/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2442.gsc
*************************************************/

init() {
  level._effect["zm_teleport_intro"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_1p.vfx");
  level._effect["zm_teleport_end"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_end_1p.vfx");
  level._effect["zm_teleport_intro_blue"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_blue_1p.vfx");
  level._effect["zm_teleport_end_blue"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_end_blue_1p.vfx");
  level._effect["zm_teleport_intro_green"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_green_1p.vfx");
  level._effect["zm_teleport_end_green"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_end_green_1p.vfx");
}

_id_F028() {}

_id_7965(var_0, var_1) {
  return &"CP_ZMB_INTERACTIONS/ENTER_PORTAL";
}

_id_E21B(var_0) {
  var_1 = var_0[0];

  if(isDefined(var_1)) {
    level thread _id_E0E4(var_1);
  }
}

_id_E0E4(var_0) {
  var_1 = 100;
  var_2 = _id_06EF::_id_E1E5(var_0, "s4_zm_portal_01", 1);
  var_2._id_A8DB = var_0._id_A906;
  var_3 = (0, 0, 32);
  var_4 = _id_06EF::_id_E170(var_0, ::_id_FDC1, &"ZOMBIES/BEACON_PROMPT", undefined, var_1, undefined, undefined, var_3);
  var_4._id_E9E6 = &"ZOMBIES/BEACON_PROMPT";
  var_4 _meth_8426(0);
  var_4._id_CF8F = var_2;
  var_2.trigger = var_4;
  level._id_EC5B = var_4;
  var_5 = level scripts\engine\utility::_id_1087F("start_exfil", "portal_activated");
  var_4 delete();
}

_id_FDC1(var_0) {
  var_1 = var_0._id_0025;
  var_2 = self._id_CF8F;
}

_id_0FFF(var_0) {
  level._id_0DEF = scripts\engine\utility::array_add(level._id_0DEF, var_0);
}

_id_C419(var_0) {
  level._id_0DEF = scripts\engine\utility::array_remove(level._id_0DEF, var_0);
}

_id_3867(var_0, var_1, var_2) {
  self notify("beacon_dist_endon");
}

_id_246F(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  self endon("beacon_dist_endon");
  var_2 = self.origin;

  while(distance2d(self.origin, var_2) < 32) {
    waitframe();

    if(!isDefined(var_0)) {
      break;
    }
  }
}

_id_3861() {
  self notify("srOverlayOpened");
  _id_0774::force_close_pap_menu();
  _id_0717::close_covenant_store();
  _id_0718::force_close_crafting_menu();
}

_id_59C9(var_0) {
  _id_3861();
  level._id_A37B = 5;
  _id_098B::_id_59C8(undefined, undefined, undefined, "survival_next_dest", var_0, undefined, undefined, 1, 1, 0, undefined, 1);
}

_id_2471() {}

get_transient_for_destination(var_0, var_1) {
  if(!level.destinationstreamingenabled) {
    return "";
  }

  if(isDefined(var_1) && var_1 == "start_interact") {
    return level.hubdestination;
  } else if(isDefined(var_0) && isDefined(var_0._id_96CF) && isDefined(var_0._id_96CF._id_4823) && isDefined(var_0._id_96CF._id_4823._id_CE88)) {
    return var_0._id_96CF._id_4823._id_CE88;
  }

  return "";
}

_id_109FC(var_0, var_1) {
  level endon("begin_game_ended");

  if(level scripts\engine\utility::_id_5C00("beacon_trigger_used")) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("beacon_trigger_used");
  var_2 = 1;

  if(!var_2) {
    level scripts\engine\utility::_id_5C04("beacon_trigger_used");
    return;
  }

  if(scripts\engine\utility::is_equal(var_0._id_3BE5, "exfil")) {
    level scripts\engine\utility::_id_5C04("beacon_trigger_used");
    return;
  }

  var_3 = 10;
  level thread portal_screen_distortion();

  foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
    var_5 thread reset_portal_screen_fx_on_disconnect();
    var_5 thread reset_portal_screen_fx_on_game_end();

    if(isDefined(level.str_portal_first_person_effect_label_override)) {
      playFXOnTag(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), var_5, "j_head");
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx("zm_teleport_intro"), var_5, "j_head");
  }

  level._id_0C35 = 1;
  level notify("portal_countdown_started");
  level thread _id_2471();

  foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
    var_5 playSound("zmb_pre_teleport_rise");
  }

  wait(var_3);

  foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
    var_5 playSound("zmb_teleport_start");
  }

  var_11 = _id_0987::_id_6692(var_0);
  level scripts\engine\utility::_id_5C04("beacon_trigger_used");
  _func_0343();
  level notify("portal_activated");

  if(var_11.size > 0) {
    var_12 = scripts\cp\utility::_id_6C5C();

    for(var_13 = 0; var_13 < var_12.size; var_13++) {
      if(isalive(var_12[var_13])) {
        var_14 = var_13;

        if(var_14 >= var_11.size) {
          var_14 = var_11.size - 1;
        }

        var_12[var_13] _meth_86A3(var_11[var_14].origin, 1);
      }
    }
  }

  if(scripts\engine\utility::is_equal(getdvarint("#x34fad450704810a5c", 0), 0)) {
    var_15 = get_transient_for_destination(var_0, var_1);

    if(var_15.size > 0 && scripts\cp\cp_destinations::get_loaded_destination() != var_15) {
      scripts\cp\cp_destinations::unload_current_destination();
      scripts\cp\cp_destinations::load_destination(var_15);
    }
  }

  level._id_0C35 = undefined;
  level._id_2030 = scripts\cp\utility::_id_459B(level._id_2030, 1);

  foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
    if(isalive(var_5)) {
      var_5 thread _id_59C9(var_11[0]);

      if(var_11.size > 1) {
        var_11 = scripts\engine\utility::array_remove_index(var_11, 0, 0);
      }

      var_5._id_8F1F = var_5 getcurrentweapon();
    }
  }

  var_0.a_unused_player_spawn_pts = var_11;
  var_18 = 1;

  while(var_18) {
    var_18 = 0;

    foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
      if(istrue(var_5._id_2031)) {
        var_18 = 1;
        break;
      }
    }

    if(!var_18) {
      break;
    }

    wait 0.1;
  }

  foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
    var_5 playSound("zmb_teleport_end");
    var_5 _meth_86A4();
  }

  scripts\cp\cp_destinations::wait_for_current_destination_to_load();
  level notify("portal_warp_finished");
  level thread exit_portal_screen_fx();
}

