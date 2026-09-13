/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tjugg.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 150);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.juggswitchtime = 90;
  }

  updategametypedvars();
  level.teambased = 1;
  level.doprematch = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  game["dialog"]["gametype"] = "gametype_tjugg";
  game["dialog"]["boost"] = "boost_tjugg";
  game["dialog"]["offense_obj"] = "boost_tjugg";
  game["dialog"]["defense_obj"] = "boost_tjugg";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_5E082608D1C0B076", getmatchrulesdata("tjuggData", "juggHealth"));
  setdynamicdvar("dvar_FD08A0BE7FB6883D", getmatchrulesdata("tjuggData", "juggSwitchTime"));
  setdynamicdvar("dvar_08552C10F4AAC8FF", getmatchrulesdata("tjuggData", "ppkAsJugg"));
  setdynamicdvar("dvar_66052A303431277A", getmatchrulesdata("tjuggData", "ppkOnJugg"));
  setdynamicdvar("dvar_CA1D7E784FC1147D", getmatchrulesdata("tjuggData", "ppkJuggOnJugg"));
  setdynamicdvar("dvar_611FCAE6CAEEBE05", 0);
  scripts\mp\utility\game::registerroundswitchdvar("tjugg", 0, 0, 9);
  setdynamicdvar("dvar_46632ECEA89E2D48", 1);
  scripts\mp\utility\game::registerroundlimitdvar("tjugg", 1);
  setdynamicdvar("dvar_71B71A084374019E", 1);
  scripts\mp\utility\game::registerwinlimitdvar("tjugg", 1);
  setdynamicdvar("dvar_C3B133ABF86E27DF", 0);
  scripts\mp\utility\game::registerhalftimedvar("tjugg", 0);
  setdynamicdvar("dvar_CFC79C8D140C710D", 0);
  setdynamicdvar("dvar_9CADB51D661E162D", 0);
  setdynamicdvar("scr_player_forcerespawn", 1);
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("dvar_3D9B2DCDB77FE161", 0);
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

  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/TJUGG");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/TJUGG");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/TJUGG");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/TJUGG");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/TJUGG_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/TJUGG_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/TJUGG_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/TJUGG_HINT");
  initspawns();
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("tjugg", ["usability", "killstreaks", "supers"]);
  level.respawnoldjugg_fx = loadfx("vfx/core/expl/bouncing_betty_explosion");
  level.jugg_available = [];
  level.jugg_available["axis"] = 1;
  level.jugg_available["allies"] = 1;
  level.jugg_attackers = [];
  level.jugg_attackers["axis"] = [];
  level.jugg_attackers["allies"] = [];
  level.jugg_currjugg = [];
  level.jugg_currjugg["axis"] = undefined;
  level.jugg_currjugg["allies"] = undefined;
  level.tjugg_timerdisplay = [];
  level.tjugg_timerdisplay["allies"] = scripts\mp\hud_util::createservertimer("objective", 1.4, "allies");
  level.tjugg_timerdisplay["allies"] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level.tjugg_timerdisplay["allies"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay["allies"].alpha = 0;
  level.tjugg_timerdisplay["allies"].archived = 0;
  level.tjugg_timerdisplay["allies"].hidewheninmenu = 1;
  level.tjugg_timerdisplay["axis"] = scripts\mp\hud_util::createservertimer("objective", 1.4, "axis");
  level.tjugg_timerdisplay["axis"] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level.tjugg_timerdisplay["axis"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay["axis"].alpha = 0;
  level.tjugg_timerdisplay["axis"].archived = 0;
  level.tjugg_timerdisplay["axis"].hidewheninmenu = 1;
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["allies"]);
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["axis"]);
  level.favorclosespawnscalar = 5;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.jugghealth = scripts\mp\utility\dvars::dvarintvalue("juggHealth", 1000, 1000, 10000);
  level.juggswitchtime = scripts\mp\utility\dvars::dvarfloatvalue("juggSwitchTime", 60, 10, 180);
  level.ppkasjugg = scripts\mp\utility\dvars::dvarintvalue("ppkAsJugg", 2, 1, 100);
  level.ppkonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkOnJugg", 5, 1, 100);
  level.ppkjuggonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkJuggOnJugg", 10, 1, 100);
}

