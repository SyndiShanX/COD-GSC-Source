/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_light_zombie.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_elemental_zombies;
#namespace zm_light_zombie;

function autoexec __init__sytem__() {
  system::register("zm_light_zombie", & __init__, undefined, undefined);
}

function __init__() {
  init_fx();
  register_clientfields();
}

function init_fx() {
  level._effect["light_zombie_fx"] = "dlc1/zmb_weapon/fx_bow_wolf_wrap_torso";
  level._effect["light_zombie_suicide"] = "explosions/fx_exp_grenade_flshbng";
  level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"] = "lihgt_zombie_damage_fx";
}

function register_clientfields() {
  clientfield::register("actor", "light_zombie_clientfield_aura_fx", 15000, 1, "int", & function_98e8bc87, 0, 0);
  clientfield::register("actor", "light_zombie_clientfield_death_fx", 15000, 1, "int", & function_9127e2f8, 0, 0);
  clientfield::register("actor", "light_zombie_clientfield_damaged_fx", 15000, 1, "counter", & function_ad4789b4, 0, 0);
}

function function_9127e2f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval !== newval && newval === 1) {
    fx = playFXOnTag(localclientnum, level._effect["light_zombie_suicide"], self, "j_spineupper");
  }
}

function function_ad4789b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"])) {
      playSound(localclientnum, "gdt_electro_bounce", self.origin);
      locs = array("j_wrist_le", "j_wrist_ri");
      fx = playFXOnTag(localclientnum, level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"], self, array::random(locs));
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_98e8bc87(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval == 1) {
    fx = playFXOnTag(localclientnum, level._effect["light_zombie_fx"], self, "j_spineupper");
    setfxignorepause(localclientnum, fx, 1);
  }
}