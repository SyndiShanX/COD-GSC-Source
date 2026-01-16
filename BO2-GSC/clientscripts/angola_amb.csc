/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\angola_amb.csc
****************************************/

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
  declareambientroom("riverbed");
  setambientroomreverb("riverbed", "angola_riverbed", 1, 1);
  setambientroomcontext("riverbed", "ringoff_plr", "outdoor");
  declareambientpackage("riverbed");
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
  declareambientroom("container");
  setambientroomreverb("container", "angola_container", 1, 1);
  setambientroomcontext("container", "ringoff_plr", "outdoor");
  declareambientpackage("container");
  declaremusicstate("ANGOLA_INTRO");
  musicalias("mus_angola_intro", 0, 0);
  declaremusicstate("ANGOLA_SAVANNAH_BATTLE");
  musicaliasloop("mus_angola_savannah", 0, 4);
  declaremusicstate("ANGOLA_SAVIMBI_SALUTE");
  musicalias("mus_angola_savimbi_fanfare", 0, 0);
  level thread buffel_fire();
  level thread set_alouette_context_ext();
  level thread heli_snapshot();
  level thread walla_sounds();
  level thread set_default_snapshot();
  level thread levelfadeout();
}

heli_snapshot() {
  while(true) {
    level waittill("heli_int");
    snd_set_snapshot("spl_angola_chopper_int");
    setsoundcontext("f35", "interior");
    wait 0.5;
    level waittill("heli_done");
    snd_set_snapshot("cmn_no_wind");
    setsoundcontext("f35", "exterior");
  }
}

buffel_fire() {
  level waittill("intro");
  soundloopemitter("amb_fire_intro", (-3767, 186, -309));
  snd_set_snapshot("spl_angola_intro");
  wait 4;
  snd_set_snapshot("spl_angola_intro_duck_mortar");
}

walla_sounds() {
  level waittill("pgw");
  soundloopemitter("amb_battle_walla_l", (4613, 1494, 37));
  soundloopemitter("amb_battle_walla_r", (4089, 3108, 72));
  level waittill("sgw");
  soundstoploopemitter("amb_battle_walla_l", (4613, 1494, 37));
  soundstoploopemitter("amb_battle_walla_r", (4089, 3108, 72));
}

set_alouette_context_ext() {
  waitforclient(0);
  setsoundcontext("f35", "exterior");
}

set_intro_snapshot() {
  level waittill("audio_intro");
  snd_set_snapshot("spl_angola_intro");
}

set_default_snapshot() {
  level waittill("pobws");
  snd_set_snapshot("default");
}

levelfadeout() {
  level waittill("end_fade");
  snd_set_snapshot("cmn_fade_out");
}

sndsetendsnapshot() {
  snd_set_snapshot("spl_angola1_levelend_snap");
  level thread sndendcheerloops();
}

sndduckmortars() {
  snd_set_snapshot("cmn_no_wind");
  soundstoploopemitter("amb_fire_intro", (-3767, 186, -309));
}

sndendcheerloops() {
  ent1 = spawn(0, (2667, 872, 192), "script_origin");
  ent2 = spawn(0, (2752, 1332, 191), "script_origin");
  ent1 playloopsound("amb_cheer_looper1", 5);
  ent2 playloopsound("amb_cheer_looper2", 5);
}