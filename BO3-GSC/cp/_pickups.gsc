/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_pickups.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_laststand;
#using scripts\cp\_pickups;
#using scripts\cp\_scoreevents;
#using scripts\cp\_util;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;

class cpickupitem: cbaseinteractable {
  var m_e_model;
  var m_e_body_trigger;
  var m_n_respawn_rounds;
  var m_n_respawn_time;
  var m_n_despawn_wait;
  var m_custom_despawn_func;
  var m_n_drop_offset;
  var m_str_modelname;
  var m_fx_glow;
  var m_str_itemname;
  var m_str_pickup_hintstring;
  var m_iscarryable;
  var m_custom_spawn_func;
  var m_str_holding_hintstring;
  var m_e_carry_model;
  var m_n_throw_distance_min;
  var m_n_throw_distance_max;
  var m_n_throw_max_hold_duration;
  var m_v_holding_angle;
  var m_v_holding_offset_angle;
  var m_n_holding_distance;
  var a_carry_threads;
  var a_drop_funcs;

  constructor() {
    m_n_respawn_time = 1;
    m_n_respawn_rounds = 0;
    m_n_throw_distance_min = 128;
    m_n_throw_distance_max = 256;
    m_n_throw_max_hold_duration = 2;
    m_v_holding_angle = (0, 0, 0);
    m_n_despawn_wait = 0;
    m_v_holding_offset_angle = vectorscale((1, 0, 0), 45);
    m_n_holding_distance = 64;
    m_n_drop_offset = 0;
    m_iscarryable = 1;
    a_carry_threads = [];
    a_carry_threads[0] = &carry_pickupitem;
    a_drop_funcs = [];
    a_drop_funcs[0] = &drop_pickupitem;
  }

  destructor() {}

  function drop_pickupitem(e_triggerer) {
    pickupitem_spawn(e_triggerer.origin, e_triggerer.angles);
  }

  function carry_pickupitem(e_triggerer) {
    m_e_model delete();
    m_e_body_trigger setinvisibletoall();
  }

  function pickupitem_respawn_delay() {
    if(m_n_respawn_rounds > 0) {} else if(m_n_respawn_time > 0) {
      wait(m_n_respawn_time);
    }
  }

  function pickupitem_despawn() {
    self notify("respawn_pickupitem");
  }

  function debug_despawn_timer() {
    self endon("cancel_despawn");
    n_time_remaining = m_n_despawn_wait;
    while(n_time_remaining >= 0 && isDefined(m_e_model)) {
      print3d(m_e_model.origin + vectorscale((0, 0, 1), 15), n_time_remaining, (1, 0, 0), 1, 1, 20);
      wait(1);
      n_time_remaining = n_time_remaining - 1;
    }
  }

  function pickupitem_despawn_timer() {
    self endon("cancel_despawn");
    if(m_n_despawn_wait <= 0) {
      return;
    }
    self thread debug_despawn_timer();
    wait(m_n_despawn_wait);
    if(isDefined(m_custom_despawn_func)) {
      [[m_custom_despawn_func]]();
    } else {
      pickupitem_despawn();
    }
  }

  function pickupitem_spawn(v_pos, v_angles) {
    if(!isDefined(m_e_model)) {
      m_e_model = util::spawn_model(m_str_modelname, v_pos + (0, 0, m_n_drop_offset), v_angles);
      m_e_model notsolid();
      if(isDefined(m_fx_glow)) {
        playFXOnTag(m_fx_glow, m_e_model, "tag_origin");
      }
    }
    m_str_pickup_hintstring = ("Press and hold ^3[{+activate}]^7 to pick up ") + m_str_itemname;
    if(!isDefined(m_e_body_trigger)) {
      e_trigger = cbaseinteractable::spawn_body_trigger(v_pos);
      cbaseinteractable::set_body_trigger(e_trigger);
    }
    m_e_body_trigger setvisibletoall();
    m_e_body_trigger.origin = v_pos;
    m_e_body_trigger notify("upgrade_trigger_moved");
    m_e_body_trigger notify("upgrade_trigger_enable", 1);
    m_e_body_trigger sethintstring(m_str_pickup_hintstring);
    m_e_body_trigger.str_itemname = m_str_itemname;
    if(!isDefined(m_e_body_trigger.targetname)) {
      m_str_targetname = "";
      m_a_str_targetname = strtok(tolower(m_str_itemname), " ");
      foreach(n_index, m_str_targetname_piece in m_a_str_targetname) {
        if(n_index > 0) {
          m_str_targetname = m_str_targetname + "_";
        }
        m_str_targetname = m_str_targetname + m_str_targetname_piece;
      }
      m_e_body_trigger.targetname = "trigger_" + m_str_targetname;
    }
    if(m_iscarryable) {
      self thread cbaseinteractable::thread_allow_carry();
    }
  }

