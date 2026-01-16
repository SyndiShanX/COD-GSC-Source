/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\monsoon_amb.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  snd_set_snapshot("spl_monsoon_fade_in");
  declareambientroom("monsoon_outdoor", 1);
  setambientroomtone("monsoon_outdoor", "amb_monsoon_rain_blend", 1, 1);
  setambientroomreverb("monsoon_outdoor", "monsoon_outdoor", 1, 1);
  setambientroomcontext("monsoon_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("monsoon_outdoor");
  declareambientroom("mon_outside_elevator");
  setambientroomtone("mon_outside_elevator", "amb_monsoon_rain_blend", 1, 1);
  setambientroomreverb("mon_outside_elevator", "monsoon_vader_lobby", 1, 1);
  setambientroomcontext("mon_outside_elevator", "ringoff_plr", "indoor");
  declareambientpackage("mon_outside_elevator");
  declareambientroom("mon_gaurd_booth");
  setambientroomreverb("mon_gaurd_booth", "monsoon_booth", 1, 1);
  setambientroomcontext("mon_gaurd_booth", "ringoff_plr", "indoor");
  declareambientpackage("mon_gaurd_booth");
  declareambientroom("mon_temple_arch_lrg");
  setambientroomtone("mon_temple_arch_lrg", "amb_monsoon_rain_blend", 1, 1);
  setambientroomreverb("mon_temple_arch_lrg", "monsoon_arch_lg", 1, 1);
  setambientroomcontext("mon_temple_arch_lrg", "ringoff_plr", "outdoor");
  declareambientpackage("mon_temple_arch_lrg");
  declareambientroom("mon_temple_arch_sml");
  setambientroomtone("mon_temple_arch_sml", "amb_monsoon_rain_blend", 1, 1);
  setambientroomreverb("mon_temple_arch_sml", "monsoon_arch_sml", 1, 1);
  setambientroomcontext("mon_temple_arch_sml", "ringoff_plr", "outdoor");
  declareambientpackage("mon_temple_arch_sml");
  declareambientroom("mon_temple_hallway");
  setambientroomreverb("mon_temple_hallway", "monsoon_arch_hall", 1, 1);
  setambientroomcontext("mon_temple_hallway", "ringoff_plr", "indoor");
  declareambientpackage("mon_temple_hallway");
  declareambientroom("mon_temple_lg");
  setambientroomreverb("mon_temple_lg", "monsoon_temple", 1, 1);
  setambientroomcontext("mon_temple_lg", "ringoff_plr", "indoor");
  declareambientpackage("mon_temple_lg");
  declareambientroom("mon_lab_hallway");
  setambientroomtone("mon_lab_hallway", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_lab_hallway", "monsoon_lab_hall", 1, 1);
  setambientroomcontext("mon_lab_hallway", "ringoff_plr", "indoor");
  declareambientpackage("mon_lab_hallway");
  declareambientroom("mon_lab_room_sml");
  setambientroomtone("mon_lab_room_sml", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_lab_room_sml", "monsoon_lab_sml", 1, 1);
  setambientroomcontext("mon_lab_room_sml", "ringoff_plr", "indoor");
  declareambientpackage("mon_lab_room_sml");
  declareambientroom("mon_lab_entr_room");
  setambientroomtone("mon_lab_entr_room", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_lab_entr_room", "monsoon_lab_lg", 1, 1);
  setambientroomcontext("mon_lab_entr_room", "ringoff_plr", "indoor");
  declareambientpackage("mon_lab_entr_room");
  declareambientroom("mon_rock_hallway");
  setambientroomreverb("mon_rock_hallway", "monsoon_stone_hall", 1, 1);
  setambientroomcontext("mon_rock_hallway", "ringoff_plr", "indoor");
  declareambientpackage("mon_rock_hallway");
  declareambientroom("mon_server_room_bot");
  setambientroomtone("mon_server_room_bot", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_server_room_bot", "monsoon_server_sml", 1, 1);
  setambientroomcontext("mon_server_room_bot", "ringoff_plr", "indoor");
  declareambientpackage("mon_server_room_bot");
  declareambientroom("mon_server_room_cntr");
  setambientroomtone("mon_server_room_cntr", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_server_room_cntr", "monsoon_server_lg", 1, 1);
  setambientroomcontext("mon_server_room_cntr", "ringoff_plr", "indoor");
  declareambientpackage("mon_server_room_cntr");
  declareambientroom("mon_server_room_top");
  setambientroomtone("mon_server_room_top", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_server_room_top", "monsoon_server_top", 1, 1);
  setambientroomcontext("mon_server_room_top", "ringoff_plr", "indoor");
  declareambientpackage("mon_server_room_top");
  declareambientroom("mon_elev_room");
  setambientroomtone("mon_elev_room", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_elev_room", "monsoon_vader_room", 1, 1);
  setambientroomcontext("mon_elev_room", "ringoff_plr", "indoor");
  declareambientpackage("mon_elev_room");
  declareambientroom("mon_inside_elev");
  setambientroomtone("mon_elev_room", "amb_comp_room_2d", 0.5, 0.5);
  setambientroomreverb("mon_inside_elev", "monsoon_vader_int", 1, 1);
  setambientroomcontext("mon_inside_elev", "ringoff_plr", "indoor");
  declareambientpackage("mon_inside_elev");
  declareambientroom("mon_lower_lab_sml");
  setambientroomtone("mon_lower_lab_sml", "amb_cntrl_rm_2d", 0.5, 0.5);
  setambientroomreverb("mon_lower_lab_sml", "mon_lower_lab_sml", 1, 1);
  setambientroomcontext("mon_lower_lab_sml", "ringoff_plr", "indoor");
  declareambientpackage("mon_lower_lab_sml");
  declareambientroom("mon_lower_lab_med_room");
  setambientroomtone("mon_lower_lab_med_room", "amb_cntrl_rm_2d", 0.5, 0.5);
  setambientroomreverb("mon_lower_lab_med_room", "mon_lower_lab_med_room", 1, 1);
  setambientroomcontext("mon_lower_lab_med_room", "ringoff_plr", "indoor");
  declareambientpackage("mon_lower_lab_med_room");
  declareambientroom("mon_lower_lab_sml_room");
  setambientroomtone("mon_lower_lab_sml_room", "amb_cntrl_rm_2d", 0.5, 0.5);
  setambientroomreverb("mon_lower_lab_sml_room", "mon_lower_lab_sml_room", 1, 1);
  setambientroomcontext("mon_lower_lab_sml_room", "ringoff_plr", "indoor");
  declareambientpackage("mon_lower_lab_sml_room");
  declareambientroom("mom_main_lab_cntr_bot");
  setambientroomtone("mom_main_lab_cntr_bot", "amb_main_lab_2d", 0.5, 0.5);
  setambientroomreverb("mom_main_lab_cntr_bot", "mom_main_lab_cntr_bot", 1, 1);
  setambientroomcontext("mom_main_lab_cntr_bot", "ringoff_plr", "indoor");
  declareambientpackage("mom_main_lab_cntr_bot");
  declareambientroom("mom_main_lab");
  setambientroomtone("mom_main_lab", "amb_main_lab_2d", 0.5, 0.5);
  setambientroomreverb("mom_main_lab", "mom_main_lab", 1, 1);
  setambientroomcontext("mom_main_lab", "ringoff_plr", "indoor");
  declareambientpackage("mom_main_lab");
  declareambientroom("mon_gen_corridor");
  setambientroomtone("mom_main_lab", "amb_main_lab_2d", 0.5, 0.5);
  setambientroomreverb("mon_gen_corridor", "mon_gen_corridor", 1, 1);
  setambientroomcontext("mon_gen_corridor", "ringoff_plr", "indoor");
  declareambientpackage("mon_gen_corridor");
  declareambientroom("mon_main_gen_room");
  setambientroomtone("mom_main_lab", "amb_main_lab_2d", 0.5, 0.5);
  setambientroomreverb("mon_main_gen_room", "mon_main_gen_room", 1, 1);
  setambientroomcontext("mon_main_gen_room", "ringoff_plr", "indoor");
  declareambientpackage("mon_main_gen_room");
  declaremusicstate("MONSOON_INTRO");
  musicaliasloop("mus_intro_pad_loop", 0, 4);
  declaremusicstate("MONSOON_SWING");
  musicalias("mus_swing_stg", 0, 3);
  musicstinger("mus_tree_fall", 8, 1);
  declaremusicstate("MONSOON_TREE_FALL");
  musicaliasloop("mus_intro_pad_loop_c", 0, 3);
  declaremusicstate("MONSOON_FLIGHT");
  musicaliasloop("mus_flight", 0, 7);
  declaremusicstate("MONSOON_STEALTH");
  musicaliasloop("mus_stealth_prefight", 1, 3);
  declaremusicstate("MONSOON_BATTLE_1");
  musicalias("mus_outside_battle_intro", 0, 0, 1.7);
  musicaliasloop("mus_outside_battle", 0, 3.5);
  musicstinger("mus_outside_battle_stg", 10);
  declaremusicstate("MONSOON_BATTLE_1_END");
  musicaliasloop("mus_base_pad_loop", 0, 3);
  declaremusicstate("MONSOON_IN_RUINS");
  musicaliasloop("mus_underscore", 3, 0);
  declaremusicstate("MONSOON_BASE_FIGHT_1");
  musicaliasloop("mus_base_battle_part_one", 0, 3);
  declaremusicstate("MONSOON_LAB_UPSTAIRS_CLEAR");
  musicaliasloop("mus_underscore", 0, 3);
  declaremusicstate("MONSOON_NITROGEN_GUYS");
  musicaliasloop("mus_base_battle_part_one", 0, 3);
  declaremusicstate("MONSOON_ISAAC");
  musicaliasloop("mus_underscore", 3, 0);
  declaremusicstate("MONSOON_DEFEND_EVENT");
  musicaliasloop("mus_base_battle_part_two", 0, 3);
  declaremusicstate("MONSOON_DEFEND_EVENT_END");
  musicaliasloop("mus_underscore", 3, 3);
  declaremusicstate("MONSOON_CELERIUM");
  musicaliasloop("mus_celerium", 0, 0);
  declaremusicstate("MONSOON_BASE_FIGHT_3");
  musicalias("mus_outside_battle_intro", 0, 0, 1.7);
  musicaliasloop("mus_base_battle_part_three", 0, 2);
  declaremusicstate("MONSOON_ENDING");
  musicaliasloop("mus_ending", 0, 8);
  declaremusicstate("MONSOON_BRIGGS");
  musicalias("mus_briggs_stg", 0, 0);
  thread snd_play_loopers();
  thread snd_start_autofx_audio();
  level thread wingsuit();
  level thread snd_start_add_exploder_alias();
  level thread heliwatcher();
  level thread intro_fake_ambience();
  level thread base_alarms();
  level thread celerium_loops();
  thread snd_amb_ruin_off();
  thread lab_alarms();
  thread lab_alarms_off();
}

heliwatcher() {
  level waittill("stpheli");
  self.should_not_play_sounds = 1;
}

intro_fake_ambience() {
  level waittill("sndFakeAmb");
  snd_set_snapshot("spl_monsoon_fake_ambience_intro");
  ent = spawn(0, (0, 0, 0), "script_origin");
  ent playloopsound("amb_monsoon_fake_amb_front", 0.05);
  ent2 = spawn(0, (0, 0, 1), "script_origin");
  ent2 playloopsound("evt_binocs_hud_lp", 0.05);
  level waittill("sndFakeAmbEnd");
  snd_set_snapshot("default");
  ent2 stoploopsound(0.2);
  ent stoploopsound(9);
  wait 9;
  ent delete();
}

snapshot_check() {
  level endon("intr_on");
  wait 2;
  snd_set_snapshot("default");
}

snd_play_loopers() {
  playloopat("amb_metal_drips", (7231, 53843, -701));
  playloopat("amb_metal_drips", (7229, 54772, -867));
  playloopat("amb_wind_strong_temple", (7239, 55165, -386));
  playloopat("amb_out_lights", (7379, 53713, -630));
  playloopat("amb_out_lights", (6977, 53759, -671));
  playloopat("amb_out_lights", (7462, 55355, -863));
  playloopat("amb_out_lights", (7233, 53809, -465));
  playloopat("amb_out_lights", (7232, 54243, -534));
  playloopat("amb_out_lights", (7302, 54508, -800));
  playloopat("amb_out_lights", (7026, 54943, -784));
  playloopat("amb_out_lights", (6892, 54809, -829));
  playloopat("amb_out_lights", (7076, 55346, -789));
  playloopat("amb_out_lights", (7356, 55608, -842));
  playloopat("amb_flourescent_light", (7648, 55516, -650));
}

celerium_loops() {
  level waittill("clrm_o");
  playloopat("amb_celerium_hum", (-18358, 4530, 697));
  playloopat("amb_celerium_computer_rf", (5910, 56291, -1195));
  playloopat("amb_celerium_computer_rr", (5645, 56287, -1202));
  playloopat("amb_celerium_computer_lf", (5905, 56030, -1202));
  playloopat("amb_celerium_computer_lr", (5643, 56029, -1193));
  level waittill("clrm_x");
  stoploopat("amb_celerium_hum", (-18358, 4530, 697));
  stoploopat("amb_celerium_computer_rf", (5910, 56291, -1195));
  stoploopat("amb_celerium_computer_rr", (5645, 56287, -1202));
  stoploopat("amb_celerium_computer_lf", (5905, 56030, -1202));
  stoploopat("amb_celerium_computer_lr", (5643, 56029, -1193));
}

snd_start_add_exploder_alias() {
  wait 1;
  snd_add_exploder_alias(1000, "evt_ruins_doors_explode");
  snd_add_exploder_alias(1500, "evt_karma_smoke_grenade");
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_mon_vent_roof_steam_lg", "amb_steam_lrg", 0, 0, 0, 0);
  snd_play_auto_fx("fx_water_spill_splash_wide", "amb_water_drip", 0, 0, 0, 1);
  snd_play_auto_fx("fx_water_roof_spill_lg_hvy", "amb_water_splash_2", 0, 0, 0, 0);
  snd_play_auto_fx("fx_mon_mud_stream_froth", "amb_muddy_water", 0, 0, 0, 1);
  snd_play_auto_fx("fx_mon_lab_steam_vent", "amb_exhaust", 0, 0, 0, 1);
}

wingsuit() {
  ent1 = spawn(0, (0, 0, 0), "script_origin");
  level waittill("wng_st");
  ent1 playloopsound("evt_wingsuit_wind_fnt", 2.5);
  level waittill("wg_st_dn");
  ent1 stoploopsound(7);
  ent1 delete();
}

base_alarms() {
  level waittill("stlth_x");
  playloopat("amb_base_alarm", (-838, 50818, -889));
  playloopat("amb_base_alarm", (1142, 53177, -656));
}

snd_amb_ruin_off() {
  level waittill("snoff");
  level notify("snd_amb_off");
}

snd_pa_start() {
}

lab_alarms() {
  level waittill("snd_alarm");
  playloopat("amb_lab_alarm", (9436, 55201, -723));
  playloopat("amb_lab_alarm", (9567, 56625, -691));
  playloopat("amb_lab_alarm", (7137, 57308, -1124));
  playloopat("amb_lab_alarm_2", (7636, 56074, -1014));
}

lab_alarms_off() {
  level waittill("snd_alarm_off");
  stoploopat("amb_lab_alarm", (9436, 55201, -723));
  stoploopat("amb_lab_alarm", (9567, 56625, -691));
}