/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\phonebooth.gsc
***************************************************/

hint_phonebooth(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_0.powered_on)) {
    return &"CP_DISCO_INTERACTIONS_PHONEBOOTH_USE";
  }

  return &"COOP_INTERACTIONS_REQUIRES_POWER";
}

init_phonebooth() {
  level.phone = spawnStruct();
  level.phone.numbers["666"] = ::beast;
  level.phone.numbers["369686337"] = ::downunder;
  level.phone.numbers["49"] = ::iw;
  level.phone.numbers["736348"] = ::sendit;
  level.phone.numbers["69"] = ::prank;
  level.phone.numbers["2333"] = ::burgertown;
  level.phone.numbers["7399"] = ::crystal;
  level.phone.numbers["3323"] = ::deadwoman;
  level.phone.numbers["34726"] = ::disco;
  level.phone.numbers["411"] = ::info;
  level.phone.numbers["0"] = ::operator;
  level.phone.numbers["911"] = ::emergency;
  level.phone.numbers["232"] = ::cdc;
  level.phone.numbers["9328437"] = ::weather;
  level.phone.numbers["5550152"] = ::skullbuster;
  snd_setup();
  level.phone.booths = [];
  foreach(var_1 in scripts\engine\utility::getstructarray("phonebooth", "script_noteworthy")) {
    var_1 thread init_phone();
    wait(0.1);
  }
}

beast() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = randomint(2);
  var_1 = undefined;
  switch (var_0) {
    case 0:
      var_1 = "beast_01";
      break;

    case 1:
      var_1 = "beast_02";
      break;
  }

  playlocalsound_phone(var_1, 1, 1);
}

downunder() {
  thread playlocalsound_phone("ring_foreign");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_foreign");
  playlocalsound_phone("downunda");
}

iw() {
  wait(2);
  playlocalsound_phone("busy");
}

sendit() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  playlocalsound_phone("payphone_plr_fax_modem");
}

prank() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = randomint(5);
  var_1 = undefined;
  switch (var_0) {
    case 1:
    case 0:
      var_1 = "prank_call_02";
      break;

    case 2:
      var_1 = "prank_call_03";
      break;

    case 3:
      var_1 = "prank_call_04";
      break;

    case 4:
      var_1 = "prank_call_05";
      break;

    default:
      var_1 = "prank_call_05";
      break;
  }

  playlocalsound_phone(var_1, 1, 1);
}

burgertown() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = "burger_town";
  playlocalsound_phone(var_0, 1, 1);
}

crystal() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = "crystal";
  playlocalsound_phone(var_0, 1, 1);
}

deadwoman() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = "dead_woman";
  playlocalsound_phone(var_0, 1, 1);
}

disco() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = "disco";
  playlocalsound_phone(var_0, 1, 1);
}

info() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(2.2, 5.5));
  stoplocalsound_phone("ring_usa");
  var_0 = "info";
  playlocalsound_phone(var_0, 1, 1);
}

operator() {
  var_0 = undefined;
  var_1 = randomint(9);
  switch (var_1) {
    case 0:
      var_0 = "operator_01";
      break;

    case 1:
      var_0 = "operator_02";
      break;

    case 2:
      var_0 = "operator_03";
      break;

    case 3:
      var_0 = "operator_04";
      break;

    case 4:
      var_0 = "operator_05";
      break;

    case 5:
      var_0 = "operator_06";
      break;

    case 6:
      var_0 = "operator_07";
      break;

    case 7:
      var_0 = "operator_08";
      break;

    case 8:
      var_0 = "operator_09";
      break;
  }

  playlocalsound_phone(var_0, 1, 1);
}

emergency() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(6, 10));
  stoplocalsound_phone("ring_usa");
  var_0 = "911";
  playlocalsound_phone(var_0, 1, 1);
}

cdc() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(6, 10));
  stoplocalsound_phone("ring_usa");
  var_0 = "cdc";
  playlocalsound_phone(var_0, 1, 1);
}

