/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rugby.gsc
***********************************************/

function main() {
  var0 = spawnStruct();
  level.rugby = var0;
  var0.endzones = [];
  var0.endzones["allies"] = [];
  var0.endzones["axis"] = [];
  var0.juggcratesetups = [];
  var0.goals = [];
  var0.activejuggcrates = [];
  var0.activejuggernauts = [];
  var0.lastjuggpositions = [];
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
  var0 = getmatchrulesdata("rugbyData", "juggHealth");
  setdynamicdvar("scr_rugby_juggHealth", var0);
  var1 = getmatchrulesdata("rugbyData", "juggSpeed");
  setdynamicdvar("scr_rugby_juggSpeed", var1);
  var2 = getmatchrulesdata("rugbyData", "juggTeamSpeed");
  setdynamicdvar("scr_rugby_juggTeamSpeed", var2);
  var3 = getmatchrulesdata("rugbyData", "juggTimeout");
  setdynamicdvar("scr_rugby_juggTimeout", var3);
  var4 = getmatchrulesdata("rugbyData", "helperMax");
  setdynamicdvar("scr_rugby_helperMax", var4);
  var5 = getmatchrulesdata("rugbyData", "juggCaptureTime");
  setdynamicdvar("scr_rugby_juggCaptureTime", var5);
}

function getjuggmaxhealth() {
  return getdvarint("scr_rugby_juggHealth");
}

function getjuggspeedscalar(var0) {
  var1 = -0.3 + 0.1 * getdvarfloat("scr_rugby_juggSpeed");
  var0 = int(min(var0, getdvarint("scr_rugby_helperMax")));
  var2 = 0.08 * getdvarfloat("scr_rugby_juggTeamSpeed");
  return var1 + var0 * var2;
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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"MP_MODE_RUGBY/INGAME_OBJECTIVE");
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
  var0 = level.rugby;
  var1 = scripts\engine\utility::getStructArray("rugby_endzone", "targetname");

  foreach(var3 in var1) {
    initendzoneent(var3);
    var0.endzones[var3.team][var0.endzones[var3.team].size] = var3;
  }
}

function initendzoneent(var0) {
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    if(var3.classname == "trigger_multiple_mp_rugby_endzone") {
      var0.trigger = var3;
    }

    if(isDefined(var3.script_noteworthy) && getsubstr(var3.script_noteworthy, 0, 3) == "fx_") {
      var3 delete();
    }
  }

  getlinktarget(var0);

  if(var0.spawnflags & 1) {
    var0.team = "allies";
    var0.trigger.objectivekey = "allies";
  } else if(var0.spawnflags & 2) {
    var0.team = "axis";
    var0.trigger.objectivekey = "axis";
  } else {
    var0.team = "allies";
    var0.trigger.objectivekey = "allies";
  }

  foreach(var3 in var1) {
    if(!isDefined(var0.chevrons)) {
      thread ref_13232(level);
    }
  }
}

function getlinktarget(var0) {
  if(level.mapname == "mp_crash2") {
    if(distance2d(var0.origin, (312, -1552, 216)) < 10) {
      var0.spawnflags = 1;
      return;
    }

    return;
  }

  if(level.mapname == "mp_scrapyard") {
    if(distance2d(var0.origin, (-25223.3, -12439.2, 36.5)) < 10) {
      var0.spawnflags = 2;
      return;
    }

    if(distance2d(var0.origin, (-26150.7, -8967.81, 144)) < 10) {
      var0.spawnflags = 1;
      return;
    }

    return;
  }
}

function initjuggcratesetupents() {
  var0 = level.rugby;
  var1 = scripts\engine\utility::getStructArray("rugby_jugg_crate", "targetname");

  foreach(var3 in var1) {
    var3 = player_get_sniper_weapon_object(var3);
    var0.juggcratesetups[var0.juggcratesetups.size] = var3;
  }

  level.rugby = var0;
}

function player_get_sniper_weapon_object(var0) {
  switch (level.mapname) {
    case "mp_aniyah_tac":
      if(distance(var0.origin, (3113.65, -1118.5, 378.5)) < 10) {
        var0.origin = (2751, -1028, 376.5);
      }

      break;
    default:
      break;
  }

  return var0;
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
  var0 = scripts\mp\juggernaut::jugg_createconfig();
  level.rugby.juggconfig = var0;
  var1 = getjuggmaxhealth();
  var0.maxhealth = var1;
  var0.startinghealth = var1;
  var2 = "iw8_juggernaut_mp_rugby";

  if(scripts\common\utility::iscp()) {
    var2 = "iw8_juggernaut_cp_rugby";
  }

  var0.suit = var2;
  var0.clothtype = "vestheavy";
  var0.forcetostand = 0;
  var0.allows["sprint"] = 1;
  var0.allows["weapon_switch"] = undefined;
  var0.classstruct.loadoutprimary = "iw8_lm_dblmg";
}

