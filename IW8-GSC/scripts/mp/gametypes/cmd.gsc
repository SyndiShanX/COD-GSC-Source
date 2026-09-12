/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cmd.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, "cop");
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_cmd_cmdRules", getmatchrulesdata("cmdData", "cmdRules"));
  setdynamicdvar("scr_cmd_activationDelayCenter", getmatchrulesdata("cmdData", "activationDelayCenter"));
  setdynamicdvar("scr_cmd_activationDelayHalf", getmatchrulesdata("cmdData", "activationDelayHalf"));
  setdynamicdvar("scr_cmd_activationDelayBase", getmatchrulesdata("cmdData", "activationDelayBase"));
  setdynamicdvar("scr_cmd_captureDurationCenter", getmatchrulesdata("cmdData", "captureDurationCenter"));
  setdynamicdvar("scr_cmd_captureDurationHalf", getmatchrulesdata("cmdData", "captureDurationHalf"));
  setdynamicdvar("scr_cmd_captureDurationBase", getmatchrulesdata("cmdData", "captureDurationBase"));
  setdynamicdvar("scr_cmd_holdDurationCenter", getmatchrulesdata("cmdData", "holdDurationCenter"));
  setdynamicdvar("scr_cmd_holdDurationHalf", getmatchrulesdata("cmdData", "holdDurationHalf"));
  setdynamicdvar("scr_cmd_holdDurationBase", getmatchrulesdata("cmdData", "holdDurationBase"));
  setdynamicdvar("scr_cmd_juggSpawnBehavior", getmatchrulesdata("cmdData", "juggSpawnBehavior"));
  setdynamicdvar("scr_cmd_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_cmd_flagNeutralization", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("scr_cmd_captureCondition", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("scr_dom_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dom", 0);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.cmdrules = scripts\mp\utility\dvars::dvarintvalue("cmdRules", 1, 1, 3);
  level.tieractivationdelay = [];
  level.tieractivationdelay[0] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayCenter", 15, 0, 60);
  level.tieractivationdelay[1] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayHalf", 15, 0, 60);
  level.tieractivationdelay[2] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayBase", 15, 0, 60);
  level.tiercapturetime = [];
  level.tiercapturetime[0] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationCenter", 10, 0, 60);
  level.tiercapturetime[1] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationHalf", 10, 0, 60);
  level.tiercapturetime[2] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationBase", 10, 0, 60);
  level.tierholdtime = [];
  level.tierholdtime[0] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationCenter", 30, 0, 60);
  level.tierholdtime[1] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationHalf", 30, 0, 60);
  level.tierholdtime[2] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationBase", 45, 0, 60);
  level.juggspawnbehavior = scripts\mp\utility\dvars::dvarintvalue("juggSpawnBehavior", 1, 0, 3);
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.hvtspawnpos = scripts\mp\utility\dvars::dvarintvalue("captureCondition", 1, 0, 2);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("overtimeLimit", 300, 0, 300);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.persistentbombtimer = 0;
  level.persistentdomtimer = 1;

  if(istrue(level.persistentbombtimer)) {
    level.bombtimer = 60;
  } else {
    level.bombtimer = 30;
  }

  if(level.cmdrules == 1) {
    level.planttime = 2;
    level.defusetime = 2;
  } else {
    level.planttime = level.tiercapturetime[2];
    level.defusetime = level.tiercapturetime[2];
    level.bombtimer = 3;
  }

  level.controltoprogress = 1;
  setDvar("cg_buttonHintNaturalDistance", 200);
  level.forcedobjectiveindex = getdvarint("scr_cmd_force_index", -1);

  if(level.forcedobjectiveindex != -1) {
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_roundLimit", 2);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_roundswitch", 1);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    return;
  }
}

function ontimelimit() {
  if(level.cmdrules == 2) {
    if(level.cmddefendingteam != "neutral") {
      cmd_endgame(level.cmddefendingteam, game["end_reason"]["outpost_defended"]);
      return;
    }

    level thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(scripts\mp\utility\game::inovertime()) {
    level thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  level thread scripts\mp\gamelogic::endgame("overtime", game["end_reason"]["time_limit_reached"]);
}

function seticonnames() {
  level.iconcapture = "icon_waypoint_capture";
  level.iconcontested = "icon_waypoint_contested";
  level.icondefend = "icon_waypoint_defend";
  level.icondefusing = "icon_waypoint_defusing";
  level.iconlosing = "icon_waypoint_losing";
  level.iconneutral = "icon_waypoint_neutral";
  level.iconplanting = "icon_waypoint_planting";
  level.icontaking = "icon_waypoint_taking";
  level.icontarget = "icon_waypoint_target";
}

function onstartgametype() {
  seticonnames();

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
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");
  initspecatatorcameras();
  thread loopspectatorlocations();
  setupobjectives();
  initspawns();
  setupdestructibledoors();

  if(level.mapname == "mp_faridah") {
    init_mp_faridah();
  }

  thread startgame();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();
}

function init_mp_faridah() {
  initschoolmgturret();
  thread initksbonuscrates();
  thread initpropaganda();
}

function initpropaganda() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = (435, 0, 625);
  var_1 = (0, 0, 0);
  level.propagandaent = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  level.propagandaent show();
  level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
}

function initschoolmgturret() {
  var_0 = (260, -1415, 150);
  var_1 = (0, 90, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  var_3 = spawnturret("misc_turret", var_2.origin, "tur_gun_faridah_mp", 0);
  var_3.angles = var_2.angles;
  var_3 linkTo(var_2, "tag_origin", (0, 0, 16), (0, 0, 0));
  var_3 setModel("weapon_mg_bravo50_balcony");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_4 = getcompleteweaponname("tur_gun_faridah_mp");
  var_3.objweapon = var_4;
  var_5 = var_3 gettagorigin("tag_turret_pitch");
  var_6 = scripts\mp\gameobjects::createhintobject(var_5, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var_6 linkTo(var_3, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  thread turretthink(var_6);
  var_3.killcament = spawn("script_model", (255, -1425, 210));
}

function turretthink(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = "tur_gun_faridah_mp";
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0) {
      waitframe();
    }

    var_1 controlturreton(var_0);
    thread endturretusewatch(var_1, var_0);
    thread endturretonplayer(var_1);
    self waittill("end_turret_use");

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeusable();
  }
}

function endturretusewatch(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

function endturretonplayer(var_0) {
  var_0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}

function initksbonuscrates() {
  wait 2;
  var_0 = (1125, -1675, 100);
  givekscratetoteam("allies", var_0, "cruise_predator");
  var_0 = (-1150, -575, 100);
  givekscratetoteam("allies", var_0, "chopper_gunner");
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  var_0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "to_allies_camera":
          setteammapposition(var_3, game["attackers"], var_6);
          break;
        case "to_axis_camera":
          setteammapposition(var_3, game["defenders"], var_6);
          break;
      }
    }
  }
}

function setteammapposition(var_0, var_1, var_2) {
  if(!isDefined(level.spectatorcameras[var_0])) {
    level.spectatorcameras[var_0] = [];
  }

  level.spectatorcameras[var_0][var_1] = var_2;
}

