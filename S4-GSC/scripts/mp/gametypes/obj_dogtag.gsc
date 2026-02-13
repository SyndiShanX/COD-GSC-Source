/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dogtag.gsc
*************************************************/

init() {
  level._id_4CE8 = [];
  level._id_4CE2 = scripts\mp\gametypes\common::_id_4CE4;
  level._id_4CE6 = scripts\mp\gametypes\common::_id_4CE5;
  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level._id_A790 = scripts\mp\utility\game::_id_6A65();
}

_id_DBE1(var_0) {
  if(isDefined(self._id_EC33)) {
    return 0;
  }

  if(isDefined(var_0) && var_0 == self) {
    return 0;
  }

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "trigger_hurt" || var_0.classname == "worldspawn")) {
    return 0;
  }

  return 1;
}

_id_E298(var_0, var_1, var_2, var_3) {
  var_4 = var_1.team;
  var_5 = 1;

  if(istrue(level._id_A790)) {
    var_5 = var_0 _id_DBE1(var_1);

    if(var_5) {
      var_5 = var_5 && !scripts\mp\utility\player::isreallyalive(var_0);
    }
  }

  if(!var_5) {
    return;
  }
  if(isagent(var_0)) {
    return;
  }
  if(isagent(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
      var_4 = var_1.team;
    } else {
      var_6 = scripts\mp\utility\teams::_id_6A01(var_0.team);

      foreach(var_8 in var_6) {
        if(var_8 != var_1.team) {
          var_4 = var_8;
          break;
        }
      }
    }
  }

  var_10 = 14;
  var_11 = (0, 0, 0);
  var_12 = var_0.angles;

  if(var_0 _id_07D6::_id_F38E()) {
    var_12 = var_0 _meth_8541();
    var_11 = anglestoup(var_12);

    if(var_11[2] < 0) {
      var_10 = -14;
    }
  }

  if(isDefined(level._id_4CE8[var_0.guid])) {
    playFX(level._id_3B72["vanish"], level._id_4CE8[var_0.guid]._id_4140);
    level._id_4CE8[var_0.guid] _id_C64B();
    level._id_4CE8[var_0.guid]._id_10430[0].angles = (0, 0, 0);
    level._id_4CE8[var_0.guid]._id_10430[1].angles = (0, 0, 0);
  } else {
    var_13[0] = spawn("script_model", (0, 0, 0));
    var_13[1] = spawn("script_model", (0, 0, 0));

    if(getdvarint("#x3795fc8e1852226bd", 1)) {
      foreach(var_15 in var_13) {
        var_15 notsolid();
      }
    }

    if(scripts\mp\utility\game::isholidayenabled(2)) {
      var_13[0] setModel("s4_usa_kc_dogtags_01_holiday");
      var_13[1] setModel("s4_usa_kc_dogtags_01_holiday_blue");
    } else if(scripts\mp\utility\game::isholidayenabled(3)) {
      var_13[0] setModel("s4_usa_kc_dogtags_01_vday_pink");
      var_13[1] setModel("s4_usa_kc_dogtags_01_vday_blue");
    } else {
      var_13[0] setModel("s4_usa_kc_dogtags_01_red");
      var_13[1] setModel("s4_usa_kc_dogtags_01");
    }

    var_13[0] setasgametypeobjective();
    var_13[1] setasgametypeobjective();
    var_17 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

    if(var_0 _id_07D6::_id_F38E()) {
      if(var_11[2] < 0) {
        var_13[0].angles = var_12;
        var_13[1].angles = var_12;
      }
    }

    var_18 = "any";
    var_19 = 0;
    level._id_4CE8[var_0.guid] = _id_07D6::_id_406E(var_18, var_17, var_13, (0, 0, 16));
    level._id_4CE8[var_0.guid]._id_ABCB = ::_id_ABCB;
    level._id_4CE8[var_0.guid] _id_07D6::_id_D8D2(var_19);
    level._id_4CE8[var_0.guid]._id_103C2 = var_0;
    level._id_4CE8[var_0.guid]._id_103CC = var_0.team;
    level thread _id_3963(var_0);
    var_0 thread _id_ED77(level._id_4CE8[var_0.guid]);
  }

  var_20 = var_0.origin + (0, 0, var_10);
  level._id_4CE8[var_0.guid]._id_4140 = var_20;
  level._id_4CE8[var_0.guid].trigger.origin = var_20;
  level._id_4CE8[var_0.guid]._id_10430[0].origin = var_20;
  level._id_4CE8[var_0.guid]._id_10430[1].origin = var_20;
  level._id_4CE8[var_0.guid] _id_07D6::_id_81EA();
  level._id_4CE8[var_0.guid] _id_07D6::_id_15DF("any");
  level._id_4CE8[var_0.guid]._id_10430[0] _id_DCF7(level._id_4CE8[var_0.guid], var_4);
  level._id_4CE8[var_0.guid]._id_10430[1] _id_DCF7(level._id_4CE8[var_0.guid], var_0.team);
  level._id_4CE8[var_0.guid].attacker = var_1;
  level._id_4CE8[var_0.guid]._id_1DE3 = var_4;
  level._id_4CE8[var_0.guid]._id_ADAE = var_0.team;

  if(isDefined(level._id_4CE8[var_0.guid]._id_A908)) {
    if(level._id_4CE8[var_0.guid]._id_A908 != -1) {
      var_21 = level._id_4CE8[var_0.guid]._id_A908;
      _id_07F9::_id_FB9E(var_21, "current");
      _id_07F9::_id_FB97(var_21, var_0.origin + (0, 0, 36));
      _id_07F9::_id_FB98(var_21, 1);
      _id_07F9::_id_A8B1(level._id_4CE8[var_0.guid]._id_A908, 0);
      _id_07F9::_id_A8B2(level._id_4CE8[var_0.guid]._id_A908, 0);
      level._id_4CE8[var_0.guid] _id_07D6::_id_D61B("waypoint_dogtags_friendly", "waypoint_dogtags");
      level._id_4CE8[var_0.guid] _id_07D6::_id_D8E0("any");
    }
  }

  level notify(var_2, level._id_4CE8[var_0.guid]);
  level._id_4CE8[var_0.guid]._id_10430[0] _meth_82CB("mp_dogtag_spin");
  level._id_4CE8[var_0.guid]._id_10430[1] _meth_82CB("mp_dogtag_spin");
}

