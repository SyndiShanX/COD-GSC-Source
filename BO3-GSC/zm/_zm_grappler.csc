/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_grappler.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_grappler;

function autoexec __init__sytem__() {
  system::register("zm_grappler", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "grappler_beam_source", 15000, 1, "int", & function_79d05fa8, 0, 0);
  clientfield::register("scriptmover", "grappler_beam_target", 15000, 1, "int", & function_7bbbd82e, 0, 0);
}

function function_79d05fa8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.var_3d35ab43)) {
    level.var_3d35ab43 = [];
  }
  if(newval) {
    level.var_3d35ab43[localclientnum] = self;
  }
}

function function_7bbbd82e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.var_3d35ab43)) {
    level.var_3d35ab43 = [];
  }
  assert(isdefined(level.var_3d35ab43[localclientnum]));
  pivot = level.var_3d35ab43[localclientnum];
  if(newval) {
    thread function_55af4b5b(self, "tag_origin", pivot, 0.05);
  } else {
    self notify("hash_dabe9c83");
  }
}

function function_55af4b5b(player, tag, pivot, delay) {
  player endon("hash_dabe9c83");
  wait(delay);
  thread grapple_beam(player, tag, pivot);
}

function grapple_beam(player, tag, pivot) {
  level beam::launch(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
  player waittill("hash_dabe9c83");
  level beam::kill(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
}