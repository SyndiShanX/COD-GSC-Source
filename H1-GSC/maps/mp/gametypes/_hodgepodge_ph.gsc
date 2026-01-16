/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hodgepodge_ph.gsc
************************************************/

ph_init() {
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  setupdvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.onspawnplayer = ::onspawnplayer;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.checkforovertime = ::ph_checkforovertime;
  level.customplaydamagesound = ::playdamagesoundph;
  level.customplaydeathsound = ::playdeathsoundph;
  level.modifyplayerdamage = ::gamemodemodifyplayerdamage;

  if(level.madpropsmode) {
    if(!isdefined(game["roundsPlayed"]))
      game["roundsPlayed"] = 0;

    level.getspawnpoint = ::getpkspawnpoint;
  } else {
    level.getspawnpoint = ::getspawnpoint;
    level.bypassclasschoicefunc = ::phclass;
  }

  level.proplist = [];
  level.spawnproplist = [];
  level.abilities = ["FLASH"];
  level.allowlatecomers = 0;
  level.startcheck = 0;
  populateproplist();
  ph_precache();
  initializegametypesettings();
  level.ph_linker = spawn("script_model", (0, 0, 0));
  level.ph_linker setmodel("tag_player");
  onstartgametype();

  if(!level.madpropsmode) {
    level thread stillalivexp();
    level checkmapofflimits();
  }

  level thread watchhostmigration();
  level thread disablejipaftermatchstart();
}

disablejipaftermatchstart() {
  maps\mp\_utility::gameflagwait("prematch_done");
  setnojiptime(1);
}

setupdvars() {
  if(level.madpropsmode) {
    setdynamicdvar("scr_game_hardpoints", 0);
    setdynamicdvar("scr_war_timelimit", 4);
    setdynamicdvar("scr_war_scorelimit", 0);
    setdynamicdvar("scr_war_roundlimit", 4);
    setdynamicdvar("scr_war_winlimit", 3);
    setdynamicdvar("scr_war_numlives", 4);
    maps\mp\_utility::registerwinlimitdvar("war", 3);
    setdynamicdvar("scr_war_roundswitch", 1);
    maps\mp\_utility::registerroundswitchdvar("war", 1, 0, 9);
    setdynamicdvar("scr_war_halftime", 0);
  } else {
    setdynamicdvar("scr_game_hardpoints", 0);
    setdynamicdvar("scr_war_timelimit", 4);
    setdynamicdvar("scr_war_scorelimit", 0);
    setdynamicdvar("scr_war_roundlimit", 4);
    setdynamicdvar("scr_war_winlimit", 3);
    setdynamicdvar("scr_war_numlives", 1);
    maps\mp\_utility::registerwinlimitdvar("war", 3);
    setdynamicdvar("scr_war_roundswitch", 1);
    maps\mp\_utility::registerroundswitchdvar("war", 1, 0, 9);
    setdynamicdvar("scr_war_halftime", 0);
    setdynamicdvar("scr_player_healthregen", 0);
    level.roundswitch = getdvarint("scr_war_roundswitch");

    if(maps\mp\_utility::getmapname() == "mp_shipment") {
      setdynamicdvar("g_oldschool", 1);
      setdynamicdvar("scr_war_timelimit", 2.2);
    }
  }
}

watchhostmigration() {
  level endon("game_ended");

  for (;;) {
    level waittill("host_migration_begin");
    setupdvars();
    level waittill("host_migration_end");
    setupdvars();
  }
}

ph_precache() {
  foreach(var_1 in level.proplist)
  precachemodel(var_1.modelname);
}

onprecachegametype() {
  ph_precache();
}

initializegametypesettings() {
  var_0 = 29;
  var_1 = 20;
  var_2 = 2;
  var_3 = 29;
  var_4 = 6;

  if(maps\mp\_utility::getmapname() == "mp_shipment") {
    var_0 = 11;
    var_2 = 1;
  }

  level.phsettings = spawnstruct();
  level.phsettings.prophidetime = getdvarfloat("scr_ph_propHideTime", var_0);

  if(level.madpropsmode) {
    level.madpropssettings = spawnstruct();
    level.madpropssettings.madpropshidetime = getdvarfloat("scr_ph_madpropsHideTime", var_3);
    level.madpropssettings.propinvulntime = getdvarfloat("scr_ph_madpropsInvulnTime", var_4);
  } else {
    level.phsettings.propwhistletime = getdvarfloat("scr_ph_propWhistleTime", var_1);
    level.phsettings.propchangecount = getdvarint("scr_ph_propChangeCount", var_2);
  }
}

onstartgametype() {
  if([
      [level.checkforovertime]
    ]()) {
    game["status"] = "overtime";
    setdvar("ui_overtime", 1);
    setdvar("overtimeTimeLimit", 3.5);
  }

  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  } else
    level.prematchperiod = 30;

  setspecialloadouts();
  setclientnamemode("manual_change");

  if(level.madpropsmode) {
    maps\mp\_utility::setobjectivetext(game["attackers"], & "OBJECTIVES_PK_ATTACKER");
    maps\mp\_utility::setobjectivetext(game["defenders"], & "OBJECTIVES_PK_DEFENDER");
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_PK_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_PK_DEFENDER_SCORE");
    maps\mp\_utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_PK_ATTACKER_HINT");
    maps\mp\_utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_PK_DEFENDER_HINT");
  } else {
    maps\mp\_utility::setobjectivetext(game["attackers"], & "OBJECTIVES_PH_ATTACKER");
    maps\mp\_utility::setobjectivetext(game["defenders"], & "OBJECTIVES_PH_DEFENDER");
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_PH_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_PH_DEFENDER_SCORE");
    maps\mp\_utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_PH_ATTACKER_HINT");
    maps\mp\_utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_PH_DEFENDER_HINT");
  }

  if(level.madpropsmode) {
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
    maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  } else {
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  }

  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_2[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_2);
  level._effect["propFlash"] = loadfx("vfx\explosion\flashbang_h1");
  level._effect["propDeathFX"] = loadfx("vfx\explosion\prop_explosion");

  if(!level.madpropsmode) {
    level thread setuproundstarthud();
    level thread propwhistle();
    level thread propspectateing();
    level thread hidehudintermission();
  } else {
    level.propsinvuln = 1;
    level thread setupmadpropsstarthud();
  }

  level thread monitortimers();
  level thread deleteallglass();
  level thread setphteamscores();
}

setspecialloadouts() {
  if(level.madpropsmode) {
    var_0 = game["defenders"];
    level.ph_loadouts[var_0] = maps\mp\gametypes\_class::getemptyloadout();
    level.ph_loadouts[var_0]["loadoutPrimary"] = "h1_ak47";
    level.ph_loadouts[var_0]["loadoutPerks"] = ["specialty_null", "specialty_null", "specialty_quieter"];
    level.ph_loadouts[var_0]["loadoutEquipment"] = "h1_fraggrenade_mp";
    level.ph_loadouts[var_0]["loadoutOffhand"] = "h1_flashgrenade_mp";
  } else {
    var_0 = game["defenders"];
    level.ph_loadouts[var_0] = maps\mp\gametypes\_class::getemptyloadout();
    level.ph_loadouts[var_0]["loadoutPrimary"] = "h1_ak47";
    level.ph_loadouts[var_0]["loadoutPerks"] = ["specialty_null", "specialty_null", "specialty_quieter"];
    level.ph_loadouts[var_0]["loadoutEquipment"] = "h1_fraggrenade_mp";
    level.ph_loadouts[var_0]["loadoutOffhand"] = "h1_flashgrenade_mp";

    if(maps\mp\_utility::getmapname() == "mp_shipment") {
      var_1 = game["attackers"];
      level.ph_loadouts[var_1] = maps\mp\gametypes\_class::getemptyloadout();
      level.ph_loadouts[var_1]["loadoutSecondary"] = "h1_deserteagle";
      level.ph_loadouts[var_1]["loadoutPrimary"] = "h1_p90";
      level.ph_loadouts[var_1]["loadoutPerks"] = ["rpg_mp", "specialty_null", "specialty_null"];
      level.ph_loadouts[var_1]["loadoutEquipment"] = "h1_fraggrenade_mp";
      level.ph_loadouts[var_1]["loadoutOffhand"] = "h1_concussiongrenade_mp";
    } else {
      var_1 = game["attackers"];
      level.ph_loadouts[var_1] = maps\mp\gametypes\_class::getemptyloadout();
      level.ph_loadouts[var_1]["loadoutSecondary"] = "h1_deserteagle";
      level.ph_loadouts[var_1]["loadoutPrimary"] = "h1_p90";
      level.ph_loadouts[var_1]["loadoutEquipment"] = "h1_fraggrenade_mp";
      level.ph_loadouts[var_1]["loadoutOffhand"] = "h1_concussiongrenade_mp";
    }
  }
}

phclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.ph_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

getspawnpoint() {
  if(self.pers["team"] == game["attackers"])
    var_0 = "mp_sd_spawn_attacker";
  else
    var_0 = "mp_sd_spawn_defender";

  var_1 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(var_0);
  var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_1);
  return var_2;
}

getpkspawnpoint() {
  var_0 = self.pers["team"];

  if(game["roundsPlayed"] >= 2)
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(level.usestartspawns && level.ingraceperiod)
    var_1 = maps\mp\gametypes\_spawnlogic::getbeststartspawn("mp_tdm_spawn_" + var_0 + "_start");
  else {
    var_2 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_2, var_0);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

propspectateing() {
  level endon("game_ended");
  level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
  maps\mp\gametypes\_spectating::updatespectatesettings();
}

setupkeybindings() {
  if(level.madpropsmode) {
    self notifyonplayercommand("explode", "+attack");
    self notifyonplayercommand("explode", "+attack_akimbo_accessible");
    self notifyonplayercommand("zoomin", "+actionslot 3");
    self notifyonplayercommand("zoomout", "+actionslot 4");
    return;
  }

  self notifyonplayercommand("lock", "+attack");
  self notifyonplayercommand("lock", "+attack_akimbo_accessible");
  self notifyonplayercommand("spin", "+toggleads_throw");
  self notifyonplayercommand("spin", "+speed_throw");
  self notifyonplayercommand("spin", "+speed");
  self notifyonplayercommand("spin", "+ads_akimbo_accessible");
  self notifyonplayercommand("changeProp", "weapnext");
  self notifyonplayercommand("setToSlope", "+usereload");
  self notifyonplayercommand("setToSlope", "+activate");
  self notifyonplayercommand("propAbility", "+smoke");
  self notifyonplayercommand("zoomin", "+actionslot 3");
  self notifyonplayercommand("zoomout", "+actionslot 4");
  self notifyonplayercommand("spectate", "+actionslot 2");
}

propcontrolshud() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 26;
  self.propchangecounter = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  self.propchangecounter.label = & "MP_PH_CHANGESLEFT";
  self.propchangecounter setvalue(0);
  self.propchangecounter.x = -5;
  self.propchangecounter.y = var_0;
  self.propchangecounter.alignx = "right";
  self.propchangecounter.aligny = "top";
  self.propchangecounter.horzalign = "right_adjustable";
  self.propchangecounter.vertalign = "top_adjustable";
  self.propchangecounter.archived = 1;
  self.propchangecounter.fontscale = 1;
  self.propchangecounter.alpha = 1;
  self.propchangecounter.glowalpha = 0;
  self.propchangecounter.hidewheninmenu = 0;
  var_0 = var_0 + 12;
  self.changepropkey = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  self.changepropkey.label = & "MP_PH_CHANGE";
  self.changepropkey.x = -5;
  self.changepropkey.y = var_0;
  self.changepropkey.alignx = "right";
  self.changepropkey.aligny = "top";
  self.changepropkey.horzalign = "right_adjustable";
  self.changepropkey.vertalign = "top_adjustable";
  self.changepropkey.archived = 1;
  self.changepropkey.fontscale = 1;
  self.changepropkey.alpha = 1;
  self.changepropkey.glowalpha = 0;
  self.changepropkey.hidewheninmenu = 0;
  var_0 = var_0 + 12;
  self.lockpropkey = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  self.lockpropkey.label = & "MP_PH_LOCK";
  self.lockpropkey.x = -5;
  self.lockpropkey.y = var_0;
  self.lockpropkey.alignx = "right";
  self.lockpropkey.aligny = "top";
  self.lockpropkey.horzalign = "right_adjustable";
  self.lockpropkey.vertalign = "top_adjustable";
  self.lockpropkey.archived = 1;
  self.lockpropkey.fontscale = 1;
  self.lockpropkey.alpha = 1;
  self.lockpropkey.glowalpha = 0;
  self.lockpropkey.hidewheninmenu = 0;
  var_0 = var_0 + 12;
  self.matchslopekey = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);

  if(common_scripts\utility::is_player_gamepad_enabled())
    self.matchslopekey.label = & "MP_PH_SLOPE";
  else
    self.matchslopekey.label = & "MP_PH_SLOPE_PC";

  self.matchslopekey.x = -5;
  self.matchslopekey.y = var_0;
  self.matchslopekey.alignx = "right";
  self.matchslopekey.aligny = "top";
  self.matchslopekey.horzalign = "right_adjustable";
  self.matchslopekey.vertalign = "top_adjustable";
  self.matchslopekey.archived = 1;
  self.matchslopekey.fontscale = 1;
  self.matchslopekey.alpha = 1;
  self.matchslopekey.glowalpha = 0;
  self.matchslopekey.hidewheninmenu = 0;
  var_0 = var_0 + 12;
  self.abilitykey = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  setnewabilityhud();
  self.abilitykey.x = -5;
  self.abilitykey.y = var_0;
  self.abilitykey.alignx = "right";
  self.abilitykey.aligny = "top";
  self.abilitykey.horzalign = "right_adjustable";
  self.abilitykey.vertalign = "top_adjustable";
  self.abilitykey.archived = 1;
  self.abilitykey.fontscale = 1;
  self.abilitykey.alpha = 1;
  self.abilitykey.glowalpha = 0;
  self.abilitykey.hidewheninmenu = 0;
  thread updatetextongamepadchange();
}

pkcontrolshud() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 38;
  self.pkexplodekey = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  self.pkexplodekey.label = & "MP_PK_EXPLODELKEY";
  self.pkexplodekey.x = -5;
  self.pkexplodekey.y = var_0;
  self.pkexplodekey.alignx = "right";
  self.pkexplodekey.aligny = "top";
  self.pkexplodekey.horzalign = "right_adjustable";
  self.pkexplodekey.vertalign = "top_adjustable";
  self.pkexplodekey.archived = 1;
  self.pkexplodekey.fontscale = 1;
  self.pkexplodekey.alpha = 0;
  self.pkexplodekey.glowalpha = 0;
  self.pkexplodekey.hidewheninmenu = 0;
  var_0 = var_0 + 12;
  self.pklivesleft = maps\mp\gametypes\_hud_util::createfontstring("objective", 0.9);
  self.pklivesleft.label = & "MP_PK_LIVESLEFT";
  self.pklivesleft setvalue(3);
  self.pklivesleft.x = -5;
  self.pklivesleft.y = var_0;
  self.pklivesleft.alignx = "right";
  self.pklivesleft.aligny = "top";
  self.pklivesleft.horzalign = "right_adjustable";
  self.pklivesleft.vertalign = "top_adjustable";
  self.pklivesleft.archived = 1;
  self.pklivesleft.fontscale = 1;
  self.pklivesleft.alpha = 1;
  self.pklivesleft.glowalpha = 0;
  self.pklivesleft.hidewheninmenu = 0;
}

