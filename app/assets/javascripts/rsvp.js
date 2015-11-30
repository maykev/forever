$(function() {
    $('#rsvp button').on('click', function(e) {
        console.log('searching for rsvp');

        $.get('/invitation?email=' + $('#rsvp .email').val())
            .done(function(invitation_id) {
                window.location.href = '/invitation/' + invitation_id;
            })
            .fail(function(err) {
                alert(err.message);
            });
    });
});