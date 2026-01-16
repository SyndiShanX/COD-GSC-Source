/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_helicopter.gsc
********************************/

precachehelicopter(var_0) {
  precachemodel(var_0);
}

precacheassets() {
  precacheitem("cobra_ffar_mp");
  precacheitem("hind_ffar_mp");
  precacheitem("cobra_20mm_mp");
  level.cobra_missile_models = [];
  level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
  precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
  level.heli_sound["allies"]["hit"] = "h1_ks_chopper_damage_exp";
  level.heli_sound["allies"]["hitsecondary"] = "h1_ks_chopper_damage_exp";
  level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["allies"]["spinloop"] = "h1_ks_chopper_death_spin_mid";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "h1_ks_chopper_crash_mid";
  level.heli_sound["allies"]["missilefire"] = "h1_ks_chopper_missile_shot";
  level.heli_sound["axis"]["hit"] = "h1_ks_chopper_damage_exp";
  level.heli_sound["axis"]["hitsecondary"] = "h1_ks_chopper_damage_exp";
  level.heli_sound["axis"]["damaged"] = "hind_helicopter_damaged";
  level.heli_sound["axis"]["spinloop"] = "h1_ks_chopper_death_spin_mid";
  level.heli_sound["axis"]["spinstart"] = "hind_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "h1_ks_chopper_crash_mid";
  level.heli_sound["axis"]["missilefire"] = "h1_ks_chopper_missile_shot";
}

heli_path_graph() {
  var_0 = getentorstructarray("heli_start", "targetname");
  var_1 = getentorstructarray("heli_dest", "targetname");
  var_2 = getentorstructarray("heli_loop_start", "targetname");
  var_3 = getentorstructarray("heli_leave", "targetname");
  var_4 = getentorstructarray("heli_crash_start", "targetname");

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = [];
    var_7 = var_1[var_5];
    var_8 = getentorstruct(var_7.target, "targetname");

    for (var_9 = 0; var_9 < var_0.size; var_9++) {
      var_10 = 0;

      for (var_11 = var_0[var_9]; isdefined(var_11.target); var_11 = var_12) {
        var_12 = getentorstruct(var_11.target, "targetname");

        if(var_12.origin == var_8.origin) {
          var_10 = 1;
          break;
        }

        debug_print3d_simple("+", var_11, (0, 0, -10));

        if(isdefined(var_12.target)) {
          var_13 = getentorstruct(var_12.target, "targetname");

          if(isdefined(var_13) && isdefined(var_13.origin))
            debug_line(var_12.origin, var_13.origin, (0.25, 0.5, 0.25));
        }

        if(isdefined(var_11.script_delay))
          debug_print3d_simple("Wait: " + var_11.script_delay, var_11, (0, 0, 10));
      }

      if(var_10)
        var_6[var_6.size] = getentorstruct(var_0[var_9].target, "targetname");
    }

    level.heli_paths[level.heli_paths.size] = var_6;
  }

  for (var_5 = 0; var_5 < var_2.size; var_5++) {
    var_14 = getentorstruct(var_2[var_5].target, "targetname");
    level.heli_loop_paths[level.heli_loop_paths.size] = var_14;
  }

  for (var_5 = 0; var_5 < var_3.size; var_5++)
    level.heli_leavenodes[level.heli_leavenodes.size] = var_3[var_5];

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isdefined(var_4[var_5].target))
      var_15 = getentorstruct(var_4[var_5].target, "targetname");
    else
      var_15 = var_4[var_5];

    level.heli_crash_paths[level.heli_crash_paths.size] = var_15;
  }
}

getentorstruct(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  return common_scripts\utility::getstruct(var_0, var_1);
}

getentorstructarray(var_0, var_1) {
  var_2 = common_scripts\utility::getstructarray(var_0, var_1);
  var_3 = getentarray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = common_scripts\utility::array_combine(var_2, var_3);

  return var_2;
}

