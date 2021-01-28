#! /usr/bin/perl -w

{
  my($show_p) = 0;
  my(%record);

  my($show_original_records_p) = 0;

  my(@field_names) = 

##,'cn'
##,'company'
##,'c'
##,'description'
##,'postalCode'
##,'streetAddress'
##,'st'

  ('l'
  ,'department'
  ,'sn'
  ,'givenName'
  ,'initials'
  ,'mail'
  ,'telephoneNumber'
  ,'mobile'
  ,'title'
  );

  my(%positive_list);
  foreach my $field (@field_names)
    {
      $positive_list{$field} = 1;
    }

  print join(',',@field_names) , "\n";

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
	  my($any_of_them_is_defined_p) = 0;
	  my($output_line) = '';
	  my($separator) = '';

	  foreach my $field (@field_names)
	    {
	      $any_of_them_is_defined_p ||= defined($record{$field});

	      $output_line .=
		sprintf "%s\"%s\"",
		  $separator,
		  defined($record{$field}) ? $record{$field} : ''
		  ;
	      $separator = ',';
	    }

	  $output_line .= "\n";
	  print $output_line 
	    if $any_of_them_is_defined_p;

	  print
	    if $show_original_records_p;
	  %record = ();

	  $show_p = 0;
	}
      elsif($show_p)
	{
	  if(    m/ ^ (?<lhs> [^:]+ ) : \s* (?<rhs>.*?) ( \s+ \/\/ \s+ .* )? $ /x
	      && exists($positive_list{$+{lhs}})
	    )
	    { 
	      print		# w/o decoding
		if $show_original_records_p;

	      $record{ $+{lhs} } = $+{rhs};
	    }
	}
    }
}
