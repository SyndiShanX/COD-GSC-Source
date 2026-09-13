/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 100);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  game["dialog"]["gametype"] = "frontline";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  thread spawnzonefx();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_front_enemybasekillreveal", getmatchrulesdata("frontData", "enemyBaseKillReveal"));
  setdynamicdvar("scr_front_friendlybasescore", getmatchrulesdata("frontData", "friendlyBaseScore"));
  setdynamicdvar("scr_front_midfieldscore", getmatchrulesdata("frontData", "midfieldScore"));
  setdynamicdvar("scr_front_enemybasescore", getmatchrulesdata("frontData", "enemyBaseScore"));
  setdynamicdvar("dvar_01686370AA066325", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/FRONT");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/FRONT");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/FRONT_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/FRONT_HINT");
  }

  level.iconkill3d = "waypoint_capture_kill";
  level.iconkill2d = "waypoint_capture_kill";
  initspawns();
  base_setupvfx();
  thread setupbases();
  thread setupbaseareabrushes();
  level.disablebuddyspawn = 1;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.enemybasekillreveal = scripts\mp\utility\dvars::dvarfloatvalue("enemyBaseKillReveal", 5, 0, 60);
  level.friendlybasescore = scripts\mp\utility\dvars::dvarfloatvalue("friendlyBaseScore", 1, 0, 25);
  level.midfieldscore = scripts\mp\utility\dvars::dvarfloatvalue("midfieldScore", 2, 0, 25);
  level.enemybasescore = scripts\mp\utility\dvars::dvarfloatvalue("enemyBaseScore", 1, 0, 25);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
  level.frontlinespawnsets = [];
  level.frontlinespawnsets["allies"] = "allies";
  level.frontlinespawnsets["axis"] = "axis";

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_26508F2DE04C7A52::_id_1150A8D7A08DF473();
  else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    scripts\mp\spawnlogic::registerspawnset("allies", "mp_front_spawn_allies");
    scripts\mp\spawnlogic::registerspawnset("axis", "mp_front_spawn_axis");
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  if(isPlayer(self)) {
    self.inenemybase = 0;
    self.infriendlybase = 0;
    self.outlinetime = 0;

    if(isDefined(self.outlineid))
      scripts\mp\utility\outline::outlinedisable(self.outlineid, self);

    self.useoutline = 0;
    self.outlineid = undefined;
    thread friendlybasewatcher();
    thread enemybasewatcher();

    foreach(zone in level.zones)
    zone showbaseeffecttoplayer(self);
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"])
    spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.frontlinespawnsets[spawnteam]);
  return spawnpoint;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  _id_A7F928303DA7CDD2 = 0;

  if(victim.infriendlybase || attacker.inenemybase) {
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_032C83DB6A9B8DD6", objweapon);
    _id_A7F928303DA7CDD2 = level.enemybasescore;
  } else if(attacker.infriendlybase || victim.inenemybase) {
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_537F763990AD6BF3", objweapon);
    _id_A7F928303DA7CDD2 = level.friendlybasescore;
  } else {
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_4C4AFED94AF7FD08", objweapon);
    _id_A7F928303DA7CDD2 = level.midfieldscore;
  }

  _id_882B7AD682FF97CE = game["teamScores"][attacker.pers["team"]] + _id_A7F928303DA7CDD2;
  hitscorelimit = _id_882B7AD682FF97CE >= level.roundscorelimit;

  if(hitscorelimit && level.roundscorelimit != 0)
    _id_A7F928303DA7CDD2 = level.roundscorelimit - game["teamScores"][attacker.pers["team"]];

  if(_id_A7F928303DA7CDD2 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], _id_A7F928303DA7CDD2, 0);
    attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", _id_A7F928303DA7CDD2));
  }
}

enemybasekillreveal() {
  level endon("game_ended");
  self endon("death");
  self notify("EnemyBaseKillReveal");
  self endon("EnemyBaseKillReveal");

  if(isDefined(self.basekilloutlineid))
    scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);

  self.basekilloutlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self))
    scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);

  self sethudtutorialmessage(&"MP/FRONT_REVEALED", 1);
  wait(level.enemybasekillreveal);
  scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);
  scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  self clearhudtutorialmessage(0);
}

