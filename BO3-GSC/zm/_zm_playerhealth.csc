/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_playerhealth.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_playerhealth;

function autoexec __init__sytem__() {
  system::register("zm_playerhealth", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "sndZombieHealth", 21000, 1, "int", & sndzombiehealth, 0, 1);
  visionset_mgr::register_overlay_info_style_speed_blur("zm_health_blur", 1, 1, 0.1, 0.5, 0.75, 0, 0, 500, 500, 0);
}

function sndzombiehealth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isdefined(self.sndzombiehealthid)) {
      playsound(0, "zmb_health_lowhealth_enter", self.origin);
      self.sndzombiehealthid = self playloopsound("zmb_health_lowhealth_loop");
    }
  } else if(isdefined(self.sndzombiehealthid)) {
    self stoploopsound(self.sndzombiehealthid);
    self.sndzombiehealthid = undefined;
    if(!(isdefined(self.inlaststand) && self.inlaststand)) {
      playsound(0, "zmb_health_lowhealth_exit", self.origin);
    }
  }
}