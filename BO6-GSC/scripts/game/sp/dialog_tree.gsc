/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\dialog_tree.gsc
*******************************************/

#using script_39b1f0d056a0c138;
#using scripts\anim\dialogue;
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace dialog_tree;

function autoexec function_946cb62acc3f9388() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  setdvarifuninitialized(@ "hash_77bc411a1f18c6ef", 0);

  level.var_93d89c08e78d9ba1 = [];
  level.var_93d89c08e78d9ba1["\r+x5"] = undefined;
  level.var_93d89c08e78d9ba1["\t\xbc\xcb\x17\xb2\xcd\a\n \x86A"] = 55;
  level.var_93d89c08e78d9ba1["=\xacw\xee"] = 45;
  level.var_93d89c08e78d9ba1["\x15Z\xde,\x82j\xb1\xee\xa9"] = 35;
  level.var_93d89c08e78d9ba1["\xef\xd0v\xbc<\xbc\xa7F\x81\x0f\xfd\x8a"] = 25;
  level.var_a500b574468ac0b = [];
  level.var_f840041b4be441b["sh\xbc\ru"] = 1;
  level.var_f840041b4be441b["w=&\x15\xbd\xae"] = 2.8;
  level.var_d748ffb39eddcf85 = getdvarfloat(@ "cg_fov");
  level.player thread function_2a2a96feb468203b();
  utility::flag_init("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16");
  utility::flag_init("|&\xea\x18~O\xf2\x1earq\xbf\x1a\xb6\x9b\x15");
  ui::lui_registercallback("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", &function_aa8e42a9bc2d9b12);
  ui::lui_registercallback("-\x80\x9f\xf4zG\xc7\xb7\xbb\x15J<4\xfd@\v/H\x95\x96\xc9G\xf7~", &function_53f70b0a39a5e864);
}

function new_tree(enter_func, exit_func, allow_movement = 0, allow_weapon = 0, script_bundle, var_3773a34ab2d41dc8 = 1, timeout = 0, skippable = 1, force_headlook = 0, param_ref = "\x11\xca\xcc\v\xab\xd8:") {
  new_dialog = spawnStruct();
  new_dialog.selected_options = 0;
  new_dialog.player_pos = [];
  new_dialog.enter_func = enter_func;
  new_dialog.exit_func = exit_func;
  new_dialog.allow_movement = allow_movement;
  new_dialog.allow_weapon = allow_weapon;
  new_dialog.var_3773a34ab2d41dc8 = var_3773a34ab2d41dc8;
  new_dialog.timeout = timeout;
  new_dialog.skippable = skippable;
  new_dialog.force_headlook = force_headlook;
  new_dialog.var_16468517a29ad26f = 0;
  new_dialog.param_ref = param_ref;
  new_dialog.options = [];
  new_dialog.position = {
    #vertalign: 2, #horzalign: 2, #vertoffset: -260, #horzoffset: -240
  };
  new_dialog.state_index = 0;
  new_dialog.temp_disabled = 0;
  new_dialog.var_7a1a08ae68f6b825 = &"t10_dialog_tree/not_safe_for_conversation";
  new_dialog set_scriptbundle(script_bundle);
  new_dialog.var_a62c714dc1f94a6b = 0;
  return new_dialog;
}

function set_scriptbundle(bundle, default_idle, include_actors) {
  if(isDefined(bundle)) {
    if(isstring(bundle)) {
      self.scriptbundle = bundle;
    } else if(isDefined(bundle.script_scenescriptbundle)) {
      self.scriptbundle = bundle.script_scenescriptbundle;
    } else {
      assert("<dev string:x24>" + bundle);
    }

    self.var_815ff889bee59756 = default_idle;
  }

  if(isDefined(include_actors)) {
    if(!isarray(include_actors)) {
      include_actors = [include_actors];
    }

    self.include_actors = include_actors;
  }
}

function function_c1f5c55efdef71bd(template_name, player_positions) {
  namespace_6f793d3cf96d68f::function_54cd64e94d7d35f(template_name);
  self.anim_template = template_name;
  self.var_b82409fa4c439a37 = player_positions;
  self.template_struct = spawnStruct();
}

function add_option(option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  if(!isDefined(end_dialog)) {
    end_dialog = 0;
  }

  option = function_d2606160ea42614a(undefined, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, undefined, selected_func, func_parameter, skip_func);
  return function_6ed554c2f446e515(option);
}

function function_c8966ea98379d904(var_f31b5aee30ec24ce, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  option = function_d2606160ea42614a(undefined, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, var_f31b5aee30ec24ce, selected_func, func_parameter, skip_func);
  return function_6ed554c2f446e515(option);
}

function function_1437db552bb0a1fa(expire_count, expire_flag, reset, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  if(!isDefined(reset)) {
    reset = 1;
  }

  option = function_d2606160ea42614a(undefined, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, undefined, selected_func, func_parameter, skip_func, 0, expire_count, expire_flag, reset);
  return function_6ed554c2f446e515(option);
}

function function_16def926f6fa509a(option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  var_68f95564fff485c0 = self.options.size - 1;
  option = function_d2606160ea42614a(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_6ed554c2f446e515(option);
}

function function_648cfc1fe90b0ba7(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  option = function_d2606160ea42614a(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_6ed554c2f446e515(option);
}

function function_345113f70bd2db8d(var_f31b5aee30ec24ce, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  var_68f95564fff485c0 = self.options.size - 1;
  option = function_d2606160ea42614a(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, var_f31b5aee30ec24ce, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_6ed554c2f446e515(option);
}

function function_5836e05a7a52282e(var_68f95564fff485c0, var_f31b5aee30ec24ce, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  option = function_d2606160ea42614a(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, var_f31b5aee30ec24ce, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_6ed554c2f446e515(option);
}

function function_7e53cd2c49461b3c(var_68f95564fff485c0, expire_count, expire_flag, reset, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, selected_func, func_parameter, skip_func) {
  if(!isDefined(reset)) {
    reset = 1;
  }

  option = function_d2606160ea42614a(var_68f95564fff485c0, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, undefined, selected_func, func_parameter, skip_func, 0, expire_count, expire_flag, reset);
  option.active = 0;
  return function_6ed554c2f446e515(option);
}

function function_486db37d1e88eabf(option_id, end_dialog = 1) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].end_dialog = end_dialog;
}

function function_6ae7b9dd8ec84859(option_id, quick_exit = 1) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].end_dialog = 1;
  self.options[option_id].quick_exit = quick_exit;
}

function function_44f9ed019ff9d167(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].pin_bottom = 1;
  self.var_16468517a29ad26f = 1;
}

function function_958e4c859009a022(flag_array, option_id) {
  option_id = function_b94652ed3f3e44cf(option_id);
  assert(!isDefined(self.options[option_id].var_78e97cdd5117c2bd) && !isDefined(self.options[option_id].var_d3f8428a96158f79), "<dev string:x68>");
  self.options[option_id].locked = 1;

  if(isarray(flag_array)) {
    self.options[option_id].var_78e97cdd5117c2bd = flag_array;
    return;
  }

  self.options[option_id].var_78e97cdd5117c2bd = [flag_array];
}

function function_f6f4279b98717bc4(flag_array, option_id) {
  option_id = function_b94652ed3f3e44cf(option_id);
  assert(!isDefined(self.options[option_id].var_78e97cdd5117c2bd) && !isDefined(self.options[option_id].var_d3f8428a96158f79), "<dev string:xbf>");
  self.options[option_id].locked = 1;

  if(isarray(flag_array)) {
    self.options[option_id].var_d3f8428a96158f79 = flag_array;
    return;
  }

  self.options[option_id].var_d3f8428a96158f79 = [flag_array];
}

function function_96c29424f6588e58(flag_array, option_id) {
  option_id = function_b94652ed3f3e44cf(option_id);
  assert(!isDefined(self.options[option_id].var_8988090b1a8ff0e8) && !isDefined(self.options[option_id].var_a26e7cfa32e1d65e), "<dev string:x115>");

  if(isarray(flag_array)) {
    self.options[option_id].var_8988090b1a8ff0e8 = flag_array;
    return;
  }

  self.options[option_id].var_8988090b1a8ff0e8 = [flag_array];
}

function function_5550794c771a77ae(flag_array, option_id) {
  option_id = function_b94652ed3f3e44cf(option_id);
  assert(!isDefined(self.options[option_id].var_8988090b1a8ff0e8) && !isDefined(self.options[option_id].var_a26e7cfa32e1d65e), "<dev string:x16b>");

  if(isarray(flag_array)) {
    self.options[option_id].var_a26e7cfa32e1d65e = flag_array;
    return;
  }

  self.options[option_id].var_a26e7cfa32e1d65e = [flag_array];
}

function function_c8d1d52ed43df841(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].important = 1;
}

function function_90a2fe6effc45433(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].var_5de507950b974d43 = 1;
}

function function_31d914d0387e8310(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].show_locked = 1;
}

function function_60c62b80be090077(option_id, var_e60c64e1d6089514, cycle_style, vo_lines, anims) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  if(!isDefined(var_e60c64e1d6089514)) {
    var_e60c64e1d6089514 = 0;
  }

  if(!isDefined(cycle_style)) {
    cycle_style = "\xd0\xce\x88\x9e";
  }

  if(!isDefined(vo_lines)) {
    vo_lines = 1;
  }

  if(!isDefined(anims)) {
    anims = 1;
  }

  self.options[option_id].cycle_style = cycle_style;

  if(vo_lines) {
    if(isDefined(self.options[option_id].vo_npc)) {
      if(!isarray(self.options[option_id].vo_npc)) {
        self.options[option_id].vo_npc = [self.options[option_id].vo_npc];
      }

      if(var_e60c64e1d6089514) {
        self.options[option_id].cur_vo = randomint(self.options[option_id].vo_npc.size);
      } else {
        self.options[option_id].cur_vo = 0;
      }
    }
  }

  if(anims) {
    if(isDefined(self.options[option_id].anim_npc)) {
      if(!isarray(self.options[option_id].anim_npc)) {
        self.options[option_id].anim_npc = [self.options[option_id].anim_npc];
      }

      if(var_e60c64e1d6089514) {
        self.options[option_id].cur_anim = randomint(self.options[option_id].anim_npc.size);
        return;
      }

      self.options[option_id].cur_anim = 0;
    }
  }
}

function function_ccb81546a8105955(message, var_563ea27c02df577c) {
  self.temp_disabled = 1;

  if(isDefined(message)) {
    self.var_7a1a08ae68f6b825 = message;
  }

  if(isDefined(var_563ea27c02df577c)) {
    utility::flag_wait(var_563ea27c02df577c);
    self.temp_disabled = 0;
  }
}

function function_e94209c7f6cf8250() {
  self.temp_disabled = 0;
}

function function_13dccbbb0ae83b7e(dialog_tree, position_overrides) {
  assert(isDefined(dialog_tree));
  assert(isstruct(position_overrides), "<dev string:x1c0>");

  if(isDefined(position_overrides.horzoffset)) {
    assert(isint(position_overrides.horzoffset));
    dialog_tree.position.horzoffset = position_overrides.horzoffset;
  }

  if(isDefined(position_overrides.vertoffset)) {
    assert(isint(position_overrides.vertoffset));
    dialog_tree.position.vertoffset = position_overrides.vertoffset;
  }

  if(isDefined(position_overrides.horzalign)) {
    assert(isint(position_overrides.horzalign));
    dialog_tree.position.horzalign = position_overrides.horzalign;
  }

  if(isDefined(position_overrides.vertalign)) {
    assert(isint(position_overrides.vertalign));
    dialog_tree.position.vertalign = position_overrides.vertalign;
  }
}

function function_fe49d1bdcfad6bac(var_792e0f4487021d96, var_12b1f9bd3e48b2f1) {
  self.var_a7cfc2c5fb2ef991 = var_792e0f4487021d96;
  self.var_77d615b2072cec60 = var_12b1f9bd3e48b2f1;
}

function function_ee02485a93659c(state_index) {
  self.state_index = state_index;
}

