/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\bots\bot_buttons.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace bot;

function tap_attack_button() {
  self bottapbutton(0);
}

function press_attack_button() {
  self botpressbutton(0);
}

function release_attack_button() {
  self botreleasebutton(0);
}

function tap_melee_button() {
  self bottapbutton(2);
}

function tap_reload_button() {
  self bottapbutton(4);
}

function tap_use_button() {
  self bottapbutton(3);
}

function press_crouch_button() {
  self botpressbutton(9);
}

function press_use_button() {
  self botpressbutton(3);
}

function release_use_button() {
  self botreleasebutton(3);
}

function press_sprint_button() {
  self botpressbutton(1);
}

function release_sprint_button() {
  self botreleasebutton(1);
}

function press_frag_button() {
  self botpressbutton(14);
}

function release_frag_button() {
  self botreleasebutton(14);
}

function tap_frag_button() {
  self bottapbutton(14);
}

function press_offhand_button() {
  self botpressbutton(15);
}

function release_offhand_button() {
  self botreleasebutton(15);
}

function tap_offhand_button() {
  self bottapbutton(15);
}

function press_throw_button() {
  self botpressbutton(24);
}

function release_throw_button() {
  self botreleasebutton(24);
}

function tap_jump_button() {
  self bottapbutton(10);
}

function press_jump_button() {
  self botpressbutton(10);
}

function release_jump_button() {
  self botreleasebutton(10);
}

function tap_ads_button() {
  self bottapbutton(11);
}

function press_ads_button() {
  self botpressbutton(11);
}

function release_ads_button() {
  self botreleasebutton(11);
}

function tap_doublejump_button() {
  self bottapbutton(65);
}

function press_doublejump_button() {
  self botpressbutton(65);
}

function release_doublejump_button() {
  self botreleasebutton(65);
}

function tap_offhand_special_button() {
  self bottapbutton(70);
}

function press_swim_up() {
  self botpressbutton(67);
}

function release_swim_up() {
  self botreleasebutton(67);
}

function press_swim_down() {
  self botpressbutton(68);
}

function release_swim_down() {
  self botreleasebutton(68);
}