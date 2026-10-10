/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\helicopter.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace helicopter;

function init() {
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["jet_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_harrier_angel_flares.vfx");

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level thread getaveragelowspawnpoint();
  }
}

function getaveragelowspawnpoint() {
  spawnpoints = scripts\mp\spawnlogic::function_32d25b070a9516de(getspawnarray("mp_tdm_spawn_allies_start"));
  count = 0;
  totalz = 0;

  foreach(point in spawnpoints) {
    count++;
    totalz += point.origin[2];
  }

  if(count > 0) {
    level.averagealliesz = totalz / count;
    return;
  }

  level.averagealliesz = 0;
}

function makehelitype(helitype, deathfx, lightfxfunc) {
  level.chopper_fx["explode"]["death"][helitype] = loadfx(deathfx);
  level.lightfxfunc[helitype] = lightfxfunc;
}

function addairexplosion(helitype, explodefx) {
  level.chopper_fx["explode"]["air_death"][helitype] = loadfx(explodefx);
}

function defaultlightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

function usehelicopter(lifeid, streakname) {
  return tryusehelicopter(lifeid, "helicopter");
}

function tryusehelicopter(lifeid, helitype) {
  var_4440147083abaf0a = 1;

  if(isDefined(level.chopper)) {
    shouldqueue = 1;
  } else {
    shouldqueue = 0;
  }

  if(isDefined(level.chopper) && shouldqueue) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");

    if(isDefined(helitype) && helitype != "helicopter") {
      streakname = "helicopter_" + helitype;
    } else {
      streakname = "helicopter";
    }

    queueent = spawn("script_origin", (0, 0, 0));
    queueent hide();
    queueent thread deleteonentnotify(self, "disconnect");
    queueent.player = self;
    queueent.lifeid = lifeid;
    queueent.helitype = helitype;
    queueent.streakname = streakname;
    queueadd("helicopter", queueent);
    return false;
  } else if(currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  var_4440147083abaf0a = 1;
  starthelicopter(lifeid, helitype);
  return true;
}

function deleteonentnotify(ent, notifystring) {
  self endon("death");
  ent waittill(notifystring);
  self delete();
}

function starthelicopter(lifeid, helitype) {
  incrementfauxvehiclecount();
  startnode = undefined;

  if(!isDefined(helitype)) {
    helitype = "";
  }

  eventtype = "helicopter";
  team = self.pers["team"];
  startnode = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
  utility::trycall(level.matchdata_logkillstreakevent, eventtype, self.origin);
  thread heli_think(lifeid, self, startnode, self.pers["team"], helitype);
}

function precachehelicoptersounds() {
  level.heli_sound["allies"]["hit"] = "veh_chopper_support_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "veh_chopper_support_hit";
  level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

function heli_getteamforsoundclip() {
  teamname = self.team;

  if(level.multiteambased) {
    teamname = "axis";
  }

  return teamname;
}

function spawn_helicopter(owner, origin, angles, vehicletype, modelname) {
  chopper = spawnhelicopter(owner, origin, angles, vehicletype, modelname);

  if(!isDefined(chopper)) {
    return undefined;
  }

  if(modelname == "vehicle_battle_hind") {
    chopper.heli_type = "cobra";
  } else {
    chopper.heli_type = level.heli_types[modelname];
  }

  chopper thread[[level.lightfxfunc[chopper.heli_type]]]();
  chopper addtohelilist(chopper getentitynumber());
  chopper.zoffset = (0, 0, chopper gettagorigin("tag_origin")[2] - chopper gettagorigin("tag_ground")[2]);
  chopper.attractor = missile_createattractorent(chopper, level.heli_attract_strength, level.heli_attract_range);
  return chopper;
}

function helidialog(dialoggroup) {
  if(gettime() - level.lasthelidialogtime < 6000) {
    return;
  }

  level.lasthelidialogtime = gettime();
  randomindex = randomint(level.helidialog[dialoggroup].size);
  soundalias = level.helidialog[dialoggroup][randomindex];
  fullsoundalias = getteamvoiceinfix(self.team) + "tl" + soundalias;
  self playlocalsound(fullsoundalias);
}

function updateareanodes(areanodes) {
  validenemies = [];

  foreach(node in areanodes) {
    node.validplayers = [];
    node.nodescore = 0;
  }

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(player.team == self.team) {
      continue;
    }

    foreach(node in areanodes) {
      if(distancesquared(player.origin, node.origin) > 1048576) {
        continue;
      }

      node.validplayers[node.validplayers.size] = player;
    }
  }

  bestnode = areanodes[0];

  foreach(node in areanodes) {
    helinode = getEnt(node.target, "targetname");

    foreach(player in node.validplayers) {
      node.nodescore += 1;

      if(scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), helinode.origin, 0, player)) {
        node.nodescore += 3;
      }
    }

    if(node.nodescore > bestnode.nodescore) {
      bestnode = node;
    }
  }

  return getEnt(bestnode.target, "targetname");
}

