#! /usr/bin/perl -w

use MIME::Base64;

{
  my(%decoding_makes_no_sense);

  $decoding_makes_no_sense{msExchArchiveGUID} = 1;
  $decoding_makes_no_sense{msExchDisabledArchiveGUID} = 1;
  $decoding_makes_no_sense{msExchBlockedSendersHash} = 1;
  $decoding_makes_no_sense{msExchMailboxGuid} = 1;
  $decoding_makes_no_sense{msExchMailboxSecurityDescriptor} = 1;
  $decoding_makes_no_sense{msExchMasterAccountSid} = 1;
  $decoding_makes_no_sense{msExchSafeSendersHash} = 1;
  $decoding_makes_no_sense{objectGUID} = 1;
  $decoding_makes_no_sense{objectSid} = 1;
  $decoding_makes_no_sense{protocolSettings} = 1;
  $decoding_makes_no_sense{thumbnailPhoto} = 1;
  $decoding_makes_no_sense{userCertificate} = 1;
  $decoding_makes_no_sense{userParameters} = 1;

##$decoding_makes_no_sense{msExchBlockedSendersHash} = 1;
##$decoding_makes_no_sense{msExchDisabledArchiveGUID} = 1;
##$decoding_makes_no_sense{msExchMailboxGuid} = 1;
##$decoding_makes_no_sense{msExchMailboxSecurityDescriptor} = 1;
##$decoding_makes_no_sense{msExchMasterAccountSid} = 1;
##$decoding_makes_no_sense{msExchSafeSendersHash} = 1;
##$decoding_makes_no_sense{objectGUID} = 1;
##$decoding_makes_no_sense{objectSid} = 1;
##$decoding_makes_no_sense{protocolSettings} = 1;
##$decoding_makes_no_sense{thumbnailPhoto} = 1;
##$decoding_makes_no_sense{userCertificate} = 1;
##$decoding_makes_no_sense{userParameters} = 1;

  ################################################################################

  while(<>)
    {
      if(m/ ^ (?<lhs> [^:]+ ) :: \s+ (?<rhs>.*) $ /x)
	{ 
	  my(%plus) = %+;

	  if(exists($decoding_makes_no_sense{$plus{lhs}}))
	    {
	      print;		# w/o decoding
	    }

	  elsif(0)		# *with* the enclosing parentheses
	    {
	      printf "%s: ((%s))\n",
		$plus{lhs},
		decode_base64($plus{rhs})
		if 1;

	      printf "%s\n",$plus{lhs}
		if 0;
	    }

	  elsif(1)		# *w/o* the enclosing parentheses, but with an extra comment
	    {
	      printf "%s: %s // %s\n",
		$plus{lhs},
		decode_base64($plus{rhs}),
		'originally base64 encoded'
		if 1;

	      printf "%s\n",$plus{lhs}
		if 0;
	    }

	  else
	    {
	      printf "%s: ((%s))\n", # maybe w/o the enclosing parentheses
		$plus{lhs},
		decode_base64($plus{rhs})
		if 1;

	      printf "%s\n",$plus{lhs}
		if 0;
	    }
	}
      elsif(0)
	{
	}
      else
	{
	  print
	}
    }
}
