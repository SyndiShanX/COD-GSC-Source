/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_infect.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_infect();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_infect_think;
  level.bot_funcs["_encstr_8252168E297F97F00D3748CB8040537BE0831F5F11D0E6B7"] = ::bot_should_pickup_weapons_infect;
}

setup_bot_infect() {
  level.bots_gametype_handles_class_choice = 1;
  level.bots_ignore_team_balance = 1;
  level.bots_gametype_handles_team_choice = 1;
  thread bot_infect_ai_director_update();
}

bot_should_pickup_weapons_infect() {
  if(level.infect_chosefirstinfected && self.team == "_encstr_8E8405EA382B2A")
    return 0;

  return scripts\mp\bots\bots::bot_should_pickup_weapons();
}

bot_infect_think() {
  self notify("_encstr_A11D11C47B3AFA969B66AC6C8EF5E80DB4E6AD");
  self endon("_encstr_A11D11C47B3AFA969B66AC6C8EF5E80DB4E6AD");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  childthread bot_infect_retrieve_knife();

  for(;;) {
    if(level.infect_chosefirstinfected) {
      if(self.team == "_encstr_8E8405EA382B2A" && self botgetpersonality() != "_encstr_BD560C63E89DE9BFF81D7747ADC0")
        scripts\mp\bots\bots_util::bot_set_personality("_encstr_BD560C63E89DE9BFF81D7747ADC0");
    }

    if(self.bot_team != self.team)
      self.bot_team = self.team;

    if(self.team == "_encstr_8E8405EA382B2A") {
      var_0 = scripts\mp\bots\bots_strategy::bot_melee_tactical_insertion_check();

      if(!isDefined(var_0) || var_0)
        self botclearscriptgoal();
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}

bot_infect_ai_director_update() {
  level notify("_encstr_86671E98DEE8F55ACD66AC1B8EAF2CA5FA915AC995B18EF6E4FAAE3823B01D95");
  level endon("_encstr_86671E98DEE8F55ACD66AC1B8EAF2CA5FA915AC995B18EF6E4FAAE3823B01D95");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = [];
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3.initial_spawn_time) && var_3.health > 0 && isDefined(var_3.team) && (var_3.team == "_encstr_9A8507BA4040188D08" || var_3.team == "_encstr_8E8405EA382B2A"))
        var_3.initial_spawn_time = gettime();

      if(isDefined(var_3.initial_spawn_time) && gettime() - var_3.initial_spawn_time > 5000) {
        if(!isDefined(var_3.team)) {
          continue;
        }
        if(var_3.team == "_encstr_8E8405EA382B2A") {
          var_0[var_0.size] = var_3;
          continue;
        }

        if(var_3.team == "_encstr_9A8507BA4040188D08")
          var_1[var_1.size] = var_3;
      }
    }

    if(var_0.size > 0 && var_1.size > 0) {
      var_5 = 1;

      foreach(var_7 in var_1) {
        if(isbot(var_7))
          var_5 = 0;
      }

      if(var_5) {
        foreach(var_3 in var_1) {
          if(!isDefined(var_3.last_infected_hiding_time)) {
            var_3.last_infected_hiding_time = gettime();
            var_3.last_infected_hiding_loc = var_3.origin;
            var_3.time_spent_hiding = 0;
          }

          if(gettime() >= var_3.last_infected_hiding_time + 5000) {
            var_3.last_infected_hiding_time = gettime();
            var_10 = distancesquared(var_3.origin, var_3.last_infected_hiding_loc);
            var_3.last_infected_hiding_loc = var_3.origin;

            if(var_10 < 90000) {
              var_3.time_spent_hiding = var_3.time_spent_hiding + 5000;

              if(var_3.time_spent_hiding >= 20000) {
                var_11 = scripts\engine\utility::get_array_of_closest(var_3.origin, var_0);

                foreach(var_13 in var_11) {
                  if(isbot(var_13)) {
                    var_14 = var_13 botgetscriptgoaltype();

                    if(var_14 != "_encstr_99C209E34FC743616118AB" && var_14 != "_encstr_99CC09DA9020C4ECD149AD") {
                      var_13 thread hunt_human(var_3);
                      break;
                    }
                  }
                }
              }
            } else {
              var_3.time_spent_hiding = 0;
              var_3.last_infected_hiding_loc = var_3.origin;
            }
          }
        }
      }
    }

    wait 1.0;
  }
}

