/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\powerups.gsc
***************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\engine\hud_management;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace powerups;

function init_powerups(var_6b2e229a933504d2, var_ac91518e3e88e114) {
  level utility::flag_set("-z\xc0\x9e\xf8$Pl\x7f\xc7\x10\x8e\xdd");
  root = function_af35457112dfa81b();
  root.active_powerups = [];
  root.powerups = [];
  root.powerup_index = 0;
  root.var_5a50a87976240aea = [];
  root.var_50f816faac2def5e = [];
  level thread function_d913b29de3d7a0b9(var_6b2e229a933504d2, var_ac91518e3e88e114);
  utility::registersharedfunc(#"powerups", #"dropPowerup", &powerup_drop);
}

function private function_d913b29de3d7a0b9(var_6b2e229a933504d2, var_ac91518e3e88e114) {
  wait 1;
  root = function_af35457112dfa81b();
  var_87b26fcee3a46903 = function_4fb0e35550090818();

  if(!isDefined(var_87b26fcee3a46903.powerup_list)) {
    return;
  }

  list_index = 0;

  foreach(var_f08befb90f2c1ae7 in var_87b26fcee3a46903.powerup_list) {
    if(isDefined(var_f08befb90f2c1ae7.ref) && isDefined(var_f08befb90f2c1ae7.bundle)) {
      var_32ce4d2c3601f28f = getscriptbundle("\xa5K\xfa\xfa!\xfd\xd1}" + var_f08befb90f2c1ae7.bundle);
      root.powerups[var_f08befb90f2c1ae7.ref] = var_32ce4d2c3601f28f;
      root.var_5a50a87976240aea[var_f08befb90f2c1ae7.ref] = list_index;

      if(istrue(var_f08befb90f2c1ae7.var_bb8b8a7d387b683a)) {
        root.var_50f816faac2def5e[root.var_50f816faac2def5e.size] = var_f08befb90f2c1ae7.ref;
      }
    }

    list_index++;
  }

  root.var_50f816faac2def5e = utility::array_randomize(root.var_50f816faac2def5e);
  function_bb4d7b8c925f1867("\xdbK/S?\x9b\x83\xc1\x16{\xf6SXf2\xe7#\xcd\xb8s\xda8\xf9\x10\a\xb9;\x93\xab\t\xf0\xa0\x9b\xd9#\x93\x1e\t\xe7{", var_87b26fcee3a46903.drop_event_incremental_number_per_player);

  if(isarray(var_87b26fcee3a46903.var_4dbd3117c6a6e9e1)) {
    drop_event_ranges = [];

    foreach(range in var_87b26fcee3a46903.var_4dbd3117c6a6e9e1) {
      range_struct = spawnStruct();
      range_struct.n_players = range.player_number;
      range_struct.n_min = range.min;
      range_struct.n_max = range.max;
      range_struct.var_8d65a01d46674077 = range.var_c25aec64710e534a;
      range_struct.str_label = range.category_label;
      drop_event_ranges[drop_event_ranges.size] = range_struct;
    }

    function_bb4d7b8c925f1867("\xf9\xb8\x16S^g\xbdv\x16\xfb \xb9I\xb0\xbb9\x1b", drop_event_ranges);
  }

  function_bb4d7b8c925f1867("\xb8S\xf7\x9b/\n\xdf\xcb\xc4t#\xe7\xa0&\xab\xb88\xd3", var_87b26fcee3a46903.drop_height_offset ?? 0);
  function_bb4d7b8c925f1867("\xdb\xe1x\x1f\xad\xc1\xb4^\x10\x9fQ\a\x1d!\xbf&\x0e\x9d\x0eB", var_87b26fcee3a46903.model_drop_delay_max ?? 0);
  function_bb4d7b8c925f1867("\xc3\xc8\x9af\xcc\"\xbb\xfd\xeb^\b\xce\xa7\xc0\xf6\x89\x80\xce\x85\x82", var_87b26fcee3a46903.model_drop_delay_min ?? 0);
  function_bb4d7b8c925f1867("\xc6\xaa9.xC\xe7\xf0m\xe4\x84\xbd\xc2\xc2@\xc6\xe6\xdaoh4O\x950\aO\xcaY\f\x193", var_87b26fcee3a46903.model_drop_delay_distance_outer ?? 0);
  function_bb4d7b8c925f1867("\xad{\x91\xb2l\xaf\x91\xc9\xb78\xeb\x19e\x8da\xf2\xf52i\x9b\x8ea\xdc\xc6+\xfain\xe6\xac\x93", var_87b26fcee3a46903.model_drop_delay_distance_inner ?? 0);
  function_bb4d7b8c925f1867("\x93~\xcc/\xb0\xadtlfK\x80'\xcb{N", var_87b26fcee3a46903.intro_vfx_label);
  function_bb4d7b8c925f1867("-s\xd19o\xaf\xd9\x99<\xaf\x8c]r,t\xd2\xf67", var_87b26fcee3a46903.intro_vfx_duration);
  function_bb4d7b8c925f1867("\nU\xaf\xec\x0f\x193g\x14\xd1=\x16\x9f\xea", var_87b26fcee3a46903.idle_vfx_label);
  function_bb4d7b8c925f1867("\xd7K3\x1b\x02\x9b\xcb\x86\x0e\xff\x12?Y\xe6\"\xe7!", var_87b26fcee3a46903.grabbed_vfx_label);
  function_bb4d7b8c925f1867("\xd9\n{\x81\x90PV\x0f]so\xc2\x8f3\x0e\xd5\xfd$7\x1b", var_87b26fcee3a46903.grabbed_vfx_duration);
  root.show_splash = getdvarint(@ "hash_c33094fc634b0af", var_87b26fcee3a46903.showsplash) == 1;
  var_91f96f9445825b04 = function_bb4d7b8c925f1867("{\xa6\x81\xdb\xd3R\xf1\xe2\x88u=u\x97\x93m\x1dZ\x19aD\x94>j\x1d", int(var_87b26fcee3a46903.ammo_spacing_min ?? 0));
  var_3c5da9513f385fba = function_bb4d7b8c925f1867("\x83o\xbbY'\xabp\xd7\xc2\xdak\xf6\xaf\xdc\a\vc\xd2\xdc\x9d\xd7\xdaX\x1e", int(var_87b26fcee3a46903.ammo_spacing_max ?? 0));

  if(var_3c5da9513f385fba != 0 || var_91f96f9445825b04 != 0) {
    if(var_3c5da9513f385fba > var_91f96f9445825b04) {
      root.var_aac6daf49e3d45c = function_c2165e3fac3afa14(var_91f96f9445825b04, var_3c5da9513f385fba);
    } else {
      assertmsg("<dev string:x24>" + root.var_3a66478faa794fb3);
    }
  }

  if(isarray(root.var_df2b241020b1cb9b)) {
    foreach(struct in root.var_df2b241020b1cb9b) {
      _register(struct.str_powerup, struct.func_grab_powerup, struct.func_should_drop_with_regular_powerups, struct.var_c35232116ac83a16);
    }

    root.var_df2b241020b1cb9b = undefined;
  }

  if(isDefined(var_ac91518e3e88e114)) {
    level[[var_ac91518e3e88e114]]();
  }

  level callback::add(var_6b2e229a933504d2, &function_aafabafb978ec1c7);
  function_709da975950db770(var_87b26fcee3a46903.var_9e2f88f1a3012681);
  level utility::flag_set("\xf9N\x88.\xc5\xa7\xfa\xf5TO\xf9~H\x11\xbd\xbb\r|\xd6BW\xbe");
}

function private function_709da975950db770(widget) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(isDefined(widget)) {
    level.var_7b3d5378c5ad3c8d = spawnStruct();
    level.var_7b3d5378c5ad3c8d.container_widget = widget;
    level.var_7b3d5378c5ad3c8d.var_d3725c3f9b3b7387 = hud_management::function_a6d447d45572370d(widget, "\xc8#\t\xbew\xa2\xc8:\\\x81\xf8\xe9k", "\x91\xca\xcc\v\xab\xd8:");
    level.var_7b3d5378c5ad3c8d.omnvars = [];
    var_9729ee0c534cc927 = hud_management::function_2d30d3e4449a6631(widget, "\xc8#\t\xbew\xa2\xc8:\\\x81\xf8\xe9k", "\x91\xca\xcc\v\xab\xd8:");

    foreach(omnvar_data in var_9729ee0c534cc927) {
      level.var_7b3d5378c5ad3c8d.omnvars[ref] = omnvar_data;
    }
  }
}

