/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_infect.gsc
****************************************************/

function main() {
  setup_callbacks();
  setup_bot_infect();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_infect_think;
  level.bot_funcs["should_pickup_weapons"] = &bot_should_pickup_weapons_infect;
}

function setup_bot_infect() {
  level.bots_gametype_handles_class_choice = 1;
  level.bots_ignore_team_balance = 1;
  level.bots_gametype_handles_team_choice = 1;
  thread bot_infect_ai_director_update();
}

function bot_should_pickup_weapons_infect() {
  if(level.infect_chosefirstinfected && self.team == "axis") {
    return 0;
  }

  return scripts\mp\bots\bots::bot_should_pickup_weapons();
}

function bot_infect_think() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  GscBinSkip4(0x35);
}

function bot_infect_ai_director_update() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");

  for(;;) {
    var0 = [];
    var1 = [];

    foreach(var3 in level.players) {
      if(!isDefined(var3.initial_spawn_time) && var3.health > 0 && isDefined(var3.team) && (var3.team == "allies" || var3.team == "axis")) {
        var3.initial_spawn_time = gettime();
      }

      if(isDefined(var3.initial_spawn_time) && gettime() - var3.initial_spawn_time > 5000) {
        if(!isDefined(var3.team)) {
          continue;
        }

        if(var3.team == "axis") {
          var0 = var3;
          continue;
        }

        if(var3.team == "allies") {
          var1 = var3;
        }
      }
    }

    if(var0.size > 0 && var1.size > 0) {
      var5 = 1;

      foreach(var8, var7 in var1) {
        if(isbot(var7)) {
          var5 = 0;
        }
      }

      if(var5) {
        foreach(var3 in var1) {
          if(!isDefined(var3.last_infected_hiding_time)) {
            var3.last_infected_hiding_time = gettime();
            var3.last_infected_hiding_loc = var3.origin;
            var3.time_spent_hiding = 0;
          }

          if(gettime() >= var3.last_infected_hiding_time + 5000) {
            var3.last_infected_hiding_time = gettime();
            var10 = distancesquared(var3.origin, var3.last_infected_hiding_loc);
            var3.last_infected_hiding_loc = var3.origin;

            if(var10 < 90000) {
              var3.time_spent_hiding += 5000;

              if(var3.time_spent_hiding >= 20000) {
                var11 = scripts\engine\utility::get_array_of_closest(var3.origin, var0);

                foreach(var13 in var11) {
                  if(isbot(var13)) {
                    var14 = var13 botgetscriptgoaltype();

                    if(var14 != "tactical" && var14 != "critical") {
                      thread hunt_human(var13);
                      break;
                    }
                  }
                }

                var11 = undefined;
                var13 = undefined;
              }
            } else {
              var2.time_spent_hiding = 0;
              var2.last_infected_hiding_loc = var2.origin;
            }
          }
        }

        var8 = undefined;
        var9 = undefined;
      }
    }

    wait 1;
  }
}

function hunt_human(var0) {
  self endon("death_or_disconnect");
  self botsetscriptgoal(var0.origin, 0, "critical");
  scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
  self botclearscriptgoal();
}

function bot_infect_retrieve_knife() {
  if(self.team == "axis") {
    self.can_melee_enemy_time = 0;
    self.melee_enemy = undefined;
    self.melee_enemy_node = undefined;
    self.melee_enemy_new_node_time = 0;
    self.melee_self_node = undefined;
    self.melee_self_new_node_time = 0;
    var0 = self botgetdifficultysetting("throwKnifeChance");

    if(var0 < 0.25) {
      self botsetdifficultysetting("throwKnifeChance", 0.25);
    }

    self botsetdifficultysetting("allowGrenades", 1);

    for(;;) {
      if(self hasweapon("throwingknife_mp")) {
        if(scripts\mp\utility\entity::isgameparticipant(self.enemy)) {
          var1 = gettime();

          if(!isDefined(self.melee_enemy) || self.melee_enemy != self.enemy) {
            self.melee_enemy = self.enemy;
            self.melee_enemy_node = self.enemy getnearestnode();
            self.melee_enemy_new_node_time = var1;
          } else {
            var2 = squared(self botgetdifficultysetting("meleeDist"));

            if(distancesquared(self.enemy.origin, self.origin) <= var2) {
              self.can_melee_enemy_time = var1;
            }

            var3 = self.enemy getnearestnode();
            var4 = self getnearestnode();

            if(!isDefined(self.melee_enemy_node) || self.melee_enemy_node != var3) {
              self.melee_enemy_new_node_time = var1;
              self.melee_enemy_node = var3;
            }

            if(!isDefined(self.melee_self_node) || self.melee_self_node != var4) {
              self.melee_self_new_node_time = var1;
              self.melee_self_node = var4;
            } else if(distancesquared(self.origin, self.melee_self_node.origin) > 9216) {
              self.melee_self_at_same_node_time = var1;
            }

            if(self.can_melee_enemy_time + 3000 < var1) {
              if(self.melee_self_new_node_time + 3000 < var1) {
                if(self.melee_enemy_new_node_time + 3000 < var1) {
                  if(bot_infect_angle_too_steep_for_knife_throw(self.origin, self.enemy.origin)) {
                    scripts\mp\bots\bots_util::bot_queued_process("find_node_can_see_ent", &bot_infect_find_node_can_see_ent, self.enemy, self.melee_self_node);
                  }

                  if(!self getammocount("throwingknife_mp")) {
                    self setweaponammoclip("throwingknife_mp", 1);
                  }

                  scripts\engine\utility::ref_143bf(30, "enemy");
                  self botclearscriptgoal();
                }
              }
            }
          }
        }
      }

      wait 0.25;
    }

    return;
  }
}

function bot_infect_angle_too_steep_for_knife_throw(var0, var1) {
  if(abs(var0[2] - var1[2]) > 56 && distance2dsquared(var0, var1) < 2304) {
    return true;
  }

  return false;
}

function bot_infect_find_node_can_see_ent(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  var2 = 0;

  if(issubstr(var1.type, "Begin")) {
    var2 = 1;
  }

  var3 = getlinkednodes(var1);

  if(isDefined(var3) && var3.size) {
    var4 = scripts\engine\utility::array_randomize(var3);

    foreach(var6 in var4) {
      if(var2 && issubstr(var6.type, "End")) {
        continue;
      }

      if(bot_infect_angle_too_steep_for_knife_throw(var6.origin, var0.origin)) {
        continue;
      }

      var7 = self getEye() - self.origin;
      var8 = var6.origin + var7;
      var9 = var0.origin;

      if(isPlayer(var0)) {
        var9 = var0 scripts\mp\utility\player::getstancecenter();
      }

      if(sighttracepassed(var8, var9, 0, self, var0)) {
        var10 = vectortoyaw(var9 - var8);
        self botsetscriptgoalnode(var6, "critical", var10);
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3);
        return;
      }

      wait 0.05;
    }

    var6 = undefined;
    var10 = undefined;
    return;
  }
}