onplayerconnect(player) {
  player.hasbeenjugg = 0;
  player.jugg_allegiance = 0;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"])
    spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback");

  return spawnpoint;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(smeansofdeath == "MOD_SUICIDE" && objweapon.basename == "none" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
    return;
  }
  victim = self;

  if(isDefined(victim.isjuggmodejuggernaut)) {
    if(isDefined(victim.juggoverlay))
      victim.juggoverlay destroy();

    victim.playerstreakspeedscale = undefined;
    victim.nostuckdamagekill = 0;
    victim scripts\mp\utility\player::_setsuit("iw9_defaultsuit_mp");
    cleanupobjectiveiconsforjugg(victim);
  }

  if(isDefined(attacker) && isPlayer(attacker)) {
    _id_F4D0EA798E0D0A66 = 0;
    _id_40D658E81E7BA8FF = 0;
    _id_9D26360583DE8411 = 0;
    _id_F2983A5AC513BD5E = 0;
    _id_B345478EFE9F8796 = 0;
    _id_A557A32D9A4AA6D6 = 0;
    score = 0;

    if(attacker == victim) {
      if(isDefined(victim.isjuggmodejuggernaut))
        _id_40D658E81E7BA8FF = 1;
    } else if(attacker.team != victim.team) {
      if(isDefined(victim.isjuggmodejuggernaut)) {
        _id_40D658E81E7BA8FF = 1;

        if(isDefined(attacker.isjuggmodejuggernaut))
          _id_9D26360583DE8411 = 1;
        else
          _id_F2983A5AC513BD5E = 1;
      } else if(isDefined(attacker.isjuggmodejuggernaut))
        _id_B345478EFE9F8796 = 1;

      if(level.jugg_available[attacker.team])
        _id_F4D0EA798E0D0A66 = 1;
    } else if(isDefined(victim.isjuggmodejuggernaut) && attacker.team == victim.team) {
      victim thread givejuggloadout();
      return;
    }

    if(_id_F4D0EA798E0D0A66)
      resetjugg(attacker);

    if(_id_40D658E81E7BA8FF) {
      _id_0E11D6CD8CFD3403 = getbestteammate(victim.team, 0);

      if(!isDefined(_id_0E11D6CD8CFD3403))
        _id_0E11D6CD8CFD3403 = getbestteammate(victim.team, 1);

      if(!isDefined(_id_0E11D6CD8CFD3403))
        _id_0E11D6CD8CFD3403 = victim;

      resetjugg(_id_0E11D6CD8CFD3403, victim);
    }

    if(_id_F4D0EA798E0D0A66 || _id_40D658E81E7BA8FF)
      scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");

    if(attacker != victim && attacker.team != victim.team && !isDefined(attacker.isjuggmodejuggernaut)) {
      if(attacker.hasbeenjugg) {
        attacker.jugg_allegiance = attacker.jugg_allegiance + 25;

        if(_id_F2983A5AC513BD5E)
          attacker.jugg_allegiance = attacker.jugg_allegiance + 75;

        if(isDefined(level.jugg_attackers[attacker.team][victim.guid])) {
          _id_A557A32D9A4AA6D6 = 1;
          attacker.jugg_allegiance = attacker.jugg_allegiance + 50;
          level.jugg_attackers[attacker.team][victim.guid] = undefined;
        }
      } else {
        attacker.jugg_allegiance = attacker.jugg_allegiance + 50;

        if(_id_F2983A5AC513BD5E)
          attacker.jugg_allegiance = attacker.jugg_allegiance + 100;

        if(isDefined(level.jugg_attackers[attacker.team][victim.guid])) {
          _id_A557A32D9A4AA6D6 = 1;
          attacker.jugg_allegiance = attacker.jugg_allegiance + 100;
          level.jugg_attackers[attacker.team][victim.guid] = undefined;
        }
      }
    }

    if(_id_F2983A5AC513BD5E) {
      attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_FD0C8FBAC1063EAA");
      score = level.ppkonjugg;
    } else if(_id_9D26360583DE8411) {
      attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_2B561EF0AC51E440");
      score = level.ppkjuggonjugg;
    } else if(_id_B345478EFE9F8796) {
      attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_670456684D1AC92F");
      score = level.ppkasjugg;
    }

    if(score)
      attacker scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score);

    if(attacker.team != victim.team && game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherteam[attacker.team]]) {
      attacker.finalkill = 1;
      return;
    }
  } else if(isDefined(victim.isjuggmodejuggernaut)) {
    _id_0E11D6CD8CFD3403 = getbestteammate(victim.team, 0);

    if(!isDefined(_id_0E11D6CD8CFD3403))
      _id_0E11D6CD8CFD3403 = getbestteammate(victim.team, 1);

    if(!isDefined(_id_0E11D6CD8CFD3403))
      _id_0E11D6CD8CFD3403 = victim;

    resetjugg(_id_0E11D6CD8CFD3403, victim);
  }
}

