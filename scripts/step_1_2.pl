
my $filename1 = $ARGV[0];
my $filename2 = $ARGV[1];
my $filename3 = $ARGV[2];

my $first = "true";

my %hash1;
my %hash2;

open(IN, "<$filename1");
while (<IN>){
	if ($first eq "true"){
		$first = "false";
		next;
	}
	my $line = $_;
	my @items = split(/\s+/, $line);
	
	$hash1{$items[0]} = $items[3];
}
close (IN);

$first = "true";
open(IN, "<$filename2");
while (<IN>){
        if ($first eq "true"){
                $first = "false";
                $second = "true";
                next;
        }
        my $line = $_;
        my @items = split(/\s+/, $line);
        
        $hash2{$items[0]} = $items[3];
}

close (IN);

open(OUT, ">$filename3");
#foreach my $key1 (keys %hash1){
#	foreach my $key2 (keys %hash2){
#		my @arr1 = split (/\./, $key1);
#		my @arr2 = split (/\./, $key2);
#		if (($arr1[0] eq $arr2[0]) && ($arr1[1] eq $arr2[1])){
#			print OUT "$hash1{$key1} $hash2{$key2}\n";
#			last;
#		}		
#	}
#}

foreach my $key1 (keys %hash1){
	my @arr1 = split(/\./, $key1);
	my $key2 = $arr1[0].".".$arr1[1].".2";
	if (exists $hash2{$key2}){
		print OUT "$hash1{$key1} $hash2{$key2}\n";	
	} 
}
close(OUT);
