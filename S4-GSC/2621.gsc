/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2621.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_7C8C = "deployable_vest";
  var_0.weaponinfo = "deployable_vest_marker_mp";
  var_0.modelbase = "prop_ballistic_vest_iw6";
  var_0._id_9FD4 = "prop_ballistic_vest_iw6_bombsquad";
  var_0._id_0224 = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  var_0._id_3239 = &"KILLSTREAKS_BOX_GETTING_VEST";
  var_0._id_5689 = "deployable_vest_taken";
  var_0.streakname = "deployable_vest";
  var_0._id_E419 = "used_deployable_vest";
  var_0._id_D968 = "compass_objpoint_deploy_friendly";
  var_0._id_75F5 = 20;
  var_0._id_9371 = 90.0;
  var_0._id_FEF7 = 50;
  var_0._id_CC16 = "destroyed_vest";
  var_0._id_1068F = "ballistic_vest_destroyed";
  var_0._id_47E9 = "mp_vest_deployed_ui";
  var_0._id_ABD3 = "ammo_crate_use";
  var_0._id_ABCD = ::_id_ABD0;
  var_0._id_3201 = ::_id_3203;
  var_0._id_FEE7 = 1000;
  var_0.maxhealth = 220;
  var_0._id_42FD = "deployable_bag";
  var_0._id_4421 = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  var_0._id_15C1 = 1;
  var_0._id_15B9 = 0;
  var_0._id_9CB7 = 4;
  var_0._id_3208 = 0;
  level._id_298E["deployable_vest"] = var_0;
  level._id_47DD["deployable_vest"] = [];
}

_id_F778(var_0, var_1) {
  var_2 = _id_0A3C::_id_24A8(var_0, "deployable_vest");

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\common\utility::_id_F73A(level._id_9BB4, "deployable_vest", self.origin);
  return 1;
}

_id_3203(var_0) {
  return !_id_07EA::_id_7580(self);
}

_id_ABD0(var_0) {
  _id_0A6B::_id_D5E1();
}

_id_6300(var_0, var_1) {
  if(var_0 + level._id_47E4[var_1] > level._id_47E3) {
    return level._id_47E3;
  }

  return var_0 + level._id_47E4[var_1];
}