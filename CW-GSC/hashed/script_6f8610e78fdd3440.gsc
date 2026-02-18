/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6f8610e78fdd3440.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\smart_object;
#using scripts\core_common\struct;
#namespace namespace_5cd4acd8;

function init_hunt_regions() {
  if(!(isDefined(level.hunt_region_load) && isDefined(level.stealth.hunt_stealth_group_region_sets))) {
    level.hunt_region_load = spawnStruct();
    inithuntregiondata();
  }

  if(isDefined(level.stealth)) {
    assert(isDefined(level.hunt_region_load) && isDefined(level.hunt_region_load.hunt_stealth_group_region_sets));
    level.stealth.hunt_stealth_group_region_sets = level.hunt_region_load.hunt_stealth_group_region_sets;
    level.hunt_region_load = undefined;
  }
}

function findnextpointofinterest(curpos, region, var_5a990e80, bforward = 1) {
  var_9a135fe4 = var_5a990e80;
  checkpos = curpos;
  dist = min(region.bfs_distance, 3);
  var_9da4df29 = 48 * (1 + dist);
  var_aea7aa5b = 84 * (1 + dist);

  while(bforward && var_9a135fe4 < region.route_points.size || !bforward && var_9a135fe4 >= 0) {
    var_84ee6edd = region.route_points[var_9a135fe4].origin;
    smartobj = self smart_object::function_a49ba261(checkpos, var_84ee6edd, region, undefined, var_9da4df29, var_aea7aa5b, 0);

    if(isDefined(smartobj)) {
      var_640dd14c = checkpos;

      if(bforward && var_9a135fe4 - 1 >= 0) {
        var_640dd14c = region.route_points[var_9a135fe4 - 1].origin;
      } else if(!bforward && var_9a135fe4 + 1 < region.route_points.size) {
        var_640dd14c = region.route_points[var_9a135fe4 + 1].origin;
      }

      starttoend = var_84ee6edd - var_640dd14c;
      var_e15dea17 = length(starttoend);
      starttoend /= var_e15dea17;
      var_acb91842 = var_9a135fe4 == var_5a990e80 && (var_5a990e80 == 0 && bforward || var_5a990e80 == region.route_points.size && !bforward);
      result = [];
      result[0] = smartobj;
      result[1] = var_9a135fe4;

      if(var_acb91842 || vectordot(starttoend, smartobj.origin - var_640dd14c) > var_e15dea17 - 24) {
        if(bforward) {
          result[1] = var_9a135fe4 + 1;
        } else {
          result[1] = var_9a135fe4 - 1;
        }
      }

      return result;
    }

    var_c22264c1 = distance2d(checkpos, var_84ee6edd);
    var_9da4df29 = max(var_9da4df29 - var_c22264c1, 0);
    var_aea7aa5b = max(var_aea7aa5b - var_c22264c1, 0);
    checkpos = var_84ee6edd;

    if(bforward) {
      var_9a135fe4++;
      continue;
    }

    var_9a135fe4--;
  }
}

function findcurposonroute(curpos, route) {
  var_6a605059 = route.size;
  bestscore = 0;
  var_747c2571 = -1;
  var_5a1a59a4 = -1;
  var_5b94af06 = 0;

  for(var_6bc1390 = 0; var_6bc1390 < var_6a605059; var_6bc1390++) {
    nextpt = (var_6bc1390 + 1) % var_6a605059;
    starttoend = route[nextpt].origin - route[var_6bc1390].origin;
    var_5e9b5f9f = length(starttoend);
    starttoend /= var_5e9b5f9f;
    var_4fbaae92 = curpos - route[var_6bc1390].origin;
    var_98883cf9 = vectordot(starttoend, var_4fbaae92);

    if(bestscore > 0 && (var_98883cf9 < 0 || var_98883cf9 > var_5e9b5f9f)) {
      continue;
    }

    var_bb8e7f0d = (starttoend[1], -1 * starttoend[0], 0);
    var_bb8e7f0d = vectornormalize(var_bb8e7f0d);
    var_c79274d2 = abs(vectordot(var_bb8e7f0d, var_4fbaae92));

    if(bestscore <= 0 || var_c79274d2 < bestscore) {
      bestscore = var_c79274d2;
      var_747c2571 = nextpt;
    }

    if(var_5b94af06 <= 0 || var_c79274d2 < var_5b94af06) {
      if(!isDefined(route[nextpt].var_4ff89bee) || gettime() > route[nextpt].var_4ff89bee) {
        var_5b94af06 = var_c79274d2;
        var_5a1a59a4 = nextpt;
      }
    }
  }

  if(var_5a1a59a4 >= 0) {
    var_747c2571 = var_5a1a59a4;
  }

  assert(var_747c2571 >= 0);
  return var_747c2571;
}

