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

  foreach(var1 in level.teamnamelist) {
    level.availablespawnlocations[var1] = [];
  }

  thread initspawns();
  scripts\common\ui::lui_registercallback("tac_ops_spawn_focus_changed", &endcondition_focuschanged);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&updatefobspawnsindanger);
}

function delayspawntoc130() {}

function churnareas() {
  var0 = [];
  GscBinSkip0(0x2e, 0, "lane01_");
}

function setspawnlocations(var0, var1) {
  var2 = [];

  foreach(var4 in level.availablespawnlocations[var1]) {
    if(issubstr(var4, "dynamic") || issubstr(var4, "vehicle") || issubstr(var4, "squad")) {
      var2 = var4;
    }
  }

  level.availablespawnlocations[var1] = [];

  foreach(var7 in var0) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var1], var7)) {
      level.availablespawnlocations[var1][level.availablespawnlocations[var1].size] = var7;
    }
  }

  foreach(var7 in var2) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var1], var7)) {
      level.availablespawnlocations[var1][level.availablespawnlocations[var1].size] = var7;
    }
  }
}

function allowspawnlocation(var0, var1) {
  if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var1], var0)) {
    level.availablespawnlocations[var1][level.availablespawnlocations[var1].size] = var0;
    return;
  }
}

function removespawnlocation(var0, var1) {
  var2 = [];

  foreach(var4 in level.availablespawnlocations[var1]) {
    if(var4 != var0) {
      var2 = var4;
    }
  }

  level.availablespawnlocations[var1] = var2;
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

  foreach(var22, var1 in level.teamnamelist) {
    var2 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[var1]);
    scripts\mp\spawnlogic::registerspawnpoints(var1, var2);

    foreach(var18, var4 in var2) {
      if(!isDefined(var4.target) || var4.target == "") {
        continue;
      }

      var5 = getEntArray(var4.target, "targetname");

      if(!isDefined(var5) || var5.size == 0) {
        var5 = scripts\engine\utility::getStructArray(var4.target, "targetname");
      }

      if(var5.size == 0) {
        continue;
      }

      var6 = undefined;

      if(var5.size == 1) {
        var6 = var5[0];
      } else {
        jumpiffalse(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) LOC_0000013c;

        foreach(var8 in var5) {
          if(isDefined(var8.script_noteworthy) && var8.script_noteworthy == level.localeid) {
            var6 = var8;
            break;
          }
        }

        goto LOC_0000018a;
      }

      if(!isDefined(var14)) {
        continue;
      }

      var15 = var14.script_label;
      var18 = var2;

      if(isDefined(var14.script_team) && scripts\mp\utility\teams::isgameplayteam(var14.script_team)) {
        if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_quarry2" && var14.targetname == "gw_fob_03_safe_axis") {
          var18 = "axis";
        } else {
          var18 = var14.script_team;
        }
      }

      if(isDefined(level.spawnselectionlocations[var15]) && isDefined(level.spawnselectionlocations[var15][var18])) {
        var16 = level.spawnselectionlocations[var15][var18];

        if(!scripts\engine\utility::array_contains(var16.spawnpoints, var5)) {
          var16.spawnpoints[var16.spawnpoints.size] = var5;
        }

        continue;
      }

      var17 = spawnStruct();
      var17.origin = var14.origin;
      var17.angles = var14.angles;
      var17.spawnpoints = [];
      var17.spawnpoints[0] = var5;

      if(!issubstr(var15, "safe")) {
        initspawnarea(var18, var17, var15);
      } else {
        level.spawnselectionlocations[var15][var18] = var17;
      }
    }

    var4 = undefined;
    var19 = undefined;

    foreach(var21 in level.spawnselectionlocations) {
      if(isDefined(var21[var2])) {
        scripts\mp\spawnlogic::registerspawnset(var22 + "_" + var2, var21[var2].spawnpoints);
      }
    }
  }

  var1 = undefined;
  var8 = undefined;
  level.usespawnselection = getdvarint("scr_game_usespawnselection", 0) == 1 && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection) {
    level.getspawnpoint = &getspawnpoint;
    return;
  }
}

function initspawnarea(var0, var1, var2) {
  var3 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var2);
  var4 = spawn("script_model", var1.origin);
  var4 setModel("tag_origin");
  var1.anchorentity = var4;
  var1.typeid = var3;
  var1.typeref = var2;
  var1.owner = "allies";

  if(!issubstr(var2, "HQ") && !issubstr(var2, "vehicle")) {
    var5 = getlabelid(var2 + "_" + level.localeid);

    if(!isDefined(var5) || var5 == -1) {
      var1.labelid = var3;
    } else {
      var1.labelid = var5;
    }
  } else {
    var1.labelid = var3;
  }

  if(isDefined(var1.dynamicent)) {
    var4 linkTo(var1.dynamicent);
  }

  level.spawnselectionlocations[var2][var0] = var1;
}

function getlabelid(var0) {
  var1 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var0);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  return var1;
}

function setanchorent(var0, var1, var2) {
  level.spawnselectionlocations[var0][var1].anchorentity = var2;
}

function setupspawninfluencezones() {
  level.spawninfluencezones = [];

  for(var0 = 1; var0 <= 5; var0++) {
    var1 = scripts\cp_mp\utility\game_utility::getlocaleent("gw_fob_0" + var0 + "_spawnInfluenceZone");

    if(!isDefined(var1)) {
      continue;
    }

    scripts\mp\utility\trigger::makeenterexittrigger(var1, &spawninfluencezone_onusebegin, &spawninfluencezone_onuseend);
    var1.touchlist = [];
    level.spawninfluencezones["gw_fob_0" + var0] = var1;
  }
}

function spawninfluencezone_onusebegin(var0, var1) {
  if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
    return;
  }

  var1.touchlist = scripts\engine\utility::array_add(var1.touchlist, var0);
}

function spawninfluencezone_onuseend(var0, var1) {
  if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
    return;
  }

  var1.touchlist = scripts\engine\utility::array_remove(var1.touchlist, var0);
}

function isteamtouching(var0) {
  var1 = 0;
  var2 = [];

  foreach(var4 in self.touchlist) {
    if(!isDefined(var4)) {
      continue;
    }

    if(isDefined(var4.team) && var4.team == var0) {
      var1 = 1;
    }

    var2 = var4;
  }

  self.touchlist = var2;
  return var1;
}

function getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(isDefined(self.thrust_fx_model)) {
    var0 = self.thrust_fx_model;
    self.thrust_fx_model = undefined;
    return var0;
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.team]);
    var0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
    return var0;
  }

  var0 = undefined;
  self.ref_1443d = 0;

  if(!isDefined(self.selectedspawnarea)) {
    if(self.team == "allies") {
      self.selectedspawnarea = "gw_fob_alliesHQ";
    } else {
      self.selectedspawnarea = "gw_fob_axisHQ";
    }
  }

  if(isDefined(self.selectedspawnarea)) {
    if(issubstr(self.selectedspawnarea, "squad")) {
      var2 = undefined;

      if(self.selectedspawnarea == "squad_leader") {
        var2 = level.squaddata[self.team][self.squadindex].squadleaderindex;
      } else {
        var2 = int(getsubstr(self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size));
      }

      var3 = level.squaddata[self.team][self.squadindex].players[var2];
      var0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var3);
      var3 thread scripts\mp\utility\points::giveunifiedpoints("squad_spawn");
      thread scripts\mp\utility\points::giveunifiedpoints("squad_spawn_self");
      self.ref_1443d = 1;

      if(isDefined(var3.vehicle)) {
        self.spawningintovehicle = 1;
        self.ref_14268 = var3.vehicle.vehiclename;
      }

      scripts\mp\utility\stats::incpersstat("spawnSelectSquad", 1);
      var3 scripts\mp\utility\stats::incpersstat("timesSelectedAsSquadLeader", 1);
    } else if(issubstr(self.selectedspawnarea, "dynamic")) {
      var0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      thread scripts\mp\gametypes\arm::spawnplayertoc130();
    } else if(issubstr(self.selectedspawnarea, "vehicle")) {
      var0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
      var4 = level.spawnselectionlocations[self.selectedspawnarea][self.team].dynamicent;
      var0.origin = var4.origin + anglesToForward(var4.angles) * -200 + (0, 0, 64);
      var0.angles = (0, var4.angles[1], 0);
      var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var4, 1);

      if(var5.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var4))) {
        var6 = spawnStruct();
        var6.useonspawn = 1;
        var6.enterstartwaitmsg = "spawned_player";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var4, var5[0], self, var6);
      }

      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else {
      if(isDefined(level.spawninfluencezones)) {
        var7 = undefined;
        var8 = getarraykeys(level.spawninfluencezones);

        foreach(var10 in var8) {
          if(var10 == self.selectedspawnarea) {
            var7 = level.spawninfluencezones[var10];
          }
        }

        if(isDefined(var7) && isteamtouching(var7, scripts\mp\utility\game::getotherteam(self.team)[0])) {
          var12 = self.selectedspawnarea + "_safe_" + self.team;
          var13 = level.spawnglobals.spawnsets[var12];

          if(!isDefined(var13)) {
            var12 = self.selectedspawnarea + "_" + self.team;
          }
        } else {
          var12 = self.selectedspawnarea + "_" + self.team;
        }
      } else {
        var12 = self.selectedspawnarea + "_" + self.team;
      }

      scripts\mp\spawnlogic::activatespawnset(var12, 1);
      var12 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");

      if(issubstr(self.selectedspawnarea, "alliesHQ") || issubstr(self.selectedspawnarea, "axisHQ")) {
        scripts\mp\utility\stats::incpersstat("spawnSelectBase", 1);
      } else {
        scripts\mp\utility\stats::incpersstat("spawnSelectFlag", 1);
      }
    }
  } else {
    var12 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var14 = self getspectatingplayer();

    if(isDefined(var14) && isDefined(self.squadindex) && self.team == var14.team && self.squadindex == var14.squadindex) {
      var12 = scripts\mp\spawnscoring::findteammatebuddyspawn(var14);
      var14 thread scripts\mp\utility\points::sec_sys_struct_1("squad_spawn");
      thread scripts\mp\utility\points::sec_sys_struct_1("squad_spawn_self");
      self.ref_1443d = 1;
    }
  }

  return var12;
}

function refreshplayerspawnareaomnvars() {
  for(var0 = 0; var0 < 16; var0++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var0, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var0, -1);
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
  var0 = [];

  for(;;) {
    if(var0.size > level.availablespawnlocations[self.team].size) {
      thread refreshplayerspawnareaomnvars();
      return;
    }

    var1 = 0;

    foreach(var3 in level.availablespawnlocations[self.team]) {
      if(!isDefined(var0[var1])) {
        break;
      }

      if(var0[var1].location != var3) {
        thread refreshplayerspawnareaomnvars();
        return;
      }

      var1++;
    }

    var1 = 0;

    foreach(var3 in level.availablespawnlocations[self.team]) {
      var6 = level.spawnselectionlocations[var3][self.team];

      if(var1 == var0.size) {
        var7 = spawnStruct();
        var7.location = undefined;
        var7.entity = undefined;
        var7.id = undefined;
        var0 = var7;
      }

      if(!isDefined(var0[var1].location)) {
        var0[var1].location = var3;
      }

      if(!isDefined(var0[var1].entity)) {
        var0[var1].entity = var6.anchorentity;
        self setclientomnvar("ui_tom_spawn_entity_" + var1, var6.anchorentity);
      }

      var8 = 0;
      var9 = 0;
      var10 = 0;

      if(isDefined(var6.objectivekey)) {
        var8 = istrue(var6.start_reach_icbm_launch);
      } else if(issubstr(var3, "vehicle")) {
        var11 = var6.dynamicent;

        if(isDefined(var11) && !istrue(var11.isdestroyed)) {
          var8 = istrue(var11.start_reach_icbm_launch);
          var9 = shouldmodelognotify(var11, self);

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var11).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var11))) {
            var10 = 1;
          }
        }
      }

      var12 = var6.labelid;

      if(var8) {
        var12 += 128;
      }

      if(istrue(var10)) {
        var12 += 1024;
      }

      if(istrue(var9)) {
        var12 += 2048;
      }

      if(!isDefined(var0[var1].id) || var0[var1].id != var12) {
        var0[var1].id = var12;
        self setclientomnvar("ui_tom_spawn_id_" + var1, var12);
      }

      var1++;
    }

    waitframe();
  }
}

