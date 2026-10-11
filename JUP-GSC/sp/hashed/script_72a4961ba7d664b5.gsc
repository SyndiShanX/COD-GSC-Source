/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_72a4961ba7d664b5.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4b7698942d6f679a;
#using script_51f0a664afd44022;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using script_760b8e170bd1e20d;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_build;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_d0159c2e36ea5dec;

function function_4ff4912a64be3672() {}

function function_62b5ab121c530e3f() {
  clearmusicstate();
  setmusicstate("mx_vip_courtyard_arrive");
}

function function_312ac2bdc608977d() {
  thread function_e39d8a96b86719ce(0);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_333c73e0dcbdc794();
  spawn_allies();
  level.ally1 function_ff8247487cfb4eb9("courtyard_ally1_start", 1);
  level.ally2 function_ff8247487cfb4eb9("courtyard_ally2_start", 1);
  function_dc2aa213aa5830aa(getStruct("elevator_tp_end_makarov", "targetname"));
  set_start_location("rooftop_assault_start_org", [level.player]);
  setsaveddvar(@ "hash_f0ef87209242c743", 1);
  thread function_a533d8921f706b7e();
  level thread function_c6aecb595687f644();
}

function function_65de14819ad15534() {
  flag_wait("cine_elevator_pre_end");
  level.player.vo_handler say("dx_sp_jvip_coex_kob2_allstationswegotanmg");
  level.makarov say("dx_sp_jvip_coex_maka_czartoraptorrequesti");
  level.player.vo_handler say("dx_sp_jvip_coex_rap1_rogerthatraptorsinbo");
  thread function_931a769d15b3b3dd();
  flag_wait("flag_courtyard_arrive_mg_passed");
  level.player.vo_handler say("dx_sp_jvip_coex_rap1_raptortogroundtarget");
  level.makarov say("dx_sp_jvip_coex_maka_copyrainfire");
  flag_wait("flag_courtyard_opening_view_reached");
  level.player.vo_handler say("dx_sp_jvip_coex_rap1_shotsoutshotsoutfox2");
  flag_wait("flag_courtyard_jet_strike_hit");
  level.player.vo_handler say("dx_sp_jvip_coex_rap1_directtargetdestroye", undefined, undefined, undefined, 0.75);
  level.ally1 say("dx_sp_jvip_coex_ivan_gettothetunnelontheo", undefined, undefined, undefined, 0.25);
  thread function_bf8ff844db06b231();
  flag_wait("flag_courtyard_encounter_entered");
  wait 6.75;
  level.player say("dx_sp_jvip_coex_noln_headsupthatenemyhelo");
  level.makarov say("dx_sp_jvip_coex_maka_shouldvetakenitoutwh", undefined, undefined, undefined, 0.25);
  level.ally1 say("dx_sp_jvip_coex_ivan_itsfocusedonthepriso", undefined, undefined, undefined, 0.25);
  flag_set("flag_courtyard_encounter_enable_chopper_shoot_warnings");
  tower_guy = getEnt("courtyard_tower_enemy", "script_noteworthy");

  if(isalive(tower_guy)) {
    tower_guy thread function_f3cca3fd9d672178();
  }

  thread function_84c15c58d14bafb2();
  flag_wait("flag_courtyard_helipad_enemies_spawned");
  level.ally2 say("dx_sp_jvip_enhp_koa3_contacthelipad");
  level.ally2 say("dx_sp_jvip_enhp_koa3_helipadishot");
}

function function_bf8ff844db06b231() {
  level endon("flag_courtyard_entry_stop_vo_pre_heli");

  if(!flag("flag_courtyard_entry_stop_vo_pre_heli")) {
    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    nearest_prisoner = get_array_of_closest(level.player.origin, level.courtyard_prisoners)[0];

    if(isDefined(nearest_prisoner)) {
      nearest_prisoner say("dx_sp_jvip_copr_pri2_icanseethegate");
    }

    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    nearest_prisoner = get_array_of_closest(level.player.origin, level.courtyard_prisoners)[0];

    if(isDefined(nearest_prisoner)) {
      nearest_prisoner say("dx_sp_jvip_copr_pri1_letsgoletsgo");
    }

    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    nearest_prisoner = get_array_of_closest(level.player.origin, level.courtyard_prisoners)[0];

    if(isDefined(nearest_prisoner)) {
      nearest_prisoner say("dx_sp_jvip_copr_pri2_werealmostfree");
    }
  }
}

function function_931a769d15b3b3dd() {
  level endon("flag_courtyard_jet_strike_hit");
  dmg_trig = getEnt("courtyard_mg_nest_hit_trigger", "targetname");
  min_wait = 2;
  max_wait = 4;
  choice = 0;
  choice_max = 2;

  while(true) {
    dmg_trig waittill("trigger", attacker);

    if(attacker == level.player) {
      wait 0.5;

      if(choice == 0) {
        level.ally1 say("dx_sp_jvip_mgnn_ivan_letairsupporthandlet");
      }

      if(choice == 1) {
        level.ally1 say("dx_sp_jvip_mgnn_ivan_raptorcanhandlethemg");
      }

      if(choice == 2) {
        level.ally1 say("dx_sp_jvip_mgnn_ivan_leaveitraptorwilltak");
      }

      choice += 1;

      if(choice > choice_max) {
        choice = 0;
      }

      wait randomfloatrange(min_wait, max_wait);
    }

    waitframe();
  }
}

function function_84c15c58d14bafb2() {
  wait 5;
  level.var_5cc6018dc2937f3b = [];
  min_delay = 5;
  max_delay = 10;
  var_30486b140ab642b7 = 25;
  var_11de9b9936cccf58 = 0;
  var_4ef1f5ab0d4e649d = 0;

  while(!flag("flag_courtyard_exit_passed_helipad")) {
    line_num = randomintrange(0, 9);

    if(array_contains(level.var_5cc6018dc2937f3b, line_num)) {
      waitframe();
      continue;
    }

    nearest_prisoner = get_array_of_closest(level.player.origin, level.courtyard_prisoners)[0];

    if(isDefined(nearest_prisoner)) {
      if(line_num == 0) {
        nearest_prisoner say("dx_sp_jvip_copr_pri1_letsgoletsgo");
      }

      if(line_num == 1) {
        nearest_prisoner say("dx_sp_jvip_copr_pri2_werealmostfree");
      }

      if(line_num == 2) {
        nearest_prisoner say("dx_sp_jvip_copr_pri2_icanseethegate");
      }

      if(line_num == 3) {
        nearest_prisoner say("dx_sp_jvip_copr_pri2_theyrebreaking");
      }

      if(line_num == 4) {
        nearest_prisoner say("dx_sp_jvip_copr_pri1_keeppushing");
      }

      if(line_num == 5) {
        nearest_prisoner say("dx_sp_jvip_copr_pri1_werebreakingthrough");
      }

      if(line_num == 6 && !var_11de9b9936cccf58) {
        var_11de9b9936cccf58 = 1;
        level.player.vo_handler say("dx_sp_jvip_copr_noln_guardsarelosinggroun");
      }

      if(line_num == 7 && !var_4ef1f5ab0d4e649d) {
        var_4ef1f5ab0d4e649d = 1;
        level.player.vo_handler say("dx_sp_jvip_copr_noln_wevegotthemontherun");
      }

      thread function_24e6f19dcdd11232(line_num, var_30486b140ab642b7);
      wait randomfloatrange(min_delay, max_delay);
    }

    waitframe();
  }
}

function function_24e6f19dcdd11232(line_num, var_30486b140ab642b7) {
  level.var_5cc6018dc2937f3b = array_add(level.var_5cc6018dc2937f3b, line_num);
  wait var_30486b140ab642b7;
  level.var_5cc6018dc2937f3b = array_remove(level.var_5cc6018dc2937f3b, line_num);
}

function function_3c6ab9ba991c1136() {
  function_64f815da552ce8c6();

  if(function_42f59b2f83e6aec0()) {
    thread function_412e8b44221032e3();
  }

  if(function_42f59b2f83e6aec0()) {
    setsaveddvar(@ "ai_corpsecount", 7);
    thread function_64db928b8ca53ae4();
  }

  flag_wait("cine_elevator_actual_teleport");
  thread function_65de14819ad15534();
  thread namespace_b5c68445db70f7b1::function_8a691b483d7eec10();
  thread function_f7c97a76fc9bcf7c();
  level.var_3e8bdb241a36d9d6 = ["body_c_jup_sp_civ_prisoner_01_b_blood", "body_c_jup_sp_civ_prisoner_02_b_blood", "body_c_jup_sp_civ_prisoner_03_b_blood", "body_c_jup_sp_civ_prisoner_04_b_blood", "body_c_jup_sp_civ_prisoner_05_b_blood"];
  thread function_839a059b851ad908();
  function_3a4e080be3f70a75();
  level.allies = [level.makarov, level.ally1, level.ally2];

  foreach(guy in level.allies) {
    guy set_ignoreall(0);
    guy aiclearscriptdesiredspeed();
  }

  level.makarov.aggressivemode = 1;
  level.makarov.dontgiveuponsuppression = 1;
  level.ally1 set_force_color("b");
  level.ally2 set_force_color("g");
  activate_trigger_with_targetname("courtyard_allies_leave_lift_color_trig");
  thread function_4ff51f995f14e1f();
  var_5bf313d83327fbd6 = getStruct("courtyard_mg_nest_struct_bottom", "targetname");
  var_c006dcf16a56071c = getStruct("courtyard_mg_nest_struct_top", "targetname");
  back_orgs = getStructArray("courtyard_mg_ambient_target_orgs", "targetname");
  front_orgs = getStructArray("courtyard_first_mg_ambient_target_orgs", "targetname");
  var_5bf313d83327fbd6 thread function_67df4cb8788c501a("flag_couryard_elevator_exit_spotlight_move", "flag_courtyard_mg_nest_kill");
  sandbags = getEntArray("courtyard_tower_sandbags", "targetname");

  foreach(obj in sandbags) {
    obj show();
  }

  array_spawn_function_targetname("courtyard_arrive_enemy_target_guys", &function_3f5ccc8b6ae34132);
  array_spawn_targetname("courtyard_arrive_enemy_target_guys");
  array_spawn_function_targetname("courtyard_arrive_elevator_exit_prisoners", &function_be4ba477a4d5cfc0);
  array_spawn_function_targetname("courtyard_arrive_elevator_exit_prisoners_late", &function_be4ba477a4d5cfc0);
  init_prisoners = array_spawn_targetname("courtyard_arrive_elevator_exit_prisoners");

  foreach(guy in init_prisoners) {
    guy setModel(random(level.var_3e8bdb241a36d9d6));
  }

  flag_wait("cine_elevator_pre_end");
  thread courtyard_music();

  if(level.start_point != "courtyard_arrive") {
    thread function_36ab55de1c5166ee();
  }

  wait 0.25;
  late_prisoners = array_spawn_targetname("courtyard_arrive_elevator_exit_prisoners_late");

  foreach(guy in late_prisoners) {
    guy setModel(random(level.var_3e8bdb241a36d9d6));
  }

  flag_wait("cine_elevator_end");
  autosave_by_name("courtyard_arrive");
  thread namespace_165c742e346e899e::function_cfe71de2170ae357();
  wait 1.75;
  flag_wait("flag_courtyard_elevator_exit_wait_start");
  flag_set("flag_courtyard_arrive_mg_pre_intro");
  var_273902bbc18084f7 = 0.75;
  thread namespace_165c742e346e899e::function_31cca1dfb5876cfb(var_273902bbc18084f7);
  thread namespace_165c742e346e899e::function_46c68eacc66e61e();
  wait var_273902bbc18084f7;
  flag_set("courtyard_arrive_mg_intro");
  scene_prisoners = array_combine(init_prisoners, late_prisoners, [level.var_55ac4c093cd8a163]);
  scene_prisoners = array_removedead_or_dying(scene_prisoners);
  scene_prisoners = get_array_of_closest(level.player.origin, scene_prisoners);
  thread function_a1c2cde86a7886b4("courtyard_elevator_exit_crate_1_dest_org", 0.75);

  foreach(guy in scene_prisoners) {
    if(!isDefined(guy.script_noteworthy)) {
      var_5bf313d83327fbd6 function_fcdf944672a85396(guy, 4, 5, 1);
    }
  }

  flag_set("flag_couryard_elevator_exit_spotlight_move");
  level.var_8972dec3f33a4e4a = [];
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_prisoners_1");
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_prisoners_2");
  waitframe();
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_prisoners_3");
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_enemies_1");
  waitframe();
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_enemies_2");
  thread function_4347f743ba0ee10c("courtyard_pre_encounter_filler_enemies_3");
  waitframe();
  redirect_guys = array_spawn_targetname("courtyard_arrive_redirect_prisoners", undefined, undefined, undefined, 1);

  foreach(guy in redirect_guys) {
    guy setModel(random(level.var_3e8bdb241a36d9d6));
    guy aisetdesiredspeed(randomintrange(170, 220));
  }

  wait 1.5;
  thread function_a1c2cde86a7886b4("courtyard_elevator_exit_crate_2_dest_org", 0.1);

  if(!function_42f59b2f83e6aec0()) {
    thread function_a1c2cde86a7886b4("courtyard_elevator_exit_crate_3_dest_org", 0.5, (-40, -40, 0));
  }

  foreach(guy in redirect_guys) {
    var_5bf313d83327fbd6 thread function_fcdf944672a85396(guy, 5, 7, 1);
    wait 0.15;
  }

  flag_set("flag_courtyard_arrive_mg_passed");
  activate_trigger_with_targetname("courtyard_allies_tower_view_cover_trig");
  flag_wait("flag_courtyard_opening_view_reached");
  thread namespace_165c742e346e899e::function_5a7cc57b7debf84e();
  var_5bf313d83327fbd6 thread function_67df4cb8788c501a("flag_courtyard_jet_strike_hit", "flag_courtyard_mg_nest_kill_2");
  thread function_75d381e17723d980();
  var_5bf313d83327fbd6 thread function_247601276cb69bf1(front_orgs, 1);
  var_c006dcf16a56071c thread function_247601276cb69bf1(back_orgs, 0);
  tower_prisoners = array_spawn_targetname("courtyard_tower_prisoners", undefined, undefined, undefined, 1);

  foreach(guy in tower_prisoners) {
    guy thread function_78a85d86a981699a();
  }

  wait 1.8;
  fodder = getEntArray("courtyard_mg_nest_fodder", "script_noteworthy");

  foreach(guy in fodder) {
    var_5bf313d83327fbd6 thread function_fcdf944672a85396(guy, 5, 7, 1);
  }

  flag_wait("flag_courtyard_jet_strike_hit");
  flag_set("flag_obj_reach_gatehouse_activate");

  foreach(obj in sandbags) {
    obj delete();
  }

  thread function_153cf8abef37418b();
  thread function_a0838fc1013efcc3();
  thread function_45c2284963670e5();
  thread function_e2979f5eef1974cc();
  thread function_ae634d26b3baf0a3(10);
  thread function_8bb013f89a436929();
  thread function_93bb14f8daf93942();

  if(function_42f59b2f83e6aec0()) {
    level.var_8972dec3f33a4e4a = array_removedead(level.var_8972dec3f33a4e4a);

    foreach(guy in level.var_8972dec3f33a4e4a) {
      guy kill();
    }
  }

  array_spawn_function_targetname("courtyard_enemies_init", &courtyard_enemy_think);
  array_spawn_targetname("courtyard_enemies_init", undefined, undefined, undefined, 1);
  array_spawn_function_noteworthy("courtyard_enemies_triggered", &courtyard_enemy_think);
  waitframe();

  thread function_bb46a27907f30d5c();

  level.player setclientomnvar("ui_show_objectives", 1);

  if(!function_42f59b2f83e6aec0()) {
    array_spawn_function_targetname("courtyard_prisoners_init", &function_78a85d86a981699a);
    array_spawn_targetname("courtyard_prisoners_init");
  }

  wait 0.75;
  delaythread(2.5, &activate_trigger_with_targetname, "courtyard_allies_enter_courtyard_trig");

  foreach(guy in level.allies) {
    guy set_ignoreall(0);
  }

  flag_wait("flag_courtyard_encounter_entered");
  level.player setclientomnvar("ui_show_objectives", 0);
  thread function_58747f455097f103();
  thread function_630fb17fff08202f();
  thread function_4b8a9eab31c15f9a();
  thread function_d7d7e32709b250c7();
  thread function_4a96dbd5beead42e();
  wait 2;
  array_spawn_function_noteworthy("courtyard_enemies_init_truck", &courtyard_enemy_think);

  if(!function_42f59b2f83e6aec0()) {
    truck = spawn_vehicle_from_targetname_and_drive("courtyard_arrive_truck", 1);
    truck.vehicle_keeps_going_after_driver_dies = 1;
    thread namespace_165c742e346e899e::function_8b28f9fd65f493d1(truck);
    truck thread function_e2065ccdf6cf2725();
  }

  flag_wait("flag_courtyard_update_vols_to_gate");
  tower_guy = getEnt("courtyard_tower_enemy", "script_noteworthy");

  if(isalive(tower_guy)) {
    tower_guy kill();
  }

  flag_wait("flag_courtyard_helipad_enemies_spawned");
  array_spawn_function_targetname("courtyard_enemies_helipad", &courtyard_enemy_think);
  array_spawn_targetname("courtyard_enemies_helipad", undefined, undefined, undefined, 1);
  thread function_541f5daed5730fde();
  waitframe();
  thread function_b70c9147e961ac46();
}

