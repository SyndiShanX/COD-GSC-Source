/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\youngblood_code.gsc
*****************************************************/

deer_fade_in() {
  level.player freezecontrols(1);
  setsaveddvar("hud_showstance", 0);
  common_scripts\utility::waitframe();
  level.player setclienttriggeraudiozone("youngblood_forest_start", 2.0);
  level.player setblurforplayer(10, 0);
  setsaveddvar("cg_fov", 35);
  common_scripts\utility::flag_set("campfire_start");
  wait 0.5;
  level.player freezecontrols(0);
  thread maps\_hud_util::fade_in(4);
  common_scripts\utility::waitframe();
  level.player setblurforplayer(0, 2);
  level.player enableslowaim();
  level.player lerpfov(65, 12);
  wait 3;
  level.elias maps\youngblood_util::init_jog_animset();
  level.hesh maps\youngblood_util::init_hesh_animset();
  level.hesh.uphill = 1;
  level.hesh maps\youngblood_util::init_uphill_walk_animset();
  level.elias maps\youngblood_util::init_uphill_jog_animset();
  level.hesh.goalradius = 128;
  level.elias.goalradius = 128;
  level.hesh.goalheight = 256;
  level.elias.goalheight = 256;
  level.hesh maps\_utility::enable_arrivals();
  level.elias maps\_utility::enable_arrivals();
  level.hesh maps\_utility::disable_exits();
  level.elias maps\_utility::disable_exits();
  level.hesh.dontchangepushplayer = 1;
  level.elias.dontchangepushplayer = 1;
  level.elias.pushable = 0;
  level.hesh.pushable = 0;
  level.hesh.pushplayer = 1;
  level.elias.pushplayer = 1;
  level.hesh pushplayer(1);
  level.elias pushplayer(1);
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_elias"), 0);
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_hesh"), 200);
}

deer() {
  maps\_hud_util::start_overlay("black");
  thread maps\_art::sunflare_changes("default", 0);
  maps\_utility::vision_set_fog_changes("", 0);

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.player setviewmodel("viewhands_gs_hostage_clean");
    level.scr_model["player_rig"] = "viewhands_player_gs_hostage_clean";
  }

  level.player_on_hill = 0;
  level.nointerrupt = 0;
  level.player.ignoreme = 1;
  level.player.ignoreall = 1;
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowmelee(0);
  level.player_location_vfx = "vfx_yb_onplayer_01_deer";
  level.player thread vfx_on_player_location_to_odin();
  level.player switchtoweapon("noweapon_youngblood+yb_state_hill");
  thread maps\youngblood_util::yb_player_speed_percent(40);
  thread deer_fade_in();
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel(level.hesh.model);
  var_1.animname = "player_body";
  var_1 maps\_anim::setanimtree();
  level.player playerlinktoabsolute(var_0, "tag_player");
  common_scripts\utility::flag_wait("campfire_start");
  level.player common_scripts\utility::delaycall(1, ::playerlinktodelta, var_0, "tag_player", 1, 20, 20, 20, 20);
  var_2 = common_scripts\utility::get_target_ent("intro_scene_ref_pos");
  thread distant_boom_sound();
  var_2 thread maps\_anim::anim_single_run([level.elias], "campfire");
  var_2 thread maps\_anim::anim_single_run([level.hesh], "campfire");
  var_2 maps\_anim::anim_single([var_0, var_1], "campfire");
  common_scripts\utility::flag_set("yb_intro_plr_unlink");
  var_1 delete();
  var_0 hide();
  level.player unlink();
  level.player disableslowaim();
  var_0 delete();
  level.player allowcrouch(1);
  level.player allowprone(1);
  setsaveddvar("hud_showstance", 1);
}

distant_boom_sound() {
  level.hesh waittillmatch("single anim", "distant_boom");
  var_0 = anglestoright(level.player.angles);
  var_0 = var_0 * 50000;
  thread common_scripts\utility::play_sound_in_space("yb_rog_distant_design_campfire", (6437, -109503, -116473));
}

after_hunt() {
  var_0 = getEntArray("trigger_multiple", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_prefab_exploder) && var_2.script_prefab_exploder == "deer_hut_tremor_a") {
      var_2 delete();
      break;
    }
  }

  common_scripts\utility::flag_wait("new_start_after_hunt");
  level.hesh.anim_blend_time_override = 0.3;
  level.elias.anim_blend_time_override = 0.3;
  wait 0.5;
  level.player allowsprint(0);
  thread common_scripts\utility::play_sound_in_space("scn_quake_01", level.player.origin);
  wait 0.5;
  thread maps\youngblood_util::heroes_light_earthquake(33);
  level.hesh maps\_utility::delaythread(0.5, maps\_utility::smart_dialogue, "youngblood_hsh_woahlittletremorthere");
  level.hesh thread maps\_anim::anim_generic_gravity(level.hesh, "youngblood_hesh_walk_tremor");
  level.elias maps\youngblood_util::init_elias_animset();
  level.hesh maps\youngblood_util::init_hesh_animset();
  level.elias maps\_utility::enable_exits();
  level.elias maps\_utility::enable_arrivals();
  level.hesh maps\_utility::enable_exits();
  level.hesh maps\_utility::enable_arrivals();
  wait 1;
  level.hesh.goalradius = 200;
  level.hesh thread hesh_uphill(common_scripts\utility::get_target_ent("ah_path_hesh_2"));
  level.hesh thread uphill_stopanims("youngblood_hesh_walk_turn_45_l");
  level.hesh thread uphill_anim_flagset("youngblood_hesh_walk_2_tremor_2_run", "new_treefall", 0.5);
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_hesh_2"), 300);
  wait 1;
  level.elias.goalradius = 200;
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_elias_2"), 600);
  wait 0.5;
  level.elias thread maps\_utility::smart_dialogue("youngblood_els_hehthosethingsusedto");
  common_scripts\utility::flag_wait("ah_tremor_2");
  common_scripts\utility::exploder("deer_hut_tremor_a");
  thread maps\youngblood_util::heroes_light_earthquake(40);
  thread common_scripts\utility::play_sound_in_space("scn_quake_02", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("scn_quake_02_debris_01", (5999, -108103, -116150));
  thread common_scripts\utility::play_sound_in_space("scn_quake_02_debris_02", (6071, -107813, -116045));
  thread common_scripts\utility::play_sound_in_space("scn_quake_02_debris_03", (6344, -107850, -116153));
  thread common_scripts\utility::exploder("exp02");
  thread after_hunt_dialogue();
}

hesh_uphill(var_0) {
  var_0 waittill("trigger");
  self.uphill = 1;
  thread maps\_anim::anim_generic_gravity(self, "youngblood_hesh_walk_uphill_2_IN");

  switch (level.woods_movement) {
    case "walk":
      thread maps\youngblood_util::init_uphill_walk_animset();
      break;
    case "jog":
      thread maps\youngblood_util::init_uphill_jog_animset();
      break;
  }
}

uphill_stopanims(var_0) {
  self waittillmatch("starting_anim", var_0);
  var_1 = getanimlength(maps\_utility::getanim_generic(var_0));
  wait(var_1 - 0.2);
  self notify("custom_animmode", "stop anim");
}

uphill_anim_flagset(var_0, var_1, var_2) {
  self waittillmatch("starting_anim", var_0);
  common_scripts\utility::flag_set(var_1);

  if(isDefined(var_2)) {
    self.anim_blend_time_override = var_2;
    self waittill("finished_custom_animmode" + var_0);
    self.anim_blend_time_override = undefined;
  }
}

after_hunt_dialogue() {
  wait 1;
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_anotherone");
  wait 0.7;
  level.elias maps\_utility::smart_dialogue("youngblood_els_wellgetacouple");
  wait 2.5;
  maps\_utility::autosave_by_name_silent("woods");
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_windsstartintopick");
}

woods() {
  common_scripts\utility::flag_wait("new_treefall");
  thread common_scripts\utility::play_sound_in_space("scn_quake_03", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_debris_04", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_debris_01", (5883, -107667, -115970));
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_debris_02", (6229, -107426, -115996));
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_debris_03", (5944, -107160, -115972));
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_log_roll_left", (5664, -107490, -115973));
  thread common_scripts\utility::play_sound_in_space("scn_quake_03_log_roll_right", (5819, -107295, -115973));
  thread wood_sfx_trees_mvmt_begin_upper_forest();
  maps\_utility::add_extra_autosave_check("close_to_hesh", maps\youngblood_util::check_close_to_hesh, "too far from hesh");
  maps\_utility::autosave_by_name_silent("woods");
  thread maps\youngblood_util::neighborhood_fail_if_too_far();
  maps\_utility::music_play("mus_prlog_intro_quakes");
  level.woods_movement = "jog";
  level.elias maps\youngblood_util::init_jog_animset_alert();
  level.hesh maps\youngblood_util::init_jog_animset_alert();
  level.elias maps\youngblood_util::set_move_rate(1);
  level.hesh maps\youngblood_util::set_move_rate(0.9);
  level.elias.goalradius = 256;
  level.elias.goalheight = 256;
  level.hesh.goalradius = 256;
  level.elias.goalheight = 256;
  maps\_utility::activate_trigger_with_noteworthy("treefall");
  level.player_location_vfx = "vfx_yb_onplayer_02_trunkroll";
  thread common_scripts\utility::exploder("exp04");
  maps\_utility::activate_trigger_with_noteworthy("deer_hill_tremor_a_trigger");
  thread common_scripts\utility::exploder("evilclouds");
  wait 0.5;
  thread maps\youngblood_util::heavy_quake(50);
  level.elias thread maps\_anim::anim_generic(level.elias, "hijack_generic_stumble_stand2");
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("fence_pos_elias"), 0);
  wait 1.5;
  level.elias common_scripts\utility::delaycall(0.0, ::stopanimscripted);
  wait 0.5;
  level.elias maps\_utility::enable_arrivals();
  level.elias maps\_utility::enable_exits();
  level thread deer_stampede_logic();
  level thread woods_hesh_halt_run();
  thread woods_dialogue();
  common_scripts\utility::flag_wait("deer_stampede");
  wait 1.8;
  level.elias maps\youngblood_util::set_move_rate(1.1);
  level.hesh.goalradius = 128;
  level.elias.goalradius = 128;
  level.hesh thread maps\youngblood_util::yb_follow_path_and_animate(common_scripts\utility::get_target_ent("fence_pos_hesh"), 200);
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("fence_pos_elias"), 0);
  level.elias maps\_utility::enable_arrivals();
  wait 0.4;
  level.hesh maps\youngblood_util::set_move_rate(1);
  level.hesh maps\_utility::enable_arrivals();
  level.hesh maps\_utility::enable_exits();
  thread maps\youngblood_util::flashes_on_player();
}

wood_sfx_trees_mvmt_begin_upper_forest() {
  self endon("player_near_mansion_exit");
  var_0 = (5978, -107002, -115769);
  var_1 = (5676, -106512, -115646);
  var_2 = (5204, -106268, -115505);
  var_3 = (5158, -107261, -115709);
  var_4 = (5068, -106911, -115623);
  var_5 = (4852, -106711, -115441);
  var_6 = [var_0, var_1, var_2, var_3, var_4, var_5];
  wait 0.5;

  for(;;) {
    var_7 = common_scripts\utility::random(var_6);
    thread common_scripts\utility::play_sound_in_space("emt_yb_foliage_debris", var_7);
    var_8 = randomfloatrange(2.0, 4.0);
    wait(var_8);
  }
}

woods_dialogue() {
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_dad");
  level.player setclienttriggeraudiozone("youngblood_forest_upper", 2.0);
  level.player allowsprint(1);
  level.elias thread maps\_utility::smart_dialogue("youngblood_els_letsjustgetto");
  maps\_utility::trigger_wait_targetname("hint_sprint_trigger");
  maps\_utility::display_hint("hint_sprint");
}

woods_hesh_halt_run() {
  wait 0.6;
  level.hesh maps\youngblood_util::yb_follow_path_and_animate(common_scripts\utility::get_target_ent("deer_event_hesh"), 0);
}

neighborhood() {
  thread n_sound_cars();
  thread common_scripts\utility::exploder("exp06");
  common_scripts\utility::flag_wait("start_neighborhood");
  wait 0.5;
  maps\_utility::music_stop(30);
  thread town_car();
  thread maps\youngblood_util::rog_strikes();
  wait 0.5;
  level.player thread maps\_utility::play_sound_on_entity("scn_quake_05");
  level.elias maps\_utility::disable_exits();
  thread n_hesh_stumble_and_path();
  level.elias thread enable_exit_on_notify("youngblood_hesh_calm_idle_2_tremor_2_run");
  thread maps\youngblood_util::heavy_quake(72);
  level.elias thread maps\_anim::anim_generic_gravity(level.elias, "youngblood_hesh_calm_idle_2_tremor_2_run");
  level.elias maps\youngblood_util::init_run_animset_alert();
  wait 0.75;
  common_scripts\utility::flag_wait("player_near_fence");
  level.elias.turnrate = 0.15;
  level.hesh.turnrate = 0.15;
  level.elias maps\youngblood_util::set_move_rate(1.03);
  level.hesh maps\youngblood_util::set_move_rate(1.03);
  level.elias.goalradius = 128;
  level.hesh maps\_utility::enable_arrivals();
  level.elias maps\_utility::enable_arrivals();
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("1_street_pos_elias"), 0);
  level.elias pushplayer(1);
  level.hesh pushplayer(1);
  level.player_location_vfx = "vfx_yb_onplayer_03_afterfence";
  thread n_vehicle_2();
  thread n_watchers();
  thread n_door_knock();
  thread n_walla();
  var_0 = getent("town_sedan", "targetname");
  var_0 thread neighborhood_vehicle_delete();
}

