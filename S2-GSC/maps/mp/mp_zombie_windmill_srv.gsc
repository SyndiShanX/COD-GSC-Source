/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_srv.gsc
**********************************************/

func_00F9() {
  maps\mp\mp_zombie_windmill_srv_precache::func_F9();
  maps\createart\mp_zombie_windmill_srv_art::func_F9();
  maps\mp\mp_zombie_windmill_srv_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_zombie_windmill_lighting::func_F9();
  maps\mp\mp_zombie_windmill_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_windmill_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_AC2E = 5;
  level.var_ABD3 = -3500;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.sg_pack_use_small_radius = 1;
  level.var_AC71 = ::initwindmillweapons;
  level.var_783F = 0;
  level.door_data_out_of_date = 0;
  level.disable_jumpscare_playerdata = 0;
  level.var_6BB0 = ::onwindmillstartgame;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_05";
  level.pap_camo_ref_override = "zom_frontline_01";
  level.var_ACA3 = 1;
  level.var_C11 = 0;
  common_scripts\utility::func_3C87("power_sz2");
  func_5375();
  maps\mp\zombies\zombie_survival_common::func_D5();
  thread maps\mp\mp_zombie_windmill_util::windmill_think();
  thread windmill_srv_ee();
  level thread add_windmill_ceiling_patch();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::func_D5();
  level.upgrade_machine_upgrade_func = ::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initwindmillweapons() {
  level.sworddelivery_checkradius = 128;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
}

add_windmill_ceiling_patch() {
  var_00 = common_scripts\utility::func_46B7("ceiling_stuff_patches_05", "targetname");
  var_01 = common_scripts\utility::func_46B7("ceiling_stuff_patches_04", "targetname");
  foreach(var_03 in var_00) {
    var_04 = spawn("script_model", var_03.var_116);
    var_04.var_1D = var_03.var_1D;
    var_04 setModel("cob_floor_dmg_section_wood_05");
  }

  foreach(var_03 in var_01) {
    var_04 = spawn("script_model", var_03.var_116);
    var_04.var_1D = var_03.var_1D;
    var_04 setModel("cob_floor_dmg_section_wood_04");
  }
}

func_5375() {
  lib_055A::func_D5();
  lib_055A::func_530A("zone_plaza", 1);
  lib_055A::func_88A();
  thread house_door_listener();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::func_D5();
  maps\mp\zombies\zombie_survival_common::srv_init_miniboss_rounds();
}

house_door_listener() {
  common_scripts\utility::func_3C87("zone_plaza_to_zone_house");
  common_scripts\utility::func_3C9F("zone_plaza_to_zone_house");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "zone_plaza_to_zone_house" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

onwindmillstartgame() {
  level.roundstartfuncgeneric = ::windmill_srv_round_start;
  level.roundendfuncgeneric = ::windmill_srv_round_end;
}

windmill_srv_round_start() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundstart();
}

windmill_srv_round_end() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundend();
}

windmill_srv_ee() {
  level.ducks_per_window = 1;
  var_00 = 5;
  var_01 = getEntArray("hunt_ee", "targetname");
  var_02 = getent("dog_ee", "targetname");
  var_02 setModel("zmw_tinker_toy_set_02");
  foreach(var_04 in var_01) {
    var_04 setModel("zmw_belongings_toy_duck_01");
  }

  var_02.target_struct = common_scripts\utility::func_46B5(var_02.var_1A2, "targetname");
  var_02.var_926A = var_02.var_116;
  var_02.raised_position = var_02.target_struct.var_116;
  var_02.is_dog = 1;
  var_06 = getent("srv_pap_fuse_spawn_loc", "targetname");
  var_06 linkto(var_02);
  var_07 = getent("srv_pap_fuse_pickup_trig", "targetname");
  var_07 common_scripts\utility::func_9D9F();
  foreach(var_04 in var_01) {
    var_04.var_926A = var_04.var_116;
    var_04.var_931A = "lowered";
    var_04.target_struct = common_scripts\utility::func_46B5(var_04.var_1A2, "targetname");
    var_04.raised_position = var_04.target_struct.var_116;
    var_04.var_29B5 = ::ee_dmg_listen;
  }

  var_0A = 0;
  for(;;) {
    var_0B = common_scripts\utility::func_7A33(var_01);
    var_0B.is_starter = 1;
    var_0B thread ee_raise();
    level waittill("ee_started", var_0C);
    level.ee_contestant = var_0C;
    level.ducks_per_window = 1;
    var_00 = 5;
    var_0D = 0;
    for(;;) {
      var_0D++;
      var_0E = [];
      var_0F = undefined;
      var_10 = var_01;
      if(var_0D == 1) {
        var_10 = common_scripts\utility::func_F93(var_10, var_0B);
      }

      level.ducks_killed_in_window = 0;
      while(var_0E.size < level.ducks_per_window) {
        var_0F = common_scripts\utility::func_7A33(var_10);
        if(lib_0547::func_5565(var_0F.var_931A, "lowered")) {
          var_10 = common_scripts\utility::func_F93(var_10, var_0F);
          var_0E = common_scripts\utility::func_F6F(var_0E, var_0F);
          continue;
        }

        wait 0.05;
      }

      foreach(var_04 in var_0E) {
        var_04 thread ee_raise();
      }

      level common_scripts\utility::func_A74B("all_ducks_in_window_killed", var_00);
      if(level.ducks_killed_in_window >= level.ducks_per_window) {
        if(var_0D == 3 || var_0D == 5) {
          level.ducks_per_window++;
          var_00 = var_00 + 5;
          wait(3);
        } else if(var_0D == 8) {
          var_0A = 1;
          break;
        }

        continue;
      }

      foreach(var_04 in var_0E) {
        var_04 thread ee_lower();
      }

      var_02 ee_show_dog_fail();
      level waittill("zombie_wave_started");
      var_0A = 0;
      break;
    }

    if(var_0A) {
      break;
    }
  }

  var_02 ee_show_dog_success(var_06);
}

