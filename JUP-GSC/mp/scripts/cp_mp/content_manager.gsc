/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\content_manager.gsc
************************************************/

#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;
#namespace content_manager;

function function_9218617331ba59ff(instance, string) {
  if(isDefined(instance.contentgroups[string])) {
    return instance.contentgroups[string][0];
  }
}

function function_223d2522d69e265d(instance, string) {
  content_array = [];

  if(isDefined(instance.contentgroups[string])) {
    content_array = instance.contentgroups[string];
  }

  return content_array;
}

function function_3e419ffd7ff0650d() {
  flag_init("content_manager_initialized");
  level.contentmanager = spawnStruct();
  level.contentmanager.registeredscripts = [];
  level.contentmanager.scriptcategories = [];
  setup_destinations();
  setup_locations();
  level.contentmanager.spawnedinstances = [];
  flag_set("content_manager_initialized");

  level thread init_devgui();
}

function function_25d8f4a67b2f6fa6() {
  setup_destinations();
  setup_locations();

  level thread init_devgui();
}

function register_script(scriptname, spawncallback, var_76c7d77c9c5c25cb) {
  assert(isstring(scriptname));
  assert(isDefined(spawncallback));
  assertex(!isDefined(level.contentmanager.registeredscripts[scriptname]), scriptname + "<dev string:x1c>");
  script = spawnStruct();
  script.scriptname = scriptname;
  script.spawncallback = spawncallback;
  level.contentmanager.registeredscripts[scriptname] = script;

  if(istrue(var_76c7d77c9c5c25cb)) {
    array_add(level.contentmanager.var_be6410a3e31c071b, scriptname);
  }

  return script;
}

function get_script(scriptname) {
  assert(isstring(scriptname));
  return level.contentmanager.registeredscripts[scriptname];
}

function function_2643181f53446ac4(key, value) {
  assert(isstring(key));

  if(!isDefined(value)) {
    return [];
  }

  scripts = getStructArray(value, key);
  var_2d9173702eb7f54e = [];

  foreach(script in scripts) {
    foreach(var_e5feb06a255e7309 in level.contentmanager.registeredscripts) {
      var_2d9173702eb7f54e[var_2d9173702eb7f54e.size] = var_e5feb06a255e7309;
    }
  }

  return var_2d9173702eb7f54e;
}

function function_1d0ccd8d315db185(destination, content_category) {
  locations = array_randomize(get_children(destination));

  for(i = 0; i < locations.size; i++) {
    if(isDefined(locations[i].variantname) && locations[i].variantname != "content_location") {
      array_remove_index(locations, i, 1);
    }
  }

  array_removeundefined(locations, 1);

  foreach(location in locations) {
    instances = array_randomize(get_children(location));

    foreach(instance in instances) {
      if(isDefined(instance.content_script_name) && instance.content_script_name == content_category) {
        return instance;
      }
    }
  }
}

function setup_destinations() {
  level.contentmanager.destinations = [];

  if(!isDefined(level.struct_class_names["variantname"])) {
    return;
  }

  mapdestinations = getStructArray("content_destination", "variantname");

  foreach(destination in mapdestinations) {
    assert(isDefined(destination.targetname));
    assert(!isDefined(level.contentmanager.destinations[destination.targetname]));
    level.contentmanager.destinations[destination.targetname] = destination;
    function_dcb921c0f1ffc7a2(destination);
    destination.locations = [];
    children = get_children(destination);

    foreach(child in children) {
      if(child.variantname != "content_location") {
        continue;
      }

      assert(isDefined(child.targetname));
      assert(!isDefined(destination.locations[child.targetname]));
      destination.locations[child.targetname] = child;
    }
  }

  level.contentmanager.destinations = array_randomize(level.contentmanager.destinations);
}

function setup_adjacencies(str_destination, var_29d15208128f7711) {
  assert(isDefined(level.contentmanager.destinations[str_destination]), "<dev string:x54>" + str_destination);
  i = 0;

  foreach(var_bb24acdfc3f6728 in var_29d15208128f7711) {
    adjacency = getStruct(var_bb24acdfc3f6728);
    assert(isDefined(adjacency), "<dev string:x83>" + var_bb24acdfc3f6728);
    level.contentmanager.destinations[str_destination].adjacencies[i] = adjacency;
    i++;
  }
}

function function_38c2d8befceaca58(location) {
  assert(isstruct(location));
  assert(location.variantname == "<dev string:xbc>");
  spawned_instances = isarray(location.spawnedinstances) && location.spawnedinstances.size > 0;
  return spawned_instances;
}

