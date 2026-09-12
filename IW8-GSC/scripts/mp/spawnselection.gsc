/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnselection.gsc
***********************************************/

function init() {
  if(getdvarint("scr_game_usespawnselection", 0) == 0) {
    return;
  }

  level.usec130spawn = getdvarint("scr_game_c130_spawn", 0) == 1;
  level.usesquadspawn = getdvarint("scr_game_squad_spawn", 0) == 1;
  level.usesquadspawnselection = getdvarint("scr_game_spawnselection_squad", 1) == 1;
  level.checkspawnselectionafk = scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_game_spawnselection_afk", 1) == 1;
  level.usespawnselection = 0;
  level.availablespawnlocations = [];

  foreach(var_1 in level.teamnamelist) {
    level.availablespawnlocations[var_1] = [];
  }

  thread initspawns();
  scripts\common\ui::lui_registercallback("tac_ops_spawn_focus_changed", &endcondition_focuschanged);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&updatefobspawnsindanger);
}

function delayspawntoc130() {}

function churnareas() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, "lane01_");
}

function setspawnlocations(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.availablespawnlocations[var_1]) {
    if(issubstr(var_4, "dynamic") || issubstr(var_4, "vehicle") || issubstr(var_4, "squad")) {
      var_2 = var_4;
    }
  }

  level.availablespawnlocations[var_1] = [];

  foreach(var_7 in var_0) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_7)) {
      level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_7;
    }
  }

  foreach(var_7 in var_2) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_7)) {
      level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_7;
    }
  }
}

function allowspawnlocation(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_0)) {
    level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_0;
    return;
  }
}

function removespawnlocation(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.availablespawnlocations[var_1]) {
    if(var_4 != var_0) {
      var_2 = var_4;
    }
  }

  level.availablespawnlocations[var_1] = var_2;
}

function updatespawnareas() {
  level notify("tac_ops_map_changed");
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  setupspawnlocations();

  if(scripts\mp\utility\game::getgametype() == "arm") {
    setupspawninfluencezones();
    return;
  }
}

function setupspawnlocations() {
  while(!isDefined(level.gamemodespawnpointnames)) {
    waitframe();
  }

  level.spawnselectionlocations = [];

  foreach(var_22, var_1 in level.teamnamelist) {
    var_2 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[var_1]);
    scripts\mp\spawnlogic::registerspawnpoints(var_1, var_2);

    foreach(var_18, var_4 in var_2) {
      if(!isDefined(var_4.target) || var_4.target == "") {
        continue;
      }

      var_5 = getEntArray(var_4.target, "targetname");

      if(!isDefined(var_5) || var_5.size == 0) {
        var_5 = scripts\engine\utility::getStructArray(var_4.target, "targetname");
      }

      if(var_5.size == 0) {
        continue;
      }

      var_6 = undefined;

      if(var_5.size == 1) {
        var_6 = var_5[0];
      } else {
        jumpiffalse(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) LOC_0000013c;

        foreach(var_8 in var_5) {
          if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == level.localeid) {
            var_6 = var_8;
            break;
          }
        }

        goto LOC_0000018a;
      }

      if(!isDefined(var_14)) {
        continue;
      }

      var_15 = var_14.script_label;
      var_18 = var_2;

      if(isDefined(var_14.script_team) && scripts\mp\utility\teams::isgameplayteam(var_14.script_team)) {
        if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_quarry2" && var_14.targetname == "gw_fob_03_safe_axis") {
          var_18 = "axis";
        } else {
          var_18 = var_14.script_team;
        }
      }

      if(isDefined(level.spawnselectionlocations[var_15]) && isDefined(level.spawnselectionlocations[var_15][var_18])) {
        var_16 = level.spawnselectionlocations[var_15][var_18];

        if(!scripts\engine\utility::array_contains(var_16.spawnpoints, var_5)) {
          var_16.spawnpoints[var_16.spawnpoints.size] = var_5;
        }

        continue;
      }

      var_17 = spawnStruct();
      var_17.origin = var_14.origin;
      var_17.angles = var_14.angles;
      var_17.spawnpoints = [];
      var_17.spawnpoints[0] = var_5;

      if(!issubstr(var_15, "safe")) {
        initspawnarea(var_18, var_17, var_15);
      } else {
        level.spawnselectionlocations[var_15][var_18] = var_17;
      }
    }

    var_4 = undefined;
    var_19 = undefined;

    foreach(var_21 in level.spawnselectionlocations) {
      if(isDefined(var_21[var_2])) {
        scripts\mp\spawnlogic::registerspawnset(var_22 + "_" + var_2, var_21[var_2].spawnpoints);
      }
    }
  }

  var_1 = undefined;
  var_8 = undefined;
  level.usespawnselection = getdvarint("scr_game_usespawnselection", 0) == 1 && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection) {
    level.getspawnpoint = &getspawnpoint;
    return;
  }
}

function initspawnarea(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_2);
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_1.anchorentity = var_4;
  var_1.typeid = var_3;
  var_1.typeref = var_2;
  var_1.owner = "allies";

  if(!issubstr(var_2, "HQ") && !issubstr(var_2, "vehicle")) {
    var_5 = getlabelid(var_2 + "_" + level.localeid);

    if(!isDefined(var_5) || var_5 == -1) {
      var_1.labelid = var_3;
    } else {
      var_1.labelid = var_5;
    }
  } else {
    var_1.labelid = var_3;
  }

  if(isDefined(var_1.dynamicent)) {
    var_4 linkTo(var_1.dynamicent);
  }

  level.spawnselectionlocations[var_2][var_0] = var_1;
}

function getlabelid(var_0) {
  var_1 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_0);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  return var_1;
}

function setanchorent(var_0, var_1, var_2) {
  level.spawnselectionlocations[var_0][var_1].anchorentity = var_2;
}

function setupspawninfluencezones() {
  level.spawninfluencezones = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    var_1 = scripts\cp_mp\utility\game_utility::getlocaleent("gw_fob_0" + var_0 + "_spawnInfluenceZone");

    if(!isDefined(var_1)) {
      continue;
    }

    scripts\mp\utility\trigger::makeenterexittrigger(var_1, &spawninfluencezone_onusebegin, &spawninfluencezone_onuseend);
    var_1.touchlist = [];
    level.spawninfluencezones["gw_fob_0" + var_0] = var_1;
  }
}

function spawninfluencezone_onusebegin(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }

  var_1.touchlist = scripts\engine\utility::array_add(var_1.touchlist, var_0);
}

function spawninfluencezone_onuseend(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }

  var_1.touchlist = scripts\engine\utility::array_remove(var_1.touchlist, var_0);
}

function isteamtouching(var_0) {
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in self.touchlist) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(isDefined(var_4.team) && var_4.team == var_0) {
      var_1 = 1;
    }

    var_2 = var_4;
  }

  self.touchlist = var_2;
  return var_1;
}

function getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(isDefined(self.thrust_fx_model)) {
    var_0 = self.thrust_fx_model;
    self.thrust_fx_model = undefined;
    return var_0;
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.team]);
    var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    return var_0;
  }

  var_0 = undefined;
  self.ref_1443D = 0;

  if(!isDefined(self.selectedspawnarea)) {
    if(self.team == "allies") {
      self.selectedspawnarea = "gw_fob_alliesHQ";
    } else {
      self.selectedspawnarea = "gw_fob_axisHQ";
    }
  }

  if(isDefined(self.selectedspawnarea)) {
    if(issubstr(self.selectedspawnarea, "squad")) {
      var_2 = undefined;

      if(self.selectedspawnarea == "squad_leader") {
        var_2 = level.squaddata[self.team][self.squadindex].squadleaderindex;
      } else {
        var_2 = int(getsubstr(self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size));
      }

      var_3 = level.squaddata[self.team][self.squadindex].players[var_2];
      var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_3);
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("squad_spawn");
      thread scripts\mp\utility\points::giveunifiedpoints("squad_spawn_self");
      self.ref_1443D = 1;

      if(isDefined(var_3.vehicle)) {
        self.spawningintovehicle = 1;
        self.ref_14268 = var_3.vehicle.vehiclename;
      }

      scripts\mp\utility\stats::incpersstat("spawnSelectSquad", 1);
      var_3 scripts\mp\utility\stats::incpersstat("timesSelectedAsSquadLeader", 1);
    } else if(issubstr(self.selectedspawnarea, "dynamic")) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      thread scripts\mp\gametypes\arm::spawnplayertoc130();
    } else if(issubstr(self.selectedspawnarea, "vehicle")) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      var_4 = level.spawnselectionlocations[self.selectedspawnarea][self.team].dynamicent;
      var_0.origin = var_4.origin + anglesToForward(var_4.angles) * -200 + (0, 0, 64);
      var_0.angles = (0, var_4.angles[1], 0);
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_4, 1);

      if(var_5.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_4))) {
        var_6 = spawnStruct();
        var_6.useonspawn = 1;
        var_6.enterstartwaitmsg = "spawned_player";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_4, var_5[0], self, var_6);
      }

      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else {
      if(isDefined(level.spawninfluencezones)) {
        var_7 = undefined;
        var_8 = getarraykeys(level.spawninfluencezones);

        foreach(var_10 in var_8) {
          if(var_10 == self.selectedspawnarea) {
            var_7 = level.spawninfluencezones[var_10];
          }
        }

        if(isDefined(var_7) && isteamtouching(var_7, scripts\mp\utility\game::getotherteam(self.team)[0])) {
          var_12 = self.selectedspawnarea + "_safe_" + self.team;
          var_13 = level.spawnglobals.spawnsets[var_12];

          if(!isDefined(var_13)) {
            var_12 = self.selectedspawnarea + "_" + self.team;
          }
        } else {
          var_12 = self.selectedspawnarea + "_" + self.team;
        }
      } else {
        var_12 = self.selectedspawnarea + "_" + self.team;
      }

      scripts\mp\spawnlogic::activatespawnset(var_12, 1);
      var_12 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");

      if(issubstr(self.selectedspawnarea, "alliesHQ") || issubstr(self.selectedspawnarea, "axisHQ")) {
        scripts\mp\utility\stats::incpersstat("spawnSelectBase", 1);
      } else {
        scripts\mp\utility\stats::incpersstat("spawnSelectFlag", 1);
      }
    }
  } else {
    var_12 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var_14 = self getspectatingplayer();

    if(isDefined(var_14) && isDefined(self.squadindex) && self.team == var_14.team && self.squadindex == var_14.squadindex) {
      var_12 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_14);
      var_14 thread scripts\mp\utility\points::sec_sys_struct_1("squad_spawn");
      thread scripts\mp\utility\points::sec_sys_struct_1("squad_spawn_self");
      self.ref_1443D = 1;
    }
  }

  return var_12;
}

function refreshplayerspawnareaomnvars() {
  for(var_0 = 0; var_0 < 16; var_0++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_0, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var_0, -1);
  }

  if(isDefined(self.forcedavailablespawnlocation)) {
    picklane(self.forcedavailablespawnlocation);
  }

  thread obj_room_fire_03();

  if(istrue(level.usesquadspawnselection)) {
    thread evaluatesquadspawn();
    return;
  }
}

function obj_room_fire_03() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  var_0 = [];

  for(;;) {
    if(var_0.size > level.availablespawnlocations[self.team].size) {
      thread refreshplayerspawnareaomnvars();
      return;
    }

    var_1 = 0;

    foreach(var_3 in level.availablespawnlocations[self.team]) {
      if(!isDefined(var_0[var_1])) {
        break;
      }

      if(var_0[var_1].location != var_3) {
        thread refreshplayerspawnareaomnvars();
        return;
      }

      var_1++;
    }

    var_1 = 0;

    foreach(var_3 in level.availablespawnlocations[self.team]) {
      var_6 = level.spawnselectionlocations[var_3][self.team];

      if(var_1 == var_0.size) {
        var_7 = spawnStruct();
        var_7.location = undefined;
        var_7.entity = undefined;
        var_7.id = undefined;
        var_0 = var_7;
      }

      if(!isDefined(var_0[var_1].location)) {
        var_0[var_1].location = var_3;
      }

      if(!isDefined(var_0[var_1].entity)) {
        var_0[var_1].entity = var_6.anchorentity;
        self setclientomnvar("ui_tom_spawn_entity_" + var_1, var_6.anchorentity);
      }

      var_8 = 0;
      var_9 = 0;
      var_10 = 0;

      if(isDefined(var_6.objectivekey)) {
        var_8 = istrue(var_6.start_reach_icbm_launch);
      } else if(issubstr(var_3, "vehicle")) {
        var_11 = var_6.dynamicent;

        if(isDefined(var_11) && !istrue(var_11.isdestroyed)) {
          var_8 = istrue(var_11.start_reach_icbm_launch);
          var_9 = shouldmodelognotify(var_11, self);

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_11).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_11))) {
            var_10 = 1;
          }
        }
      }

      var_12 = var_6.labelid;

      if(var_8) {
        var_12 += 128;
      }

      if(istrue(var_10)) {
        var_12 += 1024;
      }

      if(istrue(var_9)) {
        var_12 += 2048;
      }

      if(!isDefined(var_0[var_1].id) || var_0[var_1].id != var_12) {
        var_0[var_1].id = var_12;
        self setclientomnvar("ui_tom_spawn_id_" + var_1, var_12);
      }

      var_1++;
    }

    waitframe();
  }
}

function ref_12ACB(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  waitframe();
  var_2 = level.squaddata[var_0][var_1].players;
}

function isobjectiveindanger(var_0, var_1) {
  return level.objectives[var_0].ownerteam != var_1 || level.objectives[var_0].stalemate || level.objectives[var_0].captureblocked || istrue(level.objectives[var_0].ref_13686) || level.objectives[var_0].claimteam != "none" && level.objectives[var_0].claimteam != var_1;
}

