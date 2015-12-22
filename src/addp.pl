#!/usr/bin/perl
# $Header: /repo/local.cvs/app/story-xml/old/src/addp.pl,v 1.1 2005/01/16 02:30:55 bruce Exp $
# For all text contained in the <text> element, convert all blank
# lines to <p> tags.  Existing <p> tags are normalized.

while (<>) {
	if (/<text / and  ! /pre/) {
		$tInText = 1;
		$tFirst = $_;
		$tBlock = "";
		next;
	}
	if ($tInText and /<\/text>/) {
		$tLast = $_;
		$tInText = 0;
		# Process the block
		$tBlock =~ s/^\n* *<p> *\n*//s;
		$tBlock =~ s/\n* *<\/p> *\n*$//s;
		$tBlock =~ s/<p>/\n\n<p>/sg;
		$tBlock =~ s/<\/p>/<\/p>\n\n/sg;
		$tBlock =~ s/<p>//sg;
		$tBlock =~ s/<\/p>//sg;
		$tBlock =~ s/\n *\n *\n+/\n\n/sg;
		$tBlock =~ s/\n *\n/<\/p>\n\n<p>/sg;
		print $tFirst;
		print "<p>" . $tBlock . "</p>\n";
		print $tLast;
		$tBlock = "";
		next;
	}
	if ($tInText) {
		$tBlock .= $_;
		next;
	}
	print $_;
}
