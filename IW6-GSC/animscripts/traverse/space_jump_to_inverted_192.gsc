/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\space_jump_to_inverted_192.gsc
***************************************************************/

#using_animtree("generic_human");

main() {
  if(!isDefined(self.swimmer) || !self.swimmer) {
    return;
  }
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self.turnrate = 2000;
  self orientmode("face angle 3d", var_0.angles);
  self clearanim( % root, 0);
  self setflaggedanimknoballrestart("3dtraverseAnim", % space_traversal_jump_180_u, % root, 1, 0.1, 1);
  animscripts\shared::donotetracks("3dtraverseAnim");
}