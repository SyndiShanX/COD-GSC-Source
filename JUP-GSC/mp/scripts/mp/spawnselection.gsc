/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\spawnselection.gsc
***********************************************/

#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\tweakables;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#namespace spawnselection;

function init() {
  if(scripts\mp\spawnselection::function_167619fe3d0cff00()) {
    setDvar(@ "scr_game_disablespawncamera", 0);
  } else {
    return;
  }

  level.usec130spawn = getdvarint(@ "scr_game_c130_spawn", 0) == 1;
  level.usesquadspawn = getdvarint(@ "scr_game_squad_spawn", 0) == 1;
  level.usesquadspawnselection = getdvarint(@ "scr_game_spawnselection_squad", 1) == 1;
  level.spawnsquadleaderonly = getdvarint(@ "hash_fc11053944ab5f7e", 0) == 1;
  level.var_f15becfbc1b01a1b = getdvarint(@ "hash_ee75f0b9d9e03349", 1) == 1;
  level.var_a50b22fa98674a50 = getdvarint(@ "hash_ef54007b614237da", 0) == 1;
  level.var_6f40c2b6970373c0 = getdvarint(@ "hash_8fe41b9ffb4e54aa", 1) == 1;
  level.var_757ec02df4d678f5 = getdvarint(@ "hash_537448d6935dd02b", 1) == 1;
  level.var_111c5f085a86c2f0 = &function_f83711dd7546db96;
  level.var_aba39caf969cd3f7 = &function_dc659688380c4195;
  level.checkspawnselectionafk = matchmakinggame() && getdvarint(@ "scr_game_spawnselection_afk", 1) == 1;
  level.var_f13131261b4c6ad5 = getdvarint(@ "hash_6560b9b4c5fcbab", 0) == 1;
  level.var_ca4fe20b267c4f54 = getdvarint(@ "hash_9fe20711e5bcee42", 0) == 1;
  level.var_4d2556c1d0f4893e = getdvarint(@ "hash_a959156dff929a38", 0) == 1;
  level.var_7119a108c4ba4d2c = getdvarint(@ "hash_4ce0b40aac178e56", 0) == 1;
  level.var_c0e8540c63b7af50 = getdvarfloat(@ "scr_spawnselection_obj_owned_partial_pct", 0);
  level.var_f335c53db1d6dd34 = getdvarint(@ "hash_8e9e98f013db1ac4", 1) == 1;
  level.availablespawnlocations = [];

  foreach(entry in level.teamnamelist) {
    level.availablespawnlocations[entry] = [];
  }

  if(!isDefined(level.var_d280c5fdb0036183)) {
    level.var_d280c5fdb0036183 = &function_dc3a172bf923d9b3;
  }

  level thread initspawns();
  scripts\common\ui::lui_registercallback("tac_ops_spawn_focus_changed", &endcondition_focuschanged);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&isplayerindanger_think);
}

function function_dc3a172bf923d9b3() {
  return true;
}

function delayspawntoc130() {}

function churnareas() {
  lanenames = [];
  lanenames[0] = "lane01_";
  lanenames[1] = "lane02_";
  lanenames[2] = "lane03_";
  alliesareas = [];
  alliesareas[alliesareas.size] = lanenames[0] + randomint(3) + 1;
  alliesareas[alliesareas.size] = lanenames[1] + randomint(3) + 1;
  alliesareas[alliesareas.size] = lanenames[2] + randomint(3) + 1;
  setspawnlocations(alliesareas, "allies");
  axisareas = [];
  axisareas[alliesareas.size] = lanenames[0] + randomint(3) + 1;
  axisareas[alliesareas.size] = lanenames[1] + randomint(3) + 1;
  axisareas[alliesareas.size] = lanenames[2] + randomint(3) + 1;
  setspawnlocations(axisareas, "axis");
  updatespawnareas();

  while(true) {
    wait 10;
    alliesareas = [];
    alliesareas[alliesareas.size] = lanenames[0] + randomint(3) + 1;
    alliesareas[alliesareas.size] = lanenames[1] + randomint(3) + 1;
    alliesareas[alliesareas.size] = lanenames[2] + randomint(3) + 1;
    setspawnlocations(alliesareas, "allies");
    axisareas = [];
    axisareas[axisareas.size] = lanenames[0] + randomint(3) + 1;
    axisareas[axisareas.size] = lanenames[1] + randomint(3) + 1;
    axisareas[axisareas.size] = lanenames[2] + randomint(3) + 1;
    setspawnlocations(axisareas, "axis");
    updatespawnareas();
  }
}

function setspawnlocations(refarray, team) {
  dynamiclocations = [];

  foreach(loc in level.availablespawnlocations[team]) {
    if(issubstr(loc, "dynamic") || issubstr(loc, "vehicle") || issubstr(loc, "squad")) {
      dynamiclocations[dynamiclocations.size] = loc;
    }
  }

  level.availablespawnlocations[team] = [];

  foreach(ref in refarray) {
    if(!array_contains(level.availablespawnlocations[team], ref)) {
      level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
    }
  }

  foreach(ref in dynamiclocations) {
    if(!array_contains(level.availablespawnlocations[team], ref)) {
      level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
    }
  }
}

function allowspawnlocation(ref, team) {
  if(!array_contains(level.availablespawnlocations[team], ref)) {
    level.availablespawnlocations[team][level.availablespawnlocations[team].size] = ref;
  }
}

function removespawnlocation(ref, team) {
  availablespawnlocations = [];

  foreach(location in level.availablespawnlocations[team]) {
    if(location != ref) {
      availablespawnlocations[availablespawnlocations.size] = location;
    }
  }

  level.availablespawnlocations[team] = availablespawnlocations;
}

function updatespawnareas() {
  level notify("tac_ops_map_changed");
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(!isDefined(level.var_a88344345b7590c8)) {
    level.var_a88344345b7590c8 = &setupspawnlocations;
  }

  [[level.var_a88344345b7590c8]]();

  if(getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "bigctf") {
    setupspawninfluencezones();
  }
}

function setupspawnlocations() {
  while(!isDefined(level.gamemodespawnpointnames)) {
    waitframe();
  }

  level.spawnselectionlocations = [];

  foreach(entry in level.teamnamelist) {
    spawns = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[entry]);
    scripts\mp\spawnlogic::registerspawnpoints(entry, spawns);

    foreach(s in spawns) {
      if(!isDefined(s.target) || s.target == "") {
        continue;
      }

      targets = getEntArray(s.target, "targetname");

      if(!isDefined(targets) || targets.size == 0) {
        targets = getStructArray(s.target, "targetname");
      }

      if(targets.size == 0) {
        continue;
      }

      target = undefined;

      if(targets.size == 1) {
        target = targets[0];
      } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
        foreach(ent in targets) {
          if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
            target = ent;
            break;
          }
        }
      } else {
        closestdistsq = undefined;

        foreach(ent in targets) {
          distsq = distancesquared(s.origin, ent.origin);

          if(!isDefined(closestdistsq) || distsq < closestdistsq) {
            target = ent;
            closestdistsq = distsq;
          }
        }
      }

      if(!isDefined(target)) {
        continue;
      }

      ref = target.script_label;
      team = entry;

      if(isDefined(target.script_team) && isgameplayteam(target.script_team)) {
        if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_quarry2" && target.targetname == "gw_fob_03_safe_axis") {
          team = "axis";
        } else if(team == "team_three" || team == "team_four") {} else {
          team = target.script_team;
        }
      }

      if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
        loc = level.spawnselectionlocations[ref][team];

        if(!array_contains(loc.spawnpoints, s)) {
          loc.spawnpoints[loc.spawnpoints.size] = s;
        }

        continue;
      }

      struct = spawnStruct();
      struct.origin = target.origin;
      struct.angles = target.angles;
      struct.spawnpoints = [];
      struct.spawnpoints[0] = s;

      if(!issubstr(ref, "safe")) {
        initspawnarea(team, struct, ref);
        continue;
      }

      level.spawnselectionlocations[ref][team] = struct;
    }

    foreach(key, teamarray in level.spawnselectionlocations) {
      if(isDefined(teamarray[entry])) {
        scripts\mp\spawnlogic::registerspawnset(key + "_" + entry, teamarray[entry].spawnpoints);
      }
    }
  }

  level.usespawnselection = scripts\mp\spawnselection::function_167619fe3d0cff00() && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection) {
    level.getspawnpoint = &getspawnpoint;
  }
}

function initspawnarea(team, struct, ref) {
  typeid = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, ref);
  assertex(typeid >= 0, "<dev string:x1c>" + ref + "<dev string:x4f>");
  anchorent = spawn("script_model", struct.origin);
  anchorent setModel("tag_origin");
  struct.anchorentity = anchorent;
  struct.typeid = typeid;
  struct.typeref = ref;
  struct.owner = "allies";

  if(!issubstr(ref, "HQ") && !issubstr(ref, "vehicle")) {
    var_53db5ba095078996 = undefined;

    if(isDefined(level.localeid)) {
      var_53db5ba095078996 = getlabelid(ref + "_" + level.localeid);
    }

    if(!isDefined(var_53db5ba095078996) || var_53db5ba095078996 == -1) {
      struct.labelid = typeid;
    } else {
      struct.labelid = var_53db5ba095078996;
    }
  } else {
    struct.labelid = typeid;
  }

  if(isDefined(struct.dynamicent)) {
    anchorent linkTo(struct.dynamicent);
  }

  level.spawnselectionlocations[ref][team] = struct;
}

function getlabelid(ref) {
  labelid = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, ref);

  if(!isDefined(labelid)) {
    labelid = 0;
  }

  return labelid;
}

function setanchorent(ref, team, ent) {
  level.spawnselectionlocations[ref][team].anchorentity = ent;
}

function setupspawninfluencezones() {
  level.spawninfluencezones = [];

  for(i = 1; i <= 5; i++) {
    trigger = scripts\cp_mp\utility\game_utility::getlocaleent("gw_fob_0" + i + "_spawnInfluenceZone");

    if(!isDefined(trigger)) {
      continue;
    }

    scripts\mp\utility\trigger::makeenterexittrigger(trigger, &spawninfluencezone_onusebegin, &spawninfluencezone_onuseend);
    trigger.touchlist = [];
    level.spawninfluencezones["gw_fob_0" + i] = trigger;
  }
}

