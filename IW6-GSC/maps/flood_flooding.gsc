/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_flooding.gsc
*****************************************************/

section_

section_precache() {
  precachemodel("flood_angryflood_edge_tracker_0");
  precachemodel("flood_angryflood_big_wave_1");
  precachemodel("flood_alley_flood_near_trackers");
  precachemodel("flood_alley_flood_far_trackers");
  precachemodel("com_coffee_machine_destroyed");
  precachemodel("road_barrier_post");
  precachemodel("com_trafficcone01");
  precachemodel("cardboard_box03_iw6");
  precachemodel("com_cardboardboxshortclosed_1");
  precachemodel("flood_framed_picture_bw_01");
  precachemodel("intro_wood_floorboard_piece02");
  precachemodel("intro_wood_floorboard_piece03");
  precachemodel("intro_wood_floorboard_piece01");
  precachemodel("flood_framed_picture_bw_02");
  precachemodel("flood_crate_plastic_single02");
  precachemodel("com_plastic_crate_pallet");
  precachemodel("com_barrel_green");
  precachemodel("street_trashcan_open_iw6");
  precachemodel("com_folding_chair");
  precachemodel("com_trafficcone02");
  precachemodel("com_plasticcase_beige_big_iw6");
  precachemodel("com_pallet_2");
  precachemodel("cardboard_box02_iw6");
  precachemodel("furniture_shelf_wood_1");
  precachemodel("com_trashbin01");
  precachemodel("com_bookshelves1_d");
  precachemodel("com_office_chair_killhouse");
  precachemodel("com_plasticcase_beige_big_iw6");
  precacheshellshock("default_nosound");
  precacheshellshock("player_limp");
  precacherumble("water_splash");
}

section_flag_inits() {
  common_scripts\utility::flag_init("alley_move_toend");
  common_scripts\utility::flag_init("alley_move_shitfuck");
  common_scripts\utility::flag_init("alley_move_kickdoor");
  common_scripts\utility::flag_init("warehouse_door_breached");
  common_scripts\utility::flag_init("player_doing_warehouse_mantle");
  common_scripts\utility::flag_init("stop_alley_wakes");
  common_scripts\utility::flag_init("ally0_stair_ready");
  common_scripts\utility::flag_init("ally1_stair_ready");
  common_scripts\utility::flag_init("ally1_stair_vo_hack");
  common_scripts\utility::flag_init("moving_to_mall");
  common_scripts\utility::flag_init("player_killed_by_angry");
}

flooding_ext_start() {
  maps\flood_util::player_move_to_checkpoint_start("flooding_ext_start");
  maps\flood_util::spawn_allies();
  maps\flood_util::setup_default_weapons();
  allies_dam_vign();
  level.allies[0] thread ally0_main();
  level.allies[1] thread ally1_main();
  level.allies[2] thread ally2_main();
  common_scripts\utility::flag_set("end_of_dam");
}

flooding_ext() {
  common_scripts\utility::flag_wait("end_of_dam");
  level thread switch_to_last_player_weapon();
  level thread maps\_utility::autosave_by_name("flood_exterior");
  maps\_utility::stop_exploder("flak");
  thread maps\flood_fx::alley_end_of_alley_fx();
  thread maps\flood_fx::fx_warehouse_floating_debris();
  thread maps\flood_fx::fx_warehouse_underwater_fx_on();
  thread maps\flood_fx::fx_warehouse_underwater_fx_off();
  common_scripts\utility::flag_set("cw_player_abovewater");
  common_scripts\utility::flag_clear("cw_player_underwater");
  level.oldangryflood = 0;
  thread maps\flood_audio::sfx_dam_start_water();

  if(level.oldangryflood) {
    thread waterball_main_setup("waterball_path_1");
    maps\_utility::delaythread(10, ::waterball_alley_stream_setup);
    thread alley_giantsplashes_left();
  }

  thread inside_loadingdocks();
  thread breach_warehouse_doors();
  thread player_adjust_speed();
  thread alley_bokehdots();
  thread warehouse_collision_hacks_toggle();
  thread close_loading_dock_doors();
  thread alley_kill_triggers("off");
  thread crush_player_with_floating_lynx();
  var_0 = getent("inside_loadingdocks", "targetname");
  var_0 waittill("trigger");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
}

switch_to_last_player_weapon() {
  if(isDefined(level.dam_break_weapon))
    level.player switchtoweapon(level.dam_break_weapon);
}

fade_up_black(var_0) {
  level.black_overlay fadeovertime(var_0);
  level.black_overlay.alpha = 0;
}

setup_missile_launcher() {
  var_0 = getent("missile_launcher_4", "targetname");
  var_0 rotateyaw(-180, 0.01);
}

player_adjust_speed() {
  level.player maps\_utility::blend_movespeedscale(0.4, 0.01);
  level.player thread maps\_utility::blend_movespeedscale_default(3);
  maps\flood_util::player_water_movement(95, 0.01);
  setsaveddvar("player_sprintUnlimited", "1");
  common_scripts\utility::flag_wait("player_at_stairs");
  maps\flood_util::player_water_movement(100, 2);
  setsaveddvar("player_sprintUnlimited", "0");
}

ally_flee_setup(var_0) {
  maps\_utility::clear_force_color();
  maps\_utility::disable_cqbwalk();
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  self.dontavoidplayer = 1;
  self.ignoresuppression = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoreexplosionevents = 1;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  animscripts\weaponlist::refillclip();
  self.cw_in_rising_water = 1;
  thread ai_water_rising_think("breach_start");
  self.flood_og_moveplaybackrate = self.moveplaybackrate;
  self.flood_og_movetransitionrate = self.movetransitionrate;
  self.flood_og_animplaybackrate = self.animplaybackrate;
  var_1 = 1;
  self.moveplaybackrate = var_1;
  self.movetransitionrate = var_1;
  self.animplaybackrate = var_1;
}

ally_clear_flee_behavior() {
  maps\_utility::disable_sprint();
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  maps\_utility::enable_surprise();
  maps\_utility::enable_pain();
  maps\_utility::disable_heat_behavior();
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.dontavoidplayer = 0;
  self.ignoresuppression = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoreexplosionevents = 0;
  self.disablebulletwhizbyreaction = 0;
  self.disablefriendlyfirereaction = 0;

  if(isDefined(self.flood_og_moveplaybackrate)) {
    self.moveplaybackrate = self.flood_og_moveplaybackrate;
    self.movetransitionrate = self.flood_og_movetransitionrate;
    self.animplaybackrate = self.flood_og_animplaybackrate;
  }
}

ally_start_cornerwaving(var_0, var_1) {
  self endon("death");

  if(!var_1) {
    while(self.a.movement != "stop")
      common_scripts\utility::waitframe();

    wait(randomfloatrange(0.75, 1.25));
  }

  maps\_utility::disable_heat_behavior();
  self.prevmovemode = "none";
  self notify("move_loop_restart");

  while(!common_scripts\utility::flag("alley_move_toend"))
    var_0 maps\_anim::anim_loop_solo(self, "flood_cornerwaving_loop", "stop_loop");
}

block_ally_cornerwaving(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("alley_move_toend");
  var_1 = distance2d(level.allies[1].origin, self.origin);

  while(var_1 < var_0) {
    var_1 = distance2d(level.allies[1].origin, self.origin);
    common_scripts\utility::waitframe();
  }
}

allies_dam_vign() {
  var_0 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_1 = [];
  var_1["ally_0"] = level.allies[0];
  var_1["ally_1"] = level.allies[1];
  var_1["ally_2"] = level.allies[2];
  var_0 thread maps\_anim::anim_single(var_1, "dam_break");
  maps\_utility::delaythread(0.05, maps\_anim::anim_set_time, var_1, "dam_break", 0.9);
  wait 3;
}

ally_turnanim_hack(var_0) {
  self endon("death");
  self.noturnanims = 1;
  wait(var_0);
  self.noturnanims = undefined;
}

block_until_fully_stopped_and_idle(var_0, var_1, var_2) {
  self endon("death");

  while(self.a.movement != "stop")
    common_scripts\utility::waitframe();

  wait(var_2);

  if(!common_scripts\utility::flag("alley_move_toend"))
    var_0 thread maps\_anim::anim_loop_solo(self, var_1, "stop_loop");
}

ally0_main() {
  thread ally_flee_setup("r");
  maps\_utility::disable_heat_behavior();
  self pushplayer(1);
  maps\_utility::ent_flag_init("started_cornerwaving");
  self.alertlevelint = 1;
  self.moveplaybackrate = self.moveplaybackrate - 0.06;
  var_0 = common_scripts\utility::getstruct("ally0_flee_face", "targetname");
  var_0 thread maps\_anim::anim_reach_solo(self, "flood_cornerwaving_enter");
  var_1 = distance2d(var_0.origin, self.origin);

  while(var_1 > 200) {
    var_1 = distance2d(var_0.origin, self.origin);
    common_scripts\utility::waitframe();
  }

  if(!common_scripts\utility::flag("alley_move_toend")) {
    self waittill("goal");
    var_0 maps\_anim::anim_single_solo(self, "flood_cornerwaving_enter");
    var_0 thread maps\_anim::anim_loop_solo(self, "flood_cornerwaving_loop", "stop_loop");
    maps\_utility::ent_flag_set("started_cornerwaving");
    var_2 = [];
    var_2[0] = "flood_pri_keepupwithteam";
    var_2[1] = "flood_diz_hurry";
    maps\_utility::delaythread(0, maps\flood_util::play_nag, var_2, "alley_move_toend", 3, 15, 3, 2);
  }

  self.moveplaybackrate = self.moveplaybackrate + 0.06;
  block_ally_cornerwaving(230);
  var_0 notify("stop_loop");

  if(maps\_utility::ent_flag("started_cornerwaving"))
    var_0 maps\_anim::anim_single_run_solo(self, "flood_cornerwaving_run");

  maps\_utility::enable_sprint();
  self.prevmovemode = "none";
  self notify("move_loop_restart");
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  thread ally_alley_flood_spawn(var_0);
  var_0 maps\_anim::anim_reach_solo(self, "flood_warehouse_breach");
  thread maps\flood_audio::sfx_stop_alley_water();
  thread ally0_inhere();
  maps\_utility::disable_sprint();
  common_scripts\utility::exploder("wh_lipwater");
  var_0 maps\_anim::anim_single_run_solo(self, "flood_warehouse_breach");
  ally0_main_int();
}

