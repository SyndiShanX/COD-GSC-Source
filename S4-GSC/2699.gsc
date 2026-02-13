/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2699.gsc
*************************************************/

_id_6437(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_8987 = 1;
  var_2._id_8732 = 0;
  var_2._id_019B = var_0;
  var_2._id_42EB = var_1;
  return var_2;
}

_id_6439(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_8987 = 0;
  var_2._id_8732 = 0;
  var_2._id_8A27 = 1;
  var_2._id_019B = var_0;
  var_2._id_42EB = var_1;
  return var_2;
}

_id_6434(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_8987 = 0;
  var_2._id_8732 = 0;
  var_2._id_019B = var_0;
  var_2._id_42EB = var_1;
  return var_2;
}

_id_6436(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_8987 = 0;
  var_2._id_8732 = 0;
  var_2._id_019B = var_0;
  var_2._id_42EB = var_1;
  return var_2;
}

_id_6438(var_0) {
  return var_0.origin + (0, 0, 32);
}

_id_6435(var_0) {
  return var_0.origin;
}

_id_FF20() {
  return level.useperbullethitmarkers;
}

_id_8A8B(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var_0.basename) {
    case "blackout_grenade_mp":
    case "s4_smoke_usa_m18_mp":
    case "s4_stun_gbr_n69_mp":
    case "cryo_mine_mp":
      return 1;
    case "trophy_mp":
    case "deployable_cover_mp":
      return 0;
    default:
      return 0;
  }
}

_id_8866(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1) && scripts\engine\utility::_id_8794(var_1)) {
    var_3 = scripts\mp\utility\weapon::_id_6E69(var_0);

    foreach(var_5 in var_3) {
      if(var_5 == "fmj" || var_5 == "reflect") {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_8891(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  return var_1 == "head" || var_1 == "helmet" || issubstr(var_0, "s4_") && var_1 == "neck";
}

_id_8AA6(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  return var_1 == "torso_upper" || var_1 == "torso_lower" || issubstr(var_0, "iw8_") && var_1 == "neck";
}

_id_8AA7(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  return var_1 == "torso_upper" || issubstr(var_0, "iw8_") && var_1 == "neck";
}

_id_8AC1(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  switch (var_1) {
    case "neck":
    case "right_arm_lower":
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_leg_upper":
    case "right_leg_upper":
    case "torso_lower":
      return 1;
  }

  return 0;
}

_id_891A(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  switch (var_1) {
    case "left_leg_upper":
    case "right_leg_lower":
    case "right_leg_upper":
    case "right_foot":
    case "left_foot":
    case "left_leg_lower":
      return 1;
  }

  return 0;
}

_id_8AC0(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  switch (var_1) {
    case "neck":
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_upper":
    case "torso_lower":
    case "head":
    case "helmet":
      return 1;
  }

  return 0;
}

_id_894D(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  switch (var_1) {
    case "neck":
    case "right_arm_lower":
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_leg_upper":
    case "right_leg_lower":
    case "right_leg_upper":
    case "torso_lower":
    case "left_leg_lower":
    case "head":
    case "helmet":
      return 1;
  }

  return 0;
}

_id_8AC2(var_0, var_1, var_2, var_3) {
  if(!_id_FF64(var_0, var_2, var_3)) {
    return 0;
  }

  switch (var_1) {
    case "neck":
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_upper":
    case "left_leg_upper":
    case "right_leg_upper":
    case "torso_lower":
    case "head":
    case "helmet":
      return 1;
  }

  return 0;
}

_id_FF64(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(var_2.owner)) {
      switch (var_2._id_00EC) {
        case "misc_turret":
        case "script_model":
        case "script_vehicle":
          return 0;
      }
    }
  }

  switch (var_1) {
    case "MOD_FIRE":
    case "MOD_CRUSH":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      return 0;
  }

  return 1;
}

_id_890A(var_0, var_1, var_2, var_3) {
  if(var_3 != "MOD_MELEE") {
    return 0;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return 0;
  }

  if(var_1 _id_07DE::_id_756F()) {
    return 0;
  }

  if(!scripts\mp\utility\player::_id_8653()) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_885D(var_2.basename)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8927(var_2)) {
    return 1;
  }

  if(scripts\mp\utility\weapon::_id_88F9(var_2.basename)) {
    return 1;
  }

  if(scripts\mp\utility\weapon::_id_8778(var_2)) {
    return 1;
  }

  if(var_2.basename == "iw8_defibrillator_mp") {
    return 1;
  }

  if(scripts\mp\utility\weapon::_id_8774(var_2.basename) && var_0 getweaponammoclip(var_2) > 0) {
    return 1;
  }

  foreach(var_5 in var_2._id_0070) {
    if(scripts\engine\utility::string_starts_with(var_5, "bayonet") || scripts\engine\utility::string_starts_with(var_5, "tacknife")) {
      return 1;
    }
  }

  return 0;
}

