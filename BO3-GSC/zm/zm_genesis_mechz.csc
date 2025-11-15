/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_mechz.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_genesis_mechz;

function autoexec __init__sytem__() {
  system::register("zm_genesis_mechz", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["tesla_zombie_shock"] = "dlc4/genesis/fx_elec_trap_body_shock";
  if(ai::shouldregisterclientfieldforarchetype("mechz")) {
    clientfield::register("actor", "death_ray_shock_fx", 15000, 1, "int", & death_ray_shock_fx, 0, 0);
  }
  clientfield::register("actor", "mechz_fx_spawn", 15000, 1, "counter", & function_4b9cfd4c, 0, 0);
}

function death_ray_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_51adc559(localclientnum);
  if(newval) {
    if(!isDefined(self.tesla_shock_fx)) {
      tag = "J_SpineUpper";
      if(!self isai()) {
        tag = "tag_origin";
      }
      self.tesla_shock_fx = playFXOnTag(localclientnum, level._effect["tesla_zombie_shock"], self, tag);
      self playSound(0, "zmb_electrocute_zombie");
    }
    if(isdemoplaying()) {
      self thread function_7772592b(localclientnum);
    }
  }
}

function function_7772592b(localclientnum) {
  self notify("hash_51adc559");
  self endon("hash_51adc559");
  level waittill("demo_jump");
  self function_51adc559(localclientnum);
}

function function_51adc559(localclientnum) {
  if(isDefined(self.tesla_shock_fx)) {
    deletefx(localclientnum, self.tesla_shock_fx, 1);
    self.tesla_shock_fx = undefined;
  }
  self notify("hash_51adc559");
}

function function_4b9cfd4c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.spawnfx = playFXOnTag(localclientnum, level._effect["mechz_ground_spawn"], self, "tag_origin");
    playSound(0, "zmb_mechz_spawn_nofly", self.origin);
  }
}