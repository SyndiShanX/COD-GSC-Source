/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_10bb9f045d0c567a.gsc
*************************************************/

#using script_73e89fcb51b31802;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\soldier\pain;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\ai_armor;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\dialogue;
#using scripts\sp\door;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace namespace_5643a6b7e3dcbf23;

function set_objective(type) {
  switch (type) {
    case #"hash_bf2698954a8a0491":
      objectives::objective_add("silo", "current", undefined, &"SP_JUP_SILO/OBJ_1_INTRO", "");
      utility::flag_wait("intro_finished");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_2694799580a3b94d":
      objectives::objective_add("silo", "current", undefined, &"SP_JUP_SILO/OBJ_2_INFIL", "");
      utility::flag_wait("player_in_base");
      objectives::objective_remove("silo");
      wait 0.05;

      if(!utility::flag("keycard_picked_up")) {
        objectives::objective_add("silo", "current", undefined, &"SP_JUP_SILO/OBJ_3_BASE", "");
        structs = utility::getStructArray("obj_comm", "targetname");
        objectiveindex = objectives::_objective_getindexforname("silo");
        wait 0.05;

        foreach(struct in structs) {
          struct function_9594b519aef98e4(objectiveindex);
        }

        utility::flag_wait("base_boss_spawned");
        utility::flag_wait_either("baseboss_death", "baseBoss_spotted");

        if(!utility::flag("baseboss_death") || isDefined(level.baseboss) && isalive(level.baseboss)) {
          utility::flag_set("obj_comm_1");
          utility::flag_set("obj_comm_2");
          utility::flag_set("obj_comm_3");
          waitframe();
          objectives::objective_remove("silo");
          wait 0.05;
          objectives::objective_add("silo", "current", undefined, &"SP_JUP_SILO/OBJ_3_2_BASE", "");

          if(isDefined(level.baseboss) && isalive(level.baseboss)) {
            objectives::objective_set_on_entity("silo", "baseBoss", level.baseboss);
            objectives::objective_set_z_offset("silo", 68);
          }
        }

        wait 0.05;
        utility::flag_wait("baseboss_death");
        objectives::objective_remove("silo");
        wait 0.05;
        objectives::objective_add("silo", "current", level.keycard.origin, &"SP_JUP_SILO/OBJ_3_5_BASE", "");
        flag_wait("keycard_picked_up");
        objectives::objective_remove("silo");
      }

      objstruct = getStruct("upper_base_keycard_struct", "targetname");
      objectives::objective_add("silo", "current", objstruct.origin, &"SP_JUP_SILO/OBJ_4_BASE", "");
      utility::flag_wait("silo_door_opened");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_bc0639cfcea1df22":
      objstruct = getStruct("elevator_struct", "targetname");
      objectives::objective_add("silo", "current", objstruct.origin, &"SP_JUP_SILO/OBJ_5_SILO", "");
      utility::flag_wait("player_in_elevator");
      objectives::objective_remove("silo");
      wait 0.05;
      objstruct = getStruct("meetup_struct", "targetname");
      objectives::objective_add("silo", "current", objstruct.origin, &"SP_JUP_SILO/OBJ_6_SILO", "");
      utility::flag_wait("meetup_with_farah");
      objectives::objective_remove("silo");
      wait 0.05;
      objstruct = getStruct("server_room_struct", "targetname");
      objectives::objective_add("silo", "current", objstruct.origin, &"SP_JUP_SILO/OBJ_6_SILO", "");
      utility::flag_wait("farah_opens_door");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_aa20f28138d691a0":
      struct = utility::getStruct("maintenance_door_struct", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_6_SILO", "");
      utility::flag_wait("player_enters_maintenance_room");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_e44587dd9676e5ef":
      struct = getStruct("missile_room_laptop_struct", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_7_SILO", "");
      wait 0.05;
      utility::flag_wait("player_interacts_with_laptop");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_43c990a8627eae88":
      if(!flag("player_exits_missile_room")) {
        struct = utility::getStruct("obj_tunnel_exit1", "targetname");
        objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_8_SILO", "");
        wait 0.05;
        utility::flag_wait("player_exits_missile_room");
        objectives::objective_remove("silo");
        wait 0.05;
      }

      struct = getStruct("obj_tunnel_exit2", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_8_SILO", "");
      wait 0.05;
      utility::flag_wait("player_enters_exit_tunnel");
      objectives::objective_remove("silo");
      wait 0.05;
      struct = getStruct("obj_tunnel_exit25", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_8_SILO", "");
      wait 0.05;
      utility::flag_wait("player_near_exit_ladder");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_e8caf2d7f999f21e":
      struct = utility::getStruct("obj_tunnel_exit3", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_9_SILO", "");
      utility::flag_clear("player_is_exiting_hatch");
      wait 0.05;
      utility::flag_wait("player_is_exiting_hatch");
      objectives::objective_remove("silo");
      wait 0.05;
    case #"hash_97591d94e1ac2788":
      struct = utility::getStruct("ending_button", "targetname");
      objectives::objective_add("silo", "current", struct.origin, &"SP_JUP_SILO/OBJ_10_FINAL", "");
      break;
  }
}

function function_9594b519aef98e4(objectiveindex) {
  num = level.objnum;
  objective_setlocation(objectiveindex, num, self.origin);
  level.objnum++;
  thread function_a625a8b4bd3111f4(objectiveindex, num);
  thread function_974ee725f88fc501();
}

function function_a625a8b4bd3111f4(objectiveindex, num) {
  utility::flag_wait_either(self.script_noteworthy, "baseboss_death");
  objective_unsetlocation(objectiveindex, num);
}

function function_974ee725f88fc501() {
  note = self.script_noteworthy;
  utility::flag_wait_either(note, "baseboss_death");

  if(utility::flag("baseboss_death") || utility::flag("keycard_picked_up")) {
    return;
  }

  if(!function_408263f999f41641() || function_1e4aaaddfd5236ca()) {
    return;
  }

  function_4e7b3c7c40803a95();

  switch (note) {
    case #"hash_2f6aed6b50ad1e37":
      function_67506983eb892378();
      break;
    case #"hash_2f6aee6b50ad1fca":
      function_67506c83eb892a11();
      break;
    case #"hash_2f6aef6b50ad215d":
      function_67506b83eb8927de();
      break;
  }

  function_596ce1ff779d36a7();
}

function function_67506983eb892378() {
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_building1makingentry");
}

function function_67506c83eb892a11() {
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_checkingbuilding2");
}

function function_67506b83eb8927de() {
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_movinginternalbuildi");
}

function function_97ea6ab4a7bac67e(time) {
  if(level.player isonladder()) {
    while(!level.player isonladder()) {
      waitframe();
    }
  }

  while(level.player isonladder()) {
    waitframe();
  }

  setomnvar("ui_show_objectives", 1);
  showtime = 7;

  if(isDefined(time)) {
    showtime = time;
  }

  wait showtime;
  setomnvar("ui_show_objectives", 0);
}

function function_f5afce4fbdde1fd8() {
  struct = spawnStruct();
  struct.origin = (3870, 2700, 204);
  distmax = squared(900);

  while(true) {
    waitframe();

    if(utility::flag("final_button_pushed")) {
      break;
    }

    dist = distance2dsquared(level.player.origin, struct.origin);

    if(dist <= distmax) {
      break;
    }
  }

  if(!utility::flag("final_button_pushed")) {
    setomnvar("ui_show_objectives", 1);
  }

  utility::flag_wait_or_timeout("final_button_pushed", 6);
  setomnvar("ui_show_objectives", 0);
}

function function_61e183b8af11995() {
  add_global_spawn_function("axis", &function_1fff94dfc053e521);
  add_global_spawn_function("axis", &function_d770eb34f845615c);
  add_global_spawn_function("axis", &function_e56716161de57024);
  array_spawn_function_noteworthy("fakePlayer", &function_b9b329312ab21873);
  array_spawn_function_noteworthy("partner", &function_15bc474ae4e60f3f);
  array_spawn_function_noteworthy("truck_driver_intro", &function_a1b50967422392a4);
  array_spawn_function_noteworthy("stealth_fields_enemy", &function_4a4e875bd37f3e89);
  array_spawn_function_noteworthy("stealth_fields_1_enemy", &function_d72c27fc736ace49);
  array_spawn_function_noteworthy("stealth_fields_2_enemy", &function_fc8aa183d73025ea);
  array_spawn_function_targetname("stealth_fields_3", &function_d9833153356c3480);
  array_spawn_function_targetname("stealth_fields_4", &function_d9833153356c3480);
  array_spawn_function_targetname("upper_base_gate", &function_cb330f79e48f724b);
  array_spawn_function_noteworthy("upper_base_enemy", &function_d8e994d82077dae0);
  array_spawn_function_noteworthy("upper_base_interaction", &function_b99eeaed8a93f82c);
  array_spawn_function_noteworthy("upper_base_interaction_multi", &function_c25c6207ef06656e);
  array_spawn_function_noteworthy("upper_base_depot_enemy_1", &function_b49a6ed9f7ea38a9);
  array_spawn_function_noteworthy("upper_base_depot_enemy_2", &function_b49a6bd9f7ea3210);
  array_spawn_function_noteworthy("upper_base_boss", &function_90f133bd3ad3e515);
  array_spawn_function_noteworthy("upper_base_alarm_enemy", &function_fe2196e25c42a2c6);
  array_spawn_function_noteworthy("upper_base_heavy", &function_57c8fae7adcd9f33);
  array_spawn_function_noteworthy("upper_base_sniper", &function_730df4e78570c277);
  array_spawn_function_noteworthy("meetup_guard", &function_572cd76f06a4513);
  array_spawn_function_noteworthy("meetup_guard_stealth", &function_8f3166a9e9cf49cb);
  array_spawn_function_noteworthy("meetup_guard_alert", &function_2daaf50d00a0a882);
  array_spawn_function_noteworthy("server_room_postup", &function_13ce1e8d1697e7b4);
  array_spawn_function_noteworthy("server_room_flanker", &function_57ac1a37a433c47c);
  array_spawn_function_noteworthy("server_room_arrive", &function_89b13db6c88711d4);
  array_spawn_function_noteworthy("server_room_2_move_about", &function_5d8501439cd40867);
  array_spawn_function_noteworthy("control_room_postup", &function_2fcb9ddb5dc83db8);
  array_spawn_function_noteworthy("control_room_arrive", &function_5ddea4fc03f98460);
  array_spawn_function_noteworthy("control_room_sniper", &function_4e972e8a45d88d80);
  array_spawn_function_noteworthy("farah_stairs_threat", &function_5c49685918123f95);
  array_spawn_function_noteworthy("farah_stairs_nothreat", &function_2a927c048b1f5b42);
  array_spawn_function_noteworthy("second_floor_postup", &function_3740cebed99fd27c);
  array_spawn_function_noteworthy("2nd_floor_lmg", &function_60b9b730cca8faeb);
  array_spawn_function_noteworthy("silo_missile_room", &function_d7c0655b3db928d);
  array_spawn_function_noteworthy("silo_run_in", &function_3eb7732a6b1e14ad);
  array_spawn_function_noteworthy("silo_defend", &function_8c70c01de82a6294);
  array_spawn_function_noteworthy("tunnel_jugg_enemy", &function_3a5ad4768a185b26);
  array_spawn_function_noteworthy("tunnel_jugg_second_enemy", &function_416900e047103c81);
  array_spawn_function_noteworthy("tunnel_jugg", &function_7776ed0995a3a381);
  array_spawn_function_noteworthy("final_fight_enemy", &function_cd65d0f852ba711f);
  array_spawn_function_noteworthy("final_fight_enemy_aggr", &function_13d85585bee7ac69);
  array_spawn_function_noteworthy("final_fight_enemy_heli", &function_3d7da921abf780e8);
  array_spawn_function_noteworthy("final_fight_enemy_pilots", &function_ba0eea8a2f39a12e);
  array_spawn_function_noteworthy("final_fight_enemy_fixed", &function_54c376187683579a);
  array_spawn_function_noteworthy("final_fight_enemy_jugg", &function_9bf99b5220bfee9f);
}

function function_b9b329312ab21873() {
  self endon("death");
  level.fakeplayer = self;
  self.var_428407c1b0a62c2f = "fakePlayer_stop_loop";
  utility::name_hide();
  weapon = make_weapon("iw9_dm_mike14_sp", ["silencer01_br", "ammo_762n", "arscope_vz02", "bar_dm_p18_mike14", "grip_vertshort03", "iw9_rec_mike14", "mag_sn_large_p18", "pgrip_dm_p18", "stock_dm_light_p18"]);
  scripts\anim\shared::forceuseweapon(weapon, "primary");
}

function function_15bc474ae4e60f3f() {
  self endon("death");
  level.partner = self;
  scripts\common\ai::magic_bullet_shield();
  enable_ai_color();
  set_force_color("g");
  self.goalradius = 32;
  self.var_428407c1b0a62c2f = "partner_stop_loop";
  self setthreatbiasgroup("partner");
  weapon = make_weapon("iw9_ar_mcbravo_sp", ["silencer01_br", "ammo_blk", "bar_ar_light_p08|1", "grip_vertshort03|1", "iw9_selectsemi", "lasercyl_ads01|2", "mag_ar_heavy_p08|1", "pgrip_ar2_p08", "rec_mcbravo|1", "reflex07_tall", "stock_ar_tactical_p08|2"]);
  scripts\anim\shared::forceuseweapon(weapon, "primary");
  self.ignoreplayersuppressionlines = 1;
  self.ignoresuppression = 1;
  self enableavoidance(0);
  self.anim_playvo_func = &scripts\sp\dialogue::function_7bd4fbf21584d46e;
}

function function_1fff94dfc053e521() {
  self endon("death");
  function_dcbbd82bc61046d1();
}

function function_a1b50967422392a4() {
  self endon("death");
  self endon("alarm_tripped");
  self endon("alarm_notify");
  level endon("truck_driver_stopped");
  level.var_a6670846479f0f87 = self;
  self.goalradius = 32;
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread function_ab78e89f3cc2b7d5();
  thread function_5ca84a3afe2581a();
  utility::waittill_any_ents(self, "unloaded", self, "unload", level, "truck_driver_unloaded");
  self setgoalpos(self.origin);
  self.goalradius = 2048;
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread alarm_init();
  ids = function_b052fa8d568c8f0a(self.animname);
  function_323be8f4542e0ea6(ids);
}

function function_ab78e89f3cc2b7d5() {
  level endon("truck_driver_unloaded");
  self waittill("death");
  wait 0.1;
  level notify("truck_driver_stopped", "death");
}

function function_5ca84a3afe2581a() {
  level endon("truck_driver_unloaded");
  self endon("death");
  utility::waittill_any_ents(level, "truck_shot_at", self, "damage", self, "bulletwhizby", self, "alarm_notify");
  level notify("truck_driver_stopped", "unload");
  self setgoalpos(self.origin);
  self.goalradius = 800;
  self.ignoreall = 0;
  self.ignoreme = 0;
  utility::waittill_notify_or_timeout("unload", 6);
  enemies = getaiarray("axis");
  var_d08346ccb8ef116b = 0;
  distmax = squared(800);

  if(isDefined(enemies) && enemies.size > 0) {
    foreach(enemy in enemies) {
      result = undefined;

      if(isDefined(enemy) && isalive(enemy)) {
        result = enemy function_2759889b8ceacafc(self, distmax);
      }

      if(istrue(result)) {
        var_d08346ccb8ef116b = 1;
      }
    }

    if(istrue(var_d08346ccb8ef116b)) {
      function_2fb932e41fa56ad5("combat", level.player.origin);
    } else {
      function_2fb932e41fa56ad5("investigate", self.origin);
    }
  } else {
    function_2fb932e41fa56ad5("investigate", self.origin);
  }

  while(!istrue(self.bisincombat)) {
    wait 0.1;
  }

  self.goalradius = 2048;
}

function function_2759889b8ceacafc(driver, distmax) {
  self endon("death");
  dist = distancesquared(self.origin, driver.origin);

  if(dist >= distmax) {
    return undefined;
  }

  if(istrue(self.bisincombat) && is_equal(self.enemy, level.player)) {
    return 1;
  }

  function_2fb932e41fa56ad5("investigate", self.origin);
  return undefined;
}

function function_4a4e875bd37f3e89() {
  self endon("death");
  self.goalradius = 128;
  thread alarm_init();
}

function function_d72c27fc736ace49() {
  self endon("death");
  self endon("alarm_notify");
  self endon(utility::function_a1260c3b5f229f69());

  switch (self.animname) {
    case #"hash_a5f586cd3892a588":
      level.var_9a04df6e6fdfceae = self;
      level.var_9a051d6e6fe05708[0] = self;
      break;
    case #"hash_a5f589cd3892aa41":
      level.var_9a04de6e6fdfcc7b = self;
      level.var_9a051d6e6fe05708[1] = self;
      break;
  }

  self.var_428407c1b0a62c2f = self.animname + "_stop_loop";
  self.startorigin = self.origin;
  self.allowdeath = 1;

  while(level.var_9a051d6e6fe05708.size < 2) {
    waitframe();
  }

  switch (self.animname) {
    case #"hash_a5f586cd3892a588":
      self.otherguy = level.var_9a051d6e6fe05708[1];
      break;
    case #"hash_a5f589cd3892aa41":
      self.otherguy = level.var_9a051d6e6fe05708[0];
      break;
  }

  childthread function_642a2c7d04246a0d();
  childthread function_7352f179c369142f();
  thread stealth_watcher();
  animnode = utility::getStruct("poster_guy_1_animnode", "targetname");
  animnode childthread animation::anim_loop_solo(self, "idle_1", self.var_428407c1b0a62c2f);
  self.animnode = animnode;
  function_fc962f64b4d73414("player_close_to_field", 2000);
  animnode notify(self.var_428407c1b0a62c2f);
  animnode animation::anim_single_solo(self, "scene_2");
  animnode childthread animation::anim_loop_solo(self, "idle_2", self.var_428407c1b0a62c2f);
  wait 5;
  animnode notify(self.var_428407c1b0a62c2f);
  animnode childthread animation::anim_single_solo(self, "scene_3");
  childthread function_a03d86db6dc5eeb3(animnode);
  wait 16.5;
  function_127aac7a976f1a4a();
}

function function_a03d86db6dc5eeb3(animnode) {
  animnode endon(self.var_428407c1b0a62c2f);
  self endon("alarm_notify");
  self endon("combat");
  self waittillmatch("single anim", "end");
  animnode childthread animation::anim_loop_solo(self, "idle_3", self.var_428407c1b0a62c2f);
}

function function_4f8b3a424771dd64() {
  animnode = utility::getStruct("poster_guy_1_animnode", "targetname");
  truck = getEnt("poster_truck", "targetname");
  truck hidepart("tag_wheel_center_front_left_flat");
  truck hidepart("tag_wheel_center_front_right_flat");
  truck hidepart("tag_wheel_center_back_left_flat");
  truck hidepart("tag_wheel_center_back_right_flat");
  waitframe();
  truck assign_animtree("poster_truck");
  animnode anim_first_frame_solo(truck, "idle_1");
}

function function_127aac7a976f1a4a() {
  if(!isDefined(self.otherguy) || !isalive(self.otherguy)) {
    childthread function_bdca72a24868ce20();
  }
}

function function_bdca72a24868ce20() {
  corpses = getcorpsearrayinradius(self.origin, 750);
  var_ef40b8aba89e6768 = 0;
  origin = self.origin;

  if(isDefined(corpses) && corpses.size > 0) {
    foreach(corpse in corpses) {
      if(isDefined(corpse) && ray_trace_passed(self getEye(), corpse.origin + (0, 0, 30), [self])) {
        if(isDefined(corpse.origin)) {
          origin = corpse.origin;
        }

        var_ef40b8aba89e6768 = 1;
      }
    }
  }

  function_29d55ab51bfc3d73();
  wait 0.1;

  if(istrue(var_ef40b8aba89e6768)) {
    self aieventlistenerevent("saw_corpse", level.player, origin);
  } else {
    self aieventlistenerevent("investigate", level.player, self.origin);
  }

  self.sawsomething = 1;
}

function function_642a2c7d04246a0d() {
  distmax = squared(700);

  while(true) {
    waitframe();

    if(utility::flag("drone_in_use")) {
      continue;
    }

    if(self.bisincombat || isDefined(self.stealth) && self.var_fe5ebefa740c7106 != 0) {
      break;
    }

    if(self function_a4a9e73b2d25ff8b() || isDefined(self.var_fd01ad49b4e38ae8)) {
      break;
    }

    dist = distancesquared(level.player.origin, self.origin);

    if(dist <= distmax && !function_ebf6c163be94738a()) {
      if(scripts\engine\trace::can_see_origin(level.player getEye(), 0)) {
        break;
      }
    }

    if(isDefined(self.otherguy) && isalive(self.otherguy)) {
      if(istrue(self.otherguy.sawsomething) && scripts\engine\trace::can_see_origin(self.otherguy getEye(), 0)) {
        break;
      }
    }
  }

  self notify("combat");
  self.sawsomething = 1;
  function_bdca72a24868ce20();
}

function function_7352f179c369142f() {
  self waittill("damage");
  self.var_7ca70957c1a0fc3 = 1;
  self notify("alarm_notify");
  utility::anim_stopanimScripted();
  waitframe();
  asmname = self.asmname;
  statename = self asmgetcurrentstate(asmname);
  scripts\asm\soldier\pain::playpainanim(asmname, statename);
  waitframe();
  self notify("combat");
  self.var_7ca70957c1a0fc3 = undefined;
}

function stealth_watcher() {
  self endon("death");
  self endon(utility::function_a1260c3b5f229f69());
  result = waittill_any_return_5("bulletwhizby", "combat", "notify_ally", "stealth_combat", "stealth_investigate");
  wait 1;
  function_29d55ab51bfc3d73();

  while(is_equal(self.script, "pain") || istrue(self.var_7ca70957c1a0fc3)) {
    waitframe();
  }

  if(isDefined(result)) {
    switch (result) {
      case #"hash_13251ba402e7508":
      case #"hash_a6459f3fa26fc8bb":
      case #"hash_de811d1d5fa7e6b4":
        anim_sp::force_low_reaction();
        break;
      case #"hash_9e02cd4a0f3ca981":
      case #"hash_a4157a2f0345f08d":
        anim_sp::force_high_reaction();
        break;
    }
  }

  self.sawsomething = 1;

  if(isDefined(self.otherguy) && isalive(self.otherguy)) {
    self.otherguy thread function_bdca72a24868ce20();
  }
}

function function_29d55ab51bfc3d73() {
  self notify("alarm_notify");

  if(isDefined(self.animnode)) {
    self.animnode notify(self.var_428407c1b0a62c2f);
  }

  utility::anim_stopanimScripted();
  waitframe();
  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    model = self getattachmodelname(i);

    if(is_equal(model, "tool_spray_paint_can_01_bottle_black")) {
      self detach("tool_spray_paint_can_01_bottle_black", "tag_accessory_right");
    }
  }
}

function function_fc8aa183d73025ea() {
  self endon("death");
  self endon("alarm_tripped");
  self endon("alarm_notify");
  self.goalradius = 1000;
  childthread function_64ed25bde18c8870();
  function_fc962f64b4d73414("player_close_to_field_2", 2000);
  wait 1;
  utility::waittill_either("reached_path_end", "goal");
  self.goalradius = 1000;
  ids = [];
  ids[0] = function_5d6132045b29baf5(self.animname + "_01");
  ids[1] = function_5d6132045b29baf5(self.animname + "_02");
  ids[2] = function_5d6132045b29baf5(self.animname + "_03");
  function_323be8f4542e0ea6(ids);
}

function function_fc962f64b4d73414(msg, dist) {
  level endon(msg);
  maxdist = squared(dist);
  cosnum = cos(50);
  var_2a15108a1767270e = cos(15);
  utility::flag_wait("intro_finished");

  while(true) {
    waitframe();

    if(utility::flag("drone_in_use")) {
      continue;
    }

    dist = distance2dsquared(self.origin, level.player.origin);
    playereye = level.player getEye();
    playerangles = level.player getplayerangles();

    if(dist <= maxdist) {
      if(within_fov(playereye, playerangles, self.origin, cosnum)) {
        break;
      }
    }

    if(level.player isads()) {
      if(within_fov(playereye, playerangles, self.origin, var_2a15108a1767270e)) {
        if(ray_trace_passed(playereye, self getEye(), [self, level.player])) {
          break;
        }
      }
    }
  }

  flag_set(msg);
}

function function_d9833153356c3480() {
  self endon("death");
  level waittill("alarm_tripped_first_time");
  origin = level.player.origin;
  origin = getclosestpointonnavmesh(origin);
  thread function_ce2d18636e810f3a(origin, 0);
}

function function_cb330f79e48f724b() {
  self endon("death");
  level.var_1b1490e6f931ecd6[level.var_1b1490e6f931ecd6.size] = self;
  thread alarm_init();
  self function_d493e7fe15e5eaf4("default_no_ai");
}

function function_d8e994d82077dae0() {
  self endon("death");
  self.goalradius = 128;
  thread alarm_init();
}

function function_b99eeaed8a93f82c() {
  self endon("death");
  thread alarm_init();
}

function function_c25c6207ef06656e() {
  self endon("death");
  self.goalradius = 1000;
  thread alarm_init();
  ids = function_b052fa8d568c8f0a(self.animname);
  function_323be8f4542e0ea6(ids);
}

function function_b49a6ed9f7ea38a9() {
  self endon("death");
  self.goalradius = 128;
  thread alarm_init();
  self function_d493e7fe15e5eaf4("default_no_ai");
  distmax = squared(1000);
  distmin = squared(600);
  cosnum = cos(70);

  while(true) {
    wait 0.1;

    if(utility::flag("drone_in_use")) {
      continue;
    }

    dist = distance2dsquared(self.origin, level.player.origin);

    if(dist <= distmax) {
      playereye = level.player getEye();
      selfeye = self getEye();

      if(within_fov(playereye, level.player getplayerangles(), selfeye, cosnum)) {
        if(ray_trace_passed(playereye, selfeye, [self, level.player])) {
          break;
        }
      }
    }

    if(dist <= distmin) {
      break;
    }
  }

  flag_set("move_ai_depot_1");
}

function function_b49a6bd9f7ea3210() {
  self endon("death");
  self endon("alarm_notify");
  self endon(utility::function_a1260c3b5f229f69());
  truck = 0;

  switch (self.animname) {
    case #"hash_d1f9efa086fcca9a":
      level.var_6ac35acf418573b8 = self;
      level.var_6ac31ccf4184eb5e[0] = self;
      break;
    case #"hash_d1f9eea086fcc907":
      level.var_6ac35dcf41857a51 = self;
      level.var_6ac31ccf4184eb5e[1] = self;
      truck = 1;
      break;
  }

  self.goalradius = 128;
  self.allowdeath = 1;
  self.var_428407c1b0a62c2f = self.animname + "_stop_loop";
  thread alarm_init();
  self function_d493e7fe15e5eaf4("default_no_ai");
  animnode = utility::getStruct("spray_guy_1_animnode", "targetname");
  animnode childthread animation::anim_loop_solo(self, "idle_1", self.var_428407c1b0a62c2f);

  if(istrue(truck)) {
    thread function_c463d04efaaddd44(animnode);
  }

  distmax = squared(1000);
  distmin = squared(600);
  cosnum = cos(70);

  while(level.var_6ac31ccf4184eb5e.size < 2) {
    waitframe();
  }

  switch (self.animname) {
    case #"hash_d1f9efa086fcca9a":
      self.otherguy = level.var_6ac31ccf4184eb5e[1];
      break;
    case #"hash_d1f9eea086fcc907":
      self.otherguy = level.var_6ac31ccf4184eb5e[0];
      break;
  }

  childthread function_642a2c7d04246a0d();
  childthread function_7352f179c369142f();
  thread stealth_watcher();

  while(true) {
    waitframe();

    if(utility::flag("drone_in_use")) {
      continue;
    }

    if(utility::flag("move_ai_depot_2")) {
      break;
    }

    dist = distance2dsquared(self.origin, level.player.origin);

    if(dist <= distmax || level.player isads()) {
      playereye = level.player getEye();
      selfeye = self getEye();

      if(utility::within_fov(playereye, level.player getplayerangles(), selfeye, cosnum)) {
        if(trace::ray_trace_passed(playereye, selfeye, [self, level.player])) {
          break;
        }
      }
    }

    if(dist <= distmin) {
      break;
    }
  }

  utility::flag_set("move_ai_depot_2");
  animnode notify(self.var_428407c1b0a62c2f);
  animnode anim_single_solo(self, "scene_2");
  animnode childthread anim_loop_solo(self, "idle_2", self.var_428407c1b0a62c2f);
  wait 5;
  animnode notify(self.var_428407c1b0a62c2f);
  animnode anim_single_solo(self, "exit");
  function_127aac7a976f1a4a();
}

function function_c463d04efaaddd44(animnode) {
  truck = getEnt("painter_truck", "targetname");
  truck assign_animtree("painter_truck");
  animnode childthread animation::anim_loop_solo(truck, "idle_1", "stop_truck_loop");
  truck hidepart("tag_wheel_center_front_left_flat");
  truck hidepart("tag_wheel_center_front_right_flat");
  truck hidepart("tag_wheel_center_back_left_flat");
  truck hidepart("tag_wheel_center_back_right_flat");
  result = waittill_any_ents_return(self, "death", level, "move_ai_depot_2");
  animnode notify("stop_truck_loop");
  animnode thread animation::anim_single_solo(truck, "scene_2");

  while(true) {
    if(!isDefined(self) || !isalive(self)) {
      truck setanimrate(truck getanim("scene_2"), 0);
      break;
    }

    waitframe();
  }
}

function function_90f133bd3ad3e515() {
  self endon("death");
  thread function_4831cc9cdac32cda();
  level.baseboss = self;
  self.goalradius = 1000;
  self function_d493e7fe15e5eaf4("default_no_ai");
  ids = function_b052fa8d568c8f0a(self.animname);
  childthread function_323be8f4542e0ea6(ids);
  childthread function_54504ff39113ddca();
  utility::flag_set("base_boss_spawned");
}

function function_54504ff39113ddca() {
  level endon("baseboss_death");
  utility::flag_wait("player_in_base");
  distmax = squared(800);
  cosnum = cos(25);
  var_f982854c8891564a = cos(10);
  breakout = 0;

  while(true) {
    dist = distance2dsquared(level.player.origin, self.origin);

    if(dist <= distmax) {
      breakout = function_78fa3eb1e77fc1eb(cosnum);
    } else if(level.player utility::isads()) {
      breakout = function_78fa3eb1e77fc1eb(var_f982854c8891564a);
    }

    if(istrue(breakout) && function_408263f999f41641()) {
      break;
    }

    wait 0.1;
  }

  utility::flag_set("baseBoss_spotted");
  thread function_8bd731f2f78a3dbc();
}

function function_8bd731f2f78a3dbc() {
  function_3bb94732214d7da7(0.1);

  if(!utility::flag("baseboss_death")) {
    utility::battlechatter_off();

    if(function_1e4aaaddfd5236ca()) {
      level.player dialogue::say_team("dx_sp_jslo_inex_pric_goteyesonthecaptain");
      wait 0.2;
    } else {
      level.player dialogue::say_team("dx_sp_jslo_inex_pric_visualonthecaptain");
      wait 0.2;
    }

    utility::battlechatter_on();
  }

  function_596ce1ff779d36a7();
}

function function_78fa3eb1e77fc1eb(cosnum) {
  timemax = gettime() + 350;

  while(true) {
    waitframe();
    playereye = level.player getEye();
    selfeye = self getEye();

    if(utility::within_fov(playereye, level.player getplayerangles(), selfeye, cosnum)) {
      if(gettime() >= timemax && trace::ray_trace_passed(playereye, selfeye, [self, level.player])) {
        return 1;
      }

      continue;
    }

    return 0;
  }
}

function function_4831cc9cdac32cda() {
  self waittill("death");
  origin = self.origin;
  origin = utility::drop_to_ground(origin, 50, -10);
  offset = (0, 0, 0);
  level.keycard = spawn("script_model", origin + offset);
  level.keycard setModel("un_military_backpack_01");
  thread function_e84d33ffcd5a4eda();
  utility::flag_set("baseBoss_spotted");
  utility::flag_set("baseboss_death");
  utility::battlechatter_off();
  thread function_72a008d8d9461dae();
  thread player::focus_display_hint(5, 1);
  level.keycard cursor_hint::create_cursor_hint("tag_origin", (0, 0, 5), &"SP_JUP_SILO/CURSOR_KEYCARD", 360, 500, 100, 1, undefined, undefined, "hud_icon_loot_keycard_jugg_maze");
  level.keycard waittill("trigger");
  utility::flag_set("keycard_picked_up");
  utility::flag_set("force_autosave");
  thread function_d3b3097e22309f24();
  thread utility::play_sound_in_space("weap_pickup", level.keycard.origin);
  level.player forceplaygestureviewmodel("iw9_ges_pickup");
  wait 0.15;
  level.keycard delete();
  wait 0.2;
  utility::battlechatter_on();
}

function function_e84d33ffcd5a4eda() {
  keycard = spawn("script_model", (2374, 2908, 204.5));
  keycard setModel("electronics_keycard_office_01");
  level waittill("keycard_done");
  keycard delete();
}

function function_72a008d8d9461dae() {
  function_3bb94732214d7da7(0.4);

  if(function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_kilokonnicaptainsdow");
    wait 0.3;

    if(!utility::flag("keycard_picked_up")) {
      level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_youneedthatkeycardfo");
    }
  } else {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_konnicaptainsdown");
    wait 0.3;

    if(!utility::flag("keycard_picked_up")) {
      level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_confirmwhenyougetthe");
    }
  }

  function_596ce1ff779d36a7();
}

function function_d3b3097e22309f24() {
  function_3bb94732214d7da7(0.3);

  if(function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_keycardssecure");
    wait 0.7;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_captainyouhavemoreko");
    wait 0.3;
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_allpartoftheplan");
    wait 0.5;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_getthroughdoorillfin");
  } else {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_gotthekeycard");
    wait 0.7;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_copythativefoundanin");
    wait 0.3;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_kiloout");
  }

  function_596ce1ff779d36a7();
}

function function_fe2196e25c42a2c6() {
  self endon("death");
  thread alarm_init();
  self function_d493e7fe15e5eaf4("default_no_ai");
}

function function_57c8fae7adcd9f33() {
  self endon("death");
  thread alarm_init();
  self function_d493e7fe15e5eaf4("default_no_ai");
}

function function_730df4e78570c277() {
  self endon("death");
  thread alarm_init();
  thread function_ab9ff063d4430687();
  laser_on();
  self function_d493e7fe15e5eaf4("jup_sandbox_sniper");
  utility::waittill_any_ents(level, "alarm_tripped_first_time", self, "alarm_tripped");
  vol = getEnt("upper_sniper_alert_vol", "targetname");
  self setgoalvolumeauto(vol);
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
}

function function_ab9ff063d4430687() {
  self waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    function_8703c62c009fbe06();
    wait 1;

    if(!function_1e4aaaddfd5236ca() && function_408263f999f41641()) {
      function_4e7b3c7c40803a95();
      level.player dialogue::say_team("dx_sp_jslo_inex_pric_tookouttheiroverwatc");
      wait 0.2;
      function_596ce1ff779d36a7();
    }
  }
}

function laser_on() {
  self.laserenabled = 1;
  self updatelaserstatus();
}

function laser_off() {
  self.laserenabled = 0;
  self updatelaserstatus();
}

function function_572cd76f06a4513() {
  self endon("death");

  switch (self.animname) {
    case #"hash_5c97276458d6f4c1":
      change_body("body_c_jup_sp_enemy_pmc_rusher_01", "head_c_jup_sp_enemy_pmc_rusher_01");
      break;
    case #"hash_5c97246458d6f008":
      change_body("body_c_jup_sp_enemy_pmc_rusher_02", "head_c_jup_sp_enemy_pmc_rusher_02");
      ai::gun_remove();
      break;
    case #"hash_5c97256458d6f19b":
      change_body("body_c_jup_sp_enemy_pmc_rusher_03", "head_c_jup_sp_enemy_pmc_rusher_03");
      ai::gun_remove();
      break;
  }

  ai::magic_bullet_shield();
}

function change_body(body, head) {
  if(isDefined(body)) {
    self setModel(body);
  }

  if(isDefined(head)) {
    self detach(self.headmodel);
    self.headmodel = head;
    self attach(self.headmodel);
  }
}

function function_8f3166a9e9cf49cb() {
  self endon("death");
  self.goalradius = 100;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalpos(self.origin);
  var_e94d220ef8fc983d = squared(380);
  distmax = squared(530);
  self.script_deathflag = "meetup_guard_hallway_death";
  thread ai::ai_deathflag();

  switch (self.animname) {
    case #"hash_23271fa5afaf53ed":
      level.var_51729ce379271e4[0] = self;
      break;
    case #"hash_23271ca5afaf4f34":
      level.var_51729ce379271e4[1] = self;
      break;
  }

  while(level.var_51729ce379271e4.size < 2) {
    waitframe();
  }

  switch (self.animname) {
    case #"hash_23271fa5afaf53ed":
      self.otherguy = level.var_51729ce379271e4[1];
      break;
    case #"hash_23271ca5afaf4f34":
      self.otherguy = level.var_51729ce379271e4[0];
      break;
  }

  close = 0;
  endtime = undefined;

  while(true) {
    selfeye = self getEye();
    playereye = level.player getEye();
    playerangles = level.player getplayerangles();
    dist = distancesquared(level.player.origin, self.origin);

    if(dist <= var_e94d220ef8fc983d && function_957f095f7648a233(selfeye, playereye)) {
      break;
    } else if(dist <= distmax && function_957f095f7648a233(selfeye, playereye)) {
      if(!close) {
        close = 1;
        endtime = gettime() + 350;
      }

      if(close && gettime() >= endtime) {
        break;
      }
    } else if(close) {
      close = 0;
    }

    if(level.player isfiring()) {
      if(trace::ray_trace_passed(selfeye, playereye, [self, level.player])) {
        break;
      }
    }

    if(utility::flag("meetup_guard_stealth_alert")) {
      wait 0.2;
      break;
    }

    if(!isDefined(self.otherguy) || !isalive(self.otherguy)) {
      break;
    }

    if(isDefined(self.otherguy) && isalive(self.otherguy) && istrue(self.otherguy.bisincombat)) {
      break;
    }

    wait 0.1;
  }

  utility::flag_set("meetup_guard_stealth_alert");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self getenemyinfo(level.player);
  self function_1aff80c5fc5a3eea("alert");
}

function function_957f095f7648a233(selfeye, playereye) {
  if(trace::ray_trace_passed(selfeye, playereye, [self, level.player])) {
    return true;
  }

  return false;
}

function function_2daaf50d00a0a882() {
  self endon("death");
  self.goalradius = 800;
  self.fixednode = 1;
  self.script_deathflag = "meetup_guard_hallway_death";
  thread ai::ai_deathflag();
  flag_wait("player_in_elevator");
  self getenemyinfo(level.player);
}

function function_13ce1e8d1697e7b4() {
  self endon("death");
  waitframe();
  self.fixednode = 1;
  self.fixednodesaferadius = 32;
  self.goalradius = 32;

  if(is_equal(self.animname, "stay") && is_equal(self.script_deathflag, "server_room_2_death")) {
    level.var_cedf9d7173ebdd93 = self;
    thread function_84296e286da4320f();
    childthread function_d9f79323a7c46323();
    function_744c1d6dc1393770("server_room_2_goalvolume");
    return;
  }

  function_744c1d6dc1393770("server_room_goalvolume");
}

function function_57ac1a37a433c47c() {
  self endon("death");
  waitframe();
  self.fixednode = 1;
  self.fixednodesaferadius = 32;
  self.goalradius = 32;
  function_744c1d6dc1393770("server_room_goalvolume");
}

function function_89b13db6c88711d4() {
  self endon("death");
}

function function_5d8501439cd40867() {
  self endon("death");
  waitframe();
  self.fixednode = 1;
  self.fixednodesaferadius = 32;
  self.goalradius = 32;

  if(istrue(level.var_ff33e78edae731ba)) {
    level.var_ff33e78edae731ba = undefined;
    childthread function_8f84fba0133f3591();
  }

  thread function_84296e286da4320f();
  function_744c1d6dc1393770("server_room_2_goalvolume");
}

function function_d9f79323a7c46323() {
  utility::flag_wait("player_at_server_room_stairs");
  wait 0.2;
  dialogue::say_global("dx_sp_jslo_itrp_kon1_getreadyforthebastar");
}

function function_8f84fba0133f3591() {
  self endon("weapon_fired");
  wait 0.2;
  dialogue::say_global("dx_sp_jslo_itrp_kon1_unloadonthemwhenthey");
  wait 0.5;
  dialogue::say_global("dx_sp_jslo_itrp_kon1_iminposition");
  wait 1;
  dialogue::say_global("dx_sp_jslo_itrp_kon2_gunsonthedoortheyrec");
  wait 1.5;
  dialogue::say_global("dx_sp_jslo_itrp_kon3_thesemotherfuckersdi");
  wait 1;
  dialogue::say_global("dx_sp_jslo_itrp_kon1_noprisonerskillthema");
}

function function_84296e286da4320f() {
  level endon("stop_room_2_death");
  level endon("player_in_control_room");
  self waittill("death", attacker);
  wait 0.8;

  if(utility::flag("player_in_control_room")) {
    return;
  }

  if(utility::flag("server_room_2_death") && istrue(level.var_d54d7b6adec74d65)) {
    level.var_d54d7b6adec74d65 = undefined;

    if(isDefined(attacker) && isPlayer(attacker) && function_408263f999f41641()) {
      level.player thread dialogue::say_team("dx_sp_jslo_itrp_pric_clear");
      level notify("stop_room_2_death");
    }
  }
}

function function_2fcb9ddb5dc83db8() {
  self endon("death");
  childthread function_c7fffbf9405fcdb8(1.5);
  function_c4a4f968064e97df("player_in_control_room");
}

function function_4e972e8a45d88d80() {
  self endon("death");
  laser_on();
  childthread function_c7fffbf9405fcdb8(1.8);
  function_c4a4f968064e97df("player_in_control_room");
}

function function_5ddea4fc03f98460() {
  self endon("death");
  function_c4a4f968064e97df("player_in_control_room");
}

function function_c7fffbf9405fcdb8(time) {
  self.ignoreme = 1;
  wait time;
  self.ignoreme = 0;
}

function function_c4a4f968064e97df(msg) {
  if(!utility::flag(msg)) {
    utility::set_battlechatter(0);
    utility::flag_wait(msg);
    utility::set_battlechatter(1);
  }
}

function function_5c49685918123f95() {
  self endon("death");
  self setthreatbiasgroup("partner_threat");
}

function function_2a927c048b1f5b42() {
  self endon("death");
  self setthreatbiasgroup("partner_nothreat");
}

function function_3740cebed99fd27c() {
  self endon("death");
  self.goalradius = 400;
}

function function_60b9b730cca8faeb() {
  self endon("death");
  struct = utility::getStruct("2nd_floor_lmg_struct", "targetname");
  struct2 = utility::getStruct(struct.target, "targetname");
  aiment = utility::spawn_script_origin(struct.origin, struct.angles);
  self.goalradius = 32;
  self.disablereload = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  cosnum = cos(30);
  childthread function_9c04fcc26150e8a1(self.origin, struct.origin);
  wait 0.5;

  while(true) {
    waitframe();
    playereye = level.player getEye();
    selfeye = self.origin + (0, 0, 60);

    if(sighttracepassed(selfeye, playereye, 0, self, level.player)) {
      if(trace::ray_trace_passed(selfeye, playereye, [self, level.player])) {
        break;
      }
    }
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
  self.shootstyleoverride = "full";
  self.ignoresuppression = 1;
  utility::set_dontmelee(1);
  laser_on();
  childthread function_b7b86b817fe43dcb(aiment, struct, struct2);
  function_789615731633828b(aiment);
  self notify("stop_aim_ent");
  self clearentitytarget(aiment);
  self getenemyinfo(level.player);
  self.ignoresuppression = 0;
  utility::set_dontmelee(0);
  aiment delete();
}

function function_9c04fcc26150e8a1(origin1, origin2) {
  wait 1.5;
  glassradiusdamage(origin1, 150, 10000, 9000);
  wait 1;
  glassradiusdamage(origin2, 150, 10000, 9000);
}

function function_b7b86b817fe43dcb(aiment, struct, struct2) {
  level endon("stop_lmg");
  self endon("stop_aim_ent");

  while(true) {
    aiment moveTo(struct2.origin, 6);
    wait 6;
    aiment moveTo(struct.origin, 6);
    wait 6;
  }
}

function function_789615731633828b(aiment) {
  var_ca5dce4c786ba706 = 0;

  while(true) {
    waitframe();

    if(utility::flag("stop_lmg")) {
      break;
    }

    playereye = level.player getEye();
    selfeye = self.origin + (0, 0, 60);

    if(sighttracepassed(selfeye, playereye, 0, self, level.player) && trace::ray_trace_passed(selfeye, playereye, [self, level.player])) {
      if(var_ca5dce4c786ba706) {
        self clearentitytarget(aiment);
        var_ca5dce4c786ba706 = 0;
      }

      utility::set_favoriteenemy(level.player);
      self getenemyinfo(level.player);
      continue;
    }

    var_ca5dce4c786ba706 = 1;
    self setentitytarget(aiment);
  }
}

function function_d7c0655b3db928d() {
  self endon("death");
  animnode = utility::getStruct("cctv_animnode", "targetname");
  self.goalradius = 400;
  self.allowdeath = 1;
  thread function_e7daf9a90981b40d();
  msg = undefined;

  switch (self.animname) {
    case #"hash_49099d38ff0cef6":
      msg = "silo_room_kill_1";
      break;
    case #"hash_49098d38ff0cd63":
      msg = "silo_room_kill_2";
      break;
    case #"hash_49097d38ff0cbd0":
      msg = "silo_room_kill_2";
      break;
  }

  ai::gun_remove();
  animnode childthread animation::anim_loop_solo(self, "silo_idle");
  level waittill(msg);

  if(isDefined(level.partner)) {
    self kill(level.partner.origin, level.partner);
    return;
  }

  self kill(level.player.origin, level.player);
}

function function_e7daf9a90981b40d() {
  self waittill("death");
  level notify("stop_pre_missile_silo_vo");
}

function function_3eb7732a6b1e14ad() {
  self endon("death");
  self.goalradius = 32;
  self getenemyinfo(level.player);
}

function function_8c70c01de82a6294() {
  self endon("death");
  self.goalradius = 400;
  self getenemyinfo(level.player);
}

function function_3a5ad4768a185b26() {
  self endon("death");
  self.goalradius = 800;
  self setgoalpos(self.origin);
  utility::flag_wait("jugg_sees_player");
  self.runngun = 1;
  self getenemyinfo(level.player);
  vol = getEnt("tunnel_jugg_enemy_volume", "targetname");
  self setgoalvolumeauto(vol);
}

function function_416900e047103c81() {
  self endon("death");
  self.goalradius = 800;
  self.runngun = 1;
  self getenemyinfo(level.player);
  childthread function_17ec2637c87d3402();
}

function function_7776ed0995a3a381() {
  self endon("death");
  self.goalradius = 32;
  self setgoalpos(self.origin);
  function_3541d359de2df108();
  childthread function_a50197b534a9a1f1();
}

function function_a50197b534a9a1f1() {
  thread function_496a5d63d1927455();
  thread function_1202c236b5c317b0();
  distmax = squared(650);
  self.ignoreme = 1;
  self.ignoreall = 1;

  while(true) {
    wait 0.2;
    dist = distance2dsquared(self.origin, level.player.origin);

    if(dist <= distmax) {
      break;
    }

    if(self.health < self.maxhealth) {
      break;
    }
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  self.disablereload = 1;
  self.goalradius = 1500;
  self getenemyinfo(level.player);
  self setgoalpos(level.player.origin);
  cosnum = cos(50);
  var_4dc328e60cd0f41e = self.maxhealth / 3;
  var_2aba2ab4a35a7f0c = 0;

  while(true) {
    playereye = level.player getEye();
    playerangles = level.player getplayerangles();
    var_4c09b281a5a0573 = self getEye();

    if(sighttracepassed(var_4c09b281a5a0573, playereye, 1, undefined)) {
      if(trace::ray_trace_passed(var_4c09b281a5a0573, playereye, [self, level.player])) {
        break;
      }
    }

    if(utility::within_fov(playereye, playerangles, self.origin, cosnum)) {
      if(trace::ray_trace_passed(playereye, var_4c09b281a5a0573, [self, level.player])) {
        var_2aba2ab4a35a7f0c = 1;
        break;
      }
    }

    wait 0.1;
  }

  utility::flag_set("jugg_sees_player");
  thread function_388bcf58ec5e7630(var_2aba2ab4a35a7f0c, cosnum);
  wait 1;
  childthread function_462afb2afca450a3();

  while(true) {
    if(utility::flag("tunnel_jugg_enemy_dead")) {
      break;
    }

    if(self.health <= var_4dc328e60cd0f41e) {
      break;
    }

    wait 0.1;
  }

  wait 0.2;
  utility::flag_set("jugg_half_health");
}

function function_1202c236b5c317b0() {
  self waittill("death");
  utility::flag_set("tunnel_jugg_dead");
}

function function_388bcf58ec5e7630(var_2aba2ab4a35a7f0c, cosnum) {
  function_b787e80770e10f5a(var_2aba2ab4a35a7f0c, cosnum);
  wait 1.2;

  if(function_408263f999f41641() && !utility::flag("tunnel_jugg_dead")) {
    level.player dialogue::say_team("dx_sp_jslo_roof_pric_enemyjuggernaut");
  }

  if(!utility::flag("tunnel_jugg_dead")) {
    utility::flag_wait("tunnel_jugg_dead");
  }

  wait 1.5;

  if(function_408263f999f41641()) {
    level.player dialogue::say_team("dx_sp_jslo_roof_pric_enemyjuggernautsdown");
  }
}

function function_b787e80770e10f5a(var_2aba2ab4a35a7f0c, cosnum) {
  self endon("death");

  if(!istrue(var_2aba2ab4a35a7f0c)) {
    while(true) {
      wait 0.1;
      playereye = level.player getEye();
      playerangles = level.player getplayerangles();
      var_4c09b281a5a0573 = self getEye();

      if(utility::within_fov(playereye, playerangles, self.origin, cosnum)) {
        if(trace::ray_trace_passed(playereye, var_4c09b281a5a0573, [self, level.player])) {
          break;
        }
      }
    }
  }
}

function function_496a5d63d1927455() {
  utility::waittill_any_ents_return(self, "death", level, "jugg_half_health", level, "tunnel_jugg_enemy_dead");
  utility::flag_set("jugg_half_health");
  utility::array_spawn_targetname("tunnel_jugg_second_enemy", 1);
}

function function_3541d359de2df108() {
  self.armorbreak = 0;
  self.maxhealth = 8500;
  self.health = 8500;
  self function_2ec5d600c5d338e9("specialty_melee_invulnerable", 1);
  childthread utility::add_damage_function(&function_513dbd22af16435b);
}

function function_d68f3affbbfccf4d(var_fd3007cc6805d1dd, var_a078843598f291b8, sound_name, partname, armoramount) {
  if(damagefeedback::isheadshot(partname)) {
    ai_armor::function_758ea9f162c62fdc(sound_name, var_a078843598f291b8, armoramount);
    return;
  }

  ai_armor::function_758ea9f162c62fdc(sound_name, var_fd3007cc6805d1dd, armoramount);
}

function function_513dbd22af16435b(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(self.health >= 5000) {
    function_d68f3affbbfccf4d("hitveharmor", "hithelmetlight", "hit_marker_3d_lrg_armor", level.var_d43e78e513933216[partname], 3);
    return;
  }

  if(self.health >= 2500) {
    function_d68f3affbbfccf4d("hitveharmor", "hithelmetlight", "hit_marker_3d_med_armor", level.var_d43e78e513933216[partname], 2);
    return;
  }

  if(self.health >= 1000) {
    function_d68f3affbbfccf4d("hitveharmor", "hithelmetlight", "hit_marker_3d_armor", level.var_d43e78e513933216[partname]);
    return;
  }

  if(istrue(self.armorbreak)) {
    return;
  }

  function_d68f3affbbfccf4d("hitveharmorbreak", "hithelmetheavybreak", "hit_marker_3d_armor_break", level.var_d43e78e513933216[partname]);
  self.armorbreak = 1;
}

function function_cd65d0f852ba711f() {
  self endon("death");
  utility::flag_wait("start_upper_ambush");
  wait 0.1;
  vol = getEnt("final_fight_enemy", "targetname");
  self setgoalvolumeauto(vol);
  self getenemyinfo(level.player);
}

function function_13d85585bee7ac69() {
  self endon("death");
  self.goalradius = 1000;
  self.runngun = 1;
  utility::flag_wait("start_upper_ambush");
  wait 0.1;
  vol = getEnt("final_fight_enemy_aggr", "targetname");
  self setgoalvolumeauto(vol);
  self getenemyinfo(level.player);
  wait 0.1;
  childthread function_17ec2637c87d3402();
}

function function_3d7da921abf780e8() {
  self endon("death");
  self.goalradius = 1000;
  self.runngun = 1;
  self getenemyinfo(level.player);
}

function function_ba0eea8a2f39a12e() {
  self endon("death");
  self.health = 300;
  self.maxhealth = self.health;
  thread pilot_death_watcher();
  scripts\common\ai::gun_remove();
  tag = "tag_seat_0";
  offset = (-9, 10, 10);

  if(is_equal(self.animname, "copilot")) {
    tag = "tag_seat_1";
    offset = (-9, -13, 10);
  }

  animnode = spawn_tag_origin(level.heli gettagorigin(tag), level.heli gettagangles(tag));
  animnode linkTo(level.heli, tag, offset, (0, 0, 0));
  self linkTo(animnode, "tag_origin", (0, 0, 0), (0, 0, 0));
  waitframe();
  animnode thread anim_loop_solo(self, "heli_pilot_idle", "stop_pilot_loop");
  level waittill("heli_death");
  self delete();
}

function pilot_death_watcher() {
  self waittill("death", attacker, meansofdeath, weaponobject, damagelocation);

  if(isDefined(level.heli) && isalive(level.heli)) {
    level.heli endon("death");

    if(level.heli vehicle::vehicle_is_crashing() || !isPlayer(attacker)) {
      return;
    }

    level.heli.pilot_killed = 1;
    level.heli dodamage(level.heli.health + 500000, level.player.origin, level.player);
  }
}

function function_54c376187683579a() {
  self endon("death");
  self.combatmode = "ambush";
  self.fixednode = 1;
  self.var_98add129a7ecb962 = 0;
  self.var_428407c1b0a62c2f = "stop_loop_" + self.animname;
  animnode = utility::getStruct("outro_animnode", "targetname");
  var_4f5da32e76b66561 = 0;

  switch (self.animname) {
    case #"hash_b1814a65888b98f0":
      var_4f5da32e76b66561 = 1;
      level.var_937981019a8768f6[0] = self;
      break;
    case #"hash_b1814d65888b9da9":
      level.var_937981019a8768f6[1] = self;
      break;
  }

  self getenemyinfo(level.player);

  if(var_4f5da32e76b66561) {
    self.allowdeath = 1;
    ai::disable_surprise();
    childthread function_f1509de99bdb5fc9();
    animnode childthread animation::anim_loop_solo(self, "finale_idle", self.var_428407c1b0a62c2f);
    utility::flag_set("finale_enemy_spawned");
    distmax = squared(350);

    while(true) {
      if(utility::flag("finale_enemy_react")) {
        break;
      }

      dist = distancesquared(level.player.origin, self.origin);

      if(dist <= distmax) {
        if(trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self])) {
          break;
        }
      }

      waitframe();
    }

    utility::flag_set("finale_enemy_react");
    animnode notify(self.var_428407c1b0a62c2f);
    animnode animation::anim_single_solo(self, "finale_react");
  } else {
    distmax = squared(500);

    while(true) {
      if(utility::flag("finale_enemy_react")) {
        break;
      }

      result = utility::waittill_any_ents_return(self, "weapon_fired", level, "finale_enemy_react");
      dist = distancesquared(level.player.origin, self.origin);

      if(dist <= distmax) {
        break;
      }

      waitframe();
    }

    utility::flag_set("finale_enemy_react");
  }

  self getenemyinfo(level.player);
}

function function_f1509de99bdb5fc9() {
  while(level.var_937981019a8768f6.size < 2) {
    wait 0.1;
  }

  level.var_937981019a8768f6[0] endon("death");
  level.var_937981019a8768f6[1] endon("death");

  if(function_408263f999f41641()) {
    level notify("new_key_vo");
    level endon("new_key_vo");
    level.player dialogue::stop_dialogue();
    level.var_a267818b73bf19f2 dialogue::stop_dialogue();
    function_4e7b3c7c40803a95();
    level.player dialogue::say_team("dx_sp_jslo_roof_pric_pushingintothecontro");
    wait 0.1;
    function_596ce1ff779d36a7();
  }

  level.var_937981019a8768f6[0] dialogue::say_global("dx_sp_jslo_roof_kon5_theyrecoming");
  wait 0.5;
  level.var_937981019a8768f6[1] dialogue::say_global("dx_sp_jslo_roof_kon6_launchthemissilesill");
  wait 0.8;
  level.var_937981019a8768f6[0] dialogue::say_global("dx_sp_jslo_roof_kon5_stage1completestage2");
  wait 1.8;
  level.var_937981019a8768f6[0] dialogue::say_global("dx_sp_jslo_roof_kon5_itsdonemissileislaun");
}

function function_9bf99b5220bfee9f() {
  self endon("death");
  self.goalradius = 32;
  self getenemyinfo(level.player);
  utility::set_favoriteenemy(level.player);
  function_3541d359de2df108();
  childthread function_fbbbe976edc7f645();
  distmax = squared(1000);
  var_4dc328e60cd0f41e = self.maxhealth / 3;

  while(true) {
    waitframe();
    dist = distance2dsquared(level.player.origin, self.origin);

    if(dist <= distmax) {
      break;
    }

    if(self.health <= var_4dc328e60cd0f41e) {
      break;
    }
  }

  self cleargoalvolume();
  self.goalradius = 1200;
  wait 0.1;
  childthread function_462afb2afca450a3();
  utility::flag_set("force_move_heli");
}

function function_fbbbe976edc7f645() {
  cosnum = cos(50);
  distmax = squared(1200);

  while(true) {
    wait 0.1;
    dist = distancesquared(self.origin, level.player.origin);

    if(dist >= distmax) {
      continue;
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();
    var_4c09b281a5a0573 = self getEye();

    if(sighttracepassed(var_4c09b281a5a0573, playereye, 1, undefined)) {
      if(trace::ray_trace_passed(var_4c09b281a5a0573, playereye, [self, level.player])) {
        break;
      }
    }

    if(utility::within_fov(playereye, playerangles, self.origin, cosnum)) {
      if(trace::ray_trace_passed(playereye, var_4c09b281a5a0573, [self, level.player])) {
        break;
      }
    }
  }

  level.player playSound("mus_jup_d156_juggernaut_stinger");
  level.player setsoundsubmix("sp_jup_silo_jugg_stinger_sfx");
  level.player setsoundsubmix("sp_jup_silo_jugg_stinger_mus");
}

function function_dcbbd82bc61046d1() {
  name = self.classname;

  if(!isDefined(name)) {
    return;
  }

  weapon = undefined;

  switch (name) {
    case #"hash_36054a175047dd61":
    case #"hash_9dabdbf2f66002ac":
    case #"hash_ba438ee93f0269eb":
      weapon = make_weapon("iw9_sm_aviktor_sp", ["pgrip_p04", "stock_sm_tactical_p04", "mag_sm_large_p04", "reflex01_tall", "grip_angled02", "flash_sm_01"]);
      break;
    case #"hash_334480bfab888493":
    case #"hash_db531894722ecdc4":
    case #"hash_f8f509372cc710ea":
      weapon = make_weapon("iw9_sh_mike1014_sp");
      break;
    case #"hash_5bd14af2d4186c69":
    case #"hash_78ec2542db5b1acf":
    case #"hash_e03f8be953278932":
    case #"hash_f0cb8b17b2878eb4":
      weapon = make_weapon("iw9_lm_rkilo_sp", ["pgrip_p04", "bar_lm_long_p04", "stock_lmg_heavy_p04", "drum_lm_large_p04", "holo02", "grip_angled02", "comp_br_01"]);
      break;
    case #"hash_1abcf0e97195fb51":
    case #"hash_20ef05f2b55a7aca":
    case #"hash_b5e8201793c7ce43":
      weapon = make_weapon("iw9_dm_scromeo_sp", ["pgrip_p05", "bar_sn_long_p05", "stock_ar_heavy_p05", "mag_sn_large_p05", "fourx04", "grip_angled02", "comp_br_05"]);
      break;
    case #"hash_1eee2bf7b5849180":
    case #"hash_44a41989e78f38c3":
    case #"hash_685b19aa2ff9a4ed":
      weapon = make_weapon("iw9_ar_akilo105_sp", ["pgrip_p04_akilo105", "iw9_minireddot02_tall", "stock_sm_tactical_p04", "bar_ar_heavy_p04", "mag_ar_lgtlarge_p04", "grip_vert01", "comp_ar_01"]);
      break;
  }

  if(isDefined(weapon)) {
    scripts\anim\shared::forceuseweapon(weapon, "primary");
  }
}

function function_17ec2637c87d3402() {
  while(true) {
    self setgoalpos(level.player.origin);
    wait 0.2;
  }
}

function function_462afb2afca450a3() {
  var_6e9c69ea5883c14f = 0;
  distmax = squared(1200);
  var_a825dbbc9429b523 = squared(800);

  while(true) {
    dist = distance2dsquared(self.origin, level.player.origin);
    playereye = level.player getEye();
    var_4c09b281a5a0573 = self getEye();

    if(!var_6e9c69ea5883c14f && dist >= distmax || !trace::ray_trace_passed(playereye, var_4c09b281a5a0573, [self, level.player])) {
      var_6e9c69ea5883c14f = 1;
      self setgoalpos(level.player.origin);
    } else if(var_6e9c69ea5883c14f && dist >= var_a825dbbc9429b523) {
      var_6e9c69ea5883c14f = 0;
      self setgoalpos(self.origin);
    }

    wait 0.2;
  }
}

function function_744c1d6dc1393770(targetname) {
  self endon("death");
  volume = getEnt(targetname, "targetname");

  if(!isDefined(volume)) {
    return;
  }

  while(true) {
    selfeye = self getEye();
    playereye = level.player getEye();

    if(sighttracepassed(selfeye, playereye, 1, undefined)) {
      if(ray_trace_passed(selfeye, playereye, [self, level.player])) {
        break;
      }
    }

    wait 0.3;
  }

  if(istrue(self.fixednode)) {
    self.fixednode = 0;
  }

  self.fixednodesaferadius = 400;
  self.goalradius = 400;
  self setgoalvolumeauto(volume);
}

function function_323be8f4542e0ea6(ids) {
  self endon("alarm_tripped");
  self endon("alarm_notify");
  thread function_8599fba8664d49c7(ids);
  childthread function_64ed25bde18c8870();
  num = 0;
  var_d5ef324d01d7d157 = ids.size;

  while(true) {
    waitframe();

    if(self.var_fe5ebefa740c7106 != 0) {
      continue;
    }

    self function_76b3cfb91ef40b3b(ids[num]);
    wait 0.1;
    self waittill("bseq_user_deleted");
    num++;

    if(num >= var_d5ef324d01d7d157) {
      num = 0;
    }
  }
}

function function_8599fba8664d49c7(ids) {
  self waittill("death");

  foreach(id in ids) {
    despawninteraction(id);
  }
}

function function_64ed25bde18c8870() {
  self notify("new_break_interaction_alert");
  self endon("new_break_interaction_alert");
  waittill_either("alarm_tripped", "alarm_notify");
  wait 0.3;
  self leaveinteraction();
}

function alarm_init() {
  self endon("death");
  childthread alarm_trigger();
  childthread function_3700eae769329215();
  childthread function_f23c0b57e786c9f6();
}

function alarm_trigger() {
  while(true) {
    level waittill("stealth_combat", stealth_group);
    thread stealth_claim(stealth_group);
    waitframe();
  }
}

function stealth_claim(stealth_group) {
  if(isDefined(stealth_group)) {
    level notify("validate_stealth_claim" + stealth_group);
    level endon("validate_stealth_claim" + stealth_group);
  } else {
    level notify("validate_stealth_claim");
    level endon("validate_stealth_claim");
  }

  msg = waittill_any_timeout_1(1.5, "stealth_combat_validated");
  thread function_4a79dd62554e6292();
}

function function_4a79dd62554e6292() {
  if(utility::ent_flag("alarm_tripped")) {
    return;
  }

  wait 2;

  if(function_eac0cd99c9c6d8ee() != "spotted") {
    return;
  }

  utility::ent_flag_set("alarm_tripped");
  childthread function_d2bd474b61b2a8c2(0);
}

function function_f23c0b57e786c9f6() {
  thread function_b94c11b6818b3d1b();
  utility::ent_flag_wait("alarm_tripped");
  thread alarm_music();
  level.var_cb719db520fa8b8b.active = 1;
  level.var_cb719db520fa8b8b.set = 1;
  level.var_cb719db520fa8b8b.num++;
  self.goalradius = 2048;
}

function alarm_music() {
  setmusicstate("mx_silo_exposed");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_infil_alerted", 3.5, 3.5);
}

function function_cc3bc45cee803ba0() {
  if(istrue(level.alarm)) {
    return true;
  }

  return false;
}

function function_48da179b4ec16645() {
  level.alarm = 1;
}

function function_b94c11b6818b3d1b() {
  self waittill("death");

  if(utility::ent_flag("alarm_tripped")) {
    level.var_cb719db520fa8b8b.num--;
  }
}

function function_3700eae769329215() {
  while(true) {
    self waittill("weapon_fired");
    wait 3;

    if(utility::ent_flag("alarm_tripped")) {
      continue;
    }

    if(function_eac0cd99c9c6d8ee() != "spotted") {
      continue;
    }

    if(!istrue(level.alarm)) {
      level notify("alarm_tripped_first_time");
      level.alarm = 1;
      thread function_cc4de138cb503bd0();
    }

    utility::ent_flag_set("alarm_tripped");
    childthread function_d2bd474b61b2a8c2(1);

    while(utility::ent_flag("alarm_tripped")) {
      waitframe();
    }
  }
}

function function_cc4de138cb503bd0() {
  var_552ec412ede511a3 = (2675, 1757, 505);
  level.var_e05fb44af318872e = spawn_script_origin(var_552ec412ede511a3);
  oneshot_length = 1.75;
  var_19f16af5509599b0 = 2.75;
  var_fe9eb0c13abf30a8 = 3;
  var_9c6b9ee5e766fe74 = 6;
  var_6b0788f5c6a0f17 = 0;

  for(var_9677d6bdf3e8de9b = 0; var_9677d6bdf3e8de9b < var_9c6b9ee5e766fe74; var_9677d6bdf3e8de9b++) {
    while(var_6b0788f5c6a0f17 < var_fe9eb0c13abf30a8) {
      level.var_e05fb44af318872e playSound("scn_jup_upper_base_security_alarm");
      wait oneshot_length;
      var_6b0788f5c6a0f17++;
    }

    wait var_19f16af5509599b0;
    var_6b0788f5c6a0f17 = 0;
  }

  wait 5;
  level.var_e05fb44af318872e delete();
  thread function_8b824195175521a9();
}

function function_8b824195175521a9() {
  wait 4;
  setmusicstate("mx_silo_stealthmoods");
}

function function_d2bd474b61b2a8c2(spotted) {
  enemies = getaiarray("axis");
  origin = self.origin;

  if(istrue(spotted) || !isDefined(origin)) {
    origin = level.player.origin;
  }

  origin = getclosestpointonnavmesh(origin);

  if(isDefined(enemies) && enemies.size >= 1) {
    foreach(enemy in enemies) {
      if(isDefined(enemy) && isalive(enemy)) {
        enemy thread function_ce2d18636e810f3a(origin, spotted);
      }
    }
  }

  wait 0.1;
  enemies = getaiarray("axis");
  num = 0;

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      if(enemy function_b02ecabd3fb294fc()) {
        num++;
      }
    }
  }

  if(num < 5) {
    spawn_reinforcement(num, origin);
    return;
  }

  spawn_reinforcement(3, origin);
}

function function_b02ecabd3fb294fc() {
  if(utility::is_equal(self.alertlevel, "combat")) {
    return true;
  }

  return false;
}

function spawn_reinforcement(num, origin) {
  structs = utility::getStructArray("reinforcement_struct", "targetname");
  var_d88bc94baf775eaf = sortbydistance(structs, level.player.origin);
  path = undefined;
  distmax = squared(350);

  foreach(struct in structs) {
    if(isDefined(path)) {
      break;
    }

    if(scripts\engine\trace::ray_trace_passed(level.player getEye(), struct.origin + (0, 0, 50), [level.player])) {
      continue;
    }

    dist = distance2dsquared(level.player.origin, struct.origin);

    if(dist <= distmax) {
      continue;
    }

    path = struct;
  }

  if(!isDefined(path)) {
    return;
  }

  numleft = 5 - num;

  for(i = 1; i <= numleft; i++) {
    waitframe();
    enemies = getaiarray("axis");
    level.reinforcements = array_removedead(level.reinforcements);
    level.reinforcements = function_fdc9d5557c53078e(level.reinforcements);

    if(enemies.size > 31) {
      continue;
    }

    if(level.reinforcements.size > 6) {
      continue;
    }

    targetname = "reinforcement_spawner";

    if(is_equal(path.script_noteworthy, "elite")) {
      targetname = "reinforcement_elite_spawner";
    }

    ai = utility::spawn_targetname(targetname);

    if(isDefined(ai)) {
      ai thread function_cc56d7ab26d8f0a4(i, path, origin);
    }
  }
}

function function_cc56d7ab26d8f0a4(i, path, origin) {
  self endon("death");
  level.reinforcements[level.reinforcements.size] = self;
  self.script_stealth = 1;
  self.script_stealthgroup = "upper_base_main";
  self.goalradius = 200;
  utility::demeanor_override("combat");
  waitframe();
  self forceteleport(path.origin, path.angles);
  self function_1aff80c5fc5a3eea("combat");
  function_2fb932e41fa56ad5("combat", origin);
  self getenemyinfo(level.player);
  set_favoriteenemy(level.player);
  self setgoalpos(origin);
  distmax = squared(70);
  cosnum = cos(40);
  childthread reinforce_debug(i);

  while(true) {
    waitframe();
    dist = distancesquared(self.origin, level.player.origin);

    if(dist <= distmax) {
      function_2fb932e41fa56ad5("investigate", self.origin);
      break;
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();

    if(within_fov(playereye, playerangles, self.origin, cosnum) && ray_trace_passed(playereye, self getEye(), [self, level.player])) {
      function_2fb932e41fa56ad5("sight", level.player.origin);
      break;
    }
  }
}

function reinforce_debug(i) {
  while(true) {
    if(getdvarint(@ "hash_76852036995dc6cc")) {
      print3d(self.origin + (0, 0, 65), "<dev string:x1c>" + i, (1, 1, 1), 1, 1, 1, 1);
      line(self.origin, level.player.origin, (1, 1, 1), 1, 0, 1);
    }

    waitframe();
  }
}

function function_ce2d18636e810f3a(origin, spotted) {
  self endon("death");
  close = 500;
  max = 700;

  if(istrue(spotted)) {
    close = 600;
    max = 1000;
  }

  var_a825dbbc9429b523 = squared(close);
  distmax = squared(max);
  cosnum = cos(40);
  dist = distance2dsquared(origin, self.origin);

  if(dist <= var_a825dbbc9429b523) {
    self notify("alarm_notify");
    self endon("alarm_notify");
    utility::ent_flag_set("alarm_tripped");
    self function_1aff80c5fc5a3eea("combat");
    self getenemyinfo(level.player);
    function_2fb932e41fa56ad5("combat", level.player.origin);
    maxtime = gettime() + 8000;

    while(gettime() <= maxtime) {
      waitframe();
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();

    if(within_fov(playereye, playerangles, self.origin, cosnum) && ray_trace_passed(playereye, self getEye(), [self, level.player])) {
      function_2fb932e41fa56ad5("sight", level.player.origin);
    } else {
      function_2fb932e41fa56ad5("investigate", level.player.origin);
    }

    return;
  }

  if(dist <= distmax) {
    self notify("alarm_notify");
    function_2fb932e41fa56ad5("investigate", level.player.origin);
  }
}

function function_2fb932e41fa56ad5(type, origin) {
  if(!isDefined(origin)) {
    origin = function_6c523dc176b4da50();
  }

  self aieventlistenerevent(type, level.player, origin);
}

function function_6c523dc176b4da50() {
  origin = self lastknownpos(level.player);

  if(!isDefined(origin)) {
    origin = level.player.origin;
  }

  return origin;
}

function function_7d957df01b5ea2a() {
  if(level.var_cb719db520fa8b8b.num >= 1) {
    return false;
  }

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    return false;
  }

  return true;
}

function despawn_enemies() {
  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      enemy despawn_enemy();
    }
  }
}

function despawn_enemy() {
  self endon("death");

  if(is_equal(self.animname, "guard1") || is_equal(self.animname, "guard2")) {
    return;
  }

  if(isDefined(self.var_acbe6b1f12bab7b7)) {
    self notify("force_delete");
    waitframe();
  }

  self.diequietly = 1;
  self delete();
}

function function_2ff515ad86aa0efe() {
  if(isDefined(self.script_parameters)) {
    node = getnode(self.script_parameters, "targetname");
    thread teleport_ai_to_cover_node(node);
  }
}

function teleport_ai_to_cover_node(cover_node) {
  coverangles = cover_node.angles;
  coverorigin = cover_node.origin;

  if(!issubstr(cover_node.type, "Prone")) {
    if(issubstr(cover_node.type, "Left")) {
      coverangles += (0, 90, 0);
    } else if(issubstr(cover_node.type, "Right") || issubstr(cover_node.type, "Cover Crouch") || issubstr(cover_node.type, "Conceal") || issubstr(cover_node.type, "Cover Stand")) {
      coverangles -= (0, 90, 0);
    }
  }

  self forceteleport(coverorigin, coverangles);
  self usecovernode(cover_node, 1);
  self setgoalnode(cover_node);
}

function function_d611bfc0be2d9563() {
  if(is_equal(self.animname, "stay")) {
    self.fixednode = 1;
    self.goalradius = 64;
  }
}

function function_ef39228649b4fb51() {
  utility::flag_wait("scriptables_ready");
  animnode = getStruct("silo_room_animnode", "targetname");
  rocket = getEnt("silo_container", "targetname");
  rocket assign_animtree("silo_container");
  animnode anim_first_frame_solo(rocket, "back_door_open");
}

function lock_doors() {
  flag_wait("interactive_doors_ready");
  door = scripts\sp\door::get_interactive_door("control_room_hall_door");
  door.locked = 1;
  door utility::door_ai_allowed(0);
  doors = scripts\sp\door::get_interactive_door_array("tunnel_exit_door");

  foreach(door in doors) {
    door.locked = 1;
    door utility::door_ai_allowed(0);
  }

  thread function_6ef1d67eb61d457b(doors, "jugg_half_health");
  distmax = squared(100);

  foreach(door in level.interactive_doors.ents) {
    dist1 = distancesquared(door.origin, (2784, 2120, -328));
    dist2 = distancesquared(door.origin, (2301, 3537, -452));

    if(dist1 <= distmax) {
      door thread function_d6da1ee07ddbda10("player_in_control_room");
    }

    if(dist2 <= distmax) {
      door thread function_d6da1ee07ddbda10("player_in_server_room");
    }
  }

  utility::flag_set("level_doors_finished");
}

function function_d6da1ee07ddbda10(msg) {
  self setCanDamage(0);
  utility::door_ai_allowed(0);
  utility::flag_wait(msg);
  utility::door_ai_allowed(1);
}

function function_6ef1d67eb61d457b(doors, eflag) {
  struct = getStruct("obj_tunnel_exit2", "targetname");
  trigger = getEnt("tunnel_exit_trigger", "targetname");
  utility::flag_wait(eflag);

  while(level.player istouching(trigger)) {
    waitframe();
  }

  foreach(door in doors) {
    door.locked = 0;
    door utility::door_ai_allowed(1);
    door scripts\game\sp\door::remove_door_snake_cam_ability();
    door scripts\sp\door::remove_open_ability();
    door scripts\sp\door::door_open_completely(struct, 0.2);
  }
}

function function_a4c4199bfb798025() {
  ents = getEntArray("pickup_flashbang", "targetname");

  foreach(ent in ents) {
    ent thread function_2e1e687540ce9953("flash");
  }

  ents = getEntArray("pickup_frag", "targetname");

  foreach(ent in ents) {
    ent thread function_2e1e687540ce9953("frag");
  }
}

function function_2e1e687540ce9953(type, model) {
  struct = getStruct(self.target, "targetname");
  ents = getEntArray(self.target, "targetname");
  ents[ents.size] = self;

  if(getdvarint(@ "hash_3988468c8fd8b097")) {
    foreach(ent in ents) {
      ent delete();
    }

    return;
  }

  locstring = undefined;
  var_c8056294780d4635 = undefined;
  lethal = 0;

  if(is_equal(type, "flash")) {
    foreach(ent in ents) {
      ent setModel("offhand_1h_wm_grenade_flash_v0");
    }

    locstring = &"WEAPON/FLASH_GRENADE";
  } else {
    lethal = 1;

    foreach(ent in ents) {
      ent setModel("offhand_2h_wm_grenade_frag_v0");
    }

    locstring = &"WEAPON/M2FRAGGRENADE";
  }

  while(true) {
    struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), locstring, 60, 250, 80);
    struct waittill("trigger");
    type = "primaryoffhand";

    if(!lethal) {
      type = "secondaryoffhand";
    }

    weapon = level.player getcurrentoffhand(type);
    weaponname = getweaponbasename(weapon);
    var_c8056294780d4635 = level.player getammocount(weapon);
    maxammo = weapon.maxammo;

    if(var_c8056294780d4635 < maxammo) {
      thread play_sound_in_space("weap_pickup", struct.origin);
      ammoamount = min(var_c8056294780d4635 + 2, maxammo);
      ammoamount = int(ammoamount);
      level.player forceplaygestureviewmodel("iw9_ges_pickup");
      level.player give_offhand(weaponname, ammoamount);
      array_delete(ents);
      wait 0.15;
      break;
    } else {
      utility::display_hint_forced(type, 3);
    }

    wait 0.1;
  }
}

