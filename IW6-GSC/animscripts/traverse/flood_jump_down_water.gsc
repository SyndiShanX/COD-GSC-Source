/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\flood_jump_down_water.gsc
**********************************************************/

#using_animtree("generic_human");

main() {
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_0 = [];
  var_0["traverseAnim"] = % flood_rooftop_traversal_ally02_secondjump;
  animscripts\traverse\shared::dotraverse(var_0);
}