updatetextongamepadchange() {
  level endon("game_ended");
  self endon("disconnect");

  if(level.console) {
    return;
  }
  var_0 = common_scripts\utility::is_player_gamepad_enabled();

  for (;;) {
    var_1 = common_scripts\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      var_0 = var_1;

      if(var_1) {
        if(!maps\mp\_utility::is_true(self.slopelocked))
          self.matchslopekey.label = & "MP_PH_SLOPE";
        else
          self.matchslopekey.label = & "MP_PH_SLOPED";
      } else if(!maps\mp\_utility::is_true(self.slopelocked))
        self.matchslopekey.label = & "MP_PH_SLOPE_PC";
      else
        self.matchslopekey.label = & "MP_PH_SLOPED_PC";
    }

    waitframe();
  }
}

setuproundstarthud() {
  level.phcountdowntimer = maps\mp\gametypes\_hud_util::createservertimer("objective", 1.4);
  level.phcountdowntimer maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, 50);
  level.phcountdowntimer.label = & "MP_PH_STARTS_IN";
  level.phcountdowntimer.alpha = 0;
  level.phcountdowntimer.archived = 0;
  level.phcountdowntimer.hidewheninmenu = 1;
  level.phcountdowntimer.sort = 1;
  level.phwhistletimer = maps\mp\gametypes\_hud_util::createservertimer("objective", 0.9);
  level.phwhistletimer.x = -6;
  level.phwhistletimer.y = 2;
  level.phwhistletimer.alignx = "right";
  level.phwhistletimer.aligny = "top";
  level.phwhistletimer.horzalign = "right_adjustable";
  level.phwhistletimer.vertalign = "top_adjustable";
  level.phwhistletimer.label = & "MP_PH_WHISTILE_IN";
  level.phwhistletimer.alpha = 0;
  level.phwhistletimer.archived = 0;
  level.phwhistletimer.hidewheninmenu = 1;
  level.phwhistletimer settimer(120);
  level.whistling = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 1);
  level.whistling.label = & "MP_PH_WHISTLING";
  level.whistling.x = -5;
  level.whistling.y = 2;
  level.whistling.alignx = "right";
  level.whistling.aligny = "top";
  level.whistling.horzalign = "right_adjustable";
  level.whistling.vertalign = "top_adjustable";
  level.whistling.archived = 1;
  level.whistling.alpha = 0;
  level.whistling.glowalpha = 0.2;
  level.whistling.hidewheninmenu = 0;

  if(!isdefined(level.elim_hud))
    level.elim_hud = [];

  level.elim_hud = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 0.9);
  level.elim_hud.label = & "MP_PH_ALIVE";
  level.elim_hud setvalue(0);
  level.elim_hud.x = -5;
  level.elim_hud.y = 14;
  level.elim_hud.alignx = "right";
  level.elim_hud.aligny = "top";
  level.elim_hud.horzalign = "right_adjustable";
  level.elim_hud.vertalign = "top_adjustable";
  level.elim_hud.archived = 1;
  level.elim_hud.fontscale = 1.0;
  level.elim_hud.alpha = 1;
  level.elim_hud.glowalpha = 0;
  level.elim_hud.hidewheninmenu = 0;
  level thread eliminatedhudmonitor();
}

setupmadpropsstarthud() {
  if(!isdefined(level.elim_hud))
    level.elim_hud = [];

  level.elim_hud = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 0.9);
  level.elim_hud.label = & "MP_PK_ALIVE";
  level.elim_hud setvalue(0);
  level.elim_hud.x = -5;
  level.elim_hud.y = 14;
  level.elim_hud.alignx = "right";
  level.elim_hud.aligny = "top";
  level.elim_hud.horzalign = "right_adjustable";
  level.elim_hud.vertalign = "top_adjustable";
  level.elim_hud.archived = 1;
  level.elim_hud.fontscale = 1.0;
  level.elim_hud.alpha = 1;
  level.elim_hud.glowalpha = 0;
  level.elim_hud.hidewheninmenu = 0;

  if(!isdefined(level.elim_hud_humans))
    level.elim_hud_humans = [];

  level.elim_hud_humans = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 0.9);
  level.elim_hud_humans.label = & "MP_PK_HUMANSALIVE";
  level.elim_hud_humans setvalue(0);
  level.elim_hud_humans.x = -5;
  level.elim_hud_humans.y = 26;
  level.elim_hud_humans.alignx = "right";
  level.elim_hud_humans.aligny = "top";
  level.elim_hud_humans.horzalign = "right_adjustable";
  level.elim_hud_humans.vertalign = "top_adjustable";
  level.elim_hud_humans.archived = 1;
  level.elim_hud_humans.fontscale = 1.0;
  level.elim_hud_humans.alpha = 1;
  level.elim_hud_humans.glowalpha = 0;
  level.elim_hud_humans.hidewheninmenu = 0;
  level thread eliminatedhudmonitor();
  level.phcountdowntimer = maps\mp\gametypes\_hud_util::createservertimer("objective", 1.4);
  level.phcountdowntimer maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, 50);
  level.phcountdowntimer.label = & "MP_PK_STARTS_IN";
  level.phcountdowntimer.alpha = 0;
  level.phcountdowntimer.archived = 0;
  level.phcountdowntimer.hidewheninmenu = 1;
  level.phcountdowntimer.sort = 1;
  level.pkinvuln = maps\mp\gametypes\_hud_util::createservertimer("objective", 1.4);
  level.pkinvuln maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, 50);
  level.pkinvuln.label = & "MP_PK_PROPSINVULN";
  level.pkinvuln.alpha = 0;
  level.pkinvuln.archived = 0;
  level.pkinvuln.hidewheninmenu = 1;
  level.pkinvuln.sort = 1;
}

eliminatedhudmonitor() {
  level endon("game_ended");

  for (;;) {
    if(level.madpropsmode) {
      var_0 = get_alive_nonspecating_players(game["attackers"]);
      level.elim_hud_humans setvalue(var_0.size);
    }

    var_1 = get_alive_nonspecating_players(game["defenders"]);
    level.elim_hud setvalue(var_1.size);
    level common_scripts\utility::waittill_any("player_spawned", "player_killed", "player_eliminated", "playerCountChanged", "propCountChanged");
  }
}

