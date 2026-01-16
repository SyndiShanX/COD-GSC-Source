/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_seeder.gsc
**************************************************/

seeder_level_init() {
  if(!isDefined(level.alien_funcs))
    level.agent_funcs = [];

  level.alien_funcs["seeder"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;
  level.alien_funcs["seeder"]["combat"] = ::seeder_combat;
  level.alien_funcs["seeder"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;

  if(!isDefined(level.seeder_active_turrets))
    level.seeder_active_turrets = [];

  level.seeder_active_pet_turrets = 0;
}

seeder_init() {
  self.gas_cloud_available = 1;
  self.num_active_turrets = 0;
  self.skipstartmove = 1;
  self.total_turrets_spawned = 0;
}

load_seeder_fx() {
  level._effect["spit_AOE"] = loadfx("vfx/gameplay/alien/vfx_alien_spitter_gas_cloud");
  level._effect["spit_AOE_small"] = loadfx("vfx/gameplay/alien/vfx_alien_spitter_gas_cloud_64");
  level._effect["spore_darts_fire"] = loadfx("vfx/gameplay/alien/vfx_alien_spore_darts_01");
  level._effect["spore_death_fx"] = loadfx("vfx/gameplay/alien/vfx_alien_seeder_spore_death");
  level._effect["spore_birth_fx"] = loadfx("vfx/gameplay/alien/vfx_alien_seeder_spore_birth");
  level._effect["alien_seeder_preexplode"] = loadfx("vfx/gameplay/alien/vfx_alien_minion_preexplosion");
  level._effect["alien_seeder_explode"] = loadfx("vfx/gameplay/alien/vfx_alien_minion_explode");
}

seeder_death(var_0) {
  if(!var_0)
    level thread seeder_explode_on_death(self);

  maps\mp\agents\alien\_alien_spitter::release_spit_node();

  if(isDefined(self.pet) && level.seeder_active_pet_turrets > 0) {
    foreach(var_2 in level.seeder_active_turrets) {
      if(isDefined(var_2.parent) && var_2.parent == self && isDefined(var_2.pet))
        var_2 notify("death");
    }
  }
}

seeder_combat(var_0) {
  self endon("bad_path");
  self endon("death");
  self endon("alien_main_loop_restart");
  var_1 = undefined;

  for(;;) {
    var_2 = maps\mp\agents\alien\_alien_spitter::find_spitter_attack_node(self.enemy);
    var_3 = 0;

    if(isDefined(var_2)) {
      maps\mp\agents\alien\_alien_spitter::move_to_spitter_attack_node(var_2);
      var_4 = get_seeder_val("min_desired");
      var_5 = get_seeder_val("max_desired");
      var_6 = level.seeder_active_turrets.size - level.seeder_active_pet_turrets;

      if(var_6 < var_4)
        var_3 = 1;
      else if(var_6 >= var_4 && var_6 < var_5) {
        if(common_scripts\utility::cointoss())
          var_3 = 1;
      }

      if(self.total_turrets_spawned >= get_seeder_val("ammo"))
        var_3 = 0;

      if(var_3)
        seeder_attack(self.enemy);
      else
        maps\mp\agents\alien\_alien_spitter::spitter_attack(self.enemy);
    } else
      wait 0.05;

    var_1 = var_2;
  }
}

seeder_attack(var_0) {
  self endon("spitter_node_move_requested");

  if(!isDefined(self.current_spit_node)) {
    maps\mp\agents\alien\_alien_spitter::choose_spit_type("close_range");
    maps\mp\agents\alien\_alien_spitter::spit_projectile(var_0);
    self.valid_moving_spit_attack_time = gettime() + randomfloatrange(1.5, 2.5) * 1000.0;
    return;
  }

  if(!maps\mp\agents\alien\_alien_spitter::is_escape_sequence_active())
    wait(randomfloatrange(1.5, 2.5) * 0.5);

  for(;;) {
    var_1 = undefined;
    var_2 = 0.0;
    var_3 = get_seeder_val("max_per_alien");

    while(!isDefined(var_1)) {
      var_2 = var_2 + 0.2;

      if(var_2 >= 1.0) {
        return;
      }
      wait 0.2;

      if(level.seeder_active_turrets.size + 1 > 12 || isDefined(self.num_active_turrets) && self.num_active_turrets + 1 > var_3) {
        continue;
      }
      if(self.total_turrets_spawned >= get_seeder_val("ammo")) {
        return;
      }
      var_1 = get_best_turret_location(var_0);

      if(isDefined(var_1)) {
        break;
      }
    }

    self.spit_type = "long_range";
    self.spit_target_location = var_1;
    self.melee_type = "seeder_spit";
    maps\mp\agents\alien\_alien_think::alien_melee(var_0);
    wait(randomfloatrange(1.5, 2.5));
  }
}

match_node_orientation(var_0) {
  var_1 = anglestoup(var_0.angles);
  var_2 = anglesToForward(self.angles);
  var_3 = vectorcross(var_1, var_2);
  var_2 = vectorcross(var_3, var_1);
  var_4 = (0, 0, 0) - var_3;
  var_5 = axistoangles(var_2, var_4, var_1);
  self scragentsetorientmode("face angle abs", var_5);

  for(var_6 = 0; var_6 < 10; var_6++) {
    if(abs(angleclamp180(self.angles[0] - var_5[0])) < 2 && abs(angleclamp180(self.angles[2] - var_5[2])) < 2) {
      break;
    }

    wait 0.05;
  }
}

seeder_spit_attack(var_0) {
  self endon("melee_pain_interrupt");
  var_1 = var_0;
  var_1 endon("death");
  var_2 = self.spit_target_location;

  if(isDefined(self.current_spit_node))
    match_node_orientation(self.current_spit_node);

  turntowardsorigin(var_2);
  self.looktarget = var_1;
  maps\mp\alien\_utility::set_alien_emissive(0.2, 1.0);

  if(isDefined(self.current_spit_node) && !maps\mp\alien\_utility::is_normal_upright(anglestoup(self.current_spit_node.angles))) {
    var_3 = anglestoup(self.current_spit_node.angles);
    var_4 = anglesToForward(self.angles);
    var_5 = vectorcross(var_3, var_4);
    var_4 = vectorcross(var_5, var_3);
    var_6 = (0, 0, 0) - var_5;
    var_7 = axistoangles(var_4, var_6, var_3);
  } else {
    var_4 = vectornormalize(var_2 - self.origin);

    if(isDefined(self.current_spit_node))
      var_3 = anglestoup(self.current_spit_node.angles);
    else
      var_3 = anglestoup(self.angles);

    var_5 = vectorcross(var_3, var_4);
    var_4 = vectorcross(var_5, var_3);
    var_6 = (0, 0, 0) - var_5;
    var_7 = axistoangles(var_4, var_6, var_3);
  }

  self scragentsetorientmode("face angle abs", var_7);
  self.spit_type = "long_range";

  if(self.oriented)
    self scragentsetanimmode("anim angle delta");
  else
    self scragentsetanimmode("anim deltas");

  if(common_scripts\utility::cointoss())
    maps\mp\agents\_scriptedagents::playanimuntilnotetrack("close_spit_attack", "spit_attack", "end", ::handleattacknotetracks);
  else
    maps\mp\agents\_scriptedagents::playanimuntilnotetrack("turret_spit_attack", "spit_attack", "end", ::handleattacknotetracks);

  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
  self.looktarget = undefined;
  self.spit_type = undefined;
}

handleattacknotetracks(var_0, var_1, var_2, var_3) {
  if(var_0 == "spit")
    return fire_seeder_projectile();
}

fire_seeder_projectile() {
  if(!isDefined(self.spit_target_location)) {
    return;
  }
  var_0 = self.spit_target_location;
  var_1 = self gettagorigin("TAG_BREATH");
  var_2 = magicbullet("seeder_spit_mp", var_1, var_0, self);
  var_2.parent = self;

  if(isDefined(var_2))
    var_2 thread seeder_projectile_impact_monitor(self);
}

seeder_projectile_impact_monitor(var_0) {
  self waittill("explode", var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.spit_target_location))
    var_1 = self.spit_target_location;

  if(isalive(var_0))
    thread seeder_spawn_turret(var_0, var_1, var_0.pet, 0);
}

get_best_turret_location(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.origin))
    return undefined;

  var_1 = get_best_seeder_node(var_0.origin, 0, 0, 1, self gettagorigin("TAG_BREATH"));

  if(!isDefined(var_1))
    return undefined;

  if(!turret_capsule_trace_passed(var_1)) {
    var_1.bad_turret_spot = 1;
    return undefined;
  }

  self.spit_target_node = var_1;
  self.spit_target_location = var_1.origin;

  if(!isDefined(var_1) || !isDefined(var_1.origin))
    return undefined;

  return var_1.origin;
}

