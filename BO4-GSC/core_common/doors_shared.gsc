/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\doors_shared.gsc
***********************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace doors;

class cdoor {
  var angles;
  var m_door_open_delay_time;
  var m_e_door;
  var m_e_trigger;
  var m_e_trigger_player;
  var m_n_door_connect_paths;
  var m_n_trigger_height;
  var m_s_bundle;
  var m_str_type;
  var m_v_close_pos;
  var m_v_open_pos;
  var origin;
  var stuck_items;
  var v_trigger_offset;
  var var_19fde5b7;
  var var_3c6838bc;
  var var_7d28591d;
  var var_85f2454d;
  var var_9bc2acd6;
  var var_a2f96f78;
  var var_e1477b7c;
  var var_e1a5a27e;
  var var_fb8a6fcc;

  constructor() {
    m_n_trigger_height = 80;
    m_door_open_delay_time = 0;
    m_e_trigger_player = undefined;
    m_str_type = "door";
    var_fb8a6fcc = [];
    var_e1a5a27e = [];
    var_7d28591d = 0;
  }

  destructor() {
    if(isDefined(m_e_trigger)) {
      m_e_trigger delete();
    }
  }

  function function_670cd4a3() {
    self endon(#"death");
    var_19fde5b7 = [];

    while(true) {
      waitresult = self waittill(#"grenade_stuck");

      if(isDefined(waitresult.projectile)) {
        array::add(var_19fde5b7, waitresult.projectile);
      }
    }
  }

  function function_ea9e96ca(delay_time) {
    m_door_open_delay_time = delay_time;
  }

  function function_d36318ad(b_malfunction = 0, b_open_door = 1, b_reverse = 0, var_682c0d1c = 0, var_a7fd1c5 = 0) {
    if(b_malfunction) {
      if(b_open_door) {
        var_bf73cb70 = isDefined(m_s_bundle.var_ba0e0b07) ? m_s_bundle.var_ba0e0b07 : 0;
        var_ad9c43d9 = isDefined(m_s_bundle.var_3a2b94e8) ? m_s_bundle.var_3a2b94e8 : 0;
      } else {
        var_bf73cb70 = isDefined(m_s_bundle.var_cb1b0a1d) ? m_s_bundle.var_cb1b0a1d : 0;
        var_ad9c43d9 = isDefined(m_s_bundle.var_40c7110b) ? m_s_bundle.var_40c7110b : 0;
      }

      if(var_bf73cb70 == 0 && var_ad9c43d9 == 0) {
        var_3880cb10 = 0;
      } else if(var_ad9c43d9 > var_bf73cb70) {
        var_3880cb10 = randomfloatrange(var_bf73cb70, var_ad9c43d9);
      } else {
        assertmsg("<dev string:x91>");
      }

      if(b_open_door) {
        if(isDefined(var_7d28591d) && var_7d28591d) {
          var_2b9a525f = m_s_bundle.var_f2943dab + var_3880cb10;
        } else {
          var_2b9a525f = m_s_bundle.door_swing_angle + var_3880cb10;
        }
      } else {
        var_2b9a525f = var_3880cb10;
      }
    } else if(b_open_door) {
      if(isDefined(var_7d28591d) && var_7d28591d) {
        var_2b9a525f = m_s_bundle.var_f2943dab;
      } else {
        var_2b9a525f = m_s_bundle.door_swing_angle;
      }
    } else {
      var_2b9a525f = 0;
    }

    if(b_reverse) {
      if(var_682c0d1c) {
        v_angle = (var_85f2454d.angles[0], var_85f2454d.angles[1], var_85f2454d.angles[2] - var_2b9a525f);
      } else if(var_a7fd1c5) {
        v_angle = (var_85f2454d.angles[0] - var_2b9a525f, var_85f2454d.angles[1], var_85f2454d.angles[2]);
      } else {
        v_angle = (var_85f2454d.angles[0], var_85f2454d.angles[1] - var_2b9a525f, var_85f2454d.angles[2]);
      }

      return v_angle;
    }

    if(var_682c0d1c) {
      v_angle = (var_85f2454d.angles[0], var_85f2454d.angles[1], var_85f2454d.angles[2] + var_2b9a525f);
    } else if(var_a7fd1c5) {
      v_angle = (var_85f2454d.angles[0] + var_2b9a525f, var_85f2454d.angles[1], var_85f2454d.angles[2]);
    } else {
      v_angle = (var_85f2454d.angles[0], var_85f2454d.angles[1] + var_2b9a525f, var_85f2454d.angles[2]);
    }

    return v_angle;
  }

  function calculate_offset_position(v_origin, v_angles, v_offset) {
    v_pos = v_origin;

    if(v_offset[0]) {
      v_side = anglesToForward(v_angles);
      v_pos += v_offset[0] * v_side;
    }

    if(v_offset[1]) {
      v_dir = anglestoright(v_angles);
      v_pos += v_offset[1] * v_dir;
    }

    if(v_offset[2]) {
      v_up = anglestoup(v_angles);
      v_pos += v_offset[2] * v_up;
    }

    return v_pos;
  }

  function set_door_paths(n_door_connect_paths) {
    m_n_door_connect_paths = n_door_connect_paths;
  }

  function init_player_spawns() {
    if(isDefined(var_a2f96f78.targetname)) {
      a_structs = struct::get_array(var_a2f96f78.targetname, "target");

      foreach(struct in a_structs) {
        struct.c_door = self;
      }
    }
  }

  function init_movement(str_slide_dir, n_slide_amount) {
    if(m_s_bundle.door_open_method == "slide") {
      v_offset = function_e61944fa(str_slide_dir, n_slide_amount);
      m_v_open_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
      m_v_close_pos = m_e_door.origin;
    }
  }

  function function_e4659543(var_9bbee0ba = 1) {
    if(var_9bbee0ba) {
      m_v_close_pos = m_e_door.origin;
      v_offset = function_e61944fa(undefined, m_s_bundle.door_slide_open_units);
      m_v_open_pos = calculate_offset_position(m_v_close_pos, m_e_door.angles, v_offset);
      var_85f2454d.origin = m_e_door.origin;
      var_85f2454d.angles = m_e_door.angles;
      return;
    }

    m_v_open_pos = m_e_door.origin;
    v_offset = function_e61944fa(undefined, m_s_bundle.door_slide_open_units * -1);
    m_v_close_pos = calculate_offset_position(m_v_open_pos, m_e_door.angles, v_offset);
    var_85f2454d.origin = m_v_close_pos;
    var_85f2454d.angles = m_e_door.angles;
  }

  function function_e61944fa(var_f770af7e, n_slide_amount) {
    str_slide_dir = isDefined(var_3c6838bc) ? var_3c6838bc : var_f770af7e;

    switch (str_slide_dir) {
      case #"x":
        v_offset = (n_slide_amount, 0, 0);
        var_3c6838bc = "X";
        break;
      case #"y":
        v_offset = (0, n_slide_amount, 0);
        var_3c6838bc = "Y";
        break;
      case #"z":
        v_offset = (0, 0, n_slide_amount);
        var_3c6838bc = "Z";
        break;
      default:
        v_offset = (0, 0, n_slide_amount);
        var_3c6838bc = "Z";
        break;
    }

    return v_offset;
  }

  function set_script_flags(b_set) {
    if(isDefined(var_a2f96f78.script_flag)) {
      a_flags = strtok(var_a2f96f78.script_flag, ", ");

      foreach(str_flag in a_flags) {
        if(b_set) {
          level flag::set(str_flag);
          continue;
        }

        level flag::clear(str_flag);
      }
    }
  }

  function init_trigger(v_offset, n_radius) {
    if(isDefined(m_s_bundle.var_99c60bd4)) {
      thread function_cde3a4b3();
    } else if(isDefined(m_s_bundle.door_interact)) {
      thread function_323b4378();
    } else {
      v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
      v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);

      if(isDefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target && isDefined(var_a2f96f78.target)) {
        a_e_targets = getEntArray(var_a2f96f78.target, "targetname");
        e_target = a_e_targets[0];

        if(isDefined(e_target)) {
          if(e_target trigger::is_trigger_of_type("trigger_multiple", "trigger_radius", "trigger_box", "trigger_multiple_new", "trigger_radius_new", "trigger_box_new")) {
            t_radius_or_multiple = e_target;
            v_pos = e_target.origin;
          } else if(e_target trigger::is_trigger_of_type("trigger_use", "trigger_use_touch")) {
            t_use = e_target;
            m_s_bundle.door_use_trigger = 1;
          }
        }
      }

      if(isDefined(m_s_bundle.door_use_trigger) && m_s_bundle.door_use_trigger) {
        if(isDefined(t_use)) {
          m_e_trigger = t_use;
        } else {
          m_e_trigger = spawn("trigger_radius_use", v_pos, 16384 | 4096, n_radius, m_n_trigger_height);
        }

        m_e_trigger triggerignoreteam();
        m_e_trigger setvisibletoall();
        m_e_trigger setteamfortrigger(#"none");
        m_e_trigger usetriggerrequirelookat();
        m_e_trigger setcursorhint("HINT_NOICON");
      } else if(isDefined(t_radius_or_multiple)) {
        m_e_trigger = t_radius_or_multiple;
      } else {
        m_e_trigger = spawn("trigger_radius", v_pos, 16384 | 4096 | 16 | 512, n_radius, m_n_trigger_height);
      }
    }

    if(isDefined(m_s_bundle.var_e182494f) && m_s_bundle.var_e182494f) {
      m_e_door setCanDamage(1);
      thread function_54605e70();
    }
  }

  function function_cde3a4b3() {
    m_e_door makeusable();
    m_e_door setcursorhint("HINT_NOICON");
    m_e_door sethintstring(#"hash_1cc0220a2ef3e6d6");
    thread function_2190a0ee(1, 0);
  }

  function function_323b4378() {
    level flagsys::wait_till("radiant_gameobjects_initialized");
    m_e_door.func_custom_gameobject_position = &function_4fe7d9d5;
    m_e_door.v_trigger_offset = m_s_bundle.v_trigger_offset;
    m_e_door gameobjects::init_game_objects(m_s_bundle.door_interact);
    m_e_door.mdl_gameobject.t_interact usetriggerrequirelookat();
    thread function_2190a0ee(isDefined(m_s_bundle.door_closes) && m_s_bundle.door_closes, 1);
  }

  function function_54605e70() {
    m_e_trigger endon(#"death");

    while(true) {
      m_e_door waittill(#"damage");

      if(!is_open() && !self flag::get("animating")) {
        open();
        flag::wait_till_clear("animating");

        if(isDefined(m_s_bundle.var_6270dafc) && m_s_bundle.var_6270dafc) {
          wait isDefined(m_s_bundle.var_be86269a) ? m_s_bundle.var_be86269a : 0;

          if(isDefined(m_e_trigger_player)) {
            var_ceedbc10 = m_e_trigger.maxs[0] * m_e_trigger.maxs[0];

            while(isDefined(m_e_trigger_player) && m_e_trigger_player istouching(m_e_trigger)) {
              waitframe(1);
            }

            close();
          } else {
            close();
          }
        }
      }

      waitframe(1);
    }
  }

  function function_2190a0ee(b_reusable, var_23456fbb) {
    m_e_door endon(#"hash_190d72393c0a8869", #"delete", #"gameobject_deleted");

    while(true) {
      if(var_23456fbb) {
        waitresult = m_e_door.mdl_gameobject waittill(#"gameobject_end_use_player");
        e_player = waitresult.player;
      } else {
        waitresult = m_e_door waittill(#"trigger");
        e_player = waitresult.activator;
      }

      if(!self flag::get("animating")) {
        if(!b_reusable) {
          m_e_door notify(#"hash_190d72393c0a8869");
        }

        unlock();
        set_player_who_opened(e_player);
        e_player playrumbleonentity("damage_light");

        if(is_open()) {
          if(isDefined(m_s_bundle.var_b8824800)) {
            var_f40ac45d = float(isDefined(m_s_bundle.var_66bbc6d6) ? m_s_bundle.var_66bbc6d6 : 0);
            var_3488a701 = float(isDefined(m_s_bundle.var_f5bea36f) ? m_s_bundle.var_f5bea36f : 0);
            thread function_145675ba(e_player, m_s_bundle.var_b8824800, var_f40ac45d, var_3488a701);
          }

          m_e_door notify(#"hash_923096b653062ea");
          close();
        } else {
          if(isDefined(m_s_bundle.var_a22b716)) {
            var_f40ac45d = float(isDefined(m_s_bundle.var_bbbdcca7) ? m_s_bundle.var_bbbdcca7 : 0);
            var_3488a701 = float(isDefined(m_s_bundle.var_52b6e5e9) ? m_s_bundle.var_52b6e5e9 : 0);
            thread function_145675ba(e_player, m_s_bundle.var_a22b716, var_f40ac45d, var_3488a701);
          }

          m_e_door notify(#"hash_7166c13e79b73f9");
          open();
        }
      }

      waitframe(1);
    }
  }

  function function_145675ba(e_player, str_anim, var_f40ac45d, n_start_time) {
    e_player thread animation::play(str_anim, e_player, undefined, var_f40ac45d, 0.2, 0, 0, n_start_time);
  }

  function function_4fe7d9d5() {
    v_angles = angles;
    v_offset = v_trigger_offset;
    v_pos = origin;

    if(isDefined(v_offset)) {
      if(v_offset[0]) {
        v_side = anglesToForward(v_angles);
        v_pos += v_offset[0] * v_side;
      }

      if(v_offset[1]) {
        v_dir = anglestoright(v_angles);
        v_pos += v_offset[1] * v_dir;
      }

      if(v_offset[2]) {
        v_up = anglestoup(v_angles);
        v_pos += v_offset[2] * v_up;
      }
    }

    return v_pos;
  }

  function run_lock_fx() {
    if(!isDefined(m_s_bundle.door_locked_fx) && !isDefined(m_s_bundle.door_unlocked_fx)) {
      return;
    }

    e_fx = undefined;
    v_pos = get_hack_pos();
    v_angles = get_hack_angles();

    while(true) {
      self flag::wait_till("locked");

      if(isDefined(e_fx)) {
        e_fx delete();
        e_fx = undefined;
      }

      if(isDefined(m_s_bundle.door_locked_fx)) {
        e_fx = spawn("script_model", v_pos);
        e_fx setModel(#"tag_origin");
        e_fx.angles = v_angles;
        playFXOnTag(m_s_bundle.door_locked_fx, e_fx, "tag_origin");
      }

      self flag::wait_till_clear("locked");

      if(isDefined(e_fx)) {
        e_fx delete();
        e_fx = undefined;
      }

      if(isDefined(m_s_bundle.door_unlocked_fx)) {
        e_fx = spawn("script_model", v_pos);
        e_fx setModel(#"tag_origin");
        e_fx.angles = v_angles;
        playFXOnTag(m_s_bundle.door_unlocked_fx, e_fx, "tag_origin");
      }
    }
  }

  function update_use_message() {
    if(!(isDefined(m_s_bundle.door_use_trigger) && m_s_bundle.door_use_trigger)) {
      return;
    }

    if(self flag::get("open")) {
      if(!(isDefined(m_s_bundle.door_closes) && m_s_bundle.door_closes)) {}

      return;
    }

    if(isDefined(m_s_bundle.door_open_message) && m_s_bundle.door_open_message != "") {
      return;
    }

    if(isDefined(m_s_bundle.door_use_hold) && m_s_bundle.door_use_hold) {
      return;
    }

    if(self flag::get("locked")) {}
  }

  function open_internal(b_malfunction = 0, var_8e2567b1) {
    var_1b13d203 = isDefined(var_8e2567b1) ? var_8e2567b1 : m_s_bundle.door_open_time;
    self flag::set("animating");

    if(isDefined(var_a2f96f78.groupname)) {
      a_door_structs = struct::get_array(var_a2f96f78.groupname, "groupname");

      foreach(s_door_struct in a_door_structs) {
        b_animating = s_door_struct.c_door flag::get("animating");

        if(s_door_struct.c_door.m_e_door != m_e_door) {
          if(![
              [s_door_struct.c_door]
            ] - > is_open() && !b_animating) {
            s_door_struct.c_door.m_e_trigger_player = m_e_trigger_player;
            [
              [s_door_struct.c_door]
            ] - > open();
          }
        }
      }
    }

    m_e_door notify(#"door_opening");
    m_e_door function_e0954c11();
    self flag::clear("door_fully_closed");

    if(isDefined(m_s_bundle.door_start_sound) && m_s_bundle.door_start_sound != "") {
      m_e_door playSound(m_s_bundle.door_start_sound);
    }

    if(isDefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
      sndent = spawn("script_origin", m_e_door.origin);
      sndent linkto(m_e_door);
      sndent playLoopSound(m_s_bundle.door_loop_sound, 1);
    }

    if(m_s_bundle.door_open_method == "slide") {
      if(!b_malfunction) {
        function_e4659543(1);
      }

      var_7256682e = function_f1a2a15f(b_malfunction, 1);
      m_e_door moveto(var_7256682e, var_1b13d203);
      m_e_door waittill(#"movedone");
    } else if(m_s_bundle.door_open_method == "swing_away_from_player") {
      if(!isDefined(m_e_trigger_player)) {
        if(isDefined(var_a2f96f78.groupname)) {
          a_door_structs = struct::get_array(var_a2f96f78.groupname, "groupname");

          foreach(s_door_struct in a_door_structs) {
            if(s_door_struct.c_door.m_e_door != m_e_door) {
              if(isDefined(s_door_struct.c_door.m_e_trigger_player)) {
                m_e_trigger_player = s_door_struct.c_door.m_e_trigger_player;
                break;
              }
            }
          }
        }
      }

      v_player_forward = anglesToForward(m_e_trigger_player.angles);
      upvec = anglestoup(m_e_trigger_player.angles);
      var_7a69da4c = anglesToForward(m_e_door.angles);
      var_5461b69e = var_7a69da4c;

      if(isDefined(m_s_bundle.var_25fe36af) && m_s_bundle.var_25fe36af) {
        var_5461b69e = vectorcross(var_7a69da4c, upvec);
      }

      var_cd167873 = vectordot(var_5461b69e, v_player_forward);

      if(var_cd167873 > 0) {
        v_angle = function_d36318ad(b_malfunction, 1, 0, m_s_bundle.var_16a4e229, m_s_bundle.var_16e3e29b);
        m_e_door rotateto(v_angle, var_1b13d203);
        m_e_door waittill(#"rotatedone");
      } else {
        v_angle = function_d36318ad(b_malfunction, 1, 1, m_s_bundle.var_16a4e229, m_s_bundle.var_16e3e29b);
        m_e_door rotateto(v_angle, var_1b13d203);
        m_e_door waittill(#"rotatedone");
      }
    } else if(m_s_bundle.door_open_method == "swing") {
      v_angle = function_d36318ad(b_malfunction, 1, 0, m_s_bundle.var_16a4e229, m_s_bundle.var_16e3e29b);
      m_e_door rotateto(v_angle, var_1b13d203);
      m_e_door waittill(#"rotatedone");
    } else if(m_s_bundle.door_open_method == "animated" && isDefined(m_s_bundle.door_animated_open_bundle)) {
      if(scene::get_player_count(m_s_bundle.door_animated_open_bundle) > 0) {
        m_e_door scene::play(m_s_bundle.door_animated_open_bundle, array(m_e_door, m_e_trigger_player));
      } else {
        m_e_door scene::play(m_s_bundle.door_animated_open_bundle, m_e_door);
      }
    }

    if(isDefined(m_n_door_connect_paths) && m_n_door_connect_paths && m_s_bundle.door_open_method !== "swing") {
      if(isDefined(m_s_bundle.var_a6324e06) && m_s_bundle.var_a6324e06) {
        m_e_door function_df3a1348();
      } else {
        m_e_door fly_step_crouch_walk_bot_plr_brick();
      }
    }

    m_e_door notify(#"door_opened");

    if(isDefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
      sndent delete();
    }

    flag::clear("animating");
    set_script_flags(1);
    function_7d2c33c4(1);
    update_use_message();
  }

  function function_e0954c11() {
    if(!isDefined(stuck_items)) {
      return;
    }

    foreach(var_221be278 in stuck_items) {
      if(!isDefined(var_221be278)) {
        continue;
      }

      var_221be278 dodamage(500, origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  function function_f1a2a15f(b_malfunction = 0, b_open_door = 1) {
    if(b_malfunction) {
      if(b_open_door) {
        var_27c5527f = isDefined(m_s_bundle.var_52a07bbb) ? m_s_bundle.var_52a07bbb : 0;
        var_ef3feac9 = isDefined(m_s_bundle.var_7ffecd77) ? m_s_bundle.var_7ffecd77 : 0;
      } else {
        var_27c5527f = isDefined(m_s_bundle.var_afd6d156) ? m_s_bundle.var_afd6d156 : 0;
        var_ef3feac9 = isDefined(m_s_bundle.var_acfdd537) ? m_s_bundle.var_acfdd537 : 0;
      }

      if(var_27c5527f == 0 && var_ef3feac9 == 0) {
        var_42cf6fbd = 0;
      } else if(var_ef3feac9 > var_27c5527f) {
        var_42cf6fbd = randomfloatrange(var_27c5527f, var_ef3feac9);
      } else {
        assertmsg("<dev string:x38>");
      }

      switch (var_3c6838bc) {
        case #"x":
          v_offset = (var_42cf6fbd, 0, 0);
          break;
        case #"y":
          v_offset = (0, var_42cf6fbd, 0);
          break;
        case #"z":
          v_offset = (0, 0, var_42cf6fbd);
          break;
        default:
          v_offset = (0, 0, 0);
          break;
      }

      if(b_open_door) {
        var_58636008 = calculate_offset_position(m_v_open_pos, var_85f2454d.angles, v_offset);
      } else {
        var_58636008 = calculate_offset_position(m_v_close_pos, var_85f2454d.angles, v_offset);
      }
    } else if(b_open_door) {
      var_58636008 = m_v_open_pos;
    } else {
      var_58636008 = m_v_close_pos;
    }

    return var_58636008;
  }

  function function_f50c09b3(b_enable) {
    self notify(#"hash_50b9293fc24e2756");
    self endon(#"hash_50b9293fc24e2756");
    m_e_door endon(#"death");

    if(b_enable) {
      self notify(#"end_door_update");
    }

    n_delay_min = isDefined(m_s_bundle.var_b7a623f5) ? m_s_bundle.var_b7a623f5 : 0.1;
    n_delay_max = isDefined(m_s_bundle.var_5cac6503) ? m_s_bundle.var_5cac6503 : 1;

    if(m_s_bundle.door_open_method === "slide" || m_s_bundle.door_open_method === "swing") {
      if(b_enable) {
        while(true) {
          open_internal(b_enable, randomfloatrange(n_delay_min, n_delay_max));
          wait randomfloatrange(n_delay_min, n_delay_max);
          close_internal(b_enable, randomfloatrange(n_delay_min, n_delay_max));
        }
      } else {
        close_internal(b_enable);
        level thread doors::door_update(self);
      }

      return;
    }

    if(m_s_bundle.door_open_method == "animated" && isDefined(m_s_bundle.var_6a0dae54)) {
      if(b_enable) {
        var_85f2454d thread scene::play(m_s_bundle.var_6a0dae54, m_e_door);
        return;
      }

      var_85f2454d thread scene::stop(m_s_bundle.var_6a0dae54);
    }
  }

  function close() {
    self flag::clear("open");
  }

  function function_cbbcc8ab() {
    self flag::wait_till("door_fully_closed");

    while(isDefined(m_e_trigger_player) && distance2d(m_e_trigger_player.origin, m_e_door.origin) < 16) {
      waitframe(1);
    }
  }

  function close_internal(b_malfunction = 0, var_8e2567b1) {
    if(self flag::get("door_fully_closed")) {
      return;
    } else {
      self flag::clear("open");
    }

    if(isDefined(var_a2f96f78.groupname)) {
      a_door_structs = struct::get_array(var_a2f96f78.groupname, "groupname");

      foreach(s_door_struct in a_door_structs) {
        b_animating = s_door_struct.c_door flag::get("animating");

        if(s_door_struct.c_door.m_e_door != m_e_door) {
          if([
              [s_door_struct.c_door]
            ] - > is_open() && !b_animating) {
            [
              [s_door_struct.c_door]
            ] - > close();
          }
        }
      }
    }

    var_1b13d203 = isDefined(var_8e2567b1) ? var_8e2567b1 : m_s_bundle.door_open_time;
    set_script_flags(0);
    self flag::set("animating");
    m_e_door notify(#"door_closing");
    self thread function_cbbcc8ab();

    if(isDefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
      m_e_door playSound(m_s_bundle.door_start_sound);
      sndent = spawn("script_origin", m_e_door.origin);
      sndent linkto(m_e_door);
      sndent playLoopSound(m_s_bundle.door_loop_sound, 1);
    } else if(isDefined(m_s_bundle.door_stop_sound) && m_s_bundle.door_stop_sound != "") {
      m_e_door playSound(m_s_bundle.door_stop_sound);
    }

    if(m_s_bundle.door_open_method == "slide") {
      if(!b_malfunction) {
        function_e4659543(0);
      }

      var_ce02fcb7 = function_f1a2a15f(b_malfunction, 0);
      m_e_door moveto(var_ce02fcb7, var_1b13d203);
      m_e_door waittill(#"movedone");
    } else if(m_s_bundle.door_open_method == "swing_away_from_player") {
      v_angle = function_d36318ad(b_malfunction, 0, 0, m_s_bundle.var_16a4e229, m_s_bundle.var_16e3e29b);
      m_e_door rotateto(v_angle, var_1b13d203);
      m_e_door waittill(#"rotatedone");
    } else if(m_s_bundle.door_open_method == "swing") {
      v_angle = function_d36318ad(b_malfunction, 0, 0, m_s_bundle.var_16a4e229, m_s_bundle.var_16e3e29b);
      m_e_door rotateto(v_angle, var_1b13d203);
      m_e_door waittill(#"rotatedone");
    } else if(m_s_bundle.door_open_method == "animated" && isDefined(m_s_bundle.door_animated_close_bundle)) {
      if(scene::get_player_count(m_s_bundle.door_animated_close_bundle) > 0) {
        m_e_door notify(#"hash_3803c0c576f1982b", {
          #player: m_e_trigger_player
        });
        m_e_door scene::play(m_s_bundle.door_animated_close_bundle, array(m_e_door, m_e_trigger_player));
      } else {
        m_e_door scene::play(m_s_bundle.door_animated_close_bundle, m_e_door);
      }
    }

    m_e_door notify(#"door_closed");
    self flag::set("door_fully_closed");

    if(isDefined(m_n_door_connect_paths) && m_n_door_connect_paths) {
      if(isDefined(m_s_bundle.var_a6324e06) && m_s_bundle.var_a6324e06) {
        m_e_door fly_step_crouch_walk_bot_plr_brick();
      } else {
        m_e_door function_df3a1348();
      }
    }

    if(isDefined(m_s_bundle.b_loop_sound) && m_s_bundle.b_loop_sound) {
      sndent delete();
      m_e_door playSound(m_s_bundle.door_stop_sound);
    }

    flag::clear("animating");
    function_7d2c33c4(0);
    update_use_message();
  }

  function function_7d2c33c4(b_opened = 1) {
    if(b_opened) {
      foreach(node in var_fb8a6fcc) {
        setenablenode(node, 1);
      }

      foreach(node in var_e1a5a27e) {
        setenablenode(node, 0);
      }

      return;
    }

    foreach(node in var_fb8a6fcc) {
      setenablenode(node, 0);
    }

    foreach(node in var_e1a5a27e) {
      setenablenode(node, 1);
    }
  }

  function remove_door_trigger() {
    if(isDefined(m_e_trigger)) {
      m_e_trigger delete();
    }
  }

  function is_open() {
    return self flag::get("open");
  }

  function set_player_who_opened(e_player) {
    m_e_trigger_player = e_player;
  }

  function open() {
    if(m_str_type === "breach" && !(isDefined(var_9bc2acd6) && var_9bc2acd6)) {
      self notify(#"hash_722c5466076f75cf");
      var_9bc2acd6 = 1;
      return;
    }

    self flag::set("open");
  }

  function delete_door() {
    m_e_door delete();
    m_e_door = undefined;

    if(isDefined(m_e_trigger)) {
      m_e_trigger delete();
      m_e_trigger = undefined;
    }
  }

  function unlock() {
    self flag::clear("locked");
  }

  function lock() {
    self flag::set("locked");
    update_use_message();
  }

  function init_hint_trigger() {
    if(isDefined(m_s_bundle.door_interact)) {
      return;
    }

    if(m_s_bundle.door_unlock_method === "default" && !(isDefined(m_s_bundle.door_trigger_at_target) && m_s_bundle.door_trigger_at_target)) {
      return;
    }

    v_offset = m_s_bundle.v_trigger_offset;
    n_radius = m_s_bundle.door_trigger_radius;
    v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_offset);
    v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
  }

  function get_hack_angles() {
    v_angles = m_e_door.angles;

    if(isDefined(var_a2f96f78.target)) {
      e_target = getent(var_a2f96f78.target, "targetname");

      if(isDefined(e_target)) {
        return e_target.angles;
      }
    }

    return v_angles;
  }

  function get_hack_pos() {
    v_trigger_offset = m_s_bundle.v_trigger_offset;
    v_pos = calculate_offset_position(m_e_door.origin, m_e_door.angles, v_trigger_offset);
    v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);

    if(isDefined(var_a2f96f78.target)) {
      e_target = getent(var_a2f96f78.target, "targetname");

      if(isDefined(e_target)) {
        return e_target.origin;
      }
    }

    return v_pos;
  }

  function init_door_model(e_or_str_model, connect_paths, s_door_instance) {
    if(isentity(e_or_str_model)) {
      m_e_door = e_or_str_model;
    } else if(!isDefined(e_or_str_model) && !isDefined(s_door_instance.model)) {
      e_or_str_model = "tag_origin";
    }

    if(!isDefined(m_e_door)) {
      m_e_door = util::spawn_model(e_or_str_model, s_door_instance.origin, s_door_instance.angles);
    }

    m_e_door function_881077b4(33, 1);

    if(connect_paths) {
      m_e_door function_df3a1348();
    }

    m_e_door.script_objective = s_door_instance.script_objective;
    var_85f2454d = {
      #origin: m_e_door.origin, 
      #angles: m_e_door.angles
    };
    m_e_door thread doors::function_fa74d5cd(self);

    if(isDefined(s_door_instance.linkname)) {
      var_e1477b7c = getEntArray(s_door_instance.linkname, "linkto");

      if(isDefined(s_door_instance.script_tag)) {
        array::run_all(var_e1477b7c, &linkto, m_e_door, s_door_instance.script_tag);
      } else {
        array::run_all(var_e1477b7c, &linkto, m_e_door);
      }
    }

    m_e_door.var_4f564337 = 1;
    m_e_door thread function_670cd4a3();
  }

  function function_61c13b93() {
    return m_v_close_pos;
  }

}

autoexec __init__system__() {
  system::register(#"doors", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  level flagsys::wait_till("radiant_gameobjects_initialized");
  var_1cde154f = getgametypesetting(#"use_doors");
  var_5a23774b = getdvarint(#"disabledoors", 0);

  if(!(isDefined(var_1cde154f) && var_1cde154f) || isDefined(var_5a23774b) && var_5a23774b) {
    return;
  }

  a_doors = struct::get_array("scriptbundle_doors", "classname");
  a_doors = arraycombine(a_doors, getEntArray("smart_object_door", "script_noteworthy"), 0, 0);

  foreach(s_instance in a_doors) {
    c_door = s_instance init();

    if(isDefined(c_door)) {
      s_instance.c_door = c_door;
    }
  }

  level thread init_door_panels();
}

init_door_panels() {
  a_door_panels = struct::get_array("smart_object_door_panel", "script_noteworthy");
  a_door_panels = arraycombine(a_door_panels, getEntArray("smart_object_door_panel", "script_noteworthy"), 0, 0);
  a_door_panels = arraycombine(a_door_panels, struct::get_array("scriptbundle_gameobject", "classname"), 0, 0);

  foreach(door_panel in a_door_panels) {
    if(isDefined(door_panel.script_gameobject) || isDefined(door_panel.mdl_gameobject)) {
      if(!isDefined(door_panel.mdl_gameobject)) {
        door_panel gameobjects::init_game_objects(door_panel.script_gameobject);
      }

      door_panel setup_doors_with_panel();
    }
  }
}

setup_doors_with_panel() {
  var_c1157335 = 0;

  if(isDefined(self.target)) {
    a_e_doors = getEntArray(self.target, "targetname");
    a_e_doors = arraycombine(a_e_doors, struct::get_array(self.target, "targetname"), 0, 0);

    foreach(e_door in a_e_doors) {
      if(isDefined(e_door) && isDefined(e_door.c_door)) {
        door = e_door.c_door;
        [
          [door]
        ] - > remove_door_trigger();

        if(!var_c1157335) {
          if(isDefined(door.m_s_bundle.door_closes) && door.m_s_bundle.door_closes) {
            var_ce2455a3 = 1;
          } else {
            var_ce2455a3 = 0;
          }

          var_c1157335 = 1;
          self thread door_panel_interact(var_ce2455a3);
        }
      }
    }
  }
}

door_panel_interact(b_is_panel_reusable) {
  self endon(#"death");
  self.mdl_gameobject endon(#"death");

  while(true) {
    waitresult = self.mdl_gameobject waittill(#"gameobject_end_use_player");
    e_player = waitresult.player;
    self.mdl_gameobject gameobjects::disable_object(1);

    if(isDefined(self.target)) {
      a_e_doors = getEntArray(self.target, "targetname");
      a_e_doors = arraycombine(a_e_doors, struct::get_array(self.target, "targetname"), 0, 0);

      foreach(e_door in a_e_doors) {
        if(isDefined(e_door) && isDefined(e_door.c_door)) {
          door = e_door.c_door;
          [
            [door]
          ] - > unlock();
          [
            [door]
          ] - > set_player_who_opened(e_player);

          if([
              [door]
            ] - > is_open()) {
            [
              [door]
            ] - > close();

            if(!(isDefined(door.m_s_bundle.door_closes) && door.m_s_bundle.door_closes) && isDefined(door.m_s_bundle.var_d37e8f3e) && door.m_s_bundle.var_d37e8f3e) {
              door notify(#"set_destructible", {
                #player: e_player
              });
            }

            continue;
          }

          [
            [door]
          ] - > open();
        }
      }

      waitframe(1);

      if(isDefined(b_is_panel_reusable) && b_is_panel_reusable) {
        while(true) {
          b_door_animating = 0;

          foreach(e_door in a_e_doors) {
            if(isDefined(e_door) && isDefined(e_door.c_door)) {
              door = e_door.c_door;

              if(door flag::get("animating")) {
                b_door_animating = 1;
                break;
              }
            }
          }

          if(!b_door_animating) {
            break;
          }

          waitframe(1);
        }

        self.mdl_gameobject gameobjects::enable_object(1);
        continue;
      }

      return;
    }
  }
}

init() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  s_door_bundle = struct::get_script_bundle("doors", isDefined(self.var_e87a94f3) ? self.var_e87a94f3 : self.scriptbundlename);
  c_door = new cdoor();
  return setup_door_info(s_door_bundle, self, c_door);
}

setup_door_info(s_door_bundle, s_door_instance, c_door) {
  c_door flag::init("locked");
  c_door flag::init("open");
  c_door flag::init("animating");
  c_door flag::init("door_fully_closed");

  if(!isDefined(s_door_bundle)) {
    s_door_bundle = spawnStruct();
    s_door_bundle.door_open_method = s_door_instance.door_open_method;
    s_door_bundle.var_25fe36af = s_door_instance.var_25fe36af;
    s_door_bundle.door_slide_horizontal = s_door_instance.door_slide_horizontal;
    s_door_bundle.door_slide_horizontal_y = s_door_instance.door_slide_horizontal_y;
    s_door_bundle.door_open_time = s_door_instance.door_open_time;
    s_door_bundle.door_slide_open_units = s_door_instance.door_slide_open_units;
    s_door_bundle.door_swing_angle = s_door_instance.door_swing_angle;
    s_door_bundle.var_f2943dab = s_door_instance.var_f2943dab;
    s_door_bundle.door_closes = s_door_instance.door_closes;
    s_door_bundle.var_d37e8f3e = s_door_instance.var_d37e8f3e;
    s_door_bundle.door_start_open = s_door_instance.door_start_open;
    s_door_bundle.door_triggeroffsetx = s_door_instance.door_triggeroffset[0];
    s_door_bundle.door_triggeroffsety = s_door_instance.door_triggeroffset[1];
    s_door_bundle.door_triggeroffsetz = s_door_instance.door_triggeroffset[2];
    s_door_bundle.door_trigger_radius = s_door_instance.door_trigger_radius;
    s_door_bundle.door_start_sound = s_door_instance.door_start_sound;
    s_door_bundle.door_loop_sound = s_door_instance.door_loop_sound;
    s_door_bundle.door_stop_sound = s_door_instance.door_stop_sound;
    s_door_bundle.door_animated_open_bundle = s_door_instance.door_animated_open_bundle;
    s_door_bundle.door_animated_close_bundle = s_door_instance.door_animated_close_bundle;
    s_door_bundle.var_b24cba18 = s_door_instance.var_b24cba18;
    s_door_bundle.model = s_door_instance;
    s_door_instance.door_open_method = undefined;
    s_door_instance.var_25fe36af = undefined;
    s_door_instance.door_slide_horizontal = undefined;
    s_door_instance.door_slide_horizontal_y = undefined;
    s_door_instance.door_open_time = undefined;
    s_door_instance.door_slide_open_units = undefined;
    s_door_instance.door_swing_angle = undefined;
    s_door_instance.var_f2943dab = undefined;
    s_door_instance.door_closes = undefined;
    s_door_instance.var_d37e8f3e = undefined;
    s_door_instance.door_start_open = undefined;
    s_door_instance.door_triggeroffsetx = undefined;
    s_door_instance.door_triggeroffsety = undefined;
    s_door_instance.door_triggeroffsetz = undefined;
    s_door_instance.door_trigger_radius = undefined;
    s_door_instance.door_start_sound = undefined;
    s_door_instance.door_loop_sound = undefined;
    s_door_instance.door_stop_sound = undefined;
    s_door_instance.door_animated_open_bundle = undefined;
    s_door_instance.door_animated_close_bundle = undefined;
    s_door_instance.var_b24cba18 = undefined;
    s_door_instance.var_ee1b0615 = undefined;
    s_door_instance.var_3b86b7db = undefined;
    s_door_instance.var_16a4e229 = undefined;
    s_door_instance.var_16e3e29b = undefined;
  }

  c_door.m_s_bundle = s_door_bundle;
  c_door.var_a2f96f78 = s_door_instance;

  if(isDefined(s_door_instance.target)) {
    a_target_ents = getEntArray(s_door_instance.target, "targetname");

    foreach(ent in a_target_ents) {
      if(ent.objectid === "clip_player_doorway") {
        if(isDefined(ent.script_door_enable_player_clip) && ent.script_door_enable_player_clip) {
          ent.targetname = undefined;
          c_door.m_e_player_clip = ent;
        } else {
          ent delete();
        }

        continue;
      }

      if(ent trigger::is_trigger_of_type()) {
        c_door.m_s_bundle.door_trigger_at_target = 1;
      }
    }
  }

  if(c_door.m_s_bundle.door_unlock_method === "hack" && !(isDefined(level.door_hack_precached) && level.door_hack_precached)) {
    level.door_hack_precached = 1;
  }

  e_or_str_door_model = c_door.m_s_bundle.model;

  if(isDefined(c_door.m_s_bundle.door_triggeroffsetx)) {
    n_xoffset = c_door.m_s_bundle.door_triggeroffsetx;
  } else {
    n_xoffset = 0;
  }

  if(isDefined(c_door.m_s_bundle.door_triggeroffsety)) {
    n_yoffset = c_door.m_s_bundle.door_triggeroffsety;
  } else {
    n_yoffset = 0;
  }

  if(isDefined(c_door.m_s_bundle.door_triggeroffsetz)) {
    n_zoffset = c_door.m_s_bundle.door_triggeroffsetz;
  } else {
    n_zoffset = 0;
  }

  v_trigger_offset = (n_xoffset, n_yoffset, n_zoffset);
  c_door.m_s_bundle.v_trigger_offset = v_trigger_offset;
  n_trigger_radius = c_door.m_s_bundle.door_trigger_radius;

  if(isDefined(c_door.m_s_bundle.door_slide_horizontal) && c_door.m_s_bundle.door_slide_horizontal) {
    if(isDefined(c_door.m_s_bundle.door_slide_horizontal_y) && c_door.m_s_bundle.door_slide_horizontal_y) {
      str_slide_dir = "Y";
    } else {
      str_slide_dir = "X";
    }
  } else {
    str_slide_dir = "Z";
  }

  n_open_time = c_door.m_s_bundle.door_open_time;
  n_slide_amount = c_door.m_s_bundle.door_slide_open_units;

  if(!isDefined(c_door.m_s_bundle.door_swing_angle)) {
    c_door.m_s_bundle.door_swing_angle = 0;
  }

  if(!isDefined(c_door.m_s_bundle.var_f2943dab)) {
    c_door.m_s_bundle.var_f2943dab = 0;
  }

  if(isDefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes) {
    n_door_closes = 1;
  } else {
    n_door_closes = 0;
  }

  if(isDefined(c_door.m_s_bundle.door_connect_paths) && c_door.m_s_bundle.door_connect_paths) {
    n_door_connect_paths = 1;
  } else {
    n_door_connect_paths = 0;
  }

  if(isDefined(s_door_instance.script_obstruction_cover_open)) {
    c_door.var_fb8a6fcc = getnodearray(s_door_instance.script_obstruction_cover_open, "script_obstruction_cover_open");
  }

  if(isDefined(s_door_instance.script_obstruction_cover_close)) {
    c_door.var_e1a5a27e = getnodearray(s_door_instance.script_obstruction_cover_close, "script_obstruction_cover_close");
  }

  [[c_door]] - > function_7d2c33c4(0);

  if(isDefined(c_door.m_s_bundle.door_start_open) && c_door.m_s_bundle.door_start_open) {
    c_door flag::set("open");
  }

  if(isDefined(c_door.var_a2f96f78.script_flag)) {
    a_flags = strtok(c_door.var_a2f96f78.script_flag, ", ");

    foreach(str_flag in a_flags) {
      level flag::init(str_flag);
    }
  }

  [[c_door]] - > init_door_model(e_or_str_door_model, n_door_connect_paths, s_door_instance);
  [[c_door]] - > init_trigger(v_trigger_offset, n_trigger_radius, c_door.m_s_bundle);
  [[c_door]] - > init_player_spawns();
  [[c_door]] - > init_hint_trigger();
  thread[[c_door]] - > run_lock_fx();
  [[c_door]] - > init_movement(str_slide_dir, n_slide_amount);

  if(!isDefined(c_door.m_s_bundle.door_open_time)) {
    c_door.m_s_bundle.door_open_time = 0.4;
  }

  [[c_door]] - > set_door_paths(n_door_connect_paths);

  if(isDefined(s_door_instance.script_delay)) {
    [[c_door]] - > function_ea9e96ca(s_door_instance.script_delay);
  }

  c_door.m_s_bundle.b_loop_sound = isDefined(c_door.m_s_bundle.door_loop_sound) && c_door.m_s_bundle.door_loop_sound != "";

  if(isDefined(s_door_instance.script_obstruction_malfunction) && s_door_instance.script_obstruction_malfunction) {
    c_door thread function_83929c65(1);
  } else {
    level thread door_update(c_door);
  }

  if(isDefined(c_door.m_s_bundle.var_d37e8f3e) && c_door.m_s_bundle.var_d37e8f3e) {
    level thread function_dc98f943(c_door);
  }

  return c_door;
}

door_open_update(c_door) {
  if(!isDefined(c_door.m_e_trigger)) {
    return;
  }

  c_door.m_e_trigger endon(#"death");
  str_unlock_method = "default";

  if(isDefined(c_door.m_s_bundle.door_unlock_method)) {
    str_unlock_method = c_door.m_s_bundle.door_unlock_method;
  }

  b_auto_close = isDefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes && !(isDefined(c_door.m_s_bundle.door_use_trigger) && c_door.m_s_bundle.door_use_trigger);
  b_hold_open = isDefined(c_door.m_s_bundle.door_use_hold) && c_door.m_s_bundle.door_use_hold;
  b_manual_close = isDefined(c_door.m_s_bundle.door_use_trigger) && c_door.m_s_bundle.door_use_trigger && isDefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes;

  while(true) {
    waitresult = c_door.m_e_trigger waittill(#"trigger");
    e_who = waitresult.activator;
    c_door.m_e_trigger_player = e_who;

    if(c_door.var_a2f96f78.script_team !== #"any" && !c_door.m_e_trigger_player util::is_on_side(c_door.var_a2f96f78.script_team)) {
      continue;
    }

    if(!c_door flag::get("open")) {
      if(!c_door flag::get("locked")) {
        if(b_hold_open || b_auto_close) {
          [
            [c_door]
          ] - > open();

          if(b_hold_open) {
            if(isplayer(e_who)) {
              e_who player_freeze_in_place(1);
              e_who disableweapons();
              e_who disableoffhandweapons();
            }
          }

          door_wait_until_clear(c_door, e_who);
          [
            [c_door]
          ] - > close();

          if(b_hold_open) {
            waitframe(1);
            c_door flag::wait_till_clear("animating");

            if(isplayer(e_who)) {
              e_who player_freeze_in_place(0);
              e_who enableweapons();
              e_who enableoffhandweapons();
            }
          }
        } else {
          [
            [c_door]
          ] - > open();
        }
      }

      continue;
    }

    if(b_manual_close) {
      [
        [c_door]
      ] - > close();
    }
  }
}

door_update(c_door) {
  c_door notify(#"end_door_update");
  c_door endon(#"end_door_update");
  str_unlock_method = "default";

  if(isDefined(c_door.m_s_bundle.door_unlock_method)) {
    str_unlock_method = c_door.m_s_bundle.door_unlock_method;
  }

  if(isDefined(c_door.m_s_bundle.door_locked) && c_door.m_s_bundle.door_locked) {
    c_door flag::set("locked");

    if(isDefined(c_door.var_a2f96f78.targetname)) {
      thread door_update_lock_scripted(c_door);
    }
  }

  thread door_open_update(c_door);
  [[c_door]] - > update_use_message();

  while(true) {
    if(c_door flag::get("locked")) {
      c_door flag::wait_till_clear("locked");
    }

    c_door flag::wait_till("open");

    if(c_door.m_door_open_delay_time > 0) {
      c_door.m_e_door notify(#"door_waiting_to_open", {
        #player: c_door.m_e_trigger_player
      });
      wait c_door.m_door_open_delay_time;
    }

    [[c_door]] - > open_internal();
    c_door flag::wait_till_clear("open");
    [[c_door]] - > close_internal();

    if(!(isDefined(c_door.m_s_bundle.door_closes) && c_door.m_s_bundle.door_closes)) {
      if(isDefined(c_door.m_s_bundle.var_d37e8f3e) && c_door.m_s_bundle.var_d37e8f3e) {
        c_door notify(#"set_destructible", {
          #player: c_door.m_e_trigger_player
        });
      }

      break;
    }

    waitframe(1);
  }

  if(isDefined(c_door.m_e_trigger)) {
    c_door.m_e_trigger delete();
    c_door.m_e_trigger = undefined;
  }
}

door_update_lock_scripted(c_door) {
  door_str = c_door.var_a2f96f78.targetname;
  c_door.m_e_trigger.targetname = door_str + "_trig";
  c_door.m_e_trigger endon(#"death");

  while(true) {
    c_door.m_e_trigger waittill(#"unlocked");
    [[c_door]] - > unlock();
  }
}

function_dc98f943(c_door) {
  e_door = c_door.m_e_door;
  e_door endon(#"door_cleared", #"delete");
  assert(isDefined(e_door), "<dev string:xeb>");
  e_door setCanDamage(0);
  waitresult = c_door waittill(#"set_destructible");
  e_door waittill(#"door_closed");
  e_door setCanDamage(1);
  e_door setteam(waitresult.player.team);

  if(isDefined(c_door.var_a2f96f78) && isDefined(c_door.var_a2f96f78.script_make_full_sentient) && c_door.var_a2f96f78.script_make_full_sentient) {
    e_door makesentient();
    e_door.canbemeleed = 0;
  } else {
    e_door util::function_5d36c37a();
  }

  target_set(e_door);
  level notify(#"hash_9db88375ef038b", {
    #c_door: c_door, 
    #player: waitresult.player
  });
  e_door val::set(#"hash_25bedd86747e41e1", "takedamage", 1);
  e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 1);

  if(isDefined(c_door.m_s_bundle.registersidestepshouldstun)) {
    e_door.health = c_door.m_s_bundle.registersidestepshouldstun;
  } else {
    e_door.health = 10000;
  }

  if(isDefined(c_door.m_s_bundle.var_8bed02db)) {
    e_door.script_health = e_door.health;
    e_door thread scene::init(c_door.m_s_bundle.var_8bed02db, e_door);
    e_door waittill(#"hash_18be12558bc58fe");
  } else {
    while(e_door.health > 0) {
      e_door waittill(#"damage");
    }

    e_door ghost();
  }

  target_remove(e_door);

  if(issentient(e_door)) {
    e_door function_60d50ea4();
  } else if(function_ffa5b184(e_door)) {
    e_door function_dfee3dec();
  }

  e_door val::reset(#"hash_25bedd86747e41e1", "takedamage");
  e_door val::reset(#"hash_25bedd86747e41e1", "allowdeath");
  e_door.health = 0;

  if(isDefined(c_door.m_s_bundle.var_ffb77aca)) {
    playFXOnTag(c_door.m_s_bundle.var_ffb77aca, e_door, "tag_origin");
  }

  e_door notsolid();
  e_door fly_step_crouch_walk_bot_plr_brick();
  e_door notify(#"door_cleared");
}

player_freeze_in_place(b_do_freeze) {
  if(!b_do_freeze) {
    if(isDefined(self.freeze_origin)) {
      self unlink();
      self.freeze_origin delete();
      self.freeze_origin = undefined;
    }

    return;
  }

  if(!isDefined(self.freeze_origin)) {
    self.freeze_origin = spawn("script_model", self.origin);
    self.freeze_origin setModel(#"tag_origin");
    self.freeze_origin.angles = self.angles;
    self playerlinktodelta(self.freeze_origin, "tag_origin", 1, 45, 45, 45, 45);
  }
}

function_4fb146e4(c_door) {
  allentities = getentitiesinradius([[c_door]] - > function_61c13b93(), 30);
  entcount = 0;

  foreach(entity in allentities) {
    if(isplayer(entity)) {
      continue;
    }

    if(iscorpse(entity) && isDefined(level.var_a348230f) && level.var_a348230f) {
      entity delete();
      continue;
    }

    if(!isDefined(entity.weapon)) {
      continue;
    }

    entcount++;
  }

  return entcount == 0;
}

trigger_wait_until_clear(c_door) {
  self endon(#"death");
  last_trigger_time = gettime();
  self.ents_in_trigger = 1;
  str_kill_trigger_notify = "trigger_now_clear";
  self thread trigger_check_for_ents_touching(str_kill_trigger_notify);

  while(true) {
    time = gettime();

    if(self.ents_in_trigger == 1) {
      self.ents_in_trigger = 0;
      last_trigger_time = time;
    }

    var_39533c4 = 0;
    dt = float(time - last_trigger_time) / 1000;

    if(dt >= 0.3) {
      var_39533c4 = 1;
    }

    if(var_39533c4 && function_4fb146e4(c_door)) {
      break;
    }

    waitframe(1);
  }

  self notify(str_kill_trigger_notify);
}

door_wait_until_user_release(c_door, e_triggerer, str_kill_on_door_notify) {
  if(isDefined(str_kill_on_door_notify)) {
    c_door endon(str_kill_on_door_notify);
  }

  wait 0.25;
  max_dist_sq = c_door.m_s_bundle.door_trigger_radius * c_door.m_s_bundle.door_trigger_radius;
  b_pressed = 1;
  n_dist = 0;

  do {
    waitframe(1);
    b_pressed = e_triggerer usebuttonpressed();
    n_dist = distancesquared(e_triggerer.origin, self.origin);
  }
  while(b_pressed && n_dist < max_dist_sq);
}

door_wait_until_clear(c_door, e_triggerer) {
  e_trigger = c_door.m_e_trigger;

  if(isplayer(e_triggerer) && isDefined(c_door.m_s_bundle.door_use_hold) && c_door.m_s_bundle.door_use_hold) {
    c_door.m_e_trigger door_wait_until_user_release(c_door, e_triggerer);
  }

  e_trigger trigger_wait_until_clear(c_door);
}

trigger_check_for_ents_touching(str_kill_trigger_notify) {
  self endon(#"death", str_kill_trigger_notify);

  while(true) {
    self waittill(#"trigger");
    self.ents_in_trigger = 1;
  }
}

door_debug_line(v_origin) {
  self endon(#"death");

  while(true) {
    v_start = v_origin;
    v_end = v_start + (0, 0, 1000);
    v_col = (0, 0, 1);

    line(v_start, v_end, (0, 0, 1));

    wait 0.1;
  }
}

unlock(str_value, str_key = "targetname", b_do_open = 1) {
  if(isDefined(self.c_door)) {
    [[self.c_door]] - > unlock();

    if(b_do_open) {
      [
        [self.c_door]
      ] - > open();
    }

    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    if(isDefined(e_door.c_door)) {
      [
        [e_door.c_door]
      ] - > unlock();

      if(b_do_open) {
        [
          [e_door.c_door]
        ] - > open();
      }
    }
  }
}

unlock_all(b_do_open = 1) {
  unlock(undefined, undefined, b_do_open);
}

lock(str_value, str_key = "targetname", b_do_close = 1) {
  if(isDefined(self.c_door)) {
    if(b_do_close) {
      [
        [self.c_door]
      ] - > close();
    }

    [[self.c_door]] - > lock();
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    if(isDefined(e_door.c_door)) {
      if(b_do_close) {
        [
          [e_door.c_door]
        ] - > close();
      }

      [
        [e_door.c_door]
      ] - > lock();
    }
  }
}

lock_all(b_do_close = 1) {
  lock(undefined, undefined, b_do_close);
}

open(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    [[self.c_door]] - > open();
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    if(isDefined(e_door.c_door)) {
      [
        [e_door.c_door]
      ] - > open();
    }
  }
}

open_all() {
  open();
}

close(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    [[self.c_door]] - > open();
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    if(isDefined(e_door.c_door)) {
      [
        [e_door.c_door]
      ] - > close();
    }
  }
}

close_all() {
  close();
}

is_open() {
  return self.c_door flag::get("open");
}

waittill_door_opened(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    self.c_door flag::wait_till("open");
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  while(true) {
    var_8c4538df = 1;

    foreach(e_door in a_e_doors) {
      if(!e_door.c_door flag::get("open")) {
        var_8c4538df = 0;
        break;
      }
    }

    if(var_8c4538df) {
      return;
    }

    waitframe(1);
  }
}

waittill_door_closed(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    self.c_door flag::wait_till_clear("open");
    self.c_door flag::wait_till_clear("animating");
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  while(true) {
    var_a644cd9e = 1;

    foreach(e_door in a_e_doors) {
      if(e_door.c_door flag::get("open") || e_door.c_door flag::get("animating")) {
        var_a644cd9e = 0;
        break;
      }
    }

    if(var_a644cd9e) {
      return;
    }

    waitframe(1);
  }
}

get_doors(str_value, str_key = "targetname") {
  if(isDefined(str_value)) {
    a_e_doors = struct::get_array(str_value, str_key);
    a_e_doors = arraycombine(a_e_doors, getEntArray(str_value, str_key), 0, 0);
  } else {
    a_e_doors = struct::get_array("scriptbundle_doors", "classname");
    a_e_doors = arraycombine(a_e_doors, struct::get_array("scriptbundle_obstructions", "classname"), 0, 0);
    a_e_doors = arraycombine(a_e_doors, getEntArray("smart_object_door", "script_noteworthy"), 0, 0);
  }

  return a_e_doors;
}

function_3353d645(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    [[self.c_door]] - > delete_door();
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    [[e_door.c_door]] - > delete_door();
  }
}

function_83929c65(b_enable, str_value, str_key = "targetname") {
  if(isclass(self)) {
    self thread function_fcadd390(b_enable);
    return;
  }

  if(isDefined(self.c_door)) {
    self.c_door thread function_fcadd390(b_enable);
    return;
  }

  a_e_doors = get_doors(str_value, str_key);

  foreach(e_door in a_e_doors) {
    if(isDefined(e_door.c_door)) {
      e_door.c_door thread function_fcadd390(b_enable);
    }
  }
}

private function_fcadd390(b_enable) {
  self.m_e_door endon(#"death");
  self notify(#"hash_50b9293fc24e2756");
  self endon(#"hash_50b9293fc24e2756");
  [[self]] - > close_internal();
  thread[[self]] - > function_f50c09b3(b_enable);
}

private function_fa74d5cd(c_door) {
  self waittill(#"death");
  c_door = undefined;
}

function_73f09315(str_value, str_key = "targetname") {
  if(isDefined(self.c_door)) {
    return self.c_door.m_e_door;
  }

  a_e_doors = get_doors(str_value, str_key);
  return a_e_doors[0].c_door.m_e_door;
}