/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter.gsc
**************************************************/

init() {
  var_00 = getEntArray("heli_start", "targetname");
  var_01 = getEntArray("heli_loop_start", "targetname");
  if(!var_00.size && !var_01.size) {
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
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("helicopter", ::usehelicopter);
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
  var_02 = spawnStruct();
  var_02.scorepopup = "destroyed_helicopter";
  var_02.callout = "callout_destroyed_helicopter";
  var_02.samdamagescale = 0.09;
  var_02.enginevfxtag = "tag_engine_left";
  level.heliconfigs["helicopter"] = var_02;
  var_02 = spawnStruct();
  var_02.scorepopup = "destroyed_little_bird";
  var_02.callout = "callout_destroyed_little_bird";
  var_02.samdamagescale = 0.09;
  var_02.enginevfxtag = "tag_engine_left";
  level.heliconfigs["airdrop"] = var_02;
  var_02 = spawnStruct();
  var_02.scorepopup = "destroyed_dronedrop";
  var_02.var_52DA = "dronedrop_destroyed";
  var_02.callout = "callout_destroyed_dronedrop";
  level.heliconfigs["dronedrop"] = var_02;
  var_02 = spawnStruct();
  var_02.scorepopup = "destroyed_pavelow";
  var_02.callout = "callout_destroyed_helicopter_flares";
  var_02.samdamagescale = 0.07;
  var_02.enginevfxtag = "tag_engine_left";
  level.heliconfigs["flares"] = var_02;
  scripts\mp\utility::func_DB8D("helicopter");
}

makehelitype(param_00, param_01, param_02) {
  level.chopper_fx["explode"]["death"][param_00] = loadfx(param_01);
  level.lightfxfunc[param_00] = param_02;
}

addairexplosion(param_00, param_01) {
  level.chopper_fx["explode"]["air_death"][param_00] = loadfx(param_01);
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

usehelicopter(param_00, param_01) {
  return tryusehelicopter(param_00, "helicopter");
}

tryusehelicopter(param_00, param_01) {
  var_02 = 1;
  if(isDefined(level.chopper)) {
    var_03 = 1;
  } else {
    var_03 = 0;
  }

  if(isDefined(level.chopper) && var_03) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");
    if(isDefined(param_01) && param_01 != "helicopter") {
      var_04 = "helicopter_" + param_01;
    } else {
      var_04 = "helicopter";
    }

    var_05 = spawn("script_origin", (0, 0, 0));
    var_05 hide();
    var_05 thread deleteonentnotify(self, "disconnect");
    var_05.player = self;
    var_05.lifeid = param_00;
    var_05.helitype = param_01;
    var_05.streakname = var_04;
    scripts\mp\utility::func_DB8B("helicopter", var_05);
    var_06 = undefined;
    if(!self hasweapon(scripts\engine\utility::getlastweapon())) {
      var_06 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
    } else {
      var_06 = scripts\engine\utility::getlastweapon();
    }

    var_07 = scripts\mp\utility::getkillstreakweapon("helicopter");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_06 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  var_06 = 1;
  func_10DA2(var_04, var_05);
  return 1;
}

deleteonentnotify(param_00, param_01) {
  self endon("death");
  param_00 waittill(param_01);
  self delete();
}

func_10DA2(param_00, param_01) {
  scripts\mp\utility::incrementfauxvehiclecount();
  var_02 = undefined;
  if(!isDefined(param_01)) {
    param_01 = "";
  }

  var_03 = "helicopter";
  var_04 = self.pers["team"];
  var_02 = level.var_8D96[randomint(level.var_8D96.size)];
  scripts\mp\matchdata::logkillstreakevent(var_03, self.origin);
  thread func_8D9B(param_00, self, var_02, self.pers["team"], param_01);
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
  var_00 = self.team;
  if(level.multiteambased) {
    var_00 = "axis";
  }

  return var_00;
}

func_1072E(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnhelicopter(param_00, param_01, param_02, param_03, param_04);
  if(!isDefined(var_05)) {
    return undefined;
  }

  if(param_04 == "vehicle_battle_hind") {
    var_05.var_8DA0 = "cobra";
  } else {
    var_05.var_8DA0 = level.var_8DA1[param_04];
  }

  var_05 thread[[level.lightfxfunc[var_05.var_8DA0]]]();
  var_05 func_184E();
  var_05.zoffset = (0, 0, var_05 gettagorigin("tag_origin")[2] - var_05 gettagorigin("tag_ground")[2]);
  var_05.attractor = missile_createattractorent(var_05, level.var_8D2E, level.var_8D2D);
  return var_05;
}

func_8DB6(param_00) {
  if(gettime() - level.var_A99A < 6000) {
    return;
  }

  level.var_A99A = gettime();
  var_01 = randomint(level.var_8DB6[param_00].size);
  var_02 = level.var_8DB6[param_00][var_01];
  var_03 = scripts\mp\teams::getteamvoiceprefix(self.team) + var_02;
  self playlocalsound(var_03);
}

updateareanodes(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_03.var_1314F = [];
    var_03.var_C056 = 0;
  }

  foreach(var_06 in level.players) {
    if(!isalive(var_06)) {
      continue;
    }

    if(var_06.team == self.team) {
      continue;
    }

    foreach(var_03 in param_00) {
      if(distancesquared(var_06.origin, var_03.origin) > 1048576) {
        continue;
      }

      var_03.var_1314F[var_03.var_1314F.size] = var_06;
    }
  }

  var_0A = param_00[0];
  foreach(var_03 in param_00) {
    var_0C = getent(var_03.target, "targetname");
    foreach(var_06 in var_03.var_1314F) {
      var_03.var_C056 = var_03.var_C056 + 1;
      if(bullettracepassed(var_06.origin + (0, 0, 32), var_0C.origin, 0, var_06)) {
        var_03.var_C056 = var_03.var_C056 + 3;
      }
    }

    if(var_03.var_C056 > var_0A.var_C056) {
      var_0A = var_03;
    }
  }

  return getent(var_0A.target, "targetname");
}

func_8D9B(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_02.origin;
  var_06 = param_02.angles;
  var_07 = "cobra_mp";
  var_08 = "vehicle_battle_hind";
  var_09 = func_1072E(param_01, var_05, var_06, var_07, var_08);
  if(!isDefined(var_09)) {
    return;
  }

  level.chopper = var_09;
  if(param_03 == "allies") {
    level.allieschopper = var_09;
  } else {
    level.axischopper = var_09;
  }

  var_09.helitype = param_04;
  var_09.lifeid = param_00;
  var_09.team = param_03;
  var_09.pers["team"] = param_03;
  var_09.triggerportableradarping = param_01;
  var_09 setotherent(param_01);
  var_09.var_10DCD = param_02;
  var_09.maxhealth = level.var_8D73;
  var_09.var_11568 = level.var_8D9A;
  var_09.primarytarget = undefined;
  var_09.secondarytarget = undefined;
  var_09.var_4F = undefined;
  var_09.currentstate = "ok";
  var_09 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", param_01);
  var_09.empgrenaded = 0;
  if(param_04 == "flares" || param_04 == "minigun") {
    var_09 thread scripts\mp\killstreaks\_flares::flares_monitor(1);
  }

  var_09 thread heli_leave_on_disconnect(param_01);
  var_09 thread heli_leave_on_changeteams(param_01);
  var_09 thread heli_leave_on_gameended(param_01);
  var_09 thread heli_damage_monitor(param_04);
  var_09 thread heli_watchempdamage();
  var_09 thread heli_watchdeath();
  var_09 thread func_8D49();
  var_09 endon("helicopter_done");
  var_09 endon("crashing");
  var_09 endon("leaving");
  var_09 endon("death");
  var_0A = getEntArray("heli_attack_area", "targetname");
  var_0B = undefined;
  var_0B = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  var_09 heli_fly_simple_path(param_02);
  var_09 thread heli_targeting();
  var_09 thread heli_leave_on_timeout(60);
  var_09 thread heli_fly_loop_path(var_0B);
}

func_8D49() {
  var_00 = self getentitynumber();
  scripts\engine\utility::waittill_any_3("death", "crashing", "leaving");
  func_E109(var_00);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  var_01 = undefined;
  var_02 = scripts\mp\utility::func_DB94("helicopter");
  if(!isDefined(var_02)) {
    level.chopper = undefined;
    return;
  }

  var_01 = var_02.player;
  var_03 = var_02.lifeid;
  var_04 = var_02.streakname;
  var_05 = var_02.helitype;
  var_02 delete();
  if(isDefined(var_01) && var_01.sessionstate == "playing" || var_01.sessionstate == "dead") {
    var_01 func_10DA2(var_03, var_05);
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
    var_00 = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;
    foreach(var_02 in level.characters) {
      wait(0.05);
      if(!func_3922(var_02)) {
        continue;
      }

      var_00[var_00.size] = var_02;
    }

    if(var_00.size) {
      for(var_04 = func_7E00(var_00); !isDefined(var_04); var_04 = func_7E00(var_00)) {
        wait(0.05);
      }

      self.primarytarget = var_04;
      self notify("primary acquired");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait(0.25);
  }
}

func_3922(param_00) {
  var_01 = 1;
  if(!isalive(param_00) || isDefined(param_00.sessionstate) && param_00.sessionstate != "playing") {
    return 0;
  }

  if(self.helitype == "remote_mortar") {
    if(param_00 giveperks(self.origin, self) < 1) {
      return 0;
    }
  }

  if(distance(param_00.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }

  if(!self.triggerportableradarping scripts\mp\utility::isenemy(param_00)) {
    return 0;
  }

  if(isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5) {
    return 0;
  }

  if(param_00 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  var_02 = self.origin + (0, 0, -160);
  var_03 = anglesToForward(self.angles);
  var_04 = var_02 + 144 * var_03;
  if(param_00 giveperks(var_04, self) < level.var_8D97) {
    return 0;
  }

  return var_01;
}

func_7E00(param_00) {
  foreach(var_02 in param_00) {
    if(!isDefined(var_02)) {
      continue;
    }

    update_player_threat(var_02);
  }

  var_04 = 0;
  var_05 = undefined;
  var_06 = getEntArray("minimap_corner", "targetname");
  foreach(var_02 in param_00) {
    if(!isDefined(var_02)) {
      continue;
    }

    if(var_06.size == 2) {
      var_08 = var_06[0].origin;
      var_09 = var_06[0].origin;
      if(var_06[1].origin[0] > var_09[0]) {
        var_09 = (var_06[1].origin[0], var_09[1], var_09[2]);
      } else {
        var_08 = (var_06[1].origin[0], var_08[1], var_08[2]);
      }

      if(var_06[1].origin[1] > var_09[1]) {
        var_09 = (var_09[0], var_06[1].origin[1], var_09[2]);
      } else {
        var_08 = (var_08[0], var_06[1].origin[1], var_08[2]);
      }

      if(var_02.origin[0] < var_08[0] || var_02.origin[0] > var_09[0] || var_02.origin[1] < var_08[1] || var_02.origin[1] > var_09[1]) {
        continue;
      }
    }

    if(var_02.threatlevel < var_04) {
      continue;
    }

    if(!bullettracepassed(var_02.origin + (0, 0, 32), self.origin, 0, self)) {
      wait(0.05);
      continue;
    }

    var_04 = var_02.threatlevel;
    var_05 = var_02;
  }

  return var_05;
}

update_player_threat(param_00) {
  param_00.threatlevel = 0;
  var_01 = distance(param_00.origin, self.origin);
  param_00.threatlevel = param_00.threatlevel + level.heli_visual_range - var_01 / level.heli_visual_range * 100;
  if(isDefined(self.var_4F) && param_00 == self.var_4F) {
    param_00.threatlevel = param_00.threatlevel + 100;
  }

  if(isplayer(param_00)) {
    param_00.threatlevel = param_00.threatlevel + param_00.destroynavrepulsor * 4;
  }

  if(isDefined(param_00.antithreat)) {
    param_00.threatlevel = param_00.threatlevel - param_00.antithreat;
  }

  if(param_00.threatlevel <= 0) {
    param_00.threatlevel = 1;
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

addrecentdamage(param_00) {
  self endon("death");
  self.recentdamageamount = self.recentdamageamount + param_00;
  wait(4);
  self.recentdamageamount = self.recentdamageamount - param_00;
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_00)) {
    if((isDefined(self.triggerportableradarping) && param_00 == self.triggerportableradarping && self.streakname == "heli_sniper") || isDefined(param_00.class) && param_00.class == "worldspawn" || param_00 == self) {
      return -1;
    }
  }

  var_05 = param_03;
  var_06 = 2;
  var_07 = 3;
  var_08 = 4;
  if(isDefined(self.helitype) && self.helitype == "dronedrop") {
    var_06 = 1;
    var_07 = 1;
    var_08 = 2;
  }

  var_05 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(param_00, param_01, param_02, var_05, self.maxhealth, var_06, var_07, var_08);
  thread addrecentdamage(var_05);
  self notify("heli_damage_fx");
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    var_05 = 0;
  }

  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00)) {
    var_04 = level.heliconfigs[self.streakname];
    var_05 = "";
    if(isDefined(self.streakinfo)) {
      var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
    }

    var_06 = var_04.callout;
    if(var_05 != "") {
      var_06 = var_06 + "_" + var_05;
    }

    var_07 = scripts\mp\damage::onkillstreakkilled(self.streakname, param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.var_52DA, var_06);
    if(var_07) {
      param_00 notify("destroyed_helicopter");
      self.var_A667 = param_00;
    }

    if(param_01 == "heli_pilot_turret_mp") {
      param_00 scripts\mp\missions::processchallenge("ch_enemy_down");
    }

    scripts\mp\missions::func_3DE3(param_00, self, param_01);
  }
}

heli_damage_monitor(param_00, param_01, param_02) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = param_00;
  self.recentdamageamount = 0;
  if(!scripts\mp\utility::istrue(param_02)) {
    thread heli_health();
  }

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1, param_01);
}

heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    self.empgrenaded = 1;
    if(isDefined(self.mgturretleft)) {
      self.mgturretleft notify("stop_shooting");
    }

    if(isDefined(self.mgturretright)) {
      self.mgturretright notify("stop_shooting");
    }

    wait(var_01);
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
  var_00 = 3;
  self give_fwoosh_perk(var_00);
  var_01 = level.heliconfigs[self.streakname];
  for(;;) {
    self waittill("heli_damage_fx");
    if(var_00 > 0 && self.var_E1 >= self.maxhealth) {
      var_00 = 0;
      self give_fwoosh_perk(var_00);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_01.enginevfxtag);
      self notify("death");
      break;
    } else {
      if(var_00 > 1 && self.var_E1 >= self.maxhealth * 0.66) {
        var_00 = 1;
        self give_fwoosh_perk(var_00);
        self.currentstate = "heavy smoke";
        stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_01.enginevfxtag);
        playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_01.enginevfxtag);
        continue;
      }

      if(var_00 > 2 && self.var_E1 >= self.maxhealth * 0.33) {
        var_00 = 2;
        self give_fwoosh_perk(var_00);
        self.currentstate = "light smoke";
        playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_01.enginevfxtag);
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

  var_00 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, var_00.enginevfxtag);
  thread heli_crash();
}

