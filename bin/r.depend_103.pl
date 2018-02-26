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
 
#$depend = $$."_listfile" ;
$depend_incl = "/users/dor/armn/luc/home1/source/scripts/listincl" ;
#$depend_mod = "/users/dor/armn/luc/home1/source/scripts/listmod" ;
#$fichmod = "/users/dor/armn/luc/home1/source/scripts/fich_mod";
#print "$depend $$\n";
#if (! open(DEST_incl,">$depend_incl")) {
#            print STDERR "Can't open output file $depend_incl \n";
#    }
#if (! open(DEST_mod,">$depend_mod")) {
#            print STDERR "Can't open output file $depend_mod \n";
#    }
if (! open(FICHMOD,"<$ENV{fIcHiEr_MoDuLe}")) {
            print STDERR "Can't open input file $ENV{fIcHiEr_MoDuLe} \n";
    }

%modules = () ;
 
while(<FICHMOD>) {
#  print "$_ ligne \n " ;
  if($_ =~ /^[\s]*([\w.,]+)[\s]+([\w]+)/)
     {
      $modules{$2} = $1 ;
#      print STDERR "$2  $1 icI \n ";
     }
}
close FICHMOD ;
foreach $file (@listfile) {
        if (! open(INPUT,"<$file") ) {
            print STDERR "Can't open input file $file.\n";
            next;}
	$file = "$file " ;
	$file =~ s/,v[\s]+/ / ;
	$file =~ s/[\s]+/ / ;
#  print "$file coucou \n" ;
	while (<INPUT>) { 
# On verifie si la ligne commence par module, puis
# par un nom de module
#	  print "$_ allo \n" ;
	  $_ =~ tr/A-Z/a-z/;
	  if ($_ =~ /^[@]*[\s]*include[\s]*[<"'\s]([a-z][\w.]*)[>"'\s][\s]*/)
	    {
	      print "$file$1\n";
#	      print DEST_incl " $file $1 \n";
              
	    }
	  if ($_ =~ /^[@]*[\s]*#[\s]*include[\s]*[<'"\s]([a-z][\w.]*)[>"'\s][\s]*/)
	    {
              if($1 !~ /(ftn|ftn90|f|f90|c)$/)
              {
	        print "$file$1\n";
#	        print DEST_incl " $file $1\n";
              }
	    }
	  if ($_ =~ /^[@]*[\s]*\buse[\s]+([a-z][\w]*)/)
	    {
              $nom_module=$1;
              print DEST_incl "$file $nom_module \n";
              if( $modules{$nom_module} =~ /([a-z][\w]*)/)
	      {
                $nom_fich_mod=$modules{$nom_module};
                print  "$file$nom_fich_mod\n";
                $nom_fich_mod =~ s/.cdk90/.o/ ;
                print  "$file$nom_fich_mod\n";
              }
              else
              {
                print STDERR "WARNING: Can't find module $nom_module \n";
              }
#	      print STDERR  " $file$nom_fich_mod\n";
#	      print " $file $modules{$1} $1 \n";
	    }
	    
	}
      }
close INPUT ;
