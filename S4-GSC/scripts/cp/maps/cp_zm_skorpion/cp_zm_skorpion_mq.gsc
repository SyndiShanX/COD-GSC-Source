/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_mq.gsc
****************************************************************/

init() {
  level._effect["mq_shield_crystal_ambient"] = loadfx("vfx/s4/zombie/vfx_crystal_yellow_idle_med");
  level._effect["mq_shield_crystal_trail"] = loadfx("vfx/s4/zombie/vfx_crystal_hand_trail");
  level._effect["mq_shield_crystal_destroy"] = loadfx("vfx/s4/zombie/vfx_crystal_yellow_explode");
  level._effect["forever_blitz_vo_runestone"] = loadfx("vfx/s4/zombie/vfx_loot_crystal_idle");
  level._effect["mq_crystal_hand_explode"] = loadfx("vfx/s4/zombie/vfx_crystal_hand_explode");
  level._effect["mq_portal_open_green"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_hub_portal_open_green");
  level._effect["mq_portal_open_blue"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_hub_portal_open_blue");
  level._effect["mq_final_reward"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_zmb_spawn");
  level._effect["mq_shield_ambient"] = loadfx("vfx/s4/zombie/vfx_crystal_hand_shield_idle");
  level thread init_common_elements();
  level thread _id_0720::add_new_aliases_into_allowlist("cp/cp_zm_skorpion_vo_table.csv", 0);
  level.n_shield_crystals_remaining = scripts\cp\utility::_id_459B(level.n_shield_crystals_remaining, 0);
  level.b_force_disable_portal_nag = scripts\cp\utility::_id_459B(level.b_force_disable_portal_nag, 1);
  _id_099C::_id_C211("mainquest", 1, ::init_meet_vercanna, ::do_meet_vercanna, ::cleanup_meet_vercanna, ::debug_meet_vercanna);
  _id_099C::_id_C211("mainquest", 2, ::init_find_shield, ::do_find_shield, ::cleanup_find_shield, ::debug_find_shield);
  _id_099C::_id_C211("mainquest", 3, ::init_open_domination_arena, ::do_open_domination_arena, ::cleanup_open_domination_arena, ::debug_open_domination_arena);
  _id_099C::_id_C211("mainquest", 4, ::init_unique_assault, ::do_unique_assault, ::cleanup_unique_assault, ::debug_unique_assault);
  _id_099C::_id_C211("mainquest", 5, ::init_void, ::do_void, ::cleanup_void, ::debug_void);
  spawn_shield_crystals();
  scripts\engine\utility::_id_5C11("yelow_crystal_cracked");
}

init_common_elements() {
  var_0 = scripts\engine\utility::getstruct("s2_mq_crystal_hand_lock_loc", "targetname");
  level.e_crystal_hand = scripts\cp\utility::_id_E190("s4_zm_crystalized_hand", var_0.origin, var_0.angles);
  var_1 = scripts\engine\utility::getstruct("lock_shield", "targetname");
  level.e_shield_eye_closed = scripts\cp\utility::_id_E190("vm_shield_demonic_zm_closeeye_200", var_1.origin, var_1.angles);
  playFXOnTag(level._effect["mq_shield_ambient"], level.e_shield_eye_closed, "tag_riot_shield");
  level.e_shield_clip = getent("s2_mq_shield_clip", "targetname");
  level.e_shield_clip notsolid();
  level.e_dominaiton_portal_clip = getent("s2_mq_domination_portal_clip", "targetname");
  level.e_dominaiton_portal_clip notsolid();
  level.e_assault_portal_clip = getent("s2_mq_assault_portal_clip", "targetname");
  level.e_assault_portal_clip notsolid();
  level.e_void_portal_clip = getent("s2_mq_void_portal_clip", "targetname");
  level.e_void_portal_clip notsolid();
}

init_meet_vercanna() {}

do_meet_vercanna() {
  scripts\engine\utility::_id_5C24("introscreen_over");
  wait 30;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_vrcn_qcaa", "zm_z2mq_mqs2_vrcn_qcab"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  var_0 = scripts\engine\utility::random(level.players);

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }
}

cleanup_meet_vercanna() {}

debug_meet_vercanna() {}

init_find_shield() {
  if(isDefined(level.e_shield_eye_closed)) {
    level thread _id_B558(level.e_shield_eye_closed);
  }
}

_id_B558(var_0) {
  level endon("end_game");
  var_0 endon("death");
  level endon("player_find_shield");
  wait 1;

  for(;;) {
    if(_func_0107(level.players)) {
      foreach(var_2 in level.players) {
        var_3 = distance2dsquared(var_0.origin, var_2.origin);

        if(var_3 <= _func_0219(300)) {
          level notify("player_find_shield", var_2);
        }
      }
    }

    wait 1;
  }
}

do_find_shield() {
  level waittill("player_find_shield", var_0);
  level thread play_find_sheild_vo(var_0);
  level waittill("mq_find_sheild_vo_done");

  if(level._id_11049 < 3) {
    level.n_mq_start_round = 3;
  } else {
    level.n_mq_start_round = level._id_11049 + 1;
  }

  while(level._id_11049 < level.n_mq_start_round) {
    wait 1;
  }

  level waittill("players_landed");
  level thread vercanna_turst_vo_wait();
}

cleanup_find_shield() {}

debug_find_shield() {
  level notify("player_find_shield", level.players[0]);
  wait 1;
  level notify("mq_find_sheild_vo_done");
  wait 1;
  level.n_mq_start_round = 0;
  wait 2;
  level notify("players_landed");
}

vercanna_turst_vo_wait() {
  level endon("end_game");
  wait 10;
  level thread play_vercanna_trust_vo();
}

play_find_sheild_vo(var_0) {
  level endon("end_game");
  wait 1;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_dnvk_qcba", "zm_z2mq_mqs2_vrcn_qcbb", "zm_z2mq_mqs2_vrcn_qcbc", "zm_z2mq_mqs2_vrcn_qcbd", "zm_z2mq_mqs2_vrcn_qcca", "zm_z2mq_mqs2_krft_qccb"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("mq_find_sheild_vo_done");

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }
}

play_vercanna_trust_vo() {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_vrcn_qccc", "zm_z2mq_mqs2_vrcn_qcda", "zm_z2mq_mqs2_krft_qcda"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  var_0 = scripts\engine\utility::random(level.players);
  var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  level notify("vercanna_trust_vo_done");
}

init_open_domination_arena() {
  var_0 = scripts\engine\utility::getstruct("s2_mq_speaking_stone_01_loc", "targetname");

  if(!isDefined(level.mdl_domination_stone)) {
    level.mdl_domination_stone = scripts\cp\utility::_id_E190("s4_zm_soul_capture_runestone_02", var_0.origin, var_0.angles);
  }

  if(!isDefined(level.mdl_domination_fx)) {
    level.mdl_domination_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_domination_stone.origin - (0, 0, 15));
    playFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_domination_fx, "tag_origin");
  }
}

