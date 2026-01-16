/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_airsupport.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_utility_code;
#include clientscripts\_vehicle;

planesounds(spawnsound, flybysound, flybysoundloop, lengthofflyby) {
  self endon("delete");
  fake_ent_plane = spawnfakeent(0);
  playsound(0, spawnsound, (0, 0, 0));
  thread plane_position_updater(fake_ent_plane, self, flybysound, flybysoundloop, lengthofflyby);
}

plane_position_updater(fake_ent, plane, flybysound, flybysoundloop, lengthofflyby) {
  soundid = -1;
  dx = undefined;
  lasttime = undefined;
  lastpos = undefined;
  starttime = 0;

  while(isDefined(plane)) {
    setfakeentorg(0, fake_ent, plane.origin);

    if(soundid < 0 && isDefined(lastpos)) {
      dx = plane.origin - lastpos;

      if(length(dx) > 0.01) {
        velocity = dx / (getrealtime() - lasttime);
        assert(isDefined(velocity));
        players = level.localplayers;
        assert(isDefined(players));
        other_point = plane.origin + velocity * 100000;
        point = closest_point_on_line_to_point(players[0].origin, plane.origin, other_point);
        assert(isDefined(point));
        dist = distance(point, plane.origin);
        assert(isDefined(dist));
        time = dist / length(velocity);
        assert(isDefined(time));

        if(time < lengthofflyby) {
          if(isDefined(flybysoundloop))
            soundid = playloopsound(0, fake_ent, flybysoundloop, 0);

          if(isDefined(flybysound))
            plane playsound(0, flybysound);

          starttime = getrealtime();
        }
      }
    }

    lastpos = plane.origin;
    lasttime = getrealtime();
    waitrealtime(0.1);
  }

  wait 5;
  deletefakeent(0, fake_ent);
}

closest_point_on_line_to_point(point, linestart, lineend) {
  linemagsqrd = lengthsquared(lineend - linestart);
  t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;

  if(t < 0.0)
    return linestart;
  else if(t > 1.0)
    return lineend;
  else {
    start_x = linestart[0] + t * (lineend[0] - linestart[0]);
    start_y = linestart[1] + t * (lineend[1] - linestart[1]);
    start_z = linestart[2] + t * (lineend[2] - linestart[2]);
    return (start_x, start_y, start_z);
  }
}

getplanemodel(teamfaction) {
  switch (teamfaction) {
    case "vietcong":
      planemodel = "t5_veh_air_mig_21_nva_flying";
      break;
    case "nva":
      planemodel = "t5_veh_air_mig_21_nva_flying";
      break;
    case "japanese":
      planemodel = "t5_veh_air_mig_21_ussr_flying";
      break;
    case "russian":
      planemodel = "t5_veh_air_mig_21_ussr_flying";
      break;
    case "marines":
      planemodel = "t5_veh_jet_f4_gearup";
      break;
    case "specops":
      planemodel = "t5_veh_jet_f4_gearup";
      break;
    default:

      println("invalid faction, defaulting to marines");

      planemodel = "t5_veh_jet_f4_gearup";
      break;
  }

  return planemodel;
}

planeturnleft(plane, yaw, halflife) {
  plane endon("delete");
  yawy = getdvarfloatdefault("scr_planeyaw", 0.6);
  rollz = getdvarfloatdefault("scr_planeroll", -1.5);
  maxyaw = getdvarfloatdefault("scr_max_planeyaw", 45.0);
  minroll = getdvarfloatdefault("scr_min_planeroll", -60.0);
  ox = getdvarfloatdefault("scr_planeox", 30000.0);
  oy = getdvarfloatdefault("scr_planeoy", 30000.0);
  maxox = getdvarfloatdefault("scr_maxo_planex", -1.0);
  maxoy = getdvarfloatdefault("scr_maxo_planey", -1.0);

  if(plane.angles[1] == 360)
    plane.angles = (plane.angles[0], 0, plane.angles[2]);

  origx = plane.origin[0];
  origy = plane.origin[1];
  accumturn = 0;

  for(looptime = 0.1; looptime <= halflife; looptime = looptime + 0.1) {
    if(plane.angles[1] == 360)
      plane.angles = (plane.angles[0], 0, plane.angles[2]);

    if(minroll != -1 && plane.angles[2] <= minroll)
      rollz = 0.0;

    accumturn = accumturn + yawy;

    if(accumturn >= maxyaw)
      yawy = 0.0;

    plane.angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] + rollz);
    mathx = sin(45 * looptime / halflife) * ox;
    mathy = cos(45 * looptime / halflife) * oy;
    oldx = mathx;
    oldy = oy - mathy;
    rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
    rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;
    endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
    plane moveto(endpoint, 0.1, 0, 0);
    waitrealtime(0.1);
  }

  yawy = getdvarfloatdefault("scr_planeyaw2", 0.6);
  rollz = getdvarfloatdefault("scr_planeroll2", -0.9);
  ox = getdvarfloatdefault("scr_planeox", 30000.0);
  oy = getdvarfloatdefault("scr_planeoy", 30000.0);
  maxox = getdvarfloatdefault("scr_maxo_planex", -1.0);
  maxoy = getdvarfloatdefault("scr_maxo_planey", -1.0);
  y = getdvarfloatdefault("scr_planey2", 0.6);
  z = getdvarfloatdefault("scr_planez2", -1.5);
  maxy = getdvarfloatdefault("scr_max_planey2", 90);
  accumturn = 0;

  while(looptime < halflife + halflife) {
    if(plane.angles[1] == 360)
      plane.angles = (plane.angles[0], 0, plane.angles[2]);

    if(minroll != -1 && plane.angles[2] >= 0)
      rollz = 0.0;

    accumturn = accumturn + yawy;

    if(accumturn >= maxyaw)
      yawy = 0.0;

    plane.angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] - rollz);
    mathx = sin(45 * looptime / halflife) * ox;
    mathy = cos(45 * looptime / halflife) * oy;
    oldx = mathx;
    oldy = oy - mathy;
    rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
    rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;
    endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
    plane moveto(endpoint, 0.1, 0, 0);
    waitrealtime(0.1);
    looptime = looptime + 0.1;
  }
}

