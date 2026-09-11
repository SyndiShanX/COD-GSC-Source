/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\clear_regions.gsc
***********************************************/

function init_hunt_regions() {
  if(!isDefined(level.hunt_region_load)) {
    level.hunt_region_load = spawnStruct();
    inithuntregiondata();
  }

  if(isDefined(level.stealth)) {
    level.stealth.hunt_stealth_group_region_sets = level.hunt_region_load.hunt_stealth_group_region_sets;
    level.hunt_region_load = undefined;
    return;
  }
}

function findnextpointofinterest(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  var4 = var2;
  var5 = var0;
  var6 = min(var1.bfs_distance, 3);
  var7 = 48 * (1 + var6);

  for(var8 = 84 * (1 + var6); var3 && var4 < var1.route_points.size || !var3 && var4 >= 0; var8--) {
    var9 = var1.route_points[var4].origin;
    var10 = scripts\smartobjects\utility::getbestsmartobjectalongline(var5, var9, var1, undefined, var7, var8, 0);

    if(isDefined(var10)) {
      var11 = var5;

      if(var3 && var4 - 1 >= 0) {
        var11 = var1.route_points[var4 - 1].origin;
      } else if(!var3 && var4 + 1 < var1.route_points.size) {
        var11 = var1.route_points[var4 + 1].origin;
      }

      var12 = var9 - var11;
      var13 = length(var12);
      var12 /= var13;
      var14 = var4 == var2 && (var2 == 0 && var3 || var2 == var1.route_points.size && !var3);

      if(var14 || vectordot(var12, var10.origin - var11) > var13 - 24) {
        if(var3) {
          return [var10, var4 + 1];
        } else {
          return [var10, var4 - 1];
        }
      }

      return [var10, var4];
    }

    var14 = distance2d(var9, var12);
    var15 = max(var15 - var14, 0);
    var11 = max(var11 - var14, 0);
    var9 = var12;

    if(var7) {
      var8++;
      continue;
    }
  }
}

function findcurposonroute(var0, var1) {
  var2 = var1.size;
  var3 = 0;
  var4 = -1;

  for(var5 = 0; var5 < var2; var5++) {
    var6 = (var5 + 1) % var2;
    var7 = var1[var6].origin - var1[var5].origin;
    var8 = length(var7);
    var7 /= var8;
    var9 = var0 - var1[var5].origin;
    var10 = vectordot(var7, var9);

    if(var3 > 0 && (var10 < 0 || var10 > var8)) {
      continue;
    }

    var11 = (var7[1], -1 * var7[0], 0);
    var11 = vectorNormalize(var11);
    var12 = abs(vectordot(var11, var9));

    if(var3 <= 0 || var12 < var3) {
      var3 = var12;
      var4 = var6;
    }
  }

  return var4;
}

function getregionforpos(var0) {
  var1 = 1000000000;
  var2 = undefined;
  var3 = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group];

  if(!isDefined(var3)) {
    return undefined;
  }

  foreach(var5 in var3.hunt_regions) {
    if(!isDefined(self.script_stealth_region_group) || self.script_stealth_region_group != var5.stealth_group) {
      continue;
    }

    if(ispointinvolume(var0, var5.volume)) {
      return var5;
    }

    var6 = lengthsquared(var5.approx_location - self.origin);

    if(var6 < var1) {
      var1 = var6;
      var2 = var5;
    }
  }

  return var2;
}

function gethuntstealthgroups(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var4 = strtok(var3.script_stealth_region_group, " ");

    foreach(var6 in var4) {
      var1 = var6;
    }
  }

  return scripts\engine\utility::array_remove_duplicates(var1);
}

function gethuntroutepoints() {
  var0 = [];

  foreach(var2 in level.struct) {
    if(isDefined(var2.script_stealth_clear) && var2.script_stealth_clear == 1) {
      var3 = var2;
      var3.transitions = [];
      var4 = var0.size;
      var3.index = var4;
      var0 = var3;
    }
  }

  return var0;
}

function gethuntstealthgroupvolumelists(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    var2 = [];

    foreach(var6 in var1) {
      if(issubstr(var6.script_stealth_region_group, var4)) {
        var7 = var2[var4].size;
        var2[var7] = var6;
      }
    }
  }

  return var2;
}

