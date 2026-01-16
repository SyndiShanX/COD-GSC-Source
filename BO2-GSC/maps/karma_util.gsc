/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\anims;
#include maps\_objectives;
#include maps\_scene;
#include maps\_dynamic_nodes;
#include maps\_strength_test;
#include maps\_glasses;
#include maps\_fxanim;

setup_objectives() {
  level.a_objectives = [];
  level.n_obj_index = 0;
  level.obj_security = register_objective(&"KARMA_OBJ_SECURITY");
  level.obj_find_crc = register_objective(&"KARMA_OBJ_FIND_CRC");
  level.obj_enter_crc = register_objective(&"KARMA_OBJ_INFILTRATE_CRC");
  level.obj_disable_zapper = register_objective(&"KARMA_OBJ_DISABLE_ZAPPER");
  level.obj_crc_guy = register_objective(&"KARMA_OBJ_CRC_GUY");
  level.obj_intruder = register_objective(&"");
  level.obj_brute = register_objective(&"");
  level.obj_trespasser = register_objective(&"");
  level.obj_id_karma = register_objective(&"KARMA_OBJ_ID_KARMA");
  level.obj_get_to_club = register_objective(&"KARMA_OBJ_GET_TO_CLUB");
  level.obj_meet_karma = register_objective(&"KARMA_OBJ_MEET_KARMA");
  level.obj_kill_club_guards = register_objective(&"KARMA_OBJ_KILL_CLUB_GUARDS");
  level.obj_exit_club = register_objective(&"KARMA_OBJ_EXIT_CLUB");
  level.obj_salazar_unlock_door = register_objective(&"KARMA_2_OBJ_OPEN_GATE");
  level.obj_stop_defalco = register_objective(&"KARMA_2_OBJ_STOP_DEFALCO");
  level thread maps\_objectives::objectives();
}

init_hero_startstruct(str_hero_name, str_struct_targetname) {
  ai_hero = init_hero(str_hero_name);
  s_start_pos = getstruct(str_struct_targetname, "targetname");
  assert(isDefined(s_start_pos), "Bad Hero setup struct: " + str_struct_targetname);

  if(isDefined(s_start_pos.angles))
    v_angles = s_start_pos.angles;
  else
    v_angles = (0, 0, 0);

  ai_hero forceteleport(s_start_pos.origin, v_angles);
  return ai_hero;
}

add_cleanup_ent(str_category) {
  if(!isDefined(level.a_e_cleanup))
    level.a_e_cleanup = [];

  if(!isDefined(level.a_e_cleanup[str_category]))
    level.a_e_cleanup[str_category] = [];

  if(isarray(self))
    level.a_e_cleanup[str_category] = arraycombine(level.a_e_cleanup[str_category], self, 1, 0);
  else
    level.a_e_cleanup[str_category][level.a_e_cleanup[str_category].size] = self;
}

cleanup_ents(str_category) {
  level thread cleanup_structs(str_category);
  level notify(str_category);

  if(isDefined(level.a_e_cleanup) && isDefined(level.a_e_cleanup[str_category])) {
    foreach(ent in level.a_e_cleanup[str_category]) {
      if(isDefined(ent))
        ent delete();
    }

    level.a_e_cleanup[str_category] = undefined;
  }

  a_ents = getentarray(str_category, "script_noteworthy");

  foreach(ent in a_ents)
  ent delete();

  if(str_category == "cleanup_outersolar") {
    foreach(e_solarsystem in getentarray("solar_systems", "script_noteworthy"))
    e_solarsystem delete();
  }
}

cleanup(ent) {
  if(isDefined(ent))
    ent delete();
}

cleanup_kvp(str_value, str_key) {
  array_delete(getentarray(str_value, str_key));
}

cleanup_structs(str_category) {
  level thread delete_structs(str_category, "script_noteworthy");

  if(str_category == "cleanup_outersolar") {
    foreach(s_dancer in getstructarray("dancers", "script_noteworthy"))
    s_dancer structdelete();
  }
}

delete_structs(str_value, str_key) {
  foreach(s_struct in getstructarray(str_value, str_key))
  s_struct structdelete();
}

