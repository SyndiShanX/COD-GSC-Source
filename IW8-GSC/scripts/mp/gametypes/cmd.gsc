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
  setDvar("NSOMOMMLML", 200);
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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/DOM_HINT");
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
  var0 = (435, 0, 625);
  var1 = (0, 0, 0);
  level.propagandaent = scripts\engine\utility::spawn_tag_origin(var0, var1);
  level.propagandaent show();
  level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
}

function initschoolmgturret() {
  var0 = (260, -1415, 150);
  var1 = (0, 90, 0);
  var2 = scripts\engine\utility::spawn_tag_origin(var0, var1);
  var3 = spawnturret("misc_turret", var2.origin, "tur_gun_faridah_mp", 0);
  var3.angles = var2.angles;
  var3 linkTo(var2, "tag_origin", (0, 0, 16), (0, 0, 0));
  var3 setModel("weapon_mg_bravo50_balcony");
  var3 makeunusable();
  var3 setnodeploy(1);
  var3 setdefaultdroppitch(0);
  var4 = getcompleteweaponname("tur_gun_faridah_mp");
  var3.objweapon = var4;
  var5 = var3 gettagorigin("tag_turret_pitch");
  var6 = scripts\mp\gameobjects::createhintobject(var5, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var6 linkTo(var3, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  thread turretthink(var6);
  var3.killcament = spawn("script_model", (255, -1425, 210));
}

function turretthink(var0) {
  for(;;) {
    self waittill("trigger", var1);
    self makeunusable();
    var1.prevweapon = var1 getcurrentweapon();
    var1.useweapon = "tur_gun_faridah_mp";
    var1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1.useweapon, undefined, undefined, 1);

    while(var1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1.useweapon, 1) == 0) {
      waitframe();
    }

    var1 controlturreton(var0);
    thread endturretusewatch(var1, var0);
    thread endturretonplayer(var1);
    self waittill("end_turret_use");

    if(isDefined(var1)) {
      var1 controlturretoff(var0);
      var1 switchtoweaponimmediate(var1.prevweapon);
      var1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var1.useweapon);
    }

    self makeusable();
  }
}

function endturretusewatch(var0, var1) {
  var0 endon("death_or_disconnect");

  while(var0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var0 useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

function endturretonplayer(var0) {
  var0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}

function initksbonuscrates() {
  wait 2;
  var0 = (1125, -1675, 100);
  givekscratetoteam("allies", var0, "cruise_predator");
  var0 = (-1150, -575, 100);
  givekscratetoteam("allies", var0, "chopper_gunner");
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  var0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;
    var4 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    foreach(var6 in var4) {
      switch (var6.script_label) {
        case "to_allies_camera":
          setteammapposition(var3, game["attackers"], var6);
          break;
        case "to_axis_camera":
          setteammapposition(var3, game["defenders"], var6);
          break;
      }
    }
  }
}

function setteammapposition(var0, var1, var2) {
  if(!isDefined(level.spectatorcameras[var0])) {
    level.spectatorcameras[var0] = [];
  }

  level.spectatorcameras[var0][var1] = var2;
}

function loopspectatorlocations() {
  var0 = 0;

  for(;;) {
    if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var1 = getdvarint("scr_cmd_camera_index", -1);

      if(var1 != -1) {
        var0 = var1;
      }

      updatespectatorcamera("cop_" + var0);
      var2 = getdvarfloat("scr_cmd_camera_delay", 1);
      wait var2;
      var0++;

      if(var0 > 4) {
        var0 = 0;
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

  foreach(var1 in level.destructibles["destructible_door"]) {
    var2 = getdoorowner(var1.ents[0].origin);
    var1 scripts\mp\destructible::assigninteractteam(scripts\mp\utility\teams::getenemyteams(var2));
  }
}

function getdoorowner(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.objectives) {
    if(!isDefined(var4.defaultownerteam)) {
      continue;
    }

    var5 = distance2dsquared(var0, var4.curorigin);

    if(!isDefined(var1) || var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1.defaultownerteam;
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

  foreach(var1 in level.objectives) {
    var1.spawnpoints = [];
    var1.spawnpoints[game["attackers"]] = [];
    var1.spawnpoints[game["defenders"]] = [];
  }

  foreach(var4 in level.spawnpoints) {
    if(isDefined(var4.script_noteworthy)) {
      var5 = var4.script_noteworthy;

      if(var4.classname == "mp_cmd_spawn_allies") {
        level.objectives[var5].spawnpoints[game["attackers"]][level.objectives[var5].spawnpoints[game["attackers"]].size] = var4;
      } else if(var4.classname == "mp_cmd_spawn_axis") {
        level.objectives[var5].spawnpoints[game["defenders"]][level.objectives[var5].spawnpoints[game["defenders"]].size] = var4;
      }
    }
  }

  foreach(var1 in level.objectives) {
    var1.spawnsets = [];
    var1.spawnsets[game["attackers"]] = "objSpawn_allies_" + var8;
    scripts\mp\spawnlogic::registerspawnset(var1.spawnsets[game["attackers"]], var1.spawnpoints[game["attackers"]]);
    var1.spawnsets[game["defenders"]] = "objSpawn_axis_" + var8;
    scripts\mp\spawnlogic::registerspawnset(var1.spawnsets[game["defenders"]], var1.spawnpoints[game["defenders"]]);
  }
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    jumpiffalse(game["switchedsides"]) LOC_00000028;
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_cmd_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
    self.startspawnpoint = var2;
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, level.currentobjective.spawnsets[var2]);
  }

  return var2;
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
  var0 = getEntArray("cop_bombzone", "targetname");

  if(var0.size == 0) {
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

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;

    if(var3 == "5") {
      var3 = "_b";
    } else {
      var3 = "_a";
    }

    var2.objectivekey = var3;
    mapobjectiveicon(var2);
    var4 = scripts\mp\gametypes\obj_bombzone::setupobjective(var2);
    bombzone_ondisableobjective(var4);
    var4 scripts\mp\gameobjects::releaseid();
    level.objectives[var4.objectivekey] = var4;
    var4.onbeginuse = &bombzone_onbeginuse;
    var4.onenduse = &bombzone_onenduse;
    var4.onuse = &bombzone_onuseplantobject;
    var4.ondisableobjective = &bombzone_ondisableobjective;
    var4.onenableobjective = &bombzone_onenableobjective;
    var4.onactivateobjective = &bombzone_onactivateobjective;

    if(var3 == "_a") {
      var4 scripts\mp\gameobjects::setownerteam(game["attackers"]);
      continue;
    }

    var4 scripts\mp\gameobjects::setownerteam(game["defenders"]);
  }
}

function setupflags() {
  var0 = getEntArray("cop_flag", "targetname");
  var1 = getEntArray("cop_flag_override", "targetname");

  if(var0.size == 0) {
    return;
  }

  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var2 = var0[var3];
  }

  var4 = [];

  if(var1.size > 0) {
    foreach(var6 in var1) {
      var7 = var6.script_noteworthy;
      var4 = var6;
    }
  }

  foreach(var6 in var2) {
    var7 = var6.script_noteworthy;

    if(isDefined(var4[var7])) {
      var6 = var4[var7];
    }

    var6.objectivekey = var7;
    mapobjectiveicon(var6, var7);
    var10 = scripts\mp\gametypes\obj_dom::setupobjective(var6);
    var10.flagmodel delete();
    var10.flagmodel = undefined;
    var10.outlineent = undefined;
    dompoint_ondisableobjective(var10);
    level.objectives[var10.objectivekey] = var10;
    var10.onbeginuse = &dompoint_onbeginuse;
    var10.onuse = &dompoint_onuse;
    var10.onenduse = &dompoint_onenduse;
    var10.oncontested = &dompoint_oncontested;
    var10.onuncontested = &dompoint_onuncontested;
    var10.ondisableobjective = &dompoint_ondisableobjective;
    var10.onenableobjective = &dompoint_onenableobjective;
    var10.onactivateobjective = &dompoint_onactivateobjective;
    var10 thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
  }
}

function disabledomflagscriptable() {
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function setupareabrushes() {
  var0 = getEntArray("cop_zone_visual", "targetname");
  var1 = getEntArray("cop_zone_visual_contest", "targetname");
  var2 = getEntArray("cop_zone_visual_friend", "targetname");
  var3 = getEntArray("cop_zone_visual_enemy", "targetname");
  var4 = getEntArray("cop_zone_visual_friend_pulse", "targetname");
  var5 = getEntArray("cop_zone_visual_enemy_pulse", "targetname");

  foreach(var7 in level.objectives) {
    if(isDefined(var7.scriptable)) {
      var7.scriptable delete();
      var7.scriptable = undefined;
    }
  }

  if(isDefined(var0)) {
    foreach(var10 in var0) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].neutralbrush)) {
        level.objectives[var11].neutralbrush = [];
      }

      level.objectives[var11].neutralbrush[level.objectives[var11].neutralbrush.size] = var10;
      var10 hide();
    }

    foreach(var10 in var1) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].contestedbrush)) {
        level.objectives[var11].contestedbrush = [];
      }

      level.objectives[var11].contestedbrush[level.objectives[var11].contestedbrush.size] = var10;
      var10 hide();
    }

    foreach(var10 in var2) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].friendlybrush)) {
        level.objectives[var11].friendlybrush = [];
      }

      level.objectives[var11].friendlybrush[level.objectives[var11].friendlybrush.size] = var10;
      var10 hide();
    }

    foreach(var10 in var3) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].enemybrush)) {
        level.objectives[var11].enemybrush = [];
      }

      level.objectives[var11].enemybrush[level.objectives[var11].enemybrush.size] = var10;
      var10 hide();
    }

    foreach(var10 in var4) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].friendlypulsebrush)) {
        level.objectives[var11].friendlypulsebrush = [];
      }

      level.objectives[var11].friendlypulsebrush[level.objectives[var11].friendlypulsebrush.size] = var10;
      var10 hide();
    }

    foreach(var10 in var5) {
      var11 = var10.script_noteworthy;

      if(!isDefined(level.objectives[var11].enemypulsebrush)) {
        level.objectives[var11].enemypulsebrush = [];
      }

      level.objectives[var11].enemypulsebrush[level.objectives[var11].enemypulsebrush.size] = var10;
      var10 hide();
    }

    return;
  }
}

