$(document).ready(function(){
  $('[data-behavior="skill-chat"]').click(function(){
    // SendMessage(teacher, from_user, )
    App.messenger.send_message(
      $(this).data('teacher-id'),
      "Hello. I am interested in requesting a lesson."
    );
    console.log('Chat button clicked');
  });
});

