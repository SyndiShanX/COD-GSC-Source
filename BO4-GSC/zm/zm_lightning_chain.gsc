/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_lightning_chain.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace lightning_chain;

autoexec __init__system__() {
  system::register(#"lightning_chain", &init, undefined, undefined);
}

init() {
  level._effect[#"tesla_bolt"] = "zm_ai/fx8_elec_bolt";
  level._effect[#"tesla_shock"] = "zm_ai/fx8_elec_shock";
  level._effect[#"tesla_shock_secondary"] = "zm_ai/fx8_elec_bolt";
  level._effect[#"tesla_shock_nonfatal"] = "zm_ai/fx8_elec_shock_os";
  level._effect[#"tesla_shock_eyes"] = "zm_ai/fx8_elec_shock_eyes";
  level.default_lightning_chain_params = create_lightning_chain_params();
  clientfield::register("actor", "lc_fx", 1, 2, "int");
  clientfield::register("vehicle", "lc_fx", 1, 2, "int");
  clientfield::register("actor", "lc_death_fx", 1, 2, "int");
  clientfield::register("vehicle", "lc_death_fx", 1, 2, "int");
  callback::on_connect(&on_player_connect);
}

create_lightning_chain_params(max_arcs = 5, max_enemies_killed = 10, radius_start = 300, radius_decay = 20, head_gib_chance = 75, arc_travel_time = 0.11, kills_for_powerup = 10, min_fx_distance = 128, network_death_choke = 4, should_kill_enemies = 1, clientside_fx = 1, arc_fx_sound = undefined, no_fx = 0, prevent_weapon_kill_credit = 0) {
  lcp = spawnStruct();
  lcp.max_arcs = max_arcs;
  lcp.max_enemies_killed = max_enemies_killed;
  lcp.radius_start = radius_start;
  lcp.radius_decay = radius_decay;
  lcp.head_gib_chance = head_gib_chance;
  lcp.arc_travel_time = arc_travel_time;
  lcp.kills_for_powerup = kills_for_powerup;
  lcp.min_fx_distance = min_fx_distance;
  lcp.network_death_choke = network_death_choke;
  lcp.should_kill_enemies = should_kill_enemies;
  lcp.clientside_fx = clientside_fx;
  lcp.arc_fx_sound = arc_fx_sound;
  lcp.no_fx = no_fx;
  lcp.prevent_weapon_kill_credit = prevent_weapon_kill_credit;
  return lcp;
}

private on_player_connect() {
  self endon(#"disconnect", #"death");
  self waittill(#"spawned_player");
  self.tesla_network_death_choke = 0;
  self.tesla_arc_count = 0;

  for(;;) {
    util::wait_network_frame(2);
    self.tesla_network_death_choke = 0;
  }
}

arc_damage(source_enemy, player, arc_num, params = level.default_lightning_chain_params) {
  player endon(#"disconnect");

  if(!isDefined(player.tesla_network_death_choke)) {
    player.tesla_network_death_choke = 0;
  }

  if(!isDefined(player.tesla_enemies_hit)) {
    player.tesla_enemies_hit = 0;
  }

  zm_utility::debug_print("<dev string:x38>" + arc_num + "<dev string:x61>" + player.tesla_enemies_hit);

    lc_flag_hit(self, 1);
  radius_decay = params.radius_decay * arc_num;
  origin = self gettagorigin("j_head");

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  enemies = lc_get_enemies_in_area(origin, params.radius_start - radius_decay, player);
  util::wait_network_frame();
  lc_flag_hit(enemies, 1);
  self thread lc_do_damage(source_enemy, arc_num, player, params);

  zm_utility::debug_print("<dev string:x7a>" + enemies.size + "<dev string:x84>" + arc_num);

    for(i = 0; i < enemies.size; i++) {
      if(!isDefined(enemies[i]) || enemies[i] == self) {
        continue;
      }

      if(lc_end_arc_damage(arc_num + 1, player.tesla_enemies_hit, params)) {
        lc_flag_hit(enemies[i], 0);
        continue;
      }

      player.tesla_enemies_hit++;
      enemies[i] arc_damage(self, player, arc_num + 1, params);
    }
}

arc_damage_ent(player, arc_num, params = level.default_lightning_chain_params) {
  lc_flag_hit(self, 1);
  self thread lc_do_damage(self, arc_num, player, params);
}

private lc_end_arc_damage(arc_num, enemies_hit_num, params) {
  if(arc_num >= params.max_arcs) {

    zm_utility::debug_print("<dev string:xa0>");

      return true;
  }

  if(enemies_hit_num >= params.max_enemies_killed) {

    zm_utility::debug_print("<dev string:xc5>");

      return true;
  }

  radius_decay = params.radius_decay * arc_num;

  if(params.radius_start - radius_decay <= 0) {

    zm_utility::debug_print("<dev string:xf0>");

      return true;
  }

  return false;
}

private lc_get_enemies_in_area(origin, distance, player) {

  level thread lc_debug_arc(origin, distance);

    distance_squared = distance * distance;
  enemies = [];

  if(!isDefined(player.tesla_enemies)) {
    player.tesla_enemies = zombie_utility::get_round_enemy_array();

    if(player.tesla_enemies.size > 0) {
      player.tesla_enemies = array::get_all_closest(origin, player.tesla_enemies);
    }
  }

  zombies = player.tesla_enemies;

  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(!isDefined(zombies[i])) {
        continue;
      }

      if(isDefined(zombies[i].lightning_chain_immune) && zombies[i].lightning_chain_immune) {
        continue;
      }

      test_origin = zombies[i] gettagorigin("j_head");

      if(!isDefined(test_origin)) {
        test_origin = zombies[i].origin;
      }

      if(zombies[i] ai::is_stunned()) {
        continue;
      }

      if(zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
        continue;
      }

      if(distancesquared(origin, test_origin) > distance_squared) {
        continue;
      }

      if(!bullettracepassed(origin, test_origin, 0, undefined)) {
        continue;
      }

      enemies[enemies.size] = zombies[i];
    }
  }

  return enemies;
}

private lc_flag_hit(enemy, hit) {
  if(isDefined(enemy)) {
    if(isarray(enemy)) {
      for(i = 0; i < enemy.size; i++) {
        if(isDefined(enemy[i])) {
          if(hit) {
            enemy[i] ai::stun();
            continue;
          }

          enemy[i] ai::clear_stun();
        }
      }

      return;
    }

    if(isDefined(enemy)) {
      if(hit) {
        enemy ai::stun();
        return;
      }

      enemy ai::clear_stun();
    }
  }
}

private lc_do_damage(source_enemy, arc_num, player, params) {
  player endon(#"disconnect");

  if(arc_num > 1) {
    wait randomfloatrange(0.2, 0.6) * arc_num;
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(params.clientside_fx) {
    if(arc_num > 1) {
      clientfield::set("lc_fx", 2);
    } else {
      clientfield::set("lc_fx", 1);
    }
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(isDefined(source_enemy) && source_enemy != self) {
    if(player.tesla_arc_count > 3) {
      util::wait_network_frame();
      player.tesla_arc_count = 0;
    }

    player.tesla_arc_count++;
    source_enemy lc_play_arc_fx(self, params);
  }

  while(player.tesla_network_death_choke > params.network_death_choke) {

    zm_utility::debug_print("<dev string:x128>" + player.tesla_network_death_choke);

      waitframe(1);
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  player.tesla_network_death_choke++;
  self lc_play_death_fx(arc_num, params);
  self.tesla_death = params.should_kill_enemies;
  str_mod = isDefined(params.str_mod) ? params.str_mod : "MOD_UNKNOWN";
  origin = player.origin;

  if(isDefined(source_enemy) && source_enemy != self) {
    origin = source_enemy.origin;
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(params.should_kill_enemies) {
    if(isDefined(self.tesla_damage_func)) {
      self[[self.tesla_damage_func]](origin, player);
      return;
    } else if(isDefined(params.prevent_weapon_kill_credit) && params.prevent_weapon_kill_credit) {
      self dodamage(self.health + 666, origin, player, undefined, "none", str_mod, 0, level.weaponnone);
    } else {
      weapon = level.weaponnone;

      if(isDefined(params.weapon)) {
        weapon = params.weapon;
      }

      self dodamage(self.health + 666, origin, player, undefined, "none", str_mod, 0, weapon);
    }

    if(!(isDefined(self.deathpoints_already_given) && self.deathpoints_already_given) && player zm_spawner::player_can_score_from_zombies()) {
      self.deathpoints_already_given = 1;
      player zm_score::player_add_points("death", "", "", self);
    }

    if(isDefined(params.challenge_stat_name) && isDefined(player) && isplayer(player)) {
      player zm_stats::increment_challenge_stat(params.challenge_stat_name);
    }

    return;
  }

  if(isDefined(params.n_damage_max)) {
    self thread function_915d4fec(params, origin, player);
  }
}

private function_915d4fec(params, v_origin, player) {
  if(isDefined(params.var_a9255d36)) {
    s_waitresult = self waittill(params.var_a9255d36, #"death");
  }

  weapon = isDefined(params.weapon) ? params.weapon : level.weaponnone;
  str_mod = isDefined(params.str_mod) ? params.str_mod : "MOD_UNKNOWN";

  if(isalive(self)) {
    self dodamage(params.n_damage_max, v_origin, player, undefined, "none", str_mod, 0, weapon);

    if(!isalive(self) && isDefined(params.challenge_stat_name) && isplayer(player)) {
      player zm_stats::increment_challenge_stat(params.challenge_stat_name);
    }
  }
}

lc_play_death_fx(arc_num, params) {
  tag = "J_SpineUpper";
  fx = "tesla_shock";
  n_fx = 1;
  b_can_clientside = 1;

  if(isDefined(self.isdog) && self.isdog) {
    tag = "J_Spine1";
  }

  if(isDefined(self.teslafxtag)) {
    b_can_clientside = 0;
    tag = self.teslafxtag;
  } else if(!(self.archetype === #"zombie")) {
    tag = "tag_origin";
  }

  if(arc_num > 1) {
    fx = "tesla_shock_secondary";
    n_fx = 2;
  }

  if(!params.should_kill_enemies) {
    fx = "tesla_shock_nonfatal";
    n_fx = 3;
  }

  if(params.no_fx) {} else if(params.clientside_fx && b_can_clientside) {
    clientfield::set("lc_death_fx", n_fx);
  } else {
    zm_net::network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect[fx], self, tag);
  }

  if(isDefined(self.tesla_head_gib_func) && !self.head_gibbed && params.should_kill_enemies && !(isDefined(self.no_gib) && self.no_gib)) {
    [[self.tesla_head_gib_func]]();
  }
}

lc_play_arc_fx(target, params) {
  if(!isDefined(self) || !isDefined(target)) {
    wait params.arc_travel_time;
    return;
  }

  tag = "J_SpineUpper";

  if(isDefined(self.isdog) && self.isdog) {
    tag = "J_Spine1";
  } else if(!(self.archetype === #"zombie")) {
    tag = "tag_origin";
  }

  target_tag = "J_SpineUpper";

  if(isDefined(target.isdog) && target.isdog) {
    target_tag = "J_Spine1";
  } else if(!(target.archetype === #"zombie")) {
    target_tag = "tag_origin";
  }

  origin = self gettagorigin(tag);
  target_origin = target gettagorigin(target_tag);
  distance_squared = params.min_fx_distance * params.min_fx_distance;

  if(distancesquared(origin, target_origin) < distance_squared) {

    zm_utility::debug_print("<dev string:x169>");

      return;
  }

  fxorg = util::spawn_model("tag_origin", origin);
  fx = playFXOnTag(level._effect[#"tesla_bolt"], fxorg, "tag_origin");

  if(isDefined(params.arc_fx_sound)) {
    playsoundatposition(params.arc_fx_sound, fxorg.origin);
  }

  fxorg moveto(target_origin, params.arc_travel_time);
  fxorg waittill(#"movedone");
  fxorg delete();
}

private lc_debug_arc(origin, distance) {
  if(getdvarint(#"zombie_debug", 0) != 3) {
    return;
  }

  start = gettime();

  while(gettime() < start + 3000) {
    waitframe(1);
  }
}

