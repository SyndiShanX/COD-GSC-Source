/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\zombie_react.gsc
************************************************/

#namespace zombie_react;

function isenemyzombie(asmname, statename, tostatename, params) {
  return isDefined(self.enemy) && isDefined(self.enemy.unittype) && self.enemy.unittype == "\x9b\x11\"\xd6\xfb;";
}