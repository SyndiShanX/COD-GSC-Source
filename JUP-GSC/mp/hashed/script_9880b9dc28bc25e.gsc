/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9880b9dc28bc25e.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_attractor_manager;

function autoexec init() {
  utility::registersharedfunc("zombie_attractor", "init", &function_eb4aeba58080eb81);
  utility::registersharedfunc("zombie_attractor", "addAttractor", &add_attractor);
  utility::registersharedfunc("zombie_attractor", "removeAttractor", &remove_attractor);
  utility::registersharedfunc("zombie_attractor", "addOnSelf", &function_c0d3ba0eab1acba0);
  utility::registersharedfunc("zombie_attractor", "removeOnSelf", &function_6e660434fe00b495);
}

function function_eb4aeba58080eb81() {
  level.active_attractors = [];
  level.var_f0ca262664a2c6c0 = [];
  callback::get_template("zombie") callback::add("damage_point", &function_561a075da0b0a82d);
  thread function_569a4f4cf02304eb();
  thread function_6bc8c49a7e617194();

  thread debug_attractors();
}

function add_attractor(ent_or_struct, priority, range, is_attackable, var_56842bf94d8b7ac, var_6ccde54efc53a1af, var_9c7aa233ebc6c208, override_team, force_reachable) {
  assert(isent(ent_or_struct) || isstruct(ent_or_struct));
  assert(isDefined(ent_or_struct.origin));

  if(!isDefined(ent_or_struct.origin)) {
    return;
  }

  attractor_struct = spawnStruct();
  attractor_struct.source = ent_or_struct;
  attractor_struct.var_6ccde54efc53a1af = var_6ccde54efc53a1af;

  if(isDefined(override_team)) {
    attractor_struct.source.team = override_team;
  }

  attractor_struct.source.team = default_to(attractor_struct.source.team, "allies");
  level function_2e54c576f16fefca(attractor_struct, priority, range, is_attackable, var_56842bf94d8b7ac, var_9c7aa233ebc6c208, force_reachable);
  return attractor_struct;
}

function function_c0d3ba0eab1acba0(ent_or_struct, priority, range, is_attackable, var_56842bf94d8b7ac, var_6ccde54efc53a1af, var_9c7aa233ebc6c208, override_team, force_reachable) {
  assert(isent(ent_or_struct) || isstruct(ent_or_struct));
  assert(isDefined(ent_or_struct.origin));

  if(!isDefined(ent_or_struct.origin)) {
    return;
  }

  attractor_struct = spawnStruct();
  attractor_struct.source = ent_or_struct;
  attractor_struct.var_6ccde54efc53a1af = var_6ccde54efc53a1af;

  if(isDefined(override_team)) {
    attractor_struct.source.team = override_team;
  }

  attractor_struct.source.team = default_to(attractor_struct.source.team, "allies");
  level.var_f0ca262664a2c6c0 = array_add_safe(level.var_f0ca262664a2c6c0, self);
  function_2e54c576f16fefca(attractor_struct, priority, range, is_attackable, var_56842bf94d8b7ac, var_9c7aa233ebc6c208, force_reachable);
  return attractor_struct;
}

function remove_attractor(var_7812e428c8c01551) {
  return level function_a422c7bcf32db693(var_7812e428c8c01551);
}

function function_6e660434fe00b495(var_7812e428c8c01551) {
  return function_a422c7bcf32db693(var_7812e428c8c01551);
}