n_walla() {
  common_scripts\utility::flag_wait("load_car_2");
  var_0 = (3800, -105493, -115324);
  thread common_scripts\utility::play_sound_in_space("youngblood_wla_allguys", var_0);
  var_1 = (3612, -105153, -115268);
  thread common_scripts\utility::play_sound_in_space("youngblood_wla_plusgirl", var_1);
}

n_sound_cars() {
  var_0 = common_scripts\utility::get_target_ent("n_car_1");
  var_0 maps\_utility::add_spawn_function(::car_1_audio);
  var_0 = common_scripts\utility::get_target_ent("n_car_2");
  var_0 maps\_utility::add_spawn_function(::car_2_audio);
  var_0 = common_scripts\utility::get_target_ent("town_speed_car");
  var_0 maps\_utility::add_spawn_function(::truck_audio);
}

truck_audio() {
  level endon("death");
  level endon("car_stop_damage");
  self playLoopSound("scn_yb_truck_drive_lp");

  for(;;) {
    if(distance2d(level.player.origin, self.origin) < 1215) {
      thread maps\_utility::play_sound_on_entity("scn_yb_truck_passby");
      wait 6;
      self stoploopsound();
      return;
    }

    wait 0.1;
  }
}

car_1_audio() {
  wait 0;
  thread maps\_utility::play_sound_on_entity("scn_yb_first_car_passby");
}

car_2_audio() {
  level endon("death");
  level endon("car_stop_damage");
  self playLoopSound("scn_yb_second_car_drive_lp");

  for(;;) {
    if(distance2d(level.player.origin, self.origin) < 880) {
      thread maps\_utility::play_sound_on_entity("scn_yb_second_car_passby");
      wait 6;
      self stoploopsound();
      return;
    }

    wait 0.1;
  }
}

n_hesh_stumble_and_path() {
  level.hesh maps\_utility::enable_exits();
  var_0 = spawnStruct();
  var_0.origin = level.hesh.origin;
  var_0.angles = level.hesh.angles;
  var_1 = common_scripts\utility::get_target_ent("1_street_pos_hesh");
  var_0.angles = vectortoangles(var_1.origin - var_0.origin);
  var_0.angles = (0, var_0.angles[1], 0);
  level.hesh maps\_utility::enable_exits();
  var_0 maps\_anim::anim_generic(level.hesh, "youngblood_generic_stumble_stand2");
  level.hesh.goalradius = 128;
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("1_street_pos_hesh"), 0);
}

enable_exit_on_notify(var_0) {
  self waittill(var_0);
  wait 0.1;
  maps\_utility::enable_exits();
}

neighborhood_dialogue() {
  wait 7.5;
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_dadwhatshappening");
  common_scripts\utility::flag_wait("start_neighborhood");
  wait 1.5;
  maps\_utility::delaythread(1.25, common_scripts\utility::flag_set, "load_car_1");
  level thread maps\_utility::autosave_by_name_silent("entering_neighborhood_save");
  thread play_distant_cloud_sounds();
  wait 0.5;
  level.elias maps\_utility::smart_dialogue("youngblood_els_odinitsodin");
  level.cloud_sfx_base_wait_min = 0.9;
  level.cloud_sfx_base_wait_max = 1.8;
  wait 0.5;
  thread n_diag();
  common_scripts\utility::flag_set("load_car_2");
  thread common_scripts\utility::exploder("exp07");
  thread neighborhood_dialog();
  wait 3;
  maps\_utility::delaythread(2, common_scripts\utility::exploder, "exp08");
}

n_diag() {
  level.elias maps\_utility::smart_dialogue("youngblood_els_tothehouseboys");
  level.cloud_sfx_design_wait_min = 4.0;
  level.cloud_sfx_design_wait_max = 9.3;
}

orange_plume_sound_stopping() {
  if(isDefined(level.plume_sound)) {
    level.plume_sound scalevolume(0.0, 8.0);
    wait 8.1;
    level.plume_sound stopsounds();
    wait 0.3;
    level.plume_sound delete();
  }
}

town_car() {
  common_scripts\utility::flag_wait("town_car_spawn");
  thread orange_plume_sound_stopping();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("town_speed_car");
  var_0 maps\_utility::delaythread(1, maps\_utility::play_sound_on_entity, "scn_yb_truck_skid_corner");
  var_0 maps\_utility::delaythread(1.8, maps\_utility::play_sound_on_entity, "yb_pars_volk_peel_out_r");
  var_0 maps\_utility::delaythread(2.5, maps\_utility::play_sound_on_entity, "yb_chase_pileup_01");
  var_0 thread neighborhood_vehicle_delete();
  var_0 thread neighborhood_vehicle_damage(var_0);
  wait 2;
  level.player thread maps\youngblood_util::yb_player_speed_percent(70, 2);
  level.elias maps\_utility::disable_exits();
  level.elias thread maps\_anim::anim_generic_gravity(level.elias, "yb_deer_halt_3_hesh");
  wait 0.7;
  level.elias maps\youngblood_util::set_move_rate(1.1);
  level.hesh maps\youngblood_util::set_move_rate(1.1);

  if(distance(level.hesh.origin, level.elias.origin) < 300) {
    level.hesh.animplaybackrate = 1.2;
    level.hesh maps\_utility::disable_exits();
    level.hesh maps\_anim::anim_generic_run(level.hesh, "suprise_stop");
    level.hesh.animplaybackrate = 1;
  } else
    level.hesh.moveplaybackrate = 1.05;

  wait 0.1;
  level.hesh maps\_utility::enable_arrivals();
  level.hesh maps\_utility::enable_exits();
}

neighborhood_vehicle_delete() {
  common_scripts\utility::flag_wait("start_mansion");
  self notify("stop_loop");
  self delete();
}

neighborhood_vehicle_damage(var_0) {
  self endon("death");
  level endon("car_stop_damage");

  for(;;) {
    if(level.player istouching(var_0)) {
      level.player dodamage(300, (0, 0, 0));
      level notify("new_quote_string");
      setdvar("ui_deadquote", & "YOUNGBLOOD_AVOIDCARS");
      maps\_utility::missionfailedwrapper();
      return;
    }

    wait 0.3;
  }
}

neighborhood_car() {
  common_scripts\utility::flag_wait("watchout_car");
  thread common_scripts\utility::exploder("exp09");
}

neighborhood_dialog() {
  common_scripts\utility::flag_wait("town_car_spawn");
  level.elias maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "youngblood_hsh_careful");
  wait 3.5;
  thread maps\youngblood_util::mansion_exploders("manxrock", 7);
  level.elias maps\_utility::smart_dialogue("youngblood_els_itsnotanearthquake");
  wait 0.4;
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_whatareyoutalkin");
  var_0 = common_scripts\utility::get_target_ent("elias_neighborhood_cmon");
  level.elias notify("stop_path");
  var_0 maps\_anim::anim_generic_reach(level.elias, "youngblood_elias_jog_twitch_3");
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("elias_mansion_ext_exit_pos"));
  var_0 thread maps\_anim::anim_generic_gravity(level.elias, "youngblood_elias_jog_twitch_3");
  level.elias maps\_utility::smart_dialogue("youngblood_els_heshtakeyourbrother");
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_butdad");
  thread mansion_ext_elias_leaves();
  level.hesh maps\_utility::enable_sprint();
  level.player thread maps\youngblood_util::yb_player_speed_percent(78, 2);
  level.hesh maps\_utility::disable_exits();
  var_0 = common_scripts\utility::get_target_ent("hesh_neighborhood_cmon");
  var_0 maps\_anim::anim_generic_reach(level.hesh, "yb_uphill_splitup_hesh");
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("mansion_ext_pos_hesh"));
  var_0 maps\_anim::anim_generic_gravity(level.hesh, "yb_uphill_splitup_hesh");
  wait 0.1;
  level.hesh maps\_utility::enable_exits();
  wait 2;
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_whatthehellis");
}

mansion_ext() {
  common_scripts\utility::flag_wait("start_mansion_ext");
  level.hesh.anim_blend_time_override = undefined;
  level.elias.anim_blend_time_override = undefined;
  level.player_location_vfx = "vfx_yb_onplayer_04_mansionhill";
  thread common_scripts\utility::exploder("exp10");
  thread mansion_flyaway_birds_sfx();
  thread mansion_pool_crack();
  thread common_scripts\utility::exploder("exp11");
  common_scripts\utility::flag_wait("player_top_hill");
  thread common_scripts\utility::exploder("exp12");
  common_scripts\utility::flag_wait("hesh_climbs_into_mansion");
  level.hesh maps\_utility::disable_exits();
  level.hesh maps\youngblood_util::set_move_rate(1.1);
  level.player thread maps\youngblood_util::yb_player_speed_percent(70, 2);
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_thiswayloganclimb");
  wait 2;
  level.hesh maps\_utility::smart_dialogue("youngblood_hsh_itsnotsafeout");
}

mansion_flyaway_birds_sfx() {
  var_0 = spawn("script_origin", (1235, -104262, -114722));
  var_0 playSound("scn_yb_birds_flyaway", "sounddone");
  var_0 moveto((1437, -105698, -114721), 6);
  wait 20;
  var_0 delete();
}

