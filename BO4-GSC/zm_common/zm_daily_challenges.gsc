/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_daily_challenges.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\table_shared;
#include scripts\zm_common\gametypes\globallogic_score;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_daily_challenges;

autoexec __init__system__() {
  system::register(#"zm_daily_challenges", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_connect(&on_connect);
  callback::on_spawned(&on_spawned);
  callback::on_challenge_complete(&on_challenge_complete);
  zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

__main__() {
  level thread spent_points_tracking();
  level thread earned_points_tracking();
}

on_connect() {
  self thread round_tracking();
  self thread perk_purchase_tracking();
  self thread perk_drink_tracking();
  self.a_daily_challenges = [];
  self.a_daily_challenges[0] = 0;
  self.a_daily_challenges[1] = 0;
  self.a_daily_challenges[2] = 0;
  self.a_daily_challenges[3] = 0;
}

on_spawned() {
  self thread challenge_ingame_time_tracking();
}

round_tracking() {
  self endon(#"disconnect");

  while(true) {
    level waittill(#"end_of_round");
    self.a_daily_challenges[3]++;
    self zm_stats::increment_challenge_stat(#"hash_4d3e2513e68c6848", undefined, 1);

    debug_print("<dev string:x38>");

      switch (self.a_daily_challenges[3]) {
        case 10:
          self zm_stats::increment_challenge_stat(#"zm_daily_round_10", undefined, 1);

          debug_print("<dev string:x52>");

            break;
        case 15:
          self zm_stats::increment_challenge_stat(#"zm_daily_round_15", undefined, 1);

          debug_print("<dev string:x71>");

            break;
        case 20:
          self zm_stats::increment_challenge_stat(#"zm_daily_round_20", undefined, 1);

          debug_print("<dev string:x90>");

            break;
        case 25:
          self zm_stats::increment_challenge_stat(#"zm_daily_round_25", undefined, 1);

          debug_print("<dev string:xaf>");

            break;
        case 30:
          self zm_stats::increment_challenge_stat(#"zm_daily_round_30", undefined, 1);

          debug_print("<dev string:xce>");

            break;
      }
  }
}

death_check_for_challenge_updates(e_attacker) {
  if(!isDefined(e_attacker)) {
    return;
  }

  if(isDefined(e_attacker._trap_type)) {
    if(isDefined(e_attacker.activated_by_player)) {
      e_attacker.activated_by_player zm_stats::increment_challenge_stat(#"zm_daily_kills_traps");

      debug_print("<dev string:xed>");

    }
  }

  if(!isplayer(e_attacker)) {
    return;
  }

  e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills");

  debug_print("<dev string:x102>");

    if(isvehicle(self)) {
      str_damagemod = self.str_damagemod;
      w_damage = self.w_damage;
    }
  else {
    str_damagemod = self.damagemod;
    w_damage = self.damageweapon;
  }

  if(w_damage.inventorytype == "dwlefthand") {
    w_damage = w_damage.dualwieldweapon;
  }

  w_damage = zm_weapons::get_nonalternate_weapon(w_damage);

  if(isDefined(self.zm_ai_category)) {
    switch (self.zm_ai_category) {
      case #"heavy":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_heavy");

        debug_print("<dev string:x112>");

          break;
      case #"miniboss":
        e_attacker zm_stats::increment_challenge_stat(#"hash_258c10d310bf4203");

        debug_print("<dev string:x128>");

          break;
    }
  }

  switch (self.archetype) {
    case #"blight_father":
      e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_blightfather");

      debug_print("<dev string:x141>");

        break;
    case #"catalyst":
      e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_catalyst");

      debug_print("<dev string:x15e>");

        if(isDefined(self.var_69a981e6) && self.var_69a981e6) {

          e_attacker debug_print("<dev string:x177>");

            e_attacker zm_stats::increment_challenge_stat(#"catalyst_transformation_denials");
        }

      break;
    case #"gladiator":
      e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_gladiator");

      debug_print("<dev string:x1a9>");

        break;
    case #"stoker":
      e_attacker zm_stats::increment_challenge_stat(#"hash_2eb016a9af7e8a3");

      debug_print("<dev string:x1c3>");

        break;
    case #"tiger":
      e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_tiger");

      debug_print("<dev string:x1da>");

        break;
  }

  if(isDefined(self.missinglegs) && self.missinglegs) {
    e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_crawler");

    debug_print("<dev string:x1f0>");

  }

  if(self zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod)) {
    e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_headshots");

    debug_print("<dev string:x208>");

      if(isDefined(e_attacker.a_daily_challenges) && isint(e_attacker.a_daily_challenges[0])) {
        e_attacker.a_daily_challenges[0]++;

        if(e_attacker.a_daily_challenges[0] == 20) {
          e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_headshots_in_row");

          debug_print("<dev string:x221>");

        }
      }
  } else {
    e_attacker.a_daily_challenges[0] = 0;
  }

  if(isplayer(e_attacker) && e_attacker zm_powerups::is_insta_kill_active()) {
    e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_instakill");

    debug_print("<dev string:x244>");

  }

  if(zm_loadout::is_lethal_grenade(w_damage)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_5f9b7801af13f397");

    debug_print("<dev string:x25f>");

  }

  if(e_attacker zm_pap_util::function_b81da3fd(w_damage)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_799aecaf1ec45db1");

    debug_print("<dev string:x279>");

      w_stat = zm_weapons::get_base_weapon(w_damage);
  } else if(zm_weapons::is_weapon_upgraded(w_damage)) {
    e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_packed");

    debug_print("<dev string:x29e>");

      w_stat = zm_weapons::get_base_weapon(w_damage);
  } else {
    w_stat = zm_weapons::function_386dacbc(w_damage);
  }

  if(zm_loadout::is_hero_weapon(w_damage)) {
    e_attacker zm_stats::increment_challenge_stat(#"hash_730e40ef22de352");

    debug_print("<dev string:x2bc>");

  }

  if(isDefined(level.zombie_weapons[w_stat])) {
    switch (level.zombie_weapons[w_stat].weapon_classname) {
      case #"ar":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_rifle");

        debug_print("<dev string:x2d8>");

          break;
      case #"lmg":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_mg");

        debug_print("<dev string:x2ee>");

          break;
      case #"pistol":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_pistol");

        debug_print("<dev string:x301>");

          break;
      case #"shotgun":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_shotgun");

        debug_print("<dev string:x318>");

          break;
      case #"smg":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_smg");

        debug_print("<dev string:x330>");

          break;
      case #"sniper":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_sniper");

        debug_print("<dev string:x344>");

          break;
      case #"tr":
        e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_tactical_rifle");

        debug_print("<dev string:x35b>");

          break;
    }
  }

  switch (str_damagemod) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_projectile":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
      e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_explosive");

      debug_print("<dev string:x37a>");

        break;
  }

  if(w_damage.statname === #"bowie_knife") {
    e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_bowie");

    debug_print("<dev string:x394>");

  }
}

spent_points_tracking() {
  level endon(#"end_game");

  while(true) {
    result = level waittill(#"spent_points");
    player = result.player;
    n_points = result.points;
    player.a_daily_challenges[1] += n_points;
    player zm_stats::increment_challenge_stat(#"zm_daily_spend_25k", n_points);
    player zm_stats::increment_challenge_stat(#"zm_daily_spend_50k", n_points);

    debug_print("<dev string:x3b0>");

  }
}

earned_points_tracking() {
  level endon(#"end_game");

  while(true) {
    result = level waittill(#"earned_points");
    player = result.player;

    if(!isDefined(player)) {
      continue;
    }

    n_points = result.points;

    if(zm_utility::is_standard()) {
      player zm_stats::increment_challenge_stat(#"hash_7ea82afc1c790346", n_points);
    } else {
      player zm_stats::increment_challenge_stat(#"hash_67970ded10f84169", n_points, 1);
    }

    debug_print("<dev string:x3c7>");

      n_multiplier = zm_score::get_points_multiplier(player);

    if(n_multiplier == 2) {
      player.a_daily_challenges[2] += n_points;
      player zm_stats::increment_challenge_stat(#"zm_daily_earn_5k_with_2x", n_points, 1);

      debug_print("<dev string:x3e0>");

    }
  }
}

challenge_ingame_time_tracking() {
  self endon(#"disconnect");
  self notify(#"stop_challenge_ingame_time_tracking");
  self endon(#"stop_challenge_ingame_time_tracking");
  level flag::wait_till("start_zombie_round_logic");

  for(;;) {
    wait 1;
    zm_stats::increment_client_stat("ZM_DAILY_CHALLENGE_INGAME_TIME");
  }
}

increment_windows_repaired(s_barrier) {
  if(!isDefined(self.n_dc_barriers_rebuilt)) {
    self.n_dc_barriers_rebuilt = 0;
  }

  if(!(isDefined(self.b_dc_rebuild_timer_active) && self.b_dc_rebuild_timer_active)) {
    self thread rebuild_timer();
    self.a_s_barriers_rebuilt = [];
  }

  if(!isinarray(self.a_s_barriers_rebuilt, s_barrier)) {
    if(!isDefined(self.a_s_barriers_rebuilt)) {
      self.a_s_barriers_rebuilt = [];
    } else if(!isarray(self.a_s_barriers_rebuilt)) {
      self.a_s_barriers_rebuilt = array(self.a_s_barriers_rebuilt);
    }

    self.a_s_barriers_rebuilt[self.a_s_barriers_rebuilt.size] = s_barrier;
    self.n_dc_barriers_rebuilt++;
  }
}

private rebuild_timer() {
  self endon(#"disconnect");
  self.b_dc_rebuild_timer_active = 1;
  wait 45;

  if(self.n_dc_barriers_rebuilt >= 5) {
    self zm_stats::increment_challenge_stat(#"zm_daily_rebuild_windows");

    debug_print("<dev string:x412>");

  }

  self.n_dc_barriers_rebuilt = 0;
  self.a_s_barriers_rebuilt = [];
  self.b_dc_rebuild_timer_active = undefined;
}

increment_magic_box() {
  if(isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
    self zm_stats::increment_challenge_stat(#"zm_daily_purchase_fire_sale_magic_box");

    debug_print("<dev string:x42d>");

  }

  self zm_stats::increment_challenge_stat(#"zm_daily_purchase_magic_box", undefined, 1);
  self zm_stats::increment_challenge_stat(#"hash_702d98df99af63d5", undefined, 1);

  debug_print("<dev string:x458>");

}

increment_nuked_zombie() {
  foreach(player in level.players) {
    if(player.sessionstate != "spectator") {
      player zm_stats::increment_challenge_stat(#"zm_daily_kills_nuked");

      debug_print("<dev string:x472>");

    }
  }
}

perk_purchase_tracking() {
  self endon(#"disconnect");

  while(true) {
    str_perk = undefined;
    self waittill(#"perk_purchased", str_perk);
    self zm_stats::increment_challenge_stat(#"zm_daily_purchase_perks");

    debug_print("<dev string:x48a>");

  }
}

perk_drink_tracking() {
  self endon(#"disconnect");

  while(true) {
    self waittill(#"perk_bought");
    self zm_stats::increment_challenge_stat(#"zm_daily_drink_perks");

    debug_print("<dev string:x4a4>");

  }
}

debug_print(str_line) {
  if(getdvarint(#"zombie_debug", 0) > 0) {
    println(str_line);
  }
}

on_challenge_complete(params) {
  n_challenge_index = params.challenge_index;

  if(is_daily_challenge(n_challenge_index)) {
    if(isDefined(self)) {
      uploadstats(self);
    }

    a_challenges = table::load(#"gamedata/stats/zm/statsmilestones4.csv", "a0");
    str_current_challenge = a_challenges[n_challenge_index][#"e4"];
    n_players = level.players.size;
    n_time_played = game.timepassed / 1000;
    n_challenge_start_time = self zm_stats::get_global_stat("zm_daily_challenge_start_time");
    n_challenge_time_ingame = self globallogic_score::getpersstat(#"zm_daily_challenge_ingame_time");
    n_challenge_games_played = self zm_stats::get_global_stat("zm_daily_challenge_games_played");

    debug_print("<dev string:x4ba>" + n_challenge_index);

  }
}

is_daily_challenge(n_challenge_index) {
  n_row = tablelookuprownum(#"gamedata/stats/zm/statsmilestones4.csv", 0, n_challenge_index);

  if(n_row > -1) {
    return true;
  }

  return false;
}