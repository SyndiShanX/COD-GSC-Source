/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\sr.gsc
********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_func_133()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 4);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  level._id_10EB = 1;
  level.objectivebased = 1;
  maps\mp\_utility::_id_873B(1);
  level._id_6702 = 1;
  level._id_6B86 = maps\mp\gametypes\common_sd_sr::_id_6B86;
  level._id_6BAF = ::_id_6BAF;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B7B = ::_id_6B7B;
  level._id_6AE2 = maps\mp\gametypes\common_sd_sr::_id_6AE2;
  level._id_6B5E = maps\mp\gametypes\common_sd_sr::_id_6B5E;
  level._id_6BB6 = maps\mp\gametypes\common_sd_sr::_id_6BB6;
  level._id_6B5C = maps\mp\gametypes\common_sd_sr::_id_6B5C;
  level._id_3FC7 = maps\mp\gametypes\common_sd_sr::_id_5782;
  level._id_0C25 = 0;

  if(level._id_6031 || level._id_6035)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  game["dialog"]["gametype"] = "sr_intro";

  if(getdvarint("2043"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["revived"] = "sr_rev";
  _func_032("ui_bomb_a_timer_endtime", 0);
  _func_032("ui_bomb_b_timer_endtime", 0);
  level._id_257E["vanish"] = loadfx("vfx/test/test_fx");
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  var_0 = _func_132("srData", "roundLength");
  _func_035("scr_sr_timelimit", var_0);
  maps\mp\_utility::registertimelimitdvar("sr", var_0);
  var_1 = _func_132("srData", "roundSwitch");
  _func_035("scr_sr_roundswitch", var_1);
  maps\mp\_utility::registerroundswitchdvar("sr", var_1, 0, 9);
  var_2 = _func_132("commonOption", "scoreLimit");
  _func_035("scr_sr_winlimit", var_2);
  maps\mp\_utility::registerwinlimitdvar("sr", var_2);
  _func_035("scr_sr_bombtimer", _func_132("srData", "bombTimer"));
  _func_035("scr_sr_planttime", _func_132("srData", "plantTime"));
  _func_035("scr_sr_defusetime", _func_132("srData", "defuseTime"));
  _func_035("scr_sr_multibomb", _func_132("srData", "multiBomb"));
  _func_035("scr_sr_silentplant", _func_132("srData", "silentPlant"));
  _func_035("scr_sr_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sr", 0);
  _func_035("scr_sr_scorelimit", 1);
  maps\mp\_utility::registerscorelimitdvar("sr", 1);
  _func_035("scr_sr_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sr", 0);
}

_id_6BAF() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  _func_157("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
  level._effect["search_dstry_bomb_arming_light"] = loadfx("vfx/unique/search_dstry_bomb_arming_light");
  maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  _id_050D::_id_10E4();
  var_2[0] = "sd";
  var_2[1] = "bombzone";
  var_2[2] = "blocker";
  _id_04D1::main(var_2);
  maps\mp\gametypes\common_sd_sr::_id_A121();
  level._id_31F9 = [];
  maps\mp\gametypes\common_sd_sr::_id_872D();
  thread maps\mp\gametypes\common_sd_sr::_id_18FD();
}

_id_6BA7() {
  var_0 = isDefined(self._id_57A7) && self._id_57A7;
  self._id_5777 = 0;
  self._id_56C2 = 0;

  if(!var_0) {
    self._id_568D = 0;
    self._id_0112 = 0;
  }

  if(isPlayer(self) && !var_0) {
    if(level._id_6510 && self.pers["team"] == game["attackers"]) {
      self _meth_82FF("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::_id_9102("bomb_pickedup");
    } else
      self _meth_82FF("ui_carrying_bomb", 0);
  }

  self._id_57A7 = undefined;
  level notify("spawned_player");

  if(self._id_0179 == "axis" || self._id_0179 == "allies") {
    level notify("sr_player_joined", self);
    maps\mp\_utility::_id_867B(0);

    if(isDefined(self.pers["plants"]))
      maps\mp\_utility::_id_867B(self.pers["plants"]);

    maps\mp\_utility::_id_867C(0);

    if(isDefined(self.pers["defuses"]))
      maps\mp\_utility::_id_867C(self.pers["defuses"]);

    self._id_0021 = 0;

    if(isDefined(self.pers["denied"]))
      self._id_0021 = self.pers["denied"];
  }
}

_id_8BAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_9566))
    return 0;

  if(isDefined(self._id_A878))
    return 0;

  if(isDefined(var_1) && var_1 == self)
    return 0;

  if(level.teambased && isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.team)
    return 0;

  if(isDefined(var_1) && !isDefined(var_1.team) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn"))
    return 0;

  return 1;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isPlayer(self))
    self _meth_82FF("ui_carrying_bomb", 0);

  if(!maps\mp\_utility::gameflag("prematch_done"))
    maps\mp\gametypes\_playerlogic::mayspawn();
  else {
    var_10 = _id_8BAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_10)
      var_10 = var_10 && !maps\mp\_utility::isreallyalive(self);

    if(var_10)
      var_10 = var_10 && !maps\mp\gametypes\_playerlogic::mayspawn();

    if(var_10)
      level thread _id_903E(self, var_1);
  }

  thread maps\mp\gametypes\common_sd_sr::_id_21AB();
  maps\mp\gametypes\common_sd_sr::_id_254C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_903E(var_0, var_1) {
  if(_func_1EF(var_0)) {
    return;
  }
  if(_func_1EF(var_1))
    var_1 = var_1._id_0117;

  var_2 = var_0.origin + (0, 0, 14);

  if(isDefined(level._id_31F9[var_0.guid])) {
    playFX(level._id_257E["vanish"], level._id_31F9[var_0.guid]._id_28D4);
    level._id_31F9[var_0.guid] notify("reset");
  } else {
    var_3[0] = spawn("script_model", (0, 0, 0));
    var_3[0] _meth_8384(var_0);
    var_3[0] setModel("prop_dogtags_future_enemy_animated");
    var_3[1] = spawn("script_model", (0, 0, 0));
    var_3[1] _meth_8384(var_0);
    var_3[1] setModel("prop_dogtags_future_friend_animated");
    var_4 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level._id_31F9[var_0.guid] = _id_04D1::_id_2837("any", var_4, var_3, (0, 0, 16));
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["allies"]);
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["axis"]);
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["broadcaster"]);
    level._id_31F9[var_0.guid] _id_04D1::_id_8A5A(0);
    level._id_31F9[var_0.guid]._id_6BBF = ::_id_6BBF;
    level._id_31F9[var_0.guid]._id_A490 = var_0;
    level._id_31F9[var_0.guid]._id_A496 = var_0.team;
    level thread _id_2404(var_0);
    var_0 thread _id_95BD(level._id_31F9[var_0.guid]);
  }

  level._id_31F9[var_0.guid]._id_28D4 = var_2;
  level._id_31F9[var_0.guid]._id_9D65.origin = var_2;
  level._id_31F9[var_0.guid]._id_A582[0].origin = var_2;
  level._id_31F9[var_0.guid]._id_A582[1].origin = var_2;
  level._id_31F9[var_0.guid] _id_04D1::_id_5307();
  level._id_31F9[var_0.guid] _id_04D1::_id_0C30("any");
  level._id_31F9[var_0.guid]._id_A582[0] thread _id_8C21(level._id_31F9[var_0.guid], maps\mp\_utility::getotherteam(var_0.team));
  level._id_31F9[var_0.guid]._id_A582[1] thread _id_8C21(level._id_31F9[var_0.guid], var_0.team);
  level._id_31F9[var_0.guid]._id_1180 = var_1;

  if(var_0.team == "axis") {
    _func_1D1(level._id_31F9[var_0.guid]._id_698B, "waypoint_dogtags_friendlys");
    _func_183(level._id_31F9[var_0.guid]._id_698B, "axis");
    _func_1D1(level._id_31F9[var_0.guid]._id_698A, "waypoint_dogtags");
    _func_183(level._id_31F9[var_0.guid]._id_698A, "allies");
  } else {
    _func_1D1(level._id_31F9[var_0.guid]._id_698A, "waypoint_dogtags_friendlys");
    _func_183(level._id_31F9[var_0.guid]._id_698A, "allies");
    _func_1D1(level._id_31F9[var_0.guid]._id_698B, "waypoint_dogtags");
    _func_183(level._id_31F9[var_0.guid]._id_698B, "axis");
  }

  _func_1D2(level._id_31F9[var_0.guid]._id_698A, var_2);
  _func_1D2(level._id_31F9[var_0.guid]._id_698B, var_2);
  _func_1D0(level._id_31F9[var_0.guid]._id_698A, "active");
  _func_1D0(level._id_31F9[var_0.guid]._id_698B, "active");
  playsoundatpos(var_2, "mp_killconfirm_tags_drop");
  level notify("sr_player_killed", var_0);
  var_0._id_95B4 = 1;
  var_0._id_0112 = 3;
  level._id_31F9[var_0.guid]._id_A582[0] _meth_8276("mp_dogtag_spin");
  level._id_31F9[var_0.guid]._id_A582[1] _meth_8276("mp_dogtag_spin");
}