function function_3ec1c37f9b2c85d4(player_loc, var_f0ef6763e36510fa, var_9092d69981cdfe58, var_792e0f4487021d96, var_12b1f9bd3e48b2f1, stance, fov, dof, lerptime, frame_position, override_scene, override_struct, var_2c9d77290fe5cda9, var_be9abe469b636bf1, var_bc26c4a7eb6949d9) {
  if(!isDefined(stance)) {
    stance = "\x8b\x90\xb5\xc4W";
  }

  if(!isDefined(fov)) {
    fov = "\x15Z\xde,\x82j\xb1\xee\xa9";
  }

  if(!isDefined(dof)) {
    dof = "w=&\x15\xbd\xae";
  }

  if(!isDefined(lerptime)) {
    lerptime = 2;
  }

  if(!isDefined(frame_position)) {
    frame_position = "=\xff0b";
  }

  new_pos = spawnStruct();
  new_pos.player_loc = player_loc;

  if(isDefined(player_loc)) {
    new_pos.origin = player_loc.origin;
    new_pos.var_bc26c4a7eb6949d9 = 1;
  }

  if(isDefined(var_bc26c4a7eb6949d9)) {
    new_pos.var_bc26c4a7eb6949d9 = var_bc26c4a7eb6949d9;
  }

  new_pos.var_f0ef6763e36510fa = var_f0ef6763e36510fa;
  new_pos.var_451238bbdc72c7cf = var_9092d69981cdfe58;
  new_pos.var_792e0f4487021d96 = var_792e0f4487021d96;
  new_pos.var_12b1f9bd3e48b2f1 = var_12b1f9bd3e48b2f1;
  new_pos.stance = stance;
  new_pos.fov = fov;
  new_pos.dof = dof;
  new_pos.lerptime = lerptime;
  new_pos.frame_pos = frame_position;
  new_pos.override_scene = override_scene;
  new_pos.override_struct = override_struct;

  if(isDefined(var_2c9d77290fe5cda9)) {
    new_pos.var_2c9d77290fe5cda9 = var_2c9d77290fe5cda9;
  }

  if(isDefined(var_be9abe469b636bf1)) {
    new_pos.var_be9abe469b636bf1 = var_be9abe469b636bf1;
  }

  self.player_pos[self.player_pos.size] = new_pos;
}

function add_greeting(vo_line, delay_before, delay_after, actor) {
  assert(isDefined(vo_line), "<dev string:x248>");
  self.greetings = function_53b7421a488e1b22(self.greetings, vo_line, delay_before, delay_after, actor);
}

function function_90a50a4f03b2db19(mode) {
  self.var_c53309bba304dc96 = mode;
}

function function_a9edfd2f4eb20fac(vo_line, delay_before, delay_after, actor) {
  assert(isDefined(vo_line), "<dev string:x270>");
  self.exhaustions = function_53b7421a488e1b22(self.exhaustions, vo_line, delay_before, delay_after, actor);
}

function function_deeabe4158c05bf0(mode) {
  self.var_25b3bc07c63e0823 = mode;
}

function set_exhausted(exhausted) {
  if(!isDefined(exhausted)) {
    exhausted = 1;
  }

  self.exhausted = exhausted;
}

function get_exhausted() {
  var_78faeb7dcf69afc9 = 0;

  if(isDefined(self.exhausted) && self.exhausted == 1 || function_1a1617d9ab947237(1) <= var_78faeb7dcf69afc9) {
    return true;
  }

  return false;
}

function play_greeting(ai_actor) {
  self.cur_greeting = function_a6350e47edbcb717(self.greetings, self.cur_greeting, ai_actor, self.var_c53309bba304dc96);
}

function function_973674f91d9b821d(ai_actor) {
  if(is_exhausted(ai_actor)) {
    self.var_f276172da17c24eb = function_a6350e47edbcb717(self.exhaustions, self.var_f276172da17c24eb, ai_actor, self.var_25b3bc07c63e0823);
    return true;
  }

  return false;
}

function is_exhausted(ai_actor) {
  return isDefined(self.exhaustions) && get_exhausted();
}

function private function_53b7421a488e1b22(vo_array, vo_line, delay_before, delay_after, actor) {
  vo_struct = spawnStruct();
  vo_struct.vo_line = vo_line;

  if(isDefined(delay_before)) {
    vo_struct.pre_delay = delay_before;
  }

  if(isDefined(delay_after)) {
    vo_struct.post_delay = delay_after;
  }

  if(isDefined(actor)) {
    vo_struct.actor = actor;
  }

  if(!isDefined(vo_array)) {
    vo_array = [];
  }

  vo_array[vo_array.size] = vo_struct;
  return vo_array;
}

function private function_a6350e47edbcb717(vo_array, var_2dbd43f4e4abf78c, ai_actor, cycle_option = "^6v*\r\x10\vt\xa9") {
  if(!isDefined(vo_array)) {
    return -1;
  }

  if(!isDefined(var_2dbd43f4e4abf78c)) {
    var_2dbd43f4e4abf78c = -1;
  }

  var_2dbd43f4e4abf78c = function_ffbaaf0e9b0f08f(var_2dbd43f4e4abf78c, vo_array.size, cycle_option);
  vo_struct = vo_array[var_2dbd43f4e4abf78c];
  vo_line = vo_struct.vo_line;

  if(isDefined(vo_struct.actor)) {
    ai_actor = vo_struct.actor;
  }

  if(isDefined(vo_struct.pre_delay)) {
    wait vo_struct.pre_delay;
  }

  ai_actor utility::ent_flag_set("\x8b\xbe\x10'\n\t\x1d4\xc7`\x9a\xe1\x9dK\xeb\xa1\xb6`\x8d\xfe\xd5\x97\x8e!\x13\xad\x7f");

  if(soundexists(vo_line)) {
    ai_actor dialogue::stop_dialogue();
    waitframe();
    ai_actor dialogue::say(vo_line);
  } else {
    if(ai_actor != level && ai_actor != level.player) {
      ai_actor thread utility_sp::dialogue_print(vo_line);
    } else {
      iprintlnbold(vo_line);
    }
  }

  if(isDefined(vo_struct.post_delay)) {
    wait vo_struct.post_delay;
  }

  ai_actor utility::ent_flag_clear("\x8b\xbe\x10'\n\t\x1d4\xc7`\x9a\xe1\x9dK\xeb\xa1\xb6`\x8d\xfe\xd5\x97\x8e!\x13\xad\x7f");
  return var_2dbd43f4e4abf78c;
}

function function_ffbaaf0e9b0f08f(cur_idx, num_choices, cycle_option) {
  last_idx = cur_idx;
  cur_idx++;

  if(cur_idx >= num_choices) {
    cur_idx = 0;

    switch (cycle_option) {
      case #"hash_ef6e32f0225e8f5a":
        cur_idx = 1;
        break;
      case #"hash_f657293e61f29f2f":
        cur_idx = last_idx;
        break;
      case #"hash_1ae0bd40582c8a9c":
        cur_idx = randomint(num_choices);
        break;
      case #"hash_b161b2bee816e90f":
        cur_idx = randomint(num_choices - 1) + 1;
        break;
    }

    if(cycle_option == "^6v*\r\x10\vt\xa9" || cycle_option == "\x13A7j\xbf\xea\xa2t\x1a\xe6T{@\xbb}RLep\x9a") {
      first_option = 0;

      if(cycle_option == "\x13A7j\xbf\xea\xa2t\x1a\xe6T{@\xbb}RLep\x9a") {
        first_option = 1;
      }

      if(cur_idx == last_idx) {
        cur_idx++;

        if(cur_idx >= num_choices) {
          cur_idx = first_option;
        }
      }
    }

    cur_idx = int(clamp(cur_idx, 0, num_choices - 1));
  }

  return cur_idx;
}

function function_be4ffa08ef2e2e0f(ai_actor, anim_struct) {
  var_2bb9e722a9347173 = 4.32;
  player = self.activator;

  if(isDefined(self.anim_template) && isDefined(self.var_b82409fa4c439a37)) {
    function_20f998165ab8a5c();
  }

  if(isDefined(self.player_pos) && self.player_pos.size > 0) {
    foreach(pos in self.player_pos) {
      if(isDefined(ai_actor) && utility::hastag(ai_actor.model, "\xc7\xae?f\x10\xbcr")) {
        ai_pos = spawnStruct();
        ai_pos.origin = ai_actor gettagorigin("\xc7\xae?f\x10\xbcr");
        ai_pos.angles = ai_actor.angles;
      }

      future_pos = undefined;

      if(isDefined(pos.var_f0ef6763e36510fa)) {
        bundle = self.scriptbundle;
        struct = anim_struct;

        if(isDefined(pos.override_scene)) {
          bundle = pos.override_scene;
        }

        if(isDefined(pos.override_struct)) {
          struct = pos.override_struct;
        }

        player_objs = scene::function_37f0ac9fd771420c("T^\x83\xca7\xeb\n6a\xcber", pos.var_f0ef6763e36510fa, bundle);

        if(player_objs.size > 0) {
          pos.var_4912664e94f977f2 = 1;

          if(!isDefined(pos.var_bc26c4a7eb6949d9)) {
            pos.var_bc26c4a7eb6949d9 = 1;
          }

          future_pos = function_3adc7b35530a971f(player_objs[0], struct, bundle, pos.var_f0ef6763e36510fa);
        } else {
          var_284914780a1cace5 = function_545f2ec4cb1ed84(ai_actor, struct, bundle, pos.var_f0ef6763e36510fa);

          if(isDefined(var_284914780a1cace5)) {
            ai_pos = var_284914780a1cace5;
            future_pos = spawnStruct();
            future_pos.origin = (ai_pos.origin[0], ai_pos.origin[1], ai_actor.origin[2] + var_2bb9e722a9347173);
            future_pos.angles = ai_pos.angles;
          }
        }
      }

      if(!isDefined(pos.player_loc)) {
        pos.player_loc = spawnStruct();
        self.position = {
          #vertalign: 2, #horzalign: 2, #vertoffset: -260, #horzoffset: -240
        };

        if(isDefined(pos.var_4912664e94f977f2) && isDefined(future_pos)) {
          pos.player_loc = future_pos;
        } else {
          side_offset = 5;
          angle_offset = 12;

          if(pos.frame_pos == "o0\xee\xc1\x8c") {
            side_offset *= -1;
            angle_offset *= -1;
          }

          pos.player_loc.origin = ai_pos.origin + anglesToForward(ai_pos.angles) * 56 + anglestoright(ai_pos.angles) * side_offset;
          pos.player_loc.origin = (pos.player_loc.origin[0], pos.player_loc.origin[1], ai_actor.origin[2] + var_2bb9e722a9347173);
          pos.player_loc.angles = ai_pos.angles + (0, 180, 0) - (0, angle_offset, 0);
          player_fwd = anglesToForward(pos.player_loc.angles);
          player_eye = pos.player_loc.origin + (0, 0, level.player getplayerviewheight(pos.stance));
          var_79fbadc956994e0f = ai_pos.origin - (0, 0, 6) - player_eye;

          if(player_eye[2] - ai_pos.origin[2] > 18) {
            var_79fbadc956994e0f = ai_pos.origin - player_eye;
          }

          pos.player_loc.angles = (vectortoangles(var_79fbadc956994e0f)[0], pos.player_loc.angles[1], pos.player_loc.angles[2]);
        }

        pos.origin = pos.player_loc.origin;
      }
    }

    closest_pos = utility::getclosest(player.origin, self.player_pos);
    ai_actor.var_c18ce0912da5fc59 = closest_pos;
    self.position = {
      #vertalign: 2, #horzalign: 2, #vertoffset: -260, #horzoffset: -240
    };

    if(closest_pos.frame_pos == "o0\xee\xc1\x8c") {
      self.position = {
        #vertalign: 2, #horzalign: 0, #vertoffset: -260, #horzoffset: 240
      };
    }

    if(isDefined(closest_pos.stance)) {
      switch (closest_pos.stance) {
        case #"hash_c6775c88e38f7803":
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "1x\xc5\xb4\xabx", 0);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "GX\xa9]\x82", 0);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x8b\x90\xb5\xc4W", 1);
          break;
        case #"hash_3fed0cbd303639eb":
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "1x\xc5\xb4\xabx", 1);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "GX\xa9]\x82", 0);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x8b\x90\xb5\xc4W", 0);
          break;
        case #"hash_d91940431ed7c605":
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "1x\xc5\xb4\xabx", 0);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "GX\xa9]\x82", 1);
          self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x8b\x90\xb5\xc4W", 0);
          break;
      }

      player setstance(closest_pos.stance);
    }

    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\rnT\xb9G\xdco\x12\x86\x7fMO6\xc9", [0, 0.25]);

    if(isPlayer(player)) {
      self.activator hidefromplayer(player);
    }

    ai_actor thread handle_camera_adjustments(closest_pos);

    if(!isDefined(closest_pos.var_4912664e94f977f2)) {
      self.player_linkto = player utility::spawn_tag_origin(closest_pos.player_loc.origin, closest_pos.player_loc.angles);
      self.player_linkto dontinterpolate();
      self.player_linkto.var_bc26c4a7eb6949d9 = closest_pos.var_bc26c4a7eb6949d9;
      ai_actor notify("\xf8\xd1'\xf0\xb1\xd6\x1a1\xad\xc9w\xd9<n\xa8\x99\x918\xbe\xcc\x11");
    }

    player val::set("\x90\xa8$\xa5\x18\x8a:\xd5\x01/\n8\x18\xee\vU", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
    thread function_6819e142d7fa1207(player, closest_pos);
    thread function_e961306ec6c9bd6a(ai_actor, anim_struct, closest_pos);
    ai_actor utility::waittill_any("_tz\xe47[\xd4u\x99D\x91o+bc\xd4U\xbf8{_\x04\x826", "\xf9q\x93\xe6\x81v3\xb2H\xd9&\xfa O\x97\x81p\xdf\xe00p\xa5\xd4U");
    player utility::delaythread(0.75, &val::reset_all, "\x90\xa8$\xa5\x18\x8a:\xd5\x01/\n8\x18\xee\vU");
    ai_actor notify("\xf8\xd1'\xf0\xb1\xd6\x1a1\xad\xc9w\xd9<n\xa8\x99\x918\xbe\xcc\x11");
  }
}