function function_101e62af9bc09262() {
  potential_attractors = self function_f1739f09a44aa308();

  if(!isDefined(potential_attractors) || potential_attractors.size <= 0) {
    self.target_attractor = undefined;
    return false;
  }

  best_attractor = undefined;
  var_bcf33e4213ba9c82 = [];
  var_1b7d45dcb09f55ab = 1;
  closest_dist_sq = undefined;
  var_4395d5baa680d265 = undefined;

  foreach(attractor in potential_attractors) {
    if(isDefined(var_4395d5baa680d265) && isDefined(attractor.priority) && attractor.priority < var_4395d5baa680d265) {
      break;
    }

    if(isDefined(attractor.var_6ccde54efc53a1af) && ![[attractor.var_6ccde54efc53a1af]](attractor, self)) {
      continue;
    }

    if(isDefined(attractor.source) && is_equal(self.team, attractor.source.team)) {
      continue;
    }

    available_slots = [];
    var_ebfb339599a7eec9 = 0;

    if(attractor.attractor_slots.size > 0) {
      available_slots = [];

      foreach(slot in attractor.attractor_slots) {
        if(!isDefined(slot.assigned_ai) || !isalive(slot.assigned_ai)) {
          available_slots[available_slots.size] = slot;
          continue;
        }

        if(slot.assigned_ai == self) {
          var_ebfb339599a7eec9 = 1;
        }
      }

      if(available_slots.size <= 0 && !var_ebfb339599a7eec9) {
        continue;
      }
    }

    dist_sq = distancesquared(attractor.source.origin, self.origin);

    if(!isDefined(closest_dist_sq) || closest_dist_sq > dist_sq) {
      best_attractor = ter_op(istrue(attractor.var_9c7aa233ebc6c208), undefined, attractor);
      var_bcf33e4213ba9c82 = available_slots;
      var_4395d5baa680d265 = attractor.priority;
      var_1b7d45dcb09f55ab = !var_ebfb339599a7eec9;
      closest_dist_sq = dist_sq;
    }
  }

  self.target_attractor = best_attractor;

  if(var_1b7d45dcb09f55ab) {
    slot = undefined;

    if(var_bcf33e4213ba9c82.size > 0) {
      slot = getclosest(self.origin, var_bcf33e4213ba9c82);
    }

    if(isDefined(self.var_6257f99d508345d4)) {
      self.var_6257f99d508345d4.assigned_ai = undefined;
    }

    self.var_6257f99d508345d4 = slot;

    if(isDefined(slot)) {
      slot.assigned_ai = self;
    }
  }

  return true;
}

function function_da9012234026c32(attractor) {
  if(isDefined(attractor.var_56842bf94d8b7ac)) {
    return [[attractor.var_56842bf94d8b7ac]](attractor, self);
  }

  if(isDefined(self.var_6257f99d508345d4)) {
    return self.var_6257f99d508345d4.origin;
  }

  return attractor.source.origin;
}

function function_b0441752fb8134be() {
  assert(isDefined(self.target_attractor));
  var_ff81381f2596d7da = !isDefined(self.var_a4d8ca24c0fc49c7);
  var_3aa2cc768cd55c4b = !var_ff81381f2596d7da && self.var_a4d8ca24c0fc49c7.time != gettime();
  calculated_goal = undefined;
  var_fca259e17b4d4609 = 0;
  var_6b712f9ab5ed59e2 = 0;

  if(var_3aa2cc768cd55c4b) {
    var_fca259e17b4d4609 = self.var_a4d8ca24c0fc49c7.attractor != self.target_attractor;

    if(!var_fca259e17b4d4609) {
      calculated_goal = function_da9012234026c32(self.target_attractor);
      var_6b712f9ab5ed59e2 = self.var_a4d8ca24c0fc49c7.goal != calculated_goal;
    }
  }

  if(var_ff81381f2596d7da || var_fca259e17b4d4609 || var_6b712f9ab5ed59e2) {
    goal = isDefined(calculated_goal) ? calculated_goal : function_da9012234026c32(self.target_attractor);
    var_8464ccd739176b11 = getclosestpointonnavmesh(goal, self, 0, 0, 0, 1);

    if(!isDefined(var_8464ccd739176b11) && self.target_attractor.force_reachable) {
      var_8464ccd739176b11 = self getclosestreachablepointonnavmesh(goal);
    }

    if(isDefined(var_8464ccd739176b11)) {
      attractor_info = spawnStruct();
      attractor_info.time = gettime();
      attractor_info.attractor = self.target_attractor;
      attractor_info.goal = goal;
      attractor_info.reachable_goal = var_8464ccd739176b11;
      self.var_a4d8ca24c0fc49c7 = attractor_info;
    }
  }

  return self.var_a4d8ca24c0fc49c7;
}