function ref_12acb(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  waitframe();
  var2 = level.squaddata[var0][var1].players;
}

function isobjectiveindanger(var0, var1) {
  return level.objectives[var0].ownerteam != var1 || level.objectives[var0].stalemate || level.objectives[var0].captureblocked || istrue(level.objectives[var0].ref_13686) || level.objectives[var0].claimteam != "none" && level.objectives[var0].claimteam != var1;
}

function vault_gate_cut(var0) {
  var1 = gettime();
  var2 = isDefined(var0) && isDefined(var0.lasttimedamaged) && var0.lasttimedamaged + 5000 > var1;
  var3 = isDefined(var0) && var0 scripts\mp\outofbounds::istouchingoobtrigger();
  var4 = 0;

  if(isDefined(var0.team)) {
    var5 = scripts\common\utility::playersnear(var0.origin, 384);

    foreach(var7 in var5) {
      if(isDefined(var7) && var7.team != var0.team && isalive(var7) && !isDefined(var7.fauxdead)) {
        if(abs(var0.origin[2] - var7.origin[2]) < 100) {
          var4 = 1;
          break;
        }
      }
    }
  }

  return var2 || var3 || var4;
}

function ref_1424c(var0) {
  var0 endon("death");
  var0.start_reach_icbm_launch = 0;
  var1 = getdvarfloat("scr_gw_apc_ignore_damage_health_pct", 0.15);

  for(;;) {
    var2 = gettime();
    var3 = istrue(var0.flarecooldown);
    var4 = scripts\cp_mp\utility\weapon_utility::islockedonto(var0);
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c7(var0);
    var6 = isDefined(var0) && isDefined(var0.lasttimedamaged) && var0.lasttimedamaged + 5000 > var2;

    if(var0.vehiclename == "apc_russian") {
      var7 = var0.health / var0.maxhealth;

      if(var7 > var1) {
        var6 = 0;
      }
    }

    var8 = isDefined(var0) && var0 scripts\mp\outofbounds::istouchingoobtrigger();
    var9 = 0;

    if(isDefined(var0.team)) {
      var10 = scripts\common\utility::playersnear(var0.origin, 384);

      foreach(var12 in var10) {
        if(isDefined(var12) && var12.team != var0.team && isalive(var12) && !isDefined(var12.fauxdead)) {
          if(abs(var0.origin[2] - var12.origin[2]) < 100) {
            var9 = 1;
            break;
          }
        }
      }
    }

    var14 = var0.start_reach_icbm_launch;

    if(var6 || var8 || var9 || var3 || var4 || !var5) {
      var0.start_reach_icbm_launch = 1;
    } else {
      var0.start_reach_icbm_launch = 0;
    }

    waitframe();
  }
}

function shouldmodelognotify(var0, var1) {
  var2 = level.squaddata[self.team][self.squadindex].players;

  foreach(var4 in var0.occupants) {
    foreach(var6 in var2) {
      if(var6 == var4) {
        return true;
      }
    }
  }

  return false;
}

function setspawnselectionorder() {
  var0 = scripts\engine\utility::getStructArray("axisLeft_alliesRight", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var1 = undefined;

    foreach(var3 in var0) {
      if(var3.script_noteworthy == level.localeid) {
        var1 = var3;
      }
    }
  } else {
    var1 = scripts\engine\utility::getStruct("axisLeft_alliesRight", "targetname");
  }

  var5 = [];

  foreach(var11, var7 in level.spawnselectionlocations) {
    foreach(var9 in var7) {
      if(var10 != self.team) {
        continue;
      }

      var5 = var9;
    }
  }

  if(self.team == "axis") {
    var12 = var1 scripts\engine\utility::array_sort_with_func(var5, &sortlocationsbydistance_closestfirst);
  } else {
    var12 = var5 scripts\engine\utility::array_sort_with_func(var6, &sortlocationsbydistance_farthestfirst);
  }

  foreach(var14 in var12) {
    self setclientomnvar("ui_tom_spawn_entity_" + var11, var14.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + var11, var14.labelid);
  }
}

function sortlocationsbydistance_closestfirst(var0, var1) {
  return distancesquared(var0.origin, self.origin) < distancesquared(var1.origin, self.origin);
}

function sortlocationsbydistance_farthestfirst(var0, var1) {
  return distancesquared(var0.origin, self.origin) > distancesquared(var1.origin, self.origin);
}

function picklane(var0) {
  var1 = undefined;

  foreach(var3 in level.availablespawnlocations[self.team]) {
    if(issubstr(var3, var0)) {
      var1 = var3;
      break;
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(level.spawnselectionlocations[var1])) {
    return;
  }

  var5 = level.spawnselectionlocations[var1][self.team];

  if(!isDefined(var5)) {
    return;
  }

  var6 = self.team == "allies";
  var7 = 0;

  switch (var0) {
    case "spawn_selection_a":
    case "lane03_":
    case "left":
      var7 = scripts\engine\utility::ter_op(var6, 0, 2);
      break;
    case "spawn_selection_b":
    case "lane02_":
    case "mid":
      var7 = 1;
      break;
    case "spawn_selection_c":
    case "lane01_":
    case "right":
      var7 = scripts\engine\utility::ter_op(var6, 2, 0);
      break;
  }

  self setclientomnvar("ui_tom_spawn_entity_" + var7, var5.anchorentity);
  self setclientomnvar("ui_tom_spawn_id_" + var7, var5.labelid);
}

function refreshsquadspawns() {
  var0 = 3;

  foreach(var2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var2, "squad_")) {
      var3 = level.spawnselectionlocations[var2][self.team];
      self setclientomnvar("ui_tom_spawn_entity_" + var0, var3.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var0, var3.labelid);
      var0++;
    }
  }
}

function refreshdynamicspawns() {
  var0 = 6;

  foreach(var2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var2, "dynamic_")) {
      if(!isDefined(level.spawnselectionlocations[var2][self.team])) {
        continue;
      }

      var3 = level.spawnselectionlocations[var2][self.team];

      if(!isDefined(var3)) {
        continue;
      }

      self setclientomnvar("ui_tom_spawn_entity_" + var0, var3.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var0, var3.labelid);
      var0++;
    }
  }
}

