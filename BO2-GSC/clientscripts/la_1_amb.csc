/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_1_amb.csc
**************************************/

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
  setambientroomreverb("indoor", "gen_mediumroom", 1, 1);
  setambientroomcontext("indoor", "ringoff_plr", "indoor");
  declareambientpackage("indoor");
  declareambientroom("battle");
  setambientroomtone("battle", "blk_la_battle_bg", 0.5, 0.5);
  setambientroomreverb("battle", "gen_city", 1, 1);
  setambientroomcontext("battle", "ringoff_plr", "battle");
  declareambientpackage("battle");
  declareambientroom("staples_center");
  setambientroomtone("staples_center", "blk_la_indoor_bg", 0.5, 0.5);
  setambientroomreverb("staples_center", "gen_mediumroom", 1, 1);
  setambientroomcontext("staples_center", "ringoff_plr", "indoor");
  declareambientpackage("staples_center");
  declareambientroom("lobby");
  setambientroomreverb("lobby", "la_1_lobby", 1, 1);
  setambientroomcontext("lobby", "ringoff_plr", "indoor");
  declareambientpackage("lobby");
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
  declareambientroom("la_1_intro_cougar");
  setambientroomreverb("la_1_intro_cougar", "la_1_intro_cougar", 1, 1);
  setambientroomcontext("la_1_intro_cougar", "ringoff_plr", "indoor");
  declareambientpackage("la_1_intro_cougar");
  declareambientroom("la_1_drivable_cougar");
  setambientroomreverb("la_1_drivable_cougar", "la_1_intro_cougar", 1, 1);
  setambientroomcontext("la_1_drivable_cougar", "ringoff_plr", "indoor");
  declareambientpackage("la_1_drivable_cougar");
  declareambientroom("la_1_post_intro");
  setambientroomreverb("la_1_post_intro", "la_1_low_road", 1, 1);
  setambientroomcontext("la_1_post_intro", "ringoff_plr", "indoor");
  declareambientpackage("la_1_post_intro");
  declaremusicstate("LA_1_INTRO");
  musicalias("mus_la1_intro", 0);
  declaremusicstate("LA_1_CRAWL");
  musicaliasloop("mus_crawl_pad_loop", 0, 0);
  declaremusicstate("LA_POST_CRASH");
  musicaliasloop("mus_post_crash_loop", 0, 3.5);
  musicstinger("mus_turret_jump", 12.5, 1);
  declaremusicstate("LA_1_TURRET");
  musicaliasloop("mus_la1_turret", 0, 0);
  declaremusicstate("LA_1_OFF_TURRET");
  musicalias("mus_anderson_reveal", 0, 0, 50);
  musicaliasloop("mus_post_anderson_loop", 0, 2);
  declaremusicstate("LA_1_SNIPER_RAPEL");
  musicaliasloop("mus_sniper_event_music", 2, 2);
  musicstinger("mus_post_sniper_stg", 11, 1);
  declaremusicstate("LA_1_BRIDGE_SCENE");
  musicalias("mus_sniper_event_stg", 0, 0, 42);
  musicaliasloop("mus_predrive_pad_loop", 0, 2);
  declaremusicstate("LA_1_PRE_DRIVE");
  musicaliasloop("mus_predrive_pad_loop", 0, 2);
  declaremusicstate("LA_1_DRIVE");
  musicaliasloop("mus_drive_loop", 1, 4);
  musicstinger("mus_drive_stg", 0);
  declaremusicstate("LA_1_HOPELESS");
  musicaliasloop("null", 0, 0);
  musicstinger("mus_drive_cresendo", 0, 1);
  declaremusicstate("LA_1_SEMI");
  musicaliasloop("null", 0, 0);
  thread tv_sounds();
  thread snd_fx_create();
  level thread cougar_radio_chatter();
  level thread sam_turret_snapshot_and_verb_on();
  level thread sam_turret_snapshot_and_verb_off();
  level thread sonar_vision();
  level thread set_intro_snapshot();
  level thread setup_ambient_fx_sounds();
  level thread play_siren_on_cop_car();
  level thread play_siren_on_cop_car_2();
  level thread f35_context();
  level thread cougar_crash_snapshot();
  level thread big_battle_ambience();
  level thread play_siren2_after_freeway();
  level thread play_distant_battle_bg_until_jump();
  level thread freeway_barrier_suspension_audio();
  level thread cougar_jump_duck();
  level thread battle_sam_context();
  level thread sndactivatedrivesnapshot();
  level thread drone_listener();
  level thread sound_fade_out_snapshot();
  level thread cougar_rattle_scaling();
  level thread post_anderson_reveal_fires();
  level thread snapshot_check();
  level thread play_cougar_heartbeat();
}

