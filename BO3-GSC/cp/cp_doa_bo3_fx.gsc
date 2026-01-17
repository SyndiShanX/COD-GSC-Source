/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_doa_bo3_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace namespace_e8effba5;

function main() {
  level._effect["raps_meteor_fire"] = "zombie/fx_meatball_trail_zmb";
  level._effect["lightning_raps_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
  level._effect["raps_gib"] = "zombie/fx_dog_explosion_zmb";
  level._effect["raps_trail_fire"] = "zombie/fx_raps_fire_trail_zmb";
  level._effect["raps_trail_ash"] = "zombie/fx_dog_ash_trail_zmb";
}

function raps_explode_fx(origin) {
  playFX(level._effect["raps_gib"], origin);
  playsoundatposition("zmb_hellhound_explode", origin);
}