function vault_gate_cut(var_0) {
  var_1 = gettime();
  var_2 = isDefined(var_0) && isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_1;
  var_3 = isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger();
  var_4 = 0;

  if(isDefined(var_0.team)) {
    var_5 = scripts\common\utility::playersnear(var_0.origin, 384);

    foreach(var_7 in var_5) {
      if(isDefined(var_7) && var_7.team != var_0.team && isalive(var_7) && !isDefined(var_7.fauxdead)) {
        if(abs(var_0.origin[2] - var_7.origin[2]) < 100) {
          var_4 = 1;
          break;
        }
      }
    }
  }

  return var_2 || var_3 || var_4;
}

function ref_1424C(var_0) {
  var_0 endon("death");
  var_0.start_reach_icbm_launch = 0;
  var_1 = getdvarfloat("scr_gw_apc_ignore_damage_health_pct", 0.15);

  for(;;) {
    var_2 = gettime();
    var_3 = istrue(var_0.flarecooldown);
    var_4 = scripts\cp_mp\utility\weapon_utility::islockedonto(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141C7(var_0);
    var_6 = isDefined(var_0) && isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_2;

    if(var_0.vehiclename == "apc_russian") {
      var_7 = var_0.health / var_0.maxhealth;

      if(var_7 > var_1) {
        var_6 = 0;
      }
    }

    var_8 = isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger();
    var_9 = 0;

    if(isDefined(var_0.team)) {
      var_10 = scripts\common\utility::playersnear(var_0.origin, 384);

      foreach(var_12 in var_10) {
        if(isDefined(var_12) && var_12.team != var_0.team && isalive(var_12) && !isDefined(var_12.fauxdead)) {
          if(abs(var_0.origin[2] - var_12.origin[2]) < 100) {
            var_9 = 1;
            break;
          }
        }
      }
    }

    var_14 = var_0.start_reach_icbm_launch;

    if(var_6 || var_8 || var_9 || var_3 || var_4 || !var_5) {
      var_0.start_reach_icbm_launch = 1;
    } else {
      var_0.start_reach_icbm_launch = 0;
    }

    waitframe();
  }
}

function shouldmodelognotify(var_0, var_1) {
  var_2 = level.squaddata[self.team][self.squadindex].players;

  foreach(var_4 in var_0.occupants) {
    foreach(var_6 in var_2) {
      if(var_6 == var_4) {
        return true;
      }
    }
  }

  return false;
}

function setspawnselectionorder() {
  var_0 = scripts\engine\utility::getStructArray("axisLeft_alliesRight", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_1 = undefined;

    foreach(var_3 in var_0) {
      if(var_3.script_noteworthy == level.localeid) {
        var_1 = var_3;
      }
    }
  } else {
    var_1 = scripts\engine\utility::getStruct("axisLeft_alliesRight", "targetname");
  }

  var_5 = [];

  foreach(var_11, var_7 in level.spawnselectionlocations) {
    foreach(var_9 in var_7) {
      if(var_10 != self.team) {
        continue;
      }

      var_5 = var_9;
    }
  }

  if(self.team == "axis") {
    var_12 = var_1 scripts\engine\utility::array_sort_with_func(var_5, &sortlocationsbydistance_closestfirst);
  } else {
    var_12 = var_5 scripts\engine\utility::array_sort_with_func(var_6, &sortlocationsbydistance_farthestfirst);
  }

  foreach(var_14 in var_12) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_11, var_14.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + var_11, var_14.labelid);
  }
}

function sortlocationsbydistance_closestfirst(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

function sortlocationsbydistance_farthestfirst(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) > distancesquared(var_1.origin, self.origin);
}

function picklane(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_3, var_0)) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.spawnselectionlocations[var_1])) {
    return;
  }

  var_5 = level.spawnselectionlocations[var_1][self.team];

  if(!isDefined(var_5)) {
    return;
  }

  var_6 = self.team == "allies";
  var_7 = 0;

  switch (var_0) {
    case "spawn_selection_a":
    case "lane03_":
    case "left":
      var_7 = scripts\engine\utility::ter_op(var_6, 0, 2);
      break;
    case "spawn_selection_b":
    case "lane02_":
    case "mid":
      var_7 = 1;
      break;
    case "spawn_selection_c":
    case "lane01_":
    case "right":
      var_7 = scripts\engine\utility::ter_op(var_6, 2, 0);
      break;
  }

  self setclientomnvar("ui_tom_spawn_entity_" + var_7, var_5.anchorentity);
  self setclientomnvar("ui_tom_spawn_id_" + var_7, var_5.labelid);
}

function refreshsquadspawns() {
  var_0 = 3;

  foreach(var_2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_2, "squad_")) {
      var_3 = level.spawnselectionlocations[var_2][self.team];
      self setclientomnvar("ui_tom_spawn_entity_" + var_0, var_3.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var_0, var_3.labelid);
      var_0++;
    }
  }
}

function refreshdynamicspawns() {
  var_0 = 6;

  foreach(var_2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_2, "dynamic_")) {
      if(!isDefined(level.spawnselectionlocations[var_2][self.team])) {
        continue;
      }

      var_3 = level.spawnselectionlocations[var_2][self.team];

      if(!isDefined(var_3)) {
        continue;
      }

      self setclientomnvar("ui_tom_spawn_entity_" + var_0, var_3.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var_0, var_3.labelid);
      var_0++;
    }
  }
}

function waitforspawnselection(var_0, var_1) {
  if(istrue(level.gameended) || istrue(level.nukedetonated)) {
    pickrandomnonvehiclespawn();
    return;
  }

  if(isDefined(self.setspawnpoint)) {
    return;
  }

  self endon("disconnect");
  self.selectedspawnarea = undefined;
  refreshplayerspawnareaomnvars();
  getclosestavailablespawnlocation();

  if(istrue(level.forcetopickafob)) {
    timeuntilspawnmessaging(1, 9);
    pickrandomnonvehiclespawn();
    return;
  }

  if(isai(self) || istrue(var_1) || issubstr(self.name, "_hl_")) {
    timeuntilspawnmessaging(var_0, 9);

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      return;
    }

    pickrandomnonvehiclespawn();
    return;
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  self lerpfovscalefactor(0, 0.2);
  spawnselectionthink(var_0);
  self lerpfovscalefactor(1, 0.2);
}

function pickrandomnonvehiclespawn() {
  var_0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "fob") || issubstr(var_2, "HQ")) {
      self.selectedspawnarea = var_2;
      return;
    }
  }
}

function ref_1234C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "vehicle";
  }

  var_1 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "vehicle")) {
      self.selectedspawnarea = var_3;
      return;
    }
  }
}

function ref_1234B() {
  var_0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);
  self.selectedspawnarea = var_0[0];
}

