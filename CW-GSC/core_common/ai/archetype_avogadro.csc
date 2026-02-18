/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_avogadro.csc
*************************************************/

#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace archetype_avogadro;

function private autoexec __init__system__() {
  system::register(#"archetype_avogadro", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("missile", "" + # "avogadro_bolt_fx", 1, 2, "int", &function_9452b8f1, 0, 0);
  clientfield::register("actor", "" + # "avogadro_phase_fx", 1, 1, "int", &function_1d2d070c, 0, 0);
  clientfield::register("actor", "" + # "avogadro_health_fx", 1, 2, "int", &function_ae4cd3d4, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_183ef3538fd62563", 1, 1, "int", &function_9beb815c, 0, 0);
  clientfield::register("scriptmover", "avogadro_phase_beam", 1, getminbitcountfornum(3), "int", &function_6ddf79a2, 0, 0);
  ai::add_archetype_spawn_function(#"avogadro", &initavogadro);
}

function private postinit() {}

function initavogadro(localclientnum) {
  util::waittill_dobj(localclientnum);
  fxclientutils::playfxbundle(localclientnum, self, "fxd9_zm_char_avogadro_elec_unaware");
  self callback::on_shutdown(&on_entity_shutdown);
}

function on_entity_shutdown(localclientnum) {
  if(isDefined(self) && isDefined(self.jammer_interface)) {
    self.jammer_interface delete();
  }

  if(isDefined(self)) {
    self stoprenderoverridebundle(#"hash_4a28179035ece31c");
  }
}

function function_8dede8a3(localclientnum) {
  self endon(#"shutdown", #"death");

  while(isDefined(self)) {
    self playSound(localclientnum, #"hash_6f92148122930a");
    wait randomintrange(3, 10);
  }
}

function function_9452b8f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump === 1) {
    self.boltfx = function_239993de(fieldname, "zm_ai/fx8_avo_elec_projectile", self, "tag_origin_animate");

    if(!isDefined(self.var_cb169d5f)) {
      self.var_cb169d5f = self playLoopSound(#"hash_64fad034010aebaa");
    }

    return;
  }

  if(isDefined(self.boltfx)) {
    stopfx(fieldname, self.boltfx);
    self.boltfx = undefined;
  }

  if(isDefined(self.var_cb169d5f)) {
    self stoploopsound(self.var_cb169d5f);
    self.var_cb169d5f = undefined;
  }
}

function function_9beb815c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  function_239993de(bwastimejump, "zm_ai/fx9_avo_elec_projectile_dest", self, "tag_origin_animate");
  playSound(bwastimejump, #"hash_3f6164143de4427e", self.origin);
}

function function_1d2d070c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self.phase_fx = function_239993de(fieldname, "zm_ai/fx8_cata_elec_aura", self, "j_spine4");
    return;
  }

  if(isDefined(self.phase_fx)) {
    stopfx(fieldname, self.phase_fx);
    self.phase_fx = undefined;
  }
}

function private function_ae4cd3d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1 && self.health_state !== 1) {
    self function_df8ae699(fieldname);
    fxclientutils::playfxbundle(fieldname, self, "fxd9_zm_char_avogadro_elec_health_low");
    self.health_state = 1;
    return;
  }

  if(bwastimejump == 2 && self.health_state !== 2) {
    self function_df8ae699(fieldname);
    fxclientutils::playfxbundle(fieldname, self, "fxd9_zm_char_avogadro_elec_health_med");
    self.health_state = 2;
    return;
  }

  if(bwastimejump == 3 && self.health_state !== 3) {
    self function_df8ae699(fieldname);
    fxclientutils::playfxbundle(fieldname, self, "fxd9_zm_char_avogadro_elec_health_high");
    self.health_state = 3;
  }
}

function private function_6ddf79a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(binitialsnap);

  if(!isDefined(self)) {
    return;
  }

  timestamp = gettime();
  id = bwastimejump;

  if(bwastimejump == 0) {
    id = fieldname;
  }

  if(!isDefined(level.var_c42e1dca)) {
    level.var_c42e1dca = [];
  }

  if(!isDefined(level.var_c42e1dca[id])) {
    level.var_c42e1dca[id] = spawnStruct();
  }

  if(bwastimejump == 0) {
    assert(isDefined(level.var_c42e1dca[id].beam_id));
    beamkill(binitialsnap, level.var_c42e1dca[id].beam_id);
    return;
  }

  if(level.var_c42e1dca[id].time !== timestamp) {
    level.var_c42e1dca[id].time = timestamp;
    level.var_c42e1dca[id].model = self;
    return;
  }

  var_905cc9f0 = level.var_c42e1dca[id].model;
  var_ecde63d5 = self;
  playSound(binitialsnap, #"hash_45cd897c902f8c6d", var_ecde63d5.origin);
  playSound(binitialsnap, #"hash_1e6ec35a55d2046b", var_905cc9f0.origin);
  level.var_c42e1dca[id].beam_id = beamlaunch(binitialsnap, var_ecde63d5, "tag_origin", var_905cc9f0, "tag_origin", "beam9_zm_avogadro_elec_teleport");
}

function function_df8ae699(localclientnum) {
  fxclientutils::stopfxbundle(localclientnum, self, "fxd9_zm_char_avogadro_elec_health_low");
  fxclientutils::stopfxbundle(localclientnum, self, "fxd9_zm_char_avogadro_elec_health_med");
  fxclientutils::stopfxbundle(localclientnum, self, "fxd9_zm_char_avogadro_elec_health_high");
  fxclientutils::stopfxbundle(localclientnum, self, "fxd9_zm_char_avogadro_elec_unaware");
}