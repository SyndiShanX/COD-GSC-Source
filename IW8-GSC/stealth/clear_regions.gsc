/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\clear_regions.gsc
***********************************************/

init_hunt_regions() {
  if(!isDefined(level.hunt_region_load)) {
    level.hunt_region_load = spawnStruct();
    inithuntregiondata();
  }

  if(isDefined(level.stealth)) {
    level.stealth.hunt_stealth_group_region_sets = level.hunt_region_load.hunt_stealth_group_region_sets;
    level.hunt_region_load = undefined;
  }
}

findnextpointofinterest(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = var_2;
  var_5 = var_0;
  var_6 = min(var_1.bfs_distance, 3);
  var_7 = 48 * (1 + var_6);
  var_8 = 84 * (1 + var_6);

  while(var_3 && var_4 < var_1.route_points.size || !var_3 && var_4 >= 0) {
    var_9 = var_1.route_points[var_4].origin;
    var_10 = scripts\smartobjects\utility::getbestsmartobjectalongline(var_5, var_9, var_1, undefined, var_7, var_8, 0);

    if(isDefined(var_10)) {
      var_11 = var_5;

      if(var_3 && var_4 - 1 >= 0)
        var_11 = var_1.route_points[var_4 - 1].origin;
      else if(!var_3 && var_4 + 1 < var_1.route_points.size)
        var_11 = var_1.route_points[var_4 + 1].origin;

      var_12 = var_9 - var_11;
      var_13 = length(var_12);
      var_12 = var_12 / var_13;
      var_14 = var_4 == var_2 && (var_2 == 0 && var_3 || var_2 == var_1.route_points.size && !var_3);

      if(var_14 || vectordot(var_12, var_10.origin - var_11) > var_13 - 24) {
        if(var_3)
          return [var_10, var_4 + 1];
        else
          return [var_10, var_4 - 1];
      }

      return [var_10, var_4];
    }

    var_15 = distance2d(var_5, var_9);
    var_7 = max(var_7 - var_15, 0);
    var_8 = max(var_8 - var_15, 0);
    var_5 = var_9;

    if(var_3) {
      var_4++;
      continue;
    }

    var_4--;
  }
}

findcurposonroute(var_0, var_1) {
  var_2 = var_1.size;
  var_3 = 0;
  var_4 = -1;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = (var_5 + 1) % var_2;
    var_7 = var_1[var_6].origin - var_1[var_5].origin;
    var_8 = length(var_7);
    var_7 = var_7 / var_8;
    var_9 = var_0 - var_1[var_5].origin;
    var_10 = vectordot(var_7, var_9);

    if(var_3 > 0 && (var_10 < 0 || var_10 > var_8)) {
      continue;
    }
    var_11 = (var_7[1], -1 * var_7[0], 0);
    var_11 = vectorNormalize(var_11);
    var_12 = abs(vectordot(var_11, var_9));

    if(var_3 <= 0 || var_12 < var_3) {
      var_3 = var_12;
      var_4 = var_6;
    }
  }

  return var_4;
}

getregionforpos(var_0) {
  var_1 = 1000000000;
  var_2 = undefined;
  var_3 = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group];

  if(!isDefined(var_3))
    return undefined;

  foreach(var_5 in var_3.hunt_regions) {
    if(!isDefined(self.script_stealth_region_group) || self.script_stealth_region_group != var_5.stealth_group) {
      continue;
    }
    if(ispointinvolume(var_0, var_5.volume))
      return var_5;

    var_6 = lengthsquared(var_5.approx_location - self.origin);

    if(var_6 < var_1) {
      var_1 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

gethuntstealthgroups(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = strtok(var_3.script_stealth_region_group, "_encstr_974C0246");

    foreach(var_6 in var_4)
    var_1[var_1.size] = var_6;
  }

  return scripts\engine\utility::array_remove_duplicates(var_1);
}

gethuntroutepoints() {
  var_0 = [];

  foreach(var_2 in level.struct) {
    if(isDefined(var_2.script_stealth_clear) && var_2.script_stealth_clear == 1) {
      var_3 = var_2;
      var_3.transitions = [];
      var_4 = var_0.size;
      var_3.index = var_4;
      var_0[var_4] = var_3;
    }
  }

  return var_0;
}

gethuntstealthgroupvolumelists(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2[var_4] = [];

    foreach(var_6 in var_1) {
      if(issubstr(var_6.script_stealth_region_group, var_4)) {
        var_7 = var_2[var_4].size;
        var_2[var_4][var_7] = var_6;
      }
    }
  }

  return var_2;
}

