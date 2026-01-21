/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3427.gsc
**************************************/

init() {
  scripts\cp\cp_splash_grenade::splashgrenadeinit();
  head_shard_init();
  facemelter_fx_init();
  level.facemelter_globs = [];
}

activate_zero_g_on_character(var_0) {
  var_0 thread agent_float_in_air(var_0);
}

deactivate_zero_g_on_character(var_0) {
  var_0 unlink();

  if(isDefined(level.deactivate_zerog_func)) {
    [[level.deactivate_zerog_func]](var_0);
  }
}

agent_float_in_air(var_0) {
  var_1 = 5;
  var_2 = bulletTrace(var_0.origin, var_0.origin + (0, 0, 170), 0, var_0);
  var_3 = var_2["position"];
  var_4 = var_3[2] - var_0.origin[2];
  var_5 = min(var_4, 170) - 70;
  var_6 = spawn("script_origin", var_0.origin);
  var_6.angles = var_0.angles;
  var_0.do_immediate_ragdoll = 1;
  var_0 linkto(var_6);
  var_6 moveto(var_0.origin + (0, 0, var_5), var_1);
  var_7 = var_6 scripts\cp\utility::waittill_any_ents_return(level, "deactivate zero g", var_0, "death");

  if(isDefined(var_0)) {
    var_0.do_immediate_ragdoll = 0;
  }

  var_6 delete();
}

fx_stun_damage() {
  self endon("death");
  self.stunned = 1;
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  wait 0.5;
  self.stunned = undefined;
}

special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.agent_type) && (self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey")) {
    return;
  }
  var_12 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_13 = scripts\engine\utility::is_true(self.is_suicide_bomber);
  var_14 = getweaponbasename(var_5);

  if(!isDefined(var_14)) {
    return;
  }
  var_15 = 0;

  if(!var_13) {
    switch (var_14) {
      case "iw7_headcutter3_zm":
      case "iw7_headcutter2_zm":
      case "iw7_headcutter_zm_pap1":
      case "iw7_headcutter_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !scripts\engine\utility::is_true(self.isfrozen)) {
          self.health = var_2 + 1;
          self.allowpain = 1;
          self.killedby = var_1;
          thread head_exploder(var_1, var_6, var_8, var_2, var_5);
          var_15 = 1;
        }

        break;
      case "iw7_dischord_zm_pap1":
      case "iw7_dischord_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !scripts\engine\utility::is_true(self.isfrozen)) {
          self.health = var_2 + 1;
          self.allowpain = 1;
          self.killedby = var_1;
          thread dischord_death_logic(var_1, var_6, var_8, var_2, var_5);
        }

        break;
      case "iw7_facemelter_zm_pap1":
      case "iw7_facemelter_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !scripts\engine\utility::is_true(self.isfrozen)) {
          self.health = var_2 + 1;
          self.allowpain = 1;
          self.killedby = var_1;
          thread facemelter_death_logic(var_1, var_6, var_8, var_2, var_5);
        }

        break;
      case "iw7_shredder_zm_pap1":
      case "iw7_shredder_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !scripts\engine\utility::is_true(self.isfrozen)) {
          self.health = var_2 + 1;
          self.allowpain = 1;
          self.killedby = var_1;
          thread shredder_death_logic(var_1, var_6, var_8, var_2);
        }

        break;
      default:
        break;
    }

    if(self.health - var_2 < 1) {
      if(isDefined(level.medusa_check_func)) {
        var_16 = [[level.medusa_check_func]](self);

        if(isDefined(var_16)) {
          self.nocorpse = 1;
          self.near_medusa = var_16;
        } else {
          self.near_medusa = undefined;
        }
      }

      if(isDefined(level.crystal_check_func)) {
        if(isplayer(var_1) && isDefined(var_5) && var_5 != "none") {
          var_17 = [
            [level.crystal_check_func]
          ](self, var_5);

          if(var_17) {
            self.nocorpse = 1;
            self.near_crystal = 1;
          } else {
            self.near_crystal = undefined;
          }
        } else {
          self.near_crystal = undefined;
        }
      }
    }
  }

  if(self.health - var_2 < 1) {
    if(isDefined(level.lethaldamage_func)) {
      [[level.lethaldamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(!var_12 && !var_15) {
      if(var_1 scripts\cp\utility::is_consumable_active("headshot_explosion")) {
        check_to_use_headshot_explosion(var_1, var_6, var_2, var_4, var_5, var_8, var_13);
      } else if(var_1 scripts\cp\utility::has_zombie_perk("perk_machine_change")) {
        [[level.change_chew_explosion_func]](var_1, var_6, var_2, var_4, var_5, var_8);
      }
    }
  }
}

dischord_death_logic(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.link_ent)) {
    return;
  }
  self endon("death");

  if(scripts\engine\utility::is_true(self.is_dancing) || self.scripted_mode) {
    self.do_immediate_ragdoll = 1;
    self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, var_0, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  self.scripted_mode = 1;
  var_5 = 0;
  var_6 = scripts\cp\utility::weaponhasattachment(var_4, "pap1");
  var_7 = 50;

  if(var_6) {
    var_7 = 100;
    self.upgraded_dischord_spin = 1;
  }

  self.dischord_spin = 1;

  if(scripts\engine\utility::is_true(self.is_traversing)) {
    thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 5);
    playFXOnTag(level._effect["dischord_tornado"], self, "tag_origin");
    var_5 = 1;

    while(scripts\engine\utility::is_true(self.is_traversing)) {
      wait 0.1;
    }

    self notify("stop_spin");
  }

  thread kill_me_after_timeout(5, "ready_to_spin");

  if(!var_5) {
    self setscriptablepartstate("dischord_spin_fx", "active", 1);
  }

  self waittill("ready_to_spin");
  self.link_ent = spawn("script_origin", self.origin);
  self.link_ent thread kill_link_ent_on_death(self);

  if(!var_6) {
    self linkto(self.link_ent);
  }

  thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 0.5);
  self.link_ent rotateyaw(360, 1.0);
  wait 0.5;
  thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 0.5);
  self.link_ent rotateyaw(720, 1.0);
  wait 0.5;
  thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 1);
  self.link_ent rotateyaw(1080, 1.0);
  wait 1;
  thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 1);
  self.link_ent rotateyaw(1240, 1.0);
  wait 1;

  if(var_6) {
    thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 2);
    wait 2;
  } else {
    thread dischord_spin_attack(var_0, var_1, var_2, var_3, var_7, 0.1);
  }

  playLoopSound(self.origin, "zombie_dischord_zmb_spin_explo");
  self.full_gib = 1;
  self.nocorpse = 1;
  self.gib_fx_override = "dischord_explosion";
  self setscriptablepartstate("dischord_spin_fx", "inactive", 1);
  var_8 = 128;

  if(var_6) {
    var_8 = 256;
  }

  if(isDefined(var_0)) {
    var_0 radiusdamage(self.origin, var_8, 2000, 2000, var_0, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  } else {
    level.players[0] radiusdamage(self.origin, var_8, 2000, 2000, level.players[0], "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  if(isDefined(self.link_ent)) {
    self.dischord_spin = 0;
    self.deathmethod = "dischord";
    self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, self.link_ent, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }
}

kill_link_ent_on_death(var_0) {
  var_0 waittill("death");
  wait 0.25;
  self delete();
}

kill_me_after_timeout(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  wait(var_0);
  self suicide();
}

dischord_spin_attack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("stop_spin");
  var_6 = var_5;
  var_7 = 0.1;
  var_8 = 2;
  var_3 = 3000;

  if(var_4 == 100) {
    var_3 = 7000;
  }

  while(var_6 > 0) {
    var_9 = 0;
    var_10 = scripts\engine\utility::get_array_of_closest(self.origin, level.spawned_enemies, [self], 30, var_4);

    if(isDefined(var_10)) {
      foreach(var_12 in var_10) {
        if(var_12.agent_type == "zombie_brute" || var_12.agent_type == "zombie_grey") {
          continue;
        }
        if(var_12 scripts\mp\agents\zombie\zombie_agent::dying_zapper_death()) {
          continue;
        }
        var_13 = undefined;

        if(scripts\engine\utility::is_true(self.is_traversing)) {
          var_13 = 1;
        }

        if(!scripts\engine\utility::is_true(var_12.customdeath)) {
          var_9++;

          if(var_9 >= var_8) {
            var_13 = 1;
          }

          var_12 thread fling_zombie(var_3, self.link_ent, var_0, var_13);
        }
      }
    }

    var_6 = var_6 - var_7;
    wait(var_7);
  }
}