function function_e2065ccdf6cf2725() {
  self waittill("reached_end_node");
  wait 0.5;
  self vehphys_forcekeyframedmotion();
  self.isstationary = 1;
}

function function_412e8b44221032e3() {
  script_models = ["reachvip_dungeondoor_left", "reachvip_dungeondoor_right", "vip_reachvip_dungeondoor", "vip_reach_vip_halldoor_00", "vip_reach_vip_halldoor_02", "vip_reach_vip_halldoor_03", "vip_reach_vip_halldoor_03_old", "vip_reachvip_makcelldoor", "descend_level_2_door_5", "descend_level_2_door_4", "descend_level_2_door_6", "descend_level_1_door_3", "descend_level_1_door_2", "descend_level_2_door_3", "descend_level_2_door_2", "descend_level_2_door_1", "maint_breach_door", "elevator_hallway_door", "floor_grate", "infil_pipe_gate"];

  foreach(script_model in script_models) {
    ent = getEnt(script_model, "targetname");

    if(isent(ent)) {
      waitframe();
      ent delete();
    }
  }

  var_98136602ace3a9d7 = ["level_3_door"];

  foreach(var_9a6f36d62bf57dbe in var_98136602ace3a9d7) {
    ents = getEntArray(var_9a6f36d62bf57dbe, "targetname");

    foreach(ent in ents) {
      if(isent(ent)) {
        waitframe();
        ent delete();
      }
    }
  }

  noteworthy_ents = ["armory_weapon_pickups"];

  foreach(noteworthy in noteworthy_ents) {
    ents = getEntArray(noteworthy, "script_noteworthy");

    foreach(ent in ents) {
      if(isent(ent)) {
        waitframe();
        ent delete();
      }
    }
  }

  brush_models = ["vip_reach_vip_halldoor_01_old", "vip_reach_vip_halldoor_02_col", "vip_reach_vip_halldoor_02_old", "makarov_reveal_door_blocker", "locker_room_door_clip", "level_3_door_right_clip", "grate_lift_panel_blocker"];

  foreach(brush_model in brush_models) {
    ent = getEnt(brush_model, "targetname");

    if(isent(ent)) {
      waitframe();
      ent delete();
    }
  }
}

function function_4347f743ba0ee10c(spawner_targ) {
  spawner = getspawner(spawner_targ, "targetname");
  first_node = getnode(spawner.target, "targetname");
  min_delay = 2;
  max_delay = 4;

  while(!flag("flag_courtyard_opening_view_reached")) {
    spawner.count = 10;
    guy = spawn_targetname(spawner_targ, 1);

    if(isDefined(guy)) {
      level.var_8972dec3f33a4e4a[level.var_8972dec3f33a4e4a.size] = guy;
      guy thread function_861b02d129576b19(first_node);
      guy waittill("death");
      wait randomfloatrange(min_delay, max_delay);
    }

    waitframe();
  }
}

function function_861b02d129576b19(first_node) {
  self endon("death");
  set_goal_radius(8);
  set_goal_height(32);
  set_baseaccuracy(0.5);
  set_fixednode_false();
  vol = getEnt(self.target, "targetname");
  self setgoalvolumeauto(vol);
  flag_wait("flag_courtyard_jet_strike_hit");
  set_fixednode_false();

  if(self.team == "axis") {
    thread courtyard_enemy_think();
    return;
  }

  thread function_78a85d86a981699a();
}

function function_153cf8abef37418b() {
  level.courtyard_color_trigs = getEntArray("courtyard_color_trigs", "script_noteworthy");

  foreach(trig in level.courtyard_color_trigs) {
    if(isDefined(trig.script_parameters)) {
      trig thread function_b2f2bc52e55f01ac();
    }
  }
}

function function_b2f2bc52e55f01ac() {
  my_group = self.script_parameters;
  self waittill("trigger");
  waitframe();
  level.courtyard_color_trigs = array_removeundefined(level.courtyard_color_trigs);

  foreach(trig in level.courtyard_color_trigs) {
    if(isDefined(trig.script_parameters) && my_group == trig.script_parameters) {
      trig delete();
    }
  }
}

function function_f3cca3fd9d672178() {
  self endon("death");

  while(true) {
    level.player waittill("damage", amount, attacker);

    if(attacker == self) {
      num = randomintrange(0, 3);

      if(num == 0) {
        level.ally1 say("dx_sp_jvip_engt_ivan_fireontheguardtower");
      }

      if(num == 1) {
        level.ally2 say("dx_sp_jvip_engt_koa3_shootersinthetower");
      }

      if(num == 2) {
        level.ally2 say("dx_sp_jvip_engt_koa3_shootersintheguardto");
      }

      wait randomfloatrange(7, 12);
    }

    waitframe();
  }
}

function function_d7d7e32709b250c7() {
  flag_wait("flag_courtyard_clean_up_building_outpost");
  guy = getEnt("courtyard_right_building_guy", "script_noteworthy");

  if(isalive(guy)) {
    guy kill();
  }
}

function function_8bb013f89a436929() {
  flag_wait("flag_courtyard_tower_reached");
  level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

  if(level.courtyard_enemies.size < 9) {
    array_spawn_function_targetname("courtyard_enemies_tower", &courtyard_enemy_think);
    array_spawn_targetname("courtyard_enemies_tower", 1, 1, undefined, 1);
  }
}

function function_93bb14f8daf93942() {
  level endon("flag_courtyard_exit_passed_helipad");
  on_ladder = 0;

  while(true) {
    if(level.player isonladder() &!on_ladder) {
      on_ladder = 1;
      wait 1;
      thread function_3632139249e4dc11();
    }

    if(!level.player isonladder() &on_ladder) {
      on_ladder = 0;
      wait 0.5;
      level.player notify("stop_ladder_protector_think");
      level.player set_ignoreme(0);
    }

    waitframe();
  }
}

function function_3632139249e4dc11() {
  level.player endon("stop_ladder_protector_think");
  timeout = 5;
  curr_time = 0;
  level.player set_ignoreme(1);

  while(true) {
    curr_time += 0.05;

    if(curr_time > 5) {
      level.player set_ignoreme(0);
      return;
    }

    waitframe();
  }
}

function function_ae634d26b3baf0a3(wait_time) {
  level.var_bc3ac12e339ea654 = 0;
  wait wait_time;
  vols = getEntArray("courtyard_arrival_hang_back_grenade_vols", "targetname");
  level.var_b44bf34c7d88586b = 0;

  foreach(vol in vols) {
    vol thread function_8b1f0bc280a67831();
  }
}

function function_8b1f0bc280a67831() {
  level endon("flag_courtyard_encounter_entered");
  trigger_time = 3;
  fuse_time = 5;
  post_timeout = 5;
  max_grenades = 2;
  struct = getStruct(self.target, "targetname");
  struct_offset = (0, 0, 120);
  curr_time = 0;

  while(true) {
    if(level.var_bc3ac12e339ea654 >= max_grenades) {
      return;
    }

    if(level.var_b44bf34c7d88586b) {
      waitframe();
      continue;
    }

    if(level.player istouching(self) && curr_time < trigger_time) {
      curr_time += 0.05;
    }

    if(curr_time > trigger_time) {
      level.var_b44bf34c7d88586b = 1;

      while(true) {
        in_fov = within_fov(level.player getEye(), level.player getgunangles(), struct.origin + struct_offset, cos(100));

        if(in_fov) {
          waitframe();
          continue;
        }

        break;
      }

      magicgrenademanual("frag", struct.origin + struct_offset, (0, 0, 0), fuse_time);
      level.var_bc3ac12e339ea654 += 1;
      curr_time = 0;
      wait fuse_time;
      wait post_timeout;
      level.var_b44bf34c7d88586b = 0;
    }

    waitframe();
  }
}

function function_be4ba477a4d5cfc0() {
  self endon("death");
  utility::add_damage_function(&function_d799ec6e01836246);
  magic_bullet_shield();
  set_fixednode_true();
  self.name = "";
  flag_wait("courtyard_arrive_mg_intro");
  stop_magic_bullet_shield();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "survivor") {
    flag_wait("flag_courtyard_jet_strike_hit");
    thread function_78a85d86a981699a();
  }
}

function function_3f5ccc8b6ae34132() {
  self endon("death");
  magic_bullet_shield();
  set_fixednode_true();
  flag_wait("courtyard_arrive_mg_intro");
  stop_magic_bullet_shield();
  self kill();
}

function courtyard_music() {
  setmusicstate("mx_vip_courtyard_arrive");
}

function function_3a4e080be3f70a75() {
  level.courtyard_enemies = [];
  level.courtyard_prisoners = [];
  var_ece04baa3e9bf2a0 = getnoentvolumearray("courtyard_vol_start_prisoners", "targetname");
  var_58d4940c6ad9ee07 = getnoentvolumearray("courtyard_vol_start_enemies", "targetname");
  var_50dd32d3d48c950 = getnoentvolumearray("courtyard_vol_gate_enemies", "targetname");
  var_5c201346025a0103 = getnoentvolumearray("courtyard_vol_gate_prisoners", "targetname");
  var_4a25f69d80594430 = getnoentvolumearray("courtyard_vol_helipad_enemies", "targetname");
  var_47333a6fb61ac3e3 = getnoentvolumearray("courtyard_vol_helipad_prisoners", "targetname");
  var_a41d4376a9fab7b1 = getnoentvolumearray("courtyard_vol_retreat_prisoners", "targetname");
  var_9305e7607dac88b3 = getnoentvolumearray("courtyard_vol_retreat_helipad_prisoners", "targetname");
  var_a492477731201d0e = getnoentvolumearray("courtyard_vol_retreat_enemies", "targetname");
  level.courtyard_vol_start_prisoners = var_ece04baa3e9bf2a0[0];
  level.courtyard_vol_start_enemies = var_58d4940c6ad9ee07[0];
  level.courtyard_vol_gate_enemies = var_50dd32d3d48c950[0];
  level.courtyard_vol_gate_prisoners = var_5c201346025a0103[0];
  level.courtyard_vol_helipad_enemies = var_4a25f69d80594430[0];
  level.courtyard_vol_helipad_prisoners = var_47333a6fb61ac3e3[0];
  level.courtyard_vol_retreat_prisoners = var_a41d4376a9fab7b1[0];
  level.courtyard_vol_retreat_helipad_prisoners = var_9305e7607dac88b3[0];
  level.courtyard_vol_retreat_enemies = var_a492477731201d0e[0];
}

function function_232d2150f9d35c0f() {
  while(true) {
    level.courtyard_enemies = array_removedead(level.courtyard_enemies);

    iprintlnbold(level.courtyard_enemies.size);

    wait 1;
  }
}

function function_630fb17fff08202f() {
  var_66823e8f6606ec24 = 3;
  var_f8864dbac6d02f44 = 5;
  var_ee935a870c58f0c9 = 2;
  var_5bc7cc70a59aae75 = 5;
  var_d88be59999334a9 = 2;
  var_eae0f7e50cffa1d5 = 6;
  var_e5a720f151f05844 = 0;

  while(!flag("flag_courtyard_update_vols_to_gate")) {
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    if(level.courtyard_enemies.size < var_f8864dbac6d02f44 && var_e5a720f151f05844 <= var_66823e8f6606ec24) {
      guy = spawn_targetname("courtyard_enemy_backfill_start_spawner", 0);

      if(isDefined(guy)) {
        guy thread courtyard_enemy_think();
        var_e5a720f151f05844 += 1;
      }
    }

    waitframe();
  }

  var_e5a720f151f05844 = 0;

  while(!flag("flag_courtyard_helipad_enemies_spawned")) {
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    if(level.courtyard_enemies.size < var_5bc7cc70a59aae75 && var_e5a720f151f05844 <= var_ee935a870c58f0c9) {
      guy = spawn_targetname("courtyard_enemy_backfill_gate_spawner", 0);

      if(isDefined(guy)) {
        guy thread courtyard_enemy_think();
        var_e5a720f151f05844 += 1;
      }
    }

    waitframe();
  }

  thread function_517feed43e31c568(var_eae0f7e50cffa1d5);
  flag_wait("flag_courtyard_helipad_encounter_reached");
  var_e5a720f151f05844 = 0;

  while(!flag("flag_courtyard_exit_passed_helipad")) {
    if(level.courtyard_enemies.size < var_eae0f7e50cffa1d5 && var_e5a720f151f05844 <= var_d88be59999334a9) {
      guy = spawn_targetname("courtyard_enemy_backfill_helipad_spawner", 0);

      if(isDefined(guy)) {
        guy thread courtyard_enemy_think();
        var_e5a720f151f05844 += 1;
        wait randomfloatrange(0.2, 0.4);
      }
    }

    waitframe();
  }
}

function function_517feed43e31c568(var_eae0f7e50cffa1d5) {
  while(!flag("flag_courtyard_exit_passed_helipad")) {
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    if(!flag("flag_courtyard_helipad_encounter_reached")) {
      if(level.courtyard_enemies.size < var_eae0f7e50cffa1d5) {
        guy = spawn_targetname("courtyard_enemy_backfill_helipad_spawner", 0);

        if(isDefined(guy)) {
          guy thread courtyard_enemy_think();
          wait randomfloatrange(1, 3);
          continue;
        }
      }
    }

    waitframe();
  }
}

