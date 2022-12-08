my %matchup = 'AX' => 3, 'AY' => 4, 'AZ' => 8, 'BX' => 1, 'BY' => 5, 'BZ' => 9, 'CX' => 2, 'CY' => 6, 'CZ' => 7;

my $total = 0;
for 'input.txt'.IO.lines -> $line {
    my ($them, $me) = $line.split(" ");
    $total += %matchup{$them ~ $me};
}
say $total;
