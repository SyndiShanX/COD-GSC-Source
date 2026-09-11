/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rugby.gsc
***********************************************/

function main() {
  var_0 = spawnStruct();
  level.rugby = var_0;
  var_0.endzones = [];
  var_0.endzones["allies"] = [];
  var_0.endzones["axis"] = [];
  var_0.juggcratesetups = [];
  var_0.goals = [];
  var_0.activejuggcrates = [];
  var_0.activejuggernauts = [];
  var_0.lastjuggpositions = [];
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initrules() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 240);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.ontimelimitgraceperiod = remove_steam_damage();
  level.currenttimelimitdelay = 0;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("rugbyData", "juggHealth");
  setdynamicdvar("scr_rugby_juggHealth", var_0);
  var_1 = getmatchrulesdata("rugbyData", "juggSpeed");
  setdynamicdvar("scr_rugby_juggSpeed", var_1);
  var_2 = getmatchrulesdata("rugbyData", "juggTeamSpeed");
  setdynamicdvar("scr_rugby_juggTeamSpeed", var_2);
  var_3 = getmatchrulesdata("rugbyData", "juggTimeout");
  setdynamicdvar("scr_rugby_juggTimeout", var_3);
  var_4 = getmatchrulesdata("rugbyData", "helperMax");
  setdynamicdvar("scr_rugby_helperMax", var_4);
  var_5 = getmatchrulesdata("rugbyData", "juggCaptureTime");
  setdynamicdvar("scr_rugby_juggCaptureTime", var_5);
}

function getjuggmaxhealth() {
  return getdvarint("scr_rugby_juggHealth");
}

function getjuggspeedscalar(var_0) {
  var_1 = -0.3 + 0.1 * getdvarfloat("scr_rugby_juggSpeed");
  var_0 = int(min(var_0, getdvarint("scr_rugby_helperMax")));
  var_2 = 0.08 * getdvarfloat("scr_rugby_juggTeamSpeed");
  return var_1 + var_0 * var_2;
}

function getjuggtimeout() {
  return getdvarfloat("scr_rugby_juggTimeout");
}

function remove_spawn_disable_struct() {
  return getdvarfloat("scr_rugby_juggCaptureTime");
}

function remove_steam_damage() {
  return getdvarfloat("scr_rugby_juggOvertime", 45);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"MP_MODE_RUGBY/INGAME_OBJECTIVE");
  }

  setupwaypointicons();
  ref_12c4b();
  thread initrugbyents();
  thread setupinitialstate();
  initspawns();
  initjugg();
  thread ref_136f4();
  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
}

function ref_136f4() {
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;
  level thread scripts\mp\hud_message::notifyteam("jugg_capture", "jugg_capture", "allies");
}

function initrugbyents() {
  level.trial_target_headshot_func = scripts\engine\utility::array_combine(level.outofboundstriggers, level.minetriggers, level.hurttriggers, level.radtriggers);
  initendzoneents();
  initjuggcratesetupents();
}

function initendzoneents() {
  var_0 = level.rugby;
  var_1 = scripts\engine\utility::getStructArray("rugby_endzone", "targetname");

  foreach(var_3 in var_1) {
    initendzoneent(var_3);
    var_0.endzones[var_3.team][var_0.endzones[var_3.team].size] = var_3;
  }
}

function initendzoneent(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple_mp_rugby_endzone") {
      var_0.trigger = var_3;
    }

    if(isDefined(var_3.script_noteworthy) && getsubstr(var_3.script_noteworthy, 0, 3) == "fx_") {
      var_3 delete();
    }
  }

  getlinktarget(var_0);

  if(var_0.spawnflags & 1) {
    var_0.team = "allies";
    var_0.trigger.objectivekey = "allies";
  } else if(var_0.spawnflags & 2) {
    var_0.team = "axis";
    var_0.trigger.objectivekey = "axis";
  } else {
    var_0.team = "allies";
    var_0.trigger.objectivekey = "allies";
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_0.chevrons)) {
      thread ref_13232(level);
    }
  }
}

function getlinktarget(var_0) {
  if(level.mapname == "mp_crash2") {
    if(distance2d(var_0.origin, (312, -1552, 216)) < 10) {
      var_0.spawnflags = 1;
      return;
    }

    return;
  }

  if(level.mapname == "mp_scrapyard") {
    if(distance2d(var_0.origin, (-25223.3, -12439.2, 36.5)) < 10) {
      var_0.spawnflags = 2;
      return;
    }

    if(distance2d(var_0.origin, (-26150.7, -8967.81, 144)) < 10) {
      var_0.spawnflags = 1;
      return;
    }

    return;
  }
}

function initjuggcratesetupents() {
  var_0 = level.rugby;
  var_1 = scripts\engine\utility::getStructArray("rugby_jugg_crate", "targetname");

  foreach(var_3 in var_1) {
    var_3 = player_get_sniper_weapon_object(var_3);
    var_0.juggcratesetups[var_0.juggcratesetups.size] = var_3;
  }

  level.rugby = var_0;
}

function player_get_sniper_weapon_object(var_0) {
  switch (level.mapname) {
    case "mp_aniyah_tac":
      if(distance(var_0.origin, (3113.65, -1118.5, 378.5)) < 10) {
        var_0.origin = (2751, -1028, 376.5);
      }

      break;
    default:
      break;
  }

  return var_0;
}