weather() {
  thread playlocalsound_phone("ring_usa");
  wait(randomfloatrange(6, 10));
  stoplocalsound_phone("ring_usa");
  var_0 = "weather";
  playlocalsound_phone(var_0, 1, 1);
}

skullbuster() {
  var_0 = getomnvar("zm_num_ghost_n_skull_coin");
  if(scripts\engine\utility::istrue(level.skullbuster_service_available) && isDefined(var_0) && var_0 >= 5) {
    thread playlocalsound_phone("ring_usa");
    wait(randomfloatrange(2.2, 5.5));
    stoplocalsound_phone("ring_usa");
    playlocalsound_phone("prank_call_01", 1, 1);
    level notify("skullbuster_service_called");
    return;
  }

  wait(2);
  playlocalsound_phone("busy");
}

phonebooth_update_scriptable_state(var_0) {
  if(!isDefined(var_0.pb_scriptable)) {
    return;
  }

  if(!isDefined(var_0.powered_on) || var_0.powered_on == 0) {
    var_0.pb_scriptable setscriptablepartstate("phonebooth", "power_off");
    return;
  }

  if(isDefined(var_0.quest_state)) {
    if(var_0.quest_state == 1) {
      var_0.pb_scriptable setscriptablepartstate("phonebooth", "power_red");
      return;
    }

    var_0.pb_scriptable setscriptablepartstate("phonebooth", "power_on");
    return;
  }

  var_0.pb_scriptable setscriptablepartstate("phonebooth", "power_on");
}

update_all_phonebooth_scriptable_states() {
  foreach(var_1 in level.phone.booths) {
    phonebooth_update_scriptable_state(var_1);
  }
}

init_phone() {
  level.phone.booths[level.phone.booths.size] = self;
  self.linkpoint_struct = undefined;
  self.keypad_buttons = [];
  self.quest_state = 0;
  foreach(var_1 in scripts\engine\utility::getstructarray(self.target, "targetname")) {
    if(var_1.script_parameters == "linkpoint") {
      self.linkpoint_struct = var_1;
    }
  }

  self.keypad_frame = undefined;
  foreach(var_4 in getEntArray(self.target, "targetname")) {
    if(var_4.classname == "script_model") {
      self.keypad_frame = var_4;
      self.keypad_frame.start_pos = var_4.origin;
      for(var_5 = 0; var_5 < 12; var_5++) {
        var_6 = undefined;
        var_7 = undefined;
        var_8 = undefined;
        var_9 = undefined;
        if(var_5 == 10) {
          var_6 = "tag_key_star";
          var_7 = "cp_disco_payphone_key_star";
          var_8 = "*";
          var_9 = 10;
        } else if(var_5 == 11) {
          var_6 = "tag_key_pound";
          var_7 = "cp_disco_payphone_key_pound";
          var_8 = "#";
          var_9 = 11;
        } else {
          var_6 = "tag_key_" + var_5;
          var_7 = "cp_disco_payphone_key_" + var_5;
          var_8 = "" + var_5;
          var_9 = var_5;
        }

        var_1 = spawnStruct();
        var_1.keypos = var_4 gettagorigin(var_6);
        var_1.keyang = var_4 gettagangles(var_6);
        var_1.stopfxontag = var_7;
        var_1.keyname = var_8;
        var_1.keyvalue = var_9;
        self.keypad_buttons[var_5] = var_1;
      }
    }

    if(issubstr(var_4.classname, "scriptable")) {
      self.pb_scriptable = var_4;
    }
  }

  if(isDefined(level.players)) {
    foreach(var_0C in level.players) {
      if(isDefined(self.keypad_frame)) {
        self.keypad_frame hidefromplayer(var_0C);
      }
    }
  }

  if(scripts\engine\utility::istrue(self.requires_power)) {
    var_0E = undefined;
    if(isDefined(self.script_area)) {
      var_0E = self.script_area;
    } else {
      var_0E = scripts\cp\cp_interaction::get_area_for_power(self);
    }

    if(isDefined(var_0E)) {
      level scripts\engine\utility::waittill_any_3("power_on", var_0E + " power_on");
    }
  }

  self.powered_on = 1;
  phonebooth_update_scriptable_state(self);
}