function private function_8c5e0d5d40cc9de5(ref, widget_type) {
  if(!isDefined(self.var_7b3d5378c5ad3c8d)) {
    self.var_7b3d5378c5ad3c8d = {};
  }

  if(!isDefined(self.var_7b3d5378c5ad3c8d.available_indices)) {
    self.var_7b3d5378c5ad3c8d.available_indices = [];

    for(i = 0; i < level.var_7b3d5378c5ad3c8d.var_d3725c3f9b3b7387; i++) {
      self.var_7b3d5378c5ad3c8d.available_indices[i] = i + 1;
    }
  }

  assert(self.var_7b3d5378c5ad3c8d.available_indices.size);

  if(!isDefined(self.var_7b3d5378c5ad3c8d.active_refs)) {
    self.var_7b3d5378c5ad3c8d.active_refs = [];
  }

  if(self.var_7b3d5378c5ad3c8d.available_indices.size > 0) {
    assert(!isDefined(self.var_7b3d5378c5ad3c8d.active_refs[ref]));
    self.var_7b3d5378c5ad3c8d.active_refs[ref] = {};
    self.var_7b3d5378c5ad3c8d.active_refs[ref].index = self.var_7b3d5378c5ad3c8d.available_indices[0];
    self.var_7b3d5378c5ad3c8d.active_refs[ref].widget_type = widget_type;
    self.var_7b3d5378c5ad3c8d.available_indices = utility::array_remove_index(self.var_7b3d5378c5ad3c8d.available_indices, 0);
    function_9fdf9825ce4b88ef(self.var_7b3d5378c5ad3c8d.active_refs[ref].index);
  }
}

function private function_96801c0d77f6a4d2(ref) {
  if(isDefined(self.var_7b3d5378c5ad3c8d.active_refs[ref])) {
    index = self.var_7b3d5378c5ad3c8d.active_refs[ref].index;
    self.var_7b3d5378c5ad3c8d.available_indices[self.var_7b3d5378c5ad3c8d.available_indices.size] = index;
    self.var_7b3d5378c5ad3c8d.active_refs[ref] = undefined;
    return index;
  }
}

function private function_e7700150c608b23d(ref, omnvar_ref, value) {
  omnvar_data = level.var_7b3d5378c5ad3c8d.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_7b3d5378c5ad3c8d.active_refs[ref].index, value);
}

function private function_5747b3cb415b5519(ref, omnvar_ref) {
  omnvar_data = level.var_7b3d5378c5ad3c8d.omnvars[omnvar_ref];
  return self getclientomnvar(omnvar_data.name + "w" + self.var_7b3d5378c5ad3c8d.active_refs[ref].index);
}

function private function_d9252d0264f23428(ref, omnvar_ref) {
  omnvar_data = level.var_7b3d5378c5ad3c8d.omnvars[omnvar_ref];
  self setclientomnvar(omnvar_data.name + "w" + self.var_7b3d5378c5ad3c8d.active_refs[ref].index, omnvar_data.default_value);
}

function private function_9fdf9825ce4b88ef(index) {
  foreach(omnvar_data in level.var_7b3d5378c5ad3c8d.omnvars) {
    self setclientomnvar(omnvar_data.name + "w" + index, omnvar_data.default_value);
  }
}

function function_edd3d8c5fb4cc877(ref) {
  return isDefined(ref) && isDefined(self.var_7b3d5378c5ad3c8d.active_refs[ref]);
}

