/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_amb.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("pakistan_outdoor", 1);
  setambientroomtone("pakistan_outdoor", "amb_rain_exterior_2d", 0.2, 0.5);
  setambientroomreverb("pakistan_outdoor", "pakistan_outdoor", 1, 1);
  setambientroomcontext("pakistan_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("pakistan_outdoor");
  declareambientroom("pak_intro_smallroom");
  setambientroomreverb("pak_intro_smallroom", "pakistan_mediumroom", 1, 1);
  setambientroomcontext("pak_intro_smallroom", "ringoff_plr", "indoor");
  declareambientpackage("pak_intro_smallroom");
  declareambientroom("pak_intro_medroom");
  setambientroomreverb("pak_intro_medroom", "pakistan_mediumroom", 1, 1);
  setambientroomcontext("pak_intro_medroom", "ringoff_plr", "indoor");
  declareambientpackage("pak_intro_medroom");
  declareambientroom("pak_hallway");
  setambientroomreverb("pak_hallway", "pakistan_mediumroom", 1, 1);
  setambientroomcontext("pak_hallway", "ringoff_plr", "indoor");
  declareambientpackage("pak_hallway");
  declareambientroom("pak_flood_street");
  setambientroomreverb("pak_flood_street", "pakistan_hills", 1, 1);
  setambientroomcontext("pak_flood_street", "ringoff_plr", "indoor");
  declareambientpackage("pak_flood_street");
  declareambientroom("pak_flood_street_arch_sm");
  setambientroomreverb("pak_flood_street_arch_sm", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_flood_street_arch_sm", "ringoff_plr", "indoor");
  declareambientpackage("pak_flood_street_arch_sm");
  declareambientroom("pak_brick_semi_open");
  setambientroomreverb("pak_brick_semi_open", "pakistan_stoneroom", 1, 1);
  setambientroomcontext("pak_brick_semi_open", "ringoff_plr", "outdoor");
  declareambientpackage("pak_brick_semi_open");
  declareambientroom("pak_brick_closed");
  setambientroomreverb("pak_brick_closed", "pakistan_stoneroom", 1, 1);
  setambientroomcontext("pak_brick_closed", "ringoff_plr", "indoor");
  declareambientpackage("pak_brick_closed");
  declareambientroom("pak_small_concrete");
  setambientroomreverb("pak_small_concrete", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_small_concrete", "ringoff_plr", "indoor");
  declareambientpackage("pak_small_concrete");
  declareambientroom("pak_fallen_building");
  setambientroomreverb("pak_fallen_building", "pakistan_mediumroom", 1, 1);
  setambientroomcontext("pak_fallen_building", "ringoff_plr", "indoor");
  declareambientpackage("pak_fallen_building");
  declareambientroom("pak_sewer_pipe");
  setambientroomreverb("pak_sewer_pipe", "pakistan_sewerpipe", 1, 1);
  setambientroomcontext("pak_sewer_pipe", "ringoff_plr", "indoor");
  declareambientpackage("pak_sewer_pipe");
  declareambientroom("pak_sewer_room");
  setambientroomreverb("pak_sewer_room", "pakistan_sewerpipe_room", 1, 1);
  setambientroomcontext("pak_sewer_room", "ringoff_plr", "indoor");
  declareambientpackage("pak_sewer_room");
  declareambientroom("pak_sewer_brick_room");
  setambientroomreverb("pak_sewer_brick_room", "pakistan_smallroom", 1, 1);
  setambientroomcontext("pak_sewer_brick_room", "ringoff_plr", "indoor");
  declareambientpackage("pak_sewer_brick_room");
  declareambientroom("pak_sideroom");
  setambientroomreverb("pak_sideroom", "pakistan_mediumroom", 1, 1);
  setambientroomcontext("pak_sideroom", "ringoff_plr", "indoor");
  declareambientpackage("pak_sideroom");
  declaremusicstate("PAK_INTRO_MARKET");
  musicaliasloop("mus_intro_market", 0, 4);
  declaremusicstate("PAK_RIVER_FIGHT");
  musicaliasloop("mus_fighting_up_river_remix", 4, 4);
  declaremusicstate("PAK_RIVER_BUS_START");
  musicaliasloop("mus_pre_bus_stg", 0, 2);
  musicstinger("mus_bus_stg", 6, 1);
  declaremusicstate("PAK_RIVER_BUS_HIT");
  musicaliasloop("mus_fighting_up_river", 0, 3);
  musicstinger("mus_River_of_Bodies_stg", 6, 1);
  declaremusicstate("PAK_BODIES");
  musicaliasloop("null", 0, 1);
  musicstinger("mus_hide_under_bodies_stg", 10, 1);
  declaremusicstate("PAK_STEALTH_CHOPPER");
  musicaliasloop("mus_searchlights", 1, 7);
  declaremusicstate("PAK_POST_CHOPPER");
  musicaliasloop("mus_fighting_up_river", 3, 1);
  thread snd_play_loopers();
  thread snd_start_autofx_audio();
  thread bus_loop_audio();
  thread into_snd_snapshot();
  level thread snd_pov_watcher();
  level thread play_water_rush();
  level thread intro_snapshot();
  level thread sewer_lights();
  level thread splash_trigs();
  level thread waitfor_dryland();
  setsoundcontext("grass", "in_grass");
}

splash_trigs() {
  trig = getent(0, "sndSplashTrig", "targetname");
  trig thread splash_trig_think_plr();
  trig thread splash_trig_think_ai();
}

splash_trig_think_plr() {
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

splash_trig_think_ai() {
  if(!isDefined(self)) {
    return;
  }
  while(true) {
    self waittill("trigger", who);

    if(who isplayer())
      continue;
    else {
      playsound(0, "fly_npc_jump_into_water", who.origin);

      while(who istouching(self))
        wait 0.1;
    }

    wait 0.1;
  }
}

intro_snapshot() {
  level waittill("isnp");
  snd_set_snapshot("spl_pakistan_1_intro");
  playsound(0, "evt_claw_boot", (0, 0, 0));
  level waittill("isnp_f");
  snd_set_snapshot("default");
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

play_water_rush() {
  clientscripts\_audio::playloopat("amb_water_rush", (2090, 3677, 348));
  clientscripts\_audio::playloopat("amb_water_rush", (2075, 3158, 338));
  clientscripts\_audio::playloopat("amb_water_rush", (1903, 2512, 337));
  clientscripts\_audio::playloopat("amb_water_rush", (1820, 1998, 328));
  clientscripts\_audio::playloopat("amb_water_rush", (2364, 3510, 340));
  clientscripts\_audio::playloopat("amb_water_rush", (2420, 3933, 361));
}

snd_start_add_exploder_alias() {
  wait 1;
}

snd_pov_watcher() {
  while(true) {
    msg = level waittill_any_return("stfutz", "clawfutz", "drnfutz", "nofutz");

    switch (msg) {
      case "stfutz":
        setglobalfutz("spl_war_command", 1.0);
        break;
      case "clawfutz":
        setglobalfutz("spl_bigdog_pov", 1.0);
        break;
      case "drnfutz":
        setglobalfutz("spl_quad_pov", 0.6);
        break;
      case "nofutz":
        setglobalfutz("no_gfutz", 0.0);
        break;
      default:
        setglobalfutz("no_gfutz", 0.0);
        break;
    }
  }
}

snd_play_loopers() {
  clientscripts\_audio::playloopat("amb_water_int_trans_rumb", (2518, 4050, 373));
  clientscripts\_audio::playloopat("amb_water_int_trans", (2516, 4023, 353));
  clientscripts\_audio::playloopat("amb_rain_water_placed", (1591, 1102, 324));
  clientscripts\_audio::playloopat("amb_rain_water_placed", (1581, 798, 327));
  clientscripts\_audio::playloopat("amb_rain_water_placed", (1463, 584, 329));
  clientscripts\_audio::playloopat("amb_rain_water_placed", (1934, 734, 352));
  clientscripts\_audio::playloopat("amb_rain_water_placed", (1773, 321, 342));
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_pak_water_froth_pole", "amb_water_froth", 0, 0, 0, 1);
  snd_play_auto_fx("fx_water_spill_sm_splash", "amb_water_stream", 0, 0, 0, 1);
  snd_play_auto_fx("fx_insects_fly_swarm", "amb_body_flies", 0, 0, 0, 1);
  snd_play_auto_fx("fx_drain_pipes_splash", "amb_water_sewer_splash", 0, 0, 0, 1);
}

bus_loop_audio() {
  level waittill("bus_hit");
  wait 9;
  bus_loop_ent = spawn(0, (2271, 4554, 335), "script_origin");
  bus_loop_ent playloopsound("amb_water_bus_hit", 2.5);
}

into_snd_snapshot() {
  while(true) {
    level waittill("sfx_off");
    snd_set_snapshot("spl_pakistan_alloff");
    wait 0.1;
    level waittill("sfx_on");
    wait 0.1;
  }
}

sewer_lights() {
  clientscripts\_audio::playloopat("amb_light_buzz", (417, -231, 455));
  clientscripts\_audio::playloopat("amb_light_buzz", (1184, -630, 481));
  clientscripts\_audio::playloopat("amb_light_buzz", (224, -753, 435));
  clientscripts\_audio::playloopat("amb_light_buzz_sw", (2854, -6240, 616));
  clientscripts\_audio::playloopat("amb_light_flourescent_sw", (2468, -5566, 500));
  clientscripts\_audio::playloopat("amb_light_flourescent_sw", (2465, -5360, 415));
  clientscripts\_audio::playloopat("amb_light_flourescent_sw", (2345, -5121, 412));
  clientscripts\_audio::playloopat("amb_light_flourescent_sw", (2150, -5123, 416));
  clientscripts\_audio::playloopat("amb_pipe_stress_close", (2790, -6331, 564));
  clientscripts\_audio::playloopat("amb_pipe_stress_close", (1481, -6081, 309));
}