heli_crash() {
  self notify("crashing");
  self getplayerkillstreakcombatmode();
  var_00 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];
  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(var_00);
  thread heli_explode();
}

heli_secondary_explosions() {
  var_00 = heli_getteamforsoundclip();
  var_01 = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_01.enginevfxtag);
  self playSound(level.heli_sound[var_00]["hitsecondary"]);
  wait(3);
  if(!isDefined(self)) {
    return;
  }

  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_01.enginevfxtag);
  self playSound(level.heli_sound[var_00]["hitsecondary"]);
}

heli_spin(param_00) {
  self endon("death");
  var_01 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_01]["hit"]);
  thread spinsoundshortly();
  self givelastonteamwarning(param_00, param_00, param_00);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + param_00 * 0.9);
    wait(1);
  }
}

spinsoundshortly() {
  self endon("death");
  wait(0.25);
  var_00 = heli_getteamforsoundclip();
  self stoploopsound();
  wait(0.05);
  self playLoopSound(level.heli_sound[var_00]["spinloop"]);
  wait(0.05);
  self playLoopSound(level.heli_sound[var_00]["spinstart"]);
}

heli_explode(param_00) {
  self notify("death");
  if(isDefined(param_00) && isDefined(level.chopper_fx["explode"]["air_death"][self.var_8DA0])) {
    var_01 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.var_8DA0], self gettagorigin("tag_deathfx"), anglesToForward(var_01), anglestoup(var_01));
  } else {
    var_02 = self.origin;
    var_03 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.var_8DA0], var_02, var_03);
  }

  var_04 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[var_04]["crash"]);
  wait(0.05);
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

