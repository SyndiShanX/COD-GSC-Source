/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_ftue\mp_m_ftue.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_precache::main();
  scripts\mp\maps\mp_m_ftue\gen\mp_m_ftue_art::main();
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_fx::main();
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_m_ftue");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  game["dialog"]["gametype"] = "welcometocampfubar";
  load_dialog_into_array("alrightyouknowthedri");
  load_dialog_into_array("welcometocampfubar");
  load_dialog_into_array("alrightyouknowthedri");
  load_dialog_into_array("pickuptherifle");
  load_dialog_into_array("getovertothefiringli");
  load_dialog_into_array("trysprintingthiswari");
  load_dialog_into_array("shootthosetargetsfro");
  load_dialog_into_array("nowaimyourrifledownr");
  load_dialog_into_array("nowshooteachtargetwh");
  load_dialog_into_array("fantasticnowhitthelo");
  load_dialog_into_array("nowusethatpieceofcov");
  load_dialog_into_array("hitthetargetwhilemou");
  load_dialog_into_array("trymovingwhileyourem");
  load_dialog_into_array("nowblindfireandhitth");
  load_dialog_into_array("trygoingfromblindfir");
  load_dialog_into_array("greatnowgetovertothe");
  load_dialog_into_array("nowthetargetsarebloc");
  load_dialog_into_array("goodnowimgoingtopopu");
  load_dialog_into_array("nowrunthroughthatwal");
  load_dialog_into_array("greatweredoneheregok");
  level._id_DDC3 = 1;
  level._id_F7AA = 1;
  level.codcasterenabled = 0;
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x3eef4e390f811e19", 1);
  setDvar("#x3d4e90ea01c7bc02a", 0);
  setDvar("#x3da7701e93a21d8a", 0);
  level._id_159E = ::allowclasschoiceftue;
  level._id_AB75 = undefined;
  level._id_AB70 = ::tutonplayerkilled;
  level._id_52F7 = ::exit_level;
  level._id_A5B7 = 1;

  if(getdvarint("#x380734ab662c5b16", 1) != 0) {
    level._id_AD0F = getEntArray("OutOfBounds", "targetname");
    level._id_8D0B = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\engine\utility::_id_5C11("flag_player_hasweapon");
  scripts\engine\utility::_id_5C11("flag_player_reloaded");
  scripts\engine\utility::_id_5C11("flag_player_sprinted");
  scripts\engine\utility::_id_5C11("flag_player_tactical_sprinted");
  scripts\engine\utility::_id_5C11("flag_player_mounted");
  scripts\engine\utility::_id_5C11("flag_player_used_ads");
  scripts\engine\utility::_id_5C11("flag_player_mantled");
  scripts\engine\utility::_id_5C11("flag_player_hit_target_with_ads");
  scripts\engine\utility::_id_5C11("flag_player_hit_target_with_hip_fire");
  scripts\engine\utility::_id_5C11("flag_player_hit_target_while_mounted");
  scripts\engine\utility::_id_5C11("flag_player_moved_while_mounted");
  scripts\engine\utility::_id_5C11("flag_player_in_blindfire_position");
  scripts\engine\utility::_id_5C11("flag_player_hit_target_blindfire");
  scripts\engine\utility::_id_5C11("flag_player_hit_target_mounted_blindfire");
  scripts\engine\utility::_id_5C11("player_inside_end_sprint_trigger");
  scripts\engine\utility::_id_5C11("flag_popup_target_hit");
  scripts\engine\utility::_id_5C11("flag_global_hint_active");
  scripts\engine\utility::_id_5C11("flag_allow_sprint_hint");
  scripts\engine\utility::_id_5C11("flag_prevent_mantle_hint");
  scripts\engine\utility::_id_5C11("flag_monitor_blindfire_position");
  scripts\engine\utility::_id_5C11("flag_end_hud_tutorial_messages");
  scripts\engine\utility::_id_5C11("flag_allow_context_menu");
  scripts\engine\utility::_id_5C11("flag_butcher_alrightyouknowthedri");
  scripts\engine\utility::_id_5C11("flag_butcher_welcometocampfubar");
  scripts\engine\utility::_id_5C11("flag_butcher_alrightyouknowthedri");
  scripts\engine\utility::_id_5C11("flag_butcher_pickuptherifle");
  scripts\engine\utility::_id_5C11("flag_butcher_getovertothefiringli");
  scripts\engine\utility::_id_5C11("flag_butcher_trysprintingthiswari");
  scripts\engine\utility::_id_5C11("flag_butcher_shootthosetargetsfro");
  scripts\engine\utility::_id_5C11("flag_butcher_nowaimyourrifledownr");
  scripts\engine\utility::_id_5C11("flag_butcher_nowshooteachtargetwh");
  scripts\engine\utility::_id_5C11("flag_butcher_fantasticnowhitthelo");
  scripts\engine\utility::_id_5C11("flag_butcher_nowusethatpieceofcov");
  scripts\engine\utility::_id_5C11("flag_butcher_hitthetargetwhilemou");
  scripts\engine\utility::_id_5C11("flag_butcher_trymovingwhileyourem");
  scripts\engine\utility::_id_5C11("flag_butcher_nowblindfireandhitth");
  scripts\engine\utility::_id_5C11("flag_butcher_trygoingfromblindfir");
  scripts\engine\utility::_id_5C11("flag_butcher_greatnowgetovertothe");
  scripts\engine\utility::_id_5C11("flag_butcher_nowthetargetsarebloc");
  scripts\engine\utility::_id_5C11("flag_butcher_goodnowimgoingtopopu");
  scripts\engine\utility::_id_5C11("flag_butcher_nowrunthroughthatwal");
  scripts\engine\utility::_id_5C11("flag_butcher_greatweredoneheregok");
  level thread _id_AA5D();
}

allowclasschoiceftue() {
  return 0;
}

doesmodesupportplayerteamchoiceftue() {
  return 0;
}

load_dialog_into_array(var_0) {
  game["dialog"][var_0] = "mp_glob_ftue_bchr_" + var_0;
}

unload_dialog_from_array(var_0) {
  game["dialog"][var_0] = undefined;
}

_id_AA5D() {
  var_0 = 0;

  for(;;) {
    level waittill("connected", var_1);
    setDvar("#x3816522b6b2012a71", 0);
    var_1 _meth_8680("fade_to_black_all_except_music", 1);
    var_1 _meth_867F("mp_ftue_default_mix", 0.0, 1);

    if(!isbot(var_1)) {
      var_1._id_2A64 = 0;
      var_1._id_9A67 = 1;
      var_1._id_7594 = 1;
      var_1.completed_areas = [];
      var_1._id_A417 = undefined;
      var_1 thread stage_start();
    }
  }
}

