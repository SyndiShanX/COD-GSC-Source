/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 474.gsc
*********************************************/

lib_01DA::func_00F9() {
  wait(0);
  if(isDefined(self)) {
    self delete();
  }
}

lib_01DA::func_0044() {
  self endon("death");
  wait 0.05;
  self delete();
}