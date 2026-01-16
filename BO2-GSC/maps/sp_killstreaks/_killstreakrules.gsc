/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\sp_killstreaks\_killstreakrules.gsc
****************************************************/

#include maps\_utility;
#include maps\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killstreakrules = [];
  level.killstreaktype = [];
  createrule("vehicle", 7, 7);
  createrule("firesupport", 1, 1);
  createrule("airsupport", 1, 1);
  createrule("playercontrolledchopper", 1, 1);
  createrule("chopperInTheAir", 1, 1);
  createrule("chopper", 2, 1);
  createrule("dog", 1, 1);
  createrule("turret", 7, 7);
  createrule("weapon", 3, 3);
  createrule("satellite", 2, 1);
  createrule("supplydrop", 3, 3);
  createrule("rcxd", 3, 2);
  createrule("targetableent", 32, 32);
  addkillstreaktorule("helicopter_sp", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_sp", "chopper", 1, 1);
  addkillstreaktorule("helicopter_sp", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter_sp", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_sp", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_x2_sp", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_x2_sp", "chopper", 1, 1);
  addkillstreaktorule("helicopter_x2_sp", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter_x2_sp", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_x2_sp", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_comlink_sp", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_comlink_sp", "chopper", 1, 1);
  addkillstreaktorule("helicopter_comlink_sp", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter_comlink_sp", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_comlink_sp", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson_sp", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson_sp", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson_sp", "chopperInTheAir", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson_sp", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_gunner_sp", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_gunner_sp", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_gunner_sp", "chopperInTheAir", 1, 1);
  addkillstreaktorule("helicopter_gunner_sp", "targetableent", 1, 1);
  addkillstreaktorule("rcbomb_sp", "rcxd", 1, 1);
  addkillstreaktorule("supply_drop_sp", "vehicle", 1, 1);
  addkillstreaktorule("supply_drop_sp", "supplydrop", 1, 1);
  addkillstreaktorule("supply_drop_sp", "targetableent", 1, 1);
  addkillstreaktorule("supply_station_sp", "vehicle", 1, 1);
  addkillstreaktorule("supply_station_sp", "supplydrop", 1, 1);
  addkillstreaktorule("supply_station_sp", "targetableent", 1, 1);
  addkillstreaktorule("tow_turret_drop_sp", "vehicle", 1, 1);
  addkillstreaktorule("turret_drop_sp", "vehicle", 1, 1);
  addkillstreaktorule("m220_tow_drop_sp", "vehicle", 1, 1);
  addkillstreaktorule("tow_turret_drop_sp", "supplydrop", 1, 1);
  addkillstreaktorule("turret_drop_sp", "supplydrop", 1, 1);
  addkillstreaktorule("m220_tow_drop_sp", "supplydrop", 1, 1);
  addkillstreaktorule("m220_tow_killstreak_sp", "weapon", 1, 1);
  addkillstreaktorule("autoturret_sp", "turret", 1, 1);
  addkillstreaktorule("auto_tow_sp", "turret", 1, 1);
  addkillstreaktorule("minigun_sp", "weapon", 1, 1);
  addkillstreaktorule("m202_flash_sp", "weapon", 1, 1);
  addkillstreaktorule("m220_tow_sp", "weapon", 1, 1);
  addkillstreaktorule("mp40_drop_sp", "weapon", 1, 1);
  addkillstreaktorule("dogs_sp", "dog", 1, 1);
  addkillstreaktorule("artillery_sp", "firesupport", 1, 1);
  addkillstreaktorule("mortar_sp", "firesupport", 1, 1);
  addkillstreaktorule("napalm_sp", "vehicle", 1, 1);
  addkillstreaktorule("napalm_sp", "airsupport", 1, 1);
  addkillstreaktorule("airstrike_sp", "vehicle", 1, 1);
  addkillstreaktorule("airstrike_sp", "airsupport", 1, 1);
  addkillstreaktorule("radardirection_sp", "satellite", 1, 1);
  addkillstreaktorule("radar_sp", "targetableent", 1, 1);
  addkillstreaktorule("counteruav_sp", "targetableent", 1, 1);
  addkillstreaktorule("remote_missile_sp", "targetableent", 1, 1);
  addkillstreaktorule("talon_sp", "turret", 1, 1);
}

createrule(rule, maxallowable, maxallowableperteam) {
  level.killstreakrules[rule] = spawnstruct();
  level.killstreakrules[rule].cur = 0;
  level.killstreakrules[rule].curteam = [];
  level.killstreakrules[rule].max = maxallowable;
  level.killstreakrules[rule].maxperteam = maxallowableperteam;
}

addkillstreaktorule(hardpointtype, rule, counttowards, checkagainst) {
  if(!isDefined(level.killstreaktype[hardpointtype]))
    level.killstreaktype[hardpointtype] = [];

  keys = getarraykeys(level.killstreaktype[hardpointtype]);
  assert(isDefined(level.killstreakrules[rule]));

  if(!isDefined(level.killstreaktype[hardpointtype][rule]))
    level.killstreaktype[hardpointtype][rule] = spawnstruct();

  level.killstreaktype[hardpointtype][rule].counts = counttowards;
  level.killstreaktype[hardpointtype][rule].checks = checkagainst;
}

killstreakstart(hardpointtype, team, hacked, displayteammessage) {
  assert(isDefined(team), "team needs to be defined");

  if(self iskillstreakallowed(hardpointtype, team) == 0)
    return false;

  assert(isDefined(hardpointtype));

  killstreak_debug_text("Started killstreak: " + hardpointtype);

  if(!isDefined(hacked))
    hacked = 0;

  if(!isDefined(displayteammessage))
    displayteammessage = 1;

  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointtype][keys[i]].counts) {
      continue;
    }
    assert(isDefined(level.killstreakrules[keys[i]]));
    level.killstreakrules[keys[i]].cur++;
  }

  return true;
}

killstreakstop(hardpointtype, team) {
  assert(isDefined(team), "team needs to be defined");
  assert(isDefined(hardpointtype));

  killstreak_debug_text("Stopped killstreak: " + hardpointtype);

  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointtype][keys[i]].counts) {
      continue;
    }
    assert(isDefined(level.killstreakrules[keys[i]]));
    level.killstreakrules[keys[i]].cur--;
    assert(level.killstreakrules[keys[i]].cur >= 0);
  }
}

iskillstreakallowed(hardpointtype, team) {
  assert(isDefined(team), "team needs to be defined");
  assert(isDefined(hardpointtype));
  isallowed = 1;
  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointtype][keys[i]].checks) {
      continue;
    }
    if(level.killstreakrules[keys[i]].max != 0) {
      if(level.killstreakrules[keys[i]].cur >= level.killstreakrules[keys[i]].max)
        isallowed = 0;
    }
  }

  if(isDefined(self.laststand) && self.laststand)
    isallowed = 0;

  if(isallowed == 0) {
    if(isDefined(level.killstreaks[hardpointtype]) && isDefined(level.killstreaks[hardpointtype].notavailabletext))
      self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
  }

  return isallowed;
}

killstreak_debug_text(text) {
  level.killstreak_rule_debug = getdvarintdefault("scr_killstreak_rule_debug", 0);

  if(isDefined(level.killstreak_rule_debug)) {
    if(level.killstreak_rule_debug == 1.0)
      iprintln(text);
    else if(level.killstreak_rule_debug == 2.0)
      iprintlnbold(text);
  }

}