get_alive_nonspecating_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isdefined(var_3) && isalive(var_3) && (!isdefined(var_3.sessionstate) || var_3.sessionstate == "playing")) {
      if(!isdefined(var_0) || var_3.team == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

weaponusagecheck() {
  var_0 = common_scripts\utility::waittill_any_return("weapon_fired", "end_weapon_check_usage");

  if(var_0 == "end_weapon_check_usage") {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    return 0;
  }

  return 1;
}

positioncheck() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = squared(300);
  var_2 = 0;

  for (var_3 = 0; var_3 < 30; var_3++) {
    if(!var_2) {
      var_4 = distancesquared(var_0, self.origin);

      if(var_4 >= var_1)
        var_2 = 1;
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  if(var_2)
    return 1;

  return 0;
}

startcheck() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self.doingcheck = 1;
  maps\mp\_utility::gameflagwait("prematch_done");

  while (!level.startcheck)
    wait 1;

  if(!level.madpropsmode)
    childthread weaponusagecheck();

  if(!positioncheck()) {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  if(!positioncheck()) {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);
  self notify("end_weapon_check_usage");
}

onconnect() {
  if(level.madpropsmode)
    thread watchthrownflash();

  thread attackerswaittime();
}

onspawnplayer() {
  self.breathingstoptime = 0;

  if(self.team == game["defenders"]) {
    if(level.madpropsmode) {
      self.concussionimmune = 1;
      self.flashimmune = 1;
      thread handleprop();
      thread updateprop();

      if(!isdefined(self.pkexplodekey))
        thread pkcontrolshud();

      if(!isdefined(self.doingcheck))
        thread startcheck();

      self disableoffhandweapons();
    } else {
      self.concussionimmune = 1;
      setownedtaunt();
      self.isangleoffset = 0;
      self.changesleft = int(level.phsettings.propchangecount);

      if(!isdefined(self.pers["ability"]))
        self.pers["ability"] = 0;

      self.currentability = level.abilities[self.pers["ability"]];
      self.abilitylocked = 0;
      setnewabilitycount();
      thread playerlastvalidpositionwatch();
      thread propcontrolshud();
      thread handleprop();
      thread updateprop();
    }
  } else if(level.madpropsmode) {
    self.pers["lives"] = 0;
    level.livescount[self.team] = 0;
  } else {
    if(!isdefined(self.hasthrownspecial))
      self.hasthrownspecial = 0;

    thread givecustomloadout();

    if(!isdefined(self.doingcheck))
      thread startcheck();
  }
}

playerlastvalidpositionwatch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("stop_watch_last_valid_pos");
  self.lastvalidpos = undefined;
  self.lastnodeinsight = undefined;

  for (;;) {
    var_0 = playerphysicstraceinfo(self.origin, self.origin + (0, 0, 1), self);

    if(var_0["fraction"] == 1)
      self.lastvalidpos = self.origin;

    var_1 = getclosestnodeinsight(self.origin);

    if(isdefined(var_1))
      self.lastnodeinsight = var_1;

    waitframe();
  }
}

monitortimers() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");

  if(level.madpropsmode) {
    level thread pausepktimerformigration();
    level.phcountdowntimer settimer(level.madpropssettings.madpropshidetime);
    level.phcountdowntimer.alpha = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.madpropssettings.madpropshidetime);
  } else {
    level thread pausephtimerformigration();
    level.phcountdowntimer settimer(level.phsettings.prophidetime);
    level.phcountdowntimer.alpha = 1;
    level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    level.phwhistletimer.alpha = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime);
  }

  level notify("props_hide_over");

  if(!level.madpropsmode) {
    level.phwhistletimer.alpha = 1;
    level.phcountdowntimer.alpha = 0;

    foreach(var_1 in level.players) {
      if(isdefined(var_1.abilitylocked))
        var_1.abilitylocked = 1;
    }
  } else {
    level.phcountdowntimer.alpha = 0;
    level.pkinvuln settimer(level.madpropssettings.propinvulntime);
    level.pkinvuln.alpha = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.madpropssettings.propinvulntime);
    level.pkinvuln.alpha = 0;
    level.propsinvuln = 0;

    foreach(var_1 in level.players) {
      if(var_1.team == game["defenders"] && isdefined(var_1.pkexplodekey) && maps\mp\_utility::isreallyalive(var_1)) {
        var_1.concussionimmune = 0;
        var_1.flashimmune = 0;
        var_1.pkexplodekey.alpha = 1;
      }
    }
  }
}

pausephtimerformigration() {
  level endon("game_ended");
  level endon("props_hide_over");
  var_0 = int(level.phsettings.prophidetime + gettime() / 1000);
  var_1 = 0;

  for (;;) {
    level waittill("host_migration_begin");
    level.phcountdowntimer.alpha = 0;
    level.phwhistletimer.alpha = 0;
    var_2 = int(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() / 1000);
    var_1 = var_1 + var_2;
    var_2 = var_1;
    var_3 = var_0 + var_2 - int(gettime() / 1000);
    level.phcountdowntimer settimer(var_3);
    level.phwhistletimer settimer(level.phsettings.propwhistletime + var_3);
    level.phcountdowntimer.alpha = 1;
    level.phwhistletimer.alpha = 1;
  }
}

pausepktimerformigration() {
  level endon("game_ended");
  level endon("props_hide_over");
  var_0 = int(level.madpropssettings.madpropshidetime + gettime() / 1000);
  var_1 = 0;

  for (;;) {
    level waittill("host_migration_begin");
    level.pkcountdowntimer.alpha = 0;
    var_2 = int(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() / 1000);
    var_1 = var_1 + var_2;
    var_2 = var_1;
    var_3 = var_0 + var_2 - int(gettime() / 1000);
    level.pkcountdowntimer settimer(var_3);
    level.pkcountdowntimer.alpha = 1;
  }
}

setownedtaunt() {
  var_0 = "prop_whistle_01";
  self.playtaunt = var_0;
}

handleprop() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("applyLoadout");

    if(level.madpropsmode) {
      self takeallweapons();

      if(!isdefined(self.prop))
        thread setupmadprops();

      continue;
    }

    self takeallweapons();
    self allowsprint(0);
    self allowspectateteam(game["attackers"], 1);
    self setmovespeedscale(1.5);

    if(!isdefined(self.prop))
      thread setupprop();
  }
}

setupprop() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = common_scripts\utility::random(level.proplist);
  self playerhide(1);
  self.propanchor = spawn("script_model", self.origin);
  self.propanchor linktosynchronizedparent(self);
  self.propanchor _meth_8581();
  self.propanchor setcontents(0);
  self.propent = spawn("script_model", self.origin);
  self.propent linktosynchronizedparent(self.propanchor);
  self.propent _meth_8581();
  self.propent setcontents(0);
  self.prop = spawn("script_model", self.propent.origin);
  self.prop setmodel(var_0.modelname);
  self.prop setcandamage(1);
  self.prop.xyzoffset = var_0.xyzoffset;
  self.prop.anglesoffset = var_0.anglesoffset;
  self.prop.angles = self.angles;
  applyxyzoffset();
  applyanglesoffset();
  self.prop linktosynchronizedparent(self.propent);
  self.prop _meth_8581();
  self.prop.owner = self;
  self.prop.health = 10000;
  self.prop setdamagecallbackon(1);
  self.prop.info = var_0;
  self.health = var_0.propsize;
  self.maxhealth = self.health;
  thread setupkeybindings();
  thread setupdamage();
  childthread proplockwatch();
  thread propwatchdeath();
  thread propwatchdeletedisconnect();
  thread propwatchdeleteroundend();
  self notify("propSetup");
}

setupmadprops() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = common_scripts\utility::random(level.proplist);
  self playerhide(1);
  self.propanchor = spawn("script_model", self.origin);
  self.propanchor linktosynchronizedparent(self);
  self.propanchor _meth_8581();
  self.propanchor setcontents(0);
  self.propent = spawn("script_model", self.origin);
  self.propent linktosynchronizedparent(self.propanchor);
  self.propent _meth_8581();
  self.propent setcontents(0);
  self.prop = spawn("script_model", self.propent.origin);
  self.prop setmodel(var_0.modelname);
  self.prop setcandamage(1);
  self.prop.xyzoffset = var_0.xyzoffset;
  self.prop.anglesoffset = var_0.anglesoffset;
  self.prop.angles = self.angles;
  applyxyzoffset();
  applyanglesoffset();
  self.prop linktosynchronizedparent(self.propent);
  self.prop _meth_8581();
  self.prop.owner = self;
  self.prop.health = 10000;
  self.prop setdamagecallbackon(1);
  self.prop.info = var_0;
  self.health = var_0.propsize;
  self.maxhealth = self.health;
  thread setupkeybindings();
  thread setupdamage();
  childthread madpropswatch();
  thread propwatchdeath();
  thread propwatchdeletedisconnect();
  thread propwatchdeleteroundend();
  self notify("propSetup");
}

applyxyzoffset() {
  if(!isdefined(self.prop.xyzoffset)) {
    return;
  }
  self.prop.angles = self.angles;
  var_0 = anglestoforward(self.prop.angles) * self.prop.xyzoffset[0];
  var_1 = anglestoright(self.prop.angles) * self.prop.xyzoffset[1];
  var_2 = anglestoup(self.prop.angles) * self.prop.xyzoffset[2];
  self.prop.origin = self.prop.origin + var_0;
  self.prop.origin = self.prop.origin + var_1;
  self.prop.origin = self.prop.origin + var_2;
}

applyanglesoffset() {
  if(!isdefined(self.prop.anglesoffset)) {
    return;
  }
  self.prop.angles = self.angles;
  self.prop.angles = self.prop.angles + self.prop.anglesoffset;
  self.isangleoffset = 1;
}

