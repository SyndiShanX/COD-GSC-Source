/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_elemental_zombies.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_elemental_zombie;

function autoexec __init__sytem__() {
  system::register("zm_elemental_zombie", & __init__, undefined, undefined);
}

function __init__() {
  init_fx();
  register_clientfields();
}

function init_fx() {
  level._effect["elemental_zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot_optim";
  level._effect["elemental_sparky_zombie_suicide"] = "explosions/fx_ability_exp_ravage_core_optim";
  level._effect["elemental_zombie_fire_damage"] = "fire/fx_embers_burst_optim";
  level._effect["elemental_napalm_zombie_suicide"] = "explosions/fx_exp_dest_barrel_concussion_sm_optim";
  level._effect["elemental_zombie_spark_light"] = "light/fx_light_spark_chest_zombie_optim";
  level._effect["elemental_electric_spark"] = "electric/fx_elec_sparks_burst_blue_optim";
}

function register_clientfields() {
  clientfield::register("actor", "sparky_zombie_spark_fx", 1, 1, "int", & function_de563d9b, 0, 0);
  clientfield::register("actor", "sparky_zombie_death_fx", 1, 1, "int", & function_d0886efe, 0, 0);
  clientfield::register("actor", "napalm_zombie_death_fx", 1, 1, "int", & function_56ad3a27, 0, 0);
  clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter", & function_86aaed61, 0, 0);
  clientfield::register("actor", "napalm_damaged_fx", 1, 1, "counter", & function_16467cb6, 0, 0);
  clientfield::register("actor", "napalm_sfx", 11000, 1, "int", & function_b542950d, 0, 0);
}

function function_56ad3a27(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(oldval !== newval && newval === 1) {
    fx = playFXOnTag(localclientnum, level._effect["elemental_napalm_zombie_suicide"], self, "j_spineupper");
    self playSound(0, "zmb_elemental_zombie_explode_fire");
  }
}

function function_16467cb6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["elemental_zombie_fire_damage"])) {
      playSound(localclientnum, "gdt_electro_bounce", self.origin);
      locs = array("j_wrist_le", "j_wrist_ri");
      fx = playFXOnTag(localclientnum, level._effect["elemental_zombie_fire_damage"], self, array::random(locs));
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_b542950d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_1f5b576b)) {
      self.var_1f5b576b = self playLoopSound("zmb_elemental_zombie_loop_fire", 0.2);
    }
  }
}

function function_de563d9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval == 1) {
    if(!isDefined(self.var_e863c331)) {
      self.var_e863c331 = self playLoopSound("zmb_electrozomb_lp", 0.2);
    }
    str_tag = "J_SpineUpper";
    if(isDefined(self.var_46d9c2ee)) {
      str_tag = self.var_46d9c2ee;
    }
    str_fx = level._effect["elemental_zombie_sparky"];
    if(isDefined(self.var_7abb4217)) {
      str_fx = self.var_7abb4217;
    }
    fx = playFXOnTag(localclientnum, str_fx, self, str_tag);
    setfxignorepause(localclientnum, fx, 1);
    var_4473cd0 = level._effect["elemental_zombie_spark_light"];
    if(isDefined(self.var_e22d3880)) {
      var_4473cd0 = self.var_e22d3880;
    }
    fx = playFXOnTag(localclientnum, var_4473cd0, self, str_tag);
    setfxignorepause(localclientnum, fx, 1);
  }
}

function function_d0886efe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval !== newval && newval === 1) {
    fx = playFXOnTag(localclientnum, level._effect["elemental_sparky_zombie_suicide"], self, "j_spineupper");
    self playSound(0, "zmb_elemental_zombie_explode_elec");
  }
}

function function_86aaed61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(newval)) {
    return;
  }
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval >= 1) {
    if(!isDefined(self.var_e863c331)) {
      self.var_e863c331 = self playLoopSound("zmb_electrozomb_lp", 0.2);
    }
    fx = playFXOnTag(localclientnum, level._effect["elemental_electric_spark"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, fx, 1);
  }
}