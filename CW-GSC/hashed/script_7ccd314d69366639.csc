/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7ccd314d69366639.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace objective_retrieval;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("toplayer", "" + # "canister_effect", 1, 1, "int", &function_d3af9ddb, 0, 0);
  clientfield::register("scriptmover", "" + # "canister_shockwave", 1, 1, "counter", &canister_shockwave, 0, 0);
  clientfield::register("scriptmover", "" + # "container_collect", 1, 1, "int", &function_6b90cf3a, 0, 0);
  clientfield::register("scriptmover", "" + # "canister_glow", 1, 1, "int", &function_1eb1d4d6, 0, 0);
  clientfield::register("scriptmover", "" + # "rocket_thruster", 1, 1, "int", &function_5ce76614, 0, 0);
  util::waitforclient(0);
}

function function_5ce76614(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_3e09a106 = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_truck_light_spin", self, "tag_fx_launch_beacon_light_lb");
    self.var_c454a3d = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_truck_light_spin", self, "tag_fx_launch_beacon_light_lf");
    self.var_faaadabb = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_truck_light_spin", self, "tag_fx_launch_beacon_light_rb");
    self.var_c7ae258d = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_truck_light_spin", self, "tag_fx_launch_beacon_light_rf");
    wait 4;
    self.var_67819d90 = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_rocket_thruster_cam_shack", self, "tag_rocket_animate");
    return;
  }

  if(isDefined(self.var_67819d90)) {
    stopfx(fieldname, self.var_67819d90);
    self.var_67819d90 = undefined;
  }

  wait 15;

  if(isDefined(self.var_3e09a106)) {
    stopfx(fieldname, self.var_3e09a106);
    self.var_3e09a106 = undefined;
  }

  if(isDefined(self.var_c454a3d)) {
    stopfx(fieldname, self.var_c454a3d);
    self.var_c454a3d = undefined;
  }

  if(isDefined(self.var_faaadabb)) {
    stopfx(fieldname, self.var_faaadabb);
    self.var_faaadabb = undefined;
  }

  if(isDefined(self.var_c7ae258d)) {
    stopfx(fieldname, self.var_c7ae258d);
    self.var_c7ae258d = undefined;
  }
}

function function_6b90cf3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.n_fx_id = util::playFXOnTag(fieldname, "sr/fx9_canister_pod_aether", self, "tag_animate");
    self.var_b3673abf = self playLoopSound(#"hash_724ba66a7599d72d", undefined, (0, 0, 15));
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

function function_1eb1d4d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    if(isDefined(self.n_fx_id)) {
      killfx(fieldname, self.n_fx_id);
      self.n_fx_id = undefined;
    }

    self.n_fx_id = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_container_glow", self, "p9_sur_console_control_01_canister_handle_jnt");

    if(!isDefined(self.var_b3673abf)) {
      self.var_b3673abf = self playLoopSound(#"hash_3432d05cab6568b1", undefined, (0, 0, 10));
    }

    return;
  }

  if(isDefined(self.n_fx_id)) {
    killfx(fieldname, self.n_fx_id);
    self.n_fx_id = undefined;
  }

  if(isDefined(self.var_b3673abf)) {
    self stoploopsound(self.var_b3673abf);
    self.var_b3673abf = undefined;
  }
}

function canister_shockwave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.model === # "p9_zm_platinum_magic_box_bunny") {
    str_fx = # "hash_138a5318ce27c2ca";
  } else {
    str_fx = # "zombie/fx9_player_shockwave_retrieval";
  }

  playFX(bwastimejump, str_fx, self.origin, (180, 0, 0));
  self playSound(bwastimejump, #"hash_5db462e1df5084e7");
  self playrumbleonentity(bwastimejump, "damage_heavy");
}

function function_d3af9ddb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    if(function_65b9eb0f(fieldname)) {
      return;
    }

    if(self isPlayer()) {
      self.var_726a59ef = playfxoncamera(fieldname, "sr/fx9_camera_canister_in_hand", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      self postfx::playpostfxbundle(#"pstfx_retrieve");
      self.var_51dd9721 = # "pstfx_retrieve";
      self function_116b95e5(#"pstfx_retrieve", #"inner mask", 0.3);
      self function_116b95e5(#"pstfx_retrieve", #"outer mask", 0.8);

      if(!isDefined(self.var_fbd5f7c8)) {
        self.var_fbd5f7c8 = util::playFXOnTag(fieldname, "sr/fx9_obj_retrieval_container_gas_trail", self, "tag_stowed_back");
      }

      if(!isDefined(self.var_e53a5eb7)) {
        self playSound(fieldname, #"hash_22a6864697c92c12");
        self.var_e53a5eb7 = self playLoopSound(#"hash_6d68538eca6c8226");
      }
    }

    return;
  }

  if(function_65b9eb0f(fieldname)) {
    return;
  }

  if(self isPlayer()) {
    if(isDefined(self.var_726a59ef)) {
      stopfx(fieldname, self.var_726a59ef);
      self.var_726a59ef = undefined;
    }

    if(isDefined(self.var_fbd5f7c8)) {
      stopfx(fieldname, self.var_fbd5f7c8);
      self.var_fbd5f7c8 = undefined;
    }

    if(isDefined(self.var_e53a5eb7)) {
      self playSound(fieldname, #"hash_211ebca22128a977");
      self stoploopsound(self.var_e53a5eb7);
      self.var_e53a5eb7 = undefined;
    }

    self notify(#"stop_blur");
    wait 0.5;

    if(isDefined(self)) {
      self function_116b95e5(#"pstfx_retrieve", #"blur", 0);
      self postfx::exitpostfxbundle(#"pstfx_retrieve");
      self.var_51dd9721 = undefined;
    }
  }
}

function function_d233fb1f() {
  self endon(#"death", #"disconnect", #"stop_blur");
  var_9b8a1091 = 0.01;

  while(true) {
    self function_116b95e5(#"pstfx_retrieve", #"blur", var_9b8a1091);
    wait 0.08;
    var_9b8a1091 += 0.01;

    if(var_9b8a1091 > 0.1) {
      while(var_9b8a1091 > 0) {
        var_9b8a1091 -= 0.01;
        self function_116b95e5(#"pstfx_retrieve", #"blur", var_9b8a1091);
        wait 0.08;
      }
    }
  }
}