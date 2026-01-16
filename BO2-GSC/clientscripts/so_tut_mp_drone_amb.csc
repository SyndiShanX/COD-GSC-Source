/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\so_tut_mp_drone_amb.csc
*************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("drone_outdoor", 1);
  setambientroomtone("drone_outdoor", "amb_wind_extreior_2d", 0.55, 1);
  setambientroomreverb("drone_outdoor", "drone_outdoor", 1, 1);
  setambientroomcontext("drone_outdoor", "ringoff_plr", "outdoor");
  declareambientroom("drone_partial_room");
  setambientroomreverb("drone_partial_room", "drone_partial_room", 1, 1);
  setambientroomcontext("drone_partial_room", "ringoff_plr", "outdoor");
  declareambientroom("drone_small_partial");
  setambientroomreverb("drone_small_partial", "drone_small_partial", 1, 1);
  setambientroomcontext("drone_small_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_small_room");
  setambientroomreverb("drone_small_room", "drone_small_room", 1, 1);
  setambientroomcontext("drone_small_room", "ringoff_plr", "indoor");
  declareambientroom("drone_entry_room");
  setambientroomreverb("drone_entry_room", "drone_entry_room", 1, 1);
  setambientroomcontext("drone_entry_room", "ringoff_plr", "indoor");
  declareambientroom("drone_medium_room");
  setambientroomreverb("drone_medium_room", "drone_medium_room", 1, 1);
  setambientroomcontext("drone_medium_room", "ringoff_plr", "indoor");
  declareambientroom("drone_large_room");
  setambientroomreverb("drone_large_room", "drone_large_room", 1, 1);
  setambientroomcontext("drone_large_room", "ringoff_plr", "indoor");
  declareambientroom("drone_open_room");
  setambientroomreverb("drone_open_room", "drone_open_room", 1, 1);
  setambientroomcontext("drone_open_room", "ringoff_plr", "outdoor");
  declareambientroom("drone_dense_hallway");
  setambientroomreverb("drone_dense_hallway", "drone_dense_hallway", 1, 1);
  setambientroomcontext("drone_dense_hallway", "ringoff_plr", "indoor");
  declareambientroom("drone_indoor_hallway");
  setambientroomreverb("drone_indoor_hallway", "drone_indoor_hallway", 1, 1);
  setambientroomcontext("drone_indoor_hallway", "ringoff_plr", "indoor");
  declareambientroom("drone_indoor_hallway_partial");
  setambientroomreverb("drone_indoor_hallway_partial", "drone_indoor_hallway", 1, 1);
  setambientroomcontext("drone_indoor_hallway_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_outdoor_hallway");
  setambientroomreverb("drone_outdoor_hallway", "drone_outdoor_hallway", 1, 1);
  setambientroomcontext("drone_outdoor_hallway", "ringoff_plr", "outdoor");
  declareambientroom("drone_stone_room");
  setambientroomreverb("drone_stone_room", "drone_stone_room", 1, 1);
  setambientroomcontext("drone_stone_room", "ringoff_plr", "indoor");
  declareambientroom("drone_container");
  setambientroomreverb("drone_container", "drone_container", 1, 1);
  setambientroomcontext("drone_container", "ringoff_plr", "indoor");
  declareambientroom("drone_small_helipad_room");
  setambientroomreverb("drone_small_helipad_room", "drone_small_room", 1, 1);
  setambientroomcontext("drone_small_helipad_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_helipad_room_partial");
  setambientroomreverb("drone_small_helipad_room_partial", "drone_small_room", 1, 1);
  setambientroomcontext("drone_small_helipad_room_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_small_under_helipad_room");
  setambientroomreverb("drone_small_under_helipad_room", "drone_cave", 1, 1);
  setambientroomcontext("drone_small_under_helipad_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_carpet_room");
  setambientroomreverb("drone_small_carpet_room", "drone_carpet", 1, 1);
  setambientroomcontext("drone_small_carpet_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_carpet_partial_room");
  setambientroomreverb("drone_small_carpet_partial_room", "drone_carpet", 1, 1);
  setambientroomcontext("drone_small_carpet_partial_room", "ringoff_plr", "outdoor");
  declareambientroom("drone_large_hanger_room");
  setambientroomreverb("drone_large_hanger_room", "drone_hangar", 1, 1);
  setambientroomcontext("drone_large_hanger_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_comp_room");
  setambientroomreverb("drone_small_comp_room", "drone_small_comp", 1, 1);
  setambientroomcontext("drone_small_comp_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_comp_room_partial");
  setambientroomreverb("drone_small_comp_room_partial", "drone_small_comp", 1, 1);
  setambientroomcontext("drone_small_comp_room_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_factory");
  setambientroomreverb("drone_factory", "drone_factory", 1, 1);
  setambientroomcontext("drone_factory", "ringoff_plr", "indoor");
  declareambientroom("drone_factory_partial");
  setambientroomreverb("drone_factory_partial", "drone_factory", 1, 1);
  setambientroomcontext("drone_factory_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_large_machine_room");
  setambientroomreverb("drone_large_machine_room", "drone_factory", 1, 1);
  setambientroomcontext("drone_large_machine_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_brick_room");
  setambientroomreverb("drone_small_brick_room", "drone_stone_room", 1, 1);
  setambientroomcontext("drone_small_brick_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_tile_room");
  setambientroomreverb("drone_small_tile_room", "drone_tile_room", 1, 1);
  setambientroomcontext("drone_small_tile_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_marble_room");
  setambientroomreverb("drone_small_marble_room", "drone_marble_room", 1, 1);
  setambientroomcontext("drone_small_marble_room", "ringoff_plr", "indoor");
  declareambientroom("drone_small_marble_room_partial");
  setambientroomreverb("drone_small_marble_room_partial", "drone_marble_room", 1, 1);
  setambientroomcontext("drone_small_marble_room_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_hangar_hall");
  setambientroomreverb("drone_hangar_hall", "drone_hangar_hall", 1, 1);
  setambientroomcontext("drone_hangar_hall", "ringoff_plr", "indoor");
  declareambientroom("drone_hangar_hall_partial");
  setambientroomreverb("drone_hangar_hall_partial", "drone_hangar_hall", 1, 1);
  setambientroomcontext("drone_hangar_hall_partial", "ringoff_plr", "outdoor");
  declareambientroom("drone_stairwell");
  setambientroomreverb("drone_stairwell", "drone_stairwell", 1, 1);
  setambientroomcontext("drone_stairwell", "ringoff_plr", "indoor");
  thread snd_start_autofdrone_audio();
  thread snd_play_loopers();
  thread playforcefieldloops();
  thread rts_endmenu();
  declaremusicstate("DRONE_ACTION");
  musicaliasloop("mus_rts_action", 0, 3.5);
  declaremusicstate("RTS_ACTION_END");
  musicaliasloop("mus_rts_action", 0, 3.5);
  declaremusicstate("DOCKSIDE_ACTION_NM");
  musicaliasloop("null", 0, 0);
}

