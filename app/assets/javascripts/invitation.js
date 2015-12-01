$(document).on('page:change', function() {
    $('#invitation-submit').on('click', function(e) {
        e.preventDefault();

        $.ajax({
            url: '/invitation/' + $('#invitation-id').val(),
            type: 'put',
            data: $("#invitation-form").serialize()
        })
        .done(function() {
            window.location.href = '/invitation/thanks/' + $('#invitation-id').val();
        })
        .fail(function(err) {
            alert(err);
        });
    });
})