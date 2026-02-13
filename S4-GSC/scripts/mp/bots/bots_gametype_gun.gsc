/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_gun.gsc
*************************************************/

main() {
  _id_D795();
  _id_D773();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27E6;
}

_id_D773() {}

_id_27E5(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = _func_00D6(var_0, 0, var_0.size - 3);
    var_3 = level._id_2926[var_2];
    var_4 = strtok(var_3, "| ");
    var_5 = weaponclass(var_0);

    if(var_5 == "pistol") {
      var_4 = ["cqb", "run_and_gun"];
    }

    if(var_4.size > 0) {
      var_6 = undefined;

      if(scripts\engine\utility::array_contains(var_4, var_1)) {
        var_6 = var_1;
      } else {
        var_6 = scripts\engine\utility::random(var_4);
      }

      if(self._id_B023 != var_6) {
        scripts\mp\bots\bots_util::_id_28C8(var_6);
      }
    }
  }
}

_id_27E6() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = self _meth_8030("throwKnifeChance");

  if(var_0 < 0.25) {
    self _meth_8053("throwKnifeChance", 0.25);
  }

  self _meth_8053("allowGrenades", 1);
  var_1 = "";
  var_2 = self._id_B023;
  wait 0.1;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(var_3.basename != "none" && !scripts\mp\utility\weapon::_id_88F6(var_3) && var_3.basename != var_1 && var_3.basename != "s4_knifestab_mp") {
      var_1 = var_3.basename;

      if(self _meth_8030("advancedPersonality") && self _meth_8030("strategyLevel") > 0) {
        _id_27E5(var_3.basename, var_2);
      }
    }

    self[[self._id_B025]]();
    wait 0.05;
  }
}