function loopspectatorlocations() {
  var_0 = 0;

  for(;;) {
    if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var_1 = getdvarint("scr_cmd_camera_index", -1);

      if(var_1 != -1) {
        var_0 = var_1;
      }

      updatespectatorcamera("cop_" + var_0);
      var_2 = getdvarfloat("scr_cmd_camera_delay", 1);
      wait var_2;
      var_0++;

      if(var_0 > 4) {
        var_0 = 0;
      }

      if(getdvarint("scr_cmd_camera_debug", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}

function setupdestructibledoors() {
  if(!isDefined(level.destructibles) || !isDefined(level.destructibles["destructible_door"])) {
    return;
  }

  foreach(var_1 in level.destructibles["destructible_door"]) {
    var_2 = getdoorowner(var_1.ents[0].origin);
    var_1 scripts\mp\destructible::assigninteractteam(scripts\mp\utility\teams::getenemyteams(var_2));
  }
}

function getdoorowner(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    if(!isDefined(var_4.defaultownerteam)) {
      continue;
    }

    var_5 = distance2dsquared(var_0, var_4.curorigin);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1.defaultownerteam;
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_cmd_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_cmd_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_cmd_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_cmd_spawn_axis", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_1 in level.objectives) {
    var_1.spawnpoints = [];
    var_1.spawnpoints[game["attackers"]] = [];
    var_1.spawnpoints[game["defenders"]] = [];
  }

  foreach(var_4 in level.spawnpoints) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = var_4.script_noteworthy;

      if(var_4.classname == "mp_cmd_spawn_allies") {
        level.objectives[var_5].spawnpoints[game["attackers"]][level.objectives[var_5].spawnpoints[game["attackers"]].size] = var_4;
      } else if(var_4.classname == "mp_cmd_spawn_axis") {
        level.objectives[var_5].spawnpoints[game["defenders"]][level.objectives[var_5].spawnpoints[game["defenders"]].size] = var_4;
      }
    }
  }

  foreach(var_1 in level.objectives) {
    var_1.spawnsets = [];
    var_1.spawnsets[game["attackers"]] = "objSpawn_allies_" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnsets[game["attackers"]], var_1.spawnpoints[game["attackers"]]);
    var_1.spawnsets[game["defenders"]] = "objSpawn_axis_" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnsets[game["defenders"]], var_1.spawnpoints[game["defenders"]]);
  }
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    jumpiffalse(game["switchedsides"]) LOC_00000028;
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_cmd_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    self.startspawnpoint = var_2;
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, level.currentobjective.spawnsets[var_2]);
  }

  return var_2;
}

function setupobjectives() {
  level.currentobjective = undefined;
  level.objectives = [];
  setupbombzones();
  setupflags();
  setupareabrushes();
  setupteamoobtriggers();
  validateobjectives();
  thread ui_updatecmdprogress();
  thread disableobjectiveongameended();
  thread setupcaptureflares();
}

function setupbombzones() {
  var_0 = getEntArray("cop_bombzone", "targetname");

  if(var_0.size == 0) {
    return;
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["faridah_bomb_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion_large_2.vfx");
  level.ddbombmodel = [];
  level.multibomb = 1;
  level.bombsplanted = 0;
  level.bombexploded = 0;
  level.bombplanted = 0;
  level.aplanted = 0;
  level.bplanted = 0;

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(var_3 == "5") {
      var_3 = "_b";
    } else {
      var_3 = "_a";
    }

    var_2.objectivekey = var_3;
    mapobjectiveicon(var_2);
    var_4 = scripts\mp\gametypes\obj_bombzone::setupobjective(var_2);
    bombzone_ondisableobjective(var_4);
    var_4 scripts\mp\gameobjects::releaseid();
    level.objectives[var_4.objectivekey] = var_4;
    var_4.onbeginuse = &bombzone_onbeginuse;
    var_4.onenduse = &bombzone_onenduse;
    var_4.onuse = &bombzone_onuseplantobject;
    var_4.ondisableobjective = &bombzone_ondisableobjective;
    var_4.onenableobjective = &bombzone_onenableobjective;
    var_4.onactivateobjective = &bombzone_onactivateobjective;

    if(var_3 == "_a") {
      var_4 scripts\mp\gameobjects::setownerteam(game["attackers"]);
      continue;
    }

    var_4 scripts\mp\gameobjects::setownerteam(game["defenders"]);
  }
}

function setupflags() {
  var_0 = getEntArray("cop_flag", "targetname");
  var_1 = getEntArray("cop_flag_override", "targetname");

  if(var_0.size == 0) {
    return;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_0[var_3];
  }

  var_4 = [];

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      var_7 = var_6.script_noteworthy;
      var_4 = var_6;
    }
  }

  foreach(var_6 in var_2) {
    var_7 = var_6.script_noteworthy;

    if(isDefined(var_4[var_7])) {
      var_6 = var_4[var_7];
    }

    var_6.objectivekey = var_7;
    mapobjectiveicon(var_6, var_7);
    var_10 = scripts\mp\gametypes\obj_dom::setupobjective(var_6);
    var_10.flagmodel delete();
    var_10.flagmodel = undefined;
    var_10.outlineent = undefined;
    dompoint_ondisableobjective(var_10);
    level.objectives[var_10.objectivekey] = var_10;
    var_10.onbeginuse = &dompoint_onbeginuse;
    var_10.onuse = &dompoint_onuse;
    var_10.onenduse = &dompoint_onenduse;
    var_10.oncontested = &dompoint_oncontested;
    var_10.onuncontested = &dompoint_onuncontested;
    var_10.ondisableobjective = &dompoint_ondisableobjective;
    var_10.onenableobjective = &dompoint_onenableobjective;
    var_10.onactivateobjective = &dompoint_onactivateobjective;
    var_10 thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
  }
}

function disabledomflagscriptable() {
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function setupareabrushes() {
  var_0 = getEntArray("cop_zone_visual", "targetname");
  var_1 = getEntArray("cop_zone_visual_contest", "targetname");
  var_2 = getEntArray("cop_zone_visual_friend", "targetname");
  var_3 = getEntArray("cop_zone_visual_enemy", "targetname");
  var_4 = getEntArray("cop_zone_visual_friend_pulse", "targetname");
  var_5 = getEntArray("cop_zone_visual_enemy_pulse", "targetname");

  foreach(var_7 in level.objectives) {
    if(isDefined(var_7.scriptable)) {
      var_7.scriptable delete();
      var_7.scriptable = undefined;
    }
  }

  if(isDefined(var_0)) {
    foreach(var_10 in var_0) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].neutralbrush)) {
        level.objectives[var_11].neutralbrush = [];
      }

      level.objectives[var_11].neutralbrush[level.objectives[var_11].neutralbrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_1) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].contestedbrush)) {
        level.objectives[var_11].contestedbrush = [];
      }

      level.objectives[var_11].contestedbrush[level.objectives[var_11].contestedbrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_2) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].friendlybrush)) {
        level.objectives[var_11].friendlybrush = [];
      }

      level.objectives[var_11].friendlybrush[level.objectives[var_11].friendlybrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_3) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].enemybrush)) {
        level.objectives[var_11].enemybrush = [];
      }

      level.objectives[var_11].enemybrush[level.objectives[var_11].enemybrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_4) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].friendlypulsebrush)) {
        level.objectives[var_11].friendlypulsebrush = [];
      }

      level.objectives[var_11].friendlypulsebrush[level.objectives[var_11].friendlypulsebrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_5) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].enemypulsebrush)) {
        level.objectives[var_11].enemypulsebrush = [];
      }

      level.objectives[var_11].enemypulsebrush[level.objectives[var_11].enemypulsebrush.size] = var_10;
      var_10 hide();
    }

    return;
  }
}

function setupteamoobtriggers() {
  var_0 = getEntArray("cop_outofbounds", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(level.objectives[var_3].oobtriggers)) {
      level.objectives[var_3].oobtriggers = [];
    }

    if(isDefined(var_2.target)) {
      var_4 = getscriptablearray(var_2.target, "targetname");
      var_5 = [];

      foreach(var_7 in var_4) {
        var_8 = var_5.size;
        var_5 = var_7;

        if(isDefined(var_7.script_noteworthy)) {
          var_5[var_8].drawcount = int(var_7.script_noteworthy);
          continue;
        }

        var_5[var_8].drawcount = 1;
      }

      var_2.visuals = var_5;
      thread updateoobvisuals(var_2);
    }

    level.objectives[var_3].oobtriggers[var_2.script_label] = var_2;
  }
}