get_best_seeder_node(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 64;
  var_6 = 512;
  var_7 = 512;

  if(isDefined(var_1) && var_1) {
    var_5 = 0;
    var_6 = 96;
    var_7 = 96;
  }

  var_8 = getnodesinradius(var_0, var_6, var_5, var_7, "jump attack");
  var_9 = getnodesinradius(var_0, var_6, var_5, var_7, "path");
  var_8 = common_scripts\utility::array_combine(var_8, var_9);
  var_10 = [];

  foreach(var_12 in var_8) {
    if(!isDefined(var_12) || isDefined(var_12.claimed) && var_12.claimed == 1) {
      continue;
    }
    if(var_10.size > 1 && var_12.type == "Path" && randomint(100) < 90) {
      continue;
    }
    if(isDefined(var_2) && var_2) {
      var_13 = anglestoup(var_12.angles);
      var_14 = (0, 0, 1);

      if(vectordot(var_13, var_14) < 0.3)
        continue;
    }

    if(isDefined(var_3) && var_3) {
      var_15 = bulletTrace(var_4, var_12.origin, 1);

      if(!isDefined(var_15) || distancesquared(var_15["position"], var_12.origin) > 64)
        continue;
    }

    var_10[var_10.size] = var_12;
  }

  if(var_10.size == 0)
    return undefined;

  return common_scripts\utility::random(var_10);
}

