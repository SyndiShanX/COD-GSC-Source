/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1815.gsc
*************************************************/

init() {
  level._effect["vfx_covenant_altar_vortex"] = loadfx("vfx/s4/zombie/vfx_covenant_altar_vortex.vfx");
  level._effect["vfx_covenant_altar_eye_white"] = loadfx("vfx/s4/zombie/vfx_covenant_altar_eye_white.vfx");
  level._effect["vfx_covenant_altar_eye_blue"] = loadfx("vfx/s4/zombie/vfx_covenant_altar_eye_blue.vfx");
  level._effect["vfx_covenant_altar_eye_purple"] = loadfx("vfx/s4/zombie/vfx_covenant_altar_eye_purple.vfx");
  level._effect["vfx_covenant_altar_eye_orange"] = loadfx("vfx/s4/zombie/vfx_covenant_altar_eye_orange.vfx");
}

_id_C1EF() {
  _id_0737::_id_C266("covenant_store", ::_id_7977, ::_id_0EA8, ::_id_7F3B, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_sacrificialaltar", 112, getdvarint("#x3dee089cb49164e4e", 0));
  _id_0737::addinteractionhinttypecallback("covenant_store", ::covenant_store_hint_type);
}

_id_7977(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
  }

  return &"CP_ZMB_INTERACTIONS/OPEN_COVENANT_STORE";
}

_id_0EA8(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return;
  }
  while(var_1 scripts\cp\utility::_id_1A57()) {
    waitframe();
  }

  var_1 _id_AC00();

  if(scripts\engine\utility::is_equal(level.mapname, "cp_zm_oasis")) {
    var_1 thread covenant_store_distance_monitor(var_0);
  }
}

covenant_store_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_7F3B(var_0) {
  var_1 = _func_0393("covenantlist:cp_covenant_list");

  foreach(var_11, var_3 in var_1.covenants) {
    var_4 = _func_0393("covenant:" + var_3.covenant);

    if(isDefined(var_4)) {
      foreach(var_6 in var_4._id_3DBF) {
        foreach(var_8 in var_6._id_F7AF) {
          if(isDefined(var_8._id_5095)) {
            setDvar(var_8._id_5095, scripts\cp\utility::_id_459B(var_8._id_04CB, 0));
          }
        }
      }
    }
  }

  var_12 = getEntArray("covenant_store_model", "targetname");

  foreach(var_14 in var_12) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_covenant_altar_vortex"), var_14, "tag_origin");
    var_14 thread covenant_bob();
    var_14 playLoopSound("zmb_covenant_idle_lp");
  }

  if(isDefined(var_0) && var_0.size > 0) {
    thread _id_0720::init_approach_dialogue(var_0[0].origin, "hac", 1, 10000);
  }

  thread refresh_unlocked_covenants();
}

get_rarity_string(var_0) {
  switch (var_0) {
    case 0:
      return "Rare";
    case 1:
      return "Epic";
    case 2:
      return "Legendary";
    default:
      return "";
  }
}

_id_805B() {
  self._id_BE30 = [];
  self._id_3DC0 = [];
  self.covenant_pool_weight = 0;
  var_0 = _func_0393("covenantlist:cp_covenant_list");

  foreach(var_4, var_2 in var_0.covenants) {
    var_3 = _func_0393("covenant:" + var_2.covenant);

    if(isDefined(var_3)) {
      var_3.index = var_4;
      self._id_3DC0[var_4] = var_3;
    }
  }

  scripts\engine\utility::delaythread(3, ::_id_5A3C);
  thread get_unlocked_covenants();
}

_id_5A3C() {
  if(!isDefined(self.covenant_store)) {
    self.covenant_store = [];
  }

  for(var_0 = 0; var_0 < 3; var_0++) {
    self.covenant_store[var_0] = undefined;
  }

  self.covenant_pool_weight = get_covenant_pool_weight();

  if(self._id_3DC0.size == 0 || self.covenant_pool_weight == 0) {
    return;
  }
  for(var_0 = 0; var_0 < 3; var_0++) {
    self.covenant_store[var_0] = get_random_covenant_info();
  }

  thread play_covenant_store_eye_fx();
}

get_unlocked_covenants() {
  self endon("disconnect");
  self waittill("covenant_unlock_check_ready");
  wait 10;
  get_unlocked_covenants_internal();
}

