/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_siegebot_nikolai.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace zm_siegebot_nikolai;

function autoexec __init__sytem__() {
  system::register("zm_siegebot_nikolai", & __init__, undefined, undefined);
}

function __init__() {
  vehicle::add_vehicletype_callback("siegebot_nikolai", & on_spawned);
  clientfield::register("vehicle", "nikolai_destroyed_r_arm", 12000, 1, "int", & nikolai_destroyed_r_arm, 0, 0);
  clientfield::register("vehicle", "nikolai_destroyed_l_arm", 12000, 1, "int", & nikolai_destroyed_l_arm, 0, 0);
  clientfield::register("vehicle", "nikolai_destroyed_r_chest", 12000, 1, "int", & nikolai_destroyed_r_chest, 0, 0);
  clientfield::register("vehicle", "nikolai_destroyed_l_chest", 12000, 1, "int", & nikolai_destroyed_l_chest, 0, 0);
  clientfield::register("vehicle", "nikolai_weakpoint_l_fx", 12000, 1, "int", & nikolai_weakpoint_l_fx, 0, 0);
  clientfield::register("vehicle", "nikolai_weakpoint_r_fx", 12000, 1, "int", & nikolai_weakpoint_r_fx, 0, 0);
  clientfield::register("vehicle", "nikolai_gatling_tell", 12000, 1, "int", & nikolai_gatling_tell, 0, 0);
  clientfield::register("missile", "harpoon_impact", 12000, 1, "int", & harpoon_impact, 0, 0);
  clientfield::register("vehicle", "play_raps_trail_fx", 12000, 1, "int", & function_66f3947f, 0, 0);
  clientfield::register("vehicle", "raps_landing", 12000, 1, "int", & raps_landing, 0, 0);
}

function on_spawned(localclientnum) {
  self useanimtree($generic);
  self thread function_89d7e567(localclientnum);
  self thread function_48c3fc7d(localclientnum);
}

function function_48c3fc7d(localclientnum) {
  self endon("entityshutdown");
  self notify("hash_48c3fc7d");
  self endon("hash_48c3fc7d");
  nikolai = undefined;
  while(true) {
    level waittill("hash_eeba0c72");
    if(!isDefined(nikolai)) {
      allents = getEntArray(localclientnum);
      foreach(ent in allents) {
        if(ent.model === "c_zom_dlc_waw_nikolai_fb" && self isentitylinkedtotag(ent)) {
          nikolai = ent;
        }
      }
    }
    bottle = undefined;
    if(isDefined(nikolai)) {
      origin = nikolai gettagorigin("j_ringbase_le");
      angles = nikolai gettagangles("j_ringbase_le");
      up = anglestoup(angles);
      angles = angles + vectorscale((0, 0, 1), 180);
      bottle = spawn(localclientnum, origin, "script_model");
      bottle setModel("p7_zm_sta_bottle_vodka_01");
      bottle.angles = angles;
      nikolai thread function_97181777(bottle);
    }
    level waittill("hash_13cefe1f");
    if(isDefined(bottle)) {
      bottle delete();
    }
  }
}

function function_97181777(bottle) {
  while(isDefined(self) && isDefined(bottle)) {
    origin = self gettagorigin("j_ringbase_le");
    angles = self gettagangles("j_ringbase_le");
    forward = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    angles = angles + vectorscale((0, 0, 1), 180);
    offset = (forward * 1.6) + (right * -1.2) + (up * 11);
    bottle.origin = origin + offset;
    bottle.angles = angles;
    wait(0.016);
  }
}

function function_89d7e567(localclientnum) {
  self endon("disconnect");
  self endon("entityshutdown");
  while(true) {
    self waittill("gunner_weapon_fired");
    self setanim("ai_zm_dlc3_russian_mech_shoot_gunbarrel", 1, 0, 1);
  }
}

function nikolai_gatling_tell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_16903828 = playFXOnTag(localclientnum, level._effect["nikolai_gatling_tell"], self, "tag_gunner_aim1");
    self playSound(localclientnum, "zmb_nikolaibot_rapidfire_start", self gettagorigin("tag_eye"));
    self.var_464db63 = self playLoopSound("zmb_nikolaibot_rapidfire_barrel_lp");
  } else {
    if(isDefined(self.var_16903828)) {
      stopfx(localclientnum, self.var_16903828);
    }
    self playSound(localclientnum, "zmb_nikolaibot_rapidfire_end", self gettagorigin("tag_eye"));
    if(isDefined(self.var_464db63)) {
      self stoploopsound(self.var_464db63);
      self.var_464db63 = undefined;
    }
  }
}

function nikolai_destroyed_r_arm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_01_d1");
    self playSound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_01_d1"));
  }
}

function nikolai_destroyed_l_arm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_02_d1");
    self playSound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_02_d1"));
  }
}

function nikolai_destroyed_r_chest(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_03_d1");
    self playSound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_03_d1"));
  }
}

function nikolai_destroyed_l_chest(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_04_d1");
    self playSound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_04_d1"));
  }
}

function nikolai_weakpoint_r_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_da48848b = playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_fx"], self, "tag_heat_vent_01_d0");
  } else if(isDefined(self.var_da48848b)) {
    stopfx(localclientnum, self.var_da48848b);
    self.var_da48848b = undefined;
  }
}

function nikolai_weakpoint_l_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_f639a615 = playFXOnTag(localclientnum, level._effect["nikolai_weakpoint_fx"], self, "tag_heat_vent_02_d0");
  } else if(isDefined(self.var_f639a615)) {
    stopfx(localclientnum, self.var_f639a615);
    self.var_f639a615 = undefined;
  }
}

function harpoon_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["nikolai_harpoon_impact"], self.origin, anglesToForward(self.angles) * -1);
    playSound(0, "zmb_nikolaibot_harpoon_impact", self.origin + vectorscale((0, 0, 1), 10));
    playrumbleonposition(localclientnum, "harpoon_land", self.origin + vectorscale((0, 0, 1), 10));
  }
}

function function_66f3947f(n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, b_demo_jump) {
  self endon("disconnect");
  self endon("entityshutdown");
  if(n_val_new) {
    self.fx_trail = playFXOnTag(n_local_client, level._effect["nikolai_raps_trail"], self, "tag_body");
    self playSound(0, "wpn_nikolaibot_raps_launch");
  } else if(isDefined(self.fx_trail)) {
    stopfx(n_local_client, self.fx_trail);
  }
}

function raps_landing(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["nikolai_raps_landing"], self, "tag_origin");
    self playSound(0, "zmb_nikolaibot_raps_impact");
  }
}