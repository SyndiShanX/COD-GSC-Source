/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_spire_fx.csc
*************************************************/

#using scripts\codescripts\struct;
#namespace mp_spire_fx;

function precache_scripted_fx() {}

function precache_fx_anims() {
  level.scr_anim = [];
  level.scr_anim["fxanim_props"] = [];
}

function main() {
  disablefx = getdvarint("disable_fx");
  if(!isdefined(disablefx) || disablefx <= 0) {
    precache_scripted_fx();
  }
}