ally1_main() {
  thread ally_flee_setup("r");
  maps\_utility::enable_sprint();
  maps\_utility::disable_heat_behavior();
  self pushplayer(1);
  self.alertlevelint = 1;
  maps\_utility::delaythread(2, maps\_utility::dialogue_queue, "flood_diz_floodwaters");
  self.goalradius = 128;
  self.moveplaybackrate = self.moveplaybackrate + 0.03;
  var_0 = getnode("ally1_flee_face", "targetname");
  self setgoalnode(var_0);
  self.flood_current_goalnode = var_0.targetname;
  self waittill("goal");
  self.moveplaybackrate = self.moveplaybackrate - 0.03;
  thread block_until_fully_stopped_and_idle(var_0, "flood_cornerwaving_loop", 1);
  thread ally_turnanim_hack(4);
  var_1 = distance2d(level.player.origin, self.origin);

  while(var_1 > 550) {
    var_1 = distance2d(level.player.origin, self.origin);
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("alley_move_toend");
  var_0 notify("stop_loop");
  self stopanimscripted();
  self.prevmovemode = "none";
  self notify("move_loop_restart");
  level.allies[1] thread maps\_utility::dialogue_queue("flood_bkr_downthealley");
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_0 = maps\flood_util::block_until_at_struct(var_0, 666);
  common_scripts\utility::flag_set("alley_move_shitfuck");
  level notify("stop_crazyness");
  thread maps\flood_audio::stop_sfx_dam_siren_ext();
  thread maps\flood_audio::start_sfx_dam_siren_int();
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  self.moveplaybackrate = self.moveplaybackrate - 0.1;
  var_0 = maps\flood_util::block_until_at_struct(var_0, 666);
  self.moveplaybackrate = self.moveplaybackrate + 0.1;
  maps\_utility::disable_sprint();
  ally1_main_int();
}

ally2_main() {
  thread ally_flee_setup("r");
  maps\_utility::enable_sprint();
  maps\_utility::disable_heat_behavior();
  self pushplayer(1);
  self.alertlevelint = 1;
  self.flood_hasmantled = 0;
  thread maps\_utility::dialogue_queue("flood_kgn_letsmoveit");
  self.goalradius = 128;
  self.moveplaybackrate = self.moveplaybackrate + 0.04;
  var_0 = getnode("ally2_flee_face", "targetname");
  self setgoalnode(var_0);
  self.flood_current_goalnode = var_0.targetname;
  self waittill("goal");
  self.moveplaybackrate = self.moveplaybackrate - 0.04;
  var_1 = gettime();
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  thread ally_turnanim_hack(4);
  block_ally_cornerwaving(88);
  var_1 = gettime() - var_1;
  self.prevmovemode = "none";
  self notify("move_loop_restart");
  var_0 = maps\flood_util::block_until_at_struct(var_0);
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  self.moveplaybackrate = self.moveplaybackrate - 0.1;
  var_0 = maps\flood_util::block_until_at_struct(var_0, 666);
  self.moveplaybackrate = self.moveplaybackrate + 0.1;
  maps\_utility::disable_sprint();
  ally2_main_int();
}

ally0_start_path2(var_0) {
  self endon("death");
  var_1 = distance2d(var_0.origin, self.origin);

  for(;;) {
    if(var_1 < 510) {
      thread waterball_main_setup("waterball_path_2");
      break;
    }

    var_1 = distance2d(var_0.origin, self.origin);
    common_scripts\utility::waitframe();
  }
}

alley_stumble() {
  self endon("death");
  self.run_overrideanim = maps\_utility::getgenericanim("run_stumble_non_loop");
  wait(getanimlength(maps\_utility::getgenericanim("run_stumble_non_loop")));
  self.run_overrideanim = undefined;
  self.prevmovemode = "none";
  self notify("move_loop_restart");
}

ally_alley_flood_spawn(var_0) {
  self endon("death");
  var_1 = distance2d(var_0.origin, self.origin);

  while(var_1 > 850) {
    var_1 = distance2d(var_0.origin, self.origin);
    common_scripts\utility::waitframe();
  }

  thread maps\flood_audio::sfx_dam_tidal_wave_02();
  thread maps\flood_anim::alley_flood_spawn();
}

ally0_inhere() {
  wait 0.3;
  level.allies[1] thread maps\_utility::dialogue_queue("flood_kgn_weretrapped");
  wait 0.2;

  if(level.allies[1].flood_current_goalnode == "ally1_alley_node")
    level.allies[1] notify("goal");

  wait 0.6;
  thread maps\_utility::dialogue_queue("flood_diz_inhere");
  wait 0.2;

  if(level.allies[2].flood_current_goalnode == "ally2_alley_node")
    level.allies[2] notify("goal");
}

open_loading_dock_doors(var_0) {
  thread start_loadingdocks_water();
  common_scripts\utility::waitframe();
  var_1 = getEntArray("alley_door_l", "targetname");
  var_2 = getEntArray("alley_door_r", "targetname");
  thread maps\flood_audio::diaz_door_kick_sfx();
  thread maps\flood_fx::fx_warehouse_door_breach();
  var_3 = 0.3;

  foreach(var_5 in var_1) {
    var_5 rotateyaw(85, var_3, 0, 0.2);

    if(var_5.classname == "script_brushmodel")
      var_5 connectpaths();
  }

  foreach(var_5 in var_2) {
    var_5 rotateyaw(-85, var_3, 0, 0.2);

    if(var_5.classname == "script_brushmodel")
      var_5 connectpaths();
  }

  wait 0.2;
  var_9 = getent("loading_dock_door_hack", "targetname");
  var_9 notsolid();
}

close_loading_dock_doors() {
  common_scripts\utility::flag_wait("player_at_stairs");
  var_0 = getEntArray("alley_door_l", "targetname");
  var_1 = getEntArray("alley_door_r", "targetname");
  var_2 = 0.3;

  foreach(var_4 in var_0) {
    var_4 rotateyaw(-85, var_2, 0, 0.2);

    if(var_4.classname == "script_brushmodel")
      var_4 disconnectpaths();
  }

  foreach(var_4 in var_1) {
    var_4 rotateyaw(85, var_2, 0, 0.2);

    if(var_4.classname == "script_brushmodel")
      var_4 disconnectpaths();
  }
}

waterball_main_setup(var_0) {
  level endon("enter_loadingdocks");
  level endon("stop_crazyness");
  var_1 = 0.25;

  if(var_0 == "waterball_path_1") {
    thread waterball_main_startfx(var_0);
    thread waterball_main_stream_setup(var_0);
    wait 4;
  }

  for(var_2 = 0; var_2 < 15; var_2++)
    thread waterball_main_spawn(var_0, "debris", 666, 1);

  for(var_2 = 0; var_2 < 6; var_2++)
    thread waterball_main_spawn(var_0, "medium_water_splash", 4, 1);

  wait(var_1);

  if(var_0 == "waterball_path_1")
    thread waterball_main_side_setup(var_0);

  for(;;) {
    thread waterball_main_spawn(var_0, "debris", 666, 0);
    thread waterball_main_spawn(var_0, "debris", 666, 0);
    thread waterball_main_spawn(var_0, "debris", 666, 0);

    if(var_0 == "waterball_path_1")
      thread waterball_main_spawn(var_0, "medium_water_splash", 8, 0);
    else
      thread waterball_main_spawn(var_0, "medium_water_splash", 666, 0);

    wait(var_1);
  }
}

waterball_test() {}

waterball_debris_whee() {
  self rotatevelocity((randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-200, 200)), 3000);
  wait 4;
  self rotatevelocity((0, 0, randomfloatrange(50, 200)), 3000);
}

