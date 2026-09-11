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

function onstartgametype(var0) {
  GscBinSkip1(0x45, 0, "dd");
}

function initspawns() {
  var0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_toair_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_toair_spawn_axis");
  var0.to_air_spawns = [];
  var0.to_air_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toair_spawn_allies");
  var0.to_air_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toair_spawn_axis");
}

function getspawnpoint() {
  var0 = level.tacopsspawns;
  var1 = self.pers["team"];
  var2 = undefined;
  var2 = var0.to_air_spawns[var1];
  var2 = scripts\mp\tac_ops_map::filterspawnpoints(var2);
  var3 = undefined;

  if(isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var4 = isDefined(level.escortheli[0]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[0];
    var5 = isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1];
    var6 = isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2];

    if(var4 || var5 && level.escortheli[1].spawnoccupied || var6 && level.escortheli[2].spawnoccupied) {
      var7 = scripts\engine\utility::player_drop_to_ground(self.tacopsmapselectedarea.dynamicent.origin, 32, 0, -1500, (0, 0, 1));
      self.tacopsmapselectedarea.dynamicent.spawnorigin = var7;
    } else if(isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      thread enterattackheli(level.escortheli[1].owner);
    } else if(isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      thread enterattackheli(level.escortheli[2].owner);
    }

    var8 = anglesToForward(self.tacopsmapselectedarea.dynamicent.angles);
    var8 *= (1, 1, 0);
    var9 = (0, 0, 1);
    var10 = vectorcross(var8, var9);
    var11 = axistoangles(var8, var10, var9);
    self.tacopsmapselectedarea.dynamicent.spawnangles = var11;
  }

  return var3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_air", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_air", "axis");
  level.getspawnpoint = &getspawnpoint;
}

function onnormaldeath(var0, var1, var2, var3, var4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4);
}