setup_elevator(str_brushmodelname, str_modelname, str_cleanup) {
  bm_lift = getent(str_brushmodelname, "targetname");
  a_bm_door_clips = getentarray(bm_lift.target, "targetname");

  foreach(bm_door_clip in a_bm_door_clips)
  bm_door_clip linkto(bm_lift);

  m_lift = getent(str_modelname, "targetname");
  m_lift thread play_fx("elevator_light", undefined, undefined, "elevator_flashlight_off", 1, "tag_flashlight");
  m_lift thread play_fx("elevator_lights", m_lift gettagorigin("tag_origin") + (27.5, 37.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_lift thread play_fx("elevator_lights", m_lift gettagorigin("tag_origin") + (-27.5, 37.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_lift thread play_fx("elevator_lights", m_lift gettagorigin("tag_origin") + (27.5, -37.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_lift thread play_fx("elevator_lights", m_lift gettagorigin("tag_origin") + (-27.5, -37.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  bm_lift.origin = m_lift.origin;
  m_lift linkto(bm_lift);
  return bm_lift;
}

elevator_move_doors(b_open, n_time, n_accel, n_decel, b_connect_paths) {
  if(!isDefined(n_time))
    n_time = 2.0;

  if(!isDefined(n_accel))
    n_accel = 0.0;

  if(!isDefined(n_decel))
    n_decel = 0.0;

  a_doors = getentarray(self.target, "targetname");

  foreach(m_door in a_doors) {
    if(b_open)
      m_door unlink();

    if(isDefined(m_door.script_float)) {
      n_rotate = m_door.script_float;

      if(!b_open)
        n_rotate = n_rotate * -1;

      m_door rotateyaw(n_rotate, n_time, n_accel, n_decel);
      continue;
    }

    if(isDefined(m_door.script_vector)) {
      v_move = m_door.script_vector;

      if(!b_open)
        v_move = v_move * -1;

      m_door moveto(m_door.origin + v_move, n_time, n_accel, n_decel);
    }
  }

  wait(n_time);

  if(!b_open) {
    foreach(m_door in a_doors)
    m_door linkto(self);
  }

  if(isDefined(b_connect_paths)) {
    foreach(m_door in a_doors) {
      if(b_open) {
        m_door connectpaths();
        continue;
      }

      m_door disconnectpaths();
    }
  }
}

entity_death_in_pose_after_time(delay, str_pose) {
  self endon("death");

  if(isDefined(delay))
    wait(delay);

  while(true) {
    if(self.a.pose == str_pose) {
      wait 0.05;
      self.health = 1;
      self dodamage(self.health, self.origin);
      return;
    }

    wait 0.01;
  }
}

spawn_fn_ai_run_to_target(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades, ignore_all) {
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades);
}

entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  if(isDefined(player_favourate_enemy) && player_favourate_enemy != 0)
    self.favoriteenemy = level.player;

  if(isDefined(str_cleanup_category))
    self add_cleanup_ent(str_cleanup_category);

  if(isDefined(ignore_surpression) && ignore_surpression != 0)
    self.script_ignore_suppression = 1;

  if(isDefined(disable_grenades) && disable_grenades != 0) {
    self.grenadeammo = 0;
    self.script_accuracy = 1.0;
  }
}

spawn_fn_ai_run_to_holding_node(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  self endon("death");
  self.goalradius = 48;
  self waittill("goal");
  self.fixednode = 1;
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades);
}

spawn_fn_ai_run_to_prone_node(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  self endon("death");
  self.goalradius = 48;
  self waittill("goal");
  self.npc_damage_scale = 0.7;
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades);
}

spawn_fn_ai_run_to_jumper_node(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades, attack_dist) {
}

run_to_jumper_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(self.npc_damage_scale))
    n_damage = int(n_damage * self.npc_damage_scale);

  return n_damage;
}

spawn_ai_battle(str_friendly_sp, str_enemy_sp, friendly_health, enemy_health, friendly_grenades, enemy_grenades, friendly_accuracy, enemy_accuracy) {
  sp_friendly = getent(str_friendly_sp, "targetname");
  ai_friendly = simple_spawn_single(sp_friendly, ::spawn_fn_ai_run_to_holding_node);

  if(isDefined(friendly_health))
    ai_friendly.health = friendly_health;

  sp_enemy = getent(str_enemy_sp, "targetname");
  ai_enemy = simple_spawn_single(sp_enemy, ::spawn_fn_ai_run_to_holding_node);

  if(isDefined(enemy_health))
    ai_enemy.health = enemy_health;

  ai_friendly.favouriteenemy = ai_enemy;
  ai_enemy.favouriteenemy = ai_friendly;

  if(!isDefined(friendly_grenades))
    ai_friendly.grenadeammo = 0;

  if(!isDefined(enemy_grenades))
    ai_enemy.grenadeammo = 0;

  if(!isDefined(friendly_accuracy))
    ai_friendly.script_accuracy = friendly_accuracy;

  if(!isDefined(enemy_accuracy))
    ai_enemy.script_accuracy = enemy_accuracy;
}

add_category_to_ai_in_scene(str_scene_name, str_category) {
  a_ai = get_ais_from_scene(str_scene_name);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++)
      a_ai[i] add_cleanup_ent(str_category);
  }
}