check_owner() {
  if(!isDefined(self.triggerportableradarping) || !isDefined(self.triggerportableradarping.pers["team"]) || self.triggerportableradarping.pers["team"] != self.team) {
    thread heli_leave();
    return 0;
  }

  return 1;
}

heli_leave_on_disconnect(param_00) {
  self endon("death");
  self endon("helicopter_done");
  param_00 waittill("disconnect");
  thread heli_leave();
}

heli_leave_on_changeteams(param_00) {
  self endon("death");
  self endon("helicopter_done");
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return;
  }

  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  thread heli_leave();
}

heli_leave_on_spawned(param_00) {
  self endon("death");
  self endon("helicopter_done");
  param_00 waittill("spawned");
  thread heli_leave();
}

heli_leave_on_gameended(param_00) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

heli_leave_on_timeout(param_00) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  thread heli_leave();
}

fireontarget(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_01 = 15;
  var_02 = 0;
  var_03 = 0;
  foreach(var_05 in level.heli_loop_nodes) {
    var_02++;
    var_03 = var_03 + var_05.origin[2];
  }

  var_07 = var_03 / var_02;
  self notify("newTarget");
  if(isDefined(self.secondarytarget) && self.secondarytarget.var_E1 < self.secondarytarget.maxhealth) {
    return;
  }

  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }

  var_08 = self.primarytarget;
  var_08.antithreat = 0;
  var_09 = self.primarytarget.origin * (1, 1, 0);
  var_0A = self.origin * (0, 0, 1);
  var_0B = var_09 + var_0A;
  var_0C = distance2d(self.origin, var_08.origin);
  if(var_0C < 1000) {
    var_01 = 600;
  }

  var_0D = anglesToForward(var_08.angles);
  var_0D = var_0D * (1, 1, 0);
  var_0E = var_0B + var_01 * var_0D;
  var_0F = var_0E - var_0B;
  var_10 = vectortoangles(var_0F);
  var_10 = var_10 * (1, 1, 0);
  thread attackgroundtarget(var_08);
  self vehicle_setspeed(80);
  if(distance2d(self.origin, var_0E) < 1000) {
    var_0E = var_0E * 1.5;
  }

  var_0E = var_0E * (1, 1, 0);
  var_0E = var_0E + (0, 0, var_07);
  _setvehgoalpos(var_0E, 1, 1);
  self waittill("near_goal");
  if(!isDefined(var_08) || !isalive(var_08)) {
    return;
  }

  self setlookatent(var_08);
  thread isfacing(10, var_08);
  scripts\engine\utility::waittill_any_timeout_1(4, "facing");
  if(!isDefined(var_08) || !isalive(var_08)) {
    return;
  }

  self getplayerkillstreakcombatmode();
  var_11 = var_0B + var_01 * anglesToForward(var_10);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var_11, 1, 1);
  self setmaxpitchroll(30, 30);
  if(isDefined(var_08) && isalive(var_08)) {
    if(isDefined(var_08.antithreat)) {
      var_08.antithreat = var_08.antithreat + 100;
    } else {
      var_08.antithreat = 100;
    }
  }

  scripts\engine\utility::waittill_any_timeout_1(3, "near_goal");
}