function function_6819e142d7fa1207(player, closest_pos) {
  lr_arc = closest_pos.var_2c9d77290fe5cda9 ?? 7;
  tb_arc = closest_pos.var_be9abe469b636bf1 ?? 5;

  if(isDefined(self.player_linkto)) {
    targ_pos = self.player_linkto gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");

    if(targ_pos != (0, 0, 0) && distance(player.origin, targ_pos) < 256) {
      lerptime = closest_pos.lerptime ?? 2;
      self.player_linkto.prev_origin = player.origin;
      player startcameratween(lerptime, 1, "b]\x19\xa9\xf0:p\x05p4([0\xad\x98", 1);
      player playerlinktodelta(self.player_linkto, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 0, 0, 0, 0, 1, 0, 0, 1);
      wait lerptime + level.framedurationseconds;
    }
  }

  if(istrue(self.allow_movement)) {
    player unlink();
    self.player_linkto = undefined;
    self.activator val::reset("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\xd56a\x9b\xba$Do]uE\xb6\x9b1");
  } else {
    player thread function_fc75deb11f048634(lr_arc, lr_arc, tb_arc, tb_arc);
  }

  player show();
}

function private function_fc75deb11f048634(left, right, top, bottom) {
  self notify("\xabF\x7f^\xad\x14\xf5\xe6m\t\x97\xf7\xf5\xc2\xa1\xb0");
  self endon("\xabF\x7f^\xad\x14\xf5\xe6m\t\x97\xf7\xf5\xc2\xa1\xb0");
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  lastlooking = 0;
  viewavailable = 1;

  while(true) {
    if(!self islinked()) {
      waitframe();
      continue;
    }

    var_48decbba5a3f62df = !istrue(level.var_58664a6b176228c3);

    if(isDefined(self getlinkedparent()) && !self function_63b1b7751d765b9e()) {
      if(var_48decbba5a3f62df) {
        self springcamenabled(0.5, 3.2, 1.6);
      } else {
        self springcamdisabled(0.5);
      }
    }

    cammovement = self getnormalizedcameramovement();

    if(lengthsquared(cammovement) > 0.01 || !var_48decbba5a3f62df) {
      lastlooking = gettime();
    }

    if(lastlooking == gettime() && !viewavailable) {
      viewavailable = 1;

      if(!self function_63b1b7751d765b9e()) {
        self lerpviewangleclamp(0.25, 0.1, 0.1, left, right, top, bottom, 1);
      }
    } else if(gettime() - lastlooking > 500 && viewavailable) {
      viewavailable = 0;

      if(!self function_63b1b7751d765b9e()) {
        self lerpviewangleclamp(1, 0.5, 0.5, 0, 0, 0, 0, 1);
      }
    }

    waitframe();
  }
}

function function_3adc7b35530a971f(player_obj, struct, scene, shot) {
  fake_player = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", level.player.origin);
  fake_player setModel(player_obj.sceneobject.variant_object.xmodelname);
  fake_player.angles = level.player.angles;
  fake_player utility_sp::assign_animtree("K_p\x84a\x01");
  fake_player hide();
  enter_animations = struct scene::function_979b54d9d4c16e5f(player_obj.sceneobject.variant_object.name, shot, scene);
  enter_animation = enter_animations[enter_animations.size - 1];
  alignmentinfo = struct scene::function_bec8070223d71bb8(player_obj.sceneobject.variant_object.name, shot, scene);
  fake_player animScripted("\xee\x95\xb7e\xf4\xf72\x9f\x0es", alignmentinfo.origin, alignmentinfo.angles, enter_animation, undefined, undefined, 0, 0);

  if(!animislooping(enter_animation)) {
    fake_player setanimtime(enter_animation, 0);
  }

  fake_player dontinterpolate();
  wait 0.05;
  pos_info = spawnStruct();
  pos_info.origin = fake_player gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");
  pos_info.angles = fake_player gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
  fake_player delete();
  return pos_info;
}

function function_545f2ec4cb1ed84(ai_actor, struct, scene, shot) {
  if(isDefined(ai_actor)) {
    pos_info = spawnStruct();
    pos_info.origin = ai_actor gettagorigin("\xc7\xae?f\x10\xbcr");
    pos_info.angles = ai_actor gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");

    if(isDefined(shot) && isDefined(scene) && isDefined(struct)) {
      fakeai = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", ai_actor.origin);
      fakeai setModel(ai_actor.model);
      fakeai.angles = ai_actor.angles;
      fakeai.targetname = ai_actor.targetname;
      fakeai.animname = ai_actor.animname;
      fakeai utility_sp::assign_human_animtree();
      fakeai hide();
      enter_animations = struct scene::function_979b54d9d4c16e5f(fakeai.animname, shot, scene);
      enter_animation = enter_animations[enter_animations.size - 1];
      alignmentinfo = struct scene::function_bec8070223d71bb8(fakeai.animname, shot, scene);

      if(isDefined(enter_animation)) {
        fakeai animScripted("\xee\x95\xb7e\xf4\xf72\x9f\x0es", alignmentinfo.origin, alignmentinfo.angles, enter_animation, undefined, undefined, 0, 0);
        fakeai setanimtime(enter_animation, 1);
        fakeai dontinterpolate();
        wait 0.05;
        pos_info.origin = fakeai gettagorigin("\xc7\xae?f\x10\xbcr");
        pos_info.angles = fakeai gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
      }

      fakeai delete();
    }

    return pos_info;
  }

  return undefined;
}

function private function_1532d157d3ba6a0a(ai_actor, actor_list, enable) {
  foreach(actor in actor_list) {
    if(isent(actor) && !isPlayer(actor) && isent(ai_actor) && ai_actor != actor) {
      if(istrue(enable)) {
        actor val::reset("\xc8i\xb0\x8d\xbd\xce}t\xc9\xb2+\xfa\x16\x9b-\xda", "y\x9e\xfa\xb1\x95.\x839");
        continue;
      }

      actor val::set("\xc8i\xb0\x8d\xbd\xce}t\xc9\xb2+\xfa\x16\x9b-\xda", "y\x9e\xfa\xb1\x95.\x839", enable);
    }
  }
}

function function_e961306ec6c9bd6a(ai_actor, struct, player_pos) {
  ai_actor endon("\xd9\x17\xaf\xa6\xf6\xfcTT\xa9T\xa9{\x8c\xea\x19\x9fh3t\x9a\xf1\xd4>\xd6R\x87iXi");

  if(!isDefined(player_pos.override_scene)) {
    player_pos.override_scene = self.scriptbundle;
  }

  if(!isDefined(player_pos.override_struct)) {
    player_pos.override_struct = struct;
  }

  bundle = player_pos.override_scene;
  scene_struct = player_pos.override_struct;
  actor_list = function_88631a9dfe1d8e0d(ai_actor);
  function_1532d157d3ba6a0a(ai_actor, actor_list, 0);

  if(isDefined(bundle)) {
    if(isDefined(player_pos.var_f0ef6763e36510fa)) {
      scene_struct scene::play(actor_list, player_pos.var_f0ef6763e36510fa, bundle);
    } else {
      waitframe();
    }
  } else {
    waitframe();
  }

  ai_actor notify("\xf9q\x93\xe6\x81v3\xb2H\xd9&\xfa O\x97\x81p\xdf\xe00p\xa5\xd4U");
  start_idle = self.var_815ff889bee59756;

  if(isDefined(player_pos.var_451238bbdc72c7cf)) {
    start_idle = player_pos.var_451238bbdc72c7cf;
  }

  if(isDefined(self.anim_template)) {
    start_idle = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(self.anim_template, "R\\\xfe\xb5\xd1\xf6\xd3");
    bundle = namespace_6f793d3cf96d68f::function_ea78b4318e27edea(self.anim_template);
    scene_struct = self.template_struct;
  }

  if(isDefined(start_idle)) {
    scene_struct thread scene::play(actor_list, start_idle, bundle);
  }
}

function function_682facdd3e6c42bd(ai_actor, struct, player_pos) {
  ai_actor endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(player_pos)) {
    bundle = self.scriptbundle;
    exit_struct = struct;

    if(isDefined(player_pos.fov) && isnumber(player_pos.fov) || isstring(player_pos.fov) && player_pos.fov != "\r+x5") {
      lerptime = player_pos.lerptime * 0.5;
      thread function_b4fbd087c4ff907f(lerptime);
    }

    if(isDefined(player_pos.dof) && player_pos.dof != "\r+x5") {
      if(isDefined(ai_actor) && isactor(ai_actor)) {
        level.player utility::dof_disable_autofocus();
      } else {
        level.player utility::dof_disable_autofocus();
      }
    }

    var_792e0f4487021d96 = player_pos.var_792e0f4487021d96;
    var_12b1f9bd3e48b2f1 = player_pos.var_12b1f9bd3e48b2f1;

    if(isDefined(self.var_a7cfc2c5fb2ef991)) {
      var_792e0f4487021d96 = self.var_a7cfc2c5fb2ef991;

      if(isDefined(self.var_77d615b2072cec60)) {
        var_12b1f9bd3e48b2f1 = self.var_77d615b2072cec60;
      }
    } else {
      if(isDefined(player_pos.override_scene)) {
        bundle = player_pos.override_scene;
      }

      if(isDefined(player_pos.override_struct)) {
        exit_struct = player_pos.override_struct;
      }
    }

    actor_list = function_88631a9dfe1d8e0d(ai_actor);

    if(isDefined(bundle)) {
      if(isDefined(var_792e0f4487021d96)) {
        player_objs = scene::function_37f0ac9fd771420c("T^\x83\xca7\xeb\n6a\xcber", var_792e0f4487021d96, bundle);

        if(player_objs.size > 0) {
          self.var_4fb25c0aefc18ffb = 1;
        }

        ai_actor notify("*\x94\xb5r\x04\x01\xd7]AZ\n\xc6\xbd\xc6\x96\x93\xaa\r\xe4B\xc4");
        ai_actor utility::ent_flag_set("\xdf\x16q\xfc\xb4\xfe\n\xcb\xdf\a\xd8\x9c\xdf\xe0\x11\xfa}");
        exit_struct scene::play(actor_list, var_792e0f4487021d96, bundle);
        ai_actor utility::ent_flag_clear("\xdf\x16q\xfc\xb4\xfe\n\xcb\xdf\a\xd8\x9c\xdf\xe0\x11\xfa}");
      }

      ai_actor notify("F\x96\xb06\xb7\xd9\xf5Gr\x95Y\xaf\xac\xe1Z\xd1\xfa\xc2ni\xb6\xebl\xde\xb6\x0e\xd8VGV");

      if(isDefined(var_12b1f9bd3e48b2f1)) {
        exit_struct thread scene::play(actor_list, var_12b1f9bd3e48b2f1, bundle);
      }
    }

    function_1532d157d3ba6a0a(ai_actor, actor_list, 1);
  }
}

