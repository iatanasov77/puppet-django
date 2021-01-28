function vs_django::apache_vhost_wsgi_daemon(
	$venvPath,
	$projectPath,
	$user 		= 'apache',
	$group		= 'apache',
	$threads	= 2
) {
    "WSGIDaemonProcess django.lh python-home=${venvPath} python-path=${projectPath} user=${user} group=${group} threads=${threads}"
}
