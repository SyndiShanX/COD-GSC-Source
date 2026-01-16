/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_skipto;
#include maps\_scene;
#include maps\_anim;
#include maps\angola_jungle_stealth_carry;
#include maps\_dialog;
#include maps\angola_river;
#include maps\angola_barge;
#include maps\angola_jungle_stealth;
#include maps\angola_village;
#include maps\angola_jungle_escape;
#include maps\_turret;
#include maps\_grenade_toss;
#include maps\_stealth_logic;
#include maps\_patrol;
#include maps\_fxanim;

level_init_flags() {
  flag_init("show_introscreen_title");
  maps\angola_river::init_flags();
  maps\angola_barge::init_flags();
  maps\angola_jungle_stealth::init_flags();
  maps\angola_village::init_flags();
  maps\angola_jungle_escape::init_flags();
}

skipto_setup() {
  skipto = level.skipto_point;

  if(skipto == "riverbed") {
    return;
  }
  if(skipto == "savannah") {
    return;
  }
  if(skipto == "river") {
    return;
  }
  if(skipto == "jungle_stealth") {
    return;
  }
  if(skipto == "village") {
    return;
  }
  if(skipto == "jungle_escape") {
    return;
  }
  if(skipto == "jungle_ending")
    return;
}

setup_objectives() {
  level.obj_secure_the_barge = register_objective(&"ANGOLA_2_SECURE_THE_BARGE");
  level.obj_find_woods = register_objective(&"ANGOLA_2_SEARCH_WOODS_TRUCK");
  level.obj_destroy_hind = register_objective(&"ANGOLA_2_TAKE_OUT_HIND");
  level.obj_refill_ammo = register_objective("");
  level.obj_escape_jungle = register_objective(&"ANGOLA_2_ESCAPE_JUNGLE");
  level.obj_radio_for_extraction = register_objective(&"ANGOLA_2_RADIO_FOR_EXTRACTION");
  level.obj_dont_get_discovered = register_objective(&"ANGOLA_2_DONT_GET_DISCOVERED");
  level.obj_find_radio = register_objective(&"ANGOLA_2_FIND_RADIO");
  level.obj_mason_goto_hut_window = register_objective(&"ANGOLA_2_APPROACH_HUT_WINDOW");
  level.obj_mason_grab_menendez = register_objective(&"ANGOLA_2_OVERPOWER_RADIO_OP");
  level.obj_interact = register_objective(&"");
  level.obj_mason_exit_village_enter_forest = register_objective(&"ANGOLA_2_EXIT_INTO_FOREST");
  level.obj_battle_forest_1 = register_objective(&"ANGOLA_2_DEFEND_POSITION");
  level.obj_protect_hudson_and_woods_on_way_to_beach = register_objective(&"ANGOLA_2_FALL_BACK_TO_RIVER");
  level.obj_battle_forest_2 = register_objective(&"ANGOLA_2_DEFEND_POSITION");
  level.obj_battle_forest_3 = register_objective(&"ANGOLA_2_DEFEND_POSITION");
  level.obj_hudson_moves_to_beach_evac = register_objective(&"ANGOLA_2_FALL_BACK_TO_RIVER");
  level.obj_tall_grass_stealth = register_objective(&"");
  level.obj_intruder = register_objective(&"");
  level.obj_brute_force = register_objective("");
}

add_cleanup_ent(str_category, e_add) {
  if(!isDefined(level.a_e_cleanup))
    level.a_e_cleanup = [];

  if(!isDefined(level.a_e_cleanup[str_category]))
    level.a_e_cleanup[str_category] = [];

  level.a_e_cleanup[str_category][level.a_e_cleanup[str_category].size] = e_add;
}

cleanup_ents(str_category) {
  if(isDefined(level.a_e_cleanup) && isDefined(level.a_e_cleanup[str_category])) {
    foreach(ent in level.a_e_cleanup[str_category]) {
      if(isDefined(ent))
        ent delete();
    }

    level.a_e_cleanup[str_category] = undefined;
  }
}

spawner_set_cleanup_category(str_category) {
  add_cleanup_ent(str_category, self);
}

multiple_trigger_waits(str_trigger_name, str_trigger_notify) {
  a_triggers = getentarray(str_trigger_name, "targetname");

  for(i = 0; i < a_triggers.size; i++)
    a_triggers[i] thread multiple_trigger_wait(str_trigger_notify);
}

multiple_trigger_wait(str_trigger_notify) {
  level endon(str_trigger_notify);
  self waittill("trigger");
  level notify(str_trigger_notify);
}

simple_spawn_script_delay(a_ents, spawn_fn, param1, param2, param3, param4, param5) {
  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i];

    if(isDefined(e_ent.script_delay)) {
      level thread spawn_with_delay(e_ent.script_delay, e_ent, spawn_fn, param1, param2, param3, param4, param5);
      continue;
    }

    e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5, 1);

    if(isDefined(e_ent.script_health))
      e_ai.health = e_ent.script_health;

    if(isDefined(e_ent.script_int))
      e_ai thread ai_turn_of_hold_node_after_time(e_ent.script_int);

    if(isDefined(e_ent.script_float))
      e_ai.accuracy = e_ent.script_float;
  }
}

spawn_with_delay(delay, e_ent, spawn_fn, param1, param2, param3, param4, param5) {
  wait(delay);
  e_ai = simple_spawn_single(e_ent, spawn_fn, param1, param2, param3, param4, param5);

  if(isDefined(e_ai)) {
    if(isDefined(e_ent.script_health))
      e_ai.health = e_ent.script_health;

    if(isDefined(e_ent.script_int))
      e_ai thread ai_turn_of_hold_node_after_time(e_ent.script_int);

    if(isDefined(e_ent.script_float))
      e_ai.accuracy = e_ent.script_float;
  }
}

ai_turn_of_hold_node_after_time(delay) {
  self endon("death");
  wait(delay);
  self.fixednode = 0;
}

spawn_fn_ai_run_to_target(player_favourate_enemy, str_cleanup_category, aggressive_mode, disable_grenades, ignore_me) {
  self endon("death");

  if(isDefined(ignore_me) && ignore_me == 1)
    self.ignoreme = 1;

  if(isDefined(str_cleanup_category)) {
    spawner_set_cleanup_category(str_cleanup_category);
    str_cleanup_category = undefined;
  }

  if(isDefined(level.jungle_escape_accuracy))
    self.script_accuracy = level.jungle_escape_accuracy;

  self.goalradius = 48;
  self.goalheight = 256;
  self waittill("goal");
  self.aggressivemode = aggressive_mode;
  self.goalradius = 2048;
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, 0, disable_grenades);
}

entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  if(isDefined(player_favourate_enemy) && player_favourate_enemy != 0)
    self.favoriteenemy = level.player;

  if(isDefined(str_cleanup_category))
    spawner_set_cleanup_category(str_cleanup_category);

  if(isDefined(ignore_surpression) && ignore_surpression != 0)
    self.script_ignore_suppression = 1;

  if(isDefined(disable_grenades) && disable_grenades != 0) {
    self.grenadeammo = 0;

    if(isDefined(level.jungle_escape_accuracy))
      self.script_accuracy = level.jungle_escape_accuracy;
    else
      self.script_accuracy = 1.0;
  }

  self.overrideactordamage = ::enemy_damage_override;
}

spawn_fn_ai_run_to_holding_node(player_favourate_enemy, str_cleanup_category, break_hold_time, disable_grenades, ignore_me) {
  if(isDefined(level.jungle_escape_accuracy))
    self.script_accuracy = level.jungle_escape_accuracy;

  self.goalradius = 48;
  self waittill("goal");
  self.fixednode = 1;
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, 0, disable_grenades);

  if(isDefined(ignore_me) && ignore_me == 1)
    self.ignoreme = 1;

  if(isDefined(break_hold_time))
    self thread ai_break_holding_node_timer(break_hold_time);
}

ai_break_holding_node_timer(break_hold_time) {
  self endon("death");
  wait(break_hold_time);
  self.fixednode = 0;

  if(isDefined(self.script_string)) {
    nd_node = getnode(self.script_string, "targetname");
    self.goalradius = 48;
    self setgoalnode(nd_node);
    self waittill("goal");
  }

  self.goalradius = 2048;
}

spawn_fn_ai_run_to_node_and_die(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades) {
  if(isDefined(self.script_int) && self.script_int > 0) {
    self.animname = "misc_patrol";
    self set_run_anim("walk");
  }

  self.ignoreall = 1;
  self.goalradius = 48;
  self waittill("goal");
  self entity_common_spawn_setup(player_favourate_enemy, str_cleanup_category, ignore_surpression, disable_grenades);

  if(isDefined(self.target)) {
    nd_node = getnode(self.target, "targetname");

    while(isDefined(nd_node.target)) {
      nd_node = getnode(nd_node.target, "targetname");

      for(dist = distance(self.origin, nd_node.origin); dist > 48; dist = distance(self.origin, nd_node.origin)) {
        self setgoalpos(nd_node.origin);
        self.goalradius = 48;
        wait 0.01;
      }
    }
  }

  self delete();
}

player_rusher(str_category, delay, breakoff_distance, npc_damage_scale, npc_damage_scale_breakoff, disable_pain) {
  self endon("death");

  if(isDefined(delay))
    wait(delay);

  self entity_common_spawn_setup(0, str_category, 1, 1);

  if(isDefined(disable_pain) && disable_pain != 0)
    self disable_pain();

  player = get_players()[0];
  self change_movemode("sprint");
  self.overrideactordamage = ::enemy_damage_override;
  self.npc_damage_scale = npc_damage_scale;
  self.npc_damage_scale_breakoff = npc_damage_scale_breakoff;

  while(true) {
    self setgoalpos(player.origin);
    self set_goalradius(24);
    wait 0.2;
    dist = distance(player.origin, self.origin);

    if(dist < breakoff_distance) {
      self.npc_damage_scale = self.npc_damage_scale_breakoff;
      self change_movemode("run");
      self.ignoresuppression = 0;
      self.ignoreall = 0;
      self enable_pain();
      self set_goalradius(2048);
      self setgoalpos(self.origin);
      return;
    }
  }
}

player_rusher_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(self.npc_damage_scale)) {
    if(isDefined(e_inflictor) && e_inflictor != level.player)
      n_damage = int(n_damage * self.npc_damage_scale);
  }

  return n_damage;
}

enemy_ai_keep_your_distance(keep_away) {
  ai = getaiarray("axis");

  if(isDefined(ai)) {
    for(i = 0; i < ai.size; i++) {
      e_ent = ai[i];

      if(keep_away) {
        e_ent.a.disablereacquire = 1;
        continue;
      }

      e_ent.a.disablereacquire = 0;
    }
  }
}

enemy_ai_disable_grenades(disable_grenades) {
  ai = getaiarray("axis");

  if(isDefined(ai)) {
    for(i = 0; i < ai.size; i++) {
      e_ent = ai[i];

      if(disable_grenades) {
        e_ent.temp_grenade_num = e_ent.grenadeammo;
        e_ent.grenadeammo = 0;
        continue;
      }

      if(isDefined(e_ent.temp_grenade_num))
        e_ent.grenadeammo = e_ent.temp_grenade_num;
    }
  }
}

ai_set_enemy_fight_distance(e_enemy, path_distance, skip_launchers) {
  ai = getaiarray("axis");

  if(isDefined(ai)) {
    for(i = 0; i < ai.size; i++) {
      e_ent = ai[i];

      if(isDefined(skip_launchers) && skip_launchers == 1 && ent_is_launcher(e_ent)) {
        continue;
      }
      if(isDefined(e_enemy))
        e_ent setgoalentity(e_enemy);
      else
        e_ent setgoalentity(e_ent);

      e_ent.pathenemyfightdist = path_distance;
    }
  }
}

ent_is_launcher(e_spawner) {
  if(isDefined(e_spawner.classname)) {
    if(issubstr(e_spawner.classname, "_Launcher_"))
      return true;
  }

  return false;
}

wait_time_and_enemies(min_time, max_time, min_enemies, str_notify) {
  start_time = gettime();
  wait(min_time);

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= max_time) {
      break;
    }

    if(isDefined(min_enemies)) {
      num_axis = getaiarray("axis").size;

      if(num_axis <= min_enemies) {
        break;
      }
    }

    wait 0.01;
  }

  level notify(str_notify);
}

trigger_wait_or_time(trigger_targetname, time) {
  trigger = getent(trigger_targetname, "targetname");
  trigger endon("trigger");
  wait(time);
}

simple_spawn_rusher_single(str_rusher_spawner_targetname, str_category, rusher_distance) {
  sp_rusher = getent(str_rusher_spawner_targetname, "targetname");

  if(isDefined(sp_rusher))
    process_rusher_spawner(sp_rusher, str_category, rusher_distance);
}

