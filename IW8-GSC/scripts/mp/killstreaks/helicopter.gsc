/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helicopter.gsc
*************************************************/

function init() {
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["jet_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_harrier_angel_flares.vfx");

  if(level.gametype != "br") {
    thread getaveragelowspawnpoint();
    return;
  }
}

function getaveragelowspawnpoint() {
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var1 = 0;
  var2 = 0;

  foreach(var4 in var0) {
    var1++;
    var2 += var4.origin[2];
  }

  if(var1 > 0) {
    level.averagealliesz = var2 / var1;
    return;
  }

  level.averagealliesz = 0;
}

function makehelitype(var0, var1, var2) {
  level.chopper_fx["explode"]["death"][var0] = loadfx(var1);
  level.lightfxfunc[var0] = var2;
}

function addairexplosion(var0, var1) {
  level.chopper_fx["explode"]["air_death"][var0] = loadfx(var1);
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

function usehelicopter(var0, var1) {
  return tryusehelicopter(var0, "helicopter");
}

function tryusehelicopter(var0, var1) {
  var2 = 1;

  if(isDefined(level.chopper)) {
    var3 = 1;
  } else {
    var3 = 0;
  }

  if(isDefined(level.chopper) && var3) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");

    if(isDefined(var2) && var2 != "helicopter") {
      var4 = "helicopter_" + var2;
    } else {
      var4 = "helicopter";
    }

    var5 = spawn("script_origin", (0, 0, 0));
    var5 hide();
    thread deleteonentnotify(var5, self);
    var5.player = self;
    var5.lifeid = var2;
    var5.helitype = var3;
    var5.streakname = var4;
    scripts\mp\utility\script::queueadd("helicopter", var5);
    return false;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var4 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  var4 = 1;
  starthelicopter(var3, var4);
  return true;
}

function deleteonentnotify(var0, var1) {
  self endon("death");
  var0 waittill(var1);
  self delete();
}

function starthelicopter(var0, var1) {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var2 = undefined;

  if(!isDefined(var1)) {
    var1 = "";
  }

  var3 = "helicopter";
  var4 = self.pers["team"];
  var2 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
  scripts\common\utility::ref_13e0a(level.ref_11b2a, var3, self.origin);
  thread heli_think(var0, self, var2, self.pers["team"], var1);
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
  var0 = self.team;

  if(level.multiteambased) {
    var0 = "axis";
  }

  return var0;
}

function spawn_helicopter(var0, var1, var2, var3, var4) {
  var5 = spawnhelicopter(var0, var1, var2, var3, var4);

  if(!isDefined(var5)) {
    return undefined;
  }

  if(var4 == "vehicle_battle_hind") {
    var5.heli_type = "cobra";
  } else {
    var5.heli_type = level.heli_types[var4];
  }

  var5 thread[[level.lightfxfunc[var5.heli_type]]]();
  var5 scripts\mp\utility\killstreak::addtohelilist(var5 getentitynumber());
  var5.zoffset = (0, 0, var5 gettagorigin("tag_origin")[2] - var5 gettagorigin("tag_ground")[2]);
  var5.attractor = missile_createattractorent(var5, level.heli_attract_strength, level.heli_attract_range);
  return var5;
}

function helidialog(var0) {
  if(gettime() - level.lasthelidialogtime < 6000) {
    return;
  }

  level.lasthelidialogtime = gettime();
  var1 = randomint(level.helidialog[var0].size);
  var2 = level.helidialog[var0][var1];
  var3 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "tl" + var2;
  self playlocalsound(var3);
}

function updateareanodes(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var3.validplayers = [];
    var3.nodescore = 0;
  }

  foreach(var6 in level.players) {
    if(!isalive(var6)) {
      continue;
    }

    if(var6.team == self.team) {
      continue;
    }

    foreach(var3 in var0) {
      if(distancesquared(var6.origin, var3.origin) > 1048576) {
        continue;
      }

      var3.validplayers[var3.validplayers.size] = var6;
    }
  }

  var10 = var0[0];

  foreach(var3 in var0) {
    var12 = getEnt(var3.target, "targetname");

    foreach(var6 in var3.validplayers) {
      var3.nodescore += 1;

      if(scripts\engine\trace::_bullet_trace_passed(var6.origin + (0, 0, 32), var12.origin, 0, var6)) {
        var3.nodescore += 3;
      }
    }

    if(var3.nodescore > var10.nodescore) {
      var10 = var3;
    }
  }

  return getEnt(var10.target, "targetname");
}