waterball_main_spawn(var_0, var_1, var_2, var_3) {
  var_4 = waterball_get_pathnodes(var_0);

  if(isDefined(var_3) && var_3)
    var_5 = randomfloatrange(-300, 0);
  else
    var_5 = randomfloatrange(-300, 300);

  var_6 = randomfloatrange(-1000, 0);
  var_7 = randomfloatrange(30, 50);
  var_8 = randomfloatrange(1100, 1450);
  var_9 = 0;
  var_10 = spawn("script_model", var_4[var_9].origin + (var_5, var_6, var_7));
  var_10 thread trigger_radius_damage(128, 50);

  if(var_1 == "debris") {
    var_11[0] = "ac_prs_bld_debris_wood_a_6";
    var_11[1] = "ac_prs_enm_crates_b_debris_3";
    var_11[2] = "ac_prs_prp_roof_debris_a_01";
    var_11[3] = "com_coffee_machine_destroyed";
    var_11[4] = "vehicle_man_7t_iw6";
    var_11[5] = "foliage_tree_destroyed_tree_a";
    var_11[6] = "vehicle_iveco_lynx_iw6";
    var_1 = var_11[randomint(var_11.size)];
    var_10 startusinglessfrequentlighting();
    var_10 rotatevelocity((randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-200, 200)), 3000);
  } else {
    var_10 setModel("tag_origin");
    var_10 thread waterball_play_fx(var_1);
    var_10 thread waterball_play_bigfx(var_2);
  }

  for(var_12 = 1; isDefined(var_4[var_12]); var_12++) {
    var_13 = distance(var_4[var_9].origin, var_4[var_12].origin) / var_8;
    var_10 moveto(var_4[var_12].origin + (var_5, var_6, var_7), var_13);
    wait(var_13);
    var_9++;
  }

  var_10 delete();
}

waterball_main_side_setup(var_0) {
  level endon("enter_loadingdocks");
  level endon("stop_crazyness");
  wait 5;

  for(;;) {
    thread waterball_main_side_spawn(var_0, 320);
    thread waterball_main_side_spawn(var_0, -500);
    wait(randomfloatrange(0.3, 0.5));
  }
}

waterball_main_side_spawn(var_0, var_1) {
  level endon("enter_loadingdocks");
  var_2 = waterball_get_pathnodes(var_0);
  var_3 = 0;
  var_4 = spawn("script_model", var_2[var_3].origin + (var_1, 0, 0));
  var_4 setModel("tag_origin");
  var_4 thread trigger_radius_damage(256, 50);
  var_4 thread waterball_play_fx("medium_water_splash");

  for(var_5 = 1; isDefined(var_2[var_5]); var_5++) {
    var_6 = distance(var_2[var_3].origin, var_2[var_5].origin) / 1500;
    var_4 moveto(var_2[var_5].origin + (var_1, 0, 0), var_6);
    wait(var_6);
    var_3++;
  }

  var_4 delete();
}

waterball_main_stream_setup(var_0) {
  for(var_1 = 0; var_1 < 10; var_1++) {
    for(var_2 = 0; var_2 < 6; var_2++)
      thread waterball_main_stream(var_0);

    wait 0.25;
  }
}

waterball_main_stream(var_0) {
  var_1 = waterball_get_pathnodes(var_0);
  var_2 = randomfloatrange(-300, 300);
  var_3 = randomfloatrange(-100, 0);
  var_4 = randomfloatrange(5, 15);
  var_5 = randomfloatrange(800, 1000);
  var_6 = randomintrange(1, 4);
  var_7 = spawn("script_model", var_1[var_6].origin + (var_2, var_3, var_4));
  var_7 setModel("tag_origin");
  var_7.angles = (275, 270, 90);
  var_7 thread trigger_radius_push(128, 50);
  var_7 thread waterball_play_smallfx_fast();
  var_7 rotatevelocity((0, 0, randomfloatrange(-50, 50)), 3000);

  for(var_8 = var_6 + 1; isDefined(var_1[var_8]); var_8++) {
    if(var_8 == 4)
      var_7 rotateto((-90, 0, 0), 0.25);

    var_9 = distance(var_1[var_6].origin, var_1[var_8].origin) / var_5;
    var_7 moveto(var_1[var_8].origin + (var_2, var_3, var_4), var_9);
    wait(var_9);
    var_6++;
  }

  var_7 notify("finished");
  var_7 delete();
}

waterball_get_pathnodes(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  for(var_2 = 0; isDefined(var_1.target); var_2++) {
    var_3[var_2] = var_1;
    var_1 = common_scripts\utility::getstruct(var_1.target, "targetname");
  }

  var_3[var_2] = var_1;
  return var_3;
}

waterball_play_smallfx(var_0) {
  if(randomint(var_0) == 1)
    playFXOnTag(level._effect["small_water_splash"], self, "tag_origin");
}

waterball_play_smallfx_fast() {
  playFXOnTag(level._effect["small_water_splash_fast"], self, "tag_origin");
}

waterball_play_fx(var_0) {
  self endon("death");
  playFXOnTag(level._effect["medium_water_splash"], self, "tag_origin");
}

waterball_play_bigfx(var_0) {
  self endon("death");

  if(var_0 != 666) {
    wait(randomfloatrange(1, 5));

    if(randomint(var_0) == 1)
      playFX(level._effect["giant_water_splash"], self.origin);
  }
}

waterball_main_startfx(var_0) {
  level endon("enter_loadingdocks");
  level endon("stop_crazyness");
  var_1 = getent(var_0, "targetname").origin;
  playFX(level._effect["giant_water_splash"], var_1 + (0, 0, -200));

  for(var_2 = 0; var_2 < 12; var_2++) {
    playFX(level._effect["giant_water_splash"], var_1 + (randomfloatrange(-600, 600), -400, randomfloatrange(-300, -200)));
    wait(randomfloatrange(0.1, 0.4));
  }
}

waterball_alley_stream_setup() {
  level endon("enter_loadingdocks");
  var_0 = 0.15;
  var_1 = getent("waterball_path_3", "targetname");
  var_2 = getent("waterball_path_4", "targetname");

  for(;;) {
    thread waterball_alley_stream_spawn("flood_waterball_mini", var_1, -90, 2);
    thread waterball_alley_stream_spawn("flood_waterball_mini", var_2, 90, 2);
    wait(var_0);
  }
}

waterball_alley_stream_spawn(var_0, var_1, var_2, var_3) {
  var_4 = randomfloatrange(-100, 100);
  var_5 = randomfloatrange(-100, 100);
  var_6 = randomfloatrange(5, 12);
  var_7 = randomfloatrange(150, 200);
  var_8 = spawn("script_model", var_1.origin + (var_4, var_5, var_6));
  var_8 setModel("tag_origin");
  var_8.angles = (-90, 0, 0);
  var_8 startusinglessfrequentlighting();
  var_8 rotatevelocity((0, 0, randomfloatrange(-50, 0)), 3000);
  var_8 thread waterball_play_smallfx(var_3);
  var_9 = getent(var_1.target, "targetname");
  var_10 = distance(var_1.origin, var_9.origin) / var_7;
  var_8 moveto(var_9.origin + (var_4, var_5, var_6), var_10);
  wait(var_10);
  var_8 delete();
}

waterball_alley_setup() {
  level endon("breach_start");
  var_0 = 1;
  var_1 = getent("waterball_path_3", "targetname");
  var_2 = getent("waterball_path_4", "targetname");

  for(;;) {
    thread waterball_alley_spawn(var_1);
    thread waterball_alley_spawn(var_2);
    wait(var_0);
  }
}

waterball_alley_spawn(var_0) {
  var_1 = 0;
  var_2 = 200;
  var_3 = spawn("script_model", var_0.origin + (0, var_1, 0));
  var_3 setModel("tag_origin");
  var_3 thread waterball_play_fx("medium_water_splash");
  var_3 thread trigger_radius_damage(180, 75);
  var_4 = getent(var_0.target, "targetname");
  var_5 = distance(var_0.origin, var_4.origin) / var_2;
  var_3 moveto(var_4.origin + (0, var_1, 0), var_5);
  wait(var_5);
  var_3 delete();
}

waterball_loadingdocks_setup() {
  level endon("breach_start");
  wait 4;
  var_0 = 1;
  var_1 = getent("waterball_path_5", "targetname");

  for(;;) {
    thread waterball_loadingdocks_spawn(var_1);
    wait(var_0);
  }
}

waterball_loadingdocks_spawn(var_0) {
  var_1 = 0;
  var_2 = 200;
  var_3 = spawn("script_model", var_0.origin + (0, var_1, 0));
  var_3 setModel("tag_origin");
  var_3 thread waterball_play_fx("medium_water_splash");
  var_3 thread trigger_radius_damage(130, 20);
  var_4 = getent(var_0.target, "targetname");
  var_5 = distance(var_0.origin, var_4.origin) / var_2;
  var_3 moveto(var_4.origin + (0, var_1, 0), var_5);
  wait(var_5);
  var_3 delete();
}

waterball_loadingdocks_floor() {
  level endon("breach_start");
  var_0 = 0.05;
  var_1 = getEntArray("loadingdocks_floor", "targetname");

  for(;;) {
    var_2 = var_1[randomint(var_1.size)];
    playFX(level._effect["small_water_splash"], var_2.origin + (0, 0, 10));
    wait(var_0);
  }
}

moving_damage_radius_think_damage(var_0) {
  self endon("death");
  self waittill("trigger");
  level.player dodamage(var_0, level.player.origin);
  level.player shellshock("default_nosound", 0.5);
}

moving_damage_radius_think_push(var_0) {
  self endon("death");
  self waittill("trigger");
}

trigger_radius_damage(var_0, var_1) {
  var_2 = spawn("trigger_radius", self.origin, 0, var_0, var_0);
  var_2 enablelinkto();
  var_2 linkto(self);
  var_2 thread moving_damage_radius_think_damage(var_1);
  self waittill("death");
  var_2 delete();
}

