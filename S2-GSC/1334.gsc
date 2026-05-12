/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1334.gsc
*********************************************/

lib_0536::func_00D5() {
  self.var_4BA2 = 0;
}

lib_0536::func_3662() {
  maps\mp\_utility::func_47A2("specialty_personaluav");
  maps\mp\_utility::func_47A2("specialty_spygame");
  maps\mp\_utility::func_47A2("specialty_coldblooded");
  maps\mp\_utility::func_47A2("specialty_heartbreaker");
  maps\mp\_utility::func_47A2("specialty_undercover");
  self.var_267E = maps\mp\gametypes\_class::func_1F95(1);
  maps\mp\gametypes\_class::func_21B9();
  maps\mp\gametypes\_teams::func_73CA();
  self.var_4BA2 = 1;
}

lib_0536::func_2F9E() {
  maps\mp\_utility::func_0735("specialty_coldblooded");
  maps\mp\_utility::func_0735("specialty_spygame");
  maps\mp\_utility::func_0735("specialty_heartbreaker");
  maps\mp\_utility::func_0735("specialty_personaluav");
  maps\mp\_utility::func_0735("specialty_undercover");
  self.var_267E = maps\mp\gametypes\_class::func_1F95(1);
  maps\mp\gametypes\_class::func_21B9();
  maps\mp\gametypes\_teams::func_73CA();
  self.var_4BA2 = 0;
}