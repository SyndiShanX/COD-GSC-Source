/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1372.gsc
**************************************/

init() {
  var_0 = level._id_0A41["zombie"];
  var_0["think"] = ::_id_AB57;
  var_0["move_mode"] = ::_id_AB54;
  var_0["post_model"] = ::_id_AB52;
  var_0["ragdoll_overrides"] = ::_id_AB56;
  var_0["on_damaged"] = ::_id_AB55;
  var_0["is_hit_weak_point"] = ::_id_AB53;
  level._id_0A41["zombie_berserker"] = var_0;
  var_1["whole_body"] = "zom_sprinter_base";
  var_1["heads"] = ["zom_sprinter_head"];
  var_2 = spawnStruct();
  var_2._id_0A4B = "zombie_berserker";
  var_2._id_0EAE = "zombie_animclass";
  var_2._id_0879 = "zombie_generic";
  var_2._id_5ED2["sprinter"] = var_1;
  var_2._id_4C12 = 0.5;
  var_2._id_60E2 = 30;
  var_2._id_8302 = 65;
  var_2._id_8303 = 15;
  var_2.parenttype = "zombie_generic";
  var_2.suppressive_fire_speed_multiplier = 0.3;
  var_2.tacklebymelee = 1;
  var_2.tacklebycharge = 1;
  var_2.knockbyravensword = 1;
  var_2.shockbyteslablood = 1;
  var_2.energyhold = 1;
  var_2.energyholdkill = 1;
  var_2.energyholdsecondary = 1;
  var_2.throwable = 1;
  _id_0547::_id_0A52(var_2, "zombie_berserker");
  common_scripts\utility::_id_092C("zmb_sprinter_head_flies", "vfx/zombie/zmb_sprinter_head_flies");
}

_id_AB57() {
  var_0 = 0.0872222;
  self _meth_85E0(1);
  self _meth_85DE(var_0);
  self._id_2FA4 = 0;
  self.cornerlessturnmindegreeoverride = 70;
  self _meth_85A1("zombie_berserker");
  self.stuckfortraversalthreshold = 16;
  _id_0566::_id_ABB4();
}

_id_AB54() {
  self._id_64C2 = 1.1 * _id_054D::_id_4440();
  return "sprint";
}

_id_4759() {
  self endon("death");
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  _func_147(common_scripts\utility::_id_44F5("zmb_sprinter_head_flies"), self, "j_head");
}

_id_AB52() {
  var_0 = self _meth_8445("j_head");

  if(var_0 == -1) {}

  thread _id_4759();
}

_id_AB56() {
  return 0.8;
}

_id_AB55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_5 == "panzerschreck_zm" || var_5 == "bazooka_zm")
    var_2 = self.maxhealth;

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_AB53(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_8) && (var_8 == "head" || var_8 == "helmet"))
    return 1;

  return 0;
}