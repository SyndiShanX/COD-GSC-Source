/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dc_whitehouse.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_weather;
#include maps\dc_whitehouse_code;
#using_animtree("generic_human");

main() {
  default_start(::start_tunnels);
  add_start("tunnels", ::start_tunnels, "[tunnels] -> make you way to WH", ::tunnels_main);
  add_start("oval_office", ::start_oval_office, "[oval_office] -> Will only work for testing anims");
  add_start("flare", ::start_flare, "[flare] -> pop the flare");

  flags();
  global_inits();
}

global_inits() {
  maps\dc_whitehouse_precache::main();
  maps\createart\dc_whitehouse_fog::main();
  maps\createfx\dc_whitehouse_fx::main();
  maps\dc_whitehouse_fx::main();
  maps\_load::main();

  precacheitem("flare");
  precachemodel("picture_frame_07_animated");
  precacheshellshock("minor");
  precachemodel("mil_sandbag_plastic_white_single_flat");
  precachemodel("mil_sandbag_plastic_white_single_bent");
  precachemodel("rappelrope100_ri");
  precachemodel("mil_emergency_flare");
  precachemodel("furniture_chandelier1_off");
  PreCacheTurret("heli_spotlight");
  precachemodel("cod3mg42");
  PrecacheItem("rpg_straight");
  precachemodel("com_door_01_handleleft2");
  precachemodel("mil_sandbag_plastic_white_single_flat");
  precachemodel("mil_sandbag_plastic_white_single_bent");
  precachemodel("weapon_binocular");

  add_hint_string("how_to_pop_flare", &"SCRIPT_PLATFORM_HINTSTR_POPFLARE", ::stop_flare_hint);

  level.default_goalheight = 72;

  maps\dc_whitehouse_anim::main();
  maps\_drone_ai::init();

  setsaveddvar("compassMaxRange", 4500);
  level thread maps\dc_whitehouse_amb::main();

  thread maps\_utility::set_ambient("dcemp_heavy_rain_tunnel");
  thread maps\_utility::vision_set_fog_changes("dc_whitehouse_tunnel", 0);

  level.player setempjammed(true);
  maps\_compass::setupMiniMap("compass_map_dcemp_static");

  add_global_spawn_function("allies", ::set_color_goal_func);

  array_thread(getvehiclenodearray("plane_sound", "script_noteworthy"), maps\_mig29::plane_sound_node);

  createthreatbiasgroup("ignore_player");
  createthreatbiasgroup("player");
  SetIgnoreMeGroup("player", "ignore_player");
  level.player setthreatbiasgroup("player");

  delaythread(1, ::flavorbursts_off, "allies");

  array_thread(getEntArray("flickerlight1", "script_noteworthy"), ::flickerlight_flares);

  level thread music();
}

music() {
  music_loop("dc_whitehouse_tunneldrone", 140);

  flag_wait("music_cue");
  music_loop("dc_whitehouse_attack", 328, 1);

  flag_wait("whitehouse_entrance_clear");
  music_loop("dc_whitehouse_attack_int", 328, 7);

  flag_wait("whitehouse_2min");
  music_play("dc_whitehouse_endrun", 5);

  flag_wait("music_cue_endrun_ending");
  level thread music_stop(7);
  level.player play_sound_on_entity("dc_whitehouse_endrun_ending");
}

flags() {
  flag_init("team_initialized");

  flag_init("mg_threat");
  flag_init("oval_office_foley_react");
  flag_init("oval_office_done");
  flag_init("oval_office_door_open");
  flag_init("oval_office_moveout");
  flag_init("oval_office_anim_started");
  flag_init("oval_office_foley_inplace");
  flag_init("whitehouse_kitchen_open");
  flag_init("whitehouse_interior");
  flag_init("whitehouse_radio_done");
  flag_init("whitehouse_hammerdown");
  flag_init("whitehouse_hammerdown_stopped");
  flag_init("whitehouse_briefing_end");
  flag_init("whitehouse_hammerdown_started");
  flag_init("whitehouse_flare_breach");
  flag_init("whitehouse_wrapup");
  flag_init("whitehouse_completed");
  flag_init("broadcast");
  flag_init("broadcast_pause");
  flag_init("broadcast_end");
  flag_init("countdown");
  flag_init("whitehouse_hammerdown_jets");
  flag_init("whitehouse_hammerdown_jets_fly");
  flag_init("remove_use_hint");
  flag_init("flare_end_fx");
  flag_init("whitehouse_2min");
  flag_init("whitehouse_90sec");
  flag_init("whitehouse_1min");
  flag_init("whitehouse_30sec");
  flag_init("player_flare");
  flag_init("player_flare_popped");
  flag_init("remove_flare_hint");
  flag_init("player_looking_at_flareguy");
  flag_init("music_cue_endrun_ending");
}

