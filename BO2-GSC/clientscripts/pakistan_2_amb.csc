/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_2_amb.csc
********************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("pakistan_outdoor", 1);
  setambientroomtone("pakistan_outdoor", "blk_amb_rain", 0.5, 0.5);
  setambientroomreverb("pakistan_outdoor", "pakistan_outdoor", 1, 1);
  setambientroomcontext("pakistan_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("pakistan_outdoor");
  declareambientroom("pak_control_room");
  setambientroomreverb("pak_control_room", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_control_room", "ringoff_plr", "indoor");
  declareambientpackage("pak_control_room");
  declareambientroom("pak_brick_open");
  setambientroomreverb("pak_brick_open", "pakistan_stoneroom", 1, 1);
  setambientroomcontext("pak_brick_open", "ringoff_plr", "indoor");
  declareambientpackage("pak_brick_open");
  declareambientroom("pak_carpet_train_room");
  setambientroomreverb("pak_carpet_train_room", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_carpet_train_room", "ringoff_plr", "indoor");
  declareambientpackage("pak_carpet_train_room");
  declareambientroom("pak_wood_train_room");
  setambientroomreverb("pak_wood_train_room", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_wood_train_room", "ringoff_plr", "indoor");
  declareambientpackage("pak_wood_train_room");
  declareambientroom("pak_train_warehouse");
  setambientroomreverb("pak_train_warehouse", "pakistan_largeroom", 1, 1);
  setambientroomcontext("pak_train_warehouse", "ringoff_plr", "indoor");
  declareambientpackage("pak_train_warehouse");
  declareambientroom("pak_above_water_room_sm");
  setambientroomtone("pak_above_water_room_sm", "amb_under_grate_rm_tone", 0.5, 0.5);
  setambientroomreverb("pak_above_water_room_sm", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_above_water_room_sm", "ringoff_plr", "indoor");
  declareambientpackage("pak_above_water_room_sm");
  declareambientroom("pak_above_water_room_lrg");
  setambientroomreverb("pak_above_water_room_lrg", "pakistan_largeroom", 1, 1);
  setambientroomcontext("pak_above_water_room_lrg", "ringoff_plr", "indoor");
  declareambientpackage("pak_above_water_room_lrg");
  declaremusicstate("PAK_2_INTRO");
  musicaliasloop("mus_intro_loop", 0, 6);
  declaremusicstate("PAK_ANTHEM");
  musicaliasloop("mus_anthem_loop", 0, 6);
  declaremusicstate("PAK_ANTHEM_DEFALCO");
  musicaliasloop("mus_anthem_defalco", 3, 7);
  declaremusicstate("PAK_ANTHEM_HOT");
  musicaliasloop("mus_anthem_beats_loop", 4, 2);
  declaremusicstate("PAK_DROP_FROM_VAN");
  musicalias("mus_pre_van_oneshot", 2, 0, 3);
  musicaliasloop("mus_pre_van_loop", 1, 0);
  declaremusicstate("PAK_VAN_KILL");
  musicalias("mus_van_kill_stg", 4, 0, 7);
  declaremusicstate("PAK_POST_VAN");
  musicaliasloop("mus_post_van", 1, 8);
  declaremusicstate("PAK_INT_ESCAPE_REFERENCE");
  musicaliasloop("mus_post_menendez_reso", 4, 6);
  declaremusicstate("PAK_MILLIBAR");
  musicalias("mus_surveillance_stg", 0, 0);
  declaremusicstate("PAK_GRENADES_DROP");
  musicalias("mus_grenade_drop", 4, 0);
  declaremusicstate("PAK_ESCAPE_ANTHEM");
  musicaliasloop("mus_pre_claw", 4, 0.5);
  declaremusicstate("PAK_CLAWS");
  musicaliasloop("mus_claw_battles", 0, 2);
  declaremusicstate("PAK_POST_CLAW");
  musicaliasloop("null", 0, 1);
  declaremusicstate("PAKISTAN_CHASE");
  musicaliasloop("mus_pakistan_chase", 0, 3.5);
  level thread mill_scanner();
  level thread snd_play_gaz_idle();
  level thread anthem_clocktower_toll();
  level thread anthem_randoms();
  level thread waitfor_underwater();
  level thread drone_crane();
  level thread surverlance_device();
  level thread start_ambient_baseloop();
  level thread play_rain_player_emitters();
  level thread underwater_explo();
  setsoundcontext("grass", "no_grass");
}

play_rain_player_emitters() {
  clientscripts\_audio::playloopat("amb_rain_on_player", (-17761, 35243, 444));
}

surverlance_device() {
  snd_set_snapshot("spl_pakistan_2_bfutz");
}

start_ambient_baseloop() {
  clientscripts\_audio::playloopat("amb_base_loop", (-19217, 39530, 708));
}

waitfor_underwater() {
  player = getlocalplayers()[0];

  while(true) {
    player waittill("aS_underwater");
    setsoundcontext("grass", "in_grass");
    player waittill("aS_surface");
    setsoundcontext("grass", "no_grass");
  }
}

anthem_clocktower_toll() {
  level waittill("clck");
  wait 10;
  playsound(0, "amb_anthem_clocktower_bell_start", (-18814, 41708, 1394));
  wait 14;

  for(i = 0; i < 6; i++) {
    playsound(0, "amb_anthem_clocktower_bell", (-18814, 41708, 1394));
    wait 2;
  }
}

anthem_randoms() {
  level thread anthem_random_pa();
  level thread anthem_random_yells();
}

anthem_random_pa() {
  level endon("train");
  origin = (-19695, 39971, 789);

  while(true) {
    wait(randomintrange(20, 37));
    playsound(0, "amb_anthem_random_pa", origin);
  }
}

anthem_random_yells() {
  level endon("train");
  origin = [];
  origin[0] = (-18600, 39653, 631);
  origin[1] = (-18916, 39573, 604);
  origin[2] = (-18725, 40139, 578);
  origin[3] = (-19133, 41062, 593);
  origin[4] = (-19340, 40941, 611);
  origin[5] = (-19725, 40490, 568);
  origin[6] = (-19737, 40258, 592);
  origin[7] = (-19335, 40126, 593);

  while(true) {
    wait(randomintrange(7, 16));

    for(i = 0; i < randomintrange(2, 5); i++) {
      playsound(0, "amb_anthem_yell_randoms", origin[i]);
      wait(randomfloatrange(1, 3));
    }

    array_randomize(origin);
  }
}

snd_play_loopers() {
  wait 1;
  clientscripts\_audio::playloopat("amb_rain_splash", (-18049, 37588, 916));
  clientscripts\_audio::playloopat("amb_rain_splash", (-18341, 37576, 925));
  clientscripts\_audio::playloopat("amb_rain_splash", (-18846, 37580, 913));
  clientscripts\_audio::playloopat("amb_rain_splash", (-17542, 41056, 984));
  clientscripts\_audio::playloopat("amb_rain_splash", (-17526, 40803, 979));
  clientscripts\_audio::playloopat("amb_rain_roof", (-17687, 40865, 963));
  clientscripts\_audio::playloopat("amb_rain_roof", (-17799, 40763, 941));
  clientscripts\_audio::playloopat("amb_rain_roof", (-18019, 40694, 934));
}

snd_play_gaz_idle() {
  playloopat("evt_truck_idle", (-17935, 35400, 487));
  level waittill("sndShutOffGaz");
  stoploopat("evt_truck_idle", (-17935, 35400, 487), "evt_truck_shutoff");
}

snd_start_autofx_audio() {
}

underwater_explo() {
  snd_add_exploder_alias(700, "evt_anim_ugrnd_grenades_exp");
}

menendezstartrecording(localclientnum, set, newent) {
  if(set) {
    level.surv_on = 1;
    level notify("surv_START");
    player = getlocalplayers()[0];
    player thread menendezchangedvar(self);
    level thread waitfor_stoploop();
    level thread waitfor_startloop();
    level thread waitfor_failsafe();
  } else {
    level notify("surv_END");
    setdvarfloat("snd_futz", 1);

    if(isDefined(level.survsndent))
      level.survsndent delete();
  }
}

waitfor_failsafe() {
  level endon("surv_START");
  level waittill("surv_END");
  setdvarfloat("snd_futz", 1);

  if(isDefined(level.survsndent))
    level.survsndent delete();
}

menendezchangedvar(menendez) {
  level endon("surv_END");
  min_num = 0.979;
  max_num = 0.9999;
  min_set = -1;
  max_set = -0.1;

  if(!isDefined(level.survsndent))
    level.survsndent = spawn(0, (0, 0, 0), "script_origin");

  loop_id = level.survsndent playloopsound("evt_static_loop", 1);
  setsoundvolume(loop_id, 0);

  while(true) {
    if(isDefined(menendez)) {
      num = self get_view_num(self get_eye(), self getplayerangles(), menendez.origin + vectorscale((0, 0, 1), 45.0));
      set = abs(scale_speed(min_num, max_num, min_set, max_set, num));
      level set_dvar_and_volume(loop_id, set);
    }

    wait 0.05;
  }
}

set_dvar_and_volume(loop_id, set) {
  if(set == 0 || !level.surv_on) {
    setdvarfloat("snd_futz", 1);
    setsoundvolume(loop_id, 1);
  } else {
    setdvarfloat("snd_futz", set);
    setsoundvolume(loop_id, set);
  }
}

get_view_num(start_origin, start_angles, end_origin) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglestoforward(start_angles);
  dot = vectordot(forward, normal);
  return dot;
}

waitfor_stoploop() {
  level endon("surv_END");

  while(true) {
    level waittill("surv_OFF");
    level.surv_on = 0;
    snd_set_snapshot("spl_pakistan_2_bfutz");
  }
}

waitfor_startloop() {
  level endon("surv_END");
  snd_set_snapshot("default");

  while(true) {
    level waittill("surv_ON");
    level.surv_on = 1;
    snd_set_snapshot("default");
  }
}

menendezendrecording(ent) {
  level waittill("surv_END");
  setdvarfloat("snd_futz", 1);
  ent delete();
}

mill_scanner() {
  while(true) {
    level waittill("millibar_on");
    scanent = spawn(0, (0, 0, 0), "script_origin");
    scanent playloopsound("evt_mill_scan");
    playsound(0, "evt_mill_scan_on", (0, 0, 0));
    level waittill("millibar_off");
    scanent stoploopsound(0.5);
    playsound(0, "evt_mill_scan_off", (0, 0, 0));
    wait 1;
    scanent delete();
  }
}

drone_crane() {
  level waittill("drone_sfx");
  wait 1.2;
  playsound(0, "evt_drone_crane", (0, 0, 0));
}