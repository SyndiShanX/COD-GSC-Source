/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_wmd.gsc
****************************************************/

function main() {
  setup_callbacks();
  setup_bot_wmd();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_wmd_think;
}

function setup_bot_wmd() {
  level.bot_tag_obj_radius = 200;
  level.bot_tag_allowable_jump_height = 38;
}

function bot_wmd_think() {
  self notify("bot_wmd_think");
  self endon("bot_wmd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.next_time_check_tags = gettime() + 500;
  self.tags_seen = [];
  GscBinSkip4(0x35);
}

function bot_check_tag_above_head(var0) {
  if(isDefined(var0.on_path_grid) && var0.on_path_grid) {
    var1 = self.origin + (0, 0, 55);

    if(distance2dsquared(var0.curorigin, var1) < 144) {
      var2 = var0.curorigin[2] - var1[2];

      if(var2 > 0) {
        if(var2 < level.bot_tag_allowable_jump_height) {
          if(!isDefined(self.last_time_jumped_for_tag)) {
            self.last_time_jumped_for_tag = 0;
          }

          if(gettime() - self.last_time_jumped_for_tag > 3000) {
            self.last_time_jumped_for_tag = gettime();
            thread bot_jump_for_tag();
          }
        } else {
          var0.on_path_grid = 0;
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
    level waittill("new_tag_spawned", var0);
    self.next_time_check_tags = -1;

    if(isDefined(var0)) {
      if(isDefined(var0.victim) && var0.victim == self || isDefined(var0.attacker) && var0.attacker == self) {
        if(!isDefined(var0.on_path_grid) && !isDefined(var0.calculations_in_progress)) {
          thread calculate_tag_on_path_grid(var0);
          waittill_tag_calculated_on_path_grid(var0);

          if(var0.on_path_grid) {
            var1 = spawnStruct();
            var1.origin = var0.curorigin;
            var1.tag = var0;
            GscBinSkip1(0x45, 0, var1);
          }
        }
      }
    }
  }
}

function bot_combine_tag_seen_arrays(var0, var1) {
  var2 = var1;

  foreach(var4 in var0) {
    var5 = 0;

    foreach(var7 in var1) {
      if(var4.tag == var7.tag && scripts\mp\bots\bots_util::bot_vectors_are_equal(var4.origin, var7.origin)) {
        var5 = 1;
        break;
      }
    }

    if(!var5) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  return var2;
}

function bot_is_tag_visible(var0, var1, var2) {
  if(!var0.calculated_nearest_node) {
    var0.nearest_node = getclosestnodeinsight(var0.curorigin);
    var0.calculated_nearest_node = 1;
  }

  if(isDefined(var0.calculations_in_progress)) {
    return false;
  }

  var3 = var0.nearest_node;
  var4 = !isDefined(var0.on_path_grid);

  if(isDefined(var3) && (var4 || var0.on_path_grid)) {
    var5 = var3 == var1 || nodesvisible(var3, var1, 1);

    if(var5) {
      var6 = scripts\engine\utility::within_fov(self.origin, self.angles, var0.curorigin, var2);

      if(var6) {
        if(var4) {
          thread calculate_tag_on_path_grid(var0);
          waittill_tag_calculated_on_path_grid(var0);

          if(!var0.on_path_grid) {
            return false;
          }
        }

        return true;
      }
    }
  }

  return false;
}

function bot_find_visible_tags(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var1)) {
    var3 = var1;
  } else {
    var3 = self getnearestnode();
  }

  var4 = undefined;

  if(isDefined(var2)) {
    var4 = var2;
  } else {
    var4 = self botgetfovdot();
  }

  var5 = [];

  if(isDefined(var3) && isDefined(level.dogtags)) {
    foreach(var7 in level.dogtags) {
      if(var7 scripts\mp\gameobjects::caninteractwith(self.team)) {
        var8 = 0;

        if(!var0) {
          if(!isDefined(var7.calculations_in_progress)) {
            if(!isDefined(var7.on_path_grid)) {
              thread calculate_tag_on_path_grid(level);
              waittill_tag_calculated_on_path_grid(var7);
            }

            var8 = distancesquared(self.origin, var7.curorigin) < 1000000 && var7.on_path_grid;
          }
        } else if(bot_is_tag_visible(var7, var3, var4)) {
          var8 = 1;
        }

        if(var8) {
          var9 = spawnStruct();
          var9.origin = var7.curorigin;
          var9.tag = var7;
          var5 = scripts\engine\utility::array_add(var5, var9);
        }
      }
    }
  }

  return var5;
}

function calculate_tag_on_path_grid(var0) {
  scripts\mp\bots\bots_gametype_conf::calculate_tag_on_path_grid(var0);
}

function waittill_tag_calculated_on_path_grid(var0) {
  while(!isDefined(var0.on_path_grid)) {
    wait 0.05;
  }
}

function bot_find_best_tag_from_array(var0, var1) {
  var2 = undefined;

  if(var0.size > 0) {
    var3 = 1409865409;

    foreach(var5 in var0) {
      var6 = get_num_allies_getting_tag(var5.tag);

      if(!var1 || var6 < 2) {
        var7 = distancesquared(var5.tag.curorigin, self.origin);

        if(var7 < var3) {
          var2 = var5.tag;
          var3 = var7;
        }
      }
    }
  }

  return var2;
}

function bot_remove_invalid_tags(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(var3.tag scripts\mp\gameobjects::caninteractwith(self.team) && scripts\mp\bots\bots_util::bot_vectors_are_equal(var3.tag.curorigin, var3.origin)) {
      if(!bot_check_tag_above_head(var3.tag) && var3.tag.on_path_grid) {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    }
  }

  return var1;
}

function get_num_allies_getting_tag(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(!isDefined(var3.team)) {
      continue;
    }

    if(var3.team == self.team && var3 != self) {
      if(isai(var3)) {
        if(isDefined(var3.tag_getting) && var3.tag_getting == var0) {
          var1++;
        }

        continue;
      }

      if(distancesquared(var3.origin, var0.curorigin) < 160000) {
        var1++;
      }
    }
  }

  return var1;
}

function bot_camp_tag(var0, var1, var2) {
  self notify("bot_camp_tag");
  self endon("bot_camp_tag");
  self endon("stop_camping_tag");

  if(isDefined(var2)) {
    self endon(var2);
  }

  self botsetscriptgoalnode(self.node_ambushing_from, var1, self.ambush_yaw);
  var3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var3 == "goal") {
    var4 = var0.nearest_node;

    if(isDefined(var4)) {
      var5 = findentrances(self.origin);
      var5 = scripts\engine\utility::array_add(var5, var4);
      childthread scripts\mp\bots\bots_util::bot_watch_nodes(var5);
      return;
    }

    return;
  }
}