turntowardsorigin(var_0) {
  var_1 = var_0 - self.origin;
  return maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_1);
}

seeder_explode_on_death(var_0) {
  var_1 = var_0.origin;
  common_scripts\utility::waitframe();
  playFX(level._effect["alien_seeder_explode"], var_1 + (0, 0, 32));
  playsoundatpos(var_1, "alien_minion_explode");
  radiusdamage(var_1, 150, level.alien_types["minion"].attributes["explode_max_damage"], level.alien_types["minion"].attributes["explode_min_damage"], var_0, "MOD_EXPLOSIVE", "alien_minion_explosion");
}

seeder_spawn_turret(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.spit_target_node))
    var_4 = var_0.spit_target_node;
  else
    var_4 = get_best_seeder_node(var_1, 1, var_3);

  if(isDefined(var_2))
    var_1 = common_scripts\utility::drop_to_ground(var_1, 5, -1000);

  if(turret_spawn_failed(var_0, var_1, var_2, var_4)) {
    return;
  }
  if(isDefined(var_2) && isDefined(self.force_use_attacknode) && isDefined(var_4))
    var_1 = var_4.origin;

  var_5 = spawn("script_model", var_1);
  var_5 setModel("alien_spore");
  var_5 solid();
  var_5.parent = var_0;
  var_5.team = var_0.team;
  var_5.origin = var_1;
  var_5.alien_type = "seeder_spore";
  var_5 thermaldrawenable();

  if(isDefined(var_4)) {
    var_5.angles = var_4.angles;
    var_5.origin = var_4.origin;
    var_5.claimed_node = var_4;
    var_5.claimed_node.claimed = 1;
  } else
    var_5.angles = (0, 0, 0);

  if(isDefined(var_2) && var_2) {
    var_5.pet = 1;
    maps\mp\alien\_outline_proto::enable_outline(var_5, 3, 1);
  }

  level.seeder_active_turrets = common_scripts\utility::array_add(level.seeder_active_turrets, var_5);

  if(isDefined(var_5.pet))
    level.seeder_active_pet_turrets = level.seeder_active_pet_turrets + 1;

  if(isDefined(var_0.alien_type)) {
    if(!isDefined(var_0.total_turrets_spawned))
      var_0.total_turrets_spawned = 0;

    var_0.total_turrets_spawned = var_0.total_turrets_spawned + 1;

    if(!isDefined(var_0.num_active_turrets))
      var_0.num_active_turrets = 0;

    var_0.num_active_turrets = var_0.num_active_turrets + 1;
  }

  var_5 thread seeder_turret_anim_state_machine();
  var_5 thread seeder_turret_face_target();
  var_5 thread seeder_turret_spit_attack();
  var_5 thread seeder_turret_timeout();
  var_5 thread seeder_turret_cleanup();
  var_5 notify("play_anim_spawn");
  wait 0.05;

  if(!isDefined(var_5)) {
    return;
  }
  var_5.coll_model = spawn("script_model", var_1);
  var_5.coll_model setModel("alien_spore_hitbox");
  var_5.coll_model.origin = var_5 gettagorigin("J_Spore_hitbox");
  var_5.coll_model.angles = var_5.angles;
  var_5.coll_model.parent = var_5;
  var_5.coll_model.team = var_5.team;
  var_5.coll_model linkto(var_5, "J_Spore_hitbox");
  var_5.coll_model setCanDamage(1);
  var_5.coll_model setCanRadiusDamage(1);
  var_5.coll_model.alien_type = "seeder_spore";
  var_5.coll_model thread seeder_turret_damage_watcher();
  wait 0.05;

  if(isDefined(var_5))
    playsoundatpos(var_5.origin, "spore_spawn");
}

