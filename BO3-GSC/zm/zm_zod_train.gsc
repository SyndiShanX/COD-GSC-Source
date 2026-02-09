/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_train.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_zod_cleanup_mgr;
#using scripts\zm\zm_zod_util;

class czmtrain {
  var m_vh_train;
  var m_a_jumptags;
  var var_9e0dc993;
  var m_a_s_stations;
  var m_n_last_jumper_time;
  var m_a_zombies_locked_in;
  var m_e_volume;
  var m_str_destination;
  var m_t_switch;
  var m_str_station;
  var m_s_trigger;
  var m_b_free;
  var var_901503d0;
  var var_619deb2d;
  var m_a_mdl_doors;
  var m_b_facing_forward;
  var var_97fef807;
  var m_b_incoming;
  var origin;
  var angles;

  constructor() {
    m_vh_train = undefined;
    m_s_trigger = undefined;
    m_t_switch = undefined;
    m_e_volume = undefined;
    m_b_facing_forward = 1;
    m_b_free = 0;
    m_b_incoming = 0;
    m_a_s_stations = [];
    m_a_mdl_doors = [];
    m_str_station = undefined;
    m_str_destination = undefined;
    m_a_zombies_locked_in = [];
    m_n_last_jumper_time = 0;
    m_a_jumptags = [];
    var_9e0dc993 = 1;
    a_names = array("tag_enter_back_top", "tag_enter_front_top", "tag_enter_left_top", "tag_enter_right_top");
    a_anims = array("ai_zombie_zod_train_win_trav_from_roof_b", "ai_zombie_zod_train_win_trav_from_roof_f", "ai_zombie_zod_train_win_trav_from_roof_l", "ai_zombie_zod_train_win_trav_from_roof_r");
    assert(a_names.size == a_anims.size);
    for(i = 0; i < a_names.size; i++) {
      str_name = a_names[i];
      str_anim = a_anims[i];
      m_a_jumptags[str_name] = spawnStruct();
      s_entrance = m_a_jumptags[str_name];
      s_entrance.str_tag = str_name;
      s_entrance.str_anim = str_anim;
      s_entrance.occupied = 0;
    }
  }

  destructor() {}

  function function_876255() {
    a_e_train_maps = getEntArray("map_train", "targetname");
    while(true) {
      str_station = get_current_station();
      switch (str_station) {
        case "slums": {
          n_station = 1;
          break;
        }
        case "theater": {
          n_station = 2;
          break;
        }
        case "canal": {
          n_station = 3;
          break;
        }
      }
      foreach(e_train_map in a_e_train_maps) {
        e_train_map clientfield::set("train_map_light", n_station);
      }
      self flag::wait_till("moving");
      foreach(e_train_map in a_e_train_maps) {
        e_train_map clientfield::set("train_map_light", 0);
      }
      self flag::wait_till_clear("moving");
    }
  }

  function get_origin() {
    return m_vh_train.origin;
  }

  function get_available_jumptag() {
    a_valid_tags = [];
    foreach(tag in m_a_jumptags) {
      if(tag.occupied) {
        continue;
      }
      if(!isDefined(a_valid_tags)) {
        a_valid_tags = [];
      } else if(!isarray(a_valid_tags)) {
        a_valid_tags = array(a_valid_tags);
      }
      a_valid_tags[a_valid_tags.size] = tag;
    }
    a_valid_tags = array::randomize(a_valid_tags);
    a_forward_tags = [];
    a_players = get_players_on_train(0);
    n_roll = randomint(100);
    if(n_roll < 80 && a_players.size > 0) {
      foreach(s_tag in a_valid_tags) {
        if(any_player_facing_tag(s_tag.str_tag)) {
          if(!isDefined(a_forward_tags)) {
            a_forward_tags = [];
          } else if(!isarray(a_forward_tags)) {
            a_forward_tags = array(a_forward_tags);
          }
          a_forward_tags[a_forward_tags.size] = s_tag;
        }
      }
    }
    if(a_forward_tags.size > 2) {
      a_valid_tags = a_forward_tags;
    }
    if(a_valid_tags.size == 0) {
      return undefined;
    }
    return array::random(a_valid_tags);
  }

  function private any_player_facing_tag(str_tag) {
    foreach(e_player in level.players) {
      v_pos = m_vh_train gettagorigin(str_tag);
      v_fwd = anglesToForward(e_player.angles);
      v_to_tag = vectornormalize(v_pos - e_player.origin);
      if(vectordot(v_fwd, v_to_tag) > 0) {
        return true;
      }
    }
    return false;
  }

  function is_offline() {
    return self flag::get("offline");
  }

  function is_cooling_down() {
    return self flag::get("cooldown");
  }

  function function_3e62f527() {
    return var_9e0dc993;
  }

  function is_moving() {
    return self flag::get("moving");
  }

  function get_junction_origin() {
    v_origin = (0, 0, 0);
    foreach(s_station in m_a_s_stations) {
      v_origin = v_origin + s_station.junction_node.origin;
    }
    v_origin = v_origin / float(m_a_s_stations.size);
    return v_origin;
  }

  function jump_into_train(ai, str_tag) {
    self endon("death");
    s_tag = m_a_jumptags[str_tag];
    s_tag.occupied = 1;
    v_tag_pos = m_vh_train gettagorigin(str_tag);
    v_tag_angles = m_vh_train gettagangles(str_tag);
    ai teleport(v_tag_pos, v_tag_angles);
    util::wait_network_frame();
    ai linkto(m_vh_train, str_tag);
    ai animscripted("entered_train", v_tag_pos, v_tag_angles, s_tag.str_anim);
    ai zombie_shared::donotetracks("entered_train");
    ai unlink();
    s_tag.occupied = 0;
    if(is_moving()) {
      add_zombie_locked_in(ai);
    }
  }

  function mark_jumper_time() {
    m_n_last_jumper_time = gettime();
  }

  function get_time_since_last_jumper() {
    return (float(gettime() - m_n_last_jumper_time)) / 1000;
  }

  function get_zombies_locked_in() {
    return m_a_zombies_locked_in;
  }

  function locked_in_list_remove_undefined() {
    m_a_zombies_locked_in = array::remove_undefined(m_a_zombies_locked_in);
  }

  function remove_zombie_locked_in(ai_zombie) {
    ai_zombie.locked_in_train = 0;
    arrayremovevalue(m_a_zombies_locked_in, ai_zombie);
    ai_zombie notify("released_from_train");
  }

  function add_zombie_locked_in(ai_zombie) {
    ai_zombie.locked_in_train = 1;
    array::add(m_a_zombies_locked_in, ai_zombie, 0);
    thread watch_zombie_fall_off(ai_zombie);
  }