attackgroundtarget(param_00) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetent(param_00);
  waitontargetordeath(param_00, 3);
  if(!isalive(param_00)) {
    self.isattacking = 0;
    return;
  }

  var_01 = distance2dsquared(self.origin, param_00.origin);
  if(var_01 < 640000) {
    thread dropbombs(param_00);
    self.isattacking = 0;
    return;
  }

  if(checkisfacing(50, param_00) && scripts\engine\utility::cointoss()) {
    thread firemissile(param_00);
    self.isattacking = 0;
    return;
  }

  var_02 = weaponfiretime("cobra_20mm_mp");
  var_03 = 0;
  var_04 = 0;
  for(var_05 = 0; var_05 < level.heli_turretclipsize; var_05++) {
    if(!isDefined(self)) {
      break;
    }

    if(self.empgrenaded) {
      break;
    }

    if(!isDefined(param_00)) {
      break;
    }

    if(!isalive(param_00)) {
      break;
    }

    if(self.var_E1 >= self.maxhealth) {
      continue;
    }

    if(!checkisfacing(55, param_00)) {
      self stoploopsound();
      var_04 = 0;
      wait(var_02);
      var_05--;
      continue;
    }

    if(var_05 < level.heli_turretclipsize - 1) {
      wait(var_02);
    }

    if(!isDefined(param_00) || !isalive(param_00)) {
      break;
    }

    if(!var_04) {
      self playLoopSound("weap_hind_20mm_fire_npc");
      var_04 = 1;
    }

    self giveflagassistedcapturepoints("cobra_20mm_mp");
    self fireweapon("tag_flash", param_00);
  }

  if(!isDefined(self)) {
    return;
  }

  self stoploopsound();
  var_04 = 0;
  self.isattacking = 0;
}

