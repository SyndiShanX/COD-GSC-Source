/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\_boss_util.gsc
***************************************************************/

init() {
  _id_0547::_id_7BA9(::watch_for_final_boss_killed);
}

set_zombie_boss_has_weapon_loot() {
  maps\mp\_events_z::start_boss_battle_tracking();

  if(!isDefined(self.bossloot))
    self.bossloot = [];

  self.bossloot = common_scripts\utility::_id_0F6F(self.bossloot, ::spawn_zombie_boss_weapon_loot);
}

spawn_zombie_boss_weapon_loot(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = spawnStruct();
  var_2.origin = _func_2E1(var_0) + (0, 0, 24);
  var_3 = var_2 common_scripts\utility::_id_8FFC();
  var_3 _meth_805B();
  var_3 thread floaty();
  var_3.angles = var_3.angles + (30, 70, 0);
  var_3 setModel("zmb_balacc_01");
  var_4 = spawnStruct();
  var_4.origin = var_3.origin;
  var_5 = _id_0547::_id_8FBA(var_4, "zmb_ber_gun_cone_glow");
  _func_14C(var_5);
  var_5.origin = var_4.origin;

  foreach(var_7 in level.players) {
    var_3 _meth_8006(var_7);
    var_5 _meth_8006(var_7);
  }

  var_3 _meth_8005(var_1);
  var_3 _id_0378::_id_8D74("zmb_ballistic_aura");
  var_5 _meth_8005(var_1);
  wait_for_player_pickup_or_timeout(var_3, var_1);
  var_3 delete();
  level notify("aud_stop_ballistic_aura_snd");
  var_5 delete();
  var_9 = maps\mp\zombies\zombie_weapon_kits_shared::_id_4736();
  var_10 = [];

  foreach(var_12 in var_9) {
    if(issubstr(var_12, "shovel")) {
      continue;
    }
    if(!_id_0547::_id_5844(_id_0547::mp_to_zombies(maps\mp\_utility::_id_4431(var_12)))) {
      continue;
    }
    var_13 = var_1 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_12, "bossupgrade");

    if(!isDefined(var_13) || !var_13)
      var_10 = common_scripts\utility::_id_0F6F(var_10, var_12);
  }

  if(var_10.size > 0) {
    var_15 = common_scripts\utility::random(var_10);
    var_1 setplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_15, "bossupgrade", 1);
    var_1 setplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_15, "bossupgradebreadcrumb", 1);
    var_1 setplayerdata(common_scripts\utility::_id_46A8(), "getBossAttachmentLastMatch", 1);
    level thread show_reward_splash(var_1, var_15);
    maps\mp\zquests\dlc3_trophies_shattered_mode::complete_shattered_trophy_event_4(var_1, var_9, var_10);
  } else {
    if(!common_scripts\utility::_id_562E(level.zmb_red_skull_mode_activated)) {
      var_16 = "exp_bonus_shattered";
      var_17 = "dlc3_exp_ref_2";
    } else {
      var_16 = "exp_bonus_shattered_hc";
      var_17 = "dlc3_exp_ref_3";
    }

    _id_0555::_id_83DD("dlc3_ba_hint", var_1, var_16);
    _id_054D::giveplayersexp(var_17, var_1);
  }
}

floaty() {
  self endon("entitydeleted");
  self endon("death");
  self._id_6C53 = self.origin;
  waitframe();

  for(;;) {
    self _meth_82B1(self._id_6C53 + (0, 0, 3), 3, 1, 1);
    self _meth_82BA(180, 3);
    wait 3;
    self _meth_82B1(self._id_6C53 + (0, 0, -3), 3, 1, 1);
    self _meth_82BA(180, 3);
    wait 3;
  }
}

show_reward_splash(var_0, var_1) {
  var_0 endon("disconnect");
  _id_0555::_id_83DD("dlc3_ba_hint", var_0, var_1);
  wait 1;
  var_0 maps\mp\gametypes\_hud_message::_id_9102("zm_collectible_splash_11");
}

wait_for_player_pickup_or_timeout(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = 30;

  while(var_2 > 0 && distance(var_0.origin, var_1.origin) > 64) {
    var_2 = var_2 - 0.1;
    wait 0.1;
  }
}

watch_for_final_boss_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self.bossloot)) {
    return;
  }
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed_small");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::boss_defeated_bonus();

  foreach(var_10 in self.bossloot) {
    var_11 = 1;
    var_12 = 0;

    if(getdvarint("scr_testBossLootMTX", 0)) {
      var_11 = 5;
      var_12 = 5;
    }

    for(var_13 = 0; var_13 < var_11; var_13++)
      level thread maps\mp\_utility::_id_6F74(var_10, self.origin + (0, var_13 * 32, 0));

    if(var_12 > 0) {
      for(var_14 = 1; var_14 < var_12; var_14++) {
        for(var_13 = 0; var_13 < var_11; var_13++)
          level thread maps\mp\_utility::_id_6F74(var_10, self.origin + (var_14 * 32, var_13 * 32, 0));
      }
    }
  }

  maps\mp\_events_z::end_boss_battle_tracking();
}