/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_crouch.gsc
****************************************/

#include animscripts\Combat_utility;
#include animscripts\Utility;
#include common_scripts\Utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");

  self trackScriptState("Cover Crouch Main", "code");
  animscripts\utility::initialize("cover_crouch");

  self animscripts\cover_wall::cover_wall_think("crouch");
}