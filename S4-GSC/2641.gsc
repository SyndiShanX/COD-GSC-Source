/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2641.gsc
*************************************************/

_id_8205() {
  var_0 = spawnStruct();
  level._id_8DD5 = var_0;
  var_0._id_3D93 = [];
  var_0._id_3D93[1] = "ui_score_streak_cost";
  var_0._id_3D93[2] = "ui_score_streak_two_cost";
  var_0._id_3D93[3] = "ui_score_streak_three_cost";
  var_0._id_DDF4 = [];
  var_0._id_DDF4[0] = "ui_score_streak_index_0";
  var_0._id_DDF4[1] = "ui_score_streak_index_1";
  var_0._id_DDF4[2] = "ui_score_streak_index_2";
  var_0._id_DDF4[3] = "ui_score_streak_index_3";
  var_0._id_1F92 = [];
  var_0._id_1F92[0] = "ui_score_streak_available_0";
  var_0._id_1F92[1] = "ui_score_streak_available_1";
  var_0._id_1F92[2] = "ui_score_streak_available_2";
  var_0._id_1F92[3] = "ui_score_streak_available_3";
  _id_AE76();
  _id_0A97::_id_C28A(::_id_8DDE);
  level._id_C0F0["allies"] = [];
  level._id_C0F0["axis"] = [];
  level._id_C0F0["all"] = [];
  level._id_C0FC["allies"] = [];
  level._id_C0FC["axis"] = [];
  level._id_C0FC["all"] = [];
}

_id_AE76() {
  var_0 = level._id_8DD5;

  if(isDefined(game["killstreakTable"])) {
    var_0._id_EA18 = game["killstreakTable"];
    return;
  }

  var_1 = spawnStruct();
  game["killstreakTable"] = var_1;
  var_0._id_EA18 = var_1;
  var_1._id_EC74 = [];
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 1);

    if(var_3 == "") {
      break;
    }

    var_1._id_EC74[var_3] = [];
    var_1._id_EC74[var_3]["index"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 0));
    var_1._id_EC74[var_3]["hudIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 12);
    var_1._id_EC74[var_3]["overheadIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 13);
    var_1._id_EC74[var_3]["enemyUseDialog"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 10));
    var_1._id_EC74[var_3]["kills"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 4));

    if(isDefined(level.killstreakcost) && isDefined(level.killstreakcost[var_3]) && level.killstreakcost[var_3] != 0) {
      if(level.killstreakcost[var_3] == -1) {
        var_1._id_EC74[var_3]["kills"] = 0;
      } else {
        var_1._id_EC74[var_3]["kills"] = level.killstreakcost[var_3];
      }
    }

    var_1._id_EC74[var_3]["supportCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 5));
    var_1._id_EC74[var_3]["scoreCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 6));
    var_1._id_EC74[var_3]["name"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 2);
    var_1._id_EC74[var_3]["shownInMenu"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 16);
    var_1._id_EC74[var_3]["workInProgress"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 27);
    var_1._id_EC74[var_3]["type"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 19);

    if(var_3 != "none") {
      var_4 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 7);
      game["dialog"][var_3] = var_4;
      var_5 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 8);

      if(issubstr(var_5, "|")) {
        var_5 = strtok(var_5, "|");
      }

      var_6 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 9);

      if(issubstr(var_6, "|")) {
        var_6 = strtok(var_6, "|");
      }

      if(scripts\mp\utility\game::_id_8701()) {
        game["dialog"]["allies_friendly_" + var_3 + "_inbound"] = var_5 + "_fuse";
        game["dialog"]["allies_enemy_" + var_3 + "_inbound"] = var_5 + "_euse";
      } else {
        game["dialog"]["allies_friendly_" + var_3 + "_inbound"] = var_5;
        game["dialog"]["allies_enemy_" + var_3 + "_inbound"] = var_6;
      }

      if(scripts\mp\utility\game::_id_8701()) {
        game["dialog"]["axis_friendly_" + var_3 + "_inbound"] = var_6 + "_fuse";
        game["dialog"]["axis_enemy_" + var_3 + "_inbound"] = var_6 + "_euse";
      } else {
        game["dialog"]["axis_friendly_" + var_3 + "_inbound"] = var_5;
        game["dialog"]["axis_enemy_" + var_3 + "_inbound"] = var_6;
      }

      if(scripts\mp\utility\game::_id_8701()) {
        game["dialog"]["use_" + var_3] = var_5 + "_use";
        game["dialog"]["destroyed_" + var_3] = var_5 + "_dest";
        game["dialog"]["timeout_" + var_3] = var_5 + "_ende";
      } else if(!_func_0107(var_5)) {
        game["dialog"]["use_" + var_3] = var_5 + "_use";
        game["dialog"]["destroyed_" + var_3] = var_5 + "_destroyed";
        game["dialog"]["timeout_" + var_3] = var_5 + "_timeout";
      }

      var_7 = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 11));
      scripts\mp\rank::_id_C2AC("killstreak_" + var_3, "value", var_7);
    }

    var_2++;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }

    if(!isDefined(var_0.pers["streakData"])) {
      var_0.pers["streakData"] = _id_4033();
    }

    var_0._id_E9FF = var_0.pers["streakData"];
    var_0 scripts\mp\utility\stats::_id_8257("streakPoints");
    var_0._id_EA13 = var_0 scripts\mp\utility\stats::_id_6C29("streakPoints");
    var_0._id_BC46 = var_0._id_EA13;
    var_0._id_A73E = var_0 scripts\mp\utility\stats::_id_6C29("cur_kill_streak");
    var_0 visionsetmissilecamforplayer(game["thermal_vision"]);

    if(!level._id_C945) {
      var_0 _id_C645(1);
    }
  }
}

onplayerspawned() {
  if(isDefined(level._id_43FA) && !level._id_43FA) {
    _id_C645(1);
  }

  _id_D068();

  if(!isDefined(self._id_50E9)) {
    self._id_50E9 = 0;
  }

  self._id_F628 = undefined;
  _id_D6F5();
  _id_FC9A();
  _id_FC9C();
  _id_FD47();
  _id_FD45();
  _id_F60D();
}

_id_4033() {
  var_0 = spawnStruct();
  var_0._id_EA14 = [];
  return var_0;
}

_id_6C66() {
  return self._id_E9FF;
}

