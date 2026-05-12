/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1407.gsc
*********************************************/

lib_057F::func_00D5() {
  thread lib_057F::func_7BAD();
  lib_057F::func_522E();
  var_00 = undefined;
  thread maps\mp\_utility::func_6F74(::lib_057F::func_A8DF, var_00);
  level.var_A9C8["raven_sword_zm"] = ::lib_057F::func_7A7C;
  level.var_62B3["raven_sword_zm"] = ::lib_057F::func_7A7E;
  level.activeswordname = "raven_sword_zm+" + maps\mp\gametypes\_class::func_A9EE("zom_raven");
  lib_0547::func_7BA9(::lib_057F::func_7A7F);
}

lib_057F::func_522E() {
  if(!isDefined(level.var_6DF9)) {
    level.var_6DF9 = [];
  }

  var_00 = [];
  var_00[16]["noGib"] = 1;
  var_01 = (42.816, 5.533, 0);
  var_02 = length(var_01);
  level.var_6DF9["default"]["raven_sword_zm"]["hit_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  level.var_6DF9["default"]["raven_sword_zm"]["hit_zombie_action"] = "pain_paired_melee_raven_sword";
  level.var_6DF9["default"]["raven_sword_zm"]["fatal_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  level.var_6DF9["default"]["raven_sword_zm"]["fatal_zombie_action"] = "death_melee_raven_sword_zm";
  level.var_6DF9["default"]["raven_sword_zm"]["dismemberment_override"] = var_00;
  level.var_6DF9["default"]["raven_sword_zm"]["fatal_zombie_pos"] = var_01;
  level.var_6DF9["default"]["raven_sword_zm"]["fatal_zombie_dist"] = var_02;
  level.var_6DF9["heavy"]["raven_sword_zm"]["fatal_worldmodel_anim"] = "va_npc_melee_raven_sword_hit_crit_long";
  level.var_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_action"] = "death_melee_heavy_raven_sword_zm";
  level.var_6DF9["heavy"]["raven_sword_zm"]["dismemberment_override"] = var_00;
  level.var_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_pos"] = var_01;
  level.var_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_dist"] = var_02;
  level.var_6DF9["heavy"]["raven_sword_zm"]["no_flinch_time"] = 4;
}

lib_057F::func_7BAD() {
  level.var_0611["zmb_raven_sword_burst"] = loadfx("vfx/zombie/zmb_sword_burst");
  level.var_0611["zmb_raven_sword_touch_of_death_aoe"] = loadfx("vfx/explosion/zmb_sword_tod_aoe");
  level.var_0611["zmb_sword_activate"] = loadfx("vfx/zombie/zmb_sword_activate");
  level.var_0611["zmb_sword_impale_head"] = loadfx("vfx/blood/zmb_sword_impale_head");
  level.var_0611["zmb_sword_slice"] = loadfx("vfx/blood/zmb_sword_slice");
}

lib_057F::func_4B3A() {
  var_00 = self method_82D5();
  return issubstr(var_00, "raven_sword_zm");
}

lib_057F::func_A8DF(param_00) {
  lib_057F::func_5242();
  var_01 = 0;
  for(;;) {
    var_02 = lib_057F::func_4B3A();
    if(var_01 != var_02) {
      if(var_02) {
        thread lib_057F::func_7A7B();
      } else {
        thread lib_057F::func_7A7D();
      }

      var_01 = var_02;
    }

    common_scripts\utility::func_A70A("weapon_taken", "weapon_given");
  }
}

lib_057F::func_7A7E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_01 method_8661()) {
    if(param_01 lib_0547::func_1F54(param_00, param_04)) {
      return param_02;
    } else {
      return 0;
    }
  }

  var_08 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), level.var_A980);
  if(param_01.var_7A8D.var_08BE) {
    param_01 lib_057F::func_90F2(1);
    var_08 = var_08 * 2;
  } else {
    var_08 = int(ceil(var_08 / 2));
  }

  return int(max(param_02, var_08));
}

lib_057F::func_7A7B() {
  thread lib_057F::func_7A84();
}

lib_057F::func_7A7D() {
  self notify("raven_sword_lost");
}

lib_057F::func_7A84() {
  self endon("raven_sword_lost");
  thread lib_057F::func_5FC5();
  thread lib_057F::func_5FC4();
}

