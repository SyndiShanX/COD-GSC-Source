/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombietron_amb\.csc
********************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  declareAmbientRoom("default");
  declareAmbientPackage("default");
  declareAmbientRoom("island");
  declareAmbientPackage("island");
  setAmbientRoomTone("island", "amb_island_looper");
  setAmbientRoomReverb("island", "stoneroom", 1, 1);
  declareAmbientRoom("town");
  declareAmbientPackage("town");
  setAmbientRoomTone("town", "amb_town_looper");
  setAmbientRoomReverb("town", "stoneroom", 1, 1);
  declareAmbientRoom("prison");
  declareAmbientPackage("prison");
  setAmbientRoomTone("prison", "amb_prison_looper");
  setAmbientRoomReverb("prison", "stoneroom", 1, 1);
  declareAmbientRoom("factory");
  declareAmbientPackage("factory");
  setAmbientRoomTone("factory", "amb_factory_looper");
  setAmbientRoomReverb("factory", "stoneroom", 1, 1);
  declareAmbientRoom("farm");
  declareAmbientPackage("farm");
  setAmbientRoomTone("farm", "amb_farm_looper");
  setAmbientRoomReverb("farm", "stoneroom", 1, 1);
  declareAmbientRoom("rooftop");
  declareAmbientPackage("rooftop");
  setAmbientRoomTone("rooftop", "amb_rooftop_looper");
  setAmbientRoomReverb("rooftop", "stoneroom", 1, 1);
  declareAmbientRoom("snow");
  declareAmbientPackage("snow");
  setAmbientRoomTone("snow", "amb_snow_looper");
  setAmbientRoomReverb("snow", "stoneroom", 1, 1);
  declareAmbientRoom("temple");
  declareAmbientPackage("temple");
  setAmbientRoomTone("temple", "amb_temple_looper");
  setAmbientRoomReverb("temple", "stoneroom", 1, 1);
  declareAmbientRoom("jungle");
  declareAmbientPackage("jungle");
  setAmbientRoomTone("jungle", "amb_jungle_looper");
  setAmbientRoomReverb("jungle", "stoneroom", 1, 1);
  declareAmbientRoom("bunker");
  declareAmbientPackage("bunker");
  setAmbientRoomTone("bunker", "amb_bunker_looper");
  setAmbientRoomReverb("bunker", "stoneroom", 1, 1);
  activateAmbientPackage(0, "default", 0);
  activateAmbientRoom(0, "default", 0);
  declareMusicState("island");
  musicAliasloop("mus_zmbtron_island", 4, 4);
  declareMusicState("town");
  musicAliasloop("mus_zmbtron_town", 4, 4);
  declareMusicState("prison");
  musicAliasloop("mus_zmbtron_prison", 4, 4);
  declareMusicState("factory");
  musicAliasloop("mus_zmbtron_factory", 4, 4);
  declareMusicState("rooftop");
  musicAliasloop("mus_zmbtron_rooftop", 4, 4);
  declareMusicState("snow");
  musicAliasloop("mus_zmbtron_snow", 4, 4);
  declareMusicState("temple");
  musicAliasloop("mus_zmbtron_temple", 4, 4);
  declareMusicState("jungle");
  musicAliasloop("mus_zmbtron_jungle", 4, 4);
  declareMusicState("challenge");
  musicAliasloop("mus_zmbtron_challenge", 4, 4);
  declareMusicState("boss");
  musicAliasloop("mus_zmbtron_boss", 4, 4);
  declareMusicState("fate");
  musicAliasloop("mus_zmbtron_fate", 4, 4);
  declareMusicState("bonus");
  musicAliasloop("mus_zmbtron_bonus", 4, 4);
  declareMusicState("end_of_game");
  musicAliasloop("mus_zmbtron_end", 4, 4);
  declareMusicState("street");
  musicAliasloop("mus_zmbtron_street", 4, 4);
  declareMusicState("bunker");
  musicAliasloop("mus_zmbtron_bunker", 4, 4);
}