print3d_ent(str_msg, v_offset, n_time, msg_endon) {
  if(!isDefined(n_time))
    n_time = 99999;

  self endon("death");

  if(isDefined(msg_endon))
    level endon(msg_endon);

  n_time = gettime() + n_time * 1000;

  if(!isDefined(v_offset))
    v_offset = vectorscale((0, 0, 1), 32.0);

  v_offset = v_offset + vectorscale((0, 0, 1), 1.5);

  if(str_msg == "animname") {
    if(isDefined(self.animname))
      str_msg = self.animname;
    else
      str_msg = "NA";
  }

  while(gettime() < n_time) {
    print3d(self.origin + v_offset, str_msg);
    wait 0.05;
  }

}

delete_hero(ai_hero) {
  if(isalive(ai_hero))
    ai_hero delete();

  level.heroes = array_removedead(level.heroes);
}

simple_spawn_script_delay(a_ents, spawn_fn, param1, param2, param3, param4, param5) {
  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i];

    if(isDefined(e_ent.script_delay)) {
      level thread spawn_with_delay(e_ent.script_delay, e_ent, spawn_fn, param1, param2, param3, param4, param5);
      continue;
    }

    e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5, 0);

    if(isDefined(e_ent.script_health))
      e_ai.health = e_ent.script_health;
  }
}

spawn_with_delay(delay, e_ent, spawn_fn, param1, param2, param3, param4, param5) {
  wait(delay);
  e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5);
}

run_to_node_and_die(n_node) {
  self endon("death");
  self setgoalnode(n_node);
  self.goalradius = 64;
  self waittill("goal");
  self thread civ_idle();
  self auto_delete_with_ref();
}

aggressive_runner(str_category, n_delay) {
  self endon("death");

  if(isDefined(n_delay))
    wait(n_delay);

  if(isDefined(str_category))
    self add_cleanup_ent(str_category);

  self.ignoresuppression = 1;
  self change_movemode("sprint");
  self.aggressivemode = 1;
  self.canflank = 1;
}

player_rusher(str_category, delay, breakoff_distance, npc_damage_scale, npc_damage_scale_breakoff, disable_pain) {
}

helicopter_fly_down_attack_path(teleport_to_start_node, use_start_node_angles, initial_delay, accel, str_start_struct, reached_node_dist, delete_at_path_end) {
  self endon("death");

  if(isDefined(initial_delay))
    wait(initial_delay);

  speed = 30;
  s_node = getstruct(str_start_struct, "targetname");

  if(teleport_to_start_node)
    self.origin = s_node.origin;

  if(use_start_node_angles)
    self.angles = s_node.angles;

  wait 0.01;
  e_look_at_ent = spawn("script_origin", (0, 0, 0));

  while(true) {
    s_prev_node = s_node;
    s_node = getstruct(s_prev_node.target, "targetname");

    if(isDefined(s_node.speed))
      speed = s_node.speed;

    self setspeed(speed, accel, accel);
    self setvehgoalpos(s_node.origin);
    dir = anglestoforward(s_prev_node.angles);
    e_look_at_ent.origin = s_node.origin + dir * 840;
    self setlookatent(e_look_at_ent);
    dist = distance(self.origin, s_node.origin);

    while(dist > reached_node_dist) {
      dist = distance(self.origin, s_node.origin);
      wait 0.01;
    }

    if(!isDefined(s_node.target)) {
      break;
    }
  }

  e_look_at_ent delete();
  self notify("heli_path_complete");
  wait 0.1;

  if(isDefined(delete_at_path_end) && delete_at_path_end == 1)
    self delete();
  else
    self setspeed(0, accel, accel);
}