function spawnselectionthink(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  thread getinitialwinningteam();

  if(istrue(level.gameended)) {
    return;
  }

  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }

  if(istrue(level.nukedetonated)) {
    return;
  }

  scripts\mp\class::loadout_clearperks();
  thread scripts\mp\spawncamera::startspawncamera(0, 1.5, 0.5);
  self.inspawnselection = 1;
  self setclientomnvar("ui_hide_objectives", 1);
  thread selectiondelaymessaging(var_0);

  if(istrue(level.spawnselectionshowfriendly) || istrue(level.spawnselectionshowenemy)) {
    thread scripts\mp\flashpoint::flashpoint_spawnselectionvfx();
  }

  if(istrue(level.ref_13377)) {
    thread scripts\mp\gametypes\arm::ref_1420E();
  }

  if(istrue(level.ref_13375)) {
    thread scripts\mp\gametypes\arm::ref_1420F();
  }

  wait 0.5;

  if(!istrue(level.hideenemyhq)) {
    thread scripts\mp\gametypes\arm::spawnselection_showenemyhq();
  }

  self setclientomnvar("ui_hide_objectives", 0);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  timeuntilspawnmessaging(var_0, 9);
  thread selectionmade();
  jumpiffalse(istrue(level.checkspawnselectionafk)) LOC_000000e8;
  thread watchforafk();

  for(;;) {
    var_1 = watchendconditions();
    var_2 = 1;

    switch (var_1) {
      case "tac_ops_map_selection_valid":
        var_2 = 1;
        break;
      case "tac_ops_map_changed":
        var_2 = 0;
        refreshplayerspawnareaomnvars();
        break;
      case "tac_ops_map_cleared":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "spawned_player":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_map_game_ended":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_spawn_focus_changed":
        var_2 = 0;
        break;
      case "tac_ops_map_nuke":
        var_2 = 0;
        self setclientomnvar("ui_hide_objectives", 1);
        self setclientomnvar("ui_tac_ops_map_open", 0);
        thread spawnselectionshutdown_nuke();
        break;
      default:
        break;
    }

    if(var_2) {
      self notify("stop_spawnselection_afk");
      self setclientomnvar("ui_tac_ops_map_open", 0);
      self.inspawnselection = 0;
      return;
    }
  }
}

function getinitialwinningteam() {
  self endon("stop_spawnselection_afk");
  self endon("disconnect");

  while(!istrue(level.gameended)) {
    waitframe();
  }

  self setclientomnvar("ui_tac_ops_map_open", 0);
}

function watchforafk() {
  self endon("disconnect");
  self endon("stop_spawnselection_afk");

  if(isDefined(level.ref_1369C)) {
    wait level.ref_1369C;
  } else {
    wait 60;
  }

  self notify("afk_disconnection_imminent");
  wait 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

function selectiondelaymessaging(var_0) {
  self endon("disconnect");
  self.canprocessselection = 0;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    self setclientomnvar("ui_arm_respawnTimerActive", 1);
  }

  if(var_0 > 0) {
    wait var_0;
  }

  if(scripts\mp\utility\game::getgametype() == "arm") {
    self setclientomnvar("ui_arm_respawnTimerActive", 0);
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(16);
  self.canprocessselection = 1;

  if(isDefined(self.selectedspawnarea)) {
    validateselectedspawnarea();
    return;
  }
}

function validateselectedspawnarea() {
  foreach(var_1 in level.availablespawnlocations[self.team]) {
    if(var_1 == self.selectedspawnarea) {
      self notify("tac_ops_map_selection_made");
      return;
    }
  }

  self.selectedspawnarea = undefined;
}

function selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "tac_ops_spawn_area_selected") {
      var_1 = ref_1400A(var_1);
      var_2 = undefined;

      foreach(var_5, var_4 in level.spawnselectionlocations) {
        if(isDefined(var_4[self.team]) && isDefined(var_4[self.team].anchorentity) && var_4[self.team].anchorentity getentitynumber() == var_1) {
          ref_1401D(var_4[self.team].typeref, self, self.team);

          if(isDefined(var_4[self.team].objectivekey) && isobjectiveindanger(var_4[self.team].objectivekey, self.team)) {
            break;
          }

          if(isDefined(var_4[self.team].typeref) && issubstr(var_4[self.team].typeref, "vehicle") && istrue(var_4[self.team].dynamicent.start_reach_icbm_launch)) {
            break;
          }

          var_2 = var_4[self.team].typeref;
          break;
        }
      }

      if(!isDefined(var_2)) {
        var_6 = round_get_vehicles(self.team, self.squadindex);

        foreach(var_4 in var_6) {
          if(isDefined(var_4.dynamicent) && var_4.dynamicent getentitynumber() == var_1) {
            if(var_4.dynamicent.team != self.team || var_4.dynamicent.squadindex != self.squadindex) {
              thread refreshplayerspawnareaomnvars();
              break;
            }

            if(issquadmateindanger(var_4.dynamicent)) {
              break;
            }

            var_8 = var_4.dynamicent.vehicle;

            if(isDefined(var_8)) {
              if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_8).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_8))) {
                break;
              }
            }

            var_9 = spawnStruct();
            var_9 = scripts\mp\spawnscoring::get_cumulative_damage_expire_time(var_9, var_3.dynamicent);

            if(!isDefined(var_9.ref_1368A)) {
              var_3.dynamicent.ref_11EAC = gettime();
              break;
            }

            <
            error > = var_1.typeref;
            break;
          }
        }

        var_4 = undefined;
        var_5 = undefined;
      }

      if(!isDefined( < error > )) {
        continue;
      }

      self.selectedspawnarea = < error > ;

      if(istrue(self.canprocessselection)) {
        self notify("tac_ops_map_selection_made");
        return;
      }
    }
  }
}

function ref_1400A(var_0) {
  if(!isDefined(self.setaardata)) {
    self.setaardata = [];
  }

  var_1 = 65536;
  var_2 = 131072;
  var_3 = 262144;
  var_4 = 524288;
  self.setaardata["rightmouseup"] = istrue(self.setaardata["rightmouseup"]) || (var_0 &var_1) > 0;
  self.setaardata["leftmouseup"] = istrue(self.setaardata["leftmouseup"]) || (var_0 &var_2) > 0;
  self.setaardata["activate"] = istrue(self.setaardata["activate"]) || (var_0 &var_3) > 0;
  self.setaardata["gostand"] = istrue(self.setaardata["gostand"]) || (var_0 &var_4) > 0;
  return var_0 &~(var_1 | var_2 | var_3 | var_4);
}

function watchendconditions() {
  self endon("disconnect");
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  thread endconditionwatcher_nuke();
  var_0 = scripts\engine\utility::ref_143B8("tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke");
  self notify("tac_ops_end_condition_met");
  return var_0;
}

function endconditionwatcher_selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("tac_ops_map_selection_made");

    if(istrue(self.canprocessselection)) {
      self notify("tac_ops_map_selection_valid");
      break;
    }
  }
}

