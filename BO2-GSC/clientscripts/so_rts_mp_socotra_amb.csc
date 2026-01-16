/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\so_rts_mp_socotra_amb.csc
***************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("default", 1);
  setambientroomtone("default", "amb_battel_2d", 0.2, 0.5);
  setambientroomreverb("default", "socotra_outdoor", 1, 1);
  setambientroomcontext("default", "ringoff_plr", "outdoor");
  declareambientroom("under_bridge");
  setambientroomreverb("under_bridge", "socotra_stoneroom", 1, 1);
  setambientroomcontext("under_bridge", "ringoff_plr", "outdoor");
  declareambientroom("small_room");
  setambientroomreverb("small_room", "socotra_smallroom", 1, 1);
  setambientroomcontext("small_room", "ringoff_plr", "indoor");
  declareambientroom("small_room_partial");
  setambientroomreverb("small_room_partial", "socotra_smallroom", 1, 1);
  setambientroomcontext("small_room_partial", "ringoff_plr", "outdoor");
  declareambientroom("medium_room");
  setambientroomreverb("medium_room", "socotra_mediumroom", 1, 1);
  setambientroomcontext("medium_room", "ringoff_plr", "indoor");
  declareambientroom("medium_room_partial");
  setambientroomreverb("medium_room_partial", "socotra_mediumroom", 1, 1);
  setambientroomcontext("medium_room_partial", "ringoff_plr", "outdoor");
  declareambientroom("largeroom_room");
  setambientroomreverb("largeroom_room", "socotra_largeroom", 1, 1);
  setambientroomcontext("largeroom_room", "ringoff_plr", "indoor");
  declareambientroom("hallroom");
  setambientroomreverb("hallroom", "socotra_hallroom", 1, 1);
  setambientroomcontext("hallroom", "ringoff_plr", "indoor");
  declareambientroom("hallroom_partial");
  setambientroomreverb("hallroom_partial", "socotra_hallroom", 1, 1);
  setambientroomcontext("hallroom_partial", "ringoff_plr", "outdoor");
  declareambientroom("partialroom");
  setambientroomreverb("partialroom", "socotra_partialroom", 1, 1);
  setambientroomcontext("partialroom", "ringoff_plr", "outdoor");
  declaremusicstate("SOCOTRA_ACTION");
  musicaliasloop("mus_rts_action", 0, 3.5);
  declaremusicstate("DOCKSIDE_ACTION_NM");
  musicaliasloop("null", 0, 0);
  declaremusicstate("RTS_ACTION_END");
  musicaliasloop("null", 0, 0);
  musicalias("mus_rts_action_end", 0.0);
  level thread rts_endmenu();
}

rts_endmenu() {
  level waittill("sndEndMenu");
  snd_set_snapshot("spl_rts_endmenu");
}

snd_play_loopers() {
}