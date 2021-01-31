define vs_django::apache_vhost (
    String $hostName,
    String $documentRoot,
	String $projectPath,
	String $venvPath,
    String $user 		= 'apache',
	String $group		= 'apache',
	Integer $processes	= 1,
	Integer $threads	= 2,
    Boolean $withSsl	= false,
) {
	apache::vhost { "${hostName}":
		port            => '80',
		serveradmin     => "webmaster@${hostName}",
        docroot         => "${documentRoot}", 
        override        => 'all',
        log_level       => 'debug',
        
        serveraliases   => [
            "www.${hostName}",
        ],
        
        directories     => [
            {
                path            => "${documentRoot}",
                allow_override  => ['All'],
                'Require'       => 'all granted',
            }
        ],
		
		wsgi_daemon_process         => $hostName,
		wsgi_daemon_process_options => {
			python-home	=> $venvPath,
			python-path	=> $projectPath,
			user		=> $user,
			group		=> $group,
			processes	=> "${processes}",
			threads		=> "${threads}",
		},
		
		wsgi_process_group          => $hostName,
		wsgi_script_aliases         => { '/' => "${documentRoot}/wsgi.py" },
	}
	
	if $withSsl {
	
		apache::vhost { "${hostName}_ssl":
			servername 		=> "${hostName}",
	        serveraliases   => [
	            "www.${hostName}",
	        ],
	        
	        port            => '443',
	        ssl				=> true,
	        ssl_cert 		=> '/etc/pki/tls/certs/apache-selfsigned.crt',
  			ssl_key  		=> '/etc/pki/tls/private/apache-selfsigned.key',
	        
	        serveradmin     => "webmaster@${hostName}",
	        docroot         => "${documentRoot}", 
	        override        => 'all',
	        
	        aliases         => $aliases,
	        directories     => [
	            {
	                'path'              => "${documentRoot}",
	                'allow_override'    => ['All'],
	                'Require'           => 'all granted',
	            }
	        ],
	        
	        log_level       => 'debug',
	        
	        wsgi_process_group	=> $hostName,
			wsgi_script_aliases	=> { '/' => "${documentRoot}/wsgi.py" },
		}
	}
	
}