function getregionforpos(pos) {
  mindist = 1000000000;
  var_ccae54a1 = undefined;
  var_945ef26b = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group];

  if(!isDefined(var_945ef26b)) {
    return undefined;
  }

  foreach(region in var_945ef26b.hunt_regions) {
    if(!isDefined(self.script_stealth_region_group) || self.script_stealth_region_group != region.stealth_group) {
      continue;
    }

    if(region.volume istouching(pos)) {
      return region;
    }

    dist = lengthsquared(region.approx_location - self.origin);

    if(dist < mindist) {
      mindist = dist;
      var_ccae54a1 = region;
    }
  }

  return var_ccae54a1;
}

function function_7a946650(msg, index, var_371132fe) {
  idx = string(index);
  target = "<dev string:x38>";
  targetname = "<dev string:x38>";

  if(isDefined(var_371132fe.target)) {
    target = var_371132fe.target;
  }

  if(isDefined(var_371132fe.targetname)) {
    targetname = var_371132fe.targetname;
  }

  transition = "<dev string:x40>";

  if(var_371132fe.transitions.size > 0) {
    transition = "<dev string:x44>";
  }

  println("<dev string:x49>" + msg + "<dev string:x53>" + idx + "<dev string:x5a>" + targetname + "<dev string:x60>" + target + "<dev string:x6a>" + transition);
}

function function_28ec085c() {
  foreach(region in level.stealth.hunt_regions) {
    foreach(point in region.transition_points) {
      foreach(transition in point.transitions) {
        println("<dev string:x70>" + point.index + "<dev string:x75>" + transition.index + "<dev string:x7e>");
      }
    }
  }
}

function gethuntstealthgroups(var_bbf5d56f) {
  var_9e7c8581 = [];

  foreach(volume in var_bbf5d56f) {
    assert(isDefined(volume.script_stealth_region_group), "<dev string:x83>");
    var_86fb4fc6 = strtok(volume.script_stealth_region_group, " ");

    foreach(str in var_86fb4fc6) {
      var_9e7c8581[var_9e7c8581.size] = str;
    }
  }

  var_9e7c8581 = array::function_b1d17853(var_9e7c8581);
  return var_9e7c8581;
}

function gethuntroutepoints(var_bbf5d56f) {
  var_1f7c13ae = struct::get_array("stealth_clearpath", "variantname");
  var_23471399 = [];

  foreach(struct in var_1f7c13ae) {
    var_371132fe = struct;
    var_371132fe.transitions = [];
    size = var_23471399.size;
    var_371132fe.index = size;
    var_23471399[size] = var_371132fe;
  }

  return var_23471399;
}

function gethuntstealthgroupvolumelists(var_9e7c8581, var_bbf5d56f) {
  var_5310ca1e = [];

  foreach(group in var_9e7c8581) {
    var_5310ca1e[group] = [];

    foreach(volume in var_bbf5d56f) {
      if(issubstr(volume.script_stealth_region_group, group)) {
        size = var_5310ca1e[group].size;
        var_5310ca1e[group][size] = volume;
      }
    }
  }

  return var_5310ca1e;
}

