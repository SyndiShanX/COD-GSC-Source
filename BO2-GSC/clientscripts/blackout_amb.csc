/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\blackout_amb.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  snd_set_snapshot("spl_blackout_fadein");
  declareambientroom("blackout_outdoor", 1);
  setambientroomtone("blackout_outdoor", "blk_calm_wind_2d", 0.2, 0.5);
  setambientroomreverb("blackout_outdoor", "black_outdoor", 1, 1);
  setambientroomcontext("blackout_outdoor", "ringoff_plr", "outdoor");
  setambientroomcontext("blackout_outdoor", "grass", "no_grass");
  declareambientpackage("blackout_outdoor");
  declareambientroom("intro_room_sml");
  setambientroomreverb("intro_room_sml", "black_introom", 1, 1);
  setambientroomcontext("intro_room_sml", "ringoff_plr", "indoor");
  setambientroomcontext("intro_room_sml", "grass", "no_grass");
  declareambientroom("intro_hallway_sml");
  setambientroomreverb("intro_hallway_sml", "black_inthall", 1, 1);
  setambientroomcontext("intro_hallway_sml", "ringoff_plr", "indoor");
  setambientroomcontext("intro_hallway_sml", "grass", "no_grass");
  declareambientroom("intro_hallway_rooms_sml");
  setambientroomreverb("intro_hallway_rooms_sml", "black_inthall", 1, 1);
  setambientroomcontext("intro_hallway_rooms_sml", "ringoff_plr", "indoor");
  setambientroomcontext("intro_hallway_rooms_sml", "grass", "no_grass");
  declareambientroom("intro_pre_stair_room");
  setambientroomreverb("intro_pre_stair_room", "black_inthall", 1, 1);
  setambientroomcontext("intro_pre_stair_room", "ringoff_plr", "indoor");
  setambientroomcontext("intro_pre_stair_room", "grass", "no_grass");
  declareambientroom("hallway_stair_room");
  setambientroomreverb("hallway_stair_room", "black_stairs", 1, 1);
  setambientroomcontext("hallway_stair_room", "ringoff_plr", "indoor");
  setambientroomcontext("hallway_stair_room", "grass", "no_grass");
  declareambientroom("hallway_outside");
  setambientroomreverb("hallway_outside", "black_open_hall", 1, 1);
  setambientroomtone("blackout_outdoor", "blk_calm_wind_2d", 0.2, 0.5);
  setambientroomcontext("hallway_outside", "ringoff_plr", "outdoor");
  setambientroomcontext("hallway_outside", "grass", "no_grass");
  declareambientroom("hallway_outside_rooms");
  setambientroomreverb("hallway_outside_rooms", "black_open_smallroom", 1, 1);
  setambientroomcontext("hallway_outside_rooms", "ringoff_plr", "outdoor");
  setambientroomcontext("hallway_outside_rooms", "grass", "no_grass");
  declareambientroom("bridge_rooms_sml");
  setambientroomreverb("bridge_rooms_sml", "black_smallroom", 1, 1);
  setambientroomcontext("bridge_rooms_sml", "ringoff_plr", "indoor");
  setambientroomcontext("bridge_rooms_sml", "grass", "no_grass");
  declareambientroom("main_bridge_room");
  setambientroomreverb("main_bridge_room", "black_bridge_room", 1, 1);
  setambientroomcontext("main_bridge_room", "ringoff_plr", "indoor");
  setambientroomcontext("main_bridge_room", "grass", "no_grass");
  declareambientroom("main_bridge_map_room");
  setambientroomreverb("main_bridge_map_room", "black_smallroom", 1, 1);
  setambientroomcontext("main_bridge_map_room", "ringoff_plr", "indoor");
  setambientroomcontext("main_bridge_map_room", "grass", "no_grass");
  declareambientroom("main_bridge_room_front");
  setambientroomreverb("main_bridge_room_front", "black_bridge_room", 1, 1);
  setambientroomcontext("main_bridge_room_front", "ringoff_plr", "indoor");
  setambientroomcontext("main_bridge_room_front", "grass", "no_grass");
  declareambientroom("below_bridge_room");
  setambientroomreverb("below_bridge_room", "black_smallroom", 1, 1);
  setambientroomcontext("below_bridge_room", "ringoff_plr", "indoor");
  setambientroomcontext("below_bridge_room", "grass", "no_grass");
  declareambientroom("below_pipe_room");
  setambientroomreverb("below_pipe_room", "black_b_piperm", 1, 1);
  setambientroomcontext("below_pipe_room", "ringoff_plr", "indoor");
  setambientroomcontext("below_pipe_room", "grass", "no_grass");
  declareambientroom("below_pipe_room_stairs");
  setambientroomreverb("below_pipe_room_stairs", "black_stairs_2", 1, 1);
  setambientroomcontext("below_pipe_room_stairs", "ringoff_plr", "indoor");
  setambientroomcontext("below_pipe_room_stairs", "grass", "no_grass");
  declareambientroom("below_bridge_office_rooms");
  setambientroomreverb("below_bridge_office_rooms", "black_smallroom", 1, 1);
  setambientroomcontext("below_bridge_office_rooms", "ringoff_plr", "indoor");
  setambientroomcontext("below_bridge_office_rooms", "grass", "no_grass");
  declareambientroom("below_bridge_hallway");
  setambientroomreverb("below_bridge_hallway", "black_b_hall", 1, 1);
  setambientroomcontext("below_bridge_hallway", "ringoff_plr", "indoor");
  setambientroomcontext("below_bridge_hallway", "grass", "no_grass");
  declareambientroom("pre_security_stairs");
  setambientroomreverb("pre_security_stairs", "black_stairs", 1, 1);
  setambientroomcontext("pre_security_stairs", "ringoff_plr", "indoor");
  setambientroomcontext("pre_security_stairs", "grass", "no_grass");
  declareambientroom("security_rooms_sml");
  setambientroomreverb("security_rooms_sml", "black_sec_room", 1, 1);
  setambientroomcontext("security_rooms_sml", "ringoff_plr", "indoor");
  setambientroomcontext("security_rooms_sml", "grass", "no_grass");
  declareambientroom("engine_room_hallway_below");
  setambientroomreverb("engine_room_hallway_below", "black_sec_room", 1, 1);
  setambientroomcontext("engine_room_hallway_below", "ringoff_plr", "indoor");
  setambientroomcontext("engine_room_hallway_below", "grass", "no_grass");
  declareambientroom("engine_room_main");
  setambientroomreverb("engine_room_main", "black_med_sec_room", 1, 1);
  setambientroomcontext("engine_room_main", "ringoff_plr", "indoor");
  setambientroomcontext("engine_room_main", "grass", "no_grass");
  declareambientroom("small_stairs");
  setambientroomreverb("small_stairs", "black_med_sec_room", 1, 1);
  setambientroomcontext("small_stairs", "ringoff_plr", "indoor");
  setambientroomcontext("small_stairs", "grass", "no_grass");
  declareambientroom("pre_vent_room");
  setambientroomreverb("pre_vent_room", "black_med_sec_room", 1, 1);
  setambientroomcontext("pre_vent_room", "ringoff_plr", "indoor");
  setambientroomcontext("pre_vent_room", "grass", "no_grass");
  declareambientroom("air_vent");
  setambientroomreverb("air_vent", "black_vent", 1, 1);
  setambientroomcontext("air_vent", "ringoff_plr", "indoor");
  setambientroomcontext("air_vent", "grass", "no_grass");
  declareambientroom("server_room");
  setambientroomreverb("server_room", "black_server_room", 1, 1);
  setambientroomcontext("server_room", "ringoff_plr", "indoor");
  setambientroomcontext("server_room", "grass", "no_grass");
  declareambientroom("menendez_cctv_room");
  setambientroomreverb("menendez_cctv_room", "black_server_room", 1, 1);
  setambientroomcontext("menendez_cctv_room", "ringoff_plr", "indoor");
  setambientroomcontext("menendez_cctv_room", "grass", "no_grass");
  declareambientroom("hanger_control_room");
  setambientroomreverb("hanger_control_room", "black_hang_ctl", 1, 1);
  setambientroomcontext("hanger_control_room", "ringoff_plr", "indoor");
  setambientroomcontext("hanger_control_room", "grass", "no_grass");
  declareambientroom("hanger_control_room_stairs");
  setambientroomreverb("hanger_control_room_stairs", "black_hang_ctl", 1, 1);
  setambientroomcontext("hanger_control_room_stairs", "ringoff_plr", "indoor");
  setambientroomcontext("hanger_control_room_stairs", "grass", "no_grass");
  declareambientroom("hanger_room");
  setambientroomreverb("hanger_room", "black_hang_lg", 1, 1);
  setambientroomcontext("hanger_room", "ringoff_plr", "indoor");
  setambientroomcontext("hanger_room", "grass", "no_grass");
  declareambientroom("medium_room");
  setambientroomreverb("medium_room", "black_med_sec_room", 1, 1);
  setambientroomcontext("medium_room", "ringoff_plr", "indoor");
  setambientroomcontext("medium_room", "grass", "no_grass");
  declareambientroom("gas_mask");
  setambientroomtone("gas_mask", "evt_gasmask_loop", 3, 3);
  setambientroomreverb("gas_mask", "black_gasmask", 1, 1);
  setambientroomcontext("gas_mask", "grass", "in_grass");
  setambientroomsnapshot("gas_mask", "spl_blackout_gas_mask");
  declareambientroom("f35_int");
  setambientroomtone("f35_int", "");
  setambientroomreverb("f35_int", "black_cockpit", 1, 1);
  setambientroomsnapshot("f35_int", "veh_f35_int_blackout");
  setambientroomcontext("f35_int", "f35", "interior");
  setambientroomcontext("f35_int", "grass", "no_grass");
  declaremusicstate("BLACKOUT_INTRO");
  musicaliasloop("mus_blackout_intro", 2, 2);
  declaremusicstate("BLACKOUT_INTERROGATION");
  musicalias("mus_blackout_interrogation", 0, 2, 142);
  musicaliasloop("mus_blackout_menendez_esc", 0, 4);
  declaremusicstate("BLACKOUT_POST_INTERROGATION");
  musicaliasloop("mus_blackout_post_interrogation", 2, 2);
  declaremusicstate("BLACKOUT_BRIDGE_FIGHT");
  musicaliasloop("mus_blackout_action_1", 1, 4);
  declaremusicstate("BLACKOUT_PRE_MENENDEZ");
  musicaliasloop("mus_blackout_post_interrogation", 1, 10);
  declaremusicstate("BLACKOUT_MENENDEZ_WALK");
  musicaliasloop("mus_menendez_walk", 2, 8);
  declaremusicstate("BLACKOUT_MENENDEZ_HOLDUP");
  musicalias("mus_menendez_walk_shield", 2, 2);
  declaremusicstate("BLACKOUT_PRE_SUPERKILL");
  musicalias("mus_blackout_superkill_transition", 0.5, 2);
  declaremusicstate("BLACKOUT_POST_SUPERKILL");
  musicaliasloop("mus_blackout_post_superkill", 2, 4);
  declaremusicstate("BLACKOUT_EYEBALL");
  musicalias("mus_blackout_eyeball", 0, 0);
  declaremusicstate("BLACKOUT_ACTION_DISCOVERY");
  musicaliasloop("mus_blackout_action_discovery", 0, 4);
  declaremusicstate("BLACKOUT_ACTION_REALIZATION");
  musicaliasloop("mus_blackout_action_realization", 2, 3);
  declaremusicstate("BLACKOUT_ACTION_POST_DISCOVERY");
  musicaliasloop("mus_blackout_action_discovery", 2, 2);
  declaremusicstate("BLACKOUT_SALAZAR_CONFRONTATION");
  musicalias("mus_salazar_confrontation", 1, 0);
  declaremusicstate("BLACKOUT_DECK_FIGHT");
  musicaliasloop("mus_blackout_action_2", 1, 4);
  declaremusicstate("BLACKOUT_FLY_AWAY");
  musicalias("mus_blackout_flyaway", 0, 2);
  declaremusicstate("BLACKOUT_MENENDEZ_OVER");
  musicaliasloop("null", 0, 0);
  thread knocked_out_snapshots();
  thread bridge_walla_on_off();
  thread snd_start_autofx_audio();
  thread snd_commotion_start();
  thread walla_vignettes();
  thread random_alarms();
  thread activate_f35_room();
  thread computer_loops();
  thread nuke_loop();
  thread sndmaskoff();
  thread sound_fade_out_snapshot();
  thread menendez_mask_on();
  thread interrogation_lightflicker();
  thread play_ceiling_water_splash();
  thread snapshot_check();
  thread alarm_loop();
  thread time_passes();
  level thread introsnpshot();
  thread surgury_sfx();
}

