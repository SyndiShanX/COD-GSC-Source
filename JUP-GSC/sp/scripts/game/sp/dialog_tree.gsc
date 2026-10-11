/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\game\sp\dialog_tree.gsc
***********************************************/

#using script_39b1f0d056a0c138;
#using script_72ef6b9f0cf1f55a;
#using script_7921358c02f87a25;
#using scripts\anim\dialogue;
#using scripts\common\ai_lookat;
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace dialog_tree;

function private autoexec function_85c4374b5e2ec4b1() {
  level.var_53e726a5ce0f4530 = [];
  level.var_53e726a5ce0f4530["none"] = undefined;
  level.var_53e726a5ce0f4530["slight_zoom"] = 55;
  level.var_53e726a5ce0f4530["zoom"] = 45;
  level.var_53e726a5ce0f4530["more_zoom"] = 35;
  level.var_53e726a5ce0f4530["extreme_zoom"] = 25;
  level.var_7c1687cb471e91d2 = [];
  level.var_daa9346aafb503a2["close"] = 1;
  level.var_daa9346aafb503a2["medium"] = 2.8;
  flag_init("dialog_tree_active");
  flag_init("prompts_disabled");
  scripts\common\ui::lui_registercallback("dialog_tree_option_selected", &function_26cc8ab8ee78d07f);
  scripts\common\ui::lui_registercallback("dialog_tree_request_skip", &function_e70848b1ace60b2d);
}

function new_tree(enter_func, exit_func, allow_movement, allow_weapon, script_bundle, var_7c495f86e82a2621, timeout, skippable, force_headlook) {
  if(!isDefined(allow_movement)) {
    allow_movement = 0;
  }

  if(!isDefined(allow_weapon)) {
    allow_weapon = 0;
  }

  if(!isDefined(var_7c495f86e82a2621)) {
    var_7c495f86e82a2621 = 1;
  }

  if(!isDefined(timeout)) {
    timeout = 0;
  }

  if(!isDefined(skippable)) {
    skippable = 1;
  }

  if(!isDefined(force_headlook)) {
    force_headlook = 1;
  }

  new_dialog = spawnStruct();
  new_dialog.selected_options = 0;
  new_dialog.player_pos = [];
  new_dialog.enter_func = enter_func;
  new_dialog.exit_func = exit_func;
  new_dialog.allow_movement = allow_movement;
  new_dialog.allow_weapon = allow_weapon;
  new_dialog.var_7c495f86e82a2621 = var_7c495f86e82a2621;
  new_dialog.timeout = timeout;
  new_dialog.skippable = skippable;
  new_dialog.force_headlook = force_headlook;
  new_dialog.var_b11619776bfbfa3a = 0;
  new_dialog.options = [];
  new_dialog.position = (1224, 650, 0);
  new_dialog.state_index = 0;
  new_dialog.temp_disabled = 0;
  new_dialog.var_6d8359c75fd25cf8 = &"T10_DIALOG_TREE/NOT_SAFE_FOR_CONVERSATION";
  new_dialog set_scriptbundle(script_bundle);
  new_dialog.var_ae6649775a3f3762 = 0;
  return new_dialog;
}

function set_scriptbundle(bundle, default_idle, include_actors) {
  if(isDefined(bundle)) {
    if(isstring(bundle)) {
      self.scriptbundle = bundle;
    } else if(isDefined(bundle.script_scenescriptbundle)) {
      self.scriptbundle = bundle.script_scenescriptbundle;
    } else {
      assert("dialog_tree: set_scriptbundle: Invalid script bundle parameter: " + bundle);
    }

    self.var_ea8cafa6b0eb06c7 = default_idle;
  }

  if(isDefined(include_actors)) {
    if(!isarray(include_actors)) {
      include_actors = [include_actors];
    }

    self.include_actors = include_actors;
  }
}

function function_ddef287c20089430(template_name, player_positions) {
  function_efafec9a80234daa(template_name);
  self.anim_template = template_name;
  self.var_2c6249da4d27ca4e = player_positions;
  self.template_struct = spawnStruct();
}

function add_option(option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  if(!isDefined(end_dialog)) {
    end_dialog = 0;
  }

  option = function_90cdd85860a9e8df(undefined, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, undefined, selected_func, func_parameter, skip_func);
  return function_896a08d617c4a4e4(option);
}

function function_26412a0fc619f981(var_176104ebd5b06dab, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  option = function_90cdd85860a9e8df(undefined, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, var_176104ebd5b06dab, selected_func, func_parameter, skip_func);
  return function_896a08d617c4a4e4(option);
}

function function_db717f41559f6cab(expire_count, expire_flag, reset, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  if(!isDefined(reset)) {
    reset = 1;
  }

  option = function_90cdd85860a9e8df(undefined, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, undefined, selected_func, func_parameter, skip_func, 0, expire_count, expire_flag, reset);
  return function_896a08d617c4a4e4(option);
}

function function_eb25fb6b87dd57d3(option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  var_e9a574a5ef884c9d = self.options.size - 1;
  option = function_90cdd85860a9e8df(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_896a08d617c4a4e4(option);
}

function function_82c7d1482d815396(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  option = function_90cdd85860a9e8df(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_896a08d617c4a4e4(option);
}

function function_a7b448f1ff4bdf88(var_176104ebd5b06dab, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  var_e9a574a5ef884c9d = self.options.size - 1;
  option = function_90cdd85860a9e8df(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, var_176104ebd5b06dab, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_896a08d617c4a4e4(option);
}

function function_8495817a14e39bcf(var_e9a574a5ef884c9d, var_176104ebd5b06dab, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  option = function_90cdd85860a9e8df(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, var_176104ebd5b06dab, selected_func, func_parameter, skip_func);
  option.active = 0;
  return function_896a08d617c4a4e4(option);
}

function function_694b58fb71ff8739(var_e9a574a5ef884c9d, expire_count, expire_flag, reset, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, selected_func, func_parameter, skip_func) {
  if(!isDefined(reset)) {
    reset = 1;
  }

  option = function_90cdd85860a9e8df(var_e9a574a5ef884c9d, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, undefined, selected_func, func_parameter, skip_func, 0, expire_count, expire_flag, reset);
  option.active = 0;
  return function_896a08d617c4a4e4(option);
}

function function_836a91a25a0959ea(option_id, end_dialog) {
  if(!isDefined(end_dialog)) {
    end_dialog = 1;
  }

  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].end_dialog = end_dialog;
}

function function_20db3ae16c16a034(option_id, quick_exit) {
  if(!isDefined(quick_exit)) {
    quick_exit = 1;
  }

  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].end_dialog = 1;
  self.options[option_id].quick_exit = quick_exit;
}

function function_ad302d4c644188ca(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].pin_bottom = 1;
  self.var_b11619776bfbfa3a = 1;
}

function function_985eb5a1a4780d17(flag_array, option_id) {
  option_id = function_efa6071d5c0c7cf6(option_id);
  assertex(!isDefined(self.options[option_id].var_79a2e334ef20037c) && !isDefined(self.options[option_id].var_e4ef57c233595c4c), "option_unlock_on_all_flags called on an option with activation flag(s) already set!");
  self.options[option_id].locked = 1;

  if(isarray(flag_array)) {
    self.options[option_id].var_79a2e334ef20037c = flag_array;
    return;
  }

  self.options[option_id].var_79a2e334ef20037c = [flag_array];
}

function function_fe57780a219892e1(flag_array, option_id) {
  option_id = function_efa6071d5c0c7cf6(option_id);
  assertex(!isDefined(self.options[option_id].var_79a2e334ef20037c) && !isDefined(self.options[option_id].var_e4ef57c233595c4c), "option_unlock_on_any_flag called on an option with activation flag(s) already set!");
  self.options[option_id].locked = 1;

  if(isarray(flag_array)) {
    self.options[option_id].var_e4ef57c233595c4c = flag_array;
    return;
  }

  self.options[option_id].var_e4ef57c233595c4c = [flag_array];
}

