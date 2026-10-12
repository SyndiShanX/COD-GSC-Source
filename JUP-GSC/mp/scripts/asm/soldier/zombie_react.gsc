/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\zombie_react.gsc
************************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace zombie_react;

function isenemyzombie(asmname, statename, tostatename, params) {
  return isDefined(self.enemy) && isDefined(self.enemy.unittype) && self.enemy.unittype == "zombie";
}