function endcondition_focuschanged(var_0) {
  if(isDefined(self.selectedspawnarea)) {
    return;
  }

  self endon("disconnect");
  self notify("endConditionWatcher_FocusChanged()");
  self endon("endConditionWatcher_FocusChanged()");
  self notify("tac_ops_spawn_focus_changed");
  var_1 = undefined;

  foreach(var_3 in level.spawnselectionlocations) {
    if(isDefined(var_3[self.team]) && isDefined(var_3[self.team].anchorentity) && var_3[self.team].anchorentity getentitynumber() == var_0) {
      thread vehicle_registerturret(var_3[self.team].anchorentity.origin);
      var_1 = var_3[self.team].typeref;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_5 = round_get_vehicles(self.team, self.squadindex);

    foreach(var_3 in var_5) {
      if(isDefined(var_3.dynamicent) && var_3.dynamicent getentitynumber() == var_0) {
        thread vehicle_registerturret(var_3.dynamicent.origin);
        var_1 = var_3.typeref;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    return;
  }

  self setclientomnvar("ui_tom_veh_health_percent", 0);

  if(issubstr(var_1, "squad")) {
    thread managesquadcameraposition(var_1);
    var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_1);
    self setclientomnvar("ui_tom_previous_selection", var_8);
    return;
  }

  if(issubstr(var_2, "vehicle")) {
    thread managevehiclecameraposition(var_2);
    thread ref_11AB3(var_2);
    var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_2);
    self setclientomnvar("ui_tom_previous_selection", var_8);
    return;
  }

  var_8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_3 + "_" + level.localeid);
  self setclientomnvar("ui_tom_previous_selection", var_8);

  if(isDefined(level.spawncameras[var_3]) && isDefined(level.spawncameras[var_3][self.team])) {
    self.forcedspawncameraref = var_3;

    while(!scripts\mp\flags::gameflag("prematch_done")) {
      waitframe();
    }

    thread scripts\mp\spawncamera::movetospawncamera(0);
    return;
  }
}

function vehicle_registerturret(var_0) {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");
  self endon("spawned_player");
  self notify("keepStreamPosFresh");
  self endon("keepStreamPosFresh");

  if(!isDefined(level.ref_145DF)) {
    level.ref_145DF = max(getdvarint("cg_worldStreamingKeepAliveTimeout", 20000) * 0.5 / 1000, 1);
  }

  for(;;) {
    self predictstreampos(var_0, 1);
    wait level.ref_145DF;
  }
}

function endconditionwatcher_gameended() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_GameEnded()");
  self endon("endConditionWatcher_GameEnded()");
  level waittill("game_ended");
  self notify("tac_ops_map_game_ended");
}

function endconditionwatcher_mapcleared() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapCleared()");
  self endon("endConditionWatcher_MapCleared()");
  level waittill("tac_ops_map_cleared");
  self notify("tac_ops_map_cleared");
}

function endconditionwatcher_mapchanged() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapChanged()");
  self endon("endConditionWatcher_MapChanged()");
  level waittill("tac_ops_map_changed");
  self notify("tac_ops_map_changed");
}

function endconditionwatcher_nuke() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_Nuke()");
  self endon("endConditionWatcher_Nuke()");
  level waittill("nuke_detonated");
  self notify("tac_ops_map_nuke");
}

function spawnselectionshutdown_nuke() {
  if(!istrue(self.inspawnselection)) {
    return;
  }

  self visionsetnakedforplayer("nuke_global_aftermath", 0.05);
  wait 2;

  if(!istrue(self.inspawnselection)) {
    return;
  }

  self visionsetnakedforplayer("flir_0_black_to_white_heavy_damage", 0.05);
}

function adddynamicspawnarea(var_0, var_1, var_2, var_3) {
  if(isDefined(level.spawnselectionlocations[var_2]) && isDefined(level.spawnselectionlocations[var_2][var_0])) {
    var_4 = level.spawnselectionlocations[var_2][var_0];
    var_4.origin = var_1.origin + scripts\engine\utility::ter_op(isDefined(var_3), var_3, (0, 0, 0));
    var_4.angles = var_1.angles;
    return;
  }

  var_4 = spawnStruct();
  var_4.origin = var_2.origin + scripts\engine\utility::ter_op(isDefined(var_4), var_4, (0, 0, 0));
  var_4.angles = var_2.angles;
  var_4.dynamicent = var_2;
  var_4.script_noteworthy = var_3;
  initspawnarea(var_1, var_4, var_3);
  updatespawnareas();
}

function removedynamicspawnarea(var_0, var_1) {
  if(isDefined(level.spawnselectionlocations[var_1]) && isDefined(level.spawnselectionlocations[var_1][var_0])) {
    level.spawnselectionlocations[var_1][var_0] = undefined;

    if(level.spawnselectionlocations[var_1].size == 0) {
      level.spawnselectionlocations[var_1] = undefined;
    }
  }

  updatespawnareas();
}

function round_get_vehicles(var_0, var_1) {
  var_2 = [];

  if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[var_0]) && isDefined(level.squadspawnselectionlocations[var_0][var_1])) {
    var_2 = level.squadspawnselectionlocations[var_0][var_1];
  }

  return var_2;
}

function updatesquadspawn(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.squadspawnselectionlocations)) {
    level.squadspawnselectionlocations = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[var_0])) {
    level.squadspawnselectionlocations[var_0] = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[var_0][var_1])) {
    level.squadspawnselectionlocations[var_0][var_1] = [];
  }

  if(isDefined(level.squadspawnselectionlocations[var_0][var_1][var_2])) {
    if(!isDefined(var_3)) {
      level.squadspawnselectionlocations[var_0][var_1][var_2] = undefined;
      return;
    }

    var_4 = level.squadspawnselectionlocations[var_0][var_1][var_2];
    var_4.typeref = var_2;
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4.dynamicent = var_3;
    return;
  }

  if(!isDefined(var_4)) {
    return;
  }

  var_4 = spawnStruct();
  var_4.typeref = var_3;
  var_4.origin = var_4.origin;
  var_4.angles = var_4.angles;
  var_4.dynamicent = var_4;
  level.squadspawnselectionlocations[var_1][var_2][var_3] = var_4;
}

function removespawnareaondeathdisconnect(var_0, var_1) {
  self endon("tac_ops_end_condition_met");
  adddynamicspawnarea(var_0, self, var_1);
  self waittill("death_or_disconnect");
  thread addspawnareaonspawn(var_0, var_1);
}

function addspawnareaonspawn(var_0, var_1) {
  self endon("tac_ops_end_condition_met");
  removedynamicspawnarea(var_0, var_1);
  self endon("disconnect");
  self waittill("spawned_player");
  thread removespawnareaondeathdisconnect(var_0, var_1);
}

function evaluatesquadspawn() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateSquadSpawn");
  self endon("evaluateSquadSpawn");
  var_0 = level.availablespawnlocations[self.team].size;
  var_1 = [];
  GscBinSkip0(0x2e, 0, tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_0"));
}