snd_setup() {
  var_0["0"] = "payphone_plr_button_press_0";
  var_0["1"] = "payphone_plr_button_press_1";
  var_0["2"] = "payphone_plr_button_press_2";
  var_0["3"] = "payphone_plr_button_press_3";
  var_0["4"] = "payphone_plr_button_press_4";
  var_0["5"] = "payphone_plr_button_press_5";
  var_0["6"] = "payphone_plr_button_press_6";
  var_0["7"] = "payphone_plr_button_press_7";
  var_0["8"] = "payphone_plr_button_press_8";
  var_0["9"] = "payphone_plr_button_press_9";
  var_0["#"] = "payphone_plr_button_press_pound";
  var_0["*"] = "payphone_plr_button_press_star";
  var_0["ring_usa"] = "payphone_plr_ringing_usa_oneshot";
  var_0["ring_foreign"] = "payphone_plr_ringing_foreign_oneshot";
  var_0["coin_insert"] = "payphone_plr_start_insert_coin";
  var_0["coin_return_denied"] = "payphone_plr_denied_use";
  var_0["coin_return"] = "payphone_plr_end_hangup_coin_returned";
  var_0["coin_accept"] = "payphone_plr_end_hangup_coin_deposited";
  var_0["busy"] = "payphone_plr_busy_oneshot";
  var_0["invalid_number"] = "payphone_plr_wrong_number_pickup";
  var_0["payphone_plr_fax_modem"] = "payphone_plr_fax_modem";
  var_0["receiver_pickup"] = "payphone_plr_start_pickup_receiver";
  var_0["receiver_hangup"] = "payphone_plr_end_hangup_receiver";
  var_0["timeout_vo"] = "payphone_plr_timeout_start";
  var_0["timeout_tone"] = "payphone_plr_timeout_oneshot";
  var_0["prank_call_01"] = "disco_phone_prankcall_01";
  var_0["prank_call_02"] = "disco_phone_prankcall_02";
  var_0["prank_call_03"] = "disco_phone_prankcall_03";
  var_0["prank_call_04"] = "disco_phone_prankcall_04";
  var_0["prank_call_05"] = "disco_phone_prankcall_05";
  var_0["prank_call_06"] = "disco_phone_prankcall_06";
  var_0["burger_town"] = "disco_phone_burgertown_01";
  var_0["crystal"] = "disco_phone_crystal_01";
  var_0["dead_woman"] = "disco_phone_deadwoman_01";
  var_0["disco"] = "disco_phone_disco_01";
  var_0["beast_01"] = "disco_phone_beast_01";
  var_0["beast_02"] = "disco_phone_beast_02";
  var_0["info"] = "disco_phone_infohotline_01";
  var_0["operator_01"] = "disco_phone_operator_01";
  var_0["operator_02"] = "disco_phone_operator_02";
  var_0["operator_03"] = "disco_phone_operator_03";
  var_0["operator_04"] = "disco_phone_operator_04";
  var_0["operator_05"] = "disco_phone_operator_05";
  var_0["operator_06"] = "disco_phone_operator_06";
  var_0["operator_07"] = "disco_phone_operator_07";
  var_0["operator_08"] = "disco_phone_operator_08";
  var_0["operator_09"] = "disco_phone_operator_09";
  var_0["cdc"] = "disco_phone_operator_10";
  var_0["911"] = "disco_phone_operator_11";
  var_0["weather"] = "disco_phone_operator_15";
  var_0["downunda"] = "payphone_plr_australia_didgeridoo";
  level.phone.sounds = var_0;
}