pip_karma_event(str_scene_name) {
  level thread maps\_glasses::play_bink_on_hud("karma_" + str_scene_name, 0, 0);
}

earthquake_delay(delay, scale, duration, origin, radius) {
  if(isDefined(delay))
    wait(delay);

  earthquake(scale, duration, origin, radius);
}

civ_run_from_node_to_node(delay, str_civ_targetname, str_node_start, str_node_end) {
  if(isDefined(delay))
    wait(delay);

  n_node1_start = getnode(str_node_start, "targetname");

  if(isDefined(n_node1_start.target))
    n_node1_end = getnode(n_node1_start.target, "targetname");
  else
    n_node1_end = getnode(str_node_end, "targetname");

  ai_civ = simple_spawn_single(str_civ_targetname);

  if(isalive(ai_civ)) {
    ai_civ forceteleport(n_node1_start.origin, ai_civ.angles);
    ai_civ setgoalnode(n_node1_end);
    ai_civ.goalradius = 48;
    ai_civ waittill("goal");
    ai_civ thread civ_idle();
    ai_civ thread auto_delete_with_ref();
  }
}

civ_idle() {
  self endon("death");

  while(true) {
    self setgoalpos(self.origin);
    wait 1;
  }
}

camera_think() {
  v_camera_eyes = self geteye();
  level.e_extra_cam.origin = v_camera_eyes;
  level.e_extra_cam.angles = self.angles;
  level.e_extra_cam linkto(self);
  self hide();
}

override_actor_killed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker)) {
    if(isplayer(eattacker)) {
      if(self.team == "axis") {
        if(isDefined(self.on_sundeck) && self.on_sundeck)
          level notify("killed_with_trespasser");

        if(isDefined(self.b_rappelling) && self.b_rappelling)
          level notify("killed_while_rappelling");
      }
    }
  }
}

callback_actorkilled_headshotcheck(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker) && isplayer(eattacker) && self.team == "axis") {
    level.player notify("player_killed_enemy");

    if(shitloc == "helmet")
      level notify("bar_fight_headshot");
  }
}

challenge_electrocutions(str_notify) {
  while(true) {
    self waittill("tazer_kill");
    self notify(str_notify);
  }
}

keep_asd_alive_challenge(str_notify) {
  flag_wait("friendly_asd_activated");
  level.vh_friendly_asd endon("death");
  level waittill("nextmission");
  self notify(str_notify);
}

special_vision_kills_challenge(str_notify) {
  flag_wait("scene_event8_door_breach_started");
  add_global_spawn_function("axis", ::special_vision_kill_think, self, str_notify);

  while(true) {
    level waittill("killed_with_trespasser");
    self notify(str_notify);
  }
}

special_vision_kill_think(e_player, str_notify) {
  self.on_sundeck = 1;
}

retrieve_bot_challenge(str_notify) {
  m_spiderbot_temp = getent("destroyed_spider_bot", "targetname");
  trigger_wait("destroyed_spider_bot_trigger");
  e_trigger = getent("destroyed_spider_bot_trigger", "targetname");
  e_trigger delete();
  m_spiderbot_temp delete();
  self notify(str_notify);
}

no_killing_civ(str_notify) {
  level endon("player_killed_civ");
  level waittill("nextmission");
  self notify(str_notify);
}

fast_complete_spider_bot(str_notify) {
  level endon("spiderbot_timed_out");
  flag_wait("spiderbot_bootup_done");
  level thread timednotify(60, "spiderbot_timed_out");
  flag_wait("spiderbot_entered_crc");
  scene_wait("it_mgr_surprise");

  if(flag("it_mgr_disabled"))
    self notify(str_notify);
}

club_speed_kill_challenge(str_notify) {
  flag_wait("start_bar_fight");

  while(!flag("counterterrorists_win")) {
    level waittill("bar_fight_headshot");
    self notify(str_notify);
  }
}

rappel_kills_challenge(str_notify) {
  while(true) {
    level waittill("killed_while_rappelling");
    self notify(str_notify);
  }
}

