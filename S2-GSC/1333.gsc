/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1333.gsc
*********************************************/

lib_0535::func_00D5() {
  level.steelbibmovespeedscale = 0.75;
  level.var_9394 = 75;
  level.var_9392 = 1;
  self.var_4B9A = 0;
}

lib_0535::func_3662() {
  self.var_9393 = level.var_9394;
  self.var_4B9A = 1;
  thread lib_0535::func_63D8();
  maps\mp\gametypes\_weapons::func_A13B();
}

lib_0535::func_2F9E() {
  self.var_4B9A = 0;
  maps\mp\gametypes\_weapons::func_A13B();
}

lib_0535::func_63D8() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("SteelBibDestroyed");
  self notify("DisabledRoleAbility");
  lib_0535::func_2F9E();
}

lib_0535::func_0F31(param_00) {
  if(self.var_4B9A) {
    self.var_9393 = self.var_9393 - param_00;
    var_01 = param_00 / level.var_9394;
    self roleapplypowerchange(-1 * var_01 * level.var_9392);
    if(self.var_9393 <= 0) {
      self notify("SteelBibDestroyed");
    }
  }
}