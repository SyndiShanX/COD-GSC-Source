/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_killstreakrules.gsc
****************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killstreakrules = [];
  level.killstreaktype = [];
  createRule("vehicle", 7, 7);
  createRule("firesupport", 1, 1);
  createRule("airsupport", 1, 1);
  createRule("playercontrolledchopper", 1, 1);
  createRule("chopperInTheAir", 1, 1);
  createRule("chopper", 2, 1);
  createRule("dog", 1, 1);
  createRule("turret", 7, 7);
  createRule("weapon", 3, 3);
  createRule("satellite", 2, 1);
  createRule("supplydrop", 3, 3);
  createRule("rcxd", 3, 2);
  createRule("targetableent", 32, 32);
  addKillstreakToRule("helicopter_mp", "vehicle", true, true);
  addKillstreakToRule("helicopter_mp", "chopper", true, true);
  addKillstreakToRule("helicopter_mp", "playercontrolledchopper", false, true);
  addKillstreakToRule("helicopter_mp", "chopperInTheAir", true, false);
  addKillstreakToRule("helicopter_mp", "targetableent", true, true);
  addKillstreakToRule("helicopter_x2_mp", "vehicle", true, true);
  addKillstreakToRule("helicopter_x2_mp", "chopper", true, true);
  addKillstreakToRule("helicopter_x2_mp", "playercontrolledchopper", false, true);
  addKillstreakToRule("helicopter_x2_mp", "chopperInTheAir", true, false);
  addKillstreakToRule("helicopter_x2_mp", "targetableent", true, true);
  addKillstreakToRule("helicopter_comlink_mp", "vehicle", true, true);
  addKillstreakToRule("helicopter_comlink_mp", "chopper", true, true);
  addKillstreakToRule("helicopter_comlink_mp", "playercontrolledchopper", false, true);
  addKillstreakToRule("helicopter_comlink_mp", "chopperInTheAir", true, false);
  addKillstreakToRule("helicopter_comlink_mp", "targetableent", true, true);
  addKillstreakToRule("helicopter_player_firstperson_mp", "vehicle", true, true);
  addKillstreakToRule("helicopter_player_firstperson_mp", "playercontrolledchopper", true, true);
  addKillstreakToRule("helicopter_player_firstperson_mp", "chopperInTheAir", true, true);
  addKillstreakToRule("helicopter_player_firstperson_mp", "targetableent", true, true);
  addKillstreakToRule("helicopter_gunner_mp", "vehicle", true, true);
  addKillstreakToRule("helicopter_gunner_mp", "playercontrolledchopper", true, true);
  addKillstreakToRule("helicopter_gunner_mp", "chopperInTheAir", true, true);
  addKillstreakToRule("helicopter_gunner_mp", "targetableent", true, true);
  addKillstreakToRule("rcbomb_mp", "rcxd", true, true);
  addKillstreakToRule("supply_drop_mp", "vehicle", true, true);
  addKillstreakToRule("supply_drop_mp", "supplydrop", true, true);
  addKillstreakToRule("supply_drop_mp", "targetableent", true, true);
  addKillstreakToRule("supply_station_mp", "vehicle", true, true);
  addKillstreakToRule("supply_station_mp", "supplydrop", true, true);
  addKillstreakToRule("supply_station_mp", "targetableent", true, true);
  addKillstreakToRule("tow_turret_drop_mp", "vehicle", true, true);
  addKillstreakToRule("turret_drop_mp", "vehicle", true, true);
  addKillstreakToRule("m220_tow_drop_mp", "vehicle", true, true);
  addKillstreakToRule("tow_turret_drop_mp", "supplydrop", true, true);
  addKillstreakToRule("turret_drop_mp", "supplydrop", true, true);
  addKillstreakToRule("m220_tow_drop_mp", "supplydrop", true, true);
  addKillstreakToRule("m220_tow_killstreak_mp", "weapon", true, true);
  addKillstreakToRule("autoturret_mp", "turret", true, true);
  addKillstreakToRule("auto_tow_mp", "turret", true, true);
  addKillstreakToRule("minigun_mp", "weapon", true, true);
  addKillstreakToRule("m202_flash_mp", "weapon", true, true);
  addKillstreakToRule("m220_tow_mp", "weapon", true, true);
  addKillstreakToRule("mp40_drop_mp", "weapon", true, true);
  addKillstreakToRule("dogs_mp", "dog", true, true);
  addKillstreakToRule("artillery_mp", "firesupport", true, true);
  addKillstreakToRule("mortar_mp", "firesupport", true, true);
  addKillstreakToRule("napalm_mp", "vehicle", true, true);
  addKillstreakToRule("napalm_mp", "airsupport", true, true);
  addKillstreakToRule("airstrike_mp", "vehicle", true, true);
  addKillstreakToRule("airstrike_mp", "airsupport", true, true);
  addKillstreakToRule("radardirection_mp", "satellite", true, true);
  addKillstreakToRule("radar_mp", "targetableent", true, true);
  addKillstreakToRule("counteruav_mp", "targetableent", true, true);
}
createRule(rule, maxAllowable, maxAllowablePerTeam) {
  if(!level.teambased) {
    if(maxAllowable > maxAllowablePerTeam) {
      maxAllowable = maxAllowablePerTeam;
    }
  }
  level.killstreakrules[rule] = spawnStruct();
  level.killstreakrules[rule].cur = 0;
  level.killstreakrules[rule].curTeam = [];
  level.killstreakrules[rule].max = maxAllowable;
  level.killstreakrules[rule].maxPerTeam = maxAllowablePerTeam;
}
addKillstreakToRule(hardpointType, rule, countTowards, checkAgainst) {
  if(!isDefined(level.killstreaktype[hardpointType]))
    level.killstreaktype[hardpointType] = [];
  keys = GetArrayKeys(level.killstreaktype[hardpointType]);
  assert(isDefined(level.killstreakrules[rule]));
  if(!isDefined(level.killstreaktype[hardpointType][rule]))
    level.killstreaktype[hardpointType][rule] = spawnStruct();
  level.killstreaktype[hardpointType][rule].counts = countTowards;
  level.killstreaktype[hardpointType][rule].checks = checkAgainst;
}
killstreakStart(hardpointType, team, hacked, displayTeamMessage) {
  if(self isKillstreakAllowed(hardpointType, team) == false)
    return false;
  assert(isDefined(hardpointType));
  if(!isDefined(hacked))
    hacked = false;
  if(!isDefined(displayTeamMessage))
    displayTeamMessage = true;
  if(displayTeamMessage == true) {
    if(isDefined(level.killstreaks[hardpointType]) && isDefined(level.killstreaks[hardpointType].inboundtext) && !hacked)
      level thread maps\mp\_popups::DisplayKillstreakTeamMessageToAll(hardpointType, self);
  }
  keys = GetArrayKeys(level.killstreaktype[hardpointType]);
  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointType][keys[i]].counts)
      continue;
    assert(isDefined(level.killstreakrules[keys[i]]));
    level.killstreakrules[keys[i]].cur++;
    if(level.teambased) {
      if(!isDefined(level.killstreakrules[keys[i]].curTeam[team]))
        level.killstreakrules[keys[i]].curTeam[team] = 0;
      level.killstreakrules[keys[i]].curTeam[team]++;
    }
  }
  return true;
}
killstreakStop(hardpointType, team) {
  assert(isDefined(hardpointType));
  keys = GetArrayKeys(level.killstreaktype[hardpointType]);
  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointType][keys[i]].counts)
      continue;
    assert(isDefined(level.killstreakrules[keys[i]]));
    level.killstreakrules[keys[i]].cur--;
    assert(level.killstreakrules[keys[i]].cur >= 0);
    if(level.teambased) {
      assert(isDefined(team));
      assert(isDefined(level.killstreakrules[keys[i]].curTeam[team]));
      level.killstreakrules[keys[i]].curTeam[team]--;
      assert(level.killstreakrules[keys[i]].curTeam[team] >= 0);
    }
  }
}
isKillstreakAllowed(hardpointType, team) {
  assert(isDefined(hardpointType));
  isAllowed = true;
  keys = GetArrayKeys(level.killstreaktype[hardpointType]);
  for(i = 0; i < keys.size; i++) {
    if(!level.killstreaktype[hardpointType][keys[i]].checks)
      continue;
    if(level.killstreakrules[keys[i]].max != 0) {
      if(level.killstreakrules[keys[i]].cur >= level.killstreakrules[keys[i]].max)
        isAllowed = false;
    }
    if(level.teambased && level.killstreakrules[keys[i]].maxPerTeam != 0) {
      if(!isDefined(level.killstreakrules[keys[i]].curTeam[team]))
        level.killstreakrules[keys[i]].curTeam[team] = 0;
      if(level.killstreakrules[keys[i]].curTeam[team] >= level.killstreakrules[keys[i]].maxPerTeam)
        isAllowed = false;
    }
  }
  if(isDefined(self.lastStand) && self.lastStand)
    isAllowed = false;
  if(isAllowed == false) {
    if(isDefined(level.killstreaks[hardpointType]) && isDefined(level.killstreaks[hardpointType].notAvailableText))
      self iprintlnbold(level.killstreaks[hardpointType].notAvailableText);
  }
  return isAllowed;
}
killstreak_debug_text(text) {}