function setupteamoobtriggers() {
  var0 = getEntArray("cop_outofbounds", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;

    if(!isDefined(level.objectives[var3].oobtriggers)) {
      level.objectives[var3].oobtriggers = [];
    }

    if(isDefined(var2.target)) {
      var4 = getscriptablearray(var2.target, "targetname");
      var5 = [];

      foreach(var7 in var4) {
        var8 = var5.size;
        var5 = var7;

        if(isDefined(var7.script_noteworthy)) {
          var5[var8].drawcount = int(var7.script_noteworthy);
          continue;
        }

        var5[var8].drawcount = 1;
      }

      var2.visuals = var5;
      thread updateoobvisuals(var2);
    }

    level.objectives[var3].oobtriggers[var2.script_label] = var2;
  }
}

function validateobjectives() {
  if(level.objectives.size == 0) {} else if((level.objectives.size - 2) % 2 == 0) {}

  level.midpointobjectiveindex = int(floor((level.objectives.size - 2) / 2));
  level.currentobjectiveindex = level.midpointobjectiveindex;
  level.previousobjectiveindex = level.currentobjectiveindex;

  foreach(var1 in level.objectives) {
    if(level.cmdrules == 1) {
      if(var1.objectivekey == "_a" || var1.objectivekey == "_b") {
        continue;
      }
    }

    var2 = int(var1.objectivekey);
    var3 = int(clamp(floor(abs(var2 - 2)), 0, 2));
    var1.tierindex = var3;
    var1.activationdelay = level.tieractivationdelay[var3];
    var1.captureduration = level.tiercapturetime[var3];
    var1.holdtime = level.tierholdtime[var3];
    var1 scripts\mp\gameobjects::disableobject();
    var1.firsttime = 1;

    if(level.cmdrules == 1) {
      switch (var3) {
        case 1:
        case 0:
          var1 scripts\mp\gameobjects::setcapturebehavior("persistent");
          var1.ignorestomp = 1;
          break;
        case 2:
          if(var2 < level.midpointobjectiveindex) {
            var1.defaultownerteam = game["defenders"];
          } else {
            var1.defaultownerteam = game["attackers"];
          }

          break;
      }

      continue;
    }

    var1.firsttime = 1;
    var1 scripts\mp\gameobjects::setcapturebehavior("normal");

    if(var2 == level.midpointobjectiveindex) {
      continue;
    }

    if(var2 < level.midpointobjectiveindex) {
      var1.defaultownerteam = game["defenders"];
      continue;
    }

    var1.defaultownerteam = game["attackers"];
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

function updatecurrentobjective(var0) {
  if(level.forcedobjectiveindex != -1) {
    var0 = level.forcedobjectiveindex;
  }

  if(!isDefined(level.objectives[scripts\engine\utility::string(var0)])) {
    return;
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
  }

  level.previousobjectiveindex = level.currentobjectiveindex;
  level.currentobjectiveindex = var0;
  updatespectatorcamera("cop_" + level.currentobjectiveindex);
  level.currentobjective = level.objectives[scripts\engine\utility::string(var0)];
  setomnvar("ui_cmd_current_obj", var0);
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
    var1 = level.currentobjective.activationdelay;
    ui_updatezonetimer(var1);
    ui_updatezonetimerpausedness(0);
    ui_updatecmdownerteam("zone_activation_delay");
    ui_updatecmdcapturestatus("zone_activation_delay", 0);
    wait 3;
    showsplashtoteam("all", "cop_target");
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("allies", "next"), "allies", 1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("axis", "next"), "axis", 1);
    level.currentobjective.firsttime = 0;
    var2 = gettime();

    foreach(var4 in level.players) {
      var4.lastsitreptime = var2;
    }

    wait var1 - 3;
    level.activationdelaystarttime = undefined;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective)) {
    level.currentobjective[[level.currentobjective.onactivateobjective]]();
  }

  showsplashtoteam("all", "cop_activate");
  var6 = 0;

  switch (level.currentobjective.tierindex) {
    case 0:
      var6 = 0;
      break;
    case 1:
      var6 = 5;
      break;
    case 2:
      var6 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var6);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "allies", 0);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "axis", 0);
}