get_radio_hint_func(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return "";
  } else {
    return &"CP_SKORPION/INTERACT_RADIO";
  }
}

radio_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

on_radio_interact(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return;
  }
  if(isDefined(level.mdl_domination_fx)) {
    stopFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_domination_fx, "tag_origin");
    level.mdl_domination_fx delete();
  }

  scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  hide_exfil_interact();
  level thread play_domination_portal_vo(var_1);
  level thread domination_portal_show_up();
  _id_0737::_id_C4AB("radio_inactive");
}

init_override_objective_vos(var_0) {
  if(istrue(var_0.b_is_quest)) {
    var_0.override_vos = "domination_for_mq";
    var_0.override_capture_vo = "zm_cqdm_oqdm_krtx_dqca";
    var_0.override_encouragement_vo1 = [];
    var_0.override_encouragement_vo1["str_rune_prog_vo"] = "zm_cqdm_oqdm_krtx_dqda";
    var_0.override_encouragement_vo1["str_rune_prog_vo_resp"] = "zm_cqdm_oqdm_dsrx_dqdb";
    var_0.override_encouragement_vo2 = [];
    var_0.override_encouragement_vo2["str_rune_prog_vo"] = "zm_cqdm_oqdm_krtx_dqfa";
    var_0.override_encouragement_vo2["str_rune_prog_vo_resp"] = "zm_cqdm_oqdm_dsrx_dqfb";
    var_0.override_enemy_spawn_vo = "zm_cqdm_oqdm_dsrx_dqea";
  }
}

pickup_designated_objective(var_0) {
  for(;;) {
    if(_func_0107(level._id_3BE9._id_4828)) {
      foreach(var_2 in level._id_3BE9._id_4828) {
        var_3 = _id_06EF::_id_6410(var_2, var_0);
        return var_3;
      }
    }

    wait 0.1;
  }
}

do_open_domination_arena() {
  level waittill("vercanna_trust_vo_done");
  _id_0737::_id_C266("radio_inactive", ::get_radio_hint_func, ::on_radio_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("radio_inactive", ::radio_hint_type);
  level waittill("domination_quest_completed");
  level waittill("players_landed");
}

cleanup_open_domination_arena() {
  scripts\cp\zombies\zm_hub_portals::show_portals_objectives();

  if(isDefined(level._id_A883) && isDefined(level._id_A883._id_E5F6)) {
    level._id_A883._id_E5F6 scripts\cp\zombies\zm_hub_portals::cleanup_portal();
  }

  level.e_dominaiton_portal_clip _meth_8093();
  level.e_dominaiton_portal_clip notsolid();
  level.e_dominaiton_portal_clip delete();
}

reset_objective_vo(var_0) {
  var_0.b_is_quest = undefined;
  var_0.override_vos = undefined;
  var_0.override_capture_vo = undefined;
  var_0.override_encouragement_vo1 = undefined;
  var_0.override_encouragement_vo2 = undefined;
  var_0.override_enemy_spawn_vo = undefined;
  level.objective_override_vo_func = undefined;
  level.objective_override_vo_cleanup_func = undefined;
}

debug_open_domination_arena() {
  level notify("vercanna_trust_vo_done");
  waitframe();
  level notify("domination_quest_completed");
  waitframe();
  level notify("players_landed");
}

play_domination_portal_vo(var_0) {
  level endon("end_game");
  level scripts\engine\utility::_id_5C1B("mq_speaking_stone_playing");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_vrcn_qcdb", "zm_z2mq_mqs2_vrcn_qcdc", "zm_z2mq_mqs2_vrcn_qcdd", "zm_z2mq_mqs2_dsrx_qcde", "zm_z2mq_mqs2_vrcn_qcdf", "zm_z2mq_mqs2_vrcn_qcdg", "zm_z2mq_mqs2_dsrx_qcdh", "zm_z2mq_mqs2_vrcn_qcdi", "zm_z2mq_mqs2_vrcn_qcdj", "zm_z2mq_mqs2_dnrt_qcdk", "zm_z2mq_mqs2_blkr_qcdl", "zm_z2mq_mqs2_dnrt_qcdm", "zm_z2mq_mqs2_dsrx_qcdn", "zm_z2mq_mqs2_dsrx_qcdo"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("domination_portal_show_up");

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }

  level scripts\engine\utility::_id_5C04("mq_speaking_stone_playing");
}

