/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_c.gsc
******************************************************************/

trial_c_init() {
  level.trial_c_zones = ["zone_crash_site", "zone_crash_site_west", "zone_crash_site_east_south"];
  level scripts\engine\utility::_id_5C04("trial_c_release_orb");
  level scripts\engine\utility::_id_5C04("obelisk_c_cursed_items_collected");
  level scripts\engine\utility::_id_5C04("trial_c_pickup_shield");
  level scripts\engine\utility::_id_5C04("shield_challenge_finished");
  level scripts\engine\utility::_id_5C04("mq_trial_c_done");
  init_curses_info();
  trial_c_kick_off();
}

trial_c_kick_off() {
  level thread handle_trial_c_flow();
}

trail_c_finalize() {
  scripts\engine\utility::_id_5C1B("mq_trial_c_done");
}

trial_c_init_clip() {
  trial_c_wall_block();
  trial_c_oblesik_clip();
  trial_c_syphoncore_clip();
  level.shield_clip = getent("mq_shield_clip", "script_noteworthy");

  if(isDefined(level.shield_clip)) {
    level.shield_clip notsolid();
    level.shield_clip _meth_8093();
  }

  level.fountain_clip = getent("trial_of_resilience_fountain_blocker", "script_noteworthy");

  if(isDefined(level.fountain_clip)) {
    level.fountain_clip notsolid();
    level.fountain_clip _meth_8093();
  }

  if(!getdvarint("#x3a165e78de6483fc8", 0)) {
    return;
  }
  if(!isDefined(level.e_crystal_hand)) {
    var_0 = scripts\engine\utility::getstruct("trial_of_resilience_crystalized_hand", "script_noteworthy");
    level.e_crystal_hand = scripts\cp\utility::_id_E190("s4_zm_crystalized_hand", var_0.origin, var_0.angles);
  }

  if(!isDefined(level.e_shield)) {
    var_1 = scripts\engine\utility::getstruct("trial_of_resilience_lock_shield", "script_noteworthy");
    level.e_shield = scripts\cp\utility::_id_E190("vm_shield_demonic_zm_closeeye_200", var_1.origin, var_1.angles);

    if(scripts\engine\utility::_id_608B("mq_trial_c_hand_idle")) {
      playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_hand_idle"), level.e_shield, "tag_riot_shield");
    }
  }
}

trial_c_wall_block(var_0) {
  var_1 = getEntArray("mq_trial_c_zone_barricade", "script_noteworthy");
  var_2 = getEntArray("mq_trial_c_path_clip", "script_noteworthy");

  if(istrue(var_0)) {
    scripts\engine\utility::_id_1B98(var_1, ::show);
    scripts\engine\utility::_id_1B98(var_2, ::solid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_80B5);
  } else {
    scripts\engine\utility::_id_1B98(var_1, ::hide);
    scripts\engine\utility::_id_1B98(var_2, ::notsolid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_8093);
  }
}

trial_c_oblesik_clip(var_0) {
  var_1 = getEntArray("trial_of_resilience_obelisk_clip", "script_noteworthy");

  if(istrue(var_0)) {
    scripts\engine\utility::_id_1B98(var_1, ::solid);
    scripts\engine\utility::_id_1B98(var_1, ::_meth_80B5);
  } else {
    scripts\engine\utility::_id_1B98(var_1, ::notsolid);
    scripts\engine\utility::_id_1B98(var_1, ::_meth_8093);
  }
}

trial_c_syphoncore_clip(var_0, var_1) {
  var_2 = var_1;

  if(!isDefined(var_2)) {
    var_2 = getEntArray("trial_of_resilience_syphoncore_clip", "script_noteworthy");
  }

  if(istrue(var_0)) {
    scripts\engine\utility::_id_1B98(var_2, ::solid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_80B5);
  } else {
    scripts\engine\utility::_id_1B98(var_2, ::notsolid);
    scripts\engine\utility::_id_1B98(var_2, ::_meth_8093);
  }
}

destroy_soul_crystal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("crystal") || var_0._id_CF22 != "trial_c_crystal") {
    return;
  }
  var_0 setscriptablepartstate("crystal", "destroyed");
  waitframe();

  if(istrue(var_0.b_imprison_orb)) {
    level scripts\engine\utility::_id_5C1B("trial_c_release_orb");
  }
}