get_unlocked_covenants_internal() {
  self endon("disconnect");
  self notify("get_unlocked_covenants");
  self endon("get_unlocked_covenants");
  var_0 = _func_0393("covenantlist:cp_covenant_list");

  for(var_1 = 0; var_1 < var_0.covenants.size; var_1++) {
    if(isDefined(self._id_3DC0[var_1].lootreference)) {
      self setclientomnvar("ui_zm_covenant_id_loot_check", var_1 + 1);

      for(;;) {
        self waittill("luinotifyserver", var_2, var_3);

        if(var_2 == "zm_progression_check_covenant") {
          self._id_3DC0[var_1].unlocked = var_3;
          break;
        }
      }

      continue;
    }

    self._id_3DC0[var_1].unlocked = 1;
  }
}

refresh_unlocked_covenants() {
  level endon("game_ended");

  for(;;) {
    level waittill("begin_successful_objective_ended");

    foreach(var_1 in level.players) {
      var_1 thread get_unlocked_covenants_internal();
    }
  }
}

play_covenant_store_eye_fx() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("play_covenant_store_eye_fx");
  self endon("play_covenant_store_eye_fx");

  if(istrue(self._id_E3E5) && istrue(self.on_initializing)) {
    self waittill("auto_respawn");

    if(!isDefined(self)) {
      return;
    }
  }

  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in self.covenant_store) {
    var_4 = self._id_3DC0[var_3.covenant_index];
    var_5 = var_4._id_3DBF[var_3.level_index];
    var_6 = scripts\cp\utility::_id_459B(var_5._id_C040, 0);

    if(var_0 < var_6) {
      var_0 = var_6;
    }
  }

  if(var_0 == 0) {
    var_1 = "vfx_covenant_altar_eye_blue";
  } else if(var_0 == 1) {
    var_1 = "vfx_covenant_altar_eye_purple";
  } else if(var_0 == 2) {
    var_1 = "vfx_covenant_altar_eye_orange";
  }

  var_8 = getEntArray("covenant_store_model", "targetname");

  if(!isDefined(self.covenant_altar_previous_eye_fx) || self.covenant_altar_previous_eye_fx != var_1) {
    foreach(var_10 in var_8) {
      if(isDefined(self.covenant_altar_previous_eye_fx)) {
        _func_02D1(level._effect[self.covenant_altar_previous_eye_fx], var_10, "tag_origin", self);
        waitframe();
      }

      _func_019D(level._effect[var_1], var_10, "tag_origin", self);
      self.covenant_altar_previous_eye_fx = var_1;
    }
  }
}

get_covenant_pool_weight() {
  var_0 = 0;

  foreach(var_2 in self._id_3DC0) {
    var_0 = var_0 + get_valid_covenant_weight(var_2);
  }

  return var_0;
}

get_covenant_level_weight(var_0) {
  if(!isDefined(var_0._id_0503) || var_0._id_0503.size == 0) {
    return 0;
  }

  var_1 = level._id_11049;

  if(isDefined(level.covenant_upgrade_rate_scale)) {
    var_1 = int(clamp(var_1 * level.covenant_upgrade_rate_scale, 1, var_1)) + 1;
  }

  var_2 = var_1 - 1;

  if(var_0._id_0503.size <= var_2) {
    return scripts\cp\utility::_id_459B(var_0._id_0503[var_0._id_0503.size - 1]._id_04CB, 0);
  }

  return scripts\cp\utility::_id_459B(var_0._id_0503[var_2]._id_04CB, 0);
}

get_valid_covenant_weight(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in var_0._id_3DBF) {
    if(is_valid_covenant_for_store(var_0.index, var_4)) {
      var_1 = var_1 + get_covenant_level_weight(var_3);
    }
  }

  return var_1;
}

get_random_covenant_info() {
  if(!isDefined(self.covenant_pool_weight) || self.covenant_pool_weight == 0) {
    return undefined;
  }

  var_0 = randomint(self.covenant_pool_weight);
  var_1 = 0;

  foreach(var_9, var_3 in self._id_3DC0) {
    foreach(var_8, var_5 in var_3._id_3DBF) {
      if(is_valid_covenant_for_store(var_9, var_8)) {
        var_6 = get_covenant_level_weight(var_5);
        var_1 = var_1 + var_6;

        if(var_0 < var_1 && var_6 != 0) {
          self.covenant_pool_weight = self.covenant_pool_weight - get_valid_covenant_weight(var_3);
          var_7 = spawnStruct();
          var_7.covenant_index = var_9;
          var_7.level_index = var_8;
          return var_7;
        }
      }
    }
  }

  return undefined;
}