function spawninfluencezone_onusebegin(ent, trigger) {
  if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
    return;
  }

  trigger.touchlist = array_add(trigger.touchlist, ent);
}

function spawninfluencezone_onuseend(ent, trigger) {
  if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
    return;
  }

  trigger.touchlist = array_remove(trigger.touchlist, ent);
}

function isteamtouching(team) {
  found = 0;
  validtouchlist = [];

  foreach(entry in self.touchlist) {
    if(!isDefined(entry)) {
      continue;
    }

    if(isDefined(entry.team) && entry.team == team) {
      found = 1;
    }

    validtouchlist[validtouchlist.size] = entry;
  }

  self.touchlist = validtouchlist;
  return found;
}

function getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.team]);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    return spawnpoint;
  }

  spawnpoint = undefined;
  self.wassquadspawned = 0;

  if(isDefined(self.selectedspawnarea)) {
    printspawnmessage("spawnSelection::getSpawnPoint() = " + self.selectedspawnarea);

    if(issubstr(self.selectedspawnarea, "squad")) {
      index = undefined;

      if(self.selectedspawnarea == "squad_leader") {
        index = level.squaddata[self.team][self.sessionsquadid].squadleader.sessionuimemberindex;
      } else {
        index = int(getsubstr(self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size));
      }

      teammate = level.squaddata[self.team][self.sessionsquadid].players[index];
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(teammate);
      teammate thread scripts\mp\utility\points::doscoreevent(#"squad_spawn");
      thread scripts\mp\utility\points::doscoreevent(#"hash_5fe4192c1fd1be4c");
      self.wassquadspawned = 1;

      if(isDefined(teammate.vehicle)) {
        self.spawningintovehicle = 1;
        self.vehiclespawninginto = teammate.vehicle.vehiclename;
      }

      scripts\mp\utility\stats::incpersstat("spawnSelectSquad", 1);
      teammate scripts\mp\utility\stats::incpersstat("timesSelectedAsSquadLeader", 1);
    } else if(issubstr(self.selectedspawnarea, "dynamic")) {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, 2);
      thread scripts\mp\gametypes\arm_vehicles::spawnplayertoc130();
    } else if(issubstr(self.selectedspawnarea, "vehicle")) {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, 2);
      vehicleent = level.spawnselectionlocations[self.selectedspawnarea][self.team].dynamicent;
      forwardoffset = -200;
      heightoffset = 64;
      spawnpoint.origin = vehicleent.origin + anglesToForward(vehicleent.angles) * forwardoffset + (0, 0, heightoffset);
      spawnpoint.angles = (0, vehicleent.angles[1], 0);
      seat = function_d3d95972f58ad2bc(vehicleent);

      if(isDefined(seat) && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(vehicleent)) && (istrue(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(vehicleent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd()).var_1ad50a59da38c8f5) || seat == "driver")) {
        data = spawnStruct();
        data.useonspawn = 1;
        data.enterstartwaitmsg = "spawned_player";
        thread vehicle_occupancy_enter(vehicleent, seat, self, data);
      } else {
        exitboundinginfo = function_517f60905f08bf96(vehicleent);
        var_b8e7e41430673dd2 = vehicle_occupancy_getleveldataforvehicle(vehicleent.vehiclename);
        var_de71eef0ad57608 = 0;

        foreach(ref, direction in var_b8e7e41430673dd2.exitdirections) {
          if(direction == "top" || direction == "inside") {
            position = vehicle_occupancy_getexitposition(vehicleent, self, ref, exitboundinginfo, 1);
            exitoffset = var_b8e7e41430673dd2.exitoffsets[ref];

            if(isDefined(position)) {
              spawnpoint.origin = position;
              self.var_f109e15fae27ddc2 = vehicleent;
              self.platformoffset = exitoffset;
              thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicleent, self);
              break;
            }

            if(!var_de71eef0ad57608) {
              var_de71eef0ad57608 = 1;
              leveldataforvehicle = vehicle_occupancy_getleveldataforvehicle(vehicleent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
              exitoffset = leveldataforvehicle.exitoffsets[ref];
              spawnpoint.origin = vehicleent.origin + rotatevector(exitoffset, vehicleent.angles);
              self.var_f109e15fae27ddc2 = vehicleent;
              self.platformoffset = exitoffset;
              thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicleent, self);
            }
          }
        }
      }

      driver = vehicle_occupancy_getdriver(vehicleent);
      vehicleref = vehicleent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
      var_4ac41c9583912b8f = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(vehicleref).var_51b047bd40d984fe;

      if(isDefined(driver) && isDefined(var_4ac41c9583912b8f) && var_4ac41c9583912b8f != "") {
        driver thread scripts\mp\utility\points::doscoreevent(function_1823ff50bb28148d(var_4ac41c9583912b8f));
      }

      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else if(self.selectedspawnarea == "tac_insert") {
      if(isDefined(self.setspawnpoint)) {
        self.ti_spawn = 1;
        spawnpoint = self.setspawnpoint;
      }
    } else {
      if(isDefined(level.spawninfluencezones)) {
        trigger = undefined;
        keys = getarraykeys(level.spawninfluencezones);

        foreach(key in keys) {
          if(key == self.selectedspawnarea) {
            trigger = level.spawninfluencezones[key];
          }
        }

        if(isDefined(trigger) && trigger isteamtouching(getotherteam(self.team)[0])) {
          ref = self.selectedspawnarea + "_safe_" + self.team;
          spawnset = level.spawnglobals.spawnsets[ref];

          if(!isDefined(spawnset)) {
            ref = self.selectedspawnarea + "_" + self.team;
          }
        } else {
          ref = self.selectedspawnarea + "_" + self.team;
        }
      } else {
        ref = self.selectedspawnarea + "_" + self.team;
      }

      scripts\mp\spawnlogic::activatespawnset(ref, 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, 2);

      if(issubstr(self.selectedspawnarea, "alliesHQ") || issubstr(self.selectedspawnarea, "axisHQ")) {
        scripts\mp\utility\stats::incpersstat("spawnSelectBase", 1);
      } else {
        scripts\mp\utility\stats::incpersstat("spawnSelectFlag", 1);
      }
    }
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, 2);
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    spectatingteammate = self getspectatingplayer();

    if(isDefined(spectatingteammate) && isDefined(self.sessionsquadid) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid) {
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(spectatingteammate);
      spectatingteammate thread scripts\mp\utility\points::givexpwithtext(#"squad_spawn");
      thread scripts\mp\utility\points::givexpwithtext(#"hash_5fe4192c1fd1be4c");
      self.wassquadspawned = 1;
    }
  }

  return spawnpoint;
}

function refreshplayerspawnareaomnvars() {
  for(var_7df4a8a7599bcca3 = 0; var_7df4a8a7599bcca3 < 16; var_7df4a8a7599bcca3++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_7df4a8a7599bcca3, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var_7df4a8a7599bcca3, -1);
  }

  if(isDefined(self.forcedavailablespawnlocation)) {
    picklane(self.forcedavailablespawnlocation);
  }

  thread evaluatefobspawns();

  if(istrue(level.usesquadspawnselection)) {
    thread evaluatesquadspawn();
  }

  if(isDefined(self.setspawnpoint)) {
    thread function_7de3f8f504024fde();
  }
}

function evaluatefobspawns() {
  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateFOBSpawns");
  self endon("evaluateFOBSpawns");
  var_e62653e4f73622a = [];

  while(true) {
    if(var_e62653e4f73622a.size > level.availablespawnlocations[self.team].size) {
      thread refreshplayerspawnareaomnvars();
      return;
    }

    index = 0;

    foreach(entry in level.availablespawnlocations[self.team]) {
      if(!isDefined(var_e62653e4f73622a[index])) {
        break;
      }

      if(var_e62653e4f73622a[index].location != entry) {
        thread refreshplayerspawnareaomnvars();
        return;
      }

      index++;
    }

    index = 0;

    foreach(entry in level.availablespawnlocations[self.team]) {
      selected = level.spawnselectionlocations[entry][self.team];

      if(index == var_e62653e4f73622a.size) {
        data = spawnStruct();
        data.location = undefined;
        data.entity = undefined;
        data.id = undefined;
        var_e62653e4f73622a[var_e62653e4f73622a.size] = data;
      }

      if(!isDefined(var_e62653e4f73622a[index].location)) {
        var_e62653e4f73622a[index].location = entry;
      }

      if(!isDefined(var_e62653e4f73622a[index].entity)) {
        var_e62653e4f73622a[index].entity = selected.anchorentity;
        self setclientomnvar("ui_tom_spawn_entity_" + index, selected.anchorentity);
      }

      indanger = 0;
      isowned = 0;
      var_8d03c3781f6b70c0 = 0;
      var_5e41ee78365ed202 = 0;

      if(isDefined(selected.objectivekey)) {
        indanger = istrue(selected.indanger);
        isowned = level.objectives[selected.objectivekey].ownerteam == self.team;
      } else if(issubstr(entry, "vehicle")) {
        vehent = selected.dynamicent;

        if(isDefined(vehent) && !istrue(vehent.isdestroyed)) {
          indanger = istrue(vehent.indanger);
          var_8d03c3781f6b70c0 = hassquadmatepassengers(vehent, self);

          if(vehicle_occupancy_getavailablevehicleseats(vehent).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(vehent))) {
            var_5e41ee78365ed202 = 1;
          }
        }
      }

      id = selected.labelid;

      if(indanger) {
        id += 128;
      }

      if(isowned) {
        id += 256;
      }

      if(istrue(var_5e41ee78365ed202)) {
        id += 1024;
      }

      if(istrue(var_8d03c3781f6b70c0)) {
        id += 2048;
      }

      if(isDefined(selected.objectivekey) && !objective_isunlimited()) {
        id += 32768;
        objectiveindex = level.objectives[selected.objectivekey].objidnum;
        id += objectiveindex << 16;
      }

      if(!isDefined(var_e62653e4f73622a[index].id) || var_e62653e4f73622a[index].id != id) {
        var_e62653e4f73622a[index].id = id;
        self setclientomnvar("ui_tom_spawn_id_" + index, id);
      }

      index++;
    }

    waitframe();
  }
}