start_tunnels() {
  spawn_team();
  activate_trigger_with_targetname("tunnels_init_color_trigger");

  level waittill("introscreen_complete");

  activate_trigger_with_targetname("tunnels_start_color_trigger");
  delaythread(4, ::activate_trigger_with_targetname, "tunnels_move_color_trigger");

  level thread objectives();
}

tunnels_main() {
  maps\_weather::rainhard(1);

  array_spawn_function_noteworthy("tunnels_wave_guy", ::tunnels_wave_guy);
  array_spawn_function_noteworthy("tunnels_twirl_guy", ::tunnels_twirl_guy);

  force_flash_setup();
  battlechatter_off("allies");

  level.foley thread init_foley();
  level.dunn thread init_dunn();

  flag_wait("tunnels_wave_guy");
  thread maps\_weather::rainLight(30);

  flag_wait("whitehouse_init");

  normal = maps\dc_whitehouse_fx::lightning_normal;
  flashfunc = maps\dc_whitehouse_fx::lightning_flash;
  thread maps\_weather::lightningFlash(normal, flashfunc);

  level thread whitehouse_main();
}

tunnels_dialogues() {
  flag_wait("whitehouse_ambience");

  level.dunn dialogue_queue("dcemp_cpd_partystarted");

  level.foley dialogue_queue("dcemp_fly_rogerstayfrosty");
}

tunnels_wave_guy() {
  self endon("death");

  node = getnode(self.target, "targetname");
  node thread anim_generic_loop(self, "wave_on");

  flag_wait("tunnels_wave_guy");

  wait 4.5;

  lines = [];
  lines[0] = "dcemp_ar3_hustleup";
  lines[1] = "dcemp_ar3_thisway";
  lines[2] = "dcemp_ar3_movemove";

  index = 0;
  while(!flag("whitehouse_init")) {
    self generic_dialogue_queue(lines[index]);
    wait randomfloatrange(7, 10);

    if(index == 2)
      wait 10;
    index = (index + 1) % lines.size;
  }

  self delete();
}

tunnels_twirl_guy() {
  animent = getent("tunnels_twirl_animent", "targetname");

  self walkdist_zero();
  animent anim_generic_reach(self, "combatwalk_F_spin");

  animent anim_generic(self, "combatwalk_F_spin");
  self enable_ai_color();
  self walkdist_reset();
}

whitehouse_main() {
  autosave_by_name("tunnel_exit");

  array_spawn_function_noteworthy("whitehouse_drone", ::whitehouse_drone);
  array_spawn_function_noteworthy("drone_war_drone", ::whitehouse_drone_war_drone);

  spawner = getent("marshall", "script_noteworthy");
  spawner add_spawn_function(::whitehouse_marshall);
  spawner spawn_ai();

  chandelier_setup();
  magic_rpg_setup();
  whitehouse_rappel_setup();
  sandbag_group_setup("sandbag_group");
  sandbag_group_setup("westwing_sandbag_group");
  whitehouse_mg_setup();
  westwing_mg_setup();
  level thread whitehouse_spotlight_main();

  level thread oval_office();
  level thread whitehouse_hammerdown();

  array_thread(level.team, ::whitehouse_team);

  level thread whitehouse_dialogue();
  level thread whitehouse_radio();
  level thread whitehouse_radio_loop();

  level.player.ignoreme = true;

  flag_wait("whitehouse_moveout");
  level.player.ignoreme = false;

  autosave_by_name("moveout");

  activate_trigger_with_targetname("whitehouse_moveout_color_trigger");

  battlechatter_on("allies");

  flag_wait("whitehouse_spotlight");
  thread maps\_weather::rainnone(20);

  level thread whitehouse_drone_slaughter();

  whitehouse_entrance();
}

whitehouse_spotlight_main() {
  flag_wait("whitehouse_spotlight");

  wh_spotlight = whitehouse_spotlight_create("whitehouse_spotlight", 400);
  wh_spotlight thread whitehouse_spotlight_dunn();

  flag_wait("whitehouse_entrance_init");

  if(isDefined(wh_spotlight))
    wh_spotlight.damage_ent notify("damage", 1000, level.player);

  ww_spotlight = whitehouse_spotlight_create("westwing_spotlight", 600);

  flag_wait("whitehouse_radio_start");
  wait 30;

  if(isDefined(ww_spotlight))
    ww_spotlight.damage_ent notify("damage", 1000, level.player);
}

