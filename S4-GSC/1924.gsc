/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1924.gsc
*************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "createHintObject", ::_id_F649);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "canTripTrap", ::_id_F646);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "damageFunc", ::_id_F64A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "disarmGiveWeapon", ::_id_F64E);
}

_id_F649(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("script_model", var_0);
  var_11 setModel("tag_origin");
  var_11.angles = (0, 0, 0);

  if(isDefined(var_5)) {
    var_11 setuseholdduration(var_5);
  } else {
    var_11 setuseholdduration("duration_medium");
  }

  if(!isDefined(var_5) || var_5 == "duration_medium" || var_5 == "duration_long") {
    var_11 sethintrequiresholding(1);
  }

  if(isDefined(var_6)) {
    var_11 _meth_84D9(var_6);
  } else {
    var_11 _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    var_11 _meth_84D4(var_7);
  } else {
    var_11 _meth_84D4(200);
  }

  var_11 sethintdisplayfov(65);

  if(isDefined(var_9)) {
    var_11 setuserange(var_9);
  } else {
    var_11 setuserange(72);
  }

  if(isDefined(var_10)) {
    var_11 setusefov(var_10);
  } else {
    var_11 setusefov(65);
  }

  thread _id_D805();
  level thread scripts\cp\cp_weapon::_id_1046(self);
  var_3 = &"CP_STRIKE/DEFUSE";
  var_11 sethintstring(var_3);
  var_11 setcursorhint("HINT_BUTTON");
  var_11 makeuseable();
  return var_11;
}

_id_D805() {
  self _meth_86FE("equipment");
  self waittill("death");

  if(isDefined(self)) {
    self _meth_86FF("equipment");
  }
}

_id_F646(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isPlayer(var_0) && _func_010F(var_2) && var_3 > 90) {
    return 1;
  }

  if(isPlayer(var_0) && _id_8AB1(var_2) && var_3 > 10) {
    return 1;
  }

  if(isPlayer(var_0) && _id_881A(var_0, var_1)) {
    return 1;
  }

  return 0;
}

_id_8AB1(var_0) {
  if(scripts\engine\utility::_id_8794(var_0)) {
    return 1;
  }

  if(var_0 == "MOD_FIRE") {
    return 1;
  }

  return 0;
}

_id_881A(var_0, var_1) {
  if(var_1.basename == "emp_drone_player_mp") {
    return 1;
  }

  if(var_1.basename == "emp_drone_non_player_mp") {
    return 1;
  }

  if(var_1.basename == "emp_drone_non_player_direct_mp") {
    return 1;
  }

  return 0;
}

_id_F64A(var_0, var_1) {
  var_0 _meth_86FF("equipment");

  if(isDefined(var_1) && isPlayer(var_1)) {
    _func_01BA(var_0.origin, 384, 256, 40, undefined, "MOD_SUICIDE", "frag_grenade_mp");
  } else {
    _func_01BA(var_0.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  }

  playrumbleonposition("grenade_rumble", var_0.origin);
  earthquake(0.45, 0.7, var_0.origin, 800);

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(distancesquared(var_1.origin, var_0.origin) < 250000) {
      level thread _id_0750::_id_F759(var_1, "flavor_negative", undefined, 1);
    }
  }
}

_id_F653(var_0, var_1) {
  var_2 = "power_frag";

  if(!_func_0121(var_0)) {
    var_2 = getcompleteweaponname(var_0);
  }

  switch (var_2) {
    case "frag":
      var_3 = "power_frag";
      break;
    case "semtex":
      var_3 = "power_semtex";
      break;
    case "c4":
      var_3 = "power_c4";
      break;
    default:
      var_3 = "power_frag";
      break;
  }

  var_4 = 0;

  if(isDefined(var_1._id_BADE[var_3])) {
    var_4 = var_1._id_BADE[var_3]._id_3411;
  }

  var_5 = _id_073C::_id_65FC(var_1, "primary");

  if(var_4 >= var_5) {
    var_4 = var_5 - 1;
  }

  var_1 _id_0753::_id_6FD3(var_3, "primary", undefined, undefined, undefined, 0, 1, var_4 + 1);
}

_id_F64E(var_0, var_1, var_2) {
  var_3 = var_0;

  if(_func_0121(var_0)) {
    var_3 = makeweaponfromstring(var_0);
  }

  if(_id_755C(var_0, var_2) || _id_758B(var_2)) {
    _id_F653(var_0, var_2);
  }

  level thread _id_B219(var_2);
}

_id_755C(var_0, var_1) {
  var_2 = var_0;

  if(_func_0121(var_0)) {
    var_2 = makeweaponfromstring(var_0);
  }

  var_3 = var_1._id_02FF;

  foreach(var_5 in var_3) {
    if(getweaponbasename(var_5) == getweaponbasename(var_2)) {
      return 1;
    }

    if(getweaponbasename(var_2) == "frag" && getweaponbasename(var_5) == "frag_grenade_mp") {
      return 1;
    }
  }

  return 0;
}

_id_758B(var_0) {
  var_1 = 0;
  var_2 = var_0._id_02FF;

  foreach(var_4 in var_2) {
    var_5 = scripts\cp\utility::_id_6A18(getweaponbasename(var_4));

    if(isDefined(var_5)) {
      if(var_5 == "lethal") {
        var_1 = 1;
      }
    }
  }

  if(!var_1) {
    return 1;
  }

  return 0;
}

_id_8A10(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6A18(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_2 == scripts\cp\utility::_id_6A18(var_1)) {
    return 1;
  }

  return 0;
}

_id_757D(var_0) {
  var_1 = var_0._id_02FF;

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\utility::_id_6A18(getweaponbasename(var_3));

    if(isDefined(var_4) && var_4 == "lethal") {
      return 1;
    }
  }

  return 0;
}

_id_B219(var_0) {
  if(!isDefined(level._id_1064D) || gettime() > level._id_1064D) {
    level._id_1064D = gettime() + 30000;
    level thread _id_0750::_id_F759(var_0, "ping_enemy_traps", undefined, 0.8);
  }
}