function validateobjectives() {
  if(level.objectives.size == 0) {} else if((level.objectives.size - 2) % 2 == 0) {}

  level.midpointobjectiveindex = int(floor((level.objectives.size - 2) / 2));
  level.currentobjectiveindex = level.midpointobjectiveindex;
  level.previousobjectiveindex = level.currentobjectiveindex;

  foreach(var_1 in level.objectives) {
    if(level.cmdrules == 1) {
      if(var_1.objectivekey == "_a" || var_1.objectivekey == "_b") {
        continue;
      }
    }

    var_2 = int(var_1.objectivekey);
    var_3 = int(clamp(floor(abs(var_2 - 2)), 0, 2));
    var_1.tierindex = var_3;
    var_1.activationdelay = level.tieractivationdelay[var_3];
    var_1.captureduration = level.tiercapturetime[var_3];
    var_1.holdtime = level.tierholdtime[var_3];
    var_1 scripts\mp\gameobjects::disableobject();
    var_1.firsttime = 1;

    if(level.cmdrules == 1) {
      switch (var_3) {
        case 1:
        case 0:
          var_1 scripts\mp\gameobjects::setcapturebehavior("persistent");
          var_1.ignorestomp = 1;
          break;
        case 2:
          if(var_2 < level.midpointobjectiveindex) {
            var_1.defaultownerteam = game["defenders"];
          } else {
            var_1.defaultownerteam = game["attackers"];
          }

          break;
      }

      continue;
    }

    var_1.firsttime = 1;
    var_1 scripts\mp\gameobjects::setcapturebehavior("normal");

    if(var_2 == level.midpointobjectiveindex) {
      continue;
    }

    if(var_2 < level.midpointobjectiveindex) {
      var_1.defaultownerteam = game["defenders"];
      continue;
    }

    var_1.defaultownerteam = game["attackers"];
  }
}

function startgame() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  updateteamscores();
  setomnvar("ui_objective_timer_stopped", 0);

  if(level.cmdrules == 2) {
    level scripts\mp\gamelogic::pausetimer();
  }

  updatecurrentobjective(level.currentobjectiveindex);
}

function updatecurrentobjective(var_0) {
  if(level.forcedobjectiveindex != -1) {
    var_0 = level.forcedobjectiveindex;
  }

  if(!isDefined(level.objectives[scripts\engine\utility::string(var_0)])) {
    return;
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
  }

  level.previousobjectiveindex = level.currentobjectiveindex;
  level.currentobjectiveindex = var_0;
  updatespectatorcamera("cop_" + level.currentobjectiveindex);
  level.currentobjective = level.objectives[scripts\engine\utility::string(var_0)];
  setomnvar("ui_cmd_current_obj", var_0);
  updateoobtriggers();

  if(isDefined(level.currentobjective.onenableobjective)) {
    level.currentobjective[[level.currentobjective.onenableobjective]]();
  }

  thread ui_updatecmdholdprogress();
  updateteamscores();

  if(level.currentobjective.activationdelay > 0) {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level.activationdelaystarttime = gettime();
    var_1 = level.currentobjective.activationdelay;
    ui_updatezonetimer(var_1);
    ui_updatezonetimerpausedness(0);
    ui_updatecmdownerteam("zone_activation_delay");
    ui_updatecmdcapturestatus("zone_activation_delay", 0);
    wait 3;
    showsplashtoteam("all", "cop_target");
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("allies", "next"), "allies", 1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("axis", "next"), "axis", 1);
    level.currentobjective.firsttime = 0;
    var_2 = gettime();

    foreach(var_4 in level.players) {
      var_4.lastsitreptime = var_2;
    }

    wait var_1 - 3;
    level.activationdelaystarttime = undefined;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective)) {
    level.currentobjective[[level.currentobjective.onactivateobjective]]();
  }

  showsplashtoteam("all", "cop_activate");
  var_6 = 0;

  switch (level.currentobjective.tierindex) {
    case 0:
      var_6 = 0;
      break;
    case 1:
      var_6 = 5;
      break;
    case 2:
      var_6 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var_6);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "allies", 0);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "axis", 0);
}

function getfirsttimevoforobjective(var_0) {
  var_1 = "cop_obj_" + level.currentobjectiveindex + "_" + level.mapname;
  return var_1;
}

function getvoforobjective(var_0, var_1) {
  var_2 = "";
  var_3 = 0;
  var_4 = var_0 == "allies" && level.previousobjectiveindex > level.currentobjectiveindex || var_0 == "axis" && level.previousobjectiveindex < level.currentobjectiveindex;

  if(var_1 == "next" && level.currentobjective.firsttime) {
    var_2 = getfirsttimevoforobjective(var_0);
  } else {
    switch (level.currentobjectiveindex) {
      case 4:
      case 0:
        var_3 = 0;

        switch (var_1) {
          case "next":
            var_2 = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var_4, "_attack_", "_defend_") + level.mapname;
            break;
          case "bomb_planted":
            if(level.currentobjectiveindex == 0) {
              var_2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var_0 == "allies", "_atenemy", "_atfriendly");
            } else {
              var_2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var_0 == "axis", "_atenemy", "_atfriendly");
            }

            break;
          case "bomb_defused":
            var_3 = 1;
            break;
        }

        break;
      case 3:
      case 2:
      case 1:
        switch (var_1) {
          case "next":
            var_2 = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var_4, "_attack_", "_defend_") + level.mapname;
            break;
          case "hold_confirmed":
          case "enemy_sec":
          case "hold":
            var_3 = 1;
            break;
        }

        break;
    }

    if(var_2 == "") {
      if(var_3) {
        var_2 = "cop_" + var_1;
      } else {
        var_2 = "cop_obj_" + level.currentobjectiveindex + "_" + var_1 + "_" + level.mapname;
      }
    }
  }

  return var_2;
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }

  switch (level.currentobjective.id) {
    case "domFlag":
      scripts\mp\gametypes\obj_dom::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      break;
    case "bomb_zone":
      scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var_1, self);
      break;
  }
}

function onplayerconnect(var_0) {
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;

  foreach(var_2 in level.objectives) {
    if(isDefined(var_2.neutralbrush)) {
      hidebrushes(var_2, var_0);
    }
  }

  thread updatefloorbrushwaitforjoined();
}

function decayholdtime(var_0) {
  self endon("domPoint_HoldTimer");

  for(;;) {
    if(isDefined(var_0)) {
      self.teamholdtimers[var_0] -= level.framedurationseconds;

      if(self.teamholdtimers[var_0] <= 0) {
        self.teamholdtimers[var_0] = 0;
        break;
      }
    }

    waitframe();
  }
}

