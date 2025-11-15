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
  clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter", &function_874dcef1, 0, 0);
  clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter", &function_5b403c46, 0, 0);
  clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter", &function_908b00b2, 0, 0);
  clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter", &function_35616d2, 0, 0);
  level._effect["zm_bgb_burned_out" + "_1p"] = "zombie/fx_bgb_burned_out_1p_zmb";
  level._effect["zm_bgb_burned_out" + "_3p"] = "zombie/fx_bgb_burned_out_3p_zmb";
  level._effect["zm_bgb_burned_out" + "_fire_torso"] = "zombie/fx_bgb_burned_out_fire_torso_zmb";
}

function_874dcef1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self zm_utility::function_f8796df3(localclientnum)) {
    util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_1p"], self, "tag_origin");
  }
}

function_5b403c46(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self zm_utility::function_f8796df3(localclientnum)) {
    util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_3p"], self, "tag_origin");
  }
}

function_908b00b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_54e59513 = "j_spinelower";

  if(isDefined(self gettagorigin(var_54e59513))) {
    var_54e59513 = "tag_origin";
  }

  util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_54e59513);

  if(!isDefined(self.var_de2c8500)) {
    self playSound(localclientnum, #"hash_4539c48ed56aa72b");
    self.var_de2c8500 = self playLoopSound(#"hash_729fda7f41c1cb45");
  }
}

function_35616d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_54e59513 = "tag_body";

  if(isDefined(self gettagorigin(var_54e59513))) {
    var_54e59513 = "tag_origin";
  }

  util::playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_54e59513);

  if(!isDefined(self.var_de2c8500)) {
    self playSound(localclientnum, #"hash_4539c48ed56aa72b");
    self.var_de2c8500 = self playLoopSound(#"hash_729fda7f41c1cb45");
  }
}