propwhistle() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  var_0 = gettime();
  var_1 = level.phsettings.propwhistletime * 1000;
  var_2 = var_1;
  var_3 = 5000;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime + level.phsettings.propwhistletime);

  for (;;) {
    if(var_0 + var_1 < gettime()) {
      foreach(var_5 in level.players) {
        if(!isdefined(var_5)) {
          continue;
        }
        level.phwhistletimer.alpha = 0;
        level.whistling.alpha = 0.6;

        if(var_5.team == game["defenders"] && isalive(var_5)) {
          level.whistling.alpha = 1;
          level.whistling fadeovertime(0.75);
          level.whistling.alpha = 0.6;
          playsoundatpos(var_5.origin, var_5.playtaunt);
          maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
        }
      }

      var_0 = gettime();

      if(var_2 >= maps\mp\gametypes\_gamelogic::gettimeremaining() - var_3) {
        level.whistling.alpha = 0;
        return;
      } else {
        if(var_2 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= maps\mp\gametypes\_gamelogic::gettimeremaining() - var_3) {
          level.phwhistletimer.label = & "MP_PH_FINAL_WHISTLE";
          var_2 = var_2 + getteamplayersalive(game["defenders"]) * 2500;
        }

        level.phwhistletimer settimer(int(var_1 / 1000));
        level.whistling.alpha = 0;
        level.phwhistletimer.alpha = 1;
      }
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  }
}

getlivingplayersonteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isdefined(var_3.team)) {
      continue;
    }
    if(maps\mp\_utility::isreallyalive(var_3) && maps\mp\_utility::isteamparticipant(var_3) && var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

createpropspeclist() {
  self.spectatableprops = getlivingplayersonteam(game["defenders"]);
}

proplockwatch() {
  if(isbot(self)) {
    return;
  }
  self.lock = 0;
  self.slopelocked = 0;
  var_0 = level.proplist;
  self.propchangecounter setvalue(self.changesleft);
  maps\mp\_utility::gameflagwait("prematch_done");
  childthread propmoveunlock();
  childthread propcamerazoom();
  childthread propspectate();
  var_1 = 1;

  for (;;) {
    var_2 = common_scripts\utility::waittill_any_return("lock", "spin", "changeProp", "setToSlope", "propAbility");

    if(!isdefined(var_2)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    if(self.endingpropspecate) {
      continue;
    }
    if(var_2 == "lock") {
      if(self ismantling()) {
        continue;
      }
      if(self.lock)
        unlockprop();
      else
        lockprop();

      continue;
    }

    if(var_2 == "spin") {
      self.propent unlink();
      self.propent.angles = self.propent.angles + (0, 45, 0);
      self.propent.origin = self.propanchor.origin;

      if(self.slopelocked && maps\mp\_utility::is_true(self.lock))
        self.propent set_pitch_roll_for_ground_normal(self.prop);

      self.propent linktosynchronizedparent(self.propanchor);
      continue;
    }

    if(var_2 == "changeProp") {
      if(var_0.size == 1)
        var_0 = level.proplist;

      if(self.changesleft > 0) {
        self notify("changed_prop");
        var_0 = common_scripts\utility::array_remove(var_0, self.prop.info);
        self.prop.info = common_scripts\utility::random(var_0);
        self.prop setmodel(self.prop.info.modelname);
        self.prop.xyzoffset = self.prop.info.xyzoffset;
        self.prop.anglesoffset = self.prop.info.anglesoffset;
        self.prop unlink();
        self.propent unlink();
        self.propent.origin = self.propanchor.origin;
        self.prop.origin = self.propent.origin;
        self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
        self.prop.angles = self.propent.angles;

        if(maps\mp\_utility::is_true(self.isangleoffset)) {
          self.prop.angles = self.angles;
          self.isangleoffset = 0;
        }

        applyxyzoffset();
        applyanglesoffset();
        self.prop linktosynchronizedparent(self.propent);

        if(self.slopelocked && maps\mp\_utility::is_true(self.lock))
          self.propent set_pitch_roll_for_ground_normal(self.prop);

        self.propent linktosynchronizedparent(self.propanchor);
        var_3 = self.health / self.maxhealth;
        self.maxhealth = int(self.prop.info.propsize);
        self.health = int(self.prop.info.propsize * var_3);
        setnewabilitycount();
        self.abilitykey.alpha = 1;
        self.changesleft--;
        self.propchangecounter setvalue(self.changesleft);

        if(self.changesleft <= 0)
          self.changepropkey.alpha = 0;
      }

      continue;
    }

    if(var_2 == "setToSlope") {
      if(!maps\mp\_utility::is_true(self.slopelocked)) {
        self.slopelocked = 1;

        if(maps\mp\_utility::is_true(self.lock)) {
          self.propent unlink();
          self.propent set_pitch_roll_for_ground_normal(self.prop);
          self.propent linkto(self.propanchor);
        }

        if(common_scripts\utility::is_player_gamepad_enabled())
          self.matchslopekey.label = & "MP_PH_SLOPED";
        else
          self.matchslopekey.label = & "MP_PH_SLOPED_PC";
      } else {
        self.slopelocked = 0;

        if(maps\mp\_utility::is_true(self.lock)) {
          self.propent unlink();
          self.propent.angles = (self.angles[0], self.prop.angles[1], self.angles[2]);
          self.propent.origin = self.propanchor.origin;
          self.propent linktosynchronizedparent(self.propanchor);
        }

        if(common_scripts\utility::is_player_gamepad_enabled())
          self.matchslopekey.label = & "MP_PH_SLOPE";
        else
          self.matchslopekey.label = & "MP_PH_SLOPE_PC";
      }

      continue;
    }

    if(var_2 == "propAbility") {
      if(!self.abilitylocked)
        self.abilitylocked = 1;

      if(self.abilityleft > 0) {
        thread useability();

        if(self.abilityleft <= 0)
          self.abilitykey.alpha = 0;
      }
    }
  }
}

madpropswatch() {
  self endon("death");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  maps\mp\_utility::gameflagwait("prematch_done");
  childthread propcamerazoom();

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return("explode");

    if(!isdefined(var_0)) {
      continue;
    }
    if(level.propsinvuln) {
      continue;
    }
    self playsound("prop_whistle_01");
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);

    if(var_0 == "explode") {
      magicgrenademanual("h1_fraggrenade_mp", self.origin + (0, 0, 5), (0, 0, 0), 0, self, 1);
      self suicide();
    }
  }
}

set_pitch_roll_for_ground_normal(var_0) {
  if(!isdefined(var_0))
    var_1 = self;
  else
    var_1 = var_0;

  var_2 = bullettrace(self.origin + (0, 0, 4), self.origin + (0, 0, -16), 0, var_1, 1, 0, 0, 0, 0, 0, 0);

  if(var_2["fraction"] >= 1) {
    return;
  }
  var_3 = var_2["normal"];
  var_4 = anglestoforward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = vectortoangles(var_3);
  var_7 = angleclamp180(var_6[0] + 90);
  var_6 = (0, var_6[1], 0);
  var_8 = anglestoforward(var_6);
  var_9 = vectordot(var_8, var_5);

  if(var_9 < 0)
    var_9 = -1;
  else
    var_9 = 1;

  var_10 = vectordot(var_8, var_4);
  var_11 = var_10 * var_7;
  var_12 = (1 - abs(var_10)) * var_7 * var_9;
  self.angles = (var_11, self.angles[1], var_12);
}

