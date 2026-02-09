/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter.gsc
**************************************************/

init() {
  var_0 = getEntArray("heli_start", "targetname");
  var_1 = getEntArray("heli_loop_start", "targetname");
  if(!var_0.size && !var_1.size) {
    return;
  }

  level.chopper = undefined;
  level.var_8D96 = getEntArray("heli_start", "targetname");
  level.heli_loop_nodes = getEntArray("heli_loop_start", "targetname");
  level.var_110D1 = scripts\engine\utility::getstructarray("strafe_path", "targetname");
  level.heli_leave_nodes = getEntArray("heli_leave", "targetname");
  level.heli_crash_nodes = getEntArray("heli_crash_start", "targetname");
  level.var_8D75 = 5;
  level.var_8D73 = 2000;
  level.heli_debug = 0;
  level.var_8D9A = 0.5;
  level.var_8D9F = 1.5;
  level.heli_turretclipsize = 60;
  level.heli_visual_range = 3700;
  level.var_8D98 = 5;
  level.var_8D97 = 0.5;
  level.var_8D74 = 256;
  level.var_8D76 = 0.3;
  level.var_8D2C = 0.3;
  level.var_8D2E = 1000;
  level.var_8D2D = 4096;
  level.heli_angle_offset = 90;
  level.var_8D56 = 0;
  level func_D80F();
  level.chopper_fx["damage"]["light_smoke"] = loadfx("vfx\core\smktrail\smoke_trail_white_heli_emitter");
  level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_helo_damage.vfx");
  level.chopper_fx["damage"]["on_fire"] = loadfx("vfx\core\expl\fire_smoke_trail_l_emitter");
  level.chopper_fx["light"]["left"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["right"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["belly"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["tail"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["medium"] = loadfx("vfx\core\expl\aerial_explosion");
  level.chopper_fx["explode"]["large"] = loadfx("vfx\core\expl\helicopter_explosion_secondary_small");
  level.chopper_fx["smoke"]["trail"] = loadfx("vfx\core\smktrail\smoke_trail_white_heli");
  level.chopper_fx["explode"]["death"] = [];
  level.chopper_fx["explode"]["death"]["apache"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["air_death"]["apache"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.lightfxfunc["apache"] = ::defaultlightfx;
  level.lightfxfunc["cobra"] = ::defaultlightfx;
  level.chopper_fx["explode"]["death"]["littlebird"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["air_death"]["littlebird"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.lightfxfunc["littlebird"] = ::defaultlightfx;
  level._effect["vehicle_flares"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_warden_em_flares.vfx");
  level.chopper_fx["fire"]["trail"]["medium"] = loadfx("vfx\core\expl\fire_smoke_trail_l_emitter");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("helicopter", ::usehelicopter);
  level.var_8DB6["tracking"][0] = "ac130_fco_moreenemy";
  level.var_8DB6["tracking"][1] = "ac130_fco_getthatguy";
  level.var_8DB6["tracking"][2] = "ac130_fco_guyrunnin";
  level.var_8DB6["tracking"][3] = "ac130_fco_gotarunner";
  level.var_8DB6["tracking"][4] = "ac130_fco_personnelthere";
  level.var_8DB6["tracking"][5] = "ac130_fco_rightthere";
  level.var_8DB6["tracking"][6] = "ac130_fco_tracking";
  level.var_8DB6["locked"][0] = "ac130_fco_lightemup";
  level.var_8DB6["locked"][1] = "ac130_fco_takehimout";
  level.var_8DB6["locked"][2] = "ac130_fco_nailthoseguys";
  level.var_A99A = 0;
  level.heliconfigs = [];
  var_2 = spawnStruct();
  var_2.scorepopup = "destroyed_helicopter";
  var_2.callout = "callout_destroyed_helicopter";
  var_2.samdamagescale = 0.09;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["helicopter"] = var_2;
  var_2 = spawnStruct();
  var_2.scorepopup = "destroyed_little_bird";
  var_2.callout = "callout_destroyed_little_bird";
  var_2.samdamagescale = 0.09;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["airdrop"] = var_2;
  var_2 = spawnStruct();
  var_2.scorepopup = "destroyed_dronedrop";
  var_2.var_52DA = "dronedrop_destroyed";
  var_2.callout = "callout_destroyed_dronedrop";
  level.heliconfigs["dronedrop"] = var_2;
  var_2 = spawnStruct();
  var_2.scorepopup = "destroyed_pavelow";
  var_2.callout = "callout_destroyed_helicopter_flares";
  var_2.samdamagescale = 0.07;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["flares"] = var_2;
  scripts\mp\utility::func_DB8D("helicopter");
}

makehelitype(var_0, var_1, var_2) {
  level.chopper_fx["explode"]["death"][var_0] = loadfx(var_1);
  level.lightfxfunc[var_0] = var_2;
}

addairexplosion(var_0, var_1) {
  level.chopper_fx["explode"]["air_death"][var_0] = loadfx(var_1);
}

defaultlightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

usehelicopter(var_0, var_1) {
  return tryusehelicopter(var_0, "helicopter");
}

tryusehelicopter(var_0, var_1) {
  var_2 = 1;
  if(isDefined(level.chopper)) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  if(isDefined(level.chopper) && var_3) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");
    if(isDefined(var_1) && var_1 != "helicopter") {
      var_4 = "helicopter_" + var_1;
    } else {
      var_4 = "helicopter";
    }

    var_5 = spawn("script_origin", (0, 0, 0));
    var_5 hide();
    var_5 thread deleteonentnotify(self, "disconnect");
    var_5.player = self;
    var_5.lifeid = var_0;
    var_5.helitype = var_1;
    var_5.streakname = var_4;
    scripts\mp\utility::func_DB8B("helicopter", var_5);
    var_6 = undefined;
    if(!self hasweapon(scripts\engine\utility::getlastweapon())) {
      var_6 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
    } else {
      var_6 = scripts\engine\utility::getlastweapon();
    }

    var_7 = scripts\mp\utility::getkillstreakweapon("helicopter");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_6 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  var_6 = 1;
  func_10DA2(var_4, var_5);
  return 1;
}

deleteonentnotify(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
}

func_10DA2(var_0, var_1) {
  scripts\mp\utility::incrementfauxvehiclecount();
  var_2 = undefined;
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_3 = "helicopter";
  var_4 = self.pers["team"];
  var_2 = level.var_8D96[randomint(level.var_8D96.size)];
  scripts\mp\matchdata::logkillstreakevent(var_3, self.origin);
  thread func_8D9B(var_0, self, var_2, self.pers["team"], var_1);
}

func_D80F() {
  level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

heli_getteamforsoundclip() {
  var_0 = self.team;
  if(level.multiteambased) {
    var_0 = "axis";
  }

  return var_0;
}

func_1072E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnhelicopter(var_0, var_1, var_2, var_3, var_4);
  if(!isDefined(var_5)) {
    return undefined;
  }

  if(var_4 == "vehicle_battle_hind") {
    var_5.var_8DA0 = "cobra";
  } else {
    var_5.var_8DA0 = level.var_8DA1[var_4];
  }

  var_5 thread[[level.lightfxfunc[var_5.var_8DA0]]]();
  var_5 func_184E();
  var_5.zoffset = (0, 0, var_5 gettagorigin("tag_origin")[2] - var_5 gettagorigin("tag_ground")[2]);
  var_5.attractor = missile_createattractorent(var_5, level.var_8D2E, level.var_8D2D);
  return var_5;
}

func_8DB6(var_0) {
  if(gettime() - level.var_A99A < 6000) {
    return;
  }

  level.var_A99A = gettime();
  var_1 = randomint(level.var_8DB6[var_0].size);
  var_2 = level.var_8DB6[var_0][var_1];
  var_3 = scripts\mp\teams::getteamvoiceprefix(self.team) + var_2;
  self playlocalsound(var_3);
}

updateareanodes(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_3.var_1314F = [];
    var_3.var_C056 = 0;
  }

  foreach(var_6 in level.players) {
    if(!isalive(var_6)) {
      continue;
    }

    if(var_6.team == self.team) {
      continue;
    }

    foreach(var_3 in var_0) {
      if(distancesquared(var_6.origin, var_3.origin) > 1048576) {
        continue;
      }

      var_3.var_1314F[var_3.var_1314F.size] = var_6;
    }
  }

  var_10 = var_0[0];
  foreach(var_3 in var_0) {
    var_12 = getent(var_3.target, "targetname");
    foreach(var_6 in var_3.var_1314F) {
      var_3.var_C056 = var_3.var_C056 + 1;
      if(bullettracepassed(var_6.origin + (0, 0, 32), var_12.origin, 0, var_6)) {
        var_3.var_C056 = var_3.var_C056 + 3;
      }
    }

    if(var_3.var_C056 > var_10.var_C056) {
      var_10 = var_3;
    }
  }

  return getent(var_10.target, "targetname");
}

func_8D9B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.origin;
  var_6 = var_2.angles;
  var_7 = "cobra_mp";
  var_8 = "vehicle_battle_hind";
  var_9 = func_1072E(var_1, var_5, var_6, var_7, var_8);
  if(!isDefined(var_9)) {
    return;
  }

  level.chopper = var_9;
  if(var_3 == "allies") {
    level.allieschopper = var_9;
  } else {
    level.axischopper = var_9;
  }

  var_9.helitype = var_4;
  var_9.lifeid = var_0;
  var_9.team = var_3;
  var_9.pers["team"] = var_3;
  var_9.owner = var_1;
  var_9 setotherent(var_1);
  var_9.var_10DCD = var_2;
  var_9.maxhealth = level.var_8D73;
  var_9.var_11568 = level.var_8D9A;
  var_9.primarytarget = undefined;
  var_9.secondarytarget = undefined;
  var_9.var_4F = undefined;
  var_9.currentstate = "ok";
  var_9 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_1);
  var_9.empgrenaded = 0;
  if(var_4 == "flares" || var_4 == "minigun") {
    var_9 thread scripts\mp\killstreaks\_flares::flares_monitor(1);
  }

  var_9 thread heli_leave_on_disconnect(var_1);
  var_9 thread heli_leave_on_changeteams(var_1);
  var_9 thread heli_leave_on_gameended(var_1);
  var_9 thread heli_damage_monitor(var_4);
  var_9 thread heli_watchempdamage();
  var_9 thread heli_watchdeath();
  var_9 thread func_8D49();
  var_9 endon("helicopter_done");
  var_9 endon("crashing");
  var_9 endon("leaving");
  var_9 endon("death");
  var_10 = getEntArray("heli_attack_area", "targetname");
  var_11 = undefined;
  var_11 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  var_9 heli_fly_simple_path(var_2);
  var_9 thread heli_targeting();
  var_9 thread heli_leave_on_timeout(60);
  var_9 thread heli_fly_loop_path(var_11);
}

func_8D49() {
  var_0 = self getentitynumber();
  scripts\engine\utility::waittill_any("death", "crashing", "leaving");
  func_E109(var_0);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  var_1 = undefined;
  var_2 = scripts\mp\utility::func_DB94("helicopter");
  if(!isDefined(var_2)) {
    level.chopper = undefined;
    return;
  }

  var_1 = var_2.player;
  var_3 = var_2.lifeid;
  var_4 = var_2.streakname;
  var_5 = var_2.helitype;
  var_2 delete();
  if(isDefined(var_1) && var_1.sessionstate == "playing" || var_1.sessionstate == "dead") {
    var_1 func_10DA2(var_3, var_5);
    return;
  }

  level.chopper = undefined;
}

heli_targeting() {
  self notify("heli_targeting");
  self endon("heli_targeting");
  self endon("death");
  self endon("helicopter_done");
  for(;;) {
    var_0 = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;
    foreach(var_2 in level.characters) {
      wait(0.05);
      if(!func_3922(var_2)) {
        continue;
      }

      var_0[var_0.size] = var_2;
    }

    if(var_0.size) {
      for(var_4 = func_7E00(var_0); !isDefined(var_4); var_4 = func_7E00(var_0)) {
        wait(0.05);
      }

      self.primarytarget = var_4;
      self notify("primary acquired");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait(0.25);
  }
}

func_3922(var_0) {
  var_1 = 1;
  if(!isalive(var_0) || isDefined(var_0.sessionstate) && var_0.sessionstate != "playing") {
    return 0;
  }

  if(self.helitype == "remote_mortar") {
    if(var_0 giveperks(self.origin, self) < 1) {
      return 0;
    }
  }

  if(distance(var_0.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }

  if(!self.owner scripts\mp\utility::isenemy(var_0)) {
    return 0;
  }

  if(isDefined(var_0.spawntime) && gettime() - var_0.spawntime / 1000 <= 5) {
    return 0;
  }

  if(var_0 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  var_2 = self.origin + (0, 0, -160);
  var_3 = anglesToForward(self.angles);
  var_4 = var_2 + 144 * var_3;
  if(var_0 giveperks(var_4, self) < level.var_8D97) {
    return 0;
  }

  return var_1;
}

func_7E00(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    update_player_threat(var_2);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = getEntArray("minimap_corner", "targetname");
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(var_6.size == 2) {
      var_8 = var_6[0].origin;
      var_9 = var_6[0].origin;
      if(var_6[1].origin[0] > var_9[0]) {
        var_9 = (var_6[1].origin[0], var_9[1], var_9[2]);
      } else {
        var_8 = (var_6[1].origin[0], var_8[1], var_8[2]);
      }

      if(var_6[1].origin[1] > var_9[1]) {
        var_9 = (var_9[0], var_6[1].origin[1], var_9[2]);
      } else {
        var_8 = (var_8[0], var_6[1].origin[1], var_8[2]);
      }

      if(var_2.origin[0] < var_8[0] || var_2.origin[0] > var_9[0] || var_2.origin[1] < var_8[1] || var_2.origin[1] > var_9[1]) {
        continue;
      }
    }

    if(var_2.threatlevel < var_4) {
      continue;
    }

    if(!bullettracepassed(var_2.origin + (0, 0, 32), self.origin, 0, self)) {
      wait(0.05);
      continue;
    }

    var_4 = var_2.threatlevel;
    var_5 = var_2;
  }

  return var_5;
}

update_player_threat(var_0) {
  var_0.threatlevel = 0;
  var_1 = distance(var_0.origin, self.origin);
  var_0.threatlevel = var_0.threatlevel + level.heli_visual_range - var_1 / level.heli_visual_range * 100;
  if(isDefined(self.var_4F) && var_0 == self.var_4F) {
    var_0.threatlevel = var_0.threatlevel + 100;
  }

  if(isPlayer(var_0)) {
    var_0.threatlevel = var_0.threatlevel + var_0.score * 4;
  }

  if(isDefined(var_0.antithreat)) {
    var_0.threatlevel = var_0.threatlevel - var_0.antithreat;
  }

  if(var_0.threatlevel <= 0) {
    var_0.threatlevel = 1;
  }
}

heli_reset() {
  self getplayerspeedbyweapon();
  self getplayerkills();
  self vehicle_setspeed(80, 35);
  self givelastonteamwarning(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

addrecentdamage(var_0) {
  self endon("death");
  self.recentdamageamount = self.recentdamageamount + var_0;
  wait(4);
  self.recentdamageamount = self.recentdamageamount - var_0;
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    if((isDefined(self.owner) && var_0 == self.owner && self.streakname == "heli_sniper") || isDefined(var_0.class) && var_0.class == "worldspawn" || var_0 == self) {
      return -1;
    }
  }

  var_5 = var_3;
  var_6 = 2;
  var_7 = 3;
  var_8 = 4;
  if(isDefined(self.helitype) && self.helitype == "dronedrop") {
    var_6 = 1;
    var_7 = 1;
    var_8 = 2;
  }

  var_5 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_5, self.maxhealth, var_6, var_7, var_8);
  thread addrecentdamage(var_5);
  self notify("heli_damage_fx");
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    var_5 = 0;
  }

  return var_5;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_4 = level.heliconfigs[self.streakname];
    var_5 = "";
    if(isDefined(self.streakinfo)) {
      var_5 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
    }

    var_6 = var_4.callout;
    if(var_5 != "") {
      var_6 = var_6 + "_" + var_5;
    }

    var_7 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.var_52DA, var_6);
    if(var_7) {
      var_0 notify("destroyed_helicopter");
      self.var_A667 = var_0;
    }

    if(var_1 == "heli_pilot_turret_mp") {
      var_0 scripts\mp\missions::processchallenge("ch_enemy_down");
    }

    scripts\mp\missions::func_3DE3(var_0, self, var_1);
  }
}

heli_damage_monitor(var_0, var_1, var_2) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = var_0;
  self.recentdamageamount = 0;
  if(!scripts\mp\utility::istrue(var_2)) {
    thread heli_health();
  }

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1, var_1);
}

heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    self.empgrenaded = 1;
    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("stop_shooting");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("stop_shooting");
    }

    wait(var_1);
    self.empgrenaded = 0;
    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("turretstatechange");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("turretstatechange");
    }
  }
}

