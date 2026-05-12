/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_ee.gsc
*********************************************/

func_00D5() {
  level.upgrade_machine_reveal_func = ::wait_for_upgrade_machine_arrived;
  lib_0557::func_7846("quest_get_bearings", ::lib_0557::func_30D8, [], &"ZOMBIE_BERLIN_HINT_QUEST_GET_BEARINGS");
  lib_0557::func_781E("quest_get_bearings", "step_get_bearings", ::quest_step_get_bearings, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_GET_BEARINGS");
  lib_0557::func_7848("quest_get_bearings");
  common_scripts\utility::func_3C87("flag_exit_underbelly");
  common_scripts\utility::func_3C87("flag_straub_death_scene");
  lib_0557::func_7846("quest_contact_hq", ::lib_0557::func_30D8, ["quest_get_bearings"], &"ZOMBIE_BERLIN_HINT_QUEST_CONTACT_HQ");
  lib_0557::func_781E("quest_contact_hq", "step_find_radio", ::quest_step_find_radio, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_RADIO");
  lib_0557::func_781E("quest_contact_hq", "step_use_radio", ::quest_step_use_radio, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_USE_RADIO");
  lib_0557::func_7848("quest_contact_hq");
  lib_0557::func_7846("quest_contact_soviets", ::lib_0557::func_30D8, ["quest_contact_hq"], &"ZOMBIE_BERLIN_HINT_QUEST_CONTACT_SOVIETS");
  lib_0557::func_781E("quest_contact_soviets", "step_contact_soviets", ::quest_step_use_radio_codes_listener, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_CONTACT_SOVIETS");
  lib_0557::func_7848("quest_contact_soviets");
  lib_0557::func_7846("quest_draw_airship", ::lib_0557::func_30D8, ["quest_contact_soviets"], &"ZOMBIE_BERLIN_HINT_QUEST_DRAW_AIRSHIP");
  lib_0557::func_781E("quest_draw_airship", "step_ignite_flare", ::lib_0557::func_30D8, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_IGNITE_FLARE");
  lib_0557::func_7848("quest_draw_airship");
  common_scripts\utility::func_3C87("flag_drop_pod_reached_airship");
  thread airship_master_logic();
  thread setup_airship_anchors();
  lib_0557::func_7846("quest_bring_down_airship", ::lib_0557::func_30D8, ["quest_draw_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_BRING_DOWN_AIRSHIP");
  lib_0557::func_781E("quest_bring_down_airship", "step_reel_anchors", ::quest_step_airship_anchors, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_REEL_ANCHORS");
  lib_0557::func_781E("quest_bring_down_airship", "step_enter_dropcage", ::quest_drop_pod_enter_drop_pod_listener, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_ENTER_DROPCAGE");
  lib_0557::func_781E("quest_bring_down_airship", "step_raise_dropcage", ::lib_0557::func_30D8, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_RAISE_DROPCAGE");
  lib_0557::func_7848("quest_bring_down_airship");
  thread quest_drop_pod_init();
  lib_0557::func_7846("quest_the_wunderbuss", ::lib_0557::func_30D8, ["quest_draw_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_ASSEMBLE_WUNDERBUSS");
  lib_0557::func_781E("quest_the_wunderbuss", "step_assemble_weapon", ::lib_0557::func_30D8, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_PARTS");
  lib_0557::func_7848("quest_the_wunderbuss");
  thread quest_wunderbuss_init();
  lib_0557::func_7846("quest_defeat_straub", ::lib_0557::func_30D8, ["quest_bring_down_airship"], &"ZOMBIE_BERLIN_HINT_QUEST_DEFEAT_STRAUB");
  lib_0557::func_781E("quest_defeat_straub", "step_find_straub", ::quest_step_find_way_through_cargo_bay, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_FIND_STRAUB");
  lib_0557::func_781E("quest_defeat_straub", "step_override_electroschnell", ::quest_step_overload_straubs_electroschnell, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_OVERRIDE_ELECTROSCHNELL");
  lib_0557::func_7848("quest_defeat_straub");
  lib_0557::func_7846("quest_bob", ::lib_0557::func_30D8, ["quest_defeat_straub"], &"ZOMBIE_BERLIN_HINT_QUEST_BOB");
  lib_0557::func_781E("quest_bob", "step_defeat_bob", ::quest_step_defeat_bob, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_DEFEAT_BOB");
  lib_0557::func_781E("quest_bob", "step_escape_airship", ::escape_airship_logic, ::lib_0557::func_30D8, &"ZOMBIE_BERLIN_HINT_STEP_ESCAPE_AIRSHIP");
  lib_0557::func_7848("quest_bob");
  thread quest_init_defeat_straub();
  thread escape_airship_init();
  thread flare_box_init();
  thread quest_pap_init();
  thread js_sewer_board();
  thread js_dancer();
  level thread maps\mp\_utility::func_6F74(::maps\mp\mp_zombie_berlin_utils::spine_player_manager);
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
  level endon(lib_0557::func_7838("quest_get_bearings", "step_get_bearings"));
  var_00 = getEntArray("quest_trig_get_bearings", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread maps\mp\mp_zombie_berlin_utils::complete_quest_on_trigger("quest_get_bearings", "step_get_bearings");
    var_02 thread quest_step_get_bearings_complete();
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_logic();
}

quest_step_get_bearings_complete() {
  level endon(lib_0557::func_7838("quest_get_bearings", "step_get_bearings"));
  self waittill("trigger");
  var_00 = getEntArray("quest_trig_get_bearings", "targetname");
  foreach(var_02 in var_00) {
    var_02 common_scripts\utility::func_9D9F();
  }

  common_scripts\utility::func_3C8F("flag_exit_underbelly");
  iprintlnbold("We have to find a radio and contact HQ for help!");
}

___________________find_radio___________________() {}

quest_step_find_radio() {
  level endon(lib_0557::func_7838("quest_contact_hq", "step_find_radio"));
  maps\mp\mp_zombie_berlin_utils::radio_system_setup();
  var_00 = getent("quest_trig_find_radio", "targetname");
  var_00 thread maps\mp\mp_zombie_berlin_utils::complete_quest_on_trigger("quest_contact_hq", "step_find_radio");
  var_00 thread quest_step_find_radio_complete();
}

quest_step_find_radio_complete() {
  var_00 = getent("radio_tuner_right", "targetname");
  var_01 = 0;
  while(var_01 == 0) {
    foreach(var_03 in level.var_744A) {
      if(distance(var_03.var_116, var_00.var_116) < 300) {
        var_04 = lib_0380::func_288B("zmb_berl_gfm_radio_help", undefined, var_00);
        lib_0380::func_288F(var_04, var_00, "radio_help_dlg_done");
        level notify("radio_found");
        var_01 = 1;
      }
    }

    wait(1);
  }

  var_00 waittill("radio_help_dlg_done");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("radio_found");
}

quest_step_use_radio() {
  level endon(lib_0557::func_7838("quest_contact_hq", "step_use_radio"));
  quest_setup_use_radio_waitfor_playeruse();
  thread quest_step_use_radio_complete();
}

quest_setup_use_radio_waitfor_playeruse() {
  thread maps\mp\mp_zombie_berlin_utils::radio_system_init();
  level waittill("player_used_radio", var_00);
  level.radio_user = var_00;
  thread quest_setup_use_radio_listener(var_00);
}

quest_step_use_radio_complete() {
  lib_0557::func_782D("quest_contact_hq", "step_use_radio");
  wait(0.5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("radio_range_discovery");
  iprintlnbold("Damn! It\'s only a short-range radio.");
  wait(3);
  iprintlnbold("The Red Army is our only hope now.");
  wait(3);
  iprintlnbold("We need to figure out what to tune this to.");
}

__________________contact_soviets__________________() {}

quest_step_use_radio_codes_listener() {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_contact_hq", "step_use_radio"));
  lib_054D::giveplayersexp("berlin_exp_ref_23");
  var_00 = 0;
  while(!var_00) {
    while(!quest_step_use_radio_codes_check(level.radio_code_right, "right") || !quest_step_use_radio_codes_check(level.radio_code_left, "left")) {
      wait 0.05;
    }

    var_01 = 2500;
    var_02 = gettime();
    var_03 = 0;
    while(var_01 > var_03) {
      if(quest_step_use_radio_codes_check(level.radio_code_right, "right") && quest_step_use_radio_codes_check(level.radio_code_left, "left")) {
        var_03 = gettime() - var_02;
        if(var_01 <= var_03) {
          var_00 = 1;
          break;
        }
      }

      wait 0.05;
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_04 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_04] = [];
  level.possible_radio_codes[var_04]["left"] = level.radio_code_left;
  level.possible_radio_codes[var_04]["right"] = level.radio_code_right;
  thread maps\mp\mp_zombie_berlin_utils::radio_system_suspend_tuning_for_response();
  lib_054D::giveplayersexp("berlin_exp_ref_22");
  if(isDefined(level.radio_user)) {
    level.radio_user lib_0367::func_8E3C("radio_conversation_start");
  }

  lib_0378::func_8D74("aud_radio_tuning", "dialog_playing", "zmb_berl_mkh_radio_conversation_reply");
  wait(23);
  if(isDefined(level.radio_user)) {
    level.radio_user lib_0367::func_8E3C("radio_conversation_end");
  }

  iprintlnbold("Russians need to know you\'re on their side.");
  wait(3);
  iprintlnbold("They ask you to take down Straub\'s airship.");
  wait(3);
  thread quest_step_contact_soviets_complete();
}

quest_step_use_radio_codes_check(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  param_00 = int(param_00);
  var_02 = 2;
  if(!isDefined(level.tuner_values) || !isDefined(level.tuner_values["radio_tuner"]) || !isDefined(level.tuner_values["radio_tuner"][param_01])) {
    return 0;
  }

  for(var_03 = -1 * var_02; var_03 < var_02; var_03++) {
    if(param_00 == level.tuner_values["radio_tuner"][param_01] + var_03) {
      return 1;
    }
  }

  return 0;
}

quest_setup_use_radio_listener(param_00) {
  while(!common_scripts\utility::func_3C77(lib_0557::func_7838("quest_contact_soviets", "step_contact_soviets"))) {
    param_00 waittill("stop_using_station");
    level waittill("player_used_radio", param_00);
    level.radio_user = param_00;
  }
}

quest_step_contact_soviets_complete() {
  lib_0557::func_782D("quest_contact_soviets", "step_contact_soviets");
}

__________________attract_airship__________________() {}

quest_step_find_flare() {
  thread flare_box_helper();
  wait(4);
  iprintlnbold("We\'ve got to find some way to draw in the airship!");
}

flare_box_init() {
  var_00 = getent("flare_crate_closed", "script_noteworthy");
  var_01 = getent("flare_crate_interact_trig", "targetname");
  var_02 = getent("trig_dmg_flare_lock", "script_noteworthy");
  var_03 = getent("trig_dmg_flare_crate", "script_noteworthy");
  var_04 = 0;
  var_05 = 0;
  var_02 waittill("damage");
  self notify("notify_crate_smash_open");
  level thread common_scripts\_exploder::func_88E(224);
  lib_0378::func_8D74("aud_open_flare_crate", var_00.var_116);
  var_00 method_8495("zom_berlin_flare_box_open", var_00.var_116, var_00.var_1D);
  var_04 = 1;
  wait 0.05;
  for(;;) {
    var_03 waittill("damage");
    lib_0378::func_8D74("aud_flare_triggered", var_00.var_116);
    var_06 = getent("origin_flare_crate_fx", "targetname");
    playFX(level.var_611["flare_sparks"], var_06.var_116);
    wait(0.5);
    playFX(level.var_611["zmb_ber_warning_flare"], var_06.var_116);
    playFX(level.var_611["flare_sparks"], var_06.var_116);
    wait(0.4);
    playFX(level.var_611["flare_sparks"], var_06.var_116);
    playFX(level.var_611["zmb_ber_warning_flare"], var_06.var_116);
    wait(1);
    if(common_scripts\utility::func_3C77(lib_0557::func_7838("quest_contact_soviets", "step_contact_soviets")) && !common_scripts\utility::func_3C77("flag_airship_summoned")) {
      common_scripts\utility::func_3C8F("flag_airship_summoned");
      common_scripts\utility::func_3C8F("flag_sizzlers_active");
      iprintlnbold("Airship summoned!");
      lib_0557::func_782D("quest_draw_airship", "step_ignite_flare");
      lib_054D::giveplayersexp("berlin_exp_ref_21");
      foreach(var_08 in level.var_744A) {
        var_08 thread maps\mp\mp_zombie_berlin_utils::vo_first_sizzler_transformation();
      }

      wait(2);
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("flares_fired");
      wait(1.5);
      thread maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_recognise_alt", "exterior", 0, level.straub_airship);
      wait(8.5);
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_en_route");
      wait(15);
      maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_drop_pod_alt_1", "exterior", 0, level.straub_airship);
      wait(2);
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_tethered");
    }

    wait(5);
  }
}

flare_box_helper() {
  level endon(lib_0557::func_7838("quest_draw_airship", "step_find_flare"));
  var_00 = level.var_A980 + 2;
  if(!1) {
    var_01 = level.var_A980;
    var_00 = var_01 + 2;
    if(1) {
      wait(200);
    }

    if(1) {
      if(level.var_A980 <= var_00) {
        for(;;) {
          level waittill("zombie_wave_started");
          if(level.var_A980 > var_00) {
            break;
          }
        }
      }
    }

    level.flare_box_helper_tripped = 1;
  }
}

flare_box_highlight(param_00) {
  if(1) {
    if(!isDefined(level.flare_crate_data)) {
      var_01 = getent("flare_crate_closed", "script_noteworthy");
      level.flare_crate_data = lib_0557::func_782F(undefined, var_01);
    }

    if(param_00) {
      lib_0557::func_781D("quest_draw_airship", level.flare_crate_data);
      return;
    }

    lib_0557::func_7847("quest_draw_airship", level.flare_crate_data);
  }
}

flare_crate_smash_open() {}

__________________bring_down_airship__________________() {}

setup_airship_anchors() {
  common_scripts\utility::func_3C87("flag_airship_anchor_a_reeled");
  common_scripts\utility::func_3C87("flag_airship_anchor_b_reeled");
  common_scripts\utility::func_3C87("flag_airship_anchor_c_reeled");
  common_scripts\utility::func_3C87("flag_airship_anchor_d_reeled");
  common_scripts\utility::func_3C87("flag_airship_anchor_c_being_charged");
  common_scripts\utility::func_3C7B("flag_airship_anchor_c_being_charged");
  var_00 = getent("origin_anchor_base_a", "script_noteworthy");
  var_00 method_805C();
}

quest_step_airship_anchors() {
  var_00 = getEntArray("airship_anchor_model", "script_noteworthy");
  var_01 = getEntArray("airship_anchor_ring", "script_noteworthy");
  foreach(var_03 in var_00) {
    var_03.tether_ambient_effects = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_ambient"], var_03, "Tag_Origin");
    triggerfx(var_03.tether_ambient_effects);
    foreach(var_05 in var_01) {
      if(var_05.var_8260 == var_03.var_8260) {
        var_03.ring = var_05;
        var_03.ring.var_116 = var_03.var_116;
        var_03.ring linkto(var_03, "glow_ring");
        break;
      }
    }

    var_07 = 125;
    var_03.damage_trig = undefined;
    switch (var_03.var_8260) {
      case "airship_tether_refuge":
        var_03.damage_trig = getent("airship_anchor_trig_refuge", "script_noteworthy");
        var_03.damage_trig thread airship_anchor_get_blasted(var_03, var_07, "flag_airship_anchor_a_reeled");
        var_03.damage_trig thread airship_anchor_charge_wait_for_damage(var_03, var_07);
        break;

      case "airship_tether_underbelly":
        var_03.damage_trig = getent("airship_anchor_trig_underbelly", "script_noteworthy");
        var_03.damage_trig thread airship_anchor_get_blasted(var_03, var_07, "flag_airship_anchor_b_reeled");
        var_03.damage_trig thread airship_anchor_charge_wait_for_damage(var_03, var_07);
        break;

      case "airship_tether_courtyard":
        var_03.damage_trig = getent("airship_anchor_trig_courtyard", "script_noteworthy");
        var_03.damage_trig thread airship_anchor_get_blasted(var_03, var_07, "flag_airship_anchor_c_reeled");
        var_03.damage_trig thread airship_anchor_charge_wait_for_damage(var_03, var_07);
        var_03 thread airship_anchor_soul_bucket(10, "flag_airship_anchor_c_reeled");
        break;

      case "airship_tether_museum":
        var_03.damage_trig = getent("airship_anchor_trig_museum", "script_noteworthy");
        var_03.damage_trig thread airship_anchor_get_blasted(var_03, var_07, "flag_airship_anchor_d_reeled");
        var_03.damage_trig thread airship_anchor_charge_wait_for_damage(var_03, var_07);
        var_03.damage_trig thread airship_anchor_museum_first_shot(var_03);
        break;

      default:
        break;
    }

    var_03.damage_trig enablelinkto();
    var_03.damage_trig method_8449(var_03);
    var_03.damage_trig method_80B0(var_03.damage_trig method_85A0() | 256);
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_airship_anchor_damage();
  thread maps\mp\mp_zombie_berlin_utils::vo_straub_airship_anchor_damage();
  level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];
  common_scripts\utility::func_3CA1(level.airship_anchor_flag_array);
  lib_054D::giveplayersexp("berlin_exp_ref_16");
  lib_0557::func_782D("quest_bring_down_airship", "step_reel_anchors");
}

airship_anchor_get_blasted(param_00, param_01, param_02) {
  thread airship_anchor_wonderweapon_collection(param_00, param_01, param_02);
  level waittill("airship_anchor_courtyard_impact");
  while(!common_scripts\utility::func_3C77(param_02)) {
    self waittill("damage", var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C);
    if(isDefined(var_0C) && var_0C == "wunderbuss_zm" && !common_scripts\utility::func_3C89(param_02)) {
      self notify("notify_airship_anchor_blasted");
      level notify("airship_anchor_damaged");
      if(!isDefined(self.tether_impact)) {
        self.tether_impact = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_charge"], param_00, "Tag_Origin");
      }

      triggerfx(self.tether_impact);
    }

    wait 0.05;
  }

  if(isDefined(self.tether_impact)) {
    self.tether_impact delete();
  }
}

airship_anchor_museum_first_shot(param_00) {
  self waittill("notify_airship_anchor_blasted");
  playFX(level.var_611["zmb_tether_rock_burst"], param_00.var_116);
}

airship_anchor_soul_bucket(param_00, param_01) {
  level endon(param_01);
  level waittill("airship_anchor_courtyard_impact");
  var_02 = getent("origin_anchor_base_a", "script_noteworthy");
  var_02 setModel("tag_origin");
  var_02 method_805B();
  self.percent_filled = 0;
  thread airship_anchor_charge_progress_vfx();
  thread airship_anchor_soul_bucket_charge(param_00, var_02);
  var_02 maps\mp\mp_zombies_soul_collection::func_170B(param_00, 180, 140, "zmb_anchor_c_zombie_killed", undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 100));
  if(!common_scripts\utility::func_3C77("flag_airship_anchor_c_reeled")) {
    if(!isDefined(level.airship_lower_percentage)) {
      level.airship_lower_percentage = 0;
    }

    level.airship_lower_percentage = level.airship_lower_percentage + 25;
    playFX(level.var_611["zmb_ber_zep_tether_charge"], var_02.var_116);
    iprintlnbold("soul collection for " + param_01 + " end");
    common_scripts\utility::func_3C8F(param_01);
    var_03 = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_on"], self, "Tag_Origin");
    triggerfx(var_03);
    self notify("anchor_charge_complete");
    common_scripts\utility::func_3C7B("flag_airship_anchor_c_being_charged");
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
  }
}

airship_anchor_wonderweapon_collection(param_00, param_01, param_02) {
  self.timesblasted = 0;
  param_00.percent_filled = 0;
  param_00 thread airship_anchor_charge_progress_vfx();
  while(param_01 > self.timesblasted) {
    self waittill("notify_airship_anchor_blasted");
    self.timesblasted++;
    param_00.percent_filled = self.timesblasted / param_01 * 100;
    wait 0.05;
  }

  if(!common_scripts\utility::func_3C77(param_02)) {
    common_scripts\utility::func_3C8F(param_02);
    var_03 = getent("origin_anchor_base_a", "script_noteworthy");
    level.var_8E3 = common_scripts\utility::func_F93(level.var_8E3, var_03);
    if(!isDefined(level.airship_lower_percentage)) {
      level.airship_lower_percentage = 0;
    }

    level.airship_lower_percentage = level.airship_lower_percentage + 25;
    param_00.tether_ambient_effects delete();
    var_04 = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_on"], param_00, "Tag_Origin");
    thread maps\mp\mp_zombie_berlin_lighting::set_anchor_fast_pulse_lights();
  }
}

airship_anchor_charge_progress_vfx() {
  for(;;) {
    if(self.percent_filled > 0) {
      var_00 = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_charge_a"], self, "Tag_Origin");
      triggerfx(var_00);
      iprintlnbold("Play 1-49% VFX");
      break;
    }

    wait 0.05;
  }

  for(;;) {
    if(self.percent_filled > 50) {
      var_01 = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_charge_b"], self, "Tag_Origin");
      var_00 delete();
      triggerfx(var_01);
      iprintlnbold("Play 50-99% VFX");
      break;
    }

    wait 0.05;
  }

  for(;;) {
    if(self.percent_filled >= 100) {
      var_02 = spawnlinkedfx(level.var_611["zmb_ber_zep_tether_charge_c"], self, "Tag_Origin");
      var_01 delete();
      triggerfx(var_02);
      iprintlnbold("Play 100% VFX");
      break;
    }

    wait 0.05;
  }
}

airship_anchor_soul_bucket_charge(param_00, param_01) {
  self endon("anchor_charge_complete");
  for(;;) {
    level waittill("zmb_anchor_c_zombie_killed");
    self.damage_trig.timesblasted = self.damage_trig.timesblasted + 4;
    self.percent_filled = param_01.var_AC2C * 10;
    if(!common_scripts\utility::func_3C77("flag_airship_anchor_c_being_charged")) {
      airship_anchor_charge_soul_bucket_animation(param_00);
    }
  }
}

airship_anchor_charge_soul_bucket_animation(param_00) {
  self endon("anchor_charge_complete");
  common_scripts\utility::func_3C8F("flag_airship_anchor_c_being_charged");
  if(!isDefined(self.anim_progress)) {
    self.anim_progress = 0;
  }

  var_01 = getanimlength(%s2_zom_zep_tether_scene_ring_up);
  var_02 = var_01 * param_00;
  self.ring scriptmodelplayanim("s2_zom_zep_tether_scene_ring_up", "", self.anim_progress * var_01, 1 / param_00);
  var_03 = 1 / param_00 * var_02;
  wait(var_03);
  self.ring scriptmodelpauseanim(1);
  self.anim_progress = self.anim_progress + clamp(1 / param_00, 0, 1);
  common_scripts\utility::func_3C7B("flag_airship_anchor_c_being_charged");
}

airship_anchor_charge_wait_for_damage(param_00, param_01) {
  param_00 endon("anchor_charge_complete");
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(isDefined(var_0B) && var_0B == "wunderbuss_zm" && !common_scripts\utility::func_3C77("flag_airship_anchor_c_being_charged")) {
      param_00 thread airship_anchor_charge_ring_animation(param_01);
      param_00 thread airship_anchor_charge_ring_listen();
      param_00 waittill("anchor_ring_stop_charging");
    }
  }
}

airship_anchor_charge_ring_animation(param_00) {
  self endon("anchor_charge_complete");
  if(!isDefined(self.anim_progress)) {
    self.anim_progress = 0;
  }

  var_01 = getanimlength(%s2_zom_zep_tether_scene_ring_up);
  var_02 = param_00 * 0.1;
  for(;;) {
    self.ring scriptmodelplayanim("s2_zom_zep_tether_scene_ring_up", "", self.anim_progress * var_01, 1 / var_02);
    common_scripts\utility::func_3C8F("flag_airship_anchor_c_being_charged");
    self.ring_start_time = gettime();
    var_03 = var_02 * 1 - self.anim_progress;
    if(var_03 < 0) {
      var_03 = 0;
    }

    var_04 = common_scripts\utility::func_A74D("anchor_ring_stop_charging", var_03);
    if(isDefined(var_04) && var_04 == "timeout") {
      common_scripts\utility::func_3C7B("flag_airship_anchor_c_being_charged");
      self notify("anchor_charge_complete");
    }

    self.ring scriptmodelpauseanim(1);
    var_05 = gettime() - self.ring_start_time * 0.001;
    self.anim_progress = self.anim_progress + clamp(var_05 / param_00 * 0.1, 0, 1);
    common_scripts\utility::func_3C7B("flag_airship_anchor_c_being_charged");
    break;
  }
}

airship_anchor_charge_ring_listen() {
  self endon("anchor_charge_complete");
  self endon("anchor_ring_stop_charging");
  var_00 = 0;
  var_01 = 1;
  var_02 = 0;
  for(;;) {
    wait(0.1);
    if(self.percent_filled > var_00) {
      thread play_tether_charge_audio(var_02);
      thread tether_charge_scale_pitch(self.percent_filled);
      var_02 = 1;
      var_01 = 1;
    } else {
      var_01 = 0;
      var_02 = 0;
    }

    if(!var_01) {
      self notify("anchor_ring_stop_charging");
    }

    var_00 = self.percent_filled;
  }
}

play_tether_charge_audio(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    lib_0380::func_2893(self.charge_audio_stop, 0.2);
    self.charge_audio_stop = undefined;
    self.charge_audio_start = lib_0380::func_288B("zmb_berl_tether_winch_start", undefined, self);
    self.charge_audio_lp1 = lib_0380::func_6844("zmb_berl_tether_winch_lp", undefined, self, 0.5);
    self.charge_audio_lp2 = lib_0380::func_6844("zmb_berl_tether_winch_lp2", undefined, self, 0.5);
    self.charge_audio_lp3 = lib_0380::func_6844("zmb_berl_tether_winch_lp3", undefined, self, 0.5);
    common_scripts\utility::knock_off_battery("anchor_ring_stop_charging", "anchor_charge_complete");
    lib_0380::func_2893(self.charge_audio_start, 0.2);
    self.charge_audio_start = undefined;
    lib_0380::func_6850(self.charge_audio_lp1, 0.5);
    self.charge_audio_lp1 = undefined;
    lib_0380::func_6850(self.charge_audio_lp2, 0.5);
    self.charge_audio_lp2 = undefined;
    lib_0380::func_6850(self.charge_audio_lp3, 0.5);
    self.charge_audio_lp3 = undefined;
    self.charge_audio_stop = lib_0380::func_288B("zmb_berl_tether_winch_stop", undefined, self);
  }
}

tether_charge_scale_pitch(param_00) {
  var_01 = param_00 / 200 + 0.5;
  if(isDefined(self.charge_audio_lp1)) {
    lib_0380::func_684D(self.charge_audio_lp1, var_01, 0.1);
  }
}

quest_drop_pod_enter_drop_pod_listener() {
  var_00 = getent("quest_trig_enter_dropcage", "targetname");
  var_00 waittill("trigger");
  lib_0557::func_782D("quest_bring_down_airship", "step_enter_dropcage");
}

quest_drop_pod_init() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_00 method_805C();
  var_00 notsolid();
  var_01 = getent("dropcage_push_trigger", "targetname");
  var_01 enablelinkto();
  var_01 method_8449(var_00);
  var_02 = getent("pod_underneath_clip", "targetname");
  var_02 movez(-742, 0.05);
  wait 0.05;
  var_02 method_8449(var_00);
  var_02 notsolid();
  var_02 method_8060();
  var_03 = getent("drop_pod_cable", "script_noteworthy");
  var_03 method_805C();
  var_00.lightfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_drop_pod_light"), var_00, "tag_origin");
  var_00.lightfx method_805C();
  var_04 = getent("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_04 enablelinkto();
  var_04 method_8449(var_00);
  var_04 method_805C();
  var_05 = getent("clip_wpn_drop_pod_winch", "script_noteworthy");
  var_05 method_805C();
  var_05 method_8449(var_00);
  var_06 = getent("clip_drop_pod_closed", "script_noteworthy");
  var_06 method_805C();
  var_06 notsolid();
  var_06 method_8449(var_00);
  var_07 = getent("clip_drop_pod", "script_noteworthy");
  var_07 method_805C();
  var_07 notsolid();
  var_07 method_8449(var_00);
  var_08 = getent("org_tp_plaza", "script_noteworthy");
  var_08 method_8449(var_00);
  var_09 = getEntArray("pod_player_teleport_spot", "script_noteworthy");
  foreach(var_0B in var_09) {
    var_0B method_8449(var_00);
  }

  var_0D = getent("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_0D movez(-128, 0.05);
  wait 0.05;
  var_0D notsolid();
  var_0D method_8060();
  var_0E = getent("clip_door", "script_noteworthy");
  var_0E movez(-128, 0.05);
  wait 0.05;
  var_0E notsolid();
  var_0E method_8060();
  var_0F = getent("model_airship_drop_pod", "script_noteworthy");
  var_0F.airpodlightfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_drop_pod_light"), var_0F, "tag_origin");
  triggerfx(var_0F.airpodlightfx);
  var_0F.airpodlightfx method_805C();
  quest_drop_pod_logic();
}

quest_drop_pod_logic() {
  thread debug_lower_drop_pod_incremental_listen();
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_draw_airship", "step_ignite_flare"));
  wait(1);
  thread quest_drop_pod_show_pod();
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_bring_down_airship", "step_enter_dropcage"));
  level.var_6F1E = 1;
  thread quest_drop_pod_movement();
  thread quest_drop_pod_charge_init();
  thread quest_drop_pod_charge_drain();
  thread quest_drop_pod_teleport_to_airship();
}

quest_drop_pod_show_pod() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_00 method_805B();
  var_00 solid();
  var_01 = getent("drop_pod_cable", "script_noteworthy");
  var_01 method_805B();
  var_00.lightfx method_805B();
  var_02 = getent("clip_drop_pod", "script_noteworthy");
  var_02 method_805B();
  var_02 solid();
  var_03 = getent("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_04 = getent("clip_wpn_drop_pod_winch", "script_noteworthy");
  var_03 method_805B();
  var_04 method_805B();
  var_05 = getent("org_drop_pod_winch_vfx", "script_noteworthy");
  var_06 = spawn("script_model", var_05.var_116);
  var_06 setModel("tag_origin");
  var_06 method_8449(var_00);
  playFXOnTag(level.var_611["zmb_ber_droppod_roof"], var_06, "Tag_Origin");
}

quest_drop_pod_movement() {
  level endon(lib_0557::func_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_00 = getEntArray("clip_drop_pod", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.var_A045 = ::quest_drop_pod_unresolved_collision_func;
  }

  common_scripts\utility::func_3C87("flag_drop_pod_can_be_charged");
  common_scripts\utility::func_3C8F("flag_drop_pod_can_be_charged");
  level.drop_pod_charge = 0;
  var_04 = getent("drop_pod_model", "script_noteworthy");
  var_05 = getent("clip_drop_pod_closed", "script_noteworthy");
  var_06 = 0;
  for(;;) {
    if(level.drop_pod_charge > 0 && !var_06) {
      thread quest_drop_pod_move_up_rumble();
      var_04 lib_0378::func_8D74("droppod_winch_up");
      foreach(var_02 in var_00) {
        var_02.var_A045 = ::quest_drop_pod_unresolved_collision_func;
      }

      var_05 method_805B();
      var_05 solid();
      lib_0378::func_8D74("inside_droppod_submix_strt");
      level notify("drop_pod_moving_up");
      var_06 = 1;
    } else if(level.drop_pod_charge <= 0 && var_06) {
      var_09 = 0;
      if(isDefined(level.drop_pod_up_start_time)) {
        var_09 = gettime() - level.drop_pod_up_start_time * 0.001;
      }

      if(var_09 < 0) {
        var_09 = 0;
      }

      foreach(var_02 in var_00) {
        var_02.var_A045 = undefined;
      }

      maps\mp\_utility::func_2CED(var_09, ::quest_drop_pod_impact_ground);
      thread quest_drop_pod_move_down_rumble();
      var_04 lib_0378::func_8D74("droppod_winch_down");
      level notify("drop_pod_moving_down");
      level notify("stop_move_up_rumble");
      var_06 = 0;
      common_scripts\utility::func_3C7B("flag_drop_pod_can_be_charged");
      common_scripts\utility::func_3C9F("flag_drop_pod_can_be_charged");
    }

    wait 0.05;
  }
}

quest_drop_pod_move_up_rumble() {
  level endon("stop_move_up_rumble");
  var_00 = 1;
  for(;;) {
    wait(var_00);
    maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.1, var_00, 1000);
  }
}

quest_drop_pod_move_down_rumble() {
  level endon("stop_move_down_rumble");
  var_00 = 1;
  for(;;) {
    wait(var_00);
    maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.2, var_00, 10000);
  }
}

quest_drop_pod_impact_ground() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("clip_drop_pod_closed", "script_noteworthy");
  var_01 method_805C();
  var_01 notsolid();
  lib_0378::func_8D74("inside_droppod_submix_stp");
  level notify("stop_move_down_rumble");
  maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.35, 0.5, 100000);
  common_scripts\utility::func_3C8F("flag_drop_pod_can_be_charged");
  var_00 lib_0378::func_8D74("droppod_ground_impact");
}

quest_drop_pod_charge_init() {
  level endon(lib_0557::func_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_00 = getent("trig_dmg_drop_pod_winch", "script_noteworthy");
  var_00 method_80B0(var_00 method_85A0() | 256);
  var_00 setdamagecallbackon(1);
  var_00.var_29B5 = ::quest_drop_pod_charge_damage_callback;
}

quest_drop_pod_charge_damage_callback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self notify("damage" + param_01.var_20D8);
  self endon("damage" + param_01.var_20D8);
  if(isDefined(param_05) && param_05 == "wunderbuss_zm") {
    self.hitby[param_01.var_20D8] = 1;
  }

  var_0C = quest_drop_pod_charge_check_for_all_players();
  if(var_0C) {
    level.drop_pod_charge = level.drop_pod_charge + 1;
  }

  wait(0.5);
  self.hitby[param_01.var_20D8] = 0;
}

quest_drop_pod_charge_check_for_all_players() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(isDefined(self.hitby[var_02.var_20D8])) {
      if(self.hitby[var_02.var_20D8] == 1) {
        var_00 = var_00 + 1;
      }
    }
  }

  if(var_00 == level.var_744A.size) {
    return 1;
  }

  return 0;
}

quest_drop_pod_charge_drain() {
  level endon(lib_0557::func_7838("quest_bring_down_airship", "step_raise_dropcage"));
  var_00 = 100;
  var_01 = 0.1;
  var_02 = 1 / var_01;
  for(;;) {
    var_03 = level.var_744A.size;
    if(level.drop_pod_charge > 0) {
      wait(1);
      switch (var_03) {
        case 1:
          var_04 = var_00 * var_03 / var_02 - var_03;
          level.drop_pod_charge = level.drop_pod_charge - var_04;
          break;

        case 2:
          var_04 = var_00 * var_03 / var_02 - var_03 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_04;
          break;

        case 3:
          var_04 = var_00 * var_03 / var_02 - var_03 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_04;
          break;

        case 4:
          var_04 = var_00 * var_03 / var_02 - var_03 * 2;
          level.drop_pod_charge = level.drop_pod_charge - var_04;
          break;
      }
    }

    if(level.drop_pod_charge < 0) {
      level.drop_pod_charge = 0;
    }

    wait 0.05;
  }
}

quest_drop_pod_teleport_to_airship() {
  level endon(lib_0557::func_7838("quest_bring_down_airship", "step_raise_dropcage"));
  level waittill("drop_pod_reached_airship");
  common_scripts\utility::func_3C8F("flag_drop_pod_reached_airship");
  var_00 = getent("clip_door", "script_noteworthy");
  var_00 delete();
  thread airship_audiolog_init();
  var_01 = getent("org_tp_plaza", "script_noteworthy");
  var_02 = getent("org_tp_airship", "script_noteworthy");
  foreach(var_04 in level.var_744A) {
    var_04 lib_0378::func_8D74("droppod_lock_in");
    var_04.relative_position = var_04.var_116 - var_01.var_116;
    var_04 setorigin(var_02.var_116 + var_04.relative_position);
  }

  lib_0547::playerspawneroverrideset("airship");
  var_06 = lib_0547::func_408F();
  foreach(var_08 in var_06) {
    var_08 suicide();
  }

  thread quest_drop_pod_teleport_to_airship_turn_off_light();
  level notify("stop_move_down_rumble");
  level notify("stop_move_up_rumble");
  quest_drop_pod_entered_airship();
}

quest_drop_pod_teleport_to_airship_turn_off_light() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("model_airship_drop_pod", "script_noteworthy");
  var_00.lightfx method_805C();
  var_01.airpodlightfx method_805B();
  lib_0378::func_8D74("inside_droppod_submix_stp");
}

quest_drop_pod_entered_airship() {
  level notify("entered_airship_sizzler_pause");
  wait(1);
  thread maps\mp\mp_zombie_berlin_utils::airship_pods_animation();
  level.var_953D = spawn("script_model", (0, 0, 0));
  foreach(var_01 in level.var_744A) {
    var_01 playersetgroundreferenceent(level.var_953D);
  }

  foreach(var_01 in level.var_744A) {
    var_01 thread maps\mp\mp_zombie_berlin_utils::airship_camera_sway();
  }

  lib_054D::giveplayersexp("berlin_exp_ref_19");
  lib_0557::func_782D("quest_bring_down_airship", "step_raise_dropcage");
}

quest_drop_pod_unresolved_collision_func(param_00) {}

airship_master_logic() {
  common_scripts\utility::func_3C87("flag_airship_summoned");
  common_scripts\utility::func_3C87("flag_airship_reached_middle");
  common_scripts\utility::func_3C87("flag_airship_fully_lowered");
  common_scripts\utility::func_3C87("flag_airship_doors_opened");
  common_scripts\utility::func_3C87("level_to_airship");
  level.airship = getEntArray("berlin_airship_map", "targetname");
  level.airship_active = 0;
  level.airship_doors_open = 0;
  level.airship_route_blockers = getEntArray("airship_route_blockers", "targetname");
  foreach(var_01 in level.airship) {
    var_01 maps\mp\mp_zombie_berlin_utils::airship_objects_hide();
  }

  maps\mp\mp_zombie_berlin_utils::hack_station_hide_all();
  thread maps\mp\mp_zombie_berlin_utils::airship_puzzle_doors_disable_buy();
  level thread maps\mp\mp_zombie_berlin_utils::airship_animation_master_handler();
  level.straub_airship = getent("straub_airship_exterior_model", "script_noteworthy");
  level.straub_airship.canmakesizzlers = 0;
  var_03 = common_scripts\utility::func_46B5("zeppelin_sizzler_cannon", "targetname");
  level.straub_airship.siz_cannon = var_03 maps\mp\mp_zombie_berlin_utils::airship_turret_build("turretweapon_zeppelin_siz_zm", var_03.var_165, ::maps\mp\mp_zombie_berlin_utils::airship_turret_modify_player_damage, ::maps\mp\mp_zombie_berlin_utils::airship_turret_on_player_damage, ::maps\mp\mp_zombie_berlin_utils::airship_turret_modify_agent_damage, ::maps\mp\mp_zombie_berlin_utils::airship_turret_on_agent_damage);
  level.straub_airship.siz_cannon method_8449(level.straub_airship);
  level.straub_airship thread maps\mp\mp_zombie_berlin_utils::airship_turret_think();
  common_scripts\utility::func_3C9F("flag_airship_summoned");
  level thread maps\mp\mp_zombie_berlin_utils::airship_straub_summon();
  common_scripts\utility::func_3C9F("flag_airship_reached_middle");
  level thread maps\mp\mp_zombie_berlin_utils::airship_lowering_handler();
  thread maps\mp\mp_zombie_berlin_lighting::set_anchor_pulse_lights_on();
  common_scripts\utility::func_3C9F("flag_airship_fully_lowered");
  level thread maps\mp\mp_zombie_berlin_utils::airship_interior_state_swap();
  common_scripts\utility::func_3C9F("flag_airship_doors_opened");
  common_scripts\utility::func_3C8F("level_to_airship");
  level thread maps\mp\mp_zombie_berlin_utils::airship_route_blockers_state_swap();
}

warp_lower_drop_pod() {
  common_scripts\utility::func_3C8F("flag_airship_anchor_a_reeled");
  common_scripts\utility::func_3C8F("flag_airship_anchor_b_reeled");
  common_scripts\utility::func_3C8F("flag_airship_anchor_c_reeled");
  common_scripts\utility::func_3C8F("flag_airship_anchor_d_reeled");
}

debug_show_tp_org() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("debug_drop_pod_tp", "script_noteworthy");
  var_01 method_8449(var_00);
  var_01 notsolid();
  var_01 method_805C();
}

debug_drop_pod_position() {
  level endon("drop_pod_reached_airship");
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("org_tp_plaza", "script_noteworthy");
  foreach(var_03 in level.var_744A) {
    for(;;) {
      var_03.relative_position = var_03.var_116 - var_01.var_116;
      iprintlnbold(var_03.relative_position);
      wait(0.5);
    }
  }
}

debug_drop_pod_position_airship() {
  level waittill("drop_pod_reached_airship");
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("org_tp_airship", "script_noteworthy");
  foreach(var_03 in level.var_744A) {
    for(;;) {
      var_03.relative_position = var_03.var_116 - var_01.var_116;
      iprintlnbold(var_03.relative_position);
      wait(0.5);
    }
  }
}

debug_lower_drop_pod_incremental_listen() {
  if(!isDefined(level.airship_anchor_flag_array)) {
    level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];
  }

  level waittill("debug_lower_drop_pod");
  common_scripts\utility::func_3C8F(level.airship_anchor_flag_array[0]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::func_3C8F(level.airship_anchor_flag_array[1]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::func_3C8F(level.airship_anchor_flag_array[2]);
  level waittill("debug_lower_drop_pod");
  common_scripts\utility::func_3C8F(level.airship_anchor_flag_array[3]);
}

debug_cheat_lower_drop_pod() {}

__________________build_wunderbuss__________________() {}

quest_wunderbuss_init() {
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_battery_placed");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_geistbolt_collected");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_geistbolt_placed");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_holding_battery");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_wunderbuss_built");
  common_scripts\utility::func_3C87("flag_quest_wunderbuss_escape_smugglers_den");
  level.smuggler_den_doors_open = 0;
  thread quest_wunderbuss_init_bench();
  var_00 = common_scripts\utility::func_46B5("weapon_assembly_bench", "targetname");
  var_00 thread quest_wunderbuss_build_weapon();
  quest_wunderbuss_logic();
}

quest_wunderbuss_logic() {
  thread quest_wunderbuss_collect_battery();
  thread quest_wunderbuss_collect_bolt();
  thread quest_wunderbuss_access_smuggler_den();
  common_scripts\utility::func_3C9F("flag_quest_wunderbuss_wunderbuss_built");
  thread quest_wunderbuss_escape_smuggler_den();
}

quest_wunderbuss_collect_battery() {
  var_00 = getEntArray("wunderbuss_part_battery", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  var_04 = randomintrange(0, var_00.size);
  var_05 = var_00[var_04];
  var_05 method_805B();
  var_06 = undefined;
  var_07 = undefined;
  var_08 = common_scripts\utility::func_44BE(var_05.var_1A2, "targetname");
  foreach(var_0A in var_08) {
    switch (var_0A.var_165) {
      case "wunderbuss_trig_battery":
        var_06 = getent(var_0A.var_1A5, "targetname");
        break;

      case "wunderbuss_battery_vfx_org":
        var_0B = common_scripts\utility::func_46B5(var_0A.var_1A5, "targetname");
        var_07 = spawn("script_model", var_0B.var_116);
        var_07 setModel("tag_origin");
        playFXOnTag(level.var_611["red_dot_light"], var_07, "tag_origin");
        break;
    }
  }

  var_06 waittill("trigger");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_holding_battery");
  lib_0378::func_8D74("wonderbuss_build_collect_battery", var_06.var_116);
  foreach(var_02 in var_00) {
    var_02 delete();
  }

  killfxontag(level.var_611["red_dot_light"], var_07, "tag_origin");
}

quest_wunderbuss_collect_bolt() {
  lib_0547::func_7BA9(::maps\mp\mp_zombie_berlin_utils::spine_zombie_collect_listener);
  common_scripts\utility::func_3C9F("flag_quest_wunderbuss_geistbolt_collected");
  lib_0547::func_2D8C(::maps\mp\mp_zombie_berlin_utils::spine_zombie_collect_listener);
}

quest_wunderbuss_access_smuggler_den() {
  level endon("flag_quest_wunderbuss_wunderbuss_built");
  var_00 = getent("wunderbuss_trig_smuggler_door", "script_noteworthy");
  var_01 = getent("wunderbuss_smuggler_door_battery", "script_noteworthy");
  var_01 method_805C();
  var_02 = getEntArray("smuggler_den_door_main_body", "script_noteworthy");
  var_03 = getEntArray("smuggler_den_door_bot", "targetname");
  var_04 = getEntArray("smuggler_den_door_top", "targetname");
  foreach(var_06 in var_03) {
    var_06 movez(128, 0.1);
  }

  foreach(var_06 in var_04) {
    var_06 movez(128, 0.1);
  }

  common_scripts\utility::func_3C9F("flag_quest_wunderbuss_battery_collected");
  lib_054D::giveplayersexp("berlin_exp_ref_9");
  for(;;) {
    var_00 waittill("trigger");
    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_holding_battery")) {
      lib_0378::func_8D74("wonderbuss_build_battery_door_unlock", var_01.var_116);
      var_01 method_805B();
      common_scripts\utility::func_3C7B("flag_quest_wunderbuss_holding_battery");
      level thread common_scripts\_exploder::func_2A6D(219, undefined, 0);
      level thread common_scripts\_exploder::func_88E(220);
      if(!level.smuggler_den_doors_open) {
        quest_wunderbuss_open_close_doors();
      }
    } else if(!common_scripts\utility::func_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed")) {
      lib_0378::func_8D74("wonderbuss_build_battery_door_lock", var_01.var_116);
      var_01 method_805C();
      common_scripts\utility::func_3C8F("flag_quest_wunderbuss_holding_battery");
      level thread common_scripts\_exploder::func_2A6D(220, undefined, 0);
      level thread common_scripts\_exploder::func_88E(219);
      if(level.smuggler_den_doors_open) {
        quest_wunderbuss_open_close_doors();
        thread quest_wunderbuss_escape_smuggler_den_reset_check();
      }
    }

    wait(1);
  }
}

quest_wunderbuss_build_weapon() {
  self.assembly_trig thread quest_wunderbuss_hint_strings();
  self.assembly_trig thread quest_wunderbuss_build_part(self.assembly_model_battery, "flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_battery_placed");
  self.assembly_trig thread quest_wunderbuss_build_part(self.assembly_model_bolt, "flag_quest_wunderbuss_geistbolt_collected", "flag_quest_wunderbuss_geistbolt_placed");
  while(!common_scripts\utility::func_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed") && common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      common_scripts\utility::func_3C8F("flag_quest_wunderbuss_wunderbuss_built");
      continue;
    }

    wait 0.05;
  }

  var_00 = getent("wunderbuss_weapon_complete", "script_noteworthy");
  var_00 method_805B();
  thread quest_wunderbuss_give_wunderbuss();
  lib_0557::func_782D("quest_the_wunderbuss", "step_assemble_weapon");
}

quest_wunderbuss_hint_strings() {
  level thread give_exp_on_bolt_found();
  common_scripts\utility::func_3CA2("flag_quest_wunderbuss_battery_collected", "flag_quest_wunderbuss_geistbolt_collected");
  while(!common_scripts\utility::func_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_collected") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      self sethintstring(&"ZOMBIE_BERLIN_PART_PLACE");
    }

    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_collected") && common_scripts\utility::func_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed")) {
      self sethintstring(&"ZOMBIE_BERLIN_PART_PLACE");
    }

    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_placed") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_collected")) {
      self sethintstring(&"ZOMBIE_BERLIN_PART_REMOVE");
    }

    if(!common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_collected") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_holding_battery") && !common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed")) {
      self sethintstring(" ");
    }

    common_scripts\utility::func_3CA2("flag_quest_wunderbuss_geistbolt_placed", "flag_quest_wunderbuss_battery_placed", "flag_quest_wunderbuss_holding_battery", "flag_quest_wunderbuss_geistbolt_collected");
    wait 0.05;
  }

  self sethintstring(&"ZOMBIE_BERLIN_WEAPON_PICKUP");
}