function initspawns() {
  var0 = level.rugby;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Rugby", "Crit_Default");
  var0.startspawnclassname = "mp_rugby_spawn";
  scripts\mp\spawnlogic::addstartspawnpoints(var0.startspawnclassname + "_allies_start", 1, "allies");
  scripts\mp\spawnlogic::addstartspawnpoints(var0.startspawnclassname + "_axis_start", 1, "axis");

  if(!isDefined(level.teamstartspawnpoints)) {
    var0.startspawnclassname = "mp_tdm_spawn";
    scripts\mp\spawnlogic::addstartspawnpoints(var0.startspawnclassname + "_allies_start", 1, "allies");
    scripts\mp\spawnlogic::addstartspawnpoints(var0.startspawnclassname + "_axis_start", 1, "axis");
  }

  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies");
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis");

  if(var1.size <= 0 || var2.size <= 0) {
    var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    foreach(var5 in var3) {
      if(distancesquared(var5.origin, var0.goals["allies"].origin) < distancesquared(var5.origin, var0.goals["axis"].origin)) {
        var1 = var5;
        continue;
      }

      var2 = var5;
    }
  }

  var7 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies_secondary");
  var8 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis_secondary");
  scripts\mp\spawnlogic::registerspawnpoints("allies", var1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var2);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var7);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var8);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies", var1);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis", var2);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies_base", var7);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis_base", var8);
  var0.spawnsets = [];
  var0.spawnsets["allies"] = "rugby_allies";
  var0.spawnsets["axis"] = "rugby_axis";
  var0.fallbackspawnsets = [];
  var0.fallbackspawnsets["allies"] = "rugby_allies_base";
  var0.fallbackspawnsets["axis"] = "rugby_axis_base";
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var0 = level.rugby;
  var1 = self.pers["team"];

  if(istrue(game["switchedsides"])) {
    var1 = scripts\engine\utility::ter_op(var1 == "allies", "axis", "allies");
  }

  var2 = scripts\engine\utility::ter_op(var1 == "allies", "axis", "allies");
  jumpiffalse(scripts\mp\spawnlogic::shoulduseteamstartspawn()) LOC_00000083;
  var3 = scripts\mp\spawnlogic::getspawnpointarray(var0.startspawnclassname + "_" + var1 + "_start");
  var4 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var3);
  goto LOC_0000010b;
}

function modeonteamchangedeath(var0) {
  if(isDefined(level.ref_12dd4)) {
    var0 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var0.team == level.ref_12dd4.team, 0, 1));
    return;
  }
}

function onplayerconnect(var0) {
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["damage"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["damage"]);
  }

  var0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var0.pers["defends"])) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["defends"]);
  }

  thread onplayerspawned(var0);
}

function onplayerspawned(var0) {
  var0 waittill("spawned");

  if(isDefined(level.ref_12dd4) && isDefined(level.ref_12dd4.team) && isDefined(var0.team)) {
    var0 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var0.team == level.ref_12dd4.team, 0, 1));
    return;
  }
}

function onplayerdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(isDefined(var1) && var1 != var2 && isPlayer(var1)) {
    if(var3 >= var7) {
      var3 = var7;
    }

    var1 scripts\mp\persistence::statsetchild("round", "damage", var1.pers["damage"]);
    var1 scripts\mp\utility\stats::setextrascore0(var1.pers["damage"]);
    return;
  }
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self.overrideweaponspeed_speedscale = undefined;

  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 0;
  var11 = 0;
  var12 = self;
  var13 = var12.origin;
  var14 = var1.origin;
  var15 = 0;

  if(isDefined(var0)) {
    var14 = var0.origin;
    var15 = var0 == var1;
  }

  if(isDefined(level.ref_12dd4)) {
    if(isDefined(var1) && isPlayer(var1) && var1.team != var12.team) {
      if(var1 == level.ref_12dd4) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("kill_as_juggernaut");
        return;
      }

      if(var12 == level.ref_12dd4) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("kill_juggernaut");
        return;
      }

      if(var1.team == level.ref_12dd4.team && var1 != level.ref_12dd4) {
        var16 = distancesquared(level.ref_12dd4.origin, var14);

        if(var16 < 105625) {
          var1 thread scripts\mp\rank::scoreeventpopup("defend");
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var1 scripts\mp\utility\stats::incpersstat("defends", 1);
          var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
          var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
          thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
          return;
        }

        return;
      }

      if(var1.team != level.ref_12dd4.team && var12.team == level.ref_12dd4.team) {
        var16 = distancesquared(level.ref_12dd4.origin, var13);

        if(var16 < 105625) {
          var1 thread scripts\mp\rank::scoreeventpopup("assault");
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
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
  var0 = getdvarfloat("scr_rugby_juggTimeout");
  var0 = int(var0 * 1000 + gettime());
  setomnvar("ui_rugby_jugg_timer", var0);
  setomnvar("ui_rugby_jugg_radial", 1);
  return var0;
}

function ref_13166() {
  level notify("stop_rugby_timeout");
  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
}

function getjuggorcratepos() {
  var0 = level.rugby;

  if(isDefined(level.ref_12dd4)) {
    return level.ref_12dd4.origin;
  } else if(var0.activejuggernauts.size > 0) {
    foreach(var2 in var0.activejuggernauts) {
      return var2.origin;
    }

    var2 = undefined;
  } else {
    foreach(var5 in var1.activejuggcrates) {
      return var5.origin;
    }

    var5 = undefined;
  }

  return undefined;
}

function doesteamhaveactivejugg(var0) {
  var1 = level.rugby;

  if(var1.activejuggernauts.size > 0) {
    foreach(var3 in var1.activejuggernauts) {
      if(var3.team == var0) {
        return true;
      }
    }
  }

  return false;
}

function onjuggproximityscore(var0) {
  level endon("game_ended");
  playsoundatpos(var0.origin, "exp_bombsite_lr");
  playFX(scripts\engine\utility::getfx("rugby_score_explosion"), var0.origin);
  var1 = scripts\mp\utility\player::getplayersinradius(var0.origin, 800);

  foreach(var3 in var1) {
    if(var3 != var0 && var3.team != var0.team) {
      var3 dodamage(5000, var0.origin, var3, undefined, "MOD_EXPLOSIVE");
    }
  }

  thread scripts\mp\gamelogic::endgame(var0.team, game["end_reason"]["target_destroyed"]);
}

function setupinitialstate() {
  var0 = level.rugby;

  if(!activateendzone(var0.endzones["allies"][0], "allies")) {
    return;
  }

  if(!activateendzone(var0.endzones["axis"][0], "axis")) {
    return;
  }

  if(!activatenewjuggcrate()) {
    return;
  }
}

function activatenewjuggcrate() {
  var0 = randomint(level.rugby.juggcratesetups.size);
  var1 = level.rugby.juggcratesetups[var0];

  if(!isDefined(var1)) {
    return 0;
  }

  return activatejuggcrate(var1.origin, scripts\engine\utility::ter_op(isDefined(var1.angles), var1.angles, (0, 0, 0)), 1);
}

function activateendzone(var0, var1) {
  var2 = level.rugby;

  if(istrue(game["switchedsides"])) {
    var1 = scripts\engine\utility::ter_op(var1 == "allies", "axis", "allies");
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var2.goals[var1])) {
    deactivateendzone(var2.goals[var1]);
  }

  var2.goals[var1] = var0;
  thread watchforjuggproximityscore(var0);
  return true;
}

function deactivateendzone(var0) {
  var0 notify("endzone_deactivate");
}

function ref_13232(var0) {
  if(level.mapname == "mp_shipment" || level.mapname == "mp_euphrates" || level.mapname == "mp_rust" || level.mapname == "mp_crash2" || level.mapname == "mp_malyshev") {
    if(var0.trigger.objectivekey == "allies") {
      var1 = "allies_endzone_vis";
    } else {
      var1 = "axis_endzone_vis";
    }
  } else if(level.mapname == "mp_backlot2") {
    if(var1.trigger.targetname == "allies_endzone") {
      var1 = "axis_endzone_vis";
    } else {
      var1 = "allies_endzone_vis";
    }
  } else if(var1.trigger.targetname == "allies_endzone") {
    var1 = "allies_endzone_vis";
  } else {
    var1 = "axis_endzone_vis";
  }

  thread cargo_truck_mg_initomnvars(var1, var1);
  thread updatechevrons(var1);
}

function cargo_truck_mg_initomnvars(var0, var1) {
  wait 1;
  var2 = getentitylessscriptablearrayinradius(var0, "targetname");
  var2 = ref_12805(var2, var1);
  var3 = [];

  foreach(var5 in var2) {
    var6 = var3.size;
    var3 = var5;
    var3[var6].numchevrons = 1;

    if(isDefined(var5.script_noteworthy)) {
      if(var5.script_noteworthy == "2") {
        var3[var6].numchevrons = 2;
        continue;
      }

      if(var5.script_noteworthy == "3") {
        var3[var6].numchevrons = 3;
        continue;
      }

      if(var5.script_noteworthy == "4") {
        var3[var6].numchevrons = 4;
      }
    }
  }

  self.chevrons = var3;
}