heli_health() {
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self give_fwoosh_perk(3);
  var_0 = 3;
  self give_fwoosh_perk(var_0);
  var_1 = level.heliconfigs[self.streakname];
  for(;;) {
    self waittill("heli_damage_fx");
    if(var_0 > 0 && self.var_E1 >= self.maxhealth) {
      var_0 = 0;
      self give_fwoosh_perk(var_0);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1.enginevfxtag);
      self notify("death");
      break;
    } else {
      if(var_0 > 1 && self.var_E1 >= self.maxhealth * 0.66) {
        var_0 = 1;
        self give_fwoosh_perk(var_0);
        self.currentstate = "heavy smoke";
        stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_1.enginevfxtag);
        playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1.enginevfxtag);
        continue;
      }

      if(var_0 > 2 && self.var_E1 >= self.maxhealth * 0.33) {
        var_0 = 2;
        self give_fwoosh_perk(var_0);
        self.currentstate = "light smoke";
        playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_1.enginevfxtag);
      }
    }
  }
}

heli_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage) {
    thread heli_explode(1);
    return;
  }

  var_0 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, var_0.enginevfxtag);
  thread heli_crash();
}

heli_crash() {
  self notify("crashing");
  self getplayerkillstreakcombatmode();
  var_0 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];
  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(var_0);
  thread heli_explode();
}

