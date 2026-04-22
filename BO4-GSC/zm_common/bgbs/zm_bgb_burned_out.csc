/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_burned_out.csc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_utility;
#namespace zm_bgb_burned_out;

autoexec __init__system__() {
  system::register(#"zm_bgb_burned_out", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_burned_out", "event");
  clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter", &zm_bgb_burned_out_1p_toplayer_cb, 0, 0);
  clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter", &zm_bgb_burned_out_3p_allplayers_cb, 0, 0);
  clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter", &zm_bgb_burned_out_fire_torso_actor_cb, 0, 0);
  clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter", &zm_bgb_burned_out_fire_torso_vehicle_cb, 0, 0);
  level._effect["zm_bgb_burned_out" + "_1p"] = "zombie/fx_bgb_burned_out_1p_zmb";
  level._effect["zm_bgb_burned_out" + "_3p"] = "zombie/fx_bgb_burned_out_3p_zmb";
  level._effect["zm_bgb_burned_out" + "_fire_torso"] = "zombie/fx_bgb_burned_out_fire_torso_zmb";
}

zm_bgb_burned_out_1p_toplayer_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self zm_utility::function_f8796df3(localclientnum)) {
    util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_1p"], self, "tag_origin");
  }
}

zm_bgb_burned_out_3p_allplayers_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self zm_utility::function_f8796df3(localclientnum)) {
    util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_3p"], self, "tag_origin");
  }
}

zm_bgb_burned_out_fire_torso_actor_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  fire_torso_tag = "j_spinelower";

  if(isDefined(self gettagorigin(fire_torso_tag))) {
    fire_torso_tag = "tag_origin";
  }

  util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, fire_torso_tag);

  if(!isDefined(self.var_de2c8500)) {
    self playSound(localclientnum, #"hash_4539c48ed56aa72b");
    self.var_de2c8500 = self playLoopSound(#"hash_729fda7f41c1cb45");
  }
}

zm_bgb_burned_out_fire_torso_vehicle_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  fire_torso_tag = "tag_body";

  if(isDefined(self gettagorigin(fire_torso_tag))) {
    fire_torso_tag = "tag_origin";
  }

  util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, fire_torso_tag);

  if(!isDefined(self.var_de2c8500)) {
    self playSound(localclientnum, #"hash_4539c48ed56aa72b");
    self.var_de2c8500 = self playLoopSound(#"hash_729fda7f41c1cb45");
  }
}