init() {
  var_0 = getentorstructarray("heli_start", "targetname");
  var_1 = getentorstructarray("heli_loop_start", "targetname");

  if(!var_0.size && !var_1.size) {
    return;
  }
  precacheassets();
  precachehelicopter("vehicle_cobra_helicopter_fly");
  precachehelicopter("h1_vehicle_mi24_hind");
  level.chopper = undefined;
  level.heli_paths = [];
  level.heli_loop_paths = [];
  level.heli_leavenodes = [];
  level.heli_crash_paths = [];
  thread heli_update_global_dvars();
  level.chopper_fx["explode"]["death"] = loadfx("fx\explosions\helicopter_explosion_cobra");
  level.chopper_fx["explode"]["large"] = loadfx("fx\explosions\aerial_explosion_large");
  level.chopper_fx["explode"]["medium"] = loadfx("fx\explosions\aerial_explosion");
  level.chopper_fx["smoke"]["trail"] = loadfx("vfx\trail\trail_smk_white_heli");
  level.chopper_fx["fire"]["trail"]["medium"] = loadfx("vfx\trail\trail_smk_black_heli");
  level.chopper_fx["fire"]["trail"]["large"] = loadfx("vfx\trail\trail_fire_smoke_l");
  heli_path_graph();
}

heli_update_global_dvars() {
  level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax", "1");
  level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof", "5");
  level.heli_armor = heli_get_dvar_int("scr_heli_armor", "500");
  level.heli_rage_missile = heli_get_dvar("scr_heli_rage_missile", "5");
  level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth", "1100");
  level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max", "3");
  level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait", "2");
  level.heli_debug = heli_get_dvar_int("scr_heli_debug", "0");
  level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay", "0.5");
  level.heli_turretreloadtime = heli_get_dvar("scr_heli_turretReloadTime", "1.5");
  level.heli_turretclipsize = heli_get_dvar_int("scr_heli_turretClipSize", "40");
  level.heli_visual_range = heli_get_dvar_int("scr_heli_visual_range", "3500");
  level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade", "0");
  level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection", "5");
  level.heli_turret_engage_dist = heli_get_dvar_int("scr_heli_turret_engage_dist", "1000");
  level.heli_missile_engage_dist = heli_get_dvar_int("scr_heli_missile_engage_dist", "2000");
  level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time", "10");
  level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay", "0.75");
  level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition", "0.5");
  level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare", "256");
  level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone", "0.3");
  level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage", "0.3");
  level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength", "1000");
  level.heli_attract_range = heli_get_dvar("scr_heli_attract_range", "4096");
}

heli_get_dvar_int(var_0, var_1) {
  return int(var_1);
}

heli_get_dvar(var_0, var_1) {
  return float(var_1);
}

spawn_helicopter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnhelicopter(var_0, var_1, var_2, var_3, var_4);
  var_5.attractor = missile_createattractorent(var_5, level.heli_attract_strength, level.heli_attract_range);
  return var_5;
}

heli_think(var_0, var_1, var_2, var_3) {
  var_4 = var_1.origin;
  var_5 = var_1.angles;

  if(var_2 == "allies") {
    var_6 = "vehicle_cobra_helicopter_fly";

    if(isdefined(level.heli_model_allies_override))
      var_6 = level.heli_model_allies_override;

    var_7 = spawn_helicopter(var_0, var_4, var_5, "cobra_mp", var_6);
    var_7 playloopsound("h1_ks_chopper_cobra_mid");
  } else {
    var_6 = "h1_vehicle_mi24_hind";

    if(isdefined(level.heli_model_axis_override))
      var_6 = level.heli_model_axis_override;

    var_7 = spawn_helicopter(var_0, var_4, var_5, "hind_mp", var_6);
    var_7 playloopsound("h1_ks_chopper_hind_mid");
  }

  var_7.requireddeathcount = var_0.deaths;
  var_7.team = var_2;
  var_7.pers["team"] = var_2;
  var_7.owner = var_0;
  var_7 setotherent(var_0);
  var_7 thread heli_existance();
  level.chopper = var_7;
  var_7.reached_dest = 0;
  var_7.maxhealth = level.heli_maxhealth;
  var_7.waittime = level.heli_dest_wait;
  var_7.loopcount = 0;
  var_7.evasive = 0;
  var_7.health_bulletdamageble = level.heli_armor;
  var_7.health_evasive = level.heli_armor;
  var_7.health_low = level.heli_maxhealth * 0.8;
  var_7.targeting_delay = level.heli_targeting_delay;
  var_7.primarytarget = undefined;
  var_7.secondarytarget = undefined;
  var_7.attacker = undefined;
  var_7.missile_ammo = level.heli_missile_max;
  var_7.currentstate = "ok";
  var_7.lastrocketfiretime = -1;
  var_7.helitype = "helicopter";
  var_7 common_scripts\utility::make_entity_sentient_mp(var_2);
  var_7 thread heli_fly(var_1);
  var_7 thread heli_damage_monitor();
  var_7 thread heli_health();
  var_7 thread attack_targets();
  var_7 thread heli_targeting();
  var_7 thread heli_missile_regen();
}