function updatechevrons(var0) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons)) {
    waitframe();
  }

  foreach(var2 in self.chevrons) {
    for(var3 = 0; var3 < var2.numchevrons; var3++) {
      var2 setscriptablepartstate("chevron_" + var3, var0);
    }
  }
}

function ref_12c1d(var0, var1) {
  var2 = [];
  var3 = [];

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

  if(isDefined(var3[var1])) {
    foreach(var5 in var0) {
      foreach(var7 in var3[var1]) {
        if(distance(var5.origin, var7) < 10) {
          var2 = var5;
          break;
        }
      }
    }
  }

  var0 = scripts\engine\utility::array_remove_array(var0, var2);
  return var0;
}

function ref_12805(var0, var1) {
  var2 = [];
  var3 = [];

  switch (level.mapname) {
    case "mp_piccadilly":
      var2 = [];
      var2[0] = [(-2376, -3322, 39), (0, -90, 0)];
      var2[1] = [(-2071, -3537, 0), (0, 180, 0)];
      var2[2] = [(-2071, -3653, 0), (0, 180, 0)];
      var2[3] = [(-2071, -3754, 3), (0, 180, 0)];
      var2 = [];
      var2[0] = [(2137, 493, 124), (0, -85, 0)];
      var2[1] = [(2302, 495, 128), (0, -90, 0)];
      var2[2] = [(2390, 495, 134), (0, -90, 0)];
      var2[3] = [(2457, 494, 134), (0, -90, 0)];
      break;
    case "mp_harbor":
      var2 = [];
      var2[0] = [(-722, -1428, 201), (0, 0, 0)];
      var2[1] = [(-722, -1567, 200), (0, 0, 0)];
      var2[2] = [(-721, -1496, 200), (0, 0, 0)];
      var2[3] = [(-721, -1639, 200), (0, 0, 0)];
      var2[4] = [(-720, -1711, 200), (0, 0, 0)];
      var2[5] = [(-720, -1806, 200), (0, 0, 0)];
      var2[6] = [(-719, -1896, 200), (0, 0, 0)];
      var2[7] = [(-719, -1999, 200), (0, 0, 0)];
      var2[8] = [(-483, -2074, 200), (0, -270, 0)];
      break;
    case "mp_vacant":
      var2 = [];
      var2[0] = [(4948, 1284, 9), (0, 45, 0)];
      break;
    case "mp_m_speed":
      var2 = [];
      var2[0] = [(-603, 3101, 33), (0, 155, 0)];
      var2 = [];
      var2[0] = [(-1070, 600, 32), (0, -20, 0)];
      break;
    case "mp_hardhat":
      var2 = [];
      var2[0] = [(1773, -1148, 302), (0, -90, 0)];
      var2[1] = [(2098, -1153, 292), (0, -90, 0)];
      break;
    case "mp_runner_pm":
    case "mp_runner":
      var2 = [];
      var2[0] = [(1648, 367, 291), (0, 0, 0)];
      var2[1] = [(1947, 859, 255), (0, 270, 0)];
      var2[2] = [(1691, 854, 291), (0, 270, 0)];
      break;
    case "mp_raid":
      var2 = [];
      var2[0] = [(-2404.94, -1457.67, 280), (0, 0, 0)];
      var2[1] = [(-849.814, -1158.33, 280), (0, 180, 0)];
      var2[2] = [(-1978.45, -341.57, 280), (0, 270, 0)];
      var2[3] = [(-1143, -975, 280), (0, 270, 0)];
      var2 = [];
      var2[0] = [(-1300.9, 4861.72, 269), (0, 180, 0)];
      var2[1] = [(-1300.9, 4947, 269), (0, 180, 0)];
      var2[2] = [(-1300.9, 4759, 269), (0, 180, 0)];
      var2[3] = [(-1293.48, 4459.81, 273), (0, 180, 0)];
      var2[4] = [(-1293.48, 4392, 274), (0, 180, 0)];
      var2[5] = [(-2300.19, 3725.48, 288), (0, 90, 0)];
      var2[6] = [(-1700.19, 3725.48, 286), (0, 90, 0)];
      var2[7] = [(-1598.19, 4348.83, 279), (0, 90, 0)];
      break;
    case "mp_hackney_yard":
    case "mp_hackney_am":
      var2 = [];
      var2[0] = [(765, -1883, 23), (0, 180, 0)];
      var2[1] = [(762, -2006, 187), (0, 180, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var2[var1])) {
    foreach(var5 in var2[var1]) {
      var6 = var5[0];
      var7 = var5[1];
      var8 = easepower("hardpoint_chevron", var6, var7);
      var3 = var8;
    }
  }

  var0 = scripts\engine\utility::array_combine(var0, var3);
  return var0;
}

function init_vo_arrays(var0, var1, var2) {
  var0.origin = var1;
  var0.angles = var2;
  return var0;
}

function setupgoalvisualsforjugg(var0) {
  var1 = var0.team;
  var2 = scripts\mp\utility\teams::getenemyteams(var1);
  var3 = var2[0];
  var4 = level.rugby.goals[var3];
  thread updatechevrons(var4);
  var5 = level.rugby.goals[var1];
  thread updatechevrons(var5);
}

function watchforjuggproximityscore(var0) {
  level endon("game_ended");
  self endon("endzone_deactivate");

  for(;;) {
    self.trigger waittill("trigger", var1);

    if(isDefined(var1.rugbyjugginfo) && var1.team != var0) {
      onjuggproximityscore(var1);
      return;
    }
  }
}

function activatenewjuggernaut(var0) {
  var1 = level.rugby;
  var2 = setupplayerasjugg(var0);

  if(!var2) {
    return false;
  }

  var3 = spawnStruct();
  var3.player = var0;
  var4 = var0 getentitynumber();
  var3.id = var4;
  var1.activejuggernauts[var4] = var0;
  level.ref_12dd4 = var0;
  var0.rugbyjugginfo = var3;
  createobjectiveiconsforactivejugg(var0, var3);
  startjugghud(var0);
  setupgoalvisualsforjugg(var0);
  thread watchjugghealth();
  thread watchforjuggdeathdisconnect();
  thread watchjuggprogress();
  thread watchteammatesnearjugg();

  if(getjuggtimeout() > 0) {
    thread watchjuggtimeout();
  }

  var0 scripts\mp\utility\dialog::leaderdialogonplayer("rugby_new_jugg", "obj");
  var0 thread scripts\mp\hud_message::showsplash("jugg_player");
  var5 = [var0];
  var6 = scripts\mp\utility\game::getotherteam(var0.team)[0];
  scripts\mp\utility\dialog::statusdialog("rugby_secured_jugg", var0.team, "obj", var5);
  scripts\mp\utility\dialog::statusdialog("rugby_lost_jugg", var6, "obj");
  thread ref_12451(level, var0.team);

  foreach(var8 in level.players) {
    if(var8.team == var0.team) {
      if(var8 != var0) {
        var8 thread scripts\mp\hud_message::showsplash("jugg_captured");
      }

      continue;
    }

    var8 thread scripts\mp\hud_message::showsplash("jugg_lost");
  }

  return true;
}

function ref_12451(var0, var1) {
  wait 3;
  scripts\mp\utility\dialog::statusdialog("rugby_order_attack", var0);
  scripts\mp\utility\dialog::statusdialog("rugby_order_fallback", var1);
}

function deactivatejuggernaut(var0) {
  var1 = level.rugby;
  var2 = var0.rugbyjugginfo;

  if(isDefined(var0)) {
    var0.rugbyjugginfo = undefined;
  }

  var1.activejuggernauts[var2.id] = undefined;
  level.ref_12dd4 = undefined;
  cleanupobjectiveiconsforjugg(var0, var2);
  clearjugghud();

  foreach(var4 in var1.endzones) {
    thread updatechevrons(var4[0]);
  }

  level.rugby.maxperkbonustier = undefined;
  level.rugby.ref_128bf = undefined;
  level.rugby.vehicle_occupancy_isfriendlytoplayer = undefined;
  level.rugby.vehicle_occupancy_isenemytoteam = undefined;

  if(isDefined(var0) && isDefined(var0.team)) {
    level thread scripts\mp\hud_message::notifyteam("jugg_down_fr", "jugg_down_en", var0.team);
  } else {
    level thread scripts\mp\hud_message::notifyteam("jugg_capture", "jugg_capture", "allies");
  }

  setomnvar("ui_rugby_jugg_timer", 0);
  setomnvar("ui_rugby_jugg_radial", 0);
  var0 notify("rugby_jugg_end");
}

function startjugghud(var0) {
  setomnvar("ui_rugby_jugg_client", var0);
  setomnvar("ui_rugby_jugg_health", 1);

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var2.team == var0.team, 0, 1));
  }
}