rts_endmenu() {
  level waittill("sndEndMenu");
  snd_set_snapshot("spl_rts_endmenu");
}

playforcefieldloops() {
  playloopat("evt_forcefield_loop", (-1862, -1010, 143));
  playloopat("evt_forcefield_loop", (-1171, -688, 322));
  playloopat("evt_forcefield_loop", (-461, 102, 339));
  playloopat("evt_forcefield_loop", (-463, 297, 344));
  playloopat("evt_forcefield_loop", (-396, 801, 327));
  playloopat("evt_forcefield_loop", (-554, 1924, 192));
  level waittill("turn_off_forcefields");
  stoploopat("evt_forcefield_loop", (-1862, -1010, 143), "evt_forcefield_off");
  stoploopat("evt_forcefield_loop", (-1171, -688, 322), "evt_forcefield_off");
  stoploopat("evt_forcefield_loop", (-461, 102, 339), "evt_forcefield_off");
  stoploopat("evt_forcefield_loop", (-463, 297, 344), "evt_forcefield_off");
  stoploopat("evt_forcefield_loop", (-396, 801, 327), "evt_forcefield_off");
  stoploopat("evt_forcefield_loop", (-554, 1924, 192), "evt_forcefield_off");
}

snd_play_loopers() {
  playloopat("amb_factory_fans", (-1872, -1079, 355));
  playloopat("amb_floor_grate", (-130, 268, 105));
  playloopat("amb_cave_drip", (-72, -1215, -21));
  playloopat("amb_cave_drip", (-93, -1148, -28));
  playloopat("amb_cave_drip", (-59, -1005, -33));
  playloopat("amb_cave_drip", (179, -831, -31));
  playloopat("amb_exahust", (-181, 1236, 239));
  playloopat("amb_exahust", (-181, 1394, 239));
  playloopat("amb_scanner_idle", (-551, -718, 62));
  playloopat("amb_scanner_idle", (-770, -712, 68));
}

