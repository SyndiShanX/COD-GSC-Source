/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_conf.gsc
**************************************************/

#using script_27fdece778e999d8;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gameobjects;
#namespace bots_gametype_conf;

function main() {
  setup_callbacks();
  setup_bot_conf();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_conf_think;

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    level.bot_funcs["player_spawned_gamemode"] = &namespace_da125b44c190d236::function_5f51c5c13fd2911b;
    level.modifyplayerdamage = &namespace_da125b44c190d236::modifyplayerdamage;
  }
}

function setup_bot_conf() {
  level.bot_tag_obj_radius = 200;
  level.bot_tag_allowable_jump_height = 38;

  thread function_1303b6877c472535();
}

function function_1303b6877c472535() {
  bot_waittill_bots_enabled();
  setdevdvarifuninitialized(@ "hash_242f40f6d99b93e9", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_313eed123eed35ac", "<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_9cac85d6351e1df") == 1) {
      if(getDvar(@ "hash_242f40f6d99b93e9") == "<dev string:x1c>") {
        foreach(tag in level.dogtags) {
          if(tag bot_can_tag_interact_with("<dev string:x21>") || tag bot_can_tag_interact_with("<dev string:x2b>")) {
            bot_draw_circle(tag.curorigin, level.bot_tag_obj_radius, (1, 0, 0), 0, 16);
          }
        }
      } else {
        foreach(tag in level.dogtags) {
          if(tag bot_can_tag_interact_with("<dev string:x21>") || tag bot_can_tag_interact_with("<dev string:x2b>")) {
            bot_draw_circle(tag.curorigin, 10, (0, 1, 0), 1, 16);
          }
        }

        foreach(player in level.participants) {
          if(!isDefined(player.team)) {
            continue;
          }

          if(isalive(player) && isDefined(player.tags_seen)) {
            foreach(tag in player.tags_seen) {
              if(tag.tag bot_can_tag_interact_with(player.team)) {
                linecolor = undefined;

                if(player.team != tag.tag.victim.team) {
                  linecolor = (1, 0, 0);
                } else {
                  linecolor = (0, 0, 1);
                }

                line(tag.tag.curorigin, player.origin + (0, 0, 20), linecolor, 1, 1);
              }
            }
          }
        }
      }
    }

    if(getDvar(@ "hash_313eed123eed35ac") == "<dev string:x33>") {
      foreach(tag in level.dogtags) {
        if(tag bot_can_tag_interact_with("<dev string:x21>") || tag bot_can_tag_interact_with("<dev string:x2b>")) {
          if(isDefined(tag.nearest_node)) {
            bot_draw_cylinder(tag.nearest_node.origin, 10, 10, 0.05, undefined, (0, 0, 1), 1, 4);
            line(tag.curorigin, tag.nearest_node.origin, (0, 0, 1), 1, 1);
          }
        }
      }
    }

    wait 0.05;
  }
}