domination_portal_show_up() {
  level endon("end_game");
  level waittill("domination_portal_show_up");
  level._id_A883 = pickup_designated_objective("domination");
  level._id_A883.b_is_quest = 1;
  level.objective_override_vo_func = ::init_override_objective_vos;
  level.objective_override_vo_cleanup_func = ::reset_objective_vo;
  level.active_objective_instances = scripts\cp\utility::_id_1B8C(level.active_objective_instances, level._id_A883);
  var_0 = scripts\engine\utility::getstruct("s2_mq_unique_domination_portal", "targetname");
  _id_06EF::_id_E16F(level._id_A883);
  level.e_dominaiton_portal_clip solid();
  level.e_dominaiton_portal_clip _meth_80B5();
  playsoundatpos(var_0.origin, "zmb_exfil_portal_open");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, anglesToForward(var_0.angles));
  playFX(level._effect["mq_portal_open_blue"], var_1.origin, anglesToForward(var_1.angles + (270, 180, -90)));
  wait 0.2;
  scripts\cp\zombies\zm_hub_portals::_id_E206(var_0, level._id_A883, "s4_zm_portal_01", 1);
  level thread mq_portal_reactive_watcher();
}

mq_portal_reactive_watcher() {
  level endon("game_ended");
  level endon("players_landed");
  level waittill("s2_mq_portal_reactive");
  level._id_A883._id_E5F6 setscriptablepartstate("content_interact", "visible");
  scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  level thread mq_portal_reactive_watcher();
}

init_unique_assault() {
  var_0 = scripts\engine\utility::getstruct("s2_mq_speaking_stone_02_loc", "targetname");

  if(!isDefined(level.mdl_assault_stone)) {
    level.mdl_assault_stone = scripts\cp\utility::_id_E190("s4_zm_soul_capture_runestone_02", var_0.origin, var_0.angles);
  }

  if(!isDefined(level.mdl_assault_fx)) {
    level.mdl_assault_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_assault_stone.origin - (0, 0, 15));
  }
}

get_radio_hint_func_unique_assault(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return "";
  } else {
    return &"CP_SKORPION/INTERACT_RADIO";
  }
}

on_radio_interact_unique_assault(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return;
  }
  if(isDefined(level.mdl_assault_fx)) {
    stopFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_assault_fx, "tag_origin");
    level.mdl_assault_fx delete();
  }

  scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  hide_exfil_interact();
  level thread play_assault_portal_vo(var_1);
  level thread assault_portal_show_up();
  _id_0737::_id_C4AB("radio_inactive_unique_assault");
}