fixcollision() {
  var_0 = getent("scriptbrush_mantle_over", "targetname");
  var_1 = spawn("script_model", (-835, 775, 215));
  var_1.angles = (0, 182.705, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = spawn("script_model", (-835, 775, 262));
  var_2.angles = (0, 182.705, 0);
  var_2 clonebrushmodeltoscriptmodel(var_0);
}

stage_start() {
  self waittill("giveLoadout");
  level.player thread scripts\mp\utility\player::_id_7908(1);
  level.player clear_all_hud_tutorial_messages();
  self takeallweapons();
  waittillframeend;
  scripts\mp\equipment::_id_391D();
  var_0 = makeweapon("s4_me_fists_mp");
  self giveweapon(var_0);
  self switchtoweapon(var_0);
  self allowmountside(0);
  self allowmounttop(0);
  var_1 = getent("scriptbrush_mantle_over", "targetname");
  var_1 hide();
  thread fixcollision();
  level thread doors_init();
  level thread popuptargets_init();
  var_2 = getent("marker_rifle", "targetname");
  _id_E24D("s4_ar_stango44", var_2.origin, var_2.angles);
  _id_07D1::_id_60C2("prematch_done");
  thread monitor_reload_think();
  thread monitor_sprint_think();
  thread monitor_tactical_sprint_think();
  thread monitor_player_ammo();
  thread monitor_player_mantle();
  _id_58A6(2.5, 1);
  waitframe();
  _id_B218("welcometocampfubar");
  stage_pickup_rifle();
  stage_goto_firing_line();
  stage_hipfire();
  stage_ads_fire();
  stage_invert_view();
  stage_mount_fire();
  stage_blind_fire();
  stage_goto_area2();
  stage_shoot_targets_destruction();
  stage_shoot_popup_targets();
  stage_goto_end();
  exit_level();
}

stage_pickup_rifle() {
  wait_for_dialogue(1.0);
  _id_B218("alrightyouknowthedri");
  var_0 = getent("marker_rifle", "targetname");
  var_1 = "stage_pickup_rifle";
  objectivemarker_show(var_1, var_0, &"MP_M_FTUE/PICK_UP_WEAPON", &"MP_M_FTUE/OBJICON_DESC_PICKUP");
  scripts\engine\utility::_id_5C04("flag_player_using_rifle");
  thread monitor_player_using_rifle();

  while(!scripts\engine\utility::_id_5C00("flag_player_using_rifle")) {
    level scripts\engine\utility::_id_1070F("flag_player_using_rifle", 10.0);

    if(!scripts\engine\utility::_id_5C00("flag_player_using_rifle") && !scripts\engine\utility::_id_5C00("flag_butcher_pickuptherifle")) {
      _id_B218("pickuptherifle");
    }
  }

  objectivemarker_complete(var_1);
  clear_all_hud_tutorial_messages();
  wait 1;
}

stage_goto_firing_line() {
  var_0 = getent("marker_firingline", "targetname");
  var_1 = "stage_goto_firing_line";
  objectivemarker_show(var_1, var_0, &"MP_M_FTUE/MOVE_NEXT", &"MP_M_FTUE/OBJICON_DESC_ADVANCE");
  show_hud_tutorial_message(&"MP_M_FTUE/MOVE_NEXT");
  _id_B218("getovertothefiringli");
  var_2 = getent("trigger_firingline", "targetname");
  var_2 waittill("trigger", var_3);
  objectivemarker_complete(var_1);
  clear_all_hud_tutorial_messages();
  wait 1;
}

stage_hipfire() {
  var_0 = popuptarget_get_targets(["popup_target_1", "popup_target_2", "popup_target_3"]);
  thread popuptargets_raise(var_0);
  var_1 = var_0.size;
  _id_B218("shootthosetargetsfro");
  show_hud_tutorial_message(&"MP_M_FTUE/HIPFIRE");
  var_2 = "stage_hipfire";
  objectivemarker_show(var_2, undefined, &"MP_M_FTUE/MOVE_NEXT", undefined);
  var_3 = [ &"MP_M_FTUE/HIPFIRE_ACCURACY1", &"MP_M_FTUE/HIPFIRE_ACCURACY2"];
  var_4 = 0;

  while(!level scripts\engine\utility::_id_5C00("flag_player_hit_target_with_hip_fire") || var_1 > 0) {
    level waittill("flag_popup_target_hit");
    var_1--;

    if(!var_4 && level scripts\engine\utility::_id_5C00("flag_player_hit_target_with_hip_fire")) {
      clear_all_hud_tutorial_messages(0);
      thread cycle_hud_tutorial_messages_think(var_3, 4.0, 0, 0.6);
      var_4 = 1;
    }

    if(var_1 == 0 && !level scripts\engine\utility::_id_5C00("flag_player_hit_target_with_hip_fire")) {
      wait 1;
      thread popuptargets_raise(var_0);
      var_1 = var_0.size;
    }
  }

  thread popuptargets_lower(var_0);
  objectivemarker_complete(var_2);
  wait_for_dialogue(1.0);
  clear_all_hud_tutorial_messages();
  wait 1;
}

stage_ads_fire() {
  var_0 = popuptarget_get_targets(["popup_target_1", "popup_target_2", "popup_target_3"]);
  thread popuptargets_raise(var_0);
  var_1 = var_0.size;
  _id_B218("nowaimyourrifledownr");
  var_2 = get_ads_toggle_string();
  show_hud_tutorial_message(var_2);
  thread monitor_player_ads();
  thread manage_ads_hint();
  level scripts\engine\utility::_id_5C04("flag_player_hit_target_with_ads");

  while(!level scripts\engine\utility::_id_5C00("flag_player_hit_target_with_ads") || var_1 > 0) {
    level waittill("flag_popup_target_hit");
    var_1--;

    if(var_1 == 0 && !level scripts\engine\utility::_id_5C00("flag_player_hit_target_with_ads")) {
      wait 1;
      thread popuptargets_raise(var_0);
      var_1 = var_0.size;

      if(!scripts\engine\utility::_id_5C00("flag_butcher_nowshooteachtargetwh")) {
        _id_B218("nowshooteachtargetwh");
      }
    }
  }

  level scripts\engine\utility::_id_5C04("flag_allow_ads_hint");
  thread popuptargets_lower(var_0);
  clear_all_hud_tutorial_messages();
  wait_for_dialogue();
  wait 1;
}

get_ads_toggle_string() {
  var_0 = &"MP_M_FTUE/ADS_HINT";

  if(self usinggamepad()) {
    var_1 = scripts\engine\utility::_id_C578("toggleADSEnabledGamepad");
  } else {
    var_1 = scripts\engine\utility::_id_C578("toggleADSEnabledKeyboard");
  }

  if(var_1 != 0) {
    var_0 = &"MP_M_FTUE/ADS_HINT_PRESS";
  }

  return var_0;
}

stage_invert_view() {
  var_0 = popuptarget_get_targets(["popup_target_4"]);
  thread popuptargets_raise(var_0);

  for(var_1 = var_0.size; var_1 > 0; var_1--) {
    level waittill("flag_popup_target_hit");
  }

  prompt_to_invert_controls();
  var_0 = popuptarget_get_targets(["popup_target_1"]);
  var_2 = getent("target1_highlow_target_data_up", "targetname");

  if(isDefined(var_2)) {
    var_0[0].up_pos = var_2.origin;
  }

  thread popuptargets_raise(var_0);
  var_1 = var_0.size;
  _id_B218("fantasticnowhitthelo");
  show_hud_tutorial_message(&"MP_M_FTUE/INVERT_SETTINGS");
  var_3 = 0;

  while(var_1 > 0) {
    level waittill("flag_popup_target_hit");
    var_1--;
    level scripts\engine\utility::_id_5C04("flag_allow_context_menu");
  }

  thread popuptargets_lower(var_0);
  wait_for_dialogue(1);
  clear_all_hud_tutorial_messages();
  wait 1;
}

get_mount_activation_string() {
  if(self usinggamepad()) {
    var_0 = scripts\engine\utility::_id_C578("mountButtonConfig");
  } else {
    var_0 = scripts\engine\utility::_id_C578("mountButtonConfigKBM");
  }

  switch (var_0) {
    case 1:
      return undefined;
    case 2:
      return &"MP_M_FTUE/MOUNT_DOUBLE_ADS";
    case 3:
      return &"MP_M_FTUE/MOUNT_ADS_MELEE";
    case 4:
      return undefined;
    case 5:
      return undefined;
    case 6:
      return undefined;
    case 7:
      return &"MP_M_FTUE/MOUNT";
    case 8:
      return &"MP_M_FTUE/MOUNT_BIND";
    case 9:
      return &"MP_M_FTUE/MOUNT_BIND_HOLD";
    case 10:
      return &"MP_M_FTUE/MOUNT_ADS_ACTIVATE";
  }
}

stage_mount_fire() {
  self allowmountside(1);
  self allowmounttop(1);
  self allowmantle(0);
  _id_B218("nowusethatpieceofcov");
  var_0 = getEntArray("marker_mount", "targetname");
  var_1 = "stage_mount_fire";
  objectivemarker_show(var_1, var_0[0], undefined, &"MP_M_FTUE/OBJICON_DESC_MOUNT");
  var_2 = get_mount_activation_string();

  if(isDefined(var_2)) {
    show_hud_tutorial_message(var_2);
  }

  while(self _meth_826F() < 0.5) {
    wait 0.5;
  }

  objectivemarker_complete(var_1);
  clear_hud_tutorial_message(&"MP_M_FTUE/MOUNT");
  wait 0.5;
  var_3 = popuptarget_get_targets(["popup_target_1", "popup_target_2", "popup_target_3"]);
  var_4 = getent("target1_mount_target_data_up", "targetname");

  if(isDefined(var_4)) {
    var_3[0].up_pos = var_4.origin;
  }

  thread popuptargets_raise(var_3);
  var_5 = var_3.size;
  _id_B218("hitthetargetwhilemou");
  show_hud_tutorial_message(&"MP_M_FTUE/MOUNT_SHOOT");
  var_6 = 0;
  level scripts\engine\utility::_id_5C04("flag_player_hit_target_while_mounted");
  level scripts\engine\utility::_id_5C04("flag_player_moved_while_mounted");
  thread monitor_move_while_mounted_think();

  while(!level scripts\engine\utility::_id_5C00("flag_player_hit_target_while_mounted") || !level scripts\engine\utility::_id_5C00("flag_player_moved_while_mounted") || var_5 > 0) {
    level waittill("flag_popup_target_hit");
    var_5--;

    if(!var_6 && level scripts\engine\utility::_id_5C00("flag_player_hit_target_while_mounted")) {
      clear_all_hud_tutorial_messages(0);
      show_hud_tutorial_message(&"MP_M_FTUE/MOUNT_HINT");
      var_6 = 1;

      if(var_5 == 0) {
        wait 1;
      }
    }

    if(var_5 == 0 && (!level scripts\engine\utility::_id_5C00("flag_player_hit_target_while_mounted") || !level scripts\engine\utility::_id_5C00("flag_player_moved_while_mounted"))) {
      wait 1;
      thread popuptargets_raise(var_3);
      var_5 = var_3.size;

      if(!level scripts\engine\utility::_id_5C00("flag_player_moved_while_mounted") && !level scripts\engine\utility::_id_5C00("flag_butcher_trymovingwhileyourem")) {
        _id_B218("trymovingwhileyourem");
        level scripts\engine\utility::_id_5C1B("flag_butcher_trymovingwhileyourem");
        clear_all_hud_tutorial_messages(0);
        show_hud_tutorial_message(&"MP_M_FTUE/MOUNT_MOVE");
      }
    }
  }

  clear_all_hud_tutorial_messages();
  wait_for_dialogue(2);
  self allowmantle(1);
}

get_blindfire_mount_activation_string() {
  if(self usinggamepad()) {
    var_0 = scripts\engine\utility::_id_C578("mountButtonConfig");
    var_1 = scripts\engine\utility::_id_C578("blindfireEnabledGpad");
  } else {
    var_0 = scripts\engine\utility::_id_C578("mountButtonConfigKBM");
    var_1 = scripts\engine\utility::_id_C578("blindfireEnabledKBM");
  }

  if(var_1) {
    switch (var_0) {
      case 1:
        return undefined;
      case 2:
        return &"MP_M_FTUE/DOUBLETAP_BLINDFIRE";
      case 3:
        return &"MP_M_FTUE/MOUNT_ADS_MELEE_BLINDFIRE";
      case 4:
        return undefined;
      case 5:
        return undefined;
      case 6:
        return undefined;
      case 7:
        return &"MP_M_FTUE/BLINDFIRE2";
      case 8:
        return &"MP_M_FTUE/MOUNT_BLINDFIRE";
      case 9:
        return &"MP_M_FTUE/MOUNT_HOLD_BLINDFIRE";
      case 10:
        return &"MP_M_FTUE/MOUNT_ADS_ACTIVATE_BLINDFIRE";
    }
  }
}

stage_blind_fire() {
  self allowmantle(0);
  self allowmountside(1);
  self allowmounttop(1);
  self allowads(1);
  setDvar("#x3128c3af25cb83383", 1);
  var_0 = getEntArray("marker_blindfire", "targetname");
  var_1 = getent("trigger_blindfire", "targetname");
  var_2 = 0;
  var_3 = 0;
  var_4 = gettime();
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  _id_B218("nowblindfireandhitth");
  var_8 = "stage_blind_fire";
  objectivemarker_show(var_8, var_0[0], undefined, &"MP_M_FTUE/OBJICON_DESC_CROUCH");
  wait 1.0;
  self allowmountside(1);
  self allowmounttop(1);
  self allowads(1);
  var_9 = 0;
  var_10 = set_crouch_tutorial_string();

  while(!self _meth_848D() || self _meth_826F() > 0.9) {
    if(!var_9 && !is_dialogue_playing(1.0)) {
      show_hud_tutorial_message(var_10);
      var_9 = 1;
    }

    wait 0.1;
  }

  clear_hud_tutorial_message(var_10);
  var_11 = popuptarget_get_targets(["popup_target_1"]);
  var_12 = var_11.size;
  var_13 = get_blindfire_mount_activation_string();

  while(!var_2 || !var_3 || var_12 > 0) {
    var_14 = distance(var_0[0].origin, level.player.origin) <= 64.0;
    var_15 = self _meth_826F() > 0.9;
    var_16 = self _meth_848D();
    var_17 = self _meth_8271() != "mount_none";

    if(!var_2) {
      var_6 = var_14 && !var_15 && var_16;
    } else if(!var_3) {
      var_6 = var_14 && (var_16 || var_17);
    }

    if(var_6) {
      if(var_6 != var_7) {
        objectivemarker_delete(var_8);
        clear_all_hud_tutorial_messages();

        if(!var_2) {
          show_hud_tutorial_message(&"MP_M_FTUE/BLINDFIRE");
        } else if(!var_3) {
          if(isDefined(var_13)) {
            show_hud_tutorial_message(var_13);
          }
        }

        thread popuptargets_raise(var_11);
      }

      var_12 = 0;

      foreach(var_19 in var_11) {
        if(var_19._id_E747 == "up") {
          var_12++;
        }
      }

      if(var_12 == 0 && !(var_2 && var_3) && !var_17) {
        thread popuptargets_raise(var_11);
        var_12 = var_11.size;
      }
    } else {
      if(var_6 != var_7) {
        clear_all_hud_tutorial_messages();
        objectivemarker_show(var_8, var_0[0], undefined, &"MP_M_FTUE/OBJICON_DESC_CROUCH");
        thread popuptargets_lower(var_11);
        var_12 = 0;
      }

      if(var_14 && !var_16) {
        if(!scripts\engine\utility::is_equal(level.last_hud_tutorial_str, var_10)) {
          show_hud_tutorial_message(var_10);
        }
      } else if(scripts\engine\utility::is_equal(level.last_hud_tutorial_str, var_10))
        clear_all_hud_tutorial_messages();
    }

    if(!var_2) {
      var_21 = level scripts\engine\utility::_id_5C00("flag_player_hit_target_blindfire");

      if(level scripts\engine\utility::_id_5C00("flag_player_hit_target_blindfire")) {
        var_2 = 1;
        thread popuptargets_lower(var_11);

        while(self _meth_8271() != "mount_none") {
          wait 0.5;
        }

        clear_all_hud_tutorial_messages(0);
        wait_for_dialogue(1.0);
        _id_B218("trygoingfromblindfir");
        wait_for_dialogue(0.0, 4.0);

        if(isDefined(var_13)) {
          show_hud_tutorial_message(var_13);
        }

        var_11 = popuptarget_get_targets(["popup_target_1", "popup_target_2", "popup_target_3"]);
        thread popuptargets_raise(var_11);
        level scripts\engine\utility::_id_5C04("flag_player_hit_target_blindfire");
        level scripts\engine\utility::_id_5C04("flag_player_hit_target_mounted_blindfire");
      }
    } else if(!var_3) {
      if(level scripts\engine\utility::_id_5C00("flag_player_hit_target_blindfire") || level scripts\engine\utility::_id_5C00("flag_player_hit_target_mounted_blindfire")) {
        var_3 = 1;
      }
    }

    var_7 = var_6;
    waitframe();
  }

  clear_all_hud_tutorial_messages();
  wait_for_dialogue(1.0);
  self allowmantle(1);
  setDvar("#x3128c3af25cb83383", 0);
}

stage_goto_area2() {
  _id_4DFF("openabledoor_1");
  var_0 = getent("scriptbrush_mantle_over", "targetname");
  var_0 show();
  var_1 = [];
  var_1[0] = getent("marker_mount", "targetname");
  var_1[1] = getent("marker_goto_area2_1", "targetname");
  var_1[2] = getent("marker_goto_area2_2", "targetname");
  var_2 = [];
  var_2[0] = getent("trigger_enteredrange", "targetname");
  var_2[1] = getent("trigger_goto_area2_1", "targetname");
  var_2[2] = getent("trigger_goto_area2_2", "targetname");
  _id_B218("greatnowgetovertothe");
  var_3 = "stage_goto_area2";
  objectivemarker_show(var_3, var_1[0], undefined, &"MP_M_FTUE/OBJICON_DESC_ADVANCE");
  level.player thread manage_mantle_hint();
  thread player_inside_end_sprint_trigger_think();
  scripts\engine\utility::_id_10888(level, "flag_player_mantled", var_2[0], "trigger");
  objectivemarker_move(var_3, var_1[1].origin);
  level.player thread manage_sprint_hint(0);
  var_2[1] waittill("trigger", var_4);
  objectivemarker_move(var_3, var_1[2].origin);
  var_2[2] waittill("trigger", var_4);
  level scripts\engine\utility::_id_5C04("flag_allow_sprint_hint");
  clear_hud_tutorial_message(&"MP_M_FTUE/SPRINT");
  objectivemarker_complete(var_3);
  wait_for_dialogue();
  wait 1;
}

stage_shoot_targets_destruction() {
  self allowmantle(1);
  self allowmounttop(1);
  self allowmountside(1);
  _id_B218("nowthetargetsarebloc");
  wait_for_dialogue(0.0, 4.0);
  var_0 = popuptarget_get_group("popup_targets_area2");
  thread popuptargets_raise(var_0);
  var_1 = var_0.size;
  var_2 = getEntArray("marker_target_area2", "targetname");
  show_hud_tutorial_message(&"MP_M_FTUE/SHOOT_BREAKABLE");

  while(var_1 > 0) {
    level waittill("flag_popup_target_hit");
    var_1--;
  }

  clear_all_hud_tutorial_messages();
  wait_for_dialogue();
  wait 1;
}

stage_shoot_popup_targets() {
  _id_B218("goodnowimgoingtopopu");
  wait_for_dialogue(0.0, 4.0);
  var_0 = popuptarget_get_group("popup_targets_area2");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0.size;
  var_2 = getEntArray("marker_target_area2", "targetname");
  show_hud_tutorial_message(&"MP_M_FTUE/SHOOT_TARGETS");

  while(var_1 > 0) {
    var_3 = var_0[var_1 - 1];

    while(istrue(var_3._id_8939)) {
      wait 0.5;
    }

    var_3 thread popuptarget_flip("up");
    level waittill("flag_popup_target_hit");
    var_1--;
  }

  clear_all_hud_tutorial_messages();
  wait_for_dialogue();
  wait 1;
}

stage_goto_end() {
  _id_B218("greatnowgetovertothe");
  _id_4DFF("openabledoor_2");
  var_0 = [];
  var_0[0] = getent("marker_goto_end_1", "targetname");
  var_0[1] = getent("marker_goto_end_2", "targetname");
  var_1 = [];
  var_1[0] = getent("trigger_goto_end_1", "targetname");
  var_1[1] = getent("trigger_goto_end_2", "targetname");
  level scripts\engine\utility::_id_5C04("flag_player_sprinted");
  level scripts\engine\utility::_id_5C04("flag_player_tactical_sprinted");
  thread monitor_sprint_think();
  thread monitor_tactical_sprint_think();
  level.player thread manage_tactical_sprint_hint(1);
  var_2 = "stage_goto_end";
  objectivemarker_show(var_2, var_0[0], undefined, &"MP_M_FTUE/OBJICON_DESC_ADVANCE");
  var_1[0] waittill("trigger", var_3);
  level scripts\engine\utility::_id_5C04("flag_allow_sprint_hint");
  wait_for_dialogue(0.1);
  waitframe();
  objectivemarker_complete(var_2);
  var_2 = "stage_goto_end_2";
  objectivemarker_show(var_2, var_0[1], undefined, &"MP_M_FTUE/OBJICON_DESC_SPRINTWALL");
  _id_B218("nowrunthroughthatwal");
  show_hud_tutorial_message(&"MP_M_FTUE/SPRINT_WALL");
  var_1[1] waittill("trigger", var_3);
  setDvar("#x3816522b6b2012a71", 1);
  thread _id_07BC::createftuechallengeevent();
  self allowsprint(0);
  self _meth_8017(0);
  objectivemarker_complete(var_2);
  thread _id_07F8::ftue_fade_music();
  clear_all_hud_tutorial_messages();
  wait_for_dialogue(1.0);
  _id_B218("greatweredoneheregok");
  level.player clear_all_hud_tutorial_messages();
  level.player thread scripts\mp\utility\player::_id_7903();
  level.player thread scripts\mp\utility\player::_id_7908(1);
  wait_for_dialogue(0.0, 2.0);
  thread _id_58A8(2.0);
  level.player disableweapons();
  wait_for_dialogue(0.0);
  level.player _meth_8680("mp_ftue_default_mix", 2);
  level.player _meth_867F("fade_to_black_all_except_music", 4);
  wait 2.0;
}

_id_E24D(var_0, var_1, var_2) {
  if(var_0 != "none") {
    var_3 = scripts\mp\class::buildweapon(var_0, [], "none", "none");
    var_4 = getcompleteweaponname(var_3);
    var_5 = spawn("weapon_" + var_4, var_1);
    var_5.angles = var_2;
    return var_5;
  }

  return undefined;
}

objectivemarker_show(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_4 = var_1 _meth_8169();
  }

  scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives::_id_A864(var_0, "current", var_4, var_3);
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives::_id_A8B9(var_0, 1);
  self playlocalsound("ui_mp_ftue_notify_lrg");
}