function getfirsttimevoforobjective(var0) {
  var1 = "cop_obj_" + level.currentobjectiveindex + "_" + level.mapname;
  return var1;
}

function getvoforobjective(var0, var1) {
  var2 = "";
  var3 = 0;
  var4 = var0 == "allies" && level.previousobjectiveindex > level.currentobjectiveindex || var0 == "axis" && level.previousobjectiveindex < level.currentobjectiveindex;

  if(var1 == "next" && level.currentobjective.firsttime) {
    var2 = getfirsttimevoforobjective(var0);
  } else {
    switch (level.currentobjectiveindex) {
      case 4:
      case 0:
        var3 = 0;

        switch (var1) {
          case "next":
            var2 = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var4, "_attack_", "_defend_") + level.mapname;
            break;
          case "bomb_planted":
            if(level.currentobjectiveindex == 0) {
              var2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var0 == "allies", "_atenemy", "_atfriendly");
            } else {
              var2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var0 == "axis", "_atenemy", "_atfriendly");
            }

            break;
          case "bomb_defused":
            var3 = 1;
            break;
        }

        break;
      case 3:
      case 2:
      case 1:
        switch (var1) {
          case "next":
            var2 = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var4, "_attack_", "_defend_") + level.mapname;
            break;
          case "hold_confirmed":
          case "enemy_sec":
          case "hold":
            var3 = 1;
            break;
        }

        break;
    }

    if(var2 == "") {
      if(var3) {
        var2 = "cop_" + var1;
      } else {
        var2 = "cop_obj_" + level.currentobjectiveindex + "_" + var1 + "_" + level.mapname;
      }
    }
  }

  return var2;
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(isDefined(var4) && scripts\mp\utility\weapon::iskillstreakweapon(var4.basename)) {
    return;
  }

  switch (level.currentobjective.id) {
    case "domFlag":
      scripts\mp\gametypes\obj_dom::awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
      break;
    case "bomb_zone":
      scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var1, self);
      break;
  }
}

function onplayerconnect(var0) {
  var0.ui_dom_securing = undefined;
  var0.ui_dom_stalemate = undefined;

  foreach(var2 in level.objectives) {
    if(isDefined(var2.neutralbrush)) {
      hidebrushes(var2, var0);
    }
  }

  thread updatefloorbrushwaitforjoined();
}

function decayholdtime(var0) {
  self endon("domPoint_HoldTimer");

  for(;;) {
    if(isDefined(var0)) {
      self.teamholdtimers[var0] -= level.framedurationseconds;

      if(self.teamholdtimers[var0] <= 0) {
        self.teamholdtimers[var0] = 0;
        break;
      }
    }

    waitframe();
  }
}

function dompoint_holdtimer(var0, var1) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  level.inobjectiveot = 0;
  ui_updatecmdownerteam(var0);

  if(istrue(level.persistentdomtimer)) {
    var2 = self.teamholdtimers[var0];
    self.holdteam = var0;
  } else {
    var2 = level.currentobjective.holdtime;
  }

  var3 = scripts\mp\utility\game::getotherteam(var1)[0];

  if(var2 > 0) {
    thread decayholdtime(var1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var3, "enemy_hold"), var3, 1);
    var4 = 0;

    if(level.currentobjectiveindex != 2 && var2 > 5) {
      var5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var1);

      if(isDefined(var5)) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var5, getcapturedialog("captured"));
        var4 += getselfobjcaptureddialog(var5, "captured");
      }
    }

    if(var4 > 0) {
      wait var4;
    }

    var6 = 0;
    var5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var1);

    if(isDefined(var5) && var2 > 5 + var4) {
      var6 = level thread scripts\mp\battlechatter_mp::trysaylocalsound(var5, "cop_confirm_copsecureask");

      if(!isDefined(var6)) {
        var6 = 0;
      }
    }

    var4 += var6;
    wait var6;

    if(var2 > 5 + var4) {
      scripts\mp\utility\dialog::statusdialog(getvoforobjective(var1, "hold"), var1, 1);
    }

    if(var2 - var4 > 0) {
      wait var2 - var4;
    } else {
      wait var2;
    }

    var3 = scripts\mp\utility\game::getotherteam(var1)[0];

    if(istrue(level.controltoprogress) && level.currentobjective.touchlist[var3].size > 0) {
      level.inobjectiveot = 1;
      ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);

      for(;;) {
        if(level.currentobjective.touchlist[var3].size == 0) {
          break;
        }

        waitframe();
      }

      level.inobjectiveot = 0;
    }
  }

  var7 = 0;
  var8 = level.currentobjectiveindex;

  if(var1 == game["attackers"]) {
    var8--;

    if(level.currentobjectiveindex <= level.midpointobjectiveindex) {
      var7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var1, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var1)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent)) {
          level.propagandaent stoploopsound();
        }
      }
    }
  } else {
    var8++;

    if(level.currentobjectiveindex >= level.midpointobjectiveindex) {
      var7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var1, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var1)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent)) {
          level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
        }
      }
    }
  }

  if(0 && var7) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1, 1, 0);
  }

  if(self.tierindex == 0) {
    if(isDefined(var2)) {
      thread givekillstreak(var2, "uav");
    } else {
      var5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var1);
      thread givekillstreak(var5, "uav");
    }
  }

  updateteamscores();

  if(var2 > 0) {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var1, "hold_confirmed"), var1, 1);
  }

  showsplashtoteam(var1, "cop_captured_friendly");
  showsplashtoteam(var3, "cop_captured_enemy");

  if(level.forcedobjectiveindex != -1) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1, 1, 0);
    cmd_endgame(var1, game["end_reason"]["target_destroyed"]);
    return;
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1, 1, 0);
    return;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
    level.extratime += 90;
    var9 = scripts\mp\gamelogic::gettimeremaining();
    setgameendtime(gettime() + int(var9));
    level scripts\mp\gamelogic::resumetimer();
  }

  updatecurrentobjective(var8);
}

