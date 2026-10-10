/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_ff8b2e2a2a57828.gsc
************************************************/

#using script_1426fa5f49d822c8;
#using script_2dcc22f11f14cb9;
#using script_389a9d54d8274d2a;
#using script_49511723a3204d35;
#using script_654ffaecd1155946;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\exploder;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace namespace_69509601d5e4ed14;

function function_7e0c5db2fbc8bba4() {}

function function_5597cff585479739() {
  level thread function_eae70b127f98985b();
  utility::set_start_location("s_start_hideout_intro", utility::array_combine([level.player], level.var_679be75090dd2a47));
  namespace_fc0114e844f0b4c::function_e3a57216f5802c88();
  utility::flag_set("flg_pov_price_tac");
  level thread namespace_8ab6dfa83f4e0dea::function_554254a8f0ee57f0();

  level thread function_c4bed616d3a3036c("<dev string:x1c>");
}

function function_4dde5fec8c66abba() {
  thread namespace_fc0114e844f0b4c::function_7cc0459bf11198d8();
  function_a92f5fba710994fe();
  function_be299b038f549e49();
  level thread function_35dd19d7376bcf4();
  level thread function_7edb2a4f2153695e();
  level thread namespace_fc0114e844f0b4c::function_3c4b810d62d1f03f();
  level thread function_c03bb90937e657d3();
  level thread namespace_f43c40f7bcbe17e7::function_c5795c615a163823();
  level thread function_791c2eb990017928();
  registered = "streets_cctv_timeskip";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "prone", 1);
  level.player player::focusdisable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level thread function_6163de672e04d0e2();
  level thread function_cd79e047e1e8e0ac();
  thread function_a9a6adb5b58b3fb4();
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_5ccdc11fd0355883();
  function_95b92e88851f75ae();
  level.player val::set(registered, "show_weapon_hud", 1);
  level.player val::set(registered, "show_hud", 1);
  level.player val::set(registered, "weapon", 1);
  level.player val::set(registered, "freezecontrols", 0);
  level.player player::focusenable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  flag_set("flg_streets_cctv_track_done");
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_4dfbcdf6e57930e7();
  var_bee15146f952c6ed = getspawnerarray("ai_hideout_alley_police");
  array_spawn_function(var_bee15146f952c6ed, &function_8167697ac480b624);
  level.var_bee15146f952c6ed = array_spawn(var_bee15146f952c6ed, 1);
  var_2827842c90a18abf = getspawnerarray("ai_civ_hideout_crowd");

  if(var_2827842c90a18abf.size > 0) {
    array_spawn_function(var_2827842c90a18abf, &function_e5bbb1fb05fc2e44);
    array_spawn_function(var_2827842c90a18abf, &function_e92e2de5964389c2, undefined, 1);
    var_2827842c90a18abf = array_spawn(var_2827842c90a18abf, 1);
  }

  var_9d18842100721fd0 = getEntArray("e_street_outro_alley_prop", "targetname");

  foreach(e_prop in var_9d18842100721fd0) {
    e_prop hide();
  }

  flag_wait("flag_scene_0300_player_entered_gate_complete");
  level thread function_8ff0eb9963fb04f9();
  level thread function_242f4899008ebd3b();
  startweapon = utility::make_weapon("jup_jp09_sh_oromeo12_sp", ["jup_jp09_sh_oromeo12_bar_short", "jup_jp09_sh_oromeo12_stock", "jup_jp09_sh_oromeo12_mag_8_12g", "grip_vertshort07", "jup_comp_sh_02", "jup_jp09_sh_oromeo12_pgrip_tac"]);
  level.player utility::give_weapon(startweapon);
  level.player switchtoweapon(startweapon);
  thread function_5ff5bbe55d13626c();
  thread function_24a1f037d09eb2f4();
  thread function_9e0badccd0eb200a();
  utility::autosave_by_name();
  flag_wait_or_timeout("flg_hideout_breach_vo_complete", 10);
  level.player val::set("no_first_raise", "weapon_first_raise_anims", 1);
  level utility::flag_set("flg_hideout_entry_sfo_kickoff");
  level.ai_soap function_11f1be76c3f89960("cqb");
  level.var_d18d63c6d75cd1e function_11f1be76c3f89960("cqb");
  ai_enemy_hideout_cqc_stagger = spawn_targetname("ai_enemy_hideout_cqc_stagger");
  ai_enemy_hideout_cqc_stagger thread hideout_cqc_enemy_stagger();
  ai_enemy_hideout_cqc_stagger thread function_b52f72e5d94144f9();
  function_9e29132d33b8fd8c();
  utility::flag_wait("flg_hideout_intro_done");
  utility::flag_set("hideout_follow_team_complete");
  flag_set("flg_street_vehicle_cleanup");
}

function function_a9a6adb5b58b3fb4() {
  stopmusicstate("mx_surge_seen");
}

function function_cd79e047e1e8e0ac() {
  wait 20;
  level.var_d18d63c6d75cd1e setgoalnode(getnode("nd_streets_tunnel_gaz_end", "targetname"));
  level.ai_soap setgoalnode(getnode("nd_streets_tunnel_soap_end", "targetname"));
  level.ai_soap set_force_color("b");
  level.var_d18d63c6d75cd1e set_force_color("g");
  flag_wait("flg_hideout_breached");
  level.ai_soap demeanor_override("combat");
  level.var_d18d63c6d75cd1e demeanor_override("combat");
}

function function_7edb2a4f2153695e() {
  utility::transient_load_array(["jup_surge_hideout_tr"]);
  utility::flag_wait("flg_streets_cctv_track_done");
  utility::transient_unload_array(["sp_jup_surge_water_tr"]);
  utility::flag_wait("hideout_follow_team_complete");
  utility::transient_unload_array(["jup_surge_city_park_tr", "jup_surge_city_periph_tr"]);
}

function function_24a1f037d09eb2f4() {
  var_21887061be3ae2d8 = getEnt("b_hideout_breach_player_blocker", "targetname");
  utility::flag_wait("breach_start");
  wait 3;
  var_21887061be3ae2d8 movez(-128, 0.1);
}

function function_8167697ac480b624() {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "generic";
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  utility::demeanor_override("patrol");
  self setgoalpos(self.origin);
  self.fixednode = 1;
  flag_wait("flg_hideout_intro_done");
  self delete();
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_4dfbcdf6e57930e7();
}

function function_e5bbb1fb05fc2e44() {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "generic";
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  thread civilianfailwrapper();
  flag_wait("flg_hideout_intro_done");
  self delete();
}

function function_c03bb90937e657d3() {
  while(!isDefined(level.ai_hideout_sfo_interior_1)) {
    waitframe();
  }

  function_40ec157015971a3e(78);
  level.ai_soap.disablegrenaderesponse = 1;
  level.var_d18d63c6d75cd1e.disablegrenaderesponse = 1;
  level.ai_soap enableavoidance(0);
  level.var_d18d63c6d75cd1e enableavoidance(0);

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    sfo.disablegrenaderesponse = 1;
  }

  flag_wait("flg_hideout_stairwell_advance");
  flag_set("flg_hideout_breach_2nd_wave");
}

function function_8ff0eb9963fb04f9() {
  flag_wait("flg_streets_cctv_track_done");
  level.player allowprone(1);
  level.player allowsupersprint(1);
  level.player val::set("player_speedScalingLogic", "sprint", 1);
  level.player val::set("player_speedScalingLogic", "allow_jump", 1);
  level thread function_837bb2142379dbfb("default");
  utility::flag_set("flg_pov_price_tac");
  level.player function_6078d3c20d55c620();
  backupweapon = utility::make_weapon("jup_jp12_pi_mike93_sp", ["jup_jp12_pi_mike93_mag_30_9mm", "breacher_pi_01", "jup_jp12_pi_mike93_trigger", "laserpstl_hip01"]);
  level.player utility::give_weapon(backupweapon);
  level.player give_offhand("frag", 4);
  level.player give_offhand("smoke", 4);
  level.player utility::function_fef4d6151e091533();

  if(scripts\sp\starts::is_after_start("hideout_intro")) {
    startweapon = utility::make_weapon("jup_jp09_sh_oromeo12_sp", ["jup_jp09_sh_oromeo12_bar_short", "jup_jp09_sh_oromeo12_stock", "jup_jp09_sh_oromeo12_mag_8_12g", "grip_vertshort07", "jup_comp_sh_02", "jup_jp09_sh_oromeo12_pgrip_tac"]);
    level.player utility::give_weapon(startweapon);
    level.player switchtoweapon(startweapon);
  } else {
    while(weapon_empty(level.player getcurrentprimaryweapon())) {
      wait 0.1;
    }
  }

  level.player function_8d2c23481bd4016c(1);
}

function hideout_cqc_enemy_stagger() {
  self endon("death");
  self.animname = "generic";
  set_pacifist(1);
  level thread function_678ee05eb44c1fb9(self, "flg_hideout_intro_stagger_enemy_visible", "flg_hideout_cqc_hallway_advance_3");
  var_3c1fba7fc11e4977 = getStruct(self.target, "targetname");
  var_3c1fba7fc11e4977 scripts\common\anim::anim_first_frame_solo(self, "run_reaction_180");
  utility::flag_wait("flg_hideout_cqc_enemy_stagger");
  level thread function_3025ee051d28ec46([self], "flg_hideout_intro_stagger_enemy_dead");
  flag_set("flg_hideout_cqc_bathroom_enemy_anim_start");
  set_allowdeath(1);
  var_3c1fba7fc11e4977 anim_single_solo_run(self, "run_reaction_180");
  demeanor_override("sprint");
  s_retreat = getStruct("s_bathroom_stagger_retreat_path", "targetname");
  thread scripts\sp\spawner::go_to_node(s_retreat);
  utility::flag_wait("flg_hideout_stagger_reached_bathroom");

  if(!flag("flg_hideout_bathroom_enter")) {
    self delete();
    return;
  }

  set_pacifist(0);
}

function function_8595438a6e47852f() {
  self endon("death");
  self.animname = "generic";
  set_pacifist(1);
  var_3c1fba7fc11e4977 = getStruct(self.target, "targetname");
  var_3c1fba7fc11e4977 scripts\common\anim::anim_first_frame_solo(self, "jup_interaction_alert_doorcode_loop_01");
  utility::flag_wait("flg_hideout_cqc_hallway_advance_3");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  set_allowdeath(1);

  while(!flag("flg_hideout_ab_turret_safety")) {
    var_3c1fba7fc11e4977 anim_single_solo_run(self, "jup_interaction_alert_doorcode_loop_01");
  }

  var_3c1fba7fc11e4977 anim_single_solo_run(self, "jup_interaction_alert_doorcode_loop_01");
  level notify("cqc_turret_active");
  var_3c1fba7fc11e4977 anim_single_solo_run(self, "jup_interaction_alert_doorcode_end");
  vol_hideout_bathroom_back = getEnt("vol_hideout_bathroom_back", "targetname");
  self setgoalvolumeauto(vol_hideout_bathroom_back);
  wait 3;
  self delete();
}

function function_9e0badccd0eb200a() {
  var_dab51401055f47c2 = getEnt("trg_hideout_breach_colors_heroes_stackup_1", "targetname");
  var_dab51301055f458f = getEnt("trg_hideout_breach_colors_heroes_stackup_2", "targetname");
  flag_wait("breach_start");
  wait 4;

  if(!flag("flg_hideout_breached")) {
    var_dab51301055f458f notify("trigger");
    wait 0.7;
    var_dab51401055f47c2 notify("trigger");
  }
}

function function_c62d194cbba5e51b() {
  utility::flag_set("flg_pov_price_tac");
  utility::flag_set("flg_streets_cctv_track_done");
  flag_set("flg_street_vehicle_cleanup");
  thread namespace_fc0114e844f0b4c::function_7cc0459bf11198d8();
  function_9e29132d33b8fd8c();
  thread function_5ff5bbe55d13626c();
  level.player function_8d2c23481bd4016c(1);
  function_be299b038f549e49();
}

function function_b3d76e2146c01696() {}

