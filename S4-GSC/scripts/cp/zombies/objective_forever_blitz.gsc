/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\objective_forever_blitz.gsc
**********************************************************/

init() {
  level thread disable_pap_clips();
  level thread disable_anchor_clips();
  level thread disable_portal_clips();

  if(!getdvarint("#x3553d15a56298db4", 0)) {
    return;
  }
  level._effect["forever_blitz_page"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_floating");
  level._effect["forever_blitz_page_shield"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield");
  level._effect["forever_blitz_page_src"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_src");
  level._effect["forever_blitz_page_tgt"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_tgt");
  level._effect["forever_blitz_anchor"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor");
  level._effect["forever_blitz_anchor_immune"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_destroy_fail");
  level._effect["forever_blitz_anchor_trail"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_trail");
  level._effect["forever_blitz_anchor_destroy"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_destroy");
  level._effect["forever_blitz_green_portal"] = loadfx("vfx/s4/zombie/vfx_hub_portal_green");
  level._effect["forever_blitz_vo_runestone"] = loadfx("vfx/s4/zombie/vfx_loot_crystal_idle");
  level._effect["tome_page_fall_ambient"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_progress_3");
  _id_0987::_id_C215("forever_blitz", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "forever_blitz", undefined, undefined, "forever_blitz", undefined, undefined, undefined);
  _id_06CB::_id_0FA4("objective_triggered", ::on_objective_triggered);
  register_zombie_entry_triggers();
}

disable_pap_clips() {
  waitframe();
  var_0 = ["sumpf_forever_blitz_pap_clip"];

  foreach(var_2 in var_0) {
    var_3 = getent(var_2, "targetname");

    if(isDefined(var_3)) {
      var_3 hide();
      var_3 _meth_8093();
    }
  }
}

disable_anchor_clips() {
  waitframe();

  foreach(var_1 in getEntArray("forever_blitz_anchor_clip", "script_noteworthy")) {
    var_1 hide();
    var_1 _meth_8093();
  }
}

disable_portal_clips() {
  waitframe();

  foreach(var_1 in getEntArray("forever_blitz_end_portal_clip", "targetname")) {
    var_1 hide();
    var_1 _meth_8093();
  }
}

register_zombie_entry_triggers() {
  level.a_objective_zombie_entry_triggers["objective_sumpf_forever_blitz"] = ["trigger_sumpf_first_floor_holdout", "trigger_sumpf_second_floor_holdout", "trigger_sumpf_flogger_holdout", "trigger_shino_top_down_soul", "trigger_shino_bottom_up_soul"];
}

spawn_forever_blitz() {
  if(!getdvarint("#x3553d15a56298db4", 0)) {
    return;
  }
  if(!isDefined(level._id_3BE9._id_4828)) {
    return;
  }
  foreach(var_1 in level._id_3BE9._id_4828) {
    var_2 = _id_06EF::_id_6410(var_1, "forever_blitz");

    if(isDefined(var_2) && _func_0107(var_2._id_96CF._id_3BE8["start_interact"])) {
      _id_06EF::_id_E16F(var_2);
    }
  }
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_529C = 1;
  level.a_forever_blitz_instance = scripts\cp\utility::_id_459B(level.a_forever_blitz_instance, []);
  level.a_forever_blitz_instance = scripts\engine\utility::_id_1B8D(level.a_forever_blitz_instance, var_0);
  var_0._id_E5F6 thread _id_06EF::_id_833B();
  var_0._id_E5F6 setscriptablepartstate("base", "off");
  var_0._id_E5F6 setscriptablepartstate("fx", "off");
  var_0._id_E5F6 scripts\cp\zombies\zm_hub_portals::toggle_portal_clip(0);
  scripts\cp\zombies\zm_hub_portals::remove_start_interact_marker(var_0, var_0._id_E5F6);
  toggle_escape_portal_clip(0);
  scripts\engine\utility::_id_5C11("tome_page_collected");
  level thread init_forever_blitz_start_interact(var_0);

  if(is_15_event(var_0)) {
    level thread cp_zod_portal_c_completed_vo();
    level thread cp_zod_portal_c_1_completed_vo();
    level thread cp_zod_enter_office_vo();
    level thread cp_zod_forever_blitz_portal_completed();
    level thread cp_zod_enter_office_after_forever_blitz();
    level thread cp_zod_runestone_interact();
  }

  if(is_20_event(var_0)) {
    level thread play_portal_success_vo(var_0);
    level thread play_anchor_destroyed_vo(var_0);
  }
}

on_objective_triggered(var_0) {
  if(scripts\engine\utility::is_equal(var_0._id_82FC._id_3BE5, "forever_blitz")) {
    level thread on_forever_blitz_triggered(var_0);
  }
}

on_forever_blitz_triggered(var_0) {
  var_1 = var_0._id_82FC;

  if(!isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_1 endon("ended");

  if(is_15_event(var_1)) {
    var_1 scripts\engine\utility::_id_5470("triggered_vo_done");

    if(is_first_time(var_1)) {
      wait 1;
      level thread _id_0720::play_narration("zm_zofb_ofbz_krft_ftrg");
      level waittill("dialogue_finished");
      wait 1;
      level thread _id_0720::play_narration("zm_zofb_ofbz_blkr_ftgr");
      level waittill("dialogue_finished");
    }

    var_1 scripts\engine\utility::_id_5474("triggered_vo_done");
  }
}

init_forever_blitz_start_interact(var_0) {
  if(isDefined(level.fn_forever_blitz_start_wait_override)) {
    [[level.fn_forever_blitz_start_wait_override]]();
  }

  if(isDefined(var_0) && isDefined(var_0._id_E5F6)) {
    var_0.forever_blitz_ready = 1;
    var_0._id_E5F6 thread _id_06EF::_id_833C(1);
    var_0._id_E5F6 setscriptablepartstate("content_interact", "visible");
    var_0._id_E5F6 scripts\cp\zombies\zm_hub_portals::set_portal_asset(var_0);
    var_0._id_E5F6 scripts\cp\zombies\zm_hub_portals::toggle_portal_clip(1);
    scripts\cp\zombies\zm_hub_portals::add_start_interact_marker(var_0, var_0._id_E5F6, 65);
  }
}

setup(var_0) {
  if(!is_20_event(var_0) || !level scripts\engine\utility::_id_5C00("tome_page_collected")) {
    level thread spawn_tome_page_and_anchors(var_0);
  }

  level thread show_pack_a_punch(var_0);
  level thread enable_portal_clip(var_0);

  if(is_15_event(var_0) && is_first_time(var_0)) {
    level.b_disable_special_intro_vo = 1;
  }
}

is_15_event(var_0) {
  return isDefined(var_0) && scripts\engine\utility::is_equal(var_0._id_0481, "objective_sumpf_forever_blitz");
}

is_20_event(var_0) {
  return isDefined(var_0) && scripts\engine\utility::is_equal(var_0._id_0481, "objective_dark_aether_forever_blitz");
}

is_first_time(var_0) {
  var_1 = 1;

  if(isDefined(var_0) && var_0 scripts\engine\utility::_id_546E("first_time_done")) {
    var_1 = 0;
  }

  return var_1;
}

_id_385C() {
  self notify("ended");
  level thread delete_tome_page_and_anchors(self);
  level thread hide_pack_a_punch(self);
  level thread disable_portal_clip(self);
  scripts\engine\utility::_id_5474("first_time_done");

  if(is_20_event(self)) {
    level._id_A52A = 0;
  }
}

register_ai_spawned(var_0, var_1, var_2, var_3) {
  self.a_ai_spawned[var_0] = [];
  self.a_n_attempts[var_0] = 0;
  self.a_n_chance_base[var_0] = var_1;
  self.a_n_chance_increment[var_0] = var_2;
  self.a_n_cooldown[var_0] = var_3;
  self.a_b_cooldown[var_0] = 0;
}

_id_8CE4(var_0) {
  if(!getdvarint("#x3553d15a56298db4", 0)) {
    return;
  }
  if(isDefined(var_0) && _func_0121(var_0)) {
    var_0 = scripts\engine\utility::getstruct(var_0, "targetname");
  }

  if(!isDefined(var_0) || !_func_02DE(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1 = var_0.e_interact;

  if(isDefined(var_1)) {
    var_1 _id_06EF::_id_833C(0);
  }

  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  level thread scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\cp_zm_poi_spawning::cleanup_poi_encounters();
  _id_06EF::_id_2CB3(var_0);
  var_0.b_use_zones = isDefined(var_0._id_3BE8["zone"]);
  level.s_forever_blitz = var_0;
  var_0.n_rounds = 0;
  level scripts\engine\utility::_id_5C04("long_forever_blitz");
  var_0 register_ai_spawned("enemy_zombie_trickster_cp", 1, 1, [80, 60, 40, 20]);
  var_0 register_ai_spawned("enemy_zombie_juggernaut_cp", 1, 2, [60, 45, 30, 15]);
  var_0 register_ai_spawned("enemy_zombie_screamer_cp", 5, 2, [10, 8, 6, 4]);
  _id_06CB::on_ai_spawned(::on_ai_spawned);
  _id_06CB::_id_AA4A(::_id_AA4A);

  if(should_use_zones(var_0)) {
    zones_init(var_0);
  }

  var_0.a_music = scripts\engine\utility::array_combine([], level.hub_music_states);
  _func_01E3("frvr_blitz");
  _id_0987::set_objective_ui_state(5, 0, 1);
  level thread play_kickoff_vo(var_0);
  wait 5;
  level thread rounds_think(var_0);
  var_0 thread ending_update();
  level thread override_objective_wait_after_completion();

  if(is_20_event(var_0)) {
    level._id_A52A = 1;
  }
}

play_kickoff_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");

  if(is_15_event(var_0) && is_first_time(var_0)) {
    wait 3;
    var_0 scripts\engine\utility::_id_5476("triggered_vo_done");
    level thread _id_0720::play_narration("zm_zofb_ofbz_krft_fsns");
    level waittill("dialogue_finished");
    wait 1;
    level thread _id_0720::play_narration("zm_zofb_ofbz_vlst_fsnr");
  }

  if(is_20_event(var_0) && is_first_time(var_0)) {
    wait 3;
    level thread _id_0720::play_narration("zm_z2fb_ofbz_krft_fssh");
    level waittill("dialogue_finished");
    wait 0.5;
    level thread _id_0720::play_narration("zm_z2fb_ofbz_krtx_fssr");
  }
}

should_use_zones(var_0) {
  return istrue(var_0.b_use_zones);
}

rounds_think(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");
  var_0 scripts\engine\utility::_id_5470("portal_open");

  for(;;) {
    var_0 scripts\engine\utility::_id_5470("all_spawned");
    var_0 scripts\engine\utility::_id_5470("all_killed");
    var_0 thread zombie_cleanup_after_duration();

    if(should_use_zones(var_0)) {
      level thread zone_spawns_think(var_0);
    } else {
      level thread spawns_think(var_0);
    }

    var_0 scripts\engine\utility::_id_5476("all_killed");
    var_1 = respawn_players(var_0);

    if(var_1) {
      waitframe();
    }

    var_0.n_rounds++;
    _id_070F::createvoidroundcompeletedevent();
    level._id_11049++;
    level thread _id_0987::update_round_tracker_hud();
    _id_072A::setperroundxp(level._id_3BE9._id_0F51._id_3BE5, level._id_11049);
    give_round_xp(var_0);

    if(var_0.n_rounds % 3 == 0) {
      foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
        var_3 thread _id_0752::_id_7003("objective_forever_blitz_perseverance");
      }
    }

    if(!var_0 scripts\engine\utility::_id_546E("portal_open") && var_0.n_rounds >= 3) {
      var_0 scripts\engine\utility::_id_5474("portal_open");
      level thread portal_open(var_0);
      level thread portal_ui_update(var_0);
    }

    level thread play_round_end_vo(var_0);

    foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
      var_3 playsoundtoplayer("zmb_obj_round_end", var_3);
    }

    if(is_15_event(var_0)) {
      if(var_0.n_rounds >= 10) {
        level scripts\engine\utility::_id_5C1B("long_forever_blitz");
      }

      if(var_0.n_rounds >= 12) {
        foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
          var_3.n_min_perk_level = 2;
        }
      }
    }

    var_0 notify("round_complete");
    wait 15;

    foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
      var_3 playsoundtoplayer("zmb_obj_round_start", var_3);
    }
  }
}

respawn_players(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_2 = _id_0987::_id_6692(var_0);

    if(isDefined(var_2) && _func_0107(var_2)) {
      var_3 = scripts\engine\utility::array_combine([], var_2);

      foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
        if(scripts\engine\utility::is_equal(var_5.sessionstate, "spectator")) {
          var_5._id_5EC7 = undefined;
          var_5._id_5EC2 = undefined;
          var_5.s_forever_blitz_respawn = undefined;

          foreach(var_7 in var_3) {
            if(!_func_01A5(var_7.origin)) {
              var_5.s_forever_blitz_respawn = var_7;
              break;
            }
          }

          if(!isDefined(var_5.s_forever_blitz_respawn)) {
            var_5.s_forever_blitz_respawn = scripts\engine\utility::random(var_3);
          }

          if(isDefined(var_5.s_forever_blitz_respawn)) {
            var_1 = 1;
            var_5._id_5EC7 = var_5.s_forever_blitz_respawn.origin;
            var_5._id_5EC2 = var_5.s_forever_blitz_respawn.angles;
            var_3 = scripts\engine\utility::array_remove(var_3, var_5.s_forever_blitz_respawn);
            var_5 _id_06CB::_id_0FA5("on_player_spawned", ::on_forced_respawn);
            var_5 notify("auto_respawn");
          }
        }
      }
    }
  }

  return var_1;
}

on_forced_respawn() {
  self endon("disconnect");
  _id_06CB::_id_C38A("on_player_spawned", ::on_forced_respawn);
  waitframe();
  self._id_5EC7 = undefined;
  self._id_5EC2 = undefined;
  self.s_forever_blitz_respawn = undefined;
}

give_round_xp(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.n_rounds)) {
    return;
  }
  switch (var_0.n_rounds) {
    case 1:
      var_1 = "objective_forever_blitz_round_1";
      break;
    case 2:
      var_1 = "objective_forever_blitz_round_2";
      break;
    case 3:
      var_1 = "objective_forever_blitz_round_3";
      break;
    case 4:
      var_1 = "objective_forever_blitz_round_4";
      break;
    default:
      var_1 = "objective_forever_blitz_round_5";
      break;
  }

  if(isDefined(var_1)) {
    var_2 = _id_0756::_id_6D0C(var_1, "xp");

    if(isDefined(var_2)) {
      foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
        var_4 _id_0756::giverankxp(var_1, var_2);
      }
    }
  }
}

play_round_end_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_0 notify("playing_round_end_vo");
  var_0 endon("playing_round_end_vo");

  if(is_15_event(var_0) || is_20_event(var_0)) {
    wait 2;

    if(is_first_time(var_0) && var_0 scripts\engine\utility::_id_546E("portal_open") && !var_0 scripts\engine\utility::_id_546E("played_portal_open_vo")) {
      var_0 scripts\engine\utility::_id_5474("played_portal_open_vo");
      level thread _id_0720::play_narration("zm_zofb_ofbz_krft_faep");
    }

    wait 15;
    level play_round_increase_vo(var_0);

    if(is_first_time(var_0) && isDefined(var_0.n_rounds)) {
      wait 5;

      if(var_0.n_rounds >= 10 && !var_0 scripts\engine\utility::_id_546E("played_celebrate_vo_01")) {
        var_0 scripts\engine\utility::_id_5474("played_celebrate_vo_01");
        level thread _id_0720::play_narration("zm_zofb_ofbz_vlst_fse1");
      } else if(var_0.n_rounds >= 12 && !var_0 scripts\engine\utility::_id_546E("played_celebrate_vo_02")) {
        var_0 scripts\engine\utility::_id_5474("played_celebrate_vo_02");
        level thread _id_0720::play_narration("zm_zofb_ofbz_blkr_fse2");
      }
    }
  }
}

play_round_increase_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.b_round_end_vo_krtx)) {
    var_0.b_round_end_vo_krtx = scripts\engine\utility::cointoss();
  }

  if(!isDefined(var_0.a_str_round_end_vo)) {
    var_0.a_str_round_end_vo["krtx"]["pool"] = ::scripts\engine\utility::array_randomize(["zm_zofb_ofbz_krtx_frta", "zm_zofb_ofbz_krtx_frtb", "zm_zofb_ofbz_krtx_frtc", "zm_zofb_ofbz_krtx_frtd", "zm_zofb_ofbz_krtx_frte", "zm_zofb_ofbz_krtx_frtf", "zm_zofb_ofbz_krtx_frtg", "zm_zofb_ofbz_krtx_frth"]);
    var_0.a_str_round_end_vo["vlst"]["pool"] = ::scripts\engine\utility::array_randomize(["zm_zofb_ofbz_vlst_frti", "zm_zofb_ofbz_vlst_frtj", "zm_zofb_ofbz_vlst_frtk", "zm_zofb_ofbz_vlst_frtl", "zm_zofb_ofbz_vlst_frtm", "zm_zofb_ofbz_vlst_frtn", "zm_zofb_ofbz_vlst_frto", "zm_zofb_ofbz_vlst_frtp"]);
    var_0.a_str_round_end_vo["krtx"]["remaining"] = ::scripts\engine\utility::array_combine([], var_0.a_str_round_end_vo["krtx"]["pool"]);
    var_0.a_str_round_end_vo["vlst"]["remaining"] = ::scripts\engine\utility::array_combine([], var_0.a_str_round_end_vo["vlst"]["pool"]);
  }

  var_1 = "vlst";

  if(istrue(var_0.b_round_end_vo_krtx)) {
    var_1 = "krtx";
  }

  if(var_0.a_str_round_end_vo[var_1]["remaining"].size <= 0) {
    var_0.a_str_round_end_vo[var_1]["remaining"] = ::scripts\engine\utility::array_combine([], var_0.a_str_round_end_vo[var_1]["pool"]);

    if(isDefined(var_0.str_last_round_end_vo)) {
      var_0.a_str_round_end_vo[var_1]["remaining"] = ::scripts\engine\utility::array_remove(var_0.a_str_round_end_vo[var_1]["remaining"], var_0.str_last_round_end_vo);
    }
  }

  var_2 = var_0.a_str_round_end_vo[var_1]["remaining"][0];

  if(isDefined(var_2)) {
    var_0.a_str_round_end_vo[var_1]["remaining"] = ::scripts\engine\utility::array_remove_index(var_0.a_str_round_end_vo[var_1]["remaining"], 0);
    var_0.str_last_round_end_vo = var_2;
    var_0.b_round_end_vo_krtx = !var_0.b_round_end_vo_krtx;
    level thread _id_0720::play_narration(var_2);
    level waittill("dialogue_finished");
  }
}