mansion_pool_crack() {
  common_scripts\utility::flag_wait("pool_crack");
  level.player thread maps\_utility::play_sound_on_entity("scn_quake_10");
  thread common_scripts\utility::play_sound_in_space("scn_pool_quake_01", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("yb_shg_harb_boat_slowmo_splash", (956, -103469, -114737));
  thread common_scripts\utility::play_sound_in_space("yb_elm_flood_debris_splash_03", (924, -103639, -114792));
  thread common_scripts\utility::play_sound_in_space("yb_water_splash_lrg_02", (727, -103579, -114735));
  thread common_scripts\utility::play_sound_in_space("yb_water_fountain_splash_05", (1213, -103950, -114735));
  maps\_utility::delaythread(2.0, common_scripts\utility::play_sound_in_space, "yb_uw_pov_splash_04", (1081, -103934, -114834));
  thread maps\_utility::activate_trigger_with_noteworthy("pool_crack_trig");
  common_scripts\utility::exploder("exp13");
  thread maps\youngblood_util::heavy_quake(75);
  thread mansion_sfx_crumbling();
  var_0 = common_scripts\utility::get_target_ent("pool_foam_ref");
  playFXOnTag(common_scripts\utility::getfx("ygb_pool_surface_follow"), var_0, "tag_origin");
  wait 20;
  var_0 delete();
}

mansion_sfx_crumbling() {
  wait 1.75;
  thread common_scripts\utility::play_sound_in_space("scn_yb_house_crumble", (973, -103355, -114695));
  thread common_scripts\utility::play_sound_in_space("scn_yb_house_crumble", (415, -103773, -114681));
  maps\_utility::delaythread(0.5, common_scripts\utility::play_sound_in_space, "scn_yb_house_debris", (423, -103614, -114527));
  maps\_utility::delaythread(0.9, common_scripts\utility::play_sound_in_space, "scn_yb_house_debris", (761, -103372, -114516));
  maps\_utility::delaythread(1.2, common_scripts\utility::play_sound_in_space, "scn_yb_house_debris", (522, -103427, -114227));
  maps\_utility::delaythread(2.3, common_scripts\utility::play_sound_in_space, "scn_yb_house_tile_debris", (227, -103826, -114675));
  maps\_utility::delaythread(4.0, common_scripts\utility::play_sound_in_space, "scn_yb_house_tile_debris", (648, -103344, -114497));
  maps\_utility::delaythread(1.5, common_scripts\utility::play_sound_in_space, "scn_yb_house_explo_debris", (400, -103818, -114666));
}

mansion_ext_elias_leaves() {
  level.elias thread maps\_utility::smart_dialogue("youngblood_els_justdoitson");
  level.cloud_sfx_base_wait_min = 0.7;
  level.cloud_sfx_base_wait_max = 1.4;
  level.cloud_sfx_design_wait_min = 3.5;
  level.cloud_sfx_design_wait_max = 6.3;
  level.elias maps\youngblood_util::set_move_rate(1.2);
  common_scripts\utility::flag_wait("start_mansion");
  level.elias delete();
}

mansion() {
  if(!maps\_utility::game_is_current_gen())
    setsaveddvar("r_mbEnable", "0");

  var_0 = common_scripts\utility::get_target_ent("mansion_middle_door_left");
  var_1 = common_scripts\utility::get_target_ent("clip_mansion_mid_door_L");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.animname = "door";
  var_2 maps\_anim::setanimtree();
  var_1 linkto(var_2);
  var_0 linkto(var_2, "tag_origin", (0, 0, 0), (0, 180, 0));
  var_3 = common_scripts\utility::get_target_ent("mansion_middle_door_right");
  var_4 = common_scripts\utility::get_target_ent("clip_mansion_mid_door_R");
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_3.origin;
  var_5.angles = var_3.angles;
  var_5.animname = "door";
  var_5 maps\_anim::setanimtree();
  var_4 linkto(var_3);
  var_3 linkto(var_5);

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.player setviewmodel("viewhands_gs_hostage_clean");
    level.scr_model["player_rig"] = "viewhands_player_gs_hostage_clean";
  }

  common_scripts\utility::flag_wait("start_mansion");
  thread maps\youngblood_util::mansion_exploders("manprock", 6);
  level notify("pre_mansion_done");
  common_scripts\utility::trigger_off("player_near_mansion_door", "targetname");
  maps\youngblood_util::disable_team_color();
  common_scripts\utility::trigger_off("player_near_2nd_door", "targetname");
  common_scripts\utility::trigger_off("trig_player_enter_2nd_door", "targetname");
  common_scripts\utility::trigger_off("player_near_mansion_exit", "targetname");
  var_6 = getent("mansion_front_door_left", "targetname");
  level.hesh notify("stop_path");
  var_7 = common_scripts\utility::get_target_ent("mansion_anim_ref");
  var_7 maps\_anim::anim_generic_reach(level.hesh, "youngblood_house_entry_friendly");
  var_8 = common_scripts\utility::get_target_ent("mansion_front_door_left");
  var_9 = common_scripts\utility::get_target_ent("clip_mansion_front_door_L");
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = var_8.origin;
  var_10.angles = var_8.angles;
  var_10.animname = "door";
  var_10 maps\_anim::setanimtree();
  var_9 linkto(var_8);
  var_8 linkto(var_10);
  var_7 thread maps\_anim::anim_single_solo(var_10, "youngblood_house_entry_door");
  var_7 maps\_anim::anim_generic(level.hesh, "youngblood_house_entry_friendly");
  var_7 thread maps\_anim::anim_generic_loop(level.hesh, "youngblood_house_entry_idle");
  var_7 thread maps\_anim::anim_loop_solo(var_10, "youngblood_house_entry_door_idle");
  thread maps\youngblood_util::chaos_kill_after_time(10);
  thread maps\_utility::stop_exploder("evilclouds");
  var_11 = common_scripts\utility::get_target_ent("clip_player_mansion_door");
  var_11 delete();
  common_scripts\utility::trigger_on("player_near_mansion_door", "targetname");
  maps\_utility::trigger_wait_targetname("player_near_mansion_door");
  level notify("stop_rog_strikes");
  level notify("player_safe");
  level notify("stop_mansion_exploders");
  level notify("car_stop_damage");
  var_7 notify("stop_loop");
  var_12 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_12 hide();
  level.cloud_sfx_base_wait_min = 1.2;
  level.cloud_sfx_base_wait_max = 2.4;
  level.cloud_sfx_design_wait_min = 12.0;
  level.cloud_sfx_design_wait_max = 20.0;
  level.player setclienttriggeraudiozone("youngblood_house", 1.5);
  level notify("player_goes_into_mansion");
  maps\_utility::autosave_by_name_silent("in_mansion");
  var_7 maps\_anim::anim_first_frame_solo(var_12, "youngblood_house_entry_player");
  maps\youngblood_util::viewmodel_anim_on();
  thread mansion_hesh(var_7);
  var_7 thread maps\_anim::anim_single_solo(var_10, "youngblood_house_entry_door_close");
  level.player playerlinktoblend(var_12, "tag_player", 0.5, 0.2, 0);
  var_12 common_scripts\utility::delaycall(0.5, ::show);
  level.player maps\_utility::delaythread(1.5, maps\_utility::play_sound_on_entity, "scn_quake_11");
  level.player common_scripts\utility::delaycall(1.5, ::playrumbleonentity, "light_2s");
  common_scripts\utility::noself_delaycall(1.5, ::earthquake, 0.4, 2.5, level.player.origin, 512);
  maps\_utility::delaythread(1.5, common_scripts\utility::exploder, "exp14");
  maps\_utility::delaythread(1.5, ::exp14_sounds);
  var_7 maps\_anim::anim_single_solo(var_12, "youngblood_house_entry_player");
  maps\youngblood_util::viewmodel_anim_off();
  level.player unlink();
  var_12 delete();
  level.player maps\_utility::delaythread(5.0, ::player_wobbles);
  level.player_location_vfx = "vfx_yb_onplayer_05_mansion";
  common_scripts\utility::flag_wait("hesh_finish_1st");
  level.hesh.anim_playsound_func = ::_playsound;
  var_7 thread maps\_anim::anim_single_solo(var_2, "youngblood_house_2nd_door_1");
  var_7 thread maps\_anim::anim_single_solo(var_5, "youngblood_house_2nd_door_2");
  var_7 thread maps\_anim::anim_generic(level.hesh, "youngblood_house_2nd_room_friendly");
  thread mansion_middle_room_handler(var_7);
  thread maps\youngblood_util::chaos_kill_after_time(6);
  common_scripts\utility::trigger_on("trig_player_enter_2nd_door", "targetname");
  common_scripts\utility::flag_wait("player_enter_2nd_door");
  level notify("player_safe");
  common_scripts\utility::flag_clear("player_unsafe");
  waittillframeend;
  level.cloud_sfx_base_wait_min = 0.6;
  level.cloud_sfx_base_wait_max = 1.6;
  level.cloud_sfx_design_wait_min = 3.5;
  level.cloud_sfx_design_wait_max = 6.0;
  level.player thread player_falls_down_flat();
  level.player_location_vfx = "vfx_yb_onplayer_06_mansion";
  thread mansion_exit_door_handler(var_7);
  common_scripts\utility::trigger_on("player_near_mansion_exit", "targetname");
  thread maps\youngblood_util::chaos_kill_after_time(16);
  common_scripts\utility::flag_wait("player_near_mansion_exit");
  level notify("player_safe");
  common_scripts\utility::flag_clear("player_unsafe");
  var_12 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_12 hide();
  var_7 maps\_anim::anim_first_frame_solo(var_12, "youngblood_house_exit_player");
  level.player playerlinktoblend(var_12, "tag_player", 0.5);
  maps\youngblood_util::viewmodel_anim_on();
  var_12 show();
  var_8 = common_scripts\utility::get_target_ent("mansion_exit_door_left");
  var_13 = common_scripts\utility::get_target_ent("clip_mansion_exit_door_L");
  var_14 = common_scripts\utility::spawn_tag_origin();
  var_14.origin = var_8.origin;
  var_14.angles = var_8.angles;
  var_14.animname = "door";
  var_14 maps\_anim::setanimtree();
  var_13 linkto(var_8);
  var_8 linkto(var_14);
  var_15 = common_scripts\utility::get_target_ent("mansion_exit_door_right");
  var_16 = common_scripts\utility::spawn_tag_origin();
  var_16.origin = var_15.origin;
  var_16.angles = var_15.angles;
  var_16.animname = "door";
  var_16 maps\_anim::setanimtree();
  var_15 linkto(var_16);
  var_7 notify("stop_loop");
  level.hesh common_scripts\utility::delaycall(0.2, ::stopsounds);
  var_7 maps\_utility::delaythread(0.1, maps\_anim::anim_generic, level.hesh, "youngblood_house_exit_friendly_open_door");
  var_7 maps\_utility::delaythread(0.1, maps\_anim::anim_single_solo, var_12, "youngblood_house_exit_player");
  var_7 thread maps\_anim::anim_single_solo(var_14, "youngblood_house_exit_door_1");
  var_7 thread maps\_anim::anim_single_solo(var_16, "youngblood_house_exit_door_2");
  common_scripts\utility::exploder("tospace");
  level.player maps\_utility::delaythread(3.7, maps\youngblood_util::player_heartbeat);
  maps\_utility::delaythread(3.8, maps\_utility::vision_set_fog_changes, "ygb_mansion_int_a_bloom", 0.3);
  maps\_utility::delaythread(3.9, common_scripts\utility::exploder, "mansion_door_reveal_a");
  common_scripts\utility::noself_delaycall(4.1, ::setslowmotion, 1, 0.2, 0.25);
  maps\_utility::delaythread(4, maps\_hud_util::fade_out, 0.35, "white");
  level.player common_scripts\utility::delaycall(4, ::setclienttriggeraudiozone, "youngblood_white_transition", 0.25);
  maps\_utility::delaythread(3.6, common_scripts\utility::play_sound_in_space, "scn_yb_house_transition_to_odin_lr", level.player.origin);

  if(isDefined(level.prologue) && level.prologue == 1)
    common_scripts\utility::noself_delaycall(4.65, ::setslowmotion, 0.2, 1, 5);

  wait 4.4;
  resetsunlight();
  resetsundirection();
  maps\_utility::stop_exploder("deer_hut_tremor_a");
  maps\_utility::stop_exploder("exp02");
  maps\_utility::stop_exploder("exp04");
  maps\_utility::stop_exploder("exp06");
  maps\_utility::stop_exploder("exp07");
  maps\_utility::stop_exploder("exp09");
  maps\_utility::stop_exploder("exp10");
  maps\_utility::stop_exploder("exp11");
  maps\_utility::stop_exploder("exp12");
  maps\_utility::stop_exploder("exp09");
  maps\_utility::stop_exploder("exp13");
  maps\_utility::stop_exploder("evilclouds");
  level.hesh.anim_playsound_func = undefined;
  thread maps\_utility::fx_volume_pause_noteworthy("yb_fx_volume_1");
  var_7 thread maps\_anim::anim_generic_loop(level.hesh, "youngblood_house_exit_idle_friendly", "stop_hesh_door_idle");
  level notify("stop_player_heartbeat");
  thread maps\_art::sunflare_changes("default", 0);
  thread maps\_utility::vision_set_fog_changes("", 0.05);
  level.hesh notify("stop_hesh_door_idle");
  level notify("stop_vfx_on_player");
  level.hesh maps\_utility::stop_magic_bullet_shield();
  level.hesh delete();
  var_8 unlink();
  var_15 unlink();
  level.player unlink();
  var_12 delete();
  maps\_utility::remove_extra_autosave_check("close_to_hesh");
  maps\_utility::activate_trigger_with_targetname("yb_ground_fx_off");

  if(isDefined(level.prologue) && level.prologue == 1) {
    var_17 = getaiarray();
    common_scripts\utility::array_call(var_17, ::delete);
    setdvar("hud_showObjectives", 1);
    setsaveddvar("ammoCounterHide", "0");
    common_scripts\utility::flag_set("start_transition_to_odin");
    thread maps\_art::sunflare_changes("odin_default", 0);
  }
}

exp14_sounds() {
  var_0 = (475, -103369, -114522);
  var_1 = (439, -103301, -114704);
  wait 2.5;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 thread maps\_utility::play_sound_on_entity("scn_yb_glass_wood_burst");
  var_2 moveto(var_1, 1);
  var_2 waittill("movedone");
  wait 3;
  var_2 delete();
}

mansion_exit_door_handler(var_0) {
  if(common_scripts\utility::flag("hesh_middle_room_in_position"))
    var_0 maps\_anim::anim_generic(level.hesh, "youngblood_house_knockdown_friendly");
  else
    wait 1.2;

  var_0 maps\_anim::anim_generic(level.hesh, "youngblood_house_exit_friendly");

  if(common_scripts\utility::flag("player_near_mansion_exit") == 0) {
    var_0 thread maps\_anim::anim_generic_loop(level.hesh, "youngblood_house_exit_friendly_idle");
    common_scripts\utility::flag_wait("player_near_mansion_exit");
    var_0 notify("stop_loop");
  }
}

mansion_middle_room_handler(var_0) {
  if(common_scripts\utility::flag("player_enter_2nd_door") == 0) {}

  var_0 waittill("youngblood_house_2nd_room_friendly");

  if(common_scripts\utility::flag("player_enter_2nd_door") == 0) {
    common_scripts\utility::flag_set("hesh_middle_room_in_position");
    var_0 thread maps\_anim::anim_generic_loop(level.hesh, "youngblood_house_2nd_room_idle_friendly");
    common_scripts\utility::flag_wait("player_enter_2nd_door");
    var_0 notify("stop_loop");
  }
}

mansion_hesh(var_0) {
  var_0 maps\_anim::anim_generic(level.hesh, "youngblood_house_1st_room_friendly");
  common_scripts\utility::flag_set("hesh_finish_1st");
}

