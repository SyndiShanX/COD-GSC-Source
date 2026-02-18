/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_score.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\trials\zm_trial_damage_drains_points;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_score;

function private autoexec __init__system__() {
  system::register(#"zm_score", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);
  level.var_d6031813 = 1;

  foreach(subdivision in level.var_697c8943) {
    score_cf_register_info("damage" + subdivision, 1, 7);
  }

  score_cf_register_info("death_head", 1, 3);
  score_cf_register_info("death_melee", 1, 3);
  score_cf_register_info("transform_kill", 1, 3);
  clientfield::register_clientuimodel("hudItems.doublePointsActive", 1, 1, "int");
  callback::on_spawned(&player_on_spawned);
  callback::on_item_pickup(&on_item_pickup);
  level callback::on_ai_killed(&function_a3d16ee5);
  level.score_total = 0;
  level.a_func_score_events = [];
  level.var_c44113ca = [];
}

function private postinit() {}

function function_610e9242(event, player, victim, descvalue, weapon, playersaffected) {
  score = playersaffected rank::getscoreinfovalue(weapon);
  assert(isDefined(score));
  xp = playersaffected rank::getscoreinfoxp(weapon);
  assert(isDefined(xp));
  label = rank::getscoreinfolabel(weapon);
  return score;
}

function register_score_event(str_event, func_callback) {
  level.a_func_score_events[str_event] = func_callback;
}

function function_e5d6e6dd(str_archetype, n_score) {
  level.var_c44113ca[str_archetype] = n_score;
}

function function_e5ca5733() {
  if(isDefined(self.score_events[# "kill"]) && isDefined(level.scoreinfo[self.score_events[# "kill"]][# "sp"]) && level.scoreinfo[self.score_events[# "kill"]][# "sp"] > 0) {
    return level.scoreinfo[self.score_events[# "kill"]][# "sp"];
  } else if(isDefined(self.archetype) && isDefined(level.var_c44113ca[self.archetype])) {
    return level.var_c44113ca[self.archetype];
  }

  return 0;
}

function function_a3d16ee5(s_params) {
  if(isDefined(self.score_event) && isPlayer(s_params.eattacker)) {
    scoreevents::processscoreevent(self.score_event, s_params.eattacker, undefined, s_params.weapon);
  }
}

function player_on_spawned() {
  util::wait_network_frame();

  if(isDefined(self)) {
    self.var_42dd3eba = 0;
    self.ready_for_score_events = 1;
  }
}

function score_cf_register_info(name, version, max_count) {
  for(i = 0; i < 5; i++) {
    clientfield::function_5b7d846d("PlayerList.client" + i + ".score_cf_" + name, version, getminbitcountfornum(max_count), "counter");
  }
}

function score_cf_increment_info(name, var_ce49f2dd = 0) {
  if(!var_ce49f2dd && self bgb::function_69b88b5()) {
    clientfield::increment_world_uimodel("PlayerList.client" + self.entity_num + ".score_cf_" + name);
  }
}

function player_add_points(event, mod, hit_location, e_target, zombie_team, damage_weapon, var_96054e3, var_e6e61503 = 0) {
  if(level.intermission) {
    return;
  }

  if(!zm_utility::is_player_valid(self, 0, var_96054e3)) {
    return;
  }

  player_points = 0;
  multiplier = get_points_multiplier(self);

  if(isDefined(level.a_func_score_events[event])) {
    player_points = [[level.a_func_score_events[event]]](event, mod, hit_location, zombie_team, damage_weapon);
  } else {
    switch (event) {
      case # "rebuild_board":
      case # "carpenter_powerup":
      case # "nuke_powerup":
      case # "reviver":
      case # "oracle_boon":
      case # "bonus_points_powerup":
        player_points = mod;
        break;
      case # "bonus_points_powerup_shared":
        player_points = mod;
        multiplier = 1;
        break;
      case # "damage_points":
        switch (mod) {
          case 10:
          case 20:
          case 30:
          case 40:
          case 50:
          case 60:
          case 70:
          case 80:
          case 90:
          case 100:
          case 110:
          case 120:
          case 130:
          case 140:
          case 150:
          case 160:
          case 170:
          case 180:
          case 190:
          case 200:
            player_points = mod;

            if(!function_e31cf9d5(event)) {
              if(mod > 90) {
                self score_cf_increment_info("damage" + 90, var_e6e61503);
              } else {
                self score_cf_increment_info("damage" + mod, var_e6e61503);
              }
            }

            break;
        }

        break;
      case # "death":
        player_points = e_target.var_f256a4d9;

        if(!isDefined(player_points)) {
          player_points = 0;
        }

        var_dd71ee3e = player_points;
        var_dc75a3a1 = 0;

        while(var_dd71ee3e > 0) {
          while(var_dc75a3a1 < level.var_697c8943.size && var_dd71ee3e < level.var_697c8943[var_dc75a3a1]) {
            var_dc75a3a1++;
          }

          if(var_dc75a3a1 == level.var_697c8943.size) {
            break;
          }

          var_dd71ee3e -= level.var_697c8943[var_dc75a3a1];

          if(!function_e31cf9d5(event)) {
            self score_cf_increment_info("damage" + level.var_697c8943[var_dc75a3a1], var_e6e61503);
          }
        }

        if(!function_e31cf9d5(event)) {
          player_points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon, player_points, var_e6e61503);
        }

        if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
          self zm_stats::increment_client_stat("grenade_kills");
          self zm_stats::increment_player_stat("grenade_kills");
        }

        break;
      case # "riotshield_fling":
        player_points = mod;

        if(!var_e6e61503) {
          scoreevents::processscoreevent("kill_rbz_zombie", self, undefined, damage_weapon);
        }

        break;
      case # "transform_kill":
        self score_cf_increment_info("transform_kill", var_e6e61503);

        if(!var_e6e61503) {
          scoreevents::processscoreevent("transform_kill", self, undefined, damage_weapon);
        }

        player_points = zombie_utility::get_zombie_var(#"hash_68aa9b4c8de33261");
        break;
      default:
        assert(0, "<dev string:x38>");
        break;
    }
  }

  if(isDefined(level.player_score_override)) {
    player_points = self[[level.player_score_override]](damage_weapon, player_points);
  }

  player_points = multiplier * zm_utility::round_up_score(player_points);

  if(isDefined(self.point_split_receiver) && event == "death") {
    split_player_points = player_points - zm_utility::round_up_score(player_points * self.point_split_keep_percent);
    self.point_split_receiver add_to_player_score(split_player_points);
    player_points -= split_player_points;
  }

  if(event === "rebuild_board") {
    level notify(#"rebuild_board", {
      #player: self, #points: player_points
    });
  }

  self add_to_player_score(player_points, 1, event, var_e6e61503);

  if(var_e6e61503 || is_true(level.var_894a83d8) || function_e31cf9d5(event)) {
    return;
  }

  self.pers[# "score"] = self.score;

  if(isDefined(level._game_module_point_adjustment)) {
    level[[level._game_module_point_adjustment]](self, zombie_team, player_points);
  }
}

function private function_e31cf9d5(str_score_event) {
  if(zm_trial_damage_drains_points::is_active(1) && (str_score_event === "death" || str_score_event === "damage_points")) {
    return true;
  }

  return false;
}

function get_points_multiplier(player) {
  multiplier = isDefined(player zombie_utility::get_zombie_var_player(#"zombie_point_scalar")) ? player zombie_utility::get_zombie_var_player(#"zombie_point_scalar") : zombie_utility::get_zombie_var_team(#"zombie_point_scalar", player.team);

  if(isDefined(level.current_game_module) && level.current_game_module == 2) {
    if(isDefined(level._race_team_double_points) && level._race_team_double_points == player._race_team) {
      return multiplier;
    } else {
      return 1;
    }
  }

  return multiplier;
}

function player_add_points_kill_bonus(mod, hit_location, weapon, player_points = undefined, var_e6e61503 = 0) {
  if(mod != "MOD_MELEE" && !is_true(level.is_survival)) {
    if("head" == hit_location || "helmet" == hit_location || "neck" == hit_location) {
      scoreevents::processscoreevent("headshot", self, undefined, weapon);
    } else {
      scoreevents::processscoreevent("kill_rbz_zombie", self, undefined, weapon);
    }
  }

  if(isDefined(level.player_score_override)) {
    new_points = self[[level.player_score_override]](weapon, player_points);

    if(new_points > 0 && new_points != player_points) {
      return new_points;
    }
  }

  if(mod == "MOD_MELEE" && (!isDefined(weapon) || !weapon.isriotshield && !zm_loadout::is_hero_weapon(weapon))) {
    self score_cf_increment_info("death_melee", var_e6e61503);

    if(!is_true(level.is_survival)) {
      scoreevents::processscoreevent("melee_kill", self, undefined, weapon);
    }

    return zombie_utility::get_zombie_var(#"zombie_score_bonus_melee");
  }

  if(isDefined(player_points)) {
    score = player_points;
  } else {
    score = 0;
  }

  if(isDefined(hit_location)) {
    switch (hit_location) {
      case # "head":
      case # "helmet":
      case # "neck":
        self score_cf_increment_info("death_head", var_e6e61503);
        score = zombie_utility::get_zombie_var(#"zombie_score_bonus_head");
        break;
      default:
        break;
    }
  }

  return score;
}

function player_reduce_points(event, n_amount) {
  if(level.intermission || zm_utility::is_standard()) {
    return;
  }

  points = 0;

  switch (event) {
    case # "take_all":
      points = self.score;
      break;
    case # "take_half":
      points = int(self.score / 2);
      break;
    case # "take_specified":
      points = n_amount;
      break;
    case # "no_revive_penalty":
      if(zm_custom::function_901b751c(#"zmpointlossonteammatedeath")) {
        percent = zm_custom::function_901b751c(#"zmpointlossonteammatedeath") / 100;
        points = self.score * percent;
      } else if(level.round_number >= 50) {
        percent = zombie_utility::get_zombie_var(#"penalty_no_revive");
        points = self.score * percent;
      }

      break;
    case # "died":
      if(zm_custom::function_901b751c(#"zmpointlossondeath")) {
        percent = zm_custom::function_901b751c(#"zmpointlossondeath") / 100;
        points = self.score * percent;
      } else if(level.round_number >= 50) {
        percent = zombie_utility::get_zombie_var(#"penalty_died");
        points = self.score * percent;
      }

      break;
    case # "downed":
      if(level.round_number < 50 && !zm_custom::function_901b751c(#"zmpointlossondown")) {
        percent = 0;
      } else if(zm_custom::function_901b751c(#"zmpointlossondown")) {
        percent = zm_custom::function_901b751c(#"zmpointlossondown") / 100;
      } else {
        percent = zombie_utility::get_zombie_var(#"penalty_downed");
        step = zombie_utility::get_zombie_var(#"hash_3037a1f286b662e6");

        if(step > 0) {
          percent *= int(self.score / step);
        }

        if(percent > 0.5) {
          percent = 0.5;
        }
      }

      self notify(#"i_am_down");
      points = self.score * percent;
      self.score_lost_when_downed = zm_utility::round_up_to_ten(int(points));
      break;
    case # "points_lost_on_hit_percent":
      points = self.score * n_amount;
      break;
    case # "points_lost_on_hit_value":
      points = n_amount;
      break;
    default:
      assert(0, "<dev string:x38>");
      break;
  }

  points = self.score - zm_utility::round_up_to_ten(int(points));

  if(points < 0) {
    points = 0;
  }

  if(points > 4000000) {
    points = 4000000;
  }

  self.score = points;
  self notify(#"reduced_points", {
    #str_reason: event
  });
}

function add_to_player_score(points, b_add_to_total = 1, str_awarded_by = "", var_e6e61503 = 0) {
  if(!isDefined(points) || level.intermission || !is_true(level.var_d6031813)) {
    return;
  }

  assert(isPlayer(self), "<dev string:x4f>");
  points = zm_utility::round_up_score(points);

  if(is_true(level.var_894a83d8) || var_e6e61503 || function_e31cf9d5(str_awarded_by)) {
    return;
  }

  n_points_to_add_to_currency = bgb::add_to_player_score_override(points, str_awarded_by);
  self.score += n_points_to_add_to_currency;

  if(self.score > 4000000) {
    self.score = 4000000;
  }

  self.pers[# "score"] = self.score;
  self incrementplayerstat("scoreEarned", n_points_to_add_to_currency);
  self zm_stats::function_301c4be2("boas_scoreEarned", n_points_to_add_to_currency);
  self zm_stats::function_c0c6ab19(#"zearned", n_points_to_add_to_currency, 1);
  level notify(#"earned_points", {
    #player: self, #points: points
  });
  self contracts::increment_zm_contract(#"contract_zm_points", n_points_to_add_to_currency, #"zstandard");
  self stats::function_dad108fa(#"hash_6a861f1323ce4ae9", n_points_to_add_to_currency);
  self zm_stats::function_fbce465a(#"hash_76bf5af08a08d8fe", n_points_to_add_to_currency);
  self zm_stats::function_fbce465a(#"hash_3d915bbfdb0453ba", n_points_to_add_to_currency);
  self zm_stats::function_17ee4529(#"hash_5a974e436e73bc2", n_points_to_add_to_currency, #"hash_6abe83944d701459");

  if(zm_utility::is_standard()) {
    self zm_stats::function_c0c6ab19(#"rush_points", n_points_to_add_to_currency);
  }

  if(b_add_to_total) {
    self.score_total += points;
    level.score_total += points;
  }

  if(!isDefined(self.var_42dd3eba)) {
    self.var_42dd3eba = 0;
  }

  if(!isDefined(self.var_93369bb6)) {
    self.var_93369bb6 = 0;
  }

  if(!isDefined(self.var_2e139723)) {
    self.var_2e139723 = 0;
  }

  self.var_42dd3eba += points;
  self.var_93369bb6 += points;

  if(self.var_93369bb6 > 25000) {
    self.var_93369bb6 = 0;
    self zm_stats::function_fbce465a(#"hash_24abad59aafa4b84");
  }

  self.var_2e139723 += points;

  if(self.var_2e139723 > 35000) {
    self.var_2e139723 = 0;
    self zm_stats::function_fbce465a(#"hash_3a26c1202d86e50e");
  }

  self notify(#"earned_points", {
    #n_points: points, #str_awarded_by: str_awarded_by
  });
}

function minus_to_player_score(points, b_forced = 0) {
  if(!isDefined(points) || level.intermission) {
    return;
  }

  if(self bgb::is_enabled(#"zm_bgb_shopping_free") && !b_forced) {
    self notify(#"hash_14b0ad44336160bc");
    self bgb::do_one_shot_use();
    self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
    return;
  }

  if(zm_utility::is_standard() && !b_forced) {
    return;
  }

  if(!b_forced) {
    self contracts::increment_zm_contract(#"contract_zm_points_spent", points);
  }

  self.score -= points;
  self zm_stats::function_7ec42fbf(#"hash_3c096a414d5b9096", points);
  self stats::function_dad108fa(#"hash_59d8674357c2b6de", points);
  self.pers[# "score"] = self.score;
  self incrementplayerstat("scoreSpent", points);
  self zm_stats::function_301c4be2("boas_scoreSpent", points);
  level notify(#"spent_points", {
    #player: self, #points: points
  });
  self notify(#"spent_points", {
    #points: points
  });
}

function add_to_team_score(points) {}

function minus_to_team_score(points) {}

function player_died_penalty() {
  players = getplayers(self.team);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player == self) {
      continue;
    }

    if(is_true(player.is_zombie)) {
      continue;
    }

    player player_reduce_points("no_revive_penalty");
  }
}

function player_downed_penalty() {
  println("<dev string:xa8>");
  self player_reduce_points("downed");
}

function can_player_purchase(n_cost, var_1c65f833 = 0) {
  if(self.score >= n_cost) {
    return true;
  }

  if(self bgb::is_enabled(#"zm_bgb_shopping_free")) {
    return true;
  }

  if(zm_utility::is_standard() && !var_1c65f833) {
    return true;
  }

  return false;
}

function on_item_pickup(s_params) {
  itementry = s_params.item.itementry;

  if(itementry.itemtype === # "survival_essence") {
    if(isPlayer(self)) {
      e_player = self;
    } else {
      e_player = s_params.player;
    }

    switch (itementry.name) {
      case # "resource_item_medium_harvesting_sr":
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: e_player, #scoreevent: "essence_pickup_medium"});
        break;
      case # "resource_item_harvesting_sr":
      case # "hash_69a628368f8263f":
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: e_player, #scoreevent: "essence_pickup_large"});
        break;
      default:
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: e_player, #scoreevent: "essence_pickup_small"});
        break;
    }
  }
}

function function_5f41330c() {
  return isDefined(self.score_events[# "assist"]) && isDefined(level.scoreinfo[self.score_events[# "assist"]][# "sp"]) && level.scoreinfo[self.score_events[# "assist"]][# "sp"] > 0;
}

function function_82732ced() {
  if(isDefined(self.var_17a22c08)) {
    var_7afe66bc = self.var_17a22c08;
  } else {
    var_7afe66bc = self function_e5ca5733();

    if(!var_7afe66bc && !self function_5f41330c()) {
      assert(var_7afe66bc, "<dev string:xd5>" + function_9e72a96(self.archetype) + "<dev string:xf2>");
    }
  }

  self.var_f256a4d9 = var_7afe66bc;
  self.var_d8caf335 = var_7afe66bc != 0 ? max(1, int(self.maxhealth / var_7afe66bc * 0.1)) : 1;
  self.var_8d5c706f = [];
}

function function_89db94b3(e_attacker, n_damage, e_inflictor) {
  if(!isPlayer(e_attacker) || !isDefined(self.var_8d5c706f) || is_true(self.marked_for_death)) {
    return;
  }

  n_index = e_attacker.entity_num;

  if(!isDefined(n_index)) {
    return;
  }

  if(!isDefined(self.var_8d5c706f[n_index])) {
    self.var_8d5c706f[n_index] = 0;
  }

  var_20701980 = self.var_8d5c706f[n_index];
  var_810a69da = var_20701980 + n_damage;
  var_86e74a5c = int(var_20701980 / self.var_d8caf335);
  var_6fb77dc8 = int(var_810a69da / self.var_d8caf335);
  n_points = (var_6fb77dc8 - var_86e74a5c) * 10;

  if(n_points > self.var_f256a4d9) {
    n_points = self.var_f256a4d9;
  }

  if(is_true(e_attacker zombie_utility::get_zombie_var_player(#"zombie_insta_kill")) || is_true(zombie_utility::get_zombie_var_team(#"zombie_insta_kill", e_attacker.team))) {
    n_points = self.var_f256a4d9;
  }

  if(n_points) {
    if(isDefined(e_inflictor) && e_inflictor.subarchetype === # "zombie_wolf_ally") {
      e_attacker player_add_points("damage_points", 10, undefined, undefined, undefined, undefined, undefined, self.var_12745932);
      self.var_f256a4d9 -= n_points;
    } else {
      e_attacker player_add_points("damage_points", n_points, undefined, undefined, undefined, undefined, undefined, self.var_12745932);
      self.var_f256a4d9 -= n_points;
    }
  }

  self.var_8d5c706f[n_index] = var_810a69da;
}

function function_acaab828(b_disabled = 1) {
  if(isDefined(self)) {
    self.var_12745932 = b_disabled;
  }
}

function function_ffc2d0bc() {
  return self.pers[# "score"];
}

function function_c1f146ff(score) {
  self.pers[# "score"] = score;
  self.score = score;
}

function function_bc9de425(b_lowest_first = 0) {
  var_5e8a44f9 = [];
  var_e8d2685c = 0;

  foreach(player in getplayers()) {
    if(!isDefined(player.var_9fc3ee66)) {
      player.var_9fc3ee66 = -1;
    }

    if(!isDefined(player.var_a8da9faf)) {
      player.var_a8da9faf = -1;
    }

    if(!isDefined(var_5e8a44f9)) {
      var_5e8a44f9 = [];
    } else if(!isarray(var_5e8a44f9)) {
      var_5e8a44f9 = array(var_5e8a44f9);
    }

    var_5e8a44f9[var_5e8a44f9.size] = player.score;

    if(player.score > 0) {
      var_e8d2685c = 1;
    }
  }

  var_5e8a44f9 = array::sort_by_value(var_5e8a44f9, b_lowest_first);
  var_51639 = 0;
  var_694faff0 = -1;

  foreach(var_f0c1d3c2 in var_5e8a44f9) {
    if(var_e8d2685c && var_f0c1d3c2 != var_694faff0) {
      var_694faff0 = var_f0c1d3c2;
      var_51639++;
    } else {
      continue;
    }

    foreach(player in getplayers()) {
      if(player.score == var_f0c1d3c2) {
        player.var_a8da9faf = player.var_9fc3ee66;
        player.var_9fc3ee66 = var_51639;
        continue;
      }
    }
  }

  return var_5e8a44f9;
}