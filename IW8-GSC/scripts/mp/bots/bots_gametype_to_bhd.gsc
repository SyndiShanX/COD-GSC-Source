/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_bhd.gsc
****************************************************/

function main() {
  setup_callbacks();
  setup_bot_bhd();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_bhd_think;
}

function setup_bot_bhd() {
  level.bot_tag_obj_radius = 200;
  level.bot_tag_allowable_jump_height = 38;
}

function bot_bhd_think() {
  self notify("bot_bhd_think");
  self endon("bot_bhd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.next_time_check_tags = gettime() + 500;
  self.tags_seen = [];
  GscBinSkip4(0x35);
}

function bot_check_tag_above_head(var_0) {
  if(isDefined(var_0.on_path_grid) && var_0.on_path_grid) {
    var_1 = self.origin + (0, 0, 55);

    if(distance2dsquared(var_0.curorigin, var_1) < 144) {
      var_2 = var_0.curorigin[2] - var_1[2];

      if(var_2 > 0) {
        if(var_2 < level.bot_tag_allowable_jump_height) {
          if(!isDefined(self.last_time_jumped_for_tag)) {
            self.last_time_jumped_for_tag = 0;
          }

          if(gettime() - self.last_time_jumped_for_tag > 3000) {
            self.last_time_jumped_for_tag = gettime();
            thread bot_jump_for_tag();
          }
        } else {
          var_0.on_path_grid = 0;
          return true;
        }
      }
    }
  }

  return false;
}

function bot_jump_for_tag() {
  self endon("death_or_disconnect");
  self botsetstance("stand");
  wait 1;
  self botpressbutton("jump");
  wait 1;
  self botsetstance("none");
}

function bot_watch_new_tags() {
  for(;;) {
    level waittill("new_tag_spawned", var_0);
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
            GscBinSkip1(0x45, 0, var_1);
          }
        }
      }
    }
  }
}

function bot_combine_tag_seen_arrays(var_0, var_1) {
  var_2 = var_1;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_4.tag == var_7.tag && scripts\mp\bots\bots_util::bot_vectors_are_equal(var_4.origin, var_7.origin)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

function bot_is_tag_visible(var_0, var_1, var_2) {
  if(!var_0.calculated_nearest_node) {
    var_0.nearest_node = getclosestnodeinsight(var_0.curorigin);
    var_0.calculated_nearest_node = 1;
  }

  if(isDefined(var_0.calculations_in_progress)) {
    return false;
  }

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

          if(!var_0.on_path_grid) {
            return false;
          }
        }

        return true;
      }
    }
  }

  return false;
}

function bot_find_visible_tags(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = self getnearestnode();
  }

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = self botgetfovdot();
  }

  var_5 = [];

  if(isDefined(var_3) && isDefined(level.dogtags)) {
    foreach(var_7 in level.dogtags) {
      if(var_7 scripts\mp\gameobjects::caninteractwith(self.team)) {
        var_8 = 0;

        if(!var_0) {
          if(!isDefined(var_7.calculations_in_progress)) {
            if(!isDefined(var_7.on_path_grid)) {
              thread calculate_tag_on_path_grid(level);
              waittill_tag_calculated_on_path_grid(var_7);
            }

            var_8 = distancesquared(self.origin, var_7.curorigin) < 1000000 && var_7.on_path_grid;
          }
        } else if(bot_is_tag_visible(var_7, var_3, var_4)) {
          var_8 = 1;
        }

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

function calculate_tag_on_path_grid(var_0) {
  scripts\mp\bots\bots_gametype_conf::calculate_tag_on_path_grid(var_0);
}

function waittill_tag_calculated_on_path_grid(var_0) {
  while(!isDefined(var_0.on_path_grid)) {
    wait 0.05;
  }
}

function bot_find_best_tag_from_array(var_0, var_1) {
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

function bot_remove_invalid_tags(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.tag scripts\mp\gameobjects::caninteractwith(self.team) && scripts\mp\bots\bots_util::bot_vectors_are_equal(var_3.tag.curorigin, var_3.origin)) {
      if(!bot_check_tag_above_head(var_3.tag) && var_3.tag.on_path_grid) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

function get_num_allies_getting_tag(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3.team == self.team && var_3 != self) {
      if(isai(var_3)) {
        if(isDefined(var_3.tag_getting) && var_3.tag_getting == var_0) {
          var_1++;
        }

        continue;
      }

      if(distancesquared(var_3.origin, var_0.curorigin) < 160000) {
        var_1++;
      }
    }
  }

  return var_1;
}

function bot_camp_tag(var_0, var_1, var_2) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self botsetscriptgoalnode(self.node_ambushing_from, var_1, self.ambush_yaw);
  var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_3 == "goal") {
    var_4 = var_0.nearest_node;

    if(isDefined(var_4)) {
      var_5 = findentrances(self.origin);
      var_5 = scripts\engine\utility::array_add(var_5, var_4);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(var_5);
      return;
    }

    return;
  }
}