function buildhuntstealthgrouptransitiondata() {
  foreach(group_data in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(region in group_data.hunt_regions) {
      var_18b52478 = [];

      foreach(index, transition_point in region.transition_points) {
        stealth_group = region.stealth_group;
        transition_points = struct::get_array(transition_point.target, "targetname");

        foreach(to_point in transition_points) {
          foreach(var_4e481c6b in to_point.containing_regions) {
            if(var_4e481c6b.stealth_group == stealth_group) {
              if(!array::contains(transition_point.transitions, to_point)) {
                transition_point.transitions[transition_point.transitions.size] = to_point;
              }

              if(!isDefined(to_point.transitions)) {
                to_point.transitions = [];
              }

              if(!array::contains(to_point.transitions, transition_point)) {
                to_point.transitions[to_point.transitions.size] = transition_point;
              }

              if(!array::contains(var_4e481c6b.transition_points, to_point)) {
                size = var_4e481c6b.transition_points.size;
                var_4e481c6b.transition_points[size] = to_point;
              }

              break;
            }
          }
        }

        if(transition_point.transitions.size == 0) {
          var_18b52478[var_18b52478.size] = index;
        }
      }

      foreach(index in var_18b52478) {
        array::remove_index(region.transition_points, index, 0);
      }
    }
  }
}

function buildhuntstealthgroupgraphdata() {
  foreach(group_data in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(region in group_data.hunt_regions) {
      region.region_links = [];

      foreach(transition_point in region.transition_points) {
        foreach(var_b568c168 in transition_point.transitions) {
          var_4e481c6b = undefined;

          foreach(var_35862c8b in var_b568c168.containing_regions) {
            if(var_35862c8b.stealth_group == region.stealth_group) {
              var_4e481c6b = var_35862c8b;
              break;
            }
          }

          if(!isDefined(var_4e481c6b)) {
            continue;
          }

          var_2f106193 = spawnStruct();
          var_2f106193.region = var_4e481c6b;
          var_2f106193.transition_point = transition_point;
          var_2f106193.transition_to_point = var_b568c168;
          size = region.region_links.size;
          region.region_links[size] = var_2f106193;
        }
      }
    }

    foreach(region in group_data.hunt_regions) {
      if(region.route_points.size == 0) {
        continue;
      }

      if(region.route_points.size == 1) {
        region.approx_location = region.route_points[0].origin;
        continue;
      }

      var_fb678b1c = 0;
      var_ebcfaa4d = 0;
      i = 1;

      for(i = 1; i < region.route_points.size; i++) {
        var_ebcfaa4d = length(region.route_points[i].origin - region.route_points[i - 1].origin);
        var_fb678b1c += var_ebcfaa4d;
      }

      var_fb678b1c *= 0.5;

      for(i = 0; i < region.route_points.size - 1; i++) {
        var_ebcfaa4d = length(region.route_points[i].origin - region.route_points[i + 1].origin);

        if(var_fb678b1c - var_ebcfaa4d < 0) {
          break;
        }

        var_fb678b1c -= var_ebcfaa4d;
      }

      fraction = var_fb678b1c / var_ebcfaa4d;
      region.approx_location = vectorlerp(region.route_points[i].origin, region.route_points[i + 1].origin, fraction);
    }
  }
}

function cleanuphuntbuilddata(var_23471399) {
  foreach(point in var_23471399) {
    point.containing_regions = undefined;
    point.transitions = undefined;
  }

  foreach(var_57287dad in level.hunt_region_load.hunt_stealth_group_region_sets) {
    foreach(region in var_57287dad.hunt_regions) {
      region.transition_points = undefined;
    }
  }
}