turret_spawn_failed(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2) && level.seeder_active_turrets.size > 12)
    return 1;

  var_4 = get_seeder_val("max_per_alien");

  if(!isDefined(var_2) && !isDefined(var_0.num_active_turrets) && (isDefined(var_0.num_active_turrets) && var_0.num_active_turrets > var_4))
    return 1;

  if(!isDefined(self))
    return 1;

  var_5 = maps\mp\alien\_utility::get_closest_living_player();

  if(distancesquared(var_5.origin, var_1) > 1440000)
    return 1;

  if(!check_is_turret_pos_clear(var_1))
    return 1;

  if(!isDefined(var_2) && !isDefined(var_3))
    return 1;

  if(isDefined(var_2)) {
    if(isplayer(var_0) && !capsuletracepassed(var_1 + (0, 0, 5), 20, 100, undefined, 1, 1)) {
      if(isDefined(var_3) && var_0 turret_capsule_trace_passed(var_3))
        self.force_use_attacknode = 1;
      else
        return 1;
    }

    if(level.seeder_active_turrets.size >= 12) {
      var_6 = common_scripts\utility::random(level.seeder_active_turrets);
      var_6 notify("death");
    }

    if(level.seeder_active_pet_turrets >= 5) {
      for(var_7 = 0; !isDefined(level.seeder_active_turrets[var_7].pet) && var_7 < 12; var_7 = var_7 + 1) {}

      level.seeder_active_turrets[var_7] notify("death");
    }
  } else if(!var_0 turret_capsule_trace_passed(var_3))
    return 1;

  return 0;
}