get_round() {
  var_0 = 1;

  if(isDefined(level._id_11049)) {
    var_0 = level._id_11049;
  }

  return var_0;
}

play_round_music(var_0) {
  if(!isDefined(var_0) || !isDefined(level.hub_music_states)) {
    return;
  }
  if(!isDefined(var_0.a_str_music) || var_0.a_str_music.size <= 0) {
    var_0.a_str_music = scripts\engine\utility::array_randomize(scripts\engine\utility::array_combine([], level.hub_music_states));
  }

  if(isDefined(var_0.str_last_music)) {
    var_0.a_str_music = scripts\engine\utility::array_remove(var_0.a_str_music, var_0.str_last_music);
  }

  var_1 = var_0.a_str_music[0];

  if(isDefined(var_1)) {
    var_0.str_last_music = var_1;
    var_0.a_str_music = scripts\engine\utility::array_remove_index(var_0.a_str_music, 0);
    _func_01E3(var_1);
  }
}

get_total_spawn_count() {
  var_0 = get_number_of_players();
  var_1 = 24;

  if(var_0 == 1) {
    var_2 = 29;
    var_3 = 0.84;
    var_4 = 0.5;
  } else {
    var_2 = 20;
    var_3 = 0.6;
    var_4 = 0.5 + var_0 / 2.0;
  }

  var_5 = get_round();

  if(var_5 < var_2) {
    var_3 = 0.15;
    var_6 = var_5 / 5;

    if(var_6 < 1) {
      var_6 = 1;
    }

    var_6 = var_6 * (var_5 * var_3);
  } else
    var_6 = var_5 * var_3;

  var_1 = var_1 + int(var_4 * 6 * var_6);
  var_7 = [6, 8, 11, 14];
  var_8 = [9, 11, 14, 18];
  var_9 = [13, 15, 20, 25];
  var_10 = [18, 20, 25, 33];
  var_11 = [24, 25, 32, 42];

  switch (var_5) {
    case 1:
      var_1 = var_7[var_0 - 1];
      break;
    case 2:
      var_1 = var_8[var_0 - 1];
      break;
    case 3:
      var_1 = var_9[var_0 - 1];
      break;
    case 4:
      var_1 = var_10[var_0 - 1];
      break;
    case 5:
      var_1 = var_11[var_0 - 1];
      break;
  }

  return var_1;
}