heli_secondary_explosions() {
  var_0 = heli_getteamforsoundclip();
  var_1 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_1.enginevfxtag);
  self playSound(level.heli_sound[var_0]["hitsecondary"]);
  wait(3);
  if(!isDefined(self)) {
    return;
  }

  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_1.enginevfxtag);
  self playSound(level.heli_sound[var_0]["hitsecondary"]);
}

heli_spin(var_0) {
  self endon("death");
  var_1 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_1]["hit"]);
  thread spinsoundshortly();
  self givelastonteamwarning(var_0, var_0, var_0);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait(1);
  }
}

spinsoundshortly() {
  self endon("death");
  wait(0.25);
  var_0 = heli_getteamforsoundclip();
  self stoploopsound();
  wait(0.05);
  self playLoopSound(level.heli_sound[var_0]["spinloop"]);
  wait(0.05);
  self playLoopSound(level.heli_sound[var_0]["spinstart"]);
}

heli_explode(var_0) {
  self notify("death");
  if(isDefined(var_0) && isDefined(level.chopper_fx["explode"]["air_death"][self.var_8DA0])) {
    var_1 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.var_8DA0], self gettagorigin("tag_deathfx"), anglesToForward(var_1), anglestoup(var_1));
  } else {
    var_2 = self.origin;
    var_3 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.var_8DA0], var_2, var_3);
  }

  var_4 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_4]["crash"]);
  wait(0.05);
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread heli_leave();
    return 0;
  }

  return 1;
}