function heli_think(var0, var1, var2, var3, var4) {
  var5 = var2.origin;
  var6 = var2.angles;
  var7 = "cobra_mp";
  var8 = "vehicle_battle_hind";
  var9 = spawn_helicopter(var1, var5, var6, var7, var8);

  if(!isDefined(var9)) {
    return;
  }

  level.chopper = var9;

  if(var3 == "allies") {
    level.allieschopper = var9;
  } else {
    level.axischopper = var9;
  }

  var9.helitype = var4;
  var9.lifeid = var0;
  var9.team = var3;
  var9.pers["team"] = var3;
  var9.owner = var1;
  var9 setotherent(var1);
  var9.startnode = var2;
  var9.maxhealth = level.heli_maxhealth;
  var9.targeting_delay = level.heli_targeting_delay;
  var9.primarytarget = undefined;
  var9.secondarytarget = undefined;
  var9.attacker = undefined;
  var9.currentstate = "ok";
  var9 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var1);
  var9.empgrenaded = 0;

  if(var4 == "flares" || var4 == "minigun") {
    var9 thread scripts\mp\killstreaks\flares::flares_monitor(1);
  }

  thread heli_leave_on_disconnect(var9);
  thread heli_leave_on_changeteams(var9);
  thread heli_leave_on_gameended(var9);
  thread heli_damage_monitor(var9);
  thread heli_watchempdamage();
  thread heli_watchdeath();
  thread heli_existance();
  var9 endon("helicopter_done");
  var9 endon("crashing");
  var9 endon("leaving");
  var9 endon("death");
  var10 = getEntArray("heli_attack_area", "targetname");
  var11 = undefined;
  var11 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  heli_fly_simple_path(var9, var2);
  thread heli_targeting();
  thread heli_leave_on_timeout(var9);
  thread heli_fly_loop_path(var9);
}

