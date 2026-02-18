/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2618e0f3e5e11649.gsc
***********************************************/

#using script_19367cd29a4485db;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_40859a8b9c8becd;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#namespace namespace_ce1f29cc;

function function_6b885d72(destination) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  assert(!isDefined(level.hotzones));

  if(!isDefined(level.hotzones)) {
    level.hotzones = [];
  }

  if(!isDefined(level.var_3b4ee947)) {
    level.var_3b4ee947 = [];
  }

  if(!isDefined(level.var_39b4b1e2)) {
    level.var_39b4b1e2 = [];
  }

  if(!isDefined(level.var_f5909b7)) {
    level.var_f5909b7 = [];
  }

  level flag::wait_till(#"hash_39574fd530246717");

  foreach(s_location in destination.locations) {
    hotzones = struct::get_array(s_location.targetname, "target");
    hotzones = function_7b8e26b3(hotzones, "hotzone", "variantname");
    hotzones = function_61f56bb6(hotzones);

    foreach(hotzone in hotzones) {
      function_4aca4e83(hotzone);
      waitframe(1);
    }

    level.hotzones = arraycombine(level.hotzones, hotzones, 0, 0);
  }

  namespace_1125e192::function_93c5a24();
  level flag::clear(#"hash_39574fd530246717");
}

function function_61f56bb6(hotzones) {
  var_be6053fa = [];
  var_c6d0eb25 = [];

  foreach(hotzone in hotzones) {
    if(!isDefined(hotzone.var_c43420a)) {
      var_be6053fa[var_be6053fa.size] = hotzone;
      continue;
    }

    if(!isDefined(var_c6d0eb25[hotzone.var_c43420a])) {
      var_c6d0eb25[hotzone.var_c43420a] = [];
    } else if(!isarray(var_c6d0eb25[hotzone.var_c43420a])) {
      var_c6d0eb25[hotzone.var_c43420a] = array(var_c6d0eb25[hotzone.var_c43420a]);
    }

    var_c6d0eb25[hotzone.var_c43420a][var_c6d0eb25[hotzone.var_c43420a].size] = hotzone;
  }

  foreach(group in var_c6d0eb25) {
    group = array::randomize(group);
    var_7e24bb5a = group[0].var_d3455e4;
    assert(var_7e24bb5a <= group.size);

    for(i = 0; i < var_7e24bb5a; i++) {
      var_be6053fa[var_be6053fa.size] = array::pop_front(group, 0);
    }
  }

  if(isDefined(level.contentmanager.nextspawn)) {
    var_be6053fa = arraysortclosest(var_be6053fa, level.contentmanager.nextspawn.origin, undefined, 2000);
  }

  return var_be6053fa;
}

function function_4aca4e83(var_89bd79c0) {
  tunables = getscriptbundle(var_89bd79c0.scriptbundlename);
  var_89bd79c0.instance = {};
  function_8ff3e9d(var_89bd79c0, tunables);
  function_c43e2960(var_89bd79c0, tunables);
  var_89bd79c0.instance.tier = 1;
  var_89bd79c0.instance.active_ai = [];
  var_89bd79c0.instance.var_4188d7c8 = 0;
  var_89bd79c0.instance.spawned_ai = 0;
  var_89bd79c0.instance.priority = 0;
  var_89bd79c0.instance.var_bb0c9afd = [];
  var_89bd79c0.instance.var_ee69e628 = [];
  var_89bd79c0.instance.var_ac7b2365 = [];

  var_89bd79c0.instance.priority_debug = [];

  function_3c977c4f(var_89bd79c0, 0);
}

function function_8ff3e9d(var_89bd79c0, tunables) {
  if(!isDefined(var_89bd79c0.var_117ccd5c)) {
    var_89bd79c0.var_117ccd5c = function_65c306e7(tunables.var_d5ae73b2);
  }

  if(!isDefined(var_89bd79c0.var_192fb9a2)) {
    var_89bd79c0.var_192fb9a2 = function_65c306e7(tunables.var_1d67b7db);
  }
}

function function_65c306e7(var_71398223) {
  list = [];

  foreach(struct in var_71398223) {
    list[list.size] = struct.var_210a8489;
  }

  return list;
}

function function_c43e2960(var_89bd79c0, tunables) {
  if(isDefined(var_89bd79c0.instance.initial_spawn_points) && isDefined(var_89bd79c0.instance.var_d9c7b945)) {
    return;
  }

  if(!isDefined(var_89bd79c0.spawn_radius)) {
    var_89bd79c0.spawn_radius = var_89bd79c0.radius;
  }

  spawn_points = struct::get_array(var_89bd79c0.targetname, "target");
  initial_spawn_points = function_7b8e26b3(spawn_points, "hotzone_spawn_point_initial", "variantname");
  function_ba8b8ba3(initial_spawn_points);
  initial_spawn_points = function_3759eaa0(var_89bd79c0, initial_spawn_points, int((isDefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0) + (isDefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0) * (isDefined(tunables.var_4dc06056) ? tunables.var_4dc06056 : 0) * 3));
  var_d9c7b945 = function_7b8e26b3(spawn_points, "hotzone_spawn_point_hot", "variantname");
  function_ba8b8ba3(var_d9c7b945);
  var_d9c7b945 = function_3759eaa0(var_89bd79c0, var_d9c7b945, isDefined(tunables.var_783fc5e) ? tunables.var_783fc5e : 0);
  var_89bd79c0.instance.initial_spawn_points = array::randomize(initial_spawn_points);
  var_89bd79c0.instance.var_d9c7b945 = array::randomize(var_d9c7b945);
  var_89bd79c0.instance.var_968f26a5 = [];

  foreach(spawn_point in var_89bd79c0.instance.initial_spawn_points) {
    if(isDefined(spawn_point.aitype)) {
      if(!isDefined(var_89bd79c0.instance.var_968f26a5[spawn_point.aitype])) {
        var_89bd79c0.instance.var_968f26a5[spawn_point.aitype] = 0;
      }
    }
  }

  foreach(spawn_point in var_89bd79c0.instance.var_d9c7b945) {
    if(isDefined(spawn_point.aitype)) {
      if(!isDefined(var_89bd79c0.instance.var_968f26a5[spawn_point.aitype])) {
        var_89bd79c0.instance.var_968f26a5[spawn_point.aitype] = 0;
      }
    }
  }

  var_89bd79c0.instance.var_f2be2673 = [];

  foreach(spawn_point in var_89bd79c0.instance.initial_spawn_points) {
    if(isDefined(spawn_point.archetype)) {
      if(!isDefined(var_89bd79c0.instance.var_f2be2673[spawn_point.archetype])) {
        var_89bd79c0.instance.var_f2be2673[spawn_point.archetype] = 0;
      }
    }
  }

  foreach(spawn_point in var_89bd79c0.instance.var_d9c7b945) {
    if(isDefined(spawn_point.archetype)) {
      if(!isDefined(var_89bd79c0.instance.var_f2be2673[spawn_point.archetype])) {
        var_89bd79c0.instance.var_f2be2673[spawn_point.archetype] = 0;
      }
    }
  }
}

function function_ba8b8ba3(&spawn_points) {
  foreach(point in spawn_points) {
    if(point.var_90d0c0ff === # " ") {
      point.var_90d0c0ff = undefined;
    }

    if(point.archetype === # " ") {
      point.archetype = undefined;
    }
  }
}

function function_3759eaa0(var_89bd79c0, var_9b694d6c, var_36a2355b) {
  if(var_9b694d6c.size <= var_36a2355b) {
    if(!is_true(var_89bd79c0.var_19e89e4e)) {
      var_53911b23 = namespace_85745671::function_e4791424(var_89bd79c0.origin, var_36a2355b - var_9b694d6c.size, var_89bd79c0.spawn_height, var_89bd79c0.spawn_radius, var_89bd79c0.var_243d78a7, 0, 1);
    } else {
      var_53911b23 = namespace_85745671::function_7a1b21f6(var_89bd79c0.origin, var_89bd79c0.angles, var_36a2355b - var_9b694d6c.size, var_89bd79c0.var_499035e2, var_89bd79c0.var_81314a61, var_89bd79c0.spawn_height, 0, 1);
    }

    if(!isarray(var_53911b23)) {
      println("<dev string:x38>" + var_89bd79c0.target);
    }

    if(!isDefined(var_53911b23)) {
      var_53911b23 = [];
    }

    var_9b694d6c = arraycombine(var_9b694d6c, var_53911b23, 0, 0);
  }

  return var_9b694d6c;
}

function deactivate_hotzones(params) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  level notify(#"hash_1a8453d57fb3fe48");
  level flag::wait_till_clear("update_hotzone_states");
  level flag::set("deactivate_hotzones");
  assert(isDefined(params.destination), "<dev string:x88>");
  assert(isarray(params.destination.locations), "<dev string:xbb>");

  foreach(s_location in params.destination.locations) {
    hotzones = struct::get_array(s_location.targetname, "target");
    hotzones = function_7b8e26b3(hotzones, "variantname", "hotzone");

    foreach(hotzone in hotzones) {
      function_ea2997e4(hotzone);
      waitframe(1);
    }
  }

  level.hotzones = undefined;
  level.var_3b4ee947 = undefined;
  level flag::clear("deactivate_hotzones");
}

function function_ea2997e4(var_89bd79c0) {
  if(is_true(var_89bd79c0.instance.var_4188d7c8)) {
    function_e5786b9a(var_89bd79c0);
  }

  foreach(ai in var_89bd79c0.instance.active_ai) {
    if(isDefined(ai)) {
      ai delete();
    }
  }

  var_89bd79c0.instance = undefined;
}

function function_3c977c4f(hotzone, state) {
  if(hotzone.instance.current_state !== state) {
    hotzone.instance.spawn_point_index = 0;
    hotzone.instance.tier = level.var_f534e0;

    if(getdvarint(#"hash_15ed4f1fab002e20", 0)) {
      hotzone.instance.tier = getdvarint(#"hash_15ed4f1fab002e20", 0);
    }

    hotzone.instance.var_1fb426c4 = function_e670bffd(hotzone.scriptbundlename, state);
    hotzone.instance.var_735d3a6b = function_d0e4a026(hotzone.scriptbundlename);
    list_name = function_47ae367f(hotzone, hotzone.instance.tier, state);

    if(isDefined(list_name)) {
      if(!isDefined(hotzone.instance.var_bb0c9afd[state])) {
        hotzone.instance.var_bb0c9afd[state] = namespace_679a22ba::function_77be8a83(list_name);
      }
    }

    hotzone.instance.var_d36a24ed = hotzone.instance.var_bb0c9afd[state];
    hotzone.instance.var_98957c00 = undefined;

    if(state === 2) {
      hotzone.instance.var_3ad2f505 = 0;
      hotzone.instance.var_b4481bdb = hotzone.instance.initial_spawn_points;
    }

    if(hotzone.instance.current_state === 2) {
      hotzone.instance.var_ee69e628 = [];
      hotzone.instance.var_3ad2f505 = undefined;
      hotzone.instance.var_b4481bdb = undefined;
    }
  }

  hotzone.instance.current_state = state;
}

function function_fac3e87c() {
  if(!isDefined(level.hotzones)) {
    println("<dev string:xf6>");
    return [];
  }

  spawns = [];

  foreach(hotzone in level.hotzones) {
    if(!isDefined(hotzone.targetname)) {
      continue;
    }

    spawn_points = struct::get_array(hotzone.targetname, "target");
    spawns = arraycombine(spawn_points, spawns);
  }

  return spawns;
}

function function_e24de31c(params) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  level notify(#"hash_1a8453d57fb3fe48");

  foreach(hotzone in level.hotzones) {
    if(is_true(hotzone.instance.var_4188d7c8)) {
      function_e5786b9a(hotzone);
    }

    function_fb4091d0(hotzone);
    function_3c977c4f(hotzone, 3);
  }
}

function function_368a7cde() {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  foreach(hotzone in level.hotzones) {
    function_87f604a(hotzone);
  }
}

function function_c981b20b(origin, radius) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  var_ea21a801 = function_72d3bca6(level.hotzones, origin, undefined, 0, radius);

  foreach(hotzone in var_ea21a801) {
    function_87f604a(hotzone);
  }
}

function function_12c2f41f(origin, radius) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  level notify(#"hash_1a8453d57fb3fe48");
  var_ea21a801 = function_72d3bca6(level.hotzones, origin, undefined, 0, radius);

  foreach(hotzone in var_ea21a801) {
    function_ea2997e4(hotzone);
    arrayremovevalue(level.var_3b4ee947, hotzone);
    arrayremovevalue(level.hotzones, hotzone);
  }
}

function function_87f604a(hotzone) {
  level notify(#"hash_1a8453d57fb3fe48");
  hotzone.instance.disabled = 1;
  function_3c977c4f(hotzone, 0);

  if(is_true(hotzone.instance.var_4188d7c8)) {
    function_e5786b9a(hotzone);
  }

  function_fb4091d0(hotzone);
}

function function_fca72198() {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  foreach(hotzone in level.hotzones) {
    function_33cf33f9(hotzone);
  }
}

function function_1724f4ac(origin, radius) {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  var_ea21a801 = function_72d3bca6(level.hotzones, origin, undefined, 0, radius);

  foreach(hotzone in var_ea21a801) {
    function_33cf33f9(hotzone);
  }
}

function function_33cf33f9(hotzone) {
  level notify(#"hash_1a8453d57fb3fe48");
  hotzone.instance.disabled = undefined;
}

function function_15bf0b91(tier) {
  level.var_f534e0 = tier;
}

function add_archetype_spawn_function(archetype, func) {
  if(!isDefined(level.var_f5909b7[archetype])) {
    level.var_f5909b7[archetype] = [];
  }

  level.var_f5909b7[archetype][level.var_f5909b7[archetype].size] = func;
}

function function_ddccdffa(archetype, func) {
  if(!isDefined(level.var_f5909b7[archetype])) {
    level.var_f5909b7[archetype] = [];
  }

  arrayremovevalue(level.var_f5909b7[archetype], func);
}

function function_e670bffd(var_f4a682a0, state) {
  tunables = getscriptbundle(var_f4a682a0);
  var_1fb426c4 = 0;

  if(state == 1) {
    var_1fb426c4 = namespace_679a22ba::function_b9ea4226(isDefined(tunables.var_e4de985f) ? tunables.var_e4de985f : 0, isDefined(tunables.var_4dc06056) ? tunables.var_4dc06056 : 0);
  } else if(state == 2) {
    var_1fb426c4 = namespace_679a22ba::function_b9ea4226(isDefined(tunables.var_b8fc9deb) ? tunables.var_b8fc9deb : 0, isDefined(tunables.var_a1208a9a) ? tunables.var_a1208a9a : 0);
  }

  return var_1fb426c4;
}

function function_d0e4a026(var_f4a682a0) {
  tunables = getscriptbundle(var_f4a682a0);
  return namespace_679a22ba::function_b9ea4226(isDefined(tunables.var_735d3a6b) ? tunables.var_735d3a6b : 0, isDefined(tunables.var_d961aeb3) ? tunables.var_d961aeb3 : 0);
}

function function_47ae367f(hotzone, tier, state) {
  if(state == 1) {
    index = int(min(hotzone.var_117ccd5c.size - 1, tier - 1));
    return hotzone.var_117ccd5c[index];
  }

  if(state == 2) {
    index = int(min(hotzone.var_192fb9a2.size - 1, tier - 1));
    return hotzone.var_192fb9a2[index];
  }
}

function function_6d39329f(hotzone, state) {
  if(state == 1) {
    return hotzone.instance.initial_spawn_points;
  }

  if(state == 2) {
    return hotzone.instance.var_d9c7b945;
  }
}

function function_6b51cc65(&var_e592e473, var_8437e990, aitype) {
  var_2a3ffa2e = function_7b8e26b3(var_e592e473, aitype, "aitype");

  if(var_2a3ffa2e.size) {
    for(i = 0; i < var_2a3ffa2e.size; i++) {
      var_8437e990.var_968f26a5[aitype] = (var_8437e990.var_968f26a5[aitype] + 1) % var_2a3ffa2e.size;
      spawn_point = var_2a3ffa2e[var_8437e990.var_968f26a5[aitype]];

      if(getplayers(undefined, spawn_point.origin, 256).size) {
        continue;
      }

      assert(isDefined(spawn_point));
      return spawn_point;
    }
  }
}

function function_1e745fc0(&var_e592e473, var_8437e990, archetype) {
  var_630a610f = function_7b8e26b3(var_e592e473, archetype, "archetype");

  if(var_630a610f.size) {
    for(i = 0; i < var_630a610f.size; i++) {
      var_8437e990.var_f2be2673[archetype] = (var_8437e990.var_f2be2673[archetype] + 1) % var_630a610f.size;
      spawn_point = var_630a610f[var_8437e990.var_f2be2673[archetype]];

      if(getplayers(undefined, spawn_point.origin, 256).size) {
        continue;
      }

      assert(isDefined(spawn_point));
      return spawn_point;
    }
  }
}

function function_89116a1e(&var_e592e473, var_8437e990, aitype) {
  if(isDefined(aitype)) {
    spawn_point = function_6b51cc65(var_e592e473, var_8437e990, aitype);

    if(isDefined(spawn_point)) {
      return spawn_point;
    }

    archetype = getarchetypefromclassname(aitype);
    spawn_point = function_1e745fc0(var_e592e473, var_8437e990, archetype);

    if(isDefined(spawn_point)) {
      return spawn_point;
    }
  }

  for(i = 0; i < var_e592e473.size; i++) {
    var_8437e990.spawn_point_index = (var_8437e990.spawn_point_index + 1) % var_e592e473.size;
    spawn_point = var_e592e473[var_8437e990.spawn_point_index];

    if(getplayers(undefined, spawn_point.origin, 256).size || isDefined(aitype) && isDefined(spawn_point.var_90d0c0ff) && !function_ee71d10f(aitype, spawn_point.var_90d0c0ff)) {
      continue;
    }

    assert(isDefined(spawn_point));
    return spawn_point;
  }

  if(isDefined(var_8437e990.var_b4481bdb) && isDefined(var_8437e990.var_3ad2f505) && var_8437e990.var_b4481bdb.size) {
    spawn_point = var_8437e990.var_b4481bdb[var_8437e990.var_3ad2f505];
    var_8437e990.var_3ad2f505 = (var_8437e990.var_3ad2f505 + 1) % var_8437e990.var_b4481bdb.size;

    if(isDefined(spawn_point)) {
      return spawn_point;
    }
  }

  return array::random(var_e592e473);
}

function function_ffbebde3(&hotzones) {
  level endon(#"hash_1a8453d57fb3fe48");

  if(is_true(level.var_70da9652.var_780e31de)) {
    return;
  }

  foreach(hotzone in hotzones) {
    hotzone.instance.var_8fa06b8e = 0;

    hotzone.instance.var_19b23216 = [];
  }

  players = getplayers();
  fake_players = [];

  foreach(player in players) {
    fake_players[fake_players.size] = {
      #origin: player.origin, #angles: player.angles
    };
  }

  foreach(hotzone in hotzones) {
    if(hotzone.instance.current_state == 3 || is_true(hotzone.instance.disabled)) {
      continue;
    }

    var_1414fb7f = function_72d3bca6(fake_players, hotzone.origin, undefined, undefined, 10000);

    if(!var_1414fb7f.size) {
      continue;
    }

    proximity = function_3e21a60b(hotzone, var_1414fb7f);

    hotzone.instance.var_19b23216[# "proximity"] = proximity;

    hotzone.instance.var_8fa06b8e += proximity;
    facing = function_b6a93fcd(hotzone, var_1414fb7f);

    hotzone.instance.var_19b23216[# "facing"] = facing;

    hotzone.instance.var_8fa06b8e += facing;
    state = function_df47d6e7(hotzone);

    hotzone.instance.var_19b23216[# "state"] = state;

    hotzone.instance.var_8fa06b8e += state;
    waitframe(1);
  }

  for(index = 0; index < hotzones.size; index++) {
    hotzone = hotzones[index];
    hotzone.instance.priority = hotzone.instance.var_8fa06b8e;
    hotzone.instance.var_8fa06b8e = undefined;

    hotzone.instance.priority_debug = hotzone.instance.var_19b23216;
    hotzone.instance.var_19b23216 = undefined;
  }

  array::bubble_sort(hotzones, &function_d4dbf960);
}

function private function_d4dbf960(left, right) {
  return right.instance.priority < left.instance.priority;
}

function function_3e21a60b(hotzone, &player_array) {
  score = 0;
  radius = hotzone.radius;
  radiussq = sqr(radius);

  for(player_index = player_array.size - 1; player_index >= 0; player_index--) {
    player = player_array[player_index];

    if(player.origin[2] > hotzone.origin[2] && player.origin[2] < hotzone.origin[2] + hotzone.height && distance2dsquared(player.origin, hotzone.origin) <= radiussq) {
      score += 100;
      continue;
    }

    if(player.origin[2] > hotzone.origin[2] - 2000 && player.origin[2] < hotzone.origin[2] + hotzone.height + 2000) {
      score += mapfloat(radius, 10000, 100, 0, distance2d(player.origin, hotzone.origin));
    }
  }

  return score;
}

function function_b6a93fcd(hotzone, &player_array) {
  score = 0;
  fov = cos(45);

  foreach(player in player_array) {
    normal = vectornormalize(hotzone.origin - player.origin);
    forward = anglesToForward(player.angles);
    dot = vectordot(forward, normal);

    if(dot < fov) {
      continue;
    }

    score += mapfloat(fov, 1, 0, 25, dot);
  }

  return score;
}

function function_df47d6e7(hotzone) {
  if(hotzone.instance.current_state == 2) {
    if(!isDefined(hotzone.instance.var_ac7b2365[# "chase"])) {
      return 50;
    }

    return 400;
  }

  if(hotzone.instance.current_state == 1) {
    return 30;
  }

  return 0;
}

function update_hotzone_states() {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  level endon(#"game_ended");

  while(true) {
    level flag::clear("update_hotzone_states");
    waitframe(1);
    level flag::wait_till_clear("deactivate_hotzones");

    if(!(isDefined(level.hotzones) && isDefined(level.var_3b4ee947))) {
      continue;
    }

    level flag::set("update_hotzone_states");
    var_d8ee487e = [];
    function_ffbebde3(level.hotzones);
    waitframe(1);

    if(!isDefined(level.hotzones)) {
      continue;
    }

    for(index = 0; index < level.hotzones.size; index++) {
      hotzone = level.hotzones[index];

      if(var_d8ee487e.size >= getdvarint(#"hash_7c3872b765911891", 4)) {
        break;
      }

      if(is_true(hotzone.instance.var_4188d7c8)) {
        function_e5786b9a(hotzone);
        function_a3ad37ef(hotzone);
      }

      if(hotzone.instance.current_state == 3 || is_true(hotzone.instance.disabled)) {
        continue;
      }

      var_d8ee487e[var_d8ee487e.size] = hotzone;
    }

    waitframe(1);

    foreach(hotzone in var_d8ee487e) {
      if(isDefined(hotzone.instance) && isDefined(hotzone.instance.current_state)) {
        switch (hotzone.instance.current_state) {
          case 0:
            function_3c977c4f(hotzone, 1);
            break;
          case 1:
            if(function_64a303c6(hotzone)) {
              function_3c977c4f(hotzone, 2);
            }

            break;
          case 2:
            if(function_64a303c6(hotzone) || function_e923faaf(hotzone)) {
              hotzone.instance.var_c80ba91c = undefined;
            } else if(isDefined(hotzone.instance.var_c80ba91c) && hotzone.instance.var_c80ba91c < gettime()) {
              function_3c977c4f(hotzone, 1);
              function_947f6f99(hotzone);
            } else if(!isDefined(hotzone.instance.var_c80ba91c)) {
              hotzone.instance.var_c80ba91c = gettime() + int(10 * 1000);
            }

            break;
        }
      }

      if(isinarray(level.var_3b4ee947, hotzone)) {
        arrayremovevalue(level.var_3b4ee947, hotzone, 0);
      }
    }

    foreach(hotzone in level.var_3b4ee947) {
      if(!isDefined(hotzone.instance.current_state) || is_true(hotzone.instance.disabled)) {
        continue;
      }

      switch (hotzone.instance.current_state) {
        case 1:
        case 2:
          function_fb4091d0(hotzone);
          function_3c977c4f(hotzone, 0);
          break;
      }
    }

    level.var_3b4ee947 = var_d8ee487e;
  }
}

function function_9e0aba37() {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  level endon(#"game_ended");
  level.var_71c1e90a = 0;

  while(true) {
    waitframe(1);

    if(getaicount() >= getailimit() || !isDefined(level.var_3b4ee947)) {
      continue;
    }

    level flag::wait_till(#"spawn_zombies");

    if(!isDefined(level.var_3b4ee947) || !isarray(level.var_3b4ee947)) {
      continue;
    }

    foreach(hotzone in level.var_3b4ee947) {
      instance = hotzone.instance;

      if(!isDefined(instance)) {
        println("<dev string:x130>");
        continue;
      }

      if(is_true(hotzone.instance.var_4188d7c8)) {
        function_e5786b9a(hotzone);
        function_a3ad37ef(hotzone);
      }

      if(!level flag::get(#"spawn_zombies")) {
        break;
      }

      if(is_true(instance.var_98957c00) || !isDefined(instance.spawned_ai) || instance.spawned_ai >= instance.var_735d3a6b || instance.current_state == 1 && level.var_71c1e90a >= 30) {
        continue;
      }

      if(instance.active_ai.size < instance.var_1fb426c4) {
        new_ai = spawn_ai(hotzone);

        if(!isDefined(new_ai)) {
          continue;
        }

        instance.active_ai[instance.active_ai.size] = new_ai;
        namespace_679a22ba::function_266ee075(new_ai.list_name, new_ai.var_89592ba7);
        instance.spawned_ai++;

        if(hotzone.instance.current_state == 1) {
          new_ai.var_722e942 = 1;
          level.var_71c1e90a++;
          var_13a8c4ed = instance.active_ai.size;

          foreach(ai in instance.active_ai) {
            if(is_true(ai.var_f3723430)) {
              var_13a8c4ed--;
            }
          }

          if(var_13a8c4ed >= instance.var_1fb426c4) {
            instance.var_98957c00 = 1;
          }
        } else if(hotzone.instance.current_state == 2) {
          if(hotzone.instance.var_ee69e628.size) {
            var_32ba732d = array::randomize(hotzone.instance.var_ee69e628);

            for(i = 0; i < var_32ba732d.size; i++) {
              if(!isalive(var_32ba732d[i].entity)) {
                continue;
              }

              event = {
                #type: 0, #position: var_32ba732d[i].entity.origin
              };
              new_ai callback::function_d8abfc3d(#"hash_790882ac8688cee5", &function_a007a803, undefined, array(event, var_32ba732d[i].entity));
              break;
            }
          }
        }

        break;
      }
    }
  }
}

function spawn_ai(hotzone) {
  assert(hotzone.instance.current_state == 1 || hotzone.instance.current_state == 2, "<dev string:x192>");
  instance = hotzone.instance;
  list_name = function_47ae367f(hotzone, instance.tier, instance.current_state);
  var_e592e473 = function_6d39329f(hotzone, instance.current_state);

  if(!var_e592e473.size) {
    return undefined;
  }

  spawn_info = namespace_679a22ba::function_ca209564(list_name, instance.var_d36a24ed);

  if(!isDefined(spawn_info)) {
    return;
  }

  spawn_point = function_89116a1e(var_e592e473, instance, spawn_info.aitype_name);

  if(hotzone === level.var_2c56b3ec && !level flag::get(#"hash_ad588d53f52329a")) {
    var_9f9ede51 = # "hash_729b116cf9d044";
  } else {
    var_9f9ede51 = spawn_info.aitype_name;
  }

  var_abb82760 = namespace_85745671::function_3b941e5c(spawn_point.origin, var_9f9ede51);
  var_9f9ede51 = isDefined(var_abb82760) ? var_abb82760 : var_9f9ede51;
  new_ai = spawnactor(var_9f9ede51, spawn_point.origin, spawn_point.angles, undefined, 1);

  if(isDefined(new_ai)) {
    new_ai.spawn_point = spawn_point;
    new_ai.list_name = spawn_info.list_name;
    new_ai.var_89592ba7 = instance.var_d36a24ed;
    new_ai.var_341387d5 = hotzone.origin;
    new_ai.var_b518f045 = 3000;
    new_ai.var_c37d7f3b = 4000;
    new_ai.hotzone = hotzone;

    if(isDefined(spawn_point.var_90d0c0ff) && function_ee71d10f(spawn_info.aitype_name, spawn_point.var_90d0c0ff)) {
      new_ai.var_c9b11cb3 = spawn_point.var_90d0c0ff;
    }

    if(var_9f9ede51 == # "hash_729b116cf9d044" && !level flag::get(#"hash_ad588d53f52329a")) {
      level flag::set(#"hash_ad588d53f52329a");

      level thread namespace_1125e192::function_ace23f69(spawn_point.origin);
    }

    new_ai callback::function_d8abfc3d(#"on_ai_killed", &function_2b886fac, undefined, [hotzone]);
    new_ai callback::function_d8abfc3d(#"on_entity_deleted", &function_95899b5c, undefined, [hotzone]);
    new_ai callback::function_d8abfc3d(#"hash_7d2e38b28c894e5a", &function_95899b5c, undefined, [hotzone]);
    new_ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_18c143e6);
    new_ai callback::function_d8abfc3d(#"hash_540e54ba804a87b9", &function_527d149a);
    new_ai thread function_8967ab54();

    if(isarray(level.var_f5909b7[new_ai.archetype])) {
      foreach(func in level.var_f5909b7[new_ai.archetype]) {
        new_ai[[func]]();
      }
    }
  }

  return new_ai;
}

function function_fb4091d0(hotzone, &var_e1e8316f = undefined) {
  if(!isDefined(var_e1e8316f)) {
    var_e1e8316f = &hotzone.instance.active_ai;
  }

  foreach(ai in var_e1e8316f) {
    if(isalive(ai) && !is_true(ai.var_f3723430)) {
      if(isDefined(level.contentmanager.activeobjective) && distance2dsquared(ai.origin, level.contentmanager.activeobjective.origin) <= sqr(2000)) {
        ai thread namespace_85745671::function_b7e28ade(level.contentmanager.activeobjective.origin, 2000);
        continue;
      }

      ai.var_f3723430 = 1;
      ai callback::callback(#"hash_10ab46b52df7967a");
    }
  }
}

function function_947f6f99(hotzone) {
  instance = hotzone.instance;
  var_3d1dc91f = function_47ae367f(hotzone, instance.tier, 2);
  var_d21da46f = function_47ae367f(hotzone, instance.tier, 1);
  var_c794a75 = [];

  if(var_3d1dc91f !== var_d21da46f) {
    var_8d31964e = namespace_679a22ba::function_3e7317ca(var_3d1dc91f);
    var_77391339 = namespace_679a22ba::function_3e7317ca(var_d21da46f);
    var_ea96ab6d = array::exclude(var_8d31964e, var_77391339);

    if(var_ea96ab6d.size > 0) {
      if(is_true(hotzone.instance.var_4188d7c8)) {
        function_e5786b9a(hotzone);
      }

      foreach(ai in hotzone.instance.active_ai) {
        if(isinarray(var_ea96ab6d, hash(ai.aitype))) {
          if(!isDefined(var_c794a75)) {
            var_c794a75 = [];
          } else if(!isarray(var_c794a75)) {
            var_c794a75 = array(var_c794a75);
          }

          var_c794a75[var_c794a75.size] = ai;
        }
      }
    }
  }

  var_a9c2ddd5 = 0;
  var_c21cdef8 = int(function_e670bffd(hotzone.scriptbundlename, 1));
  var_a9c2ddd5 = max(0, hotzone.instance.active_ai.size - var_c21cdef8 - var_c794a75.size);

  for(i = 0; var_a9c2ddd5 > 0 && i < hotzone.instance.active_ai.size; i++) {
    if(!isinarray(var_c794a75, hotzone.instance.active_ai[i])) {
      var_c794a75[var_c794a75.size] = hotzone.instance.active_ai[i];
      var_a9c2ddd5 -= 1;
    }
  }

  function_fb4091d0(hotzone, var_c794a75);
}

function function_418ab095(ai, hotzone) {
  ai callback::function_d8abfc3d(#"on_ai_killed", &function_2b886fac, undefined, [hotzone]);
  ai callback::function_d8abfc3d(#"on_entity_deleted", &function_95899b5c, undefined, [hotzone]);
  ai callback::function_d8abfc3d(#"hash_7d2e38b28c894e5a", &function_95899b5c, undefined, [hotzone]);
  ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_18c143e6);
  ai callback::function_d8abfc3d(#"hash_540e54ba804a87b9", &function_527d149a);
  ai.hotzone = hotzone;
  ai function_18c143e6();

  if(ai.current_state.name === # "chase" && isDefined(ai.favoriteenemy) && ai.favoriteenemy.team !== level.zombie_team) {
    self function_11efa003(hotzone, ai.favoriteenemy);
  } else {
    ai thread function_8967ab54();
  }

  hotzone.instance.active_ai[hotzone.instance.active_ai.size] = ai;

  if(ai.var_722e942 === 1) {
    level.var_71c1e90a++;
  }
}

function function_2b886fac(params, hotzone, var_679c4943 = 0) {
  hotzone.instance.var_4188d7c8 = 1;

  if(is_true(self.var_8f7ba187)) {
    return;
  }

  self function_527d149a();

  if(self.var_722e942 === 1 && !is_true(self.var_39f7f68)) {
    level.var_71c1e90a--;
    self.var_39f7f68 = 1;
  }

  var_26b5ea9d = var_679c4943;

  if(!var_26b5ea9d && isDefined(self.var_813a079f)) {
    var_26b5ea9d = self[[self.var_813a079f]](params, hotzone);
  } else if(!var_26b5ea9d && isDefined(params) && !isPlayer(params.eattacker) && isDefined(self.list_name) && isDefined(self.var_89592ba7) && !is_true(self.var_7a68cd0c)) {
    var_26b5ea9d = 1;
  }

  if(var_26b5ea9d) {
    namespace_679a22ba::function_898aced0(self.list_name, self.var_89592ba7);
    hotzone.instance.spawned_ai--;
    hotzone.instance.var_98957c00 = 0;
  }

  self.var_8f7ba187 = 1;
}

function function_95899b5c(hotzone) {
  if(self.aitype === # "hash_729b116cf9d044") {
    level flag::clear(#"hash_ad588d53f52329a");
  }

  function_2b886fac(undefined, hotzone, 1);
}

function function_a007a803(params, event, enemy) {
  if(isalive(enemy)) {
    event.position = enemy.origin;
  }

  awareness::function_1db27761(self, event);
  self.var_3eaac485 = gettime() + int(3 * 1000);
  self callback::function_52ac9652(#"hash_790882ac8688cee5", &function_a007a803);
}

function function_18c143e6(params) {
  if(!isDefined(self.hotzone.instance)) {
    return;
  }

  if(!isDefined(self.hotzone.instance.var_ac7b2365[self.current_state.name])) {
    self.hotzone.instance.var_ac7b2365[self.current_state.name] = 0;
  }

  self.hotzone.instance.var_ac7b2365[self.current_state.name]++;
}

function function_527d149a(params) {
  if(!isDefined(self.hotzone.instance)) {
    return;
  }

  if(!isDefined(self.hotzone.instance.var_ac7b2365[self.current_state.name])) {
    return;
  }

  self.hotzone.instance.var_ac7b2365[self.current_state.name]--;

  if(self.hotzone.instance.var_ac7b2365[self.current_state.name] <= 0) {
    arrayremoveindex(self.hotzone.instance.var_ac7b2365, self.current_state.name, 1);
  }
}

function function_e923faaf(hotzone) {
  var_be320827 = [# "wander", #"idle"];

  foreach(key, __ in hotzone.instance.var_ac7b2365) {
    if(!isinarray(var_be320827, key)) {
      return true;
    }
  }

  return false;
}

function function_8967ab54() {
  self notify("2bc9ca8e8a5059b9");
  self endon("2bc9ca8e8a5059b9");
  self endon(#"death", #"deleted");
  level endon(#"game_ended");
  waitresult = self waittill(#"hash_151828d1d5e024ee");
  self function_11efa003(self.hotzone, waitresult.enemy);
}

function function_11efa003(hotzone, enemy) {
  if(!isDefined(hotzone.instance.var_ee69e628[enemy getentitynumber()])) {
    hotzone.instance.var_ee69e628[enemy getentitynumber()] = {
      #count: 0, #entity: enemy
    };

    hotzone.instance.var_ee69e628[enemy getentitynumber()].entities = [];
  }
}

function function_e5786b9a(hotzone) {
  function_1eaaceab(hotzone.instance.active_ai);
  hotzone.instance.var_4188d7c8 = 0;
}

function function_a3ad37ef(hotzone) {
  if(!isDefined(hotzone.instance.var_d36a24ed)) {
    return;
  }

  if(hotzone.instance.active_ai.size) {
    return;
  }

  if(!is_true(hotzone.instance.var_98957c00) && hotzone.instance.spawned_ai < hotzone.instance.var_735d3a6b) {
    spawn_list = function_47ae367f(hotzone, hotzone.instance.tier, hotzone.instance.current_state);
    var_b47234f1 = namespace_679a22ba::function_ce65eab6(hotzone.instance.var_d36a24ed);

    if(var_b47234f1.var_cffbc08 == -1 || var_b47234f1.spawned < var_b47234f1.var_cffbc08) {
      return;
    }
  }

  function_3c977c4f(hotzone, 3);
}

function function_64a303c6(hotzone) {
  if(!hotzone.instance.active_ai.size || !getplayers(undefined, hotzone.origin, 3000).size) {
    return false;
  }

  foreach(ai in hotzone.instance.active_ai) {
    if(isDefined(ai.current_state) && ai.current_state.name == # "chase") {
      return true;
    }
  }

  return false;
}

function function_ee71d10f(aitype, alias) {
  if(!isDefined(level.var_39b4b1e2[alias])) {
    level.var_39b4b1e2[alias] = [];
  }

  if(!isDefined(level.var_39b4b1e2[alias][aitype])) {
    level.var_39b4b1e2[alias][aitype] = function_c4cb6239(aitype, alias);
  }

  return level.var_39b4b1e2[alias][aitype];
}

function function_9b928fad() {
  if(!getdvarint(#"hash_7f960fed9c1533f", 1)) {
    return;
  }

  while(!canadddebugcommand()) {
    waitframe(1);
  }

  level.var_70da9652 = {};
  function_5ac4dc99("<dev string:x1d8>", 0);
  function_5ac4dc99("<dev string:x1ec>", "<dev string:x204>");
  adddebugcommand("<dev string:x208>");
  adddebugcommand("<dev string:x23b>");
  adddebugcommand("<dev string:x26a>");
  adddebugcommand("<dev string:x29c>");
  adddebugcommand("<dev string:x2c6>");
  adddebugcommand("<dev string:x2f1>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x323>" + "<dev string:x33e>" + "<dev string:x34f>" + var_46903069 + "<dev string:x354>" + "<dev string:x1d8>");
  var_46903069++;
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x323>" + "<dev string:x35a>" + "<dev string:x34f>" + var_46903069 + "<dev string:x354>" + "<dev string:x372>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x323>" + "<dev string:x395>" + "<dev string:x34f>" + var_46903069 + "<dev string:x354>" + "<dev string:x3ac>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x323>" + "<dev string:x3c6>" + "<dev string:x34f>" + var_46903069 + "<dev string:x354>" + "<dev string:x3df>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x415>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x44e>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x46d>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x486>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x49f>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x4ba>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x4d5>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x4ef>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x509>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x521>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x533>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x552>" + "<dev string:x468>");
  var_46903069 = (isDefined(var_46903069) ? var_46903069 : -1) + 1;
  adddebugcommand("<dev string:x3fb>" + "<dev string:x570>" + "<dev string:x34f>" + var_46903069 + "<dev string:x42e>" + "<dev string:x592>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x5b1>" + "<dev string:x5e2>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x354>" + "<dev string:x5f7>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x5b1>" + "<dev string:x615>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x354>" + "<dev string:x623>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x66c>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x67f>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x690>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x6a2>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x6b2>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x6c9>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x6de>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x6fc>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x718>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x740>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x766>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x787>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x7a6>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x7bd>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x7d2>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x7e7>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x7fa>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x819>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x836>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x851>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x86a>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x88a>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x8a9>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x8c7>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x8e5>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x8ff>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x917>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x935>" + "<dev string:x468>");
  var_525602a9 = (isDefined(var_525602a9) ? var_525602a9 : -1) + 1;
  adddebugcommand("<dev string:x63c>" + "<dev string:x951>" + "<dev string:x34f>" + var_525602a9 + "<dev string:x42e>" + "<dev string:x969>" + "<dev string:x468>");
  function_cd140ee9("<dev string:x1d8>", &function_3fbd8696);
  function_cd140ee9("<dev string:x1ec>", &function_542b33bf);
}

function function_3fbd8696(dvar) {
  switch (dvar.value) {
    case 0:
      level notify(#"hash_7ef679d3b9fffd3f");
      break;
    case 1:
      level thread function_3de1c8ac(&function_c3eed624);
      break;
    case 2:
      level thread function_3de1c8ac(&function_bf876de8);
      break;
  }
}

function function_542b33bf(dvar) {
  switch (dvar.value) {
    case # "hash_35a3b819e2c0441d":
      level.var_70da9652.var_4b72bf24 = !is_true(level.var_70da9652.var_4b72bf24);
      break;
    case # "hash_1a6ac45da64a952e":
      level.var_70da9652.var_42f5dda4 = !is_true(level.var_70da9652.var_42f5dda4);
      break;
    case # "hash_4a89612f4c29723c":
      level.var_70da9652.var_22a4a482 = !is_true(level.var_70da9652.var_22a4a482);
      break;
    case # "hash_9980be38b90805c":
      level.var_70da9652.var_5ff49272 = !is_true(level.var_70da9652.var_5ff49272);
      break;
    case # "hash_70840771b862a3e":
      level.var_70da9652.var_4bff9c78 = !is_true(level.var_70da9652.var_4bff9c78);
      break;
    case # "hash_2bf9ed47f334d3d6":
      level.var_70da9652.var_b3795227 = !is_true(level.var_70da9652.var_b3795227);
      break;
    case # "hash_2d98dc88067eb39b":
      level.var_70da9652.var_3eef4d41 = !is_true(level.var_70da9652.var_3eef4d41);
      break;
    case # "hash_2bdd64b5fe882d98":
      level.var_70da9652.var_4e02b047 = !is_true(level.var_70da9652.var_4e02b047);
      break;
    case # "hash_46b8b4503ce24c31":
      level.var_70da9652.var_26ba38c4 = !is_true(level.var_70da9652.var_26ba38c4);
      break;
    case # "hash_7ba17de60e0b4f0d":
      level.var_70da9652.var_5cdd46ee = !is_true(level.var_70da9652.var_5cdd46ee);
      break;
    case # "show_priority":
      level.var_70da9652.show_priority = !is_true(level.var_70da9652.show_priority);
      break;
    case # "hash_759ea2f57b13650e":
      level.var_70da9652.var_780e31de = !is_true(level.var_70da9652.var_780e31de);

      if(is_true(level.var_70da9652.var_780e31de)) {
        level.var_70da9652.var_2269342d = {};

        foreach(player in getplayers()) {
          if(!isDefined(level.var_70da9652.var_2269342d.player_info)) {
            level.var_70da9652.var_2269342d.player_info = [];
          } else if(!isarray(level.var_70da9652.var_2269342d.player_info)) {
            level.var_70da9652.var_2269342d.player_info = array(level.var_70da9652.var_2269342d.player_info);
          }

          level.var_70da9652.var_2269342d.player_info[level.var_70da9652.var_2269342d.player_info.size] = {
            #origin: player.origin, #angles: player.angles
          };
        }
      } else {
        level.var_70da9652.var_2269342d = undefined;
      }

      break;
    case # "hash_5401bac31bdc67":
    case # "hash_18e3d1b23392828e":
      level.var_70da9652.var_c5d20e33 = dvar.value;
      break;
    case # "hash_4f3a0e609d3f7e2b":
      function_bc437ca0();
      break;
    case # "hash_125f47c25f63a021":
      function_e24de31c();
      break;
    case # "hash_155d8615abc8b3f5":
      spawns = function_fac3e87c();
      level thread namespace_420b39d3::function_46997bdf(&spawns, "<dev string:x981>");
      break;
    case # "hash_635a7b13408b9567":
      spawns = function_fac3e87c();
      namespace_420b39d3::function_70e877d7(&spawns);
      break;
    case # "hash_2a330edd1205dc06":
      level.var_70da9652.var_bf84a5e9 = !is_true(level.var_70da9652.var_bf84a5e9);
      break;
    case # "hash_6832c8f3ef9fb279":
      level.var_70da9652.var_cb0c00c7 = !is_true(level.var_70da9652.var_cb0c00c7);
      break;
    case # "hash_7f507f57d1cfb17":
      level.var_70da9652.var_9da890d8 = !is_true(level.var_70da9652.var_9da890d8);
      break;
    case # "hash_278df421cdf19ebe":
      level.var_70da9652.var_bd4a2cac = !is_true(level.var_70da9652.var_bd4a2cac);
    default:
      break;
  }

  if(dvar.value != "<dev string:x204>") {
    setDvar(dvar.name, "<dev string:x204>");
  }
}

function function_bc437ca0() {
  waittillframeend();
  level notify(#"hash_1a8453d57fb3fe48");

  foreach(hotzone in level.hotzones) {
    function_ea2997e4(hotzone);
    function_4aca4e83(hotzone);
  }
}

function function_d78228f7() {
  level.var_70da9652.var_b74207be = getdvarint(#"hash_3de4c46e91e294cc", 0);
  level.var_70da9652.var_84a7284e = getdvarint(#"hash_3558c135587c5d42", 0);
}

function function_c3eed624() {
  return getplayers()[0].origin;
}

function function_bf876de8() {
  player = getplayers()[0];
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  direction_vec = (direction_vec[0] * 20000, direction_vec[1] * 20000, direction_vec[2] * 20000);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  circle(trace[# "position"], 16, (1, 0.5, 0), 1, 1, 1);
  debugstar(trace[# "position"], 1, (1, 0.5, 0));
  return trace[# "position"];
}

function function_3de1c8ac(var_2da12984) {
  level endon(#"game_ended", #"hash_7ef679d3b9fffd3f");
  self notify("<dev string:x98c>");
  self endon("<dev string:x98c>");

  while(true) {
    waitframe(1);

    if(!isDefined(level.hotzones)) {
      continue;
    }

    function_d78228f7();
    origin = getplayers()[0].origin;
    options = level.var_70da9652;
    var_3bd2fa1f = arraysortclosest(level.hotzones, [[var_2da12984]](), options.var_b74207be);
    hotzones = level.hotzones;

    if(isDefined(options.var_c5d20e33)) {
      if(options.var_c5d20e33 === "<dev string:x4ba>") {
        function_c981b20b([[var_2da12984]](), 2000);
      } else {
        function_1724f4ac([[var_2da12984]](), 2000);
      }

      level.var_70da9652.var_c5d20e33 = undefined;
    }

    foreach(index, hotzone in level.hotzones) {
      scale = 0.7;
      distance = distance(hotzone.origin, origin);

      if(distance > 400) {
        scale = distance * 0.002;
      }

      if(!isinarray(var_3bd2fa1f, hotzone)) {
        function_a5ea005d(hotzone, index, scale);
        continue;
      }

      function_1a530376(hotzone, index, scale);
    }

    if(isarray(options.var_2269342d.player_info)) {
      foreach(info in options.var_2269342d.player_info) {
        function_af647be2(info);
      }
    }

    if(is_true(options.var_bf84a5e9)) {
      scale = 0.85;
      offset = 75;
      debug2dtext((105, offset * scale, 0), "<dev string:x9a0>" + level.var_71c1e90a, (1, 1, 0), undefined, (0.4, 0.4, 0.4), 0.9, scale);
      offset += 22;
    }
  }
}

function function_a5ea005d(hotzone, array_index, scale) {
  index = 0;
  options = level.var_70da9652;
  var_a7c842b3 = function_6320ae1d(hotzone, options);

  if(is_true(options.show_priority)) {
    index = function_af798ce8(index, scale, 1, var_a7c842b3, array_index, hotzone);
    return;
  }

  line(hotzone.origin, hotzone.origin + (0, 0, 300), var_a7c842b3, 1);
}

function function_1a530376(hotzone, array_index, scale) {
  index = 0;
  options = level.var_70da9652;
  var_a7c842b3 = function_6320ae1d(hotzone, options);
  debugstar(hotzone.origin, 1, var_a7c842b3);

  if(is_true(options.show_priority)) {
    index = function_af798ce8(index, scale, 1, var_a7c842b3, array_index, hotzone);
  }

  print3d(hotzone.origin + (0, 0, index), function_89a74781(hotzone) + "<dev string:x9ae>" + hotzone.instance.tier, var_a7c842b3, 1, scale * 0.8, 1);
  index += 17 * scale * 0.8;
  print3d(hotzone.origin + (0, 0, index), function_9e72a96(hotzone.scriptbundlename), var_a7c842b3, 1, scale * 1, 1);
  index += 17 * scale * 1;
  print3d(hotzone.origin + (0, 0, index), is_true(hotzone.instance.disabled) ? "<dev string:x9b8>" : "<dev string:x9c4>", is_true(hotzone.instance.disabled) ? (1, 0, 1) : (0, 1, 1), 1, scale * 1, 1);
  index += 17 * scale * 1;

  if(is_true(options.var_5cdd46ee)) {
    index = function_42926dcf(index, scale, 1, hotzone);
  }

  if(is_true(options.var_4e02b047)) {
    index = function_d937ea12(index, scale, 1, var_a7c842b3, hotzone, options);
  }

  if(is_true(options.var_9da890d8)) {
    index = function_11ba669e(index, scale, 1, var_a7c842b3, hotzone, options);
  }

  if(is_true(options.var_bd4a2cac)) {
    index = function_22dd41d8(index, scale, 1, var_a7c842b3, hotzone, options);
  }

  if(is_true(options.var_4b72bf24)) {
    function_9c8936c1(hotzone.instance.initial_spawn_points, hotzone.origin, (0, 1, 1));
  }

  if(is_true(options.var_42f5dda4)) {
    function_9c8936c1(hotzone.instance.var_d9c7b945, hotzone.origin, (1, 0, 0));
  }

  if(is_true(options.var_5ff49272)) {
    function_59a41525(hotzone.origin, hotzone.radius, hotzone.height, (1, 0, 1), 1);
  }

  if(is_true(options.var_4bff9c78)) {
    if(hotzone.instance.current_state !== 0) {
      function_59a41525(hotzone.origin, 3000, hotzone.height, (1, 0.5, 0), 1);
    }
  }

  if(is_true(options.var_b3795227)) {
    if(hotzone.instance.current_state !== 0) {
      function_59a41525(hotzone.origin, 4000, hotzone.height, (0.4, 0.4, 0.4), 1);
    }
  }

  if(is_true(options.var_3eef4d41) && !is_true(hotzone.var_19e89e4e)) {
    function_59a41525(hotzone.origin, hotzone.spawn_radius, hotzone.spawn_height, (1, 1, 0), 1);
    return;
  }

  if(is_true(options.var_3eef4d41) && is_true(hotzone.var_19e89e4e)) {
    draw_box(hotzone.origin, hotzone.angles, hotzone.var_499035e2, hotzone.var_81314a61, hotzone.spawn_height, (1, 1, 0));
  }
}

function function_af798ce8(index, scale, alpha, color, var_5ab1a705, hotzone) {
  if(!hotzone.instance.priority) {
    line(hotzone.origin, hotzone.origin + (0, 0, 300), color);
    return index;
  }

  print3d(hotzone.origin + (0, 0, index), "<dev string:x9cf>" + hotzone.instance.priority, color, alpha, scale * 1, 1);
  index += 17 * scale * 1;

  foreach(key, value in hotzone.instance.priority_debug) {
    print3d(hotzone.origin + (0, 0, index), function_9e72a96(key) + "<dev string:x34f>" + value, color, alpha, scale * 1, 1);
    index += 17 * scale * 1;
  }

  if(!level.hotzones[0].instance.priority) {
    var_2a5f3b00 = mapfloat(0, level.hotzones.size, 0, 1, var_5ab1a705);
  } else {
    var_2a5f3b00 = mapfloat(0, level.hotzones[0].instance.priority, 0, 1, hotzone.instance.priority);
  }

  height = 300 + 1000 * var_2a5f3b00;
  line(hotzone.origin, hotzone.origin + (0, 0, height), color);
  print3d(hotzone.origin + (0, 0, height), var_5ab1a705, color, 1, scale * 2);
  return index;
}

function function_d937ea12(index, scale, alpha, color, hotzone, options) {
  list_name = function_47ae367f(hotzone, hotzone.instance.tier, hotzone.instance.current_state);
  print3d(hotzone.origin + (0, 0, index), "<dev string:x9dc>" + (is_true(hotzone.instance.var_98957c00) ? "<dev string:x9ee>" : "<dev string:x9f6>"), color, alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  print3d(hotzone.origin + (0, 0, index), "<dev string:x9ff>" + (is_true(hotzone.instance.var_4188d7c8) ? "<dev string:x9ee>" : "<dev string:x9f6>"), color, alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  print3d(hotzone.origin + (0, 0, index), "<dev string:xa13>" + hotzone.instance.active_ai.size + "<dev string:xa21>" + hotzone.instance.var_1fb426c4, color, alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  print3d(hotzone.origin + (0, 0, index), "<dev string:xa26>" + hotzone.instance.spawned_ai + "<dev string:xa21>" + hotzone.instance.var_735d3a6b, color, alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  index += 17 * scale * 0.75;

  if(isDefined(hotzone.instance.var_d36a24ed)) {
    spawn_info = namespace_679a22ba::function_ce65eab6(hotzone.instance.var_d36a24ed);
    print3d(hotzone.origin + (0, 0, index), "<dev string:xa38>" + spawn_info.spawned + "<dev string:xa21>" + (spawn_info.var_cffbc08 == -1 ? "<dev string:xa4b>" : spawn_info.var_cffbc08), color, alpha, scale * 0.75, 1);
    index += 17 * scale * 0.75;

    if(is_true(options.var_26ba38c4)) {
      for(i = hotzone.instance.var_d36a24ed.var_7c88c117.size - 1; i >= 0; i--) {
        entry = hotzone.instance.var_d36a24ed.var_7c88c117[i];
        print3d(hotzone.origin + (0, 0, index), "<dev string:xa52>" + entry.name + "<dev string:x34f>" + entry.spawned + "<dev string:xa21>" + (entry.var_cffbc08 == -1 ? "<dev string:xa4b>" : entry.var_cffbc08), color, alpha, scale * 0.75, 1);
        index += 17 * scale * 0.75;
      }
    }
  }

  print3d(hotzone.origin + (0, 0, index), "<dev string:xa5d>" + (isDefined(list_name) ? list_name : "<dev string:x204>"), (0, 1, 1), alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  return index;
}

function function_11ba669e(index, scale, alpha, var_a7c842b3, hotzone, options) {
  foreach(ent_num, var_687dacb8 in options.instance.var_ee69e628) {
    print3d(options.origin + (0, 0, scale), "<dev string:xa68>" + ent_num + "<dev string:xa70>" + var_687dacb8.count, hotzone, var_a7c842b3, alpha * 0.75, 1);
    scale += 17 * alpha * 0.75;

    foreach(ai in var_687dacb8.entities) {
      if(!isalive(ai)) {
        continue;
      }

      line(ai.origin + (0, 0, ai function_6a9ae71()), var_687dacb8.entity.origin, (1, 0, 1));
    }
  }

  print3d(options.origin + (0, 0, scale), "<dev string:xa76>", hotzone, var_a7c842b3, alpha * 0.75, 1);
  scale += 17 * alpha * 0.75;
  return scale;
}

function function_22dd41d8(index, scale, alpha, var_a7c842b3, hotzone, options) {
  scale += 17 * alpha * 0.75;

  foreach(state_name, count in options.instance.var_ac7b2365) {
    print3d(options.origin + (0, 0, scale), "<dev string:xa8b>" + function_9e72a96(state_name) + "<dev string:xa70>" + count, hotzone, var_a7c842b3, alpha * 0.75, 1);
    scale += 17 * alpha * 0.75;
  }

  print3d(options.origin + (0, 0, scale), "<dev string:xa93>", hotzone, var_a7c842b3, alpha * 0.75, 1);
  scale += 17 * alpha * 0.75;
  return scale;
}

function function_42926dcf(index, scale, alpha, hotzone) {
  if(!isDefined(hotzone.var_c43420a)) {
    return index;
  }

  print3d(hotzone.origin + (0, 0, index), "<dev string:xaaa>" + hotzone.var_c43420a + "<dev string:xab4>" + hotzone.var_d3455e4, (1, 0, 1), alpha, scale * 0.75, 1);
  index += 17 * scale * 0.75;
  return index;
}

function function_6320ae1d(hotzone, options) {
  if(is_true(options.show_priority)) {
    if(!level.hotzones[0].instance.priority) {
      return (1, 0, 0);
    } else {
      var_2a5f3b00 = mapfloat(0, level.hotzones[0].instance.priority, 0, 1, hotzone.instance.priority);
      return vectorlerp((1, 0, 0), (0, 1, 0), var_2a5f3b00);
    }
  }

  switch (hotzone.instance.current_state) {
    case 0:
      return (1, 0, 0);
    case 1:
      return (0, 1, 0);
    case 2:
      return (1, 0.5, 0);
    default:
      return (0.3, 0.3, 0.3);
  }
}

function function_89a74781(hotzone) {
  switch (hotzone.instance.current_state) {
    case 0:
      return "<dev string:xabd>";
    case 1:
      return "<dev string:xac9>";
    case 2:
      if(!isDefined(hotzone.instance.var_c80ba91c)) {
        return "<dev string:xad3>";
      } else {
        return ("<dev string:xada>" + float(hotzone.instance.var_c80ba91c - gettime()) / 1000);
      }

      break;
    default:
      return "<dev string:xae2>";
  }
}

function function_59a41525(origin, radius, height, color, depthtest) {
  circle(origin, radius, color, depthtest, 1, 1);
  circle(origin + (0, 0, height), radius, color, depthtest, 1, 1);
  line(origin, origin + (0, 0, height), color, 1, depthtest, 1);
}

function draw_box(origin, angles, width, length, height, color, centered) {
  if(!isDefined(centered)) {
    centered = 0;
  }

  mins = (-0.5 * width, -0.5 * length, centered ? height / -2 : 0);
  maxs = (0.5 * width, 0.5 * length, centered ? height / 2 : height);
  box(origin, mins, maxs, angles, color, 1, 1, 1);
}

function function_9c8936c1(&var_af4acf6e, origin, color) {
  foreach(point in var_af4acf6e) {
    index = 0;
    debugstar(point.origin, 1, color);
    line(point.origin, origin, color);

    if(is_true(level.var_70da9652.var_22a4a482) && isDefined(point.var_90d0c0ff)) {
      draw_box(point.origin, point.angles, 8, 8, 8, (1, 0.752941, 0.796078), 1);
      index = function_774fd83c(point, color, index, 0.75, 1);
    }

    if(is_true(level.var_70da9652.var_cb0c00c7) && isDefined(point.archetype)) {
      print3d(point.origin + (0, 0, index), point.archetype, color, 1, 0.75 * 0.75, 1, 1);
      index += 17 * 0.75 * 0.75;
    }
  }
}

function function_774fd83c(spawn_point, color, index, scale, alpha) {
  print3d(spawn_point.origin + (0, 0, index), spawn_point.var_90d0c0ff, color, alpha, scale * scale, 1, 1);
  index += 17 * scale * scale;
  draw_arrow(spawn_point.origin, spawn_point.origin + anglesToForward(spawn_point.angles) * 15, (1, 0.752941, 0.796078), 6);
  return index;
}

function function_af647be2(player) {
  line(player.origin + (0, 0, 72), player.origin + (0, 0, 572), (0, 1, 1));
  draw_box(player.origin, player.angles, 32, 32, 72, (0, 1, 1));
  var_9029dbde = rotatepointaroundaxis((256, 0, 0), (0, 0, 1), angleclamp180(player.angles[1] + 45));
  var_9029dbde += player.origin;
  line(player.origin, var_9029dbde, (1, 0.5, 0));
  var_a9e71ad4 = rotatepointaroundaxis((256, 0, 0), (0, 0, 1), angleclamp180(player.angles[1] - 45));
  var_a9e71ad4 += player.origin;
  line(player.origin, var_a9e71ad4, (1, 0.5, 0));
  line(player.origin, player.origin + anglesToForward(player.angles) * 256, (1, 1, 0));
}

function draw_arrow(start, end, color, var_6c0bdd43) {
  angles = vectortoangles(end - start);
  y_delta = var_6c0bdd43 / sqrt(2);
  x_delta = var_6c0bdd43 / sqrt(2);
  line(start, end, color);
  var_52defcab = rotatepoint((-1 * x_delta, -1 * y_delta, 0), angles);
  var_2ded77 = rotatepoint((-1 * x_delta, y_delta, 0), angles);
  line(end, end + var_52defcab, color);
  line(end, end + var_2ded77, color);
}