heli_leave_on_disconnect(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 waittill("disconnect");
  thread heli_leave();
}

heli_leave_on_changeteams(var_0) {
  self endon("death");
  self endon("helicopter_done");
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return;
  }

  var_0 scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  thread heli_leave();
}

heli_leave_on_spawned(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 waittill("spawned");
  thread heli_leave();
}

heli_leave_on_gameended(var_0) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

heli_leave_on_timeout(var_0) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread heli_leave();
}

fireontarget(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_1 = 15;
  var_2 = 0;
  var_3 = 0;
  foreach(var_5 in level.heli_loop_nodes) {
    var_2++;
    var_3 = var_3 + var_5.origin[2];
  }

  var_7 = var_3 / var_2;
  self notify("newTarget");
  if(isDefined(self.secondarytarget) && self.secondarytarget.var_E1 < self.secondarytarget.maxhealth) {
    return;
  }

  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }

  var_8 = self.primarytarget;
  var_8.antithreat = 0;
  var_9 = self.primarytarget.origin * (1, 1, 0);
  var_10 = self.origin * (0, 0, 1);
  var_11 = var_9 + var_10;
  var_12 = distance2d(self.origin, var_8.origin);
  if(var_12 < 1000) {
    var_1 = 600;
  }

  var_13 = anglesToForward(var_8.angles);
  var_13 = var_13 * (1, 1, 0);
  var_14 = var_11 + var_1 * var_13;
  var_15 = var_14 - var_11;
  var_10 = vectortoangles(var_15);
  var_10 = var_10 * (1, 1, 0);
  thread attackgroundtarget(var_8);
  self vehicle_setspeed(80);
  if(distance2d(self.origin, var_14) < 1000) {
    var_14 = var_14 * 1.5;
  }

  var_14 = var_14 * (1, 1, 0);
  var_14 = var_14 + (0, 0, var_7);
  _setvehgoalpos(var_14, 1, 1);
  self waittill("near_goal");
  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }

  self setlookatent(var_8);
  thread isfacing(10, var_8);
  scripts\engine\utility::waittill_any_timeout(4, "facing");
  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }

  self getplayerkillstreakcombatmode();
  var_11 = var_11 + var_1 * anglesToForward(var_10);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var_11, 1, 1);
  self setmaxpitchroll(30, 30);
  if(isDefined(var_8) && isalive(var_8)) {
    if(isDefined(var_8.antithreat)) {
      var_8.antithreat = var_8.antithreat + 100;
    } else {
      var_8.antithreat = 100;
    }
  }

  scripts\engine\utility::waittill_any_timeout(3, "near_goal");
}