function isobjectiveindanger(objectivekey, team) {
  obj = level.objectives[objectivekey];

  switch (obj.id) {
    case #"hash_def5f510c5aa68f4":
      if(istrue(level.var_b307135dbcef5a38)) {
        return (team != obj.ownerteam);
      } else {
        return false;
      }
    case #"hash_ffc490adcece137f":
      if(!level.var_a09dce2c531d0bab) {
        return true;
      }

      if(istrue(level.var_f335c53db1d6dd34)) {
        return (team != obj.ownerteam);
      }

      checkpct = level.var_c0e8540c63b7af50 > 0;
      allowpercent = isDefined(obj.var_f271d42faf329b89) && obj.var_f271d42faf329b89 <= level.var_c0e8540c63b7af50;

      if(checkpct) {
        return !allowpercent;
      } else {
        return false;
      }
    case #"hash_2da0874a234cfd12":
      return false;
    default:
      var_90ee2572b0fe338a = obj.ownerteam != team;
      iscontested = !level.var_f13131261b4c6ad5 && obj.stalemate;
      isblocked = !level.var_ca4fe20b267c4f54 && obj.captureblocked;
      isbeingcaptured = !level.var_4d2556c1d0f4893e && obj.claimteam != "none" && obj.claimteam != team;
      var_a3a90d8c2aee0964 = !level.var_7119a108c4ba4d2c && istrue(obj.spawnpointdanger);
      var_adfc287fdbf815aa = level.var_c0e8540c63b7af50 > 0 && obj.curprogress / obj.usetime <= level.var_c0e8540c63b7af50;

      if(var_adfc287fdbf815aa) {
        iscontested = 0;
        isblocked = 0;
        isbeingcaptured = 0;
        isbeingcaptured = 0;
      }

      return (var_90ee2572b0fe338a || iscontested || isblocked || isbeingcaptured || var_a3a90d8c2aee0964);
  }

  return false;
}

function isvehicleindanger(vehent) {
  currenttime = gettime();
  tookdamage = isDefined(vehent) && isDefined(vehent.lasttimedamaged) && vehent.lasttimedamaged + 5000 > currenttime;
  oob = isDefined(vehent) && vehent scripts\mp\outofbounds::istouchingoobtrigger();
  enemyinproximity = 0;

  if(isDefined(vehent.team)) {
    var_35c341a22b58d17d = utility::playersnear(vehent.origin, 384);

    foreach(player in var_35c341a22b58d17d) {
      if(isDefined(player) && player.team != vehent.team && isalive(player) && !isDefined(player.fauxdead)) {
        if(abs(vehent.origin[2] - player.origin[2]) < 100) {
          enemyinproximity = 1;
          break;
        }
      }
    }
  }

  return tookdamage || oob || enemyinproximity;
}

function function_167619fe3d0cff00() {
  if(!isDefined(level.usespawnselection)) {
    level.usespawnselection = getdvarint(@ "scr_game_usespawnselection", 0) != 0;
  }

  return level.usespawnselection;
}

function vehicleindangertracking(vehent) {
  vehent endon("death");
  vehent.indanger = 0;
  ignoredamagethreshold = getdvarfloat(@ "hash_b5bc6252b2764d8c", 0.15);

  while(true) {
    currenttime = gettime();
    burningdown = istrue(vehent.burningdown);
    missilelocked = scripts\cp_mp\utility\weapon_utility::islockedonto(vehent);
    var_f7772e25266681de = vehicle_occupancy_canspawninto(vehent);
    tookdamage = isDefined(vehent) && isDefined(vehent.lasttimedamaged) && vehent.lasttimedamaged + 5000 > currenttime;
    oob = isDefined(vehent) && vehent scripts\mp\outofbounds::istouchingoobtrigger();
    isbeached = 0;
    enemyinproximity = 0;

    if(isDefined(vehent.team) && vehent.vehiclename != "apc_russian" && vehent.vehiclename != "veh9_apc_8x8") {
      var_35c341a22b58d17d = utility::playersnear(vehent.origin, 384);

      foreach(player in var_35c341a22b58d17d) {
        if(isDefined(player) && player.team != vehent.team && isalive(player) && !isDefined(player.fauxdead)) {
          if(abs(vehent.origin[2] - player.origin[2]) < 100) {
            enemyinproximity = 1;
            break;
          }
        }
      }
    }

    if(vehent.vehiclename == "apc_russian" || vehent.vehiclename == "veh9_apc_8x8" || vehent.vehiclename == "veh9_palfa") {
      currenthealthpct = vehent.health / vehent.maxhealth;

      if(currenthealthpct > ignoredamagethreshold) {
        tookdamage = 0;
      }

      missilelocked = 0;
    } else if(vehent.vehiclename == "veh9_patrol_boat") {
      isbeached = vehent vehicle_isonground();
    }

    lastoutcome = vehent.indanger;
    vehent.indanger = tookdamage || oob || enemyinproximity || burningdown || missilelocked || !var_f7772e25266681de || isbeached;
    waitframe();
  }
}

function hassquadmatepassengers(vehicle, player) {
  if(!isDefined(level.squaddata)) {
    return false;
  }

  squadmates = level.squaddata[self.team][self.sessionsquadid].players;

  foreach(occupant in vehicle.occupants) {
    foreach(mate in squadmates) {
      if(mate == occupant) {
        return true;
      }
    }
  }

  return false;
}

function setspawnselectionorder() {
  markers = getStructArray("axisLeft_alliesRight", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_ef171a7416dc2ab0 = undefined;

    foreach(marker in markers) {
      if(marker.script_noteworthy == level.localeid) {
        var_ef171a7416dc2ab0 = marker;
      }
    }

    assert(isDefined(var_ef171a7416dc2ab0), "<dev string:x54>" + level.localeid);
  } else {
    var_ef171a7416dc2ab0 = getStruct("axisLeft_alliesRight", "targetname");
  }

  var_c099305bcdb72ad7 = [];

  foreach(location in level.spawnselectionlocations) {
    foreach(index, team in location) {
      if(index != self.team) {
        continue;
      }

      var_c099305bcdb72ad7[var_c099305bcdb72ad7.size] = team;
    }
  }

  if(self.team == "axis") {
    objectives_ordered = var_ef171a7416dc2ab0 array_sort_with_func(var_c099305bcdb72ad7, &sortlocationsbydistance_closestfirst);
  } else {
    objectives_ordered = var_ef171a7416dc2ab0 array_sort_with_func(var_c099305bcdb72ad7, &sortlocationsbydistance_farthestfirst);
  }

  foreach(index, objective in objectives_ordered) {
    self setclientomnvar("ui_tom_spawn_entity_" + index, objective.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + index, objective.labelid);
  }
}

function sortlocationsbydistance_closestfirst(location1, location2) {
  return distancesquared(location1.origin, self.origin) < distancesquared(location2.origin, self.origin);
}

function sortlocationsbydistance_farthestfirst(location1, location2) {
  return distancesquared(location1.origin, self.origin) > distancesquared(location2.origin, self.origin);
}

function picklane(lane) {
  areakey = undefined;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, lane)) {
      areakey = loc;
      break;
    }
  }

  if(!isDefined(areakey)) {
    return;
  }

  if(!isDefined(level.spawnselectionlocations[areakey])) {
    return;
  }

  selected = level.spawnselectionlocations[areakey][self.team];

  if(!isDefined(selected)) {
    return;
  }

  var_4e2f30f5b1dfa9f3 = self.team == "allies";
  laneindex = 0;

  switch (lane) {
    case #"hash_2eafa9a536901cad":
    case #"hash_7270631ce8f6357f":
    case #"hash_c9b3133a17a3b2d0":
      laneindex = ter_op(var_4e2f30f5b1dfa9f3, 0, 2);
      break;
    case #"hash_2881ce6c1efb40c5":
    case #"hash_2eafa6a5369017f4":
    case #"hash_7273231ce8f80f56":
      laneindex = 1;
      break;
    case #"hash_2eafa7a536901987":
    case #"hash_726a231ce8f15391":
    case #"hash_96815ce4f2a3dbc5":
      laneindex = ter_op(var_4e2f30f5b1dfa9f3, 2, 0);
      break;
  }

  self setclientomnvar("ui_tom_spawn_entity_" + laneindex, selected.anchorentity);
  self setclientomnvar("ui_tom_spawn_id_" + laneindex, selected.labelid);
}

function refreshsquadspawns() {
  omnvarindex = 3;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, "squad_")) {
      selected = level.spawnselectionlocations[loc][self.team];
      self setclientomnvar("ui_tom_spawn_entity_" + omnvarindex, selected.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + omnvarindex, selected.labelid);
      omnvarindex++;
    }
  }
}

function refreshdynamicspawns() {
  omnvarindex = 6;

  foreach(loc in level.availablespawnlocations[self.team]) {
    if(issubstr(loc, "dynamic_")) {
      if(!isDefined(level.spawnselectionlocations[loc][self.team])) {
        continue;
      }

      selected = level.spawnselectionlocations[loc][self.team];

      if(!isDefined(selected)) {
        continue;
      }

      self setclientomnvar("ui_tom_spawn_entity_" + omnvarindex, selected.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + omnvarindex, selected.labelid);
      omnvarindex++;
    }
  }
}

