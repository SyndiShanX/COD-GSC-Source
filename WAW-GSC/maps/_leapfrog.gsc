/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_leapfrog.gsc
*****************************************************/

#include maps\_utility;

main() {
  level.leap_delay_min = 6;
  level.leap_delay_max = 14;
  level.leap_delay_override = false;
  level.leapfrog_max_node_ai = 6;
  level.leap_node_array = [];
  level.leapfrog_random_int = randomint(5);
  createthreatbiasgroup("leapfrog");
  setthreatbiasagainstall("leapfrog", -200);
  level thread leapfrog_masterthread();
}

leapfrog_masterthread() {
  while (true) {
    if(!level.leap_delay_override)
      wait(randomFloatRange(level.leap_delay_min, level.leap_delay_max));
    else
      wait .05;
    level.leap_delay_override = false;
    level.leapfrog_random_int = randomint(5);
    node_arr = [];
    high_weight = -1000000;
    if(!level.leap_node_array.size) {
      continue;
    }
    for (i = 0; i < level.leap_node_array.size; i++) {
      weight = level.leap_node_array[i].leap_weight;
      if(!isDefined(node_arr[weight]))
        node_arr[weight] = [];
      node_arr[weight][node_arr[weight].size] = level.leap_node_array[i];
      if(weight > high_weight)
        high_weight = weight;
    }
    assertEx(isDefined(node_arr[high_weight]), "high_weight is: " + high_weight);
    assertEx(isDefined(high_weight >= 0), "high_weight is below zero: " + high_weight);
    node = node_arr[high_weight][randomint(node_arr[high_weight].size)];
    assert(isDefined(node.target));
    node_arr = getnodearray(node.target, "targetname");
    next_node = node_arr[randomint(node_arr.size)];
    if(isDefined(next_node.leapfrog_ai_count))
      next_node.leapfrog_future_ai_count = next_node.leapfrog_ai_count;
    else
      next_node.leapfrog_future_ai_count = 0;
    array_thread(level.leap_node_array, ::increment_leap_weight, node);
    new_weight = int(node.leap_weight * -.25);
    if(isDefined(next_node.leap_weight))
      new_weight += next_node.leap_weight;
    add_leap_node(next_node, new_weight);
    node notify("leapfrog", next_node);
    remove_leap_node(node);
  }
}

increment_leap_weight(node) {
  if(self == node) {
    return;
  }
  diff_weight = node.leap_weight - self.leap_weight;
  self.leap_weight += (int(diff_weight * 0.5) + 1);
}

leapfrog() {
  self endon("death");
  self endon("stop_leapfrog");
  self notify("stop_going_to_node");
  node_arr = getnodearray(self.target, "targetname");
  node = node_arr[randomint(node_arr.size)];
  while (true) {
    if(node.radius != 0)
      self.goalradius = node.radius;
    if(isDefined(node.height))
      self.goalheight = node.height;
    self setgoalnode(node);
    old_maxsightdistsqrd = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 350 * 350;
    old_group = self getthreatbiasgroup();
    self setthreatbiasgroup("leapfrog");
    self waittill("goal");
    node notify("trigger", self);
    self.maxsightdistsqrd = old_maxsightdistsqrd;
    self setthreatbiasgroup(old_group);
    self thread leapfrog_on_death(node);
    if(!isDefined(node.target)) {
      break;
    }
    if(isDefined(node.script_delay)) {
      node script_delay();
      node_arr = getnodearray(node.target, "targetname");
      next_node = node_arr[level.leapfrog_random_int % node_arr.size];
    } else {
      if(!add_leap_node(node)) {
        break;
      }
      node waittill("leapfrog", next_node);
      next_node.leapfrog_future_ai_count++;
      max_node_ai = level.leapfrog_max_node_ai;
      if(isDefined(node.script_noteworthy))
        max_node_ai = int(node.script_noteworthy);
      if(next_node.leapfrog_future_ai_count > max_node_ai) {
        level.leap_delay_override = true;
        if(isDefined(next_node.leap_weight)) {
          next_node.leap_weight += 1;
        }
        next_node = node;
      }
    }
    node = next_node;
  }
  level notify("leapfrog_completed", self);
}

leapfrog_on_death(node) {
  node endon("leapfrog");
  if(!isDefined(node.leapfrog_ai_count))
    node.leapfrog_ai_count = 0;
  node.leapfrog_ai_count++;
  self waittill("death");
  node.leapfrog_ai_count--;
  if(isDefined(node.leap_weight)) {
    new_weight = node.leap_weight - 1;
    if(new_weight < 1)
      new_weight = 1;
    node.leap_weight = new_weight;
  }
  if(!node.leapfrog_ai_count)
    remove_leap_node(node);
}

add_leap_node(node, weight) {
  if(!isDefined(node.target) || isDefined(node.script_delay))
    return false;
  if(getdvar("debug") == "1")
    node thread debug_leap_node();
  if(!is_in_array(level.leap_node_array, node)) {
    level.leap_node_array = array_add(level.leap_node_array, node);
    node.leap_weight = 0;
  }
  if(isDefined(weight))
    node.leap_weight = weight;
  else
    node.leap_weight += 2;
  return true;
}

remove_leap_node(node) {
  node.leap_weight = undefined;
  node.leapfrog_ai_count = undefined;
  level.leap_node_array = array_remove(level.leap_node_array, node);
}

debug_leap_node() {
  if(isDefined(self.debug_leapnode))
    return;
  self.debug_leapnode = true;
  while (true) {
    if(isDefined(self.leap_weight))
      self thread print3Dmessage(self.leap_weight, .5);
    if(isDefined(self.leapfrog_ai_count))
      self thread print3Dmessage(self.leapfrog_ai_count, 0.5, (1, 0, 0), (0, 0, 128), 3);
    wait .5;
  }
}

print3Dmessage(message, show_time, color, offset, scale) {
  if(!isDefined(color))
    color = (0.5, 1, 0.5);
  if(!isDefined(offset))
    offset = (0, 0, 56);
  if(!isDefined(scale))
    scale = 6;
  show_time = gettime() + (show_time * 1000);
  while (gettime() < show_time) {
    print3d(self.origin + offset, message, color, 1, scale);
    wait(0.05);
  }
}