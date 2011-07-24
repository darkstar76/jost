BEGIN {@INC=(@INC,'./lib')};

use User;

use strict;
use warnings;
use MyUtil;
use Mkdir;

sub main{
	
	my %param = MyUtil::MyOp(@ARGV);
	
	my $user = new User;
	my $dominio = new Domain;
	#Envia la la referencia al objeto y la referencia al hash de parametros
	#Debuelve usuario Seteado.
	
	MyUtil::Set($user,\%param); 
	
	
	$dominio->Set_group_name($user->Get_domain());
	
	if(!$dominio->Existe())
	{
		print $dominio->Get_error(),"\n";
		return 0;
	}
	
	
	#Control parametros
	if(!$user->Control())
	{
		print $user->Get_error(),"\n";
		return 0;
	}
	$user->Default();
	
	if($user->Existe())
	{
		print "Usuario Existe\n";
		return 0;
	}
	
	$user->add();
	
	my $dir = new Mkdir();
	$dir->Set_user($user);
	
	if(!$dir->existe_homedir())
	{
		print "No existe home para el usuario\n";
		
		if(!$dir->existe_parenthomedir())
		{
			$dir->mkparenthomedir();
		}
		$dir->mkhomedir();
	}
	
}

main();
print "Exit\n";