function initoverheadcameras() {
  level.spectatorcameras = [];
  level.spectatorcameras[0]["allies"] = spawnStruct();
  level.spectatorcameras[0]["axis"] = spawnStruct();
  scripts\mp\spawncamera::setgamemodecamera("allies", level.spectatorcameras[0]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spectatorcameras[0]["axis"]);
  updateoverheadcamerapos("allies");
  updateoverheadcamerapos("axis");
  level.updategamemodecamera = &updateoverheadcamerapos;
  level.spectatorcameratime = 1.25;
}

function initjugg() {
  var_0 = scripts\mp\juggernaut::jugg_createconfig();
  level.rugby.juggconfig = var_0;
  var_1 = getjuggmaxhealth();
  var_0.maxhealth = var_1;
  var_0.startinghealth = var_1;
  var_2 = "iw8_juggernaut_mp_rugby";

  if(scripts\common\utility::iscp()) {
    var_2 = "iw8_juggernaut_cp_rugby";
  }

  var_0.suit = var_2;
  var_0.clothtype = "vestheavy";
  var_0.forcetostand = 0;
  var_0.allows["sprint"] = 1;
  var_0.allows["weapon_switch"] = undefined;
  var_0.classstruct.loadoutprimary = "iw8_lm_dblmg";
}

function initspawns() {
  var_0 = level.rugby;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Rugby", "Crit_Default");
  var_0.startspawnclassname = "mp_rugby_spawn";
  scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_allies_start", 1, "allies");
  scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_axis_start", 1, "axis");

  if(!isDefined(level.teamstartspawnpoints)) {
    var_0.startspawnclassname = "mp_tdm_spawn";
    scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_allies_start", 1, "allies");
    scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_axis_start", 1, "axis");
  }

  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies");
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis");

  if(var_1.size <= 0 || var_2.size <= 0) {
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    foreach(var_5 in var_3) {
      if(distancesquared(var_5.origin, var_0.goals["allies"].origin) < distancesquared(var_5.origin, var_0.goals["axis"].origin)) {
        var_1 = var_5;
        continue;
      }

      var_2 = var_5;
    }
  }

  var_7 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies_secondary");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis_secondary");
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_2);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_7);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_8);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies", var_1);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis", var_2);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies_base", var_7);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis_base", var_8);
  var_0.spawnsets = [];
  var_0.spawnsets["allies"] = "rugby_allies";
  var_0.spawnsets["axis"] = "rugby_axis";
  var_0.fallbackspawnsets = [];
  var_0.fallbackspawnsets["allies"] = "rugby_allies_base";
  var_0.fallbackspawnsets["axis"] = "rugby_axis_base";
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = level.rugby;
  var_1 = self.pers["team"];

  if(istrue(game["switchedsides"])) {
    var_1 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  jumpiffalse(scripts\mp\spawnlogic::shoulduseteamstartspawn()) LOC_00000083;
  var_3 = scripts\mp\spawnlogic::getspawnpointarray(var_0.startspawnclassname + "_" + var_1 + "_start");
  var_4 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_3);
  goto LOC_0000010b;
}

function modeonteamchangedeath(var_0) {
  if(isDefined(level.ref_12dd4)) {
    var_0 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var_0.team == level.ref_12dd4.team, 0, 1));
    return;
  }
}

function onplayerconnect(var_0) {
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["damage"])) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["damage"]);
  }

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["defends"]);
  }

  thread onplayerspawned(var_0);
}

function onplayerspawned(var_0) {
  var_0 waittill("spawned");

  if(isDefined(level.ref_12dd4) && isDefined(level.ref_12dd4.team) && isDefined(var_0.team)) {
    var_0 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var_0.team == level.ref_12dd4.team, 0, 1));
    return;
  }
}

function onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7) {
      var_3 = var_7;
    }

    var_1 scripts\mp\persistence::statsetchild("round", "damage", var_1.pers["damage"]);
    var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["damage"]);
    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.overrideweaponspeed_speedscale = undefined;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = self;
  var_13 = var_12.origin;
  var_14 = var_1.origin;
  var_15 = 0;

  if(isDefined(var_0)) {
    var_14 = var_0.origin;
    var_15 = var_0 == var_1;
  }

  if(isDefined(level.ref_12dd4)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.team != var_12.team) {
      if(var_1 == level.ref_12dd4) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("kill_as_juggernaut");
        return;
      }

      if(var_12 == level.ref_12dd4) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("kill_juggernaut");
        return;
      }

      if(var_1.team == level.ref_12dd4.team && var_1 != level.ref_12dd4) {
        var_16 = distancesquared(level.ref_12dd4.origin, var_14);

        if(var_16 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("defend");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
          var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
          var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
          thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "defending");
          return;
        }

        return;
      }

      if(var_1.team != level.ref_12dd4.team && var_12.team == level.ref_12dd4.team) {
        var_16 = distancesquared(level.ref_12dd4.origin, var_13);

        if(var_16 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("assault");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "assaulting");
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function ontimelimit() {
  if(level.gameended) {
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["cyber_tie"]);
}

function ontimelimitot() {
  if(level.rugby.activejuggernauts.size > 0) {
    if(!istrue(level.rugby.inot)) {
      setomnvar("ui_overtime_time", gettime() + remove_steam_damage() * 1000);
      level.rugby.inot = 1;
      level.canprocessot = 1;
      ref_13166();
      thread vehicle_isenemytoteam();
      return;
    }

    return;
  }

  level.canprocessot = 1;
  level.currenttimelimitdelay = level.ontimelimitgraceperiod;
}

function vehicle_isenemytoteam() {
  level endon("game_ended");

  for(;;) {
    if(level.rugby.activejuggernauts.size > 0) {
      wait 0.05;
      continue;
    }

    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
    break;
  }
}

function ref_13167() {
  var_0 = getdvarfloat("scr_rugby_juggTimeout");
  var_0 = int(var_0 * 1000 + gettime());
  setomnvar("ui_rugby_jugg_timer", var_0);
  setomnvar("ui_rugby_jugg_radial", 1);
  return var_0;
}

function ref_13166() {
  level notify("stop_rugby_timeout");
  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
}

function getjuggorcratepos() {
  var_0 = level.rugby;

  if(isDefined(level.ref_12dd4)) {
    return level.ref_12dd4.origin;
  } else if(var_0.activejuggernauts.size > 0) {
    foreach(var_2 in var_0.activejuggernauts) {
      return var_2.origin;
    }

    var_2 = undefined;
  } else {
    foreach(var_5 in var_1.activejuggcrates) {
      return var_5.origin;
    }

    var_5 = undefined;
  }

  return undefined;
}

function doesteamhaveactivejugg(var_0) {
  var_1 = level.rugby;

  if(var_1.activejuggernauts.size > 0) {
    foreach(var_3 in var_1.activejuggernauts) {
      if(var_3.team == var_0) {
        return true;
      }
    }
  }

  return false;
}

function onjuggproximityscore(var_0) {
  level endon("game_ended");
  playsoundatpos(var_0.origin, "exp_bombsite_lr");
  playFX(scripts\engine\utility::getfx("rugby_score_explosion"), var_0.origin);
  var_1 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 800);

  foreach(var_3 in var_1) {
    if(var_3 != var_0 && var_3.team != var_0.team) {
      var_3 dodamage(5000, var_0.origin, var_3, undefined, "MOD_EXPLOSIVE");
    }
  }

  thread scripts\mp\gamelogic::endgame(var_0.team, game["end_reason"]["target_destroyed"]);
}

function setupinitialstate() {
  var_0 = level.rugby;

  if(!activateendzone(var_0.endzones["allies"][0], "allies")) {
    return;
  }

  if(!activateendzone(var_0.endzones["axis"][0], "axis")) {
    return;
  }

  if(!activatenewjuggcrate()) {
    return;
  }
}

function activatenewjuggcrate() {
  var_0 = randomint(level.rugby.juggcratesetups.size);
  var_1 = level.rugby.juggcratesetups[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return activatejuggcrate(var_1.origin, scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0)), 1);
}

function activateendzone(var_0, var_1) {
  var_2 = level.rugby;

  if(istrue(game["switchedsides"])) {
    var_1 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_2.goals[var_1])) {
    deactivateendzone(var_2.goals[var_1]);
  }

  var_2.goals[var_1] = var_0;
  thread watchforjuggproximityscore(var_0);
  return true;
}

function deactivateendzone(var_0) {
  var_0 notify("endzone_deactivate");
}

function ref_13232(var_0) {
  if(level.mapname == "mp_shipment" || level.mapname == "mp_euphrates" || level.mapname == "mp_rust" || level.mapname == "mp_crash2" || level.mapname == "mp_malyshev") {
    if(var_0.trigger.objectivekey == "allies") {
      var_1 = "allies_endzone_vis";
    } else {
      var_1 = "axis_endzone_vis";
    }
  } else if(level.mapname == "mp_backlot2") {
    if(var_1.trigger.targetname == "allies_endzone") {
      var_1 = "axis_endzone_vis";
    } else {
      var_1 = "allies_endzone_vis";
    }
  } else if(var_1.trigger.targetname == "allies_endzone") {
    var_1 = "allies_endzone_vis";
  } else {
    var_1 = "axis_endzone_vis";
  }

  thread cargo_truck_mg_initomnvars(var_1, var_1);
  thread updatechevrons(var_1);
}

function cargo_truck_mg_initomnvars(var_0, var_1) {
  wait 1;
  var_2 = getentitylessscriptablearrayinradius(var_0, "targetname");
  var_2 = ref_12805(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3 = var_5;
    var_3[var_6].numchevrons = 1;

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "2") {
        var_3[var_6].numchevrons = 2;
        continue;
      }

      if(var_5.script_noteworthy == "3") {
        var_3[var_6].numchevrons = 3;
        continue;
      }

      if(var_5.script_noteworthy == "4") {
        var_3[var_6].numchevrons = 4;
      }
    }
  }

  self.chevrons = var_3;
}

function updatechevrons(var_0) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons)) {
    waitframe();
  }

  foreach(var_2 in self.chevrons) {
    for(var_3 = 0; var_3 < var_2.numchevrons; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, var_0);
    }
  }
}