_id_8C21(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self _meth_805C();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1)
      self _meth_8005(var_3);

    if(var_3.team == "spectator" && var_1 == "allies")
      self _meth_8005(var_3);
  }

  for(;;) {
    level waittill("joined_team");
    self _meth_805C();

    foreach(var_3 in level.players) {
      if(var_3.team == var_1)
        self _meth_8005(var_3);

      if(var_3.team == "spectator" && var_1 == "allies")
        self _meth_8005(var_3);
    }
  }
}

_id_913F() {
  maps\mp\gametypes\_playerlogic::_id_50F8(self.team);
  self._id_0CA4 = 1;
  thread _id_A6E1();
}

_id_A6E1() {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(isDefined(self) && (self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))) {
      self.pers["lives"] = 1;
      maps\mp\gametypes\_playerlogic::_id_9035();
      continue;
    }

    return;
  }
}

_id_6BBF(var_0) {
  if(isDefined(var_0._id_0117))
    var_0 = var_0._id_0117;

  if(var_0.pers["team"] == self._id_A496) {
    self._id_9D65 playSound("mp_snd_ally_revive");
    var_0 thread _id_047A::_id_7E63(self._id_A490);

    if(isDefined(self._id_A490)) {
      level notify("sr_player_respawned", self._id_A490);
      self._id_A490 maps\mp\_utility::leaderdialogonplayer("revived");
    }

    if(isDefined(self._id_A490)) {
      if(!level.gameended)
        self._id_A490 thread _id_913F();
    }

    var_0 maps\mp\gametypes\_missions::processchallenge("ch_rescuer");

    if(!isDefined(var_0._id_7D26))
      var_0._id_7D26 = [];

    var_0._id_7D26[self._id_A490.guid] = 1;

    if(var_0._id_7D26.size == 4)
      var_0 maps\mp\gametypes\_missions::processchallenge("ch_helpme");
  } else {
    self._id_9D65 playSound("mp_killconfirm_tags_pickup");
    var_0 thread _id_047A::_id_35D3();

    if(isDefined(self._id_A490)) {
      if(!level.gameended) {
        self._id_A490 maps\mp\_utility::_id_86C3("spawn_info", game["strings"]["spawn_next_round"]);
        self._id_A490 thread maps\mp\gametypes\_playerlogic::_id_7CFA(3.0);
      }

      self._id_A490._id_95B4 = undefined;
    }

    var_0 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_hideandseek");
  }

  self._id_A490._id_0112 = 0;
  level thread _id_047A::_id_63E9(var_0);
  _id_7D6F();
}