function heli_think(lifeid, owner, startnode, heli_team, helitype) {
  heliorigin = startnode.origin;
  heliangles = startnode.angles;
  vehicletype = "cobra_mp";
  vehiclemodel = "vehicle_battle_hind";
  chopper = spawn_helicopter(owner, heliorigin, heliangles, vehicletype, vehiclemodel);

  if(!isDefined(chopper)) {
    return;
  }

  level.chopper = chopper;

  if(heli_team == "allies") {
    level.allieschopper = chopper;
  } else {
    level.axischopper = chopper;
  }

  chopper.helitype = helitype;
  chopper.lifeid = lifeid;
  chopper.team = heli_team;
  chopper.pers["team"] = heli_team;
  chopper.owner = owner;
  chopper setotherent(owner);
  chopper.startnode = startnode;
  chopper.maxhealth = level.heli_maxhealth;
  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primarytarget = undefined;
  chopper.secondarytarget = undefined;
  chopper.attacker = undefined;
  chopper.currentstate = "ok";
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  chopper.empgrenaded = 0;

  if(helitype == "flares" || helitype == "minigun") {
    chopper thread scripts\mp\killstreaks\flares::flares_monitor(1);
  }

  chopper thread heli_leave_on_disconnect(owner);
  chopper thread heli_leave_on_changeteams(owner);
  chopper thread heli_leave_on_gameended(owner);
  chopper thread heli_damage_monitor(helitype);
  chopper thread heli_watchempdamage();
  chopper thread heli_watchdeath();
  chopper thread heli_existance();
  chopper endon("helicopter_done");
  chopper endon("crashing");
  chopper endon("leaving");
  chopper endon("death");
  attackareas = getEntArray("heli_attack_area", "targetname");
  loopnode = undefined;
  loopnode = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  chopper heli_fly_simple_path(startnode);
  chopper thread heli_targeting();
  chopper thread heli_leave_on_timeout(60);
  chopper thread heli_fly_loop_path(loopnode);
}

function heli_existance() {
  entitynumber = self getentitynumber();
  waittill_any_3("death", "crashing", "leaving");
  removefromhelilist(entitynumber);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  player = undefined;
  queueent = queueremovefirst("helicopter");

  if(!isDefined(queueent)) {
    level.chopper = undefined;
    return;
  }

  player = queueent.player;
  lifeid = queueent.lifeid;
  streakname = queueent.streakname;
  helitype = queueent.helitype;
  queueent delete();

  if(isDefined(player) && (player.sessionstate == "playing" || player.sessionstate == "dead")) {
    player starthelicopter(lifeid, helitype);
    return;
  }

  level.chopper = undefined;
}

