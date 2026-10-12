/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\arbitrary_up;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#namespace front;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 100);
    registerroundlimitdvar(getgametype(), 2);
    registerwinlimitdvar(getgametype(), 0);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  game["dialog"]["gametype"] = "frontline";

  if(getdvarint(@ "hash_4a2b3d01a81655a6")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(hashcat(@ "scr_", getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  thread spawnzonefx();
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_3e97c6567fefc5bd", getmatchrulesdata("frontData", "enemyBaseKillReveal"));
  setdynamicdvar(@ "hash_49f985623f33a0c9", getmatchrulesdata("frontData", "friendlyBaseScore"));
  setdynamicdvar(@ "hash_d6b034d5a365754d", getmatchrulesdata("frontData", "midfieldScore"));
  setdynamicdvar(@ "hash_95adf40e176fdeca", getmatchrulesdata("frontData", "enemyBaseScore"));
  setdynamicdvar(@ "hash_1686370aa066325", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/FRONT");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/FRONT");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/FRONT_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/FRONT_HINT");
  }

  level.iconkill3d = "waypoint_capture_kill";
  level.iconkill2d = "waypoint_capture_kill";
  initspawns();
  base_setupvfx();
  thread setupbases();
  thread setupbaseareabrushes();
  level.disablebuddyspawn = 1;

  thread function_8469a5927d069db7();
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.enemybasekillreveal = dvarfloatvalue("enemyBaseKillReveal", 5, 0, 60);
  level.friendlybasescore = dvarfloatvalue("friendlyBaseScore", 1, 0, 25);
  level.midfieldscore = dvarfloatvalue("midfieldScore", 2, 0, 25);
  level.enemybasescore = dvarfloatvalue("enemyBaseScore", 1, 0, 25);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  }

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

function onspawnplayer(revivespawn) {
  if(isPlayer(self)) {
    self.inenemybase = 0;
    self.infriendlybase = 0;
    self.outlinetime = 0;

    if(isDefined(self.outlineid)) {
      outlinedisable(self.outlineid, self);
    }

    self.useoutline = 0;
    self.outlineid = undefined;
    thread friendlybasewatcher();
    thread enemybasewatcher();

    foreach(zone in level.zones) {
      zone showbaseeffecttoplayer(self);
    }
  }
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"]) {
    spawnteam = getotherteam(spawnteam)[0];
  }

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.frontlinespawnsets[spawnteam]);
  return spawnpoint;
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  givescore = 0;

  if(victim.infriendlybase || attacker.inenemybase) {
    attacker thread function_e3e3e81453fd788b(#"hash_32c83db6a9b8dd6", objweapon);
    givescore = level.enemybasescore;
  } else if(attacker.infriendlybase || victim.inenemybase) {
    attacker thread function_e3e3e81453fd788b(#"hash_537f763990ad6bf3", objweapon);
    givescore = level.friendlybasescore;
  } else {
    attacker thread function_e3e3e81453fd788b(#"hash_4c4afed94af7fd08", objweapon);
    givescore = level.midfieldscore;
  }

  targetscore = game["teamScores"][attacker.pers["team"]] + givescore;
  hitscorelimit = targetscore >= level.roundscorelimit;

  if(hitscorelimit && level.roundscorelimit != 0) {
    givescore = level.roundscorelimit - game["teamScores"][attacker.pers["team"]];
  }

  if(givescore > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], givescore, 0);
    attacker thread scripts\mp\rank::scoreeventpopup(hashcat(#"hash_2c8bcbb02ec7ff9b", givescore));
  }
}

function enemybasekillreveal() {
  level endon("game_ended");
  self endon("death");
  self notify("EnemyBaseKillReveal");
  self endon("EnemyBaseKillReveal");

  if(isDefined(self.basekilloutlineid)) {
    outlinedisable(self.basekilloutlineid, self);
  }

  self.basekilloutlineid = outlineenableforteam(self, getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    _hudoutlineviewmodelenable("outline_nodepth_orange", 0);
  }

  self sethudtutorialmessage(&"MP/FRONT_REVEALED", 1);
  wait level.enemybasekillreveal;
  outlinedisable(self.basekilloutlineid, self);
  _hudoutlineviewmodeldisable();
  self clearhudtutorialmessage(0);
}

function setupbases() {
  level.zones = [];

  if(game["switchedsides"]) {
    level.allieszone = getEntArray("frontline_zone_allies", "targetname");

    foreach(zone in level.allieszone) {
      zone.team = "axis";
      zone thread friendlybasewatcher();
      zone thread enemybasewatcher();
      zone thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("frontline_zone_axis", "targetname");

    if(level.mapname == "mp_junk") {
      var_42f7956e85359a06 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var_42f7956e85359a06;
    }

    foreach(zone in level.axiszone) {
      zone.team = "allies";
      zone thread friendlybasewatcher();
      zone thread enemybasewatcher();
      zone thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
    return;
  }

  level.allieszone = getEntArray("frontline_zone_allies", "targetname");

  foreach(zone in level.allieszone) {
    zone.team = "allies";
    zone thread friendlybasewatcher();
    zone thread enemybasewatcher();
    zone thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.allieszone[0]);
  level.zones[level.zones.size] = level.allieszone[0];
  level.axiszone = getEntArray("frontline_zone_axis", "targetname");

  if(level.mapname == "mp_junk") {
    var_42f7956e85359a06 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
    level.axiszone[level.axiszone.size] = var_42f7956e85359a06;
  }

  foreach(zone in level.axiszone) {
    zone.team = "axis";
    zone thread friendlybasewatcher();
    zone thread enemybasewatcher();
    zone thread enemybasekillstreakwatcher();
  }

  thread setupvisuals(level.axiszone[0]);
  level.zones[level.zones.size] = level.axiszone[0];
}

function setupvisuals(zone) {
  visuals = [];
  visuals[0] = zone;

  if(isDefined(zone.target)) {
    othervisuals = getEntArray(zone.target, "targetname");

    for(j = 0; j < othervisuals.size; j++) {
      visuals[visuals.size] = othervisuals[j];
    }
  }

  visuals = mappatchborders(visuals, zone.target);
  zone.visuals = visuals;
}

function mappatchborders(visuals, targetname) {
  if(level.mapname == "mp_parkour" && targetname == "front_vis_axis") {
    ent1 = spawn("script_origin", (-1088, -1504, 136));
    ent1.angles = (0, 180, 0);
    ent1.targetname = targetname;
    visuals[visuals.size] = ent1;
    ent2 = spawn("script_origin", (-1088, -1440, 136));
    ent2.angles = (0, 180, 0);
    ent1.targetname = targetname;
    visuals[visuals.size] = ent2;
  }

  return visuals;
}

function friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player.team != self.team) {
      continue;
    }

    if(player.infriendlybase) {
      continue;
    }

    player thread friendlybasetriggerwatcher(self);
  }
}

function friendlybasetriggerwatcher(trigger) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(game["switchedsides"]) {
    if(self.team == "allies") {
      triggers = level.axiszone;
    } else {
      triggers = level.allieszone;
    }
  } else if(self.team == "allies") {
    triggers = level.allieszone;
  } else {
    triggers = level.axiszone;
  }

  while(true) {
    self.infriendlybase = 0;

    foreach(trigger in triggers) {
      if(self istouching(trigger)) {
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

  while(true) {
    self waittill("trigger", player);

    if(isDefined(player.team) && player.team == self.team) {
      continue;
    }

    if(isalive(player) && isDefined(player.sessionstate) && player.sessionstate != "spectator" || playercontrolledstreak(player)) {
      player.inenemybase = 1;
      player thread enemybasetriggerwatcher(self);
    }
  }
}

function enemybasetriggerwatcher(trigger) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.useoutline)) {
    return;
  }

  while(true) {
    if(isDefined(self) && self istouching(trigger)) {
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
  self.outlineid = outlineenableforteam(self, getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    if(isPlayer(self)) {
      _hudoutlineviewmodelenable("outline_nodepth_orange", 0);
    }
  }
}

function disableenemybaseoutline() {
  self.useoutline = 0;
  outlinedisable(self.outlineid, self);
  self.outlineid = undefined;

  if(!isbot(self) && isPlayer(self)) {
    _hudoutlineviewmodeldisable();
  }
}

function enemybasekillstreakwatcher() {
  level endon("game_ended");

  while(true) {
    if(level.turrets.size > 0) {
      foreach(turret in level.turrets) {
        handleoutlinesforstreaks(turret);
      }
    }

    wait 0.1;
  }
}

function handleoutlinesforstreaks(streak) {
  if(streak.owner.team == self.team) {
    return;
  }

  if(streak istouching(self)) {
    if(!isDefined(streak.outlineid)) {
      streak.outlineid = outlineenableforteam(streak, self.team, "outline_nodepth_orange", "lowest");
    }

    return;
  }

  if(isDefined(streak.outlineid)) {
    outlinedisable(streak.outlineid, streak);
    streak.outlineid = undefined;
  }
}

function playercontrolledstreak(player) {
  if(isDefined(player.streakname)) {
    return false;
  }

  return false;
}

function showbaseeffecttoplayer(player) {
  zoneteam = self.team;
  effect = undefined;
  var_8e879faf3052e0d2 = player.team;

  if(!isDefined(var_8e879faf3052e0d2)) {
    var_8e879faf3052e0d2 = "allies";
  }

  iscodcaster = player iscodcaster();

  if(iscodcaster) {
    var_8e879faf3052e0d2 = player function_638eebeff841e16a();
  } else if(var_8e879faf3052e0d2 == "spectator") {
    var_8e879faf3052e0d2 = "allies";
  }

  friendlyfx = level.basefxid["friendly"];
  enemyfx = level.basefxid["enemy"];

  if(var_8e879faf3052e0d2 == zoneteam) {
    showfxarray(self._baseeffectfriendly, player);
    hidefxarray(self._baseeffectenemy, player);
    return;
  }

  showfxarray(self._baseeffectenemy, player);
  hidefxarray(self._baseeffectfriendly, player);
}

function showfxarray(array, player) {
  for(i = 0; i < array.size; i++) {
    array[i] showtoplayer(player);
  }
}

function hidefxarray(array, player) {
  for(i = 0; i < array.size; i++) {
    array[i] hidefromplayer(player);
  }
}

function spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];

  for(i = 1; i < self.visuals.size; i++) {
    fxfwd = anglesToForward(self.visuals[i].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["friendly"], self.visuals[i].origin, fxfwd);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(i = 1; i < self.visuals.size; i++) {
    fxfwd = anglesToForward(self.visuals[i].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["enemy"], self.visuals[i].origin, fxfwd);
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

  foreach(zone in level.zones) {
    zone spawnfxarray();
  }
}

function onplayerconnect(player) {
  foreach(zone in level.zones) {
    zone showbaseeffecttoplayer(player);
  }
}

function setupbaseareabrushes() {
  var_cc3b1b8ac44951a8 = getbasearray("front_zone_visual_allies_contest");
  var_e82eaa629a967a01 = getbasearray("front_zone_visual_axis_contest");
  var_c460c49b683a0ca0 = getbasearray("front_zone_visual_allies_friend");
  var_8c66a4000f9adc9 = getbasearray("front_zone_visual_axis_friend");
  var_5cce0c45429a8293 = getbasearray("front_zone_visual_allies_enemy");
  var_51e29d3dbdb3a3a = getbasearray("front_zone_visual_axis_enemy");
  hidebasebrushes(var_cc3b1b8ac44951a8);
  hidebasebrushes(var_e82eaa629a967a01);
  hidebasebrushes(var_c460c49b683a0ca0);
  hidebasebrushes(var_8c66a4000f9adc9);
  hidebasebrushes(var_5cce0c45429a8293);
  hidebasebrushes(var_51e29d3dbdb3a3a);
}

function hidebasebrushes(brush) {
  if(isDefined(brush)) {
    for(index = 0; index < brush.size; index++) {
      brush[index] hide();
    }
  }
}

function getbasearray(targetname) {
  zones = getEntArray(targetname, "targetname");

  if(!isDefined(zones) || zones.size == 0) {
    return undefined;
  }

  return zones;
}

function function_8469a5927d069db7() {
  level endon("<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x2a>", getdvarint(@ "hash_46a6b424af6acbc2"), 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x34>", getdvarint(@ "hash_86e14326e43c0115"), 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_8469a5927d069db7();
}

# /