use_phonebooth(var_0, var_1) {
  if(!isDefined(var_0.keypad_frame)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      continue;
    }

    if(distancesquared(var_3.origin, var_0.linkpoint_struct.origin) < 4096) {
      var_1 playlocalsound("perk_machine_deny");
      return;
    }
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_1.iscarrying = 1;
  var_1 notify("force_cancel_placement");
  var_5 = 1;
  if(isDefined(level.phone_preuse_func)) {
    var_5 = [[level.phone_preuse_func]]();
  }

  if(isDefined(level.phone_puzzle_phone) && var_0 == level.phone_puzzle_phone) {
    phone_puzzle_call(var_0, var_1);
    var_5 = 0;
  }

  if(var_5) {
    var_1._phone_sounds_played = [];
    var_1._phone_sounds_active = [];
    var_1 thread snd_phone_intro();
    var_0.linkpoint = spawn("script_model", var_0.linkpoint_struct.origin);
    var_0.linkpoint setModel("tag_origin");
    var_0.linkpoint.angles = var_0.linkpoint_struct.angles;
    var_1 playerlinktodelta(var_0.linkpoint, "tag_origin", 1, 0, 0, 0, 0);
    var_6 = 0.1;
    var_7 = var_1 getstance();
    if(var_7 == "prone") {
      var_6 = 0.7;
    } else if(var_7 == "crouch") {
      var_6 = 0.3;
    }

    var_1 scripts\engine\utility::allow_prone(0);
    var_1 scripts\engine\utility::allow_crouch(0);
    var_1 allowfire(0);
    var_1 scripts\engine\utility::allow_offhand_weapons(0);
    foreach(var_3 in level.players) {
      if(var_3 == var_1) {
        var_0.keypad_frame showtoplayer(var_3);
        continue;
      }

      var_0.keypad_frame hidefromplayer(var_3);
    }

    var_1 clear_phone_omnvars_for_player();
    var_1 setclientomnvar("zm_ui_dialpad_ent", var_0.keypad_frame);
    foreach(var_0B in var_0.keypad_buttons) {
      if(!isDefined(var_0B.model)) {
        var_0C = spawn("script_model", var_0B.keypos);
        var_0C setModel(var_0B.stopfxontag);
        var_0C.origin = var_0B.keypos;
        var_0C.angles = var_0B.keyang;
        var_0B.model = var_0C;
        foreach(var_3 in level.players) {
          if(var_3 == var_1) {
            var_0B.model showtoplayer(var_3);
            continue;
          }

          var_0B.model hidefromplayer(var_3);
        }
      }
    }

    var_10 = use_phone_keypad(var_0, var_1, var_6);
    if(isDefined(var_1)) {
      var_1 thread snd_phone_outro(var_10);
      var_1 scripts\engine\utility::waittill_any_3("exit_phonebooth", "phone_outro_end");
    }

    if(isDefined(var_1)) {
      var_1.iscarrying = undefined;
    }

    wait(0.1);
    foreach(var_0B in var_0.keypad_buttons) {
      if(isDefined(var_0B.model)) {
        if(isDefined(var_1)) {
          scripts\cp\cp_outline::disable_outline_for_player(var_0B.model, var_1);
        }

        var_0B.model delete();
      }
    }

    if(isDefined(var_1)) {
      var_1 scripts\engine\utility::allow_prone(1);
      var_1 scripts\engine\utility::allow_crouch(1);
      var_1 allowfire(1);
      var_1 scripts\engine\utility::allow_offhand_weapons(1);
      var_1 unlink();
      foreach(var_3 in level.players) {
        var_0.keypad_frame hidefromplayer(var_3);
      }
    }

    var_0.linkpoint delete();
    if(isDefined(var_1)) {
      var_1 clear_phone_omnvars_for_player();
      var_1 stoplocalsoundall();
      var_1 thread playlocalsound_phone("receiver_hangup");
      if(!isDefined(var_10) || var_10 == "invalid_number") {
        var_1 thread playlocalsound_phone("coin_return", 0);
        playsoundatpos(var_0.origin, "payphone_npc_end_hangup_coin_returned");
      } else {
        var_1 thread playlocalsound_phone("coin_accept", 0);
        playsoundatpos(var_0.origin, "payphone_npc_end_hangup_coin_deposited");
      }

      var_1._phone_sounds_played = undefined;
      var_1._phone_sounds_active = undefined;
      var_1._phone_exit_move = undefined;
      var_1._phone_exit_damage = undefined;
      var_1 notify("phonebooth_end");
    }
  }

  scripts\cp\cp_interaction::interaction_cooldown(var_0, 1);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
}

