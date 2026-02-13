/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2640.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("juggernaut", _id_09B8::_id_F78F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "initConfig", ::_id_8C06);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "levelData", ::_id_8C07);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerActionSet", ::_id_8C10);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "registerOnPlayerSpawnCallback", ::_id_8C11);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "dropCrateFromScriptedHeli", ::_id_8BF7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "makeJuggernaut", ::_id_8C09);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "watchPickup", ::_id_8C29);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "getMoveSpeedScalar", ::_id_8BFD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "updateMoveSpeedScale", ::_id_8C1D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "allowActionSet", ::_id_8BE1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "decrementFauxVehicleCount", ::_id_8BF3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "incrementFauxVehicleCount", ::_id_8C04);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "canTriggerJuggernaut", ::_id_8BE9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "playOperatorUseLine", ::_id_8C0E);
}

_id_8C10() {
  scripts\mp\playeractions::_id_C23B("fakeJugg", ["slide", "prone", "reload"]);
}

_id_8C11(var_0) {}

_id_8BF7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return scripts\cp_mp\killstreaks\airdrop::_id_502A(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_8C09(var_0, var_1) {
  return _id_07E6::_id_8C08(var_0, var_1);
}

_id_8C06(var_0) {
  return _id_07E6::_id_8BED(var_0);
}

_id_8C07(var_0) {
  return scripts\cp_mp\killstreaks\airdrop::_id_6B00(var_0);
}

_id_8C29() {
  thread scripts\mp\weapons::_id_10BCF();
}

_id_8BFD() {
  return _id_07E6::_id_8BFD();
}

_id_8C1D() {
  scripts\mp\weapons::_id_FCCC();
}

_id_8BE1(var_0, var_1) {
  scripts\mp\playeractions::_id_1596(var_0, var_1);
}

_id_8BF3() {
  scripts\mp\utility\killstreak::_id_455A();
}

_id_8C04() {
  scripts\mp\utility\killstreak::_id_7DEF();
}

_id_8BE9(var_0) {
  if(scripts\mp\utility\game::_id_875D()) {
    return 1;
  }

  var_1 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

  foreach(var_3 in var_1) {
    if(var_3 != self && var_3.primaryweaponobj.basename == "s4_gw_flima35_mp") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_FLAMETHROWER");
      }

      _id_0A8D::_id_9137("battlespace_crowded");
      return 0;
    }
  }

  return 1;
}

jugg_arena_evo_canpurchasejuggernaut() {
  return !scripts\mp\gametypes\arena_evo_tourney_loot::arenatournament_at_max_flamenauts();
}

_id_8C85(var_0, var_1) {
  if(istrue(self._id_88DF)) {
    return;
  }
  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "s4_gw_flima35_mp") {
    var_2 = weaponclipsize(var_1);
    self setweaponammoclip(var_1, var_2);
    return;
  }

  self._id_9F06 = var_1;
  self._id_B7E4 = _id_07E6::_id_8BFD();
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\playeractions::_id_1596("fakeJugg", 0);

  if(!istrue(level._id_4ACD)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  _id_09B8::_id_10B92(var_0, var_1);
}

_id_8C0E(var_0) {
  level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "use_killstreak_juggernaut_local");
}