simple_spawn_rusher(str_rusher_spawner_targetname, str_category, rusher_distance) {
  a_sp_rusher = getentarray(str_rusher_spawner_targetname, "targetname");

  if(isDefined(a_sp_rusher)) {
    for(i = 0; i < a_sp_rusher.size; i++)
      level thread process_rusher_spawner(a_sp_rusher[i], str_category, rusher_distance);
  }
}

process_rusher_spawner(sp_rusher, str_category, rusher_distance) {
  if(isDefined(sp_rusher.script_delay))
    wait(sp_rusher.script_delay);

  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread player_rusher(str_category, undefined, rusher_distance, 0.02, 0.1, 1);
}

ai_run_along_node_array(str_ai_targetname, a_str_nodes, ignore_all, teleport_to_start_node, str_walk_mode) {
  level endon("stealth_broken");
  s_spawner = getent(str_ai_targetname, "targetname");

  if(isDefined(s_spawner.script_delay))
    delay = s_spawner.script_delay;
  else
    delay = 0;

  if(delay > 0)
    wait(delay);

  e_ai = simple_spawn_single(str_ai_targetname);

  if(isDefined(ignore_all) && ignore_all == 1)
    e_ai.ignoreall = 1;

  wait 0.1;

  if(!isDefined(e_ai)) {
    iprintlnbold("Not enough AI slots");
    return;
  }

  e_ai.disablearrivals = 1;
  e_ai.disableexits = 1;

  if(isDefined(teleport_to_start_node) && teleport_to_start_node == 1) {
    n_node = getnode(a_str_nodes[0], "targetname");
    e_ai forceteleport(n_node.origin, e_ai.angles);
    start_index = 1;
  } else
    start_index = 0;

  wait 0.01;

  for(i = start_index; i < a_str_nodes.size; i++) {
    n_node = getnode(a_str_nodes[i], "targetname");
    e_ai setgoalnode(n_node);
    e_ai.goalradius = 64;
    e_ai waittill("goal");
  }

  e_ai delete();
}

mission_fail_if_not_inside_info_volumes(str_info_targetname, str_end_notify, fail_mission_delay, fail_mission_flag, str_fail_enemy_spawners, b_kill_player) {
  level endon(str_end_notify);
  a_volumes = getentarray(str_info_targetname, "targetname");

  if(!isDefined(a_volumes)) {
    return;
  }
  while(true) {
    player_is_safe = 0;

    for(i = 0; i < a_volumes.size; i++) {
      e_vol = a_volumes[i];

      if(level.player istouching(e_vol))
        player_is_safe = 1;
    }

    if(player_is_safe == 0 || flag("js_player_fails_stealth")) {
      flag_set("js_player_fails_stealth");
      level notify("kill_in_cover_checks");

      if(isDefined(fail_mission_flag))
        flag_set(fail_mission_flag);

      if(isDefined(str_fail_enemy_spawners))
        level thread spawn_in_stealth_failure_guards(str_fail_enemy_spawners);

      if(isDefined(b_kill_player) && b_kill_player) {
        level.player disableinvulnerability();
        level.player enablehealthshield(1);
      }

      if(isDefined(fail_mission_delay))
        wait(fail_mission_delay);

      missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
      return;
    }

    wait 0.05;
  }
}

kill_player_if_standing_inside_volume(str_volume, str_endon, fail_mission_delay, str_fail_enemy_spawners) {
  level endon(str_endon);
  e_volume = getent(str_volume, "targetname");

  while(true) {
    if(level.player istouching(e_volume)) {
      if(!is_mason_stealth_crouched()) {
        level notify("kill_in_cover_checks");

        if(isDefined(str_fail_enemy_spawners))
          level thread spawn_in_stealth_failure_guards(str_fail_enemy_spawners);

        if(isDefined(fail_mission_delay))
          wait(fail_mission_delay);

        missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
        return;
      }
    }

    wait 0.01;
  }
}

fail_mission_if_not_in_crouch_cover(str_endon_notify, delay_fail_time, allow_stance_time, nag_crouch_time) {
  level endon(str_endon_notify);
  level endon("kill_in_cover_checks");
  start_time = gettime();
  last_crouched_time = start_time;
  nag_additional_time = 0;

  while(true) {
    time = gettime();

    if(is_mason_stealth_crouched()) {
      last_crouched_time = time;
      nag_crouch_time = undefined;
    } else {
      time_standing = (time - last_crouched_time) / 1000;

      if(time_standing > allow_stance_time) {
        dt = (time - start_time) / 1000;
        dt = dt - nag_additional_time;

        if(dt > delay_fail_time) {
          if(isDefined(nag_crouch_time)) {
            nag_additional_time = nag_crouch_time;
            nag_crouch_time = undefined;
            continue;
          }

          flag_set("js_player_fails_stealth");
          wait 0.5;
          return;
        }
      }
    }

    wait 0.01;
  }
}

spawn_in_stealth_failure_guards(str_fail_enemy_spawners) {
  a_spawners = getentarray(str_fail_enemy_spawners, "targetname");

  if(isDefined(a_spawners)) {
    for(i = 0; i < a_spawners.size; i++) {
      e_enemy = simple_spawn_single(a_spawners[i]);

      if(isDefined(a_spawners[i].target))
        nd_node = getnode(a_spawners[i].target, "targetname");
      else
        nd_node = undefined;

      if(!issubstr(e_enemy.classname, "child"))
        e_enemy thread ai_force_fire_at_target(undefined, level.player, undefined, undefined, nd_node);
    }
  }
}

ai_force_fire_at_target(str_scene, e_target, fire_burst, fire_time, nd_node) {
  self endon("death");

  if(isDefined(str_scene))
    end_scene(str_scene);

  if(!isDefined(e_target))
    e_target = level.player;

  if(!isDefined(fire_burst))
    fire_burts = 0.2;

  if(!isDefined(fire_time))
    fire_time = 10.0;

  self.ignoreall = 1;
  self.favoriteenemy = e_target;
  self.script_ignore_suppression = 1;
  self thread aim_at_target(e_target);
  self thread shoot_at_target(e_target, undefined, fire_burst, fire_time);

  if(isDefined(nd_node)) {
    self.goalradius = 64;
    self setgoalnode(nd_node);
  }
}

