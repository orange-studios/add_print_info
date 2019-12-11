#!/usr/bin/perl

use strict;
use warnings;

if((scalar @ARGV) < 2)
{
	printf "usage: \n $0 file_name outfile.\n";
	exit  -1;
}

my ($file,$outfile) = @ARGV;
my ($in,$out);

my $add_line='printk("[OrangeYang][%s:--%s]--%d\n", __FILE__, __func__, __LINE__);';
$add_line="\n\t$add_line\n";

my $line;
my $num = 0;

open $in , '<', $file or die "can't open input file $file" ;
open $out , '>',$outfile or die "can't open output file $outfile" ;

$/='{';

while ($line=<$in>)
{
	my $outline = $line;
	
	if($line =~/(\w+)\s*\([^\{\}\;\/]*\)(\s*|\n#endif\s*)\{$/)
	{
		my $name =$1;
		my $pre = $`;
	
		if(($name !~/^(if|for|while|do|switch|defined)$/) 
			&&($name !~/(for|do)_each/)
			&& ($pre !~/\s(_init|_exit)\s+\w*\s*$/))
		{
			$num++;
			$outline .= $add_line;
		}	
	}
	
	print $out $outline;
}	

close $in;
print STDOUT $num, "\n";