give_exp_on_bolt_found() {
  common_scripts\utility::func_3C9F("flag_quest_wunderbuss_geistbolt_collected");
  lib_054D::giveplayersexp("berlin_exp_ref_12");
}

quest_wunderbuss_build_part(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B5("weapon_assembly_bench", "targetname");
  var_04 = common_scripts\utility::func_44BE(var_03.var_1A2, "targetname");
  common_scripts\utility::func_3C9F(param_01);
  for(;;) {
    self waittill("trigger");
    if(param_01 == "flag_quest_wunderbuss_battery_collected") {
      if(common_scripts\utility::func_3C77(param_02)) {
        common_scripts\utility::func_3C8F("flag_quest_wunderbuss_holding_battery");
        common_scripts\utility::func_3C7B(param_02);
        foreach(var_06 in var_04) {
          if(var_06.var_165 != "wunderbuss_weapon_base") {
            var_06 method_805C();
            continue;
          }

          if(var_06.var_165 == "wunderbuss_weapon_base") {
            var_06 method_805B();
          }
        }

        self sethintstring(" ");
      } else if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_holding_battery")) {
        foreach(var_06 in var_04) {
          var_06 method_805C();
        }

        param_00 method_805B();
        level thread common_scripts\_exploder::func_88E(207);
        lib_0378::func_8D74("wonderbuss_weapon_build_infusion", param_00.var_116);
        self sethintstring(" ");
        common_scripts\utility::func_3C7B("flag_quest_wunderbuss_holding_battery");
        common_scripts\utility::func_3C8F(param_02);
      }
    } else if(!common_scripts\utility::func_3C77("flag_quest_wunderbuss_geistbolt_placed")) {
      foreach(var_06 in var_04) {
        var_06 method_805C();
      }

      param_00 method_805B();
      level thread common_scripts\_exploder::func_88E(208);
      lib_0378::func_8D74("wonderbuss_weapon_build_infusion", param_00.var_116);
      self sethintstring(" ");
      common_scripts\utility::func_3C8F(param_02);
    }

    if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
      level thread common_scripts\_exploder::func_88E(224);
      foreach(var_06 in var_04) {
        var_06 method_805C();
      }

      var_03 = common_scripts\utility::func_46B5("weapon_assembly_bench", "targetname");
      var_03.assembly_model_complete method_805B();
      level thread common_scripts\_exploder::func_88E(223);
      lib_0378::func_8D74("wonderbuss_weapon_build_infusion", param_00.var_116);
      self sethintstring(&"ZOMBIE_BERLIN_WEAPON_PICKUP");
      break;
    }

    wait 0.05;
  }
}

