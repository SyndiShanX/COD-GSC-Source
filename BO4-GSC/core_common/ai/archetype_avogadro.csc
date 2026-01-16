/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_avogadro.csc
*************************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace archetype_avogadro;

autoexec __init__system__() {
  system::register(#"archetype_avogadro", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"avogadro_bolt_fx", 16000, 1, "int", &function_9452b8f1, 0, 0);
  clientfield::register("actor", "" + #"avogadro_phase_fx", 16000, 1, "int", &function_1d2d070c, 0, 0);
  clientfield::register("actor", "" + #"avogadro_health_fx", 16000, 2, "int", &function_ae4cd3d4, 0, 0);
  ai::add_archetype_spawn_function(#"avogadro", &initavogadro);
}

__main__() {}

initavogadro(localclientnum) {
  util::waittill_dobj(localclientnum);
  self callback::on_shutdown(&on_entity_shutdown);
}

on_entity_shutdown(localclientnum) {
  if(isDefined(self) && isDefined(self.jammer_interface)) {
    self.jammer_interface delete();
  }
}

function_9452b8f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval) {
    self.boltfx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_projectile", self, "tag_origin");
    return;
  }

  if(isDefined(self.boltfx)) {
    stopfx(localclientnum, self.boltfx);
    self.boltfx = undefined;
  }
}

function_1d2d070c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval) {
    self.phase_fx = function_239993de(localclientnum, "zm_ai/fx8_cata_elec_aura", self, "j_spine4");
    return;
  }

  if(isDefined(self.phase_fx)) {
    stopfx(localclientnum, self.phase_fx);
    self.phase_fx = undefined;
  }
}

private function_ae4cd3d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.jammer_interface)) {
    self.jammer_interface = util::spawn_model(localclientnum, "tag_origin");
    self.jammer_interface linkto(self, "j_spine4");
  }

  if(isDefined(self.health_fx)) {
    stopfx(localclientnum, self.health_fx);
  }

  switch (newval) {
    case 3:
      self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_aura_main", self.jammer_interface, "j_spine4");
      break;
    case 2:
      self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_cata_water_aura", self.jammer_interface, "j_spine4");
      break;
    case 1:
      self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_aura_weakened", self.jammer_interface, "j_spine4");
      break;
    default:
      break;
  }
}