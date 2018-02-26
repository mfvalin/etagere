#!/usr/bin/perl


# Si pas d'arguments, on prend STDIN

if ( $#ARGV==-1 ){
 @listfile = split(/ /, <>) ;
 $listfile[$#listfile] =~ s/\n/ /;
}
else
{
 @listfile = (@ARGV) ;
 $listfile[$#listfile] =~ s/\n/ /;
}   

%modules = () ;

foreach $file (@listfile) {
        if (! open(INPUT,"<$file") ) {
            print STDERR "Can't open input file $file.\n";
            next;}
	while (<INPUT>) { 
# si la ligne contient :
	  if ($_ =~ /:/ )
	    {
	      $dans_eff=0;
	    }
	  if ($_ =~ /(\w+\.\w+):\s*\1\s/)
	    {
	      $dans_eff=1;
#	      print STDERR "a $1 \n";
#	      print "$file$1\n";
##	      print DEST_incl " $file $1 \n";
              
	    }
	  elsif ( $dans_eff == 0)
	    {
	      print STDOUT $_
	    }
#	  if ($_ =~ /^[@]*[\s]*#[\s]*include[\s]*[<'"\s]([a-z][\w.]*)[>"'\s][\s]*/)
#	    {
#              if($1 !~ /(ftn|ftn90|f|f90|c)$/)
#              {
#	        print "$file$1\n";
##	        print DEST_incl " $file $1\n";
#              }
#	    }
#	  if ($_ =~ /^[@]*[\s]*\buse[\s]+([a-z][\w]*)/)
#	    {
#              $nom_module=$1;
#              print DEST_incl "$file $nom_module \n";
#              if( $modules{$nom_module} =~ /([a-z][\w]*)/)
#	      {
#                $nom_fich_mod=$modules{$nom_module};
#                print  "$file$nom_fich_mod\n";
#                $nom_fich_mod =~ s/.cdk90/.o/ ;
#                print  "$file$nom_fich_mod\n";
#              }
#              else
#              {
#                print STDERR "WARNING: Can't find module $nom_module \n";
#              }
##	      print STDERR  " $file$nom_fich_mod\n";
##	      print " $file $modules{$1} $1 \n";
#	    }
	    
	}
      }
close INPUT ;