trigger_radius_push(var_0, var_1) {
  var_2 = spawn("trigger_radius", self.origin, 0, var_0, var_0);
  var_2 enablelinkto();
  var_2 linkto(self);
  var_2 thread moving_damage_radius_think_push(var_1);
  self waittill("death");
  var_2 delete();
}

damage_vehicles_path1() {
  level endon("enter_loadingdocks");
  level endon("stop_crazyness");
  var_0 = getent("flood_street_car_1", "script_noteworthy");
  var_0 thread damage_vehicle_think(1);
  var_0 = getent("flood_street_car_2", "script_noteworthy");
  var_0 thread damage_vehicle_think(3);
  var_0 = getent("flood_street_car_3", "script_noteworthy");
  var_0 thread damage_vehicle_think(4.5);
  var_0 = getent("flood_street_car_4", "script_noteworthy");
  var_0 thread damage_vehicle_think(4.5);
  var_0 = getent("flood_street_car_5", "script_noteworthy");
  var_0 thread damage_vehicle_think(5);
}

damage_vehicles_path2() {
  var_0 = getent("flood_street_car_path2_1", "script_noteworthy");
  var_0 thread damage_vehicle_think(1.8);
  wait 2.2;
  thread alley_giantsplashes_right();
}

damage_vehicle_think(var_0) {
  wait(var_0);
  self dodamage(999999, self.origin);
  var_1 = anglestoup(self.origin) * 1000;
  self vehphys_launch(var_1, 2);
  wait 5;
}

alley_giantsplashes_left() {
  level endon("enter_loadingdocks");
  var_0 = getent("alley_splashes", "targetname");
  var_0 waittill("trigger");

  for(;;) {
    playFX(level._effect["giant_water_splash"], getent("alley_giantsplash_left", "targetname").origin);
    wait 3;
  }
}

alley_giantsplashes_right() {
  level endon("enter_loadingdocks");

  for(;;) {
    playFX(level._effect["giant_water_splash"], getent("alley_giantsplash_right", "targetname").origin);
    wait 3;
  }
}

inside_loadingdocks() {
  var_0 = getent("inside_loadingdocks", "targetname");
  var_0 waittill("trigger");
  level notify("enter_loadingdocks");
}

setup_loadingdocks_water() {
  thread start_coverheight_water_rising(-125, 1, "coverwater_warehouse");
  thread start_coverheight_water_rising(-125, 1, "coverwater_warehouse_postmantle");
  thread start_coverheight_water_rising(0, 1, "coverwater_warehouse_premantle");
  wait 0.1;
}

start_loadingdocks_water() {
  level.flood_double_door_center = getent("double_door_center_ent", "targetname");
  var_0 = getEntArray("coverwater_warehouse", "targetname");
  level.flood_double_door_center linkto(var_0[0]);
  setup_loadingdocks_water();
  thread maps\flood_coverwater::register_coverwater_area("coverwater_warehouse", "swept_away");
  thread start_coverheight_water_rising(1, 0, "coverwater_warehouse");
  level.cw_player_in_rising_water = 1;
  level.cw_player_allowed_underwater_time = 1;
}

flooding_int_start() {
  maps\flood_util::player_move_to_checkpoint_start("flooding_int_start");
  visionsetnaked("flood_warehouse", 0);
  maps\_utility::fog_set_changes("flood_warehouse", 0);
  level.cw_vision_above = "flood_warehouse";
  level.cw_fog_above = "flood_warehouse";
  maps\flood_util::spawn_allies();
  maps\flood_util::allies_move_to_checkpoint_start("flooding_int", 1);
  level.allies[0] ally_flee_setup("r");
  level.allies[1] ally_flee_setup("r");
  level.allies[2] ally_flee_setup("r");
  level.allies[0] thread ally0_main_int();
  level.allies[1] thread ally1_main_int();
  level.allies[2] thread ally2_main_int();
  thread maps\flood_fx::fx_warehouse_floating_debris_int();

  if(!isDefined(level.already_checking_udwfx)) {
    thread maps\flood_fx::fx_warehouse_underwater_fx_on();
    thread maps\flood_fx::fx_warehouse_underwater_fx_off();
    common_scripts\utility::flag_set("cw_player_abovewater");
    common_scripts\utility::flag_clear("cw_player_underwater");
  }

  thread start_loadingdocks_water();
  thread breach_warehouse_doors();
  thread player_adjust_speed();
  thread warehouse_collision_hacks_toggle();
  thread maps\flood_fx::warelights_off();
  maps\flood_util::setup_default_weapons();
}

flooding_int() {
  level thread maps\_utility::autosave_by_name("flood_interior");
  thread close_warehouse_doors();
  thread trigger_warehouse_door_burst();
  thread check_player_warehouse_mantle();
  thread teleport_ally2();
  thread maps\flood_util::setup_bokehdot_volume("flooding_bokehdot");
  thread maps\flood_mall::mall_roof_door_firstframe();
  thread warehouse_double_doors();
  thread enemy_spanish_vo();
  thread player_set_stairwell_speed();
  thread alley_kill_triggers("on");
  thread exit_water_tired();
  thread broken_door_rumbles();
  thread angry_flood_cleanup();
  thread runback_death_toggle("on");
  thread maps\flood_fx::fx_warehouse_amb_fx();
  thread maps\flood_fx::fx_retarget_warehouse_waters_lighting();
  thread maps\flood_audio::sfx_warehouse_water();
  thread maps\flood_audio::sfx_small_rumble_loop();
  common_scripts\utility::flag_wait("mall_breach_start");
}

hide_hole1_pieces() {
  var_0 = getent("mall_roof_hole1_trig", "targetname");
  var_0 common_scripts\utility::trigger_off();
}

ally_main_walk() {
  maps\_utility::disable_heat_behavior();
  maps\_utility::cqb_walk("on");
}

ally0_main_int() {
  maps\flood_util::jkuprint("mall int start time: " + gettime());
  self endon("death");
  maps\_utility::ent_flag_init("stop_alley_wakes");
  maps\_utility::ent_flag_set("stop_alley_wakes");
  var_0 = common_scripts\utility::getstruct("ally0_flee_int_start", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "flood_warehouse_mantle");
  thread maps\flood_fx::character_make_wet(1, 0);
  thread maps\flood_fx::fx_warehouse_ally_mantle(0.3, 0.3);
  maps\flood_audio::sfx_flood_mall_int_npc_mantles("scn_flood_mall_ally_mantle_01");
  var_0 maps\_anim::anim_single_run_solo(self, "flood_warehouse_mantle");
  thread trigger_splash_wet("warehouse_wet01", 50);
  thread trigger_splash_wet("warehouse_wet02", 40);
  thread maps\_utility::dialogue_queue("flood_bkr_notsafehere");
  level.allies[1] maps\_utility::delaythread(4, maps\_utility::dialogue_queue, "flood_diz_dontstoprunning");
  level.allies[1] maps\_utility::delaythread(8, maps\_utility::dialogue_queue, "flood_kgn_keepmoving2");
  thread maps\flood_audio::sfx_big_metal_stress();
  thread trigger_warehouse_hallway_vo();
  var_0 = common_scripts\utility::getstruct("warehouse_stairs", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "warehouse_stairs_start");
  thread maps\flood_fx::character_make_wet(20, 0);
  var_0 maps\_anim::anim_single_solo(self, "warehouse_stairs_start");
  common_scripts\utility::flag_set("ally0_stair_ready");
  var_0 thread maps\_anim::anim_loop_solo(self, "warehouse_stairs_loop", "stop_loop");
  common_scripts\utility::flag_wait_all("player_at_stairs", "ally1_stair_ready");
  var_0 notify("stop_loop");
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "moving_to_mall");
  var_0 maps\_anim::anim_single_solo(self, "warehouse_stairs_end");
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  thread maps\flood_audio::sfx_stop_warehouse_water();
  maps\flood_mall::ally0_mall();
}

flooding_stairs_vo(var_0) {
  level.player endon("death");
  level.allies[0] endon("death");
  level.allies[1] endon("death");
  level.allies[2] endon("death");
  common_scripts\utility::flag_set("moving_to_mall");
  maps\flood_util::jkuprint("starting long vo: " + gettime());
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_commentarylieutenant");
  wait 0.25;
  level.allies[1] maps\_utility::dialogue_queue("flood_mrk_ithinkitsbad");
  wait 0.3;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_runofthemill");
  wait 0.15;
  level.allies[1] maps\_utility::dialogue_queue("flood_mrk_sir");
  wait 0.2;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_thatwouldbesitrep");
  wait 0.2;
  level.allies[1] maps\_utility::dialogue_queue("flood_mrk_sitrepconfirmedsir");
  wait 0.5;
  level.allies[1] maps\_utility::dialogue_queue("flood_mrk_whatkindofman");
  wait 0.2;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_amanwhowont");
  wait 0.9;
  level.allies[2] maps\_utility::dialogue_queue("flood_bkr_thisplaceisntgonna");
  wait 0.3;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_itshotoutthere");
  wait 0.3;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_anyobjectionstofinishing");
  wait 0.4;
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_allrightletsgo");
  maps\flood_util::jkuprint("ending long vo: " + gettime());
}