objectivemarker_complete(var_0) {
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives::_id_A8A9(var_0);
}

objectivemarker_delete(var_0) {
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives::_id_A8A9(var_0);
}

objectivemarker_move(var_0, var_1) {
  scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives::_id_A8B3(var_0, var_1);
  self playlocalsound("ui_mp_ftue_notify_lrg");
}

doors_init() {
  level._id_4E4C = [];
  var_0 = getEntArray("tut_door", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_39D6 = var_2.angles;
    var_2.openangles = var_2._id_39D6 + (0, 90, 0);
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5.classname) {
        case "script_brushmodel":
          var_2._id_39A7 = var_5;
          var_2._id_39A7 linkto(var_2);
          break;
        case "script_model":
          var_2.openangles = var_5.angles;
          var_5 delete();
          break;
        default:
          break;
      }
    }

    if(isDefined(var_2._id_039B)) {
      level._id_4E4C[var_2._id_039B] = var_2;
      continue;
    }

    level._id_4E4C[level._id_4E4C.size] = var_2;
  }
}

_id_4DFF(var_0) {
  var_1 = level._id_4E4C[var_0];

  if(isDefined(var_1._id_AC2B)) {
    return;
  }
  var_1._id_AC2B = 1;
  wait 0.8;
  thread scripts\engine\utility::_id_B2DA("mp_ftue_door_open_chainlink", var_1.origin + (0, 0, 30));
  var_1 rotateto(var_1.openangles, 1, 0.2, 0.8);
}

