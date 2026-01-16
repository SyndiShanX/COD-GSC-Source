/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_412188df54bb77d9.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_87b5173f;

init() {
  clientfield::register("actor", "shower_trap_death_fx", 1, 1, "int", &acid_trap_death_fx, 0, 0);
  clientfield::register("scriptmover", "shower_trap_fx", 1, 1, "int", &acid_trap_fx, 0, 0);
  clientfield::register("toplayer", "player_shower_trap_post_fx", 18000, 1, "int", &player_acid_trap_post_fx, 0, 0);
  clientfield::register("toplayer", "player_fire_trap_post_fx", 18000, 1, "int", &player_fire_trap_post_fx, 0, 0);
  clientfield::register("scriptmover", "fire_trap_fx", 1, 1, "int", &fire_trap_fx, 0, 0);
  clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int", &spinning_trap_blood_fx, 0, 0);
  clientfield::register("actor", "spinning_trap_eye_fx", 1, 1, "int", &spinning_trap_eye_fx, 0, 0);
  clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int", &rumble_spinning_trap, 0, 0);
  level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
  level._effect[#"acid_spray"] = #"hash_424786ecbc7f5672";
  level._effect[#"acid_spray_death"] = #"hash_48d74d13d0c569c";
  level._effect[#"hash_294b19c300d1b482"] = #"hash_29ac72c5aa5398bc";
  level._effect[#"hash_4391e5c4b43c63c9"] = #"hash_709cca7d0048aa72";
  level._effect[#"hash_5647f8e593893bce"] = #"hash_69af1783a31b44f7";
  level._effect[#"zombie_eye_trail"] = #"hash_526060b70ce93d7e";
  level._effect[#"spinning_blood"] = #"hash_358533e8293f131d";
  level._effect[#"hash_44ccd33973542202"] = #"hash_5fdb13b4843bc710";
}

acid_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_91180673)) {
      self.var_91180673 delete();
    }

    playSound(localclientnum, #"hash_68f3e5dbc3422363", self.origin);
    audio::playloopat("zmb_trap_acid_loop", self.origin);
    self.var_91180673 = util::playFXOnTag(localclientnum, level._effect[#"acid_spray"], self, "tag_origin");
    return;
  }

  playSound(localclientnum, #"hash_4da8231bc8767676", self.origin);
  audio::stoploopat("zmb_trap_acid_loop", self.origin);

  if(isDefined(self.var_91180673)) {
    stopfx(localclientnum, self.var_91180673);
    self.var_91180673 = undefined;
  }

  playFX(localclientnum, level._effect[#"acid_spray_death"], self.origin);
}

acid_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.n_acid_trap_death_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_294b19c300d1b482"], self, "tag_stowed_back");
    playSound(localclientnum, #"hash_4d4c9f8ad239b61f", self.origin);
    return;
  }

  if(isDefined(self.n_acid_trap_death_fx)) {
    stopfx(localclientnum, self.n_acid_trap_death_fx);
    self.n_acid_trap_death_fx = undefined;
  }
}

player_acid_trap_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isdemoplaying() && demoisanyfreemovecamera()) {
      return;
    }

    if(self != function_5c10bd79(localclientnum)) {
      return;
    }

    self notify(#"player_acid_trap_post_fx_complete");
    self.var_431ddde9 = self playLoopSound(#"hash_341a3fa00975f232");
    self thread function_17956e93(localclientnum);
    self thread postfx::playpostfxbundle(#"hash_98397d99cb3a03");
    self.var_b1409d8f = playfxoncamera(localclientnum, level._effect[#"hash_4391e5c4b43c63c9"]);
    self playrenderoverridebundle(#"hash_216f6c4ece79a4b8");

    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_7a7fac87 = playviewmodelfx(localclientnum, level._effect[#"hash_5647f8e593893bce"], "j_wrist_ri");
    }

    return;
  }

  self notify(#"player_acid_trap_post_fx_complete");

  if(isDefined(self.var_431ddde9)) {
    self stoploopsound(self.var_431ddde9);
    self.var_431ddde9 = undefined;
  }
}

function_17956e93(localclientnum) {
  self endoncallback(&function_502136a5, #"death");
  self waittill(#"player_acid_trap_post_fx_complete");

  if(isDefined(self)) {
    self postfx::exitpostfxbundle(#"hash_98397d99cb3a03");

    if(isDefined(localclientnum) && isDefined(self.var_b1409d8f)) {
      stopfx(localclientnum, self.var_b1409d8f);
      self.var_b1409d8f = undefined;
    }

    if(isDefined(localclientnum) && isDefined(self.var_7a7fac87)) {
      stopfx(localclientnum, self.var_7a7fac87);
      self.var_7a7fac87 = undefined;
    }

    if(isDefined(self.var_431ddde9)) {
      self stoploopsound(self.var_431ddde9);
      self.var_431ddde9 = undefined;
    }

    self stoprenderoverridebundle(#"hash_216f6c4ece79a4b8");
  }
}

function_502136a5(str_notify) {
  if(isDefined(self)) {
    localclientnum = self getlocalclientnumber();

    if(self postfx::function_556665f2(#"hash_98397d99cb3a03")) {
      self postfx::exitpostfxbundle(#"hash_98397d99cb3a03");
    }

    if(isDefined(self.var_431ddde9)) {
      self stoploopsound(self.var_431ddde9);
      self.var_431ddde9 = undefined;
    }

    if(isDefined(localclientnum) && isDefined(self.var_b1409d8f)) {
      stopfx(localclientnum, self.var_b1409d8f);
      self.var_b1409d8f = undefined;
    }

    if(isDefined(localclientnum) && isDefined(self.var_7a7fac87)) {
      stopfx(localclientnum, self.var_7a7fac87);
      self.var_7a7fac87 = undefined;
    }

    self stoprenderoverridebundle(#"hash_216f6c4ece79a4b8");
  }
}

fire_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_91180673)) {
      self.var_91180673 delete();
    }

    playSound(localclientnum, #"hash_370460eab1a33ee6", self.origin);
    audio::playloopat("wpn_fire_trap_loop", self.origin);
    self.var_91180673 = util::playFXOnTag(localclientnum, level._effect[#"hash_44ccd33973542202"], self, "tag_origin");
    return;
  }

  playSound(localclientnum, #"hash_5d8ec72f0838594e", self.origin);
  audio::stoploopat("wpn_fire_trap_loop", self.origin);

  if(isDefined(self.var_91180673)) {
    stopfx(localclientnum, self.var_91180673);
    self.var_91180673 = undefined;
  }
}

player_fire_trap_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isdemoplaying() && demoisanyfreemovecamera()) {
      return;
    }

    if(self != function_5c10bd79(localclientnum)) {
      return;
    }

    self notify(#"player_fire_trap_post_fx_complete");
    self thread function_33da4ab(localclientnum);
    self thread postfx::playpostfxbundle(#"pstfx_zm_fire_blue_trap");
    return;
  }

  self notify(#"player_fire_trap_post_fx_complete");
}

function_33da4ab(localclientnum) {
  self endoncallback(&function_3204a9f, #"death");
  self waittill(#"player_fire_trap_post_fx_complete");

  if(isDefined(self)) {
    self postfx::exitpostfxbundle(#"pstfx_zm_fire_blue_trap");
  }
}

function_3204a9f(str_notify) {
  if(isDefined(self)) {
    localclientnum = self getlocalclientnumber();

    if(self postfx::function_556665f2(#"pstfx_zm_fire_blue_trap")) {
      self postfx::exitpostfxbundle(#"pstfx_zm_fire_blue_trap");
    }
  }
}

spinning_trap_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.n_spinning_trap_blood_fx)) {
    stopfx(localclientnum, self.n_spinning_trap_blood_fx);
    self.n_spinning_trap_blood_fx = undefined;
  }

  if(newval == 1) {
    var_1f694afe = "j_spinelower";

    if(self.archetype == #"zombie_dog") {
      var_1f694afe = "j_spine1";
    }

    self.n_spinning_trap_blood_fx = util::playFXOnTag(localclientnum, level._effect[#"spinning_blood"], self, var_1f694afe);
    playSound(localclientnum, #"hash_5840ac12dd5f08cd", self.origin);
  }
}

spinning_trap_eye_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.n_spinning_trap_eye_fx)) {
    stopfx(localclientnum, self.n_spinning_trap_eye_fx);
    self.n_spinning_trap_eye_fx = undefined;
  }

  if(newval == 1) {
    self.n_spinning_trap_eye_fx = util::playFXOnTag(localclientnum, level._effect[#"zombie_eye_trail"], self, "tag_eye");
  }
}

rumble_spinning_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(newval == 1) {
    self endon(#"hash_6fb55d3438a8d5fa");

    while(true) {
      if(isinarray(getlocalplayers(), self)) {
        self playrumbleonentity(localclientnum, "damage_light");
      }

      wait 0.25;
    }

    return;
  }

  self notify(#"hash_6fb55d3438a8d5fa");
}