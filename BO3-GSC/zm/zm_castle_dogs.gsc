/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_dogs.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_castle_low_grav;
#namespace zm_castle_dogs;

function autoexec init() {
  spawner::add_archetype_spawn_function("zombie_dog", & function_9f8cfcf5);
}

function function_9f8cfcf5() {
  self thread zm_castle_low_grav::function_f4766f6();
}

function dog_round_tracker() {
  level.dog_round_count = 1;
  level.next_dog_round = level.round_number + randomintrange(4, 6);
  old_spawn_func = level.round_spawn_func;
  old_wait_func = level.round_wait_func;
  while (true) {
    level waittill("between_round_over");
    if(getdvarint("") > 0) {
      level.next_dog_round = level.round_number;
    }
    if(level.round_number == level.next_dog_round) {
      level.sndmusicspecialround = 1;
      old_spawn_func = level.round_spawn_func;
      old_wait_func = level.round_wait_func;
      zm_ai_dogs::dog_round_start();
      level.round_spawn_func = & zm_ai_dogs::dog_round_spawning;
      level.round_wait_func = & zm_ai_dogs::dog_round_wait_func;
      level clientfield::set("castle_fog_bank_switch", 1);
      level.next_dog_round = level.round_number + randomintrange(7, 14);
      getplayers()[0] iprintln("" + level.next_dog_round);
    } else if(level flag::get("dog_round")) {
      level clientfield::set("castle_fog_bank_switch", 0);
      zm_ai_dogs::dog_round_stop();
      level.round_spawn_func = old_spawn_func;
      level.round_wait_func = old_wait_func;
      level.dog_round_count = level.dog_round_count + 1;
    }
  }
}

function function_33aa4940() {
  var_88369d66 = 0;
  if(level.round_number > 30) {
    if(randomfloat(100) < 4) {
      var_88369d66 = 1;
    }
  } else {
    if(level.round_number > 25) {
      if(randomfloat(100) < 3) {
        var_88369d66 = 1;
      }
    } else {
      if(level.round_number > 20) {
        if(randomfloat(100) < 2) {
          var_88369d66 = 1;
        }
      } else if(level.round_number > 15) {
        if(randomfloat(100) < 1) {
          var_88369d66 = 1;
        }
      }
    }
  }
  if(var_88369d66) {
    zm_ai_dogs::special_dog_spawn(1);
    level.zombie_total--;
  }
  return var_88369d66;
}

function function_92e4eaff(var_70e0fe97, var_19764360) {
  var_2ad6ea05 = array::randomize(level.zm_loc_types["dog_location"]);
  for (i = 0; i < var_2ad6ea05.size; i++) {
    if(isdefined(level.old_dog_spawn) && level.old_dog_spawn == var_2ad6ea05[i]) {
      continue;
    }
    if(isdefined(var_19764360)) {
      n_dist_squared = distancesquared(var_2ad6ea05[i].origin, var_19764360.origin);
      if(n_dist_squared > 360000 && n_dist_squared < 1440000) {
        level.old_dog_spawn = var_2ad6ea05[i];
        return var_2ad6ea05[i];
      }
    }
  }
  return var_2ad6ea05[0];
}

function function_8cf500c9() {
  self ai::set_behavior_attribute("sprint", 1);
}

function function_1aaa22b5() {
  if(!isdefined(self.favoriteenemy)) {
    return;
  }
  var_4b010f36 = self zm_utility::get_current_zone();
  var_3d24b4b1 = self.favoriteenemy zm_utility::get_current_zone();
  if(isdefined(var_4b010f36) && isdefined(var_3d24b4b1)) {
    if(issubstr(var_4b010f36, "v10") && !issubstr(var_3d24b4b1, "v10") || (!issubstr(var_4b010f36, "v10") && issubstr(var_3d24b4b1, "v10"))) {
      level.dog_round_count++;
      self kill();
    }
  }
}