/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_ee.gsc
***************************************************/

init() {
  level.upgrade_machine_reveal_func = ::wait_for_upgrade_machine_arrived;
  _id_0557::_id_7846("quest_get_bearings", _id_0557::_id_30D8, [], &"ZOMBIE_BERLIN_HINT_QUEST_GET_BEARINGS");
  _id_0557::_id_781E("quest_get_bearings", "step_get_bearings", ::quest_step_get_bearings, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_GET_BEARINGS");
  _id_0557::_id_7848("quest_get_bearings");
  common_scripts\utility::flag_init("flag_exit_underbelly");
  common_scripts\utility::flag_init("flag_straub_death_scene");
  _id_0557::_id_7846("quest_contact_hq", _id_0557::_id_30D8, ["quest_get_bearings"], &"ZOMBIE_BERLIN_HINT_QUEST_CONTACT_HQ");
  _id_0557::_id_781E("quest_contact_hq", "step_find_radio", ::quest_step_find_radio, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_RADIO");
  _id_0557::_id_781E("quest_contact_hq", "step_use_radio", ::quest_step_use_radio, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_USE_RADIO");
  _id_0557::_id_7848("quest_contact_hq");
  _id_0557::_id_7846("quest_contact_soviets", _id_0557::_id_30D8, ["quest_contact_hq"], &"ZOMBIE_BERLIN_HINT_QUEST_CONTACT_SOVIETS");
  _id_0557::_id_781E("quest_contact_soviets", "step_contact_soviets", ::quest_step_use_radio_codes_listener, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_CONTACT_SOVIETS");
  _id_0557::_id_7848("quest_contact_soviets");
  _id_0557::_id_7846("quest_draw_airship", _id_0557::_id_30D8, ["quest_contact_soviets"], &"ZOMBIE_BERLIN_HINT_QUEST_DRAW_AIRSHIP");
  _id_0557::_id_781E("quest_draw_airship", "step_ignite_flare", _id_0557::_id_30D8, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_IGNITE_FLARE");
  _id_0557::_id_7848("quest_draw_airship");
  common_scripts\utility::flag_init("flag_drop_pod_reached_airship");
  thread airship_master_logic();
  thread setup_airship_anchors();
  _id_0557::_id_7846("quest_bring_down_airship", _id_0557::_id_30D8, ["quest_draw_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_BRING_DOWN_AIRSHIP");
  _id_0557::_id_781E("quest_bring_down_airship", "step_reel_anchors", ::quest_step_airship_anchors, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_REEL_ANCHORS");
  _id_0557::_id_781E("quest_bring_down_airship", "step_enter_dropcage", ::quest_drop_pod_enter_drop_pod_listener, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_ENTER_DROPCAGE");
  _id_0557::_id_781E("quest_bring_down_airship", "step_raise_dropcage", _id_0557::_id_30D8, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_RAISE_DROPCAGE");
  _id_0557::_id_7848("quest_bring_down_airship");
  thread quest_drop_pod_init();
  _id_0557::_id_7846("quest_the_wunderbuss", _id_0557::_id_30D8, ["quest_draw_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_ASSEMBLE_WUNDERBUSS");
  _id_0557::_id_781E("quest_the_wunderbuss", "step_assemble_weapon", _id_0557::_id_30D8, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_PARTS");
  _id_0557::_id_7848("quest_the_wunderbuss");
  thread quest_wunderbuss_init();
  _id_0557::_id_7846("quest_defeat_straub", _id_0557::_id_30D8, ["quest_bring_down_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_DEFEAT_STRAUB");
  _id_0557::_id_781E("quest_defeat_straub", "step_find_straub", ::quest_step_find_way_through_cargo_bay, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_STRAUB");
  _id_0557::_id_781E("quest_defeat_straub", "step_override_electroschnell", ::quest_step_overload_straubs_electroschnell, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_OVERRIDE_ELECTROSCHNELL");
  _id_0557::_id_7848("quest_defeat_straub");
  _id_0557::_id_7846("quest_bob", _id_0557::_id_30D8, ["quest_defeat_straub"], &"ZOMBIE_BERLIN_HINT_QUEST_BOB");
  _id_0557::_id_781E("quest_bob", "step_defeat_bob", ::quest_step_defeat_bob, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_DEFEAT_BOB");
  _id_0557::_id_781E("quest_bob", "step_escape_airship", ::escape_airship_logic, _id_0557::_id_30D8, &"ZOMBIE_BERLIN_HINT_STEP_ESCAPE_AIRSHIP");
  _id_0557::_id_7848("quest_bob");
  thread quest_init_defeat_straub();
  thread escape_airship_init();
  thread flare_box_init();
  thread quest_pap_init();
  thread js_sewer_board();
  thread js_dancer();
  level thread maps\mp\_utility::_id_6F74(maps\mp\mp_zombie_berlin_utils::spine_player_manager);
  thread debug_show_tp_org();
  thread debug_cheat_give_wonderweapon();
  thread debug_cheat_give_battery();
  thread debug_cheat_give_bolt();
  thread debug_cheat_lower_drop_pod();
  thread debug_cheat_bell_race_complete();
  thread the_classic_init();
  thread hangman_setup();
  thread bell_race_init();
  thread bonus_ee_audiolog_dancer_init();
  thread transmedia_event_init();
}

__________________get_bearings__________________() {}

quest_step_get_bearings() {
  level endon(_id_0557::_id_7838("quest_get_bearings", "step_get_bearings"));
  var_0 = getEntArray("quest_trig_get_bearings", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread maps\mp\mp_zombie_berlin_utils::complete_quest_on_trigger("quest_get_bearings", "step_get_bearings");
    var_2 thread quest_step_get_bearings_complete();
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_logic();
}

quest_step_get_bearings_complete() {
  level endon(_id_0557::_id_7838("quest_get_bearings", "step_get_bearings"));
  self waittill("trigger");
  var_0 = getEntArray("quest_trig_get_bearings", "targetname");

  foreach(var_2 in var_0) {
    var_2 common_scripts\utility::_id_9D9F();
  }

  common_scripts\utility::flag_set("flag_exit_underbelly");
  _iprintlnbold("We have to find a radio and contact HQ for help!");
}

___________________find_radio___________________() {}

quest_step_find_radio() {
  level endon(_id_0557::_id_7838("quest_contact_hq", "step_find_radio"));
  maps\mp\mp_zombie_berlin_utils::radio_system_setup();
  var_0 = _getEnt("quest_trig_find_radio", "targetname");
  var_0 thread maps\mp\mp_zombie_berlin_utils::complete_quest_on_trigger("quest_contact_hq", "step_find_radio");
  var_0 thread quest_step_find_radio_complete();
}

quest_step_find_radio_complete() {
  var_0 = _getEnt("radio_tuner_right", "targetname");
  var_1 = 0;

  while(var_1 == 0) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, var_0.origin) < 300) {
        var_4 = _id_0380::_id_288B("zmb_berl_gfm_radio_help", undefined, var_0);
        _id_0380::_id_288F(var_4, var_0, "radio_help_dlg_done");
        level notify("radio_found");
        var_1 = 1;
      }
    }

    wait 1;
  }

  var_0 waittill("radio_help_dlg_done");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("radio_found");
}

quest_step_use_radio() {
  level endon(_id_0557::_id_7838("quest_contact_hq", "step_use_radio"));
  quest_setup_use_radio_waitfor_playeruse();
  thread quest_step_use_radio_complete();
}

quest_setup_use_radio_waitfor_playeruse() {
  thread maps\mp\mp_zombie_berlin_utils::radio_system_init();
  level waittill("player_used_radio", var_0);
  level.radio_user = var_0;
  thread quest_setup_use_radio_listener(var_0);
}

quest_step_use_radio_complete() {
  _id_0557::_id_782D("quest_contact_hq", "step_use_radio");
  wait 0.5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("radio_range_discovery");
  _iprintlnbold("Damn! It's only a short-range radio.");
  wait 3;
  _iprintlnbold("The Red Army is our only hope now.");
  wait 3;
  _iprintlnbold("We need to figure out what to tune this to.");
}

__________________contact_soviets__________________() {}

quest_step_use_radio_codes_listener() {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_contact_hq", "step_use_radio"));
  _id_054D::giveplayersexp("berlin_exp_ref_23");
  var_0 = 0;

  while(!var_0) {
    while(!quest_step_use_radio_codes_check(level.radio_code_right, "right") || !quest_step_use_radio_codes_check(level.radio_code_left, "left")) {
      waitframe();
    }

    var_1 = 2500;
    var_2 = gettime();
    var_3 = 0;

    while(var_1 > var_3) {
      if(quest_step_use_radio_codes_check(level.radio_code_right, "right") && quest_step_use_radio_codes_check(level.radio_code_left, "left")) {
        var_3 = gettime() - var_2;

        if(var_1 <= var_3) {
          var_0 = 1;
          break;
        }
      }

      waitframe();
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_4 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_4] = [];
  level.possible_radio_codes[var_4]["left"] = level.radio_code_left;
  level.possible_radio_codes[var_4]["right"] = level.radio_code_right;
  thread maps\mp\mp_zombie_berlin_utils::radio_system_suspend_tuning_for_response();
  _id_054D::giveplayersexp("berlin_exp_ref_22");

  if(isDefined(level.radio_user)) {
    level.radio_user _id_0367::_id_8E3C("radio_conversation_start");
  }

  _id_0378::_id_8D74("aud_radio_tuning", "dialog_playing", "zmb_berl_mkh_radio_conversation_reply");
  wait 23;

  if(isDefined(level.radio_user)) {
    level.radio_user _id_0367::_id_8E3C("radio_conversation_end");
  }

  _iprintlnbold("Russians need to know you're on their side.");
  wait 3;
  _iprintlnbold("They ask you to take down Straub's airship.");
  wait 3;
  thread quest_step_contact_soviets_complete();
}

quest_step_use_radio_codes_check(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 = int(var_0);
  var_2 = 2;

  if(!isDefined(level.tuner_values) || !isDefined(level.tuner_values["radio_tuner"]) || !isDefined(level.tuner_values["radio_tuner"][var_1])) {
    return 0;
  }

  for(var_3 = -1 * var_2; var_3 < var_2; var_3++) {
    if(var_0 == level.tuner_values["radio_tuner"][var_1] + var_3) {
      return 1;
    }
  }

  return 0;
}

quest_setup_use_radio_listener(var_0) {
  while(!common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_contact_soviets", "step_contact_soviets"))) {
    var_0 waittill("stop_using_station");
    level waittill("player_used_radio", var_0);
    level.radio_user = var_0;
  }
}

quest_step_contact_soviets_complete() {
  _id_0557::_id_782D("quest_contact_soviets", "step_contact_soviets");
}

__________________attract_airship__________________() {}

quest_step_find_flare() {
  thread flare_box_helper();
  wait 4;
  _iprintlnbold("We've got to find some way to draw in the airship!");
}

flare_box_init() {
  var_0 = _getEnt("flare_crate_closed", "script_noteworthy");
  var_1 = _getEnt("flare_crate_interact_trig", "targetname");
  var_2 = _getEnt("trig_dmg_flare_lock", "script_noteworthy");
  var_3 = _getEnt("trig_dmg_flare_crate", "script_noteworthy");
  var_4 = 0;
  var_5 = 0;
  var_2 waittill("damage");
  self notify("notify_crate_smash_open");
  level thread common_scripts\_exploder::_id_088E(224);
  _id_0378::_id_8D74("aud_open_flare_crate", var_0.origin);
  var_0 scriptmodelplayanimdeltamotionfrompos("zom_berlin_flare_box_open", var_0.origin, var_0.angles);
  var_4 = 1;
  waitframe();

  for(;;) {
    var_3 waittill("damage");
    _id_0378::_id_8D74("aud_flare_triggered", var_0.origin);
    var_6 = _getEnt("origin_flare_crate_fx", "targetname");
    playFX(level._effect["flare_sparks"], var_6.origin);
    wait 0.5;
    playFX(level._effect["zmb_ber_warning_flare"], var_6.origin);
    playFX(level._effect["flare_sparks"], var_6.origin);
    wait 0.4;
    playFX(level._effect["flare_sparks"], var_6.origin);
    playFX(level._effect["zmb_ber_warning_flare"], var_6.origin);
    wait 1;

    if(common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_contact_soviets", "step_contact_soviets")) && !common_scripts\utility::_id_3C77("flag_airship_summoned")) {
      common_scripts\utility::flag_set("flag_airship_summoned");
      common_scripts\utility::flag_set("flag_sizzlers_active");
      _iprintlnbold("Airship summoned!");
      _id_0557::_id_782D("quest_draw_airship", "step_ignite_flare");
      _id_054D::giveplayersexp("berlin_exp_ref_21");

      foreach(var_8 in level.players) {
        var_8 thread maps\mp\mp_zombie_berlin_utils::vo_first_sizzler_transformation();
      }

      wait 2;
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("flares_fired");
      wait 1.5;
      thread maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_recognise_alt", "exterior", 0, level.straub_airship);
      wait 8.5;
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_en_route");
      wait 15;
      maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_drop_pod_alt_1", "exterior", 0, level.straub_airship);
      wait 2;
      _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_tethered");
    }

    wait 5;
  }
}

flare_box_helper() {
  level endon(_id_0557::_id_7838("quest_draw_airship", "step_find_flare"));
  var_0 = level._id_A980 + 2;

  if(!1) {
    var_1 = level._id_A980;
    var_0 = var_1 + 2;

    if(1) {
      wait 200;
    }

    if(1) {
      if(level._id_A980 <= var_0) {
        for(;;) {
          level waittill("zombie_wave_started");

          if(level._id_A980 > var_0) {
            break;
          }
        }
      }
    }

    level.flare_box_helper_tripped = 1;
  }
}

flare_box_highlight(var_0) {
  if(1) {
    if(!isDefined(level.flare_crate_data)) {
      var_1 = _getEnt("flare_crate_closed", "script_noteworthy");
      level.flare_crate_data = _id_0557::_id_782F(undefined, var_1);
    }

    if(var_0) {
      _id_0557::_id_781D("quest_draw_airship", level.flare_crate_data);
    } else {
      _id_0557::_id_7847("quest_draw_airship", level.flare_crate_data);
    }
  }
}

flare_crate_smash_open() {}

__________________bring_down_airship__________________() {}

setup_airship_anchors() {
  common_scripts\utility::flag_init("flag_airship_anchor_a_reeled");
  common_scripts\utility::flag_init("flag_airship_anchor_b_reeled");
  common_scripts\utility::flag_init("flag_airship_anchor_c_reeled");
  common_scripts\utility::flag_init("flag_airship_anchor_d_reeled");
  common_scripts\utility::flag_init("flag_airship_anchor_c_being_charged");
  common_scripts\utility::_id_3C7B("flag_airship_anchor_c_being_charged");
  var_0 = _getEnt("origin_anchor_base_a", "script_noteworthy");
  var_0 hide();
}

quest_step_airship_anchors() {
  var_0 = getEntArray("airship_anchor_model", "script_noteworthy");
  var_1 = getEntArray("airship_anchor_ring", "script_noteworthy");

  foreach(var_3 in var_0) {
    var_3.tether_ambient_effects = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_ambient"], var_3, "Tag_Origin");
    _triggerfx(var_3.tether_ambient_effects);

    foreach(var_5 in var_1) {
      if(var_5.setlookatent == var_3.setlookatent) {
        var_3.ring = var_5;
        var_3.ring.origin = var_3.origin;
        var_3.ring linkTo(var_3, "glow_ring");
        break;
      }
    }

    var_7 = 125;
    var_3.damage_trig = undefined;

    switch (var_3.setlookatent) {
      case "airship_tether_refuge":
        var_3.damage_trig = _getEnt("airship_anchor_trig_refuge", "script_noteworthy");
        var_3.damage_trig thread airship_anchor_get_blasted(var_3, var_7, "flag_airship_anchor_a_reeled");
        var_3.damage_trig thread airship_anchor_charge_wait_for_damage(var_3, var_7);
        break;
      case "airship_tether_underbelly":
        var_3.damage_trig = _getEnt("airship_anchor_trig_underbelly", "script_noteworthy");
        var_3.damage_trig thread airship_anchor_get_blasted(var_3, var_7, "flag_airship_anchor_b_reeled");
        var_3.damage_trig thread airship_anchor_charge_wait_for_damage(var_3, var_7);
        break;
      case "airship_tether_courtyard":
        var_3.damage_trig = _getEnt("airship_anchor_trig_courtyard", "script_noteworthy");
        var_3.damage_trig thread airship_anchor_get_blasted(var_3, var_7, "flag_airship_anchor_c_reeled");
        var_3.damage_trig thread airship_anchor_charge_wait_for_damage(var_3, var_7);
        var_3 thread airship_anchor_soul_bucket(10, "flag_airship_anchor_c_reeled");
        break;
      case "airship_tether_museum":
        var_3.damage_trig = _getEnt("airship_anchor_trig_museum", "script_noteworthy");
        var_3.damage_trig thread airship_anchor_get_blasted(var_3, var_7, "flag_airship_anchor_d_reeled");
        var_3.damage_trig thread airship_anchor_charge_wait_for_damage(var_3, var_7);
        var_3.damage_trig thread airship_anchor_museum_first_shot(var_3);
        break;
      default:
        break;
    }

    var_3.damage_trig enablelinkTo();
    var_3.damage_trig linktosynchronizedparent(var_3);
    var_3.damage_trig setcontents(var_3.damage_trig _meth_85A0() | 256);
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_airship_anchor_damage();
  thread maps\mp\mp_zombie_berlin_utils::vo_straub_airship_anchor_damage();
  level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];
  common_scripts\utility::_id_3CA1(level.airship_anchor_flag_array);
  _id_054D::giveplayersexp("berlin_exp_ref_16");
  _id_0557::_id_782D("quest_bring_down_airship", "step_reel_anchors");
}

airship_anchor_get_blasted(var_0, var_1, var_2) {
  thread airship_anchor_wonderweapon_collection(var_0, var_1, var_2);
  level waittill("airship_anchor_courtyard_impact");

  while(!common_scripts\utility::_id_3C77(var_2)) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_12) && var_12 == "wunderbuss_zm" && !common_scripts\utility::_id_3C89(var_2)) {
      self notify("notify_airship_anchor_blasted");
      level notify("airship_anchor_damaged");

      if(!isDefined(self.tether_impact)) {
        self.tether_impact = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_charge"], var_0, "Tag_Origin");
      }

      _triggerfx(self.tether_impact);
    }

    waitframe();
  }

  if(isDefined(self.tether_impact)) {
    self.tether_impact delete();
  }
}

airship_anchor_museum_first_shot(var_0) {
  self waittill("notify_airship_anchor_blasted");
  playFX(level._effect["zmb_tether_rock_burst"], var_0.origin);
}

airship_anchor_soul_bucket(var_0, var_1) {
  level endon(var_1);
  level waittill("airship_anchor_courtyard_impact");
  var_2 = _getEnt("origin_anchor_base_a", "script_noteworthy");
  var_2 setModel("tag_origin");
  var_2 show();
  self.percent_filled = 0;
  thread airship_anchor_charge_progress_vfx();
  thread airship_anchor_soul_bucket_charge(var_0, var_2);
  var_2 maps\mp\mp_zombies_soul_collection::_id_170B(var_0, 180, 140, "zmb_anchor_c_zombie_killed", undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 100));

  if(!common_scripts\utility::_id_3C77("flag_airship_anchor_c_reeled")) {
    if(!isDefined(level.airship_lower_percentage)) {
      level.airship_lower_percentage = 0;
    }

    level.airship_lower_percentage = level.airship_lower_percentage + 25;
    playFX(level._effect["zmb_ber_zep_tether_charge"], var_2.origin);
    _iprintlnbold("soul collection for " + var_1 + " end");
    common_scripts\utility::flag_set(var_1);
    var_3 = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_on"], self, "Tag_Origin");
    _triggerfx(var_3);
    self notify("anchor_charge_complete");
    common_scripts\utility::_id_3C7B("flag_airship_anchor_c_being_charged");
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
  }
}

airship_anchor_wonderweapon_collection(var_0, var_1, var_2) {
  self.timesblasted = 0;
  var_0.percent_filled = 0;
  var_0 thread airship_anchor_charge_progress_vfx();

  while(var_1 > self.timesblasted) {
    self waittill("notify_airship_anchor_blasted");
    self.timesblasted++;
    var_0.percent_filled = self.timesblasted / var_1 * 100;
    waitframe();
  }

  if(!common_scripts\utility::_id_3C77(var_2)) {
    common_scripts\utility::flag_set(var_2);
    var_3 = _getEnt("origin_anchor_base_a", "script_noteworthy");
    level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, var_3);

    if(!isDefined(level.airship_lower_percentage)) {
      level.airship_lower_percentage = 0;
    }

    level.airship_lower_percentage = level.airship_lower_percentage + 25;
    var_0.tether_ambient_effects delete();
    var_4 = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_on"], var_0, "Tag_Origin");
    thread maps\mp\mp_zombie_berlin_lighting::set_anchor_fast_pulse_lights();
  }
}

airship_anchor_charge_progress_vfx() {
  for(;;) {
    if(self.percent_filled > 0) {
      var_0 = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_charge_a"], self, "Tag_Origin");
      _triggerfx(var_0);
      _iprintlnbold("Play 1-49% VFX");
      break;
    }

    waitframe();
  }

  for(;;) {
    if(self.percent_filled > 50) {
      var_1 = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_charge_b"], self, "Tag_Origin");
      var_0 delete();
      _triggerfx(var_1);
      _iprintlnbold("Play 50-99% VFX");
      break;
    }

    waitframe();
  }

  for(;;) {
    if(self.percent_filled >= 100) {
      var_2 = _spawnlinkedfx(level._effect["zmb_ber_zep_tether_charge_c"], self, "Tag_Origin");
      var_1 delete();
      _triggerfx(var_2);
      _iprintlnbold("Play 100% VFX");
      break;
    }

    waitframe();
  }
}

airship_anchor_soul_bucket_charge(var_0, var_1) {
  self endon("anchor_charge_complete");

  for(;;) {
    level waittill("zmb_anchor_c_zombie_killed");
    self.damage_trig.timesblasted = self.damage_trig.timesblasted + 4;
    self.percent_filled = var_1._id_AC2C * 10;

    if(!common_scripts\utility::_id_3C77("flag_airship_anchor_c_being_charged")) {
      airship_anchor_charge_soul_bucket_animation(var_0);
    }
  }
}

#using_animtree("animated_props_zombies_DLC2");

airship_anchor_charge_soul_bucket_animation(var_0) {
  self endon("anchor_charge_complete");
  common_scripts\utility::flag_set("flag_airship_anchor_c_being_charged");

  if(!isDefined(self.anim_progress)) {
    self.anim_progress = 0;
  }

  var_1 = _getanimlength(%s2_zom_zep_tether_scene_ring_up);
  var_2 = var_1 * var_0;
  self.ring scriptmodelplayanim("s2_zom_zep_tether_scene_ring_up", "", self.anim_progress * var_1, 1 / var_0);
  var_3 = 1 / var_0 * var_2;
  wait(var_3);
  self.ring setshadowrendering(1);
  self.anim_progress = self.anim_progress + clamp(1 / var_0, 0, 1);
  common_scripts\utility::_id_3C7B("flag_airship_anchor_c_being_charged");
}

airship_anchor_charge_wait_for_damage(var_0, var_1) {
  var_0 endon("anchor_charge_complete");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_11) && var_11 == "wunderbuss_zm" && !common_scripts\utility::_id_3C77("flag_airship_anchor_c_being_charged")) {
      var_0 thread airship_anchor_charge_ring_animation(var_1);
      var_0 thread airship_anchor_charge_ring_listen();
      var_0 waittill("anchor_ring_stop_charging");
    }
  }
}

airship_anchor_charge_ring_animation(var_0) {
  self endon("anchor_charge_complete");

  if(!isDefined(self.anim_progress)) {
    self.anim_progress = 0;
  }

  var_1 = _getanimlength(%s2_zom_zep_tether_scene_ring_up);
  var_2 = var_0 * 0.1;

  for(;;) {
    self.ring scriptmodelplayanim("s2_zom_zep_tether_scene_ring_up", "", self.anim_progress * var_1, 1 / var_2);
    common_scripts\utility::flag_set("flag_airship_anchor_c_being_charged");
    self.ring_start_time = gettime();
    var_3 = var_2 * (1 - self.anim_progress);

    if(var_3 < 0) {
      var_3 = 0;
    }

    var_4 = common_scripts\utility::_id_A74D("anchor_ring_stop_charging", var_3);

    if(isDefined(var_4) && var_4 == "timeout") {
      common_scripts\utility::_id_3C7B("flag_airship_anchor_c_being_charged");
      self notify("anchor_charge_complete");
    }

    self.ring setshadowrendering(1);
    var_5 = (gettime() - self.ring_start_time) * 0.001;
    self.anim_progress = self.anim_progress + clamp(var_5 / (var_0 * 0.1), 0, 1);
    common_scripts\utility::_id_3C7B("flag_airship_anchor_c_being_charged");
    break;
  }
}

airship_anchor_charge_ring_listen() {
  self endon("anchor_charge_complete");
  self endon("anchor_ring_stop_charging");
  var_0 = 0;
  var_1 = 1;
  var_2 = 0;

  for(;;) {
    wait 0.1;

    if(self.percent_filled > var_0) {
      thread play_tether_charge_audio(var_2);
      thread tether_charge_scale_pitch(self.percent_filled);
      var_2 = 1;
      var_1 = 1;
    } else {
      var_1 = 0;
      var_2 = 0;
    }

    if(!var_1) {
      self notify("anchor_ring_stop_charging");
    }

    var_0 = self.percent_filled;
  }
}

play_tether_charge_audio(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    _id_0380::_stoplocalsound(self.charge_audio_stop, 0.2);
    self.charge_audio_stop = undefined;
    self.charge_audio_start = _id_0380::_id_288B("zmb_berl_tether_winch_start", undefined, self);
    self.charge_audio_lp1 = _id_0380::_id_6844("zmb_berl_tether_winch_lp", undefined, self, 0.5);
    self.charge_audio_lp2 = _id_0380::_id_6844("zmb_berl_tether_winch_lp2", undefined, self, 0.5);
    self.charge_audio_lp3 = _id_0380::_id_6844("zmb_berl_tether_winch_lp3", undefined, self, 0.5);
    common_scripts\utility::_id_A70A("anchor_ring_stop_charging", "anchor_charge_complete");
    _id_0380::_stoplocalsound(self.charge_audio_start, 0.2);
    self.charge_audio_start = undefined;
    _id_0380::_id_6850(self.charge_audio_lp1, 0.5);
    self.charge_audio_lp1 = undefined;
    _id_0380::_id_6850(self.charge_audio_lp2, 0.5);
    self.charge_audio_lp2 = undefined;
    _id_0380::_id_6850(self.charge_audio_lp3, 0.5);
    self.charge_audio_lp3 = undefined;
    self.charge_audio_stop = _id_0380::_id_288B("zmb_berl_tether_winch_stop", undefined, self);
  }
}

tether_charge_scale_pitch(var_0) {
  var_1 = var_0 / 200 + 0.5;

  if(isDefined(self.charge_audio_lp1)) {
    _id_0380::_id_684D(self.charge_audio_lp1, var_1, 0.1);
  }
}

quest_drop_pod_enter_drop_pod_listener() {
  var_0 = _getEnt("quest_trig_enter_dropcage", "targetname");
  var_0 waittill("trigger");
  _id_0557::_id_782D("quest_bring_down_airship", "step_enter_dropcage");
}

quest_drop_pod_init() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_0 hide();
  var_0 notsolid();
  var_1 = _getEnt("dropcage_push_trigger", "targetname");
  var_1 enablelinkTo();
  var_1 linktosynchronizedparent(var_0);
  var_2 = _getEnt("pod_underneath_clip", "targetname");
  var_2 movez(-742, 0.05);
  waitframe();
  var_2 linktosynchronizedparent(var_0);
  var_2 notsolid();
  var_2 connectpaths();
  var_3 = _getEnt("drop_pod_cable", "script_noteworthy");
  var_3 hide();
  var_0.lightfx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_drop_pod_light"), var_0, "tag_origin");
  var_0.lightfx hide();
  var_4 = _getEnt("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_4 enablelinkTo();
  var_4 linktosynchronizedparent(var_0);
  var_4 hide();
  var_5 = _getEnt("clip_wpn_drop_pod_winch", "script_noteworthy");
  var_5 hide();
  var_5 linktosynchronizedparent(var_0);
  var_6 = _getEnt("clip_drop_pod_closed", "script_noteworthy");
  var_6 hide();
  var_6 notsolid();
  var_6 linktosynchronizedparent(var_0);
  var_7 = _getEnt("clip_drop_pod", "script_noteworthy");
  var_7 hide();
  var_7 notsolid();
  var_7 linktosynchronizedparent(var_0);
  var_8 = _getEnt("org_tp_plaza", "script_noteworthy");
  var_8 linktosynchronizedparent(var_0);
  var_9 = getEntArray("pod_player_teleport_spot", "script_noteworthy");

  foreach(var_11 in var_9) {
    var_11 linktosynchronizedparent(var_0);
  }

  var_13 = _getEnt("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_13 movez(-128, 0.05);
  waitframe();
  var_13 notsolid();
  var_13 connectpaths();
  var_14 = _getEnt("clip_door", "script_noteworthy");
  var_14 movez(-128, 0.05);
  waitframe();
  var_14 notsolid();
  var_14 connectpaths();
  var_15 = _getEnt("model_airship_drop_pod", "script_noteworthy");
  var_15.airpodlightfx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_drop_pod_light"), var_15, "tag_origin");
  _triggerfx(var_15.airpodlightfx);
  var_15.airpodlightfx hide();
  quest_drop_pod_logic();
}

quest_drop_pod_logic() {
  thread debug_lower_drop_pod_incremental_listen();
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_draw_airship", "step_ignite_flare"));
  wait 1;
  thread quest_drop_pod_show_pod();
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_bring_down_airship", "step_enter_dropcage"));
  level._id_6F1E = 1;
  thread quest_drop_pod_movement();
  thread quest_drop_pod_charge_init();
  thread quest_drop_pod_charge_drain();
  thread quest_drop_pod_teleport_to_airship();
}

quest_drop_pod_show_pod() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_0 show();
  var_0 solid();
  var_1 = _getEnt("drop_pod_cable", "script_noteworthy");
  var_1 show();
  var_0.lightfx show();
  var_2 = _getEnt("clip_drop_pod", "script_noteworthy");
  var_2 show();
  var_2 solid();
  var_3 = _getEnt("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_4 = _getEnt("clip_wpn_drop_pod_winch", "script_noteworthy");
  var_3 show();
  var_4 show();
  var_5 = _getEnt("org_drop_pod_winch_vfx", "script_noteworthy");
  var_6 = spawn("script_model", var_5.origin);
  var_6 setModel("tag_origin");
  var_6 linktosynchronizedparent(var_0);
  _playFXOnTag(level._effect["zmb_ber_droppod_roof"], var_6, "Tag_Origin");
}

quest_drop_pod_movement() {
  level endon(_id_0557::_id_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_0 = getEntArray("clip_drop_pod", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2._id_A045 = ::quest_drop_pod_unresolved_collision_func;
  }

  common_scripts\utility::flag_init("flag_drop_pod_can_be_charged");
  common_scripts\utility::flag_set("flag_drop_pod_can_be_charged");
  level.drop_pod_charge = 0;
  var_4 = _getEnt("drop_pod_model", "script_noteworthy");
  var_5 = _getEnt("clip_drop_pod_closed", "script_noteworthy");
  var_6 = 0;

  for(;;) {
    if(level.drop_pod_charge > 0 && !var_6) {
      thread quest_drop_pod_move_up_rumble();
      var_4 _id_0378::_id_8D74("droppod_winch_up");

      foreach(var_2 in var_0) {
        var_2._id_A045 = ::quest_drop_pod_unresolved_collision_func;
      }

      var_5 show();
      var_5 solid();
      _id_0378::_id_8D74("inside_droppod_submix_strt");
      level notify("drop_pod_moving_up");
      var_6 = 1;
    } else if(level.drop_pod_charge <= 0 && var_6) {
      var_9 = 0;

      if(isDefined(level.drop_pod_up_start_time)) {
        var_9 = (gettime() - level.drop_pod_up_start_time) * 0.001;
      }

      if(var_9 < 0) {
        var_9 = 0;
      }

      foreach(var_2 in var_0) {
        var_2._id_A045 = undefined;
      }

      maps\mp\_utility::_id_2CED(var_9, ::quest_drop_pod_impact_ground);
      thread quest_drop_pod_move_down_rumble();
      var_4 _id_0378::_id_8D74("droppod_winch_down");
      level notify("drop_pod_moving_down");
      level notify("stop_move_up_rumble");
      var_6 = 0;
      common_scripts\utility::_id_3C7B("flag_drop_pod_can_be_charged");
      common_scripts\utility::_id_3C9F("flag_drop_pod_can_be_charged");
    }

    waitframe();
  }
}

quest_drop_pod_move_up_rumble() {
  level endon("stop_move_up_rumble");
  var_0 = 1;

  for(;;) {
    wait(var_0);
    maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.1, var_0, 1000);
  }
}

quest_drop_pod_move_down_rumble() {
  level endon("stop_move_down_rumble");
  var_0 = 1;

  for(;;) {
    wait(var_0);
    maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.2, var_0, 10000);
  }
}

quest_drop_pod_impact_ground() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("clip_drop_pod_closed", "script_noteworthy");
  var_1 hide();
  var_1 notsolid();
  _id_0378::_id_8D74("inside_droppod_submix_stp");
  level notify("stop_move_down_rumble");
  maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.35, 0.5, 100000);
  common_scripts\utility::flag_set("flag_drop_pod_can_be_charged");
  var_0 _id_0378::_id_8D74("droppod_ground_impact");
}

quest_drop_pod_charge_init() {
  level endon(_id_0557::_id_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_0 = _getEnt("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_0 setcontents(var_0 _meth_85A0() | 256);
  var_0 setdamagecallbackon(1);
  var_0.damagecallback = ::quest_drop_pod_charge_damage_callback;
}

quest_drop_pod_charge_damage_callback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self notify("damage" + var_1._id_20D8);
  self endon("damage" + var_1._id_20D8);

  if(isDefined(var_5) && var_5 == "wunderbuss_zm") {
    self.hitby[var_1._id_20D8] = 1;
  }

  var_12 = quest_drop_pod_charge_check_for_all_players();

  if(var_12) {
    level.drop_pod_charge = level.drop_pod_charge + 1;
  }

  wait 0.5;
  self.hitby[var_1._id_20D8] = 0;
}

quest_drop_pod_charge_check_for_all_players() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(self.hitby[var_2._id_20D8])) {
      if(self.hitby[var_2._id_20D8] == 1) {
        var_0 = var_0 + 1;
      }
    }
  }

  if(var_0 == level.players.size) {
    return 1;
  } else {
    return 0;
  }
}

