/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\jump_up_80.gsc
***********************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0._id_1EFA - var_0.origin[2];
  thread animscripts\traverse\shared::_id_3FE7(var_1 - 80);
  self clearanim(%root, 0.2);
  self setflaggedanimrestart("jump_up_80", anim._id_3AF6["jump_up_80"], 1, 0.2, 1);
  animscripts\shared::_id_0C51("jump_up_80");
  self._id_3B58 = 1;
}