attackgroundtarget(var_0) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetent(var_0);
  waitontargetordeath(var_0, 3);
  if(!isalive(var_0)) {
    self.isattacking = 0;
    return;
  }

  var_1 = distance2dsquared(self.origin, var_0.origin);
  if(var_1 < 640000) {
    thread dropbombs(var_0);
    self.isattacking = 0;
    return;
  }

  if(checkisfacing(50, var_0) && scripts\engine\utility::cointoss()) {
    thread firemissile(var_0);
    self.isattacking = 0;
    return;
  }

  var_2 = weaponfiretime("cobra_20mm_mp");
  var_3 = 0;
  var_4 = 0;
  for(var_5 = 0; var_5 < level.heli_turretclipsize; var_5++) {
    if(!isDefined(self)) {
      break;
    }

    if(self.empgrenaded) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    if(!isalive(var_0)) {
      break;
    }

    if(self.var_E1 >= self.maxhealth) {
      continue;
    }

    if(!checkisfacing(55, var_0)) {
      self stoploopsound();
      var_4 = 0;
      wait(var_2);
      var_5--;
      continue;
    }

    if(var_5 < level.heli_turretclipsize - 1) {
      wait(var_2);
    }

    if(!isDefined(var_0) || !isalive(var_0)) {
      break;
    }

    if(!var_4) {
      self playLoopSound("weap_hind_20mm_fire_npc");
      var_4 = 1;
    }

    self giveflagassistedcapturepoints("cobra_20mm_mp");
    self fireweapon("tag_flash", var_0);
  }

  if(!isDefined(self)) {
    return;
  }

  self stoploopsound();
  var_4 = 0;
  self.isattacking = 0;
}