function dompoint_holdtimer(var_0, var_1) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  level.inobjectiveot = 0;
  ui_updatecmdownerteam(var_0);

  if(istrue(level.persistentdomtimer)) {
    var_2 = self.teamholdtimers[var_0];
    self.holdteam = var_0;
  } else {
    var_2 = level.currentobjective.holdtime;
  }

  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];

  if(var_2 > 0) {
    thread decayholdtime(var_1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_3, "enemy_hold"), var_3, 1);
    var_4 = 0;

    if(level.currentobjectiveindex != 2 && var_2 > 5) {
      var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_1);

      if(isDefined(var_5)) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5, getcapturedialog("captured"));
        var_4 += getselfobjcaptureddialog(var_5, "captured");
      }
    }

    if(var_4 > 0) {
      wait var_4;
    }

    var_6 = 0;
    var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_1);

    if(isDefined(var_5) && var_2 > 5 + var_4) {
      var_6 = level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5, "cop_confirm_copsecureask");

      if(!isDefined(var_6)) {
        var_6 = 0;
      }
    }

    var_4 += var_6;
    wait var_6;

    if(var_2 > 5 + var_4) {
      scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "hold"), var_1, 1);
    }

    if(var_2 - var_4 > 0) {
      wait var_2 - var_4;
    } else {
      wait var_2;
    }

    var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];

    if(istrue(level.controltoprogress) && level.currentobjective.touchlist[var_3].size > 0) {
      level.inobjectiveot = 1;
      ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);

      for(;;) {
        if(level.currentobjective.touchlist[var_3].size == 0) {
          break;
        }

        waitframe();
      }

      level.inobjectiveot = 0;
    }
  }

  var_7 = 0;
  var_8 = level.currentobjectiveindex;

  if(var_1 == game["attackers"]) {
    var_8--;

    if(level.currentobjectiveindex <= level.midpointobjectiveindex) {
      var_7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var_1, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var_1)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent)) {
          level.propagandaent stoploopsound();
        }
      }
    }
  } else {
    var_8++;

    if(level.currentobjectiveindex >= level.midpointobjectiveindex) {
      var_7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var_1, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var_1)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent)) {
          level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
        }
      }
    }
  }

  if(0 && var_7) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
  }

  if(self.tierindex == 0) {
    if(isDefined(var_2)) {
      thread givekillstreak(var_2, "uav");
    } else {
      var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_1);
      thread givekillstreak(var_5, "uav");
    }
  }

  updateteamscores();

  if(var_2 > 0) {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "hold_confirmed"), var_1, 1);
  }

  showsplashtoteam(var_1, "cop_captured_friendly");
  showsplashtoteam(var_3, "cop_captured_enemy");

  if(level.forcedobjectiveindex != -1) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
    cmd_endgame(var_1, game["end_reason"]["target_destroyed"]);
    return;
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
    return;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
    level.extratime += 90;
    var_9 = scripts\mp\gamelogic::gettimeremaining();
    setgameendtime(gettime() + int(var_9));
    level scripts\mp\gamelogic::resumetimer();
  }

  updatecurrentobjective(var_8);
}

function dompoint_cancelholdtimer() {
  if(!istrue(level.persistentdomtimer)) {
    return;
  }

  var_0 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.holdteam) && self.holdteam == var_0) {
    ui_updatezonetimerpausedness(1);
    self notify("domPoint_HoldTimer");
    self.holdteam = undefined;
    return;
  }
}

function givekscratetoteam(var_0, var_1, var_2) {}

function createkscrate(var_0, var_1, var_2) {}

function cratethink(var_0, var_1) {
  self endon("restarting_physics");
  self endon("death");
  var_2 = scripts\engine\utility::drop_to_ground(self.origin + (7, 9, 0), 50, -200, (0, 0, 1));
  var_3 = spawn("script_model", var_2 + (0, 0, 0));
  var_3 setModel("offhand_wm_grenade_smoke");
  var_3.angles = self.angles + (-80, 120, 90);
  var_4 = spawn("script_model", var_3.origin);
  var_4 setModel("tag_origin");
  var_4.angles = self.angles + (0, 30, 0);
  var_4 playLoopSound("mp_flare_burn_lp");
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var_4, "tag_origin");
  var_5 = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var_6 = undefined;

  switch (var_1) {
    case "juggernaut":
      var_5 = &"KILLSTREAKS_HINTS/JUGGERNAUT_PICKUP_GL";
      var_6 = "icon_ks_jugg";
      break;
    case "cruise_predator":
      var_5 = &"KILLSTREAKS_HINTS/CRUISE_PREDATOR_PICKUP_GL";
      var_6 = "hud_icon_killstreak_cruise_missile";
      break;
    case "chopper_gunner":
      var_5 = &"KILLSTREAKS_HINTS/CHOPPER_GUNNER_PICKUP_GL";
      var_6 = "hud_icon_killstreak_apache";
      break;
  }

  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 24, "HINT_BUTTON", var_6, var_5, -1, undefined, "show", 250, 360, 100, 360);
  self.useobj linkTo(self);
  jumpiffalse(var_1 == "juggernaut") LOC_00000187;
  thread gainedjuggupdater(var_0);
  thread removedjuggupdater(var_0);

  for(;;) {
    self waittill("captured", var_7);

    if(isPlayer(var_7)) {
      var_7 setclientomnvar("ui_securing", 0);
      var_7.ui_securing = undefined;
    }

    switch (var_1) {
      case "juggernaut":
        break;
      case "cruise_predator":
        thread givekillstreak(var_7, "cruise_predator");
        wait 3;
        break;
      case "chopper_gunner":
        thread givekillstreak(var_7, "chopper_gunner");
        wait 3;
        break;
    }

    var_7 playlocalsound("ammo_crate_use");
    stopFXOnTag(level._effect["vfx_smk_signal"], var_4, "tag_origin");
    var_4 stoploopsound();
    var_4 delete();
    var_4 = undefined;
    var_3 delete();
    var_3 = undefined;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
    LOC_00000249:
  }
}

function gainedjuggupdater(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0 && istrue(var_2.isjuggernaut)) {
      self disableplayeruse(var_2);
    }
  }

  for(;;) {
    level waittill("gained_juggernaut", var_2);

    if(var_2.team == var_0) {
      self disableplayeruse(var_2);
    }
  }
}

function removedjuggupdater(var_0) {
  self endon("death");

  for(;;) {
    level waittill("removed_juggernaut", var_1);

    if(var_1.team == var_0) {
      self enableplayeruse(var_1);
    }
  }
}

function givekillstreak(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_0);
  scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_2, "other");

  if(istrue(var_1)) {
    wait 0.1;
    self notify("ks_action_4");
    return;
  }
}

function bombzone_warningklaxon() {
  level endon("game_ended");
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  var_0 = game["music"]["cop_finalpush"].size;
  var_1 = randomint(var_0);

  foreach(var_3 in level.players) {
    var_3 setplayermusicstate(game["music"]["cop_finalpush"][var_1]);
  }

  wait 2;
  wait 16;
}

function bombzone_holdtimer(var_0) {
  if(!isDefined(level.currentobjective)) {
    return;
  }

  level endon("gameEnded");
  level endon("bomb_planted");
  self notify("bombZone_HoldTimer");
  self endon("bombZone_HoldTimer");
  var_1 = level.currentobjective.defaultownerteam;
  var_2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var_2);
  level.timelimitoverride = 0;

  if(var_0 > 0) {
    ui_updatezonetimer(var_0);
    wait var_0;

    if(istrue(level.controltoprogress)) {
      var_2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
      var_3 = 0;

      for(;;) {
        if(!var_3) {
          var_3 = 1;
          ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);
        }

        if(level.currentobjective.touchlist[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  foreach(var_5 in level.players) {
    var_5 setplayermusicstate("mus_mp_cop_bombplant_end");
  }

  thread scripts\mp\music_and_dialog::suspensemusic();
  var_7 = level.currentobjectiveindex;
  var_8 = level.currentobjective scripts\mp\gameobjects::getownerteam();

  if(var_8 == game["attackers"]) {
    var_7--;
  } else {
    var_7++;
  }

  updatecurrentobjective(var_7);
}

function bombhandler(var_0, var_1, var_2) {
  if(level.gameended) {
    return;
  }

  if(var_1 == "explode") {
    self.bombexploded = 1;
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    scripts\mp\gamescore::giveteamscoreforobjective(var_2, 1, 0);
    cmd_endgame(var_2, game["end_reason"]["target_destroyed"]);
    return;
  }
}

function resetbombzone() {
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("none");
  self.id = "bomb_zone";
  self.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  self.bombexploded = undefined;
}

function cmd_endgame(var_0, var_1) {
  level.docmdoutro = 1;
  var_2 = undefined;

  if(level.mapname == "mp_faridah") {
    var_2 = spawnStruct();

    if(var_0 == "allies") {
      var_2.origin = (-207, -4711, 211);
      var_2.angles = (7, 64, 0);
    } else if(var_0 == "axis") {
      var_2.origin = (1945, 4423, 670);
      var_2.angles = (15, 244, 0);
    }
  }

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_4 setclientomnvar("ui_objective_state", 0);
    }

    thread playendofmatchtransition(var_4);
  }

  var_6 = game["teamScores"][var_0];
  var_7 = game["teamScores"][scripts\mp\utility\game::getotherteam(var_0)[0]];

  if(var_7 > var_6) {
    var_8 = var_7 - var_6 + 1;
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_8, 0);
  }

  thread scripts\mp\gamelogic::endgame(var_0, var_1);
  wait 0.65;
  level notify("allow_bomb_explosion");
  wait 5;
  level notify("cmd_continue_game_end");
}

