/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_apartments_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace mp_apartments_fx;

function main() {
  precache_fxanim_props();
  precache_scripted_fx();
}

function precache_scripted_fx() {}

function precache_fxanim_props() {
  level.scr_anim = [];
  level.scr_anim["fxanim_props"] = [];
}