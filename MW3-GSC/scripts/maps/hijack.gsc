/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack.gsc
**************************************/

main() {
  maps\createart\hijack_art::main();
  maps\hijack_fx::main();
  maps\hijack_aud::main();
  maps\hijack_anim::main();
  maps\hijack_precache::main();
  _id_56FB();
  _id_5A62();
  _id_5A64();
  maps\_utility::_id_26A9("airplane");
  maps\_utility::_id_1E74("airplane", maps\hijack_airplane::_id_5A5E);
  maps\_utility::_id_1E74("debate", maps\hijack_airplane::_id_5A5F);
  maps\_utility::_id_1E74("pre_zero_g", maps\hijack_airplane::_id_5A60);
  maps\_utility::_id_1E74("lower_level_combat", maps\hijack_airplane::_id_5A61);
  maps\_utility::_id_1E74("crash", maps\hijack_crash::_id_5A15);
  maps\_utility::_id_1E74("tarmac", maps\hijack_tarmac::_id_59D6);
  maps\_utility::_id_1E74("tarmac_2", maps\hijack_tarmac::_id_59DA);
  maps\_utility::_id_1E74("post_tarmac", maps\hijack_script_2b::_id_59C1);
  maps\_utility::_id_1E74("end_scene", maps\hijack_script_2c::_id_5998);
  _id_1109();
}

_id_56FB() {
  precacheitem("flash_grenade");
  precacheitem("armory_grenade");
  precacheitem("rpg_straight");
  precacheitem("ak74u");
  precacheitem("ak74u_zero_g");
  precacheitem("ak47_acog");
  precacheitem("fnfiveseven");
  precacheitem("fnfiveseven_zero_g");
  precacheshader("overlay_frozen");
  precachemodel("electronics_pda");
  precachemodel("viewhands_fso");
  precachemodel("viewhands_player_fso");
}

_id_5A62() {
  maps\hijack_airplane::_id_5A63();
  maps\hijack_crash::_id_5A18();
  maps\hijack_tarmac::_id_59DC();
  common_scripts\utility::flag_init("stop_rocking");
  common_scripts\utility::flag_init("stop_turbulence");
  common_scripts\utility::flag_init("in_flight");
  common_scripts\utility::flag_init("pause_inflight_fx");
  common_scripts\utility::flag_init("pause_tarmac_fx");
  common_scripts\utility::flag_init("start_tarmacend_combat");
  common_scripts\utility::flag_init("tarmac_combat_wave2");
  common_scripts\utility::flag_init("tarmac_combat_wave3");
  common_scripts\utility::flag_init("tarmac_combat_wave4");
  common_scripts\utility::flag_init("endguys_dead");
}

_id_5A64() {
  maps\hijack_tarmac::_id_59DD();
}