karma_no_death_challenge(str_notify) {
  level waittill("nextmission");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

timednotify(time, msg) {
  self endon(msg);
  wait(time);
  self notify(msg);
}

screen_message(str_msg, n_timeout, str_notify) {
  screen_message_create(str_msg);

  if(isDefined(str_notify))
    waittill_notify_or_timeout(n_timeout, str_notify);
  else
    wait(n_timeout);

  screen_message_delete();
}

lerp_intensity(n_intensity_final, n_time) {
  n_frames = int(n_time * 20);
  n_intensity_current = self getlightintensity();
  n_intensity_change_total = n_intensity_final - n_intensity_current;
  n_intensity_change_per_frame = n_intensity_change_total / n_frames;

  for(i = 0; i < n_frames; i++) {
    self setlightintensity(n_intensity_current);
    n_intensity_current = n_intensity_current + n_intensity_change_per_frame;
    wait 0.05;
  }

  self setlightintensity(n_intensity_final);
}

blend_exposure_over_time(n_exposure_final, n_time) {
  n_frames = int(n_time * 20);
  n_exposure_current = getdvarfloat(#"r_exposureValue");
  n_exposure_change_total = n_exposure_final - n_exposure_current;
  n_exposure_change_per_frame = n_exposure_change_total / n_frames;
  setdvar("r_exposureTweak", 1);

  for(i = 0; i < n_frames; i++) {
    setdvar("r_exposureValue", n_exposure_current + n_exposure_change_per_frame * i);
    wait 0.05;
  }

  setdvar("r_exposureValue", n_exposure_final);
}

react_scene(str_triggername, str_start_idle, str_react, str_end_idle, str_end_flag) {
  if(isDefined(str_end_flag)) {
    level endon(str_end_flag);
    level thread react_scene_end(str_start_idle, str_react, str_end_idle, str_end_flag);
  }

  if(isDefined(str_start_idle))
    thread run_scene(str_start_idle);

  trigger_wait(str_triggername);
  end_scene(str_start_idle);
  run_scene(str_react, 1);

  if(isDefined(str_end_idle))
    thread run_scene(str_end_idle);
}

react_scene_end(str_start_idle, str_react, str_end_idle, str_end_flag) {
  flag_wait(str_end_flag);

  if(isDefined(str_start_idle))
    delete_scene_all(str_start_idle, 1, 0);

  delete_scene_all(str_react, 1, 0);

  if(isDefined(str_end_idle))
    delete_scene_all(str_end_idle, 1, 0);
}

turn_on_enemy_highlight(guy) {
  if(level.player get_temp_stat(1)) {
    self setclientflag(4);
    self waittill("death");

    if(isDefined(self))
      self clearclientflag(4);
  }
}

autoexec init_node_flags() {
  a_nodes = getallnodes();

  foreach(node in a_nodes) {
    if(isDefined(node.script_flag_wait)) {
      if(!level flag_exists(node.script_flag_wait))
        level flag_init(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_set)) {
      if(!level flag_exists(node.script_flag_set))
        level flag_init(node.script_flag_set);
    }
  }
}

follow_path(nd_path, b_teleport) {
  if(!isDefined(b_teleport))
    b_teleport = 0;

  self endon("death");
  self endon("follow_path_end");
  self thread stop_follow_path("stop_follow_path");
  self notify("stop_going_to_node");
  assert(isDefined(self.targetname), "Must have a targetname to follow a path.");
  str_dont_stop_flag = self.targetname + "_dont_stop";

  if(!level flag_exists(str_dont_stop_flag))
    level flag_init(str_dont_stop_flag);

  if(!self flag_exists("walk_path_pause"))
    self ent_flag_init("walk_path_pause");

  if(isstring(nd_path)) {
    if(isai(self))
      nd_path = getnode(nd_path, "targetname");
    else if(isDefined(self.classname) && self.classname == "script_vehicle")
      nd_path = getvehiclenode(nd_path, "targetname");
  }

  a_path = [];

  while(isDefined(nd_path)) {
    a_path[a_path.size] = nd_path;

    if(isDefined(nd_path.target)) {
      if(isai(self))
        nd_path = getnode(nd_path.target, "targetname");
      else if(isDefined(self.classname) && self.classname == "script_vehicle")
        nd_path = getvehiclenode(nd_path.target, "targetname");

      e_trig = getent(nd_path.targetname, "target");

      if(isDefined(e_trig))
        nd_path thread follow_path_node_trigger_wait(e_trig);
    } else
      break;
  }

  if(isai(self)) {
    self.follow_path_old_forcecolor = self.script_forcecolor;
    disable_ai_color();
  }

  goal_radius = 20;
  max_dist_sq = 640000;
  sprint_dist_sq = 40000;

  if(a_path.size > 0 && b_teleport) {
    if(isai(self))
      self forceteleport(a_path[0].origin, a_path[0].angles);
    else {
      self.origin = a_path[0].origin;
      self.angles = a_path[0].angles;
    }
  }

  foreach(nd_path in a_path) {
    self ent_flag_waitopen("walk_path_pause");

    if(isDefined(self.follow_path_skipto)) {
      if(!isDefined(nd_path.script_noteworthy) || nd_path.script_noteworthy != self.follow_path_skipto)
        continue;
    }

    self.follow_path_skipto = undefined;

    if(isDefined(nd_path.radius) && nd_path.radius != 0)
      self.goalradius = nd_path.radius;
    else
      self.goalradius = goal_radius;

    self notify("new_follow_node", nd_path);
    b_stop = nd_path should_stop_at_goal();

    if(isai(self)) {
      self.disablearrivals = !b_stop;

      if(isDefined(nd_path.script_forcegoal) && nd_path.script_forcegoal) {
        self.perfectaim = 1;
        self force_goal(nd_path);
        self.perfectaim = 0;
      } else
        self set_goal_node(nd_path);

      self.disablearrivals = 0;
    } else if(isDefined(self.classname) && self.classname == "script_vehicle") {
      if(isDefined(nd_path.script_unload) && self.vehicleclass == "helicopter")
        self thread helicopter_unload(nd_path);
      else
        self setvehgoalpos(nd_path.origin, b_stop);

      if(nd_path has_spawnflag(65536) && isDefined(nd_path.angles))
        self settargetyaw(nd_path.angles[1]);
      else
        self cleartargetyaw();

      if(isDefined(nd_path.speed))
        self setspeed(nd_path.speed * 0.0568182);

      if(isDefined(nd_path.radius) && nd_path.radius != 0)
        self setneargoalnotifydist(nd_path.radius);
      else
        self setneargoalnotifydist(50);

      self waittill("near_goal");
    }

    self notify("reached_follow_node", nd_path);
    nd_path thread script_delete(self);

    if(isDefined(nd_path.script_notify))
      self notify(nd_path.script_notify);

    if(isDefined(nd_path.script_ignoreall))
      self set_ignoreall(nd_path.script_ignoreall);

    if(isDefined(nd_path.script_flag_set))
      flag_set(nd_path.script_flag_set);

    if(isDefined(nd_path.script_unload))
      self waittill("unloaded");

    if(nd_path flag_exists("trigger_wait") && !isgodmode(level.player))
      nd_path ent_flag_waitopen("trigger_wait");

    if(isDefined(nd_path.script_aigroup))
      flag_wait_either(nd_path.script_aigroup + "_cleared", str_dont_stop_flag);

    if(isDefined(nd_path.script_flag_wait))
      flag_wait_either(nd_path.script_flag_wait, str_dont_stop_flag);

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_waittill) && nd_path.script_waittill != "look_at")
        level waittill_either(nd_path.script_waittill, str_dont_stop_flag);
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_wait))
        nd_path script_wait();
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_run_scene))
        level run_scene(nd_path.script_run_scene);
    }
  }

  stop_follow_path();
}