function function_4b8a9eab31c15f9a() {
  var_f8864dbac6d02f44 = 7;
  var_5bc7cc70a59aae75 = 5;
  var_eae0f7e50cffa1d5 = 6;

  if(function_42f59b2f83e6aec0()) {
    var_f8864dbac6d02f44 = 3;
    var_5bc7cc70a59aae75 = 3;
    var_eae0f7e50cffa1d5 = 3;
  }

  var_bad994d4a16721db = 1;
  var_bab68ad4a140c425 = 3;

  while(!flag("flag_courtyard_update_vols_to_gate")) {
    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);

    if(level.courtyard_prisoners.size < var_f8864dbac6d02f44) {
      guy = spawn_targetname("courtyard_prisoner_backfill_start_spawner", 0);

      if(isDefined(guy)) {
        wait randomfloatrange(var_bad994d4a16721db, var_bab68ad4a140c425);
        guy thread function_78a85d86a981699a();
      }
    }

    waitframe();
  }

  while(!flag("flag_courtyard_helipad_enemies_spawned")) {
    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);

    if(level.courtyard_prisoners.size < var_5bc7cc70a59aae75) {
      guy = spawn_targetname("courtyard_prisoner_backfill_gate_spawner", 0);

      if(isDefined(guy)) {
        wait randomfloatrange(var_bad994d4a16721db, var_bab68ad4a140c425);
        guy thread function_78a85d86a981699a();
      }
    }

    waitframe();
  }

  while(!flag("flag_courtyard_exit_passed_helipad")) {
    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);

    if(level.courtyard_prisoners.size < var_eae0f7e50cffa1d5) {
      guy = spawn_targetname("courtyard_prisoner_backfill_helipad_spawner", 0);

      if(isDefined(guy)) {
        wait randomfloatrange(var_bad994d4a16721db, var_bab68ad4a140c425);
        guy thread function_78a85d86a981699a();
      }
    }

    waitframe();
  }
}

function function_7ad012d64185f60(var_cf26f2e7f3060757) {
  self endon("death");
  self endon("stop_think");

  if(isDefined(self.script_noteworthy)) {
    self.area = self.script_noteworthy;
  }

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "ragdoll_on_shot") {
      thread function_7ef8f55dec9c51d4();
    }

    if(self.script_parameters == "low_accuracy") {
      set_baseaccuracy(0.05);
    }
  }

  if(isDefined(self.target)) {
    first_node = getnode(self.target, "targetname");

    if(isDefined(first_node)) {
      self setgoalnode(first_node);
      self setgoalpos(first_node.origin, 8);
      set_goal_radius(8);

      while(distance(self.origin, first_node.origin) > 16) {
        waitframe();
      }

      if(isDefined(first_node.script_noteworthy)) {
        if(first_node.script_noteworthy == "notify") {
          self waittill("first_node_done");
        }

        if(first_node.script_noteworthy == "instaprogress") {
          waitframe();
        } else {
          wait randomfloatrange(8, 12);
        }
      }
    }
  }

  waitframe();
  self notify("initial_choreography_done");
}

function function_78a85d86a981699a(var_cf26f2e7f3060757, var_24d1cb32e962926c) {
  self endon("death");
  self endon("stop_think");
  utility::add_damage_function(&function_d799ec6e01836246);
  level.courtyard_prisoners = array_add(level.courtyard_prisoners, self);
  set_goal_radius(8);
  set_goal_height(32);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "courtyard_tower_prisoners_mg_runners") {
    self aisetdesiredspeed(randomintrange(250, 280));
  } else {
    self aisetdesiredspeed(randomintrange(150, 220));
  }

  set_baseaccuracy(0.25);
  set_fixednode_false();
  self.name = "";

  if(function_42f59b2f83e6aec0()) {
    self dontcastshadows();
  }

  flag_wait("flag_courtyard_jet_strike_hit");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "courtyard_tower_prisoners_mg_runners") {
    self aisetdesiredspeed(randomintrange(150, 220));
  }

  time = randomfloatrange(1.5, 3);
  wait time;
  self setgoalvolumeauto(level.courtyard_vol_start_prisoners);
  flag_wait("flag_courtyard_update_vols_to_gate");
  self setgoalvolumeauto(level.courtyard_vol_gate_prisoners);
  flag_wait("flag_courtyard_helipad_enemies_spawned");
  self setgoalvolumeauto(level.courtyard_vol_helipad_prisoners);
  flag_wait("flag_courtyard_exit_passed_helipad");

  if(!istrue(var_24d1cb32e962926c) && randomfloatrange(0, 1) > 0.33) {
    self setgoalvolumeauto(level.courtyard_vol_retreat_helipad_prisoners);
    self waittill("goal");
  }

  self setgoalvolumeauto(level.courtyard_vol_retreat_prisoners);
  set_grenadeammo(0);

  if(cointoss()) {
    demeanor_override("combat");
  }
}

function courtyard_enemy_think() {
  self endon("death");
  level.courtyard_enemies = array_add(level.courtyard_enemies, self);
  set_goal_radius(8);
  set_goal_height(32);
  set_baseaccuracy(0.6);

  if(self tagexists("tag_laser_attach")) {
    playFXOnTag(utility::getfx("vfx_flashlight_npc_perf_short_vip"), self, "tag_laser_attach");
  }

  if(function_42f59b2f83e6aec0()) {
    self dontcastshadows();
  }

  thread function_7ad012d64185f60();
  self waittill("initial_choreography_done");
  var_d908cbfb88087d25 = 0;

  if(isDefined(self.targetname)) {
    if(self.targetname == "courtyard_enemies_right_cage") {
      var_d908cbfb88087d25 = 1;
    }

    if(self.targetname == "courtyard_enemies_walkway_roof") {
      var_d908cbfb88087d25 = 1;
    }

    if(self.targetname == "courtyard_enemies_tower_int") {
      var_d908cbfb88087d25 = 1;
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "courtyard_right_building_guy") {
      var_d908cbfb88087d25 = 1;
    }

    if(self.script_noteworthy == "courtyard_tower_enemy") {
      var_d908cbfb88087d25 = 1;
    }
  }

  if(!var_d908cbfb88087d25) {
    self cleargoalentity();
    self setgoalvolumeauto(level.courtyard_vol_start_enemies);
    flag_wait("flag_courtyard_update_vols_to_gate");
    self setgoalvolumeauto(level.courtyard_vol_gate_enemies);
    flag_wait("flag_courtyard_helipad_enemies_spawned");
    self setgoalvolumeauto(level.courtyard_vol_helipad_enemies);
    flag_wait("flag_courtyard_helipad_player_seek_on");
    player_seek_enable();
    flag_wait("flag_courtyard_exit_passed_helipad");
    set_baseaccuracy(0);
    self.health = 10;
    player_seek_disable();
    self cleargoalentity();
    self setgoalvolumeauto(level.courtyard_vol_retreat_enemies);
    self aisetdesiredspeed(randomintrange(150, 220));
  }

  flag_wait_any("flag_courtyard_exit_teleport_allies_right", "flag_courtyard_exit_teleport_allies_left");
  wait randomfloatrange(0, 1);
  self kill();
}

function function_4a96dbd5beead42e() {
  vol = getEnt("courtyard_zipline_hint_vol", "targetname");
  touching = 0;

  while(!flag("courtyard_zipline_used")) {
    if(level.player istouching(vol) && !touching) {
      touching = 1;
      thread function_c30c11dde06f44ac();
      utility::display_hint("zipline_hint", 60, 0, level.player, "kill_zipline_hint");
    }

    if(!level.player istouching(vol) && touching) {
      touching = 0;
      level.player notify("kill_zipline_hint");
    }

    waitframe();
  }
}

function function_c30c11dde06f44ac() {
  level.player endon("kill_zipline_hint");
  level.player waittill("ascender_device_use_success");
  flag_set("courtyard_zipline_used");
  level.player notify("kill_zipline_hint");
}

function function_67df4cb8788c501a(endon_notif, kill_flag) {
  level endon(endon_notif);
  flag_wait(kill_flag);
  thread function_fcdf944672a85396(level.player getEye(), 15, 25, 1);
  wait 0.5;
  level.player kill();
}

function function_a0838fc1013efcc3() {
  triggers = getEntArray("courtyard_struggle_vignette_triggers", "script_noteworthy");

  foreach(trig in triggers) {
    trig thread function_9284047af5e3617e();
  }
}

function function_9284047af5e3617e() {
  scene_struct = getStruct(self.target, "targetname");
  self waittill("trigger");

  if(istrue(scene_struct.triggered)) {
    return;
  }

  do_intro = 0;

  if(isDefined(self.script_parameters) && self.script_parameters == "do_intro") {
    do_intro = 1;
  }

  scene_struct thread function_d3a80fb8ce54bcb1(do_intro, &function_78a85d86a981699a, &courtyard_enemy_think, 5);
  scene_struct.triggered = 1;
}

function function_45c2284963670e5() {
  spawner = getspawner("courtyard_vista_prisoner_spawner", "targetname");
  level.var_7213d5845d183df8 = [];
  var_90dafce9bff985e0 = 1;
  var_90b812e9bfd36e8a = 5;
  max_guys = 10;

  if(function_42f59b2f83e6aec0()) {
    max_guys = 2;
    wait 1;
  }

  while(!flag("flag_courtyard_update_vols_to_gate")) {
    level.var_7213d5845d183df8 = array_removedead_or_dying(level.var_7213d5845d183df8);

    if(level.var_7213d5845d183df8.size < max_guys && function_c7aa276c65157d1a()) {
      spawner.count = 100;
      guy = spawner spawn_ai(1);
      guy thread function_cd39050793615f82();
      wait randomfloatrange(var_90dafce9bff985e0, var_90b812e9bfd36e8a);
    }

    waitframe();
  }
}

function function_cd39050793615f82() {
  self endon("death");
  utility::add_damage_function(&function_d799ec6e01836246);
  level.var_7213d5845d183df8 = array_add(level.var_7213d5845d183df8, self);
  self aisetdesiredspeed(randomintrange(150, 220));
  set_baseaccuracy(0);
  self.name = "";
  var_6cfd2ca3029472ef = 3;
  var_6cda1aa3026e03a1 = 8;
  vol1 = getEnt("courtyard_vista_prisoner_vol_1", "targetname");
  vol2 = getEnt("courtyard_vista_prisoner_vol_2", "targetname");
  vol3 = getEnt("courtyard_vista_prisoner_vol_3", "targetname");
  vol_end = getEnt("courtyard_vista_prisoner_vol_end", "targetname");

  if(cointoss()) {
    self setgoalvolumeauto(vol1);
    wait randomfloatrange(var_6cfd2ca3029472ef, var_6cda1aa3026e03a1);
  }

  if(cointoss()) {
    self setgoalvolumeauto(vol2);
    wait randomfloatrange(var_6cfd2ca3029472ef, var_6cda1aa3026e03a1);
  }

  if(cointoss()) {
    self setgoalvolumeauto(vol3);
    wait randomfloatrange(var_6cfd2ca3029472ef, var_6cda1aa3026e03a1);
  }

  self setgoalvolumeauto(vol_end);
  self waittill("goal");
  wait 2;
  self delete();
}

function function_52e5bb0e329da129() {
  sandbags = getEntArray("courtyard_tower_sandbags", "targetname");

  foreach(obj in sandbags) {
    obj hide();
  }

  var_2e07c346b0599dc6 = getEntArray("courtyard_static_reinf_truck_ents", "targetname");

  foreach(ent in var_2e07c346b0599dc6) {
    ent notsolid();
    ent hide();
  }

  flag_wait("scriptables_ready");
  barrels = getscriptablearray("courtyard_red_barrels", "targetname");

  foreach(barrel in barrels) {
    barrel setscriptablepartstate("base", "hidden");
  }

  flag_wait("cine_elevator_end");

  foreach(barrel in barrels) {
    barrel setscriptablepartstate("base", "healthy");
  }

  if(function_42f59b2f83e6aec0()) {
    foreach(ent in var_2e07c346b0599dc6) {
      ent solid();
      ent show();
    }
  }
}

function function_36ab55de1c5166ee() {
  org = getStruct("courtyard_prisoner_weapon_grab_anim_org", "targetname");
  guy = spawn_targetname("courtyard_elevator_exit_weapon_guy");
  guy invisiblenotsolid();
  guy.animname = "guy";
  level.var_55ac4c093cd8a163 = guy;
  guy thread function_9144f3225588f5d8(guy);
  org anim_single_solo(guy, "courtyard_prisoner_weapon_grab");
  guy function_be4ba477a4d5cfc0();
}

function function_9144f3225588f5d8(guy) {
  waitframe();
  waitframe();
  anim_set_time_solo(guy, "courtyard_prisoner_weapon_grab", 0.625);
  waitframe();
  guy visiblesolid();
}

function function_75d381e17723d980() {
  thread function_7c1d425f332127a7();
  start = getStruct("courtyard_jet_rocket_start", "targetname");
  end = getStruct("courtyard_jet_rocket_end", "targetname");
  wait 2.95;
  autosave_by_name("courtyard_encounter");
  wait 0.5;
  exploder("tower_dest_missile");
  wait 1;
  flag_set("flag_courtyard_jet_strike_hit");
  wait 0.25;
  flag_set("vfx_start_gulag_destruction");
  level notify("kill_mg_nest");
  playrumbleonposition("grenade_rumble", level.player.origin);
}

function function_7c1d425f332127a7() {
  wait 3.7;
  movetime = 6;
  snd_play("temp_veh_jet_flyby_close_fast", level.player);
  jet1 = getEnt("courtyard_flyover_jet_1", "targetname");
  jet2 = getEnt("courtyard_flyover_jet_2", "targetname");
  jets = [jet1, jet2];

  foreach(jet in jets) {
    jet show();
  }

  playFXOnTag(getfx("vfx_vip_jet_thrusters"), jet1, "tag_origin");
  playFXOnTag(getfx("vfx_vip_jet_thrusters"), jet2, "tag_origin");
  wait 0.1;
  playFXOnTag(getfx("vfx_vip_jet_trails"), jet1, "tag_origin");
  playFXOnTag(getfx("vfx_vip_jet_trails"), jet2, "tag_origin");

  foreach(jet in jets) {
    targ = getStruct(jet.target, "targetname");
    jet moveTo(targ.origin, movetime);
  }

  wait movetime;
  killfxontag(getfx("vfx_vip_jet_thrusters"), jet1, "tag_origin");
  killfxontag(getfx("vfx_vip_jet_thrusters"), jet2, "tag_origin");
  wait 0.1;
  stopFXOnTag(getfx("vfx_vip_jet_trails"), jet1, "tag_origin");
  stopFXOnTag(getfx("vfx_vip_jet_trails"), jet2, "tag_origin");

  foreach(jet in jets) {
    jet hide();
  }
}

function function_247601276cb69bf1(targ_array, var_f89fbe1fac74f05a, end_notif) {
  var_c4663408634b46df = 0.4;
  var_daf5183e427e19dd = 1;
  self.fire_cancelled = 0;

  while(!flag("flag_courtyard_jet_strike_hit")) {
    foreach(targ in targ_array) {
      function_fcdf944672a85396(targ, 2, 10, var_f89fbe1fac74f05a);
      wait randomfloatrange(var_c4663408634b46df, var_daf5183e427e19dd);

      if(istrue(self.fire_cancelled)) {
        return;
      }
    }

    waitframe();
  }
}

