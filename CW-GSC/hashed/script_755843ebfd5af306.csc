/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_755843ebfd5af306.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace namespace_53a8fe5e;

function init() {
  clientfield::register("actor", "hellhound_fx", 1, 1, "int", &function_1ec447d3, 0, 0);
  function_cae618b4("spawner_zombietron_wolf");
  function_cae618b4("spawner_zombietron_wolf_ghost");
  function_cae618b4("spawner_zombietron_hellhound");
  init_dog_fx();
}

function init_dog_fx() {
  level._effect[#"dog_eye_glow"] = #"zm_ai/fx8_dog_eye_single";
  level._effect[#"hash_55d6ab2c7eecbad4"] = #"zm_ai/fx8_dog_eye_glow";
  level._effect[#"dog_head_glow"] = #"zm_ai/fx8_dog_head_glow";
  level._effect[#"hash_5e4d4083a69396b8"] = #"zm_ai/fx8_dog_tail_glow";
  level._effect[#"hash_33fd6545401e3622"] = #"zm_ai/fx8_dog_belly_glow";
  level._effect[#"hash_63f497890003547"] = #"zm_ai/fx8_dog_torso_glow";
  level._effect[#"dog_gib"] = #"zm_ai/fx8_dog_death_exp";
  level._effect[#"lightning_dog_spawn"] = #"zm_ai/fx8_dog_lightning_spawn";
}

function function_1ec447d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    if(!isDefined(self.var_93471229)) {
      self.var_93471229 = [];
    }

    array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail0"));
    array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail1"));
    array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_33fd6545401e3622"], self, "j_spine2"));
    array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_63f497890003547"], self, "j_neck"));
    array::add(self.var_93471229, util::playFXOnTag(fieldname, level._effect[#"hash_55d6ab2c7eecbad4"], self, "tag_eye"));
    self mapshaderconstant(fieldname, 0, "scriptVector2", 0, 1, 1);
    return;
  }

  if(isDefined(self.var_93471229)) {
    foreach(fxhandle in self.var_93471229) {
      deletefx(fieldname, fxhandle);
    }
  }

  util::playFXOnTag(fieldname, level._effect[#"dog_gib"], self, "j_spine2");
}

function function_f7a64042(localclientnum) {
  self notify(#"hash_178210c7441aeb0b");
  self endon(#"hash_178210c7441aeb0b");

  while(isDefined(self)) {
    array::add(self.var_93471229, util::playFXOnTag(localclientnum, level._effect[#"hash_1d9e53a201883cb"], self, "RI_Ear"));
    array::add(self.var_93471229, util::playFXOnTag(localclientnum, level._effect[#"hash_1d9e53a201883cb"], self, "LE_Ear"));
    wait 6;
  }
}