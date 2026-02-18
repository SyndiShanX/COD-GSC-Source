/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\content_manager.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace content_manager;

function private autoexec __init__system__() {
  system::register(#"content_manager", &preinit, undefined, &finalize, undefined);
}

function private preinit() {
  level.contentmanager = spawnStruct();
  level.contentmanager.registeredscripts = [];
  level.contentmanager.scriptcategories = [];
}

function private finalize() {
  setup_destinations();
  setup_locations();
  level.contentmanager.spawnedinstances = [];

  level thread init_devgui();
}

function register_script(scriptname, spawncallback, var_99021fa0 = 0) {
  assert(isstring(scriptname) || ishash(scriptname));
  assert(isfunctionptr(spawncallback));
  registeredscripts = level.contentmanager.registeredscripts;
  assert(!isDefined(registeredscripts[scriptname]));
  script = {
    #scriptname: scriptname, #spawncallback: spawncallback
  };
  registeredscripts[scriptname] = script;

  if(var_99021fa0) {
    if(!isDefined(level.contentmanager.var_ab00156)) {
      level.contentmanager.var_ab00156 = [];
    } else if(!isarray(level.contentmanager.var_ab00156)) {
      level.contentmanager.var_ab00156 = array(level.contentmanager.var_ab00156);
    }

    level.contentmanager.var_ab00156[level.contentmanager.var_ab00156.size] = scriptname;
  } else if(scriptname === # "safehouse") {
    script.var_b4fae213 = 9;
  }

  return script;
}

function get_script(scriptname) {
  assert(isstring(scriptname) || ishash(scriptname));
  return level.contentmanager.registeredscripts[scriptname];
}

function function_4485ab6d(key, value) {
  assert(isstring(key));
  return function_7b8e26b3(level.contentmanager.registeredscripts, value, key);
}

function function_31e8da78(destination, content_category) {
  locations = array::randomize(get_children(destination));

  for(i = 0; i < locations.size; i++) {
    if(locations[i].variantname !== # "content_location") {
      arrayremoveindex(locations, i, 1);
    }
  }

  arrayremovevalue(locations, undefined);

  foreach(location in locations) {
    instances = array::randomize(get_children(location));

    foreach(instance in instances) {
      if(instance.content_script_name === content_category) {
        return instance;
      }
    }
  }
}

function private setup_destinations() {
  mapdestinations = struct::get_array(#"content_destination", "variantname");
  destinations = [];
  level.contentmanager.destinations = destinations;

  foreach(destination in mapdestinations) {
    assert(isDefined(destination.targetname));
    assert(!isDefined(destinations[destination.targetname]));
    destinations[destination.targetname] = destination;
    function_656a32f0(destination);
    locations = [];
    destination.locations = locations;
    children = get_children(destination);

    foreach(child in children) {
      if(child.variantname != # "content_location") {
        continue;
      }

      assert(isDefined(child.targetname));
      assert(!isDefined(locations[child.targetname]));
      locations[child.targetname] = child;
    }
  }

  var_e5f80f4e = getmapfields(util::get_map_name());

  if(isDefined(var_e5f80f4e.var_dd9e5316)) {
    foreach(destination in var_e5f80f4e.var_dd9e5316) {
      struct::get(destination.targetname).var_8d629117 = !is_true(destination.var_a15fd6d3);

      if(!isDefined(destination.var_7774bfaf)) {
        continue;
      }

      enabled = getgametypesetting(destination.var_7774bfaf);
      assert(isDefined(enabled), "<dev string:x38>" + destination.var_7774bfaf + "<dev string:x4c>");

      if(is_false(enabled)) {
        arrayremovevalue(destinations, struct::get(destination.targetname));
      }
    }
  }

  level.contentmanager.destinations = array::randomize(destinations);
}

function setup_adjacencies(str_destination, var_2d26f85c) {
  assert(isDefined(level.contentmanager.destinations[str_destination]) && isDefined("<dev string:x5e>" + str_destination));
  i = 0;

  foreach(var_fc091632 in var_2d26f85c) {
    adjacency = struct::get(var_fc091632);
    assert(isDefined(adjacency) && isDefined("<dev string:x8d>" + var_fc091632));
    level.contentmanager.destinations[str_destination].adjacencies[i] = adjacency;
    i++;
  }
}

function function_fe9fb6fd(location) {
  assert(isstruct(location));
  assert(location.variantname == # "content_location");
  spawned_instances = isarray(location.spawnedinstances) && location.spawnedinstances.size > 0;
  return spawned_instances;
}

function private setup_locations() {
  maplocations = struct::get_array(#"content_location", "variantname");
  locations = [];
  level.contentmanager.locations = locations;

  foreach(location in maplocations) {
    assert(isDefined(location.targetname));
    assert(!isDefined(locations[location.targetname]));
    locations[location.targetname] = location;

    if(isDefined(location.target)) {
      parent = struct::get(location.target);

      if(parent.variantname == # "content_destination") {
        location.destination = parent;
      }
    }

    function_656a32f0(location);
    instances = [];
    location.instances = instances;
    children = get_children(location);

    foreach(child in children) {
      if(child.variantname != # "content_instance") {
        continue;
      }

      assert(isDefined(child.content_script_name));
      assert(!isDefined(instances[child.content_script_name]));
      instances[child.content_script_name] = child;
      child.location = location;
    }
  }
}

function spawn_instance(instance) {
  assert(isstruct(instance));
  assert(instance.variantname == # "content_instance");
  assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
  assert(isstruct(instance.location));
  function_656a32f0(instance);
  script = level.contentmanager.registeredscripts[instance.content_script_name];

  if(isDefined(script.spawncallback)) {
    level thread[[script.spawncallback]](instance);
  }

  function_130f0da3(instance);
}

function function_1c78a45d(instance) {
  assert(isstruct(instance));
  assert(instance.variantname == # "content_instance");
  assert(isstring(instance.content_script_name) || ishash(instance.content_script_name));
  assert(isstruct(instance.location));
  return !function_fe9fb6fd(instance.location);
}

function private function_130f0da3(instance) {
  assert(isarray(level.contentmanager.spawnedinstances));

  if(!isDefined(instance.location.spawnedinstances)) {
    instance.location.spawnedinstances = [];
  }

  instance.location.spawnedinstances[instance.location.spawnedinstances.size] = instance;
  spawnedinstances = level.contentmanager.spawnedinstances;

  if(!isDefined(spawnedinstances[instance.content_script_name])) {
    spawnedinstances[instance.content_script_name] = [];
  }

  instances = spawnedinstances[instance.content_script_name];
  instances[instances.size] = instance;
}

function function_76c93f39(contentstructs, usecallback, hintstring, radius) {
  assert(isarray(contentstructs));
  assert(isfunctionptr(usecallback));
  assert(ishash(hintstring));
  triggers = [];

  foreach(struct in contentstructs) {
    trigger = spawn_interact(struct, usecallback, hintstring, undefined, radius);
    triggers[trigger.size] = trigger;
  }

  return triggers;
}

function spawn_interact(struct, usecallback, hintstring, var_e0355bdc, radius = 64, height = 128, centered = 1, offset = (0, 0, 0), var_499de507) {
  assert(isstruct(struct));
  assert(isfunctionptr(usecallback));
  assert(ishash(hintstring));

  if(isDefined(struct.radius)) {
    radius = struct.radius;
  }

  usetrigger = spawn("trigger_radius_use", struct.origin + offset, 0, radius, height, centered);
  usetrigger triggerignoreteam();
  usetrigger setcursorhint("HINT_NOICON");
  usetrigger usetriggerrequirelookat();

  if(isDefined(var_e0355bdc) && isDefined(var_499de507)) {
    usetrigger sethintstring(hintstring, var_e0355bdc, var_499de507);
  } else if(isDefined(var_e0355bdc)) {
    usetrigger sethintstring(hintstring, var_e0355bdc);
  } else {
    usetrigger sethintstring(hintstring);
  }

  usetrigger callback::on_trigger(usecallback);
  struct.trigger = usetrigger;
  return usetrigger;
}

function function_22e120bc(struct, usecallback, hintstring, var_e0355bdc, n_width = 64, n_length = 64, n_height = 64, offset = (0, 0, 0), var_499de507) {
  assert(isstruct(struct));
  assert(isfunctionptr(usecallback));
  assert(ishash(hintstring));
  usetrigger = spawn("trigger_box_use", struct.origin + offset, 0, n_width, n_length, n_height);
  usetrigger triggerignoreteam();
  usetrigger setcursorhint("HINT_NOICON");
  usetrigger usetriggerrequirelookat();

  if(isDefined(var_e0355bdc) && isDefined(var_499de507)) {
    usetrigger sethintstring(hintstring, var_e0355bdc, var_499de507);
  } else if(isDefined(var_e0355bdc)) {
    usetrigger sethintstring(hintstring, var_e0355bdc);
  } else {
    usetrigger sethintstring(hintstring);
  }

  usetrigger callback::on_trigger(usecallback);
  struct.trigger = usetrigger;
  return usetrigger;
}

function function_cfa4f1a0(contentstructs, modelname, var_bfbc537c = 0, var_619a5c20 = 1) {
  models = [];

  foreach(struct in contentstructs) {
    model = spawn_script_model(struct, modelname, var_bfbc537c, var_619a5c20);
    models[models.size] = model;
  }

  return models;
}

function spawn_script_model(struct, modelname, var_bfbc537c = 0, var_619a5c20 = 1) {
  model = util::spawn_model(modelname, struct.origin, struct.angles);

  if(isDefined(struct.targetname)) {
    model.targetname = struct.targetname;
  }

  if(isDefined(struct.script_noteworthy)) {
    model.script_noteworthy = struct.script_noteworthy;
  }

  if(var_bfbc537c) {
    model disconnectpaths();
  }

  if(var_619a5c20) {
    model function_619a5c20();
  }

  parent = struct;

  while(true) {
    if(parent.variantname === # "content_instance") {
      if(!isDefined(parent.a_models)) {
        parent.a_models = [];
      } else if(!isarray(parent.a_models)) {
        parent.a_models = array(parent.a_models);
      }

      if(!isinarray(parent.a_models, model)) {
        parent.a_models[parent.a_models.size] = model;
      }

      break;
    }

    parent = struct::get(parent.target);

    if(!isDefined(parent)) {
      break;
    }
  }

  return model;
}

function spawn_zbarrier(struct, zbarrier_classname, var_e546275c = 0) {
  zbarrier = spawn(zbarrier_classname, struct.origin);
  zbarrier.angles = struct.angles;

  if(var_e546275c) {
    zbarrier disconnectpaths();
  }

  parent = struct;

  while(true) {
    if(parent.variantname === # "content_instance") {
      if(!isDefined(parent.a_models)) {
        parent.a_models = [];
      } else if(!isarray(parent.a_models)) {
        parent.a_models = array(parent.a_models);
      }

      if(!isinarray(parent.a_models, zbarrier)) {
        parent.a_models[parent.a_models.size] = zbarrier;
      }

      break;
    }

    parent = struct::get(parent.target);

    if(!isDefined(parent)) {
      break;
    }
  }

  return zbarrier;
}

function function_690c4abe() {
  level notify(#"hash_4a140b223cb0019d");
  models_cleaned = 0;

  foreach(group in level.contentmanager.spawnedinstances) {
    foreach(instance in group) {
      if(isDefined(instance.a_models)) {
        foreach(model in instance.a_models) {
          if(isDefined(model)) {
            if(isDefined(model.trigger)) {
              model.trigger delete();
            }

            if(isDefined(model.var_e55c8b4e)) {
              if(isDefined(level.var_49f8cef4)) {
                [[level.var_49f8cef4]](model.var_e55c8b4e);
              } else {
                objective_delete(model.var_e55c8b4e);
                gameobjects::release_obj_id(model.var_e55c8b4e);
              }
            }

            if(isDefined(model.objectiveid)) {
              if(isDefined(level.var_49f8cef4)) {
                [[level.var_49f8cef4]](model.objectiveid);
              } else {
                objective_delete(model.objectiveid);
                gameobjects::release_obj_id(model.objectiveid);
              }
            }

            model scene::stop();
            model delete();
            models_cleaned += 1;

            if(models_cleaned % 10 == 0) {
              waitframe(1);
            }
          }
        }

        arrayremovevalue(instance.a_models, undefined);
      }

      arrayremovevalue(group, instance, 1);
      arrayremovevalue(instance.location.spawnedinstances, instance, 1);
    }

    arrayremovevalue(group, undefined);
    arrayremovevalue(level.contentmanager.spawnedinstances, group, 1);
  }

  arrayremovevalue(level.contentmanager.spawnedinstances, undefined);
}

function private function_656a32f0(parent) {
  children = get_children(parent);
  contentgroups = function_bedd4c47(children);
  parent.contentgroups = contentgroups;

  foreach(child in children) {
    if(child.variantname !== # "content_struct" || !isDefined(child.content_key)) {
      continue;
    }

    child.parent = parent;
    function_656a32f0(child);
  }
}

function private function_bedd4c47(children) {
  groups = [];

  foreach(child in children) {
    if(child.variantname != # "content_struct" || !isDefined(child.content_key)) {
      continue;
    }

    if(!isDefined(groups[child.content_key])) {
      groups[child.content_key] = [];
    }

    group = groups[child.content_key];
    group[group.size] = child;
  }

  return groups;
}

function get_children(parent) {
  if(!isDefined(parent.targetname)) {
    return [];
  }

  return struct::get_array(parent.targetname, "target");
}

function private init_devgui() {
  util::waittill_can_add_debug_command();
  adddebugcommand("<dev string:xc6>");
  util::add_devgui(devgui_path("<dev string:xf3>", 0), "<dev string:x108>");

  foreach(destination in level.contentmanager.destinations) {
    foreach(location in destination.locations) {
      foreach(instance in location.instances) {
        instancekey = location.targetname + "<dev string:x131>" + instance.content_script_name;
        path = devgui_path("<dev string:x136>", 1, destination.targetname, location.targetname, instance.content_script_name);
        util::add_devgui(path, "<dev string:x146>" + instancekey);
      }
    }
  }

  foreach(location in level.contentmanager.locations) {
    foreach(instance in location.instances) {
      instancekey = location.targetname + "<dev string:x131>" + instance.content_script_name;
      path = devgui_path("<dev string:x16b>", 2, location.targetname, instance.content_script_name);
      util::add_devgui(path, "<dev string:x146>" + instancekey);
    }
  }

  level thread debug_draw();
  level thread function_b3843ca7();
}

function devgui_path(...) {
  path = "<dev string:x178>";

  foreach(arg in vararg) {
    if(isint(arg)) {
      path += "<dev string:x131>";
    } else {
      path += "<dev string:x192>";
    }

    path += arg;
  }

  return path;
}

function private function_b3843ca7() {
  while(true) {
    setDvar(#"hash_6d5a45dcdc3af9b5", "<dev string:x197>");
    waitframe(1);
    instancekey = getdvarstring(#"hash_6d5a45dcdc3af9b5", "<dev string:x197>");

    if(instancekey == "<dev string:x197>") {
      continue;
    }

    keys = strtok(instancekey, "<dev string:x131>");

    if(keys.size != 2) {
      continue;
    }

    location = level.contentmanager.locations[keys[0]];

    if(!isDefined(location)) {
      continue;
    }

    if(isDefined(location.spawnedinstance)) {
      continue;
    }

    instance = location.instances[keys[1]];

    if(!isDefined(instance)) {
      continue;
    }

    teleport = instance.contentgroups[# "start"][0];

    if(!isDefined(teleport)) {
      teleport = instance;
    }

    getplayers()[0] setorigin(teleport.origin);
    spawn_instance(instance);
  }
}

function private debug_draw() {
  while(true) {
    if(getdvarint(#"hash_55e098bf3549b14d", 0)) {
      foreach(destination in level.contentmanager.destinations) {
        draw_destination(destination);
      }

      foreach(location in level.contentmanager.locations) {
        draw_location(location, location.destination);
      }
    }

    waitframe(1);
  }
}

function draw_destination(destination) {
  draw_struct(destination, (0, 1, 0), undefined, destination.targetname);
}

function draw_location(location, destination) {
  if(!isDefined(destination)) {
    destination = undefined;
  }

  draw_struct(location, (0, 1, 1), destination, location.targetname);

  foreach(instance in location.instances) {
    draw_instance(instance, location);
  }
}

function draw_instance(instance, location) {
  if(!isDefined(location)) {
    location = undefined;
  }

  draw_struct(instance, (0, 0, 1), location);
  function_b2b08c09(instance);
}

function function_b2b08c09(node) {
  if(isarray(node.contentgroups)) {
    foreach(group in node.contentgroups) {
      foreach(child in group) {
        draw_struct(child, (1, 0, 1), node);
        function_b2b08c09(child);
      }
    }
  }
}

function draw_struct(struct, color, parent, extrastr) {
  if(!isDefined(parent)) {
    parent = undefined;
  }

  if(!isDefined(extrastr)) {
    extrastr = undefined;
  }

  debugstr = undefined;
  debugstr = function_4636f4cb(debugstr, struct.variantname);
  debugstr = function_4636f4cb(debugstr, struct.content_script_name);
  debugstr = function_4636f4cb(debugstr, struct.content_key);
  debugstr = function_4636f4cb(debugstr, extrastr);

  if(isDefined(parent)) {
    line(struct.origin, parent.origin, color);
  }

  sphere(struct.origin, 8, color);
  print3d(struct.origin, debugstr);
}

function function_4636f4cb(str, append) {
  if(ishash(append)) {
    append = function_9e72a96(append);
  }

  if(!isDefined(str)) {
    return append;
  } else if(isDefined(append)) {
    return (str + "<dev string:x19b>" + append);
  }

  return str;
}