function onspawnplayer() {
  var0 = 0;

  if(self.team == "allies") {
    var0 = 1;

    if(!istrue(level.spawnedescortchopper)) {
      level.spawnedescortchopper = 1;
      thread setupheliobjective();
    }
  } else if(self.team == "axis") {
    var0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var0);
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

function constructhelipath(var0, var1) {
  var2 = getEnt(var1, "targetname");

  if(isDefined(var2) && isDefined(var2.target)) {
    var3 = getEntArray(var2.target, "targetname");

    if(isDefined(var3) && var3.size > 0) {
      level.airpathnodes[var0] = [];

      foreach(var5 in var3) {
        var6 = int(var5.script_noteworthy);
        level.airpathnodes[var0][var6] = [];

        for(var7 = var5;; var7 = getEnt(var7.target, "targetname")) {
          level.airpathnodes[var0][var6][level.airpathnodes[var0][var6].size] = var7;

          if(!isDefined(var7.target)) {
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

function spawnescortchopper(var0) {
  var1 = var0;
  var2 = (0, 0, 0);
  var3 = 24000;
  var4 = undefined;
  var5 = var0[2];
  var6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var5);
  var7 = 8000;
  var8 = "jackal";
  var9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var1, var2, var3, var4, var5, var7, var6, var8);
  var10 = fakestreakinfo();
  var11 = scripts\mp\killstreaks\jackal::beginjackalescort(0, var9["startPoint"], var1, var10, undefined);
  return var11;
}

function fakestreakinfo() {
  var0 = spawnStruct();
  var0.available = 1;
  var0.firednotify = "offhand_fired";
  var0.isgimme = 1;
  var0.kid = 5;
  var0.lifeid = 0;
  var0.madeavailabletime = gettime();
  var0.scriptuseagetype = "gesture_script_weapon";
  var0.streakname = "jackal";
  var0.streaksetupinfo = undefined;
  var0.variantid = -1;
  var0.weaponname = "ks_gesture_generic_mp";
  var0.objweapon = getcompleteweaponname(var0.weaponname);
  return var0;
}

function setupobjectives() {
  level.currentobjectiveindex = 0;
  level.currentobjective = undefined;
  level.objectives = [];
  wait 2;
  setupflags();
}

function setupflags() {
  var0 = getEntArray("flag_primary", "targetname");
  var1 = getEntArray("flag_secondary", "targetname");

  if(var0.size + var1.size == 0) {
    return;
  }

  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var2 = var0[var3];
  }

  for(var3 = 0; var3 < var1.size; var3++) {
    var2 = var1[var3];
  }

  var4 = [];
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

function helifollowpath(var0) {
  var1 = level.escortheli[var0];
  var2 = level.airpathnodes[var0][level.airpathidx];

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(var2)) {
    return;
  }

  for(var3 = 1; var3 < var2.size; var3++) {
    if(!isDefined(var1)) {
      return;
    }

    var4 = var2[var3];
    var5 = var4.origin;
    var1.combatmode = "guard_location";
    var1 notify(var1.combatmode);
    var1 thread scripts\mp\killstreaks\jackal::guardpositionescort(var5);

    if(isDefined(var1)) {
      var1 waittill("goal");
    }
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.trigger)) {
    var1 thread scripts\mp\killstreaks\jackal::guardpositionescort(undefined, level.currentobjective.trigger);
  }

  if(var0 == 0) {
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

function setheligoal(var0) {
  var1 = distance(level.attackheli.origin, var0);
  var2 = var1 / 150;
  var3 = 0.25;
  var4 = 0.25;
  level.attackheli moveTo(var0, var2, var3, var4);
  var5 = anglesToForward(level.attackheli.angles);
  var6 = vectorNormalize(var0 - level.attackheli.origin);
  thread changeheading(var5, var6, 2);
  return var2;
}

function changeheading(var0, var1, var2) {
  var3 = gettime();
  var4 = var3;
  var2 = int(var2 * 1000);
  var5 = var4 + var2;

  while(var3 < var5) {
    var6 = clamp((var3 - var4) / var2, 0, 1);
    var7 = vectorlerp(var0, var1, var6);
    level.attackheli.angles = scripts\mp\utility\script::vectortoanglessafe(var7, (0, 0, 1));
    waitframe();
    var3 = gettime();
  }
}

function dompoint_onbeginuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var0);
}

function dompoint_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  thread dompoint_holdtimer(var1);
}

function dompoint_onenduse(var0, var1, var2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
}

function dompoint_onuncontested(var0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var0);
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

function dompoint_holdtimer(var0) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  var1 = level.currentobjective.holdtime;

  if(var1 > 0) {
    wait var1;

    if(istrue(level.controltoprogress)) {
      var2 = scripts\mp\utility\game::getotherteam(var0)[0];

      for(;;) {
        if(level.currentobjective.touchlist[var2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  if(var0 == "allies") {
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

  foreach(var9, var1 in level.allowedspawnareas) {
    foreach(var3 in level.tacopsmap.activeconfigs[var9].spawnareas[var9]) {
      var4 = 0;

      foreach(var6 in level.allowedspawnareas[var9]) {
        if(var6 == var3.script_noteworthy) {
          var4 = 1;
          break;
        }
      }

      var3.enabled = var4;
    }
  }

  level notify("tac_ops_map_changed");
}

function enterattackheli(var0) {
  self waittill("spawned_player");
  self playerlinkTo(var0, "tag_origin");
  self remotecontrolturret(var0.turret);
  var0.spawnoccupied = 1;
  updateallowedspawnareas();
  thread watchearlyexit(var0);
  thread watchhelideath(var0);
}

function watchearlyexit(var0) {
  level endon("game_ended");
  var0 endon("death");
  self endon("leaving");
  var0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var0 waittill("killstreakExit");
  self remotecontrolturretoff(var0.turret);
  var1 = scripts\engine\utility::player_drop_to_ground(var0.origin, 32, 0, -1500, (0, 0, 1));
  self unlink();
  self dontinterpolate();
  self setOrigin(var1);
  var2 = anglesToForward(var0.angles);
  var2 *= (1, 1, 0);
  var3 = (0, 0, 1);
  var4 = vectorcross(var2, var3);
  var5 = axistoangles(var2, var4, var3);
  self setplayerangles(var5);
  var0.spawnoccupied = 0;
  updateallowedspawnareas();
  self notify("exited_heli");
}

function watchhelideath(var0) {
  self endon("exited_heli");
  var0 waittill("death");
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