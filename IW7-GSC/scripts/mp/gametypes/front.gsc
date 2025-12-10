/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
******************************************/

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
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
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
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
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
  var_02[0] = level.gametype;
  scripts\mp\gameobjects::main(var_02);
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
    foreach(var_01 in level.zones) {
      var_01 showbaseeffecttoplayer(self);
    }
  }
}

getspawnpoint() {
  var_00 = self.pers["team"];
  if(game["switchedsides"]) {
    var_00 = scripts\mp\utility::getotherteam(var_00);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(var_00);
    var_02 = scripts\mp\spawnscoring::getspawnpoint(var_01);
  } else {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(var_02);
    var_03 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_01);
    var_02 = scripts\mp\spawnscoring::getspawnpoint(var_01, var_03);
  }

  return var_02;
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  scripts\mp\gametypes\common::onnormaldeath(param_00, param_01, param_02, param_03, param_04);
  var_05 = 0;
  if(param_00.infriendlybase || param_01.inenemybase) {
    param_01 thread scripts\mp\utility::giveunifiedpoints("enemy_base_kill", param_04);
    var_05 = level.enemybasescore;
  } else if(param_01.infriendlybase || param_00.inenemybase) {
    param_01 thread scripts\mp\utility::giveunifiedpoints("friendly_base_kill", param_04);
    var_05 = level.friendlybasescore;
  } else {
    param_01 thread scripts\mp\utility::giveunifiedpoints("midfield_kill", param_04);
    var_05 = level.midfieldscore;
  }

  var_06 = game["teamScores"][param_01.pers["team"]] + var_05;
  var_07 = var_06 >= level.roundscorelimit;
  if(var_07 && level.roundscorelimit != 0) {
    var_05 = level.roundscorelimit - game["teamScores"][param_01.pers["team"]];
  }

  if(var_05 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(param_01.pers["team"], var_05, 0);
    param_01 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_05);
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
    foreach(var_01 in level.allieszone) {
      var_01.team = "axis";
      var_01 thread friendlybasewatcher();
      var_01 thread func_654F();
      var_01 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("frontline_zone_axis", "targetname");
    if(level.mapname == "mp_junk") {
      var_03 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var_03;
    }

    foreach(var_01 in level.axiszone) {
      var_01.team = "allies";
      var_01 thread friendlybasewatcher();
      var_01 thread func_654F();
      var_01 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
    return;
  }

  level.allieszone = getEntArray("frontline_zone_allies", "targetname");
  foreach(var_01 in level.allieszone) {
    var_01.team = "allies";
    var_01 thread friendlybasewatcher();
    var_01 thread func_654F();
    var_01 thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.allieszone[0]);
  level.zones[level.zones.size] = level.allieszone[0];
  level.axiszone = getEntArray("frontline_zone_axis", "targetname");
  if(level.mapname == "mp_junk") {
    var_03 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
    level.axiszone[level.axiszone.size] = var_03;
  }

  foreach(var_01 in level.axiszone) {
    var_01.team = "axis";
    var_01 thread friendlybasewatcher();
    var_01 thread func_654F();
    var_01 thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.axiszone[0]);
  level.zones[level.zones.size] = level.axiszone[0];
}

setupvisuals(param_00) {
  var_01 = [];
  var_01[0] = param_00;
  if(isDefined(param_00.target)) {
    var_02 = getEntArray(param_00.target, "targetname");
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_01[var_01.size] = var_02[var_03];
    }
  }

  var_01 = mappatchborders(var_01, param_00.target);
  param_00.visuals = var_01;
}

mappatchborders(param_00, param_01) {
  if(level.mapname == "mp_parkour" && param_01 == "front_vis_axis") {
    var_02 = spawn("script_origin", (-1088, -1504, 136));
    var_02.angles = (0, 180, 0);
    var_02.var_336 = param_01;
    param_00[param_00.size] = var_02;
    var_03 = spawn("script_origin", (-1088, -1440, 136));
    var_03.angles = (0, 180, 0);
    var_02.var_336 = param_01;
    param_00[param_00.size] = var_03;
  }

  return param_00;
}

friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isplayer(var_00)) {
      continue;
    }

    if(var_00.team != self.team) {
      continue;
    }

    if(var_00.infriendlybase) {
      continue;
    }

    var_00 thread friendlybasetriggerwatcher(self);
  }
}

