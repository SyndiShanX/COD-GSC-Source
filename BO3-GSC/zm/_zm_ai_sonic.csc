/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_sonic.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_ai_sonic;

function autoexec __init__sytem__() {
  system::register("zm_ai_sonic", & __init__, undefined, undefined);
}

function __init__() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("actor", "issonic", 21000, 1, "int", & sonic_zombie_callback, 0, 0);
}

function sonic_zombie_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread sonic_ambient_sounds(localclientnum);
  } else {
    self thread function_59e62cc8(localclientnum);
  }
}

function sonic_ambient_sounds(client_num) {
  if(client_num != 0) {
    return;
  }
  self playLoopSound("evt_sonic_ambient_loop", 1);
}

function function_59e62cc8(client_num) {
  self notify("stop_sounds");
}