propmoveunlock() {
  for (;;) {
    waitframe();
    var_0 = self getnormalizedmovement();

    if(!isdefined(var_0)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    if(self.lock && (var_0[0] != 0 || var_0[1] != 0))
      unlockprop();
  }
}

allowmove(var_0) {
  if(var_0)
    self playerlinkto(level.ph_linker, "tag_player");
  else
    self unlink();
}

unlockprop() {
  self unlink();

  if(self.slopelocked) {
    self.propent unlink();
    self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
    self.propent.origin = self.propanchor.origin;
    self.propent linktosynchronizedparent(self.propanchor);
  }

  self.propanchor linktosynchronizedparent(self);
  self.lock = 0;
  self.lockpropkey.label = & "MP_PH_LOCK";
}

lockprop() {
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self playerlinkto(self.propanchor);

  if(self.slopelocked) {
    self.propent unlink();
    self.propent set_pitch_roll_for_ground_normal(self.prop);
    self.propent linktosynchronizedparent(self.propanchor);
  }

  self.lock = 1;
  self.lockpropkey.label = & "MP_PH_LOCKED";
  self notify("locked");
}

propspectate() {
  level endon("noPropsToSpectate");
  self.propspectating = 0;
  self.endingpropspecate = 0;

  if(!isdefined(self.spectatenumber))
    self.spectatenumber = 0;

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return("spectate");

    if(self.endingpropspecate) {
      continue;
    }
    if(var_0 == "spectate") {
      if(self.propspectating) {
        self notify("endPropSpectate");
        continue;
      }

      createpropspeclist();

      if(self.spectatableprops.size <= 1) {
        continue;
      }
      self.propspectating = 1;
      propabilitykeysvisible(0);
      thread propspectateendwatch();
      childthread propspectatekeys();
    }
  }
}

propspectatekeys() {
  self endon("endPropSpectate");

  if(checkifvalidpropspectate())
    spectateprop();
  else {
    findvalidspectateprop(1);
    spectateprop();
  }

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return("zoomin", "zoomout");

    if(self.endingpropspecate) {
      continue;
    }
    if(var_0 == "zoomin") {
      findvalidspectateprop(1);
      checkifvalidpropspectate();
      movetonewprop();
    }

    if(var_0 == "zoomout") {
      findvalidspectateprop(0);
      checkifvalidpropspectate();
      movetonewprop();
    }
  }
}

checkifvalidpropspectate() {
  var_0 = self.spectatableprops[self.spectatenumber];

  if(!isdefined(var_0))
    return 0;

  if(var_0 == self)
    return 0;

  if(maps\mp\_utility::isreallyalive(var_0))
    return 1;

  return 0;
}

findvalidspectateprop(var_0) {
  var_1 = self.spectatenumber;

  for (;;) {
    if(maps\mp\_utility::is_true(var_0))
      self.spectatenumber++;
    else
      self.spectatenumber--;

    if(var_0 && self.spectatableprops.size <= self.spectatenumber)
      self.spectatenumber = 0;
    else if(self.spectatenumber < 0)
      self.spectatenumber = self.spectatableprops.size - 1;

    if(self.spectatenumber == var_1) {
      break;
    }

    if(checkifvalidpropspectate()) {
      break;
    }
  }
}

propspectateendwatch() {
  self endon("disconnect");
  self endon("death");
  createpropspecatehud();
  common_scripts\utility::waittill_any_ents(self, "endPropSpectate", level, "noPropsToSpectate");

  if(maps\mp\_utility::is_true(self.endingpropspecate)) {
    return;
  }
  self.endingpropspecate = 1;
  destroypropspecatehud();
  returntoprop();
  waittillframeend;
  propabilitykeysvisible(1);
  self.propspectating = 0;
  self.endingpropspecate = 0;
}

createpropspecatehud() {
  self.spectatecommands = maps\mp\gametypes\_hud_util::createfontstring("objective", 1);
  self.spectatecommands.label = & "MP_PH_SPECCOMMANDS";
  self.spectatecommands.x = 20;
  self.spectatecommands.y = -80;
  self.spectatecommands.alignx = "center";
  self.spectatecommands.aligny = "middle";
  self.spectatecommands.horzalign = "center_adjustable";
  self.spectatecommands.vertalign = "bottom_adjustable";
  self.spectatecommands.archived = 1;
  self.spectatecommands.fontscale = 1;
  self.spectatecommands.alpha = 1;
  self.spectatecommands.glowalpha = 0.5;
  self.spectatecommands.hidewheninmenu = 0;
}

destroypropspecatehud() {
  if(isdefined(self.spectatecommands))
    self.spectatecommands destroy();
}

spectateprop() {
  var_0 = self.spectatableprops[self.spectatenumber];
  self.spectatingthisplayer = var_0;
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self setorigin(var_0.origin);
  self.angles = var_0.angles;
  self playerlinkto(var_0.propanchor);
}

movetonewprop() {
  var_0 = self.spectatableprops[self.spectatenumber];
  self unlink();
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self playerlinkto(var_0.propanchor);
}

returntoprop() {
  self unlink();
  self setorigin(self.propanchor.origin);

  if(self.lock)
    self playerlinkto(self.propanchor);
  else {
    self.propanchor linktosynchronizedparent(self);
    self.propanchor.origin = self.origin;
  }
}

nospectatablepropswatch() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");

  if(isdefined(self.spectatekey))
    self.spectatekey destroy();
}

propcamerazoom() {
  self.thirdpersonrange = 120;
  self.actualthirdpersonrange = 120;

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return("zoomin", "zoomout");

    if(maps\mp\_utility::is_true(self.endingpropspecate)) {
      continue;
    }
    if(!isdefined(var_0)) {
      continue;
    }
    if(maps\mp\_utility::is_true(self.propspectating)) {
      continue;
    }
    if(var_0 == "zoomin") {
      if(self.thirdpersonrange <= 60) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange - 15;
      self setclientthirdperson(1, self.thirdpersonrange);
      continue;
    }

    if(var_0 == "zoomout") {
      if(self.thirdpersonrange >= 240) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange + 15;
      self setclientthirdperson(1, self.thirdpersonrange);
    }
  }
}

setnewabilityhud() {
  switch (self.currentability) {
    case "FLASH":
      self.abilitykey.label = & "MP_PH_FLASH";
      break;
    default:
      break;
  }
}

setnewabilitycount() {
  self.abilityleft = 1;
}

useability() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.abilityleft > 0) {
    switch (self.currentability) {
      case "FLASH":
        flashenemies();
        self.abilityleft--;
        break;
      default:
        break;
    }
  }
}

flashtheprops(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  thread maps\mp\gametypes\_shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_1);

  if(!isdefined(var_0)) {
    return;
  }
  flashenemies(var_0, var_1);
}

watchthrownflash() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isdefined(var_0) && isdefined(var_1) && var_1 == "h1_flashgrenade_mp")
      var_0 thread flashtheprops(self);
  }
}

flashenemies(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = self;

  if(!isdefined(var_1))
    var_1 = self.origin;

  if(!level.madpropsmode) {
    playfx(common_scripts\utility::getfx("propFlash"), var_1 + (0, 0, 4));
    playsoundatpos(var_1, "prop_flashbang");
  }

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }
    if(maps\mp\_utility::is_true(var_3.flashimmune)) {
      continue;
    }
    if(level.madpropsmode) {
      if(!isdefined(var_3) || !isalive(var_3) || !isdefined(var_3.team) || var_3.team != game["defenders"])
        continue;
    } else if(!isdefined(var_3) || !isalive(var_3) || !isdefined(var_3.team) || var_3.team != game["attackers"]) {
      continue;
    }
    var_4 = var_1 + (0, 0, 4) - var_3 geteye();
    var_5 = length(var_4);
    var_6 = 500.0;
    var_7 = 150.0;

    if(var_5 <= var_6) {
      if(var_5 <= var_7)
        var_8 = 1;
      else
        var_8 = 1 - (var_5 - var_7) / (var_6 - var_7);

      var_9 = vectornormalize(var_4);
      var_10 = anglestoforward(var_3 getplayerangles());
      var_11 = vectordot(var_10, var_9);
      var_3 notify("flashbang", var_1 + (0, 0, 4), var_8, var_11, var_0);
      var_0 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard", var_0);
    }
  }
}

setupdamage() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self.prop.damagecallback = ::damagewatch;
}

damagewatch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isdefined(var_1)) {
    return;
  }
  if(!isdefined(self.owner)) {
    return;
  }
  if(isplayer(var_1)) {
    if(var_1.pers["team"] == self.owner.pers["team"]) {
      return;
    }
    var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard", self);
  }

  self.owner dodamage(var_2, var_6, var_1, var_0, var_4, var_5, var_8);
}