radio_hint_type_unique_assault(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

do_unique_assault() {
  level.str_portal_cinematic_override = undefined;
  level.str_portal_first_person_effect_label_override = undefined;
  level.str_portal_end_first_person_effect_label_override = undefined;
  scripts\engine\utility::_id_5C1B("yelow_crystal_cracked");
  var_0 = scripts\engine\utility::getstructarray("mq_shield_crystal_loc", "script_noteworthy");

  foreach(var_2 in var_0) {
    playFXOnTag(level._effect["mq_shield_crystal_ambient"], var_2.mdl_crystal, "tag_origin");
    var_2.mdl_crystal playLoopSound("zmb_mq_crystal_amb_lp");
  }

  level thread crystal_vo_play_wait(var_0);

  while(level.n_shield_crystals_remaining > 0) {
    wait 1;
  }

  stopFXOnTag(level._effect["mq_shield_ambient"], level.e_shield_eye_closed, "tag_riot_shield");
  scripts\engine\utility::_id_5C04("yelow_crystal_cracked");

  if(!isDefined(level.assault_stone_fx)) {
    level.assault_stone_fx = playFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_assault_fx, "tag_origin");
  }

  level thread _id_B558(level.e_shield_eye_closed);
  level waittill("player_find_shield", var_4);
  level thread play_free_shield_vo(var_4);
  level waittill("mq_free_shield_vo_done");
  _id_0737::_id_C266("radio_inactive_unique_assault", ::get_radio_hint_func_unique_assault, ::on_radio_interact_unique_assault, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("radio_inactive_unique_assault", ::radio_hint_type_unique_assault);
  level waittill("unique_assault_complete");
  level waittill("players_landed");
}

crystal_vo_watcher() {
  level endon("end_game");
  level endon("crystal_vo_played");

  while(level.n_shield_crystals_remaining > 0) {
    if(_func_0107(level.players)) {
      foreach(var_1 in level.players) {
        var_2 = distance2dsquared(self.origin, var_1.origin);

        if(var_2 <= _func_0219(500)) {
          level thread play_crystal_vo();
          return;
        }
      }
    }

    wait 1;
  }
}

crystal_vo_play_wait(var_0) {
  level endon("end_game");
  level endon("crystal_vo_played");
  wait 10;

  foreach(var_2 in var_0) {
    var_2 thread crystal_vo_watcher();
  }
}

play_crystal_vo() {
  level endon("end_game");
  level notify("crystal_vo_played");
  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_krft_qcea", "zm_z2mq_mqs2_blkr_qceb"], 1, 0, "force_quit_current_dialogue");
}

play_free_shield_vo(var_0) {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_krft_qcec", "zm_z2mq_mqs2_blkr_qced", "zm_z2mq_mqs2_vrcn_qcee", "zm_z2mq_mqs2_dnvk_qcfa"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }

  wait 1;
  level notify("mq_free_shield_vo_done");
}

cleanup_unique_assault() {
  if(isDefined(level._id_A883) && isDefined(level._id_A883._id_E5F6)) {
    level._id_A883._id_E5F6 scripts\cp\zombies\zm_hub_portals::cleanup_portal();
  }

  level.e_assault_portal_clip notsolid();
  level.e_assault_portal_clip _meth_8093();
  level.e_assault_portal_clip delete();
}

debug_unique_assault() {
  level.n_shield_crystals_remaining = 0;
  wait 1;
  level notify("player_find_shield");
  wait 1;
  level notify("mq_free_shield_vo_done");
  wait 1;
  level notify("unique_assault_complete");
  wait 1;
  level notify("players_landed");
}

shield_crystal_damage_watcher() {
  level endon("end_game");
  self.t_dmg = getent(self._id_0481, "target");
  self.t_dmg.n_health = 300;

  for(;;) {
    self.t_dmg waittill("damage", var_0, var_1);
    self.mdl_crystal playSound("zmb_mq_crystal_impact");

    if(level scripts\engine\utility::_id_5C00("yelow_crystal_cracked")) {
      if(isDefined(var_1) && isPlayer(var_1)) {
        level thread _id_072E::display_damage_number_internal(var_1, 0, var_0, self.t_dmg.origin);
        self.t_dmg.n_health = self.t_dmg.n_health - var_0;
      }

      if(self.t_dmg.n_health <= 0) {
        playFX(level._effect["mq_shield_crystal_destroy"], self.origin);

        if(isDefined(self.mdl_crystal)) {
          _func_0130(self.mdl_crystal);
          self.mdl_crystal stoploopsound("zmb_mq_crystal_amb_lp");
          self.mdl_crystal playSound("zmb_mq_crystal_destroy");
          waitframe();

          if(isDefined(self.mdl_crystal)) {
            self.mdl_crystal delete();
          }
        }

        play_crystal_trail_fx(self.origin, level.e_shield_eye_closed.origin);

        if(isDefined(self.t_dmg)) {
          self.t_dmg delete();
        }

        break;
      }
    } else if(isDefined(var_1) && isPlayer(var_1))
      level thread _id_072E::display_damage_number_internal(var_1, 0, 0, self.t_dmg.origin);
  }
}

play_crystal_trail_fx(var_0, var_1) {
  level endon("end_game");
  var_2 = distance(var_0, var_1) / 150;

  if(var_2 <= 0) {
    return;
  }
  self.mdl_energy = scripts\cp\utility::_id_E190("tag_origin", var_0);
  self.mdl_energy playLoopSound("zmb_mq_crystal_essence_lp");
  waitframe();

  if(isDefined(self.mdl_energy)) {
    playFXOnTag(level._effect["mq_shield_crystal_trail"], self.mdl_energy, "tag_origin");
    self.mdl_energy moveto(var_1, var_2);
    self.mdl_energy waittill("movedone");

    foreach(var_4 in level.players) {
      var_5 = distance2dsquared(level.e_shield_eye_closed.origin, var_4.origin);

      if(var_5 <= _func_0219(300)) {
        var_4 earthquakeforplayer(0.3, 0.5, var_4.origin, 100);
        var_4 _meth_827A("cp_zm_s2_mq_shield_rumble", var_4.origin);
      }
    }
  }

  if(isDefined(self.mdl_energy)) {
    _func_0130(self.mdl_energy);
    self.mdl_energy playSound("zmb_mq_crystal_essence_absorb");
    self.mdl_energy delete();
  }

  level.n_shield_crystals_remaining--;
}

play_assault_portal_vo(var_0) {
  level endon("end_game");
  level scripts\engine\utility::_id_5C1B("mq_speaking_stone_playing");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_dnvk_qcfb", "zm_z2mq_mqs2_vrcn_qcfc", "zm_z2mq_mqs2_vrcn_qcfd", "zm_z2mq_mqs2_vrcn_qcfe", "zm_z2mq_mqs2_dnvk_qcff", "zm_z2mq_mqs2_dnrt_qcfg", "zm_z2mq_mqs2_blkr_qcfh", "zm_z2mq_mqs2_vrcn_qcfi", "zm_z2mq_mqs2_dsrx_qcfj", "zm_z2mq_mqs2_vrcn_qcfk"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("assault_portal_show_up");

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }

  level scripts\engine\utility::_id_5C04("mq_speaking_stone_playing");
}