aud_chopper_full_volume(var_0) {}

heli_existance() {
  common_scripts\utility::waittill_any("death", "crashing", "leaving");
  level notify("helicopter gone");
}

heli_missile_regen() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for (;;) {
    debug_print3d("Missile Ammo: " + self.missile_ammo, (0.5, 0.5, 1), self, (0, 0, -100), 0);

    if(self.missile_ammo >= level.heli_missile_max)
      self waittill("missile fired");
    else if(self.currentstate == "heavy smoke")
      wait(level.heli_missile_regen_time / 4);
    else if(self.currentstate == "light smoke")
      wait(level.heli_missile_regen_time / 2);
    else
      wait(level.heli_missile_regen_time);

    if(self.missile_ammo < level.heli_missile_max)
      self.missile_ammo++;
  }
}

heli_targeting() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for (;;) {
    var_0 = [];
    var_1 = level.players;

    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(cantarget_turret(var_3)) {
        if(isdefined(var_3))
          var_0[var_0.size] = var_3;

        continue;
      }

      continue;
    }

    if(var_0.size == 0) {
      self.primarytarget = undefined;
      self.secondarytarget = undefined;
      debug_print_target();
      wait(self.targeting_delay);
      continue;
    } else if(var_0.size == 1) {
      update_player_threat(var_0[0]);
      self.primarytarget = var_0[0];
      self notify("primary acquired");
      self.secondarytarget = undefined;
      debug_print_target();
      wait(self.targeting_delay);
      continue;
    } else if(var_0.size > 1)
      assigntargets(var_0);

    debug_print_target();
  }
}

cantarget_turret(var_0) {
  var_1 = 1;

  if(!isalive(var_0) || var_0.sessionstate != "playing")
    return 0;

  if(distance(var_0.origin, self.origin) > level.heli_visual_range)
    return 0;

  if(!isdefined(var_0.pers["team"]))
    return 0;

  if(level.teambased && var_0.pers["team"] == self.team)
    return 0;

  if(isdefined(self.owner) && var_0 == self.owner)
    return 0;

  if(var_0.pers["team"] == "spectator")
    return 0;

  if(isdefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= level.heli_target_spawnprotection)
    return 0;

  var_2 = self.origin + (0, 0, -160);
  var_3 = anglestoforward(self.angles);
  var_4 = var_2 + 144 * var_3;

  if(var_0 sightconetrace(var_4, self, 1) < level.heli_target_recognition)
    return 0;

  return var_1;
}

assigntargets(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    update_player_threat(var_0[var_1]);

  var_2 = 0;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].threatlevel >= var_2) {
      var_2 = var_0[var_1].threatlevel;
      var_4 = var_0[var_1];
    }
  }

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].threatlevel >= var_3 && var_0[var_1] != var_4) {
      var_3 = var_0[var_1].threatlevel;
      var_5 = var_0[var_1];
    }
  }

  self.primarytarget = var_4;
  self notify("primary acquired");
  self.secondarytarget = var_5;
  self notify("secondary acquired");
  wait(self.targeting_delay);
}