fling_zombie(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait 0.05;

  if(scripts\engine\utility::is_true(var_3)) {
    self.nocorpse = 1;
    self.full_gib = 1;

    if(isDefined(var_2)) {
      self getrandomarmkillstreak(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    } else {
      self getrandomarmkillstreak(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    }
  } else {
    self giveflagcapturexp(vectornormalize(self.origin - var_1.origin) * 200 + (0, 0, 800));
    wait 0.1;

    if(isDefined(var_2)) {
      self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_2, var_1, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    } else {
      self getrandomarmkillstreak(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    }
  }
}

should_take_players_current_weapon(var_0) {
  var_1 = 3;

  if(var_0 scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_1 = 4;
  }

  var_2 = var_0 getweaponslist("primary");
  return var_2.size >= var_1;
}

facemelter_fx_init() {
  level._effect["base_plasma_explosion_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_large_explosion_enemy.vfx");
  level._effect["glob_plasma_pool_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_med_flames_enemy.vfx");
  level._effect["glob_plasma_impact_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_small_explosion_enemy.vfx");
  level._effect["glob_plasma_trail_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_trail_enemy.vfx");
  level._effect["dischord_tornado"] = loadfx("vfx\iw7\core\zombie\weapon\dischord\vfx_zmb_dischord_energy_tornado.vfx");
  level._effect["player_plasma_enemy"] = loadfx("vfx\iw7\_requests\mp\power\vfx_splash_grenade_light_en.vfx");
  level._effect["player_plasma_friendly"] = loadfx("vfx\iw7\_requests\mp\power\vfx_splash_grenade_light_fr.vfx");
}

facemelter_death_logic(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(self.link_ent)) {
    return;
  }
  self.scripted_mode = 1;
  self.ignoreall = 1;
  var_5 = scripts\cp\utility::weaponhasattachment(var_4, "pap1");

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim) {
    level thread facemelter_fire_pool(self, 5, var_0);
    self.nocorpse = 1;
    self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, var_0, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
    return;
  } else if(isDefined(self.is_traversing)) {
    self.rocket_feet = 1;
    level thread facemelter_fire_pool(self, 5, var_0, var_5, 1);
    self setscriptablepartstate("burning", "active", 1);

    while(scripts\engine\utility::is_true(self.is_traversing)) {
      wait 0.1;
    }
  }

  self.rocket_feet = 1;

  if(isDefined(self.pooltrigger)) {
    self.pooltrigger notify("fire_pool_done");
  }

  thread remove_rocket_feet_failsafe();
  level thread facemelter_fire_pool(self, 5, var_0, var_5);

  if(!scripts\engine\utility::is_true(self.is_cop)) {
    thread turn_on_rocket_feet();
    self waittill("ready_to_launch");
    self.link_ent = spawn("script_origin", self.origin);
    self.link_ent.angles = self.angles;
    self.link_ent thread kill_link_ent_on_death(self);
    self linkto(self.link_ent);
    var_6 = self.origin + (0, 0, 200);
    var_7 = self aiphysicstrace(self.origin, self.origin + (0, 0, 200), 15, 60, 1, 1);
    var_8 = 1;

    if(isDefined(var_7) && isDefined(var_7["position"])) {
      var_6 = var_7["position"] + (0, 0, -40);
      var_8 = var_6[2] - self.link_ent.origin[2];

      if(var_8 < 20) {
        var_8 = 20;
        var_6 = (var_6[0], var_6[1], self.link_ent.origin[2] + 20);
      }

      var_8 = var_8 / 200;
    }

    self.link_ent moveto(var_6, var_8);
    wait 0.1;
    self setscriptablepartstate("left_leg", "detached", 1);
    self setscriptablepartstate("right_leg", "detached", 1);
    wait(0.8 * var_8);
    self playSound("zombie_facemelter_rocket_launch");
  } else {
    wait 0.9;
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self setscriptablepartstate("rocket_explosion", "active", 1);
  wait 0.1;
  var_9 = self.origin;
  var_10 = var_0;
  var_11 = var_10.team;

  if(var_5) {
    var_12 = 3;

    for(var_13 = 0; var_13 < var_12; var_13++) {
      var_14 = randomintrange(-200, 200);
      var_15 = randomintrange(-200, 200);
      var_16 = randomintrange(200, 400);
      var_17 = var_9 + (var_14, var_15, var_16) - var_9;
      var_18 = var_0 launchgrenade("zmb_globproj_zm", var_9, var_17, 8);
      var_18.owner = var_0;
      var_18.team = var_0.team;
      var_18.trophy_name = "zmb_globproj_zm";

      if(var_13 == 0) {
        var_18 setscriptablepartstate("explosion", "active");
      } else {
        var_18 setscriptablepartstate("explosion", "neutral");
      }

      var_18 setscriptablepartstate("trail", "active");
      level.facemelter_globs = scripts\engine\utility::add_to_array(level.facemelter_globs, var_18);
      var_18 thread watchglobstick("iw7_facemelterdummy_zm", var_5);
      scripts\engine\utility::waitframe();
    }
  }

  var_19 = self.link_ent;

  if(isalive(self)) {
    self.rocket_feet = 0;
    self setscriptablepartstate("rocket_feet", "inactive", 1);
    self setscriptablepartstate("rocket_explosion", "inactive", 1);

    if(!isDefined(var_0)) {
      var_0 = undefined;
    }

    self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, self.link_ent, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
  }

  if(isDefined(var_19)) {
    var_19 delete();
  }
}

turn_on_rocket_feet() {
  self endon("death");
  self playSound("zombie_facemelter_rocket_feet");
  self waittill("facemelter_launch_chosen");

  if(scripts\engine\utility::is_true(self.dismember_crawl)) {
    wait 0.3;
  } else {
    wait 0.1;
  }

  self setscriptablepartstate("rocket_feet", "active", 1);
}

remove_rocket_feet_failsafe() {
  self endon("death");
  wait 6;
  self.rocket_feet = 0;
}

facemelter_fire_pool(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 75;
  var_6 = 30;

  if(isDefined(var_4)) {
    wait 0.1;
    self.pooltrigger = spawn("trigger_rotatable_radius", var_0.origin, 0, var_5, var_6);
    self.pooltrigger thread run_fire_pool(var_0, var_1, var_2, var_3);
    self.pooltrigger thread fire_pool_timeout(var_1);
    wait(var_1);
  } else {
    var_7 = spawnfx(level._effect["fire_pool_wide"], var_0.origin);
    var_7 playSound("zombie_facemelter_fire_pool");
    wait 0.1;
    var_8 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_5, var_6);
    var_8 thread run_fire_pool(var_0, var_1, var_2, var_3);
    var_8 thread fire_pool_timeout(var_1);
    var_7 setfxkilldefondelete();
    triggerfx(var_7);
    wait(var_1);
    var_7 delete();
  }
}

run_fire_pool(var_0, var_1, var_2, var_3) {
  self endon("fire_pool_done");
  var_4 = var_1 * 10;

  for(;;) {
    self waittill("trigger", var_5);

    if(isDefined(var_5.rocket_feet)) {
      wait 0.1;
      continue;
    } else if(isplayer(var_5)) {
      if(var_2 == var_5 && !scripts\engine\utility::is_true(var_3) && !isDefined(var_5.burning)) {
        if(!scripts\engine\utility::is_true(var_5.inlaststand)) {
          var_5.burning = 1;
          var_5 thread dodamageandunsetburnstate(var_5, self);
        }
      }

      wait 0.1;
      continue;
    } else if(isalive(var_5)) {
      level thread scripts\cp\utility::damage_over_time(var_5, var_2, 5, var_5.health + 1000, undefined, "iw7_facemelterdummy_zm", 0, "burning");
    }

    wait 0.1;
  }
}

dodamageandunsetburnstate(var_0, var_1) {
  var_0 notify("doDamageAndUnsetBurnState");
  var_0 endon("doDamageAndUnsetBurnState");
  var_0 endon("disconnect");

  if(isalive(var_0)) {
    var_0 getrandomarmkillstreak(int(var_0.maxhealth * 0.15), var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_facemelterdummy_zm");
  }

  wait 1;
  var_0.burning = undefined;
}

fire_pool_timeout(var_0) {
  wait(var_0);
  self notify("fire_pool_done");
  self delete();
}

shredder_death_logic(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(scripts\mp\agents\zombie\zombie_agent::dying_zapper_death()) {
    return;
  }
  self.shredder_death = 1;
  self.ignoreall = 1;
  self clearpath();
  wait 0.1;
  var_4 = ["left_arm", "right_arm"];
  var_4 = scripts\engine\utility::array_randomize(var_4);

  if(!scripts\engine\utility::is_true(self.is_cop)) {
    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.25;
    }

    var_4 = ["right_leg", "left_leg"];
    var_4 = scripts\engine\utility::array_randomize(var_4);

    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.25;
    }

    self setscriptablepartstate("shredder_fx", "active", 1);
    wait 0.25;
    self setscriptablepartstate("head", "detached", 1);
  } else {
    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.1;
    }

    var_4 = ["right_leg", "left_leg"];
    var_4 = scripts\engine\utility::array_randomize(var_4);

    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.1;
    }

    self.full_gib = 1;
  }

  wait 0.1;
  self.nocorpse = 1;
  self.deathmethod = "shredder";
  self.shredder_death = 0;
  self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, undefined, "MOD_UNKNOWN", "iw7_shredderdummy_zm");
}