lib_057F::func_5242() {
  if(!isDefined(self.var_7A8D)) {
    self.var_7A8D = spawnStruct();
    self.var_7A8D.var_08BE = 0;
    self.var_7A8D.var_20F0 = 0;
    self.var_7A8D.var_5A50 = 0;
    self.var_7A8D.var_9AC4 = 0;
  }
}

lib_057F::func_7A80() {
  self.var_7A8D.var_08BE = 1;
  while(self method_8661() || self method_8128()) {
    wait 0.05;
  }

  var_00 = self getcurrentweapon();
  lib_0586::func_0790("raven_sword_zm");
  lib_0586::func_078C(level.activeswordname);
  if(issubstr(var_00, "raven_sword")) {
    self switchtoweaponimmediate(level.activeswordname);
  }

  wait(0.1);
  thread lib_057F::func_7119();
}

lib_057F::func_7119() {
  var_00 = self getcurrentweapon();
  if(var_00 == level.activeswordname && self.var_7A8D.var_08BE == 1) {
    var_01 = common_scripts\utility::func_44F5("zmb_sword_activate");
    self.var_7A8D.var_35A6 = spawnlinkedfx(var_01, self, "TAG_WW_MELEE_FX", 1);
    triggerfx(self.var_7A8D.var_35A6);
    lib_0378::func_8D74("aud_raven_sword_power_up");
  }

  while(common_scripts\utility::func_562E(self.var_7A8D.var_08BE)) {
    common_scripts\utility::func_A70A("weapon_given", "weapon_taken", "zombie_player_spawn_finished", "melee_weapon_change", "weapon_switch_started");
    wait 0.05;
    while(self method_833B()) {
      wait 0.05;
    }

    var_00 = self getcurrentweapon();
    if(var_00 == level.activeswordname && self.var_7A8D.var_08BE == 1) {
      var_01 = common_scripts\utility::func_44F5("zmb_sword_activate");
      self.var_7A8D.var_35A6 = spawnlinkedfx(var_01, self, "TAG_WW_MELEE_FX", 1);
      triggerfx(self.var_7A8D.var_35A6);
      lib_0378::func_8D74("aud_raven_sword_power_up");
      continue;
    }

    if(isDefined(self.var_7A8D.var_35A6)) {
      lib_0378::func_8D74("aud_raven_sword_power_dwn");
      self.var_7A8D.var_35A6 delete();
      self.var_7A8D.var_35A6 = undefined;
    }
  }
}

lib_057F::func_7A81() {
  self.var_7A8D.var_08BE = 0;
  var_00 = self getcurrentweapon();
  lib_0586::func_0790(level.activeswordname);
  lib_0586::func_078C("raven_sword_zm");
  if(issubstr(var_00, "raven_sword")) {
    self switchtoweaponimmediate("raven_sword_zm");
  }

  lib_0378::func_8D74("aud_raven_sword_power_dwn");
  if(isDefined(self.var_7A8D) && isDefined(self.var_7A8D.var_35A6)) {
    self.var_7A8D.var_35A6 delete();
    self.var_7A8D.var_35A6 = undefined;
  }
}

lib_057F::func_9E06(param_00) {
  if(!self.var_7A8D.var_08BE) {
    if(common_scripts\utility::func_562E(param_00)) {
      self.var_7A8D.var_5A50 = self.var_7A8D.var_5A50 + 10;
    } else {
      self.var_7A8D.var_5A50++;
    }

    if(self.var_7A8D.var_5A50 >= 20) {
      self.var_7A8D.var_20F0 = 12;
      self.var_7A8D.var_5A50 = 0;
      wait(0.45);
      lib_057F::func_7A80();
    }
  }
}

lib_057F::func_90F2(param_00) {
  self.var_7A8D.var_20F0 = self.var_7A8D.var_20F0 - param_00;
  if(self.var_7A8D.var_20F0 <= 0) {
    lib_057F::func_7A81();
  }
}

lib_057F::func_5FC5() {
  self endon("raven_sword_lost");
  for(;;) {
    self waittill("paired_heavy_melee_kill");
    if(self.var_7A8D.var_08BE) {
      lib_057F::func_90F2(4);
      thread lib_057F::func_9AB9();
      while(self method_8661()) {
        wait 0.05;
      }

      continue;
    }

    while(self method_8661()) {
      wait 0.05;
    }
  }
}