_id_1DD9(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(!level.teambased) {
    return 0;
  } else if(!isDefined(var_1) || !isDefined(var_0)) {
    return 0;
  } else if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return 0;
  } else if(var_0 == var_1) {
    return 0;
  } else if(scripts\mp\utility\game::getgametype() == "infect" && var_0.pers["team"] == var_1.team && isDefined(var_1._id_EF66)) {
    return 0;
  } else if(scripts\mp\utility\game::getgametype() == "infect" && var_0.pers["team"] != var_1.team && isDefined(var_1._id_EF66)) {
    return 1;
  } else if(isDefined(var_1._id_CC51) && var_1._id_CC51) {
    return 0;
  } else if(scripts\mp\utility\player::_id_899C(var_0, var_1)) {
    return 0;
  } else if(isagent(var_0) && isDefined(var_0.owner) && var_0.owner == var_1) {
    return 0;
  } else if(var_0.team == var_1.team) {
    return 1;
  } else {
    return 0;
  }
}

_id_0DB6(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

_id_0DBA(var_0) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return undefined;
  }

  return var_0;
}

_id_42D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_09BF::_id_ADCA(var_0, var_1, undefined, var_2, var_3, var_4);

  if(!_func_010F(var_3) && var_3 != "MOD_FIRE") {
    return 1;
  }

  if(var_3 == "MOD_GRENADE") {
    return 1;
  }

  if(var_3 == "MOD_PROJECTILE") {
    return 1;
  }

  if(isDefined(var_0) && var_0 == var_1) {
    return 1;
  }

  if(var_1 _id_09BF::_id_8A6A(var_6)) {
    return 1;
  }

  if(scripts\mp\utility\weapon::_id_10DA2(var_2, var_5)) {
    return 1;
  }

  return 0;
}

_id_0CAE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_BF42(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  var_10 = scripts\engine\trace::_id_3EE0();
  var_11 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 1, 0);
  var_12 = [];

  foreach(var_14 in level.characters) {
    if(!isDefined(var_14)) {
      continue;
    }
    if(!var_14 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(var_9 && var_14 == var_5) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(level.teambased && var_14.team == var_5.team) {
      var_12[var_12.size] = var_14;
    }
  }

  var_16 = _func_02C5(var_5.origin, var_2, var_10, var_12, "physicsquery_all");

  if(isDefined(var_16) && var_16.size > 0) {
    for(var_17 = 0; var_17 < var_16.size; var_17++) {
      var_18 = var_16[var_17]["entity"];
      var_19 = var_16[var_17]["distance"];
      var_20 = var_16[var_17]["position"];

      if(!isDefined(var_18)) {
        continue;
      }
      var_21 = _func_02C1(var_0, var_20, var_11, undefined, 0, "physicsquery_closest");

      if(isDefined(var_21) && var_21.size > 0) {
        continue;
      }
      var_22 = max(var_19, var_1) / var_2;
      var_23 = var_3 + (var_4 - var_3) * var_22;
      var_18 dodamage(var_23, var_0, var_5, var_6, var_7, var_8);
    }
  }
}

