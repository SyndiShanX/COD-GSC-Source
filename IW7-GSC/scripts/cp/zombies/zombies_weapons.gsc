/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_weapons.gsc
**************************************************/

init() {
  scripts\cp\cp_spawn_plasma_projectile::splashgrenadeinit();
  head_shard_init();
  facemelter_fx_init();
  level.facemelter_globs = [];
}

activate_zero_g_on_character(param_00) {
  param_00 thread agent_float_in_air(param_00);
}

deactivate_zero_g_on_character(param_00) {
  param_00 unlink();
  if(isDefined(level.deactivate_zerog_func)) {
    [[level.deactivate_zerog_func]](param_00);
  }
}

agent_float_in_air(param_00) {
  var_01 = 5;
  var_02 = bulletTrace(param_00.origin, param_00.origin + (0, 0, 170), 0, param_00);
  var_03 = var_02["position"];
  var_04 = var_03[2] - param_00.origin[2];
  var_05 = min(var_04, 170) - 70;
  var_06 = spawn("script_origin", param_00.origin);
  var_06.angles = param_00.angles;
  param_00.do_immediate_ragdoll = 1;
  param_00 linkto(var_06);
  var_06 moveto(param_00.origin + (0, 0, var_05), var_01);
  var_07 = var_06 scripts\cp\utility::waittill_any_ents_return(level, "deactivate zero g", param_00, "death");
  if(isDefined(param_00)) {
    param_00.do_immediate_ragdoll = 0;
  }

  var_06 delete();
}

fx_stun_damage() {
  self endon("death");
  self.stunned = 1;
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  wait(0.5);
  self.stunned = undefined;
}

