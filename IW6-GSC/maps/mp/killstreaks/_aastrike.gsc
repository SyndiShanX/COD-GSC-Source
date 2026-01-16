/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_aastrike.gsc
*********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  precacheItem("aamissile_projectile_mp");
  precacheModel("vehicle_av8b_harrier_jet_mp");

  level.teamAirDenied["axis"] = false;
  level.teamAirDenied["allies"] = false;

  level.rockets = [];
  level.killstreakFuncs["aastrike"] = ::tryUseAAStrike;
}

tryUseAAStrike(lifeId, streakName) {
  heightEnt = GetEnt("airstrikeheight", "targetname");
  assertEx(isDefined(heightEnt), "NO HEIGHT ENT IN LEVEL:Don't know what this means, ask Ned or Jordan");

  if(!isDefined(heightEnt))
    return false;

  self maps\mp\_matchdata::logKillstreakEvent("aastrike", self.origin);

  self thread finishAAStrike(lifeId);
  self thread teamPlayerCardSplash("used_aastrike", self, self.team);
  return true;
}

cycleTargets() {
  self endon("stopFindingTargets");
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");

  for(;;) {
    wait(.05);
    self findTargets();
    wait(randomIntRange(4, 5));
  }

}

findTargets() {
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");

  lbTargets = [];
  heliTargets = [];
  uavTargets = [];

  if(isDefined(level.littleBirds) && level.littleBirds.size) {
    foreach(lb in level.littleBirds) {
      if(isDefined(lb.team) && lb.team != self.team)
        lbTargets[lbTargets.size] = lb;
    }
  }

  if(isDefined(level.helis) && level.helis.size) {
    foreach(heli in level.helis) {
      if(heli.team != self.team)
        heliTargets[heliTargets.size] = heli;
    }
  }

  otherTeam = getOtherTeam(self.team);

  if(isDefined(level.activeUAVs[otherTeam])) {
    foreach(uav in level.uavmodels[otherTeam]) {
      uavTargets[uavTargets.size] = uav;
    }
  }

  targetCount = 0;
  foreach(lb in lbTargets) {
    wait(3);

    if(targetCount % 2)
      self thread fireAtTarget(lb, self.team, true);
    else
      self thread fireAtTarget(lb, self.team, false);

    targetCount++;
  }

  foreach(heli in heliTargets) {
    wait(3);
    self thread fireAtTarget(heli, self.team, true);
  }

  foreach(uav in uavTargets) {
    wait(0.5);
    self thread fireAtTarget(uav, self.team, false);
  }

}

earlyAbortWatcher() {
  self endon("stopFindingTargets");

  team = self.team;

  if(bot_is_fireteam_mode()) {
    self waittill("killstreak_disowned");
  } else {
    self waittill_either("killstreak_disowned", "game_ended");
  }

  self notify("owner_gone");

  level.teamAirDenied[getOtherTeam(team)] = false;
  level.airDeniedPlayer = undefined;
}

finishAAStrike(lifeId) {
  self endon("disconnect");
  self endon("owner_gone");
  self endon("game_ended");

  level.teamAirDenied[getOtherTeam(self.team)] = true;
  level.airDeniedPlayer = self;
  self thread earlyAbortWatcher();

  self thread cycleTargets();

  for(i = 0; i < 4; i++) {
    wait(6);
    if(i == 1 || i == 3)
      self thread doFlyBy(true);
    else
      self thread doFlyBy(false);
  }

  wait(3);

  self notify("stopFindingTargets");
  level.teamAirDenied[getOtherTeam(self.team)] = false;
  level.airDeniedPlayer = undefined;
}