check_to_use_headshot_explosion(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::isbulletdamage(var_3) || var_3 == "MOD_EXPLOSIVE_BULLET" && var_5 != "none";

  if(!var_7) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(var_4, var_5, var_3, var_0)) {
    return;
  }
  var_0 scripts\cp\utility::notify_used_consumable("headshot_explosion");
  thread explode_head_with_fx(var_0, var_5, var_2, "bloody_death", undefined, var_6);
}

explode_head_with_fx(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\agents\zombie\zombie_agent::dying_zapper_death()) {
    return;
  }
  if(scripts\cp\utility::agentisfnfimmune()) {
    return;
  }
  self.head_is_exploding = 1;
  var_4 = self gettagorigin("J_Spine4");
  playLoopSound(self.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect[var_3], var_4);

  foreach(var_7 in level.players) {
    if(distance(var_7.origin, var_4) <= 350) {
      var_7 thread showonscreenbloodeffects();
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(!var_5) {
    self setscriptablepartstate("head", "hide");
  }
}

showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::waittill_any_timeout(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

head_shard_init() {
  level._effect["head_exploder"] = loadfx("vfx\iw7\_requests\coop\zmb_head_exploder.vfx");
  level._effect["head_expander"] = loadfx("vfx\iw7\_requests\coop\zmb_head_expander.vfx");
  level._effect["head_blood_explosion"] = loadfx("vfx\iw7\_requests\coop\zmb_head_blood_explosion.vfx");
}

head_exploder(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(scripts\mp\agents\zombie\zombie_agent::dying_zapper_death()) {
    return;
  }
  self.head_is_exploding = 1;
  wait(randomfloatrange(0.0, 0.5));

  if(!scripts\engine\utility::is_true(self.is_cop)) {
    self setscriptablepartstate("eyes", "headcutter_eyes");
  }

  self.ignoreall = 1;
  self clearpath();
  wait 1;
  self setscriptablepartstate("eyes", "eye_glow_off");
  wait 0.1;
  self setscriptablepartstate("headcutter_fx", "active");
  wait 0.1;
  self setscriptablepartstate("head", "hide", 1);
  wait 0.1;
  var_1 = self gettagorigin("J_Spine4");
  var_0 thread explode_head_shards(var_0, var_1, self, var_4);

  if(scripts\engine\utility::is_true(self.is_cop)) {
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self getrandomarmkillstreak(self.health + 1000, self.origin, var_0, undefined, "MOD_UNKNOWN", "iw7_headcutterdummy_zm");
}

explode_head_shards(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::weaponhasattachment(var_3, "pap1");
  var_5 = getweaponbasename(var_3);
  var_6 = "iw7_headcutterdummy_zm";
  var_7 = 15000;

  switch (var_5) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
      if(var_4) {
        var_6 = "iw7_headcutter2_zm+hcpap1";
      } else {
        var_6 = "iw7_headcutter2_zm";
      }

      break;
    case "iw7_headcutter2_zm":
      if(var_4) {
        var_6 = "iw7_headcutter3_zm+hcpap1";
      } else {
        var_6 = "iw7_headcutterdummy_zm";
      }

      break;
  }

  var_8 = [];
  var_8 = level.spawned_enemies;
  var_9 = [var_2];
  var_10 = 128;

  if(var_4) {
    var_10 = 256;
  }

  var_11 = scripts\engine\utility::get_array_of_closest(var_1, var_8, var_9, undefined, var_10, 0);

  foreach(var_13 in var_11) {
    if(isDefined(var_13.agent_type) && (var_13.agent_type == "zombie_grey" || var_13.agent_type == "zombie_brute")) {
      var_14 = 100;
    } else {
      var_14 = 100000;
    }

    var_13 getrandomarmkillstreak(var_14, var_1, var_0, var_0, "MOD_EXPLOSIVE", var_6);
  }
}

delayshardfire(var_0, var_1, var_2, var_3) {
  var_3 endon("disconnect");
  wait(var_0);
  var_4 = magicbullet("iw7_headcuttershards_mp", var_1, var_2, var_3);
}

weapon_watch_hint() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  var_0 = getweaponbasename(self getcurrentprimaryweapon());
  var_1 = self getcurrentweapon();
  var_2 = undefined;

  for(;;) {
    if(isDefined(var_0) && var_0 == "iw7_axe_zm" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE_AXE_HINT", 4);
      self.axe_hint_display = self.axe_hint_display + 1;
    } else if(isDefined(var_0) && var_0 == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE_FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display = self.forgefreeze_hint_display + 1;
    }

    updatecamoscripts(var_1, var_2);
    var_2 = var_1;
    self waittill("weapon_change");
    wait 0.5;
    var_0 = getweaponbasename(self getcurrentprimaryweapon());
    var_1 = self getcurrentweapon();
  }
}

updatecamoscripts(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = getweaponcamoname(var_0);
  } else {
    var_2 = undefined;
  }

  if(isDefined(var_1)) {
    var_3 = getweaponcamoname(var_1);
  } else {
    var_3 = undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  clearcamoscripts(var_1, var_3);
  runcamoscripts(var_0, var_2);
}

runcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "camo211":
      self setscriptablepartstate("camo_211", "reset");
      break;
    case "camo212":
      self setscriptablepartstate("camo_212", "reset");
      break;
    case "camo204":
      self setscriptablepartstate("camo_204", "activate");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "activate");
      break;
    case "camo84":
      thread blood_camo_84();
      break;
    case "camo222":
      thread blood_camo_222();
      break;
    case "camo92":
      self setscriptablepartstate("camo_92", "reset");
      break;
    case "camo93":
      self setscriptablepartstate("camo_93", "reset");
      break;
  }
}

clearcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "camo204":
      self setscriptablepartstate("camo_204", "neutral");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "neutral");
      break;
    case "camo84":
      self notify("blood_camo_84");
      break;
    case "camo222":
      self notify("blood_camo_222");
      break;
  }
}

blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");

  if(!isDefined(self.bloodcamokillcount)) {
    self.bloodcamokillcount = 0;
  }

  var_0 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;

    if(self.bloodcamokillcount / 5 == var_0) {
      var_1 = int(self.bloodcamokillcount / 5);

      if(var_1 > 14) {
        break;
      }
      self setscriptablepartstate("camo_84", var_1 + "_kills");
      var_0++;
    }
  }
}

blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");
  var_0 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self.katanacamokillcount = self.katanacamokillcount + 1;

    if(self.katanacamokillcount / 5 == var_0) {
      var_1 = int(self.katanacamokillcount / 5);

      if(var_1 > 10) {
        break;
      }
      self setscriptablepartstate("camo_222", var_1 + "_kills");
      var_0++;
    }
  }
}

axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", var_0, var_1, var_2);
    var_3 = getweaponbasename(var_0);
    var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
    var_5 = get_melee_weapon_fov(var_3, var_4);
    var_6 = get_melee_weapon_hit_distance(var_3, var_4);
    var_7 = get_melee_weapon_max_enemies(var_3, var_4);
    var_8 = checkenemiesinfov(var_5, var_6, var_7);
    thread setaxescriptablestate(self);

    foreach(var_10 in var_8) {
      if(var_10 == var_1) {
        continue;
      }
      var_10 thread axe_damage(var_10, self, var_2, var_10.origin, self.origin, var_0, 0.5);
    }
  }
}