should_stop_at_goal() {
  if(flag_exists("trigger_wait") && !ent_flag("trigger_wait"))
    return true;

  if(isDefined(self.script_aigroup) && !flag(self.script_aigroup + "_cleared"))
    return true;

  if(isDefined(self.script_flag_wait) && !flag(self.script_flag_wait))
    return true;

  if(isDefined(self.script_waittill))
    return true;

  if(isDefined(self.script_wait))
    return true;

  if(isDefined(self.script_unload))
    return true;

  return false;
}

helicopter_unload(nd_path) {
  self sethoverparams(0, 0, 10);
  goal = nd_path.origin;
  trace = bullettrace(nd_path.origin, nd_path.origin - vectorscale((0, 0, 1), 10000.0), 0, undefined, 1);

  if(trace["fraction"] <= 1)
    goal = (trace["position"][0], trace["position"][1], trace["position"][2] + self.fastropeoffset);

  drop_offset_tag = "tag_fastrope_ri";

  if(isDefined(self.drop_offset_tag))
    drop_offset_tag = self.drop_offset_tag;

  drop_offset = self gettagorigin("tag_origin") - self gettagorigin(drop_offset_tag);
  goal = goal + (drop_offset[0], drop_offset[1], 0);
  self setvehgoalpos(goal, 1);
  self waittill("near_goal");
  self notify("unload", nd_path.script_unload);
}

