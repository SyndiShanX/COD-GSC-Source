/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 474.gsc
*********************************************/

main() {
  wait(0);
  if(isDefined(self)) {
    self delete();
  }
}

func_0044() {
  self endon("death");
  wait 0.05;
  self delete();
}