function function_409b8682ff1c1175(flag_array, option_id) {
  option_id = function_efa6071d5c0c7cf6(option_id);
  assertex(!isDefined(self.options[option_id].var_9e70d6ccc832341) && !isDefined(self.options[option_id].var_43d0b8282bd404df), "option_repeat_until_all_flags called on an option with repeat flag(s) already set!");

  if(isarray(flag_array)) {
    self.options[option_id].var_9e70d6ccc832341 = flag_array;
    return;
  }

  self.options[option_id].var_9e70d6ccc832341 = [flag_array];
}

function function_7836816fa6ccc853(flag_array, option_id) {
  option_id = function_efa6071d5c0c7cf6(option_id);
  assertex(!isDefined(self.options[option_id].var_9e70d6ccc832341) && !isDefined(self.options[option_id].var_43d0b8282bd404df), "option_repeat_until_any_flag called on an option with repeat flag(s) already set!");

  if(isarray(flag_array)) {
    self.options[option_id].var_43d0b8282bd404df = flag_array;
    return;
  }

  self.options[option_id].var_43d0b8282bd404df = [flag_array];
}

function function_3c28bcef9ae8e464(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].important = 1;
}

function function_431f560b1728a0cd(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  self.options[option_id].show_locked = 1;
}

function function_b67633ee02ae6b2(option_id, var_9a5c68dcc5c8bd6d, cycle_style, vo_lines, anims) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  if(!isDefined(var_9a5c68dcc5c8bd6d)) {
    var_9a5c68dcc5c8bd6d = 0;
  }

  if(!isDefined(cycle_style)) {
    cycle_style = "loop";
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

      if(var_9a5c68dcc5c8bd6d) {
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

      if(var_9a5c68dcc5c8bd6d) {
        self.options[option_id].cur_anim = randomint(self.options[option_id].anim_npc.size);
        return;
      }

      self.options[option_id].cur_anim = 0;
    }
  }
}

function function_787240d6c2742ddc(message, var_2910bcf7078c9f81) {
  self.temp_disabled = 1;

  if(isDefined(message)) {
    self.var_6d8359c75fd25cf8 = message;
  }

  if(isDefined(var_2910bcf7078c9f81)) {
    flag_wait(var_2910bcf7078c9f81);
    self.temp_disabled = 0;
  }
}

function function_dc13a584a0aa03f9() {
  self.temp_disabled = 0;
}

function function_b4bb4d1ddabc5697(dialog_tree, var_c7db93f999bd20d8) {
  assert(isDefined(dialog_tree) && isarray(var_c7db93f999bd20d8) && isint(var_c7db93f999bd20d8[0]) && isint(var_c7db93f999bd20d8[1]), "position2D must be an array of integer values");
  dialog_tree.position = var_c7db93f999bd20d8;
}

function function_603c5988986065f9(state_index) {
  self.state_index = state_index;
}

function function_20c528b5c4f4eac1(player_loc, var_5df695ba8d6a39fb, var_8b9d7241bd481e99, var_d35bbd317ecfb67b, var_6874582d5c9ff240, stance, fov, dof, lerptime, frame_position, override_scene, override_struct) {
  if(!isDefined(stance)) {
    stance = "stand";
  }

  if(!isDefined(fov)) {
    fov = "more_zoom";
  }

  if(!isDefined(dof)) {
    dof = "medium";
  }

  if(!isDefined(lerptime)) {
    lerptime = 2;
  }

  if(!isDefined(frame_position)) {
    frame_position = "left";
  }

  new_pos = spawnStruct();
  new_pos.player_loc = player_loc;

  if(isDefined(player_loc)) {
    new_pos.origin = player_loc.origin;
  }

  new_pos.var_5df695ba8d6a39fb = var_5df695ba8d6a39fb;
  new_pos.var_26380da9bb0a366 = var_8b9d7241bd481e99;
  new_pos.var_d35bbd317ecfb67b = var_d35bbd317ecfb67b;
  new_pos.var_6874582d5c9ff240 = var_6874582d5c9ff240;
  new_pos.stance = stance;
  new_pos.fov = fov;
  new_pos.dof = dof;
  new_pos.lerptime = lerptime;
  new_pos.frame_pos = frame_position;
  new_pos.override_scene = override_scene;
  new_pos.override_struct = override_struct;
  self.player_pos[self.player_pos.size] = new_pos;
}

function add_greeting(vo_line, delay_before, delay_after, actor) {
  assert(isDefined(vo_line), "add_greeting called with no vo_line!");
  self.greetings = function_5b314449d3e0df23(self.greetings, vo_line, delay_before, delay_after, actor);
}

function function_f5c480aca0b8155d(vo_line, delay_before, delay_after, actor) {
  assert(isDefined(vo_line), "add_exhaustion called with no vo_line!");
  self.exhaustions = function_5b314449d3e0df23(self.exhaustions, vo_line, delay_before, delay_after, actor);
}

function set_exhausted(exhausted) {
  if(!isDefined(exhausted)) {
    exhausted = 1;
  }

  self.exhausted = exhausted;
}

function get_exhausted() {
  var_facd509222059348 = 0;

  if(isDefined(self.exhausted) && self.exhausted == 1 || function_3041b446fbb7cebe(1) <= var_facd509222059348) {
    return true;
  }

  return false;
}

function play_greeting(ai_actor) {
  self.cur_greeting = function_9f1af335b72ba436(self.greetings, self.cur_greeting, ai_actor);
}

function function_a61e244dd0bb1ae4(ai_actor) {
  if(isDefined(self.exhaustions) && get_exhausted()) {
    self.var_7818a30c28de7142 = function_9f1af335b72ba436(self.exhaustions, self.var_7818a30c28de7142, ai_actor);
    return true;
  }

  return false;
}

