/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tjugg.gsc
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
  setdynamicdvar("scr_tjugg_juggHealth", getmatchrulesdata("tjuggData", "juggHealth"));
  setdynamicdvar("scr_tjugg_juggswitchtime", getmatchrulesdata("tjuggData", "juggSwitchTime"));
  setdynamicdvar("scr_tjugg_ppkasjugg", getmatchrulesdata("tjuggData", "ppkAsJugg"));
  setdynamicdvar("scr_tjugg_ppkonjugg", getmatchrulesdata("tjuggData", "ppkOnJugg"));
  setdynamicdvar("scr_tjugg_ppkjuggonjugg", getmatchrulesdata("tjuggData", "ppkJuggOnJugg"));
  setdynamicdvar("scr_tjugg_roundswitch", 0);
  scripts\mp\utility\game::registerroundswitchdvar("tjugg", 0, 0, 9);
  setdynamicdvar("scr_tjugg_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("tjugg", 1);
  setdynamicdvar("scr_tjugg_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("tjugg", 1);
  setdynamicdvar("scr_tjugg_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("tjugg", 0);
  setdynamicdvar("scr_tjugg_playerrespawndelay", 0);
  setdynamicdvar("scr_tjugg_waverespawndelay", 0);
  setdynamicdvar("scr_player_forcerespawn", 1);
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("scr_tjugg_promode", 0);
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
  scripts\mp\playeractions::registeractionset("tjugg", ["usability", "killstreaks", "supers"]);
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

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.jugghealth = scripts\mp\utility\dvars::dvarintvalue("juggHealth", 1000, 1000, 10000);
  level.juggswitchtime = scripts\mp\utility\dvars::dvarfloatvalue("juggSwitchTime", 60, 10, 180);
  level.ppkasjugg = scripts\mp\utility\dvars::dvarintvalue("ppkAsJugg", 2, 1, 100);
  level.ppkonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkOnJugg", 5, 1, 100);
  level.ppkjuggonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkJuggOnJugg", 10, 1, 100);
}

function onplayerconnect(var0) {
  var0.hasbeenjugg = 0;
  var0.jugg_allegiance = 0;
}

function initspawns() {
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

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, "normal", "fallback");
  }

  return var2;
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(var3 == "MOD_SUICIDE" && var4.basename == "none" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
    return;
  }

  var10 = self;

  if(isDefined(var10.isjuggmodejuggernaut)) {
    if(isDefined(var10.juggoverlay)) {
      var10.juggoverlay destroy();
    }

    var10.playerstreakspeedscale = undefined;
    var10.nostuckdamagekill = 0;
    var10 scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
    cleanupobjectiveiconsforjugg(var10);
  }

  if(isDefined(var1) && isPlayer(var1)) {
    var11 = 0;
    var12 = 0;
    var13 = 0;
    var14 = 0;
    var15 = 0;
    var16 = 0;
    var17 = 0;

    if(var1 == var10) {
      if(isDefined(var10.isjuggmodejuggernaut)) {
        var12 = 1;
      }
    } else if(var1.team != var10.team) {
      if(isDefined(var10.isjuggmodejuggernaut)) {
        var12 = 1;

        if(isDefined(var1.isjuggmodejuggernaut)) {
          var13 = 1;
        } else {
          var14 = 1;
        }
      } else if(isDefined(var1.isjuggmodejuggernaut)) {
        var15 = 1;
      }

      if(level.jugg_available[var1.team]) {
        var11 = 1;
      }
    } else if(isDefined(var10.isjuggmodejuggernaut) && var1.team == var10.team) {
      thread givejuggloadout();
      return;
    }

    if(var11) {
      resetjugg(var1);
    }

    if(var12) {
      var18 = getbestteammate(var10.team, 0);

      if(!isDefined(var18)) {
        var18 = getbestteammate(var10.team, 1);
      }

      if(!isDefined(var18)) {
        var18 = var10;
      }

      resetjugg(var18, var10);
    }

    if(var11 || var12) {
      scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    }

    if(var1 != var10 && var1.team != var10.team && !isDefined(var1.isjuggmodejuggernaut)) {
      if(var1.hasbeenjugg) {
        var1.jugg_allegiance += 25;

        if(var14) {
          var1.jugg_allegiance += 75;
        }

        if(isDefined(level.jugg_attackers[var1.team][var10.guid])) {
          var16 = 1;
          var1.jugg_allegiance += 50;
          level.jugg_attackers[var1.team][var10.guid] = undefined;
        }
      } else {
        var1.jugg_allegiance += 50;

        if(var14) {
          var1.jugg_allegiance += 100;
        }

        if(isDefined(level.jugg_attackers[var1.team][var10.guid])) {
          var16 = 1;
          var1.jugg_allegiance += 100;
          level.jugg_attackers[var1.team][var10.guid] = undefined;
        }
      }
    }

    if(var14) {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("kill_juggernaut");
      var17 = level.ppkonjugg;
    } else if(var13) {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("jugg_on_jugg");
      var17 = level.ppkjuggonjugg;
    } else if(var15) {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("kill_as_juggernaut");
      var17 = level.ppkasjugg;
    }

    if(var17) {
      var1 scripts\mp\gamescore::giveteamscoreforobjective(var1.pers["team"], var17);
    }

    if(var1.team != var10.team && game["state"] == "postgame" && game["teamScores"][var1.team] > game["teamScores"][level.otherteam[var1.team]]) {
      var1.finalkill = 1;
      return;
    }

    return;
  }

  if(isDefined(var10.isjuggmodejuggernaut)) {
    var18 = getbestteammate(var10.team, 0);

    if(!isDefined(var18)) {
      var18 = getbestteammate(var10.team, 1);
    }

    if(!isDefined(var18)) {
      var18 = var10;
    }

    resetjugg(var18, var10);
    return;
  }
}