_id_C612() {
  if(istrue(level._id_3324)) {
    return;
  }
  _id_FD33();
  _id_FD45();

  if(isDefined(self._id_AA37) && isDefined(self.perks) && self._id_AA37.size > 0) {
    if(scripts\engine\utility::_id_1BA1(self.perks, "specialty_support_killstreaks") && scripts\engine\utility::_id_1BA1(self._id_AA37, "specialty_support_killstreaks")) {
      return;
    } else if(!scripts\engine\utility::_id_1BA1(self._id_AA37, "specialty_support_killstreaks")) {
      return;
    } else {
      _id_C647();
      _id_C645();
      _id_FC9C();
      _id_FC9A();
    }
  }
}

_id_D883() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");
  self notifyonplayercommand("ks_select_up", "+actionslot 1");
  self notifyonplayercommand("ks_select_down", "+actionslot 2");
  self notifyonplayercommand("ks_action_5", "+actionslot 5");
  self notifyonplayercommand("ks_action_6", "+actionslot 6");
  self notifyonplayercommand("ks_action_3", "+actionslot 3");
  self notifyonplayercommand("ks_action_4", "+actionslot 4");
  self setactionslot(4, "");
}

_id_FD46() {
  if(self._id_EA13 == self._id_BC46) {
    return;
  }
  var_0 = self._id_EA13;
  _setclientkillstreakpoints(int(min(self._id_EA13, 16384)));

  if(!isDefined(self._id_A4DC) || self._id_EA13 >= self._id_A4DC) {
    _id_D6F5();
  }
}

_id_C646() {
  _setclientkillstreakpoints(0);
  self setclientomnvar("ui_score_streak_cost", 0);
  self setclientomnvar("ui_score_streak_two_cost", 0);
  self setclientomnvar("ui_score_streak_three_cost", 0);
  _id_D6F5();
}

_id_D6F5() {
  if(!isDefined(self._id_EA19)) {
    self._id_A4DC = 0;
    self _meth_80CA(0);
    return;
  }

  if(_id_5AF5() == 0) {
    self._id_A4DC = 0;
    self _meth_80CA(0);
    return;
  }

  var_0 = self._id_A4DC;
  var_1 = _id_6B91();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_2EC5(var_1);
  self._id_A4DC = var_2;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && isDefined(_id_6AE4(1)) && !istrue(self._id_50E8)) {
    var_3 = 0;

    foreach(var_5 in self._id_E9FF._id_EA14) {
      if(istrue(var_5._id_50E6)) {
        var_3 = 1;
        continue;
      }

      var_3 = 0;
    }

    if(var_3 && !isDefined(self._id_50E8)) {
      self._id_50E8 = 1;
      self._id_A4DC = 0;
      self _meth_80CA(0);
      _setclientkillstreakpoints(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      self setclientomnvar("ui_score_streak_two_cost", 0);
      self setclientomnvar("ui_score_streak_three_cost", 0);
      return;
    }
  }

  self _meth_80CA(var_2);
}

_id_6B91() {
  if(self._id_EA13 == _id_5AF5() && self._id_EA19 != "specialist") {
    var_0 = 0;
  } else {
    var_0 = self._id_EA13;
  }

  for(var_1 = 1; var_1 <= 4; var_1++) {
    var_2 = _id_6AE4(var_1);

    if(isDefined(var_2) && var_2._id_41BD > var_0) {
      return var_2.streakname;
    }
  }

  return undefined;
}

_id_FD47() {
  self setclientomnvar("ui_score_streak", self._id_EA13);
}

_id_FD45() {
  _id_FD44(1);
  _id_FD44(2);
  _id_FD44(3);
  _id_FD44(4);
}

_id_FD44(var_0) {
  var_1 = level._id_8DD5;
  var_2 = _id_6AE4(var_0);

  if(isDefined(var_2)) {
    var_3 = _id_2EC5(var_2.streakname);
    var_2._id_41BD = var_3;

    if(var_0 <= 3) {
      var_4 = var_1._id_3D93[var_0];
      self setclientomnvar(var_4, var_3);
    }
  }
}

_id_5AF5() {
  for(var_0 = 4; var_0 >= 1; var_0--) {
    var_1 = _id_6AE4(var_0);

    if(!isDefined(var_1)) {
      continue;
    }
    return var_1._id_41BD;
  }

  return 0;
}

_id_FC9C() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  var_0 = level._id_8DD5;

  for(var_1 = 0; var_1 <= 3; var_1++) {
    _id_FC9B(var_1);
  }
}

_id_FC9B(var_0) {
  if(var_0 > 3) {
    return;
  }
  var_1 = level._id_8DD5;
  var_2 = _id_6AE4(var_0);

  if(isDefined(var_2) && isDefined(var_2.streakname)) {
    var_3 = undefined;

    if(istrue(self._id_96A3) && var_0 != 0) {
      var_4 = scripts\mp\perks\perks::_id_6D68(var_2.streakname);
      var_3 = scripts\mp\perks\perks::_id_6C26(var_4);
    } else
      var_3 = scripts\mp\utility\killstreak::_id_6AE3(var_2.streakname);

    self setclientomnvar(var_1._id_DDF4[var_0], var_3);
    self setclientomnvar(var_1._id_1F92[var_0], var_2._id_1F84);
    _id_0CE4(var_0, var_3);
    _id_0CE2(var_0, var_2._id_1F84);
    _id_0CE3(var_0, var_2._id_41BD);
  } else {
    self setclientomnvar(var_1._id_DDF4[var_0], 0);
    self setclientomnvar(var_1._id_1F92[var_0], 0);
    _id_0CE4(var_0, 0);
    _id_0CE2(var_0, 0);
    _id_0CE3(var_0, 0);
  }
}

_id_FC9A() {
  var_0 = _id_6D1E();

  if(isDefined(var_0)) {
    self setclientomnvar("ui_score_streak_selected_slot", var_0);
  } else {
    self setclientomnvar("ui_score_streak_selected_slot", -1);
  }
}

_id_FD33() {
  if(isDefined(self._id_96A3)) {
    self setclientomnvar("ui_score_streak_is_specialist", self._id_96A3);
  }
}

_id_8DDE(var_0) {
  if(istrue(var_0._id_33DB)) {
    var_0 _id_394F();
  }
}

_id_9551(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "streak_select") {
    _id_4D05(undefined, var_1);
  }
}

