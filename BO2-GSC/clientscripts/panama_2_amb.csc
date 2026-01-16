/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_2_amb.csc
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
  declareambientroom("slums_interior_open");
  setambientroomtone("slums_interior_open", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("slums_interior_open", "panama_slums_partial", 1, 1);
  setambientroomcontext("slums_interior_open", "ringoff_plr", "outdoor");
  declareambientpackage("slums_interior_open");
  declareambientroom("slums_ally");
  setambientroomtone("slums_ally", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("slums_ally", "panama_slums_alley", 1, 1);
  setambientroomcontext("slums_ally", "ringoff_plr", "outdoor");
  declareambientpackage("slums_ally");
  declareambientroom("slums_hospital");
  setambientroomreverb("slums_hospital", "panama_mediumroom", 1, 1);
  setambientroomcontext("slums_hospital", "ringoff_plr", "indoor");
  declareambientpackage("slums_hospital");
  declareambientroom("docks_outdoor");
  setambientroomtone("docks_outdoor", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("docks_outdoor", "panama_outdoor_docks", 1, 1);
  setambientroomcontext("docks_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("docks_outdoor");
  declareambientroom("docks_warehouse");
  setambientroomtone("docks_warehouse", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("docks_warehouse", "panama_busy_room", 1, 1);
  setambientroomcontext("docks_warehouse", "ringoff_plr", "indoor");
  declareambientpackage("docks_warehouse");
  declareambientroom("docks_elevator");
  setambientroomtone("docks_elevator", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("docks_elevator", "panama_vader", 1, 1);
  setambientroomcontext("docks_elevator", "ringoff_plr", "indoor");
  declareambientpackage("docks_elevator");
  declaremusicstate("DIGBAT_SURPRISE");
  musicalias("mus_digbat_surprise", 4, 0);
  declaremusicstate("POST_DIGBAT");
  musicaliasloop("mus_post_digbat", 0, 1);
  musicstinger("mus_door_kick_stg", 0, 1);
  declaremusicstate("MAIN_FIGHT");
  musicaliasloop("null", 0, 0);
  level thread old_ambient_packages();
  level thread song_player();
  level thread setup_ambient_fx_sounds();
  level thread setup_exploder_aliases();
  level thread set_post_intro_snapshot();
}

set_post_intro_snapshot() {
  level waittill("dbid");
  snd_set_snapshot("spl_panama2_introscene");
  level waittill("drkck");
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
}

setup_exploder_aliases() {
  clientscripts\_audio::snd_add_exploder_alias(562, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(561, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(560, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(550, "fxa_pan_library_collapse");
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
}