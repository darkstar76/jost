package Mkdir;

use strict ;
use warnings;
use User;
use File::Path qw(make_path remove_tree);
use MyUtil;

sub new 
{
	my $self = {};
	bless $self;
	
	$self->{user} = undef;
	
	return $self;
}

sub Set_user
{
	
	my $self = shift;
	$self->{user} = $_[0];

}

sub mkhomedir
{
	
	my $cfg = new Config::Simple();
	$cfg->read('jost.conf') or die $cfg->error();	
		 
	my $wrapper = $cfg->param("bin.wrapper");
	my $self = shift;
	
	system($wrapper." \'mkdir ".$self->{user}->Get_homedir()."\'");
	system($wrapper." \'chown ".$self->{user}->Get_user_name()." ".$self->{user}->Get_homedir()."\'");
	system($wrapper." \'chmod 750 ".$self->{user}->Get_homedir()."\'");
	system($wrapper." \'chgrp ".$self->{user}->Get_domain()." ".$self->{user}->Get_homedir()."\'");
}

sub mkparenthomedir
{
	my $cfg = new Config::Simple();
	$cfg->read('jost.conf') or die $cfg->error();	
	my $wrapper = $cfg->param("bin.wrapper");
	my $self = shift;
	
	system($wrapper." \'mkdir -p ".$self->Get_parenthomedir()."\'");
	system($wrapper." \'chown root ".$self->Get_parenthomedir()."\'");
	system($wrapper." \'chgrp ".$self->{user}->Get_domain()." ".$self->Get_parenthomedir()."\'");
	system($wrapper." \'chmod 750 ".$self->Get_parenthomedir()."\'");
}

sub existe_parenthomedir
{
	my $self = shift;
	my $ret = undef;
	
	my $dev = (stat($self->Get_parenthomedir()))[0];
	if($dev)
	{
		$ret = 1;
	}
	return $ret;
	
}

sub existe_homedir
{
	my $self = shift;
	my $ret = undef;
	
	#($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat($filename);
	my $dev = (stat($self->{user}->Get_homedir))[0];
	if($dev)
	{
		$ret = 1;
	}
	return $ret;
}

1;

sub Get_parenthomedir
{
	my $self = shift;
	
	my $user_no_dominio = substr($self->{user}->Get_user_name(),0,length($self->{user}->Get_user_name())-(length($self->{user}->Get_domain())+1));
	my $string = substr($self->{user}->Get_homedir(),0,length($self->{user}->Get_homedir())-length($user_no_dominio));
	return $string;
}
