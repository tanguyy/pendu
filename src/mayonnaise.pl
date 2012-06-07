use strict;
use warnings;

my @mot;
my @mot_mystere; #contiendra les lettres du mots sous la forme de *
my @pendu = ("\n   ,==========U===","\n   ||","  /","      |","\n   || /       |","\n   ||","/","        O","\n   ||        /|\\","\n   ||","        / \\","\n   ||             ","\n   ||             ",
             "\n  /||              ","\n============");

sub jeu {
    my ($lettre,$i) = (shift,0);
	
    unless(grep {$_ eq $lettre} @mot) # sauf si on trouve la lettre dans le mot
    {
        print "FAUX !\n"; 
        return 0;
    }
	
    map { $_ = $mot[$i-1] if($mot[$i++] eq $lettre) } @mot_mystere; 
    print join('', @mot_mystere) . "\n";
}

sub tirer_mot {
    # Treees trees long... :-(
    open(FIC, "<dictionnaire.txt");
    my @t = <FIC>; # absorbe TOUS les mots du dictionnaire
    chomp(my $mot_mystere = $t[int(rand(scalar @t))]);

    return $mot_mystere;
}

my ($mot,$coups) = (tirer_mot(),0);
my $lettre;

@mot = split(//,uc($mot)); # on décompose le mot dans un tableau de lettres
@mot_mystere = split(//, "*" x scalar(@mot));

print do {local $" = ''; "Mot généré : @mot_mystere"};

while($coups < 15 && grep {$_ eq "*"} @mot_mystere)
{
    print "\nLettre ? ";
    chomp($lettre = <>);
    # on affiche le pendu si jeu() retourne 0, donc si la lettre n'est pas dans le mot.
    print join('', @pendu[0..$coups++]) . "\n\n\n" if(!jeu(uc($lettre))); 
}

print "\nJe suis déjà mort ! Dommage !" if $coups >= 15;
print "\nBravo ! vous avez gagné !" unless (grep {$_ eq "*"} @mot_mystere);