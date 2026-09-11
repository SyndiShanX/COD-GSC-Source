/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_air.gsc
***********************************************/

function main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  }

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = &onstartgametype;
}

function maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype(1);
}

function maintacopsinit() {
  level.tacopssublevel = "to_air";
  level.currentmode = "to_air";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_air", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_air", 10);
    scripts\mp\utility\game::registerscorelimitdvar("to_air", 65);
    scripts\mp\utility\game::registerroundlimitdvar("to_air", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_air", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_air", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_air", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_air", 0);
    level.matchrules_damagemultiplier = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_to_air_waverespawndelay", 5);
  setdynamicdvar("scr_to_air_waverespawndelay_alt", 10);
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.controltoprogress = 1;
}

function onstartgametype(var_0) {
  GscBinSkip1(0x45, 0, "dd");
}

function initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_toair_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_toair_spawn_axis");
  var_0.to_air_spawns = [];
  var_0.to_air_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toair_spawn_allies");
  var_0.to_air_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toair_spawn_axis");
}

function getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["team"];
  var_2 = undefined;
  var_2 = var_0.to_air_spawns[var_1];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_2);
  var_3 = undefined;

  if(isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var_4 = isDefined(level.escortheli[0]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[0];
    var_5 = isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1];
    var_6 = isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2];

    if(var_4 || var_5 && level.escortheli[1].spawnoccupied || var_6 && level.escortheli[2].spawnoccupied) {
      var_7 = scripts\engine\utility::player_drop_to_ground(self.tacopsmapselectedarea.dynamicent.origin, 32, 0, -1500, (0, 0, 1));
      self.tacopsmapselectedarea.dynamicent.spawnorigin = var_7;
    } else if(isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      thread enterattackheli(level.escortheli[1].owner);
    } else if(isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      thread enterattackheli(level.escortheli[2].owner);
    }

    var_8 = anglesToForward(self.tacopsmapselectedarea.dynamicent.angles);
    var_8 *= (1, 1, 0);
    var_9 = (0, 0, 1);
    var_10 = vectorcross(var_8, var_9);
    var_11 = axistoangles(var_8, var_10, var_9);
    self.tacopsmapselectedarea.dynamicent.spawnangles = var_11;
  }

  return var_3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_air", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_air", "axis");
  level.getspawnpoint = &getspawnpoint;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

function onspawnplayer() {
  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;

    if(!istrue(level.spawnedescortchopper)) {
      level.spawnedescortchopper = 1;
      thread setupheliobjective();
    }
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

function seticonnames() {
  level.icontarget = "waypoint_hardpoint_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_enemy";
  level.icondefend = "koth_friendly";
  level.iconcontested = "waypoint_hardpoint_contested";
  level.icontaking = "waypoint_taking_chevron";
  level.iconlosing = "waypoint_hardpoint_losing";
  level.iconbombcapture = "waypoint_target";
  level.iconbombdefend = "waypoint_defend";
}

function setupairpath() {
  level.airpathnodes = [];
  constructhelipath(0, "air_path_0");
  constructhelipath(1, "air_path_1");
  constructhelipath(2, "air_path_2");
}

function constructhelipath(var_0, var_1) {
  var_2 = getEnt(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_2.target)) {
    var_3 = getEntArray(var_2.target, "targetname");

    if(isDefined(var_3) && var_3.size > 0) {
      level.airpathnodes[var_0] = [];

      foreach(var_5 in var_3) {
        var_6 = int(var_5.script_noteworthy);
        level.airpathnodes[var_0][var_6] = [];

        for(var_7 = var_5;; var_7 = getEnt(var_7.target, "targetname")) {
          level.airpathnodes[var_0][var_6][level.airpathnodes[var_0][var_6].size] = var_7;

          if(!isDefined(var_7.target)) {
            break;
          }
        }
      }

      return;
    }

    return;
  }
}