quest_wunderbuss_give_wunderbuss() {
  for(;;) {
    self.assembly_trig waittill("trigger", var_00);
    var_01 = 0;
    var_02 = var_00 getweaponslistprimaries();
    foreach(var_04 in var_02) {
      if(var_04 == "wunderbuss_zm") {
        var_01 = 1;
      }
    }

    if(!var_01) {
      maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00, "wunderbuss_zm");
      var_00 lib_0586::func_78E("wunderbuss_zm");
      maps\mp\mp_zombie_berlin_utils::try_give_exp_to_players_for_weap("wunderbuss_zm");
      maps\mp\mp_zombie_berlin_utils::flag_try_set(maps\mp\mp_zombie_berlin_utils::get_special_melee_weapon_flag_name("wunderbuss_zm"));
      var_00 thread maps\mp\mp_zombie_berlin_utils::wunderbuss_ammo_tracker();
      var_00 thread maps\mp\mp_zombie_berlin_utils::wunderbuss_drop_watcher();
    }

    if(isDefined(var_00.wunderbuss_prev_ammo)) {
      wait 0.05;
      var_00 method_82FA("wunderbuss_zm", var_00.wunderbuss_prev_ammo);
    }
  }
}

quest_wunderbuss_init_bench() {
  var_00 = common_scripts\utility::func_46B5("weapon_assembly_bench", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    switch (var_03.var_165) {
      case "trig_workbench":
        var_00.assembly_trig = var_03;
        break;

      case "wunderbuss_weapon_base":
        var_00.assembly_model_base = var_03;
        var_00.assembly_model_base method_805C();
        break;

      case "wunderbuss_weapon_battery":
        var_00.assembly_model_battery = var_03;
        var_00.assembly_model_battery method_805C();
        break;

      case "wunderbuss_weapon_bolt":
        var_00.assembly_model_bolt = var_03;
        var_00.assembly_model_bolt method_805C();
        break;

      case "wunderbuss_weapon_complete":
        var_00.assembly_model_complete = var_03;
        var_00.assembly_model_complete method_805C();
        break;
    }
  }

  var_05 = getent("wunderbuss_weapon_base", "script_noteworthy");
  var_05 method_805B();
  wait(2);
  level thread common_scripts\_exploder::func_88E(219);
}

