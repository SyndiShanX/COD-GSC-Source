/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\util\ai_dog_util.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#namespace zombie_dog_util;

function private autoexec __init__system__() {
  system::register(#"zombie_dog_util", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_dog_fx();
  clientfield::register("actor", "dog_fx", 1, 1, "int", &dog_fx, 0, 0);
  clientfield::register("world", "dog_round_fog_bank", 1, 1, "int", &dog_round_fog_bank, 0, 0);
}

function init_dog_fx() {
  level._effect[#"dog_eye_glow"] = # "hash_70696527ecb861ae";
  level._effect[#"hash_55d6ab2c7eecbad4"] = # "hash_249f091d13da3663";
  level._effect[#"hash_808a86715bfac90"] = # "hash_78f02617f4f71d8a";
  level._effect[#"hash_5e4d4083a69396b8"] = # "hash_36a9dd505e78a";
  level._effect[#"hash_33fd6545401e3622"] = # "hash_39b25de05718b20c";
  level._effect[#"hash_63f497890003547"] = # "hash_3055dc23ae9ca695";
  level._effect[#"dog_gib"] = # "zm_ai/fx8_dog_death_exp";
  level._effect[#"lightning_dog_spawn"] = # "zm_ai/fx8_dog_lightning_spawn";
}

function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    if(self.subarchetype === # "hash_2a5479b83161cb35") {
      fxclientutils::playfxbundle(fieldname, self, self.fxdef);
    } else {
      self._eyeglow_fx_override = level._effect[#"dog_eye_glow"];
      self zm::createzombieeyes(fieldname);
      self mapshaderconstant(fieldname, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());

      if(!isDefined(self.var_93471229)) {
        self.var_93471229 = [];
      }

      if(isDefined(level.var_17c4823f) && !isDefined(self.var_a9305c6e)) {
        self.var_a9305c6e = self playLoopSound(level.var_17c4823f);
      }

      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_808a86715bfac90"], self, "j_neck_end"));
      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail0"));
      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail1"));
      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_33fd6545401e3622"], self, "j_spine2"));
      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_63f497890003547"], self, "j_neck"));
      array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_55d6ab2c7eecbad4"], self, "tag_eye"));
    }

    return;
  }

  if(self.subarchetype !== # "hash_2a5479b83161cb35") {
    if(isDefined(self.var_a9305c6e)) {
      self stoploopsound(self.var_a9305c6e);
    }

    self mapshaderconstant(fieldname, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
    self zm::deletezombieeyes(fieldname);

    if(isDefined(self.var_93471229)) {
      foreach(fxhandle in self.var_93471229) {
        deletefx(fieldname, fxhandle);
      }
    }
  }

  util::playFXOnTag(fieldname, level._effect[#"dog_gib"], self, "j_spine2");
}

function dog_round_fog_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    e_player = getlocalplayers()[fieldname];
    e_player thread function_33593a44(fieldname, 1, 2);
    return;
  }

  e_player = getlocalplayers()[fieldname];
  e_player thread function_33593a44(fieldname, 2, 1);
}

function private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3) {
  self notify("10c315d1eb0626c3");
  self endon("10c315d1eb0626c3");
  n_blend = 0;
  n_increment = 1 / n_time / 0.05;

  if(var_312d65d1 == 1 && var_68f7ce2e == 2) {
    if(isDefined(level.var_25fd57f3) && isDefined(level.var_653fb8f8)) {
      var_13e9ea9a = level.var_25fd57f3;
      var_ef96af58 = level.var_653fb8f8;

      while(n_blend < 1) {
        var_13e9ea9a = math::clamp(var_13e9ea9a - n_blend, 0, 1);
        var_ef96af58 = math::clamp(var_ef96af58 - n_blend, 0, 1);

        if(var_ef96af58 > var_13e9ea9a) {
          var_312d65d1 = 8;
        }

        function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, var_13e9ea9a, n_blend, 0, var_ef96af58);
        n_blend += n_increment;
        wait 0.05;
        level.var_25fd57f3 = var_13e9ea9a;
        level.var_653fb8f8 = var_ef96af58;
      }

      level.var_25fd57f3 = undefined;
      level.var_653fb8f8 = undefined;
    } else {
      while(n_blend < 1) {
        function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, n_blend, 0, 0);
        n_blend += n_increment;
        wait 0.05;
      }
    }

    return;
  }

  if(var_312d65d1 == 2 && var_68f7ce2e == 1) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 1 - n_blend, 0, 0);
      n_blend += n_increment;
      wait 0.05;
    }
  }
}