resetjugg(_id_F4D0EA798E0D0A66, _id_A978E1B119C99AE5) {
  if(isDefined(_id_A978E1B119C99AE5)) {
    _id_A978E1B119C99AE5 notify("lost_juggernaut");
    _id_A978E1B119C99AE5.isjuggmodejuggernaut = undefined;
  } else
    level.jugg_available[_id_F4D0EA798E0D0A66.team] = 0;

  level.jugg_currjugg[_id_F4D0EA798E0D0A66.team] = undefined;
  level.tjugg_timerdisplay[_id_F4D0EA798E0D0A66.team].alpha = 0;
  level.jugg_attackers[_id_F4D0EA798E0D0A66.team] = [];

  foreach(player in level.players) {
    if(player.team == _id_F4D0EA798E0D0A66.team)
      player.jugg_allegiance = 0;
  }

  _id_F4D0EA798E0D0A66 thread givejuggloadout();
}

givejuggloadout() {
  if(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote()) {
    self endon("disconnect");
    thread resetjuggloadoutondisconnect(0);

    while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote())
      waitframe();

    self notify("end_resetJuggLoadoutOnDisconnect");
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  if(istrue(self.isjuggmodejuggernaut)) {
    self notify("lost_juggernaut");
    waitframe();
  }

  self.isjuggmodejuggernaut = 1;
  level.jugg_currjugg[self.team] = self;
  self.hasbeenjugg = 1;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  scripts\mp\class::_id_A16868D4DCD81A4B();
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  createjuggobjectiveicon(self);
  thread updatejuggpingorigin();
  self.isjuggernaut = 1;
  self.maxhealth = level.jugghealth;
  self.health = self.maxhealth;
  self.nostuckdamagekill = 1;
  scripts\mp\class::loadout_clearweapons(1);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("tjugg", 0);
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_lm_kilo121", ["holo"], "none", "none", -1);
  self giveweapon(weapon);
  scripts\cp_mp\utility\inventory_utility::forcevalidweapon(weapon);
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_la_rpapa7", [], "none", "none", -1);
  self giveweapon(weapon);
  self givemaxammo(weapon);
  scripts\mp\utility\perk::giveperk("specialty_stun_resistance");
  scripts\mp\utility\perk::giveperk("specialty_sharp_focus");
  scripts\mp\utility\player::_setsuit("iw9_juggernaut_mp");
  self.playerstreakspeedscale = -0.2;
  scripts\mp\weapons::updatemovespeedscale();
  self.juggoverlay = newclienthudelem(self);
  self.juggoverlay.x = 0;
  self.juggoverlay.y = 0;
  self.juggoverlay.alignx = "left";
  self.juggoverlay.aligny = "top";
  self.juggoverlay.horzalign = "fullscreen";
  self.juggoverlay.vertalign = "fullscreen";
  self.juggoverlay setshader("gasmask_overlay_delta", 640, 480);
  self.juggoverlay.sort = -10;
  self.juggoverlay.archived = 1;
  self.juggoverlay.alpha = 1.0;
  self.friendlyoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outlinefill_nodepth_cyan", "killstreak");
  thread resetjuggloadoutondisconnect(1);
  thread resetjuggloadoutonchangeteam();
  thread rewardteammateproximity();
  thread logattackers();

  if(level.juggswitchtime != 0)
    thread nextjuggtimeout();
}