is_valid_covenant_for_store(var_0, var_1) {
  if(!isDefined(self._id_3DC0[var_0]) || !isDefined(self._id_3DC0[var_0]._id_3DBF[var_1])) {
    return 0;
  }

  var_2 = self._id_3DC0[var_0];
  var_3 = var_2._id_3DBF[var_1];

  if(scripts\cp\utility::_id_459B(var_2.store_cooldown, 0) > 0) {
    return 0;
  }

  var_4 = scripts\cp\utility::_id_459B(var_3._id_C040, 0);

  if(var_4 == 2 && !istrue(var_2.unlocked)) {
    return 0;
  }

  if(!istrue(var_2.availableinsolo) && level.players.size == 1) {
    return 0;
  }

  foreach(var_6 in self.covenant_store) {
    if(var_6.covenant_index == var_0) {
      return 0;
    }
  }

  foreach(var_6 in self._id_BE30) {
    if(var_6.covenant_index == var_0) {
      var_9 = var_2._id_3DBF[var_6.level_index];

      if(isDefined(var_9) && scripts\cp\utility::_id_459B(var_9._id_C040, 0) >= scripts\cp\utility::_id_459B(var_3._id_C040, 0)) {
        return 0;
      }

      break;
    }
  }

  return 1;
}

_id_FBD1() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    if(!isDefined(self.covenant_store[var_0])) {
      self setclientomnvar("ui_zombie_covenant_selection_id_" + var_0, 0);
      self setclientomnvar("ui_zombie_covenant_selection_state_" + var_0, 0);
      self setclientomnvar("ui_zombie_covenant_selection_level_" + var_0, 0);
      continue;
    }

    if(_func_0121(self.covenant_store[var_0]) && self.covenant_store[var_0] == "purchased") {
      self setclientomnvar("ui_zombie_covenant_selection_state_" + var_0, 2);
      continue;
    }

    var_1 = self.covenant_store[var_0];
    var_2 = scripts\cp\utility::_id_459B(var_1.level_index, 0);
    self setclientomnvar("ui_zombie_covenant_selection_id_" + var_0, self.covenant_store[var_0].covenant_index + 1);
    self setclientomnvar("ui_zombie_covenant_selection_state_" + var_0, 1);
    self setclientomnvar("ui_zombie_covenant_selection_level_" + var_0, var_2);
  }
}

_id_AC00() {
  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    thread enemy_ignore_player("covenant_store_closed");
  }

  _id_FBD1();
  self setclientomnvar("ui_zombie_open_covenant_menu", 1);
  thread _id_1074C();
  thread watch_for_end_conditions();
}

close_covenant_store() {
  if(isPlayer(self)) {
    self setclientomnvar("ui_zombie_open_covenant_menu", 0);
  }

  self notify("covenant_store_closed");
}

covenant_store_distance_monitor(var_0) {
  level endon("game_ended");
  self endon("covenant_store_closed");
  self endon("disconnect");
  self endon("death");
  var_1 = 8100;

  if(isDefined(var_0._id_425E)) {
    var_1 = var_0._id_425E * var_0._id_425E;
  }

  while(isDefined(self) && scripts\engine\utility::is_equal(self _meth_876E("ui_zombie_open_covenant_menu"), 1)) {
    if(distancesquared(self.origin, var_0.origin) > var_1) {
      close_covenant_store();
      return;
    }

    waitframe();
  }
}

watch_for_end_conditions() {
  level endon("game_ended");
  self endon("covenant_store_closed");
  self endon("disconnect");
  self endon("death");
  var_0 = 0;

  while(!istrue(var_0)) {
    if(_id_073B::_id_B4EF(self)) {
      var_0 = 1;
    }

    if(istrue(level._id_0C35) || istrue(self._id_2031)) {
      var_0 = 1;
    }

    waitframe();
  }

  close_covenant_store();
}