function dompoint_cancelholdtimer() {
  if(!istrue(level.persistentdomtimer)) {
    return;
  }

  var0 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.holdteam) && self.holdteam == var0) {
    ui_updatezonetimerpausedness(1);
    self notify("domPoint_HoldTimer");
    self.holdteam = undefined;
    return;
  }
}

function givekscratetoteam(var0, var1, var2) {}

function createkscrate(var0, var1, var2) {}

function cratethink(var0, var1) {
  self endon("restarting_physics");
  self endon("death");
  var2 = scripts\engine\utility::drop_to_ground(self.origin + (7, 9, 0), 50, -200, (0, 0, 1));
  var3 = spawn("script_model", var2 + (0, 0, 0));
  var3 setModel("offhand_wm_grenade_smoke");
  var3.angles = self.angles + (-80, 120, 90);
  var4 = spawn("script_model", var3.origin);
  var4 setModel("tag_origin");
  var4.angles = self.angles + (0, 30, 0);
  var4 playLoopSound("mp_flare_burn_lp");
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var4, "tag_origin");
  var5 = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var6 = undefined;

  switch (var1) {
    case "juggernaut":
      var5 = &"KILLSTREAKS_HINTS/JUGGERNAUT_PICKUP_GL";
      var6 = "icon_ks_jugg";
      break;
    case "cruise_predator":
      var5 = &"KILLSTREAKS_HINTS/CRUISE_PREDATOR_PICKUP_GL";
      var6 = "hud_icon_killstreak_cruise_missile";
      break;
    case "chopper_gunner":
      var5 = &"KILLSTREAKS_HINTS/CHOPPER_GUNNER_PICKUP_GL";
      var6 = "hud_icon_killstreak_apache";
      break;
  }

  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 24, "HINT_BUTTON", var6, var5, -1, undefined, "show", 250, 360, 100, 360);
  self.useobj linkTo(self);
  jumpiffalse(var1 == "juggernaut") LOC_00000187;
  thread gainedjuggupdater(var0);
  thread removedjuggupdater(var0);

  for(;;) {
    self waittill("captured", var7);

    if(isPlayer(var7)) {
      var7 setclientomnvar("ui_securing", 0);
      var7.ui_securing = undefined;
    }

    switch (var1) {
      case "juggernaut":
        break;
      case "cruise_predator":
        thread givekillstreak(var7, "cruise_predator");
        wait 3;
        break;
      case "chopper_gunner":
        thread givekillstreak(var7, "chopper_gunner");
        wait 3;
        break;
    }

    var7 playlocalsound("ammo_crate_use");
    stopFXOnTag(level._effect["vfx_smk_signal"], var4, "tag_origin");
    var4 stoploopsound();
    var4 delete();
    var4 = undefined;
    var3 delete();
    var3 = undefined;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
    LOC_00000249:
  }
}

function gainedjuggupdater(var0) {
  self endon("death");

  foreach(var2 in level.players) {
    if(var2.team == var0 && istrue(var2.isjuggernaut)) {
      self disableplayeruse(var2);
    }
  }

  for(;;) {
    level waittill("gained_juggernaut", var2);

    if(var2.team == var0) {
      self disableplayeruse(var2);
    }
  }
}

function removedjuggupdater(var0) {
  self endon("death");

  for(;;) {
    level waittill("removed_juggernaut", var1);

    if(var1.team == var0) {
      self enableplayeruse(var1);
    }
  }
}

function givekillstreak(var0, var1) {
  var2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var0);
  scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var2, "other");

  if(istrue(var1)) {
    wait 0.1;
    self notify("ks_action_4");
    return;
  }
}

function bombzone_warningklaxon() {
  level endon("game_ended");
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  var0 = game["music"]["cop_finalpush"].size;
  var1 = randomint(var0);

  foreach(var3 in level.players) {
    var3 setplayermusicstate(game["music"]["cop_finalpush"][var1]);
  }

  wait 2;
  wait 16;
}

function bombzone_holdtimer(var0) {
  if(!isDefined(level.currentobjective)) {
    return;
  }

  level endon("gameEnded");
  level endon("bomb_planted");
  self notify("bombZone_HoldTimer");
  self endon("bombZone_HoldTimer");
  var1 = level.currentobjective.defaultownerteam;
  var2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var2);
  level.timelimitoverride = 0;

  if(var0 > 0) {
    ui_updatezonetimer(var0);
    wait var0;

    if(istrue(level.controltoprogress)) {
      var2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
      var3 = 0;

      for(;;) {
        if(!var3) {
          var3 = 1;
          ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);
        }

        if(level.currentobjective.touchlist[var2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  foreach(var5 in level.players) {
    var5 setplayermusicstate("mus_mp_cop_bombplant_end");
  }

  thread scripts\mp\music_and_dialog::suspensemusic();
  var7 = level.currentobjectiveindex;
  var8 = level.currentobjective scripts\mp\gameobjects::getownerteam();

  if(var8 == game["attackers"]) {
    var7--;
  } else {
    var7++;
  }

  updatecurrentobjective(var7);
}

function bombhandler(var0, var1, var2) {
  if(level.gameended) {
    return;
  }

  if(var1 == "explode") {
    self.bombexploded = 1;
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    scripts\mp\gamescore::giveteamscoreforobjective(var2, 1, 0);
    cmd_endgame(var2, game["end_reason"]["target_destroyed"]);
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

function cmd_endgame(var0, var1) {
  level.docmdoutro = 1;
  var2 = undefined;

  if(level.mapname == "mp_faridah") {
    var2 = spawnStruct();

    if(var0 == "allies") {
      var2.origin = (-207, -4711, 211);
      var2.angles = (7, 64, 0);
    } else if(var0 == "axis") {
      var2.origin = (1945, 4423, 670);
      var2.angles = (15, 244, 0);
    }
  }

  foreach(var4 in level.players) {
    if(!isai(var4)) {
      var4 setclientomnvar("ui_objective_state", 0);
    }

    thread playendofmatchtransition(var4);
  }

  var6 = game["teamScores"][var0];
  var7 = game["teamScores"][scripts\mp\utility\game::getotherteam(var0)[0]];

  if(var7 > var6) {
    var8 = var7 - var6 + 1;
    scripts\mp\gamescore::giveteamscoreforobjective(var0, var8, 0);
  }

  thread scripts\mp\gamelogic::endgame(var0, var1);
  wait 0.65;
  level notify("allow_bomb_explosion");
  wait 5;
  level notify("cmd_continue_game_end");
}

function dompoint_onbeginuse(var0) {
  dompoint_cancelholdtimer();
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var0);
  self.didstatusnotify = 1;
  thread updateflares(var0.team);
  ui_updatecmdcapturestatus(var0.team, self.stalemate);

  if(var0.team == game["attackers"]) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
      var1 = scripts\mp\gameobjects::getownerteam();

      if(var0.team != var1) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, getcapturedialog("capturing"));
        getselfobjcaptureddialog(var0, "planting");
      } else {
        getselfobjcaptureddialog(var0, "defusing");
      }
    } else {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, getcapturedialog("capturing"));
    }
  }

  var2 = scripts\mp\utility\game::getotherteam(var0.team)[0];

  if(var2 == scripts\mp\gameobjects::getownerteam()) {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var0.team, "enemy_cap"), var2, 0);
  } else {
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var0.team, "enemy_sec"), var2, 0);
  }

  foreach(var0 in level.players) {
    updatefloorbrush(var0);
  }
}

