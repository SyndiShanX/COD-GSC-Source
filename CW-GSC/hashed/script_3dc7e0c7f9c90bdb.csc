/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3dc7e0c7f9c90bdb.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_63c7213c;

function private autoexec __init__system__() {
  system::register(#"hash_3c43448fdb77ea73", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival() && !zm_utility::is_classic()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_1e2b95e15661dad")) && !getdvarint(#"hash_730311c63805303a", 0) && !is_true(level.var_1d1a6e08)) {
    return;
  }

  clientfield::register("actor", "soul_capture_zombie_fire", 1, 1, "int", &soul_capture_zombie_fire, 0, 0);
  clientfield::register("scriptmover", "soul_capture_leave", 1, 1, "int", &soul_capture_leave, 0, 0);
  clientfield::register("scriptmover", "soul_capture_timer", 1, 1, "int", &function_86bba240, 0, 0);
  level.var_1ffd81e8 = [];
}

function soul_capture_zombie_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_f6a6e73d)) {
      self.var_f6a6e73d = util::playFXOnTag(fieldname, #"hash_5a09c40118c2df6e", self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_f6a6e73d)) {
    stopfx(fieldname, self.var_f6a6e73d);
    self.var_f6a6e73d = undefined;
  }
}

function soul_capture_leave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.n_fx)) {
      var_70609425 = self.origin + (0, 0, 5000);
      self.b_success = 1;
      self.var_c2310a57 = playFX(fieldname, #"zm_ai/fx9_orda_spawn_portal_c", var_70609425, (1, 0, 0), (0, 0, 1));
      self playrumbleonentity(fieldname, "sr_world_event_soul_capture_crystal_leave_rumble");
    }

    if(!isDefined(self.soundorigin)) {
      self.soundorigin = self.origin;
      playSound(fieldname, #"hash_46461ba72b8ab7a2", self.soundorigin);
      soundloopemitter("evt_sur_we_portal_common_lp", self.soundorigin);
    }

    return;
  }

  if(isDefined(self.var_c2310a57)) {
    stopfx(fieldname, self.var_c2310a57);
  }

  if(isDefined(self.soundorigin)) {
    playSound(fieldname, #"hash_3c03699766f040c7", self.soundorigin);
    soundstoploopemitter("evt_sur_we_portal_common_lp", self.soundorigin);
    self.soundorigin = undefined;
  }

  self stoprumble(fieldname, "sr_world_event_soul_capture_crystal_leave_rumble");
}

function function_86bba240(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.model === # "p9_fxanim_sv_dragon_console_mod") {
    if(bwastimejump) {
      self playrenderoverridebundle(#"hash_5e190029d2c86444");
      self function_78233d29(#"hash_5e190029d2c86444", "", "Brightness", 1);
      self function_78233d29(#"hash_5e190029d2c86444", "", "Threshold", 1);
    } else {
      self thread function_d0b587e2(fieldname);
    }

    return;
  }

  if(bwastimejump) {
    self.var_59419da4[fieldname] = playFX(fieldname, #"hash_37652ead88a2ed5e", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(isDefined(self.var_59419da4[fieldname])) {
    stopfx(fieldname, self.var_59419da4[fieldname]);
    self.var_59419da4[fieldname] = undefined;
  }
}

function private function_d0b587e2(localclientnum) {
  self endon(#"death");
  n_percent = 1;
  n_increment = 1 / 50;

  while(n_percent > 0) {
    self function_78233d29(#"hash_5e190029d2c86444", "", "Threshold", n_percent);
    n_percent -= n_increment;
    wait 1;
  }

  self function_78233d29(#"hash_5e190029d2c86444", "", "Threshold", 0);
}