function resetjugg(var0, var1) {
  if(isDefined(var1)) {
    var1 notify("lost_juggernaut");
    var1.isjuggmodejuggernaut = undefined;
  } else {
    level.jugg_available[var0.team] = 0;
  }

  level.jugg_currjugg[var0.team] = undefined;
  level.tjugg_timerdisplay[var0.team].alpha = 0;
  level.jugg_attackers[var0.team] = [];

  foreach(var3 in level.players) {
    if(var3.team == var0.team) {
      var3.jugg_allegiance = 0;
    }
  }

  thread givejuggloadout();
}

function givejuggloadout() {
  if(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote()) {
    self endon("disconnect");
    thread resetjuggloadoutondisconnect(0);

    while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote()) {
      waitframe();
    }

    self notify("end_resetJuggLoadoutOnDisconnect");
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  if(istrue(self.isjuggmodejuggernaut)) {
    self notify("lost_juggernaut");
    waitframe();
  }

  self.isjuggmodejuggernaut = 1;
  level.jugg_currjugg[self.team] = self;
  self.hasbeenjugg = 1;
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
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
  scripts\mp\playeractions::allowactionset("tjugg", 0);
  var0 = scripts\mp\class::buildweapon("iw8_lm_kilo121", ["holo"], "none", "none", -1);
  self giveweapon(var0);
  scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var0);
  var0 = scripts\mp\class::buildweapon("iw8_la_rpapa7", [], "none", "none", -1);
  self giveweapon(var0);
  self givemaxammo(var0);
  scripts\mp\utility\perk::giveperk("specialty_stun_resistance");
  scripts\mp\utility\perk::giveperk("specialty_sharp_focus");
  scripts\mp\utility\player::_setsuit("iw8_juggernaut_mp");
  self.playerstreakspeedscale = -0.2;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\juggernaut::jugg_setModel();
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
  self.juggoverlay.alpha = 1;
  self.friendlyoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outlinefill_nodepth_cyan", "killstreak");
  thread resetjuggloadoutondisconnect(1);
  thread resetjuggloadoutonchangeteam();
  thread rewardteammateproximity();
  thread logattackers();

  if(level.juggswitchtime != 0) {
    thread nextjuggtimeout();
    return;
  }
}

function nextjuggtimeout() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  level.tjugg_timerdisplay[self.team].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay[self.team] settimer(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 0;
  var0 = getbestteammate(self.team, 0);

  if(!isDefined(var0)) {
    var0 = getbestteammate(self.team, 1);
  }

  if(!isDefined(var0)) {
    var0 = self;
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
  resetjugg(var0, self);

  if(var0 != self) {
    thread respawnoldjugg();
    return;
  }
}

function respawnoldjugg() {
  level endon("game_ended");
  self endon("disconnect");

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote()) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  playFX(level.respawnoldjugg_fx, self.origin);
  self notify("lost_juggernaut");
  waitframe();

  while(!self isonground()) {
    waitframe();
  }

  self notify("faux_spawn");

  if(isDefined(self.juggoverlay)) {
    self.juggoverlay destroy();
  }

  self.faux_spawn_stance = self getstance();
  self.playerstreakspeedscale = undefined;
  self.isjuggernaut = 0;
  self.nostuckdamagekill = 0;
  scripts\mp\utility\outline::outlinedisable(self.friendlyoutlineid, self);
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  thread scripts\mp\playerlogic::spawnplayer(1);
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
  scripts\mp\weapons::updatemovespeedscale();
  cleanupobjectiveiconsforjugg(self);
}