  function respawn_loop(v_pos, v_angles) {
    while(true) {
      if(isDefined(m_custom_spawn_func)) {
        [[m_custom_spawn_func]](v_pos, v_angles);
      } else {
        m_str_holding_hintstring = ("Press ^3[{+usereload}]^7 to drop ") + m_str_itemname;
        pickupitem_spawn(v_pos, v_angles);
      }
      self waittill("respawn_pickupitem");
      pickupitem_respawn_delay();
    }
  }

  function spawn_at_position(v_pos, v_angles) {
    respawn_loop(v_pos, v_angles);
  }

  function spawn_at_struct(str_struct) {
    if(!isDefined(str_struct.angles)) {
      str_struct.angles = (0, 0, 0);
    }
    respawn_loop(str_struct.origin, str_struct.angles);
  }

  function get_model() {
    if(isDefined(m_e_carry_model)) {
      return m_e_carry_model;
    }
    if(isDefined(m_e_model)) {
      return m_e_model;
    }
    return undefined;
  }
}

class cbaseinteractable {
  var m_n_body_trigger_height;
  var m_n_body_trigger_radius;
  var m_n_repair_height;
  var m_n_repair_radius;
  var m_e_player_currently_holding;
  var disable_object_pickup;
  var m_e_carry_model;
  var a_drop_funcs;
  var m_v_holding_offset_angle;
  var m_v_holding_angle;
  var m_n_holding_distance;
  var m_str_carry_model;
  var m_str_modelname;
  var m_str_itemname;
  var m_e_body_trigger;
  var a_carry_threads;
  var m_iscarryable;
  var m_allow_carry_custom_conditions_func;
  var m_repair_complete_func;
  var m_repair_custom_complete_func;
  var m_prompt_manager_custom_func;
  var m_isfunctional;
  var m_ishackable;

  constructor() {
    m_isfunctional = 1;
    m_ishackable = 0;
    m_iscarryable = 0;
    m_n_body_trigger_radius = 36;
    m_n_body_trigger_height = 128;
    m_n_repair_radius = 72;
    m_n_repair_height = 128;
    m_repair_complete_func = &repair_completed;
    m_str_itemname = "Item";
  }

  destructor() {}

  function spawn_interact_trigger(v_origin, n_radius, n_height, str_hint) {
    assert(isDefined(v_origin), "");
    assert(isDefined(n_radius), "");
    assert(isDefined(n_height), "");
    e_trigger = spawn("trigger_radius", v_origin, 0, n_radius, n_height);
    e_trigger triggerignoreteam();
    e_trigger setvisibletoall();
    e_trigger setteamfortrigger("none");
    e_trigger setcursorhint("HINT_NOICON");
    if(isDefined(str_hint)) {
      e_trigger sethintstring(str_hint);
    }
    return e_trigger;
  }

  function spawn_body_trigger(v_origin) {
    e_trigger = spawn_interact_trigger(v_origin, m_n_body_trigger_radius, m_n_body_trigger_height, "");
    e_trigger sethintlowpriority(1);
    return e_trigger;
  }

  function spawn_repair_trigger(v_origin) {
    e_repair_trigger = spawn_interact_trigger(v_origin, m_n_repair_radius, m_n_repair_height, "Bring Toolbox to repair");
    return e_repair_trigger;
  }

  function drop_on_death(e_triggerer) {
    self notify("drop_on_death");
    self endon("drop_on_death");
    e_triggerer util::waittill_any("player_downed", "death");
    if(isDefined(m_e_player_currently_holding)) {
      drop(e_triggerer);
    }
  }