_id_4DD1(var_0) {
  var_1 = level._id_4E4C[var_0];

  if(!isDefined(var_1._id_AC2B)) {
    return;
  }
  var_1._id_AC2B = undefined;
  var_1 rotateto(var_1._id_39D6, 0.3, 0.15, 0.15);
}

popuptargets_init() {
  level.shooting_targets = [];
  level.targetsshot = 0;
  var_0 = getEntArray("danger_target", "targetname");

  foreach(var_2 in getEntArray("danger_target_2", "targetname")) {
    var_0[var_0.size] = var_2;
  }

  var_4 = getEntArray("target_data_up", "targetname");
  var_5 = getEntArray("target_data_down", "targetname");
  var_6 = getEntArray("target_data_left", "targetname");
  var_7 = getEntArray("target_data_right", "targetname");

  foreach(var_9 in var_0) {
    var_9.target_type = var_9._id_0481;
    var_9.up_angles = var_9.angles;
    var_9._id_4EAF = var_9.angles - (90, 0, 0);
    var_9.down_pos = var_9.origin;
    var_9.up_pos = var_9.origin;
    var_10 = getEntArray(var_9.target, "targetname");

    foreach(var_2 in var_10) {
      switch (var_2.classname) {
        case "script_model":
          var_9._id_B1DB = var_2;
          break;
        case "script_brushmodel":
          if(!scripts\engine\utility::is_equal(var_2._id_039B, "paper")) {
            var_9._id_3A5F = var_2;
          }

          break;
        default:
          break;
      }
    }

    foreach(var_2 in var_10) {
      if(scripts\engine\utility::is_equal(var_2._id_039B, "paper")) {
        var_2 linkto(var_9);
      }
    }

    var_15 = strtok(var_9._id_039B, ",");

    foreach(var_17 in var_15) {
      foreach(var_2 in var_4) {
        if(var_2._id_039B == var_17) {
          var_9.up_pos = var_2.origin;
          var_9.up_angles = var_2.angles;
          break;
        }
      }

      foreach(var_2 in var_5) {
        if(var_2._id_039B == var_17) {
          var_9.down_pos = var_2.origin;
          var_9._id_4EAF = var_2.angles;
          break;
        }
      }

      foreach(var_2 in var_6) {
        if(var_2._id_039B == var_17) {
          var_9.left_pos = var_2.origin;
          break;
        }
      }

      foreach(var_2 in var_7) {
        if(var_2._id_039B == var_17) {
          var_9.right_pos = var_2.origin;
          break;
        }
      }
    }

    var_9._id_B1DB linkto(var_9);
    var_9._id_E747 = "down";
    var_9.angles = var_9._id_4EAF;
    var_9.origin = var_9.down_pos;
    level.shooting_targets[level.shooting_targets.size] = var_9;
    var_9 thread popuptarget_handledamage();
  }
}