fireAtTarget(curTarget, team, showIcon) {
  if(!isDefined(curTarget)) {
    return;
  }
  upVector = (0, 0, 14000);
  miniUpVector = (0, 0, 1500);
  backDist = 15000;
  forwardDist = 20000;

  targetPos = curTarget.origin;
  upVector = (0, 0, 1) * (targetPos) + (0, 0, 1000);

  curTargetYaw = curTarget.angles * (0, 1, 0);

  forward = anglesToForward(curTargetYaw);
  startpos = curTarget.origin + miniUpVector + forward * backDist * -1;
  endPos = curTarget.origin + miniUpVector + forward * forwardDist;

  rocket1 = MagicBullet("aamissile_projectile_mp", startpos + (0, 0, -75), curTarget.origin, self);
  rocket1 Missile_SetTargetEnt(curTarget);
  rocket1 Missile_SetFlightmodeDirect();

  rocket2 = MagicBullet("aamissile_projectile_mp", startpos + (RandomInt(500), RandomInt(500), -75), curTarget.origin, self);
  rocket2 Missile_SetTargetEnt(curTarget);
  rocket2 Missile_SetFlightmodeDirect();

  if(showIcon)
    plane = spawnplane(self, "script_model", startpos, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_friendly");
  else
    plane = spawnplane(self, "script_model", startpos);

  if(self.team == "allies")
    plane setModel("vehicle_av8b_harrier_jet_mp");
  else
    plane setModel("vehicle_av8b_harrier_jet_opfor_mp");

  length = distance(startPos, endPos);

  plane.angles = vectorToAngles(endPos - startPos);

  plane thread AASoundManager(length);
  plane thread playPlaneFx();

  length = distance(startPos, endPos);
  plane moveTo(endPos * 2, length / 2000, 0, 0);

  wait(length / 3000);
  plane delete();
}

AASoundManager(length) {
  self playLoopSound("veh_aastrike_flyover_loop");

  wait((length / 2) / 2000);
  self stopLoopSound();
  self playLoopSound("veh_aastrike_flyover_outgoing_loop");
}

doFlyBy(showIcon) {
  self endon("disconnect");

  randSpawn = randomInt(level.spawnPoints.size - 1);
  targetPos = level.spawnPoints[randSpawn].origin * (1, 1, 0);

  backDist = 20000;
  forwardDist = 20000;
  heightEnt = GetEnt("airstrikeheight", "targetname");

  upVector = (0, 0, heightEnt.origin[2] + randomIntRange(-100, 600));

  forward = anglesToForward((0, randomInt(45), 0));

  startpos = targetPos + upVector + forward * backDist * -1;
  endPos = targetPos + upVector + forward * forwardDist;

  plane2StartPos = startpos + (randomIntRange(400, 500), randomIntRange(400, 500), randomIntRange(200, 300));
  plane2EndPos = endPos + (randomIntRange(400, 500), randomIntRange(400, 500), randomIntRange(200, 300));

  if(showIcon)
    plane = spawnplane(self, "script_model", startpos, "hud_minimap_harrier_green", "hud_minimap_harrier_red");
  else
    plane = spawnplane(self, "script_model", startpos);

  plane2 = spawnplane(self, "script_model", plane2StartPos);

  if(self.team == "allies") {
    plane setModel("vehicle_av8b_harrier_jet_mp");
    plane2 setModel("vehicle_av8b_harrier_jet_mp");
  } else {
    plane setModel("vehicle_av8b_harrier_jet_opfor_mp");
    plane2 setModel("vehicle_av8b_harrier_jet_opfor_mp");
  }

  plane.angles = vectorToAngles(endPos - startPos);
  plane playLoopSound("veh_aastrike_flyover_loop");
  plane thread playPlaneFx();

  plane2.angles = vectorToAngles(endPos - plane2StartPos);
  plane2 thread playPlaneFx();

  length = distance(startPos, endPos);
  plane moveTo(endPos * 2, length / 1800, 0, 0);
  wait(randomFloatRange(.25, .5));
  plane2 moveTo(plane2EndPos * 2, length / 1800, 0, 0);

  wait(length / 1600);
  plane delete();
  plane2 delete();
}

playPlaneFx() {
  self endon("death");

  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}