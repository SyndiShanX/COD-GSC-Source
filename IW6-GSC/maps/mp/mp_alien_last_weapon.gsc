/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_last_weapon.gsc
********************************************/

init() {
  init_last_weapon_fx();
}

init_last_weapon_fx() {
  level._effect["electric_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_li_cloud");
  level._effect["nx1_explode"] = loadfx("vfx/gameplay/alien/vfx_alien_actuator_exp");
  level._effect["fire_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_fire_cloud");
  level._effect["corrosive_blast"] = loadfx("vfx/gameplay/alien/vfx_alien_arm_gun_gas");
}

special_gun_watcher() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("gun_watcher_logic");
  self endon("gun_watcher_logic");
  thread cortex_gun_charge_watcher();
  thread watch_player_weaponswitch();
  thread cortex_gun_ammo_handler();
  thread cortex_gun_hud_monitor();
  var_0 = "none";
  var_1 = undefined;

  for(;;) {
    self waittill("missile_fire", var_1, var_0);

    if(var_0 != "iw6_aliendlc41_mp" && var_0 != "iw6_aliendlc42_mp") {
      continue;
    }
    if(var_0 == "iw6_aliendlc41_mp" && self.adspressedtime != 9999999)
      self stoplocalsound("weap_cortex_chrg_plr");

    var_1.health = 1;
    thread cortex_gun_shoot(var_1, var_0);
    wait 0.05;
  }
}

watch_player_weaponswitch() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::waittill_any("weapon_switch_started", "weapon_change", "weaponchange");
    self.adspressed = 0;
    self.adspressedtime = 9999999;
  }
}

cortex_gun_hud_monitor() {
  self endon("death");
  self endon("disconnect");
  var_0 = 10;

  if(self _meth_842C("nerf_min_ammo"))
    var_0 = 5;

  self.gun_chargeable = 0;

  for(;;) {
    if(self getcurrentweapon() == "iw6_aliendlc41_mp") {
      var_1 = self getcurrentweaponclipammo();

      if(var_1 >= var_0) {
        self.gun_chargeable = 1;

        if(maps\mp\alien\_utility::is_true(self.adsallowed))
          self notify("cortex_launcher_full");

        self.cortex_weapon_ammo_full = 1;
      } else if(var_1 < var_0) {
        self.cortex_weapon_ammo_full = 0;
        self.gun_chargeable = 0;
      }

      if(maps\mp\alien\_perk_utility::has_perk("perk_bullet_damage", [2, 3, 4]))
        self unsetperk("specialty_quickdraw", 1);
    } else if(maps\mp\alien\_perk_utility::has_perk("perk_bullet_damage", [2, 3, 4]))
      self setperk("specialty_quickdraw", 1, 0);

    wait 0.2;
  }
}

cortex_gun_charge_watcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.adspressed = 0;
  self.adsallowed = 1;
  self.adspressedtime = 9999999;
  var_0 = 0;
  var_1 = -1;

  for(;;) {
    var_2 = -1;

    if(self getcurrentweapon() != "iw6_aliendlc41_mp" || self isusingturret() || maps\mp\_utility::isusingremote() || isDefined(self.throwinggrenade) || maps\mp\alien\_utility::is_true(self.is_grabbed)) {
      if(self.adspressedtime != 9999999)
        thread audio_cortex_interrupt_charge();

      self.adsallowed = 1;
      self.adspressedtime = 9999999;

      if(var_1 != -1) {
        self setclientomnvar("ui_custom_reticle_state", -1);
        var_1 = -1;
      }

      wait 0.05;
      continue;
    }

    var_2 = 0;

    if(self adsbuttonpressed() && self.adsallowed && !self meleebuttonpressed()) {
      var_3 = gettime();

      if(!self.adspressed) {
        if(maps\mp\alien\_utility::is_true(self.cortex_weapon_ammo_full)) {
          self playlocalsound("weap_cortex_chrg_plr");
          self.adspressed = 1;
          self.adspressedtime = var_3;
        } else {
          self.adspressed = 0;
          self.adspressedtime = 9999999;
          var_0 = 0;
          self playlocalsound("weap_cortex_no_chrg_plr");
          self allowads(0);
          self.adsallowed = 0;
          thread allow_ads_reset(0.25);
        }

        var_0 = 0;
      }

      var_4 = var_3 - self.adspressedtime;
      var_5 = 350.0;

      for(var_6 = 1; var_6 <= 4; var_6++) {
        if(var_4 >= var_6 * var_5)
          var_2++;
      }

      if(var_4 > 1400) {
        if(!var_0)
          var_0 = 1;
        else if(var_4 > 1400) {
          fire_large_cortex_blast();
          wait 0.5;
          thread allow_ads_reset();
        }
      }
    } else {
      if(self.adspressedtime != 9999999 && self.adsallowed) {
        thread audio_cortex_interrupt_charge();
        self.adsallowed = 0;
        self allowads(0);

        if(self meleebuttonpressed())
          thread allow_ads_reset();
        else
          thread allow_ads_reset(0.25);
      }

      self.adspressed = 0;
      var_0 = 0;
      self.adspressedtime = 9999999;
    }

    if(var_2 != var_1) {
      self setclientomnvar("ui_custom_reticle_state", var_2);
      var_1 = var_2;
    }

    wait 0.05;
  }
}

