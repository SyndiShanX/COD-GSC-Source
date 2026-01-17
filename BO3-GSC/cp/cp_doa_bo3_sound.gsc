/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_doa_bo3_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#namespace namespace_4fca3ee8;

function main() {}

#namespace namespace_1a381543;

function function_68fdd800() {
  if(!isDefined(level.var_ae4549e5)) {
    level.var_ae4549e5 = spawn("script_origin", (0, 0, 0));
  }
  level.var_ae4549e5 playLoopSound("amb_rally_bg");
  level.var_ae4549e5 function_42b6c406();
}

function function_42b6c406() {
  level waittill("ro");
  self stoploopsound();
  wait(1);
  self delete();
}