function waitforspawnselection(timeuntilspawn, forcepick) {
  if(istrue(level.gameended) || istrue(level.nukeinfo.detonated)) {
    pickrandomnonvehiclespawn();
    return;
  }

  self endon("disconnect");
  self.selectedspawnarea = undefined;
  refreshplayerspawnareaomnvars();
  getclosestavailablespawnlocation();

  if(istrue(level.forcetopickafob)) {
    timeuntilspawnmessaging(1, "waiting_to_spawn");
    pickrandomnonvehiclespawn();
    return;
  }

  if(isai(self) || istrue(forcepick) || issubstr(self.name, "_hl_")) {
    timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      return;
    }

    pickrandomnonvehiclespawn();
    return;
  }

  while(!gameflag("prematch_done")) {
    waitframe();
  }

  self lerpfovscalefactor(0, 0.2);
  spawnselectionthink(timeuntilspawn);
  self lerpfovscalefactor(1, 0.2);
}

function pickrandomnonvehiclespawn() {
  var_e7479a24d5e8f522 = array_randomize(level.availablespawnlocations[self.team]);

  foreach(area in var_e7479a24d5e8f522) {
    if(issubstr(area, "fob") || issubstr(area, "HQ")) {
      self.selectedspawnarea = area;
      return;
    }
  }
}

function pickrandomvehiclespawn(var_b6603908715584da) {
  if(!isDefined(var_b6603908715584da)) {
    var_b6603908715584da = "vehicle";
  }

  var_e7479a24d5e8f522 = array_randomize(level.availablespawnlocations[self.team]);

  foreach(area in var_e7479a24d5e8f522) {
    if(issubstr(area, "vehicle")) {
      self.selectedspawnarea = area;
      return;
    }
  }
}

function pickrandomspawn() {
  [self.selectedspawnarea] = array_randomize(level.availablespawnlocations[self.team]);
}

function function_37b8d5f51288ba7d() {
  timeoutms = getdvarint(@ "hash_b7cddbc61e64ed", 2000);

  if(!istrue(self.var_a7461778c6502729) && gameflag("prematch_done")) {
    timeoutms = getdvarint(@ "hash_a06dc2c4de808757", 9000);
    self.var_a7461778c6502729 = 1;
  }

  spawncamera = scripts\mp\spawncamera::getspawncamera();
  streamorigin = scripts\mp\gametypes\br_public::playerstreamhintlocation(spawncamera.origin, timeoutms);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

function spawnselectionthink(timeuntilspawn) {
  level endon("game_ended");
  self endon("disconnect");
  thread checkformatchend();

  if(istrue(level.gameended)) {
    return;
  }

  if(isteamreviveenabled()) {
    return;
  }

  if(istrue(level.nukeinfo.detonated)) {
    return;
  }

  if(!self[[level.var_d280c5fdb0036183]]()) {
    return;
  }

  scripts\mp\class::loadout_clearperks();
  thread scripts\mp\spawncamera::startspawncamera(0, 0, 0);
  thread function_37b8d5f51288ba7d();
  self.selectedspawnarea = undefined;
  self.inspawnselection = 1;
  self setclientomnvar("ui_hide_objectives", 1);
  thread selectiondelaymessaging(timeuntilspawn);

  if(istrue(level.spawnselectionshowfriendly) || istrue(level.spawnselectionshowenemy)) {
    thread scripts\mp\flashpoint::flashpoint_spawnselectionvfx();
  }

  if(istrue(level.showteamtanks)) {
    thread vehicle_showteamtanks();
  }

  wait 0.5;

  if(isDefined(level.var_111c5f085a86c2f0)) {
    self[[level.var_111c5f085a86c2f0]]();
  }

  self setclientomnvar("ui_hide_objectives", 0);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  self cameralinkTo(self.spawncameraent, "tag_origin", 1);
  printspawnmessage("spawnselection::spawnSelectionThink() CameralinkTo()");
  thread timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");
  thread selectionmade();

  if(istrue(level.checkspawnselectionafk)) {
    thread watchforafk();
  }

  self.var_f9cd51a4708ec70f = 0;

  while(true) {
    endcondition = watchendconditions();
    var_83cb6d50fa2daf87 = 1;

    switch (endcondition) {
      case #"hash_2400cb6252980d91":
        var_83cb6d50fa2daf87 = 1;
        break;
      case #"hash_eccbb0b46937db3a":
        var_83cb6d50fa2daf87 = 0;
        refreshplayerspawnareaomnvars();
        break;
      case #"hash_d79f98d6ba6dd9de":
        var_83cb6d50fa2daf87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case #"hash_315ca762a236ee4b":
        var_83cb6d50fa2daf87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case #"hash_e73d5cfa4614c287":
        var_83cb6d50fa2daf87 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case #"hash_8bfb9f6e1ffad7f4":
        var_83cb6d50fa2daf87 = 0;
        break;
      case #"hash_af2638e19142720b":
        var_83cb6d50fa2daf87 = 0;
        self setclientomnvar("ui_hide_objectives", 1);
        self setclientomnvar("ui_tac_ops_map_open", 0);
        thread spawnselectionshutdown_nuke();
        break;
      case #"hash_e3e8e9e8b2bb7b82":
        var_83cb6d50fa2daf87 = 1;
        self.var_f9cd51a4708ec70f = 1;
        break;
      default:
        assertmsg("<dev string:x98>");
        break;
    }

    if(var_83cb6d50fa2daf87) {
      self notify("stop_spawnselection_afk");
      self setclientomnvar("ui_tac_ops_map_open", 0);
      self.inspawnselection = 0;

      if(isDefined(level.var_aba39caf969cd3f7)) {
        self[[level.var_aba39caf969cd3f7]]();
      }

      return;
    }
  }
}

function checkformatchend() {
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

  if(isDefined(level.spawnselectionafktime)) {
    wait level.spawnselectionafktime;
  } else {
    wait 60;
  }

  self notify("afk_disconnection_imminent");
  wait 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

function selectiondelaymessaging(timeuntilspawn) {
  self endon("disconnect");
  self.canprocessselection = 0;

  if(getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "gwbomb" || getgametype() == "bigctf") {
    self setclientomnvar("ui_tom_respawnTimerActive", 1);
  }

  if(timeuntilspawn > 0) {
    wait timeuntilspawn;
  }

  if(getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "gwbomb" || getgametype() == "bigctf") {
    self setclientomnvar("ui_tom_respawnTimerActive", 0);
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar("select_spawn");
  self.canprocessselection = 1;

  if(isDefined(self.selectedspawnarea)) {
    validateselectedspawnarea();
  }
}

function validateselectedspawnarea() {
  foreach(loc in level.availablespawnlocations[self.team]) {
    if(loc == self.selectedspawnarea) {
      self notify("tac_ops_map_selection_made");
      return;
    }
  }

  self.selectedspawnarea = undefined;
}

function selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  while(true) {
    self waittill("luinotifyserver", message, var_84d6164f2a6eb8da);

    if(message == "tac_ops_spawn_area_selected") {
      var_84d6164f2a6eb8da = updateplayerspawninputtype(var_84d6164f2a6eb8da);
      printspawnmessage("spawnSelection::selectionMade() START");
      selectedspawnarea = undefined;

      foreach(loc in level.spawnselectionlocations) {
        if(isDefined(loc[self.team]) && isDefined(loc[self.team].anchorentity) && loc[self.team].anchorentity getentitynumber() == var_84d6164f2a6eb8da) {
          updatespecificfobindanger(loc[self.team].typeref, self, self.team);

          if(isDefined(loc[self.team].objectivekey) && isobjectiveindanger(loc[self.team].objectivekey, self.team)) {
            break;
          }

          if(isDefined(loc[self.team].typeref) && issubstr(loc[self.team].typeref, "vehicle") && istrue(loc[self.team].dynamicent.indanger)) {
            break;
          }

          selectedspawnarea = loc[self.team].typeref;
          break;
        }
      }

      if(!isDefined(selectedspawnarea)) {
        squadlocations = getsquadspawnlocations(self.team, self.sessionsquadid);

        foreach(loc in squadlocations) {
          if(isDefined(loc.dynamicent) && loc.dynamicent getentitynumber() == var_84d6164f2a6eb8da) {
            if(loc.dynamicent.team != self.team || loc.dynamicent.sessionsquadid != self.sessionsquadid) {
              thread refreshplayerspawnareaomnvars();
              assertmsg("<dev string:xcf>" + "<dev string:x108>" + self.team + "<dev string:x123>" + self.sessionsquadid + "<dev string:x142>" + loc.dynamicent + "<dev string:x15d>" + loc.dynamicent.sessionsquadid);
              break;
            }

            if(issquadmateindanger(loc.dynamicent)) {
              break;
            }

            vehicle = loc.dynamicent.vehicle;

            if(isDefined(vehicle)) {
              if(vehicle_occupancy_getavailablevehicleseats(vehicle).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(vehicle))) {
                break;
              }
            }

            spawninfo = spawnStruct();
            spawninfo = scripts\mp\spawnscoring::capsulepass(spawninfo, loc.dynamicent);

            if(!isDefined(spawninfo.spawnposition)) {
              loc.dynamicent.nogroundfoundtime = gettime();
              break;
            }

            selectedspawnarea = loc.typeref;
            break;
          }
        }
      }

      if(!isDefined(selectedspawnarea)) {
        if(isDefined(self.setspawnpoint) && self.setspawnpoint getentitynumber() == var_84d6164f2a6eb8da) {
          selectedspawnarea = "tac_insert";
        } else {
          continue;
        }
      }

      var_f199bbb576943488 = issubstr(selectedspawnarea, "squad");
      var_a95007e8e6d9d166 = getdvarint(@ "hash_517d1754377878d8", 0) == 1;

      if(istrue(self.canprocessselection) || var_f199bbb576943488 && var_a95007e8e6d9d166) {
        printspawnmessage("spawnSelection::selectionMade() = " + selectedspawnarea);
        self.selectedspawnarea = selectedspawnarea;
        self notify("tac_ops_map_selection_made");
        return;
      }
    }
  }
}

function updateplayerspawninputtype(var_84d6164f2a6eb8da) {
  if(!isDefined(self.gwinputtypesused)) {
    self.gwinputtypesused = [];
  }

  var_c1606c1030582cfa = 65536;
  var_9078b4c4e3258dfb = 131072;
  mask_activate = 262144;
  var_e4f4a7af0d80ea24 = 524288;
  self.gwinputtypesused["rightmouseup"] = istrue(self.gwinputtypesused["rightmouseup"]) || (var_84d6164f2a6eb8da &var_c1606c1030582cfa) > 0;
  self.gwinputtypesused["leftmouseup"] = istrue(self.gwinputtypesused["leftmouseup"]) || (var_84d6164f2a6eb8da &var_9078b4c4e3258dfb) > 0;
  self.gwinputtypesused["activate"] = istrue(self.gwinputtypesused["activate"]) || (var_84d6164f2a6eb8da &mask_activate) > 0;
  self.gwinputtypesused["gostand"] = istrue(self.gwinputtypesused["gostand"]) || (var_84d6164f2a6eb8da &var_e4f4a7af0d80ea24) > 0;
  return var_84d6164f2a6eb8da &~(var_c1606c1030582cfa | var_9078b4c4e3258dfb | mask_activate | var_e4f4a7af0d80ea24);
}

function watchendconditions() {
  self endon("disconnect");
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  thread endconditionwatcher_nuke();
  thread function_b0e57461a4af2476();
  result = function_efe4706df8361219("tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke", "tac_ops_map_no_valid_selections");
  self notify("tac_ops_end_condition_met");
  return result;
}

function endconditionwatcher_selectionmade() {
  self endon("disconnect");
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  while(true) {
    self waittill("tac_ops_map_selection_made");
    self notify("tac_ops_map_selection_valid");
    break;
  }
}

function endcondition_focuschanged(var_84d6164f2a6eb8da) {
  if(isDefined(self.selectedspawnarea)) {
    return;
  }

  self endon("disconnect");
  self notify("endConditionWatcher_FocusChanged()");
  self endon("endConditionWatcher_FocusChanged()");
  self notify("tac_ops_spawn_focus_changed");
  printspawnmessage("endCondition_FocusChanged() START");
  selectedspawnarea = undefined;

  foreach(loc in level.spawnselectionlocations) {
    if(isDefined(loc[self.team]) && isDefined(loc[self.team].anchorentity) && loc[self.team].anchorentity getentitynumber() == var_84d6164f2a6eb8da) {
      thread keepstreamposfresh(loc[self.team].anchorentity.origin);
      selectedspawnarea = loc[self.team].typeref;
      break;
    }
  }

  if(!isDefined(selectedspawnarea)) {
    squadlocations = getsquadspawnlocations(self.team, self.sessionsquadid);

    foreach(loc in squadlocations) {
      if(isDefined(loc.dynamicent) && loc.dynamicent getentitynumber() == var_84d6164f2a6eb8da) {
        thread keepstreamposfresh(loc.dynamicent.origin);
        selectedspawnarea = loc.typeref;
        break;
      }
    }
  }

  if(!isDefined(selectedspawnarea)) {
    return;
  }

  printspawnmessage("endCondition_FocusChanged() = " + selectedspawnarea);
  self setclientomnvar("ui_tom_veh_health_percent", 0);

  if(issubstr(selectedspawnarea, "squad")) {
    if(!istrue(level.var_72c2648ce78bea79)) {
      thread managesquadcameraposition(selectedspawnarea);
    }

    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);
    self setclientomnvar("ui_tom_previous_selection", id);
    return;
  }

  if(issubstr(selectedspawnarea, "vehicle")) {
    if(!istrue(level.var_8f6541607d5dda6b)) {
      thread managevehiclecameraposition(selectedspawnarea);
    }

    thread managevehiclehealthui(selectedspawnarea);
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);
    self setclientomnvar("ui_tom_previous_selection", id);
    return;
  }

  id = -1;

  if(isDefined(level.localeid)) {
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea + "_" + level.localeid);
  }

  if(id == -1) {
    id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, selectedspawnarea);
  }

  self setclientomnvar("ui_tom_previous_selection", id);

  if(isDefined(level.spawncameras[selectedspawnarea]) && isDefined(level.spawncameras[selectedspawnarea][self.team])) {
    self.forcedspawncameraref = selectedspawnarea;

    while(!gameflag("prematch_done")) {
      waitframe();
    }

    thread scripts\mp\spawncamera::movetospawncamera(0);
  }
}