function clearjugghud() {
  setomnvar("ui_rugby_jugg_client", undefined);

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_rugby_jugg_friendly", -1);
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
  var0 = undefined;

  if(!isDefined(self)) {
    var0 = level.lastjuggpositions[self.rugbyjugginfo.id];
  } else {
    var0 = self.origin;
  }

  var1 = getnodesinradius(var0, 32, 0, 32);
  var2 = getclosestpointonnavmesh(var0);

  if(distance(var0, var2) > 50) {
    var2 = var0;
  }

  var2 = var0;
  activatejuggcrate(var2 + (0, 0, 0), (0, 0, 0));
  deactivatejuggernaut(self);
}

function watchjuggprogress() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  var0 = self.team;
  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = var1[0];
  var3 = level.rugby.goals[var0];
  var4 = level.rugby.goals[var2];
  var5 = var4.origin - var3.origin;
  var6 = vectordot(var5, var5);
  var7 = undefined;

  for(;;) {
    var8 = self.origin * (1, 1, 0) - var3.origin * (1, 1, 0);
    var9 = vectordot(var5, var8) / var6;
    var9 = clamp(var9, 0, 1);
    var10 = [];
    var10 = var9;
    var10 = 1 - var9;

    foreach(var12 in level.players) {
      if(var12.team == var0 || var12.team == var2) {
        var12 setclientomnvar("ui_rugby_jugg_progress", var10[var12.team]);
      }
    }

    if(var9 > 0.8) {
      thread getquestunlockableindexfromlootid(level, var9, var0);
    }

    if(isDefined(level.ref_12dd4)) {
      if(!isDefined(var7)) {
        var7 = var9;
      }

      if(var9 > var7 + 0.1) {
        var7 = var9;
        level.ref_12dd4 thread scripts\mp\utility\points::giveunifiedpoints("rugby_obj_push");
      }
    }

    level.lastjuggpositions[self.rugbyjugginfo.id] = self.origin;
    wait 0.05;
  }
}