get_spawn_delay() {
  var_0 = get_round();

  if(var_0 > 60) {
    var_0 = 60;
  }

  var_1 = get_number_of_players();
  var_2 = 2;

  switch (var_1) {
    case 2:
      var_2 = var_2 * 0.75;
      break;
    case 3:
      var_2 = var_2 * 0.445;
      break;
    case 4:
      var_2 = var_2 * 0.335;
      break;
  }

  for(var_3 = 1; var_3 < var_0; var_3++) {
    var_2 = var_2 * 0.95;

    if(var_2 <= 0.1) {
      var_2 = 0.1;
      break;
    }
  }

  return var_2;
}

zone_spawns_think(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");
  var_1 = get_total_spawn_count();
  var_2 = get_spawn_delay();
  reset_all_ai_roll_attempts(var_0);

  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(scripts\cp\utility::_id_636E());

    if(var_3.size <= 0) {
      wait 0.1;
      continue;
    }

    foreach(var_5 in var_3) {
      if(!isDefined(var_5) || !var_5 scripts\cp\utility::_id_8708()) {
        continue;
      }
      var_6 = get_zone_spawn(var_0, var_5);

      if(isDefined(var_6)) {
        var_7 = _id_6315(var_0);
        var_8 = var_6.origin;
        var_9 = _func_02AB(var_8);

        if(!isDefined(var_9) || distancesquared(var_9, var_8) > 62500) {
          continue;
        }
        var_10 = _id_09A4::_id_110AD(var_7, var_9, var_6.angles, var_6);

        if(isDefined(var_10)) {
          var_1--;

          if(var_7 != "enemy_base_zombie_cp") {
            var_0.a_ai_spawned[var_7] = ::scripts\engine\utility::_id_1BCE(var_0.a_ai_spawned[var_7]);
            var_0.a_ai_spawned[var_7] = ::scripts\engine\utility::array_add(var_0.a_ai_spawned[var_7], var_10);
            level thread start_ai_type_cooldown(var_0, var_7);
          }

          if(var_1 <= 0) {
            var_0 scripts\engine\utility::_id_5474("all_spawned");
            return;
          }
        }
      }

      wait(var_2);
    }
  }
}

zones_init(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_06EF::_id_6412(var_0, "zone");

  if(var_1.size <= 0) {
    return;
  }
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_0481)) {
      var_4.vol_zone = getent(var_4._id_0481, "target");
    }

    var_5 = _id_06EF::_id_6412(var_4, "spawn");

    if(var_5.size > 0) {
      var_4.a_s_spawns = scripts\engine\utility::array_combine([], var_5);
      var_4.a_s_spawns_left = scripts\engine\utility::array_combine([], var_4.a_s_spawns);
    }

    var_6 = [];

    if(isDefined(var_4._id_CE71)) {
      var_7 = strtok(var_4._id_CE71);

      foreach(var_9 in var_7) {
        foreach(var_11 in var_1) {
          if(scripts\engine\utility::is_equal(var_11._id_039B, var_9)) {
            var_6 = scripts\engine\utility::array_add(var_6, var_11);
          }
        }
      }
    }

    var_4.a_s_adjacent_zones = var_6;

    if(isDefined(var_4._id_039B) && isDefined(level.a_active_zones) && scripts\engine\utility::array_contains(level.a_active_zones, var_4._id_039B)) {
      var_4 scripts\engine\utility::_id_5474("enabled");
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  var_0.a_s_enabled_zones = var_2;
}

get_enabled_zones(var_0) {
  var_1 = [];

  if(isDefined(var_0) && isDefined(var_0.a_s_enabled_zones)) {
    var_1 = var_0.a_s_enabled_zones;
  }

  return var_1;
}