  function get_players_on_train(b_valid_targets_only = 0) {
    a_players = [];
    foreach(e_player in level.players) {
      if(b_valid_targets_only && (e_player.ignoreme || !zm_utility::is_player_valid(e_player))) {
        continue;
      }
      if(e_player.on_train) {
        if(!isDefined(a_players)) {
          a_players = [];
        } else if(!isarray(a_players)) {
          a_players = array(a_players);
        }
        a_players[a_players.size] = e_player;
      }
    }
    return a_players;
  }

  function is_touching_train_volume(ent) {
    return ent istouching(m_e_volume);
  }

  function watch_zombie_fall_off(ai) {
    ai endon("death");
    ai endon("released_from_train");
    zm_net::network_safe_init("train_fall_check", 1);
    while(self zm_net::network_choke_action("train_fall_check", &is_touching_train, ai)) {
      wait(2);
    }
    remove_zombie_locked_in(ai);
  }

  function is_touching_train(e_ent) {
    return e_ent istouching(m_e_volume);
  }

  function watch_players_on_train() {
    foreach(e_player in level.players) {
      assert(isDefined(e_player.on_train));
    }
    while(true) {
      foreach(e_player in level.players) {
        e_player.on_train = is_touching_train(e_player);
      }
      wait(0.5);
    }
  }

  function function_ccd778ab() {
    foreach(e_player in level.players) {
      if(is_touching_train(e_player)) {
        return false;
      }
    }
    return true;
  }

  function function_ca899bfc() {
    if(m_str_destination == "slums") {
      m_vh_train hidepart("tag_sign_footlight");
      m_vh_train hidepart("tag_sign_canals");
      m_vh_train showpart("tag_sign_waterfront");
      playsoundatposition("evt_train_switch_track_hit", m_t_switch.origin);
    } else {
      if(m_str_destination == "theater") {
        m_vh_train hidepart("tag_sign_canals");
        m_vh_train hidepart("tag_sign_waterfront");
        m_vh_train showpart("tag_sign_footlight");
        playsoundatposition("evt_train_switch_track_hit", m_t_switch.origin);
      } else if(m_str_destination == "canal") {
        m_vh_train hidepart("tag_sign_footlight");
        m_vh_train hidepart("tag_sign_waterfront");
        m_vh_train showpart("tag_sign_canals");
        playsoundatposition("evt_train_switch_track_hit", m_t_switch.origin);
      }
    }
  }

  function function_de6e1f4f(m_t_switch) {
    m_vh_train endon("hash_51689c0f");
    if(!flag::get("switches_enabled")) {
      flag::wait_till("switches_enabled");
    }
    m_t_switch.player_used = 0;
    m_t_switch waittill("trigger");
    m_t_switch.player_used = 1;
  }

  function run_switch() {
    while(true) {
      function_de6e1f4f(m_t_switch);
      str_prev_dest = m_str_destination;
      if(m_t_switch.player_used) {
        m_a_s_stations[m_str_station].b_left_path_active = !m_a_s_stations[m_str_station].b_left_path_active;
        m_str_destination = get_current_destination();
      }
      if(m_str_destination != str_prev_dest) {
        function_ca899bfc();
        if(is_moving() && !level flag::get("callbox")) {
          sndnum = m_a_s_stations[m_str_destination].audio_divert;
          level clientfield::set("sndTrainVox", sndnum);
          m_vh_train playsoundontag(level.var_98f27ad[sndnum - 1], "tag_support_arm_01");
        }
        if(level flag::get("callbox")) {
          level flag::clear("callbox");
        }
        m_t_switch sethintstring(&"ZM_ZOD_SWITCHING_PROGRESS");
        wait(1);
        if(flag::get("switches_enabled")) {
          m_t_switch sethintstring(&"ZM_ZOD_SWITCH_ENABLE");
        }
      }
      level notify("hash_8939bd21");
    }
  }

  function send_train() {
    if(isDefined(m_s_trigger)) {
      m_b_free = 1;
      m_s_trigger notify("trigger");
    }
  }

  function update_use_trigger() {
    if(!isDefined(m_s_trigger)) {
      return;
    }
    if(m_b_free) {
      m_s_trigger zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_USE_FREE");
    } else {
      if(is_offline()) {
        m_s_trigger zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_OFFLINE");
      } else {
        if(is_cooling_down()) {
          m_s_trigger zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_COOLDOWN");
        } else {
          m_s_trigger zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_USE", 500);
        }
      }
    }
  }

  function recalc_zombies_locked_in_train() {
    zombies = getaiteamarray(level.zombie_team);
    n_counter = 0;
    foreach(zombie in zombies) {
      if(!isDefined(zombie) || !isalive(zombie)) {
        continue;
      }
      if(is_touching_train_volume(zombie)) {
        add_zombie_locked_in(zombie);
      }
      n_counter++;
      if((n_counter % 3) == 0) {
        util::wait_network_frame();
      }
    }
  }

  function function_285f0f0b() {
    if(var_901503d0) {
      self scene::play("p7_fxanim_zm_zod_train_door_rt_close_bundle", self);
      var_901503d0 = 0;
    }
    if(var_619deb2d) {
      self scene::play("p7_fxanim_zm_zod_train_door_lft_close_bundle", self);
      var_619deb2d = 0;
    }
  }

  function function_9211290c() {
    foreach(e_door in m_a_mdl_doors) {
      v_pos = get_door_closed_pos(e_door);
      e_door unlink();
      e_door moveto(v_pos, 0.3);
      e_door.e_clip unlink();
      e_door.e_clip moveto(e_door.e_clip.var_b620e1b1.origin, 0.3);
    }
    m_a_mdl_doors[0] waittill("movedone");
    util::wait_network_frame();
    foreach(e_door in m_a_mdl_doors) {
      v_pos = get_door_closed_pos(e_door);
      e_door.origin = v_pos;
      e_door.angles = e_door.script_origin.angles;
      e_door linkto(m_vh_train);
      e_door.e_clip linkto(m_vh_train);
    }
  }

  function close_doors() {
    m_vh_train function_285f0f0b();
    foreach(e_door in m_a_mdl_doors) {
      v_pos = get_door_closed_pos(e_door);
      e_door unlink();
      e_door moveto(v_pos, 0.3);
      e_door.e_clip unlink();
      e_door.e_clip moveto(e_door.e_clip.var_b620e1b1.origin, 0.3);
    }
    m_a_mdl_doors[0] waittill("movedone");
    util::wait_network_frame();
    foreach(e_door in m_a_mdl_doors) {
      v_pos = get_door_closed_pos(e_door);
      e_door.origin = v_pos;
      e_door.angles = e_door.script_origin.angles;
      e_door linkto(m_vh_train);
      e_door.e_clip linkto(m_vh_train);
    }
    thread recalc_zombies_locked_in_train();
  }

