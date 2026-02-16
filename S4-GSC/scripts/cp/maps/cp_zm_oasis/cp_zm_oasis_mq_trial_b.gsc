/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_trial_b.gsc
******************************************************************/

trial_b_init() {
  level.trial_b_zones = ["zone_train_north", "zone_train_west", "zone_train_south"];
  level scripts\engine\utility::_id_5C04("trial_b_all_torches_lighting");
  level scripts\engine\utility::_id_5C04("obelisk_b_sacrifice_finished");
  level scripts\engine\utility::_id_5C04("obelisk_b_charged");
  level scripts\engine\utility::_id_5C04("ring_of_fire_challenge_finished");
  level scripts\engine\utility::_id_5C04("mq_trial_b_done");
  trial_b_kick_off();
}

trial_b_kick_off() {
  level thread handle_trial_b_flow();
}

trail_b_finalize() {
  scripts\engine\utility::_id_5C1B("mq_trial_b_done");
}

trial_b_init_clip() {
  trial_b_wall_block();
  var_0 = getEntArray("mq_trial_b_obelisk_clip", "script_noteworthy");
  scripts\engine\utility::_id_1B98(var_0, ::notsolid);
  scripts\engine\utility::_id_1B98(var_0, ::_meth_8093);
}

trial_b_wall_block(var_0) {
  var_1 = getEntArray("mq_trial_b_zone_barricade", "script_noteworthy");
  var_2 = getEntArray("mq_trial_b_path_clip", "script_noteworthy");

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

get_players_in_trial_zone(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || isDefined(var_3.active_curse) || isDefined(var_3.activate_gauntlet)) {
      continue;
    }
    var_4 = var_3 scripts\cp\zone_manager::_id_642F();

    if(isDefined(var_4) && scripts\engine\utility::array_contains(var_0, var_4.script_zone_name)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

play_trial_vo_to_player(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(_func_0107(var_0)) {
    var_0 = scripts\engine\utility::random(var_0);
  }

  if(isDefined(self.trial_vo_list)) {
    if(!istrue(var_1)) {
      self.trial_vo_list[self.trial_vo_list.size] = var_0;
    }

    return;
  }

  self.trial_vo_list = [var_0];

  if(istrue(level._id_493C)) {
    level _id_0720::waittill_dialogue_finished();
  }

  if(isDefined(self._id_4169) && self._id_4169 != "") {
    self waittill("dialogue_finished");
  }

  while(self.trial_vo_list.size > 0) {
    var_0 = self.trial_vo_list[0];
    var_2 = _id_0720::get_portrait_index(strtok(var_0, "_")[3]);
    self setclientomnvar("ui_zm_comms", var_2);
    _id_0720::_id_B309(self, var_0);
    self setclientomnvar("ui_zm_comms", -1);
    self.trial_vo_list = scripts\engine\utility::array_remove_index(self.trial_vo_list, 0);
  }

  self.trial_vo_list = undefined;
  self notify("trial_vo_finished");
}

play_vo_to_players(var_0, var_1, var_2) {
  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_4 thread play_trial_vo_to_player(var_1, var_2);
    }
  }
}

play_narrations_to_player(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_3 in var_0) {
    thread play_trial_vo_to_player(var_3, var_1.b_skip_when_playing);
  }

  self waittill("trial_vo_finished");
  var_1.n_finished++;
}

play_narrations_to_players(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = spawnStruct();
  var_3.n_finished = 0;
  var_3.b_skip_when_playing = var_2;

  foreach(var_5 in var_0) {
    if(isDefined(var_5)) {
      var_5 thread play_narrations_to_player(var_1, var_3);
    }
  }

  var_7 = 60;

  while(var_3.n_finished < var_0.size && var_7 > 0) {
    var_0 = scripts\engine\utility::_id_1BD1(var_0);
    var_7--;
    wait 1;
  }
}

handle_lighting_torche() {
  level endon("game_ended");
  level endon("mq_trial_b_done");
  level endon("trial_b_all_torches_lighting");

  if(!isDefined(self.mdl)) {
    self.mdl = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
    waitframe();
  }

  for(;;) {
    self.mdl stoploopsound();
    stopFXOnTag(scripts\engine\utility::getfx("mq_trial_b_torch"), self.mdl, "tag_origin");
    self waittill("lighting_torch", var_0);
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_torch"), self.mdl, "tag_origin");
    self.mdl playLoopSound("zmb_trial_amb_torch");

    if(!istrue(level.b_trial_b_torch_vo_played) && isDefined(var_0)) {
      level.b_trial_b_torch_vo_played = 1;
      play_vo_to_players([var_0], ["zm_cpm5_mqs5_dnvk_qihc", "zm_cpm5_mqs5_dnvk_qihd", "zm_cpm5_mqs5_dnvk_qihe", "zm_cpm5_mqs5_dnvk_qihf"], 1);
    }

    level.lighting_torches++;

    if(level.lighting_torches >= level.a_torches.size) {
      level.last_torch = self;
      level scripts\engine\utility::_id_5C1B("trial_b_all_torches_lighting");
      break;
    }

    wait 20;
    level.lighting_torches--;
    wait 0.2;
  }
}