get_player_zone(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  foreach(var_3 in get_enabled_zones(var_0)) {
    if(isDefined(var_3.vol_zone) && var_1 istouching(var_3.vol_zone)) {
      return var_3;
    }
  }
}

get_zone_spawn(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  var_2 = get_player_zone(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::array_combine([], var_2.a_s_spawns);

  if(isDefined(var_2.a_s_adjacent_zones)) {
    foreach(var_5 in var_2.a_s_adjacent_zones) {
      if(var_5 scripts\engine\utility::_id_5C00("enabled") && isDefined(var_5.a_s_spawns)) {
        var_3 = scripts\engine\utility::array_combine(var_3, var_5.a_s_spawns);
      }
    }
  }

  var_3 = scripts\engine\utility::_id_6369(var_1.origin, var_3, undefined, undefined, 1800);
  var_3 = scripts\engine\utility::array_randomize(var_3);

  foreach(var_8 in var_3) {
    if(is_valid_spawn(var_8)) {
      return var_8;
    }
  }

  if(var_3.size > 0) {
    return var_3[0];
  }
}

is_valid_spawn(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(scripts\engine\utility::_id_6369(var_0.origin, scripts\cp\utility::_id_636E(), undefined, 1, 128).size <= 0) {
      var_1 = 1;
    }
  }

  return var_1;
}

spawns_think(var_0) {
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_06EF::_id_6412(var_0, "spawn");

  if(var_1.size <= 0) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_2 = scripts\engine\utility::array_combine([], var_1);
  var_3 = get_total_spawn_count();
  var_4 = get_spawn_delay();
  reset_all_ai_roll_attempts(var_0);
  var_5 = 0;

  if(is_20_event(var_0)) {
    var_5 = 9999;
  } else {
    var_5 = 1024;
  }

  for(;;) {
    var_6 = scripts\engine\utility::array_randomize(scripts\cp\utility::_id_636E());

    if(var_6.size <= 0) {
      wait 0.1;
      continue;
    }

    foreach(var_8 in var_6) {
      if(isDefined(var_8) && isalive(var_8) && _func_0072("all", "all") < 24) {
        if(var_2.size <= 0) {
          var_2 = scripts\engine\utility::array_combine([], var_1);
        }

        var_9 = var_8.origin;
        var_10 = scripts\engine\utility::_id_6369(var_9, var_2, undefined, undefined, var_5);

        if(var_10.size <= 0) {
          var_10 = scripts\engine\utility::_id_6369(var_9, var_1, undefined, undefined, var_5);
        }

        if(var_10.size > 0) {
          var_11 = scripts\engine\utility::random(var_10);
        } else {
          var_11 = scripts\engine\utility::random(var_1);
        }

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_13 = _func_02AB(var_12);

          if(!isDefined(var_13) || distancesquared(var_13, var_12) > 62500) {
            continue;
          }
          var_14 = _id_6315(var_0);
          var_15 = _id_09A4::_id_110AD(var_14, var_13, var_11.angles);

          if(isDefined(var_15)) {
            var_2 = scripts\engine\utility::array_remove(var_2, var_11);
            var_3--;

            if(var_14 != "enemy_base_zombie_cp") {
              var_0.a_ai_spawned[var_14] = ::scripts\engine\utility::_id_1BCE(var_0.a_ai_spawned[var_14]);
              var_0.a_ai_spawned[var_14] = ::scripts\engine\utility::array_add(var_0.a_ai_spawned[var_14], var_15);
              level thread start_ai_type_cooldown(var_0, var_14);
            }

            if(var_3 <= 0) {
              var_0 scripts\engine\utility::_id_5474("all_spawned");
              return;
            }
          }
        }
      }

      wait(var_4);
    }
  }
}

get_number_of_players() {
  return int(clamp(scripts\cp\utility::_id_6C5C().size, 1, 4));
}

get_spawned_ai_of_type(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_ai_spawned) && isDefined(var_0.a_ai_spawned[var_1])) {
    var_0.a_ai_spawned[var_1] = ::scripts\engine\utility::_id_1BCE(var_0.a_ai_spawned[var_1]);
    var_2 = var_0.a_ai_spawned[var_1];
  }

  return var_2;
}

increment_ai_roll_attempts(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_0.a_n_attempts[var_1]++;
  }
}

get_ai_roll_attempts(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_2 = var_0.a_n_attempts[var_1];
  }

  return var_2;
}

reset_all_ai_roll_attempts(var_0) {
  if(isDefined(var_0) && isDefined(var_0.a_n_attempts)) {
    foreach(var_2 in getarraykeys(var_0.a_n_attempts)) {
      reset_ai_roll_attempts(var_0, var_2);
    }
  }
}

reset_ai_roll_attempts(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_attempts[var_1])) {
    var_0.a_n_attempts[var_1] = 0;
  }
}

should_spawn_ai_type(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    if(var_1 == "enemy_base_zombie_cp") {
      var_3 = 1;
    } else if(!istrue(is_ai_type_on_cooldown(var_0, var_1))) {
      if(_id_0991::_check_ai_spawn_round_threshold(var_1)) {
        var_4 = _id_0991::get_global_max_zombie_count_by_type(var_1);

        if(get_spawned_ai_of_type(var_0, var_1).size < var_4) {
          var_5 = var_0.a_n_chance_base[var_1];
          var_6 = var_0.a_n_chance_increment[var_1];

          if(isDefined(var_5) && isDefined(var_6)) {
            var_7 = var_5 + var_6 * get_ai_roll_attempts(var_0, var_1);

            if(var_2 <= var_7) {
              var_3 = 1;
              reset_ai_roll_attempts(var_0, var_1);
            } else
              increment_ai_roll_attempts(var_0, var_1);
          }
        }
      }
    }
  }

  return var_3;
}

is_ai_type_on_cooldown(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && istrue(var_0.a_b_cooldown[var_1])) {
    var_2 = 1;
  }

  return var_2;
}

get_ai_type_cooldown_duration(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_0.a_n_cooldown[var_1])) {
    var_3 = var_0.a_n_cooldown[var_1];
    var_4 = get_number_of_players();
    var_2 = var_3[var_4 - 1];
  }

  return var_2;
}

start_ai_type_cooldown(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");
  var_2 = get_ai_type_cooldown_duration(var_0, var_1);

  if(var_2 > 0) {
    var_0.a_b_cooldown[var_1] = 1;
    wait(var_2);
  }

  var_0.a_b_cooldown[var_1] = 0;
}

_id_6315(var_0) {
  var_1 = "enemy_base_zombie_cp";

  if(isDefined(var_0)) {
    var_2 = randomint(100);

    foreach(var_5, var_4 in var_0.a_ai_spawned) {
      if(should_spawn_ai_type(var_0, var_5, var_2)) {
        var_1 = var_5;
        break;
      }
    }
  }

  return var_1;
}

on_ai_spawned() {
  self endon("death");
  self._id_DB73 = 1;
  scripts\aitypes\zombie_common\awareness::set_aware();
  waitframe();

  if(scripts\engine\utility::is_equal(self._id_1210, "actor_enemy_base_zombie_cp") && isDefined(self._id_D603)) {
    self thread[[self._id_D603]](get_move_speed());
  }
}

_id_AA4A(var_0) {
  var_1 = level.s_forever_blitz;

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 scripts\engine\utility::_id_546E("all_spawned") && _func_0072("all", "all") <= 0) {
    var_1 scripts\engine\utility::_id_5474("all_killed");
    level thread _id_0990::_id_E3DD("bonus_points_team", self.origin);
  }
}

get_move_speed() {
  var_0 = "run";
  var_1 = 10;
  var_2 = 0;
  var_3 = get_round();

  if(var_3 >= 16) {
    var_1 = 100;
    var_2 = 75;
  } else if(var_3 >= 11) {
    var_1 = 75;
    var_2 = 50;
  } else if(var_3 >= 6) {
    var_1 = 25;
    var_2 = 10;
  }

  var_4 = randomint(100);

  if(var_4 <= var_1) {
    var_0 = "sprint";
  } else if(var_4 <= var_2) {
    var_0 = "super_sprint";
  }

  return var_0;
}