function function_357609ca7ca5486e(attractor_struct, slots_array) {
  assert(isarray(slots_array));
  assert(isstruct(attractor_struct));
  attractor_struct.attractor_slots = slots_array;
}

function function_24879cc9b7867fa9(attractor_struct, attractor_angle) {
  assert(isDefined(attractor_angle));
  assert(istrue(attractor_struct.is_attackable));
  attractor_struct.var_65e051f31ceda285 = attractor_angle;
}

function function_9c76a841ce54201f(attractor_struct) {
  assert(isDefined(attractor_struct));
  ai_list = [];

  if(isDefined(attractor_struct.attractor_slots)) {
    foreach(slot in attractor_struct.attractor_slots) {
      if(isDefined(slot.assigned_ai) && isalive(slot.assigned_ai)) {
        ai_list[ai_list.size] = slot.assigned_ai;
      }
    }
  }

  return ai_list;
}

function function_aa5b896e0db21411(attractor_struct, scriptmodel) {
  assert(isDefined(scriptmodel));
  assert(istrue(attractor_struct.is_attackable));
  assert(scriptmodel.classname == "<dev string:x1c>");
  attractor_struct.var_eb287a759525f0bd = scriptmodel;
  assertex(isDefined(scriptmodel physics_getentityaabb()), "<dev string:x2c>");
}

function function_c7ea973c95733604(attractor_struct, box_origin, var_5288b409a0967c3a, box_angles) {
  assert(istrue(attractor_struct.is_attackable));
  attractor_struct.var_8cf5aa3cb82b52ff = box_origin;
  attractor_struct.var_7bcee312994437a0 = var_5288b409a0967c3a;
  attractor_struct.var_b288c8be0472af21 = box_angles;
}

function function_29dcd907bcbec6df(attractor_struct, origin, angles, radius, num_spots) {
  level endon("game_ended");
  slots = [];

  for(spot_i = 0; spot_i < num_spots; spot_i++) {
    angle_i = math::remap(spot_i, 0, num_spots, 0, 360);
    x = radius * cos(angle_i + angles[1]);
    y = radius * sin(angle_i + angles[1]);
    pos = (x, y, 0) + origin;
    capsule_height = 60;
    capsule_radius = 15;

    if(isDefined(attractor_struct.source) && !attractor_struct.source aiphysicstracepassed(origin + (0, 0, 5), pos + (0, 0, 5), capsule_radius, capsule_height, 1)) {
      if(spot_i % 2 == 1) {
        waitframe();
      }

      continue;
    }

    end_pos = physicstrace(pos + (0, 0, 10), pos - (0, 0, 10));
    pos_on_navmesh = getclosestpointonnavmesh(end_pos);
    slot = spawnStruct();
    slot.origin = pos_on_navmesh;
    slots[slots.size] = slot;
  }

  function_357609ca7ca5486e(attractor_struct, slots);
}

function private function_2e54c576f16fefca(attractor_struct, priority, range, is_attackable, var_56842bf94d8b7ac, var_9c7aa233ebc6c208, force_reachable) {
  attractor_struct.priority = default_to(priority, 0);
  attractor_struct.range = default_to(range, -1);
  attractor_struct.is_attackable = default_to(is_attackable, 0);
  attractor_struct.var_9c7aa233ebc6c208 = default_to(var_9c7aa233ebc6c208, 0);
  attractor_struct.force_reachable = default_to(force_reachable, 0);
  attractor_struct.var_56842bf94d8b7ac = var_56842bf94d8b7ac;
  attractor_struct.attractor_slots = [];

  if(istrue(is_attackable)) {
    function_24879cc9b7867fa9(attractor_struct, 45);
  }

  self.active_attractors = default_to(self.active_attractors, []);
  self.active_attractors = array_add_safe(self.active_attractors, attractor_struct);
}