lib_057F::func_9AB9() {
  self endon("death");
  self endon("disconnect");
  self endon("touch_of_death_aoe_cleanup");
  var_00 = common_scripts\utility::func_44F5("zmb_raven_sword_touch_of_death_aoe");
  playFX(var_00, self.var_0116);
  self.var_7A8D.var_9AC4 = 1;
  var_01 = gettime();
  lib_0547::func_09E9(self, "touch_of_death_aoe");
  thread lib_057F::func_9ABA();
  while(gettime() < var_01 + 6000) {
    var_02 = lib_0547::func_408F();
    foreach(var_04 in function_01AC(var_02, self.var_0116, 100)) {
      var_05 = var_04.var_00BC;
      if(var_04 lib_0547::func_53DC()) {
        var_05 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), level.var_A980) * 0.1;
      }

      var_04 dodamage(var_05, self.var_0116, self, self, "MOD_MELEE", "raven_sword_tod_aoe_zm", "none");
      wait 0.05;
    }

    wait(0.5);
  }

  self notify("touch_of_death_aoe_complete");
}

lib_057F::func_9ABA() {
  common_scripts\utility::func_A70A("death", "disconnect", "touch_of_death_aoe_complete");
  lib_0547::func_7CF8(self, "touch_of_death_aoe");
  self.var_7A8D.var_9AC4 = 0;
  self notify("touch_of_death_aoe_cleanup");
}

lib_057F::func_5FC4() {
  self endon("raven_sword_lost");
  for(;;) {
    self waittill("melee_fired", var_00);
    if(issubstr(var_00, "raven_sword_zm") && self method_8661()) {
      wait(0.45);
      self.var_99FE = gettime();
      if(isDefined(self.var_9A00) && self.var_99FE > self.var_9A00 + 400) {
        lib_057F::func_2416();
      }

      self.var_9A00 = gettime();
      wait(0.3);
      while(self method_8661()) {
        wait 0.05;
      }
    }
  }
}

lib_057F::func_2416() {
  var_00 = 72;
  var_01 = 120;
  var_02 = 800;
  var_03 = 0.5;
  if(self.var_7A8D.var_08BE && !self.var_7A8D.var_9AC4) {
    lib_057F::func_90F2(2);
    var_00 = 109;
    var_01 = 120;
    var_02 = 1;
    var_03 = 5;
    var_04 = common_scripts\utility::func_44F5("zmb_raven_sword_burst");
    playFX(var_04, self.var_0116 + (0, 0, 40));
    lib_0378::func_8D74("aud_raven_sword_aoe");
  }

  var_05 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), level.var_A980);
  var_06 = int(var_02) + int(var_03 * var_05);
  var_07 = lib_0586::zombies_hit_by_melee_cone(var_00, var_01);
  foreach(var_09 in var_07) {
    var_09 dodamage(var_06, self getEye(), self, self, "MOD_MELEE", "raven_sword_cleave_zm", "none");
    if(isDefined(var_09.var_0A4B)) {
      var_0A = lib_0547::func_0A51(var_09.var_0A4B);
      if(isDefined(var_0A) && common_scripts\utility::func_562E(var_0A.knockbyravensword)) {
        if(var_0A.var_0A4B != "zombie_heavy" && self.var_7A8D.var_08BE) {
          lib_0547::func_7D1B(self, var_09, "close");
        } else {
          lib_0547::func_7D1B(self, var_09, "far");
        }
      }
    }

    wait 0.05;
  }
}

lib_057F::func_7A7C(param_00) {
  if(!self adsButtonPressed()) {
    return 0;
  }

  return 1;
}

lib_057F::func_7A7F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(param_01) && isPlayer(param_01) && param_01 lib_057F::func_4B3A()) {
    var_09 = getweapondisplayname(param_04);
    var_0A = 0;
    switch (var_09) {
      case "raven_sword_zm":
        if(common_scripts\utility::func_562E(self.var_0103)) {
          var_0A = 1;
        }

        break;

      case "raven_sword_cleave_zm":
        param_01 lib_057F::func_9E06(var_0A);
        break;
    }
  }
}