hunt_human(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self botsetscriptgoal(var_0.origin, 0, "_encstr_99CC09DA9020C4ECD149AD");
  scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
  self botclearscriptgoal();
}

bot_infect_retrieve_knife() {
  if(self.team == "_encstr_8E8405EA382B2A") {
    self.can_melee_enemy_time = 0;
    self.melee_enemy = undefined;
    self.melee_enemy_node = undefined;
    self.melee_enemy_new_node_time = 0;
    self.melee_self_node = undefined;
    self.melee_self_new_node_time = 0;
    var_0 = self botgetdifficultysetting("_encstr_BE23115C039EB8170C257B791D73AB87A0AF5F");

    if(var_0 < 0.25)
      self botsetdifficultysetting("_encstr_BE23115C039EB8170C257B791D73AB87A0AF5F", 0.25);

    self botsetdifficultysetting("_encstr_8A9B0E47C31DC01387FBDD88AF740362", 1);

    for(;;) {
      if(self hasweapon("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83")) {
        if(scripts\mp\utility\entity::isgameparticipant(self.enemy)) {
          var_1 = gettime();

          if(!isDefined(self.melee_enemy) || self.melee_enemy != self.enemy) {
            self.melee_enemy = self.enemy;
            self.melee_enemy_node = self.enemy getnearestnode();
            self.melee_enemy_new_node_time = var_1;
          } else {
            var_2 = squared(self botgetdifficultysetting("_encstr_A7970A69871A1379946F5818"));

            if(distancesquared(self.enemy.origin, self.origin) <= var_2)
              self.can_melee_enemy_time = var_1;

            var_3 = self.enemy getnearestnode();
            var_4 = self getnearestnode();

            if(!isDefined(self.melee_enemy_node) || self.melee_enemy_node != var_3) {
              self.melee_enemy_new_node_time = var_1;
              self.melee_enemy_node = var_3;
            }

            if(!isDefined(self.melee_self_node) || self.melee_self_node != var_4) {
              self.melee_self_new_node_time = var_1;
              self.melee_self_node = var_4;
            } else if(distancesquared(self.origin, self.melee_self_node.origin) > 9216)
              self.melee_self_at_same_node_time = var_1;

            if(self.can_melee_enemy_time + 3000 < var_1) {
              if(self.melee_self_new_node_time + 3000 < var_1) {
                if(self.melee_enemy_new_node_time + 3000 < var_1) {
                  if(bot_infect_angle_too_steep_for_knife_throw(self.origin, self.enemy.origin))
                    scripts\mp\bots\bots_util::bot_queued_process("_encstr_BDC7165C348AA18E0EE770603F5B01FDE1DA455501926D13", ::bot_infect_find_node_can_see_ent, self.enemy, self.melee_self_node);

                  if(!self getammocount("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83"))
                    self setweaponammoclip("_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83", 1);

                  scripts\engine\utility::_id_143BF(30, "_encstr_88BF06FD784A6393");
                  self botclearscriptgoal();
                }
              }
            }
          }
        }
      }

      wait 0.25;
    }
  }
}

bot_infect_angle_too_steep_for_knife_throw(var_0, var_1) {
  if(abs(var_0[2] - var_1[2]) > 56.0 && distance2dsquared(var_0, var_1) < 2304)
    return 1;

  return 0;
}

bot_infect_find_node_can_see_ent(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = 0;

  if(issubstr(var_1.type, "_encstr_845E066577577837"))
    var_2 = 1;

  var_3 = getlinkednodes(var_1);

  if(isDefined(var_3) && var_3.size) {
    var_4 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_6 in var_4) {
      if(var_2 && issubstr(var_6.type, "_encstr_961804AD954A")) {
        continue;
      }
      if(bot_infect_angle_too_steep_for_knife_throw(var_6.origin, var_0.origin)) {
        continue;
      }
      var_7 = self getEye() - self.origin;
      var_8 = var_6.origin + var_7;
      var_9 = var_0.origin;

      if(isPlayer(var_0))
        var_9 = var_0 scripts\mp\utility\player::getstancecenter();

      if(sighttracepassed(var_8, var_9, 0, self, var_0)) {
        var_10 = vectortoyaw(var_9 - var_8);
        self botsetscriptgoalnode(var_6, "_encstr_99CC09DA9020C4ECD149AD", var_10);
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3.0);
        return;
      }

      wait 0.05;
    }
  }
}