use warnings;
use strict;

{
  package Data;

  sub remove_outerspace {
   my $string = shift;
   if (defined $string) {
     $string =~ s/^\s+//;
     $string =~ s/\s+$//;
   }
   return $string;
  }

}

{
  package Env;
  use File::HomeDir;
  
  sub find_home {
    my $home = File::HomeDir->my_home;
    if ( -d $home ) {
      return $home
    } else {
      warn "home-dir does not exist!?\n";
    }
  }
}

{
package Process;
	
	sub confirm {
		my $eingabe='';
		until ( $eingabe eq 'y' ) {
			print "Continue with 'y'..\n>";
			$eingabe = <STDIN>;
			chomp $eingabe;
		}
	}
	
	sub confirmJN {
		my $eingabe='';
		my @exp_keys = ('j','n');
		until (grep {$eingabe eq $_} @exp_keys) {
			print "(j)a oder (n)ein... \n>";
			$eingabe = <STDIN>;
			chomp $eingabe;
		}
		if ($eingabe eq 'j') {
			return 1;
		} else {
			return 0;
		}
	}
	
	sub enter_str {
		my $eingabe;
		print "\n>";
		$eingabe = <STDIN>;
		chomp $eingabe;
		return $eingabe;
	}
    
	sub confirm_numcount {
		my $max = shift;
		my $eingabe='';
		my @exp_keys = (1..$max);
		until (grep {$eingabe eq $_} @exp_keys) {
			print (join ",", @exp_keys);
			print "\n>";
			$eingabe = <STDIN>;
			chomp $eingabe;
		}
		return $eingabe+0;
	}
}
1;
