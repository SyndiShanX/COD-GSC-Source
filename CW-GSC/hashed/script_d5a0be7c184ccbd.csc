/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_d5a0be7c184ccbd.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_b61bbd82;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::function_5e69f468(&_objective);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  var_d4b173d0 = undefined;

  while(!isDefined(var_d4b173d0)) {
    var_d4b173d0 = getent(0, "audio_cricket_trigger", "targetname");
    waitframe(1);
  }

  var_d4b173d0 thread function_91836779(level.player);
  function_befba10a();
  thread function_bb691cfa();
  thread function_f958a41b();
  thread function_f40c094d();
  thread function_b7ef60a2();
  thread function_4a83b171();
  thread function_bd18b7b8();
  thread function_1172e136();
  thread function_5a97f38f();
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "evt_audio_vig_forest_flyby":
      vh_heli = ent;
      thread function_a5ecad0d(ent);
      ent waittill(#"death");
      vh_heli = undefined;
      break;
    case # "audio_perimeter_apc_driveby":
      vh_perimeter_vig_apc_driveby = ent;
      thread function_30189650(ent);
      ent waittill(#"death");
      vh_perimeter_vig_apc_driveby = undefined;
      break;
    case # "audio_perimeter_apc_threat":
      vh_perimeter_vig_apc_threat = ent;
      thread function_7258f7f4(ent);
      ent waittill(#"death");
      vh_perimeter_vig_apc_threat = undefined;
      break;
    case # "audio_side_door_apc_go":
      var_127d9a14 = ent;
      thread audio_side_door_apc_go(ent);
      ent waittill(#"death");
      level notify(#"hash_74a73f5954822211");
      var_f712b673 = undefined;
      break;
    case # "audio_side_door_apc_stop":
      var_127d9a14 = ent;
      thread audio_side_door_apc_stop(ent);
      ent waittill(#"death");
      level notify(#"hash_74a73f5954822211");
      var_f712b673 = undefined;
      break;
    case # "evt_audio_main_street_truck_drive_up":
      var_4e65d853 = ent;
      thread function_db555295(ent);
      ent waittill(#"death");
      var_4e65d853 = undefined;
      break;
    case # "evt_tower_elevator_audio":
      var_d5535d9a = ent;
      thread function_845469bf(ent);
      ent waittill(#"death");
      var_d5535d9a = undefined;
      break;
    case # "evt_tower_elevator_up_audio":
      var_d5535d9a = ent;
      thread function_1a0fd7ea(ent);
      ent waittill(#"death");
      var_d5535d9a = undefined;
      break;
    case # "evt_ai_open_terminal_door_audio":
      e_terminal_entrance_door_org = ent;
      thread evt_ai_open_terminal_door_audio(ent);
      ent waittill(#"death");
      e_terminal_entrance_door_org = undefined;
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69(name, "<dev string:x5d>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case # "$default":
      snd::set_element(trigger, trigger_name);
      break;
    case # "hash_f14cb3bf30d26a3":
      thread function_bda0d0f7();
      break;
    case # "hash_2ef3e4f4d4afaed3":
      level flag::set("exterior_sounds_cleanup");
      break;
    case # "facility_tunnels":
      snd::set_element(trigger, trigger_name);
      break;
    case # "tunnels_side_room":
      snd::set_element(trigger, trigger_name);
      break;
    case # "hallway_to_arcade":
      snd::set_element(trigger, trigger_name);
      break;
    case # "arcade":
      snd::set_element(trigger, trigger_name);
      thread function_329bafc9();
      break;
    case # "video_store":
      level notify(#"hash_cead01409a49817");
      level notify(#"hash_c67feccc2a013c6");
      break;
    case # "hash_42a59392492195ac":
      snd::set_element(trigger, trigger_name);
      thread function_8656b058();
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "audio_level_begin_duck_start":
      thread function_563a791();
      break;
    case # "audio_level_begin_duck_stop":
      thread function_1cfbed4a();
      break;
    case # "flg_audio_perimeter_heli_spawned":
      level notify(#"perimeter_heli_spawned");
      break;
    case # "audio_perimeter_apc_stop":
      level notify(#"hash_77ea555910abea0f");
      break;
    case # "audio_watch_your_head":
      thread function_75f2707c();
      break;
    case # "audio_tunnels_alarm":
      thread function_545dfe3b();
      break;
    case # "flg_audio_tunnel_generator_off":
      level notify(#"hash_7881749038062387");
      break;
    case # "audio_muffled_arcade_music":
      thread function_c0af2104();
      break;
    case # "flg_arcade_audio_emitters_start":
      thread function_7547ed65();
      break;
    case # "flg_arcade_emulator_start":
      thread function_b18c414e();
      break;
    case # "flg_arcade_emulator_stop":
      level notify(#"flg_arcade_emulator_stop");
      break;
    case # "flg_heli_rappel_alarm":
      thread evt_heli_rappel_alarm();
      break;
    case # "audio_main_street_music_started":
      level notify(#"audio_main_street_music_started");
      break;
    case # "flg_audio_truck_engine_idle_stop":
      level notify(#"flg_audio_truck_engine_idle_stop");
      break;
    case # "flg_main_street_elevator_reached_ground":
      level notify(#"flg_main_street_elevator_reached_ground");
      break;
    case # "flg_control_tower_elevator_at_top":
      level notify(#"flg_control_tower_elevator_at_top");
      break;
    case # "flg_audio_servers_spool_up":
      thread function_8f849679();
      break;
    case # "flg_audio_servers_stop":
      level notify(#"hash_3abf20f78c8facb5");
      break;
    case # "audio_start_terminal_computer_duck":
      thread function_dc569745();
      break;
    case # "audio_stop_terminal_computer_duck":
      function_ed62c9c2("cp_rus_amerika_terminal_computer_duck", 0.3);
      break;
    case # "flg_audio_terminal_alarm_start":
      thread function_b676524d();
      thread function_747d0cf3();
      break;
    case # "audio_stop_terminal_alarms":
      level flag::set("flg_audio_stop_terminal_alarms");
      break;
    case # "audio_motor_pool_rollup_door":
      thread function_c8cd1f84();
      break;
    case # "audio_motorpool_alarms":
      level notify(#"hash_4867a529b7eb5c2d");
      break;
    case # "flg_audio_motorpool_huge_door_close":
      thread function_5a5419bb();
      break;
    case # "flg_audio_apc_ride_town_square_start":
      thread function_85f15df8();
      break;
    case # "flg_audio_apc_ride_mall_transition_start":
      thread function_4c2bbef4();
      break;
    case # "outro_movie":
      level notify(#"hash_6163ece11287ae21");
      function_ed62c9c2("cp_rus_amerika_apc_ride_scene", 1);
      audio::snd_set_snapshot("cmn_duck_all_but_movie");
      break;
    case # "sfx_explode_reaction":
      thread function_9bb82dae();
      break;
    case # "flg_cricket_stop":
      level flag::set("flg_cricket_stop");
      break;
    case # "musictrack_cp_amerika_1":
    case # "musictrack_cp_amerika_3":
    case # "musictrack_cp_amerika_2":
    case # "musictrack_cp_amerika_5":
    case # "musictrack_cp_amerika_4":
      function_2cca7b47(0, msg);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  switch (objective) {
    case # "forest":
      thread function_7ecccb98();
      break;
    case # "perimeter":
      thread function_bda0d0f7();
      thread function_7ecccb98();
      break;
    case # "helipad":
      thread function_bda0d0f7();
      thread function_7ecccb98();
      break;
    case # "side_door":
      thread function_bda0d0f7();
      break;
    case # "lockpick":
      break;
    case # "tunnels":
      thread function_4190b630();
      thread function_ace83e8e();
      break;
    case # "arcade":
      thread function_4190b630();
      thread function_ace83e8e();
      break;
    case # "video_store":
      break;
    case # "main_street":
      thread function_55f97b00();
      break;
    case # "elevator_fight":
      thread function_55f97b00();
      break;
    case # "elevator":
      break;
    case # "terminal":
      level flag::set("elevator_generators_off");
      break;
    case # "Observation":
      level flag::set("elevator_generators_off");
      thread function_b676524d();
      thread function_747d0cf3();
      break;
    case # "Facades":
      level flag::set("elevator_generators_off");
      break;
    case # "Rooftops":
      level flag::set("elevator_generators_off");
      break;
    case # "storage":
      level flag::set("elevator_generators_off");
      break;
    case # "motor_pool":
      break;
    case # "apc_turret":
      break;
    case # "apc_townsquare":
      break;
    case # "apc_mall":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>");

      break;
  }
}

function function_91836779(player) {
  trigger = self;

  while(true) {
    waitresult = trigger waittill(#"trigger");
    trigger_player = waitresult.activator;

    if(trigger_player == player) {
      level thread function_7a945b02();
      level thread function_123c2ccb();
      level thread function_8ce67015();
      break;
    }
  }
}

function private function_e098a17a(alias, v_position, var_7423a2af, var_ed8c72a9) {
  level.player endon(#"death");
  assert(isarray(var_7423a2af));
  assert(isarray(var_ed8c72a9));

  while(true) {
    var_3b71b6c3 = array::random(var_7423a2af);

    for(i = 0; i < var_3b71b6c3; i++) {
      var_c576baf0 = snd::play(alias, v_position);
      snd::function_2fdc4fb(var_c576baf0);
      wait randomfloatrange(0, 0.7);
    }

    wait randomfloatrange(var_ed8c72a9[0], var_ed8c72a9[1]);

    if(level flag::get("flg_cricket_stop") == 1) {
      break;
    }
  }
}

function function_37294a47(var_47544845) {
  self endon(#"death");

  while(true) {
    var_2564fee0 = var_47544845.origin + anglestoright(var_47544845.angles) * 12;
    var_2564fee0 += anglestoup(var_47544845.angles) * 10;
    self.origin = var_2564fee0;

    if(var_47544845.health <= 0) {
      self delete();
    }

    waitframe(5);
  }
}

function function_befba10a() {
  plr = undefined;
  var_58602358 = [];
  snd::element_init("$default", var_58602358);
  facility_tunnels = [["elm_metal_deep_stress", plr, [6, 10], [200, 300]], ["elm_metal_knock_light", plr, [3, 12], [200, 300]], ["elm_metal_dist_knock", plr, [12, 16], [200, 300]], ["elm_mtl_stress_creak", plr, [3, 9], [200, 300]]];
  snd::element_init("facility_tunnels", facility_tunnels);
  tunnels_side_room = [["elm_metal_deep_stress", plr, [6, 10], [200, 300]], ["elm_metal_knock_light", plr, [3, 12], [200, 300]], ["elm_metal_dist_knock", plr, [12, 16], [200, 300]], ["elm_mtl_stress_creak", plr, [3, 9], [200, 300]]];
  snd::element_init("tunnels_side_room", tunnels_side_room);
  hallway_to_arcade = [["elm_metal_deep_stress", plr, [6, 10], [200, 300]], ["elm_metal_knock_light", plr, [3, 12], [200, 300]], ["elm_metal_dist_knock", plr, [12, 16], [200, 300]], ["elm_mtl_stress_creak", plr, [3, 9], [200, 300]]];
  snd::element_init("hallway_to_arcade", hallway_to_arcade);
  arcade = [];
  snd::element_init("arcade", arcade);
}

function function_563a791() {
  function_5ea2c6e3("cp_rus_amerika_level_begin");
}

function function_1cfbed4a() {
  function_ed62c9c2("cp_rus_amerika_level_begin");
}

function function_7ecccb98() {
  if(level flag::get("flg_audio_distant_thunder_playing") == 1) {
    return;
  }

  var_7ecccb98 = snd::emitter("emt_amerika_distant_thunder", [(-1340, 1663, 1259)], [25, 40]);

  if(isDefined(var_7ecccb98)) {
    level flag::set("flg_audio_distant_thunder_playing");
    level flag::wait_till("exterior_sounds_cleanup");
    var_7ecccb98 notify(#"snd_emitter_stop");
  }
}

function function_bb691cfa() {
  level waittill(#"hash_7aaf15b1dddd49ef");
  snd::play("evt_forest_intro_heli_dist_3d", (-6553, -6179, 558));
}

function function_a5ecad0d(ent) {
  audio::snd_set_snapshot("cp_rus_amerika_heli_intro");
  var_51b965c9 = snd::play("evt_forest_intro_heli_02", ent);
  level waittill(#"perimeter_heli_spawned");
  audio::snd_set_snapshot("");
}

function function_7a945b02() {
  level.player endon(#"death");

  if(level flag::get("flg_audio_forest_crickets_playing") == 1) {
    return;
  }

  if(isDefined(level.player)) {
    level flag::set("flg_audio_forest_crickets_playing");
    level waittill(#"hash_63d9c03656bf9e3f");
    self thread function_e098a17a("emt_cricket_chirp_single_forest_01", (-6555, -5873, 380), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_01", (-6102, -5014, 430), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_02", (-6825, -6884, 450), [1, 2, 3, 5], [3, 11]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_02", (-6244, -5250, 430), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_02", (-6020, -4754, 430), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_03", (-6394, -6410, 380), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_03", (-6421, -5630, 430), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_04", (-6586, -6211, 380), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_04", (-6366, -5182, 430), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_forest_04", (-5661, -4605, 410), [1, 2, 3, 5], [4, 12]);
  }
}

function function_123c2ccb() {
  level.player endon(#"death");

  if(level flag::get("flg_audio_perimeter_crickets_playing") == 1) {
    return;
  }

  if(isDefined(level.player)) {
    level flag::set("flg_audio_perimeter_crickets_playing");
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4635, -4384, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4394, -4959, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4394, -4959, 80), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-5056, -2845, 54), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-4744, -4120, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-5046, -4564, 149), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-5318, -3243, 65), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-5318, -3243, 65), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-5287, -2446, 30), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-4959, -3817, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-4335, -4356, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-3705, -5571, 80), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-5782, -3313, 65), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-5408, -1983, 40), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-5368, -4078, 102), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-4097, -4657, 80), [1, 2, 3, 5], [4, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-2774, -5801, 80), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-5827, -2161, 30), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-4706, -4254, 80), [1], [10, 20]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-5093, -3124, 60), [1], [10, 20]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-5056, -1784, 20), [1], [10, 20]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-3761, -4116, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-2588, -4229, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-1916, -4827, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-4280, -4061, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-2898, -3539, 20), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-3291, -4656, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-2117, -3911, 50), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-3399, -3899, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-2500, -3787, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-2146, -4409, 60), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-3506, -4323, 20), [1], [7, 15]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4793, -2026, 20), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4134, -3660, 20), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-4249, -2231, 20), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-4143, -2638, 20), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-3940, -3800, 20), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-4377, -2687, 20), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-4140, -2267, 20), [1], [7, 15]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-4646, -2312, 20), [1], [10, 20]);
  }
}

function function_30189650(ent) {
  var_26c5f497 = snd::play("veh_driveby_apc_lp", ent);
  level flag::wait_till("exterior_sounds_cleanup");
  snd::stop(var_26c5f497, 0.5);
  snd::stop(level.var_c061a627, 0.5);
}

function function_7258f7f4(ent) {
  level.var_c061a627 = snd::play("veh_driveby_apc_lp", ent);
  level waittill(#"hash_77ea555910abea0f");
  snd::stop(level.var_c061a627, 0.3);
  snd::play("veh_driveby_apc_decelerate", ent);
  snd::play([0, "veh_driveby_apc_idle_lp", 0.5], ent);
}

function function_bda0d0f7() {
  if(level flag::get("flg_audio_heli_idle_playing") == 1) {
    return;
  }

  var_98f7f290 = snd::play("emt_helicopter_large_idle", (-2925, -1952, 199));
  level flag::set("flg_audio_heli_idle_playing");
  level flag::wait_till("exterior_sounds_cleanup");
  snd::stop(var_98f7f290, 1);
}

function function_75f2707c() {
  snd::play("evt_heli_blade_death");
}

function audio_side_door_apc_go(ent) {
  snd::stop(level.var_fcf043d9, 2);
  snd::play("evt_veh_apc_drive_close_accelerate", ent);
  level.var_6cb78143 = snd::play([0, "evt_veh_apc_drive_close_lp", 4], ent);
  level waittill(#"hash_74a73f5954822211");
  snd::stop(level.var_6cb78143, 5);
}

function audio_side_door_apc_stop(ent) {
  snd::stop(level.var_6cb78143, 2);
  snd::play("evt_veh_apc_drive_close_decelerate", ent);
  level.var_fcf043d9 = snd::play([0, "evt_veh_apc_drive_close_idle_lp", 1.5], ent);
  level waittill(#"hash_74a73f5954822211");
  snd::stop(level.var_fcf043d9, 5);
}

function function_8ce67015() {
  level.player endon(#"death");

  if(level flag::get("flg_audio_sidedoor_crickets_playing") == 1) {
    return;
  }

  if(isDefined(level.player)) {
    level flag::set("flg_audio_sidedoor_crickets_playing");
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-654, -1226, 10), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-4071, -524, 20), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_01", (-2616, 46, 20), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-1165, -750, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-3984, -783, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-1951, -56, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_02", (-76, 101, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (302, -1206, 10), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-3460, -332, 10), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-2451, -341, 10), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_03", (-973, 84, 10), [1, 2, 3, 5], [2, 10]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-95, -1203, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-2919, -375, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (-670, -102, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_single_04", (144, -173, 10), [1, 2, 3, 5], [2, 12]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-711, -748, 10), [1], [20, 30]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-3313, 41, 10), [1], [15, 25]);
    self thread function_e098a17a("emt_cricket_chirp_pattern_01", (-1182, -344, 10), [1], [15, 25]);
    level flag::wait_till("exterior_sounds_cleanup");
    level flag::set("flg_cricket_stop");
  }
}

function function_ace83e8e() {
  if(level flag::get("flg_audio_tunnels_tvs") == 1) {
    return;
  }

  level flag::set("flg_audio_tunnels_tvs");
  var_136b3fde = getdynentarray("audio_tunnels_tv_dyent");

  foreach(var_21f452ad in var_136b3fde) {
    var_e9853265 = snd::play("amb_emt_tv_static_03", var_21f452ad.origin);
    var_e9853265 thread function_37294a47(var_21f452ad);
  }
}

function function_f40c094d() {
  if(level flag::get("tunnel_generator_on") == 1) {
    return;
  }

  level flag::set("tunnel_generator_on");
  level waittill(#"hash_67ee65147a09a849");
  audio::snd_set_snapshot("cp_rus_amerika_tunnels_generator");
  var_b70962f6 = snd::play([0, "amb_emt_generator_tunnel_stairs", 0.5], (891, -137, -279));
  level waittill(#"hash_24df18dddddc2d4a");
  wait 0.25;
  audio::snd_set_snapshot("");
  level waittill(#"hash_7881749038062387");
  snd::stop(var_b70962f6, 4);
}

function function_4190b630() {
  if(level flag::get("tunnel_generator_on") == 1) {
    return;
  }

  level flag::set("tunnel_generator_on");
  var_b70962f6 = snd::play([0, "amb_emt_generator_tunnel_stairs", 0], (891, -137, -279));
  level waittill(#"hash_7881749038062387");
  snd::stop(var_b70962f6, 4);
}

function function_545dfe3b() {
  wait 0.2;
  snd::play("evt_lockpick_room_alarm_lr");
}

function function_7547ed65() {
  var_941e5193 = ["emt_arcade_game_ptfll", "emt_arcade_game_brnstrmng", "emt_arcade_game_grndprx", "emt_arcade_game_fshdrby", "emt_arcade_game_rvrrd", "emt_pinball_idle_01", "emt_pinball_idle_02", "emt_arcade_game_broken"];
  var_355193d1 = [[(1679, 1503, -248)], [(1792, 1720, -248)], [(1914, 1557, -248)], [(2259, 1536, -248)], [(1918, 1326, -248)], [(1805, 1846, -256)], [(1739, 1838, -259)], [(1578, 1493, -264), (1689, 1566, -264), (1814, 1514, -264), (1700, 1455, -267), (1942, 1742, -265)]];
  level.var_28f2e8d6 = [];
  level waittill(#"hash_3e20e66e1130f5e0");
  wait 0.5;

  foreach(index, alias in var_941e5193) {
    level.var_28f2e8d6[index] = snd::emitter(alias, var_355193d1[index], [5, 5]);
  }

  level waittill(#"hash_cead01409a49817");
  level notify(#"snd_emitter_stop");
}

function function_c0af2104() {
  var_32615380 = snd::play("mus_arcade_behind_door", (1574, 1819, -259));
  level waittill(#"hash_28c486ec7f5c0f67");
  snd::stop(var_32615380, 0.3);
  var_8e92e6db = snd::play("mus_arcade", (1778, 1628, -213));
  var_b238197c = snd::play("mus_video_store", (2463, 949, -130));
  level waittill(#"audio_main_street_music_started");
  snd::stop(var_8e92e6db, 3.5);
  snd::stop(var_b238197c, 3.5);
}

function evt_heli_rappel_alarm() {
  snd::play("evt_heli_rappel_alarm", (2914, 2314, 64));
  wait 2;
  snd::play("evt_heli_rappel_alarm", (2914, 2314, 64));
  wait 2;
  snd::play("evt_heli_rappel_alarm", (2914, 2314, 64));
  wait 2;
  snd::play("evt_heli_rappel_alarm", (2914, 2314, 64));
  wait 2;
}

function function_329bafc9() {
  if(flag::get("moving_targets_ducked") == 1) {
    return;
  }

  flag::set("moving_targets_ducked");
  audio::snd_set_snapshot("cp_rus_amerika_moving_targets");
  level waittill(#"hash_c67feccc2a013c6");
  audio::snd_set_snapshot("");
}

function function_b18c414e() {
  function_5ea2c6e3("cp_rus_amk_arcade_game_interacts", 0, 1);
  level waittill(#"flg_arcade_emulator_stop");
  function_ed62c9c2("cp_rus_amk_arcade_game_interacts", 1);
}

function function_db555295(ent) {
  wait 0.5;
  snd::play("evt_enemy_truck_drive_up", ent);
  var_76a03a09 = snd::play([2.1, "evt_enemy_truck_drive_up_idle", 0.25], ent);
  level waittill(#"flg_audio_truck_engine_idle_stop");
  snd::stop(var_76a03a09, 0.25);
}

function function_55f97b00() {
  if(level flag::get("flg_audio_tv_store_tvs") == 1) {
    return;
  }

  level flag::set("flg_audio_tv_store_tvs");
  var_136b3fde = getdynentarray("audio_tv_store_tv_dyent");

  foreach(var_21f452ad in var_136b3fde) {
    var_e9853265 = snd::play("dst_amk_tv_lp", var_21f452ad.origin);
    var_e9853265 thread function_37294a47(var_21f452ad);
  }
}

function function_b7ef60a2() {
  if(level flag::get("elevator_generators_off") == 1) {
    return;
  }

  var_852e7409 = [(5267, 4006, -251), (5269, 4266, -252), (5661, 4106, -267)];
  generators = snd::play([0, "amb_emt_elev_generator_03_no_occ", 0.5], var_852e7409);
  level waittill(#"hash_2b669872cda1e74f");
  snd::stop(generators, 10);
}

function function_845469bf(ent) {
  snd::play("evt_tower_elevator_start_lr", ent);
  var_12c17d45 = snd::play([0.5, "evt_tower_elevator_lp_lr"], ent);
  level waittill(#"flg_main_street_elevator_reached_ground");
  snd::stop(var_12c17d45, 0.5);
  snd::play("evt_tower_elevator_stop_lr", ent);
}

function function_1a0fd7ea(ent) {
  level notify(#"hash_2b669872cda1e74f");
  snd::play("evt_tower_elevator_start_lr", ent);
  var_12c17d45 = snd::play([0.5, "evt_tower_elevator_lp_lr"], ent);
  level waittill(#"flg_control_tower_elevator_at_top");
  wait 5.7;
  snd::stop(var_12c17d45, 0.5);
  snd::play("evt_tower_elevator_stop_lr", ent);
}

function evt_ai_open_terminal_door_audio(ent) {
  snd::play("evt_ai_open_terminal_door", ent);
}

function function_8f849679() {
  snd::play("emt_tape_servers_start", (6231, 4357, 332));
  server_loop = snd::play([2, "emt_tape_servers_lp", 1], (6231, 4357, 332));
  level waittill(#"hash_3abf20f78c8facb5");
  snd::stop(server_loop, 0);
  snd::play("emt_tape_servers_stop", (6231, 4357, 332));
}

function function_dc569745() {
  function_5ea2c6e3("cp_rus_amerika_terminal_computer_duck", 0, 1);
}

function function_b676524d() {
  if(flag::get("terminal_alarms_triggered") == 1) {
    return;
  }

  flag::set("terminal_alarms_triggered");

  while(!level flag::get("flg_audio_stop_terminal_alarms")) {
    var_93014a21 = [(6454, 4662, 413), (6761, 4359, 379), (7316, 4820, 800), (7439, 5447, 118)];
    snd::play("evt_terminal_alarm_a", var_93014a21);
    var_4d9856f4 = [(6017, 4576, 413), (6969, 4564, 391), (7289, 5054, 800), (7984, 5468, 118)];
    snd::play("evt_terminal_alarm_b", var_4d9856f4);
    var_179d7e2e = [(6223, 4339, 413), (6972, 5096, 415), (7904, 5013, 481), (7761, 5029, 46)];
    snd::play("evt_terminal_alarm_c", var_179d7e2e);
    var_9fe3343d = [(6220, 4843, 413), (6640, 5064, 415), (7859, 5320, 346), (7416, 5084, 31)];
    snd::play("evt_terminal_alarm_d", var_9fe3343d);
    wait 3;
  }
}

function function_747d0cf3() {
  if(flag::get("terminal_alarm_emitters_triggered") == 1) {
    return;
  }

  flag::set("terminal_alarm_emitters_triggered");
  var_1765a14 = snd::play("emt_alarm_pulsing_light_observation", (6773, 4677, 410));
  var_b676524d = snd::play("emt_alarm_pulsing_light_terminal", (6227, 4576, 436));
  var_a04da0aa = snd::play("evt_alarm_klaxon_lp", (7437, 5004, 417));
  var_3ded9baa = [(6279, 4474, 304), (6141, 4643, 300), (6034, 4367, 350)];
  snd::play("emt_soviet_comp_alarm_lp_01", var_3ded9baa);
  var_d1eac190 = [(6199, 4466, 295), (6530, 4354, 335), (6715, 5092, 358), (6085, 4341, 350)];
  snd::play("emt_soviet_comp_alarm_lp_02", var_d1eac190);
  var_6091908a = [(6292, 4503, 302), (6194, 4676, 300), (6725, 4351, 356), (6974, 4798, 350), (6429, 4364, 350), (6029, 4772, 332)];
  snd::play("emt_soviet_comp_alarm_lp_03", var_6091908a);
  var_1e1c17f0 = [(6233, 4464, 299), (6237, 4673, 300), (6624, 5064, 358), (6362, 4339, 350)];
  snd::play("emt_soviet_comp_alarm_lp_04", var_1e1c17f0);
  var_c17af0f0 = [(6154, 4479, 295), (6625, 4862, 358), (6978, 4596, 356), (6003, 4725, 332)];
  snd::play("emt_soviet_comp_alarm_lp_05", var_c17af0f0);
  var_a3ed1fb7 = [(6141, 4505, 295), (6283, 4649, 300), (6639, 5090, 358)];
  snd::play("emt_soviet_comp_alarm_lp_06", var_a3ed1fb7);
  level flag::wait_till("flg_audio_stop_terminal_alarms");
  snd::stop(var_1765a14);
  snd::stop(var_b676524d);
  snd::stop(var_a04da0aa);
}

function function_9bb82dae() {
  snd::play("cin_amk_6020_fds_stumble_gear_01");
  snd::play("cin_amk_6020_fds_stumble_props_01");
}

function function_8656b058() {
  function_5ea2c6e3("cp_rus_amerika_apc_wpn", 0, 1);
}

function function_c8cd1f84() {
  snd::play("evt_motor_pool_rollup_door", (9674, 1318, -403));
  function_ed62c9c2("cp_rus_amerika_apc_wpn", 0);
  level notify(#"hash_4867a529b7eb5c2d");
}

function function_4a83b171() {
  if(flag::get("flg_audio_motorpool_alarms_started") == 1) {
    return;
  }

  flag::set("flg_audio_motorpool_alarms_started");
  level waittill(#"hash_4867a529b7eb5c2d");
  snd::play("emt_alarm_pulsing_light_motorpool", (10595, 1909, -146));
}

function function_5a5419bb() {
  snd::play("evt_motor_pool_rollup_door", (9674, 1318, -403));
  snd::play("evt_motor_pool_huge_door_close", (11534, 2902, -217));
  snd::play("evt_motor_pool_huge_door_klaxon", (11534, 2902, -217));
}

function function_f958a41b() {
  level waittill(#"hash_3ebf6e122c1624b6");

  if(level flag::get("flg_audio_apc_started") == 1) {
    return;
  }

  level flag::set("flg_audio_apc_started");
  wait 2;
  snd::play("veh_apc_ride_full_lr");
  function_5ea2c6e3("cp_rus_amerika_apc_ride_scene", 0, 1);
}

function function_85f15df8() {
  if(level flag::get("flg_audio_apc_started") == 1) {
    return;
  }

  level flag::set("flg_audio_apc_started");
  snd::play([0, "veh_apc_ride_courtyard_lr", 0.5]);
  function_5ea2c6e3("cp_rus_amerika_apc_ride_scene", 0, 1);
}

function function_4c2bbef4() {
  if(level flag::get("flg_audio_apc_started") == 1) {
    return;
  }

  level flag::set("flg_audio_apc_started");
  snd::play([0, "veh_apc_ride_mall_lr", 0.5]);
  function_5ea2c6e3("cp_rus_amerika_apc_ride_scene", 0, 1);
}

function function_bd18b7b8() {
  level waittill(#"hash_744134a5d398d586");
  snd::play("evt_apc_ride_facility_door_klaxon", (1204, 7312, 141));
}

function function_1172e136() {
  level waittill(#"hash_70d984364da76e92");
  snd::play("evt_apc_ride_facility_door_close_01", (1215, 7277, -274));
}

function function_5a97f38f() {
  level waittill(#"hash_70d983364da76cdf");
  snd::play("evt_apc_ride_facility_door_close_02", (230, 7232, 99));
}