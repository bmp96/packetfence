package pfappserver::Form::Field::PfdetectRegexRule;

=head1 NAME

pfappserver::Form::Field::PfdetectRegexRule - The detect::parser::regex rule

=cut

=head1 DESCRIPTION



=cut

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Compound';
use namespace::autoclean;

has_field 'name' =>
  (
   type => 'Text',
   label => 'Name',
   required => 1,
   messages => { required => 'Please specify the name of the rule' },
  );

has_field 'regex' =>
  (
   type => 'Regex',
   label => 'Regex',
   required => 1,
   messages => { required => 'Please specify the regex pattern using named captures' },
  );

has_field 'send_add_event' =>
  (
   type => 'Toggle',
   label => 'Send Add Event',
   messages => { required => 'Please specify the if the add_event is sent' },
   checkbox_value => 'enabled',
   unchecked_value => 'disabled',
  );

has_field 'events' =>
  (
   type => 'Text',
   label => 'Event List',
   #This is required if the send_add_event if checked
   #Add validation to the event list
   messages => { required => 'Please specify the regex pattern using named captures' },
  );

=head2 actions

The list of action

=cut

has_field 'actions' =>
  (
    'type' => 'Repeatable',
  );

=head2 actions.contains

The definition for the list of actions

=cut

has_field 'actions.contains' =>
  (
    type => 'Text',
    label => 'Action',
  );
 
=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2016 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

1;