_id_756D(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_764D);
}

_id_6A95(var_0) {
  return int(var_0 * self._id_764E);
}

_id_D5A2(var_0) {
  self._id_764D = 1;

  if(!isDefined(self._id_764E)) {
    self._id_764E = 1;
  }

  var_0 = int(clamp(var_0, 0, 100));
  var_1 = (100 - var_0) / 100;

  if(var_1 < self._id_764E) {
    self._id_764E = var_1;
  }
}

_id_3943() {
  self._id_764D = undefined;
  self._id_764E = undefined;
}

_id_0D8A() {
  if(self.sessionstate != "playing") {
    return;
  }
  if(_id_B7AF() && !isDefined(self._id_59E0)) {
    thread _id_07C3::_id_B6F7(self, self, self, 10000, 0, "MOD_SUICIDE", _func_0375(), (0, 0, 0), "none", 0, 1116, 1);
  } else if(!_id_B7AF() && !isDefined(self._id_59E0) && !isDefined(self.vehicle)) {
    self suicide();
  }
}

_id_EAE0() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  thread _id_EADF();
}

_id_EADF() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("suicide_on_alive");
  self endon("suicide_on_alive");

  while(!scripts\mp\utility\player::isreallyalive(self) || self.sessionstate != "playing") {
    waitframe();
  }

  _id_0D8A();
}

_id_B7AF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(istrue(var_0) && scripts\mp\utility\player::_id_8ACE()) {
    return 1;
  }

  if(isDefined(level._id_9FEE) && self[[level._id_9FEE]]()) {
    return 1;
  }

  return 0;
}

_id_89CC(var_0) {
  var_1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return 1;
  }

  return 0;
}

_id_A5A5(var_0, var_1) {
  if(var_0.damage == 0) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0.attacker;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    var_2 = var_0.inflictor;

    if(isDefined(var_2)) {
      if(isPlayer(var_2)) {
        var_1 = var_2;
      } else {
        var_1 = var_2.owner;
      }
    } else
      var_1 = undefined;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1)) {
      return;
    }
  } else if(level.teambased && isDefined(self.team) && self.team == var_1.team) {
    return;
  }
  _id_A5A0(var_0, var_1);
}

_id_A5A0(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.attacker;
  }

  var_2 = undefined;
  var_3 = _id_A5A4(var_1);

  if(!isDefined(var_3)) {
    var_3 = _id_A5A4(var_1, 1);
    var_2 = gettime();
  }

  var_3.damage = var_3.damage + var_0.damage;
  var_3.objweapon = var_0.objweapon;
  var_3.point = var_0.point;
  var_3._id_0165 = var_0._id_49CA;
  var_3._id_031A = var_0._id_031A;
  var_3._id_9CD6 = var_0._id_9CD6;
  var_3._id_90A7 = gettime();
  var_3._id_5BE2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, var_3._id_5BE2);

  if(isDefined(var_1) && isPlayer(var_1) && !isnullweapon(var_1 getcurrentprimaryweapon())) {
    var_3._id_E44C = getcompleteweaponname(var_1 getcurrentprimaryweapon());
  } else {
    var_3._id_E44C = undefined;
  }
}

_id_A5A4(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(self._id_1DD4) && istrue(var_1)) {
    self._id_1DD4 = [];
  }

  if(isDefined(self._id_1DD4)) {
    var_3 = var_0.guid;

    if(isDefined(var_3)) {
      var_2 = self._id_1DD4[var_3];

      if(isDefined(var_2)) {
        if(var_2._id_8ADB || level.teambased && var_0.team != var_2.team) {
          var_2 = undefined;
          self._id_1DD4[var_3] = undefined;
        }
      }

      if(!isDefined(var_2) && istrue(var_1)) {
        var_2 = spawnStruct();
        var_2.attacker = var_0;
        var_2.team = var_0.team;
        var_2.guid = var_3;
        var_2._id_8ADB = 1;
        var_2.damage = 0;
        var_2._id_79A3 = 0;
        var_2._id_5BE3 = gettime();
        self._id_1DD4[var_3] = var_2;
      }
    }
  }

  return var_2;
}