function function_e769306f9faf12c8(ref, bundle_index, time, widget_type = "\x91\xca\xcc\v\xab\xd8:") {
  widget_index = hud_management::function_82bc555407efe4fd(level.var_7b3d5378c5ad3c8d.container_widget, "\xc8#\t\xbew\xa2\xc8:\\\x81\xf8\xe9k", widget_type);

  if(!(isDefined(time) && isDefined(bundle_index) && isDefined(ref) && isDefined(widget_index))) {
    assertmsg("<dev string:x5a>" + level.var_7b3d5378c5ad3c8d.container_widget + "<dev string:x107>" + widget_type + "<dev string:x110>");
  }

  if(function_edd3d8c5fb4cc877(ref)) {
    function_6b490060add90e7b(ref, time);
    return;
  }

  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\xf9N\x88.\xc5\xa7\xfa\xf5TO\xf9~H\x11\xbd\xbb\r|\xd6BW\xbe");

  if(!hud_management::function_48c98ea9a4f0da89("\xf72\x18\xdf\a[|\xe2o\xaa\x87\x91\xe6\x15")) {
    poweruplist = function_4fb0e35550090818();

    if(isDefined(poweruplist.var_547eddebb45f0a01)) {
      self setclientomnvar("@\xc7[:\xf1\xbd!\xd5\x81\x14\xeb8*^\xbb\x1b\xe5\xbf\xb3\xf2\xfc\\", int(poweruplist.var_547eddebb45f0a01));
    }

    hud_management::function_35924dfcb78711f4("\xf72\x18\xdf\a[|\xe2o\xaa\x87\x91\xe6\x15", level.var_7b3d5378c5ad3c8d.container_widget);
    anchorhorz = hud_management::function_8c7cf24f0d9455e0(poweruplist.var_fe556a1d366484d5);
    anchorvert = hud_management::function_3b1161c0877a7ebe(poweruplist.var_743755676649908b);
    anchorx = poweruplist.var_6bfec08907c96cc6 ?? 0;
    anchory = poweruplist.var_d55f1ce4ea659e7d ?? 0;
    hud_management::function_85d8a0ba2e35b6f2("\xf72\x18\xdf\a[|\xe2o\xaa\x87\x91\xe6\x15", anchorx, anchory, anchorhorz, anchorvert);
  }

  function_8c5e0d5d40cc9de5(ref, hud_management::function_6b541ec4e8abf983(level.var_7b3d5378c5ad3c8d.container_widget, "\xc8#\t\xbew\xa2\xc8:\\\x81\xf8\xe9k", widget_type));
  function_e7700150c608b23d(ref, #"widget_type_index", widget_index);
  function_e7700150c608b23d(ref, #"bundle_index", bundle_index);
  function_e7700150c608b23d(ref, #"time", int(time));
}

function function_d408737e10ae64c9(ref) {
  if(!isDefined(level.var_7b3d5378c5ad3c8d) || !function_edd3d8c5fb4cc877(ref)) {
    return;
  }

  function_e7700150c608b23d(ref, #"widget_type_index", 0);
  function_96801c0d77f6a4d2(ref);

  if(self.var_7b3d5378c5ad3c8d.active_refs.size == 0) {
    hud_management::scripted_widget_destroy("\xf72\x18\xdf\a[|\xe2o\xaa\x87\x91\xe6\x15");
  }
}

function function_6b490060add90e7b(ref, time) {
  if(!function_edd3d8c5fb4cc877(ref)) {
    return;
  }

  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\xf9N\x88.\xc5\xa7\xfa\xf5TO\xf9~H\x11\xbd\xbb\r|\xd6BW\xbe");
  prev_time = function_5747b3cb415b5519(ref, #"time");
  time = int(time);
  function_e7700150c608b23d(ref, #"time", time);

  if(time == prev_time) {
    function_e7700150c608b23d(ref, #"reset", !function_5747b3cb415b5519(ref, #"reset"));
  }
}

function function_152ab9697cc8fa39(ref, state) {
  if(!function_edd3d8c5fb4cc877(ref)) {
    return;
  }

  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\xf9N\x88.\xc5\xa7\xfa\xf5TO\xf9~H\x11\xbd\xbb\r|\xd6BW\xbe");
  omnvar_data = level.var_7b3d5378c5ad3c8d.omnvars[#"state"];
  hud_management::function_d8d634ceece460(self.var_7b3d5378c5ad3c8d.active_refs[ref].widget_type, state, omnvar_data.name + "w" + self.var_7b3d5378c5ad3c8d.active_refs[ref].index);
}

function function_99fc751ace377646(event) {
  level callback::add(event, &function_aafabafb978ec1c7);
}

function function_4fb0e35550090818() {
  root = function_af35457112dfa81b();

  if(!isDefined(root.var_46945c1fa2a33bfb)) {
    if(isDefined(level.var_8acd709a408f80ed)) {
      var_8acd709a408f80ed = "\xc1\xde\xee\xca9\xae8l\xd2\xb9\xa3G" + level.var_8acd709a408f80ed;
      root.var_3a66478faa794fb3 = level.var_8acd709a408f80ed;
    } else {
      var_8acd709a408f80ed = undefined;

      if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.powerup_list)) {
        var_8acd709a408f80ed = "\xc1\xde\xee\xca9\xae8l\xd2\xb9\xa3G" + level.gametypebundle.powerup_list;
        root.var_3a66478faa794fb3 = level.gametypebundle.powerup_list;
      } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.powerup_list)) {
        var_8acd709a408f80ed = "\xc1\xde\xee\xca9\xae8l\xd2\xb9\xa3G" + level.gamemodebundle.powerup_list;
        root.var_3a66478faa794fb3 = level.gamemodebundle.powerup_list;
      }

      assert(isDefined(var_8acd709a408f80ed), "<dev string:x115>");
    }

    root.var_46945c1fa2a33bfb = getscriptbundle(var_8acd709a408f80ed);
  }

  return root.var_46945c1fa2a33bfb;
}

function register_powerup(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_c35232116ac83a16) {
  root = function_af35457112dfa81b();

  if(isarray(root.powerups) && root.powerups.size > 0) {
    _register(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_c35232116ac83a16);
    return;
  }

  function_1f55404f419c04bf(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_c35232116ac83a16);
}

function _register(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_c35232116ac83a16) {
  root = function_af35457112dfa81b();

  if(isDefined(root.powerups[str_powerup])) {
    root.powerups[str_powerup].func_grab_powerup = func_grab_powerup;
    root.powerups[str_powerup].func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups ?? &func_should_always_drop;
    root.powerups[str_powerup].var_c35232116ac83a16 = var_c35232116ac83a16;
  }
}

function function_1f55404f419c04bf(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_c35232116ac83a16) {
  root = function_af35457112dfa81b();

  if(!isarray(root.var_df2b241020b1cb9b)) {
    root.var_df2b241020b1cb9b = [];
  }

  struct = spawnStruct();
  struct.str_powerup = str_powerup;
  struct.func_grab_powerup = func_grab_powerup;
  struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
  struct.var_c35232116ac83a16 = var_c35232116ac83a16;
  root.var_df2b241020b1cb9b[root.var_df2b241020b1cb9b.size] = struct;
}

function powerup_activate(str_powerup, ent_powerup) {
  assert(isPlayer(self));
  player = self;
  var_32ce4d2c3601f28f = function_3117e4a2c373f5e0(str_powerup);

  if(isDefined(var_32ce4d2c3601f28f.func_grab_powerup)) {
    player thread[[var_32ce4d2c3601f28f.func_grab_powerup]](str_powerup, ent_powerup);
  }

  params = spawnStruct();
  params.str_powerup = str_powerup;
  params.powerup_source = ent_powerup.var_84a7cd262aa3b9dc;
  callback::callback("L\xf1N\xab\xee\xb0\xc0A\xdf\x8f5K\xb6\xfe\xc5\xaa\x86", params);
}

function function_4d108b426d7e4487(str_powerup) {
  return istrue(function_3117e4a2c373f5e0(str_powerup).var_33b90ed8989c1de1);
}

function function_331c789c8013dbe2(str_powerup) {
  return !function_4d108b426d7e4487(str_powerup) && istrue(function_3117e4a2c373f5e0(str_powerup).var_6f6a858dc25c244e);
}

function function_a8f866125b63e7fb(str_powerup) {
  affected_radius = function_3117e4a2c373f5e0(str_powerup).var_3435b5edcf29f829;

  if(isfloat(affected_radius)) {
    return affected_radius;
  }

  return 0;
}

function function_3117e4a2c373f5e0(str_powerup) {
  return function_af35457112dfa81b().powerups[str_powerup];
}

function function_495ddb903509d4ac(str_powerup, powerup_origin) {
  root = function_af35457112dfa81b();
  a_players = [];

  if(function_4d108b426d7e4487(str_powerup)) {
    a_players[a_players.size] = self;
  } else if(function_331c789c8013dbe2(str_powerup)) {
    a_players = level.players;
  } else if(isDefined(root.var_ab2e0e683ace9ce9)) {
    a_players = self[[root.var_ab2e0e683ace9ce9]]();
  } else {
    foreach(player in level.players) {
      if(isPlayer(player) && self.team == player.team) {
        a_players[a_players.size] = player;
      }
    }
  }

  final_players = [];
  var_c47ec02aa6d8ebaf = function_a8f866125b63e7fb(str_powerup);

  if(isDefined(powerup_origin) && var_c47ec02aa6d8ebaf > 0) {
    foreach(player in a_players) {
      if(distancesquared(player.origin, powerup_origin) <= squared(var_c47ec02aa6d8ebaf)) {
        final_players[final_players.size] = player;
      }
    }
  } else {
    final_players = a_players;
  }

  return final_players;
}

function function_1da5df3f47fec0fd(str_powerup, v_spawn_pos, v_spawn_angles) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  e_powerup = powerup_drop(str_powerup, v_spawn_pos, -1, 0);

  if(isDefined(e_powerup)) {
    e_powerup.angles = v_spawn_angles;
    e_powerup.mesh_mdl.angles = v_spawn_angles;
    e_powerup setModel("\x8e\x96\xce[;;\xea\\\xdc\x9a\xbb\x9f{\xfd\xe3\x18\xe02");
    contents = trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
    v_up = anglestoup(e_powerup.angles);
    caststart = e_powerup.origin + v_up * 32;
    castend = caststart + v_up * -100;
    traceresult = trace::ray_trace(caststart, castend, [], contents);

    if(isDefined(traceresult["\x1f\xa8\x10WP\xa9"])) {
      e_powerup linkTo(traceresult["\x1f\xa8\x10WP\xa9"]);
      e_powerup.mesh_mdl linkTo(traceresult["\x1f\xa8\x10WP\xa9"]);
    }
  }
}

function function_9f1872cab57657dc(str_powerup, origin, var_84a7cd262aa3b9dc) {
  if(!isDefined(origin)) {
    assertmsg("<dev string:x185>");
    return;
  }

  offset = (0, 0, function_7cc2b4e69f199fc3("\xb8S\xf7\x9b/\n\xdf\xcb\xc4t#\xe7\xa0&\xab\xb88\xd3"));
  level thread powerup_drop(str_powerup, origin + offset, undefined, undefined, var_84a7cd262aa3b9dc);
}

function powerup_drop(str_powerup, v_spawn_pos, var_19c4be6a41f6bdcb, var_1eac486a710cd28f, var_84a7cd262aa3b9dc) {
  self endon("2\xf3\x18\\\xa3}\xd4\xcc\xbc\b9\n\xd1\xa9-");
  self endon("\x1e\xfd\xd1\xa2\a");
  root = function_af35457112dfa81b();
  var_32ce4d2c3601f28f = function_3117e4a2c373f5e0(str_powerup);
  e_powerup = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", v_spawn_pos);
  e_powerup setModel("\xec\xbfK|\au\xcd\xc2\x19<");
  e_powerup function_a1b82abf09fa3be0(var_32ce4d2c3601f28f.model, 1);
  e_powerup.str_powerup = str_powerup;
  e_powerup.var_84a7cd262aa3b9dc = var_84a7cd262aa3b9dc ?? "\x8e\f\xe4I";
  function_815523e3bf15207c(str_powerup);
  offset = (0, 0, function_7cc2b4e69f199fc3("\xb8S\xf7\x9b/\n\xdf\xcb\xc4t#\xe7\xa0&\xab\xb88\xd3"));
  groundent = e_powerup thread function_b3259958c515610(offset);
  groundent = e_powerup.mesh_mdl function_b3259958c515610(offset);
  e_powerup thread powerup_wobble(e_powerup.mesh_mdl, groundent);
  e_powerup thread powerup_timeout(var_19c4be6a41f6bdcb);
  e_powerup thread powerup_wait_for_pickup(var_1eac486a710cd28f);
  root.active_powerups[root.active_powerups.size] = e_powerup;
  level notify("\xcbp\xe3u3\xf3'\xf17\x0e\x9fK(\xc9P", e_powerup);

  if(isDefined(root.dropped_callbacks)) {
    foreach(dc in root.dropped_callbacks) {
      level[[dc]](e_powerup);
    }
  }

  return e_powerup;
}

function function_b3259958c515610(offset = (0, 0, 0)) {
  movingplatforminfo = utility::function_21fc4ef13fb1f5c3();

  if(isDefined(movingplatforminfo.localorigin) && isDefined(movingplatforminfo.groundent) && isDefined(movingplatforminfo) && isDefined(movingplatforminfo.localangles)) {
    if(isDefined(self.linkedparent)) {
      self.linkedparent linkTo(movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles);
    } else {
      self linkTo(movingplatforminfo.groundent, "", movingplatforminfo.localorigin + offset, movingplatforminfo.localangles);
    }

    return movingplatforminfo.groundent;
  }
}

function function_5376733c72d94c75(func_callback) {
  root = function_af35457112dfa81b();

  if(!isDefined(root.dropped_callbacks)) {
    root.dropped_callbacks = [];
  }

  root.dropped_callbacks[root.dropped_callbacks.size] = func_callback;
}

function function_815523e3bf15207c(str_powerup) {
  root = function_af35457112dfa81b();

  if(isDefined(root.var_aac6daf49e3d45c)) {
    if(str_powerup == "J\xc1u\xecs'j\xae\xc5") {
      root.var_aac6daf49e3d45c = function_c2165e3fac3afa14(function_7cc2b4e69f199fc3("{\xa6\x81\xdb\xd3R\xf1\xe2\x88u=u\x97\x93m\x1dZ\x19aD\x94>j\x1d"), function_7cc2b4e69f199fc3("\x83o\xbbY'\xabp\xd7\xc2\xdak\xf6\xaf\xdc\a\vc\xd2\xdc\x9d\xd7\xdaX\x1e"));
      return;
    }

    if(root.var_aac6daf49e3d45c > 0) {
      root.var_aac6daf49e3d45c--;
    }
  }
}

function powerup_wobble(ent_model, groundent) {
  self endon("2\xf3\x18\\\xa3}\xd4\xcc\xbc\b9\n\xd1\xa9-");
  self endon("0\x9f0U\xd2\xf3\x0f\xa1]9#S\r\x16\xd0\x81");
  self endon("\x1e\xfd\xd1\xa2\a");
  powerup_info = function_3117e4a2c373f5e0(self.str_powerup);

  if(istrue(powerup_info.var_7e36d6729c125b6a)) {
    return;
  }

  while(isDefined(ent_model)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomint(360);

    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }

    yaw = ent_model.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));

    if(isDefined(groundent)) {
      ent_model rotateTo(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    } else {
      ent_model rotateTo(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    }

    wait randomfloat(waittime - 0.1);
  }
}

function powerup_timeout(n_lifetime) {
  if(isDefined(n_lifetime) && n_lifetime < 0) {
    return;
  }

  powerup_info = function_3117e4a2c373f5e0(self.str_powerup);

  if(!isDefined(n_lifetime)) {
    n_lifetime = powerup_info.var_c5cfea2f094ba6f8;
  }

  self endon("2\xf3\x18\\\xa3}\xd4\xcc\xbc\b9\n\xd1\xa9-");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x96\x839,\xde\xebo\x9e\xb4\x1a%\xae8");
  blinktime = 10;
  var_e9a8fe115cbede2e = max(0, n_lifetime - blinktime);
  wait var_e9a8fe115cbede2e;
  hide_and_show(&powerup_hide, &powerup_show);
  self notify("0\x9f0U\xd2\xf3\x0f\xa1]9#S\r\x16\xd0\x81");

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("4\xacz\xed|")) {
    self.mesh_mdl setscriptablepartstate("4\xacz\xed|", "\xef\xf2%\xbc\xb7o\xfe\xb2\xb9");
  }

  thread function_481052a391e92699();
}

function powerup_hide() {
  if(isDefined(self)) {
    self hide();
  }

  if(isDefined(self.mesh_mdl)) {
    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x9a\x93\xa5\xc4I")) {
      self.mesh_mdl setscriptablepartstate("\x9a\x93\xa5\xc4I", "\xf8\x02\xad1r\x06\x012\xebV");
      return;
    }

    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x91\x88\xc2*")) {
      self.mesh_mdl setscriptablepartstate("\x91\x88\xc2*", "\x19b\xc2y");
      return;
    }

    self.mesh_mdl hide();
  }
}

