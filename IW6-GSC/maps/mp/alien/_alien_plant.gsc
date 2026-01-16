/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_alien_plant.gsc
******************************************/

spore_plant_init() {
  level.plant_warning_sent = 0;
  level._effect["proj_spit_AOE"] = loadfx("vfx/gameplay/alien/vfx_alien_fauna_gas");
  level._effect["spore_death_fx"] = loadfx("vfx/gameplay/alien/vfx_alien_fauna_death");
  level._effect["spore_birth_fx"] = loadfx("vfx/gameplay/alien/vfx_alien_seeder_spore_birth");
  scriptable_init();
}

scriptable_init() {
  level.alive_plants = [];
  level.plants = getscriptablearray("spore_plant_spawn", "targetname");

  foreach(var_1 in level.plants)
  var_1 thread scriptable_crate_spore_plant();

  level thread run_plant_state_logic();
}

scriptable_crate_spore_plant() {
  self.plant_attacking = 0;
  self setscriptablepartstate(0, "inactive");
  self waittill("grow_plant");
  self.trigger = spawn("trigger_radius", self.origin, 0, 128, 128);
  wait 0.1;
  self.elapsed_time = -1;
  thread grow_then_idle();
  thread run_plant_attack_on_damage_logic();
  thread plant_radius_attack();
  self.team = "axis";
  self.alien_type = "spore_plant";
  self.coll_model = spawn("script_model", self.origin);
  self.coll_model setModel("alien_spore_hitbox");
  self.coll_model.origin = self gettagorigin("J_Spore_hitbox");
  self.coll_model.angles = self.angles;
  self.coll_model.parent = self;
  self.coll_model.team = self.team;
  self.coll_model linkto(self, "J_Spore_hitbox");
  self.coll_model setCanDamage(1);
  self.coll_model setCanRadiusDamage(1);
  self.coll_model.alien_type = "seeder_spore";
  level.alive_plants[level.alive_plants.size] = self;
  level notify("added_plant");
}

remove_old_plants() {
  var_0 = 4;

  if(level.alive_plants.size > 8) {
    var_1 = level.alive_plants.size - 8;

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = level.alive_plants[var_2];

      if(isDefined(var_3)) {
        level.alive_plants = common_scripts\utility::array_remove(level.alive_plants, var_3);
        var_3.plant_health = 0;

        if(isDefined(var_3.coll_model))
          var_3.coll_model dodamage(1, (0, 0, 0));
      }

      wait 0.1;
    }
  }
}

run_plant_state_logic() {
  for(;;) {
    var_0 = 0;
    level waittill("drill_planted");
    var_1 = common_scripts\utility::get_array_of_closest(level.drill.origin, level.plants);

    foreach(var_3 in var_1) {
      if(distance2d(var_3.origin, level.drill.origin) < 1024) {
        if(var_3 far_enough_from_players(300)) {
          var_3 notify("grow_plant");
          var_0++;
          wait 1.25;
        }

        if(var_0 >= get_num_to_spawn()) {
          break;
        }
      }
    }

    level thread remove_old_plants();
    wait 0.1;
  }
}

get_num_to_spawn() {
  var_0 = level.players.size;

  switch (var_0) {
    case 1:
      return 4;
    case 2:
      return 6;
    case 3:
      return 7;
    case 4:
      return 8;
    default:
      break;
  }

  return 0;
}

far_enough_from_players(var_0) {
  var_1 = var_0 * var_0;

  foreach(var_3 in level.players) {
    if(distance2dsquared(self.origin, var_3.origin) < var_1)
      return 0;
  }

  return 1;
}

grow_then_idle() {
  self.plant_health = 100;
  self setscriptablepartstate(0, "grow");
  playFX(level._effect["spore_birth_fx"], self.origin, (0, 0, 1), (1, 0, 0));
  wait 3.0;

  if(self.plant_attacking != 1 && self.plant_health > 0)
    self setscriptablepartstate(0, "idle");
}

