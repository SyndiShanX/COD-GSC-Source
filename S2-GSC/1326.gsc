/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1326.gsc
*********************************************/

init() {
  level.adrenalineshotmovespeedscale = 1.1;
  level.var_A0A = 100;
  level.var_A0B = 1.5;
  level.var_A0C = 13.33;
  level.var_A07 = 1;
  self.var_4B50 = 0;
}

func_3662() {
  maps\mp\_utility::func_870F(level.var_A0A);
  self.var_7AD7 = level.var_A0A;
  self.var_98E1 = level.var_A0B;
  self.var_98E2 = level.var_A0C;
  self.var_4B50 = 1;
  maps\mp\gametypes\_weapons::func_A13B();
}

func_2F9E() {
  maps\mp\_utility::func_870F(0);
  self.var_7AD7 = 0;
  self.var_98E1 = undefined;
  self.var_98E2 = undefined;
  self.var_4B50 = 0;
  maps\mp\gametypes\_weapons::func_A13B();
}