quest_wunderbuss_escape_smuggler_den() {
  level endon("flag_quest_wunderbuss_escape_smugglers_den");
  var_00 = getent("wunderbuss_trig_dmg_smuggler_door", "script_noteworthy");
  var_00 method_80B0(var_00 method_85A0() | 256);
  var_01 = 0;
  var_02 = 10;
  while(var_01 < var_02) {
    var_00 waittill("damage", var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C);
    if(var_0C == "wunderbuss_zm") {
      var_01++;
    }

    wait 0.05;
  }

  if(!level.smuggler_den_doors_open) {
    level thread quest_wunderbuss_open_close_doors();
  }

  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_escape_smugglers_den");
}

quest_wunderbuss_escape_smuggler_den_reset_check() {
  level endon("flag_quest_wunderbuss_escape_smugglers_den");
  var_00 = getent("zone_smuggler_den", "script_noteworthy");
  var_01 = [];
  for(;;) {
    foreach(var_03 in level.var_744A) {
      if(var_03 istouching(var_00)) {
        var_01 = common_scripts\utility::func_F6F(var_01, var_03);
        continue;
      }

      var_01 = common_scripts\utility::func_F93(var_01, var_03);
    }

    var_01 = common_scripts\utility::func_F97(var_01);
    if(var_01.size <= 0 && !level.smuggler_den_doors_open) {
      if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_battery_placed")) {
        quest_wunderbuss_open_close_doors();
      }

      break;
    }

    wait 0.05;
  }

  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_escape_smugglers_den");
}

quest_wunderbuss_open_close_doors() {
  var_00 = getEntArray("smuggler_den_door_bot", "targetname");
  var_01 = getEntArray("smuggler_den_door_top", "targetname");
  var_02 = getEntArray("smuggler_den_door_main_body", "script_noteworthy");
  switch (level.smuggler_den_doors_open) {
    case 1:
      level.smuggler_den_doors_open = 0;
      foreach(var_04 in var_00) {
        var_04 movez(-80, 1, 0.25, 0.25);
      }

      foreach(var_04 in var_01) {
        var_04 movez(-40, 1, 0.25, 0.25);
      }

      foreach(var_09 in var_02) {
        var_09 solid();
        var_09 method_805F();
      }
      break;

    case 0:
      level.smuggler_den_doors_open = 1;
      foreach(var_04 in var_00) {
        var_04 movez(80, 1, 0.25, 0.25);
      }

      wait(0.5);
      foreach(var_04 in var_01) {
        var_04 movez(40, 1, 0.25, 0.25);
      }

      foreach(var_09 in var_02) {
        var_09 notsolid();
        var_09 method_8060();
      }
      break;

    default:
      break;
  }
}

warp_give_wonderweapon_parts() {
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_holding_battery");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_geistbolt_collected");
}

warp_wonderweapon_built() {
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_battery_placed");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_geistbolt_placed");
}

debug_cheat_give_wonderweapon() {}

debug_cheat_give_battery() {}

debug_cheat_give_bolt() {}

debug_give_battery() {
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_battery_collected");
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_holding_battery");
}

debug_give_bolt() {
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_geistbolt_collected");
}

__________________defeat_straub__________________() {}

