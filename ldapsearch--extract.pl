#! /usr/bin/perl -w

{
  my(%positive_list);

  $positive_list{cn} = 1;
  $positive_list{company} = 1;
  $positive_list{c} = 1;
  $positive_list{department} = 1;
  $positive_list{description} = 1;
  $positive_list{givenName} = 1;
  $positive_list{l} = 1;
  $positive_list{mail} = 1;
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
	  if( defined($record{sn}) || defined($record{givenName}) || defined($record{mail}) )
	    {
	      # l,department,sn,givenName,mail,telephoneNumbertitle,title

	      printf "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
		defined($record{l})  	          ? $record{l}  : '' ,
		defined($record{department}) 	  ? $record{department}      : '' ,
		defined($record{sn})         	  ? $record{sn}         : '' ,
		defined($record{givenName})  	  ? $record{givenName}  : '' ,
		defined($record{mail})       	  ? $record{mail}       : '' ,
		defined($record{telephoneNumber}) ? $record{telephoneNumber} : '' ,
		defined($record{title})      	  ? $record{title}           : ''
		;
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