function powerup_show(var_d57490c963ae8577) {
  if(isDefined(self)) {
    self show();
  }

  if(isDefined(self.mesh_mdl)) {
    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x9a\x93\xa5\xc4I")) {
      if(istrue(var_d57490c963ae8577)) {
        self.mesh_mdl setscriptablepartstate("\x9a\x93\xa5\xc4I", "r\xad\"\x04\x95\xe2\xa3\n\x8e\xfe");
      } else {
        self.mesh_mdl setscriptablepartstate("\x9a\x93\xa5\xc4I", "/\xf2Ul\x0enW\xf1$rH4Vc\x97#\x06h\xa9Y\xef");
      }

      return;
    }

    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x91\x88\xc2*")) {
      self.mesh_mdl setscriptablepartstate("\x91\x88\xc2*", "\xf1\xba\x8f\x9d");
      return;
    }

    self.mesh_mdl show();
  }
}

function hide_and_show(hide_func, show_func) {
  self endon("\x1e\xfd\xd1\xa2\a");
  var_d57490c963ae8577 = 0;

  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self[[show_func]](var_d57490c963ae8577);
    } else {
      self[[hide_func]]();
    }

    if(i < 16) {
      wait 0.5;
      continue;
    }

    if(i < 24) {
      var_d57490c963ae8577 = 1;
      wait 0.25;
      continue;
    }

    var_d57490c963ae8577 = 1;
    wait 0.1;
  }
}