function inithuntregiondata() {
  aiprofile_beginentry("Init Hunt Region Data");
  var_bbf5d56f = getEntArray("info_volume_stealth_clear", "variantname");
  var_9e7c8581 = gethuntstealthgroups(var_bbf5d56f);
  var_23471399 = gethuntroutepoints(var_bbf5d56f);
  var_b8850d25 = [];
  var_ed36f7a7 = gethuntstealthgroupvolumelists(var_9e7c8581, var_bbf5d56f);
  level.hunt_region_load.hunt_stealth_group_region_sets = [];

  foreach(group, var_2e6299dc in var_ed36f7a7) {
    level.hunt_region_load.hunt_stealth_group_region_sets[group] = spawnStruct();
    level.hunt_region_load.hunt_stealth_group_region_sets[group].hunt_regions = [];
    level.hunt_region_load.hunt_stealth_group_region_sets[group].target_score = 0;

    foreach(index, volume in var_2e6299dc) {
      region = spawnStruct();
      region.volume = volume;
      region.index = index;
      region.approx_location = (0, 0, 0);
      region.bfs_distance = 100000;
      region.bfs_score = 100000;
      region.cooldown = 20000;
      shared_data = var_b8850d25[volume getentitynumber()];

      if(!isDefined(shared_data)) {
        shared_data = spawnStruct();
        shared_data.bfs_assigned = 0;
        shared_data.max_enemies = 2;
        shared_data.bfs_cooldown = 0;
        shared_data.in_region = 0;
        shared_data.player_in_region = 0;
        shared_data.assign_window = 0;
        var_b8850d25[volume getentitynumber()] = shared_data;
      }

      region.shared_data = shared_data;

      if(isDefined(volume.script_count)) {
        shared_data.max_enemies = volume.script_count;
      }

      if(isDefined(volume.script_timer)) {
        shared_data.cooldown = volume.script_timer * 1000;
      }

      region.stealth_group = group;
      region.route_points = [];
      region.transition_points = [];

      foreach(point in var_23471399) {
        if(volume istouching(point.origin)) {
          size = region.route_points.size;
          region.route_points[size] = point;

          if(!isDefined(point.containing_regions)) {
            point.containing_regions = [];
          }

          size = point.containing_regions.size;
          point.containing_regions[size] = region;
          var_3eeed7ad = struct::get_array(point.target, "targetname");
          var_3eeed7ad = arraycombine(var_3eeed7ad, struct::get_array(point.targetname, "target"));
          var_3eeed7ad = array::function_b1d17853(var_3eeed7ad);

          foreach(link in var_3eeed7ad) {
            if(link !== point && link.variantname === "stealth_clearpath" && !volume istouching(link.origin)) {
              region.transition_points[region.transition_points.size] = link;
              region.transition_points = array::function_b1d17853(region.transition_points);
            }
          }
        }
      }

      if(region.route_points.size == 0) {
        assertmsg("<dev string:xcb>");
      }

      region.smart_objects = [];

      foreach(smart_object in level.smartobjectpoints) {
        if(volume istouching(smart_object.origin)) {
          size = region.smart_objects.size;
          region.smart_objects[size] = smart_object;
        }
      }

      size = level.hunt_region_load.hunt_stealth_group_region_sets[group].hunt_regions.size;
      level.hunt_region_load.hunt_stealth_group_region_sets[group].hunt_regions[size] = region;
    }

    foreach(region in level.hunt_region_load.hunt_stealth_group_region_sets[group].hunt_regions) {
      if(region.route_points.size == 0) {
        continue;
      }

      startnode = -1;

      for(i = 0; i < region.route_points.size; i++) {
        point = region.route_points[i];
        targetname = point.targetname;

        if(!isDefined(targetname)) {
          if(startnode != -1) {
            orig = point.origin;
            assertmsg("<dev string:xf2>" + orig[0] + "<dev string:x146>" + orig[1] + "<dev string:x146>" + orig[2] + "<dev string:x7e>");
          }

          startnode = i;
          continue;
        }

        var_8bacc3fa = undefined;

        foreach(var_40ad2e7d in region.route_points) {
          if(isDefined(var_40ad2e7d.target) && var_40ad2e7d.target == targetname) {
            var_8bacc3fa = var_40ad2e7d;
          }
        }

        if(!isDefined(var_8bacc3fa)) {
          if(startnode != -1) {
            assertmsg("<dev string:x14c>" + targetname + "<dev string:x7e>");
          }

          startnode = i;
        }
      }

      if(startnode == -1) {
        startnode = 0;
      }

      buffer = [];
      curidx = startnode;
      buffer[0] = region.route_points[curidx];

      for(i = 1; i < region.route_points.size; i++) {
        point = region.route_points[curidx];
        target = point.target;
        j = 0;
        var_e1c83c67 = undefined;

        while(j < region.route_points.size) {
          target_point = region.route_points[j];
          targetname = target_point.targetname;

          if(isDefined(targetname) && target == targetname) {
            var_e1c83c67 = target_point;
            break;
          }

          j++;
        }

        if(!isDefined(var_e1c83c67)) {
          assertmsg("<dev string:x183>");
        }

        buffer[i] = var_e1c83c67;
        curidx = j;
      }

      region.route_points = buffer;
    }
  }

  var_b8850d25 = undefined;

  foreach(var_371132fe in var_23471399) {
    if(!isDefined(var_371132fe.containing_regions)) {
      assertmsg("<dev string:x1ac>" + var_371132fe.origin + "<dev string:x1c2>");
    }
  }

  buildhuntstealthgrouptransitiondata();
  buildhuntstealthgroupgraphdata();
  cleanuphuntbuilddata(var_23471399);
  aiprofile_endentry();
}