function setupheliobjective() {
  level.escortheli = [];
  level.escortheli[0] = spawnescortchopper(level.airpathnodes[0][0][0].origin);
  thread axiswinondeath();
  level.escortheli[1] = spawnescortchopper(level.airpathnodes[1][0][0].origin);
  level.escortheli[2] = spawnescortchopper(level.airpathnodes[2][0][0].origin);
  scripts\mp\tac_ops_map::adddynamicspawnarea("to_air", level.escortheli[0], "allies", "to_air_allies_blackhawk");
  scripts\mp\tac_ops_map::adddynamicspawnarea("to_air", level.escortheli[1], "allies", "to_air_allies_ah64_left");
  scripts\mp\tac_ops_map::adddynamicspawnarea("to_air", level.escortheli[2], "allies", "to_air_allies_ah64_right");
  level.escortheli[0].spawnoccupied = 0;
  level.escortheli[1].spawnoccupied = 0;
  level.escortheli[2].spawnoccupied = 0;
  updateallowedspawnareas();
  level.escortheli[0].trackedobject = level.escortheli[0] scripts\mp\gameobjects::createtrackedobject(level.escortheli[0], (0, 0, 0));
  level.escortheli[0].trackedobject scripts\mp\gameobjects::releaseid();
  level.escortheli[0].trackedobject scripts\mp\gameobjects::requestid(0, 1);
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setownerteam("allies");
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setvisibleteam("any");
  level.airpathidx = 0;
  level.escortheli[0] waittill("goal");
  followairpath();
}

function spawnescortchopper(var_0) {
  var_1 = var_0;
  var_2 = (0, 0, 0);
  var_3 = 24000;
  var_4 = undefined;
  var_5 = var_0[2];
  var_6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_5);
  var_7 = 8000;
  var_8 = "jackal";
  var_9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_1, var_2, var_3, var_4, var_5, var_7, var_6, var_8);
  var_10 = fakestreakinfo();
  var_11 = scripts\mp\killstreaks\jackal::beginjackalescort(0, var_9["startPoint"], var_1, var_10, undefined);
  return var_11;
}

function fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "offhand_fired";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "ks_gesture_generic_mp";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  return var_0;
}

function setupobjectives() {
  level.currentobjectiveindex = 0;
  level.currentobjective = undefined;
  level.objectives = [];
  wait 2;
  setupflags();
}

function setupflags() {
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_1.size == 0) {
    return;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_0[var_3];
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2 = var_1[var_3];
  }

  var_4 = [];
  GscBinSkip0(0x2e, 0, 10);
}

function disabledomflagscriptable() {
  scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function followairpath() {
  level.currentobjective = level.objectives[level.currentobjectiveindex];

  if(isDefined(level.currentobjective)) {
    level.currentobjective[[level.currentobjective.onenableobjective]]();
  }

  thread helifollowpath(0);
  thread helifollowpath(1);
  thread helifollowpath(2);
}

function helifollowpath(var_0) {
  var_1 = level.escortheli[var_0];
  var_2 = level.airpathnodes[var_0][level.airpathidx];

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_2)) {
    return;
  }

  for(var_3 = 1; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_1)) {
      return;
    }

    var_4 = var_2[var_3];
    var_5 = var_4.origin;
    var_1.combatmode = "guard_location";
    var_1 notify(var_1.combatmode);
    var_1 thread scripts\mp\killstreaks\jackal::guardpositionescort(var_5);

    if(isDefined(var_1)) {
      var_1 waittill("goal");
    }
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.trigger)) {
    var_1 thread scripts\mp\killstreaks\jackal::guardpositionescort(undefined, level.currentobjective.trigger);
  }

  if(var_0 == 0) {
    if(isDefined(level.currentobjective)) {
      level.currentobjective[[level.currentobjective.onactivateobjective]]();
    } else {
      scripts\mp\gamescore::_setteamscore("allies", 1, 0);
      thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["objective_completed"]);
    }

    level.airpathidx++;
    return;
  }
}

function setheligoal(var_0) {
  var_1 = distance(level.attackheli.origin, var_0);
  var_2 = var_1 / 150;
  var_3 = 0.25;
  var_4 = 0.25;
  level.attackheli moveTo(var_0, var_2, var_3, var_4);
  var_5 = anglesToForward(level.attackheli.angles);
  var_6 = vectorNormalize(var_0 - level.attackheli.origin);
  thread changeheading(var_5, var_6, 2);
  return var_2;
}

function changeheading(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = var_3;
  var_2 = int(var_2 * 1000);
  var_5 = var_4 + var_2;

  while(var_3 < var_5) {
    var_6 = clamp((var_3 - var_4) / var_2, 0, 1);
    var_7 = vectorlerp(var_0, var_1, var_6);
    level.attackheli.angles = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));
    waitframe();
    var_3 = gettime();
  }
}