function setup_locations() {
  level.contentmanager.locations = [];

  if(!isDefined(level.struct_class_names["variantname"])) {
    return;
  }

  maplocations = getStructArray("content_location", "variantname");

  foreach(location in maplocations) {
    assert(isDefined(location.targetname));
    assert(!isDefined(level.contentmanager.locations[location.targetname]));
    level.contentmanager.locations[location.targetname] = location;

    if(isDefined(location.target)) {
      parent = getStruct(location.target, "targetname");

      if(isDefined(parent) && isDefined(parent.variantname) && parent.variantname == "content_destination") {
        location.destination = parent;
      }
    }

    function_dcb921c0f1ffc7a2(location);
    location.instances = [];
    children = get_children(location);

    foreach(child in children) {
      if(!isDefined(child.variantname) || child.variantname != "content_instance") {
        continue;
      }

      assert(isDefined(child.content_script_name));

      if(!isDefined(location.instances[child.content_script_name])) {
        location.instances[child.content_script_name] = spawnStruct();
        location.instances[child.content_script_name].versions = [];
      }

      location.instances[child.content_script_name].versions = default_to(location.instances[child.content_script_name].versions, []);
      location.instances[child.content_script_name].versions = function_6d6af8144a5131f1(location.instances[child.content_script_name].versions, child);
      child.location = location;
    }
  }
}

function spawn_instance(instance) {
  assert(isstruct(instance));
  assert(instance.variantname == "<dev string:xd0>");
  assert(isstring(instance.content_script_name));
  assert(isstruct(instance.location));
  function_dcb921c0f1ffc7a2(instance);
  script = level.contentmanager.registeredscripts[instance.content_script_name];

  if(isDefined(script.spawncallback)) {
    level thread[[script.spawncallback]](instance);
  }

  function_83373446144cfe7d(instance);
}

function function_200f782ea3757585(instance) {
  assert(isstruct(instance));
  assert(instance.variantname == "<dev string:xd0>");
  assert(isstring(instance.content_script_name));
  assert(isstruct(instance.location));
  return !function_38c2d8befceaca58(instance.location);
}

function function_83373446144cfe7d(instance) {
  assert(isarray(level.contentmanager.spawnedinstances));
  instance.location.spawnedinstances = default_to(instance.location.spawnedinstances, []);
  instance.location.spawnedinstances[instance.location.spawnedinstances.size] = instance;
  spawnedinstances = level.contentmanager.spawnedinstances;
  spawnedinstances[instance.content_script_name] = default_to(spawnedinstances[instance.content_script_name], []);
  spawnedinstances[instance.content_script_name][spawnedinstances[instance.content_script_name].size] = instance;
  level.contentmanager.spawnedinstances = spawnedinstances;
}

function spawn_interact(struct, scriptable_name, usecallback, offset) {
  assert(isstruct(struct));
  assert(isDefined(usecallback));
  offset = default_to(offset, (0, 0, 0));
  interact = spawnscriptable(scriptable_name, struct.origin + offset, struct.angles);
  function_32645103f7520635(interact, usecallback);
  interact interact_show(1);
  return interact;
}

function interact_show(b_show) {
  state_name = "visible";

  if(!b_show) {
    state_name = "hidden";
  }

  self setscriptablepartstate("content_interact", state_name);
}

function function_1ab52e17fab56634() {
  self setscriptablepartstate("content_interact", "inactive");
}

function interact_used(interact, part, state, player, auto_use, use_string) {
  if(!isDefined(interact.var_e9c2e3596843e78)) {
    return;
  }

  interact thread[[interact.var_e9c2e3596843e78]](player);
}

function function_a6df741f1a9b67b1(contentstructs, modelname, var_4056e5ccaf62d67d, pingable) {
  default_to(var_4056e5ccaf62d67d, 0);
  default_to(pingable, 1);
  models = [];

  foreach(struct in contentstructs) {
    model = spawn_script_model(struct, modelname, var_4056e5ccaf62d67d, pingable);
    models[models.size] = model;
  }

  return models;
}

function spawn_script_model(struct, modelname, var_4056e5ccaf62d67d, pingable, var_194ed46ea3828b33) {
  var_4056e5ccaf62d67d = default_to(var_4056e5ccaf62d67d, 0);
  pingable = default_to(pingable, 1);
  var_194ed46ea3828b33 = default_to(var_194ed46ea3828b33, struct.origin);
  model = spawn("script_model", var_194ed46ea3828b33);
  model.angles = default_to(struct.angles, (0, 0, 0));
  model setModel(modelname);

  if(isDefined(struct.targetname)) {
    model.targetname = struct.targetname;
  }

  if(isDefined(struct.script_noteworthy)) {
    model.script_noteworthy = struct.script_noteworthy;
  }

  if(isDefined(struct.script_string)) {
    model.script_string = struct.script_string;
  }

  if(var_4056e5ccaf62d67d) {
    model disconnectPaths();
  }

  if(pingable) {}

  parent = struct;

  while(true) {
    if(isDefined(parent.variantname) && parent.variantname == "content_instance" && isDefined(parent.a)) {
      if(!array_contains(parent.a.models, model)) {
        parent.a.models = array_add(parent.a.models, model);
      }

      break;
    }

    if(!isDefined(parent.target)) {
      break;
    }

    parent = getStruct(parent.target, "targetname");

    if(!isDefined(parent)) {
      break;
    }

    waitframe();
  }

  return model;
}