whitehouse_spotlight_dunn() {
  flag_wait("whitehouse_entrance_moveup");
  wait 8;

  if(isDefined(self)) {
    level.dunn SetEntityTarget(self);
    self waittill("death");
    level.dunn clearEntityTarget();
  }
}

objectives() {
  wait 2;

  switch (level.start_point) {
    default:
    case "tunnels":
      Objective_Add(9, "current", &"DC_WHITEHOUSE_OBJ_WHISKEY_HOTEL");
      objective_onentity(9, level.foley, (0, 0, 70));

      flag_wait("whitehouse_moveout");
      wait 5;
      Objective_state(9, "done");

      pos = getstruct("objective_entrance", "targetname");
      Objective_Add(10, "current", &"DC_WHITEHOUSE_OBJ_BREACH_WH", pos.origin);

      flag_wait("oval_office_scene");
      level thread dunn_objective_dvars();

      objective_onentity(10, level.dunn, (0, 0, 70));

      flag_wait("oval_office_done");
      Objective_state(10, "done");

    case "flare":
      Objective_Add(11, "current", &"DC_WHITEHOUSE_OBJ_DEPLOY_FLARE");
      objective_onentity(11, level.foley, (0, 0, 70));

      flag_wait("whitehouse_flare_breach");
      SetSavedDvar("objectiveFadeTimeWaitOff", 0.5);
      SetSavedDvar("objectiveFadeTooFar", 0.1);

      objective_onentity(11, level.flare_guy, (0, 0, 70));

      flag_wait("whitehouse_hammerdown_jets_safe");
      wait 2;
      Objective_state(11, "done");
  }

  flag_wait("whitehouse_completed");

  wait 3;
  fade_out_level(3.5);

  if(is_default_start()) {
    nextmission();
  } else
    IPrintLnBold("DEVELOPER: END OF SCRIPTED LEVEL");
}

dunn_objective_dvars() {
  objectiveFadeTimeWaitOff = getdvarfloat("objectiveFadeTimeWaitOff");
  objectiveFadeTooFar = getdvarfloat("objectiveFadeTooFar");
  SetSavedDvar("objectiveFadeTimeWaitOff", 0.5);
  SetSavedDvar("objectiveFadeTooFar", 0.1);

  wait 2;

  SetSavedDvar("objectiveFadeTimeWaitOff", objectiveFadeTimeWaitOff);
  SetSavedDvar("objectiveFadeTooFar", objectiveFadeTooFar);
}

start_oval_office() {
  spawn_team();
  dcwh_teleport_team(level.team, getStructArray("oval_office_start_points", "targetname"));
  dcwh_teleport_player();

  chandelier_setup();
  thread maps\_utility::vision_set_fog_changes("dc_whitehouse_lawn", 0);

  level.foley thread init_foley();
  level.dunn thread init_dunn();
  level thread westwing_dialogue();

  activate_trigger_with_targetname("allies_lawn_trigger");
  activate_trigger_with_targetname("whitehouse_approach_color_trigger");

  flag_set("whitehouse_moveout");
  flag_set("whitehouse_briefing_end");
  flag_set("whitehouse_radio_start");
  flag_set("whitehouse_entrance_clear");

  level thread objectives();
  level thread whitehouse_radio();
  level thread whitehouse_radio_loop();
  level thread oval_office();
}

oval_office() {
  level thread oval_office_window();
  level thread oval_office_door();
  level thread oval_office_painting();
  level thread oval_office_dialogue();

  flag_wait("oval_office_scene");
  battlechatter_off("allies");

  flag_wait("oval_office_moveout");
  activate_trigger_with_targetname("oval_office_exit_enemies_trigger");
  activate_trigger_with_targetname("oval_office_exit_color_trigger");

  battlechatter_on("allies");
}

oval_office_dialogue() {
  flag_wait("oval_office_foley_dialogue");

  level.foley dialogue_queue("dcwhite_fly_dunngetdoor");

  wait 2.5;
  if(!flag("oval_office_foley_inplace")) {
    level.foley dialogue_queue("dcwhite_fly_dunn");
    wait 2;
    level.foley dialogue_queue("dcwhite_fly_thatswhy");
  }
}