_id_1109() {
  maps\_load::main();
  precacheshellshock("hijack_airplane");
  precacheshellshock("hijack_minor");
  precacheshellshock("hijack_slowview");
  precacheshellshock("default");
  precacheshellshock("dcburning");
  precacheshellshock("hijack_door_explosion");
  precacheshellshock("hijack_engine_explosion");
  precacheshellshock("hijack_tail_explosion");
  precacheshellshock("hijack_end_scene");
  precacherumble("hijack_plane_low");
  precacherumble("hijack_plane_medium");
  precacherumble("hijack_plane_large");
  maps\_utility::_id_265A("axis");
  maps\_utility::_id_265A("allies");
  thread maps\_utility::set_vision_set("hijack_airplane", 1);
  level._id_5A65 = getent("player_debate_trigger", "script_noteworthy");
  level._id_5A65 common_scripts\utility::trigger_off();
  level._id_5A66 = getent("player_debate_trigger_b", "script_noteworthy");
  level._id_5A66 common_scripts\utility::trigger_off();
  level._id_5A67 = getent("debate_laptop_off", "targetname");
  level._id_5A67 hide();

  if(getDvar("airmasks") == "") {
    setDvar("airmasks", "1");
  }
  maps\_flare::main("tag_flash");
  maps\_drone_ai::init();
  level.friendlyfire["enemy_kill_points"] = 3;
  level.friendlyfire["friend_kill_points"] = -1000;
  level.player setweaponammostock("fnfiveseven", 60);
  level._id_5A68 = getDvar("phys_gravity");
  level._id_5A69 = getDvar("phys_gravity_ragdoll");
  level._id_5A6A = getDvar("phys_gravityChangeWakeupRadius");
  level._id_5A6B = getDvar("ragdoll_max_life");
  level._id_5A6C = (-14, 114, 0);
  level._id_5960 = getent("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level._id_5960);
  level._id_5961 = [];
  level._id_5961 = maps\_utility::_id_0BC3(level._id_5961, level._id_5960);
  level._id_5A6D = getEntArray("conf_light_off", "targetname");
  common_scripts\utility::array_call(level._id_5A6D, ::hide);
  common_scripts\utility::array_call(level._id_5A6D, ::notsolid);
  var_0 = getEntArray("airmask", "targetname");
  common_scripts\utility::array_thread(var_0, maps\hijack_code::_id_5969);
  level._id_5A6E = getEntArray("seatbelt_signs", "targetname");
  common_scripts\utility::array_call(level._id_5A6E, ::hide);
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "snow");
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "ice");
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "slush");
  var_1 = getent("commander", "script_noteworthy");
  var_1 maps\_utility::add_spawn_function(::_id_5A80);
  var_2 = getent("commander_tarmac", "script_noteworthy");
  var_2 maps\_utility::add_spawn_function(::_id_5A80);
  var_3 = getent("advisor", "script_noteworthy");
  var_3 maps\_utility::add_spawn_function(::_id_5A81);
  var_4 = getent("advisor_tarmac", "script_noteworthy");
  var_4 maps\_utility::add_spawn_function(::_id_5A81);
  var_5 = getent("president", "script_noteworthy");
  var_5 maps\_utility::add_spawn_function(::_id_5A82);
  var_6 = getent("president_tarmac", "script_noteworthy");
  var_6 maps\_utility::add_spawn_function(::_id_5A82);
  var_7 = getent("find_daughter_pre_crash", "targetname");
  var_7 maps\_utility::add_spawn_function(::_id_59E1);
  var_8 = getent("hero_agent_01", "script_noteworthy");
  var_8 maps\_utility::add_spawn_function(::_id_5A85);
  var_9 = getent("zerog_agent_01", "script_noteworthy");
  var_9 maps\_utility::add_spawn_function(::_id_5A86);
  var_10 = getent("zerog_agent_02", "script_noteworthy");
  var_10 maps\_utility::add_spawn_function(::_id_5A88);
  var_11 = getent("crash_agent_1", "script_noteworthy");
  var_11 maps\_utility::add_spawn_function(::_id_5A8A);
  maps\_utility::_id_27CA("pre_zerog_terrorists", ::_id_5A8C);
  maps\_utility::_id_27CB("terrorists", maps\hijack_code::_id_45E4);
  level._id_5976 = getEntArray("hijack_crash_plane_model", "targetname");
  thread _id_5A8D();
  thread _id_5A77();
  thread _id_5A75();
  thread _id_5A7A();
  thread _id_5A76();
  thread _id_5A6F();
  thread _id_5A93();
  thread _id_5A70();
  thread _id_5A72();
  thread _id_5A73();
  thread _id_5A74();
  thread maps\_shg_fx::_id_445E(400, "fx_crash_trench_fire");
  thread maps\_shg_fx::_id_445E(410, "fx_hangar_combat_area");
  thread maps\_shg_fx::_id_445E(420, "fx_final_area");
}

