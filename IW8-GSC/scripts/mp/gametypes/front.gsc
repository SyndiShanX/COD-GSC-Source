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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/FRONT");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/FRONT");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/FRONT_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/FRONT_HINT");
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

    foreach(var1 in level.zones) {
      showbaseeffecttoplayer(var1, self);
    }

    return;
  }
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, level.frontlinespawnsets[var0]);
  return var1;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
  var6 = 0;

  if(var0.infriendlybase || var1.inenemybase) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("enemy_base_kill", var4);
    var6 = level.enemybasescore;
  } else if(var1.infriendlybase || var0.inenemybase) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("friendly_base_kill", var4);
    var6 = level.friendlybasescore;
  } else {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("midfield_kill", var4);
    var6 = level.midfieldscore;
  }

  var7 = game["teamScores"][var1.pers["team"]] + var6;
  var8 = var7 >= level.roundscorelimit;

  if(var8 && level.roundscorelimit != 0) {
    var6 = level.roundscorelimit - game["teamScores"][var1.pers["team"]];
  }

  if(var6 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1.pers["team"], var6, 0);
    var1 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var6);
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

    foreach(var1 in level.allieszone) {
      var1.team = "axis";
      thread friendlybasewatcher();
      thread enemybasewatcher();
      thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("frontline_zone_axis", "targetname");

    if(level.mapname == "mp_junk") {
      var3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var3;
    }

    foreach(var1 in level.axiszone) {
      var1.team = "allies";
      thread friendlybasewatcher();
      thread enemybasewatcher();
      thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
    return;
  }

  level.allieszone = getEntArray("frontline_zone_allies", "targetname");

  foreach(var1 in level.allieszone) {
    var1.team = "allies";
    thread friendlybasewatcher();
    thread enemybasewatcher();
    thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.allieszone[0]);
  level.zones[level.zones.size] = level.allieszone[0];
  level.axiszone = getEntArray("frontline_zone_axis", "targetname");

  if(level.mapname == "mp_junk") {
    var3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
    level.axiszone[level.axiszone.size] = var3;
  }

  foreach(var1 in level.axiszone) {
    var1.team = "axis";
    thread friendlybasewatcher();
    thread enemybasewatcher();
    thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.axiszone[0]);
  level.zones[level.zones.size] = level.axiszone[0];
}

function setupvisuals(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function mappatchborders(var0, var1) {
  if(level.mapname == "mp_parkour" && var1 == "front_vis_axis") {
    var2 = spawn("script_origin", (-1088, -1504, 136));
    var2.angles = (0, 180, 0);
    var2.targetname = var1;
    var0 = var2;
    var3 = spawn("script_origin", (-1088, -1440, 136));
    var3.angles = (0, 180, 0);
    var2.targetname = var1;
    var0 = var3;
  }

  return var0;
}

function friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(var0.team != self.team) {
      continue;
    }

    if(var0.infriendlybase) {
      continue;
    }

    thread friendlybasetriggerwatcher(var0);
  }
}

function friendlybasetriggerwatcher(var0) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(game["switchedsides"]) {
    if(self.team == "allies") {
      var1 = level.axiszone;
    } else {
      var1 = level.allieszone;
    }

    goto LOC_00000071;
  }

  if(self.team == "allies") {
    var1 = level.allieszone;
    goto LOC_00000071;
  }

  var1 = level.axiszone;

  for(;;) {
    self.infriendlybase = 0;

    foreach(var1 in var1) {
      if(self istouching(var1)) {
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
    self waittill("trigger", var0);

    if(isDefined(var0.team) && var0.team == self.team) {
      continue;
    }

    if(isalive(var0) && isDefined(var0.sessionstate) && var0.sessionstate != "spectator" || playercontrolledstreak(var0)) {
      var0.inenemybase = 1;
      thread enemybasetriggerwatcher(var0);
    }
  }
}

function enemybasetriggerwatcher(var0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.useoutline)) {
    return;
  }

  for(;;) {
    if(isDefined(self) && self istouching(var0)) {
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
      foreach(var1 in level.turrets) {
        handleoutlinesforstreaks(var1);
      }
    }

    wait 0.1;
  }
}

function handleoutlinesforstreaks(var0) {
  if(var0.owner.team == self.team) {
    return;
  }

  if(var0 istouching(self)) {
    if(!isDefined(var0.outlineid)) {
      var0.outlineid = scripts\mp\utility\outline::outlineenableforteam(var0, self.team, "outline_nodepth_orange", "lowest");
      return;
    }

    return;
  }

  if(isDefined(var0.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(var0.outlineid, var0);
    var0.outlineid = undefined;
    return;
  }
}

function playercontrolledstreak(var0) {
  if(isDefined(var0.streakname)) {
    switch (var0.streakname) {
      default:
        return false;
    }
  }

  return false;
}

function showbaseeffecttoplayer(var0) {
  var1 = self.team;
  var2 = undefined;
  var3 = var0.team;

  if(!isDefined(var3)) {
    var3 = "allies";
  }

  var4 = var0 ismlgspectator();

  if(var4) {
    var3 = var0 getmlgspectatorteam();
  } else if(var3 == "spectator") {
    var3 = "allies";
  }

  var5 = level.basefxid["friendly"];
  var6 = level.basefxid["enemy"];

  if(var3 == var1) {
    showfxarray(self._baseeffectfriendly, var0);
    hidefxarray(self._baseeffectenemy, var0);
    return;
  }

  showfxarray(self._baseeffectenemy, var0);
  hidefxarray(self._baseeffectfriendly, var0);
}

function showfxarray(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    var0[var2] showtoplayer(var1);
  }
}

function hidefxarray(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    var0[var2] hidefromplayer(var1);
  }
}

function spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];

  for(var0 = 1; var0 < self.visuals.size; var0++) {
    var1 = anglesToForward(self.visuals[var0].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["friendly"], self.visuals[var0].origin, var1);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(var0 = 1; var0 < self.visuals.size; var0++) {
    var1 = anglesToForward(self.visuals[var0].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["enemy"], self.visuals[var0].origin, var1);
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

  foreach(var1 in level.zones) {
    spawnfxarray(var1);
  }
}

function onplayerconnect(var0) {
  foreach(var2 in level.zones) {
    showbaseeffecttoplayer(var2, var0);
  }
}

function setupbaseareabrushes() {
  var0 = getbasearray("front_zone_visual_allies_contest");
  var1 = getbasearray("front_zone_visual_axis_contest");
  var2 = getbasearray("front_zone_visual_allies_friend");
  var3 = getbasearray("front_zone_visual_axis_friend");
  var4 = getbasearray("front_zone_visual_allies_enemy");
  var5 = getbasearray("front_zone_visual_axis_enemy");
  hidebasebrushes(var0);
  hidebasebrushes(var1);
  hidebasebrushes(var2);
  hidebasebrushes(var3);
  hidebasebrushes(var4);
  hidebasebrushes(var5);
}

function hidebasebrushes(var0) {
  if(isDefined(var0)) {
    for(var1 = 0; var1 < var0.size; var1++) {
      var0[var1] hide();
    }

    return;
  }
}

function getbasearray(var0) {
  var1 = getEntArray(var0, "targetname");

  if(!isDefined(var1) || var1.size == 0) {
    return undefined;
  }

  return var1;
}