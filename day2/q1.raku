my %points = 'X' => 1, 'Y' => 2, 'Z' => 3;
my %matchup = 'AX' => 3, 'AY' => 6, 'AZ' => 0, 'BX' => 0, 'BY' => 3, 'BZ' => 6, 'CX' => 6, 'CY' => 0, 'CZ' => 3;

my $total = 0;
for 'input.txt'.IO.lines -> $line {
    my ($them, $me) = $line.split(" ");
    $total += %points{$me} + %matchup{$them ~ $me};
}
say $total;