quest_init_defeat_straub() {
  common_scripts\utility::func_3C87("flag_open_cargobay_complete");
  common_scripts\utility::func_3C87("flag_open_cargobay_left_complete");
  common_scripts\utility::func_3C87("flag_open_cargobay_left_back_complete");
  common_scripts\utility::func_3C87("flag_open_cargobay_right_complete");
  common_scripts\utility::func_3C87("flag_open_cargobay_right_back_complete");
  common_scripts\utility::func_3C87("flag_override_electroschnell_complete");
}

quest_step_find_way_through_cargo_bay() {
  maps\mp\mp_zombie_berlin_utils::hack_station_init();
  wait(3);
  wait(3);
  common_scripts\utility::func_3C9F("flag_open_cargobay_complete");
  thread maps\mp\mp_zombie_berlin_utils::vo_player_enter_airship();
  thread quest_step_find_way_through_cargo_bay_complete();
  level thread common_scripts\_exploder::func_88E(216);
  lib_0557::func_782D("quest_defeat_straub", "step_find_straub");
}

quest_step_find_way_through_cargo_bay_complete() {
  wait(2);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_overload");
  wait(3);
}

quest_step_overload_straubs_electroschnell() {
  var_00 = getent("straub_airship_idle_anim_org", "targetname");
  level.airship_straub_zombies = [];
  level.airship_straub = spawn("script_model", var_00.var_116);
  level.airship_straub setModel("zom_straub_wholebody_dlc");
  level.airship_straub method_8495("s2_zom_straub_death_straub_idle", var_00.var_116, var_00.var_1D);
  level.airship_straub.color = spawn("script_model", var_00.var_116);
  level.airship_straub.color setModel("zom_head_kier_dirt_org1_dlc");
  level.airship_straub.color linkto(level.airship_straub, "j_spineupper", (0, 0, 0), (0, 0, 0));
  if(common_scripts\utility::func_3C77("flag_hat_stack_ee_complete")) {
    level.airship_straub.funny_hat = spawn("script_model", var_00.var_116);
    level.airship_straub.funny_hat setModel("zom_m40officercap_org1");
    level.airship_straub.funny_hat linkto(level.airship_straub, "j_spineupper", (26, 6, 10.5), (-20, 0, 25));
  }

  level.airship_straub.color method_8495("s2_zom_straub_death_straub_idle", var_00.var_116, var_00.var_1D);
  for(var_01 = 0; var_01 < 8; var_01++) {
    level.airship_straub_zombies[var_01] = spawn("script_model", var_00.var_116);
    level.airship_straub_zombies[var_01] setModel("zom_infantrya_bodywhole");
    level.airship_straub_zombies[var_01].animation_name = "s2_zom_straub_death_zom_0" + common_scripts\utility::func_9AAD(var_01 + 1);
    level.airship_straub_zombies[var_01].idle_anim_name = "s2_zom_straub_death_end_zom_0" + common_scripts\utility::func_9AAD(var_01 + 1);
    level.airship_straub_zombies[var_01].color = spawn("script_model", var_00.var_116);
    level.airship_straub_zombies[var_01].color setModel(common_scripts\utility::func_7A33(["zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1"]));
    level.airship_straub_zombies[var_01].color linkto(level.airship_straub_zombies[var_01], "j_spineupper", (0, 0, 0), (0, 0, 0));
    level.airship_straub_zombies[var_01] method_8495(level.airship_straub_zombies[var_01].animation_name, var_00.var_116, var_00.var_1D);
    level.airship_straub_zombies[var_01].color method_8495(level.airship_straub_zombies[var_01].animation_name, var_00.var_116, var_00.var_1D);
    level.airship_straub_zombies[var_01] common_scripts\utility::func_2CBE(0.05, ::scriptmodelpauseanim, 1);
    level.airship_straub_zombies[var_01].color common_scripts\utility::func_2CBE(0.05, ::scriptmodelpauseanim, 1);
  }

  common_scripts\utility::func_3C9F("flag_override_electroschnell_complete");
  thread quest_step_overload_straubs_electroschnell_complete();
}

quest_step_overload_straubs_electroschnell_complete() {
  common_scripts\utility::func_3C8F("flag_straub_death_scene");
  wait(5);
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(var_02.var_A == level.var_746E) {
      continue;
    }

    var_02 suicide();
  }

  thread maps\mp\mp_zombie_berlin_utils::vo_straub_death();
  var_04 = getent("straub_airship_idle_anim_org", "targetname");
  level.airship_straub method_8495("s2_zom_straub_death_straub", var_04.var_116, var_04.var_1D);
  level.airship_straub.color method_8495("s2_zom_straub_death_straub", var_04.var_116, var_04.var_1D);
  level thread quest_step_overload_straubs_electroschnell_straub_grit_blood();
  level thread quest_step_overload_straubs_electroschnell_lights();
  level thread quest_step_overload_straubs_electroschnell_complete_fx();
  for(var_05 = 0; var_05 < level.airship_straub_zombies.size; var_05++) {
    level.airship_straub_zombies[var_05] scriptmodelclearanim();
    level.airship_straub_zombies[var_05] method_8495(level.airship_straub_zombies[var_05].animation_name, var_04.var_116, var_04.var_1D);
    level.airship_straub_zombies[var_05].color method_8495(level.airship_straub_zombies[var_05].animation_name, var_04.var_116, var_04.var_1D);
  }

  lib_054D::giveplayersexp("berlin_exp_ref_18");
  wait(getanimlength(%s2_zom_straub_death_straub));
  if(isDefined(level.airship_straub)) {
    level.airship_straub method_8495("s2_zom_straub_death_end_straub", var_04.var_116, var_04.var_1D);
    level.airship_straub.color method_8495("s2_zom_straub_death_end_straub", var_04.var_116, var_04.var_1D);
    for(var_05 = 0; var_05 < level.airship_straub_zombies.size; var_05++) {
      level.airship_straub_zombies[var_05] scriptmodelclearanim();
      level.airship_straub_zombies[var_05] method_8495(level.airship_straub_zombies[var_05].idle_anim_name, var_04.var_116, var_04.var_1D);
      level.airship_straub_zombies[var_05].color method_8495(level.airship_straub_zombies[var_05].idle_anim_name, var_04.var_116, var_04.var_1D);
    }
  }

  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  wait(3);
  level notify("airship_escape");
  thread maps\mp\mp_zombie_berlin_utils::airship_camera_sway_extreme();
  thread quest_step_straub_death_powernodes_turn_on_fx();
  lib_0557::func_782D("quest_defeat_straub", "step_override_electroschnell");
  common_scripts\utility::func_3C7B("flag_straub_death_scene");
}

quest_step_overload_straubs_electroschnell_complete_fx() {
  wait(16);
  level thread common_scripts\_exploder::func_88E(215);
  wait(1.75);
  level thread common_scripts\_exploder::func_88E(213);
}

quest_step_straub_death_powernodes_turn_on_fx() {
  wait(1);
  level thread common_scripts\_exploder::func_88E(214);
}

quest_step_overload_straubs_electroschnell_lights() {
  wait(3);
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_start_lights();
  wait(2);
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_kill_lights();
  thread maps\mp\mp_zombie_berlin_lighting::straub_death_kill_fill_lights();
  thread maps\mp\mp_zombie_berlin_lighting::airship_alarm_lights();
}

quest_step_overload_straubs_electroschnell_straub_grit_blood() {
  wait(getanimlength(%s2_zom_straub_death_straub) * 0.65);
  playFXOnTag(level.var_611["zmb_dlc2_straub_death_grit"], level.airship_straub, "j_spineupper");
  wait(5.5);
  var_00 = getEntArray("ariship_straub_blast_door", "targetname");
  foreach(var_02 in var_00) {
    wait(randomfloatrange(0.05, 0.15));
    var_02 moveto(var_02.var_116 + (0, 0, 56), 0.5, 0, 0.1);
  }

  wait(0.5);
  thread quest_step_overload_straubs_electroschnell_cleanup();
}

quest_step_overload_straubs_electroschnell_cleanup() {
  level.airship_straub.color delete();
  level.airship_straub delete();
  foreach(var_01 in level.airship_straub_zombies) {
    var_01.color delete();
    var_01 delete();
  }
}

escape_airship_init() {
  var_00 = getent("clip_airship_drop_pod_closed", "script_noteworthy");
  var_00 notsolid();
  wait 0.05;
  var_00 method_8060();
}

escape_airship_logic() {
  level notify("escape_airship_start");
  if(!isDefined(level.alternate_boss_fight)) {
    thread escape_airship_rumble();
  }

  var_00 = getent("airship_lab_door_left", "targetname");
  var_00 moveto(var_00.var_116 + (0, 0, -80), 0.3);
  thread escape_airship_open_all_doors();
  thread escape_airship_drop_pod_wait_for_all_players();
}

escape_airship_rumble() {}

escape_airship_open_all_doors() {
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
      var_01 notify("open");
    }
  }
}

escape_airship_drop_pod_wait_for_all_players() {
  level endon("airship_escape_drop_pod_doors_complete");
  foreach(var_01 in level.var_744A) {
    var_01 thread escape_airship_player_in_drop_pod_check();
  }

  for(;;) {
    var_03 = 0;
    foreach(var_01 in level.var_744A) {
      if(var_01.inside_airship_drop_pod) {
        var_03 = var_03 + 1;
      }
    }

    if(isDefined(var_03) && var_03 >= level.var_744A.size) {
      break;
    }

    wait 0.05;
  }

  var_06 = getEntArray("airship_drop_pod_body", "targetname");
  foreach(var_08 in var_06) {
    var_08.var_A045 = ::airship_drop_pod_unresolved_collision_func;
  }

  var_0A = getent("model_airship_drop_pod", "script_noteworthy");
  var_0B = getanimlength(%s2_zmb_drop_pod_close_front_quick);
  var_0A scriptmodelplayanim("s2_zmb_drop_pod_close_front_quick", "airship_drop_pod_close_doors");
  lib_0378::func_8D74("inside_droppod_submix_strt");
  var_0C = getent("clip_airship_drop_pod_closed", "script_noteworthy");
  var_0C solid();
  wait(var_0B);
  escape_airship_drop_pod_move();
}

escape_airship_player_in_drop_pod_check() {
  level endon("airship_drop_pod_close_doors");
  var_00 = getent("vol_airship_drop_pod_area", "script_noteworthy");
  for(;;) {
    if(self istouching(var_00)) {
      self.inside_airship_drop_pod = 1;
    } else {
      self.inside_airship_drop_pod = 0;
    }

    wait 0.05;
  }
}

escape_airship_drop_pod_move() {
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.3, 8, 1000);
  var_00 = getent("airship_interior_launch_door", "script_noteworthy");
  var_00 method_805C();
  var_01 = getent("model_airship_drop_pod", "script_noteworthy");
  var_01 lib_0378::func_8D74("droppod_escape_fire");
  var_02 = getEntArray("airship_drop_pod_body", "targetname");
  var_03 = getent("org_tp_airship", "script_noteworthy");
  foreach(var_05 in var_02) {
    var_05 method_8449(var_01);
  }

  var_03 method_8449(var_01);
  wait(0.25);
  var_01 movez(-360, 3);
  wait(3);
  escape_airship_teleport_to_surface();
}

escape_airship_teleport_to_surface() {
  var_00 = getent("org_tp_plaza", "script_noteworthy");
  var_01 = getent("org_tp_airship", "script_noteworthy");
  wait 0.05;
  thread escape_plaza_drop_pod_move();
  thread escape_plaza_drop_pod_move_light_off();
  wait 0.05;
  var_02 = getEntArray("pod_player_teleport_spot", "script_noteworthy");
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    var_05 setorigin(var_02[var_03].var_116);
    var_03++;
  }

  level notify("airship_escape_drop_pod_doors_complete");
  lib_0557::func_782D("quest_bob", "step_escape_airship");
}

airship_drop_pod_unresolved_collision_func(param_00) {
  var_01 = getent("org_tp_airship", "script_noteworthy");
  param_00 setorigin(var_01.var_116);
}

airship_drop_pod_teleport_unresolved_collision_func(param_00) {}

escape_plaza_drop_pod_move() {
  level notify("airship_drop_pod_moving_down");
  level waittill("airship_drop_pod_reached_ground");
  var_00 = getent("clip_drop_pod_closed", "script_noteworthy");
  var_00 notsolid();
  var_01 = common_scripts\utility::func_46B5("fx_org_escape_airship_drop_pod_crash", "script_noteworthy");
  playFX(level.var_611["landing_dust"], var_01.var_116);
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players(0.6, 1, 1000);
  lib_0547::markmapcompleteforleaderboards();
  level.var_400E[level.var_400E.size] = ["wicht_set 2 1", "all"];
  var_02 = lib_0547::func_408F();
  foreach(var_04 in var_02) {
    var_04 suicide();
  }

  level.zmb_locked_spawn_zones = undefined;
  lib_0547::playerspawneroverrideclear();
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  level common_scripts\utility::func_A74B("airship_drop_pod_reached_ground", 15);
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  run_outro_berlin();
}

escape_plaza_drop_pod_move_light_off() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_01 = getent("model_airship_drop_pod", "script_noteworthy");
  var_00.lightfx method_805B();
  var_01.airpodlightfx delete();
}

warp_show_airship_exterior() {
  common_scripts\utility::func_3C8F("flag_exit_underbelly");
  common_scripts\utility::func_3C8F("flag_airship_summoned");
  common_scripts\utility::func_3C8F("flag_airship_reached_middle");
  common_scripts\utility::func_3C8F("flag_airship_fully_lowered");
}

warp_show_airship_interior() {
  common_scripts\utility::func_3C8F("flag_exit_underbelly");
  common_scripts\utility::func_3C8F("flag_airship_summoned");
  common_scripts\utility::func_3C8F("flag_airship_reached_middle");
  common_scripts\utility::func_3C8F("flag_airship_fully_lowered");
  common_scripts\utility::func_3C8F("flag_airship_doors_opened");
  common_scripts\utility::func_3C8F("flag_drop_pod_reached_airship");
  lib_0547::playerspawneroverrideset("airship");
}

warp_activateenemytypes() {
  common_scripts\utility::func_3C8F("flag_sizzlers_active");
}