function function_3be70b1887ed619b(name, msg) {
  flag_wait(msg);
  wait 0.2;
  autosave_by_name(name);
}

function function_7af34098c3733bad(name, msg, time) {
  flag_wait(msg);
  wait 0.2;
  function_d5eb6ecac5c4d41f(name, time);
}

function function_d5eb6ecac5c4d41f(name, timesec) {
  timeused = gettime() - level.timer["start"];
  timeleft = level.timer["total"] - timeused;
  timemin = function_bdf27f56a36bc52(timesec);

  if(timeleft < timemin) {
    if(getdvarint(@ "hash_a5a70c5c6668524")) {
      scripter_note("<dev string:x2b>" + timeleft / 1000 + "<dev string:x3b>" + timesec + "<dev string:x44>");
    }

    return;
  }

  if(getdvarint(@ "hash_a5a70c5c6668524")) {
    scripter_note("<dev string:x4a>" + timeleft / 1000 + "<dev string:x3b>" + timesec + "<dev string:x44>");
  }

  autosave_by_name(name);
}

function function_bdf27f56a36bc52(num) {
  time = num * 1000;
  return time;
}

function function_a9ab389753b32597(num) {
  time = num * 60 * 1000;
  return time;
}

function function_b0a5da41ab9f35f5() {
  level endon("silo_door_opened");
  flag_wait("player_in_base");
  thread autosave_tactical();
  maxtime = gettime() + 45000;
  trigger = getEnt("out_of_bounds", "targetname");

  while(true) {
    time = gettime();

    if(time >= maxtime || flag("force_autosave")) {
      flag_clear("force_autosave");
      thread function_7fa026805c8fb459(trigger);
      maxtime = time + 45000;
    }

    wait 0.1;
  }
}