fire_weapon_on_target(target) {
  self endon("death");
  guards_1 = simple_spawn_single("river_barge_convoy_2_guards_assault");
  guards_1 enter_vehicle(self, "tag_gunner1");
  guards_1.animname = "chase_boat_gunner_front";
  self maps\_turret::set_turret_target(target, vectorscale((0, 0, 1), 40.0), 1);
  self.gunner_alive = guards_1;

  while(isalive(self)) {
    if(!isalive(guards_1)) {
      self maps\_turret::stop_turret(1);
      wait 10;
      guards_1 = simple_spawn_single("river_barge_convoy_2_guards_assault");
      guards_1 enter_vehicle(self, "tag_gunner1");
      guards_1.animname = "chase_boat_gunner_front";
      self.gunner_alive = guards_1;
    }

    self thread maps\_turret::fire_turret_for_time(2, 1);
    wait 2;
  }
}

play_damage_fx_on_chase_boat() {
  self endon("death");
  self waittill("damage");
  playfxontag(level._effect["small_boat_damage_1"], self, "tag_origin");

  while(true) {
    if(self.health < 300) {
      break;
    }

    wait 0.1;
  }

  playfxontag(level._effect["small_boat_damage_2"], self, "tag_origin");
}

hmg_boat_challenge_tracking() {
  self waittill("death", attacker);

  if(!isDefined(attacker)) {
    return;
  }
  if(attacker == level.player) {
    boat_occupant = level.escort_boat getseatoccupant(2);

    if(isDefined(boat_occupant) && boat_occupant == level.player) {
      if(!isDefined(level.challenge_hmg_boat_destroy))
        level.challenge_hmg_boat_destroy = 0;

      level.challenge_hmg_boat_destroy++;
    }
  }
}

escort_boat_challenge_tracking() {
  self waittill("death", attacker);

  if(!isDefined(attacker)) {
    return;
  }
  if(attacker == level.player) {
    if(!isDefined(level.challenge_escort_boat_destroy))
      level.challenge_escort_boat_destroy = 0;

    level.challenge_escort_boat_destroy++;
  }
}

helper_message(message, delay, str_abort_flag) {
  if(isDefined(level.helper_message))
    screen_message_delete();

  level notify("kill_helper_message");
  level endon("kill_helper_message");
  level.helper_message = message;
  screen_message_create(message);

  if(!isDefined(delay))
    delay = 5;

  start_time = gettime();

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= delay) {
      break;
    }

    if(isDefined(str_abort_flag) && flag(str_abort_flag) == 1) {
      break;
    }

    wait 0.01;
  }

  if(isDefined(level.helper_message))
    screen_message_delete();

  level.helper_message = undefined;
}

switch_to_pistol() {
  a_weapon_list = level.player getweaponslist();

  foreach(str_weapon in a_weapon_list) {
    if(str_weapon == "browninghp_sp") {
      level.player switchtoweapon(str_weapon);
      return;
    }
  }

  level.player giveweapon("browninghp_sp");
  level.player switchtoweapon("browninghp_sp");
  flag_wait("mason_ready_to_grab_menendez");
  level.player takeweapon("browninghp_sp");
}

hudson_throw_smoke_grenade(org_targetname, throw_at_pos) {
  self endon("death");
  og_grenadeweapon = undefined;
  org = undefined;
  og_grenadeweapon = self.grenadeweapon;
  self.grenadeweapon = "willy_pete_80s_sp";
  self.grenadeammo++;
  throw_tag = "tag_inhand";
  self.force_grenade_throw_tag = throw_tag;
  self.force_grenade_pos = throw_at_pos;
  self.force_grenade_explod_time = 2.0;
  maps\_anim::addnotetrack_customfunction(self.animname, "grenade_right", ::spawn_prop_grenade, "ch_ang_10_01_smoke_throw_hudson");
  maps\_anim::addnotetrack_customfunction(self.animname, "grenade_throw", maps\_grenade_toss::force_grenade_toss_internal, "ch_ang_10_01_smoke_throw_hudson");
  maps\_anim::addnotetrack_customfunction(self.animname, "grenade_throw", ::hudson_notify_grenade_throw, "ch_ang_10_01_smoke_throw_hudson");

  if(isDefined(org_targetname))
    org = getstruct(org_targetname, "targetname");

  if(!isDefined(org))
    org = self;

  old_grenadeawareness = self.grenadeawareness;
  self set_ignoreall(1);
  self.grenadeawareness = 0;
  org maps\_anim::anim_reach_aligned(self, "ch_ang_10_01_smoke_throw_hudson");
  org maps\_anim::anim_single_aligned(self, "ch_ang_10_01_smoke_throw_hudson");
  self set_ignoreall(0);
  self.grenadeawareness = old_grenadeawareness;
  self notify("hudson_threw_smoke_grenade");

  if(isDefined(og_grenadeweapon))
    self.grenadeweapon = og_grenadeweapon;
}

spawn_prop_grenade(guy) {
  grenade = spawn_model("t6_wpn_grenade_smoke_world", guy gettagorigin("tag_inhand"), guy gettagangles("tag_inhand"));
  grenade linkto(guy, "tag_inhand");
  guy.grenade_ref = grenade;
}

hudson_notify_grenade_throw(guy) {
  if(isDefined(guy.grenade_ref)) {
    guy.grenade_ref unlink();
    guy.grenade_ref delete();
    guy.grenade_ref = undefined;
  }

  guy notify("hudson_throwing_smoke");
}

setup_mason_protect_nag_distances(nag_ent, nag_distance, nag1_time, nag2_time, nag3_time, nag1_message, nag2_message, nag3_message) {
  level.mason_protect_ent = nag_ent;
  level.mason_protect_dist = nag_distance;
  level.mason_protect_nag1_time = nag1_time;
  level.mason_protect_nag2_time = nag2_time;
  level.mason_protect_nag3_time = nag3_time;
}

mason_protect_nag_think(nag_ent, nag_distance, nag1_time, nag2_time, nag3_time, nag_lines) {
  level notify("mason_protect_nag_end");
  level endon("mason_protect_nag_end");
  setup_mason_protect_nag_distances(nag_ent, nag_distance, nag1_time, nag2_time, nag3_time);
  level.mason_protect_ent endon("death");
  safe_time = gettime();
  nag1 = 0;
  nag2 = 0;
  nag3 = 0;

  while(true) {
    time = gettime();
    dist = distance(level.player.origin, level.mason_protect_ent.origin);

    if(dist > level.mason_protect_dist) {
      dt = (time - safe_time) / 1000;

      if(nag1 == 0 && dt > level.mason_protect_nag1_time) {
        nag1 = 1;
        level.ai_hudson say_dialog(nag_lines[randomint(nag_lines.size)]);
      }

      if(nag2 == 0 && dt > level.mason_protect_nag2_time) {
        nag2 = 1;
        level.ai_hudson say_dialog(nag_lines[randomint(nag_lines.size)]);
      }

      if(nag3 == 0 && dt > level.mason_protect_nag3_time) {
        nag3 = 1;
        level.ai_hudson say_dialog(nag_lines[randomint(nag_lines.size)]);
        return;
      }
    } else {
      safe_time = time;
      nag1 = 0;
      nag2 = 0;
      nag3 = 0;
    }

    wait 0.1;
  }
}

