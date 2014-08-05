//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('ready page:load', function(){
  
       // $.ajaxSetup({
       //        headers: {
       //        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
       //                }
       //                }); 

      //   $(".article_source_dropdown").hide();
      //   $("#reddit_button").click(function(){
      //     if ($("#reddit_articles").is(':hidden')) {
      //       $("#reddit_articles").animate({height:"show"});
      //       $("#arrow").css({WebkitTransform: 'rotate(' + 90 + 'deg)'})}
      //     else {
      //       $("#reddit_articles").animate({height:"hide"});
      //       $("#arrow").css({WebkitTransform: 'rotate(' + 0 + 'deg)'})}
      //   });
        
      //   $("#mashable_button").click(function(){
      //     if ($("#mashable_articles").is(':hidden')) {
      //       $("#mashable_articles").animate({height:"show"})}
      //     else {
      //       $("#mashable_articles").animate({height:"hide"})}
      //   });
     
      // $("#remove").on("click", function(){
      //   $("#showup").remove();
      //   $("#inbox").show();

  
  // $(".dropdownTitle").is(":hidden");
  
  // This slides the sidebar menus up and down
  $(".dropdownTitle").click(function(){
    if ( $(this).next("ul").is(":hidden") ) {
      $(this).next("ul").slideDown();
    } else {
      $(this).next("ul").slideUp();
    }
  });

  // adds active state to sidebar folders
  $(".dropdownItem a").each(function() {   
    if (this.href == window.location.href) {
        $(this).addClass("dropdownItemActive a");
    }
  });

  // checks all the checkboxes
  $("#selectAll").click(function(){
    $(".myCheckbox").prop("checked",$("#selectAll").prop("checked"))
  })

  // lets user return to inbox view when logo is clicked
  $("#remove2").on("click", function(){
        $("#showup1").remove();
        $("#inbox").show();
  });

  // This slides the forms on the user edit page up and down
  $("i").click(function(){
   // alert("hi")
    if ( $(this).next(".editForm").is(":hidden") ) {
      $(this).next(".editForm").slideDown();
    } else {
      $(this).next(".editForm").slideUp();
    }
  });

function clickable() {
    var stlg = parseInt($(".articles:last")[0].id.split("_")[1]) + 1;
    var myArray = [];
    if(window.location.pathname.split("/").length < 4 || window.location.pathname.split("/")[3] == ""){
      var provider = "huffP"
    }else{
      var provider = window.location.pathname.split("/")[3]
    };
    if(stlg>0){
    for(i=0; i<stlg; i++){
      myArray.push("#art_"+i)
    };
    for(j=0; j<myArray.length; j++){
      
      $(myArray[j]).on("click", function(){
        $("#showup").remove();
        $("#outlook_email_body").append("<div id='loader'><img src='/images/ajax-loader.gif' ><h4> Loading, please be patient </h4> </div>");
        $.ajax({
                type: 'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                url: '/machlookshow',
                data: {article_select: $(this)[0].id.split("_")[1], prov: provider},
              });

        
      });
    }}};

    
    function Mclickable() {
    var stlg = parseInt($(".articles:last")[0].id.split("_")[1]) + 1;
    var myArray = [];
    if(window.location.pathname.split("/").length < 4 || window.location.pathname.split("/")[3] == ""){
      var provider = "huffP"
    }else{
      var provider = window.location.pathname.split("/")[3]
    };
    if(stlg>0){
    for(i=0; i<stlg; i++){
      myArray.push("#art_"+i)
    };
    for(j=0; j<myArray.length; j++){
      
      $(myArray[j]).on("click", function(){
        $("#inbox").hide(); 
        $("#articleBody").append("<div id='loader'><img src='/images/ajax-loader.gif' ><h4> Loading, please be patient </h4> </div>");
        $.ajax({
                type: 'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                url: '/machshow',
                data: {article_select: $(this)[0].id.split("_")[1], prov: provider},
              });

        
      });
    }};
    };


    if(window.location.pathname.split("/")[2] == "machlook" || window.location.pathname.split("/")[2] == "index"){

    clickable();
    }else{
     
    Mclickable();
    };



 });


