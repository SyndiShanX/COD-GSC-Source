/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_tdef.gsc
**************************************************/

function main() {
  setup_callbacks();
  ref_131DE();
  thread ref_11CDD();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &debug_bunkerpuzzledebugdraw;
}

function ref_131DE() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread damage_per_second();
  level.bot_gametype_precaching_done = 1;
}

function dangernotifyplayer() {
  return level.keeprightdooropen;
}

function damageskipburndownhigh() {
  if(isDefined(level.keeprightdooropen.carrier)) {
    return level.keeprightdooropen.carrier;
  }

  return undefined;
}

function bot_get_enemy_team() {
  if(self.team == "allies") {
    return "axis";
  }

  return "allies";
}

function debug_bunkerpuzzledebugdraw() {
  self notify("bot_flag_think");
  self endon("bot_flag_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      thirdpersonheightoffset();
      var_0 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      var_0 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      var_0 = undefined;
      player_has_minigun("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        var_2 = 0;

        if(isDefined(self.enemy)) {
          var_2 = distancesquared(self.enemy.origin, self.origin);
        }

        if(isDefined(self.enemy) && var_2 < 9216) {}

        self botclearscriptgoal();

        if(!isDefined(var_1)) {
          var_1 = gettime() + randomintrange(500, 1000);
        }

        if(gettime() > var_1) {
          var_1 = gettime() + randomintrange(500, 1000);
        }
      } else {
        var_3 = dangernotifyplayer();

        if(!isDefined(var_3)) {
          var_4 = damageskipburndownhigh();

          if(isDefined(var_4) && var_4 != self) {
            thirdpersonheightoffset();
          }
        } else {
          self botsetscriptgoal(var_4.curorigin, 16, "objective");
          continue;
        }
      }
    } else {
      var_0 = undefined;
    }

    if(self.role == "attacker") {
      var_3 = dangernotifyplayer();

      if(!isDefined(var_3)) {
        var_4 = damageskipburndownhigh();

        if(isDefined(var_4)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(var_4)) {
            scripts\mp\bots\bots_strategy::bot_guard_player(var_4, level.bodyguard_radius);
          }
        }
      } else if(!istrue(var_3.isresetting) && !istrue(var_3.in_goal)) {
        var_5 = getclosestpointonnavmesh(var_3.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_5)) {
          scripts\mp\bots\bots_strategy::bot_protect_point(var_5, level.protect_radius);
        }
      }

      continue;
    }

    if(self.role == "defender") {
      var_6 = level.keeprightdooropen.carrier;
      var_7 = var_6.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_7)) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var_7, level.protect_radius);
      }
    }
  }
}

function thirdpersonheightoffset() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = player_grenade_fire_monitor(self.team);
  var_3 = player_gun_game_next_weapon_think(self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "stationary") {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        player_has_minigun("attacker");
        return;
      }

      player_has_minigun("defender");
      return;
    }

    player_has_minigun("attacker");
    return;
  }

  if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "active") {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        player_has_minigun("defender");
        return;
      }

      player_has_minigun("attacker");
      return;
    }

    player_has_minigun("defender");
    return;
  }
}

function damage_per_second() {
  level notify("bot_flag_ai_director_update");
  level endon("bot_flag_ai_director_update");
  level endon("game_ended");
  GscBinSkip1(0x45, 0, "allies");
}

function player_grenade_fire_monitor(var_0) {
  var_1 = player_gun_game_randomize_weapon_list_think(var_0);
  return var_1;
}

function player_gun_game_next_weapon_think(var_0) {
  return false;
}

function player_gun_game_randomize_weapon_list_think(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function ref_12335(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(var_5.team != var_0) {
      continue;
    }

    if(!isalive(var_5)) {
      continue;
    }

    if(!isai(var_5)) {
      continue;
    }

    if(isDefined(var_5.role) && var_5.role == "defender") {
      continue;
    }

    var_6 = distancesquared(var_5.origin, var_1.curorigin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

function get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("attacker", var_0);
  return var_1;
}

function get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("defender", var_0);
  return var_1;
}

function player_has_minigun(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function ref_11CDD() {
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    var_1 = damageskipburndownhigh();

    if(!isDefined(var_0) || !isDefined(var_1) || var_1 != var_0) {
      if(isDefined(var_0) && var_0.threatbias == 505) {
        var_0.threatbias = 0;
      }

      var_0 = var_1;
    }

    if(isDefined(var_1) && var_1.threatbias == 0) {
      var_1.threatbias = 505;
    }

    wait 0.05;
  }
}