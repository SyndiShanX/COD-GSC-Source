/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\traverse_window_terminal.gsc
*************************************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_0176("wallhop", 5);
    return;
  }

  self._id_247C = "stand";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("jumpanim", % jump_across_72, % body, 1, 0.1, 1);
  self waittillmatch("jumpanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("jumpanim");
}