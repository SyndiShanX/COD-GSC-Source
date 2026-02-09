/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_beastcode.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_altbody_beast;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using_animtree("generic");

class cbeastcode {
  var m_n_device_state;
  var m_n_input_index;
  var m_a_current;
  var stub;
  var var_71f130fa;
  var m_a_codes;
  var m_a_funcs;
  var m_a_mdl_clues;
  var m_a_mdl_inputs;
  var var_36948aba;
  var m_a_t_inputs;
  var m_a_s_input_button_tags;
  var var_1d4fdfa6;
  var m_b_discovered;

  constructor() {}

  destructor() {}

  function interpret_trigger_event(player, n_index) {
    m_n_device_state = 0;
    hide_given_input(n_index);
    m_a_current[m_n_input_index] = n_index;
    m_n_input_index++;
    if(m_n_input_index == 3) {
      activate_input_device();
    }
    m_n_device_state = 1;
  }

  function get_keycode_device_state() {
    return m_n_device_state;
  }

  function keycode_input_trigger_think(o_beastcode, n_index) {
    while(true) {
      self waittill("trigger", player);
      if(o_beastcode.var_71f130fa <= 0) {
        continue;
      }
      if(player zm_utility::in_revive_trigger()) {
        continue;
      }
      if(!(isDefined([[o_beastcode]] - > get_keycode_device_state()) && [[o_beastcode]] - > get_keycode_device_state())) {
        continue;
      }
      [[o_beastcode]] - > interpret_trigger_event(player, n_index);
    }
  }

  function keycode_input_prompt(player) {
    self endon("kill_trigger");
    player endon("death_or_disconnect");
    str_hint = &"";
    str_old_hint = &"";
    a_s_input_button_tags = [[stub.o_keycode]] - > get_tags_from_input_device();
    while(true) {
      n_state = [[stub.o_keycode]] - > get_keycode_device_state();
      switch (n_state) {
        case 2: {
          str_hint = &"ZM_ZOD_KEYCODE_TRYING";
          break;
        }
        case 3: {
          str_hint = &"ZM_ZOD_KEYCODE_SUCCESS";
          break;
        }
        case 4: {
          str_hint = &"ZM_ZOD_KEYCODE_FAIL";
          break;
        }
        case 0: {
          str_hint = &"ZM_ZOD_KEYCODE_UNAVAILABLE";
          break;
        }
        case 1: {
          player.n_keycode_lookat_tag = undefined;
          n_closest_dot = 0.996;
          v_eye_origin = player getplayercamerapos();
          v_eye_direction = anglesToForward(player getplayerangles());
          foreach(s_tag in a_s_input_button_tags) {
            v_tag_origin = s_tag.v_origin;
            v_eye_to_tag = vectornormalize(v_tag_origin - v_eye_origin);
            n_dot = vectordot(v_eye_to_tag, v_eye_direction);
            if(n_dot > n_closest_dot) {
              n_closest_dot = n_dot;
              player.n_keycode_lookat_tag = s_tag.n_index;
            }
          }
          if(!isDefined(player.n_keycode_lookat_tag)) {
            str_hint = &"";
          } else {
            if(player.n_keycode_lookat_tag < 3) {
              str_hint = &"ZM_ZOD_KEYCODE_INCREMENT_NUMBER";
            } else {
              str_hint = &"ZM_ZOD_KEYCODE_ACTIVATE";
            }
          }
          break;
        }
      }
      if(str_old_hint != str_hint) {
        str_old_hint = str_hint;
        stub.hint_string = str_hint;
        if(str_hint === (&"ZM_ZOD_KEYCODE_INCREMENT_NUMBER")) {
          self sethintstring(stub.hint_string, player.n_keycode_lookat_tag + 1);
        } else {
          self sethintstring(stub.hint_string);
        }
      }
      wait(0.1);
    }
  }

  function keycode_input_visibility(player) {
    b_is_invis = !(isDefined(player.beastmode) && player.beastmode);
    self setinvisibletoplayer(player, b_is_invis);
    self thread keycode_input_prompt(player);
    return !b_is_invis;
  }

