/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_791ecf7869b6b24f.csc
***********************************************/

#using script_7d6dc1eb458198d1;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_f7b3ed9;

function init() {
  clientfield::register("scriptmover", "" + # "damaged_sparks", 16000, 1, "int", &damaged_sparks, 0, 0);
  clientfield::register("scriptmover", "" + # "damaged_smoke", 16000, 1, "int", &damaged_smoke, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4cf52ac8c941f331", 16000, 1, "int", &function_38a9e5d1, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_20b22d2242b107cc", 16000, 1, "int", &function_33827fb9, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_354f2f0ca110088b", 16000, 1, "counter", &function_773683a7, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_221e597b28199323", 16000, 1, "int", &function_a229f8c1, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_48cdaba6cfee3ee8", 16000, 1, "int", &function_4c4184dd, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_11d9c3835adcaece", 16000, 1, "int", &function_6909812d, 0, 0);
  clientfield::register("actor", "" + # "zombie_soul", 16000, 1, "int", &function_bb5d646a, 0, 0);
  zm_control_point_hud::register();
}

function damaged_sparks(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.damaged_sparks) && bwasdemojump == 0) {
    stopfx(fieldname, self.damaged_sparks);
    self.damaged_sparks = undefined;
  }

  if(bwasdemojump == 1) {
    self.damaged_sparks = playFX(fieldname, #"hash_244ac8229348af01", self.origin + (10, 0, 0), (0, 0, 1), anglesToForward(self.angles));
  }
}

function damaged_smoke(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.damaged_sparks) && bwasdemojump == 0) {
    stopfx(fieldname, self.damaged_smoke);
    self.damaged_sparks = undefined;

    if(isDefined(self.var_52f9dfc0)) {
      self stoploopsound(self.var_52f9dfc0);
      self.var_52f9dfc0 = undefined;
    }
  }

  if(bwasdemojump == 1) {
    self.damaged_smoke = playFX(fieldname, #"hash_7c6ddeef1245e0ea", self.origin + (0, 0, 30), (0, 0, 1), anglesToForward(self.angles));
    self.var_52f9dfc0 = self playLoopSound(#"hash_184650f042012414");
  }
}

function function_a229f8c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_cd0913df) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_cd0913df);
    self.var_cd0913df = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_cd0913df = playFX(fieldname, #"hash_701ecdfd821cd48a", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_4c4184dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_f97e6b12) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_f97e6b12);
    self.var_f97e6b12 = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_f97e6b12 = playFX(fieldname, #"hash_775bd63fb3bba6d9", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_38a9e5d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_f97e6b12) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_f97e6b12);
    self.var_f97e6b12 = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_f97e6b12 = playFX(fieldname, #"hash_7cdce0f11e01ab9e", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_33827fb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_cd0913df) && bwasdemojump == 0) {
    stopfx(fieldname, self.var_cd0913df);
    self.var_cd0913df = undefined;
  }

  if(bwasdemojump == 1) {
    self.var_cd0913df = playFX(fieldname, #"hash_7639dfd37e054d6b", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_773683a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  playFX(bwasdemojump, #"sr/fx9_obj_console_defend_dmg_os", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
}

function function_bb5d646a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");
  self util::waittill_dobj(bwasdemojump);

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }

  self zombie_eye_glow::good_barricade_damaged(bwasdemojump);
  self playrenderoverridebundle(#"hash_9f31d2c3b11a51c");
  e_fx = util::spawn_model(bwasdemojump, "tag_origin", self gettagorigin("J_Spine4"));
  playSound(bwasdemojump, #"hash_61be08677fe8683", e_fx.origin);
  var_5e7d1e09 = struct::get_array("satellite_pos", "script_noteworthy");
  satellite_pos = arraygetclosest(self.origin, var_5e7d1e09);
  util::playFXOnTag(bwasdemojump, #"zombie/fx9_onslaught_orb_soul", e_fx, "tag_origin");
  e_fx moveto(e_fx.origin + (0, 0, 40), 0.8);
  wait 0.75;
  n_time = distance(e_fx.origin, satellite_pos.origin) / 400;
  e_fx moveto(satellite_pos.origin + (0, 0, 50), n_time);
  e_fx waittill(#"movedone");
  util::playFXOnTag(bwasdemojump, #"maps/zm_red/fx8_soul_charge_purple", e_fx, "tag_origin");
  playSound(bwasdemojump, #"hash_77a638eb74142796", e_fx.origin);
  wait 0.3;
  e_fx delete();
}

function function_6909812d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self notify(#"hash_64be90d89f0d9c8b");

  if(isDefined(self.var_1caaf1f5)) {
    stopfx(fieldname, self.var_1caaf1f5);
    self.var_1caaf1f5 = undefined;
  }

  if(isDefined(self.var_8666a1a7)) {
    stopfx(fieldname, self.var_8666a1a7);
    self.var_8666a1a7 = undefined;
  }

  if(bwasdemojump) {
    self thread function_a93c81b4(fieldname);
  }
}

function function_a93c81b4(localclientnum) {
  self notify("44eb4119b22c44f3");
  self endon("44eb4119b22c44f3");
  self endon(#"hash_64be90d89f0d9c8b");
  self.var_1caaf1f5 = playFX(localclientnum, #"hash_55dab9c7bb0687fa", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  wait 0.3;
  playFX(localclientnum, #"sr/fx9_safehouse_orb_activate", self.origin + (0, 0, 30));
  wait 3 - 0.3;
  stopfx(localclientnum, self.var_1caaf1f5);
  self.var_1caaf1f5 = undefined;
  self.var_8666a1a7 = playFX(localclientnum, #"hash_6239842e77f124b4", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}