function keepstreamposfresh(origin) {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");
  self endon("spawned_player");
  self notify("keepStreamPosFresh");
  self endon("keepStreamPosFresh");

  while(true) {
    self function_bc667001f9dd3808(origin, 1);
    wait 1;
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

function function_b0e57461a4af2476() {
  self endon("disconnect");
  self endon("tac_ops_map_selection_valid");

  while(self[[level.var_d280c5fdb0036183]]()) {
    waitframe();
  }

  self notify("tac_ops_map_no_valid_selections");
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

function adddynamicspawnarea(team, ent, ref, offset) {
  if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
    areastruct = level.spawnselectionlocations[ref][team];
    areastruct.origin = ent.origin + ter_op(isDefined(offset), offset, (0, 0, 0));
    areastruct.angles = ent.angles;
    return;
  }

  areastruct = spawnStruct();
  areastruct.origin = ent.origin + ter_op(isDefined(offset), offset, (0, 0, 0));
  areastruct.angles = ent.angles;
  areastruct.dynamicent = ent;
  areastruct.script_noteworthy = ref;
  initspawnarea(team, areastruct, ref);
  updatespawnareas();
}

function removedynamicspawnarea(team, ref) {
  if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
    level.spawnselectionlocations[ref][team] = undefined;

    if(level.spawnselectionlocations[ref].size == 0) {
      level.spawnselectionlocations[ref] = undefined;
    }
  }

  updatespawnareas();
}

function getsquadspawnlocations(team, squadindex) {
  locations = [];

  if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[team]) && isDefined(level.squadspawnselectionlocations[team][squadindex])) {
    locations = level.squadspawnselectionlocations[team][squadindex];
  }

  return locations;
}

function updatesquadspawn(team, squad, ref, ent) {
  if(!isDefined(level.squadspawnselectionlocations)) {
    level.squadspawnselectionlocations = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[team])) {
    level.squadspawnselectionlocations[team] = [];
  }

  if(!isDefined(level.squadspawnselectionlocations[team][squad])) {
    level.squadspawnselectionlocations[team][squad] = [];
  }

  if(isDefined(level.squadspawnselectionlocations[team][squad][ref])) {
    if(!isDefined(ent)) {
      level.squadspawnselectionlocations[team][squad][ref] = undefined;
      return;
    }

    areastruct = level.squadspawnselectionlocations[team][squad][ref];
    areastruct.typeref = ref;
    areastruct.origin = ent.origin;
    areastruct.angles = ent.angles;
    areastruct.dynamicent = ent;
    return;
  }

  if(!isDefined(ent)) {
    return;
  }

  areastruct = spawnStruct();
  areastruct.typeref = ref;
  areastruct.origin = ent.origin;
  areastruct.angles = ent.angles;
  areastruct.dynamicent = ent;
  level.squadspawnselectionlocations[team][squad][ref] = areastruct;
}

function removespawnareaondeathdisconnect(team, ref) {
  self endon("tac_ops_end_condition_met");
  adddynamicspawnarea(team, self, ref);
  self waittill("death_or_disconnect");
  thread addspawnareaonspawn(team, ref);
}

function addspawnareaonspawn(team, ref) {
  self endon("tac_ops_end_condition_met");
  removedynamicspawnarea(team, ref);
  self endon("disconnect");
  self waittill("spawned_player");
  thread removespawnareaondeathdisconnect(team, ref);
}

function function_360feec64890e6f1() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tacInsert_destroyed");
  self.var_eaea86358d19ed20 = 1;
  var_f148fcd88267d96e = int(level.tispawndelay);
  self setclientomnvar("ui_tom_ti_respawnTimer", gettime() + var_f148fcd88267d96e * 1000);

  while(true) {
    var_f148fcd88267d96e = clamp(var_f148fcd88267d96e, 0, level.tispawndelay);

    if(var_f148fcd88267d96e == 0) {
      self setclientomnvar("ui_tom_ti_respawnTimer", 0);
      self.var_eaea86358d19ed20 = 0;
      return;
    } else {
      var_f148fcd88267d96e -= level.framedurationseconds;
    }

    waitframe();
  }
}

function function_7de3f8f504024fde() {
  if(!isDefined(self.setspawnpoint)) {
    return;
  }

  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateTISpawn");
  self endon("evaluateTISpawn");
  startindex = level.availablespawnlocations[self.team].size;
  tiindex = startindex + 4;
  tidata = spawnStruct();
  tidata.entity = self.setspawnpoint;
  tidata.id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "tac_insert");

  if(!istrue(self.var_eaea86358d19ed20)) {
    thread function_360feec64890e6f1();
  }

  while(true) {
    if(!isDefined(self.setspawnpoint)) {
      self setclientomnvar("ui_tom_spawn_id_" + tiindex, -1);
      self setclientomnvar("ui_tom_spawn_entity_" + tiindex, undefined);
      refreshplayerspawnareaomnvars();
      return;
    }

    self setclientomnvar("ui_tom_spawn_id_" + tiindex, tidata.id);
    self setclientomnvar("ui_tom_spawn_entity_" + tiindex, tidata.entity);
    waitframe();
  }
}