function heli_existance() {
  var0 = self getentitynumber();
  scripts\engine\utility::ref_143a6("death", "crashing", "leaving");
  scripts\mp\utility\killstreak::removefromhelilist(var0);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  var1 = undefined;
  var2 = scripts\mp\utility\script::queueremovefirst("helicopter");

  if(!isDefined(var2)) {
    level.chopper = undefined;
    return;
  }

  var1 = var2.player;
  var3 = var2.lifeid;
  var4 = var2.streakname;
  var5 = var2.helitype;
  var2 delete();

  if(isDefined(var1) && (var1.sessionstate == "playing" || var1.sessionstate == "dead")) {
    starthelicopter(var1, var3, var5);
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
    var0 = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;

    foreach(var2 in level.characters) {
      wait 0.05;

      if(!cantarget_turret(var2)) {
        continue;
      }

      var0 = var2;
    }

    if(var0.size) {
      for(var4 = getbestprimarytarget(var0); !isDefined(var4); var4 = getbestprimarytarget(var0)) {
        waitframe();
      }

      self.primarytarget = var4;
      self notify("primary acquired");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait 0.25;
  }
}

function cantarget_turret(var0) {
  var1 = 1;

  if(!isalive(var0) || isDefined(var0.sessionstate) && var0.sessionstate != "playing") {
    return 0;
  }

  if(distance(var0.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }

  if(!self.owner scripts\mp\utility\player::isenemy(var0)) {
    return 0;
  }

  if(isDefined(var0.spawntime) && (gettime() - var0.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(var0 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    return 0;
  }

  var2 = self.origin + (0, 0, -160);
  var3 = anglesToForward(self.angles);
  var4 = var2 + 144 * var3;

  if(var0 sightconetrace(var4, self) < level.heli_target_recognition) {
    return 0;
  }

  return var1;
}

function getbestprimarytarget(var0) {
  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    update_player_threat(var2);
  }

  var4 = 0;
  var5 = undefined;
  var6 = getEntArray("minimap_corner", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    if(var6.size == 2) {
      var8 = var6[0].origin;
      var9 = var6[0].origin;

      if(var6[1].origin[0] > var9[0]) {
        var9 = (var6[1].origin[0], var9[1], var9[2]);
      } else {
        var8 = (var6[1].origin[0], var8[1], var8[2]);
      }

      if(var6[1].origin[1] > var9[1]) {
        var9 = (var9[0], var6[1].origin[1], var9[2]);
      } else {
        var8 = (var8[0], var6[1].origin[1], var8[2]);
      }

      if(var2.origin[0] < var8[0] || var2.origin[0] > var9[0] || var2.origin[1] < var8[1] || var2.origin[1] > var9[1]) {
        continue;
      }
    }

    if(var2.threatlevel < var4) {
      continue;
    }

    if(!scripts\engine\trace::_bullet_trace_passed(var2.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    var4 = var2.threatlevel;
    var5 = var2;
  }

  return var5;
}

function update_player_threat(var0) {
  var0.threatlevel = 0;
  var1 = distance(var0.origin, self.origin);
  var0.threatlevel += (level.heli_visual_range - var1) / level.heli_visual_range * 100;

  if(isDefined(self.attacker) && var0 == self.attacker) {
    var0.threatlevel += 100;
  }

  if(isPlayer(var0)) {
    var0.threatlevel += var0.score * 4;
  }

  if(isDefined(var0.antithreat)) {
    var0.threatlevel -= var0.antithreat;
  }

  if(var0.threatlevel <= 0) {
    var0.threatlevel = 1;
    return;
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

function addrecentdamage(var0) {
  self endon("death");
  self.recentdamageamount += var0;
  wait 4;
  self.recentdamageamount -= var0;
}

function modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = 2;
  var8 = 3;
  var9 = 4;

  if(isDefined(self.helitype) && self.helitype == "dronedrop") {
    var7 = 1;
    var8 = 1;
    var9 = 2;
  }

  var6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var2, var3, var6, self.maxhealth, var7, var8, var9);
  thread addrecentdamage(var6);
  self notify("heli_damage_fx");
  return var6;
}

function handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(isDefined(var1)) {
    var6 = level.heliconfigs[self.streakname];
    var7 = scripts\mp\damage::onkillstreakkilled(self.streakname, var1, var2, var3, var4, var6.scorepopup, var6.destroyedvo, var6.callout);

    if(var7) {
      var1 notify("destroyed_helicopter");
      self.killingattacker = var1;
      return;
    }

    return;
  }
}

function heli_damage_monitor(var0, var1, var2) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = var0;
  self.recentdamageamount = 0;

  if(!istrue(var2)) {
    thread heli_health();
  }

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", &handledeathdamage, &modifydamage, 1, var1);
}

function heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var0, var1);
    self.empgrenaded = 1;

    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("stop_shooting");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("stop_shooting");
    }

    wait var1;
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
  var0 = 3;
  self setdamagestage(var0);
  var1 = level.heliconfigs[self.streakname];

  for(;;) {
    self waittill("heli_damage_fx");

    if(var0 > 0 && self.damagetaken >= self.maxhealth) {
      var0 = 0;
      self setdamagestage(var0);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var1.enginevfxtag);
      self notify("death");
      break;
    }

    if(var0 > 1 && self.damagetaken >= self.maxhealth * 0.66) {
      var0 = 1;
      self setdamagestage(var0);
      self.currentstate = "heavy smoke";
      stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var1.enginevfxtag);
      playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var1.enginevfxtag);
      continue;
    }

    if(var0 > 2 && self.damagetaken >= self.maxhealth * 0.33) {
      var0 = 2;
      self setdamagestage(var0);
      self.currentstate = "light smoke";
      playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var1.enginevfxtag);
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

  var0 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, var0.enginevfxtag);
  thread heli_crash();
}

function heli_crash() {
  self notify("crashing");
  self clearlookatent();
  var0 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(var0);
  thread heli_explode();
}

