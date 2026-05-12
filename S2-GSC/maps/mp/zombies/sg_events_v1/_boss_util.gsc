/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\_boss_util.gsc
*******************************************************/

func_00D5() {
  lib_0547::func_7BA9(::watch_for_final_boss_killed);
}

set_zombie_boss_has_weapon_loot() {
  maps\mp\_events_z::start_boss_battle_tracking();
  if(!isDefined(self.bossloot)) {
    self.bossloot = [];
  }

  self.bossloot = common_scripts\utility::func_F6F(self.bossloot, ::spawn_zombie_boss_weapon_loot);
}

spawn_zombie_boss_weapon_loot(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = spawnStruct();
  var_02.var_116 = getclosestpointonnavmesh(param_00) + (0, 0, 24);
  var_03 = var_02 common_scripts\utility::func_8FFC();
  var_03 method_805B();
  var_03 thread floaty();
  var_03.var_1D = var_03.var_1D + (30, 70, 0);
  var_03 setModel("zmb_balacc_01");
  var_04 = spawnStruct();
  var_04.var_116 = var_03.var_116;
  var_05 = lib_0547::func_8FBA(var_04, "zmb_ber_gun_cone_glow");
  triggerfx(var_05);
  var_05.var_116 = var_04.var_116;
  foreach(var_07 in level.var_744A) {
    var_03 hidefromclient(var_07);
    var_05 hidefromclient(var_07);
  }

  var_03 showtoclient(var_01);
  var_03 lib_0378::func_8D74("zmb_ballistic_aura");
  var_05 showtoclient(var_01);
  wait_for_player_pickup_or_timeout(var_03, var_01);
  var_03 delete();
  level notify("aud_stop_ballistic_aura_snd");
  var_05 delete();
  var_09 = maps\mp\zombies\zombie_weapon_kits_shared::func_4736();
  var_0A = [];
  foreach(var_0C in var_09) {
    if(issubstr(var_0C, "shovel")) {
      continue;
    }

    if(!lib_0547::func_5844(lib_0547::mp_to_zombies(maps\mp\_utility::func_4431(var_0C)))) {
      continue;
    }

    var_0D = var_01 getrankedplayerdata(common_scripts\utility::func_46A8(), "weaponBuildKits", var_0C, "bossupgrade");
    if(!isDefined(var_0D) || !var_0D) {
      var_0A = common_scripts\utility::func_F6F(var_0A, var_0C);
    }
  }

  if(var_0A.size > 0) {
    var_0F = common_scripts\utility::func_7A33(var_0A);
    var_01 setrankedplayerdata(common_scripts\utility::func_46A8(), "weaponBuildKits", var_0F, "bossupgrade", 1);
    var_01 setrankedplayerdata(common_scripts\utility::func_46A8(), "weaponBuildKits", var_0F, "bossupgradebreadcrumb", 1);
    var_01 setrankedplayerdata(common_scripts\utility::func_46A8(), "getBossAttachmentLastMatch", 1);
    level thread show_reward_splash(var_01, var_0F);
    maps\mp\zquests\dlc3_trophies_shattered_mode::complete_shattered_trophy_event_4(var_01, var_09, var_0A);
    return;
  }

  if(!common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated)) {
    var_10 = "exp_bonus_shattered";
    var_11 = "dlc3_exp_ref_2";
  } else {
    var_10 = "exp_bonus_shattered_hc";
    var_11 = "dlc3_exp_ref_3";
  }

  lib_0555::func_83DD("dlc3_ba_hint", var_01, var_10);
  lib_054D::giveplayersexp(var_11, var_01);
}

floaty() {
  self endon("entitydeleted");
  self endon("death");
  self.var_6C53 = self.var_116;
  wait 0.05;
  for(;;) {
    self moveto(self.var_6C53 + (0, 0, 3), 3, 1, 1);
    self rotateyaw(180, 3);
    wait(3);
    self moveto(self.var_6C53 + (0, 0, -3), 3, 1, 1);
    self rotateyaw(180, 3);
    wait(3);
  }
}

show_reward_splash(param_00, param_01) {
  param_00 endon("disconnect");
  lib_0555::func_83DD("dlc3_ba_hint", param_00, param_01);
  wait(1);
  param_00 maps\mp\gametypes\_hud_message::func_9102("zm_collectible_splash_11");
}

wait_for_player_pickup_or_timeout(param_00, param_01) {
  param_01 endon("disconnect");
  var_02 = 30;
  while(var_02 > 0 && distance(param_00.var_116, param_01.var_116) > 64) {
    var_02 = var_02 - 0.1;
    wait(0.1);
  }
}

watch_for_final_boss_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(self.bossloot)) {
    return;
  }

  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed_small");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::boss_defeated_bonus();
  foreach(var_0A in self.bossloot) {
    var_0B = 1;
    var_0C = 0;
    if(getdvarint("scr_testBossLootMTX", 0)) {
      var_0B = 5;
      var_0C = 5;
    }

    for(var_0D = 0; var_0D < var_0B; var_0D++) {
      level thread maps\mp\_utility::func_6F74(var_0A, self.var_116 + (0, var_0D * 32, 0));
    }

    if(var_0C > 0) {
      for(var_0E = 1; var_0E < var_0C; var_0E++) {
        for(var_0D = 0; var_0D < var_0B; var_0D++) {
          level thread maps\mp\_utility::func_6F74(var_0A, self.var_116 + (var_0E * 32, var_0D * 32, 0));
        }
      }
    }
  }

  maps\mp\_events_z::end_boss_battle_tracking();
}