molotov_use_check() {
  level endon("trial_b_all_torches_lighting");

  for(;;) {
    level waittill("grenade_exploded_during_stealth", var_0);

    if(isDefined(var_0) && (scripts\engine\utility::is_equal(var_0.weapon_name, "s4_molotov_zm") || scripts\engine\utility::is_equal(var_0.weapon_name, "s4_thermite_zm"))) {
      foreach(var_2 in level.a_torches) {
        if(distance2d(var_0.origin, var_2.origin) < 70) {
          var_2 notify("lighting_torch", var_0.owner);
        }
      }
    }

    waitframe();
  }
}

trial_b_intro_vo() {
  for(var_0 = get_players_in_trial_zone(level.trial_b_zones); var_0.size == 0; var_0 = get_players_in_trial_zone(level.trial_b_zones)) {
    wait 3;
  }

  level play_narrations_to_players(var_0, ["zm_cpm5_mqs5_dnvk_qiha"]);

  if(!level scripts\engine\utility::_id_5C00("trial_b_all_torches_lighting")) {
    level play_narrations_to_players(var_0, ["zm_cpm5_mqs5_vlst_qihb"]);
  }
}

handle_trial_b_flow() {
  level endon("game_ended");
  level endon("mq_trial_b_done");
  level endon("start_rbz_exfil");
  level.main_obelisk_b = scripts\engine\utility::getstruct("mq_main_obelisk", "script_noteworthy");

  if(!isDefined(level.main_obelisk_b.mdl)) {
    childthread spawn_obelisk_model(level.main_obelisk_b);
    var_0 = scripts\engine\utility::getStructArray("mq_trial_b_torch", "script_noteworthy");

    foreach(var_2 in var_0) {
      scripts\cp\utility::_id_E190("egy_torch_02", var_2.origin, var_2.angles);
    }
  }

  level childthread trial_b_intro_vo();
  level childthread molotov_use_check();
  level.a_torches = scripts\engine\utility::getStructArray("mq_trial_b_torch_fire", "script_noteworthy");
  level.lighting_torches = 0;
  scripts\engine\utility::_id_1BE2(level.a_torches, ::handle_lighting_torche);
  level scripts\engine\utility::_id_5C24("trial_b_all_torches_lighting");
  var_4 = scripts\engine\utility::getstruct("orb_trial_b_loc", "script_noteworthy");
  var_5 = scripts\cp\utility::_id_459B(level.last_torch, var_4);
  level.red_orb = scripts\cp\utility::_id_E190("tag_origin", var_5.origin, var_5.angles);
  level.last_torch = undefined;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_orb_spawn"), level.red_orb, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_orb"), level.red_orb, "tag_origin");
  level.red_orb playSound("zmb_trail_orb_spawn");
  level.red_orb playLoopSound("zmb_trial_orb_lp");
  level.red_orb moveto(level.red_orb.origin + (0, 0, 50), 1, 0.5, 0.1);
  wait 1.2;
  var_6 = distance(var_4.origin, level.red_orb.origin) / 250;
  var_6 = max(0.7, var_6);
  level.red_orb moveto(var_4.origin, var_6, 0.5, 0.1);
  level.red_orb waittill("movedone");
  level.main_obelisk_b.origin = level.red_orb.origin;
  level.red_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  play_narrations_to_players(get_players_in_trial_zone(level.trial_b_zones), scripts\engine\utility::random(["zm_cpm5_mqs5_dnvk_qihg", "zm_cpm5_mqs5_dnvk_qihi", "zm_cpm5_mqs5_dnvk_qihj", "zm_cpm5_mqs5_dnvk_qihk"]));
  _id_0737::_id_C266("mq_main_obelisk", ::get_obelisk_hint_func, ::on_obelisk_activation_func, undefined, undefined, undefined, undefined, 1);
}

