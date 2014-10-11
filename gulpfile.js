var gulp = require('gulp');
var apn = require('apn');
var q = require('q');

gulp.task('apns', function() {
	console.log('推送--开始');
	push();
});

var myDevice = new apn.Device("B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F");

var options = {};
var apnConnection = new apn.Connection(options);

/**
 *	推送
 */
function push() {
	var note = new apn.Notification();
	
	note.expiry = Math.floor(Date.now() / 1000);
	note.badge = 3;
	note.sound = "ping.aiff";
	note.alert = "\uD83D\uDCE7 \u2709 You have a new message";
	note.payload = {'messageFrom': 'Caroline'};

	apnConnection.pushNotification(note, myDevice);
}