planeturnright(plane, yaw, halflife) {
  plane endon("delete");
  yawy = getdvarfloatdefault("scr_planeyaw", -0.6);
  rollz = getdvarfloatdefault("scr_planeroll", 1.5);
  maxyaw = getdvarfloatdefault("scr_max_planeyaw", -45.0);
  minroll = getdvarfloatdefault("scr_min_planeroll", 60.0);
  ox = getdvarfloatdefault("scr_planeox", 30000.0);
  oy = getdvarfloatdefault("scr_planeoy", -30000.0);
  maxox = getdvarfloatdefault("scr_maxo_planex", -1.0);
  maxoy = getdvarfloatdefault("scr_maxo_planey", -1.0);

  if(plane.angles[1] == 360)
    plane.angles = (plane.angles[0], 0, plane.angles[2]);

  origx = plane.origin[0];
  origy = plane.origin[1];
  accumturn = 0;

  for(looptime = 0.1; looptime <= halflife; looptime = looptime + 0.1) {
    if(plane.angles[1] == 360)
      plane.angles = (plane.angles[0], 0, plane.angles[2]);

    if(minroll != -1 && plane.angles[2] >= minroll)
      rollz = 0.0;

    accumturn = accumturn + yawy;

    if(accumturn <= maxyaw)
      yawy = 0.0;

    plane.angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] + rollz);
    mathx = sin(45 * looptime / halflife) * ox;
    mathy = cos(45 * looptime / halflife) * oy;
    oldx = mathx;
    oldy = oy - mathy;
    rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
    rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;

    println(rotatedx + " " + rotatedy + "\\n");

    endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
    plane moveto(endpoint, 0.1, 0, 0);
    waitrealtime(0.1);
  }

  yawy = getdvarfloatdefault("scr_planeyaw2", 0.6);
  rollz = getdvarfloatdefault("scr_planeroll2", -0.9);
  ox = getdvarfloatdefault("scr_planeox", 30000.0);
  oy = getdvarfloatdefault("scr_planeoy", -30000.0);
  maxox = getdvarfloatdefault("scr_maxo_planex", -1.0);
  maxoy = getdvarfloatdefault("scr_maxo_planey", -1.0);
  y = getdvarfloatdefault("scr_planey2", 0.6);
  z = getdvarfloatdefault("scr_planez2", -1.5);
  maxy = getdvarfloatdefault("scr_max_planey2", 90);
  accumturn = 0;

  while(looptime < halflife + halflife) {
    if(plane.angles[1] == 360)
      plane.angles = (plane.angles[0], 0, plane.angles[2]);

    if(minroll != -1 && plane.angles[2] >= 0)
      rollz = 0.0;

    accumturn = accumturn + yawy;

    if(accumturn >= maxyaw)
      yawy = 0.0;

    plane.angles = (plane.angles[0], plane.angles[1] + yawy, plane.angles[2] - rollz);
    mathx = sin(45 * looptime / halflife) * ox;
    mathy = cos(45 * looptime / halflife) * oy;
    oldx = mathx;
    oldy = oy - mathy;
    rotatedx = cos(yaw) * oldx - sin(yaw) * oldy;
    rotatedy = sin(yaw) * oldx + cos(yaw) * oldy;
    endpoint = (origx + rotatedx, origy + rotatedy, plane.origin[2]);
    plane moveto(endpoint, 0.1, 0, 0);
    waitrealtime(0.1);
    looptime = looptime + 0.1;
  }
}

doabarrelroll(plane, endpoint, time) {
  plane endon("delete");
  plane moveto(endpoint, time, 0, 0);
  rollz = getdvarfloatdefault("scr_barrelroll", 10);
  degreestoroll = getdvarfloatdefault("scr_degreesToRoll", 720);
  degreesrolled = 0;

  while(degreesrolled < degreestoroll) {
    plane.angles = (plane.angles[0], plane.angles[1], plane.angles[2] + rollz);
    degreesrolled = degreesrolled + rollz;
    waitrealtime(0.01);
  }
}

planegostraight(plane, endpoint, time) {
  plane endon("delete");
  plane moveto(endpoint, time, 0, 0);
}

debug_line(from, to, color, time) {
  level.airsupport_debug = getdvarintdefault("scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1.0) {
    if(!isDefined(time))
      time = 1000;

    line(from, to, color, 1, 1, time);
  }

}

debug_star(origin, color, time) {
  level.airsupport_debug = getdvarintdefault("scr_airsupport_debug", 0);

  if(isDefined(level.airsupport_debug) && level.airsupport_debug == 1.0) {
    if(!isDefined(time))
      time = 1000;

    if(!isDefined(color))
      color = (1, 1, 1);

    debugstar(origin, time, color);
  }

}