spawn_tome_page_and_anchors(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");
  var_1 = _id_06EF::_id_6411(var_0, "page");

  if(isDefined(var_1)) {
    level thread tome_page_think(var_0, var_1);
  }

  var_2 = _id_06EF::_id_6412(var_0, "anchor");
  level.n_anchors = 0;

  foreach(var_4 in var_2) {
    level thread anchor_think(var_0, var_4);
  }

  level thread tome_page_unlock_progress(var_0, var_1);
}

delete_tome_page_and_anchors(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_06EF::_id_6411(var_0, "page");

  if(isDefined(var_1.mdl_page)) {
    _func_0130(var_1.mdl_page);
    var_1.mdl_page _meth_83F8();
    waitframe();

    if(isDefined(var_1.mdl_page)) {
      var_1.mdl_page delete();
    }
  }

  var_2 = _id_06EF::_id_6412(var_0, "anchor");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.mdl_fx)) {
      _func_0130(var_4.mdl_fx);
      var_4.mdl_fx delete();
    }

    if(isDefined(var_4.mdl_fx_src)) {
      _func_0130(var_4.mdl_fx_src);
      var_4.mdl_fx_src delete();
    }

    if(isDefined(var_4.mdl_clip)) {
      var_4.mdl_clip hide();
      var_4.mdl_clip _meth_8093();
    }

    if(isDefined(var_4.mdl_anchor)) {
      var_4.mdl_anchor _meth_83F8();
      waitframe();

      if(isDefined(var_4.mdl_anchor)) {
        var_4.mdl_anchor delete();
      }
    }
  }
}

tome_page_think(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1.mdl_page = scripts\cp\utility::_id_E190("s4_zm_ritual_tome_single_page", var_1.origin, var_1.angles);
  var_1.mdl_page endon("death");
  var_1.mdl_page thread tome_page_collected_watcher(var_0);
  var_1.n_fx_idle = playFXOnTag(level._effect["forever_blitz_page"], var_1.mdl_page, "tag_origin");
  var_1.n_fx_shield = playFXOnTag(level._effect["forever_blitz_page_shield"], var_1.mdl_page, "tag_origin");

  foreach(var_3 in _id_06EF::_id_6412(var_0, "anchor")) {
    var_3.mdl_fx_src = scripts\cp\utility::_id_E190("tag_origin", var_1.origin, vectortoangles(var_3.origin - var_1.origin));
    var_3.mdl_fx_src.n_fx = playFXOnTag(level._effect["forever_blitz_page_src"], var_3.mdl_fx_src, "tag_origin");
    var_3.mdl_fx_src linkto(var_1.mdl_page);
  }

  var_1.mdl_page playLoopSound("zmb_dem_page_orb_lp");
  level thread tome_page_bobbing(var_0, var_1.mdl_page);

  if(isDefined(var_1._id_0481)) {
    var_5 = getent(var_1._id_0481, "target");

    if(isDefined(var_5)) {
      if(!isDefined(var_5.v_default_origin)) {
        var_5.v_default_origin = var_5.origin;
      }

      var_5.origin = var_5.v_default_origin;
      level thread tome_page_trigger_damage(var_0, var_1.mdl_page, var_5);
      level thread tome_page_trigger_update(var_0, var_1.mdl_page, var_5);
    }
  }
}

tome_page_bobbing(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1 endon("death");
  var_2 = 8;
  var_3 = 3;

  for(;;) {
    var_1 movez(var_2, var_3);
    var_1 waittill("movedone");
    var_2 = var_2 * -1;
  }
}

tome_page_trigger_damage(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1 endon("death");
  var_2 endon("death");

  for(;;) {
    var_2 waittill("damage", var_3, var_4);

    if(isDefined(var_4) && isPlayer(var_4)) {
      level thread play_immune_vo(var_0, var_4);
      level thread _id_072E::display_damage_number_internal(var_4, 0, 0, var_1.origin);
    }
  }
}

tome_page_trigger_update(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1 endon("death");
  var_2 endon("death");
  var_3 = var_1.origin - var_2.origin;

  for(;;) {
    var_2.origin = var_1.origin - var_3;
    waitframe();
  }
}

tome_page_collected_watcher(var_0) {
  level endon("end_game");
  var_0 endon("ended");
  level waittill("tome_page_collected");
  stopFXOnTag(level._effect["tome_page_fall_ambient"], self.mdl_tome_page_ambient_fx, "tag_origin");
  self stoploopsound("zmb_paperdoor_lp");
  self playSound("zmb_paperdoor_place");
  self.mdl_tome_page_ambient_fx delete();
  self.mdl_key_line_page _meth_86BE();
  self delete();
  level thread play_success_vo(var_0);

  if(!var_0 scripts\engine\utility::_id_546E("portal_open")) {
    var_0 scripts\engine\utility::_id_5474("portal_open");
    level thread portal_open(var_0);
  }
}

play_success_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");

  if(is_20_event(var_0)) {
    wait 2;
    level thread _id_0720::play_narration("zm_z2fb_ofbz_vlst_fscs");
  }
}

anchor_think(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_1._id_0481) || !isDefined(var_1._id_039B)) {
    return;
  }
  foreach(var_3 in getEntArray(var_1._id_0481, "target")) {
    if(isDefined(var_3._id_039B)) {
      switch (var_3._id_039B) {
        case "forever_blitz_anchor_clip":
          var_1.mdl_clip = var_3;
          var_1.mdl_clip solid();
          break;
        case "forever_blitz_anchor_trigger":
          var_1.t_damage = var_3;
          var_1.b_isdestroyed = 0;
          break;
      }
    }
  }

  if(!isDefined(var_1.t_damage)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_1.t_damage endon("death");
  level.n_anchors++;
  var_1.mdl_anchor = scripts\cp\utility::_id_E190(var_1._id_039B, var_1.origin, var_1.angles);
  var_1.mdl_anchor playLoopSound("zmb_dem_anchor_lp");

  if(isDefined(var_1.mdl_clip)) {
    var_1.mdl_clip show();
    var_1.mdl_clip _meth_80B5();
  }

  var_5 = _id_06EF::_id_6411(var_1, "fx");

  if(isDefined(var_5)) {
    var_1.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", var_5.origin, var_5.angles);
    var_6 = var_1.mdl_fx;
    var_1.n_fx_idle = playFXOnTag(level._effect["forever_blitz_anchor"], var_6, "tag_origin");
    var_7 = _id_06EF::_id_6411(var_0, "page");

    if(isDefined(var_7)) {
      var_6.angles = vectortoangles(var_7.origin - var_5.origin);
      var_1.n_fx_tgt = playFXOnTag(level._effect["forever_blitz_page_tgt"], var_6, "tag_origin");
      level thread anchor_energy_think(var_0, var_7, var_1);
    }
  }

  var_8 = var_1.origin;

  if(isDefined(var_5)) {
    var_8 = var_5.origin;
  }

  for(;;) {
    var_1.t_damage waittill("damage", var_9, var_10, var_11, var_11, var_12);

    if(isDefined(var_10) && isPlayer(var_10) && !istrue(var_1.b_isdestroyed)) {
      var_13 = var_10 getcurrentprimaryweapon();

      if(var_13.basename == "s4_me_rindigoww_mp") {
        if(var_12 == "MOD_EXPLOSIVE") {
          if(isDefined(var_5)) {
            playFX(level._effect["forever_blitz_anchor_destroy"], var_5.origin);
          }

          if(isDefined(var_1.mdl_anchor)) {
            var_1.mdl_anchor delete();
            var_1.mdl_clip notsolid();
          }

          if(isDefined(var_1.mdl_fx_src)) {
            _func_0130(var_1.mdl_fx_src);
            var_1.mdl_fx_src delete();
          }

          if(isDefined(var_1.mdl_fx)) {
            _func_0130(var_1.mdl_fx);
            var_1.mdl_fx delete();
          }

          var_1.b_isdestroyed = 1;
          level.n_anchors--;
          level notify("anchor_destroy_vo_play");
          break;
        }
      } else {
        var_9 = 0;

        if(isDefined(var_5)) {
          playFX(level._effect["forever_blitz_anchor_immune"], var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
        }

        level thread play_immune_vo(var_0, var_10);
        level thread _id_072E::display_damage_number_internal(var_10, 0, var_9, var_8);
      }
    }
  }
}

play_anchor_destroyed_vo(var_0) {
  level endon("game_ended");
  var_0 endon("ended");
  level waittill("anchor_destroy_vo_play");
  wait 1.5;
  level thread _id_0720::play_narration("zm_z2fb_ofbz_blkr_ftps");
}

anchor_energy_think(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  var_3 = var_1.mdl_page;
  var_4 = _id_06EF::_id_6411(var_2, "fx");

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  var_2 endon("destroyed");
  var_3 endon("death");
  wait(randomfloat(1));

  for(;;) {
    level thread send_anchor_energy(var_3, var_4, var_2);
    wait 1;
  }
}

send_anchor_energy(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2.mdl_fx)) {
    return;
  }
  var_3 = var_0.origin - (0, 0, 8);
  var_4 = var_1.origin - (0, 0, 8);
  var_5 = distance(var_3, var_4) / 200;

  if(var_5 <= 0) {
    return;
  }
  var_6 = scripts\cp\utility::_id_E190("tag_origin", var_3);
  var_6 thread energy_destroy_watcher(var_2);
  waitframe();

  if(isDefined(var_0)) {
    var_7 = playFXOnTag(level._effect["forever_blitz_anchor_trail"], var_6, "tag_origin");
    var_6 moveto(var_4, var_5);
    var_6 waittill("movedone");

    if(isDefined(var_7)) {
      stopFXOnTag(var_7, var_6, "tag_origin");
    }

    wait 1;
  }

  if(isDefined(var_6)) {
    var_6 delete();
  }
}

