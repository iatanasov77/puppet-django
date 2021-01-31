class vs_django (
    
) {
	include vs_django::dependencies
	
	/* Apache Mod WSGI 
	include vs_django::apache_mod_wsgi

	Class['vs_django::dependencies']
	-> Class['vs_django::apache_mod_wsgi']
	*/
}