chaos_a() {
  if(!maps\_utility::game_is_current_gen())
    setsaveddvar("r_mbEnable", "0");

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 1);

  if(maps\_utility::game_is_current_gen())
    setsaveddvar("sm_sunshadowscale", 0.55);

  if(isDefined(level.prologue) && level.prologue)
    common_scripts\utility::flag_wait("prologue_transient_ground_tr_loaded");
  else
    maps\_hud_util::fade_out(0, "white");

  common_scripts\utility::trigger_on("start_chaos_a", "targetname");
  maps\_utility::trigger_wait_targetname("start_chaos_a");
  maps\_utility::vision_set_fog_changes("", 0);
  level.player setclienttriggeraudiozone("youngblood_slomo_impact", 0.2);
  soundsettimescalefactor("voice", 0.1);
  setsaveddvar("ammoCounterHide", "1");
  thread trigger_threads_after_chaos();
  common_scripts\utility::array_thread(getEntArray("street_2_start_movement", "targetname"), ::setup_play_street_2_anims_think);
  common_scripts\utility::array_thread(getEntArray("trig_player_chaos_quake", "targetname"), ::chaos_quake_trigger_think);
  common_scripts\utility::array_thread(getEntArray("trig_player_rog", "targetname"), ::chaos_rog_think);
  common_scripts\utility::array_thread(getEntArray("street_2_start_movement", "targetname"), ::play_street_crack_2_think);
  common_scripts\utility::array_thread(getEntArray("script_sfx_for_movers", "targetname"), ::sfx_for_p_r_s_t_pieces);
  thread spawn_street_fake_first_frame();
  thread setup_play_chaos_chunk_anims();
  thread play_street_crack_1_think();
  maps\youngblood_util::spawn_hesh();
  level.hesh maps\youngblood_util::enable_hesh_walk();
  maps\youngblood_util::set_start_positions("start_chaos_a");
  level.hesh.dontchangepushplayer = 1;
  level.hesh.pushable = 0;
  level.hesh.pushplayer = 1;
  level.hesh pushplayer(1);
  level.hesh maps\_utility::disable_sprint();
  level.hesh maps\youngblood_util::init_chaos_animset();
  level.player setviewmodel("viewhands_gs_hostage_clean");
  level.scr_model["player_rig"] = "viewhands_player_gs_hostage_clean";
  level.player takeallweapons();
  level.player giveweapon("noweapon_youngblood+yb_state_chaos");
  level.player switchtoweaponimmediate("noweapon_youngblood+yb_state_chaos");
  level.player allowswim(0);
  level.player setstance("stand");
  level.player allowsprint(0);
  level.player thread maps\youngblood_util::yb_player_speed_percent(25);
  thread maps\youngblood_util::set_player_sprint_speed_scale(1.15);
  maps\youngblood_util::viewmodel_anim_on();
  var_0 = common_scripts\utility::get_target_ent("mansion_anim_ref");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 3);
  var_1.angles = var_0.angles;
  var_2 = common_scripts\utility::get_target_ent("mansion_exit_door_left");
  var_2.origin = (181, -102857, -114632);
  var_2.angles = (0, 295.6, 0);
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_3.animname = "door";
  var_3 maps\_anim::setanimtree();
  var_2 linkto(var_3);
  var_4 = common_scripts\utility::get_target_ent("mansion_exit_door_right");
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_4.origin;
  var_5.angles = var_4.angles;
  var_5.animname = "door";
  var_5 maps\_anim::setanimtree();
  var_4 linkto(var_5);
  var_6 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_6 hide();
  var_1 maps\_anim::anim_first_frame_solo(var_6, "youngblood_house_exit_player_part2");
  var_0 thread maps\_anim::anim_loop_solo(var_3, "youngblood_house_exit_idle_door_1");
  var_0 thread maps\_anim::anim_loop_solo(var_5, "youngblood_house_exit_idle_door_2");
  var_0 thread maps\_anim::anim_generic_loop(level.hesh, "youngblood_house_exit_idle_friendly");
  var_7 = 0;
  level.hesh maps\youngblood_util::set_move_rate(1.02);
  level.player enableslowaim(0.3, 0.3);
  level.player playerlinktodelta(var_6, "tag_player", 1, 0, 0, 0, 0);
  level.player common_scripts\utility::delaycall(1, ::lerpviewangleclamp, 1, 1, 0, 20, 20, 20, 20);
  var_6 show();
  common_scripts\utility::flag_wait("transition_from_odin_to_yb_done");
  common_scripts\utility::flag_wait_all("load_1", "load_2", "load_3");
  thread chaos_b_hide_debris();
  setsaveddvar("cg_fov", 65);
  thread chaos_cull_think();
  thread maps\youngblood_fx::vfx_open_door_sequence();
  level.player thread maps\_utility::play_sound_on_entity("scn_yb_rog_impact_lr");
  wait 0.5;
  maps\_utility::delaythread(2.7, common_scripts\utility::flag_set, "play_street_cracking");
  var_0 notify("stop_loop");
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, "youngblood_house_exit_door_1_part2");
  var_0 thread maps\_anim::anim_first_frame_solo(var_5, "youngblood_house_exit_door_2_part2");
  setslowmotion(1, 0.4, 0);
  thread maps\_hud_util::fade_in(0.5, "white");
  level.hesh thread chaos_a_hesh_run(var_0);
  var_1 thread maps\_anim::anim_single_solo(var_6, "youngblood_house_exit_player_part2");
  var_0 thread maps\_anim::anim_single_solo(var_3, "youngblood_house_exit_door_1_part2");
  var_0 thread maps\_anim::anim_single_solo(var_5, "youngblood_house_exit_door_2_part2");
  common_scripts\utility::noself_delaycall(1.5, ::playrumbleonposition, "prologue_chaos_a", level.player.origin + (0, 0, 700));
  var_0 = common_scripts\utility::get_target_ent("mid_street_ref");
  level.player maps\_utility::delaythread(2.4, ::chaos_moving_head, var_6);
  wait 4.1;
  setslowmotion(0.4, 1, 0.15);
  level.player setclienttriggeraudiozone("youngblood_chaos", 1.5);
  maps\_utility::add_extra_autosave_check("close_to_hesh", maps\youngblood_util::check_close_to_hesh, "too far from hesh");
  level.player disableslowaim();
  level.player thread maps\youngblood_util::yb_player_speed_percent(89, 4);
  level.player common_scripts\utility::delaycall(4, ::allowsprint, 1);
  level thread maps\_utility::autosave_now_silent();
  thread chaos_falling_debris();
  thread maps\youngblood_util::chaos_checkpoint(15);
  thread maps\youngblood_util::player_unlink_slide_on_death();
  thread chaos_moving_clip();
  thread trigger_interior_detect();
  level.player thread maps\youngblood_fx::vfx_on_player();
  maps\youngblood_util::disable_team_color();
  common_scripts\utility::flag_wait("hesh_sequence_done");
  level.hesh maps\_utility::disable_exits();
  level.hesh maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("025_stumble"), 9999);
  level.hesh maps\_utility::disable_exits();
  var_0 = common_scripts\utility::get_target_ent("mid_street_ref");
  level.hesh maps\_utility::disable_exits();
  var_0 maps\youngblood_util::anim_generic_reach_and_animate(level.hesh, "yb_car_jump_slide");
  level.hesh maps\_utility::disable_exits();
  wait 0.1;
  level.hesh maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "youngblood_hsh_keeprunningwecan");
  level.hesh thread maps\_utility::follow_path(common_scripts\utility::get_target_ent("040_sidewalk_pos"), 9999);
  level.hesh maps\_utility::disable_exits();
  wait 0.1;
  level.hesh maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "youngblood_hsh_throughthathouse");
  var_0 maps\youngblood_util::anim_generic_reach_and_animate(level.hesh, "yb_cliff_jump_hesh");
  level.hesh maps\_utility::disable_exits();
  level.hesh thread maps\_utility::follow_path(common_scripts\utility::get_target_ent("060_exithouse_pos"), 9999);
  wait 0.5;
  common_scripts\utility::flag_set("house_k2_k3_anim");
  wait 3.5;
  var_0 = common_scripts\utility::get_target_ent("housejump_anim_ref");
  thread chaos_a_wait_for_player_jump(var_0);
  thread chaos_a_hesh_jump(var_0);
  common_scripts\utility::flag_wait("trig_player_inside_house");
  waittillframeend;
  level.hesh maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("forward_walk_into"), 9999);
  level.hesh maps\_utility::follow_path(common_scripts\utility::get_target_ent("exit_basement_pos"), 9999);
  var_0 = common_scripts\utility::get_target_ent("debris_door_ref");
  var_8 = getent("basement_debris_door", "targetname");
  var_9 = maps\_utility::spawn_anim_model("tag_origin", var_8.origin);
  var_9.angles = var_8.angles;
  var_8 linkto(var_9, "tag_origin");
  var_0 maps\_anim::anim_first_frame_solo(var_9, "youngblood_basement_approach_debris_1");
  var_0 maps\_anim::anim_reach_solo(level.hesh, "youngblood_basement_approach_hesh");
  level.hesh maps\_utility::disable_exits();
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "youngblood_basement_approach_hesh");
  level.hesh maps\_utility::disable_exits();
  var_8 notsolid();
  var_0 maps\_anim::anim_single_solo(var_9, "youngblood_basement_approach_debris_1");

  if(common_scripts\utility::flag("player_near_debris_door") == 0) {
    thread maps\youngblood_util::chaos_kill_after_time(4);
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "youngblood_basement_idle_hesh");
    var_0 thread maps\_anim::anim_loop_solo(var_9, "youngblood_basement_idle_debris_1");
    level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_getupherelogan");
    common_scripts\utility::flag_wait("player_near_debris_door");
    var_0 notify("stop_loop");
  }

  common_scripts\utility::flag_wait("player_near_debris_door");
  level notify("player_safe");
  common_scripts\utility::flag_clear("player_unsafe");
  maps\_utility::activate_trigger_with_targetname("basement_vfx_trig");
  maps\_utility::activate_trigger_with_noteworthy("street_flying_house");
  var_10 = getent("street_flying_chunk_sound", "targetname");
  var_10 maps\_utility::delaythread(1.0, maps\_utility::play_sound_on_entity, "scn_yb_final_big_street_piece_incoming");
  thread maps\youngblood_util::rog_incoming();
  maps\_utility::delaythread(1.0, common_scripts\utility::play_sound_in_space, "scn_yb_final_big_street_piece_hit_quake", level.player.origin);
  var_10 maps\_utility::delaythread(2.0, maps\_utility::play_sound_on_entity, "scn_yb_final_big_street_piece_hit");
  thread maps\_utility::delaythread(2, maps\youngblood_util::heavy_quake, 85);
  level.hesh maps\_utility::disable_exits();
  var_8 thread maps\_utility::play_sound_on_entity("scn_hesh_break_wood_wall");
  thread common_scripts\utility::play_sound_in_space("scn_yb_gate_blow_away_layer", level.player.origin);
  var_0 thread maps\_anim::anim_single_solo(var_9, "youngblood_basement_exit_debris_1");
  level.hesh maps\_utility::delaythread(0.5, maps\_utility::follow_path_and_animate, common_scripts\utility::get_target_ent("chaos_b_run"), 0);
  var_0 maps\_anim::anim_single_solo(level.hesh, "youngblood_basement_exit_hesh");
  level.hesh maps\_utility::disable_exits();
  common_scripts\utility::flag_set("start_chaos_b");
}

chaos_cull_think() {
  if(maps\_utility::is_gen4())
    thread maps\_art::disable_ssao_over_time(1);

  maps\_utility::vision_set_fog_changes("ygb_chaos_a_lessfog", 0);
  wait 4.5;
  var_0 = 1;

  if(level.xb3)
    maps\_utility::vision_set_fog_changes("ygb_chaos_a_durango", var_0);
  else
    maps\_utility::vision_set_fog_changes("", var_0);

  wait(var_0);
  common_scripts\utility::waitframe();

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_umbraUseDpvsCullDist", 1);

    if(level.xb3)
      setculldist(3000);
    else
      setculldist(3000);
  } else
    setculldist(2500);
}

chaos_cull_more() {
  var_0 = 2;

  if(level.xb3)
    maps\_utility::vision_set_fog_changes("ygb_chaos_a_nearfog_durango", var_0);
  else
    maps\_utility::vision_set_fog_changes("ygb_chaos_a_nearfog", var_0);

  wait(var_0);
  common_scripts\utility::waitframe();

  if(maps\_utility::is_gen4()) {
    if(level.xb3)
      setculldist(1500);
    else
      setculldist(1500);
  } else
    setculldist(1500);
}

chaos_falling_debris() {
  var_0 = common_scripts\utility::getstructarray("chaos_falling_debris", "script_noteworthy");

  for(;;) {
    var_1 = anglesToForward(level.player.angles);
    var_1 = var_1 * 400;
    var_2 = sortbydistance(var_0, level.player.origin + var_1);
    thread maps\youngblood_util::falling_debris(var_2[randomintrange(0, 5)]);
    wait(randomfloatrange(2, 6));
  }
}

chaos_rog_think() {
  self waittill("trigger");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rog_a") {
    common_scripts\utility::exploder("chaos_a_street_rog");
    thread maps\youngblood_util::rog_incoming_light();
    thread rog_moving_sound("yb_rog_passby_after_slide", (1939, -93269, -110847), (-18834, -96188, -116563), 2.5);
    thread common_scripts\utility::play_sound_in_space("yb_rog_passby_after_slide_impact", (-4479, -100695, -115627));
    thread chaos_cull_more();
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rog_b") {
    common_scripts\utility::exploder("chaos_b_street_rog");
    thread maps\youngblood_util::rog_incoming_light();
    thread rog_moving_sound("yb_rog_passby_after_house", (-11319, -84999, -104714), (-18196, -96740, -117043), 2.2);
    thread common_scripts\utility::play_sound_in_space("yb_rog_passby_after_house_impact", (-4479, -100695, -115627));
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rog_c") {
    thread maps\youngblood_util::rog_incoming_light();
    thread common_scripts\utility::exploder("chaos_b_street_rog");
    thread rog_moving_sound("scn_yb_truck_rog_incoming", (-11703.3, -84861.8, -104786), (-17991, -96915, -116704), 2.0);
    thread common_scripts\utility::play_sound_in_space("scn_yb_truck_rog_incoming_start", (-11703.3, -84861.8, -104786));
    wait 2;
    level.player setclienttriggeraudiozone("youngblood_final_rog_hit", 0.2);
    thread common_scripts\utility::play_sound_in_space("scn_yb_truck_rog_hit_r", (-5197, -94215, -113286));
    thread common_scripts\utility::play_sound_in_space("scn_yb_truck_rog_hit_c", (-6698, -95854, -113371));
    thread common_scripts\utility::play_sound_in_space("scn_yb_truck_rog_hit_l", (-7020, -98983, -113352));
    thread common_scripts\utility::play_sound_in_space("scn_yb_truck_rog_hit_lfe", (-6698, -95854, -113371));
  }
}

