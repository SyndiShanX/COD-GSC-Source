/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_mechz_claw.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_ai_mechz_claw;

function autoexec __init__sytem__() {
  system::register("zm_ai_mechz_claw", &__init__, undefined, undefined);
}

function private __init__() {
  clientfield::register("actor", "mechz_fx", 21000, 12, "int", &function_22b149ce, 0, 0);
  clientfield::register("scriptmover", "mechz_claw", 21000, 1, "int", &function_2ad55883, 0, 0);
  clientfield::register("actor", "mechz_wpn_source", 21000, 1, "int", &function_54ae128d, 0, 0);
  clientfield::register("toplayer", "mechz_grab", 21000, 1, "int", &function_8dfa08c1, 0, 0);
  level.mechz_detach_claw_override = &mechz_detach_claw_override;
}

function private __main__() {}

function private mechz_detach_claw_override(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  pos = self gettagorigin("tag_claw");
  ang = self gettagangles("tag_claw");
  velocity = self getvelocity();
  dynent = createdynentandlaunch(localclientnum, "c_t7_zm_dlchd_origins_mech_claw", pos, ang, self.origin, velocity);
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_grappling_source_fx");
  self playSound(0, "zmb_ai_mechz_destruction");
  playFXOnTag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "tag_grappling_source_fx");
}

function private function_22b149ce(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {}

function private function_2ad55883(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    playFXOnTag(localclientnum, level._effect["mechz_claw"], self, "tag_origin");
  }
}

function private function_54ae128d(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.var_ba7e45cf = playFXOnTag(localclientnum, level._effect["mechz_wpn_source"], self, "j_elbow_le");
  } else if(isDefined(self.var_ba7e45cf)) {
    stopfx(localclientnum, self.var_ba7e45cf);
    self.var_ba7e45cf = undefined;
  }
}

function private function_8dfa08c1(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self hideviewlegs();
  } else {
    self showviewlegs();
  }
}