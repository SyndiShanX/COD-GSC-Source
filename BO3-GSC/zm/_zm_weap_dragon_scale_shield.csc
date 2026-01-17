/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_scale_shield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_dragon_strike;
#using scripts\zm\_zm_weapons;
#namespace dragon_scale_shield;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragonshield", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "ds_ammo", 12000, 1, "int", &function_3b8ce539, 0, 0);
  clientfield::register("allplayers", "burninate", 12000, 1, "counter", &function_adc7474a, 0, 0);
  clientfield::register("allplayers", "burninate_upgraded", 12000, 1, "counter", &function_627dd7e5, 0, 0);
  clientfield::register("actor", "dragonshield_snd_projectile_impact", 12000, 1, "counter", &dragonshield_snd_projectile_impact, 0, 0);
  clientfield::register("vehicle", "dragonshield_snd_projectile_impact", 12000, 1, "counter", &dragonshield_snd_projectile_impact, 0, 0);
  clientfield::register("actor", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter", &dragonshield_snd_zombie_knockdown, 0, 0);
  clientfield::register("vehicle", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter", &dragonshield_snd_zombie_knockdown, 0, 0);
}

function function_3b8ce539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
  } else {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
  }
}

function function_adc7474a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self islocalplayer()) {
    playFXOnTag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_1p", self, "tag_flash");
  } else {
    playFXOnTag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_3p", self, "tag_flash");
  }
}

function function_627dd7e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self islocalplayer()) {
    playFXOnTag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_1p_up", self, "tag_flash");
  } else {
    playFXOnTag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_3p_up", self, "tag_flash");
  }
}

function dragonshield_snd_projectile_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(localclientnum, "vox_dragonshield_forcehit", self.origin);
  playSound(localclientnum, "wpn_dragonshield_proj_impact", self.origin);
}

function dragonshield_snd_zombie_knockdown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(localclientnum, "fly_dragonshield_forcehit", self.origin);
}