ally1_main_int() {
  self endon("death");
  maps\_utility::ent_flag_init("stop_alley_wakes");
  maps\_utility::ent_flag_set("stop_alley_wakes");
  thread maps\flood_fx::fx_alley_froth();
  self.moveplaybackrate = 1.1;
  self.movetransitionrate = 1.1;
  self.animplaybackrate = 1.1;
  var_0 = common_scripts\utility::getstruct("ally1_flee_int_start", "targetname");
  maps\_utility::delaythread(0.1, maps\flood_util::push_player, 0);
  var_0 maps\_anim::anim_reach_solo(self, "flood_warehouse_mantle");
  thread maps\flood_fx::character_make_wet(1, 0);
  thread maps\flood_fx::fx_warehouse_ally_mantle(0.3, 0.25);
  maps\flood_audio::sfx_flood_mall_int_npc_mantles("scn_flood_mall_ally_mantle_02");
  var_0 maps\_anim::anim_single_run_solo(self, "flood_warehouse_mantle");
  thread trigger_splash_wet("warehouse_wet01", 50);
  thread trigger_splash_wet("warehouse_wet02", 40);
  var_0 = common_scripts\utility::getstruct("warehouse_stairs", "targetname");
  maps\_utility::delaythread(0.1, maps\flood_util::push_player, 0);
  var_0 maps\_anim::anim_reach_solo(self, "warehouse_stairs_start");
  thread maps\flood_fx::character_make_wet(20, 0);
  level maps\_utility::delaythread(getanimlength(maps\_utility::getanim("warehouse_stairs_start")) - 2, common_scripts\utility::flag_set, "ally1_stair_vo_hack");
  var_0 maps\_anim::anim_single_solo(self, "warehouse_stairs_start");
  common_scripts\utility::flag_set("ally1_stair_ready");
  var_0 thread maps\_anim::anim_loop_solo(self, "warehouse_stairs_loop", "stop_loop");
  common_scripts\utility::flag_wait_all("player_at_stairs", "ally0_stair_ready");
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "warehouse_stairs_end");
  self.moveplaybackrate = 1;
  self.movetransitionrate = 1;
  self.animplaybackrate = 1;
  maps\flood_mall::ally1_mall();
}

ally2_main_int() {
  self endon("death");
  maps\_utility::ent_flag_init("stop_alley_wakes");
  maps\_utility::ent_flag_set("stop_alley_wakes");
  self.flood_hasmantled = 0;
  var_0 = common_scripts\utility::getstruct("ally2_flee_int_start", "targetname");
  maps\_utility::delaythread(0.1, maps\flood_util::push_player, 0);
  var_0 maps\_anim::anim_reach_solo(self, "flood_warehouse_mantle");
  self.flood_hasmantled = 1;
  thread maps\flood_fx::character_make_wet(1, 0);
  thread maps\flood_fx::fx_warehouse_ally_mantle(0.4, 0.2);
  maps\flood_audio::sfx_flood_mall_int_npc_mantles("scn_flood_mall_ally_mantle_03");
  var_0 maps\_anim::anim_single_run_solo(self, "flood_warehouse_mantle");
  thread trigger_splash_wet("warehouse_wet01", 50);
  thread trigger_splash_wet("warehouse_wet02", 40);
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_0 = maps\flood_util::block_until_at_struct(var_0, 48);
  var_0 = common_scripts\utility::getstruct("warehouse_stairs", "targetname");
  maps\_utility::delaythread(0.1, maps\flood_util::push_player, 0);
  thread maps\flood_audio::sfx_oldboy_stumble_stairs();
  var_0 maps\_anim::anim_reach_solo(self, "warehouse_stairs_start");
  thread maps\flood_fx::character_make_wet(20, 0);
  var_0 maps\_anim::anim_single_solo(self, "warehouse_stairs_start");
  var_0 thread maps\_anim::anim_loop_solo(self, "warehouse_stairs_loop", "stop_loop");
  thread ally_main_walk();
  common_scripts\utility::flag_wait_all("player_at_stairs", "ally0_stair_ready", "ally1_stair_ready");
  var_0 notify("stop_loop");
  wait 1;
  var_0 maps\_anim::anim_single_run_solo(self, "warehouse_stairs_end");
  maps\flood_mall::ally2_mall();
}

trigger_warehouse_hallway_vo() {
  self endon("death");
  var_0 = common_scripts\utility::getstruct("warehouse_hallway_vo", "targetname");

  while(distance2d(var_0.origin, self.origin) > 100)
    common_scripts\utility::waitframe();

  thread maps\_utility::dialogue_queue("flood_bkr_upthestairs");
}

trigger_splash_wet(var_0, var_1) {
  self endon("death");
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");

  while(distance2d(var_2.origin, self.origin) > var_1)
    common_scripts\utility::waitframe();

  thread maps\flood_fx::character_make_wet(2, 0);
}

hallway_blocker() {
  level endon("breach_start");
  var_0 = getent("flooding_hallway_blocker", "targetname");
  var_0.origin = self.origin;
  var_0 linkto(self, "tag_origin", (0, 0, 48), (0, 0, 0));

  for(;;) {
    var_0 linkto(self, "tag_origin", (0, 0, 48), (0, self.angles[1] * -1, 0));
    wait 0.05;
  }
}

breach_warehouse_doors() {
  var_0 = getEntArray("warehouse_door_int_l", "targetname");
  var_1 = getEntArray("warehouse_door_int_r", "targetname");
  var_2 = getent("warehouse_door_int_l_lock", "targetname");
  var_3 = getent("warehouse_door_int_r_lock", "targetname");
  var_2 linkto(var_0[0]);
  var_3 linkto(var_1[0]);

  foreach(var_5 in var_0) {
    var_5 rotateyaw(85, 0.2, 0.1, 0.1);

    if(var_5.classname == "script_brushmodel")
      var_5 connectpaths();
  }

  foreach(var_5 in var_1) {
    var_5 rotateyaw(-85, 0.2, 0.1, 0.1);

    if(var_5.classname == "script_brushmodel")
      var_5 connectpaths();
  }

  var_9 = getEntArray("mall_ware_brush_show", "targetname");

  foreach(var_5 in var_9) {
    var_5 hide();
    var_5 notsolid();
  }

  common_scripts\utility::flag_set("warehouse_door_breached");
}

close_warehouse_doors() {
  level endon("swept_away");
  common_scripts\utility::flag_wait("mall_breach_start");
  var_0 = getEntArray("warehouse_door_int_l", "targetname");
  var_1 = getEntArray("warehouse_door_int_r", "targetname");

  foreach(var_3 in var_0) {
    var_3 rotateyaw(-85, 0.2, 0.1, 0.1);

    if(var_3.classname == "script_brushmodel")
      var_3 connectpaths();
  }

  foreach(var_3 in var_1) {
    var_3 rotateyaw(85, 0.2, 0.1, 0.1);

    if(var_3.classname == "script_brushmodel")
      var_3 connectpaths();
  }
}

wait_for_intro_vignette_use() {
  level.player endon("mantle_used");
  var_0 = getent("train_coupling", "targetname");
  notifyoncommand("mantle", "+gostand");

  for(;;) {
    if(common_scripts\utility::flag("trig_intro_vignette") && maps\_utility::player_looking_at(var_0.origin, 0.3) && level.player getstance() == "stand") {
      setsaveddvar("hud_forceMantleHint", 1);
      level.player allowjump(0);
      level.player thread player_mantle_wait();

      while(common_scripts\utility::flag("trig_intro_vignette") && maps\_utility::player_looking_at(var_0.origin, 0.3) && level.player getstance() == "stand") {
        if(level.player getstance() != "stand") {
          break;
        }

        wait 0.05;
      }
    } else {
      level.player notify("not_active");
      setsaveddvar("hud_forceMantleHint", 0);
      level.player allowjump(1);
    }

    wait 0.05;
  }
}

player_mantle_wait() {
  self endon("not_active");
  self waittill("mantle");
  setsaveddvar("hud_forceMantleHint", 0);
  self notify("mantle_used");
}

loadingdocks_no_jump() {
  level endon("swept_away");
  level endon("mall_attack_player");

  for(;;) {
    if(common_scripts\utility::flag("loadingdocks_no_jump"))
      level.player allowjump(0);
    else
      level.player allowjump(1);

    common_scripts\utility::waitframe();
  }
}

trigger_warehouse_door_burst() {
  level endon("player_on_mall_roof");
  var_0 = getent("warehouse_door_burst1", "targetname");
  var_0.animname = "warehouse_door_burst";
  var_0 maps\_utility::assign_animtree();
  var_1 = getent("warehouse_door_burst2", "targetname");
  var_1.animname = "warehouse_door_burst";
  var_1 maps\_utility::assign_animtree();
  var_2 = getent("warehouse_door_burst3", "targetname");
  var_2.animname = "warehouse_door_burst";
  var_2 maps\_utility::assign_animtree();
  var_0 thread maps\_anim::anim_loop_solo(var_0, "flood_warehouse_doorbuckling_door_loop1");
  var_1 thread maps\_anim::anim_loop_solo(var_1, "flood_warehouse_doorbuckling_door_loop1", "stop_loop");
  var_2 thread maps\_anim::anim_loop_solo(var_2, "flood_warehouse_doorbuckling_door_loop1", "stop_loop");
  common_scripts\utility::flag_wait("warehouse_door_burst_alt");
  thread maps\flood_audio::sfx_warehouse_door_burst_01(var_1);
  thread maps\flood_fx::fx_warehouse_door_burst_02();
  var_1 notify("stop_loop");
  var_1 maps\_anim::anim_single_solo(var_1, "flood_warehouse_doorbuckling_door_alt");
  var_1 thread maps\_anim::anim_loop_solo(var_1, "flood_warehouse_doorbuckling_door_loop2_alt");
  common_scripts\utility::flag_wait("warehouse_door_burst");
  thread maps\flood_audio::sfx_warehouse_door_burst_02(var_2);
  var_2 notify("stop_loop");
  thread maps\flood_fx::fx_warehouse_door_burst();
  var_2 maps\_anim::anim_single_solo(var_2, "flood_warehouse_doorbuckling_door");
  var_2 thread maps\_anim::anim_loop_solo(var_2, "flood_warehouse_doorbuckling_door_loop2");
}

