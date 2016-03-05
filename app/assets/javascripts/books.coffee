# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".picture").click ->
    alert "This is a picture"

  $(".dropdown-menu").on 'click', 'li', ->
  	type = $(this).data('type')
  	text = $(this).find('a').text()

  	button = $(this).parent().siblings("button")
  	button.data("type", type)
  	button.find(".text").text(text)
  	$(this).closest("form").find(".search-field input").val("")

  $("#search-button").on 'click' , ->
  	type = $(this).closest("form").find(".btn-group button").data("type")
  	value = $(this).closest("form").find(".search-field input").val()
  	hash = {}
  	hash[type] = value

  	$.ajax
  		url: "fetch_books"
  		dateType: "html"
  		data: hash
  		success: -> 
  			console.log "successfully made a ajax call on fetch_books"

# $(document).ready( function() {
# 	$('.nav').on('click', 'li', function() {
# 		//$(this).hide();
# 	});

# $(".dropdown-menu").on('click', 'li', function() {
# 		var content = $(this).data("type");
# 		var text = $(this).find('a').text() + " ▼";
#  		var button = $(this).parent().parent().find('button');
# 		console.log(text);
# 		button.data("type", content);
# 		button.text(text);

# 	});
# });