function dompoint_onbeginuse(var_0) {
  dompoint_cancelholdtimer();
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var_0);
  self.didstatusnotify = 1;
  thread updateflares(var_0.team);
  ui_updatecmdcapturestatus(var_0.team, self.stalemate);

  if(var_0.team == game["attackers"]) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
      var_1 = scripts\mp\gameobjects::getownerteam();

      if(var_0.team != var_1) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("capturing"));
        getselfobjcaptureddialog(var_0, "planting");
      } else {
        getselfobjcaptureddialog(var_0, "defusing");
      }
    } else {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("capturing"));
    }
  }

  var_2 = scripts\mp\utility\game::getotherteam(var_0.team)[0];

  if(var_2 == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0.team, "enemy_cap"), var_2, 0);
  } else {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0.team, "enemy_sec"), var_2, 0);
  }

  foreach(var_0 in level.players) {
    updatefloorbrush(var_0);
  }
}

function dompoint_onuse(var_0) {
  if(istrue(level.persistentdomtimer)) {
    ui_updatezonetimerpausedness(0);
    self.lastcaptime = gettime();
    self.firstcapture = 0;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  thread updateflares(var_1);

  foreach(var_3 in level.players) {
    updatefloorbrush(var_3);
  }

  level.usestartspawns = 0;
  var_5 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_5, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.cmdattackingteam = var_1;
      level.cmddefendingteam = var_5;
      level scripts\mp\gamelogic::pausetimer();
    } else {
      level.extratime += 90;
      var_6 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(var_6));
    }
  }

  if(level.currentobjectiveindex == 0) {
    var_7 = level.objectives["_b"] scripts\mp\gameobjects::getownerteam();

    if(var_1 != var_7) {
      bombzone_onuseplantobject(level.objectives["_b"], var_0);
    } else {
      bombzone_onusedefuseobject(level.objectives["_b"], var_0);
    }
  } else if(level.currentobjectiveindex == 4) {
    var_7 = level.objectives["_a"] scripts\mp\gameobjects::getownerteam();

    if(var_1 != var_7) {
      bombzone_onuseplantobject(level.objectives["_a"], var_0);
    } else {
      bombzone_onusedefuseobject(level.objectives["_a"], var_0);
    }
  } else {
    thread dompoint_holdtimer(var_1, var_0);
    showsplashtoteam(var_1, "cop_hold_friendly");
    showsplashtoteam(var_5, "cop_hold_enemy");
  }

  if(self == level.currentobjective) {
    ui_updatecmdcapturestatus("neutral", 0);
    return;
  }
}

function dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
  var_3 = scripts\mp\gameobjects::getownerteam();
  var_4 = scripts\engine\utility::ter_op(var_3 == "neutral", "idle", var_3);
  thread updateflares(var_4);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      var_3 = scripts\mp\gameobjects::getownerteam();
      ui_updatecmdcapturestatus("neutral", 0);

      if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
        if(var_3 != "neutral") {
          ui_updatezonetimerpausedness(0);
          self.lastcaptime = gettime();
          thread dompoint_holdtimer(var_3);
        }
      }
    }
  } else if(!var_2) {
    var_3 = scripts\mp\gameobjects::getownerteam();
    ui_updatecmdcapturestatus("neutral", 0);

    if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
      if(var_3 != "neutral") {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var_3);
      }
    }
  }

  foreach(var_1 in level.players) {
    updatefloorbrush(var_1);
  }
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  dompoint_cancelholdtimer();
  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
  thread updateflares("contested");
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  ui_updatecmdcapturestatus(var_0, 1);
  var_1 = var_0;

  if(var_0 == "neutral") {
    var_1 = self.claimteam;
  }

  if(var_1 != "none") {
    scripts\mp\utility\dialog::statusdialog("cop_obj_contested", var_1, 0);
  }

  foreach(var_3 in level.players) {
    updatefloorbrush(var_3);
  }
}

function dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var_0);
  self.didstatusnotify = 1;
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  thread updateflares(var_2);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      if(var_1 != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(var_1)[0]].size == 0) {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var_1);
      }
    }
  } else if(istrue(level.persistentdomtimer) && level.currentobjectiveindex != 0 && level.currentobjectiveindex != 4) {
    if(var_1 != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(var_1)[0]].size == 0) {
      ui_updatezonetimerpausedness(0);
      self.lastcaptime = gettime();
      thread dompoint_holdtimer(var_1);
    }
  }

  ui_updatecmdcapturestatus("neutral", 0);

  foreach(var_4 in level.players) {
    updatefloorbrush(var_4);
  }
}

function dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, &disabledomflagscriptable);
  thread updateflares("off");

  foreach(var_1 in level.players) {
    updatefloorbrush(var_1, 1);
  }
}

function dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(istrue(level.persistentdomtimer)) {
    if(!isDefined(self.teamholdtimers)) {
      self.teamholdtimers = [];
    }

    self.teamholdtimers["allies"] = self.holdtime;
    self.teamholdtimers["axis"] = self.holdtime;
    self.firstcapture = 1;
    self.holdteam = undefined;
  }

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread scripts\mp\gametypes\obj_dom::updateflagstate(self.defaultownerteam, 0);
    thread updateflares(self.defaultownerteam);
  } else {
    scripts\mp\gameobjects::setownerteam("neutral");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
    thread updateflares("idle");
  }

  if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
    thread bombzone_warningklaxon();
  }

  if(getdvarint("scr_bradley_spawner", 0) != 0) {
    scripts\mp\gametypes\bradley_spawner::tryspawnneutralbradleycmd(level.currentobjectiveindex);
  }

  foreach(var_1 in level.players) {
    updatefloorbrush(var_1);
  }
}

function dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  var_0 = scripts\mp\gameobjects::getownerteam();
  ui_updatecmdownerteam(var_0);
  ui_updatecmdcapturestatus("neutral", 0);
  scripts\mp\gameobjects::allowuse("enemy");
  thread awardcapturepoints();
  level.flagcapturetime = self.captureduration;

  if(self.tierindex == 2) {
    if(level.cmdrules == 1) {
      level.flagcapturetime = 5;
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  }

  if(level.cmdrules == 1) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
      thread bombzone_holdtimer(self.holdtime);
      return;
    }

    return;
  }
}

function bombzone_onbeginuse(var_0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var_0);
}

function bombzone_onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var_0, var_1, var_2);
}

function bombzone_onuseplantobject(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var_1);
  showsplashtoteam("all", "cop_planted");
  level.flagcapturetime = 15;

  if(istrue(level.persistentbombtimer)) {
    if(!isDefined(level.basefusetimers)) {
      level.basefusetimers = [];
      level.basefusetimers["allies"] = level.bombtimer;
      level.basefusetimers["axis"] = level.bombtimer;
    }

    level.bombtimer = level.basefusetimers[var_1];
    level.lastbombplanttime = gettime();
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(var_0);
  var_3 = game["music"]["cop_bombplant"].size;
  var_4 = randomint(var_3);

  foreach(var_6 in level.players) {
    var_6 setplayermusicstate(game["music"]["cop_bombplant"][var_4]);
  }

  if(var_0.team == "allies") {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("planted"));
  }

  if(false) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 1, 0);
  }

  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "bomb_planted"), var_1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_2, "bomb_planted"), var_2, 1);

  if(isDefined(level.zoneendtime)) {
    level.zoneendtime = int(level.zoneendtime - gettime());
  }

  if(level.cmdrules == 1) {
    ui_updatebombtimer();
  }

  ui_updatecmdownerteam(var_0.team);
}

