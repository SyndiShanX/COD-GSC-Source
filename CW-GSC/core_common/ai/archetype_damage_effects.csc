/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_damage_effects.csc
*******************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace archetype_damage_effects;

function autoexec main() {
  registerclientfields();
}

function registerclientfields() {
  clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int", &actor_fire_fx, 0, 0);
}

function actor_fire_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  switch (bwastimejump) {
    case 0:
      if(isDefined(self.activefx)) {
        self stopallloopsounds(1);

        foreach(fx in self.activefx) {
          stopfx(fieldname, fx);
        }

        self.activefx = [];
      }

      break;
    case 1:
    case 2:
    case 3:
      self.activefx = playtagfxset(fieldname, "weapon_hero_molotov_fire_3p", self);
      break;
  }
}