_id_4D05(var_0, var_1) {
  if(isDefined(self._id_F628)) {
    if(self._id_F628.streakname != "warmachine" && self._id_F628.streakname != "lmg_streak") {
      return;
    }
  }

  if(isDefined(var_0) && issubstr(var_0, "ks_")) {
    var_1 = _id_6DFE(var_0);
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_6AE4(var_1);

  if(!isDefined(var_2) || var_2._id_1F84 == 0 || var_2._id_1F84 == -1) {
    return;
  }
  _id_D6C1(var_1);
  thread _id_F62A(var_2, var_1);
}

_id_F763(var_0) {
  var_1 = _id_4057(var_0);
  var_1._id_1F84 = 1;
  var_1._id_0EF1 = _id_07EE::_id_6DE4(gettime());
  return _id_F62A(var_1);
}

_id_6DFE(var_0) {
  var_1 = undefined;

  if(!isai(self)) {
    if(!self usinggamepad()) {
      if(var_0 == "ks_action_3" || var_0 == "ks_action_4" || var_0 == "ks_action_5" || var_0 == "ks_action_6") {
        var_1 = _id_6D1E();
      }
    }
  } else if(scripts\mp\utility\game::getgametype() == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 0;
        break;
      case "ks_action_4":
        var_1 = 0;
        break;
      case "ks_action_5":
        var_1 = 0;
        break;
      case "ks_action_6":
        var_1 = 0;
        break;
    }
  } else {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 1;
        break;
      case "ks_action_4":
        var_1 = 2;
        break;
      case "ks_action_5":
        var_1 = 3;
        break;
      case "ks_action_6":
        var_1 = 0;
        break;
    }
  }

  return var_1;
}

_id_88F5(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "dronedrop":
    case "uav":
    case "directional_uav":
    case "counter_uav":
      return 0;
    default:
      return 1;
  }
}

_id_F62A(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = var_0._id_EA15;

  if(!scripts\common\utility::_id_861B()) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_USED");
    return 0;
  }

  if(isDefined(level._id_9FC9) && !self[[level._id_9FC9]](var_0, var_1)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_USED");
    return 0;
  }

  if(var_0._id_8A51 || isDefined(self._id_F628) && self._id_F628 == var_0) {
    return 0;
  }

  self._id_F628 = var_0;
  _id_09B9::_id_EA00();
  var_3 = var_0.streakname;

  if(scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks") && scripts\cp_mp\utility\killstreak_utility::_id_C0B7(var_3)) {
    if(!istrue(self.pers["canKillChain"])) {
      self.pers["canKillChain"] = 1;
    }
  } else if(istrue(self.pers["canKillChain"]))
    self.pers["canKillChain"] = 0;

  if((var_3 == "airdrop" || var_3 == "airdrop_multiple") && scripts\mp\utility\perk::_hasperk("specialty_reaper") && scripts\cp_mp\utility\killstreak_utility::_id_C0B7(var_3)) {
    scripts\cp_mp\utility\killstreak_utility::_id_C0BE();
  }

  var_4 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0.streakname, self);
  var_4._id_A2B6 = var_0;
  scripts\mp\gamelogic::_id_D58D(self, 1);
  var_5 = self[[var_2._id_F61A]](var_4);

  if(!isDefined(self.pers["streakTypesUsed"])) {
    self.pers["streakTypesUsed"] = [];
  }

  switch (var_4.streakname) {
    case "intel":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "lmg_streak":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "uav":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "airdrop":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "counter_spy_plane":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "mortar_barrage":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "guard_dog":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "glide_bomb":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "precision_airstrike":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "warmachine":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "toma_strike":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "airdrop_multiple":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "juggernaut":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "white_phosphorus":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "attack_dogs":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "air_superiority":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "directional_uav":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "ball_turret_gunner":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "paratroopers":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "nuke":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
    case "pac_sentry":
      self.pers["streakTypesUsed"][var_4.streakname] = 1;
      break;
  }

  if(isDefined(var_4.streakname)) {
    thread _id_07BC::createkillstreakchallengeevent(self, self, 0, 0, "killstreak_calledIn", var_4.streakname);
  }

  self._id_F628 = undefined;

  if(!istrue(var_5)) {
    return 0;
  }

  if(isDefined(var_1)) {
    _id_ABB2(var_0, var_1);
  }

  return 1;
}

_id_AB1A(var_0) {
  return 1;
}

_id_AB12(var_0) {
  var_1 = var_0.owner;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 scripts\mp\utility\killstreak::_id_FF5A(var_0.streakname)) {
    return 0;
  }

  return 1;
}

_id_AB17(var_0, var_1) {}

_id_5E77(var_0, var_1) {
  var_2 = _id_4057(var_0);
  _id_F62A(var_2);
}

_id_5E76() {
  var_0 = _id_6AE4(0);
  _id_F62A(var_0);
}

_id_ABB2(var_0, var_1) {
  var_2 = var_0.streakname;
  var_0._id_1F84 = -1;
  _id_0CE2(var_1, var_0._id_1F84);
  var_3 = scripts\mp\utility\game::getgametype() == "br";

  if(isDefined(var_1)) {
    if(var_3 || (var_1 == 0 || var_1 >= 5)) {
      _id_C4DC(var_1);
    }

    _id_D072();
    _id_FC9B(var_1);
  } else {}

  thread _id_07BC::_id_FE4D(var_2);
  scripts\mp\utility\print::_id_BD15("killstreak started - " + var_2, self);
  thread killstreakvowithoutoverlap(var_2);
  var_6 = _id_07EE::_id_6DE4(gettime());
  var_0._id_0EF1 = var_6;
  _id_07A9::_id_9770(self, var_0._id_EA10, var_0.streakname, var_0._id_887C, var_6, self.origin);

  if(isDefined(self.pers["telemetry"]) && isDefined(self.pers["telemetry"].num_killstreaks_used)) {
    self.pers["telemetry"].num_killstreaks_used++;
  }

  scripts\mp\utility\stats::_id_7DAE("killstreaksUsed", 1);

  switch (var_2) {
    case "care_package":
      scripts\mp\utility\stats::_id_7DAE("killstreakCarePackageUsed", 1);
      break;
    case "emergency_airdrop":
      scripts\mp\utility\stats::_id_7DAE("killstreakEmergencyAirdropUsed", 1);
      break;
  }

  _id_3ABE(var_2);

  if(isDefined(self._id_B030)) {
    _id_0798::_id_10DB();

    if(var_0._id_41BD > 7) {
      _id_0798::_id_1168();
    }

    if(var_2 == "nuke") {
      _id_0798::_id_1101();
    }
  }
}

