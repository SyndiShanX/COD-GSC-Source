/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\conf.gsc
**********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 65);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "kc_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["kill_denied"] = "kc_killdenied";
  game["dialog"]["kill_lost"] = "kc_killlost";
  game["dialog"]["defense_obj"] = "kc_start";
  game["dialog"]["offense_obj"] = "kc_start";
  level._id_257E["vanish"] = loadfx("vfx/unique/dogtag_vanish");
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _setdynamicdvar("scr_conf_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("conf", 0, 0, 9);
  _setdynamicdvar("scr_conf_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("conf", 1);
  _setdynamicdvar("scr_conf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("conf", 1);
  _setdynamicdvar("scr_conf_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("conf", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_CONF");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_CONF");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_CONF");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_CONF");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_CONF_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_CONF_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_CONF_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_CONF_HINT");
  _id_050D::_id_10E4();
  level._id_31F9 = [];
  var_2[0] = level.gametype;
  var_2[1] = "blocker_conf";
  _id_04D1::main(var_2);
}

_id_6B5C(var_0, var_1, var_2) {
  level thread _id_903E(var_0, var_1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_6C63[var_1.team]]) {
    var_1._id_3B4B = 1;
  }
}

_id_903E(var_0, var_1) {
  var_2 = var_0.pers["team"];

  if(isDefined(level._id_31F9[var_0.guid])) {
    playFX(level._id_257E["vanish"], level._id_31F9[var_0.guid]._id_28D4);
    level._id_31F9[var_0.guid] notify("reset");
  } else {
    var_3 = [];

    if(isDefined(var_0.team) && var_0.team == "allies") {
      var_3[0] = spawn("script_model", (0, 0, 0));
      var_3[0] setModel("prop_usa_kc_dogtags");
      var_3[1] = spawn("script_model", (0, 0, 0));
      var_3[1] setModel("prop_usa_kc_dogtags");
    } else if(isDefined(var_0.team) && var_0.team == "axis") {
      var_3[0] = spawn("script_model", (0, 0, 0));
      var_3[0] setModel("prop_ger_kc_dogtags");
      var_3[1] = spawn("script_model", (0, 0, 0));
      var_3[1] setModel("prop_ger_kc_dogtags");
    }

    var_4 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level._id_31F9[var_0.guid] = _id_04D1::_id_2837("any", var_4, var_3, (0, 0, 16));
    maps\mp\_utility::_objective_delete(level._id_31F9[var_0.guid]._id_698A);
    maps\mp\_utility::_objective_delete(level._id_31F9[var_0.guid]._id_698B);
    maps\mp\_utility::_objective_delete(level._id_31F9[var_0.guid]._id_698C);
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["allies"]);
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["axis"]);
    _id_04EC::_id_2D3E(level._id_31F9[var_0.guid]._id_6996["broadcaster"]);
    level._id_31F9[var_0.guid] _id_04D1::_id_8A5A(0);
    level._id_31F9[var_0.guid]._id_6BBF = ::_id_6BBF;
    level._id_31F9[var_0.guid]._id_A490 = var_0;
    level._id_31F9[var_0.guid]._id_A496 = var_2;
    level._id_31F9[var_0.guid]._id_6989 = _id_04D1::_id_45A9();
    _objective_add(level._id_31F9[var_0.guid]._id_6989, "invisible", (0, 0, 0));
    level._id_31F9[var_0.guid]._id_6988 = _id_04D1::_id_45A9();
    _objective_add(level._id_31F9[var_0.guid]._id_6988, "invisible", (0, 0, 0));
    level thread _id_2404(var_0);
    var_0 thread _id_95BD(level._id_31F9[var_0.guid]);
  }

  if(isDefined(var_0._id_6E6B) && var_0._id_6E6B && isDefined(var_0.paratrooperinsertgroundposition)) {
    var_5 = var_0.paratrooperinsertgroundposition + (0, 0, 14);
  } else {
    var_5 = var_0.origin + (0, 0, 14);
  }

  level._id_31F9[var_0.guid]._id_28D4 = var_5;
  level._id_31F9[var_0.guid]._id_9D65.origin = var_5;
  level._id_31F9[var_0.guid]._id_A582[0].origin = var_5;
  level._id_31F9[var_0.guid]._id_A582[1].origin = var_5;
  level._id_31F9[var_0.guid] _id_04D1::_id_5307();
  level._id_31F9[var_0.guid] _id_04D1::_id_0C30("any");
  level._id_31F9[var_0.guid]._id_A582[0] thread _id_8C21(level._id_31F9[var_0.guid], maps\mp\_utility::getotherteam(var_2));
  level._id_31F9[var_0.guid]._id_A582[1] thread _id_8C21(level._id_31F9[var_0.guid], var_2);
  level._id_31F9[var_0.guid]._id_A582[0] _id_84DF("friendly", 1);
  level._id_31F9[var_0.guid]._id_A582[1] _id_84DF("enemy", 1);
  level._id_31F9[var_0.guid]._id_1180 = var_1;
  _objective_icon(level._id_31F9[var_0.guid]._id_6989, "waypoint_dogtags");
  _objective_position(level._id_31F9[var_0.guid]._id_6989, var_5);
  _objective_state(level._id_31F9[var_0.guid]._id_6989, "active");
  _objective_playerteam(level._id_31F9[var_0.guid]._id_6989, var_0 getentitynumber());
  _objective_icon(level._id_31F9[var_0.guid]._id_6988, "waypoint_dogtags_friendlys");
  _objective_position(level._id_31F9[var_0.guid]._id_6988, var_5);
  _objective_state(level._id_31F9[var_0.guid]._id_6988, "active");
  _objective_playerenemyteam(level._id_31F9[var_0.guid]._id_6988, var_0 getentitynumber());
  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  level._id_31F9[var_0.guid]._id_A582[0] scriptmodelplayanim("mp_dogtag_spin");
  level._id_31F9[var_0.guid]._id_A582[1] scriptmodelplayanim("mp_dogtag_spin");
}