fire_angola_mortar(v_start, v_dest, speed_scale, height_scale, randomize_target_radius) {
  e_missile = spawn("script_model", v_start);
  e_missile setmodel("t6_wpn_mortar_shell_prop_view");
  e_missile playsound("prj_mortar_launch");
  playfxontag(level._effect["smoketrail"], e_missile, "tag_origin");

  if(isDefined(randomize_target_radius)) {
    dx = randomfloatrange(-1 * randomize_target_radius, randomize_target_radius);
    dy = randomfloatrange(-1 * randomize_target_radius, randomize_target_radius);
    v_dest = v_dest + (dx, dy, 0);
  }

  speed = 1680;

  if(isDefined(speed_scale))
    speed = speed * speed_scale;

  min_height = 126;
  max_height = 1092;
  height = max_height;
  dz = (e_missile.origin[2] - v_dest[2]) / 100;
  height = height - dz * 16;

  if(height < min_height)
    height = min_height;

  if(isDefined(height_scale))
    height = height * height_scale;

  e_missile thread angola_mortor_move(v_dest, speed, height);
  e_missile waittill("mortor_strike");
  playfx(level._effect["def_explosion"], e_missile.origin);
  radiusdamage(e_missile.origin, 672, 15, 3);
  earthquake(0.6, 1.2, e_missile.origin, 3000);
  e_missile playsound("exp_mortar");
  e_missile delete();
  level notify("angola_mortar_impact");
}

angola_mortor_move(target_position, speed, height) {
  self endon("death");
  start_position = self.origin;
  start_time = gettime() / 1000;
  dist_travelled = 0;
  total_dist = (self.origin[0] - target_position[0]) * (self.origin[0] - target_position[0]) + (self.origin[1] - target_position[1]) * (self.origin[1] - target_position[1]) + (self.origin[2] - target_position[2]) * (self.origin[2] - target_position[2]);
  total_dist = sqrt(total_dist);
  dir = vectornormalize(target_position - self.origin);
  last_time = start_time;
  last_pos = self.origin;
  frac = 0.0;
  last_frac = 0.0;
  audio_incomming_played = 0;

  while(dist_travelled < total_dist) {
    wait 0.01;
    time = gettime() / 1000;
    dt = time - last_time;
    last_time = time;
    slow_start = 0.38;
    slow_mid = 0.55;
    slow_end = 0.75;
    slow_amount = speed * 0.45;
    end_speedup = speed * 3.0;

    if(last_frac < slow_start)
      current_speed = speed;
    else if(last_frac >= slow_start && last_frac <= slow_mid) {
      mag = slow_mid - slow_start;
      diff_frac = 1.0 - (slow_mid - last_frac) / mag;
      current_speed = speed - slow_amount * diff_frac;
    } else if(last_frac > slow_mid && last_frac <= slow_end) {
      mag = slow_end - slow_mid;
      diff_frac = (slow_end - last_frac) / mag;
      current_speed = speed - slow_amount * diff_frac;
    } else {
      mag = 1.0 - slow_end;
      diff_frac = 1.0 - (1.0 - last_frac) / mag;
      current_speed = speed + end_speedup * diff_frac;
    }

    inc = dt * current_speed;
    add_vec = (dir[0] * inc, dir[1] * inc, dir[2] * inc);
    missile_height = self.origin[2] + dir[2] * inc;
    missile_pos = self.origin + add_vec;
    dist_travelled = dist_travelled + inc;
    last_frac = frac;
    frac = dist_travelled / total_dist;

    if(frac > 1.0)
      frac = 1.0;

    angle = 180 * frac;
    sinx = sin(angle);
    height_offset = height * sinx;
    base_height = start_position[2] + (target_position[2] - start_position[2]) * frac;
    self.origin = (missile_pos[0], missile_pos[1], base_height + height_offset);
    self.angles = vectortoangles(self.origin - last_pos);
    last_pos = self.origin;

    if(!audio_incomming_played && frac > 0.8) {
      self playsound("prj_mortar_incoming");
      audio_incomming_played = 1;
    }
  }

  self notify("mortor_strike");
}

background_soldier_anims_alert_timeout(str_patrol_anim, str_alerted_anim, str_begin_flag, str_end_flag, fail_timeout, alerted_timeout) {
  flag_wait(str_begin_flag);
  level thread run_scene(str_patrol_anim);
  wait(fail_timeout);
  end_scene(str_patrol_anim);

  if(flag(str_end_flag) == 0) {
    level thread run_scene(str_alerted_anim);
    wait(alerted_timeout);
    missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
  }
}

blackscreen(fadein, stay, fadeout) {
  blackscreen = newhudelem();
  blackscreen.alpha = 0;
  blackscreen.horzalign = "fullscreen";
  blackscreen.vertalign = "fullscreen";
  blackscreen setshader("black", 640, 480);

  if(fadein > 0)
    blackscreen fadeovertime(fadein);

  blackscreen.alpha = 1;
  wait(stay);

  if(fadeout > 0)
    blackscreen fadeovertime(fadeout);

  blackscreen.alpha = 0;
  blackscreen destroy();
}

make_all_enemy_aggressive(follow_player) {
  a_ai = getaiarray("axis");

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++) {
      e_ent = a_ai[i];
      e_ent.aggressivemode = 1;

      if(isDefined(follow_player) && follow_player == 1) {
        e_ent.pathenemyfightdist = 1000;
        e_ent setgoalentity(level.player);
      }
    }
  }
}

enemy_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(self.npc_damage_scale)) {
    if(isDefined(e_inflictor) && e_inflictor != level.player)
      n_damage = int(n_damage * self.npc_damage_scale);
  }

  return n_damage;
}