function heli_secondary_explosions() {
  var0 = heli_getteamforsoundclip();
  var1 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, var1.enginevfxtag);
  self playSound(level.heli_sound[var0]["hitsecondary"]);
  wait 3;

  if(!isDefined(self)) {
    return;
  }

  playFXOnTag(level.chopper_fx["explode"]["large"], self, var1.enginevfxtag);
  self playSound(level.heli_sound[var0]["hitsecondary"]);
}

function heli_spin(var0) {
  self endon("death");
  var1 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var1]["hit"]);
  thread spinsoundshortly();
  self setyawspeed(var0, var0, var0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var0 * 0.9);
    wait 1;
  }
}

function spinsoundshortly() {
  self endon("death");
  wait 0.25;
  var0 = heli_getteamforsoundclip();
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level.heli_sound[var0]["spinloop"]);
  wait 0.05;
  self playLoopSound(level.heli_sound[var0]["spinstart"]);
}

function heli_explode(var0) {
  self notify("death");

  if(isDefined(var0) && isDefined(level.chopper_fx["explode"]["air_death"][self.heli_type])) {
    var1 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.heli_type], self gettagorigin("tag_deathfx"), anglesToForward(var1), anglestoup(var1));
  } else {
    var2 = self.origin;
    var3 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.heli_type], var2, var3);
  }

  var4 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var4]["crash"]);
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

function check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread heli_leave();
    return false;
  }

  return true;
}

function heli_leave_on_disconnect(var0) {
  self endon("death");
  self endon("helicopter_done");
  var0 waittill("disconnect");
  thread heli_leave();
}

function heli_leave_on_changeteams(var0) {
  self endon("death");
  self endon("helicopter_done");
  var0 scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  thread heli_leave();
}

function heli_leave_on_spawned(var0) {
  self endon("death");
  self endon("helicopter_done");
  var0 waittill("spawned");
  thread heli_leave();
}

function heli_leave_on_gameended(var0) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

function heli_leave_on_timeout(var0) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
  thread heli_leave();
}

function fireontarget(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var1 = 15;
  var2 = 0;
  var3 = 0;

  foreach(var5 in level.heli_loop_nodes) {
    var2++;
    var3 += var5.origin[2];
  }

  var7 = var3 / var2;
  self notify("newTarget");

  if(isDefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth) {
    return;
  }

  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }

  var8 = self.primarytarget;
  var8.antithreat = 0;
  var9 = self.primarytarget.origin * (1, 1, 0);
  var10 = self.origin * (0, 0, 1);
  var11 = var9 + var10;
  var12 = distance2d(self.origin, var8.origin);

  if(var12 < 1000) {
    var1 = 600;
  }

  var13 = anglesToForward(var8.angles);
  var13 *= (1, 1, 0);
  var14 = var11 + var1 * var13;
  var15 = var14 - var11;
  var16 = vectortoangles(var15);
  var16 *= (1, 1, 0);
  thread attackgroundtarget(var8);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, var14) < 1000) {
    var14 *= 1.5;
  }

  var14 *= (1, 1, 0);
  var14 += (0, 0, var7);
  _setvehgoalpos(var14, 1, 1);
  self waittill("near_goal");

  if(!isDefined(var8) || !isalive(var8)) {
    return;
  }

  self setlookatent(var8);
  thread isfacing(10, var8);
  scripts\engine\utility::ref_143b9(4, "facing");

  if(!isDefined(var8) || !isalive(var8)) {
    return;
  }

  self clearlookatent();
  var17 = var11 + var1 * anglesToForward(var16);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var17, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isDefined(var8) && isalive(var8)) {
    if(isDefined(var8.antithreat)) {
      var8.antithreat += 100;
    } else {
      var8.antithreat = 100;
    }
  }

  scripts\engine\utility::ref_143b9(3, "near_goal");
}