energy_destroy_watcher(var_0) {
  self endon("death");

  while(isDefined(var_0.mdl_fx)) {
    waitframe();
  }

  self delete();
}

play_immune_vo(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_1 scripts\engine\utility::_id_546E("forever_blitz_immune_vo_cooldown")) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");

  if(is_20_event(var_0)) {
    return;
  }
  wait 1;

  if(isDefined(var_1) && isalive(var_1) && !var_1 scripts\engine\utility::_id_546E("forever_blitz_immune_vo_cooldown") && !istrue(level._id_493C)) {
    var_2 = var_1 _id_0766::getcurrentsuper();
    var_3 = var_2._id_E76B._id_C189;

    if(isDefined(var_3)) {
      var_4 = "";

      switch (var_3) {
        case "field_upgrade_energy_mine":
          var_4 = "zm_zofb_ofbz_dsrx_ftpf";
          break;
        case "field_upgrade_ring_of_fire":
          var_4 = "zm_zofb_ofbz_dnvk_ftpf";
          break;
        case "field_upgrade_aether_shroud":
          var_4 = "zm_zofb_ofbz_blkr_ftpf";
          break;
        case "field_upgrade_frost_blast":
          var_4 = "zm_zofb_ofbz_dnrt_ftpf";
          break;
        case "field_upgrade_healing_aura":
          var_4 = "zm_z2fb_ofbz_vrcn_ftpf";
          break;
      }

      if(var_4 != "") {
        var_1 scripts\engine\utility::_id_5474("forever_blitz_immune_vo_cooldown");
        level thread immune_vo_cooldown(var_1);
        level thread _id_0720::_id_B309(var_1, var_4);
      }
    }
  }
}

immune_vo_cooldown(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("disconnect");
  wait 60;
  var_0 scripts\engine\utility::_id_5470("forever_blitz_immune_vo_cooldown");
}

tome_page_unlock_progress(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level endon("end_game");
  var_0 endon("ended");

  while(level.n_anchors > 0) {
    wait 1;
  }

  var_1.mdl_page thread tome_page_float_down_watcher();
}

tome_page_float_down_watcher() {
  self endon("death");
  level endon("tome_page_is_ready_to_collect");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distance2dsquared(self.origin, var_1.origin);

      if(var_2 <= _func_0219(500)) {
        self moveto(self.origin + (0, 0, -200), 4, 0, 0);
        self waittill("movedone");
        self playLoopSound("zmb_paperdoor_lp");
        self.mdl_key_line_page = _func_03C5("cploot_item_lost_page", self.origin, self.angles);
        self.mdl_key_line_page setscriptablepartstate("cploot_base", "show");
        self.mdl_key_line_page _meth_8746(self);
        _func_0130(self);
        playFX(level._effect["forever_blitz_anchor_destroy"], self.origin);
        self.mdl_tome_page_ambient_fx = scripts\cp\utility::_id_E190("tag_origin", self.origin + (0, 0, -70));
        waitframe();
        playFXOnTag(level._effect["tome_page_fall_ambient"], self.mdl_tome_page_ambient_fx, "tag_origin");
        _id_0737::_id_C266("tome_page_interact", ::get_hint_func_tome_page, ::on_interact_tome_page, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128);
        _id_0737::addinteractionhinttypecallback("tome_page_interact", ::hint_type_tome_page);
        level notify("tome_page_is_ready_to_collect");
        break;
      }
    }

    wait 1;
  }
}

get_hint_func_tome_page(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "";
  } else {
    return &"CP_SKORPION/COLLECT_TOME_PAGE";
  }
}

on_interact_tome_page(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return;
  }
  scripts\engine\utility::_id_5C1B("tome_page_collected");
  _id_0737::_id_C4AB("tome_page_interact");
}

