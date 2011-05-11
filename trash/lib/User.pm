package User;


use Sql;
use Bool;
use strict ;
use warnings;
use Domain;

my $query = new Sql;
my $_obj = {};

sub new 
{
	
	bless $_obj; 
	$_obj->{id} = undef;
	$_obj->{uid} = undef;
	$_obj->{gid} = undef;
	$_obj->{user_name} = undef;
	$_obj->{domian} = undef;
	$_obj->{homedir} = undef;
	$_obj->{field} = "user.user_name";
	$_obj->{method} = ["Add","List","Help","Show"];	
	$_obj->{cmd} = undef;
	$_obj->{txt_msg} = "";	
	$_obj->Help(); ### Hola
	$_obj->{_properti} = ["user_name","gid","homedir","password","forw_addr"];
	$_obj->{password} = undef;
	$_obj->{forw_addr} = undef;
	$_obj->{mail} = 0; #Acceso por mail;
	$_obj->{ftp} = 0; #Acceso por ftp;
	$_obj->{www} = 0; #Acceso a la carpeta www;
	$_obj->{clear_password} = undef;
	return $_obj;
	
}

sub Add
{

	#$_obj = shift;
	#Inicio controles;
	$_obj->_existe();
	my $domain = new Domain;
	
	print "Sin implmentar";
	#Fin controles;
	
	$_obj->_add();
}

sub _add
{
	
	$query->{table} = "user";
	$_obj->{gid} = 10;
	$query->init();
	$query->{field} = "uid,gid,user_name,homedir";
	$query->{values} = "$_obj->{uid},$_obj->{gid},\'$_obj->{user_name}\',\'$_obj->{homedir}\'";
	$query->insert();
	$_obj->{txt_msg} = "";
}

sub List 
{

	$_obj->{txt_msg} = "";
	
	$query->{field} = "$_obj->{field}";
	$query->{tabla} = "(user join groups)";
	$query->{clausura} = " (user.uid > 1000 and user.gid = groups.gid ";
	
	if(defined($_obj->{user_name}))
	{
		$query->{clausura} .="  and user.user_name LIKE '$_obj->{user_name}'";
	}
	
	if(defined($_obj->{domain}))
	{	
		$query->{clausura} .="  and groups.group_name LIKE '$_obj->{domain}'";
	}
	$query->{clausura} .= ')' ;
	$query->init();
	
	my @a = $query->select();
	
	my $r;
	
	foreach $r(@a)
	{
		my @x = @$r;
		$_obj->{txt_msg} .= join(":",@x);
		$_obj->{txt_msg} .= "\n";
	}
	
}

sub _existe
{	
	return Bool->true;
}

sub show
{
	$_obj->{field} = "user.user_name,$_obj->{field}";  
	$_obj->list();
}

sub Help
{
	$_obj = shift;
	$_obj->{txt_msg} = 
"
 Opciones Validas: 
	jost_usr --Cmd=Add|List|Show|Help  --User_Name=[user] --Domain=[domain] 			
	
	Add:
	List:   
	Show:  + Field=[field,...]	
";	
	
}


sub msg
{
	#$_obj = shift
	
	return 	$_obj->{txt_msg};

}

sub Set_User_Name
{
		$_obj->{user_name} = $_[1];
}

sub Set_Cmd
{
		$_obj->{cmd} = $_[1];
		
}

sub Set_Field
{
		$_obj->{field} = $_[1];
		
}
sub Get_isCmd
{
	if(!(defined($_obj->{cmd})))
	{
		$_obj->{cmd} = 'Help';
	}
	
	my $_ret = Bool->false;	
	
	my $index;
	
	for($index = 0 ;$index < scalar @{$_obj->{method}}; $index++)
	{	
		if($_obj->{cmd} eq "${$_obj->{method}}[$index]")
		{ 
			$_ret = Bool->true;
			$index = scalar @{$_obj->{method}};						
		}
	}
	return $_ret;
		
}

sub Get_Cmd
{
	return $_obj->{cmd}; 	
}

sub Set_Domain
{
	my $domain = new Domain;
	$_obj->{domain} = $_[1];
	$domain->Set_Group_Name($_obj->{domain}); 
	$_obj->{gid} = $domain->Get_Gid();	
}
1;