_id_5A6F() {
  var_0 = getent("hjk_red_light_pulsing0", "targetname");
  var_1 = getent("hjk_red_light_pulsing1", "targetname");
  var_2 = getent("hjk_red_light_pulsing2", "targetname");
  var_3 = getent("hjk_red_light_pulsing3", "targetname");
  var_0 thread maps\hijack_code::_id_5970(0);
  var_1 thread maps\hijack_code::_id_5970(1);
  var_2 thread maps\hijack_code::_id_5970(2);
  var_3 thread maps\hijack_code::_id_5970(3);
}

_id_5A17() {
  var_0 = getent("cloud_tunnel", "targetname");
  var_1 = common_scripts\utility::getfx("cloud_tunnel");
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("generic_prop_raven");
  var_3 = var_2.origin;
  common_scripts\utility::flag_set("in_flight");

  for(;;) {
    common_scripts\utility::flag_wait("in_flight");
    common_scripts\utility::flag_set("pause_tarmac_fx");
    playFXOnTag(var_1, var_2, "tag_origin");
    var_2.origin = var_3;
    common_scripts\utility::flag_waitopen("in_flight");
    var_2.origin = var_3 - (0, 0, 100000);
  }
}

_id_5A70() {
  var_0 = [];
  var_0 = maps\_utility::_id_2695("window_volumetric");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("conference_room_smoke"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("banner_fire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("hijack_potlight_volumetric"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("hijack_iris_volumetric"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("aircraft_light_white_blink"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("aircraft_light_wingtip_green"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("aircraft_light_wingtip_red"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_inflight_fx");

    foreach(var_2 in level._id_5A71) {
      stopFXOnTag(common_scripts\utility::getfx("window_volumetric"), var_2, "tag_origin");
      stopFXOnTag(common_scripts\utility::getfx("window_volumetric_open"), var_2, "tag_origin");
    }

    foreach(var_5 in var_0) {}
    var_5 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_inflight_fx");

    foreach(var_5 in var_0) {}
    var_5 maps\_utility::_id_1655();
  }
}

