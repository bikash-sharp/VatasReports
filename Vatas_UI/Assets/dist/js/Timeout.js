﻿$(document).ready(function () {

    // cache a reference to the countdown element so we don't have to query the DOM for it on each ping.
    var $countdown;

    $('body').append('<div class="modal fade" id="idle-timeout-dialog" data-backdrop="static"><div class="modal-dialog modal-small"><div class="modal-content"><div class="modal-header"><h4 class="modal-title">Your session is about to expire.</h4></div><div class="modal-body"><p><i class="fa fa-warning"></i> You session will be locked in <span id="idle-timeout-counter"></span> seconds.</p><p>Do you want to continue your session?</p></div><div class="modal-footer"><button id="idle-timeout-dialog-logout" type="button" class="btn btn-default">No, Logout</button><button id="idle-timeout-dialog-keepalive" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Keep Working</button></div></div></div></div>');
    //alert('hell');
    // start the idle timer plugin
    $.idleTimeout('#idle-timeout-dialog', '.modal-content button:last', {
        idleAfter: 600, // 5 seconds
        timeout: 30, //30 seconds to timeout
        pollingInterval: 0, // 5 seconds
        keepAliveURL: $('#hfPath').val() + 'Login',
        serverResponseEquals: 'OK',
        onTimeout: function () {
            window.location = $('#hfPath').val() + 'Lock';
        },
        onIdle: function () {
            $('#idle-timeout-dialog').modal('show');
            $countdown = $('#idle-timeout-counter');

            $('#idle-timeout-dialog-keepalive').on('click', function () {
                $('#idle-timeout-dialog').modal('hide');
                window.location = window.location.href;
            });

            $('#idle-timeout-dialog-logout').on('click', function () {
                $('#idle-timeout-dialog').modal('hide');
                $.idleTimeout.options.onTimeout.call(this);
            });
        },
        onCountdown: function (counter) {
            $countdown.html(counter); // update the counter
        }
    });

});