function buildhuntstealthgrouptransitiondata() {
  foreach(var1 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var3 in var1.hunt_regions) {
      var4 = [];

      foreach(var16, var6 in var3.transition_points) {
        var7 = var3.stealth_group;
        var8 = var6 scripts\engine\utility::get_linked_structs();

        foreach(var10 in var8) {
          foreach(var12 in var10.containing_regions) {
            if(var12.stealth_group == var7) {
              var13 = var6.transitions.size;
              var6.transitions[var13] = var10;

              if(!isDefined(var10.transitions)) {
                var10.transitions = [];
              }

              if(!scripts\engine\utility::array_contains(var10.transitions, var6)) {
                var13 = var10.transitions.size;
                var10.transitions[var13] = var6;
              }

              if(!scripts\engine\utility::array_contains(var12.transition_points, var10)) {
                var13 = var12.transition_points.size;
                var12.transition_points[var13] = var10;
              }

              break;
            }
          }
        }

        if(var6.transitions.size == 0) {
          var4 = var16;
        }
      }

      foreach(var16 in var4) {
        scripts\engine\utility::array_remove_index(var3.transition_points, var16, 0);
      }
    }
  }
}

function buildhuntstealthgroupgraphdata() {
  foreach(var1 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var3 in var1.hunt_regions) {
      var3.region_links = [];

      foreach(var5 in var3.transition_points) {
        foreach(var7 in var5.transitions) {
          var8 = undefined;

          foreach(var10 in var7.containing_regions) {
            if(var10.stealth_group == var3.stealth_group) {
              var8 = var10;
              break;
            }
          }

          if(!isDefined(var8)) {
            continue;
          }

          var12 = spawnStruct();
          var12.region = var8;
          var12.transition_point = var5;
          var12.transition_to_point = var7;
          var13 = var3.region_links.size;
          var3.region_links[var13] = var12;
        }
      }
    }

    foreach(var3 in var1.hunt_regions) {
      if(var3.route_points.size == 0) {
        continue;
      }

      if(var3.route_points.size == 1) {
        var3.approx_location = var3.route_points[0].origin;
        continue;
      }

      var18 = 0;
      var19 = 0;
      var20 = 1;

      for(var20 = 1; var20 < var3.route_points.size; var20++) {
        var19 = length(var3.route_points[var20].origin - var3.route_points[var20 - 1].origin);
        var18 += var19;
      }

      var18 *= 0.5;

      for(var20 = 0; var20 < var3.route_points.size - 1; var20++) {
        var19 = length(var3.route_points[var20].origin - var3.route_points[var20 + 1].origin);

        if(var18 - var19 < 0) {
          break;
        }

        var18 -= var19;
      }

      var21 = var18 / var19;
      var3.approx_location = vectorlerp(var3.route_points[var20].origin, var3.route_points[var20 + 1].origin, var21);
    }
  }
}

function cleanuphuntbuilddata(var0) {
  foreach(var2 in var0) {
    var2.containing_regions = undefined;
    var2.transitions = undefined;
  }

  foreach(var5 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var7 in var5.hunt_regions) {
      var7.transition_points = undefined;
    }
  }
}