quest_drop_pod_charge_drain() {
  level endon(_id_0557::_id_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_0 = 100;
  var_1 = 0.1;
  var_2 = 1 / var_1;

  for(;;) {
    var_3 = level.players.size;

    if(level.drop_pod_charge > 0) {
      wait 1;

      switch (var_3) {
        case 1:
          var_4 = var_0 * var_3 / var_2 - var_3;
          level.drop_pod_charge = level.drop_pod_charge - var_4;
          break;
        case 2:
          var_4 = var_0 * var_3 / var_2 - var_3 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_4;
          break;
        case 3:
          var_4 = var_0 * var_3 / var_2 - var_3 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_4;
          break;
        case 4:
          var_4 = var_0 * var_3 / var_2 - var_3 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_4;
          break;
      }
    }

    if(level.drop_pod_charge < 0) {
      level.drop_pod_charge = 0;
    }

    waitframe();
  }
}

quest_drop_pod_teleport_to_airship() {
  level endon(_id_0557::_id_7838("quest_bring_down_airship", "step_raise_dropcage"));
  level waittill("drop_pod_reached_airship");
  common_scripts\utility::flag_set("flag_drop_pod_reached_airship");
  var_0 = _getEnt("clip_door", "script_noteworthy");
  var_0 delete();
  thread airship_audiolog_init();
  var_1 = _getEnt("org_tp_plaza", "script_noteworthy");
  var_2 = _getEnt("org_tp_airship", "script_noteworthy");

  foreach(var_4 in level.players) {
    var_4 _id_0378::_id_8D74("droppod_lock_in");
    var_4.relative_position = var_4.origin - var_1.origin;
    var_4 setOrigin(var_2.origin + var_4.relative_position);
  }

  _id_0547::playerspawneroverrideset("airship");
  var_6 = _id_0547::_id_408F();

  foreach(var_8 in var_6) {
    var_8 suicide();
  }

  thread quest_drop_pod_teleport_to_airship_turn_off_light();
  level notify("stop_move_down_rumble");
  level notify("stop_move_up_rumble");
  quest_drop_pod_entered_airship();
}

quest_drop_pod_teleport_to_airship_turn_off_light() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("model_airship_drop_pod", "script_noteworthy");
  var_0.lightfx hide();
  var_1.airpodlightfx show();
  _id_0378::_id_8D74("inside_droppod_submix_stp");
}

