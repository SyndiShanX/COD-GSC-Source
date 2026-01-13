/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
*********************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 100);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 2);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 0);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onspawnplayer;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "frontline";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
  thread onplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_front_enemyBaseKillReveal", getmatchrulesdata("frontData", "enemyBaseKillReveal"));
  setdynamicdvar("scr_front_friendlyBaseScore", getmatchrulesdata("frontData", "friendlyBaseScore"));
  setdynamicdvar("scr_front_midfieldScore", getmatchrulesdata("frontData", "midfieldScore"));
  setdynamicdvar("scr_front_enemyBaseScore", getmatchrulesdata("frontData", "enemyBaseScore"));
  setdynamicdvar("scr_front_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_FRONT");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_FRONT");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_FRONT");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_FRONT");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_FRONT_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_FRONT_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_FRONT_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_FRONT_HINT");
  level.iconkill3d = "waypoint_capture_kill";
  level.iconkill2d = "waypoint_capture_kill";
  initspawns();
  var_2[0] = level.gametype;
  scripts\mp\gameobjects::main(var_2);
  base_setupvfx();
  thread setupbases();
  thread setupbaseareabrushes();
  level.var_112BF = 0;
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.var_654C = scripts\mp\utility::dvarfloatvalue("enemyBaseKillReveal", 5, 0, 60);
  level.friendlybasescore = scripts\mp\utility::dvarfloatvalue("friendlyBaseScore", 1, 0, 25);
  level.midfieldscore = scripts\mp\utility::dvarfloatvalue("midfieldScore", 2, 0, 25);
  level.enemybasescore = scripts\mp\utility::dvarfloatvalue("enemyBaseScore", 1, 0, 25);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

onspawnplayer() {
  if(isplayer(self)) {
    scripts\mp\gametypes\common::onspawnplayer();
    self setclientomnvar("ui_uplink_carrier_hud", 0);
    self.inenemybase = 0;
    self.infriendlybase = 0;
    self.outlinetime = 0;
    if(isDefined(self.outlineid)) {
      scripts\mp\utility::outlinedisable(self.outlineid, self);
    }

    self.useoutline = 0;
    self.outlineid = undefined;
    thread friendlybasewatcher();
    thread func_654F();
    foreach(var_1 in level.zones) {
      var_1 showbaseeffecttoplayer(self);
    }
  }
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility::getotherteam(var_0);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_1);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3);
  }

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
  var_5 = 0;
  if(var_0.infriendlybase || var_1.inenemybase) {
    var_1 thread scripts\mp\utility::giveunifiedpoints("enemy_base_kill", var_4);
    var_5 = level.enemybasescore;
  } else if(var_1.infriendlybase || var_0.inenemybase) {
    var_1 thread scripts\mp\utility::giveunifiedpoints("friendly_base_kill", var_4);
    var_5 = level.friendlybasescore;
  } else {
    var_1 thread scripts\mp\utility::giveunifiedpoints("midfield_kill", var_4);
    var_5 = level.midfieldscore;
  }

  var_6 = game["teamScores"][var_1.pers["team"]] + var_5;
  var_7 = var_6 >= level.roundscorelimit;
  if(var_7 && level.roundscorelimit != 0) {
    var_5 = level.roundscorelimit - game["teamScores"][var_1.pers["team"]];
  }

  if(var_5 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_5, 0);
    var_1 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_5);
  }
}

func_654C() {
  level endon("game_ended");
  self endon("death");
  self notify("EnemyBaseKillReveal");
  self endon("EnemyBaseKillReveal");
  if(isDefined(self.var_28A5)) {
    scripts\mp\utility::outlinedisable(self.var_28A5, self);
  }

  self.var_28A5 = scripts\mp\utility::outlineenableforteam(self, "orange", scripts\mp\utility::getotherteam(self.team), 0, 0, "perk");
  if(!isbot(self)) {
    scripts\mp\utility::_hudoutlineviewmodelenable(5, 0, 0);
  }

  self sethudtutorialmessage(&"MP_FRONT_REVEALED");
  wait(level.var_654C);
  scripts\mp\utility::outlinedisable(self.var_28A5, self);
  scripts\mp\utility::_hudoutlineviewmodeldisable();
  self clearhudtutorialmessage(0);
}

