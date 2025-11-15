/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_smashables.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_zod_portals;
#using scripts\zm\zm_zod_quest;

class csmashable {
  var var_afea543d;
  var var_6e27ff4;
  var m_e_trigger;
  var m_a_callbacks;
  var m_a_e_models;
  var m_a_clip;
  var m_func_trig;
  var m_arg;
  var m_b_shader_on;
  var m_a_b_parameters;
  var m_a_nodes;

  constructor() {
    m_a_callbacks = [];
    m_a_b_parameters = [];
    m_a_e_models = [];
  }

  destructor() {}

  function function_3408f1a2() {
    if(var_afea543d && var_6e27ff4) {
      return true;
    }
    return false;
  }

  function function_89be164a(e_trigger) {
    if(isDefined(e_trigger.script_int) && isDefined(e_trigger.script_percent)) {
      var_afea543d = e_trigger.script_int;
      var_6e27ff4 = e_trigger.script_percent;
    } else {
      var_afea543d = 0;
      var_6e27ff4 = 0;
    }
  }

  function watch_all_damage(e_clip) {
    e_clip setCanDamage(1);
    while(true) {
      e_clip waittill("damage", n_amt, e_attacker, v_dir, v_pos, str_type);
      if(isDefined(e_attacker) && isplayer(e_attacker) && (isDefined(e_attacker.beastmode) && e_attacker.beastmode) && str_type === "MOD_MELEE") {
        m_e_trigger notify("trigger", e_attacker);
        break;
      }
    }
  }

  function add_callback(fn_callback, param1, param2, param3) {
    assert(isDefined(fn_callback) && isfunctionptr(fn_callback));
    s = spawnStruct();
    s.fn = fn_callback;
    s.params = [];
    if(isDefined(param1)) {
      if(!isDefined(s.params)) {
        s.params = [];
      } else if(!isarray(s.params)) {
        s.params = array(s.params);
      }
      s.params[s.params.size] = param1;
    }
    if(isDefined(param2)) {
      if(!isDefined(s.params)) {
        s.params = [];
      } else if(!isarray(s.params)) {
        s.params = array(s.params);
      }
      s.params[s.params.size] = param2;
    }
    if(isDefined(param3)) {
      if(!isDefined(s.params)) {
        s.params = [];
      } else if(!isarray(s.params)) {
        s.params = array(s.params);
      }
      s.params[s.params.size] = param3;
    }
    if(!isDefined(m_a_callbacks)) {
      m_a_callbacks = [];
    } else if(!isarray(m_a_callbacks)) {
      m_a_callbacks = array(m_a_callbacks);
    }
    m_a_callbacks[m_a_callbacks.size] = s;
  }

  function private execute_callbacks() {
    foreach(s_cb in m_a_callbacks) {
      switch (s_cb.params.size) {
        case 0: {
          self thread[[s_cb.fn]]();
          break;
        }
        case 1: {
          self thread[[s_cb.fn]](s_cb.params[0]);
          break;
        }
        case 2: {
          self thread[[s_cb.fn]](s_cb.params[0], s_cb.params[1]);
          break;
        }
        case 3: {
          self thread[[s_cb.fn]](s_cb.params[0], s_cb.params[1], s_cb.params[2]);
          break;
        }
      }
    }
  }

  function private main() {
    m_e_trigger waittill("trigger", who);
    if(isDefined(who)) {
      who notify("smashable_smashed");
    }
    foreach(model in m_a_e_models) {
      if(model.targetname == "fxanim_beast_door") {
        model playSound("zmb_bm_interaction_door");
      }
      if(model.targetname == "fxanim_crate_breakable_01") {
        model playSound("zmb_bm_interaction_crate_large");
      }
      if(model.targetname == "fxanim_crate_breakable_02") {
        model playSound("zmb_bm_interaction_crate_small");
      }
      if(model.targetname == "fxanim_crate_breakable_03") {
        model playSound("zmb_bm_interaction_crate_small");
      }
    }
    execute_callbacks();
    foreach(e_clip in m_a_clip) {
      e_clip delete();
    }
    toggle_shader(0);
    function_6ea46467(0);
    if(isDefined(m_e_trigger.script_flag_set)) {
      level flag::set(m_e_trigger.script_flag_set);
    }
    if(isDefined(m_func_trig)) {
      [
        [m_func_trig]
      ](m_arg);
    }
  }