function huntcomputeaiindependentregionscores(group, group_data) {
  aiprofile_beginentry("AI Hunt Init Scoring");
  numregions = group_data.hunt_regions.size;

  for(var_3e6a3ff3 = 0; var_3e6a3ff3 < numregions; var_3e6a3ff3++) {
    region = group_data.hunt_regions[var_3e6a3ff3];
    region.bfs_score = 1;
    region.shared_data.player_in_region = 0;
  }

  foreach(player in getplayers()) {
    if(!player flag::exists("stealth_enabled") || !player flag::get("stealth_enabled")) {
      continue;
    }

    for(var_3e6a3ff3 = 0; var_3e6a3ff3 < numregions; var_3e6a3ff3++) {
      region = group_data.hunt_regions[var_3e6a3ff3];
      region.bfs_visited = 0;
    }

    var_924463ec = undefined;
    mindist = 1e+20;

    for(var_3e6a3ff3 = 0; var_3e6a3ff3 < numregions; var_3e6a3ff3++) {
      region = group_data.hunt_regions[var_3e6a3ff3];

      if(region.volume istouching(player.origin)) {
        var_924463ec = region;
        break;
      }

      dist = lengthsquared(region.approx_location - player.origin);

      if(dist < mindist) {
        mindist = dist;
        var_924463ec = region;
      }
    }

    var_924463ec.shared_data.player_in_region = 1;
    var_21487804 = [var_924463ec];
    var_924463ec.bfs_visited = 1;
    dist = 0;
    index = 0;

    while(index < var_21487804.size) {
      stop = var_21487804.size;

      for(i = index; i < stop; i++) {
        region = var_21487804[i];
        region.bfs_score = dist * region.bfs_score;
        region.bfs_visited = 1;
        region.bfs_distance = dist;
        var_d6b10147 = region.region_links.size;

        for(ilink = 0; ilink < var_d6b10147; ilink++) {
          link = region.region_links[ilink];

          if(!link.region.bfs_visited) {
            var_21487804[var_21487804.size] = link.region;
            link.region.bfs_visited = 1;
          }
        }
      }

      index = stop;
      dist++;
    }
  }

  highestscore = 1;

  for(var_3e6a3ff3 = 0; var_3e6a3ff3 < numregions; var_3e6a3ff3++) {
    region = group_data.hunt_regions[var_3e6a3ff3];
    highestscore = max(region.bfs_score, highestscore);
  }

  for(var_3e6a3ff3 = 0; var_3e6a3ff3 < numregions; var_3e6a3ff3++) {
    region = group_data.hunt_regions[var_3e6a3ff3];
    region.bfs_score /= highestscore;
    region.bfs_visited = undefined;
  }

  aiprofile_endentry();
}