snd_start_autofdrone_audio() {
  snd_play_auto_fx("fx_mp_drone_interior_steam", "amb_ceilng_fog", 0, 0, 0, 0);
  snd_play_auto_fx("fx_ceiling_circle_light_glare", "amb_hall_ceiling_lights", 0, 0, 0, 0);
  snd_play_auto_fx("fx_drone_red_ring_console_runner", "amb_screens_a", 0, 0, 0, 0);
  snd_play_auto_fx("fx_drone_rectangle_light_blue", "amb_blue_underground_lights", 0, 0, 0, 0);
  snd_play_auto_fx("fx_wall_water_ground", "amb_gutter_flow", 0, 0, 0, 1);
  snd_play_auto_fx("fx_mp_steam_pipe_md", "amb_steam_hiss", 0, 0, 0, 0);
  snd_play_auto_fx("fx_mp_water_drip_light_long", "amb_water_drip", 0, 0, 0, 1);
  snd_play_auto_fx("fx_mp_water_drip_light_shrt", "amb_water_drip", 0, 0, 0, 1);
}

scanner_alert() {
  scannertrig = getent(0, "scanner_alert", "targetname");

  if(isDefined(scannertrig)) {
    for(;;) {
      scannertrig waittill("trigger", trigplayer);
      scannertrig thread trigger_thread(trigplayer, ::trig_enter_alarm, ::trig_leave_alarm);
      wait 0.25;
    }
  }
}

trig_enter_alarm(trigplayer) {
  self playsound(0, "amb_scanner_detect");
  wait 0.25;
  playsound(0, "amb_scanner_alarm", (-460, -809, -438));
}

trig_leave_alarm(trigplayer) {
}

setpoialarms(set, location) {
  origin = undefined;

  switch (location) {
    case 1:
      origin = (-211, -939, 357);
      break;
    case 2:
      origin = (1207, 848, 380);
      break;
    case 3:
      origin = (-2367, -1868, 281);
      break;
  }

  if(!isDefined(origin)) {
    return;
  }
  if(set == 1)
    playloopat("amb_under_attack_alarm", origin);
  else
    stoploopat("amb_under_attack_alarm", origin);
}

setfinalalarms() {
  level notify("turn_off_forcefields");
  playloopat("amb_barrier_down_alarm_ext", (-1876, -1096, 367));
  playloopat("amb_barrier_down_alarm_ext", (-361, -674, 416));
  playloopat("amb_barrier_down_alarm_ext", (-54, 840, 402));
  playloopat("amb_barrier_down_alarm_ext", (-468, 1977, 327));
  playloopat("amb_barrier_down_alarm_int", (-896, 1424, 255));
  playloopat("amb_barrier_down_alarm_int", (-1456, 787, 181));
  playloopat("amb_barrier_down_alarm_int", (-1456, -417, 187));
  playloopat("amb_barrier_down_alarm_int", (-823, -447, 347));
  playloopat("amb_barrier_down_alarm_int", (-748, 232, 365));
  playloopat("amb_barrier_down_alarm_int", (-1043, 893, 363));
}