function ref_12c1d(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      GscBinSkip0(0x2e, "1", [(-564, 1848, 24)]);

    case "mp_cave":
    case "mp_cave_am":
      GscBinSkip0(0x2e, "3", [(-692, 1828, 42), (-300, 1548, 76)]);

    case "mp_raid":
      GscBinSkip0(0x2e, "8", [(688, 256, 280)]);

    default:
      break;
  }

  if(isDefined(var_3[var_1])) {
    foreach(var_5 in var_0) {
      foreach(var_7 in var_3[var_1]) {
        if(distance(var_5.origin, var_7) < 10) {
          var_2 = var_5;
          break;
        }
      }
    }
  }

  var_0 = scripts\engine\utility::array_remove_array(var_0, var_2);
  return var_0;
}

function ref_12805(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "mp_piccadilly":
      var_2 = [];
      var_2[0] = [(-2376, -3322, 39), (0, -90, 0)];
      var_2[1] = [(-2071, -3537, 0), (0, 180, 0)];
      var_2[2] = [(-2071, -3653, 0), (0, 180, 0)];
      var_2[3] = [(-2071, -3754, 3), (0, 180, 0)];
      var_2 = [];
      var_2[0] = [(2137, 493, 124), (0, -85, 0)];
      var_2[1] = [(2302, 495, 128), (0, -90, 0)];
      var_2[2] = [(2390, 495, 134), (0, -90, 0)];
      var_2[3] = [(2457, 494, 134), (0, -90, 0)];
      break;
    case "mp_harbor":
      var_2 = [];
      var_2[0] = [(-722, -1428, 201), (0, 0, 0)];
      var_2[1] = [(-722, -1567, 200), (0, 0, 0)];
      var_2[2] = [(-721, -1496, 200), (0, 0, 0)];
      var_2[3] = [(-721, -1639, 200), (0, 0, 0)];
      var_2[4] = [(-720, -1711, 200), (0, 0, 0)];
      var_2[5] = [(-720, -1806, 200), (0, 0, 0)];
      var_2[6] = [(-719, -1896, 200), (0, 0, 0)];
      var_2[7] = [(-719, -1999, 200), (0, 0, 0)];
      var_2[8] = [(-483, -2074, 200), (0, -270, 0)];
      break;
    case "mp_vacant":
      var_2 = [];
      var_2[0] = [(4948, 1284, 9), (0, 45, 0)];
      break;
    case "mp_m_speed":
      var_2 = [];
      var_2[0] = [(-603, 3101, 33), (0, 155, 0)];
      var_2 = [];
      var_2[0] = [(-1070, 600, 32), (0, -20, 0)];
      break;
    case "mp_hardhat":
      var_2 = [];
      var_2[0] = [(1773, -1148, 302), (0, -90, 0)];
      var_2[1] = [(2098, -1153, 292), (0, -90, 0)];
      break;
    case "mp_runner_pm":
    case "mp_runner":
      var_2 = [];
      var_2[0] = [(1648, 367, 291), (0, 0, 0)];
      var_2[1] = [(1947, 859, 255), (0, 270, 0)];
      var_2[2] = [(1691, 854, 291), (0, 270, 0)];
      break;
    case "mp_raid":
      var_2 = [];
      var_2[0] = [(-2404.94, -1457.67, 280), (0, 0, 0)];
      var_2[1] = [(-849.814, -1158.33, 280), (0, 180, 0)];
      var_2[2] = [(-1978.45, -341.57, 280), (0, 270, 0)];
      var_2[3] = [(-1143, -975, 280), (0, 270, 0)];
      var_2 = [];
      var_2[0] = [(-1300.9, 4861.72, 269), (0, 180, 0)];
      var_2[1] = [(-1300.9, 4947, 269), (0, 180, 0)];
      var_2[2] = [(-1300.9, 4759, 269), (0, 180, 0)];
      var_2[3] = [(-1293.48, 4459.81, 273), (0, 180, 0)];
      var_2[4] = [(-1293.48, 4392, 274), (0, 180, 0)];
      var_2[5] = [(-2300.19, 3725.48, 288), (0, 90, 0)];
      var_2[6] = [(-1700.19, 3725.48, 286), (0, 90, 0)];
      var_2[7] = [(-1598.19, 4348.83, 279), (0, 90, 0)];
      break;
    case "mp_hackney_yard":
    case "mp_hackney_am":
      var_2 = [];
      var_2[0] = [(765, -1883, 23), (0, 180, 0)];
      var_2[1] = [(762, -2006, 187), (0, 180, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var_2[var_1])) {
    foreach(var_5 in var_2[var_1]) {
      var_6 = var_5[0];
      var_7 = var_5[1];
      var_8 = easepower("hardpoint_chevron", var_6, var_7);
      var_3 = var_8;
    }
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  return var_0;
}

function init_vo_arrays(var_0, var_1, var_2) {
  var_0.origin = var_1;
  var_0.angles = var_2;
  return var_0;
}

function setupgoalvisualsforjugg(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_1);
  var_3 = var_2[0];
  var_4 = level.rugby.goals[var_3];
  thread updatechevrons(var_4);
  var_5 = level.rugby.goals[var_1];
  thread updatechevrons(var_5);
}