function function_fcdf944672a85396(targ, min_shots, max_shots, var_f89fbe1fac74f05a) {
  var_9978a502373c7aae = self;
  fire_delay = 0.05;

  if(isent(targ)) {
    start_org = targ.origin;
  }

  var_ec26d5efe3c3bc7b = spawn_tag_origin();
  shot_count = randomintrange(min_shots, max_shots);

  for(i = 0; i < shot_count; i++) {
    if(istrue(self.fire_cancelled)) {
      return;
    }

    if(!isent(targ)) {
      end = targ;
    } else if(isalive(targ)) {
      end = targ getEye();
    } else {
      end = start_org;
    }

    if(flag("flag_courtyard_jet_strike_hit")) {
      return;
    }

    if(!isDefined(end)) {
      return;
    }

    if(isstruct(end)) {
      end = end.origin;
    }

    magicbullet("jup_mg_jltv_sp_vip", var_9978a502373c7aae.origin, end, undefined, undefined, 1);
    playFXOnTag(getfx("vfx_mg_muzzle"), var_ec26d5efe3c3bc7b, "tag_origin");
    var_9978a502373c7aae thread function_bf856a2c1056577(end);
    waitframe();
    wait fire_delay;

    if(var_f89fbe1fac74f05a) {
      source = level.player.origin;
      pitch = randomfloatrange(0.075, 0.15);
      yaw = randomfloatrange(0.075, 0.15);
      roll = randomfloatrange(0.075, 0.15);
      duration = randomfloatrange(0.1, 0.15);
      durationfadeup = 0;
      durationfadedown = 0;
      freqpitch = randomfloatrange(9, 10);
      freqyaw = randomfloatrange(9, 10);
      freqroll = randomfloatrange(9, 10);
      waitframe();
      screenshake(source, pitch, yaw, roll, duration, durationfadeup, durationfadedown, 0, freqpitch, freqyaw, freqyaw);
    }

    if(i > shot_count / randomfloatrange(2, 3) && isalive(targ) && !istrue(targ.var_744937d2c8ab33b)) {
      targ kill();
    }

    if(flag("flag_courtyard_jet_strike_hit")) {
      return;
    }
  }

  var_ec26d5efe3c3bc7b delete();
}

function function_bf856a2c1056577(end) {
  var_1424136b774ede11 = spawn_tag_origin();
  rand = randomvectorrange(0, 0.5);

  if(cointoss()) {
    rand *= -1;
  }

  var_1424136b774ede11 moveTo(end + rand, 0.2, 0, 0);
  wait 0.2;
  stopFXOnTag(getfx("vfx_mg_tracer"), var_1424136b774ede11, "tag_origin");
  var_1424136b774ede11 delete();
}

function function_4ff51f995f14e1f() {
  level.tower_orgs = getStructArray("courtyard_ambient_shot_tower_structs", "targetname");
  level.prisoner_orgs = getStructArray("courtyard_ambient_shot_prisoner_structs", "targetname");
  thread function_5960909b3bd66515(1);
  thread function_5960909b3bd66515(0);
}

function function_e2979f5eef1974cc() {
  structs = getStructArray("courtyard_ambient_shot_tower_structs", "targetname");

  foreach(struct in structs) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "disable_on_jet_strike") {
      level.tower_orgs = array_remove(level.tower_orgs, struct);
      struct notify("stop_firing");
    }
  }
}

function function_5960909b3bd66515(var_978cde78898e61ee) {
  var_c88c655703aecbf0 = 32;
  var_f45d9d1e24dc34ea = 0.15;
  var_eee8ac7cb647c1fa = 10;
  min_delay = 0.1;
  max_delay = 0.8;

  while(!flag("flag_courtyard_exit_passed_helipad")) {
    org = random(var_978cde78898e61ee ? level.tower_orgs : level.prisoner_orgs);
    targ = random(var_978cde78898e61ee ? level.prisoner_orgs : level.tower_orgs);
    org childthread function_cbd5a368aeb67f64(targ, var_c88c655703aecbf0, var_f45d9d1e24dc34ea, var_eee8ac7cb647c1fa, var_978cde78898e61ee);
    wait randomfloatrange(min_delay, max_delay);
  }
}

function function_cbd5a368aeb67f64(targ, var_c88c655703aecbf0, var_f45d9d1e24dc34ea, var_eee8ac7cb647c1fa, var_978cde78898e61ee) {
  self notify("stop_firing");
  self endon("stop_firing");
  shot_count = randomintrange(1, var_eee8ac7cb647c1fa);
  rocket_chance = 0.1;
  wait_time = randomfloatrange(0.05, var_f45d9d1e24dc34ea);

  if(!isDefined(self.var_ec26d5efe3c3bc7b)) {
    self.var_ec26d5efe3c3bc7b = spawn_tag_origin();
  }

  if(randomfloatrange(0, 1) > rocket_chance || !flag("flag_courtyard_jet_strike_hit")) {
    for(i = 0; i < shot_count; i++) {
      targ_offset = randomvectorrange(0, var_c88c655703aecbf0);
      self.var_ec26d5efe3c3bc7b fake_bullet(targ.origin + targ_offset, "jup_mg_jltv_sp_vip", "vfx_mg_muzzle");
      thread namespace_165c742e346e899e::courtyard2_fake_mg_bullet_impact(targ.origin);

      if(i == 0) {
        thread namespace_165c742e346e899e::function_5113bf8402da1f07(self.var_ec26d5efe3c3bc7b, shot_count, var_978cde78898e61ee);
      }

      wait wait_time;
    }

    return;
  }

  targ_offset = randomvectorrange(0, var_c88c655703aecbf0);
  rocket = magicbullet("iw9_la_rpapa7_sp_vip", self.origin, targ.origin + targ_offset);
  thread namespace_165c742e346e899e::function_8b9f69a35e622471(rocket);
}

function function_f7c97a76fc9bcf7c() {
  var_5cbc6d52b656fd2b = getEnt("spotlight_charlie_3_base", "targetname");
  var_7fbefe96bb2a56c7 = getEnt("spotlight_charlie_3_face", "targetname");
  var_6c0d54e2390197 = utility::getStruct("spotlight_charlie_3_rotation", "targetname");
  var_54367e376e5bb384 = utility::spawn_tag_origin(var_6c0d54e2390197.origin, var_6c0d54e2390197.angles);
  var_a4c9c2e3b5c4d820 = utility::spawn_tag_origin(var_6c0d54e2390197.origin + (10, 10, 0), var_6c0d54e2390197.angles);
  var_a4c9c2e3b5c4d820 linkTo(var_54367e376e5bb384, "tag_origin", var_a4c9c2e3b5c4d820.origin - var_54367e376e5bb384.origin, (0, 0, -90));
  var_7fbefe96bb2a56c7 linkTo(var_54367e376e5bb384, "tag_origin", (0, 0, -80), (0, 0, 0));
  var_54367e376e5bb384 linkTo(var_5cbc6d52b656fd2b, "tag_origin", (0, 0, 80), (0, 0, 0));
  playFXOnTag(utility::getfx("vfx_vip_light_searchlight_wall_02"), var_a4c9c2e3b5c4d820, "tag_origin");
  var_54367e376e5bb384 rotatebylinked((0, 0, -15), 0.1);
}

function function_9d5d2eda4f260cb5(targ, optional_delay) {
  if(isDefined(optional_delay)) {
    wait optional_delay;
  }

  self notify("kill_logic");
  self endon("kill_logic");
  min_ang = 1;
  max_ang = 2;
  min_time = 0.75;
  max_time = 1;
  min_delay = 0.2;
  max_delay = 1.25;
  direction = targ.origin - self.origin;
  ang = vectortoangles(direction);
  self rotateTo(ang, 2, 1, 1);

  while(true) {
    rand_offset = randomvectorrange(min_ang, max_ang);

    if(cointoss()) {
      rand_offset *= -1;
    }

    rot_time = randomfloatrange(min_time, max_time);
    self rotateTo(ang + rand_offset, rot_time, rot_time * 0.5, rot_time * 0.5);
    wait rot_time;
    wait randomfloatrange(min_delay, max_delay);
  }
}

function function_6d7a8ea9dae88066() {
  self endon("death");
  self endon("stop_runner_think");
  disable_pain();
  self aisetdesiredspeed(randomintrange(175, 250));
  self waittill("goal");
  self delete();
}

function function_2a0ec0b9028a2a77() {
  self.animname = "guy";
  wait 10;
  stumbles = ["courtyard_prisoner_runner_stumble_01", "courtyard_prisoner_runner_stumble_02", "courtyard_prisoner_runner_stumble_03", "courtyard_prisoner_runner_stumble_04", "courtyard_prisoner_runner_stumble_05", "courtyard_prisoner_runner_stumble_06"];

  while(true) {
    wait randomfloatrange(0, 5);
    anim_single_solo(self, random(stumbles));
  }
}

function function_541f5daed5730fde() {
  if(function_42f59b2f83e6aec0()) {
    return;
  }

  flag_wait("flag_courtyard_helipad_encounter_reached");
  truck = spawn_vehicle_from_targetname_and_drive("courtyard_prisoner_truck", 1);
  truck.script_allow_driver_death = 0;
  thread namespace_165c742e346e899e::function_8b28f6fd65f48d38(truck);
  truck waittill("reached_end_node");
  thread namespace_165c742e346e899e::function_4704fbc716921ec6(truck);
  truck kill();
  in_fov = within_fov(level.player getEye(), level.player getgunangles(), truck.origin + (0, 0, 120), cos(50));
  can_see = sighttracepassed(level.player getEye(), truck.origin + (0, 0, 120), 0, truck);

  if(in_fov && can_see) {
    source = level.player.origin;
    pitch = 7;
    yaw = 7;
    roll = 0;
    duration = 1;
    durationfadeup = 0;
    durationfadedown = 1;
    freqpitch = 5;
    freqyaw = 10;
    freqroll = 15;
    screenshake(source, pitch, yaw, roll, duration, durationfadeup, durationfadedown, 0, freqpitch, freqyaw, freqyaw);
    playrumbleonposition("grenade_rumble", level.player.origin);
  }
}

function function_58747f455097f103() {
  level.heli = spawn_vehicle_from_targetname_and_drive("courtyard_heli");
  vehicle_build::build_treadfx(level.heli.classname_mp, "default", "vfx/jup/level/sp_jup_vip/vfx_vip_heli_dust_tread_water.vfx", 1);
  level.var_4232878d3c538342 = spawn_tag_origin();
  var_4b3a4a08afc855f5 = spawn_tag_origin();
  var_4b3a4a08afc855f5 linkTo(level.heli, "tag_turret", (35, 0, 0), (30, 0, 0), 0);
  var_4b3a4a08afc855f5 thread function_db1bfa0b2a540019(level.heli);
  playFXOnTag(getfx("vfx_vip_heli_light_cockpit"), level.heli, "tag_ik_loc_ri_seat_0");
  playFXOnTag(getfx("vfx_vip_heli_lights_blinkies"), level.heli, "body_animate_jnt");
  thread namespace_165c742e346e899e::function_3c07b25b2cbe9403();
  thread namespace_165c742e346e899e::function_fdf48407f0c84ed1();
  gunnertag = level.heli gettagorigin("tag_gunner");
  turret = spawnturret("misc_turret", gunnertag, "chopper_gunner_turret_vip");
  turret linkTo(level.heli, "tag_turret", (5, 0, -5), (30, 0, 0));
  turret setModel("veh9_mil_air_heli_hind_turret");
  turret setmode("manual");
  turret setdefaultdroppitch(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret settoparc(5);
  turret setbottomarc(90);
  turret setconvergencetime(0.5, "yaw");
  turret setconvergencetime(0.5, "pitch");
  turret.convergencetime = 0.5;
  turret setturretteam("axis");
  turret.suppressiontime = 2;
  turret.accuracy = 0.01;
  turret.aispread = 180;
  turret thread function_b802cf956232f94e();
  level.heli thread function_81e279966d2cf98f();
  thread flag_set_delayed("flag_courtyard_entry_stop_vo_pre_heli", 2);
  thread flag_set_delayed("flag_courtyard_heli_stop_targetting_close_prisoners", 8);
  flag_wait("flag_courtyard_exit_passed_helipad");
  var_3ae1b405e0b2ddb4 = 0;

  while(var_3ae1b405e0b2ddb4 < 1.5) {
    in_fov = within_fov(level.player getEye(), level.player getgunangles(), level.heli.origin, cos(60));
    can_see = sighttracepassed(level.player getEye(), level.heli.origin, 0, level.heli);

    if(!in_fov || !can_see) {
      var_3ae1b405e0b2ddb4 += 0.05;
    } else {
      var_3ae1b405e0b2ddb4 = 0;
    }

    waitframe();
  }

  killfxontag(getfx("vfx_vip_heli_light_cockpit"), level.heli, "tag_ik_loc_ri_seat_0");
  killfxontag(getfx("vfx_vip_heli_lights_blinkies"), level.heli, "body_animate_jnt");
  turret delete();
  level.heli delete();
}

function function_db1bfa0b2a540019(heli) {
  fx_org = spawn_tag_origin();
  playFXOnTag(getfx("vfx_vip_lgt_heli_search"), fx_org, "tag_origin");

  while(isalive(heli)) {
    fx_org.origin = self.origin;
    dir = level.var_4232878d3c538342.origin - fx_org.origin;
    rot = vectortoangles(dir);
    fx_org.angles = rot;
    waitframe();
  }

  killfxontag(getfx("vfx_vip_lgt_heli_search"), fx_org, "tag_origin");
}

function function_81e279966d2cf98f() {
  self endon("death");
  var_a472343e86e4d23a = 4;
  var_a4951e3e870ae990 = 6;
  flag_wait("flag_courtyard_encounter_enable_chopper_shoot_warnings");

  while(true) {
    self waittill("bullethit", attacker);

    if(attacker == level.player) {
      val = randomintrange(0, 3);

      if(val == 0) {
        level.ally1 say("dx_sp_jvip_cohn_ivan_leavetheheloandgetto");
      }

      if(val == 1) {
        level.ally1 say("dx_sp_jvip_cohn_ivan_ignorethehelogettoth");
      }

      if(val == 2) {
        level.ally1 say("dx_sp_jvip_cohn_ivan_wehavetogettothetunn");
      }
    }

    wait randomfloatrange(var_a472343e86e4d23a, var_a4951e3e870ae990);
  }
}

function function_b802cf956232f94e() {
  self endon("stop_turret_fire");
  self endon("death");
  fire_time = weaponfiretime("chopper_gunner_turret_vip");
  fired_time = 0;
  var_b978c5e1c11575ff = 0.75;
  var_b955d3e1c0ef4d11 = 1.5;
  var_4ea16a8f320fa98e = 2;
  var_4e7e5c8f31e9430c = 4;
  var_affeff1f5d43ac94 = 1750;
  var_2b4687cf5bd796d1 = 128;

  if(function_42f59b2f83e6aec0()) {
    var_b978c5e1c11575ff = 2;
    var_b955d3e1c0ef4d11 = 3;
  }

  targ = spawn_tag_origin();
  ambient_target_orgs = getStructArray("courtyard_ambient_shot_prisoner_structs", "targetname");

  while(true) {
    shot_count = randomintrange(var_4ea16a8f320fa98e, var_4e7e5c8f31e9430c);

    if(function_42f59b2f83e6aec0()) {
      shot_count = 1;
    }

    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    level.var_7213d5845d183df8 = array_removedead_or_dying(level.var_7213d5845d183df8);
    targ_object = undefined;

    if(!flag("flag_courtyard_heli_stop_targetting_close_prisoners")) {
      all_prisoners = array_merge(level.courtyard_prisoners, level.var_7213d5845d183df8);

      foreach(guy in all_prisoners) {
        if(distance(guy.origin, level.player.origin) < var_2b4687cf5bd796d1) {
          all_prisoners = array_remove(all_prisoners, guy);
        }

        if(distance(guy.origin, level.player.origin) > var_affeff1f5d43ac94) {
          all_prisoners = array_remove(all_prisoners, guy);
        }
      }

      targ_object = function_111864c6ca2941be(all_prisoners);

      if(!isDefined(targ_object)) {
        close_array = get_array_of_closest(self.origin, ambient_target_orgs);
        targ_object = close_array[0];
      }
    } else {
      close_array = get_array_of_closest(self.origin, ambient_target_orgs);
      targ_object = close_array[0];
    }

    targ.origin = targ_object.origin;
    level.var_4232878d3c538342 moveTo(targ.origin, 0.25, 0.1, 0.1);
    self settargetentity(targ);
    wait 0.25;

    for(i = 0; i < shot_count + 1; i++) {
      self shootturret("tag_flash");
      wait fire_time;
    }

    wait randomfloatrange(var_b978c5e1c11575ff, var_b955d3e1c0ef4d11);
  }
}

function function_a1c2cde86a7886b4(var_dcb0b6d89c18eb6e, wait_time, add_offset) {
  if(isDefined(wait_time)) {
    wait wait_time;
  }

  org = getStruct(var_dcb0b6d89c18eb6e, "targetname");
  spawn_offset = (-32, -32, 8);

  if(isDefined(add_offset)) {
    spawn_offset = add_offset;
  }

  turret = spawnturret("misc_turret", org.origin + spawn_offset, "chopper_gunner_turret_vip");
  turret.angles += (0, 0, 180);
  turret setModel("veh9_mil_air_heli_hind_turret");
  turret setmode("manual");
  turret setdefaultdroppitch(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret settoparc(360);
  turret setbottomarc(360);
  turret setconvergencetime(0.1, "yaw");
  turret setconvergencetime(0.1, "pitch");
  turret.convergencetime = 0.1;
  turret setturretteam("axis");
  targ_struct = getStruct(org.target, "targetname");
  targ = targ_struct spawn_tag_origin();
  turret settargetentity(targ);
  waitframe();
  turret shootturret("tag_flash");
  waitframe();
  turret shootturret("tag_flash");
  waitframe();
  turret delete();
  targ delete();
}

function function_e9f4b05089a66bca() {
  trigs = getEntArray("courtyard_makarov_moment_triggers", "targetname");

  foreach(trig in trigs) {
    trig thread function_cdac884a7c75db4b();
  }
}

function function_cdac884a7c75db4b() {
  self waittill("trigger");
  guy = spawn_targetname(self.target, 1);
  guy thread function_7ad012d64185f60();
  guy set_ignoreall(1);
  var_a7981244ff4f0b2b = getStruct(self.target, "targetname");
  level.makarov forceteleport(var_a7981244ff4f0b2b.origin, var_a7981244ff4f0b2b.angles);
  activate_trigger_with_targetname(var_a7981244ff4f0b2b.target);
}

function function_64db928b8ca53ae4() {
  level endon("flag_escape_redirect_start");
  debug_active = 0;
  courtyard_z = 1300;
  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    if(corpse.origin[2] < courtyard_z) {
      corpse delete();
    }
  }

  while(true) {
    corpses = getcorpsearray();

    if(corpses.size == 0) {
      wait 0.5;
      continue;
    }

    if(debug_active) {
      iprintln(corpses.size + "<dev string:x1c>");
    }

    foreach(corpse in corpses) {
      if(!istrue(corpse.cleanup_running)) {
        corpse.cleanup_running = 1;
        corpse thread function_2e4abbc926ce3524();
      }
    }

    wait 0.5;
  }
}

function function_2e4abbc926ce3524() {
  self endon("death");
  check_dist = 300;

  while(true) {
    in_fov = within_fov(level.player getEye(), level.player getgunangles(), self.origin, cos(getdvarint(@ "cg_fov")));
    far_away = distance(level.player.origin, self.origin) > check_dist;

    if(far_away && !in_fov) {
      self delete();
    }

    wait 0.5;
  }
}

function function_bb46a27907f30d5c() {
  active = 0;

  while(active) {
    level.courtyard_enemies = array_removedead(level.courtyard_enemies);
    level.courtyard_prisoners = array_removedead(level.courtyard_prisoners);
    level.var_7213d5845d183df8 = array_removedead(level.var_7213d5845d183df8);

    iprintln(level.courtyard_enemies.size + "<dev string:x2c>" + level.courtyard_prisoners.size + "<dev string:x37>" + level.var_7213d5845d183df8.size + "<dev string:x44>");

    waitframe();
  }
}

function function_c7aa276c65157d1a() {
  if(!function_42f59b2f83e6aec0()) {
    return 1;
  }

  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);

  if(level.courtyard_prisoners.size < 4) {
    return 1;
  }

  return 0;
}