function dompoint_onuse(var0) {
  if(istrue(level.persistentdomtimer)) {
    ui_updatezonetimerpausedness(0);
    self.lastcaptime = gettime();
    self.firstcapture = 0;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);
  var1 = scripts\mp\gameobjects::getownerteam();
  thread updateflares(var1);

  foreach(var3 in level.players) {
    updatefloorbrush(var3);
  }

  level.usestartspawns = 0;
  var5 = scripts\mp\utility\game::getotherteam(var1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var5, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.cmdattackingteam = var1;
      level.cmddefendingteam = var5;
      level scripts\mp\gamelogic::pausetimer();
    } else {
      level.extratime += 90;
      var6 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(var6));
    }
  }

  if(level.currentobjectiveindex == 0) {
    var7 = level.objectives["_b"] scripts\mp\gameobjects::getownerteam();

    if(var1 != var7) {
      bombzone_onuseplantobject(level.objectives["_b"], var0);
    } else {
      bombzone_onusedefuseobject(level.objectives["_b"], var0);
    }
  } else if(level.currentobjectiveindex == 4) {
    var7 = level.objectives["_a"] scripts\mp\gameobjects::getownerteam();

    if(var1 != var7) {
      bombzone_onuseplantobject(level.objectives["_a"], var0);
    } else {
      bombzone_onusedefuseobject(level.objectives["_a"], var0);
    }
  } else {
    thread dompoint_holdtimer(var1, var0);
    showsplashtoteam(var1, "cop_hold_friendly");
    showsplashtoteam(var5, "cop_hold_enemy");
  }

  if(self == level.currentobjective) {
    ui_updatecmdcapturestatus("neutral", 0);
    return;
  }
}

function dompoint_onenduse(var0, var1, var2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
  var3 = scripts\mp\gameobjects::getownerteam();
  var4 = scripts\engine\utility::ter_op(var3 == "neutral", "idle", var3);
  thread updateflares(var4);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      var3 = scripts\mp\gameobjects::getownerteam();
      ui_updatecmdcapturestatus("neutral", 0);

      if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
        if(var3 != "neutral") {
          ui_updatezonetimerpausedness(0);
          self.lastcaptime = gettime();
          thread dompoint_holdtimer(var3);
        }
      }
    }
  } else if(!var2) {
    var3 = scripts\mp\gameobjects::getownerteam();
    ui_updatecmdcapturestatus("neutral", 0);

    if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
      if(var3 != "neutral") {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var3);
      }
    }
  }

  foreach(var1 in level.players) {
    updatefloorbrush(var1);
  }
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  dompoint_cancelholdtimer();
  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
  thread updateflares("contested");
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  ui_updatecmdcapturestatus(var0, 1);
  var1 = var0;

  if(var0 == "neutral") {
    var1 = self.claimteam;
  }

  if(var1 != "none") {
    scripts\mp\utility\dialog::statusdialog("cop_obj_contested", var1, 0);
  }

  foreach(var3 in level.players) {
    updatefloorbrush(var3);
  }
}

function dompoint_onuncontested(var0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var0);
  self.didstatusnotify = 1;
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  var2 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  thread updateflares(var2);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      if(var1 != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(var1)[0]].size == 0) {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var1);
      }
    }
  } else if(istrue(level.persistentdomtimer) && level.currentobjectiveindex != 0 && level.currentobjectiveindex != 4) {
    if(var1 != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(var1)[0]].size == 0) {
      ui_updatezonetimerpausedness(0);
      self.lastcaptime = gettime();
      thread dompoint_holdtimer(var1);
    }
  }

  ui_updatecmdcapturestatus("neutral", 0);

  foreach(var4 in level.players) {
    updatefloorbrush(var4);
  }
}

function dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, &disabledomflagscriptable);
  thread updateflares("off");

  foreach(var1 in level.players) {
    updatefloorbrush(var1, 1);
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

  foreach(var1 in level.players) {
    updatefloorbrush(var1);
  }
}

function dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  var0 = scripts\mp\gameobjects::getownerteam();
  ui_updatecmdownerteam(var0);
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

function bombzone_onbeginuse(var0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var0);
}

function bombzone_onenduse(var0, var1, var2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var0, var1, var2);
}

function bombzone_onuseplantobject(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var1);
  showsplashtoteam("all", "cop_planted");
  level.flagcapturetime = 15;

  if(istrue(level.persistentbombtimer)) {
    if(!isDefined(level.basefusetimers)) {
      level.basefusetimers = [];
      level.basefusetimers["allies"] = level.bombtimer;
      level.basefusetimers["axis"] = level.bombtimer;
    }

    level.bombtimer = level.basefusetimers[var1];
    level.lastbombplanttime = gettime();
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(var0);
  var3 = game["music"]["cop_bombplant"].size;
  var4 = randomint(var3);

  foreach(var6 in level.players) {
    var6 setplayermusicstate(game["music"]["cop_bombplant"][var4]);
  }

  if(var0.team == "allies") {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, getcapturedialog("planted"));
  }

  if(false) {
    scripts\mp\gamescore::giveteamscoreforobjective(var0.team, 1, 0);
  }

  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var1, "bomb_planted"), var1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var2, "bomb_planted"), var2, 1);

  if(isDefined(level.zoneendtime)) {
    level.zoneendtime = int(level.zoneendtime - gettime());
  }

  if(level.cmdrules == 1) {
    ui_updatebombtimer();
  }

  ui_updatecmdownerteam(var0.team);
}

