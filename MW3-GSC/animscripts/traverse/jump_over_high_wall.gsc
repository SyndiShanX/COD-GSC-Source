/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_over_high_wall.gsc
********************************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim(%stand_and_crouch, 0.1);
  self setflaggedanimknoballrestart("diveanim", %jump_over_high_wall, %body, 1, 0.1, 1);
  self playSound("dive_wall");
  self waittillmatch("diveanim", "gravity on");
  self traversemode("nogravity");
  self waittillmatch("diveanim", "noclip");
  self traversemode("noclip");
  self waittillmatch("diveanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("diveanim");
}