function watchforjuggproximityscore(var_0) {
  level endon("game_ended");
  self endon("endzone_deactivate");

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(isDefined(var_1.rugbyjugginfo) && var_1.team != var_0) {
      onjuggproximityscore(var_1);
      return;
    }
  }
}

function activatenewjuggernaut(var_0) {
  var_1 = level.rugby;
  var_2 = setupplayerasjugg(var_0);

  if(!var_2) {
    return false;
  }

  var_3 = spawnStruct();
  var_3.player = var_0;
  var_4 = var_0 getentitynumber();
  var_3.id = var_4;
  var_1.activejuggernauts[var_4] = var_0;
  level.ref_12dd4 = var_0;
  var_0.rugbyjugginfo = var_3;
  createobjectiveiconsforactivejugg(var_0, var_3);
  startjugghud(var_0);
  setupgoalvisualsforjugg(var_0);
  thread watchjugghealth();
  thread watchforjuggdeathdisconnect();
  thread watchjuggprogress();
  thread watchteammatesnearjugg();

  if(getjuggtimeout() > 0) {
    thread watchjuggtimeout();
  }

  var_0 scripts\mp\utility\dialog::leaderdialogonplayer("rugby_new_jugg", "obj");
  var_0 thread scripts\mp\hud_message::showsplash("jugg_player");
  var_5 = [var_0];
  var_6 = scripts\mp\utility\game::getotherteam(var_0.team)[0];
  scripts\mp\utility\dialog::statusdialog("rugby_secured_jugg", var_0.team, "obj", var_5);
  scripts\mp\utility\dialog::statusdialog("rugby_lost_jugg", var_6, "obj");
  thread ref_12451(level, var_0.team);

  foreach(var_8 in level.players) {
    if(var_8.team == var_0.team) {
      if(var_8 != var_0) {
        var_8 thread scripts\mp\hud_message::showsplash("jugg_captured");
      }

      continue;
    }

    var_8 thread scripts\mp\hud_message::showsplash("jugg_lost");
  }

  return true;
}

function ref_12451(var_0, var_1) {
  wait 3;
  scripts\mp\utility\dialog::statusdialog("rugby_order_attack", var_0);
  scripts\mp\utility\dialog::statusdialog("rugby_order_fallback", var_1);
}

function deactivatejuggernaut(var_0) {
  var_1 = level.rugby;
  var_2 = var_0.rugbyjugginfo;

  if(isDefined(var_0)) {
    var_0.rugbyjugginfo = undefined;
  }

  var_1.activejuggernauts[var_2.id] = undefined;
  level.ref_12dd4 = undefined;
  cleanupobjectiveiconsforjugg(var_0, var_2);
  clearjugghud();

  foreach(var_4 in var_1.endzones) {
    thread updatechevrons(var_4[0]);
  }

  level.rugby.maxperkbonustier = undefined;
  level.rugby.ref_128bf = undefined;
  level.rugby.vehicle_occupancy_isfriendlytoplayer = undefined;
  level.rugby.vehicle_occupancy_isenemytoteam = undefined;

  if(isDefined(var_0) && isDefined(var_0.team)) {
    level thread scripts\mp\hud_message::notifyteam("jugg_down_fr", "jugg_down_en", var_0.team);
  } else {
    level thread scripts\mp\hud_message::notifyteam("jugg_capture", "jugg_capture", "allies");
  }

  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
  var_0 notify("rugby_jugg_end");
}

function startjugghud(var_0) {
  setomnvar("ui_rugby_jugg_client", var_0);
  setomnvar("ui_rugby_jugg_health", 1);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var_2.team == var_0.team, 0, 1));
  }
}

function clearjugghud() {
  setomnvar("ui_rugby_jugg_client", undefined);

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_rugby_jugg_friendly", -1);
  }
}

function watchjugghealth() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    self waittill("damage");
    setomnvar("ui_rugby_jugg_health", self.health / self.maxhealth);
  }
}

function watchforjuggdeathdisconnect() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self waittill("death_or_disconnect");
  var_0 = undefined;

  if(!isDefined(self)) {
    var_0 = level.lastjuggpositions[self.rugbyjugginfo.id];
  } else {
    var_0 = self.origin;
  }

  var_1 = getnodesinradius(var_0, 32, 0, 32);
  var_2 = getclosestpointonnavmesh(var_0);

  if(distance(var_0, var_2) > 50) {
    var_2 = var_0;
  }

  var_2 = var_0;
  activatejuggcrate(var_2 + (0, 0, 0), (0, 0, 0));
  deactivatejuggernaut(self);
}