popuptarget_get_group(var_0) {
  var_1 = [];

  foreach(var_3 in level.shooting_targets) {
    foreach(var_5 in strtok(var_3._id_039B, ",")) {
      if(scripts\engine\utility::is_equal(var_0, var_5)) {
        var_1[var_1.size] = var_3;
        break;
      }
    }
  }

  return var_1;
}

popuptarget_get_targets(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_1.size] = popuptarget_get_group(var_3);
  }

  return scripts\engine\utility::_id_1B9B(var_1);
}

popuptarget_flip(var_0, var_1, var_2, var_3) {
  if(self._id_E747 == var_0) {
    return;
  }
  if(isDefined(self._id_8939)) {
    return;
  }
  self._id_8939 = 1;
  self._id_E747 = var_0;

  if(!isDefined(var_3)) {
    var_3 = 0.3;
  }

  if(var_0 == "up") {
    switch (self.target_type) {
      case "danger_target":
        self.head_icon_offset = 78;
        break;
      case "danger_target_2":
        self.head_icon_offset = 64;
        break;
      default:
    }

    self._id_3A5F solid();

    if(isDefined(self.left_pos) && isDefined(self.right_pos)) {
      if(randomint(2) == 0) {
        self.up_pos = self.left_pos;
        self.move_direction = 0;
      } else {
        self.up_pos = self.right_pos;
        self.move_direction = 1;
      }

      self.origin = (self.up_pos[0], self.up_pos[1], self.down_pos[2]);
    }

    self rotateto(self.up_angles, var_3, var_3 * 0.9, var_3 * 0.1);
    self moveto(self.up_pos, var_3, var_3 * 0.9, var_3 * 0.1);
    self playSound("mp_ftue_target_raise");
    self._id_B1DB setCanDamage(1);
    self._id_3A5F _meth_80D1();
    popuptarget_add_marker();
  } else if(var_0 == "down") {
    self._id_3A5F _meth_80A2();
    self._id_3A5F notsolid();
    popuptarget_remove_marker();

    if(isDefined(self.left_pos) && isDefined(self.right_pos)) {
      self.down_pos = (self.origin[0], self.origin[1], self.down_pos[2]);
    }

    self rotateto(self._id_4EAF, var_3, var_3 * 0.9, var_3 * 0.1);
    self moveto(self.down_pos, var_3, var_3 * 0.9, var_3 * 0.1);
    self playSound("mp_ftue_target_lower");
  }

  wait(var_3);
  self._id_8939 = undefined;
}

