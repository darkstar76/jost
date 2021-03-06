package Sql;

use DBI;
use warnings;
use strict;
use Scalar::Util qw(looks_like_number);

use Config::Simple;
my $static_obj = {};

sub new 
{
	
	#my $obj = {};
	
	if (!$static_obj->{connect})
	{
		my $cfg = new Config::Simple();
		$cfg->read('jost.conf') or die $cfg->error();	
		 
		bless $static_obj;
		$static_obj->{server} = $cfg->param("sql.server");
		$static_obj->{user} = $cfg->param("sql.user");
		$static_obj->{passwd} = $cfg->param("sql.password");
		$static_obj->{dbname} = $cfg->param("sql.dbname");
		$static_obj->{connect} = undef;
		$static_obj->{tabla} = undef;
		$static_obj->{field} = undef;
		$static_obj->{clausala} = undef;
		$static_obj->{rows} = undef;
		$static_obj->{fields} = undef;
		$static_obj->{list} = undef;
		$static_obj->{values} = undef;
	}

	return $static_obj;	
}

sub Get_connect
{
	
	if(!$static_obj->{connect})
	{
		 
		 
		#$static_obj->{connect} = DBI->connect("dbi:mysql:database=$static_obj->{dbname};hostname=$static_obj->{server};port=3306","$static_obj->{user}","$static_obj->{passwd}");
		$static_obj->{connect} = DBI->connect("dbi:mysql:database=$static_obj->{dbname};hostname=$static_obj->{server};port=3306","$static_obj->{user}");
	}
	
	return $static_obj->{connect}; 	
}


sub MaxId
{
	my $str = "SELECT max( " .$_[0].") as UID FROM ".$_[1];
	
	my $self = shift;
	
	my $sql = new Sql(); 
	my $connect = $sql->Get_connect();
	my $sth = $connect->prepare($str);
	$sth->execute();
	my $row = $sth->fetchrow_hashref();	
	return ++$row->{UID};
	
}

sub StrInsert
{
	my $obj = shift;
	my $field = $obj->{field};
	
	my @keys = @$field;
	
	my $key;
	my $index = 0;
	
	my $_key;
	my $_value;
	
	
	foreach $key(@keys) 
	{
			
			if ($obj->{$key})
			{	
				$_key .= $key.",";
				 
				if( !looks_like_number($obj->{$key}))
				{
					$_value .= "'".$obj->{$key}."',";
				}
				else
				{
					$_value .= $obj->{$key}.",";
				}
			}
			$index++;
	}
	 
	$_key = substr ($_key,0,(length $_key)-1);	
	$_value = substr ($_value,0,(length $_value)-1);	
	return "insert into user (".$_key.") value (".$_value.")";
	
}

sub insert
{
		my $str = $_[0];
		my $sql = new Sql(); 
		my $connect = $sql->Get_connect();
		my $sth = $connect->prepare($str);
		$sth->execute();
}
# Checkea si un registro en una tabla exite recibe parametro tabla y campo y valor
sub existe
{
	my $tabla = $_[0];
	my $campo = $_[1];
	my $val = $_[2];
	my $str = "select ".$campo." as campo FROM ".$tabla." where ".$campo." like "."'".$val."'";
	my $ret;
	
	my $self = shift;
	
	my $sql = new Sql(); 
	my $connect = $sql->Get_connect();
	my $sth = $connect->prepare($str);
	$sth->execute();
	my $row = $sth->fetchrow_hashref();
	
	if($row->{'campo'})
	{
		$ret = 1;
	}
	
	return $ret;
	
}

sub select
{
	my $tabla = $_[0];
	my $campos = $_[1];
	my $clausura = $_[2];
	my $val= $_[3];
	
	my $sql = new Sql(); 
	my $connect = $sql->Get_connect();
	my $str = "select ".$campos."  from ".$tabla." where ".$clausura." = "."'".$val."'";
	my $sth = $connect->prepare($str);
	$sth->execute();
	return $sth->fetchrow_hashref();
}

1;
