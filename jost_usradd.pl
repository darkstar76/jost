BEGIN {@INC=(@INC,'./lib')};

use User;

use strict;
use warnings;
use MyUtil;
use JostFile;

sub main{
	
	my %param = MyUtil::MyOp(@ARGV);
	
	my $user = new User;
	#Envia la la referencia al objeto y la referencia al hash de parametros
	#Debuelve usuario Seteado.
	
	MyUtil::Set($user,\%param); 
	
	
	
	if ($user->Control())
	{
		$user->Default();
		my $cmd = $user->Get_cmd();
		$user->$cmd();
		my $dir = new JostFile();
		$dir->mkhomedir($user);
		
		print "\n";
	}				
	
	exit;
	
}

main();