oval_office_window() {
  window_closed = getent("oval_office_window_closed", "targetname");
  window_opened = getent("oval_office_window_open", "targetname");
  barrel_clip = getent("oval_office_barrel_blocker", "targetname");
  barrel = getent(barrel_clip.target, "targetname");
  barrel_target = getstruct(barrel.target, "targetname");
  barrel_clip linkto(barrel);

  window_opened hide();

  flag_wait("oval_office_scene");

  window_opened show();

  window_opened connectpaths();
  window_closed connectpaths();
  window_closed delete();

  barrel_clip connectpaths();
  barrel.origin = barrel_target.origin;
}

oval_office_door() {
  animent = getent("oval_office_door_animent", "targetname");
  door = getent("oval_office_door", "targetname");

  flag_wait("oval_office_door_open");

  autosave_by_name("oval_office_door");

  door = getent("oval_office_door", "targetname");
  door RotateYaw(door.angles[1] + 170, 9, 0, 9);
  door connectpaths();

  wait 4;

  flag_set("oval_office_moveout");
}

whitehouse_dialogue() {
  level thread whitehouse_nag();

  level.marshall dialogue_queue("dcemp_cml_moremen");

  flag_wait("whitehouse_briefing_end");
  flag_wait("whitehouse_entrance_init");
  wait 4;

  level.foley dialogue_queue("dcemp_fly_punchthrough");

  level.foley dialogue_queue("dcemp_fly_machineguns");

  level thread westwing_dialogue();
}

westwing_dialogue() {
  flag_wait("whitehouse_entrance_clear");

  level.foley dialogue_queue("dcemp_fly_ramirezgo");

  flag_wait("whitehouse_2min");

  level.foley dialogue_queue("dcemp_fly_flattenthecity");

  level.foley dialogue_queue("dcemp_fly_lessthantwomins");

  flag_wait("whitehouse_90sec");

  level.foley dialogue_queue("dcemp_fly_90seconds");

  flag_wait("whitehouse_1min");

  level.foley dialogue_queue("dcemp_fly_60seconds");

  flag_wait("whitehouse_30sec");

  level.foley dialogue_queue("dcemp_fly_30seconds");
}

whitehouse_radio_broadcast(soundalias) {
  flag_waitopen("broadcast");
  flag_set("broadcast");

  radio_array = SortByDistance(level.radio_array, level.player.origin);
  play_count = 3;

  current_radios = [];

  level.radios = [];

  radio = undefined;
  for(i = 0; i < radio_array.size; i++) {
    dist = abs(level.player getEye()[2] - radio_array[i].origin[2]);
    if(dist > 150) {
      continue;
    }
    radio = radio_array[i];
    radio playSound(soundalias, "sounddone");

    current_radios[current_radios.size] = radio;

    play_count--;
    if(!play_count) {
      break;
    }
  }

  level.radios = current_radios;

  foreach(radio in current_radios) {
    radio add_wait(::waittill_msg, "sounddone");
  }
  do_wait();

  flag_clear("broadcast");
}

whitehouse_radio_loop() {
  level endon("broadcast_terminate");
  flag_wait("whitehouse_radio_start");

  while(true) {
    flag_clear("broadcast_end");

    flag_waitopen("broadcast_pause");

    whitehouse_radio_broadcast("dcemp_fp1_hammerdown");

    flag_waitopen("broadcast_pause");

    whitehouse_radio_broadcast("dcemp_fp1_highvalue");

    flag_waitopen("broadcast_pause");

    whitehouse_radio_broadcast("dcemp_fp1_greenflares");

    flag_waitopen("broadcast_pause");

    whitehouse_radio_broadcast("dcemp_fp1_willabort");

    flag_set("broadcast_end");
    wait 0.05;
  }
}

countdown_trigger() {
  self waittill("trigger");
  if(self.script_index == level.countdown_index) {
    flag_set("countdown");
  }
}

countdown_timeout() {
  level endon("countdown");
  wait 30;
  flag_set("countdown");
}

