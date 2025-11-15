/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\flood_stepup_32.gsc
****************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = [];
  var_0[var_0.size] = % flood_traverse_stepup_32_v1;
  var_0[var_0.size] = % flood_traverse_stepup_32_v2;
  var_0[var_0.size] = % flood_traverse_stepup_32_v3;
  var_1 = [];
  var_1["traverseAnim"] = var_0[randomint(var_0.size)];
  animscripts\traverse\shared::dotraverse(var_1);
}