  function function_59722edc(str_side) {
    if(str_side == "right") {
      if(!var_901503d0) {
        self thread scene::play("p7_fxanim_zm_zod_train_door_rt_open_bundle", self);
        var_901503d0 = 1;
      }
    } else if(!var_619deb2d) {
      self thread scene::play("p7_fxanim_zm_zod_train_door_lft_open_bundle", self);
      var_619deb2d = 1;
    }
  }

  function open_doors(str_side = get_open_side()) {
    m_vh_train function_59722edc(str_side);
    var_7631d55c = vectorscale((0, 0, 1), 300);
    a_doors_moved = [];
    foreach(e_door in m_a_mdl_doors) {
      if(!isDefined(str_side) || (str_side == "left" && e_door.script_string == "train_rear_door") || (str_side == "right" && e_door.script_string == "train_front_door")) {
        v_pos = get_door_open_pos(e_door);
        e_door unlink();
        e_door moveto(v_pos, 0.3);
        if(!isDefined(a_doors_moved)) {
          a_doors_moved = [];
        } else if(!isarray(a_doors_moved)) {
          a_doors_moved = array(a_doors_moved);
        }
        a_doors_moved[a_doors_moved.size] = e_door;
        e_door.e_clip unlink();
        e_door.e_clip moveto(e_door.e_clip.origin + var_7631d55c, 0.3);
      }
    }
    if(a_doors_moved.size > 0) {
      a_doors_moved[0] waittill("movedone");
      util::wait_network_frame();
    }
    util::wait_network_frame();
    foreach(e_door in a_doors_moved) {
      v_pos = get_door_open_pos(e_door);
      e_door.origin = v_pos;
      e_door.angles = e_door.script_origin.angles;
      e_door linkto(m_vh_train);
      e_door.e_clip linkto(m_vh_train);
    }
    for(i = m_a_zombies_locked_in.size - 1; i >= 0; i--) {
      ai = m_a_zombies_locked_in[i];
      if(isDefined(ai)) {
        remove_zombie_locked_in(ai);
      }
    }
    m_a_zombies_locked_in = [];
  }

  function is_door_open(e_door) {
    str_side = get_open_side();
    if(str_side == "left" && e_door.script_string == "train_rear_door" || (str_side == "right" && e_door.script_string == "train_front_door")) {
      return var_9e0dc993;
    }
    return 0;
  }

  function get_open_side() {
    str_side = m_a_s_stations[m_str_station].door_side;
    if(!m_b_facing_forward) {
      if(str_side == "left") {
        return "right";
      }
      if(str_side == "right") {
        return "left";
      }
    }
    return str_side;
  }

  function get_door_closed_pos(e_door) {
    return e_door.script_origin.origin;
  }

  function get_door_open_pos(e_door) {
    if(e_door.script_string == "front_door") {
      return e_door.script_origin.origin - (anglesToForward(e_door.script_origin.angles) * 100);
    }
    return e_door.script_origin.origin + (anglesToForward(e_door.script_origin.angles) * 100);
  }

  function run_gate(e_gate, a_jump_nodes) {
    nd_start = m_a_s_stations[e_gate.script_string].start_node;
    v_open = e_gate.origin;
    v_closed = v_open + (anglesToForward(nd_start.angles) * 96);
    if(m_a_s_stations[e_gate.script_string].door_side == "right") {
      v_closed = v_open - (anglesToForward(nd_start.angles) * 96);
    }
    b_open = 1;
    while(true) {
      if(b_open) {
        var_9e0dc993 = 0;
        e_gate moveto(v_closed, 1);
        b_open = 0;
        foreach(nd in a_jump_nodes) {
          unlinktraversal(nd);
        }
      }
      self flag::wait_till_clear("moving");
      if(m_str_station == e_gate.script_string) {
        e_gate moveto(v_open, 1);
        b_open = 1;
        e_gate waittill("movedone");
        foreach(nd in a_jump_nodes) {
          b_fwd_node = nd.script_string === "forward";
          if(m_b_facing_forward && b_fwd_node || (!m_b_facing_forward && !b_fwd_node)) {
            linktraversal(nd);
          }
        }
        var_9e0dc993 = 1;
      }
      self flag::wait_till("moving");
      wait(1);
    }
  }

  function run_callbox(str_callbox) {
    assert(isDefined(m_str_station));
    e_lever = m_a_s_stations[str_callbox].callbox;
    t_use = zm_zod_util::spawn_trigger_radius(e_lever.origin, 60, 1);
    thread run_callbox_hintstring(str_callbox, t_use, getent(e_lever.target, "targetname"));
    while(true) {
      t_use waittill("trigger", e_who);
      if(!e_who zm_score::can_player_purchase(500)) {
        e_who zm_audio::create_and_play_dialog("general", "transport_deny");
        continue;
      }
      if(m_str_station != str_callbox && isDefined(m_s_trigger)) {
        m_b_free = 0;
        if(str_callbox != m_str_destination) {
          level flag::set("callbox");
          m_t_switch notify("trigger");
          level waittill("hash_8939bd21");
        }
        m_s_trigger notify("trigger", e_who);
        util::wait_network_frame();
        m_b_free = 1;
        e_lever rotatepitch(180, 0.5);
        self flag::wait_till("moving");
        self flag::wait_till_clear("moving");
        e_lever rotatepitch(-180, 0.5);
      }
    }
  }

  function run_callbox_hintstring(str_callbox, t_use, e_light) {
    while(true) {
      if(m_str_station == str_callbox) {
        e_light clientfield::set("train_callbox_light", 0);
        t_use zm_zod_util::set_unitrigger_hint_string(&"");
      } else {
        e_light clientfield::set("train_callbox_light", 1);
        t_use zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_CALL", 500);
      }
      self flag::wait_till("moving");
      e_light clientfield::set("train_callbox_light", 0);
      t_use zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_MOVING");
      self flag::wait_till_clear("moving");
      wait(0.05);
      if(self flag::get("offline")) {
        t_use zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_OFFLINE");
        e_light clientfield::set("train_callbox_light", 2);
        self flag::wait_till_clear("offline");
      } else {
        if(m_str_station == str_callbox) {
          t_use zm_zod_util::set_unitrigger_hint_string(&"");
          self flag::wait_till_clear("cooldown");
        } else {
          t_use zm_zod_util::set_unitrigger_hint_string(&"ZM_ZOD_TRAIN_COOLDOWN");
          self flag::wait_till_clear("cooldown");
        }
      }
    }
  }

  function function_b0af9dac() {
    while(true) {
      level waittill("between_round_over");
      level.var_33c4ee76 = 0;
      wait(0.05);
    }
  }

  function function_955e57a7() {
    level flag::wait_till("ee_boss_defeated");
    level notify("hash_12be7dbb");
    self flag::clear("offline");
    update_use_trigger();
  }