snd_phone_intro(var_0) {
  self endon("exit_phonebooth");
  self endon("dialed");
  if(!isDefined(var_0)) {
    playlocalsound_phone("receiver_pickup");
  } else {
    thread playlocalsound_phone("payphone_npc_start_pickup_receiver");
    wait(10.358);
  }

  self notify("timeout");
}

snd_phone_outro(var_0) {
  self endon("phonebooth_end");
  self endon("exit_phonebooth");
  self notify("stop_delay_thread");
  stoplocalsoundall();
  if(!scripts\engine\utility::istrue(self._phone_exit_move) && !scripts\engine\utility::istrue(self._phone_exit_damage)) {
    if(!isDefined(var_0)) {
      playlocalsound_phone("operator_05");
      playlocalsound_phone("timeout_tone");
    } else if(var_0 == "invalid_number") {
      thread playlocalsound_phone("invalid_number");
      wait(8);
      playlocalsound_phone("timeout_tone");
    }
  }

  scripts\engine\utility::waitframe();
  self notify("phone_outro_end");
}

use_phone_keypad(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("left_stick_moved");
  var_1 endon("exit_phonebooth");
  var_1 endon("timeout");
  var_1 thread phone_exit_move();
  var_1 thread phone_exit_damage();
  wait(var_2);
  var_3 = var_1 getEye();
  foreach(var_5 in var_0.keypad_buttons) {
    var_5.vdronestrikeheight = vectornormalize(var_5.keypos - var_3);
  }

  var_1 thread phone_hilight_focused_button(var_0, var_1);
  var_1 thread phone_exit_look(var_0);
  var_1 lerpviewangleclamp(0.05, 0, 0, 30, 30, 30, 30);
  var_1 notifyonplayercommand("use_button_pressed", "+usereload");
  var_1 notifyonplayercommand("use_button_pressed", "+activate");
  var_1 notifyonplayercommand("use_button_pressed", "+attack");
  var_1 notifyonplayercommand("use_button_released", "-usereload");
  var_1 notifyonplayercommand("use_button_released", "-activate");
  var_1 notifyonplayercommand("use_button_released", "-attack");
  var_1 notifyonplayercommand("exit_phonebooth", "+stance");
  var_1 notifyonplayercommand("exit_phonebooth", "+goStand");
  var_1 notifyonplayercommand("exit_phonebooth", "+melee_zoom");
  var_1 notifyonplayercommand("exit_phonebooth", "+breath_sprint");
  var_1 notifyonplayercommand("exit_phonebooth", "+frag");
  var_1 notifyonplayercommand("exit_phonebooth", "+smoke");
  var_7 = [];
  var_8 = undefined;
  var_9 = 0;
  for(;;) {
    var_0A = undefined;
    var_1 childthread phone_exit_timeout();
    var_1 waittill("use_button_pressed");
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      return;
    }

    var_0B = anglesToForward(var_1 getplayerangles());
    foreach(var_0D in var_0.keypad_buttons) {
      var_0E = vectordot(var_0B, var_0D.vdronestrikeheight);
      if(var_0E > 0.999) {
        var_1 notify("dialed");
        var_1 notify("stop_delay_thread");
        var_1 thread stoplocalsound_phone("receiver_pickup");
        var_0A = var_0D.keyname;
        var_0F = var_0D.keyvalue;
        var_1 thread playlocalsound_phone(var_0A);
        if(isDefined(var_8)) {
          var_8 = var_8 + var_0A;
        } else {
          var_8 = var_0A;
        }

        var_7[var_9] = var_0F;
        var_9++;
        break;
      }
    }

    for(var_11 = 0; var_11 < var_7.size; var_11++) {
      var_12 = "zm_ui_dialpad_" + 9 - var_11;
      var_1 setclientomnvar(var_12, var_7[var_7.size - var_11 - 1]);
    }

    var_13 = gettime();
    var_1 waittill("use_button_released");
    var_14 = gettime();
    var_15 = var_14 - var_13;
    if(var_15 < 250) {
      var_16 = 250 - var_15 / 1000;
      if(var_16 >= 0.05) {
        wait(var_16);
      }
    }

    if(isDefined(var_0A)) {
      var_1 stoplocalsound_phone(var_0A);
    } else {
      continue;
    }

    foreach(var_19, var_18 in level.phone.numbers) {
      if(var_8 == var_19) {
        var_1 notify("dial_complete");
        var_1 stoplocalsoundall();
        var_1 notify("stop_delay_thread");
        var_1[[var_18]]();
        return "valid";
      }
    }

    if(var_9 >= 9) {
      return "invalid_number";
    }
  }
}