run_plant_attack_on_damage_logic() {
  while(!isDefined(self.coll_model))
    wait 0.1;

  while(self.plant_health > 0) {
    self.coll_model waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(self.plant_health <= 0) {
      continue;
    }
    if(isDefined(var_1) && isDefined(var_1.team) && var_1.team != self.team) {
      if(isDefined(var_1) && isDefined(var_9)) {
        var_10 = var_1;
        var_11 = "none";
        var_12 = 0;
        level thread maps\mp\alien\_challenge_function::update_alien_damage_challenge(var_10, var_1, var_0, var_8, var_4, var_9, var_3, var_2, var_11, var_12, self);

        if(weaponclass(var_9) == "spread")
          var_0 = var_0 * 4.0;

        if(var_9 == "aliensemtex_mp" && var_4 == "MOD_IMPACT")
          var_0 = 0;
      }

      self.plant_health = self.plant_health - var_0;

      if(self.gas_fx_playing == 0)
        thread plant_gas_fx();

      if(isDefined(var_1) && isplayer(var_1)) {
        var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");

        if(self.plant_health <= 0) {
          var_13 = 25;
          maps\mp\alien\_gamescore::givekillreward(var_1, var_13, undefined, undefined);
        }
      }
    }

    wait 0.1;
  }

  thread stop_trigger_after_time(3.0);
  self notify("die");
  level.alive_plants = common_scripts\utility::array_remove(level.alive_plants, self);
  playFX(level._effect["spore_death_fx"], self.origin, (1, 0, 0), (0, 0, 1));
  wait 0.1;
  self setscriptablepartstate(0, "remove");
  wait 0.1;
  self.coll_model delete();
}

stop_trigger_after_time(var_0) {
  self.gas_fx_playing = 1;
  wait(var_0);
  self notify("stop_trigger_logic");
  wait 0.1;
  self.trigger delete();
}

plant_radius_attack() {
  self endon("stop_trigger_logic");
  self.gassed_players = [];
  self.gas_fx_playing = 0;
  wait 1.0;

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isplayer(var_0)) {
      continue;
    }
    if(self.gas_fx_playing == 0)
      thread plant_gas_fx();

    self.gassed_players = common_scripts\utility::array_removeundefined(self.gassed_players);

    if(is_in_array(self.gassed_players, var_0)) {
      continue;
    }
    thread gas_player(var_0);
  }
}

plant_gas_fx() {
  if(self.plant_attacking == 0)
    thread plant_attack_anim();

  self.gas_fx_playing = 1;
  wait 3.0;
  self.gas_fx_playing = 0;
}

plant_attack_anim() {
  self endon("die");
  self setscriptablepartstate(0, "idle_to_attack");
  self.plant_attacking = 1;
  wait 1.0;
  self setscriptablepartstate(0, "attacking");
  wait 1.5;
  self setscriptablepartstate(0, "attack_to_idle");
  wait 1.0;
  self setscriptablepartstate(0, "idle");
  wait 2.0;
  self.plant_attacking = 0;
}

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

gas_player(var_0) {
  var_0 endon("disconnect");

  if(var_0 maps\mp\alien\_perk_utility::has_perk("perk_medic", [3, 4])) {
    return;
  }
  if(self.gas_fx_playing == 0)
    wait 2;

  if(isDefined(self.trigger) && var_0 istouching(self.trigger)) {
    self.gassed_players[self.gassed_players.size] = var_0;
    thread gas_damage_player(var_0);
    var_0 visionsetpostapplyforplayer("mp_alien_spore_plant", 1.0);
    var_0 playlocalsound("spore_tinnitus");

    while(isDefined(self.trigger) && var_0 istouching(self.trigger) && self.gas_fx_playing == 1)
      wait 0.1;

    self.gassed_players = common_scripts\utility::array_remove(self.gassed_players, var_0);
    var_0 stoplocalsound("spore_tinnitus");
    var_0 visionsetpostapplyforplayer("", 1.0);
  }
}

gas_damage_player(var_0) {
  var_0 endon("disconnect");

  while(is_in_array(self.gassed_players, var_0)) {
    if(maps\mp\alien\_utility::is_casual_mode())
      var_0 dodamage(2, self.origin, self, self);
    else
      var_0 dodamage(1, self.origin, self, self);

    wait 0.5;
  }
}