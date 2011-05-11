package Sql;

use DBI;
use warnings;
use strict;

my $obj = {};

sub new 
{
	bless $obj; 
	$obj->{server} = "localhost";
	$obj->{user} = "root";
	$obj->{passwd} = "root";
	$obj->{dbname} = "mynss";
	$obj->{conect} = undef;
	$obj->{tabla} = undef;
	$obj->{field} = undef;
	$obj->{clausala} = undef;
	$obj->{rows} = undef;
	$obj->{fields} = undef;
	$obj->{list} = undef;
	$obj->{values} = undef;
	return $obj;
	
}

sub init
{
		
	$obj->{conect} = DBI->connect("dbi:mysql:database=$obj->{dbname};hostname=$obj->{server};port=3306","$obj->{user}","$obj->{passwd}");
	
}

sub test
{
	my $sth = ${$obj->{conect}}->prepare('SELECT max(user_id) as val FROM user');
	
	$sth->execute();
	my $result = $sth->fetchrow_hashref();
	print "Value returned:", "$result->{val}\n";

}
sub select
{
	my $string = "SELECT $obj->{field} FROM $obj->{tabla} WHERE $obj->{clausura} ";
	my @row = undef;
	my @list = undef;
	my $index = 0;
	#print $string;
	
	my $sth = $obj->{conect}->prepare($string);
	$sth->execute();
	$obj->{rows} = $sth->rows;
	$obj->{fields} = $sth->{'NUM_OF_FIELDS'};
	
	
	while ( @row = $sth->fetchrow_array) 
	{	
		my @array;
		@array = @row;
		
		$list[$index] = \@array;  
		$index++;
	}
	return @list;
}

sub insert
{
	my $string = "INSERT INTO $obj->{table} ($obj->{field}) VALUES ($obj->{values})";
	my $sth = $obj->{conect}->prepare($string);
	$sth->execute();
	
}


1;