function private handle_camera_adjustments(closest_pos) {
  level.player notify("\x1d\xc5#\b\xfc\xb1Btu\xd3\xf8\t\x1e\xfeL!\xa69\xdbuf\xfe\xcb\xd2\x15\xf9\x7f\xb2");
  level.player endon("\x1d\xc5#\b\xfc\xb1Btu\xd3\xf8\t\x1e\xfeL!\xa69\xdbuf\xfe\xcb\xd2\x15\xf9\x7f\xb2");

  if(isDefined(closest_pos.fov)) {
    newfov = closest_pos.fov;

    if(!isnumber(closest_pos.fov) && isDefined(level.var_93d89c08e78d9ba1[closest_pos.fov])) {
      newfov = level.var_93d89c08e78d9ba1[closest_pos.fov];
    }

    if(isnumber(newfov)) {
      level.player lerpfov(newfov, closest_pos.lerptime, closest_pos.lerptime * 0.25, closest_pos.lerptime * 0.5);
      level.dt_currentfov = newfov;
    }
  }

  if(isDefined(closest_pos.dof) && isDefined(level.var_f840041b4be441b[closest_pos.dof]) && closest_pos.dof != "\r+x5") {
    if(isDefined(self) && isactor(self)) {
      level.player thread utility::dof_enable_autofocus(level.var_f840041b4be441b[closest_pos.dof], self, 50, closest_pos.lerptime, undefined, "\xc7\xae?f\x10\xbcr", undefined, 1);
      return;
    }

    level.player thread utility::dof_enable_autofocus(level.var_f840041b4be441b[closest_pos.dof], undefined, 50, closest_pos.lerptime, undefined, undefined, undefined, 1);
  }
}

function private function_2a2a96feb468203b() {
  level waittill("l\xce\x9a\x10\x10\xb9\x99\x0eT\xb7C");

  if(isDefined(level.dt_currentfov)) {
    level.player lerpfov(level.dt_currentfov);
  } else {
    level.player lerpfov(level.var_d748ffb39eddcf85);
  }

  level.player thread function_2a2a96feb468203b();
}

function private function_b4fbd087c4ff907f(lerptime) {
  self waittill("\xfd\xb1\xa5{_v\\{A\xee\xbe", camera_blendtime);
  level.player notify("\x1d\xc5#\b\xfc\xb1Btu\xd3\xf8\t\x1e\xfeL!\xa69\xdbuf\xfe\xcb\xd2\x15\xf9\x7f\xb2");

  if(camera_blendtime != -1) {
    lerptime = camera_blendtime;
  }

  level.player lerpfov(level.var_d748ffb39eddcf85, lerptime, lerptime * 0.25, lerptime * 0.5);
  level.dt_currentfov = undefined;
}

function function_13a68253ba459a8e(dialog_tree, anim_struct, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_a29cb721f305217b, interactstringoverride) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  dialog_tree endon("e\x16\x156A\xb7");

  if(isDefined(self) && isai(self) && !isalive(self)) {
    println("<dev string:x29a>" + self.name + "<dev string:x2db>");
    return;
  }

  if(!isDefined(kill_notify)) {
    kill_notify = "FZ\v6\xed\xce\xd7\xee,\x96\xa3}l,\x9b\xc6Yc";
  }

  if(!isDefined(use_dist)) {
    use_dist = 80;
  }

  if(!isDefined(display_dist)) {
    display_dist = 200;
  }

  if(!isDefined(use_angles)) {
    use_angles = 180;
  }

  if(!isDefined(use_offset)) {
    use_offset = (6, 0, 0);
  }

  if(!isDefined(var_a29cb721f305217b)) {
    var_a29cb721f305217b = 0;
  }

  anim_struct = function_ef98749681c8733b(anim_struct, self);
  self.radius = 2.5;

  if(self tagexists("\x13'$\xc4\xf8l\x16\xdf")) {
    tagname = "\x13'$\xc4\xf8l\x16\xdf";
  } else {
    tagname = undefined;
  }

  interactstring = &"t10_dialog_tree/talk_to";

  if(isDefined(interactstringoverride)) {
    interactstring = interactstringoverride;
  }

  if(isDefined(dialog_tree.anim_template)) {
    dialog_tree function_f7934db5b1c0596d(self);

    if(!utility::ent_flag("Yj\xd3mH4\xc3\xb5\x80zq\xc6")) {
      idle_anim = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(dialog_tree.anim_template, "\x91\x88\xc2*");
      bundle = namespace_6f793d3cf96d68f::function_ea78b4318e27edea(dialog_tree.anim_template);
      struct = dialog_tree.template_struct;
      actor_list = dialog_tree function_88631a9dfe1d8e0d(self);
      struct thread scene::play(actor_list, idle_anim, bundle);
    }
  }

  cursor_hint::create_cursor_hint(tagname, use_offset, interactstring, undefined, display_dist, use_dist, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, use_angles);
  utility::ent_flag_set("K'\x94\x99}\x99\a_\x9e\x80c\xa7\f");
  msg = utility::waittill_any_return("\x91`\xb1\xe7T\x97>", "\x1e\xfd\xd1\xa2\a", "\xafYgV\xa2`\xa2D\xa8\x96na\x99G7\x90-of", "\x83d\x9a\x12\xb9\x93B", kill_notify, "\xaf2\xa3\xaf\x1b\x16\x9b\xb1\xb2\x8d\xfaK\xcd:VN\x85\x8d\xe8\xa5\xde\xb9");

  if(msg == "\x91`\xb1\xe7T\x97>") {
    val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "y\x9e\xfa\xb1\x95.\x839", 0);
    return dialog_tree run(self, anim_struct, timer, level.player, var_a29cb721f305217b);
  }

  cursor_hint::remove_cursor_hint();

  if(isDefined(self)) {
    utility::ent_flag_clear("K'\x94\x99}\x99\a_\x9e\x80c\xa7\f");
  }

  return;
}

function function_9b98ff67f9ead63b(dialog_tree, anim_struct, end_flags, var_f37ee01ed565476d, var_eb17ff6891c59ff5, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_a29cb721f305217b, interactstringoverride) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");
  dialog_tree endon("e\x16\x156A\xb7");

  if(isDefined(end_flags) && !isarray(end_flags)) {
    end_flags = [end_flags];
  }

  if(!isDefined(end_flags)) {
    end_flags = [];
  }

  if(isDefined(var_f37ee01ed565476d) && !isarray(var_f37ee01ed565476d)) {
    var_f37ee01ed565476d = [var_f37ee01ed565476d];
  }

  if(!isDefined(var_f37ee01ed565476d)) {
    var_f37ee01ed565476d = [];
  }

  if(var_f37ee01ed565476d.size > 0) {
    utility::flag_waitopen_all_array(var_f37ee01ed565476d);
  }

  if(!isDefined(var_eb17ff6891c59ff5)) {
    var_eb17ff6891c59ff5 = 2;
  }

  while(end_flags.size == 0 || !flag_any(end_flags)) {
    childthread _dt_handle_disable_flags(end_flags, var_f37ee01ed565476d, kill_notify);
    function_13a68253ba459a8e(dialog_tree, anim_struct, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_a29cb721f305217b, interactstringoverride);
    utility::function_18e9f1084badc1c7("\xdf\x16q\xfc\xb4\xfe\n\xcb\xdf\a\xd8\x9c\xdf\xe0\x11\xfa}");

    if(isDefined(var_eb17ff6891c59ff5)) {
      wait var_eb17ff6891c59ff5;
    }

    if(var_f37ee01ed565476d.size > 0) {
      utility::flag_waitopen_all_array(var_f37ee01ed565476d);
    }
  }
}

function private stop_talking() {
  if(isent(self)) {
    self stopsounds();

    foreach(ent in self getlinkedchildren()) {
      if(isent(ent)) {
        ent stopsounds();
      }
    }

    if(isai(self)) {
      thread dialogue::stop_dialogue();
    }
  }
}

function private _dt_handle_disable_flags(end_flags, var_f37ee01ed565476d, kill_notify) {
  self notify("\xeb\x91t\xd7\xa1\xb0\xe6\x8c6\xac_\x8c\xa5\xcd\x16b\x1b\xac_\x996X;\xe6");
  self endon("\xeb\x91t\xd7\xa1\xb0\xe6\x8c6\xac_\x8c\xa5\xcd\x16b\x1b\xac_\x996X;\xe6");

  if(isDefined(kill_notify)) {
    self endon(kill_notify);
  }

  flag_array = utility::array_combine(end_flags, var_f37ee01ed565476d);

  if(flag_array.size > 0) {
    utility::function_98a0531c1b66c9ff(flag_array);
  }

  self notify("\xaf2\xa3\xaf\x1b\x16\x9b\xb1\xb2\x8d\xfaK\xcd:VN\x85\x8d\xe8\xa5\xde\xb9");
}

function private function_2fa6485dea9a1f23(var_ca1af37163ddd0ce) {
  asnumeric = var_ca1af37163ddd0ce ? 1 : 0;
  setomnvar("\xae\xa5_\x19\xa5\xb0\xc6\xed\xb3\xebtN\x95\x95\xf5a\xd8\x8ei\xd9\xb2", asnumeric);
}

