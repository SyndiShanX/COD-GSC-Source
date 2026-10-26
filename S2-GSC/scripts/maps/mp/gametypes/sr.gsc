/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\sr.gsc
********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
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
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 4);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level._id_10EB = 1;
  level.objectivebased = 1;
  maps\mp\_utility::_id_873B(1);
  level.nobuddyspawns = 1;
  level._id_6B86 = maps\mp\gametypes\common_sd_sr::_id_6B86;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level._id_6B7B = ::_id_6B7B;
  level.ondeadevent = maps\mp\gametypes\common_sd_sr::ondeadevent;
  level.ononeleftevent = maps\mp\gametypes\common_sd_sr::ononeleftevent;
  level.ontimelimit = maps\mp\gametypes\common_sd_sr::ontimelimit;
  level.onnormaldeath = maps\mp\gametypes\common_sd_sr::onnormaldeath;
  level.gamemodemaydropweapon = maps\mp\gametypes\common_sd_sr::isplayeroutsideofanybombsite;
  level._id_0C25 = 0;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "sr_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["revived"] = "sr_rev";
  _setomnvar("ui_bomb_a_timer_endtime", 0);
  _setomnvar("ui_bomb_b_timer_endtime", 0);
  level.conf_fx["vanish"] = loadfx("vfx/test/test_fx");
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  var_0 = _getmatchrulesdata("srData", "roundLength");
  _setdynamicdvar("scr_sr_timelimit", var_0);
  maps\mp\_utility::registertimelimitdvar("sr", var_0);
  var_1 = _getmatchrulesdata("srData", "roundSwitch");
  _setdynamicdvar("scr_sr_roundswitch", var_1);
  maps\mp\_utility::registerroundswitchdvar("sr", var_1, 0, 9);
  var_2 = _getmatchrulesdata("commonOption", "scoreLimit");
  _setdynamicdvar("scr_sr_winlimit", var_2);
  maps\mp\_utility::registerwinlimitdvar("sr", var_2);
  _setdynamicdvar("scr_sr_bombtimer", _getmatchrulesdata("srData", "bombTimer"));
  _setdynamicdvar("scr_sr_planttime", _getmatchrulesdata("srData", "plantTime"));
  _setdynamicdvar("scr_sr_defusetime", _getmatchrulesdata("srData", "defuseTime"));
  _setdynamicdvar("scr_sr_multibomb", _getmatchrulesdata("srData", "multiBomb"));
  _setdynamicdvar("scr_sr_silentplant", _getmatchrulesdata("srData", "silentPlant"));
  _setdynamicdvar("scr_sr_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sr", 0);
  _setdynamicdvar("scr_sr_scorelimit", 1);
  maps\mp\_utility::registerscorelimitdvar("sr", 1);
  _setdynamicdvar("scr_sr_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sr", 0);
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  _setclientnamemode("manual_change");
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
  maps\mp\gametypes\common_sd_sr::updategametypedvars();
  level.dogtags = [];
  maps\mp\gametypes\common_sd_sr::setspecialloadout();
  thread maps\mp\gametypes\common_sd_sr::bombs();
}

onspawnplayer() {
  var_0 = isDefined(self.isrespawningwithbombcarrierclass) && self.isrespawningwithbombcarrierclass;
  self.isplanting = 0;
  self.isdefusing = 0;

  if(!var_0) {
    self.isbombcarrier = 0;
    self._id_0112 = 0;
  }

  if(isPlayer(self) && !var_0) {
    if(level.multibomb && self.pers["team"] == game["attackers"]) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::splashnotify("bomb_pickedup");
    } else
      self setclientomnvar("ui_carrying_bomb", 0);
  }

  self.isrespawningwithbombcarrierclass = undefined;
  level notify("spawned_player");

  if(self._id_0179 == "axis" || self._id_0179 == "allies") {
    level notify("sr_player_joined", self);
    maps\mp\_utility::setextrascore0(0);

    if(isDefined(self.pers["plants"])) {
      maps\mp\_utility::setextrascore0(self.pers["plants"]);
    }

    maps\mp\_utility::setextrascore1(0);

    if(isDefined(self.pers["defuses"])) {
      maps\mp\_utility::setextrascore1(self.pers["defuses"]);
    }

    self._id_0021 = 0;

    if(isDefined(self.pers["denied"])) {
      self._id_0021 = self.pers["denied"];
    }
  }
}