function heli_targeting() {
  self notify("heli_targeting");
  self endon("heli_targeting");
  self endon("death");
  self endon("helicopter_done");

  for(;;) {
    targets = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;

    foreach(player in level.characters) {
      wait 0.05;

      if(!cantarget_turret(player)) {
        continue;
      }

      targets[targets.size] = player;
    }

    if(targets.size) {
      for(targetplayer = getbestprimarytarget(targets); !isDefined(targetplayer); targetplayer = getbestprimarytarget(targets)) {
        waitframe();
      }

      self.primarytarget = targetplayer;
      self notify("primary acquired");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait 0.25;
  }
}

function cantarget_turret(player) {
  cantarget = 1;

  if(!isalive(player) || isDefined(player.sessionstate) && player.sessionstate != "playing") {
    return 0;
  }

  if(distance(player.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }

  if(!self.owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
    return 0;
  }

  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(player _hasperk("specialty_blindeye")) {
    return 0;
  }

  heli_centroid = self.origin + (0, 0, -160);
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + 144 * heli_forward_norm;

  if(player sightconetrace(heli_turret_point, self) < level.heli_target_recognition) {
    return 0;
  }

  return cantarget;
}

function getbestprimarytarget(targets) {
  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }

    update_player_threat(player);
  }

  highest = 0;
  primarytarget = undefined;
  corners = getEntArray("minimap_corner", "targetname");

  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }

    assertex(isDefined(player.threatlevel), "<dev string:x1c>");

    if(corners.size == 2) {
      min = corners[0].origin;
      max = corners[0].origin;

      if(corners[1].origin[0] > max[0]) {
        max = (corners[1].origin[0], max[1], max[2]);
      } else {
        min = (corners[1].origin[0], min[1], min[2]);
      }

      if(corners[1].origin[1] > max[1]) {
        max = (max[0], corners[1].origin[1], max[2]);
      } else {
        min = (min[0], corners[1].origin[1], min[2]);
      }

      if(player.origin[0] < min[0] || player.origin[0] > max[0] || player.origin[1] < min[1] || player.origin[1] > max[1]) {
        continue;
      }
    }

    if(player.threatlevel < highest) {
      continue;
    }

    if(!scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    highest = player.threatlevel;
    primarytarget = player;
  }

  return primarytarget;
}

function update_player_threat(player) {
  player.threatlevel = 0;
  dist = distance(player.origin, self.origin);
  player.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;

  if(isDefined(self.attacker) && player == self.attacker) {
    player.threatlevel += 100;
  }

  if(isPlayer(player)) {
    player.threatlevel += player.score * 4;
  }

  if(isDefined(player.antithreat)) {
    player.threatlevel -= player.antithreat;
  }

  if(player.threatlevel <= 0) {
    player.threatlevel = 1;
  }
}

function heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self vehicle_setspeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

function addrecentdamage(damage) {
  self endon("death");
  self.recentdamageamount += damage;
  wait 4;
  self.recentdamageamount -= damage;
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  var_cb15fa5174e71840 = 2;
  var_be7c04516c5d9ccd = 3;
  var_ca960a517459fe15 = 4;

  if(isDefined(self.helitype) && self.helitype == "dronedrop") {
    var_cb15fa5174e71840 = 1;
    var_be7c04516c5d9ccd = 1;
    var_ca960a517459fe15 = 2;
  }

  modifieddamage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, type, modifieddamage, self.maxhealth, var_cb15fa5174e71840, var_be7c04516c5d9ccd, var_ca960a517459fe15);
  thread addrecentdamage(modifieddamage);
  self notify("heli_damage_fx");
  return modifieddamage;
}

function handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(attacker)) {
    config = level.heliconfigs[self.streakname];
    notifyattacker = scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout);

    if(notifyattacker) {
      attacker notify("destroyed_helicopter");
      self.killingattacker = attacker;
    }
  }
}

function heli_damage_monitor(type, shouldrumble, var_a39ff9e13bbc6340) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = type;
  self.recentdamageamount = 0;

  if(!istrue(var_a39ff9e13bbc6340)) {
    thread heli_health();
  }

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", &handledeathdamage, &modifydamage, 1, shouldrumble);
}

function heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);
    self.empgrenaded = 1;

    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("stop_shooting");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("stop_shooting");
    }

    wait duration;
    self.empgrenaded = 0;

    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("turretstatechange");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("turretstatechange");
    }
  }
}

function heli_health() {
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);
  damagestate = 3;
  self setdamagestage(damagestate);
  config = level.heliconfigs[self.streakname];

  while(true) {
    self waittill("heli_damage_fx");

    if(damagestate > 0 && self.damagetaken >= self.maxhealth) {
      damagestate = 0;
      self setdamagestage(damagestate);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.enginevfxtag);
      self notify("death");
      break;
    }

    if(damagestate > 1 && self.damagetaken >= self.maxhealth * 0.66) {
      damagestate = 1;
      self setdamagestage(damagestate);
      self.currentstate = "heavy smoke";
      stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.enginevfxtag);
      playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.enginevfxtag);
      continue;
    }

    if(damagestate > 2 && self.damagetaken >= self.maxhealth * 0.33) {
      damagestate = 2;
      self setdamagestage(damagestate);
      self.currentstate = "light smoke";
      playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.enginevfxtag);
    }
  }
}

