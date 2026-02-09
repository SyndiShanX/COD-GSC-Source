/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_glaive.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_glaive;

function autoexec __init__sytem__() {
  system::register("zm_weap_glaive", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "slam_fx", 1, 1, "counter", &do_slam_fx, 0, 0);
  clientfield::register("toplayer", "throw_fx", 1, 1, "counter", &function_6b6e650c, 0, 0);
  clientfield::register("toplayer", "swipe_fx", 1, 1, "counter", &do_swipe_fx, 0, 0);
  clientfield::register("toplayer", "swipe_lv2_fx", 1, 1, "counter", &function_647dc27d, 0, 0);
  clientfield::register("actor", "zombie_slice_r", 1, 2, "counter", &function_bbeb4c2c, 1, 0);
  clientfield::register("actor", "zombie_slice_l", 1, 2, "counter", &function_38924d95, 1, 0);
  level._effect["sword_swipe_1p"] = "zombie/fx_sword_trail_1p_zod_zmb";
  level._effect["sword_swipe_lv2_1p"] = "zombie/fx_sword_trail_1p_lvl2_zod_zmb";
  level._effect["sword_bloodswipe_r_1p"] = "zombie/fx_sword_slash_right_1p_zod_zmb";
  level._effect["sword_bloodswipe_l_1p"] = "zombie/fx_sword_slash_left_1p_zod_zmb";
  level._effect["sword_bloodswipe_r_level2_1p"] = "zombie/fx_keeper_death_zod_zmb";
  level._effect["sword_bloodswipe_l_level2_1p"] = "zombie/fx_keeper_death_zod_zmb";
  level._effect["groundhit_1p"] = "zombie/fx_sword_slam_elec_1p_zod_zmb";
  level._effect["groundhit_3p"] = "zombie/fx_sword_slam_elec_3p_zod_zmb";
  level._effect["sword_lvl2_throw"] = "zombie/fx_sword_lvl2_throw_1p_zod_zmb";
}

function do_swipe_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  owner = self getowner(localclientnum);
  if(isDefined(owner) && owner == getlocalplayer(localclientnum)) {
    swipe_fx = playviewmodelfx(localclientnum, level._effect["sword_swipe_1p"], "tag_flash");
    wait(3);
    deletefx(localclientnum, swipe_fx, 1);
  }
}

function function_647dc27d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  owner = self getowner(localclientnum);
  if(isDefined(owner) && owner == getlocalplayer(localclientnum)) {
    swipe_lv2_fx = playviewmodelfx(localclientnum, level._effect["sword_swipe_lv2_1p"], "tag_flash");
    wait(3);
    deletefx(localclientnum, swipe_lv2_fx, 1);
  }
}

function function_bbeb4c2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(util::is_mature() && !util::is_gib_restricted_build()) {
    if(newval == 1) {
      playFXOnTag(localclientnum, level._effect["sword_bloodswipe_r_1p"], self, "j_spine4");
    } else if(newval == 2) {
      playFXOnTag(localclientnum, level._effect["sword_bloodswipe_r_level2_1p"], self, "j_spineupper");
    }
  }
  self playSound(0, "zmb_sword_zombie_explode");
}

function function_38924d95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(util::is_mature() && !util::is_gib_restricted_build()) {
    if(newval == 1) {
      playFXOnTag(localclientnum, level._effect["sword_bloodswipe_l_1p"], self, "j_spine4");
    } else if(newval == 2) {
      playFXOnTag(localclientnum, level._effect["sword_bloodswipe_l_level2_1p"], self, "j_spineupper");
    }
  }
  self playSound(0, "zmb_sword_zombie_explode");
}

function do_slam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  thread do_gravity_spike_fx(localclientnum, self, self.origin);
}

function function_6b6e650c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  owner = self getowner(localclientnum);
  if(isDefined(owner) && owner == getlocalplayer(localclientnum)) {
    var_b7fb3c1b = playfxoncamera(localclientnum, level._effect["sword_lvl2_throw"], (0, 0, 0), (0, 1, 0), (0, 0, 1));
    wait(3);
    deletefx(localclientnum, var_b7fb3c1b, 1);
  }
}

function do_gravity_spike_fx(localclientnum, owner, position) {
  var_f31c9d4c = 0;
  if(self isPlayer() && self islocalplayer() && !isdemoplaying()) {
    if(!isDefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
      var_f31c9d4c = 1;
    }
  }
  if(var_f31c9d4c) {
    fx = level._effect["groundhit_1p"];
    fwd = anglesToForward(owner.angles);
    playFX(localclientnum, fx, position + (fwd * 100), fwd);
  } else {
    fx = level._effect["groundhit_3p"];
    fwd = anglesToForward(owner.angles);
    playFX(localclientnum, fx, position, fwd);
  }
}

function getideallocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
  currentangle = (360 / fxcount) * fxindex;
  coscurrent = cos(currentangle + rotation);
  sincurrent = sin(currentangle + rotation);
  return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

function randomizelocation(startpos, max_x_offset, max_y_offset) {
  half_x = int(max_x_offset / 2);
  half_y = int(max_y_offset / 2);
  rand_x = randomintrange(half_x * -1, half_x);
  rand_y = randomintrange(half_y * -1, half_y);
  return startpos + (rand_x, rand_y, 0);
}

function ground_trace(startpos, owner) {
  trace_height = 50;
  trace_depth = 100;
  return bulletTrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}