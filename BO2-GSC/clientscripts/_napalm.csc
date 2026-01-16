/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_napalm.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_utility_code;
#include clientscripts\_vehicle;
#include clientscripts\_airsupport;

startnapalm(localclientnum, pos, yaw, teamfaction, team, owner, exittype) {
  if(!isDefined(level.napalmstrikeinited) || level.napalmstrikeinited != 1)
    init_napalmstrike();

  players = level.localplayers;

  for(i = 0; i < players.size; i++)
    callnapalmstrike(localclientnum, pos, yaw, teamfaction, team, owner, exittype);
}

init_napalmstrike() {
  level.fx_jet_trail = loadfx("trail/fx_geotrail_jet_contrail");
  level.fx_airstrike_afterburner = loadfx("vehicle/exhaust/fx_exhaust_jet_afterburner");
  level.fx_napalm_marker = loadfx("weapon/napalm/fx_napalm_marker_mp");
  level.napalmstrikeinited = 1;

  if(isDefined(level.airsupportheightscale)) {
    switch (level.airsupportheightscale) {
      case 2:
        level.airsupportbombtimer = 2.45;
        level.airsupportfxtimer = 1.0;
        break;
      case 3:
        level.airsupportbombtimer = 2.2;
        level.airsupportfxtimer = 1.2;
        break;
    }
  }
}

playplanefx(localclientnum) {
  playfxontag(localclientnum, level.fx_airstrike_afterburner, self, "tag_engine");
  playfxontag(localclientnum, level.fx_jet_trail, self, "tag_right_wingtip");
  playfxontag(localclientnum, level.fx_jet_trail, self, "tag_left_wingtip");
}

callnapalmstrike(localclientnum, coord, yaw, teamfaction, team, owner, exittype) {
  direction = (0, yaw, 0);
  planeflyheight = 850;

  if(isDefined(level.airsupportheightscale))
    planeflyheight = planeflyheight * level.airsupportheightscale;

  startpoint = coord + vectorscale(anglestoforward(direction), -1 * 24000);
  endpoint = coord + vectorscale(anglestoforward(direction), 24000);

  if(isDefined(level.forceairsupportmapheight)) {
    startpoint = (startpoint[0], startpoint[1], level.forceairsupportmapheight);
    endpoint = (endpoint[0], endpoint[1], level.forceairsupportmapheight);
    coord = (coord[0], coord[1], level.forceairsupportmapheight);
  }

  startpoint = startpoint + (0, 0, planeflyheight);
  endpoint = endpoint + (0, 0, planeflyheight);
  d = length(startpoint - endpoint);
  flytime = d / 7000;

  if(!isDefined(localclientnum)) {
    return;
  }
  planemodel = "t5_veh_jet_mig17";
  thread flareplane(localclientnum, planemodel, team, owner, startpoint, endpoint, flytime, direction);
  wait 3;
  thread napalmplane(localclientnum, planemodel, team, owner, exittype, startpoint, endpoint, flytime, direction, yaw);
}

napalmplane(localclientnum, planemodel, team, owner, exittype, startpoint, endpoint, flytime, direction, yaw) {
  plane = spawnplane(localclientnum, startpoint, planemodel, team, owner, "compass_objpoint_napalmstrike");
  plane.angles = direction;
  plane planesounds("veh_mig_flyby_2d", "evt_us_napalm_wash", undefined, 2362);
  plane thread playplanefx(localclientnum);
  destpoint = (startpoint[0] / 2 + endpoint[0] / 2, startpoint[1] / 2 + endpoint[1] / 2, startpoint[2] / 2 + endpoint[2] / 2);
  plane moveto(destpoint, flytime / 2, 0, 0);
  waitrealtime(flytime / 2);
  halflife = getdvarfloatdefault("scr_napalmhalflife", 6.0);

  switch (exittype) {
    case "left":
      thread planeturnleft(plane, yaw, halflife);
      waitrealtime(halflife + halflife);
      break;
    case "right":
      thread planeturnright(plane, yaw, halflife);
      waitrealtime(halflife + halflife);
      break;
    case "straight":
      thread planegostraight(plane, endpoint, flytime / 2 - 1);
      waitrealtime(flytime / 2 - 1);
      break;
    case "barrelroll":
      thread doabarrelroll(plane, endpoint, flytime / 2 - 1);
      waitrealtime(flytime / 2 - 1);
      break;
    default:

      println("Warning: incorrect exit type; client napalm" + exittype + "\\n");

      break;
  }

  wait 3;
  plane notify("delete");
  plane delete();
}

flareplane(localclientnum, planemodel, team, owner, startpoint, endpoint, flytime, direction) {
  plane = spawnplane(localclientnum, startpoint, planemodel, team, owner, "compass_objpoint_napalmstrike");
  plane.angles = direction;
  plane planesounds("evt_us_napalm_flare_flyby_2d", "evt_us_napalm_flare_wash", undefined, 2362);
  plane thread playplanefx(localclientnum);
  plane moveto(endpoint, flytime, 0, 0);
  waitrealtime(flytime + 3);
  plane notify("delete");
  plane delete();
}

releaseflare(localclientnum, owner, plane, startpoint, endpoint, direction) {
  if(!isDefined(owner)) {
    return;
  }
  pathstart = startpoint;
  pathend = endpoint;
  forward = anglestoforward(direction);
  thread debug_line(pathstart, pathend, (1, 1, 1), 10);
  thread callstrike_flareeffect(localclientnum, plane, pathend, owner);
}

callstrike_flareeffect(localclientnum, plane, pathend, owner) {
  fxtimer = 0.15;

  if(isDefined(level.airsupportfxtimer))
    fxtimer = level.airsupportfxtimer;

  fxtimer = getdvarfloatdefault("scr_fxTimer", fxtimer);
  bombwait = 2.35;

  if(isDefined(level.airsupportbombtimer))
    bombwait = level.airsupportbombtimer;

  bombwait = getdvarfloatdefault("scr_napalmflareTimer", bombwait);
  wait(bombwait);
  planedir = anglestoforward(plane.angles);
  flare = spawnflare(localclientnum, plane.origin, plane.angles);
  flare movegravity(vectorscale(anglestoforward(plane.angles), 2333.33), fxtimer + 3.95);
  flare thread debug_draw_bomb_path();
  wait 1.0;
  wait(fxtimer);
  flareorigin = flare.origin;
  flareangles = flare.angles;
  minangle = 5;
  maxangle = 45;

  if(isDefined(level.napalmflameminangle))
    minangle = level.napalmflameminangle;

  if(isDefined(level.napalmflamemaxangle))
    maxangle = level.napalmflamemaxangle;

  maxangle = getdvarfloatdefault("scr_napalm_maxAngles", maxangle);
  hitpos = (0, 0, 0);
  tracedir = anglestoforward(flareangles + (maxangle, 0, 0));
  traceend = flareorigin + vectorscale(tracedir, 10000);
  trace = bullettrace(flareorigin, traceend, 0, undefined);
  tracehit = trace["position"];
  hitpos = hitpos + tracehit;
  playfx(localclientnum, level.fx_napalm_marker, hitpos);
  debug_line(flareorigin, tracehit, (1, 0, 0), 20);
  debug_star(hitpos, (1, 0, 0), 20000);
  wait 4.0;
  flare delete();
}

spawnflare(localclientnum, origin, angles) {
  flare = spawn(localclientnum, origin, "script_origin");
  flare.angles = angles;
  flare setmodel("projectile_cbu97_clusterbomb");
  return flare;
}

debug_draw_bomb_path(projectile) {
}