function private function_a422c7bcf32db693(ent_or_struct) {
  b_removed = 0;
  var_1fb70d5e1716055c = [];

  foreach(attractor in self.active_attractors) {
    if(isDefined(attractor) && attractor == ent_or_struct) {
      b_removed = 1;
      continue;
    }

    if(isDefined(attractor.source) && attractor.source == ent_or_struct) {
      b_removed = 1;
      continue;
    }

    var_1fb70d5e1716055c[var_1fb70d5e1716055c.size] = attractor;
  }

  if(b_removed) {
    self.active_attractors = var_1fb70d5e1716055c;
    return true;
  }

  return false;
}

function private function_569a4f4cf02304eb() {
  level endon("game_ended");
  var_2374a671cd093b08 = 3;
  updated_counter = 0;
  test = 1;

  while(true) {
    zombie_array = getaispeciesarray("all", "zombie");

    if(isDefined(zombie_array)) {
      foreach(ai in zombie_array) {
        if(isDefined(ai) && isalive(ai)) {
          var_b93dbc259331ffc6 = ai function_101e62af9bc09262();

          if(isDefined(ai.target_attractor)) {
            goal_info = ai function_b0441752fb8134be();
            ai._blackboard.zombieattractoristarget = 1;
            ai._blackboard.var_bba2444008510c91 = isDefined(goal_info) ? goal_info.reachable_goal : ai.origin;

            if(istrue(ai.target_attractor.is_attackable)) {
              ai._blackboard.var_e2ff8f281ac0a21d = 1;
              ai._blackboard.var_7e11be2629950382 = ai.target_attractor.source.origin;

              if(isDefined(ai.target_attractor.var_65e051f31ceda285)) {
                ai._blackboard.var_e9e9f730df068f63 = ai.target_attractor.var_65e051f31ceda285;
              }

              attractor_obb = function_490c3f1f3e5b6abe(ai.target_attractor);

              if(isDefined(attractor_obb)) {
                var_29f74ee6f6e9819 = attractor_obb.origin[2] - ai.target_attractor.source.origin[2];
                ai._blackboard.var_7a4d88085517197a = var_29f74ee6f6e9819;
              } else {
                ai._blackboard.var_7a4d88085517197a = 0;
              }
            } else {
              ai._blackboard.var_e2ff8f281ac0a21d = 0;
            }
          } else {
            ai._blackboard.zombieattractoristarget = 0;
          }
        }

        if(var_b93dbc259331ffc6) {
          updated_counter += 1;
        } else {
          updated_counter += 0.1;
        }

        if(updated_counter > var_2374a671cd093b08) {
          updated_counter = 0;
          waitframe();
        }
      }
    }

    waitframe();
    updated_counter = 0;
  }
}

function private function_6bc8c49a7e617194() {
  level endon("game_ended");

  while(true) {
    level function_8ce488c81c794ade();
    var_9f7533d4414a348f = [];
    b_removed = 0;

    foreach(ent in level.var_f0ca262664a2c6c0) {
      if(!isalive(ent)) {
        b_removed = 1;
        continue;
      }

      if(ent function_8ce488c81c794ade()) {
        if(!isDefined(ent.active_attractors) || ent.active_attractors.size <= 0) {
          b_removed = 1;
          continue;
        }
      }

      var_9f7533d4414a348f[var_9f7533d4414a348f.size] = ent;
    }

    if(b_removed) {
      level.var_f0ca262664a2c6c0 = var_9f7533d4414a348f;
    }

    waitframe();
  }
}