function getquestunlockableindexfromlootid(var0, var1, var2) {
  if(!isDefined(level.rugby.maxperkbonustier)) {
    level.rugby.maxperkbonustier = 1;
    level.rugby.ref_128bf = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var0;
    level.rugby.vehicle_occupancy_isenemytoteam = var0;
  } else if(isDefined(level.rugby.ref_128bf) && level.rugby.ref_128bf + 30000 < gettime()) {
    level.rugby.maxperkbonustier = 1;
    level.rugby.ref_128bf = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var0;
    level.rugby.vehicle_occupancy_isenemytoteam = var0;
  }

  if(istrue(level.rugby.maxperkbonustier)) {
    scripts\mp\utility\dialog::statusdialog("rugby_friendly_close_goal", var1, "obj");
    scripts\mp\utility\dialog::statusdialog("rugby_enemy_close_goal", var2, "obj");
    thread scripts\mp\music_and_dialog::timelimitmusic(var1);
  }

  level.rugby.maxperkbonustier = 0;
}

function setupplayerasjugg(var0) {
  var1 = level.rugby.juggconfig;
  var2 = var0 scripts\mp\juggernaut::jugg_makejuggernaut(var1);

  if(!var2) {
    return false;
  }

  var0.droppeddeathweapon = 1;
  var0 givemaxammo(var0.classstruct.loadoutprimaryobject);
  var0.playerstreakspeedscale = getjuggspeedscalar(0);
  var0 scripts\mp\weapons::updatemovespeedscale();
  thread handlejuggjumpspam();
  var3 = scripts\mp\utility\teams::getenemyteams(var0.team);
  var4 = var3[0];
  return true;
}

function watchteammatesnearjugg() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    var0 = 0;

    foreach(var2 in level.players) {
      if(var2.team != self.team || var2 == self) {
        continue;
      }

      if(distancesquared(var2.origin, self.origin) < 122500) {
        var0++;
      }
    }

    self.playerstreakspeedscale = getjuggspeedscalar(var0);
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

function ref_12e18(var0) {
  level endon("stop_rugby_timeout");
  var0 endon("rugby_jugg_end");
  var1 = getdvarfloat("scr_rugby_juggTimeout");
  var2 = var1;

  while(!istrue(level.canprocessot)) {
    setomnvar("ui_rugby_jugg_radial", var2 / var1);
    var2 -= level.framedurationseconds;
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

    var0 = self getvelocity();
    var1 = (var0[0] * 0.25, var0[1] * 0.25, var0[2]);
    self setvelocity(var1);
    self.overrideweaponspeed_speedscale = 0.2;
    scripts\mp\weapons::updatemovespeedscale();

    for(;;) {
      var2 = scripts\engine\utility::ref_143b9(1, "jugg_jumped");

      if(var2 == "jugg_jumped") {
        while(!self isonground()) {
          waitframe();
        }

        var0 = self getvelocity();
        var1 = (var0[0] * 0.25, var0[1] * 0.25, var0[2]);
        self setvelocity(var1);
        continue;
      }

      break;
    }

    self.overrideweaponspeed_speedscale = undefined;
  }
}