snapshot_check() {
  level endon("intr_on");
  wait 2;
  snd_set_snapshot("default");
}

sndactivatedrivesnapshot() {
  level waittill("snd_ADS");
  snd_set_snapshot("spl_la_1_drive");
  activateambientroom(0, "la_1_drivable_cougar", 80);
  activateambientpackage(0, "la_1_drivable_cougar", 80);
}

drone_listener() {
  level waittill("sds1");
  snd_set_snapshot("spl_la_1_drone");
  level thread play_heartbeat_drone();
  level waittill("sdfs1");
  snd_set_snapshot("spl_la_1_drone_incoming");
  wait 12;
  snd_set_snapshot("cmn_low_vehicles_and_ambience");
}

play_heartbeat_drone() {
  wait 1.5;
  playsound(0, "evt_drone_heartbeat", (0, 0, 0));
}

tv_sounds() {
  playloopat("blk_vox_emg_broadcast_big", (9099, -606, 413));
  playloopat("blk_vox_emg_broadcast_big", (10396, 874, 591));
  playloopat("blk_vox_emg_broadcast_big", (13964, -4424, 311));
  playloopat("blk_vox_emg_broadcast", (1625, 8261, 399));
  playloopat("blk_vox_emg_broadcast", (3312, 8935, 356));
}

sam_turret_snapshot_and_verb_on() {
  setsoundcontext("f35", "exterior");
  level waittill("mTon");
  setambientroomreverb("outdoor", "gen_smallroom", 1, 1);
  level notify("updateActiveAmbientRoom");
  setsoundcontext("f35", "interior");
}

set_intro_snapshot() {
  level waittill("intr_on");
  snd_set_snapshot("spl_la_1_intro_vehicle");
  activateambientroom(0, "la_1_intro_cougar", 50);
  level waittill("reset_snapshot");
  wait 5;
  snd_set_snapshot("spl_la_1_post_intro");
  deactivateambientroom(0, "la_1_intro_cougar", 50);
  activateambientroom(0, "la_1_post_intro", 50);
  level thread air_raid_sirens();
  level notify("intro_done");
  level waittill("snd_ECRWL");
  snd_set_snapshot("default");
  wait 1.7;
  deactivateambientroom(0, "la_1_post_intro", 50);
}

temp_remove_timer() {
  wait 0.1;
  level notify("over_black");
}

play_cougar_heartbeat() {
  level waittill("over_black");
  loop_ent_1 = spawn(0, (0, 0, 0), "script_origin");
  loop_ent_1 playloopsound("evt_la_1_intro_crawl_heartbeat", 1);
  level waittill("snd_ECRWL");
  loop_ent_1 stoploopsound();
  loop_ent_1 delete();
}

sam_turret_snapshot_and_verb_off() {
  level waittill("mToff");
  snd_set_snapshot("default");
  setambientroomreverb("outdoor", "gen_city", 1, 1);
  activateambientpackage(0, "outdoor", 0);
  activateambientroom(0, "outdoor", 0);
  level notify("updateActiveAmbientRoom");
  setsoundcontext("f35", "exterior");
}

snd_fx_create() {
  wait 1;
  clientscripts\_audio::snd_add_exploder_alias(210, "exp_mortar");
  clientscripts\_audio::snd_add_exploder_alias(211, "exp_mortar");
  clientscripts\_audio::snd_add_exploder_alias(212, "exp_mortar");
  clientscripts\_audio::snd_add_exploder_alias(405, "evt_freefall");
}

sonar_vision() {
  sonarent = spawn(0, (0, 0, 0), "script_origin");

  while(true) {
    level waittill("sonar_on");
    playsound(0, "evt_sonar_engage", (0, 0, 0));
    sonarent playloopsound("evt_sonar_loop", 1);
    level waittill("sonar_off");
    sonarent stoploopsound();
    playsound(0, "evt_sonar_disengage", (0, 0, 0));
  }
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
}

play_siren_on_cop_car() {
  copsiren1 = spawn(0, (8032, -46336, -48), "script_origin");
  copsiren1 playloopsound("amb_police_siren_stationary");
}

play_siren_on_cop_car_2() {
  copsiren2 = spawn(0, (8391, -39665, 372), "script_origin");
  copsiren2 playloopsound("amb_police_siren_stationary");
}

play_siren2_after_freeway() {
  copsiren1 = spawn(0, (14388, -17338, 148), "script_origin");
  copsiren2 = spawn(0, (14971, -17016, 163), "script_origin");
  copsiren1 playloopsound("amb_police_siren_stationary_2");
  copsiren2 playloopsound("amb_police_siren_stationary_2");
}