function bot_conf_think() {
  self notify("bot_conf_think");
  self endon("bot_conf_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.next_time_check_tags = gettime() + 500;
  self.tags_seen = [];
  childthread bot_watch_new_tags();

  if(self.personality == "camper") {
    self.conf_camper_camp_tags = 0;

    if(!isDefined(self.conf_camping_tag)) {
      self.conf_camping_tag = 0;
    }
  }

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    var_f83d156646e96c13 = isDefined(self.tag_getting);
    var_e837092cd1910147 = 0;

    if(var_f83d156646e96c13 && self bothasscriptgoal()) {
      script_goal = self botgetscriptgoal();

      if(bot_vectors_are_equal(self.tag_getting.ground_pos, script_goal)) {
        if(self botpursuingscriptgoal()) {
          var_e837092cd1910147 = 1;
        }
      } else if(bot_has_tactical_goal("kill_tag") && self.tag_getting bot_can_tag_interact_with(self.team)) {
        self.tag_getting = undefined;
        var_f83d156646e96c13 = 0;
      }
    }

    self botsetflag("force_sprint", var_e837092cd1910147);
    self.tags_seen = bot_remove_invalid_tags(self.tags_seen);
    best_tag = bot_find_best_tag_from_array(self.tags_seen, 1);
    var_ae54fafd5cd89c6f = isDefined(best_tag);

    if(var_f83d156646e96c13 && !var_ae54fafd5cd89c6f || !var_f83d156646e96c13 && var_ae54fafd5cd89c6f || var_f83d156646e96c13 && var_ae54fafd5cd89c6f && self.tag_getting != best_tag) {
      self.tag_getting = best_tag;
      self botclearscriptgoal();
      self notify("stop_camping_tag");
      clear_camper_data();
      bot_abort_tactical_goal("kill_tag");
    }

    if(isDefined(self.tag_getting)) {
      self.conf_camping_tag = 0;

      if(self.personality == "camper" && self.conf_camper_camp_tags) {
        self.conf_camping_tag = 1;

        if(should_select_new_ambush_point()) {
          if(find_ambush_node(self.tag_getting.ground_pos, 1000)) {
            childthread bot_camp_tag(self.tag_getting, "camp");
          } else {
            self.conf_camping_tag = 0;
          }
        }
      }

      if(!self.conf_camping_tag) {
        if(!bot_has_tactical_goal("kill_tag")) {
          extra_params = spawnStruct();
          extra_params.script_goal_type = "objective";
          extra_params.objective_radius = level.bot_tag_obj_radius;
          extra_params.short_term_goal = 1;
          bot_new_tactical_goal("kill_tag", self.tag_getting.ground_pos, 25, extra_params);
        }
      }
    }

    var_d59062eefb2aa6c7 = 0;

    if(isDefined(self.additional_tactical_logic_func)) {
      var_d59062eefb2aa6c7 = self[[self.additional_tactical_logic_func]]();
    }

    if(!isDefined(self.tag_getting)) {
      if(!var_d59062eefb2aa6c7) {
        self[[self.personality_update_function]]();
      }
    }

    if(gettime() > self.next_time_check_tags) {
      self.next_time_check_tags = gettime() + 500;
      var_633df63acc65980 = bot_find_visible_tags(1);
      self.tags_seen = bot_combine_tag_seen_arrays(var_633df63acc65980, self.tags_seen);
    }

    if(getdvarint(@ "hash_9cac85d6351e1df") == 1 && getDvar(@ "hash_242f40f6d99b93e9") == "<dev string:x1c>") {
      if(isDefined(self.tag_getting) && self.health > 0) {
        color = (0.5, 0, 0.5);

        if(self.team == "<dev string:x21>") {
          color = (1, 0, 1);
        }

        if(isDefined(self.conf_camper_camp_tags) && self.conf_camper_camp_tags) {
          color = (1, 0, 0);
        }

        line(self.origin + (0, 0, 40), self.tag_getting.curorigin + (0, 0, 10), color, 1, 1, 1);
      }
    }

    wait 0.05;
  }
}

function bot_can_tag_interact_with(team) {
  return scripts\mp\gameobjects::caninteractwith(team);
}

