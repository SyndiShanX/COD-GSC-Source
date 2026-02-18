/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2ae7c487149cc862.csc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_4db53432;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("allplayers", "" + # "hash_63af42145e260fb5", 1, 2, "int", &function_4fd00e1f, 0, 0);
  clientfield::register("allplayers", "" + # "hash_5323a6afe3b7e366", 1, 1, "counter", &function_53ab1c7, 0, 0);
  clientfield::register("allplayers", "" + # "turnoff_scrambler", 1, 1, "counter", &function_ebf5d79, 0, 0);
  clientfield::register("toplayer", "" + # "hash_bd79b6ca5ca6bc0", 1, 2, "int", &function_f002c513, 0, 0);
  clientfield::register("toplayer", "" + # "dark_aether", 1, 1, "int", &function_98c5cac0, 0, 0);
  clientfield::register("toplayer", "" + # "teleport_blur", 1, 1, "int", &teleport_blur, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_37895eb34ae6a3b0", 1, 1, "counter", &function_9609c8b9, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_2a3141c1214d6eaa", 1, 1, "counter", &function_6a4e64d1, 0, 0);
  clientfield::register("scriptmover", "" + # "aether_beam", 1, 1, "int", &function_94fa6eb5, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_bd6060c10031f98", 1, 1, "int", &function_7999ed44, 0, 0);
  clientfield::register("scriptmover", "" + # "barrier_fx", 1, 1, "int", &barrier_fx, 0, 0);
  clientfield::register("scriptmover", "" + # "jellyfish_trail", 1, 1, "counter", &function_20a79dc5, 0, 0);
  clientfield::register("world", "" + # "hash_77ba2c603a746873", 1, 1, "int", &function_eac49163, 0, 0);
  util::waitforclient(0);
}

function function_94fa6eb5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_40433812 = playFX(fieldname, "sr/fx9_obj_orda_spawn_portal", self.origin + (0, 0, 7500), anglesToForward(self.angles), anglestoup(self.angles));
    self.var_3e3964d7 = playFX(fieldname, "sr/fx9_orda_aether_portal_beam", self.origin, anglesToForward(self.angles), anglestoup(self.angles));

    if(!isDefined(self.var_d416b1e7)) {
      playSound(fieldname, #"hash_70ed741814a290fd", self.origin + (0, 0, 3000));
      self.var_d416b1e7 = self playLoopSound(#"hash_53739f99da95c943", undefined, (0, 0, 3000));
    }

    if(!isDefined(self.var_1f2ef20a)) {
      self.var_1f2ef20a = self playLoopSound(#"hash_48fab12b9bb60979", undefined, (0, 0, 500));
    }

    return;
  }

  if(isDefined(self.var_40433812)) {
    stopfx(fieldname, self.var_40433812);
    self.var_40433812 = undefined;
  }

  if(isDefined(self.var_3e3964d7)) {
    stopfx(fieldname, self.var_3e3964d7);
    self.var_3e3964d7 = undefined;
  }

  if(isDefined(self.var_d416b1e7)) {
    playSound(fieldname, #"hash_1442f26e3f7ba2c4", self.origin + (0, 0, 3000));
    self stoploopsound(self.var_d416b1e7);
    self.var_d416b1e7 = undefined;
  }

  if(isDefined(self.var_1f2ef20a)) {
    self stoploopsound(self.var_1f2ef20a);
    self.var_1f2ef20a = undefined;
  }

  self playrumbleonentity(fieldname, "sr_payload_portal_final_rumble");
  earthquake(fieldname, 0.25, 1, self.origin, 4000);
}

function function_7999ed44(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_a5ded638 = playFX(fieldname, "zombie/fx9_aether_crystal_lg_obj_holdout", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
    self.var_1181af89 = playFX(fieldname, "sr/fx9_obj_holdout_env_signifier", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(isDefined(self.var_a5ded638)) {
    killfx(fieldname, self.var_a5ded638);
    self.var_a5ded638 = undefined;
  }

  if(isDefined(self.var_1181af89)) {
    killfx(fieldname, self.var_1181af89);
    self.var_1181af89 = undefined;
  }

  if(isDefined(self.var_fec2778b)) {
    killfx(fieldname, self.var_fec2778b);
    self.var_fec2778b = undefined;
  }
}

function function_98c5cac0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump == 1) {
    if(!function_65b9eb0f(fieldname)) {
      self postfx::playpostfxbundle(#"hash_7f1cd473dc07762");
    }

    if(!isDefined(self.var_5bd4db29)) {
      self.var_5bd4db29 = self playLoopSound(#"hash_7244e9d74d7ada8a");
    }

    self setenemyglobalscrambler(1);
    return;
  }

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  self postfx::stoppostfxbundle(#"hash_7f1cd473dc07762");

  if(isDefined(self.var_5bd4db29)) {
    self stoploopsound(self.var_5bd4db29);
    self.var_5bd4db29 = undefined;
  }

  if(!is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    self setenemyglobalscrambler(0);
  }
}

function function_f002c513(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  self endon(#"death");

  if(wasdemojump == 1) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    if(!isDefined(self.var_706728bf)) {
      self.var_706728bf = playfxoncamera(fieldname, "sr/fx9_obj_holdout_camera_signifier", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    }

    self playrumbleonentity(fieldname, "sr_transmitter_clear");
    earthquake(fieldname, 0.25, 0.5, self.origin, 80);
    self postfx::playpostfxbundle(#"pstfx_speedblur");
    self function_116b95e5(#"pstfx_speedblur", #"inner mask", 0.2);
    self function_116b95e5(#"pstfx_speedblur", #"outer mask", 0.4);

    if(!isDefined(self.var_3e1f31af)) {
      self playSound(fieldname, #"hash_423712ee67e9a7df");
      self.var_3e1f31af = self playLoopSound(#"hash_3abb737de31477c1");
    }

    self thread function_d233fb1f(fieldname);
    return;
  }

  if(wasdemojump == 2) {
    if(!isDefined(self.var_87368464)) {
      self.var_87368464 = playfxoncamera(fieldname, "sr/fx9_obj_holdout_camera_signifier_start", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    }

    return;
  }

  self notify(#"stop_blur");

  if(isDefined(self.var_706728bf)) {
    stopfx(fieldname, self.var_706728bf);
    self.var_706728bf = undefined;
    self playrumbleonentity(fieldname, "sr_transmitter_clear");
    earthquake(fieldname, 0.25, 0.5, self.origin, 80);
  }

  if(isDefined(self.var_3e1f31af)) {
    self playSound(fieldname, #"hash_14b384e8b10abaca");
    self stoploopsound(self.var_3e1f31af);
    self.var_3e1f31af = undefined;
  }

  waitframe(1);

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  self function_116b95e5(#"pstfx_speedblur", #"blur", 0);
  self postfx::exitpostfxbundle(#"pstfx_speedblur");
}

function function_d233fb1f(localclientnum) {
  self endon(#"death", #"disconnect", #"stop_blur");
  var_9b8a1091 = 0.01;
  self playSound(localclientnum, #"hash_20493da3bbf6cbbe");

  while(true) {
    self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
    wait 0.08;
    var_9b8a1091 += 0.01;

    if(var_9b8a1091 == 0.1) {
      self playrumbleonentity(localclientnum, "damage_light");
    }

    if(var_9b8a1091 > 0.1) {
      while(var_9b8a1091 > 0) {
        var_9b8a1091 -= 0.01;
        self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
        wait 0.08;
      }

      self playSound(localclientnum, #"hash_20493da3bbf6cbbe");
    }
  }
}

function function_eac49163(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump == 1) {
    function_be93487f(fieldname, 2, 1, 1, 0, 0);
    setexposureactivebank(fieldname, 2);
    var_90a50598 = struct::get_array("jellyfish_large", "targetname");

    foreach(var_b6e76b65 in var_90a50598) {
      var_b6e76b65.var_b965b5e5 = util::spawn_model(fieldname, var_b6e76b65.model, var_b6e76b65.origin);
    }

    waitframe(1);

    foreach(var_b6e76b65 in var_90a50598) {
      if(isDefined(var_b6e76b65.var_b965b5e5)) {
        var_b6e76b65.var_b965b5e5 thread animation::play_siege("p9_fxanim_zm_silver_jellyfish_large_sanim", undefined, 1, 1);
        util::playFXOnTag(fieldname, "sr/fx9_aether_jellyfish_self_large", var_b6e76b65.var_b965b5e5, "tag_origin");
      }
    }

    return;
  }

  function_be93487f(fieldname, 1, 1, 0, 0, 0);
  setexposureactivebank(fieldname, 1);
  forcestreamxmodel(#"p9_fxanim_sv_holdout_crystal_mod");
  var_90a50598 = struct::get_array("jellyfish_large", "targetname");

  foreach(var_b6e76b65 in var_90a50598) {
    if(isDefined(var_b6e76b65.var_b965b5e5)) {
      var_b6e76b65.var_b965b5e5 delete();
      var_b6e76b65 struct::delete();
    }
  }
}

function function_4fd00e1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(level.var_3630f9c0)) {
    level.var_3630f9c0 = [];
  }

  var_47c85523 = self getentitynumber();
  var_e534cbe9 = 0;

  if(isDefined(level.var_3630f9c0[var_47c85523][fieldname])) {
    killfx(fieldname, level.var_3630f9c0[var_47c85523][fieldname]);
    level.var_3630f9c0[var_47c85523][fieldname] = undefined;
    var_e534cbe9 = 1;
  }

  if(bwastimejump > 0) {
    if(!var_e534cbe9) {
      self playSound(fieldname, #"hash_79a78504d4dbaf3f");
    }

    if(self zm_utility::function_f8796df3(fieldname)) {
      if(bwastimejump == 2) {
        str_fx = # "hash_679d39e5fd4eae19";
      } else if(bwastimejump == 1) {
        str_fx = # "hash_462352157053fa4a";
      }

      if(viewmodelhastag(fieldname, "tag_flashlight")) {
        level.var_3630f9c0[var_47c85523][fieldname] = playviewmodelfx(fieldname, str_fx, "tag_flashlight");
      }
    } else {
      if(bwastimejump == 2) {
        str_fx = # "hash_153f56ac9d13a399";
      } else if(bwastimejump == 1) {
        str_fx = # "hash_64e79a7456f58dec";
      }

      level.var_3630f9c0[var_47c85523][fieldname] = util::playFXOnTag(fieldname, str_fx, self, "tag_flashlight");
    }

    if(self == function_5c10bd79(fieldname)) {
      util::function_8eb5d4b0(3500, 0);
    }

    return;
  }

  if(var_e534cbe9) {
    self playSound(fieldname, #"hash_13715035b161a0c3");
  }

  if(self == function_5c10bd79(fieldname)) {
    util::function_8eb5d4b0(3500, 2.5);
  }
}

function function_53ab1c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  var_47c85523 = self getentitynumber();

  if(isDefined(level.var_3630f9c0[var_47c85523][bwastimejump])) {
    killfx(bwastimejump, level.var_3630f9c0[var_47c85523][bwastimejump]);
    level.var_3630f9c0[var_47c85523][bwastimejump] = undefined;
  }
}

function barrier_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.n_fx_id = playFX(fieldname, "sr/fx9_obj_holdout_barrier_window", self.origin + vectornormalize(anglestoright(self.angles)) * 6, anglestoright(self.angles), anglestoup(self.angles));
    self.var_b3673abf = self playLoopSound(#"hash_3cf13a0072fc0aae");
    return;
  }

  if(isDefined(self.n_fx_id)) {
    stopfx(fieldname, self.n_fx_id);
    self.n_fx_id = undefined;
  }

  if(isDefined(self.var_b3673abf)) {
    self stoploopsound(self.var_b3673abf);
    self.var_b3673abf = undefined;
  }
}

function function_9609c8b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(bwastimejump, "sr/fx9_obj_holdout_crystal_bomb", self.origin + (0, 0, 128), anglesToForward(self.angles), anglestoup(self.angles));
  playSound(bwastimejump, #"hash_219637e3c93b9531", self.origin);
  wait 2.5;
  playFX(bwastimejump, "sr/fx9_obj_holdout_crystal_shockwave_blast", self.origin + (0, 0, 128), anglesToForward(self.angles), anglestoup(self.angles));
  playSound(bwastimejump, #"hash_716354440fd93185", self.origin + (0, 0, 128));
  self playrumbleonentity(bwastimejump, "sr_payload_portal_final_rumble");
  earthquake(bwastimejump, 0.25, 1.5, self.origin + (0, 0, 128), 4000);
}

function function_6a4e64d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_fec2778b = playFX(bwastimejump, "sr/fx9_obj_holdout_crystal_pulse", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
  self playSound(bwastimejump, #"hash_39e7c67ba77ef8cc");
}

function function_20a79dc5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, "sr/fx9_aether_jellyfish_trail", self, "tag_origin");
  util::playFXOnTag(bwastimejump, "sr/fx9_aether_jellyfish_d_light", self, "tag_origin");
}

function teleport_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    self postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
    return;
  }

  self postfx::exitpostfxbundle(#"hash_7fbc9bc489aea188");
}

function function_ebf5d79(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_5c10bd79(bwastimejump);

  if(isDefined(player)) {
    if(!is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
      player setenemyglobalscrambler(0);
    }
  }
}