function bombzone_onusedefuseobject(var_0) {
  if(!level.bombplanted) {
    return;
  }

  showsplashtoteam("all", "cop_defused");
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  level.flagcapturetime = 5;

  if(istrue(level.persistentbombtimer)) {
    level.basefusetimers[var_1] -= (gettime() - level.lastbombplanttime) / 1000;
  }

  level.bombsplanted -= 1;

  if(self.objectivekey == "_a") {
    level.aplanted = 0;
  } else {
    level.bplanted = 0;
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onusedefuseobject(var_0);

  if(scripts\mp\utility\game::getotherteam(var_0.team)[0] == "allies") {
    var_3 = getclosestplayeronteam(level.currentobjective.trigger.origin, scripts\mp\utility\game::getotherteam(var_0.team)[0]);

    if(isDefined(var_3)) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_3, getcapturedialog("defused"));
    }
  }

  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "bomb_defused"), var_1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_2, "bomb_defused"), var_2, 1);
  var_0 notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone();

  if(isDefined(level.zoneendtime)) {
    thread bombzone_holdtimer(level.zoneendtime / 1000);
  }

  ui_updatecmdownerteam(var_0.team);
}

function bombzone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");
}

function bombzone_onenableobjective() {
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
}

function bombzone_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  ui_updatecmdownerteam("neutral");
  ui_updatecmdcapturestatus("neutral", 0);
  level.planttime = self.captureduration;
  level.defusetime = self.captureduration;
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  scripts\mp\gameobjects::allowuse("enemy");
  thread bombzone_holdtimer(self.holdtime);
}

function ui_updatezonetimer(var_0) {
  level.zoneendtime = int(gettime() + 1000 * var_0);
  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

function ui_updatebombtimer() {
  var_0 = int(gettime() + 1000 * level.bombtimer);
  setomnvar("ui_hardpoint_timer", var_0);
}

function ui_updatezonetimerpausedness(var_0) {
  setomnvar("ui_objective_timer_stopped", var_0);
}

function getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      return var_3;
    }
  }

  return var_1;
}

function ui_updatecmdcapturestatus(var_0, var_1) {
  var_2 = -1;

  if(istrue(level.inobjectiveot)) {
    if(var_1) {
      var_2 = -4;
    } else {
      var_2 = -5;
    }
  } else if(var_1) {
    var_2 = -2;
  } else {
    switch (var_0) {
      case "allies":
        var_2 = 2;
        break;
      case "axis":
        var_2 = 1;
        break;
      case "zone_activation_delay":
        var_2 = -3;
        break;
      case "overtime":
        var_2 = -4;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_cmd_capture_team", var_2);
}

function ui_updatecmdownerteam(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "allies":
      var_1 = 2;
      break;
    case "axis":
      var_1 = 1;
      break;
    case "zone_activation_delay":
      var_1 = -3;
      break;
    case "zone_shift":
    default:
      break;
  }

  setomnvar("ui_cmd_owner_team", var_1);
}

function ui_updatecmdprogress() {
  for(;;) {
    if(isDefined(level.currentobjective)) {
      setomnvar("ui_cmd_capture_progress", level.currentobjective scripts\mp\gameobjects::getcaptureprogress());
    } else {
      setomnvar("ui_cmd_capture_progress", 0);
    }

    waitframe();
  }
}

function ui_updatecmdholdprogress() {
  self notify("ui_updateCMDHoldProgress");
  self endon("ui_updateCMDHoldProgress");

  for(;;) {
    if(isDefined(level.currentobjective) && isDefined(level.currentobjective.teamholdtimers) && isDefined(level.currentobjective.holdtime) && level.currentobjective.holdtime > 0) {
      setomnvar("ui_cmd_owner_progress_allies", 1 - level.currentobjective.teamholdtimers["allies"] / level.currentobjective.holdtime);
      setomnvar("ui_cmd_owner_progress_axis", 1 - level.currentobjective.teamholdtimers["axis"] / level.currentobjective.holdtime);
    } else {
      setomnvar("ui_cmd_owner_progress_allies", 0);
      setomnvar("ui_cmd_owner_progress_axis", 0);
    }

    waitframe();
  }
}

function getcurrentvalue() {
  if(!isDefined(level.currentobjective)) {
    return 0.5;
  }

  var_0 = getcenterfrac(level.currentobjectiveindex);
  var_1 = 0;
  var_2 = level.currentobjective scripts\mp\gameobjects::getownerteam();
  var_3 = 0;
  var_4 = 0.03;
  var_5 = 0;

  if(isDefined(level.activationdelaystarttime) && level.previousobjectiveindex != level.currentobjectiveindex) {
    if(isDefined(level.currentobjective.defaultownerteam)) {
      var_1 = var_4;

      if(var_2 == "allies") {
        var_1 *= -1;
      }

      var_4 *= 2;
    }

    var_3 = 1;
    var_6 = gettime();
    var_7 = (var_6 - level.activationdelaystarttime) / level.currentobjective.activationdelay * 1000;
    var_5 = (abs(getcenterfrac(level.previousobjectiveindex) - var_0) - var_4) * var_7;

    if(level.currentobjectiveindex < level.previousobjectiveindex) {
      var_5 *= -1;
      var_4 *= -1;
    }

    var_0 = getcenterfrac(level.previousobjectiveindex);
  } else {
    var_2 = level.currentobjective scripts\mp\gameobjects::getownerteam();

    if(var_2 != "neutral") {
      var_1 = var_4;

      if(var_2 == "allies") {
        var_1 *= -1;
      }

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam != var_2) {
          var_4 *= 2;
          var_3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

          if(level.currentobjective.claimteam == "allies") {
            var_3 *= -1;
          }
        }
      }
    } else {
      var_3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam == "allies") {
          var_3 *= -1;
        }
      } else if(isDefined(level.currentobjective.lastclaimteam)) {
        if(level.currentobjective.lastclaimteam == "allies") {
          var_3 *= -1;
        }
      }
    }
  }

  return var_0 + var_1 + var_3 * var_4 + var_5;
}

function getcenterfrac(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 0:
      var_1 = 0;
      break;
    case 1:
      var_1 = 0.25;
      break;
    case 2:
      var_1 = 0.5;
      break;
    case 3:
      var_1 = 0.75;
      break;
    case 4:
      var_1 = 1;
      break;
  }

  return var_1;
}

function updateteamscores() {
  if(true) {
    scripts\mp\gamescore::_setteamscore("allies", 0, 0);
    scripts\mp\gamescore::_setteamscore("axis", 0, 0);
    return;
  }
}

function spawnjuggcate(var_0, var_1) {
  var_2 = level.juggspawnbehavior;

  if(var_1 == "attacker" && var_2 != 1 && var_2 != 3) {
    return;
  }

  if(var_1 == "defender" && var_2 != 2 && var_2 != 3) {
    return;
  }

  if(!isDefined(level.juggcrates)) {
    level.juggcrates = [];
    level.juggcrates["allies"] = [];
    level.juggcrates["axis"] = [];
  }

  if(isDefined(level.juggcrates[var_0][var_1])) {
    return;
  }

  var_3 = undefined;

  switch (level.mapname) {
    case "mp_faridah":
      if(var_1 == "attacker") {
        if(var_0 == "allies") {
          var_3 = (250, -2040, 215);
        } else {
          var_3 = (786, 2413, 260);
        }
      } else if(var_1 == "defender") {
        if(var_0 == "allies") {
          var_3 = (25, -4630, 10);
        } else {
          var_3 = (1480, 4375, -40);
        }
      }

      break;
    case "mp_anvil":
      if(var_1 == "attacker") {
        if(var_0 == "allies") {
          var_3 = (2775, 2375, 360);
        } else {
          var_3 = (-60, -260, 450);
        }
      } else if(var_1 == "defender") {
        if(var_0 == "allies") {
          var_3 = (-2680, -855, 250);
        } else {
          var_3 = (2365, 4360, 360);
        }
      }

      break;
  }

  if(isDefined(var_3)) {
    level.juggcrates[var_0][var_1] = givekscratetoteam(var_0, var_3, "juggernaut");
    thread removeondeath(level.juggcrates[var_0][var_1], var_0);
    return;
  }
}