function private function_5b314449d3e0df23(vo_array, vo_line, delay_before, delay_after, actor) {
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

function private function_9f1af335b72ba436(vo_array, var_24bc875dca80abdd, ai_actor) {
  if(!isDefined(vo_array)) {
    return -1;
  }

  if(!isDefined(var_24bc875dca80abdd)) {
    var_24bc875dca80abdd = -1;
  }

  var_24bc875dca80abdd = function_4c99d8252f8b3ae6(var_24bc875dca80abdd, vo_array.size, "randomize");
  vo_struct = vo_array[var_24bc875dca80abdd];
  vo_line = vo_struct.vo_line;

  if(isDefined(vo_struct.actor)) {
    ai_actor = vo_struct.actor;
  }

  if(isDefined(vo_struct.pre_delay)) {
    wait vo_struct.pre_delay;
  }

  if(soundexists(vo_line)) {
    if(isai(ai_actor)) {
      ai_actor stop_dialogue();
      waitframe();
      ai_actor smart_dialogue(vo_line);
    } else if(!isDefined(ai_actor) || ai_actor == level) {
      self.activator smart_radio_dialogue(vo_line);
    } else {
      ai_actor playsoundonentity(vo_line, vo_line + "_complete");
    }
  } else {
    if(ai_actor != level && ai_actor != level.player) {
      ai_actor thread dialogue_print(vo_line);
    } else {
      iprintlnbold(vo_line);
    }
  }

  if(isDefined(vo_struct.post_delay)) {
    wait vo_struct.post_delay;
  }

  return var_24bc875dca80abdd;
}

function function_4c99d8252f8b3ae6(cur_idx, num_choices, cycle_option) {
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

    if(cycle_option == "randomize" || cycle_option == "randomize_skip_first") {
      first_option = 0;

      if(cycle_option == "randomize_skip_first") {
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

function function_d61b10a951adbc62(ai_actor, anim_struct) {
  var_fba45646132ed63a = 4.32;
  player = self.activator;

  if(isDefined(self.anim_template) && isDefined(self.var_2c6249da4d27ca4e)) {
    function_3274dd5fa9090931();
  }

  if(isDefined(self.player_pos) && self.player_pos.size > 0) {
    foreach(pos in self.player_pos) {
      if(isDefined(ai_actor) && hastag(ai_actor.model, "tag_eye")) {
        ai_pos = spawnStruct();
        ai_pos.origin = ai_actor gettagorigin("tag_eye");
        ai_pos.angles = ai_actor.angles;
      }

      future_pos = undefined;

      if(isDefined(pos.var_5df695ba8d6a39fb)) {
        bundle = self.scriptbundle;
        struct = anim_struct;

        if(isDefined(pos.override_scene)) {
          bundle = pos.override_scene;
        }

        if(isDefined(pos.override_struct)) {
          struct = pos.override_struct;
        }

        player_objs = scene::function_77751080050d2cb1("Types_Player", pos.var_5df695ba8d6a39fb, bundle);

        if(player_objs.size > 0) {
          pos.var_5e5b24e8b8fc017f = 1;
          future_pos = function_de02ae5fe5a079a(player_objs[0], struct, bundle, pos.var_5df695ba8d6a39fb);
        } else {
          var_c67a1c0590a28018 = function_dd230b54e233f4bd(ai_actor, struct, bundle, pos.var_5df695ba8d6a39fb);

          if(isDefined(var_c67a1c0590a28018)) {
            ai_pos = var_c67a1c0590a28018;
            future_pos = spawnStruct();
            future_pos.origin = (ai_pos.origin[0], ai_pos.origin[1], ai_actor.origin[2] + var_fba45646132ed63a);
            future_pos.angles = ai_pos.angles;
          }
        }
      }

      if(!isDefined(pos.player_loc)) {
        pos.player_loc = spawnStruct();
        self.position = (1224, 650, 0);

        if(isDefined(pos.var_5e5b24e8b8fc017f) && isDefined(future_pos)) {
          pos.player_loc = future_pos;
        } else {
          side_offset = 5;
          angle_offset = 12;

          if(pos.frame_pos == "right") {
            side_offset *= -1;
            angle_offset *= -1;
          }

          pos.player_loc.origin = ai_pos.origin + anglesToForward(ai_pos.angles) * 56 + anglestoright(ai_pos.angles) * side_offset;
          pos.player_loc.origin = (pos.player_loc.origin[0], pos.player_loc.origin[1], ai_actor.origin[2] + var_fba45646132ed63a);
          pos.player_loc.angles = ai_pos.angles + (0, 180, 0) - (0, angle_offset, 0);
          player_fwd = anglesToForward(pos.player_loc.angles);
          player_eye = pos.player_loc.origin + (0, 0, level.player getplayerviewheight(pos.stance));
          var_4c5621dabf9fe966 = ai_pos.origin - (0, 0, 6) - player_eye;

          if(player_eye[2] - ai_pos.origin[2] > 18) {
            var_4c5621dabf9fe966 = ai_pos.origin - player_eye;
          }

          pos.player_loc.angles = (vectortoangles(var_4c5621dabf9fe966)[0], pos.player_loc.angles[1], pos.player_loc.angles[2]);
        }

        pos.origin = pos.player_loc.origin;
      }
    }

    closest_pos = getclosest(player.origin, self.player_pos);
    ai_actor.var_25bf3c46b0b8d3c8 = closest_pos;
    self.position = (1224, 650, 0);

    if(closest_pos.frame_pos == "right") {
      self.position = (240, 650, 0);
    }

    if(isDefined(closest_pos.stance)) {
      switch (closest_pos.stance) {
        case #"hash_c6775c88e38f7803":
          self.activator val::set("dialog_tree", "crouch", 0);
          self.activator val::set("dialog_tree", "prone", 0);
          self.activator val::set("dialog_tree", "stand", 1);
          break;
        case #"hash_3fed0cbd303639eb":
          self.activator val::set("dialog_tree", "crouch", 1);
          self.activator val::set("dialog_tree", "prone", 0);
          self.activator val::set("dialog_tree", "stand", 0);
          break;
        case #"hash_d91940431ed7c605":
          self.activator val::set("dialog_tree", "crouch", 0);
          self.activator val::set("dialog_tree", "prone", 1);
          self.activator val::set("dialog_tree", "stand", 0);
          break;
      }

      player setstance(closest_pos.stance);
    }

    self.activator val::set("dialog_tree", "allow_movement", 0);

    if(isPlayer(player)) {
      self.activator hideonclient(player);
    }

    ai_actor thread handle_camera_adjustments(closest_pos);

    if(!isDefined(closest_pos.var_5e5b24e8b8fc017f)) {
      self.player_linkto = player spawn_tag_origin(closest_pos.player_loc.origin, closest_pos.player_loc.angles);
      self.player_linkto dontinterpolate();
      ai_actor notify("DT_camera_adjustments");
      targ_pos = self.player_linkto gettagorigin("tag_origin");

      if(targ_pos == (0, 0, 0) || distance(player.origin, targ_pos) > 256) {
        player show();
      } else {
        self.player_linkto.prev_origin = player.origin;
        player playerlinktoblend(self.player_linkto, "tag_origin", closest_pos.lerptime, closest_pos.lerptime * 0.25, closest_pos.lerptime * 0.5);
        thread function_4efb78e6627f5cda(player);
      }
    }

    thread function_44d159250853c75f(ai_actor, anim_struct, closest_pos);
    ai_actor waittill_any("dialog_tree_show_choices", "_dt_enter_anims_complete");
    ai_actor notify("DT_camera_adjustments");
  }
}

function private handle_camera_adjustments(closest_pos) {
  if(isDefined(closest_pos.fov) && isDefined(level.var_53e726a5ce0f4530[closest_pos.fov])) {
    level.player lerpfov(level.var_53e726a5ce0f4530[closest_pos.fov], closest_pos.lerptime, closest_pos.lerptime * 0.25, closest_pos.lerptime * 0.5);
  }

  if(isDefined(closest_pos.dof) && isDefined(level.var_daa9346aafb503a2[closest_pos.dof]) && closest_pos.dof != "none") {
    if(isDefined(self) && isactor(self)) {
      level.player thread utility::dof_enable_autofocus(level.var_daa9346aafb503a2[closest_pos.dof], self, 50, closest_pos.lerptime, undefined, "tag_eye", undefined, 1);
      return;
    }

    level.player thread utility::dof_enable_autofocus(level.var_daa9346aafb503a2[closest_pos.dof], undefined, 50, closest_pos.lerptime, undefined, undefined, undefined, 1);
  }
}

function function_4efb78e6627f5cda(player) {
  wait 2;

  if(!self.allow_movement) {
    player playerlinktodelta(self.player_linkto, "tag_origin", 1, 10, 10, 5, 5, 1, 1);
  } else {
    player unlink();
    self.player_linkto = undefined;
    self.activator val::reset("dialog_tree", "allow_movement");
  }

  player show();
}

function function_de02ae5fe5a079a(player_obj, struct, scene, shot) {
  fake_player = spawn("script_model", level.player.origin);
  fake_player setModel(player_obj.sceneobject.variant_object.xmodelname);
  fake_player.angles = level.player.angles;
  fake_player scripts\engine\sp\utility::assign_animtree("player");
  fake_player hide();
  enter_animations = struct scene::function_10a1cbb13da3a4fe(player_obj.sceneobject.variant_object.name, shot, scene);
  enter_animation = enter_animations[enter_animations.size - 1];
  alignmentinfo = struct scene::function_6cb938788c210309(player_obj.sceneobject.variant_object.name, shot, scene);
  fake_player animScripted("gettingpos", alignmentinfo.origin, alignmentinfo.angles, enter_animation, undefined, undefined, 0, 0);

  if(!animislooping(enter_animation)) {
    fake_player setanimtime(enter_animation, 1);
  }

  fake_player dontinterpolate();
  wait 0.05;
  pos_info = spawnStruct();
  pos_info.origin = fake_player gettagorigin("tag_origin");
  pos_info.angles = fake_player gettagangles("tag_origin");
  fake_player delete();
  return pos_info;
}

function function_dd230b54e233f4bd(ai_actor, struct, scene, shot) {
  if(isDefined(ai_actor)) {
    pos_info = spawnStruct();
    pos_info.origin = ai_actor gettagorigin("tag_eye");
    pos_info.angles = ai_actor gettagangles("tag_origin");

    if(isDefined(scene) && isDefined(shot) && isDefined(struct)) {
      fakeai = spawn("script_model", ai_actor.origin);
      fakeai setModel(ai_actor.model);
      fakeai.angles = ai_actor.angles;
      fakeai.targetname = ai_actor.targetname;
      fakeai.animname = ai_actor.animname;
      fakeai scripts\sp\utility::assign_human_animtree();
      fakeai hide();
      enter_animations = struct scene::function_10a1cbb13da3a4fe(fakeai.animname, shot, scene);
      enter_animation = enter_animations[enter_animations.size - 1];
      alignmentinfo = struct scene::function_6cb938788c210309(fakeai.animname, shot, scene);

      if(isDefined(enter_animation)) {
        fakeai animScripted("gettingpos", alignmentinfo.origin, alignmentinfo.angles, enter_animation, undefined, undefined, 0, 0);
        fakeai setanimtime(enter_animation, 1);
        fakeai dontinterpolate();
        wait 0.05;
        pos_info.origin = fakeai gettagorigin("tag_eye");
        pos_info.angles = fakeai gettagangles("tag_origin");
      }

      fakeai delete();
    }

    return pos_info;
  }

  return undefined;
}

function function_44d159250853c75f(ai_actor, struct, player_pos) {
  if(!isDefined(player_pos.override_scene)) {
    player_pos.override_scene = self.scriptbundle;
  }

  if(!isDefined(player_pos.override_struct)) {
    player_pos.override_struct = struct;
  }

  bundle = player_pos.override_scene;
  scene_struct = player_pos.override_struct;
  actor_list = function_27e66e2cf814c5e4(ai_actor);

  if(isDefined(bundle)) {
    if(isDefined(player_pos.var_5df695ba8d6a39fb)) {
      scene_struct scene::play(actor_list, player_pos.var_5df695ba8d6a39fb, bundle);
    } else {
      waitframe();
    }
  } else {
    waitframe();
  }

  ai_actor notify("_dt_enter_anims_complete");
  start_idle = self.var_ea8cafa6b0eb06c7;

  if(isDefined(player_pos.var_26380da9bb0a366)) {
    start_idle = player_pos.var_26380da9bb0a366;
  }

  if(isDefined(self.anim_template)) {
    start_idle = function_7dc5dc6ca7fc72c4(self.anim_template, "dt_idle");
    bundle = function_d66c0bfe054fd887(self.anim_template);
    scene_struct = self.template_struct;
  }

  if(isDefined(start_idle)) {
    scene_struct thread scene::play(actor_list, start_idle, bundle);
  }
}

function function_b0728c7b89fee84(ai_actor, struct, player_pos) {
  if(isDefined(player_pos)) {
    bundle = self.scriptbundle;
    exit_struct = struct;

    if(isDefined(player_pos.fov)) {
      lerptime = player_pos.lerptime * 0.5;
      level.player lerpfov(ai_actor.var_31abe8aab080e9f7, lerptime, lerptime * 0.25, lerptime * 0.5);
    }

    if(isDefined(player_pos.dof)) {
      if(isDefined(ai_actor) && isactor(ai_actor)) {
        level.player utility::dof_disable_autofocus();
      } else {
        level.player utility::dof_disable_autofocus();
      }
    }

    if(isDefined(player_pos.override_scene)) {
      bundle = player_pos.override_scene;
    }

    if(isDefined(player_pos.override_struct)) {
      exit_struct = player_pos.override_struct;
    }

    if(isDefined(bundle)) {
      actor_list = function_27e66e2cf814c5e4(ai_actor);

      if(isDefined(player_pos.var_d35bbd317ecfb67b)) {
        ai_actor notify("dialog_tree_exit_anim");
        ai_actor ent_flag_set("_dialog_exit_anim");
        exit_struct scene::play(actor_list, player_pos.var_d35bbd317ecfb67b, bundle);
        ai_actor ent_flag_clear("_dialog_exit_anim");
      }

      ai_actor notify("dialog_tree_exit_anim_complete");

      if(isDefined(player_pos.var_6874582d5c9ff240)) {
        exit_struct thread scene::play(actor_list, player_pos.var_6874582d5c9ff240, bundle);
      }
    }
  }
}

function function_77875203287214db(dialog_tree, anim_struct, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_31d55a939e9cbc7a, interactstringoverride) {
  level.player endon("death");
  dialog_tree endon("delete");

  if(isDefined(self) && isai(self) && !isalive(self)) {
    println("<dev string:x1c>" + self.name + "<dev string:x5a>");
    return;
  }

  if(!isDefined(kill_notify)) {
    kill_notify = "dialog_wait_cancel";
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

  if(!isDefined(var_31d55a939e9cbc7a)) {
    var_31d55a939e9cbc7a = 0;
  }

  anim_struct = function_a10c80dbb1f95f26(anim_struct, self);
  self.radius = 2.5;

  if(self tagexists("j_spine4")) {
    tagname = "j_spine4";
  } else {
    tagname = undefined;
  }

  interactstring = &"T10_DIALOG_TREE/TALK_TO";

  if(isDefined(interactstringoverride)) {
    interactstring = interactstringoverride;
  }

  if(isDefined(dialog_tree.anim_template)) {
    dialog_tree function_607273064331d2b8(self);

    if(!ent_flag("scene_active")) {
      idle_anim = function_7dc5dc6ca7fc72c4(dialog_tree.anim_template, "idle");
      bundle = function_d66c0bfe054fd887(dialog_tree.anim_template);
      struct = dialog_tree.template_struct;
      actor_list = dialog_tree function_27e66e2cf814c5e4(self);
      struct thread scene::play(actor_list, idle_anim, bundle);
    }
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(tagname, use_offset, interactstring, undefined, display_dist, use_dist, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, use_angles);
  msg = waittill_any_return("trigger", "death", "start_context_melee", "deleted", kill_notify, "_dt_cancel_interaction");

  if(msg == "trigger") {
    return dialog_tree run(self, anim_struct, timer, level.player, var_31d55a939e9cbc7a);
  }

  scripts\sp\player\cursor_hint::remove_cursor_hint();
  return;
}

function function_3907588e683bb352(dialog_tree, anim_struct, end_flags, var_8340f2036ada799c, var_12e3cdec8fa929ac, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_31d55a939e9cbc7a, interactstringoverride) {
  level.player endon("death");
  self endon("death");
  dialog_tree endon("delete");

  if(isDefined(end_flags) && !isarray(end_flags)) {
    end_flags = [end_flags];
  }

  if(!isDefined(end_flags)) {
    end_flags = [];
  }

  if(isDefined(var_8340f2036ada799c) && !isarray(var_8340f2036ada799c)) {
    var_8340f2036ada799c = [var_8340f2036ada799c];
  }

  if(!isDefined(var_8340f2036ada799c)) {
    var_8340f2036ada799c = [];
  }

  if(var_8340f2036ada799c.size > 0) {
    flag_waitopen_all_array(var_8340f2036ada799c);
  }

  if(!isDefined(var_12e3cdec8fa929ac)) {
    var_12e3cdec8fa929ac = 2;
  }

  while(end_flags.size == 0 || !flag_any(end_flags)) {
    childthread _dt_handle_disable_flags(end_flags, var_8340f2036ada799c, kill_notify);
    function_77875203287214db(dialog_tree, anim_struct, timer, kill_notify, use_dist, display_dist, use_angles, use_offset, var_31d55a939e9cbc7a, interactstringoverride);
    ent_flag_waitopen("_dialog_exit_anim");

    if(isDefined(var_12e3cdec8fa929ac)) {
      wait var_12e3cdec8fa929ac;
    }

    if(var_8340f2036ada799c.size > 0) {
      flag_waitopen_all_array(var_8340f2036ada799c);
    }
  }
}

function private _dt_handle_disable_flags(end_flags, var_8340f2036ada799c, kill_notify) {
  self notify("_dt_handle_disable_flags");
  self endon("_dt_handle_disable_flags");

  if(isDefined(kill_notify)) {
    self endon(kill_notify);
  }

  flag_array = array_combine(end_flags, var_8340f2036ada799c);

  if(flag_array.size > 0) {
    flag_wait_any_array(flag_array);
  }

  self notify("_dt_cancel_interaction");
}

function run(ai_actor, anim_struct, timer, activator, var_31d55a939e9cbc7a, var_b763c53f8a399479, var_6a5d78d46f3a9e2) {
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

  if(!isDefined(var_31d55a939e9cbc7a)) {
    var_31d55a939e9cbc7a = 0;
  }

  if(!isDefined(var_b763c53f8a399479)) {
    var_b763c53f8a399479 = 4;
  }

  if(!isDefined(var_6a5d78d46f3a9e2)) {
    var_6a5d78d46f3a9e2 = 0;
  }

  function_607273064331d2b8(ai_actor);

  if(!isDefined(self.activator)) {
    return -1;
  }

  self.activator endon("death");

  if(function_a61e244dd0bb1ae4(ai_actor)) {
    return -1;
  }

  ai_actor notify("dialog_active");

  if(!isDefined(ai_actor.var_41fc4f898c255d37)) {
    ai_actor.var_41fc4f898c255d37 = 0;
  }

  ai_actor.var_41fc4f898c255d37++;
  anim_struct = function_a10c80dbb1f95f26(anim_struct, ai_actor);

  if(self.skippable) {
    thread function_952cfa1c522b5457(ai_actor, anim_struct);
  }

  ai_actor function_6fcfd605093266bb("_dialog_enter_func");

  if(isDefined(self.enter_func)) {
    ai_actor thread function_ebb58316927b2e(self.enter_func);
  }

  var_392205194b959b79 = 0;

  if(ai_actor.var_41fc4f898c255d37 <= 1) {
    flag_set("dialog_tree_active");
    flag_set("prompts_disabled");
    ai_actor.var_63de0686e572034c = self;
    self.activator val::set("dialog_tree", "ignoreme", 1);
    self.activator val::set("dialog_tree", "damage", 0);
    self.activator val::set("dialog_tree", "equipment_wheel", 0);

    if(isai(ai_actor)) {
      if(!isDefined(ai_actor.animname)) {
        ai_actor.animname = "generic";
      }

      ai_actor val::set("dialog_tree", "ignoreme", 1);
      ai_actor val::set("dialog_tree", "damage", 0);
    }

    if(!self.allow_weapon) {
      self.activator val::set("dialog_tree", "weapon", 0);
      self.activator val::set("dialog_tree", "offhand_weapons", 0);
    }

    ai_actor.var_31abe8aab080e9f7 = getdvarint(@ "cg_fov");
    ai_actor.var_ea70e39ddb4a6465 = anim_struct;
    function_d61b10a951adbc62(ai_actor, anim_struct);

    if(isai(ai_actor) && self.force_headlook) {
      ai_actor scripts\common\ai_lookat::enablelookatplayer(0.5, 1);
    }

    if(!isDefined(self.player_linkto) && !self.allow_movement) {
      self.player_linkto = spawn_tag_origin(self.activator.origin, self.activator.angles);

      if(istrue(level.var_bb012f571db2b0c9)) {
        v = level.player getplayerangles();
        f_upper = -1 * (v[0] - 10);
        f_lower = v[0] + 10;
        self.activator playerlinktodelta(self.player_linkto, "tag_origin", 0, 20, 20, f_upper, f_lower, 1);
      } else {
        self.activator playerlinktodelta(self.player_linkto, "tag_origin", 0, 20, 20, 10, 10, 1);
      }
    }

    play_greeting(ai_actor);
    self.selected_options = 0;
    var_392205194b959b79 = 1;
  } else if(isDefined(ai_actor.var_63de0686e572034c)) {
    parent_dt = ai_actor.var_63de0686e572034c;
    self.force_headlook = parent_dt.force_headlook;

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

    if(!isDefined(self.var_ea8cafa6b0eb06c7) && isDefined(parent_dt.var_ea8cafa6b0eb06c7)) {
      self.var_ea8cafa6b0eb06c7 = parent_dt.var_ea8cafa6b0eb06c7;
    }
  }

  ai_actor ent_flag_waitopen("_dialog_enter_func");
  ai_actor function_6fcfd605093266bb("_dialog_vo_playing");
  ai_actor function_6fcfd605093266bb("_dialog_anim_playing");
  ai_actor function_6fcfd605093266bb("_dialog_func_running");
  ai_actor function_6fcfd605093266bb("_dialog_ui_animating");
  ai_actor ent_flag_waitopen("_dialog_ui_animating");

  while(ai_actor.var_41fc4f898c255d37 > 1) {
    wait 0.1;
  }

  wait 0.5;
  end_dialog = 0;
  last_choice = -1;

  if(self.var_7c495f86e82a2621) {
    self.activator setclientomnvar("ui_hide_hud", 1);
  }

  if(var_392205194b959b79) {
    self.activator function_3a5cc3b6ee866c7e(self.position, self.state_index);
  }

  if(isDefined(timer)) {
    self.timeout = timer;
  }

  while(!end_dialog) {
    cur_choices = function_4b2a4d126ebeef2f(var_b763c53f8a399479);

    if(cur_choices.size < 1) {
      end_dialog = 1;
      continue;
    }

    ai_actor ent_flag_set("_dialog_ui_animating");
    chosen_id = function_b0a4d1a45e3cc77b(cur_choices, ai_actor, var_b763c53f8a399479);

    if(!isDefined(chosen_id) || chosen_id < 0) {
      break;
    }

    self.selected_options++;
    ai_actor notify("dialog_tree_choice_made");
    level notify("dialog_tree_choice_made");
    ai_actor ent_flag_waitopen("dialog_wait_for_animation");
    chosen_option = self.options[chosen_id];

    if(isai(ai_actor)) {
      ai_actor stopsounds();
    }

    if(isDefined(chosen_option.set_flag)) {
      foreach(flag_name in chosen_option.set_flag) {
        flag_set(flag_name);
      }
    }

    ai_actor ent_flag_clear("_dialog_vo_playing");
    ai_actor ent_flag_clear("_dialog_anim_playing");
    ai_actor ent_flag_clear("_dialog_func_running");
    waitflags = ["_dialog_func_running", "_dialog_vo_playing", "_dialog_anim_playing"];

    if(isDefined(chosen_option.selected_func)) {
      ai_actor ent_flag_set("_dialog_func_running");
      ai_actor childthread function_89a37d041d921c19(chosen_option.selected_func, chosen_option.func_parameter, chosen_option.skip_func);
    }

    if(isDefined(chosen_option.vo_npc)) {
      ai_actor ent_flag_set("_dialog_vo_playing");
      waitflags = ["_dialog_func_running", "_dialog_vo_playing"];

      if(chosen_option.cur_vo < 0) {
        thread function_b57073e1168e630c(ai_actor, chosen_option.vo_npc);
      } else {
        thread function_b57073e1168e630c(ai_actor, chosen_option.vo_npc[chosen_option.cur_vo]);
        chosen_option.cur_vo = function_4c99d8252f8b3ae6(chosen_option.cur_vo, chosen_option.vo_npc.size, chosen_option.cycle_style);
      }

      if(!isDefined(chosen_option.anim_npc)) {
        ai_actor thread function_8647b457c8205fe3();
      }
    }

    anim_struct notify("end_dialog_loop_anim");
    anim_npc = undefined;
    var_d03b62b68a62fa3f = undefined;
    struct = anim_struct;
    loop_struct = struct;
    bundle = self.scriptbundle;
    loop_bundle = bundle;

    if(isDefined(self.var_ea8cafa6b0eb06c7)) {
      var_d03b62b68a62fa3f = self.var_ea8cafa6b0eb06c7;
    }

    if(isDefined(self.anim_template)) {
      anim_npc = function_7dc5dc6ca7fc72c4(self.anim_template, "talk");
      var_d03b62b68a62fa3f = function_7dc5dc6ca7fc72c4(self.anim_template, "dt_idle");
      bundle = function_d66c0bfe054fd887(self.anim_template);
      loop_bundle = bundle;
      struct = self.template_struct;
      loop_struct = struct;
    }

    if(isDefined(chosen_option.anim_npc)) {
      anim_npc = chosen_option.anim_npc;

      if(isDefined(self.scriptbundle)) {
        bundle = self.scriptbundle;
        struct = anim_struct;
      }
    }

    if(isDefined(chosen_option.var_d03b62b68a62fa3f)) {
      var_d03b62b68a62fa3f = chosen_option.var_d03b62b68a62fa3f;

      if(isDefined(self.scriptbundle)) {
        loop_bundle = self.scriptbundle;
        loop_struct = anim_struct;
      }
    }

    if(isDefined(anim_npc) || isDefined(var_d03b62b68a62fa3f)) {
      ai_actor ent_flag_set("_dialog_anim_playing");

      if(chosen_option.cur_anim < 0) {
        thread function_c0ea7ed96cac83c2(ai_actor, anim_npc, struct, bundle, var_d03b62b68a62fa3f, loop_struct, loop_bundle);
      } else {
        thread function_c0ea7ed96cac83c2(ai_actor, chosen_option.anim_npc[chosen_option.cur_anim], struct, self.scriptbundle, var_d03b62b68a62fa3f, loop_struct, loop_bundle);
        chosen_option.cur_anim = function_4c99d8252f8b3ae6(chosen_option.cur_anim, chosen_option.anim_npc.size, chosen_option.cycle_style);
      }
    }

    if(istrue(chosen_option.end_dialog) || self.timeout > 0) {
      end_dialog = 1;
      last_choice = chosen_id;

      if(istrue(chosen_option.quick_exit)) {
        waitflags = ["_dialog_func_running"];
      }
    }

    ai_actor function_cba0984334ba3279(waitflags);

    if(!end_dialog || ai_actor.var_41fc4f898c255d37 > 1) {
      ai_actor ent_flag_waitopen("_dialog_ui_animating");
    }

    ai_actor notify("dialog_tree_response_complete");
    self.activator notify("dialog_tree_response_complete");
    self.options[chosen_id] function_f644d2dc71f882d3(1);
    function_3b353710664c8e46(chosen_id);
    waitframe();

    if(var_6a5d78d46f3a9e2) {
      self.var_ae6649775a3f3762 = chosen_id;
    }

    if(istrue(ai_actor.end_dialog)) {
      ai_actor.end_dialog = undefined;
      break;
    }
  }

  if(ai_actor.var_41fc4f898c255d37 <= 1) {
    self.activator function_cf43a9641fd024af("dialog_tree");

    if(self.var_7c495f86e82a2621) {
      self.activator setclientomnvar("ui_hide_hud", 0);
    }

    ai_actor.var_ea70e39ddb4a6465 = undefined;
    ai_actor.var_63de0686e572034c = undefined;

    if(isDefined(self.scriptbundle) && !function_87c6d037813b57c1(ai_actor.var_25bf3c46b0b8d3c8)) {
      anim_struct scene::stop();
    }

    if(isai(ai_actor) && self.force_headlook) {
      ai_actor scripts\common\ai_lookat::disablelookatplayer();
    }

    if(isDefined(ai_actor.var_25bf3c46b0b8d3c8)) {
      thread function_b0728c7b89fee84(ai_actor, anim_struct, ai_actor.var_25bf3c46b0b8d3c8);
    }
  }

  if(isDefined(self.exit_func)) {
    ai_actor childthread[[self.exit_func]]();
  }

  if(ai_actor.var_41fc4f898c255d37 <= 1) {
    if(!self.allow_movement) {
      if(isDefined(self.player_linkto)) {
        safe_origin = undefined;
        trace_from = self.player_linkto.origin;
        ret = self.activator player_trace(trace_from + (0, 0, 24), trace_from - (0, 0, 24), undefined, self.activator, undefined, undefined, 7);

        if(ret["hittype"] != "hittype_none") {
          safe_origin = ret["position"];
        } else if(isDefined(self.player_linkto.prev_origin)) {
          safe_origin = self.player_linkto.prev_origin;
        }

        if(isDefined(safe_origin) && distance(self.activator.origin, safe_origin) > 24) {
          safe_origin = undefined;
        }

        if(isDefined(safe_origin) && safe_origin != self.activator.origin) {
          var_93c0d18ec272ec49 = 0.5;
          self.player_linkto moveTo(safe_origin, var_93c0d18ec272ec49, var_93c0d18ec272ec49 * 0.25, var_93c0d18ec272ec49 * 0.5);
          wait var_93c0d18ec272ec49;
        }

        self.activator playerunlinkblend(0.5);
        wait 0.5;
        self.player_linkto delete();
        self.player_linkto = undefined;
      }
    }

    ai_actor ent_flag_clear("_dialog_vo_playing");
    ai_actor ent_flag_clear("_dialog_anim_playing");
    ai_actor ent_flag_clear("_dialog_func_running");

    if(isDefined(ai_actor.var_25bf3c46b0b8d3c8)) {
      ai_actor.var_25bf3c46b0b8d3c8 = undefined;
    }

    self.activator val::reset_all("dialog_tree");
    waitframe();

    if(isai(ai_actor)) {
      ai_actor val::reset_all("dialog_tree");
    }

    self notify("dialog_tree_end");
    ai_actor notify("dialog_tree_end");
    self.activator notify("dialog_tree_end");
    flag_clear("dialog_tree_active");
    flag_clear("prompts_disabled");
  }

  ai_actor.var_41fc4f898c255d37--;

  while(isDefined(ai_actor.var_41fc4f898c255d37) && ai_actor.var_41fc4f898c255d37 > 0) {
    wait 0.1;
  }

  return last_choice;
}

function function_b284f3de056ef45f() {
  if(self.var_7c495f86e82a2621) {
    self.activator setclientomnvar("ui_hide_hud", 0);
  }
}

function function_3041b446fbb7cebe(exclude_forever) {
  if(!isDefined(exclude_forever)) {
    exclude_forever = 0;
  }

  choices = function_4b2a4d126ebeef2f();
  exclude_count = 0;

  if(exclude_forever) {
    foreach(choice_id in choices) {
      flag_array = self.options[choice_id].var_9e70d6ccc832341;

      if(isDefined(flag_array)) {
        foreach(flag in flag_array) {
          flagstr = tolower(flag);

          if(issubstr(flagstr, "forever")) {
            exclude_count++;
            break;
          }
        }
      }
    }
  }

  return choices.size - exclude_count;
}

function function_72b6b41ebf8dd3ef() {
  self.ai_actor ent_flag_wait("waiting_on_player_choice");
  waitframe();
  level notify("dialog_tree_option_selected", -1);
}

function cleanup_tree(tree) {
  tree notify("delete");
  return undefined;
}

function private function_ebb58316927b2e(func) {
  ent_flag_set("_dialog_enter_func");
  self[[func]]();
  ent_flag_clear("_dialog_enter_func");
}

function private function_952cfa1c522b5457(ai_actor, anim_struct) {
  self.activator endon("death");
  self endon("dialog_tree_end");
  level notify("watch_dt_skips");
  level endon("watch_dt_skips");

  while(true) {
    level waittill("dialog_tree_request_skip");

    if(ai_actor ent_flag("_dialog_vo_playing")) {
      if(isDefined(ai_actor.var_b5399d011f68e3ed)) {
        if(isai(ai_actor)) {
          ai_actor stop_dialogue();
        } else {
          ai_actor stopsounds();
        }

        ai_actor.var_b5399d011f68e3ed = undefined;
        ai_actor notify("cancel speaking");
      }
    }

    ai_actor notify("dialog_tree_cancel_response");
    self notify("dialog_tree_anim_continue");
    wait 0.3;
  }
}

function function_5a980cdc85424aa8(sb, str_shot, anim_struct) {}

function function_b57073e1168e630c(ai_actor, vo_lines) {
  ai_actor endon("death");
  ai_actor endon("dialog_tree_end");
  waitframe();

  if(!isarray(vo_lines)) {
    vo_lines = [vo_lines];
  }

  for(i = 0; i < vo_lines.size; i++) {
    vo_line = vo_lines[i];

    if(soundexists(vo_line)) {
      ai_actor.var_b5399d011f68e3ed = 1;

      if(isai(ai_actor)) {
        ai_actor stop_dialogue();
        waitframe();
        ai_actor smart_dialogue(vo_line);
      } else if(!isDefined(ai_actor) || ai_actor == level) {
        self.activator smart_radio_dialogue(vo_line);
      } else {
        ai_actor playsoundonentity(vo_line, vo_line + "_complete");
      }

      continue;
    }

    if(isDefined(vo_line) && vo_line != "") {
      if(ai_actor != level && ai_actor != level.player) {
        ai_actor thread dialogue_print(vo_line);
      } else {
        iprintlnbold(vo_line);
      }

      self.activator waittill_any_timeout_1(1.5, "<dev string:x67>");
    }
  }

  ai_actor notify("dialog_tree_vo_response_complete");
  self notify("dialog_tree_vo_response_complete");
  ai_actor.var_b5399d011f68e3ed = undefined;
  ai_actor ent_flag_clear("_dialog_vo_playing");
}

function private function_896a08d617c4a4e4(new_option) {
  assert(isarray(self.options));
  option_id = self.options.size;
  self.options[option_id] = new_option;
  return option_id;
}

function private function_90cdd85860a9e8df(parent_id, option_text, ai_vo, ai_anim, var_228a30311662ac48, end_dialog, set_flag, var_661a368853d6a900, var_176104ebd5b06dab, selected_func, func_parameter, skip_func, important, expire_count, expire_flag, expire_reset) {
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
  option.var_d03b62b68a62fa3f = var_228a30311662ac48;
  option.end_dialog = end_dialog;
  option.pin_bottom = 0;
  option.locked = 0;

  if(isDefined(set_flag) && !isarray(set_flag)) {
    set_flag = [set_flag];
  }

  option.set_flag = set_flag;

  if(isDefined(var_176104ebd5b06dab)) {
    option.locked = 1;

    if(isarray(var_176104ebd5b06dab)) {
      option.var_79a2e334ef20037c = var_176104ebd5b06dab;
    } else {
      option.var_79a2e334ef20037c = [var_176104ebd5b06dab];
    }
  }

  if(isDefined(var_661a368853d6a900)) {
    if(isarray(var_661a368853d6a900)) {
      option.var_9e70d6ccc832341 = var_661a368853d6a900;
    } else {
      option.var_9e70d6ccc832341 = [var_661a368853d6a900];
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

function private function_9ca2b445d85472ca() {
  if(self.locked) {
    if(isDefined(self.var_79a2e334ef20037c) && flag_all(self.var_79a2e334ef20037c)) {
      return 0;
    }

    if(isDefined(self.var_e4ef57c233595c4c) && flag_any(self.var_e4ef57c233595c4c)) {
      return 0;
    }

    return 1;
  }

  return 0;
}

function private function_f644d2dc71f882d3(var_cef5f1fe5c58455b) {
  if(var_cef5f1fe5c58455b && !isDefined(self.var_43d0b8282bd404df) && !isDefined(self.var_9e70d6ccc832341)) {
    self.active = 0;
    return;
  }

  if(isDefined(self.var_9e70d6ccc832341)) {
    if(self.var_9e70d6ccc832341[0] == "forever") {
      return;
    }

    if(flag_all(self.var_9e70d6ccc832341)) {
      self.active = 0;
    }
  }

  if(isDefined(self.var_43d0b8282bd404df) && flag_any(self.var_43d0b8282bd404df)) {
    self.active = 0;
  }
}

function private flag_all(flags) {
  foreach(f in flags) {
    if(!flag(f)) {
      return false;
    }
  }

  return true;
}

function private flag_any(flags) {
  foreach(f in flags) {
    if(flag(f)) {
      return true;
    }
  }

  return false;
}

function private function_4db1d159e194fef2(cur_choices, var_b763c53f8a399479) {
  if(!isDefined(var_b763c53f8a399479)) {
    var_b763c53f8a399479 = 4;
  }

  hudstrings = [];

  for(i = 0; i < var_b763c53f8a399479; i++) {
    if(isDefined(cur_choices[i])) {
      option = self.options[cur_choices[i]];
      hudstrings[i] = spawnStruct();
      hudstrings[i].important = option.important;
      hudstrings[i].string = option.hudstring;
      hudstrings[i].locked = option function_9ca2b445d85472ca() && option.show_locked;
      continue;
    }

    hudstrings[i] = spawnStruct();
    hudstrings[i].important = 0;
    hudstrings[i].string = undefined;
    hudstrings[i].locked = 0;
  }

  return hudstrings;
}

function private function_efa6071d5c0c7cf6(option_id) {
  if(!isDefined(option_id)) {
    option_id = self.options.size - 1;
  }

  return option_id;
}

function private function_89a37d041d921c19(func, param, skip_func) {
  self endon("dialog_tree_end");

  if(isDefined(skip_func)) {
    childthread function_248fd2c8f84089de(skip_func);
  }

  if(!isDefined(param)) {
    self[[func]]();
  } else {
    self[[func]](param);
  }

  self notify("dtree_cancel_skip_func");
  ent_flag_clear("_dialog_func_running");
}

function private function_248fd2c8f84089de(skip_func) {
  self endon("dialog_tree_end");
  self endon("dtree_cancel_skip_func");
  self waittill("dialog_tree_cancel_response");
  self childthread[[skip_func]]();
}

function function_c0ea7ed96cac83c2(ai_actor, anims, struct, scriptbundle, var_d03b62b68a62fa3f, loop_struct, loop_bundle) {
  self endon("dialog_tree_end");
  ai_actor endon("dialog_tree_choice_made");
  ai_actor endon("dialog_tree_exit_anim");

  if(isDefined(anims)) {
    if(!isarray(anims)) {
      anims = [anims];
    }

    thread function_97c8fd6d796429cd(ai_actor);

    for(i = 0; i < anims.size; i++) {
      shot_name = anims[i];
      names = strtok(anims[i], ":");

      if(names.size > 1) {
        scriptbundle = names[0];
        shot_name = names[1];
      }

      if(isDefined(scriptbundle) && isDefined(shot_name)) {
        childthread internal_anim(ai_actor, shot_name, struct, scriptbundle);
        waittill_any("dialog_tree_anim_done", "dialog_tree_anim_continue", "dialog_tree_vo_response_complete");
      }
    }
  }

  ai_actor notify("dialog_tree_scene_response_complete");
  self.var_f2ad955ae5c3dee8 = undefined;
  ai_actor ent_flag_clear("_dialog_anim_playing");

  if(isDefined(var_d03b62b68a62fa3f)) {
    names = strtok(var_d03b62b68a62fa3f, ":");

    if(names.size > 1) {
      loop_bundle = names[0];
      var_d03b62b68a62fa3f = names[1];
    }

    if(isDefined(loop_bundle) && isDefined(var_d03b62b68a62fa3f)) {
      loop_struct thread scene::play(function_27e66e2cf814c5e4(ai_actor), var_d03b62b68a62fa3f, loop_bundle);
    }
  }
}

function private function_27e66e2cf814c5e4(ai_actor) {
  actor_list = [ai_actor];

  if(isDefined(self.include_actors)) {
    actor_list = array_combine(actor_list, self.include_actors);
  }

  return actor_list;
}

function private internal_anim(ai_actor, shot_name, struct, scriptbundle) {
  self endon("dialog_tree_end");
  self.var_f2ad955ae5c3dee8 = shot_name;
  struct scene::play(function_27e66e2cf814c5e4(ai_actor), shot_name, scriptbundle);
  self notify("dialog_tree_anim_done");
}

function private function_97c8fd6d796429cd(ai_actor) {
  self.activator endon("death");
  ai_actor endon("dialog_tree_scene_response_complete");
  level waittill("dialog_tree_show_choices");
  ai_actor ent_flag_clear("_dialog_anim_playing");
  ai_actor notify("dialog_tree_scene_response_complete");
}

function private function_6fcfd605093266bb(flagname) {
  if(!ent_flag_exist(flagname)) {
    ent_flag_init(flagname);
    ent_flag_clear(flagname);
    return;
  }

  ent_flag_waitopen(flagname);
}

function private function_4b2a4d126ebeef2f(max_options) {
  cur_choices = [];
  choice_id = 0;
  pin_choice = undefined;

  if(!isDefined(max_options)) {
    max_options = self.options.size;
  }

  while(choice_id < self.options.size && (cur_choices.size < max_options || self.var_b11619776bfbfa3a)) {
    option = self.options[choice_id];

    if(isDefined(option.expire_count) && option.expire_count > 0) {
      if(self.selected_options == 0 && istrue(option.expire_reset)) {
        self.options[choice_id].active = 1;

        if(isDefined(option.expire_flag)) {
          flag_clear(option.expire_flag);
        }
      }

      if(self.selected_options >= option.expire_count && option.active) {
        self.options[choice_id].active = 0;

        if(isDefined(option.expire_flag)) {
          flag_set(option.expire_flag);
        }
      }
    }

    option function_f644d2dc71f882d3(0);

    if(!option.active || option function_9ca2b445d85472ca() && !option.show_locked) {
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

function private function_3b353710664c8e46(parent_id) {
  foreach(option in self.options) {
    if(isDefined(option.parent_id) && option.parent_id == parent_id) {
      option.active = 1;
    }
  }
}

function function_b78240c8809979a3(index) {
  keyinput = index + 1;
  choice_string = "^S " + keyinput + " ^E";
  return choice_string;
}

function function_b0a4d1a45e3cc77b(cur_choices, ai_actor, var_b763c53f8a399479) {
  if(!isDefined(var_b763c53f8a399479)) {
    var_b763c53f8a399479 = 4;
  }

  dialog_strings = function_4db1d159e194fef2(cur_choices, var_b763c53f8a399479);
  index = 0;
  choices = [];

  foreach(choice in dialog_strings) {
    if(isDefined(choice.string)) {
      self.activator function_872bbb1fa784b8d8("dialog_tree", "option_" + index, function_6cd0a8e23ff14e13("scripted_widget_dialog_option"));
      fields = [];
      fields["locstring_index"] = getlocstringindex(choice.string);
      fields["important"] = choice.important;
      fields["locked"] = choice function_9ca2b445d85472ca();
      self.activator function_3eec25a52a78f31f("dialog_tree", "option_" + index, fields, 1);
      choices[index] = choice;
      index++;
    }
  }

  if(isDefined(self.timeout) && self.timeout > 0) {
    waittillframeend();
    self.activator thread function_c9f135e486f0e555();
    self.activator namespace_417b627dcd8f5453::init_countdown(self.timeout, undefined, "dialog_tree_option_selected");
    self.activator function_f4c37324750dc183("coundown_display", self.position[0], self.position[1] - 20, 0, 0, 1);
  }

  player = self.activator;
  assert(isPlayer(player));
  ai_actor ent_flag_set("waiting_on_player_choice");
  level waittill("dialog_tree_option_selected", selected_index);
  ai_actor ent_flag_clear("waiting_on_player_choice");
  player setclientomnvar("dialog_tree_set_skippable", self.skippable);

  if(selected_index < 0) {
    player thread function_530ad7e8e4ec7d2a(choices, ai_actor, 1);
    return selected_index;
  }

  player thread function_530ad7e8e4ec7d2a(choices, ai_actor);
  return cur_choices[selected_index];
}

function private function_c9f135e486f0e555() {
  self endon("death");
  self endon("dialog_tree_option_selected");
  self waittill("countdown_end");
  self setclientomnvar("dialog_tree_send_current_selection", 1);
}

function private function_26cc8ab8ee78d07f(value) {
  self notify("dialog_tree_option_selected", value);
  level notify("dialog_tree_option_selected", value);
  self setclientomnvar("dialog_tree_send_current_selection", 0);
}

function private function_e70848b1ace60b2d(value) {
  level notify("dialog_tree_request_skip");
}

function function_dc022e76b8f26129(choices) {
  self endon("death");
  self endon("dialog_tree_option_selected");
  self endon("disconnect");

  if(isDefined(choices) && isDefined(choices.size)) {
    level.waitingforresponse = 1;
    selectedoption = -1;

    while(level.waitingforresponse) {
      kbmkeypressed = waittill_any_return_1("dialog_tree_kbm_key_selected");

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
        level notify("dialog_tree_option_selected", selectedoption);
      }

      waitframe();
    }
  }
}

function function_baf288decd65aa7a(old_indices, new_indices, choices) {
  var_b488e3faa183f632 = old_indices[0];
  var_b48d954708f24665 = new_indices[0];
  var_c97689354f6b1bd2 = var_b48d954708f24665;

  while(choices[var_c97689354f6b1bd2] function_9ca2b445d85472ca()) {
    if(var_b48d954708f24665 < var_b488e3faa183f632) {
      var_c97689354f6b1bd2--;
    } else {
      var_c97689354f6b1bd2++;
    }

    if(var_c97689354f6b1bd2 < 0 || var_c97689354f6b1bd2 >= choices.size) {
      var_c97689354f6b1bd2 = var_b488e3faa183f632;
      break;
    }
  }

  if(var_c97689354f6b1bd2 != var_b488e3faa183f632) {}

  return [var_c97689354f6b1bd2, 0];
}

function function_530ad7e8e4ec7d2a(choices, ai_actor, quick_clear) {
  if(!isDefined(quick_clear)) {
    quick_clear = 0;
  }

  if(!quick_clear) {
    ai_actor waittill_notify_or_timeout("dialog_tree_response_complete", 1.5);
  }

  function_5df3186604c72b24("dialog_tree");
  ai_actor ent_flag_clear("_dialog_ui_animating");
}

function function_3a5cc3b6ee866c7e(position, state_index) {
  function_440f285bc17a2787("dialog_tree", function_6cd0a8e23ff14e13("scripted_widget_dialog_tree"));
  function_f4c37324750dc183("dialog_tree", position[0], position[1], 0, 0, 1);
}

function private function_87c6d037813b57c1(player_pos) {
  if(isDefined(player_pos) && isDefined(player_pos.var_d35bbd317ecfb67b)) {
    return 1;
  }

  return 0;
}

function private function_a10c80dbb1f95f26(anim_struct, ai_actor) {
  if(!isDefined(anim_struct)) {
    if(isDefined(ai_actor.var_ea70e39ddb4a6465)) {
      anim_struct = ai_actor.var_ea70e39ddb4a6465;
    } else {
      anim_struct = ai_actor;
    }
  }

  return anim_struct;
}

function private function_3274dd5fa9090931(template_name, ai_actor) {
  template_name = self.anim_template;
  struct = self.template_struct;
  player_positions = self.var_2c6249da4d27ca4e;

  if(isDefined(player_positions)) {
    if(!isarray(player_positions)) {
      player_positions = [player_positions];
    }

    foreach(pos in player_positions) {
      bundle = function_d66c0bfe054fd887(template_name);
      pos = tolower(pos);
      pos_info = function_1d41e14159f8de35(template_name, pos);
      idle = function_7dc5dc6ca7fc72c4(template_name, "idle");
      dt_idle = function_7dc5dc6ca7fc72c4(template_name, "dt_idle");
      assertex(isDefined(pos_info), "set_dt_animation_template called with invalid player position name: " + pos);
      function_20c528b5c4f4eac1(undefined, pos_info.enter_shot, dt_idle, pos_info.exit_shot, idle, undefined, undefined, undefined, undefined, undefined, bundle, struct);
    }

    self.var_2c6249da4d27ca4e = undefined;
  }
}

function function_607273064331d2b8(ai_actor) {
  if(isDefined(self.template_struct) && !isDefined(self.template_struct.origin)) {
    self.template_struct.origin = ai_actor.origin;
    self.template_struct.angles = ai_actor.angles;
  }
}

#using_animtree("generic_human");

function private function_8647b457c8205fe3() {
  if(isai(self)) {
    self setanim(%t10_generic_dt_talking_headbob_1_m, 1);
    ent_flag_waitopen("_dialog_vo_playing");
    self setanim(%t10_generic_dt_talking_headbob_1_m, 0, 1);
  }
}