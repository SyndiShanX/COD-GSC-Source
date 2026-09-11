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
  var0 = getzonenearest(level.teamflags["allies"].curorigin);

  if(isDefined(var0)) {
    botzonesetteam(var0, "allies");
  }

  var0 = getzonenearest(level.teamflags["axis"].curorigin);

  if(isDefined(var0)) {
    botzonesetteam(var0, "axis");
  }

  level.capzones["allies"].nearest_node = level.teamflags["allies"].trigger.nearest_node;
  level.capzones["axis"].nearest_node = level.teamflags["axis"].trigger.nearest_node;
  thread customspeed();
  level.bot_gametype_precaching_done = 1;
}

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
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
  var0 = 0;
  var1 = 0;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      scripts\mp\bots\bots_gametype_common::damagepercent();
    }

    var2 = scripts\mp\utility\game::getotherteam(self.team)[0];

    if(cutscenedone(self.team)) {
      if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var2])) {
        level.deactivate_laser_trap_parent[var2] = undefined;
      }
    }

    var3 = 0;

    if(self.role == "attacker") {
      if(cypher_iconid()) {
        var3 = 1;
      } else if(!customusefunc()) {
        var3 = distancesquared(self.origin, level.teamflags[var2].curorigin) < squared(get_flag_protect_radius());
      }
    } else if(!cutscenedone(self.team)) {
      var3 = !cycle_thrust_fx();
    }

    self botsetflag("force_sprint", var3);
    var1 = 0;

    if(cypher_iconid()) {
      if(cutscenedone(self.team)) {
        clear_defend();
        var1 = 1;

        if(!var0) {
          var0 = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(self.team) == 1) {
        cypher_id_pool();
      } else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        var4 = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        var5 = self botnodepick(var4, var4.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var5)) {
          var5 = level.capzones[self.team].nearest_node;
        }

        var6 = self botsetscriptgoalnode(var5, "critical");

        if(var6) {
          self.next_flag_hide_time = gettime() + 15000;
        }
      }
    } else if(self.role == "attacker") {
      if(customusefunc()) {
        if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          var7 = level.teamflags[var2].carrier;
          scripts\mp\bots\bots_strategy::bot_guard_player(var7, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical") {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(level.teamflags[var2].curorigin, 16, "objective", undefined, 300);
      }
    } else if(!cutscenedone(self.team)) {
      cypher_id_pool();
    } else if(!is_protecting_flag()) {
      self botclearscriptgoal();
      GscBinSkip1(0x45, "score_flags", "strict_los");
    }

    if(var0 && !var1) {
      var0 = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

function cypher_id_pool() {
  var0 = undefined;
  var1 = level.teamflags[self.team];
  var2 = var1.carrier;

  if(!isDefined(var2)) {
    var0 = var1.curorigin;
  } else if(self botcanseeentity(var2)) {
    var0 = var2.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !cutscenedone(self.team)) {
      if(!isDefined(level.deactivate_laser_trap_parent)) {
        level.deactivate_laser_trap_parent = [];
      }

      if(!isDefined(level.deactivate_laser_trap_parent[var2.team])) {
        level.deactivate_laser_trap_parent[var2.team] = [];
      }

      level.deactivate_laser_trap_parent[var2.team]["origin"] = var0;
      level.deactivate_laser_trap_parent[var2.team]["time"] = gettime();
    }
  } else if(isDefined(var1.curcarrierorigin)) {
    if(isDefined(var1.compassicons["friendly"])) {
      if(var1.objidpingfriendly) {
        var0 = var1.curcarrierorigin;
      } else {
        var0 = var2.origin;
      }
    }
  } else {
    var0 = var1.curorigin;
  }

  if(isDefined(var0)) {
    clear_defend();
    self botsetscriptgoal(var0, 16, "critical");
    return;
  }

  var3 = undefined;
  var4 = undefined;

  if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(isDefined(level.deactivate_laser_trap_parent) && isDefined(level.deactivate_laser_trap_parent[var2.team])) {
      var4 = gettime() - level.deactivate_laser_trap_parent[var2.team]["time"];

      if(var4 < 10000) {
        var3 = level.deactivate_laser_trap_parent[var2.team]["origin"];
      }
    }
  }

  if(isDefined(var3)) {
    if(var4 < 5000) {
      clear_defend();
      self botsetscriptgoal(var3, 16, "critical");
      return;
    }

    if(!scripts\mp\bots\bots_util::bot_is_patrolling()) {
      scripts\mp\bots\bots_strategy::bot_defend_stop();
      scripts\mp\bots\bots_strategy::bot_patrol_area(var3, 400);
      return;
    }

    return;
  }

  clear_defend();
  var5 = self botgetscriptgoaltype();

  if(var5 == "objective" || var5 == "critical") {
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
    var0 = self botgetworldsize();
    var1 = (var0[0] + var0[1]) / 2;
    level.protect_radius = min(800, var1 / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

function initcircledata(var0) {
  var1 = scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(var0);

  if(var1 == 1) {
    return 1;
  }

  jumpiffalse(cutscenedone(var0)) LOC_0000002c;
  var2 = var1 * 0.67;
  goto LOC_0000005a;
}

function initcirclepoststarttocircleindex(var0) {
  var1 = scripts\mp\bots\bots_gametype_common::damagedisabledfeedback(var0);
  return var1 - initcircledata(var0);
}

function get_allied_attackers_for_team(var0) {
  return scripts\mp\bots\bots_gametype_common::damageby(var0, level.capzones[var0].curorigin, get_flag_protect_radius());
}

function get_allied_defenders_for_team(var0) {
  return scripts\mp\bots\bots_gametype_common::damageclonewatch(var0, level.capzones[var0].curorigin, get_flag_protect_radius());
}

function customspeed() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread scripts\mp\bots\bots_gametype_common::damage_shield_reduction();
}

function cyberteamspawnsetids(var0) {
  if(var0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!is_protecting_flag()) {
    return 1;
  }

  var1 = var0 scripts\mp\bots\bots_util::node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(var1) {
    return 1;
  }

  return 0.2;
}

function cutscenedone(var0) {
  return level.teamflags[var0] scripts\mp\gameobjects::ishome();
}

function cyber_bot_pickup_emp(var0) {
  return isDefined(level.teamflags[var0].carrier);
}

function cycle_thrust_fx() {
  return cyber_bot_pickup_emp(self.team);
}

function customusefunc() {
  var0 = scripts\mp\utility\game::getotherteam(self.team)[0];
  return cyber_bot_pickup_emp(var0);
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