function powerup_delete() {
  if(isDefined(self.e_trigger)) {
    self.e_trigger delete();
  }

  if(isDefined(self.mesh_mdl)) {
    self.mesh_mdl delete();
  }

  root = function_af35457112dfa81b();

  if(isDefined(self)) {
    root.active_powerups = arrayremove(root.active_powerups, self);
    self delete();
  }
}

function powerup_wait_for_pickup(var_1eac486a710cd28f) {
  self endon("\x1e\xfd\xd1\xa2\a");
  root = function_af35457112dfa81b();
  var_32ce4d2c3601f28f = function_3117e4a2c373f5e0(self.str_powerup);
  offset = (0, 0, function_7cc2b4e69f199fc3("\xb8S\xf7\x9b/\n\xdf\xcb\xc4t#\xe7\xa0&\xab\xb88\xd3"));
  origin = self.origin - offset;
  n_trigger_radius = var_1eac486a710cd28f ?? 32;
  adjust_origin = isDefined(var_1eac486a710cd28f) ? self.origin : origin;
  self.e_trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", adjust_origin, 0, n_trigger_radius, 72);
  self.e_trigger enablelinkTo();
  self.e_trigger linkTo(self);

  while(true) {
    self.e_trigger waittill("\x91`\xb1\xe7T\x97>", ent);
    player = ent;

    if(isDefined(root.var_cae5dafd2a05769e)) {
      player = ent[[root.var_cae5dafd2a05769e]]();
    }

    if(!istrue(var_32ce4d2c3601f28f.var_ba5d0e5c397defa2) && !isPlayer(player)) {
      continue;
    }

    if(!istrue(var_32ce4d2c3601f28f.powerupcanpickupinlaststand) && istrue(player.inlaststand)) {
      continue;
    }

    if(isDefined(self.mesh_mdl)) {
      if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("4\xacz\xed|")) {
        self.mesh_mdl setscriptablepartstate("4\xacz\xed|", "\x1d\x95S\xfd\xf0\xa8");
      }
    }

    var_a4dcf2a70832f9a8 = player function_495ddb903509d4ac(self.str_powerup, self.origin);

    foreach(player_sound in var_a4dcf2a70832f9a8) {
      if(self.str_powerup == ">-\x83\x97") {
        continue;
      }

      sound_event = "s\x9bFV\xce\x95s\xa3_\x0e\xde\xee\xacrW\x83\xfa" + self.str_powerup;
      player_sound playsoundevent(sound_event, player_sound);
      telemetry_utils::function_5b8d2fb6021d8763("_O\xa4\x8dN\xf1B\x16\x98\xc4pP\xc4\x98F\xd4g\xf6\fl", {
        #target: undefined, #speaker: player_sound, #sound_event: sound_event, #sound_type: undefined, #script_func_name: "\x9azh[\xf5P\x9b4\xec\x94\x10H\xd8\x80\xfb=\xddF5\xc5\xab\xab7"});
    }

    if(isDefined(var_32ce4d2c3601f28f.var_2e830d5a08e83a77)) {
      a_players = player function_495ddb903509d4ac(self.str_powerup, self.origin);

      foreach(player_sound in a_players) {
        if(isPlayer(player_sound)) {
          player_sound namespace_bc7cdace2d7445a5::playsoundtoplayersharedfunc(var_32ce4d2c3601f28f.var_2e830d5a08e83a77, player_sound);
        }
      }
    }

    if(isDefined(player.name)) {
      iprintlnbold(self.str_powerup + "<dev string:x1ac>" + player.name);
    }

    level callback::callback(#"player_powerup", {
      #player: player, #powerup: self
    });
    player powerup_activate(self.str_powerup, self);
    player namespace_bc7cdace2d7445a5::dopowerupscoreeventsharedfunc();
    self notify("2\xf3\x18\\\xa3}\xd4\xcc\xbc\b9\n\xd1\xa9-", player);
    thread function_481052a391e92699(1);
    return;
  }
}

