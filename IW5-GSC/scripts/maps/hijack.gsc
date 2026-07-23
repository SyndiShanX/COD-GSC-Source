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
  level_precache();
  level_init_flags();
  level_init_assets();
  maps\_utility::set_default_start("airplane");
  maps\_utility::add_start("airplane", maps\hijack_airplane::start_airplane);
  maps\_utility::add_start("debate", maps\hijack_airplane::start_debate);
  maps\_utility::add_start("pre_zero_g", maps\hijack_airplane::start_pre_zero_g);
  maps\_utility::add_start("lower_level_combat", maps\hijack_airplane::start_lower_level_combat);
  maps\_utility::add_start("crash", maps\hijack_crash::start_crash);
  maps\_utility::add_start("tarmac", maps\hijack_tarmac::start_tarmac);
  maps\_utility::add_start("tarmac_2", maps\hijack_tarmac::start_tarmac_2);
  maps\_utility::add_start("post_tarmac", maps\hijack_script_2b::start_post_tarmac);
  maps\_utility::add_start("end_scene", maps\hijack_script_2c::start_end_scene);
  setup();
}

level_precache() {
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

level_init_flags() {
  maps\hijack_airplane::airplane_init_flags();
  maps\hijack_crash::crash_init_flags();
  maps\hijack_tarmac::tarmac_init_flags();
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

level_init_assets() {
  maps\hijack_tarmac::tarmac_init_assets();
}

setup() {
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
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  thread maps\_utility::set_vision_set("hijack_airplane", 1);
  level.debate_trigger = getEnt("player_debate_trigger", "script_noteworthy");
  level.debate_trigger common_scripts\utility::trigger_off();
  level.debate_trigger_b = getEnt("player_debate_trigger_b", "script_noteworthy");
  level.debate_trigger_b common_scripts\utility::trigger_off();
  level.debate_laptop_off = getEnt("debate_laptop_off", "targetname");
  level.debate_laptop_off hide();

  if(getDvar("airmasks") == "") {
    setDvar("airmasks", "1");
  }
  maps\_flare::main("tag_flash");
  maps\_drone_ai::init();
  level.friendlyfire["enemy_kill_points"] = 3;
  level.friendlyfire["friend_kill_points"] = -1000;
  level.player setweaponammostock("fnfiveseven", 60);
  level.orig_phys_gravity = getDvar("phys_gravity");
  level.orig_ragdoll_gravity = getDvar("phys_gravity_ragdoll");
  level.orig_wakeupradius = getDvar("phys_gravityChangeWakeupRadius");
  level.orig_ragdoll_life = getDvar("ragdoll_max_life");
  level.orig_sundirection = (-14, 114, 0);
  level.org_view_roll = getEnt("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level.org_view_roll);
  level.arollers = [];
  level.arollers = maps\_utility::array_add(level.arollers, level.org_view_roll);
  level.conf_lights_off = getEntArray("conf_light_off", "targetname");
  common_scripts\utility::array_call(level.conf_lights_off, ::hide);
  common_scripts\utility::array_call(level.conf_lights_off, ::notsolid);
  var_0 = getEntArray("airmask", "targetname");
  common_scripts\utility::array_thread(var_0, maps\hijack_code::airmask_setup);
  level.seatbeltsigns = getEntArray("seatbelt_signs", "targetname");
  common_scripts\utility::array_call(level.seatbeltsigns, ::hide);
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "snow");
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "ice");
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "slush");
  var_1 = getEnt("commander", "script_noteworthy");
  var_1 maps\_utility::add_spawn_function(::setup_commander);
  var_2 = getEnt("commander_tarmac", "script_noteworthy");
  var_2 maps\_utility::add_spawn_function(::setup_commander);
  var_3 = getEnt("advisor", "script_noteworthy");
  var_3 maps\_utility::add_spawn_function(::setup_advisor);
  var_4 = getEnt("advisor_tarmac", "script_noteworthy");
  var_4 maps\_utility::add_spawn_function(::setup_advisor);
  var_5 = getEnt("president", "script_noteworthy");
  var_5 maps\_utility::add_spawn_function(::setup_president);
  var_6 = getEnt("president_tarmac", "script_noteworthy");
  var_6 maps\_utility::add_spawn_function(::setup_president);
  var_7 = getEnt("find_daughter_pre_crash", "targetname");
  var_7 maps\_utility::add_spawn_function(::setup_daughter);
  var_8 = getEnt("hero_agent_01", "script_noteworthy");
  var_8 maps\_utility::add_spawn_function(::setup_hero_agent_01);
  var_9 = getEnt("zerog_agent_01", "script_noteworthy");
  var_9 maps\_utility::add_spawn_function(::setup_zerog_agent_01);
  var_10 = getEnt("zerog_agent_02", "script_noteworthy");
  var_10 maps\_utility::add_spawn_function(::setup_zerog_agent_02);
  var_11 = getEnt("crash_agent_1", "script_noteworthy");
  var_11 maps\_utility::add_spawn_function(::setup_crash_agent_1);
  maps\_utility::array_spawn_function_targetname("pre_zerog_terrorists", ::temp_bullet_shield);
  maps\_utility::array_spawn_function_noteworthy("terrorists", maps\hijack_code::no_grenades);
  level.crash_models = getEntArray("hijack_crash_plane_model", "targetname");
  thread manage_tail_models();
  thread setup_volumetric_lights();
  thread setup_object_mass();
  thread no_grenade_death_hack();
  thread setup_tarmac_triggers();
  thread setup_hijack_specific_lights();
  thread setup_end_heli_interior();
  thread pause_inflight_fx();
  thread pause_tarmac_fx();
  thread pause_fuselage_fire_fx();
  thread pause_wreckage_interior_fx();
  thread maps\_shg_fx::_id_445E(400, "fx_crash_trench_fire");
  thread maps\_shg_fx::_id_445E(410, "fx_hangar_combat_area");
  thread maps\_shg_fx::_id_445E(420, "fx_final_area");
}

