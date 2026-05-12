/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1328.gsc
*********************************************/

lib_0530::func_00D5() {
  level.doronvestmovespeedscale = 0.8;
  level.var_32A2 = 0.95;
  level.var_32A6 = 500;
  level.var_32A4 = 1;
  self.var_4B64 = 0;
}

lib_0530::func_3662() {
  self.var_32A5 = level.var_32A6;
  if(maps\mp\_utility::func_0649("specialty_stun_resistance")) {
    self.var_32A1 = 1;
  } else {
    maps\mp\_utility::func_47A2("specialty_stun_resistance");
  }

  self.var_4B64 = 1;
  thread lib_0530::func_63D8();
  maps\mp\gametypes\_weapons::func_A13B();
}

lib_0530::func_2F9E() {
  if(!isDefined(self.var_32A1) || !self.var_32A1) {
    maps\mp\_utility::func_0735("specialty_stun_resistance");
  }

  self.var_4B64 = 0;
  maps\mp\gametypes\_weapons::func_A13B();
}

lib_0530::func_63D8() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("DoronVestDestroyed");
  self notify("DisabledRoleAbility");
  lib_0530::func_2F9E();
}

lib_0530::func_0F31(param_00) {
  if(self.var_4B64) {
    self.var_32A5 = self.var_32A5 - param_00;
    var_01 = param_00 / level.var_32A6;
    self roleapplypowerchange(-1 * var_01 * level.var_32A4);
    if(self.var_32A5 <= 0) {
      self notify("DoronVestDestroyed");
    }
  }
}