get_obelisk_hint_func(var_0, var_1) {
  if(level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  }

  if(!level scripts\engine\utility::_id_5C00("obelisk_b_sacrifice_finished")) {
    return &"CP_ZM_OASIS/TRIAL_B_SACRIFICE_WEAPON";
  } else if(level scripts\engine\utility::_id_5C00("obelisk_b_charged")) {
    return &"CP_ZM_OASIS/TRIAL_B_START_CHALLENGE";
  } else {
    return "";
  }
}

on_obelisk_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand) || level scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return 0;
  }

  if(!level scripts\engine\utility::_id_5C00("obelisk_b_sacrifice_finished")) {
    var_2 = var_1 getcurrentweapon();
    var_3 = var_1 _id_0774::_id_684B(var_2);

    if(var_3 > 0) {
      if(var_1._id_1B3D > 0) {
        _id_0707::_id_D161(var_1, 0);
      }

      var_4 = scripts\cp\utility::_id_6CE3(var_2);

      if(isDefined(var_1._id_AE0A[var_4])) {
        var_1._id_AE0A[var_4]._id_991E = 1;
      }

      var_1 takeweapon(var_2);
      var_5 = var_1 getweaponslistprimaries();

      if(var_5.size > 0) {
        var_1 _id_0777::_id_EC3C();
        var_1 thread scripts\cp\utility::_id_3552(var_2);
      } else {
        var_6 = _id_073C::get_weapon_from_selected_loadout(var_1, var_1._id_45A9, var_1.usecustomclass, var_1._id_458F);
        var_7 = _func_02F7(var_6);
        var_1 scripts\cp\utility::_giveweapon(var_6, var_7, undefined, 1);
        var_1 switchtoweapon(var_6);
      }

      var_0.mdl playSound("zmb_trial_sacrifice_weapon");
      level scripts\engine\utility::_id_5C1B("obelisk_b_sacrifice_finished");
      level scripts\engine\utility::_id_5C04("obelisk_b_charged");
      level thread obelisk_defeat_jugg_charge(var_1);
      play_vo_to_players([var_1], ["zm_cpm5_mqs5_vlst_qihp", "zm_cpm5_mqs5_vlst_qihq", "zm_cpm5_mqs5_vlst_qihr", "zm_cpm5_mqs5_vlst_qihs"]);
      return;
    }

    play_vo_to_players([var_1], ["zm_cpm5_mqs5_vlst_qiht", "zm_cpm5_mqs5_vlst_qihu", "zm_cpm5_mqs5_vlst_qihv", "zm_cpm5_mqs5_vlst_qihw"]);
    return;
  } else if(level scripts\engine\utility::_id_5C00("obelisk_b_charged")) {
    _id_0746::_id_B8F1("zmb_obelisk_interact");
    _id_0737::_id_C3C5(var_0);
    var_8 = _id_0992::_id_106AF(var_1, 11, "ring of fire challenge start failed");

    if(istrue(var_8)) {
      _id_0746::_id_B8F1("zmb_obelisk_activate");
      level thread ring_of_fire_challenge_flow();
    } else
      _id_0737::_id_1037(var_0);
  }
}