function rewardteammateproximity() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    wait 1;

    foreach(var1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var1) && !var1 scripts\mp\utility\player::isusingremote() && var1 != self && var1.team == self.team && distancesquared(var1.origin, self.origin) < 48400) {
        if(var1.hasbeenjugg) {
          var1.jugg_allegiance += 15;
          continue;
        }

        var1.jugg_allegiance += 25;
      }
    }
  }
}

function logattackers() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isPlayer(var1) && var1.team != self.team) {
      if(!isDefined(level.jugg_attackers[self.team][var1.guid])) {
        level.jugg_attackers[self.team][var1.guid] = 1;
      }
    }
  }
}

function resetjuggloadoutondisconnect(var0) {
  level endon("game_ended");

  if(var0) {
    self endon("death");
  } else {
    self endon("end_resetJuggLoadoutOnDisconnect");
  }

  var1 = self.team;
  self waittill("disconnect");
  var2 = getbestteammate(var1, 0);

  if(!isDefined(var2)) {
    var2 = getbestteammate(var1, 1);
  }

  if(isDefined(var2)) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(var2);
    return;
  }

  level.jugg_available[var1] = 1;
  level.jugg_currjugg[var1] = undefined;
  level.tjugg_timerdisplay[var1].alpha = 0;
  level.jugg_attackers[var1] = [];

  foreach(var4 in level.players) {
    if(var4.team == var1) {
      var4.jugg_allegiance = 0;
    }
  }
}

function resetjuggloadoutonchangeteam() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = self.team;
  scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  self.isjuggmodejuggernaut = undefined;
  var1 = getbestteammate(var0, 0);

  if(!isDefined(var1)) {
    var1 = getbestteammate(var0, 1);
  }

  if(isDefined(var1)) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(var1);
    return;
  }

  level.jugg_available[var0] = 1;
  level.jugg_currjugg[var0] = undefined;
  level.tjugg_timerdisplay[var0].alpha = 0;
  level.jugg_attackers[var0] = [];

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      var3.jugg_allegiance = 0;
    }
  }
}

function getbestteammate(var0, var1) {
  var2 = undefined;
  var3 = -1;

  foreach(var5 in level.players) {
    if((var1 || !var5 scripts\mp\utility\player::isusingremote()) && var5 != self && var5.team == var0 && var5.jugg_allegiance > var3) {
      var2 = var5;
      var3 = var5.jugg_allegiance;
    }
  }

  return var2;
}

function hidetimerdisplayongameend(var0) {
  level waittill("game_ended");
  var0.alpha = 0;
}

function createjuggobjectiveicon(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var0.juggobjid = var1;
  var0.offset3d = (0, 0, 90);
  var0.visibleteam = "any";
  var0.ownerteam = var0.team;
  scripts\mp\objidpoolmanager::objective_add_objective(var1, "current", var0.origin, "icon_minimap_juggernaut");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var1, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var1, var0.offset3d[2]);
  objective_setownerteam(var1, var0.team);
  objective_setfriendlylabel(var1, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  objective_setenemylabel(var1, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

function cleanupobjectiveiconsforjugg(var0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var0.juggobjid);
  var0.juggobjid = undefined;
}

function updatejuggcurorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");

  for(;;) {
    self.curorigin = self.origin + (0, 0, 90);
    waitframe();
  }
}

function updatejuggpingorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");
  thread updatejuggcurorigin();
  jumpiftrue(isDefined(self.objpingdelay)) LOC_00000028;
  self.objpingdelay = 4;

  for(;;) {
    foreach(var1 in level.teamnamelist) {
      if(!scripts\mp\gameobjects::isfriendlyteam(var1)) {
        objective_setpingsforteam(self.juggobjid, var1);
        objective_ping(self.juggobjid);
      }
    }

    scripts\engine\utility::ref_143bf(self.objpingdelay);
  }
}

function setspecialloadouts() {
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
  level.tjugg_loadouts["default"]["loadoutMeleeSlot"] = "iw8_fists_mp_ls";
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