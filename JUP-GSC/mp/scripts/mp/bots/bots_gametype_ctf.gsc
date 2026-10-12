/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ctf.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;
#namespace bots_gametype_ctf;

function main() {
  setup_callbacks();
  setup_bot_ctf();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_ctf_think;
  level.bot_funcs["get_watch_node_chance"] = &bot_ctf_get_node_chance;
}

function setup_bot_ctf() {
  if(false) {
    level.var_5c7085cb60319b4 = 1;
  }

  level.bot_gametype_attacker_limit_for_team = &ctf_bot_attacker_limit_for_team;
  level.bot_gametype_defender_limit_for_team = &ctf_bot_defender_limit_for_team;
  level.bot_gametype_allied_attackers_for_team = &get_allied_attackers_for_team;
  level.bot_gametype_allied_defenders_for_team = &get_allied_defenders_for_team;
  level.bot_gametype_allowed_to_switch_to_defender = &bot_ctf_can_switch_to_defender;
  level.bot_gametype_human_player_always_attacker = &bot_ctf_player_always_attacker;
  bot_waittill_bots_enabled();

  while(!isDefined(level.teamflags)) {
    wait 0.05;
  }

  level.teamflags["allies"].objectivekey = "allies";
  level.teamflags["axis"].objectivekey = "axis";
  bot_cache_entrances_to_gametype_array(level.teamflags, "flag_");
  zone = getzonenearest(level.teamflags["allies"].curorigin);

  if(isDefined(zone)) {
    botzonesetteam(zone, "allies");
  }

  zone = getzonenearest(level.teamflags["axis"].curorigin);

  if(isDefined(zone)) {
    botzonesetteam(zone, "axis");
  }

  level.capzones["allies"].nearest_node = level.teamflags["allies"].trigger.nearest_node;
  level.capzones["axis"].nearest_node = level.teamflags["axis"].trigger.nearest_node;
  thread bot_ctf_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

function crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype)) {
    return 0;
  }

  if(bot_ctf_player_has_flag()) {
    return 0;
  }

  return bot_ctf_flag_is_home_of_team(self.team);
}

