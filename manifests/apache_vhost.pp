define vs_django::apache_vhost (
    String $hostName,
    String $documentRoot,
    String $configWsgiDaemon,
    String $configWsgi,
    Boolean $withSsl			= false,
) {
	$customFragment	= "
		${configWsgiDaemon}
		${configWsgi}
	"        		
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
        
        custom_fragment => $customFragment,
    }
    
    if ( $withSsl ) {
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
	        directories     => $directories + [
	            {
	                'path'              => "${documentRoot}",
	                'allow_override'    => ['All'],
	                'Require'           => 'all granted',
	            }
	        ],
	        
	        custom_fragment => $configWsgi,
	        
	        log_level       => $logLevel,
	    }
	}
}