_id_C64B() {
  self.attacker = undefined;
  self notify("reset");
  self._id_10430[0] hide();
  self._id_10430[1] hide();
  self._id_10430[0] dontinterpolate();
  self._id_10430[1] dontinterpolate();
  self._id_4140 = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self._id_10430[0].origin = (0, 0, 1000);
  self._id_10430[1].origin = (0, 0, 1000);
  _id_07D6::_id_15DF("none");

  if(self._id_A908 != -1) {
    _id_07F9::_id_FB9E(self._id_A908, "done");
  }
}

_id_C52D(var_0, var_1) {
  if(isDefined(level._id_4CE8[var_0])) {
    level._id_4CE8[var_0] _id_07D6::_id_15DF("none");

    if(istrue(var_1) && isDefined(level._id_4CE8[var_0].attacker)) {
      level._id_4CE8[var_0].attacker thread scripts\mp\rank::_id_CC00("kill_denied");
    }

    playFX(level._id_3B72["vanish"], level._id_4CE8[var_0]._id_4140);
    level._id_4CE8[var_0] notify("reset");
    waitframe();

    if(isDefined(level._id_4CE8[var_0])) {
      level._id_4CE8[var_0] notify("death");

      for(var_2 = 0; var_2 < level._id_4CE8[var_0]._id_10430.size; var_2++) {
        level._id_4CE8[var_0]._id_10430[var_2] delete();
      }

      if(!isDefined(level._id_4CE8[var_0]._id_DDB5)) {
        level._id_4CE8[var_0] thread _id_07D6::_id_479D();
      }

      level._id_4CE8[var_0] = undefined;
    }
  }
}

