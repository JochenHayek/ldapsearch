#! /usr/bin/perl -w

{
  my($show_p) = 0;
  my(%record);

  my($show_original_records_p) = 0;
##my($quotation_char) = '"';
  my($quotation_char) = '';

  my(@field_names) = 

##,'cn'
##,'company'
##,'c'
##,'description'
##,'postalCode'
##,'streetAddress'
##,'st'

##,'l'
##,'department'
##,'givenName'
##,'initials'
##,'sAMAccountName'
##,'telephoneNumber'
##,'mobile'
##,'title'

  ('displayName'
  ,'Herr_oder_Frau'
  ,'cn'
  ,'sn'
  ,'mail'
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
	  my($separator_char) = '';

	  foreach my $field (@field_names)
	    {
	      $any_of_them_is_defined_p ||= defined($record{$field});

	      $output_line .=
		sprintf "%s%s%s%s",
		  $separator_char,
		  $quotation_char,
		  defined($record{$field}) ? $record{$field} : '',
		  $quotation_char,
		  ;
	      $separator_char = ',';
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
