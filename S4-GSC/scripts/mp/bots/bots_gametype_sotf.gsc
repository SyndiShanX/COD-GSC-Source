/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sotf.gsc
**************************************************/

main() {
  _id_D795();
  _id_D77F();
}

_id_D795() {
  level._id_279D["dropped_weapon_think"] = ::_id_E040;
  level._id_279D["dropped_weapon_cancel"] = ::_id_E047;
  level._id_279D["crate_low_ammo_check"] = ::_id_E043;
  level._id_279D["crate_should_claim"] = ::_id_E044;
  level._id_279D["crate_wait_use"] = ::_id_E045;
  level._id_279D["crate_in_range"] = ::_id_E042;
  level._id_279D["crate_can_use"] = ::_id_E041;
}

_id_D77F() {
  level._id_2943 = 1;
}

_id_E047(var_0) {
  if(scripts\mp\bots\bots_util::_id_27D7() > 0) {
    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var_0._id_A860)) {
      var_2 = var_0._id_A860.classname;

      if(scripts\engine\utility::string_starts_with(var_2, "weapon_")) {
        var_2 = _func_00D6(var_2, 7);
      }

      var_3 = scripts\mp\utility\weapon::getweapongroup(var_2);

      if(!_id_2928(var_1, var_3)) {
        return 1;
      }
    }
  }

  if(!isDefined(var_0._id_A860)) {
    return 1;
  }

  return 0;
}

_id_E040() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = 0;

    if(self[[level._id_279D["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::_id_280F()) {
      if(scripts\mp\bots\bots_util::_id_2877()) {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = scripts\engine\utility::_id_6369(self.origin, var_1);

        if(var_2.size > 0) {
          var_3 = var_2[0];
          scripts\mp\bots\bots::_id_28B2(var_3);
        }
      } else {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = scripts\engine\utility::_id_6369(self.origin, var_1);

        if(var_2.size > 0) {
          var_4 = self _meth_815E();

          if(isDefined(var_4)) {
            var_5 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

            foreach(var_3 in var_2) {
              var_7 = var_3.classname;

              if(scripts\engine\utility::string_starts_with(var_7, "weapon_")) {
                var_7 = _func_00D6(var_7, 7);
              }

              var_8 = scripts\mp\utility\weapon::getweapongroup(var_7);

              if(_id_2928(var_5, var_8)) {
                if(!isDefined(var_3._id_2EE4) || !var_3._id_2EE4) {
                  var_3._id_A3F8 = _func_0080(var_3.origin);
                  var_3._id_2EE4 = 1;
                }

                if(isDefined(var_3._id_A3F8) && _func_0158(var_4, var_3._id_A3F8, 1)) {
                  scripts\mp\bots\bots::_id_28B2(var_3);
                  break;
                }
              }
            }
          }
        }
      }
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_28A3(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "weapon_other":
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
      break;
    case "weapon_pistol":
      var_1 = 1;
      break;
    case "weapon_dmr":
    case "weapon_sniper":
      var_1 = 2;
      break;
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_shotgun":
    case "weapon_smg":
      var_1 = 3;
      break;
  }

  return var_1;
}

_id_2928(var_0, var_1) {
  var_2 = _id_28A3(var_0);
  var_3 = _id_28A3(var_1);
  return var_3 > var_2;
}

_id_E043() {
  var_0 = self getcurrentweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  return var_1 + var_2 < var_3 * 0.25;
}

_id_E044() {
  return 0;
}

_id_E045() {
  scripts\mp\bots\bots_util::_id_291D(5000);
}

_id_E042(var_0) {
  return 1;
}

_id_E041(var_0) {
  if(scripts\mp\bots\bots::_id_3E70(var_0)) {
    if(isDefined(var_0) && isDefined(var_0._id_294D) && scripts\engine\utility::array_contains(var_0._id_294D, self)) {
      if(scripts\mp\bots\bots_util::_id_2877()) {
        return 1;
      } else {
        return 0;
      }
    }

    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(_id_28A3(var_1) <= 1) {
      return 1;
    }

    if(_id_E043()) {
      return 1;
    }

    return 0;
  }

  return 0;
}