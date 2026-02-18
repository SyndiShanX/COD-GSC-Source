/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3a704cbcf4081bfb.gsc
***********************************************/

#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_zonemgr;
#namespace mimic_prop_spawn;

function init() {
  if(!isDefined(level.var_5fafe5ac)) {
    level.var_5fafe5ac = [];
  }

  if(!isDefined(level.var_b7a636c9)) {
    level.var_b7a636c9 = [];
  }

  if(!isDefined(level.var_70d37ee0)) {
    level.var_70d37ee0 = [];
  }

  if(!isDefined(level.var_6e175eb)) {
    level.var_6e175eb = struct::get_array("mimic_spawn_point", "variantname");
  }

  if(!isDefined(level.var_5a6d7d3e)) {
    level.var_5a6d7d3e = [];
  }

  clientfield::register("scriptmover", "mimic_prop_rob", 6000, 3, "int");
  clientfield::register("scriptmover", "mimic_prop_rattle_cf", 6000, 1, "counter");
  level thread function_8be6cc92();
}

function function_b309db61(&var_b103a71c, entity, var_d1cd7a80, var_75f9ae2d) {
  var_491e08a8 = var_d1cd7a80;

  if(var_b103a71c.size > 1) {
    assist_theia_50 = array::randomize(var_b103a71c);

    if(!isDefined(var_491e08a8)) {
      var_491e08a8 = array::pop_front(assist_theia_50);
    }

    prop_count = randomintrangeinclusive(3, 5);
    prop_array = spawn_props(assist_theia_50, prop_count, entity, var_75f9ae2d);
  } else {
    prop_array = [];

    if(!isDefined(var_491e08a8)) {
      var_491e08a8 = var_b103a71c[0];
    }
  }

  if(isDefined(var_491e08a8.origin) && !isstruct(var_491e08a8)) {
    var_491e08a8 = {
      #origin: var_491e08a8.origin
    };
  }

  return function_913ecbbc(prop_array, entity, var_491e08a8, undefined, var_75f9ae2d);
}

function function_51012821(origin, entity, var_d1cd7a80, num_props = 1, search_radius = 1000) {
  spawn_points = function_d8f63afd(origin, search_radius, num_props);

  if(spawn_points.size || isDefined(var_d1cd7a80)) {
    if(!spawn_points.size) {
      spawn_points[spawn_points.size] = var_d1cd7a80;
    }

    return function_b309db61(spawn_points, entity, var_d1cd7a80);
  }
}

function function_913ecbbc(&prop_array, mimic, trap_prop, var_c3962187, var_75f9ae2d) {
  if(isstruct(trap_prop)) {
    if(isDefined(level.var_6939ebc1[trap_prop.lure_prop_type])) {
      var_6f50b277 = [[level.var_6939ebc1[trap_prop.lure_prop_type].handler]](trap_prop);

      if(isDefined(var_6f50b277)) {
        trap_prop = var_6f50b277.prop;
        var_d56229a9 = var_6f50b277.activation_func;
      }
    } else {
      trap_prop = spawn_prop(trap_prop, var_75f9ae2d);
    }

    if(isDefined(trap_prop)) {
      prop_array[prop_array.size] = trap_prop;
    }
  }

  if(!prop_array.size) {
    return;
  }

  if(!isDefined(trap_prop)) {
    var_faa3dbdd = array::randomize(prop_array);

    foreach(prop in var_faa3dbdd) {
      if(is_true(prop.var_3e64167)) {
        trap_prop = prop;
        break;
      }
    }

    if(!isDefined(trap_prop)) {
      trap_prop = var_faa3dbdd[0];
    }
  }

  if(!isDefined(trap_prop)) {
    return;
  }

  if(!isinarray(level.var_b7a636c9, trap_prop)) {
    level.var_b7a636c9[level.var_b7a636c9.size] = trap_prop;
  }

  if(isDefined(var_c3962187)) {
    trap_prop.origin = var_c3962187;
  }

  function_55657fb4(mimic, trap_prop, prop_array, var_d56229a9);
  return trap_prop;
}

function function_2e8c33f6() {
  arrayremovevalue(level.var_b7a636c9, undefined);
  return level.var_b7a636c9;
}

function function_e82cee4e() {
  arrayremovevalue(level.var_b7a636c9, undefined);
  var_da43492e = [];

  foreach(prop in level.var_b7a636c9) {
    if(!prop ishidden()) {
      if(!isDefined(var_da43492e)) {
        var_da43492e = [];
      } else if(!isarray(var_da43492e)) {
        var_da43492e = array(var_da43492e);
      }

      if(!isinarray(var_da43492e, prop)) {
        var_da43492e[var_da43492e.size] = prop;
      }
    }
  }

  return var_da43492e;
}

