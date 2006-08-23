#!/usr/bin/perl
# 
# THIS FILE WAS AUTOMATICALLY GENERATED BY ./rabxtopl.pl, DO NOT EDIT DIRECTLY
# 
# MaPit.pm:
# Client interface for MaPit
#
# Copyright (c) 2005 UK Citizens Online Democracy. All rights reserved.
# WWW: http://www.mysociety.org
#
# $Id: MaPit.pm,v 1.27 2006-08-23 08:23:06 francis Exp $

package mySociety::MaPit;

use strict;

use RABX;
use mySociety::Config;

=item configure [URL]

Set the RABX URL which will be used to call the functions. If you don't
specify the URL, mySociety configuration variable MAPIT_URL will be used
instead.

=cut
my $rabx_client = undef;
sub configure (;$) {
    my ($url) = @_;
    $url = mySociety::Config::get('MAPIT_URL') if !defined($url);
    $rabx_client = new RABX::Client($url) or die qq(Bad RABX proxy URL "$url");
}

=item BAD_POSTCODE 2001

  String is not in the correct format for a postcode.

=cut
use constant BAD_POSTCODE => 2001;

=item POSTCODE_NOT_FOUND 2002

  The postcode was not found in the database.

=cut
use constant POSTCODE_NOT_FOUND => 2002;

=item AREA_NOT_FOUND 2003

  The area ID refers to a non-existent area.

=cut
use constant AREA_NOT_FOUND => 2003;

=item MaPit::get_generation

  Return current MaPit data generation.

=cut
sub get_generation () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_generation', @_);
}

=item MaPit::get_voting_areas POSTCODE

  Return voting area IDs for POSTCODE.

=cut
sub get_voting_areas ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_areas', @_);
}

=item MaPit::get_voting_area_info AREA

  Return information about the given voting area. Return value is a
  reference to a hash containing elements,

  * type

    OS-style 3-letter type code, e.g. "CED" for county electoral division;

  * name

    name of voting area;

  * parent_area_id

    (if present) the ID of the enclosing area.

  * area_id

    the ID of the area itself

  * generation_low, generation_high, generation

    the range of generations of the area database for which this area is to
    be used and the current active generation.

=cut
sub get_voting_area_info ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_area_info', @_);
}

=item MaPit::get_voting_areas_info ARY

=cut
sub get_voting_areas_info ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_areas_info', @_);
}

=item MaPit::get_voting_area_geometry AREA [POLYGON_TYPE] [TOLERANCE]

  Return geometry information about the given voting area. Return value is
  a reference to a hash containing elements. Coordinates with names ending
  _e and _n are UK National Grid eastings and northings. Coordinates ending
  _lat and _lon are WGS84 latitude and longitude.

  centre_e, centre_n, centre_lat, centre_lon - centre of bounding rectangle
  min_e, min_n, min_lat, min_lon - south-west corner of bounding rectangle
  max_e, max_n, max_lat, max_lon - north-east corner of bounding rectangle
  area - surface area of the polygon, in metres squared parts - number of
  parts the polygon of the boundary has

  If POLYGON_TYPE is present, then the hash also contains a member
  'polygon'. This is an array of parts. Each part is a hash of the
  following values:

  sense - a positive value to include the part, negative to exclude (a
  hole) points - an array of pairs of (eastings, northings) if POLYGON_TYPE
  is 'ng", or (latitude, longitude) if POLYGON_TYPE is 'wgs84'.

  XXX If TOLERANCE is present then the points are first pruned. Not yet
  implemeneted.

=cut
sub get_voting_area_geometry ($;$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_area_geometry', @_);
}

=item MaPit::get_voting_areas_geometry ARY

=cut
sub get_voting_areas_geometry ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_areas_geometry', @_);
}

=item MaPit::get_areas_by_type TYPE [ALL]

  Returns an array of ids of all the voting areas of type TYPE. TYPE is the
  three letter code such as WMC. By default only gets active areas in
  current generation, if ALL is true then gets all areas for all
  generations.

=cut
sub get_areas_by_type ($;$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_areas_by_type', @_);
}

=item MaPit::get_example_postcode ID

  Given an area ID, returns one postcode that maps to it.

=cut
sub get_example_postcode ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_example_postcode', @_);
}

=item MaPit::get_voting_area_children ID

  Return array of ids of areas whose parent areas are ID.

  * coordsyst

  * easting

  * northing

    Coordinates of the point in a UTM coordinate system. The coordinate
    system is identified by the coordsyst element, which is "G" for OSGB
    (the Ordnance Survey "National Grid" for Great Britain) or "I" for the
    Irish Grid (used in the island of Ireland).

  * wgs84_lat

  * wgs84_lon

    Latitude and longitude in the WGS84 coordinate system, expressed as
    decimal degrees, north- and east-positive.

=cut
sub get_voting_area_children ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.get_voting_area_children', @_);
}

=item MaPit::admin_get_stats

  Returns a hash of statistics about the database. (Bit slow as count of
  postcodes is very slow).

=cut
sub admin_get_stats () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('MaPit.admin_get_stats', @_);
}


1;
