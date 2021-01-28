#! /usr/bin/perl -w

{
  my(%positive_list);

  $positive_list{cn} = 1;
  $positive_list{company} = 1;
  $positive_list{c} = 1;
  $positive_list{department} = 1;
  $positive_list{description} = 1;
  $positive_list{givenName} = 1;
  $positive_list{initials} = 1;
  $positive_list{l} = 1;
  $positive_list{mail} = 1;
  $positive_list{mobile} = 1;
  $positive_list{postalCode} = 1;
  $positive_list{sn} = 1;
  $positive_list{streetAddress} = 1;
  $positive_list{st} = 1;
  $positive_list{telephoneNumber} = 1;
  $positive_list{title} = 1;

  ################################################################################

  my($show_p) = 0;
  my(%record);

  my($show_original_records_p) = 0;

  while(<>)
    {
      if(m/ ^ (?<lhs>dn) : \s+/x)
	{ 
	  my(%plus) = %+;

	  $show_p = 1;

	  print
	    if $show_original_records_p;
	}
      elsif(m/ ^ \s*$ /x)
	{
	  if(    defined($record{l}) || defined($record{department}) || defined($record{sn}) || defined($record{givenName}) || defined($record{initials})
	      || defined($record{mail}) || defined($record{telephoneNumber}) || defined($record{mobile}) || defined($record{title}) 
	    )
	    {
	      my($output_line) = '';
	      my($separator) = '';
	      foreach my $field ('l','department','sn','givenName','initials','mail','telephoneNumber','mobile','title')
		{
		  $output_line .=
		    sprintf "%s\"%s\"",
		      $separator,
		      defined($record{$field}) ? $record{$field} : ''
		      ;
		  $separator = ',';
		}
	      $output_line .= "\n";
	      print $output_line;
	    }

	  print
	    if $show_original_records_p;
	  %record = ();

	  $show_p = 0;
	}
      elsif($show_p)
	{
	  if(m/ ^ (?<lhs> [^:]+ ) : \s* (?<rhs>.*?) ( \s+ \/\/ \s+ .* )? $ /x)
	    { 
	      my(%plus) = %+;

	      if(exists($positive_list{$plus{lhs}}))
		{
		  print		# w/o decoding
		    if $show_original_records_p;

		  $record{ $plus{lhs} } = $plus{rhs};
		}
	    }
	}
    }
}