quest_drop_pod_entered_airship() {
  level notify("entered_airship_sizzler_pause");
  wait 1;
  thread maps\mp\mp_zombie_berlin_utils::airship_pods_animation();
  level._id_953D = spawn("script_model", (0, 0, 0));

  foreach(var_1 in level.players) {
    var_1 playersetgroundreferenceent(level._id_953D);
  }

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\mp_zombie_berlin_utils::airship_camera_sway();
  }

  _id_054D::giveplayersexp("berlin_exp_ref_19");
  _id_0557::_id_782D("quest_bring_down_airship", "step_raise_dropcage");
}

quest_drop_pod_unresolved_collision_func(var_0) {}

airship_master_logic() {
  common_scripts\utility::flag_init("flag_airship_summoned");
  common_scripts\utility::flag_init("flag_airship_reached_middle");
  common_scripts\utility::flag_init("flag_airship_fully_lowered");
  common_scripts\utility::flag_init("flag_airship_doors_opened");
  common_scripts\utility::flag_init("level_to_airship");
  level.airship = getEntArray("berlin_airship_map", "targetname");
  level.airship_active = 0;
  level.airship_doors_open = 0;
  level.airship_route_blockers = getEntArray("airship_route_blockers", "targetname");

  foreach(var_1 in level.airship) {
    var_1 maps\mp\mp_zombie_berlin_utils::airship_objects_hide();
  }

  maps\mp\mp_zombie_berlin_utils::hack_station_hide_all();
  thread maps\mp\mp_zombie_berlin_utils::airship_puzzle_doors_disable_buy();
  level thread maps\mp\mp_zombie_berlin_utils::airship_animation_master_handler();
  level.straub_airship = _getEnt("straub_airship_exterior_model", "script_noteworthy");
  level.straub_airship.canmakesizzlers = 0;
  var_3 = common_scripts\utility::_id_46B5("zeppelin_sizzler_cannon", "targetname");
  level.straub_airship.siz_cannon = var_3 maps\mp\mp_zombie_berlin_utils::airship_turret_build("turretweapon_zeppelin_siz_zm", var_3._id_0165, maps\mp\mp_zombie_berlin_utils::airship_turret_modify_player_damage, maps\mp\mp_zombie_berlin_utils::airship_turret_on_player_damage, maps\mp\mp_zombie_berlin_utils::airship_turret_modify_agent_damage, maps\mp\mp_zombie_berlin_utils::airship_turret_on_agent_damage);
  level.straub_airship.siz_cannon linktosynchronizedparent(level.straub_airship);
  level.straub_airship thread maps\mp\mp_zombie_berlin_utils::airship_turret_think();
  common_scripts\utility::_id_3C9F("flag_airship_summoned");
  level thread maps\mp\mp_zombie_berlin_utils::airship_straub_summon();
  common_scripts\utility::_id_3C9F("flag_airship_reached_middle");
  level thread maps\mp\mp_zombie_berlin_utils::airship_lowering_handler();
  thread maps\mp\mp_zombie_berlin_lighting::set_anchor_pulse_lights_on();
  common_scripts\utility::_id_3C9F("flag_airship_fully_lowered");
  level thread maps\mp\mp_zombie_berlin_utils::airship_interior_state_swap();
  common_scripts\utility::_id_3C9F("flag_airship_doors_opened");
  common_scripts\utility::flag_set("level_to_airship");
  level thread maps\mp\mp_zombie_berlin_utils::airship_route_blockers_state_swap();
}

warp_lower_drop_pod() {
  common_scripts\utility::flag_set("flag_airship_anchor_a_reeled");
  common_scripts\utility::flag_set("flag_airship_anchor_b_reeled");
  common_scripts\utility::flag_set("flag_airship_anchor_c_reeled");
  common_scripts\utility::flag_set("flag_airship_anchor_d_reeled");
}

debug_show_tp_org() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("debug_drop_pod_tp", "script_noteworthy");
  var_1 linktosynchronizedparent(var_0);
  var_1 notsolid();
  var_1 hide();
}

debug_drop_pod_position() {
  level endon("drop_pod_reached_airship");
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("org_tp_plaza", "script_noteworthy");

  foreach(var_3 in level.players) {
    for(;;) {
      var_3.relative_position = var_3.origin - var_1.origin;
      _iprintlnbold(var_3.relative_position);
      wait 0.5;
    }
  }
}

debug_drop_pod_position_airship() {
  level waittill("drop_pod_reached_airship");
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("org_tp_airship", "script_noteworthy");

  foreach(var_3 in level.players) {
    for(;;) {
      var_3.relative_position = var_3.origin - var_1.origin;
      _iprintlnbold(var_3.relative_position);
      wait 0.5;
    }
  }
}

debug_lower_drop_pod_incremental_listen() {
  if(!isDefined(level.airship_anchor_flag_array)) {
    level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];
  }

  level waittill("debug_lower_drop_pod");
  common_scripts\utility::flag_set(level.airship_anchor_flag_array[0]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::flag_set(level.airship_anchor_flag_array[1]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::flag_set(level.airship_anchor_flag_array[2]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::flag_set(level.airship_anchor_flag_array[3]);
}

debug_cheat_lower_drop_pod() {}

__________________build_wunderbuss__________________() {}

quest_wunderbuss_init() {
  common_scripts\utility::flag_init("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_battery_placed");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_geistbolt_collected");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_geistbolt_placed");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_holding_battery");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_wunderbuss_built");
  common_scripts\utility::flag_init("flag_quest_wunderbuss_escape_smugglers_den");
  level.smuggler_den_doors_open = 0;
  thread quest_wunderbuss_init_bench();
  var_0 = common_scripts\utility::_id_46B5("weapon_assembly_bench", "targetname");
  var_0 thread quest_wunderbuss_build_weapon();
  quest_wunderbuss_logic();
}