function inithuntregiondata() {
  var0 = getEntArray("info_volume_stealth_clear", "classname");
  var1 = gethuntstealthgroups(var0);
  var2 = gethuntroutepoints();
  var3 = [];
  var4 = gethuntstealthgroupvolumelists(var1, var0);
  level.hunt_region_load.hunt_stealth_group_region_sets = [];

  foreach(var36, var6 in var4) {
    level.hunt_region_load.hunt_stealth_group_region_sets[var36] = spawnStruct();
    level.hunt_region_load.hunt_stealth_group_region_sets[var36].hunt_regions = [];
    level.hunt_region_load.hunt_stealth_group_region_sets[var36].target_score = 0;

    foreach(var8 in var6) {
      var9 = spawnStruct();
      var9.volume = var8;
      var9.index = var19;
      var9.approx_location = (0, 0, 0);
      var9.bfs_distance = 100000;
      var9.bfs_score = 100000;
      var9.cooldown = 20000;
      var10 = var3[var8 getentitynumber()];

      if(!isDefined(var10)) {
        var10 = spawnStruct();
        var10.bfs_assigned = 0;
        var10.max_enemies = 2;
        var10.bfs_cooldown = 0;
        var10.in_region = 0;
        var10.player_in_region = 0;
        var10.assign_window = 0;
        var3 = var10;
      }

      var9.shared_data = var10;

      if(isDefined(var8.script_count)) {
        var10.max_enemies = var8.script_count;
      }

      if(isDefined(var8.script_timer)) {
        var10.cooldown = var8.script_timer;
      }

      var9.stealth_group = var36;
      var9.route_points = [];
      var9.transition_points = [];

      foreach(var12 in var2) {
        if(ispointinvolume(var12.origin, var8)) {
          var13 = var9.route_points.size;
          var9.route_points[var13] = var12;

          if(!isDefined(var12.containing_regions)) {
            var12.containing_regions = [];
          }

          var13 = var12.containing_regions.size;
          var12.containing_regions[var13] = var9;
          var14 = var12 scripts\engine\utility::get_linked_structs();

          if(var14.size != 0) {
            var13 = var9.transition_points.size;
            var9.transition_points[var13] = var12;
          }
        }
      }

      if(var9.route_points.size == 0) {}

      var9.smart_objects = [];

      foreach(var17 in anim.smartobjectpoints) {
        if(ispointinvolume(var17.origin, var8)) {
          var13 = var9.smart_objects.size;
          var9.smart_objects[var13] = var17;
        }
      }

      var13 = level.hunt_region_load.hunt_stealth_group_region_sets[var36].hunt_regions.size;
      level.hunt_region_load.hunt_stealth_group_region_sets[var36].hunt_regions[var13] = var9;
    }

    foreach(var9 in level.hunt_region_load.hunt_stealth_group_region_sets[var36].hunt_regions) {
      if(var9.route_points.size == 0) {
        continue;
      }

      var21 = -1;

      for(var22 = 0; var22 < var9.route_points.size; var22++) {
        var12 = var9.route_points[var22];
        var23 = var12.targetname;

        if(!isDefined(var23)) {
          if(var21 != -1) {
            var24 = var12.origin;
          }

          var21 = var22;
          continue;
        }

        var25 = undefined;

        foreach(var27 in var9.route_points) {
          if(isDefined(var27.target) && var27.target == var23) {
            var25 = var27;
          }
        }

        if(!isDefined(var25)) {
          if(var21 != -1) {}

          var21 = var22;
        }
      }

      if(var21 == -1) {
        var21 = 0;
      }

      var29 = [];
      var30 = var21;
      var29 = var9.route_points[var30];

      for(var22 = 1; var22 < var9.route_points.size; var22++) {
        var12 = var9.route_points[var30];
        var31 = var12.target;
        var32 = 0;
        var33 = undefined;

        while(var32 < var9.route_points.size) {
          var34 = var9.route_points[var32];
          var23 = var34.targetname;

          if(isDefined(var23) && var31 == var23) {
            var33 = var34;
            break;
          }

          var32++;
        }

        if(isDefined(var33)) {}

        var29 = var33;
        var30 = var32;
      }

      var9.route_points = var29;
    }
  }

  var3 = undefined;

  foreach(var38 in var2) {
    if(isDefined(var38.containing_regions)) {}
  }

  buildhuntstealthgrouptransitiondata();
  buildhuntstealthgroupgraphdata();
  cleanuphuntbuilddata(var2);
}

