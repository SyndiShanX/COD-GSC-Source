/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\pain.gsc
***********************************************/

#using scripts\asm\asm_sp;
#namespace pain;

function main() {
  self endon("killanimscript");
  scripts\asm\asm_sp::paininternal();
}

function initpainfx() {
  level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}