package Bool;

use strict ;
use warnings;

sub true{
	return 1;
}

sub false{
	return 0;
}

sub is_cmd 
{
	my $obj = $_[1];	
	
	if(!(defined($obj->{cmd})))
	{
		$obj->{cmd} = 'help';
	}
			
		
	my $_ret = Bool->false;	
	my $index;
	
	for($index = 0 ;$index < scalar @{$obj->{accion}}; $index++)
	{	
		if($obj->{cmd} eq "${$obj->{accion}}[$index]")
		{ 
			$_ret = Bool->true;
			$index = scalar @{$obj->{accion}};						
		}
	}
	
	return $_ret;	
}

sub NoImp
{
	print "No implementada\n";
};


use Digest::SHA;

sub sha1
{
 
 my $md5 = Digest::SHA->new;
 
 $md5->add("tortuga");
 #$ctx->addfile(*FILE);

 
 my $digest = $md5->hexdigest();
 return $digest;
 
}

use Crypt::CBC;

sub plain2crypt
{

	my $my_secret_key = 'Blowfish';
	my $cipher = Crypt::CBC->new( 
								-key    => $my_secret_key,
								-cipher => 'Blowfish',
								-header => 'none',
								-iv		=> '09101976'
                            );

	my $ciphertext = $cipher->encrypt_hex($_[1]);
	return $ciphertext;
}
sub crypt2plain
{
	my $hexas = $_[1];

	my $my_secret_key = 'Blowfish';
	my $cipher = Crypt::CBC->new( 
								-key    => $my_secret_key,
								-cipher => 'Blowfish',
								-header => 'none',
								-iv		=> '09101976'
                            );
	my $plaintext = $cipher->decrypt_hex($hexas);
	
	return $plaintext;
}

1