whitehouse_radio() {
  level endon("whitehouse_hammerdown");

  level.radio_array = getEntArray("radio_origin", "targetname");

  flag_wait("whitehouse_radio_start");

  level.countdown_index = 0;

  triggers = getEntArray("countdown_trigger", "targetname");
  array_thread(triggers, ::countdown_trigger);

  countdown_line = [];
  countdown_line[0] = "dcemp_fp1_2minutes";
  countdown_line[1] = "dcemp_fp1_90secs";
  countdown_line[2] = "dcemp_fp1_1minute";
  countdown_line[3] = "dcemp_fp1_30secs";

  countdown_flag = [];
  countdown_flag[0] = "whitehouse_2min";
  countdown_flag[1] = "whitehouse_90sec";
  countdown_flag[2] = "whitehouse_1min";
  countdown_flag[3] = "whitehouse_30sec";

  flag_wait("countdown_start");

  flag_set("whitehouse_interior");

  start_time = gettime();

  while(true) {
    level.countdown_index++;

    flag_set("broadcast_pause");
    flag_waitopen("broadcast");

    println("***********************************");
    println("********** COUNTDOWN: " + elapsed_time(start_time) + "**********");
    println("***********************************");
    level whitehouse_radio_broadcast(countdown_line[level.countdown_index - 1]);
    start_time = gettime();

    time_left = 120 - ((level.countdown_index - 1) * 30);
    level.hammerdown_time = gettime() + (time_left * 1000);

    flag_set(countdown_flag[level.countdown_index - 1]);

    if(level.countdown_index == 4) {
      break;
    }

    level thread countdown_timeout();
    wait 6;
    flag_clear("broadcast_pause");

    flag_wait("countdown");
    flag_clear("countdown");
  }

  flag_set("whitehouse_hammerdown_jets");

  flag_wait("whitehouse_path_office_2");

  level thread whitehouse_radio_broadcast("dcemp_fp1_beenauthorized");

  flag_wait("whitehouse_hammerdown_jets_fly");
  wait 7;

  whitehouse_radio_broadcast("dcemp_fp1_abortabort");

  whitehouse_radio_broadcast("dcemp_fp2_abortmission");
  wait 4;
  delaythread(1.5, ::flag_set, "whitehouse_wrapup");

  whitehouse_radio_broadcast("dcemp_fp3_rollingout");
}

whitehouse_hammerdown_jets() {
  level endon("whitehouse_hammerdown");

  flag_wait("whitehouse_path_office_2");
  activate_trigger_with_targetname("hammer_down_jet_safe_trigger");
  activate_trigger_with_targetname("flare_ai_color_trigger");
}

whitehouse_hammerdown() {
  level endon("whitehouse_path_roof");

  flag_wait("whitehouse_30sec");

  wait 30;

  level thread whitehouse_hammerdown_kill();
}

whitehouse_hammerdown_kill() {
  flag_set("whitehouse_hammerdown");

  whitehouse_radio_broadcast("dcemp_fp1_bombsaway");
  wait 1;

  exploder("carpetbomb");

  earthquake(0.1, 1, level.player.origin, 512);
  wait 0.5;
  earthquake(0.2, 1, level.player.origin, 512);
  wait 0.5;
  earthquake(0.4, 1, level.player.origin, 512);
  wait 0.5;
  earthquake(0.6, 3, level.player.origin, 512);
  wait .75;

  playFX(level._effect["carpetbomb"], level.player.origin);
  level.player playSound("explo_metal_rand");
  wait 0.5;

  level.foley stop_magic_bullet_shield();
  level.foley kill();

  level.dunn stop_magic_bullet_shield();
  level.dunn kill();

  if(isDefined(level.flare_guy)) {
    level.flare_guy stop_magic_bullet_shield();
    level.flare_guy kill();
  }

  level.player kill();
  waittillframeend;
  setDvar("ui_deadquote", &"DC_WHITEHOUSE_FLARE_DEADQUOTE");
}

whitehouse_nag() {
  level endon("whitehouse_entrance_init");

  flag_wait("whitehouse_briefing_end");

  while(true) {
    wait 30;

    level.foley dialogue_queue("dcemp_fly_workyourwayleft");
    wait 15;

    level.foley dialogue_queue("dcemp_fly_ramirezgo");
    wait 20;

    level.foley dialogue_queue("dcemp_fly_takeleftflank");
    wait 15;
  }
}

whitehouse_team() {
  if(self is_hero()) {
    return;
  }
  self endon("death");

  self.ignoreme = true;
  self.ignoreall = true;

  flag_wait("whitehouse_moveout");
  self.ignoreme = false;
  self.ignoreall = false;
}

whitehouse_briefing(animent) {
  guys = [];
  guys[0] = level.foley;
  guys[1] = level.marshall;

  animent anim_single(guys, "DCemp_whitehouse_briefing");
  flag_set("whitehouse_briefing_end");

  animent anim_loop_solo(level.marshall, "DCemp_whitehouse_briefing_idle");
}

init_foley() {
  self thread tunnel_foley();
  self thread lawn_foley();
  self thread oval_office_foley();
  self thread whitehouse_foley();
  self thread roof_foley();
}