friendlybasetriggerwatcher(param_00) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(game["switchedsides"]) {
    if(self.team == "allies") {
      var_01 = level.axiszone;
    } else {
      var_01 = level.allieszone;
    }
  } else if(self.team == "allies") {
    var_01 = level.allieszone;
  } else {
    var_01 = level.axiszone;
  }

  for(;;) {
    self.infriendlybase = 0;
    foreach(param_00 in var_01) {
      if(self istouching(param_00)) {
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
    self waittill("trigger", var_00);
    if(isDefined(var_00.team) && var_00.team == self.team) {
      continue;
    }

    if((isalive(var_00) && isDefined(var_00.sessionstate) && var_00.sessionstate != "spectator") || playercontrolledstreak(var_00)) {
      var_00.inenemybase = 1;
      var_00 thread func_654E(self);
    }
  }
}

func_654E(param_00) {
  self endon("death");
  level endon("game_ended");
  if(scripts\mp\utility::istrue(self.useoutline)) {
    return;
  }

  for(;;) {
    if(isDefined(self) && self istouching(param_00)) {
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
      foreach(var_01 in level.turrets) {
        handleoutlinesforstreaks(var_01);
      }
    }

    if(level.balldrones.size > 0) {
      foreach(var_04 in level.balldrones) {
        handleoutlinesforstreaks(var_04);
      }
    }

    wait(0.1);
  }
}

handleoutlinesforstreaks(param_00) {
  if(param_00.triggerportableradarping.team == self.team) {
    return;
  }

  if(param_00 istouching(self)) {
    if(!isDefined(param_00.outlineid)) {
      param_00.outlineid = scripts\mp\utility::outlineenableforteam(param_00, "orange", self.team, 0, 0, "lowest");
      return;
    }

    return;
  }

  if(isDefined(param_00.outlineid)) {
    scripts\mp\utility::outlinedisable(param_00.outlineid, param_00);
    param_00.outlineid = undefined;
    return;
  }
}

playercontrolledstreak(param_00) {
  if(isDefined(param_00.streakname)) {
    switch (param_00.streakname) {
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

showbaseeffecttoplayer(param_00) {
  var_01 = self.team;
  var_02 = undefined;
  var_03 = param_00.team;
  if(!isDefined(var_03)) {
    var_03 = "allies";
  }

  var_04 = param_00 ismlgspectator();
  if(var_04) {
    var_03 = param_00 getmlgspectatorteam();
  } else if(var_03 == "spectator") {
    var_03 = "allies";
  }

  var_05 = level.basefxid["friendly"];
  var_06 = level.basefxid["enemy"];
  if(var_03 == var_01) {
    showfxarray(self._baseeffectfriendly, param_00);
    hidefxarray(self._baseeffectenemy, param_00);
    return;
  }

  showfxarray(self._baseeffectenemy, param_00);
  hidefxarray(self._baseeffectfriendly, param_00);
}

showfxarray(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    param_00[var_02] showtoplayer(param_01);
  }
}

hidefxarray(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    param_00[var_02] hidefromplayer(param_01);
  }
}

spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];
  for(var_00 = 1; var_00 < self.visuals.size; var_00++) {
    var_01 = anglesToForward(self.visuals[var_00].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["friendly"], self.visuals[var_00].origin, var_01);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(var_00 = 1; var_00 < self.visuals.size; var_00++) {
    var_01 = anglesToForward(self.visuals[var_00].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["enemy"], self.visuals[var_00].origin, var_01);
    self._baseeffectenemy[self._baseeffectenemy.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectenemy[self._baseeffectenemy.size - 1]);
  }
}

base_setupvfx() {
  level.basefxid["friendly"] = loadfx("vfx\core\mp\core\vfx_front_border_cyan.vfx");
  level.basefxid["enemy"] = loadfx("vfx\core\mp\core\vfx_front_border_orng.vfx");
}

onplayerconnect() {
  var_00 = 1;
  for(;;) {
    level waittill("connected", var_01);
    if(var_00) {
      foreach(var_03 in level.zones) {
        var_03 spawnfxarray();
      }

      var_00 = 0;
    }

    foreach(var_03 in level.zones) {
      var_03 showbaseeffecttoplayer(var_01);
    }
  }
}

setupbaseareabrushes() {
  var_00 = getbasearray("front_zone_visual_allies_contest");
  var_01 = getbasearray("front_zone_visual_axis_contest");
  var_02 = getbasearray("front_zone_visual_allies_friend");
  var_03 = getbasearray("front_zone_visual_axis_friend");
  var_04 = getbasearray("front_zone_visual_allies_enemy");
  var_05 = getbasearray("front_zone_visual_axis_enemy");
  hidebasebrushes(var_00);
  hidebasebrushes(var_01);
  hidebasebrushes(var_02);
  hidebasebrushes(var_03);
  hidebasebrushes(var_04);
  hidebasebrushes(var_05);
}

hidebasebrushes(param_00) {
  if(isDefined(param_00)) {
    for(var_01 = 0; var_01 < param_00.size; var_01++) {
      param_00[var_01] hide();
    }
  }
}

getbasearray(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  if(!isDefined(var_01) || var_01.size == 0) {
    return undefined;
  }

  return var_01;
}