update_player_threat(var_0) {
  var_0.threatlevel = 0;
  var_1 = distance(var_0.origin, self.origin);
  var_0.threatlevel = var_0.threatlevel + (level.heli_visual_range - var_1) / level.heli_visual_range * 100;

  if(isdefined(self.attacker) && var_0 == self.attacker)
    var_0.threatlevel = var_0.threatlevel + 100;

  if(isdefined(var_0.pers["class"]) && (var_0.pers["class"] == "CLASS_ASSAULT" || var_0.pers["class"] == "CLASS_RECON"))
    var_0.threatlevel = var_0.threatlevel + 200;

  var_0.threatlevel = var_0.threatlevel + var_0.score * 4;

  if(isdefined(var_0.antithreat))
    var_0.threatlevel = var_0.threatlevel - var_0.antithreat;

  if(var_0.threatlevel <= 0)
    var_0.threatlevel = 1;
}

heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self vehicle_setspeed(60, 25);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

heli_wait(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("evasive");
  wait(var_0);
}

heli_damage_monitor() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self.attackerlist = [];

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isdefined(var_1) || !isplayer(var_1)) {
      continue;
    }
    var_10 = maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner, var_1);

    if(!var_10) {
      continue;
    }
    if(isdefined(self.owner) && var_1 == self.owner) {
      continue;
    }
    if(level.teambased)
      var_11 = isdefined(var_1.pers["team"]) && var_1.pers["team"] != self.team;
    else
      var_11 = 1;

    if(!var_11) {
      continue;
    }
    var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(0);
    self.attacker = var_1;
    maps\mp\gametypes\_hardpoints::killstreakhit(var_1, var_9, self);

    if(maps\mp\gametypes\_damage::isnewattacker(var_1))
      self.attackerlist[self.attackerlist.size] = var_1;

    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
      if(self.damagetaken >= self.health_bulletdamageble)
        self.damagetaken = self.damagetaken + var_0;
      else
        self.damagetaken = self.damagetaken + var_0 * level.heli_armor_bulletdamage;
    } else
      self.damagetaken = self.damagetaken + var_0;

    if(self.damagetaken > self.maxhealth) {
      var_1 notify("destroyed_helicopter");
      maps\mp\gametypes\_damage::onkillstreakkilled(var_1, var_9, var_4, var_0, "helicopter_destroyed", undefined, "callout_destroyed_helicopter", 1);
      return;
    }
  }
}

heli_health() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);

  for (;;) {
    if(self.health_bulletdamageble > self.health_low) {
      if(self.damagetaken >= self.health_bulletdamageble)
        self.currentstate = "heavy smoke";
      else if(self.damagetaken >= self.health_low)
        self.currentstate = "light smoke";
    } else if(self.damagetaken >= self.health_low)
      self.currentstate = "heavy smoke";
    else if(self.damagetaken >= self.health_bulletdamageble)
      self.currentstate = "light smoke";

    if(self.currentstate == "light smoke" && self.laststate != "light smoke") {
      self setdamagestage(2);
      self.laststate = self.currentstate;
    }

    if(self.currentstate == "heavy smoke" && self.laststate != "heavy smoke") {
      self setdamagestage(1);
      self notify("stop body smoke");
      self.laststate = self.currentstate;
    }

    if(self.currentstate == "heavy smoke") {
      self.damagetaken = self.damagetaken + level.heli_health_degrade;
      level.heli_rage_missile = 20;
    }

    if(self.currentstate == "light smoke") {
      self.damagetaken = self.damagetaken + level.heli_health_degrade / 2;
      level.heli_rage_missile = 10;
    }

    if(self.damagetaken >= self.health_evasive) {
      if(!self.evasive)
        thread heli_evasive();
    }

    if(self.damagetaken > self.maxhealth) {
      self setdamagestage(0);
      thread heli_crash();
    }

    if(self.damagetaken <= level.heli_armor)
      debug_print3d_simple("Armor: " + (level.heli_armor - self.damagetaken), self, (0, 0, 100), 20);
    else
      debug_print3d_simple("Health: " + (self.maxhealth - self.damagetaken), self, (0, 0, 100), 20);

    wait 1;
  }
}