propcleanup() {
  if(isdefined(self.prop))
    self.prop delete();

  if(isdefined(self.propanchor))
    self.propanchor delete();

  if(isdefined(self.propent))
    self.propent delete();
}

propwatchdeath() {
  level endon("game_ended");
  self endon("disconnect");
  self.deathnoise = "prop_death";
  self.propdeathfx = "propDeathFX";
  self waittill("death");
  var_0 = self.body;
  playsoundatpos(self.prop.origin + (0, 0, 4), self.deathnoise);
  playfx(common_scripts\utility::getfx(self.propdeathfx), self.prop.origin + (0, 0, 4));

  if(isdefined(var_0))
    var_0 delete();

  propcleanup();
  self setclientthirdperson(0, 0);
}

propwatchdeletedisconnect() {
  self endon("death");
  level endon("round_end_finished");
  self waittill("disconnect");

  foreach(var_1 in level.players) {
    if(maps\mp\_utility::is_true(var_1.propspectating) && isdefined(var_1.spectatingthisplayer) && self == var_1.spectatingthisplayer)
      var_1 notify("endPropSpectate");
  }

  propcleanup();
}

propwatchdeleteroundend() {
  self endon("death");
  self endon("disconnect");
  level waittill("round_end_finished");
  propcleanup();
}

deleteallglass() {
  level endon("game_ended");
  level waittill("prematch_over");
  var_0 = getglasspieces();

  for (var_1 = 0; var_1 < var_0; var_1++)
    deleteglass(var_1);
}

checkmapofflimits() {
  if(maps\mp\_utility::getmapname() == "mp_citystreets")
    level thread districtrestrictedarea();
}

districtrestrictedarea() {
  level endon("game_ended");
  var_0 = spawn("trigger_radius", (5648, 68, -1176), 0, 150, 900);

  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isplayer(var_1)) {
      continue;
    }
    if(!isalive(var_1)) {
      continue;
    }
    if(maps\mp\_utility::is_true(var_1.propspectating)) {
      var_1 notify("endPropSpectate");
      continue;
    }

    var_1 suicide();
  }
}

populateproplist() {
  if(level.madpropsmode) {
    addproptolist("com_cardboardbox06", 100, 0, undefined, undefined);
    addproptolist("me_banana_box1", 100, 0, undefined, undefined);
    addproptolist("fs_h1_mwr_com_tv1_cinematic", 100, 0, undefined, undefined);
    addproptolist("com_computer_case", 100, 0, undefined, undefined);
    addproptolist("com_trashbag2_white", 100, 0, undefined, undefined);
    addproptolist("com_trashbag", 100, 0, undefined, undefined);
    addproptolist("com_propane_tank", 100, 0, undefined, undefined);
    return;
  }

  var_0 = maps\mp\_utility::getmapname();
  var_1 = "mp\ph_props_" + var_0 + ".csv";
  var_2 = tablegetrowcount(var_1);

  for (var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow(var_1, var_3, 0);
    var_5 = tablelookupbyrow(var_1, var_3, 1);
    var_6 = tablelookupbyrow(var_1, var_3, 2);
    var_7 = int(tablelookupbyrow(var_1, var_3, 3));
    var_8 = int(tablelookupbyrow(var_1, var_3, 4));
    var_9 = int(tablelookupbyrow(var_1, var_3, 5));
    var_10 = int(tablelookupbyrow(var_1, var_3, 6));
    var_11 = int(tablelookupbyrow(var_1, var_3, 7));
    var_12 = int(tablelookupbyrow(var_1, var_3, 8));
    var_13 = undefined;

    if(isdefined(var_7) && isdefined(var_8) && isdefined(var_9))
      var_13 = (var_7, var_8, var_9);

    var_14 = undefined;

    if(isdefined(var_10) && isdefined(var_11) && isdefined(var_12))
      var_14 = (var_10, var_11, var_12);

    var_15 = 0;

    switch (var_5) {
      case "xsmall":
        var_15 = 50;
        break;
      case "small":
        var_15 = 100;
        break;
      case "medium":
        var_15 = 200;
        break;
      case "large":
        var_15 = 350;
        break;
      default:
        var_15 = 100;
        break;
    }

    addproptolist(var_4, var_15, var_6, var_13, var_14);
  }
}

addproptolist(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.modelname = var_0;
  var_5.propsize = int(var_1);
  var_5.packid = var_2;

  if(isdefined(var_3))
    var_5.xyzoffset = var_3;

  if(isdefined(var_4))
    var_5.anglesoffset = var_4;

  if(!isdefined(level.proplist))
    level.proplist = [];

  level.proplist[level.proplist.size] = var_5;
}

ph_endgame(var_0, var_1) {
  if(maps\mp\_utility::is_true(level.endingph)) {
    return;
  }
  level.endingph = 1;
  level.finalkillcam_winner = var_0;
  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
  level thread givephteamscore(var_0);
}

givephteamscore(var_0) {
  level endon("game_ended");
  var_1 = game["roundsWon"][var_0] + 1;
  setteamscore(var_0, var_1);
}

setphteamscores() {
  level endon("game_ended");
  var_0 = game["roundsWon"][game["defenders"]];
  var_1 = game["roundsWon"][game["attackers"]];
  setteamscore(game["defenders"], var_0);
  setteamscore(game["attackers"], var_1);
}

ononeleftevent(var_0) {
  if(maps\mp\_utility::is_true(level.gameended)) {
    return;
  }
  if(var_0 == game["attackers"]) {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isdefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_3) && !var_3 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    if(isdefined(var_1)) {
      return;
    }
    var_1 = var_3;
  }

  if(!isdefined(var_1)) {
    return;
  }
  var_1 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);

  if(self.team == game["defenders"]) {
    level notify("noPropsToSpectate");
    level.nopropsspectate = 1;
  }

  level notify("last_alive", self);
}

ontimelimit() {
  if(level.madpropsmode) {
    ph_endgame(game["attackers"], game["end_reason"]["time_limit_reached"]);
    return;
  }

  var_0 = [];
  var_1 = undefined;
  var_2 = undefined;

  if(!maps\mp\_utility::is_true(level.gameending)) {
    foreach(var_4 in level.players) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4.team == game["defenders"]) {
        var_0[var_0.size] = var_4;
        continue;
      }

      if(!isdefined(var_1))
        var_1 = var_4;
    }

    if(var_0.size > 0)
      var_2 = common_scripts\utility::random(var_0);

    if(isdefined(var_1) && isdefined(var_2)) {
      if(maps\mp\_utility::isgameparticipant(var_2))
        var_6 = var_2 getentitynumber();
      else
        var_6 = -1;

      var_1.deathtime = gettime() - 1000;
      maps\mp\gametypes\_damage::recordfinalkillcam(5.0, var_1, var_2, var_6, -1, 0, "none", 0, 0, 0, 0, 0, "none", "normal", 0);
    }

    ph_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  }
}

ph_checkforovertime() {
  if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
    return 1;

  return 0;
}

givecustomloadout() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("applyLoadout");
    self setclientthirdperson(0, 0);
    self allowprone(1);
    self allowcrouch(1);

    if(!maps\mp\_utility::is_true(self.hasthrownspecial))
      thread watchspecialgrenadethrow();

    thread attackerregenammo();
    thread playertakegrenades();
  }
}

playertakegrenades() {
  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0) {
    if(var_2 == "h1_concussiongrenade_mp") {
      if(!maps\mp\_utility::is_true(self.hasthrownspecial))
        continue;
    }

    self setweaponammoclip(var_2, 0);
  }
}

stillalivexp() {
  level endon("game_ended");
  level.xpeventinfo["kill"]["value"] = 300;
  level waittill("props_hide_over");

  for (;;) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(10);

    foreach(var_1 in level.players) {
      if(var_1.team == game["attackers"]) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_1)) {
        continue;
      }
      level thread maps\mp\gametypes\_rank::awardgameevent("still_alive", var_1);
    }
  }
}