function private function_8ce488c81c794ade() {
  b_removed = 0;
  var_1fb70d5e1716055c = [];

  if(!isDefined(self.active_attractors)) {
    self.active_attractors = [];
  }

  foreach(attractor in self.active_attractors) {
    if(!isDefined(attractor) || !isDefined(attractor.source) || !isDefined(attractor.source.origin)) {
      b_removed = 1;
      continue;
    }

    foreach(slot in attractor.attractor_slots) {
      if(isDefined(slot.assigned_ai) && !isalive(slot.assigned_ai)) {
        slot.assigned_ai = undefined;
      }
    }

    var_1fb70d5e1716055c[var_1fb70d5e1716055c.size] = attractor;
  }

  if(b_removed) {
    self.active_attractors = ter_op(var_1fb70d5e1716055c.size <= 0, undefined, var_1fb70d5e1716055c);
  }

  return b_removed;
}

function private function_561a075da0b0a82d(params) {
  if(!isDefined(self.target_attractor)) {
    return;
  }

  obb = function_490c3f1f3e5b6abe(self.target_attractor);

  if(!isDefined(obb)) {
    return;
  }

  var_6d85b80f57609a0d = math::function_6c1e6433c5e5cf79(params.origin, obb.origin, obb.half_size, obb.angles);
  dist_threshold = 32 + default_to(params.radius, 0);

  if(distancesquared(var_6d85b80f57609a0d, params.origin) < squared(dist_threshold)) {
    collision_ent = default_to(self.target_attractor.var_eb287a759525f0bd, self.target_attractor.source);
    collision_ent dodamage(params.damage, params.origin, self, self, params.meansofdeath);
  }
}

function function_490c3f1f3e5b6abe(attractor_struct) {
  if(isDefined(attractor_struct.var_8cf5aa3cb82b52ff) && isDefined(attractor_struct.var_7bcee312994437a0) && isDefined(attractor_struct.var_b288c8be0472af21)) {
    obb = spawnStruct();
    obb.origin = attractor_struct.var_8cf5aa3cb82b52ff;
    obb.half_size = attractor_struct.var_7bcee312994437a0;
    obb.angles = attractor_struct.var_b288c8be0472af21;
    return obb;
  }

  collision_ent = default_to(attractor_struct.var_eb287a759525f0bd, attractor_struct.source);

  if(!isDefined(collision_ent) || !isent(collision_ent)) {
    return undefined;
  }

  if(isPlayer(collision_ent)) {
    return undefined;
  }

  if(collision_ent.classname != "script_model" && collision_ent.classname != "script_brushmodel" && collision_ent.classname != "script_vehicle" && collision_ent.classname != "scriptable") {
    return undefined;
  }

  aabb = collision_ent physics_getentityaabb();

  if(!isDefined(aabb)) {
    return undefined;
  }

  mid_point = vectorlerp(aabb["min"], aabb["max"], 0.5);
  bounds = (aabb["max"] - aabb["min"]) * 0.5;
  obb = spawnStruct();
  obb.origin = mid_point;
  obb.half_size = bounds;
  obb.angles = collision_ent.angles;
  return obb;
}

function private debug_attractors() {
  function_6e7290c8ee4f558b("<dev string:x76>");
  function_a9a864379a098ad6("<dev string:x8b>", "<dev string:xad>", &function_a42573c2443e726b);
  function_a9a864379a098ad6("<dev string:xcf>", "<dev string:xee>", &function_a21a8d430150a412);
  function_a9a864379a098ad6("<dev string:x104>", "<dev string:x12f>", &function_b0384ff098c7e2c9);
  function_a9a864379a098ad6("<dev string:x150>", "<dev string:x177>", &function_53b06be1a4d442b5);
  function_a9a864379a098ad6("<dev string:x19c>", "<dev string:x1c6>", &function_352da1bb7ed454f0);
  function_a9a864379a098ad6("<dev string:x1ee>", "<dev string:x216>", &function_402293d746366a91);
  function_a9a864379a098ad6("<dev string:x239>", "<dev string:x258>", &function_8714e28fdc1b009a);
  function_fe953f000498048f();
  level thread function_41fe772e56b5e549();
}

