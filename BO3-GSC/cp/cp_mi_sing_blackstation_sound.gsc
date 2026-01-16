/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_blackstation_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#namespace cp_mi_sing_blackstation_sound;

function main() {
  level thread function_8a682a34();
  level thread function_70f35bef();
  level thread function_329c89f();
  clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int");
}

function function_8a682a34() {
  level waittill("hash_d195be99");
  music::setmusicstate("military_action");
}

function function_70f35bef() {
  level waittill("hash_9074b8ad");
  wait(1.85);
  music::setmusicstate("none");
}

function function_329c89f() {
  level waittill("hash_329c89f");
  level clientfield::set("sndDrillWalla", 0);
}

#namespace namespace_4297372;

function function_973b77f9() {
  music::setmusicstate("none");
}

function function_fcea1d9() {
  wait(3);
  music::setmusicstate("none");
}

function function_240ac8fa() {
  music::setmusicstate("shanty_town");
}

function function_4f531ae2() {
  music::setmusicstate("54i_theme_igc");
}

function function_fa2e45b8() {
  music::setmusicstate("battle_1");
}

function function_91146001() {
  music::setmusicstate("battle_1_docks");
}

function function_11139d81() {
  music::setmusicstate("boat_ride");
}

function function_5b1a53ea() {
  music::setmusicstate("rachael");
}

function function_6c35b4f3() {
  music::setmusicstate("battle_2");
}

function function_d4c52995() {
  music::setmusicstate("tension_loop");
}

function function_cde82250() {
  music::setmusicstate("data_relay");
}

function function_f152b1dc() {
  wait(3);
  music::setmusicstate("zip_line");
}

function function_674f7650() {
  music::setmusicstate("last_building_underscore");
}

function function_37f7c98d() {
  music::setmusicstate("underwater");
}

function function_bed0eaad() {
  wait(9);
  music::setmusicstate("police_station");
}

function function_6048af60() {
  music::setmusicstate("discovery");
}

function function_a339da70() {
  playerlist = getplayers();
  foreach(player in playerlist) {
    player playsoundtoplayer("evt_takedown_slowmo_02", player);
    player playloopsound("evt_time_slow_loop");
    player clientfield::set_to_player("slowmo_duck_active", 1);
  }
}

function function_69fc18eb() {
  playerlist = getplayers();
  foreach(player in playerlist) {
    player playsoundtoplayer("evt_takedown_slowmo_exit", player);
    player stoploopsound();
    player clientfield::set_to_player("slowmo_duck_active", 0);
  }
}