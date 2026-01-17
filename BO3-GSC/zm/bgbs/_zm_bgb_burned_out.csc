/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_burned_out.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_burned_out;

function autoexec __init__sytem__() {
  system::register("zm_bgb_burned_out", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_burned_out", "event");
  clientfield::register("toplayer", ("zm_bgb_burned_out" + "_1p") + "toplayer", 1, 1, "counter", &function_9c2ec371, 0, 0);
  clientfield::register("allplayers", ("zm_bgb_burned_out" + "_3p") + "_allplayers", 1, 1, "counter", &function_c8cfe3c0, 0, 0);
  clientfield::register("actor", ("zm_bgb_burned_out" + "_fire_torso") + "_actor", 1, 1, "counter", &function_34caa903, 0, 0);
  clientfield::register("vehicle", ("zm_bgb_burned_out" + "_fire_torso") + "_vehicle", 1, 1, "counter", &function_69abda16, 0, 0);
  level._effect["zm_bgb_burned_out" + "_1p"] = "zombie/fx_bgb_burned_out_1p_zmb";
  level._effect["zm_bgb_burned_out" + "_3p"] = "zombie/fx_bgb_burned_out_3p_zmb";
  level._effect["zm_bgb_burned_out" + "_fire_torso"] = "zombie/fx_bgb_burned_out_fire_torso_zmb";
}

function function_9c2ec371(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isthirdperson(localclientnum)) {
    playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_1p"], self, "tag_origin");
  }
}

function function_c8cfe3c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer() || self getlocalclientnumber() != localclientnum || isthirdperson(localclientnum)) {
    playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_3p"], self, "tag_origin");
  }
}

function function_34caa903(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_68b2c2e8 = "j_spinelower";
  if(isDefined(self gettagorigin(var_68b2c2e8))) {
    var_68b2c2e8 = "tag_origin";
  }
  playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_68b2c2e8);
}

function function_69abda16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_68b2c2e8 = "tag_body";
  if(isDefined(self gettagorigin(var_68b2c2e8))) {
    var_68b2c2e8 = "tag_origin";
  }
  playFXOnTag(localclientnum, level._effect["zm_bgb_burned_out" + "_fire_torso"], self, var_68b2c2e8);
}