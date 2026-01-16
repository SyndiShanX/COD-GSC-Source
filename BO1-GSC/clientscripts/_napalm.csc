/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_napalm.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_utility_code;
#include clientscripts\_vehicle;
#include clientscripts\_airsupport;

startNapalm(localClientNum, pos, yaw, teamfaction, team, owner, exitType) {
  if(!isDefined(level.napalmstrikeinited) || level.napalmstrikeinited != true)
    init_napalmstrike();
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++)
    callNapalmStrike(localClientNum, pos, yaw, teamfaction, team, owner, exitType);
}

init_napalmstrike() {
  level.fx_jet_trail = loadfx("trail/fx_geotrail_jet_contrail");
  level.fx_airstrike_afterburner = loadfx("vehicle/exhaust/fx_exhaust_jet_afterburner");
  level.fx_napalm_marker = loadfx("weapon/napalm/fx_napalm_marker_mp");
  level.napalmstrikeinited = true;
  if(isDefined(level.airsupportHeightScale)) {
    switch (level.airsupportHeightScale) {
      case 2:
        level.airsupportbombTimer = 2.45;
        level.airsupportfxTimer = 1.0;
        break;
      case 3:
        level.airsupportbombTimer = 2.2;
        level.airsupportFxTimer = 1.2;
        break;
    }
  }
}

playPlaneFx(localClientNum) {
  playfxontag(localClientNum, level.fx_airstrike_afterburner, self, "tag_engine");
  playfxontag(localClientNum, level.fx_jet_trail, self, "tag_right_wingtip");
  playfxontag(localClientNum, level.fx_jet_trail, self, "tag_left_wingtip");
}

callNapalmStrike(localClientNum, coord, yaw, teamfaction, team, owner, exitType) {
  direction = (0, yaw, 0);
  planeHalfDistance = 24000;
  planeFlyHeight = 850;
  planeFlySpeed = 7000;
  if(isDefined(level.airsupportHeightScale)) {
    planeFlyHeight *= level.airsupportHeightScale;
  }
  startPoint = coord + vector_scale(anglestoforward(direction), -1 * planeHalfDistance);
  endPoint = coord + vector_scale(anglestoforward(direction), planeHalfDistance);
  if(isDefined(level.forceAirsupportMapHeight)) {
    startPoint = (startPoint[0], startPoint[1], level.forceAirsupportMapHeight);
    endPoint = (endPoint[0], endPoint[1], level.forceAirsupportMapHeight);
    coord = (coord[0], coord[1], level.forceAirsupportMapHeight);
  }
  startPoint += (0, 0, planeFlyHeight);
  endPoint += (0, 0, planeFlyHeight);
  d = length(startPoint - endPoint);
  flyTime = (d / planeFlySpeed);
  if(!isDefined(localClientNum))
    return;
  planeModel = "t5_veh_jet_mig17";
  thread flarePlane(localClientNum, planeModel, team, owner, startPoint, endPoint, flyTime, direction);
  timeIncreaseBetweenPlanes = 3;
  wait(timeIncreaseBetweenPlanes);
  thread napalmPlane(localClientNum, planeModel, team, owner, exitType, startPoint, endPoint, flyTime, direction, yaw);
}

