$(document).ready(function () {

    // mots illisibles
    $('input[name=illegible]').click(function () {
       if  ($(this).is(':checked')) {
             $('.illegible').addClass('highlight_illegible');
             } else  {
             $('.illegible').removeClass('highlight_illegible');
             }
    });
    
    // indices WC
    $('input[name=WC]').click(function () {
     if  ($(this).is(':checked')) {
             $('.B').addClass('highlight_B');
             $('.C').addClass('highlight_C');
             } else  {
             $('.B').removeClass('highlight_B');
             $('.C').removeClass('highlight_C');
             }
   
    });
    
    // déqualifiés
    $('input[name=deq]').click(function () {
       if  ($(this).is(':checked')) {
             $('.CDq').addClass('highlight_CDq');
             $('.ABDq').addClass('highlight_ABDq');
             
             $('.deqBloc').addClass('highlight_typeBloc');
             } else  {
            $('.CDq').removeClass('highlight_CDq');
             $('.ABDq').removeClass('highlight_ABDq');
             
             $('.deqBloc').removeClass('highlight_typeBloc');
             }
        });
        
        // mots importants
       $('input[name=imp]').click(function () {
       if  ($(this).is(':checked')) {
             $('.important').addClass('highlight_important');
             } else  {
             $('.important').removeClass('highlight_important');
             }
    });
    
    // Entités nommées
    $('input[name=en]').click(function () {
       if  ($(this).is(':checked')) {
             $('.en').addClass('highlight_en');
             } else  {
             $('.en').removeClass('highlight_en');
             }
    });
    
});