hint_type_tome_page(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

show_pack_a_punch(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_06EF::_id_6411(var_0, "pap");

  if(!isDefined(var_1)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  level endon("forever_blitz_completed");
  var_2 = undefined;

  if(isDefined(var_1._id_0481)) {
    var_2 = getent(var_1._id_0481, "target");
  }

  var_0.mdl_pap = _id_0774::spawn_weapon_upgrade_machine(var_1.origin, var_1.angles, var_2);
}

hide_pack_a_punch(var_0) {
  var_1 = var_0.mdl_pap;

  if(isDefined(var_1)) {
    _id_0774::remove_weapon_upgrade_machine(var_1);
  }
}

enable_portal_clip(var_0) {
  foreach(var_2 in getEntArray("forever_blitz_end_portal_clip", "targetname")) {
    var_2 show();
    var_2 _meth_80B5();
  }
}

disable_portal_clip(var_0) {
  foreach(var_2 in getEntArray("forever_blitz_end_portal_clip", "targetname")) {
    var_2 hide();
    var_2 _meth_8093();
  }
}

portal_open(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_06EF::_id_6411(var_0, "portal");

  if(!isDefined(var_1)) {
    return;
  }
  level endon("game_ended");

  if(!isDefined(var_1.e_portal)) {
    var_1.e_portal = _id_06EF::_id_E170(var_1, "s4_zm_portal_01", ::on_use_portal);
  } else {
    var_1.e_portal thread _id_06EF::_id_833C(1);
    var_1.e_portal setscriptablepartstate("content_interact", "visible");
  }

  if(is_20_event(var_0) && !level scripts\engine\utility::_id_5C00("tome_page_collected")) {
    var_1.e_portal thread escape_portal_interact_watcher();
  }

  playsoundatpos(var_1.origin, "zmb_exfil_portal_open");

  if(is_20_event(var_0)) {
    var_1.e_portal setscriptablepartstate("base", "skorpion_hub");
    var_1.e_portal setscriptablepartstate("fx", "normal_green");
  } else {
    var_1.e_portal setscriptablepartstate("base", "hub");
    var_1.e_portal setscriptablepartstate("fx", "normal");
  }

  var_1 toggle_escape_portal_clip(1);
  var_2 = spawnStruct();
  var_2.label = &"CP_ZMB_INTERACTIONS/END_FOREVER_BLITZ";
  var_2._id_E747 = "current";
  var_2._id_96CF = var_1.origin;
  var_2._id_11012 = 50;
  var_2._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_2.minimapiconsize = "icon_regular";
  var_2._id_9B54 = _id_0987::_id_0FFD("forever_blitz_leave", var_2);
  level waittill("forever_blitz_completed");
  var_1.e_portal _id_06EF::_id_833B();
  _id_0987::_id_C412(var_2._id_9B54);
  var_2 = undefined;
  level waittill("players_landed");
  var_0 scripts\engine\utility::_id_5470("portal_open");
  var_1.e_portal setscriptablepartstate("base", "off");
  var_1.e_portal setscriptablepartstate("fx", "off");
  var_1 toggle_escape_portal_clip(0);
}

on_use_portal(var_0) {
  if(!isDefined(self)) {
    return;
  }
  _id_06EF::_id_833B();
  var_1 = 8;
  var_2 = "forever blitz end failed";
  var_3 = _id_0992::_id_106AF(var_0, var_1, var_2);

  if(!var_3) {
    thread _id_06EF::_id_833C(1);
    self setscriptablepartstate("content_interact", "visible");
    return 0;
  }

  var_4 = level.s_forever_blitz;

  if(is_15_event(var_4)) {
    level.n_objective_wait_after_completion_override = 5;

    if(is_first_time(var_4)) {
      level.str_portal_cinematic_override = "zm_portal_full_red_s15";
      level.b_portal_cinematic_looping = 0;
      level.n_portal_cinematic_min_time_override = 16;
      level thread play_portal_vo();
    }
  }

  if(is_20_event(var_4) && level scripts\engine\utility::_id_5C00("tome_page_collected")) {
    level notify("void_completed_vo_play");
    level.str_portal_cinematic_override = "zm_portal_full_green";
    level.str_portal_first_person_effect_label_override = "zm_teleport_intro_green";
    level.str_portal_end_first_person_effect_label_override = "zm_teleport_end_green";
  }

  level notify("forever_blitz_completed");
}

portal_ui_update(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("ended");
  wait 7;
  _id_0987::set_objective_ui_state(5, 1, 4);
}

escape_portal_interact_watcher() {
  level endon("end_game");

  while(level.n_anchors > 0) {
    wait 1;
  }

  self setscriptablepartstate("content_interact", "inactive");
  level waittill("tome_page_collected");
  self setscriptablepartstate("content_interact", "visible");
}

play_portal_vo() {
  level waittill("portal_activated");
  wait 4;
  level thread _id_0720::play_narration(scripts\engine\utility::random(["zm_zofb_ofbz_krtx_fbk1", "zm_zofb_ofbz_krtx_fbk2", "zm_zofb_ofbz_krtx_fbk3", "zm_zofb_ofbz_krtx_fbk4"]));
  level.str_portal_cinematic_override = undefined;
  level.b_portal_cinematic_looping = undefined;
  level.n_portal_cinematic_min_time_override = undefined;
  waitframe();
  level.b_disable_special_intro_vo = undefined;
}

play_portal_success_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  level waittill("void_completed_vo_play");
  wait 3;
  level thread _id_0720::play_narration("zm_z2fb_ofbz_blkr_fend");
  level waittill("dialogue_finished");
  wait 1;
  level thread _id_0720::play_narration("zm_z2fb_ofbz_krft_fenr");
}

ending_update() {
  self endon("players_dead");
  self endon("game_ended");
  level waittill("forever_blitz_completed");

  if(is_15_event(self) && is_first_time(self)) {
    level thread vlo_pois_and_ambushes_think();
  }

  self notify("ended");
  _func_01E3("none");
  _id_0987::play_objective_complete_sfx();
  _id_06CB::remove_on_ai_spawned(::on_ai_spawned);
  _id_06CB::_id_C417(::_id_AA4A);
  waitframe();
  level thread _id_0991::_id_E8E2(1);
  level thread _id_0987::kill_all_objective_zombies();
  give_ending_rewards(self);
  wait 1.5;
  set_end_ui(self);
  level thread _id_0987::_id_A871(self, 1);
  cleanup_visuals();

  if(is_15_event(self)) {
    wait 7;
    level thread _id_0720::play_narration("zm_zofb_ofbz_krft_fesc");
  }
}

toggle_vlo_pois_and_ambushes(var_0) {
  var_1 = ["vloffice_poi_05", "vloffice_poi_06", "vloffice_poi_07", "vloffice_poi_08", "vloffice_ambush_03"];

  foreach(var_3 in var_1) {
    foreach(var_5 in scripts\engine\utility::getStructArray(var_3, "targetname")) {
      if(istrue(var_0)) {
        var_5.b_disabled = undefined;
        continue;
      }

      var_5.b_disabled = 1;
    }
  }
}

vlo_pois_and_ambushes_think() {
  level endon("game_ended");
  toggle_vlo_pois_and_ambushes(0);
  level waittill("players_landed");
  toggle_vlo_pois_and_ambushes(1);
}

override_objective_wait_after_completion() {
  level.n_objective_wait_after_completion = 5;
  level waittill("objective_ended");
  level.n_objective_wait_after_completion = undefined;
}

give_ending_rewards(var_0) {
  foreach(var_2 in level.players) {
    var_0 thread give_player_rewards(var_2);
  }
}

give_player_rewards(var_0) {
  var_0 _id_BB0F(3);
  var_0 notify("zmb_max_ammo");
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 givemaxammo(var_3);
    var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
  }

  waitframe();
  var_0 _id_BB0F(8);

  if(isDefined(var_0._id_1B3D) && var_0._id_1B3D > 0) {
    _id_0707::_id_6ECA(var_0, var_0._id_1B3D);
  }

  waitframe();
  var_0 _id_BB0F(6);
  var_0 thread _id_0752::_id_7003("bonus_points_powerup");
}

_id_BB0F(var_0) {
  self setclientomnvar("ui_powerup_splash", var_0);
}

set_end_ui(var_0) {
  if(level scripts\engine\utility::_id_5C00("tome_page_collected")) {
    level thread _id_0987::set_objective_ui_state(5, 2, 4);
  } else {
    level thread _id_0987::set_objective_ui_state(5, 0, 2);
  }
}

zombie_cleanup_after_duration() {
  self endon("objective_ended");
  self endon("ended");
  self endon("round_complete");
  level endon("game_ended");
  level endon("forever_blitz_completed");
  scripts\engine\utility::_id_5476("all_spawned");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = _func_0070("axis");

    if(var_2.size < 2) {
      if(!istrue(var_0)) {
        var_0 = 1;
        var_1 = gettime();
      }

      if(gettime() > var_1 + 120000) {
        _id_0987::kill_all_objective_zombies();
        return;
      }
    }

    wait 0.5;
  }
}

cleanup_visuals() {}

toggle_escape_portal_clip(var_0) {
  var_1 = getEntArray("p_clip", "targetname");

  if(!_func_0107(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 _meth_80B5();
      var_3 show();
      continue;
    }

    var_3 _meth_8093();
    var_3 hide();
  }
}

cp_zod_portal_c_completed_vo() {
  level endon("game_ended");
  level waittill("portal_c_completed");
  level.fn_play_return_narration_override = ::cp_zod_portal_c_completed_override;
}

cp_zod_portal_c_completed_override() {
  level.fn_play_return_narration_override = undefined;
  thread _id_0720::play_narration("zm_z15q_mq15_krft_qb3d");
  level waittill("dialogue_finished");
  _id_0720::play_event_vo_from_valid_players("ally_confirmation");
  level thread play_vo_when_players_approach_portal_to_vlo();
}

play_vo_when_players_approach_portal_to_vlo() {
  level endon("game_ended");
  level endon("portal_c_1_completed");
  var_0 = scripts\engine\utility::getstruct("portal_c_1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    if(players_in_hub_and_not_in_objective()) {
      foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
        if(distance2dsquared(var_2.origin, var_0.origin) <= _func_0219(256)) {
          level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4a");
          return;
        }
      }
    }

    wait 0.1;
  }
}

players_in_hub_and_not_in_objective() {
  return !scripts\engine\utility::_id_5C00("objective_locked") && !isDefined(level.lastobjective);
}

cp_zod_portal_c_1_completed_vo() {
  level endon("game_ended");
  level waittill("portal_c_1_completed");
  level.fn_play_return_narration_override = ::cp_zod_portal_c_1_completed_override;
}

cp_zod_portal_c_1_completed_override() {
  level.fn_play_return_narration_override = undefined;
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4b");
}

cp_zod_enter_office_vo() {
  var_0 = getent("forever_blitz_vo_office_1st_floor", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");

    if(players_in_hub_and_not_in_objective()) {
      break;
    }
  }

  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb1a");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb1b");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_valid_players("ally_confirmation");
}

cp_zod_forever_blitz_portal_completed() {
  level waittill("forever_blitz_portal_completed");
  level.fn_play_return_narration_override = ::cp_zod_forever_blitz_portal_completed_override;
}

cp_zod_forever_blitz_portal_completed_override() {
  level.fn_play_return_narration_override = undefined;
  var_0 = "zm_z15q_mq15_krft_qb3a";

  if(level scripts\engine\utility::_id_5C00("long_forever_blitz")) {
    var_0 = "zm_z15q_mq15_krft_qb3b";
  }

  level scripts\engine\utility::_id_5C04("long_forever_blitz");
  thread _id_0720::play_narration(var_0);
  level waittill("dialogue_finished");
  thread _id_0720::play_narration("zm_z15q_mq15_krft_qb3c");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_valid_players("ally_confirmation");
}