function bot_ctf_think() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self.next_flag_hide_time = 0;
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  set_scripted_pathing_style = 0;
  var_a4775e629f031993 = 0;

  for(;;) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      bot_gametype_initialize_attacker_defender_role();
    }

    enemy_team = getotherteam(self.team)[0];

    if(bot_ctf_flag_is_home_of_team(self.team)) {
      if(isDefined(level.bot_known_flag_carrier_loc) && isDefined(level.bot_known_flag_carrier_loc[enemy_team])) {
        level.bot_known_flag_carrier_loc[enemy_team] = undefined;
      }
    }

    sprint_desired = 0;

    if(self.role == "attacker") {
      if(bot_ctf_player_has_flag()) {
        sprint_desired = 1;
      } else if(!bot_ctf_enemy_team_flag_is_picked_up()) {
        sprint_desired = distancesquared(self.origin, level.teamflags[enemy_team].curorigin) < squared(get_flag_protect_radius());
      }
    } else if(!bot_ctf_flag_is_home_of_team(self.team)) {
      sprint_desired = !bot_ctf_my_team_flag_is_picked_up();
    }

    self botsetflag("force_sprint", sprint_desired);
    var_a4775e629f031993 = 0;

    if(bot_ctf_player_has_flag()) {
      if(bot_ctf_flag_is_home_of_team(self.team)) {
        clear_defend();
        var_a4775e629f031993 = 1;

        if(!set_scripted_pathing_style) {
          set_scripted_pathing_style = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(bot_gametype_get_num_players_on_team(self.team) == 1) {
        bot_ctf_recover_flag();
      } else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        nodes = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        hide_node = self botnodepick(nodes, nodes.size * 0.15, "node_hide_anywhere");

        if(!isDefined(hide_node)) {
          hide_node = level.capzones[self.team].nearest_node;
        }

        assert(isDefined(hide_node));
        success = self botsetscriptgoalnode(hide_node, "critical");

        if(success) {
          self.next_flag_hide_time = gettime() + 15000;
        }
      }
    } else if(self.role == "attacker") {
      if(bot_ctf_enemy_team_flag_is_picked_up()) {
        if(!bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          var_85ba43086f4dde82 = level.teamflags[enemy_team].carrier;
          bot_guard_player(var_85ba43086f4dde82, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical") {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(level.teamflags[enemy_team].curorigin, 16, "objective", undefined, 300);
      }
    } else {
      assert(self.role == "<dev string:x1c>");

      if(!bot_ctf_flag_is_home_of_team(self.team)) {
        bot_ctf_recover_flag();
      } else if(!is_protecting_flag()) {
        self botclearscriptgoal();
        optional_params["score_flags"] = "strict_los";
        optional_params["entrance_points_index"] = "flag_" + level.teamflags[self.team].objectivekey;
        optional_params["nearest_node_to_center"] = level.teamflags[self.team].trigger.nearest_node;
        bot_protect_point(level.teamflags[self.team].curorigin, get_flag_protect_radius(), optional_params);
      }
    }

    if(set_scripted_pathing_style && !var_a4775e629f031993) {
      set_scripted_pathing_style = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

function bot_ctf_recover_flag() {
  var_db965920aa486082 = undefined;
  my_flag = level.teamflags[self.team];
  flag_carrier = my_flag.carrier;

  if(!isDefined(flag_carrier)) {
    var_db965920aa486082 = my_flag.curorigin;
  } else if(self botcanseeentity(flag_carrier)) {
    var_db965920aa486082 = flag_carrier.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !bot_ctf_flag_is_home_of_team(self.team)) {
      if(!isDefined(level.bot_known_flag_carrier_loc)) {
        level.bot_known_flag_carrier_loc = [];
      }

      if(!isDefined(level.bot_known_flag_carrier_loc[flag_carrier.team])) {
        level.bot_known_flag_carrier_loc[flag_carrier.team] = [];
      }

      level.bot_known_flag_carrier_loc[flag_carrier.team]["origin"] = var_db965920aa486082;
      level.bot_known_flag_carrier_loc[flag_carrier.team]["time"] = gettime();
    }
  } else if(isDefined(my_flag.curcarrierorigin)) {
    if(isDefined(my_flag.compassicons["friendly"])) {
      if(my_flag.objidpingfriendly) {
        var_db965920aa486082 = my_flag.curcarrierorigin;
      } else {
        var_db965920aa486082 = flag_carrier.origin;
      }
    }
  } else {
    var_db965920aa486082 = my_flag.curorigin;
  }

  if(isDefined(var_db965920aa486082)) {
    clear_defend();
    self botsetscriptgoal(var_db965920aa486082, 16, "critical");
    return;
  }

  var_c74e2e565ee3fe18 = undefined;
  var_3ad830dc9d89106d = undefined;

  if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(isDefined(level.bot_known_flag_carrier_loc) && isDefined(level.bot_known_flag_carrier_loc[flag_carrier.team])) {
      var_3ad830dc9d89106d = gettime() - level.bot_known_flag_carrier_loc[flag_carrier.team]["time"];

      if(var_3ad830dc9d89106d < 10000) {
        var_c74e2e565ee3fe18 = level.bot_known_flag_carrier_loc[flag_carrier.team]["origin"];
      }
    }
  }

  if(isDefined(var_c74e2e565ee3fe18)) {
    if(var_3ad830dc9d89106d < 5000) {
      clear_defend();
      self botsetscriptgoal(var_c74e2e565ee3fe18, 16, "critical");
    } else if(!bot_is_patrolling()) {
      bot_defend_stop();
      bot_patrol_area(var_c74e2e565ee3fe18, 400);
    }

    return;
  }

  clear_defend();
  var_e7073093c8c51701 = self botgetscriptgoaltype();

  if(var_e7073093c8c51701 == "objective" || var_e7073093c8c51701 == "critical") {
    self botclearscriptgoal();
  }

  update_personality_default();
}

function clear_defend() {
  if(bot_is_defending()) {
    bot_defend_stop();
  }
}

function is_protecting_flag() {
  return bot_is_protecting();
}

function get_flag_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    worldbounds = self botgetworldsize();
    average_side = (worldbounds[0] + worldbounds[1]) / 2;
    level.protect_radius = min(800, average_side / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

function ctf_bot_attacker_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);

  if(team_limit == 1) {
    return 1;
  }

  if(bot_ctf_flag_is_home_of_team(team)) {
    var_5995918ec569a5b3 = team_limit * 0.67;
  } else {
    enemy_team = getotherteam(team)[0];

    if(bot_ctf_flag_is_home_of_team(enemy_team)) {
      var_5995918ec569a5b3 = team_limit * 0.5;
    } else {
      var_5995918ec569a5b3 = team_limit * 0.4;
    }
  }

  var_363da16eb06140fe = int(roundup(var_5995918ec569a5b3));
  my_score = game["teamScores"][team];
  enemy_score = game["teamScores"][get_enemy_team(team)];

  if(my_score + 1 < enemy_score) {
    var_363da16eb06140fe = int(min(var_363da16eb06140fe + 1, team_limit));
  }

  return var_363da16eb06140fe;
}

function ctf_bot_defender_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);
  return team_limit - ctf_bot_attacker_limit_for_team(team);
}

function get_allied_attackers_for_team(team) {
  return bot_gametype_get_allied_attackers_for_team(team, level.capzones[team].curorigin, get_flag_protect_radius());
}

function get_allied_defenders_for_team(team) {
  return bot_gametype_get_allied_defenders_for_team(team, level.capzones[team].curorigin, get_flag_protect_radius());
}

function bot_ctf_ai_director_update() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread bot_gametype_attacker_defender_ai_director_update();
}

function bot_ctf_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!is_protecting_flag()) {
    return 1;
  }

  var_4db0bb626fc52479 = node node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(var_4db0bb626fc52479) {
    return 1;
  }

  return 0.2;
}

function bot_ctf_flag_is_home_of_team(team) {
  return level.teamflags[team] scripts\mp\gameobjects::ishome();
}

function bot_ctf_flag_picked_up_of_team(team) {
  return isDefined(level.teamflags[team].carrier);
}

function bot_ctf_my_team_flag_is_picked_up() {
  return bot_ctf_flag_picked_up_of_team(self.team);
}

function bot_ctf_enemy_team_flag_is_picked_up() {
  enemy_team = getotherteam(self.team)[0];
  return bot_ctf_flag_picked_up_of_team(enemy_team);
}

function bot_ctf_player_has_flag() {
  return isDefined(self.carryflag);
}

function bot_ctf_can_switch_to_defender() {
  if(bot_ctf_player_has_flag()) {
    return false;
  }

  return true;
}

function bot_ctf_player_always_attacker() {
  if(bot_ctf_player_has_flag()) {
    return true;
  }

  return false;
}