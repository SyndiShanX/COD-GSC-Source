/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_incendiary.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\entityheadicons_shared;
#using scripts\shared\killcam_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#using scripts\shared\weapons\_weaponobjects;
#namespace incendiary;

function autoexec __init__sytem__() {
  system::register("incendiary_grenade", &init_shared, undefined, undefined);
}

function init_shared() {
  level.incendiaryfiredamage = getdvarint("scr_incendiaryfireDamage", 35);
  level.incendiaryfiredamagehardcore = getdvarint("scr_incendiaryfireDamageHardcore", 15);
  level.incendiaryfireduration = getdvarint("scr_incendiaryfireDuration", 5);
  level.incendiaryfxduration = getdvarfloat("scr_incendiaryfxDuration", 0.4);
  level.incendiarydamageradius = getdvarint("scr_incendiaryDamageRadius", 125);
  level.incendiaryfiredamageticktime = getdvarfloat("scr_incendiaryfireDamageTickTime", 1);
  level.incendiarydamagethistick = [];
  callback::on_spawned(&create_incendiary_watcher);
}

function updateincendiaryfromdvars() {
  level.incendiaryfiredamage = getdvarint("", level.incendiaryfiredamage);
  level.incendiaryfiredamagehardcore = getdvarint("", level.incendiaryfiredamagehardcore);
  level.incendiaryfireduration = getdvarint("", level.incendiaryfireduration);
  level.incendiarydamageradius = getdvarint("", level.incendiarydamageradius);
  level.incendiaryfiredamageticktime = getdvarfloat("", level.incendiaryfiredamageticktime);
  level.incendiaryfxduration = getdvarfloat("", level.incendiaryfxduration);
}

function create_incendiary_watcher() {
  watcher = self weaponobjects::createuseweaponobjectwatcher("incendiary_grenade", self.team);
  watcher.onspawn = &incendiary_system_spawn;
}

function incendiary_system_spawn(watcher, player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  player addweaponstat(self.weapon, "used", 1);
  thread watchforexplode(player);
}

function watchforexplode(owner) {
  self endon("hacked");
  self endon("delete");
  killcament = spawn("script_model", self.origin);
  killcament util::deleteaftertime(15);
  killcament.starttime = gettime();
  killcament linkto(self);
  killcament setweapon(self.weapon);
  killcament killcam::store_killcam_entity_on_entity(self);
  self waittill("projectile_impact_explode", origin, normal, surface);
  killcament unlink();
  updateincendiaryfromdvars();
  playsoundatposition("wpn_incendiary_core_start", self.origin);
  generatelocations(origin, owner, normal, killcament);
}

function getstepoutdistance(normal) {
  if(normal[2] < 0.5) {
    stepoutdistance = normal * getdvarint("scr_incendiary_stepout_wall", 50);
  } else {
    stepoutdistance = normal * getdvarint("scr_incendiary_stepout_ground", 12);
  }
  return stepoutdistance;
}

function generatelocations(position, owner, normal, killcament) {
  startpos = position + getstepoutdistance(normal);
  desiredendpos = startpos + vectorscale((0, 0, 1), 60);
  phystrace = physicstrace(startpos, desiredendpos, vectorscale((-1, -1, -1), 4), vectorscale((1, 1, 1), 4), self, 1);
  goalpos = (phystrace["fraction"] < 1 ? phystrace["position"] : desiredendpos);
  killcament moveto(goalpos, 0.5);
  rotation = randomint(360);
  if(normal[2] < 0.1) {
    black = vectorscale((1, 1, 1), 0.1);
    trace = hitpos(startpos, (startpos + ((normal * -1) * 70)) + ((0, 0, -1) * 70), black);
    traceposition = trace["position"];
    incendiarygrenade = getweapon("incendiary_fire");
    if(trace["fraction"] < 0.9) {
      wallnormal = trace["normal"];
      spawntimedfx(incendiarygrenade, trace["position"], wallnormal, level.incendiaryfireduration, self.team);
    }
  }
  fxcount = getdvarint("scr_incendiary_fx_count", 6);
  spawnalllocs(owner, startpos, normal, 1, rotation, killcament, fxcount);
}

function getlocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
  currentangle = (360 / fxcount) * fxindex;
  coscurrent = cos(currentangle + rotation);
  sincurrent = sin(currentangle + rotation);
  return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

