package Vmail;
use strict ;
use warnings;
use User;
use Sql;

sub new 
{

	my $self = {};
	bless $self;
	
	$self->{uid} = undef;
	$self->{gid} = undef;
	$self->{forw_addr} = undef;
	
	$self->{status} = undef;
	
	return $self;

}

sub get_id_usr