killstreakvowithoutoverlap(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = "";

  switch (var_0) {
    case "uav":
      var_1 = "spac";
      break;
    case "juggernaut":
      var_1 = "ftac";
      break;
    case "directional_uav":
      var_1 = "liac";
      break;
    case "mortar_barrage":
      var_1 = "mbac";
      break;
    case "precision_airstrike":
      var_1 = "srac";
      break;
    case "toma_strike":
      var_1 = "brac";
      break;
    case "fuel_airstrike":
    case "white_phosphorus":
      var_1 = "fbac";
      break;
    case "guard_dog":
      var_1 = "gdac";
      break;
    case "attack_dogs":
      var_1 = "adac";
      break;
    case "ball_turret_gunner":
      var_1 = "btac";
      break;
    case "glide_bomb":
      var_1 = "gbac";
      break;
    default:
      var_1 = "";
      break;
  }

  if(var_1 != "") {
    wait(_func_0142(self._id_AC3D.voiceprefix + "_" + self._id_AC3D._id_10691 + "_" + var_1) / 1000.0);
  }

  _id_0A8D::_id_B871(var_0);
}

storekillstreak(var_0) {
  var_1 = _id_6A1A(var_0);

  if(isDefined(var_1)) {
    _id_99F8(var_1);
  } else {
    _id_1FC8(var_0);
  }
}

_id_4057(var_0) {
  var_1 = spawnStruct();
  var_1._id_1F84 = 0;
  var_1.streakname = var_0;
  var_1._id_887C = 0;
  var_1._id_EA15 = _id_6AEA(var_0);
  var_1._id_9925 = -1;
  var_1._id_41BD = _id_2EC5(var_0);
  var_1._id_8A51 = scripts\mp\perks\perks::_id_8A53(var_0);
  var_1._id_E3CF = scripts\mp\perks\perks::_id_6D68(var_0);
  return var_1;
}

_id_1FC8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_4057(var_0);
  _id_1FC9(var_6, var_2, var_3, var_4, var_5);

  if(scripts\mp\utility\perk::_hasperk("specialty_reaper")) {
    var_7 = _id_5AF3(var_6);

    if(!isDefined(var_7)) {
      var_7 = self._id_E9FF._id_EA14.size;
    }

    self._id_E9FF._id_EA14[var_7] = var_6;
    self._id_E9FF._id_EA14[var_7]._id_C0B4 = 1;
  }
}

_id_1FC9(var_0, var_1, var_2, var_3, var_4) {
  var_0._id_887C = 1;
  var_5 = 0;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_1)) {
      var_1 = var_0._id_EA0F;
    }

    if(!isDefined(var_2)) {
      var_2 = var_0._id_EA10;
    }
  }

  _id_DDF3(var_0, var_5);
  _id_D6C1(var_5);
  _id_99F8(var_5, var_1, var_2, var_3);

  if(scripts\mp\utility\perk::_hasperk("specialty_reaper") && !istrue(self._id_967C)) {
    var_6 = _id_5AF3(var_0);

    if(!isDefined(var_6)) {
      var_6 = self._id_E9FF._id_EA14.size;
    }

    self._id_E9FF._id_EA14[var_6] = var_0;
    self._id_E9FF._id_EA14[var_6]._id_C0B4 = 1;
  }
}

_id_5551(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = _id_4057(var_0);
  _id_DDF3(var_2, var_1);
}

_id_5593(var_0) {
  _id_5551(var_0, 1);
}

_id_5595(var_0) {
  _id_5551(var_0, 2);
}

_id_5594(var_0) {
  _id_5551(var_0, 3);
}

_id_BE55() {
  var_0 = _id_6C66();

  if(isDefined(var_0._id_EA14[36])) {
    return 0;
  }

  var_1 = var_0._id_EA14[0];

  if(!isDefined(var_1)) {
    return 1;
  }

  for(var_2 = 5; var_2 < 37; var_2++) {
    if(!isDefined(var_0._id_EA14[var_2])) {
      var_0._id_EA14[var_2] = var_1;
      var_0._id_EA14[0] = undefined;
      break;
    }
  }

  return 1;
}

_id_B9EF() {
  var_0 = _id_6C66();
  var_1 = var_0._id_EA14[0];
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 5; var_4 < 37; var_4++) {
    var_5 = var_0._id_EA14[var_4];

    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = var_4;
      continue;
    }

    break;
  }

  var_0._id_EA14[0] = var_2;

  if(isDefined(var_3)) {
    var_0._id_EA14[var_3] = undefined;
  }
}

_id_4793(var_0) {
  var_1 = _id_6C66();

  if(var_0 == 36) {
    var_1._id_EA14[var_0] = undefined;
    return;
  }

  for(var_2 = var_0; var_2 < 36; var_2++) {
    var_3 = var_1._id_EA14[var_2 + 1];

    if(!isDefined(var_3)) {
      break;
    }

    var_1._id_EA14[var_0] = var_3;
  }
}

_id_C4DC(var_0) {
  self._id_E9FF._id_EA14[var_0] = undefined;

  if(var_0 == 0) {
    _id_B9EF();
  } else if(var_0 >= 5) {
    _id_4793(var_0);
  }
}

_id_394F() {
  self._id_E9FF._id_EA14 = [];
  _id_C647();
  _id_C645();
  _id_3950();
  _id_FC9C();
  _id_FC9A();
}

_id_DDF3(var_0, var_1) {
  if(var_1 == 0) {
    if(!_id_BE55()) {
      return;
    }
  } else {}

  self._id_E9FF._id_EA14[var_1] = var_0;
  _id_FC9B(var_1);

  if(var_1 != 0) {
    _id_FD44(var_1);
  }
}

_id_50EA(var_0, var_1) {
  var_2 = _id_6AE4(var_0);
  var_3 = var_2.streakname;
  scripts\mp\utility\script::_id_2C9F("earned_killstreak_buffered", var_3);
  self._id_50E9 = var_1;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    self._id_E9FF._id_EA14[var_0]._id_50E6 = 1;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_reaper")) {
    self._id_E9FF._id_EA14[var_0]._id_C0B4 = 1;
  }

  self._id_E9FF._id_EA14[var_0]._id_936C = scripts\cp_mp\utility\killstreak_utility::_id_69A7();

  if(!level.gameended) {
    thread scripts\mp\hud_message::_id_DCBD(var_3, var_1);
    _id_0A8D::_id_B86E(var_3, "killstreak_earned", 1);
    _id_3ABB(var_3);
  }

  _id_D6F5();
  _id_99F8(var_0);
  var_4 = self getentitynumber();
  scripts\mp\codcaster_utils::sendcodcasternotification(0, var_4, var_0);
}