function waitforspawnselection(var0, var1) {
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

  if(isai(self) || istrue(var1) || issubstr(self.name, "_hl_")) {
    timeuntilspawnmessaging(var0, 9);

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
  spawnselectionthink(var0);
  self lerpfovscalefactor(1, 0.2);
}

function pickrandomnonvehiclespawn() {
  var0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var2 in var0) {
    if(issubstr(var2, "fob") || issubstr(var2, "HQ")) {
      self.selectedspawnarea = var2;
      return;
    }
  }
}

function ref_1234c(var0) {
  if(!isDefined(var0)) {
    var0 = "vehicle";
  }

  var1 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var3 in var1) {
    if(issubstr(var3, "vehicle")) {
      self.selectedspawnarea = var3;
      return;
    }
  }
}

function ref_1234b() {
  var0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);
  self.selectedspawnarea = var0[0];
}

function spawnselectionthink(var0) {
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
  thread selectiondelaymessaging(var0);

  if(istrue(level.spawnselectionshowfriendly) || istrue(level.spawnselectionshowenemy)) {
    thread scripts\mp\flashpoint::flashpoint_spawnselectionvfx();
  }

  if(istrue(level.ref_13377)) {
    thread scripts\mp\gametypes\arm::ref_1420e();
  }

  if(istrue(level.ref_13375)) {
    thread scripts\mp\gametypes\arm::ref_1420f();
  }

  wait 0.5;

  if(!istrue(level.hideenemyhq)) {
    thread scripts\mp\gametypes\arm::spawnselection_showenemyhq();
  }

  self setclientomnvar("ui_hide_objectives", 0);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  timeuntilspawnmessaging(var0, 9);
  thread selectionmade();
  jumpiffalse(istrue(level.checkspawnselectionafk)) LOC_000000e8;
  thread watchforafk();

  for(;;) {
    var1 = watchendconditions();
    var2 = 1;

    switch (var1) {
      case "tac_ops_map_selection_valid":
        var2 = 1;
        break;
      case "tac_ops_map_changed":
        var2 = 0;
        refreshplayerspawnareaomnvars();
        break;
      case "tac_ops_map_cleared":
        var2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "spawned_player":
        var2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_map_game_ended":
        var2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "tac_ops_spawn_focus_changed":
        var2 = 0;
        break;
      case "tac_ops_map_nuke":
        var2 = 0;
        self setclientomnvar("ui_hide_objectives", 1);
        self setclientomnvar("ui_tac_ops_map_open", 0);
        thread spawnselectionshutdown_nuke();
        break;
      default:
        break;
    }

    if(var2) {
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

  if(isDefined(level.ref_1369c)) {
    wait level.ref_1369c;
  } else {
    wait 60;
  }

  self notify("afk_disconnection_imminent");
  wait 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

function selectiondelaymessaging(var0) {
  self endon("disconnect");
  self.canprocessselection = 0;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    self setclientomnvar("ui_arm_respawnTimerActive", 1);
  }

  if(var0 > 0) {
    wait var0;
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
  foreach(var1 in level.availablespawnlocations[self.team]) {
    if(var1 == self.selectedspawnarea) {
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
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "tac_ops_spawn_area_selected") {
      var1 = ref_1400a(var1);
      var2 = undefined;

      foreach(var5, var4 in level.spawnselectionlocations) {
        if(isDefined(var4[self.team]) && isDefined(var4[self.team].anchorentity) && var4[self.team].anchorentity getentitynumber() == var1) {
          ref_1401d(var4[self.team].typeref, self, self.team);

          if(isDefined(var4[self.team].objectivekey) && isobjectiveindanger(var4[self.team].objectivekey, self.team)) {
            break;
          }

          if(isDefined(var4[self.team].typeref) && issubstr(var4[self.team].typeref, "vehicle") && istrue(var4[self.team].dynamicent.start_reach_icbm_launch)) {
            break;
          }

          var2 = var4[self.team].typeref;
          break;
        }
      }

      if(!isDefined(var2)) {
        var6 = round_get_vehicles(self.team, self.squadindex);

        foreach(var4 in var6) {
          if(isDefined(var4.dynamicent) && var4.dynamicent getentitynumber() == var1) {
            if(var4.dynamicent.team != self.team || var4.dynamicent.squadindex != self.squadindex) {
              thread refreshplayerspawnareaomnvars();
              break;
            }

            if(issquadmateindanger(var4.dynamicent)) {
              break;
            }

            var8 = var4.dynamicent.vehicle;

            if(isDefined(var8)) {
              if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var8).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var8))) {
                break;
              }
            }

            var9 = spawnStruct();
            var9 = scripts\mp\spawnscoring::get_cumulative_damage_expire_time(var9, var3.dynamicent);

            if(!isDefined(var9.ref_1368a)) {
              var3.dynamicent.ref_11eac = gettime();
              break;
            }

            <
            error > = var1.typeref;
            break;
          }
        }

        var4 = undefined;
        var5 = undefined;
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

function ref_1400a(var0) {
  if(!isDefined(self.setaardata)) {
    self.setaardata = [];
  }

  var1 = 65536;
  var2 = 131072;
  var3 = 262144;
  var4 = 524288;
  self.setaardata["rightmouseup"] = istrue(self.setaardata["rightmouseup"]) || (var0 &var1) > 0;
  self.setaardata["leftmouseup"] = istrue(self.setaardata["leftmouseup"]) || (var0 &var2) > 0;
  self.setaardata["activate"] = istrue(self.setaardata["activate"]) || (var0 &var3) > 0;
  self.setaardata["gostand"] = istrue(self.setaardata["gostand"]) || (var0 &var4) > 0;
  return var0 &~(var1 | var2 | var3 | var4);
}

function watchendconditions() {
  self endon("disconnect");
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  thread endconditionwatcher_nuke();
  var0 = scripts\engine\utility::ref_143b8("tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke");
  self notify("tac_ops_end_condition_met");
  return var0;
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

function endcondition_focuschanged(var0) {
  if(isDefined(self.selectedspawnarea)) {
    return;
  }

  self endon("disconnect");
  self notify("endConditionWatcher_FocusChanged()");
  self endon("endConditionWatcher_FocusChanged()");
  self notify("tac_ops_spawn_focus_changed");
  var1 = undefined;

  foreach(var3 in level.spawnselectionlocations) {
    if(isDefined(var3[self.team]) && isDefined(var3[self.team].anchorentity) && var3[self.team].anchorentity getentitynumber() == var0) {
      thread vehicle_registerturret(var3[self.team].anchorentity.origin);
      var1 = var3[self.team].typeref;
      break;
    }
  }

  if(!isDefined(var1)) {
    var5 = round_get_vehicles(self.team, self.squadindex);

    foreach(var3 in var5) {
      if(isDefined(var3.dynamicent) && var3.dynamicent getentitynumber() == var0) {
        thread vehicle_registerturret(var3.dynamicent.origin);
        var1 = var3.typeref;
        break;
      }
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  self setclientomnvar("ui_tom_veh_health_percent", 0);

  if(issubstr(var1, "squad")) {
    thread managesquadcameraposition(var1);
    var8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var1);
    self setclientomnvar("ui_tom_previous_selection", var8);
    return;
  }

  if(issubstr(var2, "vehicle")) {
    thread managevehiclecameraposition(var2);
    thread ref_11ab3(var2);
    var8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var2);
    self setclientomnvar("ui_tom_previous_selection", var8);
    return;
  }

  var8 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var3 + "_" + level.localeid);
  self setclientomnvar("ui_tom_previous_selection", var8);

  if(isDefined(level.spawncameras[var3]) && isDefined(level.spawncameras[var3][self.team])) {
    self.forcedspawncameraref = var3;

    while(!scripts\mp\flags::gameflag("prematch_done")) {
      waitframe();
    }

    thread scripts\mp\spawncamera::movetospawncamera(0);
    return;
  }
}

function vehicle_registerturret(var0) {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");
  self endon("spawned_player");
  self notify("keepStreamPosFresh");
  self endon("keepStreamPosFresh");

  if(!isDefined(level.ref_145df)) {
    level.ref_145df = max(getdvarint("NOLPSOTORP", 20000) * 0.5 / 1000, 1);
  }

  for(;;) {
    self predictstreampos(var0, 1);
    wait level.ref_145df;
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

function adddynamicspawnarea(var0, var1, var2, var3) {
  if(isDefined(level.spawnselectionlocations[var2]) && isDefined(level.spawnselectionlocations[var2][var0])) {
    var4 = level.spawnselectionlocations[var2][var0];
    var4.origin = var1.origin + scripts\engine\utility::ter_op(isDefined(var3), var3, (0, 0, 0));
    var4.angles = var1.angles;
    return;
  }

  var4 = spawnStruct();
  var4.origin = var2.origin + scripts\engine\utility::ter_op(isDefined(var4), var4, (0, 0, 0));
  var4.angles = var2.angles;
  var4.dynamicent = var2;
  var4.script_noteworthy = var3;
  initspawnarea(var1, var4, var3);
  updatespawnareas();
}

function removedynamicspawnarea(var0, var1) {
  if(isDefined(level.spawnselectionlocations[var1]) && isDefined(level.spawnselectionlocations[var1][var0])) {
    level.spawnselectionlocations[var1][var0] = undefined;

    if(level.spawnselectionlocations[var1].size == 0) {
      level.spawnselectionlocations[var1] = undefined;
    }
  }

  updatespawnareas();
}

function round_get_vehicles(var0, var1) {
  var2 = [];

  if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[var0]) && isDefined(level.squadspawnselectionlocations[var0][var1])) {
    var2 = level.squadspawnselectionlocations[var0][var1];
  }

  return var2;
}

function updatesquadspawn(var0, var1, var2, var3) {
  if(!isDefined(level.squadspawnselectionlocations)) {
    level.squadspawnselectionlocations = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[var0])) {
    level.squadspawnselectionlocations[var0] = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[var0][var1])) {
    level.squadspawnselectionlocations[var0][var1] = [];
  }

  if(isDefined(level.squadspawnselectionlocations[var0][var1][var2])) {
    if(!isDefined(var3)) {
      level.squadspawnselectionlocations[var0][var1][var2] = undefined;
      return;
    }

    var4 = level.squadspawnselectionlocations[var0][var1][var2];
    var4.typeref = var2;
    var4.origin = var3.origin;
    var4.angles = var3.angles;
    var4.dynamicent = var3;
    return;
  }

  if(!isDefined(var4)) {
    return;
  }

  var4 = spawnStruct();
  var4.typeref = var3;
  var4.origin = var4.origin;
  var4.angles = var4.angles;
  var4.dynamicent = var4;
  level.squadspawnselectionlocations[var1][var2][var3] = var4;
}

function removespawnareaondeathdisconnect(var0, var1) {
  self endon("tac_ops_end_condition_met");
  adddynamicspawnarea(var0, self, var1);
  self waittill("death_or_disconnect");
  thread addspawnareaonspawn(var0, var1);
}

function addspawnareaonspawn(var0, var1) {
  self endon("tac_ops_end_condition_met");
  removedynamicspawnarea(var0, var1);
  self endon("disconnect");
  self waittill("spawned_player");
  thread removespawnareaondeathdisconnect(var0, var1);
}

function evaluatesquadspawn() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateSquadSpawn");
  self endon("evaluateSquadSpawn");
  var0 = level.availablespawnlocations[self.team].size;
  var1 = [];
  GscBinSkip0(0x2e, 0, tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_0"));
}

function handlerespawnselection(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var2 = undefined;

  if(!isDefined(var2)) {
    if(istrue(level.usec130spawnfirstonly) && istrue(level.usec130spawn) && !istrue(self.spawnedusingc130) && isDefined(level.spawnc130[self.team])) {
      var2 = 1;
    } else if(istrue(level.usesquadspawn)) {
      var2 = 0;
    } else if(istrue(level.usespawnselection)) {
      var2 = 2;
    } else if(istrue(level.usec130spawn)) {
      var2 = 1;
    } else {
      var2 = 3;
    }
  }

  var3 = gettime();
  var4 = 0;

  while(!var4) {
    var5 = gettime();
    var6 = (var3 + var1 * 1000 - var5) / 1000;

    switch (var2) {
      case 0:
        self.squadspawnconfirmed = 0;
        self.squadspawnaborted = 0;

        if(!isai(self)) {
          thread handlesquadspawnabort();
        }

        if(!var0) {
          thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }

        var0 = 1;
        var7 = scripts\engine\utility::ter_op(isDefined(self.spawnselectedsquadmate), self.spawnselectedsquadmate, 0);

        if(thread cyclevalidsquadspectate(var7, 1)) {
          if(!isai(self)) {
            var8 = handlesquadspawnconfirm(var6);

            if(!istrue(var8)) {
              self.squadspawnaborted = 1;
            } else {
              self.squadspawnconfirmed = 1;
            }
          } else {
            timeuntilspawnmessaging(var1, 5);

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
            var2 = 1;
          } else if(istrue(level.usespawnselection)) {
            var2 = 2;
          } else {
            var2 = 3;
          }
        } else {
          var4 = 1;
        }

        break;
      case 1:
        thread scripts\mp\spawncamera::startspawncamera();
        var9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var9)) {
          var9 = 0;
        }

        if(level.usec130spawnfirstonly) {
          self.spawnedusingc130 = 1;
        }

        spawntoc130();
        var4 = 1;
        break;
      case 2:
        var10 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

        if(scripts\mp\utility\game::getgametype() == "arm" && !var10 && !scripts\mp\flags::gameflag("prematch_done")) {
          var11 = scripts\mp\gametypes\arm::getmissedinfilcamerapositions(self.team);
          var12 = spawn("script_model", var11.startorigin);
          var12 setModel("tag_origin");
          var12.angles = var11.startangles;
          self cameralinkTo(var12, "tag_origin");
          var12 moveTo(var11.endorigin, 18);
          var12 rotateTo(var11.endangles, 18);
          scripts\mp\flags::gameflagwait("prematch_done");
          self cameraunlink();
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        } else {
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        }

        var9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var9)) {
          var9 = 0;
        }

        waitforspawnselection(var6 + var9);

        if(isDefined(self.selectedspawnarea)) {
          var4 = 1;
        }

        break;
      case 3:
        thread scripts\mp\spawncamera::startspawncamera();
        var9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var9)) {
          var9 = 0;
        }

        timeuntilspawnmessaging(var6 + var9, 9);
        var4 = 1;
        break;
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    }

    if(!var0) {
      thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    var0 = 1;
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
    var0 = scripts\engine\utility::ref_143ad("cyclePos", "cycleNeg");

    if(isDefined(var0)) {
      var1 = self getspectatingplayer();

      if(var0 == "cyclePos") {
        thread cyclevalidsquadspectate(var1.pers["squadMemberIndex"], 1);
      } else if(var0 == "cycleNeg") {
        thread cyclevalidsquadspectate(var1.pers["squadMemberIndex"], 0);
      }
    }
  }
}

