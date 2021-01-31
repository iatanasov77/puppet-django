class vs_django::virtualenv(
	String $hostName	= 'django.lh'
) {
	case $operatingsystem 
    {
    	'Debian', 'Ubuntu':
        {
            fail( 'Unsupported Operating System' )
        }
        'CentOS':
        {
        /*
        	$env_path = '/var/www/${hostName}'
			$path_exists = find_file( $env_path )
			
			if ! $path_exists  {
				notify{"Path ${dir_path} exist":}
			}
		*/
        	# Create project env path
		    file { "/var/www/${hostName}":
		        ensure => 'directory',
		        owner  => 'apache',
		        group  => 'root',
		        mode   => '0777',
		    } ->
		    
			Exec { "Create virtualenv for project ${hostName}":
				command	=> "virtualenv --python=/usr/bin/python3 /var/www/${hostName}/venv"
			} ->
			
			Exec { "Install Django for project ${hostName}":
				command	=> "/var/www/${hostName}/venv/bin/pip3 install Django"
			}
        }
        default:
        {
            fail( 'Unsupported Operating System' )
        }
    }
}
