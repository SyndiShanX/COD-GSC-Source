/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_shadow_zombie.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_elemental_zombies;
#namespace zm_shadow_zombie;

function autoexec __init__sytem__() {
  system::register("zm_shadow_zombie", &__init__, undefined, undefined);
}

function __init__() {
  init_fx();
  register_clientfields();
}

function init_fx() {
  level._effect["shadow_zombie_fx"] = "dlc4/genesis/fx_zombie_shadow_ambient_trail";
  level._effect["shadow_zombie_suicide"] = "dlc4/genesis/fx_zombie_shadow_death";
  level._effect["dlc4/genesis/fx_zombie_shadow_damage"] = "shadow_zombie_damage_fx";
  if(!isDefined(level._effect["mini_curse_circle"])) {
    level._effect["mini_curse_circle"] = "dlc4/genesis/fx_zombie_shadow_trap_ambient";
  }
}

function register_clientfields() {
  clientfield::register("actor", "shadow_zombie_clientfield_aura_fx", 15000, 1, "int", &function_384150e9, 0, 0);
  clientfield::register("actor", "shadow_zombie_clientfield_death_fx", 15000, 1, "int", &function_ac1abcb6, 0, 0);
  clientfield::register("actor", "shadow_zombie_clientfield_damaged_fx", 15000, 1, "counter", &function_b3071651, 0, 0);
  clientfield::register("scriptmover", "shadow_zombie_cursetrap_fx", 15000, 1, "int", &shadow_zombie_cursetrap_fx, 0, 0);
}

function function_ac1abcb6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval !== newval && newval === 1) {
    fx = playFXOnTag(localclientnum, level._effect["shadow_zombie_suicide"], self, "j_spineupper");
  }
}

function function_b3071651(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["dlc4/genesis/fx_zombie_shadow_damage"])) {
      playSound(localclientnum, "gdt_electro_bounce", self.origin);
      locs = array("j_wrist_le", "j_wrist_ri");
      fx = playFXOnTag(localclientnum, level._effect["dlc4/genesis/fx_zombie_shadow_damage"], self, array::random(locs));
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_384150e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval == 1) {
    fx = playFXOnTag(localclientnum, level._effect["shadow_zombie_fx"], self, "j_spineupper");
    fx2 = playFXOnTag(localclientnum, level._effect["shadow_zombie_fx"], self, "j_head");
    setfxignorepause(localclientnum, fx, 1);
  }
}

function shadow_zombie_cursetrap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.sndlooper)) {
    self stoploopsound(self.sndlooper, 0.5);
    self.sndlooper = undefined;
    self playSound(0, "zmb_zod_cursed_landmine_end");
  }
  if(newval) {
    self.sndlooper = self playLoopSound("zmb_zod_cursed_landmine_lp", 1);
    self playSound(0, "zmb_zod_cursed_landmine_start");
  }
  self function_267f859f(localclientnum, level._effect["mini_curse_circle"], newval, 1);
}

function function_267f859f(localclientnum, fx_id = undefined, b_on = 1, var_afcc5d76 = 0, str_tag = "tag_origin") {
  if(b_on) {
    if(isDefined(self.vfx_ref)) {
      stopfx(localclientnum, self.vfx_ref);
    }
    if(var_afcc5d76) {
      self.vfx_ref = playFXOnTag(localclientnum, fx_id, self, str_tag);
    } else {
      if(self.angles === (0, 0, 0)) {
        self.vfx_ref = playFX(localclientnum, fx_id, self.origin);
      } else {
        self.vfx_ref = playFX(localclientnum, fx_id, self.origin, self.angles);
      }
    }
  } else if(isDefined(self.vfx_ref)) {
    stopfx(localclientnum, self.vfx_ref);
    self.vfx_ref = undefined;
  }
}