function handlesquadspawnconfirm(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  timeuntilspawnmessaging(var0, 9);
  scripts\mp\utility\lower_message::setlowermessageomnvar(35);
  self notifyonplayercommand("respawn_confirm", "+usereload");
  self waittill("respawn_confirm");
  return true;
}

function cyclevalidsquadspectate(var0, var1) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("cycleValidSquadSpectate");
  self endon("cycleValidSquadSpectate");
  var2 = level.squaddata[self.team][self.squadindex].players;
  var3 = var0;
  var4 = scripts\engine\utility::ter_op(var1, 1, -1);

  for(var5 = 0; var5 < var2.size; var5++) {
    if(iscurrentspectatetarget(var2[var3]) || !issquadspawnable(var2[var3])) {
      var3 += var4;

      if(var3 == var2.size) {
        var3 = 0;
      }

      if(var3 == -1) {
        var3 = var2.size - 1;
      }

      continue;
    }

    thread monitorsquadspectator(var2[var3]);
    return true;
  }

  return false;
}

function iscurrentspectatetarget(var0) {
  if(!isDefined(self.forcespectatorclient)) {
    return false;
  }

  var1 = self getspectatingplayer();

  if(!isDefined(var1)) {
    return false;
  }

  return var0 == var1;
}

function issquadspawnable(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(istrue(var0.inspawncamera)) {
    return false;
  }

  if(var0 isskydiving()) {
    return false;
  }

  if(var0 scripts\mp\utility\player::isusingremote()) {
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

function issquadmateindanger(var0) {
  var1 = gettime();

  if(isDefined(var0) && isDefined(var0.lastdamagetime) && var0.lastdamagetime + 5000 > var1 || isDefined(var0.lasttimedamaged) && var0.lasttimedamaged + 5000 > var1) {
    return true;
  }

  if(var0 isonladder()) {
    return true;
  }

  var0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var0.recentattackers) && var0.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(var0.watch_for_players_touching_ground) && var0.watch_for_players_touching_ground + 3000 > var1) {
    return true;
  }

  if(isDefined(var0.watch_for_players_touching_ground) && isDefined(var0.watch_for_players_regrouping_to_plane) && var0.watch_for_players_touching_ground > var0.watch_for_players_regrouping_to_plane || isDefined(var0.watch_for_players_touching_ground) && !isDefined(var0.watch_for_players_regrouping_to_plane)) {
    return true;
  }

  var2 = var0 getspawnbucketforplayer(384, 100, 1);

  if(isDefined(var2)) {
    return true;
  }

  if(isDefined(var0.vehicle)) {
    if(istrue(var0.vehicle.flarecooldown)) {
      return true;
    }

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(var0.vehicle))) {
      return true;
    }
  }

  if(isDefined(var0) && var0 scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  if(getdvarint("scr_squad_spawn_bucket", 0) == 1) {
    var3 = var0 disablereloading(1, var0.origin);
    var3 = scripts\mp\spawnlogic::getspawnbucketfromstring(var3);

    if(var3 >= 2) {
      return true;
    }
  }

  if(isDefined(var0) && isDefined(var0.ref_11eac) && var0.ref_11eac + 1000 > var1) {
    return true;
  }

  return false;
}