setaxeidlescriptablestate(var_0) {
  var_0 setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe - idle", "level 1");
}

setaxescriptablestate(var_0) {
  var_0 notify("setaxeblooddrip");
  var_0 endon("setaxeblooddrip");
  var_0 setscriptablepartstate("axe", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe", "blood on");
  wait 5;
  var_0 setscriptablepartstate("axe", "neutral");
}

get_melee_weapon_fov(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 45;
  }

  switch (var_1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

get_melee_weapon_hit_distance(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 125;
  }

  switch (var_1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

get_melee_weapon_max_enemies(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  switch (var_1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

get_melee_weapon_melee_damage(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1100;
  }

  switch (var_1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

create_explosion_sphere(var_0) {
  var_1 = var_0 / 2;
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.0);
}

playredrepulsorfx() {
  var_0 = spawnfxforclient(level._effect["repulsor_view_red"], self gettagorigin("tag_eye"), self);
  triggerfx(var_0);
  var_0 thread scripts\cp\utility::delayentdelete(1);
  playrumbleonentity("slide_collision", self.origin);
  self earthquakeforplayer(0.5, 0.5, self.origin, 62.5);
}

checkenemiesinfov(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, var_1, 1);

  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectornormalize(var_9) * -25;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::within_fov(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);

    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);

        if(var_14 < var_1) {
          var_11 = 1;
        }
      } else {
        var_11 = 1;
      }
    }

    if(var_11 && var_4.size < var_2) {
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

axe_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");

  if(var_0 scripts\cp\agents\gametype_zombie::is_non_standard_zombie()) {
    var_0.allowpain = 1;
  }

  var_0 getrandomarmkillstreak(var_2, var_3, var_1, var_1, "MOD_MELEE", var_5);
  wait(var_6);

  if(scripts\engine\utility::is_true(var_0.allowpain)) {
    var_0.allowpain = 0;
  }
}

reload_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    self waittill("reload");

    if(scripts\cp\utility::is_escape_gametype()) {
      var_0 = self getcurrentweapon();
      var_1 = self getweaponammostock(var_0);
      var_2 = weaponclipsize(var_0);
      self setweaponammostock(var_0, var_1 + var_2);
    }
  }
}