_id_8C21(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      self showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self showtoplayer(var_3);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(var_3.team == var_1) {
        self showtoplayer(var_3);
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }

      if(var_0._id_A496 == var_3.team && var_3 == var_0._id_1180) {
        _objective_state(var_0._id_6989, "invisible");
      }
    }
  }
}

_id_6BBF(var_0) {
  if(isDefined(var_0._id_0117)) {
    var_0 = var_0._id_0117;
  }

  var_1 = var_0.pers["team"];

  if(var_1 == self._id_A496) {
    var_2 = _id_0380::_id_6842("mp_kc_tag_denied", undefined, var_0.origin);

    if(isPlayer(var_0)) {
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_denied");
    }

    if(isDefined(self._id_1180) && isPlayer(self._id_1180)) {
      self._id_1180 maps\mp\_utility::leaderdialogonplayer("kc_killlost");
    }

    var_3 = self._id_A490 == var_0;
    var_0 _id_047A::_id_5A38(var_3);
  } else {
    var_4 = _id_0380::_id_6842("mp_kc_tag_collected", undefined, var_0.origin);

    if(isPlayer(self._id_1180) && self._id_1180 != var_0) {
      level thread maps\mp\gametypes\_rank::_id_1457("team_confirmed", self._id_1180);
    }

    var_0 _id_047A::_id_5A35();

    if(isPlayer(var_0)) {
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");
    }

    var_0 _id_04D2::_id_47BD(var_1, 1, 1);
  }

  level thread _id_047A::_id_63E9(var_0);
  _id_7D6F();
}

_id_7D6F() {
  self._id_1180 = undefined;
  self notify("reset");
  self._id_A582[0] hide();
  self._id_A582[1] hide();
  self._id_28D4 = (0, 0, 1000);
  self._id_9D65.origin = (0, 0, 1000);
  self._id_A582[0].origin = (0, 0, 1000);
  self._id_A582[1].origin = (0, 0, 1000);
  _id_04D1::_id_0C30("none");
  _objective_state(self._id_6989, "invisible");
  _objective_state(self._id_6988, "invisible");
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
      objective_delete(level._id_31F9[var_1]._id_6989);
      objective_delete(level._id_31F9[var_1]._id_6988);
      level._id_31F9[var_1]._id_9D65 delete();

      for(var_2 = 0; var_2 < level._id_31F9[var_1]._id_A582.size; var_2++) {
        level._id_31F9[var_1]._id_A582[var_2] delete();
      }

      level._id_31F9[var_1] notify("deleted");
      level._id_31F9[var_1] = undefined;
    }
  }
}

_id_84DF(var_0, var_1) {
  var_2 = undefined;
  var_0 = _tolower(var_0);
  var_3["friendly"] = 1;
  var_3["enemy"] = 2;
  var_3["objective"] = 5;
  var_3["neutral"] = 0;
  var_2 = var_3[var_0];
  self hudoutlineenable(var_2, var_1);
}