_id_99F8(var_0, var_1, var_2, var_3) {
  var_4 = _id_6AE4(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_4.streakname;
  _id_9612(var_5);
  var_6 = var_4._id_EA15;

  if(self.team == "spectator") {
    return;
  }
  var_4._id_1F84 = 1;
  _id_0CE2(var_0, var_4._id_1F84);
  _id_D6C1(var_0);
  _id_FC9B(var_0);

  if(isDefined(var_6._id_1F91)) {
    self[[var_6._id_1F91]](var_4);
  }

  if(var_4._id_887C) {
    self notify("received_earned_killstreak");
  }

  var_4._id_9925 = _id_07EE::_id_6DE4(gettime());
  var_4._id_EA0F = self._id_936C;
  var_4._id_EA10 = self._id_9BC0;
  var_4.owner = self;
  var_4._id_ADB5 = self getxuid();

  if(isDefined(var_1)) {
    var_4._id_EA0F = var_1;
  }

  if(isDefined(var_2)) {
    var_4._id_EA10 = var_2;
  }

  if(isDefined(var_3)) {
    var_4.owner = var_3;
    var_4._id_ADB5 = var_3 getxuid();
  }

  _id_07A9::_id_9771(self, var_4._id_EA10, var_4.streakname, var_4._id_887C, var_4._id_9925, self.origin);

  if(isDefined(self.pers["telemetry"]) && isDefined(self.pers["telemetry"].num_killstreaks_earned)) {
    self.pers["telemetry"].num_killstreaks_earned++;
  }
}

_id_0CE4(var_0, var_1) {
  if(var_0 > 3) {
    return;
  }
  _id_07BF::_id_D4D7(18, var_0, var_1);
}

_id_0CE2(var_0, var_1) {
  if(var_0 > 3) {
    return;
  }
  if(var_1 < 0) {
    var_1 = 0;
  }

  _id_07BF::_id_D4D7(19, var_0, var_1);
}

_id_0CE3(var_0, var_1) {
  if(var_0 > 3 || !isDefined(var_1)) {
    return;
  }
  _id_07BF::_id_D4D7(17, var_0, var_1);
}

_setclientkillstreakpoints(var_0) {
  _id_07BF::_id_D4D9(23, var_0);
}

givekillstreak(var_0, var_1, var_2, var_3) {
  _id_1FC8(var_0, var_3);
}

_id_2EC5(var_0) {
  var_1 = int(scripts\mp\utility\killstreak::_id_6AE5(var_0));

  if(isDefined(self) && isPlayer(self)) {
    var_1 = var_1 + _id_6C25(var_0, var_1);
  }

  var_1 = int(clamp(var_1, 0, 7000));
  return var_1;
}

_id_6C25(var_0, var_1) {
  var_2 = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    var_3 = scripts\mp\utility\killstreak::_id_6AE3(var_0);
    var_2 = 175 * var_3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && var_1 > 0 && var_0 != "nuke") {
    if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
      var_2 = var_2 - 125;
    } else {
      var_2--;
    }
  }

  return var_2;
}

_id_8DE4() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("ks_select_up", "ks_select_down");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(!istrue(self._id_87A7)) {
      var_1 = _id_6D1E();

      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = var_1;

      if(var_0 == "ks_select_up") {
        var_2 = _id_6B8E(var_1);
      } else if(var_0 == "ks_select_down") {
        var_2 = _id_6C8B(var_1);
      } else {}

      _id_D6C1(var_2);
    }
  }
}

_id_D068() {
  var_0 = _id_6C66();

  if(isDefined(var_0._id_EA14[0])) {
    if(var_0._id_EA14[0]._id_1F84 == 1) {
      _id_D6C1(0);
      return;
    }
  } else {
    for(var_1 = 3; var_1 >= 0; var_1--) {
      var_2 = var_0._id_EA14[var_1];

      if(isDefined(var_2) && var_2._id_1F84 == 1) {
        _id_D6C1(var_1);
        return;
      }
    }
  }

  _id_3950();
}

_id_6B8E(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 >= 3, 0, var_0 + 1);
  var_3 = var_0;
  var_4 = var_2;

  while(var_4 != var_3) {
    var_5 = self._id_E9FF._id_EA14[var_4];

    if(isDefined(var_5) && var_5._id_1F84 == 1) {
      var_1 = var_4;
      break;
    }

    var_4++;

    if(var_4 > 3) {
      var_4 = 0;
    }
  }

  return var_1;
}

_id_6C8B(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 <= 0, 3, var_0 - 1);
  var_3 = var_0;
  var_4 = var_2;

  while(var_4 != var_3) {
    var_5 = self._id_E9FF._id_EA14[var_4];

    if(isDefined(var_5) && var_5._id_1F84 == 1) {
      var_1 = var_4;
      break;
    }

    var_4--;

    if(var_4 < 0) {
      var_4 = 3;
    }
  }

  return var_1;
}

_id_D070() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = 3; var_2 >= 0; var_2--) {
    var_3 = self._id_E9FF._id_EA14[var_2];

    if(isDefined(var_3) && var_3._id_1F84 == 1) {
      if(var_3._id_41BD > var_1) {
        var_0 = var_2;
        var_1 = var_3._id_41BD;
      }
    }
  }

  if(!isDefined(var_0)) {
    _id_3950();
    return;
  }

  _id_D6C1(var_0);
}

_id_D072() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = 0; var_2 <= 3; var_2++) {
    var_3 = self._id_E9FF._id_EA14[var_2];

    if(isDefined(var_3) && var_3._id_1F84 == 1) {
      if(istrue(var_3._id_887C)) {
        var_0 = var_2;
        break;
      } else if(var_3._id_41BD > var_1) {
        var_0 = var_2;
        var_1 = var_3._id_41BD;
      }
    }
  }

  if(!isDefined(var_0)) {
    _id_3950();
    return;
  }

  _id_D6C1(var_0);
}

_id_D6C1(var_0) {
  if(var_0 != 0 && istrue(self._id_96A3)) {
    return;
  }
  var_1 = _id_6AE4(var_0);
  self._id_41EE = var_0;
  _id_FC9A();
}

_id_3950() {
  self._id_41EE = undefined;
  _id_FC9A();
}

_id_6D1D() {
  var_0 = _id_6D1E();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return self._id_E9FF._id_EA14[var_0];
}

_id_6D1E() {
  return self._id_41EE;
}

_id_6AE4(var_0) {
  return self._id_E9FF._id_EA14[var_0];
}

_id_6A19(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_2;
    }
  }

  return undefined;
}

_id_6A1A(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_1;
    }
  }

  return undefined;
}

_id_6E44(var_0) {
  for(var_1 = 0; var_1 <= 3; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0 && var_2._id_1F84 == 1) {
      return var_1;
    }
  }

  return undefined;
}