handle_trial_c_flow() {
  level endon("game_ended");
  level endon("mq_trial_c_done");
  level endon("start_rbz_exfil");
  level.main_obelisk_c = scripts\engine\utility::getstruct("trial_of_resilience_obelisk", "script_noteworthy");

  if(!isDefined(level.main_obelisk_c)) {
    return;
  }
  if(!isDefined(level.main_obelisk_c.mdl)) {
    childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_obelisk_model(level.main_obelisk_c);
    trial_c_oblesik_clip(1);
  }

  if(!isDefined(level.e_crystal_hand)) {
    var_0 = scripts\engine\utility::getstruct("trial_of_resilience_crystalized_hand", "script_noteworthy");
    level.e_crystal_hand = scripts\cp\utility::_id_E190("s4_zm_crystalized_hand", var_0.origin, var_0.angles);
  } else
    level.e_crystal_hand setModel("s4_zm_crystalized_hand");

  if(!isDefined(level.e_shield)) {
    var_1 = scripts\engine\utility::getstruct("trial_of_resilience_lock_shield", "script_noteworthy");
    level.e_shield = scripts\cp\utility::_id_E190("vm_shield_demonic_zm_200", var_1.origin, var_1.angles);
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_hand_idle"), level.e_shield, "tag_riot_shield");
  } else
    level.e_shield setModel("vm_shield_demonic_zm_200");

  waitframe();
  level.e_shield _meth_82CB("s4_zm_shield_demonic_idle", "shield_idle");
  level.a_s_crystals = scripts\engine\utility::getStructArray("trial_of_resilience_red_crystal", "script_noteworthy");
  var_2 = level.a_s_crystals[randomint(level.a_s_crystals.size)];
  _id_07A1::_id_CEC7(::destroy_soul_crystal);

  foreach(var_4 in level.a_s_crystals) {
    if(!isDefined(var_4.crystal)) {
      var_5 = _func_03C5("s4_zm_dark_aether_crystal_a", var_4.origin, var_4.angles);
      var_5._id_CF22 = "trial_c_crystal";
      var_4.crystal = var_5;
    }

    var_4.crystal.b_imprison_orb = var_2 == var_4;
    var_4.crystal setscriptablepartstate("crystal", "idle");
  }

  for(var_7 = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones); var_7.size == 0; var_7 = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones)) {
    wait 3;
  }

  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(var_7, ["zm_cpm5_mqs5_dcmt_qiea", "zm_cpm5_mqs5_dcmt_qieb", "zm_cpm5_mqs5_vlst_qiec"]);
  level scripts\engine\utility::_id_5C24("trial_c_release_orb");
  level.yellow_orb = scripts\cp\utility::_id_E190("tag_origin", var_2.origin, var_2.angles);
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_orb_spawn"), level.yellow_orb, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_orb"), level.yellow_orb, "tag_origin");
  level.yellow_orb playSound("zmb_trail_orb_spawn");
  level.yellow_orb playLoopSound("zmb_trial_orb_lp");
  level.yellow_orb moveto(level.yellow_orb.origin + (0, 0, 50), 1, 0.5, 0.1);
  wait 1.2;
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), ["zm_cpm5_mqs5_krft_qied", "zm_cpm5_mqs5_vlst_qiee"], 1);
  var_8 = scripts\engine\utility::getstruct("orb_trial_c_loc", "script_noteworthy");
  var_9 = distance(var_8.origin, level.yellow_orb.origin) / 250;
  var_9 = max(0.7, var_9);
  level.yellow_orb moveto(var_8.origin, var_9, 0.5, 0.1);
  level.yellow_orb waittill("movedone");
  level.main_obelisk_c.origin = level.yellow_orb.origin;
  level.yellow_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), "zm_cpm5_mqs5_dcmt_qief");
  _id_0737::_id_C266("trial_of_resilience_obelisk", ::get_obelisk_c_hint_func, ::on_obelisk_c_activation_func, undefined, undefined, undefined, undefined, 1);
  _id_0737::_id_C266("trial_of_resilience_cursed_item", ::get_cursed_item_hint_func, ::on_cursed_item_activation_func, undefined, undefined, undefined, undefined, 1);
  level._id_8393["trial_of_resilience_obelisk"].hint_type_func = ::get_obelisk_c_hint_type_func;
  level.curse_item_names = [];
  level.curse_item_names["s4_zm_friesinger_hat"] = &"CP_ZM_OASIS/TRIAL_C_CURSE_ITEM_SOLDIERS_HAT";
  level.curse_item_names["s4_skull_01_bloody"] = &"CP_ZM_OASIS/TRIAL_C_CURSE_ITEM_SKULL";
  level.curse_item_names["femur_01"] = &"CP_ZM_OASIS/TRIAL_C_CURSE_ITEM_FEMUR";
  level.delivery_cursed = 0;
  var_10 = scripts\engine\utility::getStructArray("trial_of_resilience_cursed_item", "script_noteworthy");
  var_10 = scripts\engine\utility::array_randomize(var_10);
  var_11 = scripts\engine\utility::array_randomize(scripts\engine\utility::_id_1BD1(level.trial_c_curses));
  var_12 = 0;

  for(var_13 = 0; var_13 < var_10.size; var_13++) {
    if(var_13 < 3) {
      var_10[var_13]._id_4A88 = undefined;
      var_14 = var_12;

      for(;;) {
        var_15 = var_11[var_12];
        var_12 = (var_12 + 1) % var_11.size;

        if(!var_15.b_check_usable || scripts\engine\utility::is_equal(var_10[var_13]._id_CD99, var_15.name)) {
          var_10[var_13].curse_name = var_15.name;
          break;
        }

        if(var_14 == var_12) {
          break;
        }
      }

      var_10[var_13] childthread handle_cursed_item_pickup();
      continue;
    }

    if(isDefined(var_10[var_13].mdl)) {
      var_10[var_13].mdl delete();
    }

    var_10[var_13]._id_4A88 = 1;
  }

  level.yellow_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), scripts\engine\utility::random(["zm_cpm5_mqs5_dcmt_qieg", "zm_cpm5_mqs5_dcmt_qieh"]));
  level.yellow_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), scripts\engine\utility::random(["zm_cpm5_mqs5_dcmt_qiei", "zm_cpm5_mqs5_dcmt_qiej"]));
  level.yellow_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_narrations_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), scripts\engine\utility::random(["zm_cpm5_mqs5_dcmt_qiek", "zm_cpm5_mqs5_dcmt_qiel"]));
  level scripts\engine\utility::_id_5C24("obelisk_c_cursed_items_collected");
  level.curse_item_names = undefined;
  _id_0737::_id_C4AB("trial_of_resilience_cursed_item");
  _id_07A1::scriptable_removedamagecallback(::destroy_soul_crystal);
  var_9 = distance(level.e_shield.origin, level.yellow_orb.origin) / 250;
  var_9 = max(0.7, var_9);
  level.yellow_orb moveto(level.e_shield.origin + (0, 0, 120), var_9, 0.5, 0.1);
  level.yellow_orb waittill("movedone");
  wait 0.5;
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::obelisk_send_fx_trail(level.yellow_orb.origin, level.e_shield gettagorigin("tag_riot_shield"), "mq_trial_c_shield_charged", 500);
  scripts\cp\utility::_id_B8ED(level.yellow_orb.origin, "zmb_trial_zap_shield");
  stopFXOnTag(scripts\engine\utility::getfx("mq_trial_c_hand_idle"), level.e_shield, "tag_riot_shield");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_shield_active"), level.e_shield, "tag_riot_shield");
  level.e_crystal_hand setModel("s4_zm_crystalized_hand_dmg");
  scripts\cp\utility::_id_B8ED(level.e_crystal_hand.origin, "zmb_hand_shatter");
  level.e_shield _meth_82CB("s4_zm_shield_demonic_drop", "shield_drop");
  wait 0.7;
  level.main_obelisk_c.origin = level.main_obelisk_c.mdl.origin;
  var_9 = distance(level.main_obelisk_c.origin, level.yellow_orb.origin) / 250;
  var_9 = max(0.7, var_9);
  level.yellow_orb moveto(level.main_obelisk_c.origin + (0, 0, 120), var_9, 0.5, 0.1);
  wait 1.2;
  level.e_shield playSound("zmb_shield_drop");
  level.e_shield playSound("wpn_decimator_impact_npc");
  level.e_shield _meth_82CB("s4_zm_shield_demonic_idle", "shield_idle");
  playFX(scripts\engine\utility::getfx("mq_trial_c_shield_drop"), level.e_shield.origin);
  level.shield_clip solid();
  level.shield_clip _meth_80B5();

  foreach(var_17 in level.players) {
    if(!isPlayer(var_17)) {
      continue;
    }
    if(distance2dsquared(level.e_shield.origin, var_17.origin) <= 360000) {
      var_17 earthquakeforplayer(0.5, 1, var_17.origin, 100);
      var_17 _meth_827A("cp_zm_s2_mq_shield_rumble", var_17.origin);
    }
  }

  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), ["zm_cpm5_mqs5_dcmt_qifu", "zm_cpm5_mqs5_dcmt_qifv", "zm_cpm5_mqs5_dcmt_qifw", "zm_cpm5_mqs5_dcmt_qifx", "zm_cpm5_mqs5_dcmt_qify", "zm_cpm5_mqs5_dcmt_qifz"]);
  wait 3;
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_orb_charge"), level.yellow_orb, "tag_origin");
  level.yellow_orb playSound("zmb_trial_obelisk_lit_up");
  _id_0737::_id_C266("mq_shield_pick_up_trig", ::get_shield_hint_func, ::on_shield_activation_func, undefined, undefined, undefined, undefined, 1, undefined, undefined, 90);
}

