/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_infection.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_infection_fx;
#using scripts\mp\mp_infection_sound;
#using scripts\shared\util_shared;
#namespace namespace_82e4b148;

function main() {
  namespace_5d379c9::main();
  namespace_83fbe97c::main();
  load::main();
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_infection";
}