function huntcomputeaiindependentregionscores(var0, var1) {
  var2 = var1.hunt_regions.size;

  for(var3 = 0; var3 < var2; var3++) {
    var4 = var1.hunt_regions[var3];
    var4.bfs_score = 1;
    var4.shared_data.player_in_region = 0;
  }

  foreach(var6 in level.players) {
    if(!var6 scripts\engine\utility::ent_flag_exist("stealth_enabled") || !var6 scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }

    for(var3 = 0; var3 < var2; var3++) {
      var4 = var1.hunt_regions[var3];
      var4.bfs_visited = 0;
    }

    var7 = undefined;
    var8 = 1e+20;

    for(var3 = 0; var3 < var2; var3++) {
      var4 = var1.hunt_regions[var3];

      if(ispointinvolume(var6.origin, var4.volume)) {
        var7 = var4;
        break;
      }

      var9 = lengthsquared(var4.approx_location - var6.origin);

      if(var9 < var8) {
        var8 = var9;
        var7 = var4;
      }
    }

    var7.shared_data.player_in_region = 1;
    var10 = [var7];
    var7.bfs_visited = 1;
    var9 = 0;
    var11 = 0;

    while(var11 < var10.size) {
      var12 = var10.size;

      for(var13 = var11; var13 < var12; var13++) {
        var4 = var10[var13];
        var4.bfs_score = var9 * var4.bfs_score;
        var4.bfs_visited = 1;
        var4.bfs_distance = var9;
        var14 = var4.region_links.size;

        for(var15 = 0; var15 < var14; var15++) {
          var16 = var4.region_links[var15];

          if(!var16.region.bfs_visited) {
            var10 = var16.region;
            var16.region.bfs_visited = 1;
          }
        }
      }

      var11 = var12;
      var9++;
    }
  }

  var18 = 1;

  for(var3 = 0; var3 < var2; var3++) {
    var4 = var1.hunt_regions[var3];
    var18 = max(var4.bfs_score, var18);
  }

  for(var3 = 0; var3 < var2; var3++) {
    var4 = var1.hunt_regions[var3];
    var4.bfs_score /= var18;
    var4.bfs_visited = undefined;
  }
}

function huntassigntoregion(var0) {
  if(isDefined(self.stealth.cleardata)) {
    self.stealth.cleardata.curregion = var0;
    huntincaiassignment(var0);
    return;
  }
}

function huntunassignfromregion(var0) {
  if(isDefined(self.stealth.cleardata.curregion) && self.stealth.cleardata.curregion == var0) {
    huntdecaiassignment(var0);
    return;
  }
}

function huntincaiassignment(var0) {
  var0.shared_data.bfs_assigned += 1;
  hunttrytoenterregionvolume(var0);
}

function huntdecaiassignment(var0) {
  var0.shared_data.bfs_assigned -= 1;
  hunttrytoexitregionvolume(var0);

  if(var0.shared_data.in_region == 0) {
    var0.shared_data.bfs_cooldown = gettime() + var0.cooldown;
    return;
  }
}

function hunttrytoenterregionvolume(var0) {
  if(!self.stealth.cleardata.isinregion && ispointinvolume(self.origin, var0.volume)) {
    var0.shared_data.in_region += 1;
    self.stealth.cleardata.isinregion = 1;

    if(var0.shared_data.player_in_region && var0.shared_data.in_region == 1) {
      var1 = 1000;
      var0.shared_data.assign_window = gettime() + var1;
      return;
    }

    return;
  }
}

function hunttrytoexitregionvolume(var0) {
  if(self.stealth.cleardata.isinregion) {
    var0.shared_data.in_region -= 1;
    self.stealth.cleardata.isinregion = 0;
    return;
  }
}

function huntgetnextregion() {
  var0 = self.stealth.cleardata.curregion;

  if(var0.region_links.size == 0) {
    return;
  }

  if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group])) {
    return;
  }

  var1 = undefined;
  var2 = gettime();
  var3 = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score;
  var4 = 1;

  foreach(var6 in level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].hunt_regions) {
    if(var6 == var0) {
      continue;
    }

    if(var6.shared_data.bfs_cooldown > gettime()) {
      continue;
    }

    if(var6.shared_data.player_in_region && var6.shared_data.in_region > 0 && var2 > var6.shared_data.assign_window) {
      continue;
    }

    if(self.stealth.cleardata.prevregion[0] == var6 || self.stealth.cleardata.prevregion[1] == var6) {
      continue;
    }

    if(self.script_stealth_region_group != var6.stealth_group) {
      continue;
    }

    if(var6.shared_data.bfs_assigned >= var6.shared_data.max_enemies) {
      continue;
    }

    var7 = abs(var3 - var6.bfs_score);

    if(var7 < var4) {
      var1 = var6;
      var4 = var7;
    }
  }

  if(!isDefined(var1)) {
    var1 = var0.region_links[0].region;
  }

  huntunassignfromregion(var0);
  self.stealth.cleardata.prevregion[0] = self.stealth.cleardata.prevregion[1];
  self.stealth.cleardata.prevregion[1] = self.stealth.cleardata.curregion;
  huntassigntoregion(var1);
  var3 += 0.5;

  if(var3 > 1) {
    var3 = 0;
  }

  level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score = var3;
}