special_weapon_logic(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey") {
    return;
  }

  var_0C = scripts\engine\utility::istrue(param_01.inlaststand);
  var_0D = scripts\engine\utility::istrue(self.is_suicide_bomber);
  var_0E = getweaponbasename(param_05);
  if(!isDefined(var_0E)) {
    return;
  }

  var_0F = 0;
  if(!var_0D) {
    switch (var_0E) {
      case "iw7_headcutter3_zm":
      case "iw7_headcutter2_zm":
      case "iw7_headcutter_zm_pap1":
      case "iw7_headcutter_zm":
        if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\engine\utility::istrue(self.isfrozen)) {
          self.health = param_02 + 1;
          self.allowpain = 1;
          self.killedby = param_01;
          thread head_exploder(param_01, param_06, param_08, param_02, param_05);
          var_0F = 1;
        }
        break;

      case "iw7_dischord_zm_pap1":
      case "iw7_dischord_zm":
        if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\engine\utility::istrue(self.isfrozen)) {
          self.health = param_02 + 1;
          self.allowpain = 1;
          self.killedby = param_01;
          thread dischord_death_logic(param_01, param_06, param_08, param_02, param_05);
        }
        break;

      case "iw7_facemelter_zm_pap1":
      case "iw7_facemelter_zm":
        if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\engine\utility::istrue(self.isfrozen)) {
          self.health = param_02 + 1;
          self.allowpain = 1;
          self.killedby = param_01;
          thread facemelter_death_logic(param_01, param_06, param_08, param_02, param_05);
        }
        break;

      case "iw7_shredder_zm_pap1":
      case "iw7_shredder_zm":
        if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\engine\utility::istrue(self.isfrozen)) {
          self.health = param_02 + 1;
          self.allowpain = 1;
          self.killedby = param_01;
          thread shredder_death_logic(param_01, param_06, param_08, param_02);
        }
        break;

      default:
        break;
    }

    if(self.health - param_02 < 1) {
      if(isDefined(level.medusa_check_func)) {
        var_10 = [
          [level.medusa_check_func]
        ](self);
        if(isDefined(var_10)) {
          self.nocorpse = 1;
          self.near_medusa = var_10;
        } else {
          self.near_medusa = undefined;
        }
      }

      if(isDefined(level.crystal_check_func)) {
        if(isplayer(param_01) && isDefined(param_05) && param_05 != "none") {
          var_11 = [
            [level.crystal_check_func]
          ](self, param_05);
          if(var_11) {
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

  if(self.health - param_02 < 1) {
    if(isDefined(level.lethaldamage_func)) {
      [
        [level.lethaldamage_func]
      ](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    }

    if(!var_0C && !var_0F) {
      if(param_01 scripts\cp\utility::is_consumable_active("headshot_explosion")) {
        check_to_use_headshot_explosion(param_01, param_06, param_02, param_04, param_05, param_08, var_0D);
        return;
      }

      if(param_01 scripts\cp\utility::has_zombie_perk("perk_machine_change")) {
        [
          [level.change_chew_explosion_func]
        ](param_01, param_06, param_02, param_04, param_05, param_08);
        return;
      }

      return;
    }
  }
}

dischord_death_logic(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.link_ent)) {
    return;
  }

  self endon("death");
  if(scripts\engine\utility::istrue(self.is_dancing) || self.scripted_mode) {
    self.do_immediate_ragdoll = 1;
    self dodamage(self.health + 1000, self.origin, param_00, param_00, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  self.scripted_mode = 1;
  var_05 = 0;
  var_06 = scripts\cp\utility::weaponhasattachment(param_04, "pap1");
  var_07 = 50;
  if(var_06) {
    var_07 = 100;
    self.upgraded_dischord_spin = 1;
  }

  self.dischord_spin = 1;
  if(scripts\engine\utility::istrue(self.is_traversing)) {
    thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 5);
    playFXOnTag(level._effect["dischord_tornado"], self, "tag_origin");
    var_05 = 1;
    while(scripts\engine\utility::istrue(self.is_traversing)) {
      wait(0.1);
    }

    self notify("stop_spin");
  }

  thread kill_me_after_timeout(5, "ready_to_spin");
  if(!var_05) {
    self setscriptablepartstate("dischord_spin_fx", "active", 1);
  }

  self waittill("ready_to_spin");
  self.link_ent = spawn("script_origin", self.origin);
  self.link_ent thread kill_link_ent_on_death(self);
  if(!var_06) {
    self linkto(self.link_ent);
  }

  thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 0.5);
  self.link_ent rotateyaw(360, 1);
  wait(0.5);
  thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 0.5);
  self.link_ent rotateyaw(720, 1);
  wait(0.5);
  thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 1);
  self.link_ent rotateyaw(1080, 1);
  wait(1);
  thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 1);
  self.link_ent rotateyaw(1240, 1);
  wait(1);
  if(var_06) {
    thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 2);
    wait(2);
  } else {
    thread dischord_spin_attack(param_00, param_01, param_02, param_03, var_07, 0.1);
  }

  playsoundatpos(self.origin, "zombie_dischord_zmb_spin_explo");
  self.full_gib = 1;
  self.nocorpse = 1;
  self.gib_fx_override = "dischord_explosion";
  self setscriptablepartstate("dischord_spin_fx", "inactive", 1);
  var_08 = 128;
  if(var_06) {
    var_08 = 256;
  }

  if(isDefined(param_00)) {
    param_00 radiusdamage(self.origin, var_08, 2000, 2000, param_00, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  } else {
    level.players[0] radiusdamage(self.origin, var_08, 2000, 2000, level.players[0], "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  if(isDefined(self.link_ent)) {
    self.dischord_spin = 0;
    self.deathmethod = "dischord";
    self dodamage(self.health + 1000, self.origin, param_00, self.link_ent, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }
}

kill_link_ent_on_death(param_00) {
  param_00 waittill("death");
  wait(0.25);
  self delete();
}

kill_me_after_timeout(param_00, param_01) {
  if(isDefined(param_01)) {
    self endon(param_01);
  }

  wait(param_00);
  self suicide();
}

dischord_spin_attack(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  self endon("stop_spin");
  var_06 = param_05;
  var_07 = 0.1;
  var_08 = 2;
  param_03 = 3000;
  if(param_04 == 100) {
    param_03 = 7000;
  }

  while(var_06 > 0) {
    var_09 = 0;
    var_0A = scripts\engine\utility::get_array_of_closest(self.origin, level.spawned_enemies, [self], 30, param_04);
    if(isDefined(var_0A)) {
      foreach(var_0C in var_0A) {
        if(var_0C.agent_type == "zombie_brute" || var_0C.agent_type == "zombie_grey") {
          continue;
        }

        if(var_0C scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death()) {
          continue;
        }

        var_0D = undefined;
        if(scripts\engine\utility::istrue(self.is_traversing)) {
          var_0D = 1;
        }

        if(!scripts\engine\utility::istrue(var_0C.customdeath)) {
          var_09++;
          if(var_09 >= var_08) {
            var_0D = 1;
          }

          var_0C thread fling_zombie(param_03, self.link_ent, param_00, var_0D);
        }
      }
    }

    var_06 = var_06 - var_07;
    wait(var_07);
  }
}

fling_zombie(param_00, param_01, param_02, param_03) {
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait(0.05);
  if(scripts\engine\utility::istrue(param_03)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    if(isDefined(param_02)) {
      self dodamage(self.health + 1000, self.origin, param_02, param_02, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    return;
  }

  self setvelocity(vectornormalize(self.origin - param_01.origin) * 200 + (0, 0, 800));
  wait(0.1);
  if(isDefined(param_02)) {
    self dodamage(self.health + 1000, param_01.origin, param_02, param_01, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    return;
  }

  self dodamage(self.health + 1000, param_01.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
}

should_take_players_current_weapon(param_00) {
  var_01 = 3;
  if(param_00 scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_01 = 4;
  }

  var_02 = param_00 getweaponslist("primary");
  return var_02.size >= var_01;
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

facemelter_death_logic(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  if(isDefined(self.link_ent)) {
    return;
  }

  self.scripted_mode = 1;
  self.precacheleaderboards = 1;
  var_05 = scripts\cp\utility::weaponhasattachment(param_04, "pap1");
  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim) {
    level thread facemelter_fire_pool(self, 5, param_00);
    self.nocorpse = 1;
    self dodamage(self.health + 1000, self.origin, param_00, param_00, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
    return;
  } else if(isDefined(self.is_traversing)) {
    self.rocket_feet = 1;
    level thread facemelter_fire_pool(self, 5, param_00, var_05, 1);
    self setscriptablepartstate("burning", "active", 1);
    while(scripts\engine\utility::istrue(self.is_traversing)) {
      wait(0.1);
    }
  }

  self.rocket_feet = 1;
  if(isDefined(self.pooltrigger)) {
    self.pooltrigger notify("fire_pool_done");
  }

  thread remove_rocket_feet_failsafe();
  level thread facemelter_fire_pool(self, 5, param_00, var_05);
  if(!scripts\engine\utility::istrue(self.is_cop)) {
    thread turn_on_rocket_feet();
    self waittill("ready_to_launch");
    self.link_ent = spawn("script_origin", self.origin);
    self.link_ent.angles = self.angles;
    self.link_ent thread kill_link_ent_on_death(self);
    self linkto(self.link_ent);
    var_06 = self.origin + (0, 0, 200);
    var_07 = self aiphysicstrace(self.origin, self.origin + (0, 0, 200), 15, 60, 1, 1);
    var_08 = 1;
    if(isDefined(var_07) && isDefined(var_07["position"])) {
      var_06 = var_07["position"] + (0, 0, -40);
      var_08 = var_06[2] - self.link_ent.origin[2];
      if(var_08 < 20) {
        var_08 = 20;
        var_06 = (var_06[0], var_06[1], self.link_ent.origin[2] + 20);
      }

      var_08 = var_08 / 200;
    }

    self.link_ent moveto(var_06, var_08);
    wait(0.1);
    self setscriptablepartstate("left_leg", "detached", 1);
    self setscriptablepartstate("right_leg", "detached", 1);
    wait(0.8 * var_08);
    self playSound("zombie_facemelter_rocket_launch");
  } else {
    wait(0.9);
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self setscriptablepartstate("rocket_explosion", "active", 1);
  wait(0.1);
  var_09 = self.origin;
  var_0A = param_00;
  var_0B = var_0A.team;
  if(var_05) {
    var_0C = 3;
    for(var_0D = 0; var_0D < var_0C; var_0D++) {
      var_0E = randomintrange(-200, 200);
      var_0F = randomintrange(-200, 200);
      var_10 = randomintrange(200, 400);
      var_11 = var_09 + (var_0E, var_0F, var_10) - var_09;
      var_12 = param_00 launchgrenade("zmb_globproj_zm", var_09, var_11, 8);
      var_12.triggerportableradarping = param_00;
      var_12.team = param_00.team;
      var_12.trophy_name = "zmb_globproj_zm";
      if(var_0D == 0) {
        var_12 setscriptablepartstate("explosion", "active");
      } else {
        var_12 setscriptablepartstate("explosion", "neutral");
      }

      var_12 setscriptablepartstate("trail", "active");
      level.facemelter_globs = scripts\engine\utility::array_add_safe(level.facemelter_globs, var_12);
      var_12 thread watchglobstick("iw7_facemelterdummy_zm", var_05);
      scripts\engine\utility::waitframe();
    }
  }

  var_13 = self.link_ent;
  if(isalive(self)) {
    self.rocket_feet = 0;
    self setscriptablepartstate("rocket_feet", "inactive", 1);
    self setscriptablepartstate("rocket_explosion", "inactive", 1);
    if(!isDefined(param_00)) {
      param_00 = undefined;
    }

    self dodamage(self.health + 1000, self.origin, param_00, self.link_ent, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
  }

  if(isDefined(var_13)) {
    var_13 delete();
  }
}

turn_on_rocket_feet() {
  self endon("death");
  self playSound("zombie_facemelter_rocket_feet");
  self waittill("facemelter_launch_chosen");
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    wait(0.3);
  } else {
    wait(0.1);
  }

  self setscriptablepartstate("rocket_feet", "active", 1);
}

remove_rocket_feet_failsafe() {
  self endon("death");
  wait(6);
  self.rocket_feet = 0;
}

facemelter_fire_pool(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 75;
  var_06 = 30;
  if(isDefined(param_04)) {
    wait(0.1);
    self.pooltrigger = spawn("trigger_rotatable_radius", param_00.origin, 0, var_05, var_06);
    self.pooltrigger thread run_fire_pool(param_00, param_01, param_02, param_03);
    self.pooltrigger thread fire_pool_timeout(param_01);
    wait(param_01);
    return;
  }

  var_07 = spawnfx(level._effect["fire_pool_wide"], param_00.origin);
  var_07 playSound("zombie_facemelter_fire_pool");
  wait(0.1);
  var_08 = spawn("trigger_rotatable_radius", param_00.origin, 0, var_05, var_06);
  var_08 thread run_fire_pool(param_00, param_01, param_02, param_03);
  var_08 thread fire_pool_timeout(param_01);
  var_07 setfxkilldefondelete();
  triggerfx(var_07);
  wait(param_01);
  var_07 delete();
}

run_fire_pool(param_00, param_01, param_02, param_03) {
  self endon("fire_pool_done");
  var_04 = param_01 * 10;
  for(;;) {
    self waittill("trigger", var_05);
    if(isDefined(var_05.rocket_feet)) {
      wait(0.1);
      continue;
    } else if(isplayer(var_05)) {
      if(param_02 == var_05 && !scripts\engine\utility::istrue(param_03) && !isDefined(var_05.burning)) {
        if(!scripts\engine\utility::istrue(var_05.inlaststand)) {
          var_05.burning = 1;
          var_05 thread dodamageandunsetburnstate(var_05, self);
        }
      }

      wait(0.1);
      continue;
    } else if(isalive(var_05)) {
      level thread scripts\cp\utility::damage_over_time(var_05, param_02, 5, var_05.health + 1000, undefined, "iw7_facemelterdummy_zm", 0, "burning");
    }

    wait(0.1);
  }
}

dodamageandunsetburnstate(param_00, param_01) {
  param_00 notify("doDamageAndUnsetBurnState");
  param_00 endon("doDamageAndUnsetBurnState");
  param_00 endon("disconnect");
  if(isalive(param_00)) {
    param_00 dodamage(int(param_00.maxhealth * 0.15), param_01.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_facemelterdummy_zm");
  }

  wait(1);
  param_00.burning = undefined;
}

fire_pool_timeout(param_00) {
  wait(param_00);
  self notify("fire_pool_done");
  self delete();
}

shredder_death_logic(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death()) {
    return;
  }

  self.shredder_death = 1;
  self.precacheleaderboards = 1;
  self clearpath();
  wait(0.1);
  var_04 = ["left_arm", "right_arm"];
  var_04 = scripts\engine\utility::array_randomize(var_04);
  if(!scripts\engine\utility::istrue(self.is_cop)) {
    foreach(var_06 in var_04) {
      self setscriptablepartstate(var_06, "disintegrate", 1);
      wait(0.25);
    }

    var_04 = ["right_leg", "left_leg"];
    var_04 = scripts\engine\utility::array_randomize(var_04);
    foreach(var_06 in var_04) {
      self setscriptablepartstate(var_06, "disintegrate", 1);
      wait(0.25);
    }

    self setscriptablepartstate("shredder_fx", "active", 1);
    wait(0.25);
    self setscriptablepartstate("head", "detached", 1);
  } else {
    foreach(var_06 in var_06) {
      self setscriptablepartstate(var_06, "disintegrate", 1);
      wait(0.1);
    }

    var_04 = ["right_leg", "left_leg"];
    var_04 = scripts\engine\utility::array_randomize(var_04);
    foreach(var_06 in var_04) {
      self setscriptablepartstate(var_06, "disintegrate", 1);
      wait(0.1);
    }

    self.full_gib = 1;
  }

  wait(0.1);
  self.nocorpse = 1;
  self.deathmethod = "shredder";
  self.shredder_death = 0;
  self dodamage(self.health + 1000, self.origin, param_00, undefined, "MOD_UNKNOWN", "iw7_shredderdummy_zm");
}

check_to_use_headshot_explosion(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = scripts\engine\utility::isbulletdamage(param_03) || param_03 == "MOD_EXPLOSIVE_BULLET" && param_05 != "none";
  if(!var_07) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(param_04, param_05, param_03, param_00)) {
    return;
  }

  param_00 scripts\cp\utility::notify_used_consumable("headshot_explosion");
  thread explode_head_with_fx(param_00, param_05, param_02, "bloody_death", undefined, param_06);
}

explode_head_with_fx(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death()) {
    return;
  }

  if(scripts\cp\utility::agentisfnfimmune() || self.agent_type == "alien_goon" || self.agent_type == "skeleton") {
    return;
  }

  self.head_is_exploding = 1;
  param_04 = self gettagorigin("J_Spine4");
  playsoundatpos(self.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect[param_03], param_04);
  foreach(var_07 in level.players) {
    if(distance(var_07.origin, param_04) <= 350) {
      var_07 thread showonscreenbloodeffects();
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(!param_05) {
    self setscriptablepartstate("head", "hide");
  }
}

showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::waittill_any_timeout_1(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

head_shard_init() {
  level._effect["head_exploder"] = loadfx("vfx\iw7\_requests\coop\zmb_head_exploder.vfx");
  level._effect["head_expander"] = loadfx("vfx\iw7\_requests\coop\zmb_head_expander.vfx");
  level._effect["head_blood_explosion"] = loadfx("vfx\iw7\_requests\coop\zmb_head_blood_explosion.vfx");
}

head_exploder(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  if(scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death()) {
    return;
  }

  self.head_is_exploding = 1;
  wait(randomfloatrange(0, 0.5));
  if(!scripts\engine\utility::istrue(self.is_cop)) {
    self setscriptablepartstate("eyes", "headcutter_eyes");
  }

  self.precacheleaderboards = 1;
  self clearpath();
  wait(1);
  self setscriptablepartstate("eyes", "eye_glow_off");
  wait(0.1);
  self setscriptablepartstate("headcutter_fx", "active");
  wait(0.1);
  self setscriptablepartstate("head", "hide", 1);
  wait(0.1);
  param_01 = self gettagorigin("J_Spine4");
  param_00 thread explode_head_shards(param_00, param_01, self, param_04);
  if(scripts\engine\utility::istrue(self.is_cop)) {
    self.full_gib = 1;
    self.nocorpse = 1;
  }

  self dodamage(self.health + 1000, self.origin, param_00, undefined, "MOD_UNKNOWN", "iw7_headcutterdummy_zm");
}

explode_head_shards(param_00, param_01, param_02, param_03) {
  var_04 = scripts\cp\utility::weaponhasattachment(param_03, "pap1");
  var_05 = getweaponbasename(param_03);
  var_06 = "iw7_headcutterdummy_zm";
  var_07 = 15000;
  switch (var_05) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
      if(var_04) {
        var_06 = "iw7_headcutter2_zm+hcpap1";
      } else {
        var_06 = "iw7_headcutter2_zm";
      }
      break;

    case "iw7_headcutter2_zm":
      if(var_04) {
        var_06 = "iw7_headcutter3_zm+hcpap1";
      } else {
        var_06 = "iw7_headcutterdummy_zm";
      }
      break;
  }

  var_08 = [];
  var_08 = level.spawned_enemies;
  var_09 = [param_02];
  var_0A = 128;
  if(var_04) {
    var_0A = 256;
  }

  var_0B = scripts\engine\utility::get_array_of_closest(param_01, var_08, var_09, undefined, var_0A, 0);
  foreach(var_0D in var_0B) {
    if(isDefined(var_0D.agent_type) && var_0D.agent_type == "zombie_grey" || var_0D.agent_type == "zombie_brute") {
      var_0E = 100;
    } else {
      var_0E = 100000;
    }

    var_0D dodamage(var_0E, param_01, param_00, param_00, "MOD_EXPLOSIVE", var_06);
  }
}

delayshardfire(param_00, param_01, param_02, param_03) {
  param_03 endon("disconnect");
  wait(param_00);
  var_04 = magicbullet("iw7_headcuttershards_mp", param_01, param_02, param_03);
}

weapon_watch_hint() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  var_00 = getweaponbasename(self getcurrentprimaryweapon());
  var_01 = self getcurrentweapon();
  var_02 = undefined;
  for(;;) {
    if(isDefined(var_00) && var_00 == "iw7_axe_zm" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE_AXE_HINT", 4);
      self.axe_hint_display = self.axe_hint_display + 1;
    } else if(isDefined(var_00) && var_00 == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE_FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display = self.forgefreeze_hint_display + 1;
    }

    updatecamoscripts(var_01, var_02);
    var_02 = var_01;
    self waittill("weapon_change");
    wait(0.5);
    var_00 = getweaponbasename(self getcurrentprimaryweapon());
    var_01 = self getcurrentweapon();
  }
}

updatecamoscripts(param_00, param_01) {
  if(isDefined(param_00)) {
    var_02 = getweaponcamoname(param_00);
  } else {
    var_02 = undefined;
  }

  if(isDefined(param_01)) {
    var_03 = getweaponcamoname(param_01);
  } else {
    var_03 = undefined;
  }

  if(!isDefined(var_02)) {
    var_02 = "none";
  }

  if(!isDefined(var_03)) {
    var_03 = "none";
  }

  clearcamoscripts(param_01, var_03);
  runcamoscripts(param_00, var_02);
}

runcamoscripts(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  switch (param_01) {
    case "camo32":
      self setscriptablepartstate("camo_32", "loop");
      break;

    case "camo34":
      self setscriptablepartstate("camo_34", "loop");
      break;

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

    case "camo31":
      thread mw2_camo_31();
      break;
  }
}

clearcamoscripts(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  switch (param_01) {
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

    case "camo31":
      self notify("mw2_camo_31");
      break;
  }
}

mw2_camo_31() {
  self endon("disconnect");
  self endon("death");
  self endon("mw2_camo_31");
  if(!isDefined(self.mw2camokillcount)) {
    self.mw2camokillcount = 0;
  }

  var_00 = int(self.mw2camokillcount / 5);
  self setscriptablepartstate("camo_31", var_00 + "_kills");
  for(;;) {
    self waittill("zombie_killed");
    self.mw2camokillcount = self.mw2camokillcount + 1;
    if(self.mw2camokillcount % 5 == 0) {
      var_00 = int(self.mw2camokillcount / 5);
      if(var_00 > 7) {
        var_00 = 0;
        self.mw2camokillcount = 0;
      }

      self setscriptablepartstate("camo_31", var_00 + "_kills");
    }
  }
}

blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");
  if(!isDefined(self.bloodcamokillcount)) {
    self.bloodcamokillcount = 0;
  }

  var_00 = 1;
  for(;;) {
    self waittill("zombie_killed");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;
    if(self.bloodcamokillcount / 5 == var_00) {
      var_01 = int(self.bloodcamokillcount / 5);
      if(var_01 > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", var_01 + "_kills");
      var_00++;
    }
  }
}

blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");
  var_00 = 1;
  for(;;) {
    self waittill("zombie_killed");
    self.katanacamokillcount = self.katanacamokillcount + 1;
    if(self.katanacamokillcount / 5 == var_00) {
      var_01 = int(self.katanacamokillcount / 5);
      if(var_01 > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", var_01 + "_kills");
      var_00++;
    }
  }
}

axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    self waittill("axe_melee_hit", var_00, var_01, var_02);
    var_03 = getweaponbasename(var_00);
    var_04 = scripts\cp\cp_weapon::get_weapon_level(var_03);
    var_05 = get_melee_weapon_fov(var_03, var_04);
    var_06 = get_melee_weapon_hit_distance(var_03, var_04);
    var_07 = get_melee_weapon_max_enemies(var_03, var_04);
    var_08 = checkenemiesinfov(var_05, var_06, var_07);
    thread setaxescriptablestate(self);
    foreach(var_0A in var_08) {
      if(var_0A == var_01) {
        continue;
      }

      var_0A thread axe_damage(var_0A, self, var_02, var_0A.origin, self.origin, var_00, 0.5);
    }
  }
}

setaxeidlescriptablestate(param_00) {
  param_00 setscriptablepartstate("axe - idle", "neutral");
  wait(0.5);
  param_00 setscriptablepartstate("axe - idle", "level 1");
}

setaxescriptablestate(param_00) {
  param_00 notify("setaxeblooddrip");
  param_00 endon("setaxeblooddrip");
  param_00 setscriptablepartstate("axe", "neutral");
  wait(0.5);
  param_00 setscriptablepartstate("axe", "blood on");
  wait(5);
  param_00 setscriptablepartstate("axe", "neutral");
}

get_melee_weapon_fov(param_00, param_01) {
  if(!isDefined(param_00) && !isDefined(param_01)) {
    return 45;
  }

  switch (param_01) {
    case 2:
      return 52;

    case 3:
      return 60;

    default:
      return 45;
  }
}

get_melee_weapon_hit_distance(param_00, param_01) {
  if(!isDefined(param_00) && !isDefined(param_01)) {
    return 125;
  }

  switch (param_01) {
    case 2:
      return 150;

    case 3:
      return 175;

    default:
      return 125;
  }
}

get_melee_weapon_max_enemies(param_00, param_01) {
  if(!isDefined(param_00) && !isDefined(param_01)) {
    return 1;
  }

  switch (param_01) {
    case 2:
      return 8;

    case 3:
      return 24;

    default:
      return 4;
  }
}

get_melee_weapon_melee_damage(param_00, param_01) {
  if(!isDefined(param_00) && !isDefined(param_01)) {
    return 1100;
  }

  switch (param_01) {
    case 2:
      return 1500;

    case 3:
      return 2000;

    default:
      return 1100;
  }
}

create_explosion_sphere(param_00) {
  var_01 = param_00 / 2;
  var_02 = vectornormalize(anglesToForward(self.angles));
  var_03 = var_02 * var_01;
  var_04 = self.origin + var_03;
  physicsexplosionsphere(var_04, var_01, 1, 2);
}

playredrepulsorfx() {
  var_00 = spawnfxforclient(level._effect["repulsor_view_red"], self gettagorigin("tag_eye"), self);
  triggerfx(var_00);
  var_00 thread scripts\cp\utility::delayentdelete(1);
  playrumbleonposition("slide_collision", self.origin);
  self earthquakeforplayer(0.5, 0.5, self.origin, 62.5);
}

checkenemiesinfov(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 6;
  }

  var_03 = cos(param_00);
  var_04 = [];
  var_05 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_06 = scripts\engine\utility::get_array_of_closest(self.origin, var_05, undefined, 24, param_01, 1);
  foreach(var_08 in var_06) {
    var_09 = anglesToForward(self.angles);
    var_0A = vectornormalize(var_09) * -25;
    var_0B = 0;
    var_0C = var_08.origin;
    var_0D = scripts\engine\utility::within_fov(self getEye() + var_0A, self.angles, var_0C + (0, 0, 30), var_03);
    if(var_0D) {
      if(isDefined(param_01)) {
        var_0E = distance2d(self.origin, var_0C);
        if(var_0E < param_01) {
          var_0B = 1;
        }
      } else {
        var_0B = 1;
      }
    }

    if(var_0B && var_04.size < param_02) {
      var_04[var_04.size] = var_08;
    }
  }

  return var_04;
}

axe_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 endon("death");
  if(param_00 scripts\cp\agents\gametype_zombie::is_non_standard_zombie()) {
    param_00.allowpain = 1;
  }

  param_00 dodamage(param_02, param_03, param_01, param_01, "MOD_MELEE", param_05);
  wait(param_06);
  if(scripts\engine\utility::istrue(param_00.allowpain)) {
    param_00.allowpain = 0;
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
      var_00 = self getcurrentweapon();
      var_01 = self getweaponammostock(var_00);
      var_02 = weaponclipsize(var_00);
      self setweaponammostock(var_00, var_01 + var_02);
    }
  }
}

arcane_attachment_watcher(param_00) {
  scripts\engine\utility::flag_wait("doors_initialized");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("death");
  while(!isDefined(param_00.suit)) {
    wait(0.1);
  }

  param_00 thread unsetstatewhenadswithsniper(param_00);
  for(;;) {
    var_01 = param_00 scripts\engine\utility::waittill_any_3("weapon_change", "weapon_switch_started", "ads_out");
    param_00 clear_arcane_effects(param_00);
    param_00 turn_off_zapper_fx();
    param_00 thread wait_for_weapon_switch_done(param_00);
  }
}

scriptable_notify_test() {
  scripts\engine\utility::flag_wait("doors_initialized");
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("scriptableNotification", var_00, var_01, var_02);
    if(!isDefined(var_00)) {
      continue;
    }

    wait(0.05);
  }
}

unsetstatewhenadswithsniper(param_00) {
  param_00 endon("disconnect");
  param_00 notifyonplayercommand("ads_in", "+speed_throw");
  param_00 notifyonplayercommand("ads_out", "-speed_throw");
  for(;;) {
    var_01 = param_00 scripts\engine\utility::waittill_any_return("ads_in", "ads_out");
    if(param_00 scripts\cp\utility::coop_getweaponclass(param_00 getcurrentweapon()) == "weapon_sniper") {
      if(var_01 == "ads_in") {
        param_00 clear_arcane_scriptable_effects(param_00);
        param_00.pause_arcane_logic = 1;
        continue;
      }

      param_00.pause_arcane_logic = undefined;
    }
  }
}

clear_arcane_scriptable_effects(param_00) {
  param_00 setscriptablepartstate("arcane", "neutral", 1);
}

clear_arcane_effects(param_00) {
  param_00 setclientomnvar("zm_ui_specialammo", 0);
  param_00.special_ammo_type = undefined;
  param_00 setscriptablepartstate("arcane", "neutral", 1);
  if(param_00 scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    param_00 scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }

  if(param_00 scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
    param_00 scripts\cp\utility::_unsetperk("specialty_armorpiercing");
  }

  if(param_00 scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
    param_00 scripts\cp\utility::_unsetperk("specialty_bulletdamage");
  }
}

wait_for_weapon_switch_done(param_00, param_01) {
  level endon("game_ended");
  param_00 notify("wait_for_weapon_switch_done");
  param_00 endon("wait_for_weapon_switch_done");
  param_00 endon("disconnect");
  param_00 endon("weapon_switch_started");
  while(param_00 isswitchingweapon()) {
    wait(0.05);
  }

  var_02 = param_00 getcurrentweapon();
  param_00 notify("weapon_switch_done", var_02);
  param_00 assign_ark_attachment_properties(param_00, undefined, var_02);
  param_00 handle_zapper_fx(param_00, var_02);
}

assign_ark_attachment_properties(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(param_00.pause_arcane_logic)) {
    return;
  }

  if(!isDefined(param_01)) {
    if(!isDefined(param_02)) {
      param_02 = self getcurrentweapon();
    }

    if(!issubstr(param_02, "ark")) {
      return;
    }

    var_03 = strtok(param_02, "+");
    foreach(var_05 in var_03) {
      if(issubstr(var_05, "ark")) {
        param_01 = var_05;
        break;
      }
    }
  }

  if(!isDefined(param_01)) {
    param_01 = "blank";
  }

  switch (param_01) {
    case "arkblue_sm":
    case "arkblue_akimbo":
    case "blue":
    case "arkblue":
      self setclientomnvar("zm_ui_specialammo", 1);
      self.special_ammo_type = "stun_ammo";
      self.special_ammo_weapon = param_02;
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
    case "pink":
    case "arkpink":
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

handle_zapper_fx(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = self getcurrentweapon();
  }

  var_02 = getweaponbasename(param_01);
  turn_off_zapper_fx();
  if(isDefined(var_02)) {
    switch (var_02) {
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

get_ark_attachment_type(param_00) {
  var_01 = strtok(param_00, "+");
  foreach(var_03 in var_01) {
    var_04 = getsubstr(var_03, 0, 3);
    if(var_04 == "ark") {
      switch (var_03) {
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

weapon_in_inventory(param_00) {
  var_01 = self getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(var_03 == param_00) {
      return 1;
    }
  }

  return 0;
}

watchglobstick(param_00, param_01) {
  self endon("death");
  thread remove_from_glob_array_on_death();
  self waittill("missile_stuck", var_02);
  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  self setscriptablepartstate("trail", "neutral");
  self setscriptablepartstate("explosion", "active");
  playsoundatpos(self.origin, "plasma_grenade_impact");
  radiusdamage(self.origin, 128, 10, 5, self.triggerportableradarping, "MOD_EXPLOSIVE", param_00);
  if(level.facemelter_globs.size > 5) {
    self delete();
    return;
  }

  var_03 = spawn("trigger_rotatable_radius", self.origin, 0, 60, 60);
  var_03.angles = self.angles;
  var_03.triggerportableradarping = self.triggerportableradarping;
  var_03.team = self.triggerportableradarping.team;
  var_03 thread watchplayerstouchingpool(param_00, param_01);
  var_03 thread scripts\cp\utility::delayentdelete(8);
  var_03 thread delayplaySound(0.1, "plasma_grenade_fire_glob");
  self.poolscriptablepart = "poolGround";
  self setscriptablepartstate("poolGround", "active");
  wait(8);
  self setscriptablepartstate(self.poolscriptablepart, "activeEnd", 0);
  self delete();
}

remove_from_glob_array_on_death() {
  self waittill("death");
  level.facemelter_globs = scripts\engine\utility::array_remove(level.facemelter_globs, self);
}

startdamageovertime(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  param_01 endon("disconnect");
  self.startedplasmastand = 1;
  self.startedplasmalinger = undefined;
  self.is_burning = 1;
  thread watchgrenadedotend();
  thread watchstartlingerdamage(param_00, param_01);
  if(isDefined(level.splash_grenade_victim_scriptable_state_func) && isalive(self) && isDefined(self.species) && self.species == "zombie") {
    self thread[[level.splash_grenade_victim_scriptable_state_func]](self);
  } else {}

  thread standingdotdamage(param_00, param_01, param_02, param_03, param_04);
}

play_fx_for_time(param_00, param_01, param_02) {
  var_03 = undefined;
  var_03 = spawnfx(scripts\engine\utility::getfx(param_01), param_00);
  if(isDefined(var_03)) {
    triggerfx(var_03);
  }

  var_03 thread scripts\cp\utility::delayentdelete(param_02);
  return var_03;
}

watchplayerstouchingpool(param_00, param_01) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    self waittill("trigger", var_02);
    if(scripts\cp\utility::isreallyalive(var_02) && !isDefined(var_02.startedplasmastand) && var_02.team != self.triggerportableradarping.team || var_02 == self.triggerportableradarping) {
      if(param_01) {
        if(var_02 == self.triggerportableradarping) {
          continue;
        }
      }

      var_02 notify("start_plasma_stand");
      var_02 thread startdamageovertime(param_00, self.triggerportableradarping, 33, 0.5, self);
      var_02 thread watchistouchingtrigger(self);
    }
  }
}

watchistouchingtrigger(param_00) {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!isDefined(param_00) || !self istouching(param_00)) {
      self notify("plasma_dot_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watchgrenadedotend() {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::waittill_any_3("plasma_dot_end");
  self.startedplasmastand = undefined;
  self.startedplasmalinger = undefined;
  self.globtouched = undefined;
  self.is_burning = undefined;
  stopFXOnTag(scripts\engine\utility::getfx("glob_plasma_trail_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_friendly"), self, "j_mainroot");
}

watchstartlingerdamage(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("plasma_dot_end");
  param_01 endon("disconnect");
  self waittill("start_plasma_linger");
  var_02 = 1;
  var_03 = 25;
  var_04 = 1;
  self.startedplasmastand = undefined;
  self.startedplasmalinger = 1;
  var_05 = spawnfxforclient(scripts\engine\utility::getfx("player_plasma_screen_linger"), self getEye(), self);
  triggerfx(var_05);
  var_05 thread scripts\cp\utility::delayentdelete(1);
  var_05 thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
  var_05 thread deletepentsondisconnect(self);
  thread damageplayerovertime(param_00, param_01, var_03, var_04, var_02, "start_plasma_stand", "plasma_dot_end");
}

deleteonlingerstart(param_00) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 waittill("plasma_dot_end");
  if(isDefined(self)) {
    self delete();
  }
}

delayplayfxontagforclients(param_00, param_01, param_02, param_03) {
  param_02 endon("death");
  wait(param_00);
  if(isDefined(param_02) && isDefined(self)) {
    playfxontagforclients(scripts\engine\utility::getfx(param_01), param_02, param_03, self);
  }
}

standingdotdamage(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  param_01 endon("disconnect");
  if(isDefined(param_04)) {
    param_04 endon("death");
  }

  var_05 = int(param_02 / 4);
  var_06 = param_03;
  childthread damageplayerovertime(param_00, param_01, var_05, var_06, undefined, "start_stage2_plasma");
  wait(1);
  self notify("start_stage2_plasma");
  var_05 = int(param_02 / 2);
  var_06 = param_03 / 2;
  childthread damageplayerovertime(param_00, param_01, var_05, var_06, undefined, "start_stage3_plasma");
  wait(0.5);
  self notify("start_stage3_plasma");
  var_05 = param_02;
  var_06 = param_03 / 4;
  childthread damageplayerovertime(param_00, param_01, var_05, var_06);
}

damageplayerovertime(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self endon("disconnect");
  if(isDefined(param_05)) {
    self endon(param_05);
  }

  param_01 endon("disconnect");
  if(!isDefined(param_04)) {
    for(;;) {
      self dodamage(param_02, self.origin, param_01, undefined, "MOD_EXPLOSIVE", param_00);
      self.flame_damage_time = gettime() + 500;
      wait(param_03);
    }

    return;
  }

  if(param_03 > param_04) {
    return;
  }

  var_07 = param_02;
  if(self.health <= var_07) {
    self dodamage(param_02, self.origin, param_01, undefined, "MOD_EXPLOSIVE", param_00);
    self.flame_damage_time = gettime() + 500;
  }

  while(param_04 > 0) {
    if(self.health > 15 && self.health - param_02 < 15) {
      param_02 = param_02 - 15 - self.health - param_02;
    }

    if(self.health > var_07 && self.health <= 15) {
      param_02 = 1;
    }

    if(param_02 > 0) {
      self dodamage(param_02, self.origin, param_01, undefined, "MOD_EXPLOSIVE", param_00);
      self.flame_damage_time = gettime() + 500;
    }

    param_04 = param_04 - param_03;
    wait(param_03);
  }

  if(isDefined(param_06)) {
    self notify(param_06);
  }
}

deletepentsondisconnect(param_00) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 waittill("start_plasma_stand");
  if(isDefined(self)) {
    self delete();
  }
}

delayplaySound(param_00, param_01) {
  self endon("death");
  wait(param_00);
  self playSound(param_01);
}