function dompoint_onbeginuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var_0);
}

function dompoint_onuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  thread dompoint_holdtimer(var_1);
}

function dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
}

function dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var_0);
}

function dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, &disabledomflagscriptable);
}

function dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("friendly");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.icontarget);
  scripts\mp\gameobjects::setownerteam("axis");
  scripts\mp\gametypes\obj_dom::updateflagstate("axis", 0);
}

function dompoint_onactivateobjective() {
  level.flagcapturetime = self.captureduration;
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("enemy");
}

function dompoint_holdtimer(var_0) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  var_1 = level.currentobjective.holdtime;

  if(var_1 > 0) {
    wait var_1;

    if(istrue(level.controltoprogress)) {
      var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];

      for(;;) {
        if(level.currentobjective.touchlist[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  if(var_0 == "allies") {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    level.currentobjectiveindex++;
    updateallowedspawnareas();
    followairpath();
    return;
  }
}

function updateallowedspawnareas() {
  if(!isDefined(level.allowedspawnareas)) {
    level.allowedspawnareas = [];
  }

  level.allowedspawnareas["allies"] = [];
  level.allowedspawnareas["axis"] = [];

  if(isDefined(level.escortheli)) {
    level.allowedspawnareas["allies"][level.allowedspawnareas["allies"].size] = "to_air_allies_blackhawk";

    if(isDefined(level.escortheli[1]) && !istrue(level.escortheli[1].spawnoccupied)) {
      level.allowedspawnareas["allies"][level.allowedspawnareas["allies"].size] = "to_air_allies_ah64_left";
    }

    if(isDefined(level.escortheli[2]) && !istrue(level.escortheli[2].spawnoccupied)) {
      level.allowedspawnareas["allies"][level.allowedspawnareas["allies"].size] = "to_air_allies_ah64_right";
    }
  }

  switch (level.currentobjectiveindex) {
    case 0:
      level.allowedspawnareas["allies"][level.allowedspawnareas["allies"].size] = "to_air_allies_0";
      level.allowedspawnareas["axis"][level.allowedspawnareas["axis"].size] = "to_air_axis_0";
      break;
    case 1:
      level.allowedspawnareas["axis"][level.allowedspawnareas["axis"].size] = "to_air_axis_1";
      break;
    case 2:
      level.allowedspawnareas["axis"][level.allowedspawnareas["axis"].size] = "to_air_axis_2";
      break;
  }

  foreach(var_9, var_1 in level.allowedspawnareas) {
    foreach(var_3 in level.tacopsmap.activeconfigs[var_9].spawnareas[var_9]) {
      var_4 = 0;

      foreach(var_6 in level.allowedspawnareas[var_9]) {
        if(var_6 == var_3.script_noteworthy) {
          var_4 = 1;
          break;
        }
      }

      var_3.enabled = var_4;
    }
  }

  level notify("tac_ops_map_changed");
}

function enterattackheli(var_0) {
  self waittill("spawned_player");
  self playerlinkTo(var_0, "tag_origin");
  self remotecontrolturret(var_0.turret);
  var_0.spawnoccupied = 1;
  updateallowedspawnareas();
  thread watchearlyexit(var_0);
  thread watchhelideath(var_0);
}

function watchearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("leaving");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  self remotecontrolturretoff(var_0.turret);
  var_1 = scripts\engine\utility::player_drop_to_ground(var_0.origin, 32, 0, -1500, (0, 0, 1));
  self unlink();
  self dontinterpolate();
  self setOrigin(var_1);
  var_2 = anglesToForward(var_0.angles);
  var_2 *= (1, 1, 0);
  var_3 = (0, 0, 1);
  var_4 = vectorcross(var_2, var_3);
  var_5 = axistoangles(var_2, var_4, var_3);
  self setplayerangles(var_5);
  var_0.spawnoccupied = 0;
  updateallowedspawnareas();
  self notify("exited_heli");
}

function watchhelideath(var_0) {
  self endon("exited_heli");
  var_0 waittill("death");
  self suicide();
  updateallowedspawnareas();
}

function axiswinondeath() {
  level endon("game_ended");
  self waittill("death");
  wait 5;
  scripts\mp\gamescore::_setteamscore("axis", 1, 0);
  thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["objective_completed"]);
}