turret_capsule_trace_passed(var_0) {
  var_1 = anglestoup(var_0.angles);
  var_2 = var_0.origin + var_1 * 50;
  var_3 = var_0.origin + var_1 * 100;
  var_4 = self aiphysicstracepassed(var_2, var_3, 10, 20, 0);

  if(!var_4)
    return 0;

  return 1;
}

seeder_turret_anim_state_machine() {
  self.idle = "alien_seeder_spore_idle_a_dlc";
  var_0 = undefined;
  self.current_anim = "none";

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("play_anim_spawn", "play_anim_idle", "play_anim_attack", "play_anim_attack_up", "play_anim_pain", "play_anim_death");

    if(!isDefined(var_0)) {
      continue;
    }
    switch (var_0) {
      case "play_anim_spawn":
        self.current_anim = var_0;
        thread seeder_play_interruptible_anim_and_wait("alien_seeder_spore_growth_dlc", 2.86, 1);
        var_1 = self gettagorigin("TAG_origin");
        var_2 = anglesToForward(self.angles);
        var_3 = anglestoup(self.angles);
        playFX(level._effect["spore_birth_fx"], var_1, var_2, var_3);
        break;
      case "play_anim_idle":
        if(self.current_anim == "none") {
          self.current_anim = var_0;
          thread seeder_play_interruptible_anim_and_wait(self.idle, 2.86, 0, 1);
        } else {}

        break;
      case "play_anim_attack_up":
      case "play_anim_attack":
        self playSound("scn_spore_attack");

        if(self.current_anim == "none" || self.current_anim == "play_anim_idle" || self.current_anim == "play_anim_pain") {
          self.current_anim = var_0;

          if(var_0 == "play_anim_attack_up")
            thread seeder_play_interruptible_anim_and_wait("alien_seeder_spore_attack_up_dlc", 2.0, 1);
          else
            thread seeder_play_interruptible_anim_and_wait("alien_seeder_spore_attack_dlc", 2.63, 1);
        } else {}

        break;
      case "play_anim_pain":
        if(self.current_anim == "none" || self.current_anim == "play_anim_idle" || self.current_anim == "play_anim_pain") {
          self.current_anim = var_0;
          thread seeder_play_interruptible_anim_and_wait("alien_seeder_spore_pain_dlc", 0.73, 0);
        } else {}

        break;
      case "play_anim_death":
        self notify("seeder_stop_anims");
        wait 0.1;
        var_1 = self gettagorigin("TAG_origin");
        var_2 = anglesToForward(self.angles);
        var_3 = anglestoup(self.angles);
        playFX(level._effect["spore_death_fx"], var_1, var_2, var_3);
        self notify("do_after_death_cleanup");
        return;
      default:
        break;
    }
  }
}

seeder_play_interruptible_anim_and_wait(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("seeder_stop_anims");
  self scriptmodelclearanim();

  if(var_2)
    self scriptmodelplayanimdeltamotion(var_0);
  else
    self scriptmodelplayanim(var_0);

  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_3) || var_3 == 0) {
    self.current_anim = "none";
    self notify("play_anim_idle");
    self.can_rotate = 1;
  }
}

