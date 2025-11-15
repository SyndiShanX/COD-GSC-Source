/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_quest_fire.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_tomb_quest_fire;

function main() {
  clientfield::register("scriptmover", "barbecue_fx", 21000, 1, "int", & barbecue_fx, 0, 0);
}

function function_f53f6b0a(localclientnum) {
  self notify("stop_bbq_fx_loop");
  self endon("stop_bbq_fx_loop");
  self endon("entityshutdown");
  while(true) {
    playFXOnTag(localclientnum, level._effect["fire_sacrifice_flame"], self, "tag_origin");
    wait(0.5);
  }
}

function barbecue_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread function_f53f6b0a(localclientnum);
    level thread function_ebebc90(self);
  } else {
    self notify("stop_bbq_fx_loop");
  }
}

function function_ebebc90(entity) {
  origin = entity.origin;
  audio::playloopat("zmb_squest_fire_bbq_lp", origin);
  entity util::waittill_any("stop_bbq_fx_loop", "entityshutdown");
  audio::stoploopat("zmb_squest_fire_bbq_lp", origin);
}