function function_4adbe5d4d260e906() {
  level thread function_59460a9e6c862035();
  namespace_fc0114e844f0b4c::function_3c4b810d62d1f03f();
  utility::set_start_location("s_start_hideout_cqc", utility::array_combine([level.player], level.var_679be75090dd2a47));
  namespace_fc0114e844f0b4c::function_e3a57216f5802c88();
  function_a92f5fba710994fe();
  level thread function_8ff0eb9963fb04f9();
  level thread namespace_8ab6dfa83f4e0dea::function_554254a8f0ee57f0();
  level.player val::set("no_first_raise", "weapon_first_raise_anims", 0);
  level thread function_791c2eb990017928();
  level.ai_soap function_11f1be76c3f89960();
  level.var_d18d63c6d75cd1e function_11f1be76c3f89960();
  level.var_d18d63c6d75cd1e thread scripts\sp\spawner::go_to_node(getnode("nd_hideout_cqc_gaz_start", "targetname"));
  level.ai_soap thread scripts\sp\spawner::go_to_node(getnode("nd_hideout_cqc_soap_start", "targetname"));
  ai_hideout_sfo_interior_1 = getspawnerarray("ai_hideout_sfo_interior_1");
  level.ai_hideout_sfo_interior_1 = array_spawn(ai_hideout_sfo_interior_1, 1);

  while(!isDefined(level.ai_hideout_sfo_interior_1)) {
    waitframe();
  }

  function_2d0687f499cc3295();
  function_40ec157015971a3e(78);
}

function function_2d0687f499cc3295() {
  var_52b4ab89758c004b = getnodearray("nd_hideout_sfo_skipto_cqc", "script_noteworthy");
  var_f3fec43d34b4d3fe = level.ai_hideout_sfo_interior_1;

  for(i = 0; i < level.ai_hideout_sfo_interior_1.size; i++) {
    sfo = level.ai_hideout_sfo_interior_1[i];
    nd_start = var_52b4ab89758c004b[i];
    sfo forceteleport(nd_start.origin, nd_start.angles);
  }

  var_f619858dcce2d7b0 = getEnt("trg_hideout_cqc_colors", "targetname");
  var_f619858dcce2d7b0 activate_trigger();
}

function function_297b8c42f0cd844f() {
  level thread function_a0d0159672732fb9();
  level thread function_b2ef61d443fb99ff();
  thread function_6eba453eebbd5964();
  utility::autosave_by_name();
  level thread namespace_f43c40f7bcbe17e7::function_2c10063300667426();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(90, undefined, "flag_hideout_cqc_stop_nags", "hideout_cqc_player_progress");
  utility::flag_wait("flg_hideout_cqc_hallway_advance_1_skip");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level.ai_soap set_force_color("b");
  level.var_d18d63c6d75cd1e set_force_color("g");
  function_1dd827966f49f75a();
  thread function_2459ed3aa56b532f();
  ai_enemy_hideout_cqc_turret_setup = spawn_targetname("ai_enemy_hideout_cqc_turret_setup");
  ai_enemy_hideout_cqc_turret_setup thread function_8595438a6e47852f();
  flag_set("flg_hideout_cqc_stairwell_enemies_spawn");
  flag_wait("flg_hideout_cqc_hallway_advance_2_skip");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level.var_c5c98481cf154b0f = array_removedead_or_dying(level.var_c5c98481cf154b0f, 1);

  foreach(sfo in level.var_c5c98481cf154b0f) {
    sfo set_movement_speed(178);
  }

  thread function_5e1c207a7182814e();
  thread function_e13a673d634626e6();
  thread function_2a8ba607dc880189();
  thread function_c12618194aca1d4();
  thread function_b3a12d0139f837bb();
  flag_wait_any("flg_hideout_cqc_hallway_advance_4_skip", "flg_hideout_cqc_hallway_advance_4_force");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  battlechatter_on();
  level.var_d18d63c6d75cd1e demeanor_override("combat");
  level.ai_soap demeanor_override("combat");
  level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);

  if(isDefined(level.ai_hideout_sfo_interior_1)) {
    foreach(sfo in level.ai_hideout_sfo_interior_1) {
      sfo demeanor_override("combat");
    }
  }

  flag_wait_any("flg_hideout_finale_start", "flg_escalator_enemies_dead");
  var_52a1386b97810463 = getnode("n_bathroom_hall_guy", "targetname");
  level thread function_c01ae6bb604460df(var_52a1386b97810463.origin, 900);
  level function_87a70036926b2c90("hideout_cqc_player_progress");
}

function function_5e1c207a7182814e() {
  utility::flag_wait("flg_hideout_colors_reached_turret");
  a_triggers = getEntArray("flg_hideout_colors_reached_turret", "targetname");

  foreach(ent in a_triggers) {
    ent triggerdisable();
  }

  utility::flag_wait("flg_hideout_main_path_skip_3");
  a_triggers = getEntArray("flg_hideout_main_path_skip_3", "targetname");

  foreach(ent in a_triggers) {
    ent triggerdisable();
  }
}

function function_b0a9d93caead2efc() {
  level thread function_b2ef61d443fb99ff();
}

function function_b2ef61d443fb99ff() {
  var_81cca45714559a19 = [];
  flag_wait("scriptables_ready");
  var_81cca45714559a19 = getEntArray("scriptable_machinery_ferriswheel_modern_jup_surge_rig", "classname");
  var_81cca45714559a19[0] setscriptablepartstate("base", "id_hidden");
}

function function_6eba453eebbd5964() {
  utility::flag_wait("flg_hideout_cqc_hallway_advance_3");
  e_door = getEnt("surge_hideout_door", "targetname");
  e_door rotateby((0, 103, 0), 0.5);
  var_b9032fef97f89b15 = getEnt("jup_door_clip_hideout_breach", "targetname");
  var_b9032fef97f89b15 disconnectPaths();

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    if(isDefined(sfo.script_noteworthy) && sfo.script_noteworthy == "hideoutally04") {
      sfo delete();
    }
  }
}

function function_a0d0159672732fb9() {
  utility::flag_wait("flg_hideout_cqc_hallway_advance_3");
  utility::transient_unload_array(["jup_surge_city_park_tr", "jup_surge_city_periph_tr", "sp_jup_surge_water_tr", "jup_surge_city_streets_tr"]);
}

function function_2459ed3aa56b532f() {
  level endon("flg_hideout_cqc_hallway_advance_3");
  utility::flag_wait("flg_hideout_heroes_stairwell_hall_mid_3");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_cqc_player_progress");
}

function function_1dd827966f49f75a() {
  while(!isDefined(level.ai_hideout_sfo_interior_1)) {
    waitframe();
  }

  level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);
  level.ai_soap.disablegrenaderesponse = 0;
  level.var_d18d63c6d75cd1e.disablegrenaderesponse = 0;

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    sfo.disablegrenaderesponse = 0;
    sfo demeanor_override("cqb");
    sfo reset_gunpose();
  }
}

function function_e13a673d634626e6() {
  s_sentry = getStruct("s_hideout_mainhall_turret", "targetname");
  s_sentry.var_2108ba0559bdaaff = &function_5e66cae8a3e9f368;
  level.mainhall_turret = setup_enemy_sentry(s_sentry);
  var_6896cd8f9756ca43 = spawn_script_origin(level.mainhall_turret.origin + (0, 0, 50));
  thread function_20e52f38cd19d6dc(var_6896cd8f9756ca43, "flg_hideout_cqc_mainhall_turret_visible", "flg_hideout_ab_turret_safety");
  level waittill_any("cqc_turret_active", "flg_hideout_cqc_hallway_advance_4_skip");
  level.mainhall_turret makeentitysentient("axis", 0);
  thread function_c47f54c5194f6843(level.mainhall_turret, "flg_hideout_shop_endpath");
  thread function_fd88f465904eaab1(level.mainhall_turret, "flg_mainhall_turret_dead");
}

function function_4f8597ec16651fa9() {}

function function_2a8ba607dc880189() {
  level endon("flg_hideout_finale_start");
  level endon("flg_hideout_main_path_corridor02");
  level thread function_a011fc5c801696c5(level.var_d18d63c6d75cd1e);
  flag_wait("flg_hideout_bathroom_enter");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level.var_d18d63c6d75cd1e set_movement_speed(178);
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_703a09200ce52e48();
  level.var_2a2df0e9a2dbc5ae = utility::spawn_targetname("ai_enemy_hideout_bathroom_stall", 1);
  level.var_a6e7fd4bd3eb19b9 = utility::spawn_targetname("ai_enemy_hideout_bathroom_spray", 1);
  level.var_cc456419f1b1cb67 = utility::spawn_targetname("ai_enemy_hideout_bathroom_hall", 1);
  level.var_2a2df0e9a2dbc5ae thread function_f62c678f2d6a2380();
  level.var_a6e7fd4bd3eb19b9 thread function_d9311ff030de293f();
  level.var_cc456419f1b1cb67 thread function_4ef9e30b580961f9();
  thread function_fd1e9ac19a3705f4();
  var_155dc8d26a79f3a1 = [level.var_dad902a42934aee3, level.var_2a2df0e9a2dbc5ae, level.var_62ca7774886832a3, level.var_cc456419f1b1cb67];
  level thread namespace_fc0114e844f0b4c::function_3025ee051d28ec46(var_155dc8d26a79f3a1, "flag_hideout_bathroom_kills", 1);
  level thread namespace_fc0114e844f0b4c::function_3025ee051d28ec46(var_155dc8d26a79f3a1, "flag_hideout_bathroom_clear");
  flag_wait("flg_hideout_bathroom_start");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_b88dea8ecd8304e4();
  msg = utility::flag_wait_any_return("flag_hideout_bathroom_clear", "flg_hideout_bathrooms_exit");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_cqc_player_progress");

  if(msg == "flag_hideout_bathroom_clear") {
    utility::flag_wait("flg_hideout_bathrooms_exit");
  }

  thread function_26d9a26ccc05b99a();
  level.var_a6e7fd4bd3eb19b9 = undefined;
  level.var_dad902a42934aee3 = undefined;
  level.var_2a2df0e9a2dbc5ae = undefined;
  level.var_62ca7774886832a3 = undefined;
  level.var_cc456419f1b1cb67 = undefined;
}

function function_fd1e9ac19a3705f4() {
  level endon("flg_hideout_main_path_corridor01");
  s_origin = getStruct("s_hideout_bathroom_flash_origin", "targetname");
  s_target = getStruct("s_hideout_bathroom_flash_target", "targetname");
  utility::flag_wait("flg_hideout_bathroom_hall_mid");

  if(randomfloat(1) < 0.6) {
    magicgrenade("flash", s_origin.origin, s_target.origin, 1.5);
    utility::flag_set("flg_hideout_bathroom_flash_grenade");
  }
}

function function_f62c678f2d6a2380() {
  self endon("death");
  self.animname = "generic";
  self setgoalpos(self.origin, 32);
  set_fixednode_true();
  wait 0.5;
  var_ea72a4128c3104c8 = getnode("n_bathroom_stall_combat_node", "targetname");
  self.ignoresuppression = 1;
  scripts\sp\spawner::go_to_node(var_ea72a4128c3104c8);
  utility::flag_wait("flg_bathroom_stall_arrived");

  if(!flag("flg_hideout_bathroom_allies_enter")) {
    var_3c1fba7fc11e4977 = getStruct(self.target, "targetname");
    set_allowdeath(1);
    var_3c1fba7fc11e4977 anim_single_solo(self, "corner_standl_blindfire_v2");
    scripts\sp\spawner::go_to_node(var_ea72a4128c3104c8);
  }

  self.ignoresuppression = 0;
}

function function_d9311ff030de293f() {
  self endon("death");
  self.animname = "generic";
  var_f72c29cf6ad28a93 = getnode(self.target, "targetname");
  self setgoalnode(var_f72c29cf6ad28a93);
  set_fixednode_true();
  utility::flag_wait("flg_hideout_bathroom_corner");
  set_ignoresuppression(1);
  set_favoriteenemy(level.player);
  wait 4;
  n_hideout_bathroom_cover_end = getnode("n_hideout_bathroom_cover_end", "targetname");
  set_fixednode_false();
  self setgoalnode(n_hideout_bathroom_cover_end);
}