  function function_312bb6e1() {
    level endon("hash_12be7dbb");
    if(level flag::get("ee_boss_defeated") && !level flag::get("ee_final_boss_defeated")) {
      return;
    }
    if(level.var_33c4ee76 < 5) {
      return;
    }
    self flag::set("offline");
    m_vh_train clientfield::set("train_switch_light", 2);
    update_use_trigger();
    level waittill("between_round_over");
    self flag::clear("offline");
    wait(0.05);
  }

  function function_a377ba46() {
    if(flag::get("moving")) {
      var_38c97a3b = get_current_destination();
    } else {
      var_38c97a3b = m_str_station;
    }
    switch (var_38c97a3b) {
      case "slums": {
        var_bddb9113 = "lgt_exp_train_slums_debug";
        break;
      }
      case "canal": {
        var_bddb9113 = "lgt_exp_train_canals_debug";
        break;
      }
      case "theater": {
        var_bddb9113 = "lgt_exp_train_theater_debug";
        break;
      }
    }
    if(flag::get("moving")) {
      exploder::exploder(var_bddb9113);
    } else {
      wait(2);
      exploder::exploder_stop(var_bddb9113);
    }
  }

  function main() {
    a_path_names = getarraykeys(m_a_s_stations);
    a_path_names = array::randomize(a_path_names);
    m_str_station = a_path_names[0];
    var_97fef807 = m_str_station;
    m_a_s_stations[m_str_station].b_left_path_active = randomint(2);
    m_str_destination = get_current_destination();
    m_vh_train attachpath(m_a_s_stations[m_str_station].start_node);
    b_first_run = 1;
    self thread function_876255();
    self thread watch_players_on_train();
    self thread function_955e57a7();
    wait(1);
    v_front = m_vh_train gettagorigin("tag_button_front");
    m_s_trigger = zm_zod_util::spawn_trigger_radius(v_front, 60, 1);
    m_vh_train playLoopSound("evt_train_idle_loop", 4);
    open_doors();
    thread run_switch();
    while(true) {
      update_use_trigger();
      enable_train_switches(1);
      level thread function_b0af9dac();
      while(true) {
        m_vh_train clientfield::set("train_switch_light", 1);
        m_s_trigger waittill("trigger", e_who);
        m_vh_train clientfield::set("train_switch_light", 0);
        if(m_b_free) {
          m_b_free = 0;
          break;
        } else {
          if(!e_who zm_score::can_player_purchase(500)) {
            e_who zm_audio::create_and_play_dialog("general", "transport_deny");
          } else {
            e_who zm_score::minus_to_player_score(500);
            e_who zm_audio::create_and_play_dialog("train", "start");
            break;
          }
        }
      }
      level.var_33c4ee76++;
      thread function_a377ba46();
      wait(0.05);
      self flag::set("moving");
      zm_unitrigger::unregister_unitrigger(m_s_trigger);
      m_s_trigger = undefined;
      close_doors();
      m_vh_train playSound("evt_train_start");
      m_vh_train playLoopSound("evt_train_loop", 4);
      var_8d722bd4 = function_ccd778ab();
      if(var_8d722bd4 || b_first_run) {
        m_vh_train setspeed(32);
      } else {
        level.b_host_migration_force_player_respawn = 1;
        thread function_a9acf9e2();
      }
      move();
      m_vh_train playLoopSound("evt_train_idle_loop", 4);
      a_riders = get_players_on_train(0);
      if(a_riders.size > 0) {
        level flag::set(m_a_s_stations[m_str_station].str_zone_flag);
        level flag::set("train_rode_to_" + m_str_station);
      }
      if(var_8d722bd4 || b_first_run) {
        m_vh_train resumespeed();
      }
      if(b_first_run) {
        b_first_run = 0;
      }
      open_doors();
      a_riders = get_players_on_train(0);
      if(a_riders.size > 0) {
        var_3a349c58 = a_riders[randomint(a_riders.size)];
        var_3a349c58 zm_audio::create_and_play_dialog("train", "stop");
      }
      v_trig = (0, 0, 0);
      if(!m_b_facing_forward) {
        v_trig = m_vh_train gettagorigin("tag_button_back");
      } else {
        v_trig = m_vh_train gettagorigin("tag_button_front");
      }
      self flag::clear("moving");
      level.b_host_migration_force_player_respawn = 0;
      self function_312bb6e1();
      if(!m_b_free && level.var_33c4ee76 > 0) {
        self flag::set("cooldown");
        update_use_trigger();
        n_wait = 40;
        if(getdvarint("") > 0) {
          n_wait = 5;
        }
        wait(n_wait);
        m_s_trigger = zm_zod_util::spawn_trigger_radius(v_trig, 60, 1);
        self flag::clear("cooldown");
      } else {
        m_s_trigger = zm_zod_util::spawn_trigger_radius(v_trig, 60, 1);
      }
    }
  }

  function function_6f6ab7a4() {
    for(i = 0; i < m_a_mdl_doors.size; i++) {
      e_door = m_a_mdl_doors[i];
      e_door hide();
      if(e_door.script_string == "train_front_door") {
        e_door.e_clip = getent("train_front_clip", "script_string");
      } else if(e_door.script_string == "train_rear_door") {
        e_door.e_clip = getent("train_rear_clip", "script_string");
      }
      if(isDefined(e_door.e_clip)) {
        e_origin = spawn("script_origin", e_door.e_clip.origin);
        e_origin.angles = m_vh_train.angles;
        e_origin linkto(m_vh_train);
        e_door.e_clip.var_b620e1b1 = e_origin;
      }
    }
  }