global_actor_killed_callback(e_inflictor, e_attacker, n_damage, str_means_of_death, str_weapon, v_dir, str_hit_loc, timeoffset) {
  if(self.team == "axis") {
    if(flag("player_on_sniper_tree")) {
      if(isDefined(e_inflictor) && e_inflictor == level.player) {
        a_sniper_rifle_names = array("as50", "ballista", "barretm82", "dragunov", "dsr50", "svu");
        a_string_tokens = strtok(str_weapon, "_");

        foreach(str_token in a_string_tokens) {
          if(isinarray(a_sniper_rifle_names, str_token))
            level notify("sniper_tree_kill");
        }
      }
    }
  }

  if(e_attacker == level.player) {
    if(str_weapon == "machete_sp")
      level.player notify(level.machete_notify);
    else if(str_weapon == "mortar_shell_dpad_sp") {
      level.mortar_kills++;

      if(level.mortar_kills == 1)
        level thread mortar_kill_timer();
    }
  }
}

mortar_kill_timer() {
  wait 0.3;

  if(level.mortar_kills > 4)
    flag_set("mortar_challenge_complete");
  else
    level.mortar_kills = 0;
}

linkto_trigger_on() {
  self.origin = self.origin + vectorscale((0, 0, 1), 10000.0);
}

linkto_trigger_off() {
  self.origin = self.origin + vectorscale((0, 0, -1), 10000.0);
}

lookat_trigger_while_not_in_trigger(triggername) {
  lookat_trigger = getent(triggername, "targetname");

  while(true) {
    lookat_trigger waittill("trigger");

    if(!level.player istouching(lookat_trigger)) {
      return;
    }
    wait 0.05;
  }
}

swap_to_primary_weapon(str_use_primary_if_none_exists) {
  primary_weapons = self getweaponslistprimaries();

  if(isDefined(primary_weapons) && primary_weapons.size > 0)
    self switchtoweapon(primary_weapons[0]);
  else if(isDefined(str_use_primary_if_none_exists)) {
    self giveweapon(str_use_primary_if_none_exists);
    self switchtoweapon(str_use_primary_if_none_exists);
  }
}

s3_player_fail(str_location, fail_mission_delay) {
  flag_set("player_failing_stealth");
  battlechatter_on("axis");
  level.player endon("death");
  onsaverestored_callback(::s3_checkpoint_save_restored);
  self disableinvulnerability();
  self enablehealthshield(0);
  self.overrideplayerdamage = ::s3_fail_player_damage_override;
  level.ai_hudson change_movemode();

  if(isDefined(fail_mission_delay)) {
    wait(fail_mission_delay);
    missionfailedwrapper();
  }
}

s3_checkpoint_save_restored() {
  level.ai_hudson = init_hero("hudson");
}

stealth_safe_to_save() {
  failure_flags = [];
  failure_flags[0] = "child_guards_alerted";
  failure_flags[1] = "fail_after_log";
  failure_flags[2] = "fail_before_log";
  failure_flags[3] = "_stealth_spotted";
  failure_flags[4] = "js_player_fails_stealth";
  failure_flags[5] = "fail_beach";
  failure_flags[6] = "player_failing_stealth";

  foreach(msg in failure_flags) {
    if(flag(msg))
      return false;
  }

  return true;
}

s3_fail_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  n_damage = n_damage * 2;
  return n_damage;
}

patroller_logic(str_start_node, use_cqb_walk, is_fxanim_grass_user) {
  self endon("death");
  self.patroller_delete_on_path_end = 1;
  self.script_no_threat_update_on_first_frame = 1;
  self.script_noenemyinfo = 1;
  self.script_no_threat_on_spawn = 1;

  if(isDefined(use_cqb_walk) && use_cqb_walk)
    self change_movemode("cqb_walk");

  if(isDefined(is_fxanim_grass_user) && is_fxanim_grass_user)
    self thread fxanim_grass_enemy_logic();

  self thread maps\_stealth_logic::stealth_ai();
  self thread maps\_patrol::patrol(str_start_node);
}

fxanim_grass() {
  flag_init("fxanim_grass_ready");
  flag_init("fxanim_grass_spawn");
  flag_init("start_fxanim_grass_house");
  flag_init("start_fxanim_grass_middle");
  flag_init("start_fxanim_grass_end");
  a_fxanim_grass_house = getentarray("fxanim_cattails_house", "targetname");
  a_fxanim_grass_middle = getentarray("fxanim_cattails", "targetname");
  a_fxanim_grass_end = getentarray("fxanim_cattails_end", "targetname");
  a_grass_structs = [];
  a_fxanim_grass = arraycombine(a_fxanim_grass_house, a_fxanim_grass_middle, 0, 0);
  a_fxanim_grass = arraycombine(a_fxanim_grass, a_fxanim_grass_end, 0, 0);

  foreach(m_grass in a_fxanim_grass)
  a_grass_structs[a_grass_structs.size] = fxanim_grass_delete_until_needed(m_grass);

  flag_wait("fxanim_grass_spawn");
  level.a_grass_users = [];
  level.a_grass_users[level.a_grass_users.size] = level.player;
  level.a_grass_users[level.a_grass_users.size] = level.ai_hudson;
  a_fxanim_grass_house = [];
  a_fxanim_grass_middle = [];
  a_fxanim_grass_end = [];

  foreach(s_grass in a_grass_structs) {
    m_grass = fxanim_grass_restore(s_grass);

    if(isDefined(m_grass.targetname)) {
      switch (m_grass.targetname) {
        case "fxanim_cattails_house":
          a_fxanim_grass_house[a_fxanim_grass_house.size] = m_grass;
          break;
        case "fxanim_cattails":
          a_fxanim_grass_middle[a_fxanim_grass_middle.size] = m_grass;
          break;
        case "fxanim_cattails_end":
          a_fxanim_grass_end[a_fxanim_grass_end.size] = m_grass;
          break;
      }
    }
  }

  level thread manage_fxanim_grass_animating("start_fxanim_grass_house", a_fxanim_grass_house);
  level thread manage_fxanim_grass_animating("start_fxanim_grass_middle", a_fxanim_grass_middle);
  level thread manage_fxanim_grass_animating("start_fxanim_grass_end", a_fxanim_grass_end);
  flag_set("fxanim_grass_ready");
}

trigger_flag_set_touching() {
  level.player endon("death");
  level endon("tall_grass_stealth_done");
  assert(isDefined(self.script_noteworthy), "trigger must specify a flag name as its script_noteworthy");
  msg = self.script_noteworthy;

  while(true) {
    if(level.player istouching(self)) {
      if(!flag(msg))
        flag_set(msg);
    } else if(flag(msg))
      flag_clear(msg);

    wait 0.05;
  }
}

