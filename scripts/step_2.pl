
use POSIX qw/ceil/;

my $mb = 1000000;

# Creating a double hash to be the 155x155 matrix
my %matrix;
my $length = ceil(154913754/$mb);

for (my $i = 1; $i <= $length; $i++){
	my %row;
	for (my $j = 1; $j <= $length; $j++){
		$row{$j} = 0;
	}
	my $ref = \%row;
	$matrix{$i} = $ref;
}

# Generating the Hi-C contact map
my $filename1 = $ARGV[0];
open (IN, "<$filename1");

while(<IN>){
	my $line = $_;
	my @coordinates = split(/\s+/, $line);
	my $index1 = ceil($coordinates[0]/$mb);
	my $index2 = ceil($coordinates[1]/$mb);	
	if (exists $matrix{$index1}{$index2}) {
		$matrix{$index1}{$index2} += 1;
	}
}

close(IN);

my $filename2 = $ARGV[1];
open (OUT, ">$filename2");
foreach $key1 (sort {$a <=> $b} keys %matrix){
        my %row = %{$matrix{$key1}};
        foreach $key2 (sort {$a <=> $b} keys %row){
                printf OUT '%05s', $row{$key2};
		print OUT "  ";
        }
	print OUT "\n\n";
}

close(OUT);

# Finding rows with all zeros:

my @zero_row;

my $count = 0;
for (my $i = 1; $i <= $length; $i++){
	my $sum = 0;
	for (my $j = 1; $j <= $length; $j++){
		$sum += $matrix{$i}{$j};
		if ($sum != 0){
			last;			
		}
	}
	if ($sum == 0) {
		push (@zero_row, $i);
	}
}

# Delete the rows and columns
my $length2 = $length;
foreach my $key (sort {$b <=> $a} @zero_row){
	my $i;
	for ( $i = $key; $i <= ($length2 - 1); $i++){
		$matrix{$i} = $matrix{$i+1};
	}
	delete $matrix{$i};

	$length2 -= 1;

	for (my $k = 1; $k <= $length2; $k++){
		my $j;
		for ($j = $key; $j <= $length2; $j++){
			$matrix{$k}{$j} = $matrix{$k}{$j+1};
		}
		delete $matrix{$k}{$j};
	}
}

# Creating a new 153x153 distance matrix

my %distance_matrix;

for (my $i = 1; $i <= $length2; $i++){
	my %row;
	for (my $j = 1; $j <= $length2; $j++){
		$row{$j} = 0;
	}
	my $ref = \%row;
	$distance_matrix{$i} = $ref;
}

# Calculating distance from raw contact:
my $filename3 = $ARGV[2];
open (OUT, ">$filename3");

for (my $i = 1; $i <= $length2; $i++){
	for (my $j = 1; $j <= $length2; $j++){
		my $x = $matrix{$i}{$j};
		if ($x == 0){
			$x = 1;
		}
		my $y = (1/$x)**(1/3);
		$distance_matrix{$i}{$j} = $y;
		printf OUT '%8.4f', $distance_matrix{$i}{$j};
	}
	print OUT "\n\n";
}

close (OUT);
