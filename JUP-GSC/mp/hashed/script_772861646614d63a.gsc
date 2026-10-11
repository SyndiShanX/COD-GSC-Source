/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_772861646614d63a.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#using scripts\vehicle\vehicle_common;
#namespace namespace_35e55eb0037e4a11;

function function_e09936350b8d90fe() {
  data = spawnStruct();
  data.spawnheli = &function_c8189fd441946d86;
  data.var_e0fd93cddc4b8912 = &function_595d4ebd73e6b933;
  data.flyaway = &function_5eb66c5c1382fed;
  return data;
}

function function_c8189fd441946d86(guardvehicle) {
  heli = function_b232793fe47c01b9();
  heli thread function_282ffb050875ade6(guardvehicle);
  scripts\mp\weapons::function_e00b77a9cb4d8322(heli);
  heli.var_f6a794b2d3dc63e7 = &function_90ac39c3f9e0bc50;
  heli.flaresreservecount = 1;
  heli.flareslive = [];

  if(scripts\engine\utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    heli thread[[scripts\engine\utility::getsharedfunc("flares", "handleIncomingStinger")]](&function_8fe1775245b13b6f);
  }

  return heli;
}

function private function_b232793fe47c01b9() {
  node = getclosest((self.vehicle.origin + self.end.origin) * 0.5, level.var_77aa416377054823);
  spawnnode = spawnStruct();
  spawnnode.origin = node.origin;
  spawnnode.angles = node.angles;
  spawnnode.classname_mp = "script_vehicle_heli_medium";
  spawnnode.vehicletype = "lbravo_infil_cp";
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawnnode);
  heli.var_a1a5d39c25c6d70b = 1;
  heli.gunners = [];
  heli.gunners[heli.gunners.size] = function_7512e3d88c4083fa(heli, 3);
  heli.gunners[heli.gunners.size] = function_7512e3d88c4083fa(heli, 4);
  heli.exitnode = node;
  return heli;
}

function function_e1a0ba4bbcab4d69(heli) {
  heli waittill("death");

  if(isDefined(self) && isalive(self)) {
    self.nocorpse = 1;
    scripts\mp\ai_mp_controller::function_28b90eb2b591003f();
  }
}

function private function_7512e3d88c4083fa(heli, startingpos) {
  origin = ter_op(isDefined(level.var_f0872e42daf6d4d5), level.var_f0872e42daf6d4d5, heli.origin);
  aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar");
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, origin, heli.angles, "absolute", "mission", "vehicleDriveHeliDriver", undefined, undefined, undefined, self.node.poi, 1, undefined, 0);

  if(!isDefined(agent)) {
    println("<dev string:x1c>");
    return undefined;
  }

  availablepositionsstruct = heli scripts\common\vehicle_aianim::get_availablepositions();
  agent.script_startingposition = startingpos;
  pos = heli scripts\common\vehicle_aianim::choose_vehicle_position(agent, availablepositionsstruct, 0);
  agent scripts\vehicle\vehicle_common::entervehicle(heli, 1, pos, scripts\common\vehicle_aianim::anim_pos(heli, pos.vehicle_position));
  agent.vehicle_position = pos.vehicle_position;
  agent.goalradius = 10000;
  agent.maxsightdistsqrd = squared(10000);
  agent function_9215ce6fc83759b9(10000);
  agent.ignoreall = 1;
  return agent;
}

function function_282ffb050875ade6(vehicle) {
  self endon("death");
  self endon("flyaway");
  self setmaxpitchroll(20, 20);
  self setneargoalnotifydist(150);
  idletick = 0;
  updaterate = 0.1;
  self.var_83be9a2713b0d741 = 0;

  while(true) {
    wait updaterate;

    if(!isDefined(vehicle)) {
      thread function_5eb66c5c1382fed();
      return;
    }

    if(istrue(self.var_e99777b08fe2d86b)) {
      continue;
    }

    veh_speed = vehicle vehicle_getspeed();
    idletick = 0;
    currdist = distance2dsquared(self.origin, vehicle.var_52a27c0888f8eab7);
    self vehicle_setspeed(150, 30, 30);

    if(currdist > 16777216) {
      thread function_a051d3cda138645(vehicle.var_52a27c0888f8eab7, 1, vehicle);
    } else if(currdist > 1048576) {
      thread function_a051d3cda138645(vehicle.var_52a27c0888f8eab7, 1, vehicle);
    }

    if(function_93b8918609703560()) {
      thread function_5eb66c5c1382fed();
      return;
    }
  }
}