quest_wunderbuss_logic() {
  thread quest_wunderbuss_collect_battery();
  thread quest_wunderbuss_collect_bolt();
  thread quest_wunderbuss_access_smuggler_den();
  common_scripts\utility::_id_3C9F("flag_quest_wunderbuss_wunderbuss_built");
  thread quest_wunderbuss_escape_smuggler_den();
}

quest_wunderbuss_collect_battery() {
  var_0 = getEntArray("wunderbuss_part_battery", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_4 = _randomintrange(0, var_0.size);
  var_5 = var_0[var_4];
  var_5 show();
  var_6 = undefined;
  var_7 = undefined;
  var_8 = common_scripts\utility::_id_44BE(var_5.target, "targetname");

  foreach(var_10 in var_8) {
    switch (var_10._id_0165) {
      case "wunderbuss_trig_battery":
        var_6 = _getEnt(var_10.targetname, "targetname");
        break;
      case "wunderbuss_battery_vfx_org":
        var_11 = common_scripts\utility::_id_46B5(var_10.targetname, "targetname");
        var_7 = spawn("script_model", var_11.origin);
        var_7 setModel("tag_origin");
        _playFXOnTag(level._effect["red_dot_light"], var_7, "tag_origin");
        break;
    }
  }

  var_6 waittill("trigger");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_holding_battery");
  _id_0378::_id_8D74("wonderbuss_build_collect_battery", var_6.origin);

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  _killfxontag(level._effect["red_dot_light"], var_7, "tag_origin");
}

quest_wunderbuss_collect_bolt() {
  _id_0547::_id_7BA9(maps\mp\mp_zombie_berlin_utils::spine_zombie_collect_listener);
  common_scripts\utility::_id_3C9F("flag_quest_wunderbuss_geistbolt_collected");
  _id_0547::_id_2D8C(maps\mp\mp_zombie_berlin_utils::spine_zombie_collect_listener);
}

quest_wunderbuss_access_smuggler_den() {
  level endon("flag_quest_wunderbuss_wunderbuss_built");
  var_0 = _getEnt("wunderbuss_trig_smuggler_door", "script_noteworthy");
  var_1 = _getEnt("wunderbuss_smuggler_door_battery", "script_noteworthy");
  var_1 hide();
  var_2 = getEntArray("smuggler_den_door_main_body", "script_noteworthy");
  var_3 = getEntArray("smuggler_den_door_bot", "targetname");
  var_4 = getEntArray("smuggler_den_door_top", "targetname");

  foreach(var_6 in var_3) {
    var_6 movez(128, 0.1);
  }

  foreach(var_6 in var_4) {
    var_6 movez(128, 0.1);
  }

  common_scripts\utility::_id_3C9F("flag_quest_wunderbuss_battery_collected");
  _id_054D::giveplayersexp("berlin_exp_ref_9");

  for(;;) {
    var_0 waittill("trigger");

    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_holding_battery")) {
      _id_0378::_id_8D74("wonderbuss_build_battery_door_unlock", var_1.origin);
      var_1 show();
      common_scripts\utility::_id_3C7B("flag_quest_wunderbuss_holding_battery");
      level thread common_scripts\_exploder::_id_2A6D(219, undefined, 0);
      level thread common_scripts\_exploder::_id_088E(220);

      if(!level.smuggler_den_doors_open) {
        quest_wunderbuss_open_close_doors();
      }
    } else if(!common_scripts\utility::_id_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed")) {
      _id_0378::_id_8D74("wonderbuss_build_battery_door_lock", var_1.origin);
      var_1 hide();
      common_scripts\utility::flag_set("flag_quest_wunderbuss_holding_battery");
      level thread common_scripts\_exploder::_id_2A6D(220, undefined, 0);
      level thread common_scripts\_exploder::_id_088E(219);

      if(level.smuggler_den_doors_open) {
        quest_wunderbuss_open_close_doors();
        thread quest_wunderbuss_escape_smuggler_den_reset_check();
      }
    }

    wait 1;
  }
}

quest_wunderbuss_build_weapon() {
  self.assembly_trig thread quest_wunderbuss_hint_strings();
  self.assembly_trig thread quest_wunderbuss_build_part(self.assembly_model_battery, "flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_battery_placed");
  self.assembly_trig thread quest_wunderbuss_build_part(self.assembly_model_bolt, "flag_quest_wunderbuss_geistbolt_collected", "flag_quest_wunderbuss_geistbolt_placed");

  while(!common_scripts\utility::_id_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed") && common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      common_scripts\utility::flag_set("flag_quest_wunderbuss_wunderbuss_built");
      continue;
    }

    waitframe();
  }

  var_0 = _getEnt("wunderbuss_weapon_complete", "script_noteworthy");
  var_0 show();
  thread quest_wunderbuss_give_wunderbuss();
  _id_0557::_id_782D("quest_the_wunderbuss", "step_assemble_weapon");
}

quest_wunderbuss_hint_strings() {
  level thread give_exp_on_bolt_found();
  common_scripts\utility::_id_3CA2("flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_geistbolt_collected");

  while(!common_scripts\utility::_id_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_collected") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      self setHintString(&"ZOMBIE_BERLIN_PART_PLACE");
    }

    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_collected") && common_scripts\utility::_id_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed")) {
      self setHintString(&"ZOMBIE_BERLIN_PART_PLACE");
    }

    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_placed") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_collected")) {
      self setHintString(&"ZOMBIE_BERLIN_PART_REMOVE");
    }

    if(!common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_collected") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed")) {
      self setHintString(" ");
    }

    common_scripts\utility::_id_3CA2("flag_quest_wunderbuss_geistbolt_placed", "flag_quest_wunderbuss_battery_placed", "flag_quest_wunderbuss_holding_battery", "flag_quest_wunderbuss_geistbolt_collected");
    waitframe();
  }

  self setHintString(&"ZOMBIE_BERLIN_WEAPON_PICKUP");
}

give_exp_on_bolt_found() {
  common_scripts\utility::_id_3C9F("flag_quest_wunderbuss_geistbolt_collected");
  _id_054D::giveplayersexp("berlin_exp_ref_12");
}

quest_wunderbuss_build_part(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B5("weapon_assembly_bench", "targetname");
  var_4 = common_scripts\utility::_id_44BE(var_3.target, "targetname");
  common_scripts\utility::_id_3C9F(var_1);

  for(;;) {
    self waittill("trigger");

    if(var_1 == "flag_quest_wunderbuss_battery_collected") {
      if(common_scripts\utility::_id_3C77(var_2)) {
        common_scripts\utility::flag_set("flag_quest_wunderbuss_holding_battery");
        common_scripts\utility::_id_3C7B(var_2);

        foreach(var_6 in var_4) {
          if(var_6._id_0165 != "wunderbuss_weapon_base") {
            var_6 hide();
            continue;
          }

          if(var_6._id_0165 == "wunderbuss_weapon_base") {
            var_6 show();
          }
        }

        self setHintString(" ");
      } else if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_holding_battery")) {
        foreach(var_6 in var_4) {
          var_6 hide();
        }

        var_0 show();
        level thread common_scripts\_exploder::_id_088E(207);
        _id_0378::_id_8D74("wonderbuss_weapon_build_infusion", var_0.origin);
        self setHintString(" ");
        common_scripts\utility::_id_3C7B("flag_quest_wunderbuss_holding_battery");
        common_scripts\utility::flag_set(var_2);
      }
    } else if(!common_scripts\utility::_id_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      foreach(var_6 in var_4) {
        var_6 hide();
      }

      var_0 show();
      level thread common_scripts\_exploder::_id_088E(208);
      _id_0378::_id_8D74("wonderbuss_weapon_build_infusion", var_0.origin);
      self setHintString(" ");
      common_scripts\utility::flag_set(var_2);
    }

    if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
      level thread common_scripts\_exploder::_id_088E(224);

      foreach(var_6 in var_4) {
        var_6 hide();
      }

      var_3 = common_scripts\utility::_id_46B5("weapon_assembly_bench", "targetname");
      var_3.assembly_model_complete show();
      level thread common_scripts\_exploder::_id_088E(223);
      _id_0378::_id_8D74("wonderbuss_weapon_build_infusion", var_0.origin);
      self setHintString(&"ZOMBIE_BERLIN_WEAPON_PICKUP");
      break;
    }

    waitframe();
  }
}

quest_wunderbuss_give_wunderbuss() {
  for(;;) {
    self.assembly_trig waittill("trigger", var_0);
    var_1 = 0;
    var_2 = var_0 getweaponlistprimaries();

    foreach(var_4 in var_2) {
      if(var_4 == "wunderbuss_zm") {
        var_1 = 1;
      }
    }

    if(!var_1) {
      _id_0548::_id_A7D6(var_0, "wunderbuss_zm");
      var_0 _id_0586::_id_078E("wunderbuss_zm");
      maps\mp\mp_zombie_berlin_utils::try_give_exp_to_players_for_weap("wunderbuss_zm");
      maps\mp\mp_zombie_berlin_utils::flag_try_set(maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"));
      var_0 thread maps\mp\mp_zombie_berlin_utils::wunderbuss_ammo_tracker();
      var_0 thread maps\mp\mp_zombie_berlin_utils::wunderbuss_drop_watcher();
    }

    if(isDefined(var_0.wunderbuss_prev_ammo)) {
      waitframe();
      var_0 setweaponammoclip("wunderbuss_zm", var_0.wunderbuss_prev_ammo);
    }
  }
}

quest_wunderbuss_init_bench() {
  var_0 = common_scripts\utility::_id_46B5("weapon_assembly_bench", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3._id_0165) {
      case "trig_workbench":
        var_0.assembly_trig = var_3;
        break;
      case "wunderbuss_weapon_base":
        var_0.assembly_model_base = var_3;
        var_0.assembly_model_base hide();
        break;
      case "wunderbuss_weapon_battery":
        var_0.assembly_model_battery = var_3;
        var_0.assembly_model_battery hide();
        break;
      case "wunderbuss_weapon_bolt":
        var_0.assembly_model_bolt = var_3;
        var_0.assembly_model_bolt hide();
        break;
      case "wunderbuss_weapon_complete":
        var_0.assembly_model_complete = var_3;
        var_0.assembly_model_complete hide();
        break;
    }
  }

  var_5 = _getEnt("wunderbuss_weapon_base", "script_noteworthy");
  var_5 show();
  wait 2;
  level thread common_scripts\_exploder::_id_088E(219);
}

quest_wunderbuss_escape_smuggler_den() {
  level endon("flag_quest_wunderbuss_escape_smugglers_den");
  var_0 = _getEnt("wunderbuss_trig_dmg_smuggler_door", "script_noteworthy");
  var_0 setcontents(var_0 _meth_85A0() | 256);
  var_1 = 0;
  var_2 = 10;

  while(var_1 < var_2) {
    var_0 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_12 == "wunderbuss_zm") {
      var_1++;
    }

    waitframe();
  }

  if(!level.smuggler_den_doors_open) {
    level thread quest_wunderbuss_open_close_doors();
  }

  common_scripts\utility::flag_set("flag_quest_wunderbuss_escape_smugglers_den");
}

quest_wunderbuss_escape_smuggler_den_reset_check() {
  level endon("flag_quest_wunderbuss_escape_smugglers_den");
  var_0 = _getEnt("zone_smuggler_den", "script_noteworthy");
  var_1 = [];

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0)) {
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
        continue;
      }

      var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
    }

    var_1 = common_scripts\utility::_id_0F97(var_1);

    if(var_1.size <= 0 && !level.smuggler_den_doors_open) {
      if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_battery_placed")) {
        quest_wunderbuss_open_close_doors();
      }

      break;
    }

    waitframe();
  }

  common_scripts\utility::flag_set("flag_quest_wunderbuss_escape_smugglers_den");
}

quest_wunderbuss_open_close_doors() {
  var_0 = getEntArray("smuggler_den_door_bot", "targetname");
  var_1 = getEntArray("smuggler_den_door_top", "targetname");
  var_2 = getEntArray("smuggler_den_door_main_body", "script_noteworthy");

  switch (level.smuggler_den_doors_open) {
    case 1:
      level.smuggler_den_doors_open = 0;

      foreach(var_4 in var_0) {
        var_4 movez(-80, 1, 0.25, 0.25);
      }

      foreach(var_4 in var_1) {
        var_4 movez(-40, 1, 0.25, 0.25);
      }

      foreach(var_9 in var_2) {
        var_9 solid();
        var_9 disconnectPaths();
      }

      break;
    case 0:
      level.smuggler_den_doors_open = 1;

      foreach(var_4 in var_0) {
        var_4 movez(80, 1, 0.25, 0.25);
      }

      wait 0.5;

      foreach(var_4 in var_1) {
        var_4 movez(40, 1, 0.25, 0.25);
      }

      foreach(var_9 in var_2) {
        var_9 notsolid();
        var_9 connectpaths();
      }

      break;
    default:
      break;
  }
}

warp_give_wonderweapon_parts() {
  common_scripts\utility::flag_set("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_holding_battery");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_geistbolt_collected");
}

warp_wonderweapon_built() {
  common_scripts\utility::flag_set("flag_quest_wunderbuss_battery_placed");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_geistbolt_placed");
}

debug_cheat_give_wonderweapon() {}

debug_cheat_give_battery() {}

debug_cheat_give_bolt() {}