function removeondeath(var_0, var_1) {
  level endon("game_ended");
  self waittill("death");
  level.juggcrates[var_0][var_1] = undefined;
}

function givejuggernaut() {
  if(!isPlayer(self)) {
    return false;
  }

  if(istrue(self.isjuggernaut)) {
    return false;
  }

  if(isDefined(self.lightarmorhp)) {
    scripts\mp\perks\perkfunctions::unsetlightarmor();
  }

  scripts\mp\lightarmor::setlightarmorvalue(self, 500, 1, 0);
  self disableweaponpickup();
  scripts\mp\weapons::setplantedequipmentuse(0);
  scripts\common\utility::allow_offhand_weapons(0);

  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweapon);
  var_0 = "iw8_lm_kilo121_mp";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self givemaxammo(var_0);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_0);
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
  self.health = self.maxhealth;
  self.isjuggernaut = 1;
  self.movespeedscaler = 0.75;
  scripts\mp\utility\perk::giveperk("specialty_scavenger");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_sharp_focus");
  thread juggernautsounds();
  thread juggremover();
  level notify("gained_juggernaut", self);
  return true;
}

function juggernautsounds() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("jugg_removed");

  for(;;) {
    wait 3;
  }
}

function juggremover() {
  self endon("disconnect");
  thread removejuggongameended();
  thread removejuggonteamchangeordeath();
  self waittill("should_remove_jugg");

  if(isDefined(self.lightarmorhp)) {
    scripts\mp\perks\perkfunctions::unsetlightarmor();
  }

  self enableweaponpickup();
  scripts\mp\weapons::setplantedequipmentuse(1);
  scripts\common\utility::allow_offhand_weapons(1);
  self.juggoverlay destroy();
  scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_lm_kilo121_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweapon);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.primaryweapon);
  self.movespeedscaler = 1;
  scripts\mp\utility\perk::removeperk("specialty_scavenger");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_sharp_focus");
  self.isjuggernaut = 0;
  level notify("removed_juggernaut", self);
  self notify("jugg_removed");
}

function removejuggongameended() {
  self endon("disconnect");
  self endon("jugg_removed");
  level waittill("game_ended");
  self notify("should_remove_jugg");
}

function removejuggonteamchangeordeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  scripts\engine\utility::ref_143a7("death", "joined_team", "joined_spectators", "lost_juggernaut");
  self notify("should_remove_jugg");
}

function updatefloorbrush(var_0, var_1) {
  if(!isDefined(self.neutralbrush)) {
    return;
  }

  var_2 = self.ownerteam;
  var_3 = self.claimteam;
  var_4 = var_0.team;
  var_5 = var_0 ismlgspectator();

  if(var_5) {
    var_4 = var_0 getmlgspectatorteam();
  }

  if(istrue(var_1)) {
    hidebrushes(var_0);
  } else if(istrue(self.stalemate)) {
    showcontestedbrush(var_0);
  } else if(var_2 == "neutral") {
    if(var_3 != "none") {
      if(var_4 == var_3) {
        showfriendlybrush(var_0);
      } else {
        showenemybrush(var_0);
      }
    } else {
      showneutralbrush(var_0);
    }
  } else if(var_4 == var_2) {
    showfriendlybrush(var_0);
  } else {
    showenemybrush(var_0);
  }

  updatecapturebrush(var_0);
}

function updatecapturebrush(var_0) {
  if(true) {
    return;
  }

  if(!isDefined(self.neutralbrush)) {
    return;
  }

  var_1 = scripts\mp\gameobjects::getclaimteam();
  var_2 = var_0.team;
  var_3 = var_0 ismlgspectator();

  if(var_3) {
    var_2 = var_0 getmlgspectatorteam();
  }

  if(istrue(self.stalemate)) {
    hidecapturebrush(var_0);
    return;
  }

  if(var_1 == "none") {
    hidecapturebrush(var_0);
    return;
  }

  if(var_2 == var_1) {
    showfriendlycapturebrush(var_0);
    return;
  }

  showenemycapturebrush(var_0);
}

function showneutralbrush(var_0) {
  foreach(var_2 in self.friendlybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.contestedbrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.neutralbrush) {
    var_2 showtoplayer(var_0);
  }
}

function showfriendlybrush(var_0) {
  foreach(var_2 in self.friendlybrush) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self.enemybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.contestedbrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.neutralbrush) {
    var_2 hidefromplayer(var_0);
  }
}

function showenemybrush(var_0) {
  foreach(var_2 in self.friendlybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemybrush) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self.contestedbrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.neutralbrush) {
    var_2 hidefromplayer(var_0);
  }
}

function showcontestedbrush(var_0) {
  foreach(var_2 in self.friendlybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.contestedbrush) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self.neutralbrush) {
    var_2 hidefromplayer(var_0);
  }
}

function hidebrushes(var_0) {
  foreach(var_2 in self.friendlybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemybrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.contestedbrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.neutralbrush) {
    var_2 hidefromplayer(var_0);
  }
}

function showfriendlycapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self.enemypulsebrush) {
    var_2 hidefromplayer(var_0);
  }
}

function showenemycapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemypulsebrush) {
    var_2 showtoplayer(var_0);
  }
}

function hidecapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self.enemypulsebrush) {
    var_2 hidefromplayer(var_0);
  }
}

function updatefloorbrushwaitforjoined() {}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;
  var_3 = spawn("script_model", self getvieworigin());
  var_3 setModel("tag_origin");
  var_3.angles = var_2;
  self.spectatorcament = var_3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_3, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var_3, self, var_1, var_2);
}

function dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

function endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }

  removethermal();
  thread runslamzoomonspawn();
}

function updatespectatorcamera(var_0) {
  level.currentspectatorcamref = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.spectatorcament)) {
      var_3 = var_2.team;
      var_4 = getdvarint("scr_cmd_camera_team", -1);

      if(var_4 != -1) {
        var_3 = scripts\engine\utility::ter_op(var_4 == 0, "allies", "axis");
      }

      var_5 = level.spectatorcameras[level.currentspectatorcamref][var_3];
      movecameratomappos(var_2.spectatorcament, var_2, var_5.origin, var_5.angles);
    }
  }
}

function movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_1, 1, 0.5, 0.5);
  var_0 playlocalsound("mp_cmd_camera_zoom_out");
  var_0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var_2, 1, 0.5, 0.5);
  thread startoperatorsound();
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 *= (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15, 1, 1);
    var_0 earthquakeforplayer(0.03, 15, var_1 + var_5, 1000);
    return;
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
  wait 1;
  var_2 = gettime();

  if(!isDefined(self.lastsitreptime) || var_2 < self.lastsitreptime + 30000 || var_2 < level.lastteamstatustime[self.team] + 5000) {
    return;
  }

  scripts\mp\utility\dialog::sitrepdialogonplayer(getsitreplocname());
  thread playselfbattlechatter(self, "plrresponse_affirm", "cop_affirm_2d", 2.5, 1);
}

function playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0;
  wait 0.4;
  var_0 destroy();
}

function startoperatorsound() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

function ongameended() {
  level waittill("game_ended");

  foreach(var_1 in level.objectives) {
    var_1 scripts\mp\gameobjects::setvisibleteam("none");
  }
}

