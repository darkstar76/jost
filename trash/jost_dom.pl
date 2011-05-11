BEGIN {@INC=(@INC,'./lib')};

use Domain;
use Bool;
use strict;
use warnings;

sub main{
	#print @ARGV;
	
	my $domain = new Domain; 
	
	if (defined($ARGV[0]))	
	{ 
		$domain->{cmd} = substr $ARGV[0], 2;
		
	};
	
	if (defined($ARGV[1]))
	{
		$domain->{name} = $ARGV[1];
	}
	

	if (Bool->is_cmd($domain) == Bool->true)
	{
		my $cmd = $domain->{cmd};
		$domain->$cmd();
		print $domain->msg();
	}
	else
	{
		print $domain->msg();
	}

}

main();
