/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cod5_prototype_amb\.csc
*******************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  declareAmbientRoom("zombies");
  declareAmbientPackage("zombies");
  setAmbientRoomReverb("zombies", "RV_ZOMBIES_PROTO_MEDIUM_ROOM", 1, 1);
  setAmbientRoomContext("zombies", "ringoff_plr", "indoor");
  addAmbientElement("zombies", "amb_spooky_2d", 5, 8, 300, 2000);
  declareAmbientRoom("upstairs");
  declareAmbientPackage("upstairs");
  setAmbientRoomReverb("upstairs", "RV_ZOMBIES_PROTO_UPSTAIRS", 1, 1);
  setAmbientRoomContext("upstairs", "ringoff_plr", "indoor");
  addAmbientElement("upstairs", "amb_spooky_2d", 5, 8, 300, 2000);
  declareAmbientRoom("downstairs");
  declareAmbientPackage("downstairs");
  setAmbientRoomReverb("downstairs", "RV_ZOMBIES_PROTO_DOWNSTAIRS", 1, 1);
  setAmbientRoomContext("downstairs", "ringoff_plr", "indoor");
  addAmbientElement("downstairs", "amb_spooky_2d", 5, 8, 300, 2000);
  activateAmbientPackage(0, "zombies", 0);
  activateAmbientRoom(0, "zombies", 0);
  declareMusicState("SPLASH_SCREEN");
  musicAlias("mx_splash_screen", 12);
  musicwaittilldone();
  declareMusicState("WAVE");
  musicAliasloop("mus_zombie_wave_loop", 0, 4);
  declareMusicState("EGG");
  musicAlias("mus_prototype_egg", 1);
  declareMusicState("SILENCE");
  musicAlias("null", 1);
  thread clientscripts\_waw_zombiemode_radio::init();
  thread play_fire_loops();
}
play_fire_loops() {
  fire = clientscripts\_audio::playloopat(0, "fire_med", (164.8, -63.5, 127.1));
}