function function_bc29cf28() {
  if(!isDefined(level.var_6939ebc1)) {
    return [];
  }

  var_526e473a = [];

  foreach(key in getarraykeys(level.var_6939ebc1)) {
    var_526e473a = arraycombine(var_526e473a, function_7b8e26b3(level.var_6e175eb, key, "lure_prop_type"));
  }

  return var_526e473a;
}

function function_d8f63afd(origin, radius, num_props, filter_claimed = 1) {
  var_79422067 = level.var_6e175eb;
  var_79422067 = function_72d3bca6(var_79422067, origin, undefined, undefined, radius);

  foreach(index, spawn_point in var_79422067) {
    if(isDefined(level.var_6939ebc1[spawn_point.lure_prop_type].validator) && ![[level.var_6939ebc1[spawn_point.lure_prop_type].validator]](spawn_point)) {
      var_79422067[index] = undefined;
    }
  }

  arrayremovevalue(var_79422067, undefined);

  if(var_79422067.size > num_props) {
    var_79422067 = array::randomize(var_79422067);
    array_size = var_79422067.size;

    for(i = 0; i < array_size; i++) {
      if(i >= num_props) {
        arrayremoveindex(var_79422067, i, 1);
      }
    }
  }

  if(var_79422067.size < num_props && isDefined(level.var_64aa9d51)) {
    var_79422067 = arraycombine(var_79422067, [[level.var_64aa9d51]](origin, num_props - var_79422067.size), 0, 0);
  }

  var_9d369002 = [];

  foreach(spawn_point in var_79422067) {
    if(filter_claimed && is_true(spawn_point.claimed)) {
      continue;
    }

    var_9d369002[var_9d369002.size] = spawn_point;
  }

  return var_9d369002;
}

function function_1541ff3a(num_props = 1, entity) {
  in_array = isDefined(entity) && isinarray(level.var_70d37ee0, entity);
  return 20 - level.var_5fafe5ac.size + level.var_70d37ee0.size - in_array >= num_props;
}

function spawn_props(&spawn_points, num_props, entity, var_75f9ae2d) {
  arrayremovevalue(level.var_5fafe5ac, undefined);
  prop_array = [];

  if(!function_1541ff3a(num_props, entity)) {
    in_array = isDefined(entity) && isinarray(level.var_70d37ee0, entity);

    if(is_true(level.var_bce8fb65)) {
      println("<dev string:x38>" + "<dev string:x45>" + 20 - level.var_5fafe5ac.size + level.var_70d37ee0.size - in_array + "<dev string:x65>" + num_props);
    }

    if(level.var_5fafe5ac.size + level.var_70d37ee0.size >= 20) {
      return prop_array;
    }

    num_props = 20 - level.var_5fafe5ac.size + level.var_70d37ee0.size - in_array;
  }

  if(!spawn_points.size) {
    if(is_true(level.var_bce8fb65)) {
      println("<dev string:x38>" + "<dev string:x75>");
    }

    return prop_array;
  }

  spawn_points = array::randomize(spawn_points);

  foreach(loc in spawn_points) {
    if(isDefined(loc.lure_prop_type) || function_a1ef346b(undefined, loc.origin, 300).size) {
      continue;
    }

    prop = spawn_prop(loc, var_75f9ae2d);
    prop_array[prop_array.size] = prop;

    if(prop_array.size >= num_props) {
      break;
    }
  }

  return prop_array;
}