clear_phone_omnvars_for_player() {
  self setclientomnvar("zm_ui_dialpad_ent", undefined);
  self setclientomnvar("zm_ui_dialpad_0", 12);
  self setclientomnvar("zm_ui_dialpad_1", 12);
  self setclientomnvar("zm_ui_dialpad_2", 12);
  self setclientomnvar("zm_ui_dialpad_3", 12);
  self setclientomnvar("zm_ui_dialpad_4", 12);
  self setclientomnvar("zm_ui_dialpad_5", 12);
  self setclientomnvar("zm_ui_dialpad_6", 12);
  self setclientomnvar("zm_ui_dialpad_7", 12);
  self setclientomnvar("zm_ui_dialpad_8", 12);
  self setclientomnvar("zm_ui_dialpad_9", 12);
}

phone_hilight_focused_button(var_0, var_1) {
  var_1 endon("phonebooth_end");
  var_1 endon("disconnect");
  for(;;) {
    var_2 = anglesToForward(var_1 getplayerangles());
    var_3 = 0;
    foreach(var_5 in var_0.keypad_buttons) {
      var_6 = vectordot(var_2, var_5.vdronestrikeheight);
      if(var_6 > 0.999 && !var_3) {
        scripts\cp\cp_outline::enable_outline_for_player(var_5.model, var_1, 1, 1, 0, "low");
        var_3 = 1;
        continue;
      }

      scripts\cp\cp_outline::disable_outline_for_player(var_5.model, var_1);
    }

    wait(0.05);
  }
}

phone_exit_move() {
  self endon("phonebooth_end");
  self endon("disconnect");
  var_0 = 0;
  for(;;) {
    var_1 = self getnormalizedmovement();
    if(var_1[0] != 0 || var_1[1] != 0) {
      var_0++;
      if(var_0 == 3) {
        self._phone_exit_move = 1;
        self notify("exit_phonebooth");
      }
    } else {
      var_0 = 0;
    }

    wait(0.1);
  }
}

phone_exit_look(var_0) {
  self endon("disconnect");
  self endon("phonebooth_end");
  var_1 = anglesToForward(var_0.linkpoint.angles);
  for(;;) {
    var_2 = anglesToForward(self getplayerangles());
    if(scripts\engine\utility::anglebetweenvectors(var_2, var_1) >= 30) {
      self._phone_exit_move = 1;
      self notify("exit_phonebooth");
    }

    wait(0.1);
  }
}

phone_exit_damage() {
  self endon("disconect");
  self endon("phonebooth_end");
  self waittill("damage");
  self._phone_exit_damage = 1;
  self notify("exit_phonebooth");
}

phone_exit_timeout() {
  self endon("disconect");
  self notify("stop_timeout");
  self endon("dial_complete");
  self endon("stop_timeout");
  wait(7);
  self notify("timeout");
}

