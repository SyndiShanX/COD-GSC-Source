/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\ladder_up.gsc
**********************************************/

#using_animtree("generic_human");

main() {
  if(isdefined(self.type) && self.type == "dog") {
    return;
  }
  animscripts\traverse\shared::dovariablelengthtraverse(undefined, % ladder_climbup, % ladder_climboff, "noclip", "crouch", "run");
}