obelisk_defeat_jugg_charge(var_0) {
  level endon("game_ended");
  level endon("obelisk_b_charged");
  pause_round_base_spawn();
  level thread watch_obelisk_defeat_jugg_charge_finished(var_0);
  wait 5;
  level.red_orb playSound("zmb_trial_orb_voice_stinger");
  wait 2;
  var_1 = level.players.size;
  var_2 = [1, 1, 0.7, 0.7];
  var_3 = [10, 14, 18, 22];
  var_4 = [4, 4, 2.5, 2.5];
  var_5 = [2, 2, 4, 4];
  level childthread spawn_zombies_defeat("base", "enemy_base_zombie_cp", var_2[var_1 - 1], var_3[var_1 - 1], "obelisk_b_charged_fail");
  level childthread spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", var_4[var_1 - 1], var_5[var_1 - 1], "obelisk_b_charged_fail");
  var_6 = scripts\engine\utility::getstruct("mq_trial_b_jugg_spawn_loc", "script_noteworthy").origin;
  var_7 = vectortoangles(var_0.origin - var_6);
  level.red_orb moveto(var_6 + (0, 0, 50), 1, 0.5, 0.1);
  level.red_orb waittill("movedone");
  level.red_orb hide();
  play_vo_to_players(get_players_in_trial_zone(level.trial_b_zones), ["zm_cpm5_mqs5_krft_qiie", "zm_cpm5_mqs5_krft_qiif", "zm_cpm5_mqs5_krft_qiig", "zm_cpm5_mqs5_krft_qiih"]);
  level.zombie_round_override = 30;
  var_8 = _id_09A4::_id_110AD("enemy_zombie_juggernaut_cp", var_6, var_7);
  level.zombie_round_override = undefined;
  var_8.brain_rot_immune = 1;
  var_8._id_4A75 = 1;
  var_8.b_ignore_cleanup = 1;
  var_8.b_is_hvt = 1;
  var_8._id_7D0A = 1;
  var_8.backpackhealth = undefined;
  var_8.sacrifice_player = var_0;
  var_8._id_1362 = scripts\engine\utility::array_add(scripts\cp\utility::_id_459B(var_8._id_1362, []), ::damage_scale_charge_jugg);
  var_8 setscriptablepartstate("backpack", "detached", 0);
  var_8 setModel("zom_juggernaut_wholebody_red");
  var_8 thread handle_jugg_no_enemy();
  var_8 waittill("death", var_9);
  var_10 = isPlayer(var_9) || isagent(var_9);
  level.red_orb.origin = var_8.origin + (0, 0, 50);
  level.red_orb show();
  waitframe();

  if(var_10) {
    var_11 = get_players_in_trial_zone(level.trial_b_zones);

    if(isPlayer(var_9)) {
      var_11 = scripts\cp\utility::_id_1B8C(var_11, var_9);
    }

    play_vo_to_players(var_11, ["zm_cpm5_mqs5_vlst_qiii", "zm_cpm5_mqs5_vlst_qiij", "zm_cpm5_mqs5_vlst_qiik", "zm_cpm5_mqs5_vlst_qiil"]);
  } else
    level notify("obelisk_b_charged_fail");

  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_orb"), level.red_orb, "tag_origin");
  level.red_orb playSound("zmb_trail_orb_spawn");
  level.red_orb playLoopSound("zmb_trial_orb_lp");
  level.red_orb moveto(level.red_orb.origin + (0, 0, 50), 1, 0.5, 0.1);
  wait 1.2;
  var_12 = (0, 0, 0);

  if(var_10) {
    level.main_obelisk_b.origin = level.main_obelisk_b.mdl.origin;
    var_12 = (0, 0, 120);
  }

  var_13 = distance(level.main_obelisk_b.origin, level.red_orb.origin) / 250;
  var_13 = max(0.7, var_13);
  level.red_orb moveto(level.main_obelisk_b.origin + var_12, var_13, 0.5, 0.1);
  level.red_orb waittill("movedone");

  if(!var_10) {
    level scripts\engine\utility::_id_5C04("obelisk_b_sacrifice_finished");
    return;
  }

  wait 0.8;
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_orb_charge"), level.red_orb, "tag_origin");
  level.red_orb playSound("zmb_trial_obelisk_lit_up");
  wait 1;
  level scripts\engine\utility::_id_5C1B("obelisk_b_charged");
}

handle_jugg_no_enemy() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isDefined(self._id_0192)) {
      wait 5;
      continue;
    }

    scripts\aitypes\zombie_juggernaut\combat::set_defend_location(get_random_defend_pos());

    while(!isDefined(self._id_0192)) {
      wait 2;
      continue;
    }

    scripts\aitypes\zombie_juggernaut\combat::set_defend_location();
  }
}

damage_scale_charge_jugg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_5)) {
    if(var_5.basename == "s4_me_rindigoww_mp") {
      var_2 = var_2 / _id_09A4::zombiegethealthroundscale();
    }

    [var_13, var_14] = _id_0728::rbz_scale_damage_by_round(var_0, var_2, var_4, var_5, var_6, var_8, self._id_110B0, self.maxhealth);

    if(var_14) {
      if(scripts\cp\utility::_id_88F6(var_5)) {
        var_2 = var_2 * 0.4;
      } else {
        var_2 = var_2 * 0.2;
      }
    }
  }

  if(scripts\engine\utility::is_equal(var_1, self.sacrifice_player)) {
    return var_2;
  }

  if(isDefined(var_5) && weaponclass(var_5) == "spread") {
    return var_2 * 0.2;
  }

  return var_2;
}

watch_sacrifice_player_death() {
  level endon("mq_trial_b_done");
  level endon("obelisk_b_charged");
  self waittill("death_or_disconnect");
  level notify("obelisk_b_charged_fail");
}

get_random_defend_pos(var_0) {
  var_1 = randomfloatrange(250, 500);
  var_2 = randomfloat(360);

  if(isDefined(var_0)) {
    var_3 = _func_0261(var_0.origin - level.main_obelisk_b.origin);
    var_2 = randomfloatrange(var_3 - 40, var_3 + 40);
  }

  var_4 = (cos(var_2) * var_1, sin(var_2) * var_1, 0);
  return _func_02AB(level.main_obelisk_b.origin + var_4);
}