function heli_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage) {
    thread heli_explode(1);
    return;
  }

  config = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, config.enginevfxtag);
  thread heli_crash();
}

function heli_crash() {
  self notify("crashing");
  self clearlookatent();
  crashnode = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(crashnode);
  thread heli_explode();
}

function heli_secondary_explosions() {
  teamname = heli_getteamforsoundclip();
  config = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.enginevfxtag);
  self playSound(level.heli_sound[teamname]["hitsecondary"]);
  wait 3;

  if(!isDefined(self)) {
    return;
  }

  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.enginevfxtag);
  self playSound(level.heli_sound[teamname]["hitsecondary"]);
}

function heli_spin(speed) {
  self endon("death");
  teamname = heli_getteamforsoundclip();
  self playSound(level.heli_sound[teamname]["hit"]);
  thread spinsoundshortly();
  self setyawspeed(speed, speed, speed);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.9);
    wait 1;
  }
}

function spinsoundshortly() {
  self endon("death");
  wait 0.25;
  teamname = heli_getteamforsoundclip();
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level.heli_sound[teamname]["spinloop"]);
  wait 0.05;
  self playLoopSound(level.heli_sound[teamname]["spinstart"]);
}

function heli_explode(altstyle) {
  self notify("death");

  if(isDefined(altstyle) && isDefined(level.chopper_fx["explode"]["air_death"][self.heli_type])) {
    deathangles = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.heli_type], self gettagorigin("tag_deathfx"), anglesToForward(deathangles), anglestoup(deathangles));
  } else {
    org = self.origin;
    forward = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.heli_type], org, forward);
  }

  teamname = heli_getteamforsoundclip();
  self playSound(level.heli_sound[teamname]["crash"]);
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  decrementfauxvehiclecount();
  self delete();
}

function check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread heli_leave();
    return false;
  }

  return true;
}

function heli_leave_on_disconnect(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner waittill("disconnect");
  thread heli_leave();
}

function heli_leave_on_changeteams(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner waittill_any_2("joined_team", "joined_spectators");
  thread heli_leave();
}

function heli_leave_on_spawned(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner waittill("spawned");
  thread heli_leave();
}

function heli_leave_on_gameended(owner) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

function heli_leave_on_timeout(timeout) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeout);
  thread heli_leave();
}

function fireontarget(targetplayer) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_f8819918db5085ef = 15;
  loopscount = 0;
  totalheight = 0;

  foreach(node in level.heli_loop_nodes) {
    loopscount++;
    totalheight += node.origin[2];
  }

  var_9b53fc8fa63d4127 = totalheight / loopscount;
  self notify("newTarget");

  if(isDefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth) {
    return;
  }

  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }

  currenttarget = self.primarytarget;
  currenttarget.antithreat = 0;
  var_bbe89bb08d4aaa08 = self.primarytarget.origin * (1, 1, 0);
  var_4bb61811b9080546 = self.origin * (0, 0, 1);
  var_2a530280d4341a8a = var_bbe89bb08d4aaa08 + var_4bb61811b9080546;
  targetdistance2d = distance2d(self.origin, currenttarget.origin);

  if(targetdistance2d < 1000) {
    var_f8819918db5085ef = 600;
  }

  var_4a05b5b6307a4629 = anglesToForward(currenttarget.angles);
  var_4a05b5b6307a4629 *= (1, 1, 0);
  var_3f662d6595827e55 = var_2a530280d4341a8a + var_f8819918db5085ef * var_4a05b5b6307a4629;
  attackvector = var_3f662d6595827e55 - var_2a530280d4341a8a;
  attackangle = vectortoangles(attackvector);
  attackangle *= (1, 1, 0);
  thread attackgroundtarget(currenttarget);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, var_3f662d6595827e55) < 1000) {
    var_3f662d6595827e55 *= 1.5;
  }

  var_3f662d6595827e55 *= (1, 1, 0);
  var_3f662d6595827e55 += (0, 0, var_9b53fc8fa63d4127);
  _setvehgoalpos(var_3f662d6595827e55, 1, 1);
  self waittill("near_goal");

  if(!isDefined(currenttarget) || !isalive(currenttarget)) {
    return;
  }

  self setlookatent(currenttarget);
  thread isfacing(10, currenttarget);
  waittill_any_timeout_1(4, "facing");

  if(!isDefined(currenttarget) || !isalive(currenttarget)) {
    return;
  }

  self clearlookatent();
  var_1969616b8d0c188c = var_2a530280d4341a8a + var_f8819918db5085ef * anglesToForward(attackangle);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var_1969616b8d0c188c, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isDefined(currenttarget) && isalive(currenttarget)) {
    if(isDefined(currenttarget.antithreat)) {
      currenttarget.antithreat += 100;
    } else {
      currenttarget.antithreat = 100;
    }
  }

  waittill_any_timeout_1(3, "near_goal");
}