function private function_a21a8d430150a412() {
  pos = function_9b4c82dba041b23d();
  struct = spawnStruct();
  struct.origin = pos;
  level.test_attractors = array_add_safe(level.test_attractors, struct);
  add_attractor(struct, undefined, 500);
}

function private function_b0384ff098c7e2c9() {
  if(isDefined(level.test_attractors)) {
    sorted = get_array_of_closest(level.players[0].origin, level.test_attractors);
    remove_attractor(sorted[0]);
  }
}

function private function_53b06be1a4d442b5() {
  pos = function_9b4c82dba041b23d();
  zombies = getaispeciesarray("<dev string:x277>", "<dev string:x27f>");
  closest_zombie = get_array_of_closest(level.players[0].origin, zombies)[0];
  struct = spawnStruct();
  struct.origin = pos;
  level.var_ca3f5adca4fa7216 = array_add_safe(level.var_ca3f5adca4fa7216, struct);
  closest_zombie function_c0d3ba0eab1acba0(struct, undefined, 400);
}

function private function_352da1bb7ed454f0() {
  zombies = getaispeciesarray("<dev string:x277>", "<dev string:x27f>");
  closest_zombie = get_array_of_closest(level.players[0].origin, zombies)[0];
  level.var_ca3f5adca4fa7216 = default_to(level.var_ca3f5adca4fa7216, []);

  foreach(struct in level.var_ca3f5adca4fa7216) {
    closest_zombie function_6e660434fe00b495(struct);
  }
}

function private function_402293d746366a91() {
  level.var_6dd0ae652577eb72 = default_to(level.var_6dd0ae652577eb72, 0);

  if(!level.var_6dd0ae652577eb72) {
    level.var_6dd0ae652577eb72 = 1;
    add_attractor(level.players[0], undefined, 500, 1);
    return;
  }

  level.var_6dd0ae652577eb72 = 0;
  remove_attractor(level.players[0]);
}

function private function_8714e28fdc1b009a() {
  pos = function_9b4c82dba041b23d();
  pos -= (0, 0, 4);
  table = spawn("<dev string:x1c>", pos);
  table setModel("<dev string:x286>");
  table.health = 100;
  table disconnectPaths();
  table setCanDamage(1);
  attractor = add_attractor(table, 10, 400, 1);
  function_29dcd907bcbec6df(attractor, attractor.source.origin, attractor.source.angles, 50, 5);
}

function private function_a42573c2443e726b() {
  setDvar(@ "debug_attractors", ter_op(getdvarint(@ "debug_attractors") > 0, 0, 1));
}

function private function_41fe772e56b5e549() {
  level endon("<dev string:x299>");

  while(true) {
    waitframe();

    if(!isDefined(level.active_attractors)) {
      continue;
    }

    if(int(getDvar(@ "debug_attractors", 0)) <= 0) {
      continue;
    }

    level function_f394479d155c8e15();
    ai_array = getaiarray();

    foreach(ai in ai_array) {
      ai function_f394479d155c8e15();
    }
  }
}

function private function_f394479d155c8e15() {
  if(!isDefined(self.active_attractors) || self.active_attractors.size <= 0) {
    return;
  }

  foreach(attractor in self.active_attractors) {
    if(!isDefined(attractor) || !isDefined(attractor.source)) {
      continue;
    }

    function_3554b56e0cccd80f(attractor);
  }
}

