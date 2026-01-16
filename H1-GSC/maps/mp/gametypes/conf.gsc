/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\conf.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
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

  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.killstreak_kills = getdvarint("scr_conf_killstreak_kill", 1);
  level.killstreak_tag_friendly = getdvarint("scr_conf_killstreak_tag_friendly", 0);
  level.killstreak_tag_enemy = getdvarint("scr_conf_killstreak_tag_enemy", 0);

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  game["dialog"]["gametype"] = "kc_intro";
  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["kill_denied"] = "kc_killdenied";
  game["dialog"]["kill_lost"] = "kc_killlost";
  game["dialog"]["defense_obj"] = "kc_start";
  game["dialog"]["offense_obj"] = "kc_start";
  level.conf_fx["vanish"] = loadfx("vfx\unique\dogtag_vanish");
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_conf_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("conf", 0, 0, 9);
  setdynamicdvar("scr_conf_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("conf", 1);
  setdynamicdvar("scr_conf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("conf", 1);
  setdynamicdvar("scr_conf_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("conf", 0);
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = getmatchrulesdata("confData", "killstreakPointsType");

  if(var_3 == 2) {
    var_0 = 1;
    var_2 = 1;
  } else if(var_3 == 1)
    var_2 = 1;
  else
    var_0 = 1;

  setdynamicdvar("scr_conf_killstreak_kill", var_0);
  setdynamicdvar("scr_conf_killstreak_tag_friendly", var_1);
  setdynamicdvar("scr_conf_killstreak_tag_enemy", var_2);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_CONF");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_CONF");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_CONF");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_CONF");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_CONF_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_CONF_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_CONF_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_CONF_HINT");
  initspawns();
  level.dogtags = [];
  var_2[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_2);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"])
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(level.usestartspawns && level.ingraceperiod)
    var_1 = maps\mp\gametypes\_spawnlogic::getbeststartspawn("mp_tdm_spawn_" + var_0 + "_start");
  else {
    var_2 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

onnormaldeath(var_0, var_1, var_2) {
  level thread spawndogtags(var_0, var_1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]])
    var_1.finalkill = 1;
}

spawndogtags(var_0, var_1) {
  var_2 = var_0.pers["team"];

  if(isdefined(level.dogtags[var_0.guid])) {
    playfx(level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin);
    level.dogtags[var_0.guid] notify("reset");
  } else {
    if(!isdefined(level.killconfirmeddogtagenemy))
      level.killconfirmeddogtagenemy = "h1_dogtag_enemy_animated";

    if(!isdefined(level.killconfirmeddogtagfriend))
      level.killconfirmeddogtagfriend = "h1_dogtag_friend_animated";

    var_3[0] = spawn("script_model", (0, 0, 0));
    var_3[0] setmodel(level.killconfirmeddogtagenemy);
    var_3[1] = spawn("script_model", (0, 0, 0));
    var_3[1] setmodel(level.killconfirmeddogtagfriend);
    var_4 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.dogtags[var_0.guid] = maps\mp\gametypes\_gameobjects::createuseobject("any", var_4, var_3, (0, 0, 16));
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidallies);
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidaxis);
    maps\mp\_utility::_objective_delete(level.dogtags[var_0.guid].objidmlgspectator);
    maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[var_0.guid].objpoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[var_0.guid].objpoints["axis"]);
    maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[var_0.guid].objpoints["mlg"]);
    level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::setusetime(0);
    level.dogtags[var_0.guid].onuse = ::onuse;
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].victimteam = var_2;
    level.dogtags[var_0.guid].objid = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add(level.dogtags[var_0.guid].objid, "invisible", (0, 0, 0));
    objective_icon(level.dogtags[var_0.guid].objid, "waypoint_dogtags");
    level.dogtags[var_0.guid].objidself = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add(level.dogtags[var_0.guid].objidself, "invisible", (0, 0, 0));
    objective_icon(level.dogtags[var_0.guid].objidself, "waypoint_dogtags_friendlys");
    level thread clearonvictimdisconnect(var_0);
    var_0 thread tagteamupdater(level.dogtags[var_0.guid]);
  }

  var_5 = var_0.origin + (0, 0, 14);
  level.dogtags[var_0.guid].curorigin = var_5;
  level.dogtags[var_0.guid].trigger.origin = var_5;
  level.dogtags[var_0.guid].visuals[0].origin = var_5;
  level.dogtags[var_0.guid].visuals[1].origin = var_5;
  level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::initializetagpathvariables();
  level.dogtags[var_0.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
  level.dogtags[var_0.guid].visuals[0] thread showtoteam(level.dogtags[var_0.guid], maps\mp\_utility::getotherteam(var_2));
  level.dogtags[var_0.guid].visuals[1] thread showtoteam(level.dogtags[var_0.guid], var_2);
  level.dogtags[var_0.guid].attacker = var_1;
  objective_position(level.dogtags[var_0.guid].objid, var_5);
  objective_state(level.dogtags[var_0.guid].objid, "active");
  objective_playerenemyteam(level.dogtags[var_0.guid].objid, var_0 getentitynumber());
  objective_position(level.dogtags[var_0.guid].objidself, var_5);
  objective_state(level.dogtags[var_0.guid].objidself, "active");
  objective_player(level.dogtags[var_0.guid].objidself, var_0 getentitynumber());
  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
}