handle_zombie_spawn_around_item() {
  self endon("delivery_cursed");
  var_0 = scripts\engine\utility::getStructArray(self._id_0481, "target");

  if(var_0.size == 0) {
    var_1 = _func_02AA(self.origin, 300, 20);

    foreach(var_3 in var_1) {
      var_4 = spawnStruct();
      var_4._id_CC9D = "spawn_ground";
      var_4._id_0481 = "spawnStruct";
      var_4.origin = var_3;
      var_0[var_0.size] = var_4;
    }
  }

  for(;;) {
    level scripts\engine\utility::_id_5C30("disallow_rbz_exfil");
    var_6 = 0;

    foreach(var_8 in level.players) {
      if(distancesquared(self.origin, var_8.origin) < 250000) {
        var_6 = 1;
        break;
      }
    }

    if(!var_6) {
      wait 0.5;
      continue;
    }

    childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("base", "enemy_base_zombie_cp", 1, 5, "leave_curse_item", var_0);
    childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", 5, 1, "leave_curse_item", var_0);

    while(var_6 && !level scripts\engine\utility::_id_5C00("disallow_rbz_exfil")) {
      var_6 = 0;

      foreach(var_8 in level.players) {
        if(distancesquared(self.origin, var_8.origin) < 250000) {
          var_6 = 1;
          break;
        }
      }

      wait 0.5;
    }

    self notify("leave_curse_item");

    while(!isDefined(self.mdl)) {
      wait 0.5;
    }
  }
}

handle_zombie_spawn_alone_path(var_0) {
  self endon("lose_curse_item");
  var_0 endon("death_or_disconnect");
  var_1 = scripts\engine\utility::getStructArray(self._id_0481, "target");
  childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("base", "enemy_base_zombie_cp", 0.5, 5, "leave_curse_item", var_1);
  childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", 5, 1, "leave_curse_item", var_1);

  while(distancesquared(self.origin, var_0.origin) < 250000) {
    wait 2;
  }

  self notify("leave_curse_item");
  var_2 = scripts\engine\utility::getStructArray("trial_c_spawner_along_route", "script_noteworthy");
  self.a_spawn_zombies = [];

  for(;;) {
    var_3 = [];
    var_4 = [];

    foreach(var_6 in var_2) {
      var_7 = distancesquared(var_6.origin, var_0.origin);
      var_8 = distancesquared(var_6.origin, level.yellow_orb.origin);
      var_9 = distancesquared(var_0.origin, level.yellow_orb.origin);

      if(var_7 < 1000000 && var_8 < var_9) {
        if(var_3.size < 1) {
          var_3[var_3.size] = var_6;
        } else if(var_4.size < 1) {
          var_4[var_4.size] = var_6;
        } else {
          break;
        }
      } else {}
    }

    if(var_3.size < 1) {
      wait 1;
      continue;
    }

    childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("base", "enemy_base_zombie_cp", 1, 5, "leave_curse_path", var_3);

    if(var_4.size > 0) {
      childthread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", 5, 1, "leave_curse_path", var_4);
    }

    wait 2;
    self notify("leave_curse_path");

    while(self.a_spawn_zombies.size > 10) {
      wait 1;
      self.a_spawn_zombies = scripts\engine\utility::_id_1BCA(self.a_spawn_zombies);
    }

    wait 1;
  }
}

handle_cursed_item_pickup() {
  level endon("obelisk_c_cursed_items_collected");

  if(scripts\engine\utility::is_equal(self._id_CE18, "requires_dig")) {
    if(isDefined(self.mdl)) {
      self.mdl delete();
    }

    if(isDefined(self._id_605B)) {
      self._id_605B delete();
    }

    self.mdl = scripts\cp\utility::_id_E190("s4_zm_dust_pile", self.origin, self.angles);
    self._id_605B = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
    self.b_digging_up = undefined;
    playFXOnTag(scripts\engine\utility::getfx("dig_site_dust_fx"), self._id_605B, "tag_origin");
    self waittill("digging_up");
    playFX(scripts\engine\utility::getfx("fx_dig_dust"), self.origin + (0, 0, 5), anglesToForward(self.angles + (0, 0, 90)));

    if(isDefined(self.mdl)) {
      self.mdl delete();
    }

    if(isDefined(self._id_605B)) {
      self._id_605B delete();
    }
  }

  for(;;) {
    level scripts\engine\utility::_id_5C30("disallow_rbz_exfil");
    self._id_4A88 = undefined;

    if(!isDefined(self.mdl)) {
      self.mdl = scripts\cp\utility::_id_E190(self._id_0481, self.origin, self.angles);
      self.mdl _meth_81B0("outline_depth_yellow_zm_wider");
    }

    if(!isDefined(self._id_605B)) {
      self._id_605B = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_cursed_item_spawn"), self._id_605B, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_cursed_item_idle"), self._id_605B, "tag_origin");
    }

    var_0 = scripts\engine\utility::_id_1088D(self, "pickup_cursed", level, "disallow_rbz_exfil");
    var_1 = var_0[0];

    if(isDefined(self.mdl)) {
      self.mdl delete();
    }

    if(isDefined(self._id_605B)) {
      self._id_605B delete();
    }

    self._id_4A88 = 1;

    if(!isPlayer(var_1)) {
      continue;
    }
    scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players([var_1], ["zm_cpm5_mqs5_vlst_qiem", "zm_cpm5_mqs5_vlst_qien", "zm_cpm5_mqs5_vlst_qieo", "zm_cpm5_mqs5_vlst_qiep", "zm_cpm5_mqs5_vlst_qieq", "zm_cpm5_mqs5_vlst_qier"]);
    var_1.curse_item_name = self._id_0481;
    active_curse(var_1, self.curse_name);
    childthread handle_zombie_spawn_alone_path(var_1);
    var_0 = scripts\engine\utility::_id_1088B(60, var_1, "death_or_disconnect", var_1, "last_stand", var_1, "delivery_cursed", level, "disallow_rbz_exfil");

    if(isDefined(var_1)) {
      var_1.curse_item_name = undefined;
      deactive_curse(var_1);
    }

    self notify("lose_curse_item");

    if(var_0 == "delivery_cursed") {
      self notify("delivery_cursed");
      level.delivery_cursed++;

      if(level.delivery_cursed >= 3) {
        scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players(scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::get_players_in_trial_zone(level.trial_c_zones), ["zm_cpm5_mqs5_vlst_qifg", "zm_cpm5_mqs5_vlst_qifh", "zm_cpm5_mqs5_vlst_qifi", "zm_cpm5_mqs5_vlst_qifj"]);
        level scripts\engine\utility::_id_5C1B("obelisk_c_cursed_items_collected");
      } else
        scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players([var_1], ["zm_cpm5_mqs5_dcmt_qifa", "zm_cpm5_mqs5_dcmt_qifb", "zm_cpm5_mqs5_dcmt_qifc", "zm_cpm5_mqs5_dcmt_qifd", "zm_cpm5_mqs5_dcmt_qife", "zm_cpm5_mqs5_dcmt_qiff"]);

      return;
    } else if(var_0 == "timeout")
      scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players([var_1], ["zm_cpm5_mqs5_dcmt_qies", "zm_cpm5_mqs5_dcmt_qiet", "zm_cpm5_mqs5_dcmt_qieu", "zm_cpm5_mqs5_dcmt_qiev", "zm_cpm5_mqs5_dcmt_qiew", "zm_cpm5_mqs5_dcmt_qiex"]);

    level waittill("round_complete");
  }
}