cp_zod_enter_office_after_forever_blitz() {
  var_0 = getent("forever_blitz_vo_office_1st_floor", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("death");
  level waittill("forever_blitz_portal_completed");

  for(;;) {
    var_0 waittill("trigger");

    if(players_in_hub_and_not_in_objective()) {
      break;
    }
  }

  level thread krafts_door_interact_nag();
  level thread krafts_door_objective_marker();
  _id_0737::_id_C266("krafts_door_vo_interact", ::get_hint_func_krafts_door, ::on_interact_krafts_door, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128);
  _id_0737::addinteractionhinttypecallback("krafts_door_vo_interact", ::hint_type_krafts_door);
}

krafts_door_interact_nag() {
  var_0 = level scripts\engine\utility::_id_10898("kraft_door_interact", "beacon_trigger_used", "start_exfil");

  if(scripts\engine\utility::is_equal(var_0, "beacon_trigger_used")) {
    level.fn_play_return_narration_override = ::krafts_door_nag_on_portal_completed;
  }
}

krafts_door_nag_on_portal_completed() {
  level.fn_play_return_narration_override = undefined;
  thread _id_0720::play_narration("zm_z15q_mq15_krft_qb3d");
  level waittill("dialogue_finished");
}

krafts_door_objective_marker() {
  var_0 = scripts\engine\utility::getstruct("krafts_door_vo_interact", "script_noteworthy");
  var_1 = spawnStruct();
  var_1._id_E747 = "current";
  var_1._id_96CF = var_0.origin;
  var_1._id_11012 = 5;
  var_1._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_1.minimapiconsize = "icon_regular";
  var_1._id_9B54 = _id_0987::_id_0FFD("krafts_door", var_1);
  level scripts\engine\utility::_id_10898("kraft_door_interact", "beacon_trigger_used", "start_exfil");
  _id_0987::_id_C412(var_1._id_9B54);
}

get_hint_func_krafts_door(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "";
  } else {
    return &"CP_ZOD/KRAFT_DOOR_INTERACT";
  }
}

on_interact_krafts_door(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return;
  }
  level thread cp_zod_krafts_door_vo();
  level scripts\engine\utility::_id_5C1B("kraft_door_interact");
  _id_0737::_id_C4AB("krafts_door_vo_interact");
}

hint_type_krafts_door(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

cp_zod_krafts_door_vo() {
  level endon("portal_countdown_started");
  level endon("portal_activated");
  level endon("start_exfil");
  level thread disable_nags_think("portal_countdown_started", "portal_activated", "start_exfil", "krafts_door_vo_done");
  level thread krafts_door_vo_done_think();
  level thread cp_zod_krafts_office_exit_vo();
  level thread cp_zod_runestone_activate();
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4c");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4d");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4e");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4f");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb4g");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4h");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnvk_qb4i");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb4j");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dsrx_qb4k");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb4l");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4m");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb4n");
  level waittill("dialogue_finished");
  level scripts\engine\utility::_id_5C1B("krafts_door_vo_done");
}

disable_nags_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");
  level notify("disable_nags_think");
  level endon("disable_nags_think");
  level.b_disable_nags = 1;
  level scripts\engine\utility::_id_10886(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  level.b_disable_nags = undefined;
}

krafts_door_vo_done_think() {
  level endon("game_ended");
  level endon("krafts_door_vo_done");
  level scripts\engine\utility::waittill_any_3("portal_countdown_started", "portal_activated", "start_exfil");
  level scripts\engine\utility::_id_5C1B("krafts_door_vo_done");
}

cp_zod_krafts_office_exit_vo() {
  level endon("portal_countdown_started");
  level endon("portal_activated");
  level endon("start_exfil");
  level endon("set_runestone_vo_play");
  var_0 = scripts\engine\utility::getstruct("forever_blitz_portal", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level scripts\engine\utility::_id_5C24("krafts_door_vo_done");
  var_1 = 0;

  while(!var_1) {
    wait 0.1;

    if(players_in_hub_and_not_in_objective()) {
      foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
        if(distance2dsquared(var_3.origin, var_0.origin) >= _func_0219(700)) {
          var_1 = 1;
          break;
        }
      }
    }
  }

  level scripts\engine\utility::_id_5C1B("krafts_door_exit_done");
  level thread disable_nags_think("portal_countdown_started", "portal_activated", "start_exfil", "set_runestone_vo_play", "cp_zod_krafts_office_exit_vo_done");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb5a");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb5b");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb5c");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_valid_players("ally_confirmation");
  level notify("cp_zod_krafts_office_exit_vo_done");
}

cp_zod_runestone_activate() {
  level scripts\engine\utility::_id_10882("krafts_door_exit_done", "portal_countdown_started", "portal_activated", "start_exfil");
  level scripts\engine\utility::_id_5C1B("set_runestone_vo_enabled");
}

cp_zod_runestone_interact() {
  var_0 = scripts\engine\utility::getstruct("forever_blitz_vo_runestone", "script_noteworthy");
  level waittill("forever_blitz_portal_completed");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0._id_CDC1);
  level scripts\engine\utility::_id_5C24("set_runestone_vo_enabled");
  var_2 = spawn("script_model", var_0.origin - (0, 0, 15));
  var_2 setModel("tag_origin");
  playFXOnTag(level._effect["forever_blitz_vo_runestone"], var_2, "tag_origin");
  _id_0737::_id_C266("forever_blitz_vo_runestone", ::get_hint_func_runestone, ::on_interact_runestone, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128);
  _id_0737::addinteractionhinttypecallback("forever_blitz_vo_runestone", ::hint_type_runestone);
  level scripts\engine\utility::_id_5C24("set_runestone_vo_play");
  stopFXOnTag(level._effect["forever_blitz_vo_runestone"], var_2, "tag_origin");
  level thread cp_zod_runestone_vo();
}

get_hint_func_runestone(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "";
  } else {
    return &"CP_ZMB_INTERACTIONS/AUDIO_LOG_HINT";
  }
}

on_interact_runestone(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("set_runestone_vo_play");
  _id_0737::_id_C4AB("forever_blitz_vo_runestone");
}

hint_type_runestone(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

cp_zod_runestone_vo() {
  level endon("portal_countdown_started");
  level endon("portal_activated");
  level endon("start_exfil");
  level thread cp_zod_forever_blitz_portal_spawn_teaser_portal();
  level thread cp_zod_forever_blitz_portal_vo();
  level thread disable_nags_think("portal_countdown_started", "portal_activated", "start_exfil", "forever_blitz_runestone_vo_done");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb5d");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dsrx_qb5e");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnvk_qb5f");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb5g");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnvk_qb5h");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb5i");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dsrx_qb5j");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb5k");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb5l");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb5m");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_valid_players("ally_confirmation");
  level scripts\engine\utility::_id_5C1B("forever_blitz_runestone_vo_done");
}

cp_zod_forever_blitz_portal_vo() {
  level endon("portal_countdown_started");
  level endon("portal_activated");
  level endon("start_exfil");
  var_0 = getent("forever_blitz_vo_atrium", "targetname");
  var_0 waittill("trigger");
  level scripts\engine\utility::_id_5C24("forever_blitz_runestone_vo_done");
  level thread disable_nags_think("portal_countdown_started", "portal_activated", "start_exfil", "cp_zod_forever_blitz_portal_vo_done");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb6a");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb6b");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb6c");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnvk_qb6d");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dsrx_qb6e");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb6f");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb6g");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dsrx_qb6h");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb6i");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnrt_qb6j");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_dnvk_qb6k");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb6l");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_blkr_qb6m");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb6n");
  level waittill("dialogue_finished");
  level thread _id_0720::play_narration("zm_z15q_mq15_krft_qb6o");
  level waittill("dialogue_finished");
  level thread _id_0720::play_event_vo_from_valid_players("ally_confirmation");
  level notify("cp_zod_forever_blitz_portal_vo_done");
}

cp_zod_forever_blitz_portal_spawn_teaser_portal() {
  var_0 = scripts\engine\utility::getstruct("teaser_portal", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoup(var_0.angles);
  playFX(level._effect["forever_blitz_green_portal"], var_0.origin, var_1, var_2);
}