checkisfacing(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = var_1.origin - self.origin;
  var_2 = var_2 * (1, 1, 0);
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectornormalize(var_3);
  var_2 = vectornormalize(var_2);
  var_4 = vectordot(var_3, var_2);
  var_5 = cos(var_0);
  if(var_4 >= var_5) {
    return 1;
  }

  return 0;
}

isfacing(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  while(isalive(var_1)) {
    var_2 = anglesToForward(self.angles);
    var_3 = var_1.origin - self.origin;
    var_2 = var_2 * (1, 1, 0);
    var_3 = var_3 * (1, 1, 0);
    var_3 = vectornormalize(var_3);
    var_2 = vectornormalize(var_2);
    var_4 = vectordot(var_3, var_2);
    var_5 = cos(var_0);
    if(var_4 >= var_5) {
      self notify("facing");
      break;
    }

    wait(0.1);
  }
}

waitontargetordeath(var_0, var_1) {
  self endon("death");
  self endon("helicopter_done");
  var_0 endon("death");
  var_0 endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", var_1);
}

firemissile(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(level.var_DADB) {
    var_1 = 1;
  } else {
    var_1 = 2;
  }

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(!isDefined(var_0)) {
      return;
    }

    if(scripts\engine\utility::cointoss()) {
      var_3 = scripts\mp\utility::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_right") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    } else {
      var_3 = scripts\mp\utility::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_left") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    }

    var_3 missile_settargetent(var_0);
    var_3.owner = self;
    var_3 missile_setflightmodedirect();
    wait(0.5 / var_1);
  }
}

