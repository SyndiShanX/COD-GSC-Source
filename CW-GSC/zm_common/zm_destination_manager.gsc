/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_destination_manager.gsc
************************************************/

#using script_4474799e52e84c59;
#using script_5a525a75a8f1f7e4;
#using script_7b1cd3908a825fdd;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_fishing;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zsurvival;
#using scripts\zm_common\zm_wallbuy;
#namespace zm_destination_manager;

function private autoexec __init__system__() {
  system::register(#"zm_destination_manager", &preinit, undefined, &finalize, #"content_manager");
}

function private preinit() {
  level.contentmanager.preinit = 0;
  level flag::init(#"navmesh_loading", 0);
  level.var_7de6c9f = undefined;
}

function private finalize() {
  if(!zm_utility::function_c200446c()) {
    level thread function_1975f7db();
  }
}

function function_123b048f(var_8a952bed) {
  assert(isDefined(var_8a952bed), "<dev string:x38>");
  assert(var_8a952bed.variantname == # "content_destination", "<dev string:x38>");
  level.contentmanager.var_5f2429b1 = var_8a952bed;
}

function function_2e165386() {
  return level.contentmanager.var_d60029a6;
}

function function_f3be07d7(destination) {
  if(isDefined(level.var_490ade6)) {
    objective_manager::function_b06af8e3(destination, 1, level.var_490ade6, level.var_c73744cc);
  } else if(!isDefined(level.contentmanager.nextobjective)) {
    objective_manager::function_a8ad6895(destination);
  }

  var_9200b8df = level.contentmanager.nextobjective.spawn_list;

  if(isDefined(var_9200b8df)) {
    var_5f03e419 = strtok(var_9200b8df, ",");

    if(level.var_b48509f9 === 1 && var_5f03e419.size > 1 && util::get_map_name() === "mp_black_sea") {
      arrayremovevalue(var_5f03e419, "3");
    }

    var_f281f968 = array::random(var_5f03e419);
    var_58b02068 = function_e4254bac(destination, var_f281f968);
  }

  var_f281f968 = getdvarint(#"hash_445bd141a460ff3a", 0);

  if(var_f281f968) {
    var_58b02068 = function_e4254bac(destination, var_f281f968);
  }

  if(!isDefined(var_58b02068)) {
    var_58b02068 = content_manager::function_31e8da78(destination, #"start_spawn");
  }

  level.contentmanager.nextspawn = var_58b02068;
  level flag::set(#"hash_10679ff0bf4d6c8d");
  var_842cdacd = content_manager::get_children(var_58b02068);
  return array::randomize(var_842cdacd);
}

function function_e4254bac(destination, var_f281f968) {
  locations = array::randomize(content_manager::get_children(destination));

  for(i = 0; i < locations.size; i++) {
    if(locations[i].variantname !== # "content_location") {
      arrayremoveindex(locations, i, 1);
    }
  }

  arrayremovevalue(locations, undefined);

  foreach(location in locations) {
    instances = array::randomize(content_manager::get_children(location));

    foreach(instance in instances) {
      if(instance.content_script_name === # "start_spawn" && instance.script_int === var_f281f968) {
        return instance;
      }
    }
  }
}

function private function_6f9efb66() {
  var_4f146e5d = [];
  a_destinations = level.contentmanager.destinations;
  var_4f146e5d = [];

  foreach(var_8a952bed in a_destinations) {
    if(is_true(var_8a952bed.var_8d629117)) {
      continue;
    }

    var_4f146e5d = function_f3be07d7(var_8a952bed);

    if(var_4f146e5d.size) {
      var_9b06d3e2 = var_8a952bed.targetname;
      break;
    }
  }

  if(isDefined(var_8a952bed)) {
    function_123b048f(var_8a952bed);
  }
}

function private function_1975f7db() {
  destinations = [];
  categories = [];
  objective_manager::function_ef3a1d04(destinations, categories);
  objective_manager::function_c700a68b(categories);
  callback::callback(#"hash_276921163232533");
  var_4191df0e = getdvarint(#"hash_688e3b3254c8a895", 0);

  if(!var_4191df0e) {
    function_6f9efb66();
  }

  if(isDefined(level.contentmanager.var_64a75da7)) {
    [[level.contentmanager.var_64a75da7]]();
  }

  if(getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
    return;
  }

  if(!isDefined(level.contentmanager.var_d60029a6)) {
    var_92a668db = getdvarint(#"hash_6c0d94ade91b07a8", 0);

    if(!var_92a668db || var_92a668db > level.contentmanager.destinations.size) {
      var_92a668db = level.contentmanager.destinations.size;
    }

    var_a3c51b07[0] = level.contentmanager.var_5f2429b1;
    arrayremovevalue(destinations, var_a3c51b07[0]);

    for(i = 1; i < var_92a668db; i++) {
      var_918869fb = var_a3c51b07[i - 1].adjacencies;

      if(!isDefined(var_918869fb)) {
        var_918869fb = arraycopy(destinations);
      }

      while(destinations.size && var_918869fb.size) {
        var_c0335359 = array::random(var_918869fb);

        if(!isDefined(var_c0335359.var_e859e591) || !var_c0335359.var_e859e591.size || isinarray(var_a3c51b07, var_c0335359)) {
          arrayremovevalue(var_918869fb, var_c0335359);
          continue;
        }

        break;
      }

      if(!destinations.size) {
        break;
      }

      arrayremovevalue(destinations, var_c0335359);
      var_a3c51b07[i] = var_c0335359;
    }

    var_6067a19c = var_a3c51b07[i - 1];

    if(isDefined(var_6067a19c.var_e859e591[# "final_battle"])) {
      var_6067a19c.final_battle = 1;
    }

    level.contentmanager.var_d60029a6 = var_a3c51b07;

    if(var_4191df0e) {
      function_6f9efb66();
    }
  }

  level thread function_786a9f4d(level.contentmanager.var_d60029a6);
  level flag::set(#"hash_7ace2c0d668c5128");
}

function function_786a9f4d(destinations) {
  level endon(#"game_ended");
  level.contentmanager.var_46849b1b = 0;

  while(destinations.size) {
    foreach(destination in destinations) {
      level thread activate(destination);
      s_result = level waittill(#"objective_ended");

      if(s_result.completed === 0) {
        if(isDefined(level.contentmanager.var_4824f1b9) && [[level.contentmanager.var_4824f1b9]]()) {
          return;
        }
      } else {
        level callback::callback(#"hash_4ce318cfe14b54e7");
      }

      if(isDefined(level.contentmanager.var_314d6e9b)) {
        [[level.contentmanager.var_314d6e9b]](destination);
      }

      level thread namespace_591b4396::function_7c05a985(destination);
      level.contentmanager.var_46849b1b++;

      if(level.contentmanager.var_46849b1b >= destinations.size) {
        level.contentmanager.var_46849b1b = 0;
      }

      level waittill(#"portal_activated");
      level callback::callback(#"portal_activated");
      locations = destination.locations;

      foreach(location in locations) {
        foreach(instance in location.instances) {
          instance callback::callback(#"portal_activated");
        }
      }

      level callback::callback(#"destination_completed");
      deactivate(destination);
      function_dafa6af4(destination);
      return;
    }
  }
}

function function_dafa6af4(destination) {
  if(!isDefined(level.var_3d1ef3ae) && isstring(getDvar(#"hash_2f8775fbdde23a15"))) {
    level.var_3d1ef3ae = getDvar(#"hash_2f8775fbdde23a15");
  }

  if(level.contentmanager.var_dc858a58.list[level.contentmanager.var_dc858a58.index] === level.script) {
    prev_index = level.contentmanager.var_dc858a58.index;
    level.contentmanager.var_dc858a58.index = (level.contentmanager.var_dc858a58.index + 1) % level.contentmanager.var_dc858a58.list.size;

    if(level.contentmanager.var_dc858a58.index < prev_index) {
      level.contentmanager.var_dc858a58.list = array::randomize(level.contentmanager.var_dc858a58.list);

      while(level.contentmanager.var_dc858a58.list[0] === level.script) {
        level.contentmanager.var_dc858a58.list = array::randomize(level.contentmanager.var_dc858a58.list);
      }
    }
  }

  if(isDefined(level.var_c73744cc)) {
    level.contentmanager.var_9614b1d2[level.var_490ade6].index = (level.contentmanager.var_9614b1d2[level.var_490ade6].index + 1) % level.contentmanager.var_9614b1d2[level.var_490ade6].list.size;
  }

  var_bed9ce19 = level.contentmanager.var_407236bf.list[level.contentmanager.var_407236bf.index];

  if(!level.contentmanager.var_691808e8.size) {
    prev_index = level.contentmanager.var_407236bf.index;
    level.contentmanager.var_407236bf.index = (level.contentmanager.var_407236bf.index + 1) % level.contentmanager.var_407236bf.list.size;

    if(level.contentmanager.var_407236bf.index < prev_index) {
      level.contentmanager.var_407236bf.list = array::randomize(level.contentmanager.var_407236bf.list);

      while(level.contentmanager.var_407236bf.list[0] === var_bed9ce19) {
        level.contentmanager.var_407236bf.list = array::randomize(level.contentmanager.var_407236bf.list);
      }
    }
  } else {
    var_691808e8 = array::randomize(level.contentmanager.var_691808e8);

    foreach(objective in var_691808e8) {
      arrayremovevalue(level.contentmanager.var_407236bf.list, objective);
    }

    level.contentmanager.var_407236bf.list = array::randomize(level.contentmanager.var_407236bf.list);
    level.contentmanager.var_407236bf.list = arraycombine(var_691808e8, level.contentmanager.var_407236bf.list, 0);
    level.contentmanager.var_407236bf.index = 0;
  }

  var_112acc94 = isDefined(level.var_3d1ef3ae) ? level.var_3d1ef3ae : level.contentmanager.var_dc858a58.list[level.contentmanager.var_dc858a58.index];

  if(isDefined(var_112acc94)) {
    zm_utility_zsurvival::switch_map(var_112acc94);
  }
}

function private function_c62829da(destination) {
  if(function_d71c83a7()) {
    if(isDefined(destination.contentgroups[# "hash_3460aae6bb799a99"])) {
      var_6c486d1a = destination.contentgroups[# "hash_3460aae6bb799a99"][0];

      if(isDefined(var_6c486d1a)) {
        var_f6b2bc6f = getent(var_6c486d1a.targetname, "target");

        if(isDefined(var_f6b2bc6f)) {
          return var_f6b2bc6f;
        }
      }
    }
  }

  return undefined;
}

function function_ab94c270(destination) {
  if(level flag::get(#"navmesh_loading")) {
    return;
  }

  ent = function_c62829da(destination);

  if(level.var_7de6c9f === ent) {
    return;
  }

  if(isDefined(ent)) {
    level flag::set(#"navmesh_loading");
    level.var_7de6c9f = undefined;
    var_ada19974 = function_dbe9e22e(ent);

    while(var_ada19974.size > 0) {
      var_ada19974 = function_8abb2f1a(var_ada19974);
      waitframe(1);
    }

    level flag::clear(#"navmesh_loading");
    level.var_7de6c9f = ent;
  }
}

function activate(destination) {
  level.contentmanager.currentdestination = destination;
  level callback::callback(#"destination_activated", {
    #destination: destination
  });
  level thread function_ab94c270(destination);
  level flag::wait_till_clear(#"navmesh_loading");

  if(isDefined(level.contentmanager.var_a3205267)) {
    [[level.contentmanager.var_a3205267]](destination);
  }

  if(!getdvarint(#"hash_4fd21096bcb24e82", 0) && !getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
    objective_manager::spawn_objective();
  }

  if(isDefined(level.contentmanager.var_62a42ce)) {
    [[level.contentmanager.var_62a42ce]](destination);
  }

  level thread zm_magicbox::function_2dcb5cea(destination);

  if(zm_utility::is_survival()) {
    level thread zm_wallbuy::function_669a830(destination);
    level thread namespace_c09ae6c3::function_7b19802a(destination);
  }

  if(is_true(getgametypesetting(#"hash_7cc2f3e9453e060b"))) {
    showmiscmodels("fishing_setup");
    hidemiscmodels("fishing_no_use");
    level thread zm_fishing::function_43eaec20(destination);
  } else {
    hidemiscmodels("fishing_setup");
  }

  if(zm_utility::is_survival() && is_true(getgametypesetting(#"hash_1aaf37c19b933d03"))) {
    level thread namespace_5b3a52eb::function_f5ccdd88(destination);
  }

  level callback::callback(#"hash_7cdee03c16eb684a", {
    #destination: destination
  });
}

function deactivate(destination) {
  level callback::callback(#"hash_565739346fc951ae", {
    #destination: destination
  });
  content_manager::function_690c4abe();
  level notify(#"hash_3b28fcaa0b9b4489");
}

function function_506afb9e(destination, var_2371bf) {
  names = var_2371bf;

  if(isstring(var_2371bf) || ishash(var_2371bf)) {
    names = [var_2371bf];
  }

  var_526e473a = [];

  foreach(location in destination.locations) {
    foreach(name, instance in location.instances) {
      if(!isinarray(names, name)) {
        continue;
      }

      foreach(group in instance.contentgroups) {
        var_526e473a = arraycombine(var_526e473a, function_66ec9032(group), 0, 0);
      }
    }
  }

  return var_526e473a;
}

function function_66ec9032(struct_array) {
  var_526e473a = [];

  if(!struct_array.size) {
    return var_526e473a;
  }

  foreach(struct in struct_array) {
    if(struct.contentgroups.size) {
      foreach(group in struct.contentgroups) {
        var_526e473a = arraycombine(var_526e473a, function_66ec9032(group), 0, 0);
      }
    }

    var_526e473a[var_526e473a.size] = struct;
  }

  return var_526e473a;
}