check_player_warehouse_mantle() {
  level endon("player_on_mall_roof");

  for(;;) {
    if(common_scripts\utility::flag("player_warehouse_mantle")) {
      if(level.player ismantling())
        common_scripts\utility::flag_set("player_doing_warehouse_mantle");
      else
        common_scripts\utility::flag_clear("player_doing_warehouse_mantle");
    }

    common_scripts\utility::waitframe();
  }
}

teleport_ally2() {
  level endon("player_on_mall_roof");
  common_scripts\utility::flag_wait("player_doing_warehouse_mantle");

  if(!level.allies[2].flood_hasmantled && distance2d(level.player.origin, level.allies[2].origin) > 169) {
    var_0 = common_scripts\utility::getstruct("ally2_warehouse_snap", "targetname");
    level.allies[2] forceteleport(var_0.origin, var_0.angles);
    level.allies[2] setgoalpos(var_0.origin);
  }
}

angry_flood_collision(var_0, var_1, var_2, var_3) {
  var_4 = 25;

  foreach(var_6 in var_0) {
    var_7 = level.scr_model[var_6.animname];
    var_8 = getnumparts(var_7);

    for(var_9 = 0; var_9 < var_8; var_9++) {
      var_10 = getpartname(var_7, var_9);

      if(randomint(var_2) == 0)
        thread angry_flood_collision_spawn(var_6, var_10, var_1, var_4, var_3);
    }
  }
}

angry_flood_collision_spawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("trigger_radius", var_0 gettagorigin(var_1), 0, var_2, var_2);
  var_5 enablelinkto();
  var_5 linkto(var_0, var_1);
  var_5 thread angry_flood_collision_dodamage(var_3);
  common_scripts\utility::flag_wait(var_4);
  var_5 delete();
}

angry_flood_collision_dodamage(var_0) {
  self endon("death");
  self endon("player_killed_by_angry");

  for(;;) {
    self waittill("trigger");

    if(var_0 * level.player.damagemultiplier > level.player.health)
      thread angry_flood_finishing_move(var_0);
    else {
      thread maps\flood_fx::fx_bokehdots_close();
      level.player dodamage(var_0, level.player.origin);
    }

    wait 3;
  }
}

angry_flood_finishing_move(var_0) {
  if(!common_scripts\utility::flag("player_killed_by_angry")) {
    common_scripts\utility::flag_set("player_killed_by_angry");
    level.player disableweapons();
    level.player hideviewmodel();
    level.player freezecontrols(1);
    thread maps\flood_fx::water_death_fx();
    level.player dodamage(var_0, level.player.origin);
    setdvar("ui_deadquote", &"FLOOD_SKYBRIDGE_FAIL");
    level thread maps\_utility::missionfailedwrapper();
  }
}

angry_flood_collision_cheater(var_0) {
  level endon("enter_loadingdocks");

  for(;;) {
    maps\_utility::delaythread(0.3, ::angry_flood_collision_cheater_spawn, var_0, 150, 352, 1);
    maps\_utility::delaythread(0.3, ::angry_flood_collision_cheater_spawn, var_0, 150, 256, 0);
    maps\_utility::delaythread(0.15, ::angry_flood_collision_cheater_spawn, var_0, -80, 256, 0);
    thread angry_flood_collision_cheater_spawn(var_0, -300, 256, 0);
    wait 0.55;
  }
}

alley_flood_collision_cheater(var_0) {
  level endon("player_at_stairs");

  for(;;) {
    thread angry_flood_collision_cheater_spawn(var_0, 0, 184, 0, 700);
    wait 0.4;
  }
}

angry_flood_collision_cheater_spawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 1000;

  var_5 = waterball_get_pathnodes(var_0);
  var_6 = 0;
  var_7 = var_2;
  var_8 = spawn("script_model", var_5[var_6].origin + (var_1, 0, 0));
  var_9 = spawn("trigger_radius", var_5[var_6].origin + (var_1, 0, 0), 0, var_7, var_7);
  var_9 enablelinkto();
  var_9 linkto(var_8);

  if(isDefined(var_3) && var_3)
    var_9 thread maps\flood_fx::fx_angry_flood_nearmiss(0);
  else
    var_9 thread angry_flood_collision_dodamage(100);

  for(var_10 = 1; isDefined(var_5[var_10]); var_10++) {
    var_11 = distance(var_5[var_6].origin, var_5[var_10].origin) / var_4;
    var_8 moveto(var_5[var_10].origin + (var_1, 0, 0), var_11);
    wait(var_11);
    var_6++;
  }

  var_8 delete();
  var_9 delete();
}

alley_bokehdots() {
  level endon("enter_loadingdocks");
  level endon("player_on_mall_roof");
  maps\flood_fx::fx_create_bokehdots_source();
  common_scripts\utility::flag_wait("alley_bokehdots");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::flag_wait("alley_move_shitfuck");

  for(;;) {
    thread maps\flood_fx::fx_bokehdots_and_waterdrops_heavy(3);
    wait 1;
  }

  stopFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
}

alley_bokehdots_old() {
  level endon("player_on_mall_roof");
  var_0 = getent("alley_bokehdots", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_1 = var_1.origin;
  var_2 = var_2.origin;
  var_3 = distance2d(var_2, var_1);
  maps\flood_fx::fx_create_bokehdots_source();
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");

  for(;;) {
    while(common_scripts\utility::flag("alley_bokehdots")) {
      if(common_scripts\utility::flag("alley_move_shitfuck"))
        thread maps\flood_fx::fx_bokehdots_and_waterdrops_heavy();
      else {}

      var_4 = distance2d(level.player.origin, var_1) / var_3;
      var_4 = randomfloatrange(var_4 * 2.85, var_4 * 3.15);
      wait(var_4);
    }

    common_scripts\utility::waitframe();
  }
}

warehouse_double_doors() {
  level endon("player_on_mall_roof");
  var_0 = common_scripts\utility::getstruct("ware_double_doors", "targetname");
  var_1 = maps\_utility::spawn_anim_model("warehouse_double_doorl", var_0.origin);
  var_2 = maps\_utility::spawn_anim_model("warehouse_double_doorr", var_0.origin);
  var_0 thread maps\_anim::anim_loop_solo(var_1, "warehouse_double_door");
  var_0 thread maps\_anim::anim_loop_solo(var_2, "warehouse_double_door");
}

enemy_spanish_vo() {
  level endon("swept_away");
  level endon("mall_attack_player");
  common_scripts\utility::flag_wait("mall_spanish_vo");
  var_0 = getent("flood_mall_roof_opfor", "targetname");
  common_scripts\utility::flag_wait("event_quaker_big");
  wait 6;
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_everyonecheckyour");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_jimenezramosgarciacheck");
  var_0 maps\_utility::play_sound_on_entity("flood_vs1_onit");
  wait 2;
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_howmuchlongerfor");
  var_0 maps\_utility::play_sound_on_entity("flood_vs3_5minutes");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_wemightnotbe");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_makesuretheyunderstand");
  wait 2;
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_rodriguezineedyou");
  var_0 maps\_utility::play_sound_on_entity("flood_vs4_imabitbusy");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_hurryupandpull");
  wait 2;
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_sanchezandcastillomake");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_idontwantanything");
  var_0 maps\_utility::play_sound_on_entity("flood_vs6_yessir");
  wait 1;
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_anyupdateonthat");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_anyoneseeingasafe");
  var_0 maps\_utility::play_sound_on_entity("flood_vs2_howrethingslookingon");
  var_0 maps\_utility::play_sound_on_entity("flood_vs6_itfeelslikethe");
}

warehouse_collision_hacks_toggle(var_0) {
  var_1 = getent("warehouse_big_rollup_collision", "targetname");
  var_2 = getent("loading_dock_rollup_collision", "targetname");
  var_3 = getent("warehouse_front_door_collision", "targetname");

  if(!isDefined(var_0))
    var_0 = "default";

  maps\flood_util::jkuprint("turning on hack collision: " + var_0);

  switch (var_0) {
    case "big_rollup":
      var_1 show();
      var_1 solid();
      break;
    case "side":
      var_2 show();
      var_2 solid();
      break;
    case "front_door":
      var_3 show();
      var_3 solid();
      break;
    default:
      var_1 hide();
      var_1 notsolid();
      var_2 hide();
      var_2 notsolid();
      var_3 hide();
      var_3 notsolid();
  }
}

player_set_stairwell_speed() {
  common_scripts\utility::flag_wait("player_at_stairs");
  common_scripts\utility::flag_set("cw_player_no_speed_adj");
  maps\flood_util::jkuprint("settting stairwell speed");
  thread maps\flood_util::player_water_movement(50, 2);
}

