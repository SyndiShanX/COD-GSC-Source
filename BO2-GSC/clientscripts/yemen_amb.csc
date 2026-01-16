/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\yemen_amb.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  snd_set_snapshot("spl_yemen_fade_in");
  declareambientroom("desert_outside", 1);
  setambientroomtone("desert_outside", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("desert_outside", "spl_yemen_hills", 1, 1);
  setambientroomcontext("desert_outside", "ringoff_plr", "outdoor");
  declareambientpackage("desert_outside");
  addambientelement("desert_outside", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("desert_outside", "exp_very_distant", 0, 1, 1500, 4000);
  addambientelement("desert_outside", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("hills_outside");
  setambientroomtone("hills_outside", "blk_desert_wind_bg", 0.5, 0.5);
  setambientroomreverb("hills_outside", "spl_yemen_hills", 1, 1);
  setambientroomcontext("hills_outside", "ringoff_plr", "outdoor");
  declareambientpackage("hills_outside");
  addambientelement("hills_outside", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("hills_outside", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("hills_outside", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("open_air_enclosure");
  setambientroomtone("open_air_enclosure", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("open_air_enclosure", "spl_yemen_open", 1, 1);
  setambientroomcontext("open_air_enclosure", "ringoff_plr", "outdoor");
  declareambientpackage("open_air_enclosure");
  addambientelement("open_air_enclosure", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("open_air_enclosure", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("open_air_enclosure", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("stone_room_intro");
  setambientroomreverb("stone_room_intro", "spl_yemen_stone_intro", 1, 1);
  setambientroomcontext("stone_room_intro", "ringoff_plr", "indoor");
  declareambientpackage("stone_room_intro");
  declareambientroom("entry_intro");
  setambientroomreverb("entry_intro", "spl_yemen_entry_intro", 1, 1);
  setambientroomcontext("entry_intro", "ringoff_plr", "indoor");
  declareambientpackage("entry_intro");
  declareambientroom("courtyard_intro");
  setambientroomreverb("courtyard_intro", "spl_yemen_hills", 1, 1);
  setambientroomcontext("courtyard_intro", "ringoff_plr", "outdoor");
  declareambientpackage("courtyard_intro");
  addambientelement("courtyard_intro", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("courtyard_intro", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("courtyard_intro", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("partial_room");
  setambientroomreverb("partial_room", "spl_yemen_partial", 1, 1);
  setambientroomcontext("partial_room", "ringoff_plr", "outdoor");
  declareambientpackage("partial_room");
  addambientelement("partial_room", "exp_very_distant", 2, 6, 1500, 6000);
  addambientelement("partial_room", "exp_very_distant", 2, 6, 1500, 6000);
  addambientelement("partial_room", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("large_room");
  setambientroomreverb("large_room", "spl_yemen_largeroom", 1, 1);
  setambientroomcontext("large_room", "ringoff_plr", "indoor");
  declareambientpackage("large_room");
  addambientelement("large_room", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("large_room", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("large_room", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("stone_room_large");
  setambientroomtone("stone_room_large", "blk_tunnel_wind_bg", 0.5, 0.5);
  setambientroomreverb("stone_room_large", "spl_yemen_stoneroom_lg", 1, 1);
  setambientroomcontext("stone_room_large", "ringoff_plr", "indoor");
  declareambientpackage("stone_room_large");
  addambientelement("stone_room_large", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("stone_room_large", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("stone_room_large", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("bunker_tunnel");
  setambientroomtone("bunker_tunnel", "blk_tunnel_wind_bg", 0.5, 0.5);
  setambientroomreverb("bunker_tunnel", "spl_yemen_cave", 1, 1);
  setambientroomcontext("bunker_tunnel", "ringoff_plr", "indoor");
  declareambientpackage("bunker_tunnel");
  addambientelement("bunker_tunnel", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("bunker_tunnel", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("bunker_tunnel", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("bunker_room");
  setambientroomtone("bunker_room", "blk_bunker_room_bg", 0.5, 0.5);
  setambientroomreverb("bunker_room", "spl_yemen_bunker", 1, 1);
  setambientroomcontext("bunker_room", "ringoff_plr", "indoor");
  declareambientpackage("bunker_room");
  addambientelement("bunker_room", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("bunker_room", "exp_very_distant", 0, 1, 1500, 6000);
  addambientelement("bunker_room", "exp_very_distant", 2, 4, 2000, 6000);
  declareambientroom("numbers");
  setambientroomtone("numbers", "evt_numbers_amb_trippy", 1, 0.25);
  setambientroomreverb("numbers", "spl_yemen_numbers", 1, 1);
  setambientroomcontext("numbers", "ringoff_plr", "indoor");
  declareambientpackage("numbers");
  addambientelement("numbers", "evt_numbers_small", 0.25, 2, 25, 250);
  addambientelement("numbers", "evt_numbers_large", 2, 15, 150, 500);
  addambientelement("numbers", "evt_numbers_large_flux", 5, 15, 250, 500);
  declareambientroom("farid_ground");
  setambientroomtone("farid_ground", "evt_farid_shot_ground_1", 2, 0.75);
  setambientroomreverb("farid_ground", "rage_long", 1, 1);
  setambientroomsnapshot("farid_ground", "spl_yemen_farid_dying");
  declareambientpackage("farid_ground");
  declareambientroom("stone_room");
  setambientroomreverb("stone_room", "spl_yemen_stoneroom", 1, 1);
  setambientroomcontext("stone_room", "ringoff_plr", "indoor");
  declareambientpackage("stone_room");
  declareambientroom("medium_room");
  setambientroomreverb("medium_room", "spl_yemen_mediumroom", 1, 1);
  setambientroomcontext("medium_room", "ringoff_plr", "indoor");
  declareambientpackage("medium_room");
  declareambientroom("small_room");
  setambientroomreverb("small_room", "spl_yemen_smallroom", 1, 1);
  setambientroomcontext("small_room", "ringoff_plr", "indoor");
  declareambientpackage("small_room");
  declareambientroom("osprey");
  setambientroomreverb("osprey", "spl_yemen_stoneroom_lg", 1, 1);
  setambientroomcontext("osprey", "ringoff_plr", "indoor");
  declareambientpackage("osprey");
  declaremusicstate("YEMEN_INTRO");
  musicaliasloop("mus_yemen_intro", 0, 0.5);
  declaremusicstate("YEMEN_FIRST_DOOR");
  musicaliasloop("mus_yemen_march", 0, 2);
  musicstinger("mus_yemen_rally", 36, 1);
  declaremusicstate("YEMEN_DOOR_OPENED");
  musicaliasloop("mus_yemen_farid_battle", 2, 2);
  musicstinger("mus_morals_surprise_stg", 4, 1);
  declaremusicstate("YEMEN_SURPRISE_MENENDEZ");
  musicaliasloop("mus_yemen_surprise_menendez", 0, 4);
  declaremusicstate("YEMEN_HARPER_DECISION");
  musicalias("mus_yemen_harper_decision", 1, 0);
  declaremusicstate("YEMEN_HARPER_FARID_DIED");
  musicalias("null", 0, 0);
  declaremusicstate("YEMEN_HARPER_HARPER_DIED");
  musicalias("mus_yemen_harper_dead", 0, 4);
  declaremusicstate("YEMEN_MASON_INBOUND");
  musicaliasloop("mus_yemen_mason_inbound", 0, 5);
  declaremusicstate("YEMEN_MASON_ARRIVES");
  musicalias("mus_yemen_mason_arrives", 0);
  musicwaittilldone();
  declaremusicstate("YEMEN_MASON_KICKS_ASS");
  musicaliasloop("mus_yemen_mason_battle_loop", 0, 5);
  musicstinger("mus_yemen_mason_battle_loop_STG", 6, 1);
  declaremusicstate("YEMEN_SNIPER");
  musicaliasloop("mus_sniper", 2, 5);
  declaremusicstate("YEMEN_SNIPER_END");
  musicalias("mus_sniper_end", 0);
  setsoundcontext("f35", "exterior");
  thread snd_fx_create();
  thread blend_desert_tunnel();
  thread activate_numbers_audio();
  thread slomo_context_wait();
  thread snd_start_autofx_audio();
  thread canyonwind();
  thread crowdswell();
  thread set_osprey_context_ext();
  thread set_osprey_context_int();
  thread snapshot_check();
  thread snd_set_low_ambience_snapshot();
  thread snd_set_default_snapshot();
  thread set_morals_snapshot();
  thread snd_set_intro_snapshot();
  thread spawn_fake_battle_lines();
  thread set_morals_3p_fire_snap();
}

snapshot_check() {
  level endon("intr_on");
  wait 3;
  snd_set_snapshot("default");
}

torch_sounds() {
  playloopat("amb_fire_torch", (-43, 2207, 69));
  playloopat("amb_fire_torch", (-40, 2012, 69));
  playloopat("amb_fire_torch", (-1036, 1565, 71));
  playloopat("amb_fire_torch", (-1037, 1376, 66));
}

canyonwind() {
  level notify("snd_canyon_wind_start");
  level waittill("snd_canyon_wind");
  level notify("snd_canyon_wind_start");
}

crowdswell() {
  crowd_close_ent = spawn(0, (18, 2103, 57), "script_origin");
  crowd_close_ent thread transition_sounds();
  level waittill("snd_swell_start");
  playsound(0, "evt_door_open_squeak", (18, 2103, 57));
  playsound(0, "evt_yem_crowd_door", (517, 1480, 73));
  crowd_sounds_ent = spawn(0, (517, 1481, 73), "script_origin");
  crowd_sounds_ent thread speech_end_sound();
  level notify("snd_crowd_chant");
}

speech_end_sound() {
  self playloopsound("evt_yem_crowd_murmer");
  level waittill("speech_done");
  self stoploopsound(1);
  playsound(0, "evt_yem_panic_2", self.origin);
  wait 1;
  self delete();
}

transition_sounds() {
  self playloopsound("amb_crowd_walla_close");
  level waittill("snd_swell_start");
  wait 3;
  self stoploopsound(2);
  wait 2;
  self delete();
}

snd_start_autofx_audio() {
  snd_play_auto_fx("fx_fireplace01", "amb_fireplace", 0, 0, 0, 0);
  snd_play_auto_fx("fx_insects_fly_swarm", "amb_insects", 0, 0, 0, 0);
  snd_play_auto_fx("fx_seagulls_circle_overhead", "amb_seagull", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_leaves_blow01", "amb_wind_tree", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_leaves_blow02", "amb_wind_tree", 0, 0, 0, 0);
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_burningdrone01", "amb_fire_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_burningfoliage01", "amb_fire_foliage", 0, 0, 0, 0);
  snd_play_auto_fx("fx_fire_line_xsm_thin", "amb_fire_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_smokeflare01", "amb_flare", 0, 0, 0, 1);
  snd_play_auto_fx("fx_yemen_burningfoliage_custom01", "amb_fire_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_firetorch01", "amb_fire_torch", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yemen_burningdrone02", "amb_fire_sm", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yem_fire_detail", "amb_fire_md", 0, 0, 0, 0);
  snd_play_auto_fx("fx_yem_fire_column_lg", "amb_fire_metal", 0, 0, 0, 0, 250, 1, "amb_fire_metal");
  snd_play_auto_fx("fx_yem_vfire_car_compact", "amb_fire_metal", 0, 0, 0, 0, 250, 1, "amb_fire_metal");
  snd_play_auto_fx("fx_vfire_t6_civ_car_compact", "amb_fire_metal", 0, 0, 0, 0, 250, 1, "amb_fire_metal");
}

snd_create_randoms() {
  create_sound_random((-12638, -14318, 1527), "amb_wind_sand_metal", 5, 13);
  create_sound_random((-12905, -14386, 1599), "amb_wind_sand_metal", 5, 13);
  create_sound_random((-12485, -14542, 1560), "amb_wind_sand_metal", 5, 13);
  create_sound_random((-12713, -14782, 1559), "amb_wind_sand_metal", 5, 13);
}

snd_fx_create() {
  wait 1;
  clientscripts\_audio::snd_add_exploder_alias(330, "exp_yem_timeslow_canned_explo");
  clientscripts\_audio::snd_add_exploder_alias(331, "exp_yem_timeslow_exp");
  clientscripts\_audio::snd_add_exploder_alias(332, "exp_yem_timeslow_exp");
  clientscripts\_audio::snd_add_exploder_alias(333, "exp_yem_timeslow_exp");
  clientscripts\_audio::snd_add_exploder_alias(334, "exp_yem_timeslow_exp");
  clientscripts\_audio::snd_add_exploder_alias(760, "fxa_post_bridge_bldg");
}

blend_desert_tunnel() {
  playloopat("blk_blend", (15104, -10119, -32));
}

activate_numbers_audio() {
  level endon("ensc");
  level waittill("snsc");
  level thread cleanup_numbers_audio();
  activateambientpackage(0, "numbers", 100);
  activateambientroom(0, "numbers", 100);
  level notify("updateActiveAmbientPackage");
  level notify("updateActiveAmbientRoom");

  for(num = 1; 1; num++) {
    playsound(0, "evt_numbers_heartbeat_loud", (0, 0, 0));

    if(num == 2) {
      num = 0;
      playsound(0, "evt_numbers_breath_cold", (0, 0, 0));
    }

    wait 1.5;
  }
}

cleanup_numbers_audio() {
  level waittill("ensc");
  deactivateambientpackage(0, "numbers", 100);
  deactivateambientroom(0, "numbers", 100);
}

slomo_context_wait() {
  level waittill("slomo_on");
  setsoundcontext("f35", "interior");
  level waittill("slomo_off");
  setsoundcontext("f35", "exterior");
}

set_osprey_context_ext() {
  waitforclient(0);
  setsoundcontext("f35", "exterior");
}

set_osprey_context_int() {
  level waittill("inside_osprey");
  osp_ent = spawn(0, (0, 0, 0), "script_origin");
  setsoundcontext("f35", "interior");
  osp_ent playloopsound("veh_osp_interior", 0.5);
  level waittill("osprey_done");
  setsoundcontext("f35", "exterior");
  player = getlocalplayers()[0];
  fade_ent = spawn(0, player.origin, "script_origin");
  wait 1;
  fade_ent playsound(0, "veh_osp_fade");
  wait 1;
  osp_ent stoploopsound(2);
  wait 5;
  osp_ent delete();
  fade_ent delete();
}

snd_set_intro_snapshot() {
  level waittill("yem_start");
  wait 1.5;
  snd_set_snapshot("spl_yemen_intro");
}

snd_set_low_ambience_snapshot() {
  while(true) {
    level waittill("mbs");
    snd_set_snapshot("cmn_low_ambience");
  }
}

snd_set_default_snapshot() {
  while(true) {
    level waittill("mbss");
    snd_set_snapshot("default");
  }
}

set_morals_snapshot() {
  level waittill("morals");
  snd_set_snapshot("spl_yemen_morals");
}

set_morals_3p_fire_snap() {
  level waittill("vtol_snap");
  snd_set_snapshot("spl_yemen_low_3p_fire");
}

spawn_fake_battle_lines() {
  level waittill("sle");
  soundlineemitter("amb_canned_battle_script_l", (2134, -123, 709), (2028, -3837, 491));
  soundlineemitter("amb_canned_battle_script_r", (-1569, -1136, 472), (-488, -4767, 592));
}

farid_shot_duck() {
  snd_set_snapshot("spl_yemen_farid_shot");
  level notify("shot_notify");
}

farid_shot_room_change() {
  activateambientpackage(0, "farid_ground", 100);
  activateambientroom(0, "farid_ground", 100);
  playsound(0, "evt_farid_shot_sting", (0, 0, 0));
  level waittill("shot_notify");
  deactivateambientpackage(0, "farid_ground", 100);
  deactivateambientroom(0, "farid_ground", 100);
}

sndstartendsnapshot() {
  snd_set_snapshot("spl_yemen_captured");
  level waittill("sndVerb");
  activateambientroom(0, "osprey", 50);
  activateambientpackage(0, "osprey", 50);
}