function bombzone_onusedefuseobject(var0) {
  if(!level.bombplanted) {
    return;
  }

  showsplashtoteam("all", "cop_defused");
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  level.flagcapturetime = 5;

  if(istrue(level.persistentbombtimer)) {
    level.basefusetimers[var1] -= (gettime() - level.lastbombplanttime) / 1000;
  }

  level.bombsplanted -= 1;

  if(self.objectivekey == "_a") {
    level.aplanted = 0;
  } else {
    level.bplanted = 0;
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onusedefuseobject(var0);

  if(scripts\mp\utility\game::getotherteam(var0.team)[0] == "allies") {
    var3 = getclosestplayeronteam(level.currentobjective.trigger.origin, scripts\mp\utility\game::getotherteam(var0.team)[0]);

    if(isDefined(var3)) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var3, getcapturedialog("defused"));
    }
  }

  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var1, "bomb_defused"), var1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var2, "bomb_defused"), var2, 1);
  var0 notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone();

  if(isDefined(level.zoneendtime)) {
    thread bombzone_holdtimer(level.zoneendtime / 1000);
  }

  ui_updatecmdownerteam(var0.team);
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

function ui_updatezonetimer(var0) {
  level.zoneendtime = int(gettime() + 1000 * var0);
  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

function ui_updatebombtimer() {
  var0 = int(gettime() + 1000 * level.bombtimer);
  setomnvar("ui_hardpoint_timer", var0);
}

function ui_updatezonetimerpausedness(var0) {
  setomnvar("ui_objective_timer_stopped", var0);
}

function getownerteamplayer(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      return var3;
    }
  }

  return var1;
}

function ui_updatecmdcapturestatus(var0, var1) {
  var2 = -1;

  if(istrue(level.inobjectiveot)) {
    if(var1) {
      var2 = -4;
    } else {
      var2 = -5;
    }
  } else if(var1) {
    var2 = -2;
  } else {
    switch (var0) {
      case "allies":
        var2 = 2;
        break;
      case "axis":
        var2 = 1;
        break;
      case "zone_activation_delay":
        var2 = -3;
        break;
      case "overtime":
        var2 = -4;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_cmd_capture_team", var2);
}

function ui_updatecmdownerteam(var0) {
  var1 = -1;

  switch (var0) {
    case "allies":
      var1 = 2;
      break;
    case "axis":
      var1 = 1;
      break;
    case "zone_activation_delay":
      var1 = -3;
      break;
    case "zone_shift":
    default:
      break;
  }

  setomnvar("ui_cmd_owner_team", var1);
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

  var0 = getcenterfrac(level.currentobjectiveindex);
  var1 = 0;
  var2 = level.currentobjective scripts\mp\gameobjects::getownerteam();
  var3 = 0;
  var4 = 0.03;
  var5 = 0;

  if(isDefined(level.activationdelaystarttime) && level.previousobjectiveindex != level.currentobjectiveindex) {
    if(isDefined(level.currentobjective.defaultownerteam)) {
      var1 = var4;

      if(var2 == "allies") {
        var1 *= -1;
      }

      var4 *= 2;
    }

    var3 = 1;
    var6 = gettime();
    var7 = (var6 - level.activationdelaystarttime) / level.currentobjective.activationdelay * 1000;
    var5 = (abs(getcenterfrac(level.previousobjectiveindex) - var0) - var4) * var7;

    if(level.currentobjectiveindex < level.previousobjectiveindex) {
      var5 *= -1;
      var4 *= -1;
    }

    var0 = getcenterfrac(level.previousobjectiveindex);
  } else {
    var2 = level.currentobjective scripts\mp\gameobjects::getownerteam();

    if(var2 != "neutral") {
      var1 = var4;

      if(var2 == "allies") {
        var1 *= -1;
      }

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam != var2) {
          var4 *= 2;
          var3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

          if(level.currentobjective.claimteam == "allies") {
            var3 *= -1;
          }
        }
      }
    } else {
      var3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam == "allies") {
          var3 *= -1;
        }
      } else if(isDefined(level.currentobjective.lastclaimteam)) {
        if(level.currentobjective.lastclaimteam == "allies") {
          var3 *= -1;
        }
      }
    }
  }

  return var0 + var1 + var3 * var4 + var5;
}

function getcenterfrac(var0) {
  var1 = 0;

  switch (var0) {
    case 0:
      var1 = 0;
      break;
    case 1:
      var1 = 0.25;
      break;
    case 2:
      var1 = 0.5;
      break;
    case 3:
      var1 = 0.75;
      break;
    case 4:
      var1 = 1;
      break;
  }

  return var1;
}

function updateteamscores() {
  if(true) {
    scripts\mp\gamescore::_setteamscore("allies", 0, 0);
    scripts\mp\gamescore::_setteamscore("axis", 0, 0);
    return;
  }
}

function spawnjuggcate(var0, var1) {
  var2 = level.juggspawnbehavior;

  if(var1 == "attacker" && var2 != 1 && var2 != 3) {
    return;
  }

  if(var1 == "defender" && var2 != 2 && var2 != 3) {
    return;
  }

  if(!isDefined(level.juggcrates)) {
    level.juggcrates = [];
    level.juggcrates["allies"] = [];
    level.juggcrates["axis"] = [];
  }

  if(isDefined(level.juggcrates[var0][var1])) {
    return;
  }

  var3 = undefined;

  switch (level.mapname) {
    case "mp_faridah":
      if(var1 == "attacker") {
        if(var0 == "allies") {
          var3 = (250, -2040, 215);
        } else {
          var3 = (786, 2413, 260);
        }
      } else if(var1 == "defender") {
        if(var0 == "allies") {
          var3 = (25, -4630, 10);
        } else {
          var3 = (1480, 4375, -40);
        }
      }

      break;
    case "mp_anvil":
      if(var1 == "attacker") {
        if(var0 == "allies") {
          var3 = (2775, 2375, 360);
        } else {
          var3 = (-60, -260, 450);
        }
      } else if(var1 == "defender") {
        if(var0 == "allies") {
          var3 = (-2680, -855, 250);
        } else {
          var3 = (2365, 4360, 360);
        }
      }

      break;
  }

  if(isDefined(var3)) {
    level.juggcrates[var0][var1] = givekscratetoteam(var0, var3, "juggernaut");
    thread removeondeath(level.juggcrates[var0][var1], var0);
    return;
  }
}

function removeondeath(var0, var1) {
  level endon("game_ended");
  self waittill("death");
  level.juggcrates[var0][var1] = undefined;
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
  var0 = "iw8_lm_kilo121_mp";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0);
  self givemaxammo(var0);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var0);
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