function watchjuggprogress() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  var_0 = self.team;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = var_1[0];
  var_3 = level.rugby.goals[var_0];
  var_4 = level.rugby.goals[var_2];
  var_5 = var_4.origin - var_3.origin;
  var_6 = vectordot(var_5, var_5);
  var_7 = undefined;

  for(;;) {
    var_8 = self.origin * (1, 1, 0) - var_3.origin * (1, 1, 0);
    var_9 = vectordot(var_5, var_8) / var_6;
    var_9 = clamp(var_9, 0, 1);
    var_10 = [];
    var_10 = var_9;
    var_10 = 1 - var_9;

    foreach(var_12 in level.players) {
      if(var_12.team == var_0 || var_12.team == var_2) {
        var_12 setclientomnvar("ui_rugby_jugg_progress", var_10[var_12.team]);
      }
    }

    if(var_9 > 0.8) {
      thread getquestunlockableindexfromlootid(level, var_9, var_0);
    }

    if(isDefined(level.ref_12dd4)) {
      if(!isDefined(var_7)) {
        var_7 = var_9;
      }

      if(var_9 > var_7 + 0.1) {
        var_7 = var_9;
        level.ref_12dd4 thread scripts\mp\utility\points::giveunifiedpoints("rugby_obj_push");
      }
    }

    level.lastjuggpositions[self.rugbyjugginfo.id] = self.origin;
    wait 0.05;
  }
}

function getquestunlockableindexfromlootid(var_0, var_1, var_2) {
  if(!isDefined(level.rugby.maxperkbonustier)) {
    level.rugby.maxperkbonustier = 1;
    level.rugby.ref_128bf = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var_0;
    level.rugby.vehicle_occupancy_isenemytoteam = var_0;
  } else if(isDefined(level.rugby.ref_128bf) && level.rugby.ref_128bf + 30000 < gettime()) {
    level.rugby.maxperkbonustier = 1;
    level.rugby.ref_128bf = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var_0;
    level.rugby.vehicle_occupancy_isenemytoteam = var_0;
  }

  if(istrue(level.rugby.maxperkbonustier)) {
    scripts\mp\utility\dialog::statusdialog("rugby_friendly_close_goal", var_1, "obj");
    scripts\mp\utility\dialog::statusdialog("rugby_enemy_close_goal", var_2, "obj");
    thread scripts\mp\music_and_dialog::timelimitmusic(var_1);
  }

  level.rugby.maxperkbonustier = 0;
}

function setupplayerasjugg(var_0) {
  var_1 = level.rugby.juggconfig;
  var_2 = var_0 scripts\mp\juggernaut::jugg_makejuggernaut(var_1);

  if(!var_2) {
    return false;
  }

  var_0.droppeddeathweapon = 1;
  var_0 givemaxammo(var_0.classstruct.loadoutprimaryobject);
  var_0.playerstreakspeedscale = getjuggspeedscalar(0);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  thread handlejuggjumpspam();
  var_3 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_4 = var_3[0];
  return true;
}

function watchteammatesnearjugg() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2.team != self.team || var_2 == self) {
        continue;
      }

      if(distancesquared(var_2.origin, self.origin) < 122500) {
        var_0++;
      }
    }

    self.playerstreakspeedscale = getjuggspeedscalar(var_0);
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}

function watchjuggtimeout() {
  level endon("game_ended");
  level endon("stop_rugby_timeout");
  self endon("rugby_jugg_end");
  ref_13167();
  thread ref_12e18(level);
  wait getjuggtimeout();
  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
  self suicide();
}

function ref_12e18(var_0) {
  level endon("stop_rugby_timeout");
  var_0 endon("rugby_jugg_end");
  var_1 = getdvarfloat("scr_rugby_juggTimeout");
  var_2 = var_1;

  while(!istrue(level.canprocessot)) {
    setomnvar("ui_rugby_jugg_radial", var_2 / var_1);
    var_2 -= level.framedurationseconds;
    wait level.framedurationseconds;
  }
}

function handlejuggjumpspam() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self notifyonplayercommand("jugg_jumped", "+goStand");

  for(;;) {
    self waittill("jugg_jumped");

    while(!self isonground()) {
      waitframe();
    }

    var_0 = self getvelocity();
    var_1 = (var_0[0] * 0.25, var_0[1] * 0.25, var_0[2]);
    self setvelocity(var_1);
    self.overrideweaponspeed_speedscale = 0.2;
    scripts\mp\weapons::updatemovespeedscale();

    for(;;) {
      var_2 = scripts\engine\utility::ref_143b9(1, "jugg_jumped");

      if(var_2 == "jugg_jumped") {
        while(!self isonground()) {
          waitframe();
        }

        var_0 = self getvelocity();
        var_1 = (var_0[0] * 0.25, var_0[1] * 0.25, var_0[2]);
        self setvelocity(var_1);
        continue;
      }

      break;
    }

    self.overrideweaponspeed_speedscale = undefined;
  }
}

function ref_12c4b() {
  var_0 = 0;
  level.vehicle_occupancy_isfriendlytoteam = spawnStruct();
  level.vehicle_occupancy_isfriendlytoteam.objidnum = scripts\mp\objidpoolmanager::requestreservedid(var_0);
}

function createobjectiveiconsforactivejugg(var_0, var_1) {
  createjuggobjective(var_0, var_1);
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_3 = var_2[0];
  var_4 = level.rugby.goals[var_3];
  createendzoneobjective(var_4, var_3, var_1);
}

function cleanupobjectiveiconsforjugg(var_0, var_1) {
  scripts\mp\objidpoolmanager::update_objective_state(0, "done");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1.endzoneobjid);
}

function createjuggobjective(var_0, var_1) {
  var_2 = 0;
  var_1.juggobjid = var_2;
  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "current", var_0.origin, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_2, 90);
  objective_setownerteam(var_2, var_0.team);
  objective_setfriendlylabel(var_2, "MP_MODE_RUGBY/JUGG_ESCORT");
  objective_setenemylabel(var_2, "MP_MODE_RUGBY/JUGG_KILL");
}