function function_c4504c49(spawn_loc, var_75f9ae2d) {
  if(isDefined(var_75f9ae2d)) {
    bundle = getscriptbundle(var_75f9ae2d);
  } else if(isDefined(spawn_loc.scriptbundlename)) {
    bundle = getscriptbundle(spawn_loc.scriptbundlename);
  }

  if(!isDefined(bundle)) {
    return {
      #prop_name: # "barrel_rust_01_green", #pos_offset: (0, 0, 0), #angle_offset: (0, 0, 0), #rattle_sound: "amb_rattle_barrel"};
  }

  model_entry = bundle.var_e451a3f7[randomint(bundle.var_e451a3f7.size)];

  if(!isDefined(model_entry)) {
    return undefined;
  }

  pos_offset = (isDefined(model_entry.offset_x) ? model_entry.offset_x : 0, isDefined(model_entry.offset_y) ? model_entry.offset_y : 0, isDefined(model_entry.offset_z) ? model_entry.offset_z : 0);
  angle_offset = (isDefined(model_entry.pitch) ? model_entry.pitch : 0, isDefined(model_entry.yaw) ? model_entry.yaw : 0, isDefined(model_entry.roll) ? model_entry.roll : 0);
  prop_name = model_entry.model;
  var_d08c6baf = 0;

  if(!isDefined(model_entry.model) && isDefined(model_entry.var_dcb0ac7c)) {
    var_d08c6baf = 1;
    prop_name = model_entry.var_dcb0ac7c;
  }

  if(isDefined(model_entry.rattle_sound)) {
    rattle_sound = model_entry.rattle_sound;
  } else {
    rattle_sound = undefined;

    if(is_true(level.var_bce8fb65)) {
      println("<dev string:x38>" + "<dev string:x9c>" + prop_name + "<dev string:xb1>" + bundle.name + "<dev string:xc0>");
    }
  }

  if(is_true(model_entry.var_83556f31)) {
    var_e9f8015d = 1;
  } else {
    var_e9f8015d = 0;
  }

  if(is_true(model_entry.var_f0c39cc2)) {
    var_f0c39cc2 = 1;
  } else {
    var_f0c39cc2 = 0;
  }

  return {
    #prop_name: prop_name, #pos_offset: pos_offset, #angle_offset: angle_offset, #rattle_sound: rattle_sound, #var_d08c6baf: var_d08c6baf, #var_b9cdfa83: var_e9f8015d, #var_c39008ae: var_f0c39cc2
  };
}

function spawn_prop(spawn_loc, var_75f9ae2d, var_18840a20, var_1690a7c1 = 0) {
  var_4d71cea4 = function_c4504c49(spawn_loc, var_75f9ae2d);
  model_name = var_4d71cea4.prop_name;
  var_95970e62 = 1;

  if(is_true(var_4d71cea4.var_d08c6baf)) {
    itemspawnentry = getscriptbundle(var_4d71cea4.prop_name);
    var_4d71cea4.pos_offset = (isDefined(itemspawnentry.positionoffsetx) ? itemspawnentry.positionoffsetx : 0, isDefined(itemspawnentry.positionoffsety) ? itemspawnentry.positionoffsety : 0, isDefined(itemspawnentry.positionoffsetz) ? itemspawnentry.positionoffsetz : 0);
    var_4d71cea4.angle_offset = (isDefined(itemspawnentry.angleoffsetx) ? itemspawnentry.angleoffsetx : 0, isDefined(itemspawnentry.angleoffsety) ? itemspawnentry.angleoffsety : 0, isDefined(itemspawnentry.angleoffsetz) ? itemspawnentry.angleoffsetz : 0);

    if(isDefined(itemspawnentry.modelscale)) {
      var_95970e62 = itemspawnentry.modelscale;
    }

    if(isDefined(itemspawnentry.model)) {
      model_name = itemspawnentry.model;
    } else {
      model_name = itemspawnentry.weapon.worldmodel;
    }

    if(isDefined(itemspawnentry.rarity)) {
      rarity = itemspawnentry.rarity;
    }
  }

  if(isDefined(var_18840a20)) {
    model_name = var_18840a20;
  }

  if(!var_1690a7c1) {
    playFX("zm_ai/fx9_mimic_prop_spawn_in", spawn_loc.origin + var_4d71cea4.pos_offset);
  }

  if(!isDefined(spawn_loc.angles)) {
    spawn_loc.angles = (0, 0, 0);
  }

  model = util::spawn_anim_model(model_name, spawn_loc.origin + var_4d71cea4.pos_offset, spawn_loc.angles + var_4d71cea4.angle_offset);
  model playSound(#"hash_4a011e2a2a0742ac");
  spawn_loc.claimed = 1;
  model.spawn_loc = spawn_loc;
  model.rattle_sound = var_4d71cea4.rattle_sound;
  model.var_99ae5a60 = var_4d71cea4.var_b9cdfa83;
  model.var_c39008ae = var_4d71cea4.var_c39008ae;

  if(is_true(model.var_99ae5a60)) {
    model disconnectpaths();
  } else {
    model notsolid();
    model.var_c9826077 = spawn("script_model", model getcentroid());
    model.var_c9826077 setModel("wpn_t9_sr_electric_avogadro_projectile");
  }

  model setscale(var_95970e62);

  if(isDefined(itemspawnentry)) {
    model function_619a5c20();
    model.itementry = itemspawnentry;
    model.var_79299f18 = "mimic_world_prop";
    item = function_4ba8fde(model.itementry.name);

    if(isDefined(item)) {
      model setitemindex(item.id);
    }

    switch (itemspawnentry.rarity) {
      case # "off":
        var_9bed58c1 = 0;
        break;
      case # "resource":
        var_9bed58c1 = 1;
        break;
      case # "uncommon":
        var_9bed58c1 = 2;
        break;
      case # "rare":
        var_9bed58c1 = 3;
        break;
      case # "epic":
        var_9bed58c1 = 4;
        break;
      case # "legendary":
        var_9bed58c1 = 5;
        break;
      case # "ultra":
        var_9bed58c1 = 6;
        break;
      case # "loadout":
        var_9bed58c1 = 7;
        break;
      default:
        var_9bed58c1 = 0;
        break;
    }

    model clientfield::set("mimic_prop_rob", var_9bed58c1);
  }

  model callback::function_d8abfc3d(#"on_entity_deleted", &function_e85d511c);
  level.var_5fafe5ac[level.var_5fafe5ac.size] = model;
  return model;
}

function function_e85d511c(params) {
  self connectpaths();

  if(isDefined(self.spawn_loc)) {
    self.spawn_loc.claimed = undefined;
  }

  if(isDefined(self.var_c9826077)) {
    self.var_c9826077 delete();
  }

  self clientfield::set("mimic_prop_rob", 0);
}

function function_861757a2(entity) {
  var_1541ff3a = function_1541ff3a(1, entity);

  if(var_1541ff3a && !isinarray(level.var_70d37ee0, entity)) {
    level.var_70d37ee0[level.var_70d37ee0.size] = entity;
  }

  if(is_true(level.var_bce8fb65)) {
    println("<dev string:x38>" + "<dev string:xeb>" + entity getentitynumber() + (var_1541ff3a ? "<dev string:xf5>" : "<dev string:x10e>") + "<dev string:x123>");
  }

  if(is_true(level.var_bce8fb65)) {
    println("<dev string:x38>" + "<dev string:x139>" + level.var_70d37ee0.size + "<dev string:x157>" + 20);
  }

  return var_1541ff3a;
}

function function_8c7b02b0(entity) {
  arrayremovevalue(level.var_70d37ee0, entity, 0);

  if(is_true(level.var_bce8fb65)) {
    println("<dev string:x38>" + "<dev string:xeb>" + entity getentitynumber() + "<dev string:x15c>");
  }

  if(is_true(level.var_bce8fb65)) {
    println("<dev string:x38>" + "<dev string:x139>" + level.var_70d37ee0.size + "<dev string:x17a>" + level.var_5fafe5ac.size + "<dev string:x157>" + 20 + "<dev string:x18e>");
  }
}

function function_b714128e(trap_prop, &prop_array) {
  trap_prop.prop_array = prop_array;
}

function function_80335b6(prop, &prop_array, condition_func = &function_708fe162) {
  prop.var_3e64167 = 1;
  var_7cfc32e1 = function_9cc082d2(prop.origin, 200);

  if(isDefined(var_7cfc32e1)) {
    position = var_7cfc32e1[# "point"];

    if(!ispointonnavmesh(position, 15.1875)) {
      position = getclosestpointonnavmesh(position, 15.1875, 15.1875);
    }

    prop.navmesh_position = position;
  }

  if(isDefined(prop.navmesh_position)) {
    if(abs(prop.origin[2] - prop.navmesh_position[2]) > 64) {
      prop.navmesh_position = undefined;
    }

    if(isDefined(prop.navmesh_position) && is_true(prop.var_99ae5a60)) {
      prop thread function_92ba7baa();
    }
  }

  prop thread trap_thread(prop_array, condition_func);
  prop.health = isDefined(prop.var_a0009315) ? prop.var_a0009315 : 50000;
  prop.takedamage = 1;

  if(isDefined(prop.var_c9826077)) {
    prop.var_c9826077.health = isDefined(prop.var_a0009315) ? prop.var_a0009315 : 50000;
    prop.var_c9826077.takedamage = 1;
    prop.var_c9826077 thread function_82305ba4(prop);
  }

  prop.tracked_damage = 0;
  prop.var_b31a1e22 = 0;
  prop val::reset(#"mimic_spawn", "hide");

  if(is_true(prop.var_99ae5a60)) {
    prop solid();
  }

  prop callback::function_d8abfc3d(#"on_scriptmover_damage", &function_24811d29);

  if(is_true(prop.var_c39008ae)) {
    level thread function_8f0687e(prop);
  }
}

function function_92ba7baa() {
  self endon(#"death", #"disconnect");
  wait 1;

  if(isDefined(self)) {
    v_forward = anglesToForward(self.angles) * 8;
    self.navmesh_position = getclosestpointonnavmesh(self.navmesh_position + v_forward, 64, 16);
  }
}

function function_8f0687e(prop) {
  queryresult = positionquery_source_navigation(prop.origin, 48, 128, 64, 32);

  if(!queryresult.data.size) {
    return;
  }

  if(isDefined(level.var_f29dd47)) {
    loc = [[level.var_f29dd47]](prop.origin, queryresult.data);
  } else {
    loc = array::random(queryresult.data);
  }

  if(!isDefined(loc)) {
    return;
  }

  var_8b84b3ce = groundtrace(loc.origin + (0, 0, 32) + (0, 0, 8), loc.origin + (0, 0, 32) + (0, 0, -100000), 0, undefined)[# "position"];
  var_8d3beb7f = # "p9_sur_junk_parts_rare";
  model2 = # "p9_sur_junk_parts_pile";
  var_d661f9f1 = util::spawn_model(array::random([var_8d3beb7f, model2]), var_8b84b3ce, (0, 0, 0));

  if(isDefined(var_d661f9f1)) {
    var_d661f9f1 clientfield::set("mimic_prop_lure_fx", 1);
    prop.var_d661f9f1 = var_d661f9f1;
  }
}

function function_55657fb4(mimic, trap_prop, &prop_array, var_d56229a9) {
  assert(isinarray(prop_array, trap_prop), "<dev string:x198>");
  function_b714128e(trap_prop, prop_array);

  if(isDefined(mimic)) {
    function_4540d40c(mimic, trap_prop);
  }

  function_80335b6(trap_prop, prop_array, var_d56229a9);
}

function function_708fe162() {
  prop_height = (0, 0, 64);
  players = arraysortclosest(getplayers(undefined, self.origin, 400), self.origin);

  if(players.size) {
    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      if(is_true(player.ignoreme) || player isnotarget() || player inlaststand()) {
        continue;
      }

      if(is_true(level.var_72a9fe4c)) {
        circle(player.origin, player getpathfindingradius(), (0, 1, 0), 0, 1, 1);
      }

      if(isDefined(player.last_valid_position) && isDefined(self.navmesh_position)) {
        if(!tracepassedonnavmesh(player.last_valid_position, self.navmesh_position, player getpathfindingradius())) {
          if(is_true(level.var_72a9fe4c)) {
            line(player.last_valid_position, self.navmesh_position, (1, 0, 1), 1, 0, 1);
            circle(self.navmesh_position, player getpathfindingradius(), (1, 0, 0), 0, 1, 1);
          }

          continue;
        }
      } else {
        player_center = player gettagorigin("j_spine4");

        if(!isDefined(player_center)) {
          player_center = player getcentroid();
        }

        if(isDefined(player_center) && !sighttracepassed(self.origin + prop_height, player_center, 0, self)) {
          if(is_true(level.var_72a9fe4c)) {
            line(self.origin + prop_height, player gettagorigin("<dev string:x1c1>"), (1, 0.5, 0), 1, 0, 1);
          }

          continue;
        }
      }

      traceresult = physicstraceex(self.origin + (0, 0, 23), player.origin + (0, 0, 36), (-15, -15, -15), (15, 15, 15), [self, player]);

      if(traceresult[# "fraction"] >= 1) {
        self notify(#"hash_7fb506f40bcf5962");
        return player;
      }

      if(is_true(level.var_72a9fe4c)) {
        line(self.origin + (0, 0, 8), player.origin + (0, 0, 8), (1, 0, 0), 1, 0, 1);
        sphere(traceresult[# "position"], 4, (1, 0, 0), 1, 0, 10, 1);
      }
    }
  }
}

function trap_thread(&prop_array, condition_func) {
  self endon(#"death", #"damage_transform");
  level endon(#"game_ended");

  if(!isDefined(self.zone_name)) {
    self.zone_name = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 15), 1);
  }

  if(isDefined(self.zone_name)) {
    self.pause_trap = 1;
    zm_zonemgr::zone_wait_till_enabled(self.zone_name);
    self.pause_trap = undefined;
  }

  while(true) {
    waitresult = level waittilltimeout(float(function_60d95f53()) / 1000, #"hash_7fd40fb3202e52db");

    if(is_true(self.pause_trap)) {
      continue;
    }

    activator = self[[condition_func]]();

    if(isDefined(activator) || waitresult._notify === # "hash_7fd40fb3202e52db") {
      activators = [activator];

      if(waitresult._notify === # "hash_7fd40fb3202e52db") {
        activators = getplayers();
      }

      if(isDefined(self.health) && self.health > 0) {
        if(isvehicle(self)) {} else if(true) {
          function_14bad487(self, 0.35, 0.05, 8);
        }
      }

      level thread transform_spawn(self, activators);
      return;
    }
  }
}

function function_6a447863(notifyhash) {
  if(isDefined(self)) {
    self.angles = self.original_angles;
    self.var_624e969b = undefined;
  }
}

function function_e77fca72() {
  self endoncallback(&function_6a447863, #"death", #"hash_7fb506f40bcf5962");
  self.var_624e969b = 1;
  self.original_angles = self.angles;

  while(true) {
    function_14bad487(self, 0.75, 0.05, 2);

    if(true) {
      wait 2;
    }
  }
}

function function_14bad487(trap_prop, total_time, iteration_time, angle) {
  trap_prop endon(#"death", #"entitydeleted");
  original_angles = trap_prop.angles;
  iterations = total_time / iteration_time;
  start_roll = trap_prop.angles[2];
  current_delta = angle;
  self clientfield::increment("mimic_prop_rattle_cf");

  if(isDefined(self.rattle_sound)) {
    playsoundatposition(self.rattle_sound, self.origin);
  }

  for(i = 0; i < iterations; i++) {
    trap_prop rotateroll(start_roll + current_delta, iteration_time);
    current_delta *= -1;
    wait iteration_time;
  }

  trap_prop.angles = original_angles;
}

function function_8be6cc92() {
  level endon(#"game_ended");
  self notify("3b6d68b63c3dc423");
  self endon("3b6d68b63c3dc423");

  while(true) {
    foreach(player in getplayers()) {
      if(!isalive(player)) {
        continue;
      }

      if(!isDefined(arraygetclosest(player.origin, level.var_b7a636c9, 400))) {
        player clientfield::set_to_player("mimic_force_stream", 0);
      } else {
        player clientfield::set_to_player("mimic_force_stream", 1);
      }

      waitframe(1);
    }

    wait 0.5;
  }
}

function function_24811d29(s_info) {
  prop = self;
  prop.health = isDefined(prop.var_a0009315) ? prop.var_a0009315 : 50000;

  if(is_true(self.pause_trap)) {
    return;
  }

  if(!isPlayer(s_info.einflictor) && !isPlayer(s_info.eattacker)) {
    return;
  }

  if(gettime() - prop.var_b31a1e22 > int(3 * 1000)) {
    prop.tracked_damage = 0;
  }

  prop.tracked_damage += s_info.idamage;
  prop.var_b31a1e22 = gettime();

  if(prop.tracked_damage >= 100) {
    player = isPlayer(s_info.einflictor) ? s_info.einflictor : s_info.eattacker;
    prop notify(#"damage_transform");
    player stats::function_dad108fa(#"hash_7ce9029b025320f0", 1);
    transform_spawn(prop, [player], s_info);
  }
}

function function_82305ba4(model_owner) {
  self endon(#"death");
  level endon(#"game_ended");
  var_d4d62b3e = self;

  while(isDefined(var_d4d62b3e)) {
    waitresult = var_d4d62b3e waittill(#"damage");
    var_d4d62b3e.health = isDefined(model_owner.var_a0009315) ? model_owner.var_a0009315 : 50000;
    model_owner dodamage(waitresult.amount, waitresult.position, waitresult.attacker, waitresult.inflictor, undefined, waitresult.mod, waitresult.flags, waitresult.weapon);
  }
}

function function_d52f5cf7(trap_prop, mimic) {
  mimic.prop_array = trap_prop.prop_array;
  mimic.reveal_time = gettime();
  mimic callback::function_d8abfc3d(#"on_ai_killed", &function_1187de9);
}

function transform_spawn(prop, &activators, activation_info) {
  if(isDefined(prop.var_3c964886)) {
    [[prop.var_3c964886]](prop);
    prop.var_3c964886 = undefined;
  }

  if(isDefined(prop.hidden_entities)) {
    arrayremovevalue(prop.hidden_entities, undefined);

    foreach(entity in prop.hidden_entities) {
      function_d52f5cf7(prop, entity);
      entity callback::callback(#"hash_484127e0cbd8f8cb", {
        #activators: activators, #activation_info: activation_info
      });
    }
  } else {
    have_room = getaicount() < getailimit();

    if(!have_room && isDefined(level.var_e1712840) && [[level.var_e1712840]]()) {
      have_room = 1;
    }

    if(have_room) {
      if(!isDefined(level.var_15a5fa7f)) {
        level.var_15a5fa7f = # "spawner_bo5_mimic";
      }

      var_c25f58d9 = spawnactor(level.var_15a5fa7f, prop.origin, prop.angles, undefined, 1);

      if(isDefined(var_c25f58d9)) {
        var_c25f58d9 hide();
        function_4540d40c(var_c25f58d9, prop);
        function_d52f5cf7(prop, var_c25f58d9);
        waitframe(1);

        if(isDefined(var_c25f58d9)) {
          var_c25f58d9 show();
          var_c25f58d9 callback::callback(#"hash_484127e0cbd8f8cb", {
            #activators: activators, #activation_info: activation_info
          });
        }
      }
    } else {
      println("<dev string:x1cd>");
    }
  }

  if(!isDefined(prop)) {
    return;
  }

  prop.hidden_entities = undefined;
  prop.claimed = undefined;

  if(!isDefined(prop.spawn_loc.lure_prop_type)) {
    prop val::set(#"mimic_spawn", "hide", 1);
    prop notsolid();
  }

  prop callback::function_52ac9652(#"on_scriptmover_damage", &function_24811d29);

  if(isDefined(prop.var_d661f9f1)) {
    prop.var_d661f9f1 clientfield::set("mimic_prop_lure_fx", 0);
    prop.var_d661f9f1 deletedelay();
    prop.var_d661f9f1 = undefined;
  }
}

function function_4540d40c(entity, prop) {
  assert(!is_true(entity.var_2ca2d270), "<dev string:x1f8>");
  entity.trap_prop = prop;
  entity.var_83fa6083 = 1;
  entity val::set(#"hash_263a780666aef25", "hide", 2);
  entity notsolid();
  entity pathmode("dont move", 1);
  entity dontinterpolate();
  entity forceteleport(prop.origin, prop.angles);
  entity setentitypaused(1);
  entity.var_2ca2d270 = 1;
  entity.var_e8920729 = 1;
  entity.var_9d11c76e = 1;
  entity callback::callback(#"hash_29cb63a7ebb5d699", {
    #prop: prop
  });

  if(!isDefined(prop.hidden_entities)) {
    prop.hidden_entities = [];
  }

  prop.hidden_entities[prop.hidden_entities.size] = entity;
}

function function_1187de9(params) {
  arrayremovevalue(self.prop_array, undefined);

  foreach(prop in self.prop_array) {
    if(isDefined(prop.var_33960526)) {
      [[prop.var_33960526]]();
    }

    level thread clean_up_prop(prop);
  }
}

function clean_up_prop(prop, var_38acf8bf = 1) {
  if(!isDefined(prop)) {
    return;
  }

  level endon(#"game_ended");
  prop endon(#"death");

  if(isDefined(prop.hidden_entities)) {
    function_1eaaceab(prop.hidden_entities);

    foreach(hidden_entity in prop.hidden_entities) {
      if(hidden_entity ispaused()) {
        hidden_entity setentitypaused(0);
      }

      hidden_entity deletedelay();
    }
  }

  arrayremovevalue(level.var_5fafe5ac, prop);
  arrayremovevalue(level.var_b7a636c9, prop);

  if(isDefined(prop.var_3c964886)) {
    [[prop.var_3c964886]](prop);
    prop.var_3c964886 = undefined;
  }

  if(isDefined(prop.spawn_loc.lure_prop_type)) {
    return;
  }

  if(isDefined(prop.var_d661f9f1)) {
    prop.var_d661f9f1 clientfield::set("mimic_prop_lure_fx", 0);
    prop.var_d661f9f1 deletedelay();
    prop.var_d661f9f1 = undefined;
  }

  if(isDefined(prop.origin) && is_true(var_38acf8bf)) {
    playFX("zm_ai/fx9_mimic_prop_spawn_out", prop.origin);
    prop playSound(#"hash_408f33e5cf20df9d");
    wait 0.1;
  }

  prop delete();
}

function function_fd24f982() {
  arrayremovevalue(level.var_5fafe5ac, undefined);

  foreach(prop in level.var_5fafe5ac) {
    level thread clean_up_prop(prop);
  }
}

function function_da3be96b(type, handler, validator) {
  if(isDefined(level.var_6939ebc1[type])) {
    return;
  }

  if(!isDefined(level.var_6939ebc1)) {
    level.var_6939ebc1 = [];
  }

  level.var_6939ebc1[type] = {
    #handler: handler, #validator: validator
  };
}

function function_6fe38c03(prop_struct) {
  trigger = prop_struct.trigger;
  scriptmodel = prop_struct.trigger.scriptmodel;

  if(!isDefined(scriptmodel)) {
    scriptmodel = prop_struct.scriptmodel;
  }

  if(!(isDefined(trigger) && isDefined(scriptmodel)) && !isDefined(prop_struct.model)) {
    return undefined;
  }

  if(isDefined(trigger) && isDefined(scriptmodel)) {
    trap_prop = scriptmodel;
    trap_prop.spawn_loc = prop_struct;
    trap_prop.var_86038c7b = 1;
    trap_prop.var_be16d31e = 1;

    if(isDefined(trigger._callbacks[# "on_trigger"])) {
      trigger.var_d5434bfe = arraycopy(trigger._callbacks[# "on_trigger"]);
      trigger._callbacks[# "on_trigger"] = undefined;
    }

    trap_prop.var_d503cbd6 = {
      #trigger: trigger, #scriptmodel: scriptmodel
    };
    trap_prop.var_3c964886 = &function_3c964886;
    trigger callback::on_trigger(&function_55d49380, undefined, trap_prop);
    return {
      #prop: trap_prop, #activation_func: &function_204a610e
    };
  }
}

function function_644d4bf6(var_752f06e1) {
  if(!isDefined(var_752f06e1)) {
    return;
  }

  trap_prop = var_752f06e1.prop;
  trap_prop.spawn_loc = var_752f06e1;
  trap_prop.var_a0009315 = 5;
  trap_prop.var_3c964886 = &function_3c964886;
  trap_prop callback::function_d8abfc3d(#"hash_5f0caa4b2d44fedf", &function_7826507);
  return {
    #prop: trap_prop, #activation_func: &function_204a610e
  };
}

function function_6f514803(vehicle_struct) {
  if(!isDefined(vehicle_struct)) {
    return;
  }

  trap_prop = vehicle_struct.prop;
  trap_prop.var_2e8a136f = 1;
  trap_prop.spawn_loc = vehicle_struct;
  trap_prop.var_86038c7b = 1;
  trap_prop.var_be16d31e = 1;
  trap_prop.var_d503cbd6 = undefined;
  trap_prop.var_3c964886 = &function_6bb0d769;
  return {
    #prop: trap_prop, #activation_func: &function_204a610e
  };
}

function function_7826507(params) {
  self notify(#"hash_1e8aabc2641542e", {
    #activator: params.attacker
  });
}

function function_55d49380(trigger_info, trap_prop) {
  trap_prop notify(#"hash_1e8aabc2641542e", {
    #activator: trigger_info.activator
  });
}

function function_95f8029e(player_activator) {
  self.var_2e8a136f = 0;
  self notify(#"hash_1e8aabc2641542e", {
    #activator: player_activator
  });
}

function function_204a610e(params) {
  waitresult = self waittill(#"hash_1e8aabc2641542e");
  return waitresult.activator;
}

function function_3c964886(trap_prop) {
  if(!isDefined(trap_prop.var_d503cbd6.trigger)) {
    return;
  }

  trigger = trap_prop.var_d503cbd6.trigger;
  scriptmodel = trap_prop.var_d503cbd6.scriptmodel;
  level thread function_f78a8a69(trigger, scriptmodel, 5);
  trap_prop.var_d503cbd6 = undefined;
}

function function_f78a8a69(trigger, scriptmodel, restore_wait) {
  level endon(#"game_ended");
  trigger endon(#"death");
  scriptmodel endon(#"death");
  scriptmodel val::set(#"hash_b71e2a9baaa9c62", "hide", 2);
  scriptmodel notsolid();
  wait restore_wait;
  scriptmodel val::reset(#"hash_b71e2a9baaa9c62", "hide");
  scriptmodel solid();
  trigger._callbacks[# "on_trigger"] = arraycopy(trigger.var_d5434bfe);
  trigger.var_d5434bfe = undefined;
}

function function_6bb0d769(trap_vehicle) {
  level thread restore_vehicle(trap_vehicle, 5);
}

function private restore_vehicle(vehicle, restore_wait) {
  level endon(#"game_ended");
  vehicle val::set(#"hash_b71e2a9baaa9c62", "hide", 2);
  vehicle notsolid();
  wait restore_wait;

  if(!isDefined(vehicle)) {
    return;
  }

  vehicle val::reset(#"hash_b71e2a9baaa9c62", "hide");
  vehicle solid();
}