function bot_check_tag_above_head(tag) {
  if(isDefined(tag.on_path_grid) && tag.on_path_grid) {
    var_2c356f94ba57b868 = self.origin + (0, 0, 55);

    if(distance2dsquared(tag.curorigin, var_2c356f94ba57b868) < 144) {
      var_1b3d39d8c4d20e13 = tag.curorigin[2] - var_2c356f94ba57b868[2];

      if(var_1b3d39d8c4d20e13 > 0) {
        if(var_1b3d39d8c4d20e13 < level.bot_tag_allowable_jump_height) {
          if(!isDefined(self.last_time_jumped_for_tag)) {
            self.last_time_jumped_for_tag = 0;
          }

          if(gettime() - self.last_time_jumped_for_tag > 3000) {
            self.last_time_jumped_for_tag = gettime();
            thread bot_jump_for_tag();
          }
        } else {
          tag.on_path_grid = 0;
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
  while(true) {
    level waittill("new_tag_spawned", newtag);
    level thread function_3cfdf1926a55423(self, newtag);
  }
}

function function_50335c9c24555a07(tag_testing) {
  if(isDefined(tag_testing.on_path_grid)) {
    return false;
  }

  if(istrue(tag_testing.calculations_in_progress)) {
    return false;
  }

  if(istrue(tag_testing.tag_moving)) {
    return false;
  }

  return true;
}

function function_3cfdf1926a55423(bot, newtag) {
  bot.next_time_check_tags = -1;

  if(isDefined(newtag)) {
    if(isDefined(newtag.victim) && newtag.victim == bot || isDefined(newtag.attacker) && newtag.attacker == bot) {
      if(function_50335c9c24555a07(newtag)) {
        thread calculate_tag_on_path_grid(newtag);
        waittill_tag_calculated_on_path_grid(newtag);

        if(newtag.on_path_grid) {
          var_3b8d413a4ff237f2 = spawnStruct();
          var_3b8d413a4ff237f2.origin = newtag.curorigin;
          var_3b8d413a4ff237f2.tag = newtag;
          var_7f1569ab4f7f444c[0] = var_3b8d413a4ff237f2;
          bot.tags_seen = bot_combine_tag_seen_arrays(var_7f1569ab4f7f444c, bot.tags_seen);
        }
      }
    }
  }
}

function bot_combine_tag_seen_arrays(var_e4246e2d10d3e0f6, var_6e63b48e5d296bcf) {
  new_array = var_6e63b48e5d296bcf;

  foreach(new_tag in var_e4246e2d10d3e0f6) {
    var_61c41e18e75c6639 = 0;

    foreach(old_tag in var_6e63b48e5d296bcf) {
      if(new_tag.tag == old_tag.tag && bot_vectors_are_equal(new_tag.origin, old_tag.origin)) {
        var_61c41e18e75c6639 = 1;
        break;
      }
    }

    if(!var_61c41e18e75c6639) {
      new_array = array_add(new_array, new_tag);
    }
  }

  return new_array;
}

function bot_is_tag_visible(tag, var_6006b119331919f9, fov_self) {
  if(function_50335c9c24555a07(tag)) {
    thread calculate_tag_on_path_grid(tag);
  }

  if(isDefined(tag.calculations_in_progress)) {
    return false;
  }

  if(!istrue(tag.on_path_grid)) {
    return false;
  }

  if(!tag.calculated_nearest_node) {
    tag.nearest_node = getclosestnodeinsight(tag.curorigin);
    tag.calculated_nearest_node = 1;
  }

  var_bc2d0e37a05c27ad = tag.nearest_node;
  var_87e39aa5a218a99f = !isDefined(tag.on_path_grid);

  if(isDefined(var_bc2d0e37a05c27ad) && (var_87e39aa5a218a99f || tag.on_path_grid)) {
    node_visible = var_bc2d0e37a05c27ad == var_6006b119331919f9 || nodesvisible(var_bc2d0e37a05c27ad, var_6006b119331919f9, 1);

    if(node_visible) {
      node_within_fov = within_fov(self.origin, self getplayerangles(), tag.curorigin, fov_self);

      if(node_within_fov) {
        return true;
      }
    }
  }

  return false;
}

function bot_find_visible_tags(require_los, var_900c3a9d222406b8, var_3c558339662942bc) {
  var_6006b119331919f9 = undefined;

  if(isDefined(var_900c3a9d222406b8)) {
    var_6006b119331919f9 = var_900c3a9d222406b8;
  } else {
    var_6006b119331919f9 = self getnearestnode();
  }

  fov_self = undefined;

  if(isDefined(var_3c558339662942bc)) {
    fov_self = var_3c558339662942bc;
  } else {
    fov_self = self botgetfovdot();
  }

  visible_tags = [];

  if(isDefined(var_6006b119331919f9) && isDefined(level.dogtags)) {
    foreach(tag in level.dogtags) {
      if(tag bot_can_tag_interact_with(self.team)) {
        add_tag = 0;

        if(!require_los || isDefined(tag.attacker) && tag.attacker == self || isDefined(tag.victim) && tag.victim == self) {
          if(function_50335c9c24555a07(tag)) {
            level thread calculate_tag_on_path_grid(tag);
            waittill_tag_calculated_on_path_grid(tag);
            add_tag = tag.on_path_grid;
          }
        } else if(bot_is_tag_visible(tag, var_6006b119331919f9, fov_self)) {
          add_tag = 1;
        }

        if(add_tag) {
          var_3b8d413a4ff237f2 = spawnStruct();
          var_3b8d413a4ff237f2.origin = tag.curorigin;
          var_3b8d413a4ff237f2.tag = tag;
          visible_tags = array_add(visible_tags, var_3b8d413a4ff237f2);
        }
      }
    }
  }

  return visible_tags;
}

function calculate_tag_on_path_grid(tag) {
  tag endon("reset");
  tag.calculations_in_progress = 1;
  tag.on_path_grid = bot_point_is_on_pathgrid(tag.curorigin, 16, level.bot_tag_allowable_jump_height + 55);

  if(tag.on_path_grid) {
    tag.ground_pos = getgroundposition(tag.curorigin, 0, 256, 32);

    if(!isDefined(tag.ground_pos)) {
      tag.on_path_grid = 0;
    }
  }

  tag.calculations_in_progress = undefined;
}

function waittill_tag_calculated_on_path_grid(tag) {
  while(!isDefined(tag.on_path_grid)) {
    wait 0.05;
  }
}

function bot_find_best_tag_from_array(tag_array, var_fcb9461bb8ed3b2a) {
  best_tag = undefined;

  if(tag_array.size > 0) {
    var_7e67551412c990aa = 9999800001;

    foreach(tag_struct in tag_array) {
      num_allies_getting_tag = get_num_allies_getting_tag(tag_struct.tag);

      if(!var_fcb9461bb8ed3b2a || num_allies_getting_tag < 2) {
        var_f8a769e6c932e890 = distancesquared(tag_struct.tag.ground_pos, self.origin);

        if(var_f8a769e6c932e890 < var_7e67551412c990aa) {
          best_tag = tag_struct.tag;
          var_7e67551412c990aa = var_f8a769e6c932e890;
        }
      }
    }
  }

  return best_tag;
}

function bot_remove_invalid_tags(tags) {
  valid_tags = [];

  foreach(tag_struct in tags) {
    if(!isDefined(tag_struct.tag.on_path_grid)) {
      continue;
    }

    if(tag_struct.tag bot_can_tag_interact_with(self.team) && bot_vectors_are_equal(tag_struct.tag.curorigin, tag_struct.origin)) {
      if(!bot_check_tag_above_head(tag_struct.tag)) {
        valid_tags = array_add(valid_tags, tag_struct);
      }
    }
  }

  return valid_tags;
}

function get_num_allies_getting_tag(tag) {
  num = 0;

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(player.team == self.team && player != self) {
      if(isai(player)) {
        if(isDefined(player.tag_getting) && player.tag_getting == tag) {
          num++;
        }

        continue;
      }

      if(distancesquared(player.origin, tag.curorigin) < 160000) {
        num++;
      }
    }
  }

  return num;
}

function bot_camp_tag(tag, goal_type, optional_endon) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(optional_endon)) {
    self endon(optional_endon);
  }

  self botsetscriptgoalnode(self.node_ambushing_from, goal_type, self.ambush_yaw);
  result = bot_waittill_goal_or_fail();

  if(result == "goal") {
    var_bc2d0e37a05c27ad = tag.nearest_node;

    if(isDefined(var_bc2d0e37a05c27ad)) {
      var_6e99c9c93e0d0552 = findentrances(self.origin);
      var_6e99c9c93e0d0552 = array_add(var_6e99c9c93e0d0552, var_bc2d0e37a05c27ad);
      childthread bot_watch_nodes(var_6e99c9c93e0d0552);
    }
  }
}