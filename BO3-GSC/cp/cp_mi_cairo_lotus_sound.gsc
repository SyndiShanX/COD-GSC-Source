/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_lotus_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_cairo_lotus_sound;

function main() {
  level thread function_cf637cc();
  level thread function_ba59ec78();
}

function function_cf637cc() {
  level waittill("hash_72d53556");
  level util::clientnotify("start_battle_sound");
}

function function_ba59ec78() {
  level waittill("hash_fe7439eb");
  level util::clientnotify("kill_security_chatter");
}

#namespace namespace_66fe78fb;

function play_intro() {
  music::setmusicstate("intro");
}

function function_36e942f6() {
  music::setmusicstate("battle_one_part_one");
}

function function_f3bdd599() {
  music::setmusicstate("elevator_ride");
}

function function_d116b1d8() {
  wait(10);
  music::setmusicstate("battle_one_part_two");
}

function function_f2d3d939() {
  music::setmusicstate("air_duct");
  wait(15);
  util::clientnotify("sndRampair");
  wait(25);
  util::clientnotify("sndRampEnd");
}

function function_86781870() {
  wait(0.5);
  music::setmusicstate("hq_battle");
}

function function_8836c025() {
  music::setmusicstate("computer_hack");
}

function function_fd00a4f2() {
  music::setmusicstate("breach_stinger");
}

function function_51e72857() {
  music::setmusicstate("battle_two");
}

function function_973b77f9() {
  music::setmusicstate("none");
}