  function private function_387c449e() {
    self waittill("hash_13f02a5d");
    self clientfield::set("set_fade_material", 0);
  }

  function private function_d8055c34() {
    self thread function_387c449e();
    wait(10);
    if(isDefined(self)) {
      self notify("hash_13f02a5d");
    }
  }

  function private function_6ea46467(b_shader_on) {
    foreach(e_model in m_a_e_models) {
      if(b_shader_on) {
        e_model clientfield::set("set_fade_material", 1);
        continue;
      }
      e_model thread function_d8055c34();
    }
  }

  function private toggle_shader(b_shader_on) {
    foreach(e_model in m_a_e_models) {
      e_model clientfield::set("bminteract", b_shader_on);
    }
    m_b_shader_on = b_shader_on;
  }

  function function_82bc26b5() {
    wait(1);
    level clientfield::set("breakable_show", var_afea543d);
    level clientfield::set("breakable_hide", var_6e27ff4);
  }

  function private setup_fxanims() {
    s_bundle_inst = struct::get(m_e_trigger.target, "targetname");
    if(isDefined(s_bundle_inst) && isDefined(s_bundle_inst.scriptbundlename)) {
      if(!isDefined(level.zod_smashable_scriptbundles)) {
        level.zod_smashable_scriptbundles = [];
      }
      if(!isDefined(level.zod_smashable_scriptbundles[s_bundle_inst.scriptbundlename])) {
        level.zod_smashable_scriptbundles[s_bundle_inst.scriptbundlename] = s_bundle_inst.scriptbundlename;
      }
      if(function_3408f1a2()) {
        self thread function_82bc26b5();
      } else {
        level scene::init(m_e_trigger.target, "targetname");
      }
      var_5b3a6271 = function_3408f1a2();
      add_callback( & zm_zod_smashables::cb_fxanim, var_5b3a6271, var_afea543d, var_6e27ff4);
    }
  }

  function add_model(e_model) {
    if(!isDefined(m_a_e_models)) {
      m_a_e_models = [];
    } else if(!isarray(m_a_e_models)) {
      m_a_e_models = array(m_a_e_models);
    }
    m_a_e_models[m_a_e_models.size] = e_model;
    if(has_parameter("any_damage")) {
      thread watch_all_damage(e_model);
    }
    toggle_shader(m_b_shader_on);
    function_6ea46467(1);
  }

  function has_parameter(str_parameter) {
    return isDefined(m_a_b_parameters[str_parameter]) && m_a_b_parameters[str_parameter];
  }

  function private parse_parameters() {
    if(!isDefined(m_e_trigger.script_parameters)) {
      return;
    }
    a_params = strtok(m_e_trigger.script_parameters, ",");
    foreach(str_param in a_params) {
      m_a_b_parameters[str_param] = 1;
      if(str_param == "connect_paths") {
        add_callback( & zm_zod_smashables::cb_connect_paths);
        continue;
      }
      if(str_param == "any_damage") {
        foreach(e_clip in m_a_clip) {
          thread watch_all_damage(e_clip);
        }
        continue;
      }
      /
      #
      assertmsg(((("" + str_param) + "") + m_e_trigger.targetname) + "");
    }
  }

  function set_trigger_func(func_trig, arg) {
    m_func_trig = func_trig;
    m_arg = arg;
  }

  function init(e_trigger) {
    m_e_trigger = e_trigger;
    m_a_clip = getEntArray(e_trigger.target, "targetname");
    m_a_nodes = getnodearray(e_trigger.target, "targetname");
    foreach(node in m_a_nodes) {
      if(isDefined(node.script_noteworthy) && node.script_noteworthy == "air_beast_node") {
        unlinktraversal(node);
      }
    }
    function_89be164a(e_trigger);
    setup_fxanims();
    parse_parameters();
    toggle_shader(1);
    function_6ea46467(1);
    thread main();
  }

}

#namespace zm_zod_smashables;