dropbombs(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(!isDefined(var_0)) {
    return;
  }

  for(var_1 = 0; var_1 < randomintrange(2, 5); var_1++) {
    if(scripts\engine\utility::cointoss()) {
      var_2 = scripts\mp\utility::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_left") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    } else {
      var_2 = scripts\mp\utility::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_right") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

getoriginoffsets(var_0) {
  var_1 = self.origin;
  var_2 = var_0.origin;
  var_3 = 0;
  var_4 = 40;
  var_5 = (0, 0, -196);
  for(var_6 = bulletTrace(var_1 + var_5, var_2 + var_5, 0, self); distancesquared(var_6["position"], var_2 + var_5) > 10 && var_3 < var_4; var_6 = bulletTrace(var_1 + var_5, var_2 + var_5, 0, self)) {
    if(var_1[2] < var_2[2]) {
      var_1 = var_1 + (0, 0, 128);
    } else if(var_1[2] > var_2[2]) {
      var_2 = var_2 + (0, 0, 128);
    } else {
      var_1 = var_1 + (0, 0, 128);
      var_2 = var_2 + (0, 0, 128);
    }

    var_3++;
  }

  var_7 = [];
  var_7["start"] = var_1;
  var_7["end"] = var_2;
  return var_7;
}

traveltonode(var_0) {
  var_1 = getoriginoffsets(var_0);
  if(var_1["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["start"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(var_1["end"] != var_0.origin) {
    if(isDefined(var_0.script_airspeed) && isDefined(var_0.script_accel)) {
      var_2 = var_0.script_airspeed;
      var_3 = var_0.script_accel;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["end"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }
}

_setvehgoalpos(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;
  if(var_2) {
    thread _setvehgoalposadheretomesh(var_0, var_1);
    return;
  }

  self setvehgoalpos(var_0, var_1);
}

_setvehgoalposadheretomesh(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = var_0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, var_2) < 65536) {
      self setvehgoalpos(var_2, var_1);
      break;
    }

    var_3 = vectortoangles(var_2 - self.origin);
    var_4 = anglesToForward(var_3);
    var_5 = self.origin + var_4 * (1, 1, 0) * 250;
    var_6 = (0, 0, 2500);
    var_7 = var_5 + scripts\mp\utility::gethelipilotmeshoffset() + var_6;
    var_8 = var_5 + scripts\mp\utility::gethelipilotmeshoffset() - var_6;
    var_9 = bulletTrace(var_7, var_8, 0, self, 0, 0, 1);
    var_10 = var_9;
    if(isDefined(var_9["entity"]) && var_9["entity"] == self && var_9["normal"][2] > 0.1) {
      var_11 = var_9["position"][2] - 4400;
      var_12 = var_11 - self.origin[2];
      if(var_12 > 256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] + 256);
      } else if(var_12 < -256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] - 256);
      }

      var_10 = var_9["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, 600);
    } else {
      var_10 = var_2;
    }

    self setvehgoalpos(var_10, 0);
    wait(0.15);
  }
}

heli_fly_simple_path(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  for(var_1 = var_0; isDefined(var_1.target); var_1 = var_2) {
    var_2 = getent(var_1.target, "targetname");
    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      var_3 = var_1.script_airspeed;
      var_4 = var_1.script_accel;
    } else {
      var_3 = 30 + randomint(20);
      var_4 = 15 + randomint(15);
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.05);
      continue;
    }

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait(0.05);
      continue;
    }

    self vehicle_setspeed(75, 35);
    if(!isDefined(var_2.target)) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1);
      self waittill("near_goal");
      continue;
    }

    _setvehgoalpos(var_2.origin + self.zoffset, 0);
    self waittill("near_goal");
    self setgoalyaw(var_2.angles[1]);
    self waittillmatch("goal");
  }
}

heli_fly_loop_path(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(var_0);
  for(var_1 = var_0; isDefined(var_1.target); var_1 = var_2) {
    var_2 = getent(var_1.target, "targetname");
    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait(0.25);
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.1);
      continue;
    }

    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      self.desired_speed = var_1.script_airspeed;
      self.desired_accel = var_1.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed = self.desired_speed * 0.5;
      self.desired_accel = self.desired_accel * 0.5;
    }

    if(isDefined(var_2.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait(var_2.script_delay);
      continue;
    }

    _setvehgoalpos(var_2.origin + self.zoffset, 0, 1);
    self waittill("near_goal");
    self setgoalyaw(var_2.angles[1]);
    self waittillmatch("goal");
  }
}

heli_loop_speed_control(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(isDefined(var_0.script_airspeed) && isDefined(var_0.script_accel)) {
    self.desired_speed = var_0.script_airspeed;
    self.desired_accel = var_0.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  var_1 = 0;
  var_2 = 0;
  for(;;) {
    var_3 = self.desired_speed;
    var_4 = self.desired_accel;
    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.05);
      continue;
    }

    if(self.helitype != "flares" && isDefined(self.primarytarget) && !heli_is_threatened()) {
      var_3 = var_3 * 0.25;
    }

    if(var_1 != var_3 || var_2 != var_4) {
      self vehicle_setspeed(75, 35);
      var_1 = var_3;
      var_2 = var_4;
    }

    wait(0.05);
  }
}