function attackgroundtarget(currenttarget) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetEnt(currenttarget);
  waitontargetordeath(currenttarget, 3);

  if(!isalive(currenttarget)) {
    self.isattacking = 0;
    return;
  }

  dist2dsq = distance2dsquared(self.origin, currenttarget.origin);

  if(dist2dsq < 640000) {
    thread dropbombs(currenttarget);
    self.isattacking = 0;
    return;
  }

  if(checkisfacing(50, currenttarget) && cointoss()) {
    thread firemissile(currenttarget);
    self.isattacking = 0;
    return;
  }

  weaponshoottime = weaponfiretime("cobra_20mm_mp");
  var_922819de2d68c5e7 = 0;
  loopsoundplaying = 0;

  for(i = 0; i < level.heli_turretclipsize; i++) {
    if(!isDefined(self)) {
      break;
    }

    if(self.empgrenaded) {
      break;
    }

    if(!isDefined(currenttarget)) {
      break;
    }

    if(!isalive(currenttarget)) {
      break;
    }

    if(self.damagetaken >= self.maxhealth) {
      continue;
    }

    if(!checkisfacing(55, currenttarget)) {
      self stoploopsound();
      loopsoundplaying = 0;
      wait weaponshoottime;
      i--;
      continue;
    }

    if(i < level.heli_turretclipsize - 1) {
      wait weaponshoottime;
    }

    if(!isDefined(currenttarget) || !isalive(currenttarget)) {
      break;
    }

    if(!loopsoundplaying) {
      self playLoopSound("weap_hind_20mm_fire_npc");
      loopsoundplaying = 1;
    }

    self setvehweapon("cobra_20mm_mp");
    self fireweapon("tag_flash", currenttarget);
  }

  if(!isDefined(self)) {
    return;
  }

  self stoploopsound();
  loopsoundplaying = 0;
  self.isattacking = 0;
}

function checkisfacing(tolerance, currenttarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance)) {
    tolerance = 10;
  }

  heliforwardvector = anglesToForward(self.angles);
  var_6d9d6722a1121a79 = currenttarget.origin - self.origin;
  heliforwardvector *= (1, 1, 0);
  var_6d9d6722a1121a79 *= (1, 1, 0);
  var_6d9d6722a1121a79 = vectorNormalize(var_6d9d6722a1121a79);
  heliforwardvector = vectorNormalize(heliforwardvector);
  targetcosine = vectordot(var_6d9d6722a1121a79, heliforwardvector);
  facingcosine = cos(tolerance);

  if(targetcosine >= facingcosine) {
    return 1;
  }

  return 0;
}

function isfacing(tolerance, currenttarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance)) {
    tolerance = 10;
  }

  while(isalive(currenttarget)) {
    heliforwardvector = anglesToForward(self.angles);
    var_6d9d6722a1121a79 = currenttarget.origin - self.origin;
    heliforwardvector *= (1, 1, 0);
    var_6d9d6722a1121a79 *= (1, 1, 0);
    var_6d9d6722a1121a79 = vectorNormalize(var_6d9d6722a1121a79);
    heliforwardvector = vectorNormalize(heliforwardvector);
    targetcosine = vectordot(var_6d9d6722a1121a79, heliforwardvector);
    facingcosine = cos(tolerance);

    if(targetcosine >= facingcosine) {
      self notify("facing");
      break;
    }

    wait 0.1;
  }
}

