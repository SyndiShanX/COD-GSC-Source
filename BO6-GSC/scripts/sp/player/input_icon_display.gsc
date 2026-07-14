/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\input_icon_display.gsc
****************************************************/

#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace input_icon_display;

function private autoexec __init__system__() {
  system::register(#"input_icon_display", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_f049b5e95e64f3e9();
}

function private function_f049b5e95e64f3e9() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_init("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  var_8a2f124dbff18c9b = hud_management::function_a1a13273e72bfe46("?\x11\x94g\xf8\x1b\x9f~_\x82;G\x7f\x17H'4\xdas9\xb5QK\x818\xce\x1e.\x13cx\xbd\xa8\x96");

  if(isDefined(var_8a2f124dbff18c9b)) {
    level.var_eb246fce2d61278f = spawnStruct();
    level.var_eb246fce2d61278f.container_widget = var_8a2f124dbff18c9b;
    level.var_eb246fce2d61278f.var_d3725c3f9b3b7387 = hud_management::function_a6d447d45572370d(var_8a2f124dbff18c9b, "\xd5\x1d\x01c\\\xed\xdd\x84\x9c\xe5", "\x91\xca\xcc\v\xab\xd8:");
    level.var_eb246fce2d61278f.alignment = "\x14#\x01\x89\f\x81";
    level.var_eb246fce2d61278f.isplayerhudprompt = 1;
    level.var_eb246fce2d61278f.omnvars = [];
    var_9729ee0c534cc927 = hud_management::function_2d30d3e4449a6631(var_8a2f124dbff18c9b, "\xd5\x1d\x01c\\\xed\xdd\x84\x9c\xe5", "\x91\xca\xcc\v\xab\xd8:");

    foreach(ref, omnvar_data in var_9729ee0c534cc927) {
      level.var_eb246fce2d61278f.omnvars[ref] = omnvar_data;
    }

    level.var_eb246fce2d61278f.widget_types = [];
    misc_data = hud_management::function_746f27d6042f857d(var_8a2f124dbff18c9b, "\xd5\x1d\x01c\\\xed\xdd\x84\x9c\xe5");

    foreach(data in misc_data) {
      level.var_eb246fce2d61278f.widget_types[tolower(ref)] = data.index + 1;
    }
  }

  level utility::flag_set("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");
}

function function_ea6b1181ae6d7cf4(isplayerhudprompt) {
  level utility::flag_wait("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");
  level.var_eb246fce2d61278f.isplayerhudprompt = isplayerhudprompt;

  if(isPlayer(self) && hud_management::function_48c98ea9a4f0da89("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f")) {
    hud_management::function_d3b457baa69dec73("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", "p\xa2Y\x03\x06\x97\xb5\xff\xac\xc0\x82\xadn3\x86u\x01\xb5", isplayerhudprompt);
  }
}

function set_position(x_pos, y_pos, horz_anchor, vert_anchor, var_ffb4c7f1639c871d) {
  level utility::flag_wait("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");
  level.var_eb246fce2d61278f.position = {
    #var_ffb4c7f1639c871d: var_ffb4c7f1639c871d, #vert_anchor: vert_anchor, #horz_anchor: horz_anchor, #y_pos: y_pos, #x_pos: x_pos
  };

  if(isPlayer(self) && hud_management::function_48c98ea9a4f0da89("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f")) {
    hud_management::function_85d8a0ba2e35b6f2("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", x_pos, y_pos, horz_anchor, vert_anchor, var_ffb4c7f1639c871d);
  }
}

function set_alignment(alignment) {
  level utility::flag_wait("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");
  level.var_eb246fce2d61278f.alignment = alignment;

  if(isPlayer(self) && hud_management::function_48c98ea9a4f0da89("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f")) {
    hud_management::function_d8d634ceece460("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", alignment);
  }
}

function private function_e74f805ee87f69cc(desired_index) {
  foundindex = 0;

  if(isDefined(desired_index)) {
    for(i = 0; i < self.var_eb246fce2d61278f.available_indices.size; i++) {
      if(self.var_eb246fce2d61278f.available_indices[i] == desired_index) {
        foundindex = i;
      }
    }
  }

  retval = self.var_eb246fce2d61278f.available_indices[foundindex];
  self.var_eb246fce2d61278f.available_indices = utility::array_remove_index(self.var_eb246fce2d61278f.available_indices, foundindex);
  return retval;
}

function private function_8c5e0d5d40cc9de5(ref, desired_index) {
  if(!isDefined(self.var_eb246fce2d61278f)) {
    self.var_eb246fce2d61278f = {};
  }

  if(!isDefined(self.var_eb246fce2d61278f.available_indices)) {
    self.var_eb246fce2d61278f.available_indices = [];

    for(i = 0; i < level.var_eb246fce2d61278f.var_d3725c3f9b3b7387; i++) {
      self.var_eb246fce2d61278f.available_indices[i] = i + 1;
    }
  }

  assert(self.var_eb246fce2d61278f.available_indices.size);

  if(!isDefined(self.var_eb246fce2d61278f.active_refs)) {
    self.var_eb246fce2d61278f.active_refs = [];
  }

  if(self.var_eb246fce2d61278f.available_indices.size > 0) {
    assert(!isDefined(self.var_eb246fce2d61278f.active_refs[ref]));
    self.var_eb246fce2d61278f.active_refs[ref] = function_e74f805ee87f69cc(desired_index);
    function_9fdf9825ce4b88ef(self.var_eb246fce2d61278f.active_refs[ref]);
  }
}

function private function_96801c0d77f6a4d2(ref) {
  if(isDefined(self.var_eb246fce2d61278f.active_refs[ref])) {
    index = self.var_eb246fce2d61278f.active_refs[ref];
    self.var_eb246fce2d61278f.available_indices[self.var_eb246fce2d61278f.available_indices.size] = index;
    self.var_eb246fce2d61278f.active_refs[ref] = undefined;
    return index;
  }
}

function private function_5747b3cb415b5519(ref, omnvar_ref) {
  omnvar_data = level.var_eb246fce2d61278f.omnvars[omnvar_ref];
  return self getclientomnvar(omnvar_data.name + "w" + self.var_eb246fce2d61278f.active_refs[ref]);
}

function private function_e7700150c608b23d(ref, omnvar_ref, value) {
  omnvar_data = level.var_eb246fce2d61278f.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_eb246fce2d61278f.active_refs[ref], value);
}