rog_moving_sound(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", var_1);
  var_4 moveto(var_2, var_3);
  var_4 playSound(var_0, "rog_sound_done");
  var_4 waittill("rog_sound_done");
  common_scripts\utility::waitframe();
  var_4 delete();
}

chaos_moving_head(var_0) {
  var_1 = 25;
  setsaveddvar("hud_showStance", 1);
  maps\youngblood_util::viewmodel_anim_off();
  level.player freezecontrols(0);
  level.player unlink();
  var_0 delete();
  level.player_outside = 1;
  level.player allowsprint(0);
}

chaos_moving_clip() {
  var_0 = common_scripts\utility::get_target_ent("moving_clip_start");
  var_1 = common_scripts\utility::getstruct("moving_clip_dest", "targetname");
  var_0 delete();
}

chaos_a_hesh_jump(var_0) {
  level endon("player_jumped_into_house");

  if(!common_scripts\utility::flag("player_jumped_into_house")) {
    level.hesh maps\_utility::disable_exits();
    var_0 maps\_anim::anim_reach_solo(level.hesh, "yb_roof_landing");
    var_0 maps\_anim::anim_single_solo(level.hesh, "yb_roof_landing");
    thread maps\youngblood_util::chaos_kill_after_time(7);
    thread chaos_a_house_jump_nag();
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "yb_roof_landing_idle", "stop_roof_loop");
    thread chaos_a_hesh_jump_breakout(var_0);
  }
}

chaos_a_hesh_jump_breakout(var_0) {
  common_scripts\utility::flag_wait("player_jumped_into_house");
  var_0 notify("stop_roof_loop");
  level.hesh maps\_utility::disable_exits();
}

chaos_a_wait_for_player_jump(var_0) {
  maps\_utility::stop_exploder("a");
  maps\_utility::stop_exploder("c");
  maps\_utility::stop_exploder("e");

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.player setviewmodel("viewhands_gs_hostage");
    level.scr_model["player_rig"] = "viewhands_player_gs_hostage";
  }

  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_0 maps\_anim::anim_first_frame_solo(var_1, "youngblood_player_roof_smash");
  var_1 hide();
  common_scripts\utility::flag_wait("player_jumped_into_house");
  level.player playrumbleonentity("damage_heavy");
  thread common_scripts\utility::play_sound_in_space("scn_yb_player_jump_through_roof", level.player.origin);
  common_scripts\utility::flag_set("suppress_crash_player_fx");
  common_scripts\utility::flag_set("chaos_player_safe");
  level notify("player_safe");
  common_scripts\utility::flag_clear("player_unsafe");
  level.player playerlinktoabsolute(var_1, "tag_player");
  var_1 show();
  setsaveddvar("r_znear", 0.1);
  var_0 thread maps\_anim::anim_single_solo(var_1, "youngblood_player_roof_smash");
  level.player enabledeathshield(1);
  level.player dodamage(400, (0, 0, 0));
  level.player maps\_utility::player_speed_percent(25);
  common_scripts\utility::flag_set("player_on_house_floor");
  level.player enabledeathshield(1);
  level.player dodamage(400, (0, 0, 0));
  thread chaos_a_hesh_landing(var_0);
  maps\_utility::vision_set_fog_changes("", 2);

  if(maps\_utility::is_gen4())
    setsaveddvar("r_umbraUseDpvsCullDist", 0);

  setculldist(0);
  var_0 waittill("youngblood_player_roof_smash");
  setsaveddvar("r_znear", 4);
  thread sfx_temp_enable_chaos_bg_after_getting_up();
  level.player unlink();
  var_1 delete();
  level.player allowsprint(0);
  level.player maps\youngblood_util::yb_player_speed_percent(85, 7);
  level.player common_scripts\utility::delaycall(7, ::allowsprint, 1);
  level.player enabledeathshield(0);
  thread chaos_house_climb_kill_thread();
}

sfx_temp_enable_chaos_bg_after_getting_up() {
  wait 4.0;
  level.player setclienttriggeraudiozone("youngblood_chaos", 1.0);
}

chaos_house_climb_kill_thread() {
  level.player endon("death");
  var_0 = -98608;
  var_1 = -115125;

  for(;;) {
    wait 1;

    if(level.player.origin[1] < var_0 && level.player.origin[2] > var_1)
      level.player kill();
  }
}

chaos_a_house_jump_nag() {
  var_0 = common_scripts\utility::get_target_ent("player_exits_house_pos");
}

chaos_a_hesh_landing(var_0) {
  common_scripts\utility::flag_wait("player_on_house_floor");
  var_1 = common_scripts\utility::getstruct("landing_spot_hesh", "targetname");
  level.hesh forceteleport(var_1.origin, var_1.angles);
  level.hesh setgoalpos(var_1.origin);
  var_2 = getent("chunk_main_s", "targetname");
  var_2 maps\_utility::delaythread(6.0, maps\_utility::play_sound_on_entity, "scn_yb_house_move4");
  var_2 maps\_utility::delaythread(6.0, maps\_utility::play_sound_on_entity, "scn_yb_house_move4_layer_lfe");
  var_3 = getent("chaos_pool_table", "targetname");
  var_3 maps\_utility::delaythread(11.55, maps\_utility::play_sound_on_entity, "scn_yb_house_pool_table_slide");
  maps\_utility::delaythread(14.5, common_scripts\utility::play_sound_in_space, "scn_yb_house_tiles_crashing", (-1572, -97979, -115057));
  maps\_utility::delaythread(14.9, common_scripts\utility::play_sound_in_space, "scn_yb_house_tiles_crashing", (-1620, -97966, -115045));
  maps\_utility::delaythread(15.1, common_scripts\utility::play_sound_in_space, "scn_yb_house_tiles_crashing", (-1564, -98070, -115075));
  maps\_utility::delaythread(15.7, common_scripts\utility::play_sound_in_space, "scn_yb_house_tiles_crashing", (-1505, -98028, -115084));
  maps\_utility::delaythread(16.75, common_scripts\utility::play_sound_in_space, "scn_yb_house_tiles_crashing", (-1481, -97841, -115044));
  var_0 maps\_anim::anim_first_frame_solo(level.hesh, "youngblood_hesh_underbar");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "youngblood_hesh_underbar");
  wait 9;
  level.hesh stopanimscripted();
  level.hesh maps\_utility::disable_exits();
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_runupstairswehave");
  common_scripts\utility::flag_set("trig_player_inside_house");
}

chaos_a_hesh_run(var_0) {
  var_0 maps\_anim::anim_generic(level.hesh, "youngblood_house_exit_friendly_part2");
  maps\_utility::disable_exits();
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_comeonwehave");
  level.hesh maps\_utility::follow_path(common_scripts\utility::get_target_ent("piece_01_pos"), 2000);
  level.hesh thread chaos_faster_hesh();
  level.hesh maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("020_jump"), 2000);

  if(distance2d(level.player.origin, level.hesh.origin) < 200)
    thread maps\youngblood_util::heavy_quake(100, 50);

  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_getacrossquick");
  common_scripts\utility::flag_set("hesh_sequence_done");
}

chaos_b() {
  common_scripts\utility::flag_wait("start_chaos_b");
  level.player endon("death");
  thread maps\youngblood_util::chaos_kill_if_too_far();
  level notify("stop_vfx_on_player");
  level.player_outside = 1;
  level.player_location_vfx = "vfx_yb_onplayer_city_vista_a";
  level.player thread vfx_on_player_location_to_odin();
  thread play_church_fall_think();
  common_scripts\utility::trigger_off("carry_hesh_carry_trig", "targetname");
  common_scripts\utility::trigger_off("trig_start_pickup", "targetname");
  level notify("stop_chaos_a");
  thread chaos_b_slow_zone();
  level.hesh maps\_utility::disable_exits();
  level.hesh thread maps\_utility::smart_dialogue("youngblood_hsh_justkeeprunning");

  if(level.start_point == "start_chaos_b")
    level.hesh maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("chaos_b_run"), 0);
  else
    level.hesh waittill("path_end_reached");

  var_0 = common_scripts\utility::get_target_ent("anim_tanker_orig");
  thread hesh_truck_run(var_0);
  var_1 = common_scripts\utility::get_target_ent("animate_cab");
  var_1 show();
  var_1.animname = "truck";
  var_1 maps\_anim::setanimtree();
  level waittill("hesh_in_position");
  wait 2.5;
  level.player playrumbleonentity("light_1s");
  var_1 maps\_utility::delaythread(0.45, maps\_utility::play_sound_on_entity, "scn_yb_truck_incoming");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "youngblood_semitanker_ygb_explode_A");
  var_0 thread maps\_anim::anim_single_solo(var_1, "youngblood_semitanker_ygb_explode_A");
  common_scripts\utility::flag_set("church_fall_go");
  maps\_utility::delaythread(2.0, common_scripts\utility::play_sound_in_space, "scn_yb_truck_ending_lr", level.player.origin);
  level.player common_scripts\utility::delaycall(2.2, ::playrumbleonentity, "light_1s");
  common_scripts\utility::noself_delaycall(2.6, ::setslowmotion, 1.0, 0.33, 0.1);
  common_scripts\utility::noself_delaycall(3.5, ::setslowmotion, 0.33, 1.0, 0.5);
  maps\_utility::music_play("mus_prlog_end_reveal");
  level.player maps\_utility::delaythread(3.3, ::player_fall_down, var_0, var_1);
  maps\_utility::activate_trigger_with_noteworthy("street_oil_tanker_2");
  maps\_utility::delaythread(3.2, maps\_utility::vision_set_fog_changes, "ygb_chaos_b", 0.4);
  common_scripts\utility::flag_wait("truck_landed_exit_scene");
  level.player setclienttriggeraudiozone("youngblood_tanker_fire", 3.0);
  var_1 delete();

  foreach(var_3 in level.a_debris)
  var_3 show();
}

player_fall_down(var_0, var_1) {
  if(!isalive(level.player)) {
    return;
  }
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.1);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.4);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("hurt", 0.25);
  soundsettimescalefactor("auto", 0.5);
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("cg_drawCrosshair", "0");
  setsaveddvar("aim_AutoAimRangeScale", 0);
  setsaveddvar("aim_aimAssistRangeScale", "1");
  setsaveddvar("r_znear", 0.5);
  maps\youngblood_util::viewmodel_anim_on();
  level.hesh.name = " ";
  var_2 = maps\_utility::spawn_anim_model("player_rig", self.origin);
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel(level.hesh.model);
  var_3.animname = "player_body";
  var_3 maps\_anim::setanimtree();
  level.player playerlinktoblend(var_2, "tag_player", 0.2);
  thread maps\_hud_util::fade_out(1.7);
  level.player setblurforplayer(10, 0.85);
  level.player playrumbleonentity("light_2s");
  level.player notify("player_safe");
  level.player shellshock("ygb_end", 999);
  var_4 = spawnStruct();
  var_4.origin = level.player.origin;
  var_4.angles = level.player.angles;

  if(!level.player maps\_utility::player_looking_at(var_1.origin, 0.7, 1)) {
    var_4.angles = vectortoangles(var_1.origin - level.player.origin);
    var_4.angles = (var_4.angles[0], var_4.angles[1], 0);
    var_2 hide();
    var_2 common_scripts\utility::delaycall(0.3, ::show);
    var_3 hide();
    var_3 common_scripts\utility::delaycall(0.3, ::show);
  }

  var_4 maps\_anim::anim_single([var_2, var_3], "youngblood_tanker_explosion");
  var_4 = undefined;
  common_scripts\utility::flag_set("truck_landed_exit_scene");
  level notify("stop_vfx_on_player");
  level.player_location_vfx = "vfx_yb_onplayer_09_truckfire";
  level.player thread vfx_on_player_location_to_odin();
  setslowmotion(1, 0.5, 0.25);
  wait 1;
  maps\_utility::delaythread(0.5, maps\youngblood_exit_ride::spawn_and_setup_elias);
  level.hesh maps\_utility::delaythread(1.25, maps\_utility::smart_dialogue, "youngblood_hsh_logan");
  maps\_utility::delaythread(0.0, maps\_utility::smart_radio_dialogue, "youngblood_hsh_coughing");
  wait 2;
  level.player unlink();
  var_2 hide();
  var_2 delete();
  var_3 delete();
  var_2 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_5 = 20;
  level.player playerlinktoabsolute(var_2, "tag_player");
  level.player playerlinktodelta(var_2, "tag_player", 1, var_5, var_5, var_5, 0);
  level.elias maps\_utility::delaythread(1.5, maps\_utility::smart_dialogue, "youngblood_els_heshlogan");
  level.hesh maps\_utility::delaythread(3.5, maps\_utility::smart_dialogue, "youngblood_hsh_dad_2");
  level.elias maps\_utility::delaythread(5, maps\_utility::smart_dialogue, "youngblood_els_getinthetruck");
  level.hesh maps\_utility::delaythread(6, maps\_utility::smart_dialogue, "youngblood_hsh_cmon_2");
  common_scripts\utility::exploder("city");
  var_6 = [var_2, level.hesh];
  var_0 = common_scripts\utility::get_target_ent("chaos_end_test");
  var_0 thread maps\_anim::anim_single(var_6, "walkoff");
  wait 0.1;
  common_scripts\utility::array_thread(var_6, maps\youngblood_util::_set_anim_time, "walkoff", 0.04);
  level.player setblurforplayer(0, 3);
  thread maps\_hud_util::fade_in(1);
  wait 3;
  level.player.better = 1;
  wait 4;
  level.player setblurforplayer(10, 1);
  maps\_hud_util::fade_out(2);
  var_2 hide();
  level.elias maps\_utility::delaythread(0, maps\_utility::smart_dialogue, "youngblood_els_isheokis");
  common_scripts\utility::waitframe();
  level.truck notify("elias_car_stop");
  level.elias unlink();
  common_scripts\utility::waitframe();
  var_0 = getvehiclenode("start_truck_part2_2", "script_noteworthy");
  level.truck attachpath(var_0);
  level.truck thread maps\_vehicle::vehicle_paths(var_0);
  level.truck startpath(var_0);
  var_6 = [var_2, level.hesh, level.elias];
  var_0 = common_scripts\utility::get_target_ent("chaos_end_test_2");
  var_0 thread maps\_anim::anim_single(var_6, "walkoff");
  wait 0.1;
  common_scripts\utility::array_thread(var_6, maps\youngblood_util::_set_anim_time, "walkoff", 0.715);
  level.player setblurforplayer(0, 3);
  thread maps\_hud_util::fade_in(2.2);
  wait 5.5;
  level.player setblurforplayer(10, 1);
  maps\_hud_util::fade_out(2);
  common_scripts\utility::flag_set("start_pickup");
}

