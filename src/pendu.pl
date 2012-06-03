use strict;
use warnings;

my @mot;
my @mot_mystere; #contiendra les lettres du mots sous la forme de *
my @pendu = ("\n_______","\n|"," /","   |","\n|","/","    O    ","\n|   -"," |"," -   ","\n|    /",
             " \\","\n|","\n|","__");

sub afficher_pendu {
    my ($limite) = @_;
	
	for(my $i = 0; $i <= $limite; $i++)
	{
	    print $pendu[$i];
	}
	
	print "\n\n\n";
}
			 
sub comparetab {
# me sert à voir si toutes les lettres ont été trouvées
    my ($result,$i) = (0,0);
	
    for my $lettre (@mot)
    {
        $result++ if($lettre eq $mot_mystere[$i]);
		$i++;
    }
    
    return $result==scalar(@mot)?1:0;
}

sub jeu {
    my ($lettre) = @_;
	
	if(grep {$_ eq $lettre} @mot) #on recherche si la lettre est dans le tableau.
	{
	    # pour la condition : on boucle tant que $mot[$i] existe, c'est à dire jusqu'à la dernière lettre !
	    for(my $i = 0; defined($mot[$i]); $i++)
		{
		    $mot_mystere[$i] = $mot[$i] if($mot[$i] eq $lettre);
		}
	}
	
	else { print "FAUX !\n";
           return 0; }
	
	print @mot_mystere;
	print "\n";
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

print "Mot généré : @mot_mystere";

while($coups < 15 && !comparetab())
{
	print "\nLettre ? ";

    chomp($lettre = <>);
	
	afficher_pendu($coups++) if(!jeu(uc($lettre)));
}

print "\nJe suis déjà mort ! Dommage !" if $coups >= 15;
print "\nBravo ! vous avez gagné !" if (comparetab());