checkisfacing(param_00, param_01) {
  self endon("death");
  self endon("leaving");
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  var_02 = anglesToForward(self.angles);
  var_03 = param_01.origin - self.origin;
  var_02 = var_02 * (1, 1, 0);
  var_03 = var_03 * (1, 1, 0);
  var_03 = vectornormalize(var_03);
  var_02 = vectornormalize(var_02);
  var_04 = vectordot(var_03, var_02);
  var_05 = cos(param_00);
  if(var_04 >= var_05) {
    return 1;
  }

  return 0;
}

isfacing(param_00, param_01) {
  self endon("death");
  self endon("leaving");
  if(!isDefined(param_00)) {
    param_00 = 10;
  }

  while(isalive(param_01)) {
    var_02 = anglesToForward(self.angles);
    var_03 = param_01.origin - self.origin;
    var_02 = var_02 * (1, 1, 0);
    var_03 = var_03 * (1, 1, 0);
    var_03 = vectornormalize(var_03);
    var_02 = vectornormalize(var_02);
    var_04 = vectordot(var_03, var_02);
    var_05 = cos(param_00);
    if(var_04 >= var_05) {
      self notify("facing");
      break;
    }

    wait(0.1);
  }
}

waitontargetordeath(param_00, param_01) {
  self endon("death");
  self endon("helicopter_done");
  param_00 endon("death");
  param_00 endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", param_01);
}

firemissile(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(level.var_DADB) {
    var_01 = 1;
  } else {
    var_01 = 2;
  }

  for(var_02 = 0; var_02 < var_01; var_02++) {
    if(!isDefined(param_00)) {
      return;
    }

    if(scripts\engine\utility::cointoss()) {
      var_03 = scripts\mp\utility::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_right") - (0, 0, 64), param_00.origin, self.triggerportableradarping);
      var_03.vehicle_fired_from = self;
    } else {
      var_03 = scripts\mp\utility::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_left") - (0, 0, 64), param_00.origin, self.triggerportableradarping);
      var_03.vehicle_fired_from = self;
    }

    var_03 missile_settargetent(param_00);
    var_03.triggerportableradarping = self;
    var_03 missile_setflightmodedirect();
    wait(0.5 / var_01);
  }
}

