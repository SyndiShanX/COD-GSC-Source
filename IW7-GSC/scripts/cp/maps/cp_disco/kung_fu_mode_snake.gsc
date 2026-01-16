/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_snake.gsc
***********************************************************/

snake_kung_fu_init() {
  level._effect["skeleton_summon_portal"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_spawn_portal.vfx");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_snake", scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_summon_pet_snake", scripts\cp\maps\cp_disco\kung_fu_mode::blank, scripts\cp\maps\cp_disco\kung_fu_mode::blank, ::summon_skeleton_pet, undefined, "snake_chi_power", undefined);
}

summon_skeleton_pet() {
  self endon("watch_for_kung_fu_timeout");
  self endon("disconnect");
  self endon("last_stand");
  wait(0.1);
  if(scripts\engine\utility::istrue(self.snake_super)) {
    return;
  }

  scripts\cp\powers\coop_powers::power_disablepower();
  var_0 = 250;
  if(self.chi_meter_amount - var_0 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  self playlocalsound("chi_snake_skeleton_summon");
  wait(1);
  if(isDefined(self.pet_skeleton)) {
    self.pet_skeleton notify("owner_spawned_new_guy");
    self.pet_skeleton dodamage(self.pet_skeleton.health + 100, self.pet_skeleton.origin);
    wait(0.1);
    self.pet_skeleton = undefined;
  }

  self.pet_skeleton = skeleton_spawner();
  if(isDefined(self.pet_skeleton)) {
    scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
  } else {
    scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  }

  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("snake_chi_power", 1);
}

skeleton_spawner() {
  var_0 = determine_skeleton_spawn_point(self.origin);
  var_1 = spawn_skeleton_solo(var_0);
  if(isDefined(var_1)) {
    var_1 thread skeleton_arrival_cowbell(var_0);
    var_1 thread set_skeleton_attributes(self);
  }

  return var_1;
}

spawn_skeleton_solo(var_0) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.script_parameters = "ground_spawn_no_boards";
  var_1.script_animation = "spawn_ground";
  var_2 = 4;
  var_3 = 0.3;
  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = var_1 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("skeleton", 1);
    if(isDefined(var_5)) {
      level thread skeleton_spawn_fx_pillar(var_0, 2);
      wait(var_3);
      return var_5;
    }

    wait(var_3);
  }

  return undefined;
}

skeleton_spawn_fx_pillar(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin_snake_chi");
  wait(var_1);
  var_2 delete();
}

skeleton_arrival_cowbell(var_0) {
  var_1 = (0, 0, -11);
  var_2 = spawnfx(level._effect["skeleton_summon_portal"], var_0 + var_1, (0, 0, 1), (1, 0, 0));
  thread scripts\engine\utility::play_sound_in_space("chi_snake_skeleton_spawn", var_2.origin);
  triggerfx(var_2);
  self playSound("chi_snake_skeleton_spawn_foley");
  scripts\engine\utility::waittill_any("death", "intro_vignette_done");
  var_2 delete();
}

set_skeleton_attributes(var_0) {
  level endon("game_ended");
  self endon("death");
  self.playerowner = var_0;
  self.owner = var_0;
  var_1 = self;
  var_1.team = "allies";
  var_1.synctransients = "sprint";
  var_1.is_reserved = 1;
  var_1.is_turned = 1;
  var_1.maxhealth = 900;
  var_1.health = 900;
  var_1.allowpain = 0;
  var_1 notify("turned");
  var_1 thread zombie_movement_update(self);
  var_1.melee_damage_amt = int(scripts\cp\zombies\zombies_spawning::calculatezombiehealth("generic_zombie") * 1.5);
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, var_1);
  level.current_num_spawned_enemies--;
  var_1 thread kill_turned_zombie_after_time(30);
  var_1 thread remove_zombie_from_turned_list_on_death();
  var_1 thread watch_zombie_collision();
  if(isDefined(level.turned_zombies)) {
    level.turned_zombies = scripts\engine\utility::array_add(level.turned_zombies, var_1);
    return;
  }

  level.turned_zombies = [];
  level.turned_zombies = scripts\engine\utility::array_add(level.turned_zombies, var_1);
}