audio_cortex_interrupt_charge() {
  self playlocalsound("weap_cortex_chrg_interrupt_plr");
  wait 0.15;
  self stoplocalsound("weap_cortex_chrg_plr");
}

fire_large_cortex_blast() {
  var_0 = 10;

  if(self _meth_842C("nerf_min_ammo"))
    var_0 = 5;

  if(self getcurrentweapon() != "iw6_aliendlc41_mp" || self isusingturret() || maps\mp\_utility::isusingremote() || isDefined(self.throwinggrenade) || maps\mp\alien\_utility::is_true(self.is_grabbed) || self getcurrentweaponclipammo() != var_0) {
    if(self.adspressedtime != 9999999)
      self stoplocalsound("weap_cortex_chrg_plr");

    self.adspressed = 0;
    self.adspressedtime = 9999999;
    self allowads(0);
    self.adsallowed = 0;
    return;
  }

  foreach(var_2 in level.players) {
    if(var_2 == self) {
      self playlocalsound("weap_cortex_fire_lg_plr");
      continue;
    }

    self playsoundtoplayer("weap_cortex_fire_lg_npc", var_2);
  }

  wait 0.05;
  self.adsallowed = 0;
  self allowads(0);
  thread allow_ads_reset();
  self.cortex_weapon_ammo_full = 0;
  self.gun_chargeable = 0;
  self setweaponammoclip("iw6_aliendlc41_mp", 0);
  self setweaponammostock("iw6_aliendlc41_mp", 0);
  var_4 = anglesToForward(self getplayerangles());
  var_5 = self getEye();
  var_6 = var_5 + var_4 * 1000;
  earthquake(0.5, 1, self.origin + (0, 0, 30), 64);
  self playrumbleonentity("artillery_rumble");
  var_7 = magicbullet("iw6_aliendlc42_mp", var_5, var_6, self);

  if(!isDefined(var_7)) {
    return;
  }
  self notify("nx1_large_fire");
  thread cortex_gun_explode(var_7);
  thread detect_ancestor_hit(var_7);
}

allow_ads_reset(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.75;

  common_scripts\utility::waittill_any_timeout(var_0, "weapon_switch_started", "weapon_change", "cortex_launcher_full");
  self allowads(1);
  self.adsallowed = 1;
}

cortex_gun_shoot(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_2 = gettime();
  self.cortex_last_shot_time = var_2;
  self.adspressed = 0;
  self.adspressedtime = 9999999;
  self.cortex_weapon_ammo_full = 0;
  self.gun_chargeable = 0;
}

detect_ancestor_hit(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_1 = 6400;
  wait 0.1;

  for(;;) {
    var_2 = common_scripts\utility::array_combine(level.active_ancestors, maps\mp\alien\_spawnlogic::get_alive_agents());

    foreach(var_4 in var_2) {
      var_5 = var_4.origin + (0, 0, 10);

      if(isDefined(var_4.alien_type) && var_4.alien_type == "ancestor") {
        var_5 = var_4.origin + (0, 0, 80);
        var_6 = abs(var_0.origin[2] - var_5[2]);

        if(distance2dsquared(var_0.origin, var_5) <= var_1 && var_6 < 125) {
          playsoundatpos(var_0.origin, "weap_cortex_impact_lg");
          playFX(level._effect["nx1_explode"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
          var_4 dodamage(2000, var_0.origin, self, var_0, "MOD_PROJECTILE");
          radiusdamage(var_0.origin, 250, 3000, 1500, self, "MOD_PROJECTILE_SPLASH", "iw6_aliendlc42_mp");
          var_0 notify("explode", var_0.origin);
          var_0 delete();
        }

        continue;
      }

      if(isDefined(var_4.alien_type)) {
        if(distancesquared(var_0.origin, var_5) <= var_1) {
          playsoundatpos(var_0.origin, "weap_cortex_impact_lg");
          playFX(level._effect["nx1_explode"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
          var_4 dodamage(2000, var_0.origin, self, var_0, "MOD_PROJECTILE");
          radiusdamage(var_0.origin, 250, 3000, 1500, self, "MOD_PROJECTILE_SPLASH", "iw6_aliendlc42_mp");
          var_0 notify("explode", var_0.origin);
          var_0 delete();
        }
      }
    }

    wait 0.2;
  }
}

cortex_gun_ammo_handler() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = "iw6_aliendlc41_mp";
  self.cortex_last_shot_time = 0;
  self setweaponammostock(var_0, 0);
  var_1 = 5;
  var_2 = 1;
  var_3 = 10;

  if(self _meth_842C("nerf_min_ammo")) {
    var_2 = 2;
    var_1 = 7.5;
    var_3 = 5;
  }

  for(;;) {
    if(gettime() - self.cortex_last_shot_time < var_1 * 1000) {
      wait 0.1;
      continue;
    }

    var_4 = self getweaponammoclip(var_0);

    if(var_4 < var_3) {
      self setweaponammoclip(var_0, var_4 + 1);
      self setweaponammostock(var_0, 0);
    }

    wait(var_2);
  }
}

cortex_gun_attractor(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  playFXOnTag(level._effect["electric_blast"], var_0, "TAG_ORIGIN");
  var_0.attractor = missile_createattractorent(var_0, 9000, 1200);
  wait 1;
  var_1 = 202500;

  for(;;) {
    var_2 = maps\mp\alien\_spawnlogic::get_alive_agents();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4.singularity_active) && distancesquared(var_4.origin, var_0.origin) < var_1) {
        var_4.singularity_active = 1;
        thread singularity_attract(var_4, var_0);
        thread singularity_kill_near_center(var_4, var_0);
      }
    }

    wait 0.2;
  }
}