  function initialize(e_train) {
    assert(isDefined(e_train));
    m_vh_train = e_train;
    m_vh_train.var_619deb2d = 0;
    m_vh_train.var_901503d0 = 0;
    if(!self flag::exists("moving")) {
      self flag::init("moving", 0);
    }
    if(!self flag::exists("cooldown")) {
      self flag::init("cooldown", 0);
    }
    if(!self flag::exists("offline")) {
      self flag::init("offline", 0);
    }
    if(!self flag::exists("switches_enabled")) {
      self flag::init("switches_enabled", 1);
    }
    if(!level flag::exists("callbox")) {
      level flag::init("callbox");
    }
    m_vh_train.team = "spectator";
    initialize_stations();
    thread debug_draw_paths();
    thread debug_draw_doors();
    a_e_children = getEntArray(m_vh_train.target, "targetname");
    foreach(e_ent in a_e_children) {
      if(isDefined(e_ent.script_string)) {
        if(e_ent.script_string == "train_volume") {
          if(!isDefined(m_e_volume)) {
            assert(!isDefined(m_e_volume));
            e_ent enablelinkto();
            m_e_volume = e_ent;
          }
        } else if(e_ent.script_string == "train_rear_door" || e_ent.script_string == "train_front_door") {
          if(!isDefined(e_ent.script_origin)) {
            e_ent.script_origin = spawn("script_origin", e_ent.origin);
            e_ent.script_origin.angles = m_vh_train.angles;
            e_ent.script_origin linkto(m_vh_train);
          }
          if(!isDefined(m_a_mdl_doors)) {
            m_a_mdl_doors = [];
          } else if(!isarray(m_a_mdl_doors)) {
            m_a_mdl_doors = array(m_a_mdl_doors);
          }
          m_a_mdl_doors[m_a_mdl_doors.size] = e_ent;
        }
        e_ent linkto(m_vh_train);
        continue;
      }
      iprintlnbold(("" + zm_zod_util::vec_to_string(e_ent.origin)) + "");
    }
    function_6f6ab7a4();
    if(!isDefined(m_e_volume)) {
      assertmsg(("" + zm_zod_util::vec_to_string(m_vh_train.origin)) + "");
    }
    m_vh_train function_a8e2d7ff();
    m_t_switch = getent("m_s_switch_trigger", "targetname");
    m_t_switch triggerignoreteam();
    m_t_switch setteamfortrigger("none");
    m_t_switch sethintstring(&"ZM_ZOD_SWITCH_DISABLE");
    m_t_switch setcursorhint("HINT_NOICON");
    m_t_switch enablelinkto();
    m_t_switch linkto(m_vh_train);
    m_t_switch.player_used = 0;
    thread main();
    a_callboxes = getEntArray("train_call_lever", "targetname");
    foreach(e_callbox in a_callboxes) {
      thread run_callbox(e_callbox.script_string);
    }
    a_gates = getEntArray("train_gate", "targetname");
    foreach(gate in a_gates) {
      station = m_a_s_stations[gate.script_string];
      if(!isDefined(station.gates)) {
        station.gates = [];
      }
      if(!isDefined(station.gates)) {
        station.gates = [];
      } else if(!isarray(station.gates)) {
        station.gates = array(station.gates);
      }
      station.gates[station.gates.size] = gate;
      jump_nodes = getnodearray(station.path_node.target, "targetname");
      self thread run_gate(gate, jump_nodes);
    }
  }

  function initialize_stations() {
    m_a_s_stations = [];
    a_path_nodes = getnodearray("train_pathnode", "targetname");
    foreach(nd in a_path_nodes) {
      str_station = nd.script_string;
      m_a_s_stations[str_station] = spawnStruct();
      m_a_s_stations[str_station].path_node = nd;
      m_a_s_stations[str_station].origin = nd.origin;
      m_a_s_stations[str_station].angles = nd.angles;
      m_a_s_stations[str_station].station_id = str_station;
      m_a_s_stations[str_station].door_side = nd.script_parameters;
    }
    m_a_s_stations["slums"].left_path = "canal";
    m_a_s_stations["slums"].right_path = "theater";
    m_a_s_stations["slums"].b_left_path_active = 0;
    m_a_s_stations["slums"].str_zone_flag = "activate_slums_waterfront";
    m_a_s_stations["slums"].audio_divert = 8;
    m_a_s_stations["slums"].audio_depart = 5;
    m_a_s_stations["slums"].audio_arrive = 1;
    m_a_s_stations["slums"].start_node = getvehiclenode("a1", "targetname");
    m_a_s_stations["theater"].left_path = "slums";
    m_a_s_stations["theater"].right_path = "canal";
    m_a_s_stations["theater"].b_left_path_active = 0;
    m_a_s_stations["theater"].str_zone_flag = "activate_theater_square";
    m_a_s_stations["theater"].audio_divert = 9;
    m_a_s_stations["theater"].audio_depart = 6;
    m_a_s_stations["theater"].audio_arrive = 2;
    m_a_s_stations["theater"].start_node = getvehiclenode("b1", "targetname");
    m_a_s_stations["canal"].left_path = "theater";
    m_a_s_stations["canal"].right_path = "slums";
    m_a_s_stations["canal"].b_left_path_active = 0;
    m_a_s_stations["canal"].str_zone_flag = "activate_brothel_street";
    m_a_s_stations["canal"].audio_divert = 7;
    m_a_s_stations["canal"].audio_depart = 4;
    m_a_s_stations["canal"].audio_arrive = 3;
    m_a_s_stations["canal"].start_node = getvehiclenode("c1", "targetname");
    level.var_98f27ad = array("vox_tanc_board_canal_0", "vox_tanc_board_slums_0", "vox_tanc_board_theater_0", "vox_tanc_depart_canal_0", "vox_tanc_depart_slums_0", "vox_tanc_depart_theater_0", "vox_tanc_divert_canal_0", "vox_tanc_divert_slums_0", "vox_tanc_divert_theater_0");
    a_keys = getarraykeys(m_a_s_stations);
    for(i = 0; i < a_keys.size; i++) {
      str_key = a_keys[i];
      nd_next = m_a_s_stations[str_key].start_node;
      nd_prev = undefined;
      m_a_s_stations[str_key].nodes = [];
      while(isDefined(nd_next)) {
        if(isDefined(nd_prev)) {
          nd_next.target2 = nd_prev.targetname;
        }
        if(!isDefined(m_a_s_stations[str_key].nodes)) {
          m_a_s_stations[str_key].nodes = [];
        } else if(!isarray(m_a_s_stations[str_key].nodes)) {
          m_a_s_stations[str_key].nodes = array(m_a_s_stations[str_key].nodes);
        }
        m_a_s_stations[str_key].nodes[m_a_s_stations[str_key].nodes.size] = nd_next;
        nd_prev = nd_next;
        if(!isDefined(nd_next.target)) {
          break;
        } else {
          nd_next = getvehiclenode(nd_next.target, "targetname");
        }
      }
      num_nodes = m_a_s_stations[str_key].nodes.size;
      m_a_s_stations[str_key].junction_node = m_a_s_stations[str_key].nodes[num_nodes - 1];
      m_a_s_stations[str_key].path_toward_junction = 1;
    }
    a_callboxes = getEntArray("train_call_lever", "targetname");
    foreach(e_callbox in a_callboxes) {
      e_station_closest = arraygetclosest(e_callbox.origin, m_a_s_stations);
      assert(isDefined(e_station_closest));
      e_callbox.script_string = e_station_closest.station_id;
      e_station_closest.callbox = e_callbox;
    }
  }

  function function_dda9a9d2() {
    m_b_facing_forward = !m_b_facing_forward;
  }

