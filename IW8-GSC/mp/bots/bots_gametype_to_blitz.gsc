/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_to_blitz.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_blitz();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_blitz_think;
}

setup_bot_blitz() {
  level.bot_tag_obj_radius = 200;
  level.bot_tag_allowable_jump_height = 38;
}

bot_blitz_think() {
  self notify("_encstr_863A108DF70BE0403404EB22A1F4C823421F");
  self endon("_encstr_863A108DF70BE0403404EB22A1F4C823421F");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.next_time_check_tags = gettime() + 500;
  self.tags_seen = [];
  childthread bot_watch_new_tags();

  if(self.personality == "_encstr_B892078D2C5BE05927") {
    self.conf_camper_camp_tags = 0;

    if(!isDefined(self.conf_camping_tag))
      self.conf_camping_tag = 0;
  }

  for(;;) {
    var_0 = isDefined(self.tag_getting);
    var_1 = 0;

    if(var_0 && self bothasscriptgoal()) {
      var_2 = self botgetscriptgoal();

      if(scripts\mp\bots\bots_util::bot_vectors_are_equal(self.tag_getting.curorigin, var_2)) {
        if(self botpursuingscriptgoal())
          var_1 = 1;
      } else if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_99D509CBFC59B01903E199") && self.tag_getting scripts\mp\gameobjects::caninteractwith(self.team)) {
        self.tag_getting = undefined;
        var_0 = 0;
      }
    }

    self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", var_1);
    self.tags_seen = bot_remove_invalid_tags(self.tags_seen);
    var_3 = bot_find_best_tag_from_array(self.tags_seen, 1);
    var_4 = isDefined(var_3);

    if(var_0 && !var_4 || !var_0 && var_4 || var_0 && var_4 && self.tag_getting != var_3) {
      self.tag_getting = var_3;
      self botclearscriptgoal();
      self notify("_encstr_9B93116E8EF683FA8D16DAC1A5B93BEB8EB0EC");
      scripts\mp\bots\bots_personality::clear_camper_data();
      scripts\mp\bots\bots_strategy::bot_abort_tactical_goal("_encstr_99D509CBFC59B01903E199");
    }

    if(isDefined(self.tag_getting)) {
      self.conf_camping_tag = 0;

      if(self.personality == "_encstr_B892078D2C5BE05927" && self.conf_camper_camp_tags) {
        self.conf_camping_tag = 1;

        if(scripts\mp\bots\bots_personality::should_select_new_ambush_point()) {
          if(scripts\mp\bots\bots_personality::find_ambush_node(self.tag_getting.curorigin, 1000))
            childthread bot_camp_tag(self.tag_getting, "_encstr_8F9005D80B6B38");
          else
            self.conf_camping_tag = 0;
        }
      }

      if(!self.conf_camping_tag) {
        if(!scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_99D509CBFC59B01903E199")) {
          var_5 = spawnStruct();
          var_5.script_goal_type = "_encstr_9A2B0A12F03587575B7BBEA5";
          var_5.objective_radius = level.bot_tag_obj_radius;
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_99D509CBFC59B01903E199", self.tag_getting.curorigin, 25, var_5);
        }
      }
    }

    var_6 = 0;

    if(isDefined(self.additional_tactical_logic_func))
      var_6 = self[[self.additional_tactical_logic_func]]();

    if(!isDefined(self.tag_getting)) {
      if(!var_6)
        self[[self.personality_update_function]]();
    }

    if(gettime() > self.next_time_check_tags) {
      self.next_time_check_tags = gettime() + 500;
      var_7 = bot_find_visible_tags(1);
      self.tags_seen = bot_combine_tag_seen_arrays(var_7, self.tags_seen);
    }

    wait 0.05;
  }
}