function function_4ef9e30b580961f9() {
  self endon("death");
  set_ignoreall(1);
  self.grenadeammo = 0;
  set_fixednode_true();
  utility::flag_wait_any("flag_hideout_bathroom_kills", "flg_hideout_bathroom_mid_2");
  set_fixednode_false();
  set_ignoreall(0);
  vol_hideout_bathroom_back = getEnt("vol_hideout_bathroom_back", "targetname");
  self setgoalvolumeauto(vol_hideout_bathroom_back);
}

function function_26d9a26ccc05b99a() {
  ai_enemy_bathroom_sneakattack = utility::spawn_targetname("ai_enemy_bathroom_sneakattack", 1);
  ai_enemy_bathroom_sneakattack endon("death");
  thread function_3025ee051d28ec46([ai_enemy_bathroom_sneakattack], "flg_hideout_bathroom_sneakattack_killed", undefined, "flg_hideout_finale_start");
  ai_enemy_bathroom_sneakattack set_favoriteenemy(level.ai_soap);
  utility::flag_wait("flg_hideout_main_path_corridor02");
  flag_wait_any_timeout(5, "flg_hideout_main_path_room01", "flg_hideout_main_path_skip_2");
  ai_enemy_bathroom_sneakattack set_favoriteenemy(level.player);
  ai_enemy_bathroom_sneakattack set_fixednode_false();
}

function function_a011fc5c801696c5(var_d18d63c6d75cd1e) {
  level endon("flg_hideout_bathroom_start");
  var_d5c57f3307a4458e = getStruct("s_hideout_bathroom_tele_gaz", "targetname");
  level waittill("hideout_bathroom_catchup");
  var_d18d63c6d75cd1e set_ignoreall(0);
  level.var_d18d63c6d75cd1e set_movement_speed(178);
}

function function_12d584089a5294a4() {}

function function_c12618194aca1d4() {
  flag_wait("flg_hideout_heroes_stairwell_hall_mid_3");
  thread function_2b90e41696e05656();
  thread function_39b6a972d7acee3f();
  e_hideout_shops_door = getEntArray("e_hideout_shops_door", "targetname");
  e_hideout_shops_door[0].max_yaw_left = 110;
  level thread function_f285fd7f0e1251fd();
  level thread function_4361584c4d6f869b();
}

function function_40ec157015971a3e(walk_spd) {
  if(!isDefined(walk_spd)) {
    walk_spd = 78;
  }

  if(!isDefined(level.var_c5c98481cf154b0f)) {
    level.var_c5c98481cf154b0f = [];

    if(isDefined(level.ai_hideout_sfo_interior_1)) {
      foreach(var_b8ebcdbcf4a1e531 in level.ai_hideout_sfo_interior_1) {
        if(isDefined(var_b8ebcdbcf4a1e531) && isDefined(var_b8ebcdbcf4a1e531.script_noteworthy) && isalive(var_b8ebcdbcf4a1e531)) {
          switch (var_b8ebcdbcf4a1e531.script_noteworthy) {
            case #"hash_3036e64788d345d0":
            case #"hash_3036e74788d34763":
            case #"hash_3036eb4788d34daf":
            case #"hash_3036ec4788d34f42":
            case #"hash_3036ed4788d350d5":
              level.var_c5c98481cf154b0f = array_add(level.var_c5c98481cf154b0f, var_b8ebcdbcf4a1e531);
              break;
          }
        }
      }
    }
  }

  if(!isDefined(level.var_443c4e804ddb50fe)) {
    level.var_443c4e804ddb50fe = [];
  }

  foreach(var_7752e81b2031e291 in level.var_c5c98481cf154b0f) {
    var_7752e81b2031e291 enableavoidance(0, 0);
    var_7752e81b2031e291 set_movement_speed(walk_spd);
    var_7752e81b2031e291 function_ddde7369b63b3113();
    var_7752e81b2031e291 function_16a594417ddabeb1();
    var_7752e81b2031e291 namespace_fc0114e844f0b4c::function_6323c0b324a46589();
    level.var_443c4e804ddb50fe = array_add(level.var_443c4e804ddb50fe, var_b8ebcdbcf4a1e531);
    var_7752e81b2031e291 function_c1e075c4168a8bea(1, 0);
  }
}

function function_4361584c4d6f869b() {
  level utility::flag_wait("flg_hideout_main_path_corridor02");
  level utility::flag_set("flg_hideout_bathrooms_exit");
  level notify("hideout_bathroom_catchup");
}

function function_2b90e41696e05656() {
  utility::flag_wait("flg_hideout_ab_mid_1");
  array_spawn_function_targetname("ai_hideout_mainhall", &function_2fb6a53b70bebae0);
  var_e399b1e970d88027 = array_spawn_targetname("ai_hideout_mainhall", 1);
  var_d64b3126074735c2 = array_spawn_targetname("ai_hideout_mainhall_turret", 1);
  flag_set("flg_hideout_cqc_mainhall_enemies_spawn");
  var_e399b1e970d88027 = array_combine(var_e399b1e970d88027, var_d64b3126074735c2);
  thread namespace_fc0114e844f0b4c::function_3025ee051d28ec46(var_d64b3126074735c2, "flg_hideout_mainhall_turret_enemies_dead");
  thread namespace_fc0114e844f0b4c::function_3025ee051d28ec46(var_e399b1e970d88027, "flg_hideout_mainhall_enemies_dead");
  thread namespace_f43c40f7bcbe17e7::function_21e9945eedbb7027(var_e399b1e970d88027);
  level thread function_a5146064b8e3f1fa(var_e399b1e970d88027);
}

function function_2fb6a53b70bebae0() {
  self endon("death");
  utility::flag_wait("flg_hideout_bathroom_sneakattack_killed");

  if(isDefined(self.target) && self.target == "n_hideout_turret_sideroom_diagonal") {
    thread function_62b21c7770be3f25();
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mainhall_retreat") {
    set_attackeraccuracy(100);
    self.health = int(max(self.health / 4, 1));
    set_fixednode_false();
    self.balwayscoverexposed = 1;
    vol = getEnt("vol_hideout_shop_2_mg", "targetname");
    self setgoalvolumeauto(vol);
    return;
  }

  vol_retreat = getEnt("vol_hideout_turret_retreat", "targetname");
  self setgoalvolumeauto(vol_retreat);
  set_favoriteenemy(level.player);
}

function function_62b21c7770be3f25() {
  level endon("flg_hideout_main_path_corridor02");
  utility::flag_wait("flg_hideout_bathroom_mid_2");
  var_67efe57a7627df78 = getnode("n_hideout_turret_sideroom_straight", "targetname");
  self setgoalnode(var_67efe57a7627df78);
}

function function_bcded1070897dad8() {}

function function_39b6a972d7acee3f() {
  level endon("flg_hideout_main_path_corridor02");
  flag_wait("flg_hideout_servicehall_start");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level.var_e984af293eec633b = spawn_targetname("ai_hideout_left_path_lmg", 1);
  level.var_e984af293eec633b thread function_aa2b46cb0a21557();
  level.var_e984af293eec633b waittill("death");
  flag_set("flg_hideout_servicehall_enemy_dead");
}

function function_aa2b46cb0a21557() {
  self endon("death");
  self.fixednode = 1;
  set_favoriteenemy(level.ai_soap);
  wait 2.5;
  set_favoriteenemy();
}

function function_f285fd7f0e1251fd() {
  level endon("flg_hideout_mainhall_enemies_dead");
  trg = getEnt("trg_hideout_sidehall_kill_enemies", "targetname");
  trg waittill("trigger");
  utility::flag_set("flg_hideout_main_path_corridor01");
  array_spawn_function_targetname("ai_hideout_flank_into_shop", &function_f02faebcd250cf0b);
  var_9cc7a7f4e7027640 = array_spawn_targetname("ai_hideout_flank_into_shop", 1);
  thread function_44db21fc63549cae();
  thread function_913dd5a181c82342();
  level notify("flank_hall_catchup_kill");
  level.mainhall_turret notify("death");
  flag_set("flg_hideout_turret_force_kill");
}

function function_f02faebcd250cf0b() {
  self endon("death");
  self setthreatbiasgroup("hideout_shops_bonus");
  level waittill("bonus_notice_player");
  self setthreatbiasgroup();

  iprintln("<dev string:x20>");
}

function function_44db21fc63549cae() {
  level endon("flg_hideout_escalator_reached");
  e_hideout_shops_door = getEntArray("e_hideout_shops_door", "targetname");
  e_hideout_shops_door[0] waittill("bashed");

  iprintln("<dev string:x3d>");

  level notify("bonus_notice_player");
  level flag_set("flg_shops_enemies_notice_player");
}

function function_913dd5a181c82342() {
  level endon("flg_hideout_escalator_reached");
  level.player waittill("weapon_fired");

  iprintln("<dev string:x49>");

  level notify("bonus_notice_player");
  level flag_set("flg_shops_enemies_notice_player");
}

function function_a5146064b8e3f1fa(a_enemies) {
  level endon("flg_hideout_mainhall_enemies_dead");
  level waittill("flank_hall_catchup_kill");
  a_enemies = array_removedead_or_dying(a_enemies, 1);

  foreach(enemy in a_enemies) {
    enemy kill();
  }
}

function function_1ddf23fced64a62e() {}

function function_b3a12d0139f837bb() {
  function_3a59e3a15ffbca1();
  level utility::flag_wait("flg_hideout_main_path_corridor02");
  level function_87a70036926b2c90("hideout_cqc_player_progress");
  level thread function_66721c131ee31266();
  level thread function_5c655b748e850db8();
  array_spawn_function_targetname("ai_hideout_shop", &function_abf13289a0695291);
  level.var_a1e59aafd4d3ebb5 = array_spawn_targetname("ai_hideout_shop", 1);
  utility::flag_set("flg_hideout_shops_enemies_spawned");
  level.player setthreatbiasgroup("hideout_shops_player");
  level.ai_soap setthreatbiasgroup("hideout_shops_allies");
  level.var_d18d63c6d75cd1e setthreatbiasgroup("hideout_shops_allies");

  foreach(enemy in level.var_a1e59aafd4d3ebb5) {
    if(isDefined(enemy)) {
      enemy setthreatbiasgroup("hideout_shops_enemies");
    }
  }

  thread function_98c36c3d971b8c69();
  thread function_3025ee051d28ec46(level.var_a1e59aafd4d3ebb5, "flg_shops_enemies_notice_player", 2);
  thread function_3025ee051d28ec46(level.var_a1e59aafd4d3ebb5, "flg_shops_enemies_start_cleanup", 2);
  level thread function_1e5f1dd34ffa00b(level.var_a1e59aafd4d3ebb5);
  level thread function_4714f9998a2de22e();
  thread function_1619889c551a0eb7(level.var_a1e59aafd4d3ebb5);
  level thread function_3025ee051d28ec46(level.var_a1e59aafd4d3ebb5, "flg_hideout_shops_rushers_dead", 4, "flg_hideout_shops_enemies_dead");
  level thread namespace_fc0114e844f0b4c::function_3025ee051d28ec46(level.var_a1e59aafd4d3ebb5, "flg_hideout_shops_enemies_dead");
  level thread function_242d911690e068ac();
  utility::flag_wait("flg_hideout_shop_enemies_cleanup");
  n_hideout_shop_endpath_heroes = utility::getStruct("n_hideout_shop_endpath_heroes", "targetname");
  s_hideout_path_traps_exit_sfo = utility::getStruct("s_hideout_path_traps_exit_sfo", "targetname");
  level.ai_soap thread spawner::go_to_node(n_hideout_shop_endpath_heroes);
  level.var_d18d63c6d75cd1e thread spawner::go_to_node(n_hideout_shop_endpath_heroes);
  utility::flag_set("flg_hideout_escalator_reached");
}

function function_3a59e3a15ffbca1() {
  createthreatbiasgroup("hideout_shops_enemies");
  createthreatbiasgroup("hideout_shops_player");
  createthreatbiasgroup("hideout_shops_allies");
  createthreatbiasgroup("hideout_shops_shields");
  createthreatbiasgroup("hideout_shops_bonus");
  setthreatbias("hideout_shops_enemies", "hideout_shops_player", 1);
  setthreatbias("hideout_shops_enemies", "hideout_shops_allies", 100);
  setthreatbias("hideout_shops_enemies", "hideout_shops_shields", 1000);
  setthreatbias("hideout_shops_bonus", "hideout_shops_player", 1);
  setthreatbias("hideout_shops_bonus", "hideout_shops_allies", 100);
  setthreatbias("hideout_shops_bonus", "hideout_shops_shields", 1000);
  setignoremegroup("hideout_shops_player", "hideout_shops_bonus");
}

