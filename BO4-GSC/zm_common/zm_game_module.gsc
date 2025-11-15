/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_game_module.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_utility;

#namespace zm_game_module;

register_game_module(index, module_name, pre_init_func, post_init_func, pre_init_zombie_spawn_func, post_init_zombie_spawn_func, hub_start_func) {
  if(!isDefined(level._game_modules)) {
    level._game_modules = [];
    level._num_registered_game_modules = 0;
  }

  for(i = 0; i < level._num_registered_game_modules; i++) {
    if(!isDefined(level._game_modules[i])) {
      continue;
    }

    if(isDefined(level._game_modules[i].index) && level._game_modules[i].index == index) {
      assert(level._game_modules[i].index != index, "<dev string:x38>" + index + "<dev string:x6a>");
    }
  }

  level._game_modules[level._num_registered_game_modules] = spawnStruct();
  level._game_modules[level._num_registered_game_modules].index = index;
  level._game_modules[level._num_registered_game_modules].module_name = module_name;
  level._game_modules[level._num_registered_game_modules].pre_init_func = pre_init_func;
  level._game_modules[level._num_registered_game_modules].post_init_func = post_init_func;
  level._game_modules[level._num_registered_game_modules].pre_init_zombie_spawn_func = pre_init_zombie_spawn_func;
  level._game_modules[level._num_registered_game_modules].post_init_zombie_spawn_func = post_init_zombie_spawn_func;
  level._game_modules[level._num_registered_game_modules].hub_start_func = hub_start_func;
  level._num_registered_game_modules++;
}

set_current_game_module(game_module_index) {
  if(!isDefined(game_module_index)) {
    level.current_game_module = level.game_module_classic_index;
    level.scr_zm_game_module = level.game_module_classic_index;
    return;
  }

  game_module = get_game_module(game_module_index);

  if(!isDefined(game_module)) {
    assert(isDefined(game_module), "<dev string:x6e>" + game_module_index + "<dev string:x6a>");
    return;
  }

  level.current_game_module = game_module_index;
}

get_current_game_module() {
  return get_game_module(level.current_game_module);
}

get_game_module(game_module_index) {
  if(!isDefined(game_module_index)) {
    return undefined;
  }

  for(i = 0; i < level._game_modules.size; i++) {
    if(level._game_modules[i].index == game_module_index) {
      return level._game_modules[i];
    }
  }

  return undefined;
}

game_module_pre_zombie_spawn_init() {
  current_module = get_current_game_module();

  if(!isDefined(current_module) || !isDefined(current_module.pre_init_zombie_spawn_func)) {
    return;
  }

  self[[current_module.pre_init_zombie_spawn_func]]();
}

game_module_post_zombie_spawn_init() {
  current_module = get_current_game_module();

  if(!isDefined(current_module) || !isDefined(current_module.post_init_zombie_spawn_func)) {
    return;
  }

  self[[current_module.post_init_zombie_spawn_func]]();
}

respawn_spectators_and_freeze_players() {
  foreach(player in getplayers()) {
    if(player.sessionstate == "spectator") {
      player[[level.spawnplayer]]();
    }

    player val::set(#"respawn_spectators_and_freeze_players", "freezecontrols");
  }
}

damage_callback_no_pvp_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, eapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker) && isplayer(eattacker) && eattacker == self) {
    return idamage;
  }

  if(isDefined(eattacker) && !isplayer(eattacker)) {
    return idamage;
  }

  if(!isDefined(eattacker)) {
    return idamage;
  }

  return 0;
}

respawn_players() {
  players = getplayers();

  foreach(player in players) {
    player[[level.spawnplayer]]();
  }
}

zombie_goto_round(target_round) {
  level flag::set("round_reset");
  level notify(#"restart_round");

  if(target_round < 1) {
    target_round = 1;
  }

  level.zombie_total = 0;
  level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), target_round);
  zm_round_logic::set_round_number(target_round);
  enemies = getaiteamarray(level.zombie_team);

  if(isDefined(enemies)) {
    for(i = 0; i < enemies.size; i++) {
      enemy = enemies[i];

      if(zm_utility::is_magic_bullet_shield_enabled(enemy)) {
        enemy util::stop_magic_bullet_shield();
      }

      enemy.allowdeath = 1;
      enemy kill(undefined, undefined, undefined, undefined, undefined, 1);
    }
  }

  wait 5;
  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    if(isactorcorpse(corpse)) {
      corpse delete();
    }
  }
}

make_supersprinter() {
  self zombie_utility::set_zombie_run_cycle("super_sprint");
}

create_fireworks(launch_spots, min_wait, max_wait, randomize) {
  level endon(#"stop_fireworks");

  while(true) {
    if(isDefined(randomize) && randomize) {
      launch_spots = array::randomize(launch_spots);
    }

    foreach(spot in launch_spots) {
      level thread fireworks_launch(spot);
      wait randomfloatrange(min_wait, max_wait);
    }

    wait randomfloatrange(min_wait, max_wait);
  }
}

fireworks_launch(launch_spot) {
  firework = spawn("script_model", launch_spot.origin + (randomintrange(-60, 60), randomintrange(-60, 60), 0));
  firework setModel(#"tag_origin");
  util::wait_network_frame();
  playFXOnTag(level._effect[#"fw_trail_cheap"], firework, "tag_origin");
  firework playLoopSound(#"zmb_souls_loop", 0.75);
  dest = launch_spot;

  while(isDefined(dest) && isDefined(dest.target)) {
    random_offset = (randomintrange(-60, 60), randomintrange(-60, 60), 0);
    new_dests = struct::get_array(dest.target, "targetname");
    new_dest = array::random(new_dests);
    dest = new_dest;
    dist = distance(new_dest.origin + random_offset, firework.origin);
    time = dist / 700;
    firework moveto(new_dest.origin + random_offset, time);
    firework waittill(#"movedone");
  }

  firework playSound(#"zmb_souls_end");
  playFX(level._effect[#"fw_pre_burst"], firework.origin);
  firework delete();
}