function spawn_zbarrier(struct, zbarrier_classname, var_52bec72bdd3b32dd) {
  default_to(var_52bec72bdd3b32dd, 0);
  zbarrier = spawn(zbarrier_classname, struct.origin);
  zbarrier.angles = struct.angles;

  if(var_52bec72bdd3b32dd) {
    zbarrier disconnectPaths();
  }

  parent = struct;

  while(true) {
    if(parent.variantname == "content_instance") {
      if(!array_contains(parent.a.models, zbarrier)) {
        parent.a.models = array_add(parent.a.models, zbarrier);
      }

      break;
    }

    parent = getStruct(parent.target);

    if(!isDefined(parent)) {
      break;
    }
  }

  return zbarrier;
}

function cleanup_spawned_instances() {
  level notify("cleanup_spawned_instances");
  var_c2e3697f2eabf2ea = 10;
  models_cleaned = 0;

  foreach(group in level.contentmanager.spawnedinstances) {
    foreach(instance in group) {
      if(isDefined(instance.a_models)) {
        foreach(model in instance.a_models) {
          if(isDefined(model)) {
            if(isDefined(model.trigger)) {
              model.trigger delete();
            }

            if(isDefined(model.var_eb28965081694d6)) {
              if(isDefined(level.var_4108d934ddee914)) {
                [[level.var_4108d934ddee914]](model.var_eb28965081694d6);
              } else {
                objective_delete(model.var_eb28965081694d6);
              }
            }

            if(isDefined(model.objectiveid)) {
              if(isDefined(level.var_4108d934ddee914)) {
                [[level.var_4108d934ddee914]](model.objectiveid);
              } else {
                objective_delete(model.objectiveid);
              }
            }

            model anim_scene_stop();
            model delete();
            models_cleaned += 1;

            if(models_cleaned % var_c2e3697f2eabf2ea == 0) {
              wait 0.05;
            }
          }
        }

        instance.a_models = array_removeundefined(instance.a_models);
      }

      group = array_remove(group, instance);
      instance.location.spawnedinstances = array_remove(instance.location.spawnedinstances, instance);
    }

    group = array_removeundefined(group);
    level.contentmanager.spawnedinstances = array_remove(level.contentmanager.spawnedinstances, group);
  }

  array_removeundefined(level.contentmanager.spawnedinstances);
}

function function_dcb921c0f1ffc7a2(parent) {
  children = get_children(parent);
  contentgroups = function_8133fcadd8a74b66(children);
  parent.contentgroups = contentgroups;

  foreach(child in children) {
    if(!isDefined(child.content_key) || child.variantname != "content_struct") {
      continue;
    }

    child.parent = parent;
    function_dcb921c0f1ffc7a2(child);
  }
}

function function_8133fcadd8a74b66(children) {
  groups = [];

  foreach(child in children) {
    if(!isDefined(child.content_key) || child.variantname != "content_struct") {
      continue;
    }

    groups[child.content_key] = default_to(groups[child.content_key], []);
    groups[child.content_key][groups[child.content_key].size] = child;
  }

  return groups;
}

function get_children(parent) {
  if(!isDefined(parent.targetname)) {
    return [];
  }

  return getStructArray(parent.targetname, "target");
}

function init_devgui() {
  level notify("<dev string:xe4>");
  level endon("<dev string:xe4>");
  wait 0.05;
  adddebugcommand("<dev string:x109>" + "<dev string:x116>" + "<dev string:x134>");
  path = devgui_path("<dev string:x13e>", 0);
  add_devgui(devgui_path("<dev string:x13e>", 0), "<dev string:x153>" + "<dev string:x116>" + "<dev string:x15e>");

  foreach(destination in level.contentmanager.destinations) {
    foreach(location in destination.locations) {
      foreach(instance_type in location.instances) {
        foreach(instance in instance_type.versions) {
          instancekey = location.targetname + "<dev string:x166>" + instance.content_script_name;
          path = devgui_path("<dev string:x16b>", 1, destination.targetname + "<dev string:x17b>" + location.targetname + "<dev string:x17b>" + instance.content_script_name);
          add_devgui(path, "<dev string:x180>" + "<dev string:x188>" + instancekey);
        }
      }
    }
  }

  foreach(location in level.contentmanager.locations) {
    foreach(instance_type in location.instances) {
      foreach(instance in instance_type.versions) {
        instancekey = location.targetname + "<dev string:x166>" + instance.content_script_name;
        path = devgui_path("<dev string:x1a9>", 2, location.targetname + "<dev string:x17b>" + instance.content_script_name);
        add_devgui(path, "<dev string:x180>" + "<dev string:x188>" + instancekey);
      }
    }
  }

  level thread debug_draw();
  level thread function_35cf2e81c8407bf7();
}