debug_give_battery() {
  common_scripts\utility::flag_set("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::flag_set("flag_quest_wunderbuss_holding_battery");
}

debug_give_bolt() {
  common_scripts\utility::flag_set("flag_quest_wunderbuss_geistbolt_collected");
}

__________________defeat_straub__________________() {}

quest_init_defeat_straub() {
  common_scripts\utility::flag_init("flag_open_cargobay_complete");
  common_scripts\utility::flag_init("flag_open_cargobay_left_complete");
  common_scripts\utility::flag_init("flag_open_cargobay_left_back_complete");
  common_scripts\utility::flag_init("flag_open_cargobay_right_complete");
  common_scripts\utility::flag_init("flag_open_cargobay_right_back_complete");
  common_scripts\utility::flag_init("flag_override_electroschnell_complete");
}

quest_step_find_way_through_cargo_bay() {
  maps\mp\mp_zombie_berlin_utils::hack_station_init();
  wait 3;
  wait 3;
  common_scripts\utility::_id_3C9F("flag_open_cargobay_complete");
  thread maps\mp\mp_zombie_berlin_utils::vo_player_enter_airship();
  thread quest_step_find_way_through_cargo_bay_complete();
  level thread common_scripts\_exploder::_id_088E(216);
  _id_0557::_id_782D("quest_defeat_straub", "step_find_straub");
}

quest_step_find_way_through_cargo_bay_complete() {
  wait 2;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_overload");
  wait 3;
}

quest_step_overload_straubs_electroschnell() {
  var_0 = _getEnt("straub_airship_idle_anim_org", "targetname");
  level.airship_straub_zombies = [];
  level.airship_straub = spawn("script_model", var_0.origin);
  level.airship_straub setModel("zom_straub_wholebody_dlc");
  level.airship_straub scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_straub_idle", var_0.origin, var_0.angles);
  level.airship_straub._id_00B9 = spawn("script_model", var_0.origin);
  level.airship_straub._id_00B9 setModel("zom_head_kier_dirt_org1_dlc");
  level.airship_straub._id_00B9 linkTo(level.airship_straub, "j_spineupper", (0, 0, 0), (0, 0, 0));

  if(common_scripts\utility::_id_3C77("flag_hat_stack_ee_complete")) {
    level.airship_straub.funny_hat = spawn("script_model", var_0.origin);
    level.airship_straub.funny_hat setModel("zom_m40officercap_org1");
    level.airship_straub.funny_hat linkTo(level.airship_straub, "j_spineupper", (26, 6, 10.5), (-20, 0, 25));
  }

  level.airship_straub._id_00B9 scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_straub_idle", var_0.origin, var_0.angles);

  for(var_1 = 0; var_1 < 8; var_1++) {
    level.airship_straub_zombies[var_1] = spawn("script_model", var_0.origin);
    level.airship_straub_zombies[var_1] setModel("zom_infantrya_bodywhole");
    level.airship_straub_zombies[var_1].animation_name = "s2_zom_straub_death_zom_0" + common_scripts\utility::_id_9AAD(var_1 + 1);
    level.airship_straub_zombies[var_1].idle_anim_name = "s2_zom_straub_death_end_zom_0" + common_scripts\utility::_id_9AAD(var_1 + 1);
    level.airship_straub_zombies[var_1]._id_00B9 = spawn("script_model", var_0.origin);
    level.airship_straub_zombies[var_1]._id_00B9 setModel(common_scripts\utility::random(["zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1"]));
    level.airship_straub_zombies[var_1]._id_00B9 linkTo(level.airship_straub_zombies[var_1], "j_spineupper", (0, 0, 0), (0, 0, 0));
    level.airship_straub_zombies[var_1] scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_1].animation_name, var_0.origin, var_0.angles);
    level.airship_straub_zombies[var_1]._id_00B9 scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_1].animation_name, var_0.origin, var_0.angles);
    level.airship_straub_zombies[var_1] common_scripts\utility::_id_2CBE(0.05, ::setshadowrendering, 1);
    level.airship_straub_zombies[var_1]._id_00B9 common_scripts\utility::_id_2CBE(0.05, ::setshadowrendering, 1);
  }

  common_scripts\utility::_id_3C9F("flag_override_electroschnell_complete");
  thread quest_step_overload_straubs_electroschnell_complete();
}

quest_step_overload_straubs_electroschnell_complete() {
  common_scripts\utility::flag_set("flag_straub_death_scene");
  wait 5;
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(var_2._id_000A == level._id_746E) {
      continue;
    }
    var_2 suicide();
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_straub_death();
  var_4 = _getEnt("straub_airship_idle_anim_org", "targetname");
  level.airship_straub scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_straub", var_4.origin, var_4.angles);
  level.airship_straub._id_00B9 scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_straub", var_4.origin, var_4.angles);
  level thread quest_step_overload_straubs_electroschnell_straub_grit_blood();
  level thread quest_step_overload_straubs_electroschnell_lights();
  level thread quest_step_overload_straubs_electroschnell_complete_fx();

  for(var_5 = 0; var_5 < level.airship_straub_zombies.size; var_5++) {
    level.airship_straub_zombies[var_5] scriptmodelclearanim();
    level.airship_straub_zombies[var_5] scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_5].animation_name, var_4.origin, var_4.angles);
    level.airship_straub_zombies[var_5]._id_00B9 scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_5].animation_name, var_4.origin, var_4.angles);
  }

  _id_054D::giveplayersexp("berlin_exp_ref_18");
  wait(_getanimlength(%s2_zom_straub_death_straub));

  if(isDefined(level.airship_straub)) {
    level.airship_straub scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_end_straub", var_4.origin, var_4.angles);
    level.airship_straub._id_00B9 scriptmodelplayanimdeltamotionfrompos("s2_zom_straub_death_end_straub", var_4.origin, var_4.angles);

    for(var_5 = 0; var_5 < level.airship_straub_zombies.size; var_5++) {
      level.airship_straub_zombies[var_5] scriptmodelclearanim();
      level.airship_straub_zombies[var_5] scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_5].idle_anim_name, var_4.origin, var_4.angles);
      level.airship_straub_zombies[var_5]._id_00B9 scriptmodelplayanimdeltamotionfrompos(level.airship_straub_zombies[var_5].idle_anim_name, var_4.origin, var_4.angles);
    }
  }

  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  wait 3;
  level notify("airship_escape");
  thread maps\mp\mp_zombie_berlin_utils::airship_camera_sway_extreme();
  thread quest_step_straub_death_powernodes_turn_on_fx();
  _id_0557::_id_782D("quest_defeat_straub", "step_override_electroschnell");
  common_scripts\utility::_id_3C7B("flag_straub_death_scene");
}

quest_step_overload_straubs_electroschnell_complete_fx() {
  wait 16;
  level thread common_scripts\_exploder::_id_088E(215);
  wait 1.75;
  level thread common_scripts\_exploder::_id_088E(213);
}

quest_step_straub_death_powernodes_turn_on_fx() {
  wait 1;
  level thread common_scripts\_exploder::_id_088E(214);
}

quest_step_overload_straubs_electroschnell_lights() {
  wait 3;
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_start_lights();
  wait 2;
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_kill_lights();
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_kill_fill_lights();
  thread maps\mp\mp_zombie_berlin_lighting::airship_alarm_lights();
}

quest_step_overload_straubs_electroschnell_straub_grit_blood() {
  wait(_getanimlength(%s2_zom_straub_death_straub) * 0.65);
  _playFXOnTag(level._effect["zmb_dlc2_straub_death_grit"], level.airship_straub, "j_spineupper");
  wait 5.5;
  var_0 = getEntArray("ariship_straub_blast_door", "targetname");

  foreach(var_2 in var_0) {
    wait(_randomfloatrange(0.05, 0.15));
    var_2 moveTo(var_2.origin + (0, 0, 56), 0.5, 0, 0.1);
  }

  wait 0.5;
  thread quest_step_overload_straubs_electroschnell_cleanup();
}

quest_step_overload_straubs_electroschnell_cleanup() {
  level.airship_straub._id_00B9 delete();
  level.airship_straub delete();

  foreach(var_1 in level.airship_straub_zombies) {
    var_1._id_00B9 delete();
    var_1 delete();
  }
}

escape_airship_init() {
  var_0 = _getEnt("clip_airship_drop_pod_closed", "script_noteworthy");
  var_0 notsolid();
  waitframe();
  var_0 connectpaths();
}

escape_airship_logic() {
  level notify("escape_airship_start");

  if(!isDefined(level.alternate_boss_fight)) {
    thread escape_airship_rumble();
  }

  var_0 = _getEnt("airship_lab_door_left", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, -80), 0.3);
  thread escape_airship_open_all_doors();
  thread escape_airship_drop_pod_wait_for_all_players();
}

escape_airship_rumble() {}

escape_airship_open_all_doors() {
  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable") {
      var_1 notify("open");
    }
  }
}

escape_airship_drop_pod_wait_for_all_players() {
  level endon("airship_escape_drop_pod_doors_complete");

  foreach(var_1 in level.players) {
    var_1 thread escape_airship_player_in_drop_pod_check();
  }

  for(;;) {
    var_3 = 0;

    foreach(var_1 in level.players) {
      if(var_1.inside_airship_drop_pod) {
        var_3 = var_3 + 1;
      }
    }

    if(isDefined(var_3) && var_3 >= level.players.size) {
      break;
    }

    waitframe();
  }

  var_6 = getEntArray("airship_drop_pod_body", "targetname");

  foreach(var_8 in var_6) {
    var_8._id_A045 = ::airship_drop_pod_unresolved_collision_func;
  }

  var_10 = _getEnt("model_airship_drop_pod", "script_noteworthy");
  var_11 = _getanimlength(%s2_zmb_drop_pod_close_front_quick);
  var_10 scriptmodelplayanim("s2_zmb_drop_pod_close_front_quick", "airship_drop_pod_close_doors");
  _id_0378::_id_8D74("inside_droppod_submix_strt");
  var_12 = _getEnt("clip_airship_drop_pod_closed", "script_noteworthy");
  var_12 solid();
  wait(var_11);
  escape_airship_drop_pod_move();
}

escape_airship_player_in_drop_pod_check() {
  level endon("airship_drop_pod_close_doors");
  var_0 = _getEnt("vol_airship_drop_pod_area", "script_noteworthy");

  for(;;) {
    if(self istouching(var_0)) {
      self.inside_airship_drop_pod = 1;
    } else {
      self.inside_airship_drop_pod = 0;
    }

    waitframe();
  }
}

escape_airship_drop_pod_move() {
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.3, 8, 1000);
  var_0 = _getEnt("airship_interior_launch_door", "script_noteworthy");
  var_0 hide();
  var_1 = _getEnt("model_airship_drop_pod", "script_noteworthy");
  var_1 _id_0378::_id_8D74("droppod_escape_fire");
  var_2 = getEntArray("airship_drop_pod_body", "targetname");
  var_3 = _getEnt("org_tp_airship", "script_noteworthy");

  foreach(var_5 in var_2) {
    var_5 linktosynchronizedparent(var_1);
  }

  var_3 linktosynchronizedparent(var_1);
  wait 0.25;
  var_1 movez(-360, 3);
  wait 3;
  escape_airship_teleport_to_surface();
}

escape_airship_teleport_to_surface() {
  var_0 = _getEnt("org_tp_plaza", "script_noteworthy");
  var_1 = _getEnt("org_tp_airship", "script_noteworthy");
  waitframe();
  thread escape_plaza_drop_pod_move();
  thread escape_plaza_drop_pod_move_light_off();
  waitframe();
  var_2 = getEntArray("pod_player_teleport_spot", "script_noteworthy");
  var_3 = 0;

  foreach(var_5 in level.players) {
    var_5 setOrigin(var_2[var_3].origin);
    var_3++;
  }

  level notify("airship_escape_drop_pod_doors_complete");
  _id_0557::_id_782D("quest_bob", "step_escape_airship");
}

airship_drop_pod_unresolved_collision_func(var_0) {
  var_1 = _getEnt("org_tp_airship", "script_noteworthy");
  var_0 setOrigin(var_1.origin);
}

airship_drop_pod_teleport_unresolved_collision_func(var_0) {}

escape_plaza_drop_pod_move() {
  level notify("airship_drop_pod_moving_down");
  level waittill("airship_drop_pod_reached_ground");
  var_0 = _getEnt("clip_drop_pod_closed", "script_noteworthy");
  var_0 notsolid();
  var_1 = common_scripts\utility::_id_46B5("fx_org_escape_airship_drop_pod_crash", "script_noteworthy");
  playFX(level._effect["landing_dust"], var_1.origin);
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.6, 1, 1000);
  _id_0547::markmapcompleteforleaderboards();
  level._id_400E[level._id_400E.size] = ["wicht_set 2 1", "all"];
  var_2 = _id_0547::_id_408F();

  foreach(var_4 in var_2) {
    var_4 suicide();
  }

  level.zmb_locked_spawn_zones = undefined;
  _id_0547::playerspawneroverrideclear();
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  level common_scripts\utility::waittill_notify_or_timeout("airship_drop_pod_reached_ground", 15);
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  run_outro_berlin();
}

escape_plaza_drop_pod_move_light_off() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_1 = _getEnt("model_airship_drop_pod", "script_noteworthy");
  var_0.lightfx show();
  var_1.airpodlightfx delete();
}

warp_show_airship_exterior() {
  common_scripts\utility::flag_set("flag_exit_underbelly");
  common_scripts\utility::flag_set("flag_airship_summoned");
  common_scripts\utility::flag_set("flag_airship_reached_middle");
  common_scripts\utility::flag_set("flag_airship_fully_lowered");
}

warp_show_airship_interior() {
  common_scripts\utility::flag_set("flag_exit_underbelly");
  common_scripts\utility::flag_set("flag_airship_summoned");
  common_scripts\utility::flag_set("flag_airship_reached_middle");
  common_scripts\utility::flag_set("flag_airship_fully_lowered");
  common_scripts\utility::flag_set("flag_airship_doors_opened");
  common_scripts\utility::flag_set("flag_drop_pod_reached_airship");
  _id_0547::playerspawneroverrideset("airship");
}

warp_activateenemytypes() {
  common_scripts\utility::flag_set("flag_sizzlers_active");
}

warp_setup_drop_pod_position() {
  var_0 = _getEnt("drop_pod_model", "script_noteworthy");
  var_0 show();
  var_0.lightfx show();
  var_1 = _getEnt("clip_drop_pod_closed", "script_noteworthy");
  var_2 = _getEnt("clip_drop_pod", "script_noteworthy");
  var_1 solid();
  var_2 solid();
  quest_drop_pod_entered_airship();
}