dropbombs(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(!isDefined(param_00)) {
    return;
  }

  for(var_01 = 0; var_01 < randomintrange(2, 5); var_01++) {
    if(scripts\engine\utility::cointoss()) {
      var_02 = scripts\mp\utility::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_left") - (0, 0, 45), param_00.origin, self.triggerportableradarping);
      var_02.vehicle_fired_from = self;
    } else {
      var_02 = scripts\mp\utility::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_right") - (0, 0, 45), param_00.origin, self.triggerportableradarping);
      var_02.vehicle_fired_from = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

getoriginoffsets(param_00) {
  var_01 = self.origin;
  var_02 = param_00.origin;
  var_03 = 0;
  var_04 = 40;
  var_05 = (0, 0, -196);
  for(var_06 = bulletTrace(var_01 + var_05, var_02 + var_05, 0, self); distancesquared(var_06["position"], var_02 + var_05) > 10 && var_03 < var_04; var_06 = bulletTrace(var_01 + var_05, var_02 + var_05, 0, self)) {
    if(var_01[2] < var_02[2]) {
      var_01 = var_01 + (0, 0, 128);
    } else if(var_01[2] > var_02[2]) {
      var_02 = var_02 + (0, 0, 128);
    } else {
      var_01 = var_01 + (0, 0, 128);
      var_02 = var_02 + (0, 0, 128);
    }

    var_03++;
  }

  var_07 = [];
  var_07["start"] = var_01;
  var_07["end"] = var_02;
  return var_07;
}

traveltonode(param_00) {
  var_01 = getoriginoffsets(param_00);
  if(var_01["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_01["start"] + (0, 0, 30), 0);
    self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(var_01["end"] != param_00.origin) {
    if(isDefined(param_00.script_airspeed) && isDefined(param_00.script_accel)) {
      var_02 = param_00.script_airspeed;
      var_03 = param_00.script_accel;
    } else {
      var_02 = 30 + randomint(20);
      var_03 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_01["end"] + (0, 0, 30), 0);
    self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }
}

_setvehgoalpos(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  param_02 = 0;
  if(param_02) {
    thread _setvehgoalposadheretomesh(param_00, param_01);
    return;
  }

  self setvehgoalpos(param_00, param_01);
}

_setvehgoalposadheretomesh(param_00, param_01) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_02 = param_00;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, var_02) < 65536) {
      self setvehgoalpos(var_02, param_01);
      break;
    }

    var_03 = vectortoangles(var_02 - self.origin);
    var_04 = anglesToForward(var_03);
    var_05 = self.origin + var_04 * (1, 1, 0) * 250;
    var_06 = (0, 0, 2500);
    var_07 = var_05 + scripts\mp\utility::gethelipilotmeshoffset() + var_06;
    var_08 = var_05 + scripts\mp\utility::gethelipilotmeshoffset() - var_06;
    var_09 = bulletTrace(var_07, var_08, 0, self, 0, 0, 1);
    var_0A = var_09;
    if(isDefined(var_09["entity"]) && var_09["entity"] == self && var_09["normal"][2] > 0.1) {
      var_0B = var_09["position"][2] - 4400;
      var_0C = var_0B - self.origin[2];
      if(var_0C > 256) {
        var_09["position"] = var_09["position"] * (1, 1, 0);
        var_09["position"] = var_09["position"] + (0, 0, self.origin[2] + 256);
      } else if(var_0C < -256) {
        var_09["position"] = var_09["position"] * (1, 1, 0);
        var_09["position"] = var_09["position"] + (0, 0, self.origin[2] - 256);
      }

      var_0A = var_09["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, 600);
    } else {
      var_0A = var_02;
    }

    self setvehgoalpos(var_0A, 0);
    wait(0.15);
  }
}

heli_fly_simple_path(param_00) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  for(var_01 = param_00; isDefined(var_01.target); var_01 = var_02) {
    var_02 = getent(var_01.target, "targetname");
    if(isDefined(var_01.script_airspeed) && isDefined(var_01.script_accel)) {
      var_03 = var_01.script_airspeed;
      var_04 = var_01.script_accel;
    } else {
      var_03 = 30 + randomint(20);
      var_04 = 15 + randomint(15);
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
    if(!isDefined(var_02.target)) {
      _setvehgoalpos(var_02.origin + self.zoffset, 1);
      self waittill("near_goal");
      continue;
    }

    _setvehgoalpos(var_02.origin + self.zoffset, 0);
    self waittill("near_goal");
    self setgoalyaw(var_02.angles[1]);
    self waittillmatch("goal");
  }
}

heli_fly_loop_path(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(param_00);
  for(var_01 = param_00; isDefined(var_01.target); var_01 = var_02) {
    var_02 = getent(var_01.target, "targetname");
    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait(0.25);
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.1);
      continue;
    }

    if(isDefined(var_01.script_airspeed) && isDefined(var_01.script_accel)) {
      self.desired_speed = var_01.script_airspeed;
      self.desired_accel = var_01.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed = self.desired_speed * 0.5;
      self.desired_accel = self.desired_accel * 0.5;
    }

    if(isDefined(var_02.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(var_02.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait(var_02.script_delay);
      continue;
    }

    _setvehgoalpos(var_02.origin + self.zoffset, 0, 1);
    self waittill("near_goal");
    self setgoalyaw(var_02.angles[1]);
    self waittillmatch("goal");
  }
}

heli_loop_speed_control(param_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(isDefined(param_00.script_airspeed) && isDefined(param_00.script_accel)) {
    self.desired_speed = param_00.script_airspeed;
    self.desired_accel = param_00.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  var_01 = 0;
  var_02 = 0;
  for(;;) {
    var_03 = self.desired_speed;
    var_04 = self.desired_accel;
    if(isDefined(self.isattacking) && self.isattacking) {
      wait(0.05);
      continue;
    }

    if(self.helitype != "flares" && isDefined(self.primarytarget) && !heli_is_threatened()) {
      var_03 = var_03 * 0.25;
    }

    if(var_01 != var_03 || var_02 != var_04) {
      self vehicle_setspeed(75, 35);
      var_01 = var_03;
      var_02 = var_04;
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

func_8D55(param_00) {
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

    var_01 = get_best_area_attack_node(param_00);
    traveltonode(var_01);
    if(isDefined(var_01.script_airspeed) && isDefined(var_01.script_accel)) {
      var_02 = var_01.script_airspeed;
      var_03 = var_01.script_accel;
    } else {
      var_02 = 30 + randomint(20);
      var_03 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_01.origin + self.zoffset, 1);
    self setgoalyaw(var_01.angles[1] + level.heli_angle_offset);
    if(level.var_8D56 != 0) {
      self waittill("near_goal");
      wait(level.var_8D56);
      continue;
    }

    if(!isDefined(var_01.script_delay)) {
      self waittill("near_goal");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("goal");
    wait(var_01.script_delay);
  }
}

get_best_area_attack_node(param_00) {
  return updateareanodes(param_00);
}

heli_leave(param_00) {
  self notify("leaving");
  self getplayerkillstreakcombatmode();
  if(isDefined(self.helitype) && self.helitype == "osprey" && isDefined(self.var_C96C)) {
    _setvehgoalpos(self.var_C96C, 1);
    scripts\engine\utility::waittill_any_timeout_1(5, "goal");
  }

  if(!isDefined(param_00)) {
    var_01 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    param_00 = var_01.origin;
  }

  var_02 = spawn("script_origin", param_00);
  if(isDefined(var_02)) {
    self setlookatent(var_02);
    var_02 thread wait_and_delete(3);
  }

  var_03 = param_00 - self.origin * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var_03, 1);
  scripts\engine\utility::waittill_any_timeout_1(12, "goal");
  self notify("gone");
  self notify("death");
  wait(0.05);
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

wait_and_delete(param_00) {
  self endon("death");
  level endon("game_ended");
  wait(param_00);
  self delete();
}

debug_print3d(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_text(param_00, param_01, param_02, param_03, param_04);
  }
}

debug_print3d_simple(param_00, param_01, param_02, param_03) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    if(isDefined(param_03)) {
      thread draw_text(param_00, (0.8, 0.8, 0.8), param_01, param_02, param_03);
      return;
    }

    thread draw_text(param_00, (0.8, 0.8, 0.8), param_01, param_02, 0);
  }
}

debug_line(param_00, param_01, param_02, param_03) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1 && !isDefined(param_03)) {
    thread draw_line(param_00, param_01, param_02);
    return;
  }

  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    thread draw_line(param_00, param_01, param_02, param_03);
  }
}

