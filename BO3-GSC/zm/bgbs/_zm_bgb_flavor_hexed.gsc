/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_flavor_hexed.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_flavor_hexed;

function autoexec __init__sytem__() {
  system::register("zm_bgb_flavor_hexed", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_flavor_hexed", "event", &event, undefined, undefined, undefined);
}

function event() {
  self endon("disconnect");
  self endon("bled_out");
  self.var_c3a5a8 = [];
  var_2cf032a6 = self.bgb_pack;
  foreach(str_bgb, var_410edbc8 in level.bgb) {
    if(var_410edbc8.consumable == 1) {
      if(!isinarray(var_2cf032a6, str_bgb) && str_bgb != "zm_bgb_flavor_hexed") {
        if(!isDefined(self.var_c3a5a8)) {
          self.var_c3a5a8 = [];
        } else if(!isarray(self.var_c3a5a8)) {
          self.var_c3a5a8 = array(self.var_c3a5a8);
        }
        self.var_c3a5a8[self.var_c3a5a8.size] = str_bgb;
      }
    }
  }
  assert(self.var_c3a5a8.size, "");
  var_50f0f8bb = array::random(self.var_c3a5a8);
  self thread function_9a45adfb(var_50f0f8bb);
}

function function_9a45adfb(var_50f0f8bb) {
  wait(1);
  self thread function_655e0571(var_50f0f8bb);
  self playsoundtoplayer("zmb_bgb_flavorhex", self);
  self thread bgb::give(var_50f0f8bb);
  arrayremovevalue(self.var_c3a5a8, var_50f0f8bb);
}

function function_655e0571(var_50f0f8bb) {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_gumball_anim_give");
  self waittill("bgb_update_give_" + var_50f0f8bb);
  self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
  self waittill("bgb_update", var_1531e8c4, var_9a4acf7);
  if(var_9a4acf7 === var_50f0f8bb && self.var_c3a5a8.size) {
    var_df8558a0 = array::random(self.var_c3a5a8);
    self playsoundtoplayer("zmb_bgb_flavorhex", self);
    self thread function_21f6c6f5(var_df8558a0);
    self bgb::give(var_df8558a0);
  }
}

function function_21f6c6f5(var_50f0f8bb) {
  self endon("disconnect");
  self endon("bled_out");
  self waittill("bgb_update_give_" + var_50f0f8bb);
  self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
}