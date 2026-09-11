/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ctf.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_bot_ctf();
}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_ctf_think;
  level.bot_funcs["get_watch_node_chance"] = &cyberteamspawnsetids;
}

function setup_bot_ctf() {
  level.damage_stage_final_watcher = &initcircledata;
  level.damage_taken = &initcirclepoststarttocircleindex;
  level.damage_players_on_blades = &get_allied_attackers_for_team;
  level.damage_players_on_bottom = &get_allied_defenders_for_team;
  level.damage_players_when_enter_trigger = &customturret;
  level.damagefactor = &cypher_current_string;
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.teamflags)) {
    wait 0.05;
  }

  level.teamflags["allies"].objectivekey = "allies";
  level.teamflags["axis"].objectivekey = "axis";
  scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(level.teamflags, "flag_");
  var_0 = getzonenearest(level.teamflags["allies"].curorigin);

  if(isDefined(var_0)) {
    botzonesetteam(var_0, "allies");
  }

  var_0 = getzonenearest(level.teamflags["axis"].curorigin);

  if(isDefined(var_0)) {
    botzonesetteam(var_0, "axis");
  }

  level.capzones["allies"].nearest_node = level.teamflags["allies"].trigger.nearest_node;
  level.capzones["axis"].nearest_node = level.teamflags["axis"].trigger.nearest_node;
  thread customspeed();
  level.bot_gametype_precaching_done = 1;
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(cypher_iconid()) {
    return 0;
  }

  return cutscenedone(self.team);
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
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      scripts\mp\bots\bots_gametype_common::damagepercent();
    }

    var_2 = scripts\mp\utility\game::getotherteam(self.team)[0];

    if(cutscenedone(self.team)) {
      if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var_2])) {
        level.deactivate_laser_trap_parent[var_2] = undefined;
      }
    }

    var_3 = 0;

    if(self.role == "attacker") {
      if(cypher_iconid()) {
        var_3 = 1;
      } else if(!customusefunc()) {
        var_3 = distancesquared(self.origin, level.teamflags[var_2].curorigin) < squared(get_flag_protect_radius());
      }
    } else if(!cutscenedone(self.team)) {
      var_3 = !cycle_thrust_fx();
    }

    self botsetflag("force_sprint", var_3);
    var_1 = 0;

    if(cypher_iconid()) {
      if(cutscenedone(self.team)) {
        clear_defend();
        var_1 = 1;

        if(!var_0) {
          var_0 = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(self.team) == 1) {
        cypher_id_pool();
      } else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        var_4 = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        var_5 = self botnodepick(var_4, var_4.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var_5)) {
          var_5 = level.capzones[self.team].nearest_node;
        }

        var_6 = self botsetscriptgoalnode(var_5, "critical");

        if(var_6) {
          self.next_flag_hide_time = gettime() + 15000;
        }
      }
    } else if(self.role == "attacker") {
      if(customusefunc()) {
        if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          var_7 = level.teamflags[var_2].carrier;
          scripts\mp\bots\bots_strategy::bot_guard_player(var_7, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical") {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(level.teamflags[var_2].curorigin, 16, "objective", undefined, 300);
      }
    } else if(!cutscenedone(self.team)) {
      cypher_id_pool();
    } else if(!is_protecting_flag()) {
      self botclearscriptgoal();
      GscBinSkip1(0x45, "score_flags", "strict_los");
    }

    if(var_0 && !var_1) {
      var_0 = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

function cypher_id_pool() {
  var_0 = undefined;
  var_1 = level.teamflags[self.team];
  var_2 = var_1.carrier;

  if(!isDefined(var_2)) {
    var_0 = var_1.curorigin;
  } else if(self botcanseeentity(var_2)) {
    var_0 = var_2.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !cutscenedone(self.team)) {
      if(!isDefined(level.deactivate_laser_trap_parent)) {
        level.deactivate_laser_trap_parent = [];
      }

      if(!isDefined(level.deactivate_laser_trap_parent[var_2.team])) {
        level.deactivate_laser_trap_parent[var_2.team] = [];
      }

      level.deactivate_laser_trap_parent[var_2.team]["origin"] = var_0;
      level.deactivate_laser_trap_parent[var_2.team]["time"] = gettime();
    }
  } else if(isDefined(var_1.curcarrierorigin)) {
    if(isDefined(var_1.compassicons["friendly"])) {
      if(var_1.objidpingfriendly) {
        var_0 = var_1.curcarrierorigin;
      } else {
        var_0 = var_2.origin;
      }
    }
  } else {
    var_0 = var_1.curorigin;
  }

  if(isDefined(var_0)) {
    clear_defend();
    self botsetscriptgoal(var_0, 16, "critical");
    return;
  }

  var_3 = undefined;
  var_4 = undefined;

  if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var_2.team])) {
      var_4 = gettime() - level.deactivate_laser_trap_parent[var_2.team]["time"];

      if(var_4 < 10000) {
        var_3 = level.deactivate_laser_trap_parent[var_2.team]["origin"];
      }
    }
  }

  if(isDefined(var_3)) {
    if(var_4 < 5000) {
      clear_defend();
      self botsetscriptgoal(var_3, 16, "critical");
      return;
    }

    if(!scripts\mp\bots\bots_util::bot_is_patrolling()) {
      scripts\mp\bots\bots_strategy::bot_defend_stop();
      scripts\mp\bots\bots_strategy::bot_patrol_area(var_3, 400);
      return;
    }

    return;
  }

  clear_defend();
  var_5 = self botgetscriptgoaltype();

  if(var_5 == "objective" || var_5 == "critical") {
    self botclearscriptgoal();
  }

  scripts\mp\bots\bots_personality::update_personality_default();
}

function clear_defend() {
  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    return;
  }
}

function is_protecting_flag() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function get_flag_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(800, var_1 / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

function initcircledata(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(var_0);

  if(var_1 == 1) {
    return 1;
  }

  jumpiffalse(cutscenedone(var_0)) LOC_0000002c;
  var_2 = var_1 * 0.67;
  goto LOC_0000005a;
}

function initcirclepoststarttocircleindex(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(var_0);
  return var_1 - initcircledata(var_0);
}

function get_allied_attackers_for_team(var_0) {
  return scripts\mp\bots\bots_gametype_common::damageby(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

function get_allied_defenders_for_team(var_0) {
  return scripts\mp\bots\bots_gametype_common::damageclonewatch(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

function customspeed() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread scripts\mp\bots\bots_gametype_common::damage_shield_reduction();
}

function cyberteamspawnsetids(var_0) {
  if(var_0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!is_protecting_flag()) {
    return 1;
  }

  var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(var_1) {
    return 1;
  }

  return 0.2;
}

function cutscenedone(var_0) {
  return level.teamflags[var_0] scripts\mp\gameobjects::ishome();
}

function cyber_bot_pickup_emp(var_0) {
  return isDefined(level.teamflags[var_0].carrier);
}

function cycle_thrust_fx() {
  return cyber_bot_pickup_emp(self.team);
}

function customusefunc() {
  var_0 = scripts\mp\utility\game::getotherteam(self.team)[0];
  return cyber_bot_pickup_emp(var_0);
}

function cypher_iconid() {
  return isDefined(self.carryflag);
}

function customturret() {
  if(cypher_iconid()) {
    return false;
  }

  return true;
}

function cypher_current_string() {
  if(cypher_iconid()) {
    return true;
  }

  return false;
}