buildhuntstealthgrouptransitiondata() {
  foreach(var_20, var_1 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var_3 in var_1.hunt_regions) {
      var_4 = [];

      foreach(var_16, var_6 in var_3.transition_points) {
        var_7 = var_3.stealth_group;
        var_8 = var_6 scripts\engine\utility::get_linked_structs();

        foreach(var_10 in var_8) {
          foreach(var_12 in var_10.containing_regions) {
            if(var_12.stealth_group == var_7) {
              var_13 = var_6.transitions.size;
              var_6.transitions[var_13] = var_10;

              if(!isDefined(var_10.transitions))
                var_10.transitions = [];

              if(!scripts\engine\utility::array_contains(var_10.transitions, var_6)) {
                var_13 = var_10.transitions.size;
                var_10.transitions[var_13] = var_6;
              }

              if(!scripts\engine\utility::array_contains(var_12.transition_points, var_10)) {
                var_13 = var_12.transition_points.size;
                var_12.transition_points[var_13] = var_10;
              }

              break;
            }
          }
        }

        if(var_6.transitions.size == 0)
          var_4[var_4.size] = var_16;
      }

      foreach(var_16 in var_4)
      scripts\engine\utility::array_remove_index(var_3.transition_points, var_16, 0);
    }
  }
}

buildhuntstealthgroupgraphdata() {
  foreach(var_23, var_1 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var_3 in var_1.hunt_regions) {
      var_3.region_links = [];

      foreach(var_5 in var_3.transition_points) {
        foreach(var_7 in var_5.transitions) {
          var_8 = undefined;

          foreach(var_10 in var_7.containing_regions) {
            if(var_10.stealth_group == var_3.stealth_group) {
              var_8 = var_10;
              break;
            }
          }

          if(!isDefined(var_8)) {
            continue;
          }
          var_12 = spawnStruct();
          var_12.region = var_8;
          var_12.transition_point = var_5;
          var_12.transition_to_point = var_7;
          var_13 = var_3.region_links.size;
          var_3.region_links[var_13] = var_12;
        }
      }
    }

    foreach(var_3 in var_1.hunt_regions) {
      if(var_3.route_points.size == 0) {
        continue;
      }
      if(var_3.route_points.size == 1) {
        var_3.approx_location = var_3.route_points[0].origin;
        continue;
      }

      var_18 = 0;
      var_19 = 0;
      var_20 = 1;

      for(var_20 = 1; var_20 < var_3.route_points.size; var_20++) {
        var_19 = length(var_3.route_points[var_20].origin - var_3.route_points[var_20 - 1].origin);
        var_18 = var_18 + var_19;
      }

      var_18 = var_18 * 0.5;

      for(var_20 = 0; var_20 < var_3.route_points.size - 1; var_20++) {
        var_19 = length(var_3.route_points[var_20].origin - var_3.route_points[var_20 + 1].origin);

        if(var_18 - var_19 < 0) {
          break;
        }

        var_18 = var_18 - var_19;
      }

      var_21 = var_18 / var_19;
      var_3.approx_location = vectorlerp(var_3.route_points[var_20].origin, var_3.route_points[var_20 + 1].origin, var_21);
    }
  }
}

cleanuphuntbuilddata(var_0) {
  foreach(var_2 in var_0) {
    var_2.containing_regions = undefined;
    var_2.transitions = undefined;
  }

  foreach(var_9, var_5 in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(var_7 in var_5.hunt_regions)
    var_7.transition_points = undefined;
  }
}