seeder_turret_damage_watcher() {
  self.parent endon("death");
  self setCanDamage(1);
  self.spore_maxhealth = get_seeder_val("health");
  self.spore_health = self.spore_maxhealth;
  self.health = 10000;
  thread seeder_turret_death_watcher();

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    maps\mp\alien\_chaos::process_chaos_event("refill_combo_meter");
    var_10 = var_1;
    var_11 = "none";
    var_12 = 0;
    var_0 = onaliensporedamaged(var_10, var_1, var_0, var_8, var_4, var_9, var_3, var_2, var_11, var_12);

    if(isDefined(var_9) && weaponclass(var_9) == "spread")
      var_0 = var_0 * 4.0;

    self.spore_health = self.spore_health - var_0;

    if(self.spore_health <= 0) {
      if(isDefined(var_1) && isDefined(var_1.owner) && isplayer(var_1.owner))
        var_1 = var_1.owner;

      if(maps\mp\alien\_utility::is_chaos_mode())
        maps\mp\alien\_chaos::update_alien_killed_event(maps\mp\alien\_utility::get_alien_type(), self.origin, var_1);

      if(isDefined(var_1) && isplayer(var_1)) {
        var_13 = 25;
        maps\mp\alien\_gamescore::givekillreward(var_1, var_13, undefined, var_11);
        maps\mp\alien\_achievement::update_alien_kill_achievements(var_10, var_1, var_0, var_4, var_9, var_2, var_11);
      }

      return;
    }

    self.parent notify("play_anim_pain");
  }
}

seeder_turret_death_watcher() {
  self endon("death");
  self.parent endon("death");
  wait 0.1;

  for(;;) {
    if(!isDefined(self) || !isDefined(self.parent) || !isDefined(self.spore_health)) {
      return;
    }
    if(self.spore_health <= 0) {
      self.parent notify("death");
      return;
    }

    wait 0.2;
  }
}

onaliensporedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_5) && (var_5 == "alienspit_mp" || var_5 == "alienspit_gas_mp"))
    var_2 = int(var_2 * 5);

  if(isDefined(var_1) && isDefined(self.parent.pet) && isDefined(var_1.team) && self.parent.team == var_1.team)
    return 0;

  var_2 = maps\mp\alien\_damage::set_alien_damage_by_weapon_type(var_4, var_5, var_2, var_1);

  if(isplayer(var_1) && !maps\mp\alien\_utility::is_trap(var_0)) {
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_perks(var_1, var_2, var_4, var_5);
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_weapon_type(var_1, var_2, var_4, var_5, var_8);
  }

  if(var_2 <= 0)
    return 0;

  if(isDefined(var_1) && var_1 != self && var_2 > 0) {
    if(isDefined(level.attack_heli) && var_1 == level.attack_heli)
      var_2 = int(var_2 * 0.6);
  }

  var_2 = maps\mp\alien\_damage::scale_alien_damage_by_prestige(var_1, var_2);

  if(isDefined(var_1) && isDefined(var_5))
    level thread maps\mp\alien\_challenge_function::update_alien_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);

  var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
  return var_2;
}