function waitontargetordeath(target, timeout) {
  self endon("death");
  self endon("helicopter_done");
  target endon("death_or_disconnect");
  waittill_notify_or_timeout("turret_on_target", timeout);
}

function firemissile(missiletarget) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  assert(self.health > 0);
  var_585f84a1c35d91b1 = 2;

  for(i = 0; i < var_585f84a1c35d91b1; i++) {
    if(!isDefined(missiletarget)) {
      return;
    }

    if(cointoss()) {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_right") - (0, 0, 64), missiletarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_left") - (0, 0, 64), missiletarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    missile missile_settargetEnt(missiletarget);
    missile.owner = self;
    missile missile_setflightmodedirect();
    wait 0.5 / var_585f84a1c35d91b1;
  }
}

function dropbombs(missiletarget) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(missiletarget)) {
    return;
  }

  for(i = 0; i < randomintrange(2, 5); i++) {
    if(cointoss()) {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_left") - (0, 0, 45), missiletarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_right") - (0, 0, 45), missiletarget.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    wait randomfloatrange(0.35, 0.65);
  }
}

function getoriginoffsets(goalnode) {
  startorigin = self.origin;
  endorigin = goalnode.origin;
  numtraces = 0;
  maxtraces = 40;
  traceoffset = (0, 0, -196);

  for(traceorigin = scripts\engine\trace::_bullet_trace(startorigin + traceoffset, endorigin + traceoffset, 0, self); distancesquared(traceorigin["position"], endorigin + traceoffset) > 10 && numtraces < maxtraces; traceorigin = scripts\engine\trace::_bullet_trace(startorigin + traceoffset, endorigin + traceoffset, 0, self)) {
    println("<dev string:x48>" + distancesquared(traceorigin["<dev string:x5a>"], endorigin + traceoffset));

    if(startorigin[2] < endorigin[2]) {
      startorigin += (0, 0, 128);
    } else if(startorigin[2] > endorigin[2]) {
      endorigin += (0, 0, 128);
    } else {
      startorigin += (0, 0, 128);
      endorigin += (0, 0, 128);
    }

    numtraces++;
  }

  offsets = [];
  offsets["start"] = startorigin;
  offsets["end"] = endorigin;
  return offsets;
}

function traveltonode(goalnode) {
  originoffets = getoriginoffsets(goalnode);

  if(originoffets["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(originoffets["start"] + (0, 0, 30), 0);
    self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(originoffets["end"] != goalnode.origin) {
    if(isDefined(goalnode.script_airspeed) && isDefined(goalnode.script_accel)) {
      heli_speed = goalnode.script_airspeed;
      heli_accel = goalnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(originoffets["end"] + (0, 0, 30), 0);
    self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }
}

function _setvehgoalpos(goalposition, shouldstop, adheretomesh) {
  if(!isDefined(shouldstop)) {
    shouldstop = 0;
  }

  adheretomesh = 0;

  if(adheretomesh) {
    thread _setvehgoalposadheretomesh(goalposition, shouldstop);
    return;
  }

  self setvehgoalpos(goalposition, shouldstop);
}

function _setvehgoalposadheretomesh(goalposition, shouldstop) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  finalgoalposition = goalposition;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(distance_2d_squared(self.origin, finalgoalposition) < 65536) {
      self setvehgoalpos(finalgoalposition, shouldstop);
      println("<dev string:x66>");
      break;
    }

    vecangles = vectortoangles(finalgoalposition - self.origin);
    vecforward = anglesToForward(vecangles);
    var_7a7eaf576c2dcc51 = self.origin + vecforward * (1, 1, 0) * 250;
    traceoffset = (0, 0, 2500);
    tracestart = var_7a7eaf576c2dcc51 + gethelipilotmeshoffset() + traceoffset;
    traceend = var_7a7eaf576c2dcc51 + gethelipilotmeshoffset() - traceoffset;
    tracepos = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, self, 0, 0, 1);
    microgoalposition = tracepos;

    if(isDefined(tracepos["entity"]) && tracepos["entity"] == self && tracepos["normal"][2] > 0.1) {
      traceposz = tracepos["position"][2] - 4400;
      zchange = traceposz - self.origin[2];

      if(zchange > 256) {
        tracepos["position"] = tracepos["position"] * (1, 1, 0);
        tracepos["position"] = tracepos["position"] + (0, 0, self.origin[2] + 256);
      } else if(zchange < -256) {
        tracepos["position"] = tracepos["position"] * (1, 1, 0);
        tracepos["position"] = tracepos["position"] + (0, 0, self.origin[2] - 256);
      }

      microgoalposition = tracepos["position"] - gethelipilotmeshoffset() + (0, 0, 600);
    } else {
      microgoalposition = finalgoalposition;
    }

    self setvehgoalpos(microgoalposition, 0);
    wait 0.15;
  }
}