hesh_truck_run(var_0) {
  var_0 maps\_anim::anim_reach_solo(level.hesh, "youngblood_tanker_hesh");
  level notify("hesh_in_position");
  level.hesh maps\_utility::disable_exits();
  level.hesh maps\_utility::delaythread(4.0, maps\_utility::smart_dialogue, "youngblood_hsh_lookout");
  var_0 maps\_anim::anim_single_solo(level.hesh, "youngblood_tanker_hesh");
  level.hesh maps\_utility::disable_exits();
}

chaos_b_hide_debris() {
  level.a_debris = getEntArray("truck_debris_array", "script_noteworthy");
  level.a_debris = common_scripts\utility::array_combine(level.a_debris, getEntArray("tanker_debris", "targetname"));

  foreach(var_1 in level.a_debris)
  var_1 hide();
}

chaos_b_slow_zone() {
  maps\_utility::trigger_wait_targetname("chaos_b_slow_zone");
  level.player maps\youngblood_util::yb_player_speed_percent(20, 2);
  level.player allowsprint(0);
}

player_chaos_heartbeat() {
  level endon("stop_player_chaos_audio");
  level endon("death");

  for(;;) {
    wait(randomfloatrange(1, 2));
    level.player thread maps\_utility::play_sound_on_entity("plr_heartbeat");
  }
}

play_distant_cloud_sounds() {
  self endon("player_near_mansion_exit");
  var_0 = (-2965, -102971, -113841);
  var_1 = (-1179, -100516, -113306);
  var_2 = (706, -100274, -113447);
  var_3 = [var_0, var_1, var_2];
  level.cloud_sfx_base_wait_min = 0.2;
  level.cloud_sfx_base_wait_max = 0.6;
  level.cloud_sfx_design_wait_min = 2.0;
  level.cloud_sfx_design_wait_max = 4.3;
  thread play_distant_cloud_base(var_3);
  thread play_distant_cloud_design(var_3);
}

play_distant_cloud_base(var_0) {
  self endon("player_near_mansion_exit");

  for(;;) {
    var_1 = common_scripts\utility::random(var_0);
    thread common_scripts\utility::play_sound_in_space("yb_rog_distant", var_1);
    var_2 = randomfloatrange(level.cloud_sfx_base_wait_min, level.cloud_sfx_base_wait_max);
    wait(var_2);
  }
}

play_distant_cloud_design(var_0) {
  self endon("player_near_mansion_exit");
  wait 2;
  var_1 = common_scripts\utility::random(var_0);
  thread common_scripts\utility::play_sound_in_space("yb_rog_distant_design_first", var_1);
  var_2 = randomfloatrange(0.8, 0.85);
  wait(var_2);
  var_1 = common_scripts\utility::random(var_0);
  thread common_scripts\utility::play_sound_in_space("yb_rog_distant_design_second", var_1);
  var_2 = randomfloatrange(level.cloud_sfx_design_wait_min, level.cloud_sfx_design_wait_max);
  wait(var_2);

  for(;;) {
    var_1 = common_scripts\utility::random(var_0);
    thread common_scripts\utility::play_sound_in_space("yb_rog_distant_design", var_1);
    var_2 = randomfloatrange(0.5, 0.8);
    wait(var_2);
    var_1 = common_scripts\utility::random(var_0);
    thread common_scripts\utility::play_sound_in_space("yb_rog_distant_design", var_1);
    var_2 = randomfloatrange(level.cloud_sfx_design_wait_min, level.cloud_sfx_design_wait_max);
    wait(var_2);
  }
}

player_chaos_breathing() {
  level endon("stop_player_chaos_audio");
  level endon("death");
  level.player maps\_utility::play_sound_on_entity("breathing_hurt_start");
  var_0 = 1;

  for(;;) {
    wait(var_0);

    if(!isDefined(level.player.better))
      level.player maps\_utility::play_sound_on_entity("breathing_hurt");
    else
      level.player maps\_utility::play_sound_on_entity("breathing_better");

    var_0 = var_0 + 0.15;
  }
}

pickup() {
  common_scripts\utility::flag_wait("start_pickup");
  thread maps\youngblood_exit_ride::exit_ride_setup();
}

player_fall_down_trigger() {
  self waittill("trigger");
  maps\youngblood_util::viewmodel_anim_on();
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_1 = 0;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  level.player maps\_anim::anim_single_solo(var_0, "youngblood_player_fall_down");
  maps\youngblood_util::viewmodel_anim_off();
  var_0 delete();
  level.player setorigin(level.player.origin + (0, 0, 24));
}

n_door_knock() {
  var_0 = getent("n_knock_m", "script_noteworthy");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 thread maps\youngblood_util::init_jog_animset_alert();
  var_1 thread maps\_anim::anim_generic_loop(var_1, "london_civ_idle_wave");
  common_scripts\utility::flag_wait("player_past_fence");
  var_1 stopanimscripted();
  var_2 = getnode("house_across_street", "targetname");
  var_1 thread delete_on_path_end(var_2);
}

n_watchers() {
  common_scripts\utility::flag_wait("player_area_3");
  var_0 = maps\_utility::array_spawn_targetname("n_watchers");
  thread civ_walla(var_0);
}

civ_walla(var_0) {
  var_1 = ["youngblood_dad2_dannygetyourass", "youngblood_mom1_butthedog", "youngblood_dad1_wecantcarryanymore", "youngblood_kid2_idontwantto"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0 = common_scripts\utility::array_removeundefined(var_0);

    if(var_0.size == 0) {
      return;
    }
    var_3 = var_2 % var_0.size;
    var_0[var_3] maps\_utility::play_sound_on_entity(var_1[var_2]);
    wait(randomfloatrange(0.5, 1));
  }
}

n_watchers_think() {
  var_0 = common_scripts\utility::get_target_ent();
  maps\_utility::set_generic_run_anim("unarmed_panickedrun_loop_V2");
  maps\_utility::set_generic_idle_anim("youngblood_hesh_calm_idle");
  self.moveplaybackrate = self.script_moveplaybackrate;
  self.goalradius = 128;
  maps\_utility::walkdist_zero();
  maps\_utility::disable_exits();
  maps\_utility::disable_arrivals();
  self pushplayer(1);

  if(isDefined(self.script_soundalias)) {
    self.animname = "generic";
    maps\_utility::delaythread(randomfloatrange(0.5, 1), maps\_utility::play_sound_on_entity, self.script_soundalias);
  }

  maps\_utility::follow_path_and_animate(var_0, 0);
  wait 1;

  while(maps\_utility::player_looking_at(self getEye(), 0.6, 1))
    wait 0.1;

  self delete();
}

delete_on_path_end(var_0) {
  maps\_utility::set_goal_radius(16);
  self setgoalnode(var_0);
  maps\_utility::enable_sprint();
  self waittill("goal");
  self delete();
}

n_vehicle_1() {}

n_vehicle_2() {
  level.car_1 = maps\_vehicle::spawn_vehicle_from_targetname("n_car_2");
  level.car_1.animname = "coupe";
  level.car_1 useanimtree(level.scr_animtree["coupe"]);
  common_scripts\utility::flag_wait("load_car_1");
  var_0 = getent("car_2_m", "script_noteworthy");
  var_1 = var_0 maps\_utility::spawn_ai();
  thread n_vehicle_2_anim_link_guy(var_1);
  common_scripts\utility::flag_wait("passenger_1_in");
  level.car_1 n_vehicle_2_leave();
  level.car_1.veh_transmission = "forward";
  level.car_1 maps\_vehicle::vehicle_wheels_forward();
  var_2 = getvehiclenode("n_car_2_exit", "targetname");
  level.car_1 attachpath(var_2);
  level.car_1 thread maps\_vehicle::vehicle_paths(var_2);
  level.car_1 startpath(var_2);
  level.car_1 maps\_utility::play_sound_on_entity("scn_yb_second_car_peel_out");
  level.car_1 thread neighborhood_vehicle_damage(level.car_1);
  level.car_1 thread neighborhood_vehicle_delete();
}

n_vehicle_3() {}

n_vehicle_2_leave() {
  self.veh_transmission = "reverse";
  maps\_vehicle::vehicle_wheels_backward();
  var_0 = getvehiclenode("n_car_2_reverse_out", "targetname");
  level.car_1 attachpath(var_0);
  level.car_1 thread maps\_vehicle::vehicle_paths(var_0);
  level.car_1 startpath(var_0);
  level.car_1 waittill("reached_end_node");
}

n_vehicle_2_anim_link_guy(var_0) {
  level.car_1 maps\_anim::anim_generic_reach(var_0, "YB_car_entrance_driver_B", "tag_driver");
  level.car_1 thread maps\_anim::anim_single_solo(level.car_1, "YB_car_entrance_driver_B_car");
  level.car_1 maps\_anim::anim_generic(var_0, "YB_car_entrance_driver_B", "tag_driver");
  level.car_1 thread maps\_anim::anim_generic_loop(var_0, "car_sitting_idle_driver", "stop_loop", "tag_driver");
  var_0 linkto(level.car_1);
  common_scripts\utility::flag_set("passenger_1_in");
}

damage_player_in_fire() {
  level endon("player_on_truck");

  for(;;) {
    wait 0.2;

    if(level.player.health == level.player.maxhealth)
      level.player dodamage(100, (0, 0, 0));
  }
}

player_falls_down_flat() {
  level.player thread maps\_utility::play_sound_on_entity("scn_yb_house_collapse");
  level.player maps\youngblood_util::yb_player_speed_percent(25);
  maps\youngblood_util::viewmodel_anim_on();
  earthquake(0.4, 3.3, level.player.origin, 64);
  level.player playrumbleonentity("heavy_3s");
  common_scripts\utility::exploder("mansion_door_crash");
  thread common_scripts\utility::exploder("exp15");
  maps\_utility::delaythread(1.3, ::mansion_debris_switch);
  thread common_scripts\utility::play_sound_in_space("scn_quake_13_plr_stumble", level.player.origin);
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.player.origin;
  var_0.angles = level.player.angles;
  common_scripts\utility::waitframe();
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var_1 show();
  level.player playerlinktoblend(var_1, "tag_player", 0.1);
  var_1 thread maps\_anim::anim_single_solo(var_1, "youngblood_player_fall_down");
  level.player shellshock("ygb_crash", 4.5);
  wait 1.5;
  var_1 common_scripts\utility::delaycall(0.5, ::hide);
  level.player playerlinktoblend(var_1, "tag_origin", 1.5, 0, 0.5);
  wait 1;
  level.player allowcrouch(1);
  level.player allowstand(0);
  wait 0.55;
  level.player unlink();
  var_1 delete();
  maps\youngblood_util::viewmodel_anim_off();
  level.player maps\youngblood_util::yb_player_speed_percent(50, 2);
}

mansion_debris_switch() {
  var_0 = common_scripts\utility::getstruct("mansion_destruction_ref", "targetname");
  var_1 = common_scripts\utility::get_target_ent("mansion_destruction_piece");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
}