  function function_a9acf9e2() {
    var_e19f73fe = [];
    foreach(e_player in level.players) {
      if(is_touching_train(e_player)) {
        if(e_player isinmovemode("", "")) {
          continue;
        }
        if(!zm_utility::is_player_valid(e_player, 1, 0)) {
          continue;
        }
        e_player.train_board_time = gettime();
        if(!isDefined(var_e19f73fe)) {
          var_e19f73fe = [];
        } else if(!isarray(var_e19f73fe)) {
          var_e19f73fe = array(var_e19f73fe);
        }
        var_e19f73fe[var_e19f73fe.size] = e_player;
      }
    }
    m_vh_train waittill("docked_in_station");
    var_1a8b64d3 = m_vh_train getcentroid();
    var_10b9b744 = 0;
    foreach(e_player in var_e19f73fe) {
      if(e_player isinmovemode("", "")) {
        continue;
      }
      if(!zm_utility::is_player_valid(e_player, 1, 0)) {
        continue;
      }
      if(!isDefined(e_player.train_board_time)) {
        continue;
      }
      if(isDefined(e_player.last_bleed_out_time) && e_player.last_bleed_out_time > e_player.train_board_time) {
        continue;
      }
      if(!is_touching_train(e_player)) {
        fatal = 0;
        do {
          spawnpos = var_1a8b64d3;
          switch (var_10b9b744) {
            case 0: {
              spawnpos = spawnpos + vectorscale((1, 1, 0), 36);
              break;
            }
            case 1: {
              spawnpos = spawnpos + (vectorscale((-1, -1, 0), 36));
              break;
            }
            case 2: {
              spawnpos = spawnpos + (vectorscale((1, -1, 0), 36));
              break;
            }
            case 3: {
              spawnpos = spawnpos + (vectorscale((-1, 1, 0), 36));
              break;
            }
            case 4: {
              e_player dodamage(1000, (0, 0, 0));
              fatal = 1;
              jump loc_0000374E;
            }
          }
          var_10b9b744++;
        }
        while(!fatal && !function_eb9ee200(spawnpos));
        e_player setorigin(spawnpos);
      }
    }
  }

  function function_eb9ee200(spawnpos) {
    foreach(e_player in level.players) {
      if(!zm_utility::is_player_valid(e_player, 0, 0)) {
        continue;
      }
      porigin = e_player.origin;
      if((abs(porigin[2] - spawnpos[2])) > 60) {
        continue;
      }
      distance_apart = distance2d(porigin, spawnpos);
      if(abs(distance_apart) > 18) {
        continue;
      }
      return false;
    }
    return true;
  }

  function move() {
    m_b_incoming = 0;
    str_start = m_str_station;
    str_left = m_a_s_stations[str_start].left_path;
    str_right = m_a_s_stations[str_start].right_path;
    if(m_a_s_stations[str_start].path_toward_junction == 0) {
      m_vh_train flip180();
      m_a_s_stations[str_start].path_toward_junction = switch_path_direction(m_a_s_stations[str_start].nodes, m_a_s_stations[str_start].path_toward_junction);
      m_vh_train switchstartnode(m_a_s_stations[str_start].start_node, m_a_s_stations[str_start].junction_node);
    }
    if(m_a_s_stations[str_left].path_toward_junction == 1) {
      m_a_s_stations[str_left].path_toward_junction = switch_path_direction(m_a_s_stations[str_left].nodes, m_a_s_stations[str_left].path_toward_junction);
      m_vh_train switchstartnode(m_a_s_stations[str_left].start_node, m_a_s_stations[str_left].junction_node);
    }
    if(m_a_s_stations[str_right].path_toward_junction == 1) {
      m_a_s_stations[str_right].path_toward_junction = switch_path_direction(m_a_s_stations[str_right].nodes, m_a_s_stations[str_right].path_toward_junction);
      m_vh_train switchstartnode(m_a_s_stations[str_right].start_node, m_a_s_stations[str_right].junction_node);
    }
    sndnum = m_a_s_stations[m_str_destination].audio_depart;
    level clientfield::set("sndTrainVox", sndnum);
    m_vh_train playsoundontag(level.var_98f27ad[sndnum - 1], "tag_support_arm_01");
    thread watch_node_parameters();
    m_vh_train recalcsplinepaths();
    m_vh_train attachpath(m_a_s_stations[str_start].start_node);
    m_vh_train startpath();
    while(distance2dsquared(m_vh_train.origin, m_a_s_stations[str_start].junction_node.origin) > 122500) {
      util::wait_network_frame();
    }
    enable_train_switches(0);
    thread function_a377ba46();
    str_chosen_path = str_left;
    if(!m_a_s_stations[str_start].b_left_path_active) {
      str_chosen_path = str_right;
    }
    which_way = m_a_s_stations[str_chosen_path].junction_node;
    m_vh_train setswitchnode(m_a_s_stations[str_start].junction_node, m_a_s_stations[str_chosen_path].junction_node);
    m_b_incoming = 1;
    var_97fef807 = str_chosen_path;
    level flag::set(m_a_s_stations[str_chosen_path].str_zone_flag);
    m_vh_train waittill("reached_end_node");
    m_b_facing_forward = !m_b_facing_forward;
    m_str_station = str_chosen_path;
    m_str_destination = get_current_destination();
    m_vh_train notify("docked_in_station", m_str_station);
    sndnum = m_a_s_stations[m_str_station].audio_arrive;
    level clientfield::set("sndTrainVox", sndnum);
    m_vh_train playsoundontag(level.var_98f27ad[sndnum - 1], "tag_support_arm_01");
  }

  function function_7eb2583b() {
    timeout = 15;
    while(timeout > 0 && self flag::get("moving")) {
      timeout = timeout - 1;
      wait(1);
    }
  }

  function watch_node_parameters() {
    m_vh_train endon("docked_in_station");
    while(true) {
      m_vh_train waittill("reached_node", nd);
      if(isDefined(nd.script_parameters)) {
        switch (nd.script_parameters) {
          case "arrival_brakes": {
            if(m_b_incoming) {
              m_vh_train playSound("evt_train_stop");
              m_vh_train stoploopsound(3);
            }
            break;
          }
          case "arrival_bell": {
            if(m_b_incoming) {
              e_callbox = m_a_s_stations[m_str_destination].callbox;
              e_callbox playSound("evt_train_station_bell");
            }
            break;
          }
          default: {
            assertmsg("" + nd.script_parameters);
            break;
          }
        }
      }
    }
  }

  function get_current_destination() {
    if(m_a_s_stations[m_str_station].b_left_path_active) {
      return m_a_s_stations[m_str_station].left_path;
    }
    return m_a_s_stations[m_str_station].right_path;
  }

  function get_current_station() {
    return m_str_station;
  }

  function function_a8e2d7ff() {
    var_aed9540e = [];
    var_aed9540e["moving"] = getEntArray("lgt_train_lightrig_veh_placement", "targetname");
    var_aed9540e["canals"] = getEntArray("lgt_train_lightrig_canals_debug", "targetname");
    var_aed9540e["slums"] = getEntArray("lgt_train_lightrig_slums_debug", "targetname");
    var_aed9540e["theater"] = getEntArray("lgt_train_lightrig_theater_debug", "targetname");
    var_105cc375 = vectorscale((0, 1, 0), 45);
    self enablelinkto();
    foreach(var_83e6406e in var_aed9540e) {
      foreach(var_66fccd7 in var_83e6406e) {
        var_66fccd7.origin = origin;
        var_66fccd7.angles = angles + var_105cc375;
        var_66fccd7 linkto(self);
      }
    }
  }

