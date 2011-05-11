package JostFile;

use strict ;
use warnings;
use User;

sub new 
{

	my $self = {};
	bless $self;
	
	$self->{uid} = undef;
	$self->{gid} = undef;
	return $self;

}

sub mkhomedir
{
	my $self = shift;
	my $user = shift;
	my $dir_  = $user->Get_homedir();
	mkdir  '.'.$dir_;
}

1;