player_wobbles() {
  level.player maps\youngblood_util::yb_player_speed_percent(25);
  maps\youngblood_util::viewmodel_anim_on();
  thread maps\youngblood_util::heavy_quake(50);
  thread common_scripts\utility::exploder("exp14");
  thread exp14_sounds();
  thread common_scripts\utility::play_sound_in_space("scn_quake_11", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("scn_yb_house_rattle_lr", level.player.origin);
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var_0 linktoplayerview(level.player, "tag_player", (0, 0, 0), (0, 0, 0), 1);
  var_0 setanim(var_0 maps\_utility::getanim("youngblood_player_wobble_1"), 1, 0, 1);
  wait 2.5;
  var_0 unlink();
  var_0 delete();
  maps\youngblood_util::viewmodel_anim_off();
  level.player maps\youngblood_util::yb_player_speed_percent(80, 2);
}

trigger_threads_after_chaos() {
  if(!maps\_utility::game_is_current_gen())
    common_scripts\utility::array_thread(getEntArray("house_falls_apart", "targetname"), ::play_house_fall_think);

  var_0 = getEntArray("church_pieces", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();

  var_4 = common_scripts\utility::get_target_ent("animate_cab");
  var_4 hide();
  var_5 = common_scripts\utility::getstruct("church_first_frame", "targetname");
  level.fake_church = spawn("script_model", var_5.origin);
  level.fake_church.angles = var_5.angles;
  level.fake_church setModel("vfx_ygb_churchcollapse_first_frame");
}

trigger_interior_detect() {
  level endon("stop_chaos_a");
  var_0 = common_scripts\utility::get_target_ent("chaos_interior_volume");
  var_1 = common_scripts\utility::get_target_ent("chaos_interior_volume1");

  for(;;) {
    wait 0.1;

    if(level.player istouching(var_0) || level.player istouching(var_1)) {
      level.player_outside = 0;
      continue;
    }

    level.player_outside = 1;
  }
}

vfx_on_player_location_to_odin() {
  level endon("stop_vfx_on_player");

  for(;;) {
    wait 0.6;
    var_0 = anglesToForward(level.player.angles) * 96;
    playFX(common_scripts\utility::getfx(level.player_location_vfx), level.player.origin + var_0);
  }
}

deer_stampede_logic() {
  common_scripts\utility::flag_wait("deer_stampede");
  level.plume_sound = common_scripts\utility::spawn_tag_origin();
  level.plume_sound.origin = (-2055, -101789, -111164);
  level.plume_sound playSound("yb_rog_distant_orange_plume");
  thread common_scripts\utility::exploder("exp05");
  wait 1;
  thread neighborhood_dialogue();
}

chaos_faster_hesh() {
  level.player endon("death");
  level endon("stop_chaos_faster_hesh");

  while(level.player_anim_not_on) {
    wait 0.1;
    var_0 = vectornormalize(level.player.origin - level.hesh.origin);
    var_1 = anglesToForward(level.hesh.angles);
    var_2 = vectordot(var_1, var_0);
    var_3 = distance(level.player.origin, level.hesh.origin);

    if(var_3 < 20 && var_2 < 0) {
      level.hesh maps\_utility::disable_sprint();
      maps\_utility::disable_exits();
      level.hesh maps\youngblood_util::set_move_rate(1.05);
      continue;
    }

    var_0 = vectornormalize(level.player.origin - level.hesh.origin);
    var_1 = anglesToForward(level.hesh.angles);
    var_2 = vectordot(var_1, var_0);

    if(var_2 > 0) {
      level.hesh maps\_utility::enable_sprint();
      maps\_utility::disable_exits();
      continue;
    }

    level.hesh maps\_utility::disable_sprint();
    maps\_utility::disable_exits();
    level.hesh maps\youngblood_util::set_move_rate(1.05);
  }
}

chaos_quake_trigger_think() {
  self waittill("trigger");
  thread maps\youngblood_util::heavy_quake(100, 50);
}

yb_save_trigger() {
  self waittill("trigger");
  thread maps\_utility::autosave_now_silent();
}

setup_play_street_2_anims_think() {
  var_0 = common_scripts\utility::get_target_ent("chaos_street_pos");
  var_1 = getent("chunk_main_f", "targetname");
  var_2 = common_scripts\utility::getstruct("chunk_main_f_pos", "targetname");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_1.origin;
  var_3.angles = var_1.angles;
  var_3.animname = "moving_pieces";
  var_3 maps\_anim::setanimtree();
  var_1 linkto(var_3);
  var_0 maps\_anim::anim_first_frame_solo(var_3, "youngblood_chaos_chunk_f");
  var_4 = getent("chunk_main_g", "targetname");
  var_5 = common_scripts\utility::getstruct("chunk_main_g_pos", "targetname");
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_4.origin;
  var_6.angles = var_4.angles;
  var_6.animname = "moving_pieces";
  var_6 maps\_anim::setanimtree();
  var_4 linkto(var_6);
  var_0 maps\_anim::anim_first_frame_solo(var_6, "youngblood_chaos_chunk_g");
  var_7 = getent("chunk_main_n", "targetname");
  var_8 = common_scripts\utility::getstruct("chunk_main_n_pos", "targetname");
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.origin = var_7.origin;
  var_9.angles = var_7.angles;
  var_9.animname = "moving_pieces";
  var_9 maps\_anim::setanimtree();
  var_7 linkto(var_9);
  var_0 maps\_anim::anim_first_frame_solo(var_9, "youngblood_chaos_chunk_n");
  var_10 = getent("chunk_main_h", "targetname");
  var_11 = common_scripts\utility::getstruct("chunk_main_h_pos", "targetname");
  var_12 = common_scripts\utility::spawn_tag_origin();
  var_12.origin = var_10.origin;
  var_12.angles = var_10.angles;
  var_12.animname = "moving_pieces";
  var_12 maps\_anim::setanimtree();
  var_10 linkto(var_12);
  var_0 maps\_anim::anim_first_frame_solo(var_12, "youngblood_chaos_chunk_h");
  var_13 = getent("chunk_main_j", "targetname");
  var_14 = common_scripts\utility::getstruct("chunk_main_j_pos", "targetname");
  var_15 = common_scripts\utility::spawn_tag_origin();
  var_15.origin = var_13.origin;
  var_15.angles = var_13.angles;
  var_15.animname = "moving_pieces";
  var_15 maps\_anim::setanimtree();
  var_13 linkto(var_15);
  var_0 maps\_anim::anim_first_frame_solo(var_15, "youngblood_chaos_chunk_j");
  var_16 = getent("chunk_main_j1", "targetname");
  var_17 = common_scripts\utility::getstruct("chunk_main_j1_pos", "targetname");
  var_18 = common_scripts\utility::spawn_tag_origin();
  var_18.origin = var_16.origin;
  var_18.angles = var_16.angles;
  var_18.animname = "moving_pieces";
  var_18 maps\_anim::setanimtree();
  var_16 linkto(var_18);
  var_0 maps\_anim::anim_first_frame_solo(var_18, "youngblood_chaos_chunk_j1");
  var_19 = getent("chunk_main_k", "targetname");
  var_20 = common_scripts\utility::getstruct("vfx_yb_house_h_furniture_a", "targetname");
  var_21 = common_scripts\utility::getstruct("vfx_yb_house_h_dustfall_a", "targetname");
  var_22 = common_scripts\utility::getstruct("vfx_yb_house_h_dustfall_b", "targetname");
  var_23 = common_scripts\utility::spawn_tag_origin();
  var_23.origin = var_20.origin;
  var_23.angles = var_20.angles;
  var_24 = common_scripts\utility::spawn_tag_origin();
  var_24.origin = var_21.origin;
  var_24.angles = var_21.angles;
  var_25 = common_scripts\utility::spawn_tag_origin();
  var_25.origin = var_22.origin;
  var_25.angles = var_22.angles;
  var_26 = common_scripts\utility::getstruct("chunk_main_k_pos", "targetname");
  var_27 = common_scripts\utility::spawn_tag_origin();
  var_27.origin = var_19.origin;
  var_27.angles = var_19.angles;
  var_27.animname = "moving_pieces";
  var_27 maps\_anim::setanimtree();
  var_23 linkto(var_27);
  var_24 linkto(var_27);
  var_25 linkto(var_27);
  var_19 linkto(var_27);
  var_0 maps\_anim::anim_first_frame_solo(var_27, "youngblood_chaos_chunk_k_1");
  var_28 = getent("chunk_main_l", "targetname");
  var_29 = common_scripts\utility::getstruct("chunk_main_l_pos", "targetname");
  var_30 = common_scripts\utility::spawn_tag_origin();
  var_30.origin = var_28.origin;
  var_30.angles = var_28.angles;
  var_30.animname = "moving_pieces";
  var_30 maps\_anim::setanimtree();
  var_28 linkto(var_30);
  var_0 maps\_anim::anim_first_frame_solo(var_30, "youngblood_chaos_chunk_l");
  var_31 = getent("chunk_main_m", "targetname");
  var_32 = common_scripts\utility::getstruct("chunk_main_m_pos", "targetname");
  var_33 = common_scripts\utility::spawn_tag_origin();
  var_33.origin = var_31.origin;
  var_33.angles = var_31.angles;
  var_33.animname = "moving_pieces";
  var_33 maps\_anim::setanimtree();
  var_31 linkto(var_33);
  var_0 maps\_anim::anim_first_frame_solo(var_33, "youngblood_chaos_chunk_m");
  self waittill("trigger");
  thread sfx_for_street_chunks(var_3.origin);
  thread sfx_loop_sound_for_anim_chunk(var_1, "scn_yb_destruct_loop_sub1");
  thread sfx_loop_sound_for_anim_chunk(var_4, "scn_yb_destruct_loop_rocks1");
  thread sfx_loop_sound_for_anim_chunk(var_13, "scn_yb_destruct_loop_rocks2");
  thread sfx_loop_sound_for_anim_chunk(var_7, "scn_yb_destruct_loop_rocks3");
  thread sfx_loop_sound_for_anim_chunk(var_28, "scn_yb_destruct_loop_rocks2");
  thread sfx_loop_sound_for_anim_chunk(var_31, "scn_yb_destruct_loop_rocks1");
  var_0 thread maps\_anim::anim_single_solo(var_3, "youngblood_chaos_chunk_f");
  var_0 thread maps\_anim::anim_single_solo(var_6, "youngblood_chaos_chunk_g");
  var_0 thread maps\_anim::anim_single_solo(var_9, "youngblood_chaos_chunk_n");
  var_0 thread maps\_anim::anim_single_solo(var_12, "youngblood_chaos_chunk_h");
  var_0 thread maps\_anim::anim_single_solo(var_15, "youngblood_chaos_chunk_j");
  var_0 thread maps\_anim::anim_single_solo(var_18, "youngblood_chaos_chunk_j1");
  var_0 thread maps\_anim::anim_single_solo(var_30, "youngblood_chaos_chunk_l");
  var_0 thread maps\_anim::anim_single_solo(var_33, "youngblood_chaos_chunk_m");
  thread play_street_2_k_move(var_0, var_27, var_23, var_24, var_25, var_19);
}

sfx_for_p_r_s_t_pieces() {
  self waittill("trigger");
  var_0 = getent("chunk_main_p", "targetname");
  var_1 = getent("street_jump_house", "targetname");
  var_2 = getent("chunk_main_s", "targetname");
  var_3 = getent("chunk_main_t", "targetname");
  var_0 thread sfx_loop_for_mover_piece(11.5, 1, 4, "scn_yb_destruct_loop_rocks2");
  var_1 thread sfx_loop_for_mover_piece(8, 1, 4.5, "scn_yb_destruct_loop_rocks3");
  var_2 thread sfx_loop_for_mover_piece(13.5, 1, 5.5, "scn_yb_destruct_loop_rocks1");
  var_3 thread sfx_loop_for_mover_piece(15, 1, 6, "scn_yb_destruct_loop_rocks2");
}

sfx_loop_for_mover_piece(var_0, var_1, var_2, var_3) {
  self playLoopSound(var_3);
  self scalevolume(0.0, 0.0);
  waittillframeend;
  self scalevolume(1.0, var_1);
  var_4 = var_0 - var_2;
  wait(var_4);
  self scalevolume(0.0, var_2);
  wait(var_2);
  self stoploopsound();
}

sfx_for_street_destroy(var_0, var_1, var_2) {
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("scn_yb_street1_collapse_left", var_0);
  thread common_scripts\utility::play_sound_in_space("scn_yb_street1_collapse_center", var_1);
  thread common_scripts\utility::play_sound_in_space("scn_yb_street1_collapse_center_lfe", var_1);
  thread common_scripts\utility::play_sound_in_space("scn_yb_street1_collapse_right", var_2);
  wait 4;
  maps\_utility::delaythread(0.8, common_scripts\utility::play_sound_in_space, "mtl_water_pipe_burst", (-418, -102797, -114713));
  wait 2;
  maps\_utility::delaythread(1.9, common_scripts\utility::play_sound_in_space, "mtl_water_pipe_burst", (-243, -101768, -114738));
  maps\_utility::delaythread(2.7, common_scripts\utility::play_sound_in_space, "mtl_water_pipe_burst", (-346, -101833, -114811));
}

sfx_for_street_chunks(var_0) {
  thread common_scripts\utility::play_sound_in_space("scn_yb_street2_collapse_center", var_0);
  wait 7;
  maps\_utility::delaythread(1.9, common_scripts\utility::play_sound_in_space, "mtl_water_pipe_burst", (-292, -100801, -114839));
  maps\_utility::delaythread(3.0, common_scripts\utility::play_sound_in_space, "mtl_water_pipe_burst", (-412, -100459, -115061));
}

sfx_loop_sound_for_anim_chunk(var_0, var_1) {
  var_0 playLoopSound(var_1);
  var_0 scalevolume(0.0, 0.0);
  wait 0.1;
  var_0 scalevolume(1.0, 2.0);
  wait 7;
  var_0 scalevolume(0.0, 3.0);
  wait 3;
  var_0 stoploopsound();
}

play_street_2_k_move(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread sfx_loop_sound_for_anim_chunk(var_5, "scn_yb_destruct_loop_wood1");
  var_0 maps\_anim::anim_single_solo(var_1, "youngblood_chaos_chunk_k_1");
  wait 1.0;
  var_5 thread play_2_k_sfx("scn_yb_house_move_ext_right", "scn_yb_house_move_ext_left");
  var_0 maps\_anim::anim_single_solo(var_1, "youngblood_chaos_chunk_k_2");
  playFXOnTag(common_scripts\utility::getfx("vfx_yb_house_h_dustfall_a"), var_3, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("vfx_yb_house_h_dustfall_a"), var_4, "tag_origin");
  common_scripts\utility::flag_wait("house_k2_k3_anim");
  thread sfx_loop_sound_for_anim_chunk(var_5, "scn_yb_destruct_loop_wood1");
  var_5 maps\_utility::delaythread(1.0, ::play_2_k_sfx, "scn_yb_house_move_int_right", "scn_yb_house_move_int_left");
  var_0 thread maps\_anim::anim_single_solo(var_1, "youngblood_chaos_chunk_k_3");
  playFXOnTag(common_scripts\utility::getfx("vfx_yb_house_h_furniture_a"), var_2, "tag_origin");
}

play_2_k_sfx(var_0, var_1) {
  var_2 = spawn("script_origin", self.origin + (450, 0, 200));
  var_3 = spawn("script_origin", self.origin + (-150, 0, 200));
  var_2 linkto(self);
  var_3 linkto(self);
  var_2 playSound(var_0, "soundrightdone");
  var_3 playSound(var_1, "soundleftdone");
  var_2 thread waittill_delete("soundrightdone");
  var_3 thread waittill_delete("soundleftdone");
}

waittill_delete(var_0) {
  self waittill(var_0);
  self delete();
}

setup_play_chaos_chunk_anims() {
  var_0 = common_scripts\utility::get_target_ent("mansion_anim_ref");
  var_1 = getent("chunk_main_a", "targetname");
  var_2 = common_scripts\utility::getstruct("chunk_main_a_pos", "targetname");
  var_3 = maps\_utility::spawn_anim_model("tag_origin", var_2.origin);
  var_3.angles = var_2.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_3, "youngblood_chaos_chunk_a");
  var_1.origin = var_3.origin;
  var_1.angles = var_3.angles;
  var_1 linkto(var_3, "tag_origin");
  var_4 = getent("chunk_main_b", "targetname");
  var_5 = common_scripts\utility::getstruct("chunk_main_b_pos", "targetname");
  var_6 = maps\_utility::spawn_anim_model("tag_origin", var_5.origin);
  var_6.angles = var_5.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_6, "youngblood_chaos_chunk_b");
  var_4.origin = var_6.origin;
  var_4.angles = var_6.angles;
  var_4 linkto(var_6, "tag_origin");
  var_7 = getent("chunk_main_c", "targetname");
  var_8 = common_scripts\utility::getstruct("chunk_main_c_pos", "targetname");
  var_9 = maps\_utility::spawn_anim_model("tag_origin", var_8.origin);
  var_9.angles = var_8.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_9, "youngblood_chaos_chunk_c");
  var_7.origin = var_9.origin;
  var_7.angles = var_9.angles;
  var_7 linkto(var_9, "tag_origin");
  var_10 = getent("chunk_main_d", "targetname");
  var_11 = common_scripts\utility::getstruct("chunk_main_d_pos", "targetname");
  var_12 = maps\_utility::spawn_anim_model("tag_origin", var_11.origin);
  var_12.angles = var_11.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_12, "youngblood_chaos_chunk_d");
  var_10.origin = var_12.origin;
  var_10.angles = var_12.angles;
  var_10 linkto(var_12, "tag_origin");
  var_13 = getent("chunk_main_e", "targetname");
  var_14 = common_scripts\utility::getstruct("chunk_main_e_pos", "targetname");
  var_15 = maps\_utility::spawn_anim_model("tag_origin", var_14.origin);
  var_15.angles = var_14.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_15, "youngblood_chaos_chunk_e");
  var_13.origin = var_15.origin;
  var_13.angles = var_15.angles;
  var_13 linkto(var_15, "tag_origin");
  waittillframeend;
  common_scripts\utility::flag_set("load_1");
  common_scripts\utility::flag_wait("play_street_cracking");
  thread vfx_for_street_destroy(var_0);
  thread sfx_for_street_destroy(var_3.origin, var_9.origin, var_12.origin);
  thread sfx_loop_sound_for_anim_chunk(var_4, "scn_yb_destruct_loop_sub1");
  var_0 thread maps\_anim::anim_single_solo(var_3, "youngblood_chaos_chunk_a");
  var_0 thread maps\_anim::anim_single_solo(var_6, "youngblood_chaos_chunk_b");
  var_0 thread maps\_anim::anim_single_solo(var_9, "youngblood_chaos_chunk_c");
  var_0 thread maps\_anim::anim_single_solo(var_12, "youngblood_chaos_chunk_d");
  var_0 thread maps\_anim::anim_single_solo(var_15, "youngblood_chaos_chunk_e");
  common_scripts\utility::flag_set("chaos_hesh_go");
}

