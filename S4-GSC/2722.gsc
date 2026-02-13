/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2722.gsc
*************************************************/

_id_57C8() {
  if(isDefined(self._id_0393)) {
    wait(self._id_0393);
  }

  self playSound(level._id_CC46[self._id_CE49]);
}

_id_B8F1(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 _meth_81E2() && !var_4 _meth_81E3()) {
          continue;
        }
        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !scripts\engine\utility::array_contains(var_2, var_4)) {
          var_4 playlocalsound(var_0);
        }
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 _meth_81E2() && !var_4 _meth_81E3()) {
        continue;
      }
      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_4 playlocalsound(var_0);
      }
    }

    return;
  } else if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] _meth_81E2() && !level.players[var_3] _meth_81E3()) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_2, level.players[var_3])) {
        level.players[var_3] playlocalsound(var_0);
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] _meth_81E2() && !level.players[var_3] _meth_81E3()) {
        continue;
      }
      level.players[var_3] playlocalsound(var_0);
    }
  }
}

_id_B2DD(var_0, var_1) {
  _id_B2DE(var_0);
}

_id_B2DE(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
  } else {
    playsoundatpos(self.origin, var_0);
  }
}

_id_B8BA(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playSound(var_2, var_0);
}

_id_B386(var_0, var_1) {
  var_2 = "effort_death";

  switch (var_0) {
    case "MOD_FALLING":
      var_2 = "effort_death";
      break;
    case "MOD_BURNED_OVER_TIME":
    case "MOD_BURNED":
    case "MOD_FIRE_BULLET":
    case "MOD_FIRE":
      var_2 = "effort_burned";

      if(var_1 _meth_8624("ammo_incendiary", 1)) {
        var_2 = "effort_death";
      }

      break;
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_PROJECTILE":
      var_2 = "effort_exploded";
      break;
    case "MOD_MELEE":
      if(var_1 _meth_8624("bayonet", 1) || var_1.basename == "s4_me_knife_mp") {
        var_2 = "effort_stabbed";
      } else {
        var_2 = "effort_bludgeoned";
      }

      break;
    case "MOD_CRUSH":
      var_2 = "effort_death_veh_fl";
      var_2 = "effort_death_veh_hi";
      var_2 = "effort_death_veh_un";
      break;
    default:
      var_2 = "effort_death";

      if(var_1.basename == "s4_gas_usa_mk5cn_mp") {
        var_2 = "gas_player_death";
      }

      break;
  }

  level thread scripts\mp\battlechatter_mp::_id_F759(self, var_2);
}