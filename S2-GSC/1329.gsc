/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1329.gsc
*********************************************/

init() {
  level.extremeconditioningmovespeedscale = 1.4;
  self.var_4B66 = 0;
}

func_3662() {
  self.var_4B66 = 1;
  maps\mp\gametypes\_weapons::func_A13B();
}

func_2F9E() {
  self.var_4B66 = 0;
  maps\mp\gametypes\_weapons::func_A13B();
}