get_obelisk_c_hint_type_func(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("trial_c_pickup_shield") && !var_1 scripts\cp\utility::riotshield_hasweaponname("s4_me_rindigoww_mp")) {
    var_0._id_7D7E = 1;
    return "HINT_NOBUTTON";
  }

  var_0._id_7D7E = undefined;
  return "HINT_NOICON";
}

get_obelisk_c_hint_func(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  }

  if(level scripts\engine\utility::_id_5C00("trial_c_pickup_shield")) {
    if(var_1 scripts\cp\utility::riotshield_hasweaponname("s4_me_rindigoww_mp")) {
      return &"CP_ZM_OASIS/TRIAL_C_START_CHALLENGE";
    } else {
      return &"CP_ZM_OASIS/TRIAL_C_START_CHALLENGE_FAIL";
    }
  } else if(isDefined(var_1.active_curse)) {
    if(isDefined(var_1._id_8388) && isDefined(level.curse_item_names[var_1.curse_item_name])) {
      var_1._id_8388 _meth_8557(level.curse_item_names[var_1.curse_item_name]);
    }

    return &"CP_ZM_OASIS/TRIAL_C_DELIVERY_CURSED";
  } else
    return "";
}

on_obelisk_c_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand) || level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return;
  }
  if(level scripts\engine\utility::_id_5C00("trial_c_pickup_shield")) {
    if(!var_1 scripts\cp\utility::riotshield_hasweaponname("s4_me_rindigoww_mp")) {
      return;
    }
    _id_0746::_id_B8F1("zmb_obelisk_interact");
    _id_0737::_id_C3C5(var_0);
    var_2 = _id_0992::_id_106AF(var_1, 15, "shield challenge start failed");

    if(istrue(var_2)) {
      _id_0746::_id_B8F1("zmb_obelisk_activate");
      level thread shield_challenge_flow();
      return;
    }

    _id_0737::_id_1037(var_0);
    return;
  } else if(isDefined(var_1.active_curse)) {
    var_0.mdl playSound("zmb_trial_cursed_item_deliver");
    var_1 notify("delivery_cursed");
  }
}

get_cursed_item_hint_func(var_0, var_1) {
  if(scripts\engine\utility::is_equal(var_0._id_CE18, "requires_dig") && !istrue(var_0.b_digging_up)) {
    if(istrue(var_1.b_got_shovel)) {
      return &"CP_SKORPION/DIG_SOID";
    } else {
      return "";
    }
  }

  if(isDefined(var_1.active_curse)) {
    return &"CP_ZM_OASIS/TRIAL_C_PICKUP_CURSED_FAIL";
  } else if(!isDefined(var_1.activate_gauntlet)) {
    if(isDefined(var_1._id_8388) && isDefined(level.curse_item_names[var_0._id_0481])) {
      var_1._id_8388 _meth_8557(level.curse_item_names[var_0._id_0481]);
    }

    return &"CP_ZM_OASIS/TRIAL_C_PICKUP_CURSED";
  } else
    return "";
}

on_cursed_item_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand) || !isDefined(var_0.mdl)) {
    return;
  }
  if(scripts\engine\utility::is_equal(var_0._id_CE18, "requires_dig") && !istrue(var_0.b_digging_up)) {
    if(istrue(var_1.b_got_shovel)) {
      var_0.b_digging_up = 1;
      playsoundatpos(var_0.origin, "zmb_dig");
      var_0 notify("digging_up");
    }

    return;
  }

  if(!isDefined(var_1.active_curse) && !isDefined(var_1.activate_gauntlet)) {
    var_0.mdl playSound("zmb_trial_cursed_item_pickup");
    var_0 notify("pickup_cursed", var_1);
  }
}

get_shield_hint_func(var_0, var_1) {
  return &"CP_SKORPION/SHIELD_PICK_UP";
}

on_shield_activation_func(var_0, var_1) {
  if(!isDefined(level.e_shield)) {
    return;
  }
  var_2 = spawnStruct();
  var_2.player = var_1;
  var_2.origin = level.e_shield.origin;
  var_2.triggeringweapon = "s4_me_rindigoww_mp";
  _id_0932::drop_relevant_weapon(var_2);
  level.e_shield delete();
  level.shield_clip notsolid();
  level.shield_clip _meth_8093();
  var_1 playlocalsound("zmb_shield_pickup_plr");

  foreach(var_4 in level.players) {
    if(scripts\engine\utility::is_equal(var_4, var_1)) {
      continue;
    }
    var_4 playlocalsound("zmb_shield_pickup_npc");
  }

  var_1 giveweapon("s4_me_rindigoww_mp");
  var_1 switchtoweapon("s4_me_rindigoww_mp");
  level scripts\engine\utility::_id_5C1B("trial_c_pickup_shield");
  _id_0737::_id_C4AB("mq_shield_pick_up_trig");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players([var_1], "zm_wwds_wdrs_dcmt_wdpu");

  foreach(var_1 in level.players) {
    var_1 thread player_disconnect_drop_shield_watcher();
  }
}