function run(ai_actor, anim_struct, timer, activator, var_a29cb721f305217b, var_f959de37fc678890, var_7355d394592d89cf, var_21794942e204af8f = 1) {
  assert(isarray(self.options));

  if(!isDefined(ai_actor)) {
    ai_actor = level;
  }

  self.ai_actor = ai_actor;

  if(isDefined(activator) && isPlayer(activator)) {
    self.activator = activator;
  } else {
    self.activator = level.players[0];
  }

  if(!isDefined(var_a29cb721f305217b)) {
    var_a29cb721f305217b = 0;
  }

  if(!isDefined(var_f959de37fc678890)) {
    var_f959de37fc678890 = 4;
  }

  if(!isDefined(var_7355d394592d89cf)) {
    var_7355d394592d89cf = 0;
  }

  if(ai_actor utility::ent_flag("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0") && !is_exhausted(ai_actor)) {
    ai_actor utility::ent_flag_set("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
    ai_actor utility::function_18e9f1084badc1c7("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0");
  }

  function_f7934db5b1c0596d(ai_actor);

  if(!isDefined(self.activator)) {
    return -1;
  }

  self.activator endon("\x1e\xfd\xd1\xa2\a");

  if(function_973674f91d9b821d(ai_actor)) {
    return -1;
  }

  ai_actor notify("l\xda\xdc\x90\x7f\x04\xa7c\xfa\xf4\x81|\xa9");

  if(!isDefined(ai_actor.var_3b3f07cf1f03a47e)) {
    ai_actor.var_3b3f07cf1f03a47e = 0;
  }

  ai_actor.var_3b3f07cf1f03a47e++;
  anim_struct = function_ef98749681c8733b(anim_struct, ai_actor);
  ai_actor function_c259b18cb1aa807a("\xcafX\xee\xacb.\x06\xa5l\x0e\x95\xfd\x80\xe6h\xd9\xa7");

  if(isDefined(self.enter_func)) {
    ai_actor thread function_217fbab77a860753(self.enter_func);
  }

  var_27c8c7cb3c4fb508 = 0;

  if(ai_actor.var_3b3f07cf1f03a47e <= 1) {
    self.activator notify("\xdb\x9eV\x9a\x809X\x1d\xc1/\x8d\aeV\xe03\xd8\xfd\xfc\x1b", ai_actor, anim_struct);
    level utility::function_a90fafbfd5e2453();

    if(self.skippable) {
      thread function_519ac0f14e25ff5a(ai_actor, anim_struct);
    }

    ai_actor utility::ent_flag_set("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16");
    utility::flag_set("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16");
    utility::flag_set("|&\xea\x18~O\xf2\x1earq\xbf\x1a\xb6\x9b\x15");
    ai_actor.var_ab4fbc3ae4aeab19 = self;

    if(istrue(var_21794942e204af8f)) {
      self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "Kg7{N\xac[e", 1);
    }

    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\fU`\xc0y\x95", 0);
    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);

    if(isai(ai_actor)) {
      if(!isDefined(ai_actor.animname)) {
        ai_actor.animname = "RF\x9e\xe1\xc4\x1f\xe7";
      }

      ai_actor val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "Kg7{N\xac[e", 1);
      ai_actor val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\fU`\xc0y\x95", 0);
    }

    if(!self.allow_weapon) {
      self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\xe5\x06\xb0\bE\x16", 0);
      self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    }

    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", 0);
    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "`QW\xf5\xf2\x1b\xd6\xd7\x03\xd6\xce\bf\xd6", 0);
    self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
    ai_actor.var_b6adac95e3d5943c = anim_struct;
    function_2fa6485dea9a1f23(1);
    activate_lookat(ai_actor);
    thread play_greeting(ai_actor);
    function_be4ffa08ef2e2e0f(ai_actor, anim_struct);

    if(!isDefined(self.player_linkto) && !self.allow_movement) {
      self.player_linkto = utility::spawn_tag_origin(self.activator.origin, self.activator.angles);
      linkedent = self.activator getlinkedparent();

      if(isDefined(linkedent)) {
        self.activator startcameratween(1);
        self.player_linkto.angles = self.activator getplayerangles();
      }

      self.activator playerlinktodelta(self.player_linkto, "\xec\xbfK|\au\xcd\xc2\x19<", 0, 7, 7, 5, 5, 1);
    }

    self.selected_options = 0;
    var_27c8c7cb3c4fb508 = 1;
  } else {
    if(isDefined(ai_actor.var_ab4fbc3ae4aeab19)) {
      parent_dt = ai_actor.var_ab4fbc3ae4aeab19;
      self.force_headlook = parent_dt.force_headlook;
      self.position = parent_dt.position;

      if(!isDefined(self.player_linkto)) {
        self.player_linkto = parent_dt.player_linkto;
      }

      if(!isDefined(self.scriptbundle) && isDefined(parent_dt.scriptbundle)) {
        self.scriptbundle = parent_dt.scriptbundle;
      }

      if(!isDefined(self.anim_template) && isDefined(parent_dt.anim_template)) {
        self.anim_template = parent_dt.anim_template;
        self.template_struct = parent_dt.template_struct;
      }

      if(!isDefined(self.include_actors) && isDefined(parent_dt.include_actors)) {
        self.include_actors = parent_dt.include_actors;
      }

      if(!isDefined(self.var_815ff889bee59756) && isDefined(parent_dt.var_815ff889bee59756)) {
        self.var_815ff889bee59756 = parent_dt.var_815ff889bee59756;
      }
    }

    waitframe();
  }

  ai_actor utility::function_18e9f1084badc1c7("\xcafX\xee\xacb.\x06\xa5l\x0e\x95\xfd\x80\xe6h\xd9\xa7");
  ai_actor function_c259b18cb1aa807a("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");
  ai_actor function_c259b18cb1aa807a("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
  ai_actor function_c259b18cb1aa807a("\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7");
  ai_actor function_c259b18cb1aa807a("Dx\x991\xc0\x16\x8f\x03R\xf7\x14\xa8I\xf9\x91v]\xf0\x81\x01");
  ai_actor utility::function_18e9f1084badc1c7("Dx\x991\xc0\x16\x8f\x03R\xf7\x14\xa8I\xf9\x91v]\xf0\x81\x01");

  while(ai_actor.var_3b3f07cf1f03a47e > 1) {
    wait 0.1;
  }

  wait 0.5;
  end_dialog = 0;
  last_choice = -1;

  if(self.var_3773a34ab2d41dc8) {
    self.activator setclientomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 1);
  }

  if(var_27c8c7cb3c4fb508) {
    self.activator function_ecacfa1e7f3e2e5b(self.position, self.state_index, self.param_ref);
  }

  if(isDefined(timer)) {
    self.timeout = timer;
  }

  while(!end_dialog) {
    cur_choices = function_75e970f3c8188372(var_f959de37fc678890);

    if(cur_choices.size < 1) {
      end_dialog = 1;
      continue;
    }

    activate_lookat(ai_actor, 25);
    ai_actor utility::ent_flag_set("Dx\x991\xc0\x16\x8f\x03R\xf7\x14\xa8I\xf9\x91v]\xf0\x81\x01");
    chosen_id = function_9c4d986ae8219aa(cur_choices, ai_actor, var_f959de37fc678890);

    if(!isDefined(chosen_id) || chosen_id < 0) {
      break;
    }

    self.selected_options++;
    ai_actor notify("R+\xbcd=z\x87y\xeaJ1\xa8\xf6zy\r\xa3R>\x88\x13i\x90");
    level notify("R+\xbcd=z\x87y\xeaJ1\xa8\xf6zy\r\xa3R>\x88\x13i\x90");
    ai_actor utility::function_18e9f1084badc1c7("gPp\x14\x82\xdc\xd7\xbf\xdf\x83}\xc9VX[\xd1\xae(\x98\xad\xba\xadS\xd7\xeb");
    chosen_option = self.options[chosen_id];

    if(isDefined(chosen_option.hudstring)) {
      dt_name = self.scriptbundle;

      if(!isDefined(dt_name)) {
        dt_name = "5{.nnfu2#";
      }

      choice = "m,\xdegOb\x97\x18d\xbb\x02\x16\xf9";

      if(isistring(chosen_option.hudstring)) {
        choice = function_53058b535e4c328(chosen_option.hudstring);
      }

      analytics::function_a7b33e28c76eecd4(dt_name, choice);
    }

    ai_actor stop_talking();

    if(isDefined(chosen_option.set_flag)) {
      foreach(flag_name in chosen_option.set_flag) {
        utility::flag_set(flag_name);
      }
    }

    ai_actor utility::ent_flag_clear("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");
    ai_actor utility::ent_flag_clear("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
    ai_actor utility::ent_flag_clear("\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7");
    waitflags = ["\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7", "\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)", "\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z"];

    if(isDefined(chosen_option.selected_func)) {
      ai_actor utility::ent_flag_set("\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7");
      ai_actor childthread function_18a615c404b88864(chosen_option.selected_func, chosen_option.func_parameter, chosen_option.skip_func);
    }

    if(isDefined(chosen_option.vo_npc)) {
      ai_actor utility::ent_flag_set("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");

      if(chosen_option.cur_vo < 0) {
        thread function_6a513ecd0d8fb0a1(ai_actor, chosen_option.vo_npc);
      } else {
        thread function_6a513ecd0d8fb0a1(ai_actor, chosen_option.vo_npc[chosen_option.cur_vo]);
        chosen_option.cur_vo = function_ffbaaf0e9b0f08f(chosen_option.cur_vo, chosen_option.vo_npc.size, chosen_option.cycle_style);
      }

      if(!isDefined(chosen_option.anim_npc)) {
        ai_actor thread function_ddbb467848fce81a();
      }
    }

    anim_struct notify("n\xeb\xad\x96\xf36\rv\x96f\xc8\xc0E\xc3g\xba\xf3\xea\r\x19");
    anim_npc = undefined;
    var_e2e3be77268f7caa = undefined;
    struct = anim_struct;
    loop_struct = struct;
    bundle = self.scriptbundle;
    loop_bundle = bundle;
    complete_anim = 1;

    if(isDefined(self.var_815ff889bee59756)) {
      var_e2e3be77268f7caa = self.var_815ff889bee59756;
    }

    if(isDefined(self.anim_template)) {
      anim_npc = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(self.anim_template, "\x166x\x98");
      var_e2e3be77268f7caa = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(self.anim_template, "R\\\xfe\xb5\xd1\xf6\xd3");
      bundle = namespace_6f793d3cf96d68f::function_ea78b4318e27edea(self.anim_template);
      loop_bundle = bundle;
      struct = self.template_struct;
      loop_struct = struct;
      complete_anim = 0;
    }

    if(isDefined(chosen_option.anim_npc)) {
      anim_npc = chosen_option.anim_npc;
      complete_anim = 1;

      if(isDefined(self.scriptbundle)) {
        bundle = self.scriptbundle;
        struct = anim_struct;
      }
    }

    if(isDefined(chosen_option.var_e2e3be77268f7caa)) {
      var_e2e3be77268f7caa = chosen_option.var_e2e3be77268f7caa;

      if(isDefined(self.scriptbundle)) {
        loop_bundle = self.scriptbundle;
        loop_struct = anim_struct;
      }
    }

    if(istrue(chosen_option.var_5de507950b974d43)) {
      complete_anim = 0;
    }

    if(isDefined(anim_npc) || isDefined(var_e2e3be77268f7caa)) {
      ai_actor utility::ent_flag_set("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
      ai_actor notify("\xd9\x17\xaf\xa6\xf6\xfcTT\xa9T\xa9{\x8c\xea\x19\x9fh3t\x9a\xf1\xd4>\xd6R\x87iXi");

      if(chosen_option.cur_anim < 0) {
        thread function_92c894f1d3524a7(ai_actor, anim_npc, struct, bundle, var_e2e3be77268f7caa, loop_struct, loop_bundle, complete_anim);
      } else {
        thread function_92c894f1d3524a7(ai_actor, chosen_option.anim_npc[chosen_option.cur_anim], struct, self.scriptbundle, var_e2e3be77268f7caa, loop_struct, loop_bundle, complete_anim);
        chosen_option.cur_anim = function_ffbaaf0e9b0f08f(chosen_option.cur_anim, chosen_option.anim_npc.size, chosen_option.cycle_style);
      }
    }

    if(!complete_anim && isDefined(chosen_option.vo_npc)) {
      waitflags = arrayremove(waitflags, "\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
    }

    if(istrue(chosen_option.end_dialog) || self.timeout > 0) {
      end_dialog = 1;
      last_choice = chosen_id;

      if(istrue(chosen_option.quick_exit)) {
        waitflags = ["\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7"];
      }
    }

    waitflags[waitflags.size] = "\xafP\xec\x86\x9c0w\xaf\xf7O4\xa4\x9c\xccD\xdd";
    ai_actor utility::function_8530ca31a17b1a44(waitflags);

    if(!end_dialog || ai_actor.var_3b3f07cf1f03a47e > 1) {
      ai_actor utility::function_18e9f1084badc1c7("Dx\x991\xc0\x16\x8f\x03R\xf7\x14\xa8I\xf9\x91v]\xf0\x81\x01");
    }

    level notify("<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8");
    ai_actor notify("<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8");
    self.activator notify("<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8");
    self.options[chosen_id] function_715ccf8be559445a(1);
    function_939a3a7ddfe70aab(chosen_id);
    waitframe();

    if(var_7355d394592d89cf) {
      self.var_a62c714dc1f94a6b = chosen_id;
    }

    if(istrue(ai_actor.end_dialog)) {
      ai_actor.end_dialog = undefined;
      break;
    }
  }

  if(ai_actor.var_3b3f07cf1f03a47e <= 1) {
    self.activator hud_management::function_995d1afc30296a16("T\x9f\xd3~z\x12\x04$\xc5\xe6r");

    if(self.var_3773a34ab2d41dc8) {
      self.activator setclientomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 0);
    }

    ai_actor.var_b6adac95e3d5943c = undefined;
    ai_actor.var_ab4fbc3ae4aeab19 = undefined;

    if(isai(ai_actor) && self.force_headlook) {
      ai_actor setlookatstate("\xba\xa5\x1f\xc9m\x80i");
    }

    if(isDefined(ai_actor.var_c18ce0912da5fc59)) {
      thread function_682facdd3e6c42bd(ai_actor, anim_struct, ai_actor.var_c18ce0912da5fc59);
    }
  }

  if(isDefined(self.exit_func)) {
    ai_actor childthread[[self.exit_func]]();
  }

  if(ai_actor.var_3b3f07cf1f03a47e <= 1) {
    level utility::function_7083fdcb0b1b5020();

    if(!self.allow_movement) {
      if(isDefined(self.player_linkto)) {
        safe_origin = undefined;
        var_c9c2a7e71f16d2fc = 2;

        if(isDefined(self.player_linkto.prev_origin) && !istrue(self.player_linkto.var_bc26c4a7eb6949d9)) {
          safe_origin = self.player_linkto.prev_origin;
        }

        trace_from = self.player_linkto.origin;
        ret = self.activator trace::player_trace(trace_from + (0, 0, 40), trace_from, undefined, self.activator);

        if(ret[")\x9a\x94]\xee}s"] != "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
          near_origin = ret["\xc1\xbd\xdci\xe8i{7"];

          if(distance(self.activator.origin, near_origin) < 12) {
            safe_origin = ret["\xc1\xbd\xdci\xe8i{7"];
          }
        } else {
          safe_origin = self.activator.origin;
        }

        if(!isDefined(safe_origin) || distance(self.activator.origin, safe_origin) < 12) {
          var_c9c2a7e71f16d2fc = 0.5;
        }

        self.activator notify("\xdb:\xb1\x01\xc2\x90C\xf7\v>\xe0\xa3\x13\xcf>\xba\xda\xbc", ai_actor, anim_struct, var_c9c2a7e71f16d2fc);
        self.activator startcameratween(var_c9c2a7e71f16d2fc, 1, "b]\x19\xa9\xf0:p\x05p4([0\xad\x98", 1);
        self notify("\xfd\xb1\xa5{_v\\{A\xee\xbe", 0);

        if(istrue(self.var_4fb25c0aefc18ffb)) {
          ai_actor utility::ent_flag_wait("\xdf\x16q\xfc\xb4\xfe\n\xcb\xdf\a\xd8\x9c\xdf\xe0\x11\xfa}");
        }

        if(isDefined(safe_origin) && safe_origin != self.activator.origin) {
          self.activator unlink();
          self.activator setOrigin(safe_origin);
        } else {
          self.activator playerunlinkblend(var_c9c2a7e71f16d2fc);
        }

        wait var_c9c2a7e71f16d2fc;
        self.player_linkto delete();
        self.player_linkto = undefined;
      } else {
        self notify("\xfd\xb1\xa5{_v\\{A\xee\xbe", -1);
        self.activator notify("\xdb:\xb1\x01\xc2\x90C\xf7\v>\xe0\xa3\x13\xcf>\xba\xda\xbc", ai_actor, anim_struct, -1);
      }
    } else {
      self notify("\xfd\xb1\xa5{_v\\{A\xee\xbe", -1);
      self.activator notify("\xdb:\xb1\x01\xc2\x90C\xf7\v>\xe0\xa3\x13\xcf>\xba\xda\xbc", ai_actor, anim_struct, -1);
    }

    ai_actor utility::ent_flag_clear("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");
    ai_actor utility::ent_flag_clear("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
    ai_actor utility::ent_flag_clear("\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7");

    if(isDefined(ai_actor.var_c18ce0912da5fc59)) {
      ai_actor.var_c18ce0912da5fc59 = undefined;
    }

    self.activator val::reset_all("T\x9f\xd3~z\x12\x04$\xc5\xe6r");
    waitframe();

    if(isai(ai_actor)) {
      ai_actor val::reset_all("T\x9f\xd3~z\x12\x04$\xc5\xe6r");
    }

    self notify("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
    ai_actor notify("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
    self.activator notify("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
    ai_actor utility::ent_flag_clear("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16");
    utility::flag_clear("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16");
    utility::flag_clear("|&\xea\x18~O\xf2\x1earq\xbf\x1a\xb6\x9b\x15");
  }

  ai_actor.var_3b3f07cf1f03a47e--;

  while(isDefined(ai_actor.var_3b3f07cf1f03a47e) && ai_actor.var_3b3f07cf1f03a47e > 0) {
    wait 0.1;
  }

  function_2fa6485dea9a1f23(0);
  return last_choice;
}

function function_ca880a68579a4f66() {
  if(self.var_3773a34ab2d41dc8) {
    self.activator setclientomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 0);
  }
}

function function_1a1617d9ab947237(exclude_forever) {
  if(!isDefined(exclude_forever)) {
    exclude_forever = 0;
  }

  choices = function_75e970f3c8188372();
  exclude_count = 0;

  if(exclude_forever) {
    foreach(choice_id in choices) {
      flag_array = self.options[choice_id].var_8988090b1a8ff0e8;

      if(isDefined(flag_array)) {
        foreach(flag in flag_array) {
          flagstr = tolower(flag);

          if(issubstr(flagstr, ")\xb0\x16\xd5YF\xae")) {
            exclude_count++;
            break;
          }
        }
      }
    }
  }

  return choices.size - exclude_count;
}

function function_424cca1785e71096() {
  self.ai_actor utility::ent_flag_wait("\xf9AHw7\b\x99:\xbb5,\xc1\xa2L\xedH\x17Pyh\xf9\x93W\xd7");
  waitframe();
  level notify("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", -1);
}

function cleanup_tree(tree) {
  tree notify("e\x16\x156A\xb7");
  return undefined;
}

function function_33e2264bf097aba2() {
  self.activator hud_management::function_908e2205a6516f5d("T\x9f\xd3~z\x12\x04$\xc5\xe6r");
  self.activator hud_management::function_995d1afc30296a16("T\x9f\xd3~z\x12\x04$\xc5\xe6r");
  self.activator val::reset("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5");

  if(self.var_3773a34ab2d41dc8) {
    self.activator setclientomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 0);
  }
}

function function_bdb3ade86efd65bb() {
  self.activator function_ecacfa1e7f3e2e5b(self.position, self.state_index, self.param_ref);
  self.activator val::set("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 1);

  if(self.var_3773a34ab2d41dc8) {
    self.activator setclientomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 1);
  }
}

function private function_217fbab77a860753(func) {
  utility::ent_flag_set("\xcafX\xee\xacb.\x06\xa5l\x0e\x95\xfd\x80\xe6h\xd9\xa7");
  self[[func]]();
  utility::ent_flag_clear("\xcafX\xee\xacb.\x06\xa5l\x0e\x95\xfd\x80\xe6h\xd9\xa7");
}

function private function_519ac0f14e25ff5a(ai_actor, anim_struct) {
  self notify("c\xb7\"<\xd2\xe9\xba\x80\x96\x0e}\x0f\\`\x82\x86");
  self endon("c\xb7\"<\xd2\xe9\xba\x80\x96\x0e}\x0f\\`\x82\x86");
  self.activator endon("\x1e\xfd\xd1\xa2\a");
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  level notify("R\xc53\x86W0\xa6}$\x88\xb67\x1fS");
  level endon("R\xc53\x86W0\xa6}$\x88\xb67\x1fS");

  while(true) {
    ai_actor utility::function_b4384b6be45783e5(["\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)", "\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z"]);

    if(ai_actor utility::ent_flag("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)")) {
      ai_actor utility::ent_flag_wait("\xd7\xc8t\xd7\x9d\xf6\xfa\xb1\xb4n+\xfa\x856\x8eK;\x95");
      wait 0.3;
    }

    ret = level utility::waittill_any_return("-\x80\x9f\xf4zG\xc7\xb7\xbb\x15J<4\xfd@\v/H\x95\x96\xc9G\xf7~", "<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8");

    if(ret == "<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8") {
      continue;
    }

    if(ai_actor utility::ent_flag("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)") && ai_actor utility::ent_flag("\xd7\xc8t\xd7\x9d\xf6\xfa\xb1\xb4n+\xfa\x856\x8eK;\x95")) {
      if(isDefined(ai_actor.var_13750a376e91088c)) {
        ai_actor notify("\x8f\x92c\b\xc9\x01D\xd8\xc8T\x15\b\xf5\xa8\x9a\xb7\x87\x8aY|\xf9\xa1~ \xc8$\x11");
        ai_actor stop_talking();
        ai_actor.var_13750a376e91088c = undefined;
        ai_actor notify("\xf0\xf2(\xc5\x9f%\xa2\xb3{X\xbaB\xfe\"\t");
        ai_actor utility::ent_flag_clear("\xd7\xc8t\xd7\x9d\xf6\xfa\xb1\xb4n+\xfa\x856\x8eK;\x95");
        wait 0.5;
      }

      continue;
    }

    if(ai_actor utility::ent_flag("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z")) {
      if(isDefined(self.var_3f04691035a8a305)) {
        ai_actor notify("\x8f\x92c\b\xc9\x01D\xd8\xc8T\x15\b\xf5\xa8\x9a\xb7\x87\x8aY|\xf9\xa1~ \xc8$\x11");
        ai_actor stop_talking();
        shotlength = self.var_146ae58be4c38d44 scene::function_be97e534be3fddee(self.var_3f04691035a8a305);
        shottimenext = max(0, shotlength - 0.2);
        sceneobjectdata = self.var_146ae58be4c38d44 scene::get_object(ai_actor);

        if(isDefined(sceneobjectdata.entity) && isDefined(sceneobjectdata.index)) {
          skiptimenext = self.var_146ae58be4c38d44 function_e3939e399d651289(["\xca!\xcf", "\x17\xa5\xb1\xa2\xa52$\xc1\xdb6n?"], ["\xda\f\xf8"], self.var_3f04691035a8a305, sceneobjectdata);

          if(isDefined(skiptimenext)) {
            shottimenext = skiptimenext;
          }
        }

        timefromend = shotlength - shottimenext;
        thread function_441448b9b4c64699(timefromend);
        wait 0.5;
      }
    }
  }
}

function private function_441448b9b4c64699(timefromend) {
  self notify("N\xafI\xd1\xfa^e\x99\x18=\xdb\x05\x88\xbc\xf3n");
  self endon("N\xafI\xd1\xfa^e\x99\x18=\xdb\x05\x88\xbc\xf3n");
  utility::ent_flag_set("\xafP\xec\x86\x9c0w\xaf\xf7O4\xa4\x9c\xccD\xdd");
  self.var_146ae58be4c38d44 scene::skip(self.var_3f04691035a8a305, timefromend, 0);
  utility::ent_flag_clear("\xafP\xec\x86\x9c0w\xaf\xf7O4\xa4\x9c\xccD\xdd");
}

function private function_e3939e399d651289(noteprefixes, paramprefixes, shot, sceneobjectdata) {
  assert(isarray(noteprefixes));
  assert(isarray(paramprefixes));
  assert(isDefined(sceneobjectdata.index));
  anims = scene::function_979b54d9d4c16e5f(sceneobjectdata.index, shot);
  animtime = undefined;
  shottime = 0;

  foreach(index, animasset in anims) {
    animtime = sceneobjectdata.entity getanimtime(animasset);
    animlen = getanimlength(animasset);

    if(animtime > 0) {
      shottime += animtime * animlen;
      break;
    }

    shottime += animlen;
    animtime = undefined;
  }

  if(!isDefined(animtime)) {
    return undefined;
  }

  while(index < anims.size) {
    notesarray = getnotetracks(anims[index], undefined, undefined, undefined, 1);
    animlen = getanimlength(anims[index]);

    foreach(notevalues in notesarray) {
      if(notevalues["\x92\xd3\x9f\xbb"] <= animtime) {
        continue;
      }

      foreach(prefix in noteprefixes) {
        if(getsubstr(notevalues["\xf4\x1f\x13\xee"], 0, prefix.size) == prefix) {
          var_2012306cf7a85c8f = 1;

          if(isstring(notevalues["\xc1\xf88\x92\xdf\x93"][0])) {
            var_2012306cf7a85c8f = 0;

            foreach(paramprefix in paramprefixes) {
              if(getsubstr(notevalues["\xc1\xf88\x92\xdf\x93"][0], 0, paramprefix.size) == paramprefix) {
                var_2012306cf7a85c8f = 1;
                break;
              }
            }
          }

          if(var_2012306cf7a85c8f) {
            prebuffer = 0.1;
            var_2fceddf7ad0d58e4 = notevalues["\x92\xd3\x9f\xbb"] * animlen;
            var_c818fae5f4562031 = animtime * animlen;
            skiptime = var_2fceddf7ad0d58e4 - var_c818fae5f4562031 - prebuffer;

            if(getdvarint(@ "hash_77bc411a1f18c6ef", 0)) {
              notename = notevalues["<dev string:x2eb>"];
              len = notename.size;

              if(len > 23) {
                notename = getsubstr(notename, 0, 10) + "<dev string:x2f3>" + getsubstr(notename, len - 10, len);
              }

              iprintln("<dev string:x2fa>" + var_c818fae5f4562031 + "<dev string:x304>" + var_2fceddf7ad0d58e4 - prebuffer / animlen + "<dev string:x30b>" + notename + "<dev string:x312>");
              startskip = animtime;
              endskip = notevalues["<dev string:x318>"] - prebuffer / animlen;

              foreach(notedata in notesarray) {
                if(notedata["<dev string:x318>"] >= startskip && notedata["<dev string:x318>"] <= endskip) {
                  params = "<dev string:x320>";

                  if(isDefined(notedata["<dev string:x324>"])) {
                    foreach(index, parm in notedata["<dev string:x324>"]) {
                      params = params + "<dev string:x32e>" + parm;
                    }
                  }

                  iprintln("<dev string:x333>" + notedata["<dev string:x318>"] * animlen + "<dev string:x339>" + notedata["<dev string:x2eb>"] + params);
                }
              }
            }

            return max(0, shottime + skiptime);
          }
        }
      }
    }

    animtime = 0;
    shottime += animlen;
    index++;
  }

  return undefined;
}

function function_6a513ecd0d8fb0a1(ai_actor, vo_lines) {
  ai_actor endon("\x1e\xfd\xd1\xa2\a");
  ai_actor endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  waitframe();

  if(!isarray(vo_lines)) {
    vo_lines = [vo_lines];
  }

  for(i = 0; i < vo_lines.size; i++) {
    vo_line = vo_lines[i];

    if(isnumber(vo_line)) {
      wait vo_line;
      continue;
    }

    ai_actor utility::ent_flag_set("\xd7\xc8t\xd7\x9d\xf6\xfa\xb1\xb4n+\xfa\x856\x8eK;\x95");

    if(soundexists(vo_line)) {
      ai_actor.var_13750a376e91088c = 1;
      ai_actor dialogue::stop_dialogue();
      waitframe();
      ai_actor dialogue::say(vo_line);
    } else if(isDefined(vo_line) && vo_line != "") {
      if(ai_actor != level && ai_actor != level.player) {
        ai_actor thread utility_sp::dialogue_print(vo_line);
      } else {
        iprintlnbold(vo_line);
      }

      self.activator utility::waittill_any_timeout(1.5, "<dev string:x33f>");
    }

    ai_actor utility::ent_flag_clear("\xd7\xc8t\xd7\x9d\xf6\xfa\xb1\xb4n+\xfa\x856\x8eK;\x95");
    ai_actor.var_13750a376e91088c = undefined;
  }

  ai_actor notify("\xf63\v\xe1\xa8biq]\\\xa5v\xa3\xf6\x83\x97~\xe7O\xe5Z~\xeb\x83\xb5p\xb9\xac\x83\xb6$D");
  self notify("\xf63\v\xe1\xa8biq]\\\xa5v\xa3\xf6\x83\x97~\xe7O\xe5Z~\xeb\x83\xb5p\xb9\xac\x83\xb6$D");
  ai_actor utility::ent_flag_clear("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");
}

function private function_6ed554c2f446e515(new_option) {
  assert(isarray(self.options));
  option_id = self.options.size;
  self.options[option_id] = new_option;
  return option_id;
}

function private function_d2606160ea42614a(parent_id, option_text, ai_vo, ai_anim, var_2054a63d5f49dd39, end_dialog, set_flag, var_6a2f9581eafbc4c9, var_f31b5aee30ec24ce, selected_func, func_parameter, skip_func, important, expire_count, expire_flag, expire_reset) {
  if(!isDefined(end_dialog)) {
    end_dialog = 0;
  }

  if(!isDefined(important)) {
    important = 0;
  }

  if(!isDefined(expire_reset)) {
    expire_reset = 1;
  }

  option = spawnStruct();
  option.active = 1;
  option.parent_id = parent_id;
  option.hudstring = option_text;
  option.vo_npc = ai_vo;
  option.anim_npc = ai_anim;
  option.var_e2e3be77268f7caa = var_2054a63d5f49dd39;
  option.end_dialog = end_dialog;
  option.pin_bottom = 0;
  option.locked = 0;

  if(isDefined(set_flag) && !isarray(set_flag)) {
    set_flag = [set_flag];
  }

  option.set_flag = set_flag;

  if(isDefined(var_f31b5aee30ec24ce)) {
    option.locked = 1;

    if(isarray(var_f31b5aee30ec24ce)) {
      option.var_78e97cdd5117c2bd = var_f31b5aee30ec24ce;
    } else {
      option.var_78e97cdd5117c2bd = [var_f31b5aee30ec24ce];
    }
  }

  if(isDefined(var_6a2f9581eafbc4c9)) {
    if(isarray(var_6a2f9581eafbc4c9)) {
      option.var_8988090b1a8ff0e8 = var_6a2f9581eafbc4c9;
    } else {
      option.var_8988090b1a8ff0e8 = [var_6a2f9581eafbc4c9];
    }
  }

  option.selected_func = selected_func;
  option.func_parameter = func_parameter;
  option.skip_func = skip_func;
  option.important = important;
  option.show_locked = 0;
  option.cur_vo = -1;
  option.cur_anim = -1;
  option.expire_count = expire_count;
  option.expire_flag = expire_flag;
  option.expire_reset = expire_reset;
  return option;
}

function private function_d91992e892556edf() {
  if(self.locked) {
    if(isDefined(self.var_78e97cdd5117c2bd) && flag_all(self.var_78e97cdd5117c2bd)) {
      return 0;
    }

    if(isDefined(self.var_d3f8428a96158f79) && flag_any(self.var_d3f8428a96158f79)) {
      return 0;
    }

    return 1;
  }

  return 0;
}

function private function_715ccf8be559445a(var_834ead573924e61a) {
  if(var_834ead573924e61a && !isDefined(self.var_a26e7cfa32e1d65e) && !isDefined(self.var_8988090b1a8ff0e8)) {
    self.active = 0;
    return;
  }

  if(isDefined(self.var_8988090b1a8ff0e8)) {
    if(self.var_8988090b1a8ff0e8[0] == ")\xb0\x16\xd5YF\xae") {
      return;
    }

    if(flag_all(self.var_8988090b1a8ff0e8)) {
      self.active = 0;
    }
  }

  if(isDefined(self.var_a26e7cfa32e1d65e) && flag_any(self.var_a26e7cfa32e1d65e)) {
    self.active = 0;
  }
}

function private flag_all(flags) {
  foreach(f in flags) {
    if(!utility::flag(f)) {
      return false;
    }
  }

  return true;
}

function private flag_any(flags) {
  foreach(f in flags) {
    if(utility::flag(f)) {
      return true;
    }
  }

  return false;
}

function private function_4b600a15f6bad737(cur_choices, var_f959de37fc678890) {
  if(!isDefined(var_f959de37fc678890)) {
    var_f959de37fc678890 = 4;
  }

  hudstrings = [];

  for(i = 0; i < var_f959de37fc678890; i++) {
    if(isDefined(cur_choices[i])) {
      option = self.options[cur_choices[i]];
      hudstrings[i] = spawnStruct();
      hudstrings[i].important = option.important;
      hudstrings[i].string = option.hudstring;
      hudstrings[i].locked = option function_d91992e892556edf() && option.show_locked;
      continue;
    }

    hudstrings[i] = spawnStruct();
    hudstrings[i].important = 0;
    hudstrings[i].string = undefined;
    hudstrings[i].locked = 0;
  }

  return hudstrings;
}

function private function_b94652ed3f3e44cf(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  return option_id;
}

function private function_18a615c404b88864(func, param, skip_func) {
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");

  if(isDefined(skip_func)) {
    childthread function_e7de9c4d84010353(skip_func);
  }

  if(!isDefined(param)) {
    self[[func]]();
  } else {
    self[[func]](param);
  }

  self notify("\xe9\xac8\xd2_\xbf\xdf\xbf\x82\x16\xe3+A\xb7\xf8Nt\xf7\x98j\x876");
  utility::ent_flag_clear("\xec\xf6\xbcY3\xef\x96pH\xa9\xac`\xcfh\xb4\xc3b\xb8\xa0\xc7");
}

function private function_e7de9c4d84010353(skip_func) {
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  self endon("\xe9\xac8\xd2_\xbf\xdf\xbf\x82\x16\xe3+A\xb7\xf8Nt\xf7\x98j\x876");
  self waittill("\x8f\x92c\b\xc9\x01D\xd8\xc8T\x15\b\xf5\xa8\x9a\xb7\x87\x8aY|\xf9\xa1~ \xc8$\x11");
  self childthread[[skip_func]]();
}

function function_92c894f1d3524a7(ai_actor, anims, struct, scriptbundle, var_e2e3be77268f7caa, loop_struct, loop_bundle, complete_anim) {
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  ai_actor endon("R+\xbcd=z\x87y\xeaJ1\xa8\xf6zy\r\xa3R>\x88\x13i\x90");
  ai_actor endon("*\x94\xb5r\x04\x01\xd7]AZ\n\xc6\xbd\xc6\x96\x93\xaa\r\xe4B\xc4");

  if(isDefined(anims)) {
    if(!isarray(anims)) {
      anims = [anims];
    }

    thread function_9b2195ed30c2af30(ai_actor);

    for(i = 0; i < anims.size; i++) {
      shot_name = anims[i];
      names = strtok(anims[i], "\xb0");

      if(names.size > 1) {
        scriptbundle = names[0];
        shot_name = names[1];
      }

      if(isDefined(scriptbundle) && isDefined(shot_name)) {
        childthread internal_anim(ai_actor, shot_name, struct, scriptbundle);
        waits = ["\x10W\xec\xf4\xb1O\x8f\xeb\xecz\xbf4\xdd\x8e\x04\x8cJ\x82h\xd4\xa8", "E<\x97\xfe\xa2W0}N$\x90'\xd6n>\xc6\xd9.^\xae~\x162\xcd\xd5"];

        if(!complete_anim) {
          waits[waits.size] = "\xf63\v\xe1\xa8biq]\\\xa5v\xa3\xf6\x83\x97~\xe7O\xe5Z~\xeb\x83\xb5p\xb9\xac\x83\xb6$D";
        }

        utility::waittill_any_in_array(waits);
        utility::function_18e9f1084badc1c7("\xafP\xec\x86\x9c0w\xaf\xf7O4\xa4\x9c\xccD\xdd");
      }
    }
  }

  ai_actor notify("\xea\xf0Z\xa11_\xd7\xf8\xd3|\xe0A\xf2 \x923\xfd\x13\x1f\xa2m\xddG\xc5\x02\xad\xe1\xbaMe%\xb3WN=");
  self.var_3f04691035a8a305 = undefined;
  ai_actor utility::ent_flag_clear("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");

  if(isDefined(var_e2e3be77268f7caa)) {
    names = strtok(var_e2e3be77268f7caa, "\xb0");

    if(names.size > 1) {
      loop_bundle = names[0];
      var_e2e3be77268f7caa = names[1];
    }

    if(isDefined(loop_bundle) && isDefined(var_e2e3be77268f7caa)) {
      loop_struct thread scene::play(function_88631a9dfe1d8e0d(ai_actor), var_e2e3be77268f7caa, loop_bundle);
      waitframe();
    }
  }
}

function private function_88631a9dfe1d8e0d(ai_actor) {
  actor_list = [ai_actor];

  if(isDefined(self.include_actors)) {
    actor_list = utility::array_combine(actor_list, self.include_actors);
  }

  return actor_list;
}

function private internal_anim(ai_actor, shot_name, struct, scriptbundle) {
  self endon("WWw6\xfd\xaa!\xf9:\x04\xbc=\xdaZV");
  self.var_3f04691035a8a305 = shot_name;
  self.var_146ae58be4c38d44 = struct;
  self.var_38e6b0132d6f206d = scriptbundle;
  struct scene::play(function_88631a9dfe1d8e0d(ai_actor), shot_name, scriptbundle);
  self notify("\x10W\xec\xf4\xb1O\x8f\xeb\xecz\xbf4\xdd\x8e\x04\x8cJ\x82h\xd4\xa8");
}

function private activate_lookat(ai_actor, look_pct = 50) {
  if(isai(ai_actor) && self.force_headlook) {
    ai_actor setlookatstate("\xf7x\xb7\xf3\xdf\xf3\x13");
    ai_actor lookat({
      #percent: look_pct, #entity: level.player
    });
  }
}

function private function_9b2195ed30c2af30(ai_actor) {
  self.activator endon("\x1e\xfd\xd1\xa2\a");
  ai_actor endon("\xea\xf0Z\xa11_\xd7\xf8\xd3|\xe0A\xf2 \x923\xfd\x13\x1f\xa2m\xddG\xc5\x02\xad\xe1\xbaMe%\xb3WN=");
  ai_actor waittill("_tz\xe47[\xd4u\x99D\x91o+bc\xd4U\xbf8{_\x04\x826");
  ai_actor utility::ent_flag_clear("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z");
  ai_actor notify("\xea\xf0Z\xa11_\xd7\xf8\xd3|\xe0A\xf2 \x923\xfd\x13\x1f\xa2m\xddG\xc5\x02\xad\xe1\xbaMe%\xb3WN=");
}

function private function_c259b18cb1aa807a(flagname) {
  if(!utility::ent_flag_exist(flagname)) {
    utility::ent_flag_init(flagname);
    utility::ent_flag_clear(flagname);
    return;
  }

  utility::function_18e9f1084badc1c7(flagname);
}

function private function_75e970f3c8188372(max_options) {
  cur_choices = [];
  choice_id = 0;
  pin_choice = undefined;

  if(!isDefined(max_options)) {
    max_options = self.options.size;
  }

  while(choice_id < self.options.size && (cur_choices.size < max_options || self.var_16468517a29ad26f)) {
    option = self.options[choice_id];

    if(isDefined(option.expire_count) && option.expire_count > 0) {
      if(self.selected_options == 0 && istrue(option.expire_reset)) {
        self.options[choice_id].active = 1;

        if(isDefined(option.expire_flag)) {
          utility::flag_clear(option.expire_flag);
        }
      }

      if(self.selected_options >= option.expire_count && option.active) {
        self.options[choice_id].active = 0;

        if(isDefined(option.expire_flag)) {
          utility::flag_set(option.expire_flag);
        }
      }
    }

    option function_715ccf8be559445a(0);

    if(!option.active || option function_d91992e892556edf() && !option.show_locked) {
      choice_id++;
      continue;
    }

    if(option.pin_bottom) {
      pin_choice = choice_id;
    } else {
      cur_choices[cur_choices.size] = choice_id;
    }

    choice_id++;
  }

  if(isDefined(pin_choice)) {
    if(cur_choices.size < max_options) {
      cur_choices[cur_choices.size] = pin_choice;
    } else {
      cur_choices[max_options - 1] = pin_choice;
    }
  }

  return cur_choices;
}

function private function_939a3a7ddfe70aab(parent_id) {
  foreach(option in self.options) {
    if(isDefined(option.parent_id) && option.parent_id == parent_id) {
      option.active = 1;
    }
  }
}

function function_f6165c772ed9bfd6(index) {
  keyinput = index + 1;
  choice_string = "$\xe3\x05" + keyinput + "@\x97Q";
  return choice_string;
}

function function_9c4d986ae8219aa(cur_choices, ai_actor, var_f959de37fc678890) {
  if(!isDefined(var_f959de37fc678890)) {
    var_f959de37fc678890 = 4;
  }

  dialog_strings = function_4b600a15f6bad737(cur_choices, var_f959de37fc678890);
  index = 0;
  choices = [];

  foreach(choice in dialog_strings) {
    if(isDefined(choice.string)) {
      self.activator hud_management::function_222841054993effd("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "$\xb2N2~\xe8@" + index, hud_management::function_a1a13273e72bfe46("\xbe\x1e\xb2\x80\xda3\xb8vE\xd0\xd2\xc5\xfa\x11\x1a\xf4oXB1\x16\x1e\xe1\xb6)g\xc4\xa2Z"));
      self.activator hud_management::function_eeded2ac210fa100("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "$\xb2N2~\xe8@" + index, self.param_ref);
      fields = [];
      fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(choice.string);
      fields["\x90\xcd\xb8\xf8\xd9c\xdbM\x8d"] = choice.important;
      fields["!\x90l\x94\xcfU"] = choice function_d91992e892556edf();
      self.activator hud_management::function_f5104e32d4bc69f2("T\x9f\xd3~z\x12\x04$\xc5\xe6r", "$\xb2N2~\xe8@" + index, fields, 1);
      choices[index] = choice;
      index++;
    }
  }

  if(isDefined(self.timeout) && self.timeout > 0) {
    waittillframeend();
    self.activator thread function_eb84ff654dcc6614(self.timeout);
    self.activator setclientomnvar("\xef\x980\x98f\fCr\xf4{$fl1\x9c\xbf\x1d\x84\xe0", int(self.timeout * 1000));
    var_b445825011883495 = self.position;
  }

  player = self.activator;
  assert(isPlayer(player));
  ai_actor utility::ent_flag_set("\xf9AHw7\b\x99:\xbb5,\xc1\xa2L\xedH\x17Pyh\xf9\x93W\xd7");
  level waittill("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", selected_index);
  ai_actor utility::ent_flag_clear("\xf9AHw7\b\x99:\xbb5,\xc1\xa2L\xedH\x17Pyh\xf9\x93W\xd7");
  player setclientomnvar("\x9e\xda\xfd\xaf\xf7M\x14\xae\x05\xde\xfe\xd7\xd3]\"@aEf\xaf\xe8\x89\x04\xa4*", self.skippable);

  if(selected_index < 0) {
    player thread function_d4f8c4fdf7bfcd03(choices, ai_actor, 1);
    return selected_index;
  }

  player thread function_d4f8c4fdf7bfcd03(choices, ai_actor);
  return cur_choices[selected_index];
}

function private function_eb84ff654dcc6614(timeout) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N");
  self endon("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
  wait timeout;
  self setclientomnvar("so\x1b\xf3].\x86\xbb>\x0e-Q;\x1a\x8e3\xfd\xcd\x1eu\x1a-\xc8\xbfy\x8d\xad\x9d\xb1\x9b\xe9\xb00\xee", 1);
  self setclientomnvar("\xef\x980\x98f\fCr\xf4{$fl1\x9c\xbf\x1d\x84\xe0", 0);
  self notify("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
}

function private function_aa8e42a9bc2d9b12(value) {
  self notify("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", value);
  level notify("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", value);
  self setclientomnvar("so\x1b\xf3].\x86\xbb>\x0e-Q;\x1a\x8e3\xfd\xcd\x1eu\x1a-\xc8\xbfy\x8d\xad\x9d\xb1\x9b\xe9\xb00\xee", 0);
  self setclientomnvar("\xef\x980\x98f\fCr\xf4{$fl1\x9c\xbf\x1d\x84\xe0", 0);
}

function private function_53f70b0a39a5e864(value) {
  level notify("-\x80\x9f\xf4zG\xc7\xb7\xbb\x15J<4\xfd@\v/H\x95\x96\xc9G\xf7~");
}

function function_8b6af0af020188d8(choices) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  if(isDefined(choices) && isDefined(choices.size)) {
    level.waitingforresponse = 1;
    selectedoption = -1;

    while(level.waitingforresponse) {
      kbmkeypressed = utility::waittill_any_return("\x13_\x17sU\xed\x87\xbd<\tmI\xb2\xdf^\xdd\xd0\\\x19\xbf\"mK\xf9xMm\x97");

      if(choices.size > 0 && kbmkeypressed.optindex == 1) {
        selectedoption = 0;
        level.waitingforresponse = 0;
      } else if(choices.size > 1 && kbmkeypressed.optindex == 2) {
        selectedoption = 1;
        level.waitingforresponse = 0;
      } else if(choices.size > 2 && kbmkeypressed.optindex == 3) {
        selectedoption = 2;
        level.waitingforresponse = 0;
      } else if(choices.size > 3 && kbmkeypressed.optindex == 4) {
        selectedoption = 3;
        level.waitingforresponse = 0;
      }

      if(!level.waitingforresponse) {
        level notify("k\xb3\x1b\xfcF\xc4\x80Bk\x7f\x91\xe6j\xd0\xc3Z\xe0\x96\x9b\xf6\xaf\x9eDA\xc53N", selectedoption);
      }

      waitframe();
    }
  }
}

function function_18cbe52333fe78b3(old_indices, new_indices, choices) {
  var_25f9890ac91b8af3 = old_indices[0];
  var_c03ff413ed56108 = new_indices[0];
  var_623bd361af8a6cb7 = var_c03ff413ed56108;

  while(choices[var_623bd361af8a6cb7] function_d91992e892556edf()) {
    if(var_c03ff413ed56108 < var_25f9890ac91b8af3) {
      var_623bd361af8a6cb7--;
    } else {
      var_623bd361af8a6cb7++;
    }

    if(var_623bd361af8a6cb7 < 0 || var_623bd361af8a6cb7 >= choices.size) {
      var_623bd361af8a6cb7 = var_25f9890ac91b8af3;
      break;
    }
  }

  if(var_623bd361af8a6cb7 != var_25f9890ac91b8af3) {}

  return [var_623bd361af8a6cb7, 0];
}

function function_d4f8c4fdf7bfcd03(choices, ai_actor, quick_clear) {
  if(!isDefined(quick_clear)) {
    quick_clear = 0;
  }

  if(!quick_clear) {
    ai_actor utility::waittill_notify_or_timeout("<\xa5T\xc8\xacQUE\xfe\xd1\xa0oq\xc49\xf0\xd7\xd8k\x8f\xf6\x88Q\xe2Y\xc4Xj8", 1.5);
  }

  hud_management::function_908e2205a6516f5d("T\x9f\xd3~z\x12\x04$\xc5\xe6r");
  ai_actor utility::ent_flag_clear("Dx\x991\xc0\x16\x8f\x03R\xf7\x14\xa8I\xf9\x91v]\xf0\x81\x01");
}

function function_ecacfa1e7f3e2e5b(position, state_index, param_ref) {
  hud_management::function_91ff36a22dc2c60e("T\x9f\xd3~z\x12\x04$\xc5\xe6r", hud_management::function_a1a13273e72bfe46("n$Z\x0e\xe6\xe8\x86\xa0\x90s!\xde\xfc\xcb8\x17DgbhkQw\xd0Dg>"));
  hud_management::function_85d8a0ba2e35b6f2("T\x9f\xd3~z\x12\x04$\xc5\xe6r", position.horzoffset, position.vertoffset, position.horzalign, position.vertalign, 1);
  hud_management::function_b683400f784cb7dc("T\x9f\xd3~z\x12\x04$\xc5\xe6r", param_ref);
}

function private function_a080a22223df2fc4(player_pos) {
  if(isDefined(player_pos) && isDefined(player_pos.var_792e0f4487021d96)) {
    return 1;
  }

  return 0;
}

function private function_ef98749681c8733b(anim_struct, ai_actor) {
  if(!isDefined(anim_struct)) {
    if(isDefined(ai_actor.var_b6adac95e3d5943c)) {
      anim_struct = ai_actor.var_b6adac95e3d5943c;
    } else {
      anim_struct = ai_actor;
    }
  }

  return anim_struct;
}

function private function_20f998165ab8a5c(template_name, ai_actor) {
  template_name = self.anim_template;
  struct = self.template_struct;
  player_positions = self.var_b82409fa4c439a37;

  if(isDefined(player_positions)) {
    if(!isarray(player_positions)) {
      player_positions = [player_positions];
    }

    foreach(pos in player_positions) {
      bundle = namespace_6f793d3cf96d68f::function_ea78b4318e27edea(template_name);
      pos = tolower(pos);
      pos_info = namespace_6f793d3cf96d68f::function_88d6e629a3116c84(template_name, pos);
      idle = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(template_name, "\x91\x88\xc2*");
      dt_idle = namespace_6f793d3cf96d68f::function_8ed66d64a89a92cd(template_name, "R\\\xfe\xb5\xd1\xf6\xd3");
      assert(isDefined(pos_info), "<dev string:x35e>" + pos);
      function_3ec1c37f9b2c85d4(undefined, pos_info.enter_shot, dt_idle, pos_info.exit_shot, idle, undefined, undefined, undefined, undefined, undefined, bundle, struct);
    }

    self.var_b82409fa4c439a37 = undefined;
  }
}

function function_f7934db5b1c0596d(ai_actor) {
  if(isDefined(self.template_struct) && !isDefined(self.template_struct.origin)) {
    self.template_struct.origin = ai_actor.origin;
    self.template_struct.angles = ai_actor.angles;
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function private function_ddbb467848fce81a() {
  if(isai(self)) {
    self setanim(%\x0f\xd7\x1aI\x10\x93\xac\xed]\xa8\xa0\xd1\x92(\xa4\x0e\xa7\xbe\xd0\xfa\x98\x82\x19\xfd\xed\xec\x9bx\xd4\xa8 % $Q\xb5, 1);
    utility::function_18e9f1084badc1c7("\xcd\xaa\x9b\x05Zq}'\x1f\xef\xeb\f~ \x848#)");
    self setanim(%\x0f\xd7\x1aI\x10\x93\xac\xed]\xa8\xa0\xd1\x92(\xa4\x0e\xa7\xbe\xd0\xfa\x98\x82\x19\xfd\xed\xec\x9bx\xd4\xa8 % $Q\xb5, 0, 1);
  }
}