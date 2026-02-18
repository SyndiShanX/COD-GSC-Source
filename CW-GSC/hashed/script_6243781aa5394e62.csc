/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6243781aa5394e62.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_dog;
#using scripts\zm_common\ai\zombie_dog_toxic_cloud;
#namespace namespace_ec0691f8;

function private autoexec __init__system__() {
  system::register(#"hash_4863f776a30a1247", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "sr_dog_fx", 1, 1, "int", &dog_fx, 0, 0);
  clientfield::register("actor", "sr_dog_spawn_fx", 1, 1, "counter", &dog_spawn_fx, 0, 0);
  clientfield::register("actor", "sr_dog_pre_spawn_fx", 1, 1, "counter", &function_30933ca1, 0, 0);
  ai::add_archetype_spawn_function(#"zombie_dog", &function_3b0e8b8b);
}

function function_3b0e8b8b(localclientnum) {
  util::waittill_dobj(localclientnum);
}

function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    if(!isDefined(self.var_93471229)) {
      self.var_93471229 = [];
    }

    if(isDefined(self.fxdef) && !isDefined(self._fxcharacter[self.fxdef])) {
      fxclientutils::playfxbundle(fieldname, self, self.fxdef);
    }

    self mapshaderconstant(fieldname, 0, "scriptVector2", 0, 1, 1);
    return;
  }

  if(isDefined(self.var_93471229)) {
    foreach(fxhandle in self.var_93471229) {
      deletefx(fieldname, fxhandle);
    }
  }

  util::playFXOnTag(fieldname, #"zm_ai/fx8_dog_death_exp", self, "j_spine2");
}

function function_30933ca1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  if(self.subarchetype === # "hash_2a5479b83161cb35") {
    var_d1dc644a = playFX(bwastimejump, #"hash_baef237a01b261a", self.origin + (0, 0, 36), anglestoup(self.angles));
    playSound(bwastimejump, #"hash_6b6572c7d66929d", self.origin + (0, 0, 36));
  } else if(self.subarchetype === # "hash_28e36e7b7d5421f") {
    var_d1dc644a = playFX(bwastimejump, #"hash_2de6c1300bec68cd", self.origin + (0, 0, 36), anglestoup(self.angles));
    playSound(bwastimejump, #"hash_3731f907ac5beb1", self.origin + (0, 0, 36));
  } else {
    playSound(bwastimejump, #"hash_1b702e745dd73148", self.origin + (0, 0, 36));
  }

  wait 1;

  if(isDefined(var_d1dc644a)) {
    stopfx(bwastimejump, var_d1dc644a);
  }
}

function dog_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(self.subarchetype === # "hash_2a5479b83161cb35") {
    util::playFXOnTag(bwasdemojump, #"hash_784a8bc7b9b17876", self, "j_spine2");
    playSound(bwasdemojump, #"hash_6ba18f5ab09d3e00", self.origin + (0, 0, 36));
  } else if(self.subarchetype === # "hash_28e36e7b7d5421f") {
    util::playFXOnTag(bwasdemojump, #"hash_44214bf58f0e6d87", self, "j_spine2");
    playSound(bwasdemojump, #"hash_6a7f1f4ef6078e4", self.origin + (0, 0, 36));
  } else {
    util::playFXOnTag(bwasdemojump, level._effect[# "lightning_dog_spawn"], self, "j_spine2");
    playSound(bwasdemojump, #"hash_342202bccfe632e3", self.origin + (0, 0, 36));
  }

  fxclientutils::playfxbundle(bwasdemojump, self, self.fxdef);
}