_id_1074C() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "zombie_purchase_covenant") {
      if(var_1 == 9) {
        self notify("covenant_store_closed");
        return;
      }

      var_2 = var_1 % 10;
      var_3 = int(floor(var_1 / 10)) - 1;

      if(var_2 >= 0 && var_2 < 3) {
        var_4 = self.covenant_store[var_2];

        if(!_func_02DE(var_4)) {
          continue;
        }
        var_5 = _id_641B(var_4);

        if(!isDefined(var_5) || !scripts\cp\cp_sacrificial_heart::getplayersacrificialheart() >= var_5) {
          self setclientomnvar("ui_zombie_covenant_response", 2);
          self playlocalsound("zmb_ui_covenant_buy_deny");
          _id_0720::_id_BEC0("insufficient_funds", 1);
          continue;
        }

        var_6 = var_3;

        if(var_6 == -1 && self._id_BE30.size < 3) {
          var_6 = self._id_BE30.size;
          self playlocalsound("zmb_ui_covenant_buy");
        }

        if(var_6 != -1) {
          _id_BE2D(var_2, var_6);
          self playlocalsound("zmb_ui_covenant_buy_replace");
        }
      }
    }
  }
}

_id_BE2D(var_0, var_1) {
  if(isDefined(self.covenant_store[var_0]) && !_func_0121(self.covenant_store[var_0])) {
    var_2 = _id_641B(self.covenant_store[var_0]);

    if(!isDefined(var_2) || !scripts\cp\cp_sacrificial_heart::getplayersacrificialheart() >= var_2) {
      self setclientomnvar("ui_zombie_covenant_response", 2);
      return;
    }

    thread scripts\cp\cp_sacrificial_heart::takeplayersacrificialheart(var_2);
    _id_070F::createpurchasecovenantevent(self, self.covenant_store[var_0]);
    covenant_purchased(var_0, var_1);
    _id_FBD1();
    _id_070F::createupdatecovenantsevent(self, self._id_BE30);
    _id_0720::_id_BEC0("receive_covenant", 1);
    self setclientomnvar("ui_zombie_covenant_response", 1);
  }
}

covenant_purchased(var_0, var_1) {
  _id_6ED8(self.covenant_store[var_0], var_1);
  self.covenant_store[var_0] = "purchased";
  var_2 = self.covenant_store[var_0];
  var_3 = var_1;
  scripts\cp\telemetry_cp::logevent_covenantpurchase(self, self.covenant_store[var_0], var_3);
}

_id_6ED8(var_0, var_1) {
  var_2 = self._id_3DC0[var_0.covenant_index];
  var_3 = var_2._id_3DBF[var_0.level_index];

  if(isDefined(self._id_BE30[var_1])) {
    var_4 = self._id_BE30[var_1].covenant_index == var_0.covenant_index;
    remove_covenant(self._id_BE30[var_1], var_4);
  }

  self._id_BE30[var_1] = var_0;
  self setclientomnvar("ui_zombie_covenant_equipped_id_" + var_1, var_0.covenant_index + 1);
  self setclientomnvar("ui_zombie_covenant_equipped_level_" + var_1, var_0.level_index);

  foreach(var_6 in var_3._id_F7AF) {
    switch (var_6.type) {
      case "Perk":
        scripts\cp\utility::_id_6FC2(var_6._id_C189);
        break;
      case "PerkDataAdditive":
        var_7 = scripts\cp\utility::_id_459B(var_6._id_04CB, 0);
        _id_0945::_id_D2EB(var_6._id_C189, _id_0945::_id_664E(var_6._id_C189) + var_7);
        break;
      case "PerkDataSet":
        var_7 = scripts\cp\utility::_id_459B(var_6._id_04CB, 0);
        var_6.original_value = _id_0945::_id_664E(var_6._id_C189);
        _id_0945::_id_D2EB(var_6._id_C189, var_7);
        break;
    }
  }

  _id_06FA::_id_FB31("ZM_DEAL_WITH_THE_DEVIL", self._id_BE30.size);
}