function function_4714f9998a2de22e() {
  iprintln("<dev string:x5d>");

  level waittill("shops_enemies_noticed_player");
  level utility::flag_set("flg_hideout_shop_enemies_noticed_player");

  iprintln("<dev string:x7c>");
}

function function_98c36c3d971b8c69() {
  level endon("flg_hideout_finale_rpg_event");
  utility::flag_wait("flg_shops_floodspawn_start");
  level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);

  while(level.ai_hideout_sfo_interior_1.size > 2) {
    wait 1;
    level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);
  }

  var_7531b7eed4fc9300 = getspawnerarray("ai_sfo_hideout_shops_refill");
  array_spawn_function(var_7531b7eed4fc9300, &function_c4da5063b6781022);
  flood_spawn(var_7531b7eed4fc9300);
  utility::flag_wait("flg_hideout_finale_start");
  scripts\sp\spawner::killspawner(10);
}

function function_c4da5063b6781022() {
  level.ai_hideout_sfo_interior_1 = array_add(level.ai_hideout_sfo_interior_1, self);
  level.var_443c4e804ddb50fe = array_add(level.var_443c4e804ddb50fe, self);
  function_ddde7369b63b3113();
  function_16a594417ddabeb1();
  enable_ai_color();
}

function function_abf13289a0695291() {
  thread function_156a007c5510e444();

  switch (self.script_noteworthy) {
    case #"hash_a85153367159c7ba":
      thread function_a0b7524e844a6299();
      break;
    case #"hash_c6d0fb0f2cfe7c68":
      thread function_1ea68c60a878932e();
      level thread function_ab692643417ad6e(self);
      break;
    default:
      break;
  }
}

function function_156a007c5510e444() {
  utility::flag_wait_any("flg_shops_enemies_notice_player", "flg_hideout_main_path_skip_3");
  level notify("shops_enemies_noticed_player");
  setthreatbias("hideout_shops_enemies", "hideout_shops_player", 1000);
}

function function_a0b7524e844a6299() {
  waittill_any_ents(self, "damage", level, "flg_hideout_main_path_skip_3");
  set_fixednode_false();
  retreat_vol = getEnt("vol_hideout_shop_2_mg", "targetname");
  self setgoalvolumeauto(retreat_vol);
}

function function_1ea68c60a878932e() {
  waittill_any_ents(level, "flag_hideout_escalator_reached", level, "shop_distant_retreat");
  retreat_vol = getEnt("vol_lightsout_room_end", "targetname");
  self setgoalvolumeauto(retreat_vol);
}

function function_ab692643417ad6e(ai_enemy) {
  level endon("shop_distant_retreat");
  level endon("flag_hideout_escalator_reached");
  ai_enemy waittill("death");
  level flag_set("shop_distant_retreat");
}

function function_1619889c551a0eb7(var_1c8d5f579c55f58e) {
  utility::flag_wait_any("flg_hideout_shop_endpath", "flg_shops_enemies_start_cleanup");
  level function_87a70036926b2c90("hideout_cqc_player_progress");

  iprintln("<dev string:x9b>");

  var_1c8d5f579c55f58e = array_removedead_or_dying(var_1c8d5f579c55f58e, 1);

  foreach(enemy in var_1c8d5f579c55f58e) {
    enemy set_attackeraccuracy(100);
    enemy set_movement_speed(160);
    enemy.health = int(max(enemy.health / 4, 1));
    enemy set_fixednode_false();
    enemy set_favoriteenemy(level.player);
  }

  utility::flag_set("flg_hideout_shop_enemies_cleanup");
  level endon("flg_hideout_finale_start");
  var_f619858dcce2d7b0 = getEnt("trg_hideout_color_shops2_scripted", "targetname");
  var_f619858dcce2d7b0 notify("trigger");
  var_f85bb4610134653f = getEnt("vol_hideout_shop_enemies_inside", "targetname");

  for(var_1c8d5f579c55f58e = array_removedead_or_dying(var_1c8d5f579c55f58e, 1); var_1c8d5f579c55f58e.size > 0 && var_f85bb4610134653f is_touching_any(var_1c8d5f579c55f58e); var_1c8d5f579c55f58e = array_removedead_or_dying(var_1c8d5f579c55f58e, 1)) {
    wait 1;
  }

  var_f619858dcce2d7b0 = getEnt("trg_hideout_color_shops2_scripted_2", "targetname");
  var_f619858dcce2d7b0 notify("trigger");
}

function function_66721c131ee31266() {
  level utility::flag_wait("flg_hideout_escalator_reached");

  if(!flag("flg_hideout_shop_endpath")) {
    flag_set("flg_hideout_shop_endpath");
  }

  s_hideout_path_shops_exit_soap = utility::getStruct("s_hideout_path_shops_exit_soap", "targetname");
  s_hideout_path_shops_exit_gaz = utility::getStruct("s_hideout_path_shops_exit_gaz", "targetname");
  level.ai_soap utility::clear_movement_speed();
  level.ai_soap spawner::go_to_node(s_hideout_path_shops_exit_soap);
  waitframe();
  level.ai_soap set_force_color("b");
  level.var_d18d63c6d75cd1e utility::clear_movement_speed();
  level.var_d18d63c6d75cd1e spawner::go_to_node(s_hideout_path_shops_exit_gaz);
  waitframe();
  level.var_d18d63c6d75cd1e set_force_color("g");
}

function function_1e5f1dd34ffa00b(var_1c8d5f579c55f58e) {
  level utility::flag_wait_or_timeout("flg_hideout_main_path_skip_3", 90);
  vol_badplace = getEnt("vol_hideout_escalator_enemy_badplace", "targetname");
  createnavbadplacebyent(vol_badplace, "allies", "axis");
  utility::array_spawn_function_targetname("ai_enemy_hideout_escalator", &function_95d3b75d974927ea);
  level.var_e936e3c84ef59410 = utility::array_spawn_targetname("ai_enemy_hideout_escalator", 1);
  level thread function_3025ee051d28ec46(level.var_e936e3c84ef59410, "flg_escalator_enemies_dead");
  var_1c8d5f579c55f58e = array_removedead_or_dying(var_1c8d5f579c55f58e);
  var_83af42ac3069f90e = array_combine(var_1c8d5f579c55f58e, level.var_e936e3c84ef59410);
  level thread function_3025ee051d28ec46(var_83af42ac3069f90e, "flg_shop_and_escalator_enemies_dead");
  wait 10;

  while(!flag("flg_hideout_finale_start")) {
    level.var_e936e3c84ef59410 = array_removedead_or_dying(level.var_e936e3c84ef59410);

    if(level.var_e936e3c84ef59410.size <= 2) {
      flag_set("flg_escalator_enemies_some_dead");
      break;
    }

    wait 1;
  }
}

function function_95d3b75d974927ea() {
  self endon("death");
  demeanor_override("combat");
  disable_pain();
  self enableavoidance(0);
  set_ignoresuppression(1);
  set_ignoreall(1);
  set_attackeraccuracy(0.5);

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "escalator_shooter_1") {
      hideout_escalator_enemy_path_1a();
    }

    if(self.script_noteworthy == "escalator_shooter_2") {
      hideout_escalator_enemy_path_1b();
    }
  }

  vol_lightsout_room_end = getEnt("vol_lightsout_room_end", "targetname");
  self setgoalvolumeauto(vol_lightsout_room_end);
  flag_wait_or_timeout("flg_hideout_escalators_notice_player", 10);
  set_fixednode_false();
  set_ignoresuppression(0);
  set_ignoreall(0);
}

function hideout_escalator_enemy_path_1a() {
  level endon("flg_hideout_escalators_notice_player");
  set_fixednode_true();
  s_path = getStruct("s_hideout_escalator_enemy_path_1a", "targetname");
  scripts\sp\spawner::go_to_node(s_path);
  utility::flag_wait("flg_hideout_escalator_enemy_arrived_1a");
  set_ignoreall(0);
  wait 5;
  set_fixednode_false();
  set_ignoreall(1);
}

function hideout_escalator_enemy_path_1b() {
  level endon("flg_hideout_escalators_notice_player");
  set_fixednode_true();
  wait 1;
  s_path = getStruct("s_hideout_escalator_enemy_path_1b", "targetname");
  scripts\sp\spawner::go_to_node(s_path);
  utility::flag_wait("flg_hideout_escalator_enemy_arrived_1b");
  set_ignoreall(0);
  wait 7;
  flag_set("flg_hideout_escalator_enemies_retreating");
  set_fixednode_false();
  set_ignoreall(1);
}

function function_5c655b748e850db8() {
  utility::flag_wait("flag_hideout_escalator_reached");
  utility::array_spawn_function_targetname("ai_hideout_finale_transition_enemy", &function_5ddcb6fc1ad096e3);
  var_fb8d926c3321a183 = utility::array_spawn_targetname("ai_hideout_finale_transition_enemy", 1);
}

function function_5ddcb6fc1ad096e3() {
  vol_lightsout_room_end = getEnt("vol_lightsout_room_end", "targetname");
  self setgoalvolumeauto(vol_lightsout_room_end);
  set_attackeraccuracy(0.5);
}

function function_d9d85dbf66feef63() {}

function hideout_finale_start() {
  namespace_fc0114e844f0b4c::function_3c4b810d62d1f03f();
  utility::set_start_location("s_start_hideout_finale", utility::array_combine([level.player], level.var_679be75090dd2a47));
  namespace_fc0114e844f0b4c::function_e3a57216f5802c88();
  level thread function_791c2eb990017928();
  function_a92f5fba710994fe();
  level thread function_8ff0eb9963fb04f9();
  level thread function_59460a9e6c862035();

  if(isDefined(level.ai_soap) && isalive(level.ai_soap)) {
    level.ai_soap set_force_color("b");
  }

  if(isDefined(level.var_d18d63c6d75cd1e) && isalive(level.var_d18d63c6d75cd1e)) {
    level.var_d18d63c6d75cd1e set_force_color("g");
  }

  function_199d0b0f24ace63();

  if(!isDefined(level.var_443c4e804ddb50fe)) {
    level.var_443c4e804ddb50fe = [];
  }

  level.var_2b34463b2129b4a3 = array_combine(level.var_443c4e804ddb50fe, level.ai_hideout_sfo_interior_1);
  level.ai_soap function_11f1be76c3f89960();
  level.var_d18d63c6d75cd1e function_11f1be76c3f89960();
  level.ai_soap function_9f82c74eb1b7caf9(1);
  level.var_d18d63c6d75cd1e function_9f82c74eb1b7caf9(1);

  while(!isDefined(level.sentrysettings)) {
    wait 0.1;
  }

  level thread function_242d911690e068ac();
  level.player val::set("no_first_raise", "weapon_first_raise_anims", 0);

  level thread function_c4bed616d3a3036c("<dev string:x1c>");
}

function function_199d0b0f24ace63() {
  if(!isDefined(level.ai_hideout_sfo_interior_1)) {
    level.ai_hideout_sfo_interior_1 = [];
  }

  if(!isDefined(level.var_443c4e804ddb50fe)) {
    level.var_443c4e804ddb50fe = [];
  }

  var_f0919ccf9efcfa05 = getspawnerarray("ai_hideout_sfo_interior_1");
  var_79e4a682ff402623 = getnodearray("n_hideout_finale_wait_escalators", "targetname");
  node_num = 0;

  for(i = 0; i < var_f0919ccf9efcfa05.size; i++) {
    switch (var_f0919ccf9efcfa05[i].script_noteworthy) {
      case #"hash_3036e64788d345d0":
      case #"hash_3036e74788d34763":
      case #"hash_3036eb4788d34daf":
      case #"hash_3036ec4788d34f42":
        ai = var_f0919ccf9efcfa05[i] spawn_ai();
        level.ai_hideout_sfo_interior_1 = array_add(level.ai_hideout_sfo_interior_1, ai);
        level.var_443c4e804ddb50fe = array_add(level.var_443c4e804ddb50fe, ai);
        ai set_force_color("r");
        ai forceteleport(var_79e4a682ff402623[node_num].origin, var_79e4a682ff402623[node_num].angles);
        ai setgoalpos(ai.origin);
        ai set_baseaccuracy(0.4);
        node_num++;
      default:
        break;
    }
  }

  function_40ec157015971a3e(178);
}