function createendzoneobjective(var_0, var_1, var_2) {
  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_2.endzoneobjid = var_3;
  scripts\mp\objidpoolmanager::objective_add_objective(var_3, "current", var_0.origin, "icon_waypoint_rugby_base");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_3, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_3, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_3);
  objective_setownerteam(var_3, var_1);
  objective_setfriendlylabel(var_3, "MP_MODE_RUGBY/ENDZONE_DEFEND");
  objective_setenemylabel(var_3, "MP_MODE_RUGBY/ENDZONE_ASSAULT");
}

function activatejuggcrate(var_0, var_1, var_2) {
  var_3 = level.rugby;

  if(!vandalize_attack_min_cooldown(var_0)) {
    var_0 = level.init_ai_kill_params_for_events;
    var_1 = level.init_ai;
  }

  var_4 = createjuggcrate(var_0, var_1, var_2);
  var_3.activejuggcrates[0] = var_4;
  var_3.activejuggcrates[0].crateid = var_4;
  return true;
}

function vandalize_attack_min_cooldown(var_0) {
  var_1 = 1;

  foreach(var_3 in level.trial_target_headshot_func) {
    if(ispointinvolume(var_0, var_3)) {
      var_1 = 0;
      break;
    }
  }

  return var_1;
}

function createjuggcrate(var_0, var_1, var_2) {
  var_3 = getgroundposition(var_0, 8, 2000, 32);
  var_3 += (0, 0, 5);
  var_4 = spawn("script_model", var_3);
  var_4.angles = var_1;
  var_4.visuals = [var_4];
  var_4.trigger = var_4;
  var_4.trigger.origin = var_4.origin;
  var_4.curorigin = var_4.trigger.origin;
  var_4.safeorigin = var_4.trigger.origin;
  var_4.visuals[0] setModel("military_carepackage_02_rupture");
  var_4 thread scripts\mp\gameobjects::setdropped();
  var_4.crateid = var_4 getentitynumber();
  thread juggcratemanageuse(var_4);

  if(istrue(var_2)) {
    level.init_ai_kill_params_for_events = var_0;
    level.init_ai = var_1;

    foreach(var_6 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("rugby_capture_jugg", var_6, "obj");
    }
  }

  return var_4;
}

function gunkillerhackthread() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = getweaponarray();

    foreach(var_2 in var_0) {
      if(distance2dsquared(var_2.origin, self.origin) < 40000) {
        var_2 delete();
      }
    }

    wait 0.25;
  }
}

function juggcratemanageuse(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = spawn("script_model", self.origin + (0, 0, 30));
  var_1.usetype = 1;
  var_1.destination = self.origin + (0, 0, 30);
  var_1.vampirepoints = 1;
  self.ref_14074 = scripts\mp\gameobjects::createholduseobject("neutral", var_1, self.visuals, (0, 0, 64));

  foreach(var_3 in level.teamnamelist) {
    self.ref_14074.teamprogress = undefined;
  }

  self.ref_14074.trigger.ref_1408a = 16900;
  self.ref_14074.trigger setuserange(130);
  self.ref_14074.trigger setHintString(&"MP_MODE_RUGBY/CRATE_USE");
  self.ref_14074.trigger makeusable();
  self.ref_14074.trigger setCursorHint("HINT_BUTTON");
  self.ref_14074.trigger setuseholdduration("duration_none");
  self.ref_14074.trigger setusehideprogressbar(1);
  self.ref_14074.trigger setusepriority(-3);
  self.ref_14074.trigger sethintonobstruction("hide");
  self.ref_14074 scripts\mp\gameobjects::setusetime(remove_spawn_disable_struct());
  self.ref_14074.interactteam = "any";
  self.ref_14074.curprogress = 0;
  self.ref_14074.defaultusetime = self.ref_14074.ref_1409e;
  self.ref_14074.userate = 1;
  self.ref_14074.id = "rugby_jugg";
  self.ref_14074.exclusiveuse = 0;
  self.ref_14074.exclusiveclaim = 0;
  self.ref_14074.skiptouching = 1;
  self.ref_14074.onbeginuse = &ref_12dd1;
  self.ref_14074.onuse = &ref_12dd0;
  self.ref_14074.onenduse = &ref_12dd2;
  self.ref_14074.oncantuse = &ref_12dd3;
  self.ref_14074.inuse = 0;

  foreach(var_6 in level.teamnamelist) {
    self.ref_14074.numtouching[var_6] = 0;
    self.ref_14074.touchlist[var_6] = [];
  }

  self.ref_14074.cancontestclaim = 0;
  self.ref_14074.stalemate = 0;
  self.ref_14074.wasstalemate = 0;
  self.ref_14074.cancontestclaim = 0;
  self.ref_14074.majoritycapprogress = 1;
  self.ref_14074.wasmajoritycapprogress = 0;
  self.ref_14074.resetprogress = 1;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  self.ref_14074.type = "useObject";
  self.ref_14074.offset3d = (0, 0, 32);
  self.ref_14074 scripts\mp\gameobjects::requestid(1, 1);
  self.ref_14074 scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_jugg_crate");
  self.ref_14074 scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.ref_14074.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.ref_14074.objidnum, 0);
}

