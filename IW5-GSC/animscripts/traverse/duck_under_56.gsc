/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\duck_under_56.gsc
**************************************************/

#using_animtree("generic_human");

main() {
  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("jumpanim", %gulag_pipe_traverse, %body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "finish");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("jumpanim");
}