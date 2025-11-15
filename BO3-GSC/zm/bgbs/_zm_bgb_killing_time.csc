/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_killing_time.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_killing_time;

function autoexec __init__sytem__() {
  system::register("zm_bgb_killing_time", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_killing_time", "activated");
  clientfield::register("actor", "zombie_instakill_fx", 1, 1, "int", & function_a81107fc, 0, 1);
  clientfield::register("toplayer", "instakill_upgraded_fx", 1, 1, "int", & function_cf8c9fce, 0, 0);
}

function function_cf8c9fce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {} else {
    self notify("hash_eb366021");
  }
}

function function_2a30e2ca(localclientnum) {
  self endon("death");
  self endon("end_demo_jump_listener");
  self endon("entityshutdown");
  self notify("hash_eb366021");
  self endon("hash_eb366021");
  while(true) {
    self.var_dedf9511 = self playSound(localclientnum, "zmb_music_box", self.origin);
    wait(4);
  }
}

function function_a81107fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval) {
    fxobj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    fxobj thread function_10dcbf51(localclientnum, fxobj);
  }
}

function private function_10dcbf51(localclientnum, fxobj) {
  fxobj playSound(localclientnum, "evt_ai_explode");
  wait(1);
  fxobj delete();
}