/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_pap_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#namespace zm_island_pap_quest;

function init() {
  clientfield::register("scriptmover", "show_part", 9000, 1, "int", &function_97bd83a7, 0, 0);
  clientfield::register("actor", "zombie_splash", 9000, 1, "int", &function_b2ce2a08, 0, 0);
  clientfield::register("world", "lower_pap_water", 9000, 2, "int", &lower_pap_water, 0, 0);
}

function function_97bd83a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["glow_piece"], self, "tag_origin");
}

function function_b2ce2a08(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["water_splash"], self.origin + (vectorscale((0, 0, -1), 48)));
}

function lower_pap_water(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level thread function_cc69986f(-432, 22, 3);
  } else {
    if(newval == 2) {
      level thread function_cc69986f(-454, 22, 3);
    } else if(newval == 3) {
      level thread function_cc69986f(-476, 22, 3);
    }
  }
}

function function_cc69986f(n_curr, var_e1344a83, n_time) {
  n_end = n_curr - var_e1344a83;
  var_c1c93aba = 187.5;
  n_delta = var_e1344a83 / var_c1c93aba;
  var_c0b3756a = n_curr;
  while(var_c0b3756a >= n_end) {
    var_c0b3756a = var_c0b3756a - n_delta;
    setwavewaterheight("bunker_pap_room_water", var_c0b3756a);
    wait(0.016);
  }
  if(var_c0b3756a < n_end) {
    setwavewaterheight("bunker_pap_room_water", n_end);
  }
}