/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_octobomb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_octobomb;

function autoexec __init__sytem__() {
  system::register("zm_weap_octobomb", & __init__, & __main__, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "octobomb_fx", 1, 2, "int", & octobomb_fx, 1, 0);
  clientfield::register("actor", "octobomb_spores_fx", 1, 2, "int", & octobomb_spores_fx, 1, 0);
  clientfield::register("actor", "octobomb_tentacle_hit_fx", 1, 1, "int", & octobomb_tentacle_hit_fx, 1, 0);
  clientfield::register("actor", "zombie_explode_fx", 1, 1, "counter", & octobomb_zombie_explode_fx, 1, 0);
  clientfield::register("actor", "zombie_explode_fx", -8000, 1, "counter", & octobomb_zombie_explode_fx, 1, 0);
  clientfield::register("actor", "octobomb_zombie_explode_fx", 8000, 1, "counter", & octobomb_zombie_explode_fx, 1, 0);
  clientfield::register("missile", "octobomb_spit_fx", 1, 2, "int", & octobomb_spit_fx, 1, 0);
  clientfield::register("toplayer", "octobomb_state", 1, 3, "int", undefined, 0, 1);
  setupclientfieldcodecallbacks("toplayer", 1, "octobomb_state");
}

function __main__() {
  if(!zm_weapons::is_weapon_included(getweapon("octobomb"))) {
    return;
  }
  level._effect["octobomb_explode_fx"] = "zombie/fx_octobomb_explo_death_zod_zmb";
  level._effect["octobomb_spores"] = "zombie/fx_octobomb_sporesplosion_zod_zmb";
  level._effect["octobomb_spores_spine"] = "zombie/fx_octobomb_spore_burn_torso_zod_zmb";
  level._effect["octobomb_spores_legs"] = "zombie/fx_octobomb_spore_burn_leg_zod_zmb";
  level._effect["octobomb_sporesplosion"] = "zombie/fx_octobomb_sporesplosion_tell_zod_zmb";
  level._effect["octobomb_ug_spores"] = "zombie/fx_octobomb_sporesplosion_ee_zod_zmb";
  level._effect["octobomb_ug_spores_spine"] = "zombie/fx_octobomb_spore_burn_torso_ee_zod_zmb";
  level._effect["octobomb_ug_spores_legs"] = "zombie/fx_octobomb_spore_burn_leg_zod_zmb";
  level._effect["octobomb_ug_sporesplosion"] = "zombie/fx_octobomb_sporesplosion_tell_ee_zod_zmb";
  level._effect["octobomb_tentacle_hit"] = "impacts/fx_flesh_hit_knife_lg_zmb";
  level._effect["zombie_explode"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
}

function octobomb_tentacle_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.fx_octobomb_tentacle_hit = playFXOnTag(localclientnum, level._effect["octobomb_tentacle_hit"], self, "j_spineupper");
  } else if(isDefined(self.fx_octobomb_tentacle_hit)) {
    stopfx(localclientnum, self.fx_octobomb_tentacle_hit);
    self.fx_octobomb_tentacle_hit = undefined;
  }
}

function octobomb_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 3: {
      playFX(localclientnum, level._effect["octobomb_explode_fx"], self.origin, anglestoup(self.angles));
      break;
    }
    case 2: {
      fx_octobomb = level._effect["octobomb_ug_spores"];
      playFXOnTag(localclientnum, fx_octobomb, self, "tag_origin");
      break;
    }
    default: {
      fx_octobomb = level._effect["octobomb_spores"];
      playFXOnTag(localclientnum, fx_octobomb, self, "tag_origin");
      break;
    }
  }
}

function octobomb_spores_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread octobomb_spore_fx_on(localclientnum, newval);
  }
}

function octobomb_spore_fx_on(localclientnum, n_fx_type) {
  self endon("entityshutdown");
  if(n_fx_type == 2) {
    fx_spine = level._effect["octobomb_ug_spores_spine"];
    fx_legs = level._effect["octobomb_ug_spores_legs"];
  } else {
    fx_spine = level._effect["octobomb_spores_spine"];
    fx_legs = level._effect["octobomb_spores_legs"];
  }
  self.fx_octobomb_spores_spine = playFXOnTag(localclientnum, fx_spine, self, "j_spine4");
  wait(3.5);
  self.fx_octobomb_spores_leg_ri = playFXOnTag(localclientnum, fx_legs, self, "j_hip_ri");
  self.fx_octobomb_spores_leg_le = playFXOnTag(localclientnum, fx_legs, self, "j_hip_le");
  wait(3.5);
  stopfx(localclientnum, self.fx_octobomb_spores_spine);
  stopfx(localclientnum, self.fx_octobomb_spores_leg_ri);
  stopfx(localclientnum, self.fx_octobomb_spores_leg_le);
}

function octobomb_zombie_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(util::is_mature() && !util::is_gib_restricted_build()) {
    playFXOnTag(localclientnum, level._effect["zombie_explode"], self, "j_spinelower");
  }
}

function octobomb_spit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 2) {
    fx_spit = level._effect["octobomb_ug_sporesplosion"];
  } else {
    fx_spit = level._effect["octobomb_sporesplosion"];
  }
  level thread octobomb_spit_fx_and_cleanup(localclientnum, self.origin, self.angles, fx_spit);
}

function octobomb_spit_fx_and_cleanup(localclientnum, v_origin, v_angles, fx_spit) {
  fx_id = playFX(localclientnum, fx_spit, v_origin, anglestoup(v_angles));
  wait(3.416675);
  stopfx(localclientnum, fx_id);
}