assault_portal_show_up() {
  level endon("end_game");
  level waittill("assault_portal_show_up");
  level._id_A883 = pickup_designated_objective("assault");
  level.active_objective_instances = scripts\cp\utility::_id_1B8C(level.active_objective_instances, level._id_A883);
  level._id_A883.b_is_quest = 1;
  level._id_A883.hide_round_message_hud = 1;
  level.objective_override_vo_func = ::override_assault_vo_func;
  level.objective_override_vo_cleanup_func = ::override_assaultvo_cleanup_func;
  var_0 = scripts\engine\utility::getstruct("s2_mq_unique_assault_portal", "targetname");
  _id_06EF::_id_E16F(level._id_A883);
  level.e_assault_portal_clip solid();
  level.e_assault_portal_clip _meth_80B5();
  playsoundatpos(var_0.origin, "zmb_exfil_portal_open");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  playFX(level._effect["mq_portal_open_green"], var_1.origin, anglesToForward(var_1.angles + (180, 90, -90)));
  wait 0.2;
  scripts\cp\zombies\zm_hub_portals::_id_E206(var_0, level._id_A883, "s4_zm_portal_01", 1);
  level thread mq_portal_reactive_watcher();
}

override_assault_vo_func(var_0) {
  if(istrue(var_0.b_is_quest)) {
    var_0.override_success_vo = "zm_cqas_oqas_vrcn_aqsc";
    var_0.override_end_vo = "zm_cqas_oqas_krft_aqnd";
    var_0.override_end_resp_vo = "zm_cqas_oqas_vrcn_aqnr";
    var_0.override_fail_vo = "zm_cqas_oqas_krtx_aqfl";
    var_0.override_1st_rift_open_vo = "zm_cqas_oqas_krtx_aq1o";
    var_0.override_1st_rift_open_resp_vo = "zm_cqas_oqas_vrcn_aq1r";
    var_0.override_2nd_rift_open_vo = "zm_cqas_oqas_krtx_aq2o";
    var_0.override_2nd_rift_open_resp_vo = "zm_cqas_oqas_vrcn_aq2r";
    var_0.override_announce_vo = "zm_cqas_oqas_vrcn_aqtg";
    var_0.override_trigger_vo = "zm_cqas_oqas_vrcn_aqtr";
  }
}

override_assaultvo_cleanup_func(var_0) {
  if(istrue(var_0.b_is_quest)) {
    var_0.override_success_vo = undefined;
    var_0.override_end_vo = undefined;
    var_0.override_end_resp_vo = undefined;
    var_0.override_fail_vo = undefined;
    var_0.override_1st_rift_open_vo = undefined;
    var_0.override_1st_rift_open_resp_vo = undefined;
    var_0.override_2nd_rift_open_vo = undefined;
    var_0.override_2nd_rift_open_resp_vo = undefined;
    var_0.override_announce_vo = undefined;
    var_0.override_trigger_vo = undefined;
    var_0.b_is_quest = 0;
    level.objective_override_vo_func = undefined;
    level.objective_override_vo_cleanup_func = undefined;
  }
}

init_void() {
  level.fn_forever_blitz_start_wait_override = ::cp_zm_skorpion_forever_blitz_start_wait_override;
  var_0 = scripts\engine\utility::getstruct("s2_mq_speaking_stone_03_loc", "targetname");

  if(!isDefined(level.mdl_stone_void)) {
    level.mdl_stone_void = scripts\cp\utility::_id_E190("s4_zm_soul_capture_runestone_02", var_0.origin, var_0.angles);
  }

  if(!isDefined(level.mdl_void_stone_fx)) {
    level.mdl_void_stone_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_stone_void.origin - (0, 0, 15));
  }
}

get_radio_hint_func_void(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return "";
  } else {
    return &"CP_SKORPION/INTERACT_RADIO";
  }
}

on_radio_interact_void(var_0, var_1) {
  if(istrue(level._id_0C35) || scripts\engine\utility::_id_5C00("objective_locked")) {
    return;
  }
  if(isDefined(level.mdl_void_stone_fx)) {
    stopFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_void_stone_fx, "tag_origin");
    level.mdl_void_stone_fx delete();
  }

  scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  hide_exfil_interact();
  _id_0737::_id_C4AB("radio_inactive_void");
  level thread play_void_portal_vo(var_1);
  level thread show_up_void_portal();
}

