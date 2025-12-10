/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_blast_furnace.csc
*************************************************/

#using scripts\shared\aat_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_aat_blast_furnace;

function autoexec __init__sytem__() {
  system::register("zm_aat_blast_furnace", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_blast_furnace", "zmui_zm_aat_blast_furnace", "t7_icon_zm_aat_blast_furnace");
  clientfield::register("actor", "zm_aat_blast_furnace" + "_explosion", 1, 1, "counter", &zm_aat_blast_furnace_explosion, 0, 0);
  clientfield::register("vehicle", "zm_aat_blast_furnace" + "_explosion_vehicle", 1, 1, "counter", &zm_aat_blast_furnace_explosion_vehicle, 0, 0);
  clientfield::register("actor", "zm_aat_blast_furnace" + "_burn", 1, 1, "counter", &zm_aat_blast_furnace_burn, 0, 0);
  clientfield::register("vehicle", "zm_aat_blast_furnace" + "_burn_vehicle", 1, 1, "counter", &zm_aat_blast_furnace_burn_vehicle, 0, 0);
  level._effect["zm_aat_blast_furnace"] = "zombie/fx_aat_blast_furnace_zmb";
}

function zm_aat_blast_furnace_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(0, "wpn_aat_blastfurnace_explo", self.origin);
  s_aat_blast_furnace_explosion = spawnStruct();
  s_aat_blast_furnace_explosion.origin = self.origin;
  s_aat_blast_furnace_explosion.angles = self.angles;
  s_aat_blast_furnace_explosion thread zm_aat_blast_furnace_explosion_think(localclientnum);
}

function zm_aat_blast_furnace_explosion_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(0, "wpn_aat_blastfurnace_explo", self.origin);
  s_aat_blast_furnace_explosion = spawnStruct();
  s_aat_blast_furnace_explosion.origin = self.origin;
  s_aat_blast_furnace_explosion.angles = self.angles;
  s_aat_blast_furnace_explosion thread zm_aat_blast_furnace_explosion_think(localclientnum);
}

function zm_aat_blast_furnace_explosion_think(localclientnum) {
  angles = self.angles;
  if(lengthsquared(angles) < 0.001) {
    angles = (1, 0, 0);
  }
  self.fx_aat_blast_furnace_explode = playFX(localclientnum, "zombie/fx_aat_blast_furnace_zmb", self.origin, angles);
  wait(2.5);
  stopfx(localclientnum, self.fx_aat_blast_furnace_explode);
  self.fx_aat_blast_furnace_explode = undefined;
}

function zm_aat_blast_furnace_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  tag = "j_spine4";
  v_tag = self gettagorigin(tag);
  if(!isDefined(v_tag)) {
    tag = "tag_origin";
  }
  level thread zm_aat_blast_furnace_burn_think(localclientnum, self, tag);
}

function zm_aat_blast_furnace_burn_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  tag = "tag_body";
  v_tag = self gettagorigin(tag);
  if(!isDefined(v_tag)) {
    tag = "tag_origin";
  }
  level thread zm_aat_blast_furnace_burn_think(localclientnum, self, tag);
}

function zm_aat_blast_furnace_burn_think(localclientnum, e_zombie, tag) {
  e_zombie.fx_aat_blast_furnace_burn = playFXOnTag(localclientnum, "zombie/fx_bgb_burned_out_fire_torso_zmb", e_zombie, tag);
  e_zombie playLoopSound("chr_burn_npc_loop1", 0.5);
  e_zombie waittill("entityshutdown");
  if(isDefined(e_zombie)) {
    e_zombie stopallloopsounds(1.5);
    stopfx(localclientnum, e_zombie.fx_aat_blast_furnace_burn);
  }
}