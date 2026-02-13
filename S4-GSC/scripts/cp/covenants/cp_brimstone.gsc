/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_brimstone.gsc
*************************************************/

init() {
  _id_0945::_id_C2B1("specialty_brimstone", ::set_brimstone, ::unset_brimstone);
  level._effect["vfx_cov_brimstone_dmg"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_brimstone_dmg.vfx");
}

set_brimstone() {
  thread brimstone_damage_tick();
}

unset_brimstone() {
  self notify("end_brimstone");
}

brimstone_damage_tick() {
  self endon("disconnect");
  self endon("end_brimstone");
  waitframe();
  var_0 = _id_0945::_id_664E("brimstone_radius");
  var_1 = _id_0945::_id_664E("brimstone_damage_per_second");

  for(;;) {
    if(isalive(self) && !self.inlaststand) {
      var_2 = self getEye();
      var_3 = _func_0071(self.origin, var_0);

      foreach(var_5 in var_3) {
        if(!isDefined(var_5) || !isDefined(var_5.maxhealth)) {
          continue;
        }
        if(istrue(var_5.immune_brimstone)) {
          continue;
        }
        if(istrue(var_5._id_86F2)) {
          continue;
        }
        if(!_func_0202(var_2, var_5 getEye(), 0, self, var_5)) {
          continue;
        }
        var_6 = var_5.maxhealth * var_1 * 1;

        if(var_5.zm_ai_category == "special") {
          var_6 = var_6 * 0.33;
        } else if(var_5.zm_ai_category == "elite") {
          var_6 = var_6 * 0.1;
        }

        playFXOnTag(level._effect["vfx_cov_brimstone_dmg"], var_5, "j_spine4");
        var_5 childthread scripts\engine\utility::_id_46A6(::dodamage, 0.25, var_6, self.origin, self, self, "MOD_UNKNOWN", "s4_brimstone_zm", "none");
      }
    }

    wait 1;
  }
}

is_brimstone_damage(var_0) {
  return isweapon(var_0) && var_0.basename == "s4_brimstone_zm";
}