draw_text(param_00, param_01, param_02, param_03, param_04) {
  if(param_04 == 0) {
    while(isDefined(param_02)) {
      wait(0.05);
    }

    return;
  }

  for(var_05 = 0; var_05 < param_04; var_05++) {
    if(!isDefined(param_02)) {
      break;
    }

    wait(0.05);
  }
}

draw_line(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    for(var_04 = 0; var_04 < param_03; var_04++) {
      wait(0.05);
    }

    return;
  }

  wait(0.05);
}

func_184E() {
  level.helis[self getentitynumber()] = self;
}

func_E109(param_00) {
  level.helis[param_00] = undefined;
}

addtolittlebirdlist(param_00) {
  if(isDefined(param_00) && param_00 == "lbSniper") {
    level.lbsniper = self;
  }

  level.littlebirds[self getentitynumber()] = self;
}

func_E111(param_00) {
  var_01 = self getentitynumber();
  self waittill("death");
  if(isDefined(param_00) && param_00 == "lbSniper") {
    level.lbsniper = undefined;
  }

  level.littlebirds[var_01] = undefined;
}

exceededmaxlittlebirds(param_00) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && param_00 == "littlebird_flock") {
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

lbspin(param_00) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self givelastonteamwarning(param_00, param_00, param_00);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + param_00 * 0.9);
    wait(1);
  }
}

lbexplode() {
  var_00 = self.origin + (0, 0, 1) - self.origin;
  var_01 = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(var_01), anglestoup(var_01));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

trail_fx(param_00, param_01, param_02) {
  self notify(param_02);
  self endon(param_02);
  self endon("death");
  for(;;) {
    playFXOnTag(param_00, self, param_01);
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