function spawnalllocs(owner, startpos, normal, multiplier, rotation, killcament, fxcount) {
  defaultdistance = getdvarint("scr_incendiary_trace_distance", 220) * multiplier;
  defaultdropdistance = getdvarint("scr_incendiary_trace_down_distance", 90);
  colorarray = [];
  colorarray[colorarray.size] = (0.9, 0.2, 0.2);
  colorarray[colorarray.size] = (0.2, 0.9, 0.2);
  colorarray[colorarray.size] = (0.2, 0.2, 0.9);
  colorarray[colorarray.size] = vectorscale((1, 1, 1), 0.9);
  locations = [];
  locations["color"] = [];
  locations["loc"] = [];
  locations["tracePos"] = [];
  locations["distSqrd"] = [];
  locations["fxtoplay"] = [];
  locations["radius"] = [];
  for(fxindex = 0; fxindex < fxcount; fxindex++) {
    locations["point"][fxindex] = getlocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation);
    locations["color"][fxindex] = colorarray[fxindex % colorarray.size];
  }
  for(count = 0; count < fxcount; count++) {
    trace = hitpos(startpos, locations["point"][count], locations["color"][count]);
    traceposition = trace["position"];
    locations["tracePos"][count] = traceposition;
    if(trace["fraction"] < 0.7) {
      locations["loc"][count] = traceposition;
      locations["normal"][count] = trace["normal"];
      continue;
    }
    average = (startpos / 2) + (traceposition / 2);
    trace = hitpos(average, average - (0, 0, defaultdropdistance), locations["color"][count]);
    if(trace["fraction"] != 1) {
      locations["loc"][count] = trace["position"];
      locations["normal"][count] = trace["normal"];
    }
  }
  incendiarygrenade = getweapon("incendiary_fire");
  spawntimedfx(incendiarygrenade, startpos, normal, level.incendiaryfireduration, self.team);
  level.incendiarydamageradius = getdvarint("scr_incendiaryDamageRadius", level.incendiarydamageradius);
  thread damageeffectarea(owner, startpos, level.incendiarydamageradius, level.incendiarydamageradius, killcament);
  for(count = 0; count < locations["point"].size; count++) {
    if(isDefined(locations["loc"][count])) {
      normal = locations["normal"][count];
      spawntimedfx(incendiarygrenade, locations["loc"][count], normal, level.incendiaryfireduration, self.team);
    }
  }
}

function incendiary_debug_line(from, to, color, depthtest, time) {
  debug_rcbomb = getdvarint("", 0);
  if(debug_rcbomb == 1) {
    if(!isDefined(time)) {
      time = 100;
    }
    if(!isDefined(depthtest)) {
      depthtest = 1;
    }
    line(from, to, color, 1, depthtest, time);
  }
}

function damageeffectarea(owner, position, radius, height, killcament) {
  trigger_radius_position = position - (0, 0, height);
  trigger_radius_height = height * 2;
  fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
  if(getdvarint("")) {
    level thread util::drawcylinder(trigger_radius_position, radius, trigger_radius_height, undefined, "");
  }
  if(isDefined(level.rapsonburnraps)) {
    owner thread[[level.rapsonburnraps]](fireeffectarea);
  }
  var_5686ecd0 = owner.team;
  loopwaittime = level.incendiaryfiredamageticktime;
  durationofincendiary = level.incendiaryfireduration;
  while(durationofincendiary > 0) {
    if(isDefined(owner) && owner.team !== var_5686ecd0) {
      break;
    }
    durationofincendiary = durationofincendiary - loopwaittime;
    damageapplied = 0;
    potential_targets = self getpotentialtargets(owner);
    foreach(target in potential_targets) {
      self trytoapplyfiredamage(target, owner, position, fireeffectarea, loopwaittime, killcament);
    }
    wait(loopwaittime);
  }
  if(isDefined(killcament)) {
    killcament entityheadicons::destroyentityheadicons();
  }
  fireeffectarea delete();
  if(getdvarint("")) {
    level notify("incendiary_draw_cylinder_stop");
  }
}