watch_obelisk_defeat_jugg_charge_finished(var_0) {
  level endon("game_ended");
  var_0 childthread watch_sacrifice_player_death();
  var_1 = level scripts\engine\utility::_id_10898("obelisk_b_charged", "mq_trial_b_done", "obelisk_b_charged_fail");
  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    var_4 _meth_81FA();
  }

  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  _id_0746::_id_B8F1("zmb_trial_clear_zombies");
}

create_trial_desc_hud(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.trial_hint)) {
      var_2.trial_hint = var_2 scripts\cp\utility::createfontstring("default", 1);
      var_2.trial_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
      var_2.trial_hint.color = (1, 1, 1);
      var_2.trial_hint settext(var_0);
      var_2.trial_hint.alpha = 1;
    }
  }
}

clear_trial_desc_hud() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.trial_hint)) {
      var_1.trial_hint fadeovertime(0.15);
      var_1.trial_hint.alpha = 0;
      var_1.trial_hint scripts\cp\utility::destroyelem();
      var_1.trial_hint = undefined;
    }
  }
}

update_trial_timer_hud_position() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1._id_A8CC)) {
      var_1._id_A8CC scripts\cp\utility::setpoint("LEFT", undefined, 30, -70);
    }
  }
}

pause_round_base_spawn() {
  scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level.force_cleanup_all_zombies = 1;
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2._id_5FF5 = 1;
      var_3 = scripts\engine\utility::ter_op(var_2 tagexists("j_spinelower"), "j_spinelower", "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("powerup_nuke_zombie_fire"), var_2, var_3);
      var_2 thread scripts\cp\zombies\zm_cleanup::cleanup_zombie();
    }
  }

  level.force_cleanup_all_zombies = 0;

  if(scripts\engine\utility::_id_5C00("in_special_round")) {
    level.rbz scripts\engine\utility::_id_5474("all_killed");
    level.next_special_round = level._id_11049 + 1;
  }
}

spawn_zombies_defeat(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon(var_4);
  var_6 = [];

  for(;;) {
    var_6 = scripts\engine\utility::_id_1BCA(var_6);

    if(var_6.size < var_3) {
      if(level._id_11049 < 10) {
        level.zombie_round_override = 10;
      }

      var_7 = undefined;

      if(isDefined(var_5)) {
        var_8 = var_5[randomint(var_5.size)];
        var_7 = _id_09A4::_id_110AD(var_1, var_8.origin, var_8.angles, var_8);
      } else
        var_7 = scripts\cp\spawners\agent_spawner::_id_E0AC(var_1);

      if(level._id_11049 < 10) {
        level.zombie_round_override = undefined;
      }

      wait 0.5;

      if(isalive(var_7)) {
        var_7.brain_rot_immune = 1;
        var_7._id_4A75 = 1;
        var_7._id_A52A = 1;
        var_7.exclude_cleanup_adding_to_total = 1;

        if(var_7 tagexists("j_spine4")) {
          playFXOnTag(scripts\engine\utility::getfx("mq_extra_spawned_zombie"), var_7, "j_spine4");
        }

        var_7 _id_06CB::_id_0FA5("on_ai_killed", ::on_trial_ai_killed);
        var_7.on_zombie_killed_score_override_func = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::on_zombie_killed_give_no_score;
        var_6[var_6.size] = var_7;

        if(isDefined(self.a_spawn_zombies)) {
          self.a_spawn_zombies[self.a_spawn_zombies.size] = var_7;
        }

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(isDefined(var_7._id_D603)) {
            var_7[[var_7._id_D603]]("sprint");
          }
        }
      }
    }

    wait(var_2);
  }
}

on_trial_ai_killed(var_0) {
  var_1 = randomintrange(0, 100);

  if(var_1 < 15) {
    [var_3, var_4, var_5] = _id_073D::_id_6531(0, self.origin, self.angles);
    _id_092E::_id_E178("cploot_ammo", var_3, var_4, var_5, 1, 0, undefined, 30);
  }
}