function function_42f59b2f83e6aec0() {
  if(isplatformxb3() || isplatformps4() || level.var_ecd8c327b55af5e8) {
    return 1;
  }

  return 0;
}

function function_ff8247487cfb4eb9(struct_targ, force) {
  org = getStruct(struct_targ, "targetname");
  height_offset = (0, 0, 32);

  if(istrue(force)) {
    self forceteleport(org.origin, org.angles, 10000, 1);
    return;
  }

  in_fov = within_fov(level.player getEye(), level.player getgunangles(), self.origin + height_offset, cos(80));
  can_see = sighttracepassed(level.player getEye(), self.origin + height_offset, 0, self);

  if(!in_fov || in_fov && !can_see) {
    self forceteleport(org.origin, org.angles, 10000, 1);
  }
}

function function_d2647b3a158eedb5(vol_targ) {
  self endon("death");
  self.var_4fc24134fe792d97 = 0;
  vol = getEnt(vol_targ, "targetname");

  while(true) {
    if(!self istouching(vol)) {
      waitframe();
      continue;
    }

    break;
  }

  self.var_4fc24134fe792d97 = 1;
}

function function_f2d4304e97766f76(org) {
  self endon("death");

  while(true) {
    utility::aim_at(org.origin, 0, undefined, 1.5);
    self shoot(10, org.origin);
    wait 0.2;
  }
}

function function_839a059b851ad908() {
  prisoner_structs = getStructArray("courtyard_arrive_prisoner_anim_orgs", "targetname");

  foreach(org in prisoner_structs) {
    guy = spawn_targetname("courtyard_arrive_prisoner_structs_spawner", 1);
    guy setModel(random(level.var_3e8bdb241a36d9d6));
    org thread function_34d7e5ec7e16548c(guy);
    waitframe();
  }
}

function function_34d7e5ec7e16548c(guy) {
  anime = self.animation;
  guy visiblenotsolid();
  guy deletable_magic_bullet_shield();
  guy.animname = "guy";
  guy gun_remove();
  thread anim_loop_solo(guy, anime);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "kill") {
    waitframe();
    self notify("stop_loop");
    guy anim_stopanimScripted();
    guy ai_ragdoll_immediate();
    return;
  }

  flag_wait("flag_courtyard_opening_view_reached");
  guy function_2e4abbc926ce3524();
}

function function_7ef8f55dec9c51d4() {
  self endon("entitydeleted");

  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker == level.player) {
      break;
    }

    waitframe();
  }

  ai_ragdoll_immediate();
}

function function_95e220adc562801c() {}

function courtyard_retreat_catchup() {
  flag_set("flag_escape_tunnel_enter");
}

function courtyard_retreat_start() {
  thread function_e39d8a96b86719ce(0);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_333c73e0dcbdc794();
  thread namespace_165c742e346e899e::function_17574a02c3d82efe();
  function_3a4e080be3f70a75();
  spawn_allies();
  level.ally1 function_ff8247487cfb4eb9("courtyard_retreat_ally1_start", 1);
  level.ally2 function_ff8247487cfb4eb9("courtyard_retreat_ally2_start", 1);
  function_dc2aa213aa5830aa(getStruct("elevator_retreat_makarov_start", "targetname"));
  level.allies = [level.makarov, level.ally1, level.ally2];
  set_start_location("courtyard_retreat_start_org", [level.player]);
  thread function_4ff51f995f14e1f();
  setsaveddvar(@ "hash_f0ef87209242c743", 0);
  thread function_a533d8921f706b7e();
  level thread function_c6aecb595687f644();
}

function function_462d0abc80ff9e56() {
  level.ally1 say("dx_sp_jvip_enhp_ivan_letsgetthesegunsdown");
  level.makarov say("dx_sp_jvip_ensb_maka_gettothetunnelforext");
  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
  level.courtyard_prisoners = get_array_of_closest(level.player.origin, level.courtyard_prisoners);
  level.courtyard_prisoners[0] say("dx_sp_jvip_copr_pri1_letsgoletsgo");
  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
  level.courtyard_prisoners[1] say("dx_sp_jvip_copr_pri2_werealmostfree");
  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
  level.courtyard_prisoners[2] say("dx_sp_jvip_copr_pri1_keeppushing");

  if(!flag("flag_escape_redirect_start")) {
    thread function_51a1b823a9a2e235();
  }
}

function function_51a1b823a9a2e235() {
  level endon("flag_escape_redirect_start");
  var_e08526ad4a5a2c1a = 15;
  var_6733ea1672e3dd44 = 20;
  choice = 1;
  choice_max = 5;

  while(true) {
    wait randomfloatrange(var_e08526ad4a5a2c1a, var_6733ea1672e3dd44);

    switch (choice) {
      case 1:
        level.makarov say("dx_sp_jvip_ensb_maka_alltroopstothetunnel", 0, 3);
        break;
      case 2:
        level.ally1 say("dx_sp_jvip_tuna_ivan_gettothetunnelthatso", 0, 3);
        break;
      case 3:
        level.makarov say("dx_sp_jvip_ensb_maka_allteamstothetunnelf", 0, 3);
        break;
      case 4:
        level.ally1 say("dx_sp_jvip_ensb_ivan_copyactualyouheardth", 0, 3);
        break;
      case 5:
        level.makarov say("dx_sp_jvip_ensb_maka_gettothetunnelforext", 0, 3);
        break;
      default:
        break;
    }

    choice += 1;

    if(choice > choice_max) {
      choice = 1;
    }
  }
}

function courtyard_retreat_main() {
  wait 0.1;
  flag_wait("flag_courtyard_exit_passed_helipad");
  flag_set("flag_courtyard_helipad_player_seek_on");
  thread function_462d0abc80ff9e56();
  activate_trigger_with_targetname("courtyard_retreat_allies_helipad");

  foreach(guy in level.allies) {
    guy thread function_d2647b3a158eedb5("courtyard_exit_squad_check_vol");
  }

  array_spawn_function_targetname("courtyard_retreat_enemies", &courtyard_enemy_think);
  array_spawn_function_targetname("courtyard_retreat_prisoners_start", &function_78a85d86a981699a, 1);
  thread function_f35085136acaa12f();

  if(!function_42f59b2f83e6aec0()) {
    array_spawn_targetname("courtyard_retreat_enemies", 0, 1, undefined, 1);
    wait 0.25;
    array_spawn_targetname("courtyard_retreat_prisoners_start", 0, 1, undefined, 1);
  } else {
    max_prisoners = 7;
    max_enemies = 9;
    enemy_spawners = getspawnerarray("courtyard_retreat_enemies");
    prisoner_spawners = getspawnerarray("courtyard_retreat_prisoners_start");
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    while(level.courtyard_enemies.size < max_enemies) {
      spawner = random(enemy_spawners);

      if(!isDefined(spawner)) {
        break;
      }

      spawner spawn_ai();
      enemy_spawners = array_remove(enemy_spawners, spawner);
      waitframe();
      level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);
    }

    level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);

    while(level.courtyard_prisoners.size < max_prisoners) {
      spawner = random(prisoner_spawners);

      if(!isDefined(spawner)) {
        break;
      }

      spawner spawn_ai();
      prisoner_spawners = array_remove(prisoner_spawners, spawner);
      waitframe();
      level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    }
  }

  flag_wait("flag_courtyard_retreat_player_pushed_past_helipad");
  flag_set("flag_obj_courtyard_reach_gatehouse");
  level.makarov demeanor_override("sprint");
  level.makarov setavoidanceradius(8);
  level.ally1 demeanor_override("sprint");
  level.ally1 setavoidanceradius(8);
  level.ally2 demeanor_override("sprint");
  level.ally2 setavoidanceradius(8);
  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
  closest_prisoners = get_array_of_closest((0, 2000, 0), level.courtyard_prisoners);

  for(i = 0; i < 4; i++) {
    closest_prisoners[i] thread function_e3920f40737f6544();
  }

  activate_trigger_with_targetname("courtyard_retreat_prisoners_leading_push_up_trig");
  thread function_723aa388336f5de4();
  flag_wait("flag_courtyard_retreat_send_allies_to_anim_start");
}

function function_b70c9147e961ac46() {
  level endon("flag_courtyard_exit_passed_helipad");

  while(true) {
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    if(level.courtyard_enemies.size < 6) {
      flag_set("flag_courtyard_helipad_player_seek_on");
      break;
    }

    waitframe();
  }

  while(true) {
    level.courtyard_enemies = array_removedead_or_dying(level.courtyard_enemies);

    if(level.courtyard_enemies.size < 4) {
      wait 0.5;
      flag_set("flag_courtyard_player_defeated_helipad");
      flag_set("flag_courtyard_exit_passed_helipad");
      return;
    }

    waitframe();
  }
}

function function_f35085136acaa12f() {
  disable_trigger_with_targetname("courtyard_retreat_truck_hurt_trig");
  flag_wait("flag_courtyard_retreat_spawn_truck");
  spawner = getEnt("courtyard_retreat_reinf_truck", "targetname");
  spawner.script_allow_driver_death = 0;
  truck = spawn_vehicle_from_targetname_and_drive("courtyard_retreat_reinf_truck", 1);
  waitframe();
  thread namespace_165c742e346e899e::function_c66d03aeb8392cc3(truck);
  truck function_9ce59aa48970a667();
  truck.script_allow_driver_death = 0;
  truck.vehicle_keeps_going_after_driver_dies = 1;

  if(isDefined(truck.driver)) {
    truck.driver set_ignoreme(1);
  }

  waittill_any_ents(level, "courtyard_retreat_truck_hit_listen", truck, "reached_end_node");

  if(isDefined(truck.driver)) {
    truck.driver set_ignoreme(0);
  }

  left_org = getStruct("courtyard_retreat_truck_rpg_org_left", "targetname");
  right_org = getStruct("courtyard_retreat_truck_rpg_org_right", "targetname");
  var_582787cb8215c486 = undefined;
  safe_dist = 450;
  var_14c847ba9086e3fd = 550;

  while(true) {
    player_safe = distance(level.player.origin, truck.origin) > safe_dist;
    var_fe18f8e8ee685e72 = distance(level.makarov.origin, truck.origin) > safe_dist;
    var_e86308186eaab936 = distance(level.ally1.origin, truck.origin) > safe_dist;
    var_af6613018eed7261 = distance(level.ally2.origin, truck.origin) > safe_dist;
    var_66f2620aaada82fe = within_fov(level.player getEye(), level.player getgunangles(), left_org.origin, cos(50));
    var_6f825c2d2a8b4e21 = within_fov(level.player getEye(), level.player getgunangles(), right_org.origin, cos(50));

    if(player_safe && var_fe18f8e8ee685e72 && var_e86308186eaab936 && var_af6613018eed7261 && (!var_66f2620aaada82fe || !var_6f825c2d2a8b4e21)) {
      break;
    }

    waitframe();
  }

  if(!var_66f2620aaada82fe) {
    var_582787cb8215c486 = left_org;
  } else {
    var_582787cb8215c486 = right_org;
  }

  rocket = magicbullet("iw9_la_rpapa7_sp_vip", var_582787cb8215c486.origin, truck.origin);
  thread namespace_165c742e346e899e::function_d6157457a14fb91e(truck, rocket, var_582787cb8215c486.origin);
  wait 0.45;
  truck notsolid();
  truck vehphys_forcekeyframedmotion();
  truck function_7d7628da4296efab();
  truck.isstationary = 1;
  wait 0.1;
  vfx_angles = truck gettagangles("tag_origin");
  vfx_position = truck gettagorigin("tag_origin");
  thread namespace_165c742e346e899e::function_8df9693aa3cc1551(truck);
  truck kill();
  truck vehphys_forcekeyframedmotion();
  enable_trigger_with_targetname("courtyard_retreat_truck_hurt_trig");
  source = level.player.origin;
  pitch = 7;
  yaw = 7;
  roll = 0;
  duration = 1;
  durationfadeup = 0;
  durationfadedown = 1;
  freqpitch = 5;
  freqyaw = 10;
  freqroll = 15;
  waitframe();
  screenshake(source, pitch, yaw, roll, duration, durationfadeup, durationfadedown, 0, freqpitch, freqyaw, freqyaw);
  playrumbleonposition("grenade_rumble", level.player.origin);
  wait 0.1;
  playFX(getfx("vfx_vip_yard_truck_exp"), vfx_position, anglesToForward(vfx_angles), anglestoup(vfx_angles));
  scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::truck_explosion_look();
  wait 0.1;
  exploder("yard_truck_death");
}