warp_setup_drop_pod_position() {
  var_00 = getent("drop_pod_model", "script_noteworthy");
  var_00 method_805B();
  var_00.lightfx method_805B();
  var_01 = getent("clip_drop_pod_closed", "script_noteworthy");
  var_02 = getent("clip_drop_pod", "script_noteworthy");
  var_01 solid();
  var_02 solid();
  quest_drop_pod_entered_airship();
}

warp_setup_straub_death_scene() {
  wait(1);
  var_00 = getent("airship_node_03_03", "targetname");
  var_00 notify("hack_interact");
  var_00 = getent("airship_node_01_02", "targetname");
  var_00 notify("hack_interact");
  var_00 = getent("airship_node_02_01", "targetname");
  var_00 notify("hack_interact");
  var_00 = getent("airship_node_05_02", "targetname");
  var_00 notify("hack_interact");
  var_00 = getent("airship_node_04_01", "targetname");
  var_00 notify("hack_interact");
  wait(5);
  var_01 = getent("airship_node_03_05", "targetname");
  var_01 notify("hack_interact");
}

__________________beast_of_berlin__________________() {}

quest_step_defeat_bob() {
  common_scripts\utility::func_3C8F("flag_sizzlers_active");
  thread boss_spawn();
}

boss_spawn() {
  var_00 = common_scripts\utility::func_46B5("spawner_zombie_bob_airship", "targetname");
  var_01 = getent("trigger_leaving_airship_boss", "script_noteworthy");
  var_02 = 0;
  while(var_02 == 0) {
    var_01 waittill("trigger", var_03);
    if(isPlayer(var_03)) {
      var_02 = 1;
    }

    wait 0.05;
  }

  var_04 = lib_054D::func_90BA("zombie_bob", var_00, "bob", 0, 1, 0);
  if(common_scripts\utility::func_3C77("flag_hat_stack_ee_complete")) {
    var_04.funny_hat = spawn("script_model", var_04.var_116);
    var_04.funny_hat setModel("zom_m40officercap_org1");
    var_04.funny_hat linkto(var_04, "J_Helmet", (4, 0, 0), (0, 0, 0));
  }

  level.bob = var_04;
  thread wait_time_earthquake(1.875493, var_04);
  var_04 lib_0547::func_84CB();
  bob_stun_zombies_nearby(var_04);
  level thread max_out_zombies_after_animation();
  level.var_1F4F["normal"] = ::dontdroppickups;
  maps\mp\_events_z::start_boss_battle_tracking();
  thread maps\mp\mp_zombie_berlin_utils::vo_say_hello_to_my_little_bob();
  for(;;) {
    if(isalive(var_04) == 0) {
      wait(1);
      break;
    }

    wait(0.1);
  }

  wait(1);
  thread escape_airship_rumble();
  maps\mp\_events_z::end_boss_battle_tracking();
  iprintlnbold("Get to the drop pod to escape!");
  lib_0557::func_782D("quest_bob", "step_defeat_bob");
  thread maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.maxed_zombies_sprint = 0;
  level.var_1F4F["normal"] = ::droppickups;
}

dontdroppickups(param_00) {
  return 0;
}

droppickups(param_00) {
  return 1;
}

max_out_zombies_after_animation() {
  wait(getanimlength(%s2_zom_bob_intro));
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  level.maxed_zombies_sprint = 1;
}

bob_stun_zombies_nearby(param_00) {
  wait(0.75);
  var_01 = param_00.var_116;
  var_02 = 200;
  var_03 = 1;
  var_04 = lib_0547::func_408F();
  var_05 = function_01AC(lib_0547::func_408F(), var_01, var_02);
  var_06 = 1;
  foreach(var_08 in var_05) {
    var_09 = spawnStruct();
    var_09.var_116 = var_01;
    var_09.var_1180 = param_00;
    var_09.durationsecs = 1;
    level thread bob_stun_zombie(var_08, var_09, var_03, var_06);
    var_06 = var_06 + 0.05;
  }
}

bob_stun_zombie(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  wait(param_03);
  var_04 = 0.125 * maps\mp\gametypes\zombies::func_1E59();
  var_05 = param_01.var_116;
  var_06 = param_01.var_1180;
  param_00 dodamage(var_04, var_05, var_06);
  if(common_scripts\utility::func_562E(param_00.var_57E8)) {
    return;
  }

  param_00 thread lib_0547::func_7D1A("mini_stunning_burst", [param_01], param_02);
}

wait_time_earthquake(param_00, param_01) {
  wait(param_00);
  thread maps\mp\mp_zombie_berlin_utils::earthquake_alive_players_with_origin(0.5, 0.5, 2000, param_01);
  wait(0.5);
  level thread common_scripts\_exploder::func_88E(217);
}

__________________pack_a_punch__________________() {}

quest_pap_init() {
  common_scripts\utility::func_3C87("pap_ww_blasted_1");
  common_scripts\utility::func_3C87("pap_ww_blasted_2");
  var_00 = getent("pap_machine_fake", "script_noteworthy");
  level thread quest_pap_handler(var_00);
}

wait_for_upgrade_machine_arrived(param_00, param_01) {
  param_01 hidefromclient(param_00);
  common_scripts\utility::func_3C9F("pap_ww_blasted_1");
}

quest_pap_handler(param_00) {
  var_01 = getent("trigger_dmg_elevator_shaft", "script_noteworthy");
  var_02 = getent("trigger_dmg_elevator_bottom_doors", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("struct_fx_panel_1", "script_noteworthy");
  var_04 = common_scripts\utility::func_46B5("struct_fx_panel_2", "script_noteworthy");
  var_05 = getent("pap_electric_box_door_1", "script_noteworthy");
  var_06 = getent("pap_electric_box_door_2", "script_noteworthy");
  var_01 thread trigger_electric_box_hit(var_03, var_05);
  var_02 thread trigger_electric_box_hit(var_04, var_06);
  var_07 = getent("script_pap_elevator_mover", "script_noteworthy");
  var_08 = getent("script_pap_elevator_geo", "script_noteworthy");
  level waittill("pap_electric_box_complete");
  playFX(level.var_611["elevator_crash"], param_00.var_116);
  wait(0.5);
  var_08 method_8449(var_07);
  param_00 method_8449(var_07);
  var_07 movez(-100, 0.5, 0.25, 0.1);
  var_07 lib_0378::func_8D74("aud_pap_move_elevator");
  wait(0.7);
  param_00 delete();
  common_scripts\utility::func_3C8F("pap_ww_blasted_1");
  level waittill("pap_electric_box_complete");
  common_scripts\utility::func_3C8F("pap_ww_blasted_2");
  var_09 = common_scripts\utility::func_46B5("zmb_pack_a_punch_scripted_node", "targetname");
  var_0A = getent("pap_elevator_doors", "script_noteworthy");
  var_0B = getent("pap_elevator_clip", "script_noteworthy");
  lib_054D::giveplayersexp("berlin_exp_ref_3");
  open_elevator_doors(var_09, var_0A, var_0B);
  maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_2();
}

open_elevator_doors(param_00, param_01, param_02) {
  param_01 method_8495("zmb_elevator_door_open_02", param_00.var_116, param_00.var_1D, "script_anim");
  param_01 lib_0378::func_8D74("aud_pap_open_elevator");
  param_02 method_8060();
  wait 0.05;
  param_02 delete();
}

trigger_electric_box_hit(param_00, param_01) {
  self method_80B0(self method_85A0() | 256);
  var_02 = 10;
  var_03 = 0;
  var_04 = 0;
  while(var_04 == 0) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    if(isDefined(var_09) && var_09 == "MOD_EXPLOSIVE" || var_09 == "MOD_GRENADE_SPLASH" || var_09 == "MOD_GRENADE") {
      var_04 = 1;
    }

    if(isDefined(var_0E) && var_0E == "fliegerfaust_zm") {
      var_04 = 1;
    }

    wait 0.05;
  }

  param_01 rotateyaw(-143, 0.6, 0.3, 0.1);
  while(var_02 > var_03) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    if(var_0E == "wunderbuss_zm") {
      self notify("pap_electric_box_hit");
      var_03++;
      playFX(level.var_611["zmb_elec_coil_charge_pap_puzzle"], param_00.var_116);
    }

    wait 0.05;
  }

  playFX(level.var_611["zmb_fog_wispy_cliff_electric_box"], param_00.var_116);
  level notify("pap_electric_box_complete");
  self delete();
}

__________________misc_jump_scares__________________() {}

js_sewer_board() {
  var_00 = 0;
  var_01 = getent("jumpscare_sewer_board_geo", "script_noteworthy");
  var_02 = getent("jumpscare_sewer_board_geo_after", "script_noteworthy");
  var_03 = getent("jumpscare_sewer_board_trigger", "script_noteworthy");
  var_04 = getent("jumpscare_sewer_board_clip", "script_noteworthy");
  var_02 method_805C();
  while(var_00 == 0) {
    var_03 waittill("trigger", var_05);
    if(isPlayer(var_05)) {
      wait(0.75);
      if(!var_05 istouching(var_03)) {
        continue;
      } else {
        var_00 = 1;
        var_04 delete();
        var_01 delete();
        var_02 method_805B();
        var_05 lib_0378::func_8D74("player_falls_into_sewer");
        wait(0.5);
        var_05 setstance("prone");
      }
    }

    wait 0.05;
  }
}

js_dancer() {
  var_00 = getent("dancer_js", "targetname");
  var_01 = getent("dancer_js_trig", "targetname");
  var_02 = common_scripts\utility::func_46B5("dancer_js_struct", "targetname");
  var_03 = getent("bonus_ee_audiolog_dancer_pickup_model", "targetname");
  while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
    wait 0.05;
  }

  var_00 method_8495("s2_zom_berlin_bed_scare_idle", var_00.var_116, var_00.var_1D, "dancer_js_idle");
  wait(1);
  var_04 = var_00 gettagorigin("TAG_WEAPON_RIGHT");
  var_05 = var_00 gettagangles("TAG_WEAPON_RIGHT");
  var_03 moveto(var_04, 0.1);
  var_03.var_1D = var_05;
  wait(0.5);
  var_03 method_8449(var_00, "TAG_WEAPON_RIGHT");
  thread maps\mp\_utility::func_6F74(::bonus_ee_audiolog_dancer_alternate_prop_swap);
  var_06 = 0;
  common_scripts\utility::func_3C9F("flag_audiolog_dancer_jumpscare_available");
  while(!var_06) {
    foreach(var_08 in level.var_744A) {
      var_09 = var_08 istouching(var_01);
      var_0A = common_scripts\utility::func_AA4A(var_08 getEye(), var_08 geteyeangles(), var_02.var_116, cos(25));
      if(var_09 && var_0A) {
        var_06 = 1;
      }
    }

    wait(0.1);
  }

  wait(1);
  common_scripts\utility::func_3C8F("flag_audiolog_dancer_jumpscare_triggered");
  var_00 scriptmodelclearanim();
  var_00 scriptmodelplayanim("s2_zom_berlin_bed_scare_jump", "dancer_js_jump");
  var_00 lib_0378::func_8D74("aud_dancer_jumpscare");
}

warp_dancer_jump_scare() {
  common_scripts\utility::func_3C8F("flag_audiolog_dancer_jumpscare_available");
}

__________________audio_log_3_dancer___________________________________________________() {}

bonus_ee_audiolog_dancer_init() {
  common_scripts\utility::func_3C87("flag_audiolog_dancer_shot_painting");
  common_scripts\utility::func_3C87("flag_audiolog_dancer_grabbed_record");
  common_scripts\utility::func_3C87("flag_audiolog_dancer_placed_record");
  common_scripts\utility::func_3C87("flag_audiolog_dancer_jumpscare_available");
  common_scripts\utility::func_3C87("flag_audiolog_dancer_jumpscare_triggered");
  var_00 = getent("bonus_ee_audiolog_dancer_painting", "script_noteworthy");
  var_01 = getent("bonus_ee_audiolog_dancer_painting_trig", "script_noteworthy");
  var_02 = getent("bonus_ee_audiolog_dancer_record", "script_noteworthy");
  var_03 = getent("bonus_ee_audiolog_dancer_record_trig_use", "script_noteworthy");
  var_04 = getent("bonus_ee_audiolog_dancer_phono_trig_use", "script_noteworthy");
  var_05 = getent("bonus_ee_audiolog_dancer_phono_trig_dmg", "script_noteworthy");
  var_06 = getent("trigger_dancer_jump_scare_audiolog_collect", "script_noteworthy");
  var_07 = [];
  var_08 = function_021F("zmb_phonograph_model", "targetname");
  var_07["record_player"] = var_08[0];
  var_09 = function_021F("hc_phonograph_tech_piece", "targetname");
  var_07["record_player_tech"] = var_09[0];
  var_07["record_player"] thread set_phonograph_state("off");
  if(isDefined(var_06)) {
    var_06 common_scripts\utility::func_9D9F();
  }

  var_07 thread bonus_ee_audiolog_dancer_step_01(var_00, var_01, var_02, var_03);
  var_07 thread bonus_ee_audiolog_dancer_step_02(var_04);
  var_07 thread bonus_ee_audiolog_dancer_step_03(var_05, var_06);
}

bonus_ee_audiolog_dancer_step_01(param_00, param_01, param_02, param_03) {
  var_04 = 2;
  var_05 = 0;
  self["record_player"] setscriptablepartstate("record", "off");
  self["record_player_tech"] setscriptablepartstate("tech_light", "off");
  while(var_04 > var_05) {
    param_01 waittill("damage", var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F);
    var_05++;
    param_00 movez(-1, 0.2, 0.1, 0.05);
    wait 0.05;
  }

  param_00 rotateroll(165, 0.75, 0.5, 0.2);
  wait(0.4);
  param_00 movex(18, 0.25, 0.1, 0.1);
  wait(0.2);
  param_00 movez(-60, 0.5, 0.25, 0);
  param_03 waittill("trigger");
  common_scripts\utility::func_3C8F("flag_audiolog_dancer_grabbed_record");
  param_02 delete();
}

bonus_ee_audiolog_dancer_step_02(param_00) {
  common_scripts\utility::func_3C9F("flag_audiolog_dancer_grabbed_record");
  self["record_player_tech"] setscriptablepartstate("tech_light", "red_on");
  param_00 waittill("trigger");
  common_scripts\utility::func_3C8F("flag_audiolog_dancer_placed_record");
}