ring_of_fire_challenge_flow() {
  level endon("game_ended");
  level endon("ring_of_fire_challenge_finished");
  level thread watch_ring_of_fire_challenge_finished();
  var_0 = scripts\engine\utility::getStructArray("mq_trial_b_teleport_loc", "script_noteworthy");
  var_1 = ["zone_train_north", "zone_train_west", "zone_train_south"];

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = var_3 scripts\cp\zone_manager::_id_642F();

    if(isDefined(var_4) && scripts\engine\utility::array_contains(var_1, var_4.script_zone_name)) {
      var_3 thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::fadetowhite_for_specific_player(0.5);
      continue;
    }

    level thread trial_teleport_specific_player(var_0, var_3);
  }

  trial_b_wall_block(1);
  wait 0.5;
  pause_round_base_spawn();
  var_6 = level.players.size;
  level.main_obelisk_b.n_charged_count = 0;
  var_7 = [6, 8, 12, 16];
  level.main_obelisk_b.n_charged_max = var_7[var_6 - 1];
  level.n_obelisk_charged = 0;
  level.a_sub_obelisk_b = scripts\engine\utility::getStructArray("mq_trial_b_sub_obelisk", "script_noteworthy");

  foreach(var_9 in level.a_sub_obelisk_b) {
    if(!isDefined(var_9.mdl)) {
      childthread spawn_obelisk_model(var_9);
    }

    var_9.b_charged = 0;
    var_9.n_charged_count = 0;
    var_9.n_charged_max = var_7[var_6 - 1];
  }

  var_11 = scripts\engine\utility::getstruct("mq_trial_b_magic_stone", "script_noteworthy");
  level.e_field_upgrade_stone = scripts\cp\utility::_id_E190("s4_zm_soul_capture_runestone_02", var_11.origin, var_11.angles);
  level.e_field_upgrade_stone thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::do_bob();
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_stone_spawn"), level.e_field_upgrade_stone, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_b_stone"), level.e_field_upgrade_stone, "tag_origin");
  _id_0737::_id_C266("mq_trial_b_magic_stone", ::get_field_upgrade_stone_hint_func, ::on_field_upgrade_stone_activation_func);

  while(isDefined(level.trial_teleporting_players_count) && level.trial_teleporting_players_count > 0) {
    wait 1;
  }

  wait 2;
  scripts\cp\zone_manager::set_zone_enabled("zone_west_ruins_to_train", 0);
  _id_06CB::_id_AA4A(::killed_zombie_around_obelisk);
  var_12 = [1, 1, 0.7, 0.7];
  var_13 = [10, 14, 18, 22];
  var_14 = [4, 4, 2.5, 2.5];
  var_15 = [2, 2, 4, 4];
  level thread spawn_zombies_defeat("base", "enemy_base_zombie_cp", var_12[var_6 - 1], var_13[var_6 - 1], "ring_of_fire_challenge_finished");
  level thread spawn_zombies_defeat("screamer", "enemy_zombie_screamer_cp", var_14[var_6 - 1], var_15[var_6 - 1], "ring_of_fire_challenge_finished");
  _func_01E3("trial_battle");
  _id_0987::_id_3F28(180);
  update_trial_timer_hud_position();
  create_trial_desc_hud(&"CP_ZM_OASIS/TRIAL_B_CHALLENGE_DESC");
  play_vo_to_players(level.players, ["zm_cpm5_mqs5_dnvk_qiim", "zm_cpm5_mqs5_dnvk_qiin", "zm_cpm5_mqs5_dnvk_qiio", "zm_cpm5_mqs5_dnvk_qiip"]);
  wait 165;
  level.e_timer_sfx = spawn("script_origin", (0, 0, 0));
  level.e_timer_sfx playLoopSound("zmb_exfil_timer_countdown");
  level thread scripts\engine\utility::_id_982A("game_ended", level.e_timer_sfx);
  wait 15;
  level scripts\engine\utility::_id_5C1B("ring_of_fire_challenge_finished");
}

get_field_upgrade_stone_hint_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand)) {
    return "";
  }

  var_2 = var_1 _id_0766::_id_69B0();

  if(!scripts\engine\utility::is_equal(var_2, "field_upgrade_ring_of_fire")) {
    return &"CP_ZM_OASIS/TRIAL_B_GET_ROF";
  } else {
    return "";
  }
}

on_field_upgrade_stone_activation_func(var_0, var_1) {
  if(!isalive(var_1) || istrue(var_1.inlaststand)) {
    return;
  }
  var_2 = var_1 _id_0766::_id_69B0();

  if(!scripts\engine\utility::is_equal(var_2, "field_upgrade_ring_of_fire")) {
    var_1 _id_0766::givesuper("field_upgrade_ring_of_fire", 0, 0);
  }
}