_id_6AEC(var_0) {
  for(var_1 = 0; var_1 <= 3; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_1;
    }
  }

  return undefined;
}

_id_6A6C() {
  var_0 = [];
  var_1 = _id_6AE4(0);

  if(isDefined(var_1)) {
    var_0[0] = var_1;

    for(var_2 = 5; var_2 < 37; var_2++) {
      var_3 = self._id_E9FF._id_EA14[var_2];

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
        continue;
      }

      break;
    }
  }

  return var_0;
}

_id_68EA() {
  var_0 = [];

  if(self._id_E9FF._id_EA14.size > 0) {
    for(var_1 = 1; var_1 < 4; var_1++) {
      var_2 = self._id_E9FF._id_EA14[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2._id_1F84 == 1) {
        var_0[var_0.size] = var_2;
      }
    }
  }

  return var_0;
}

_id_68A4() {
  var_0 = [];

  if(self._id_E9FF._id_EA14.size > 0) {
    for(var_1 = 0; var_1 < 3; var_1++) {
      var_2 = self._id_E9FF._id_EA14[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2._id_1F84 == 1) {
        var_0[var_0.size] = var_2;
      }
    }
  }

  return var_0;
}

_id_C26A(var_0, var_1, var_2) {
  if(!isDefined(level._id_8DE6)) {
    level._id_8DE6 = [];
  }

  var_3 = spawnStruct();
  level._id_8DE6[var_0] = var_3;
  var_3._id_F61A = var_1;
  var_3._id_1F91 = var_2;
}

_id_6AEA(var_0) {
  var_1 = level._id_8DE6[var_0];
  return var_1;
}

_id_3561(var_0) {
  for(var_1 = 1; var_1 <= 4; var_1++) {
    var_2 = _id_6AE4(var_1);

    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = var_2._id_41BD;

    if(self._id_BC46 >= var_3 || var_0 < var_3) {
      continue;
    }
    if(isDefined(var_2.skip) && var_2.skip) {
      continue;
    }
    if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && istrue(var_2._id_50E6)) {
      continue;
    }
    if(isDefined(var_2._id_936C) && var_2._id_936C == self._id_936C) {
      continue;
    }
    _id_50EA(var_1, var_3);
  }
}

_id_1A5A(var_0) {
  var_1 = _id_6C66();

  if(!isDefined(var_1) || !isDefined(var_1._id_EA14)) {
    return 0;
  }

  foreach(var_3 in var_0) {
    var_4 = 0;

    for(var_5 = 1; var_5 <= 4; var_5++) {
      var_6 = var_1._id_EA14[var_5];

      if(isDefined(var_6)) {
        if(isDefined(var_6.streakname) && var_6.streakname == var_3) {
          if(var_6._id_8A51) {
            var_7 = scripts\mp\perks\perks::_id_6D68(var_3);

            if(var_6._id_E3CF == var_7) {
              var_4 = 1;
              break;
            }
          } else {
            var_4 = 1;
            break;
          }
        }

        continue;
      }

      if(var_3 == "none") {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      return 0;
    }
  }

  return 1;
}

_id_5AF3(var_0) {
  for(var_1 = 0; var_1 <= 37; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(!isDefined(var_2)) {
      if(var_1 >= 5) {
        break;
      }
    } else if(var_0 == var_2)
      return var_1;
  }

  return undefined;
}

_id_EA0C(var_0) {
  if(isDefined(var_0._id_A2B6)) {
    var_1 = _id_AB1A(var_0);

    if(!var_1) {
      return 0;
    }
  }

  return 1;
}

_id_EA0A(var_0) {
  var_1 = var_0.owner;

  if(isDefined(var_0._id_A2B6)) {
    var_2 = _id_AB12(var_0);

    if(!var_2) {
      return 0;
    }
  }

  if(isDefined(var_1)) {
    if(level.codcasterenabled) {
      if(_id_88F5(var_0.streakname)) {
        var_1 _meth_80CD(1);
      }
    }

    var_3 = var_1 getentitynumber();
    scripts\mp\codcaster_utils::sendcodcasternotification(1, var_3, var_1 _id_6AEC(var_0.streakname));

    if(scripts\mp\utility\game::_id_8932()) {
      var_4 = int(_func_0222("mp/killstreaktable.csv", 1, var_0.streakname, 4));

      if(var_4 >= 1000) {
        var_5 = _func_0222("mp/killstreaktable.csv", 1, var_0.streakname, 0);

        if(var_5 != "") {
          var_6 = int(var_5);
        }
      }
    }
  }

  var_1 notify("begin_use_streak");
  return 1;
}

_id_EA0B(var_0) {
  var_1 = var_0.owner;
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1 scripts\mp\utility\killstreak::_id_7599(var_0);
  }

  if(isDefined(var_0._id_A2B6)) {
    _id_AB17(var_0, var_2);
  }

  if(istrue(var_0._id_C0B4)) {
    var_0._id_C0B4 = undefined;
  }

  if(isDefined(var_1)) {
    if(!var_2) {
      var_1 notify("killstreak_use_finished");
    }

    if(level.codcasterenabled) {
      var_1 _meth_80CD(0);
    }

    if(scripts\engine\utility::is_equal(level.gametype, "base")) {
      var_1 thread scripts\mp\gametypes\s4_base_loot::s4_base_killstreak_finished(var_0.streakname);
    }
  }

  var_1 notify("end_use_streak");
}