tunnel_foley() {
  flag_wait("whitehouse_init");
  self.neverenablecqb = true;
  self disable_cqbwalk();
  self disable_ai_color();
  self.ignoreme = true;
  self.ignoreall = true;

  wait 1;

  node = getnode("foley_briefing_approach_node", "targetname");
  self.goalradius = node.radius;
  self setgoalnode(node);
  self waittill("goal");

  animent = getent("whitehouse_briefing_ent", "targetname");
  animent anim_reach_solo(self, "DCemp_whitehouse_briefing");

  level thread whitehouse_briefing(animent);
}

lawn_foley() {
  flag_wait("whitehouse_briefing_end");

  self enable_ai_color();

  self.neverenablecqb = undefined;
  self.ignoreme = false;
  self.ignoreall = false;
}

oval_office_foley() {
  flag_wait("oval_office_scene");

  if(distance(level.player.origin, level.foley.origin) > 500) {
    teleport_ent = getstruct("oval_office_foley_teleport", "targetname");
    level.foley ForceTeleport(teleport_ent.origin, teleport_ent.angles);
  }

  self disable_ai_color();

  animent = getent("oval_office_animent", "targetname");
  animent anim_reach_solo(self, "dcemp_wh_radio_1");
  animent anim_single_solo(self, "dcemp_wh_radio_1");

  animent thread anim_loop_solo(self, "dcemp_wh_radio_1_idle");

  if(!flag("oval_office_foley_react")) {
    flag_set("oval_office_foley_inplace");

    flag_wait("oval_office_foley_react");
    animent notify("stop_loop");
    animent anim_single_solo_run(self, "dcemp_wh_radio_1_exit");
  } else {
    flag_wait("oval_office_moveout");
    animent notify("stop_loop");
  }

  flag_set("oval_office_done");
  self enable_ai_color();
}

whitehouse_foley() {
  flag_wait("whitehouse_breached");
  self disable_ai_color();

  door = getent("whitehouse_kitchen_door", "targetname");
  parts = getEntArray(door.target, "targetname");
  array_call(parts, ::linkto, door);

  animent = getent("whitehouse_kitchen_kick", "targetname");
  animent anim_generic_reach(level.foley, "doorburst_wave");
  animent thread anim_generic_gravity(level.foley, "doorburst_wave");
  door thread door_open_kick();

  flag_set("whitehouse_kitchen_open");
  self enable_heat_behavior(true);

  start_node = getnode("foley_wh_path", "targetname");
  self thread maps\_spawner::go_to_node(start_node);
  self.neverenablecqb = undefined;
  self enable_cqbwalk();
  self.ignoreme = false;
  self.ignoreall = false;

  self set_ignoreSuppression(true);
  self set_fixednode_false();

  flag_wait("whitehouse_path_elevator");

  self set_ignoreSuppression(false);
  self set_fixednode_true();
}

roof_foley() {
  flag_wait("whitehouse_hammerdown_jets_safe");
  self.neverenablecqb = true;
  self disable_cqbwalk();
  self disable_heat_behavior();
  self PushPlayer(true);
}

init_dunn() {
  self.ignoreme = true;
  self.ignoreall = true;

  wait 0.8;

  self thread lawn_dunn();
  self thread oval_office_dunn();
  self thread whitehouse_dunn();
  self thread roof_dunn();
}

lawn_dunn() {
  flag_wait("whitehouse_moveout");
  self.ignoreme = false;
  self.ignoreall = false;
}

oval_office_dunn() {
  flag_wait("whitehouse_entrance_clear");
  self disable_ai_color();
  self set_goal_node_targetname("whitehouse_entrance_dunn_node");

  flag_wait("oval_office_scene");

  self.neverenablecqb = undefined;
  self enable_cqbwalk();

  struct = getstruct("oval_office_dune_start", "targetname");
  self ForceTeleport(struct.origin, struct.angles);

  animent = getent("oval_office_animent", "targetname");
  level thread oval_office_clear_axis(animent);

  self walkdist_zero();
  animent anim_reach_solo(self, "dcemp_wh_radio");

  flag_set("oval_office_anim_started");

  guys = [];
  guys[0] = self;
  guys[1] = level.painting;

  animent anim_single(guys, "dcemp_wh_radio", undefined);

  self enable_ai_color();
  self walkdist_reset();
}

oval_office_clear_axis(animent) {
  axis = SortByDistance(getaiarray("axis"), animent.origin);

  for(i = 0; i < axis.size && i < 3; i++) {
    axis[i] kill(level.dunn.origin);
  }
}