_id_7D6F() {
  self._id_1180 = undefined;
  self notify("reset");
  self._id_A582[0] _meth_805C();
  self._id_A582[1] _meth_805C();
  self._id_28D4 = (0, 0, 1000);
  self._id_9D65.origin = (0, 0, 1000);
  self._id_A582[0].origin = (0, 0, 1000);
  self._id_A582[1].origin = (0, 0, 1000);
  _id_04D1::_id_0C30("none");
  _func_1D0(self._id_698A, "invisible");
  _func_1D0(self._id_698B, "invisible");
}

_id_95BD(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    var_0._id_A496 = self.pers["team"];
    var_0 _id_7D6F();
  }
}

_id_2404(var_0) {
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");

  if(isDefined(level._id_31F9[var_1])) {
    level._id_31F9[var_1] _id_04D1::_id_0C30("none");
    playFX(level._id_257E["vanish"], level._id_31F9[var_1]._id_28D4);
    level._id_31F9[var_1] notify("reset");
    waitframe();

    if(isDefined(level._id_31F9[var_1])) {
      objective_delete(level._id_31F9[var_1]._id_698A);
      objective_delete(level._id_31F9[var_1]._id_698A);
      level._id_31F9[var_1]._id_9D65 delete();

      for(var_2 = 0; var_2 < level._id_31F9[var_1]._id_A582.size; var_2++)
        level._id_31F9[var_1]._id_A582[var_2] delete();

      level._id_31F9[var_1] notify("deleted");
      level._id_31F9[var_1] = undefined;
    }
  }
}