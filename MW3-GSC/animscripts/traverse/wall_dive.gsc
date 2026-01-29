/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_dive.gsc
**********************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("diveanim", % jump_over_low_wall, % body, 1, 0.1, 1);
  self playSound("dive_wall");
  self waittillmatch("diveanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("diveanim");
  self.a._id_0D2B = "run";
}