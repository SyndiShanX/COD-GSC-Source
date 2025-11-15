/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_electric_cherry.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_electric_cherry;

function autoexec __init__sytem__() {
  system::register("zm_perk_electric_cherry", & __init__, undefined, undefined);
}

function __init__() {
  zm_perks::register_perk_clientfields("specialty_electriccherry", & electric_cherry_client_field_func, & electric_cherry_code_callback_func);
  zm_perks::register_perk_effects("specialty_electriccherry", "electric_light");
  zm_perks::register_perk_init_thread("specialty_electriccherry", & init_electric_cherry);
}

function init_electric_cherry() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect["electric_light"] = "_t6/misc/fx_zombie_cola_revive_on";
  }
  registerclientfield("allplayers", "electric_cherry_reload_fx", 1, 2, "int", & electric_cherry_reload_attack_fx, 0);
  clientfield::register("actor", "tesla_death_fx", 1, 1, "int", & tesla_death_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_death_fx_veh", 10000, 1, "int", & tesla_death_fx_callback, 0, 0);
  clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", & tesla_shock_eyes_fx_callback, 0, 0);
  clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int", & tesla_shock_eyes_fx_callback, 0, 0);
  level._effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
  level._effect["electric_cherry_trail"] = "dlc1/castle/fx_castle_electric_cherry_trail";
  level._effect["tesla_death_cherry"] = "zombie/fx_tesla_shock_zmb";
  level._effect["tesla_shock_eyes_cherry"] = "zombie/fx_tesla_shock_eyes_zmb";
  level._effect["tesla_shock_cherry"] = "zombie/fx_bmode_shock_os_zod_zmb";
}

function electric_cherry_client_field_func() {
  clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int", undefined, 0, 1);
}

function electric_cherry_code_callback_func() {}

function electric_cherry_reload_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.electric_cherry_reload_fx)) {
    stopfx(localclientnum, self.electric_cherry_reload_fx);
  }
  if(newval == 1) {
    self.electric_cherry_reload_fx = playFXOnTag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
  } else {
    if(newval == 2) {
      self.electric_cherry_reload_fx = playFXOnTag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
    } else {
      if(newval == 3) {
        self.electric_cherry_reload_fx = playFXOnTag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
      } else {
        if(isDefined(self.electric_cherry_reload_fx)) {
          stopfx(localclientnum, self.electric_cherry_reload_fx);
        }
        self.electric_cherry_reload_fx = undefined;
      }
    }
  }
}

function tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    str_tag = "J_SpineUpper";
    if(isDefined(self.str_tag_tesla_death_fx)) {
      str_tag = self.str_tag_tesla_death_fx;
    } else if(isDefined(self.isdog) && self.isdog) {
      str_tag = "J_Spine1";
    }
    self.n_death_fx = playFXOnTag(localclientnum, level._effect["tesla_death_cherry"], self, str_tag);
    setfxignorepause(localclientnum, self.n_death_fx, 1);
  } else {
    if(isDefined(self.n_death_fx)) {
      deletefx(localclientnum, self.n_death_fx, 1);
    }
    self.n_death_fx = undefined;
  }
}

function tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    str_tag = "J_SpineUpper";
    if(isDefined(self.str_tag_tesla_shock_eyes_fx)) {
      str_tag = self.str_tag_tesla_shock_eyes_fx;
    } else if(isDefined(self.isdog) && self.isdog) {
      str_tag = "J_Spine1";
    }
    self.n_shock_eyes_fx = playFXOnTag(localclientnum, level._effect["tesla_shock_eyes_cherry"], self, "J_Eyeball_LE");
    setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
    self.n_shock_fx = playFXOnTag(localclientnum, level._effect["tesla_death_cherry"], self, str_tag);
    setfxignorepause(localclientnum, self.n_shock_fx, 1);
  } else {
    if(isDefined(self.n_shock_eyes_fx)) {
      deletefx(localclientnum, self.n_shock_eyes_fx, 1);
      self.n_shock_eyes_fx = undefined;
    }
    if(isDefined(self.n_shock_fx)) {
      deletefx(localclientnum, self.n_shock_fx, 1);
      self.n_shock_fx = undefined;
    }
  }
}