player_disconnect_drop_shield_watcher() {
  level endon("game_ended");
  level endon("kortifex_die");
  self notify("player_disconnect_drop_shield_watcher_singleton");
  self endon("player_disconnect_drop_shield_watcher_singleton");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("death", "disconnect");

    if(!isDefined(self) && !_func_0458(self)) {
      return;
    }
    drop_shield_check(self);

    if(var_0 == "disconnect") {
      return;
    }
  }
}

drop_shield_check(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::riotshield_hasweaponname("s4_me_rindigoww_mp")) {
      var_1++;
    }
  }

  if(var_1 >= 1) {
    return;
  }
  var_5 = 0;

  if(_func_0107(var_0.weaponlist)) {
    foreach(var_7 in var_0.weaponlist) {
      if(isnullweapon(var_7)) {
        continue;
      }
      if(var_7.basename == "s4_me_rindigoww_mp") {
        var_5 = 1;
        break;
      }
    }
  }

  if(!var_5 && _func_0107(var_0._id_3D58)) {
    foreach(var_7 in var_0._id_3D58) {
      if(isnullweapon(var_7)) {
        continue;
      }
      if(var_7.basename == "s4_me_rindigoww_mp") {
        var_5 = 1;

        if(isDefined(var_0)) {
          var_0._id_3D58 = scripts\engine\utility::array_remove(var_0._id_3D58, var_7);
        }

        break;
      }
    }
  }

  if(!var_5) {
    return;
  }
  foreach(var_3 in level.players) {
    if(!scripts\engine\utility::is_equal(var_3, var_0)) {
      var_12 = scripts\cp\cp_weapon::buildweapon("s4_me_rindigoww_mp");
      _id_092E::_id_E24D(var_12, var_3.origin + (0, 0, 20) + anglesToForward(var_3.origin) * 5, var_3.angles, undefined, undefined, undefined, 1);
      return;
    }
  }

  return;
}

shield_challenge_flow() {
  level endon("game_ended");
  level endon("mq_trial_c_done");
  level endon("shield_challenge_finished");
  level thread watch_shield_challenge_finished();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players(level.players, ["zm_cpm5_mqs5_dcmt_qifk", "zm_cpm5_mqs5_dcmt_qifl", "zm_cpm5_mqs5_dcmt_qifm", "zm_cpm5_mqs5_dcmt_qifn", "zm_cpm5_mqs5_dcmt_qifo", "zm_cpm5_mqs5_dcmt_qifp"]);
  var_0 = scripts\engine\utility::getStructArray("mq_trial_c_teleport_loc", "script_noteworthy");
  var_1 = ["zone_crash_site", "zone_crash_site_west", "zone_crash_site_east_south"];

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = var_3 scripts\cp\zone_manager::_id_642F();

    if(isDefined(var_4) && scripts\engine\utility::array_contains(var_1, var_4.script_zone_name)) {
      var_3 thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::fadetowhite_for_specific_player(0.5);
      continue;
    }

    level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::trial_teleport_specific_player(var_0, var_3);
  }

  trial_c_wall_block(1);
  wait 0.5;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::pause_round_base_spawn();
  level.trial_c_fountain = scripts\engine\utility::getstruct("trial_of_resilience_fountain", "script_noteworthy");

  if(!isDefined(level.trial_c_fountain.mdl)) {
    level.trial_c_fountain.mdl = scripts\cp\utility::_id_E190("s4_zm_broken_demonic_fountain_revive", level.trial_c_fountain.origin, level.trial_c_fountain.angles);
    level.trial_c_blood_surface = scripts\cp\utility::_id_E190("tag_origin", level.trial_c_fountain.origin, level.trial_c_fountain.angles);
    level.fountain_clip solid();
    level.fountain_clip _meth_80B5();
    level.trial_c_blood_surface.n_max_height = level.trial_c_blood_surface.origin[2];
    level.trial_c_blood_surface.n_min_height = level.trial_c_blood_surface.origin[2] - 20;
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_fountain_surface"), level.trial_c_blood_surface, "tag_origin");
  }

  level.trial_c_fountain childthread watch_blood_fountain_fill();
  _id_0737::_id_C266("trial_of_resilience_fountain", ::get_resilience_fountain_hint_func, ::on_resilience_fountain_activation_func, undefined, undefined, undefined, undefined, 1, undefined, undefined, 90);

  while(isDefined(level.trial_teleporting_players_count) && level.trial_teleporting_players_count > 0) {
    wait 1;
  }

  wait 2;
  scripts\cp\zone_manager::set_zone_enabled("zone_merchant_road_east", 0);
  scripts\cp\zone_manager::set_zone_enabled("zone_merchant_road_south", 0);
  _id_0737::_id_C266("trial_of_resilience_syphoncore", ::get_resilience_syphoncore_hint_func, ::on_resilience_syphoncore_activation_func, undefined, undefined, undefined, undefined, 1);
  level._id_8393["trial_of_resilience_syphoncore"].hint_type_func = ::get_resilience_syphoncore_hint_type_func;
  var_6 = level.players.size;
  var_7 = var_6 + 2;
  var_8 = scripts\engine\utility::getStructArray("trial_of_resilience_syphoncore", "script_noteworthy");
  var_9 = [];
  level.a_trial_c_syphoncore = [];

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    var_8[var_10]._id_4A88 = 1;
    var_8[var_10].b_empty = undefined;

    if(var_10 < var_7) {
      var_8[var_10] childthread handle_syphoncore_instance();
      level.a_trial_c_syphoncore[var_10] = var_8[var_10];
      var_9[var_9.size] = getent(var_8[var_10].target, "targetname");
    }
  }

  trial_c_syphoncore_clip(1, var_9);
  level.main_obelisk_c.n_charged_count = 0;
  level.main_obelisk_c.n_charged_max = 10 * var_6;
  set_blood_surface_height(0);
  level.shield_charged_screen = loadfx("vfx/s4/zombie/vfx_screen_shield_hint.vfx");
  _id_06CB::_id_AA4A(::trial_c_killed_zombie_around_obelisk);
  var_11 = [2, 2, 2, 2];
  var_12 = [8, 12, 16, 20];
  var_13 = [5, 5, 3, 3];
  var_14 = [1, 2, 3, 4];
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("base", "enemy_base_zombie_cp", var_11[var_6 - 1], var_12[var_6 - 1], "shield_challenge_finished");
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", var_13[var_6 - 1], var_14[var_6 - 1], "shield_challenge_finished");
  _func_01E3("trial_battle");
  _id_0987::_id_3F28(150);
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::update_trial_timer_hud_position();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::create_trial_desc_hud(&"CP_ZM_OASIS/TRIAL_C_CHALLENGE_DESC");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players(level.players, ["zm_cpm5_mqs5_vlst_qifq", "zm_cpm5_mqs5_vlst_qifr", "zm_cpm5_mqs5_vlst_qifs", "zm_cpm5_mqs5_vlst_qift"]);
  wait 135;
  level.e_timer_sfx = spawn("script_origin", (0, 0, 0));
  level.e_timer_sfx playLoopSound("zmb_exfil_timer_countdown");
  level thread scripts\engine\utility::_id_982A("game_ended", level.e_timer_sfx);
  wait 15;
  level scripts\engine\utility::_id_5C1B("shield_challenge_finished");
}

