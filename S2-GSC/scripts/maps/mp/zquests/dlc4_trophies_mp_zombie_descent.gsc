/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\dlc4_trophies_mp_zombie_descent.gsc
***********************************************************************/

init() {
  level thread run_shattered_trophy_event_1();
  level thread run_shattered_trophy_event_2();
  level thread run_shattered_trophy_event_3();
  level thread maps\mp\_utility::_id_6F74(::run_shattered_trophy_event_4);
  _id_0547::_id_7BA9(::run_shattered_trophy_event_9);
}

complete_descent_trophy_event_1(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_DESCENT", var_0, 1);
}

run_shattered_trophy_event_1() {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_firstdoor", "quest_firstdoor_bloodpool"));
  complete_descent_trophy_event_1();
}

complete_descent_trophy_event_2(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_SUPERIOR", undefined, 1);
}

run_shattered_trophy_event_2() {
  while(!common_scripts\utility::_id_3C83("flag_descent_pap")) {
    waitframe();
  }

  common_scripts\utility::_id_3C9F("flag_descent_pap");
  complete_descent_trophy_event_2();
}

complete_descent_trophy_event_3(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_BLOOD", undefined, 1);
}

run_shattered_trophy_event_3() {
  var_0 = ["zombie_fireman", "zombie_king", "zombie_treasurer", "zombie_sizzler"];

  while(!isDefined(level._id_0A50) || level._id_0A50.size == 0) {
    waitframe();
  }

  waitframe();

  foreach(var_3, var_2 in level._id_0A50) {
    if(common_scripts\utility::_id_0F79(var_0, var_3)) {
      continue;
    }
    common_scripts\utility::flag_init(var_3 + "_trophy_event_3");
  }

  foreach(var_3, var_2 in level._id_0A50) {
    if(common_scripts\utility::_id_0F79(var_0, var_3)) {
      continue;
    }
    common_scripts\utility::_id_3C9F(var_3 + "_trophy_event_3");
  }

  complete_descent_trophy_event_3();
}

complete_descent_trophy_event_4(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_LONG", var_0, 1);
}

run_shattered_trophy_event_4() {
  var_0 = self;
  wait_for_moon_raven_orb_gap("zone_cave", "zone_bridge");
  complete_descent_trophy_event_4(var_0);
}

complete_descent_trophy_event_5(var_0) {
  var_0.craftedweapons++;
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_MOONRAVEN", var_0, 1);
}

complete_descent_trophy_event_6(var_0) {
  var_0.craftedweapons++;
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_BLOODRAVEN", var_0, 1);
}

complete_descent_trophy_event_7(var_0) {
  var_0.craftedweapons++;
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_DEATHRAVEN", var_0, 1);
}

complete_descent_trophy_event_8(var_0) {
  var_0.craftedweapons++;
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_STORMRAVEN", var_0, 1);
}

complete_descent_trophy_event_9(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_WEAPON", var_0, 1);
}

run_shattered_trophy_event_9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(!isDefined(var_1.ravenweapontracker)) {
    var_1.ravenweapontracker = [];

    foreach(var_11, var_10 in level.ravenweaponmanager) {
      if(issubstr(var_11, "emp")) {
        continue;
      }
      var_1.ravenweapontracker[var_11] = 0;
    }
  }

  foreach(var_13, var_10 in var_1.ravenweapontracker) {
    if(issubstr(var_4, var_13)) {
      var_1.ravenweapontracker[var_13]++;
    }
  }

  foreach(var_13, var_10 in var_1.ravenweapontracker) {
    if(var_1.ravenweapontracker[var_13] < 100) {
      return;
    }
  }

  complete_descent_trophy_event_9(var_1);
}

complete_descent_trophy_event_10(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC4_ZM_KINGFALL", undefined, 1);
}

wait_for_moon_raven_orb_gap(var_0, var_1) {
  for(;;) {
    self waittill("zmb_moonraven_grenade_gap", var_2, var_3);

    if(!isDefined(var_2) || var_2 != var_0) {
      continue;
    }
    if(!isDefined(var_3) || var_3 != var_1) {
      continue;
    }
    break;
  }
}