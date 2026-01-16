/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_amb.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_audio;

main() {
  level._audio_spiderbot_override = ::start_spiderbot_audio;
  snd_set_snapshot("spl_karma_fade_in");
  declareambientroom("karma_entrance_roof", 1);
  setambientroomtone("karma_entrance_roof", "", 0.5, 0.5);
  setambientroomreverb("karma_entrance_roof", "karma_roof", 1, 1);
  setambientroomcontext("karma_entrance_roof", "ringoff_plr", "outdoor");
  declareambientpackage("karma_entrance_roof");
  addambientelement("karma_entrance_roof", "amb_wind_gust_oneshot", 5, 20, 100, 900);
  declareambientroom("karma_entrance_security");
  setambientroomtone("karma_entrance_security", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_security", "karma_security", 1, 1);
  setambientroomcontext("karma_entrance_security", "ringoff_plr", "indoor");
  declareambientpackage("karma_entrance_security");
  declareambientroom("karma_entrance_desk");
  setambientroomtone("karma_entrance_desk", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_desk", "karma_lobby", 1, 1);
  setambientroomcontext("karma_entrance_desk", "ringoff_plr", "indoor");
  declareambientpackage("karma_entrance_desk");
  declareambientroom("karma_entrance_waiting");
  setambientroomtone("karma_entrance_waiting", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_waiting", "karma_mediumroom", 1, 1);
  setambientroomcontext("karma_entrance_waiting", "ringoff_plr", "indoor");
  declareambientpackage("karma_entrance_waiting");
  declareambientroom("karma_entrance_elevator");
  setambientroomtone("karma_entrance_elevator", "blk_karma_elevator_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_elevator", "karma_mediumroom", 1, 1);
  setambientroomcontext("karma_entrance_elevator", "ringoff_plr", "indoor");
  declareambientpackage("karma_entrance_elevator");
  declareambientroom("karma_salazar_exit_room");
  setambientroomtone("karma_salazar_exit_room", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_salazar_exit_room", "karma_smallroom", 1, 1);
  setambientroomcontext("karma_salazar_exit_room", "ringoff_plr", "indoor");
  declareambientpackage("karma_salazar_exit_room");
  declareambientroom("karma_lobby_elevator_area");
  setambientroomtone("karma_lobby_elevator_area", "blk_karma_hall_bg", 1, 1);
  setambientroomreverb("karma_lobby_elevator_area", "karma_elevator_area", 1, 1);
  setambientroomcontext("karma_lobby_elevator_area", "ringoff_plr", "indoor");
  declareambientpackage("karma_lobby_elevator_area");
  declareambientroom("karma_construct_med");
  setambientroomtone("karma_construct_med", "amb_karma_const_bg", 0.5, 0.5);
  setambientroomreverb("karma_construct_med", "karma_construct_site", 1, 1);
  setambientroomcontext("karma_construct_med", "ringoff_plr", "indoor");
  declareambientpackage("karma_construct_med");
  declareambientroom("karma_construct_sml");
  setambientroomtone("karma_construct_sml", "amb_karma_const_bg", 0.5, 0.5);
  setambientroomreverb("karma_construct_sml", "karma_construct_site_sml", 1, 1);
  setambientroomcontext("karma_construct_sml", "ringoff_plr", "indoor");
  declareambientpackage("karma_construct_sml");
  declareambientroom("karma_office_med");
  setambientroomtone("karma_office_med", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_office_med", "karma_office_sml", 1, 1);
  setambientroomcontext("karma_office_med", "ringoff_plr", "indoor");
  declareambientpackage("karma_office_med");
  declareambientroom("karma_office_hall");
  setambientroomtone("karma_office_hall", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_office_hall", "karma_office_sml", 1, 1);
  setambientroomcontext("karma_office_hall", "ringoff_plr", "indoor");
  declareambientpackage("karma_office_hall");
  declareambientroom("karma_construct_freight");
  setambientroomtone("karma_construct_freight", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_construct_freight", "karma_vader_freight", 1, 1);
  setambientroomcontext("karma_construct_freight", "ringoff_plr", "indoor");
  declareambientpackage("karma_construct_freight");
  declareambientroom("karma_spider_vent");
  setambientroomtone("karma_spider_vent", "blk_karma_vent_bg", 0.5, 0.5);
  setambientroomreverb("karma_spider_vent", "karma_spider_vents", 1, 1);
  setambientroomcontext("karma_spider_vent", "ringoff_plr", "indoor");
  declareambientpackage("karma_spider_vent");
  declareambientroom("karma_spider_vent_novox");
  setambientroomtone("karma_spider_vent_novox", "blk_karma_vent_bg", 0.5, 0.5);
  setambientroomreverb("karma_spider_vent_novox", "karma_spider_vents", 1, 1);
  setambientroomcontext("karma_spider_vent_novox", "ringoff_plr", "indoor");
  setambientroomsnapshot("karma_spider_vent_novox", "spl_karma_spiderbot_novox");
  declareambientpackage("karma_spider_vent_novox");
  declareambientroom("spiderbot");
  setambientroomtone("spiderbot", "blk_karma_vent_bg", 0.5, 0.5);
  setambientroomreverb("spiderbot", "karma_spider_vents", 1, 1);
  setambientroomcontext("spiderbot", "ringoff_plr", "indoor");
  declareambientpackage("spiderbot");
  declareambientroom("karma_cic_main");
  setambientroomtone("karma_cic_main", "amb_karma_computer_bg", 0.5, 0.5);
  setambientroomreverb("karma_cic_main", "karma_comproom_lg", 1, 1);
  setambientroomcontext("karma_cic_main", "ringoff_plr", "indoor");
  declareambientpackage("karma_cic_main");
  declareambientroom("karma_cic_main_sml");
  setambientroomtone("karma_cic_main_sml", "amb_karma_computer_bg", 0.5, 0.5);
  setambientroomreverb("karma_cic_main_sml", "karma_comproom_sml", 1, 1);
  setambientroomcontext("karma_cic_main_sml", "ringoff_plr", "indoor");
  declareambientpackage("karma_cic_main_sml");
  declareambientroom("karma_pre_outer");
  setambientroomtone("karma_pre_outer", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_pre_outer", "karma_club_outer_live", 1, 1);
  setambientroomcontext("karma_pre_outer", "ringoff_plr", "indoor");
  declareambientpackage("karma_pre_outer");
  declareambientroom("karma_solar_outer");
  setambientroomtone("karma_solar_outer", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_solar_outer", "karma_club_outer_dead", 1, 1);
  setambientroomcontext("karma_solar_outer", "ringoff_plr", "indoor");
  declareambientpackage("karma_solar_outer");
  declareambientroom("karma_solar_lounge");
  setambientroomtone("karma_solar_lounge", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_solar_lounge", "karma_club_outer_bar", 1, 1);
  setambientroomcontext("karma_solar_lounge", "ringoff_plr", "indoor");
  declareambientpackage("karma_solar_lounge");
  declareambientroom("karma_solar_club");
  setambientroomtone("karma_solar_club", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_solar_club", "karma_club_solar", 1, 1);
  setambientroomcontext("karma_solar_club", "ringoff_plr", "indoor");
  declareambientpackage("karma_solar_club");
  declareambientroom("karma_final_room_med");
  setambientroomtone("karma_final_room_med", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_med", "karma_mediumroom", 1, 1);
  setambientroomcontext("karma_final_room_med", "ringoff_plr", "indoor");
  declareambientpackage("karma_final_room_med");
  declareambientroom("karma_final_room_partial");
  setambientroomtone("karma_final_room_partial", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_partial", "karma_partial", 1, 1);
  setambientroomcontext("karma_final_room_partial", "ringoff_plr", "outdoor");
  declareambientpackage("karma_final_room_partial");
  declareambientroom("karma_final_room_atrium");
  setambientroomtone("karma_final_room_atrium", "blk_karma_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_atrium", "karma_artium_huge", 1, 1);
  setambientroomcontext("karma_final_room_atrium", "ringoff_plr", "outdoor");
  declareambientpackage("karma_final_room_atrium");
  declareambientroom("outdoor");
  setambientroomreverb("outdoor", "karma_city", 1, 1);
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declareambientroom("ospree");
  setambientroomtone("ospree", "", 0.5, 0.5);
  setambientroomreverb("ospree", "karma_cockpit", 1, 1);
  setambientroomcontext("ospree", "ringoff_plr", "indoor");
  declareambientpackage("ospree");
  declaremusicstate("KARMA_1_INTRO");
  musicalias("mus_karma_intro", 4, 0);
  declaremusicstate("KARMA_1_CHECKIN");
  musicaliasloop("mus_karma_checkin_intro", 0, 1);
  declaremusicstate("KARMA_1_ALARM");
  musicalias("mus_karma_checkin_alarm", 0);
  musicwaittilldone();
  declaremusicstate("KARMA_1_POST_ALARM");
  musicaliasloop("null", 0, 2);
  declaremusicstate("KARMA_1_CONSTRUCTION");
  musicalias("mus_karma_construction", 1, 0, 9.5);
  musicaliasloop("mus_karma_dark_loop", 1, 3);
  declaremusicstate("KARMA_1_SPIDERBOT");
  musicaliasloop("mus_karma_spiderbot", 0, 1);
  declaremusicstate("KARMA_1_GULLIVER");
  musicalias("mus_karma_spiderbot_stg", 1, 0, 10);
  musicaliasloop("mus_karma_dark_loop", 10, 0);
  declaremusicstate("KARMA_1_ENTER_CRC");
  musicaliasloop("mus_karma_crc_fight_2", 0, 4);
  declaremusicstate("KARMA_1_CRC");
  musicaliasloop("mus_karma_crc_room", 0, 3);
  musicstinger("mus_karma_crc_room_karma", 3);
  declaremusicstate("KARMA_1_KARMA_FOUND");
  musicaliasloop("mus_karma_dark_loop", 6, 0);
  declaremusicstate("KARMA_POST_CRC");
  musicaliasloop("mus_karma_post_crc", 0, 0);
  musicstinger("mus_karma_post_crc_stg", 0);
  declaremusicstate("KARMA_ELEVATOR");
  musicaliasloop("mus_karma_dark_loop", 2, 8);
  declaremusicstate("KARMA_1_OUTER_SOLAR");
  musicaliasloop("null", 0, 1);
  declaremusicstate("KARMA_1_ENTER_CLUB");
  musicaliasloop("NULL", 0, 0);
  declaremusicstate("KARMA_1_DEFALCO");
  musicaliasloop("mus_karma_defalco_scene", 0, 0);
  declaremusicstate("KARMA_1_CLUB_FIGHT");
  musicaliasloop("NULL", 0, 0);
  level thread spiderbot_amb_convo_triggers();
  level thread waitfor_bodyscan();
  level thread waitfor_bodyscan_end();
  level thread wait_to_start_club_music();
  level thread wait_to_start_club_crowd();
  level thread turn_on_bullet_snapshot();
  level thread turn_off_bullet_snapshot();
  thread snd_fx_create();
  level thread wait_for_flag_set_lull();
  level thread wait_for_flag_set_action();
  level thread snapshot_check();
  level thread ospree_ambient_room();
  level thread reset_room();
  thread snd_start_autofx_audio();
  level thread checkin_sounds();
  level thread solarmusicduck();
  level thread solarmusicduck2();
  level thread levelfadeout();
  level thread eye_scanner_loop();
  level thread spiderbot_tunnel_ambience();
  level thread force_field();
  level thread server_loops();
  level thread playlobbywalla();
  level thread spawn_line_sounds_beach();
  level thread play_floor2_walla();
  level thread level_start_solar_duck();
  level thread play_muzak_lobby();
  level thread spawn_center_fountain_solar();
  array_thread(getstructarray("primary_alarm", "targetname"), ::primary_alarm);
}

play_muzak_lobby() {
  level waittill("clr_sec");
  wait 4;
  playsound(0, "mus_karma_checkin_end", (4672, -8356, 1067));
}

playlobbywalla() {
  playloopat("amb_atruim_walla_a", (4109, -7322, 1063));
  playloopat("amb_atruim_walla_b", (5127, -7105, 1061));
  playloopat("amb_atruim_walla_a", (4834, -8260, 977));
  playloopat("amb_atruim_walla_b", (4625, -8264, 1021));
}

play_floor2_walla() {
  level waittill("edo");
  playloopat("amb_atruim_walla_floor2", (4495, -6379, -2804));
  level waittill("edc");
  stoploopat("amb_atruim_walla_floor2", (4495, -6379, -2804));
}

snapshot_check() {
  level endon("intr_on");
  wait 3;
  snd_set_snapshot("default");
}

eye_scanner_loop() {
  playloopat("amb_retina_scanner", (5326, -6602, -3516));
}

start_spiderbot_audio(player) {
  self thread play_loops_for_player(player);
  self thread play_engine_audio();
  self thread change_ambient_room();
  self thread snd_spiderbot_look_servo_start();
}

snd_spiderbot_look_servo(loop) {
  self endon("entityshutdown");

  while(true) {
    movement = self getnormalizedcameramovement();
    movement = abs(movement[0]);
    soundvolume = scale_speed(0.1, 0.99, 0, 1, movement);
    setsoundvolume(loop, soundvolume * soundvolume * soundvolume);
    wait 0.001;
  }
}

snd_spiderbot_look_servo_start(loopsoundent) {
  loopsoundent = spawn(0, self.origin, "script_origin");
  loopsound = loopsoundent playloopsound("veh_spiderbot_look_servo", 0);
  self thread snd_spiderbot_look_servo(loopsound);
  self waittill_any("entityshutdown", "drpdn");
  loopsoundent stoploopsound();
  wait 1;
  loopsoundent delete();
}

spiderbot_tunnel_ambience() {
  while(true) {
    level waittill("invnt");
    playloopat("amb_steam_xsm", (5597, -7469, -3333));
    playloopat("amb_paper_scraps", (6211, -7057, -3250));
    playloopat("amb_openings", (5829, -7249, -3313));
    playloopat("amb_openings", (5830, -7216, -3313));
    playloopat("amb_openings", (5498, -7385, -3314));
    playloopat("amb_openings", (6445, -7024, -3376));
    playloopat("amb_fan_large", (5512, -7379, -3350));
    playloopat("amb_waterpipes", (6281, -7055, -3199));
    playloopat("amb_waterpipes", (6175, -7056, -3247));
    playloopat("amb_waterpipes", (6161, -7025, -3298));
    playloopat("amb_computer_bank_a", (5559, -7114, -3549));
    playloopat("amb_computer_bank_b", (5525, -7242, -3454));
    playloopat("amb_computer_bank_c", (5961, -7022, -3368));
    playloopat("amb_vent_walla", (5834, -7233, -3308));
    level waittill("otvnt");
    stoploopat("amb_steam_xsm", (5597, -7469, -3333));
    stoploopat("amb_paper_scraps", (6211, -7057, -3250));
    stoploopat("amb_openings", (5829, -7249, -3313));
    stoploopat("amb_openings", (5830, -7216, -3313));
    stoploopat("amb_openings", (5498, -7385, -3314));
    stoploopat("amb_openings", (6445, -7024, -3376));
    stoploopat("amb_fan_large", (5512, -7379, -3350));
    stoploopat("amb_waterpipes", (6281, -7055, -3199));
    stoploopat("amb_waterpipes", (6175, -7056, -3247));
    stoploopat("amb_waterpipes", (6161, -7025, -3298));
    stoploopat("amb_computer_bank_a", (5559, -7114, -3549));
    stoploopat("amb_computer_bank_b", (5525, -7242, -3454));
    stoploopat("amb_computer_bank_c", (5961, -7022, -3368));
    stoploopat("amb_vent_walla", (5834, -7233, -3308));
  }
}

server_loops() {
  playloopat("amb_scrolling_screen", (5717, -6923, -3481));
  playloopat("amb_scrolling_screen", (5823, -7086, -3471));
  playloopat("amb_scrolling_screen", (6138, -7226, -3499));
  playloopat("amb_scrolling_screen", (6462, -6772, -3488));
  playloopat("amb_scrolling_screen", (6241, -6775, -3493));
  playloopat("amb_scrolling_screen", (5783, -6693, -3512));
  playloopat("amb_scrolling_screen", (5686, -6920, -3501));
  playloopat("amb_scrolling_screen", (6614, -6189, -3516));
  playloopat("amb_scrolling_screen", (5812, -7215, -3544));
  playloopat("amb_server_hum", (5606, -7144, -3509));
  playloopat("amb_server_hum", (6106, -6568, -3507));
  playloopat("amb_server_hum", (5981, -7342, -3513));
  playloopat("amb_computer_desk", (5699, -6545, -3543));
  playloopat("amb_computer_desk_2", (6109, -7022, -3521));
  playloopat("amb_blue_panel", (6567, -7308, -3490));
  playloopat("amb_blue_panel", (6713, -6611, -3516));
  playloopat("amb_blue_panel", (6549, -6257, -3531));
  playloopat("amb_blue_panel", (6694, -6261, -3530));
}

force_field() {
  while(true) {
    level waittill("invnt");
    playloopat("amb_force_field", (5695, -7389, -3313));
    level waittill("frcx");
    stoploopat("amb_force_field", (5695, -7389, -3313));
  }
}

change_ambient_room() {
  self thread waitfor_exit_vehicle();
  activateambientpackage(0, "spiderbot", 20);
  activateambientroom(0, "spiderbot", 20);
  level thread updateactiveambientroom();
  level thread updateactiveambientpackage();
}

waitfor_exit_vehicle() {
  self waittill("exit_vehicle");
  deactivateambientpackage(0, "spiderbot", 20);
  deactivateambientroom(0, "spiderbot", 20);
}

play_loops_for_player(player) {
  loop_ent_1 = spawn(0, (0, 0, 0), "script_origin");
  loop_ent_2 = spawn(0, (0, 0, 0), "script_origin");
  self thread loop_cleanup("exit_vehicle", loop_ent_1, loop_ent_2);
  loop_ent_1 playloopsound("veh_spiderbot_ui_plr_loop1", 1);
  loop_ent_2 playloopsound("veh_spiderbot_ui_plr_loop2", 1);
}

play_engine_audio() {
  level endon("spiderbot_audio_cleanup");
  loop_ent_1 = spawn(0, (0, 0, 0), "script_origin");
  self thread loop_cleanup("exit_vehicle", loop_ent_1);

  while(true) {
    if(self getspeed() >= 5)
      loop_ent_1 playloopsound("veh_spiderbot_legs_loop_front", 0.05);
    else
      loop_ent_1 stoploopsound(0.1);

    wait 0.05;
  }
}

play_static_loop() {
  level endon("spiderbot_audio_cleanup");
  loop_ent_1 = spawn(0, (0, 0, 0), "script_origin");
  self thread loop_cleanup("exit_vehicle", loop_ent_1);
  loop_id = loop_ent_1 playloopsound("veh_spiderbot_static_loop", 1);
  setsoundvolume(loop_id, 0);

  while(true) {
    wait(randomfloatrange(2, 5));
    setsoundvolume(loop_id, randomfloatrange(0.8, 1));
    wait(randomfloatrange(0, 2));
    setsoundvolume(loop_id, randomfloatrange(0.4, 1));
    wait(randomfloatrange(0, 2));
    setsoundvolume(loop_id, 0);
  }
}

loop_cleanup(string, ent1, ent2, ent3, ent4) {
  if(!isDefined(string)) {
    return;
  }
  self waittill(string);
  level notify("spiderbot_audio_cleanup");
  wait 0.1;

  if(isDefined(ent1))
    ent1 delete();

  if(isDefined(ent2))
    ent2 delete();

  if(isDefined(ent3))
    ent3 delete();

  if(isDefined(ent4))
    ent4 delete();
}

spiderbot_amb_convo_triggers() {
  wait 5;
  array_thread(getentarray(0, "audio_spiderbot_convo", "targetname"), ::waitfor_convo_trigger);
}

waitfor_convo_trigger() {
  self waittill("trigger");
  struct = getstruct(self.target, "targetname");

  if(isDefined(struct.script_sound))
    playsound(0, struct.script_sound, struct.origin);
}

waitfor_bodyscan() {
  level waittill("kbss");
  snd_set_snapshot("spl_karma_bodyscan");
}

waitfor_bodyscan_end() {
  level waittill("kbse");
  snd_set_snapshot("default");
}

play_intro_blockout_pa_vox() {
  level endon("sbpv");
  level endon("slpa");
  wait 5;
  location = [];
  location[0] = spawnstruct();
  location[0].origin = (5172, -10291, 1145);
  location[0].alias = "vox_blk_pa_welcome_lrg";
  location[1] = spawnstruct();
  location[1].origin = (5063, -9699, 1036);
  location[1].alias = "vox_blk_pa_welcome_sml";
  location[2] = spawnstruct();
  location[2].origin = (5265, -9697, 1039);
  location[2].alias = "vox_blk_pa_welcome_sml";
  location[3] = spawnstruct();
  location[3].origin = (5158, -8890, 1058);
  location[3].alias = "vox_blk_pa_welcome_sml";
  location[4] = spawnstruct();
  location[4].origin = (5159, -8286, 818);
  location[4].alias = "vox_blk_pa_welcome_sml";
  location[5] = spawnstruct();
  location[5].origin = (4958, -7645, 769);
  location[5].alias = "vox_blk_pa_welcome_sml";
  location[6] = spawnstruct();
  location[6].origin = (5373, -7589, 773);
  location[6].alias = "vox_blk_pa_welcome_sml";

  while(true) {
    for(i = 0; i < location.size; i++)
      playsound(0, location[i].alias, location[i].origin);

    wait 18;
  }
}

primary_alarm() {
  level waittill("alarm_on");
  sound_ent = spawn(0, self.origin, "script_origin");
  sound_ent playloopsound("evt_primary_alarm", 0.1);
  wait 10;
  sound_ent stoploopsound(1);
  wait 1;
  sound_ent delete();
}

main_area_pa_vox_setup() {
  level waittill("slpa");
  test = getentarray(0, "karma_pa_lobby", "targetname");

  if(!isDefined(test[0])) {
    return;
  }
  pa_vox = [];
  pa_vox[0] = [];
  pa_vox[1] = [];

  for(i = 0; i < 5; i++) {
    pa_vox[0][i] = "vox_karma_pa_remind_0" + i;
    pa_vox[1][i] = "vox_karma_pa_ad_0" + i;
  }

  array_vox_remind = array_randomize(pa_vox[0]);
  array_vox_ad = array_randomize(pa_vox[1]);
  array_thread(getentarray(0, "karma_pa_lobby", "targetname"), ::play_main_area_pa_muzak);
  level thread pick_and_play_pa_vox(pa_vox);
}

pick_and_play_pa_vox(pa_vox) {
  ent_array = getentarray(0, "karma_pa_lobby", "targetname");
  num = 0;
  old_array = [];
  old_array[0] = pa_vox[0];
  old_array[1] = pa_vox[1];
  wait(randomintrange(5, 11));

  while(true) {
    if(num > 1)
      num = 0;

    alias = random(pa_vox[num]);
    arrayremovevalue(pa_vox[num], alias);

    for(i = 0; i < ent_array.size; i++)
      playsound(0, alias, ent_array[i].origin);

    if(pa_vox[num].size <= 0)
      pa_vox[num] = old_array[num];

    wait(randomintrange(30, 40));
    num++;
  }
}

play_main_area_pa_muzak() {
  self playloopsound("mus_karma_lobby", 1);
}

wait_to_start_club_music() {
  wait 2;
  struct = getstruct("blk_mus_club", "targetname");
  ent1 = spawn(0, struct.origin, "script_origin");
  ent2 = spawn(0, struct.origin, "script_origin");
  level thread play_club_lowend_until_door(struct);
  level waittill("scms");
  ent1 playloopsound("blk_mus_club", 0.1);
  level waittill("scm2");
  ent1 thread temp_stop_sound_wait();
  ent2 playloopsound("blk_mus_club_quiet", 0.1);
  playsound(0, "evt_enterclub_crowd_front", (0, 0, 0));
  level waittill("scm3");
  ent2 stoploopsound(1);
  ent1 playloopsound("blk_mus_club_fight", 0.1);
  wait 110;
  ent1 stoploopsound(3);
  wait 3;
  ent1 delete();
  ent2 delete();
}

temp_stop_sound_wait() {
  self stoploopsound(0.25);
}

play_club_lowend_until_door(struct) {
  level waittill("scle");
  ent1 = spawn(0, struct.origin, "script_origin");
  ent1 playloopsound("blk_mus_club_lowend", 3);
  level waittill("scms");
  ent1 stoploopsound(0.5);
  wait 2;
  ent1 delete();
}

wait_to_start_club_crowd() {
  level waittill("scm2");
  level notify("stop_solar_walla");
}

snd_fx_create() {
  waitforclient(0);
  clientscripts\_audio::snd_add_exploder_alias(913, "exp_metalstorm_explode");
  clientscripts\_audio::snd_add_exploder_alias(914, "exp_metalstorm_explode");
  clientscripts\_audio::snd_add_exploder_alias(915, "exp_metalstorm_explode");
}

turn_on_bullet_snapshot() {
  while(true) {
    level waittill("turn_on_bullet_snapshot");
    snd_set_snapshot("spl_karma_slow_bullet");
    wait 0.1;
  }
}

turn_off_bullet_snapshot() {
  while(true) {
    level waittill("turn_off_bullet_snapshot");
    snd_set_snapshot("default");
    wait 0.1;
  }
}

wait_for_flag_set_lull() {
  while(true) {
    level waittill("lull");
    level notify("client_lull_vox_on");
  }
}

wait_for_flag_set_action() {
  while(true) {
    level waittill("ccs");
    level notify("client_action_vox_on");
  }
}

ospree_ambient_room() {
  level waittill("ls_pio");
  activateambientpackage(0, "ospree", 1);
  activateambientroom(0, "ospree", 1);
}

reset_room() {
  level waittill("verb_reset");
  wait 7;
  deactivateambientpackage(0, "ospree", 50);
  deactivateambientroom(0, "ospree", 50);
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_pipe_steam_md", "amb_steam_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_pipe_steam_xsm", "amb_steam_xsm", 0, 0, 0, 0);
}

checkin_sounds() {
  playloopat("amb_scanner_int", (4560, -9446, 1004));
}

levelfadeout() {
  level waittill("sndFadeOut");
  wait 1;
  snd_set_snapshot("cmn_fade_out");
}

solarmusicduck() {
  while(true) {
    level waittill("sndDuckSolar");
    snd_set_snapshot("spl_karma_1_solarmus_duck");
    level waittill("sndDuckSolarOff");
    snd_set_snapshot("default");
  }
}

level_start_solar_duck() {
  level waittill("start");
  snd_set_snapshot("spl_karma_1_solarmus_duck2");
}

solarmusicduck2() {
  level thread solarmusicduck2_1();
  level thread solarmusicduck2_2();
}

solarmusicduck2_1() {
  while(true) {
    level waittill("club_music_duck");
    snd_set_snapshot("spl_karma_1_solarmus_duck2");
  }
}

solarmusicduck2_2() {
  while(true) {
    level waittill("club_music_duck_off");
    snd_set_snapshot("default");
  }
}

spawn_line_sounds_beach() {
  soundlineemitter("amb_beach_children", (3626, -6806, 1007), (5762, -6830, 1028));
}

spawn_center_fountain_solar() {
  playloopat("amb_fountain_ad_rm", (3898, -4312, -5050));
  playloopat("amb_atruim_walla_a", (3898, -4312, -5050));
}

sndplayshadows() {
  playloopat("mus_karma_lobby_shadows_real", (4757, -4292, -4987));
}

sndspdbotvox(set) {
  if(set == 1)
    snd_set_snapshot("spl_karma_spiderbot_novox");
  else
    snd_set_snapshot("default");
}