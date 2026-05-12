/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_mortarstrike.gsc
*************************************************/

func_00D5() {
  level.var_80B7["mortar_strike"] = 300;
  level.var_80B8["mortar_strike"] = 100;
  level.var_80B6["mortar_strike"] = 0;
  level.var_80B9["mortar_strike"] = 1;
  level.var_80B5["mortar_strike"] = 4;
  level.var_5A61["mortar_strike"] = ::func_9E34;
  level.var_5A7D["mortar_strike_projectile_mp"] = "mortar_strike";
  level.var_5A7D["mortar_strike_projectile_axis_mp"] = "mortar_strike";
}

func_9E34(param_00) {
  return maps\mp\killstreaks\_v2_missle_strike::func_9E39(param_00, "mortar_strike");
}

func_63B6(param_00, param_01) {
  self endon("stop_location_selection");
  maps\mp\_utility::func_3E8E(1);
  for(;;) {
    var_02 = func_83B3(param_00, param_01);
    thread func_3C16(param_00, var_02, param_01);
    self method_82FA("killstreak_mortar_mp", 0);
    while(self getweaponammoclip("killstreak_mortar_mp") == 0) {
      wait 0.05;
    }

    var_03 = self getweaponammostock("killstreak_mortar_mp");
    if(var_03 <= 0) {
      break;
    }
  }

  self method_82FA("killstreak_mortar_mp", 0);
  self notify("mortars_empty");
}

func_63B5() {
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::func_A70A("stop_location_selection", "mortars_empty");
  self switchtoweapon(common_scripts\utility::func_4550());
  maps\mp\_utility::func_3E8E(0);
}

func_83B3(param_00, param_01) {
  self endon("stop_location_selection");
  var_02 = 0;
  var_03 = 1;
  maps\mp\_utility::func_05D4(param_01, "map_artillery_selector", var_02, maps\mp\killstreaks\_v2_missle_strike::func_46C2(param_01), 0.5, var_03);
  thread maps\mp\killstreaks\_v2_missle_strike::func_A6AB();
  var_04 = [];
  self waittill("confirm_location", var_05, var_06);
  var_04[0] = var_05;
  lib_0380::func_288B("mp_ks_target_select_circle_target", self, self);
  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  return var_05;
}

func_3C16(param_00, param_01, param_02) {
  self endon("disconnect");
  wait(0.9);
  if(!isDefined(self)) {
    return;
  }

  var_03 = spawnplane("script_model", param_01);
  var_04 = spawnplane("script_model", param_01);
  thread maps\mp\killstreaks\_v2_missle_strike::func_8C0B(param_02, self, var_03, var_04);
  thread maps\mp\killstreaks\_v2_missle_strike::func_624C(var_03, var_04);
  lib_0526::func_280E(param_01, 0, param_02, self.var_01A7);
  thread lib_0526::func_5FCB(param_01, param_02);
  var_05 = maps\mp\killstreaks\_v2_missle_strike::func_458A(param_02);
  var_06 = maps\mp\killstreaks\_v2_missle_strike::func_458A(param_02);
  var_07 = (param_01[0] + var_05, param_01[1] + var_06, 0);
  var_08 = bulletTrace(var_07 + (0, 0, 20000), var_07 - (0, 0, 20000), 0);
  var_09 = (32, -8, 16);
  var_0A = self.var_0116 + rotatevector(var_09, self.var_001D);
  var_0B = magicartillery(maps\mp\killstreaks\_v2_missle_strike::func_458D(param_02, self.var_01A7), var_08["position"] + (0, 0, maps\mp\killstreaks\_v2_missle_strike::func_4578()), var_08["position"], 1.5, maps\mp\killstreaks\_v2_missle_strike::func_4578(), self);
  var_0B lib_0378::func_8D74("ks_projectile_fired", param_02);
  var_0B thread maps\mp\killstreaks\_v2_missle_strike::func_7EBD(param_02, var_03, var_04);
  var_0B thread maps\mp\killstreaks\_v2_missle_strike::func_624F(self);
}