seeder_turret_spit_attack() {
  self endon("death");
  var_0 = turret_get_new_target();
  wait 5.86;

  if(isDefined(self.pet))
    var_1 = "spore_pet_beam_mp";
  else
    var_1 = "spore_beam_mp";

  for(;;) {
    if(common_scripts\utility::cointoss() || !isDefined(var_0))
      var_0 = turret_get_new_target();

    if(!isDefined(var_0)) {
      wait 2.0;
      continue;
    }

    self.can_rotate = 0;

    if(self.is_rotating) {
      wait 0.5;
      continue;
    }

    if((isplayer(var_0) || issentient(var_0)) && !var_0 maps\mp\_utility::isusingremote())
      var_2 = var_0 getEye() + (0, 0, -15);
    else if(isDefined(var_0.alien_type) && var_0.alien_type == "seeder_spore")
      var_2 = var_0 gettagorigin("J_Spore_46");
    else
      var_2 = var_0.origin + (0, 0, 32);

    var_3 = self gettagorigin("J_Spore_46");
    var_4 = "play_anim_attack";

    if(target_is_above_turret(var_2))
      var_4 = "play_anim_attack_up";

    self notify(var_4);
    wait 0.84;
    var_5 = 3;

    while(var_5 > 0) {
      if(!isDefined(self) || !isDefined(self.coll_model) || !isDefined(var_0) || isDefined(self.current_anim) && self.current_anim == "play_anim_death" || isDefined(self.coll_model.spore_health) && self.coll_model.spore_health <= 0) {
        if(isDefined(self) && isDefined(self.fxent))
          self.fxent delete();

        return;
      }

      if((isplayer(var_0) || issentient(var_0)) && !var_0 maps\mp\_utility::isusingremote())
        var_2 = var_0 getEye() + (0, 0, -15);
      else if(isDefined(var_0.alien_type) && var_0.alien_type == "seeder_spore")
        var_2 = var_0 gettagorigin("J_Spore_46");
      else
        var_2 = var_0.origin + (0, 0, 32);

      var_6 = var_2 - self gettagorigin("J_Spore_46");
      var_6 = vectortoangles(var_6);

      if(!isDefined(self.fxent))
        self.fxent = spawnfx(level._effect["spore_darts_fire"], self gettagorigin("J_Spore_46"), anglesToForward(var_6), anglestoup(var_6));
      else {
        self.fxent.origin = self gettagorigin("J_Spore_46");
        self.fxent.angles = var_6;
      }

      triggerfx(self.fxent);
      common_scripts\utility::noself_delaycall(0.2, ::magicbullet, var_1, self gettagorigin("J_Spore_46"), var_2, self.parent);
      var_5 = var_5 - 1;
      wait 0.35;

      if(isDefined(self) && isDefined(self.fxent))
        self.fxent delete();
    }

    self.can_rotate = 1;

    if(isDefined(self.pet)) {
      wait(randomfloatrange(2.0, 5.0));
      continue;
    }

    wait(randomfloatrange(2.5, 6.7));
  }
}

target_is_above_turret(var_0) {
  var_1 = self gettagorigin("J_Spore_46");
  var_2 = vectornormalize(anglestoup(self.angles));
  var_3 = vectornormalize(var_0 - var_1);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0.32)
    return 1;

  return 0;
}

rotatedartfx() {
  self endon("death");
  self rotateyaw(-20, 1, 0.2, 0.1);
  wait 1;
  self rotateyaw(40, 1, 0.2, 0.1);
  wait 1;
  self rotateyaw(-20, 1, 0.2, 0.1);
}

seeder_turret_cleanup() {
  self waittill("death");
  level.seeder_active_turrets = common_scripts\utility::array_remove(level.seeder_active_turrets, self);

  if(isDefined(self.pet))
    level.seeder_active_pet_turrets = level.seeder_active_pet_turrets - 1;

  if(isDefined(self.parent) && !isplayer(self.parent) && isDefined(self.parent.num_active_turrets))
    self.parent.num_active_turrets = self.parent.num_active_turrets - 1;

  if(isDefined(self.coll_model))
    self.coll_model delete();

  if(isDefined(self.fxent))
    self.fxent delete();

  self notify("play_anim_death");
  self waittill("do_after_death_cleanup");
  wait 0.4;

  if(isDefined(self.claimed_node))
    self.claimed_node.claimed = 0;

  self delete();
}

seeder_turret_face_target() {
  self endon("death");
  self.can_rotate = 0;
  self.is_rotating = 0;

  if(isDefined(self.pet))
    var_0 = 0.15;
  else
    var_0 = 0.45;

  var_1 = 1;
  wait 3.06;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self.enemy)) {
      wait 1.0;
      continue;
    }

    var_2 = self.enemy.origin - self.origin;
    var_3 = vectornormalize(projectvectortoplane(var_2, vectornormalize(anglestoup(self.angles))));
    var_4 = anglesToForward(self.angles);
    var_5 = vectordot(var_3, var_4);

    if(var_5 < 1) {
      var_6 = acos(var_5);
      var_7 = vectordot(vectorcross(var_3, var_4), vectornormalize(anglestoup(self.angles)));

      if(var_7 > 0)
        var_6 = var_6 * -1;

      var_8 = var_0 / 0.05;
      var_9 = var_6 / var_8;

      if(self.can_rotate && self.current_anim == "play_anim_idle") {
        for(self.is_rotating = 1; var_8; var_8 = var_8 - 1) {
          if(var_1 > 0) {
            self dontinterpolate();
            var_1 = var_1 - 1;
          }

          self.angles = combineangles(self.angles, (0, var_9, 0));
          wait 0.05;
        }
      }
    }

    wait(var_0);
    self.is_rotating = 0;
    wait 0.2;
    wait 0.2;
  }
}

