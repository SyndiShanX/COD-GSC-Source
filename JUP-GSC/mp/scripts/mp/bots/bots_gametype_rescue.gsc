/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_rescue.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#namespace bots_gametype_rescue;

function function_e45e46b7c35deadb() {}

function main() {
  setup_callbacks();
  function_a342a902f130ffd8();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_rescue_think;
}

function function_a342a902f130ffd8() {
  level.var_765b019e692c1beb = game["attackers"];
  level.var_350e53e094ac2a9f = game["defenders"];
  thread bot_rescue_ai_director_update();
}

function bot_rescue_think() {
  self notify("bot_rescue_think");
  self endon("bot_rescue_think");
  self endon("death_or_disconnect");
  self endon("revivedAlive");
  level endon("game_ended");
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    if(self.health <= 0 || istrue(self.liveragdoll)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self.role)) {
      function_a6592c048f7b884a();
    }

    if(!isDefined(self.var_1131c442fdb61642)) {
      self.var_1131c442fdb61642 = random(level.hostages);
    }

    if(isDefined(self.var_1131c442fdb61642) && self.var_1131c442fdb61642.interactteam == "none" && !isDefined(self.var_1131c442fdb61642.ownerteam)) {
      self.var_1131c442fdb61642 = random(level.hostages);
    }

    if(!isDefined(self.var_1131c442fdb61642)) {
      wait 0.05;
      continue;
    }

    if(self.team == level.var_765b019e692c1beb) {
      if(isDefined(self.var_1131c442fdb61642.carrier)) {
        clear_defend();

        if(isalive(self.var_1131c442fdb61642.carrier)) {
          self botsetscriptgoal(self.var_1131c442fdb61642.carrier.origin, 16, "critical");
        } else {
          self botsetscriptgoal(self.var_1131c442fdb61642.curorigin, 16, "critical");
        }
      } else if(!bot_is_defending_point(self.var_1131c442fdb61642.curorigin) && self.var_1131c442fdb61642.interactteam != "none") {
        optional_params["score_flags"] = "strict_los";
        self botclearscriptgoal();
        bot_protect_point(self.var_1131c442fdb61642.curorigin, level.protect_radius, optional_params);
      }
    } else if(self.team == level.var_350e53e094ac2a9f) {
      if(function_7eeb6264cce0f89f()) {
        if(!isDefined(self.var_11953c95b4bf4bcc)) {
          self.var_11953c95b4bf4bcc = random(level.extractzones);
        }

        clear_defend();
        self botsetscriptgoal(self.var_11953c95b4bf4bcc.curorigin, 16, "critical");
      } else if(isDefined(self.var_1131c442fdb61642.carrier)) {
        if(!bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          bot_guard_player(self.var_1131c442fdb61642.carrier, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical") {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(self.var_1131c442fdb61642.curorigin, 16, "objective", undefined, 50);
        result = bot_waittill_goal_or_fail();

        if(result == "goal") {
          self botpressbutton("use", 1);
          result = bot_usebutton_wait(1);
        }
      }
    }

    wait 0.05;
  }
}

function function_7eeb6264cce0f89f() {
  return istrue(self.hashostage);
}

function function_a6592c048f7b884a() {
  if(self.team == level.var_765b019e692c1beb) {
    bot_gametype_set_role("defender");
    return;
  }

  if(self.team == level.var_350e53e094ac2a9f) {
    bot_gametype_set_role("attacker");
  }
}

function function_4e910d37a5b529bf(hostage) {
  var_9e69834a9745a8b6 = [];
  var_1d98cb7c4cf3c277 = get_living_players_on_team(level.var_765b019e692c1beb);

  foreach(player in var_1d98cb7c4cf3c277) {
    if(isai(player) && isDefined(player.role) && player.role == "defender") {
      if(isDefined(player.var_1131c442fdb61642) && player.var_1131c442fdb61642 == hostage) {
        var_9e69834a9745a8b6 = array_add(var_9e69834a9745a8b6, player);
      }

      continue;
    }

    if(distancesquared(player.origin, hostage.curorigin) < level.protect_radius * level.protect_radius) {
      var_9e69834a9745a8b6 = array_add(var_9e69834a9745a8b6, player);
    }
  }

  return var_9e69834a9745a8b6;
}

function clear_defend() {
  if(bot_is_defending()) {
    bot_defend_stop();
  }
}

function bot_rescue_ai_director_update() {
  level notify("bot_rescue_ai_director_update");
  level endon("bot_rescue_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  while(true) {
    foreach(i in level.hostages) {
      foreach(j in level.hostages) {
        var_eaea273876fe3e3e = function_4e910d37a5b529bf(i);
        var_eaea263876fe3c0b = function_4e910d37a5b529bf(j);

        if(var_eaea273876fe3e3e.size > var_eaea263876fe3c0b.size + 1) {
          var_24050f51453437c9 = [];

          foreach(player in var_eaea273876fe3e3e) {
            if(isai(player)) {
              var_24050f51453437c9 = array_add(var_24050f51453437c9, player);
            }
          }

          if(var_24050f51453437c9.size > 0) {
            defender = random(var_24050f51453437c9);
            defender bot_defend_stop();
            defender.var_1131c442fdb61642 = j;
          }
        }
      }
    }

    wait 0.5;
  }
}