watch_zombie_collision() {
  self endon("death");
  var_0 = 576;
  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    if(var_1.size == 0) {
      wait(0.05);
      continue;
    }

    var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
    if(distancesquared(var_2.origin, self.origin) < var_0) {
      var_2.full_gib = 1;
      var_2.customdeath = 1;
      var_2 dodamage(var_2.health + 100, var_2.origin, self, self, "MOD_MELEE", "none");
    }

    wait(0.05);
  }
}

kill_turned_zombie_after_time(var_0) {
  level endon("game_ended");
  self endon("death");
  self waittill("intro_vignette_done");
  while(var_0 > 0) {
    wait(1);
    var_0--;
  }

  thread scripts\engine\utility::play_sound_in_space("chi_snake_skeleton_death", self.origin);
  self dodamage(self.health + 100, self.origin);
}

remove_zombie_from_turned_list_on_death() {
  level endon("game_ended");
  self waittill("death");
  level.turned_zombies = scripts\engine\utility::array_remove(level.turned_zombies, self);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

determine_skeleton_spawn_point(var_0) {
  var_1 = self.angles;
  var_2 = self.origin + anglesToForward(self.angles) * 64;
  var_3 = 0;
  while(var_3 <= 360) {
    if(ispointonnavmesh(var_2) && scripts\cp\maps\cp_disco\cp_disco::is_in_active_volume(var_2)) {
      break;
    }

    var_1 = var_1 + (0, 15, 0);
    var_3 = var_3 + 15;
    var_2 = self.origin + anglesToForward(var_1) * 64;
  }

  if(var_3 >= 360) {
    return self.origin;
  }

  return var_2;
}

zombie_movement_update(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("death");
  for(;;) {
    var_1 = determine_skeleton_mode(var_0);
    switch (var_1) {
      case "move":
        skeleton_move_to_player(var_0);
        break;

      case "fight":
        self.scripted_mode = 0;
        wait(3);
        break;

      default:
        wait(0.25);
        break;
    }
  }
}

skeleton_move_to_player(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("death");
  self.scripted_mode = 1;
  self ghostskulls_total_waves(96);
  self ghosts_attack_logic(self.playerowner);
  scripts\engine\utility::waittill_any_timeout(2, "goal_reached");
}

determine_skeleton_mode(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("death");
  if(distance2dsquared(self.origin, var_0.origin) >= 1048576) {
    return "move";
  }

  var_1 = sortbydistance(level.spawned_enemies, var_0.origin);
  if(!isDefined(var_1) || var_1.size == 0) {
    return "move";
  }

  if(distance2dsquared(var_1[0].origin, var_0.origin) >= 1048576) {
    return "move";
  }

  return "fight";
}

snake_super_use(var_0) {
  self.snake_super = 1;
  scripts\engine\utility::allow_melee(0);
  var_1 = 500;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playgestureviewmodel("ges_snake_melee_super", undefined, 1);
  thread play_snake_hand_fx();
  self.kung_fu_shield = 1;
  wait(0.75);
  self playanimscriptevent("power_active_cp", "gesture024");
  var_2 = 4;
  var_3 = 0.1;
  var_4 = var_2 / var_3;
  for(var_5 = 0; var_5 < var_4; var_5++) {
    snake_super_damage_nearby_enemies();
    wait(var_3);
  }

  self stopgestureviewmodel("ges_snake_melee_super");
  self.kung_fu_shield = undefined;
  self.kung_fu_exit_delay = 0;
  self.snake_super = undefined;
  scripts\engine\utility::allow_melee(1);
  scripts\cp\powers\coop_powers::power_enablepower();
}

play_snake_hand_fx() {
  self setscriptablepartstate("kung_fu_super_fx", "snake");
  wait(4.75);
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

snake_super_damage_nearby_enemies() {
  var_0 = 50;
  var_1 = [];
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_3 = sortbydistance(var_2, self.origin);
  foreach(var_5 in var_3) {
    isDefined(var_5);
    if(distance2dsquared(self.origin, var_5.origin) >= var_0 * var_0) {
      break;
    }

    if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_5.origin, cos(90))) {
      var_1[var_1.size] = var_5;
    }
  }

  var_7 = 0;
  foreach(var_5 in var_1) {
    if(var_7 >= 3) {
      return;
    }

    if(isDefined(var_5)) {
      var_5 dodamage(var_5.maxhealth + 1000, self.origin, self, undefined, "MOD_EXPLOSIVE");
    }

    var_7++;
  }
}