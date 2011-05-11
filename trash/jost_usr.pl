BEGIN {@INC=(@INC,'./lib')};

use User;
use Bool;
use strict;
use warnings;
use MyUtil;

sub main{
	#print @ARGV;
	
	my $user = new User; 
	my $argv;
	
	foreach $argv(@ARGV)
	{
		my @param = split (/=/, $argv); 
		my $Set =  'Set_'.substr($param[0],2);
		$user->$Set($param[1]);
	
	}
	
	
	if ($user->Get_isCmd() == Bool->true)
	{
		my $cmd = $user->Get_Cmd(); 
		$user->$cmd();
		print $user->msg();
	}
	else
	{
		print $user->msg();
	}

}

main();


#my $tx = Bool->plain2crypt ("marcelomarcelito");

#print "$tx\n";

#print Bool->crypt2plain($tx),"\n";