function attackgroundtarget(var0) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetEnt(var0);
  waitontargetordeath(var0, 3);

  if(!isalive(var0)) {
    self.isattacking = 0;
    return;
  }

  var1 = distance2dsquared(self.origin, var0.origin);

  if(var1 < 640000) {
    thread dropbombs(var0);
    self.isattacking = 0;
    return;
  }

  if(checkisfacing(50, var0) && scripts\engine\utility::cointoss()) {
    thread firemissile(var0);
    self.isattacking = 0;
    return;
  }

  var2 = weaponfiretime("cobra_20mm_mp");
  var3 = 0;
  var4 = 0;

  for(var5 = 0; var5 < level.heli_turretclipsize; var5++) {
    if(!isDefined(self)) {
      break;
    }

    if(self.empgrenaded) {
      break;
    }

    if(!isDefined(var0)) {
      break;
    }

    if(!isalive(var0)) {
      break;
    }

    if(self.damagetaken >= self.maxhealth) {
      continue;
    }

    if(!checkisfacing(55, var0)) {
      self stoploopsound();
      var4 = 0;
      wait var2;
      var5--;
      continue;
    }

    if(var5 < level.heli_turretclipsize - 1) {
      wait var2;
    }

    if(!isDefined(var0) || !isalive(var0)) {
      break;
    }

    if(!var4) {
      self playLoopSound("weap_hind_20mm_fire_npc");
      var4 = 1;
    }

    self setvehweapon("cobra_20mm_mp");
    self fireweapon("tag_flash", var0);
  }

  if(!isDefined(self)) {
    return;
  }

  self stoploopsound();
  var4 = 0;
  self.isattacking = 0;
}

function checkisfacing(var0, var1) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var0)) {
    var0 = 10;
  }

  var2 = anglesToForward(self.angles);
  var3 = var1.origin - self.origin;
  var2 *= (1, 1, 0);
  var3 *= (1, 1, 0);
  var3 = vectorNormalize(var3);
  var2 = vectorNormalize(var2);
  var4 = vectordot(var3, var2);
  var5 = cos(var0);

  if(var4 >= var5) {
    return 1;
  }

  return 0;
}

function isfacing(var0, var1) {
  self endon("death");
  self endon("leaving");
  jumpiftrue(isDefined(var0)) LOC_0000001b;
  var0 = 10;

  while(isalive(var1)) {
    var2 = anglesToForward(self.angles);
    var3 = var1.origin - self.origin;
    var2 *= (1, 1, 0);
    var3 *= (1, 1, 0);
    var3 = vectorNormalize(var3);
    var2 = vectorNormalize(var2);
    var4 = vectordot(var3, var2);
    var5 = cos(var0);

    if(var4 >= var5) {
      self notify("facing");
      break;
    }

    wait 0.1;
  }
}

function waitontargetordeath(var0, var1) {
  self endon("death");
  self endon("helicopter_done");
  var0 endon("death_or_disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", var1);
}

function firemissile(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var1 = 2;

  for(var2 = 0; var2 < var1; var2++) {
    if(!isDefined(var0)) {
      return;
    }

    if(scripts\engine\utility::cointoss()) {
      var3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hind_missile_mp"), self gettagorigin("tag_missile_right") - (0, 0, 64), var0.origin, self.owner);
      var3.vehicle_fired_from = self;
    } else {
      var3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hind_missile_mp"), self gettagorigin("tag_missile_left") - (0, 0, 64), var0.origin, self.owner);
      var3.vehicle_fired_from = self;
    }

    var3 missile_settargetEnt(var0);
    var3.owner = self;
    var3 missile_setflightmodedirect();
    wait 0.5 / var1;
  }
}

function dropbombs(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(var0)) {
    return;
  }

  for(var1 = 0; var1 < randomintrange(2, 5); var1++) {
    if(scripts\engine\utility::cointoss()) {
      var2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hind_bomb_mp"), self gettagorigin("tag_missile_left") - (0, 0, 45), var0.origin, self.owner);
      var2.vehicle_fired_from = self;
    } else {
      var2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hind_bomb_mp"), self gettagorigin("tag_missile_right") - (0, 0, 45), var0.origin, self.owner);
      var2.vehicle_fired_from = self;
    }

    wait randomfloatrange(0.35, 0.65);
  }
}