function handlerespawnselection(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = undefined;

  if(!isDefined(var_2)) {
    if(istrue(level.usec130spawnfirstonly) && istrue(level.usec130spawn) && !istrue(self.spawnedusingc130) && isDefined(level.spawnc130[self.team])) {
      var_2 = 1;
    } else if(istrue(level.usesquadspawn)) {
      var_2 = 0;
    } else if(istrue(level.usespawnselection)) {
      var_2 = 2;
    } else if(istrue(level.usec130spawn)) {
      var_2 = 1;
    } else {
      var_2 = 3;
    }
  }

  var_3 = gettime();
  var_4 = 0;

  while(!var_4) {
    var_5 = gettime();
    var_6 = (var_3 + var_1 * 1000 - var_5) / 1000;

    switch (var_2) {
      case 0:
        self.squadspawnconfirmed = 0;
        self.squadspawnaborted = 0;

        if(!isai(self)) {
          thread handlesquadspawnabort();
        }

        if(!var_0) {
          thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }

        var_0 = 1;
        var_7 = scripts\engine\utility::ter_op(isDefined(self.spawnselectedsquadmate), self.spawnselectedsquadmate, 0);

        if(thread cyclevalidsquadspectate(var_7, 1)) {
          if(!isai(self)) {
            var_8 = handlesquadspawnconfirm(var_6);

            if(!istrue(var_8)) {
              self.squadspawnaborted = 1;
            } else {
              self.squadspawnconfirmed = 1;
            }
          } else {
            timeuntilspawnmessaging(var_1, 5);

            if(scripts\engine\utility::cointoss()) {
              self.squadspawnconfirmed = 1;
            } else {
              self.squadspawnaborted = 1;
            }
          }
        } else {
          self.squadspawnaborted = 1;
        }

        if(self.squadspawnaborted) {
          self.forcespectatorclient = -1;

          if(istrue(level.usec130spawn)) {
            var_2 = 1;
          } else if(istrue(level.usespawnselection)) {
            var_2 = 2;
          } else {
            var_2 = 3;
          }
        } else {
          var_4 = 1;
        }

        break;
      case 1:
        thread scripts\mp\spawncamera::startspawncamera();
        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        if(level.usec130spawnfirstonly) {
          self.spawnedusingc130 = 1;
        }

        spawntoc130();
        var_4 = 1;
        break;
      case 2:
        var_10 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

        if(scripts\mp\utility\game::getgametype() == "arm" && !var_10 && !scripts\mp\flags::gameflag("prematch_done")) {
          var_11 = scripts\mp\gametypes\arm::getmissedinfilcamerapositions(self.team);
          var_12 = spawn("script_model", var_11.startorigin);
          var_12 setModel("tag_origin");
          var_12.angles = var_11.startangles;
          self cameralinkTo(var_12, "tag_origin");
          var_12 moveTo(var_11.endorigin, 18);
          var_12 rotateTo(var_11.endangles, 18);
          scripts\mp\flags::gameflagwait("prematch_done");
          self cameraunlink();
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        } else {
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        }

        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        waitforspawnselection(var_6 + var_9);

        if(isDefined(self.selectedspawnarea)) {
          var_4 = 1;
        }

        break;
      case 3:
        thread scripts\mp\spawncamera::startspawncamera();
        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9)) {
          var_9 = 0;
        }

        timeuntilspawnmessaging(var_6 + var_9, 9);
        var_4 = 1;
        break;
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    }

    if(!var_0) {
      thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    var_0 = 1;
    waitrespawnbutton();
  }

  thread scripts\mp\spawncamera::endspawncamera();
}

function handlesquadspawnabort() {
  self endon("disconnect");
  self notify("handleSquadSpawnAbort");
  self endon("handleSquadSpawnAbort");
  self notifyonplayercommand("switchSpawnMethod", "+stance");
  self waittill("switchSpawnMethod");
  self.forcespectatorclient = -1;
  self.squadspawnaborted = 1;
  self notify("squad_spawn_abort");
}

function handlesquadspawncycle() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("handleSquadSpawnCycle");
  self endon("handleSquadSpawnCycle");
  self notifyonplayercommand("cyclePos", "+gostand");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143AD("cyclePos", "cycleNeg");

    if(isDefined(var_0)) {
      var_1 = self getspectatingplayer();

      if(var_0 == "cyclePos") {
        thread cyclevalidsquadspectate(var_1.pers["squadMemberIndex"], 1);
      } else if(var_0 == "cycleNeg") {
        thread cyclevalidsquadspectate(var_1.pers["squadMemberIndex"], 0);
      }
    }
  }
}

function handlesquadspawnconfirm(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  timeuntilspawnmessaging(var_0, 9);
  scripts\mp\utility\lower_message::setlowermessageomnvar(35);
  self notifyonplayercommand("respawn_confirm", "+usereload");
  self waittill("respawn_confirm");
  return true;
}

function cyclevalidsquadspectate(var_0, var_1) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("cycleValidSquadSpectate");
  self endon("cycleValidSquadSpectate");
  var_2 = level.squaddata[self.team][self.squadindex].players;
  var_3 = var_0;
  var_4 = scripts\engine\utility::ter_op(var_1, 1, -1);

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(iscurrentspectatetarget(var_2[var_3]) || !issquadspawnable(var_2[var_3])) {
      var_3 += var_4;

      if(var_3 == var_2.size) {
        var_3 = 0;
      }

      if(var_3 == -1) {
        var_3 = var_2.size - 1;
      }

      continue;
    }

    thread monitorsquadspectator(var_2[var_3]);
    return true;
  }

  return false;
}

function iscurrentspectatetarget(var_0) {
  if(!isDefined(self.forcespectatorclient)) {
    return false;
  }

  var_1 = self getspectatingplayer();

  if(!isDefined(var_1)) {
    return false;
  }

  return var_0 == var_1;
}

function issquadspawnable(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(istrue(var_0.inspawncamera)) {
    return false;
  }

  if(var_0 isskydiving()) {
    return false;
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    return false;
  }

  return true;
}

function updatefobspawnsindanger() {
  thread trial_patch_finished();

  if(getdvarint("scr_squad_spawn_debug", 0) == 1) {
    thread scripts\mp\spawnscoring::ref_13747();
    return;
  }
}

function trial_patch_finished() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(issquadspawnable(self)) {
      self.start_reach_icbm_launch = issquadmateindanger(self);
    }

    waitframe();
  }
}

function issquadmateindanger(var_0) {
  var_1 = gettime();

  if(isDefined(var_0) && isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + 5000 > var_1 || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_1) {
    return true;
  }

  if(var_0 isonladder()) {
    return true;
  }

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + 3000 > var_1) {
    return true;
  }

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane)) {
    return true;
  }

  var_2 = var_0 getspawnbucketforplayer(384, 100, 1);

  if(isDefined(var_2)) {
    return true;
  }

  if(isDefined(var_0.vehicle)) {
    if(istrue(var_0.vehicle.flarecooldown)) {
      return true;
    }

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(var_0.vehicle))) {
      return true;
    }
  }

  if(isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  if(getdvarint("scr_squad_spawn_bucket", 0) == 1) {
    var_3 = var_0 disablereloading(1, var_0.origin);
    var_3 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_3);

    if(var_3 >= 2) {
      return true;
    }
  }

  if(isDefined(var_0) && isDefined(var_0.ref_11EAC) && var_0.ref_11EAC + 1000 > var_1) {
    return true;
  }

  return false;
}

