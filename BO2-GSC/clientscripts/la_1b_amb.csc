/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1b_amb.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  declareambientroom("outdoor", 1);
  setambientroomtone("outdoor", "blk_la_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("outdoor", "la_1_low_road", 1, 1);
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declareambientroom("indoor");
  setambientroomtone("indoor", "blk_la_indoor_bg", 0.5, 0.5);
  setambientroomreverb("indoor", "la_1_side_room", 1, 1);
  setambientroomcontext("indoor", "ringoff_plr", "indoor");
  declareambientpackage("indoor");
  declareambientroom("battle");
  setambientroomreverb("battle", "la_1_low_road", 1, 1);
  setambientroomcontext("battle", "ringoff_plr", "outdoor");
  declareambientpackage("battle");
  declareambientroom("staples_center");
  setambientroomtone("staples_center", "blk_la_indoor_bg", 0.5, 0.5);
  setambientroomreverb("staples_center", "la_1_arena", 1, 1);
  setambientroomcontext("staples_center", "ringoff_plr", "indoor");
  declareambientpackage("staples_center");
  declareambientroom("lobby");
  setambientroomreverb("lobby", "la_1_lobby", 1, 1);
  setambientroomcontext("lobby", "ringoff_plr", "indoor");
  declareambientpackage("lobby");
  declareambientroom("small_room");
  setambientroomreverb("small_room", "la_1_lobby", 1, 1);
  setambientroomcontext("small_room", "ringoff_plr", "indoor");
  declareambientpackage("small_room");
  declareambientroom("plaza_side_room");
  setambientroomreverb("plaza_side_room", "la_1_side_room", 1, 1);
  setambientroomcontext("plaza_side_room", "ringoff_plr", "indoor");
  declareambientpackage("plaza_side_room");
  declareambientroom("mall_room");
  setambientroomreverb("mall_room", "la_1_mallroom", 1, 1);
  setambientroomcontext("mall_room", "ringoff_plr", "indoor");
  declareambientpackage("mall_room");
  declareambientroom("la_small_room");
  setambientroomreverb("la_small_room", "la_1_smallroom", 1, 1);
  setambientroomcontext("la_small_room", "ringoff_plr", "indoor");
  declareambientpackage("la_small_room");
  declareambientroom("bus");
  setambientroomreverb("bus", "la_1_bus", 1, 1);
  setambientroomcontext("bus", "ringoff_plr", "indoor");
  declareambientroom("intro");
  setambientroomreverb("intro", "shock_flashbang", 1, 1);
  declaremusicstate("LA_1_INTRO");
  musicalias("mus_la1_intro", 0);
  musicaliasloop("NULL", 0, 0);
  declaremusicstate("LA_1_TURRET");
  musicaliasloop("mus_la1_turret", 0, 0);
  declaremusicstate("LA_1_OFF_TURRET");
  musicaliasloop("null", 0, 0);
  declaremusicstate("LA_1B_INTRO");
  musicaliasloop("mus_la1b_intro", 0, 5);
  declaremusicstate("LA_1B_INTRO_B");
  musicaliasloop("mus_street_intro", 2, 3);
  declaremusicstate("LA_1B_STREET_NO_MUSIC");
  musicaliasloop("null", 10, 0);
  declaremusicstate("LA_1B_STREET");
  musicaliasloop("mus_street_pad_loop", 1, 2);
  musicstinger("mus_claw_stg", 28, 1);
  declaremusicstate("LA_1B_STREET_CLAW_DEAD");
  musicaliasloop("mus_street_pad_loop_b", 2, 2);
  musicstinger("mus_street_battle_pres_stg", 18.5, 1);
  declaremusicstate("LA_1B_CLAW");
  musicaliasloop("mus_street_pad_loop", 0, 0);
  declaremusicstate("LA_1B_PLAZA");
  musicaliasloop("mus_plaza_loop", 0, 2);
  declaremusicstate("LA_1B_BUILDING_COLLAPSE");
  musicaliasloop("null", 0, 0);
  thread tv_sounds();
  thread snd_fx_create();
  level thread sam_turret_waitforon();
  level thread sam_turret_waitforoff();
  level thread set_intro_snapshot();
  level thread setup_ambient_fx_sounds();
  level thread air_raid_sirens();
  level thread f35_context();
  level thread battle_silent_context();
  level thread force_shock_file_for_intro();
  level thread force_street_flyby_snapshot();
  level thread sound_fade_out_snapshot();
  level thread play_f35_fire_sounds();
}

force_street_flyby_snapshot() {
  level waittill("fbsoff");
  snd_set_snapshot("default");
}

force_shock_file_for_intro() {
  level waittill("int_st");
  activateambientroom(0, "intro", 1);
  snd_set_snapshot("spl_la_1_cougar_exit_2");
  level waittill("stop_intro_snp");
  snd_set_snapshot("spl_la_1b_street_flyby_duck");
  deactivateambientroom(0, "intro", 1);
}

tv_sounds() {
  playloopat("blk_vox_emg_broadcast_big", (9099, -606, 413));
  playloopat("blk_vox_emg_broadcast_big", (10396, 874, 591));
  playloopat("blk_vox_emg_broadcast_big", (13964, -4424, 311));
  playloopat("blk_vox_emg_broadcast", (1625, 8261, 399));
  playloopat("blk_vox_emg_broadcast", (3312, 8935, 356));
}

sam_turret_waitforon() {
  setsoundcontext("f35", "exterior");
  level waittill("mTon");
  snd_set_snapshot("spl_la_1_turret_event");
  setsoundcontext("f35", "interior");
}

sam_turret_waitforoff() {
  level waittill("mToff");
  snd_set_snapshot("default");
  setsoundcontext("f35", "exterior");
}

set_intro_snapshot() {
  level waittill("intro_started");
  snd_set_snapshot("spl_la_1_intro_vehicle");
  level waittill("reset_snapshot");
  snd_set_snapshot("default");
}

snd_fx_create() {
  wait 1;
  clientscripts\_audio::snd_add_exploder_alias(405, "blk_f35_crash_impact");
  clientscripts\_audio::snd_add_exploder_alias(410, "blk_f35_crash_impact");
}

setup_ambient_fx_sounds() {
  snd_play_auto_fx("fx_fire_column_creep_xsm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_column_creep_sm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_wall_md", "amb_fire_medium", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_ceiling_md", "amb_fire_medium", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm_line", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm_ground", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_medium", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_window_lg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_window_xlg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_lg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_line_xlg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_water_splash_detail", "amb_pipe_splash", 0, 0, 0, 0);
  snd_play_auto_fx("fx_water_pipe_broken_gush", "amb_pipe_gush", 0, 0, 0, 0);
}

air_raid_sirens() {
  playloopat("amb_air_raid_siren_l", (16761, -5309, 386));
  playloopat("amb_air_raid_siren_r", (12408, -5867, 342));
}

f35_context() {
  waitforclient(0);
  setsoundcontext("f35", "exterior");
}

battle_silent_context() {
  level waittill("set_silent_context");
  waitforclient(0);
  setsoundcontext("battle", "silent");
}

sound_fade_out_snapshot() {
  level waittill("fade_out");
  snd_set_snapshot("spl_la1b_fadeout");
}

play_f35_fire_sounds() {
  level waittill("f35_crash_done");
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_large", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_fuel_sm_line", "amb_fire_large", 0, 0, 0, 0, 200, 2, "amb_fire_large");
}