arcane_attachment_watcher(var_0) {
  scripts\engine\utility::flag_wait("doors_initialized");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");

  while(!isDefined(var_0.suit)) {
    wait 0.1;
  }

  var_0 thread unsetstatewhenadswithsniper(var_0);

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any("weapon_change", "weapon_switch_started", "ads_out");
    var_0 clear_arcane_effects(var_0);
    var_0 turn_off_zapper_fx();
    var_0 thread wait_for_weapon_switch_done(var_0);
  }
}

scriptable_notify_test() {
  scripts\engine\utility::flag_wait("doors_initialized");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("scriptableNotification", var_0, var_1, var_2);

    if(!isDefined(var_0)) {
      continue;
    }
    wait 0.05;
  }
}

unsetstatewhenadswithsniper(var_0) {
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("ads_in", "+speed_throw");
  var_0 notifyonplayercommand("ads_out", "-speed_throw");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_return("ads_in", "ads_out");

    if(var_0 scripts\cp\utility::coop_getweaponclass(var_0 getcurrentweapon()) == "weapon_sniper") {
      if(var_1 == "ads_in") {
        var_0 clear_arcane_scriptable_effects(var_0);
        var_0.pause_arcane_logic = 1;
        continue;
      }

      var_0.pause_arcane_logic = undefined;
    }
  }
}

clear_arcane_scriptable_effects(var_0) {
  var_0 setscriptablepartstate("arcane", "neutral", 1);
}

clear_arcane_effects(var_0) {
  var_0 setclientomnvar("zm_ui_specialammo", 0);
  var_0.special_ammo_type = undefined;
  var_0 setscriptablepartstate("arcane", "neutral", 1);

  if(var_0 scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }

  if(var_0 scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_armorpiercing");
  }

  if(var_0 scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_bulletdamage");
  }
}

wait_for_weapon_switch_done(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("wait_for_weapon_switch_done");
  var_0 endon("wait_for_weapon_switch_done");
  var_0 endon("disconnect");
  var_0 endon("weapon_switch_started");

  while(var_0 isswitchingweapon()) {
    wait 0.05;
  }

  var_2 = var_0 getcurrentweapon();
  var_0 notify("weapon_switch_done", var_2);
  var_0 assign_ark_attachment_properties(var_0, undefined, var_2);
  var_0 handle_zapper_fx(var_0, var_2);
}