warp_for_rbz(var_0, var_1) {
  level endon("begin_game_ended");
  var_2 = 10;
  level thread portal_screen_distortion();

  foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
    var_4 thread reset_portal_screen_fx_on_disconnect();
    var_4 thread reset_portal_screen_fx_on_game_end();

    if(isDefined(level.str_portal_first_person_effect_label_override)) {
      playFXOnTag(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), var_4, "j_head");
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx("zm_teleport_intro"), var_4, "j_head");
  }

  foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
    var_4 playSound("zmb_pre_teleport_rise");
  }

  wait(var_2);

  foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
    var_4 playSound("zmb_teleport_start");
  }

  level scripts\engine\utility::_id_5C04("beacon_trigger_used");
  _func_0343();
  level notify("portal_activated");

  if(var_0.size > 0) {
    var_10 = scripts\cp\utility::_id_6C5C();

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(isalive(var_10[var_11])) {
        var_12 = var_11;

        if(var_12 >= var_0.size) {
          var_12 = var_0.size - 1;
        }

        var_10[var_11] _meth_86A3(var_0[var_12].origin, 1);
      }
    }
  }

  if(scripts\engine\utility::is_equal(getdvarint("#x34fad450704810a5c", 0), 0)) {
    if(scripts\cp\cp_destinations::get_loaded_destination() != var_1) {
      scripts\cp\cp_destinations::unload_current_destination();
      scripts\cp\cp_destinations::load_destination(var_1);
    }
  }

  level._id_2030 = scripts\cp\utility::_id_459B(level._id_2030, 1);

  foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
    if(isalive(var_4)) {
      var_4 thread _id_59C9(var_0[0]);

      if(var_0.size > 1) {
        var_0 = scripts\engine\utility::array_remove_index(var_0, 0, 0);
      }

      var_4._id_8F1F = var_4 getcurrentweapon();
    }
  }

  var_15 = 1;

  while(var_15) {
    var_15 = 0;

    foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
      if(istrue(var_4._id_2031)) {
        var_15 = 1;
        break;
      }
    }

    if(!var_15) {
      break;
    }

    wait 0.1;
  }

  foreach(var_4 in scripts\cp\utility::_id_6C5C()) {
    var_4 playSound("zmb_teleport_end");
    var_4 _meth_86A4();
  }

  scripts\cp\cp_destinations::wait_for_current_destination_to_load();
  level notify("portal_warp_finished");
  level thread exit_portal_screen_fx();
}