vfx_for_street_destroy(var_0) {
  maps\_utility::delaythread(0.0, common_scripts\utility::exploder, "c");
  maps\_utility::delaythread(0.05, common_scripts\utility::exploder, "a");
  maps\_utility::delaythread(0.1, common_scripts\utility::exploder, "e");
}

play_street_crack_1_think() {
  var_0 = common_scripts\utility::getstruct("ref_street_crack_piece", "targetname");
  var_0.no_delete = 1;
  var_0.origin = var_0.origin + (0, 0, 0);
  var_1 = getEntArray("ygb_roadcrack_street_1", "script_noteworthy");
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_4.animname = var_4.targetname;
    var_4 useanimtree(level.scr_animtree["street_crack_1"]);
    var_4.origin = var_0.origin;
    var_4.angles = var_0.angles;
    var_5 = getanimlength(var_4 maps\_utility::getanim("crack"));

    if(var_2 < var_5)
      var_2 = var_5;

    var_4 hide();
  }

  var_7 = getent("roadcrack_0", "targetname");
  var_8 = spawnStruct();
  var_8.origin = var_7.origin;
  var_8.angles = var_7.angles;
  waittillframeend;
  common_scripts\utility::flag_set("load_2");
  common_scripts\utility::flag_wait("play_street_cracking");
  var_9 = anglesToForward(var_8.angles);
  var_10 = anglestoup(var_8.angles);
  playFX(common_scripts\utility::getfx("vfx_ygb_roadcrack_set01_debris"), var_8.origin, var_9, var_10);

  foreach(var_4 in var_1) {
    var_4 common_scripts\utility::delaycall(0.0, ::show);
    var_4 common_scripts\utility::delaycall(0.5, ::movez, 4.5, 0.5);
    var_4 setflaggedanim("crack", var_4 maps\_utility::getanim("crack"), 1, 0.1);
    var_4 thread delete_on_crack1_done();
  }

  wait(var_2 - 1.125);
  var_13 = spawn("script_model", var_0.origin + (0, 0, 4.5));
  var_13.angles = var_0.angles;
  var_13 setModel("vfx_ygb_roadcrack_a_to_e_last_frame");
}

delete_on_crack1_done() {
  if(isDefined(self.no_delete)) {
    return;
  }
  wait 8;
  self delete();
}

spawn_street_fake_first_frame() {
  var_0 = common_scripts\utility::getstruct("ref_fake_street_crack", "targetname");
  var_1 = spawn("script_model", var_0.origin + (0, 0, -0.5));
  var_1.angles = var_0.angles;
  var_1 setModel("vfx_ygb_roadcrack_a_to_e_first_frame");
  common_scripts\utility::flag_wait("play_street_cracking");
  wait 0.5;
  var_1 delete();
}

play_house_fall_think() {
  var_0 = getent("house_cliff_0", "targetname");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_2 = [];
  var_2 = common_scripts\utility::array_combine(var_2, getEntArray("house_pieces", "script_noteworthy"));
  var_2 = common_scripts\utility::array_combine(var_2, getEntArray("house_cliff_pieces", "script_noteworthy"));
  var_2 = common_scripts\utility::array_combine(var_2, getEntArray("house_roof_pieces", "script_noteworthy"));
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5.animname = var_5.targetname;
    var_5 useanimtree(level.scr_animtree["falling_house"]);
    var_6 = getanimlength(var_5 maps\_utility::getanim("fall"));

    if(var_3 < var_6)
      var_3 = var_6;

    var_5 hide();
  }

  self waittill("trigger");
  common_scripts\utility::exploder("house_collapse_smoke");
  var_8 = anglesToForward(var_1.angles);
  var_9 = anglestoup(var_1.angles);
  playFX(common_scripts\utility::getfx("vfx_ygb_housecollapse_debris"), var_1.origin, var_8, var_9);

  foreach(var_5 in var_2) {
    var_5 show();
    var_5 setflaggedanim("fall", var_5 maps\_utility::getanim("fall"), 1, 0.1);
    var_5 thread delete_on_house_done();
  }

  wait(var_3);
}

delete_on_house_done() {
  if(isDefined(self.no_delete)) {
    return;
  }
  self waittillmatch("fall", "end");
  self delete();
}

play_church_fall_think() {
  var_0 = getent("church_piece_0", "targetname");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_2 = getEntArray("church_pieces", "script_noteworthy");
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5.animname = var_5.targetname;
    var_5 useanimtree(level.scr_animtree["church_tanker"]);
    var_6 = getanimlength(var_5 maps\_utility::getanim("collapse"));

    if(var_3 < var_6)
      var_3 = var_6;
  }

  common_scripts\utility::flag_wait("church_fall_go");
  var_8 = anglesToForward(var_1.angles);
  var_9 = anglestoup(var_1.angles);
  playFX(common_scripts\utility::getfx("vfx_ygb_church_collapse_debris"), var_1.origin, var_8, var_9);

  if(isDefined(level.fake_church))
    level.fake_church common_scripts\utility::delaycall(2.5, ::hide);

  foreach(var_5 in var_2) {
    var_5 common_scripts\utility::delaycall(2.45, ::show);
    var_5 setflaggedanim("collapse", var_5 maps\_utility::getanim("collapse"), 1, 0.1);
    var_5 thread delete_on_church_done();
  }

  wait(var_3);
}

delete_on_church_done() {
  if(isDefined(self.no_delete)) {
    return;
  }
  wait 5;
  self delete();
}

play_street_crack_2_think() {
  var_0 = common_scripts\utility::getstruct("street_crack_2_ref_struct", "targetname");
  var_0.no_delete = 1;
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_2 = getEntArray("street_crack_2_pieces", "script_noteworthy");
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5.animname = var_5.targetname;
    var_5 useanimtree(level.scr_animtree["street_crack_2"]);
    var_6 = getanimlength(var_5 maps\_utility::getanim("crack"));

    if(var_3 < var_6)
      var_3 = var_6;

    var_5 hide();
  }

  common_scripts\utility::flag_set("load_3");
  self waittill("trigger");
  var_8 = anglesToForward(var_1.angles);
  var_9 = anglestoup(var_1.angles);
  playFX(common_scripts\utility::getfx("vfx_ygb_roadcrack_set02_debris"), var_1.origin, var_8, var_9);

  foreach(var_5 in var_2) {
    var_5 show();
    var_5 setflaggedanim("crack", var_5 maps\_utility::getanim("crack"), 1, 0.1);
    var_5 thread delete_on_crack2_done();
  }

  common_scripts\utility::exploder("crack2");
  wait(var_3);
}

delete_on_crack2_done() {
  if(isDefined(self.no_delete)) {
    return;
  }
  wait 10;
  self delete();
}

chaos_hide_on_start() {
  var_0 = getEntArray("ygb_roadcrack_street_1", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();

  var_0 = [];
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("house_pieces", "script_noteworthy"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("house_cliff_pieces", "script_noteworthy"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("house_roof_pieces", "script_noteworthy"));

  foreach(var_2 in var_0)
  var_2 hide();

  var_0 = getEntArray("street_crack_2_pieces", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();

  var_0 = getEntArray("church_pieces", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();

  var_10 = common_scripts\utility::get_target_ent("animate_cab");
  var_10 hide();
}

_playSound(var_0, var_1, var_2) {
  self playsoundatviewheight(var_0);
}