function function_619850a3ea621029() {
  level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);

  while(level.ai_hideout_sfo_interior_1.size > 2) {
    wait 1;
    level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);
  }

  var_d486bf3fa17ba5ba = getspawnerarray("ai_sfo_hideout_escalator_refill");
  array_spawn_function(var_d486bf3fa17ba5ba, &function_23f179dd9ca0c2e2);
  flood_spawn(var_d486bf3fa17ba5ba);
  utility::flag_wait("flg_hideout_intel_enter");
  scripts\sp\spawner::killspawner(20);
}

function function_23f179dd9ca0c2e2() {
  level.ai_hideout_sfo_interior_1 = array_add(level.ai_hideout_sfo_interior_1, self);
  level.var_443c4e804ddb50fe = array_add(level.var_443c4e804ddb50fe, self);
  function_ddde7369b63b3113();
  function_16a594417ddabeb1();
}

function function_ee4d03c179ce24c9() {
  function_cfa3b3113cee6fdf();
  thread function_619850a3ea621029();
  function_eb66c89c1f99f182();
  utility::flag_wait("flg_hideout_finale_done");
}

function function_cfa3b3113cee6fdf() {
  createthreatbiasgroup("hideout_finale_enemies");
  createthreatbiasgroup("hideout_finale_player");
  createthreatbiasgroup("hideout_finale_allies");
  setthreatbias("hideout_finale_enemies", "hideout_finale_player", 10000);
  setthreatbias("hideout_finale_enemies", "hideout_finale_allies", 1000);
}

function function_eb66c89c1f99f182() {
  flag_wait_any("flg_hideout_finale_start", "flg_escalator_enemies_dead");
  utility::autosave_by_name("hideout_finale");
  level thread namespace_f43c40f7bcbe17e7::function_4453ef063b49158();
  level thread namespace_f43c40f7bcbe17e7::function_1aad1fb69976739d();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(90, undefined, "flag_hideout_finale_stop_nags", "hideout_finale_player_progress");
  t_throughfare_lightsout = getEnt("t_throughfare_lightsout", "targetname");
  t_hideout_lightson_color_enter = getEnt("t_hideout_lightson_color_enter", "targetname");
  vol_lightsout_waiting_area = getEnt("vol_lightsout_waiting_area", "targetname");
  vol_lightsout_ticket_office = getEnt("vol_lightsout_ticket_office", "targetname");
  vol_lightsout_room_end = getEnt("vol_lightsout_room_end", "targetname");
  vol_lightsout_right_windows = getEnt("vol_lightsout_right_windows", "targetname");
  vol_lightsout_back_windows = getEnt("vol_lightsout_back_windows", "targetname");
  vol_lightsout_office_defend = getEnt("vol_lightsout_office_defend", "targetname");
  vol_lightsout_office_interior = getEnt("vol_lightsout_office_interior", "targetname");
  var_e745f002c24c5045 = getspawnerarray("ai_enemy_lightsout_ground_1");
  var_1fb7de3f2ec48f70 = getspawnerarray("ai_enemy_lightsout_backwindows_1");
  level.var_ec3949787a4605ec = [];
  level.var_47aeb525c7c54b40 = [];
  level thread function_fff1e88d5004e58d();
  level thread hideout_finale_rpg_event();
  level thread function_ec7184756596ec38();
  level thread function_4b6120a5172e4709();
  level thread function_86c463ef18d22ce7();
  level thread function_2da776279daaf9a8();
  level thread function_65a7d5d338783a97();
  level thread function_b2b6692b8eaaea50();
  level thread hideout_finale_stairway_guy_floor_2();
  level thread function_3a408f3d76fadf04();
  level thread hideout_finale_final_guy();
  thread function_19f76835decf1571();
  e_hideout_maintainance_door_r = getEnt("e_hideout_maintainance_door_r", "targetname");
  e_hideout_maintainance_door_r rotateby((0, -120, 0), 0.5);
  level.ai_soap notify("stop_going_to_node");
  level.ai_soap setgoalpos(level.ai_soap.origin, 32);
  level.ai_soap.script_accuracy = 0.25;
  level.var_d18d63c6d75cd1e notify("stop_going_to_node");
  level.var_d18d63c6d75cd1e setgoalpos(level.var_d18d63c6d75cd1e.origin, 32);
  level.var_d18d63c6d75cd1e.script_accuracy = 0.25;

  if(!flag("flg_escalator_enemies_dead")) {
    waittill_any_ents(t_throughfare_lightsout, "trigger", level, "flg_escalator_enemies_dead");
  }

  level function_87a70036926b2c90("hideout_finale_player_progress");
  utility::array_spawn_function(var_1fb7de3f2ec48f70, &function_d848de247ddefd8e);
  var_2640734f7db63ac9 = utility::array_spawn_targetname("ai_enemy_lightsout_backwindows_1", 1);
  wait 1;
  level.var_ec3949787a4605ec = utility::array_removedead_or_dying(level.var_ec3949787a4605ec);
  utility::array_spawn_function(var_e745f002c24c5045, &function_d848de247ddefd8e);
  level.var_42669adfddd23baa = utility::array_spawn_targetname("ai_enemy_lightsout_ground_1", 1);
  level.player setthreatbiasgroup("hideout_finale_player");
  level.var_d18d63c6d75cd1e setthreatbiasgroup("hideout_finale_allies");
  level.ai_soap setthreatbiasgroup("hideout_finale_allies");

  foreach(guy in level.var_42669adfddd23baa) {
    if(isDefined(guy) && isalive(guy)) {
      guy setthreatbiasgroup("hideout_finale_enemies");
    }
  }

  while(level.var_42669adfddd23baa.size > 2) {
    wait 1;
    level.var_42669adfddd23baa = utility::array_removedead_or_dying(level.var_42669adfddd23baa);
  }

  level.var_ec3949787a4605ec = utility::array_removedead_or_dying(level.var_ec3949787a4605ec);
  flag_set("flg_hideout_finale_force_turret_vo");
  wait 4;
  level.var_42669adfddd23baa = utility::array_removedead_or_dying(level.var_42669adfddd23baa);

  foreach(soldier in level.var_42669adfddd23baa) {
    soldier.script_ignore_suppression = 1;
    soldier setgoalvolumeauto(vol_lightsout_office_defend);
  }

  level thread function_39fe1a402b4febad();
  var_8a98ffd9b92b4deb = [];

  if(level.var_47aeb525c7c54b40.size < 6) {
    var_8a98ffd9b92b4deb = utility::array_spawn_function_targetname("ai_hideout_lightson_reinforcement", &function_d848de247ddefd8e);
  }

  level.var_ec3949787a4605ec = utility::array_removedead_or_dying(level.var_ec3949787a4605ec);

  while(level.var_ec3949787a4605ec.size > 3) {
    wait 1;
    level.var_ec3949787a4605ec = utility::array_removedead_or_dying(level.var_ec3949787a4605ec);
  }

  flag_set("flg_hideout_finale_upstairs_enemies_force_spawn");
  waitframe();

  foreach(soldier in level.var_ec3949787a4605ec) {
    soldier cleargoalvolume();
    soldier function_9e8589036c3fd37e(1);
    soldier.aggressivemode = 1;
    soldier.aggressiveblindfire = 1;
  }

  while(level.var_ec3949787a4605ec.size > 0) {
    wait 1;
    level.var_ec3949787a4605ec = utility::array_removedead_or_dying(level.var_ec3949787a4605ec);
  }

  if(!utility::flag("flg_hideout_finale_turret_hacked") && !utility::flag("flg_hideout_finale_turret_destroyed")) {
    level utility::flag_set("flg_hideout_final_room_enemies_clear");
    utility::flag_wait_any("flg_hideout_finale_turret_hacked", "flg_hideout_finale_turret_destroyed");
  }

  level utility::flag_set("flg_hideout_final_room_clear");
  utility::flag_wait("flg_hideout_final_guy_aware");
  function_70926173b60fce4a();
  utility::flag_wait("flg_hideout_office_enemies_dead");
  level utility::flag_set("flg_hideout_finale_done");
  autosave_by_name("hideout_finale_done");
}

function function_fff1e88d5004e58d() {
  level endon("flg_hideout_finale_done");
  flag_wait("flg_hideout_lightson_midpoint_reached");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_finale_player_progress");
  flag_wait("flg_hideout_finale_extra_right");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_finale_player_progress");
}

function function_242d911690e068ac() {
  var_d8552a5a00d4e2d6 = getStruct("s_hideout_finale_turret", "targetname");
  var_d8552a5a00d4e2d6.var_2108ba0559bdaaff = &function_5e66cae8a3e9f368;
  level.finale_turret = setup_enemy_sentry(var_d8552a5a00d4e2d6, undefined, undefined, undefined, undefined, 2560);
  thread function_7f77aed56f51eaf2();
  thread function_a8de8418a329ccfe(level.finale_turret, "flg_finale_turret_dead");
}

function function_7f77aed56f51eaf2() {
  level endon("hideout_interact_evidence_start");
  flag_wait("flg_hideout_final_guy_aware");

  if(!flag("flg_hideout_finale_turret_hacked") && !flag("flg_hideout_finale_turret_destroyed")) {
    level.finale_turret notify("death");
  }
}

function function_a8de8418a329ccfe(turret, var_1bcc95a8574384a4, var_360512653033a442) {
  msg = turret waittill_any_return("death", "hacked");

  if(msg == "hacked") {
    flag_set("flg_hideout_finale_turret_hacked");
  } else {
    flag_set("flg_hideout_finale_turret_destroyed");
  }

  if(isDefined(var_360512653033a442)) {
    var_360512653033a442 = array_removedead_or_dying(var_360512653033a442, 1);

    if(var_360512653033a442.size > 0) {
      foreach(enemy in var_360512653033a442) {
        enemy set_favoriteenemy(level.player);
        enemy set_ignoresuppression(1);
        enemy set_attackeraccuracy(10);
      }
    }

    utility::flag_wait("flg_finale_turret_enemies_dead");
  }

  utility::flag_set(var_1bcc95a8574384a4);
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_finale_player_progress");
}

function hideout_finale_rpg_event() {
  goal_node = getnode("hideout_finale_rpg_guy_node", "targetname");
  rpg_struct = getStruct("s_hideout_finale_rpg_end", "targetname");
  flag_wait_any("flg_hideout_finale_rpg_event", "flg_hideout_finale_upstairs_enemies_force_spawn");
  level function_87a70036926b2c90("hideout_finale_player_progress");

  if(isDefined(level.ai_hideout_sfo_interior_1)) {
    foreach(guy in level.ai_hideout_sfo_interior_1) {
      if(isDefined(guy.magic_bullet_shield)) {
        guy stop_magic_bullet_shield();
      }
    }
  }

  level.var_cad46e1d97b1da87 = spawn_targetname("hideout_finale_rpg_guy", 1);
  level thread function_3025ee051d28ec46([level.var_cad46e1d97b1da87], "flg_hideout_finale_rpg_early_death", 1, "flg_hideout_finale_rpg_fired");
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, level.var_cad46e1d97b1da87);
  waitframe();

  if(isalive(level.var_cad46e1d97b1da87)) {
    level.var_cad46e1d97b1da87 enable_dontevershoot();
    level.var_cad46e1d97b1da87 set_goalRadius(32);
    level.var_cad46e1d97b1da87 set_fixednode_true();
    level.var_cad46e1d97b1da87 setgoalnode(goal_node);
    level.var_cad46e1d97b1da87 set_baseaccuracy(0.6);
    level.var_cad46e1d97b1da87 disable_pain();
    level.var_cad46e1d97b1da87.disablegrenaderesponse = 1;
    level.var_cad46e1d97b1da87.disablebulletwhizbyreaction = 1;
    level.var_cad46e1d97b1da87 waittill("goal");
  } else {
    utility::flag_set("flg_hideout_finale_rpg_early_death");
    return;
  }

  wait 2;

  if(isalive(level.var_cad46e1d97b1da87)) {
    level.var_cad46e1d97b1da87 set_baseaccuracy(0.2);
    level.var_cad46e1d97b1da87 enable_pain();
    level.var_cad46e1d97b1da87.disablegrenaderesponse = 0;
    level.var_cad46e1d97b1da87.disablebulletwhizbyreaction = 0;
  } else {
    utility::flag_set("flg_hideout_finale_rpg_early_death");
    return;
  }

  rpg = magicbullet("iw9_la_rpapa7_sp_ai_straight", level.var_cad46e1d97b1da87.origin + (0, 0, 92), rpg_struct.origin);
  flag_set("flg_hideout_finale_rpg_fired");
  level thread function_3025ee051d28ec46([level.var_cad46e1d97b1da87], "hideout_finale_rpg_enemy_dead", 1, "flg_hideout_final_room_clear");
  rpg waittill("explode", origin);
  radiusdamage(rpg_struct.origin, 150, 80, 50, level.var_cad46e1d97b1da87);
  playrumbleonposition("damage_light", level.player.origin);
  earthquake(0.3, 0.2, level.player.origin, 128);
  flag_set("flg_hideout_finale_rpg_exploded");
  wait 6;

  if(isalive(level.var_cad46e1d97b1da87)) {
    level.var_cad46e1d97b1da87 disable_dontevershoot();
  }
}