warp_setup_straub_death_scene() {
  wait 1;
  var_0 = _getEnt("airship_node_03_03", "targetname");
  var_0 notify("hack_interact");
  var_0 = _getEnt("airship_node_01_02", "targetname");
  var_0 notify("hack_interact");
  var_0 = _getEnt("airship_node_02_01", "targetname");
  var_0 notify("hack_interact");
  var_0 = _getEnt("airship_node_05_02", "targetname");
  var_0 notify("hack_interact");
  var_0 = _getEnt("airship_node_04_01", "targetname");
  var_0 notify("hack_interact");
  wait 5;
  var_1 = _getEnt("airship_node_03_05", "targetname");
  var_1 notify("hack_interact");
}

__________________beast_of_berlin__________________() {}

quest_step_defeat_bob() {
  common_scripts\utility::flag_set("flag_sizzlers_active");
  thread boss_spawn();
}

boss_spawn() {
  var_0 = common_scripts\utility::_id_46B5("spawner_zombie_bob_airship", "targetname");
  var_1 = _getEnt("trigger_leaving_airship_boss", "script_noteworthy");
  var_2 = 0;

  while(var_2 == 0) {
    var_1 waittill("trigger", var_3);

    if(isPlayer(var_3)) {
      var_2 = 1;
    }

    waitframe();
  }

  var_4 = _id_054D::_id_90BA("zombie_bob", var_0, "bob", 0, 1, 0);

  if(common_scripts\utility::_id_3C77("flag_hat_stack_ee_complete")) {
    var_4.funny_hat = spawn("script_model", var_4.origin);
    var_4.funny_hat setModel("zom_m40officercap_org1");
    var_4.funny_hat linkTo(var_4, "J_Helmet", (4, 0, 0), (0, 0, 0));
  }

  level.bob = var_4;
  thread wait_time_earthquake(1.87549, var_4);
  var_4 _id_0547::disableoffhandsecondaryweapons();
  bob_stun_zombies_nearby(var_4);
  level thread max_out_zombies_after_animation();
  level._id_1F4F["normal"] = ::dontdroppickups;
  maps\mp\_events_z::start_boss_battle_tracking();
  thread maps\mp\mp_zombie_berlin_utils::vo_say_hello_to_my_little_bob();

  for(;;) {
    if(isalive(var_4) == 0) {
      wait 1;
      break;
    }

    wait 0.1;
  }

  wait 1;
  thread escape_airship_rumble();
  maps\mp\_events_z::end_boss_battle_tracking();
  _iprintlnbold("Get to the drop pod to escape!");
  _id_0557::_id_782D("quest_bob", "step_defeat_bob");
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level.maxed_zombies_sprint = 0;
  level._id_1F4F["normal"] = ::droppickups;
}

dontdroppickups(var_0) {
  return 0;
}

droppickups(var_0) {
  return 1;
}

#using_animtree("zombie_bob");

max_out_zombies_after_animation() {
  wait(_getanimlength(%s2_zom_bob_intro));
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  level.maxed_zombies_sprint = 1;
}

bob_stun_zombies_nearby(var_0) {
  wait 0.75;
  var_1 = var_0.origin;
  var_2 = 200;
  var_3 = 1;
  var_4 = _id_0547::_id_408F();
  var_5 = _sortbydistance(_id_0547::_id_408F(), var_1, var_2);
  var_6 = 1;

  foreach(var_8 in var_5) {
    var_9 = spawnStruct();
    var_9.origin = var_1;
    var_9._id_1180 = var_0;
    var_9.durationsecs = 1;
    level thread bob_stun_zombie(var_8, var_9, var_3, var_6);
    var_6 = var_6 + 0.05;
  }
}

bob_stun_zombie(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  wait(var_3);
  var_4 = 0.125 * maps\mp\gametypes\zombies::_id_1E59();
  var_5 = var_1.origin;
  var_6 = var_1._id_1180;
  var_0 dodamage(var_4, var_5, var_6);

  if(common_scripts\utility::_id_562E(var_0._id_57E8)) {
    return;
  }
  var_0 thread _id_0547::_id_7D1A("mini_stunning_burst", [var_1], var_2);
}

wait_time_earthquake(var_0, var_1) {
  wait(var_0);
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players_with_origin(0.5, 0.5, 2000, var_1);
  wait 0.5;
  level thread common_scripts\_exploder::_id_088E(217);
}

__________________pack_a_punch__________________() {}

quest_pap_init() {
  common_scripts\utility::flag_init("pap_ww_blasted_1");
  common_scripts\utility::flag_init("pap_ww_blasted_2");
  var_0 = _getEnt("pap_machine_fake", "script_noteworthy");
  level thread quest_pap_handler(var_0);
}

wait_for_upgrade_machine_arrived(var_0, var_1) {
  var_1 _meth_8006(var_0);
  common_scripts\utility::_id_3C9F("pap_ww_blasted_1");
}

quest_pap_handler(var_0) {
  var_1 = _getEnt("trigger_dmg_elevator_shaft", "script_noteworthy");
  var_2 = _getEnt("trigger_dmg_elevator_bottom_doors", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("struct_fx_panel_1", "script_noteworthy");
  var_4 = common_scripts\utility::_id_46B5("struct_fx_panel_2", "script_noteworthy");
  var_5 = _getEnt("pap_electric_box_door_1", "script_noteworthy");
  var_6 = _getEnt("pap_electric_box_door_2", "script_noteworthy");
  var_1 thread trigger_electric_box_hit(var_3, var_5);
  var_2 thread trigger_electric_box_hit(var_4, var_6);
  var_7 = _getEnt("script_pap_elevator_mover", "script_noteworthy");
  var_8 = _getEnt("script_pap_elevator_geo", "script_noteworthy");
  level waittill("pap_electric_box_complete");
  playFX(level._effect["elevator_crash"], var_0.origin);
  wait 0.5;
  var_8 linktosynchronizedparent(var_7);
  var_0 linktosynchronizedparent(var_7);
  var_7 movez(-100, 0.5, 0.25, 0.1);
  var_7 _id_0378::_id_8D74("aud_pap_move_elevator");
  wait 0.7;
  var_0 delete();
  common_scripts\utility::flag_set("pap_ww_blasted_1");
  level waittill("pap_electric_box_complete");
  common_scripts\utility::flag_set("pap_ww_blasted_2");
  var_9 = common_scripts\utility::_id_46B5("zmb_pack_a_punch_scripted_node", "targetname");
  var_10 = _getEnt("pap_elevator_doors", "script_noteworthy");
  var_11 = _getEnt("pap_elevator_clip", "script_noteworthy");
  _id_054D::giveplayersexp("berlin_exp_ref_3");
  open_elevator_doors(var_9, var_10, var_11);
  maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_2();
}

open_elevator_doors(var_0, var_1, var_2) {
  var_1 scriptmodelplayanimdeltamotionfrompos("zmb_elevator_door_open_02", var_0.origin, var_0.angles, "script_anim");
  var_1 _id_0378::_id_8D74("aud_pap_open_elevator");
  var_2 connectpaths();
  waitframe();
  var_2 delete();
}

trigger_electric_box_hit(var_0, var_1) {
  self setcontents(self _meth_85A0() | 256);
  var_2 = 10;
  var_3 = 0;
  var_4 = 0;

  while(var_4 == 0) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_9) && (var_9 == "MOD_EXPLOSIVE" || var_9 == "MOD_GRENADE_SPLASH" || var_9 == "MOD_GRENADE")) {
      var_4 = 1;
    }

    if(isDefined(var_14) && var_14 == "fliegerfaust_zm") {
      var_4 = 1;
    }

    waitframe();
  }

  var_1 rotateYaw(-143, 0.6, 0.3, 0.1);

  while(var_2 > var_3) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(var_14 == "wunderbuss_zm") {
      self notify("pap_electric_box_hit");
      var_3++;
      playFX(level._effect["zmb_elec_coil_charge_pap_puzzle"], var_0.origin);
    }

    waitframe();
  }

  playFX(level._effect["zmb_fog_wispy_cliff_electric_box"], var_0.origin);
  level notify("pap_electric_box_complete");
  self delete();
}

__________________misc_jump_scares__________________() {}

js_sewer_board() {
  var_0 = 0;
  var_1 = _getEnt("jumpscare_sewer_board_geo", "script_noteworthy");
  var_2 = _getEnt("jumpscare_sewer_board_geo_after", "script_noteworthy");
  var_3 = _getEnt("jumpscare_sewer_board_trigger", "script_noteworthy");
  var_4 = _getEnt("jumpscare_sewer_board_clip", "script_noteworthy");
  var_2 hide();

  while(var_0 == 0) {
    var_3 waittill("trigger", var_5);

    if(isPlayer(var_5)) {
      wait 0.75;

      if(!var_5 istouching(var_3)) {
        continue;
      } else {
        var_0 = 1;
        var_4 delete();
        var_1 delete();
        var_2 show();
        var_5 _id_0378::_id_8D74("player_falls_into_sewer");
        wait 0.5;
        var_5 setstance("prone");
      }
    }

    waitframe();
  }
}

js_dancer() {
  var_0 = _getEnt("dancer_js", "targetname");
  var_1 = _getEnt("dancer_js_trig", "targetname");
  var_2 = common_scripts\utility::_id_46B5("dancer_js_struct", "targetname");
  var_3 = _getEnt("bonus_ee_audiolog_dancer_pickup_model", "targetname");

  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  var_0 scriptmodelplayanimdeltamotionfrompos("s2_zom_berlin_bed_scare_idle", var_0.origin, var_0.angles, "dancer_js_idle");
  wait 1;
  var_4 = var_0 gettagorigin("TAG_WEAPON_RIGHT");
  var_5 = var_0 gettagangles("TAG_WEAPON_RIGHT");
  var_3 moveTo(var_4, 0.1);
  var_3.angles = var_5;
  wait 0.5;
  var_3 linktosynchronizedparent(var_0, "TAG_WEAPON_RIGHT");
  thread maps\mp\_utility::_id_6F74(::bonus_ee_audiolog_dancer_alternate_prop_swap);
  var_6 = 0;
  common_scripts\utility::_id_3C9F("flag_audiolog_dancer_jumpscare_available");

  while(!var_6) {
    foreach(var_8 in level.players) {
      var_9 = var_8 istouching(var_1);
      var_10 = common_scripts\utility::within_fov(var_8 getEye(), var_8 _meth_8566(), var_2.origin, _cos(25));

      if(var_9 && var_10) {
        var_6 = 1;
      }
    }

    wait 0.1;
  }

  wait 1;
  common_scripts\utility::flag_set("flag_audiolog_dancer_jumpscare_triggered");
  var_0 scriptmodelclearanim();
  var_0 scriptmodelplayanim("s2_zom_berlin_bed_scare_jump", "dancer_js_jump");
  var_0 _id_0378::_id_8D74("aud_dancer_jumpscare");
}

warp_dancer_jump_scare() {
  common_scripts\utility::flag_set("flag_audiolog_dancer_jumpscare_available");
}

__________________audio_log_3_dancer___________________________________________________() {}

bonus_ee_audiolog_dancer_init() {
  common_scripts\utility::flag_init("flag_audiolog_dancer_shot_painting");
  common_scripts\utility::flag_init("flag_audiolog_dancer_grabbed_record");
  common_scripts\utility::flag_init("flag_audiolog_dancer_placed_record");
  common_scripts\utility::flag_init("flag_audiolog_dancer_jumpscare_available");
  common_scripts\utility::flag_init("flag_audiolog_dancer_jumpscare_triggered");
  var_0 = _getEnt("bonus_ee_audiolog_dancer_painting", "script_noteworthy");
  var_1 = _getEnt("bonus_ee_audiolog_dancer_painting_trig", "script_noteworthy");
  var_2 = _getEnt("bonus_ee_audiolog_dancer_record", "script_noteworthy");
  var_3 = _getEnt("bonus_ee_audiolog_dancer_record_trig_use", "script_noteworthy");
  var_4 = _getEnt("bonus_ee_audiolog_dancer_phono_trig_use", "script_noteworthy");
  var_5 = _getEnt("bonus_ee_audiolog_dancer_phono_trig_dmg", "script_noteworthy");
  var_6 = _getEnt("trigger_dancer_jump_scare_audiolog_collect", "script_noteworthy");
  var_7 = [];
  var_8 = _getscriptablearray("zmb_phonograph_model", "targetname");
  var_7["record_player"] = var_8[0];
  var_9 = _getscriptablearray("hc_phonograph_tech_piece", "targetname");
  var_7["record_player_tech"] = var_9[0];
  var_7["record_player"] thread set_phonograph_state("off");

  if(isDefined(var_6)) {
    var_6 common_scripts\utility::_id_9D9F();
  }

  var_7 thread bonus_ee_audiolog_dancer_step_01(var_0, var_1, var_2, var_3);
  var_7 thread bonus_ee_audiolog_dancer_step_02(var_4);
  var_7 thread bonus_ee_audiolog_dancer_step_03(var_5, var_6);
}

