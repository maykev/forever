// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
    $(".navbar a").click(function(e) {
        e.preventDefault();

        $('html, body').animate({
            scrollTop: $("." + e.target.id).offset().top
        }, 1000);
    });

    $(".heart").mouseover(function(e) {
        e.preventDefault();

        $('.highlight').hide();
        $("." + e.target.id).show('slow');
    });

    $('.search').click(function(e) {
        e.preventDefault();

        $('#invitation-name').show();
        $('#invitation-content').show();
        $('#invitation-select').show();
        $('#invitees').show();
        $('#invitees').empty();
        $('#invitation-submit').show();
        $('#already-responded').hide();
        $('#not-found').hide();
        $('#contact-us').hide();

        $.get('/invitation?email=' + $('.email').val())
        .done(function(data, textStatus, xhr) {
            if (xhr.status === 202) {
                $('#already-responded').show();
                hideInvitation();
            } else {
                $('#plus-one-going').prop('checked', false);
                $('#plus-one-name').val('');

                $('#invitation-name').text('To ' + data.name);
                $('#invitation-id').val(data.id);

                data.invitees.forEach(function(invitee) {
                    var $inviteeDiv = $('<div class="checkbox">');
                    var $inviteeIdInput = $("<input type='hidden' value='" + invitee.id + "' name='invitees[][id]'></input>");
                    var $inviteeAcceptedInput = $("<input id='checkbox-" + invitee.id + "' type='checkbox' value='true' name='invitees[][accepted]'></input>");
                    var $inviteeLabel = $("<label for='checkbox-" + invitee.id + "'>");
                    $inviteeLabel.text(invitee.name);

                    $inviteeDiv.append($inviteeIdInput);
                    $inviteeDiv.append($inviteeAcceptedInput);
                    $inviteeDiv.append($inviteeLabel);
                    $('#invitees').append($inviteeDiv);
                });

                if (data.plus_one) {
                    $("#plus-one").show();
                } else {
                    $("#plus-one").hide();
                }
            }
        })
        .fail(function(error) {
            $('#not-found-email').text($('.email').val());
            $('#not-found').show();
            $('#contact-us').show();
            hideInvitation();
        });
    });

    $('#plus-one-going').on('click', function(e) {
        $('#plus-one-name').prop('disabled', false);
        $('#plus-one-name').focus();
    });

    $('#invitation-submit').on('click', function(e) {
        e.preventDefault();

        if ($('#plus-one-going:checked').length > 0 && $('#plus-one-name').val() === '') {
            $('#plus-one').addClass('has-error');
            $('.plus-one-name-required').show();
            $('#plus-one-name').focus();
            return;
        } else {
            $('#plus-one').removeClass('has-error');
            $('.plus-one-name-required').hide();
        }

        $.ajax({
            url: '/invitation/' + $('#invitation-id').val(),
            type: 'put',
            data: $("#invitation-form").serialize()
        })
        .done(function() {
            $("#rsvp-modal").modal("hide");
            $("#rsvp-success-modal").modal("show");
        })
        .fail(function(error) {
            $("#rsvp-modal").modal("hide");
            $("#rsvp-failure-modal").modal("show");
        });
    });

    function hideInvitation() {
        $('#invitation-name').hide();
        $('#invitation-content').hide();
        $('#invitation-select').hide();
        $('#invitees').hide();
        $('#plus-one').hide();
        $('#invitation-submit').hide();
    }
});