function function_7fa026805c8fb459(trigger) {
  if(level.player isads()) {
    return;
  }

  if(level.player istouching(trigger)) {
    return;
  }

  if(level.var_cb719db520fa8b8b.num >= 1) {
    return;
  }

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    return;
  }

  thread autosave_tactical();
}

function ammo_refill() {
  structs = getStructArray("ammo_refill", "targetname");

  foreach(struct in structs) {
    thread function_746e6c393034988e(struct);
  }
}

function function_746e6c393034988e(struct) {
  while(true) {
    struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PRISON/REFILL_AMMO", 360, 700, 80, 0);
    struct waittill("trigger");
    curr_weapons = level.player getweaponslistprimaries();

    if(curr_weapons.size > 0) {
      thread play_sound_in_space("player_refill_all_ammo", struct.origin);
    }

    foreach(weapon in curr_weapons) {
      level.player forceplaygestureviewmodel("iw9_ges_pickup");
      level.player givemaxammo(weapon);
      wait 0.15;
    }

    wait 8;
  }
}

function function_9fc62c8428c71f23() {
  if(flag("gate_spotted")) {
    return true;
  }

  return false;
}

function function_70b033482ac1a273() {
  if(level.player isads() || utility::flag("locate_mound")) {
    return true;
  }

  return false;
}

