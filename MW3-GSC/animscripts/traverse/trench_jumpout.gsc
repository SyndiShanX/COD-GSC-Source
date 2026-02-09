/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\trench_jumpout.gsc
***************************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self.a._id_0D2B = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", %gully_trenchjump, %body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("stepanim");
  self setanimknoballrestart(animscripts\run::_id_0FC4(), %body, 1, 0.1, 1);
}