  function _wait_for_button_release() {
    self endon("player_downed");
    while(self usebuttonpressed()) {
      wait(0.05);
    }
  }

  function wait_for_button_release() {
    self endon("death_or_disconnect");
    disable_object_pickup = 1;
    self _wait_for_button_release();
    self.disable_object_pickup = undefined;
  }

  function destroy() {
    if(isDefined(m_e_player_currently_holding)) {
      restore_player_controls_from_carry(m_e_player_currently_holding);
      m_e_player_currently_holding util::screen_message_delete_client();
    }
    if(isDefined(m_e_carry_model)) {
      m_e_carry_model delete();
    }
    m_e_player_currently_holding = undefined;
  }

  function remove(e_triggerer) {
    restore_player_controls_from_carry(e_triggerer);
    e_triggerer util::screen_message_delete_client();
    if(isDefined(m_e_carry_model)) {
      m_e_carry_model delete();
    }
    m_e_player_currently_holding = undefined;
    self notify("respawn_pickupitem");
  }

  function drop(e_triggerer) {
    restore_player_controls_from_carry(e_triggerer);
    e_triggerer util::screen_message_delete_client();
    if(isDefined(m_e_carry_model)) {
      m_e_carry_model delete();
    }
    if(isDefined(a_drop_funcs)) {
      foreach(drop_func in a_drop_funcs) {
        [[drop_func]](e_triggerer);
      }
    }
    m_e_player_currently_holding = undefined;
    self thread thread_allow_carry();
    e_triggerer thread wait_for_button_release();
  }

  function restore_player_controls_from_carry(e_triggerer) {
    e_triggerer endon("death");
    e_triggerer endon("player_downed");
    if(!e_triggerer.is_carrying_pickupitem) {
      return;
    }
    e_triggerer notify("restore_player_controls_from_carry");
    e_triggerer enableweapons();
    e_triggerer.is_carrying_pickupitem = 0;
    e_triggerer allowjump(1);
  }

  function show_carry_model(e_triggerer) {
    e_triggerer endon("restore_player_controls_from_carry");
    e_triggerer endon("death");
    e_triggerer endon("player_downed");
    v_eye_origin = e_triggerer getEye();
    v_player_angles = e_triggerer getplayerangles();
    v_player_angles = v_player_angles + m_v_holding_offset_angle;
    v_player_angles = anglesToForward(v_player_angles);
    v_angles = e_triggerer.angles + m_v_holding_angle;
    v_origin = v_eye_origin + (v_player_angles * m_n_holding_distance);
    if(!isDefined(m_str_carry_model)) {
      if(isDefined(m_str_modelname)) {
        m_str_carry_model = m_str_modelname;
      } else {
        m_str_carry_model = "script_origin";
      }
    }
    m_e_carry_model = util::spawn_model(m_str_carry_model, v_origin, v_angles);
    m_e_carry_model notsolid();
    while(isDefined(m_e_carry_model)) {
      v_eye_origin = e_triggerer getEye();
      v_player_angles = e_triggerer getplayerangles();
      v_player_angles = v_player_angles + m_v_holding_offset_angle;
      v_player_angles = anglesToForward(v_player_angles);
      m_e_carry_model.angles = e_triggerer.angles + m_v_holding_angle;
      m_e_carry_model.origin = v_eye_origin + (v_player_angles * m_n_holding_distance);
      wait(0.05);
    }
  }

  function thread_allow_drop(e_triggerer) {
    e_triggerer endon("restore_player_controls_from_carry");
    e_triggerer endon("death");
    e_triggerer endon("player_downed");
    self thread drop_on_death(e_triggerer);
    while(e_triggerer usebuttonpressed()) {
      wait(0.05);
    }
    while(!e_triggerer usebuttonpressed()) {
      wait(0.05);
    }
    self thread drop(e_triggerer);
  }

  function flash_drop_prompt_stop(player) {
    player notify("stop_flashing_drop_prompt");
    player util::screen_message_delete_client();
  }

