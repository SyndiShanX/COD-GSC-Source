/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1337.gsc
**************************************/

init() {}

_id_3662() {
  _id_054B::_id_6AB2("role_ability_melee_frenzy_zm");
  self._id_60E8 = 1;
  _id_0547::_id_7ACD();
}

_id_2F9E() {
  if(common_scripts\utility::_id_562E(self._id_60E8)) {
    self._id_60E8 = undefined;
    _id_0547::_id_7ACD();
  }
}

_id_62A6(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_2) && maps\mp\_utility::_id_5755(var_2) && isDefined(var_1._id_60E8)) {
    switch (self._id_0A4B) {
      case "zombie_berserker":
      case "zombie_generic":
      case "zombie_exploder":
        var_3 = self.health + 1;
        break;
      default:
        var_3 = var_3 + 1500;
        break;
    }
  }

  return var_3;
}