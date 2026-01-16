/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_2_amb.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  snd_set_snapshot("cmn_fade_in");
  declareambientroom("outdoor");
  setambientroomtone("outdoor", "blk_la_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("outdoor", "la_2_outdoor", 1, 1);
  setambientroomsnapshot("outdoor", "veh_f35_off");
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declareambientroom("indoor");
  setambientroomtone("indoor", "blk_la_indoor_bg", 0.5, 0.5);
  setambientroomreverb("indoor", "gen_mediumroom", 1, 1);
  setambientroomsnapshot("indoor", "veh_f35_off");
  setambientroomcontext("indoor", "ringoff_plr", "indoor");
  declareambientpackage("indoor");
  declareambientroom("battle");
  setambientroomtone("battle", "blk_la_battle_bg", 0.5, 0.5);
  setambientroomreverb("battle", "la_2_outdoor", 1, 1);
  setambientroomsnapshot("battle", "veh_f35_off");
  setambientroomcontext("battle", "ringoff_plr", "outdoor");
  declareambientpackage("battle");
  declareambientroom("f35_int", 1);
  setambientroomtone("f35_int", "blk_la_battle_f35_bg");
  setambientroomreverb("f35_int", "la_2_cockpit", 1, 1);
  setambientroomcontext("f35_int", "ringoff_plr", "indoor");
  setambientroomsnapshot("f35_int", "veh_f35_int");
  declareambientroom("f35_int_dogfight");
  setambientroomtone("f35_int_dogfight", "blk_la_battle_f35_bg");
  setambientroomreverb("f35_int_dogfight", "la_2_cockpit", 1, 1);
  setambientroomsnapshot("f35_int_dogfight", "veh_f35_int");
  setambientroomcontext("f35_int_dogfight", "ringoff_plr", "indoor");
  declaremusicstate("LA_2_INTRO");
  musicaliasloop("mus_la2_intro", 0, 2);
  declaremusicstate("LA_2_ESCORT");
  musicaliasloop("mus_la2_escort_loop", 1, 2);
  declaremusicstate("LA_2_DOGFIGHT");
  musicalias("mus_la2_dogfight_intro", 0, 0, 1.6);
  musicaliasloop("mus_la2_dogfight_loop", 0, 2);
  musicstinger("mus_la2_dogfight_parachute", 0);
  declaremusicstate("LA_2_END");
  musicaliasloop("null", 0, 0);
  declaremusicstate("LA_2_PARACHUTE");
  musicaliasloop("null", 0, 0);
  level thread activate_f35_room();
  level thread deactivate_f35_room();
  level thread set_intro_to_exterior();
  thread tv_sounds();
  level thread fx_audio_setup();
  level thread jet_transistion_watcher();
  level thread jet_boost_watcher();
  level thread setup_ambient_fx_sounds();
  level thread special_greenlight_ending();
  level thread f35_health_system();
  level thread cleanup_ground_emitters();
  level thread change_room_for_dogfight();
  level thread sound_fade_out_snapshot();
}

set_intro_to_exterior() {
  level waittill("intro_exterior");
  wait 1;
  deactivateambientroom(0, "f35_int", 1);
  activateambientroom(0, "outdoor", 1);
  setsoundcontext("grass", "no_grass");
  setsoundcontext("f35", "exterior");
}

activate_f35_room() {
  level waittill("start_f35_snap");
  deactivateambientroom(0, "outdoor", 1);
  activateambientroom(0, "f35_int", 1);
  setsoundcontext("grass", "no_grass");
  setsoundcontext("f35", "interior");
}

deactivate_f35_room() {
  level waittill("stop_f35_snap");
  deactivateambientroom(0, "f35_int", 1);
  activateambientroom(0, "outdoor", 1);
  setsoundcontext("f35", "exterior");
}

jet_transistion_watcher() {
  while(true) {
    player = getlocalplayers()[0];
    level waittill("snd_jet_start");
    level.sndvtolmode = 0;
    player playsound(0, "veh_vtol_engage_c");
    level waittill("snd_vtol_start");
    level.sndvtolmode = 1;
    player playsound(0, "veh_vtol_disengage_c");
  }
}

jet_boost_watcher() {
  boost_ent = spawn(0, (0, 0, 0), "script_origin");
  boost_lfe = spawn(0, (0, 0, 0), "script_origin");

  while(true) {
    player = getlocalplayers()[0];
    level waittill("snd_boost_start");
    player playsound(0, "veh_f35_boost");
    boost_ent playloopsound("veh_f35_boost_lp", 1);
    boost_lfe playloopsound("veh_f35_boost_lp_lfe", 1);
    level waittill("snd_boost_end");
    boost_ent stoploopsound(0.5);
    boost_lfe stoploopsound(0.5);
  }
}

fx_audio_setup() {
  snd_play_auto_fx("parking_garage_pillar", "evt_parking_garage");
}

tv_sounds() {
  playloopat("blk_vox_emg_broadcast_big", (-14951, -26712, 260));
}

radio_chatter() {
  level endon("stop_f35_snap");

  while(true) {
    wait(randomintrange(5, 15));
    self playsound(0, "blk_f35_radio_chatter");
  }
}

setup_ambient_fx_sounds() {
  snd_play_auto_fx("fx_la2_fire_window_lg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_window_xlg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_lg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_line_xlg", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_la2_fire_fuel_sm", "amb_fire_sml", 0, 0, 0, 0, 200, 3, "amb_fire_sml");
  snd_play_auto_fx("fx_fire_fuel_sm_smolder", "amb_fire_tiny", 0, 0, 0, 0, 200, 3, "amb_fire_tiny");
}

special_greenlight_ending() {
  level waittill("gnses");
  snd_set_snapshot("spl_la_2_greenlight_ending");
}

f35_health_system() {
  level thread max_health_wait();
  level thread health_warnings();
}

max_health_wait() {
  while(true) {
    level waittill("f35_h_max");
    soundstoploopemitter("evt_health_alarm_mid", (0, 0, 0));
    soundstoploopemitter("evt_health_alarm_low", (0, 0, 0));
    level thread health_warnings();
  }
}

health_warnings() {
  level endon("f35_h_max");
  level waittill("f35_h_mid");
  playloopat("evt_health_alarm_mid", (0, 0, 0));
  level waittill("f35_h_low");
  playloopat("evt_health_alarm_low", (0, 0, 0));
}

cleanup_ground_emitters() {
  level waittill("sgc");
  ground_battles = getstructarray("amb_fadeup_disaster_sirens", "targetname");

  if(isDefined(ground_battles)) {
    for(i = 0; i < ground_battles.size; i++)
      soundstoploopemitter(ground_battles[i].script_sound, ground_battles[i].origin);
  }

  amb_ground_battle_loopers = getstructarray("amb_fadeup_battle", "targetname");

  if(isDefined(amb_ground_battle_loopers)) {
    for(i = 0; i < amb_ground_battle_loopers.size; i++)
      soundstoploopemitter(amb_ground_battle_loopers[i].script_sound, amb_ground_battle_loopers[i].origin);
  }
}

change_room_for_dogfight() {
  level waittill("dfs_go");
  activateambientroom(0, "f35_int_dogfight", 0);
  setsoundcontext("grass", "in_grass");
  setsoundcontext("f35", "interior");
}

sound_fade_out_snapshot() {
  level waittill("fade_out");
  snd_set_snapshot("cmn_fade_out");
}