inithuntregiondata() {
  var_0 = getEntArray("_encstr_A3511A9BB54AF7CE56A770A0B79D0607939F07918B02CF3124A71090", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = gethuntstealthgroups(var_0);
  var_2 = gethuntroutepoints();
  var_3 = [];
  var_4 = gethuntstealthgroupvolumelists(var_1, var_0);
  level.hunt_region_load.hunt_stealth_group_region_sets = [];

  foreach(var_36, var_6 in var_4) {
    level.hunt_region_load.hunt_stealth_group_region_sets[var_36] = spawnStruct();
    level.hunt_region_load.hunt_stealth_group_region_sets[var_36].hunt_regions = [];
    level.hunt_region_load.hunt_stealth_group_region_sets[var_36].target_score = 0.0;

    foreach(var_19, var_8 in var_6) {
      var_9 = spawnStruct();
      var_9.volume = var_8;
      var_9.index = var_19;
      var_9.approx_location = (0, 0, 0);
      var_9.bfs_distance = 100000;
      var_9.bfs_score = 100000;
      var_9.cooldown = 20000;
      var_10 = var_3[var_8 getentitynumber()];

      if(!isDefined(var_10)) {
        var_10 = spawnStruct();
        var_10.bfs_assigned = 0;
        var_10.max_enemies = 2;
        var_10.bfs_cooldown = 0;
        var_10.in_region = 0;
        var_10.player_in_region = 0;
        var_10.assign_window = 0;
        var_3[var_8 getentitynumber()] = var_10;
      }

      var_9.shared_data = var_10;

      if(isDefined(var_8.script_count))
        var_10.max_enemies = var_8.script_count;

      if(isDefined(var_8.script_timer))
        var_10.cooldown = var_8.script_timer;

      var_9.stealth_group = var_36;
      var_9.route_points = [];
      var_9.transition_points = [];

      foreach(var_12 in var_2) {
        if(ispointinvolume(var_12.origin, var_8)) {
          var_13 = var_9.route_points.size;
          var_9.route_points[var_13] = var_12;

          if(!isDefined(var_12.containing_regions))
            var_12.containing_regions = [];

          var_13 = var_12.containing_regions.size;
          var_12.containing_regions[var_13] = var_9;
          var_14 = var_12 scripts\engine\utility::get_linked_structs();

          if(var_14.size != 0) {
            var_13 = var_9.transition_points.size;
            var_9.transition_points[var_13] = var_12;
          }
        }
      }

      if(var_9.route_points.size == 0) {}

      var_9.smart_objects = [];

      foreach(var_17 in anim.smartobjectpoints) {
        if(ispointinvolume(var_17.origin, var_8)) {
          var_13 = var_9.smart_objects.size;
          var_9.smart_objects[var_13] = var_17;
        }
      }

      var_13 = level.hunt_region_load.hunt_stealth_group_region_sets[var_36].hunt_regions.size;
      level.hunt_region_load.hunt_stealth_group_region_sets[var_36].hunt_regions[var_13] = var_9;
    }

    foreach(var_9 in level.hunt_region_load.hunt_stealth_group_region_sets[var_36].hunt_regions) {
      if(var_9.route_points.size == 0) {
        continue;
      }
      var_21 = -1;

      for(var_22 = 0; var_22 < var_9.route_points.size; var_22++) {
        var_12 = var_9.route_points[var_22];
        var_23 = var_12.targetname;

        if(!isDefined(var_23)) {
          if(var_21 != -1)
            var_24 = var_12.origin;

          var_21 = var_22;
          continue;
        }

        var_25 = undefined;

        foreach(var_27 in var_9.route_points) {
          if(isDefined(var_27.target) && var_27.target == var_23)
            var_25 = var_27;
        }

        if(!isDefined(var_25)) {
          if(var_21 != -1) {}

          var_21 = var_22;
        }
      }

      if(var_21 == -1)
        var_21 = 0;

      var_29 = [];
      var_30 = var_21;
      var_29[0] = var_9.route_points[var_30];

      for(var_22 = 1; var_22 < var_9.route_points.size; var_22++) {
        var_12 = var_9.route_points[var_30];
        var_31 = var_12.target;
        var_32 = 0;

        for(var_33 = undefined; var_32 < var_9.route_points.size; var_32++) {
          var_34 = var_9.route_points[var_32];
          var_23 = var_34.targetname;

          if(isDefined(var_23) && var_31 == var_23) {
            var_33 = var_34;
            break;
          }
        }

        if(!isDefined(var_33)) {}

        var_29[var_22] = var_33;
        var_30 = var_32;
      }

      var_9.route_points = var_29;
    }
  }

  var_3 = undefined;

  foreach(var_38 in var_2) {
    if(!isDefined(var_38.containing_regions)) {}
  }

  buildhuntstealthgrouptransitiondata();
  buildhuntstealthgroupgraphdata();
  cleanuphuntbuilddata(var_2);
}

huntcomputeaiindependentregionscores(var_0, var_1) {
  var_2 = var_1.hunt_regions.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1.hunt_regions[var_3];
    var_4.bfs_score = 1;
    var_4.shared_data.player_in_region = 0;
  }

  foreach(var_6 in level.players) {
    if(!var_6 scripts\engine\utility::ent_flag_exist("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46") || !var_6 scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = var_1.hunt_regions[var_3];
      var_4.bfs_visited = 0;
    }

    var_7 = undefined;
    var_8 = 100000000000000000000.0;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = var_1.hunt_regions[var_3];

      if(ispointinvolume(var_6.origin, var_4.volume)) {
        var_7 = var_4;
        break;
      }

      var_9 = lengthsquared(var_4.approx_location - var_6.origin);

      if(var_9 < var_8) {
        var_8 = var_9;
        var_7 = var_4;
      }
    }

    var_7.shared_data.player_in_region = 1;
    var_10 = [var_7];
    var_7.bfs_visited = 1;
    var_9 = 0;

    for(var_11 = 0; var_11 < var_10.size; var_9++) {
      var_12 = var_10.size;

      for(var_13 = var_11; var_13 < var_12; var_13++) {
        var_4 = var_10[var_13];
        var_4.bfs_score = var_9 * var_4.bfs_score;
        var_4.bfs_visited = 1;
        var_4.bfs_distance = var_9;
        var_14 = var_4.region_links.size;

        for(var_15 = 0; var_15 < var_14; var_15++) {
          var_16 = var_4.region_links[var_15];

          if(!var_16.region.bfs_visited) {
            var_10[var_10.size] = var_16.region;
            var_16.region.bfs_visited = 1;
          }
        }
      }

      var_11 = var_12;
    }
  }

  var_18 = 1;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1.hunt_regions[var_3];
    var_18 = max(var_4.bfs_score, var_18);
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1.hunt_regions[var_3];
    var_4.bfs_score = var_4.bfs_score / var_18;
    var_4.bfs_visited = undefined;
  }
}