bonus_ee_audiolog_dancer_step_01(var_0, var_1, var_2, var_3) {
  var_4 = 2;
  var_5 = 0;
  self["record_player"] setscriptablepartstate("record", "off");
  self["record_player_tech"] setscriptablepartstate("tech_light", "off");

  while(var_4 > var_5) {
    var_1 waittill("damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
    var_5++;
    var_0 movez(-1, 0.2, 0.1, 0.05);
    waitframe();
  }

  var_0 rotateroll(165, 0.75, 0.5, 0.2);
  wait 0.4;
  var_0 movex(18, 0.25, 0.1, 0.1);
  wait 0.2;
  var_0 movez(-60, 0.5, 0.25, 0);
  var_3 waittill("trigger");
  common_scripts\utility::flag_set("flag_audiolog_dancer_grabbed_record");
  var_2 delete();
}

bonus_ee_audiolog_dancer_step_02(var_0) {
  common_scripts\utility::_id_3C9F("flag_audiolog_dancer_grabbed_record");
  self["record_player_tech"] setscriptablepartstate("tech_light", "red_on");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("flag_audiolog_dancer_placed_record");
}

bonus_ee_audiolog_dancer_step_03(var_0, var_1) {
  var_2 = 5;
  var_3 = 0;
  var_0 setcontents(var_0 _meth_85A0() | 256);
  common_scripts\utility::_id_3C9F("flag_audiolog_dancer_placed_record");
  self["record_player"] setscriptablepartstate("record", "on");
  self["record_player_tech"] setscriptablepartstate("tech_light", "green_on");

  while(var_2 > var_3) {
    var_0 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(var_13 == "wunderbuss_zm") {
      var_3++;
    }

    waitframe();
  }

  self["record_player"] thread set_phonograph_state("on");
  self["record_player"] setscriptablepartstate("record", "on");
  var_0 thread _id_9276();
  common_scripts\utility::flag_set("flag_audiolog_dancer_jumpscare_available");

  if(isDefined(var_1)) {
    var_1 common_scripts\utility::_id_9DA3();
  }
}

#using_animtree("destructibles");

set_phonograph_state(var_0) {
  switch (var_0) {
    case "off":
      self setscriptablepartstate("machine_main", "turn_off");
      wait(_getanimlength(%zmb_phonograph_turn_off));
      self setscriptablepartstate("machine_main", "off");
      break;
    case "on":
      self setscriptablepartstate("machine_main", "turn_on");
      wait(_getanimlength(%zmb_phonograph_turn_on));
      self setscriptablepartstate("machine_main", "on");
      break;
    default:
      break;
  }
}

_id_9276() {
  var_0 = _id_0380::_id_6844("zmb_mus_darkwings_straight", undefined, self, 0.5, 1);
  common_scripts\utility::_id_3C9F("flag_audiolog_dancer_jumpscare_triggered");
  _id_0380::_id_6850(var_0, 1);
}

bonus_ee_audiolog_dancer_alternate_prop_swap(var_0) {
  var_1 = _id_0550::_id_24D4(19);
  var_2 = _id_0550::_id_415C(self, var_1);
  var_0 = _getEnt("dancer_js", "targetname");
  wait 1;
  var_3 = var_0 gettagorigin("TAG_WEAPON_RIGHT");
  var_4 = var_0 gettagangles("TAG_WEAPON_RIGHT");
  var_5 = spawn("script_model", var_3);
  var_5 setModel("dun_belongings_book_03");
  var_5.angles = (5.07907, 282.089, -44.3602);
  _id_054F::_id_86B3(var_5, self, var_2);
  wait 0.5;
  var_5 linktosynchronizedparent(var_0, "TAG_WEAPON_RIGHT");
}

__________________the_classic_ppsh__________________() {}

the_classic_init() {
  common_scripts\utility::flag_init("flag_the_classic_mirror_one_complete");
  common_scripts\utility::flag_init("flag_the_classic_mirror_two_complete");
  common_scripts\utility::flag_init("flag_the_classic_mirror_three_complete");
  var_0 = getEntArray("classic_light_model", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  the_classic_logic();
}

the_classic_logic() {
  var_0 = _getEnt("classic_trig_use_touch_mirror_one", "script_noteworthy");
  var_0 thread the_classic_listen_for_jolts("flag_the_classic_mirror_one_complete", 0.25);
  common_scripts\utility::_id_3C9F("flag_the_classic_mirror_one_complete");
  var_1 = _getEnt("classic_trig_use_touch_mirror_two", "script_noteworthy");
  var_1 thread the_classic_listen_for_jolts("flag_the_classic_mirror_two_complete", 0.15);
  common_scripts\utility::_id_3C9F("flag_the_classic_mirror_two_complete");
  var_2 = _getEnt("classic_trig_use_touch_mirror_three", "script_noteworthy");
  var_2 thread the_classic_listen_for_jolts("flag_the_classic_mirror_three_complete", 0.08);
  common_scripts\utility::_id_3C9F("flag_the_classic_mirror_three_complete");
  the_classic_completed_reward();
}

the_classic_listen_for_jolts(var_0, var_1) {
  while(!common_scripts\utility::_id_3C77(var_0)) {
    level waittill("spawned_money_share");

    foreach(var_3 in level._id_8AD2) {
      if(!self _meth_858B(var_3.origin)) {
        continue;
      }
      var_4 = var_3._id_0117;
      var_5 = var_4 getentitynumber();
      var_3 _id_0544::_id_8ADD(var_5, 0);
      var_3._id_6FD4 = 0;
      var_3._id_6FCB = 0;
      thread the_classic_jolt_drop_fx(self.origin);
      the_classic_game_logic(var_0, var_1);
    }
  }
}

the_classic_listen_for_player_input() {
  self waittill("trigger");
  self notify("classic_stop_light");
}

the_classic_game_logic(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == "flag_the_classic_mirror_one_complete") {
    the_classic_intro_light_show(1);
    var_2 = the_classic_intro_select_starting_light(1);
  } else if(var_0 == "flag_the_classic_mirror_two_complete") {
    the_classic_intro_light_show(2);
    var_2 = the_classic_intro_select_starting_light(2);
  } else if(var_0 == "flag_the_classic_mirror_three_complete") {
    the_classic_intro_light_show(3);
    var_2 = the_classic_intro_select_starting_light(3);
  }

  level.active_struct = var_2;
  var_3 = getEntArray("classic_light_model", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6._id_0165 == "classic_mirror_one" && var_0 == "flag_the_classic_mirror_one_complete") {
      var_4 = var_6;
      break;
    } else if(var_6._id_0165 == "classic_mirror_two" && var_0 == "flag_the_classic_mirror_two_complete") {
      var_4 = var_6;
      break;
    } else if(var_6._id_0165 == "classic_mirror_three" && var_0 == "flag_the_classic_mirror_three_complete") {
      var_4 = var_6;
      break;
    }
  }

  var_8 = var_4;
  thread the_classic_listen_for_player_input();
  the_classic_move_light(var_8, var_1);

  if(level.active_struct.targetname == var_2.targetname) {
    foreach(var_6 in var_3) {
      var_6 hide();
    }

    switch (var_0) {
      case "flag_the_classic_mirror_one_complete":
        the_classic_intro_light_show(1, 0);
        break;
      case "flag_the_classic_mirror_two_complete":
        the_classic_intro_light_show(2, 0);
        break;
      case "flag_the_classic_mirror_three_complete":
        the_classic_intro_light_show(3, 0);
        break;
    }

    common_scripts\utility::flag_set(var_0);
  } else {}

  foreach(var_6 in var_3) {
    var_6 hide();
  }
}

the_classic_intro_select_starting_light(var_0) {
  var_1 = [];

  switch (var_0) {
    case 1:
      var_1 = common_scripts\utility::_id_46B7("classic_mirror_one", "script_noteworthy");
      break;
    case 2:
      var_1 = common_scripts\utility::_id_46B7("classic_mirror_two", "script_noteworthy");
      break;
    case 3:
      var_1 = common_scripts\utility::_id_46B7("classic_mirror_three", "script_noteworthy");
      break;
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3.setlookatent)) {
      if(var_3.setlookatent == "classic_struct_starting_light") {
        var_4 = var_3;
        var_5 = spawn("script_model", var_4.origin);
        var_5.angles = var_4.angles;
        var_5 setModel("s2_light_bulb_03_on");
        var_6 = 1;

        for(var_7 = 0; var_7 < 5; var_7++) {
          if(var_6) {
            var_5 hide();
          } else {
            var_5 show();
          }

          var_6 = !var_6;
          wait 0.5;
        }

        return var_4;
      }
    }
  }
}

the_classic_intro_light_show(var_0, var_1) {
  var_2 = [];
  var_3 = 0.75;
  var_4 = 2;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  switch (var_0) {
    case 1:
      var_2 = common_scripts\utility::_id_46B7("classic_mirror_one", "script_noteworthy");
      var_3 = 0.6;
      var_4 = 3;
      break;
    case 2:
      var_2 = common_scripts\utility::_id_46B7("classic_mirror_two", "script_noteworthy");
      var_3 = 0.4;
      var_4 = 5;
      break;
    case 3:
      var_2 = common_scripts\utility::_id_46B7("classic_mirror_three", "script_noteworthy");
      var_3 = 0.2;
      var_4 = 9;
      break;
  }

  if(!var_1) {
    var_3 = 0.1;
    var_4 = 15;
  }

  var_5 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    if(var_6 == 0) {
      var_7 = common_scripts\utility::_id_46B5(var_2[var_6].target, "targetname");
    } else {
      var_7 = common_scripts\utility::_id_46B5(var_5[var_6 - 1].target, "targetname");
    }

    var_5 = common_scripts\utility::_id_0F6F(var_5, var_7);
  }

  var_8 = 0;

  for(var_9 = []; var_8 < var_4; var_8++) {
    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_6 % 2) {
        var_10 = spawn("script_model", var_5[var_6].origin);
        var_10.angles = var_5[var_6].angles;
        var_10 setModel("s2_light_bulb_03_on");
        var_9 = common_scripts\utility::_id_0F6F(var_9, var_10);
      }
    }

    wait(var_3);

    foreach(var_12 in var_9) {
      var_9 = common_scripts\utility::_id_0F93(var_9, var_12);
      var_12 delete();
    }

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(!(var_6 % 2)) {
        var_10 = spawn("script_model", var_5[var_6].origin);
        var_10.angles = var_5[var_6].angles;
        var_10 setModel("s2_light_bulb_03_on");
        var_9 = common_scripts\utility::_id_0F6F(var_9, var_10);
      }
    }

    wait(var_3);

    foreach(var_12 in var_9) {
      var_9 = common_scripts\utility::_id_0F93(var_9, var_12);
      var_12 delete();
    }
  }
}

the_classic_move_light(var_0, var_1) {
  self endon("classic_stop_light");
  var_0 show();

  for(;;) {
    var_2 = common_scripts\utility::_id_46B5(level.active_struct.target, "targetname");
    var_0.origin = var_2.origin;
    level.active_struct = var_2;
    wait(var_1);
  }
}

the_classic_completed_reward() {
  _iprintlnbold("CLASSIC ADDED TO BOX!");
  _id_0548::_id_09C8("ppsh41_classic_zm", "extended_mag", "none", "none");
  var_0 = getEntArray("classic_trig_use_touch", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread the_classic_jolt_drop_fx(var_2.origin);
  }
}

the_classic_jolt_drop_fx(var_0) {
  var_1 = _spawnfx(common_scripts\utility::_id_44F5("moneyCloud"), var_0);
  _triggerfx(var_1);
  wait 3;
  var_1 delete();
}

__________________bell_race__________________() {}

bell_race_init() {
  common_scripts\utility::flag_init("bell_race_complete");
  var_0 = getEntArray("lore_primary", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.setlookatent == "lore19") {
      level.bell_race_log_trig = _getEnt(var_2.target, "targetname");
      level.bell_race_log_trig common_scripts\utility::_id_9D9F();
      var_2 hide();
      level.bell_race_log = var_2;
      break;
    }
  }

  bell_race_logic();
}

bell_race_logic() {
  while(!common_scripts\utility::_id_3C77("bell_race_complete")) {
    var_0 = _getEnt("bell_race_starting_bell", "script_noteworthy");
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = _getEnt(var_0.target, "targetname");
    var_11 setModel("aac_lamp_03_on");
    var_0 _id_0378::_id_8D74("aud_ring_bell");
    level.bell_race_user = var_2;
    bell_race_start();
  }
}

bell_race_start() {
  level endon("bell_race_time_up");
  _iprintlnbold("Race start!");
  level.bells_dinged = 0;
  var_0 = getEntArray("bell_race_trig_dmg", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 thread bell_race_bell_wait_for_damage();
  }

  thread bell_race_timer();

  for(;;) {
    if(level.bells_dinged >= var_0.size) {
      var_4 = _getEnt("bell_race_ending_bell", "script_noteworthy");
      var_4 bell_race_bell_wait_for_damage();
      bell_race_complete();
      break;
    }

    waitframe();
  }
}

bell_race_bell_wait_for_damage() {
  level endon("bell_race_time_up");
  var_0 = _getEnt(self.target, "targetname");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_2 == level.bell_race_user) {
      var_0 setModel("aac_lamp_03_on");
      level.bells_dinged = level.bells_dinged + 1;
      _id_0378::_id_8D74("aud_ring_bell");
      _iprintlnbold("Ding!");
      break;
    }

    waitframe();
  }
}

bell_race_timer() {
  level endon("bell_race_bells_complete");
  var_0 = 0;
  var_1 = 20;

  while(var_0 < var_1) {
    var_0 = var_0 + 1;
    wait 1;
  }

  thread bell_race_fail();
  level notify("bell_race_time_up");
}

bell_race_fail() {
  _iprintlnbold("Race failed!");
  var_0 = getEntArray("bell_race_lamp", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.model == "aac_lamp_03_on") {
      var_2 setModel("aac_lamp_03");
    }
  }
}

bell_race_complete() {
  _iprintlnbold("Race complete!");
  level.bell_race_log_trig common_scripts\utility::_id_9DA3();
  level.bell_race_log show();
  var_0 = _getEnt("bell_race_box", "script_noteworthy");
  var_0 movegravity((100, 100, 180), 1);
  common_scripts\utility::flag_set("bell_race_complete");
  level notify("bell_race_bells_complete");
}

debug_cheat_bell_race_complete() {}

debug_bell_race_complete() {
  bell_race_complete();
}

__________________hangman__________________() {}

hangman_setup() {
  thread hangman_handler();
}

hangman_handler() {
  level endon("game_over");
  var_0 = hangman_setup_word_array();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    hangman_hide_parts();
    var_2 = var_0[var_1];
    var_3 = hangman_attempt_to_solve(var_2);

    if(var_3) {
      hangman_give_reward(var_2);
    } else {
      hangman_show_failure();
    }

    wait 2;
  }

  hangman_cleanup();
}

hangman_setup_word_array() {
  var_0 = 7;
  var_1 = [];

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1[var_1.size] = var_2;
  }

  var_1 = common_scripts\utility::array_randomize(var_1);
  var_3 = [];
  var_3[var_1[0]] = ["r", "e", "a", "p", "e", "r"];
  var_3[var_1[1]] = ["d", "a", "m", "n", "a", "t", "i", "o", "n"];
  var_3[var_1[2]] = ["f", "a", "m", "i", "s", "h", "e", "d"];
  var_3[var_1[3]] = ["w", "o", "n", "d", "e", "r"];
  var_3[var_1[4]] = ["g", "e", "i", "s", "t", "k", "r", "a", "f", "t"];
  var_3[var_1[5]] = ["g", "l", "u", "t", "t", "o", "n", "y"];
  var_3[var_1[6]] = ["t", "h", "e", "j", "a", "c", "k", "b", "o", "x"];
  return var_3;
}