popuptargets_raise(var_0) {
  foreach(var_2 in var_0) {
    while(istrue(var_2._id_8939)) {
      waitframe();
    }

    if(var_2._id_E747 == "down") {
      var_2 popuptarget_flip("up");
    }
  }
}

popuptargets_lower(var_0) {
  foreach(var_2 in var_0) {
    while(istrue(var_2._id_8939)) {
      waitframe();
    }

    if(var_2._id_E747 == "up") {
      var_2 popuptarget_flip("down");
    }
  }
}

popuptarget_handledamage() {
  if(istrue(self.isactive)) {
    return;
  }
  self.isactive = 1;
  self._id_7375 = undefined;
  self._id_753A = undefined;
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self.left_pos) && isDefined(self.right_pos)) {
    thread popuptarget_handlemovement();
  }

  for(;;) {
    self._id_B1DB waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isPlayer(var_3)) {
      if(isDefined(var_6)) {
        if(scripts\engine\utility::_id_8794(var_6)) {
          if(!var_3 scripts\mp\utility\player::_id_8989()) {
            level scripts\engine\utility::_id_5C1B("flag_player_hit_target_with_hip_fire");
          } else {
            level scripts\engine\utility::_id_5C1B("flag_player_hit_target_with_ads");
          }

          var_12 = 0;

          if(var_3 _meth_826F() >= 0.5) {
            level scripts\engine\utility::_id_5C1B("flag_player_hit_target_while_mounted");
            var_12 = 1;
          }

          var_13 = 0;

          if(var_3 _meth_8271() != "mount_none") {
            level scripts\engine\utility::_id_5C1B("flag_player_hit_target_blindfire");
            var_13 = 1;
          }

          if(var_12 && var_13) {
            level scripts\engine\utility::_id_5C1B("flag_player_hit_target_mounted_blindfire");
          }

          level.last_popuptarget_hit = self;
        }
      }

      var_3 thread _id_07C4::_id_FC86("standard", 1);
      self._id_B1DB playSound("mp_ftue_target_hit_mtl_swtnr");
      self._id_B1DB playSound("ui_hitmarker_default");
    }

    if(self._id_E747 == "up" && (!isDefined(self._id_753A) || !self._id_753A)) {
      thread popuptarget_flip("down", var_11, var_3);
      level notify("flag_popup_target_hit");

      if(scripts\engine\utility::_id_5C00("player_shot_first_target_group") && level.targetsshot >= 3 && !level.voqueue.size) {
        level notify("goodJobPlayer");
        level.targetsshot = 0;
      }
    }
  }
}

popuptarget_handlemovement() {
  if(!isDefined(self.left_pos) || !isDefined(self.right_pos)) {
    return;
  }
  for(;;) {
    if(self._id_E747 == "up" && !(isDefined(self._id_8939) && self._id_8939)) {
      if(!isDefined(self._id_A1FD)) {
        self._id_A1FD = 30.0;
      }

      var_0 = distance(self.left_pos, self.right_pos);
      var_1 = var_0 / self._id_A1FD;

      switch (self.move_direction) {
        case 0:
          self moveto(self.right_pos, var_1, 1.0, 1.0);
          self.move_direction = 1;
          break;
        case 1:
          self moveto(self.left_pos, var_1, 1.0, 1.0);
          self.move_direction = 0;
          break;
        default:
          break;
      }

      wait(var_1 + 1.0);
      continue;
    }

    wait 1.0;
  }
}

popuptarget_add_marker() {
  if(isDefined("hud_icon_nameplate_chevron_enemy")) {
    if(isDefined(self._id_75DD)) {}

    self._id_75DD = _func_0353(self._id_B1DB);
    _func_0355(self._id_75DD, "hud_icon_nameplate_chevron_enemy");
    _func_0364(self._id_75DD, "axis");
    _func_0480(self._id_75DD, 1);
    _func_035D(self._id_75DD, self.head_icon_offset);
    _func_035B(self._id_75DD, 1);
    _func_035C(self._id_75DD, 1);
  }
}

popuptarget_remove_marker() {
  if(isDefined(self._id_75DD)) {
    _func_0354(self._id_75DD);
    self._id_75DD = undefined;
  }
}

show_hud_tutorial_message(var_0) {
  if(isDefined(level.last_hud_tutorial_time)) {
    var_1 = gettime() - level.last_hud_tutorial_time;
  } else {
    var_1 = 1000;
  }

  if(var_1 > 500) {
    var_2 = "ui_mp_ftue_notify_sml";
  } else {
    var_2 = "ui_mp_ftue_notify_lrg";
  }

  self playlocalsound(var_2);
  self sethudtutorialmessage(var_0);
  level.last_hud_tutorial_time = gettime();
  level.last_hud_tutorial_str = var_0;
}

cycle_hud_tutorial_messages_think(var_0, var_1, var_2, var_3) {
  level scripts\engine\utility::_id_5C04("flag_end_hud_tutorial_messages");
  var_4 = 0;

  if(isDefined(var_3)) {
    level scripts\engine\utility::_id_1070F("flag_end_hud_tutorial_messages", var_3);
  }

  while(!scripts\engine\utility::_id_5C00("flag_end_hud_tutorial_messages")) {
    if(var_4 < var_0.size) {
      show_hud_tutorial_message(var_0[var_4]);
      level scripts\engine\utility::_id_1070F("flag_end_hud_tutorial_messages", var_1);
      clear_hud_tutorial_message(var_0[var_4]);
      wait 0.6;
      var_4++;
      continue;
    }

    if(istrue(var_2)) {
      var_4 = 0;
      continue;
    }

    level scripts\engine\utility::_id_5C1B("flag_end_hud_tutorial_messages");
  }
}