setup_hijack_specific_lights() {
  var_0 = getEnt("hjk_red_light_pulsing0", "targetname");
  var_1 = getEnt("hjk_red_light_pulsing1", "targetname");
  var_2 = getEnt("hjk_red_light_pulsing2", "targetname");
  var_3 = getEnt("hjk_red_light_pulsing3", "targetname");
  var_0 thread maps\hijack_code::hjk_red_light_pulsing(0);
  var_1 thread maps\hijack_code::hjk_red_light_pulsing(1);
  var_2 thread maps\hijack_code::hjk_red_light_pulsing(2);
  var_3 thread maps\hijack_code::hjk_red_light_pulsing(3);
}

setup_cloud_tunnel() {
  var_0 = getEnt("cloud_tunnel", "targetname");
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

pause_inflight_fx() {
  var_0 = [];
  var_0 = maps\_utility::getfxarraybyid("window_volumetric");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("conference_room_smoke"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("banner_fire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("hijack_potlight_volumetric"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("hijack_iris_volumetric"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("aircraft_light_white_blink"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("aircraft_light_wingtip_green"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("aircraft_light_wingtip_red"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_inflight_fx");

    foreach(var_2 in level.volumetric_window_fx_ents) {
      stopFXOnTag(common_scripts\utility::getfx("window_volumetric"), var_2, "tag_origin");
      stopFXOnTag(common_scripts\utility::getfx("window_volumetric_open"), var_2, "tag_origin");
    }

    foreach(var_5 in var_0) {}
    var_5 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_inflight_fx");

    foreach(var_5 in var_0) {}
    var_5 maps\_utility::restarteffect();
  }
}

pause_tarmac_fx() {
  var_0 = [];
  var_0 = maps\_utility::getfxarraybyid("after_math_embers");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("horizon_fireglow"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke2"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke3"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("hijack_firelp_med_pm"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("firelp_large_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("hijack_megafire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("fire_trail_60"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("firelp_med_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("banner_fire"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("banner_fire_nodrip"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("firelp_small_pm_nolight"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("powerline_runner_cheap_hijack"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("field_fire_distant2"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("plane_gash_volumetric"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_tarmac_fx");

    foreach(var_2 in var_0) {}
    var_2 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_tarmac_fx");

    foreach(var_2 in var_0) {}
    var_2 maps\_utility::restarteffect();
  }
}

pause_fuselage_fire_fx() {
  var_0 = [];
  var_0 = maps\_utility::getfxarraybyid("banner_fire");
  var_1 = [];
  var_1 = maps\_utility::getfxarraybyid("airplane_crash_embers");
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("hijack_firelp_huge_pm_nolight"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("trench_glow"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("fire_trail_60"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_fuselage_fire_fx");

    foreach(var_3 in var_0) {}
    var_3 maps\_utility::restarteffect();

    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_fuselage_fire_fx");

    foreach(var_3 in var_0) {}
    var_3 common_scripts\utility::pauseeffect();

    foreach(var_3 in var_1) {}
    var_3 maps\_utility::restarteffect();
  }
}

pause_wreckage_interior_fx() {
  var_0 = [];
  var_1 = [];
  var_1 = maps\_utility::getfxarraybyid("powerline_runner");
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("powerline_runner_cheap"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("interior_ceiling_smoke"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("interior_ceiling_smoke2"));
  var_1 = common_scripts\utility::array_combine(var_1, maps\_utility::getfxarraybyid("interior_ceiling_smoke3"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_wreckage_interior_fx");

    foreach(var_3 in var_0) {}
    var_3 maps\_utility::restarteffect();

    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_wreckage_interior_fx");

    foreach(var_3 in var_0) {}
    var_3 common_scripts\utility::pauseeffect();

    foreach(var_3 in var_1) {}
    var_3 maps\_utility::restarteffect();
  }
}

setup_object_mass() {
  level.objectmass = [];
  level.objectmass["trash_cup_short1"] = 1;
  level.objectmass["hjk_vodka_glass"] = 0.5;
  level.objectmass["hjk_vodka_glass_lrg"] = 0.5;
  level.objectmass["trash_bottle_whisky"] = 0.5;
  level.objectmass["cs_coffeemug02_static"] = 0.1;
  level.objectmass["ma_salt_shaker_1"] = 0.1;
  level.objectmass["ma_restaurant_plate_01"] = 5;
  level.objectmass["hjk_ashtray"] = 5;
  level.objectmass["hjk_napkin_1"] = 5;
  level.objectmass["hjk_napkin_2"] = 5;
  level.objectmass["newspaper_folded_static"] = 5;
  level.objectmass["cs_vodkabottle01"] = 3;
  level.objectmass["trash_bottle_wine"] = 3;
  level.objectmass["hjk_metal_pitcher"] = 6;
  level.objectmass["bo_p_glo_beer_bottle01_world"] = 3;
  level.objectmass["hjk_laptop_closed"] = 1;
  level.objectmass["ap_luggage02"] = 1;
  level.objectmass["ap_luggage03"] = 1;
  level.objectmass["me_banana"] = 0.5;
  level.objectmass["me_fruit_orange"] = 0.5;
  level.objectmass["me_fruit_mango_green"] = 0.5;
  level.objectmass["me_fruit_mango_redorange"] = 0.5;
}

setup_tarmac_triggers() {
  var_0 = getEntArray("disable_during_crash", "script_noteworthy");
  var_1 = getEnt("tarmac_backtrack_trigger", "script_noteworthy");

  foreach(var_3 in var_0) {}
  var_3 common_scripts\utility::trigger_off();

  var_1 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_on_feet_post_crash");

  foreach(var_3 in var_0) {}
  var_3 common_scripts\utility::trigger_on();

  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1 common_scripts\utility::trigger_on();
}

setup_volumetric_lights() {
  wait 0.1;
  level.volumetric_window_fx = [];
  level.volumetric_window_fx_ents = [];
  level.godrays = getEntArray("god_ray_emitter", "targetname");

  foreach(var_1 in level.godrays) {
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
    var_2 linkTo(var_3);
    level.volumetric_window_fx_ents[level.volumetric_window_fx_ents.size] = var_2;
    level.volumetric_window_fx[level.volumetric_window_fx.size] = var_3;
  }

  level.arollers = common_scripts\utility::array_combine(level.arollers, level.volumetric_window_fx);
  level notify("volumetrics_setup");
}

no_grenade_death_hack() {
  for(;;) {
    anim.nextcornergrenadedeathtime = gettime() + 300000;
    wait 60;
  }
}

setup_common_hijack_features() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  maps\_utility::magic_bullet_shield();
  maps\hijack_code::no_grenades();
  maps\_utility::setflashbangimmunity(1);
}

player_damage_to_friendlies() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      if(isDefined(self.magic_bullet_shield)) {
        maps\_utility::stop_magic_bullet_shield();
        self.allowdeath = 1;

        if(self != level.president) {
          self.deathfunction = agent_death();
          continue;
        }

        self.deathfunction = civilian_death();
      }
    }
  }
}

civilian_death() {
  setDvar("ui_deadquote", &"HIJACK_MISSIONFAIL_PRESIDENT");
  thread maps\_utility::missionfailedwrapper();
}

agent_death() {
  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  thread maps\_utility::missionfailedwrapper();
}

setup_generic_script_guy() {
  thread setup_common_hijack_features();
  self.animname = "generic";
  maps\_utility::gun_remove();
}

setup_commander() {
  thread setup_common_hijack_features();
  level.commander = self;
  level.commander.notarget = 1;
  level.commander.animname = "commander";
}

setup_daughter() {
  thread setup_common_hijack_features();
  level.daughter = self;
  self.animname = "daughter";
}

setup_advisor() {
  thread setup_common_hijack_features();
  level.advisor = self;
  level.advisor.notarget = 1;
  level.advisor.animname = "advisor";
  level.advisor maps\_utility::gun_remove();
}

setup_president() {
  thread setup_common_hijack_features();
  level.president = self;
  level.president.notarget = 1;
  level.president.animname = "president";
  level.president.force_civilian_stand_run = 1;
  level.president maps\hijack_anim::president_setup_anims();
  wait 0.1;
  level.president notify("disable_combat_state_check");
  self.pathturnanimoverridefunc = maps\hijack_anim::president_setup_turn_anims_override;
  level.president thread player_damage_to_friendlies();
}

setup_hero_agent_01() {
  thread setup_common_hijack_features();
  level.hero_agent_01 = self;
  level.hero_agent_01 thread player_damage_to_friendlies();
}

setup_zerog_agent_01() {
  thread setup_common_hijack_features();
  level.zerog_agent_01 = self;
  self.animname = "agent1";
  self.fixednode = 1;
  self.goalradius = 16;
  maps\_utility::enable_cqbwalk();
  self.ignoresuppression = 1;
  self.baseaccuracy = 0.1;
}

setup_zerog_agent_02() {
  thread setup_common_hijack_features();
  level.zerog_agent_02 = self;
  self.animname = "agent2";
  self.fixednode = 1;
  self.goalradius = 16;
  maps\_utility::enable_cqbwalk();
  self.ignoresuppression = 1;
  self.baseaccuracy = 0.1;
}

setup_crash_agent_1() {
  thread setup_common_hijack_features();
  level.crash_agent_1 = self;
  maps\_utility::set_force_color("c");
  self.animname = "crash_agent1";
  self.notarget = 1;
}

temp_bullet_shield() {
  thread maps\_utility::magic_bullet_shield();
}

manage_tail_models() {
  level endon("planecrash_approaching");
  hide_tail_models();

  for(;;) {
    common_scripts\utility::flag_clear("show_crash_model");
    common_scripts\utility::flag_wait("show_crash_model");
    show_tail_models();
    common_scripts\utility::flag_clear("hide_crash_model");
    common_scripts\utility::flag_wait("hide_crash_model");
    hide_tail_models();
  }
}

hide_tail_models() {
  common_scripts\utility::array_call(level.crash_models, ::hide);
  common_scripts\utility::array_call(level.crash_models, ::notsolid);
}

show_tail_models() {
  common_scripts\utility::array_call(level.crash_models, ::show);

  if(!isDefined(level.setup_crash_models)) {
    var_0 = common_scripts\utility::getStruct("hijack_plane_crash_model_origin", "targetname");

    foreach(var_2 in level.crash_models) {}
    var_2.origin = var_0.origin;

    level.setup_crash_models = 1;
  }

  common_scripts\utility::array_call(level.crash_models, ::solid);
}

setup_turbines() {
  var_0 = getEntArray("turbine", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread turbine_anim();
}

turbine_anim() {
  var_0 = maps\_utility::spawn_anim_model("turbines");
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_0, "engine_turbine_spin");
  self linkTo(var_0, "J_prop_1");
  var_0 thread maps\_anim::anim_loop_solo(var_0, "engine_turbine_spin_loop", "kill_turbines");
  common_scripts\utility::flag_wait("stop_phones");
  var_0 notify("kill_turbines");
  waittillframeend;
  var_0 delete();
  self delete();
}

setup_end_heli_interior() {
  var_0 = common_scripts\utility::getStruct("heli_end_node", "targetname");
  level.heli_interior = getEntArray("heli_interior", "targetname");

  foreach(var_2 in level.heli_interior) {
    var_2 hide();
    var_2 notsolid();
  }

  level.end_cards = getEntArray("hijack_blurcard_ending", "targetname");

  foreach(var_5 in level.end_cards) {}
  var_5 hide();
}