function monitorsquadspectator(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("monitorSquadSpectator");
  self endon("monitorSquadSpectator");
  var1 = var0.pers["squadMemberIndex"];
  self.forcespectatorclient = var0 getentitynumber();
  self forcethirdpersonwhenspectating();
  thread handlesquadspawncycle();

  while(issquadspawnable(var0)) {
    if(issquadmateindanger(var0)) {
      self setclientomnvar("ui_squad_spawn_combat", 1);
    } else {
      self setclientomnvar("ui_squad_spawn_combat", 0);
    }

    self.squadspectatepos = var0.origin + anglesToForward(var0.angles) * -80 + (0, 0, 64);
    self.squadspectateang = var0.angles;
    waitframe();
  }

  if(!thread cyclevalidsquadspectate(var1, 1)) {
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

  var0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var0) {
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

function timeuntilspawnmessaging(var0, var1) {
  self endon("disconnect");

  if(var0 > 0) {
    if(!isDefined(var1)) {
      var1 = 9;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(var1, int(gettime() + var0 * 1000));
    scripts\engine\utility::ref_143bf(var0, "force_spawn");
    return;
  }
}

function managesquadcameraposition(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageSquadCameraPosition");
  self endon("manageSquadCameraPosition");
  var1 = undefined;

  if(var0 == "squad_leader") {
    var1 = level.squaddata[self.team][self.squadindex].squadleaderindex;
  } else {
    var1 = int(getsubstr(var0, var0.size - 1, var0.size));
  }

  var2 = undefined;

  if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.squadindex]) && isDefined(level.squaddata[self.team][self.squadindex].players[var1])) {
    var2 = level.squaddata[self.team][self.squadindex].players[var1];
  }

  var3 = level.spawnselectionteamforward[self.team];

  while(isDefined(self.spawncameraent) && isDefined(var2)) {
    var4 = [];
    var5 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var6 = getstaticcameraposition(self.team);
      var4 = var6.origin;
      var5 = var6.angles;
    } else {
      var4 = var2.origin + var3 * -8500 + (0, 0, 7000);
      var7 = vectorNormalize(var2.origin - var4);
      var5 = scripts\mp\utility\script::vectortoanglessafe(var7, (0, 0, 1));

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var8 = getunifedspawnselectioncameraheight();
        var4 = (var4[0], var4[1], var8);
      }

      var4 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var2.origin);
    }

    self.spawncameratargetpos = var4;
    self.spawncameratargetang = var5;
    self.spawncameraent moveTo(var4, 0.25, 0.05, 0.2);
    self.spawncameraent rotateTo(var5, 0.25, 0.05, 0.2);
    waitframe();
  }
}