introsnpshot() {
  level waittill("intr_on");
  snd_set_snapshot("spl_blackout_intro");
}

knocked_out_snapshots() {
  level thread set_knocked_out("on", "spl_blackout_knocked_out");
  level thread set_knocked_out("off", "default");
}

set_knocked_out(suffix, snapshot) {
  while(true) {
    level waittill("knc_" + suffix);
    snd_set_snapshot(snapshot);
  }
}

bridge_walla_on_off() {
  wait 2;
  ent = spawn(0, (323, 984, 500), "script_origin");
  ent playloopsound("amb_walla_fighting_loud", 1);
  level waittill("stop_Bwalla");
  wait 3;
  ent stoploopsound(5);
  wait 7;
  ent delete();
}

walla_vignettes() {
  level waittill("argument_done");
  location = [];
  location[0] = (613, 1200, 356);
  location[1] = (309, 1420, 500);
  location[2] = (192, 449, -208);
  location[3] = (498, 258, 323);
  location[4] = (628, 703, 355);
  location[5] = (101, 899, 334);
  location[6] = (1936, 879, -277);
  location[7] = (341, 1057, 227);
  location[8] = (685, 2653, -480);
  location[9] = (1787, -452, -407);
  location[10] = (613, 485, -226);
  location[11] = (1415, 1560, -352);
  location = array_randomize(location);

  for(i = 0; i < location.size; i++)
    level thread play_walla_vignettes(location[i], undefined);

  oneshot = [];
  oneshot[0] = spawnstruct();
  oneshot[0].location = (2343, 915, -250);
  oneshot[0].alias = "amb_walla_execution";
  oneshot[1] = spawnstruct();
  oneshot[1].location = (1744, 2602, -475);
  oneshot[1].alias = "amb_walla_crying";

  for(i = 0; i < oneshot.size; i++)
    level thread play_walla_vignettes(oneshot[i], 1);
}

