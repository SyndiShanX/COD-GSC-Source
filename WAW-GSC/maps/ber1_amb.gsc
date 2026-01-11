/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber1_amb.gsc
*****************************************************/

#include maps\_utility;
#include maps\_ambientpackage;

main() {
  declareAmbientPackage("ber1_outdoors_pkg");
  declareAmbientPackage("ber1_stone_room_pkg");
  addAmbientElement("ber1_stone_room_pkg", "amb_stone_small", 10, 20, 100, 200);
  addAmbientElement("ber1_stone_room_pkg", "bomb_far", 2, 15, 10, 200);
  addAmbientElement("ber1_stone_room_pkg", "bomb_medium", 15, 30, 100, 500);
  declareAmbientPackage("ber1_wood_room_pkg");
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_small", 10, 20, 100, 200);
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_boards", 20, 40, 100, 500);
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_creak", 20, 40, 100, 500);
  addAmbientElement("ber1_wood_room_pkg", "bomb_far", 2, 15, 10, 200);
  addAmbientElement("ber1_wood_room_pkg", "bomb_medium", 15, 30, 100, 500);
  declareAmbientPackage("ber1_asylum_pkg");
  addAmbientElement("ber1_asylum_pkg", "amb_rodents", 5, 35, 100, 500);
  declareAmbientPackage("ber1_train_station_pkg");
  addAmbientElement("ber1_train_station_pkg", "amb_water_drips", 0.05, 0.8, 10, 100);
  declareAmbientRoom("ber1_outdoors_room");
  setAmbientRoomReverb("ber1_outdoors_room", "Ber1", 1, 1);
  declareAmbientRoom("ber1_closed_room");
  setAmbientRoomTone("ber1_closed_room", "closed_room_wind");
  setAmbientRoomReverb("ber1_closed_room", "cod_room", 1, 0.4);
  declareAmbientRoom("ber1_partial_room");
  setAmbientRoomTone("ber1_partial_room", "partial_room_wind");
  setAmbientRoomReverb("ber1_partial_room", "cod_room", 1, 0.4);
  declareAmbientRoom("ber1_asylum");
  setAmbientRoomTone("ber1_asylum", "asylum_wind");
  setAmbientRoomReverb("ber1_asylum", "cod_room", 1, 0.4);
  declareAmbientRoom("ber1_train_station");
  setAmbientRoomTone("ber1_train_station", "train_station_wind");
  activateAmbientPackage("ber1_outdoors_pkg", 0);
  activateAmbientRoom("ber1_outdoors_room", 0);
  level thread play_music_box();
  level thread play_children_chant();
  level thread playground();
  level thread play_arty_sound();
  level thread wall_fire();
}

wall_fire() {
  level waittill("first_player_ready");
  wait 5;
  wall_fire = spawn("script_origin", (3400, 4400, -72));
  wall_fire playLoopSound("wall_fire", 1);
}

play_bell_toll_sound() {
  level endon("ber1_clock_shot");
  level waittill("ber1_bell_toll");
  toll1 = getent("clock", "targetname");
  toll1 playSound("bell_toll1", "sound_done");
  toll1 waittill("sound_done");
  toll2 = getent("clock", "targetname");
  toll2 playSound("bell_toll2", "sound_done");
  toll2 waittill("sound_done");
  toll3 = getent("clock", "targetname");
  toll3 playSound("bell_toll3", "sound_done");
  toll3 waittill("sound_done");
  toll4 = getent("clock", "targetname");
  toll4 playSound("bell_toll4", "sound_done");
  toll4 waittill("sound_done");
  toll5 = getent("clock", "targetname");
  toll5 playSound("bell_toll5", "sound_done");
  toll5 waittill("sound_done");
  toll_end = getent("clock", "targetname");
  toll_end playSound("bell_toll_end", "sound_done");
  toll_end waittill("sound_done");
}

play_music_box() {
  level waittill("music_box_on");
  music_box = getent("music_box", "targetname");
  music_box playLoopSound("music_box");
  level waittill("music_box_off");
  music_box stoploopsound(.5);
  music_box playSound("music_box_close");
  wait 1;
  music_box playSound("insane_laugh");
}

play_children_chant() {
  level waittill("music_box_on");
  chant = getent("chant", "targetname");
  chant playLoopSound("child_chant");
  level waittill("boy_scream_off");
  chant stoploopsound(.5);
  wait 1;
  chant playSound("child_scream");
}

playground() {
  level waittill("playground_on");
  playground = getent("playground", "targetname");
  playground playLoopSound("playground");
  level waittill("playground_off");
  playground stoploopsound(.5);
}

play_insane_scream() {
  level waittill("insane_scream");
  insane_scream = getent("insane_scream", "targetname");
  insane_scream playSound("insane_scream");
}

play_arty_sound() {
  level waittill("ber2_earthquake");
  ber2_earthquake = getent("music_box", "targetname");
  ber2_earthquake playSound("art_int", "sound_done");
}

/*
train_ride()
{
	
	
	
	
	
	
	
	
	playsoundatposition ("train_rear_left", (-10600,-2232, -856));
	playsoundatposition ("train_rear_right", (-10568, -10792, -856));
	playsoundatposition ("train_front_left", (2992, -32, -792));
	playsoundatposition ("train_front_right", (3192, -10712, -792));
	playsoundatposition ("train_front_center", (2096, -6736, -792));
	
}

*\