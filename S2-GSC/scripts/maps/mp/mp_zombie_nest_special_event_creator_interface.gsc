/******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_special_event_creator_interface.gsc
******************************************************************************/

_id_8F2A(var_0) {
  var_1 = isDefined(level._id_08E3) && level._id_08E3.size > 0;

  if(!var_1) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_2 = 0;

    foreach(var_4 in level._id_08E3) {
      if(issubstr(var_4._id_695B, var_0)) {
        return 1;
      }
    }

    return 0;
  }

  return 1;
}

_id_ABD2(var_0) {
  foreach(var_2 in level._id_08CB) {
    if(!isDefined(var_2._id_65D6)) {
      continue;
    }
    foreach(var_4 in var_2._id_65D6) {
      if(isDefined(var_4) && isDefined(var_0) && var_4 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_08F4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = common_scripts\utility::_id_46B5(var_7, "targetname");
  var_9 = common_scripts\utility::_id_46B7(var_8.target, "targetname");

  foreach(var_11 in var_9) {
    var_11._id_38B2 = var_0._id_38C3;
  }

  var_0._id_65D6 = [];
  var_0._id_ABEA = spawnStruct();
  var_0._id_ABEA._id_5054 = var_9;
  var_0._id_ABEA._id_1176 = var_1;
  var_0._id_ABEA._id_67EA = var_2;
  var_0._id_ABEA._id_AC7C = var_3;
  var_0._id_ABEA._id_38B7 = var_4;
  var_0._id_ABEA._id_38B8 = var_5;
  var_0._id_ABEA._id_29B3 = var_6;
  var_0._id_ABEA._id_504B = var_7;
  var_13 = var_0._id_38C4["zombieObjectiveMax"];
  var_14 = var_0._id_38C4["respawnExclusionRadius"];
  _id_52F1(var_0);
  level thread _id_7F7C();
}

_id_52F1(var_0) {
  var_0._id_ABEA._id_1176 maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_52DD(var_0);
}

_id_7C69(var_0) {
  _id_23C4(var_0);
  var_0._id_ABEA = undefined;
}

_id_7F7C() {
  level notify("new_zombie_defense_event");
  level endon("new_zombie_defense_event");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  var_0 = 0.125;
  var_1 = 0;

  while(_id_0547::_id_0795()) {
    foreach(var_3 in level._id_08CB) {
      if(!common_scripts\utility::_id_562E(var_3._id_552B)) {
        continue;
      }
      var_3._id_65D6 = _id_23B0(var_3);
      var_1 = _id_2C2B(var_3);

      if(var_1) {
        break;
      }

      maps\mp\mp_zombie_nest_special_event_creator_util::_id_2C2C(var_3, 5000);
      _id_2C2D(var_3, var_0);
      var_3 _id_2E60();
    }

    _id_7C82();

    foreach(var_6 in level.players) {
      var_6._id_5579 = var_6 maps\mp\mp_zombie_nest_special_event_creator_util::_id_600B();
    }

    if(var_1) {
      maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_23A0();
      maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_A63F();
    }

    if(_id_0547::_id_0BC7()) {
      maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
    }

    if(_id_0547::_id_0796()) {
      maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
    }

    wait(var_0);
  }

  maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_23A0();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
}

_id_7C82() {
  var_0 = [];

  foreach(var_2 in level._id_08CB) {
    if(!isDefined(var_2) || !isDefined(var_2._id_65D6)) {
      continue;
    }
    foreach(var_4 in var_2._id_65D6) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(!common_scripts\utility::_id_0F79(var_0, var_4)) {
        var_0 = common_scripts\utility::_id_0F6F(var_0, var_4);
        continue;
      }

      var_2._id_65D6 = common_scripts\utility::_id_0F93(var_2._id_65D6, var_4);
    }
  }
}

_id_2E60() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_9B61) && isDefined(var_2._id_9B61._id_38B2)) {
      if(var_2._id_9B61._id_38B2 == self._id_38C3 && !common_scripts\utility::_id_0F79(self._id_65D6, var_2)) {
        self._id_65D6 = common_scripts\utility::_id_0F6F(self._id_65D6, var_2);
      }

      if(var_2._id_9B61._id_38B2 != self._id_38C3 && common_scripts\utility::_id_0F79(self._id_65D6, var_2)) {
        self._id_65D6 = common_scripts\utility::_id_0F93(self._id_65D6, var_2);
      }
    }
  }
}

_id_23B0(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_65D6) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  return var_1;
}

_id_23C4(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_65D6)) {
    foreach(var_2 in var_0._id_65D6) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_2 maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_8605();
      }
    }

    var_0._id_65D6 = [];
  }
}

_id_2C2B(var_0) {
  var_1 = ["zombie_generic", "zombie_berserker"];
  var_2 = 0;
  var_3 = maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_4082(var_0._id_ABEA._id_1176);
  var_2 = maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_7C0F(var_0._id_ABEA._id_1176, var_1);
  var_4 = maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_425A(var_1, var_0._id_ABEA._id_38B7);

  if(!var_2) {
    var_0 maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_9E0E(var_4, var_3, var_0._id_ABEA._id_5054, var_1, var_0._id_38C4["zombieObjectiveMax"]);
  }

  return var_2;
}

_id_2C2D(var_0, var_1) {
  if(level.players.size > 1) {
    var_2 = var_0._id_38C4["objectiveHealth"];
  } else {
    var_2 = var_0._id_38C4["objectiveHealthSolo"];
  }

  var_3 = var_0._id_ABEA._id_1176;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5] maps\mp\mp_zombie_nest_special_event_creator_util::_id_45BC();

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_3[var_5]._id_28FF = var_3[var_5]._id_28FF - var_1;
      var_3[var_5] thread _id_0378::_id_8D74("aud_tower_machine_zombie_hit");
      var_4 = 1;
    }

    [[var_0._id_ABEA._id_29B3]](var_3[var_5], var_2, var_4);

    if(var_3[var_5]._id_28FF <= 0) {
      var_8 = 1;

      for(var_5 = 0; var_5 < var_3.size; var_5++) {
        var_3[var_5]._id_28FF = 0;
        var_3[var_5] notify(var_0._id_ABEA._id_67EA._id_39D1);
      }
    }
  }

  maps\mp\mp_zombie_nest_special_event_creator_util::_id_11B4(var_3);
}

_id_55C0() {
  if(_id_0547::_id_0796()) {
    for(var_0 = 0; var_0 < level._id_08CB.size; var_0++) {
      if(distance(self.origin, level._id_08CB[var_0]._id_38B7) < level._id_08CB[var_0]._id_38BA) {
        return 1;
      }
    }

    return 0;
  } else
    return 0;
}

_id_9959() {
  foreach(var_1 in level.players) {
    for(var_2 = 0; var_2 < level._id_08CB.size; var_2++) {
      if(isalive(var_1) && !common_scripts\utility::_id_562E(var_1.inlaststand) && var_1 _id_55C1(level._id_08CB[var_2])) {
        return 1;
      }
    }
  }

  return 0;
}

_id_55C1(var_0) {
  return distance(self.origin, var_0._id_38B7) < var_0._id_38BA;
}

_id_405B() {
  var_0 = common_scripts\utility::random(level._id_08CB);
  return var_0._id_38C2;
}

_id_08F3(var_0) {
  if(!isDefined(level._id_08CB)) {
    level._id_08CB = [];
  }

  level._id_08CB = common_scripts\utility::_id_0F6F(level._id_08CB, var_0);
}

_id_7C68(var_0) {
  level._id_08CB = common_scripts\utility::_id_0F93(level._id_08CB, var_0);
}