function function_5430f10a8cfbf553() {
  if(flag("hill_spotted")) {
    return true;
  }

  return false;
}

function function_ad1ba65164ac06c8() {
  if(flag("boss_spotted")) {
    return true;
  }

  return false;
}

function function_40b5ac91b0c3b168() {
  if(flag("drone_in_use")) {
    return true;
  }

  return false;
}

function function_cab7c63bf8ce5da3() {
  if(!flag("drone_in_use")) {
    return true;
  }

  return false;
}

function function_8da3daaa6d7ab1a1(var_b3095c74bd63cdc0) {
  blendtime = 1;
  var_858203d3d31e76f2 = 0.6;

  if(isDefined(var_b3095c74bd63cdc0)) {
    rightarc = isDefined(var_b3095c74bd63cdc0.rightarc) ? var_b3095c74bd63cdc0.rightarc : 30;
    leftarc = isDefined(var_b3095c74bd63cdc0.leftarc) ? var_b3095c74bd63cdc0.leftarc : 30;
    toparc = isDefined(var_b3095c74bd63cdc0.toparc) ? var_b3095c74bd63cdc0.toparc : 30;
    bottomarc = isDefined(var_b3095c74bd63cdc0.bottomarc) ? var_b3095c74bd63cdc0.bottomarc : 30;
  } else {
    rightarc = 30;
    leftarc = 30;
    toparc = 30;
    bottomarc = 30;
  }

  if(level.player getstance() != "stand") {
    level.player setstance("stand", 1, 0, 0);
    waitframe();
  }

  level.player_rig.allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "crouch", "prone"];
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktoabsolute, level.player_rig, "tag_player");
  wait var_858203d3d31e76f2;
}

