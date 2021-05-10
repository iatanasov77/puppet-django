class vs_django::dependencies
{
	case $operatingsystem 
    {
    	'Debian', 'Ubuntu':
        {
            fail( 'Unsupported Operating System' )
        }
        'CentOS':
        {
        	$dependencies = [
				'python3',
				'python3-pip',
				#'python3-mod_wsgi',
				'python3-devel',
				'mysql-devel'
			]
        	
        	each( $dependencies ) |$dependency| {
				if ! defined(Package[$dependency]) {
					package { $dependency:
						ensure	=> present,
					}
				}
			}

			package { 'virtualenv':
                provider    => 'pip3',
                require     => [Package['python3'], Package['python3-pip']]
            }
        }
        default:
        {
            fail( 'Unsupported Operating System' )
        }
    }
}