function managevehiclecameraposition(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleCameraPosition");
  self endon("manageVehicleCameraPosition");
  var1 = int(getsubstr(var0, var0.size - 1, var0.size));
  var2 = level.spawnselectionlocations[var0][self.team].dynamicent;
  var3 = level.spawnselectionteamforward[self.team];
  var4 = 0;

  while(isDefined(self.spawncameraent) && isDefined(var2) && !istrue(var2.isdestroyed)) {
    var5 = [];
    var6 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var7 = getstaticcameraposition(self.team);
      var5 = var7.origin;
      var6 = var7.angles;
    } else {
      var5 = var2.origin + var3 * -8500 + (0, 0, 7000);

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var8 = getunifedspawnselectioncameraheight();
        var5 = (var5[0], var5[1], var8);
      }

      var9 = level.spawnselectionlocations[var0][self.team].anchorentity.origin;
      var10 = var9 + var3 * -8500 + (0, 0, 7000);
      var11 = vectorNormalize(var9 - var10);
      var6 = scripts\mp\utility\script::vectortoanglessafe(var11, (0, 0, 1));
      var5 += scripts\mp\gametypes\arm::calculatecameraoffset(self.team, var9);
    }

    self.spawncameratargetpos = var5;
    self.spawncameratargetang = var6;

    if(!isDefined(self.spawncameraendtime) || gettime() > self.spawncameraendtime) {
      self.spawncameraent moveTo(var5, 0.25, 0.05, 0.2);
      self.spawncameraent rotateTo(var6, 0.25, 0.05, 0.2);
    } else if(!var4) {
      var4 = 1;
      self.spawncameraent moveTo(var5, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
      self.spawncameraent rotateTo(var6, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
    }

    waitframe();
  }
}

function ref_11ab3(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleHealthUI");
  self endon("manageVehicleHealthUI");
  var1 = level.spawnselectionlocations[var0][self.team].dynamicent;
  self setclientomnvar("ui_tom_veh_health_percent", 0);
  waitframe();
  var2 = undefined;

  while(isDefined(var1)) {
    var3 = int(clamp(var1.health / var1.maxhealth * 100, 0, 100));

    if(var3 < 0) {}

    if(!isDefined(var2) || var2 != var3) {
      self setclientomnvar("ui_tom_veh_health_percent", int(var3));
      var2 = var3;
    }

    waitframe();
  }
}

function getclosestavailablespawnlocation() {
  var0 = undefined;
  var1 = undefined;

  if(!scripts\mp\flags::gameflag("prematch_done") && scripts\mp\utility\game::getgametype() == "arm" || !isDefined(self.hasvisitedgwspawnselection)) {
    if(self.team == "axis") {
      var1 = "gw_fob_axisHQ";
    } else {
      var1 = "gw_fob_alliesHQ";
    }

    self.hasvisitedgwspawnselection = 1;
  } else {
    var2 = 0;

    foreach(var4 in level.availablespawnlocations[self.team]) {
      var5 = distancesquared(self.origin, level.spawnselectionlocations[var4][self.team].anchorentity.origin);

      if(var4 == "gw_fob_" + self.team + "HQ") {
        if(var5 < 4194304) {
          var0 = var5;
          var1 = var4;
          break;
        }
      }

      if(!isDefined(var0) || var5 < var0) {
        var0 = var5;
        var1 = var4;
      }
    }

    if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[self.team][self.squadindex])) {
      var7 = round_get_vehicles(self.team, self.squadindex);

      foreach(var9 in var7) {
        if(var9.dynamicent == self) {
          continue;
        }

        var5 = distancesquared(self.origin, var9.dynamicent.origin);

        if(var5 < var0) {
          var0 = var5;
          var1 = var9.typeref;
        }
      }
    }
  }

  if(issubstr(var1, "vehicle")) {}

  if(isDefined(var1)) {
    if(!issubstr(var1, "squad") && !issubstr(var1, "vehicle") && !issubstr(var1, "HQ")) {
      var11 = var1 + "_" + level.localeid;
    } else {
      var11 = var11;
    }

    var12 = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var11);
    self setclientomnvar("ui_tom_previous_selection", var12);
    self.forcedspawncameraref = var11;
    return;
  }

  self setclientomnvar("ui_tom_previous_selection", -1);
  self.forcedspawncameraref = undefined;
}