singularity_attract(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_1 endon("death");
  var_2 = (0, 0, -800);
  var_0 thread maps\mp\alien\_alien_fx::fx_stun_damage();

  for(;;) {
    var_3 = trajectorycalculateinitialvelocity(var_0.origin, var_1.origin, var_2, 0.5);
    var_0 setvelocity(var_3);
    var_4 = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
    var_0 scragentsetorientmode("face angle abs", var_4);
    wait 0.5;
  }
}

singularity_kill_near_center(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_1 endon("death");
  var_2 = 1024;

  for(;;) {
    if(distancesquared(var_0.origin, var_1.origin) < var_2)
      var_0 suicide();

    wait 0.2;
  }
}

cortex_gun_explode(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 waittill("explode", var_1);
  earthquake(0.35, 0.5, var_1, 512);

  if(isDefined(var_0.attractor))
    missile_deleteattractor(var_0.attractor);

  wait 0.6;
  physicsexplosionsphere(var_1 + (0, 0, -5), 250, 32, 10);
}

last_grenade_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("grenade_watcher_logic");
  self endon("grenade_watcher_logic");
  var_0 = "none";
  var_1 = undefined;

  for(;;) {
    self waittill("grenade_fire", var_1, var_0);
    thread grenade_explosion_monitor(var_1, var_0);
    wait 0.05;
  }
}

grenade_explosion_monitor(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  var_2 = var_0.origin;

  if(is_venom_grenade(var_1))
    level thread cloudmonitor(self, var_2, var_1);
  else if(var_1 == "iw6_aliendlc43_mp") {
    wait 0.6;
    physicsexplosionsphere(var_2 + (0, 0, -5), 800, 250, 10);
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

  if(isDefined(var_3))
    triggerfx(var_3);

  if(var_2 == "iw6_aliendlc11li_mp")
    playsoundatpos(var_1, "venom_lightning_expl");

  if(var_2 == "iw6_aliendlc11fi_mp")
    playsoundatpos(var_1, "venom_fire_expl");

  var_16 = 0.0;
  var_17 = 0.25;
  var_18 = 1;
  var_19 = 0;
  wait(var_18);

  for(var_16 = var_16 + var_18; var_16 < var_7; var_16 = var_16 + var_17) {
    var_20 = [];

    foreach(var_22 in level.agentarray) {
      if(isDefined(var_22) && isalive(var_22) && var_22 istouching(var_15) && !isDefined(var_22.melting)) {
        if(var_22.alien_type == "ancestor" && var_22 maps\mp\agents\alien\alien_ancestor\_alien_ancestor::isshieldup()) {
          continue;
        }
        var_20[var_20.size] = var_22;
      }
    }

    if(isDefined(level.alive_plants)) {
      foreach(var_25 in level.alive_plants) {
        if(isDefined(var_25) && isDefined(var_25.coll_model) && var_25.coll_model istouching(var_15))
          var_25.coll_model dodamage(var_6, var_25.origin, var_0, var_0);
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

  if(isDefined(var_3))
    var_3 delete();
}

alien_corrosive_on() {
  if(!isDefined(self.is_corrosive))
    self.is_corrosive = 0;

  self.is_corrosive++;

  if(self.is_corrosive == 1)
    self setscriptablepartstate("body", "corrosive");
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

  if(!isDefined(var_2))
    var_2 = 6;

  self.melting = 1;

  switch (var_5) {
    case "iw6_aliendlc11_mp":
    case "iw6_aliendlc31_mp":
      if(!isDefined(level.spider) || isDefined(level.spider) && self != level.spider)
        alien_corrosive_on();

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
    if(isDefined(var_3))
      self dodamage(var_0, self.origin, var_1, var_1, "MOD_UNKNOWN");
    else
      self dodamage(var_0, self.origin, var_1);

    var_6 = var_6 + var_4;
    wait(var_4);
  }

  if(isDefined(self.is_corrosive))
    alien_corrosive_off();

  self.melting = undefined;
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