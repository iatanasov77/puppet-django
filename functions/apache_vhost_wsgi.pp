function vs_django::apache_vhost_wsgi(
	$host,
	$documentRoot
) {
    "
    WSGIScriptAlias / ${documentRoot}/wsgi.py process-group=${host}
    WSGIProcessGroup ${host}
    "
}