function unlink_player_from_rig() {
  level.player_rig delete();
  level.player val::reset_array("player_rig", level.player_rig.allows);
}

function function_fbca877c7dca5b38(node, prefix, directions) {
  shortest_dist = undefined;
  best_dir = undefined;

  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
    level.player_rig hide();
  }

  foreach(dir in directions) {
    animation = level.player_rig getanim(prefix + dir);
    origin = getstartorigin(node.origin, node.angles, animation);
    new_dist = distance(level.player.origin, origin);

    if(!isDefined(shortest_dist)) {
      shortest_dist = new_dist;
      best_dir = dir;
      continue;
    }

    if(new_dist < shortest_dist) {
      shortest_dist = new_dist;
      best_dir = dir;
    }
  }

  return prefix + best_dir;
}

function function_1e4aaaddfd5236ca() {
  state = function_eac0cd99c9c6d8ee();

  if(utility::is_equal(state, "hidden")) {
    return false;
  }

  if(utility::is_equal(state, "spotted")) {
    return true;
  }

  if(istrue(level.player.incombat)) {
    return true;
  }

  return false;
}

function function_25ed56105e3958be() {
  level endon("alarm_tripped");
  level endon("achievement_given");
  level.var_4feda7e91a64e636 = 0;
  level.var_856246c8995fafd4 = 0;
  level.var_f8816adaa612c008 = 0;
  var_6dfeeebd5989a352 = [];
  var_6dfeeebd5989a352[0] = "dx_sp_jslo_inex_pric_twoforone";
  var_6dfeeebd5989a352[1] = "dx_sp_jslo_inex_pric_twokonnioneshot";
  var_6dfeeebd5989a352[2] = "dx_sp_jslo_inex_pric_callthatatwofer";
  var_ec44c06676021f69 = [];
  var_ec44c06676021f69[0] = "dx_sp_jslo_inex_fara_savingbrasssmart";
  var_ec44c06676021f69[1] = "dx_sp_jslo_inex_fara_efficient";

  while(true) {
    level.player waittill("weapon_fired");
    function_2d178eb5a9a9de00();
    childthread achievement_watcher(var_6dfeeebd5989a352, var_ec44c06676021f69);
  }
}

