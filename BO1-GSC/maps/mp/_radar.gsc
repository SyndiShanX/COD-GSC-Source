/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_radar.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  setMatchFlag("radar_allies", 0);
  setMatchFlag("radar_axis", 0);
  setDvar("ui_radar_client", 0);
  level.spyplane = [];
  level.counterspyplane = [];
  level.satellite = [];
  level.spyplaneType = [];
  level.satelliteType = [];
  level.radarTimers = [];
  level.radarTimers["allies"] = getTime();
  level.radarTimers["axis"] = getTime();
  level.spyplaneViewTime = 20;
  level.radarViewTime = 30;
  level.radarLongViewTime = 45;
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowradar")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("radar_mp", "radar_mp", "killstreak_spyplane", "uav_used", ::useKillstreakRadar);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("radar_mp", &"KILLSTREAK_EARNED_RADAR", &"KILLSTREAK_RADAR_NOT_AVAILABLE", &"KILLSTREAK_RADAR_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("radar_mp", "mpl_killstreak_radar", "kls_u2_used", "", "kls_u2_enemy", "", "kls_u2_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("radar_mp", "scr_giveradar");
  }
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowcounteruav")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("counteruav_mp", "counteruav_mp", "killstreak_counteruav", "counteruav_used", ::useKillstreakCounterUAV);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("counteruav_mp", &"KILLSTREAK_EARNED_COUNTERUAV", &"KILLSTREAK_COUNTERUAV_NOT_AVAILABLE", &"KILLSTREAK_COUNTERUAV_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("counteruav_mp", "mpl_killstreak_radar", "kls_cu2_used", "", "kls_cu2_enemy", "", "kls_cu2_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("counteruav_mp", "scr_givecounteruav");
  }
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowradardirection")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("radardirection_mp", "radardirection_mp", "killstreak_spyplane_direction", "uav_used", ::useKillstreakSatellite);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("radardirection_mp", &"KILLSTREAK_EARNED_SATELLITE", &"KILLSTREAK_SATELLITE_NOT_AVAILABLE", &"KILLSTREAK_SATELLITE_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("radardirection_mp", "mpl_killstreak_satellite", "kls_sat_used", "", "kls_sat_enemy", "", "kls_sat_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("radardirection_mp", "scr_giveradardirection");
  }
}
useKillstreakRadar(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false)
    return false;
  self thread maps\mp\_spyplane::callspyplane(hardpointType, false);
  return true;
}
useKillstreakCounterUAV(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false)
    return false;
  self thread maps\mp\_spyplane::callcounteruav(hardpointType, false);
  return true;
}
useKillstreakSatellite(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointType, self.team) == false)
    return false;
  self thread maps\mp\_spyplane::callsatellite(hardpointType, false);
  return true;
}
teamHasSpyplane(team) {
  spyplaneActive = getTeamSpyplane(team);
  if(spyplaneActive > 0)
    spyplaneActive = 1;
  return spyplaneActive;
}
teamHasSatellite(team) {
  satelliteActive = getTeamSatellite(team);
  if(satelliteActive > 0)
    satelliteActive = 1;
  return satelliteActive;
}
useRadarItem(hardpointType, team, displayMessage) {
  team = self.team;
  otherteam = "axis";
  if(team == "axis")
    otherteam = "allies";
  assert(isDefined(level.players));
  self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog(hardpointType, team);
  if(level.teambased) {
    if(!isDefined(level.spyplane[team]))
      level.spyplaneType[team] = 0;
    currentTypeSpyplane = level.spyplaneType[team];
    if(!isDefined(level.satelliteType[team]))
      level.satelliteType[team] = 0;
    currentTypeSatellite = level.satelliteType[team];
  } else {
    if(!isDefined(self.pers["spyplaneType"]))
      self.pers["spyplaneType"] = 0;
    currentTypeSpyplane = self.pers["spyplaneType"];
    if(!isDefined(self.pers["satelliteType"]))
      self.pers["satelliteType"] = 0;
    currentTypeSatellite = self.pers["satelliteType"];
  }
  radarViewType = 0;
  normal = 1;
  fastSweep = 2;
  notifyString = "";
  isSatellite = false;
  isRadar = false;
  isCounterUAV = false;
  viewTime = level.radarViewTime;
  switch (hardpointType) {
    case "radar_mp": {
      notifyString = "spyplane";
      isRadar = true;
      viewTime = level.spyplaneViewTime;
      self maps\mp\gametypes\_persistence::statAdd("RECON_USED", 1, false);
      level.globalKillstreaksCalled++;
      self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_spyplane", 1, "used");
    }
    break;
    case "radardirection_mp": {
      notifyString = "satellite";
      isSatellite = true;
      viewTime = level.radarLongViewTime;
      level notify("satelliteInbound", team, self);
      self maps\mp\gametypes\_persistence::statAdd("SATELLITE_USED", 1, false);
      level.globalKillstreaksCalled++;
      self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_spyplane_direction", 1, "used");
    }
    break;
    case "counteruav_mp": {
      notifyString = "counteruav";
      isCounterUAV = true;
      viewTime = level.radarViewTime;
      self maps\mp\gametypes\_persistence::statAdd("COUNTERUAV_USED", 1, false);
      level.globalKillstreaksCalled++;
      self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_counteruav", 1, "used");
    }
    break;
  }
  if(displayMessage) {
    if(isDefined(level.killstreaks[hardpointType]) && isDefined(level.killstreaks[hardpointType].inboundtext))
      level thread maps\mp\_popups::DisplayKillstreakTeamMessageToAll(hardpointType, self);
  }
  return viewTime;
}
radarDestroyed(team, otherteam) {
  setTeamSpyplaneWrapper(team);
  if(!isDefined(level.spyplane[self.team]) || level.spyplane[self.team] == 0) {
    level notify("spyplane_mp_timer_kill_" + team);
  }
}
resetSpyplaneTypeOnEnd(type) {
  self waittill(type + "_timer_kill");
  self.pers["spyplane"] = 0;
}
resetSatelliteTypeOnEnd(type) {
  self waittill(type + "_timer_kill");
  self.pers["satellite"] = 0;
}
setTeamSpyplaneWrapper(team, value) {
  setTeamSpyplane(team, value);
  radarType = "ui_radar_" + team;
  if(radarType == "ui_radar_allies")
    setMatchFlag("radar_allies", value);
  else
    setMatchFlag("radar_axis", value);
  level notify("radar_status_change", team);
}
setTeamSatelliteWrapper(team, value) {
  setTeamSatellite(team, value);
  radarType = "ui_radar_" + team;
  if(radarType == "ui_radar_allies")
    setMatchFlag("radar_allies", value);
  else
    setMatchFlag("radar_axis", value);
  if(value == false)
    level notify("satellite_finished_" + team);
  level notify("radar_status_change", team);
}
enemyObituaryText(type, numseconds) {
  switch (type) {
    case "radarupdate_mp": {
      self iprintln(&"MP_WAR_RADAR_ACQUIRED_UPDATE_ENEMY", numseconds);
    }
    break;
    case "radardirection_mp": {
      self iprintln(&"MP_WAR_RADAR_ACQUIRED_DIRECTION_ENEMY", numseconds);
    }
    break;
    case "counteruav_mp": {
      self iprintln(&"MP_WAR_RADAR_COUNTER_UAV_ACQUIRED_ENEMY", numseconds);
    }
    break;
    default: {
      self iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY", numseconds);
    }
  }
}
friendlyObituaryText(type, callingPlayer, numseconds) {
  switch (type) {
    case "radarupdate_mp": {
      self iprintln(&"MP_WAR_RADAR_UPDATE_ACQUIRED", callingPlayer, numseconds);
    }
    break;
    case "radardirection_mp": {
      self iprintln(&"MP_WAR_RADAR_DIRECTION_ACQUIRED", callingPlayer, numseconds);
    }
    break;
    case "counteruav_mp": {
      self iprintln(&"MP_WAR_RADAR_COUNTER_UAV_ACQUIRED", numseconds);
    }
    break;
    default: {
      self iprintln(&"MP_WAR_RADAR_ACQUIRED", callingPlayer, numseconds);
    }
  }
}