bonus_ee_audiolog_dancer_step_03(param_00, param_01) {
  var_02 = 5;
  var_03 = 0;
  param_00 method_80B0(param_00 method_85A0() | 256);
  common_scripts\utility::func_3C9F("flag_audiolog_dancer_placed_record");
  self["record_player"] setscriptablepartstate("record", "on");
  self["record_player_tech"] setscriptablepartstate("tech_light", "green_on");
  while(var_02 > var_03) {
    param_00 waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    if(var_0D == "wunderbuss_zm") {
      var_03++;
    }

    wait 0.05;
  }

  self["record_player"] thread set_phonograph_state("on");
  self["record_player"] setscriptablepartstate("record", "on");
  param_00 thread func_9276();
  common_scripts\utility::func_3C8F("flag_audiolog_dancer_jumpscare_available");
  if(isDefined(param_01)) {
    param_01 common_scripts\utility::func_9DA3();
  }
}

set_phonograph_state(param_00) {
  switch (param_00) {
    case "off":
      self setscriptablepartstate("machine_main", "turn_off");
      wait(getanimlength(%zmb_phonograph_turn_off));
      self setscriptablepartstate("machine_main", "off");
      break;

    case "on":
      self setscriptablepartstate("machine_main", "turn_on");
      wait(getanimlength(%zmb_phonograph_turn_on));
      self setscriptablepartstate("machine_main", "on");
      break;

    default:
      break;
  }
}

func_9276() {
  var_00 = lib_0380::func_6844("zmb_mus_darkwings_straight", undefined, self, 0.5, 1);
  common_scripts\utility::func_3C9F("flag_audiolog_dancer_jumpscare_triggered");
  lib_0380::func_6850(var_00, 1);
}

bonus_ee_audiolog_dancer_alternate_prop_swap(param_00) {
  var_01 = lib_0550::func_24D4(19);
  var_02 = lib_0550::func_415C(self, var_01);
  param_00 = getent("dancer_js", "targetname");
  wait(1);
  var_03 = param_00 gettagorigin("TAG_WEAPON_RIGHT");
  var_04 = param_00 gettagangles("TAG_WEAPON_RIGHT");
  var_05 = spawn("script_model", var_03);
  var_05 setModel("dun_belongings_book_03");
  var_05.var_1D = (5.07907, 282.089, -44.3602);
  lib_054F::func_86B3(var_05, self, var_02);
  wait(0.5);
  var_05 method_8449(param_00, "TAG_WEAPON_RIGHT");
}

__________________the_classic_ppsh__________________() {}

the_classic_init() {
  common_scripts\utility::func_3C87("flag_the_classic_mirror_one_complete");
  common_scripts\utility::func_3C87("flag_the_classic_mirror_two_complete");
  common_scripts\utility::func_3C87("flag_the_classic_mirror_three_complete");
  var_00 = getEntArray("classic_light_model", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  the_classic_logic();
}

the_classic_logic() {
  var_00 = getent("classic_trig_use_touch_mirror_one", "script_noteworthy");
  var_00 thread the_classic_listen_for_jolts("flag_the_classic_mirror_one_complete", 0.25);
  common_scripts\utility::func_3C9F("flag_the_classic_mirror_one_complete");
  var_01 = getent("classic_trig_use_touch_mirror_two", "script_noteworthy");
  var_01 thread the_classic_listen_for_jolts("flag_the_classic_mirror_two_complete", 0.15);
  common_scripts\utility::func_3C9F("flag_the_classic_mirror_two_complete");
  var_02 = getent("classic_trig_use_touch_mirror_three", "script_noteworthy");
  var_02 thread the_classic_listen_for_jolts("flag_the_classic_mirror_three_complete", 0.08);
  common_scripts\utility::func_3C9F("flag_the_classic_mirror_three_complete");
  the_classic_completed_reward();
}

the_classic_listen_for_jolts(param_00, param_01) {
  while(!common_scripts\utility::func_3C77(param_00)) {
    level waittill("spawned_money_share");
    foreach(var_03 in level.var_8AD2) {
      if(!self method_858B(var_03.var_116)) {
        continue;
      }

      var_04 = var_03.var_117;
      var_05 = var_04 getentitynumber();
      var_03 maps\mp\zombies\_zombies_money::func_8ADD(var_05, 0);
      var_03.var_6FD4 = 0;
      var_03.var_6FCB = 0;
      thread the_classic_jolt_drop_fx(self.var_116);
      the_classic_game_logic(param_00, param_01);
    }
  }
}

the_classic_listen_for_player_input() {
  self waittill("trigger");
  self notify("classic_stop_light");
}

the_classic_game_logic(param_00, param_01) {
  var_02 = undefined;
  if(param_00 == "flag_the_classic_mirror_one_complete") {
    the_classic_intro_light_show(1);
    var_02 = the_classic_intro_select_starting_light(1);
  } else if(param_00 == "flag_the_classic_mirror_two_complete") {
    the_classic_intro_light_show(2);
    var_02 = the_classic_intro_select_starting_light(2);
  } else if(param_00 == "flag_the_classic_mirror_three_complete") {
    the_classic_intro_light_show(3);
    var_02 = the_classic_intro_select_starting_light(3);
  }

  level.active_struct = var_02;
  var_03 = getEntArray("classic_light_model", "targetname");
  var_04 = undefined;
  foreach(var_06 in var_03) {
    if(var_06.var_165 == "classic_mirror_one" && param_00 == "flag_the_classic_mirror_one_complete") {
      var_04 = var_06;
      break;
    } else if(var_06.var_165 == "classic_mirror_two" && param_00 == "flag_the_classic_mirror_two_complete") {
      var_04 = var_06;
      break;
    } else if(var_06.var_165 == "classic_mirror_three" && param_00 == "flag_the_classic_mirror_three_complete") {
      var_04 = var_06;
      break;
    }
  }

  var_08 = var_04;
  thread the_classic_listen_for_player_input();
  the_classic_move_light(var_08, param_01);
  if(level.active_struct.var_1A5 == var_02.var_1A5) {
    foreach(var_06 in var_03) {
      var_06 method_805C();
    }

    switch (param_00) {
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

    common_scripts\utility::func_3C8F(param_00);
  } else {}

  foreach(var_06 in var_03) {
    var_06 method_805C();
  }
}

the_classic_intro_select_starting_light(param_00) {
  var_01 = [];
  switch (param_00) {
    case 1:
      var_01 = common_scripts\utility::func_46B7("classic_mirror_one", "script_noteworthy");
      break;

    case 2:
      var_01 = common_scripts\utility::func_46B7("classic_mirror_two", "script_noteworthy");
      break;

    case 3:
      var_01 = common_scripts\utility::func_46B7("classic_mirror_three", "script_noteworthy");
      break;
  }

  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_8260)) {
      if(var_03.var_8260 == "classic_struct_starting_light") {
        var_04 = var_03;
        var_05 = spawn("script_model", var_04.var_116);
        var_05.var_1D = var_04.var_1D;
        var_05 setModel("s2_light_bulb_03_on");
        var_06 = 1;
        for(var_07 = 0; var_07 < 5; var_07++) {
          if(var_06) {
            var_05 method_805C();
          } else {
            var_05 method_805B();
          }

          var_06 = !var_06;
          wait(0.5);
        }

        return var_04;
      }
    }
  }
}

the_classic_intro_light_show(param_00, param_01) {
  var_02 = [];
  var_03 = 0.75;
  var_04 = 2;
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  switch (param_00) {
    case 1:
      var_02 = common_scripts\utility::func_46B7("classic_mirror_one", "script_noteworthy");
      var_03 = 0.6;
      var_04 = 3;
      break;

    case 2:
      var_02 = common_scripts\utility::func_46B7("classic_mirror_two", "script_noteworthy");
      var_03 = 0.4;
      var_04 = 5;
      break;

    case 3:
      var_02 = common_scripts\utility::func_46B7("classic_mirror_three", "script_noteworthy");
      var_03 = 0.2;
      var_04 = 9;
      break;
  }

  if(!param_01) {
    var_03 = 0.1;
    var_04 = 15;
  }

  var_05 = [];
  for(var_06 = 0; var_06 < var_02.size; var_06++) {
    if(var_06 == 0) {
      var_07 = common_scripts\utility::func_46B5(var_02[var_06].var_1A2, "targetname");
    } else {
      var_07 = common_scripts\utility::func_46B5(var_05[var_06 - 1].var_1A2, "targetname");
    }

    var_05 = common_scripts\utility::func_F6F(var_05, var_07);
  }

  var_08 = 0;
  var_09 = [];
  while(var_08 < var_04) {
    for(var_06 = 0; var_06 < var_05.size; var_06++) {
      if(var_06 % 2) {
        var_0A = spawn("script_model", var_05[var_06].var_116);
        var_0A.var_1D = var_05[var_06].var_1D;
        var_0A setModel("s2_light_bulb_03_on");
        var_09 = common_scripts\utility::func_F6F(var_09, var_0A);
      }
    }

    wait(var_03);
    foreach(var_0C in var_09) {
      var_09 = common_scripts\utility::func_F93(var_09, var_0C);
      var_0C delete();
    }

    for(var_06 = 0; var_06 < var_05.size; var_06++) {
      if(!var_06 % 2) {
        var_0A = spawn("script_model", var_05[var_06].var_116);
        var_0A.var_1D = var_05[var_06].var_1D;
        var_0A setModel("s2_light_bulb_03_on");
        var_09 = common_scripts\utility::func_F6F(var_09, var_0A);
      }
    }

    wait(var_03);
    foreach(var_0C in var_09) {
      var_09 = common_scripts\utility::func_F93(var_09, var_0C);
      var_0C delete();
    }

    var_08++;
  }
}

the_classic_move_light(param_00, param_01) {
  self endon("classic_stop_light");
  param_00 method_805B();
  for(;;) {
    var_02 = common_scripts\utility::func_46B5(level.active_struct.var_1A2, "targetname");
    param_00.var_116 = var_02.var_116;
    level.active_struct = var_02;
    wait(param_01);
  }
}

the_classic_completed_reward() {
  iprintlnbold("CLASSIC ADDED TO BOX!");
  maps\mp\zombies\_zombies_magicbox::func_9C8("ppsh41_classic_zm", "extended_mag", "none", "none");
  var_00 = getEntArray("classic_trig_use_touch", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread the_classic_jolt_drop_fx(var_02.var_116);
  }
}

the_classic_jolt_drop_fx(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5("moneyCloud"), param_00);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
}

__________________bell_race__________________() {}

bell_race_init() {
  common_scripts\utility::func_3C87("bell_race_complete");
  var_00 = getEntArray("lore_primary", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(var_02.var_8260 == "lore19") {
      level.bell_race_log_trig = getent(var_02.var_1A2, "targetname");
      level.bell_race_log_trig common_scripts\utility::func_9D9F();
      var_02 method_805C();
      level.bell_race_log = var_02;
      break;
    }
  }

  bell_race_logic();
}

bell_race_logic() {
  while(!common_scripts\utility::func_3C77("bell_race_complete")) {
    var_00 = getent("bell_race_starting_bell", "script_noteworthy");
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    var_0B = getent(var_00.var_1A2, "targetname");
    var_0B setModel("aac_lamp_03_on");
    var_00 lib_0378::func_8D74("aud_ring_bell");
    level.bell_race_user = var_02;
    bell_race_start();
  }
}

bell_race_start() {
  level endon("bell_race_time_up");
  iprintlnbold("Race start!");
  level.bells_dinged = 0;
  var_00 = getEntArray("bell_race_trig_dmg", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread bell_race_bell_wait_for_damage();
  }

  thread bell_race_timer();
  for(;;) {
    if(level.bells_dinged >= var_00.size) {
      var_04 = getent("bell_race_ending_bell", "script_noteworthy");
      var_04 bell_race_bell_wait_for_damage();
      bell_race_complete();
      break;
    }

    wait 0.05;
  }
}

bell_race_bell_wait_for_damage() {
  level endon("bell_race_time_up");
  var_00 = getent(self.var_1A2, "targetname");
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(var_02 == level.bell_race_user) {
      var_00 setModel("aac_lamp_03_on");
      level.bells_dinged = level.bells_dinged + 1;
      lib_0378::func_8D74("aud_ring_bell");
      iprintlnbold("Ding!");
      break;
    }

    wait 0.05;
  }
}

bell_race_timer() {
  level endon("bell_race_bells_complete");
  var_00 = 0;
  var_01 = 20;
  while(var_00 < var_01) {
    var_00 = var_00 + 1;
    wait(1);
  }

  thread bell_race_fail();
  level notify("bell_race_time_up");
}

bell_race_fail() {
  iprintlnbold("Race failed!");
  var_00 = getEntArray("bell_race_lamp", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(var_02.var_106 == "aac_lamp_03_on") {
      var_02 setModel("aac_lamp_03");
    }
  }
}

bell_race_complete() {
  iprintlnbold("Race complete!");
  level.bell_race_log_trig common_scripts\utility::func_9DA3();
  level.bell_race_log method_805B();
  var_00 = getent("bell_race_box", "script_noteworthy");
  var_00 gravitymove((100, 100, 180), 1);
  common_scripts\utility::func_3C8F("bell_race_complete");
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
  var_00 = hangman_setup_word_array();
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    hangman_hide_parts();
    var_02 = var_00[var_01];
    var_03 = hangman_attempt_to_solve(var_02);
    if(var_03) {
      hangman_give_reward(var_02);
    } else {
      hangman_show_failure();
    }

    wait(2);
  }

  hangman_cleanup();
}

hangman_setup_word_array() {
  var_00 = 7;
  var_01 = [];
  for(var_02 = 0; var_02 < var_00; var_02++) {
    var_01[var_01.size] = var_02;
  }

  var_01 = common_scripts\utility::func_F92(var_01);
  var_03 = [];
  var_03[var_01[0]] = ["r", "e", "a", "p", "e", "r"];
  var_03[var_01[1]] = ["d", "a", "m", "n", "a", "t", "i", "o", "n"];
  var_03[var_01[2]] = ["f", "a", "m", "i", "s", "h", "e", "d"];
  var_03[var_01[3]] = ["w", "o", "n", "d", "e", "r"];
  var_03[var_01[4]] = ["g", "e", "i", "s", "t", "k", "r", "a", "f", "t"];
  var_03[var_01[5]] = ["g", "l", "u", "t", "t", "o", "n", "y"];
  var_03[var_01[6]] = ["t", "h", "e", "j", "a", "c", "k", "b", "o", "x"];
  return var_03;
}

