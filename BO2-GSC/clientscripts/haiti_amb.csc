/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\haiti_amb.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("haiti_outside", 1);
  setambientroomtone("haiti_outside", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("haiti_outside", "haiti_outdoor", 1, 1);
  setambientroomcontext("haiti_outside", "ringoff_plr", "outdoor");
  declareambientpackage("haiti_outside");
  declareambientroom("haiti_security_building");
  setambientroomtone("haiti_security_building", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_security_building", "haiti_security_building", 1, 1);
  setambientroomcontext("haiti_security_building", "ringoff_plr", "indoor");
  declareambientpackage("haiti_security_building");
  declareambientroom("haiti_security_stairs");
  setambientroomtone("haiti_security_stairs", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_security_stairs", "haiti_stairwell", 1, 1);
  setambientroomcontext("haiti_security_stairs", "ringoff_plr", "indoor");
  declareambientpackage("haiti_security_stairs");
  declareambientroom("haiti_security_garage");
  setambientroomtone("haiti_security_garage", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_security_garage", "haiti_security_garage", 1, 1);
  setambientroomcontext("haiti_security_garage", "ringoff_plr", "indoor");
  declareambientpackage("haiti_security_garage");
  declareambientroom("haiti_round_overhang");
  setambientroomtone("haiti_round_overhang", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("haiti_round_overhang", "haiti_partial", 1, 1);
  setambientroomcontext("haiti_round_overhang", "ringoff_plr", "outdoor");
  declareambientpackage("haiti_round_overhang");
  declareambientroom("haiti_ammo_room");
  setambientroomtone("haiti_ammo_room", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_ammo_room", "haiti_ammo_room", 1, 1);
  setambientroomcontext("haiti_ammo_room", "ringoff_plr", "indoor");
  declareambientpackage("haiti_ammo_room");
  declareambientroom("haiti_main_ent_outside");
  setambientroomtone("haiti_main_ent_outside", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("haiti_main_ent_outside", "haiti_partial", 1, 1);
  setambientroomcontext("haiti_main_ent_outside", "ringoff_plr", "outdoor");
  declareambientpackage("haiti_main_ent_outside");
  declareambientroom("haiti_main_ent_inside");
  setambientroomtone("haiti_main_ent_inside", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_main_ent_inside", "haiti_main_ent_inside", 1, 1);
  setambientroomcontext("haiti_main_ent_inside", "ringoff_plr", "indoor");
  declareambientpackage("haiti_main_ent_inside");
  declareambientroom("haiti_side_room");
  setambientroomtone("haiti_side_room", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_side_room", "haiti_side_room", 1, 1);
  setambientroomcontext("haiti_side_room", "ringoff_plr", "indoor");
  declareambientpackage("haiti_side_room");
  declareambientroom("haiti_ent_stairwell");
  setambientroomtone("haiti_ent_stairwell", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_ent_stairwell", "haiti_stairwell", 1, 1);
  setambientroomcontext("haiti_ent_stairwell", "ringoff_plr", "indoor");
  declareambientpackage("haiti_ent_stairwell");
  declareambientroom("haiti_pre_security_scan");
  setambientroomtone("haiti_pre_security_scan", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_pre_security_scan", "haiti_security_building", 1, 1);
  setambientroomcontext("haiti_pre_security_scan", "ringoff_plr", "indoor");
  declareambientpackage("haiti_pre_security_scan");
  declareambientroom("haiti_security_scan");
  setambientroomtone("haiti_security_scan", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_security_scan", "haiti_security_building", 1, 1);
  setambientroomcontext("haiti_security_scan", "ringoff_plr", "indoor");
  declareambientpackage("haiti_security_scan");
  declareambientroom("haiti_command_main");
  setambientroomtone("haiti_command_main", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_command_main", "haiti_command_main", 1, 1);
  setambientroomcontext("haiti_command_main", "ringoff_plr", "indoor");
  declareambientpackage("haiti_command_main");
  declareambientroom("haiti_command_hallway_sml");
  setambientroomtone("haiti_command_hallway_sml", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_command_hallway_sml", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_command_hallway_sml", "ringoff_plr", "indoor");
  declareambientpackage("haiti_command_hallway_sml");
  declareambientroom("haiti_command_server_rm");
  setambientroomtone("haiti_command_server_rm", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_command_server_rm", "haiti_command_server_rm", 1, 1);
  setambientroomcontext("haiti_command_server_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_command_server_rm");
  declareambientroom("haiti_command_main_hallway");
  setambientroomtone("haiti_command_main_hallway", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_command_main_hallway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_command_main_hallway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_command_main_hallway");
  declareambientroom("haiti_shipping_rm");
  setambientroomtone("haiti_shipping_rm", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_shipping_rm", "haiti_shipping_rm", 1, 1);
  setambientroomcontext("haiti_shipping_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_shipping_rm");
  declareambientroom("haiti_shipping_walkway");
  setambientroomtone("haiti_shipping_walkway", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_shipping_walkway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_shipping_walkway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_shipping_walkway");
  declareambientroom("haiti_assembly_hallway");
  setambientroomtone("haiti_assembly_hallway", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_assembly_hallway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_assembly_hallway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_assembly_hallway");
  declareambientroom("haiti_assembly_main");
  setambientroomtone("haiti_assembly_main", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_assembly_main", "haiti_assembly_main", 1, 1);
  setambientroomcontext("haiti_assembly_main", "ringoff_plr", "indoor");
  declareambientpackage("haiti_assembly_main");
  declareambientroom("haiti_assembly_office");
  setambientroomtone("haiti_assembly_office", "amb_facility_bg", 0.5, 0.5);
  setambientroomreverb("haiti_assembly_office", "haiti_office", 1, 1);
  setambientroomcontext("haiti_assembly_office", "ringoff_plr", "indoor");
  declareambientpackage("haiti_assembly_office");
  declareambientroom("haiti_theater");
  setambientroomtone("haiti_theater", "amb_facility_theater_bg", 0.5, 0.5);
  setambientroomreverb("haiti_theater", "haiti_theater", 1, 1);
  setambientroomcontext("haiti_theater", "ringoff_plr", "indoor");
  declareambientpackage("haiti_theater");
  declareambientroom("haiti_theater_stairwell");
  setambientroomtone("haiti_theater_stairwell", "amb_facility_theater_bg", 0.5, 0.5);
  setambientroomreverb("haiti_theater_stairwell", "haiti_stairwell", 1, 1);
  setambientroomcontext("haiti_theater_stairwell", "ringoff_plr", "indoor");
  declareambientpackage("haiti_theater_stairwell");
  declareambientroom("haiti_transmission_main");
  setambientroomtone("haiti_transmission_main", "amb_facility_theater_bg", 0.5, 0.5);
  setambientroomreverb("haiti_transmission_main", "haiti_office", 1, 1);
  setambientroomcontext("haiti_transmission_main", "ringoff_plr", "indoor");
  declareambientpackage("haiti_transmission_main");
  declareambientroom("haiti_destroyed_hallway");
  setambientroomtone("haiti_destroyed_hallway", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_destroyed_hallway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_destroyed_hallway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_destroyed_hallway");
  declareambientroom("haiti_destroyed_office");
  setambientroomtone("haiti_destroyed_office", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_destroyed_office", "haiti_office", 1, 1);
  setambientroomcontext("haiti_destroyed_office", "ringoff_plr", "indoor");
  declareambientpackage("haiti_destroyed_office");
  declareambientroom("haiti_destroyed_pre_main");
  setambientroomtone("haiti_destroyed_pre_main", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_destroyed_pre_main", "haiti_office", 1, 1);
  setambientroomcontext("haiti_destroyed_pre_main", "ringoff_plr", "indoor");
  declareambientpackage("haiti_destroyed_pre_main");
  declareambientroom("haiti_destroyed_main_lrg");
  setambientroomtone("haiti_destroyed_main_lrg", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_destroyed_main_lrg", "haiti_shipping_rm", 1, 1);
  setambientroomcontext("haiti_destroyed_main_lrg", "ringoff_plr", "indoor");
  declareambientpackage("haiti_destroyed_main_lrg");
  declareambientroom("haiti_dest_stairwell");
  setambientroomtone("haiti_dest_stairwell", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_stairwell", "haiti_med_room", 1, 1);
  setambientroomcontext("haiti_dest_stairwell", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_stairwell");
  declareambientroom("haiti_dest_pre_server");
  setambientroomtone("haiti_dest_pre_server", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_pre_server", "haiti_comm_main", 1, 1);
  setambientroomcontext("haiti_dest_pre_server", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_pre_server");
  declareambientroom("haiti_dest_server");
  setambientroomtone("haiti_dest_server", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_server", "haiti_comm_main", 1, 1);
  setambientroomcontext("haiti_dest_server", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_server");
  declareambientroom("haiti_dest_production");
  setambientroomtone("haiti_dest_production", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_production", "haiti_med_room", 1, 1);
  setambientroomcontext("haiti_dest_production", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_production");
  declareambientroom("haiti_dest_piston_hallway");
  setambientroomtone("haiti_dest_piston_hallway", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_piston_hallway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_dest_piston_hallway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_piston_hallway");
  declareambientroom("haiti_dest_piston_rm");
  setambientroomtone("haiti_dest_piston_rm", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_piston_rm", "haiti_med_room", 1, 1);
  setambientroomcontext("haiti_dest_piston_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_piston_rm");
  declareambientroom("haiti_dest_catwalk_rm");
  setambientroomtone("haiti_dest_catwalk_rm", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_dest_catwalk_rm", "haiti_comm_main", 1, 1);
  setambientroomcontext("haiti_dest_catwalk_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_dest_catwalk_rm");
  declareambientroom("haiti_pre_iso_rm");
  setambientroomtone("haiti_pre_iso_rm", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_pre_iso_rm", "haiti_comm_main", 1, 1);
  setambientroomcontext("haiti_pre_iso_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_pre_iso_rm");
  declareambientroom("haiti_main_iso_rm");
  setambientroomtone("haiti_main_iso_rm", "amb_facility_special_bg", 0.5, 0.5);
  setambientroomreverb("haiti_main_iso_rm", "haiti_med_room", 1, 1);
  setambientroomcontext("haiti_main_iso_rm", "ringoff_plr", "indoor");
  declareambientpackage("haiti_main_iso_rm");
  declareambientroom("haiti_comm_hallway");
  setambientroomtone("haiti_comm_hallway", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_comm_hallway", "haiti_hallway", 1, 1);
  setambientroomcontext("haiti_comm_hallway", "ringoff_plr", "indoor");
  declareambientpackage("haiti_comm_hallway");
  declareambientroom("haiti_comm_main");
  setambientroomtone("haiti_comm_main", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_comm_main", "haiti_comm_main", 1, 1);
  setambientroomcontext("haiti_comm_main", "ringoff_plr", "indoor");
  declareambientpackage("haiti_comm_main");
  declareambientroom("haiti_hanger");
  setambientroomtone("haiti_hanger", "amb_facility_start_bg", 0.5, 0.5);
  setambientroomreverb("haiti_hanger", "haiti_hangar", 1, 1);
  setambientroomcontext("haiti_hanger", "ringoff_plr", "indoor");
  declareambientpackage("haiti_hanger");
  declareambientroom("timeslow");
  setambientroomreverb("timeslow", "rage_echo", 1, 1);
  setambientroomcontext("timeslow", "ringoff_plr", "indoor");
  declareambientpackage("timeslow");
  declareambientroom("haiti_wingsuit");
  setambientroomreverb("haiti_wingsuit", "haiti_wingsuit", 1, 1);
  setambientroomcontext("haiti_wingsuit", "ringoff_plr", "indoor");
  declareambientpackage("haiti_wingsuit");
  declaremusicstate("HAITI_INTRO");
  musicalias("mus_intro", 1, 0);
  declaremusicstate("HAITI_FLIGHT");
  musicalias("mus_flight", 6, 1, 97);
  declaremusicstate("HAITI_GROUND_FIGHT_1");
  musicaliasloop("mus_base_fight_1", 0, 3);
  declaremusicstate("HAITI_PRE_MENENDEZ");
  musicaliasloop("mus_pre_menendez_speech", 1, 2);
  declaremusicstate("HAITI_MENENDEZ_SPEECH");
  musicaliasloop("mus_menendez_speech", 1, 3);
  declaremusicstate("HAITI_MENENDEZ_CHASE");
  musicaliasloop("mus_menendez_chase", 3, 1);
  declaremusicstate("HAITI_END_EXPLOSION");
  musicalias("mus_end_explosion", 0, 0);
  declaremusicstate("HAITI_DROP_DOWN");
  musicalias("mus_end_slomo", 7, 0);
  declaremusicstate("HAI_DROP_DOWN_FAIL");
  musicaliasloop("null", 0, 0);
  declaremusicstate("HAI_MORALS");
  musicalias("mus_morals", 1, 1);
  musicstinger("mus_morals_stg", 5, 1);
  declaremusicstate("HAI_CHOICE_KILL");
  musicaliasloop("null", 0, 0);
  declaremusicstate("HAI_CHOICE_CAPTURE");
  musicaliasloop("null", 0, 0);
  declaremusicstate("HAITI_END_KILLED_HARPER");
  musicalias("mus_end_death_harper", 5, 0.5);
  declaremusicstate("HAITI_END_KILLED_OUTSIDE_HARPER");
  musicalias("mus_end_death_outside", 0, 5);
  declaremusicstate("HAITI_END_KILLED_OUTSIDE_NOHARPER");
  musicalias("mus_end_death_outside_noharper", 0, 1.5);
  declaremusicstate("HAITI_END_CAPTURED");
  musicalias("mus_end_captured", 0, 0);
  level thread snd_start_add_exploder_alias();
  level thread intro_snapshot();
  level thread snapshot_check();
  level thread vtol_hatch_snapshot();
  level thread jet_wing_helmet_futz_on();
  level thread jet_wing_helmet_futz_off();
  level thread jet_wing_radio_chatter();
  level thread cerelium_room_loops();
  level thread theater_battle_loops();
  level thread jet_wing_breathing();
  level thread jetpack_wind();
  level thread snd_start_autofx_audio();
  setsoundcontext("grass", "no_grass");
}

snd_start_add_exploder_alias() {
  wait 1;
  snd_add_exploder_alias(105, "vtol_doors");
  snd_add_exploder_alias(110, "exp_air_vtol_swt");
  snd_add_exploder_alias(120, "exp_air_vtol");
}

intro_snapshot() {
  level waittill("intro_snapshot");
  snd_set_snapshot("spl_haiti_vtol_int");
  setsoundcontext("grass", "in_grass");
}

snapshot_check() {
  level endon("intro_snapshot");
  wait 3;
  snd_set_snapshot("default");
}

vtol_hatch_snapshot() {
  level waittill("vtol_snapshot_change");
  snd_set_snapshot("default");
}

jet_wing_helmet_futz_on() {
  while(true) {
    level waittill("hmt");
    setglobalfutz("jet_wing_helmet", 0.0);
    activateambientroom(0, "haiti_wingsuit", 100);
    wait 47;
    level notify("jet_wind");
    wait 4;
    level notify("strt_chtr");
  }
}

jet_wing_helmet_futz_off() {
  while(true) {
    level waittill("hmtx");
    wait 14;
    playsound(0, "evt_jetwing_helmet_off", (0, 0, 0));
    setglobalfutz("no_gfutz", 0.0);
    deactivateambientroom(0, "haiti_wingsuit", 100);
    setsoundcontext("grass", "no_grass");
  }
}

jet_wing_radio_chatter() {
  level waittill("strt_chtr");
  wait 5;

  while(true) {
    level endon("hmtx");
    playsound(0, "evt_jetwing_chatter", (0, 0, 0));
    wait(randomintrange(4, 8));
  }
}

jet_wing_breathing() {
  level waittill("hmt");

  for(i = 0; i < 6; i++) {
    if(i > 0) {
      playsound(0, "evt_jetwing_breaths_normal");
      wait 3;
    }
  }

  level waittill("vtol_snapshot_change");

  while(true) {
    level endon("hmtx");
    playsound(0, "evt_jetwing_breaths", (0, 0, 0));
    wait(randomintrange(2, 4));
  }

  for(i = 0; i < 5; i++) {
    if(i > 0) {
      playsound(0, "evt_jetwing_breaths");
      wait 2;
    }
  }
}

sndduckambendintro() {
  snd_set_snapshot("spl_haiti_end_floor_collapse");
}

sndducklookyloo() {
  snd_set_snapshot("spl_haiti_end_lookyloo");
  level waittill("looky_loo_end");
  snd_set_snapshot("default");
}

jetpack_wind() {
  level waittill("jet_wind");
  jetpack_snd = spawn(0, (0, 0, 0), "script_origin");
  jetpack_snd playloopsound("evt_jetpack_wind_fnt", 2);
  level waittill("stop_jetpack");
  wait 8;
  jetpack_snd stoploopsound(6);
  wait 7;
  jetpack_snd delete();
}

cerelium_room_loops() {
  playloopat("amb_celerium_hum", (-18358, 4530, 697));
  playloopat("amb_celerium_computer_center", (-18357, 4531, 680));
  playloopat("amb_coolant_pipe", (-18299, 4707, 653));
  playloopat("amb_coolant_pipe", (-18567, 4502, 654));
  playloopat("amb_pistons", (-18273, 4375, 666));
  playloopat("amb_pistons", (-18520, 4626, 678));
  playloopat("amb_engine_clank", (-18283, 4453, 639));
  playloopat("amb_engine_clank", (-18519, 4696, 635));
}

theater_battle_loops() {
  playloopat("amb_fake_int_battle1", (-14885, 1461, 698));
  playloopat("amb_fake_int_battle2", (-14922, 763, 681));
}

timeslow_reverb() {
  activateambientpackage(0, "timeslow", 100);
  activateambientroom(0, "timeslow", 100);
  setsoundcontext("grass", "in_grass");
  level waittill("timeslow_snd_stop");
  deactivateambientpackage(0, "timeslow", 100);
  deactivateambientroom(0, "timeslow", 100);
  setsoundcontext("grass", "no_grass");
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_small", 0, 0, 0, 0, 350, 3, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_medium", 0, 0, 0, 0, 350, 3, "amb_fire_large");
  snd_play_auto_fx("fx_computer_fire_xsm", "amb_fire_small", 0, 0, 0, 0, 350, 3, "amb_fire_medium");
  snd_play_auto_fx("fx_computer_fire_line_sm", "amb_fire_small", 0, 0, 0, 0, 350, 3, "amb_fire_medium");
  snd_play_auto_fx("fx_vehicle_fire1", "amb_truck_fire", 0, 0, 0, 0);
  snd_play_auto_fx("fx_vehicle_fire2", "amb_truck_fire", 0, 0, 0, 0);
  snd_play_auto_fx("fx_fast_fire_md", "amb_fire_medium", 0, 0, 0, 0, 350, 3, "amb_fire_large");
  snd_play_auto_fx("fx_foliage_fire1", "amb_fire_medium", 0, 0, 0, 0, 350, 3, "amb_fire_large");
  snd_play_auto_fx("fx_end_fire_med", "amb_fire_medium", 0, 0, 0, 0, 350, 3, "amb_fire_large");
  snd_play_auto_fx("fx_end_fire_pillar1", "amb_fire_large", 0, 0, 0, 0);
  snd_play_auto_fx("fx_steam_pipe1", "amb_steam_lrg", 0, 0, 0, 0);
  snd_play_auto_fx("fx_steam_vent1", "amb_steam_lrg", 0, 0, 0, 0);
  snd_play_auto_fx("fx_steam_ceiling", "amb_steam_lrg", 0, 0, 0, 0);
  snd_play_auto_fx("fx_end_chamber_steam", "amb_steam_lrg", 0, 0, 0, 0);
}

sndendingsnapshot() {
  snd_set_snapshot("spl_haiti_ending");
  level thread sndlevelendambience();
}

sndlevelendambience() {
  thread play_fake_random((-21637, 4057, -83), "amb_radio1_random", 2, 8);
  thread play_fake_random((-21413, 4688, -59), "amb_radio2_random", 2, 8);
  soundlineemitter("amb_outdoor_loop_l", (-21177, 3884, -66), (-21547, 3911, -57));
  soundlineemitter("amb_outdoor_loop_r", (-21209, 4660, -54), (-21618, 4617, -34));
  thread play_fake_random((-21262, 3738, -42), "amb_generic_soldier_vox", 5, 12);
  thread play_fake_random((-21938, 4343, -67), "amb_generic_soldier_vox", 5, 12);
  thread play_fake_random((-21777, 4609, -24), "amb_generic_soldier_vox", 5, 12);
  thread playloopat("amb_dist_vehicle_1", (-22232, 3843, -11));
  thread playloopat("amb_dist_vehicle_2", (-21836, 5135, -6));
}

play_fake_random(origin, alias, waitmin, waitmax) {
  while(true) {
    wait(randomintrange(waitmin, waitmax));
    playsound(0, alias, origin);
  }
}

sndtheend() {
  snd_set_snapshot("spl_haiti_theend");
}

snd_create_randoms() {
  mintime = 6;
  maxtime = 26;
  create_sound_random((-14720, 996, 624), "amb_radios_trans", mintime, maxtime);
  create_sound_random((-14836, 1023, 618), "amb_radios_trans", mintime, maxtime);
  create_sound_random((-15133, 1000, 623), "amb_radios_trans", mintime, maxtime);
  create_sound_random((-15275, 1054, 618), "amb_radios_trans", mintime, maxtime);
}