function heli_fly_simple_path(startnode) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();

  for(currentnode = startnode; isDefined(currentnode.target); currentnode = nextnode) {
    nextnode = getEnt(currentnode.target, "targetname");
    assertex(isDefined(nextnode), "<dev string:x83>" + currentnode.origin);

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      heli_speed = currentnode.script_airspeed;
      heli_accel = currentnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 15 + randomint(15);
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      waitframe();
      continue;
    }

    self vehicle_setspeed(75, 35);

    if(!isDefined(nextnode.target)) {
      _setvehgoalpos(nextnode.origin + self.zoffset, 1);
      self waittill("near_goal");
      continue;
    }

    _setvehgoalpos(nextnode.origin + self.zoffset, 0);
    self waittill("near_goal");
    self setgoalyaw(nextnode.angles[1]);
    self waittill("goal");
  }

  println(currentnode.origin);
  println(self.origin);
}

function heli_fly_loop_path(startnode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(startnode);

  for(currentnode = startnode; isDefined(currentnode.target); currentnode = nextnode) {
    nextnode = getEnt(currentnode.target, "targetname");
    assertex(isDefined(nextnode), "<dev string:x83>" + currentnode.origin);

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.25;
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait 0.1;
      continue;
    }

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      self.desired_speed = currentnode.script_airspeed;
      self.desired_accel = currentnode.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed *= 0.5;
      self.desired_accel *= 0.5;
    }

    if(isDefined(nextnode.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(nextnode.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait nextnode.script_delay;
      continue;
    }

    _setvehgoalpos(nextnode.origin + self.zoffset, 0, 1);
    self waittill("near_goal");
    self setgoalyaw(nextnode.angles[1]);
    self waittill("goal");
  }
}

function heli_loop_speed_control(currentnode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
    self.desired_speed = currentnode.script_airspeed;
    self.desired_accel = currentnode.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  lastspeed = 0;
  var_b1d46319aa26b913 = 0;

  while(true) {
    goalspeed = self.desired_speed;
    var_4c3fe0af18132696 = self.desired_accel;

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(self.helitype != "flares" && isDefined(self.primarytarget) && !heli_is_threatened()) {
      goalspeed *= 0.25;
    }

    if(lastspeed != goalspeed || var_b1d46319aa26b913 != var_4c3fe0af18132696) {
      self vehicle_setspeed(75, 35);
      lastspeed = goalspeed;
      var_b1d46319aa26b913 = var_4c3fe0af18132696;
    }

    wait 0.05;
  }
}

function heli_is_threatened() {
  if(self.recentdamageamount > 50) {
    return true;
  }

  if(self.currentstate == "heavy smoke") {
    return true;
  }

  return false;
}

function heli_fly_well(destnodes) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    currentnode = get_best_area_attack_node(destnodes);
    traveltonode(currentnode);

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      heli_speed = currentnode.script_airspeed;
      heli_accel = currentnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(currentnode.origin + self.zoffset, 1);
    self setgoalyaw(currentnode.angles[1] + level.heli_angle_offset);

    if(level.heli_forced_wait != 0) {
      self waittill("near_goal");
      wait level.heli_forced_wait;
      continue;
    }

    if(!isDefined(currentnode.script_delay)) {
      self waittill("near_goal");
      wait 5 + randomint(5);
      continue;
    }

    self waittill("goal");
    wait currentnode.script_delay;
  }
}