function function_3bc50e3e36dbdfd() {
  var_b9f091c8d9830e38 = 18;
  level.courtyard_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
  nearest_prisoners = get_array_of_farthest(level.player.origin, level.courtyard_prisoners);

  while(nearest_prisoners.size > var_b9f091c8d9830e38) {
    nearest_prisoners[0] delete();
    nearest_prisoners = array_remove_index(nearest_prisoners, 0);
    nearest_prisoners = array_removedead_or_dying(level.courtyard_prisoners);
    waitframe();
  }
}

function courtyard_retreat_truck_hit_listen() {
  level endon("flag_courtyard_retreat_truck_destroy");

  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker == level.player) {
      flag_set("flag_courtyard_retreat_truck_destroy");
    }

    waitframe();
  }
}

function function_723aa388336f5de4() {
  flag_wait_any("flag_courtyard_exit_teleport_allies_left", "flag_courtyard_exit_teleport_allies_right");

  if(flag("flag_courtyard_exit_teleport_allies_left")) {
    if(!istrue(level.makarov.var_4fc24134fe792d97)) {
      level.makarov function_ff8247487cfb4eb9("courtyard_exit_tp_right_makarov");
    }

    if(!istrue(level.ally1.var_4fc24134fe792d97)) {
      level.ally1 function_ff8247487cfb4eb9("courtyard_exit_tp_right_ally1");
    }

    if(!istrue(level.ally2.var_4fc24134fe792d97)) {
      level.ally2 function_ff8247487cfb4eb9("courtyard_exit_tp_right_ally2");
    }

    return;
  }

  if(!istrue(level.makarov.var_4fc24134fe792d97)) {
    level.makarov function_ff8247487cfb4eb9("courtyard_exit_tp_left_makarov");
  }

  if(!istrue(level.ally1.var_4fc24134fe792d97)) {
    level.ally1 function_ff8247487cfb4eb9("courtyard_exit_tp_left_ally1");
  }

  if(!istrue(level.ally2.var_4fc24134fe792d97)) {
    level.ally2 function_ff8247487cfb4eb9("courtyard_exit_tp_left_ally2");
  }
}

function function_83b31d14730510f7() {}

function escape_start() {
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_881065c6aa2388e();
  thread namespace_165c742e346e899e::function_17574a02c3d82efe();
  thread function_e39d8a96b86719ce(0);
  spawn_allies();
  function_dc2aa213aa5830aa(getStruct("escape_makarov_start", "targetname"));
  set_start_location("escape_start", [level.player, level.ally1, level.ally2]);
  thread function_a533d8921f706b7e();
  level thread function_c6aecb595687f644();
}

function escape_main() {
  thread function_4bb6172b05e183cb();
  thread escape_vo();
  thread escape_fov();
  thread function_99edf228ea40e7f9();
  createthreatbiasgroup("bridge_enemies");
  createthreatbiasgroup("cliff_prisoners");
  array_spawn_function_targetname("escape_bridge_enemies", &function_349dd5a0d09e63f6);
  array_spawn_targetname("escape_bridge_enemies", 1, undefined, undefined, 1);
  thread function_dc5cceade7cf79a0();
  array_spawn_function_targetname("escape_bridge_prisoner", &function_95a5d84985436474);
  array_spawn_targetname("escape_bridge_prisoner", 1, undefined, undefined, 1);
  array_spawn_function_targetname("escape_tunnel_prisoner", &function_8abc17e6bfa3e885);
  array_spawn_targetname("escape_tunnel_prisoner", 1, undefined, undefined, 1);
  function_d5b0ae5d9122efe9();
  thread function_da47f4c6d16d0ce9();
  thread escape_tunnel_prisoner_reinforcement_survivor();
  flag_wait("flag_escape_hallway_prisoner_door_breach");
  function_e39d8a96b86719ce(1);
  var_c05c2a7250ecfe1e = getEntArray("escape_hallway_prisoner_door", "targetname");

  foreach(door in var_c05c2a7250ecfe1e) {
    door moveTo(getStruct(door.target, "targetname").origin, 0.2);
    door rotateTo(getStruct(door.target, "targetname").angles, 0.2);
  }

  array_spawn_function_targetname("escape_prisoner_hallway_door", &function_e17f6c379fefd1c9);
  var_de8497c564cd70ee = array_spawn_targetname("escape_prisoner_hallway_door", 1);
  flag_wait("flag_escape_cliff_start");
}

function function_d5b0ae5d9122efe9() {
  animnode = getStruct("escape_animnode_bridge", "targetname");
  actors = [level.makarov, level.ally1, level.ally2];
  level.var_aae0df21b6941d94 = 0;
  level.makarov thread function_524ccb207fb6e11f(animnode, "shot_010_enter_makarov", "shot_020_idle_makarov");
  level.ally1 thread function_524ccb207fb6e11f(animnode, "shot_010_enter_ivan", "shot_020_idle_ivan");
  level.ally2 thread function_524ccb207fb6e11f(animnode, "shot_010_enter_rook", "shot_020_idle_rook");
  level.makarov setavoidanceradius(15);
  level.ally1 setavoidanceradius(15);
  level.ally2 setavoidanceradius(15);
  covernodes = getnodearray("escape_tunnel_exit_node", "targetname");

  foreach(node in covernodes) {
    node disconnectnode();
    node thread function_8a1fec5d23641a01();
  }

  function_ced4924240a78b5c(actors);
  flag_wait("flag_escape_redirect_start");
  flag_set("flag_escape_redirect_scene_start");
  thread function_16b015dfd283334b();
  thread function_457735f0e5616d2f();
  add_scene_func(animnode, &function_b53cefc50d0ca133, "shot_030_ambush_heli");
  autosave_by_name("escape_redirect_scene_start");
  level.ally2.deathfunction = &function_ce450b9957138bd5;
  thread function_30d8b79a84842028(animnode);
  thread function_2f6fffb09bc347b7(animnode);
  animnode thread play(level.ally2, "shot_030_ambush_rook");
  animnode play(undefined, "shot_030_ambush_heli");
  animnode thread play(level.var_8906fd70bcda7978, "shot_110_heli_idle");
  flag_set("flag_escape_redirect_scene_end");
  thread namespace_165c742e346e899e::function_d217e2c3a16b8d79();
  thread function_c147212d47574031(animnode);
}

function function_30d8b79a84842028(animnode) {
  level.makarov aisettargetspeed(130);
  animnode play(level.makarov, "shot_030_ambush_makarov");
  level.makarov demeanor_override("combat");
  level.makarov pushplayer(1);
  level.player.script_pushable = 1;
  level.player.pushable = 1;
}

function function_2f6fffb09bc347b7(animnode) {
  level.ally1 aisettargetspeed(130);
  animnode play(level.ally1, "shot_030_ambush_ivan");
  level.ally1 demeanor_override("combat");
  level.ally1 pushplayer(1);
}

function function_ced4924240a78b5c(actors) {
  while(level.var_aae0df21b6941d94 < actors.size) {
    if(flag("flag_escape_redirect_start_fallback")) {
      break;
    }

    waitframe();
  }
}

function function_524ccb207fb6e11f(animnode, var_a6836f4573d91d71, var_289987055f545e7) {
  level endon("flag_escape_redirect_start_fallback");
  set_goal_radius(64);
  animnode play(self, var_a6836f4573d91d71);
  animnode thread play(self, var_289987055f545e7);
  level.var_aae0df21b6941d94 += 1;
}

function function_457735f0e5616d2f() {
  flag_wait("flag_redirect_fire_at_rook");
  wait 1;

  if(isDefined(level.ally2) && isalive(level.ally2)) {
    level.ally2 stop_magic_bullet_shield();
    level.ally2 kill();
  }
}

function function_16b015dfd283334b() {
  flag_wait_or_timeout("flag_escape_redirect_door_kick", 30);
  doorclip = getEnt("escape_redirect_door_clip", "targetname");
  doorclip notsolid();
  doorclip connectpaths();
  var_4de46646ae40efa6 = getStruct("escape_fake_door", "script_noteworthy");
  var_4de46646ae40efa6 function_ec55b3dd58f10e7b();
}

function function_b53cefc50d0ca133() {
  level.var_8906fd70bcda7978 = get_entity("heli");
  thread namespace_165c742e346e899e::function_d209a72b1029d79e();
  gunnertag = level.var_8906fd70bcda7978 gettagorigin("tag_gunner");
  var_6ee9204528846678 = spawn_script_origin(gunnertag);
  var_6ee9204528846678 makeentitysentient("axis");
  createthreatbiasgroup("escape_heli");
  var_6ee9204528846678 setthreatbiasgroup("escape_heli");
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_336d610219c2b94c();
  function_d6dd4f445b76833();
}

function function_8a1fec5d23641a01() {
  flag_wait("flag_escape_redirect_scene_end");
  self connectnode();
}

function function_99edf228ea40e7f9() {
  var_1961a97f83afc647 = getEnt("escape_tunnel_preanim_slowdown_vol", "targetname");

  while(!flag("flag_escape_redirect_start")) {
    if(level.player istouching(var_1961a97f83afc647)) {
      level.player player_speed_percent(85, 1);
    }

    waitframe();
  }

  level.player player_speed_default(0.1);
  distcheck = getStruct("escape_tunnel_end_distance_checker", "targetname");
  slowed = 0;
  bufferdist = 200;

  while(!flag("flag_redirect_stop_player_slow")) {
    playerdist = distance2d(level.player.origin, distcheck.origin);
    var_cc1e078865aba64c = distance2d(level.makarov.origin, distcheck.origin);

    if(playerdist <= var_cc1e078865aba64c + bufferdist && !slowed) {
      iprintln("<dev string:x5f>");

      slowed = 1;
      level.player player_speed_percent(80, 1);
      wait 1;
    } else if(playerdist >= var_cc1e078865aba64c + bufferdist && slowed) {
      iprintln("<dev string:x69>");

      slowed = 0;
      level.player player_speed_default(1);
      wait 1;
    }

    waitframe();
  }

  level.player player_speed_default(1);
}

function function_349dd5a0d09e63f6() {
  self endon("death");
  set_baseaccuracy(0);
  self setthreatbiasgroup("bridge_enemies");

  if(!isDefined(level.bridge_enemies)) {
    level.bridge_enemies = [];
  }

  level.bridge_enemies = array_add(level.bridge_enemies, self);
}

function function_dc5cceade7cf79a0() {
  spawner = getEnt("escape_bridge_enemies_reinforcements", "targetname");

  while(!flag("flag_escape_cliff_slide_start")) {
    if(level.bridge_enemies.size < 4) {
      guy = spawner spawn_ai();

      if(isDefined(guy)) {
        guy thread function_349dd5a0d09e63f6();
      }
    } else {
      level.bridge_enemies = array_removedead_or_dying(level.bridge_enemies);
    }

    waitframe();
  }
}

function function_e3920f40737f6544() {
  self endon("death");

  if(!isDefined(level.tunnel_prisoners)) {
    level.tunnel_prisoners = [];
  }

  level.tunnel_prisoners = array_add(level.tunnel_prisoners, self);
  set_fixednode_false();
  self aisetdesiredspeed(randomintrange(150, 220));
  flag_wait("flag_escape_tunnel_prisoners_push");
  goalvol = getEnt("escape_tunnel_prisoner_goal_vol", "targetname");

  if(isalive(self)) {
    self setgoalvolumeauto(goalvol);
  }

  self waittill("death");
  level.tunnel_prisoners = array_removedead_or_dying(level.tunnel_prisoners);
}

function function_8abc17e6bfa3e885() {
  self endon("death");
  set_fixednode_true();
  self aisetdesiredspeed(randomintrange(175, 250));
  self.name = "";
  utility::add_damage_function(&function_d799ec6e01836246);

  if(!isDefined(level.tunnel_prisoners)) {
    level.tunnel_prisoners = [];
  }

  level.tunnel_prisoners = array_add(level.tunnel_prisoners, self);
  flag_wait("flag_escape_redirect_scene_start");
  wait randomfloatrange(0.5, 1.5);
  set_fixednode_false();
  goalvol = getEnt("escape_bridge_prisoner_fallback_vol", "targetname");

  if(isalive(self)) {
    self setgoalvolumeauto(goalvol);
  }

  self waittill("death");
  level.tunnel_prisoners = array_removedead_or_dying(level.tunnel_prisoners);
}

function function_95a5d84985436474() {
  self endon("death");
  set_fixednode_true();
  self.name = "";
  utility::add_damage_function(&function_d799ec6e01836246);

  if(!isDefined(level.tunnel_prisoners)) {
    level.tunnel_prisoners = [];
  }

  level.tunnel_prisoners = array_add(level.tunnel_prisoners, self);

  if(isDefined(self.target)) {
    first_node = getnode(self.target, "targetname");

    if(isDefined(first_node)) {
      self setgoalnode(first_node);
      self setgoalpos(first_node.origin, 8);
      set_goal_radius(8);
    }
  }

  flag_wait("flag_redirect_heli_start_firing");
  var_fbd5fd3e964adbd6 = getEnt("escape_bridge_prisoner_charge_vol", "targetname");

  if(isalive(self)) {
    self setgoalvolumeauto(var_fbd5fd3e964adbd6);
  }

  wait 3;
  set_fixednode_false();
  goalvol = getEnt("escape_bridge_prisoner_fallback_vol", "targetname");

  if(isalive(self)) {
    self setgoalvolumeauto(goalvol);
  }
}

function function_da47f4c6d16d0ce9() {
  spawners = getEntArray("escape_tunnel_prisoner_reinforcement", "targetname");

  while(!flag("flag_escape_cliff_slide_start")) {
    if(level.tunnel_prisoners.size < 4 && !flag("flag_escape_dont_spawn_reinforcements")) {
      spawner = random(spawners);

      if(distance2d(spawner.origin, level.player.origin) > 800) {
        guy = spawner spawn_ai();

        if(isDefined(guy)) {
          guy thread function_10a90249ac1c7a93();
        }
      }
    } else {
      level.tunnel_prisoners = array_removedead_or_dying(level.tunnel_prisoners);
    }

    waitframe();
  }
}

function function_10a90249ac1c7a93() {
  goalvol = getEnt("escape_tunnel_prisoner_goal_vol", "targetname");
  var_22de0316970b7384 = getEnt("escape_bridge_prisoner_fallback_vol", "targetname");
  set_fixednode_false();
  self.name = "";
  utility::add_damage_function(&function_d799ec6e01836246);

  if(cointoss()) {
    self setgoalvolumeauto(goalvol);
  } else {
    self setgoalvolumeauto(var_22de0316970b7384);
  }

  if(!isDefined(level.tunnel_prisoners)) {
    level.tunnel_prisoners = [];
  }

  level.tunnel_prisoners = array_add(level.tunnel_prisoners, self);
  self waittill("death");
  level.tunnel_prisoners = array_removedead_or_dying(level.tunnel_prisoners);
}