heli_evasive() {
  self notify("evasive");
  self.evasive = 1;
  var_0 = level.heli_loop_paths[0];
  thread heli_fly(var_0);
}

heli_crash() {
  self notify("crashing");
  thread heli_fly(level.heli_crash_paths[0]);
  thread heli_spin(180);
  self waittill("path start");
  playfxontag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
  self playsound(level.heli_sound[self.team]["hitsecondary"]);
  thread trail_fx(level.chopper_fx["fire"]["trail"]["large"], "tag_engine_left", "stop body fire");
  self waittill("destination reached");
  thread heli_explode();
}

heli_spin(var_0) {
  self endon("death");
  playfxontag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  self playsound(level.heli_sound[self.team]["hit"]);
  thread spinsoundshortly();
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(var_0, var_0, var_0);

  while (isdefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

spinsoundshortly() {
  self endon("death");
  wait 0.25;
  self stoploopsound();
  wait 0.05;
  self playloopsound(level.heli_sound[self.team]["spinloop"]);
  wait 0.05;
}

trail_fx(var_0, var_1, var_2) {
  self notify(var_2);
  self endon(var_2);
  self endon("death");

  for (;;) {
    playfxontag(var_0, self, var_1);
    wait 0.05;
  }
}

heli_explode() {
  self notify("death");
  var_0 = self.origin + (0, 0, 100) - self.origin;
  playfx(level.chopper_fx["explode"]["death"], self.origin, var_0);
  self playsound(level.heli_sound[self.team]["crash"]);
  level.chopper = undefined;
  self delete();
}

heli_leave() {
  self notify("desintation reached");
  self notify("leaving");
  self scalevolume(0, 5);
  var_0 = randomint(level.heli_leavenodes.size);
  var_1 = level.heli_leavenodes[var_0];
  heli_reset();
  self vehicle_setspeed(100, 45);
  self setvehgoalpos(var_1.origin, 1);
  self waittillmatch("goal");
  self notify("death");
  level.chopper = undefined;
  self delete();
}

heli_fly(var_0) {
  self endon("death");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  self.reached_dest = 0;
  heli_reset();
  var_1 = self.origin;
  wait 2;

  while (isdefined(var_0.target)) {
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_2 = getentorstruct(var_0.target, "targetname");
    var_1 = var_2.origin + (0, 0, 30);

    if(isdefined(var_0.script_airspeed) && isdefined(var_0.script_accel)) {
      var_3 = var_0.script_airspeed;
      var_4 = var_0.script_accel;
    } else {
      var_3 = 30 + randomint(20);
      var_4 = 15 + randomint(15);
    }

    if(!isdefined(var_2.target))
      var_5 = 1;
    else
      var_5 = 0;

    debug_line(var_0.origin, var_2.origin, (1, 0.5, 0.5), 200);

    if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
      self vehicle_setspeed(var_3, var_4);
      self setvehgoalpos(var_1, var_5);
      self waittill("near_goal");
      self notify("path start");
    } else {
      if(isdefined(var_2.script_delay))
        var_5 = 1;

      self vehicle_setspeed(var_3, var_4);
      self setvehgoalpos(var_1, var_5);

      if(!isdefined(var_2.script_delay)) {
        self waittill("near_goal");
        self notify("path start");
      } else {
        self setgoalyaw(var_2.angles[1]);
        self waittillmatch("goal");
        heli_wait(var_2.script_delay);
      }
    }

    for (var_6 = 0; var_6 < level.heli_loop_paths.size; var_6++) {
      if(level.heli_loop_paths[var_6].origin == var_2.origin)
        self.loopcount++;
    }

    if(self.loopcount >= level.heli_loopmax) {
      thread heli_leave();
      return;
    }

    var_0 = var_2;
  }

  self setgoalyaw(var_0.angles[1]);
  self.reached_dest = 1;
  self notify("destination reached");
  heli_wait(self.waittime);

  if(isdefined(self))
    thread heli_evasive();
}

fire_missile(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = 1;

  var_3 = undefined;
  var_4 = undefined;
  var_5 = "cobra_20mm_mp";
  var_6 = [];

  switch (var_0) {
    case "ffar":
      if(self.team == "allies")
        var_3 = "cobra_ffar_mp";
      else
        var_3 = "hind_ffar_mp";

      var_6[0] = "tag_store_r_2";
      break;
    default:
      break;
  }

  var_4 = weaponfiretime(var_3);
  self setvehweapon(var_3);
  var_7 = -1;

  for (var_8 = 0; var_8 < var_1; var_8++) {
    var_7++;

    if(var_7 >= var_6.size)
      var_7 = 0;

    if(isdefined(var_2))
      var_9 = self fireweapon(var_6[var_7], var_2);
    else
      var_9 = self fireweapon(var_6[var_7]);

    self.lastrocketfiretime = gettime();

    if(var_8 < var_1 - 1)
      wait(var_4);
  }
}

check_owner() {
  if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    self notify("abandoned");
    thread heli_leave();
  }
}