updateprop() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("spawned_player");

    if(!isdefined(self.thirdpersonrange))
      self.thirdpersonrange = 120;

    self setclientthirdperson(1, self.thirdpersonrange);
    self allowprone(0);
    self allowcrouch(1);
    self _meth_8583();
    self disableweaponpickup();

    if(!level.madpropsmode)
      self allowsprint(0);
  }
}

gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(maps\mp\_utility::is_true(self.propspectating)) {
    self notify("endPropSpectate");

    if(var_3 == "MOD_TRIGGER_HURT")
      return 0;
  }

  if(maps\mp\_utility::is_true(level.propsinvuln) && isdefined(var_0.team) && var_0.team == game["defenders"])
    return 0;

  if(isdefined(var_1) && isplayer(var_1) && isalive(var_1)) {
    if(level.matchrules_damagemultiplier)
      var_2 = var_2 * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism)
      var_1.health = int(min(float(var_1.maxhealth), float(var_1.health + 20)));
  }

  if(self.team == game["defenders"] && isdefined(var_3) && var_3 == "MOD_FALLING")
    var_2 = 0;

  return var_2;
}

attackerswaittime() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(self.team == game["defenders"] && !level.madpropsmode) {
    return;
  }
  if(self.team == game["attackers"] && level.madpropsmode) {
    return;
  }
  maps\mp\_utility::gameflagwait("prematch_done");

  while (!isdefined(level.starttime))
    wait 0.05;

  while (isdefined(self.controlsfrozen) && self.controlsfrozen)
    wait 0.05;

  if(level.madpropsmode)
    var_0 = level.madpropssettings.madpropshidetime - (gettime() - level.starttime) / 1000.0;
  else
    var_0 = level.phsettings.prophidetime - (gettime() - level.starttime) / 1000.0;

  if(var_0 > 0) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self.phfrozen = 1;
    thread fadetoblackforxsec(var_0);
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }

  self.phfrozen = undefined;
  level.startcheck = 1;
  maps\mp\_utility::freezecontrolswrapper(0);
}

fadetoblackforxsec(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isdefined(var_0))
    var_0 = 5;

  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(var_2))
    var_2 = 1;

  var_3 = newclienthudelem(self);
  var_3.foreground = 0;
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("black", 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 0;
  waitframe();
  var_3 fadeovertime(var_1);
  var_3.alpha = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_2);
  var_3 fadeovertime(var_2);
  var_3.alpha = 0;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  waitframe();

  if(isdefined(var_3))
    var_3 destroy();
}

watchspecialgrenadethrow() {
  self endon("death");
  self endon("disconnect");
  self notifyonplayercommand("specialGrenade", "+smoke");
  self waittill("specialGrenade");
  self.hasthrownspecial = 1;
}

attackerregenammo() {
  self endon("death");
  self endon("disconnect");
  self notify("attackerRegenAmmo");
  self endon("attackerRegenAmmo");
  level endon("game_ended");
  var_0 = 0.15;
  self.ammoregen = 1;

  for (;;) {
    if(isalive(self)) {
      var_1 = self getcurrentprimaryweapon();

      if(var_1 != "none") {
        var_2 = self getweaponammostock(var_1);
        self setweaponammostock(var_1, var_2 + 1);
      }

      if(self.health < 100 && self.health > 0)
        self.health = 100;
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

hidehudintermission() {
  level waittill("game_ended");
  level.elim_hud.alpha = 0;
  level.phwhistletimer.alpha = 0;
  level.whistling.alpha = 0;

  foreach(var_1 in level.players)
  var_1 propabilitykeysvisible(0);
}

propabilitykeysvisible(var_0) {
  if(maps\mp\_utility::is_true(var_0))
    var_1 = 1;
  else
    var_1 = 0;

  if(isdefined(self.propchangecounter))
    self.propchangecounter.alpha = var_1;

  if(isdefined(self.changepropkey))
    self.changepropkey.alpha = var_1;

  if(isdefined(self.lockpropkey))
    self.lockpropkey.alpha = var_1;

  if(isdefined(self.matchslopekey))
    self.matchslopekey.alpha = var_1;

  if(isdefined(self.abilitykey))
    self.abilitykey.alpha = var_1;
}

checkkillrespawn() {
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.1);

  if(self.pers["lives"] == 1) {
    self.pers["lives"]--;
    level.livescount[self.team]--;

    if(isdefined(self.pklivesleft))
      self.pklivesleft setvalue(0);

    maps\mp\gametypes\_gamelogic::updategameevents();
    level notify("propCountChanged");
    return;
  }

  if(isdefined(self.pklivesleft))
    self.pklivesleft setvalue(self.pers["lives"] - 1);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = 0;
  level notify("playerCountChanged");

  if(level.madpropsmode) {
    if(var_10.team == game["attackers"] && var_1.team == game["defenders"]) {
      if(var_1.pers["lives"] == 1) {
        var_1.pers["lives"]++;
        level.livescount[var_1.team]++;
      }
    } else if(var_10.team == game["defenders"])
      var_10 thread checkkillrespawn();

    return;
  }

  if(var_10.team == game["attackers"])
    thread respawnattacker();
  else
    thread maps\mp\gametypes\_deathicons::adddeathicon(var_10.body, var_10, var_10.team, 5.0, var_1, 0);

  if(isdefined(var_1) && isplayer(var_1) && var_1 != var_10 && var_10.team != var_1.team)
    var_11 = 1;

  if(var_11)
    var_1 thread maps\mp\gametypes\_hud_message::splashnotify("prop_finalblow");

  foreach(var_13 in level.players) {
    if(maps\mp\_utility::is_true(var_13.propspectating) && isdefined(var_13.spectatingthisplayer) && var_10 == var_13.spectatingthisplayer)
      var_13 notify("endPropSpectate");

    if(var_13 != var_1 && var_13.team == game["defenders"] && isalive(var_13) && var_10.team == game["defenders"]) {
      var_13 thread maps\mp\gametypes\_hud_message::splashnotify("prop_survived");
      continue;
    }

    if(var_13 != var_1 && var_13.team == game["attackers"] && var_10.team == game["defenders"])
      var_13 thread maps\mp\gametypes\_hud_message::splashnotify("prop_killed");
  }
}

respawnattacker() {
  maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread waitillcanspawnclient();
}

waitillcanspawnclient() {
  self endon("started_spawnPlayer");
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    wait 0.05;

    if(isdefined(self) && (self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))) {
      self.pers["lives"] = 1;
      maps\mp\gametypes\_playerlogic::spawnclient();
      continue;
    }

    return;
  }
}

ondeadevent(var_0) {
  if(var_0 == game["attackers"]) {
    if(level.madpropsmode)
      thread ph_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else
    level thread propkilledend();
}

propkilledend() {
  if(maps\mp\_utility::is_true(level.hunterswonending)) {
    return;
  }
  if(maps\mp\_utility::is_true(level.gameending)) {
    return;
  }
  level.hunterswonending = 1;
  level.gameending = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
  thread ph_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

playdamagesoundph(var_0) {
  if(self.team == game["defenders"]) {
    return;
  }
  if(isdefined(self.damage_sound_time) && self.damage_sound_time + 5000 > var_0) {
    return;
  }
  self.damage_sound_time = var_0;
  var_1 = randomintrange(1, 8);

  if(self.team == "axis") {
    if(self hasfemalecustomizationmodel())
      self playsound("generic_pain_enemy_fm_" + var_1);
    else
      self playsound("generic_pain_enemy_" + var_1);
  } else if(self hasfemalecustomizationmodel())
    self playsound("generic_pain_friendly_fm_" + var_1);
  else
    self playsound("generic_pain_friendly_" + var_1);
}

playdeathsoundph() {
  var_0 = randomintrange(1, 8);

  if(self.team == game["attackers"]) {
    if(self hasfemalecustomizationmodel())
      self playsound("generic_death_enemy_fm_" + var_0);
    else
      self playsound("generic_death_enemy_" + var_0);
  }
}