function private function_d9252d0264f23428(ref, omnvar_ref) {
  omnvar_data = level.var_eb246fce2d61278f.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_eb246fce2d61278f.active_refs[ref], omnvar_data.default_value);
}

function private function_9fdf9825ce4b88ef(index) {
  foreach(omnvar_data in level.var_eb246fce2d61278f.omnvars) {
    if(ref != #"force_update") {
      self setclientomnvar(omnvar_data.name + "w" + index, omnvar_data.default_value);
    }
  }
}

function function_6f8b5ca6e794e649(ref, image) {
  if(!(isDefined(ref) && isDefined(image))) {
    assertmsg("<dev string:x24>");
  }

  image_index = function_f09d9c82acaea5a4(image);
  assert(isDefined(image_index), "<dev string:x6f>" + image + "<dev string:x7a>" + image + "<dev string:xb0>");
  function_e7700150c608b23d(ref, #"image", image_index);
}

function function_7c9ff06651218181(ref, var_b4abfca89641f973, image, desired_index = undefined, widget_type = "\x1b\xcf\xb6\xde\xb1s\xb7\xca\x04\xdcg#\xdd#", show_progress = 0, enable_notify) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("_\x83\xcc\x8d\xa7\x9d`\x1e\x86\xa1\xc5\xa8[\x16j\x9f\xa7\x1f$b\x1c\x15\x13uK\xc9\xb6\x8f\x01\x01");

  if(!(isDefined(image) && isDefined(var_b4abfca89641f973) && isDefined(ref) && isDefined(level.var_eb246fce2d61278f.widget_types[widget_type]))) {
    assertmsg("<dev string:xf4>" + level.var_eb246fce2d61278f.container_widget + "<dev string:x1af>" + widget_type + "<dev string:x1b8>");
  }

  if(!isDefined(level.var_eb246fce2d61278f) || isDefined(self.var_eb246fce2d61278f.active_refs[ref])) {
    return;
  }

  string_index = function_30e4f86dded0873(var_b4abfca89641f973);

  if(!isDefined(string_index)) {
    return;
  }

  if(!hud_management::function_48c98ea9a4f0da89("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f")) {
    hud_management::function_35924dfcb78711f4("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", level.var_eb246fce2d61278f.container_widget);
    hud_management::function_d8d634ceece460("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", level.var_eb246fce2d61278f.alignment);

    if(isDefined(level.var_eb246fce2d61278f.position)) {
      hud_management::function_85d8a0ba2e35b6f2("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", level.var_eb246fce2d61278f.position.x_pos, level.var_eb246fce2d61278f.position.y_pos, level.var_eb246fce2d61278f.position.horz_anchor, level.var_eb246fce2d61278f.position.vert_anchor, level.var_eb246fce2d61278f.position.use_safearea);
    }

    if(istrue(level.var_eb246fce2d61278f.isplayerhudprompt)) {
      hud_management::function_d3b457baa69dec73("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f", "p\xa2Y\x03\x06\x97\xb5\xff\xac\xc0\x82\xadn3\x86u\x01\xb5", 1);
      self notify("\xdc3\x94\v\xbd^\x98[\x18\xd9}\x88S\x1a\x81\xda");
    }
  }

  function_8c5e0d5d40cc9de5(ref, desired_index);
  function_e7700150c608b23d(ref, #"widget_type_index", level.var_eb246fce2d61278f.widget_types[widget_type]);
  function_e7700150c608b23d(ref, #"text", string_index);
  function_6f8b5ca6e794e649(ref, image);

  if(istrue(show_progress)) {
    function_e7700150c608b23d(ref, #"show_progress", show_progress);
  }

  function_e7700150c608b23d(ref, #"force_update", !function_5747b3cb415b5519(ref, #"force_update"));

  if(isDefined(enable_notify)) {
    thread function_cc351af92395f334(ref, enable_notify);
  }
}

function function_cc69dd0a921096d5(ref, fill_time, fill_percent, var_2dd4d85d381cd4ea) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  fill_time = int(fill_time * 1000);
  function_e7700150c608b23d(ref, #"fill_time", fill_time);
  function_e7700150c608b23d(ref, #"fill_percent", istrue(var_2dd4d85d381cd4ea) ? 1 : fill_percent ?? 0);
  function_e7700150c608b23d(ref, #"hash_ae8de5071cc4517f", istrue(var_2dd4d85d381cd4ea));
}

function function_d344c39b29cc4f92(ref, holdtime) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  holdtime = int(holdtime * 1000);
  function_e7700150c608b23d(ref, #"fill_time", holdtime);
}

function function_e0cc09f56b8497bd(ref, omnvar_ref, value) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));

  if(!isxhash(omnvar_ref)) {
    omnvar_ref = getxhash(omnvar_ref);
  }

  function_e7700150c608b23d(ref, omnvar_ref, value);
}

function function_85f8b957b53e6cba(ref) {
  if(!isDefined(level.var_eb246fce2d61278f) || !function_3c1502b13c02a127(ref)) {
    return;
  }

  function_e7700150c608b23d(ref, #"widget_type_index", 0);
  function_96801c0d77f6a4d2(ref);

  if(self.var_eb246fce2d61278f.active_refs.size == 0) {
    hud_management::scripted_widget_destroy("\x92\x02c\xfb\xe1Q\xdeA%z\x03\x03f");
  }

  self notify("K#\xf1T\\\x14-NH#\x14l\xd4R!\xc4M7\x14" + ref);
}

function show_reminder(ref, var_712d39a13dfab970 = undefined) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xfb!\xde\xf7\xfbB~\x9d\"Nz\x16i>\xb6");

  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"notify", 1);

  if(isDefined(var_712d39a13dfab970)) {
    self waittill(var_712d39a13dfab970);
    hide_reminder(ref);
  }
}

function hide_reminder(ref) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"notify", 0);
  self notify("\xfb!\xde\xf7\xfbB~\x9d\"Nz\x16i>\xb6");
}

function set_disabled(ref) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"disabled", 1);
}

function set_enabled(ref) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"disabled", 0);
}

function force_update(ref) {
  if(!(isDefined(level.var_eb246fce2d61278f) && isDefined(self.var_eb246fce2d61278f))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"force_update", !function_5747b3cb415b5519(ref, #"force_update"));
}

function function_3c1502b13c02a127(ref) {
  return isDefined(ref) && isDefined(self.var_eb246fce2d61278f.active_refs[ref]);
}

function function_cc351af92395f334(ref, enable_notify) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("K#\xf1T\\\x14-NH#\x14l\xd4R!\xc4M7\x14" + ref);

  while(true) {
    self waittill(enable_notify, val);

    if(istrue(val)) {
      set_enabled(ref);
      continue;
    }

    set_disabled(ref);
  }
}