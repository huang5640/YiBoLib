class BooksController < ApplicationController
  before_action :set_book, only: [:history, :show, :edit, :update, :destroy, :checkingIn, :checkingOut]
  before_action :set_user, only: [ :checkingIn, :checkingOut,]
  before_filter :authorize

  ##scope :distinct_book, { where("DISTINCT ISBN") }
  
  include SessionsHelper
  helper :all

  def index 
    all_books = Book.order(:title).paginate(page: params[:page], per_page: 10)
    @locations = Location.all

    if params[:searchType] == "keyword" ##search with keyword
      @books = all_books.search(params[:keyword])
    elsif params[:searchType] == "isbn" ##search with ISBN
      @books = all_books.search_by_isbn(params[:searchKey])
    elsif params[:location_id] ##filter by location
      @books = all_books.filter_by_location(params[:location_id])
    else
      @books = all_books
    end
  end

  def fetch_books
    search_hash = {}

    if params[:isbn]
      search_hash[:isbn] = params[:isbn]
    end

    if params[:title]
      search_hash[:title] = params[:title]
    end 

    if params[:author]
      search_hash[:author] = params[:author]
    end
    
    @books = Book.where(search_hash).order(:title).paginate(page: params[:page], per_page: 10)
    
    respond_to do |format|
        format.js
    end
  end

  def new
    if params[:isbn]
      @book = Book.search_douban_by_isbn(params[:isbn])
    else
      @book = Book.new
    end
  end

  def show
    /@user = @book.user /
  end

  def edit

  end

  def history
    @checkings = @book.checkings
  end

  /check in and check out /
  def checking 
      @book = Book.find_by(YiBoNum: params[:YiBoNum])
      @user = User.find_by(YiBoID: params[:YiBoID])
      if @user && @user.books.count != 0
        @borrowed_books = @user.books
      end
      if @book && @book.user
        @user = @book.user
      end
  end

  def checkingIn
    @book.update!(user_id: nil)

    flash[:notice] = "#{@user.name}已经将《#{@book.title}》归还"
    redirect_to checking_book_path
  end

  def checkingOut
    @book.update(user_id: @user.id)

    flash[:notice] = "图书已经被#{@user.name}借出"
    redirect_to checking_book_path
  end


  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to new_path, notice: "《#{@book.title}》已经被加入书库" }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: '书目信息已被更新' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
    end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: '成功删除书目' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_user
      if params[:YiBoID] 
        @user = User.find_by(YiBoID: params[:YiBoID])
      else
        @user = Book.find_by(id: params[:id]).user
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :image, :description, :ISBN, :user_id, :location_id, :YiBoNum)
    end
	 
	 def logged_in_user
	   unless logged_in?
		  flash[:danger] = "请先登入!"
		  redirect_to login_url
		end
	 end
end
