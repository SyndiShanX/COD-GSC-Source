/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\ai\zombie_dog_toxic_cloud.csc
***************************************************/

#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zombie_dog_toxic_cloud;

function private autoexec __init__system__() {
  system::register(#"hash_33449a50d9656246", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_584428de7fdfefe2", 1, 1, "int", &function_3c2a50f4, 0, 0);
  clientfield::register("toplayer", "" + # "hash_313a6af163e4bef1", 1, 1, "counter", &function_d89c5699, 0, 0);
  clientfield::register("toplayer", "" + # "hash_10eff6a8464fb235", 1, 1, "counter", &function_29b682f8, 0, 0);
  clientfield::register("actor", "pustule_pulse_plague", 1, 1, "int", &function_a17af3df, 0, 0);
}

function private postinit() {}

function function_d89c5699(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.time_to_wait)) {
    self.time_to_wait = 0;
  }

  if(isDefined(self.time_to_wait) && self.time_to_wait < gettime()) {
    if(!isDefined(self.var_bb7d3361)) {
      self playSound(bwastimejump, #"hash_77703efabee7dabc");
      self.var_bb7d3361 = self playLoopSound(#"hash_35083568f87ab28a");
    }

    self thread postfx::playpostfxbundle(#"hash_15272b37ec3c6110");
    self thread function_bdc0d799(bwastimejump);
    return;
  }

  self.time_to_wait = gettime() + 1000;
}

function function_29b682f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::waittill_dobj(bwasdemojump);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.time_to_wait)) {
    self.time_to_wait = 0;
  }

  if(isDefined(self.time_to_wait) && self.time_to_wait < gettime()) {
    if(!isDefined(self.var_bb7d3361)) {
      self playSound(bwasdemojump, #"hash_77703efabee7dabc");
      self.var_bb7d3361 = self playLoopSound(#"hash_35083568f87ab28a");
    }

    self thread postfx::playpostfxbundle(#"hash_15272b37ec3c6110");
    self thread function_bdc0d799(bwasdemojump);
  } else {
    self.time_to_wait = gettime() + 1000;
  }

  self playrumbleonentity(bwasdemojump, "zm_plague_hound_bite_rumble");
  self playSound(bwasdemojump, #"hash_34a8404fc3e64767");
}

function function_bdc0d799(localclientnum) {
  self endon(#"death");
  self.time_to_wait = gettime() + 1000;

  while(true) {
    if(isDefined(self.time_to_wait) && self.time_to_wait < gettime()) {
      self.time_to_wait = 0;
      break;
    } else {
      if(isDefined(self.var_bb7d3361)) {
        self playSound(localclientnum, #"hash_64112ddcbb607d69");
        self stoploopsound(self.var_bb7d3361);
        self.var_bb7d3361 = undefined;
      }

      self thread postfx::stoppostfxbundle(#"hash_15272b37ec3c6110");
      break;
    }

    wait 1;
  }
}

function function_3c2a50f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self thread function_87a4de18(fieldname);
    return;
  }

  if(bwastimejump === 0) {
    if(isDefined(self.var_348db091)) {
      stopfx(fieldname, self.var_348db091);
      self.var_348db091 = undefined;
    }
  }
}

function function_87a4de18(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  var_348db091 = playFX(localclientnum, "zm_ai/fx9_hound_plague_dth_aoe", self.origin + (0, 0, 18), anglestoup(self.angles));
  var_18407835 = self.origin + (0, 0, 18);
  self playSound(localclientnum, #"hash_1cbebe710791b56c");
  audio::playloopat(#"hash_155791cb3cba6094", var_18407835);
  wait 3.9;
  stopfx(localclientnum, var_348db091);
  audio::stoploopat(#"hash_155791cb3cba6094", var_18407835);
}

function function_a17af3df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self playrenderoverridebundle(#"hash_254bc28c3959a2ec");
    self callback::on_shutdown(&function_c88acbea);
    return;
  }

  function_c88acbea();
}

function function_c88acbea(params) {
  self stoprenderoverridebundle(#"hash_254bc28c3959a2ec");
}