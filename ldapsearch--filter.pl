#! /usr/bin/perl -w

{
  my($show_p) = 0;

  while(<>)
    {
      if(m/ ^ (?<lhs>dn) : \s+ (?<rhs>CN=Hayek\\, \s+ Jochen,) /x)
	{ 
	  my(%plus) = %+;

	  $show_p = 1;

	  print;
	}
      elsif(m/ ^ \s*$ /x)
	{
	  $show_p = 0;
	}
      elsif($show_p)
	{
	  print;
	}
    }
}
