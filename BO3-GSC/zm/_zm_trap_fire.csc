/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_trap_fire.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_trap_fire;

function autoexec __init__sytem__() {
  system::register("zm_trap_fire", & __init__, undefined, undefined);
}

function __init__() {
  a_traps = struct::get_array("trap_fire", "targetname");
  foreach(trap in a_traps) {
    clientfield::register("world", trap.script_noteworthy, 21000, 1, "int", & trap_fx_monitor, 0, 0);
  }
}

function trap_fx_monitor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  exploder_name = "trap_fire_" + fieldname;
  if(newval) {
    exploder::exploder(exploder_name);
  } else {
    exploder::stop_exploder(exploder_name);
  }
  fire_points = struct::get_array(fieldname, "targetname");
  foreach(point in fire_points) {
    if(!isdefined(point.script_noteworthy)) {
      if(newval) {
        point thread fire_trap_fx();
        continue;
      }
      point thread stop_trap_fx();
    }
  }
}

function fire_trap_fx() {
  ang = self.angles;
  forward = anglestoforward(ang);
  up = anglestoup(ang);
  if(isdefined(self.loopfx) && self.loopfx.size) {
    stop_trap_fx();
  }
  if(!isdefined(self.loopfx)) {
    self.loopfx = [];
  }
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    self.loopfx[i] = playfx(i, level._effect["fire_trap"], self.origin, forward, up, 0);
  }
}

function stop_trap_fx() {
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    if(isdefined(self.loopfx[i])) {
      stopfx(i, self.loopfx[i]);
    }
  }
  self.loopfx = [];
}