setupbases() {
  level.zones = [];
  if(game["switchedsides"]) {
    level.allieszone = getEntArray("frontline_zone_allies", "targetname");
    foreach(var_1 in level.allieszone) {
      var_1.team = "axis";
      var_1 thread friendlybasewatcher();
      var_1 thread func_654F();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("frontline_zone_axis", "targetname");
    if(level.mapname == "mp_junk") {
      var_3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var_3;
    }

    foreach(var_1 in level.axiszone) {
      var_1.team = "allies";
      var_1 thread friendlybasewatcher();
      var_1 thread func_654F();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
    return;
  }

  level.allieszone = getEntArray("frontline_zone_allies", "targetname");
  foreach(var_1 in level.allieszone) {
    var_1.team = "allies";
    var_1 thread friendlybasewatcher();
    var_1 thread func_654F();
    var_1 thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.allieszone[0]);
  level.zones[level.zones.size] = level.allieszone[0];
  level.axiszone = getEntArray("frontline_zone_axis", "targetname");
  if(level.mapname == "mp_junk") {
    var_3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
    level.axiszone[level.axiszone.size] = var_3;
  }

  foreach(var_1 in level.axiszone) {
    var_1.team = "axis";
    var_1 thread friendlybasewatcher();
    var_1 thread func_654F();
    var_1 thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.axiszone[0]);
  level.zones[level.zones.size] = level.axiszone[0];
}

setupvisuals(var_0) {
  var_1 = [];
  var_1[0] = var_0;
  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");
    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_1[var_1.size] = var_2[var_3];
    }
  }

  var_1 = mappatchborders(var_1, var_0.target);
  var_0.visuals = var_1;
}

mappatchborders(var_0, var_1) {
  if(level.mapname == "mp_parkour" && var_1 == "front_vis_axis") {
    var_2 = spawn("script_origin", (-1088, -1504, 136));
    var_2.angles = (0, 180, 0);
    var_2.var_336 = var_1;
    var_0[var_0.size] = var_2;
    var_3 = spawn("script_origin", (-1088, -1440, 136));
    var_3.angles = (0, 180, 0);
    var_2.var_336 = var_1;
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("trigger", var_0);
    if(!isplayer(var_0)) {
      continue;
    }

    if(var_0.team != self.team) {
      continue;
    }

    if(var_0.infriendlybase) {
      continue;
    }

    var_0 thread friendlybasetriggerwatcher(self);
  }
}

friendlybasetriggerwatcher(var_0) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(game["switchedsides"]) {
    if(self.team == "allies") {
      var_1 = level.axiszone;
    } else {
      var_1 = level.allieszone;
    }
  } else if(self.team == "allies") {
    var_1 = level.allieszone;
  } else {
    var_1 = level.axiszone;
  }

  for(;;) {
    self.infriendlybase = 0;
    foreach(var_0 in var_1) {
      if(self istouching(var_0)) {
        self.infriendlybase = 1;
        break;
      }
    }

    if(!self.infriendlybase || scripts\mp\utility::isinarbitraryup()) {
      if(scripts\mp\utility::istrue(self.spawnprotection)) {
        scripts\mp\gametypes\common::removespawnprotection();
      }

      break;
    }

    wait(0.05);
  }
}

func_654F() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_0);
    if(isDefined(var_0.team) && var_0.team == self.team) {
      continue;
    }

    if((isalive(var_0) && isDefined(var_0.sessionstate) && var_0.sessionstate != "spectator") || playercontrolledstreak(var_0)) {
      var_0.inenemybase = 1;
      var_0 thread func_654E(self);
    }
  }
}

func_654E(var_0) {
  self endon("death");
  level endon("game_ended");
  if(scripts\mp\utility::istrue(self.useoutline)) {
    return;
  }

  for(;;) {
    if(isDefined(self) && self istouching(var_0)) {
      if(!scripts\mp\utility::istrue(self.useoutline)) {
        thread enableenemybaseoutline();
      }
    } else {
      self.useoutline = 0;
      self.inenemybase = 0;
      if(isDefined(self.outlineid)) {
        thread disableenemybaseoutline();
      }

      break;
    }

    wait(0.05);
  }
}

enableenemybaseoutline() {
  self.useoutline = 1;
  self.outlinetime = gettime();
  self.outlineid = scripts\mp\utility::outlineenableforteam(self, "orange", scripts\mp\utility::getotherteam(self.team), 0, 1, "perk");
  if(!isbot(self)) {
    if(isplayer(self)) {
      scripts\mp\utility::_hudoutlineviewmodelenable(5, 0, 0);
    }
  }
}

