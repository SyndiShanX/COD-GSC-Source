/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreakrules.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\popups_shared;
#using scripts\shared\util_shared;
#namespace killstreakrules;

function init() {
  level.killstreakrules = [];
  level.killstreaktype = [];
  level.killstreaks_triggered = [];
  level.matchrecorderkillstreakkills = [];
  if(!isDefined(level.globalkillstreakscalled)) {
    level.globalkillstreakscalled = 0;
  }
  createrule("ai_tank", 4, 2);
  createrule("airsupport", 1, 1);
  createrule("combatrobot", 4, 2);
  createrule("chopper", 2, 1);
  createrule("chopperInTheAir", 2, 1);
  createrule("counteruav", 6, 3);
  createrule("dart", 4, 2);
  createrule("dogs", 1, 1);
  createrule("drone_strike", 1, 1);
  createrule("emp", 2, 1);
  createrule("firesupport", 1, 1);
  createrule("missiledrone", 3, 3);
  createrule("missileswarm", 1, 1);
  createrule("planemortar", 1, 1);
  createrule("playercontrolledchopper", 1, 1);
  createrule("qrdrone", 3, 2);
  createrule("uav", 10, 5);
  createrule("raps", 2, 1);
  createrule("rcxd", 4, 2);
  createrule("remote_missile", 2, 1);
  createrule("remotemortar", 1, 1);
  createrule("satellite", 2, 1);
  createrule("sentinel", 4, 2);
  createrule("straferun", 1, 1);
  createrule("supplydrop", 4, 4);
  createrule("targetableent", 32, 32);
  createrule("turret", 8, 4);
  createrule("vehicle", 7, 7);
  createrule("weapon", 12, 6);
  addkillstreaktorule("ai_tank_drop", "ai_tank", 1, 1);
  addkillstreaktorule("airstrike", "airsupport", 1, 1);
  addkillstreaktorule("airstrike", "vehicle", 1, 1);
  addkillstreaktorule("artillery", "firesupport", 1, 1);
  addkillstreaktorule("auto_tow", "turret", 1, 1);
  addkillstreaktorule("autoturret", "turret", 1, 1);
  addkillstreaktorule("combat_robot", "combatrobot", 1, 1);
  addkillstreaktorule("counteruav", "counteruav", 1, 1);
  addkillstreaktorule("counteruav", "targetableent", 1, 1);
  addkillstreaktorule("dart", "dart", 1, 1);
  addkillstreaktorule("dogs", "dogs", 1, 1);
  addkillstreaktorule("dogs_lvl2", "dogs", 1, 1);
  addkillstreaktorule("dogs_lvl3", "dogs", 1, 1);
  addkillstreaktorule("drone_strike", "drone_strike", 1, 1);
  addkillstreaktorule("emp", "emp", 1, 1);
  addkillstreaktorule("helicopter", "chopper", 1, 1);
  addkillstreaktorule("helicopter", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter", "targetableent", 1, 1);
  addkillstreaktorule("helicopter", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_comlink", "chopper", 1, 1);
  addkillstreaktorule("helicopter_comlink", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_comlink", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_comlink", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_guard", "airsupport", 1, 1);
  addkillstreaktorule("helicopter_gunner", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_gunner", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_gunner", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_gunner", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_gunner_assistant", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_gunner_assistant", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_gunner_assistant", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_gunner_assistant", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "chopperInTheAir", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_player_gunner", "chopperInTheAir", 1, 1);
  addkillstreaktorule("helicopter_player_gunner", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_player_gunner", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_player_gunner", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_x2", "chopper", 1, 1);
  addkillstreaktorule("helicopter_x2", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_x2", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter_x2", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_x2", "vehicle", 1, 1);
  addkillstreaktorule("m202_flash", "weapon", 1, 1);
  addkillstreaktorule("m220_tow", "weapon", 1, 1);
  addkillstreaktorule("m220_tow_drop", "supplydrop", 1, 1);
  addkillstreaktorule("m220_tow_drop", "vehicle", 1, 1);
  addkillstreaktorule("m220_tow_killstreak", "weapon", 1, 1);
  addkillstreaktorule("m32", "weapon", 1, 1);
  addkillstreaktorule("m32_drop", "weapon", 1, 1);
  addkillstreaktorule("microwave_turret", "turret", 1, 1);
  addkillstreaktorule("minigun", "weapon", 1, 1);
  addkillstreaktorule("minigun_drop", "weapon", 1, 1);
  addkillstreaktorule("missile_drone", "missiledrone", 1, 1);
  addkillstreaktorule("missile_swarm", "missileswarm", 1, 1);
  addkillstreaktorule("mortar", "firesupport", 1, 1);
  addkillstreaktorule("mp40_drop", "weapon", 1, 1);
  addkillstreaktorule("napalm", "airsupport", 1, 1);
  addkillstreaktorule("napalm", "vehicle", 1, 1);
  addkillstreaktorule("planemortar", "planemortar", 1, 1);
  addkillstreaktorule("qrdrone", "qrdrone", 1, 1);
  addkillstreaktorule("qrdrone", "vehicle", 1, 1);
  addkillstreaktorule("uav", "uav", 1, 1);
  addkillstreaktorule("uav", "targetableent", 1, 1);
  addkillstreaktorule("satellite", "satellite", 1, 1);
  addkillstreaktorule("raps", "raps", 1, 1);
  addkillstreaktorule("rcbomb", "rcxd", 1, 1);
  addkillstreaktorule("remote_missile", "targetableent", 1, 1);
  addkillstreaktorule("remote_missile", "remote_missile", 1, 1);
  addkillstreaktorule("remote_mortar", "remotemortar", 1, 1);
  addkillstreaktorule("remote_mortar", "targetableent", 1, 1);
  addkillstreaktorule("sentinel", "sentinel", 1, 1);
  addkillstreaktorule("straferun", "straferun", 1, 1);
  addkillstreaktorule("supply_drop", "supplydrop", 1, 1);
  addkillstreaktorule("supply_drop", "targetableent", 1, 1);
  addkillstreaktorule("supply_drop", "vehicle", 1, 1);
  addkillstreaktorule("supply_station", "supplydrop", 1, 1);
  addkillstreaktorule("supply_station", "targetableent", 1, 1);
  addkillstreaktorule("supply_station", "vehicle", 1, 1);
  addkillstreaktorule("tow_turret_drop", "supplydrop", 1, 1);
  addkillstreaktorule("tow_turret_drop", "vehicle", 1, 1);
  addkillstreaktorule("turret_drop", "supplydrop", 1, 1);
  addkillstreaktorule("turret_drop", "vehicle", 1, 1);
}

function createrule(rule, maxallowable, maxallowableperteam) {
  level.killstreakrules[rule] = spawnStruct();
  level.killstreakrules[rule].cur = 0;
  level.killstreakrules[rule].curteam = [];
  level.killstreakrules[rule].max = maxallowable;
  level.killstreakrules[rule].maxperteam = maxallowableperteam;
}

function addkillstreaktorule(killstreak, rule, counttowards, checkagainst, inventoryvariant) {
  if(!isDefined(level.killstreaktype[killstreak])) {
    level.killstreaktype[killstreak] = [];
  }
  keys = getarraykeys(level.killstreaktype[killstreak]);
  assert(isDefined(level.killstreakrules[rule]));
  if(!isDefined(level.killstreaktype[killstreak][rule])) {
    level.killstreaktype[killstreak][rule] = spawnStruct();
  }
  level.killstreaktype[killstreak][rule].counts = counttowards;
  level.killstreaktype[killstreak][rule].checks = checkagainst;
  if(!(isDefined(inventoryvariant) && inventoryvariant)) {
    addkillstreaktorule("inventory_" + killstreak, rule, counttowards, checkagainst, 1);
  }
}

function killstreakstart(hardpointtype, team, hacked, displayteammessage) {
  /
  #
  assert(isDefined(team), "");
  if(self iskillstreakallowed(hardpointtype, team) == 0) {
    return -1;
  }
  assert(isDefined(hardpointtype));
  if(!isDefined(hacked)) {
    hacked = 0;
  }
  if(!isDefined(displayteammessage)) {
    displayteammessage = 1;
  }
  if(getdvarint("teamOpsEnabled") == 1) {
    displayteammessage = 0;
  }
  if(displayteammessage == 1) {
    if(!hacked) {
      self displaykillstreakstartteammessagetoall(hardpointtype);
    }
  }
  keys = getarraykeys(level.killstreaktype[hardpointtype]);
  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }
    assert(isDefined(level.killstreakrules[key]));
    level.killstreakrules[key].cur++;
    if(level.teambased) {
      if(!isDefined(level.killstreakrules[key].curteam[team])) {
        level.killstreakrules[key].curteam[team] = 0;
      }
      level.killstreakrules[key].curteam[team]++;
    }
  }
  level notify("killstreak_started", hardpointtype, team, self);
  killstreak_id = level.globalkillstreakscalled;
  level.globalkillstreakscalled++;
  killstreak_data = [];
  killstreak_data["caller"] = self getxuid();
  killstreak_data["spawnid"] = getplayerspawnid(self);
  killstreak_data["starttime"] = gettime();
  killstreak_data["type"] = hardpointtype;
  killstreak_data["endtime"] = 0;
  level.matchrecorderkillstreakkills[killstreak_id] = 0;
  level.killstreaks_triggered[killstreak_id] = killstreak_data;
  killstreak_debug_text((((("" + hardpointtype) + "") + team) + "") + killstreak_id);
  return killstreak_id;
}

function displaykillstreakstartteammessagetoall(hardpointtype) {
  if(getdvarint("teamOpsEnabled") == 1) {
    return;
  }
  if(isDefined(level.killstreaks[hardpointtype]) && isDefined(level.killstreaks[hardpointtype].inboundtext)) {
    level thread popups::displaykillstreakteammessagetoall(hardpointtype, self);
  }
}

function recordkillstreakenddirect(eventindex, recordstreakindex, totalkills) {
  player = self;
  player recordkillstreakendevent(eventindex, recordstreakindex, totalkills);
  player.killstreakevents[recordstreakindex] = undefined;
}

function recordkillstreakend(recordstreakindex, totalkills) {
  player = self;
  if(!isPlayer(player)) {
    return;
  }
  if(!isDefined(totalkills)) {
    totalkills = 0;
  }
  if(!isDefined(player.killstreakevents)) {
    player.killstreakevents = associativearray();
  }
  eventindex = player.killstreakevents[recordstreakindex];
  if(isDefined(eventindex)) {
    player recordkillstreakenddirect(eventindex, recordstreakindex, totalkills);
  } else {
    player.killstreakevents[recordstreakindex] = totalkills;
  }
}

function killstreakstop(hardpointtype, team, id) {
  /
  #
  assert(isDefined(team), "");
  assert(isDefined(hardpointtype));
  idstr = "";
  if(isDefined(id)) {
    idstr = id;
  }
  killstreak_debug_text((((("" + hardpointtype) + "") + team) + "") + idstr);
  keys = getarraykeys(level.killstreaktype[hardpointtype]);
  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }
    assert(isDefined(level.killstreakrules[key]));
    level.killstreakrules[key].cur--;
    assert(level.killstreakrules[key].cur >= 0);
    if(level.teambased) {
      assert(isDefined(team));
      assert(isDefined(level.killstreakrules[key].curteam[team]));
      level.killstreakrules[key].curteam[team]--;
      assert(level.killstreakrules[key].curteam[team] >= 0);
    }
  }
  if(!isDefined(id) || id == -1) {
    killstreak_debug_text("WARNING! Invalid killstreak id detected for " + hardpointtype);
    bbprint("mpkillstreakuses", "starttime %d endtime %d name %s team %s", 0, gettime(), hardpointtype, team);
    return;
  }
  level.killstreaks_triggered[id]["endtime"] = gettime();
  totalkillswiththiskillstreak = level.matchrecorderkillstreakkills[id];
  bbprint("mpkillstreakuses", "starttime %d endtime %d spawnid %d name %s team %s", level.killstreaks_triggered[id]["starttime"], level.killstreaks_triggered[id]["endtime"], level.killstreaks_triggered[id]["spawnid"], hardpointtype, team);
  level.killstreaks_triggered[id] = undefined;
  level.matchrecorderkillstreakkills[id] = undefined;
  if(isDefined(level.killstreaks[hardpointtype].menuname)) {
    recordstreakindex = level.killstreakindices[level.killstreaks[hardpointtype].menuname];
    if(isDefined(self) && isDefined(recordstreakindex) && (!isDefined(self.activatingkillstreak) || !self.activatingkillstreak)) {
      entity = self;
      if(isDefined(entity.owner)) {
        entity = entity.owner;
      }
      entity recordkillstreakend(recordstreakindex, totalkillswiththiskillstreak);
    }
  }
}

function iskillstreakallowed(hardpointtype, team) {
  /
  #
  assert(isDefined(team), "");
  assert(isDefined(hardpointtype));
  if(self killstreaks::is_killstreak_start_blocked()) {
    return 0;
  }
  isallowed = 1;
  keys = getarraykeys(level.killstreaktype[hardpointtype]);
  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].checks) {
      continue;
    }
    if(level.killstreakrules[key].max != 0) {
      if(level.killstreakrules[key].cur >= level.killstreakrules[key].max) {
        killstreak_debug_text(("" + key) + "");
        isallowed = 0;
        break;
      }
    }
    if(level.teambased && level.killstreakrules[key].maxperteam != 0) {
      if(!isDefined(level.killstreakrules[key].curteam[team])) {
        level.killstreakrules[key].curteam[team] = 0;
      }
      if(level.killstreakrules[key].curteam[team] >= level.killstreakrules[key].maxperteam) {
        isallowed = 0;
        killstreak_debug_text(("" + key) + "");
        break;
      }
    }
  }
  if(isDefined(self.laststand) && self.laststand) {
    killstreak_debug_text("");
    isallowed = 0;
  }
  isemped = 0;
  if(self isempjammed()) {
    killstreak_debug_text("");
    isallowed = 0;
    isemped = 1;
    if(self emp::enemyempactive()) {
      if(isDefined(level.empendtime)) {
        secondsleft = int((level.empendtime - gettime()) / 1000);
        if(secondsleft > 0) {
          self iprintlnbold(&"KILLSTREAK_NOT_AVAILABLE_EMP_ACTIVE", secondsleft);
          return 0;
        }
      }
    }
  }
  if(isallowed == 0) {
    if(isDefined(level.killstreaks[hardpointtype]) && isDefined(level.killstreaks[hardpointtype].notavailabletext)) {
      self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
      if(!isDefined(self.currentkillstreakdialog) && level.killstreaks[hardpointtype].utilizesairspace && isemped == 0) {
        self globallogic_audio::play_taacom_dialog("airspaceFull");
      }
    }
  }
  return isallowed;
}

function killstreak_debug_text(text) {
  level.killstreak_rule_debug = getdvarint("", 0);
  if(isDefined(level.killstreak_rule_debug)) {
    if(level.killstreak_rule_debug == 1) {
      iprintln(("" + text) + "");
    } else if(level.killstreak_rule_debug == 2) {
      iprintlnbold("" + text);
    }
  }
}