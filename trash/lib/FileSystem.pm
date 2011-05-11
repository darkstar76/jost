package FileSystem;

use Bool;
use strict;
use warnings;

sub new  
{
	bless $obj; 
	$obj->{uid} = undef;
	$obj->{gid} = undef;
	$obj->{name} = undef;
}

sub mkdir
{
	Bool->NoImp();
}

sub chown
{
	Bool->NoImp();
}

sub webacces
{
	Bool->NoImp();
}