  function get_train_vehicle() {
    return m_vh_train;
  }

  function enable_train_switches(b_enabled) {
    if(b_enabled) {
      self flag::set("switches_enabled");
      m_t_switch sethintstring(&"ZM_ZOD_SWITCH_ENABLE");
      function_ca899bfc();
    } else {
      self flag::clear("switches_enabled");
      m_t_switch sethintstring(&"ZM_ZOD_SWITCH_DISABLE");
      m_vh_train notify("hash_51689c0f");
    }
  }

  function switch_path_direction(all_nodes, direction) {
    for(i = 0; i < all_nodes.size; i++) {
      prev_target = all_nodes[i].target;
      all_nodes[i].target = all_nodes[i].target2;
      all_nodes[i].target2 = prev_target;
    }
    return !direction;
  }

  function debug_draw_doors() {
    do {
      n_debug = getdvarint("train_debug_doors");
      wait(1);
    }
    while(!isDefined(n_debug) || n_debug <= 0);
    while(true) {
      duration = 1;
      var_6ffe9d93 = 240;
      var_4dc5a359 = 12;
      origin = m_vh_train.origin;
      origin = origin + (vectorscale((0, 0, -1), 90));
      forward = anglesToForward(m_vh_train.angles);
      right = anglestoright(m_vh_train.angles);
      if(!m_b_facing_forward) {
        forward = -1 * forward;
      }
      var_bba032ca = origin + (var_6ffe9d93 * forward);
      line(origin, var_bba032ca, (1, 0, 0), 1, 1, duration);
      line(var_bba032ca, (var_bba032ca - (var_4dc5a359 * forward)) - (var_4dc5a359 * right), (1, 0, 0), 1, 1, duration);
      line(var_bba032ca, (var_bba032ca - (var_4dc5a359 * forward)) + (var_4dc5a359 * right), (1, 0, 0), 1, 1, duration);
      foreach(e_door in m_a_mdl_doors) {
        var_d4280494 = e_door.origin;
        open = is_door_open(e_door);
        str_state = "closed";
        if(open) {
          str_state = "open";
        }
        print3d(var_d4280494, str_state, (0, 0, 1), 1, 1, duration);
      }
      wait(0.05);
    }
  }

  function debug_draw_paths() {
    do {
      n_debug = getdvarint("");
      wait(1);
    }
    while(!isDefined(n_debug) || n_debug <= 0);
    while(true) {
      a_keys = getarraykeys(m_a_s_stations);
      for(key_num = 0; key_num < m_a_s_stations.size; key_num++) {
        j = a_keys[key_num];
        node_set = m_a_s_stations[j].nodes;
        for(i = 0; i < node_set.size; i++) {
          node = node_set[i];
          node_pos = node.origin + (vectorscale((0, 0, -1), 95));
          debugstar(node_pos, 1, (1, 0, 0));
          if(isDefined(node.target)) {
            node_target = getvehiclenode(node.target, "");
            node_target_pos = node_target.origin + (vectorscale((0, 0, -1), 70));
            line(node_pos, node_target_pos, (0, 1, 0), 0, 1);
            debugstar(node_target_pos, 1, (0, 1, 0));
          }
          if(isDefined(node.target2)) {
            node_target2 = getvehiclenode(node.target2, "");
            node_target2_pos = node_target2.origin + (vectorscale((0, 0, -1), 120));
            line(node_pos, node_target2_pos, (0, 0, 1), 0, 1);
            debugstar(node_target2_pos, 1, (0, 0, 1));
          }
        }
      }
      a_zombies = getaiteamarray(level.zombie_team);
      foreach(ai in a_zombies) {
        if(isDefined(ai.locked_in_train) && ai.locked_in_train) {
          print3d(ai.origin + vectorscale((0, 0, 1), 100), ("" + m_a_zombies_locked_in.size) + "", vectorscale((0, 1, 0), 255), 1);
        }
      }
      wait(0.05);
    }
  }

}

#namespace zm_train;

function autoexec __init__sytem__() {
  system::register("zm_train", &__init__, undefined, undefined);
}

function onplayerconnect() {
  self.on_train = 0;
}

function __init__() {
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&player_on_spawned);
  zm_zod_util::on_zombie_killed(&remove_dead_zombie);
  zm_zod_util::add_zod_zombie_spawn_func(&zombie_init);
  clientfield::register("vehicle", "train_switch_light", 1, 2, "int");
  clientfield::register("scriptmover", "train_callbox_light", 1, 2, "int");
  clientfield::register("scriptmover", "train_map_light", 1, 2, "int");
  clientfield::register("vehicle", "train_rain_fx_occluder", 1, 1, "int");
  clientfield::register("world", "sndTrainVox", 1, 4, "int");
  level.player_intemission_spawn_callback = &player_intemission_spawn_callback;
  thread initialize_train();
  thread function_eb0db7bc();
  thread train_devgui();
}

function function_eb0db7bc() {
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  while(true) {
    level waittill("host_migration_end");
    [[level.o_zod_train]] - > initialize_stations();
    [[level.o_zod_train]] - > function_7eb2583b();
    [[level.o_zod_train]] - > function_dda9a9d2();
    [[level.o_zod_train]] - > send_train();
  }
}

function player_intemission_spawn_callback(origin, angles) {
  ride_vehicle = undefined;
  self.ground_ent = self getgroundent();
  if(isDefined(self.ground_ent)) {
    if(isvehicle(self.ground_ent) && !level.zombie_team === self.ground_ent) {
      ride_vehicle = self.ground_ent;
    }
  }
  if(isDefined(ride_vehicle)) {
    self spawn(origin, angles);
  }
}

function initialize_train() {
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  e_train = getent("zod_train", "targetname");
  e_train function_7465f87();
  e_train.takedamage = 0;
  e_train clientfield::set("train_rain_fx_occluder", 1);
  level.o_zod_train = new czmtrain();
  [[level.o_zod_train]] - > initialize(e_train);
  level thread autosend_train();
  level.var_33c4ee76 = 0;
}

function function_f37aa349(sn) {
  ents = getEntArray();
  foreach(ent in ents) {
    if(ent.script_noteworthy === sn) {
      return ent;
    }
  }
  return undefined;
}