playlocalsound_phone(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconect");
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = 0;
  if(scripts\engine\utility::istrue(var_1) && self._phone_sounds_played.size > 0) {
    foreach(var_4 in self._phone_sounds_played) {
      stoplocalsound_phone(var_4);
    }

    self._phone_sounds_played = [];
  }

  if(!isDefined(level.phone.sounds[var_0])) {
    return;
  }

  if(issubstr(level.phone.sounds[var_0], "_lp")) {
    if(isDefined(self._phone_sounds_played)) {
      self._phone_sounds_played[self._phone_sounds_played.size] = var_0;
      self._phone_sounds_active[self._phone_sounds_active.size] = var_0;
    }

    scripts\cp\utility::play_looping_sound_on_ent(level.phone.sounds[var_0]);
    self waittill("stop_loop");
    if(isDefined(self._phone_sounds_active)) {
      self._phone_sounds_active = scripts\engine\utility::array_remove(self._phone_sounds_active, var_0);
      return;
    }

    return;
  }

  if(var_2) {
    return;
  }

  if(isDefined(self._phone_sounds_played)) {
    self._phone_sounds_played[self._phone_sounds_played.size] = var_0;
    self._phone_sounds_active[self._phone_sounds_active.size] = var_0;
  }

  self playlocalsound(level.phone.sounds[var_0], "sounddone", "stop_" + var_0);
  var_6 = lookupsoundlength(level.phone.sounds[var_0]);
  wait(var_6 / 1000 + 0.05);
  if(isDefined(self._phone_sounds_active)) {
    self._phone_sounds_active = scripts\engine\utility::array_remove(self._phone_sounds_active, var_0);
    return;
  }
}

stoplocalsound_phone(var_0) {
  if(!isDefined(level.phone.sounds[var_0])) {
    return;
  }

  if(issubstr(level.phone.sounds[var_0], "_lp")) {
    self stoploopsound(level.phone.sounds[var_0]);
  } else {
    self stoplocalsound(level.phone.sounds[var_0]);
  }

  self notify("stop_" + var_0);
  if(isDefined(self._phone_sounds_played)) {
    self._phone_sounds_active = scripts\engine\utility::array_remove(self._phone_sounds_active, var_0);
  }
}

stoplocalsoundall() {
  stop_secondary_aliases();
  if(self._phone_sounds_played.size == 0) {
    return;
  }

  foreach(var_1 in self._phone_sounds_played) {
    thread stoplocalsound_phone(var_1);
  }

  self._phone_sounds_played = [];
}

stop_secondary_aliases() {
  self stoplocalsound("payphone_plr_start_dialtone_initial");
  self stoplocalsound("payphone_plr_start_insert_coin");
  self stoplocalsound("payphone_plr_wrong_number_vo");
  self stoplocalsound("payphone_plr_timeout_vo");
}

phone_puzzle_call(var_0, var_1) {
  level notify("puzzle_phone_answered");
  level endon("puzzle_phone_reset");
  var_2 = 1;
  var_0 notify("phone_answered");
  if(var_2) {
    var_1._phone_sounds_played = [];
    var_1._phone_sounds_active = [];
    var_1 thread snd_phone_intro(1);
    scripts\cp\utility::playsoundinspace("payphone_npc_start_pickup_receiver", var_0.linkpoint_struct.origin);
    var_0.linkpoint = spawn("script_model", var_0.linkpoint_struct.origin);
    var_0.linkpoint setModel("tag_origin");
    var_0.linkpoint.angles = var_0.linkpoint_struct.angles;
    var_1 playerlinktodelta(var_0.linkpoint, "tag_origin", 1, 0, 0, 0, 0);
    var_1 scripts\engine\utility::allow_prone(0);
    var_1 scripts\engine\utility::allow_crouch(0);
    var_1 allowfire(0);
    var_1 scripts\engine\utility::allow_offhand_weapons(0);
    var_1 thread phone_morse_code(var_0.linkpoint);
    var_1 thread phone_exit_move();
    var_1 thread phone_exit_damage();
    var_1 notifyonplayercommand("exit_phonebooth", "+stance");
    var_1 notifyonplayercommand("exit_phonebooth", "+goStand");
    var_1 notifyonplayercommand("exit_phonebooth", "+melee_zoom");
    var_1 notifyonplayercommand("exit_phonebooth", "+breath_sprint");
    var_1 notifyonplayercommand("exit_phonebooth", "+frag");
    var_1 notifyonplayercommand("exit_phonebooth", "+smoke");
    var_1 scripts\engine\utility::waittill_any_3("exit_phonebooth", "morse_ended");
    wait(0.1);
    var_1 scripts\engine\utility::allow_prone(1);
    var_1 scripts\engine\utility::allow_crouch(1);
    var_1 allowfire(1);
    var_1 scripts\engine\utility::allow_offhand_weapons(1);
    var_1.iscarrying = undefined;
    var_1 unlink();
    var_0.linkpoint delete();
    foreach(var_4 in level.players) {
      var_0.keypad_frame hidefromplayer(var_4);
    }

    var_1 stoplocalsoundall();
    var_1 thread playlocalsound_phone("receiver_hangup");
    var_1 thread playlocalsound_phone("coin_accept", 0);
    var_1._phone_sounds_played = undefined;
    var_1._phone_sounds_active = undefined;
    var_1._phone_exit_move = undefined;
    var_1._phone_exit_damage = undefined;
    var_1 notify("phonebooth_end");
  }
}