setupbases() {
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
      _id_42F7956E85359A06 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = _id_42F7956E85359A06;
    }

    foreach(zone in level.axiszone) {
      zone.team = "allies";
      zone thread friendlybasewatcher();
      zone thread enemybasewatcher();
      zone thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
  } else {
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
      _id_42F7956E85359A06 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = _id_42F7956E85359A06;
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
}

setupvisuals(zone) {
  visuals = [];
  visuals[0] = zone;

  if(isDefined(zone.target)) {
    _id_C236336A4B27E7DA = getEntArray(zone.target, "targetname");

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_C236336A4B27E7DA.size; _id_AC0E5C4AC96AAA41++)
      visuals[visuals.size] = _id_C236336A4B27E7DA[_id_AC0E5C4AC96AAA41];
  }

  visuals = mappatchborders(visuals, zone.target);
  zone.visuals = visuals;
}

mappatchborders(visuals, targetname) {
  if(level.mapname == "mp_parkour" && targetname == "front_vis_axis") {
    _id_6848D0559BA20855 = spawn("script_origin", (-1088, -1504, 136));
    _id_6848D0559BA20855.angles = (0, 180, 0);
    _id_6848D0559BA20855.targetname = targetname;
    visuals[visuals.size] = _id_6848D0559BA20855;
    _id_6848CD559BA201BC = spawn("script_origin", (-1088, -1440, 136));
    _id_6848CD559BA201BC.angles = (0, 180, 0);
    _id_6848D0559BA20855.targetname = targetname;
    visuals[visuals.size] = _id_6848CD559BA201BC;
  }

  return visuals;
}

friendlybasewatcher() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
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

friendlybasetriggerwatcher(trigger) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(game["switchedsides"]) {
    if(self.team == "allies")
      triggers = level.axiszone;
    else
      triggers = level.allieszone;
  } else if(self.team == "allies")
    triggers = level.allieszone;
  else
    triggers = level.axiszone;

  for(;;) {
    self.infriendlybase = 0;

    foreach(trigger in triggers) {
      if(self istouching(trigger)) {
        self.infriendlybase = 1;
        break;
      }
    }

    if(!self.infriendlybase || scripts\mp\arbitrary_up::isinarbitraryup()) {
      if(istrue(self.spawnprotection))
        _id_0FD32F08E72B657F::removespawnprotection();

      break;
    }

    waitframe();
  }
}

enemybasewatcher() {
  level endon("game_ended");

  for(;;) {
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

enemybasetriggerwatcher(trigger) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.useoutline)) {
    return;
  }
  for(;;) {
    if(isDefined(self) && self istouching(trigger)) {
      if(!istrue(self.useoutline))
        thread enableenemybaseoutline();
    } else {
      self.useoutline = 0;
      self.inenemybase = 0;
      thread disableenemybaseoutline();
      break;
    }

    waitframe();
  }
}

enableenemybaseoutline() {
  self.useoutline = 1;
  self.outlinetime = gettime();
  self.outlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    if(isPlayer(self))
      scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
  }
}