nextjuggtimeout() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  level.tjugg_timerdisplay[self.team].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay[self.team] settimer(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 0;
  _id_F4D0EA798E0D0A66 = getbestteammate(self.team, 0);

  if(!isDefined(_id_F4D0EA798E0D0A66))
    _id_F4D0EA798E0D0A66 = getbestteammate(self.team, 1);

  if(!isDefined(_id_F4D0EA798E0D0A66))
    _id_F4D0EA798E0D0A66 = self;

  scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
  resetjugg(_id_F4D0EA798E0D0A66, self);

  if(_id_F4D0EA798E0D0A66 != self)
    thread respawnoldjugg();
}

respawnoldjugg() {
  level endon("game_ended");
  self endon("disconnect");

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote())
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  playFX(level.respawnoldjugg_fx, self.origin);
  self notify("lost_juggernaut");
  waitframe();

  while(!self isonground())
    waitframe();

  self notify("faux_spawn");

  if(isDefined(self.juggoverlay))
    self.juggoverlay destroy();

  self.faux_spawn_stance = self getstance();
  self.playerstreakspeedscale = undefined;
  self.isjuggernaut = 0;
  self.nostuckdamagekill = 0;
  scripts\mp\utility\outline::outlinedisable(self.friendlyoutlineid, self);
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  thread scripts\mp\playerlogic::spawnplayer(1);
  scripts\mp\utility\player::_setsuit("iw9_defaultsuit_mp");
  scripts\mp\weapons::updatemovespeedscale();
  cleanupobjectiveiconsforjugg(self);
}

rewardteammateproximity() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    wait 1.0;

    foreach(player in level.players) {
      if(scripts\mp\utility\player::isreallyalive(player) && !player scripts\mp\utility\player::isusingremote() && player != self && player.team == self.team && distancesquared(player.origin, self.origin) < 48400) {
        if(player.hasbeenjugg) {
          player.jugg_allegiance = player.jugg_allegiance + 15;
          continue;
        }

        player.jugg_allegiance = player.jugg_allegiance + 25;
      }
    }
  }
}

logattackers() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("damage", amount, attacker);

    if(isPlayer(attacker) && attacker.team != self.team) {
      if(!isDefined(level.jugg_attackers[self.team][attacker.guid]))
        level.jugg_attackers[self.team][attacker.guid] = 1;
    }
  }
}

resetjuggloadoutondisconnect(endondeath) {
  level endon("game_ended");

  if(endondeath)
    self endon("death");
  else
    self endon("end_resetJuggLoadoutOnDisconnect");

  team = self.team;
  self waittill("disconnect");
  _id_F4D0EA798E0D0A66 = getbestteammate(team, 0);

  if(!isDefined(_id_F4D0EA798E0D0A66))
    _id_F4D0EA798E0D0A66 = getbestteammate(team, 1);

  if(isDefined(_id_F4D0EA798E0D0A66)) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(_id_F4D0EA798E0D0A66);
  } else {
    level.jugg_available[team] = 1;
    level.jugg_currjugg[team] = undefined;
    level.tjugg_timerdisplay[team].alpha = 0;
    level.jugg_attackers[team] = [];

    foreach(player in level.players) {
      if(player.team == team)
        player.jugg_allegiance = 0;
    }
  }
}

resetjuggloadoutonchangeteam() {
  level endon("game_ended");
  self endon("disconnect");
  team = self.team;
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self.isjuggmodejuggernaut = undefined;
  _id_F4D0EA798E0D0A66 = getbestteammate(team, 0);

  if(!isDefined(_id_F4D0EA798E0D0A66))
    _id_F4D0EA798E0D0A66 = getbestteammate(team, 1);

  if(isDefined(_id_F4D0EA798E0D0A66)) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(_id_F4D0EA798E0D0A66);
  } else {
    level.jugg_available[team] = 1;
    level.jugg_currjugg[team] = undefined;
    level.tjugg_timerdisplay[team].alpha = 0;
    level.jugg_attackers[team] = [];

    foreach(player in level.players) {
      if(player.team == team)
        player.jugg_allegiance = 0;
    }
  }
}