_id_AB69(var_0) {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  foreach(var_2 in level._id_4CE8) {
    if(isDefined(var_2._id_1DE3)) {
      if(var_0.team == var_2._id_1DE3) {
        var_2._id_10430[0] showtoplayer(var_0);
      }

      if(var_0.team == "spectator" && var_2._id_1DE3 == "allies") {
        var_2._id_10430[0] showtoplayer(var_0);
      }
    }

    if(isDefined(var_2._id_ADAE)) {
      if(var_0.team == var_2._id_ADAE) {
        var_2._id_10430[1] showtoplayer(var_0);
      }

      if(var_0.team == "spectator" && var_2._id_ADAE == "allies") {
        var_2._id_10430[1] showtoplayer(var_0);
      }
    }
  }
}

_id_DCF7(var_0, var_1) {
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      self showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self showtoplayer(var_3);
    }
  }
}

_id_B673(var_0) {
  return 1;
}

_id_ABCB(var_0) {
  if(!_id_B673(var_0)) {
    return;
  }
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(scripts\mp\utility\game::getgametype() == "conf") {
    var_0 thread _id_10BF1();
  }

  if(var_0.pers["team"] == self._id_103CC) {
    var_0 playsoundtoplayer("ui_mp_confirmed_deny", var_0);
    var_0 scripts\mp\utility\stats::_id_7DAE("denied", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "denied", var_0.pers["denied"]);
    var_0 thread _id_07BC::creategametypechallenegeevent("conf_denied");
    _id_1625(var_0);

    if(isDefined(level._id_4CE2) && !level.gameended) {
      self thread[[level._id_4CE2]](var_0);
    }
  } else {
    if(scripts\mp\utility\game::isholidayenabled(2)) {
      var_0 playsoundtoplayer("mp_codmas_kill_confirmed_collect_layer", var_0);
    }

    var_0 playsoundtoplayer("ui_mp_confirmed_collect", var_0);

    if(scripts\mp\utility\game::getgametype() != "grind" && scripts\mp\utility\game::getgametype() != "pill") {
      var_0 scripts\mp\utility\stats::_id_7DAE("confirmed", 1);
      var_0 scripts\mp\persistence::_id_E770("round", "confirmed", var_0.pers["confirmed"]);
    }

    _id_5424(var_0);

    if(isDefined(level._id_4CE6) && !level.gameended) {
      self thread[[level._id_4CE6]](var_0);
    }
  }

  self._id_103C2 notify("tag_removed");
  thread _id_C52D(self._id_103C2.guid);
}

_id_10BF1() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("watchRapidTagPickup()");
  self endon("watchRapidTagPickup()");

  if(!isDefined(self._id_C0FE)) {
    self._id_C0FE = 1;
  } else {
    self._id_C0FE++;

    if(self._id_C0FE == 3) {
      thread _id_07B1::_id_6FB9("mode_kc_3_tags");
    }
  }

  wait 3.0;
  self._id_C0FE = 0;
}

_id_ED77(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");

  for(;;) {
    self waittill("joined_team");
    thread _id_C52D(self.guid, 1);
  }
}

_id_3963(var_0) {
  var_0 notify("clearOnVictimDisconnect");
  var_0 endon("clearOnVictimDisconnect");
  var_0 endon("tag_removed");
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");
  thread _id_C52D(var_1, 1);
}

_id_ABB7(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread _id_0A9F::_id_7003(var_0);
}

_id_936D(var_0) {
  var_0.pers["rescues"]++;
  var_0 scripts\mp\persistence::_id_E770("round", "rescues", var_0.pers["rescues"]);
  var_1 = [];
  var_1[var_1.size] = self._id_103C2;
  scripts\mp\hud_message::_id_A6B6("sr_ally_respawned", "sr_enemy_respawned", self._id_103C2);

  if(isDefined(self._id_103C2)) {
    self._id_103C2 thread scripts\mp\hud_message::showsplash("sr_respawned");
    level notify("sr_player_respawned", self._id_103C2);
    self._id_103C2 _id_0A8D::_id_9137("revived");

    if(!level.gameended) {
      self._id_103C2 thread _id_C671();
    }

    self._id_103C2._id_ED4A = undefined;
    self._id_103C2._id_0407 = "";
  }

  if(isDefined(self.attacker)) {
    self.attacker thread scripts\mp\rank::_id_CC00("kill_denied");
  }

  var_0 thread _id_ABB7("kill_denied");

  if(!isDefined(var_0._id_C596)) {
    var_0._id_C596 = [];
  }

  var_0._id_C596[self._id_103C2.guid] = 1;
}

