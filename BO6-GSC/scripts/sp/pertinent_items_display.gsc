/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\pertinent_items_display.gsc
**************************************************/

#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace pertinent_items_display;

function private autoexec __init__system__() {
  system::register(#"pertinent_items_display", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_f049b5e95e64f3e9();
}

function private function_f049b5e95e64f3e9() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_init("|\v\xceYv\x8fi\xd2\xab\"\xea\xe0\x93p\x81+\xa4\xe7\x8e\xa0\xcd\xade\xb6\x15s\x01\"\xb7\x03/z\x83_");
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  var_ce637f1e0f1dcd8e = hud_management::function_a1a13273e72bfe46("\xcdl\xe4Z8\x8e\xac#\xebw\xd2\xc8\xd9\x95\x8e}8\xb2r\x8ei7\xb2s:}\xb4\xe8\x95\xb5\xe6\xf5\x19-\xcd8\xd8\x85\xcb");

  if(isDefined(var_ce637f1e0f1dcd8e)) {
    level.var_3023a65b8d5e0cb6 = {};
    level.var_3023a65b8d5e0cb6.container_widget = var_ce637f1e0f1dcd8e;
    level.var_3023a65b8d5e0cb6.var_d3725c3f9b3b7387 = hud_management::function_a6d447d45572370d(var_ce637f1e0f1dcd8e, "\\.\x97s\x84|#\f{\xb9\xbd\x1a\xf0\xae", "\x91\xca\xcc\v\xab\xd8:");
    level.var_3023a65b8d5e0cb6.alignment = "=\xff0b";
    level.var_3023a65b8d5e0cb6.omnvars = [];
    var_9729ee0c534cc927 = hud_management::function_2d30d3e4449a6631(var_ce637f1e0f1dcd8e, "\\.\x97s\x84|#\f{\xb9\xbd\x1a\xf0\xae", "\x91\xca\xcc\v\xab\xd8:");

    foreach(ref, omnvar_data in var_9729ee0c534cc927) {
      level.var_3023a65b8d5e0cb6.omnvars[ref] = omnvar_data;
    }

    level.var_3023a65b8d5e0cb6.widget_types = [];
    misc_data = hud_management::function_746f27d6042f857d(var_ce637f1e0f1dcd8e, "\\.\x97s\x84|#\f{\xb9\xbd\x1a\xf0\xae");

    foreach(data in misc_data) {
      level.var_3023a65b8d5e0cb6.widget_types[tolower(ref)] = data.index + 1;
    }
  }

  level utility::flag_set("|\v\xceYv\x8fi\xd2\xab\"\xea\xe0\x93p\x81+\xa4\xe7\x8e\xa0\xcd\xade\xb6\x15s\x01\"\xb7\x03/z\x83_");
}

function set_position(x_pos, y_pos, horz_anchor, vert_anchor, var_ffb4c7f1639c871d) {
  level utility::flag_wait("|\v\xceYv\x8fi\xd2\xab\"\xea\xe0\x93p\x81+\xa4\xe7\x8e\xa0\xcd\xade\xb6\x15s\x01\"\xb7\x03/z\x83_");
  level.var_eb246fce2d61278f.position = {
    #var_ffb4c7f1639c871d: var_ffb4c7f1639c871d, #vert_anchor: vert_anchor, #horz_anchor: horz_anchor, #y_pos: y_pos, #x_pos: x_pos
  };

  if(isPlayer(self) && hud_management::function_48c98ea9a4f0da89("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc")) {
    hud_management::function_85d8a0ba2e35b6f2("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc", x_pos, y_pos, horz_anchor, vert_anchor, var_ffb4c7f1639c871d);
  }
}