hangman_attempt_to_solve(var_0) {
  var_1 = [];
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_1[var_3] = " _ ";
  }

  var_4 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  var_5 = 0;
  childthread hangman_update_cursor_letter(var_4, var_5);
  childthread hangman_attempt_to_solve_forward_input();
  childthread hangman_attempt_to_solve_backward_input();
  childthread hangman_attempt_to_solve_lockin_input();

  while(!hangman_check_words_against_eachother(var_1, var_0)) {
    var_6 = level common_scripts\utility::waittill_any_return("hangman_forward_selection", "hangman_backward_selection", "hangman_lockin_selection");

    if(var_6 == "hangman_forward_selection") {
      var_5++;

      if(var_5 >= var_4.size) {
        var_5 = 0;
      }

      childthread hangman_update_cursor_letter(var_4, var_5);
    } else if(var_6 == "hangman_backward_selection") {
      var_5--;

      if(var_5 < 0) {
        var_5 = var_4.size - 1;
      }

      childthread hangman_update_cursor_letter(var_4, var_5);
    } else if(var_6 == "hangman_lockin_selection") {
      if(common_scripts\utility::_id_0F79(var_2, var_4[var_5])) {
        waitframe();
        continue;
      }

      var_7 = hangman_attempt_letter_entry(var_0, var_4, var_5);

      if(var_7) {
        for(var_3 = 0; var_3 < var_0.size; var_3++) {
          if(var_0[var_3] == var_4[var_5]) {
            var_1[var_3] = var_0[var_3];
            var_8 = _getEnt("hangman_letter_panel" + common_scripts\utility::_id_9AAD(var_3 + 1), "script_noteworthy");
            var_8 setModel("zbr_cab_letter_" + var_4[var_5]);
            var_8 show();
          }
        }
      } else {
        var_2[var_2.size] = var_4[var_5];
        hangman_add_zombie_part(var_2.size);

        if(var_2.size >= 6) {
          return 0;
        }
      }
    }

    waitframe();
    waitframe();
  }

  return 1;
}

hangman_attempt_letter_entry(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(var_4 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

hangman_update_cursor_letter(var_0, var_1) {
  level notify("hangman_showing_new_letter");
  level endon("hangman_showing_new_letter");
  var_2 = _getEnt("hangman_letter_cursor", "targetname");
  var_2 setModel("zbr_cab_letter_" + var_0[var_1]);
}

hangman_attempt_to_solve_forward_input() {
  var_0 = _getEnt("hangman_letter_forward", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    level notify("hangman_forward_selection");
    waitframe();
  }
}

hangman_attempt_to_solve_backward_input() {
  var_0 = _getEnt("hangman_letter_back", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    level notify("hangman_backward_selection");
    waitframe();
  }
}

hangman_attempt_to_solve_lockin_input() {
  var_0 = _getEnt("hangman_letter_submit", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    level notify("hangman_lockin_selection");
    waitframe();
  }
}

hangman_check_words_against_eachother(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] != var_1[var_2]) {
      return 0;
    }
  }

  return 1;
}

hangman_add_zombie_part(var_0) {
  var_1 = _getEnt("hangman_zombie_part_0" + common_scripts\utility::_id_9AAD(var_0), "targetname");
  var_1 show();

  if(var_0 >= 6) {
    maps\mp\_utility::_id_2CED(2, ::hangman_hide_parts);
  }
}

hangman_hide_parts() {
  var_0 = getEntArray("hangman_zombie_part", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_4 = getEntArray("hangman_letter_panel", "targetname");

  foreach(var_6 in var_4) {
    var_6 hide();
  }
}

hangman_give_reward(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];
  }

  var_3 = common_scripts\utility::_id_46B5("hangman_prize_spot", "targetname");

  switch (var_1) {
    case "reaper":
      maps\mp\gametypes\zombies::_id_281C("insta_kill", var_3.origin);
      break;
    case "damnation":
      maps\mp\gametypes\zombies::_id_281C("nuke", var_3.origin);
      break;
    case "famished":
      maps\mp\gametypes\zombies::_id_281C("ammo", var_3.origin);
      break;
    case "gluttony":
      maps\mp\gametypes\zombies::_id_281C("double_points", var_3.origin);
      break;
    case "geistkraft":
      maps\mp\gametypes\zombies::_id_281C("ability_fill", var_3.origin);
      break;
    case "wonder":
      thread hangman_give_razer_gun(var_3);
      thread hangman_give_tesla_gun(var_3);
      break;
    case "thejackbox":
      thread hangman_give_jack_in_the_box(var_3);
      break;
    default:
      break;
  }
}

hangman_give_jack_in_the_box(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 25));
  var_1 setModel("npc_zom_jack_in_the_box");
  var_1.angles = var_1.angles + (0, -90, 0);
  var_1 _id_0547::_id_AC41(" ");
  var_2 = spawn("script_model", var_0.origin + (0, 0, -205));
  var_2 setModel("tag_origin");
  var_2.angles = var_2.angles + (-90, 0, 0);
  _playFXOnTag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");

  for(;;) {
    var_1 waittill("player_used", var_3);

    if(!isDefined(var_3._id_4B72) || !var_3._id_4B72) {
      var_3 thread _id_057D::_id_4766();
      break;
    } else {
      var_3 setweaponammoclip("jack_in_box_decoy_zm", 3);
      break;
    }
  }

  var_1 delete();
  _killfxontag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");
  var_2 delete();
}

hangman_give_razer_gun(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, -48, 45));
  var_1 setModel("npc_zom_sawgun_01");
  var_1.angles = var_1.angles + (0, -45, 0);
  var_1 _id_0547::_id_AC41(" ");
  var_2 = spawn("script_model", var_0.origin + (0, -48, -200));
  var_2 setModel("tag_origin");
  var_2.angles = var_2.angles + (-90, 0, 0);
  _playFXOnTag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");
  var_1 waittill("player_used", var_3);
  var_3 _id_0586::_id_078C("razergun_zm");
  var_3 _id_0586::_id_078E("razergun_zm");
  var_1 _id_0547::_id_AC40();
  var_1 delete();
  _killfxontag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");
  var_2 delete();
}

hangman_give_tesla_gun(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 48, 45));
  var_1 setModel("tag_origin");
  var_1.angles = var_1.angles + (0, -45, 0);
  var_1 _id_0547::_id_AC41(" ");
  var_2 = spawn("script_model", var_0.origin + (0, 48, -200));
  var_2 setModel("tag_origin");
  var_2.angles = var_2.angles + (-90, 0, 0);
  var_3 = _id_0586::create_streamed_world_weapon_model("teslagun_zm", var_1.origin);
  var_3.angles = var_1.angles;
  _playFXOnTag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");
  var_1 waittill("player_used", var_4);
  _id_0548::_id_A7D6(var_4, "teslagun_zm");
  var_4 _id_0586::_id_078E("teslagun_zm");
  var_1 _id_0547::_id_AC40();
  var_1 delete();
  _killfxontag(level._effect["zmb_ber_gun_cone_glow"], var_2, "tag_origin");
  var_2 delete();
  var_3 delete();
}

hangman_show_failure() {}

hangman_cleanup() {}

__________________airship_audiolog__________________() {}

airship_audiolog_init() {
  airship_audiolog_setup_pods();
  aiship_audiolog_collect_souls();
  airship_audiolog_handle_valves();
}

airship_audiolog_setup_pods() {
  var_0 = _getEnt("beam_pod", "script_noteworthy");
  var_1 = _getEnt("log_pod", "script_noteworthy");
  var_0.angles = var_0.angles + (0, 90, 0);
  var_1.angles = var_1.angles + (0, 90, 0);
  var_0 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, 0.01);
  var_1 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, 0.01);
  waitframe();
  var_0 setshadowrendering(1);
  var_1 setshadowrendering(1);
}

aiship_audiolog_collect_souls() {
  level endon("flag_override_electroschnell_complete");
  var_0 = getEntArray("hack_node_generic", "script_noteworthy");
  var_1 = _getEnt("airship_node_03_05", "targetname");
  var_0 = common_scripts\utility::_id_0F93(var_0, var_1);
  var_2 = 0;

  while(!var_2) {
    level waittill("hack_node_soul_collected");
    var_2 = 1;

    foreach(var_4 in var_0) {
      if(!isDefined(var_4.soul_charged) || !var_4.soul_charged) {
        var_2 = 0;
        break;
      }
    }
  }
}

airship_audiolog_handle_valves() {
  level endon("flag_override_electroschnell_complete");

  while(!isDefined(level.players) || level.players.size <= 0) {
    waitframe();
  }

  thread airship_audiolog_log_valve();
  thread airship_audiolog_beam_valve();
}

airship_audiolog_log_valve() {
  level endon("flag_override_electroschnell_complete");
  var_0 = getEntArray("lore_primary", "script_noteworthy");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.setlookatent == "lore18") {
      var_1 = var_3;
      break;
    }
  }

  var_5 = _getEnt(var_1.target, "targetname");
  var_5 common_scripts\utility::_id_9D9F();
  thread airship_audiolog_open_doors("log_pod_open_trig", "log_pod_open_valve", "log_pod", "make_airship_audiolog_usable");
  level waittill("make_airship_audiolog_usable");
  var_5 common_scripts\utility::_id_9DA3();
}

airship_audiolog_beam_valve() {
  level endon("flag_override_electroschnell_complete");
  airship_audiolog_open_doors("beam_pod_open_trig", "beam_pod_open_valve", "beam_pod");
}

airship_audiolog_open_doors(var_0, var_1, var_2, var_3) {
  level endon("flag_override_electroschnell_complete");
  var_4 = _getEnt(var_0, "script_noteworthy");
  var_5 = _getEnt(var_1, "script_noteworthy");
  var_6 = _getEnt(var_2, "script_noteworthy");
  var_4.players_using = 0;

  foreach(var_8 in level.players) {
    var_8 thread airship_audiolog_open_door_player_handler(var_5, var_4, var_6, var_3);
  }
}

#using_animtree("animated_props_zombies_DLC2");

airship_audiolog_open_door_player_handler(var_0, var_1, var_2, var_3) {
  level endon("game_over");
  level endon("flag_override_electroschnell_complete");
  var_4 = _getanimlength(%s2_zmb_drop_pod_open_front_quick);
  var_5 = 0.1;
  var_6 = 0;

  while(!var_6) {
    if(self useButtonPressed() && self istouching(var_1) && var_1.players_using == 0) {
      var_1.players_using++;
      var_2 scriptmodelclearanim();
      var_2 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, var_5);
      var_7 = gettime();
      var_8 = var_4 / var_5;
      var_9 = 0;
      var_9 = airship_audiolog_open_door_player_input_think(var_7, var_8, var_1, var_0);

      if(isDefined(var_9) && var_9) {
        var_6 = 1;
        var_2 setshadowrendering(1);
      } else {
        var_10 = (gettime() - var_7) * 0.001 * var_5;
        var_11 = clamp(var_4 - var_10, 0, var_4);
        var_12 = 0.5;
        var_2 scriptmodelclearanim();
        var_2 scriptmodelplayanim("s2_zmb_drop_pod_close_front_quick", undefined, var_11, var_12);
        wait(var_4 / var_12);
        var_1.players_using = 0;
      }
    }

    while(_id_0547::_id_577E(self)) {
      waitframe();
    }

    waitframe();
  }

  if(isDefined(var_3)) {
    level notify(var_3);
  }
}

airship_audiolog_open_door_player_input_think(var_0, var_1, var_2, var_3) {
  level endon("flag_override_electroschnell_complete");
  self endon("death");
  self endon("disconnect");
  self endon("enter_last_stand");
  self endon("begin_last_stand");
  var_4 = 0;
  var_5 = 0;

  while(var_4 < var_1 * 1000 / 3) {
    waitframe();

    if(self useButtonPressed() && self istouching(var_2)) {
      var_4 = gettime() - var_0;
      var_3 rotateroll(1, 0.05);
      var_5++;
      continue;
    }

    var_3 rotateroll(-1 * var_5, 0.5);
    return 0;
  }

  return 1;
}

______________transmedia_event____________________() {}

transmedia_event_init() {
  transmedia_event_waitfor_radio_tuned();
  transmedia_event_give_prize();
}

transmedia_event_waitfor_radio_tuned() {
  while(!isDefined(level.tuner_values)) {
    waitframe();
  }

  waitframe();
  var_0 = 38.9;
  var_1 = 39.7;
  var_2 = 0;

  while(!var_2) {
    while(!quest_step_use_radio_codes_check(var_1, "right") || !quest_step_use_radio_codes_check(var_0, "left")) {
      waitframe();
    }

    var_3 = 60000;
    var_4 = gettime();
    var_5 = 0;

    while(var_3 > var_5) {
      if(quest_step_use_radio_codes_check(var_1, "right") && quest_step_use_radio_codes_check(var_0, "left")) {
        var_5 = gettime() - var_4;

        if(var_3 <= var_5) {
          var_2 = 1;
          break;
        }
      }

      waitframe();
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_6 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_6] = [];
  level.possible_radio_codes[var_6]["left"] = var_0;
  level.possible_radio_codes[var_6]["right"] = var_1;
}

transmedia_event_give_prize() {
  if(maps\mp\_utility::isproductionlevelactive(12)) {
    foreach(var_1 in level.players) {
      var_1 _meth_8697(16, [3, 22]);
      var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zom_dlc2_rune_01");
    }
  }
}

_______________outro_______________________________() {}

run_outro_berlin() {
  _preloadcinematicforall("mp/mp_zombie_berlin_outro");

  foreach(var_1 in _id_0547::_id_408F()) {
    var_1 _id_056D::_id_5A86();
  }

  foreach(var_4 in level.players) {
    var_4 playersetgroundreferenceent(undefined);
  }

  _id_054D::giveplayersexp("berlin_exp_ref_17");
  _id_0547::zm_util_run_outro("mp/mp_zombie_berlin_outro", 51, 0.5, 1, 0, "berl_outro_movie");
  maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_1();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  common_scripts\utility::flag_set("berlin_cinematic_done");

  foreach(var_4 in level.players) {
    var_4 _id_056A::_id_4772(1);
  }

  level._id_6F1E = 0;
}