function escape_tunnel_prisoner_reinforcement_survivor() {
  while(!flag("flag_escape_tunnel_player_through_door")) {
    guy = spawn_targetname("escape_tunnel_prisoner_reinforcement_survivor");

    if(isDefined(guy)) {
      guy thread function_fa19be66cd701700();
      guy waittill("death");
    }

    waitframe();
  }
}

function function_fa19be66cd701700() {
  self endon("death");
  utility::add_damage_function(&function_d799ec6e01836246);
  goalvol = getEnt("escape_cliff_volume", "targetname");
  set_fixednode_false();
  magic_bullet_shield();
  self setgoalvolumeauto(goalvol);
  self aisetdesiredspeed(randomintrange(150, 220));
  set_ignoreall(1);
  set_ignoreme(1);
  self.name = "";
  self waittill("goal");

  if(!flag("flag_escape_cliff_start")) {
    stop_magic_bullet_shield();

    if(!flag("flag_escape_cliff_start")) {
      self kill();
    }
  }
}

function function_ed76915d0744c9bf() {
  self waittill("damage");
  function_a1404ef1116dbe2c();
}

function function_4bb6172b05e183cb() {
  wait 0.1;
  level.makarov demeanor_override("sprint");
  level.ally1 demeanor_override("sprint");
  level.ally2 demeanor_override("sprint");
  level.makarov disable_pain();
  level.ally1 disable_pain();
  level.ally2 disable_pain();
  flag_wait("flag_escape_redirect_scene_start");
  level.makarov setgoalnode(getnode("escape_hallway_postdoor_makarov", "targetname"));
  level.ally1 setgoalnode(getnode("escape_hallway_postdoor_ivan", "targetname"));
  flag_wait("flag_escape_tunnel_player_through_door");
  level.makarov aiclearscriptdesiredspeed();
  level.ally1 aiclearscriptdesiredspeed();
  level.makarov setgoalnode(getnode("escape_interior_makarov_goal", "targetname"));
  wait 1;
  level.ally1 setgoalnode(getnode("escape_interior_ivan_goal", "targetname"));
}

function escape_vo() {
  flag_wait("flag_escape_redirect_scene_start");
  level.ally1 say("dx_sp_jvip_exfl_ivan_wereclearletsgo");
  wait 1;
  level.ally1 say("dx_sp_jvip_exfl_ivan_charliewerecomintoyo", 1);
  level.ally1 thread say_flag("dx_sp_jvip_exfl_ivan_gunrungetdown", "flag_vo_escape_redirect_ivan_react");
  level.makarov thread say_flag("dx_sp_jvip_exfl_maka_takecover", "flag_vo_escape_redirect_take_cover");
  thread escape_music();
  level.ally2 thread say_flag("dx_sp_jvip_exfl_koa3_painsounds", "flag_vo_escape_redirect_rook_death");
  level.ally1 thread say_flag("dx_sp_jvip_exfl_ivan_3isdown", "flag_vo_escape_redirect_rook_death_ivan_react");
  level.makarov thread say_flag("dx_sp_jvip_exfl_maka_thisway", "flag_vo_escape_redirect_makarov_leave");
  level.makarov thread say_flag("dx_sp_jvip_exfl_maka_leavehimivanletsgo", "flag_vo_escape_redirect_makarov_leave2");
  thread function_321bb640d1cd31c6();
  flag_wait("flag_escape_tunnel_player_through_door");
  wait 1;
  level.ally1 say("dx_sp_jvip_exfl_ivan_charliewassupposedto");
  level.makarov say("dx_sp_jvip_exfl_maka_ifwasaproblemyoushou", undefined, undefined, undefined, 0.5);
}

function function_321bb640d1cd31c6() {
  flag_wait("flag_escape_redirect_scene_end");
  nags = ["dx_sp_jvip_xfhn_maka_forgetthehelothisway", "dx_sp_jvip_xfhn_maka_nolanonme", "dx_sp_jvip_xfhn_maka_gettothecliffsonme"];
  level.makarov thread nag_loop(nags, 8, 6);
  flag_wait("flag_escape_tunnel_player_through_door");
  level.makarov notify("stop_nag_loop");
}

function function_c147212d47574031(var_9873f47b8845e148) {
  level endon("flag_slide_scene_start");
  var_a0ab114f6606bb1c = create_deck(["dx_sp_jvip_xfhn_ivan_saveyourbulletsthisw", "dx_sp_jvip_xfhn_ivan_nolanstopshootingand", "dx_sp_jvip_xfhn_ivan_stopshootingandgetou"]);
  var_be7b0522366db5ab = var_9873f47b8845e148 get_entity("heli");
  var_a88c0832498aba4a = 0.95;
  var_cabeadf01a0f03a4 = 0.5;

  while(true) {
    level.player waittill("weapon_fired");

    if(player_looking_at(var_be7b0522366db5ab.origin, var_a88c0832498aba4a, 1)) {
      nagline = var_a0ab114f6606bb1c deck_draw();
      level.ally1 say(nagline, 0, 3);
      wait var_cabeadf01a0f03a4;
    }
  }
}

function escape_music() {
  setmusicstate("mx_vip_escape_start");
}

function escape_fov() {}