getbestteammate(team, _id_AA49DB1E361F4D64) {
  _id_1A17A46774678A07 = undefined;
  _id_0E21B54D8672D06A = -1;

  foreach(player in level.players) {
    if((_id_AA49DB1E361F4D64 || !player scripts\mp\utility\player::isusingremote()) && player != self && player.team == team && player.jugg_allegiance > _id_0E21B54D8672D06A) {
      _id_1A17A46774678A07 = player;
      _id_0E21B54D8672D06A = player.jugg_allegiance;
    }
  }

  return _id_1A17A46774678A07;
}

hidetimerdisplayongameend(_id_FFD9D60DF184BE9C) {
  level waittill("game_ended");
  _id_FFD9D60DF184BE9C.alpha = 0;
}

createjuggobjectiveicon(_id_72837284FE79DFAB) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_72837284FE79DFAB.juggobjid = objid;
  _id_72837284FE79DFAB.offset3d = (0, 0, 90);
  _id_72837284FE79DFAB.visibleteam = "any";
  _id_72837284FE79DFAB.ownerteam = _id_72837284FE79DFAB.team;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_72837284FE79DFAB.origin, "hud_icon_minimap_killstreak_juggernaut");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  scripts\mp\objidpoolmanager::update_objective_onentity(objid, _id_72837284FE79DFAB);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, _id_72837284FE79DFAB.offset3d[2]);
  objective_setownerteam(objid, _id_72837284FE79DFAB.team);
  objective_setfriendlylabel(objid, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  objective_setenemylabel(objid, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

cleanupobjectiveiconsforjugg(_id_72837284FE79DFAB) {
  scripts\mp\objidpoolmanager::returnobjectiveid(_id_72837284FE79DFAB.juggobjid);
  _id_72837284FE79DFAB.juggobjid = undefined;
}

updatejuggcurorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");

  for(;;) {
    self.curorigin = self.origin + (0, 0, 90);
    waitframe();
  }
}

updatejuggpingorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");
  thread updatejuggcurorigin();

  if(!isDefined(self.objpingdelay))
    self.objpingdelay = 4.0;

  for(;;) {
    foreach(_id_FABF84450735DD93 in level.teamnamelist) {
      if(!scripts\mp\gameobjects::isfriendlyteam(_id_FABF84450735DD93)) {
        objective_setpingsforteam(self.juggobjid, _id_FABF84450735DD93);
        objective_ping(self.juggobjid);
      }
    }

    scripts\engine\utility::waittill_any_timeout_no_endon_death_1(self.objpingdelay);
  }
}

setspecialloadouts() {
  level.tjugg_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.tjugg_loadouts["default"]["loadoutPrimary"] = "iw8_lm_kilo121";
  level.tjugg_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondary"] = "iw8_la_rpapa7";
  level.tjugg_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.tjugg_loadouts["default"]["loadoutMeleeSlot"] = "iw9_me_fists_mp_ls";
  level.tjugg_loadouts["default"]["loadoutEquipmentPrimary"] = "equip_frag";
  level.tjugg_loadouts["default"]["loadoutEquipmentSecondary"] = "equip_smoke";
  level.tjugg_loadouts["default"]["loadoutStreakType"] = "assault";
  level.tjugg_loadouts["default"]["loadoutKillstreak1"] = "none";
  level.tjugg_loadouts["default"]["loadoutKillstreak2"] = "none";
  level.tjugg_loadouts["default"]["loadoutKillstreak3"] = "none";
  level.tjugg_loadouts["default"]["loadoutSuper"] = "none";
  level.tjugg_loadouts["default"]["loadoutPerks"] = ["specialty_scavenger", "specialty_blastshield"];
  level.tjugg_loadouts["default"]["loadoutGesture"] = "playerData";
}