ee_show_dog_fail() {
  self moveto(self.raised_position, 1, 0.1, 0.1);
  wait(1);
  self vibrate(anglestoright(self.var_1D), 0.3, 0.3, 5);
  wait(5);
  self moveto(self.var_926A, 3, 0.1, 0.1);
  wait(3);
  self moveto(self.var_926A + (0, 0, 15), 0.25, 0.1, 0.1);
  wait(4);
  self moveto(self.var_926A, 3, 0.1, 0.1);
  wait(3);
}

ee_show_dog_success(param_00) {
  self moveto(self.raised_position, 1, 0.1, 0.1);
  wait(2);
  param_00 unlink();
  param_00 thread ee_toss_fuse();
  wait(1);
  self moveto(self.var_926A, 1);
}

ee_toss_fuse() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B5("srv_pap_fuse_land_path", "targetname");
  var_00 moveto(var_01.var_116, 0.15);
  var_02 = common_scripts\utility::func_46B5(var_01.var_1A2, "targetname");
  wait(0.15);
  while(isDefined(var_02)) {
    var_00 moveto(var_02.var_116, 0.15);
    if(isDefined(var_02.var_1A2)) {
      var_02 = common_scripts\utility::func_46B5(var_02.var_1A2, "targetname");
      continue;
    }

    var_02 = undefined;
    wait(0.15);
  }

  var_03 = getent("srv_pap_fuse_pickup_trig", "targetname");
  var_03 common_scripts\utility::func_9DA3();
  var_03 usetriggerrequirelookat(1);
  var_03 waittill("trigger");
  var_00 delete();
  var_03 common_scripts\utility::func_9D9F();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}

ee_raise(param_00) {
  if(!lib_0547::func_5565(self.var_931A, "lowered")) {
    return;
  }

  self setCanDamage(1);
  self setdamagecallbackon(1);
  self.var_552B = 1;
  self.var_931A = "raising";
  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  if(param_00 <= 0) {
    self.var_116 = self.raised_position;
  } else {
    self moveto(self.raised_position, param_00, 0.1, 0.1);
    wait(param_00);
  }

  self.var_931A = "raised";
}

ee_lower(param_00, param_01) {
  if(!lib_0547::func_5565(self.var_931A, "raised")) {
    return;
  }

  self.var_931A = "lowering";
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(common_scripts\utility::func_562E(param_01)) {
    self setCanDamage(0);
    self setdamagecallbackon(0);
    self.var_552B = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  self moveto(self.var_926A, param_00, 0.1, 0.1);
  wait(param_00);
  if(!common_scripts\utility::func_562E(param_01)) {
    self setCanDamage(0);
    self setdamagecallbackon(0);
    self.var_552B = 0;
  }

  self.is_starter = 0;
  self.var_931A = "lowered";
}

ee_dmg_listen(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(lib_0547::func_5565(param_04, "MOD_EXPLOSIVE") || lib_0547::func_5565(param_04, "MOD_EXPLOSIVE_BULLET")) {
    return;
  }

  if(!common_scripts\utility::func_562E(self.var_552B)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(isDefined(level.ee_contestant) && param_01 != level.ee_contestant) {
    return;
  }

  if(common_scripts\utility::func_562E(self.is_starter)) {
    level notify("ee_started", param_01);
    thread ee_lower(undefined, 1);
    return;
  }

  if(common_scripts\utility::func_562E(self.is_dog)) {
    return;
  }

  level notify("duck_killed", param_01);
  thread ee_lower(undefined, 1);
  level.ducks_killed_in_window++;
  if(level.ducks_killed_in_window >= level.ducks_per_window) {
    level notify("all_ducks_in_window_killed");
  }
}