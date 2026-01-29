/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\fence_climb.gsc
************************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("diveanim", % fenceclimb, % body, 1, 0.1, 1);
  animscripts\shared::_id_0C51("diveanim");
  self traversemode("gravity");
}