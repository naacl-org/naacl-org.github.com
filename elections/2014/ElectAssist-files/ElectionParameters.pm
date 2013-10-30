# This file is part of the ElectAssist toolkit by Ulrich Germann
# (c) 2000,2001,2002 University of Southern California
# Everything specific to the election goes into this file.

# ADJUST THE VARIABLES BELOW TO YOUR LOCAL SETTINGS
package ElectionParameters;
use strict;
no strict 'vars';

$ElectAssist_ROOT = "/home/anoop/ElectAssist-2014";
$ElectAssist_ROOT =~ s/\/$//;
# if you use the standard setup described in the manual 
# you won't need to change $pindir, $votesdir, $error_log,
# and $votes_log below. ATTENTION: the tilde-notation for
# home directories (~/ or ~<user name>) may not work. Use
# /home/<user name>/... instead.

# DIRECTORY WHERE THE PIN FILES ARE:
$pindir   = "$ElectAssist_ROOT/PINS";

# DIRECTORY WHERE THE VOTES WILL BE STORED
$votesdir = "$ElectAssist_ROOT/VOTES";

# WHERE TO LOG THE VOTING
$voteslog = "$ElectAssist_ROOT/logs/votes.log";
# $votelog keeps a log of voting activities: failed authentications and time
# and point of access. Set this to /dev/null if you have privacy concerns
# It is included to help the admistrator track problems with people not being
# able to vote.

# DIRECTORY FOR ERROR MESSAGES (FOR DEBUGGING)
$error_log = ">> $ElectAssist_ROOT/logs/errors.log"; 
# this must include the redirection operator at the beginning:
# single > for "write a new file for each run" good for single-user testing
# double >> fo "append" instead of "overwrite" 
# (good when testing with several people)

$umask = "0400"; 
# files written to disk receive these permissions
# I recommend 0400 if you are running the election web server as a separate
# user


# CONTACT INFORMATION: YOUR EMAIL OR HTTP ADRESS (FOR PRAISE,
# COMPLAINTS, AND QUESTIONS)
# The contact information, if provided, is displayed in the
# footer of feedback screens. The anchor label/text will is
# set in the variable $contact_name, the link target in
# $contact_link. As for the latter, you can  provide an http address, 
# such as in: 
# $contact_link = "http://wwww.whatever.foo/~me";
# or an email address, such as in
# $contact_link = "mailto:me\@whatever.foo?Subject=It's all messed up";
# when including an email address, you must `backslash' the `@'
# character (your.name =>\@<= your-org.whatever). 

$contact_name = "Anoop Sarkar";
$contact_link = "mailto:anoop\@sfu.ca?Subject=NAACL 2014 elections web site"; 

# Provide the name of the HTML file containing the ballot form.
# The file should be in the same directory as index.cgi
$ballot   = "ballot-2014.html";

# For the ballot sanity checks, you must provide a list of all items
# (names of form elements on the ballot form) that are
# actually election items. The names must exactly match
# those used in the ballot form. The comparison is case-sensitive!
#
# ATTENTION: fields starting with `comment' (in any # combination of
# lower case and upper case) will be saved in a separate anonymous 
# file. Make sure that you choose appropriate field names
# for comment fields (if any) in the ballot form.

@ballot_items = ("Chair", "Secretary", "BoardMember", "Comments");

# %ballot_item_labels maps from the ballot item names (also used for
# storage) to (HTML) string used in the feedback screens. This allows
# you to have goodlooking text in the forms and easey-to-read, plain
# text ballot item names in the text file that keeps track of the 
# election process.

%ballot_item_labels = ("Chair"       => "<b>Chair</b>",
		       "Secretary" => "<b>Secretary</b>",
		       "BoardMember" => "<b>Board Member</b>");