function private function_3554b56e0cccd80f(attractor) {
  color = ter_op(self == level, (1, 0, 0), (0, 0, 1));
  scripts\engine\utility::draw_circle(attractor.source.origin, 15, (1, 0, 0), 1, 1, 1);
  range_text = ter_op(attractor.range > 0, "<dev string:x2a7>" + attractor.range, "<dev string:x2b5>");
  collision_ent = default_to(attractor.var_eb287a759525f0bd, attractor.source);
  health_text = ter_op(isDefined(collision_ent.health), "<dev string:x2b9>" + string(default_to(collision_ent.health, 0)), "<dev string:x2b5>");
  record3dtext("<dev string:x2c5>" + string(attractor.priority) + range_text, attractor.source.origin + (0, 0, 32), color);

  if(attractor.is_attackable) {
    record3dtext("<dev string:x2dd>" + health_text, attractor.source.origin + (0, 0, 24), color);
    function_37649543d5c9c828(attractor);
  }

  recordsphere(attractor.source.origin, 15, color);

  if(attractor.range > 0) {
    recordcircle(attractor.source.origin, attractor.range, color);
  }

  foreach(slot in attractor.attractor_slots) {
    slot_color = ter_op(!isDefined(slot.assigned_ai) || !isalive(slot.assigned_ai), (1, 0, 0), (0, 1, 0));
    recordcircle(slot.origin, 5, slot_color);
  }

  if(getdvarint(@ "recorder_enablerec", 0) <= 0) {
    print3d(attractor.source.origin + (0, 0, 32), "<dev string:x2c5>" + string(attractor.priority) + range_text, color);

    if(attractor.is_attackable) {
      print3d(attractor.source.origin + (0, 0, 24), "<dev string:x2dd>" + health_text, color);
    }

    if(attractor.range > 0) {
      draw_circle(attractor.source.origin, attractor.range, color);
    }

    foreach(slot in attractor.attractor_slots) {
      slot_color = ter_op(!isDefined(slot.assigned_ai) || !isalive(slot.assigned_ai), (1, 0, 0), (0, 1, 0));
      draw_circle(slot.origin, 5, slot_color);
    }
  }
}

function private function_37649543d5c9c828(attractor) {
  obb = function_490c3f1f3e5b6abe(attractor);

  if(!isDefined(obb)) {
    return undefined;
  }

  var_1d29919376ad4830[0] = obb.origin + obb.half_size;
  var_1d29919376ad4830[1] = obb.origin + obb.half_size * (1, 1, -1);
  var_1d29919376ad4830[2] = obb.origin + obb.half_size * (-1, 1, -1);
  var_1d29919376ad4830[3] = obb.origin + obb.half_size * (-1, 1, 1);
  var_1d29949376ad4ec9[0] = obb.origin + obb.half_size * (1, -1, 1);
  var_1d29949376ad4ec9[1] = obb.origin + obb.half_size * (1, -1, -1);
  var_1d29949376ad4ec9[2] = obb.origin + obb.half_size * (-1, -1, -1);
  var_1d29949376ad4ec9[3] = obb.origin + obb.half_size * (-1, -1, 1);

  for(i = 0; i < 4; i++) {
    j = i + 1;

    if(j == 4) {
      j = 0;
    }

    if(getdvarint(@ "recorder_enablerec", 0) <= 0) {
      line(var_1d29919376ad4830[i], var_1d29919376ad4830[j], (1, 0, 0), 1, 0, 1);
      line(var_1d29949376ad4ec9[i], var_1d29949376ad4ec9[j], (1, 0, 0), 1, 0, 1);
      line(var_1d29919376ad4830[i], var_1d29949376ad4ec9[i], (1, 0, 0), 1, 0, 1);
    }

    recordline(var_1d29919376ad4830[i], var_1d29919376ad4830[j], (1, 0, 0));
    recordline(var_1d29949376ad4ec9[i], var_1d29949376ad4ec9[j], (1, 0, 0));
    recordline(var_1d29919376ad4830[i], var_1d29949376ad4ec9[i], (1, 0, 0));
  }
}

# /