function function_837b48186255d277() {
  self endon("entitydeleted");

  while(!is_dead_or_dying(self)) {
    wait 1;
  }

  level flag_set("hideout_finale_rpg_enemy_dead");
}

function function_ec7184756596ec38() {
  level endon("flg_hideout_finale_done");
  vol_initial = getEnt("vol_hideout_finale_initial_lmg_guy", "targetname");
  vol_fallback = getEnt("vol_lightsout_back_windows", "targetname");
  flag_wait_any("flg_hideout_finale_player_on_left", "flg_hideout_finale_player_in_center", "flg_hideout_finale_upstairs_enemies_force_spawn");
  hideout_finale_initial_lmg_guy = spawn_targetname("hideout_finale_initial_lmg_guy", 1);
  hideout_finale_initial_lmg_guy_extra = spawn_targetname("hideout_finale_initial_lmg_guy_extra", 1);
  var_b3cbad8c72813610 = [hideout_finale_initial_lmg_guy, hideout_finale_initial_lmg_guy_extra];
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_initial_lmg_guy);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_initial_lmg_guy_extra);

  if(var_b3cbad8c72813610.size > 0) {
    foreach(enemy in var_b3cbad8c72813610) {
      enemy set_goalRadius(125);
      enemy setgoalvolumeauto(vol_initial);
    }
  } else {
    return;
  }

  flag_wait("flg_hideout_finale_spawn_stairway_guy");
  var_b3cbad8c72813610 = array_removedead_or_dying(var_b3cbad8c72813610);

  if(var_b3cbad8c72813610.size > 0) {
    foreach(enemy in var_b3cbad8c72813610) {
      enemy set_goalRadius(125);
      enemy setgoalvolumeauto(vol_fallback);
    }
  }
}

function function_d848de247ddefd8e() {
  self.grenadeammo = 0;

  if(isDefined(level.var_ec3949787a4605ec)) {
    level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, self);
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "walkway_enemies") {
    level.var_47aeb525c7c54b40 = array_removedead_or_dying(level.var_47aeb525c7c54b40, 1);
    level.var_47aeb525c7c54b40 = array_add(level.var_47aeb525c7c54b40, self);
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "guys_tier_1") {
    self setModel("civ_amsterdam_male_2_2");
    self detach(self.headmodel);
    self attach("head_sc_m_swaynos_bg_civ", "", 1);
    self.headmodel = "head_sc_m_swaynos_bg_civ";
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "guys_tier_1_2") {
    self setModel("body_civ_london_male_4_1");
    self detach(self.headmodel);
    self attach("head_sc_m_perez_bg_civ", "", 1);
    self.headmodel = "head_sc_m_perez_bg_civ";
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "guys_tier_1") {
    self setModel("civ_amsterdam_male_4_1");
    self detach(self.headmodel);
    self attach("head_sp_opforce_grunt_var_03_var_1_civ", "", 1);
    self.headmodel = "head_sp_opforce_grunt_var_03_var_1_civ";
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "guys_tier_1_2") {
    self setModel("civ_amsterdam_male_2_1");
    self detach(self.headmodel);
    self attach("head_sp_civ_var_05_hat_b_civ", "", 1);
    self.headmodel = "head_sp_civ_var_05_hat_b_civ";
  }
}

function function_19f76835decf1571() {
  var_9f34635adcce354f = getEnt("trg_hideout_finale_color_leftpath", "targetname");
  var_7f20593eb29ae30d = getEnt("trg_hideout_finale_color_mid", "targetname");
  var_9f34635adcce354f thread function_41066cac0ba6e7d0(var_7f20593eb29ae30d);
  var_7f20593eb29ae30d thread function_30d5eb97d5545777(var_9f34635adcce354f);
}

function function_41066cac0ba6e7d0(other_trig) {
  other_trig endon("trigger");
  self waittill("trigger");
  other_trig trigger_off();
}

function function_30d5eb97d5545777(other_trig) {
  other_trig endon("trigger");
  self waittill("trigger");
  other_trig trigger_off();
}

function function_4b6120a5172e4709() {
  level endon("flg_hideout_finale_done");
  level endon("flg_hideout_lightson_midpoint_reached");
  level endon("flg_hideout_finale_upstairs_enemies_force_spawn");
  vol_lightsout_ticket_office = getEnt("vol_lightsout_ticket_office", "targetname");
  flag_wait("flg_hideout_finale_spawn_ticketbooth_guy");
  hideout_finale_ticketbooth_guy = spawn_targetname("hideout_finale_ticketbooth_guy", 1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_ticketbooth_guy);
  hideout_finale_ticketbooth_guy endon("death");
  hideout_finale_ticketbooth_guy disable_pain();
  hideout_finale_ticketbooth_guy set_goalRadius(125);
  hideout_finale_ticketbooth_guy setgoalvolumeauto(vol_lightsout_ticket_office);
}

function function_86c463ef18d22ce7() {
  level endon("flg_spawn_final_hideout_guy");
  level endon("flg_hideout_finale_done");
  level endon("flg_hideout_finale_spawn_stairway_guy");
  level endon("flg_hideout_finale_player_on_right");
  var_a8d63f770162c803 = getEnt("vol_lightsout_right_windows", "targetname");
  var_a8d640770162ca36 = getEnt("vol_hideout_finale_floor_1_right_side", "targetname");
  flag_wait_any("flg_hideout_finale_player_on_left", "flg_hideout_finale_upstairs_enemies_force_spawn");
  hideout_finale_player_on_left_extra_enemy_1 = spawn_targetname("hideout_finale_player_on_left_extra_enemy_1", 1);
  hideout_finale_player_on_left_extra_enemy_2 = spawn_targetname("hideout_finale_player_on_left_extra_enemy_2", 1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_player_on_left_extra_enemy_1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_player_on_left_extra_enemy_2);
  hideout_finale_player_on_left_extra_enemy_1 endon("death");
  hideout_finale_player_on_left_extra_enemy_2 endon("death");

  if(isDefined(hideout_finale_player_on_left_extra_enemy_1) && isalive(hideout_finale_player_on_left_extra_enemy_1)) {
    hideout_finale_player_on_left_extra_enemy_1 set_goalRadius(250);
    hideout_finale_player_on_left_extra_enemy_1 setgoalvolumeauto(var_a8d63f770162c803);
  }

  if(isDefined(hideout_finale_player_on_left_extra_enemy_2) && isalive(hideout_finale_player_on_left_extra_enemy_2)) {
    hideout_finale_player_on_left_extra_enemy_2 set_goalRadius(250);

    if(isDefined(var_a8d640770162ca36)) {
      hideout_finale_player_on_left_extra_enemy_2 setgoalvolumeauto(var_a8d640770162ca36);
    }
  }
}

function function_2da776279daaf9a8() {
  level endon("flg_spawn_final_hideout_guy");
  level endon("flg_hideout_finale_done");
  level endon("flg_hideout_finale_spawn_stairway_guy");
  level endon("flg_hideout_finale_player_on_left");
  var_d5707befca53fc92 = getEnt("vol_hideout_finale_floor_1_left_side", "targetname");
  var_d5707aefca53fa5f = getEnt("vol_hideout_finale_right_balcony", "targetname");
  flag_wait_any("flg_hideout_finale_player_on_right", "flg_hideout_finale_upstairs_enemies_force_spawn");
  hideout_finale_player_on_right_extra_enemy_1 = spawn_targetname("hideout_finale_player_on_right_extra_enemy_1", 1);
  hideout_finale_player_on_right_extra_enemy_2 = spawn_targetname("hideout_finale_player_on_right_extra_enemy_2", 1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_player_on_right_extra_enemy_1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_player_on_right_extra_enemy_2);
  hideout_finale_player_on_right_extra_enemy_1 endon("death");
  hideout_finale_player_on_right_extra_enemy_2 endon("death");
  hideout_finale_player_on_right_extra_enemy_1 set_goalRadius(250);
  hideout_finale_player_on_right_extra_enemy_1 setgoalvolumeauto(var_d5707befca53fc92);
  hideout_finale_player_on_right_extra_enemy_2 set_goalRadius(125);
  hideout_finale_player_on_right_extra_enemy_2 setgoalvolumeauto(var_d5707aefca53fa5f);
}

function function_b2b6692b8eaaea50() {
  level endon("flg_spawn_final_hideout_guy");
  level endon("flg_hideout_finale_done");
  level endon("flg_hideout_finale_extra_left_turn_off");
  level endon("flg_hideout_finale_upstairs_enemies_force_spawn");
  vol_hideout_finale_extra_left_1 = getEnt("vol_hideout_finale_extra_left_1", "targetname");
  vol_hideout_finale_extra_left_2 = getEnt("vol_hideout_finale_extra_left_2", "targetname");
  flag_wait("flg_hideout_finale_extra_left");
  hideout_finale_extra_left_guy_1 = spawn_targetname("hideout_finale_extra_left_guy_1", 1);
  hideout_finale_extra_left_guy_2 = spawn_targetname("hideout_finale_extra_left_guy_2", 1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_extra_left_guy_1);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_extra_left_guy_2);
  hideout_finale_extra_left_guy_1 endon("death");
  hideout_finale_extra_left_guy_2 endon("death");
  waitframe();
  hideout_finale_extra_left_guy_1 set_goalRadius(32);
  hideout_finale_extra_left_guy_1 setgoalvolumeauto(vol_hideout_finale_extra_left_1);
  hideout_finale_extra_left_guy_2 set_goalRadius(32);
  hideout_finale_extra_left_guy_2 setgoalvolumeauto(vol_hideout_finale_extra_left_2);
}

function function_65a7d5d338783a97() {
  level endon("flg_hideout_finale_done");
  var_a0382c3c576a62a7 = getEnt("t_hideout_finale_upstairs", "targetname");
  var_a0382c3c576a62a7 waittill("trigger");
  level function_87a70036926b2c90("hideout_finale_player_progress");
  utility::flag_set("flg_hideout_topfloor_reached");
}

function hideout_finale_stairway_guy_floor_2() {
  level endon("flg_hideout_finale_done");

  if(flag("flg_hideout_topfloor_reached")) {
    return;
  }

  level endon("flg_hideout_topfloor_reached");
  vol_hideout_finale_stairway_guy_floor_2 = getEnt("vol_hideout_finale_stairway_guy_floor_2", "targetname");
  n_hide_node = getnode("n_shotgun_hide_node", "targetname");
  hideout_finale_stairway_guy_floor_2 = spawn_targetname("hideout_finale_stairway_guy_floor_2", 1);
  hideout_finale_stairway_guy_floor_2 set_fixednode_true();
  hideout_finale_stairway_guy_floor_2 set_ignoreall(0);
  level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_stairway_guy_floor_2);
  hideout_finale_stairway_guy_floor_2 setgoalnode(n_hide_node);
  hideout_finale_stairway_guy_floor_2 endon("death");
  flag_wait_any("flg_hideout_finale_spawn_stairway_guy", "flg_hideout_finale_upstairs_enemies_force_spawn");
  hideout_finale_stairway_guy_floor_2 set_goalRadius(125);
  hideout_finale_stairway_guy_floor_2 setgoalvolumeauto(vol_hideout_finale_stairway_guy_floor_2);
  hideout_finale_stairway_guy_floor_2 set_ignoreme(0);
  hideout_finale_stairway_guy_floor_2 set_ignoreall(0);
}

