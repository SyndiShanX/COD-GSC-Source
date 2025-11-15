/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_apartments_fx.csc
*************************************************/

#using scripts\codescripts\struct;
#namespace mp_apartments_fx;

function precache_scripted_fx() {}

function precache_fx_anims() {
  level.scr_anim = [];
  level.scr_anim["fxanim_props"] = [];
}

function main() {
  disablefx = getdvarint("disable_fx");
  if(!isDefined(disablefx) || disablefx <= 0) {
    precache_scripted_fx();
  }
}