stop_follow_path(str_waittill) {
  self endon("death");
  self endon("follow_path_end");

  if(isDefined(str_waittill))
    self waittill(str_waittill);

  if(isai(self)) {
    if(isDefined(self.follow_path_old_forcecolor))
      enable_ai_color();
  }

  self notify("follow_path_end");
}

follow_path_node_trigger_wait(e_trig) {
  self ent_flag_init("trigger_wait", 1);
  e_trig trigger_wait();
  self ent_flag_clear("trigger_wait");
}

take_player_damage_only(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!isplayer(eattacker))
    idamage = 0;

  return idamage;
}

take_player_damage_only_anim_func(ent) {
  ent.overrideactordamage = ::take_player_damage_only;
}

spawn_func_helicopter() {
  target_set(self);

  if(!isDefined(self.script_string) && !isDefined("follow_path") || isDefined(self.script_string) && isDefined("follow_path") && self.script_string == "follow_path")
    self follow_path(self.target, 1);
}

can_see_position(v_pos, req_dot) {
  v_forward = anglestoforward(level.player.angles);
  v_dir = v_pos - level.player.origin;
  v_dir = vectornormalize(v_dir);
  dp = vectordot(v_forward, v_dir);

  if(dp > req_dot) {
    dist = distance(v_pos, level.player.origin);
    return dist;
  }

  return 0;
}

set_level_goal(level_goal, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  e_goal = undefined;

  if(isstring(level_goal)) {
    e_goal = getent(level_goal, str_key);

    if(!isDefined(e_goal))
      e_goal = getstruct(level_goal, str_key);
  } else
    e_goal = level_goal;

  level.level_goal = e_goal;
}

dont_auto_delete() {
  self.b_dont_auto_delete = 1;
}

auto_delete_with_ref() {
  auto_delete(level.level_goal);
}

auto_delete_anim_func(ent) {
  ent auto_delete_with_ref();
}

script_delete(ent) {
  if(isDefined(self.script_delete)) {
    if(self.script_delete == 1) {
      if(isDefined(ent.classname) && ent.classname == "script_vehicle") {
        ent.delete_on_death = 1;
        ent notify("death");

        if(!isalive(ent))
          ent delete();
      } else
        ent delete();
    } else if(self.script_delete == 2)
      ent auto_delete_with_ref();
  }
}

dont_auto_delete_scene(str_scene) {
  array_thread(arraycombine(get_ais_from_scene(str_scene), get_model_or_models_from_scene(str_scene), 1, 0), ::dont_auto_delete);
}

add_effect_to_ent_when_stops_falling(delay, str_ent_targetname, effect, min_wait) {
  e_ai = getent(str_ent_targetname, "targetname");
  e_ai endon("death");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  wait(min_wait);
  last_height = -1000000;

  while(true) {
    height = e_ai.origin[2];

    if(height == last_height) {
      break;
    }

    last_height = height;
    wait 0.2;
  }

  playfx(effect, e_ai.origin);
}

die_behind_player(s_exit) {
  if(!isDefined(level.auto_kill_ai))
    level.auto_kill_ai = [];

  self.auto_kill_position = distance2dsquared(self.origin, s_exit.origin);
  n_index = 0;

  for(i = 0; i < level.auto_kill_ai.size; i++) {
    n_index = i;

    if(self.auto_kill_position >= level.auto_kill_ai[i].auto_kill_position) {
      break;
    }
  }

  arrayinsert(level.auto_kill_ai, self, n_index);
  self waittill("death");

  if(isDefined(self))
    arrayremovevalue(level.auto_kill_ai, self);
  else {
    __new = [];

    foreach(__key, __value in level.auto_kill_ai) {
      if(isDefined(__value)) {
        if(isstring(__key)) {
          __new[__key] = __value;
          continue;
        }

        __new[__new.size] = __value;
      }
    }

    level.auto_kill_ai = __new;
  }
}