assign_ark_attachment_properties(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(var_0.pause_arcane_logic)) {
    return;
  }
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      var_2 = self getcurrentweapon();
    }

    if(!issubstr(var_2, "ark")) {
      return;
    }
    var_3 = strtok(var_2, "+");

    foreach(var_5 in var_3) {
      if(issubstr(var_5, "ark")) {
        var_1 = var_5;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = "blank";
  }

  switch (var_1) {
    case "arkblue_sm":
    case "arkblue_akimbo":
    case "blue":
    case "arkblue":
      self setclientomnvar("zm_ui_specialammo", 1);
      self.special_ammo_type = "stun_ammo";
      self.special_ammo_weapon = var_2;

      if(!scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        scripts\cp\utility::giveperk("specialty_bulletdamage");
      }

      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      self setscriptablepartstate("arcane", "blue_on", 0);
      break;
    case "arkgreen_sm":
    case "arkgreen_akimbo":
    case "arkgreen":
    case "green":
      self.special_ammo_type = "poison_ammo";
      self setclientomnvar("zm_ui_specialammo", 0);
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "green_on", 0);
      break;
    case "arkyellow_sm":
    case "arkyellow_akimbo":
    case "yellow":
    case "arkyellow":
      self setclientomnvar("zm_ui_specialammo", 3);
      self.special_ammo_type = "explosive_ammo";

      if(!scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
        scripts\cp\utility::giveperk("specialty_explosivebullets");
      }

      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "yellow_on", 0);
      break;
    case "arkred_sm":
    case "arkred_akimbo":
    case "arkred":
    case "red":
      self setclientomnvar("zm_ui_specialammo", 2);
      self.special_ammo_type = "incendiary_ammo";
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "red_on", 0);
      break;
    case "arkpink_sm":
    case "arkpink_akimbo":
    case "arkpink_lmg":
    case "arkpink":
    case "pink":
      self setclientomnvar("zm_ui_specialammo", 5);
      self.special_ammo_type = "combined_ammo";

      if(!scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        scripts\cp\utility::giveperk("specialty_bulletdamage");
      }

      if(!scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
        scripts\cp\utility::giveperk("specialty_armorpiercing");
      }

      self setscriptablepartstate("arcane", "pink_on", 0);
      break;
    default:
      self setclientomnvar("zm_ui_specialammo", 0);
      self.special_ammo_type = undefined;
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "neutral", 0);
      break;
  }
}

handle_zapper_fx(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getcurrentweapon();
  }

  var_2 = getweaponbasename(var_1);
  turn_off_zapper_fx();

  if(isDefined(var_2)) {
    switch (var_2) {
      case "iw7_facemelter_zm_pap1":
      case "iw7_facemelter_zm":
        self setscriptablepartstate("facemelter", "active");
        break;
      case "iw7_headcutter_zm_pap1":
      case "iw7_headcutter_zm":
        self setscriptablepartstate("headcutter", "active");
        break;
      case "iw7_dischord_zm_pap1":
      case "iw7_dischord_zm":
        self setscriptablepartstate("dischord", "active");
        break;
      case "iw7_shredder_zm_pap1":
      case "iw7_shredder_zm":
        self setscriptablepartstate("shredder", "active");
        break;
    }
  }
}

turn_off_zapper_fx() {
  self setscriptablepartstate("headcutter", "inactive");
  self setscriptablepartstate("facemelter", "inactive");
  self setscriptablepartstate("dischord", "inactive");
  self setscriptablepartstate("shredder", "inactive");
}

get_ark_attachment_type(var_0) {
  var_1 = strtok(var_0, "+");

  foreach(var_3 in var_1) {
    var_4 = getsubstr(var_3, 0, 3);

    if(var_4 == "ark") {
      switch (var_3) {
        case "arkblueburst":
        case "arkblueshotgun":
        case "arkblueautospread":
        case "arkblueauto":
        case "arkbluesingle":
          return "arkblue";
        case "arkgreenburst":
        case "arkgreenshotgun":
        case "arkgreenautospread":
        case "arkgreenauto":
        case "arkgreensingle":
          return "arkgreen";
        case "arkyellowburst":
        case "arkyellowshotgun":
        case "arkyellowautospread":
        case "arkyellowauto":
        case "arkyellowsingle":
          return "arkyellow";
        case "arkpinkburst":
        case "arkpinkshotgun":
        case "arkpinkautospread":
        case "arkpinkauto":
        case "arkpinksingle":
          return "arkpink";
        case "arkredburst":
        case "arkredshotgun":
        case "arkredautospread":
        case "arkredauto":
        case "arkredsingle":
          return "arkred";
        case "arkwhiteburst":
        case "arkwhiteshotgun":
        case "arkwhiteautospread":
        case "arkwhiteauto":
        case "arkwhitesingle":
          return "arkwhite";
      }
    }
  }

  return undefined;
}