hangman_attempt_to_solve(param_00) {
  var_01 = [];
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_01[var_03] = " _ ";
  }

  var_04 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  var_05 = 0;
  childthread hangman_update_cursor_letter(var_04, var_05);
  childthread hangman_attempt_to_solve_forward_input();
  childthread hangman_attempt_to_solve_backward_input();
  childthread hangman_attempt_to_solve_lockin_input();
  while(!hangman_check_words_against_eachother(var_01, param_00)) {
    var_06 = level common_scripts\utility::func_A715("hangman_forward_selection", "hangman_backward_selection", "hangman_lockin_selection");
    if(var_06 == "hangman_forward_selection") {
      var_05++;
      if(var_05 >= var_04.size) {
        var_05 = 0;
      }

      childthread hangman_update_cursor_letter(var_04, var_05);
    } else if(var_06 == "hangman_backward_selection") {
      var_05--;
      if(var_05 < 0) {
        var_05 = var_04.size - 1;
      }

      childthread hangman_update_cursor_letter(var_04, var_05);
    } else if(var_06 == "hangman_lockin_selection") {
      if(common_scripts\utility::func_F79(var_02, var_04[var_05])) {
        wait 0.05;
        continue;
      }

      var_07 = hangman_attempt_letter_entry(param_00, var_04, var_05);
      if(var_07) {
        for(var_03 = 0; var_03 < param_00.size; var_03++) {
          if(param_00[var_03] == var_04[var_05]) {
            var_01[var_03] = param_00[var_03];
            var_08 = getent("hangman_letter_panel" + common_scripts\utility::func_9AAD(var_03 + 1), "script_noteworthy");
            var_08 setModel("zbr_cab_letter_" + var_04[var_05]);
            var_08 method_805B();
          }
        }
      } else {
        var_02[var_02.size] = var_04[var_05];
        hangman_add_zombie_part(var_02.size);
        if(var_02.size >= 6) {
          return 0;
        }
      }
    }

    wait 0.05;
    wait 0.05;
  }

  return 1;
}

hangman_attempt_letter_entry(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    if(var_04 == param_01[param_02]) {
      return 1;
    }
  }

  return 0;
}

hangman_update_cursor_letter(param_00, param_01) {
  level notify("hangman_showing_new_letter");
  level endon("hangman_showing_new_letter");
  var_02 = getent("hangman_letter_cursor", "targetname");
  var_02 setModel("zbr_cab_letter_" + param_00[param_01]);
}

hangman_attempt_to_solve_forward_input() {
  var_00 = getent("hangman_letter_forward", "targetname");
  for(;;) {
    var_00 waittill("trigger");
    level notify("hangman_forward_selection");
    wait 0.05;
  }
}

hangman_attempt_to_solve_backward_input() {
  var_00 = getent("hangman_letter_back", "targetname");
  for(;;) {
    var_00 waittill("trigger");
    level notify("hangman_backward_selection");
    wait 0.05;
  }
}

hangman_attempt_to_solve_lockin_input() {
  var_00 = getent("hangman_letter_submit", "targetname");
  for(;;) {
    var_00 waittill("trigger");
    level notify("hangman_lockin_selection");
    wait 0.05;
  }
}

hangman_check_words_against_eachother(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(param_00[var_02] != param_01[var_02]) {
      return 0;
    }
  }

  return 1;
}

hangman_add_zombie_part(param_00) {
  var_01 = getent("hangman_zombie_part_0" + common_scripts\utility::func_9AAD(param_00), "targetname");
  var_01 method_805B();
  if(param_00 >= 6) {
    maps\mp\_utility::func_2CED(2, ::hangman_hide_parts);
  }
}

hangman_hide_parts() {
  var_00 = getEntArray("hangman_zombie_part", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  var_04 = getEntArray("hangman_letter_panel", "targetname");
  foreach(var_06 in var_04) {
    var_06 method_805C();
  }
}

hangman_give_reward(param_00) {
  var_01 = "";
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01 = var_01 + param_00[var_02];
  }

  var_03 = common_scripts\utility::func_46B5("hangman_prize_spot", "targetname");
  switch (var_01) {
    case "reaper":
      maps\mp\gametypes\zombies::func_281C("insta_kill", var_03.var_116);
      break;

    case "damnation":
      maps\mp\gametypes\zombies::func_281C("nuke", var_03.var_116);
      break;

    case "famished":
      maps\mp\gametypes\zombies::func_281C("ammo", var_03.var_116);
      break;

    case "gluttony":
      maps\mp\gametypes\zombies::func_281C("double_points", var_03.var_116);
      break;

    case "geistkraft":
      maps\mp\gametypes\zombies::func_281C("ability_fill", var_03.var_116);
      break;

    case "wonder":
      thread hangman_give_razer_gun(var_03);
      thread hangman_give_tesla_gun(var_03);
      break;

    case "thejackbox":
      thread hangman_give_jack_in_the_box(var_03);
      break;

    default:
      break;
  }
}

hangman_give_jack_in_the_box(param_00) {
  var_01 = spawn("script_model", param_00.var_116 + (0, 0, 25));
  var_01 setModel("npc_zom_jack_in_the_box");
  var_01.var_1D = var_01.var_1D + (0, -90, 0);
  var_01 lib_0547::func_AC41(" ");
  var_02 = spawn("script_model", param_00.var_116 + (0, 0, -205));
  var_02 setModel("tag_origin");
  var_02.var_1D = var_02.var_1D + (-90, 0, 0);
  playFXOnTag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  for(;;) {
    var_01 waittill("player_used", var_03);
    if(!isDefined(var_03.var_4B72) || !var_03.var_4B72) {
      var_03 thread lib_057D::func_4766();
      break;
    } else {
      var_03 method_82FA("jack_in_box_decoy_zm", 3);
      break;
    }
  }

  var_01 delete();
  killfxontag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  var_02 delete();
}

hangman_give_razer_gun(param_00) {
  var_01 = spawn("script_model", param_00.var_116 + (0, -48, 45));
  var_01 setModel("npc_zom_sawgun_01");
  var_01.var_1D = var_01.var_1D + (0, -45, 0);
  var_01 lib_0547::func_AC41(" ");
  var_02 = spawn("script_model", param_00.var_116 + (0, -48, -200));
  var_02 setModel("tag_origin");
  var_02.var_1D = var_02.var_1D + (-90, 0, 0);
  playFXOnTag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  var_01 waittill("player_used", var_03);
  var_03 lib_0586::func_78C("razergun_zm");
  var_03 lib_0586::func_78E("razergun_zm");
  var_01 lib_0547::func_AC40();
  var_01 delete();
  killfxontag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  var_02 delete();
}

hangman_give_tesla_gun(param_00) {
  var_01 = spawn("script_model", param_00.var_116 + (0, 48, 45));
  var_01 setModel("tag_origin");
  var_01.var_1D = var_01.var_1D + (0, -45, 0);
  var_01 lib_0547::func_AC41(" ");
  var_02 = spawn("script_model", param_00.var_116 + (0, 48, -200));
  var_02 setModel("tag_origin");
  var_02.var_1D = var_02.var_1D + (-90, 0, 0);
  var_03 = lib_0586::create_streamed_world_weapon_model("teslagun_zm", var_01.var_116);
  var_03.var_1D = var_01.var_1D;
  playFXOnTag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  var_01 waittill("player_used", var_04);
  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_04, "teslagun_zm");
  var_04 lib_0586::func_78E("teslagun_zm");
  var_01 lib_0547::func_AC40();
  var_01 delete();
  killfxontag(level.var_611["zmb_ber_gun_cone_glow"], var_02, "tag_origin");
  var_02 delete();
  var_03 delete();
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
  var_00 = getent("beam_pod", "script_noteworthy");
  var_01 = getent("log_pod", "script_noteworthy");
  var_00.var_1D = var_00.var_1D + (0, 90, 0);
  var_01.var_1D = var_01.var_1D + (0, 90, 0);
  var_00 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, 0.01);
  var_01 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, 0.01);
  wait 0.05;
  var_00 scriptmodelpauseanim(1);
  var_01 scriptmodelpauseanim(1);
}

aiship_audiolog_collect_souls() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getEntArray("hack_node_generic", "script_noteworthy");
  var_01 = getent("airship_node_03_05", "targetname");
  var_00 = common_scripts\utility::func_F93(var_00, var_01);
  var_02 = 0;
  while(!var_02) {
    level waittill("hack_node_soul_collected");
    var_02 = 1;
    foreach(var_04 in var_00) {
      if(!isDefined(var_04.soul_charged) || !var_04.soul_charged) {
        var_02 = 0;
        break;
      }
    }
  }
}

airship_audiolog_handle_valves() {
  level endon("flag_override_electroschnell_complete");
  while(!isDefined(level.var_744A) || level.var_744A.size <= 0) {
    wait 0.05;
  }

  thread airship_audiolog_log_valve();
  thread airship_audiolog_beam_valve();
}

airship_audiolog_log_valve() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getEntArray("lore_primary", "script_noteworthy");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    if(var_03.var_8260 == "lore18") {
      var_01 = var_03;
      break;
    }
  }

  var_05 = getent(var_01.var_1A2, "targetname");
  var_05 common_scripts\utility::func_9D9F();
  thread airship_audiolog_open_doors("log_pod_open_trig", "log_pod_open_valve", "log_pod", "make_airship_audiolog_usable");
  level waittill("make_airship_audiolog_usable");
  var_05 common_scripts\utility::func_9DA3();
}

airship_audiolog_beam_valve() {
  level endon("flag_override_electroschnell_complete");
  airship_audiolog_open_doors("beam_pod_open_trig", "beam_pod_open_valve", "beam_pod");
}

airship_audiolog_open_doors(param_00, param_01, param_02, param_03) {
  level endon("flag_override_electroschnell_complete");
  var_04 = getent(param_00, "script_noteworthy");
  var_05 = getent(param_01, "script_noteworthy");
  var_06 = getent(param_02, "script_noteworthy");
  var_04.players_using = 0;
  foreach(var_08 in level.var_744A) {
    var_08 thread airship_audiolog_open_door_player_handler(var_05, var_04, var_06, param_03);
  }
}

airship_audiolog_open_door_player_handler(param_00, param_01, param_02, param_03) {
  level endon("game_over");
  level endon("flag_override_electroschnell_complete");
  var_04 = getanimlength(%s2_zmb_drop_pod_open_front_quick);
  var_05 = 0.1;
  var_06 = 0;
  while(!var_06) {
    if(self useButtonPressed() && self istouching(param_01) && param_01.players_using == 0) {
      param_01.players_using++;
      param_02 scriptmodelclearanim();
      param_02 scriptmodelplayanim("s2_zmb_drop_pod_open_front_quick", undefined, 0, var_05);
      var_07 = gettime();
      var_08 = var_04 / var_05;
      var_09 = 0;
      var_09 = airship_audiolog_open_door_player_input_think(var_07, var_08, param_01, param_00);
      if(isDefined(var_09) && var_09) {
        var_06 = 1;
        param_02 scriptmodelpauseanim(1);
      } else {
        var_0A = gettime() - var_07 * 0.001 * var_05;
        var_0B = clamp(var_04 - var_0A, 0, var_04);
        var_0C = 0.5;
        param_02 scriptmodelclearanim();
        param_02 scriptmodelplayanim("s2_zmb_drop_pod_close_front_quick", undefined, var_0B, var_0C);
        wait(var_04 / var_0C);
        param_01.players_using = 0;
      }
    }

    while(lib_0547::func_577E(self)) {
      wait 0.05;
    }

    wait 0.05;
  }

  if(isDefined(param_03)) {
    level notify(param_03);
  }
}

airship_audiolog_open_door_player_input_think(param_00, param_01, param_02, param_03) {
  level endon("flag_override_electroschnell_complete");
  self endon("death");
  self endon("disconnect");
  self endon("enter_last_stand");
  self endon("begin_last_stand");
  var_04 = 0;
  var_05 = 0;
  while(var_04 < param_01 * 1000 / 3) {
    wait 0.05;
    if(self useButtonPressed() && self istouching(param_02)) {
      var_04 = gettime() - param_00;
      param_03 rotateroll(1, 0.05);
      var_05++;
      continue;
    }

    param_03 rotateroll(-1 * var_05, 0.5);
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
    wait 0.05;
  }

  wait 0.05;
  var_00 = 38.9;
  var_01 = 39.7;
  var_02 = 0;
  while(!var_02) {
    while(!quest_step_use_radio_codes_check(var_01, "right") || !quest_step_use_radio_codes_check(var_00, "left")) {
      wait 0.05;
    }

    var_03 = -5536;
    var_04 = gettime();
    var_05 = 0;
    while(var_03 > var_05) {
      if(quest_step_use_radio_codes_check(var_01, "right") && quest_step_use_radio_codes_check(var_00, "left")) {
        var_05 = gettime() - var_04;
        if(var_03 <= var_05) {
          var_02 = 1;
          break;
        }
      }

      wait 0.05;
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_06 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_06] = [];
  level.possible_radio_codes[var_06]["left"] = var_00;
  level.possible_radio_codes[var_06]["right"] = var_01;
}

transmedia_event_give_prize() {
  if(maps\mp\_utility::isproductionlevelactive(12)) {
    foreach(var_01 in level.var_744A) {
      var_01 ae_reportcomplexgameevent(16, [3, 22]);
      var_01 thread maps\mp\gametypes\_hud_message::func_9102("zom_dlc2_rune_01");
    }
  }
}

_______________outro_______________________________() {}

run_outro_berlin() {
  function_028E("mp/mp_zombie_berlin_outro");
  foreach(var_01 in lib_0547::func_408F()) {
    var_01 lib_056D::func_5A86();
  }

  foreach(var_04 in level.var_744A) {
    var_04 playersetgroundreferenceent(undefined);
  }

  lib_054D::giveplayersexp("berlin_exp_ref_17");
  lib_0547::zm_util_run_outro("mp/mp_zombie_berlin_outro", 51, 0.5, 1, 0, "berl_outro_movie");
  maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_1();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  common_scripts\utility::func_3C8F("berlin_cinematic_done");
  foreach(var_04 in level.var_744A) {
    var_04 lib_056A::func_4772(1);
  }

  level.var_6F1E = 0;
}