function playendofmatchtransition(var_0) {
  self setclientomnvar("ui_total_fade", 0);
  waitframe();
  var_1 = 10;
  var_2 = var_1;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    waitframe();
    self setclientomnvar("ui_total_fade", var_2 / var_1);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote() && isDefined(var_0)) {
    var_3 = distance2dsquared(self.origin, var_0.origin);

    if(var_3 > 40000) {
      var_4 = self cloneplayer(0);
      var_4 startragdoll(1);
    }
  }

  thread scripts\mp\playerlogic::spawnintermission(var_0, "spectator");
  waitframe();
  var_1 = 4;
  var_2 = var_1;

  for(var_2 = var_1 - 1; var_2 >= 0; var_2--) {
    waitframe();
    self setclientomnvar("ui_total_fade", var_2 / var_1);
  }
}

function getsitreplocname() {
  var_0 = "sitrep_" + level.currentobjectiveindex + "_" + level.mapname;
  return var_0;
}

function getcapturedialog(var_0) {
  var_1 = "cop_obj_" + level.currentobjectiveindex + "_" + var_0 + "_" + level.mapname;
  return var_1;
}

function getselfobjcaptureddialog(var_0) {
  var_1 = "";
  var_2 = "";
  var_3 = 0;

  switch (level.currentobjectiveindex) {
    case 0:
      if(var_0 == "planting") {
        var_1 = "arming_bomb";
        var_2 = "cop_arming_bomb_2d";
        var_3 = 1;
      } else if(var_0 == "defusing") {
        var_1 = "bomb_defusing";
        var_2 = "cop_bomb_defusing_2d";
        var_3 = 1;
      }

      break;
    case 1:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        if(self.team == "axis") {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        } else if(level.mapname == "mp_faridah") {
          var_1 = "objsecured_school";
          var_2 = "cop_school_captured_2d";
        } else {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 2:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        var_1 = "objsecured_generic";
        var_2 = "cop_generic_captured_2d";
      }

      break;
    case 3:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        if(level.mapname == "mp_faridah") {
          var_1 = "objsecured_warehouse";
          var_2 = "cop_warehouse_captured_2d";
        } else {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 4:
      if(var_0 == "planting") {
        var_1 = "arming_bomb";
        var_2 = "cop_arming_bomb_2d";
        var_3 = 1;
      } else if(var_0 == "defusing") {
        var_1 = "bomb_defusing";
        var_2 = "cop_bomb_defusing_2d";
        var_3 = 1;
      }

      break;
  }

  var_4 = 0;

  if(var_3 && !scripts\mp\battlechatter_mp::saidtoorecently(var_2)) {
    scripts\mp\battlechatter_mp::updatechatter(var_2);
    thread playselfbattlechatter(self, var_1, var_2, 1.5);
  } else if(!var_3) {
    thread playselfbattlechatter(self, var_1, var_2, 1.5);
  }

  var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "afp1");
  }

  var_6 = "dx_mpp_" + var_5 + "_" + var_1;
  return lookupsoundlength(var_6) / 1000;
}

function playselfbattlechatter(var_0, var_1, var_2, var_3, var_4) {
  if(isai(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death");

  if(isDefined(var_3)) {
    wait var_3;
  }

  var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var_5 = scripts\engine\utility::ter_op(var_0.team == "allies", "usp1", "afp1");
  }

  var_6 = "dx_mpp_" + var_5 + "_" + var_1;

  if(isDefined(var_4)) {
    var_7 = var_6;

    if(soundexists(var_7)) {
      var_6 = var_7;
    }
  }

  var_0 queuedialogforplayer(var_6, var_2, 2);
}

function getclosestplayeronteam(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(var_5.team == var_1 && scripts\mp\utility\player::isreallyalive(var_5)) {
      var_6 = distance2dsquared(var_5.origin, var_0);

      if(!isDefined(var_3) || var_6 < var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

function disableobjectiveongameended() {
  level waittill("game_ended");

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    return;
  }
}

function setupcaptureflares() {
  if(getdvarint("scr_cop_flares", 0) != 1) {
    return;
  }

  wait 2;
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, spawnflare((350, -3580, -35), (0, -151, 0)));
}

function spawnflare(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    var_3 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  }

  var_4 = spawn("script_model", var_3 + (0, 0, 2));
  var_4.angles = var_1 + (0, 180, 0);
  var_4 setModel("cop_marker_scriptable");
  return var_4;
}

function updateflares(var_0) {
  if(getdvarint("scr_cop_flares", 0) != 1) {
    return;
  }

  self notify("updateFlares");
  self endon("updateFlares");

  while(!isDefined(self.scriptables)) {
    waitframe();
  }

  foreach(var_2 in self.scriptables) {
    var_2 setscriptablepartstate("marker", var_0);
  }
}

function debugcaptureflares() {
  var_0 = 0;

  for(;;) {
    var_1 = 0;

    switch (var_0) {
      case 0:
        var_1 = "allies";
        break;
      case 1:
        var_1 = "axis";
        break;
      case 2:
        var_1 = "contested";
        break;
      case 3:
        var_1 = "idle";
        break;
    }

    foreach(var_3 in level.objectives) {
      if(!isDefined(var_3.scriptables)) {
        continue;
      }

      foreach(var_5 in var_3.scriptables) {
        var_5 setscriptablepartstate("marker", var_1);
      }
    }

    var_0++;

    if(var_0 > 3) {
      var_0 = 0;
    }

    wait 3;
  }
}

function mapobjectiveicon(var_0) {
  switch (level.mapname) {
    case "mp_faridah":
      switch (self.objectivekey) {
        case "0":
          self.iconname = "_bombsite";
          break;
        case "1":
          self.iconname = "_school";
          break;
        case "2":
          self.iconname = "_clocktower";
          break;
        case "3":
          self.iconname = "_warehouse";
          break;
        case "4":
          self.iconname = "_bombsite";
          break;
        default:
          self.iconname = "";
          break;
      }

      break;
    default:
      switch (self.objectivekey) {
        case "0":
          self.iconname = "_generic";
          break;
        case "1":
          self.iconname = "_generic";
          break;
        case "2":
          self.iconname = "_generic";
          break;
        case "3":
          self.iconname = "_generic";
          break;
        case "4":
          self.iconname = "_generic";
          break;
        default:
          self.iconname = "";
          break;
      }

      break;
  }
}

function updateoobtriggers() {
  if(!isDefined(level.currentobjective.oobtriggers)) {
    return;
  }

  level notify("updateOOBTriggers");

  foreach(var_1 in level.players) {
    if(isDefined(level.currentobjective.oobtriggers["allies"])) {
      thread updateoobvisuals(level.currentobjective.oobtriggers["allies"]);
    }

    if(isDefined(level.currentobjective.oobtriggers["axis"])) {
      thread updateoobvisuals(level.currentobjective.oobtriggers["axis"]);
    }
  }
}

function updateoobvisuals(var_0) {
  self notify("updateOOBVisuals");
  self endon("updateOOBVisuals");

  while(!isDefined(self.visuals)) {
    waitframe();
  }

  foreach(var_2 in self.visuals) {
    for(var_3 = 0; var_3 < var_2.drawcount; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, var_0);
    }
  }

  level waittill("updateOOBTriggers");

  foreach(var_2 in self.visuals) {
    for(var_3 = 0; var_3 < var_2.drawcount; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, "off");
    }
  }
}

function awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    for(var_2 = 0; var_2 < var_0; var_2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 += level.framedurationseconds;

      if(self.stalemate) {}
    }

    var_3 = self.claimteam;

    if(var_3 == "none") {
      continue;
    }

    if(!self.stalemate) {
      foreach(var_5 in self.touchlist[var_3]) {
        var_5.player thread scripts\mp\utility\points::giveunifiedpoints("cop_in_obj");
      }
    }
  }
}

function showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_0 == "all" || var_3.team == var_0) {
      var_3 thread scripts\mp\hud_message::showsplash(var_1);
    }
  }
}