clear_all_hud_tutorial_messages(var_0) {
  level scripts\engine\utility::_id_5C1B("flag_end_hud_tutorial_messages");
  var_0 = istrue(var_0);
  self clearhudtutorialmessage(var_0);
  level.last_hud_tutorial_time = undefined;
  level.last_hud_tutorial_str = undefined;
}

clear_hud_tutorial_message(var_0, var_1) {
  var_1 = istrue(var_1);

  if(scripts\engine\utility::is_equal(var_0, level.last_hud_tutorial_str)) {
    self clearhudtutorialmessage(var_1);
    level.last_hud_tutorial_time = undefined;
    level.last_hud_tutorial_str = undefined;
  }
}

_id_B218(var_0) {
  _id_0A8D::_id_9137(var_0, "ftue", 1);
  level scripts\engine\utility::_id_5C1B("flag_butcher_" + var_0);
  level.last_dialogue_id = tolower(var_0);
  level.current_dialogue_length = _func_0142("mp_glob_ftue_bchr_" + level.last_dialogue_id);
  level.current_dialogue_starttime = gettime();
}

is_dialogue_playing(var_0) {
  return get_remaining_dialogue_time(var_0) > 0.0;
}

get_current_dialogue() {
  if(!is_dialogue_playing()) {
    return undefined;
  }

  return level.current_dialogue_id;
}

get_remaining_dialogue_time(var_0) {
  if(isDefined(level.current_dialogue_length) && isDefined(level.current_dialogue_starttime)) {
    var_1 = level.current_dialogue_starttime + level.current_dialogue_length - gettime();

    if(isDefined(var_0)) {
      var_1 = var_1 + var_0 * 1000.0;
    }

    return max(0.0, var_1 / 1000.0);
  }

  return 0.0;
}

wait_for_dialogue(var_0, var_1) {
  if(isDefined(level.current_dialogue_length) && isDefined(level.current_dialogue_starttime)) {
    var_2 = level.current_dialogue_length;

    if(isDefined(var_1)) {
      var_2 = min(var_2, var_1 * 1000.0);
    }

    var_3 = level.current_dialogue_starttime + var_2 - gettime();

    if(isDefined(var_0)) {
      var_3 = var_3 + var_0 * 1000.0;
    }

    if(var_3 > 0.0) {
      wait(var_3 / 1000.0);
    }
  }
}

temp_subtitle(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = -50;
  var_2 settext(var_0);
  var_2.fontscale = 1.46;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "bottom";
  var_2.sort = 1;

  if(!isDefined(var_1)) {
    var_1 = 3.0;
  }

  scripts\engine\utility::_id_1070F("flag_terminate_subtitle", var_1);
  var_2 destroy();
  level notify("flag_subtitle_finished");
}

prompt_to_invert_controls(var_0) {
  level scripts\engine\utility::_id_5C1B("flag_allow_context_menu");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!level scripts\engine\utility::_id_5C00("flag_allow_context_menu")) {
    return;
  }
  self allowmovement(0);
  show_hud_tutorial_message(&"MP_M_FTUE/INVERT_PROMPT");
  level _id_000F::_id_990C("player_wants_inverted_controls", ::_notifywantsinvertedcontrols);
  _id_06D5::_id_DC2C("invert_controls");
  self waittill("inverted_controls_message_received");
  clear_all_hud_tutorial_messages();
  wait 0.5;

  if(scripts\engine\utility::_id_546E("player_wants_inverted_controls")) {
    scripts\engine\utility::_id_5470("player_wants_inverted_controls", 1);
    show_hud_tutorial_message(&"MP_M_FTUE/KEEP_INVERTED_MSG");
    _id_06D5::_id_DC2C("invert_controls_confirm");
    self waittill("inverted_controls_message_received");
    clear_all_hud_tutorial_messages();
    scripts\engine\utility::_id_5470("player_wants_inverted_controls", 1);
  }

  self allowmovement(1);
  waitframe();
}

_notifywantsinvertedcontrols(var_0) {
  if(var_0) {
    scripts\engine\utility::_id_5474("player_wants_inverted_controls");
  }

  self notify("inverted_controls_message_received");
}

monitor_reload_think() {
  while(!self _meth_81E0()) {
    wait 0.1;
  }

  level scripts\engine\utility::_id_5C1B("flag_player_reloaded");
}

monitor_sprint_think() {
  while(!self issprinting()) {
    wait 0.1;
  }

  level scripts\engine\utility::_id_5C1B("flag_player_sprinted");
}

monitor_tactical_sprint_think() {
  while(!self _meth_81E6()) {
    wait 0.1;
  }

  level scripts\engine\utility::_id_5C1B("flag_player_tactical_sprinted");
}

monitor_player_using_rifle() {
  while(isnullweapon(level.player getcurrentweapon()) || level.player getcurrentweapon().classname != "rifle") {
    var_0 = level.player getweaponslistprimaries();

    foreach(var_2 in var_0) {
      if(var_2.classname == "rifle") {
        level.player switchtoweapon(var_2.basename);
        level.player _meth_819C(var_2);
        break;
      }
    }

    wait 0.1;
  }

  level.player disableweaponswitch();
  level scripts\engine\utility::_id_5C1B("flag_player_using_rifle");
}

monitor_move_while_mounted_think() {
  while(level.player _meth_826F() < 0.75 || length(level.player getnormalizedmovement()) < 0.25) {
    waitframe();
  }

  level scripts\engine\utility::_id_5C1B("flag_player_moved_while_mounted");
}

monitor_player_ads() {
  while(level.player playerads() < 0.5) {
    waitframe();
  }

  level scripts\engine\utility::_id_5C1B("flag_player_used_ads");
}

monitor_player_mantle() {
  while(!level.player _meth_81CE()) {
    waitframe();
  }

  level scripts\engine\utility::_id_5C1B("flag_player_mantled");
}

monitor_player_ammo() {
  for(;;) {
    wait 1;

    if(isnullweapon(level.player getcurrentweapon())) {
      continue;
    }
    var_0 = level.player getcurrentweapon();

    if(var_0.classname != "rifle") {
      continue;
    }
    if(level.player getweaponammostock(var_0) == 0) {
      level.player givemaxammo(var_0);
    }
  }
}

checkplayerusingrifle() {
  while(isnullweapon(level.player getcurrentweapon())) {
    waitframe();
  }

  return level.player getcurrentweapon().classname == "rifle";
}