warp_sepcific_player(var_0, var_1, var_2) {
  level endon("begin_game_ended");
  var_1 thread portal_screen_distortion_on_specific_player();
  var_1 thread reset_portal_screen_fx_on_disconnect_client();
  var_1 thread reset_portal_screen_fx_on_game_end_client();

  if(isDefined(level.str_portal_first_person_effect_label_override)) {
    _func_019D(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), var_1, "j_head", var_1);
  } else {
    _func_019D(scripts\engine\utility::getfx("zm_teleport_intro"), var_1, "j_head", var_1);
  }

  var_1 playSound("zmb_pre_teleport_rise");
  wait 10;

  if(!isPlayer(var_1)) {
    return;
  }
  if(isDefined(level.str_portal_first_person_effect_label_override)) {
    _func_02D1(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), var_1, "j_head", var_1);
  } else {
    _func_02D1(scripts\engine\utility::getfx("zm_teleport_intro"), var_1, "j_head", var_1);
  }

  var_1 playSound("zmb_teleport_start");
  var_3 = 0;

  if(var_0.size > 0) {
    var_4 = scripts\cp\utility::_id_6C5C();

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(isalive(var_4[var_5])) {
        var_6 = var_5;

        if(var_6 >= var_0.size) {
          var_6 = var_0.size - 1;
        }

        var_4[var_5] _meth_86A3(var_0[var_6].origin, 1);
      }

      if(var_1 == var_4[var_5]) {
        var_3 = var_5;
      }
    }
  }

  level._id_2030 = scripts\cp\utility::_id_459B(level._id_2030, 1);

  if(isalive(var_1)) {
    level._id_A37B = 5;
    var_1 _id_098B::_id_59C8(undefined, undefined, undefined, "survival_next_dest", var_0[var_3], undefined, undefined, 1, 1, 0, undefined, 1);
  }

  var_7 = 1;

  while(var_7) {
    var_7 = 0;

    if(istrue(var_1._id_2031)) {
      var_7 = 1;
      break;
    }

    if(!var_7) {
      break;
    }

    wait 0.1;
  }

  if(istrue(var_2)) {
    scripts\cp\cp_destinations::wait_for_current_destination_to_load();
  }

  var_1 playSound("zmb_teleport_end");
  var_1 _meth_86A4();
  level notify("portal_warp_finished");
  var_1 thread exit_portal_screen_fx_on_specific_player();
}

portal_screen_distortion() {
  level endon("begin_game_ended");
  var_0 = 0;
  var_1 = gettime();
  var_2 = 0.5;
  var_3 = 0;
  var_4 = 0.5;
  var_5 = 0.5;
  var_6 = 0;
  var_7 = 0.5;
  var_8 = 0;
  var_9 = 0.05;
  var_10 = 0.5;
  var_11 = -1.0;
  var_12 = 1;
  var_13 = 0.5;
  setDvar("#x320c6aa95071ea85d", var_2);
  setDvar("#x31f9ba2c1834330ea", var_3);
  setDvar("#x329d798d8baa02cac", var_4);

  while(var_0 < 9775) {
    var_0 = gettime() - var_1;
    var_14 = var_0 / 9775;
    setDvar("#x320c6aa95071ea85d", var_5 + (var_8 - var_5) * var_14);
    setDvar("#x31f9ba2c1834330ea", var_6 + (var_9 - var_6) * var_14);
    setDvar("#x329d798d8baa02cac", var_7 + (var_10 - var_7) * var_14);
    wait 0.01;
  }

  setDvar("#x320c6aa95071ea85d", var_8);
  setDvar("#x31f9ba2c1834330ea", var_9);
  setDvar("#x329d798d8baa02cac", var_10);
  var_1 = gettime();
  var_0 = 0;

  while(var_0 < 300) {
    var_0 = gettime() - var_1;
    var_14 = var_0 / 300;
    setDvar("#x320c6aa95071ea85d", var_8 + (var_11 - var_8) * var_14);
    setDvar("#x31f9ba2c1834330ea", var_9 + (var_12 - var_9) * var_14);
    setDvar("#x329d798d8baa02cac", var_10 + (var_13 - var_10) * var_14);
    wait 0.01;
  }

  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
}

portal_screen_distortion_on_specific_player() {
  level endon("begin_game_ended");
  self setclientomnvar("portal_screen_distortion", 1);
}

exit_portal_screen_fx_on_specific_player() {
  level endon("begin_game_ended");
  self setclientomnvar("exit_portal_screen", 1);

  if(isDefined(level.str_portal_end_first_person_effect_label_override)) {
    _func_019D(scripts\engine\utility::getfx(level.str_portal_end_first_person_effect_label_override), self, "j_head", self);
  } else {
    _func_019D(scripts\engine\utility::getfx("zm_teleport_end"), self, "j_head", self);
  }
}