shouldspawntags(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.switching_teams)) {
    return 0;
  }

  if(isDefined(self.wasswitchingteamsforonplayerkilled)) {
    return 0;
  }

  if(isDefined(var_1) && var_1 == self) {
    return 0;
  }

  if(level.teambased && isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.team) {
    return 0;
  }

  if(isDefined(var_1) && !isDefined(var_1.team) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
    return 0;
  }

  return 1;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isPlayer(self)) {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  if(!maps\mp\_utility::gameflag("prematch_done")) {
    maps\mp\gametypes\_playerlogic::mayspawn();
  } else {
    var_10 = shouldspawntags(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_10) {
      var_10 = var_10 && !maps\mp\_utility::isreallyalive(self);
    }

    if(var_10) {
      var_10 = var_10 && !maps\mp\gametypes\_playerlogic::mayspawn();
    }

    if(var_10) {
      level thread spawndogtags(self, var_1);
    }
  }

  thread maps\mp\gametypes\common_sd_sr::checkallowspectating();
  maps\mp\gametypes\common_sd_sr::_id_254C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

spawndogtags(var_0, var_1) {
  if(_isagent(var_0)) {
    return;
  }
  if(_isagent(var_1)) {
    var_1 = var_1._id_0117;
  }

  var_2 = var_0.origin + (0, 0, 14);

  if(isDefined(level.dogtags[var_0.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin);
    level.dogtags[var_0.guid] notify("reset");
  } else {
    var_3[0] = spawn("script_model", (0, 0, 0));
    var_3[0] setclientowner(var_0);
    var_3[0] setModel("prop_dogtags_future_enemy_animated");
    var_3[1] = spawn("script_model", (0, 0, 0));
    var_3[1] setclientowner(var_0);
    var_3[1] setModel("prop_dogtags_future_friend_animated");
    var_4 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.dogtags[var_0.guid] = _id_04D1::createuseobject("any", var_4, var_3, (0, 0, 16));
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["allies"]);
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["axis"]);
    _id_04EC::deleteobjpoint(level.dogtags[var_0.guid].objpoints["broadcaster"]);
    level.dogtags[var_0.guid] _id_04D1::setusetime(0);
    level.dogtags[var_0.guid].onuse = ::onuse;
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].victimteam = var_0.team;
    level thread clearonvictimdisconnect(var_0);
    var_0 thread tagteamupdater(level.dogtags[var_0.guid]);
  }

  level.dogtags[var_0.guid].curorigin = var_2;
  level.dogtags[var_0.guid].trigger.origin = var_2;
  level.dogtags[var_0.guid].visuals[0].origin = var_2;
  level.dogtags[var_0.guid].visuals[1].origin = var_2;
  level.dogtags[var_0.guid] _id_04D1::initializetagpathvariables();
  level.dogtags[var_0.guid] _id_04D1::_id_0C30("any");
  level.dogtags[var_0.guid].visuals[0] thread showtoteam(level.dogtags[var_0.guid], maps\mp\_utility::getotherteam(var_0.team));
  level.dogtags[var_0.guid].visuals[1] thread showtoteam(level.dogtags[var_0.guid], var_0.team);
  level.dogtags[var_0.guid].attacker = var_1;

  if(var_0.team == "axis") {
    _objective_icon(level.dogtags[var_0.guid].objidaxis, "waypoint_dogtags_friendlys");
    _objective_team(level.dogtags[var_0.guid].objidaxis, "axis");
    _objective_icon(level.dogtags[var_0.guid].objidallies, "waypoint_dogtags");
    _objective_team(level.dogtags[var_0.guid].objidallies, "allies");
  } else {
    _objective_icon(level.dogtags[var_0.guid].objidallies, "waypoint_dogtags_friendlys");
    _objective_team(level.dogtags[var_0.guid].objidallies, "allies");
    _objective_icon(level.dogtags[var_0.guid].objidaxis, "waypoint_dogtags");
    _objective_team(level.dogtags[var_0.guid].objidaxis, "axis");
  }

  _objective_position(level.dogtags[var_0.guid].objidallies, var_2);
  _objective_position(level.dogtags[var_0.guid].objidaxis, var_2);
  _objective_state(level.dogtags[var_0.guid].objidallies, "active");
  _objective_state(level.dogtags[var_0.guid].objidaxis, "active");
  playsoundatpos(var_2, "mp_killconfirm_tags_drop");
  level notify("sr_player_killed", var_0);
  var_0.tagavailable = 1;
  var_0._id_0112 = 3;
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
    }
  }
}

sr_respawn() {
  maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
  self._id_0CA4 = 1;
  thread waitillcanspawnclient();
}

waitillcanspawnclient() {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(isDefined(self) && (self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))) {
      self.pers["lives"] = 1;
      maps\mp\gametypes\_playerlogic::spawnclient();
      continue;
    }

    return;
  }
}

onuse(var_0) {
  if(isDefined(var_0._id_0117)) {
    var_0 = var_0._id_0117;
  }

  if(var_0.pers["team"] == self.victimteam) {
    self.trigger playSound("mp_snd_ally_revive");
    var_0 thread _id_047A::revivetagevent(self.victim);

    if(isDefined(self.victim)) {
      level notify("sr_player_respawned", self.victim);
      self.victim maps\mp\_utility::leaderdialogonplayer("revived");
    }

    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim thread sr_respawn();
      }
    }

    var_0 maps\mp\gametypes\_missions::processchallenge("ch_rescuer");

    if(!isDefined(var_0.rescuedplayers)) {
      var_0.rescuedplayers = [];
    }

    var_0.rescuedplayers[self.victim.guid] = 1;

    if(var_0.rescuedplayers.size == 4) {
      var_0 maps\mp\gametypes\_missions::processchallenge("ch_helpme");
    }
  } else {
    self.trigger playSound("mp_killconfirm_tags_pickup");
    var_0 thread _id_047A::eliminatetagevent();

    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);
        self.victim thread maps\mp\gametypes\_playerlogic::removespawnmessageshortly(3.0);
      }

      self.victim.tagavailable = undefined;
    }

    var_0 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_hideandseek");
  }

  self.victim._id_0112 = 0;
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
  _objective_state(self.objidallies, "invisible");
  _objective_state(self.objidaxis, "invisible");
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
      objective_delete(level.dogtags[var_1].objidallies);
      objective_delete(level.dogtags[var_1].objidallies);
      level.dogtags[var_1].trigger delete();

      for(var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++) {
        level.dogtags[var_1].visuals[var_2] delete();
      }

      level.dogtags[var_1] notify("deleted");
      level.dogtags[var_1] = undefined;
    }
  }
}