remove_covenant(var_0, var_1) {
  var_2 = self._id_3DC0[var_0.covenant_index];
  var_3 = var_2._id_3DBF[var_0.level_index];

  if(!istrue(var_1)) {
    var_2.store_cooldown = 2;
  }

  foreach(var_5 in var_3._id_F7AF) {
    switch (var_5.type) {
      case "Perk":
        scripts\cp\utility::_id_EDCE(var_5._id_C189);
        break;
      case "PerkDataAdditive":
        var_6 = scripts\cp\utility::_id_459B(var_5._id_04CB, 0);
        _id_0945::_id_D2EB(var_5._id_C189, _id_0945::_id_664E(var_5._id_C189) - var_6);
        break;
      case "PerkDataSet":
        _id_0945::_id_D2EB(var_5._id_C189, var_5.original_value);
        break;
    }
  }
}

_id_641B(var_0) {
  var_1 = self._id_3DC0[var_0.covenant_index];

  if(isDefined(var_0.level_index)) {
    return var_1._id_3DBF[var_0.level_index]._id_3D91;
  } else {
    return undefined;
  }
}

open_slot_selector() {
  if(!isDefined(self._id_9DCF)) {
    _id_06D8::_id_7FF2();
  }

  if(!isDefined(self._id_9DCF["covenant_store"])) {
    _id_06D8::_id_0FED("covenant_store", "SELECT SLOT");
  }

  _id_06D8::_id_38E9("covenant_store");
  _id_06D8::_id_0FF0("covenant_store", get_slot_string(0), ::select_slot_zero);
  _id_06D8::_id_0FF0("covenant_store", get_slot_string(1), ::select_slot_one);
  _id_06D8::_id_0FF0("covenant_store", get_slot_string(2), ::select_slot_two);
  _id_06D8::_id_0FF0("covenant_store", "[CANCEL]", ::cancel_slot_selection);
  _id_06D8::_id_520C("covenant_store");
  scripts\cp\utility::_id_5F63(1);
}

get_slot_string(var_0) {
  var_1 = "EMPTY";

  if(isDefined(self._id_BE30[var_0])) {
    var_2 = self._id_BE30[var_0].covenant_index;
    var_1 = self._id_3DC0[var_2].namestring;
  }

  return "Slot " + var_0 + ": " + var_1;
}

select_slot(var_0) {
  self notify("covenant_slot_selected", var_0);
  close_slot_selector();
}

select_slot_zero() {
  select_slot(0);
}

select_slot_one() {
  select_slot(1);
}

select_slot_two() {
  select_slot(2);
}

cancel_slot_selection() {
  self notify("covenant_slot_selected");
  close_slot_selector();
}

close_slot_selector() {
  if(_id_06D8::_id_6426() == "covenant_store") {
    _id_06D8::_id_4A25("current_menu");
    scripts\cp\utility::_id_5F63(0);
    _id_AC00();
  }
}

update_covenant_cooldowns() {
  foreach(var_1 in self._id_3DC0) {
    if(isDefined(var_1.store_cooldown) && var_1.store_cooldown > 0) {
      var_1.store_cooldown--;
    }
  }
}

on_objective_complete() {
  update_covenant_cooldowns();
  _id_5A3C();

  if(self _meth_876E("ui_zombie_open_covenant_menu") == 1) {
    _id_FBD1();
    self setclientomnvar("ui_zombie_covenant_response", 0);
  }
}

covenant_bob() {
  self endon("death");
  var_0 = 5;
  var_1 = var_0 + 0.5;
  var_2 = 3;
  var_3 = 0;
  var_4 = 0;
  var_5 = self.origin + (0, 0, var_2);
  var_6 = self.origin - (0, 0, var_2);

  for(;;) {
    self moveto(var_5, var_0, var_3, var_4);
    wait(var_1);
    self moveto(var_6, var_0, var_3, var_4);
    wait(var_1);
  }
}

get_covenant(var_0) {
  if(isDefined(self._id_3DC0) && isDefined(self._id_3DC0[var_0])) {
    return self._id_3DC0[var_0];
  }

  return undefined;
}

enemy_ignore_player(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_1 = scripts\cp\utility::_id_6871();

  if(!isDefined(self.open_store_last_ignore_round) || self.open_store_last_ignore_round != var_1) {
    self.open_store_last_ignore_round = var_1;
    scripts\cp\utility::_id_1566(1);

    if(!isDefined(var_0)) {
      wait 30;
    } else {
      scripts\engine\utility::_id_108F5(var_0, 30);
    }

    scripts\cp\utility::_id_1566(0);
  }
}