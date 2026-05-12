/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_tabun_grenade.gsc
*************************************************************/

func_00D5() {
  level.zm_grenade_funcs["tabun_grenade_zm"] = ::tabunzm_onfired;
  level.zombietacticalweapon["tabun_grenade_zm"] = 1;
  level.var_611["zmb_tabun_stun"] = loadfx("vfx/zombie/abilities_perks\zmb_storm_zmb_debuff");
  level.currentconverts = 0;
}

tabun_get_weapon_name() {
  return "tabun_grenade_zm";
}

tabun_player_give_tabun() {
  lib_0555::func_83DD("dlc3_tac_hint_2", self);
  var_00 = tabun_get_weapon_name();
  self.var_60A0 = 2;
  self method_831E(var_00);
  lib_0586::func_78C(var_00);
  self method_82FA(var_00, 2);
}

tabunzm_onfired(param_00, param_01) {
  param_01 = self;
  param_01 thread tabunzm_handle(param_00);
  return 1;
}

tabunzm_handle(param_00) {
  self endon("disconnect");
  param_00 endon("make_dud");
  param_00 endon("death");
  param_00 waittill("explode", var_01);
  var_02 = spawnStruct();
  var_02.var_2994 = 10;
  var_02.var_14F = 100;
  var_02.var_688C = 5;
  var_02.var_99EB = 1;
  var_02.var_6C2C = var_01;
  thread tabunzm_managedamage(var_02, self, tabun_get_weapon_name());
}

tabunzm_managedamage(param_00, param_01, param_02) {
  level endon("game_ended");
  param_01 endon("disconnect");
  self endon("death");
  var_03 = 0;
  while(var_03 < param_00.var_688C) {
    var_03++;
    var_04 = lib_0547::func_408F();
    foreach(var_06 in var_04) {
      var_07 = var_06.var_A4B;
      if(!lib_0547::func_5565(var_07, "zombie_generic")) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_06.isconverted)) {
        continue;
      }

      if(tabunzm_collisionpassed(var_06.var_116, param_00.var_6C2C, param_00.var_14F)) {
        if(tabunzm_zombieishittable(var_06, param_00.var_6C2C)) {
          if(isDefined(param_01) && isDefined(level.currentconverts) && level.currentconverts < 8) {
            level tabunzm_convertzombie(var_06, param_01);
          }
        }
      }
    }

    wait(param_00.var_99EB);
  }
}

tabunzm_convertzombie(param_00, param_01) {
  param_00 maps\mp\agents\_agent_utility::func_83FE("allies", param_01);
  param_00 thread tabunzm_handletimeout();
  level thread tabunzm_onzombiedeath(param_00);
  param_00.var_6816 = 1;
  param_00.isconverted = 1;
  playfxontagforclients(common_scripts\utility::func_44F5("zmb_tabun_stun"), param_00, "J_Head", param_01);
}

tabunzm_onzombiedeath(param_00) {
  param_00 endon("kill_tabun_listener");
  level.currentconverts++;
  param_00 waittill("death");
  level.currentconverts--;
}

tabunzm_handletimeout() {
  self endon("death");
  wait(60);
  self notify("kill_tabun_listener");
  level.currentconverts--;
  self dodamage(self.var_8 + 666, self.var_116, undefined, undefined, "MOD_EXPLOSIVE", tabun_get_weapon_name());
}

tabunzm_collisionpassed(param_00, param_01, param_02) {
  return distancesquared(param_00, param_01) < param_02 * param_02;
}

tabunzm_zombieishittable(param_00, param_01) {
  if(param_00.var_116[2] <= param_01[2]) {
    return bullettracepassed(param_00.var_116 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00) && bullettracepassed(param_01 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00);
  }

  return bullettracepassed(param_01 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00) && bullettracepassed(param_00.var_116 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00);
}