  function function_71154a2(t_lookat, n_code_index, var_d7d7b586) {
    var_c929283d = struct::get(t_lookat.target, "targetname");
    var_43544e59 = var_c929283d.origin;
    while(true) {
      t_lookat waittill("trigger", player);
      while(player istouching(t_lookat)) {
        v_eye_origin = player getplayercamerapos();
        v_eye_direction = anglesToForward(player getplayerangles());
        var_744d3805 = vectornormalize(var_43544e59 - v_eye_origin);
        n_dot = vectordot(var_744d3805, v_eye_direction);
        if(n_dot > 0.9) {
          n_number = get_number_in_code(n_code_index, var_d7d7b586);
          player.var_ab153665 = player hud::createprimaryprogressbartext();
          player.var_ab153665 settext("You sense the number " + n_number);
          player.var_ab153665 hud::showelem();
        }
        wait(0.05);
        if(isDefined(player.var_ab153665)) {
          player.var_ab153665 hud::destroyelem();
          player.var_ab153665 = undefined;
        }
      }
    }
  }

  function create_code_input_unitrigger() {
    width = 128;
    height = 128;
    length = 128;
    m_mdl_input.unitrigger_stub = spawnStruct();
    m_mdl_input.unitrigger_stub.origin = m_mdl_input.origin;
    m_mdl_input.unitrigger_stub.angles = m_mdl_input.angles;
    m_mdl_input.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    m_mdl_input.unitrigger_stub.cursor_hint = "HINT_NOICON";
    m_mdl_input.unitrigger_stub.script_width = width;
    m_mdl_input.unitrigger_stub.script_height = height;
    m_mdl_input.unitrigger_stub.script_length = length;
    m_mdl_input.unitrigger_stub.require_look_at = 0;
    m_mdl_input.unitrigger_stub.o_keycode = self;
    m_mdl_input.unitrigger_stub.prompt_and_visibility_func = &keycode_input_visibility;
    zm_unitrigger::register_static_unitrigger(m_mdl_input.unitrigger_stub, &keycode_input_trigger_think);
  }

  function test_current_code_against_this_code(a_code) {
    for(i = 0; i < a_code.size; i++) {
      if(!isinarray(m_a_current, a_code[i])) {
        return false;
      }
    }
    return true;
  }

  function activate_input_device() {
    var_71f130fa = var_71f130fa - 1;
    for(i = 0; i < m_a_codes.size; i++) {
      if(test_current_code_against_this_code(m_a_codes[i])) {
        playsoundatposition("zmb_zod_sword_symbol_right", (2624, -5104, -312));
        m_n_device_state = 3;
        hide_readout(1);
        [[m_a_funcs[i]]]();
        return;
      }
    }
    m_n_device_state = 4;
    m_n_input_index = 0;
    playsoundatposition("zmb_zod_sword_symbol_wrong", (2624, -5104, -312));
    if(var_71f130fa > 0) {
      hide_readout(1);
      wait(3);
      hide_readout(0);
      m_n_device_state = 1;
    } else {
      hide_readout(1);
    }
  }

  function update_clue_numbers_for_code(n_index = 0) {
    a_code = m_a_codes[n_index];
    for(i = 0; i < 3; i++) {
      mdl_clue_number = m_a_mdl_clues[n_index][i];
      for(j = 0; j < 10; j++) {
        mdl_clue_number hidepart("J_" + j);
        mdl_clue_number hidepart("p7_zm_zod_keepers_code_0" + j);
      }
      mdl_clue_number showpart("p7_zm_zod_keepers_code_0" + a_code[i]);
    }
  }

  function set_input_number_visibility(n_index, b_is_visible) {
    if(b_is_visible) {
      m_a_mdl_inputs[n_index] show();
    } else {
      m_a_mdl_inputs[n_index] hide();
    }
  }

  function set_input_number(n_index, n_value) {
    mdl_input = m_a_mdl_inputs[n_index];
    for(i = 0; i < 10; i++) {
      mdl_input hidepart("J_" + i);
      mdl_input hidepart("j_keeper_" + i);
    }
    mdl_input showpart("j_keeper_" + n_value);
  }

