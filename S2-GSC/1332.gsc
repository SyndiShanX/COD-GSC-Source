/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1332.gsc
*********************************************/

lib_0534::func_00D5() {
  self.var_4B91 = 0;
  level.var_83C8 = 6;
  level.var_83C9 = 0.05;
  level.var_83C7 = 1.25;
  level.var_83CA = 4;
}

lib_0534::func_3662() {
  maps\mp\_utility::func_47A2("specialty_finalstand");
  self.var_4B91 = 1;
  self notify("self_revive");
}

lib_0534::func_2F9E() {
  maps\mp\_utility::func_0735("specialty_finalstand");
  self.var_4B91 = 0;
  self waittill("revive");
  self.var_98E2 = undefined;
}