napalmPlane(localClientNum, planeModel, team, owner, exitType, startPoint, endPoint, flyTime, direction, yaw) {
  plane = spawnPlane(localClientNum, startPoint, planeModel, team, owner, "compass_objpoint_napalmstrike");
  plane.angles = direction;
  plane planeSounds("veh_mig_flyby_2d", "evt_us_napalm_wash", undefined, 2362);
  plane thread playPlaneFx(localClientNum);
  destPoint = (startPoint[0] / 2 + endPoint[0] / 2, startPoint[1] / 2 + endPoint[1] / 2, startPoint[2] / 2 + endPoint[2] / 2);
  plane moveTo(destPoint, flyTime / 2, 0, 0);
  realwait(flyTime / 2);
  halflife = getDvarFloatDefault(#"scr_napalmhalflife", 6.0);
  switch (exitType) {
    case "left":
      thread planeTurnLeft(plane, yaw, halflife);
      realwait(halflife + halflife);
      break;
    case "right":
      thread planeTurnRight(plane, yaw, halflife);
      realwait(halflife + halflife);
      break;
    case "straight":
      thread planeGoStraight(plane, endPoint, flyTime / 2 - 1);
      realwait(flyTime / 2 - 1);
      break;
    case "barrelroll":
      thread doABarrelRoll(plane, endPoint, flyTime / 2 - 1);
      realwait(flyTime / 2 - 1);
      break;
    default:
      println("Warning: incorrect exit type; client napalm" + exitType + "\n");
      break;
  }
  wait(3);
  plane notify("delete");
  plane delete();
}

flarePlane(localClientNum, planeModel, team, owner, startPoint, endPoint, flyTime, direction) {
  plane = spawnPlane(localClientNum, startPoint, planeModel, team, owner, "compass_objpoint_napalmstrike");
  plane.angles = direction;
  plane planeSounds("evt_us_napalm_flare_flyby_2d", "evt_us_napalm_flare_wash", undefined, 2362);
  plane thread playPlaneFx(localClientNum);
  plane moveTo(endPoint, flyTime, 0, 0);
  realwait(flyTime + 3);
  plane notify("delete");
  plane delete();
}

releaseFlare(localClientNum, owner, plane, startPoint, endPoint, direction) {
  if(!isDefined(owner))
    return;
  startPathRandomness = 100;
  endPathRandomness = 150;
  pathStart = startPoint;
  pathEnd = endPoint;
  forward = anglesToForward(direction);
  thread debug_line(pathStart, pathEnd, (1, 1, 1), 10);
  thread callStrike_flareEffect(localClientNum, plane, pathEnd, owner);
}

callStrike_flareEffect(localClientNum, plane, pathEnd, owner) {
  fxTimer = 0.15;
  if(isDefined(level.airsupportFxTimer))
    fxTimer = level.airsupportFxTimer;
  fxtimer = getDvarFloatDefault(#"scr_fxTimer", fxTimer);
  bombWait = 2.35;
  if(isDefined(level.airsupportbombTimer))
    bombWait = level.airsupportbombTimer;
  bombWait = getDvarFloatDefault(#"scr_napalmflareTimer", bombWait);
  wait(bombWait);
  planedir = anglesToForward(plane.angles);
  flare = spawnflare(localClientNum, plane.origin, plane.angles);
  flare moveGravity(vector_scale(anglestoforward(plane.angles), 7000 / 3), fxtimer + 3.95);
  flare thread debug_draw_bomb_path();
  wait 1.0;
  wait(fxTimer);
  flareOrigin = flare.origin;
  flareAngles = flare.angles;
  repeat = 8;
  minAngle = 5;
  maxAngle = 45;
  if(isDefined(level.napalmFlameMinAngle))
    minAngle = level.napalmFlameMinAngle;
  if(isDefined(level.napalmFlameMaxAngle))
    maxAngle = level.napalmFlameMaxAngle;
  maxAngle = getDvarFloatDefault(#"scr_napalm_maxAngles", maxAngle);
  hitpos = (0, 0, 0);
  previousHeight = 0;
  traceDir = anglesToForward(flareAngles + (maxAngle, 0, 0));
  traceEnd = flareOrigin + vector_scale(traceDir, 10000);
  trace = bulletTrace(flareOrigin, traceEnd, false, undefined);
  traceHit = trace["position"];
  hitpos += traceHit;
  playfx(localClientNum, level.fx_napalm_marker, hitpos);
  debug_line(flareOrigin, traceHit, (1, 0, 0), 20);
  debug_star(hitpos, (1, 0, 0), 20 * 1000);
  wait(4.0);
  flare delete();
}

spawnFlare(localClientNum, origin, angles) {
  flare = spawn(localClientNum, origin, "script_origin");
  flare.angles = angles;
  flare setModel("projectile_cbu97_clusterbomb");
  return flare;
}

debug_draw_bomb_path(projectile) {}