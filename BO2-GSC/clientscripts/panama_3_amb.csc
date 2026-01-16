/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_3_amb.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  declareambientroom("house_outdoor", 1);
  setambientroomtone("house_outdoor", "blk_panama_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("house_outdoor", "panama_neighborhood", 1, 1);
  setambientroomcontext("house_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("house_outdoor");
  declareambientroom("house_shed");
  setambientroomtone("house_shed", "blk_panama_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("house_shed", "panama_yard_shed", 1, 1);
  setambientroomcontext("house_shed", "ringoff_plr", "indoor");
  declareambientpackage("house_shed");
  declareambientroom("airfield_outdoor");
  setambientroomtone("airfield_outdoor", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("airfield_outdoor", "panama_airfield", 1, 1);
  setambientroomcontext("airfield_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("airfield_outdoor");
  declareambientroom("airfield_sewer");
  setambientroomtone("airfield_sewer", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("airfield_sewer", "panama_sewerpipe_sml", 1, 1);
  setambientroomcontext("airfield_sewer", "ringoff_plr", "indoor");
  declareambientpackage("airfield_sewer");
  declareambientroom("airfield_hangar_open");
  setambientroomtone("airfield_hangar_open", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hangar_open", "panama_hangar", 1, 1);
  setambientroomcontext("airfield_hangar_open", "ringoff_plr", "outdoor");
  declareambientpackage("airfield_hangar_open");
  declareambientroom("airfield_stairwell");
  setambientroomtone("airfield_stairwell", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_stairwell", "panama_stairs", 1, 1);
  setambientroomcontext("airfield_stairwell", "ringoff_plr", "indoor");
  declareambientpackage("airfield_stairwell");
  declareambientroom("airfield_hangar_room");
  setambientroomtone("airfield_hangar_room", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hangar_room", "panama_mediumroom", 1, 1);
  setambientroomcontext("airfield_hangar_room", "ringoff_plr", "indoor");
  declareambientpackage("airfield_hangar_room");
  declareambientroom("airfield_hotel");
  setambientroomtone("airfield_hotel", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hotel", "panama_mediumroom_hotel", 1, 1);
  setambientroomcontext("airfield_hotel", "ringoff_plr", "indoor");
  declareambientpackage("airfield_hotel");
  declareambientroom("slums_outdoor");
  setambientroomtone("slums_outdoor", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("slums_outdoor", "panama_slums", 1, 1);
  setambientroomcontext("slums_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("slums_outdoor");
  declareambientroom("slums_interior");
  setambientroomtone("slums_interior", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("slums_interior", "panama_slums_mediumroom", 1, 1);
  setambientroomcontext("slums_interior", "ringoff_plr", "indoor");
  declareambientpackage("slums_interior");
  declareambientroom("slums_hospital");
  setambientroomtone("slums_hospital", "amb_hospital_bg", 0.5, 0.5);
  setambientroomreverb("slums_hospital", "panama_mediumroom", 1, 1);
  setambientroomcontext("slums_hospital", "ringoff_plr", "indoor");
  declareambientpackage("slums_hospital");
  declareambientroom("slums_motel");
  setambientroomreverb("slums_motel", "panama_slums_motelroom", 1, 1);
  setambientroomcontext("slums_motel", "ringoff_plr", "indoor");
  declareambientpackage("slums_motel");
  declareambientroom("docks_outdoor");
  setambientroomreverb("docks_outdoor", "panama_outdoor_docks", 1, 1);
  setambientroomcontext("docks_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("docks_outdoor");
  declareambientroom("docks_warehouse");
  setambientroomreverb("docks_warehouse", "panama_busy_room", 1, 1);
  setambientroomcontext("docks_warehouse", "ringoff_plr", "indoor");
  declareambientpackage("docks_warehouse");
  declareambientroom("docks_elevator");
  setambientroomreverb("docks_elevator", "panama_vader", 1, 1);
  setambientroomcontext("docks_elevator", "ringoff_plr", "indoor");
  declareambientpackage("docks_elevator");
  declareambientroom("the_end");
  setambientroomtone("the_end", "amb_bg_the_end", 0.5, 0.5);
  setambientroomreverb("the_end", "panama_mediumroom", 1, 0.5);
  setambientroomcontext("the_end", "ringoff_plr", "indoor");
  declareambientpackage("the_end");
  declaremusicstate("PANAMA_HAUNTED_HOUSE");
  musicaliasloop("mus_haunted_underscore", 0, 2);
  musicstinger("mus_haunted_lady_fight", 8, 1);
  declaremusicstate("PANAMA_BACK_FIGHT");
  musicaliasloop("mus_fight_on_back", 0, 6);
  declaremusicstate("PANAMA_BACK_FIGHT_OVER");
  musicaliasloop("mus_post_lady_fight", 2, 3);
  musicstinger("mus_noriega_misbehaving", 17, 1);
  declaremusicstate("PANAMA_BAD_NORIEGA");
  musicaliasloop("mus_post_lady_fight", 3, 1);
  declaremusicstate("PANAMA_APACHE");
  musicalias("mus_apache", 0, 0, 39);
  musicaliasloop("mus_post_digbat", 1, 3);
  declaremusicstate("PANAMA_ELEVATOR");
  musicaliasloop("mus_rez_sfx", 3, 6);
  declaremusicstate("PANAMA_SNIPE");
  musicaliasloop("mus_rez_piano", 0, 1);
  musicstinger("mus_rez_prerun", 2.9, 1);
  declaremusicstate("PANAMA_RUN");
  musicalias("mus_rez_run", 0.2, 0);
  declaremusicstate("PANAMA_ENDING");
  musicalias("mus_rez_ending", 0.2, 0);
  level thread old_ambient_packages();
  level thread starting_snapshot();
  level thread song_player();
  level thread setup_ambient_fx_sounds();
  level thread setup_exploder_aliases();
  level thread snapshot_under_woods();
  level thread play_hospital_ambience();
  level thread cry_watcher();
  level thread play_woman_crying();
  level thread level_fade();
  level thread dock_amb();
}

snapshot_under_woods() {
  level waittill("lsmn");
}

starting_snapshot() {
  level waittill("lsn");
  snd_set_snapshot("spl_panama_3_horror");
  level waittill("SND_ehs");
  snd_set_snapshot("default");
}

song_player() {
  wait 2;
  playsound(0, "amb_song", (24019, -19919, 89));
}

setup_ambient_fx_sounds() {
  snd_play_auto_fx("fx_fire_column_creep_xsm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_column_creep_sm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_wall_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_ceiling_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_water_drip_light_long_noripple", "amb_water_drip_1", 0, 0, 0, 0);
  snd_play_auto_fx("fx_pan_light_overhead", "amb_light_buzz", 0, 0, 0, 0);
  snd_play_auto_fx("fx_alley_fire_ceiling", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_pan_fire_sml", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
}

setup_exploder_aliases() {
  clientscripts\_audio::snd_add_exploder_alias(562, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(561, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(560, "wpn_grenade_explode");
}

old_ambient_packages() {
  declareambientroom("outdoor");
  setambientroomtone("outdoor", "blk_panama_outdoor_bg", 0.5, 0.5);
  setambientroomreverb("outdoor", "panama_city", 1, 1);
  setambientroomcontext("outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("outdoor");
  declareambientroom("indoor");
  setambientroomtone("indoor", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("indoor", "panama_mediumroom", 1, 1);
  setambientroomcontext("indoor", "ringoff_plr", "indoor");
  declareambientpackage("indoor");
  declareambientroom("battle");
  setambientroomtone("battle", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("battle", "panama_city", 1, 1);
  setambientroomcontext("battle", "ringoff_plr", "outdoor");
  declareambientpackage("battle");
  declareambientroom("stairwell");
  setambientroomtone("stairwell", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("stairwell", "panama_cave", 1, 1);
  setambientroomcontext("stairwell", "ringoff_plr", "indoor");
  declareambientroom("hangar");
  setambientroomtone("hangar", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("hangar", "panama_hangar", 1, 1);
  setambientroomcontext("hangar", "ringoff_plr", "indoor");
  declareambientroom("small_room");
  setambientroomtone("small_room", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("small_room", "panama_smallroom", 1, 1);
  setambientroomcontext("small_room", "ringoff_plr", "indoor");
  declareambientroom("medium_room");
  setambientroomtone("medium_room", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("medium_room", "panama_mediumroom", 1, 1);
  setambientroomcontext("medium_room", "ringoff_plr", "indoor");
  declareambientroom("large_room");
  setambientroomtone("large_room", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("large_room", "panama_largeroom", 1, 1);
  setambientroomcontext("large_room", "ringoff_plr", "indoor");
  level thread end_anim_snapshot();
}

play_hospital_ambience() {
  playloopat("amb_light_buzz_hospital", (25099, 34756, 655));
  playloopat("amb_light_buzz_hospital", (24984, 35181, 712));
  playloopat("amb_light_buzz_hospital", (24537, 35046, 709));
  playloopat("amb_light_buzz_hospital", (24216, 34945, 714));
  playloopat("amb_light_buzz_hospital", (23493, 34939, 713));
  playloopat("amb_light_buzz_hospital", (23491, 35186, 714));
}

cry_watcher() {
  level waittill("pab");
  level notify("kill_cry");
}

play_woman_crying() {
  level endon("kill_cry");

  while(true) {
    playsound(0, "amb_crying_woman", (24226, 35097, 606));
    wait(randomintrange(4, 8));
  }
}

level_fade() {
  level waittill("sound_fade_out");
  snd_set_snapshot("spl_panama3_fade");
}

pre_end_snapshot() {
  snd_set_snapshot("spl_panama_3_pre_theend");
}

end_anim_snapshot() {
  level waittill("sndTheEnd");
  snd_set_snapshot("spl_panama_3_theend");
}

dock_amb() {
  playloopat("amb_flourescent_light", (51911, -31576, 1292));
  playloopat("amb_flourescent_light", (51848, -31290, 1290));
  playloopat("amb_idle_truck_1", (52231, -27330, 525));
  playloopat("amb_idle_truck_1", (52510, -26950, 516));
  playloopat("amb_idle_truck_2", (52351, -27080, 510));
  playloopat("amb_dock_light", (52628, -27786, 834));
}