function getpotentialtargets(owner) {
  owner_team = (isDefined(owner) ? owner.team : undefined);
  if(level.teambased && isDefined(owner_team) && level.friendlyfire == 0) {
    enemy_team = (owner_team == "axis" ? "allies" : "axis");
    potential_targets = [];
    potential_targets = arraycombine(potential_targets, getplayers(enemy_team), 0, 0);
    potential_targets = arraycombine(potential_targets, getaiteamarray(enemy_team), 0, 0);
    potential_targets = arraycombine(potential_targets, getvehicleteamarray(enemy_team), 0, 0);
    potential_targets[potential_targets.size] = owner;
    return potential_targets;
  }
  all_targets = [];
  all_targets = arraycombine(all_targets, level.players, 0, 0);
  all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
  all_targets = arraycombine(all_targets, getvehiclearray(), 0, 0);
  if(level.friendlyfire > 0) {
    return all_targets;
  }
  potential_targets = [];
  foreach(target in all_targets) {
    if(!isDefined(target)) {
      continue;
    }
    if(!isDefined(target.team)) {
      continue;
    }
    if(isDefined(owner)) {
      if(target != owner) {
        if(!isDefined(owner_team)) {
          continue;
        }
        if(target.team == owner_team) {
          continue;
        }
      }
    } else {
      if(!isDefined(self)) {
        continue;
      }
      if(!isDefined(self.team)) {
        continue;
      }
      if(target.team == self.team) {
        continue;
      }
    }
    potential_targets[potential_targets.size] = target;
  }
  return potential_targets;
}

function trytoapplyfiredamage(target, owner, position, fireeffectarea, resetfiretime, killcament) {
  if(!isDefined(target.infirearea) || target.infirearea == 0) {
    if(target istouching(fireeffectarea) && (!isDefined(target.sessionstate) || target.sessionstate == "playing")) {
      trace = bulletTrace(position, target getshootatpos(), 0, target, 1);
      if(trace["fraction"] == 1) {
        target.lastburnedby = owner;
        target thread damageinfirearea(fireeffectarea, killcament, trace, position, resetfiretime);
      }
    }
  }
}

function damageinfirearea(fireeffectarea, killcament, trace, position, resetfiretime) {
  self endon("disconnect");
  self endon("death");
  timer = 0;
  damage = level.incendiaryfiredamage;
  if(level.hardcoremode) {
    damage = level.incendiaryfiredamagehardcore;
  }
  if(candofiredamage(killcament, self, resetfiretime)) {
    level.incendiary_debug = getdvarint("", 0);
    if(level.incendiary_debug) {
      if(!isDefined(level.incendiarydamagetime)) {
        level.incendiarydamagetime = gettime();
      }
      iprintlnbold(level.incendiarydamagetime - gettime());
      level.incendiarydamagetime = gettime();
    }
    self dodamage(damage, fireeffectarea.origin, self.lastburnedby, killcament, "none", "MOD_BURNED", 0, getweapon("incendiary_fire"));
    entnum = self getentitynumber();
    self thread sndfiredamage();
  }
}

function sndfiredamage() {
  self notify("sndfire");
  self endon("death");
  self endon("disconnect");
  self endon("sndfire");
  if(!isDefined(self.sndfireent)) {
    self.sndfireent = spawn("script_origin", self.origin);
    self.sndfireent linkto(self, "tag_origin");
    self.sndfireent playSound("chr_burn_start");
    self thread sndfiredamage_deleteent(self.sndfireent);
  }
  self.sndfireent playLoopSound("chr_burn_start_loop", 0.5);
  wait(3);
  self.sndfireent delete();
  self.sndfireent = undefined;
}

function sndfiredamage_deleteent(ent) {
  self endon("disconnect");
  self waittill("death");
  if(isDefined(ent)) {
    ent delete();
  }
}

function hitpos(start, end, color) {
  trace = bulletTrace(start, end, 0, undefined);
  level.incendiary_debug = getdvarint("", 0);
  if(level.incendiary_debug) {
    debugstar(trace[""], 2000, color);
  }
  thread incendiary_debug_line(start, trace[""], color, 1, 80);
  return trace;
}

function candofiredamage(killcament, victim, resetfiretime) {
  entnum = victim getentitynumber();
  if(!isDefined(level.incendiarydamagethistick[entnum])) {
    level.incendiarydamagethistick[entnum] = 0;
    level thread resetfiredamage(entnum, resetfiretime);
    return true;
  }
  return false;
}

function resetfiredamage(entnum, time) {
  if(time > 0.05) {
    wait(time - 0.05);
  }
  level.incendiarydamagethistick[entnum] = undefined;
}