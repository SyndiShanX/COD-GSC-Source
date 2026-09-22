/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_mortarstrike.gsc
*********************************************************/

init() {
  level._id_80B7["mortar_strike"] = 300;
  level._id_80B8["mortar_strike"] = 100;
  level.setwhizbyprobabilities["mortar_strike"] = 0;
  level._id_80B9["mortar_strike"] = 1.0;
  level.makeglobalunusable["mortar_strike"] = 4.0;
  level._id_5A61["mortar_strike"] = ::_id_9E34;
  level._id_5A7D["mortar_strike_projectile_mp"] = "mortar_strike";
  level._id_5A7D["mortar_strike_projectile_axis_mp"] = "mortar_strike";
}

_id_9E34(var_0) {
  return _id_052A::_id_9E39(var_0, "mortar_strike");
}

_id_63B6(var_0, var_1) {
  self endon("stop_location_selection");
  maps\mp\_utility::freezecontrolswrapper(1);

  for(;;) {
    var_2 = isswitchinggrenade(var_0, var_1);
    thread _id_3C16(var_0, var_2, var_1);
    self setweaponammoclip("killstreak_mortar_mp", 0);

    while(self getweaponammoclip("killstreak_mortar_mp") == 0) {
      waitframe();
    }

    var_3 = self getweaponammostock("killstreak_mortar_mp");

    if(var_3 <= 0) {
      break;
    }
  }

  self setweaponammoclip("killstreak_mortar_mp", 0);
  self notify("mortars_empty");
}

_id_63B5() {
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::_id_A70A("stop_location_selection", "mortars_empty");
  self switchtoweapon(common_scripts\utility::_id_4550());
  maps\mp\_utility::freezecontrolswrapper(0);
}

isswitchinggrenade(var_0, var_1) {
  self endon("stop_location_selection");
  var_2 = 0;
  var_3 = 1;
  maps\mp\_utility::_id_05D4(var_1, "map_artillery_selector", var_2, _id_052A::_id_46C2(var_1), 0.5, var_3);
  thread _id_052A::_id_A6AB();
  var_4 = [];
  self waittill("confirm_location", var_5, var_6);
  var_4[0] = var_5;
  _id_0380::_id_288B("mp_ks_target_select_circle_target", self, self);
  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  return var_5;
}

_id_3C16(var_0, var_1, var_2) {
  self endon("disconnect");
  wait 0.9;

  if(!isDefined(self)) {
    return;
  }
  var_3 = _func_190("script_model", var_1);
  var_4 = _func_190("script_model", var_1);
  thread _id_052A::_id_8C0B(var_2, self, var_3, var_4);
  thread _id_052A::_id_624C(var_3, var_4);
  _id_0526::_id_280E(var_1, 0, var_2, self.team);
  thread _id_0526::_id_5FCB(var_1, var_2);
  var_5 = _id_052A::_id_458A(var_2);
  var_6 = _id_052A::_id_458A(var_2);
  var_7 = (var_1[0] + var_5, var_1[1] + var_6, 0);
  var_8 = bulletTrace(var_7 + (0, 0, 20000), var_7 - (0, 0, 20000), 0);
  var_9 = (32, -8, 16);
  var_10 = self.origin + _rotatevector(var_9, self.angles);
  var_11 = _func_1B6(_id_052A::_id_458D(var_2, self.team), var_8["position"] + (0, 0, _id_052A::_id_4578()), var_8["position"], 1.5, _id_052A::_id_4578(), self);
  var_11 _id_0378::_id_8D74("ks_projectile_fired", var_2);
  var_11 thread _id_052A::_id_7EBD(var_2, var_3, var_4);
  var_11 thread _id_052A::_id_624F(self);
}