function get_next_powerup() {
  root = function_af35457112dfa81b();

  if(isDefined(level.var_521a85bb48b0a5e0)) {
    str_powerup = level.var_521a85bb48b0a5e0;
    level.var_521a85bb48b0a5e0 = undefined;
    return str_powerup;
  }

  if(isDefined(level.var_4c51637ab759d4da)) {
    str_powerup = level.var_4c51637ab759d4da;
    level.var_4c51637ab759d4da = undefined;
  } else {
    str_powerup = root.var_50f816faac2def5e[root.powerup_index];
    root.powerup_index++;

    if(root.powerup_index >= root.var_50f816faac2def5e.size) {
      root.powerup_index = 0;
      function_9dc04fdee7438e56(str_powerup);
    }
  }

  return str_powerup;
}

function function_9dc04fdee7438e56(var_5c0f4be1e30d43bb) {
  root = function_af35457112dfa81b();
  root.var_50f816faac2def5e = utility::array_randomize(root.var_50f816faac2def5e);

  if(root.var_50f816faac2def5e[0] == var_5c0f4be1e30d43bb) {
    nextpowerup = root.var_50f816faac2def5e[0];
    finalindex = root.var_50f816faac2def5e.size - 1;
    finalpowerup = root.var_50f816faac2def5e[finalindex];
    root.var_50f816faac2def5e[0] = finalpowerup;
    root.var_50f816faac2def5e[finalindex] = nextpowerup;
  }
}

function func_should_always_drop() {
  return true;
}

function func_should_never_drop() {
  return false;
}

function function_aafabafb978ec1c7(params) {
  if(!function_8a2c94d4a52259c7()) {
    return;
  }

  if(istrue(self.no_powerups)) {
    return;
  }

  root = function_af35457112dfa81b();

  if(isDefined(root.var_fa094e8678de827e)) {
    if(!self[[root.var_fa094e8678de827e]](params)) {
      return;
    }
  }

  drop_pos = isai(self) ? self.var_62f5e7ff1a9c1e45 : self.origin;

  if(!isDefined(level.var_164178bbc89b0303)) {
    level.var_164178bbc89b0303 = throttle::throttle_initialize("\x17\x9c\x171}\x15o\xae\xd7\x16\x18;", 1, level.framedurationseconds);
  }

  var_38ca52a82d9ad5e7 = spawnStruct();
  throttle::function_33b7d60bed350fee(level.var_164178bbc89b0303, var_38ca52a82d9ad5e7);
  var_721739c6f6c86b5b = 1;

  if(isDefined(root.var_e50dfb8742e5ba52)) {
    params.etarget = self;
    var_721739c6f6c86b5b = level[[root.var_e50dfb8742e5ba52]](params);
  }

  if(var_721739c6f6c86b5b) {
    var_feb46db84595cc12 = undefined;
    var_feb46db84595cc12 = function_662c5decd0b5abd7();

    if(isDefined(var_feb46db84595cc12)) {
      offset = (0, 0, function_7cc2b4e69f199fc3("\xb8S\xf7\x9b/\n\xdf\xcb\xc4t#\xe7\xa0&\xab\xb88\xd3"));
      level thread powerup_drop(var_feb46db84595cc12, drop_pos + offset, undefined, undefined, "\x8e\f\xe4I");
    }
  }
}

function function_662c5decd0b5abd7() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  root = function_af35457112dfa81b();

  if(isDefined(level.var_521a85bb48b0a5e0)) {
    str_powerup = level.var_521a85bb48b0a5e0;
    level.var_521a85bb48b0a5e0 = undefined;
    return str_powerup;
  }

  for(n_loop = root.var_50f816faac2def5e.size * 2; n_loop > 0; n_loop--) {
    str_powerup = get_next_powerup();
    powerup_info = function_3117e4a2c373f5e0(str_powerup);

    if(!isDefined(powerup_info.func_should_drop_with_regular_powerups)) {
      return str_powerup;
    }

    is_available = [[powerup_info.func_should_drop_with_regular_powerups]]();

    if(istrue(is_available)) {
      return str_powerup;
    }
  }

  return undefined;
}

function function_d719c0438066345b(var_b804845bdaa924cc) {
  function_af35457112dfa81b().var_fe77464e4b039f68 = var_b804845bdaa924cc;
}