function ref_12dd1(var_0) {
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_taking", "icon_waypoint_losing");
  scripts\mp\utility\dialog::statusdialog("rugby_securing_jugg", var_0.team, "obj");
  self.visuals[0] playLoopSound("mp_care_package_non_owner_cap");
}

function ref_12dd0(var_0) {
  var_1 = activatenewjuggernaut(var_0);

  if(!var_1) {
    return;
  }

  juggcratecleanup();
  level.rugby.activejuggcrates[0].crateid = undefined;
  level.rugby.activejuggcrates[0] = undefined;

  if(isDefined(self.ref_14074)) {
    self.ref_14074 delete();
  }

  if(isDefined(self.visuals)) {
    foreach(var_3 in self.visuals) {
      var_3 delete();
    }
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
    return;
  }
}

function ref_12dd2(var_0, var_1, var_2) {
  self.visuals[0] stoploopsound("mp_care_package_non_owner_cap");

  if(!var_2) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_jugg_crate");
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);

  if(self.curprogress > 0) {
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, var_1.team);
    return;
  }

  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

function ref_12dd3(var_0) {}

function juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
}

function createjuggcrateobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_2, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);
  objective_setneutrallabel(var_1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  objective_setfriendlylabel(var_1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  objective_setenemylabel(var_1, "MP_MODE_RUGBY/CRATE_LOSING");
  updatejuggcrateobjectivestate(var_0);
}

function updatejuggcrateobjectivestate(var_0) {
  var_1 = var_0.objid;
  var_2 = istrue(var_0.inuse);

  if(var_2) {
    objective_setownerteam(var_1, var_0.usingplayer.team);
    objective_sethot(var_1, 1);
    return;
  }

  objective_setownerteam(var_1, undefined);
  objective_sethot(var_1, 0);
}

function get_circle_back_start_node(var_0) {
  var_1 = level.rugby.juggconfig;

  if(istrue(var_0.isjuggernaut)) {
    var_0 scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    return false;
  }

  var_2 = var_0 scripts\mp\juggernaut::vehicle_damage_setweaponhitdamagedata(var_1);

  if(!isDefined(var_2)) {
    var_0 scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return false;
  }

  return true;
}

function updateoverheadcamerapos(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
    var_2 = level.spectatorcameras[0][var_1];
  } else {
    var_1 = self.team;
    var_2 = level.spectatorcameras[0][self.team];
  }

  var_3 = level.rugby;
  var_4 = undefined;

  if(!istrue(game["switchedsides"])) {
    var_4 = var_1;
  } else {
    var_4 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  var_5 = scripts\engine\utility::ter_op(var_4 == "allies", "axis", "allies");
  var_6 = var_3.endzones[var_4][0].origin;
  var_7 = var_3.endzones[var_5][0].origin;
  var_8 = (var_7 - var_6) * (1, 1, 0);
  var_9 = length2d(var_8);
  var_10 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_10)) {
    var_11 = var_10.origin[2];
  } else {
    var_11 = 5000;
  }

  var_12 = undefined;
  var_13 = undefined;

  if(doesteamhaveactivejugg(var_2)) {
    var_14 = getjuggorcratepos();
    var_12 = var_14 + var_9 * -3000 / var_10;
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = var_14 + (var_8 - var_14) * 0.5;
  } else {
    var_12 = var_7 + var_9 * -2000 / var_10;
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = getjuggorcratepos();
  }

  var_15 = var_13 - var_12;
  var_16 = vectortoangles(var_15);
  var_3.origin = var_12;
  var_3.angles = var_16;
}

function startspectatorview() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  updateoverheadcamerapos();
  var_0 = level.spectatorcameras[0][self.team];
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
  removeplayeroutlinesforoverheadcam();
  thread runslamzoomonspawn();
}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_1, 1, 0.5, 0.5);
  var_0 playlocalsound("mp_cmd_camera_zoom_out");
  var_0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var_2, 1, 0.5, 0.5);
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

function enableplayeroutlinesforoverheadcam() {
  self.rugbyoverheadoutlines = [];

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }

    var_2 = scripts\engine\utility::ter_op(var_1.team == self.team, "outlinefill_nodepth_cyan", "outlinefill_nodepth_orange");
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(var_1, self, var_2, "level_script");
    self.rugbyoverheadoutlines[var_3] = var_1;
  }
}

function removeplayeroutlinesforoverheadcam() {
  if(isDefined(self.rugbyoverheadoutlines)) {
    foreach(var_1 in self.rugbyoverheadoutlines) {
      scripts\mp\utility\outline::outlinedisable(var_2, var_1);
    }

    self.rugbyoverheadoutlines = undefined;
    return;
  }
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg_crate", 0, "neutral", "MP_MODE_RUGBY/CRATE_CAPTURE", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg", 1, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg", 1, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_hq_defend", 0, "friendly", "MP_MODE_RUGBY/ENDZONE_DEFEND", "icon_waypoint_rugby_base", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_hq_attack", 0, "enemy", "MP_MODE_RUGBY/ENDZONE_ASSAULT", "icon_waypoint_rugby_base", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_jugg", 0);
}