package User;

use strict ;
use warnings;
use Switch;
use MyUtil;
use Domain;


sub new 
{
	
	my $self = {};
	bless $self;
	
	$self->{id} = undef;
	$self->{uid} = undef;
	$self->{gid} = undef;
	$self->{user_name} = undef;	
	$self->{realname} = undef;
	$self->{domain} = undef;
	$self->{password} = undef;
	$self->{shell} = undef;
	$self->{status} = undef;
	$self->{field} = ['uid','gid','user_name','realname','password','shell','homedir','status'];
	$self->{control} = ['user_name','password','domain'];
	$self->{cmd} = undef;
	$self->{msg_error} = undef;
	return $self;
}

sub Set_user_name
{
	my $self = shift;  
	$self->{user_name} = $_[0];
}

sub Set_realname
{
	my $self = shift;  
	$self->{realname} = $_[0];
}

sub Set_domain
{
	my $self = shift;  
	$self->{domain} = $_[0];
	
	my $domain = new Domain();
	$domain->Set_group_name($self->{domain});
	
	$domain->Get();
	$self->_Set_gid($domain->Get_gid);
}

sub Set_password
{
	my $self = shift;  
	$self->{password} = MyUtil::sha1($_[0]);
	
}

sub _Set_gid
{
	my $self = shift;  
	$self->{gid} = $_[0];
}
sub _Set_uid
{
	my $self = shift;  
	$self->{uid} = $_[0];
}

########################################################################

sub Default
{
	my $self = shift;
	my %default;
	
	$default{'homedir'} = '/home/'.$self->{domain}.'/'.$self->{user_name};
	$default{'shell'} = '/dev/null';
	$default{'realname'} = 'RealName';
	$default{'status'} = 'A';
	$default{'cmd'} = 'list';
	
	$self->{user_name} = $self->{user_name}.'@'.$self->{domain};
	
	my $iter;

	#Control parametros por defecto
	#
	foreach $iter (keys %default)
	{
		if (!$self->{$iter})
		{
			$self->{$iter} = $default{$iter};
		}	
	}
}

#Requiere password user_name domian
#

sub Control
{
	my $self = shift;
	my $control = $self->{control};
	my $iter;
	my $ret = 1; 
	
	#Control parametros obligatorios
	foreach $iter(@$control)
	{
		if (!$self->{$iter})
		{
			$self->Set_error("En sub Control falta parametro obligatorio ".$iter);
			undef $ret;
		}	
	}
		
	return $ret;
}

sub Get_homedir
{
	my $self = shift;  
	return $self->{homedir};
}
sub Get_user_name
{
	my $self = shift;
	return $self->{user_name};
}

sub Get_domain
{
	my $self = shift;
	return $self->{domain};
}

sub Get_uid
{
	my $self = shift;  
	return $self->{uid};
}

sub Get_gid
{
	my $self = shift;  
	return $self->{gid};
}

sub add
{
# Genera el string para para insertar Sql::StrInsert
# Si se ejecuta con exito se debe devolver treu de lo contrario false

	my $self = shift;
	
	$self->_Set_uid(Sql::MaxId('uid','user'));
	Sql::insert(Sql::StrInsert($self));
}
#Checkea si usuario existe
sub Existe
{
	my $self = shift;
	my $ret = 0;
	
	if(Sql::existe("user","user_name",$self->Get_user_name))
	{
		$ret = 1;
	}
		
	return $ret;
	
}

sub Set_error 
{
	my $self = shift;
	my $msg = $_[0];
	
	$self->{msg_error} = "Error Usuario.pm: ".$msg;
}
sub Get_error 
{
	my $self = shift;
	return $self->{msg_error};
}


1;