function devgui_path(name, pos, str) {
  path = "<dev string:x1b6>";
  path += "<dev string:x17b>" + name + "<dev string:x166>" + pos;

  if(isDefined(str)) {
    path += "<dev string:x17b>" + str;
  }

  return path;
}

function add_devgui(menu_path, commands) {
  cmd = "<dev string:x1d0>" + menu_path + "<dev string:x1e0>" + commands + "<dev string:x1e7>";
  addentrytodevgui(cmd);
}

function addentrytodevgui(command) {
  level thread addentrytodevgui_internal(command);
}

function addentrytodevgui_internal(command) {
  if(!isDefined(command)) {
    return;
  }

  wait 5;

  if(isDefined(game["<dev string:x1ed>"]) && game["<dev string:x1ed>"] == "<dev string:x1f6>") {
    return;
  }

  final_command = "<dev string:x202>";
  toks = strtok(command, "<dev string:x17b>");
  space = "<dev string:x206>";
  num_toks = 0;

  foreach(tok in toks) {
    new_toks = strtok(tok, "<dev string:x206>");
    count = 1;
    size = new_toks.size;

    foreach(new_tok in new_toks) {
      if(count < size) {
        final_command = final_command + new_tok + space;
      } else {
        final_command += new_tok;
      }

      count++;
    }

    num_toks++;

    if(num_toks < toks.size) {
      final_command += "<dev string:x17b>";
    }
  }

  adddebugcommand(final_command);
}

function function_35cf2e81c8407bf7() {
  self notify("<dev string:x20b>");
  self endon("<dev string:x20b>");

  while(true) {
    setDvar(@ "hash_861046be2917f04e", "<dev string:x202>");
    wait 0.05;
    instancekey = getDvar(@ "hash_861046be2917f04e", "<dev string:x202>");

    if(instancekey == "<dev string:x202>") {
      continue;
    }

    keys = strtok(instancekey, "<dev string:x166>");

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

    instance = location.instances.versions[keys[1]];

    if(!isDefined(instance)) {
      continue;
    }

    teleport = function_9218617331ba59ff(instance, "<dev string:x23a>");
    default_to(teleport, instance);
    level.players[0] setOrigin(teleport.origin);
    spawn_instance(instance);
  }
}

function debug_draw() {
  self notify("<dev string:x243>");
  self endon("<dev string:x243>");

  while(true) {
    if(getdvarint(@ "hash_8a58a350fd3df60e", 0)) {
      foreach(destination in level.contentmanager.destinations) {
        draw_destination(destination);
      }

      foreach(location in level.contentmanager.locations) {
        draw_location(location, location.destination);
      }
    }

    wait 0.05;
  }
}

function draw_destination(destination) {
  draw_struct(destination, (0, 1, 0), undefined, destination.targetname);
}

function draw_location(location, destination) {
  draw_struct(location, (0, 1, 1), destination, location.targetname);

  foreach(instance_type in location.instances) {
    foreach(instance in instance_type.versions) {
      draw_instance(instance, location);
    }
  }
}

function draw_instance(instance, location) {
  draw_struct(instance, (0, 0, 1), location);
  function_151de086961dc5d6(instance);
}

function function_151de086961dc5d6(node) {
  if(isarray(node.contentgroups)) {
    foreach(group in node.contentgroups) {
      foreach(child in group) {
        draw_struct(child, (1, 0, 1), node);
        function_151de086961dc5d6(child);
      }
    }
  }
}

function draw_struct(struct, color, parent, extrastr) {
  debugstr = undefined;
  debugstr = function_8d3f50d17aeb1eae(debugstr, struct.variantname);
  debugstr = function_8d3f50d17aeb1eae(debugstr, struct.content_script_name);
  debugstr = function_8d3f50d17aeb1eae(debugstr, struct.content_key);
  debugstr = function_8d3f50d17aeb1eae(debugstr, extrastr);

  if(isDefined(parent)) {
    line(struct.origin, parent.origin, color);
  }

  sphere(struct.origin, 8, color);
  print3d(struct.origin, debugstr);
}

function function_8d3f50d17aeb1eae(str, append) {
  if(!isDefined(str)) {
    return append;
  } else if(isDefined(append)) {
    return (str + "<dev string:x267>" + append);
  }

  return str;
}

# /