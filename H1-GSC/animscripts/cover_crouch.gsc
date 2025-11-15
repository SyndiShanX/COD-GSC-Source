/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_crouch.gsc
****************************************/

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("cover_crouch");
  animscripts\cover_wall::cover_wall_think("crouch");
}

end_script() {
  self.covercrouchlean_aimmode = undefined;
  animscripts\cover_behavior::end_script("crouch");
}