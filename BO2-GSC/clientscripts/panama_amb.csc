/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_amb.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  declareambientroom("house_outdoor", 1);
  setambientroomtone("house_outdoor", "amb_cricket_blend", 1, 1);
  setambientroomreverb("house_outdoor", "panama_neighborhood", 1, 1);
  setambientroomcontext("house_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("house_outdoor");
  declareambientroom("house_shed");
  setambientroomtone("house_shed", "amb_cricket_blend", 1, 1);
  setambientroomreverb("house_shed", "panama_yard_shed", 1, 1);
  setambientroomcontext("house_shed", "ringoff_plr", "outdoor");
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
  declareambientroom("airfield_hangar_large_room");
  setambientroomtone("airfield_hangar_large_room", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hangar_large_room", "panama_hangar_largeroom", 1, 1);
  setambientroomcontext("airfield_hangar_large_room", "ringoff_plr", "indoor");
  declareambientpackage("airfield_hangar_large_room");
  declareambientroom("airfield_hotel");
  setambientroomtone("airfield_hotel", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hotel", "panama_mediumroom_hotel", 1, 1);
  setambientroomcontext("airfield_hotel", "ringoff_plr", "indoor");
  declareambientpackage("airfield_hotel");
  declareambientroom("airfield_hotel_gaurd_rm");
  setambientroomtone("airfield_hotel_gaurd_rm", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("airfield_hotel_gaurd_rm", "panama_mediumroom_hotel", 1, 1);
  setambientroomcontext("airfield_hotel_gaurd_rm", "ringoff_plr", "indoor");
  declareambientpackage("airfield_hotel_gaurd_rm");
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
  declareambientroom("slums_motel");
  setambientroomtone("slums_motel", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("slums_motel", "panama_slums_motelroom", 1, 1);
  setambientroomcontext("slums_motel", "ringoff_plr", "indoor");
  declareambientpackage("slums_motel");
  declareambientroom("docks_outdoor");
  setambientroomtone("docks_outdoor", "blk_panama_battle_bg", 0.5, 0.5);
  setambientroomreverb("docks_outdoor", "panama_outdoor_docks", 1, 1);
  setambientroomcontext("docks_outdoor", "ringoff_plr", "outdoor");
  declareambientpackage("docks_outdoor");
  declareambientroom("docks_shipping_container");
  setambientroomtone("docks_shipping_container", "blk_panama_indoor_bg", 0.5, 0.5);
  setambientroomreverb("docks_shipping_container", "panama_container", 1, 1);
  setambientroomcontext("docks_shipping_container", "ringoff_plr", "indoor");
  declareambientpackage("docks_shipping_container");
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
  declaremusicstate("PANAMA_INTRO");
  musicaliasloop("mus_intro_pad_loop", 2, 0.5);
  musicstinger("mus_intro_pad_STG", 0, 1);
  declaremusicstate("PANAMA_GATE_OPENED");
  musicaliasloop("null", 0, 0);
  declaremusicstate("PANAMA_ZODIAK");
  musicaliasloop("mus_zodiac", 0, 2);
  declaremusicstate("PANAMA_BEACH");
  musicaliasloop("mus_stealth_in", 0, 0);
  musicstinger("mus_knife_kill_STG", 0, 1);
  declaremusicstate("PANAMA_CONTEXT_GO");
  musicaliasloop("null", 0, 0);
  declaremusicstate("PANAMA_PRE_HANGAR_FIGHT");
  musicaliasloop("mus_fight_to_hangar_loop", 0, 6);
  musicstinger("mus_context_kill_STG", 1, 1);
  declaremusicstate("PANAMA_AT_HANGAR");
  musicaliasloop("mus_airport_meeting", 3, 2);
  declaremusicstate("PANAMA_ROOFTOPS");
  musicaliasloop("mus_rooftops", 0, 3);
  declaremusicstate("PANAMA_HOTEL_RUN");
  musicaliasloop("mus_hotel_run", 2, 2);
  musicstinger("mus_noriega_breakin", 30, 1);
  declaremusicstate("PANAMA_NORIEGA");
  musicaliasloop("mus_intro_pad_loop", 0, 2);
  level thread song_player();
  level thread setup_ambient_fx_sounds();
  level thread setup_exploder_aliases();
  level thread motel_snapshot();
  level thread zodiac_underwater_snapshot();
  level thread grill_fire();
  level thread intro_footstep_setup();
  level thread base_footstep_return();
}

intro_footstep_setup() {
  level waittill("sscig");
  setsoundcontext("grass", "in_grass");
}

base_footstep_return() {
  level waittill("sscng");
  setsoundcontext("grass", "no_grass");
}

song_player() {
  wait 2;
  playsound(0, "amb_song", (24019, -19919, 89));
}

grill_fire() {
  playloopat("amb_grill_fire", (23757, -19198, 32));
}

setup_ambient_fx_sounds() {
  snd_play_auto_fx("fx_fire_column_creep_xsm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_column_creep_sm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_wall_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_ceiling_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_medium", 0, 0, 0, 0, 200, 2, "amb_fire_large");
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_large", 0, 0, 0, 0, 200, 3, "amb_fire_large");
  snd_play_auto_fx("fx_pan_light_overhead", "amb_street_light_buzz", 0, 0, 0, 0);
  snd_play_auto_fx("fx_pan_streetlight_flicker_glow", "amb_street_light_flicker", 0, 0, 0, 0);
}

setup_exploder_aliases() {
  clientscripts\_audio::snd_add_exploder_alias(250, "fxa_condo_explo");
  clientscripts\_audio::snd_add_exploder_alias(562, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(561, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(560, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(298, "evt_guards_flare_explode");
  clientscripts\_audio::snd_add_exploder_alias(102, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(103, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(104, "wpn_grenade_explode");
  clientscripts\_audio::snd_add_exploder_alias(105, "wpn_grenade_explode");
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

motel_snapshot() {
  level waittill("mute_amb");
  wait 4;
  snd_set_snapshot("spl_panama_1_motel");
}

zodiac_underwater_snapshot() {
  level waittill("underwater_on");
  snd_set_snapshot("spl_panama_underwater");
  level waittill("underwater_off");
  snd_set_snapshot("default");
}