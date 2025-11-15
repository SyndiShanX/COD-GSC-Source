/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_veiled.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_veiled_fx;
#using scripts\mp\mp_veiled_sound;
#using scripts\shared\util_shared;
#namespace mp_veiled;

function main() {
  namespace_f7008227::main();
  namespace_8f273e4e::main();
  load::main();
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_veiled";
}