function private function_8a2c94d4a52259c7() {
  root = function_af35457112dfa81b();

  if(isDefined(root.var_fe77464e4b039f68)) {
    return root.var_fe77464e4b039f68;
  }

  return 1;
}

function function_bb4d7b8c925f1867(zvar, value) {
  if(!isDefined(value)) {
    return undefined;
  }

  root = function_af35457112dfa81b();
  root.powerup_vars[zvar] = value;
  return value;
}

function function_7cc2b4e69f199fc3(zvar) {
  root = function_af35457112dfa81b();
  return root.powerup_vars[zvar];
}

function powerup_hud_show(str_powerup, n_lifetime, var_36ba325c699f3ec1, var_973d2947cc31853b) {
  self notify("\xac0I=UH4q\x0e\xd9\x10\xdc\xde;\x0fz(" + str_powerup);
  self endon("\xac0I=UH4q\x0e\xd9\x10\xdc\xde;\x0fz(" + str_powerup);
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  root = function_af35457112dfa81b();
  self[[root.var_9469aa34714c6d4d]](self.var_9773b5789e4435f9[str_powerup], n_lifetime, var_36ba325c699f3ec1, var_973d2947cc31853b);
  self.var_6635e72f832d8fd2[self.var_9773b5789e4435f9[str_powerup].index] = undefined;
  self.var_9773b5789e4435f9[str_powerup] = undefined;
  self[[root.var_d0b968b0e9da1f7f]](str_powerup);
}

function function_e2011903ed5cfdd5(str_powerup) {
  self notify("\xac0I=UH4q\x0e\xd9\x10\xdc\xde;\x0fz(" + str_powerup);
  self endon("\xac0I=UH4q\x0e\xd9\x10\xdc\xde;\x0fz(" + str_powerup);
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  root = function_af35457112dfa81b();

  if(!isDefined(self.var_9773b5789e4435f9)) {
    self.var_9773b5789e4435f9 = [];
  }

  if(!isDefined(self.var_9773b5789e4435f9[str_powerup])) {
    self.var_9773b5789e4435f9[str_powerup] = spawnStruct();
  }

  if(!isDefined(self.var_6635e72f832d8fd2)) {
    self.var_6635e72f832d8fd2 = [];
  }

  powerupbundle = function_4fb0e35550090818();
  poweruplist = powerupbundle.powerup_list;
  powerupindex = 0;
  spotfound = 0;

  for(i = 0; i < poweruplist.size; i++) {
    var_8dc6d474daa9a79a = isDefined(self.var_6635e72f832d8fd2[i]);
    var_f4f9a983b4c5fd13 = var_8dc6d474daa9a79a && self.var_6635e72f832d8fd2[i] == str_powerup;

    if(!var_8dc6d474daa9a79a || var_f4f9a983b4c5fd13) {
      if(!spotfound) {
        powerupindex = i;
        spotfound = 1;
        continue;
      }

      self.var_6635e72f832d8fd2[i] = undefined;
    }
  }

  self.var_9773b5789e4435f9[str_powerup].str_powerup = str_powerup;
  self.var_9773b5789e4435f9[str_powerup].start = gettime();
  self.var_9773b5789e4435f9[str_powerup].index = powerupindex;
  self.var_6635e72f832d8fd2[powerupindex] = str_powerup;
  return self.var_9773b5789e4435f9[str_powerup];
}

function function_80a188415c0433ff(hud_powerup, n_lifetime) {
  assert(isPlayer(self));
  root = function_af35457112dfa81b();
  poweruplist = function_4fb0e35550090818();
  assert(isDefined(root.var_5a50a87976240aea[hud_powerup.str_powerup]), "<dev string:x1c6>" + hud_powerup.str_powerup + "<dev string:x1db>");
  player = self;
  index = hud_powerup.index;
  scriptedwidgettype = poweruplist.var_9e2f88f1a3012681;
  refname = "\xd0]F\xf5\xc1\xb7w\xca'u\xc1_" + hud_powerup.str_powerup;
  isactive = player function_edd3d8c5fb4cc877(refname);

  if(n_lifetime > 0 && isDefined(scriptedwidgettype) && scriptedwidgettype != "") {
    state = poweruplist.scriptedwidgethudstate ?? "";

    if(!isactive) {
      player function_e769306f9faf12c8(refname, root.var_5a50a87976240aea[hud_powerup.str_powerup], n_lifetime);
    } else {
      player function_e7700150c608b23d(refname, #"bundle_index", root.var_5a50a87976240aea[hud_powerup.str_powerup]);
      player function_6b490060add90e7b(refname, n_lifetime);
    }

    player function_152ab9697cc8fa39(refname, state);
    return;
  }

  if(isactive) {
    player function_152ab9697cc8fa39(refname, "\x19b\xc2y");
    wait 1.5;
    player function_d408737e10ae64c9(refname);
  }
}

function function_23a6af6d0e61feb9(hud_powerup, n_lifetime) {
  assert(isPlayer(self));
  root = function_af35457112dfa81b();
  poweruplist = function_4fb0e35550090818();
  assert(isDefined(root.var_5a50a87976240aea[hud_powerup.str_powerup]), "<dev string:x1c6>" + hud_powerup.str_powerup + "<dev string:x1db>");
  player = self;
  index = root.var_5a50a87976240aea[hud_powerup.str_powerup];
  scriptedwidgettype = poweruplist.var_98420aefb0c6a900;
  refname = "4]\x91\xbe8{\xdd\xacN\xba8\xbe\xd9K;s\xca\x8e\x8e\xca";
  isactive = player hud_management::function_48c98ea9a4f0da89(refname);

  if(n_lifetime > 0 && isDefined(scriptedwidgettype) && scriptedwidgettype != "") {
    state = poweruplist.var_3a6a2bcdc6167a9b ?? "";
    param = poweruplist.var_b326aa33e7f2c707 ?? "";

    if(!isactive) {
      player hud_management::function_35924dfcb78711f4(refname, scriptedwidgettype);
      player hud_management::function_d8d634ceece460(refname, state);
      player hud_management::function_b683400f784cb7dc(refname, param);
    }

    return;
  }

  if(isactive) {
    player hud_management::scripted_widget_destroy(refname);
  }
}

function function_c87d1afa28859a3e() {
  if(!isDefined(self.var_6635e72f832d8fd2)) {
    return;
  }

  poweruplist = function_4fb0e35550090818();

  for(i = 0; i < self.var_6635e72f832d8fd2.size; i++) {
    self.var_6635e72f832d8fd2[i] = undefined;
  }

  hud_management::scripted_widget_destroy("\xf72\x18\xdf\a[|\xe2o\xaa\x87\x91\xe6\x15");
  self.var_7b3d5378c5ad3c8d = undefined;
}

function function_a1b82abf09fa3be0(model_name, var_1f82e0a39c93dc49) {
  self endon("2\xf3\x18\\\xa3}\xd4\xcc\xbc\b9\n\xd1\xa9-");
  self endon("\x1e\xfd\xd1\xa2\a");
  intro_fx = function_7cc2b4e69f199fc3("\x93~\xcc/\xb0\xadtlfK\x80'\xcb{N");
  var_c0dd5d97c480023e = istrue(var_1f82e0a39c93dc49) && isDefined(intro_fx) && utility::fxexists(intro_fx);

  if(var_c0dd5d97c480023e) {
    function_9dc0d8751b89684a(intro_fx);
    wait function_7cc2b4e69f199fc3("-s\xd19o\xaf\xd9\x99<\xaf\x8c]r,t\xd2\xf67");
  }

  function_9dc0d8751b89684a(function_7cc2b4e69f199fc3("\nU\xaf\xec\x0f\x193g\x14\xd1=\x16\x9f\xea"));
  mdl_delay = function_12014776a4829ccb();
  wait mdl_delay;
  self.mesh_mdl = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
  self.mesh_mdl setModel(model_name);

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x91\x88\xc2*")) {
    self.mesh_mdl setscriptablepartstate("\x91\x88\xc2*", "\xf1\xba\x8f\x9d");
  }

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("4\xacz\xed|")) {
    self.mesh_mdl setscriptablepartstate("4\xacz\xed|", "\xb5\xe2\xd8\xcd/");
  }
}