get_resilience_fountain_hint_func(var_0, var_1) {
  if(istrue(var_1.b_carrying_chalice)) {
    return &"CP_ZM_OASIS/TRIAL_C_FILL_FOUNTAIN";
  } else {
    return "";
  }
}

on_resilience_fountain_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand) || !istrue(var_1.b_carrying_chalice)) {
    return;
  }
  var_1.b_carrying_chalice = undefined;
  var_1 notify("fill_fountain");
  var_0 notify("fill_fountain");
  var_0.mdl playSound("zmb_trial_fill_fountain");
}

get_resilience_syphoncore_hint_type_func(var_0, var_1) {
  if(istrue(var_0.b_empty) || istrue(var_1.b_carrying_chalice)) {
    var_0._id_7D7E = 1;
    return "HINT_NOBUTTON";
  }

  var_0._id_7D7E = undefined;
  return "HINT_NOICON";
}

get_resilience_syphoncore_hint_func(var_0, var_1) {
  if(istrue(var_0.b_empty)) {
    return &"CP_ZM_OASIS/TRIAL_C_SYPHONCORE_EMPTY";
  } else if(istrue(var_1.b_carrying_chalice)) {
    return &"CP_ZM_OASIS/TRIAL_C_FILL_CHALICE_FAIL";
  } else {
    return &"CP_ZM_OASIS/TRIAL_C_FILL_CHALICE";
  }
}

on_resilience_syphoncore_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand) || istrue(var_0.b_empty)) {
    return;
  }
  var_0.mdl playSound("zmb_trial_chalice_fill");
  var_0 thread handle_carrying_chalice(var_1);
}

handle_carrying_chalice(var_0) {
  level endon("game_ended");

  if(istrue(var_0.b_carrying_chalice)) {
    return;
  }
  var_0 giveweapon("s4_me_zm_main_quest_chalice");
  var_0 switchtoweapon("s4_me_zm_main_quest_chalice");
  self.b_empty = 1;
  var_0.b_carrying_chalice = 1;
  var_0 scripts\common\utility::_id_1581(0, "carrying_chalice");
  var_0 scripts\common\utility::_id_1554(0, "carrying_chalice");
  var_0 scripts\common\utility::_id_1553(0, "carrying_chalice");
  var_0 scripts\common\utility::_id_155E(0, "carrying_chalice");
  var_0 scripts\common\utility::_id_155F(0, "carrying_chalice");
  var_0 waittill("weapon_change");

  if(!isDefined(var_0.play_chalice_vo_next_time) || gettime() > var_0.play_chalice_vo_next_time) {
    var_0.play_chalice_vo_next_time = gettime() + 20000;
    scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players([var_0], ["zm_cpm5_mqs5_dcmt_qiga", "zm_cpm5_mqs5_dcmt_qigb", "zm_cpm5_mqs5_dcmt_qigc", "zm_cpm5_mqs5_dcmt_qigd", "zm_cpm5_mqs5_dcmt_qige", "zm_cpm5_mqs5_dcmt_qigf"]);
  }

  var_1 = scripts\engine\utility::_id_1088C(level, "shield_challenge_finished", level, "mq_trial_c_done", var_0, "death_or_disconnect", var_0, "weapon_change", var_0, "last_stand", var_0, "fill_fountain");

  if(var_1 != "fill_fountain") {
    self.b_empty = undefined;
  }

  if(isDefined(var_0)) {
    var_0.b_carrying_chalice = undefined;
    var_0 takeweapon("s4_me_zm_main_quest_chalice");
    var_0 _id_0777::_id_EC3C();
    var_0 scripts\common\utility::_id_1581(1, "carrying_chalice");
    var_0 scripts\common\utility::_id_1554(1, "carrying_chalice");
    var_0 scripts\common\utility::_id_1553(1, "carrying_chalice");
    var_0 scripts\common\utility::_id_155E(1, "carrying_chalice");
    var_0 scripts\common\utility::_id_155F(1, "carrying_chalice");

    if(isDefined(var_0._id_3D58)) {
      foreach(var_3 in var_0._id_3D58) {
        if(isnullweapon(var_3)) {
          continue;
        }
        if(var_3.basename == "s4_me_zm_main_quest_chalice") {
          var_0._id_3D58 = scripts\engine\utility::array_remove(var_0._id_3D58, var_3);
          break;
        }
      }
    }
  }
}

handle_syphoncore_instance() {
  if(!isDefined(self.mdl)) {
    self.mdl = scripts\cp\utility::_id_E190("zmb_syphoncore_wholebody_idle", self.origin, self.angles);
    self.mdl _meth_82CB("ai_s4_zm_zombie_syphoncore_idle_01");
    self.mdl playLoopSound("zmb_ritual_site_amb_lp");
    self.mdl setCanDamage(1);
    playFX(scripts\engine\utility::getfx("mq_trial_c_syphoncore_destroy"), self.mdl.origin + anglestoup(self.mdl.angles) * 50);
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_syphoncore_idle"), self.mdl, "tag_origin");

    foreach(var_1 in ["tag_fx_mouth_1", "tag_fx_mouth_2", "tag_fx_mouth_3"]) {
      playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_syphoncore_active"), self.mdl, var_1);
    }
  }

  for(;;) {
    self.mdl waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isPlayer(var_4)) {
      continue;
    }
    if(!isDefined(var_12) || var_12.basename != "s4_me_rindigoww_mp") {
      continue;
    }
    if(!isDefined(var_7) || var_7 != "MOD_EXPLOSIVE") {
      continue;
    }
    playFX(scripts\engine\utility::getfx("mq_trial_c_syphoncore_destroy"), self.mdl.origin + anglestoup(self.mdl.angles) * 50);
    self.mdl setModel("zmb_syphoncore_wholebody_damage");
    self.mdl stoploopsound();
    self.mdl setCanDamage(0);
    self.mdl playSound("zmb_trial_syphoncore_destroyed");
    wait 1;
    _func_0130(self.mdl);
    self._id_4A88 = undefined;
    return;
  }
}