function function_692565a9023d24d7(vehicle, heli) {
  heli endon("stop_throwing");
  heli endon("death");
  heli endon("flyaway");
  heli.var_e99777b08fe2d86b = 0;
  segmentstart = (0, 0, 0);
  segmentend = (0, 0, 0);
  var_6caddec344e5f991 = 0;
  numbombs = 0;
  var_4d31b9022a51b776 = heli.origin;

  while(true) {
    if(!isDefined(vehicle)) {
      return;
    }

    if(heli function_93b8918609703560()) {
      heli thread function_5eb66c5c1382fed();
      return;
    }

    diff = heli.origin - var_4d31b9022a51b776;
    var_4d31b9022a51b776 = heli.origin;
    currdist = distance2dsquared(heli.origin, vehicle.var_52a27c0888f8eab7);

    if(!istrue(heli.var_e99777b08fe2d86b)) {
      if(currdist < 1048576) {
        heli vehicle_setspeed(125, 20, 20);
        speed = vehicle vehicle_getspeed();
        segmentstart = vehicle.var_52a27c0888f8eab7 - 1000 * vectorNormalize(vehicle.var_52a27c0888f8eab7 - heli.origin);
        segmentend = vehicle.var_52a27c0888f8eab7 + 1000 * vectorNormalize(vehicle.var_52a27c0888f8eab7 - heli.origin);
        segmentstart = (segmentstart[0], segmentstart[1], heli.origin[2]);
        segmentend = (segmentend[0], segmentend[1], heli.origin[2]);
        startdist = distance2dsquared(heli.origin, segmentstart);

        if(startdist < 122500) {
          heli.var_e99777b08fe2d86b = 1;
          var_6caddec344e5f991 = 0;
          numbombs = 0;
        } else {
          heli thread function_a051d3cda138645(segmentstart, 0, vehicle);
        }
      }
    }

    if(istrue(heli.var_e99777b08fe2d86b)) {
      heli vehicle_setspeed(120, 20, 20);
      heli thread function_a051d3cda138645(segmentend, 0, vehicle);

      if(currdist < squared(2500)) {
        var_6caddec344e5f991 += length(diff);

        if(var_6caddec344e5f991 > 500) {
          var_6caddec344e5f991 -= 500;
          numbombs++;
          thread function_88b12c91f836c975(heli, vehicle);
        }
      } else {
        heli.var_e99777b08fe2d86b = 0;
      }

      if(numbombs > 8) {
        heli.var_e99777b08fe2d86b = 0;
      }
    }

    wait 0.1;
  }
}

function function_595d4ebd73e6b933() {
  self.vehicle endon("death");
  self endon("task_ended");
  oldpositions = [self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin];
  maxindex = 3;
  currindex = 0;

  while(true) {
    speed = self.vehicle vehicle_getspeed();
    var_b413a5de3aa90b12 = 17.6;
    forward = vectorNormalize(self.vehicle.origin - oldpositions[currindex]);
    oldpositions[currindex] = self.vehicle.origin;
    currindex = ter_op(currindex < maxindex - 1, currindex + 1, 0);
    self.vehicle.var_52a27c0888f8eab7 = self.vehicle.origin + forward * speed * var_b413a5de3aa90b12 * 6;
    wait 0.5;
  }
}

function private function_88b12c91f836c975(heli, vehicle) {
  if(!istrue(heli.var_dac7ebf81da6ba53)) {
    playersonteam = scripts\mp\utility\teams::getteamdata(vehicle.var_a21a9516d1dede9e, "players");
    scripts\cp_mp\overlord::playevent("vehicledrive_helibomb", playersonteam);
    heli.var_dac7ebf81da6ba53 = 1;
  }

  if(heli function_93b8918609703560()) {
    heli thread function_5eb66c5c1382fed();
    return;
  }

  gunner = getclosest(vehicle.origin, heli.gunners);
  start = gunner.origin + (0, 0, 40) + anglesToForward(gunner.angles) * 10;
  thread function_61aa56cc8bf30b2f(start, heli);
}

function function_61aa56cc8bf30b2f(origin, heli) {
  level notify("dropping_bombs");
  c4 = magicgrenademanual("c4_dmz_heli", origin, (0, 0, -100));
  c4 setotherent(heli);
  c4.angles = (0, randomfloat(360), 0) + (-90, 180, 0);
  c4 setscriptablepartstate("effects", "neutral");
  c4 thread function_8a112ffdc7706922();
  c4 waittill_any_timeout_1(8, "detonate");
  c4 setscriptablepartstate("effects", "explode");
  wait 3;
  c4 delete();
}

function function_8a112ffdc7706922(vehicle) {
  self endon("entitydeleted");
  playerdist = squared(200);
  vehicledist = squared(275);

  while(true) {
    shoulddetonate = 0;

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distancesquared(self.origin, player.origin) < playerdist) {
          shoulddetonate = 1;
        }

        continue;
      }

      if(distancesquared(self.origin, player.vehicle.origin) < vehicledist) {
        shoulddetonate = 1;
      }
    }

    if(shoulddetonate) {
      break;
    }

    waitframe();
  }

  self notify("detonate");
}

function function_90ac39c3f9e0bc50(damage_data) {
  if(isDefined(damage_data.meansofdeath)) {
    if(isexplosivedamagemod(damage_data.meansofdeath)) {
      scripts\common\vehicle::vehicle_kill(damage_data.attacker);
    } else if(isbulletdamage(damage_data.meansofdeath)) {
      return 5;
    }
  }

  return damage_data.damage;
}