_id_5A72() {
  var_0 = [];
  var_0 = maps\_utility::_id_2695("after_math_embers");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("horizon_fireglow"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("interior_ceiling_smoke"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("interior_ceiling_smoke2"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("interior_ceiling_smoke3"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("hijack_firelp_med_pm"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("firelp_large_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("hijack_megafire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("fire_trail_60"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("firelp_med_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("banner_fire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("banner_fire_nodrip"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("firelp_small_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("powerline_runner_cheap_hijack"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("field_fire_distant2"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("plane_gash_volumetric"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_tarmac_fx");

    foreach(var_2 in var_0) {}
    var_2 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_tarmac_fx");

    foreach(var_2 in var_0) {}
    var_2 maps\_utility::_id_1655();
  }
}

_id_5A73() {
  var_0 = [];
  var_0 = maps\_utility::_id_2695("banner_fire");
  var_1 = [];
  var_1 = maps\_utility::_id_2695("airplane_crash_embers");
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("hijack_firelp_huge_pm_nolight"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("trench_glow"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("fire_trail_60"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_fuselage_fire_fx");

    foreach(var_3 in var_0) {}
    var_3 maps\_utility::_id_1655();

    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_fuselage_fire_fx");

    foreach(var_3 in var_0) {}
    var_3 common_scripts\utility::pauseeffect();

    foreach(var_3 in var_1) {}
    var_3 maps\_utility::_id_1655();
  }
}

_id_5A74() {
  var_0 = [];
  var_1 = [];
  var_1 = maps\_utility::_id_2695("powerline_runner");
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("powerline_runner_cheap"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("interior_ceiling_smoke"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("interior_ceiling_smoke2"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::_id_2695("interior_ceiling_smoke3"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_wreckage_interior_fx");

    foreach(var_3 in var_0) {}
    var_3 maps\_utility::_id_1655();

    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_wreckage_interior_fx");

    foreach(var_3 in var_0) {}
    var_3 common_scripts\utility::pauseeffect();

    foreach(var_3 in var_1) {}
    var_3 maps\_utility::_id_1655();
  }
}

_id_5A75() {
  level._id_5967 = [];
  level._id_5967["trash_cup_short1"] = 1;
  level._id_5967["hjk_vodka_glass"] = 0.5;
  level._id_5967["hjk_vodka_glass_lrg"] = 0.5;
  level._id_5967["trash_bottle_whisky"] = 0.5;
  level._id_5967["cs_coffeemug02_static"] = 0.1;
  level._id_5967["ma_salt_shaker_1"] = 0.1;
  level._id_5967["ma_restaurant_plate_01"] = 5;
  level._id_5967["hjk_ashtray"] = 5;
  level._id_5967["hjk_napkin_1"] = 5;
  level._id_5967["hjk_napkin_2"] = 5;
  level._id_5967["newspaper_folded_static"] = 5;
  level._id_5967["cs_vodkabottle01"] = 3;
  level._id_5967["trash_bottle_wine"] = 3;
  level._id_5967["hjk_metal_pitcher"] = 6;
  level._id_5967["bo_p_glo_beer_bottle01_world"] = 3;
  level._id_5967["hjk_laptop_closed"] = 1;
  level._id_5967["ap_luggage02"] = 1;
  level._id_5967["ap_luggage03"] = 1;
  level._id_5967["me_banana"] = 0.5;
  level._id_5967["me_fruit_orange"] = 0.5;
  level._id_5967["me_fruit_mango_green"] = 0.5;
  level._id_5967["me_fruit_mango_redorange"] = 0.5;
}

_id_5A76() {
  var_0 = getEntArray("disable_during_crash", "script_noteworthy");
  var_1 = getent("tarmac_backtrack_trigger", "script_noteworthy");

  foreach(var_3 in var_0) {}
  var_3 common_scripts\utility::trigger_off();

  var_1 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_on_feet_post_crash");

  foreach(var_3 in var_0) {}
  var_3 common_scripts\utility::trigger_on();

  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1 common_scripts\utility::trigger_on();
}

_id_5A77() {
  wait 0.1;
  level._id_5A78 = [];
  level._id_5A71 = [];
  level._id_5A79 = getEntArray("god_ray_emitter", "targetname");

  foreach(var_1 in level._id_5A79) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;

    if(var_1.script_noteworthy == "window_volumetric_open") {
      playFXOnTag(common_scripts\utility::getfx("window_volumetric_open"), var_2, "tag_origin");
    } else {
      playFXOnTag(common_scripts\utility::getfx("window_volumetric"), var_2, "tag_origin");
    }
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_2 linkto(var_3);
    level._id_5A71[level._id_5A71.size] = var_2;
    level._id_5A78[level._id_5A78.size] = var_3;
  }

  level._id_5961 = common_scripts\utility::array_combine(level._id_5961, level._id_5A78);
  level notify("volumetrics_setup");
}

_id_5A7A() {
  for(;;) {
    anim._id_0D6C = gettime() + 300000;
    wait 60;
  }
}

_id_5A7B() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  maps\_utility::_id_0D04();
  maps\hijack_code::_id_45E4();
  maps\_utility::_id_1058(1);
}

_id_5A7C() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      if(isDefined(self._id_0D04)) {
        maps\_utility::_id_1902();
        self.allowdeath = 1;

        if(self != level._id_58BA) {
          self._id_0D45 = _id_5A7E();
          continue;
        }

        self._id_0D45 = _id_5A7D();
      }
    }
  }
}

_id_5A7D() {
  setDvar("ui_deadquote", &"HIJACK_MISSIONFAIL_PRESIDENT");
  thread maps\_utility::_id_1826();
}

_id_5A7E() {
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  thread maps\_utility::_id_1826();
}

_id_5A7F() {
  thread _id_5A7B();
  self._id_1032 = "generic";
  maps\_utility::_id_24F5();
}

_id_5A80() {
  thread _id_5A7B();
  level._id_58D2 = self;
  level._id_58D2._id_59C3 = 1;
  level._id_58D2._id_1032 = "commander";
}

_id_59E1() {
  thread _id_5A7B();
  level._id_59E0 = self;
  self._id_1032 = "daughter";
}

_id_5A81() {
  thread _id_5A7B();
  level._id_58C6 = self;
  level._id_58C6._id_59C3 = 1;
  level._id_58C6._id_1032 = "advisor";
  level._id_58C6 maps\_utility::_id_24F5();
}

_id_5A82() {
  thread _id_5A7B();
  level._id_58BA = self;
  level._id_58BA._id_59C3 = 1;
  level._id_58BA._id_1032 = "president";
  level._id_58BA._id_408A = 1;
  level._id_58BA maps\hijack_anim::_id_5A83();
  wait 0.1;
  level._id_58BA notify("disable_combat_state_check");
  self._id_10C3 = maps\hijack_anim::_id_5A84;
  level._id_58BA thread _id_5A7C();
}

_id_5A85() {
  thread _id_5A7B();
  level._id_58CB = self;
  level._id_58CB thread _id_5A7C();
}

_id_5A86() {
  thread _id_5A7B();
  level._id_5A87 = self;
  self._id_1032 = "agent1";
  self.fixednode = 1;
  self.goalradius = 16;
  maps\_utility::_id_109B();
  self.ignoresuppression = 1;
  self._id_20AF = 0.1;
}

_id_5A88() {
  thread _id_5A7B();
  level._id_5A89 = self;
  self._id_1032 = "agent2";
  self.fixednode = 1;
  self.goalradius = 16;
  maps\_utility::_id_109B();
  self.ignoresuppression = 1;
  self._id_20AF = 0.1;
}

_id_5A8A() {
  thread _id_5A7B();
  level._id_5A8B = self;
  maps\_utility::_id_13A4("c");
  self._id_1032 = "crash_agent1";
  self._id_59C3 = 1;
}

_id_5A8C() {
  thread maps\_utility::_id_0D04();
}

_id_5A8D() {
  level endon("planecrash_approaching");
  _id_5A8E();

  for(;;) {
    common_scripts\utility::flag_clear("show_crash_model");
    common_scripts\utility::flag_wait("show_crash_model");
    _id_5A8F();
    common_scripts\utility::flag_clear("hide_crash_model");
    common_scripts\utility::flag_wait("hide_crash_model");
    _id_5A8E();
  }
}

_id_5A8E() {
  common_scripts\utility::array_call(level._id_5976, ::hide);
  common_scripts\utility::array_call(level._id_5976, ::notsolid);
}

_id_5A8F() {
  common_scripts\utility::array_call(level._id_5976, ::show);

  if(!isDefined(level._id_5A90)) {
    var_0 = common_scripts\utility::getstruct("hijack_plane_crash_model_origin", "targetname");

    foreach(var_2 in level._id_5976) {}
    var_2.origin = var_0.origin;

    level._id_5A90 = 1;
  }

  common_scripts\utility::array_call(level._id_5976, ::solid);
}

_id_5A91() {
  var_0 = getEntArray("turbine", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread _id_5A92();
}

_id_5A92() {
  var_0 = maps\_utility::_id_1287("turbines");
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 maps\_anim::_id_11CF(var_0, "engine_turbine_spin");
  self linkto(var_0, "J_prop_1");
  var_0 thread maps\_anim::_id_124E(var_0, "engine_turbine_spin_loop", "kill_turbines");
  common_scripts\utility::flag_wait("stop_phones");
  var_0 notify("kill_turbines");
  waittillframeend;
  var_0 delete();
  self delete();
}

_id_5A93() {
  var_0 = common_scripts\utility::getstruct("heli_end_node", "targetname");
  level._id_59A4 = getEntArray("heli_interior", "targetname");

  foreach(var_2 in level._id_59A4) {
    var_2 hide();
    var_2 notsolid();
  }

  level._id_59A5 = getEntArray("hijack_blurcard_ending", "targetname");

  foreach(var_5 in level._id_59A5) {}
  var_5 hide();
}