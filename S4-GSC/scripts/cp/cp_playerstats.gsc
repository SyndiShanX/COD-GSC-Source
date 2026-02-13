/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_playerstats.gsc
*************************************************/

shouldtrackcombatstatsforweapon(var_0) {
  var_1 = 1;
  var_2 = _id_0728::_id_6A14(var_0);

  if(isDefined(var_2)) {
    var_1 = 0;
  } else {
    var_3 = scripts\cp\utility::getweaponrootname(var_0);

    if(_id_0766::is_artifact_weapon(var_0) || scripts\cp\covenants\cp_covenants::is_covenant_weapon(var_0) || var_3 == "s4_juggernaut") {
      var_1 = 0;
    }
  }

  return var_1;
}

_id_7DF5(var_0, var_1, var_2, var_3) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  if(shouldtrackcombatstatsforweapon(var_1)) {
    var_4 = scripts\cp\utility::getweaponrootname(var_1);
    var_5 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "weaponStats", var_4, var_2), 0);
    var_0 setplayerdata("cp", "playerStats", "weaponStats", var_4, var_2, var_5 + var_3);
  }
}

incrementcombatstat(var_0, var_1, var_2) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "combatStats", var_1), 0);
  var_0 setplayerdata("cp", "playerStats", "combatStats", var_1, var_3 + var_2);
}

incrementcategorystat(var_0, var_1, var_2, var_3, var_4) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_5 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", var_1, var_2, var_3), 0);
  var_0 setplayerdata("cp", "playerStats", var_1, var_2, var_3, var_5 + var_4);
}

updateonlyifhighercombatstat(var_0, var_1, var_2) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "combatStats", var_1), 0);

  if(var_2 > var_3) {
    var_0 setplayerdata("cp", "playerStats", "combatStats", var_1, var_2);
  }
}

updateweaponperc(var_0, var_1, var_2, var_3, var_4) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  if(shouldtrackcombatstatsforweapon(var_1)) {
    var_5 = scripts\cp\utility::getweaponrootname(var_1);
    var_6 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "weaponStats", var_5, var_3), 0);
    var_7 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "weaponStats", var_5, var_4), 0);
    var_8 = 0.0;

    if(var_7 != 0) {
      var_8 = float(var_6) / float(var_7) * 100.0;
    }

    var_0 setplayerdata("cp", "playerStats", "weaponStats", var_5, var_2, var_8);
  }
}

getweaponstatvalue(var_0, var_1, var_2) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "weaponStats", var_1, var_2), 0);
  return var_3;
}

updatecombatstat(var_0, var_1, var_2) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 setplayerdata("cp", "playerStats", "combatStats", var_1, var_2);
}

getmedaluse(var_0, var_1) {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  var_2 = scripts\cp\utility::_id_459B(var_0 getplayerdata("cp", "playerStats", "medalStats", var_1, "uses"), 0);
  return var_2;
}