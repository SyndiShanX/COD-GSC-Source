/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_35ae72be7b4fec10.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#namespace namespace_61e6d095;

function private autoexec __init__system__() {
  system::register(#"hash_7f2a4dd4a17f2f59", &preload, undefined, undefined, undefined);
}

function private preload() {
  level.var_61e6d095 = spawnStruct();
  level.var_61e6d095.active = [];
  level.var_61e6d095.hidden = [];
  level.var_61e6d095.var_db65bf2f = [];
  level.var_61e6d095.inputs = [];
  level.var_61e6d095.inputs[# "ui_confirm"] = "confirm";
  level.var_61e6d095.inputs[# "ui_cancel"] = "cancel";
  level.var_61e6d095.inputs[# "ui_alt1"] = "alt1";
  level.var_61e6d095.inputs[# "ui_alt2"] = "alt2";
  level.var_61e6d095.inputs[# "ui_navup"] = "navup";
  level.var_61e6d095.inputs[# "ui_navdown"] = "navdown";
  level.var_61e6d095.inputs[# "ui_navleft"] = "navleft";
  level.var_61e6d095.inputs[# "ui_navright"] = "navright";
  level.var_61e6d095.inputs[# "ui_prevtab"] = "prevtab";
  level.var_61e6d095.inputs[# "ui_nexttab"] = "nexttab";
  level.var_61e6d095.inputs[# "hash_5686e6f2a8315663"] = "backspace";
  level.var_61e6d095.var_ebb98e0b = [];

  foreach(key, value in level.var_61e6d095.inputs) {
    level.var_61e6d095.var_ebb98e0b[key] = [];
    thread globallogic_ui::function_9ed5232e("ScriptedWidgetData.blockGameInput." + value, 0);
  }

  callback::add_callback(#"on_player_spawned", &on_player_spawn);
}

function on_player_spawn() {
  self endon(#"death");

  foreach(key, value in level.var_61e6d095.inputs) {
    self flag::clear(key);
  }

  while(true) {
    waitresult = self waittill(#"menuresponse");
    menu = waitresult.menu;

    if(menu == "ScriptedHudWidgetMenu" && isDefined(level.var_61e6d095.inputs[waitresult.response])) {
      self childthread flag::set_for_time(float(function_60d95f53()) / 1000 * 2, waitresult.response);
    }
  }
}

function function_affb1af1() {
  return self flag::get(#"ui_confirm");
}

function function_57fbd346() {
  return self flag::get(#"ui_cancel");
}

function function_e4d62f9a() {
  return self flag::get(#"ui_alt1");
}

function function_728aec47() {
  return self flag::get(#"ui_alt2");
}

function function_aef1e8c3() {
  return self flag::get(#"ui_navup");
}

function function_9975a94d() {
  return self flag::get(#"ui_navdown");
}

function function_c2d8a326() {
  return self flag::get(#"ui_navleft");
}

function function_3d680c10() {
  return self flag::get(#"ui_navright");
}

function function_d0beaa6e() {
  return self flag::get(#"ui_prevtab");
}

function function_1e9035e9() {
  return self flag::get(#"ui_nexttab");
}

function function_57799116() {
  return self flag::get(#"hash_5686e6f2a8315663");
}

function function_9c365c3b() {
  return function_cf2348e7(function_90d058e8(#"left_stick"));
}

function function_6cbc939b() {
  return function_cf2348e7(function_90d058e8(#"right_stick"));
}

function private function_cf2348e7(model) {
  var_b0672ef2 = getuimodel(model, #"degrees");
  var_9487f37 = getuimodel(model, #"length");
  var_f76e6210 = getuimodel(model, #"x");
  var_f1cc2bf9 = getuimodel(model, #"y");
  return {
    #degrees: getuimodelvalue(var_b0672ef2), #length: getuimodelvalue(var_9487f37), #x: getuimodelvalue(var_f76e6210), #y: getuimodelvalue(var_f1cc2bf9)
  };
}

function function_f2b01a83() {
  return function_c63f7472(function_90d058e8(#"hash_39502e607f052b14"));
}

function function_f540dc93() {
  return function_c63f7472(function_90d058e8(#"hash_25c2b6d37ccf0023"));
}

function private function_c63f7472(model) {
  var_68abddbb = getuimodel(model, #"amount");
  return getuimodelvalue(var_68abddbb);
}

function create_waypoint(uid = "waypoint", ent, image, text, offset, tag, var_7bd05154 = 1, var_754bedbb = 1, clamp = 1, var_577a0c84 = 0, progress) {
  uid = string(uid) + ent getentitynumber();
  widget_type = # "hash_14992af6bd994ba2";

  if(isDefined(progress)) {
    widget_type = # "hash_266631c3a5d0ffdb";
  }

  create(uid, widget_type);
  clear_flags(uid);

  if(isDefined(ent)) {
    set_ent(uid, ent);
  }

  if(isDefined(image)) {
    function_309bf7c2(uid, image);
  }

  if(isDefined(text)) {
    set_text(uid, text);
    set_flags(uid, 1);
  }

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  if(isDefined(tag)) {
    origin = ent.origin;

    if(isentity(ent) && is_true(var_754bedbb)) {
      origin += rotatepoint(ent getboundsmidpoint(), ent.angles);
    }

    offset = offset + ent gettagorigin(tag) - origin;
  }

  if(offset[0] != 0) {
    function_4d9fbc9d(uid, offset[0]);
  }

  if(offset[1] != 0) {
    function_52dbc715(uid, offset[1]);
  }

  if(offset[2] != 0) {
    function_60856268(uid, offset[2]);
  }

  if(is_true(clamp)) {
    function_4ef79fca(uid, clamp);
  }

  if(is_true(var_577a0c84)) {
    function_eb16868b(uid, var_577a0c84);
  }

  if(isDefined(progress)) {
    function_b1e6d7a8(uid, progress);
  }

  function_e648abd8(uid, var_754bedbb);
  function_9c3ced73(uid, var_7bd05154);
  set_state(uid, 0);
  ent function_89bba41b(uid, "offset", {
    #offset: offset
  });
  ent thread function_9718880e(uid);
  return uid;
}

function create(uid, widget_name) {
  level.var_61e6d095.active[uid] = {
    #uid: uid, #time: gettime()
  };
  function_3efa2f37(uid, "widgetName", widget_name);
  function_3efa2f37(uid, "uid", uid);
  thread function_4e406a1a();

  if(should_hide(uid)) {
    function_3efa2f37(uid, "hide", 1);
  }
}

function remove(uid) {
  arrayremoveindex(level.var_61e6d095.active, uid, 1);
  function_3abc637f(uid);
  level notify("delete_widget_" + uid);
  function_3efa2f37(uid, "widgetName", #"");
  thread function_4e406a1a();
  thread function_1b4bdb02(uid);
  globallogic_ui::function_2ec075a9("ScriptedWidgetData.widgetModels" + "." + uid, 1);
}

function remove_all() {
  level.var_61e6d095.active = [];
  level.var_61e6d095.var_2361e57e = [];
  level notify(#"hash_64a3b02565bdf75f");
  thread function_4e406a1a(1);
}

function exists(uid) {
  return isDefined(level.var_61e6d095.active[uid]);
}

function function_70217795(var_d53ecf2 = 0) {
  assert(isPlayer(self));

  if(var_d53ecf2 && !self gamepadusedlast()) {
    return self useButtonPressed();
  }

  return self function_57fbd346();
}

function function_b0bad5ff(endons, var_daf05886, var_d53ecf2 = 0) {
  assert(isPlayer(self));
  self endon(#"death");

  if(isDefined(endons)) {
    self endon(endons);
  }

  if(isDefined(var_daf05886)) {
    level endon(var_daf05886);
  }

  if(!isDefined(endons)) {
    endons = [];
  } else if(!isarray(endons)) {
    endons = array(endons);
  }

  endons[endons.size] = "request_menu_exit";

  if(!var_d53ecf2) {
    self thread block_kbm_pause_menu(endons, var_daf05886);
  }

  while(!self function_70217795(var_d53ecf2)) {
    waitframe(1);
  }

  self notify(#"request_menu_exit");
}

function block_kbm_pause_menu(endons, var_daf05886) {
  assert(isPlayer(self));
  var_753c2469 = self flag::get("block_kbm_pause_menu");
  self flag::increment("block_kbm_pause_menu");

  if(!var_753c2469) {
    self thread function_d6cfc8e9();
  }

  self thread function_5302a8d6(endons, var_daf05886);
}

function private function_d6cfc8e9() {
  self notify("3905ed56f501527e");
  self endon("3905ed56f501527e");
  self endon(#"death");
  var_4cfde9be = 1;

  while(self flag::get("block_kbm_pause_menu")) {
    is_gamepad = self gamepadusedlast();

    if(var_4cfde9be != is_gamepad || !is_gamepad && self flag::get("was_paused")) {
      setDvar(#"ui_busyblockingamemenu", !is_gamepad);
    }

    var_4cfde9be = is_gamepad;
    waitframe(1);
  }

  setDvar(#"ui_busyblockingamemenu", 0);
}

function private function_5302a8d6(var_e1d8c33c, var_b68dbe65) {
  if(!isDefined(var_e1d8c33c)) {
    var_e1d8c33c = [];
  } else if(!isarray(var_e1d8c33c)) {
    var_e1d8c33c = array(var_e1d8c33c);
  }

  var_e1d8c33c[var_e1d8c33c.size] = "death";

  if(isDefined(var_b68dbe65)) {
    self childthread function_18a00acf(var_b68dbe65);
  }

  result = self waittill(var_e1d8c33c);
  self flag::decrement("block_kbm_pause_menu");

  if(result._notify == "death") {
    setDvar(#"ui_busyblockingamemenu", 0);
  }
}

function private function_18a00acf(var_b68dbe65) {
  level waittill(var_b68dbe65);
  self notify(#"request_menu_exit");
}

function function_24e5fa63(uid, inputs, block = 1) {
  if(!isDefined(inputs)) {
    inputs = [];
  } else if(!isarray(inputs)) {
    inputs = array(inputs);
  }

  foreach(input in inputs) {
    if(isDefined(level.var_61e6d095.var_ebb98e0b[input])) {
      if(block) {
        function_78f03fef(uid, input);
        continue;
      }

      function_1b4bdb02(uid, input);
    }
  }
}

function function_e544f756(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_confirm");
    return;
  }

  function_1b4bdb02(uid, #"ui_confirm");
}

function function_29703592(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_cancel");
    return;
  }

  function_1b4bdb02(uid, #"ui_cancel");
}

function function_61d5ed40(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_alt1");
    return;
  }

  function_1b4bdb02(uid, #"ui_alt1");
}

function function_503549ff(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_alt2");
    return;
  }

  function_1b4bdb02(uid, #"ui_alt2");
}

function function_a9d2152c(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_navup");
    return;
  }

  function_1b4bdb02(uid, #"ui_navup");
}

function function_cd99f2ab(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_navdown");
    return;
  }

  function_1b4bdb02(uid, #"ui_navdown");
}

function function_46abc17c(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_navleft");
    return;
  }

  function_1b4bdb02(uid, #"ui_navleft");
}

function function_1eca647(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_navright");
    return;
  }

  function_1b4bdb02(uid, #"ui_navright");
}

function function_37cc0f71(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_prevtab");
    return;
  }

  function_1b4bdb02(uid, #"ui_prevtab");
}

function function_b2bd6ae9(uid, block = 1) {
  if(block) {
    function_78f03fef(uid, #"ui_nexttab");
    return;
  }

  function_1b4bdb02(uid, #"ui_nexttab");
}

function set_x(uid, x) {
  function_3efa2f37(uid, "x", float(x));
}

function set_y(uid, y) {
  function_3efa2f37(uid, "y", float(y));
}

function set_width(uid, width) {
  function_3efa2f37(uid, "width", float(width));
}

function set_height(uid, height) {
  function_3efa2f37(uid, "height", float(height));
}

function function_33b3b950(uid, var_b83b583) {
  function_3efa2f37(uid, "ui3dWindow", var_b83b583);
}

function set_alpha(uid, alpha) {
  function_3efa2f37(uid, "alpha", float(alpha));
}

function function_df0d7a85(var_a5a2c782, uids) {
  if(!isDefined(uids)) {
    uids = [];
  } else if(!isarray(uids)) {
    uids = array(uids);
  }

  if(!isDefined(level.var_61e6d095.hidden[var_a5a2c782])) {
    level.var_61e6d095.hidden[var_a5a2c782] = [];
  }

  foreach(uid in uids) {
    level.var_61e6d095.hidden[var_a5a2c782][uid] = uid;

    if(exists(uid)) {
      function_3efa2f37(uid, "hide", 1);
    }
  }
}

function function_f96376c5(var_a5a2c782) {
  if(isDefined(level.var_61e6d095.hidden[var_a5a2c782])) {
    uids = level.var_61e6d095.hidden[var_a5a2c782];
    arrayremoveindex(level.var_61e6d095.hidden, var_a5a2c782, 1);

    foreach(uid in uids) {
      if(exists(uid) && !should_hide(uid)) {
        function_3efa2f37(uid, "hide", 0);
      }
    }
  }
}

function function_28027c42(var_d4d3e35d, uids) {
  if(!isDefined(uids)) {
    uids = [];
  } else if(!isarray(uids)) {
    uids = array(uids);
  }

  if(!isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d])) {
    level.var_61e6d095.var_db65bf2f[var_d4d3e35d] = {};
  }

  if(!isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids)) {
    level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids = [];
  }

  foreach(uid in uids) {
    level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids[uid] = uid;
  }

  level.var_61e6d095.var_db65bf2f[var_d4d3e35d].active = 1;

  foreach(active_widget in level.var_61e6d095.active) {
    if(should_hide(active_widget.uid)) {
      function_3efa2f37(active_widget.uid, "hide", 1);
      continue;
    }

    function_3efa2f37(active_widget.uid, "hide", 0);
  }
}

function function_d3c3e5c3(uid, var_8e8cbb71) {
  if(!isDefined(var_8e8cbb71)) {
    var_8e8cbb71 = [];
  } else if(!isarray(var_8e8cbb71)) {
    var_8e8cbb71 = array(var_8e8cbb71);
  }

  any_active = 0;

  foreach(var_d4d3e35d in var_8e8cbb71) {
    if(!isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d])) {
      level.var_61e6d095.var_db65bf2f[var_d4d3e35d] = {};
    }

    if(!isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids)) {
      level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids = [];
    }

    level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids[uid] = uid;
    any_active = any_active || is_true(level.var_61e6d095.var_db65bf2f[var_d4d3e35d].active);
  }

  if(any_active) {
    if(should_hide(uid)) {
      function_3efa2f37(uid, "hide", 1);
      return;
    }

    function_3efa2f37(uid, "hide", 0);
  }
}

function function_3abc637f(uid, var_d4d3e35d) {
  if(isDefined(var_d4d3e35d)) {
    if(isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d])) {
      arrayremoveindex(level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids, uid, 1);

      if(!is_true(level.var_61e6d095.var_db65bf2f[var_d4d3e35d].active) && level.var_61e6d095.var_db65bf2f[var_d4d3e35d].uids.size == 0) {
        arrayremoveindex(level.var_61e6d095.var_db65bf2f, var_d4d3e35d, 1);
      }
    }
  } else {
    foreach(ref, exceptions in level.var_61e6d095.var_db65bf2f) {
      arrayremoveindex(exceptions.uids, uid, 1);

      if(!is_true(exceptions.active) && exceptions.uids.size == 0) {
        arrayremoveindex(level.var_61e6d095.var_db65bf2f, ref, 1);
      }
    }
  }

  if(isDefined(level.var_61e6d095.active[uid])) {
    if(should_hide(uid)) {
      function_3efa2f37(uid, "hide", 1);
      return;
    }

    function_3efa2f37(uid, "hide", 0);
  }
}

function function_4279fd02(var_d4d3e35d) {
  if(isDefined(level.var_61e6d095.var_db65bf2f[var_d4d3e35d])) {
    level.var_61e6d095.var_db65bf2f[var_d4d3e35d].active = 0;

    foreach(active_widget in level.var_61e6d095.active) {
      if(should_hide(active_widget.uid)) {
        function_3efa2f37(active_widget.uid, "hide", 1);
        continue;
      }

      function_3efa2f37(active_widget.uid, "hide", 0);
    }
  }
}

function should_hide(uid) {
  foreach(uids in level.var_61e6d095.hidden) {
    if(isDefined(uids[uid])) {
      return 1;
    }
  }

  var_bbf85716 = 0;

  if(level.var_61e6d095.var_db65bf2f.size > 0) {
    foreach(var_7db9f8e9 in level.var_61e6d095.var_db65bf2f) {
      if(is_true(var_7db9f8e9.active)) {
        var_bbf85716 = 1;

        if(isDefined(var_7db9f8e9.uids[uid])) {
          return 0;
        }
      }
    }
  }

  return var_bbf85716;
}

function function_73c9a490(uid, focus) {
  function_3efa2f37(uid, "focus", focus);
}

function function_46df0bc7(uid, priority) {
  function_3efa2f37(uid, "priority", priority);
}

function set_scale(uid, scale) {
  function_3efa2f37(uid, "scale", float(scale));
}

function function_39710437(uid, var_e93ee030) {
  assert(var_e93ee030 == "<dev string:x38>" || var_e93ee030 == "<dev string:x46>" || var_e93ee030 == "<dev string:x52>", "<dev string:x59>");
  function_3efa2f37(uid, "sizeto", var_e93ee030);
}

function set_text(uid, text) {
  function_3efa2f37(uid, "text", text);
}

function function_bfdab223(uid, text, var_80d5359e = 0) {
  function_3efa2f37(uid, "desc", text, var_80d5359e);
}

function function_e11447eb(uid, button_text) {
  function_3efa2f37(uid, "button_text", button_text);
}

function function_309bf7c2(uid, image) {
  function_3efa2f37(uid, "image", image);
}

function set_color(uid, red, green, blue) {
  function_3efa2f37(uid, "color", red + " " + green + " " + blue);
}

function set_time(uid, time) {
  function_3efa2f37(uid, "time", float(time));
}

function set_timer(uid, time, countdown = 1) {
  time = int(time * 1000);

  if(countdown) {
    function_89bba41b(uid, "timer", {
      #time: time, #goal_time: 0
    });
  } else {
    start_time = 0;
    var_f2f8de51 = function_8db2364c(uid, "timer");

    if(isDefined(var_f2f8de51)) {
      start_time = var_f2f8de51.time;
    }

    function_89bba41b(uid, "timer", {
      #time: start_time, #goal_time: time
    });
  }

  thread update_timer(uid);
}

function pause_timer(uid) {
  var_f2f8de51 = function_8db2364c(uid, "timer");

  if(isDefined(var_f2f8de51)) {
    var_f2f8de51.paused = 1;
  }
}

function function_f3dcb134(uid) {
  var_f2f8de51 = function_8db2364c(uid, "timer");

  if(isDefined(var_f2f8de51)) {
    var_f2f8de51.paused = 0;
  }
}

function clear_timer(uid) {
  function_4ac40e40(uid, "timer");
  clear_flags(uid, 3);
}

function private update_timer(uid) {
  level notify("update_timer_" + uid);
  level endon("update_timer_" + uid, "delete_widget_" + uid, "scripted_widget_data_removed_timer_" + uid, #"hash_64a3b02565bdf75f");
  set_flags(uid, 3);

  while(true) {
    timer = function_8db2364c(uid, "timer");
    set_time(uid, timer.time);

    if(!is_true(timer.paused)) {
      if(timer.goal_time == 0) {
        timer.time = int(max(timer.time - function_60d95f53(), timer.goal_time));
      } else {
        timer.time = int(min(timer.time + function_60d95f53(), timer.goal_time));
      }
    }

    waitframe(1);
  }
}

function set_distance(uid, distance) {
  function_3efa2f37(uid, "distance", distance);
}

function function_283c7712(uid, ent, var_7c7535b4 = 0.0254) {
  function_89bba41b(uid, "distance", {
    #ent: ent, #var_7c7535b4: var_7c7535b4
  });
  thread function_c6d1cf1f(uid);
}

function function_8a843e00(uid) {
  function_4ac40e40(uid, "distance");
  clear_flags(uid, 2);
}

function private function_c6d1cf1f(uid) {
  level notify("update_distance_" + uid);
  level endon("update_distance_" + uid, "delete_widget_" + uid, "scripted_widget_data_removed_distance_" + uid, #"hash_64a3b02565bdf75f");
  player = getplayers()[0];
  player endon(#"death");
  set_flags(uid, 2);
  offset = self function_8db2364c(uid, "offset");

  if(isDefined(offset)) {
    offset = offset.offset;
  }

  while(true) {
    var_9941a398 = function_8db2364c(uid, "distance");
    ent = var_9941a398.ent;
    var_7f3f225e = player getplayercamerapos();
    ent_pos = ent.origin;

    if(isentity(ent)) {
      ent_pos += rotatepoint(ent getboundsmidpoint(), ent.angles);
    }

    if(isDefined(offset)) {
      ent_pos += rotatepoint(offset, ent.angles);
    }

    dist = distance(var_7f3f225e, ent_pos) * var_9941a398.var_7c7535b4;
    set_distance(uid, dist);
    waitframe(1);
  }
}

function set_count(uid, count, var_80d5359e = 0) {
  function_3efa2f37(uid, "count", count, var_80d5359e);
}

function function_b1e6d7a8(uid, fraction, var_80d5359e = 0) {
  function_3efa2f37(uid, "fraction", float(fraction), var_80d5359e);
}

function set_state(uid, state) {
  function_3efa2f37(uid, "state", state);
}

function function_f942c3ed(uid, clip) {
  function_3efa2f37(uid, "clip", clip);
}

function set_flags(uid, flags, var_10e09b46 = 0) {
  var_b89f8baa = function_82e355ff(uid, "flags");
  var_c2e076fc = function_bfbe6ac6(flags, var_b89f8baa, var_10e09b46);
  function_3efa2f37(uid, "flags", var_c2e076fc);
}

function clear_flags(uid, flags, var_10e09b46 = 0) {
  var_b89f8baa = isDefined(function_82e355ff(uid, "flags")) ? function_82e355ff(uid, "flags") : 0;
  var_c2e076fc = function_1a20b94a(flags, var_b89f8baa, var_10e09b46);
  function_3efa2f37(uid, "flags", var_c2e076fc);
}

function set_data(uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51) {
  function_3efa2f37(uid, "data" + "." + name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51);
}

function get_data(uid, name) {
  function_80157d8(uid, "data" + "." + name);
}

function clear_data(uid, name, var_c15ae58d) {
  globallogic_ui::function_2ec075a9("ScriptedWidgetData.widgetModels" + "." + uid + "." + "data" + "." + name, var_c15ae58d);
}

function function_9ade1d9b(uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51) {
  function_3efa2f37(uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51);
}

function function_f7c4c669(uid, name) {
  return function_82e355ff(uid, name);
}

function function_43525bc6(uid, name, var_c15ae58d) {
  globallogic_ui::function_2ec075a9("ScriptedWidgetData.widgetModels" + "." + uid + "." + name, var_c15ae58d);
}

function function_330981ed(uid, list_name = "list") {
  function_3efa2f37(uid, list_name);
  thread function_57d676db(uid, list_name);
}

function function_f2a9266(uid, index, name, value, list_name = "list", force) {
  if(isDefined(index) && !isDefined(function_80157d8(uid, list_name + "." + index))) {
    function_3efa2f37(uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name);
  }

  if(isarray(value)) {
    var_d9cf51e8 = list_name;

    if(isDefined(index)) {
      var_d9cf51e8 = list_name + "." + index + "." + list_name;
    }

    foreach(i, v in value) {
      function_f2a9266(uid, i, name, v, var_d9cf51e8, force);
    }
  } else if(isstruct(value)) {
    assert(isDefined(value.names) && isDefined(value.data), "<dev string:xd7>");

    foreach(i, v in value.data) {
      function_f2a9266(uid, index, value.names[i], v, list_name, force);
    }
  } else {
    function_3efa2f37(uid, list_name + "." + index + "." + name, value, force, undefined, undefined, undefined, list_name);
  }

  thread function_57d676db(uid, list_name);
}

function function_ce8141d4(uid, index, name, list_name = "list") {
  return function_82e355ff(uid, list_name + "." + index + "." + name);
}

function function_9bc1d2f1(uid, index, flags, var_10e09b46 = 0, model_name = "flags", list_name = "list") {
  if(!isDefined(function_80157d8(uid, list_name + "." + index))) {
    function_3efa2f37(uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name);
  }

  var_b89f8baa = function_82e355ff(uid, list_name + "." + index + "." + model_name);
  var_c2e076fc = function_bfbe6ac6(flags, var_b89f8baa, var_10e09b46);
  function_3efa2f37(uid, list_name + "." + index + "." + model_name, var_c2e076fc, undefined, undefined, undefined, undefined, list_name);
  thread function_57d676db(uid, list_name);
}

function function_e8c19a33(uid, index, flags, var_10e09b46 = 0, model_name = "flags", list_name = "list") {
  if(!isDefined(function_80157d8(uid, list_name + "." + index))) {
    function_3efa2f37(uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name);
  }

  var_b89f8baa = function_82e355ff(uid, list_name + "." + index + "." + model_name);
  var_c2e076fc = function_1a20b94a(flags, var_b89f8baa, var_10e09b46);
  function_3efa2f37(uid, list_name + "." + index + "." + model_name, var_c2e076fc, undefined, undefined, undefined, undefined, list_name);
  thread function_57d676db(uid, list_name);
}

function function_7239e030(uid, index, list_name = "list") {
  if(globallogic_ui::function_6db5e620("ScriptedWidgetData.widgetModels" + "." + uid + "." + list_name, index)) {
    thread function_57d676db(uid, list_name);
  }
}

function function_cd59371c(uid, index, list_name = "list") {
  return isDefined(function_80157d8(uid, list_name + "." + index));
}

function set_ent(uid, ent) {
  if(isstruct(ent) || ent.classname === "script_origin") {
    function_3efa2f37(uid, "entNum", worldentnumber());

    if(isDefined(self.origin)) {
      function_4d9fbc9d(uid, ent.origin[0]);
      function_52dbc715(uid, ent.origin[1]);
      function_60856268(uid, ent.origin[2]);
      function_9c3ced73(uid, 1);
    }

    return;
  }

  function_3efa2f37(uid, "entNum", ent getentitynumber());
  ent thread delete_on_death(uid);
}

function function_4d9fbc9d(uid, x_offset) {
  function_3efa2f37(uid, "xOffset", x_offset);
}

function function_52dbc715(uid, y_offset) {
  function_3efa2f37(uid, "yOffset", y_offset);
}

function function_60856268(uid, z_offset) {
  function_3efa2f37(uid, "zOffset", z_offset);
}

function function_4ef79fca(uid, clamp) {
  function_3efa2f37(uid, "clamp", clamp);
}

function function_eb16868b(uid, var_9524359a) {
  function_3efa2f37(uid, "distanceScale", var_9524359a);
}

function function_e648abd8(uid, var_754bedbb) {
  function_3efa2f37(uid, "useMidpoint", var_754bedbb);
}

function function_8aa0007(uid, tag) {
  function_3efa2f37(uid, "boneTag", tag);
}

function function_9c3ced73(uid, var_7bd05154) {
  function_3efa2f37(uid, "useLocalOffset", var_7bd05154);
}

function function_fdb73881(uid, close_dist = 500, far_dist = 1000, var_bc8ff11 = 1, var_6d219ab3 = 0) {
  function_89bba41b(uid, "fade_dist", {
    #close_dist: close_dist, #far_dist: far_dist, #var_bc8ff11: var_bc8ff11, #var_6d219ab3: var_6d219ab3
  });
}

function function_c3fbdd4(uid, far_dist = 393.7, var_3a142f52 = 0, var_d7e44381 = 1, var_e23f7d1e = 2, var_1f1b932b) {
  function_89bba41b(uid, "dist_states", {
    #far_dist: far_dist, #var_3a142f52: var_3a142f52, #var_d7e44381: var_d7e44381, #var_e23f7d1e: var_e23f7d1e, #var_1f1b932b: var_1f1b932b
  });
}

function function_d3533603(uid, enable, ignore_ent) {
  if(enable) {
    function_89bba41b(uid, "occlusion", {
      #ignore_ent: ignore_ent
    });
    return;
  }

  function_4ac40e40(uid, "occlusion");
  clear_flags(uid, 0);
}

function private function_9718880e(uid) {
  level endon("delete_widget_" + uid, #"hash_64a3b02565bdf75f");
  level waittill("scripted_widget_data_set_" + uid);
  player = getplayers()[0];
  offset = function_8db2364c(uid, "offset").offset;

  while(isDefined(player)) {
    dist = undefined;
    alpha = undefined;
    fade_dist = function_8db2364c(uid, "fade_dist");
    occlusion = function_8db2364c(uid, "occlusion");
    dist_states = function_8db2364c(uid, "dist_states");
    var_7f3f225e = player getplayercamerapos();
    ent_pos = self.origin;

    if(isentity(self)) {
      ent_pos += rotatepoint(self getboundsmidpoint(), self.angles);
    }

    if(offset != (0, 0, 0)) {
      ent_pos += rotatepoint(offset, self.angles);
    }

    if(isDefined(fade_dist)) {
      if(!isDefined(dist)) {
        dist = distance(var_7f3f225e, ent_pos);
      }

      alpha = lerpfloat(fade_dist.var_bc8ff11, fade_dist.var_6d219ab3, lerpfloat(0, 1, (dist - fade_dist.close_dist) / (fade_dist.far_dist - fade_dist.close_dist)));
    }

    if(isDefined(dist_states)) {
      if(!isDefined(dist)) {
        dist = distance(var_7f3f225e, ent_pos);
      }

      if(dist > dist_states.far_dist) {
        set_state(uid, dist_states.var_3a142f52);
      } else if(!is_true(function_82e355ff(uid, "clamped"))) {
        focused = 0;

        if(isDefined(dist_states.var_1f1b932b)) {
          player_dir = anglesToForward(player getplayerangles());
          var_52be356a = vectornormalize(ent_pos - var_7f3f225e);

          if(vectordot(player_dir, var_52be356a) >= dist_states.var_1f1b932b) {
            set_state(uid, dist_states.var_e23f7d1e);
            focused = 1;
          }
        }

        if(!focused) {
          set_state(uid, dist_states.var_d7e44381);
        }
      }
    }

    if(isDefined(occlusion) && (!isDefined(alpha) || alpha > 0)) {
      if(!sighttracepassed(ent_pos, var_7f3f225e, 0, self, occlusion.ignore_ent)) {
        set_flags(uid, 0);
      } else {
        clear_flags(uid, 0);
      }
    } else if(isDefined(alpha)) {
      set_alpha(uid, alpha);
    }

    waitframe(1);
  }
}

function private function_89bba41b(uid, key, data) {
  if(!isDefined(level.var_2e036148)) {
    level.var_2e036148 = [];
  }

  if(!isDefined(level.var_2e036148[uid])) {
    level.var_2e036148[uid] = [];
  }

  level.var_2e036148[uid][key] = data;
  level notify("scripted_widget_data_set_" + uid);
  level thread function_dc5c6710(uid);
}

function private function_8db2364c(uid, var_14d09bc7) {
  if(level flag::get("level_restarting")) {
    return undefined;
  }

  assert(isDefined(level.var_2e036148) && isDefined(level.var_2e036148[uid]), "<dev string:x135>" + uid);
  return level.var_2e036148[uid][var_14d09bc7];
}

function private function_4ac40e40(uid, var_14d09bc7) {
  if(level flag::get("level_restarting")) {
    return undefined;
  }

  assert(isDefined(level.var_2e036148) && isDefined(level.var_2e036148[uid]), "<dev string:x176>" + uid);
  level notify("scripted_widget_data_removed_" + var_14d09bc7 + "_" + uid);
  level.var_2e036148[uid][var_14d09bc7] = undefined;
}

function private function_3efa2f37(uid, model, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51, list_name) {
  if(model != "widgetName") {
    if(!exists(uid)) {
      if(!level flag::get("restoring_ui_models") && !level flag::get("level_restarting")) {
        assertmsg("<dev string:x1ba>" + model + "<dev string:x1e6>" + uid + "<dev string:x1ef>");
      }

      return;
    }
  }

  if(isDefined(level.var_61e6d095.active[uid]) && gettime() > level.var_61e6d095.active[uid].time && !isDefined(function_80157d8(uid, model)) && (!isDefined(list_name) || !isDefined(function_80157d8(uid, list_name + "Update")))) {
    thread function_2b815b7(uid);
  }

  globallogic_ui::function_9ed5232e("ScriptedWidgetData.widgetModels" + "." + uid + "." + model, value, undefined, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51);
}

function function_82e355ff(uid, model) {
  return globallogic_ui::function_f053dcd4("ScriptedWidgetData.widgetModels" + "." + uid + "." + model);
}

function private function_80157d8(uid, model) {
  return globallogic_ui::function_5b3d23d5("ScriptedWidgetData.widgetModels" + "." + uid + "." + model);
}

function private function_4e406a1a(reset = 0) {
  if(level flag::get("level_restarting") && !reset) {
    return;
  }

  while(!isDefined(globallogic_ui::function_5b3d23d5("ScriptedWidgetData.update", 0))) {
    level endon(#"hash_64a3b02565bdf75f");
    waitframe(1);
  }

  globallogic_ui::function_9ed5232e("ScriptedWidgetData.update", !reset, 0, 1, undefined, undefined, 1, reset);
}

function private function_2b815b7(uid) {
  level notify("update_widget_subscriptions_" + uid);
  level endon("update_widget_subscriptions_" + uid);
  globallogic_ui::function_9ed5232e("ScriptedWidgetData.widgetModels" + "." + uid + "." + "update_subscriptions", 1, undefined, 1, 0, 0, 1);
}

function private function_57d676db(uid, list_name) {
  if(exists(uid)) {
    globallogic_ui::function_9ed5232e("ScriptedWidgetData.widgetModels" + "." + uid + "." + list_name + "Update", 1, 0, 1, undefined, undefined, 1);
  }
}

function private function_dc5c6710(uid) {
  self notify("cleanup_widget_data_" + uid);
  self endon("cleanup_widget_data_" + uid);
  level waittill("delete_widget_" + uid, #"hash_64a3b02565bdf75f");

  if(isDefined(self.var_2e036148)) {
    self.var_2e036148[uid] = undefined;
  }
}

function delete_on_death(uid) {
  self notify("delete_on_death_" + uid);
  self endon("delete_on_death_" + uid);
  level endon("delete_widget_" + uid, #"hash_64a3b02565bdf75f");
  self waittill(#"death");
  thread remove(uid);
}

function private function_bfbe6ac6(flags, var_b89f8baa, var_10e09b46 = 0) {
  var_c2e076fc = flags;

  if(!var_10e09b46) {
    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    var_c2e076fc = 0;

    foreach(flag in flags) {
      var_c2e076fc |= 1 << flag;
    }
  }

  if(isDefined(var_b89f8baa)) {
    var_c2e076fc |= var_b89f8baa;
  }

  return var_c2e076fc;
}

function private function_1a20b94a(flags, var_b89f8baa = 0, var_10e09b46 = 0) {
  var_c2e076fc = var_b89f8baa;

  if(!var_10e09b46) {
    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    foreach(flag in flags) {
      var_c2e076fc &= ~(1 << flag);
    }
  } else {
    var_c2e076fc &= ~flags;
  }

  return var_c2e076fc;
}

function function_e13a1a9c(grid_size, var_39359c1e, var_92c0faf8, cancel_callback, var_942056ea, var_daf05886, var_bd8024b5, var_26759105, var_1da0c034) {
  player = self;
  assert(isPlayer(player));
  assert(isarray(grid_size) && grid_size.size == 2);
  assert(!isDefined(var_1da0c034) || isarray(var_1da0c034) && var_1da0c034.size == 2);

  if(isDefined(var_daf05886)) {
    level endon(var_daf05886);
  }

  if(isDefined(var_bd8024b5)) {
    player endon(var_bd8024b5);
  }

  var_bc6e33ce = [0, 0];
  var_dd82beda = [0, 0];
  var_768a0348 = [-1, -1];
  new_indices = isDefined(var_1da0c034) ? var_1da0c034 : [0, 0];
  player function_2947fddf(var_768a0348, new_indices, grid_size, var_39359c1e, var_942056ea);

  while(true) {
    if(isDefined(var_92c0faf8) && self function_affb1af1()) {
      var_75843d9b = player[[var_92c0faf8]](var_768a0348, var_942056ea);

      if(is_true(var_75843d9b)) {
        break;
      }
    }

    if(isDefined(cancel_callback) && self function_57fbd346()) {
      player[[cancel_callback]](var_942056ea);
      break;
    }

    var_e73a18ff = player function_9c365c3b();

    for(var_ea37ba57 = 0; var_ea37ba57 < 2; var_ea37ba57++) {
      new_indices[var_ea37ba57] = var_768a0348[var_ea37ba57];
      var_edeb0521 = 0;

      if(var_ea37ba57 == 0) {
        var_edeb0521 = var_e73a18ff.y;
      } else {
        var_edeb0521 = var_e73a18ff.x;
      }

      var_edeb0521 = util::function_b5338ccb(var_edeb0521, 0.2);

      if(var_ea37ba57 == 0) {
        var_edeb0521 *= -1;
      }

      var_8d765541 = 0;

      if(var_edeb0521 == 0) {
        var_8d765541 = function_ec6ae51a(var_ea37ba57);
      } else if(var_edeb0521 > 0) {
        var_8d765541 = 1;
      } else {
        var_8d765541 = -1;
      }

      if(var_8d765541 == 0) {
        var_dd82beda[var_ea37ba57] = 0;
        continue;
      }

      var_691ec9a7 = var_dd82beda[var_ea37ba57] != var_8d765541;
      var_3e9543e8 = !var_691ec9a7 && gettime() - var_bc6e33ce[var_ea37ba57] > 250;

      if(var_691ec9a7 || var_3e9543e8) {
        var_bc6e33ce[var_ea37ba57] = gettime();
        var_dd82beda[var_ea37ba57] = var_8d765541;
        new_indices[var_ea37ba57] = var_768a0348[var_ea37ba57] + var_8d765541;
        new_indices[var_ea37ba57] = function_d43d9448(new_indices[var_ea37ba57], grid_size[var_ea37ba57], var_26759105);
      }
    }

    player function_2947fddf(var_768a0348, new_indices, grid_size, var_39359c1e, var_942056ea, var_26759105);
    waitframe(1);
  }
}

function private function_d43d9448(index, list_size, var_26759105) {
  min = 0;
  max = list_size - 1;

  if(is_true(var_26759105)) {
    if(index < min) {
      index = max;
    } else if(index > max) {
      index = min;
    }
  } else if(index < min) {
    index = min;
  } else if(index > max) {
    index = max;
  }

  return index;
}

function private function_2947fddf(&var_768a0348, new_indices, grid_size, callback, var_942056ea, var_26759105) {
  player = self;

  if(new_indices[0] != var_768a0348[0] || new_indices[1] != var_768a0348[1]) {
    var_14639e4f = player[[callback]](var_768a0348, new_indices, var_942056ea);

    for(var_ea37ba57 = 0; var_ea37ba57 < 2; var_ea37ba57++) {
      var_768a0348[var_ea37ba57] = new_indices[var_ea37ba57];

      if(isDefined(var_14639e4f)) {
        var_768a0348[var_ea37ba57] = function_d43d9448(var_14639e4f[var_ea37ba57], grid_size[var_ea37ba57], var_26759105);
      }
    }
  }
}

function private function_ec6ae51a(var_ea37ba57) {
  player = self;
  var_8d765541 = 0;

  if(var_ea37ba57 == 0) {
    if(function_aef1e8c3() || player forwardbuttonPressed()) {
      var_8d765541 = -1;
    } else if(function_9975a94d() || player backbuttonPressed()) {
      var_8d765541 = 1;
    }
  } else if(var_ea37ba57 == 1) {
    if(function_3d680c10() || player moverightbuttonPressed()) {
      var_8d765541 = 1;
    } else if(function_c2d8a326() || player moveleftbuttonPressed()) {
      var_8d765541 = -1;
    }
  }

  return var_8d765541;
}

function private function_78f03fef(uid, input) {
  var_2361e57e = level.var_61e6d095.var_ebb98e0b[input];

  if(!isinarray(var_2361e57e, uid)) {
    var_2361e57e[var_2361e57e.size] = uid;
    globallogic_ui::function_9ed5232e("ScriptedWidgetData.blockGameInput." + level.var_61e6d095.inputs[input], 1);
  }
}

function private function_1b4bdb02(uid, inputs) {
  if(isDefined(inputs)) {
    if(!isDefined(inputs)) {
      inputs = [];
    } else if(!isarray(inputs)) {
      inputs = array(inputs);
    }
  } else {
    inputs = getarraykeys(level.var_61e6d095.inputs);
  }

  var_ebb98e0b = level.var_61e6d095.var_ebb98e0b;

  foreach(input in inputs) {
    var_ef0e4b33 = var_ebb98e0b[input].size;
    arrayremovevalue(var_ebb98e0b[input], uid, 1);

    if(var_ef0e4b33 && var_ebb98e0b[input].size == 0) {
      globallogic_ui::function_9ed5232e("ScriptedWidgetData.blockGameInput." + level.var_61e6d095.inputs[input], 0);
    }
  }
}