projectvectortoplane(var_0, var_1) {
  var_2 = vectordot(var_0, var_1);
  var_3 = var_0 - var_1 * var_2;
  return var_3;
}

turret_get_new_target() {
  self endon("death");

  if(!isDefined(self.pet)) {
    if(isDefined(self.parent.favoriteenemy)) {
      self.enemy = self.parent.favoriteenemy;
      return self.parent.favoriteenemy;
    }

    if(isDefined(self.favoriteenemy)) {
      self.enemy = self.favoriteenemy;
      return self.favoriteenemy;
    }

    var_0 = maps\mp\alien\_utility::get_closest_living_player();
    self.enemy = var_0;
    return var_0;
  } else {
    var_1 = maps\mp\alien\_spawnlogic::get_alive_agents();
    var_2 = 4;

    while(var_1.size > 0 && var_2 > 0) {
      var_3 = common_scripts\utility::random(var_1);

      if(isDefined(var_3) && !isDefined(var_3.pet)) {
        if(isagent(var_3) && isalive(var_3) && bullettracepassed(self gettagorigin("J_Spore_hitbox"), var_3 gettagorigin("TAG_EYE"), 0, self)) {
          self.enemy = var_3;
          return var_3;
        } else if(isDefined(var_3.alien_type) && var_3.alien_type == "seeder_spore" && bullettracepassed(self gettagorigin("J_Spore_hitbox"), var_3 gettagorigin("J_Spore_hitbox"), 0, self)) {
          self.enemy = var_3;
          return var_3;
        }
      }

      var_2 = var_2 - 1;
      wait 0.1;
    }
  }
}

seeder_turret_timeout() {
  self endon("death");
  var_0 = 60000;

  if(isDefined(self.pet))
    var_0 = 60000;

  var_1 = gettime();

  for(;;) {
    if(gettime() - var_1 > var_0)
      self notify("death");

    wait 0.2;
  }
}

check_is_turret_pos_clear(var_0) {
  for(var_1 = 0; var_1 < level.seeder_active_turrets.size; var_1++) {
    if(var_1 >= 12)
      return 0;

    if(isDefined(level.seeder_active_turrets[var_1]) && distancesquared(var_0, level.seeder_active_turrets[var_1].origin) < 1024)
      return 0;
  }

  return 1;
}

get_seeder_val(var_0) {
  if(level.players.size == 1) {
    switch (var_0) {
      case "health":
        return 275;
      case "max_per_alien":
        return 2;
      case "min_desired":
        return 1;
      case "max_desired":
        return 3;
      case "ammo":
        return 3;
    }
  } else if(level.players.size == 2) {
    switch (var_0) {
      case "health":
        return 350;
      case "max_per_alien":
        return 3;
      case "min_desired":
        return 2;
      case "max_desired":
        return 3;
      case "ammo":
        return 5;
    }
  } else if(level.players.size == 3) {
    switch (var_0) {
      case "health":
        return 500;
      case "max_per_alien":
        return 4;
      case "min_desired":
        return 2;
      case "max_desired":
        return 4;
      case "ammo":
        return 5;
    }
  } else if(level.players.size == 4) {
    switch (var_0) {
      case "health":
        return 500;
      case "max_per_alien":
        return 4;
      case "min_desired":
        return 2;
      case "max_desired":
        return 4;
      case "ammo":
        return 7;
    }
  }

  return 1;
}