function ref_12c4b() {
  var0 = 0;
  level.vehicle_occupancy_isfriendlytoteam = spawnStruct();
  level.vehicle_occupancy_isfriendlytoteam.objidnum = scripts\mp\objidpoolmanager::requestreservedid(var0);
}

function createobjectiveiconsforactivejugg(var0, var1) {
  createjuggobjective(var0, var1);
  var2 = scripts\mp\utility\teams::getenemyteams(var0.team);
  var3 = var2[0];
  var4 = level.rugby.goals[var3];
  createendzoneobjective(var4, var3, var1);
}

function cleanupobjectiveiconsforjugg(var0, var1) {
  scripts\mp\objidpoolmanager::update_objective_state(0, "done");
  scripts\mp\objidpoolmanager::returnobjectiveid(var1.endzoneobjid);
}

function createjuggobjective(var0, var1) {
  var2 = 0;
  var1.juggobjid = var2;
  scripts\mp\objidpoolmanager::objective_add_objective(var2, "current", var0.origin, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var2, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var2, 90);
  objective_setownerteam(var2, var0.team);
  objective_setfriendlylabel(var2, "MP_MODE_RUGBY/JUGG_ESCORT");
  objective_setenemylabel(var2, "MP_MODE_RUGBY/JUGG_KILL");
}

function createendzoneobjective(var0, var1, var2) {
  var3 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var2.endzoneobjid = var3;
  scripts\mp\objidpoolmanager::objective_add_objective(var3, "current", var0.origin, "icon_waypoint_rugby_base");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var3, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var3, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var3);
  objective_setownerteam(var3, var1);
  objective_setfriendlylabel(var3, "MP_MODE_RUGBY/ENDZONE_DEFEND");
  objective_setenemylabel(var3, "MP_MODE_RUGBY/ENDZONE_ASSAULT");
}

function activatejuggcrate(var0, var1, var2) {
  var3 = level.rugby;

  if(!vandalize_attack_min_cooldown(var0)) {
    var0 = level.init_ai_kill_params_for_events;
    var1 = level.init_ai;
  }

  var4 = createjuggcrate(var0, var1, var2);
  var3.activejuggcrates[0] = var4;
  var3.activejuggcrates[0].crateid = var4;
  return true;
}

function vandalize_attack_min_cooldown(var0) {
  var1 = 1;

  foreach(var3 in level.trial_target_headshot_func) {
    if(ispointinvolume(var0, var3)) {
      var1 = 0;
      break;
    }
  }

  return var1;
}

function createjuggcrate(var0, var1, var2) {
  var3 = getgroundposition(var0, 8, 2000, 32);
  var3 += (0, 0, 5);
  var4 = spawn("script_model", var3);
  var4.angles = var1;
  var4.visuals = [var4];
  var4.trigger = var4;
  var4.trigger.origin = var4.origin;
  var4.curorigin = var4.trigger.origin;
  var4.safeorigin = var4.trigger.origin;
  var4.visuals[0] setModel("military_carepackage_02_rupture");
  var4 thread scripts\mp\gameobjects::setdropped();
  var4.crateid = var4 getentitynumber();
  thread juggcratemanageuse(var4);

  if(istrue(var2)) {
    level.init_ai_kill_params_for_events = var0;
    level.init_ai = var1;

    foreach(var6 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("rugby_capture_jugg", var6, "obj");
    }
  }

  return var4;
}

function gunkillerhackthread() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var0 = getweaponarray();

    foreach(var2 in var0) {
      if(distance2dsquared(var2.origin, self.origin) < 40000) {
        var2 delete();
      }
    }

    wait 0.25;
  }
}

