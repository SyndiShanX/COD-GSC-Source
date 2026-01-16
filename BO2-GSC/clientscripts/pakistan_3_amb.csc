/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_3_amb.csc
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
  setambientroomreverb("pak_above_water_room_sm", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_above_water_room_sm", "ringoff_plr", "indoor");
  declareambientpackage("pak_above_water_room_sm");
  declareambientroom("pak_above_water_room_lrg");
  setambientroomreverb("pak_above_water_room_lrg", "pakistan_largeroom", 1, 1);
  setambientroomcontext("pak_above_water_room_lrg", "ringoff_plr", "indoor");
  declareambientpackage("pak_above_water_room_lrg");
  declaremusicstate("PAKISTAN_CHASE");
  musicaliasloop("mus_pakistan_chase", 0, 10);
  declaremusicstate("PAKISTAN_BURNED");
  musicaliasloop("mus_harperburned_stg", 0, 2);
  declaremusicstate("PAKISTAN_STANDOFF");
  musicaliasloop("mus_standoff_loop", 2, 4);
  musicstinger("mus_standoff", 0);
  declaremusicstate("PAKISTAN_PLAYER_AT_STANDOFF");
  musicaliasloop("null", 0, 2);
  thread snd_play_loopers();
  thread snd_start_autofx_audio();
  level thread mill_scanner();
  level thread snd_start_add_exploder_alias();
  level thread end_level_snapshot();
}

snd_play_loopers() {
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (36634, 29276, 900));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (36096, 29070, 900));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (35468, 29062, 900));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (37007, 29760, 900));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (36165, 29752, 890));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (36074, 30073, 1089));
  clientscripts\_audio::playloopat("amb_rain_on_metal_sheet", (35181, 29699, 825));
  clientscripts\_audio::playloopat("amb_rain_on_concrete", (35972, 30080, 750));
  clientscripts\_audio::playloopat("amb_rain_on_concrete", (35789, 30363, 229));
  clientscripts\_audio::playloopat("amb_rain_on_concrete", (35966, 30578, 198));
  clientscripts\_audio::playloopat("amb_rain_on_concrete", (36458, 30551, 222));
  clientscripts\_audio::playloopat("veh_vtol_idle_fake", (36468, 30940, 390));
  clientscripts\_audio::playloopat("amb_smoke_signal", (36239, 30135, 147));
}

snd_start_add_exploder_alias() {
  wait 1;
  snd_add_exploder_alias(10830, "evt_highway_sign_01");
  snd_add_exploder_alias(10831, "evt_highway_sign_splash");
  snd_add_exploder_alias(10832, "evt_highway_sign_04");
  snd_add_exploder_alias(10833, "evt_highway_sign_02");
  snd_add_exploder_alias(10834, "evt_highway_sign_splash");
  snd_add_exploder_alias(10835, "evt_highway_sign_03");
  snd_add_exploder_alias(10836, "evt_highway_sign_05");
  snd_add_exploder_alias(770, "exp_chain_explo_1");
  snd_add_exploder_alias(771, "exp_chain_explo_4");
  snd_add_exploder_alias(772, "exp_chain_explo_5");
  snd_add_exploder_alias(773, "exp_chain_explo_2");
  snd_add_exploder_alias(774, "exp_chain_explo_6");
  snd_add_exploder_alias(775, "exp_chain_explo_3");
  snd_add_exploder_alias(776, "exp_chain_explo_7");
  snd_add_exploder_alias(777, "exp_chain_explo_2");
  snd_add_exploder_alias(778, "exp_chain_explo_8");
  snd_add_exploder_alias(779, "exp_chain_pipe_2");
  snd_add_exploder_alias(780, "exp_chain_pipe");
  snd_add_exploder_alias(785, "exp_chain_explo_1");
  snd_add_exploder_alias(786, "exp_chain_explo_2");
  snd_add_exploder_alias(787, "exp_chain_explo_6");
  snd_add_exploder_alias(788, "exp_chain_explo_2");
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_pak_light_road_flare", "amb_road_flare", 0, 0, 0, 1);
  snd_play_auto_fx("fx_pak_light_road_flare_hero", "amb_road_flare", 0, 0, 0, 1);
  snd_play_auto_fx("fx_pak_fire_building_md", "amb_fire_large", 0, 0, 0, 1);
  snd_play_auto_fx("fx_pak_fire_edge_windblown_md_dist", "amb_fire_med", 0, 0, 0, 1);
}

menendezstartrecording(localclientnum, set, newent) {
  if(set) {
    level.surv_on = 1;
    player = getlocalplayers()[0];
    player thread menendezchangedvar(self);
    level thread waitfor_stoploop();
    level thread waitfor_startloop();
  } else
    level notify("surv_END");
}

menendezchangedvar(menendez) {
  level endon("surv_END");
  min_num = 0.979;
  max_num = 0.9999;
  min_set = -1;
  max_set = -0.1;
  ent = spawn(0, (0, 0, 0), "script_origin");
  loop_id = ent playloopsound("evt_surv_talk_test_loop", 1);
  setsoundvolume(loop_id, 1);
  level thread menendezendrecording(ent);

  while(true) {
    num = self get_view_num(self get_eye(), self getplayerangles(), menendez.origin + vectorscale((0, 0, 1), 45.0));
    set = abs(scale_speed(min_num, max_num, min_set, max_set, num));
    level set_dvar_and_volume(loop_id, set);
    wait 0.05;
  }
}

set_dvar_and_volume(loop_id, set) {
  if(set == 0 || !level.surv_on)
    setdvarfloat("snd_futz", 1);
  else
    setdvarfloat("snd_futz", set);
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
  }
}

waitfor_startloop() {
  level endon("surv_END");

  while(true) {
    level waittill("surv_ON");
    level.surv_on = 1;
  }
}

menendezendrecording(ent) {
  level waittill("surv_END");
  setdvarfloat("snd_futz", 0);
  ent stoploopsound(1);
  wait 1;
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

end_level_snapshot() {
  level waittill("end_lvl");
  wait 4;
  snd_set_snapshot("cmn_vehicle_int_off");
}