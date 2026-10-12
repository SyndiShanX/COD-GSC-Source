/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\render_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace render_utility;

function function_4f2c4138dacca16a(aberration, radius, strength, distortion) {
  assert(isDefined(self));
  assert(isPlayer(self));

  if(isDefined(aberration)) {
    self setclientomnvar("chromatic_aberration_override", aberration);
  }

  if(isDefined(radius)) {
    self setclientomnvar("chromatic_aberration_radius_override", radius);
  }

  if(isDefined(strength)) {
    self setclientomnvar("chromatic_aberration_strength_override", strength);
  }

  if(isDefined(distortion)) {
    self setclientomnvar("chromatic_aberration_distortion_override", distortion);
  }
}

function function_e2eae50826e12247() {
  assert(isDefined(self));
  assert(isPlayer(self));
  self setclientomnvar("chromatic_aberration_override", 0);
  self setclientomnvar("chromatic_aberration_radius_override", 0);
  self setclientomnvar("chromatic_aberration_strength_override", 0);
  self setclientomnvar("chromatic_aberration_distortion_override", 0);
}