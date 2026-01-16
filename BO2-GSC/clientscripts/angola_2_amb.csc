/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\angola_2_amb.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_audio;

main() {
  declareambientroom("outdoor", 1);
  setambientroomtone("outdoor", "blk_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("outdoor", "angola_outside", 1, 1);
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declareambientroom("grass_short");
  setambientroomtone("grass_short", "blk_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("grass_short", "angola_outside", 1, 1);
  setambientroomcontext("grass_short", "ringoff_plr", "outdoor");
  declareambientpackage("grass_short");
  declareambientroom("riverbed");
  setambientroomreverb("riverbed", "angola_riverbed", 1, 1);
  setambientroomcontext("riverbed", "ringoff_plr", "outdoor");
  declareambientpackage("riverbed");
  declareambientroom("rock_passage");
  setambientroomtone("outdoor", "blk_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("rock_passage", "angola_rockwall", 1, 1);
  setambientroomcontext("rock_passage", "ringoff_plr", "outdoor");
  declareambientpackage("rock_passage");
  declareambientroom("boat_int");
  setambientroomreverb("boat_int", "angola_boat_cabin", 1, 1);
  setambientroomcontext("boat_int", "ringoff_plr", "outdoor");
  declareambientpackage("boat_int");
  declareambientroom("small_room");
  setambientroomreverb("small_room", "angola_smallroom", 1, 1);
  setambientroomcontext("small_room", "ringoff_plr", "indoor");
  declareambientpackage("small_room");
  declareambientroom("forest");
  setambientroomreverb("forest", "angola_forest", 1, 1);
  setambientroomcontext("forest", "ringoff_plr", "outdoor");
  declareambientpackage("forest");
  declareambientroom("village");
  setambientroomreverb("village", "angola_village", 1, 1);
  setambientroomcontext("village", "ringoff_plr", "outdoor");
  declareambientpackage("village");
  declareambientroom("open_hut");
  setambientroomreverb("open_hut", "angola_open_hut", 1, 1);
  setambientroomcontext("open_hut", "ringoff_plr", "outdoor");
  declareambientpackage("open_hut");
  declareambientroom("open_hut_med");
  setambientroomreverb("open_hut_med", "angola_open_hut_med", 1, 1);
  setambientroomcontext("open_hut_med", "ringoff_plr", "outdoor");
  declareambientpackage("open_hut_med");
  declareambientroom("woods_container");
  setambientroomreverb("woods_container", "angola_container", 1, 1);
  setambientroomcontext("woods_container", "ringoff_plr", "indoor");
  declareambientpackage("woods_container");
  declaremusicstate("ANGOLA_CHOPPER_IN");
  musicalias("mus_angola_chopper_ride", 2, 0);
  declaremusicstate("ANGOLA_MACHETE");
  musicalias("mus_angola_barge_machete", 1, 0);
  declaremusicstate("ANGOLA_BARGE_RIVERFIGHT");
  musicalias("mus_angola_barge_riverfight_leadin", 0, 0, 1.1);
  musicaliasloop("mus_angola_barge_riverfight", 0, 2);
  musicstinger("mus_angola_barge_riverfight_stg", 0, 1);
  declaremusicstate("ANGOLA_BARGE_PRE_CONT");
  musicaliasloop("null", 0, 2);
  declaremusicstate("ANGOLA_DEAD_BODIES");
  musicalias("mus_angola_dead_bodies", 3, 0.5);
  declaremusicstate("ANGOLA_CHOPPER_ARRIVE");
  musicaliasloop("mus_angola_chopper", 0, 2);
  declaremusicstate("ANGOLA_CHOPPER_DEAD");
  musicalias("mus_angola_chopper_crash", 0, 0, 11);
  musicaliasloop("mus_chopper_crash_dive", 0, 2);
  declaremusicstate("ANGOLA_POST_CHOPPER");
  musicaliasloop("mus_angola_cliffpath", 0, 6);
  declaremusicstate("ANGOLA_STEALTH_VILLAGE");
  musicaliasloop("mus_angola_stealth", 2, 4);
  declaremusicstate("ANGOLA_STEALTH_SUCCESS");
  musicaliasloop("null", 0, 2);
  declaremusicstate("ANGOLA_VILLAGE_APPROACH");
  musicaliasloop("mus_angola_pre_village", 4, 6);
  declaremusicstate("ANGOLA_MEATSHIELD_APPROACH");
  musicaliasloop("mus_angola_cabin_loop", 2, 4);
  declaremusicstate("ANGOLA_GUN_HEAD");
  musicalias("mus_angola_meat_shield", 0, 0);
  declaremusicstate("ANGOLA_JUNGLE_ESCAPE");
  musicaliasloop("mus_angola_escape", 0, 10);
  declaremusicstate("ANGOLA_END");
  musicalias("mus_angola_russianheli_stg", 1, 0);
  musicaliasloop("mus_angola_end_lowpad", 0, 2);
  declaremusicstate("ANGOLA_HUDSON_SHOT");
  musicalias("mus_angola_hudson_shot", 0, 0, 4);
  declaremusicstate("ANGOLA_END_RESOLVE");
  musicalias("mus_angola_end_resolve", 0, 0);
  level thread waterfalls();
  level thread escape_alarm();
  level thread escape_dogs();
  level thread truck_loops();
  level thread child_soldiers();
  thread snd_start_autofx_audio();
  level thread heli_fire();
  level thread set_alouette_context_int();
  level thread set_alouette_context_ext();
  level thread reset_alouette_context_ext();
  level thread chasers();
  level thread sinking_barge();
  level thread notetracked_clientnotifies();
  level thread heli_jump_snapshot();
  level thread level_fade_out();
  level thread underwater_snapshot();
  level thread snd_start_autofx_river_fight();
  level thread village_amb();
  level thread tv_missile_futz();
  level thread set_impact_context_dist();
  level thread set_impact_context_norm();
}

underwater_snapshot() {
  level waittill("uwsn_strt");
  snd_set_snapshot("spl_cmn_underwater");
  level waittill("uwsn_end");
  snd_set_snapshot("default");
}

level_fade_out() {
  level waittill("fade_out");
  snd_set_snapshot("cmn_fade_out");
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_insects_fly_swarm", "amb_insects", 0, 0, 0, 0);
  snd_play_auto_fx("fx_ango_fire_sm", "amb_fire_sml", 0, 0, 0, 0);
  snd_play_auto_fx("fx_ango_fire_xsm", "amb_fire_sml", 0, 0, 0, 0);
  snd_play_auto_fx("fx_ango_heli_fire", "amb_fire_lrg", 0, 0, 0, 0);
  snd_play_auto_fx("fx_angO-waterfall_bottom", "amb_waterfall_splash", 0, 0, 0, 0);
}

snd_start_autofx_river_fight() {
  playloopat("amb_waterfall_huge", (87141, -18019, 2155));
}

waterfalls() {
  playloopat("amb_waterfall_lg", (-20398, -865, 362));
  playloopat("amb_waterfall_splash", (-20349, -851, 476));
  playloopat("amb_waterfall_lg", (-22158, 299, 276));
  playloopat("amb_waterfall_splash", (-22158, 256, 273));
  playloopat("amb_waterfall_lg", (-25447, 670, 217));
  playloopat("amb_waterfall_lg", (-25579, 666, 94));
  playloopat("amb_waterfall_splash", (-25608, 569, 50));
  playloopat("amb_creek_rock_lp", (-23494, -384, 276));
  playloopat("amb_creek_rock_lp", (-24141, 274, 270));
  playloopat("amb_creek_rock_lp", (-25878, 595, 48));
  playloopat("amb_jungle_gen_a", (-24687, 3224, 842));
  playloopat("amb_jungle_gen_b", (-25950, 726, 1101));
  playloopat("amb_jungle_gen_c", (-24441, 225, 843));
  playloopat("amb_shore_water", (-27357, -2444, -6));
}

village_amb() {
  level endon("stopRadio");
  playloopat("amb_small_village_bg", (-19076, -2601, 1198));
  playloopat("amb_village_generator", (-19266, -2438, 678));
  playloopat("amb_base_loop", (-18423, -1963, 875));

  while(true) {
    playsound(0, "amb_village_cb_radio", (-19396, -3091, 690));
    wait(randomint(5));
  }
}

escape_alarm() {
  level waittill("esc_alrm");
  level thread playambientyellsaroundvillage();
  stoploopat("amb_small_village_bg", (-19076, -2601, 1198));
  wait 5;
  soundloopemitter("evt_escape_walla", (-18857, -2943, 742));
  soundloopemitter("evt_escape_alarm", (-18480, -3024, 728));
  wait 0.1;
  soundloopemitter("evt_escape_alarm", (-18547, -2057, 768));
  soundloopemitter("evt_escape_alarm", (-19070, -4033, 992));
  wait 0.15;
  soundloopemitter("evt_escape_alarm", (-17712, -3812, 992));
  soundloopemitter("evt_escape_alarm", (-22900, -3591, 911));
}

playambientyellsaroundvillage() {
  location = [];
  location[0] = (-19015, -2122, 751);
  location[1] = (-18729, -2673, 784);
  location[2] = (-18887, -3262, 760);
  location[3] = (-19506, -3219, 747);
  location[4] = (-19056, -2835, 679);
  wait 1;

  while(true) {
    rand = randomintrange(0, 5);
    playsound(0, "amb_base_alert_lines", location[rand]);
    wait(randomfloatrange(0.3, 2));
  }
}

escape_dogs() {
  level waittill("grn_dgs");
  wait 8.5;

  while(true) {
    playsound(0, "evt_escape_dogs", (-18953, -3434, 649));
    wait(randomint(2));
    playsound(0, "evt_escape_dogs", (-19051, -2422, 638));
    wait(randomint(2));
  }
}

truck_loops() {
  truck_ent_1 = spawn(0, (-17780, -1539, 571), "script_origin");
  truck_ent_2 = spawn(0, (-17770, -3391, 556), "script_origin");
  truck_ent_1 playloopsound("amb_truck_loop_1", 0.1);
  truck_ent_2 playloopsound("amb_truck_loop_2", 0.1);
}

child_soldiers() {
  cs_emit_1 = spawn(0, (-23207, -4260, 516), "script_origin");
  cs_emit_2 = spawn(0, (-23191, -2383, 494), "script_origin");
  cs_emit_3 = spawn(0, (-21466, -3545, 587), "script_origin");
  cs_emit_4 = spawn(0, (-21953, -2064, 476), "script_origin");
  cs_emit_5 = spawn(0, (-17780, -1539, 571), "script_origin");
  cs_emit_1 playloopsound("amb_child_soldiers_1", 0.1);
  cs_emit_2 playloopsound("amb_child_soldiers_2", 0.1);
  cs_emit_3 playloopsound("amb_child_soldiers_3", 0.1);
  cs_emit_4 playloopsound("amb_child_soldiers_4", 0.1);
  cs_emit_5 playloopsound("amb_child_soldiers_5", 0.1);
  level waittill("esc_alrm");
  cs_emit_1 stoploopsound(1);
  cs_emit_2 stoploopsound(1);
  cs_emit_3 stoploopsound(1);
  cs_emit_4 stoploopsound(1);
  cs_emit_5 stoploopsound(1);
}

heli_fire() {
  soundloopemitter("amb_heli_fire", (-26711, -2143, 44));
}

set_alouette_context_int() {
  level waittill("f35_interior");
  waitforclient(0);
  setsoundcontext("f35", "interior");
}

set_alouette_context_ext() {
  level waittill("alouette_jumped");
  wait 1.5;
  setsoundcontext("f35", "exterior");
}

reset_alouette_context_ext() {
  while(true) {
    level waittill("heli_context_switch");
    setsoundcontext("f35", "exterior");
  }
}

chasers() {
}

sinking_barge() {
  level waittill("barge_sink");
  soundloopemitter("evt_barge_overflow", (-27489, -3134, 18));
  soundloopemitter("evt_barge_overflow", (-27702, 2840, 7));
  soundloopemitter("evt_barge_overflow", (-27992, -2526, 8));
}

notetracked_clientnotifies() {
  level thread boatramsnapshots();
  level thread findwoodssequence();
}

boatramsnapshots() {
  level thread boatramsnapshoton();
  level thread boatramsnapshotoff();
}

boatramsnapshoton() {
  level waittill("boatram_on");
  snd_set_snapshot("spl_angola_evt06_boatram");
}

boatramsnapshotoff() {
  level waittill("boatram_off");
  snd_set_snapshot("default");
}

findwoodssequence() {
  level thread findwoodssnapshot();
  level thread findwoodsroom();
}

findwoodssnapshot() {
  level waittill("woods_snp_on");
  snd_set_snapshot("spl_angola_evt06_findwoods");
  level waittill("woods_snp_off");
  snd_set_snapshot("default");
}

findwoodsroom() {
  level waittill("woods_room_on");
  activateambientpackage(0, "woods_container", 80);
  activateambientroom(0, "woods_container", 80);
  level waittill("woods_room_off");
  deactivateambientpackage(0, "woods_container", 80);
  deactivateambientroom(0, "woods_container", 80);
}

heli_jump_snapshot() {
  level waittill("alouette_jumped");
  snd_set_snapshot("spl_angola_barge_fight");
  wait 7;
  snd_set_snapshot("default");
}

tv_missile_futz() {
  level endon("stop_tow_futz");
  level endon("death");

  while(true) {
    level waittill("tow_futz_on");
    setglobalfutz("spl_tow_missile", 1.0);
    level waittill("tow_futz_off");
    setglobalfutz("no_gfutz", 0.0);
    wait 0.1;
  }
}

set_impact_context_dist() {
  level waittill("imp_context");
  setsoundcontext("grass", "in_grass");
}

set_impact_context_norm() {
  level waittill("imp_context_reset");
  setsoundcontext("grass", "no_grass");
}

sndslowmosnapshoton() {
  snd_set_snapshot("spl_angola_2_radroom_slow");
  level waittill("sndSlowMoSnapshotOff");
  snd_set_snapshot("default");
}