radio_hint_type_void(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

show_up_void_portal() {
  level endon("end_game");
  level waittill("void_portal_vo_done");
  level.e_void_portal_clip solid();
  level.e_void_portal_clip _meth_80B5();
  var_0 = scripts\engine\utility::getstruct("forever_blitz_portal", "targetname");
  playsoundatpos(var_0.origin, "zmb_exfil_portal_open");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, anglesToForward(var_0.angles));
  playFX(level._effect["mq_portal_open_green"], var_1.origin, anglesToForward(var_1.angles + (90, 90, 0)));
  wait 0.2;
  scripts\cp\zombies\objective_forever_blitz::spawn_forever_blitz();
  level thread void_portal_reactive_watcher();
  level thread void_portal_enter_watcher();
  level.b_skip_hide_forever_blitz = 1;
}

void_portal_reactive_watcher() {
  level endon("game_ended");
  level endon("players_landed");
  level waittill("s2_mq_portal_reactive");
  scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  level thread void_portal_reactive_watcher();
}

void_portal_enter_watcher() {
  level endon("game_ended");
  level waittill("vote_passed");
  level.b_skip_hide_forever_blitz = 0;
}

do_void() {
  level.fn_play_return_narration_override = ::void_return_vo_override;
  level.str_portal_cinematic_override = undefined;
  level.str_portal_first_person_effect_label_override = undefined;
  level.str_portal_end_first_person_effect_label_override = undefined;
  wait 2;
  var_0 = scripts\engine\utility::getstruct("s2_mq_hand_explode_loc", "targetname");
  playFX(level._effect["mq_crystal_hand_explode"], var_0.origin);
  level.e_shield_eye_closed playSound("zmb_hand_shatter");

  foreach(var_2 in level.players) {
    var_3 = distance2dsquared(level.e_shield_eye_closed.origin, var_2.origin);

    if(var_3 <= _func_0219(1299)) {
      var_2 earthquakeforplayer(0.5, 1, var_2.origin, 100);
      var_2 _meth_827A("cp_zm_s2_mq_shield_rumble", var_2.origin);
    }
  }

  var_5 = scripts\engine\utility::getstruct("s2_mq_crystal_hand_lock_dmg_loc", "targetname");

  if(!isDefined(level.e_crystal_hand_dmg)) {
    level.e_crystal_hand_dmg = scripts\cp\utility::_id_E190("s4_zm_crystalized_hand_dmg", var_5.origin, var_5.angles);
  }

  if(isDefined(level.e_crystal_hand)) {
    level.e_crystal_hand delete();
  }

  if(isDefined(level.e_shield_eye_closed)) {
    level.e_shield_eye_closed delete();
  }

  var_6 = scripts\engine\utility::getstruct("lock_shield", "targetname");
  level.e_shield = scripts\cp\utility::_id_E190("vm_shield_demonic_zm_200", var_6.origin, var_6.angles);
  level thread player_ignore_watcher(level.e_shield.origin);
  level thread shield_vignette_music_watcher();
  waitframe();
  level.e_shield _meth_82CB("s4_zm_shield_demonic_animation", "shield_vo");
  wait 0.7;
  level thread play_shield_vo();
  wait 49;
  level.e_shield playSound("zmb_shield_drop");
  level.e_shield playSound("wpn_decimator_impact_npc");
  level.e_shield_clip solid();
  level.e_shield_clip _meth_80B5();

  foreach(var_2 in level.players) {
    var_3 = distance2dsquared(level.e_shield.origin, var_2.origin);

    if(var_3 <= _func_0219(600)) {
      var_2 earthquakeforplayer(0.5, 1, var_2.origin, 100);
      var_2 _meth_827A("cp_zm_s2_mq_shield_rumble", var_2.origin);
    }
  }

  level notify("mq_ignore_watcher_done");

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_id_88B5()) {
      var_2 scripts\cp\utility::_id_1566(0);
    }
  }

  level thread play_shield_ready_vo();
  level waittill("shield_ready_vo_done");
  _func_01E3("none");
  _id_0737::_id_C266("mq_shield_pick_up_trig", ::shield_pick_up_hint, ::on_shield_pick_up_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128);
  _id_0737::addinteractionhinttypecallback("mq_shield_pick_up_trig", ::shield_hint_type);
  level waittill("shield_picked_up", var_2);
  level.e_shield_clip notsolid();
  level.e_shield_clip _meth_8093();
  level.e_shield_clip delete();
  level.can_drop_wonder_weapon = 1;
  level thread play_shield_pick_up_vo(var_2);
  level waittill("shield_pickup_vo_done");

  if(!isDefined(level.void_stone_fx)) {
    level.void_stone_fx = playFXOnTag(level._effect["forever_blitz_vo_runestone"], level.mdl_void_stone_fx, "tag_origin");
  }

  _id_0737::_id_C266("radio_inactive_void", ::get_radio_hint_func_void, ::on_radio_interact_void, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("radio_inactive_void", ::radio_hint_type_void);

  for(;;) {
    level waittill("forever_blitz_completed");
    level waittill("players_landed");
    level.str_portal_cinematic_override = undefined;
    level.str_portal_first_person_effect_label_override = undefined;
    level.str_portal_end_first_person_effect_label_override = undefined;

    if(level scripts\engine\utility::_id_5C00("tome_page_collected")) {
      level.b_force_disable_portal_nag = 0;
      level thread give_mq_reward();
      level thread play_final_vo();
      level notify("s2_mq_done");
      break;
    }

    wait 1;
  }

  for(;;) {
    level waittill("players_landed");
    level.str_portal_cinematic_override = undefined;
    level.str_portal_first_person_effect_label_override = undefined;
    level.str_portal_end_first_person_effect_label_override = undefined;
  }
}