kill_behind_player() {
  max_ai = 20;

  if(!isDefined(level.auto_kill_ai))
    level.auto_kill_ai = [];

  while(true) {
    wait 0.05;
    n_ai = level.auto_kill_ai.size;
    n_kill = clamp(n_ai - max_ai, 0, level.auto_kill_ai.size);

    if(n_kill > 0) {
      v_eye = level.player geteye();
      i = 0;

      while(n_kill > 0 && i < level.auto_kill_ai.size) {
        ai = level.auto_kill_ai[i];

        if(isalive(ai) && ai.takedamage && !isDefined(ai.overrideactordamage)) {
          if(ai sightconetrace(v_eye, level.player) < 0.1)
            ai delete();
          else
            ai thread bloody_death();

          n_kill--;
          arrayremoveindex(level.auto_kill_ai, i);
        } else
          i++;
      }
    }
  }
}

auto_ai_cleanup() {
  foreach(ai in getaiarray()) {
    if(!(isDefined(ai.magic_bullet_shield) && ai.magic_bullet_shield))
      ai thread auto_delete_with_ref();
  }
}

fxanim_destruct_until_flag(str_name, str_flag) {
  maps\_fxanim::fxanim_deconstruct(str_name);
  flag_wait(str_flag);
  maps\_fxanim::fxanim_reconstruct(str_name);
}

wipe_volume(str_volume) {
  a_touching_ents = [];
  a_touching_ents = arraycombine(a_touching_ents, getentarray("script_model", "classname"), 0, 0);
  a_touching_ents = arraycombine(a_touching_ents, getspawnerarray(), 0, 0);
  a_touching_ents = arraycombine(a_touching_ents, getaiarray(), 0, 0);
  a_other_ents = [];
  a_other_ents = arraycombine(a_other_ents, getentarray("script_brushmodel", "classname"), 0, 0);
  a_other_ents = arraycombine(a_other_ents, get_triggers(), 0, 0);
  e_cleanup_volume = getent(str_volume, "targetname");
  n_count = 0;

  foreach(ent in a_touching_ents) {
    if(isDefined(ent)) {
      if(!(isDefined(ent.script_convert) && !ent.script_convert) && !(!isDefined(ent.script_noteworthy) && !isDefined("fxanim") || isDefined(ent.script_noteworthy) && isDefined("fxanim") && ent.script_noteworthy == "fxanim") && ent istouching(e_cleanup_volume))
        ent delete();

      n_count++;

      if(n_count >= 5) {
        n_count = 0;
        wait 0.05;
      }
    }
  }

  n_count = 0;

  foreach(ent in a_other_ents) {
    if(isDefined(ent)) {
      if(!(isDefined(ent.script_convert) && !ent.script_convert) && !(!isDefined(ent.script_noteworthy) && !isDefined("fxanim") || isDefined(ent.script_noteworthy) && isDefined("fxanim") && ent.script_noteworthy == "fxanim") && is_point_inside_volume(ent.origin, e_cleanup_volume))
        ent delete();

      n_count++;

      if(n_count >= 5) {
        n_count = 0;
        wait 0.05;
      }
    }
  }
}

defalco_marker_think() {
  s_start_position = getstruct("defalco_marker_start", "targetname");

  if(level.skipto_point == "Sundeck")
    s_start_position = getstruct("defalco_marker_start2", "script_noteworthy");

  s_target_position = getstruct(s_start_position.target, "targetname");
  level.fake_defalco = spawn_model("tag_origin", s_start_position.origin);
  level.fake_defalco.script_convert = 0;
  s_start_position = undefined;
  set_objective(level.obj_stop_defalco, level.fake_defalco);

  do {
    n_speed_scale = distance2dsquared(level.player.origin, level.fake_defalco.origin) / (4096 * 4096);
    n_speed_scale = min(max(n_speed_scale, 0), 1.0);
    n_speed_current = 288 - n_speed_scale * 224;
    v_vec_to_target = vectornormalize(s_target_position.origin - level.fake_defalco.origin) * (n_speed_current / 20);
    v_target_position = level.fake_defalco.origin + v_vec_to_target;
    level.fake_defalco moveto(v_target_position, 0.05, 0, 0);

    if(distancesquared(level.fake_defalco.origin, s_target_position.origin) <= 64) {
      if(isDefined(s_target_position.target))
        s_target_position = getstruct(s_target_position.target, "targetname");
      else
        s_target_position = undefined;
    }

    wait 0.05;
  }
  while(isDefined(s_target_position));
}