disableenemybaseoutline() {
  self.useoutline = 0;
  scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  self.outlineid = undefined;

  if(!isbot(self) && isPlayer(self))
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

enemybasekillstreakwatcher() {
  level endon("game_ended");

  for(;;) {
    if(level.turrets.size > 0) {
      foreach(turret in level.turrets)
      handleoutlinesforstreaks(turret);
    }

    wait 0.1;
  }
}

handleoutlinesforstreaks(_id_153FDEE861E0F06F) {
  if(_id_153FDEE861E0F06F.owner.team == self.team) {
    return;
  }
  if(_id_153FDEE861E0F06F istouching(self)) {
    if(!isDefined(_id_153FDEE861E0F06F.outlineid))
      _id_153FDEE861E0F06F.outlineid = scripts\mp\utility\outline::outlineenableforteam(_id_153FDEE861E0F06F, self.team, "outline_nodepth_orange", "lowest");
  } else if(isDefined(_id_153FDEE861E0F06F.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(_id_153FDEE861E0F06F.outlineid, _id_153FDEE861E0F06F);
    _id_153FDEE861E0F06F.outlineid = undefined;
  } else {}
}

playercontrolledstreak(player) {
  if(isDefined(player.streakname)) {
    switch (player.streakname) {
      default:
        return 0;
    }
  }

  return 0;
}

showbaseeffecttoplayer(player) {
  _id_16A1AB6DFEB8D692 = self.team;
  effect = undefined;
  _id_8E879FAF3052E0D2 = player.team;

  if(!isDefined(_id_8E879FAF3052E0D2))
    _id_8E879FAF3052E0D2 = "allies";

  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391)
    _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();
  else if(_id_8E879FAF3052E0D2 == "spectator")
    _id_8E879FAF3052E0D2 = "allies";

  _id_8A17F30E4281C05C = level.basefxid["friendly"];
  _id_C5DEA800696CF6A9 = level.basefxid["enemy"];

  if(_id_8E879FAF3052E0D2 == _id_16A1AB6DFEB8D692) {
    showfxarray(self._baseeffectfriendly, player);
    hidefxarray(self._baseeffectenemy, player);
  } else {
    showfxarray(self._baseeffectenemy, player);
    hidefxarray(self._baseeffectfriendly, player);
  }
}

showfxarray(array, player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    array[_id_AC0E594AC96AA3A8] showtoplayer(player);
}

hidefxarray(array, player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    array[_id_AC0E594AC96AA3A8] hidefromplayer(player);
}

spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self.visuals.size; _id_AC0E594AC96AA3A8++) {
    _id_5DAA42F92E5E9BE8 = anglesToForward(self.visuals[_id_AC0E594AC96AA3A8].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["friendly"], self.visuals[_id_AC0E594AC96AA3A8].origin, _id_5DAA42F92E5E9BE8);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self.visuals.size; _id_AC0E594AC96AA3A8++) {
    _id_5DAA42F92E5E9BE8 = anglesToForward(self.visuals[_id_AC0E594AC96AA3A8].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["enemy"], self.visuals[_id_AC0E594AC96AA3A8].origin, _id_5DAA42F92E5E9BE8);
    self._baseeffectenemy[self._baseeffectenemy.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectenemy[self._baseeffectenemy.size - 1]);
  }
}

base_setupvfx() {
  level.basefxid["friendly"] = loadfx("vfx/core/mp/core/vfx_front_border_cyan.vfx");
  level.basefxid["enemy"] = loadfx("vfx/core/mp/core/vfx_front_border_orng.vfx");
}

spawnzonefx() {
  waitframe();

  foreach(zone in level.zones)
  zone spawnfxarray();
}

onplayerconnect(player) {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player thread _id_26508F2DE04C7A52::_id_8BB13AA2A5D32576(player, "mp_gametype_front_mgl_match_introduction");

  foreach(zone in level.zones)
  zone showbaseeffecttoplayer(player);
}

setupbaseareabrushes() {
  _id_CC3B1B8AC44951A8 = getbasearray("front_zone_visual_allies_contest");
  _id_E82EAA629A967A01 = getbasearray("front_zone_visual_axis_contest");
  _id_C460C49B683A0CA0 = getbasearray("front_zone_visual_allies_friend");
  _id_08C66A4000F9ADC9 = getbasearray("front_zone_visual_axis_friend");
  _id_5CCE0C45429A8293 = getbasearray("front_zone_visual_allies_enemy");
  _id_051E29D3DBDB3A3A = getbasearray("front_zone_visual_axis_enemy");
  hidebasebrushes(_id_CC3B1B8AC44951A8);
  hidebasebrushes(_id_E82EAA629A967A01);
  hidebasebrushes(_id_C460C49B683A0CA0);
  hidebasebrushes(_id_08C66A4000F9ADC9);
  hidebasebrushes(_id_5CCE0C45429A8293);
  hidebasebrushes(_id_051E29D3DBDB3A3A);
}

hidebasebrushes(brush) {
  if(isDefined(brush)) {
    for(index = 0; index < brush.size; index++)
      brush[index] hide();
  }
}

getbasearray(targetname) {
  zones = getEntArray(targetname, "targetname");

  if(!isDefined(zones) || zones.size == 0)
    return undefined;

  return zones;
}