oval_office_painting() {
  animent = getent("oval_office_animent", "targetname");

  level.painting = spawn_anim_model("painting", animent.origin);

  animent anim_first_frame_solo(level.painting, "dcemp_wh_radio");
}

whitehouse_dunn() {
  flag_wait("whitehouse_breached");
  self disable_ai_color();
  start_node = getnode("dunn_wh_path", "targetname");
  self thread maps\_spawner::go_to_node(start_node);

  flag_wait("whitehouse_kitchen_open");
  self enable_heat_behavior(true);

  flag_wait("whitehouse_hammerdown_jets_safe");
  self PushPlayer(true);
}

roof_dunn() {
  flag_wait("whitehouse_hammerdown_jets_safe");
  self.neverenablecqb = true;
  self disable_cqbwalk();
  self disable_heat_behavior();
}

whitehouse_marshall() {
  self endon("death");

  self.animname = "marshall";
  self.ignoreme = true;
  self.ignoreall = true;
  level.marshall = self;
  self magic_bullet_shield();

  self AllowedStances("crouch");

  animent = getent("whitehouse_briefing_ent", "targetname");
  animent thread anim_first_frame_solo(self, "DCemp_whitehouse_briefing");

  self Attach("weapon_binocular", "tag_inhand");

  flag_wait("whitehouse_briefing_end");
  flag_wait("whitehouse_spotlight");

  self stop_magic_bullet_shield();
  self delete();
}

whitehouse_entrance() {
  flag_wait("whitehouse_entrance_moveup");
  level thread whitehouse_cleanup_approach();

  flag_wait("whitehouse_entrance_init");
  autosave_by_name("entrance");

  flag_wait("countdown_start");
  autosave_by_name("countdown_started");

  flag_wait("whitehouse_breached");

  activate_trigger_with_targetname("drone_war_trigger");

  flag_wait("whitehouse_kitchen_open");

  whitehouse_interior();
}

whitehouse_interior() {
  set_group_advance_to_enemy_parameters(45, 1);
  reset_group_advance_to_enemy_timer("axis");

  level thread whitehouse_hammerdown_jets();
  level thread whitehouse_flare();

  setsaveddvar("ai_friendlysuppression", 0);
  setsaveddvar("ai_friendlyfireblockduration", 0);

  flag_wait("whitehouse_path_elevator");

  time_left = (level.hammerdown_time - gettime()) / 1000;
  if(time_left > 70)
    autosave_by_name("whitehouse_parlor");

  flag_wait("whitehouse_chandelier");
  source_ent = getent("chandelier_grenade_source", "targetname");
  target_ent = getent(source_ent.target, "targetname");
  MagicGrenade("fraggrenade", source_ent.origin, target_ent.origin, 1.5);

  flag_wait("whitehouse_path_stairs");

  battlechatter_off("allies");
}

whitehouse_drone() {
  self endon("death");

  if(!isDefined(level.whitehouse_drone_array))
    level.whitehouse_drone_array = [];
  level.whitehouse_drone_array[level.whitehouse_drone_array.size] = self;

  self.health = 10000;

  flag_wait("whitehouse_silhouette_ready");

  if(isDefined(self.script_animation))
    self.deathanim = level.drone_death_anims[self.script_animation];

  self.health = 200;
}

whitehouse_drone_war_drone() {
  self endon("death");

  flag_wait("whitehouse_path_roof");
  wait randomfloat(5);
  self delete();
}

start_flare() {
  spawn_team();
  dcwh_teleport_team(level.team, getStructArray("flare_start_points", "targetname"));
  dcwh_teleport_player();

  thread maps\_utility::set_ambient("dcemp_dry");

  chandelier_setup();
  thread maps\_utility::vision_set_fog_changes("dc_whitehouse_interior", 0);

  level.hammerdown_time = gettime();

  level thread whitehouse_interior();
  level thread whitehouse_radio();

  flag_set("whitehouse_path_elevator");
  flag_set("whitehouse_chandelier");
  flag_set("whitehouse_radio_start");
  flag_set("whitehouse_breached");

  wait 0.1;
  level.countdown_index = 2;
  flag_set("whitehouse_radio_done");
  flag_set("countdown_start");
  flag_clear("broadcast");

  level.foley thread roof_foley();
  level.dunn thread roof_dunn();

  node = getnode("foley_flare_start", "script_noteworthy");
  level.foley thread maps\_spawner::go_to_node(node);
  node = getnode("dunn_flare_start", "script_noteworthy");
  level.dunn thread maps\_spawner::go_to_node(node);

  level thread objectives();

  battlechatter_off("allies");

  music_play("dc_whitehouse_endrun", 1);

  flag_wait("music_cue_endrun_ending");
  level thread music_stop(7);
  level.player play_sound_on_entity("dc_whitehouse_endrun_ending");
}