showtoteam(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1)
      self showtoplayer(var_3);

    if(var_3.team == "spectator" && var_1 == "allies")
      self showtoplayer(var_3);
  }

  for (;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(var_3.team == var_1)
        self showtoplayer(var_3);

      if(var_3.team == "spectator" && var_1 == "allies")
        self showtoplayer(var_3);

      if(var_0.victimteam == var_3.team && var_3 == var_0.attacker)
        objective_state(var_0.objid, "invisible");
    }
  }
}

onuse(var_0) {
  if(isdefined(var_0.owner))
    var_0 = var_0.owner;

  var_1 = var_0.pers["team"];

  if(var_1 == self.victimteam) {
    self.trigger playsound("mp_kc_tag_denied");

    if(isplayer(var_0))
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_denied");

    if(isdefined(self.attacker) && isplayer(self.attacker))
      self.attacker maps\mp\_utility::leaderdialogonplayer("kc_killlost");

    var_2 = self.victim == var_0;
    var_0 maps\mp\_events::killdeniedevent(var_2);

    if(level.killstreak_tag_friendly)
      maps\mp\gametypes\_damage::incrementkillstreak(var_0);
  } else {
    self.trigger playsound("mp_kc_tag_collected");

    if(isplayer(self.attacker) && self.attacker != var_0)
      level thread maps\mp\gametypes\_rank::awardgameevent("team_confirmed", self.attacker);

    var_0 maps\mp\_events::killconfirmedevent();

    if(isplayer(var_0))
      var_0 maps\mp\_utility::leaderdialogonplayer("kill_confirmed");

    var_0 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_1, 1);

    if(level.killstreak_tag_enemy)
      maps\mp\gametypes\_damage::incrementkillstreak(var_0);
  }

  level thread maps\mp\_events::monitortagcollector(var_0);
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
  maps\mp\gametypes\_gameobjects::allowuse("none");
  objective_state(self.objid, "invisible");
  objective_state(self.objidself, "invisible");
}

tagteamupdater(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("joined_team");
    var_0.victimteam = self.pers["team"];
    var_0 resettags();
  }
}

clearonvictimdisconnect(var_0) {
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");

  if(isdefined(level.dogtags[var_1])) {
    level.dogtags[var_1] maps\mp\gametypes\_gameobjects::allowuse("none");
    playfx(level.conf_fx["vanish"], level.dogtags[var_1].curorigin);
    level.dogtags[var_1] notify("reset");
    wait 0.05;

    if(isdefined(level.dogtags[var_1])) {
      objective_delete(level.dogtags[var_1].objid);
      objective_delete(level.dogtags[var_1].objidself);
      level.dogtags[var_1].trigger delete();

      for (var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++)
        level.dogtags[var_1].visuals[var_2] delete();

      level.dogtags[var_1] notify("deleted");
      level.dogtags[var_1] = undefined;
    }
  }
}