function set_alignment(alignment) {
  level utility::flag_wait("|\v\xceYv\x8fi\xd2\xab\"\xea\xe0\x93p\x81+\xa4\xe7\x8e\xa0\xcd\xade\xb6\x15s\x01\"\xb7\x03/z\x83_");
  level.var_eb246fce2d61278f.alignment = alignment;

  if(isPlayer(self) && hud_management::function_48c98ea9a4f0da89("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc")) {
    hud_management::function_d8d634ceece460("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc", alignment);
  }
}

function private function_e74f805ee87f69cc(desired_index) {
  foundindex = 0;

  if(isDefined(desired_index)) {
    for(i = 0; i < self.var_3023a65b8d5e0cb6.available_indices.size; i++) {
      if(self.var_3023a65b8d5e0cb6.available_indices[i] == desired_index) {
        foundindex = i;
      }
    }
  }

  retval = self.var_3023a65b8d5e0cb6.available_indices[foundindex];
  self.var_3023a65b8d5e0cb6.available_indices = utility::array_remove_index(self.var_3023a65b8d5e0cb6.available_indices, foundindex);
  return retval;
}

function private function_8c5e0d5d40cc9de5(ref, desired_index) {
  if(!isDefined(self.var_3023a65b8d5e0cb6)) {
    self.var_3023a65b8d5e0cb6 = {};
  }

  if(!isDefined(self.var_3023a65b8d5e0cb6.available_indices)) {
    self.var_3023a65b8d5e0cb6.available_indices = [];

    for(i = 0; i < level.var_3023a65b8d5e0cb6.var_d3725c3f9b3b7387; i++) {
      self.var_3023a65b8d5e0cb6.available_indices[i] = i + 1;
    }
  }

  assert(self.var_3023a65b8d5e0cb6.available_indices.size);

  if(!isDefined(self.var_3023a65b8d5e0cb6.active_refs)) {
    self.var_3023a65b8d5e0cb6.active_refs = [];
  }

  if(self.var_3023a65b8d5e0cb6.available_indices.size > 0) {
    assert(!isDefined(self.var_3023a65b8d5e0cb6.active_refs[ref]));
    self.var_3023a65b8d5e0cb6.active_refs[ref] = function_e74f805ee87f69cc(desired_index);
    function_9fdf9825ce4b88ef(self.var_3023a65b8d5e0cb6.active_refs[ref]);
  }
}

function private function_96801c0d77f6a4d2(ref) {
  if(isDefined(self.var_3023a65b8d5e0cb6.active_refs[ref])) {
    index = self.var_3023a65b8d5e0cb6.active_refs[ref];
    self.var_3023a65b8d5e0cb6.available_indices[self.var_3023a65b8d5e0cb6.available_indices.size] = index;
    self.var_3023a65b8d5e0cb6.active_refs[ref] = undefined;
    return index;
  }
}

function private function_5747b3cb415b5519(ref, omnvar_ref) {
  omnvar_data = level.var_3023a65b8d5e0cb6.omnvars[omnvar_ref];
  return self getclientomnvar(omnvar_data.name + "w" + self.var_3023a65b8d5e0cb6.active_refs[ref]);
}

function private function_e7700150c608b23d(ref, omnvar_ref, value) {
  omnvar_data = level.var_3023a65b8d5e0cb6.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_3023a65b8d5e0cb6.active_refs[ref], value);
}

function private function_d9252d0264f23428(ref, omnvar_ref) {
  omnvar_data = level.var_3023a65b8d5e0cb6.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_3023a65b8d5e0cb6.active_refs[ref], omnvar_data.default_value);
}

function private function_9fdf9825ce4b88ef(index) {
  foreach(omnvar_data in level.var_3023a65b8d5e0cb6.omnvars) {
    if(ref != #"force_update") {
      self setclientomnvar(omnvar_data.name + "w" + index, omnvar_data.default_value);
    }
  }
}

