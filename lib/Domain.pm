package Domain;
use strict ;
use warnings;
use MyUtil;
use Sql;

sub new 
{
# group_id, group_name, status, group_password, gid
	
	my $self = {};
	bless $self;
	
	$self->{group_id} = undef;
	$self->{group_name} = undef;
	$self->{status} = undef;
	$self->{group_password} = undef;
	$self->{gid} = undef;
	$self->{homedir} = undef;
	
	$self->{msg_error}=undef;
	return $self;
}

sub Set_group_name
{
	my $self = shift;  
	$self->{group_name} = $_[0];
}

sub Get_group_name
{
	my $self = shift;  
	return $self->{group_name};
}

sub _Set_gid
{
	my $self = shift;  
	$self->{gid} = $_[0];
}

sub Get_gid
{
	my $self = shift;  
	return $self->{gid};
}
sub Get_grop_id
{
	my $self = shift;  
	return $self->{group};
}

sub Get_homedir
{
	my $self = shift;  
	$self->{homedir} = "/home/".$self->{group_name};
	
	return $self->{homedir};
}

sub Get
{
	my $ret;
	my $self = shift;
	
	my $row = Sql::select('groups','group_id,gid','group_name',$self->{group_name});
	
	if ($row)
	{
		$self->{group_id} = $row->{group_id};
		$self->{gid} = $row->{gid};
		$ret = 1;
	}
	return $ret;
	
}

sub Existe 
{
		my $val = $_[0];
		my $self = shift;
		my $ret = Sql::existe('groups','group_name',$self->{group_name});
		
		if(!$ret)
		{
			$self->Set_error("Dominio no exsiste");
		}
		return $ret;	
}

########################################################################


sub Set_error 
{
	my $self = shift;
	my $msg = $_[0];
	
	$self->{msg_error} = "Error Dominio.pm: ".$msg;
}
sub Get_error 
{
	my $self = shift;
	return $self->{msg_error};
}

sub existe_homedir
{
	my $ret;
	

	return $ret;
}

sub ToString
{
	my $self = shift;  
	return MyUtil::ToString($self);

}

1;