exit_portal_screen_fx() {
  level endon("begin_game_ended");
  var_0 = 0;
  var_1 = gettime();
  var_2 = -1.0;
  var_3 = 1;
  var_4 = 0.5;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  foreach(var_9 in scripts\cp\utility::_id_6C5C()) {
    if(isDefined(level.str_portal_end_first_person_effect_label_override)) {
      playFXOnTag(scripts\engine\utility::getfx(level.str_portal_end_first_person_effect_label_override), var_9, "j_head");
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx("zm_teleport_end"), var_9, "j_head");
  }

  setDvar("#x320c6aa95071ea85d", var_2);
  setDvar("#x31f9ba2c1834330ea", var_3);
  setDvar("#x329d798d8baa02cac", var_4);

  while(var_0 < 250) {
    var_0 = gettime() - var_1;
    var_11 = var_0 / 250;
    setDvar("#x320c6aa95071ea85d", var_2 + (var_5 - var_2) * var_11);
    setDvar("#x31f9ba2c1834330ea", var_3 + (var_6 - var_3) * var_11);
    setDvar("#x329d798d8baa02cac", var_4 + (var_7 - var_4) * var_11);
    wait 0.01;
  }

  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
}

reset_portal_screen_fx_on_disconnect() {
  level endon("players_landed");
  level endon("portal_warp_finished");
  scripts\engine\utility::waittill_any_2("disconnect", "begin_game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.str_portal_first_person_effect_label_override)) {
    stopFXOnTag(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), self, "j_head");
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("zm_teleport_intro"), self, "j_head");
  }

  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
}

reset_portal_screen_fx_on_disconnect_client() {
  level endon("players_landed");
  level endon("portal_warp_finished");
  scripts\engine\utility::waittill_any_2("disconnect", "begin_game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.str_portal_first_person_effect_label_override)) {
    _func_02D1(scripts\engine\utility::getfx(level.str_portal_first_person_effect_label_override), self, "j_head", self);
  } else {
    _func_02D1(scripts\engine\utility::getfx("zm_teleport_intro"), self, "j_head", self);
  }

  self setclientomnvar("reset_portal_screen", 1);
}

reset_portal_screen_fx_on_game_end() {
  level endon("players_landed");
  level endon("portal_warp_finished");
  level waittill("game_ended");
  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
}

reset_portal_screen_fx_on_game_end_client() {
  level endon("players_landed");
  level endon("portal_warp_finished");
  level waittill("game_ended");

  if(isDefined(self)) {
    self setclientomnvar("reset_portal_screen", 1);
  }
}

_id_2F0F(var_0) {
  if(level scripts\engine\utility::_id_5C00("beacon_trigger_used")) {
    return;
  }
  level scripts\engine\utility::_id_5C1B("beacon_trigger_used");
  var_1 = _id_0992::_id_106AF(self, "SURVIVAL/VOTE_PROMPT_EXFIL_HEADER", "SURVIVAL/VOTE_PROMPT_EXFIL_FAILED");

  if(!var_1) {
    level scripts\engine\utility::_id_5C04("beacon_trigger_used");
    _id_3867(var_0, var_0.trigger);
    return;
  }

  var_0._id_A8DB = undefined;
  wait 2;
  level scripts\engine\utility::_id_5C1B("start_exfil");
}

_id_2470(var_0, var_1) {
  self endon("srOverlayOpened");
  var_1 = undefined;

  if(isDefined(var_0._id_A8DB)) {}

  thread _id_246F(var_0, var_1);

  for(;;) {
    self waittill("menuresponse", var_2, var_3);

    if(var_2 == "sr_beacon_menu") {
      switch (var_3) {
        case "beacon_choice_warp":
          self notify("beacon_dist_endon");
          _id_3867(var_0, var_1, 1);
          thread _id_109FC(var_0);
          return;
        case "beacon_choice_exfil":
          self notify("beacon_dist_endon");
          _id_3867(var_0, var_1, 1);
          thread _id_2F0F(var_0);
          return;
        case "upgrade_menu_close":
          self notify("beacon_dist_endon");
          _id_3867(var_0, var_1);
          return;
        default:
          var_4 = level._id_0DEE[var_3];

          if(_func_03AC(var_4)) {
            self notify("beacon_dist_endon");
            _id_3867(var_0, var_1);
            self thread[[var_4]](var_0, var_1);
            return;
          }
      }
    }
  }
}

_id_0FFE(var_0, var_1) {
  level._id_0DEE[var_0] = var_1;
}

_id_C418(var_0) {
  level._id_0DEE[var_0] = undefined;
}