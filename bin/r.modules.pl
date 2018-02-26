#!/usr/bin/perl
# Recherche les modules...
# Si pas d'arguments, on prend STDIN

if ( $#ARGV==-1 ){
 @listfile = split(/ /, <>) ;
 @listfile[$listfile] =~ s/\n/ /;
}
else
{
 @listfile = (@ARGV) ;
}   

#$depend = $$."_listfile" ;
#$liste_mod = "/users/dor/armn/luc/home1/source/scripts/fich_mod" ;

#if (! open(DEST_mod,">$liste_mod")) {
#            print STDERR "Can't open output file $liste_mod \n";
#    }

foreach $file (@listfile) {
#  print "$file \n" ;
        if (! open(INPUT,"<$file") ) {
#            print STDERR "Can't open input file $file\n";
            next;}
	$file = "$file  ";
        $file =~ s/,v[\s]+/ / ; 
	while (<INPUT>) { 
# On verifie si la ligne commence par module, puis
# par un nom de module
#	  print "$_ allo \n" ;
	  $_ =~ tr/A-Z/a-z/;
#	  print "$_ \n";
	  if ($_ =~ /^[@]*[\s]*module[\s]*[<"'\s]([a-z][\w.]*)[>"'\s][\s]*/)
	    {
	      print "$file  $1\n";
              
	    }	    
	}
      }
close INPUT ;
