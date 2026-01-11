/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2785.gsc
***************************************/

init() {
  level.func_D77E = spawnStruct();
  level.func_D77E.passivestringref = [];
  level.func_D77E.func_D799 = [];
  func_DF04("passive_decreased_cost");
  func_DF04("passive_reduced_cooldown");
  func_DF04("passive_increased_charges");
  func_DF06("power_blinkKnife", ["passive_health_regen_on_kill"]);
  func_DF06("power_clusterGrenade", ["passive_increased_speed", "passive_increased_spread", "passive_increased_entities"]);
}

getpassiveperk(var_00) {
  if(var_00 <= 0) {
    return [];
  }

  var_01 = level.func_D77E.passivestringref[var_00];

  if(!isDefined(var_01)) {
    var_02 = tablelookuprownum("mp\loot\iw7_power_loot_master.csv", 0, var_00);
    var_03 = [8, 9, 10];
    var_01 = [];

    foreach(var_05 in var_03) {
      var_06 = func_B030(var_02, var_05);

      if(!isDefined(var_06)) {
        break;
      }
      var_1[var_1.size] = var_06;
    }

    level.func_D77E.passivestringref[var_00] = var_01;
  }

  return var_01;
}

func_B030(var_00, var_01) {
  var_02 = tablelookupbyrow("mp\loot\iw7_power_loot_master.csv", var_00, var_01);
  return scripts\engine\utility::ter_op(isDefined(var_02) && var_02 != "", var_02, undefined);
}

func_D779(var_00, var_01) {
  if(var_00 == "power_teleport" && isDefined(self.func_115FC) && self.func_115FC) {
    return 0;
  }

  var_03 = self.powers[var_00];

  if(!isDefined(var_03) || !isDefined(var_3.passives)) {
    return 0;
  }

  foreach(var_05 in var_3.passives) {
    if(var_05 == var_01) {
      return 1;
    }
  }

  return 0;
}

func_DF06(var_00, var_01) {
  var_02 = level.func_D77E;

  foreach(var_04 in var_01) {
    if(!isDefined(var_2.func_D799[var_04])) {
      var_2.func_D799[var_04] = [];
    }

    var_2.func_D799[var_04][var_00] = 1;
  }
}

func_DF04(var_00) {
  var_01 = level.func_D77E;

  if(!isDefined(var_1.func_D799[var_00])) {
    var_1.func_D799[var_00] = [];
  }

  var_1.func_D799[var_00]["all"] = 1;
}

func_9ED5(var_00, var_01) {
  var_02 = level.func_D77E;

  if(!isDefined(var_2.func_D799[var_01])) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_2.func_D799[var_01]["all"])) {
    return 1;
  }

  return scripts\mp\utility\game::istrue(var_2.func_D799[var_01][var_00]);
}

func_B937(var_00) {
  if(func_D779(var_00, "passive_decreased_cost")) {
    return 1.15;
  }

  return 1.0;
}

func_7FC1(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_duration")) {
    switch (var_00) {
      case "power_opticWave":
        return var_01 + 0.5;
      case "power_domeshield":
        return var_01 + 2;
      case "power_overCharge":
      case "power_splashGrenade":
      case "power_fearGrenade":
      case "power_blackholeGrenade":
      case "power_phaseShift":
        return var_01 + 1;
      default:
        return float(var_01) * float(1.15);
    }
  }

  return var_01;
}

func_7FBF(var_00, var_01) {
  if(func_D779(var_00, "passive_reduced_cooldown")) {
    switch (var_00) {
      default:
        return float(var_01) * float(0.9);
    }
  }

  return var_01;
}

func_7FC0(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_damage")) {
    switch (var_00) {
      case "power_fearGrenade":
        return var_01 * 1.5;
      default:
        return float(var_01) * float(1.15);
    }
  }

  return var_01;
}

func_7FC7(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_spread")) {
    switch (var_00) {
      default:
        if(_isvector(var_01)) {
          return var_01 * float(1.15);
        }
        else {
          return float(var_01) * float(1.15);
        }
    }
  }

  return var_01;
}

func_7FC4(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_radius")) {
    switch (var_00) {
      default:
        return int(float(var_01) * float(1.15));
    }
  }

  return var_01;
}

func_7FC5(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_range")) {
    switch (var_00) {
      default:
        return float(var_01) * float(1.15);
    }
  }

  return var_01;
}

func_7FBE(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_charges")) {
    switch (var_00) {
      default:
        return int(var_01) + int(1);
    }
  }

  return var_01;
}

func_7FC2(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_entities")) {
    switch (var_00) {
      case "power_shardBall":
        return var_01 + 5;
      default:
        return int(var_01) + int(1);
    }
  }

  return var_01;
}

func_7FC3(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_health")) {
    switch (var_00) {
      case "power_explodingDrone":
      case "power_blackholeGrenade":
        return var_01 + 20;
      default:
        return float(var_01) * float(1.15);
    }
  }

  return var_01;
}

func_7FC6(var_00, var_01) {
  if(func_D779(var_00, "passive_increased_speed")) {
    switch (var_00) {
      case "power_blackholeGrenade":
        return var_01 * 0.6;
      case "power_arcGrenade":
        return var_01 * 0.25;
      case "power_adrenaline":
        return var_01 + 0.1;
      default:
        return float(var_01) * float(0.85);
    }
  }

  return var_01;
}