function updatefloorbrush(var0, var1) {
  if(!isDefined(self.neutralbrush)) {
    return;
  }

  var2 = self.ownerteam;
  var3 = self.claimteam;
  var4 = var0.team;
  var5 = var0 ismlgspectator();

  if(var5) {
    var4 = var0 getmlgspectatorteam();
  }

  if(istrue(var1)) {
    hidebrushes(var0);
  } else if(istrue(self.stalemate)) {
    showcontestedbrush(var0);
  } else if(var2 == "neutral") {
    if(var3 != "none") {
      if(var4 == var3) {
        showfriendlybrush(var0);
      } else {
        showenemybrush(var0);
      }
    } else {
      showneutralbrush(var0);
    }
  } else if(var4 == var2) {
    showfriendlybrush(var0);
  } else {
    showenemybrush(var0);
  }

  updatecapturebrush(var0);
}

function updatecapturebrush(var0) {
  if(true) {
    return;
  }

  if(!isDefined(self.neutralbrush)) {
    return;
  }

  var1 = scripts\mp\gameobjects::getclaimteam();
  var2 = var0.team;
  var3 = var0 ismlgspectator();

  if(var3) {
    var2 = var0 getmlgspectatorteam();
  }

  if(istrue(self.stalemate)) {
    hidecapturebrush(var0);
    return;
  }

  if(var1 == "none") {
    hidecapturebrush(var0);
    return;
  }

  if(var2 == var1) {
    showfriendlycapturebrush(var0);
    return;
  }

  showenemycapturebrush(var0);
}

function showneutralbrush(var0) {
  foreach(var2 in self.friendlybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.contestedbrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.neutralbrush) {
    var2 showtoplayer(var0);
  }
}

function showfriendlybrush(var0) {
  foreach(var2 in self.friendlybrush) {
    var2 showtoplayer(var0);
  }

  foreach(var2 in self.enemybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.contestedbrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.neutralbrush) {
    var2 hidefromplayer(var0);
  }
}

function showenemybrush(var0) {
  foreach(var2 in self.friendlybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemybrush) {
    var2 showtoplayer(var0);
  }

  foreach(var2 in self.contestedbrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.neutralbrush) {
    var2 hidefromplayer(var0);
  }
}

function showcontestedbrush(var0) {
  foreach(var2 in self.friendlybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.contestedbrush) {
    var2 showtoplayer(var0);
  }

  foreach(var2 in self.neutralbrush) {
    var2 hidefromplayer(var0);
  }
}

function hidebrushes(var0) {
  foreach(var2 in self.friendlybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemybrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.contestedbrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.neutralbrush) {
    var2 hidefromplayer(var0);
  }
}

function showfriendlycapturebrush(var0) {
  foreach(var2 in self.friendlypulsebrush) {
    var2 showtoplayer(var0);
  }

  foreach(var2 in self.enemypulsebrush) {
    var2 hidefromplayer(var0);
  }
}

function showenemycapturebrush(var0) {
  foreach(var2 in self.friendlypulsebrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemypulsebrush) {
    var2 showtoplayer(var0);
  }
}

