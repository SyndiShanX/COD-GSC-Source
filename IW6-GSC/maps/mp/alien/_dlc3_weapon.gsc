/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_dlc3_weapon.gsc
******************************************/

init() {
  init_beacon_weapon_fx();
  level thread wait_for_gun_to_be_crafted();
}

init_beacon_weapon_fx() {
  level._effect["fire_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_fire_cloud");
  level._effect["electric_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_li_cloud");
  level._effect["spore_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_sp_gas");
  level._effect["corrosive_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_gas");
  level._effect["spitter_ammo"] = loadfx("vfx/_requests/mp_alien_armory/spitter_ammo");
}

dlc3_weapon_watcher() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("gun_watcher_logic");
  self endon("gun_watcher_logic");
  self notifyonplayercommand("detonate_venom", "+toggleads_throw");
  self notifyonplayercommand("detonate_venom", "+ads_akimbo_accessible");
  thread special_gun_detonate_hint_watcher();
  var_0 = "none";
  var_1 = undefined;

  for(;;) {
    self waittill("grenade_fire", var_1, var_0);

    if(is_venom_weapon(var_0)) {
      var_1.health = 1;
      thread wait_for_detonation(var_1, var_0);
      thread explode_projectile(var_1, var_0);
    } else if(is_venom_grenade(var_0))
      thread grenade_explosion_monitor(var_1, var_0);

    wait 0.05;
  }
}

special_gun_detonate_hint_watcher() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("gun_watcher_logic");
  var_0 = 2;

  while(!isDefined(self.no_more_detonate_hint)) {
    self waittill("grenade_fire", var_1, var_2);

    if(is_venom_weapon(var_2)) {
      if(!isDefined(self.projectile_time_out_num)) {
        self.projectile_time_out_num = 1;
      } else if(self.projectile_time_out_num > var_0) {
        var_0 = 3;
        self.projectile_time_out_num = 0;
        thread show_specialweapon_hint_repeat();
      } else
        self.projectile_time_out_num++;
    }

    wait 0.1;
  }
}

wait_for_detonation(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  self.adspressed = 0;
  thread ads_watcher();
  thread toggle_ads_watcher();
  var_2 = 55;
  var_3 = 0;
  var_4 = (0, 0, 0);

  for(var_5 = var_4; self adsbuttonpressed() && var_3 < var_2; var_3 = var_3 + 1) {
    wait 0.05;
  }

  while(var_3 < var_2) {
    if(isDefined(var_0) && self.adspressed) {
      self notify("projectile_detonate");
      self.no_more_detonate_hint = 1;
      return;
    } else if(!isDefined(var_0)) {
      thread cloudmonitor(self, var_5, var_1);
      playsoundatpos(var_5, "aliendlc11_explode");
      return;
    }

    var_4 = var_0.origin;
    var_5 = var_4;
    wait 0.05;
    var_3 = var_3 + 1;
  }

  self notify("projectile_detonate");
}

toggle_ads_watcher() {
  self endon("disconnect");
  self endon("death");
  self endon("projectile_detonate");
  self endon("ads_pressed");
  self waittill("detonate_venom");
  self.adspressed = 1;
  self notify("ads_pressed");
}

ads_watcher() {
  self endon("disconnect");
  self endon("death");
  self endon("projectile_detonate");
  self endon("ads_pressed");

  for(;;) {
    if(self adsbuttonpressed()) {
      self.adspressed = 1;
      self notify("ads_pressed");
    }

    wait 0.05;
  }
}

grenade_explosion_monitor(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  level thread cloudmonitor(self, var_0.origin, var_1);
}

explode_projectile(var_0, var_1) {
  self waittill("projectile_detonate");

  if(isDefined(var_0)) {
    level thread cloudmonitor(self, var_0.origin, var_1);
    playsoundatpos(var_0.origin, "aliendlc11_explode");
    var_0 delete();
  }
}

