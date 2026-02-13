/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_critical_expertise.gsc
**********************************************************/

init() {
  _id_0945::_id_C2B1("specialty_critical_expertise", ::set_critical_expertise, ::unset_critical_expertise);
}

set_critical_expertise() {
  self.critical_expertise = spawnStruct();
  self.critical_expertise.critical_hit = [];
}

unset_critical_expertise() {
  self.critical_expertise = undefined;
}

has_critical_expertise() {
  return isPlayer(self) && scripts\cp\utility::_hasperk("specialty_critical_expertise");
}

is_critical_hit(var_0) {
  if(var_0 has_critical_expertise()) {
    if(_func_0107(var_0.critical_expertise.critical_hit)) {
      return scripts\engine\utility::array_contains(var_0.critical_expertise.critical_hit, self);
    }
  }

  return 0;
}

try_convert_to_critical_hit(var_0, var_1, var_2) {
  reset_critical_hit(var_0);

  if(var_0 has_critical_expertise()) {
    switch (var_2) {
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_CRUSH":
      case "MOD_SCARAB":
      case "MOD_IMPACT":
      case "MOD_MELEE":
        return;
    }

    if(!isDefined(var_1) || var_1 == "head" || var_1 == "helmet" || var_1 == "neck") {
      return;
    }
    var_3 = var_0 _id_0945::_id_664E("critical_expertise_chance");

    if(isDefined(var_3) && randomfloat(1) < var_3) {
      var_0.critical_expertise.critical_hit = scripts\engine\utility::array_add(var_0.critical_expertise.critical_hit, self);
    }
  }
}

reset_critical_hit(var_0) {
  if(isDefined(var_0) && isDefined(var_0.critical_expertise)) {
    var_0.critical_expertise.critical_hit = scripts\engine\utility::array_remove(var_0.critical_expertise.critical_hit, self);
  }
}

get_critical_expertise_multiplier(var_0, var_1) {
  if(var_0 has_critical_expertise()) {
    var_2 = _func_0461("head");
    var_3 = _func_0462(self, var_1, var_2);
    var_4 = scripts\cp\utility::_id_459B(var_0 _id_0945::_id_664E("critical_expertise_multiplier"), 1.0);
    return var_3 * var_4;
  }

  return 1.0;
}

is_critical_expertise_active(var_0, var_1) {
  return var_1 is_critical_hit(var_0);
}