set_blood_surface_height(var_0) {
  var_1 = level.trial_c_blood_surface;
  var_2 = level.a_trial_c_syphoncore.size;
  var_0 = clamp(var_0, 0, var_2);
  var_3 = (var_0 - var_2) * (var_1.n_max_height - var_1.n_min_height) / var_2 + var_1.n_max_height;
  var_3 = clamp(var_3, var_1.n_min_height, var_1.n_max_height);
  var_4 = (var_1.origin[0], var_1.origin[1], var_3);
  var_5 = distance(var_1.origin, var_4) / 10;

  if(var_5 > 0) {
    var_1 moveto(var_4, var_5, 0, 0);
  }
}

watch_blood_fountain_fill() {
  level.n_fill_fountain_count = 0;

  for(;;) {
    self waittill("fill_fountain");

    if(level.n_fill_fountain_count == 0) {
      playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_fountain_half"), self.mdl, "tag_origin");
    }

    level.n_fill_fountain_count++;
    set_blood_surface_height(level.n_fill_fountain_count);
    childthread play_blood_fountain_fill_fx();

    if(level.n_fill_fountain_count >= level.a_trial_c_syphoncore.size) {
      wait 2;
      level scripts\engine\utility::_id_5C1B("mq_trial_c_done");
      continue;
    }

    if(level.n_fill_fountain_count == 1) {
      scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::play_vo_to_players(level.players, ["zm_cpm5_mqs5_krft_qigg", "zm_cpm5_mqs5_krft_qigh", "zm_cpm5_mqs5_krft_qigi", "zm_cpm5_mqs5_krft_qigj", "zm_cpm5_mqs5_krft_qigk", "zm_cpm5_mqs5_krft_qigl"]);
    }
  }
}

play_blood_fountain_fill_fx() {
  self notify("play_blood_fountain_fill_fx_singleton");
  self endon("play_blood_fountain_fill_fx_singleton");
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_c_fountain_full"), self.mdl, "tag_origin");
  wait 1;
  stopFXOnTag(scripts\engine\utility::getfx("mq_trial_c_fountain_full"), self.mdl, "tag_origin");
}

watch_shield_challenge_finished() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
  level.disable_portal = 1;
  var_0 = level scripts\engine\utility::_id_10897("shield_challenge_finished", "mq_trial_c_done");
  level.disable_portal = undefined;
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  _func_01E3("none");

  if(isDefined(level.e_timer_sfx)) {
    level.e_timer_sfx delete();
  }

  level.shield_charged_screen = undefined;
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::clear_trial_desc_hud();
  _id_0987::_id_E8A5();
  scripts\cp\zone_manager::set_zone_enabled("zone_merchant_road_east", 1);
  scripts\cp\zone_manager::set_zone_enabled("zone_merchant_road_south", 1);
  _id_06CB::_id_C417(::trial_c_killed_zombie_around_obelisk);
  _id_0737::_id_C4AB("trial_of_resilience_fountain");
  _id_0737::_id_C4AB("trial_of_resilience_syphoncore");
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::fadetowhite(0.5);
  wait 0.5;
  var_1 = _id_06FE::_id_6322();

  foreach(var_3 in var_1) {
    var_3 _meth_81FA();
  }

  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  _id_0746::_id_B8F1("zmb_trial_clear_zombies");
  trial_c_wall_block(0);

  foreach(var_6 in level.a_trial_c_syphoncore) {
    if(isDefined(var_6.mdl)) {
      var_6.mdl delete();
    }
  }

  trial_c_syphoncore_clip();

  if(isDefined(level.trial_c_blood_surface)) {
    _func_0130(level.trial_c_blood_surface);
  }

  if(isDefined(level.trial_c_fountain.mdl)) {
    _func_0130(level.trial_c_fountain.mdl);
  }

  wait 0.3;

  if(isDefined(level.trial_c_blood_surface)) {
    level.trial_c_blood_surface delete();
  }

  if(isDefined(level.trial_c_fountain.mdl)) {
    level.trial_c_fountain.mdl delete();
  }

  level.fountain_clip notsolid();
  level.fountain_clip _meth_8093();

  if(var_0 == "shield_challenge_finished") {
    level waittill("round_complete");
    _id_0737::_id_1037(level.main_obelisk_c);
  } else {
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_obelisk_success"), level.main_obelisk_c.mdl, "tag_origin");
    level scripts\engine\utility::_id_5C1B("shield_challenge_finished");
    level.yellow_orb scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::give_challenge_complete_rewards();

    if(isDefined(level.yellow_orb)) {
      level.yellow_orb delete();
    }

    var_8 = [["zm_cpm5_mqs5_vlst_qigm", "zm_cpm5_mqs5_krft_qign"], ["zm_cpm5_mqs5_vlst_qigo", "zm_cpm5_mqs5_krft_qigp"], ["zm_cpm5_mqs5_vlst_qigq", "zm_cpm5_mqs5_krft_qigr"], ["zm_cpm5_mqs5_vlst_qigs", "zm_cpm5_mqs5_krft_qigt"]];
    level thread _id_0720::play_narrations(scripts\engine\utility::random(var_8), 1, 0, "force_quit_current_dialogue");
  }
}

trial_c_killed_zombie_around_obelisk(var_0) {
  var_1 = self.origin;

  if(self tagexists("j_spine4")) {
    var_1 = self gettagorigin("j_spine4");
  }

  if(distancesquared(level.main_obelisk_c.origin, self.origin) < 250000) {
    level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::obelisk_send_fx_trail(var_1, level.main_obelisk_c.origin + (0, 0, 48), "mq_trial_c_zombie_soul_trail", 600);
    level.main_obelisk_c.n_charged_count++;

    if(level.main_obelisk_c.n_charged_count >= level.main_obelisk_c.n_charged_max) {
      level.main_obelisk_c.n_charged_count = 0;

      foreach(var_3 in level.players) {
        if(!isDefined(var_3) || distancesquared(level.main_obelisk_c.origin, var_3.origin) > 250000) {
          continue;
        }
        if(var_3 scripts\cp\utility::riotshield_hasweaponname("s4_me_rindigoww_mp")) {
          playFXOnTag(scripts\engine\utility::getfx("mq_trial_obelisk_charged"), level.main_obelisk_c.mdl, "tag_origin");
          level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b::obelisk_send_fx_trail(level.main_obelisk_c.origin + (0, 0, 48), var_3 gettagorigin("j_spine4"), "mq_trial_c_shield_charged", 1000);
          var_3 notify("shield_charged");
        }
      }
    }
  }
}