function function_481052a391e92699(b_play_fx) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.e_trigger)) {
    self.e_trigger delete();
  }

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("\x91\x88\xc2*")) {
    self.mesh_mdl setscriptablepartstate("\x91\x88\xc2*", "\x19b\xc2y");
  } else {
    self.mesh_mdl hide();
  }

  grabbed_vfx = function_7cc2b4e69f199fc3("\xd7K3\x1b\x02\x9b\xcb\x86\x0e\xff\x12?Y\xe6\"\xe7!");
  var_f945b7758ee5fff5 = istrue(b_play_fx) && isDefined(grabbed_vfx) && utility::fxexists(grabbed_vfx);

  if(var_f945b7758ee5fff5) {
    function_9dc0d8751b89684a(grabbed_vfx);
    wait function_7cc2b4e69f199fc3("\xd9\n{\x81\x90PV\x0f]so\xc2\x8f3\x0e\xd5\xfd$7\x1b");
  }

  level callback::callback(#"hash_cde0f0b436df3f75", {
    #powerup: self
  });
  wait 0.05;
  powerup_delete();
}

function function_9dc0d8751b89684a(str_fx_name) {
  if(!isDefined(self)) {
    return;
  }

  if(!utility::fxexists(str_fx_name)) {
    return;
  }

  str_fx = utility::getfx(str_fx_name);
  stop_vfx();
  play_vfx(str_fx);
}

function stop_vfx() {
  if(isDefined(self.n_powerup_fx)) {
    stopFXOnTag(self.n_powerup_fx, self, "\xec\xbfK|\au\xcd\xc2\x19<");
    self.n_powerup_fx = undefined;
  }
}

function play_vfx(str_fx) {
  self.n_powerup_fx = playFXOnTag(str_fx, self, "\xec\xbfK|\au\xcd\xc2\x19<");
}

function function_615fbbae562bda58(powerup_name) {
  lifetime = function_af35457112dfa81b().powerups[powerup_name].var_f6cc79403ff4d4f;

  if(isDefined(level.powerup_timeout_override)) {
    lifetime = self[[level.powerup_timeout_override]](lifetime);
  }

  return lifetime;
}

function private function_12014776a4829ccb() {
  root = function_af35457112dfa81b();
  delay_min = function_7cc2b4e69f199fc3("\xc3\xc8\x9af\xcc\"\xbb\xfd\xeb^\b\xce\xa7\xc0\xf6\x89\x80\xce\x85\x82");
  delay_max = function_7cc2b4e69f199fc3("\xdb\xe1x\x1f\xad\xc1\xb4^\x10\x9fQ\a\x1d!\xbf&\x0e\x9d\x0eB");
  distance_outer = function_7cc2b4e69f199fc3("\xc6\xaa9.xC\xe7\xf0m\xe4\x84\xbd\xc2\xc2@\xc6\xe6\xdaoh4O\x950\aO\xcaY\f\x193");
  distance_inner = function_7cc2b4e69f199fc3("\xad{\x91\xb2l\xaf\x91\xc9\xb78\xeb\x19e\x8da\xf2\xf52i\x9b\x8ea\xdc\xc6+\xfain\xe6\xac\x93");

  if(istrue(root.var_17fddc55a3f94db9)) {
    return delay_min;
  }

  e_player = utility::getclosest(self.origin, level.players);

  if(!isDefined(e_player)) {
    return delay_max;
  }

  n_distance = distance(e_player.origin, self.origin);

  if(n_distance > distance_outer) {
    return delay_min;
  } else if(n_distance < distance_inner) {
    return delay_max;
  }

  n_delay = mapfloat(distance_inner, distance_outer, delay_max, delay_min, n_distance);
  return n_delay;
}

function function_c2165e3fac3afa14(var_48828fded403123e, var_5d7eece0005f8ab8) {
  return randomintrange(var_48828fded403123e, var_5d7eece0005f8ab8 + 1);
}

function function_af35457112dfa81b() {
  if(!isDefined(level.powerups_root)) {
    level.powerups_root = spawnStruct();
  }

  return level.powerups_root;
}

function function_b7e19900b14c2ade(a_params) {
  var_f49596c37417de83 = isDefined(a_params[1]) ? int(a_params[1]) : 1;
  str_powerup = a_params[0];
  root = function_af35457112dfa81b();

  if(var_f49596c37417de83) {
    offset = (0, 0, function_7cc2b4e69f199fc3("<dev string:x244>"));
    v_spawn_pos = devgui::function_e8c6c58108b35460() + offset - (0, 0, 8);

    if(isDefined(v_spawn_pos) && isDefined(function_3117e4a2c373f5e0(str_powerup))) {
      e_powerup = namespace_bc7cdace2d7445a5::droppowerupsharedfunc(str_powerup, v_spawn_pos);
    }

    return;
  }

  level.var_521a85bb48b0a5e0 = str_powerup;
}

# /