disableenemybaseoutline() {
  self.useoutline = 0;
  scripts\mp\utility::outlinedisable(self.outlineid, self);
  self.outlineid = undefined;
  if(!isbot(self) && isplayer(self)) {
    scripts\mp\utility::_hudoutlineviewmodeldisable();
  }
}

enemybasekillstreakwatcher() {
  level endon("game_ended");
  for(;;) {
    if(level.turrets.size > 0) {
      foreach(var_1 in level.turrets) {
        handleoutlinesforstreaks(var_1);
      }
    }

    if(level.balldrones.size > 0) {
      foreach(var_4 in level.balldrones) {
        handleoutlinesforstreaks(var_4);
      }
    }

    wait(0.1);
  }
}

handleoutlinesforstreaks(var_0) {
  if(var_0.triggerportableradarping.team == self.team) {
    return;
  }

  if(var_0 istouching(self)) {
    if(!isDefined(var_0.outlineid)) {
      var_0.outlineid = scripts\mp\utility::outlineenableforteam(var_0, "orange", self.team, 0, 0, "lowest");
      return;
    }

    return;
  }

  if(isDefined(var_0.outlineid)) {
    scripts\mp\utility::outlinedisable(var_0.outlineid, var_0);
    var_0.outlineid = undefined;
    return;
  }
}

playercontrolledstreak(var_0) {
  if(isDefined(var_0.streakname)) {
    switch (var_0.streakname) {
      case "remote_c8":
      case "venom":
      case "minijackal":
        return 1;

      default:
        return 0;
    }
  }

  return 0;
}

showbaseeffecttoplayer(var_0) {
  var_1 = self.team;
  var_2 = undefined;
  var_3 = var_0.team;
  if(!isDefined(var_3)) {
    var_3 = "allies";
  }

  var_4 = var_0 ismlgspectator();
  if(var_4) {
    var_3 = var_0 getmlgspectatorteam();
  } else if(var_3 == "spectator") {
    var_3 = "allies";
  }

  var_5 = level.basefxid["friendly"];
  var_6 = level.basefxid["enemy"];
  if(var_3 == var_1) {
    showfxarray(self._baseeffectfriendly, var_0);
    hidefxarray(self._baseeffectenemy, var_0);
    return;
  }

  showfxarray(self._baseeffectenemy, var_0);
  hidefxarray(self._baseeffectfriendly, var_0);
}

showfxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] showtoplayer(var_1);
  }
}

hidefxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] hidefromplayer(var_1);
  }
}

spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];
  for(var_0 = 1; var_0 < self.visuals.size; var_0++) {
    var_1 = anglesToForward(self.visuals[var_0].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["friendly"], self.visuals[var_0].origin, var_1);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(var_0 = 1; var_0 < self.visuals.size; var_0++) {
    var_1 = anglesToForward(self.visuals[var_0].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["enemy"], self.visuals[var_0].origin, var_1);
    self._baseeffectenemy[self._baseeffectenemy.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectenemy[self._baseeffectenemy.size - 1]);
  }
}

base_setupvfx() {
  level.basefxid["friendly"] = loadfx("vfx\core\mp\core\vfx_front_border_cyan.vfx");
  level.basefxid["enemy"] = loadfx("vfx\core\mp\core\vfx_front_border_orng.vfx");
}

onplayerconnect() {
  var_0 = 1;
  for(;;) {
    level waittill("connected", var_1);
    if(var_0) {
      foreach(var_3 in level.zones) {
        var_3 spawnfxarray();
      }

      var_0 = 0;
    }

    foreach(var_3 in level.zones) {
      var_3 showbaseeffecttoplayer(var_1);
    }
  }
}

setupbaseareabrushes() {
  var_0 = getbasearray("front_zone_visual_allies_contest");
  var_1 = getbasearray("front_zone_visual_axis_contest");
  var_2 = getbasearray("front_zone_visual_allies_friend");
  var_3 = getbasearray("front_zone_visual_axis_friend");
  var_4 = getbasearray("front_zone_visual_allies_enemy");
  var_5 = getbasearray("front_zone_visual_axis_enemy");
  hidebasebrushes(var_0);
  hidebasebrushes(var_1);
  hidebasebrushes(var_2);
  hidebasebrushes(var_3);
  hidebasebrushes(var_4);
  hidebasebrushes(var_5);
}

hidebasebrushes(var_0) {
  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] hide();
    }
  }
}

getbasearray(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  return var_1;
}