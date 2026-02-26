/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\interactive_map.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\ui\prompts;
#namespace interactive_map;

function private autoexec __init__system__() {
  system::register(#"interactive_map", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "toggle_interactive_map", 1, 1, "int");
}

function open(var_738a6265, top_left, bottom_right, var_879505e1 = 1, var_ff0f9714 = 1, map_x, map_y, map_width, map_height, var_7ec0800f) {
  if(!namespace_61e6d095::exists(#"interactive_map")) {
    player = getplayers()[0];
    player actions::function_6c59e78f(0);
    player thread namespace_61e6d095::block_kbm_pause_menu("close_interactive_map");
    player val::set(#"hash_46ef83540c23a2f7", "freezecontrols", 1);
    namespace_61e6d095::create(#"interactive_map", var_738a6265);
    namespace_61e6d095::function_28027c42(#"interactive_map", [#"interactive_map", #"hint_tutorial", #"hash_72cc4740fa4d3da3"]);
    namespace_61e6d095::function_24e5fa63(#"interactive_map", [#"ui_confirm", #"ui_cancel"], 1);

    if(!isDefined(top_left)) {
      top_left = getent("interactive_map_top_left", "targetname");

      if(!isDefined(top_left)) {
        top_left = struct::get("interactive_map_top_left", "targetname");
      }
    }

    if(!isDefined(bottom_right)) {
      bottom_right = getent("interactive_map_bottom_right", "targetname");

      if(!isDefined(bottom_right)) {
        bottom_right = struct::get("interactive_map_bottom_right", "targetname");
      }
    }

    if(isDefined(map_x)) {
      namespace_61e6d095::set_x(#"interactive_map", map_x);
    }

    if(isDefined(map_y)) {
      namespace_61e6d095::set_y(#"interactive_map", map_y);
    }

    if(isDefined(map_width)) {
      namespace_61e6d095::set_width(#"interactive_map", map_width);
    }

    if(isDefined(map_height)) {
      namespace_61e6d095::set_height(#"interactive_map", map_height);
    }

    if(is_true(var_7ec0800f) && isentity(top_left) && isentity(bottom_right)) {
      namespace_61e6d095::function_9ade1d9b(#"interactive_map", "topLeftEntNum", top_left getentitynumber());
      namespace_61e6d095::function_9ade1d9b(#"interactive_map", "bottomRightEntNum", bottom_right getentitynumber());
    }

    x_axis = anglestoright(top_left.angles) * -1;
    y_axis = anglesToForward(top_left.angles);
    var_2a5cff6e = bottom_right.origin - top_left.origin;
    width = vectordot(var_2a5cff6e, x_axis);
    height = vectordot(var_2a5cff6e, y_axis);

    if(!isDefined(level.interactive_map)) {
      level.interactive_map = {};
    }

    level.interactive_map.dims = {
      #top_left: top_left.origin, #width: width, #height: height, #x_axis: x_axis, #y_axis: y_axis
    };

    if(!isDefined(level.interactive_map.objects)) {
      level.interactive_map.objects = [];
    }

    if(!isDefined(level.interactive_map.hotspots)) {
      level.interactive_map.hotspots = [];
    }

    function_9af7280f(level.interactive_map.objects);
    function_59b2a130(level.interactive_map.hotspots);
    function_9af7280f(getEntArray("interactive_map_object", "script_noteworthy"));
    function_59b2a130(getEntArray("interactive_map_hotspot", "script_noteworthy"));

    if(is_true(var_879505e1)) {
      player function_879505e1(var_ff0f9714);
    }

    return;
  }

  assertmsg("<dev string:x38>");
}

function function_e0cc3b71(name, value) {
  namespace_61e6d095::function_9ade1d9b(#"interactive_map", name, value);
}

function function_879505e1(var_ff0f9714 = 1, var_509b0860 = # "hash_780067c4596705d7", var_74ac68df = # "hash_71f8107215effa5b") {
  assert(namespace_61e6d095::exists(#"interactive_map"), "<dev string:x8f>");
  function_23036faa(#"cursor", "uid", #"cursor");
  function_23036faa(#"cursor", "widgetName", var_509b0860);
  function_23036faa(#"cursor", "cursorImage", var_74ac68df);
  function_23036faa(#"cursor", "rightAligned", 0);
  function_23036faa(#"cursor", "bottomAligned", 0);
  namespace_61e6d095::function_9ade1d9b(#"interactive_map", "cursor" + "." + "update", 1, 1, 0, 0, 1);
  function_41d66375(#"cursor", "descriptionList");
  function_41d66375(#"cursor", "interactionList");
  function_8b43da33();
  function_e4d34e68(0);
  prompts::function_e79f51ec(#"cursor");
  level.interactive_map.var_1cd32747 = (0.5, 0.5, 0);

  if(isDefined(level.interactive_map.var_87c49d20)) {
    cursor_delta = level.interactive_map.var_87c49d20 - level.interactive_map.dims.top_left;
    level.interactive_map.var_1cd32747 = (vectordot(cursor_delta, level.interactive_map.dims.x_axis) / level.interactive_map.dims.width, vectordot(cursor_delta, level.interactive_map.dims.y_axis) / level.interactive_map.dims.height, 0);
  }

  function_23036faa(#"cursor", "x", level.interactive_map.var_1cd32747[0]);
  function_23036faa(#"cursor", "y", level.interactive_map.var_1cd32747[1]);
  self clientfield::set_to_player("toggle_interactive_map", 1);
  thread update_cursor(var_ff0f9714);
}

function function_50121b9(position) {
  if(!isDefined(level.interactive_map)) {
    level.interactive_map = {};
  }

  level.interactive_map.var_87c49d20 = position;
}

function function_9e8d4999(title = # "", descriptions, interactions, object) {
  if(!isDefined(descriptions)) {
    descriptions = [];
  } else if(!isarray(descriptions)) {
    descriptions = array(descriptions);
  }

  if(!isDefined(interactions)) {
    interactions = [];
  } else if(!isarray(interactions)) {
    interactions = array(interactions);
  }

  function_23036faa(#"cursor", "title", title);

  foreach(index, description in descriptions) {
    function_39d12272(#"cursor", index, "text", description, "descriptionList");
  }

  if(isDefined(level.interactive_map.var_2c15274b.descriptions)) {
    for(index = descriptions.size; index < level.interactive_map.var_2c15274b.descriptions.size; index++) {
      function_dcedf7f(#"cursor", index, "descriptionList");
    }
  }

  var_fadf668d = 0;
  player = getplayers()[0];
  player prompts::remove_group(#"cursor");

  foreach(prompt, interaction in interactions) {
    player prompts::function_c97a48c7(prompt, interaction);
    var_fadf668d = 1;
  }

  if(var_fadf668d) {
    player prompts::function_46f198(#"interactive_map", "cursor" + "." + "mapObjects" + "." + # "cursor" + "." + "interactionList");
  }

  level.interactive_map.var_2c15274b = {
    #title: title, #descriptions: descriptions, #interactions: interactions, #object: object
  };
}

function function_e4d34e68(state = 0) {
  function_23036faa(#"cursor", "state", state);
}

function function_8b43da33() {
  function_23036faa(#"cursor", "title", #"");

  if(isDefined(level.interactive_map.var_2c15274b)) {
    foreach(index, description in level.interactive_map.var_2c15274b.descriptions) {
      function_dcedf7f(#"cursor", index, "descriptionList");
    }

    getplayers()[0] prompts::remove_group(#"cursor");
    level.interactive_map.var_2c15274b = undefined;
  }
}

function function_2fb5abd8() {
  level notify(#"hash_546b1fe54ba63887");
  player = getplayers()[0];
  player clientfield::set_to_player("toggle_interactive_map", 0);
  util::wait_network_frame(2);
  player prompts::remove_group(#"cursor");
  function_23036faa(#"cursor", "widgetName", #"");
  namespace_61e6d095::function_9ade1d9b(#"interactive_map", "cursor" + "." + "update", 1, 1, 0, 0, 1);
  namespace_61e6d095::function_43525bc6(#"interactive_map", #"cursor", 1);
  level.interactive_map.var_2c15274b = undefined;
}

function add_object(uid, image = # "uie_map_lubyanka_marker_waypoint", var_6d62c29c, angle_offset, title, scale) {
  if(!isDefined(self.interactive_map)) {
    self.interactive_map = {};
  }

  if(!isDefined(uid)) {
    uid = self.interactive_map.uid;
  }

  if(!isDefined(var_6d62c29c)) {
    var_6d62c29c = self.interactive_map.var_6d62c29c;
  }

  if(!isDefined(angle_offset)) {
    angle_offset = self.interactive_map.angle_offset;
  }

  if(!isDefined(title)) {
    title = self.interactive_map.title;
  }

  if(!isDefined(scale)) {
    scale = self.interactive_map.scale;
  }

  if(!isDefined(uid) && isentity(self)) {
    uid = self getentitynumber();
  }

  if(!isDefined(uid)) {
    return;
  }

  level.interactive_map.objects[uid] = self;

  if(isDefined(self.interactive_map.image) && image == # "uie_map_lubyanka_marker_waypoint") {
    image = self.interactive_map.image;
  }

  self.interactive_map.uid = uid;
  self.interactive_map.image = image;
  self.interactive_map.var_6d62c29c = var_6d62c29c;
  self.interactive_map.angle_offset = angle_offset;
  self.interactive_map.title = title;
  self.interactive_map.scale = scale;

  if(!namespace_61e6d095::exists(#"interactive_map")) {
    return;
  }

  function_db6cb581(uid, #"hash_21fb68e196ffe610");
  function_d0243e5b(uid, "image", image);
  function_d0243e5b(uid, "x", 0.5);
  function_d0243e5b(uid, "y", 0.5);

  if(is_true(var_6d62c29c)) {
    function_d0243e5b(uid, "angle", 0);
  }

  if(isDefined(title)) {
    function_d0243e5b(uid, "title", title);
  }

  if(isDefined(scale)) {
    function_d0243e5b(uid, "scale", scale);
  }

  function_d0243e5b(uid, "flags", 0);
  function_d0243e5b(uid, "state", 0);

  if(isDefined(self.var_62d718e2)) {
    foreach(var_55633c65 in self.var_62d718e2) {
      function_d0243e5b(uid, var_55633c65.name, var_55633c65.cur_value);
    }
  }

  self thread function_9dfe141f(uid, var_6d62c29c, angle_offset);
}

function function_d76aae9f(uid, state) {
  if(isDefined(level.interactive_map.objects[uid])) {
    function_d0243e5b(uid, "state", state);
  }
}

function function_c8d8772e(uid, flags) {
  if(isDefined(level.interactive_map.objects[uid])) {
    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    var_c2e076fc = 0;

    foreach(flag in flags) {
      var_c2e076fc |= 1 << flag;
    }

    var_b89f8baa = function_dbf83dc4(uid, "flags");

    if(isDefined(var_b89f8baa)) {
      var_c2e076fc |= var_b89f8baa;
    }

    function_d0243e5b(uid, "flags", var_c2e076fc);
  }
}

function function_cc611397(uid, flags) {
  if(isDefined(level.interactive_map.objects[uid])) {
    var_c2e076fc = 0;
    var_b89f8baa = isDefined(function_dbf83dc4(uid, "flags")) ? function_dbf83dc4(uid, "flags") : 0;
    var_c2e076fc = var_b89f8baa;

    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    foreach(flag in flags) {
      var_c2e076fc &= ~(1 << flag);
    }
  }
}

function remove_object(uid) {
  if(isDefined(level.interactive_map.objects[uid])) {
    level.interactive_map.objects[uid] notify(#"hash_7c1f9e1214f47b4e");

    if(namespace_61e6d095::exists(#"interactive_map")) {
      function_455d4424(uid);
    }

    arrayremoveindex(level.interactive_map.objects, uid, 1);
  }
}

function function_87f0056b() {
  if(namespace_61e6d095::exists(#"interactive_map")) {
    foreach(uid, object in level.interactive_map.objects) {
      level.interactive_map.objects[uid] notify(#"hash_7c1f9e1214f47b4e");
      function_455d4424(uid);
    }
  }

  if(isDefined(level.interactive_map.objects)) {
    level.interactive_map.objects = [];
  }
}

function function_d0243e5b(uid, name, value) {
  namespace_61e6d095::set_data(#"interactive_map", "mapObjects" + "." + uid + "." + name, value);
}

function function_dbf83dc4(uid, name) {
  namespace_61e6d095::get_data(#"interactive_map", "mapObjects" + "." + uid + "." + name);
}

function function_68ec091e(uid, scale) {
  function_d0243e5b(uid, "scale", scale);
}

function function_23036faa(uid, name, value) {
  namespace_61e6d095::function_9ade1d9b(#"interactive_map", "cursor." + "mapObjects" + "." + uid + "." + name, value);
}

function function_fce63823(uid, name) {
  return namespace_61e6d095::function_f7c4c669(#"interactive_map", "cursor." + "mapObjects" + "." + uid + "." + name);
}

function function_835fb58e(scale) {
  function_23036faa(#"cursor", "scale", scale);
}

function function_41d66375(uid, list_name) {
  namespace_61e6d095::function_330981ed(#"interactive_map", "cursor." + "mapObjects" + "." + uid + "." + list_name);
}

function function_39d12272(uid, index, name, value, list_name) {
  namespace_61e6d095::function_f2a9266(#"interactive_map", index, name, value, "cursor." + "mapObjects" + "." + uid + "." + list_name);
}

function function_dcedf7f(uid, index, list_name) {
  namespace_61e6d095::function_7239e030(#"interactive_map", index, "cursor." + "mapObjects" + "." + uid + "." + list_name);
}

function function_7793b318(uid, index, list_name) {
  return namespace_61e6d095::function_cd59371c(uid, index, "cursor." + "mapObjects" + "." + uid + "." + list_name);
}

function function_9af7280f(objects) {
  foreach(uid, object in objects) {
    if(ishash(uid)) {
      object add_object(uid);
      continue;
    }

    object add_object();
  }
}

function function_6385c805() {
  array::add(level.interactive_map.hotspots, self, 0);
  map_pos = self.origin - level.interactive_map.dims.top_left;
  self.var_2ac0bdff = (vectordot(map_pos, level.interactive_map.dims.x_axis) / level.interactive_map.dims.width, vectordot(map_pos, level.interactive_map.dims.y_axis) / level.interactive_map.dims.height, 0);

  if(namespace_61e6d095::exists(#"interactive_map") && isDefined(self.var_62d718e2)) {
    foreach(var_55633c65 in self.var_62d718e2) {
      function_e0cc3b71(var_55633c65.name, var_55633c65.cur_value);
    }
  }
}

function function_59b2a130(triggers) {
  foreach(trigger in triggers) {
    trigger function_6385c805();
  }
}

function function_5a9ea417() {
  arrayremovevalue(level.interactive_map.hotspots, self);
}

function function_b2ece0a3() {
  if(isDefined(level.interactive_map.hotspots)) {
    level.interactive_map.hotspots = [];
  }
}

function function_9bc3d847(event, name, value, cur_value) {
  if(!isDefined(self.var_62d718e2)) {
    self.var_62d718e2 = [];
  } else if(!isarray(self.var_62d718e2)) {
    self.var_62d718e2 = array(self.var_62d718e2);
  }

  self.var_62d718e2[event] = {
    #name: name, #value: value, #cur_value: cur_value
  };
}

function function_4692570b(event, value) {
  if(isDefined(self.var_62d718e2[event])) {
    self.var_62d718e2[event].cur_value = value;

    if(namespace_61e6d095::exists(#"interactive_map")) {
      if(isDefined(self.interactive_map.uid)) {
        function_d0243e5b(self.interactive_map.uid, self.var_62d718e2[event].name, self.var_62d718e2[event].cur_value);
        return;
      }

      function_e0cc3b71(self.var_62d718e2[event].name, self.var_62d718e2[event].cur_value);
    }
  }
}

function function_bd9c894c(description) {
  if(!isDefined(self.var_94ca2a30)) {
    self.var_94ca2a30 = [];
  } else if(!isarray(self.var_94ca2a30)) {
    self.var_94ca2a30 = array(self.var_94ca2a30);
  }

  self.var_94ca2a30[self.var_94ca2a30.size] = description;
}

function function_e2b5e638(description) {
  if(isDefined(self.var_94ca2a30)) {
    arrayremovevalue(self.var_94ca2a30, description, 0);
  }
}

function function_b5c2702b(prompt, prompt_struct) {
  prompt_struct = structcopy(prompt_struct);

  if(!isDefined(prompt_struct.groups)) {
    prompt_struct.groups = [];
  } else if(!isarray(prompt_struct.groups)) {
    prompt_struct.groups = array(prompt_struct.groups);
  }

  if(!isinarray(prompt_struct.groups, #"cursor")) {
    prompt_struct.groups[prompt_struct.groups.size] = # "cursor";
  }

  if(!isDefined(self.var_174e0272)) {
    self.var_174e0272 = [];
  } else if(!isarray(self.var_174e0272)) {
    self.var_174e0272 = array(self.var_174e0272);
  }

  prompt_struct.var_1df3804c = self;
  self.var_174e0272[prompt] = prompt_struct;
}

function function_4b1a5235(prompt) {
  if(isDefined(self.var_174e0272)) {
    arrayremoveindex(self.var_174e0272, prompt, 1);
  }
}

function close(cleanup) {
  level notify(#"close_interactive_map");
  player = getplayers()[0];
  player notify(#"close_interactive_map");
  player clientfield::set_to_player("toggle_interactive_map", 0);
  util::wait_network_frame(2);
  player prompts::remove_group(#"cursor");
  prompts::function_398ab9eb();
  namespace_61e6d095::function_9ade1d9b(#"interactive_map", "cursor.update", 0, 1);
  namespace_61e6d095::set_data(#"interactive_map", "update", 0, 1);
  namespace_61e6d095::remove(#"interactive_map");
  namespace_61e6d095::function_4279fd02(#"interactive_map");

  if(is_true(cleanup)) {
    level.interactive_map = undefined;
  } else {
    level.interactive_map.dims = undefined;
  }

  player val::reset(#"hash_46ef83540c23a2f7", "freezecontrols");
  player actions::function_6c59e78f(1);
}

function function_fabe437a(prompt_struct) {
  waypoint = level.interactive_map.var_2c15274b.object;

  if(isDefined(waypoint.target)) {
    if(isstring(waypoint.target)) {
      if(isDefined(getent(waypoint.target, "targetname"))) {
        waypoint = getent(waypoint.target, "targetname");
      } else if(isDefined(struct::get(waypoint.target, "targetname"))) {
        waypoint = struct::get(waypoint.target, "targetname");
      }
    } else if(isstruct(waypoint.target) || isentity(waypoint.target)) {
      waypoint = waypoint.target;
    }
  }

  objectives::remove(#"map_waypoint");

  if(level.interactive_map.objects[#"map_waypoint"] === waypoint) {
    remove_object(#"map_waypoint");
    return;
  }

  objectives::goto(#"map_waypoint", waypoint.origin, undefined, 0, 0);

  if(isDefined(self.var_d9b5c896)) {
    thread objectives_ui::function_49dec5b(#"map_waypoint", undefined, self.var_d9b5c896);
  }

  if(isDefined(level.interactive_map.objects[#"map_waypoint"])) {
    level.interactive_map.objects[#"map_waypoint"] notify(#"hash_7c1f9e1214f47b4e");
    level.interactive_map.objects[#"map_waypoint"] = waypoint;
    waypoint thread function_9dfe141f(#"map_waypoint");
    function_d0243e5b(#"map_waypoint", "image", isDefined(waypoint.interactive_map.image) ? waypoint.interactive_map.image : # "uie_map_lubyanka_marker_waypoint");
  } else {
    waypoint add_object(#"map_waypoint", isDefined(waypoint.interactive_map.image) ? waypoint.interactive_map.image : # "uie_map_lubyanka_marker_waypoint", 0);
  }

  thread function_5cab7397();
  prompt_struct.player thread objectives_ui::show_objectives();
}

function private function_5cab7397() {
  level notify("f61ea4c2cf8a773");
  level endon(#"close_interactive_map", "6c5260e220bebf4", #"hash_64a3b02565bdf75f");
  level waittill(#"hash_5644658da7c85062");
  objectives::remove(#"map_waypoint");
  remove_object(#"map_waypoint");
}

function private function_db6cb581(uid, widget_name = # "hash_21fb68e196ffe610") {
  function_d0243e5b(uid, "uid", uid);
  function_d0243e5b(uid, "widgetName", widget_name);
  thread function_fa8087e3();
}

function private function_455d4424(uid) {
  if(level.interactive_map.cursor_object === self || level.interactive_map.var_1896103a === self) {
    level.interactive_map.cursor_object = undefined;
    level.interactive_map.var_1896103a = undefined;
    function_8b43da33();
  }

  function_d0243e5b(uid, "widgetName", #"");
  namespace_61e6d095::clear_data(#"interactive_map", "mapObjects" + "." + uid, 1);
  thread function_fa8087e3();
}

function private function_9dfe141f(uid, var_6d62c29c, angle_offset = 0) {
  level endon(#"close_interactive_map", #"hash_64a3b02565bdf75f");
  self endon(#"death", #"hash_7c1f9e1214f47b4e");
  self thread function_8e91c74c(uid);

  while(true) {
    pos = self.origin;
    angles = self.angles;

    if(isentity(self)) {
      pos += rotatepoint(self getboundsmidpoint(), angles);
    }

    map_pos = pos - level.interactive_map.dims.top_left;
    self.var_2ac0bdff = (vectordot(map_pos, level.interactive_map.dims.x_axis) / level.interactive_map.dims.width, vectordot(map_pos, level.interactive_map.dims.y_axis) / level.interactive_map.dims.height, 0);
    function_d0243e5b(uid, "x", self.var_2ac0bdff[0]);
    function_d0243e5b(uid, "y", self.var_2ac0bdff[1]);

    if(is_true(var_6d62c29c)) {
      function_d0243e5b(uid, "angle", angles[1] + angle_offset);
    }

    waitframe(1);
  }
}

function private function_8e91c74c(uid) {
  level endon(#"close_interactive_map", #"hash_64a3b02565bdf75f");
  self endon(#"hash_7c1f9e1214f47b4e");
  self waittill(#"death");
  thread remove_object(uid);
}

function private update_cursor(var_ff0f9714) {
  level endon(#"hash_546b1fe54ba63887", #"close_interactive_map", #"hash_64a3b02565bdf75f");
  player = getplayers()[0];
  player endon(#"death");
  level.interactive_map.cursor_object = undefined;
  level.interactive_map.var_1896103a = undefined;
  cursor_object = undefined;

  while(true) {
    if(namespace_61e6d095::should_hide(#"interactive_map")) {
      waitframe(1);
      continue;
    }

    x = function_fce63823(#"cursor", "x");
    y = function_fce63823(#"cursor", "y");
    level.interactive_map.var_1cd32747 = (isDefined(x) ? x : 0.5, isDefined(y) ? y : 0.5, 0);
    level.interactive_map.var_87c49d20 = level.interactive_map.dims.top_left + level.interactive_map.var_1cd32747[0] * level.interactive_map.dims.width * level.interactive_map.dims.x_axis + level.interactive_map.var_1cd32747[1] * level.interactive_map.dims.height * level.interactive_map.dims.y_axis;
    function_c9099483();
    function_393ad031();
    waitframe(1);
  }
}

function private function_c9099483() {
  if(isDefined(level.interactive_map.cursor_object) && !function_3fe61dc2(level.interactive_map.cursor_object)) {
    thread cursor_off(level.interactive_map.cursor_object);
    level.interactive_map.cursor_object = undefined;
    return;
  }

  if(!isDefined(level.interactive_map.cursor_object)) {
    foreach(object in level.interactive_map.objects) {
      if(function_3fe61dc2(object)) {
        thread cursor_on(object);
        level.interactive_map.cursor_object = object;
        break;
      }
    }
  }
}

function private function_3fe61dc2(object) {
  if(isDefined(object.var_2ac0bdff)) {
    delta = object.var_2ac0bdff - level.interactive_map.var_1cd32747;
    scale = isDefined(function_dbf83dc4(object.interactive_map.uid, "scale")) ? function_dbf83dc4(object.interactive_map.uid, "scale") : 1;

    if(abs(delta[0]) < 0.04 * scale && abs(delta[1]) < 0.04 * scale) {
      return true;
    }
  }

  return false;
}

function private function_393ad031() {
  if(isDefined(level.interactive_map.var_1896103a) && !function_4c186262(level.interactive_map.var_1896103a)) {
    thread cursor_off(level.interactive_map.var_1896103a);
    level.interactive_map.var_1896103a = undefined;
    return;
  }

  foreach(hotspot in level.interactive_map.hotspots) {
    if(hotspot !== level.interactive_map.var_1896103a && function_4c186262(hotspot)) {
      thread cursor_on(hotspot);
      level.interactive_map.var_1896103a = hotspot;
      break;
    }
  }
}

function private function_4c186262(hotspot) {
  return istouching(level.interactive_map.var_87c49d20, hotspot);
}

function private cursor_on(object) {
  object notify(#"hash_36f946ec36b9e18f");

  if(isDefined(object.var_f90e2591)) {
    object thread[[object.var_f90e2591]]();
  }

  if(isDefined(object.var_62d718e2[#"cursor_on"])) {
    object.var_62d718e2[#"cursor_on"].cur_value = object.var_62d718e2[#"cursor_on"].value;

    if(isDefined(object.interactive_map.uid)) {
      function_d0243e5b(object.interactive_map.uid, object.var_62d718e2[#"cursor_on"].name, object.var_62d718e2[#"cursor_on"].cur_value);
    } else {
      function_e0cc3b71(object.var_62d718e2[#"cursor_on"].name, object.var_62d718e2[#"cursor_on"].cur_value);
    }
  }

  if(function_a246a802(object)) {
    function_23036faa(#"cursor", "rightAligned", object.var_2ac0bdff[0] < 0.5);
    function_23036faa(#"cursor", "bottomAligned", object.var_2ac0bdff[1] < 0.5);
    function_e4d34e68(1);
    function_9e8d4999(object.var_d9b5c896, object.var_94ca2a30, object.var_174e0272, object);
  }
}

function private cursor_off(object) {
  object notify(#"hash_c1b6fc0fc30a88a");

  if(isDefined(object.var_938b0e9b)) {
    object thread[[object.var_938b0e9b]]();
  }

  if(isDefined(object.var_62d718e2[#"cursor_off"])) {
    object.var_62d718e2[#"cursor_off"].cur_value = object.var_62d718e2[#"cursor_off"].value;

    if(isDefined(object.interactive_map.uid)) {
      function_d0243e5b(object.interactive_map.uid, object.var_62d718e2[#"cursor_off"].name, object.var_62d718e2[#"cursor_off"].cur_value);
    } else {
      function_e0cc3b71(object.var_62d718e2[#"cursor_off"].name, object.var_62d718e2[#"cursor_off"].cur_value);
    }
  }

  if(level.interactive_map.var_2c15274b.object === object) {
    var_240f71c = object === level.interactive_map.var_1896103a;
    var_6d991c4e = level.interactive_map.var_1896103a;

    if(var_240f71c) {
      var_6d991c4e = level.interactive_map.cursor_object;
    }

    if(function_a246a802(object) && !function_a246a802(var_6d991c4e)) {
      function_e4d34e68(0);
      function_8b43da33();
      return;
    }

    if(function_a246a802(object) && function_a246a802(var_6d991c4e)) {
      function_9e8d4999(var_6d991c4e.var_d9b5c896, var_6d991c4e.var_94ca2a30, var_6d991c4e.var_174e0272, var_6d991c4e);
    }
  }
}

function private function_a246a802(object) {
  return isDefined(object.var_d9b5c896) || isDefined(object.var_94ca2a30) || isDefined(object.var_174e0272);
}

function private function_fa8087e3() {
  namespace_61e6d095::set_data(#"interactive_map", "update", 1, 1, 0, 0, 1);
}