_id_6FF5(var_0, var_1, var_2) {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"), var_2, var_1);

  if(!isDefined(var_3)) {
    var_3 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  if(var_3 == 0) {
    return;
  }
  self.pers["killstreakToScorestreak"] = undefined;
  self.pers["killstreakToScorestreak_lifeId"] = undefined;
  var_4 = self._id_EA13 + var_3;
  var_5 = _id_5AF5();

  if(var_4 > var_5) {
    var_4 = var_5;
  }

  var_6 = var_0 == "kill";

  if(var_6 && !istrue(level._id_4ADA) && (istrue(level._id_15BD) || isDefined(level._id_B027))) {
    var_7 = self._id_A73E + var_1;
    var_8 = _id_2EC5("nuke");

    if(isDefined(level._id_B027)) {
      var_8 = level._id_B027;
    }

    if(var_7 > var_8) {
      self._id_A73E = var_8;
    } else {
      self._id_A73E = var_7;

      if(self._id_A73E == var_8) {
        thread scripts\mp\hud_message::_id_DCBD("nuke", var_8);
        _id_1FC8("nuke", self);
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() == "kspoint") {
    return;
  }
  _id_D6F6(var_4);
  _id_3561(var_4);
  _id_FD47();
  _id_07A9::_id_9781(var_3, gettime(), scripts\mp\rank::_id_6D0C(var_0, "eventID"));
}

_id_878E(var_0) {
  return var_0 == "bounty";
}

_id_88F0(var_0) {
  return issubstr(var_0, "ss_kill") || var_0 == "killstreak_full_score";
}

_id_C647() {
  self._id_50E9 = 0;
  self._id_A73E = 0;
  _id_D6F6(0);
  _id_C646();
  _id_FD47();
}

_id_C645(var_0) {
  if(!isDefined(self)) {
    return;
  }
  for(var_1 = 0; var_1 <= 4; var_1++) {
    var_2 = self._id_E9FF._id_EA14[var_1];

    if(isDefined(var_2) && isDefined(var_2.streakname)) {
      if(istrue(var_0)) {
        var_2._id_1F84 = 0;
      } else if(istrue(var_2._id_8A51)) {
        var_2._id_1F84 = 0;
      } else if(var_2._id_1F84 == -1) {
        var_2._id_1F84 = 0;
      }

      _id_0CE2(var_1, var_2._id_1F84);
    }
  }
}

_id_F60D() {
  for(var_0 = 1; var_0 <= 4; var_0++) {
    var_1 = self._id_E9FF._id_EA14[var_0];

    if(isDefined(var_1) && istrue(var_1._id_1F84)) {
      var_2 = var_1._id_EA15;

      if(isDefined(var_2._id_1F91)) {
        self[[var_2._id_1F91]](var_1);
      }
    }
  }
}

_id_D6F6(var_0, var_1) {
  if(var_0 < 0) {
    var_0 = 0;
  }

  if(istrue(var_1)) {
    self._id_BC46 = var_0;
  } else if(isDefined(self._id_EA13)) {
    self._id_BC46 = self._id_EA13;
  } else {
    self._id_BC46 = 0;
  }

  self._id_EA13 = var_0;
  _id_FD46();
}

_id_E9CC() {
  level waittill("game_ended");

  if(level._id_C944) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = 0;

      if(isDefined(var_1._id_EA13)) {
        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
          var_2 = _id_0A6B::_id_8DEA(var_1._id_EA13);
        } else {
          var_2 = var_1._id_EA13;
        }
      }

      var_1.pers["streakPoints"] = var_2;
    }
  }
}

_id_5B0C(var_0, var_1, var_2, var_3) {
  var_4 = rotatevector((0, 0, 1), (-1 * var_3, 0, 0));
  var_5 = vectortoangles(var_1 - var_0.origin);

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + 30) {
    var_7 = var_2 * rotatevector(var_4, (0, var_6 + var_5[1], 0));
    var_8 = var_1 + var_7;

    if(_id_0BE5(var_0, var_8, var_1)) {
      return var_8;
    }
  }

  return undefined;
}

_id_5B0B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_0.origin - var_1);

  for(var_7 = var_3; var_7 <= var_4; var_7 = var_7 + var_5) {
    var_8 = rotatevector((1, 0, 0), (var_7 - 90, 0, 0));
    var_9 = var_2 * rotatevector(var_8, (0, var_6[1], 0));
    var_10 = var_1 + var_9;

    if(_id_0BE5(var_0, var_10, var_1)) {
      return var_10;
    }
  }

  return undefined;
}

_id_0BE5(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::_bullet_trace(var_1, var_2, 0);

  if(var_3["fraction"] > 0.99) {
    return 1;
  }

  return 0;
}

_id_5B0A(var_0, var_1, var_2) {
  var_3 = _id_5B0C(var_0, var_1, var_2, 30);

  if(!isDefined(var_3)) {
    var_3 = _id_5B0B(var_0, var_1, var_2, 15, 75, 15);
  }

  return var_3;
}

_id_8DD6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_2.owner)) {
      var_2 _id_FD1F(var_0, var_4);

      if(scripts\mp\utility\weapon::_id_88F6(var_1.basename)) {
        return;
      }
      var_5 = getcompleteweaponname(var_1);

      if(!isDefined(var_0._id_8FF1[var_5])) {
        var_0._id_8FF1[var_5] = 0;
      }

      if(var_0._id_8FF1[var_5] == gettime()) {
        return;
      }
      var_0._id_8FF1[var_5] = gettime();
      var_0 thread scripts\mp\gamelogic::_id_F13D(var_5, 1, "hits");

      if(scripts\mp\utility\game::onlinestatsenabled()) {
        var_6 = var_0 _id_0804::_id_6C64("combatStats", "totalShots");
        var_7 = var_0 _id_0804::_id_6C64("combatStats", "hits") + 1;

        if(var_7 <= var_6) {
          var_0 _id_0804::_id_D674(var_7, "combatStats", "hits");
          var_0 _id_0804::_id_D674(int(var_6 - var_7), "combatStats", "misses");
        }
      }

      if(isDefined(var_3) && scripts\engine\utility::_id_8794(var_3) || _id_0A8B::_id_89CC(var_3)) {
        var_0._id_8FB6 = gettime();
        var_8 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);

        if(var_8 == "weapon_lmg") {
          if(!isDefined(var_0._id_DA69)) {
            var_0._id_DA69 = 1;
          } else {
            var_0._id_DA69++;
          }
        }
      }
    }
  }
}

_id_FD20(var_0) {
  _id_FD1F(var_0, 150);
}

_id_FD1F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_CC5F)) {
    self._id_CC5F = [];
  }

  var_2 = var_0 getxuid();
  var_0._id_75AA = 1;

  if(!isDefined(self._id_CC5F[var_2])) {
    var_3 = spawnStruct();
    var_3.damage = 0;
    var_3.player = var_0;
    self._id_CC5F[var_2] = var_3;
  }

  self._id_CC5F[var_2].damage = self._id_CC5F[var_2].damage + var_1;
}

