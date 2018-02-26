#!/usr/bin/perl
# Si pas d'arguments, on prend STDIN

if ( $#ARGV==-1 ){
 @listfile = split(/ /, <>) ;
 @listfile[$listfile] =~ s/\n/ /;
}
else
{
 @listfile = (@ARGV);
}
open(make_cdk,">l_i_s_t_e_m_a_k_e_c_d_k_l_i_s_t_e");
open(make_file,">l_i_s_t_e_M_a_k_e_f_i_l_e_l_i_s_t_e");

foreach $file (@listfile) {
#  print "$file \n";
  if (! open(INPUT,"<$file") ) {
#            print STDERR "Can't open input file $file\n";
    next;}
	
  while (<INPUT>) {
    @ligne = split(/ /, $_);
    @ligne[0] =~ s/\n//;
    @ligne[1] =~ s/\n//;
    if(@ligne[0] =~ /(\w+\.)cdk90/){
      $deck="$1ccdk90";
      $liste{$deck}="$liste{$deck} ";
      if(@ligne[1] =~ /(\w+\.)o/){
	$liste{$deck} = "$liste{$deck}\t@ligne[1] ";
      }
      else{
	$nb{@ligne[0]}++;
	$liste{@ligne[0]} = "$liste{@ligne[0]}\t@ligne[1] ";
      }
    }
    else{
      if(@ligne[1] =~ /(\w+\.)cdk90/){
	$liste{@ligne[0]} = "$liste{@ligne[0]} ";
      }
      else{
	$liste{@ligne[0]} = "$liste{@ligne[0]}\t@ligne[1] ";
      }
      $nb{@ligne[0]}++;
    }
    if(($nb{@ligne[0]})%4 == 0){
      $liste{@ligne[0]} = "$liste{@ligne[0]}\\\n";
    }
  }
  close INPUT;
}
foreach $deck (sort keys %liste){
  @liste{$deck} =~ s/^\s*\t\s*\t/ \t/;
  @liste{$deck} =~ s/\\\n$//;
  if ($deck =~ /(\w+\.)(cdk\d*)|(\w+\.)(h)/){
    print make_cdk "$1$3a$2$4: $deck@liste{$deck}\n";
  }
  elsif($deck =~ /(\w+\.)ccdk90/){
    print make_file "$1f90: $1cdk90@liste{$deck}\n";
  }
  elsif($deck =~ /(\w+\.)[f|p](tn)?(\d*)/){
    print make_file "$1f$3: $deck@liste{$deck}\n";
  }
  elsif($deck =~ /(\w+\.)([c|f\d*|s]$)/){
    print make_file "$1o: $deck@liste{$deck}\n";
  }
  else{
    print STDOUT "r.depliste: error with deck $deck: not processed \n ";
  }
      }
     