function monitorsquadspectator(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("monitorSquadSpectator");
  self endon("monitorSquadSpectator");
  var_1 = var_0.pers["squadMemberIndex"];
  self.forcespectatorclient = var_0 getentitynumber();
  self forcethirdpersonwhenspectating();
  thread handlesquadspawncycle();

  while(issquadspawnable(var_0)) {
    if(issquadmateindanger(var_0)) {
      self setclientomnvar("ui_squad_spawn_combat", 1);
    } else {
      self setclientomnvar("ui_squad_spawn_combat", 0);
    }

    self.squadspectatepos = var_0.origin + anglesToForward(var_0.angles) * -80 + (0, 0, 64);
    self.squadspectateang = var_0.angles;
    waitframe();
  }

  if(!thread cyclevalidsquadspectate(var_1, 1)) {
    self.squadspawnaborted = 0;
    self notify("squad_spawn_abort");
    return;
  }
}

function spawntoc130() {
  self endon("disconnect");

  while(istrue(level.usec130spawn) && !isDefined(level.spawnc130)) {
    waitframe();
  }

  if(!istrue(level.usec130spawn) || !isDefined(level.spawnc130[self.team])) {
    wait 1.5;
    return;
  }

  if(!istrue(level.usec130spawnfirstonly) && isDefined(level.timeuntilnextc130) && level.timeuntilnextc130[self.team] - gettime() <= (level.flighttime + level.timebetweenc130passes) * 1000) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(29, int(level.timeuntilnextc130[self.team]));
  } else {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  thread scripts\mp\gametypes\arm::spawnplayertoc130();

  if(isDefined(level.spawnc130[self.team])) {
    self waittill("c130_ready");
    return;
  }
}

function needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return false;
  }

  if(!self.hasspawned) {
    return false;
  }

  var_0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var_0) {
    return false;
  }

  if(self.wantsafespawn) {
    return false;
  }

  return true;
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

function timeuntilspawnmessaging(var_0, var_1) {
  self endon("disconnect");

  if(var_0 > 0) {
    if(!isDefined(var_1)) {
      var_1 = 9;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(var_1, int(gettime() + var_0 * 1000));
    scripts\engine\utility::ref_143BF(var_0, "force_spawn");
    return;
  }
}

function managesquadcameraposition(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageSquadCameraPosition");
  self endon("manageSquadCameraPosition");
  var_1 = undefined;

  if(var_0 == "squad_leader") {
    var_1 = level.squaddata[self.team][self.squadindex].squadleaderindex;
  } else {
    var_1 = int(getsubstr(var_0, var_0.size - 1, var_0.size));
  }

  var_2 = undefined;

  if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.squadindex]) && isDefined(level.squaddata[self.team][self.squadindex].players[var_1])) {
    var_2 = level.squaddata[self.team][self.squadindex].players[var_1];
  }

  var_3 = level.spawnselectionteamforward[self.team];

  while(isDefined(self.spawncameraent) && isDefined(var_2)) {
    var_4 = [];
    var_5 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var_6 = getstaticcameraposition(self.team);
      var_4 = var_6.origin;
      var_5 = var_6.angles;
    } else {
      var_4 = var_2.origin + var_3 * -8500 + (0, 0, 7000);
      var_7 = vectorNormalize(var_2.origin - var_4);
      var_5 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var_8 = getunifedspawnselectioncameraheight();
        var_4 = (var_4[0], var_4[1], var_8);
      }

      var_4 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var_2.origin);
    }

    self.spawncameratargetpos = var_4;
    self.spawncameratargetang = var_5;
    self.spawncameraent moveTo(var_4, 0.25, 0.05, 0.2);
    self.spawncameraent rotateTo(var_5, 0.25, 0.05, 0.2);
    waitframe();
  }
}

function managevehiclecameraposition(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleCameraPosition");
  self endon("manageVehicleCameraPosition");
  var_1 = int(getsubstr(var_0, var_0.size - 1, var_0.size));
  var_2 = level.spawnselectionlocations[var_0][self.team].dynamicent;
  var_3 = level.spawnselectionteamforward[self.team];
  var_4 = 0;

  while(isDefined(self.spawncameraent) && isDefined(var_2) && !istrue(var_2.isdestroyed)) {
    var_5 = [];
    var_6 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var_7 = getstaticcameraposition(self.team);
      var_5 = var_7.origin;
      var_6 = var_7.angles;
    } else {
      var_5 = var_2.origin + var_3 * -8500 + (0, 0, 7000);

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var_8 = getunifedspawnselectioncameraheight();
        var_5 = (var_5[0], var_5[1], var_8);
      }

      var_9 = level.spawnselectionlocations[var_0][self.team].anchorentity.origin;
      var_10 = var_9 + var_3 * -8500 + (0, 0, 7000);
      var_11 = vectorNormalize(var_9 - var_10);
      var_6 = scripts\mp\utility\script::vectortoanglessafe(var_11, (0, 0, 1));
      var_5 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var_9);
    }

    self.spawncameratargetpos = var_5;
    self.spawncameratargetang = var_6;

    if(!isDefined(self.spawncameraendtime) || gettime() > self.spawncameraendtime) {
      self.spawncameraent moveTo(var_5, 0.25, 0.05, 0.2);
      self.spawncameraent rotateTo(var_6, 0.25, 0.05, 0.2);
    } else if(!var_4) {
      var_4 = 1;
      self.spawncameraent moveTo(var_5, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
      self.spawncameraent rotateTo(var_6, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
    }

    waitframe();
  }
}

function ref_11AB3(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleHealthUI");
  self endon("manageVehicleHealthUI");
  var_1 = level.spawnselectionlocations[var_0][self.team].dynamicent;
  self setclientomnvar("ui_tom_veh_health_percent", 0);
  waitframe();
  var_2 = undefined;

  while(isDefined(var_1)) {
    var_3 = int(clamp(var_1.health / var_1.maxhealth * 100, 0, 100));

    if(var_3 < 0) {}

    if(!isDefined(var_2) || var_2 != var_3) {
      self setclientomnvar("ui_tom_veh_health_percent", int(var_3));
      var_2 = var_3;
    }

    waitframe();
  }
}

