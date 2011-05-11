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
	
	$self->{grop_id} = undef;
	$self->{group_name} = undef;
	$self->{status} = undef;
	$self->{group_password} = undef;
	$self->{gid} = undef;
	
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

sub Get
{
	my $self = shift;
	my $sql = new Sql();
	 
	my $connect = $sql->Get_connect();
	
	my $str = "SELECT group_id,gid FROM groups where group_name = '". $self->{group_name} ."'";
	
	my $sth = $connect->prepare($str);
	$sth->execute();
	my $row = $sth->fetchrow_hashref();	
	$self->{grop_id} = $row->{group_id};
	$self->{gid} = $row->{gid};
	$sth->finish;
	#falta cerrar laconection;
}

########################################################################
sub ToString
{
	my $self = shift;  
	return MyUtil::ToString($self);

}

1;