play_walla_vignettes(array_value, oneshot) {
  if(isDefined(oneshot)) {
    player = getlocalplayers()[0];

    while(distance(player.origin, array_value.location) > 200)
      wait 0.5;

    playsound(0, array_value.alias, array_value.location);
    return;
  }

  if(randomintrange(0, 100) <= 75)
    playloopat("amb_walla_fighting_" + randomintrange(0, 2), array_value);
  else
    playloopat("amb_walla_stuck", array_value);
}

random_alarms() {
  level waittill("alarm_start");
  location = [];
  location[0] = (320, 254, 371);
  location[1] = (323, 993, 370);
  location[2] = (663, 1569, 400);
  location[3] = (426, 1207, 545);
  location[4] = (454, 1059, 551);
  location[5] = (349, 7, 556);
  location[6] = (362, -551, 384);
  location[7] = (697, 135, 387);
  location[8] = (467, 1189, 224);
  location[8] = (447, 1022, 103);
  location[9] = (624, 511, -30);
  location[10] = (401, 820, -176);
  location[11] = (507, 1549, -189);
  location[12] = (1564, 1749, -300);
  location[13] = (1551, 2459, -312);
  location[14] = (212, 136, 119);
  location[15] = (376, -237, 118);
  location[16] = (376, -237, 377);

  for(i = 0; i < location.size; i++)
    playloopat("amb_alarm_looper", location[i]);
}