function function_d6dd4f445b76833() {
  level endon("flag_slide_scene_start");
  gunnertag = level.var_8906fd70bcda7978 gettagorigin("tag_gunner");
  turret = spawnturret("misc_turret", gunnertag, "chopper_gunner_turret_vip_redirect");
  turret linkTo(level.var_8906fd70bcda7978, "tag_gunner");
  turret setModel("veh9_mil_air_heli_hind_turret");
  turret setmode("manual");
  turret setdefaultdroppitch(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret settoparc(5);
  turret setbottomarc(360);
  turret setconvergencetime(0.1, "yaw");
  turret setconvergencetime(0.1, "pitch");
  turret.convergencetime = 0.1;
  turret setturretteam("axis");
  turret.suppressiontime = 2;
  turret.accuracy = 1;
  var_c0a590ed14f737c6 = getEnt("escape_tunnel_heli_intro_target", "targetname");
  turret settargetentity(var_c0a590ed14f737c6);
  thread function_c01cdc3dedf079a9(turret);
  flag_wait("flag_redirect_heli_start_firing");
  turret function_3c3edc6ce3077fb();
  flag_set("flag_heli_turret_intro_complete");
  flag_set("flag_obj_escape_redirect");
  turret settargetentity(level.ally2);
  flag_wait("flag_redirect_fire_at_rook");
  turret function_5577154bb936813b(level.ally2, 0.5);
  thread function_2644bb5b4125fd70();
  childthread function_88cf25c470bf84ae();
  wait 2;
  flag_set("flag_escape_heli_animation_complete");
}

function function_c01cdc3dedf079a9(turret) {
  flag_wait_any("flag_escape_heli_animation_complete", "flag_escape_heli_turret_kill_player");
  thread function_a5e58b3a1f7d5d4f();
  var_d1bdf2a8800616b8 = 0;

  while(!flag("flag_slide_scene_start")) {
    var_65d96da2ddbb09c = 0;

    if(flag("flag_escape_heli_turret_kill_player")) {
      iprintln("<dev string:x72>");

      var_d1bdf2a8800616b8 = 0;
      var_65d96da2ddbb09c = 1;
      turret function_5577154bb936813b(level.player, 4);
    }

    if(flag("flag_escape_player_aiming_at_heli")) {
      iprintln("<dev string:x83>");

      turret function_5577154bb936813b(level.var_95c7292cee61361d, 3);
      var_d1bdf2a8800616b8 = 0;
      var_65d96da2ddbb09c = 1;
    } else if(var_d1bdf2a8800616b8 >= 2 && flag("flag_escape_player_tunnel_or_bridge")) {
      iprintln("<dev string:x97>");

      turret function_5577154bb936813b(level.var_95c7292cee61361d, 2);
      var_d1bdf2a8800616b8 = 0;
      var_65d96da2ddbb09c = 1;
    } else if(flag("flag_escape_tunnel_safe_from_heli") || !flag("flag_escape_player_tunnel_or_bridge")) {
      iprintln("<dev string:xa4>");

      var_d1bdf2a8800616b8++;
      function_3c1463bdcf27b7ff(turret);
    } else if(!flag("flag_escape_heli_grace_period_ended") && !flag("flag_escape_heli_turret_kill_player")) {
      iprintln("<dev string:xa4>");

      var_d1bdf2a8800616b8++;
      function_3c1463bdcf27b7ff(turret);
    } else {
      iprintln("<dev string:xb3>");

      var_d1bdf2a8800616b8 = 0;
      var_65d96da2ddbb09c = 1;
      turret function_5577154bb936813b(level.player, 2.5);
    }

    if(flag("flag_escape_heli_turret_kill_player")) {
      wait 0.25;
      continue;
    }

    if(var_65d96da2ddbb09c) {
      wait 1;
      continue;
    }

    wait randomfloatrange(1, 2);
  }
}

function function_3c1463bdcf27b7ff(turret) {
  level.tunnel_prisoners = array_removedead_or_dying(level.tunnel_prisoners);
  testpoint = getStruct("escape_heli_distance_tester", "targetname");

  if(isDefined(level.tunnel_prisoners) && level.tunnel_prisoners.size > 0) {
    nearbyai = getaiarrayinradius(testpoint.origin, testpoint.radius, "allies");
    var_9b8833a6fecf72db = [];

    foreach(ai in nearbyai) {
      if(array_contains(level.tunnel_prisoners, ai)) {
        var_9b8833a6fecf72db = array_add(var_9b8833a6fecf72db, ai);
      }
    }

    if(var_9b8833a6fecf72db.size > 0) {
      guy = random(var_9b8833a6fecf72db);
    } else {
      guy = random(level.tunnel_prisoners);
    }

    turret function_5577154bb936813b(guy, randomfloatrange(1, 2));
  }
}

function function_2644bb5b4125fd70() {
  gracetime = 12;
  wait gracetime;
  flag_set("flag_escape_heli_grace_period_ended");
}

function function_3c3edc6ce3077fb() {
  level endon("flag_escape_heli_turret_kill_player");
  exploder("fx_heli_mist");
  movetime = 4;
  helitarget = getEnt("escape_tunnel_heli_intro_target", "targetname");
  childthread function_5577154bb936813b(helitarget, movetime);
  function_6da3a9e4824fd42e(helitarget);
}

function function_6da3a9e4824fd42e(helitarget) {
  helitarget thread function_c437360044abb235();
  nexttarget = getStruct(helitarget.target, "targetname");

  while(true) {
    movetime = nexttarget.script_noteworthy;
    movetime = int(movetime);

    if(!isDefined(movetime) || movetime <= 0) {
      movetime = 0.5;
    }

    helitarget moveTo(nexttarget.origin, movetime);
    wait movetime;

    if(isDefined(nexttarget.target)) {
      nexttarget = getStruct(nexttarget.target, "targetname");
    } else {
      nexttarget = undefined;
    }

    if(!isDefined(nexttarget)) {
      break;
    }
  }
}

function function_c437360044abb235() {
  level endon("flag_heli_turret_intro_complete");

  while(true) {
    nearbyai = getaiarrayinradius(self.origin, 64);

    if(isDefined(nearbyai) && nearbyai.size > 0) {
      foreach(guy in nearbyai) {
        guy function_a1404ef1116dbe2c();
      }
    }

    waitframe();
  }
}

function function_5577154bb936813b(shoottarget, shoottime) {
  firetime = weaponfiretime("chopper_gunner_turret_vip_redirect");
  firedtime = 0;

  while(firedtime < shoottime) {
    if(!isDefined(shoottarget)) {
      iprintln("<dev string:xc2>");

      break;
    }

    if(!isPlayer(shoottarget) && flag("flag_escape_heli_turret_kill_player")) {
      iprintln("<dev string:xd9>");

      break;
    }

    self settargetentity(shoottarget);
    self shootturret("tag_flash");
    wait firetime;
    firedtime += firetime;
  }
}

function function_a5e58b3a1f7d5d4f() {
  level endon("flag_slide_scene_start");
  testpoint = getStruct("escape_heli_sight_tester", "targetname");

  while(true) {
    if(level.player isads() && level.player can_see_origin(testpoint.origin)) {
      flag_set("flag_escape_player_aiming_at_heli");
    } else {
      flag_clear("flag_escape_player_aiming_at_heli");
    }

    waitframe();
  }
}

function function_88cf25c470bf84ae() {
  level.var_95c7292cee61361d = level.player spawn_script_origin();
  maxx = 32;
  maxy = 32;
  maxz = 64;

  while(true) {
    x = randomfloatrange(maxx * -1, maxx);
    y = randomfloatrange(maxy * -1, maxy);
    z = randomfloatrange(0, maxz);
    level.var_95c7292cee61361d.origin = level.player.origin + (x, y, z);
    wait 0.5;
  }
}

function escape_catchup() {
  flag_set("flag_escape_tunnel_enter");
  flag_set("flag_escape_hallway_prisoner_door_breach");
  flag_set("flag_escape_cliff_start");
  clearmusicstate();
  setmusicstate("mx_vip_escape_start");
}

function function_79d65a4485ecae36() {}

function cliff_start() {
  level.player modifybasefov(65, 2, 0.5, 0.5);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_e3b94169b8a44a68();
  thread function_e39d8a96b86719ce(1);
  thread namespace_165c742e346e899e::function_c3a4d38367470b67();
  spawn_allies();
  function_dc2aa213aa5830aa(getStruct("cliff_makarov_start", "targetname"));
  set_start_location("cliff_start", [level.player, level.ally1]);
  level.makarov disable_pain();
  level.ally1 disable_pain();
  thread function_a533d8921f706b7e();
  level thread function_c6aecb595687f644();
}

function cliff_main() {
  autosave_by_name("escape_cliff_start");
  createthreatbiasgroup("player_group");
  createthreatbiasgroup("cliff_prisoners");

  if(!threatbiasgroupexists("bridge_enemies")) {
    createthreatbiasgroup("bridge_enemies");
    createthreatbiasgroup("cliff_prisoners");
  }

  createthreatbiasgroup("wall_enemies");
  createthreatbiasgroup("cliff_enemies");
  level.player setthreatbiasgroup("player_group");
  setignoremegroup("player_group", "wall_enemies");
  setignoremegroup("bridge_enemies", "cliff_prisoners");
  setignoremegroup("wall_enemies", "cliff_prisoners");
  level.ally1 set_ignoreall(1);
  level.makarov set_ignoreall(1);
  thread cliff_vo();
  thread cliff_tower_turret();
  var_f9b0bcfd9be7361 = getEntArray("escape_cliff_rpg_trigger", "targetname");

  foreach(trigger in var_f9b0bcfd9be7361) {
    trigger thread cliff_rpg_trigger();
  }

  level.player set_attackeraccuracy(0.1);
  level.var_bde3a1f0e4f5cc7e = [];
  array_spawn_function_targetname("escape_cliff_guard", &function_5893d1c525be9378);
  array_spawn_function_targetname("escape_cliff_wall_guard", &function_1f40cea13145165b);
  array_spawn_function_targetname("escape_cliff_prisoner", &function_e17f6c379fefd1c9);
  array_spawn_targetname("escape_cliff_guard", 1, undefined, undefined, 1);
  array_spawn_targetname("escape_cliff_wall_guard", 1, undefined, undefined, 1);
  array_spawn_targetname("escape_cliff_prisoner", 1, undefined, undefined, 1);
  thread cliff_guard_reinforcements();
  thread function_853cf9a6a7e693fc();
  thread function_b204c8407a997bd4();
  var_cef5ef06535e4aaa = getStruct("escape_cliff_boat", "targetname");
  var_c675d14504981150 = spawn("script_model", var_cef5ef06535e4aaa.origin);
  var_c675d14504981150.angles = var_cef5ef06535e4aaa.angles;
  var_c675d14504981150 setModel("veh_jup_mill_boat_armored_turret_patrol");
  var_c675d14504981150 thread function_a16d2bb79b01aae5(var_cef5ef06535e4aaa);
  var_c675d14504981150 thread function_4ad0846747ee1818();
  var_426e11897305b820 = getStruct("escape_cliff_boat_turret", "targetname");
  var_f453eb48219c41ea = spawn("script_model", var_426e11897305b820.origin);
  var_f453eb48219c41ea.angles = var_426e11897305b820.angles;
  var_f453eb48219c41ea setModel("veh_jup_mill_boat_armored_turret_patrol");
  var_f453eb48219c41ea thread function_a16d2bb79b01aae5(var_426e11897305b820);
  var_f453eb48219c41ea thread function_4ad0846747ee1818();
}

function function_b204c8407a997bd4() {
  wait 1;
  flag_wait("flag_escape_cliff_start");
  level.makarov thread function_a2d8d6ae723f7562();
  level.ally1 thread function_b5d7c484a2d2602d();
}

function function_b5d7c484a2d2602d() {
  level endon("cine_exfil_start");
  set_ignoreall(1);
  set_goalRadius(64);
  demeanor_override("sprint");
  animnode = getStruct("scene_vip_exfil_leapoffaith", "targetname");
  animnode play(self, "shot_010_enter");
  thread function_54c4099fc7efa840();
  i = 3;

  while(!flag("flag_escape_cliff_slide_start")) {
    shot = "shot_0" + i + "0_nag";
    animnode notify("stop_loop");
    animnode play(self, shot);
    animnode thread play(self, "shot_020_ivan_Idle");
    wait 3;
    i++;

    if(i == 6) {
      break;
    }
  }

  animnode thread play(self, "shot_020_ivan_Idle");
  flag_wait("flag_slide_scene_start");
}

function function_a2d8d6ae723f7562() {
  set_ignoreall(1);
  demeanor_override("sprint");
  disable_bulletwhizbyreaction();
  set_force_color("r");
  activate_trigger_with_targetname("makarov_cliff_run");

  while(!flag("flag_makarov_start_slide")) {
    waitframe();
  }

  slide_makarov();
}

function cliff_vo() {
  flag_wait("flag_escape_cliff_start");
  wait 1;
  level.makarov say("dx_sp_jvip_exfl_maka_followthecliffsideto");
  wait 1;
  level.ally1 say("dx_sp_jvip_exfl_ivan_shootersonthewalls");
  wait 0.5;
  level.ally1 say("dx_sp_jvip_exfl_maka_ignorethemgettothebo");
}

function function_54c4099fc7efa840() {
  flag_wait("flag_makarov_slide_anim_started");
  wait 4;

  while(!flag("flag_slide_scene_start")) {
    level.ally1 say("dx_sp_jvip_exfl_ivan_getmovingnolan", 0, 3);
    wait randomfloatrange(4, 6);
  }
}

function function_a16d2bb79b01aae5(marker) {
  goal = getStruct(marker.target, "targetname");
  self moveTo(goal.origin, 8);
  self rotateTo(goal.angles, 8);
  playFXOnTag(getfx("vfx_vip_boat_wake_01"), self, "tag_prop");
  animnode = getStruct("scene_vip_exfil_leapoffaith", "targetname");

  if(marker.targetname == "escape_cliff_boat") {
    wait 6.5;
    self notify("destination_reached");
    animnode thread play(self, "shot_020_idle");
  } else {
    wait 5;
    self notify("destination_reached");
    animnode thread play(self, "shot_03_idle");
  }

  flag_wait("cine_exfil_start");

  if(isDefined(self)) {
    self delete();
  }
}

function function_4ad0846747ee1818() {
  level endon("cine_exfil_start");
}

function cliff_tower_turret() {
  level endon("flag_escape_cliff_slide_start");
  flag_wait("flag_escape_cliff_turret_kill_timer");
  var_ac1480e7437181f8 = 12;
  killtimer = 24;
  thread flag_set_delayed("flag_escape_cliff_turret_kill_timer_one", var_ac1480e7437181f8);
  thread flag_set_delayed("flag_escape_cliff_turret_kill_timer_two", killtimer);
  thread function_72de19704d67734b();

  while(isalive(level.player)) {
    function_9f66966181d7211f();
    wait randomfloatrange(1, 3);
  }
}

function function_9f66966181d7211f() {
  var_2aec1ad1f4f186dd = getStruct("escape_cliff_tower_turret", "targetname");
  var_d73ab2f9869f0465 = "jup_jp06_lm_pkilop_sp";
  firerate = weaponfiretime(var_d73ab2f9869f0465);
  var_327623b3889344c5 = randomfloatrange(3, 5);

  for(var_2f002f090ba2acc8 = 0; var_2f002f090ba2acc8 < var_327623b3889344c5; var_2f002f090ba2acc8 = var_2f002f090ba2acc8 + firerate + bursttime) {
    if(flag("flag_escape_cliff_turret_kill_timer_two") && !flag("flag_escape_cliff_player_progressing")) {
      offset = (randomfloatrange(-4, 4), randomfloatrange(-4, 4), randomfloatrange(0, 100));
    } else if(flag("flag_escape_cliff_turret_kill_timer_one") && !flag("flag_escape_cliff_player_progressing")) {
      offset = (randomfloatrange(-15, 15), randomfloatrange(-15, 15), randomfloatrange(48, 140));
    } else {
      offset = (randomfloatrange(-64, 64), randomfloatrange(-64, 64), randomfloatrange(128, 196));
    }

    magicbullet(var_d73ab2f9869f0465, var_2aec1ad1f4f186dd.origin, level.player.origin + offset);
    bullettracer(var_2aec1ad1f4f186dd.origin, level.player.origin + offset, var_d73ab2f9869f0465);
    wait firerate;
    rand = randomintrange(0, 6);
    bursttime = 0;

    if(rand == 0) {
      bursttime = randomfloatrange(0.6, 1.2);
      wait bursttime;
    }
  }
}

function function_72de19704d67734b() {
  var_5788ecdd3c4e245c = getStruct("cliff_distance_checker", "targetname");
  prevdist = distance2d(level.player.origin, var_5788ecdd3c4e245c.origin);
  curdist = undefined;
  var_751d210178b9f8d5 = 50;
  warning = 0;
  var_3461854e4644a26e = 2;

  while(true) {
    curdist = distance2d(level.player.origin, var_5788ecdd3c4e245c.origin);
    progress = prevdist - curdist;

    if(progress >= var_751d210178b9f8d5) {
      warning = 0;
      flag_set("flag_escape_cliff_player_progressing");
    } else if(warning < var_3461854e4644a26e) {
      warning++;
    } else {
      flag_clear("flag_escape_cliff_player_progressing");
    }

    prevdist = curdist;
    wait 0.5;
  }
}

function cliff_rpg_trigger() {
  var_481cd098638ae908 = getStruct(self.target, "targetname");

  if(!isDefined(var_481cd098638ae908)) {
    return;
  }

  var_9c907e07a6045299 = getStruct(var_481cd098638ae908.target, "targetname");

  if(!isDefined(var_9c907e07a6045299)) {
    return;
  }

  self waittill("trigger");
  rpg = magicbullet("iw9_la_rpapa7_sp_vip", var_481cd098638ae908.origin, var_9c907e07a6045299.origin);

  switch (self.script_noteworthy) {
    case #"hash_c9bd2b55a7d2026c":
      thread namespace_165c742e346e899e::function_1ac4ea5acb931a6c(rpg, var_481cd098638ae908, var_9c907e07a6045299);
      break;
    case #"hash_c9bd2e55a7d20725":
      thread namespace_165c742e346e899e::function_1ac4ed5acb932105(rpg, var_481cd098638ae908, var_9c907e07a6045299);
      break;
    case #"hash_c9bd2d55a7d20592":
      thread namespace_165c742e346e899e::function_1ac4ec5acb931ed2(rpg, var_481cd098638ae908, var_9c907e07a6045299);
      break;
  }
}

function function_e17f6c379fefd1c9() {
  if(!isDefined(level.var_bde3a1f0e4f5cc7e)) {
    level.var_bde3a1f0e4f5cc7e = [];
  }

  level.var_bde3a1f0e4f5cc7e = array_add(level.var_bde3a1f0e4f5cc7e, self);

  if(!threatbiasgroupexists("cliff_prisoners_wall")) {
    createthreatbiasgroup("cliff_prisoners_wall");
  }

  if(is_equal(self.script_noteworthy, "shoot_at_wall")) {
    self setthreatbiasgroup("cliff_prisoners_wall");
  } else {
    self setthreatbiasgroup("cliff_prisoners");
  }

  set_baseaccuracy(0);
  set_ignoreall(1);
  self.name = "";
  utility::add_damage_function(&function_d799ec6e01836246);
  self waittill("goal");
  set_ignoreall(0);
}

function function_853cf9a6a7e693fc() {
  level endon("flag_slide_scene_start");
  var_6444e186a0df63ae = create_deck(["dx_sp_jvip_clpr_pri1_tearemapart", "dx_sp_jvip_clpr_pri2_die", "dx_sp_jvip_clpr_pri1_dontletup"]);

  while(level.var_bde3a1f0e4f5cc7e.size > 0) {
    wait randomintrange(4, 6);
    guy = random(level.var_bde3a1f0e4f5cc7e);

    if(isalive(guy)) {
      guyline = var_6444e186a0df63ae deck_draw();
      guy say(guyline, 1, 3, 1);
    }
  }
}

function function_5893d1c525be9378() {
  self setthreatbiasgroup("cliff_enemies");
  set_baseaccuracy(0.15);
  set_grenadeammo(0);

  if(!isDefined(level.var_87c18798652e1114)) {
    level.var_87c18798652e1114 = [];
  }

  level.var_87c18798652e1114 = array_add(level.var_87c18798652e1114, self);
}

function function_1f40cea13145165b() {
  self setthreatbiasgroup("wall_enemies");
  set_baseaccuracy(0.15);
  set_grenadeammo(0);
}

function cliff_guard_reinforcements() {
  spawner = getEnt("escape_cliff_guard_reinforcements", "targetname");

  while(!flag("flag_escape_cliff_slide_start")) {
    if(level.var_87c18798652e1114.size < 4) {
      guy = spawner spawn_ai();

      if(isDefined(guy)) {
        guy thread function_5893d1c525be9378();
      }
    } else {
      level.var_87c18798652e1114 = array_removedead_or_dying(level.var_87c18798652e1114);
    }

    waitframe();
  }
}

function function_45ec82c0014d1b4c() {
  clearmusicstate();
}

function function_f0659cfeba99fb57() {}

function slide_start() {
  level.player modifybasefov(65, 2, 0.5, 0.5);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::cp_outro();
  thread function_e39d8a96b86719ce(1);
  spawn_allies();
  function_dc2aa213aa5830aa(getStruct("slide_makarov_start", "targetname"));
  level.makarov thread slide_makarov();
  set_start_location("slide_start", [level.player, level.ally1]);
  level thread function_c6aecb595687f644();
}

function slide_main() {
  thread function_5ab4acc285971d37();
  flag_wait("flag_escape_cliff_slide_start");
  thread function_87451c0371a2fc32();
  autosave_by_name("escape_slide_start");
  flag_set("flag_obj_escape_makarov_complete");
  function_481f7731d7675c0a();
  nextmission();
}

function function_5ab4acc285971d37() {
  vol = getEnt("escape_cliff_noslidecrouch_vol", "targetname");

  while(!flag("flag_escape_cliff_slide_start")) {
    if(level.player istouching(vol)) {
      level.player val::set("gulag_slide", "crouch", 0);
      level.player val::set("gulag_slide", "prone", 0);
      level.player val::set("gulag_slide", "slide", 0);
    } else {
      level.player val::set("gulag_slide", "crouch", 1);
      level.player val::set("gulag_slide", "prone", 1);
      level.player val::set("gulag_slide", "slide", 1);
    }

    waitframe();
  }

  level.player val::set("gulag_slide", "crouch", 0);
  level.player val::set("gulag_slide", "prone", 0);
  level.player val::set("gulag_slide", "slide", 0);
}

function function_87451c0371a2fc32() {
  setmusicstate("mx_vip_exfil_end");
}

function slide_makarov() {
  animnode = utility::getStruct("scene_vip_exfil_leapoffaith", "targetname");
  animnode thread scene::play(self, "shot_060_makslide");
  flag_set("flag_makarov_slide_anim_started");
}

function function_481f7731d7675c0a() {
  animnode = getStruct("scene_vip_exfil_leapoffaith", "targetname");
  actors = [level.player, level.ally1];
  flag_set("flag_slide_scene_start");
  thread namespace_165c742e346e899e::function_7ce163e72544d19();
  shot = "shot_070_slide";

  if(flag("flag_escape_cliff_slide_start_middle")) {
    shot = "shot_070_slide";
  } else if(flag("flag_escape_cliff_slide_start_left")) {
    shot = "shot_080_slide_left";
  } else if(flag("flag_escape_cliff_slide_start_right")) {
    shot = "shot_090_slide_right";
  }

  level.makarov clearimpactmarks();
  level.ally1 clearimpactmarks();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  animnode play(actors, shot);
  animnode = utility::getStruct("scene_vip_exfil_on_boat", "targetname");

  if(!isDefined(level.makarov)) {
    iprintln("<dev string:xfd>");

    thread namespace_9c3faffc064160e8::function_dc2aa213aa5830aa(utility::getStruct("slide_makarov_start", "targetname"));
  }

  if(!isDefined(level.ally1)) {
    iprintln("<dev string:x12e>");

    thread namespace_9c3faffc064160e8::spawn_allies();
  }

  actors = [level.makarov, level.ally1];
  level.ally1 stopanimScripted();
  level.player player::focusdisable();
  function_1ae8f046dee579e0(1);
  flag_set("cine_exfil_start");
  flag_set("flag_exfil_scene_start");
  thread namespace_165c742e346e899e::function_8b730ff032f5bad8();
  thread function_70ff8de38de28ad1();
  animnode thread function_a1024a86b35b575f();
  add_scene_func("scene_vip_2000_exfil_on_boat", &function_77a57ce86226479d, "shot_010");
  animnode scene::play(actors, "shot_010");

  if(flag("userskipped")) {
    flag_wait("flag_exfil_scene_complete_skip");
  }

  flag_set("flag_exfil_scene_complete");
}

function function_77a57ce86226479d() {
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_cf989893662dbcd2(self);
}

function function_a1024a86b35b575f() {
  level.player waittill("vip_outro_skippable");
  userskipped = userskip_wait();

  if(!userskipped) {
    return;
  }

  scripts\sp\hud_util::fade_out(0.5, "black");
  scene::stop();
  scene::cleanup();
  flag_set("flag_exfil_scene_complete");
  flag_set("flag_exfil_scene_complete_skip");
}

function function_70ff8de38de28ad1() {
  flag_wait("level_end_fade");
  thread namespace_165c742e346e899e::function_7d0d86b34c77f571();
  hud_util::fade_out(0);
}

function slide_catchup() {}