phone_morse_code(var_0) {
  self endon("left_stick_moved");
  self endon("exit_phonebooth");
  self endon("timeout");
  level endon("puzzle_phone_reset");
  if(!isDefined(level.morse_number)) {
    var_1 = ["281", "407", "420", "596", "713", "818"];
    var_1 = scripts\engine\utility::array_randomize(var_1);
    level.morse_number = var_1[0];
  }

  wait(2);
  var_2 = undefined;
  for(var_3 = 0; var_3 < 3; var_3++) {
    if(var_3 + 1 == 3) {
      var_2 = getsubstr(level.morse_number, var_3);
    } else {
      var_2 = getsubstr(level.morse_number, var_3, var_3 + 1);
    }

    switch (var_2) {
      case "0":
        for(var_4 = 0; var_4 < 5; var_4++) {
          play_morse_dash(var_0);
        }
        break;

      case "1":
        play_morse_dot(var_0);
        for(var_4 = 0; var_4 < 4; var_4++) {
          play_morse_dash(var_0);
        }
        break;

      case "2":
        for(var_4 = 0; var_4 < 2; var_4++) {
          play_morse_dot(var_0);
        }

        for(var_4 = 0; var_4 < 3; var_4++) {
          play_morse_dash(var_0);
        }
        break;

      case "3":
        for(var_4 = 0; var_4 < 3; var_4++) {
          play_morse_dot(var_0);
        }

        for(var_4 = 0; var_4 < 2; var_4++) {
          play_morse_dash(var_0);
        }
        break;

      case "4":
        for(var_4 = 0; var_4 < 4; var_4++) {
          play_morse_dot(var_0);
        }

        play_morse_dash(var_0);
        break;

      case "5":
        for(var_4 = 0; var_4 < 5; var_4++) {
          play_morse_dot(var_0);
        }
        break;

      case "6":
        play_morse_dash(var_0);
        for(var_4 = 0; var_4 < 4; var_4++) {
          play_morse_dot(var_0);
        }
        break;

      case "7":
        for(var_4 = 0; var_4 < 2; var_4++) {
          play_morse_dash(var_0);
        }

        for(var_4 = 0; var_4 < 3; var_4++) {
          play_morse_dot(var_0);
        }
        break;

      case "8":
        for(var_4 = 0; var_4 < 3; var_4++) {
          play_morse_dash(var_0);
        }

        for(var_4 = 0; var_4 < 2; var_4++) {
          play_morse_dot(var_0);
        }
        break;

      case "9":
        for(var_4 = 0; var_4 < 4; var_4++) {
          play_morse_dash(var_0);
        }

        play_morse_dot(var_0);
        break;

      default:
        break;
    }
  }

  thread scripts\cp\maps\cp_disco\disco_mpq::play_phone_vo();
  self notify("morse_ended");
  scripts\engine\utility::flag_set("morse_code_heard");
}

play_morse_dot(var_0) {
  level endon("puzzle_phone_reset");
  self playlocalsound("payphone_plr_morse_dot");
  wait(0.3);
}

play_morse_dash(var_0) {
  level endon("puzzle_phone_reset");
  self playlocalsound("payphone_plr_morse_dash");
  wait(0.5);
}