function function_3a408f3d76fadf04() {
  level endon("flg_hideout_finale_done");

  if(flag("flg_hideout_ticket_machine_climb_taken")) {
    return;
  }

  level endon("flg_hideout_ticket_machine_climb_taken");
  vol_hideout_finale_extra_right_1 = getEnt("vol_hideout_finale_extra_right_1", "targetname");
  flag_wait_any("flg_hideout_finale_extra_right", "flg_hideout_finale_upstairs_enemies_force_spawn");
  hideout_finale_extra_right_guy_1 = spawn_targetname("hideout_finale_extra_right_guy_1");
  hideout_finale_extra_right_guy_2 = spawn_targetname("hideout_finale_extra_right_guy_2");

  if(isDefined(hideout_finale_extra_right_guy_1)) {
    level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_extra_right_guy_1);
    hideout_finale_extra_right_guy_1 set_goalRadius(250);
    hideout_finale_extra_right_guy_1 setgoalvolumeauto(vol_hideout_finale_extra_right_1);
  }

  if(isDefined(hideout_finale_extra_right_guy_2)) {
    level.var_ec3949787a4605ec = array_add(level.var_ec3949787a4605ec, hideout_finale_extra_right_guy_2);
    hideout_finale_extra_right_guy_2 set_goalRadius(150);
    hideout_finale_extra_right_guy_2 setgoalvolumeauto(vol_hideout_finale_extra_right_1);
  }
}

function function_70926173b60fce4a() {
  foreach(hero in level.var_679be75090dd2a47) {
    hero utility::clear_demeanor_override();
    waitframe();
    hero utility::demeanor_override("sprint");
  }

  s_hideout_finale_postup_soap = getStruct("s_hideout_finale_postup_soap", "targetname");
  s_hideout_finale_postup_gaz = getStruct("s_hideout_finale_postup_gaz", "targetname");
  utility::flag_wait("flg_hideout_office_enemies_dead");

  iprintln("<dev string:xb4>");

  level.ai_soap thread function_74432261549a0c24(s_hideout_finale_postup_soap, "flg_hideout_soap_reached_intel");
  level.var_d18d63c6d75cd1e thread function_74432261549a0c24(s_hideout_finale_postup_gaz, "flg_hideout_gaz_reached_intel");
  level.ai_hideout_sfo_interior_1 = array_removedead_or_dying(level.ai_hideout_sfo_interior_1, 1);

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    sfo clear_colors();
    sfo clear_force_color();
    sfo set_fixednode_true();
  }

  level.player setthreatbiasgroup();
  level.var_d18d63c6d75cd1e setthreatbiasgroup();
  level.ai_soap setthreatbiasgroup();
}

function hideout_finale_final_guy() {
  function_59f84a9745c99015();
  goal_node = getnode("hideout_finale_final_guy_node", "targetname");
  flag_wait("flg_spawn_final_hideout_guy");
  level.var_60635958d622535c = spawn_targetname("hideout_finale_final_guy", 1);
  level.var_18907a70deb3ae0f = array_add(level.var_18907a70deb3ae0f, level.var_60635958d622535c);
  level.var_60635958d622535c thread function_b0db0a57aa02a37e();
  level.var_60635958d622535c thread function_96aa4213b2b53934(1);
  level.var_ec3949787a4605ec array_removedead_or_dying(level.var_ec3949787a4605ec);
  level.var_ec3949787a4605ec = array_combine(level.var_ec3949787a4605ec, level.var_18907a70deb3ae0f);
  level thread function_3025ee051d28ec46(level.var_ec3949787a4605ec, "flg_hideout_office_enemies_dead");
  flag_set("flg_hideout_intel_enemies_spawned");

  foreach(enemy in level.var_18907a70deb3ae0f) {
    level thread function_678ee05eb44c1fb9(enemy, "flag_hideout_office_enemies_visible", "hideout_interact_evidence_complete");
  }

  level.var_60635958d622535c.animname = "generic";
  level.var_60635958d622535c set_deathanim("sdr_com_exp_stand_death01_torso_med_4");
  waitframe();

  if(isDefined(level.var_60635958d622535c) && isalive(level.var_60635958d622535c)) {
    level.var_60635958d622535c set_goalRadius(32);
    level.var_60635958d622535c set_fixednode_true();
    level.var_60635958d622535c setgoalnode(goal_node);
    level.var_60635958d622535c.health = 1;
    level.var_60635958d622535c set_ignoreme(1);
    level.var_60635958d622535c set_ignoreall(1);
  }

  flag_wait("flg_hideout_final_guy_aware");

  if(isDefined(level.var_60635958d622535c) && isalive(level.var_60635958d622535c)) {
    level.var_60635958d622535c set_ignoreme(0);
    level.var_60635958d622535c set_ignoreall(0);
    level.var_60635958d622535c set_favoriteenemy(level.player);
  }
}

function function_59f84a9745c99015() {
  vol_lightsout_office_defend = getEnt("vol_lightsout_office_defend", "targetname");
  var_c1ae9ec912386df0 = getEnt("vol_lightsout_office_interior", "targetname");
  flag_wait("flg_hideout_final_guy_aware");
  ai_hideout_final_intel_enemy_1 = spawn_targetname("ai_hideout_final_intel_enemy_1", 1);
  ai_hideout_final_intel_enemy_2 = spawn_targetname("ai_hideout_final_intel_enemy_2", 1);
  ai_hideout_final_intel_enemy_1 thread function_96aa4213b2b53934(0);
  ai_hideout_final_intel_enemy_2 thread function_96aa4213b2b53934(0);
  level.var_18907a70deb3ae0f = [];
  level.var_18907a70deb3ae0f = array_add(level.var_18907a70deb3ae0f, ai_hideout_final_intel_enemy_1);
  level.var_18907a70deb3ae0f = array_add(level.var_18907a70deb3ae0f, ai_hideout_final_intel_enemy_2);
  ai_hideout_final_intel_enemy_1 endon("death");
  ai_hideout_final_intel_enemy_1 set_goalRadius(250);
  ai_hideout_final_intel_enemy_1 setgoalvolumeauto(vol_lightsout_office_defend);
  ai_hideout_final_intel_enemy_2 set_goalRadius(150);
  ai_hideout_final_intel_enemy_2 setgoalvolumeauto(var_c1ae9ec912386df0);
}

function function_74432261549a0c24(struct, str_flag, demeanor) {
  self endon("death");
  demeanor = default_to(demeanor, "cqb");
  clear_colors();
  clear_force_color();
  set_fixednode_true();
  utility::flag_wait(str_flag);

  if(isDefined(self)) {
    demeanor_override(demeanor);
  }
}