manage_fxanim_grass_animating(msg, a_grass) {
  level.player endon("death");
  level endon("tall_grass_stealth_done");
  flag_wait("fxanim_grass_ready");

  while(true) {
    flag_wait(msg);

    foreach(grass in a_grass)
    grass thread fxanim_grass_logic();

    flag_waitopen(msg);

    foreach(grass in a_grass) {
      grass notify("stop_grass_idle");
      grass anim_stopanimscripted();
      grass notify("fxanim_grass_stop_animating");
    }
  }
}

#using_animtree("animated_props");

fxanim_grass_logic() {
  level endon("tall_grass_stealth_done");
  self endon("fxanim_grass_stop_animating");
  self init_anim_model("generic", 0, #animtree);

  while(true) {
    self thread anim_generic_loop(self, "fxanim_grass_idle", "stop_grass_idle");
    self waittill_someone_touches_grass();
    self notify("stop_grass_idle");
    self anim_stopanimscripted();
    anim_single(self, "fxanim_grass");
  }
}

fxanim_grass_delete_until_needed(m_grass) {
  s_temp_grass = spawnstruct();
  m_grass maps\_fxanim::_fxanim_copy_kvps(s_temp_grass);
  m_grass delete();
  return s_temp_grass;
}

fxanim_grass_restore(s_temp_grass) {
  m_new_grass = spawn("script_model", s_temp_grass.origin);
  s_temp_grass maps\_fxanim::_fxanim_copy_kvps(m_new_grass);
  s_temp_grass structdelete();
  return m_new_grass;
}

waittill_someone_touches_grass() {
  level.player endon("death");
  level endon("tall_grass_stealth_done");
  b_touched = 0;

  while(!b_touched) {
    foreach(e_user in level.a_grass_users) {
      if(e_user istouching(self)) {
        b_touched = 1;
        return;
      }
    }

    wait 0.05;
  }
}

fxanim_grass_enemy_logic() {
  flag_wait("fxanim_grass_ready");
  self thread remove_from_users_array();
  level.a_grass_users[level.a_grass_users.size] = self;
}

remove_from_users_array() {
  self waittill("death");
  arrayremovevalue(level.a_grass_users, self);
}

fxanim_beach_grass_logic() {
  a_beach_grass_fxanim = getentarray("fxanim_beach_grass", "targetname");

  foreach(e_grass in a_beach_grass_fxanim)
  e_grass hide();

  a_beach_grass_static = getentarray("beach_grass_static", "targetname");

  foreach(e_grass in a_beach_grass_static)
  e_grass setscale(randomfloatrange(0.27, 0.5));

  flag_wait("hind_attack_end_scene_started");
  wait 1;

  foreach(e_grass in a_beach_grass_static)
  e_grass hide();

  foreach(e_grass in a_beach_grass_fxanim)
  e_grass show();

  setsaveddvar("wind_global_vector", "440 96 0");
}

stealth_foliage_settings() {
  level.foliage_cover.sight_dist["no_cover"] = 1024;
  level.foliage_cover.sight_dist["foliage_cover_crouch"] = 256;
}

stealth_settings() {
  hidden = [];
  hidden["prone"] = 70;
  hidden["crouch"] = 256;
  hidden["stand"] = 512;
  alert = [];
  alert["prone"] = 140;
  alert["crouch"] = 900;
  alert["stand"] = 1500;
  spotted = [];
  spotted["prone"] = 512;
  spotted["crouch"] = 5000;
  spotted["stand"] = 8000;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
  level._stealth.logic.ai_event["ai_eventDistDeath"]["hidden"] = 128;
}

after_house_stealth_settings() {
  hidden = [];
  hidden["prone"] = 64;
  hidden["crouch"] = 128;
  hidden["stand"] = 512;
  alert = [];
  alert["prone"] = 64;
  alert["crouch"] = 128;
  alert["stand"] = 512;
  spotted = [];
  spotted["prone"] = 128;
  spotted["crouch"] = 512;
  spotted["stand"] = 1024;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
}

after_grass_stealth_settings() {
  hidden = [];
  hidden["prone"] = 64;
  hidden["crouch"] = 64;
  hidden["stand"] = 64;
  alert = [];
  alert["prone"] = 64;
  alert["crouch"] = 64;
  alert["stand"] = 64;
  spotted = [];
  spotted["prone"] = 64;
  spotted["crouch"] = 64;
  spotted["stand"] = 64;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
}

hack_stealth_settings() {
  hidden = [];
  hidden["prone"] = 8000;
  hidden["crouch"] = 8000;
  hidden["stand"] = 8000;
  alert = [];
  alert["prone"] = 8000;
  alert["crouch"] = 8000;
  alert["stand"] = 8000;
  spotted = [];
  spotted["prone"] = 8000;
  spotted["crouch"] = 8000;
  spotted["stand"] = 8000;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
}

jungle_stealth_skipto_clean_up() {
  delete_scene("chopper_dead_body1", 1);
  delete_scene("chopper_dead_body2", 1);
  delete_scene("chopper_dead_body3", 1);
  delete_scene("pilot_execution_pilot", 1);
  delete_scene("j_stealth_player_picks_up_woods_hudson_watches", 1);
  delete_scene("j_stealth_player_picks_up_woods", 1);
  delete_scene("hudson_mantle_climb", 1);
  delete_scene("hudson_mantle_climb_loop", 1);
  delete_scene("hudson_mantle_help", 1);
  delete_scene("mason_woods_mantle_help", 1);
  sp_enemy = getent("chopper_dead_body1", "targetname");
  sp_enemy delete();
  sp_enemy = getent("chopper_dead_body2", "targetname");
  sp_enemy delete();
  sp_enemy = getent("chopper_dead_body3", "targetname");
  sp_enemy delete();
  sp_enemy = getent("crashed_hind_pilot", "targetname");
  sp_enemy delete();
}

jungle_stealth_ent_clean_up() {
  e_to_be_deleted = getent("trig_color_approach_from_beach_1", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("trig_color_approach_from_beach_2", "targetname");
  e_to_be_deleted delete();
}

jungle_stealth_log_skipto_clean_up() {
  delete_scene("hudson_child_soldier_intro_move_to_cover", 1);
  delete_scene("hudson_waits_in_cover_for_player_to_take_cover", 1);
  delete_scene("hault_guy", 1);
  delete_scene("wait_guy", 1);
  delete_scene("going_down_stairs_8x16_2", 1);
  delete_scene("player_prone_watches_1st_child_soldier_encounter", 1);
  delete_scene("watch_1st_child_soldier_encounter", 1);
  delete_scene("direct_patrol", 1);
  delete_scene("missionary_patroller", 1);
  delete_scene("child_guards_a", 1);
  delete_scene("child_guards_b", 1);
  delete_scene("child_guards_c", 1);
  t_to_be_deleted = getent("sm_fail_beach", "targetname");
  t_to_be_deleted delete();
  t_to_be_deleted = getent("trig_fail_before_log", "targetname");
  t_to_be_deleted delete();
  t_to_be_deleted = getent("trig_child_guards_a", "targetname");
  t_to_be_deleted delete();
  t_to_be_deleted = getent("trig_child_guards_b", "targetname");
  t_to_be_deleted delete();
  t_to_be_deleted = getent("trig_child_guards_c", "targetname");
  t_to_be_deleted delete();
  e_to_be_deleted = getent("clip_house_for_hudson", "targetname");
  e_to_be_deleted connectpaths();
  e_to_be_deleted delete();
  sp_enemy = getent("stair_enemy", "targetname");
  sp_enemy delete();
  sp_enemy = getent("child_soldier_1", "targetname");
  sp_enemy delete();
  sp_enemy = getent("child_soldier_2", "targetname");
  sp_enemy delete();
  sp_enemy = getent("child_soldier_3", "targetname");
  sp_enemy delete();
  sp_enemy = getent("child_soldier_4", "targetname");
  sp_enemy delete();
  sp_enemy = getent("patrol_director", "targetname");
  sp_enemy delete();
  sp_enemy = getent("go_house_ambient_child1_spawner", "targetname");
  sp_enemy delete();
  sp_enemy = getent("go_house_ambient_child2_spawner", "targetname");
  sp_enemy delete();
  sp_enemy = getent("go_house_ambient_child3_spawner", "targetname");
  sp_enemy delete();
  sp_enemy = getent("go_house_ambient_child4_spawner", "targetname");
  sp_enemy delete();
  sp_enemy = getent("child_guard_c_2", "targetname");
  sp_enemy delete();
  sp_enemy = getent("house_follow_path_and_die_spawner", "targetname");
  sp_enemy delete();
  a_spawners = getentarray("enemy_fail_beach", "targetname");

  foreach(sp_enemy in a_spawners)
  sp_enemy delete();

  a_spawners = getentarray("enemy_fail_before_log", "targetname");

  foreach(sp_enemy in a_spawners)
  sp_enemy delete();
}

jungle_stealth_log_ent_clean_up() {
  e_to_be_deleted = getent("objective_mason_hide_under_log_cover_trigger", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("color_hudson_waiting_for_house_move_trigger", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("stealth_volume_by_log", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("trig_color_enter_house", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("trig_color_house_wait", "targetname");
  e_to_be_deleted delete();
  e_to_be_deleted = getent("trig_hudson_in_house", "targetname");
  e_to_be_deleted delete();
  a_ledge_clips = getentarray("ledge_clip", "targetname");

  foreach(m_ledge_clip in a_ledge_clips)
  m_ledge_clip delete();

  e_to_be_deleted = getent("trig_log_started", "targetname");
  e_to_be_deleted delete();
}

chase_after_target(e_target) {
  self endon("death");
  self.goalradius = 16;

  if(!issubstr(self.classname, "child")) {
    self thread shoot_at_target_untill_dead(e_target);

    while(true) {
      if(isDefined(e_target)) {
        self getperfectinfo(e_target);
        self setgoalpos(e_target.origin);
      }

      wait 1;
    }
  }
}

exploder_after_wait(n_exploder_index) {
  wait 0.05;
  exploder(n_exploder_index);
}

get_whole_number(num) {
  negative = 1;

  if(num < 0)
    negative = -1;

  num = abs(num);

  for(count = 0; num >= 1; count = count + 1)
    num = num - 1;

  return count * negative;
}

flag_set_delayed(msg, delay) {
  wait(delay);
  flag_set(msg);
}

play_battle_convo_until_flag(str_team, a_str_aliases, min_delay, max_delay, str_flag, b_do_not_randomize_lines) {
  level endon(str_flag);

  while(!flag(str_flag)) {
    a_speakers = [];

    if(!isDefined(b_do_not_randomize_lines) || !b_do_not_randomize_lines)
      a_str_aliases = array_randomize(a_str_aliases);

    for(i = 0; i < a_str_aliases.size; i++) {
      a_guys = getaiarray(str_team);

      foreach(guy in a_guys) {
        if(guy is_hero())
          arrayremovevalue(a_guys, guy, 0);
      }

      foreach(speaker in a_speakers)
      arrayremovevalue(a_guys, speaker, 0);

      if(a_guys.size == 0) {
        wait 1.0;
        continue;
      }

      speaker = a_guys[0];
      a_speakers[a_speakers.size] = speaker;
      speaker say_dialog(a_str_aliases[i]);
      wait(randomfloatrange(min_delay, max_delay));
    }
  }
}

play_specific_vo_on_notify(lines, str_notify, exclusion_timer, endon_str) {
  level.player endon("death");

  if(isDefined(endon_str)) {
    if(isarray(endon_str)) {
      foreach(str in endon_str)
      level endon(str);
    } else
      level endon(endon_str);
  }

  while(true) {
    self waittill(str_notify);
    guys = getaiarray("axis");

    if(guys.size == 0) {
      wait 1;
      continue;
    }

    guys[0] say_dialog(lines[randomint(lines.size)]);
    wait(exclusion_timer);
  }
}

play_battle_convo_from_array_until_flag(a_guys, a_str_aliases, min_delay, max_delay, str_flag, b_do_not_randomize_lines) {
  level endon(str_flag);

  while(!flag(str_flag)) {
    a_speakers = [];

    if(!isDefined(b_do_not_randomize_lines) || !b_do_not_randomize_lines)
      a_str_aliases = array_randomize(a_str_aliases);

    for(i = 0; i < a_str_aliases.size; i++) {
      foreach(speaker in a_speakers)
      arrayremovevalue(a_guys, speaker, 0);

      if(a_guys.size == 0) {
        wait 1.0;
        continue;
      }

      speaker = a_guys[0];
      a_speakers[a_speakers.size] = speaker;
      speaker say_dialog(a_str_aliases[i]);
      wait(randomfloatrange(min_delay, max_delay));
    }
  }
}

monitor_mortar_ammo() {
  self endon("death");

  while(true) {
    if(!self getammocount("mortar_shell_dpad_sp") && self getcurrentweapon() == "mortar_shell_dpad_sp") {
      a_weapons = self getweaponslistprimaries();
      self switchtoweapon(a_weapons[0]);
    }

    wait 0.1;
  }
}