function getclosestavailablespawnlocation() {
  var_0 = undefined;
  var_1 = undefined;

  if(!scripts\mp\flags::gameflag("prematch_done") && scripts\mp\utility\game::getgametype() == "arm" || !isDefined(self.hasvisitedgwspawnselection)) {
    if(self.team == "axis") {
      var_1 = "gw_fob_axisHQ";
    } else {
      var_1 = "gw_fob_alliesHQ";
    }

    self.hasvisitedgwspawnselection = 1;
  } else {
    var_2 = 0;

    foreach(var_4 in level.availablespawnlocations[self.team]) {
      var_5 = distancesquared(self.origin, level.spawnselectionlocations[var_4][self.team].anchorentity.origin);

      if(var_4 == "gw_fob_" + self.team + "HQ") {
        if(var_5 < 4194304) {
          var_0 = var_5;
          var_1 = var_4;
          break;
        }
      }

      if(!isDefined(var_0) || var_5 < var_0) {
        var_0 = var_5;
        var_1 = var_4;
      }
    }

    if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[self.team][self.squadindex])) {
      var_7 = round_get_vehicles(self.team, self.squadindex);

      foreach(var_9 in var_7) {
        if(var_9.dynamicent == self) {
          continue;
        }

        var_5 = distancesquared(self.origin, var_9.dynamicent.origin);

        if(var_5 < var_0) {
          var_0 = var_5;
          var_1 = var_9.typeref;
        }
      }
    }
  }

  if(issubstr(var_1, "vehicle")) {}

  if(isDefined(var_1)) {
    if(!issubstr(var_1, "squad") && !issubstr(var_1, "vehicle") && !issubstr(var_1, "HQ")) {
      var_11 = var_1 + "_" + level.localeid;
    } else {
      var_11 = var_11;
    }

    var_12 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_11);
    self setclientomnvar("ui_tom_previous_selection", var_12);
    self.forcedspawncameraref = var_11;
    return;
  }

  self setclientomnvar("ui_tom_previous_selection", -1);
  self.forcedspawncameraref = undefined;
}

function getstaticcameraposition(var_0) {
  var_1 = spawnStruct();

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_6":
        if(var_0 == "axis") {
          var_1.origin = (2094, -1804, 2763);
          var_1.angles = (54, 40, 0);
        } else {
          var_1.origin = (2315, 1956, 2763);
          var_1.angles = (54, 296, 0);
        }

        break;
      case "locale_7":
        if(var_0 == "axis") {
          var_1.origin = (5556, -1368, 2464);
          var_1.angles = (56, 42, 0);
        } else {
          var_1.origin = (5636, 1630, 2446);
          var_1.angles = (56, 307, 0);
        }

        break;
      default:
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_5":
        if(var_0 == "axis") {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        } else {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        }

        break;
      case "locale_6":
        if(var_0 == "axis") {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        } else {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        }

        break;
      case "locale_7":
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
      default:
        if(var_0 == "axis") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  }

  return var_1;
}

function getunifedspawnselectioncameraheight() {
  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_6":
        return 7000;
      case "locale_7":
        return 7000;
      case "locale_8":
        return 7000;
      case "locale_9":
        return 7000;
      default:
        return 7000;
    }

    return;
  }

  switch (level.localeid) {
    case "locale_5":
      return 7000;
    case "locale_6":
      return 8000;
    case "locale_7":
      return 8000;
    case "locale_8":
      return 8000;
    case "locale_9":
      return 8000;
    case "locale_16":
      return 7000;
    case "locale_17":
      return 5000;
    default:
      return 7000;
  }
}

function ref_13FD9() {
  thread ref_13FDA();

  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      foreach(var_3 in level.availablespawnlocations[var_1]) {
        var_4 = level.spawnselectionlocations[var_3][var_1];

        if(isDefined(var_4.objectivekey)) {
          var_4.start_reach_icbm_launch = isobjectiveindanger(var_4.objectivekey, var_1);
        }
      }
    }

    waitframe();
  }
}

function ref_13FDA() {
  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = scripts\mp\utility\teams::getteamdata(var_1, "players")[0];

      foreach(var_4 in level.availablespawnlocations[var_1]) {
        if(!issubstr(var_4, "HQ") && issubstr(var_4, "fob")) {
          var_5 = 1;
          var_6 = isDefined(level.spawnglobals.spawnsets[var_4 + "_safe_" + var_1]);
          var_7 = var_4 + "_" + var_1;
          var_8 = undefined;

          if(var_6) {
            var_8 = var_4 + "_safe_" + var_1;
          }

          if(isDefined(level.spawninfluencezones)) {
            var_9 = undefined;
            var_10 = getarraykeys(level.spawninfluencezones);

            foreach(var_12 in var_10) {
              if(var_12 == var_4) {
                var_9 = level.spawninfluencezones[var_12];
                break;
              }
            }

            if(isDefined(var_9) && isteamtouching(var_9, scripts\mp\utility\game::getotherteam(var_1)[0])) {
              var_5 = 0;
            }
          }

          var_14 = 0;

          if(isDefined(var_2)) {
            var_15 = undefined;
            var_16 = undefined;

            if(var_5) {
              scripts\mp\spawnlogic::activatespawnset(var_7, 1);
              var_15 = var_2 disablereloading();
              var_15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_15);
            }

            if(var_6) {
              scripts\mp\spawnlogic::activatespawnset(var_8, 1);
              var_16 = var_2 disablereloading();
              var_16 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_16);
            }

            if(var_5 && var_6) {
              var_14 = var_15 >= 2 && var_16 >= 2;
            } else if(var_5 && !var_6) {
              var_14 = var_15 >= 2;
            } else if(var_6) {
              var_14 = var_16 >= 2;
            }
          }

          var_17 = level.spawnselectionlocations[var_4][var_1].objectivekey;
          level.objectives[var_17].ref_13686 = var_14;
          level.objectives[var_17].ref_13687 = gettime();
        }
      }
    }

    wait 1;
  }
}

function ref_1401D(var_0, var_1, var_2) {
  var_3 = level.spawnselectionlocations[var_0][var_2].objectivekey;

  if(!isDefined(var_3) || !isDefined(level.objectives[var_3]) || !isDefined(level.objectives[var_3].ref_13687) || level.objectives[var_3].ref_13687 == gettime()) {
    return;
  }

  var_4 = 1;
  var_5 = isDefined(level.spawnglobals.spawnsets[var_0 + "_safe_" + var_2]);
  var_6 = var_0 + "_" + var_2;
  var_7 = undefined;

  if(var_5) {
    var_7 = var_0 + "_safe_" + var_2;
  }

  if(isDefined(level.spawninfluencezones)) {
    var_8 = undefined;
    var_9 = getarraykeys(level.spawninfluencezones);

    foreach(var_11 in var_9) {
      if(var_11 == var_0) {
        var_8 = level.spawninfluencezones[var_11];
        break;
      }
    }

    if(isDefined(var_8) && isDefined(var_8.numplayers) && var_8.numplayers[scripts\mp\utility\game::getotherteam(var_2)[0]] > 0) {
      var_4 = 0;
    }
  }

  var_13 = 0;

  if(isDefined(var_1)) {
    var_14 = undefined;
    var_15 = undefined;

    if(var_4) {
      scripts\mp\spawnlogic::activatespawnset(var_6, 1);
      var_14 = var_1 disablereloading();
      var_14 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_14);
    }

    if(var_5) {
      scripts\mp\spawnlogic::activatespawnset(var_7, 1);
      var_15 = var_1 disablereloading();
      var_15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_15);
    }

    if(var_4 && var_5) {
      var_13 = var_14 >= 2 && var_15 >= 2;
    } else if(var_4 && !var_5) {
      var_13 = var_14 >= 2;
    } else if(var_5) {
      var_13 = var_15 >= 2;
    }
  }

  level.objectives[var_3].ref_13686 = var_13;
  level.objectives[var_3].ref_13687 = gettime();
}