function function_8fe1775245b13b6f(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      missiletarget.flaresreservecount--;
      missiletarget thread function_c0afe8bb86f32d06(fxtagoverride);
      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      self.var_afcd53cfa79abccf = 1;
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      level notify("flares", player);
      return;
    }

    waitframe();
  }
}

function function_c0afe8bb86f32d06(fxtagoverride) {
  flarestag = "tag_origin";

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  playsoundatpos(self gettagorigin(flarestag), "ks_ac130_flares");
  playFXOnTag(getfx("gunship_flares"), self, flarestag);
}

function function_5eb66c5c1382fed() {
  self endon("death");

  if(istrue(self.var_c1e02d477104abd0)) {
    return;
  }

  self notify("flyaway");
  self.var_c1e02d477104abd0 = 1;
  self setvehgoalpos(self.exitnode.origin, 1);
  self vehicle_setspeed(80, 25, 25);
  self waittill("near_goal");
  scripts\common\vehicle_code::vehicle_deathcleanup();

  foreach(gunner in self.gunners) {
    gunner.nocorpse = 1;
    gunner scripts\mp\ai_mp_controller::function_28b90eb2b591003f();
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_death(self);
}

function private function_93b8918609703560() {
  alive = 0;

  foreach(gunner in self.gunners) {
    if(!isDefined(gunner) || !isalive(gunner)) {
      continue;
    }

    alive++;
  }

  return alive == 0;
}

function private function_3ab365a3526e539(point, numpositions, pathradius) {
  var_a1ae74a22938014d = 360 / numpositions;
  positions = [];
  fwd = (1, 0, 0);
  i = 0;

  while(i < 360) {
    altforward = fwd * pathradius;
    rotatedfwd = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
    pos = point + rotatedfwd;
    position = spawnStruct();
    position.origin = pos;
    z = position function_8c04a86613702b7d();
    position.origin = (position.origin[0], position.origin[1], z);
    positions[positions.size] = position;
    i += var_a1ae74a22938014d;
  }

  return positions;
}

function private function_8c04a86613702b7d() {
  heliheight = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 800);
  return heliheight[2];
}

function private function_a051d3cda138645(goal_pos, stopatgoal, vehicle) {
  self endon("death");
  self endon("flyaway");
  self endon("circle");
  self notify("gotopos");
  self endon("gotopos");
  path = function_30401425c3d8874f(goal_pos, vehicle);

  foreach(index, node in path) {
    if(index == path.size - 1) {
      self setvehgoalpos(node, stopatgoal);
    } else {
      self setvehgoalpos(node);
    }

    self waittill("near_goal");
  }
}

function private function_30401425c3d8874f(goal_pos, vehicle) {
  path = [];
  dir = vectortoangles(goal_pos - self.origin);
  fwd = anglesToForward(dir);
  dist = length(self.origin - goal_pos);

  if(dist > 250) {
    steps = dist / 250;

    for(i = 1; i < steps; i++) {
      if(i > 5) {
        break;
      }

      fwddist = i * 250;
      newpos = self.origin + fwd * fwddist;
      placedstruct = function_57dd2a79f8ad4fee(newpos);

      if(isDefined(placedstruct)) {
        path[path.size] = placedstruct.origin;
        continue;
      }

      ignored_ents = self.gunners;
      ignored_ents[ignored_ents.size] = self;
      trace = scripts\engine\trace::ray_trace(newpos + (0, 0, 1000), newpos + (0, 0, -10000), ignored_ents, undefined, undefined, 1, 1);
      pos = getgroundposition(trace["position"] + (0, 0, 800), 32, 2000, 100);
      path[path.size] = pos + (0, 0, 800);

      if(isDefined(vehicle) && isalive(vehicle)) {
        if(path[path.size - 1][2] < vehicle.origin[2]) {
          path[path.size - 1] = (path[path.size - 1][0], path[path.size - 1][1], vehicle.origin[2]) + (0, 0, 800);
        }
      }
    }
  }

  if(isDefined(vehicle) && isalive(vehicle)) {
    if(goal_pos[2] < vehicle.origin[2]) {
      path[path.size] = (goal_pos[0], goal_pos[1], vehicle.origin[2]) + (0, 0, 800);
    }
  } else {
    path[path.size] = goal_pos;
  }

  path = function_521e6d5a9479e771(path);
  return path;
}

function function_521e6d5a9479e771(path) {
  thresh = 100;

  foreach(index, node in path) {
    if(index == path.size - 1) {
      break;
    }

    diff = path[index + 1][2] - node[2];

    if(diff > thresh) {
      node += (0, 0, node[2] + diff / 2);
    }
  }

  return path;
}

function function_57dd2a79f8ad4fee(pos) {
  if(!isDefined(level.var_6b278dce447d6034)) {
    return undefined;
  }

  closest = getclosest(pos, level.var_6b278dce447d6034);

  if(isDefined(closest) && distancesquared(closest.origin, pos) <= squared(closest.radius)) {
    return closest;
  }

  return undefined;
}