# %maxvotes below sets the number of votes that are accepted
# per voter for any particular item. If no value is defined, index.cgi
# will refuse to accept any vote that specifies more than ONE option
# for the respective field. The field names must be IDENTICAL to the
# form field names used in the ballot.  For example, if voters can
# vote for two people for "Executive Committee", add the following:
# $maxvotes{"Executive Committe"} = 2;
$maxvotes{"Chair"} = 1;
$maxvotes{"Secretary"} = 1;
$maxvotes{"BoardMember"} = 2;
# The threshold hash allows you to define the minimum percentage
# of votes that a ballot item needs to 'win'
# samples:
# $threshold{"First Amendment"}{"approve"} = 2/3;
# $threshold{"President"}{"*"} = .5;
# the first line means that the First Amendment passes only with a 2/3
# majority, the second that any candidate for president wins if
# he or she gets at least 50% of the votes.

#$threshold{""}{""} = 2/3;
#$threshold{"President"}{"*"} = .5;

# DEADLINE FOR VOTING: use only numerical values !!! 
# ATTENTION! Make sure you consider different time zones!
# If your server is on the East Cost and the deadline is midnight PST, 
# you must set the deadline for 3 am EST on the next day.
# Make sure the clock on the server is right on target!
$deadline_year   = 2013; # four digits!
$deadline_month  = 12;   
$deadline_day    = 16;
$deadline_hour   = 0;   # 24-hour format
$deadline_minute = 0;

# AFTER THE DEADLINE, SHOULD ELECTION RESULTS BE DISPLAYED AUTOMATICALLY ?
# if yes, set $auto_results to 1, otherwise to 0 (zero)
# This switch overrides $election_results below.
$auto_results = 0; 

$election_results = "results.html";
# optional: if you specify this and the file exists, it will be displayed 
# instead of the ballot after the election deadline (unless $auto_results 
# is 1/true);

$hide_exact_counts = 0;
# If non-zero, exact counts are hidded when displaying autoresults. I
# am providing this feature based on the experience that some election
# committees prefer not to publish the exact details of the election
# outcome in order not to discourage potential candidates from running
# for offices. If one candidate frequently gets 95% of the votes,
# other people might not even bother trying to run for office.

$page_header = "";
# optional: if you want to provide a link to your organization's homepage,
# the election title, or some other kind of page header, define it here:
$page_header  = join("\n",
                     "<link href=\"http://naacl.org/css/bootstrap.min.css\" rel=\"stylesheet\" media=\"screen\">
                     "<div align=center>",
                     '<h1>2014 NAACL Board elections</h1>',
                     "</div>",
                     "<hr>");

return 1;

###############################################################################
# --- Nothing to be changed below this line ---

BEGIN
{
    no strict;
    use Exporter;
    @ISA = qw(Exporter);
    @EXPORT = qw($contact_link
                 $contact_name
                 $pindir 
                 $votesdir 
                 $voteslog 
                 $error_log
                 $ballot 
                 $election_results 
                 $auto_results
                 $hide_exact_counts
                 $page_header
                 %maxvotes
                 %threshold
                 $deadline_year
                 $deadline_month
                 $deadline_day
                 $deadline_hour
                 $deadline_minute
                 @ballot_items
                 gather_results
                 count_votes
                 $abstain
                 $umask);
}

sub gather_results()
# returns a hash with the election results
{
    my %results;
    open VOTE, "$ElectionParameters::votesdir/votes" 
	or die "$ElectionParameters::votesdir/votes: $!\n";
    foreach my $l (<VOTE>)
    {
	chomp $l;
	$l =~ /^(.*):::(.*)=(.*)$/;
	my ($item,$cand,$count) = ($1,$2,$3);
	$results{$item}{$cand}=$count;
    }
    return %results;
}

sub count_votes
# returns a list (# of votes received, # of pins not used)
{
    opendir PINDIR, $ElectionParameters::pindir or die "$!\n";
    my @allvotes =  readdir PINDIR;
    closedir PINDIR;
    my @didvotes = grep /^[a-zA-Z0-9]+.done$/, @allvotes;
    my @novotes =  grep /^[a-zA-Z0-9]+$/, @allvotes;
    return (scalar(@didvotes), scalar(@novotes));
}