function getstaticcameraposition(var0) {
  var1 = spawnStruct();

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_6":
        if(var0 == "axis") {
          var1.origin = (2094, -1804, 2763);
          var1.angles = (54, 40, 0);
        } else {
          var1.origin = (2315, 1956, 2763);
          var1.angles = (54, 296, 0);
        }

        break;
      case "locale_7":
        if(var0 == "axis") {
          var1.origin = (5556, -1368, 2464);
          var1.angles = (56, 42, 0);
        } else {
          var1.origin = (5636, 1630, 2446);
          var1.angles = (56, 307, 0);
        }

        break;
      default:
        if(var0 == "axis") {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        } else {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_5":
        if(var0 == "axis") {
          var1.origin = (30965, 28984, 12785);
          var1.angles = (53, 82, 0);
        } else {
          var1.origin = (35294, 53430, 12785);
          var1.angles = (50, 260, 0);
        }

        break;
      case "locale_6":
        if(var0 == "axis") {
          var1.origin = (35294, 53430, 12785);
          var1.angles = (50, 260, 0);
        } else {
          var1.origin = (30965, 28984, 12785);
          var1.angles = (53, 82, 0);
        }

        break;
      case "locale_7":
        if(var0 == "axis") {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        } else {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        }

        break;
      default:
        if(var0 == "axis") {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        } else {
          var1.origin = (0, 0, 0);
          var1.angles = (0, 0, 0);
        }

        break;
    }
  }

  return var1;
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

function ref_13fd9() {
  thread ref_13fda();

  for(;;) {
    foreach(var1 in level.teamnamelist) {
      foreach(var3 in level.availablespawnlocations[var1]) {
        var4 = level.spawnselectionlocations[var3][var1];

        if(isDefined(var4.objectivekey)) {
          var4.start_reach_icbm_launch = isobjectiveindanger(var4.objectivekey, var1);
        }
      }
    }

    waitframe();
  }
}

function ref_13fda() {
  for(;;) {
    foreach(var1 in level.teamnamelist) {
      var2 = scripts\mp\utility\teams::getteamdata(var1, "players")[0];

      foreach(var4 in level.availablespawnlocations[var1]) {
        if(!issubstr(var4, "HQ") && issubstr(var4, "fob")) {
          var5 = 1;
          var6 = isDefined(level.spawnglobals.spawnsets[var4 + "_safe_" + var1]);
          var7 = var4 + "_" + var1;
          var8 = undefined;

          if(var6) {
            var8 = var4 + "_safe_" + var1;
          }

          if(isDefined(level.spawninfluencezones)) {
            var9 = undefined;
            var10 = getarraykeys(level.spawninfluencezones);

            foreach(var12 in var10) {
              if(var12 == var4) {
                var9 = level.spawninfluencezones[var12];
                break;
              }
            }

            if(isDefined(var9) && isteamtouching(var9, scripts\mp\utility\game::getotherteam(var1)[0])) {
              var5 = 0;
            }
          }

          var14 = 0;

          if(isDefined(var2)) {
            var15 = undefined;
            var16 = undefined;

            if(var5) {
              scripts\mp\spawnlogic::activatespawnset(var7, 1);
              var15 = var2 disablereloading();
              var15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var15);
            }

            if(var6) {
              scripts\mp\spawnlogic::activatespawnset(var8, 1);
              var16 = var2 disablereloading();
              var16 = scripts\mp\spawnlogic::getspawnbucketfromstring(var16);
            }

            if(var5 && var6) {
              var14 = var15 >= 2 && var16 >= 2;
            } else if(var5 && !var6) {
              var14 = var15 >= 2;
            } else if(var6) {
              var14 = var16 >= 2;
            }
          }

          var17 = level.spawnselectionlocations[var4][var1].objectivekey;
          level.objectives[var17].ref_13686 = var14;
          level.objectives[var17].ref_13687 = gettime();
        }
      }
    }

    wait 1;
  }
}

function ref_1401d(var0, var1, var2) {
  var3 = level.spawnselectionlocations[var0][var2].objectivekey;

  if(!isDefined(var3) || !isDefined(level.objectives[var3]) || !isDefined(level.objectives[var3].ref_13687) || level.objectives[var3].ref_13687 == gettime()) {
    return;
  }

  var4 = 1;
  var5 = isDefined(level.spawnglobals.spawnsets[var0 + "_safe_" + var2]);
  var6 = var0 + "_" + var2;
  var7 = undefined;

  if(var5) {
    var7 = var0 + "_safe_" + var2;
  }

  if(isDefined(level.spawninfluencezones)) {
    var8 = undefined;
    var9 = getarraykeys(level.spawninfluencezones);

    foreach(var11 in var9) {
      if(var11 == var0) {
        var8 = level.spawninfluencezones[var11];
        break;
      }
    }

    if(isDefined(var8) && isDefined(var8.numplayers) && var8.numplayers[scripts\mp\utility\game::getotherteam(var2)[0]] > 0) {
      var4 = 0;
    }
  }

  var13 = 0;

  if(isDefined(var1)) {
    var14 = undefined;
    var15 = undefined;

    if(var4) {
      scripts\mp\spawnlogic::activatespawnset(var6, 1);
      var14 = var1 disablereloading();
      var14 = scripts\mp\spawnlogic::getspawnbucketfromstring(var14);
    }

    if(var5) {
      scripts\mp\spawnlogic::activatespawnset(var7, 1);
      var15 = var1 disablereloading();
      var15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var15);
    }

    if(var4 && var5) {
      var13 = var14 >= 2 && var15 >= 2;
    } else if(var4 && !var5) {
      var13 = var14 >= 2;
    } else if(var5) {
      var13 = var15 >= 2;
    }
  }

  level.objectives[var3].ref_13686 = var13;
  level.objectives[var3].ref_13687 = gettime();
}