function achievement_watcher(var_6dfeeebd5989a352, var_ec44c06676021f69) {
  level notify("new_collateral");
  level endon("new_collateral");

  while(true) {
    waitframe();

    if(level.var_f8816adaa612c008 >= 2) {
      break;
    }
  }

  if(!function_1e4aaaddfd5236ca() && !function_cc3bc45cee803ba0()) {
    thread achievement_counter(var_6dfeeebd5989a352, var_ec44c06676021f69);
  }
}

function achievement_counter(var_6dfeeebd5989a352, var_ec44c06676021f69) {
  level.var_4feda7e91a64e636++;

  if(level.var_4feda7e91a64e636 == 5) {
    level.player function_6a369480dbaf1090("jup_sp_cccollateral");

    if(getdvarint(@ "hash_cea5f5bb0f90163c")) {
      thread utility::scripter_note("<dev string:x53>");
    }

    function_2d178eb5a9a9de00();
    level notify("achievement_given");
  } else if(level.var_4feda7e91a64e636 < 5) {
    if(getdvarint(@ "hash_cea5f5bb0f90163c")) {
      thread utility::scripter_note("<dev string:x6c>" + level.var_4feda7e91a64e636 + "<dev string:x7d>");
    }

    function_2d178eb5a9a9de00();
  }

  function_8703c62c009fbe06();
  wait 1;

  if(!utility::flag("player_in_dialogue")) {
    function_4e7b3c7c40803a95();
    level.player dialogue::say_team(var_6dfeeebd5989a352[level.var_856246c8995fafd4]);
    level.var_856246c8995fafd4++;

    if(level.var_856246c8995fafd4 >= var_6dfeeebd5989a352.size) {
      level.var_856246c8995fafd4 = 0;
    }

    function_596ce1ff779d36a7();
    wait 0.4;

    if(function_408263f999f41641()) {
      function_4e7b3c7c40803a95();

      if(level.var_4feda7e91a64e636 == 2) {
        level.var_a267818b73bf19f2 dialogue::say_team(var_ec44c06676021f69[0]);
      } else if(level.var_4feda7e91a64e636 == 5) {
        level.var_a267818b73bf19f2 dialogue::say_team(var_ec44c06676021f69[1]);
      }

      wait 0.2;
      function_596ce1ff779d36a7();
    }
  }
}