whitehouse_flare() {
  level thread whitehouse_flare_breach();

  array_spawn_function_noteworthy("whitehouse_flare_guy", ::whitehouse_flare_guy);
  array_spawn_function_noteworthy("blind_enemies", ::blind_enemies);
  array_spawn_function_noteworthy("whitehouse_flare_breach_guy", ::whitehouse_flare_breach_guy);

  level.player thread whitehouse_player_flare();
  level thread flare_dialogue();

  flag_wait("whitehouse_flare_run");

  exploder("roof_flares");
}

flare_dialogue() {
  level endon("whitehouse_hammerdown");

  flag_wait("whitehouse_flare_run");
  wait 1.5;

  level.foley dialogue_queue("dcemp_fly_gettoroof");

  flag_wait("whitehouse_hammerdown_jets_fly");
  wait 2;

  flag_set("player_flare");

  level.foley dialogue_queue("dcemp_fly_useyourflares");

  flag_wait("whitehouse_wrapup");

  level.flare_guy dialogue_queue("dcemp_ar1_moscow");

  level.dunn SetLookAtEntity(level.flare_guy);
  level.dunn dialogue_queue("dcwhite_cpd_burnitdown");

  level.flare_guy dialogue_queue("dcwhite_ar1_huah");
  level.dunn SetLookAtEntity();

  flag_set("whitehouse_completed");

  level.foley dialogue_queue("dcemp_fly_timeisright");
}

whitehouse_flare_breach() {
  flag_wait("whitehouse_flare_breach");

  exploder("flare_breach");
}

whitehouse_flare_guy() {
  self endon("death");

  self disable_arrivals();
  self disable_exits();
  self disable_surprise();
  self disable_turnanims();

  level.flare_guy = self;

  flag_set("whitehouse_flare_breach");

  self notify("stop_going_to_node");

  self magic_bullet_shield();
  self.ignoreme = true;
  self.animname = "flare_guy";

  self set_run_anim("whitehouse_ending_runuphill");

  wait 0.1;

  animent = getent("ramp_flare_animent", "targetname");

  animent thread anim_loop_solo(self, "dcemp_flare_reshoot_start_idle");

  flag_wait("whitehouse_path_office");

  level.player thread flare_spotted_think();

  self.neverenablecqb = true;
  self disable_cqbwalk();

  animent notify("stop_loop");

  flag_set("music_cue_endrun_ending");
  animent thread anim_single_solo_run(self, "dcemp_flare_reshoot_start");

  wait 4;

  if(!flag("whitehouse_flare_run") || !flag("player_looking_at_flareguy")) {
    self anim_stopanimscripted();

    animent anim_first_frame_solo(self, "dcemp_flare_reshoot_start_short");

    flag_wait("player_looking_at_flareguy");

    level notify("flare_spotted");

    animent anim_single_solo_run(self, "dcemp_flare_reshoot_start_short");
  } else {
    level notify("flare_spotted");

    animent waittill("dcemp_flare_reshoot_start");
  }

  animent = getent("flare_scene_upper_animent", "targetname");
  animent anim_reach_solo(self, "dcemp_flare_reshoot_end");

  if(!flag("whitehouse_path_roof")) {
    animent anim_first_frame_solo(self, "dcemp_flare_reshoot_end");
    flag_wait("whitehouse_path_roof");
  }

  flag_set("whitehouse_hammerdown_jets_fly");
  flag_set("whitehouse_hammerdown_jets_safe");
  flag_set("music_cue_endrun_ending");

  self playSound("scn_dcwhite_npc_flare_end");
  animent anim_single_solo(self, "dcemp_flare_reshoot_end");

  self anim_loop_solo(self, "dcemp_flare_idle");
}

flare_spotted_think() {
  level endon("flareguy_flare_popped");
  level endon("flare_spotted");
  level.flare_guy endon("death");

  while(true) {
    if(player_looking_at(level.flare_guy getEye(), 0.75))
      flag_set("player_looking_at_flareguy");
    else if(flag("flareguy_force"))
      flag_set("player_looking_at_flareguy");
    else
      flag_clear("player_looking_at_flareguy");
    wait 0.05;
  }
}

whitehouse_flare_breach_guy() {
  self.neverenablecqb = true;
  self disable_cqbwalk();
}

whitehouse_player_flare() {
  flag_wait("player_flare");

  self thread flare_weapon();
}