function function_b0db0a57aa02a37e() {
  level.player endon("death");
  level endon("hideout_interact_evidence_start");
  var_53d38520a274620d = self getEye();
  var_eeb8a35f24071b66 = squared(576);
  self waittill("death");
  var_865048328835e385 = utility::within_fov(level.player getEye(), level.player getplayerangles(), var_53d38520a274620d, cos(15));
  var_8386785268b60d5e = distance2dsquared(level.player.origin, var_53d38520a274620d) < var_eeb8a35f24071b66;

  if(var_865048328835e385 && var_8386785268b60d5e) {
    var_d795bfe4371a3f23 = trace::create_world_contents();
    hits = physics_raycast(level.player getEye(), var_53d38520a274620d, var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

    if(isDefined(hits) && hits.size == 0) {
      level utility::flag_set("flg_hideout_finale_player_saw_buyer_die");
    }
  }
}

function function_96aa4213b2b53934(var_5ef8efbbee012729) {
  level.player endon("death");

  if(var_5ef8efbbee012729 == 1) {
    level endon("hideout_interact_evidence_start");
  }

  self waittill("death");
  scripts\anim\shared::detachallweaponmodels();

  if(var_5ef8efbbee012729 == 1) {
    var_53d38520a274620d = self.origin;
    corpse = undefined;
    var_14b9c26fb1bbb890 = 10;

    for(i = 0; i < var_14b9c26fb1bbb890; i++) {
      a_corpses = getcorpsearrayinradius(var_53d38520a274620d, 128);

      if(a_corpses.size > 0) {
        a_corpses = sortbydistance(a_corpses, var_53d38520a274620d);

        if(isDefined(a_corpses[0])) {
          corpse = a_corpses[0];
          break;
        }
      }

      wait 0.5;
    }

    if(!isDefined(corpse)) {
      return;
    }

    corpseorigin = getcorpseorigin(corpse);

    level thread utility::draw_circle_until_notify(corpseorigin, 64, 1, 0, 0, level, "<dev string:xd6>");

    var_f04850fc36886138 = 0;
    var_d1d1fcfc1fac5c9c = 0.5;
    var_eeb8a35f24071b66 = squared(234);
    var_d795bfe4371a3f23 = trace::create_world_contents();
    utility::flag_wait_all("flg_hideout_office_enemies_dead", "flg_hideout_office_intro_vo_complete");

    while(true) {
      var_865048328835e385 = utility::within_fov(level.player getEye(), level.player getplayerangles(), corpseorigin, cos(30));
      var_8386785268b60d5e = distance2dsquared(level.player.origin, corpseorigin) < var_eeb8a35f24071b66;

      if(var_865048328835e385 && var_8386785268b60d5e) {
        hits = physics_raycast(level.player getEye(), corpseorigin, var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

        if(isDefined(hits) && hits.size == 0) {
          var_f04850fc36886138 += 0.1;

          if(var_f04850fc36886138 >= var_d1d1fcfc1fac5c9c) {
            level utility::flag_set("flg_hideout_finale_player_sees_buyer_corpse");
            break;
          }
        } else {
          var_f04850fc36886138 = 0;
        }
      } else {
        var_f04850fc36886138 = 0;
      }

      wait 0.1;
    }
  }
}

function function_12ac0e282e4517c6() {
  utility::flag_set("flg_hideout_finale_done");
}

function function_83160a5df5aa4607() {}

function function_16be1bad30b8579b() {
  namespace_fc0114e844f0b4c::function_3c4b810d62d1f03f();
  utility::set_start_location("s_start_hideout_intel", utility::array_combine([level.player], level.var_679be75090dd2a47));
  namespace_fc0114e844f0b4c::function_e3a57216f5802c88();
  level thread function_8ff0eb9963fb04f9();
  level thread function_791c2eb990017928();
  n_hideout_intel_hero_doorway = getnode("n_hideout_intel_hero_doorway", "targetname");
  level.ai_soap thread spawner::go_to_node(n_hideout_intel_hero_doorway);
  level.var_d18d63c6d75cd1e thread spawner::go_to_node(n_hideout_intel_hero_doorway);
  e_hideout_maintainance_door_r = getEnt("e_hideout_maintainance_door_r", "targetname");
  e_hideout_maintainance_door_r rotateby((0, -90, 0), 0.5);
  thread namespace_b70aaea56eab28ad::scene_0340();
  level flag_set("flg_hideout_intel_enter");
  level flag_set("flg_hideout_office_enemies_dead");
  level flag_set("flg_ready_to_search_office");
  level.player val::set("no_first_raise", "weapon_first_raise_anims", 0);
}

function function_d16344accb85972c() {
  thread namespace_b70aaea56eab28ad::scene_0340();
  utility::autosave_by_name();
  level thread function_4751489da183ff08();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(60, undefined, "flag_hideout_intel_stop_nags", "hideout_intel_player_progress");
  s_inspect_cursor_hint = utility::getStruct("s_inspect_cursor_hint", "targetname");
  s_inspect_cursor_hint cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_SURGE/HIDEOUT_INTEL_INSPECT", undefined, undefined, 50);
  s_inspect_cursor_hint waittill("trigger");
  thread function_69191fdfbf7a2907();
  level.player scripts\sp\player::focusdisable();
  level namespace_fc0114e844f0b4c::function_d962f42ac75f265f("flag_hideout_intel_stop_nags");
  level notify("hideout_intel_scene_begin");
  utility::flag_set("hideout_interact_evidence_start");
  clearallcorpses();
  var_b20317e142c5a445 = getStruct("s_obj_hideout_intel_rally", "targetname");
  level thread function_c01ae6bb604460df(var_b20317e142c5a445.origin, 1600);

  if(isDefined(level.mainhall_turret)) {
    level.mainhall_turret delete();
    level.mainhall_turret = undefined;
  }

  if(isDefined(level.finale_turret)) {
    level.finale_turret delete();
    level.finale_turret = undefined;
  }

  namespace_b70aaea56eab28ad::function_869936d980d8156a();
  level.player player::focusenable();

  if(isDefined(level.var_443c4e804ddb50fe)) {
    level.var_443c4e804ddb50fe = utility::array_removedead_or_dying(level.var_443c4e804ddb50fe, 1);

    foreach(ai in level.var_443c4e804ddb50fe) {
      if(isDefined(ai)) {
        ai delete();
      }
    }
  }

  var_2028491b720b89d1 = getaiarray("allies");

  foreach(sfo in var_2028491b720b89d1) {
    switch (sfo.name) {
      case #"hash_156ffa4f8b089876":
      case #"hash_e9e6926c847ca2cd":
        break;
      default:
        if(isDefined(sfo.magic_bullet_shield)) {
          sfo stop_magic_bullet_shield();
        }

        sfo delete();
        break;
    }
  }

  foreach(ally in level.var_679be75090dd2a47) {
    ally stop_magic_bullet_shield();
    ally delete();
  }

  function_109726d29627f8de();
  utility::flag_set("hideout_breach_office_complete");
}

function function_4751489da183ff08() {
  waitframe();
  utility::transient_load_array(["highspeed_train_patform_cctv_tr", "jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"]);
}

function function_69191fdfbf7a2907() {
  stopmusicstate("mx_surge_hideoutfight");
}

function function_35f84bae2f5016f1() {}

function function_4788a2d1a5d3742a() {
  namespace_fc0114e844f0b4c::function_109726d29627f8de();
  utility::set_start_location("s_start_hideout_igc", utility::array_combine([level.player], level.var_679be75090dd2a47));
  level thread function_791c2eb990017928();
  level flag_set("flg_hideout_intel_enter");
}

function function_eb7ceb3ba1f125b5() {
  waitframe();
  utility::transient_load_array(["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"]);
  wait 2;
  utility::transient_unload_array(["jup_surge_hideout_tr", "highspeed_train_patform_cctv_tr"]);
}

function function_1de99b4a320b0c1b() {
  level thread function_eb7ceb3ba1f125b5();
  utility::flag_set("hideout_interact_evidence_complete");
}

function function_7aed2c96f31f5d42() {}

function function_11f1be76c3f89960(var_331608dcff1805ea) {
  var_331608dcff1805ea = default_to(var_331608dcff1805ea, "combat");
  namespace_fc0114e844f0b4c::function_60e33f7446b138d3(1);
  namespace_fc0114e844f0b4c::function_6323c0b324a46589();
  utility::demeanor_override("combat");
  self enableavoidance(1, 0);
  function_c1e075c4168a8bea(1, 0);
  self.allowstrafe = 0;
  set_goalRadius(32);
}

function function_fd88f465904eaab1(turret, var_1bcc95a8574384a4, var_360512653033a442) {
  thread function_f52848295af311e5();
  msg = turret waittill_any_return("death", "hacked");

  if(msg == "hacked") {
    flag_set("flg_mainhall_turret_hacked");
  } else {
    flag_set("flg_mainhall_turret_destroyed");
  }

  if(isDefined(var_360512653033a442)) {
    var_360512653033a442 = array_removedead_or_dying(var_360512653033a442, 1);

    if(var_360512653033a442.size > 0) {
      foreach(enemy in var_360512653033a442) {
        enemy set_favoriteenemy(level.player);
        enemy set_ignoresuppression(1);
        enemy set_attackeraccuracy(10);
      }
    }

    utility::flag_wait("flg_hideout_mainhall_turret_enemies_dead");
  }

  utility::flag_set(var_1bcc95a8574384a4);
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("hideout_cqc_player_progress");
}

function function_c47f54c5194f6843(turret, str_flag) {
  turret endon("death");
  str_flag = default_to(str_flag, "flg_hideout_shop_endpath");
  utility::flag_wait(str_flag);
  utility::flag_set("flg_hideout_mainhall_turret_enemies_dead");
  turret notify("death");
}

function function_f52848295af311e5() {
  level endon("flg_hideout_finale_start");
  utility::flag_wait("flg_hideout_main_path_corridor00");
  level.ai_soap disable_ai_color();

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    sfo disable_ai_color();
  }

  utility::flag_wait_any("flg_mainhall_turret_dead", "flg_hideout_shop_endpath");
  level.ai_soap enable_ai_color();

  foreach(sfo in level.ai_hideout_sfo_interior_1) {
    sfo enable_ai_color();
  }
}

function function_144bc428a1e72842(navobstacleid) {
  utility::flag_wait("flg_hideout_escalators_spawn");
  destroynavobstacle(navobstacleid);
}

function function_5ff5bbe55d13626c() {
  level.player endon("death");
  level endon("hideout_intel_scene_begin");
  level thread namespace_f43c40f7bcbe17e7::function_79d20beee276e4d5();

  while(true) {
    level.player waittill("grenade_fire", grenade, weapon);

    if(weapon.basename == "smoke") {
      flag_set("flg_hideout_smoke_grenade_thrown");
      grenade waittill("explode", grenadeorigin);
      thread function_32c6b113cc58e5c5(grenadeorigin);
      thread create_smoke_occluder(grenadeorigin);
    }
  }
}

function create_smoke_occluder(origin) {
  iprintln("<dev string:xf6>");

  occluder = spawn("script_model", origin);
  occluder setModel("ainosight256x256x256");
  occluder show();
  origin = occluder gettagorigin("tag_origin");
  wait 1;
  occluder setmovertransparentvolume();
  wait 8.75;

  iprintln("<dev string:x10d>");

  occluder delete();
  flag_clear("flg_hideout_smoke_grenade_thrown");
}

function function_32c6b113cc58e5c5(grenadeorigin) {
  level endon("flg_hideout_final_room_clear");
  var_90a4fe9e40b23401 = [level.ai_soap, level.var_d18d63c6d75cd1e];

  if(flag("flg_hideout_finale_start")) {
    flag_clear("flg_hideout_smoke_occluder_close_to_allies");
    flag_clear("flg_hideout_smoke_occluder_behind_allies");
    level.ai_soap function_6b1cbfddeed3a337(grenadeorigin);
    level.var_d18d63c6d75cd1e function_6b1cbfddeed3a337(grenadeorigin);

    if(!flag("flg_hideout_smoke_occluder_behind_allies")) {
      array_sorted = sortbydistancecullbyradius(var_90a4fe9e40b23401, grenadeorigin, 600);

      if(array_sorted.size > 0) {
        flag_set("flg_hideout_smoke_occluder_close_to_allies");
      }
    }
  }
}

function function_6b1cbfddeed3a337(origin) {
  if(!self aipointinfov(origin)) {
    flag_set("flg_hideout_smoke_occluder_behind_allies");
  }
}

function function_5aad5fe0b662028b() {}

function function_687bdc8fd9b36887() {
  utility::set_goalRadius(256);
  utility::set_fixednode_false();
  self enableavoidance(0, 0);
  self.script_accuracy = 0.25;
  namespace_fc0114e844f0b4c::function_6323c0b324a46589();
}

function function_9314ecf5202373a1() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 256;
  function_c1e075c4168a8bea(1, 0);
  self.allowstrafe = 0;
  self enableavoidance(0);
  thread function_ddde7369b63b3113();
}

function function_a92f5fba710994fe() {
  level.var_65008a2b14e076b8 = [];
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Aparece";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Arditti";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Barajas";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Barding";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Bello";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Biglang-awa";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Blalack";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Brown";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Carbonero";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Castelo";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Castro";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Chen";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Cheng";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Chevrin";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Clinton";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Connary";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Couturier";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Cravens";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Daly";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Dos Santos";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Doss";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Enriquez";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Etienne";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Flores";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Graham";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Gran";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Guayaquil";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Hansen";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Hart";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Johnston";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kaplow";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kennedy";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kilkenny";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kirtlink";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kit";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kline";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Kritzon";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Krolak";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Liu";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Martini";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Mika";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Mulkiewicz";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Nguyen";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Ondoy";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Osorio";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Paldino";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Poprik";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Power";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Raghavan";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Rench";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Richter";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Rodgers";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Roper";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Santos";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Shields";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Singh";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Staines";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Stebbing";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Torgeson";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Takasawa";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Tung";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Turchik";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Uhler";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Waszak";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Weyna";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Wou";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Yun";
  level.var_65008a2b14e076b8[level.var_65008a2b14e076b8.size] = "Zhang";
  level.var_65008a2b14e076b8 = utility::array_randomize(level.var_65008a2b14e076b8);

  foreach(index, lastname in level.var_65008a2b14e076b8) {
    var_387d74da0b65b21a = "Cdt. Guy+Alpha 7-1";

    switch (index) {
      case 0:
        var_387d74da0b65b21a = "Capt. " + level.var_65008a2b14e076b8[index] + "+Mike 0-6";
        break;
      case 1:
        var_387d74da0b65b21a = "Lt. " + level.var_65008a2b14e076b8[index] + "+Mike 0-7";
        break;
      case 2:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Mike 0-5";
        break;
      case 3:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Mike 7-1";
        break;
      case 4:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Mike 7-2";
        break;
      case 5:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Mike 7-3";
        break;
      case 6:
        var_387d74da0b65b21a = "Capt. " + level.var_65008a2b14e076b8[index] + "+Hotel 0-6";
        break;
      case 7:
        var_387d74da0b65b21a = "Lt. " + level.var_65008a2b14e076b8[index] + "+Hotel 0-7";
        break;
      case 8:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Hotel 0-5";
        break;
      case 9:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Hotel 7-1";
        break;
      case 10:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Hotel 7-2";
        break;
      case 11:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Hotel 7-3";
        break;
      case 12:
        var_387d74da0b65b21a = "Capt. " + level.var_65008a2b14e076b8[index] + "+Sierra 0-6";
        break;
      case 13:
        var_387d74da0b65b21a = "Lt. " + level.var_65008a2b14e076b8[index] + "+Sierra 0-7";
        break;
      case 14:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Sierra 0-5";
        break;
      case 15:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Sierra 7-1";
        break;
      case 16:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Sierra 7-2";
        break;
      case 17:
        var_387d74da0b65b21a = "Sgt. " + level.var_65008a2b14e076b8[index] + "+Sierra 7-3";
        break;
      default:
        ranks = ["Cdt. ", "Cdt. ", "Cdt. ", "Sgt. "];
        ranks = utility::array_randomize(ranks);
        squads = ["Hotel", "Mike", "Sierra"];
        squads = utility::array_randomize(squads);
        var_9089c505a2edd85 = ["0", "1", "2", "3", "4"];
        var_9089c505a2edd85 = utility::array_randomize(var_9089c505a2edd85);
        var_546e3e58f8125d51 = ["1", "2", "3", "4", "5", "6"];
        var_546e3e58f8125d51 = utility::array_randomize(var_546e3e58f8125d51);
        var_387d74da0b65b21a = ranks[0] + level.var_65008a2b14e076b8[index] + "+" + squads[0] + " " + var_9089c505a2edd85[0] + "-" + var_546e3e58f8125d51[0];
        break;
    }

    level.var_65008a2b14e076b8[index] = var_387d74da0b65b21a;
  }

  level.var_888219acc4d50c4d = 0;
}

function function_ddde7369b63b3113() {
  info = level.var_65008a2b14e076b8[level.var_888219acc4d50c4d];
  a_info = strtok(info, "+");
  utility::set_name(a_info[0]);
  utility::function_ab35ae296c8f8609(a_info[1]);
  level.var_888219acc4d50c4d++;

  if(level.var_888219acc4d50c4d >= 64) {
    level.var_888219acc4d50c4d = 0;
  }
}