air_raid_sirens() {
  wait 8;
  playloopat("amb_air_raid_siren_l", (5876, -55025, 823));
  playloopat("amb_air_raid_siren_r", (10533, -55215, 801));
}

f35_context() {
  waitforclient(0);
  setsoundcontext("f35", "exterior");
}

cougar_radio_chatter() {
  level waittill("cougar_chatter");
  waitforclient(0);
  loop_ent_1 = spawn(0, (0, 0, 0), "script_origin");
  loop_ent_1 playloopsound("amb_radio_chatter_cougar_loop", 2);
  loop_ent_1 thread cougar_radio_chatter_cleanup();
}

cougar_radio_chatter_cleanup() {
  level waittill("sccs");
  self delete();
}

cougar_crash_snapshot() {
  level waittill("sccs");
  wait 1;
  snd_set_snapshot("spl_la_1_cougar_crash");
}

big_battle_ambience() {
  level waittill("bbvi0");
  snd_play_auto_fx("fx_la_overpass_debris_area_md", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  snd_play_auto_fx("fx_la_overpass_debris_area_lg", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  snd_play_auto_fx("fx_la_overpass_debris_area_md_line", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  snd_play_auto_fx("fx_la_overpass_debris_area_md_line_wide", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  snd_play_auto_fx("fx_la_overpass_debris_area_xlg", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  snd_play_auto_fx("fx_la_overpass_debris_area_lg_os", "evt_freeway_debris_drivethru", 0, 0, -300, 1, 100, 2, "evt_freeway_debris_drivethru");
  origin = spawn(0, (14993, -8519, 503), "script_origin");
  level.big_battle_loop_id = origin playloopsound("amb_big_battle_loop", 1);
  setsoundvolume(level.big_battle_loop_id, 0.5);
  level thread waitfor_volume_increase("bbvi1", 0.5, 1, 2);
}

waitfor_volume_increase(time_notify, old_volume, new_volume, time) {
  level waittill(time_notify);
  num = time / 0.1;
  diff = new_volume - old_volume;
  rate = diff / num;

  for(i = 0; i < num; i++) {
    old_volume = old_volume + rate;
    setsoundvolume(level.big_battle_loop_id, old_volume);
    wait 0.1;
  }
}

play_distant_battle_bg_until_jump() {
  level waittill("sdlbg");
  origin = spawn(0, (7833, -52918, 796), "script_origin");
  origin playloopsound("amb_la_big_battle_loop", 1);
  level waittill("scjs");
  origin stoploopsound(2);
  wait 2;
  origin delete();
}

freeway_barrier_suspension_audio() {
  wait 2;
  array_thread(getentarray(0, "audio_freeway_barrier", "targetname"), ::play_suspension_audio);
}

play_suspension_audio() {
  if(!isDefined(self)) {
    return;
  }
  self waittill("trigger");
  playsound(0, "evt_cougar_suspension_oneshot", (0, 0, 0));
}

cougar_jump_duck() {
  level waittill("scjs");
  snd_set_snapshot("spl_la_1_cougar_mount");
  wait 8;
  snd_set_snapshot("spl_la_1_turret_event");
}

battle_sam_context() {
  level waittill("set_sam_int_context");
  waitforclient(0);
  setsoundcontext("f35", "interior");
  level waittill("set_sam_ext_context");
  setsoundcontext("f35", "exterior");
}

sound_fade_out_snapshot() {
  level waittill("fade_out");
  snd_set_snapshot("cmn_fade_out");
}

cougar_rattle_scaling() {
  level waittill("drive_time");
  volumerate = 2;
  player = getlocalplayers()[0];
  rattle_ent = spawn(0, player.origin, "script_origin");
  rattle_ent linkto(player, "tag_origin");
  rattle_id = rattle_ent playloopsound("veh_cougar_int_rattle");
  setsoundvolume(rattle_id, 0);

  while(true) {
    last_pos_x = player.origin[0];
    last_pos_y = player.origin[1];
    wait 0.1;
    new_pos_x = abs(last_pos_x - player.origin[0]);
    new_pos_y = abs(last_pos_y - player.origin[1]);
    pos_xy = new_pos_x + new_pos_y;
    rattle_volume = scale_speed(10, 65, 0, 1, pos_xy);
    setsoundvolumerate(rattle_id, volumerate);
    setsoundvolume(rattle_id, rattle_volume);
  }
}

post_anderson_reveal_fires() {
  level waittill("and_reveal");
  snd_play_auto_fx("fx_fire_fuel_sm_line", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
}

turn_down_cougar() {
  level waittill("cougar_vol");
  snd_set_snapshot("spl_la_1_cougar_vol");
}