function autoexec __init__sytem__() {
  system::register("zm_zod_smashables", & __init__, undefined, undefined);
}

function __init__() {
  level thread init_smashables();
  foreach(str_bundle in level.zod_smashable_scriptbundles) {
    scene::add_scene_func(str_bundle, & add_scriptbundle_models, "init");
  }
}

function private smashable_from_scriptbundle_targetname(str_targetname) {
  foreach(o_smash in level.zod_smashables) {
    if(isDefined(o_smash.m_e_trigger.target) && o_smash.m_e_trigger.target == str_targetname) {
      return o_smash;
    }
  }
  return undefined;
}

function private add_scriptbundle_models(a_models) {
  o_smash = undefined;
  foreach(e_model in a_models) {
    if(!isDefined(o_smash)) {
      o_smash = smashable_from_scriptbundle_targetname(e_model._o_scene._e_root.targetname);
    }
    if(isDefined(o_smash)) {
      [
        [o_smash]
      ] - > add_model(e_model);
    }
  }
}

function private init_smashables() {
  level.zod_smashables = [];
  a_smashable_triggers = getEntArray("beast_melee_only", "script_noteworthy");
  n_id = 0;
  foreach(trigger in a_smashable_triggers) {
    str_id = "smash_unnamed_" + n_id;
    if(isDefined(trigger.targetname)) {
      str_id = trigger.targetname;
    } else {
      trigger.targetname = str_id;
      n_id++;
    }
    if(isDefined(level.zod_smashables[str_id])) {
      /
      #
      assertmsg(("" + str_id) + "");
      continue;
    }
    o_smashable = new csmashable();
    level.zod_smashables[str_id] = o_smashable;
    if(issubstr(str_id, "portal")) {
      [
        [o_smashable]
      ] - > set_trigger_func( & zm_zod_portals::function_54ec766b, str_id);
    }
    if(issubstr(str_id, "memento")) {
      [
        [o_smashable]
      ] - > set_trigger_func( & zm_zod_quest::reveal_personal_item, str_id);
    }
    if(issubstr(str_id, "beast_kiosk")) {
      [
        [o_smashable]
      ] - > set_trigger_func( & unlock_beast_kiosk, str_id);
    }
    if(str_id === "unlock_quest_key") {
      [
        [o_smashable]
      ] - > set_trigger_func( & unlock_quest_key, str_id);
    }
    [[o_smashable]] - > init(trigger);
  }
}

function unlock_beast_kiosk(str_id) {
  unlock_beast_trigger("beast_mode_kiosk_unavailable", str_id);
  unlock_beast_trigger("beast_mode_kiosk", str_id);
}

function unlock_beast_trigger(str_targetname, str_id) {
  triggers = getEntArray(str_targetname, "targetname");
  foreach(trigger in triggers) {
    if(trigger.script_noteworthy === str_id) {
      trigger.is_unlocked = 1;
    }
  }
}

function unlock_quest_key(str_id) {
  level.quest_key_can_be_picked_up = 1;
}

function add_callback(targetname, fn_callback, param1, param2, param3) {
  o_smashable = level.zod_smashables[targetname];
  if(!isDefined(o_smashable)) {
    /
    #
    assertmsg(("" + targetname) + "");
    return;
  }
  [[o_smashable]] - > add_callback(fn_callback, param1, param2, param3);
}

function private cb_connect_paths() {
  self.m_a_clip[0] connectpaths();
  if(isDefined(self.m_a_nodes)) {
    foreach(node in self.m_a_nodes) {
      if(isDefined(node.script_noteworthy) && node.script_noteworthy == "air_beast_node") {
        linktraversal(node);
      }
    }
  }
}

function private cb_fxanim(var_5b3a6271, var_bc554281, var_6bf8cfb8) {
  str_fxanim = self.m_e_trigger.target;
  s_fxanim = struct::get(str_fxanim, "targetname");
  if(var_bc554281) {
    level clientfield::set("breakable_hide", var_bc554281);
  }
  level scene::play(str_fxanim, "targetname");
  if(var_6bf8cfb8) {
    level clientfield::set("breakable_show", var_6bf8cfb8);
  }
}