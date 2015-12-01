$(document).on('page:change', function() {
    $('#rsvp #submit').on('click', function(e) {
        console.log('submitting');
        e.preventDefault();

        $.get('/invitation?email=' + $('#rsvp .email').val())
            .done(function(invitation_id) {
                console.log('success');
                window.location.href = '/invitation/' + invitation_id;
            })
            .fail(function(err) {
                alert(err.message);
            });
    });
});