/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_front_enemyBaseKillReveal", getmatchrulesdata("frontData", "enemyBaseKillReveal"));
  setdynamicdvar("scr_front_friendlyBaseScore", getmatchrulesdata("frontData", "friendlyBaseScore"));
  setdynamicdvar("scr_front_midfieldScore", getmatchrulesdata("frontData", "midfieldScore"));
  setdynamicdvar("scr_front_enemyBaseScore", getmatchrulesdata("frontData", "enemyBaseScore"));
  setdynamicdvar("scr_front_promode", 0);
}

function onstartgametype() {
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

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/FRONT");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/FRONT");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/FRONT_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/FRONT_HINT");
  }

  level.iconkill3d = "waypoint_capture_kill";
  level.iconkill2d = "waypoint_capture_kill";
  initspawns();
  base_setupvfx();
  thread setupbases();
  thread setupbaseareabrushes();
  level.disablebuddyspawn = 1;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.enemybasekillreveal = scripts\mp\utility\dvars::dvarfloatvalue("enemyBaseKillReveal", 5, 0, 60);
  level.friendlybasescore = scripts\mp\utility\dvars::dvarfloatvalue("friendlyBaseScore", 1, 0, 25);
  level.midfieldscore = scripts\mp\utility\dvars::dvarfloatvalue("midfieldScore", 2, 0, 25);
  level.enemybasescore = scripts\mp\utility\dvars::dvarfloatvalue("enemyBaseScore", 1, 0, 25);
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
  level.frontlinespawnsets = [];
  level.frontlinespawnsets["allies"] = "allies";
  level.frontlinespawnsets["axis"] = "axis";
  scripts\mp\spawnlogic::registerspawnset("allies", "mp_front_spawn_allies");
  scripts\mp\spawnlogic::registerspawnset("axis", "mp_front_spawn_axis");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function onspawnplayer() {
  if(isPlayer(self)) {
    self.inenemybase = 0;
    self.infriendlybase = 0;
    self.outlinetime = 0;

    if(isDefined(self.outlineid)) {
      scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
    }

    self.useoutline = 0;
    self.outlineid = undefined;
    thread friendlybasewatcher();
    thread enemybasewatcher();

    foreach(var_1 in level.zones) {
      showbaseeffecttoplayer(var_1, self);
    }

    return;
  }
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.frontlinespawnsets[var_0]);
  return var_1;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = 0;

  if(var_0.infriendlybase || var_1.inenemybase) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("enemy_base_kill", var_4);
    var_6 = level.enemybasescore;
  } else if(var_1.infriendlybase || var_0.inenemybase) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("friendly_base_kill", var_4);
    var_6 = level.friendlybasescore;
  } else {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("midfield_kill", var_4);
    var_6 = level.midfieldscore;
  }

  var_7 = game["teamScores"][var_1.pers["team"]] + var_6;
  var_8 = var_7 >= level.roundscorelimit;

  if(var_8 && level.roundscorelimit != 0) {
    var_6 = level.roundscorelimit - game["teamScores"][var_1.pers["team"]];
  }

  if(var_6 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_6, 0);
    var_1 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_6);
    return;
  }
}

function enemybasekillreveal() {
  level endon("game_ended");
  self endon("death");
  self notify("EnemyBaseKillReveal");
  self endon("EnemyBaseKillReveal");

  if(isDefined(self.basekilloutlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);
  }

  self.basekilloutlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
  }

  self sethudtutorialmessage(&"MP/FRONT_REVEALED");
  wait level.enemybasekillreveal;
  scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);
  scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  self clearhudtutorialmessage(0);
}

function setupbases() {
  level.zones = [];

  if(game["switchedsides"]) {
    level.allieszone = getEntArray("frontline_zone_allies", "targetname");

    foreach(var_1 in level.allieszone) {
      var_1.team = "axis";
      thread friendlybasewatcher();
      thread enemybasewatcher();
      thread enemybasekillstreakwatcher();
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
      thread friendlybasewatcher();
      thread enemybasewatcher();
      thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
    return;
  }

  level.allieszone = getEntArray("frontline_zone_allies", "targetname");

  foreach(var_1 in level.allieszone) {
    var_1.team = "allies";
    thread friendlybasewatcher();
    thread enemybasewatcher();
    thread enemybasekillstreakwatcher();
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
    thread friendlybasewatcher();
    thread enemybasewatcher();
    thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.axiszone[0]);
  level.zones[level.zones.size] = level.axiszone[0];
}

function setupvisuals(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, var_0);
}

