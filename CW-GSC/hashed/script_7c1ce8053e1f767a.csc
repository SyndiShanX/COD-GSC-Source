/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c1ce8053e1f767a.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_957938f0;

function private autoexec __init__system__() {
  system::register(#"hash_3256c1e06451aec4", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_318abd2654cf527a")) && !getdvarint(#"hash_1afcd13f069fa385", 0)) {
    return;
  }

  clientfield::register("scriptmover", "jump_pad_active", 1, 1, "int", &jump_pad_active, 0, 0);
  clientfield::register("scriptmover", "jump_pad_essence_fx", 1, 1, "int", &jump_pad_essence_fx, 0, 0);
  clientfield::register("scriptmover", "jump_pad_amb_sound_lp", 1, 1, "int", &jump_pad_amb_sound_lp, 0, 0);
  clientfield::register("toplayer", "jump_pad_wind_sound", 1, 1, "int", &jump_pad_wind_sound, 0, 0);
  visionset_mgr::register_overlay_info_style_postfx_bundle("sr_jump_pad_visionset", 1, 1, "pstfx_jump_pad_launch");
}

function jump_pad_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump) {
    self.var_3364a192 = util::playFXOnTag(fieldname, #"hash_2fa753029cdd63bd", self, "tag_light_right_fx");
    self.var_d47b7586 = util::playFXOnTag(fieldname, #"hash_2fa753029cdd63bd", self, "tag_light_left_fx");
  } else {
    if(isDefined(self.var_3364a192)) {
      killfx(fieldname, self.var_3364a192);
    }

    if(isDefined(self.var_d47b7586)) {
      killfx(fieldname, self.var_d47b7586);
    }
  }

  self function_d309e55a("tag_light_left", bwastimejump);
  self function_d309e55a("tag_light_right", bwastimejump);
}

function jump_pad_essence_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump) {
    playFX(fieldname, #"hash_740a639c59126f59", self.origin);
    function_239993de(fieldname, #"hash_23f38f1190bb99d9", self, "tag_origin");
    self thread function_6192b162();
    return;
  }

  playFX(fieldname, #"hash_326df840230b71d6", self.origin);
  playSound(fieldname, #"zmb_powerup_resource_large_pickup", self.origin);
}

function function_6192b162() {
  self endon(#"death");

  while(true) {
    if(!self function_d2503806(#"hash_5b08235c0b55a003")) {
      self playrenderoverridebundle(#"hash_5b08235c0b55a003");
    }

    waitframe(1);
  }
}

function jump_pad_amb_sound_lp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_c50612a2 = self playLoopSound(#"hash_67d068901551222c");
  }
}

function jump_pad_wind_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_dbe88563 = self playLoopSound(#"hash_296e1c756ae8ae2b");
    self thread function_ca483953(fieldname);
    self thread function_6b3f6fa7(fieldname);
    self thread function_d80deb1d();
    return;
  }

  if(isDefined(self.var_dbe88563)) {
    self stoploopsound(self.var_dbe88563);
    self.var_dbe88563 = undefined;
  }

  self notify(#"hash_7387c0ba13aefdd7");
}

function function_ca483953(localclientnum) {
  self notify("1a03edd1862740b0");
  self endon("1a03edd1862740b0");
  self endon(#"death", #"hash_5db49134b7c7de10", #"hash_7387c0ba13aefdd7");

  while(true) {
    earthquake(localclientnum, 0.15, 0.3, self.origin, 256);
    wait 0.1;
  }
}

function function_6b3f6fa7(localclientnum) {
  self notify("2c1a4b7fe6426f07");
  self endon("2c1a4b7fe6426f07");
  self endon(#"death", #"hash_78558ed9d8282358", #"hash_7387c0ba13aefdd7");

  while(true) {
    self playrumbleonentity(localclientnum, #"anim_light");
    wait 0.1;
  }
}

function function_d80deb1d() {
  self notify("7c94ac39bb174eec");
  self endon("7c94ac39bb174eec");
  self endon(#"death", #"hash_7387c0ba13aefdd7");

  while(self getvelocity()[2] <= 666) {
    waitframe(1);
  }

  while(self getvelocity()[2] > 666) {
    waitframe(1);
  }

  self notify(#"hash_5db49134b7c7de10");
  wait 0.5;
  self notify(#"hash_78558ed9d8282358");
}