function hidecapturebrush(var0) {
  foreach(var2 in self.friendlypulsebrush) {
    var2 hidefromplayer(var0);
  }

  foreach(var2 in self.enemypulsebrush) {
    var2 hidefromplayer(var0);
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
  var0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var1 = var0.origin;
  var2 = var0.angles;
  self.deathspectatepos = var1;
  self.deathspectateangles = var2;
  var3 = spawn("script_model", self getvieworigin());
  var3 setModel("tag_origin");
  var3.angles = var2;
  self.spectatorcament = var3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var3, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var3, self, var1, var2);
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

function updatespectatorcamera(var0) {
  level.currentspectatorcamref = var0;

  foreach(var2 in level.players) {
    if(isDefined(var2.spectatorcament)) {
      var3 = var2.team;
      var4 = getdvarint("scr_cmd_camera_team", -1);

      if(var4 != -1) {
        var3 = scripts\engine\utility::ter_op(var4 == 0, "allies", "axis");
      }

      var5 = level.spectatorcameras[level.currentspectatorcamref][var3];
      movecameratomappos(var2.spectatorcament, var2, var5.origin, var5.angles);
    }
  }
}

function movecameratomappos(var0, var1, var2) {
  var0 endon("spawned_player");
  var3 = 1;
  var4 = 1;
  self moveTo(var1, 1, 0.5, 0.5);
  var0 playlocalsound("mp_cmd_camera_zoom_out");
  var0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var2, 1, 0.5, 0.5);
  thread startoperatorsound();
  wait 1.1;
  var5 = anglesToForward(var2) * 300;
  var5 *= (1, 1, 0);

  if(isDefined(var0) && isDefined(var0.spectatorcament)) {
    self moveTo(var1 + var5, 15, 1, 1);
    var0 earthquakeforplayer(0.03, 15, var1 + var5, 1000);
    return;
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  var0 = self getEye();
  var1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(var0, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
  wait 1;
  var2 = gettime();

  if(!isDefined(self.lastsitreptime) || var2 < self.lastsitreptime + 30000 || var2 < level.lastteamstatustime[self.team] + 5000) {
    return;
  }

  scripts\mp\utility\dialog::sitrepdialogonplayer(getsitreplocname());
  thread playselfbattlechatter(self, "plrresponse_affirm", "cop_affirm_2d", 2.5, 1);
}

function playslamzoomflash() {
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0 setshader("white", 640, 480);
  var0 fadeovertime(0.4);
  var0.alpha = 0;
  wait 0.4;
  var0 destroy();
}

function startoperatorsound() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

function ongameended() {
  level waittill("game_ended");

  foreach(var1 in level.objectives) {
    var1 scripts\mp\gameobjects::setvisibleteam("none");
  }
}

function playendofmatchtransition(var0) {
  self setclientomnvar("ui_total_fade", 0);
  waitframe();
  var1 = 10;
  var2 = var1;

  for(var2 = 1; var2 <= var1; var2++) {
    waitframe();
    self setclientomnvar("ui_total_fade", var2 / var1);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote() && isDefined(var0)) {
    var3 = distance2dsquared(self.origin, var0.origin);

    if(var3 > 40000) {
      var4 = self cloneplayer(0);
      var4 startragdoll(1);
    }
  }

  thread scripts\mp\playerlogic::spawnintermission(var0, "spectator");
  waitframe();
  var1 = 4;
  var2 = var1;

  for(var2 = var1 - 1; var2 >= 0; var2--) {
    waitframe();
    self setclientomnvar("ui_total_fade", var2 / var1);
  }
}

function getsitreplocname() {
  var0 = "sitrep_" + level.currentobjectiveindex + "_" + level.mapname;
  return var0;
}

function getcapturedialog(var0) {
  var1 = "cop_obj_" + level.currentobjectiveindex + "_" + var0 + "_" + level.mapname;
  return var1;
}

function getselfobjcaptureddialog(var0) {
  var1 = "";
  var2 = "";
  var3 = 0;

  switch (level.currentobjectiveindex) {
    case 0:
      if(var0 == "planting") {
        var1 = "arming_bomb";
        var2 = "cop_arming_bomb_2d";
        var3 = 1;
      } else if(var0 == "defusing") {
        var1 = "bomb_defusing";
        var2 = "cop_bomb_defusing_2d";
        var3 = 1;
      }

      break;
    case 1:
      if(var0 == "capturing") {
        var2 = "";
      } else if(var0 == "captured") {
        if(self.team == "axis") {
          var1 = "objsecured_generic";
          var2 = "cop_generic_captured_2d";
        } else if(level.mapname == "mp_faridah") {
          var1 = "objsecured_school";
          var2 = "cop_school_captured_2d";
        } else {
          var1 = "objsecured_generic";
          var2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 2:
      if(var0 == "capturing") {
        var2 = "";
      } else if(var0 == "captured") {
        var1 = "objsecured_generic";
        var2 = "cop_generic_captured_2d";
      }

      break;
    case 3:
      if(var0 == "capturing") {
        var2 = "";
      } else if(var0 == "captured") {
        if(level.mapname == "mp_faridah") {
          var1 = "objsecured_warehouse";
          var2 = "cop_warehouse_captured_2d";
        } else {
          var1 = "objsecured_generic";
          var2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 4:
      if(var0 == "planting") {
        var1 = "arming_bomb";
        var2 = "cop_arming_bomb_2d";
        var3 = 1;
      } else if(var0 == "defusing") {
        var1 = "bomb_defusing";
        var2 = "cop_bomb_defusing_2d";
        var3 = 1;
      }

      break;
  }

  var4 = 0;

  if(var3 && !scripts\mp\battlechatter_mp::saidtoorecently(var2)) {
    scripts\mp\battlechatter_mp::updatechatter(var2);
    thread playselfbattlechatter(self, var1, var2, 1.5);
  } else if(!var3) {
    thread playselfbattlechatter(self, var1, var2, 1.5);
  }

  var5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "afp1");
  }

  var6 = "dx_mpp_" + var5 + "_" + var1;
  return lookupsoundlength(var6) / 1000;
}

function playselfbattlechatter(var0, var1, var2, var3, var4) {
  if(isai(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death");

  if(isDefined(var3)) {
    wait var3;
  }

  var5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var5 = scripts\engine\utility::ter_op(var0.team == "allies", "usp1", "afp1");
  }

  var6 = "dx_mpp_" + var5 + "_" + var1;

  if(isDefined(var4)) {
    var7 = var6;

    if(soundexists(var7)) {
      var6 = var7;
    }
  }

  var0 queuedialogforplayer(var6, var2, 2);
}

function getclosestplayeronteam(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.players) {
    if(var5.team == var1 && scripts\mp\utility\player::isreallyalive(var5)) {
      var6 = distance2dsquared(var5.origin, var0);

      if(!isDefined(var3) || var6 < var3) {
        var2 = var5;
        var3 = var6;
      }
    }
  }

  return var2;
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, spawnflare((350, -3580, -35), (0, -151, 0)));
}

function spawnflare(var0, var1, var2) {
  var3 = var0;

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    var3 = scripts\engine\utility::drop_to_ground(var0, 50, -200, (0, 0, 1));
  }

  var4 = spawn("script_model", var3 + (0, 0, 2));
  var4.angles = var1 + (0, 180, 0);
  var4 setModel("cop_marker_scriptable");
  return var4;
}

function updateflares(var0) {
  if(getdvarint("scr_cop_flares", 0) != 1) {
    return;
  }

  self notify("updateFlares");
  self endon("updateFlares");

  while(!isDefined(self.scriptables)) {
    waitframe();
  }

  foreach(var2 in self.scriptables) {
    var2 setscriptablepartstate("marker", var0);
  }
}

function debugcaptureflares() {
  var0 = 0;

  for(;;) {
    var1 = 0;

    switch (var0) {
      case 0:
        var1 = "allies";
        break;
      case 1:
        var1 = "axis";
        break;
      case 2:
        var1 = "contested";
        break;
      case 3:
        var1 = "idle";
        break;
    }

    foreach(var3 in level.objectives) {
      if(!isDefined(var3.scriptables)) {
        continue;
      }

      foreach(var5 in var3.scriptables) {
        var5 setscriptablepartstate("marker", var1);
      }
    }

    var0++;

    if(var0 > 3) {
      var0 = 0;
    }

    wait 3;
  }
}

function mapobjectiveicon(var0) {
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

  foreach(var1 in level.players) {
    if(isDefined(level.currentobjective.oobtriggers["allies"])) {
      thread updateoobvisuals(level.currentobjective.oobtriggers["allies"]);
    }

    if(isDefined(level.currentobjective.oobtriggers["axis"])) {
      thread updateoobvisuals(level.currentobjective.oobtriggers["axis"]);
    }
  }
}

function updateoobvisuals(var0) {
  self notify("updateOOBVisuals");
  self endon("updateOOBVisuals");

  while(!isDefined(self.visuals)) {
    waitframe();
  }

  foreach(var2 in self.visuals) {
    for(var3 = 0; var3 < var2.drawcount; var3++) {
      var2 setscriptablepartstate("chevron_" + var3, var0);
    }
  }

  level waittill("updateOOBTriggers");

  foreach(var2 in self.visuals) {
    for(var3 = 0; var3 < var2.drawcount; var3++) {
      var2 setscriptablepartstate("chevron_" + var3, "off");
    }
  }
}

function awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var0 = 1;
  var1 = 1;

  while(!level.gameended) {
    for(var2 = 0; var2 < var0; var2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var2 += level.framedurationseconds;

      if(self.stalemate) {}
    }

    var3 = self.claimteam;

    if(var3 == "none") {
      continue;
    }

    if(!self.stalemate) {
      foreach(var5 in self.touchlist[var3]) {
        var5.player thread scripts\mp\utility\points::giveunifiedpoints("cop_in_obj");
      }
    }
  }
}

function showsplashtoteam(var0, var1) {
  foreach(var3 in level.players) {
    if(var0 == "all" || var3.team == var0) {
      var3 thread scripts\mp\hud_message::showsplash(var1);
    }
  }
}