  function function_36c50de5() {
    while(true) {
      level waittill("start_of_round");
      if(0 >= var_71f130fa) {
        hide_readout(0);
        m_n_device_state = 1;
      }
      var_71f130fa = var_36948aba;
    }
  }

  function setup_input_threads() {
    for(i = 0; i < m_a_mdl_inputs.size; i++) {
      m_a_mdl_inputs[i] thread zm_altbody_beast::watch_lightning_damage(m_a_t_inputs[i]);
      m_a_t_inputs[i] thread keycode_input_trigger_think(self, i);
      set_input_number(i, i);
    }
  }

  function hide_given_input(n_index) {
    m_a_mdl_inputs[n_index] ghost();
  }

  function hide_readout(b_hide = 1) {
    foreach(mdl_input in m_a_mdl_inputs) {
      if(b_hide) {
        mdl_input ghost();
        continue;
      }
      mdl_input show();
      zm_altbody_beast::function_41cc3fc8();
    }
  }

  function set_clue_numbers_for_code(a_mdl_clues, n_index = 0) {
    if(!isDefined(m_a_mdl_clues)) {
      m_a_mdl_clues = array(undefined);
    }
    m_a_mdl_clues[n_index] = a_mdl_clues;
    self thread update_clue_numbers_for_code(n_index);
  }

  function add_code_function_pair(a_code, func_custom) {}

  function generate_random_code() {
    a_n_numbers = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
    a_code = [];
    for(i = 0; i < 3; i++) {
      a_n_numbers = array::randomize(a_n_numbers);
      n_number = array::pop_front(a_n_numbers);
      if(!isDefined(a_code)) {
        a_code = [];
      } else if(!isarray(a_code)) {
        a_code = array(a_code);
      }
      a_code[a_code.size] = n_number;
    }
    return a_code;
  }

  function get_tags_from_input_device() {
    return m_a_s_input_button_tags;
  }

  function get_number_in_code(n_code_index, n_place_index) {
    return m_a_codes[n_code_index][n_place_index];
  }

  function get_code(n_code_index = 0) {
    a_code = m_a_codes[n_code_index];
    return a_code;
  }

  function init(a_mdl_inputs, a_t_inputs, var_4582f16d, func_activate) {
    m_a_mdl_inputs = a_mdl_inputs;
    m_a_t_inputs = a_t_inputs;
    var_1d4fdfa6 = var_4582f16d;
    m_a_current = array(0, 0, 0);
    m_n_input_index = 0;
    m_a_codes = array(generate_random_code());
    m_a_funcs = array(func_activate);
    var_36948aba = 1;
    var_71f130fa = var_36948aba;
    self thread setup_input_threads();
    self thread function_36c50de5();
    m_b_discovered = 0;
    m_n_device_state = 1;
  }
}

#namespace zm_zod_beastcode;

function autoexec __init__sytem__() {
  system::register("zm_zod_beastcode", &__init__, undefined, undefined);
}

function __init__() {}

function init() {
  a_mdl_inputs = [];
  a_mdl_clues = [];
  a_t_inputs = [];
  for(i = 0; i < 3; i++) {
    mdl_clue_number = getent("keeper_sword_locker_clue_" + i, "targetname");
    a_mdl_clues[a_mdl_clues.size] = mdl_clue_number;
  }
  for(i = 0; i < 10; i++) {
    mdl_beast_number = getent("keeper_sword_locker_number_" + i, "targetname");
    a_mdl_inputs[a_mdl_inputs.size] = mdl_beast_number;
    t_input = getent("keeper_sword_locker_trigger_" + i, "targetname");
    a_t_inputs[a_t_inputs.size] = t_input;
  }
  var_4582f16d = getEntArray("keeper_sword_locker_clue_lookat", "targetname");
  level.o_canal_beastcode = new cbeastcode();
  [[level.o_canal_beastcode]] - > init(a_mdl_inputs, a_t_inputs, var_4582f16d, &keeper_sword_locker_open_locker);
  a_code = [[level.o_canal_beastcode]] - > get_code();
  [[level.o_canal_beastcode]] - > set_clue_numbers_for_code(a_mdl_clues);
}

function keeper_sword_locker_open_locker() {
  level flag::set("keeper_sword_locker");
}