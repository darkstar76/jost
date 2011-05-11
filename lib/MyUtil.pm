package MyUtil;

use strict;
use warnings;
use Digest::SHA;

sub MyOp
{
	
	my $_Debug = 0;
	print ("Debug MyUtil::MyOp\n") if $_Debug;
	my $argv = undef;
	my $_ITER = 0;
	my %Set;
	
	foreach $argv (@_)
	{
		my @param = split (/=/, $argv); 
		
		my $set =  'Set_'.substr($param[0],2);
		$Set{"$set"} = $param[1];
		
	}
	
	if ($_Debug) 
	{ 
		my @keys = keys %Set;
		my @values = values %Set;
		
		while (@keys) 
		{
			warn pop(@keys), '=', pop(@values), "\n";
		}
	}
	
	return %Set;
}

sub ToString
{
	my $self = shift;  
	my $string ="";
	my @keys = keys %$self;
	my @values = values %$self;
	my $key;
	my $index = 0;
	
	foreach $key(@keys) 
		{
			
			if ($values[$index])
			{
				$string .= sprintf("%s=%s|",$key,$values[$index]);
			}
			$index++;
		}
	 
	$string = substr ($string,0,(length $string)-1);
}

sub sha1
{
 
 my $sha1 = Digest::SHA->new;
 
 $sha1->add($_[0]);
 
 my $digest = $sha1->hexdigest();
 
 return $digest;
 
}

sub Set
{
	my $obj = shift;
	my $hash = shift;
	
	my @keys = keys %$hash;
	my @values = values %$hash;
	
	
	my $setfoo;
	my $index = 0;
	
	foreach $setfoo (@keys) 
		{
			if ($values[$index])
			{
				$obj->$setfoo($values[$index++]);
				
			}
			
		}
}

1;