_id_936E(var_0) {
  if(isDefined(self._id_103C2)) {
    self._id_103C2 thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self._id_103C2);
  }

  var_1 = [];
  var_1[var_1.size] = self._id_103C2;
  scripts\mp\hud_message::_id_A6B6("sr_ally_eliminated", "sr_enemy_eliminated", self._id_103C2.team);

  if(isDefined(self._id_103C2)) {
    if(!level.gameended) {
      self._id_103C2 _id_0A99::_id_D5EA(2);
      self._id_103C2 thread scripts\mp\playerlogic::_id_C522(3.0);
    }

    self._id_103C2._id_ED4A = undefined;
    self._id_103C2._id_0407 = "hud_status_dead";
  }

  if(self.attacker != var_0) {
    self.attacker thread _id_ABB7("kill_confirmed");
  }

  var_0 thread _id_ABB7("kill_confirmed");
  var_0 _id_0A8D::_id_9137("kill_confirmed");
}

_id_C671() {
  scripts\mp\playerlogic::_id_7DE8(self.team);
  self._id_1643 = 1;
  thread scripts\mp\playerlogic::_id_1094C();
}

_id_1625(var_0) {
  if(self._id_103C2 == var_0) {
    var_0 thread scripts\mp\rank::_id_CC00("tag_retrieved");
    var_0 thread _id_07B1::_id_6FB9("mode_kc_own_tags");
  } else if(issubstr(scripts\mp\utility\game::getgametype(), "conf"))
    var_0 _id_ABB7("kill_denied");
  else if(scripts\mp\utility\game::getgametype() != "grind") {
    var_0 _id_ABB7("tag_denied");
  } else {
    var_0 _id_ABB7("tag_collected");
    var_0 _id_B7A5(var_0._id_ED74 + 1);
  }

  if(isDefined(self.attacker)) {
    self.attacker thread scripts\mp\rank::_id_CC00("tag_denied");
  }

  if(isDefined(level._id_EB99) && level._id_EB99) {
    if(isDefined(var_0._id_3E59) && var_0._id_3E59) {
      var_0 _id_07C1::_id_D4EE("friendly_tag");
    } else {
      var_0 _id_07C1::_id_AA91(undefined, var_0);
    }
  }
}

_id_5424(var_0) {
  if(issubstr(scripts\mp\utility\game::getgametype(), "conf")) {
    var_0 _id_ABB7("kill_confirmed");
  } else {
    var_0 _id_ABB7("tag_collected");
  }

  if(scripts\mp\utility\game::getgametype() == "grind") {
    var_0 _id_B7A5(var_0._id_ED74 + 1);
  }

  if(self.attacker != var_0) {
    if(scripts\mp\utility\game::getgametype() == "grind") {
      self.attacker thread _id_ABB7("grind_friendly_pickup");
    } else {
      self.attacker thread _id_ABB7("kc_friendly_pickup");
    }
  }

  if(isDefined(level._id_EB99) && level._id_EB99) {
    if(isDefined(var_0._id_3E59) && var_0._id_3E59) {
      var_0 _id_07C1::_id_D4EE("kill");
    } else {
      var_0 _id_07C1::_id_AA91(undefined, var_0);
    }

    if(var_0 != self.attacker && isDefined(self.attacker._id_3E59) && self.attacker._id_3E59) {
      self.attacker _id_07C1::_id_D4EE("kill");
    }
  }
}

_id_B7A5(var_0) {
  self._id_ED74 = var_0;
  self._id_01F1 = var_0;

  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}