killed_zombie_around_obelisk(var_0) {
  var_1 = scripts\cp\utility::_id_459B(var_0._id_50FF, self);
  var_2 = isPlayer(var_1) && _func_0107(var_1._id_0DF0) && var_1._id_0DF0.size > 0;
  var_3 = self gettagorigin("j_spine4");

  if(istrue(self._id_2038) || var_2) {
    foreach(var_5 in level.a_sub_obelisk_b) {
      if(!istrue(var_5.b_charged) && distancesquared(var_5.origin, var_1.origin) < 250000) {
        if(!istrue(level.b_trial_c_obelisk_charge_vo_played)) {
          play_vo_to_players(level.players, ["zm_cpm5_mqs5_dnvk_qiiq", "zm_cpm5_mqs5_dnvk_qiir", "zm_cpm5_mqs5_dnvk_qiis", "zm_cpm5_mqs5_dnvk_qiit"]);
          level.b_trial_c_obelisk_charge_vo_played = 1;
        }

        level thread obelisk_send_fx_trail(var_3, var_5.origin + (0, 0, 48), "mq_trial_b_zombie_soul_trail", 600);
        var_5.n_charged_count++;

        if(var_5.n_charged_count >= var_5.n_charged_max) {
          var_5.b_charged = 1;
          level.n_obelisk_charged++;
          var_5 thread sub_obelisk_linkto_main_fx_watcher(level.main_obelisk_b);

          if(level.n_obelisk_charged >= level.a_sub_obelisk_b.size) {
            wait 5;
            level scripts\engine\utility::_id_5C1B("mq_trial_b_done");
          }
        }

        return;
      }
    }
  }

  if(distancesquared(level.main_obelisk_b.origin, self.origin) < 250000) {
    level thread obelisk_send_fx_trail(var_3, level.main_obelisk_b.origin + (0, 0, 48), "mq_trial_b_zombie_soul_trail", 600);
    level.main_obelisk_b.n_charged_count++;

    if(level.main_obelisk_b.n_charged_count >= level.main_obelisk_b.n_charged_max) {
      level.main_obelisk_b.n_charged_count = 0;
      var_7 = level.main_obelisk_b.origin + anglesToForward(level.main_obelisk_b.angles) * 20;
      _id_0990::_id_E3DD("hero_weapon_power", var_7);
    }
  }
}

sub_obelisk_linkto_main_fx_watcher(var_0) {
  level endon("game_ended");
  level endon("ring_of_fire_challenge_finished");
  var_1 = self.origin + (0, 0, 48);
  var_2 = var_0.origin + (0, 0, 48);
  self.mdl playSound("zmb_trial_obelisk_rof_charged");

  for(;;) {
    level thread obelisk_send_fx_trail(var_1, var_2, "mq_trial_b_charge_trail", 200);
    wait 0.8;
  }
}

obelisk_send_fx_trail(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = distance(var_0, var_1) / var_3;

  if(var_4 <= 0) {
    return;
  }
  var_5 = scripts\cp\utility::_id_E190("tag_origin", var_0);
  waitframe();
  var_5 playLoopSound("zmb_trial_obelisk_link_lp");
  playFXOnTag(scripts\engine\utility::getfx(var_2), var_5, "tag_origin");
  wait 0.2;
  var_5 moveto(var_1, var_4);
  var_5 waittill("movedone");
  wait 2;
  var_5 delete();
}

spawn_obelisk_model(var_0) {
  var_1 = scripts\cp\utility::_id_E190("s4_zm_sin_eater_obelisk_01", var_0.origin, var_0.angles);
  var_0.mdl = var_1;

  if(isDefined(var_0._id_0481)) {
    var_2 = getent(var_0._id_0481, "target");

    if(isDefined(var_2)) {
      var_2 solid();
      var_2 _meth_80B5();
      var_0._id_39A7 = var_2;
    }
  }

  var_1 thread obelisk_model_bob(6, 4, 0, 0, 1);
  var_1 hide();
  var_1 playSound("zmb_obelisk_appear");
  playFX(scripts\engine\utility::getfx("mq_trial_obelisk_arrive"), var_1.origin);
  wait 3;
  var_1 notsolid();
  var_1 show();
  var_1 playLoopSound("zmb_obelisk_base_lp");
  playFXOnTag(scripts\engine\utility::getfx("mq_trial_obelisk"), var_1, "tag_origin");
}

