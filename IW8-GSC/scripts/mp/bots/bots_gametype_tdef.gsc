/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_tdef.gsc
**************************************************/

function main() {
  setup_callbacks();
  ref_131de();
  thread ref_11cdd();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &debug_bunkerpuzzledebugdraw;
}

function ref_131de() {
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
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      thirdpersonheightoffset();
      var0 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      var0 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      var0 = undefined;
      player_has_minigun("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        var2 = 0;

        if(isDefined(self.enemy)) {
          var2 = distancesquared(self.enemy.origin, self.origin);
        }

        if(isDefined(self.enemy) && var2 < 9216) {}

        self botclearscriptgoal();

        if(!isDefined(var1)) {
          var1 = gettime() + randomintrange(500, 1000);
        }

        if(gettime() > var1) {
          var1 = gettime() + randomintrange(500, 1000);
        }
      } else {
        var3 = dangernotifyplayer();

        if(!isDefined(var3)) {
          var4 = damageskipburndownhigh();

          if(isDefined(var4) && var4 != self) {
            thirdpersonheightoffset();
          }
        } else {
          self botsetscriptgoal(var4.curorigin, 16, "objective");
          continue;
        }
      }
    } else {
      var0 = undefined;
    }

    if(self.role == "attacker") {
      var3 = dangernotifyplayer();

      if(!isDefined(var3)) {
        var4 = damageskipburndownhigh();

        if(isDefined(var4)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(var4)) {
            scripts\mp\bots\bots_strategy::bot_guard_player(var4, level.bodyguard_radius);
          }
        }
      } else if(!istrue(var3.isresetting) && !istrue(var3.in_goal)) {
        var5 = getclosestpointonnavmesh(var3.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(var5)) {
          scripts\mp\bots\bots_strategy::bot_protect_point(var5, level.protect_radius);
        }
      }

      continue;
    }

    if(self.role == "defender") {
      var6 = level.keeprightdooropen.carrier;
      var7 = var6.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var7)) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var7, level.protect_radius);
      }
    }
  }
}

function thirdpersonheightoffset() {
  var0 = get_allied_attackers_for_team(self.team);
  var1 = get_allied_defenders_for_team(self.team);
  var2 = player_grenade_fire_monitor(self.team);
  var3 = player_gun_game_next_weapon_think(self.team);
  var4 = level.bot_personality_type[self.personality];

  if(var4 == "active") {
    if(var0.size >= var2) {
      var5 = 0;

      foreach(var7 in var0) {
        if(isai(var7) && level.bot_personality_type[var7.personality] == "stationary") {
          var7.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
        player_has_minigun("attacker");
        return;
      }

      player_has_minigun("defender");
      return;
    }

    player_has_minigun("attacker");
    return;
  }

  if(var4 == "stationary") {
    if(var1.size >= var3) {
      var5 = 0;

      foreach(var10 in var1) {
        if(isai(var10) && level.bot_personality_type[var10.personality] == "active") {
          var10.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
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

function player_grenade_fire_monitor(var0) {
  var1 = player_gun_game_randomize_weapon_list_think(var0);
  return var1;
}

function player_gun_game_next_weapon_think(var0) {
  return false;
}

function player_gun_game_randomize_weapon_list_think(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var3) && isDefined(var3.team) && var3.team == var0) {
      var1++;
    }
  }

  return var1;
}

function ref_12335(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.participants) {
    if(!isDefined(var5.team)) {
      continue;
    }

    if(var5.team != var0) {
      continue;
    }

    if(!isalive(var5)) {
      continue;
    }

    if(!isai(var5)) {
      continue;
    }

    if(isDefined(var5.role) && var5.role == "defender") {
      continue;
    }

    var6 = distancesquared(var5.origin, var1.curorigin);

    if(!isDefined(var3) || var6 < var3) {
      var3 = var6;
      var2 = var5;
    }
  }

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
}

function get_allied_attackers_for_team(var0) {
  var1 = get_players_by_role("attacker", var0);
  return var1;
}

function get_allied_defenders_for_team(var0) {
  var1 = get_players_by_role("defender", var0);
  return var1;
}

function player_has_minigun(var0) {
  self.role = var0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function get_players_by_role(var0, var1) {
  var2 = [];

  foreach(var4 in level.participants) {
    if(!isDefined(var4.team)) {
      continue;
    }

    if(isalive(var4) && scripts\mp\utility\entity::isteamparticipant(var4) && var4.team == var1 && isDefined(var4.role) && var4.role == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function ref_11cdd() {
  level endon("game_ended");
  var0 = undefined;

  for(;;) {
    var1 = damageskipburndownhigh();

    if(!isDefined(var0) || !isDefined(var1) || var1 != var0) {
      if(isDefined(var0) && var0.threatbias == 505) {
        var0.threatbias = 0;
      }

      var0 = var1;
    }

    if(isDefined(var1) && var1.threatbias == 0) {
      var1.threatbias = 505;
    }

    wait 0.05;
  }
}