function mappatchborders(var_0, var_1) {
  if(level.mapname == "mp_parkour" && var_1 == "front_vis_axis") {
    var_2 = spawn("script_origin", (-1088, -1504, 136));
    var_2.angles = (0, 180, 0);
    var_2.targetname = var_1;
    var_0 = var_2;
    var_3 = spawn("script_origin", (-1088, -1440, 136));
    var_3.angles = (0, 180, 0);
    var_2.targetname = var_1;
    var_0 = var_3;
  }

  return var_0;
}

function friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(var_0.team != self.team) {
      continue;
    }

    if(var_0.infriendlybase) {
      continue;
    }

    thread friendlybasetriggerwatcher(var_0);
  }
}

function friendlybasetriggerwatcher(var_0) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(game["switchedsides"]) {
    if(self.team == "allies") {
      var_1 = level.axiszone;
    } else {
      var_1 = level.allieszone;
    }

    goto LOC_00000071;
  }

  if(self.team == "allies") {
    var_1 = level.allieszone;
    goto LOC_00000071;
  }

  var_1 = level.axiszone;

  for(;;) {
    self.infriendlybase = 0;

    foreach(var_1 in var_1) {
      if(self istouching(var_1)) {
        self.infriendlybase = 1;
        break;
      }
    }

    if(!self.infriendlybase || scripts\mp\arbitrary_up::isinarbitraryup()) {
      if(istrue(self.spawnprotection)) {
        scripts\mp\gametypes\common::removespawnprotection();
      }

      break;
    }

    waitframe();
  }
}

function enemybasewatcher() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0.team) && var_0.team == self.team) {
      continue;
    }

    if(isalive(var_0) && isDefined(var_0.sessionstate) && var_0.sessionstate != "spectator" || playercontrolledstreak(var_0)) {
      var_0.inenemybase = 1;
      thread enemybasetriggerwatcher(var_0);
    }
  }
}

function enemybasetriggerwatcher(var_0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.useoutline)) {
    return;
  }

  for(;;) {
    if(isDefined(self) && self istouching(var_0)) {
      if(!istrue(self.useoutline)) {
        thread enableenemybaseoutline();
      }
    } else {
      self.useoutline = 0;
      self.inenemybase = 0;
      thread disableenemybaseoutline();
      break;
    }

    waitframe();
  }
}

function enableenemybaseoutline() {
  self.useoutline = 1;
  self.outlinetime = gettime();
  self.outlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    if(isPlayer(self)) {
      scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
      return;
    }

    return;
  }
}

function disableenemybaseoutline() {
  self.useoutline = 0;
  scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  self.outlineid = undefined;

  if(!isbot(self) && isPlayer(self)) {
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    return;
  }
}

function enemybasekillstreakwatcher() {
  level endon("game_ended");

  for(;;) {
    if(level.turrets.size > 0) {
      foreach(var_1 in level.turrets) {
        handleoutlinesforstreaks(var_1);
      }
    }

    wait 0.1;
  }
}

function handleoutlinesforstreaks(var_0) {
  if(var_0.owner.team == self.team) {
    return;
  }

  if(var_0 istouching(self)) {
    if(!isDefined(var_0.outlineid)) {
      var_0.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, self.team, "outline_nodepth_orange", "lowest");
      return;
    }

    return;
  }

  if(isDefined(var_0.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(var_0.outlineid, var_0);
    var_0.outlineid = undefined;
    return;
  }
}

function playercontrolledstreak(var_0) {
  if(isDefined(var_0.streakname)) {
    switch (var_0.streakname) {
      default:
        return false;
    }
  }

  return false;
}

function showbaseeffecttoplayer(var_0) {
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

function showfxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] showtoplayer(var_1);
  }
}

function hidefxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] hidefromplayer(var_1);
  }
}

function spawnfxarray() {
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

function base_setupvfx() {
  level.basefxid["friendly"] = loadfx("vfx/core/mp/core/vfx_front_border_cyan.vfx");
  level.basefxid["enemy"] = loadfx("vfx/core/mp/core/vfx_front_border_orng.vfx");
}

function spawnzonefx() {
  waitframe();

  foreach(var_1 in level.zones) {
    spawnfxarray(var_1);
  }
}

function onplayerconnect(var_0) {
  foreach(var_2 in level.zones) {
    showbaseeffecttoplayer(var_2, var_0);
  }
}

function setupbaseareabrushes() {
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

function hidebasebrushes(var_0) {
  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] hide();
    }

    return;
  }
}

function getbasearray(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  return var_1;
}