attack_targets() {
  thread attack_primary();
  thread attack_secondary();
}

attack_secondary() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for (;;) {
    if(isdefined(self.secondarytarget)) {
      self.secondarytarget.antithreat = undefined;
      self.missiletarget = self.secondarytarget;
      var_0 = 0;

      while (isdefined(self.missiletarget) && isalive(self.missiletarget)) {
        if(missile_target_sight_check(self.missiletarget))
          thread missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
        else
          break;

        var_0 = var_0 + 100;
        self.missiletarget.antithreat = var_0;
        self waittill("missile ready");

        if(!isdefined(self.secondarytarget) || isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget) {
          break;
        }
      }

      if(isdefined(self.missiletarget))
        self.missiletarget.antithreat = undefined;
    }

    self waittill("secondary acquired");
    check_owner();
  }
}

missile_target_sight_check(var_0) {
  var_1 = vectornormalize(var_0.origin - self.origin);
  var_2 = anglestoforward(self.angles);
  var_3 = vectornormalize(var_2);
  var_4 = vectordot(var_1, var_3);

  if(var_4 >= level.heli_missile_target_cone) {
    debug_print3d_simple("Missile sight: " + var_4, self, (0, 0, -40), 40);
    return 1;
  }

  return 0;
}

missile_support(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isdefined(var_3))
    self endon(var_3);

  self.turret_giveup = 0;

  if(!var_2) {
    wait(var_1);
    self.turret_giveup = 1;
    self notify("give up");
  }

  if(isdefined(var_0)) {
    if(level.teambased) {
      for (var_4 = 0; var_4 < level.players.size; var_4++) {
        var_5 = level.players[var_4];

        if(isdefined(var_5.pers["team"]) && var_5.pers["team"] == self.team && distance(var_5.origin, var_0.origin) <= level.heli_missile_friendlycare) {
          debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
          self notify("missile ready");
          return;
        }
      }
    } else {
      var_5 = self.owner;

      if(isdefined(var_5) && isdefined(var_5.pers["team"]) && var_5.pers["team"] == self.team && distance(var_5.origin, var_0.origin) <= level.heli_missile_friendlycare) {
        debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
        self notify("missile ready");
        return;
      }
    }
  }

  if(self.missile_ammo > 0 && isdefined(var_0)) {
    fire_missile("ffar", 1, var_0);
    self.missile_ammo--;
    self notify("missile fired");
  } else
    return;

  if(var_2) {
    wait(var_1);
    self notify("missile ready");
  }
}