huntassigntoregion(var_0) {
  if(isDefined(self.stealth.cleardata)) {
    self.stealth.cleardata.curregion = var_0;
    huntincaiassignment(var_0);
  }
}

huntunassignfromregion(var_0) {
  if(isDefined(self.stealth.cleardata.curregion) && self.stealth.cleardata.curregion == var_0)
    huntdecaiassignment(var_0);
}

huntincaiassignment(var_0) {
  var_0.shared_data.bfs_assigned = var_0.shared_data.bfs_assigned + 1;
  hunttrytoenterregionvolume(var_0);
}

huntdecaiassignment(var_0) {
  var_0.shared_data.bfs_assigned = var_0.shared_data.bfs_assigned - 1;
  hunttrytoexitregionvolume(var_0);

  if(var_0.shared_data.in_region == 0)
    var_0.shared_data.bfs_cooldown = gettime() + var_0.cooldown;
}

hunttrytoenterregionvolume(var_0) {
  if(!self.stealth.cleardata.isinregion && ispointinvolume(self.origin, var_0.volume)) {
    var_0.shared_data.in_region = var_0.shared_data.in_region + 1;
    self.stealth.cleardata.isinregion = 1;

    if(var_0.shared_data.player_in_region && var_0.shared_data.in_region == 1) {
      var_1 = 1000;
      var_0.shared_data.assign_window = gettime() + var_1;
    }
  }
}

hunttrytoexitregionvolume(var_0) {
  if(self.stealth.cleardata.isinregion) {
    var_0.shared_data.in_region = var_0.shared_data.in_region - 1;
    self.stealth.cleardata.isinregion = 0;
  }
}

huntgetnextregion() {
  var_0 = self.stealth.cleardata.curregion;

  if(var_0.region_links.size == 0) {
    return;
  }
  if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group])) {
    return;
  }
  var_1 = undefined;
  var_2 = gettime();
  var_3 = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score;
  var_4 = 1.0;

  foreach(var_6 in level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].hunt_regions) {
    if(var_6 == var_0) {
      continue;
    }
    if(var_6.shared_data.bfs_cooldown > gettime()) {
      continue;
    }
    if(var_6.shared_data.player_in_region && var_6.shared_data.in_region > 0 && var_2 > var_6.shared_data.assign_window) {
      continue;
    }
    if(self.stealth.cleardata.prevregion[0] == var_6 || self.stealth.cleardata.prevregion[1] == var_6) {
      continue;
    }
    if(self.script_stealth_region_group != var_6.stealth_group) {
      continue;
    }
    if(var_6.shared_data.bfs_assigned >= var_6.shared_data.max_enemies) {
      continue;
    }
    var_7 = abs(var_3 - var_6.bfs_score);

    if(var_7 < var_4) {
      var_1 = var_6;
      var_4 = var_7;
    }
  }

  if(!isDefined(var_1))
    var_1 = var_0.region_links[0].region;

  huntunassignfromregion(var_0);
  self.stealth.cleardata.prevregion[0] = self.stealth.cleardata.prevregion[1];
  self.stealth.cleardata.prevregion[1] = self.stealth.cleardata.curregion;
  huntassigntoregion(var_1);
  var_3 = var_3 + 0.5;

  if(var_3 > 1.0)
    var_3 = 0.0;

  level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score = var_3;
}