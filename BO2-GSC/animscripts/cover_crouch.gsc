/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_crouch.gsc
****************************************/

#include animscripts\combat_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include animscripts\cover_wall;
#include animscripts\cover_behavior;

main() {
  self endon("killanimscript");
  [[self.exception["cover_crouch"]]]();
  self trackscriptstate("Cover Crouch Main", "code");
  animscripts\utility::initialize("cover_crouch");
  self animscripts\cover_wall::cover_wall_think("crouch");
}

end_script() {
  animscripts\cover_behavior::end_script();
}