/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_infect.gsc
****************************************************/

main() {
  setup_callbacks();
  setup_bot_infect();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_infect_think;
  level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons_infect;
}

setup_bot_infect() {
  level.bots_gametype_handles_class_choice = 1;
  level.bots_ignore_team_balance = 1;
  level.bots_gametype_handles_team_choice = 1;
  thread bot_infect_ai_director_update();
}

bot_should_pickup_weapons_infect() {
  if(level.infect_chosefirstinfected && self.team == "axis")
    return 0;

  return scripts\mp\bots\bots::bot_should_pickup_weapons();
}

bot_infect_think() {
  self notify("bot_infect_think");
  self endon("bot_infect_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  childthread bot_infect_retrieve_knife();

  for(;;) {
    if(level.infect_chosefirstinfected) {
      if(self.team == "axis" && self botgetpersonality() != "run_and_gun")
        scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");
    }

    if(self.bot_team != self.team)
      self.bot_team = self.team;

    if(self.team == "axis") {
      result = scripts\mp\bots\bots_strategy::bot_melee_tactical_insertion_check();

      if(!isDefined(result) || result)
        self botclearscriptgoal();
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}

bot_infect_ai_director_update() {
  level notify("bot_infect_ai_director_update");
  level endon("bot_infect_ai_director_update");
  level endon("game_ended");

  for(;;) {
    _id_AD93A9FC8FA4924C = [];
    _id_4DE221DA8F9B25C8 = [];

    foreach(player in level.players) {
      if(!isDefined(player.initial_spawn_time) && player.health > 0 && isDefined(player.team) && (player.team == "allies" || player.team == "axis"))
        player.initial_spawn_time = gettime();

      if(isDefined(player.initial_spawn_time) && gettime() - player.initial_spawn_time > 5000) {
        if(!isDefined(player.team)) {
          continue;
        }
        if(player.team == "axis") {
          _id_AD93A9FC8FA4924C[_id_AD93A9FC8FA4924C.size] = player;
          continue;
        }

        if(player.team == "allies")
          _id_4DE221DA8F9B25C8[_id_4DE221DA8F9B25C8.size] = player;
      }
    }

    if(_id_AD93A9FC8FA4924C.size > 0 && _id_4DE221DA8F9B25C8.size > 0) {
      _id_B284217FE817CA2F = 1;

      foreach(_id_A58FF4A65B324B6B in _id_4DE221DA8F9B25C8) {
        if(isbot(_id_A58FF4A65B324B6B))
          _id_B284217FE817CA2F = 0;
      }

      if(_id_B284217FE817CA2F) {
        foreach(player in _id_4DE221DA8F9B25C8) {
          if(!isDefined(player.last_infected_hiding_time)) {
            player.last_infected_hiding_time = gettime();
            player.last_infected_hiding_loc = player.origin;
            player.time_spent_hiding = 0;
          }

          if(gettime() >= player.last_infected_hiding_time + 5000) {
            player.last_infected_hiding_time = gettime();
            _id_3B4519D9E6FFAC2C = distancesquared(player.origin, player.last_infected_hiding_loc);
            player.last_infected_hiding_loc = player.origin;

            if(_id_3B4519D9E6FFAC2C < 90000) {
              player.time_spent_hiding = player.time_spent_hiding + 5000;

              if(player.time_spent_hiding >= 20000) {
                _id_C1EDADBDAE2B698C = scripts\engine\utility::get_array_of_closest(player.origin, _id_AD93A9FC8FA4924C);

                foreach(_id_CDF39D6564BED0F7 in _id_C1EDADBDAE2B698C) {
                  if(isbot(_id_CDF39D6564BED0F7)) {
                    goal_type = _id_CDF39D6564BED0F7 botgetscriptgoaltype();

                    if(goal_type != "tactical" && goal_type != "critical") {
                      _id_CDF39D6564BED0F7 thread hunt_human(player);
                      break;
                    }
                  }
                }
              }
            } else {
              player.time_spent_hiding = 0;
              player.last_infected_hiding_loc = player.origin;
            }
          }
        }
      }
    }

    wait 1.0;
  }
}

hunt_human(_id_DF757D4CA3BEBED8) {
  self endon("death_or_disconnect");
  self botsetscriptgoal(_id_DF757D4CA3BEBED8.origin, 0, "critical");
  scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
  self botclearscriptgoal();
}

bot_infect_retrieve_knife() {
  if(self.team == "axis") {
    self.can_melee_enemy_time = 0;
    self.melee_enemy = undefined;
    self.melee_enemy_node = undefined;
    self.melee_enemy_new_node_time = 0;
    self.melee_self_node = undefined;
    self.melee_self_new_node_time = 0;
    _id_178BA45A7F7990C4 = self botgetdifficultysetting("throwKnifeChance");

    if(_id_178BA45A7F7990C4 < 0.25)
      self botsetdifficultysetting("throwKnifeChance", 0.25);

    self botsetdifficultysetting("allowGrenades", 1);

    for(;;) {
      if(self hasweapon("throwingknife_mp")) {
        if(scripts\cp_mp\utility\game_utility::isgameparticipant(self.enemy)) {
          time = gettime();

          if(!isDefined(self.melee_enemy) || self.melee_enemy != self.enemy) {
            self.melee_enemy = self.enemy;
            self.melee_enemy_node = self.enemy getnearestnode();
            self.melee_enemy_new_node_time = time;
          } else {
            _id_D299E82E1E97DF57 = squared(self botgetdifficultysetting("meleeDist"));

            if(distancesquared(self.enemy.origin, self.origin) <= _id_D299E82E1E97DF57)
              self.can_melee_enemy_time = time;

            melee_enemy_node = self.enemy getnearestnode();
            melee_self_node = self getnearestnode();

            if(!isDefined(self.melee_enemy_node) || self.melee_enemy_node != melee_enemy_node) {
              self.melee_enemy_new_node_time = time;
              self.melee_enemy_node = melee_enemy_node;
            }

            if(!isDefined(self.melee_self_node) || self.melee_self_node != melee_self_node) {
              self.melee_self_new_node_time = time;
              self.melee_self_node = melee_self_node;
            } else if(distancesquared(self.origin, self.melee_self_node.origin) > 9216)
              self.melee_self_at_same_node_time = time;

            if(self.can_melee_enemy_time + 3000 < time) {
              if(self.melee_self_new_node_time + 3000 < time) {
                if(self.melee_enemy_new_node_time + 3000 < time) {
                  if(bot_infect_angle_too_steep_for_knife_throw(self.origin, self.enemy.origin))
                    scripts\mp\bots\bots_util::bot_queued_process("find_node_can_see_ent", ::bot_infect_find_node_can_see_ent, self.enemy, self.melee_self_node);

                  if(!self getammocount("throwingknife_mp"))
                    self setweaponammoclip("throwingknife_mp", 1);

                  scripts\engine\utility::waittill_any_timeout_no_endon_death_1(30, "enemy");
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

bot_infect_angle_too_steep_for_knife_throw(_id_1CFCCAC3E5778BBB, _id_693D5A9577180151) {
  if(abs(_id_1CFCCAC3E5778BBB[2] - _id_693D5A9577180151[2]) > 56.0 && distance2dsquared(_id_1CFCCAC3E5778BBB, _id_693D5A9577180151) < 2304)
    return 1;

  return 0;
}

bot_infect_find_node_can_see_ent(targetent, startnode) {
  if(!isDefined(targetent) || !isDefined(startnode)) {
    return;
  }
  _id_23EE3D0EB96AB147 = 0;

  if(issubstr(startnode.type, "Begin"))
    _id_23EE3D0EB96AB147 = 1;

  _id_6B33768766AFB04C = getlinkednodes(startnode);

  if(isDefined(_id_6B33768766AFB04C) && _id_6B33768766AFB04C.size) {
    _id_3C953E7596AD9543 = scripts\engine\utility::array_randomize(_id_6B33768766AFB04C);

    foreach(_id_5AC78BE24C31F795 in _id_3C953E7596AD9543) {
      if(_id_23EE3D0EB96AB147 && issubstr(_id_5AC78BE24C31F795.type, "End")) {
        continue;
      }
      if(bot_infect_angle_too_steep_for_knife_throw(_id_5AC78BE24C31F795.origin, targetent.origin)) {
        continue;
      }
      _id_AB4876CB0361AE34 = self getEye() - self.origin;
      start = _id_5AC78BE24C31F795.origin + _id_AB4876CB0361AE34;
      end = targetent.origin;

      if(isPlayer(targetent))
        end = targetent scripts\mp\utility\player::getstancecenter();

      if(sighttracepassed(start, end, 0, self, targetent)) {
        yaw = vectortoyaw(end - start);
        self botsetscriptgoalnode(_id_5AC78BE24C31F795, "critical", yaw);
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3.0);
        return;
      }

      wait 0.05;
    }
  }
}