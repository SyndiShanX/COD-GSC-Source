/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_nuke.gsc
***********************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#namespace zm_powerup_nuke;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_nuke", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("nuke", &grab_nuke);
  clientfield::register("actor", "zm_nuked", 1, 1, "int");
  clientfield::register("vehicle", "zm_nuked", 1, 1, "int");
  zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", #"zombie/powerup_nuke", &function_8d3a47ed, 0, 0, 0, "zombie/fx9_powerup_nuke");
  level flag::init(#"hash_21921ed511559aa3");
}

function grab_nuke(player) {
  level thread nuke_powerup(self, player.team, player);
  players = getplayers();

  foreach(e_player in players) {
    if(isDefined(e_player) && isPlayer(e_player) && isDefined(self.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", self.hint);
    }
  }

  player thread zm_powerups::powerup_vo("nuke");
  zombies = getaiteamarray(level.zombie_team);
  player.zombie_nuked = arraysort(zombies, self.origin);
  player notify(#"nuke_triggered");
}

function function_8d3a47ed() {
  if(zm_utility::is_survival()) {
    a_players = getplayers();

    foreach(player in a_players) {
      a_enemies = player getenemiesinradius(player.origin, 3000);

      if(a_enemies.size) {
        return true;
      }
    }

    return false;
  }

  return true;
}

function nuke_powerup(drop_item, player_team, var_264cf1f9) {
  level thread nuke_delay_spawning(3);
  location = drop_item.origin;

  if(isDefined(drop_item.fx)) {
    playFX(drop_item.fx, location);
  }

  if(!is_true(level.var_5f911d8e)) {
    level thread nuke_flash(player_team, location);
  }

  if(zm_utility::is_survival()) {
    a_enemies = var_264cf1f9 getenemiesinradius(location, 3000);
  } else {
    a_enemies = getaiteamarray(level.zombie_team);
  }

  foreach(ai_enemy in a_enemies) {
    ai_enemy ai::stun(1.5);
  }

  wait 0.5;

  if(zm_utility::is_survival()) {
    zombies = a_enemies;
    function_1eaaceab(zombies);
  } else {
    zombies = getaiteamarray(level.zombie_team);
  }

  zombies = arraysort(zombies, location);
  zombies_nuked = [];

  for(i = 0; i < zombies.size; i++) {
    if(is_true(zombies[i].ignore_nuke)) {
      continue;
    }

    if(isDefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
      continue;
    }

    if(isDefined(zombies[i].nuke_damage_func)) {
      zombies[i] thread[[zombies[i].nuke_damage_func]]();
      continue;
    }

    if(zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }

    zombies[i].marked_for_death = 1;

    if(!is_true(zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
      zombies[i].nuked = 1;
      zombies[i].var_98f1f37c = 1;
      zombies_nuked[zombies_nuked.size] = zombies[i];
      zombies[i] clientfield::set("zm_nuked", 1);
      zombies[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
    }
  }

  for(i = 0; i < zombies_nuked.size; i++) {
    wait randomfloatrange(0.1, 0.3);

    if(!isDefined(zombies_nuked[i])) {
      continue;
    }

    if(zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i])) {
      continue;
    }

    if(!is_true(zombies_nuked[i].isdog)) {
      if(!is_true(zombies_nuked[i].no_gib)) {
        zombies_nuked[i] zombie_utility::zombie_head_gib();
      }

      zombies_nuked[i] playSound(#"evt_nuked");
    }

    if(zombies_nuked[i].zm_ai_category === # "normal") {
      zombies_nuked[i] kill();
    } else if(zombies_nuked[i].zm_ai_category === # "special") {
      var_c790ea95 = zombies_nuked[i].maxhealth * 0.75;
    } else if(zombies_nuked[i].zm_ai_category === # "elite") {
      var_c790ea95 = zombies_nuked[i].maxhealth * 0.25;
    }

    if(isDefined(var_c790ea95)) {
      zombies_nuked[i] dodamage(var_c790ea95, zombies_nuked[i].origin);
    }
  }

  level notify(#"nuke_complete");

  if(zm_powerups::function_cfd04802(#"nuke") && isPlayer(var_264cf1f9)) {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: var_264cf1f9, #scoreevent: "nuke_powerup_zm"});
    return;
  }

  foreach(e_player in level.players) {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: e_player, #scoreevent: "nuke_powerup_zm"});
  }
}

function nuke_flash(team, location) {
  if(isDefined(location) && zm_utility::is_survival()) {
    a_players = arraysortclosest(getplayers(), location, undefined, 0, 3000);

    foreach(player in a_players) {
      player playsoundtoplayer(#"evt_nuke_flash", player);
      player thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
    }

    return;
  } else if(isDefined(team)) {
    getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
  } else {
    getplayers()[0] playSound(#"evt_nuke_flash");
  }

  lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
}

function nuke_delay_spawning(n_spawn_delay) {
  level endoncallback(&function_406d206b, #"disable_nuke_delay_spawning");

  if(is_true(level.disable_nuke_delay_spawning)) {
    return;
  }

  b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
  level flag::set(#"hash_21921ed511559aa3");
  level flag::clear("spawn_zombies");
  level waittill(#"nuke_complete");

  if(is_true(level.disable_nuke_delay_spawning)) {
    level flag::clear(#"hash_21921ed511559aa3");
    return;
  }

  wait n_spawn_delay;

  if(!is_true(level.disable_nuke_delay_spawning) && b_spawn_zombies_before_nuke) {
    level flag::set("spawn_zombies");
  }

  level flag::clear(#"hash_21921ed511559aa3");
}

function function_406d206b(var_c34665fc) {
  level flag::clear(#"hash_21921ed511559aa3");
}

function function_9a79647b(var_8de6cf73) {
  self.nuke_damage_func = &nuke_damage_func;
  self.var_3b6e5508 = var_8de6cf73;
}

function nuke_damage_func() {
  self endon(#"death");
  wait randomfloatrange(0.1, 0.7);
  self thread zombie_death::flame_death_fx();
  self playSound(#"evt_nuked");
  self dodamage(self.maxhealth * self.var_3b6e5508, self.origin);
}