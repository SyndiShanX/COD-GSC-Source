/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_2_amb.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_audio;

main() {
  declareambientroom("karma_entrance_roof");
  setambientroomtone("karma_entrance_roof", "blk_karma_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_roof", "karma_roof", 1, 1);
  setambientroomcontext("karma_entrance_roof", "ringoff_plr", "outdoor");
  declareambientpackage("karma_entrance_roof");
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
  setambientroomtone("karma_entrance_elevator", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_entrance_elevator", "karma_vader", 1, 1);
  setambientroomcontext("karma_entrance_elevator", "ringoff_plr", "indoor");
  declareambientpackage("karma_entrance_elevator");
  declareambientroom("karma_lobby_covered");
  setambientroomtone("karma_lobby_covered", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_lobby_covered", "karma_lobby", 1, 1);
  setambientroomcontext("karma_lobby_covered", "ringoff_plr", "outdoor");
  declareambientpackage("karma_lobby_covered");
  declareambientroom("karma_lobby_uncovered");
  setambientroomtone("karma_lobby_uncovered", "blk_karma_lobby_bg", 0.5, 0.5);
  setambientroomreverb("karma_lobby_uncovered", "karma_lobby", 1, 1);
  setambientroomcontext("karma_lobby_uncovered", "ringoff_plr", "outdoor");
  declareambientpackage("karma_lobby_uncovered");
  declareambientroom("karma_lobby_elevator_area");
  setambientroomtone("karma_lobby_elevator_area", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_lobby_elevator_area", "karma_elevator_area", 1, 1);
  setambientroomcontext("karma_lobby_elevator_area", "ringoff_plr", "indoor");
  declareambientpackage("karma_lobby_elevator_area");
  declareambientroom("karma_elshaft_elevator");
  setambientroomtone("karma_elshaft_elevator", "blk_karma_hall_bg", 0.5, 0.5);
  setambientroomreverb("karma_elshaft_elevator", "karma_vader", 1, 1);
  setambientroomcontext("karma_elshaft_elevator", "ringoff_plr", "indoor");
  declareambientpackage("karma_elshaft_elevator");
  declareambientroom("karma_elshaft_shaft");
  setambientroomtone("karma_elshaft_shaft", "blk_karma_vent_bg", 0.5, 0.5);
  setambientroomreverb("karma_elshaft_shaft", "karma_shaft", 1, 1);
  setambientroomcontext("karma_elshaft_shaft", "ringoff_plr", "indoor");
  declareambientpackage("karma_elshaft_shaft");
  declareambientroom("karma_construct_med");
  setambientroomtone("karma_construct_med", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_construct_med", "karma_construct_site", 1, 1);
  setambientroomcontext("karma_construct_med", "ringoff_plr", "indoor");
  declareambientpackage("karma_construct_med");
  declareambientroom("karma_construct_sml");
  setambientroomtone("karma_construct_sml", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_construct_sml", "karma_construct_site_sml", 1, 1);
  setambientroomcontext("karma_construct_sml", "ringoff_plr", "indoor");
  declareambientpackage("karma_construct_sml");
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
  declareambientroom("karma_cic_main");
  setambientroomtone("karma_cic_main", "blk_karma_office_bg", 0.5, 0.5);
  setambientroomreverb("karma_cic_main", "karma_comproom_lg", 1, 1);
  setambientroomcontext("karma_cic_main", "ringoff_plr", "indoor");
  declareambientpackage("karma_cic_main");
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
  setambientroomreverb("karma_solar_club", "karma_mediumroom", 1, 1);
  setambientroomcontext("karma_solar_club", "ringoff_plr", "indoor");
  declareambientpackage("karma_solar_club");
  declareambientroom("karma_final_room_med");
  setambientroomtone("karma_final_room_med", "amb_mall_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_med", "karma_mediumroom", 1, 1);
  setambientroomcontext("karma_final_room_med", "ringoff_plr", "indoor");
  declareambientpackage("karma_final_room_med");
  declareambientroom("karma_final_room_partial");
  setambientroomtone("karma_final_room_partial", "amb_mall_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_partial", "karma_partial", 1, 1);
  setambientroomcontext("karma_final_room_partial", "ringoff_plr", "indoor");
  declareambientpackage("karma_final_room_partial");
  declareambientroom("karma_final_room_atrium");
  setambientroomtone("karma_final_room_atrium", "amb_mall_bg", 0.5, 0.5);
  setambientroomreverb("karma_final_room_atrium", "karma_artium_huge", 1, 1);
  setambientroomcontext("karma_final_room_atrium", "ringoff_plr", "indoor");
  declareambientpackage("karma_final_room_atrium");
  declareambientroom("karma_poolroom_over");
  setambientroomtone("karma_poolroom_over", "blk_karma_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("karma_poolroom_over", "karma_pool_area", 1, 1);
  setambientroomcontext("karma_poolroom_over", "ringoff_plr", "outdoor");
  declareambientpackage("karma_poolroom_over");
  declareambientroom("karma_security_room");
  setambientroomreverb("karma_security_room", "karma_security", 1, 1);
  setambientroomcontext("karma_security_room", "ringoff_plr", "indoor");
  declareambientpackage("karma_security_room");
  declareambientroom("outdoor", 1);
  setambientroomtone("outdoor", "blk_karma_pool_bg", 0.5, 0.5);
  setambientroomreverb("outdoor", "karma_city", 1, 1);
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declaremusicstate("KARMA_POST_MALL");
  musicalias("mus_karma_post_mall_intro", 0, 0, 0.7);
  musicaliasloop("mus_karma_post_mall", 1, 1);
  musicstinger("mus_karma_post_mall_stg", 1, 1);
  declaremusicstate("KARMA_DEFALCO_DEAD");
  musicaliasloop("mus_karma_defalco_dead", 2, 3);
  declaremusicstate("KARMA_DEFALCO_ESCAPED");
  musicaliasloop("mus_karma_karma_dead", 1, 3);
  level thread playmallmusic();
  thread snd_fx_create();
  thread setup_ambient_fx_sounds();
  thread play_aquarium_breach();
  thread play_door_bang();
  thread door_watcher();
  thread end_low_vehicle();
  thread end_slowmo();
  thread atrium_alarms();
  thread splash_trigs();
  level thread waitfor_dryland();
  setsoundcontext("grass", "in_grass");
}

waitfor_dryland() {
  level waittill("aS_on");
  level endon("aS_off");
  level thread turn_off_waitfordryland();
  player = getlocalplayers()[0];

  while(true) {
    if(!player._audioswim_dryland) {
      setsoundcontext("grass", "in_grass");
      player waittill("aS_dryland");
    } else {
      setsoundcontext("grass", "no_grass");
      player waittill("aS_wetland");
    }

    wait 0.25;
  }
}

turn_off_waitfordryland() {
  level waittill("aS_off");
  setsoundcontext("grass", "no_grass");
}

splash_trigs() {
  array_thread(getentarray(0, "sndSplashTrig", "targetname"), ::splash_trigs_think);
}

splash_trigs_think() {
  if(!isDefined(self)) {
    return;
  }
  while(true) {
    self waittill("trigger", who);

    if(who isplayer()) {
      playsound(0, "fly_player_jump_into_water", who.origin);

      while(who istouching(self))
        wait 0.1;
    }

    wait 0.1;
  }
}

playmallmusic() {
  playloopat("amb_karma_fire", (392, -7933, -2701));
  playloopat("amb_karma_pa_music", (-1469, -4290, -2012));
  playloopat("blk_mus_club_lowend", (1843, -8346, -2584));
}

door_watcher() {
  level waittill("pod");
  level notify("end_bang");
}

play_door_bang() {
  level endon("end_bang");

  while(true) {
    wait(randomfloatrange(2, 4));
    playsound(0, "amb_door_banging", (-2572, -2528, -2828));
  }
}

wait_to_start_club_crowd() {
  level waittill("scle");
  struct = getstruct("blk_mus_club", "targetname");
  ent1 = spawn(0, struct.origin, "script_origin");
  ent1 playloopsound("blk_karma_club_bg", 2);
  level waittill("scm2");
  ent1 stoploopsound(1);
  wait 2;
  ent1 delete();
}

end_low_vehicle() {
  level waittill("setLOV");
  snd_set_snapshot("spl_karma_2_end_lowvehicle");
}

end_slowmo() {
  level waittill("stSLO");
  snd_set_snapshot("spl_karma_2_end_slowmo");
  level waittill("endSLO");
  snd_set_snapshot("spl_karma_2_end_lowvehicle_nfd");
}

snd_fx_create() {
  waitforclient(0);
  clientscripts\_audio::snd_add_exploder_alias(913, "exp_metalstorm_explode");
  clientscripts\_audio::snd_add_exploder_alias(914, "exp_metalstorm_explode");
  clientscripts\_audio::snd_add_exploder_alias(915, "exp_metalstorm_explode");
  clientscripts\_audio::snd_add_exploder_alias(844, "exp_veh_large");
  clientscripts\_audio::snd_add_exploder_alias(845, "exp_veh_large");
  clientscripts\_audio::snd_add_exploder_alias(799, "exp_veh_large");
}

setup_ambient_fx_sounds() {
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm_line", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_fuel_sm_ground", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_medium", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_sm_smolder", "amb_fire_small", 0, 0, 0, 0, 200, 2, "amb_fire_medium");
  snd_play_auto_fx("fx_fire_md_smolder", "amb_fire_medium", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_water_fire_sprinkler", "amb_fire_sprinkler", 10, 0, 0, 1);
  snd_play_auto_fx("fx_waterfall_splash1", "amb_water_fall", 10, 0, 0, 1);
  snd_play_auto_fx("fx_waterfall_splash2", "amb_waterfall_splash", 10, 0, 0, 1);
}

play_aquarium_breach() {
  level waittill("aqb");
  playloopat("amb_water_gush", (-1026, -2857, -2679));
  playloopat("amb_water_gush", (-1271, -2682, -2690));
  playloopat("amb_water_gush", (-1668, -2297, -2700));
}

atrium_alarms() {
  playloopat("amb_bell_alarm", (-3232, -2067, -2506));
  playloopat("amb_fire_alarm", (-3360, -2725, -2662));
  playloopat("amb_store_alarm", (-3886, -2439, -2737));
  playloopat("amb_weird_alarm", (-3275, -855, -2634));
  playloopat("amb_fire_alarm", (-1629, -665, -2833));
  playloopat("amb_bell_alarm", (-2826, 2008, -2755));
  playloopat("amb_fire_alarm", (-937, 2293, -2771));
  playloopat("amb_weird_alarm", (-1675, 2157, -2793));
  playloopat("amb_fire_alarm", (-58, -587, -2897));
  playloopat("amb_store_alarm", (303, 2480, -3025));
  playloopat("amb_store_alarm", (2337, 2212, -3022));
  playloopat("amb_weird_alarm", (940, 3361, -2877));
  playloopat("amb_bell_alarm", (4028, 4653, -2595));
  playloopat("amb_fire_alarm", (1747, 5249, -2748));
  playloopat("amb_bell_alarm", (1299, 5850, -2866));
  playloopat("amb_store_alarm", (2949, 7730, -2821));
  playloopat("amb_weird_alarm", (1156, 7568, -2796));
  playloopat("amb_fire_alarm", (1156, 7568, -2796));
}

sndplayfakeciv() {
  wait 1.2;
  playsound(0, "vox_civ_cm3_crawl_1", (711, -8224, -2684));
  wait 12;
  playsound(0, "vox_civ_cm3_crawl_2", (711, -8224, -2684));
}