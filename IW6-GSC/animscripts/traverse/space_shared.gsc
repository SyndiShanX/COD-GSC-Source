/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\space_shared.gsc
*************************************************/

#using_animtree("generic_human");

dospacetraverse(var_0) {
  self endon("killanimscript");
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  var_1 = self getnegotiationstartnode();
  var_2 = self getnegotiationendnode();
  self.traverseheight = var_0["traverseHeight"];
  self.traversestartnode = var_1;
  var_3 = var_0["traverseAnim"];
  var_4 = var_0["traverseToCoverAnim"];
  self traversemode("nogravity");
  self traversemode("noclip");
  var_5 = 0;
  self.traverseanim = var_3;
  self.traverseanimroot = % root;
  self setflaggedanimknoballrestart("traverseAnim", var_3, % root, 1, 0.2, 1);
  self.traversedeathindex = 0;
  self.traversedeathanim = var_0["interruptDeathAnim"];
  animscripts\shared::donotetracks("traverseAnim", animscripts\traverse\shared::handletraversenotetracks);
  iprintlnbold("after notetracks");
  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
  self.deathanim = undefined;
}