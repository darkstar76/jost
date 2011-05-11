package Obj;

use strict ;
use warnings;

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