cleanup_void() {}

debug_void() {}

shield_vignette_music_watcher() {
  level endon("end_game");
  wait 14;
  _func_01E3("mq_s2_underscore_1");
}

void_return_vo_override() {
  level.fn_play_return_narration_override = undefined;
  return;
}

play_shield_vo() {
  level endon("end_game");
  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_dcmt_qcga", "zm_z2mq_mqs2_dcmt_qcgb", "zm_z2mq_mqs2_dcmt_qcgc", "zm_z2mq_mqs2_dcmt_qcgd", "zm_z2mq_mqs2_dcmt_qcge", "zm_z2mq_mqs2_dcmt_qcgf"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

cp_zm_skorpion_forever_blitz_start_wait_override() {
  if(getdvarint("#x3d716d492c9ae8f91", 0)) {
    return;
  }
  wait 0.1;
}

shield_pick_up_hint(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "";
  } else {
    return &"CP_SKORPION/SHIELD_PICK_UP";
  }
}

on_shield_pick_up_interact(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return;
  }
  var_2 = spawnStruct();
  var_2.player = var_1;
  var_2.origin = level.e_shield.origin;
  var_2.triggeringweapon = "s4_me_rindigoww_mp";
  _id_0932::drop_relevant_weapon(var_2);
  level.e_shield delete();
  var_1 playlocalsound("zmb_shield_pickup_plr");

  foreach(var_4 in level.players) {
    if(scripts\engine\utility::is_equal(var_4, var_1)) {
      continue;
    }
    var_4 playlocalsound("zmb_shield_pickup_npc");
  }

  var_1 giveweapon("s4_me_rindigoww_mp");
  var_1 switchtoweapon("s4_me_rindigoww_mp");
  level notify("shield_picked_up", var_1);
  _id_0737::_id_C4AB("mq_shield_pick_up_trig");

  foreach(var_1 in level.players) {
    var_1 thread player_disconnect_drop_shield_watcher();
    var_1 thread player_death_drop_shield_watcher();
  }
}

shield_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

play_shield_ready_vo() {
  level endon("end_game");
  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_krft_qcgg", "zm_z2mq_mqs2_blkr_qcgh"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  level notify("shield_ready_vo_done");
}

play_shield_pick_up_vo(var_0) {
  level endon("end_game");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_blkr_qcha", "zm_z2mq_mqs2_blkr_qchb", "zm_z2mq_mqs2_vrcn_qchc", "zm_z2mq_mqs2_vrcn_qchd"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");

  if(isDefined(var_0)) {
    var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  }

  level notify("shield_pickup_vo_done");
}

play_void_portal_vo(var_0) {
  level endon("end_game");
  level scripts\engine\utility::_id_5C1B("mq_speaking_stone_playing");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_vrcn_qche", "zm_z2mq_mqs2_blkr_qchf", "zm_z2mq_mqs2_vrcn_qchg", "zm_z2mq_mqs2_dnvk_qchh", "zm_z2mq_mqs2_dnrt_qchi", "zm_z2mq_mqs2_dsrx_qchj", "zm_z2mq_mqs2_vrcn_qchk"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
  var_0 thread _id_0720::_id_BEC0("ally_confirmation");
  level scripts\engine\utility::_id_5C04("mq_speaking_stone_playing");
  level notify("void_portal_vo_done");
}