snd_start_autofx_audio() {
  wait 1;
  snd_play_auto_fx("fx_com_pipe_steam", "amb_steam_pipe", 0, 0, 0, 0);
  snd_play_auto_fx("fx_com_pipe_fire", "amb_pipe_fire", 0, 0, 0, 0);
  snd_play_auto_fx("fx_com_water_drips", "amb_water_drips", 0, 0, 0, 0);
  snd_play_auto_fx("fx_com_deck_fire_sml", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_com_deck_oil_fire", "amb_oil_fire", 0, 0, 0, 1);
  snd_play_auto_fx("fx_com_water_leak", "amb_water_stream", 0, 0, 0, 1);
  level waittill("argument_done");
  snd_play_auto_fx("fx_com_water_leak", "amb_water_splash_md_metal", 10, 0, 0, 1);
}

interrogation_lightflicker() {
  light = (430, -163, 135);
  power = (311, -132, 133);
  light_ent = spawn(0, light, "script_origin");
  power_ent = spawn(0, power, "script_origin");
  level thread play_generator(power_ent);
  level thread play_flicker(light_ent);
  level thread play_off(light_ent, power_ent);
}

play_flicker(light, power) {
  level endon("INT_out");
  light_id = light playloopsound("amb_interrogation_light", 2);
  setsoundvolume(light_id, 0.8);
  setsoundpitch(light_id, 1);

  while(true) {
    level waittill("INT_flick");
    make_flicker_change(light_id, 1, 1.1, 0.9, 0.5);
    make_flicker_change(light_id, 0.4, 0.8, 0.9, 0.2);
    make_flicker_change(light_id, 0.8, 1, 0.05, 2);
  }
}

play_off(light, power) {
  level waittill("INT_out");
  playsound(0, "amb_interrogation_power_down", power.origin);
  light delete();
  power delete();
}

make_flicker_change(id, volume, pitch, rate, waittime) {
  setsoundvolumerate(id, rate);
  setsoundpitchrate(id, rate);
  setsoundvolume(id, volume);
  setsoundpitch(id, pitch);
  wait(waittime);
}

play_generator(ent) {
  level endon("INT_out");
  ent_id = ent playloopsound("amb_interrogation_power", 2);
  setsoundvolume(ent_id, 1);
  setsoundpitch(ent_id, 1);

  while(true) {
    level waittill("INT_flick");
    playsound(0, "amb_interrogation_power_down", ent.origin);
    setsoundvolumerate(ent_id, 0.2);
    setsoundpitchrate(ent_id, 0.2);
    setsoundvolume(ent_id, 0);
    setsoundpitch(ent_id, 0.5);
    wait 2.5;
    playsound(0, "amb_interrogation_power_up", ent.origin);
    setsoundvolumerate(ent_id, 0.8);
    setsoundpitchrate(ent_id, 0.8);
    setsoundvolume(ent_id, 1);
    setsoundpitch(ent_id, 1);
  }
}

play_ceiling_water_splash() {
  level waittill("cpb");
  playloopat("amb_water_splash_md_metal", (766, 1438, 356));
  playloopat("amb_water_splash_md_metal", (761, 1353, 356));
}

snd_commotion_start() {
  sound_ent_commotion = spawn(0, (317, 318, 344), "script_origin");
  sound_ent_commotion playloopsound("amb_commotion_chat", 2);
  level waittill("snd_argument");
  wait 41;
  sound_ent_commotion stoploopsound(8);
  playsound(0, "amb_commotion_argument", sound_ent_commotion.origin);
  snd_set_snapshot("default");
  level waittill("argument_done");
  sound_ent_commotion playloopsound("amb_ship_alarm", 0.1);
}

sndmaskoff() {
  level waittill("sndMaskOff");
  deactivateambientroom(0, "gas_mask", 80);
}

activate_f35_room() {
  waitforclient(0);
  level waittill("sndF38Snapshot_on");
  activateambientroom(0, "f35_int", 90);
  level thread deactivate_f35_room();
}

deactivate_f35_room() {
  level waittill("sndF38Snapshot_off");
  deactivateambientroom(0, "f35_int", 90);
}

nuke_loop() {
  playloopat("amb_nuke_hum", (1312, 2136, -343));
}

snd_create_randoms() {
  mintime = 6;
  maxtime = 46;
  create_sound_random((2345, -817, -364), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2490, -411, -362), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2618, -558, -363), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2802, -753, -365), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2873, -675, -358), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((1738, 151, -265), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((1666, 355, -223), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2521, 1287, -258), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2209, 1424, -257), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((1881, 2641, -365), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((344, 1054, -244), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((248, -639, 347), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((460, -638, 340), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((710, -602, 337), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((749, -541, 482), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((536, -634, 485), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((370, -638, 482), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((176, -644, 482), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((13, -546, 479), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((-90, 204, 556), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((223, -346, 486), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((425, -349, 485), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((218, -190, 485), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((218, -190, 485), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((260, 86, 480), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((540, -178, 484), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((464, 102, 483), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((657, 97, 483), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((655, 292, 487), "vox_blackout_radio", mintime, maxtime);
  create_sound_random((2147, -790, -368), "vox_blackout_radio", mintime, maxtime);
}

computer_loops() {
  mintime = 6;
  maxtime = 46;
  playloopat("amb_scanner", (207, 32, 60));
  playloopat("amb_touch_desk", (108, 66, 56));
  playloopat("amb_retina_scanner", (330, 14, 81));
  playloopat("amb_retina_scanner", (331, 14, 325));
  playloopat("amb_touch_desk", (105, 88, 297));
  playloopat("amb_power_box", (565, 752, 318));
  playloopat("amb_power_box", (812, 1538, 350));
  playloopat("amb_power_box", (331, 1423, 508));
  playloopat("amb_power_box", (684, 1079, 510));
  playloopat("amb_power_box", (532, 979, 475));
  playloopat("amb_comp_screen", (675, 989, 476));
  playloopat("amb_touch_desk", (290, 938, 473));
  playloopat("amb_touch_desk", (187, 932, 475));
  playloopat("amb_comp_screen", (34, 935, 477));
  playloopat("amb_power_box", (248, 791, 514));
  playloopat("amb_power_box", (638, 753, 507));
  playloopat("amb_tech_display", (650, 390, 482));
  playloopat("amb_radio", (655, 292, 487));
  playloopat("amb_tech_display", (657, 204, 485));
  playloopat("amb_radio", (657, 97, 483));
  playloopat("amb_power_box", (617, 27, 495));
  playloopat("amb_radio", (464, 102, 483));
  playloopat("amb_tech_display", (530, 29, 481));
  playloopat("amb_radio", (540, -178, 484));
  playloopat("amb_tech_display", (480, -216, 483));
  playloopat("amb_radio", (260, 86, 480));
  playloopat("amb_tech_display", (212, -1, 484));
  playloopat("amb_radio", (218, -190, 485));
  playloopat("amb_tech_display", (297, -218, 477));
  playloopat("amb_radio", (218, -190, 485));
  playloopat("amb_tech_display", (297, -218, 477));
  playloopat("amb_scanner", (569, -332, 483));
  playloopat("amb_tech_display", (528, -339, 482));
  playloopat("amb_radio", (425, -349, 485));
  playloopat("amb_tech_display", (334, -352, 483));
  playloopat("amb_radio", (223, -346, 486));
  playloopat("amb_tech_display", (165, 202, 500));
  playloopat("amb_tech_display", (-64, 604, 531));
  playloopat("amb_radio", (-90, 204, 556));
  playloopat("amb_radio", (13, -546, 479));
  playloopat("amb_tech_display", (76, -625, 480));
  playloopat("amb_radio", (176, -644, 482));
  playloopat("amb_tech_display", (271, -643, 479));
  playloopat("amb_radio", (370, -638, 482));
  playloopat("amb_tech_display", (435, -590, 480));
  playloopat("amb_radio", (536, -634, 485));
  playloopat("amb_tech_display", (694, -614, 482));
  playloopat("amb_radio", (749, -541, 482));
  playloopat("amb_tech_display", (468, -412, 482));
  playloopat("amb_radio", (710, -602, 337));
  playloopat("amb_tech_display", (610, -649, 346));
  playloopat("amb_radio", (460, -638, 340));
  playloopat("amb_tech_display", (346, -640, 338));
  playloopat("amb_radio", (248, -639, 347));
  playloopat("amb_tech_display", (62, -588, 343));
  playloopat("amb_power_box", (445, 1049, 197));
  playloopat("amb_power_box", (462, 1388, 210));
  playloopat("amb_power_box", (547, 1271, 53));
  playloopat("amb_power_box", (142, 677, -225));
  playloopat("amb_radio", (333, 615, -226));
  playloopat("amb_tech_display", (433, 612, -234));
  playloopat("amb_tech_display", (390, 822, -239));
  playloopat("amb_comp_screen", (287, 991, -241));
  playloopat("amb_radio", (344, 1054, -244));
  playloopat("amb_tech_display", (303, 1312, -234));
  playloopat("amb_power_box", (456, 1503, -342));
  playloopat("amb_power_box", (606, 1499, -343));
  playloopat("amb_tech_display", (853, 1861, -363));
  playloopat("amb_tech_display", (853, 1861, -363));
  playloopat("amb_power_box", (763, 2445, -343));
  playloopat("amb_power_box", (839, 2186, -338));
  playloopat("amb_power_box", (986, 2022, -339));
  playloopat("amb_power_box", (566, 2086, -354));
  playloopat("amb_power_box", (1239, 1724, -356));
  playloopat("amb_power_box", (1943, 2272, -361));
  playloopat("amb_radio", (1881, 2641, -365));
  playloopat("amb_tech_display", (1951, 2594, -363));
  playloopat("amb_radio", (1958, 2490, -367));
  playloopat("amb_tech_display", (1884, 2457, -371));
  playloopat("amb_power_box", (1576, 1675, -486));
  playloopat("amb_power_box", (1056, 1929, -475));
  playloopat("amb_power_box", (1047, 2208, -475));
  playloopat("amb_power_box", (552, 2591, -487));
  playloopat("amb_power_box", (773, 2303, -477));
  playloopat("amb_power_box", (1649, 1406, -246));
  playloopat("amb_power_box", (1800, 1228, -251));
  playloopat("amb_power_box", (2195, 1280, -238));
  playloopat("amb_power_box", (2104, 1143, -252));
  playloopat("amb_power_box", (2296, 1142, -246));
  playloopat("amb_power_box", (2515, 1165, -250));
  playloopat("amb_radio", (2209, 1424, -257));
  playloopat("amb_tech_display", (2326, 1448, -264));
  playloopat("amb_radio", (2521, 1287, -258));
  playloopat("amb_scanner", (2466, 1435, -265));
  playloopat("amb_touch_desk", (2495, 1420, -261));
  playloopat("amb_server_hum", (2503, 433, -295));
  playloopat("amb_server_hum", (2488, 78, -292));
  playloopat("amb_server_hum", (2297, 437, -293));
  playloopat("amb_server_hum", (2321, 88, -286));
  playloopat("amb_big_comp", (2010, -655, -362));
  playloopat("amb_radar_screen_mf1", (2558, 263, -269));
  playloopat("amb_power_box", (2190, 628, -254));
  playloopat("amb_power_box", (2109, 50, -255));
  playloopat("amb_touch_desk", (2135, -95, -259));
  playloopat("amb_touch_desk", (2786, -12, -249));
  playloopat("amb_touch_desk", (2646, 609, -261));
  playloopat("amb_power_box", (1057, 346, -369));
  playloopat("amb_radio", (1666, 355, -223));
  playloopat("amb_tech_display", (1766, 354, -217));
  playloopat("amb_tech_display", (1904, 365, -221));
  playloopat("amb_radio", (1738, 151, -265));
  playloopat("amb_radio", (1963, 153, -268));
  playloopat("amb_tech_display", (2017, 219, -265));
  playloopat("amb_tech_display", (2628, -357, -263));
  playloopat("amb_radio", (2873, -675, -358));
  playloopat("amb_tech_display", (2968, -673, -358));
  playloopat("amb_radio", (2802, -753, -365));
  playloopat("amb_tech_display", (2754, -813, -367));
  playloopat("amb_radio", (2618, -558, -363));
  playloopat("amb_radio", (2490, -411, -362));
  playloopat("amb_tech_display", (2387, -669, -364));
  playloopat("amb_radio", (2345, -817, -364));
  playloopat("amb_tech_display", (2244, -822, -365));
  playloopat("amb_radio", (2147, -790, -368));
  playloopat("amb_tech_display", (2086, -718, -371));
}

sound_fade_snapshot() {
  level waittill("fade");
  snd_set_snapshot("cmn_fade_in");
  wait 2;
  snd_set_snapshot("default");
}

sound_fade_out_snapshot() {
  level waittill("fade_out");
  snd_set_snapshot("cmn_fade_out");
}

menendez_mask_on() {
  level waittill("audio_mask");
  waitforclient(0);
  activateambientroom(0, "gas_mask", 80);
}

snapshot_check() {
  level endon("intr_on");
  wait 3;
  snd_set_snapshot("default");
}

alarm_loop() {
  level waittill("alarm_start");
  playloopat("amb_alarm_ext", (1666, 120, 586));
  playloopat("amb_alarm_ext", (-818, 571, 602));
  playloopat("amb_ship_alarm", (2558, -429, -313));
  playloopat("amb_ship_alarm", (1830, -405, -369));
  level waittill("loud_alarm_off");
  stoploopat("amb_alarm_ext", (1666, 120, 586));
  level waittill("loud_alarm_on");
  playloopat("amb_alarm_ext", (1666, 120, 586));
}

time_passes() {
  level waittill("knc_on");
  level waittill("knc_on_snd");
}

surgury_sfx() {
  playloopat("fly_hallway_surgury", (449, 527, 304));
}

setsnapdefault() {
  snd_set_snapshot("default");
}

setmentranssnap() {
  snd_set_snapshot("spl_blackout_menendez_trans");
}

set_ending_vtol_snap() {
  wait 8;
  snd_set_snapshot("spl_blackout_vtol_end");
}