function function_2d178eb5a9a9de00() {
  level.var_f8816adaa612c008 = 0;
}

function function_d770eb34f845615c() {
  self waittill("death", attacker, cause, objweapon);

  if(isDefined(attacker) && isPlayer(attacker)) {
    if(isDefined(objweapon) && utility::is_equal(getweaponbasename(objweapon), "iw9_dm_mike14_sp")) {
      waittillframeend();
      level.var_f8816adaa612c008++;
    }
  }
}

function function_e56716161de57024() {
  if(utility::flag("player_in_elevator")) {
    return;
  }

  level endon("player_in_elevator");
  self waittill("death", attacker, cause, objweapon);
  wait 1;

  if(utility::flag("player_in_elevator")) {
    return;
  }

  if(gettime() <= level.var_7a780c92ddac13e6.cooldown) {
    return;
  }

  if(isDefined(attacker) && isPlayer(attacker)) {
    if(function_408263f999f41641() && !function_1e4aaaddfd5236ca()) {
      function_4e7b3c7c40803a95();
      function_8703c62c009fbe06();
      level.player dialogue::say_global(level.var_7a780c92ddac13e6.aliases[level.var_7a780c92ddac13e6.num]);
      level.var_7a780c92ddac13e6.num++;

      if(level.var_7a780c92ddac13e6.num >= level.var_7a780c92ddac13e6.aliases.size) {
        level.var_7a780c92ddac13e6.num = 1;
      }

      function_596ce1ff779d36a7();
    }
  }
}

function function_408263f999f41641() {
  if(utility::flag("player_in_dialogue")) {
    return false;
  }

  if(level.player dialogue::function_ed8a0ba27b9104c5()) {
    return false;
  }

  return true;
}

function function_3bb94732214d7da7(var_cbfded4bd1246b59) {
  time = 0.1;

  if(utility::flag("player_in_dialogue")) {
    while(utility::flag("player_in_dialogue")) {
      waitframe();
    }

    time = 1.5;
  }

  function_4e7b3c7c40803a95(time);

  if(isDefined(var_cbfded4bd1246b59)) {
    wait var_cbfded4bd1246b59;
  }
}

function function_4e7b3c7c40803a95(delay) {
  utility::flag_set("player_in_dialogue");

  if(isDefined(delay)) {
    wait delay;
  }
}

function function_596ce1ff779d36a7() {
  utility::flag_clear("player_in_dialogue");
}

function function_8703c62c009fbe06() {
  level.var_7a780c92ddac13e6.cooldown = gettime() + 8500;
}