obelisk_model_bob(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = self;
  var_5 endon("death");
  var_5 endon("stop_scriptmodel_bob");
  var_4 = scripts\cp\utility::_id_459B(var_4, 0);
  var_6 = scripts\cp\utility::_id_459B(var_0, 0.5);
  var_7 = scripts\cp\utility::_id_459B(var_1, 4);
  var_8 = scripts\cp\utility::_id_459B(var_2, 0.15);
  var_9 = scripts\cp\utility::_id_459B(var_3, 0.15);
  var_10 = var_5.origin + (0, 0, var_7);
  var_11 = var_5.origin - (0, 0, var_7);

  for(;;) {
    var_5 moveto(var_10, var_6, var_8, var_9);

    if(var_4) {
      var_5 rotateyaw(var_5.angles[2] + 45, var_6);
    }

    wait(var_6);
    var_5 moveto(var_11, var_6, var_8, var_9);

    if(var_4) {
      var_5 rotateyaw(var_5.angles[2] + 45, var_6);
    }

    wait(var_6);
  }
}

give_challenge_complete_rewards(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

    foreach(var_4 in var_2) {
      var_1[var_1.size] = var_4.origin;
    }
  }

  if(var_1.size == 0) {
    var_1 = _func_02AA(self.origin, 150, 4);
  }

  level thread _id_0990::_id_E3DD("full_ammo", var_1[0]);
  level thread _id_0990::_id_E3DD("bonus_points_team", var_1[1]);
  level thread _id_0990::_id_E3DD("hero_weapon_power", var_1[2]);
  level thread _id_0990::_id_E3DD("armor_repair", var_1[3]);
}

trial_teleport_specific_player(var_0, var_1) {
  level endon("game_ended");
  level.trial_teleporting_players_count = scripts\cp\utility::_id_459B(level.trial_teleporting_players_count, 0);
  level.trial_teleporting_players_count++;
  level _id_098A::warp_sepcific_player(var_0, var_1);
  level.trial_teleporting_players_count--;
}

watch_ring_of_fire_challenge_finished() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C1B("disallow_rbz_exfil");
  level.disable_portal = 1;
  var_0 = level scripts\engine\utility::_id_10897("ring_of_fire_challenge_finished", "mq_trial_b_done");
  level.disable_portal = undefined;
  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  _func_01E3("none");

  if(isDefined(level.e_timer_sfx)) {
    level.e_timer_sfx delete();
  }

  clear_trial_desc_hud();
  _id_0987::_id_E8A5();
  scripts\cp\zone_manager::set_zone_enabled("zone_west_ruins_to_train", 1);
  _id_06CB::_id_C417(::killed_zombie_around_obelisk);
  _id_0737::_id_C4AB("mq_trial_b_magic_stone");
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite(0.5);
  wait 0.5;
  var_1 = _id_06FE::_id_6322();

  foreach(var_3 in var_1) {
    var_3 _meth_81FA();
  }

  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  _id_0746::_id_B8F1("zmb_trial_clear_zombies");
  trial_b_wall_block(0);

  if(isDefined(level.e_field_upgrade_stone)) {
    level.e_field_upgrade_stone delete();
  }

  var_5 = var_0 == "mq_trial_b_done";
  var_6 = scripts\engine\utility::ter_op(var_5, "mq_trial_obelisk_destroy", "mq_trial_obelisk_depart");
  var_7 = scripts\engine\utility::ter_op(var_5, "zmb_obelisk_finale", "zmb_obelisk_disappear");

  foreach(var_9 in level.a_sub_obelisk_b) {
    if(isDefined(var_9.mdl)) {
      playFX(scripts\engine\utility::getfx(var_6), var_9.origin);
      var_9.mdl playSound(var_7);
      var_9.mdl delete();

      if(isDefined(var_9._id_39A7)) {
        var_9._id_39A7 notsolid();
        var_9._id_39A7 _meth_8093();
      }
    }
  }

  if(!var_5) {
    level waittill("round_complete");
    _id_0737::_id_1037(level.main_obelisk_b);
  } else {
    playFXOnTag(scripts\engine\utility::getfx("mq_trial_obelisk_success"), level.main_obelisk_b.mdl, "tag_origin");
    level scripts\engine\utility::_id_5C1B("ring_of_fire_challenge_finished");
    level.red_orb give_challenge_complete_rewards("mq_trial_b_reward_loc");

    if(isDefined(level.red_orb)) {
      level.red_orb delete();
    }

    var_11 = [["zm_cpm5_mqs5_vlst_qija", "zm_cpm5_mqs5_krft_qijb"], ["zm_cpm5_mqs5_vlst_qijc", "zm_cpm5_mqs5_krft_qijd"], ["zm_cpm5_mqs5_vlst_qije", "zm_cpm5_mqs5_krft_qijf"], ["zm_cpm5_mqs5_vlst_qijg", "zm_cpm5_mqs5_krft_qijh"]];
    level thread _id_0720::play_narrations(scripts\engine\utility::random(var_11), 1, 0, "force_quit_current_dialogue");
  }
}