cloudmonitor(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_3 = undefined;
  var_4 = 200;
  var_5 = 150;
  var_6 = 250;
  var_7 = 5;
  var_8 = 5;
  var_9 = 0.5;
  var_10 = 200;
  var_11 = 1000;
  var_12 = 1500;

  switch (var_2) {
    case "iw6_aliendlc11li_mp":
      var_3 = spawnfx(level._effect["electric_blast"], var_1);
      break;
    case "iw6_aliendlc32_mp":
      var_4 = 200;
      var_5 = 150;
      var_6 = 250;
      var_7 = 5;
      var_8 = 5;
      var_3 = spawnfx(level._effect["electric_blast"], var_1);
      break;
    case "iw6_aliendlc11fi_mp":
      var_3 = spawnfx(level._effect["fire_blast"], var_1);
      break;
    case "iw6_aliendlc33_mp":
      var_4 = 200;
      var_5 = 150;
      var_6 = 250;
      var_7 = 5;
      var_8 = 5;
      var_3 = spawnfx(level._effect["fire_blast"], var_1);
      break;
    case "iw6_aliendlc11_mp":
      var_3 = spawnfx(level._effect["corrosive_blast"], var_1);
      break;
    case "iw6_aliendlc31_mp":
      var_4 = 200;
      var_5 = 150;
      var_6 = 250;
      var_7 = 5;
      var_8 = 5;
      break;
  }

  var_13 = var_1 - (0, 0, var_5);
  var_14 = var_5 + var_5;
  var_15 = spawn("trigger_radius", var_13, 1, var_4, var_14);
  var_15.owner = var_0;
  radiusdamage(var_1, var_10, var_12, var_11, var_0, "MOD_EXPLOSIVE");
  earthquake(0.5, 1, var_1, 512);
  playrumbleonposition("grenade_rumble", var_1);

  if(isDefined(var_3)) {
    triggerfx(var_3);
  }

  if(var_2 == "iw6_aliendlc11li_mp") {
    playsoundatpos(var_1, "venom_lightning_expl");
  }

  if(var_2 == "iw6_aliendlc11fi_mp") {
    playsoundatpos(var_1, "venom_fire_expl");
  }

  var_16 = 0.0;
  var_17 = 0.25;
  var_18 = 1;
  var_19 = 0;
  wait(var_18);

  for(var_16 = var_16 + var_18; var_16 < var_7; var_16 = var_16 + var_17) {
    var_20 = [];

    foreach(var_22 in level.agentarray) {
      if(isDefined(var_22) && isalive(var_22) && var_22 istouching(var_15) && !isDefined(var_22.melting)) {
        var_20[var_20.size] = var_22;
      }
    }

    if(isDefined(level.alive_plants)) {
      foreach(var_25 in level.alive_plants) {
        if(isDefined(var_25) && isDefined(var_25.coll_model) && var_25.coll_model istouching(var_15)) {
          var_25.coll_model dodamage(var_6, var_25.origin, var_0, var_0);
        }
      }
    }

    foreach(var_22 in var_20) {
      if(isDefined(var_22) && isalive(var_22)) {
        var_22 thread cloud_melt_alien(var_6, var_0, var_8, var_15, var_9, var_2);
        common_scripts\utility::waitframe();
      }
    }

    wait(var_17);
  }

  var_15 delete();

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

alien_corrosive_on() {
  if(!isDefined(self.is_corrosive)) {
    self.is_corrosive = 0;
  }

  self.is_corrosive++;

  if(self.is_corrosive == 1) {
    self setscriptablepartstate("body", "corrosive");
  }
}

alien_corrosive_off() {
  self.is_corrosive--;

  if(self.is_corrosive > 0) {
    return;
  }
  self.is_corrosive = undefined;
  self notify("corrosive_off");
  self setscriptablepartstate("body", "normal");
}

cloud_melt_alien(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("stasis_cloud_burning");
  self endon("stasis_cloud_burning");
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  self.melting = 1;

  switch (var_5) {
    case "iw6_aliendlc11_mp":
    case "iw6_aliendlc31_mp":
      if(!isDefined(level.spider) || isDefined(level.spider) && self != level.spider) {
        alien_corrosive_on();
      }

      break;
    case "iw6_aliendlc11fi_mp":
    case "iw6_aliendlc33_mp":
      thread maps\mp\alien\_damage::catch_alien_on_fire(var_1);
      break;
    case "iw6_aliendlc11li_mp":
    case "iw6_aliendlc32_mp":
      thread maps\mp\alien\_alien_fx::fx_stun_damage();
      break;
  }

  var_6 = 0;

  while(var_6 < var_2) {
    if(isDefined(var_3)) {
      self dodamage(var_0, self.origin, var_1, var_1, "MOD_UNKNOWN");
    } else {
      self dodamage(var_0, self.origin, var_1);
    }

    var_6 = var_6 + var_4;
    wait(var_4);
  }

  if(isDefined(self.is_corrosive)) {
    alien_corrosive_off();
  }

  self.melting = undefined;
}

wait_for_gun_to_be_crafted() {
  level waittill("venom_crafted");
  level thread venom_ammo_drop_logic();
}

venom_ammo_drop_logic() {
  var_0 = 45;
  var_1 = 90;
  level.spitter_ammo_active = 0;
  level endon("game_ended");
  var_2 = gettime() + var_0 * 1000;
  var_3 = gettime() + var_1 * 1000;

  for(;;) {
    level waittill("alien_killed", var_4);
    var_5 = gettime();
    var_6 = 0;

    if(var_5 > var_2 && level.spitter_ammo_active < 4) {
      if(gettime() < var_3) {
        if(randomintrange(0, 100) > 92) {
          var_6 = 1;
        }
      } else
        var_6 = 1;
    }

    if(var_6 && isDefined(var_4)) {
      var_2 = gettime() + var_0 * 1000;
      var_3 = gettime() + var_1 * 1000;
      level thread spitter_ammo_drop(var_4);
    }

    wait 0.05;
  }
}

spitter_ammo_drop(var_0) {
  var_1 = getgroundposition(var_0 + (0, 0, 10), 16);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("alien_spider_egg_ammo");
  wait 1;
  playFXOnTag(level._effect["spitter_ammo"], var_2, "j_egg_center");
  var_2 thread spitter_ammo_think();
  var_2 thread spitter_ammo_rotate();
  level.spitter_ammo_active++;
}

spitter_ammo_think() {
  level endon("game_ended");
  self endon("death");
  var_0 = 30;
  self makeusable();
  self sethintstring(&"MP_ALIEN_DESCENT_SPITTER_AMMO_PICKUP");
  thread spitter_ammo_delete(var_0);

  for(;;) {
    self waittill("trigger", var_1);
    var_2 = var_1 get_venom_weapon();

    if(isDefined(var_2)) {
      var_3 = var_1 getweaponammoclip(var_2);
      var_4 = var_1 getweaponammostock(var_2);

      if(var_3 + var_4 >= weaponmaxammo(var_2) + weaponclipsize(var_2)) {
        var_1 maps\mp\_utility::setlowermessage("ammo_taken", &"ALIEN_COLLECTIBLES_AMMO_MAX", 3);
        continue;
      }

      var_5 = 2;

      if(var_1 maps\mp\alien\_prestige::prestige_getminammo() != 1) {
        var_5 = 1;
      }

      var_1 setweaponammoclip(var_2, var_3 + var_5);
      var_1 setweaponammostock(var_2, var_4 + var_5);
      var_1 playSound("extinction_item_pickup");
      playFX(level._effect["alien_teleport"], self.origin);
      level.spitter_ammo_active--;
      self delete();
      return;
    }
  }
}

get_venom_weapon() {
  if(self hasweapon("iw6_aliendlc11_mp")) {
    return "iw6_aliendlc11_mp";
  } else if(self hasweapon("iw6_aliendlc11li_mp")) {
    return "iw6_aliendlc11li_mp";
  } else if(self hasweapon("iw6_aliendlc11fi_mp")) {
    return "iw6_aliendlc11fi_mp";
  } else if(self hasweapon("iw6_aliendlc11sp_mp")) {
    return "iw6_aliendlc11sp_mp";
  }

  return undefined;
}

spitter_ammo_rotate() {
  self endon("death");

  for(;;) {
    self rotateyaw(360, 5);
    wait 5;
  }
}

spitter_ammo_delete(var_0) {
  self endon("death");
  wait(var_0);
  level.spitter_ammo_active--;
  self delete();
}

show_specialweapon_hint_repeat() {
  self endon("disconnect");
  wait 1;
  self iprintlnbold(&"MP_ALIEN_DESCENT_VENOM_HINT");
}

is_venom_weapon(var_0) {
  switch (var_0) {
    case "iw6_aliendlc11fi_mp":
    case "iw6_aliendlc11li_mp":
    case "iw6_aliendlc11_mp":
      return 1;
  }

  return 0;
}

is_venom_grenade(var_0) {
  switch (var_0) {
    case "iw6_aliendlc33_mp":
    case "iw6_aliendlc32_mp":
    case "iw6_aliendlc31_mp":
      return 1;
  }

  return 0;
}