  function flash_drop_prompt(player) {
    self endon("death");
    player endon("death");
    player endon("stop_flashing_drop_prompt");
    while(true) {
      player util::screen_message_create_client(get_drop_prompt(), undefined, undefined, 0, 0.35);
      wait(0.35);
    }
  }

  function show_drop_prompt(player) {
    player util::screen_message_create_client(get_drop_prompt());
  }

  function get_drop_prompt() {
    return ("Press ^3[{+usereload}]^7 to drop ") + m_str_itemname;
  }

  function carry(e_triggerer) {
    e_triggerer endon("death");
    e_triggerer endon("player_downed");
    e_triggerer.o_pickupitem = self;
    m_e_player_currently_holding = e_triggerer;
    m_e_body_trigger notify("upgrade_trigger_enable", 0);
    self notify("cancel_despawn");
    e_triggerer disableweapons();
    wait(0.5);
    if(isDefined(a_carry_threads)) {
      foreach(carry_thread in a_carry_threads) {
        self thread[[carry_thread]](e_triggerer);
      }
    } else {
      e_triggerer allowjump(0);
    }
    self thread show_drop_prompt(e_triggerer);
    self thread show_carry_model(e_triggerer);
    self thread thread_allow_drop(e_triggerer);
  }

  function thread_allow_carry() {
    self notify("thread_allow_carry");
    self endon("thread_allow_carry");
    self endon("unmake");
    if(1) {
      for(;;) {
        wait(0.05);
        return;
        m_e_body_trigger waittill("trigger", e_triggerer);
        m_e_body_trigger sethintstringforplayer(e_triggerer, "");
      }
      for(;;) {}
      for(;;) {}
      for(;;) {}
      for(;;) {}
      for(;;) {
        return;
      }
      for(;;) {}
      for(;;) {}
      if(!isDefined(m_e_body_trigger)) {}
      if(isDefined(e_triggerer.is_carrying_pickupitem) && e_triggerer.is_carrying_pickupitem) {}
      if(!m_iscarryable) {}
      if(isDefined(e_triggerer.disable_object_pickup) && e_triggerer.disable_object_pickup) {}
      if(!e_triggerer util::use_button_held()) {}
      if(isDefined(m_allow_carry_custom_conditions_func) && ![[m_allow_carry_custom_conditions_func]]()) {}
      if(!isDefined(m_e_body_trigger)) {}
      if(!e_triggerer istouching(m_e_body_trigger)) {}
      if(isDefined(e_triggerer.is_carrying_pickupitem) && e_triggerer.is_carrying_pickupitem) {}
      if(e_triggerer laststand::player_is_in_laststand()) {}
      e_triggerer.is_carrying_pickupitem = 1;
      self thread carry(e_triggerer);
      return;
    }
  }

  function disable_carry() {
    m_iscarryable = 0;
    self notify("thread_allow_carry");
  }

  function enable_carry() {
    m_iscarryable = 1;
    self thread thread_allow_carry();
  }

  function set_body_trigger(e_trigger) {
    assert(!isDefined(m_e_body_trigger));
    m_e_body_trigger = e_trigger;
  }

  function repair_trigger() {
    self endon("unmake");
    while(true) {
      m_e_body_trigger waittill("trigger", player);
      if(isDefined(player.is_carrying_pickupitem) && player.is_carrying_pickupitem && player.o_pickupitem.m_str_itemname == "Toolbox") {
        [[player.o_pickupitem]] - > remove(player);
        [[m_repair_complete_func]](player);
      }
      wait(0.05);
    }
  }

  function repair_completed(player) {
    self notify("repair_completed");
    if(isDefined(m_repair_custom_complete_func)) {
      self thread[[m_repair_custom_complete_func]](player);
    }
  }

  function prompt_manager() {
    if(isDefined(m_prompt_manager_custom_func)) {
      self thread[[m_prompt_manager_custom_func]]();
    } else {
      while(isDefined(m_e_body_trigger)) {
        if(!m_isfunctional) {
          m_e_body_trigger sethintstring("Bring Toolbox to repair");
          wait(0.05);
          continue;
        }
        wait(0.05);
      }
    }
  }

  function get_player_currently_holding() {
    return m_e_player_currently_holding;
  }
}