alley_kill_triggers(var_0) {
  var_1 = getent("alley_runback_kill_left", "targetname");
  var_2 = getent("alley_runback_kill_loadingdocks", "targetname");

  switch (var_0) {
    case "on":
      var_1 common_scripts\utility::trigger_on();
      break;
    case "off":
      var_1 common_scripts\utility::trigger_off();
      var_2 common_scripts\utility::trigger_off();
      break;
  }
}

crush_player_with_floating_lynx() {
  var_0 = getent("flooding_crush_player", "targetname");
  var_0 waittill("trigger");
  level.player kill();
}

flooding_cleanup() {
  var_0 = getEntArray("flooding_bokehdot", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("flooding_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

start_coverheight_water_rising(var_0, var_1, var_2) {
  if(var_1) {
    var_3 = getEntArray(var_2, "targetname");
    var_4 = getent(var_2 + "_above", "targetname");
    var_5 = getent(var_2 + "_under", "targetname");
    var_3 = common_scripts\utility::array_add(var_3, var_4);
    var_3 = common_scripts\utility::array_add(var_3, var_5);
    var_5 setcontents(33);

    foreach(var_7 in var_3)
    var_7 movez(var_0, 0.01, 0, 0);

    if(var_2 == "coverwater_warehouse") {
      var_9 = getent(var_2 + "_foam", "targetname");

      if(isDefined(var_9)) {
        wait 1.01;
        var_9 movex(-1368, 0.01, 0, 0);
        wait 1.01;
        var_9 movey(317, 0.01, 0, 0);
        return;
      }

      return;
    }
  } else {
    thread maps\flood_fx::fx_wh_splashes();
    var_10 = getEntArray("water_alley", "targetname");
    var_11 = getEntArray("coverwater_warehouse", "targetname");
    var_12 = getent("coverwater_warehouse_above", "targetname");
    var_13 = getent("coverwater_warehouse_under", "targetname");
    var_14 = getent("wh_splashes_upper", "targetname");
    var_15 = getent("coverwater_warehouse_debris", "targetname");
    var_16 = getent("coverwater_warehouse_foam", "targetname");
    var_11 = common_scripts\utility::array_add(var_11, var_12);
    var_11 = common_scripts\utility::array_add(var_11, var_13);
    var_11 = common_scripts\utility::array_add(var_11, var_14);
    var_11 = common_scripts\utility::array_add(var_11, var_15);

    if(isDefined(var_16))
      var_11 = common_scripts\utility::array_add(var_11, var_16);

    var_17 = getEntArray("coverwater_warehouse_premantle", "targetname");
    var_18 = getent("coverwater_warehouse_premantle_above", "targetname");
    var_19 = getent("coverwater_warehouse_premantle_under", "targetname");
    var_20 = getent("wh_splashes_lower", "targetname");
    var_21 = getent("coverwater_warehouse_premantle_debris_T", "targetname");
    var_17 = common_scripts\utility::array_add(var_17, var_18);
    var_17 = common_scripts\utility::array_add(var_17, var_19);
    var_17 = common_scripts\utility::array_add(var_17, var_20);
    var_17 = common_scripts\utility::array_add(var_17, var_21);
    var_22 = getEntArray("coverwater_warehouse_postmantle", "targetname");
    var_23 = getent("coverwater_warehouse_postmantle_above", "targetname");
    var_24 = getent("coverwater_warehouse_postmantle_under", "targetname");
    var_22 = common_scripts\utility::array_add(var_22, var_23);
    var_22 = common_scripts\utility::array_add(var_22, var_24);
    var_25 = common_scripts\utility::array_combine(var_11, var_17);
    var_25 = common_scripts\utility::array_combine(var_25, var_22);
    var_13 setcontents(33);
    var_19 setcontents(33);
    var_24 setcontents(33);

    foreach(var_27 in var_22) {
      var_27 hide();
      var_27 notsolid();
    }

    thread start_coverheight_water_swap(var_17, var_22);
    var_29 = getent("inside_loadingdocks", "targetname");
    var_29 waittill("trigger");
    maps\flood_util::jkuprint("wr: ld");
    var_30 = 4;

    foreach(var_7 in var_17)
    var_7 movez(45, var_30, 0, 4);

    wait(var_30);
    common_scripts\utility::flag_wait_or_timeout("start_warehouse_water", 2);
    maps\_utility::delaythread(0.9, ::coverheight_water_rising_lip);
    maps\_utility::delaythread(3, ::warehouse_collision_hacks_toggle, "front_door");
    maps\flood_util::jkuprint("wr: ware");
    var_30 = 5;

    foreach(var_7 in var_25)
    var_7 movez(53, var_30, 2, 2);

    wait(var_30);
    common_scripts\utility::flag_wait_or_timeout("start_stairs_water", 7);
    thread warehouse_collision_hacks_toggle("side");

    if(common_scripts\utility::flag("start_stairs_water")) {
      maps\flood_util::jkuprint("wr: stairs no close");
      var_30 = 5;

      foreach(var_7 in var_25)
      var_7 movez(40, var_30, 2, 2);

      wait(var_30);
    } else {
      maps\flood_util::jkuprint("wr: ware close");
      var_30 = 2;

      foreach(var_7 in var_25)
      var_7 movez(10, var_30, 1, 1);

      wait(var_30);
      maps\flood_util::jkuprint("wr: stairs");
      var_30 = 3;

      foreach(var_7 in var_25)
      var_7 movez(30, var_30, 1, 2);

      wait(var_30);
    }

    common_scripts\utility::flag_wait_or_timeout("player_at_stairs", 3);
    thread warehouse_collision_hacks_toggle("big_rollup");

    if(common_scripts\utility::flag("player_at_stairs")) {
      maps\flood_util::jkuprint("wr: final no close");
      var_30 = 12;

      foreach(var_7 in var_25)
      var_7 movez(35, var_30, 6, 6);
    } else {
      maps\flood_util::jkuprint("wr: stairs close");
      var_30 = 3;

      foreach(var_7 in var_25)
      var_7 movez(10, var_30, 1, 1);

      wait(var_30);
      maps\flood_util::jkuprint("wr: final");
      var_30 = 8;

      foreach(var_7 in var_25)
      var_7 movez(25, var_30, 4, 4);
    }
  }
}

start_coverheight_water_swap(var_0, var_1) {
  common_scripts\utility::flag_wait("player_doing_warehouse_mantle");
  wait 0.2;
  thread maps\flood_fx::destroy_lip_debris_fx();

  foreach(var_3 in var_1) {
    var_3 show();
    var_3 solid();
  }

  foreach(var_3 in var_0) {
    var_3 hide();
    var_3 notsolid();
  }
}

coverheight_water_rising_lip() {
  var_0 = getent("warehouse_water_lip_02", "targetname");
  var_0 hide();
  var_0 notsolid();
}

ai_water_rising_think(var_0) {
  self endon("death");
  level endon(var_0);
  self.flooding_last_water_state = "out";
  level ai_flooding_hip_anims();
  level ai_flooding_under_anims();

  for(;;) {
    var_1 = bulletTrace(self.origin, self getEye(), 0, self);

    if(var_1["surfacetype"] == "water") {
      var_2 = var_1["position"][2] - self.origin[2];

      if(var_2 > 40) {
        if(self.flooding_last_water_state != "under") {
          self.flooding_last_water_state = "under";
          self.standruntranstime = 0.8;
          maps\_utility::set_archetype("under_water");
        }
      } else if(var_2 > 20) {
        if(self.flooding_last_water_state != "hip" && (var_2 < 36 || self.flooding_last_water_state == "out")) {
          self.flooding_last_water_state = "hip";
          self.standruntranstime = 0.8;
          maps\_utility::set_archetype("hip_water");
        }
      } else if(self.flooding_last_water_state != "out") {
        self.flooding_last_water_state = "out";
        self.standruntranstime = undefined;
        maps\_utility::clear_archetype();
        thread maps\flood_fx::character_make_wet();
      }
    }

    common_scripts\utility::waitframe();
  }
}

#using_animtree("generic_human");

ai_flooding_hip_anims() {
  if(!isDefined(anim.archetypes) || !isDefined(anim.archetypes["hip_water"])) {
    var_0 = [];
    var_1 = [];
    var_1["straight"] = % flood_ally_water_walking_mid_70;
    var_1["straight_twitch"] = [ % flood_ally_water_walking_mid_70];
    var_1["move_f"] = % flood_ally_water_walking_mid_70;
    var_0["run"] = var_1;
    var_0["walk"] = var_1;
    maps\_utility::register_archetype("hip_water", var_0);
  }
}

ai_flooding_under_anims() {
  if(!isDefined(anim.archetypes) || !isDefined(anim.archetypes["under_water"])) {
    var_0 = [];
    var_1 = [];
    var_1["straight"] = % flood_ally_water_walking_high;
    var_1["straight_twitch"] = [ % flood_ally_water_walking_high];
    var_1["move_f"] = % flood_ally_water_walking_high;
    var_0["run"] = var_1;
    var_0["walk"] = var_1;
    maps\_utility::register_archetype("under_water", var_0);
  }
}

exit_water_tired() {
  level endon("exit_water_stop_tired");
  common_scripts\utility::flag_waitopen("cw_player_underwater");
  common_scripts\utility::flag_wait("player_at_stairs");
  common_scripts\utility::exploder("mr_sunflare");
  thread maps\flood_audio::sfx_play_outofwater_sound();

  if(!common_scripts\utility::flag("ally1_stair_vo_hack"))
    level.allies[0] thread maps\_utility::dialogue_queue("flood_bkr_catchyourbreath");

  var_0 = 6;
  var_1 = gettime();
  level.tired_time_remaining = var_0 - (gettime() - var_1) / 1000;
  level.player thread enable_tired(75, level.tired_time_remaining);
  thread exit_water_tired_timer(var_1, var_0);
  maps\flood_util::jkuprint("tired");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    level.player thread disable_tired(1, 0);
    common_scripts\utility::flag_clear("cw_player_no_speed_adj");
    maps\flood_util::jkuprint("disabled");
    common_scripts\utility::flag_waitopen("cw_player_underwater");
    level.tired_time_remaining = var_0 - (gettime() - var_1) / 1000;
    level.player thread enable_tired(75, level.tired_time_remaining);
    common_scripts\utility::flag_set("cw_player_no_speed_adj");
    maps\flood_util::jkuprint("enabled " + level.tired_time_remaining);
  }
}

exit_water_tired_timer(var_0, var_1) {
  level.tired_time_remaining = var_1 - (gettime() - var_0) / 1000;

  while(level.tired_time_remaining > 0) {
    level.tired_time_remaining = var_1 - (gettime() - var_0) / 1000;
    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint("done");
  common_scripts\utility::flag_clear("cw_player_no_speed_adj");
  level notify("exit_water_stop_tired");
}

enable_tired(var_0, var_1) {
  init_default_tired();
  self.limp_strength = 1.0;
  self.ground_ref_ent = spawn("script_model", (0, 0, 0));
  self playersetgroundreferenceent(self.ground_ref_ent);
  maps\_utility::player_speed_percent(var_0, 0.05);
  self.player_speed = var_0;
  thread tired();
  thread fade_tired(var_1);
  maps\_utility::player_speed_percent(100, var_1);
  self.player_speed = 100;
}

init_default_tired() {
  level.player_tired["pitch"]["min"] = -1;
  level.player_tired["pitch"]["max"] = 1;
  level.player_tired["yaw"]["min"] = -1;
  level.player_tired["yaw"]["max"] = 1;
  level.player_tired["roll"]["min"] = 2;
  level.player_tired["roll"]["max"] = 5;
}

disable_tired(var_0, var_1) {
  self notify("stop_limp");
  self notify("stop_random_blur");
  self fadeoutshellshock();
  thread maps\_utility::vision_set_changes(level.cw_vision_above, 0.25);

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0)) {
    self playersetgroundreferenceent(undefined);
    setsaveddvar("player_sprintUnlimited", "0");
    self notify("stop_limp_forgood");
  } else {
    var_2 = randomfloatrange(0.65, 1.25);
    var_3 = adjust_angles_to_player((0, 0, 0));
    self.ground_ref_ent rotateto(var_3, var_2, 0, var_2 / 2);
    self.ground_ref_ent waittill("rotatedone");
  }

  level.player maps\_utility::player_speed_percent(100);
  setblur(0, randomfloatrange(0.5, 0.75));
  self allowstand(1);
  self allowcrouch(1);
  self allowsprint(1);
  self allowjump(1);
}

fade_tired(var_0) {
  self endon("stop_limp");
  wait(var_0);
  thread disable_tired();
}

tired(var_0) {
  self endon("stop_limp");
  self shellshock("player_limp", 9999);
  self allowsprint(0);
  self allowjump(0);
  thread player_random_blur();
  thread player_hurt_sounds();

  for(;;) {
    if(self playerads() > 0.3) {
      wait 0.05;
      continue;
    }

    var_1 = level.player getstance();

    if(var_1 == "crouch" || var_1 == "prone") {
      wait 0.05;
      continue;
    }

    var_2 = self getvelocity();
    var_3 = abs(var_2[0]) + abs(var_2[1]);

    if(var_3 < 10) {
      wait 0.05;
      continue;
    }

    var_4 = var_3 / self.player_speed;
    var_5 = randomfloatrange(level.player_tired["pitch"]["min"], level.player_tired["pitch"]["max"]);

    if(randomint(100) < 20)
      var_5 = var_5 * 1.5;

    var_6 = randomfloatrange(level.player_tired["roll"]["min"], level.player_tired["roll"]["max"]);
    var_7 = randomfloatrange(level.player_tired["yaw"]["min"], level.player_tired["yaw"]["max"]);
    var_8 = (var_5, var_7, var_6);
    var_8 = var_8 * var_4;
    var_8 = var_8 * self.limp_strength;
    var_9 = randomfloatrange(0.15, 0.45);
    var_10 = randomfloatrange(0.65, 1.25);
    thread maps\_utility::vision_set_changes("flood_stairs_pain", 3);
    thread stumble(var_8, var_9, var_10);
    wait(var_9);
    thread maps\_utility::vision_set_changes(level.cw_vision_above, var_10);
    self waittill("recovered");
  }
}

stumble(var_0, var_1, var_2, var_3) {
  self endon("stop_stumble");
  self endon("stop_limp");
  var_0 = adjust_angles_to_player(var_0);
  self notify("stumble");
  self.ground_ref_ent rotateto(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  self.ground_ref_ent waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = adjust_angles_to_player(var_4);
  self.ground_ref_ent rotateto(var_4, var_2, 0, var_2 / 2);
  self.ground_ref_ent waittill("rotatedone");

  if(!isDefined(var_3))
    self notify("recovered");
}

player_random_blur() {
  self endon("dying");
  self endon("stop_random_blur");

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(3) + 4;
    var_1 = randomfloatrange(0.1, 0.3);
    var_2 = randomfloatrange(0.3, 1);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait(var_2);
    wait(randomfloatrange(0, 1.5));
    common_scripts\utility::waittill_notify_or_timeout("blur", 5);
  }
}

player_hurt_sounds() {
  self endon("stop_limp");

  for(;;) {
    if(player_playing_hurt_sounds()) {
      wait 0.05;
      continue;
    }

    self notify("blur");
    common_scripts\utility::play_sound_in_space("breathing_limp_start");
    common_scripts\utility::play_sound_in_space("breathing_limp_better");
    wait(randomfloatrange(0, 1));
    var_0 = (level.tired_time_remaining - 0) * -5 / 15 + 6;
    common_scripts\utility::waittill_notify_or_timeout("stumble", var_0);
  }
}

player_playing_hurt_sounds() {
  if(level.player.health < 50)
    return 1;
  else
    return 0;
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

angry_flood_cleanup() {
  var_0 = getEntArray("angry_flood_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
  var_1 = [];
  var_1[var_1.size] = "flood_shake_tree_left_1";
  var_1[var_1.size] = "flood_shake_tree_left_2";
  var_1[var_1.size] = "flood_shake_tree_left_3";
  var_1[var_1.size] = "flood_shake_tree_left_4";
  var_1[var_1.size] = "flood_shake_tree_left_5";
  var_1[var_1.size] = "flood_shake_tree_right_1";
  var_1[var_1.size] = "flood_shake_tree_right_2";
  var_1[var_1.size] = "flood_shake_tree_right_3";
  var_1[var_1.size] = "flood_shake_tree_right_4";
  var_1[var_1.size] = "flood_shake_tree_right_5";
  var_1[var_1.size] = "flood_shake_tree_right_6";

  foreach(var_3 in var_1) {
    var_3 = getent(var_3, "script_noteworthy");

    if(isDefined(var_3))
      var_3 delete();
  }
}

angry_flood_rumble() {
  var_0 = level.player maps\flood_util::create_rumble_ent(1000, "flooding_cleanup");
  var_0 playrumblelooponentity("steady_rumble");

  while(distance(var_0.origin, level.player.origin) > 200 && isalive(level.player)) {
    var_1 = distance(var_0.origin, level.player.origin);

    if(var_1 > 666)
      var_0.origin = var_0.origin + (0, 0, -2);
    else
      var_0.origin = var_0.origin + (0, 0, -8);

    var_0 linkto(level.player);
    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint("done moving rumbler");
  level thread angry_flood_rumble_loop("angry_flood_rumble_ent");
  level thread angry_flood_rumble_loop("alley_flood_rumble_ent");

  while(isalive(level.player) && !common_scripts\utility::flag("alley_bokehdots"))
    common_scripts\utility::waitframe();

  var_0 stoprumble("steady_rumble");
  var_0 delete();
}

angry_flood_rumble_loop(var_0) {
  level endon("player_warehouse_mantle");
  level.player endon("death");
  var_1 = getent(var_0, "targetname");
  var_1 playrumblelooponentity("steady_rumble");

  while(isalive(level.player))
    common_scripts\utility::waitframe();

  var_1 stoprumble("steady_rumble");
}

broken_door_rumbles() {
  var_0 = getEntArray("warehouse_rumble", "targetname");

  foreach(var_2 in var_0)
  var_2 playrumblelooponentity("water_splash");

  level waittill("player_at_stairs");

  foreach(var_2 in var_0)
  var_2 delete();
}

runback_death_toggle(var_0) {
  var_1 = getEntArray("alley_kill_runback_trigger", "targetname");

  switch (var_0) {
    case "on":
      foreach(var_3 in var_1)
      var_3 common_scripts\utility::trigger_on();

      break;
    case "off":
      foreach(var_3 in var_1)
      var_3 common_scripts\utility::trigger_off();

      break;
  }
}