init_curses_info() {
  if(isDefined(level.trial_c_curses)) {
    return;
  }
  level.trial_c_curses = [];
  register_curse("hip_fire_only", ::on_hip_fire_only_start_func, ::on_hip_fire_only_stop_func, &"CP_ZM_OASIS/TRIAL_C_CURSE_HIP_FIRE_ONLY");
  register_curse("no_health_regen", ::on_no_health_regen_start_func, ::on_no_health_regen_stop_func, &"CP_ZM_OASIS/TRIAL_C_CURSE_NO_HEALTH_REGEN");
  register_curse("damame_point_drain", ::on_damame_point_drain_start_func, ::on_damame_point_drain_stop_func, &"CP_ZM_OASIS/TRIAL_C_CURSE_DAMAME_POINT_DRAIN");
  register_curse("reload_disabled", ::on_reload_disabled_start_func, ::on_reload_disabled_stop_func, &"CP_ZM_OASIS/TRIAL_C_CURSE_RELOAD_DISABLED");
  register_curse("killing_damaged", ::on_killing_damaged_start_func, ::on_killing_damaged_stop_func, &"CP_ZM_OASIS/TRIAL_C_CURSE_KILLING_DAMAGED");
}

register_curse(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5._id_E5E6 = var_1;
  var_5._id_E89C = var_2;
  var_5.hint_text = var_3;
  var_5.b_check_usable = istrue(var_4);
  level.trial_c_curses[var_0] = var_5;
}

active_curse(var_0, var_1) {
  if(!isDefined(level.trial_c_curses) || !isDefined(level.trial_c_curses[var_1])) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_0.active_curse = var_1;
  var_0 notify("active_curse");
  _func_019D(scripts\engine\utility::getfx("mq_trial_c_cursed_item_screen"), var_0, "j_head", var_0);
  var_0 visionsetkillstreakforplayer("zm_kortifex_vision", 0.5);
  var_0 playlocalsound("zmb_trial_cursed_item_start");
  var_0 playLoopSound("zmb_trial_cursed_item_lp");
  var_0 thread deactive_curse_when_exfil_starts();
  var_0 scripts\common\utility::_id_1581(0, "trial_curse");
  var_0 show_cure_info(level.trial_c_curses[var_1].hint_text);
  [[level.trial_c_curses[var_1]._id_E5E6]](var_0);
}

deactive_curse(var_0) {
  if(!isPlayer(var_0) || !isDefined(var_0.active_curse)) {
    return;
  }
  if(!isDefined(level.trial_c_curses) || !isDefined(level.trial_c_curses[var_0.active_curse])) {
    return;
  }
  [[level.trial_c_curses[var_0.active_curse]._id_E89C]](var_0);
  var_0.active_curse = undefined;
  var_0 stoploopsound("zmb_trial_cursed_item_lp");
  var_0 playlocalsound("zmb_trial_cursed_item_stop");
  var_0 visionsetkillstreakforplayer("", 0.5);
  var_0 scripts\common\utility::_id_1581(1, "trial_curse");
  _func_02D1(scripts\engine\utility::getfx("mq_trial_c_cursed_item_screen"), var_0, "j_head", var_0);

  if(isDefined(var_0.curse_hint)) {
    var_0.curse_hint scripts\cp\utility::destroyelem();
  }

  var_0 notify("deactive_curse");
}

deactive_curse_when_exfil_starts() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("deactive_curse");
  level waittill("start_rbz_exfil");
  deactive_curse(self);
}

show_cure_info(var_0) {
  if(isDefined(self.curse_hint)) {
    self.curse_hint scripts\cp\utility::destroyelem();
  }

  self.curse_hint = scripts\cp\utility::createfontstring("default", 1);
  self.curse_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
  self.curse_hint.color = (1, 1, 1);
  self.curse_hint settext(var_0);
  self.curse_hint fadeovertime(1);
  self.curse_hint.alpha = 1;
}

on_hip_fire_only_start_func(var_0) {
  var_0 scripts\common\utility::_id_151F(0, "trial_curse");
}

on_hip_fire_only_stop_func(var_0) {
  var_0 scripts\common\utility::_id_151F(1, "trial_curse");
}

on_sprint_disabled_start_func(var_0) {
  var_0 scripts\common\utility::_id_1581(0, "trial_curse");
}

on_sprint_disabled_stop_func(var_0) {
  var_0 scripts\common\utility::_id_1581(1, "trial_curse");
}

on_no_health_regen_start_func(var_0) {
  var_0 _id_0946::_id_D299("nerf_fragile", 30);
}

on_no_health_regen_stop_func(var_0) {
  var_0 _id_0946::_id_D299("nerf_fragile", 1);
  var_0 notify("force_regeneration");
}

on_damame_point_drain_start_func(var_0) {
  var_0.b_drain_when_killing = 1;
  _id_06CB::_id_AA4A(::on_ai_killed_player_curse);
}

on_damame_point_drain_stop_func(var_0) {
  var_0.b_drain_when_killing = undefined;
  _id_06CB::_id_AA4A(::on_ai_killed_player_curse);
}

on_reload_disabled_start_func(var_0) {
  var_0 scripts\common\utility::_id_1575(0, "trial_curse");
  var_0 scripts\common\utility::_id_1525(0, "trial_curse");
}

on_reload_disabled_stop_func(var_0) {
  var_0 scripts\common\utility::_id_1575(1, "trial_curse");
  var_0 scripts\common\utility::_id_1525(1, "trial_curse");
}

on_primary_weapon_disabled_start_func(var_0) {}

on_primary_weapon_disabled_stop_func(var_0) {}

on_killing_damaged_start_func(var_0) {
  var_0.b_damage_when_killing = 1;
  _id_06CB::_id_AA4A(::on_ai_killed_player_curse);
}

on_killing_damaged_stop_func(var_0) {
  var_0.b_damage_when_killing = undefined;
  _id_06CB::_id_C417(::on_ai_killed_player_curse);
}

on_ai_killed_player_curse(var_0) {
  if(!isPlayer(var_0._id_50FF)) {
    return;
  }
  if(istrue(var_0._id_50FF.b_damage_when_killing)) {
    var_0._id_50FF dodamage(10, var_0._id_50FF.origin);
  }

  if(istrue(var_0._id_50FF.b_drain_when_killing)) {
    var_0._id_50FF _id_074E::_id_ED93(100, 1, "trial_curse");
  }
}