function get_best_area_attack_node(destnodes) {
  return updateareanodes(destnodes);
}

function heli_leave(leavepos) {
  self notify("leaving");
  self clearlookatent();

  if(isDefined(self.helitype) && self.helitype == "osprey" && isDefined(self.pathgoal)) {
    _setvehgoalpos(self.pathgoal, 1);
    waittill_any_timeout_1(5, "goal");
  }

  if(!isDefined(leavepos)) {
    leavenode = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    leavepos = leavenode.origin;
  }

  endent = spawn("script_origin", leavepos);

  if(isDefined(endent)) {
    self setlookatent(endent);
    endent thread wait_and_delete(3);
  }

  var_b2805e2f86ac4904 = (leavepos - self.origin) * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var_b2805e2f86ac4904, 1);
  waittill_any_timeout_1(12, "goal");
  self notify("gone");
  self notify("death");
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  decrementfauxvehiclecount();
  self delete();
}

function wait_and_delete(waittime) {
  self endon("death");
  level endon("game_ended");
  wait waittime;
  self delete();
}

function debug_print3d(message, color, ent, origin_offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_text(message, color, ent, origin_offset, frames);
  }
}

function debug_print3d_simple(message, ent, offset, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    if(isDefined(frames)) {
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
      return;
    }

    thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
  }
}

function debug_line(from, to, color, frames) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1 && !isDefined(frames)) {
    thread draw_line(from, to, color);
    return;
  }

  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_line(from, to, color, frames);
  }
}

function draw_text(msg, color, ent, offset, frames) {
  if(frames == 0) {
    while(isDefined(ent)) {
      print3d(ent.origin + offset, msg, color, 0.5, 4);

      wait 0.05;
    }

    return;
  }

  for(i = 0; i < frames; i++) {
    if(!isDefined(ent)) {
      break;
    }

    print3d(ent.origin + offset, msg, color, 0.5, 4);

    wait 0.05;
  }
}

function draw_line(from, to, color, frames) {
  if(isDefined(frames)) {
    for(i = 0; i < frames; i++) {
      line(from, to, color);
      wait 0.05;
    }

    return;
  }

  for(;;) {
    line(from, to, color);
    wait 0.05;
  }
}

function exceededmaxlittlebirds(streakname) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && streakname == "littlebird_flock") {
    return 1;
  }

  return 0;
}

function pavelowmadeselectionvo() {
  self endon("death_or_disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait 3.5;
  self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

function lbonkilled() {
  self endon("gone");

  if(!isDefined(self)) {
    return;
  }

  self notify("crashing");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage) {
    waitframe();
  } else {
    self vehicle_setspeed(25, 5);
    thread lbspin(randomintrange(180, 220));
    wait randomfloatrange(1, 2);
  }

  lbexplode();
}

function lbspin(speed) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(speed, speed, speed);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.9);
    wait 1;
  }
}

function lbexplode() {
  forward = self.origin + (0, 0, 1) - self.origin;
  deathangles = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(deathangles), anglestoup(deathangles));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

function trail_fx(trail_fx, trail_tag, stop_notify) {
  self notify(stop_notify);
  self endon(stop_notify);
  self endon("death");

  while(true) {
    playFXOnTag(trail_fx, self, trail_tag);
    wait 0.05;
  }
}

function removelittlebird() {
  if(isDefined(self.mgturretleft)) {
    if(isDefined(self.mgturretleft.killcament)) {
      self.mgturretleft.killcament delete();
    }

    self.mgturretleft delete();
  }

  if(isDefined(self.mgturretright)) {
    if(isDefined(self.mgturretright.killcament)) {
      self.mgturretright.killcament delete();
    }

    self.mgturretright delete();
  }

  if(isDefined(self.marker)) {
    self.marker delete();
  }

  if(isDefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self) {
    level.heli_pilot[self.team] = undefined;
  }

  decrementfauxvehiclecount();
  self delete();
}