function evaluatesquadspawn() {
  if(!isDefined(level.squaddata)) {
    return;
  }

  self endon("disconnect");
  self endon("end_respawn");
  self notify("evaluateSquadSpawn");
  self endon("evaluateSquadSpawn");
  startindex = level.availablespawnlocations[self.team].size;
  typeid = [];
  typeid[0] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_0");
  typeid[1] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_1");
  typeid[2] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_2");
  typeid[3] = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_3");
  squadleaderid = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, "squad_leader");
  var_5966e8a05a4d1903 = [];

  for(i = 0; i < 4; i++) {
    data = spawnStruct();
    data.guid = undefined;
    data.entity = undefined;
    data.idmask = undefined;
    var_5966e8a05a4d1903[i] = data;
  }

  squadrefs = [];

  for(i = 0; i < 4; i++) {
    squadrefs[i] = "squad_" + i;
  }

  while(true) {
    squadleader = scripts\cp_mp\utility\squad_utility::getsquadleader(self.team, self.sessionsquadid);
    players = level.squaddata[self.team][self.sessionsquadid].players;

    for(i = 0; i < 4; i++) {
      if(!isDefined(var_5966e8a05a4d1903[i].guid)) {
        continue;
      }

      if(!isDefined(players[i]) || players[i].guid != var_5966e8a05a4d1903[i].guid) {
        thread refreshplayerspawnareaomnvars();
        return;
      }
    }

    for(i = 0; i < 4; i++) {
      if(i < players.size) {
        player = players[i];
      } else {
        player = undefined;
      }

      ref = squadrefs[i];
      updatesquadspawn(self.team, self.sessionsquadid, ref, player);
    }

    locations = getsquadspawnlocations(self.team, self.sessionsquadid);

    for(i = 0; i < 4; i++) {
      if(i < players.size) {
        player = players[i];
      } else {
        player = undefined;
      }

      issquadleader = isDefined(player) && isDefined(squadleader) && player == squadleader;

      if(!issquadleader && istrue(level.spawnsquadleaderonly)) {
        continue;
      }

      ref = squadrefs[i];
      selected = locations[ref];
      var_d059a36c2835b580 = isDefined(player) && isDefined(player.vehicle) && istrue(player.vehicle.israllypointvehicle);

      if(isDefined(player) && self != player && issquadspawnable(player) && !istrue(var_d059a36c2835b580)) {
        indanger = istrue(player.indanger);
        idmask = typeid[i];

        if(indanger) {
          idmask += 128;
        }

        if(issquadleader) {
          idmask += 256;
        }

        if(isDefined(player.vehicle)) {
          idmask += 512;

          if(vehicle_occupancy_getavailablevehicleseats(player.vehicle).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(player.vehicle))) {
            idmask += 1024;
          }

          if(player.vehicle.vehiclename == "little_bird" || player.vehicle.vehiclename == "little_bird_mg") {
            idmask += 4096;
          }
        }

        idmask += player.sessionuimemberindex << 13;

        if(!isDefined(var_5966e8a05a4d1903[i].guid)) {
          var_5966e8a05a4d1903[i].guid = player.guid;
        }

        if(!isDefined(var_5966e8a05a4d1903[i].entity) && isDefined(selected) && isDefined(selected.dynamicent)) {
          var_5966e8a05a4d1903[i].entity = selected.dynamicent;
          self setclientomnvar("ui_tom_spawn_entity_" + startindex + i, selected.dynamicent);
        }

        if(!isDefined(var_5966e8a05a4d1903[i].idmask) || var_5966e8a05a4d1903[i].idmask != idmask) {
          var_5966e8a05a4d1903[i].idmask = idmask;
          self setclientomnvar("ui_tom_spawn_id_" + startindex + i, idmask);
        }

        continue;
      }

      if(isDefined(var_5966e8a05a4d1903[i].entity)) {
        var_5966e8a05a4d1903[i].entity = undefined;
        self setclientomnvar("ui_tom_spawn_entity_" + startindex + i, undefined);
      }

      if(isDefined(var_5966e8a05a4d1903[i].idmask) && var_5966e8a05a4d1903[i].idmask != -1) {
        var_5966e8a05a4d1903[i].idmask = -1;
        self setclientomnvar("ui_tom_spawn_id_" + startindex + i, -1);
      }
    }

    waitframe();
  }
}

function handlerespawnselection(spawnedasspectator, timeuntilspawn) {
  level endon("game_ended");
  self endon("disconnect");
  respawntype = undefined;

  if(!isDefined(respawntype)) {
    if(istrue(level.usec130spawnfirstonly) && istrue(level.usec130spawn) && !istrue(self.spawnedusingc130) && isDefined(level.spawnc130[self.team])) {
      respawntype = 1;
    } else if(istrue(level.usesquadspawn)) {
      respawntype = 0;
    } else if(istrue(level.usespawnselection)) {
      respawntype = 2;
    } else if(istrue(level.usec130spawn)) {
      respawntype = 1;
    } else {
      respawntype = 3;
    }
  }

  initialtime = gettime();
  selectionmade = 0;

  while(!selectionmade) {
    currenttime = gettime();
    spawndelay = (initialtime + timeuntilspawn * 1000 - currenttime) / 1000;

    switch (respawntype) {
      case 0:
        self.squadspawnconfirmed = 0;
        self.squadspawnaborted = 0;

        if(!isai(self)) {
          thread handlesquadspawnabort();
        }

        if(!spawnedasspectator) {
          thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }

        spawnedasspectator = 1;
        startindex = ter_op(isDefined(self.spawnselectedsquadmate), self.spawnselectedsquadmate, 0);

        if(thread cyclevalidsquadspectate(startindex, 1)) {
          if(!isai(self)) {
            result = handlesquadspawnconfirm(spawndelay);

            if(!istrue(result)) {
              self.squadspawnaborted = 1;
            } else {
              self.squadspawnconfirmed = 1;
            }
          } else {
            timeuntilspawnmessaging(timeuntilspawn, "spawn_revive_wait");

            if(cointoss()) {
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
            respawntype = 1;
          } else if(istrue(level.usespawnselection)) {
            respawntype = 2;
          } else {
            respawntype = 3;
          }
        } else {
          selectionmade = 1;
        }

        break;
      case 1:
        thread scripts\mp\spawncamera::startspawncamera();
        cameradelay = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(cameradelay)) {
          cameradelay = 0;
        }

        if(istrue(level.usec130spawnfirstonly)) {
          self.spawnedusingc130 = 1;
        }

        spawntoc130();
        selectionmade = 1;
        break;
      case 2:
        caninfil = gameflag("infil_will_run") && !istrue(gameflag("infil_started"));

        if((getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "bigctf") && !caninfil && !gameflag("prematch_done")) {
          camerapositions = [[level.var_e637d49948a038d3]](self.team);
          cament = spawn("script_model", camerapositions.startorigin);
          cament setModel("tag_origin");
          cament.angles = camerapositions.startangles;
          self cameralinkTo(cament, "tag_origin");
          cament moveTo(camerapositions.endorigin, 18);
          cament rotateTo(camerapositions.endangles, 18);
          gameflagwait("prematch_done");
          self cameraunlink();
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        } else {
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0, 0.5, 0.5);
        }

        cameradelay = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(cameradelay)) {
          cameradelay = 0;
        }

        waitforspawnselection(spawndelay + cameradelay);

        if(isDefined(self.selectedspawnarea)) {
          selectionmade = 1;
        }

        break;
      case 3:
        thread scripts\mp\spawncamera::startspawncamera();
        cameradelay = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(cameradelay)) {
          cameradelay = 0;
        }

        timeuntilspawnmessaging(spawndelay + cameradelay, "waiting_to_spawn");
        selectionmade = 1;
        break;
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");
    }

    if(!spawnedasspectator) {
      thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;
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

  while(true) {
    result = waittill_any_return_2("cyclePos", "cycleNeg");

    if(isDefined(result)) {
      current = self getspectatingplayer();

      if(result == "cyclePos") {
        thread cyclevalidsquadspectate(current.sessionuimemberindex, 1);
        continue;
      }

      if(result == "cycleNeg") {
        thread cyclevalidsquadspectate(current.sessionuimemberindex, 0);
      }
    }
  }
}

function handlesquadspawnconfirm(timeuntilspawn) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  timeuntilspawnmessaging(timeuntilspawn, "waiting_to_spawn");
  scripts\mp\utility\lower_message::setlowermessageomnvar("squad_spawn");
  self notifyonplayercommand("respawn_confirm", "+usereload");
  self waittill("respawn_confirm");
  return true;
}

function cyclevalidsquadspectate(startindex, positive) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("cycleValidSquadSpectate");
  self endon("cycleValidSquadSpectate");
  players = level.squaddata[self.team][self.sessionsquadid].players;
  checkindex = startindex;
  step = ter_op(positive, 1, -1);

  for(i = 0; i < players.size; i++) {
    if(iscurrentspectatetarget(players[checkindex]) || !issquadspawnable(players[checkindex])) {
      checkindex += step;

      if(checkindex == players.size) {
        checkindex = 0;
      }

      if(checkindex == -1) {
        checkindex = players.size - 1;
      }

      continue;
    }

    thread monitorsquadspectator(players[checkindex]);
    return true;
  }

  return false;
}

function iscurrentspectatetarget(player) {
  if(!isDefined(self.forcespectatorclient)) {
    return false;
  }

  spectatingteammate = self getspectatingplayer();

  if(!isDefined(spectatingteammate)) {
    return false;
  }

  return player == spectatingteammate;
}

function issquadspawnable(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isreallyalive(player)) {
    return false;
  }

  if(istrue(player.inspawncamera)) {
    return false;
  }

  if(player isskydiving()) {
    return false;
  }

  if(player isusingremote()) {
    return false;
  }

  return true;
}

function isplayerindanger_think() {
  thread internal_isplayerindanger_think();

  if(getdvarint(@ "hash_99a922188ec4750f", 0) == 1) {
    thread scripts\mp\spawnscoring::squadspawndebug();
  }
}

function internal_isplayerindanger_think() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    if(issquadspawnable(self)) {
      self.indanger = issquadmateindanger(self);
    }

    waitframe();
  }
}