weapon_in_inventory(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

watchglobstick(var_0, var_1) {
  self endon("death");
  thread remove_from_glob_array_on_death();
  self waittill("missile_stuck", var_2);

  if(!isDefined(self.owner)) {
    return;
  }
  self setscriptablepartstate("trail", "neutral");
  self setscriptablepartstate("explosion", "active");
  playLoopSound(self.origin, "plasma_grenade_impact");
  radiusdamage(self.origin, 128, 10, 5, self.owner, "MOD_EXPLOSIVE", var_0);

  if(level.facemelter_globs.size > 5) {
    self delete();
    return;
  }

  var_3 = spawn("trigger_rotatable_radius", self.origin, 0, 60, 60);
  var_3.angles = self.angles;
  var_3.owner = self.owner;
  var_3.team = self.owner.team;
  var_3 thread watchplayerstouchingpool(var_0, var_1);
  var_3 thread scripts\cp\utility::delayentdelete(8);
  var_3 thread delayplaySound(0.1, "plasma_grenade_fire_glob");
  self.poolscriptablepart = "poolGround";
  self setscriptablepartstate("poolGround", "active");
  wait 8;
  self setscriptablepartstate(self.poolscriptablepart, "activeEnd", 0);
  self delete();
}

remove_from_glob_array_on_death() {
  self waittill("death");
  level.facemelter_globs = scripts\engine\utility::array_remove(level.facemelter_globs, self);
}

startdamageovertime(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("disconnect");
  self.startedplasmastand = 1;
  self.startedplasmalinger = undefined;
  self.is_burning = 1;
  thread watchgrenadedotend();
  thread watchstartlingerdamage(var_0, var_1);

  if(isDefined(level.splash_grenade_victim_scriptable_state_func) && isalive(self) && isDefined(self.species) && self.species == "zombie") {
    self thread[[level.splash_grenade_victim_scriptable_state_func]](self);
  }

  thread standingdotdamage(var_0, var_1, var_2, var_3, var_4);
}

play_fx_for_time(var_0, var_1, var_2) {
  var_3 = undefined;
  var_3 = spawnfx(scripts\engine\utility::getfx(var_1), var_0);

  if(isDefined(var_3)) {
    triggerfx(var_3);
  }

  var_3 thread scripts\cp\utility::delayentdelete(var_2);
  return var_3;
}

watchplayerstouchingpool(var_0, var_1) {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    self waittill("trigger", var_2);

    if(scripts\cp\utility::isreallyalive(var_2) && !isDefined(var_2.startedplasmastand) && (var_2.team != self.owner.team || var_2 == self.owner)) {
      if(var_1) {
        if(var_2 == self.owner) {
          continue;
        }
      }

      var_2 notify("start_plasma_stand");
      var_2 thread startdamageovertime(var_0, self.owner, 33, 0.5, self);
      var_2 thread watchistouchingtrigger(self);
    }
  }
}

watchistouchingtrigger(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(!isDefined(var_0) || !self istouching(var_0)) {
      self notify("plasma_dot_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watchgrenadedotend() {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::waittill_any("plasma_dot_end");
  self.startedplasmastand = undefined;
  self.startedplasmalinger = undefined;
  self.globtouched = undefined;
  self.is_burning = undefined;
  stopFXOnTag(scripts\engine\utility::getfx("glob_plasma_trail_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_friendly"), self, "j_mainroot");
}

watchstartlingerdamage(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("plasma_dot_end");
  var_1 endon("disconnect");
  self waittill("start_plasma_linger");
  var_2 = 1;
  var_3 = 25;
  var_4 = 1;
  self.startedplasmastand = undefined;
  self.startedplasmalinger = 1;
  var_5 = spawnfxforclient(scripts\engine\utility::getfx("player_plasma_screen_linger"), self getEye(), self);
  triggerfx(var_5);
  var_5 thread scripts\cp\utility::delayentdelete(1);
  var_5 thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
  var_5 thread deletepentsondisconnect(self);
  thread damageplayerovertime(var_0, var_1, var_3, var_4, var_2, "start_plasma_stand", "plasma_dot_end");
}

deleteonlingerstart(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("plasma_dot_end");

  if(isDefined(self)) {
    self delete();
  }
}

delayplayfxontagforclients(var_0, var_1, var_2, var_3) {
  var_2 endon("death");
  wait(var_0);

  if(isDefined(var_2) && isDefined(self)) {
    playfxontagforclients(scripts\engine\utility::getfx(var_1), var_2, var_3, self);
  }
}

standingdotdamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("disconnect");

  if(isDefined(var_4)) {
    var_4 endon("death");
  }

  var_5 = int(var_2 / 4);
  var_6 = var_3;
  childthread damageplayerovertime(var_0, var_1, var_5, var_6, undefined, "start_stage2_plasma");
  wait 1;
  self notify("start_stage2_plasma");
  var_5 = int(var_2 / 2);
  var_6 = var_3 / 2;
  childthread damageplayerovertime(var_0, var_1, var_5, var_6, undefined, "start_stage3_plasma");
  wait 0.5;
  self notify("start_stage3_plasma");
  var_5 = var_2;
  var_6 = var_3 / 4;
  childthread damageplayerovertime(var_0, var_1, var_5, var_6);
}

damageplayerovertime(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  var_1 endon("disconnect");

  if(!isDefined(var_4)) {
    for(;;) {
      self getrandomarmkillstreak(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
      self.flame_damage_time = gettime() + 500;
      wait(var_3);
    }
  } else {
    if(var_3 > var_4) {
      return;
    }
    var_7 = var_2;

    if(self.health <= var_7) {
      self getrandomarmkillstreak(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
      self.flame_damage_time = gettime() + 500;
    }

    while(var_4 > 0) {
      if(self.health > 15 && self.health - var_2 < 15) {
        var_2 = var_2 - (15 - (self.health - var_2));
      }

      if(self.health > var_7 && self.health <= 15) {
        var_2 = 1;
      }

      if(var_2 > 0) {
        self getrandomarmkillstreak(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
        self.flame_damage_time = gettime() + 500;
      }

      var_4 = var_4 - var_3;
      wait(var_3);
    }

    if(isDefined(var_6)) {
      self notify(var_6);
    }
  }
}

deletepentsondisconnect(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("start_plasma_stand");

  if(isDefined(self)) {
    self delete();
  }
}

delayplaySound(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self playSound(var_1);
}