function function_e05b2f20238f7c8e(ref, var_7fe2ea28e4d9de3c, item_image, backing_image, item_count = 0, desired_index = undefined, widget_type = "\x1b\xcf\xb6\xde\xb1s\xb7\xca\x04\xdcg#\xdd#") {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("|\v\xceYv\x8fi\xd2\xab\"\xea\xe0\x93p\x81+\xa4\xe7\x8e\xa0\xcd\xade\xb6\x15s\x01\"\xb7\x03/z\x83_");

  if(!(isDefined(backing_image) && isDefined(item_image) && isDefined(var_7fe2ea28e4d9de3c) && isDefined(ref) && isDefined(level.var_3023a65b8d5e0cb6.widget_types[widget_type]))) {
    assertmsg("<dev string:x24>" + level.var_3023a65b8d5e0cb6.container_widget + "<dev string:xdf>" + widget_type + "<dev string:xe8>");
  }

  if(!isDefined(level.var_3023a65b8d5e0cb6) || isDefined(self.var_3023a65b8d5e0cb6.active_refs[ref])) {
    return;
  }

  string_index = function_30e4f86dded0873(var_7fe2ea28e4d9de3c);
  var_a3dbae3daa6ac3c2 = function_f09d9c82acaea5a4(item_image);
  var_819ecd668c58a8aa = function_f09d9c82acaea5a4(backing_image);
  assert(isDefined(var_a3dbae3daa6ac3c2), "<dev string:xed>" + var_a3dbae3daa6ac3c2 + "<dev string:xf8>" + var_a3dbae3daa6ac3c2 + "<dev string:x12e>");
  assert(isDefined(var_819ecd668c58a8aa), "<dev string:xed>" + var_819ecd668c58a8aa + "<dev string:xf8>" + var_819ecd668c58a8aa + "<dev string:x12e>");

  if(!(isDefined(var_a3dbae3daa6ac3c2) && isDefined(string_index) && isDefined(var_819ecd668c58a8aa))) {
    return;
  }

  if(!hud_management::function_48c98ea9a4f0da89("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc")) {
    hud_management::function_35924dfcb78711f4("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc", level.var_3023a65b8d5e0cb6.container_widget);
    hud_management::function_d8d634ceece460("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc", level.var_3023a65b8d5e0cb6.alignment);
    hud_management::function_aaab83e8c950f455("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc", 7);
  }

  function_8c5e0d5d40cc9de5(ref, desired_index);
  function_e7700150c608b23d(ref, #"widget_type", level.var_3023a65b8d5e0cb6.widget_types[widget_type]);
  function_e7700150c608b23d(ref, #"text", string_index);
  function_e7700150c608b23d(ref, #"item_image", var_a3dbae3daa6ac3c2);
  function_e7700150c608b23d(ref, #"backing_image", var_819ecd668c58a8aa);
  function_e7700150c608b23d(ref, #"item_count", item_count);
  function_e7700150c608b23d(ref, #"force_update", !function_5747b3cb415b5519(ref, #"force_update"));
}

function function_f38201adbe0ba339(ref) {
  if(!isDefined(level.var_3023a65b8d5e0cb6) || !function_3c1502b13c02a127(ref)) {
    return;
  }

  function_e7700150c608b23d(ref, #"widget_type", 0);
  function_96801c0d77f6a4d2(ref);

  if(self.var_3023a65b8d5e0cb6.active_refs.size == 0) {
    hud_management::scripted_widget_destroy("w\xd1\xbbq\xd6\x11\xdbZ\xf8\xde\xf85\xd6\xf8\xa6\xf7R\x1b;\xf7\x87\xfc");
  }
}

function force_update(ref) {
  if(!(isDefined(level.var_3023a65b8d5e0cb6) && isDefined(self.var_3023a65b8d5e0cb6))) {
    return;
  }

  assert(function_3c1502b13c02a127(ref));
  function_e7700150c608b23d(ref, #"force_update", !function_5747b3cb415b5519(ref, #"force_update"));
}

function function_3c1502b13c02a127(ref) {
  return isDefined(ref) && isDefined(self.var_3023a65b8d5e0cb6.active_refs[ref]);
}