function issquadmateindanger(player) {
  currenttime = gettime();

  if(isDefined(player) && isDefined(player.pers["lastDamageTime"]) && player.pers["lastDamageTime"] + 5000 > currenttime || isDefined(player.lasttimedamaged) && player.lasttimedamaged + 5000 > currenttime) {
    return true;
  }

  if(player isonladder()) {
    return true;
  }

  player scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(player.recentattackers) && player.recentattackers.size > 0) {
    return true;
  }

  if(isDefined(player.lastweaponfiretimestart) && player.lastweaponfiretimestart + 3000 > currenttime) {
    return true;
  }

  if(isDefined(player.lastweaponfiretimestart) && isDefined(player.lastweaponfiretimeend) && player.lastweaponfiretimestart > player.lastweaponfiretimeend || isDefined(player.lastweaponfiretimestart) && !isDefined(player.lastweaponfiretimeend)) {
    return true;
  }

  var_f2e473b17ca70265 = player getclosestenemy(384, 100, 1);

  if(isDefined(var_f2e473b17ca70265)) {
    return true;
  }

  if(isDefined(player.vehicle)) {
    if(istrue(player.vehicle.burningdown)) {
      return true;
    }

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(player.vehicle))) {
      return true;
    }
  }

  if(isDefined(player) && player scripts\mp\outofbounds::istouchingoobtrigger()) {
    return true;
  }

  if(getdvarint(@ "hash_3728c11e46ec4b26", 0) == 1) {
    bucket = player getspawnbucketforplayer(1, player.origin);
    bucket = scripts\mp\spawnlogic::getspawnbucketfromstring(bucket);

    if(bucket >= 2) {
      return true;
    }
  }

  if(isDefined(player) && isDefined(player.nogroundfoundtime) && player.nogroundfoundtime + 1000 > currenttime) {
    return true;
  }

  return false;
}

function monitorsquadspectator(target) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("squad_spawn_abort");
  self notify("monitorSquadSpectator");
  self endon("monitorSquadSpectator");
  index = target.sessionuimemberindex;
  self.forcespectatorclient = target getentitynumber();
  self forcethirdpersonwhenspectating();
  thread handlesquadspawncycle();

  while(issquadspawnable(target)) {
    if(issquadmateindanger(target)) {
      self setclientomnvar("ui_squad_spawn_combat", 1);
    } else {
      self setclientomnvar("ui_squad_spawn_combat", 0);
    }

    self.squadspectatepos = target.origin + anglesToForward(target.angles) * -80 + (0, 0, 64);
    self.squadspectateang = target.angles;
    waitframe();
  }

  if(!thread cyclevalidsquadspectate(index, 1)) {
    self.squadspawnaborted = 0;
    self notify("squad_spawn_abort");
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
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_for_c130", int(level.timeuntilnextc130[self.team]));
  } else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }

  thread scripts\mp\gametypes\arm_vehicles::spawnplayertoc130();

  if(isDefined(level.spawnc130[self.team])) {
    self waittill("c130_ready");
  }
}

function needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return false;
  }

  if(!self.hasspawned) {
    return false;
  }

  wavebased = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay")) > 0;

  if(wavebased) {
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

  while(true) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

function timeuntilspawnmessaging(timeuntilspawn, reason) {
  self endon("disconnect");

  if(timeuntilspawn > 0) {
    if(!isDefined(reason)) {
      reason = "waiting_to_spawn";
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(reason, int(gettime() + timeuntilspawn * 1000));
    waittill_any_timeout_no_endon_death_1(timeuntilspawn, "force_spawn");
  }
}

function managesquadcameraposition(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageSquadCameraPosition");
  self endon("manageSquadCameraPosition");
  index = undefined;

  if(ref == "squad_leader") {
    index = level.squaddata[self.team][self.sessionsquadid].squadleader.sessionuimemberindex;
  } else {
    index = int(getsubstr(ref, ref.size - 1, ref.size));
  }

  goalplayer = undefined;

  if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.sessionsquadid]) && isDefined(level.squaddata[self.team][self.sessionsquadid].players[index])) {
    goalplayer = level.squaddata[self.team][self.sessionsquadid].players[index];
  }

  forward = level.spawnselectionteamforward[self.team];

  while(isDefined(self.spawncameraent) && isDefined(goalplayer)) {
    goalposition = [];
    goalangles = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      temp = scripts\mp\spawnselection::getstaticcameraposition(self.team);
      goalposition = temp.origin;
      goalangles = temp.angles;
    } else {
      heightoffset = 7000;

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        heightoffset = function_87bbbee0bbf27304();
      }

      goalposition = goalplayer.origin + forward * -8500 + (0, 0, heightoffset);
      goalvector = vectorNormalize(goalplayer.origin - goalposition);
      goalangles = vectortoanglessafe(goalvector, (0, 0, 1));
      goalposition += [[level.var_3c89983e2030dfff]](self.team, goalplayer.origin);
    }

    self.spawncameratargetpos = goalposition;
    self.spawncameratargetang = goalangles;
    self.spawncameraent moveTo(goalposition, 0.25, 0.05, 0.2);
    self.spawncameraent rotateTo(goalangles, 0.25, 0.05, 0.2);
    waitframe();
  }
}

function managevehiclecameraposition(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleCameraPosition");
  self endon("manageVehicleCameraPosition");
  index = int(getsubstr(ref, ref.size - 1, ref.size));
  vehicleent = level.spawnselectionlocations[ref][self.team].dynamicent;
  forward = level.spawnselectionteamforward[self.team];
  var_ff816c44d164cac1 = 0;

  while(isDefined(self.spawncameraent) && isDefined(vehicleent) && !istrue(vehicleent.isdestroyed)) {
    goalposition = [];
    goalangles = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      temp = scripts\mp\spawnselection::getstaticcameraposition(self.team);
      goalposition = temp.origin;
      goalangles = temp.angles;
    } else {
      heightoffset = 7000;

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        heightoffset = function_87bbbee0bbf27304();
      }

      goalposition = vehicleent.origin + forward * -8500 + (0, 0, heightoffset);
      groundpos = level.spawnselectionlocations[ref][self.team].anchorentity.origin;
      camerapos = groundpos + forward * -8500 + (0, 0, heightoffset);
      toground = vectorNormalize(groundpos - camerapos);
      goalangles = vectortoanglessafe(toground, (0, 0, 1));
      goalposition += [[level.var_3c89983e2030dfff]](self.team, groundpos);
    }

    self.spawncameratargetpos = goalposition;
    self.spawncameratargetang = goalangles;

    if(!isDefined(self.spawncameraendtime) || gettime() > self.spawncameraendtime) {
      self.spawncameraent moveTo(goalposition, 0.25, 0.05, 0.2);
      self.spawncameraent rotateTo(goalangles, 0.25, 0.05, 0.2);
    } else if(!var_ff816c44d164cac1) {
      var_ff816c44d164cac1 = 1;
      self.spawncameraent moveTo(goalposition, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
      self.spawncameraent rotateTo(goalangles, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
    }

    waitframe();
  }
}

function managevehiclehealthui(ref) {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("tac_ops_spawn_focus_changed");
  self notify("manageVehicleHealthUI");
  self endon("manageVehicleHealthUI");
  vehicleent = level.spawnselectionlocations[ref][self.team].dynamicent;
  self setclientomnvar("ui_tom_veh_health_percent", 0);
  waitframe();
  var_3ed7c323526c2b33 = undefined;

  while(isDefined(vehicleent)) {
    healthpercent = int(clamp(vehicleent.health / vehicleent.maxhealth * 100, 0, 100));

    if(healthpercent < 0) {
      println("<dev string:x182>");
    }

    if(!isDefined(var_3ed7c323526c2b33) || var_3ed7c323526c2b33 != healthpercent) {
      self setclientomnvar("ui_tom_veh_health_percent", int(healthpercent));
      var_3ed7c323526c2b33 = healthpercent;
    }

    waitframe();
  }
}

function getclosestavailablespawnlocation() {
  closestdistsq = undefined;
  closestref = undefined;

  if(!gameflag("prematch_done") && (getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "bigctf") || getgametype() == "risk" || !isDefined(self.hasvisitedgwspawnselection)) {
    if(self.team == "axis" || self.team == "team_three" || self.team == "team_four") {
      closestref = "gw_fob_axisHQ";
    } else {
      closestref = "gw_fob_alliesHQ";
    }

    self.hasvisitedgwspawnselection = 1;
  } else {
    var_be1261e9563d861b = 0;

    foreach(ref in level.availablespawnlocations[self.team]) {
      distsq = distancesquared(self.origin, level.spawnselectionlocations[ref][self.team].anchorentity.origin);

      if(!isDefined(distsq)) {
        continue;
      }

      if(ref == "gw_fob_" + self.team + "HQ") {
        if(distsq < 4194304) {
          closestdistsq = distsq;
          closestref = ref;
          break;
        }
      }

      if(!isDefined(closestdistsq) || distsq < closestdistsq) {
        closestdistsq = distsq;
        closestref = ref;
      }
    }

    if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[self.team][self.sessionsquadid])) {
      locations = getsquadspawnlocations(self.team, self.sessionsquadid);

      foreach(loc in locations) {
        if(loc.dynamicent == self) {
          continue;
        }

        distsq = distancesquared(self.origin, loc.dynamicent.origin);

        if(distsq < closestdistsq) {
          closestdistsq = distsq;
          closestref = loc.typeref;
        }
      }
    }
  }

  if(issubstr(closestref, "<dev string:x18a>")) {
    println("<dev string:x195>");
  }

  id = -1;

  if(isDefined(closestref)) {
    if(!issubstr(closestref, "squad") && !issubstr(closestref, "vehicle") && !issubstr(closestref, "HQ")) {
      var_ecb1ed5831deb517 = closestref + "_" + level.localeid;
      id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, var_ecb1ed5831deb517);
    }

    if(id == -1) {
      id = tablelookuprownum("mp/spawnSelectionMapData.csv", 0, closestref);
    }

    self setclientomnvar("ui_tom_previous_selection", id);
    self.forcedspawncameraref = closestref;
    return;
  }

  self setclientomnvar("ui_tom_previous_selection", -1);
  self.forcedspawncameraref = undefined;
}