_id_A5A2() {
  self._id_1DD4 = undefined;
}

_id_A5A7(var_0, var_1, var_2, var_3) {
  if(_id_A5A8(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  if(isDefined(var_1.basename)) {
    if(var_3 != "MOD_MELEE") {
      switch (var_1.basename) {
        case "iw8_green_beam_mp":
        case "s4_binoculars_mp":
        case "s4_ks_targeting_radio_mp":
          return 1;
      }
    }

    if(var_3 == "MOD_IMPACT") {
      switch (var_1.basename) {
        case "at_mine_mp":
        case "s4_thermite_mp":
        case "s4_mine_ger_s44_mp":
        case "s4_semtex_mp":
        case "claymore_mp":
        case "s4_c4_mp":
          return 1;
      }
    } else {
      switch (var_1.basename) {
        case "emp_drone_player_mp":
        case "claymore_radial_mp":
        case "thermite_ap_mp":
        case "snapshot_grenade_mp":
        case "s4_gas_usa_mk5cn_mp":
        case "flash_grenade_mp":
        case "s4_stun_gbr_n69_mp":
          return 1;
      }
    }
  }

  return 0;
}

_id_A5A1(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_7D1F)) {
    self._id_7D1F = 0;
  }

  if(!isDefined(self._id_7D20)) {
    self._id_7D20 = [];
  }

  var_4 = self._id_7D1F;
  self._id_7D1F++;

  if(isDefined(var_1) && _func_0121(var_1)) {
    var_1 = makeweapon(var_1);
  }

  var_5 = spawnStruct();
  var_5._id_7C8C = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5._id_9CD6 = var_3;
  var_5._id_34E2 = isDefined(var_0);
  var_5._id_3530 = isDefined(var_1) && !isnullweapon(var_1);
  var_5._id_3520 = isDefined(var_2);
  var_5._id_352B = isDefined(var_3);
  self._id_7D20[var_4] = var_5;
  return var_4;
}

_id_A5A6(var_0) {
  if(!isDefined(self._id_7D20)) {
    return;
  }
  self._id_7D20[var_0] = undefined;
}

_id_A5A3() {
  self._id_7D20 = undefined;
}

_id_A5A8(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_7D20)) {
    return 0;
  }

  if(isDefined(var_1) && _func_0121(var_1)) {
    var_1 = makeweapon(var_1);
  }

  foreach(var_5 in self._id_7D20) {
    if(!isDefined(var_5)) {
      return 0;
    }

    if(var_5._id_34E2) {
      if(!isDefined(var_5.attacker)) {
        _id_A5A6(var_5._id_7C8C);
        continue;
      } else if(!isDefined(var_0))
        continue;
      else if(var_0 != var_5.attacker) {
        continue;
      }
    }

    if(var_5._id_3530) {
      if(!isDefined(var_1) || isnullweapon(var_1)) {
        continue;
      } else if(var_1 != var_5.objweapon) {
        continue;
      }
    }

    if(var_5._id_3520) {
      if(!isDefined(var_5.inflictor)) {
        _id_A5A6(var_5._id_7C8C);
        continue;
      } else if(!isDefined(var_2))
        continue;
      else if(var_2 != var_5.inflictor) {
        continue;
      }
    }

    if(var_5._id_352B) {
      if(!isDefined(var_3)) {
        continue;
      } else if(var_3 != var_5._id_9CD6) {
        continue;
      }
    }

    return 1;
  }

  return 0;
}

_id_8905(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::_id_8774(var_0)) {
    return 0;
  }

  if(var_0.type != "projectile") {
    return 0;
  }

  if(istrue(var_2) && var_0._id_0245 && isDefined(var_0._id_04B7)) {
    return 0;
  }

  return var_1 == "MOD_IMPACT" || var_1 == "MOD_PROJECTILE" || var_1 == "MOD_GRENADE";
}