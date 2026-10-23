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
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 65);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level.onstartgametype = ::onstartgametype;
  level.onnormaldeath = ::onnormaldeath;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
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
  level.conf_fx["vanish"] = loadfx("vfx/unique/dogtag_vanish");
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  _setdynamicdvar("scr_conf_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("conf", 0, 0, 9);
  _setdynamicdvar("scr_conf_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("conf", 1);
  _setdynamicdvar("scr_conf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("conf", 1);
  _setdynamicdvar("scr_conf_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("conf", 0);
}

onstartgametype() {
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
  level.dogtags = [];
  var_2[0] = level.gametype;
  var_2[1] = "blocker_conf";
  _id_04D1::main(var_2);
}

onnormaldeath(var_0, var_1, var_2) {
  level thread spawndogtags(var_0, var_1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]]) {
    var_1.finalkill = 1;
  }
}

spawndogtags(var_0, var_1) {
  var_2 = var_0.pers["team"];

  if(isDefined(level.dogtags[var_0.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin);
    level.dogtags[var_0.guid] notify("reset");
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
    level.dogtags[var_0.guid] = _id_04D1::createuseobject("any", var_4, var_3, (0, 0, 16));
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidallies);
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidaxis);
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidmlgspectator);
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["allies"]);
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["axis"]);
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["broadcaster"]);
    level.dogtags[var_0.guid] _id_04D1::setusetime(0);
    level.dogtags[var_0.guid].onuse = ::onuse;
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].victimteam = var_2;
    level.dogtags[var_0.guid].objid = _id_04D1::_id_45A9();
    _objective_add(level.dogtags[var_0.guid].objid, "invisible", (0, 0, 0));
    level.dogtags[var_0.guid]._id_6988 = _id_04D1::_id_45A9();
    _objective_add(level.dogtags[var_0.guid]._id_6988, "invisible", (0, 0, 0));
    level thread clearonvictimdisconnect(var_0);
    var_0 thread tagteamupdater(level.dogtags[var_0.guid]);
  }

  if(isDefined(var_0._id_6E6B) && var_0._id_6E6B && isDefined(var_0.paratrooperinsertgroundposition)) {
    var_5 = var_0.paratrooperinsertgroundposition + (0, 0, 14);
  } else {
    var_5 = var_0.origin + (0, 0, 14);
  }

  level.dogtags[var_0.guid].curorigin = var_5;
  level.dogtags[var_0.guid].trigger.origin = var_5;
  level.dogtags[var_0.guid].visuals[0].origin = var_5;
  level.dogtags[var_0.guid].visuals[1].origin = var_5;
  level.dogtags[var_0.guid] _id_04D1::initializetagpathvariables();
  level.dogtags[var_0.guid] _id_04D1::_id_0C30("any");
  level.dogtags[var_0.guid].visuals[0] thread showtoteam(level.dogtags[var_0.guid], maps\mp\_utility::getotherteam(var_2));
  level.dogtags[var_0.guid].visuals[1] thread showtoteam(level.dogtags[var_0.guid], var_2);
  level.dogtags[var_0.guid].visuals[0] set_hudoutline("friendly", 1);
  level.dogtags[var_0.guid].visuals[1] set_hudoutline("enemy", 1);
  level.dogtags[var_0.guid].attacker = var_1;
  _objective_icon(level.dogtags[var_0.guid].objid, "waypoint_dogtags");
  _objective_position(level.dogtags[var_0.guid].objid, var_5);
  _objective_state(level.dogtags[var_0.guid].objid, "active");
  _objective_playerteam(level.dogtags[var_0.guid].objid, var_0 getentitynumber());
  _objective_icon(level.dogtags[var_0.guid]._id_6988, "waypoint_dogtags_friendlys");
  _objective_position(level.dogtags[var_0.guid]._id_6988, var_5);
  _objective_state(level.dogtags[var_0.guid]._id_6988, "active");
  _objective_playerenemyteam(level.dogtags[var_0.guid]._id_6988, var_0 getentitynumber());
  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
}

showtoteam(var_0, var_1) {
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

      if(var_0.victimteam == var_3.team && var_3 == var_0.attacker) {
        _objective_state(var_0.objid, "invisible");
      }
    }
  }
}

onuse(var_0) {
  if(isDefined(var_0._id_0117)) {
    var_0 = var_0._id_0117;
  }

  var_1 = var_0.pers["team"];

  if(var_1 == self.victimteam) {
    var_2 = _id_0380::_id_6842("mp_kc_tag_denied", undefined, var_0.origin);

    if(isPlayer(var_0)) {
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_denied");
    }

    if(isDefined(self.attacker) && isPlayer(self.attacker)) {
      self.attacker maps\mp\_utility::leaderdialogonplayer("kc_killlost");
    }

    var_3 = self.victim == var_0;
    var_0 _id_047A::killdeniedevent(var_3);
  } else {
    var_4 = _id_0380::_id_6842("mp_kc_tag_collected", undefined, var_0.origin);

    if(isPlayer(self.attacker) && self.attacker != var_0) {
      level thread maps\mp\gametypes\_rank::awardgameevent("team_confirmed", self.attacker);
    }

    var_0 _id_047A::killconfirmedevent();

    if(isPlayer(var_0)) {
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");
    }

    var_0 _id_04D2::giveteamscoreforobjective(var_1, 1, 1);
  }

  level thread _id_047A::monitortagcollector(var_0);
  resettags();
}

resettags() {
  self.attacker = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  _id_04D1::_id_0C30("none");
  _objective_state(self.objid, "invisible");
  _objective_state(self._id_6988, "invisible");
}

tagteamupdater(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    var_0.victimteam = self.pers["team"];
    var_0 resettags();
  }
}

clearonvictimdisconnect(var_0) {
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");

  if(isDefined(level.dogtags[var_1])) {
    level.dogtags[var_1] _id_04D1::_id_0C30("none");
    playFX(level.conf_fx["vanish"], level.dogtags[var_1].curorigin);
    level.dogtags[var_1] notify("reset");
    waitframe();

    if(isDefined(level.dogtags[var_1])) {
      objective_delete(level.dogtags[var_1].objid);
      objective_delete(level.dogtags[var_1]._id_6988);
      level.dogtags[var_1].trigger delete();

      for(var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++) {
        level.dogtags[var_1].visuals[var_2] delete();
      }

      level.dogtags[var_1] notify("deleted");
      level.dogtags[var_1] = undefined;
    }
  }
}

set_hudoutline(var_0, var_1) {
  var_2 = undefined;
  var_0 = _tolower(var_0);
  var_3["friendly"] = 1;
  var_3["enemy"] = 2;
  var_3["objective"] = 5;
  var_3["neutral"] = 0;
  var_2 = var_3[var_0];
  self hudoutlineenable(var_2, var_1);
}