function getstaticcameraposition(team) {
  assert(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()), "<dev string:x1cc>");
  var_fbc978e58d9efd71 = spawnStruct();

  if(isDefined(level.var_45abec6de5366021) && isDefined(level.var_7b73a66e2d4ca32f)) {
    var_fbc978e58d9efd71.origin = level.var_45abec6de5366021;
    var_fbc978e58d9efd71.angles = level.var_7b73a66e2d4ca32f;
    return var_fbc978e58d9efd71;
  }

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case #"hash_369d96655b32d0ca":
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (2094, -1804, 2763);
          var_fbc978e58d9efd71.angles = (54, 40, 0);
        } else {
          var_fbc978e58d9efd71.origin = (2315, 1956, 2763);
          var_fbc978e58d9efd71.angles = (54, 296, 0);
        }

        break;
      case #"hash_369d97655b32d25d":
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (5556, -1368, 2464);
          var_fbc978e58d9efd71.angles = (56, 42, 0);
        } else {
          var_fbc978e58d9efd71.origin = (5636, 1630, 2446);
          var_fbc978e58d9efd71.angles = (56, 307, 0);
        }

        break;
      default:
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        } else {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level.localeid) {
      case #"hash_369d95655b32cf37":
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (30965, 28984, 12785);
          var_fbc978e58d9efd71.angles = (53, 82, 0);
        } else {
          var_fbc978e58d9efd71.origin = (35294, 53430, 12785);
          var_fbc978e58d9efd71.angles = (50, 260, 0);
        }

        break;
      case #"hash_369d96655b32d0ca":
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (35294, 53430, 12785);
          var_fbc978e58d9efd71.angles = (50, 260, 0);
        } else {
          var_fbc978e58d9efd71.origin = (30965, 28984, 12785);
          var_fbc978e58d9efd71.angles = (53, 82, 0);
        }

        break;
      case #"hash_369d97655b32d25d":
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        } else {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        }

        break;
      case #"hash_2cd7bb8e90f46c32":
      case #"hash_2cdb2a8e90f75986":
      case #"hash_2cdb2d8e90f75e3f":
        var_fbc978e58d9efd71.origin = (6000, -46000, 19500);
        var_fbc978e58d9efd71.angles = (73, 130, 0);
        break;
      case #"hash_2ce1348e90fbe672":
      case #"hash_2ce1358e90fbe805":
        var_fbc978e58d9efd71.origin = (-33000, -23775, 12650);
        var_fbc978e58d9efd71.angles = (82, 111, 0);
        break;
      default:
        if(team == "axis") {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        } else {
          var_fbc978e58d9efd71.origin = (0, 0, 0);
          var_fbc978e58d9efd71.angles = (0, 0, 0);
        }

        break;
    }
  }

  return var_fbc978e58d9efd71;
}

function function_87bbbee0bbf27304() {
  if(getdvarint(@ "hash_9d53a38d10c6bbc5", 0) > 0) {
    return getdvarint(@ "hash_9d53a38d10c6bbc5", 0);
  }

  if(!isDefined(level.localeid)) {
    return 7000;
  }

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case #"hash_369d96655b32d0ca":
        return 7000;
      case #"hash_369d97655b32d25d":
        return 7000;
      case #"hash_369d88655b32bac0":
        return 7000;
      case #"hash_369d89655b32bc53":
        return 7000;
      case #"hash_2cd7bf8e90f4727e":
        return 12000;
      default:
        return 7000;
    }

    return;
  }

  switch (level.localeid) {
    case #"hash_369d95655b32cf37":
      return 7000;
    case #"hash_369d96655b32d0ca":
      return 8000;
    case #"hash_369d97655b32d25d":
      return 8000;
    case #"hash_369d88655b32bac0":
      return 8000;
    case #"hash_369d89655b32bc53":
      return 8000;
    case #"hash_2cd4bf8e90f233e7":
      return 7000;
    case #"hash_2cd4be8e90f23254":
      return 5000;
    case #"hash_2cd7bf8e90f4727e":
      return 12000;
    default:
      return 7000;
  }
}

function updatefobindanger() {
  if(!istrue(level.usespawnselection)) {
    return;
  }

  level thread updatefobspawnsindanger();

  while(true) {
    foreach(team in level.teamnamelist) {
      foreach(entry in level.availablespawnlocations[team]) {
        selected = level.spawnselectionlocations[entry][team];

        if(isDefined(selected) && isDefined(selected.objectivekey)) {
          selected.indanger = isobjectiveindanger(selected.objectivekey, team);
        }
      }
    }

    waitframe();
  }
}

function updatefobspawnsindanger() {
  while(true) {
    foreach(team in level.teamnamelist) {
      testplayer = getteamdata(team, "players")[0];

      foreach(location in level.availablespawnlocations[team]) {
        if(!issubstr(location, "HQ") && issubstr(location, "fob")) {
          canuseprimary = 1;
          canusefallback = isDefined(level.spawnglobals.spawnsets[location + "_safe_" + team]);
          primaryset = location + "_" + team;
          fallbackset = undefined;

          if(canusefallback) {
            fallbackset = location + "_safe_" + team;
          }

          if(isDefined(level.spawninfluencezones)) {
            trigger = undefined;
            keys = getarraykeys(level.spawninfluencezones);

            foreach(key in keys) {
              if(key == location) {
                trigger = level.spawninfluencezones[key];
                break;
              }
            }

            if(isDefined(trigger) && trigger isteamtouching(getotherteam(team)[0])) {
              canuseprimary = 0;
            }
          }

          indanger = 0;

          if(isDefined(testplayer)) {
            var_1e77bb9e18bf61a7 = undefined;
            var_55807291c518deed = undefined;

            if(canuseprimary) {
              scripts\mp\spawnlogic::activatespawnset(primaryset, 1);
              var_1e77bb9e18bf61a7 = testplayer getspawnbucketforplayer();
              var_1e77bb9e18bf61a7 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_1e77bb9e18bf61a7);
            }

            if(canusefallback) {
              scripts\mp\spawnlogic::activatespawnset(fallbackset, 1);
              var_55807291c518deed = testplayer getspawnbucketforplayer();
              var_55807291c518deed = scripts\mp\spawnlogic::getspawnbucketfromstring(var_55807291c518deed);
            }

            if(canuseprimary && canusefallback) {
              indanger = var_1e77bb9e18bf61a7 >= 2 && var_55807291c518deed >= 2;
            } else if(canuseprimary && !canusefallback) {
              indanger = var_1e77bb9e18bf61a7 >= 2;
            } else if(canusefallback) {
              indanger = var_55807291c518deed >= 2;
            }
          }

          objectivekey = level.spawnselectionlocations[location][team].objectivekey;
          level.objectives[objectivekey].spawnpointdanger = indanger;
          level.objectives[objectivekey].spawnpointdangertime = gettime();
        }
      }
    }

    wait 1;
  }
}

function updatespecificfobindanger(location, player, team) {
  objectivekey = level.spawnselectionlocations[location][team].objectivekey;

  if(!isDefined(objectivekey) || !isDefined(level.objectives[objectivekey]) || !isDefined(level.objectives[objectivekey].spawnpointdangertime) || level.objectives[objectivekey].spawnpointdangertime == gettime()) {
    return;
  }

  canuseprimary = 1;
  canusefallback = isDefined(level.spawnglobals.spawnsets[location + "_safe_" + team]);
  primaryset = location + "_" + team;
  fallbackset = undefined;

  if(canusefallback) {
    fallbackset = location + "_safe_" + team;
  }

  if(isDefined(level.spawninfluencezones)) {
    trigger = undefined;
    keys = getarraykeys(level.spawninfluencezones);

    foreach(key in keys) {
      if(key == location) {
        trigger = level.spawninfluencezones[key];
        break;
      }
    }

    if(isDefined(trigger) && isDefined(trigger.numplayers) && trigger.numplayers[getotherteam(team)[0]] > 0) {
      canuseprimary = 0;
    }
  }

  indanger = 0;

  if(isDefined(player)) {
    var_1e77bb9e18bf61a7 = undefined;
    var_55807291c518deed = undefined;

    if(canuseprimary) {
      scripts\mp\spawnlogic::activatespawnset(primaryset, 1);
      var_1e77bb9e18bf61a7 = player getspawnbucketforplayer();
      var_1e77bb9e18bf61a7 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_1e77bb9e18bf61a7);
    }

    if(canusefallback) {
      scripts\mp\spawnlogic::activatespawnset(fallbackset, 1);
      var_55807291c518deed = player getspawnbucketforplayer();
      var_55807291c518deed = scripts\mp\spawnlogic::getspawnbucketfromstring(var_55807291c518deed);
    }

    if(canuseprimary && canusefallback) {
      indanger = var_1e77bb9e18bf61a7 >= 2 && var_55807291c518deed >= 2;
    } else if(canuseprimary && !canusefallback) {
      indanger = var_1e77bb9e18bf61a7 >= 2;
    } else if(canusefallback) {
      indanger = var_55807291c518deed >= 2;
    }
  }

  level.objectives[objectivekey].spawnpointdanger = indanger;
  level.objectives[objectivekey].spawnpointdangertime = gettime();
}

function vehicle_showteamtanks() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tank in level.trackedtanks[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(tank.spawnselectionmarker.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(tank in level.trackedtanks["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
  }

  foreach(tank in level.trackedtanks["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
  }
}

function function_f83711dd7546db96() {
  if(!isDefined(level.gw_objstruct) || !isDefined(level.gw_objstruct.allieshqloc) || !isDefined(level.gw_objstruct.allieshqloc.marker)) {
    return;
  }

  if(self.team == "allies") {
    if(level.var_a50b22fa98674a50) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    }

    if(level.var_f15becfbc1b01a1b) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    }

    return;
  }

  if(level.var_a50b22fa98674a50) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.marker.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);
  }

  if(level.var_f15becfbc1b01a1b) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
}

function function_dc659688380c4195() {
  if(!isDefined(level.gw_objstruct) || !isDefined(level.gw_objstruct.allieshqloc) || !isDefined(level.gw_objstruct.allieshqloc.marker)) {
    return;
  }

  if(self.team == "allies") {
    if(level.var_757ec02df4d678f5) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    }

    if(level.var_6f40c2b6970373c0) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.enemymarker.objidnum, self);
    }

    return;
  }

  if(level.var_757ec02df4d678f5) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.marker.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);
  }

  if(level.var_6f40c2b6970373c0) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.enemymarker.objidnum, self);
}