/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7409560e3a0c9884.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_2d443451ce681a;
#using script_3dc93ca9902a9cda;
#using script_eb1a9e047313195;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\buddy_follow;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_ba979a10;

function function_3286606(var_d9a11bf0, var_f41e3a56, radius, var_d0293722) {
  level endon(var_d0293722);
  radius_sq = radius * radius;
  in_area = 0;

  while(true) {
    dist_sq = distance2dsquared(var_f41e3a56.origin, level.player.origin);

    if(!in_area && dist_sq < radius_sq) {
      in_area = 1;
      objectives::hide(var_d9a11bf0);
    } else if(in_area && dist_sq > radius_sq) {
      in_area = 0;
      objectives::show(var_d9a11bf0);
    }

    waitframe(1);
  }
}

function function_ab0709c0(var_d9a11bf0, volume, var_d0293722) {
  level endon(var_d0293722);
  objectives::hide(var_d9a11bf0);
  vol = getent(volume, "targetname");

  while(true) {
    if(level.player istouching(vol)) {
      objectives::show(var_d9a11bf0);
    } else {
      objectives::hide(var_d9a11bf0);
    }

    waitframe(1);
  }
}

function function_ee211e0d() {
  level flag::wait_till("player_rappel_done");
  objectives::scripted(#"search_and_kill_obj", undefined, #"hash_22cbba913d7929f1");
  var_c7325764 = getent("obj_tundra_bunker_01", "targetname");
  objectives::function_4eb5c04a("search_01", var_c7325764.origin, #"hash_25312f567bf1f18c");
  objectives::function_6a5ca7ac(#"search_01", undefined, #"search_and_kill_obj", undefined, 0);
  var_16c0dff0 = getent("search_area_bunker1_01", "targetname");
  objectives::area("search_area_01", var_16c0dff0.origin, 1100, undefined, undefined, undefined, undefined, "cp_waypoint_area_no_compass");
  waitframe(1);
  objectives::function_67f87f80("search_01", undefined, #"hash_5f6c6d96184307e0");
  level thread function_3286606("search_01", var_16c0dff0, 1100, "search_objective_1_cleared");
  level thread function_c7612635();
  var_b8923a10 = getent("obj_tundra_bunker_02", "targetname");
  objectives::function_4eb5c04a("search_02", var_b8923a10.origin, #"hash_253132567bf1f6a5");
  objectives::function_6a5ca7ac(#"search_02", undefined, #"search_and_kill_obj", undefined, 0);
  var_29180492 = getent("search_area_bunker2_01", "targetname");
  objectives::area("search_area_02", var_29180492.origin, 400, undefined, undefined, undefined, undefined, "cp_waypoint_area_no_compass");
  waitframe(1);
  objectives::function_67f87f80("search_02", undefined, #"hash_5f6c6d96184307e0");
  level thread function_3286606("search_02", var_29180492, 400, "search_objective_2_cleared");
  level thread function_7f4315fa();
  var_c7555796 = getent("obj_tundra_bunker_03", "targetname");
  objectives::function_4eb5c04a("search_03", var_c7555796.origin, #"hash_253131567bf1f4f2");
  objectives::function_6a5ca7ac(#"search_03", undefined, #"search_and_kill_obj", undefined, 0);
  var_f1de162b = getent("search_area_bunker3_01", "targetname");
  objectives::area("search_area_03", var_f1de162b.origin, 650, undefined, undefined, undefined, undefined, "cp_waypoint_area_no_compass");
  waitframe(1);
  objectives::function_67f87f80("search_03", undefined, #"hash_5f6c6d96184307e0");
  level thread function_3286606("search_03", var_f1de162b, 750, "search_objective_3_cleared");
  level thread function_ecfd716d();
  level flag::wait_till_any(array("flag_rudnik_truck_mp_1_spawn", "flag_rudnik_truck_mp_2_spawn", "flag_rudnik_truck_fd_1_spawn", "flag_rudnik_truck_fd_2_spawn"));
  level flag::set("flag_start_final_building");

  if(flag::get("search_objective_3_cleared")) {
    if(flag::get("flag_rudnik_truck_mp_1_spawn")) {
      level thread function_f7c83b06("tundra_rudnik_veh_1", "runik_veh1_start_node");
    } else if(flag::get("flag_rudnik_truck_mp_2_spawn")) {
      level thread function_f7c83b06("tundra_rudnik_veh_2", "runik_veh2_start_node");
    }
  } else if(flag::get("search_objective_1_cleared")) {
    if(flag::get("flag_rudnik_truck_fd_1_spawn")) {
      level thread function_f7c83b06("tundra_rudnik_veh_3", "runik_veh3_start_node");
    } else if(flag::get("flag_rudnik_truck_fd_2_spawn")) {
      level thread function_f7c83b06("tundra_rudnik_veh_4", "runik_veh4_start_node");
    }
  }

  objectives::complete("search_01");
  objectives::complete("search_area_01");
  objectives::complete("search_02");
  objectives::complete("search_area_02");
  objectives::complete("search_03");
  objectives::complete("search_area_03");
  level flag::wait_till("flag_rudnik_truck_stop");
  var_f7bf663b = getent("obj_tundra_final_bunker", "targetname");
  objectives::function_4eb5c04a(#"final_building", var_f7bf663b.origin, #"hash_25312c567bf1ec73");
  objectives::function_6a5ca7ac(#"final_building", undefined, #"search_and_kill_obj", undefined, 0);
  waitframe(1);
  objectives::function_67f87f80("final_building", undefined, #"hash_5f6c6d96184307e0");
  search_obj_04 = getent("search_area_bunker4_01", "targetname");
  objectives::area("search_obj_04", search_obj_04.origin, 575, undefined, undefined, undefined, undefined, "cp_waypoint_area_no_compass");
  level thread function_3286606(#"final_building", search_obj_04, 575, "flag_spawn_enemy_vip");
  var_8433129 = struct::get("use_org_door_breach", "targetname");
  objectives::function_4eb5c04a("bunker_breach", var_8433129.origin);
  level thread function_ab0709c0("bunker_breach", "final_bunker_int_combat_vol", "door_breached");
  level flag::wait_till("flag_spawn_enemy_vip");
  objectives::complete("search_obj_04");
  waitframe(1);
  objectives::kill("kill_vip", level.vip, undefined, undefined, undefined, undefined, #"hash_17f4660b06e37fdb");
  waitframe(1);
  objectives::function_67f87f80("kill_vip", level.vip, #"hash_7ead0c0608d779c");
  level flag::wait_till("flag_tundra_vip_killed");
  objectives::scripted("corpse_photo", undefined, #"hash_b5a39672b1b6832");
  objectives::complete("final_building");
  objectives::complete("search_and_kill_obj");
  level flag::wait_till("flag_tundra_vip_kill_confirmed");
  objectives::complete("corpse_photo");
  objectives::scripted("exfil", undefined, #"hash_691ff8392bd7780e");
}

function function_c7612635() {
  level flag::wait_till_all(array("flag_obj_1_search_clear_1", "flag_obj_1_search_clear_2", "flag_obj_1_search_clear_3", "flag_obj_1_search_clear_4"));
  level notify(#"cleared_building");
  level flag::set("search_objective_1_cleared");
  objectives::complete("search_01");
  objectives::complete("search_area_01");
  level flag::set("flag_combat_vehicle_1");
}

function function_7f4315fa() {
  level flag::wait_till_all(array("flag_obj_2_search_clear_1", "flag_obj_2_search_clear_2"));
  level notify(#"cleared_building");
  level flag::set("search_objective_2_cleared");
  objectives::complete("search_02");
  objectives::complete("search_area_02");
}

function function_ecfd716d() {
  level flag::wait_till_all(array("flag_obj_3_search_clear_1", "flag_obj_3_search_clear_2"));
  level notify(#"cleared_building");
  level flag::set("search_objective_3_cleared");
  objectives::complete("search_03");
  objectives::complete("search_area_03");
  level flag::set("flag_combat_vehicle_2");
}

function function_aba9a175() {
  if(flag::get("search_objective_1_cleared") && flag::get("search_objective_3_cleared")) {
    objectives::complete("search_02");
    return;
  }

  if(flag::get("search_objective_1_cleared") && flag::get("search_objective_2_cleared")) {
    objectives::complete("search_03");
    return;
  }

  if(flag::get("search_objective_2_cleared") && flag::get("search_objective_3_cleared")) {
    objectives::complete("search_01");
  }
}

function function_f7c83b06(vehicle, start_node) {
  var_825d3987 = vehicle::simple_spawn_single_and_drive(start_node);
  obj_loc = util::spawn_model("tag_origin", var_825d3987.origin + (0, 0, 96), var_825d3987.angles);
  obj_loc linkto(var_825d3987, "tag_origin");
  objectives::follow(#"follow_vip", obj_loc, undefined, undefined, undefined, #"hash_443d177707542b08");
  objectives::function_67f87f80("follow_vip", obj_loc, #"hash_7ead0c0608d779c");
  snd::client_targetname(var_825d3987, "rudnik_truck");
  level flag::set("flag_rudnik_truck_drive");
  level flag::wait_till("flag_rudnik_truck_stop");
  objectives::complete(#"follow_vip");
  obj_loc delete();
}

function function_14f72bec() {
  var_3dc528fe = getEntArray("vip_vehicles", "script_noteworthy", 1);

  foreach(e_vehicle in var_3dc528fe) {
    e_vehicle.team = "axis";
  }
}

function function_29513390() {
  self callback::function_d8abfc3d(#"on_ai_damage", &function_2bf6e321);
}

function function_2bf6e321(s_params) {
  if(s_params.shitloc == "none") {
    level flag::set("rudnik_no_hit_loc");
    return;
  }

  if(isDefined(s_params.shitloc)) {
    if(s_params.shitloc == "head" || s_params.shitloc == "neck" || s_params.shitloc == "helmet") {
      level flag::set("rudnik_head_shot_loc");
      return;
    }

    if(s_params.shitloc == "torso_upper" || s_params.shitloc == "torso_lower" || s_params.shitloc == "torso_mid" || s_params.shitloc == "chest") {
      level flag::set("rudnik_gut_shot_loc");
    }
  }
}

function function_78a1b9ef() {
  level.vip = self;
  level.vip.dontdropweapon = 1;
  level.vip.var_c681e4c1 = 1;
  level.player.takedown.disabled = 1;
  level callback::function_30c3f95d(&function_36578ff1);
  level flag::set("tundra_vip_enemy_spawned");
  level thread function_aba9a175();
  level.var_c1ec7c3d = level.vip.model;
  level.vip waittill(#"death");
  level flag::wait_till("flag_vip_became_corpse");
  wait 1;
  corpse = level.var_b28ef69b;
  timeout = gettime() + 7000;
  var_ab3730a4 = (0, 0, 0);

  while(timeout > gettime() && lengthsquared(var_ab3730a4 - corpse getcorpsephysicsorigin() + corpse function_6c7f19df()) > 4) {
    var_ab3730a4 = corpse getcorpsephysicsorigin() + corpse function_6c7f19df();
    waitframe(3);
  }

  corpseorigin = corpse getcorpsephysicsorigin();
  var_1157b993 = corpse function_6c7f19df();
  level.var_a4592423 = [];
  level.orgs = [];
  level.orgs[level.orgs.size] = corpseorigin;
  level.orgs[level.orgs.size] = var_1157b993;
  start = corpseorigin + (0, 0, 8);
  end = var_1157b993 + (0, 0, 8);
  toadd = (end - start) / 4;
  level.orgs[level.orgs.size] = end;
  level.orgs[level.orgs.size] = start;

  for(i = 0; i < 4 - 1; i++) {
    level.orgs[level.orgs.size] = level.orgs[level.orgs.size - 1] + toadd;
  }

  foreach(org in level.orgs) {
    if(isDefined(org)) {
      level.var_a4592423[level.var_a4592423.size] = util::spawn_model("tag_origin", org);
    }
  }

  if(false) {
    foreach(tag in level.var_a4592423) {
      sphere(tag.origin, 3, (0, 0, 1), 1, 0, 8, 1400);
    }
  }

  level flag::set("flag_corpse_camera_tags_setup");
  level flag::wait_till("flag_corpse_camera_tags_setup");
  level flag::set("flag_tundra_vip_killed");
  objectives::complete("search_and_kill_obj");
  objectives::complete("kill_vip", level.vip);
}

function private function_36578ff1(parm) {
  corpse = self;

  if(corpse.model == level.var_c1ec7c3d) {
    level.var_b28ef69b = corpse;
    level flag::set("flag_vip_became_corpse");
    corpse callback::function_95ba5345(&function_36578ff1);
  }
}

function function_d3e635a9(set_flag, notification) {
  self waittill(notification);
  level flag::set(set_flag);
}

function function_c06a491a(teleport_node) {
  node = getnode(teleport_node, "targetname");
  self forceteleport(node.origin, node.angles);
  waitframe(1);
  self setgoal(node, 1);
}

function function_d6af6077() {
  trig = getent("player_jump_kill_trigger", "targetname");
  level flag::wait_till("player_is_rappelling");
  trig delete();
}

function function_d6b495cf(var_5267e989 = 1048576, everyone = 1) {
  enemy_ai = [];
  var_131a400f = spawner::get_ai_group_ai("motor_pool_int_enemies");
  enemy_ai = arraycombine(enemy_ai, var_131a400f);
  var_c25f1838 = spawner::get_ai_group_ai("motor_pool_enemies");
  enemy_ai = arraycombine(enemy_ai, var_c25f1838);
  var_3d899f02 = spawner::get_ai_group_ai("radar_int_enemies");
  enemy_ai = arraycombine(enemy_ai, var_3d899f02);
  var_522a93bb = spawner::get_ai_group_ai("radar_ext_enemies");
  enemy_ai = arraycombine(enemy_ai, var_522a93bb);
  var_304f9f3a = spawner::get_ai_group_ai("fuel_depot_int_enemies");
  enemy_ai = arraycombine(enemy_ai, var_304f9f3a);
  var_ccf591c0 = spawner::get_ai_group_ai("fuel_depot_ext_enemies");
  enemy_ai = arraycombine(enemy_ai, var_ccf591c0);

  if(everyone) {
    var_298eca1f = spawner::get_ai_group_ai("outbuilding2_int_enemies");
    enemy_ai = arraycombine(enemy_ai, var_298eca1f);
    var_43db4b2 = spawner::get_ai_group_ai("tundra_combat_veh_enemies");
    enemy_ai = arraycombine(enemy_ai, var_43db4b2);
  }

  var_9daaae3d = 0;

  foreach(ai in enemy_ai) {
    if(!isalive(ai)) {
      continue;
    }

    inside = distance2dsquared(level.player.origin, ai.origin) < var_5267e989;

    if(!everyone && inside) {
      continue;
    }

    if(inside && var_9daaae3d % 2) {
      ai kill();
      var_9daaae3d += 4;
    } else {
      ai delete();
      var_9daaae3d++;
    }

    if(var_9daaae3d >= 8) {
      var_9daaae3d = 0;
      waitframe(1);
    }
  }
}

function function_abde7b6d() {
  var_d64a504a = getEntArray("combat_vehicles", "script_noteworthy", 1);

  foreach(ent in var_d64a504a) {
    if(isalive(ent)) {
      ent delete();
    }
  }

  vehicle_corpses = getentitiesinradius(level.player.origin, 10000, 14);

  if(isDefined(vehicle_corpses.size)) {
    iprintln("<dev string:x38>" + vehicle_corpses.size);

    array::delete_all(vehicle_corpses);
  }
}

function function_cb6a2e9b() {
  level endon(#"door_breached");
  level thread function_2e11eba4();
  level thread namespace_ae270045::function_cfcd9b92(780, #"hash_664e9b711fb935b3", undefined, 1, #"hash_5a2c9005d167f4b8", 50);
  level waittill(#"hash_56a61cb4fe8b8e79");
  level flag::set("mission_timer_fail");
  level waittill(#"hash_267bd9980f77d5f4");
  util::function_2a8f4806(#"hash_67c0d8cb1c978161", #"hash_4bac1239d9e0e0bd");
}

function function_7094e60a() {
  level thread namespace_ae270045::function_cfcd9b92(90, #"hash_63d50e5ab788472b", undefined, 1, #"hash_453ed8c47ddb6690", 50);
  level waittill(#"hash_56a61cb4fe8b8e79");
  level flag::set("evac_heli_kill");
  level waittill(#"hash_267bd9980f77d5f4");
  wait 0.2;
  util::function_2a8f4806(#"hash_73070752ddd02cad", #"hash_4bac1239d9e0e0bd");
}

function setup_allies() {
  util::function_268bdf4f("woods");
  level.woods pushplayer(1);
  level.woods battlechatter::function_2ab9360b(0);
  level flag::wait_till("tundra_intro_done");
  createthreatbiasgroup("sniper_woods");
  level.woods setthreatbiasgroup("sniper_woods");
}

function function_c70f5d3() {
  level endon(#"stop_tundra_handle_woods_ridge");
  level.woods endon(#"death");
  level.player endon(#"death");
  level.woods.fixednode = 1;
  level flag::wait_till("level_is_go");
  waitframe(20);
  level.woods thread function_c06a491a("woods_ridge_start_node");
  waitframe(5);
  level.woods val::set("woods_ridge", "ignoreme", 1);
  level.woods val::set("woods_ridge", "ignoreall", 1);
  var_4e2fa30a = getnode("woods_ridge_start_node", "targetname");
  var_41476401 = [];
  var_41476401[0] = struct::get("woods_north_limit", "targetname");
  var_41476401[1] = struct::get(var_41476401[0].target, "targetname");

  level.var_13a95ce2 = 0;

  var_880f27ba = 0;
  level.woods childthread function_723f322d();

  while(true) {
    if(!isDefined(var_4e2fa30a)) {
      var_4e2fa30a = getnode("woods_ridge_start_node", "targetname");
    }

    var_7f1df23e = pointonsegmentnearesttopoint(var_41476401[var_880f27ba].origin, var_41476401[var_880f27ba + 1].origin, level.player.origin);
    nearest_node = getnearestnode(var_7f1df23e);

    if(!isDefined(nearest_node)) {
      nearest_node = var_4e2fa30a;
    }

    if(var_4e2fa30a != nearest_node) {
      curr = distance(var_4e2fa30a.origin, var_7f1df23e);
      nearest = distance(nearest_node.origin, var_7f1df23e);

      if(nearest * 1.33 < curr) {
        var_4e2fa30a = nearest_node;
        level.woods setgoal(var_4e2fa30a, 1);
      }
    }

    if(level.var_13a95ce2 === 1) {
      for(i = 0; i < var_41476401.size; i++) {
        sphere(var_41476401[i].origin, 16, (0, 0, 1), 1, 0, 8, 4);

        if(i > 0) {
          line(var_41476401[i].origin, var_41476401[i - 1].origin, (0, 0, 1), 1, 0, 4);
        }

        sphere(var_7f1df23e, 32, (1, 1, 0), 1, 0, 8, 4);
        sphere(level.woods.origin - (0, 0, 32), 49, (1, 0, 0), 0.5, 0, 8, 4);
        sphere(var_4e2fa30a.origin - (0, 0, 52), 40, (0, 0, 1), 0.6, 0, 8, 4);

        if(var_4e2fa30a != nearest_node) {
          sphere(nearest_node.origin, 32, (0.1, 0.1, 0.1), 1, 0, 8, 4);
        }

        line(var_7f1df23e, level.player.origin, (1, 1, 0), 1, 0, 4);
      }
    }

    waitframe(4);
  }
}

function function_6842005a() {
  self endon(#"evac_woods_stop_shooting");
  var_959b99c9 = ["vox_cp_rcir_01250_wood_gotone_ba", "vox_cp_rcir_01250_wood_anotherdown_d7", "vox_cp_rcir_01250_wood_gotanotheronewe_25", "vox_cp_rcir_01250_wood_fishinabarrel_c8", "vox_cp_rcir_01250_wood_andanother_52", "vox_cp_rcir_01250_wood_droppedhim_5a", "vox_cp_rcir_01250_wood_imtheeagleofdea_79"];
  var_fc5ff665 = 0;
  var_ac9255fb = 0;

  while(true) {
    self waittill(#"hash_35a85d0d53e9405e");
    wait 0.6;

    if(gettime() > var_ac9255fb) {
      self dialogue::radio(var_959b99c9[var_fc5ff665 % var_959b99c9.size]);
      var_fc5ff665++;
      var_ac9255fb = gettime() + 10000 + 10000 * var_fc5ff665 / var_959b99c9.size / 1.5;
      continue;
    }

    remaining = (var_ac9255fb - gettime()) / 1000;
    iprintln("<dev string:x56>" + remaining);
  }
}

function function_723f322d() {
  self endon(#"death");
  self endon(#"evac_woods_stop_shooting");
  level flag::wait_till_any(array("flag_spawn_motor_pool_enemies", "flag_spawn_radar_enemies", "flag_spawn_fuel_depot_enemies"));
  self childthread function_6842005a();
  self.var_5b0f2db2 = gettime();
  var_36ff13de = 0;
  ai_array = [];
  var_ffb10b3c = [];

  while(true) {
    if(self.var_5b0f2db2 > gettime()) {
      self waittilltimeout((self.var_5b0f2db2 - gettime()) / 1000, #"hash_11f70abb49422ad6");
    }

    if(level flag::get("woods_pause_overwatch")) {
      var_36ff13de = 0;
      level flag::wait_till_clear("woods_pause_overwatch");
      continue;
    }

    if(!var_36ff13de) {
      fwd = anglesToForward(level.player getangles());
      player_origin = level.player getplayercamerapos();
      var_ffb10b3c = getaiteamarray("axis");
      ai_array = [];
      var_36ff13de = 1;

      foreach(ai in var_ffb10b3c) {
        var_2c0fdec8 = length2d(ai getvelocity());

        if(ai.script_parameters === "woods_no_shoot" || length2dsquared(ai getvelocity()) > 1400) {
          continue;
        }

        dot = vectordot(fwd, vectornormalize(ai.origin - player_origin));

        if(dot > 0.866025 && dot < 0.997) {
          ai_array[ai_array.size] = ai;
          ai.dot = dot;
        }
      }

      if(level.var_13a95ce2 === 1) {
        foreach(ai in ai_array) {
          color = (0, 0, 1);

          if(ai.dot < 0) {
            color = (1, 0, 0);
          }

          print3d(ai.origin + (0, 0, 72), "<dev string:x6c>" + int(ai.dot * 1000), color, 1, 1, 40, 1);
        }
      }

    }

    if(var_36ff13de) {
      var_d3692aca = 0;
      ai_target = undefined;

      while(ai_array.size > 0) {
        if(var_d3692aca >= 2) {
          break;
        }

        ai = ai_array[randomint(ai_array.size)];

        if(!isDefined(ai)) {
          arrayremovevalue(ai_array, undefined);
          continue;
        }

        if(!self cansee(ai)) {
          if(level.var_13a95ce2 === 1) {
            sphere(ai.origin, 12, (1, 0, 0), 1, 0, 10, 40);
          }

          arrayremovevalue(ai_array, ai);
          var_d3692aca++;
          continue;
        }

        ai_target = ai;
        break;
      }

      if(isDefined(ai_target)) {
        self.var_5b0f2db2 = gettime() + 5000;
        start = self.origin + (0, 0, 36) + anglesToForward(self.angles) * 120;
        end = ai gettagorigin("j_head");
        var_bdccc219 = length(start - end) / 24000;
        vel = ai getvelocity();
        end += vel * var_bdccc219;
        var_280c0a5f = gettime();
        magicbullet(self.weapon, start, end, self, ai);
        var_36ff13de = 0;
        ret = ai waittilltimeout(var_bdccc219 + 0.1, #"death");

        if(ret._notify === # "death" && ret.attacker === self) {
          self notify(#"hash_35a85d0d53e9405e");
        } else {
          self.var_5b0f2db2 = gettime() + 5000 / 3;
        }
      } else if(ai_array.size == 0) {
        self.var_5b0f2db2 = gettime() + 500;
        var_36ff13de = 0;
        continue;
      }
    }

    waitframe(1);
  }
}

function function_fe17f833() {
  wait 30;

  if(isDefined(level.woods) && isalive(level.woods)) {
    level flag::set("stop_tundra_handle_woods_ridge");
    level flag::set("evac_woods_stop_shooting");
    waitframe(1);
    node = getnode("woods_evac_final_node", "targetname");
    level.woods setgoal(node, 1);
  }
}

function function_ead0a373(params) {
  if(params.einflictor.scriptvehicletype === "player_snowmobile") {
    self aiutility::setcurrentweapon(level.weaponnone);
    self aiutility::setprimaryweapon(level.weaponnone);
    self aiutility::setsecondaryweapon(level.weaponnone);
    self.disableammodrop = 1;
  }
}

function function_b1ea4c94() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"enter_vehicle");

    if(waitresult.vehicle.scriptvehicletype === "player_snowmobile") {
      function_3369f0c5();
      self thread function_5797b2ea();
      waittillframeend();
      self val::reset(#"player_vehicle", "ignoreme");
    }
  }
}

function function_37761722() {
  while(level.player adsButtonPressed() && !self.var_38b8f61c) {
    waitframe(1);
  }

  if(!!self.var_38b8f61c) {
    self val::set("weapon_on_snowmobile", "show_weapon_hud", 0);
    self.var_38b8f61c = 1;
  }
}

function function_1d2685a0() {
  self endon(#"death");
  self endon(#"exit_vehicle");

  while(true) {
    if(!self.var_38b8f61c) {
      self val::set("weapon_on_snowmobile", "show_weapon_hud", 0);
      self.var_38b8f61c = 1;
    }

    function_3369f0c5();
    self waittill(#"change_seat");
    self val::reset("weapon_on_snowmobile", "show_weapon_hud");
    self.var_38b8f61c = 0;
    function_3369f0c5();
    self waittill(#"change_seat");
  }
}

function function_3369f0c5() {
  usinggamepad = level.player gamepadusedlast();
  var_c9ed28e4 = level.player adsButtonPressed();
  var_ce3139b1 = getlocalprofileint("interact_requires_hold");
  var_eeccc49f = getlocalprofileint("transport_vehicle_alternate_control");
  namespace_c8e236da::removelist();

  if(usinggamepad) {
    namespace_c8e236da::function_ebf737f8(#"hash_4dbc4bd4b6006eed");
    namespace_c8e236da::function_ebf737f8(#"hash_2b76a90fe9fa674f");
  } else if(var_eeccc49f) {
    namespace_c8e236da::function_ebf737f8(#"hash_728b7bdb1313421c");
  }

  if(var_c9ed28e4) {
    namespace_c8e236da::function_ebf737f8(#"hash_70dd599464b0044");
  } else {
    namespace_c8e236da::function_ebf737f8(#"hash_1632eeb11fb9d59");
  }

  if(!usinggamepad && !var_ce3139b1) {
    namespace_c8e236da::function_ebf737f8(#"hash_1b8b60beb626fb8a");
    return;
  }

  namespace_c8e236da::function_ebf737f8(#"hash_1f85b592c37f12f0");
}

function function_5797b2ea() {
  self endon(#"death");
  self.var_38b8f61c = 0;
  self thread function_1d2685a0();
  waitresult = self waittill(#"exit_vehicle");
  namespace_c8e236da::removelist();

  if(self.var_38b8f61c) {
    self val::reset("weapon_on_snowmobile", "show_weapon_hud");
    self.var_38b8f61c = 0;
  }
}

function function_a2ca02f3() {
  level flag::wait_till("stealth_spotted");
  wait 2;
  level thread namespace_979752dc::disable_stealth_system();
  level flag::set("no_corpse_pickup ");
}

function function_2e11eba4() {
  level endon(#"door_breached");
  level thread function_a2ca02f3();
  var_4a37c7a0 = ["Cleared Building with ", "Got Timeout with "];
  var_4aa60bdd = 780000 / 4;
  getplayers()[0] endon(#"death");
  start_t = gettime();
  var_53e12236 = 0;
  var_88e50635 = 0;

  while(var_53e12236 < 3) {
    ret = level waittilltimeout(45, #"cleared_building");

    if(ret._notify === "cleared_building") {
      var_53e12236++;
      var_88e50635 = 0;
    } else {
      var_88e50635 = 1;
    }

    if(start_t + (var_53e12236 + var_88e50635) * var_4aa60bdd > gettime()) {
      thread savegame::checkpoint_save(1);

      var_9dbe6b43 = (start_t + (var_53e12236 + var_88e50635) * var_4aa60bdd - gettime()) / 1000;
      iprintln("<dev string:x72>" + var_4a37c7a0[var_88e50635] + var_9dbe6b43 + "<dev string:x80>");

      continue;
    }

    overtime = (gettime() - start_t + (var_53e12236 + var_88e50635) * var_4aa60bdd) / 1000;
    iprintln("<dev string:xa9>" + var_4a37c7a0[var_88e50635] + overtime + "<dev string:xba>");
  }
}

function function_7d2d1987(distsquared = 640000, fov = cos(45), var_e6208e62 = 1) {
  self notify("785a77f645a252f9");
  self endon("785a77f645a252f9");
  self endon(#"death");
  level.player endon(#"death");

  if(is_false(var_e6208e62)) {
    self waittill(#"reached_path_end");
  }

  while(true) {
    wait randomfloat(0.225);

    if(distancesquared(level.player.origin, self.origin) < distsquared) {
      continue;
    }

    if(!util::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), fov)) {
      self delete();
    }
  }
}

function function_7fe34c6e() {
  clip = getent("final_door_clip_blocker", "targetname");
  clip disconnectpaths();
  level flag::wait_till("smoke_tossed");
  clip connectpaths();

  if(isDefined(clip)) {
    clip delete();
  }
}