_id_6D13(var_0) {
  if(!isDefined(self._id_CC5F)) {
    return [];
  }

  var_1 = [];

  foreach(var_3 in self._id_CC5F) {
    var_4 = var_3.damage;
    var_5 = var_3.player;

    if(var_4 < 150) {
      continue;
    }
    var_6 = !scripts\mp\utility\player::_id_886C(self.team, var_5);
    var_7 = istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_5, self.owner));

    if(!var_6 && !var_7) {
      continue;
    }
    if(isDefined(var_0) && var_5 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

_id_6FEA(var_0, var_1) {
  if(isDefined(var_1) && weaponclass(var_1) != "rocketlauncher") {
    var_1 = undefined;
  }

  thread _id_0A9F::_id_7003("destroyed_equipment", var_1);
  _id_0793::_id_BD60(var_0, self);
}

givescoreforalliedkillsduringcounterspyplane() {
  thread _id_0A9F::_id_7003("ss_counter_uav_assist");
}

_id_6FE6() {
  thread _id_0A9F::_id_7003("destroyed_tac_insert");
}

_id_6FEE() {
  thread _id_0A9F::_id_7003("trophy_defense");
}

_id_6FE4() {
  thread _id_0A9F::_id_7003("blackhat_hack");
}

_id_6FEB() {
  thread _id_0A9F::_id_7003("hack");
}

_id_6FE9() {
  thread _id_0A9F::_id_7003("emped_vehicle");
}

_id_6FE7() {
  thread _id_0A9F::_id_7003("emped_killstreak");
}

_id_6FE8() {
  thread _id_0A9F::_id_7003("emped_player");
}

_id_6FEC(var_0) {
  if(var_0) {
    thread _id_0A9F::_id_7003("perk_marked_target");
  } else {
    thread _id_0A9F::_id_7003("perk_marked_target", undefined, 0);
  }
}

_id_6FE5() {
  thread _id_0A9F::_id_7003("perk_destroyed_target");
}

_id_6FE3() {
  thread _id_0A9F::_id_7003("perk_destroyed_target");
}

_id_6FED() {
  thread _id_0A9F::_id_7003("triggered_alarm");
}

_id_EA1A(var_0) {
  switch (var_0) {
    case "assault":
    case "specialist":
      return 1;
    case "resource":
    case "support":
      return 0;
    default:
      return 1;
  }
}

_id_827A(var_0) {
  scripts\common\utility::_id_158A(0);
  var_1 = _id_827B(var_0);

  if(isDefined(self)) {
    scripts\common\utility::_id_158A(1);
  }

  return var_1;
}

_id_827B(var_0) {
  if(isDefined(var_0) && _id_88FC(var_0)) {
    var_1 = "timeout";
  } else {
    var_1 = scripts\engine\utility::_id_108A9(1.0, "death", "disconnect", "weapon_switch_started");
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(var_1 == "disconnect" || var_1 == "death") {
    if(var_1 == "disconnect") {
      return "disconnect";
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return "success";
  }

  if(scripts\mp\utility\game::_id_88EE()) {
    return "fail";
  }

  if(!isDefined(var_0) || !issubstr(var_0, "pointSelect")) {
    if(var_0 == "drone_hive") {
      self _meth_844E("black_bw", 0);
      thread scripts\mp\utility\player::_id_D433("black_bw", 0, 1.0, undefined, 1);
      var_2 = scripts\engine\utility::_id_108A7(0, "death_or_disconnect");
    } else {
      self _meth_844E("black_bw", 0.75);
      thread scripts\mp\utility\player::_id_D433("black_bw", 0.75, 1.0, undefined, 1);
      var_2 = scripts\engine\utility::_id_108A7(0.8, "death_or_disconnect");
    }
  } else
    var_2 = scripts\engine\utility::_id_108A7(1.0, "death_or_disconnect");

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 != "disconnect") {
    if(!isDefined(var_0) || !issubstr(var_0, "pointSelect")) {
      thread _id_3973(1.0);
    } else {
      self notify("intro_cleared");
    }

    if(self.team == "spectator") {
      return "fail";
    }
  }

  if(self isonladder()) {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(scripts\mp\utility\game::_id_88EE()) {
    return "fail";
  }

  if(var_2 == "disconnect") {
    return "disconnect";
  } else {
    return "success";
  }
}

_id_88FC(var_0) {
  switch (var_0) {
    case "remote_tank":
    case "remote_uav":
    case "osprey_gunner":
    case "pointSelect":
    case "drone_hive":
    case "heli_pilot":
    case "precision_airstrike":
    case "ball_turret_gunner":
      return 1;
  }

  return 0;
}

_id_3973(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self _meth_844E("", var_1);
  scripts\mp\utility\player::_id_D433("", var_1);
  self notify("intro_cleared");
}

_id_15CF(var_0) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = self.owner;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("end_remote");
  self endon("death");
  var_2 = level._id_5F3A;
  var_3 = 0.75;
  var_4 = 1;

  for(;;) {
    var_5 = 0;

    if(var_4 == 1) {
      var_1 setclientomnvar("ui_exit_progress", 0);
      var_4 = 0;
    }

    while(var_1 useButtonPressed()) {
      var_5 = var_5 + var_2;
      var_4 = 1;
      var_1 setclientomnvar("ui_exit_progress", var_5 / var_3);

      if(var_5 > var_3) {
        self notify("killstreakExit");
        return;
      }

      wait(var_2);
    }

    wait(var_2);
  }
}

_id_3ABE(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::_id_6D95(var_0);

  if(!isDefined(var_1)) {
    if(var_0 != "nuke") {}

    return;
  }

  var_2 = self getplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "uses");
  self setplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "uses", var_2 + 1);
}

_id_34E8() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self._id_E9FF._id_EA14[self._id_E9FF._id_EA14.size];

  if(var_0._id_1F84 == 1 || var_0._id_1F84 == -1) {
    return 1;
  }

  return 0;
}

_id_9612(var_0) {
  var_1 = [];
  var_2 = scripts\cp_mp\utility\killstreak_utility::_id_6ADF(var_0);
  var_1[var_1.size] = var_2;
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6AE2(var_0);
  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  self loadweaponsforplayer(var_1, 1);
}

_id_3ABB(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::_id_6D95(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "awardedCount");
  self setplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "awardedCount", var_2 + 1);
}

_id_3ABC(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::_id_6D95(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "extraStat1");
  self setplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "extraStat1", var_2 + 1);
}

_id_CB52() {
  self._id_CB4E = self._id_EA13;
}

_id_96A9() {
  if(isDefined(self._id_CB4E) && self._id_CB4E > 0) {
    var_0 = self._id_CB4E + self._id_EA13;
    self._id_CB4E = 0;

    for(var_1 = 1; var_1 <= 4; var_1++) {
      var_2 = _id_6AE4(var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2._id_41BD <= self._id_CB4E) {
        var_2.skip = 1;
      }
    }

    _id_D6F6(var_0, 1);
    _id_3561(var_0);
    _id_FD47();
    _id_FC9C();
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "cipher_recover");

    for(var_1 = 1; var_1 <= 4; var_1++) {
      var_2 = _id_6AE4(var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      var_2.skip = 0;
    }

    self._id_CB4E = 0;
  }
}

_id_C63D() {
  self._id_CB4E = 0;
}