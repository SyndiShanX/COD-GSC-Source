/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo_tourney_weapon_util.gsc
******************************************************************/

_id_1AD2(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1AA4[var_0])) {
    return 0;
  }

  return var_1._id_1AA4[var_0];
}

arenatournament_get_weapon_rarity_from_level(var_0, var_1) {
  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  var_2 = "weapon_level_" + var_1;
  var_3 = level._id_1A90[var_0][var_2];

  if(isDefined(var_3)) {
    return var_3;
  } else {
    return "comm";
  }
}

arenatournament_get_weapon_level_from_object(var_0) {
  var_1 = getcompleteweaponname(var_0);
  return arenatournament_get_weapon_level_from_name(var_1);
}

arenatournament_get_weapon_level_from_name(var_0) {
  var_1 = strtok(var_0, "+");
  var_2 = scripts\mp\utility\script::_id_EA63(var_1[0], "_mp");
  var_3 = [];

  foreach(var_5 in var_1) {
    var_3[var_5] = 1;
  }

  for(var_7 = level._id_1A8F[var_2].size - 1; var_7 > 0; var_7--) {
    var_8 = level._id_1A8F[var_2][var_7];

    if(isDefined(var_3[var_8])) {
      return var_7;
    }
  }

  return 0;
}

_id_1A9D(var_0) {
  return isDefined(_id_B491(var_0.basename));
}

_id_B491(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = getweaponbasename(var_3);

    if(scripts\engine\utility::is_equal(var_4, var_0)) {
      return var_3;
    }
  }
}