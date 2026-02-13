/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_artifact_defense_system.gsc
***************************************************************/

init() {
  _id_0945::_id_C2B1("specialty_artifact_defense", ::set_artifact_defense, ::unset_artifact_defense);
  _id_0945::_id_C2B1("specialty_artifact_defense_legendary", ::set_artifact_defense, ::unset_artifact_defense);
}

set_artifact_defense() {
  self.nextartifactdefense = gettime();
}

unset_artifact_defense() {
  self.nextartifactdefense = undefined;
}

try_to_activate_artifact_defense_system(var_0) {
  if(!isDefined(self.nextartifactdefense)) {
    return;
  }
  if(scripts\cp\utility::_hasperk("specialty_artifact_defense") && is_hit_on_the_back(var_0) || scripts\cp\utility::_hasperk("specialty_artifact_defense_legendary")) {
    var_1 = gettime();

    if(var_1 >= self.nextartifactdefense) {
      var_2 = _id_0945::_id_664E("artifact_defense_chance");

      if(isDefined(var_2) && randomfloat(1) < var_2) {
        if(_id_0766::_id_24B6(1, 1)) {
          var_3 = _id_0945::_id_664E("artifact_defense_cooldown");
          self.nextartifactdefense = var_1 + scripts\cp\utility::_id_459B(scripts\cp\utility::_id_CFF0(var_3), 0);
        }
      }
    }
  }
}

is_hit_on_the_back(var_0) {
  var_1 = self.origin - var_0.origin;
  var_1 = vectornormalize((var_1[0], var_1[1], 0));
  var_2 = anglesToForward(self.angles);
  var_3 = vectordot(var_2, var_1);
  return var_3 > 0;
}