function juggcratemanageuse(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = spawn("script_model", self.origin + (0, 0, 30));
  var1.usetype = 1;
  var1.destination = self.origin + (0, 0, 30);
  var1.vampirepoints = 1;
  self.ref_14074 = scripts\mp\gameobjects::createholduseobject("neutral", var1, self.visuals, (0, 0, 64));

  foreach(var3 in level.teamnamelist) {
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

  foreach(var6 in level.teamnamelist) {
    self.ref_14074.numtouching[var6] = 0;
    self.ref_14074.touchlist[var6] = [];
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

function ref_12dd1(var0) {
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_taking", "icon_waypoint_losing");
  scripts\mp\utility\dialog::statusdialog("rugby_securing_jugg", var0.team, "obj");
  self.visuals[0] playLoopSound("mp_care_package_non_owner_cap");
}

function ref_12dd0(var0) {
  var1 = activatenewjuggernaut(var0);

  if(!var1) {
    return;
  }

  juggcratecleanup();
  level.rugby.activejuggcrates[0].crateid = undefined;
  level.rugby.activejuggcrates[0] = undefined;

  if(isDefined(self.ref_14074)) {
    self.ref_14074 delete();
  }

  if(isDefined(self.visuals)) {
    foreach(var3 in self.visuals) {
      var3 delete();
    }
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
    return;
  }
}

function ref_12dd2(var0, var1, var2) {
  self.visuals[0] stoploopsound("mp_care_package_non_owner_cap");

  if(!var2) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_jugg_crate");
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var1.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);

  if(self.curprogress > 0) {
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, var1.team);
    return;
  }

  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

function ref_12dd3(var0) {}

function juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
}

function createjuggcrateobjective(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var0.objid = var1;
  var2 = var0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var1, "current", var2, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1);
  objective_setneutrallabel(var1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  objective_setfriendlylabel(var1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  objective_setenemylabel(var1, "MP_MODE_RUGBY/CRATE_LOSING");
  updatejuggcrateobjectivestate(var0);
}

function updatejuggcrateobjectivestate(var0) {
  var1 = var0.objid;
  var2 = istrue(var0.inuse);

  if(var2) {
    objective_setownerteam(var1, var0.usingplayer.team);
    objective_sethot(var1, 1);
    return;
  }

  objective_setownerteam(var1, undefined);
  objective_sethot(var1, 0);
}

function get_circle_back_start_node(var0) {
  var1 = level.rugby.juggconfig;

  if(istrue(var0.isjuggernaut)) {
    var0 scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    return false;
  }

  var2 = var0 scripts\mp\juggernaut::vehicle_damage_setweaponhitdamagedata(var1);

  if(!isDefined(var2)) {
    var0 scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return false;
  }

  return true;
}

function updateoverheadcamerapos(var0) {
  if(isDefined(var0)) {
    var1 = var0;
    var2 = level.spectatorcameras[0][var1];
  } else {
    var1 = self.team;
    var2 = level.spectatorcameras[0][self.team];
  }

  var3 = level.rugby;
  var4 = undefined;

  if(!istrue(game["switchedsides"])) {
    var4 = var1;
  } else {
    var4 = scripts\engine\utility::ter_op(var1 == "allies", "axis", "allies");
  }

  var5 = scripts\engine\utility::ter_op(var4 == "allies", "axis", "allies");
  var6 = var3.endzones[var4][0].origin;
  var7 = var3.endzones[var5][0].origin;
  var8 = (var7 - var6) * (1, 1, 0);
  var9 = length2d(var8);
  var10 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var10)) {
    var11 = var10.origin[2];
  } else {
    var11 = 5000;
  }

  var12 = undefined;
  var13 = undefined;

  if(doesteamhaveactivejugg(var2)) {
    var14 = getjuggorcratepos();
    var12 = var14 + var9 * -3000 / var10;
    var12 = (var12[0], var12[1], var11);
    var13 = var14 + (var8 - var14) * 0.5;
  } else {
    var12 = var7 + var9 * -2000 / var10;
    var12 = (var12[0], var12[1], var11);
    var13 = getjuggorcratepos();
  }

  var15 = var13 - var12;
  var16 = vectortoangles(var15);
  var3.origin = var12;
  var3.angles = var16;
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
  var0 = level.spectatorcameras[0][self.team];
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

function movecameratomappos(var0, var1, var2) {
  var0 endon("spawned_player");
  var3 = 1;
  var4 = 1;
  self moveTo(var1, 1, 0.5, 0.5);
  var0 playlocalsound("mp_cmd_camera_zoom_out");
  var0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var2, 1, 0.5, 0.5);
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

function enableplayeroutlinesforoverheadcam() {
  self.rugbyoverheadoutlines = [];

  foreach(var1 in level.players) {
    if(var1 == self) {
      continue;
    }

    var2 = scripts\engine\utility::ter_op(var1.team == self.team, "outlinefill_nodepth_cyan", "outlinefill_nodepth_orange");
    var3 = scripts\mp\utility\outline::outlineenableforplayer(var1, self, var2, "level_script");
    self.rugbyoverheadoutlines[var3] = var1;
  }
}

function removeplayeroutlinesforoverheadcam() {
  if(isDefined(self.rugbyoverheadoutlines)) {
    foreach(var1 in self.rugbyoverheadoutlines) {
      scripts\mp\utility\outline::outlinedisable(var2, var1);
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