function function_7465f87() {
  trigs = getEntArray("train_buyable_weapon", "script_noteworthy");
  foreach(trig in trigs) {
    trig enablelinkto();
    trig linkto(self, "", self worldtolocalcoords(trig.origin), (0, 0, 0));
    trig.weapon = getweapon(trig.zombie_weapon_upgrade);
    trig setcursorhint("HINT_WEAPON", trig.weapon);
    trig.cost = zm_weapons::get_weapon_cost(trig.weapon);
    trig.hint_string = zm_weapons::get_weapon_hint(trig.weapon);
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      trig sethintstring(trig.hint_string);
    } else {
      trig.hint_parm1 = trig.cost;
      trig sethintstring(trig.hint_string, trig.hint_parm1);
    }
    self.buyable_weapon = trig;
    level._spawned_wallbuys[level._spawned_wallbuys.size] = trig;
    weapon_model = getent(trig.target, "targetname");
    weapon_model linkto(self, "", self worldtolocalcoords(weapon_model.origin), weapon_model.angles + self.angles);
    weapon_model setmovingplatformenabled(1);
    weapon_model._linked_ent = trig;
    weapon_model show();
    weapon_model thread function_d7993b3d(trig);
  }
}

function player_on_spawned() {
  self thread function_69c89e00();
}

function function_69c89e00() {
  self endon("disconnect");
  self notify("hash_69c89e00");
  self endon("hash_69c89e00");
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  wait(1);
  wallbuy = level.o_zod_train.m_vh_train.buyable_weapon;
  self notify("zm_bgb_secret_shopper", wallbuy);
  self.var_316060b3 = 0;
  while(isDefined(self)) {
    if(isDefined(self.on_train) && self.on_train) {
      if(!self.var_316060b3) {
        self notify("zm_bgb_secret_shopper", wallbuy);
      }
      wallbuy function_2e9b7fc1(self, wallbuy.weapon);
    } else if(self.var_316060b3) {
      self notify("hash_a09e2c64");
    }
    self.var_316060b3 = self.on_train;
    wait(1);
  }
}

function function_2e9b7fc1(player, weapon = self.weapon) {
  player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
  if(!player_has_weapon && (isDefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing)) {
    shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.zombie_weapon_upgrade);
    if(isDefined(shared_ammo_weapon)) {
      weapon = shared_ammo_weapon;
      player_has_weapon = 1;
    }
  }
  if(!player_has_weapon) {
    cursor_hint = "HINT_WEAPON";
    cost = zm_weapons::get_weapon_cost(weapon);
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
        hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER";
        self sethintstringforplayer(player, hint_string);
      } else {
        hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
        self sethintstringforplayer(player, hint_string);
      }
    } else {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
        hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER";
        n_bgb_cost = player zm_weapons::get_ammo_cost_for_weapon(player.currentweapon);
        self sethintstringforplayer(player, hint_string, cost, n_bgb_cost);
      } else {
        hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL";
        self sethintstringforplayer(player, hint_string, cost);
      }
    }
  } else {
    if(player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(weapon)) {
      ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
    } else {
      if(player zm_weapons::has_upgrade(weapon)) {
        ammo_cost = zm_weapons::get_upgraded_ammo_cost(weapon);
      } else {
        ammo_cost = zm_weapons::get_ammo_cost(weapon);
      }
    }
    if(isDefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled) {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
        hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER";
        self sethintstringforplayer(player, hint_string);
      } else {
        hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL";
        self sethintstringforplayer(player, hint_string);
      }
    } else {
      if(player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
        hint_string = &"ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER";
        n_bgb_cost = player zm_weapons::get_ammo_cost_for_weapon(player.currentweapon);
        self sethintstringforplayer(player, hint_string, ammo_cost, n_bgb_cost);
      } else {
        hint_string = &"ZOMBIE_WEAPONAMMOONLY";
        self sethintstringforplayer(player, hint_string, ammo_cost);
      }
    }
  }
  cursor_hint = "HINT_WEAPON";
  cursor_hint_weapon = weapon;
  self setcursorhint(cursor_hint, cursor_hint_weapon);
  return true;
}

function function_d7993b3d(trigger) {
  self.var_5823efe0 = self.model;
  self setModel("wpn_t7_none_world");
  trigger waittill("trigger");
  self setModel(self.var_5823efe0);
}

function zombie_init() {
  self.locked_in_train = 0;
}

function autosend_train() {
  level flag::wait_till("connect_start_to_junction");
  [[level.o_zod_train]] - > send_train();
}

function in_range_2d(v1, v2, range, vert_allowance) {
  if((abs(v1[2] - v2[2])) > vert_allowance) {
    return 0;
  }
  return distance2dsquared(v1, v2) < (range * range);
}

function get_players_on_train(b_valid_targets_only = 0) {
  return [[level.o_zod_train]] - > get_players_on_train(1);
}

function is_moving() {
  if(!isDefined(level.o_zod_train)) {
    return 0;
  }
  return [[level.o_zod_train]] - > is_moving();
}

function zombie_jump_onto_moving_train(ai) {
  [[level.o_zod_train]] - > mark_jumper_time();
  spot = [[level.o_zod_train]] - > get_available_jumptag();
  if(isDefined(spot)) {
    ai.str_train_tag = spot.str_tag;
    [[level.o_zod_train]] - > jump_into_train(ai, spot.str_tag);
  }
}

function remove_dead_zombie(e_attacker, str_means_of_death, weapon) {
  if(isDefined(self)) {
    b_on_train = 0;
    if(is_moving()) {
      if(self.locked_in_train) {
        b_on_train = 1;
      }
    }
    if(b_on_train) {
      self clientfield::set("zombie_gut_explosion", 1);
      self ghost();
    }
  }
  if(isDefined(level.o_zod_train)) {
    if(isDefined(self) && self.locked_in_train) {
      [[level.o_zod_train]] - > remove_zombie_locked_in(self);
    } else {
      [[level.o_zod_train]] - > locked_in_list_remove_undefined();
    }
  }
}

function get_num_zombies_locked_in() {
  a_zombies = [[level.o_zod_train]] - > get_zombies_locked_in();
  return a_zombies.size;
}

function is_full() {
  return get_num_zombies_locked_in() >= 6;
}

function is_ready_for_jumper() {
  return ([[level.o_zod_train]] - > get_time_since_last_jumper()) > 10;
}

function debug_go_to_train() {
  train = getent("", "");
  if(isDefined(train)) {
    train_origin = train getorigin();
    player = level.players[0];
    if(isDefined(player) && isDefined(train_origin)) {
      train_origin = (train_origin[0], train_origin[1], train_origin[2] - 100);
      player setorigin(train_origin);
    }
  }
}

function train_devgui() {
  setDvar("", "");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  while(true) {
    cmd = getdvarstring("");
    if(cmd != "") {
      switch (cmd) {
        case "":
        case "":
        case "": {
          break;
        }
        case "": {
          [[level.o_zod_train]] - > open_doors();
          break;
        }
        case "": {
          [[level.o_zod_train]] - > close_doors();
          break;
        }
        case "": {
          debug_go_to_train();
          break;
        }
        default: {
          break;
        }
      }
      setDvar("", "");
    }
    util::wait_network_frame();
  }
}