function huntassigntoregion(region) {
  if(isDefined(self.stealth.cleardata)) {
    self.stealth.cleardata.curregion = region;
    huntincaiassignment(region);
  }
}

function huntunassignfromregion(region) {
  if(isDefined(self.stealth.cleardata.curregion) && self.stealth.cleardata.curregion == region) {
    huntdecaiassignment(region);
  }
}

function huntincaiassignment(region) {
  region.shared_data.bfs_assigned += 1;
  self hunttrytoenterregionvolume(region);
}

function huntdecaiassignment(region) {
  assert(region.shared_data.bfs_assigned != 0, "<dev string:x1f3>");
  region.shared_data.bfs_assigned -= 1;
  self hunttrytoexitregionvolume(region);

  if(region.shared_data.in_region == 0) {
    region.shared_data.bfs_cooldown = gettime() + region.cooldown;
  }
}

function hunttrytoenterregionvolume(region) {
  if(!self.stealth.cleardata.isinregion && region.volume istouching(self.origin)) {
    assert(self.stealth.cleardata.curregion == region, "<dev string:x231>" + region.index + "<dev string:x24c>");
    region.shared_data.in_region += 1;
    self.stealth.cleardata.isinregion = 1;

    if(region.shared_data.player_in_region && region.shared_data.in_region == 1) {
      var_8a32f5c = 1000;
      region.shared_data.assign_window = gettime() + var_8a32f5c;
    }
  }
}

function hunttrytoexitregionvolume(region) {
  assert(self.stealth.cleardata.curregion == region, "<dev string:x26b>" + region.index + "<dev string:x285>");

  if(self.stealth.cleardata.isinregion) {
    region.shared_data.in_region -= 1;
    self.stealth.cleardata.isinregion = 0;
  }
}

function huntgetnextregion(region) {
  aiprofile_beginentry("Hunt Get Next Reg");

  if(region.region_links.size == 0) {
    aiprofile_endentry();
    return;
  }

  if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group])) {
    aiprofile_endentry();
    return;
  }

  var_161b41f9 = undefined;
  curtime = gettime();
  target_score = level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score;
  var_6036e3a2 = 1;

  foreach(toregion in level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].hunt_regions) {
    if(toregion == region) {
      continue;
    }

    if(toregion.shared_data.bfs_cooldown > gettime()) {
      continue;
    }

    if(toregion.shared_data.player_in_region && toregion.shared_data.in_region > 0 && curtime > toregion.shared_data.assign_window) {
      continue;
    }

    if(self.script_stealth_region_group != toregion.stealth_group) {
      continue;
    }

    if(toregion.shared_data.bfs_assigned >= toregion.shared_data.max_enemies) {
      continue;
    }

    target_dist = abs(target_score - toregion.bfs_score);

    if(target_dist < var_6036e3a2) {
      var_161b41f9 = toregion;
      var_6036e3a2 = target_dist;
    }
  }

  if(!isDefined(var_161b41f9)) {
    var_161b41f9 = region.region_links[0].region;
  }

  self.stealth.cleardata.prevregion[0] = self.stealth.cleardata.prevregion[1];
  self.stealth.cleardata.prevregion[1] = self.stealth.cleardata.curregion;
  target_score += 0.5;

  if(target_score > 1) {
    target_score = 0;
  }

  level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].target_score = target_score;
  aiprofile_endentry();
  return var_161b41f9;
}