bot_check_tag_above_head(var_0) {
  if(isDefined(var_0.on_path_grid) && var_0.on_path_grid) {
    var_1 = self.origin + (0, 0, 55);

    if(distance2dsquared(var_0.curorigin, var_1) < 144) {
      var_2 = var_0.curorigin[2] - var_1[2];

      if(var_2 > 0) {
        if(var_2 < level.bot_tag_allowable_jump_height) {
          if(!isDefined(self.last_time_jumped_for_tag))
            self.last_time_jumped_for_tag = 0;

          if(gettime() - self.last_time_jumped_for_tag > 3000) {
            self.last_time_jumped_for_tag = gettime();
            thread bot_jump_for_tag();
          }
        } else {
          var_0.on_path_grid = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

bot_jump_for_tag() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self botsetstance("_encstr_A5AD069B231F0BAF");
  wait 1.0;
  self botpressbutton("_encstr_84DD05D205AA0B");
  wait 1.0;
  self botsetstance("_encstr_8BBA05185F8B99");
}

bot_watch_new_tags() {
  for(;;) {
    level waittill("_encstr_871E107D55071984D9C07FC790315FD28B7D", var_0);
    self.next_time_check_tags = -1;

    if(isDefined(var_0)) {
      if(isDefined(var_0.victim) && var_0.victim == self || isDefined(var_0.attacker) && var_0.attacker == self) {
        if(!isDefined(var_0.on_path_grid) && !isDefined(var_0.calculations_in_progress)) {
          thread calculate_tag_on_path_grid(var_0);
          waittill_tag_calculated_on_path_grid(var_0);

          if(var_0.on_path_grid) {
            var_1 = spawnStruct();
            var_1.origin = var_0.curorigin;
            var_1.tag = var_0;
            var_2[0] = var_1;
            self.tags_seen = bot_combine_tag_seen_arrays(var_2, self.tags_seen);
          }
        }
      }
    }
  }
}

bot_combine_tag_seen_arrays(var_0, var_1) {
  var_2 = var_1;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_4.tag == var_7.tag && scripts\mp\bots\bots_util::bot_vectors_are_equal(var_4.origin, var_7.origin)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5)
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

bot_is_tag_visible(var_0, var_1, var_2) {
  if(!var_0.calculated_nearest_node) {
    var_0.nearest_node = getclosestnodeinsight(var_0.curorigin);
    var_0.calculated_nearest_node = 1;
  }

  if(isDefined(var_0.calculations_in_progress))
    return 0;

  var_3 = var_0.nearest_node;
  var_4 = !isDefined(var_0.on_path_grid);

  if(isDefined(var_3) && (var_4 || var_0.on_path_grid)) {
    var_5 = var_3 == var_1 || nodesvisible(var_3, var_1, 1);

    if(var_5) {
      var_6 = scripts\engine\utility::within_fov(self.origin, self.angles, var_0.curorigin, var_2);

      if(var_6) {
        if(var_4) {
          thread calculate_tag_on_path_grid(var_0);
          waittill_tag_calculated_on_path_grid(var_0);

          if(!var_0.on_path_grid)
            return 0;
        }

        return 1;
      }
    }
  }

  return 0;
}

bot_find_visible_tags(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = self getnearestnode();

  var_4 = undefined;

  if(isDefined(var_2))
    var_4 = var_2;
  else
    var_4 = self botgetfovdot();

  var_5 = [];

  if(isDefined(var_3) && isDefined(level.dogtags)) {
    foreach(var_7 in level.dogtags) {
      if(var_7 scripts\mp\gameobjects::caninteractwith(self.team)) {
        var_8 = 0;

        if(!var_0) {
          if(!isDefined(var_7.calculations_in_progress)) {
            if(!isDefined(var_7.on_path_grid)) {
              level thread calculate_tag_on_path_grid(var_7);
              waittill_tag_calculated_on_path_grid(var_7);
            }

            var_8 = distancesquared(self.origin, var_7.curorigin) < 1000000 && var_7.on_path_grid;
          }
        } else if(bot_is_tag_visible(var_7, var_3, var_4))
          var_8 = 1;

        if(var_8) {
          var_9 = spawnStruct();
          var_9.origin = var_7.curorigin;
          var_9.tag = var_7;
          var_5 = scripts\engine\utility::array_add(var_5, var_9);
        }
      }
    }
  }

  return var_5;
}

calculate_tag_on_path_grid(var_0) {
  _encstr_BEDD27FA96CDBA40BBA0FEFFD0B80A82693655360839D3A7E1288FC7C8AAD0EA6746CDAD6425EAB389::calculate_tag_on_path_grid(var_0);
}

waittill_tag_calculated_on_path_grid(var_0) {
  while(!isDefined(var_0.on_path_grid))
    wait 0.05;
}

bot_find_best_tag_from_array(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = 1409865409;

    foreach(var_5 in var_0) {
      var_6 = get_num_allies_getting_tag(var_5.tag);

      if(!var_1 || var_6 < 2) {
        var_7 = distancesquared(var_5.tag.curorigin, self.origin);

        if(var_7 < var_3) {
          var_2 = var_5.tag;
          var_3 = var_7;
        }
      }
    }
  }

  return var_2;
}

bot_remove_invalid_tags(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.tag scripts\mp\gameobjects::caninteractwith(self.team) && scripts\mp\bots\bots_util::bot_vectors_are_equal(var_3.tag.curorigin, var_3.origin)) {
      if(!bot_check_tag_above_head(var_3.tag) && var_3.tag.on_path_grid)
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

get_num_allies_getting_tag(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(var_3.team == self.team && var_3 != self) {
      if(isai(var_3)) {
        if(isDefined(var_3.tag_getting) && var_3.tag_getting == var_0)
          var_1++;

        continue;
      }

      if(distancesquared(var_3.origin, var_0.curorigin) < 160000)
        var_1++;
    }
  }

  return var_1;
}

bot_camp_tag(var_0, var_1, var_2) {
  self notify("_encstr_BA580D31BD1DEB1B2C5BC1F547B0CE");
  self endon("_encstr_BA580D31BD1DEB1B2C5BC1F547B0CE");
  self endon("_encstr_9B93116E8EF683FA8D16DAC1A5B93BEB8EB0EC");

  if(isDefined(var_2))
    self endon(var_2);

  self botsetscriptgoalnode(self.node_ambushing_from, var_1, self.ambush_yaw);
  var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_3 == "_encstr_8B7205D9ED5958") {
    var_4 = var_0.nearest_node;

    if(isDefined(var_4)) {
      var_5 = findentrances(self.origin);
      var_5 = scripts\engine\utility::array_add(var_5, var_4);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_5);
    }
  }
}