play_final_vo() {
  level endon("end_game");
  wait 5;
  level thread _id_0720::play_narrations(["zm_z2mq_mqs2_blkr_qcja", "zm_z2mq_mqs2_krft_qcjb", "zm_z2mq_mqs2_krft_qcjc", "zm_z2mq_mqs2_dsrx_qcjd", "zm_z2mq_mqs2_dnvk_qcje", "zm_z2mq_mqs2_blkr_qcjf", "zm_z2mq_mqs2_dnrt_qcjg", "zm_z2mq_mqs2_krft_qcjh", "zm_z2mq_mqs2_vrcn_qcji", "zm_z2mq_mqs2_vrcn_qcjj"], 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

player_ignore_watcher(var_0) {
  level endon("end_game");
  level endon("mq_ignore_watcher_done");

  for(;;) {
    foreach(var_2 in level.players) {
      var_3 = distance2dsquared(var_2.origin, var_0);

      if(var_3 <= _func_0219(300)) {
        if(!var_2 scripts\cp\utility::_id_88B5()) {
          var_2 scripts\cp\utility::_id_1566(1);
        }

        continue;
      }

      if(var_2 scripts\cp\utility::_id_88B5()) {
        var_2 scripts\cp\utility::_id_1566(0);
      }
    }

    wait 1;
  }
}

spawn_shield_crystals() {
  var_0 = scripts\engine\utility::getstructarray("mq_shield_crystal_loc", "script_noteworthy");

  if(level.n_shield_crystals_remaining < 4) {
    foreach(var_2 in var_0) {
      var_2.mdl_crystal = scripts\cp\utility::_id_E190("s4_zm_shield_crystal_med", var_2.origin, var_2.angles);
      var_2 thread shield_crystal_damage_watcher();
      level.n_shield_crystals_remaining++;
    }
  }
}

give_mq_reward() {
  level endon("end_game");
  level.get_pap_cost_override = ::get_mq_final_pap_cost;

  foreach(var_1 in level.players) {
    var_2 = var_1 getcurrentprimaryweapon();

    if(var_2.basename != "s4_me_rindigoww_mp") {
      var_1 thread _id_0774::_id_10D20();
    }
  }

  level.get_pap_cost_override = undefined;
  level.b_s2_mq_complete = 1;
  var_4 = scripts\engine\utility::getstructarray("s2_mq_final_reward_chest_loc", "targetname");

  foreach(var_6 in var_4) {
    spawn_golden_chest(var_6.origin, var_6.angles);
  }

  wait 0.5;
  var_8 = scripts\engine\utility::getstructarray("s2_mq_final_reward_loc", "targetname");

  foreach(var_6 in var_8) {
    drop_final_loot(var_6);
  }

  wait 0.5;

  foreach(var_1 in level.players) {
    var_1 thread _id_0752::_id_7003("s2_mq_complete");
  }
}

spawn_golden_chest(var_0, var_1) {
  var_2 = var_0 + (0, 0, 32);
  var_3 = var_0 - (0, 0, 32);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, var_4);

  if(var_5["fraction"] < 1.0) {
    var_6 = var_5["position"];
  } else {
    var_6 = var_3;
  }

  var_7 = _func_03C5("s4_zm_loot_chest", var_6 - (0, 0, 2), var_1);
  var_7 setscriptablepartstate("zm_loot_chest", "closed");
  var_7 setscriptablepartstate("fx", "closed");
  var_7.objectiveiconlocation = spawn("script_model", var_7.origin);
  var_7.objectiveiconparams = spawnStruct();
  var_7.objectiveiconparams._id_E747 = "active";
  var_7.objectiveiconparams._id_96CF = var_7.objectiveiconlocation;
  var_7.objectiveiconparams._id_7C3B = "v_ui_icons_zombies_minimap_chest";
  var_7.objectiveiconparams.minimapiconsize = "icon_regular";
  var_7.objectiveiconparams.hideonminimapwhenclipped = 1;
  var_7.objectiveiconparams.setbackground = 1;
  var_7.markerlabel = "chest_poi";
  var_7.instanceindex = _id_0987::add_instanced_objective_marker(var_7.markerlabel, var_7.objectiveiconparams);
  var_7 thread chest_life_watcher();
}

chest_life_watcher() {
  level endon("end_game");
  self endon("death");
  level waittill("players_landed");
  self _meth_86BE();
}

drop_final_loot(var_0) {
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
  wait 1.35;
  var_2 = level.cache_drop_table_names["syphoncore"];

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = _id_073D::get_highest_round_loot_table(var_2, scripts\cp\utility::_id_6871());

  if(isDefined(var_1)) {
    playFX(level._effect["mq_final_reward"], var_1.origin);
    var_1 playSound("zmb_exfil_portal_open");
    _id_073D::select_and_spawn_items_from_table(var_3, var_1.origin + (0, 0, 48), var_1.angles, undefined, "syphoncore", 20, undefined, 0.2, "zmb_spawn_portal", var_1);
  }
}

get_mq_final_pap_cost() {
  return 0;
}

hide_exfil_interact() {
  if(isDefined(level._id_570D) && isDefined(level._id_570D._id_E5F6)) {
    level._id_570D._id_5713 = 0;
    level._id_570D._id_E5F6 thread _id_06EF::_id_833C(0);
    level._id_570D._id_E5F6 setscriptablepartstate("fx", "inactive");
    scripts\cp\zombies\zm_hub_portals::remove_start_interact_marker(level._id_570D, level._id_570D._id_E5F6);
  }
}

player_disconnect_drop_shield_watcher() {
  level endon("game_ended");
  level endon("s2_mq_done");
  self waittill("disconnect");
  drop_shield_check(self);
}

player_death_drop_shield_watcher() {
  level endon("game_ended");
  level endon("s2_mq_done");
  self waittill("death");

  if(isDefined(self)) {
    drop_shield_check(self);
    thread player_death_drop_shield_watcher();
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
  foreach(var_3 in level.players) {
    if(!scripts\engine\utility::is_equal(var_3, var_0)) {
      var_6 = scripts\cp\cp_weapon::buildweapon("s4_me_rindigoww_mp");
      _id_092E::_id_E24D(var_6, var_3.origin + (0, 0, 20) + anglesToForward(var_3.origin) * 5, var_3.angles, undefined);
      return;
    }
  }

  return;
}