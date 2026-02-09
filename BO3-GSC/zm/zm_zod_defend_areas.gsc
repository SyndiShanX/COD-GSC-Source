/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_defend_areas.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_zod_quest;
#using scripts\zm\zm_zod_util;

class careadefend {
  var m_s_centerpoint;
  var m_str_luimenu_progress;
  var m_str_luimenu_return;
  var m_n_defend_current_progress;
  var m_e_defend_volume;
  var m_n_defend_radius_sq;
  var m_n_state;
  var m_n_defend_progress_per_update_interval;
  var m_a_defend_event_zombies;
  var m_e_spawn_points;
  var m_a_players_involved;
  var m_arg1;
  var m_func_fail;
  var m_t_use;
  var m_func_succeed;
  var m_a_e_zombie_spawners;
  var m_n_defend_grace_duration;
  var m_n_defend_grace_remaining;
  var m_n_defend_duration;
  var m_func_prereq;
  var m_triggerer;
  var m_func_start;
  var stub;
  var m_b_started;
  var m_str_area_defend_unavailable;
  var m_str_area_defend_available;
  var m_func_trigger_visibility;
  var m_e_rumble_volume;
  var m_str_luimenu_succeeded;
  var m_str_luimenu_failed;
  var m_str_spawn;
  var m_n_defend_radius;
  var m_n_rumble_radius;
  var m_n_rumble_radius_sq;
  var m_str_area_defend_in_progress;

  constructor() {}

  destructor() {}

  function function_a5e2032d() {
    var_7591ca03 = zm_zonemgr::get_zone_from_position(m_s_centerpoint.origin);
    if(issubstr(var_7591ca03, "burlesque")) {
      var_b42fba6b = "burlesque";
    } else {
      if(issubstr(var_7591ca03, "gym")) {
        var_b42fba6b = "gym";
      } else {
        if(issubstr(var_7591ca03, "brothel")) {
          var_b42fba6b = "brothel";
        } else {
          if(issubstr(var_7591ca03, "magician")) {
            var_b42fba6b = "magician";
          } else {
            var_b42fba6b = "pap";
          }
        }
      }
    }
    var_b5a606c0 = [];
    foreach(str_zone_name in level.active_zone_names) {
      if(issubstr(str_zone_name, var_b42fba6b)) {
        if(!isDefined(var_b5a606c0)) {
          var_b5a606c0 = [];
        } else if(!isarray(var_b5a606c0)) {
          var_b5a606c0 = array(var_b5a606c0);
        }
        var_b5a606c0[var_b5a606c0.size] = str_zone_name;
      }
    }
    a_ai_zombies = getaiteamarray(level.zombie_team);
    a_ai_zombies = arraysort(a_ai_zombies, m_s_centerpoint.origin);
    i = 0;
    while(i < a_ai_zombies.size) {
      var_31a4faf3 = 0;
      foreach(var_7da234a9 in var_b5a606c0) {
        if(a_ai_zombies[i] zm_zonemgr::entity_in_zone(var_7da234a9)) {
          var_31a4faf3 = 1;
          i++;
          break;
        }
      }
      if(!var_31a4faf3) {
        arrayremovevalue(a_ai_zombies, a_ai_zombies[i]);
      }
    }
    return a_ai_zombies;
  }

