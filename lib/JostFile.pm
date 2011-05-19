package JostFile;

use strict ;
use warnings;
use User;
use File::Path qw(make_path remove_tree);


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
	
	make_path '.'.$dir_ , {owner=>'dark', group=>'nogroup'};
}

1;