manage_ads_hint() {
  if(level scripts\engine\utility::_id_5C00("flag_allow_ads_hint")) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("flag_allow_ads_hint");
  var_0 = get_ads_toggle_string();
  show_hud_tutorial_message(var_0);

  while(level scripts\engine\utility::_id_5C00("flag_allow_ads_hint")) {
    var_1 = self _meth_863A() > 0.5;

    if(!var_1) {
      var_2 = get_ads_toggle_string();

      if(var_0 != var_2) {
        var_0 = var_2;
        show_hud_tutorial_message(var_0);
      }
    } else if(var_0 != &"MP_M_FTUE/SHOOT") {
      var_0 = &"MP_M_FTUE/SHOOT";
      show_hud_tutorial_message(var_0);
    }

    if(var_1 && !is_dialogue_playing(0.6) && !level scripts\engine\utility::_id_5C00("flag_butcher_nowshooteachtargetwh")) {
      _id_B218("nowshooteachtargetwh");
    }

    waitframe();
  }

  clear_all_hud_tutorial_messages();
}

manage_sprint_hint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(level scripts\engine\utility::_id_5C00("flag_allow_sprint_hint")) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("flag_allow_sprint_hint");

  while(self getnormalizedmovement() == (0, 0, 0)) {
    wait 0.25;
  }

  waitframe();
  wait_for_dialogue(2.0);

  if(level scripts\engine\utility::_id_5C00("flag_player_sprinted") || !level scripts\engine\utility::_id_5C00("flag_allow_sprint_hint")) {
    return;
  }
  show_hud_tutorial_message(&"MP_M_FTUE/SPRINT");

  if(var_0 && !level scripts\engine\utility::_id_5C00("flag_butcher_trysprintingthiswari")) {
    _id_B218("trysprintingthiswari");
  }

  level scripts\engine\utility::_id_5C24("flag_player_sprinted");
  clear_hud_tutorial_message(&"MP_M_FTUE/SPRINT");
}

manage_tactical_sprint_hint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(level scripts\engine\utility::_id_5C00("flag_allow_sprint_hint")) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("flag_allow_sprint_hint");

  while(self getnormalizedmovement() == (0, 0, 0)) {
    wait 0.25;
  }

  waitframe();
  wait_for_dialogue(1.0);

  if(!level scripts\engine\utility::_id_5C00("player_inside_end_sprint_trigger")) {
    level waittill("player_inside_end_sprint_trigger");
  }

  if(!level scripts\engine\utility::_id_5C00("flag_allow_sprint_hint")) {
    return;
  }
  var_1 = set_tactical_sprint_tutorial_string();

  if(get_tactical_sprint_option() != 2) {
    show_hud_tutorial_message(var_1);
  }

  if(var_0 && !level scripts\engine\utility::_id_5C00("flag_butcher_trysprintingthiswari")) {
    _id_B218("trysprintingthiswari");
  }

  level scripts\engine\utility::_id_5C24("flag_player_tactical_sprinted");

  if(get_tactical_sprint_option() != 2) {
    clear_hud_tutorial_message(var_1);
  }
}

manage_mantle_hint() {
  wait_for_dialogue(1.0);

  if(level scripts\engine\utility::_id_5C00("flag_player_mantled")) {
    return;
  }
  show_hud_tutorial_message(&"MP_M_FTUE/MANTLE");
  level waittill("flag_player_mantled");
  clear_hud_tutorial_message(&"MP_M_FTUE/MANTLE");
}

player_inside_end_sprint_trigger_think() {
  var_0 = getent("trigger_goto_end_0", "targetname");
  level scripts\engine\utility::_id_5C04("player_inside_end_sprint_trigger");
  var_1 = self;

  for(;;) {
    var_0 waittill("trigger", var_1);
    level scripts\engine\utility::_id_5C1B("player_inside_end_sprint_trigger");

    for(var_2 = ""; var_2 != "timeout"; var_2 = var_0 scripts\engine\utility::_id_108F7("trigger", 0.1)) {}

    level scripts\engine\utility::_id_5C04("player_inside_end_sprint_trigger");
  }
}

tutonplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isbot(self)) {
    return;
  }
  exit_level();
}

exit_level(var_0, var_1, var_2) {
  level.player clear_all_hud_tutorial_messages(1);

  if(!isDefined(var_2) || var_2 == 0) {
    level notify("exitLevel_called");
    exitlevel(0);
  }
}

_id_58A6(var_0, var_1) {
  self.fadeoverlay = newclienthudelem(self);
  self.fadeoverlay.x = 0;
  self.fadeoverlay.y = 0;
  self.fadeoverlay setshader("black", 640, 480);
  self.fadeoverlay.alignx = "left";
  self.fadeoverlay.aligny = "top";
  self.fadeoverlay.horzalign = "fullscreen";
  self.fadeoverlay.vertalign = "fullscreen";
  self.fadeoverlay.alpha = 1;

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self.fadeoverlay fadeovertime(var_0);
  self.fadeoverlay.alpha = 0;
}

_id_58A8(var_0) {
  self.fadeoverlay = newclienthudelem(self);
  self.fadeoverlay.x = 0;
  self.fadeoverlay.y = 0;
  self.fadeoverlay setshader("black", 640, 480);
  self.fadeoverlay.alignx = "left";
  self.fadeoverlay.aligny = "top";
  self.fadeoverlay.horzalign = "fullscreen";
  self.fadeoverlay.vertalign = "fullscreen";
  self.fadeoverlay.alpha = 0;
  self.fadeoverlay fadeovertime(var_0);
  self.fadeoverlay.alpha = 1;
}

set_crouch_tutorial_string() {
  var_0 = scripts\engine\utility::_id_C578("crouchType");
  var_1 = &"MP_M_FTUE/CROUCH";

  if(!self usinggamepad() && var_0 == 2) {
    var_1 = &"MP_M_FTUE/CROUCH_HOLD";
  }

  return var_1;
}

get_tactical_sprint_option() {
  if(self usinggamepad()) {
    var_0 = scripts\engine\utility::_id_C578("autoSprintGamepad");
  } else {
    var_0 = scripts\engine\utility::_id_C578("autoSprintKBM");
  }

  return var_0;
}

is_sprint_option_hold() {
  if(self usinggamepad()) {
    var_0 = scripts\engine\utility::_id_C578("holdSprintGamepad");
  } else {
    var_0 = scripts\engine\utility::_id_C578("holdSprintKeyboard");
  }

  return var_0;
}

set_tactical_sprint_tutorial_string() {
  var_0 = get_tactical_sprint_option();
  var_1 = is_sprint_option_hold();
  var_2 = &"MP_M_FTUE/TACTICAL_SPRINT";

  if(self usinggamepad()) {
    if(var_1) {
      var_2 = &"MP_M_FTUE/TACTICAL_SPRINT_DPRESS_HOLD";
    } else if(var_0 == 0) {
      var_2 = &"MP_M_FTUE/TACTICAL_SPRINT_PRESS_DPRESS";
    }
  } else if(var_1) {
    if(var_0 == 0) {
      var_2 = &"MP_M_FTUE/TACTICAL_SPRINT_DPRESS_HOLD";
    } else {
      var_2 = &"MP_M_FTUE/TACTICAL_SPRINT_HOLD";
    }
  } else if(var_0 == 1)
    var_2 = &"MP_M_FTUE/TACTICAL_SPRINT_PRESS";

  return var_2;
}