  function ritual_nuke() {
    level lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    wait(0.2);
    a_ai_zombies = function_a5e2032d();
    var_6b1085eb = [];
    foreach(ai_zombie in a_ai_zombies) {
      if(isDefined(ai_zombie.ignore_nuke) && ai_zombie.ignore_nuke) {
        continue;
      }
      if(isDefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
        continue;
      }
      if(isDefined(ai_zombie.nuke_damage_func)) {
        ai_zombie thread[[ai_zombie.nuke_damage_func]]();
        continue;
      }
      if(zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
        continue;
      }
      ai_zombie.marked_for_death = 1;
      ai_zombie.nuked = 1;
      var_6b1085eb[var_6b1085eb.size] = ai_zombie;
    }
    foreach(i, var_f92b3d80 in var_6b1085eb) {
      if(!isDefined(var_f92b3d80)) {
        continue;
      }
      if(zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
        continue;
      }
      if(i < 5 && (!(isDefined(var_f92b3d80.isdog) && var_f92b3d80.isdog))) {
        var_f92b3d80 thread zombie_death::flame_death_fx();
      }
      if(!(isDefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
        if(!(isDefined(var_f92b3d80.no_gib) && var_f92b3d80.no_gib)) {
          var_f92b3d80 zombie_utility::zombie_head_gib();
        }
      }
      var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
      if(!level flag::get("special_round")) {
        if(var_f92b3d80.archetype == "margwa") {
          level.var_e0191376++;
          continue;
        }
        level.zombie_total++;
      }
    }
  }

  function reset_hud(player) {
    if(isDefined(player) && player.sessionstate === "spectator") {
      return;
    }
    if(isDefined(player) && isDefined(player.defend_area_luimenu_status)) {
      progress_menu_status = player getluimenu(m_str_luimenu_progress);
      return_menu_status = player getluimenu(m_str_luimenu_return);
      if(isDefined(progress_menu_status) || isDefined(return_menu_status)) {
        player closeluimenu(player.defend_area_luimenu_status);
        player.defend_area_luimenu_status = undefined;
      }
    }
  }

  function defend_failed_hud(player) {
    self reset_hud(player);
    if(isDefined(player) && player.sessionstate === "spectator") {
      return;
    }
    wait(3);
    self reset_hud(player);
  }

  function defend_succeeded_hud(player) {
    self reset_hud(player);
    if(isDefined(player) && isDefined(player.sessionstate) && player.sessionstate == "spectator") {
      return;
    }
    wait(3);
    self reset_hud(player);
  }

  function get_current_progress() {
    return m_n_defend_current_progress / 100;
  }

  function is_player_in_defend_area(player) {
    if(isDefined(m_e_defend_volume)) {
      if(zm_utility::is_player_valid(player, 1, 1) && player istouching(m_e_defend_volume)) {
        return true;
      }
      return false;
    }
    if(zm_utility::is_player_valid(player, 1, 1) && distance2dsquared(player.origin, m_s_centerpoint.origin) < m_n_defend_radius_sq && player.origin[2] > (m_s_centerpoint.origin[2] + -20)) {
      return true;
    }
    return false;
  }

  function get_players_in_defend_area() {
    a_players_in_defend_area = [];
    foreach(player in level.activeplayers) {
      if(zm_utility::is_player_valid(player) && is_player_in_defend_area(player)) {
        array::add(a_players_in_defend_area, player);
      }
    }
    return a_players_in_defend_area;
  }

  function get_state() {
    return m_n_state;
  }

  function get_progress_rate(n_players_in_defend_area, n_players_total) {
    n_current_update_rate = (n_players_in_defend_area / n_players_total) * m_n_defend_progress_per_update_interval;
    return n_current_update_rate;
  }

  function kill_all_defend_event_zombies() {
    foreach(zombie in m_a_defend_event_zombies) {
      if(isalive(zombie) && (isDefined(zombie.allowdeath) && zombie.allowdeath)) {
        zombie kill();
      }
    }
  }

  function defend_failed() {
    println("");
    m_n_state = 1;
    update_usetrigger_hintstring();
    kill_all_defend_event_zombies();
    m_e_spawn_points = [];
    self thread populate_spawn_points();
    foreach(player in m_a_players_involved) {
        if(!isDefined(player)) {
          continue;
        }
        player thread zm_zod_util::set_rumble_to_player(0);
        player.is_in_defend_area = undefined;
        self thread defend_failed_hud(player);
      }
      [[m_func_fail]](m_arg1);
  }

  function defend_succeeded() {
    println("");
    m_n_state = 3;
    kill_all_defend_event_zombies();
    foreach(s_spawn_point in m_e_spawn_points) {
      s_spawn_point delete();
    }
    m_e_spawn_points = [];
    self thread ritual_nuke();
    zm_unitrigger::unregister_unitrigger(m_t_use);
    m_t_use = undefined;
    foreach(player in m_a_players_involved) {
        if(!isDefined(player)) {
          continue;
        }
        player thread zm_zod_util::set_rumble_to_player(6);
        player.is_in_defend_area = undefined;
        self thread defend_succeeded_hud(player);
        player zm_score::add_to_player_score(500);
      }
      [[m_func_succeed]](m_arg1, m_a_players_involved);
    self notify("area_defend_completed");
  }

  function get_unused_spawn_point() {
    a_valid_spawn_points = [];
    b_all_points_used = 0;
    while(!a_valid_spawn_points.size) {
      foreach(s_spawn_point in m_e_spawn_points) {
        if(!isDefined(s_spawn_point.spawned_zombie) || b_all_points_used) {
          s_spawn_point.spawned_zombie = 0;
        }
        if(!s_spawn_point.spawned_zombie) {
          array::add(a_valid_spawn_points, s_spawn_point, 0);
        }
      }
      if(!a_valid_spawn_points.size) {
        b_all_points_used = 1;
      }
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    s_spawn_point.spawned_zombie = 1;
    return s_spawn_point;
  }

  function function_877a7365() {
    self endon("death");
    while(true) {
      var_c7ca004c = [];
      foreach(player in level.activeplayers) {
        if(zm_utility::is_player_valid(player) && (isDefined(player.is_in_defend_area) && player.is_in_defend_area)) {
          if(!isDefined(var_c7ca004c)) {
            var_c7ca004c = [];
          } else if(!isarray(var_c7ca004c)) {
            var_c7ca004c = array(var_c7ca004c);
          }
          var_c7ca004c[var_c7ca004c.size] = player;
        }
      }
      e_target_player = array::random(var_c7ca004c);
      while(isalive(e_target_player) && (!(isDefined(e_target_player.beastmode) && e_target_player.beastmode)) && !e_target_player laststand::player_is_in_laststand()) {
        self setgoal(e_target_player);
        self waittill("goal");
      }
      wait(0.1);
    }
  }

  function function_df5ae14e(ai_zombie) {
    ai_zombie waittill("death");
    ai_zombie clientfield::set("keeper_fx", 0);
  }

  function monitor_defend_event_zombies() {
    m_a_defend_event_zombies = [];
    while(m_n_state == 2) {
      m_a_defend_event_zombies = array::remove_dead(m_a_defend_event_zombies, 0);
      n_defend_event_zombie_limit = 4;
      if(level.round_number < 4) {
        n_defend_event_zombie_limit = 6;
      } else if(level.round_number < 6) {
        n_defend_event_zombie_limit = 5;
      }
      if(m_a_defend_event_zombies.size < n_defend_event_zombie_limit) {
        s_spawn_point = get_unused_spawn_point();
        ai = zombie_utility::spawn_zombie(m_a_e_zombie_spawners[0], "defend_event_zombie", s_spawn_point);
        if(!isDefined(ai)) {
          println("");
          continue;
        }
        ai.var_81ac9e79 = 1;
        ai thread zm_zod_quest::function_2d0c5aa1(s_spawn_point);
        ai thread function_877a7365();
        array::add(m_a_defend_event_zombies, ai, 0);
      }
      wait(level.zombie_vars["zombie_spawn_delay"]);
    }
  }

  function function_d9a5609b(n_players_total, n_players_in_defend_area) {
    if(n_players_total == 1) {
      return 20;
    }
    if(n_players_total == 2 && n_players_in_defend_area == 1) {
      return 30;
    }
    if(n_players_total == 2 && n_players_in_defend_area == 2) {
      return 20;
    }
    if(n_players_total == 3 && n_players_in_defend_area == 1) {
      return 40;
    }
    if(n_players_total == 3 && n_players_in_defend_area == 2) {
      return 30;
    }
    if(n_players_total == 3 && n_players_in_defend_area == 3) {
      return 20;
    }
    if(n_players_total == 4 && n_players_in_defend_area == 1) {
      return 60;
    }
    if(n_players_total == 4 && n_players_in_defend_area == 2) {
      return 40;
    }
    if(n_players_total == 4 && n_players_in_defend_area == 3) {
      return 30;
    }
    if(n_players_total == 4 && n_players_in_defend_area == 4) {
      return 20;
    }
    return 30;
  }

  function progress_think() {
    println("");
    m_n_defend_current_progress = 0;
    m_n_defend_grace_remaining = m_n_defend_grace_duration;
    m_a_players_involved = [];
    var_db69778c = level.activeplayers.size;
    a_players_in_defend_area = get_players_in_defend_area();
    n_players_in_defend_area = a_players_in_defend_area.size;
    m_n_defend_duration = function_d9a5609b(var_db69778c, n_players_in_defend_area);
    m_n_defend_progress_per_update_interval = (100 / m_n_defend_duration) * 0.1;
    while(m_n_defend_current_progress < 100 && m_n_defend_grace_remaining > 0) {
      a_players_in_defend_area = get_players_in_defend_area();
      n_players_in_defend_area = a_players_in_defend_area.size;
      foreach(player in level.activeplayers) {
        if(!zm_utility::is_player_valid(player, 1, 1)) {
          continue;
        }
        if(is_player_in_defend_area(player)) {
          if(!isDefined(player.is_in_defend_area)) {
            player thread zm_zod_util::set_rumble_to_player(5);
            array::add(m_a_players_involved, player, 0);
            player.is_in_defend_area = 1;
          }
          if(!player.is_in_defend_area) {
            player thread zm_zod_util::set_rumble_to_player(5);
            player.is_in_defend_area = 1;
            self reset_hud(player);
          }
          continue;
        }
        if(zm_utility::is_player_valid(player, 1, 1)) {
          if(isDefined(player.is_in_defend_area) && player.is_in_defend_area) {
            player thread zm_zod_util::set_rumble_to_player(0);
            player.is_in_defend_area = 0;
            self reset_hud(player);
            player.defend_area_luimenu_status = player openluimenu(m_str_luimenu_return);
          }
        }
      }
      n_current_progress_rate = m_n_defend_progress_per_update_interval;
      m_n_defend_current_progress = m_n_defend_current_progress + n_current_progress_rate;
      if(n_players_in_defend_area > 0) {
        m_n_defend_current_progress = math::clamp(m_n_defend_current_progress, 0, 100);
        m_n_defend_grace_remaining = m_n_defend_grace_duration;
      } else {
        m_n_defend_grace_remaining = m_n_defend_grace_remaining - 0.1;
      }
      wait(0.1);
    }
    if(m_n_defend_current_progress == 100) {
      defend_succeeded();
    } else {
      defend_failed();
    }
  }

  function usetrigger_think() {
    self endon("area_defend_completed");
    while(true) {
      m_t_use waittill("trigger", e_triggerer);
      if(e_triggerer zm_utility::in_revive_trigger()) {
        continue;
      }
      if(!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
        continue;
      }
      if(m_n_state != 1) {
        continue;
      }
      if(isDefined(m_func_prereq) && [[m_func_prereq]](m_arg1) == 0) {
        continue;
      }
      m_n_state = 2;
      m_triggerer = e_triggerer;
      update_usetrigger_hintstring();
      [[m_func_start]](m_arg1, m_triggerer);
      self thread progress_think();
      self thread monitor_defend_event_zombies();
      while(m_n_state != 1) {
        wait(1);
      }
    }
  }

  function update_usetrigger_hintstring() {
    if(isDefined(m_t_use)) {
      m_t_use zm_unitrigger::run_visibility_function_for_all_triggers();
    }
  }

  function function_4e035595(player) {
    self endon("disconnect");
    if(isDefined(player.var_b999c630) && player.var_b999c630 || !level flag::get("ritual_in_progress")) {
      return;
    }
    player.var_b999c630 = 1;
    if(zm_utility::is_player_valid(player)) {
      player thread zm_zod_util::function_55f114f9("zmInventory.widget_quest_items", 3.5);
      player thread zm_zod_util::show_infotext_for_duration("ZM_ZOD_UI_RITUAL_BUSY", 3.5);
    }
    wait(3.5);
    player.var_b999c630 = 0;
  }

  function ritual_start_prompt_and_visibility(player) {
    b_is_visible = [[stub.o_defend_area]] - > ritual_start_visible_internal(player);
    if(b_is_visible) {
      str_msg = [[stub.o_defend_area]] - > ritual_start_message_internal(player);
      self sethintstring(str_msg);
      thread function_4e035595(player);
    } else {
      self sethintstring(&"");
    }
    return b_is_visible;
  }

  function ritual_start_visible_internal(player) {
    if(isDefined(player.beastmode) && player.beastmode) {
      return false;
    }
    if(isDefined(level.var_522a1f61) && level.var_522a1f61) {
      return false;
    }
    if(m_b_started) {
      switch (m_n_state) {
        case 0:
        case 1: {
          return true;
        }
        default: {
          break;
        }
      }
    }
    return false;
  }

  function ritual_start_message_internal(player) {
    if(!m_b_started) {
      return &"";
    }
    switch (m_n_state) {
      case 0: {
        return m_str_area_defend_unavailable;
      }
      case 1: {
        return m_str_area_defend_available;
      }
      default: {
        return &"";
      }
    }
  }

  function set_availability(b_is_available) {
    if(b_is_available && m_n_state == 0) {
      m_n_state = 1;
    } else if(!b_is_available && m_n_state == 1) {
      m_n_state = 0;
    }
    update_usetrigger_hintstring();
  }

  function start() {
    ritual_start_dims = (110, 110, 128);
    m_t_use = zm_zod_util::spawn_trigger_box(m_s_centerpoint.origin, m_s_centerpoint.angles, ritual_start_dims, 1);
    m_t_use.o_defend_area = self;
    m_t_use.prompt_and_visibility_func = m_func_trigger_visibility;
    m_b_started = 1;
    update_usetrigger_hintstring();
    self thread usetrigger_think();
  }

  function set_duration(n_duration) {
    m_n_defend_duration = n_duration;
    m_n_defend_progress_per_update_interval = (100 / m_n_defend_duration) * 0.1;
  }

  function set_volumes(str_defend_volume, str_rumble_volume) {
    m_e_defend_volume = getent(str_defend_volume, "targetname");
    m_e_rumble_volume = getent(str_rumble_volume, "targetname");
    assert(isDefined(m_e_defend_volume), "");
    assert(isDefined(m_e_rumble_volume), "");
  }

  function set_luimenus(str_luimenu_progress, str_luimenu_return, str_luimenu_succeeded, str_luimenu_failed) {
    m_str_luimenu_progress = str_luimenu_progress;
    m_str_luimenu_return = str_luimenu_return;
    m_str_luimenu_succeeded = str_luimenu_succeeded;
    m_str_luimenu_failed = str_luimenu_failed;
  }

  function set_external_functions(func_prereq, func_start, func_succeed, func_fail, arg1) {
    m_func_prereq = func_prereq;
    m_func_start = func_start;
    m_func_succeed = func_succeed;
    m_func_fail = func_fail;
    m_arg1 = arg1;
  }

  function set_trigger_visibility_function(func_trigger_visibility) {
    m_func_trigger_visibility = func_trigger_visibility;
  }

  function populate_spawn_points() {
    m_a_e_zombie_spawners = getEntArray("ritual_zombie_spawner", "targetname");
    a_s_spawn_points = struct::get_array(m_str_spawn, "targetname");
    foreach(s_spawn_point in a_s_spawn_points) {
      e_deletable_spawn_point = spawn("script_model", s_spawn_point.origin);
      e_deletable_spawn_point setModel("tag_origin");
      e_deletable_spawn_point.origin = s_spawn_point.origin;
      e_deletable_spawn_point.angles = s_spawn_point.angles;
      if(!isDefined(m_e_spawn_points)) {
        m_e_spawn_points = [];
      } else if(!isarray(m_e_spawn_points)) {
        m_e_spawn_points = array(m_e_spawn_points);
      }
      m_e_spawn_points[m_e_spawn_points.size] = e_deletable_spawn_point;
    }
  }

  function init(str_centerpoint, str_spawn) {
    m_s_centerpoint = struct::get(str_centerpoint, "targetname");
    m_str_spawn = str_spawn;
    m_n_defend_duration = 30;
    m_n_defend_current_progress = 0;
    m_n_defend_progress_per_update_interval = (100 / m_n_defend_duration) * 0.1;
    m_n_defend_grace_duration = 5;
    m_n_defend_grace_remaining = m_n_defend_grace_duration;
    m_n_defend_radius = 220;
    m_n_defend_radius_sq = m_n_defend_radius * m_n_defend_radius;
    m_n_rumble_radius = m_n_defend_radius;
    m_n_rumble_radius_sq = m_n_rumble_radius * m_n_rumble_radius;
    m_str_area_defend_unavailable = &"ZM_ZOD_DEFEND_AREA_UNAVAILABLE";
    m_str_area_defend_available = &"ZM_ZOD_DEFEND_AREA_AVAILABLE";
    m_str_area_defend_in_progress = &"ZM_ZOD_DEFEND_AREA_IN_PROGRESS";
    m_func_trigger_visibility = &ritual_start_prompt_and_visibility;
    m_func_trigger_thread = &usetrigger_think;
    populate_spawn_points();
    m_n_state = 0;
    m_b_started = 0;
    update_usetrigger_hintstring();
  }
}