heli_is_threatened() {
  if(self.recentdamageamount > 50) {
    return 1;
  }

  if(self.currentstate == "heavy smoke") {
    return 1;
  }

  return 0;
}

func_8D55(var_0) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.05);
      continue;
    }

    var_1 = get_best_area_attack_node(var_0);
    traveltonode(var_1);
    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      var_2 = var_1.script_airspeed;
      var_3 = var_1.script_accel;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1.origin + self.zoffset, 1);
    self setgoalyaw(var_1.angles[1] + level.heli_angle_offset);
    if(level.var_8D56 != 0) {
      self waittill("near_goal");
      wait(level.var_8D56);
      continue;
    }

    if(!isDefined(var_1.script_delay)) {
      self waittill("near_goal");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("goal");
    wait(var_1.script_delay);
  }
}

get_best_area_attack_node(var_0) {
  return updateareanodes(var_0);
}

heli_leave(var_0) {
  self notify("leaving");
  self getplayerkillstreakcombatmode();
  if(isDefined(self.helitype) && self.helitype == "osprey" && isDefined(self.var_C96C)) {
    _setvehgoalpos(self.var_C96C, 1);
    scripts\engine\utility::waittill_any_timeout(5, "goal");
  }

  if(!isDefined(var_0)) {
    var_1 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    var_0 = var_1.origin;
  }

  var_2 = spawn("script_origin", var_0);
  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread wait_and_delete(3);
  }

  var_3 = var_0 - self.origin * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var_3, 1);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  self notify("gone");
  self notify("death");
  wait(0.05);
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

debug_print3d(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_text(var_0, var_1, var_2, var_3, var_4);
  }
}

debug_print3d_simple(var_0, var_1, var_2, var_3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    if(isDefined(var_3)) {
      thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, var_3);
      return;
    }

    thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, 0);
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1 && !isDefined(var_3)) {
    thread draw_line(var_0, var_1, var_2);
    return;
  }

  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_line(var_0, var_1, var_2, var_3);
  }
}

draw_text(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    while(isDefined(var_2)) {
      wait(0.05);
    }

    return;
  }

  for(var_5 = 0; var_5 < var_4; var_5++) {
    if(!isDefined(var_2)) {
      break;
    }

    wait(0.05);
  }
}

draw_line(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait(0.05);
    }

    return;
  }

  wait(0.05);
}

func_184E() {
  level.helis[self getentitynumber()] = self;
}

func_E109(var_0) {
  level.helis[var_0] = undefined;
}

addtolittlebirdlist(var_0) {
  if(isDefined(var_0) && var_0 == "lbSniper") {
    level.lbsniper = self;
  }

  level.littlebirds[self getentitynumber()] = self;
}

func_E111(var_0) {
  var_1 = self getentitynumber();
  self waittill("death");
  if(isDefined(var_0) && var_0 == "lbSniper") {
    level.lbsniper = undefined;
  }

  level.littlebirds[var_1] = undefined;
}

exceededmaxlittlebirds(var_0) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && var_0 == "littlebird_flock") {
    return 1;
  }

  return 0;
}

func_C9D8() {
  self endon("death");
  self endon("disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait(3.5);
  self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

lbonkilled() {
  self endon("gone");
  if(!isDefined(self)) {
    return;
  }

  self notify("crashing");
  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage) {
    scripts\engine\utility::waitframe();
  } else {
    self vehicle_setspeed(25, 5);
    thread lbspin(randomintrange(180, 220));
    wait(randomfloatrange(1, 2));
  }

  lbexplode();
}

lbspin(var_0) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self givelastonteamwarning(var_0, var_0, var_0);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait(1);
  }
}

lbexplode() {
  var_0 = self.origin + (0, 0, 1) - self.origin;
  var_1 = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(var_1), anglestoup(var_1));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

trail_fx(var_0, var_1, var_2) {
  self notify(var_2);
  self endon(var_2);
  self endon("death");
  for(;;) {
    playFXOnTag(var_0, self, var_1);
    wait(0.05);
  }
}

removelittlebird() {
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

  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}