attack_primary() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for (;;) {
    if(isdefined(self.primarytarget)) {
      self.primarytarget.antithreat = undefined;
      self.turrettarget = self.primarytarget;
      var_0 = 0;
      var_1 = undefined;

      while (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
        self setturrettargetent(self.turrettarget, (0, 0, 40));

        if(missile_target_sight_check(self.turrettarget))
          thread missile_support(self.turrettarget, 10 / level.heli_rage_missile, 0, "turret on target");

        self waittill("turret_on_target");
        self notify("turret on target");
        thread turret_target_flag(self.turrettarget);
        wait(level.heli_turret_spinup_delay);
        var_2 = weaponfiretime("cobra_20mm_mp");
        self setvehweapon("cobra_20mm_mp");

        for (var_3 = 0; var_3 < level.heli_turretclipsize; var_3++) {
          if(isdefined(self.turrettarget) && isdefined(self.primarytarget)) {
            if(self.primarytarget != self.turrettarget)
              self setturrettargetent(self.primarytarget, (0, 0, 40));
          } else if(isdefined(self.targetlost) && self.targetlost && isdefined(self.turret_last_pos))
            self setturrettargetvec(self.turret_last_pos);
          else
            self clearturrettarget();

          if(gettime() != self.lastrocketfiretime) {
            self setvehweapon("cobra_20mm_mp");
            var_4 = self fireweapon("tag_flash");
          }

          if(var_3 < level.heli_turretclipsize - 1)
            wait(var_2);
        }

        self notify("turret reloading");
        wait(level.heli_turretreloadtime);

        if(isdefined(self.turrettarget) && isalive(self.turrettarget)) {
          var_0 = var_0 + 100;
          self.turrettarget.antithreat = var_0;
        }

        if(!isdefined(self.primarytarget) || isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget) {
          break;
        }
      }

      if(isdefined(self.turrettarget))
        self.turrettarget.antithreat = undefined;
    }

    self waittill("primary acquired");
    check_owner();
  }
}

turret_target_flag(var_0) {
  self notify("flag check is running");
  self endon("flag check is running");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("turret reloading");
  var_0 endon("death");
  var_0 endon("disconnect");
  self.targetlost = 0;
  self.turret_last_pos = undefined;

  while (isdefined(var_0)) {
    var_1 = self.origin + (0, 0, -160);
    var_2 = anglestoforward(self.angles);
    var_3 = var_1 + 144 * var_2;
    var_4 = var_0 sightconetrace(var_3, self, 1);

    if(var_4 < level.heli_target_recognition) {
      break;
    }

    wait 0.05;
  }

  if(isdefined(var_0) && isdefined(var_0.origin)) {
    self.turret_last_pos = var_0.origin + (0, 0, 40);
    self setturrettargetvec(self.turret_last_pos);
    debug_print3d_simple("Turret target lost at: " + self.turret_last_pos, self, (0, 0, -70), 60);
    self.targetlost = 1;
  } else {
    self.targetlost = undefined;
    self.turret_last_pos = undefined;
  }
}

debug_print_target() {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isdefined(self.primarytarget) && isdefined(self.primarytarget.threatlevel))
      var_0 = "Primary: " + self.primarytarget.name + " : " + self.primarytarget.threatlevel;
    else
      var_0 = "Primary: ";

    if(isdefined(self.secondarytarget) && isdefined(self.secondarytarget.threatlevel))
      var_1 = "Secondary: " + self.secondarytarget.name + " : " + self.secondarytarget.threatlevel;
    else
      var_1 = "Secondary: ";

    var_2 = int(self.targeting_delay * 20) + 1;
    thread draw_text(var_0, (1, 0.6, 0.6), self, (0, 0, 40), var_2);
    thread draw_text(var_1, (1, 0.6, 0.6), self, (0, 0, 0), var_2);
  }
}

debug_print3d(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_text(var_0, var_1, var_2, var_3, var_4);
}

debug_print3d_simple(var_0, var_1, var_2, var_3) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isdefined(var_3))
      thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, var_3);
    else
      thread draw_text(var_0, (0.8, 0.8, 0.8), var_1, var_2, 0);
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0 && !isdefined(var_3))
    thread draw_line(var_0, var_1, var_2);
  else if(isdefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(var_0, var_1, var_2, var_3);
}

draw_text(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    while (isdefined(var_2))
      wait 0.05;
  } else {
    for (var_5 = 0; var_5 < var_4; var_5++) {
      if(!isdefined(var_2)) {
        break;
      }

      wait 0.05;
    }
  }
}

draw_line(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3)) {
    for (var_4 = 0; var_4 < var_3; var_4++)
      wait 0.05;
  } else {
    for (;;)
      wait 0.05;
  }
}