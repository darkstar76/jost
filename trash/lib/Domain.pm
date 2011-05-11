package Domain;

use Sql;
use Bool;

use strict ;
use warnings;

my $query = new Sql;
my $obj = {};	 
sub new 
{
	
	bless $obj; 
	$obj->{gid} = -1;
	$obj->{group_name} = undef;
	
	$obj->{accion} = ['add','del','help','list'];	
	$obj->{txt_msg} = "";	
	$obj->help();
	$obj->{cmd} = undef;
	return $obj;
	
}

sub Add
{

	#$obj = shift;
	#Inicio controles;	
	#$obj->_existe();
	print "Sin implementar";
	#Fin controles;
	#$obj->_add();
}

sub _add
{
	#$obj = shift;
	
	$query->init();	
	$query->test();
	$obj->{txt_msg} = "--add $obj->{gid} $obj->{name}\n";
}

sub Del
{
	print "Sin implementar"
	#$obj = shift;
	#$obj->{txt_msg} = "--del $obj->{gid} $obj->{name}\n";
}

sub _existe
{
	$obj = shift;	
	$obj->{txt_msg} = "Existe o No $obj->{gid} $obj->{name}\n";
	
	return 'True';
}

sub help
{
	$obj = shift;
	$obj->{txt_msg} = 
"
 Opciones Validas: 
	jost_dom --add [domain]
	jost_dom --del [domain]
	jost_dom --list [domain]
	jost_dom --help [domain]\n";	
	
}

sub List 
{
	$query->{campo} = "*";
	
}
sub Msg
{
	#$obj = shift;
	return 	$obj->{txt_msg};
	
}

sub Get_Gid
{
	$query->{tabla} = "groups";
	$query->{clausura} = " group_id > 1000";
	$query->{field} = "group_name";
	
	if(defined($obj->{group_name}))
	{
		$query->{clausura} .="  and group_name LIKE \'$obj->{group_name}\'";
	}
	
	$query->init();
	my @a = $query->select();
	print @a;
}

sub Set_Group_Name
{
	$obj->{group_name} = $_[1];		
}
1;