function getoriginoffsets(var0) {
  var1 = self.origin;
  var2 = var0.origin;
  var3 = 0;
  var4 = 40;
  var5 = (0, 0, -196);

  for(var6 = scripts\engine\trace::_bullet_trace(var1 + var5, var2 + var5, 0, self); distancesquared(var6["position"], var2 + var5) > 10 && var3 < var4; var6 = scripts\engine\trace::_bullet_trace(var1 + var5, var2 + var5, 0, self)) {
    if(var1[2] < var2[2]) {
      var1 += (0, 0, 128);
    } else if(var1[2] > var2[2]) {
      var2 += (0, 0, 128);
    } else {
      var1 += (0, 0, 128);
      var2 += (0, 0, 128);
    }

    var3++;
  }

  var7 = [];
  GscBinSkip0(0x2e, "start", var1);
}

function traveltonode(var0) {
  var1 = getoriginoffsets(var0);

  if(var1["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var1["start"] + (0, 0, 30), 0);
    self setgoalyaw(var0.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(var1["end"] != var0.origin) {
    if(isDefined(var0.script_airspeed) && isDefined(var0.script_accel)) {
      var2 = var0.script_airspeed;
      var3 = var0.script_accel;
    } else {
      var2 = 30 + randomint(20);
      var3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var3["end"] + (0, 0, 30), 0);
    self setgoalyaw(var2.angles[1] + level.heli_angle_offset);
    self waittill("goal");
    return;
  }
}

function _setvehgoalpos(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = 0;

  if(var2) {
    thread _setvehgoalposadheretomesh(var0, var1);
    return;
  }

  self setvehgoalpos(var0, var1);
}

function _setvehgoalposadheretomesh(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var2 = var0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, var2) < 65536) {
      self setvehgoalpos(var2, var1);
      break;
    }

    var3 = vectortoangles(var2 - self.origin);
    var4 = anglesToForward(var3);
    var5 = self.origin + var4 * (1, 1, 0) * 250;
    var6 = (0, 0, 2500);
    var7 = var5 + scripts\mp\utility\killstreak::gethelipilotmeshoffset() + var6;
    var8 = var5 + scripts\mp\utility\killstreak::gethelipilotmeshoffset() - var6;
    var9 = scripts\engine\trace::_bullet_trace(var7, var8, 0, self, 0, 0, 1);
    var10 = var9;

    if(isDefined(var9["entity"]) && var9["entity"] == self && var9["normal"][2] > 0.1) {
      var11 = var9["position"][2] - 4400;
      var12 = var11 - self.origin[2];

      if(var12 > 256) {
        var9 = var9["position"] * (1, 1, 0);
        var9 = var9["position"] + (0, 0, self.origin[2] + 256);
      } else if(var12 < -256) {
        var9 = var9["position"] * (1, 1, 0);
        var9 = var9["position"] + (0, 0, self.origin[2] - 256);
      }

      var10 = var9["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 600);
    } else {
      var10 = var2;
    }

    self setvehgoalpos(var10, 0);
    wait 0.15;
  }
}

function heli_fly_simple_path(var0) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();

  for(var1 = var0; isDefined(var1.target); var1 = var2) {
    var2 = getEnt(var1.target, "targetname");

    if(isDefined(var1.script_airspeed) && isDefined(var1.script_accel)) {
      var3 = var1.script_airspeed;
      var4 = var1.script_accel;
    } else {
      var3 = 30 + randomint(20);
      var4 = 15 + randomint(15);
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

    if(!isDefined(var2.target)) {
      _setvehgoalpos(var2.origin + self.zoffset, 1);
      self waittill("near_goal");
      continue;
    }

    _setvehgoalpos(var2.origin + self.zoffset, 0);
    self waittill("near_goal");
    self setgoalyaw(var2.angles[1]);
    self waittillmatch("goal", < error pop > );
  }
}

function heli_fly_loop_path(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(var0);

  for(var1 = var0; isDefined(var1.target); var1 = var2) {
    var2 = getEnt(var1.target, "targetname");

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.25;
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait 0.1;
      continue;
    }

    if(isDefined(var1.script_airspeed) && isDefined(var1.script_accel)) {
      self.desired_speed = var1.script_airspeed;
      self.desired_accel = var1.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed *= 0.5;
      self.desired_accel *= 0.5;
    }

    if(isDefined(var2.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(var2.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait var2.script_delay;
      continue;
    }

    _setvehgoalpos(var2.origin + self.zoffset, 0, 1);
    self waittill("near_goal");
    self setgoalyaw(var2.angles[1]);
    self waittillmatch("goal", < error pop > );
  }
}

function heli_loop_speed_control(var0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(var0.script_airspeed) && isDefined(var0.script_accel)) {
    self.desired_speed = var0.script_airspeed;
    self.desired_accel = var0.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  var1 = 0;
  var2 = 0;

  for(;;) {
    var3 = self.desired_speed;
    var4 = self.desired_accel;

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(self.helitype != "flares" && isDefined(self.primarytarget) && !heli_is_threatened()) {
      var3 *= 0.25;
    }

    if(var1 != var3 || var2 != var4) {
      self vehicle_setspeed(75, 35);
      var1 = var3;
      var2 = var4;
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

function heli_fly_well(var0) {
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

    var1 = get_best_area_attack_node(var0);
    traveltonode(var1);

    if(isDefined(var1.script_airspeed) && isDefined(var1.script_accel)) {
      var2 = var1.script_airspeed;
      var3 = var1.script_accel;
    } else {
      var2 = 30 + randomint(20);
      var3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var1.origin + self.zoffset, 1);
    self setgoalyaw(var1.angles[1] + level.heli_angle_offset);

    if(level.heli_forced_wait != 0) {
      self waittill("near_goal");
      wait level.heli_forced_wait;
      continue;
    }

    if(!isDefined(var1.script_delay)) {
      self waittill("near_goal");
      wait 5 + randomint(5);
      continue;
    }

    self waittillmatch("goal", < error pop > );
    wait var1.script_delay;
  }
}

function get_best_area_attack_node(var0) {
  return updateareanodes(var0);
}

function heli_leave(var0) {
  self notify("leaving");
  self clearlookatent();

  if(isDefined(self.helitype) && self.helitype == "osprey" && isDefined(self.pathgoal)) {
    _setvehgoalpos(self.pathgoal, 1);
    scripts\engine\utility::ref_143b9(5, "goal");
  }

  if(!isDefined(var0)) {
    var1 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    var0 = var1.origin;
  }

  var2 = spawn("script_origin", var0);

  if(isDefined(var2)) {
    self setlookatent(var2);
    thread wait_and_delete(var2);
  }

  var3 = (var0 - self.origin) * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var3, 1);
  scripts\engine\utility::ref_143b9(12, "goal");
  self notify("gone");
  self notify("death");
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

function wait_and_delete(var0) {
  self endon("death");
  level endon("game_ended");
  wait var0;
  self delete();
}

function debug_print3d(var0, var1, var2, var3, var4) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_text(var0, var1, var2, var3, var4);
    return;
  }
}

function debug_print3d_simple(var0, var1, var2, var3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    if(isDefined(var3)) {
      thread draw_text(var0, (0.8, 0.8, 0.8), var1, var2, var3);
      return;
    }

    thread draw_text(var0, (0.8, 0.8, 0.8), var1, var2, 0);
    return;
  }
}

function debug_line(var0, var1, var2, var3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1 && !isDefined(var3)) {
    thread draw_line(var0, var1, var2);
    return;
  }

  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_line(var0, var1, var2, var3);
    return;
  }
}

function draw_text(var0, var1, var2, var3, var4) {
  if(var4 == 0) {
    while(isDefined(var2)) {
      wait 0.05;
    }

    return;
  }

  for(var5 = 0; var5 < var4; var5++) {
    if(!isDefined(var2)) {
      break;
    }

    wait 0.05;
  }
}

function draw_line(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    for(var4 = 0; var4 < var3; var4++) {
      wait 0.05;
    }

    return;
  }

  for(;;) {
    wait 0.05;
  }
}

function exceededmaxlittlebirds(var0) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && var0 == "littlebird_flock") {
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

function lbspin(var0) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(var0, var0, var0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var0 * 0.9);
    wait 1;
  }
}

function lbexplode() {
  var0 = self.origin + (0, 0, 1) - self.origin;
  var1 = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(var1), anglestoup(var1));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

function trail_fx(var0, var1, var2) {
  self notify(var2);
  self endon(var2);
  self endon("death");

  for(;;) {
    playFXOnTag(var0, self, var1);
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

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}