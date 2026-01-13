/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2785.gsc
**************************************/

init() {
  level.var_D77E = spawnStruct();
  level.var_D77E.passivestringref = [];
  level.var_D77E.var_D799 = [];
  func_DF04("passive_decreased_cost");
  func_DF04("passive_reduced_cooldown");
  func_DF04("passive_increased_charges");
  func_DF06("power_blinkKnife", ["passive_health_regen_on_kill"]);
  func_DF06("power_clusterGrenade", ["passive_increased_speed", "passive_increased_spread", "passive_increased_entities"]);
}

getpassiveperk(var_0) {
  if(var_0 <= 0) {
    return [];
  }

  var_1 = level.var_D77E.passivestringref[var_0];

  if(!isDefined(var_1)) {
    var_2 = tablelookuprownum("mp\loot\iw7_power_loot_master.csv", 0, var_0);
    var_3 = [8, 9, 10];
    var_1 = [];

    foreach(var_5 in var_3) {
      var_6 = func_B030(var_2, var_5);

      if(!isDefined(var_6)) {
        break;
      }
      var_1[var_1.size] = var_6;
    }

    level.var_D77E.passivestringref[var_0] = var_1;
  }

  return var_1;
}

func_B030(var_0, var_1) {
  var_2 = tablelookupbyrow("mp\loot\iw7_power_loot_master.csv", var_0, var_1);
  return scripts\engine\utility::ter_op(isDefined(var_2) && var_2 != "", var_2, undefined);
}

func_D779(var_0, var_1) {
  if(var_0 == "power_teleport" && isDefined(self.var_115FC) && self.var_115FC) {
    return 0;
  }

  var_3 = self.powers[var_0];

  if(!isDefined(var_3) || !isDefined(var_3.passives)) {
    return 0;
  }

  foreach(var_5 in var_3.passives) {
    if(var_5 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_DF06(var_0, var_1) {
  var_2 = level.var_D77E;

  foreach(var_4 in var_1) {
    if(!isDefined(var_2.var_D799[var_4])) {
      var_2.var_D799[var_4] = [];
    }

    var_2.var_D799[var_4][var_0] = 1;
  }
}

func_DF04(var_0) {
  var_1 = level.var_D77E;

  if(!isDefined(var_1.var_D799[var_0])) {
    var_1.var_D799[var_0] = [];
  }

  var_1.var_D799[var_0]["all"] = 1;
}

func_9ED5(var_0, var_1) {
  var_2 = level.var_D77E;

  if(!isDefined(var_2.var_D799[var_1])) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_2.var_D799[var_1]["all"])) {
    return 1;
  }

  return scripts\mp\utility\game::istrue(var_2.var_D799[var_1][var_0]);
}

func_B937(var_0) {
  if(func_D779(var_0, "passive_decreased_cost")) {
    return 1.15;
  }

  return 1.0;
}

func_7FC1(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_duration")) {
    switch (var_0) {
      case "power_opticWave":
        return var_1 + 0.5;
      case "power_domeshield":
        return var_1 + 2;
      case "power_overCharge":
      case "power_splashGrenade":
      case "power_fearGrenade":
      case "power_blackholeGrenade":
      case "power_phaseShift":
        return var_1 + 1;
      default:
        return float(var_1) * float(1.15);
    }
  }

  return var_1;
}

func_7FBF(var_0, var_1) {
  if(func_D779(var_0, "passive_reduced_cooldown")) {
    switch (var_0) {
      default:
        return float(var_1) * float(0.9);
    }
  }

  return var_1;
}

func_7FC0(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_damage")) {
    switch (var_0) {
      case "power_fearGrenade":
        return var_1 * 1.5;
      default:
        return float(var_1) * float(1.15);
    }
  }

  return var_1;
}

func_7FC7(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_spread")) {
    switch (var_0) {
      default:
        if(_isvector(var_1)) {
          return var_1 * float(1.15);
        } else {
          return float(var_1) * float(1.15);
        }
    }
  }

  return var_1;
}

func_7FC4(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_radius")) {
    switch (var_0) {
      default:
        return int(float(var_1) * float(1.15));
    }
  }

  return var_1;
}

func_7FC5(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_range")) {
    switch (var_0) {
      default:
        return float(var_1) * float(1.15);
    }
  }

  return var_1;
}

func_7FBE(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_charges")) {
    switch (var_0) {
      default:
        return int(var_1) + int(1);
    }
  }

  return var_1;
}

func_7FC2(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_entities")) {
    switch (var_0) {
      case "power_shardBall":
        return var_1 + 5;
      default:
        return int(var_1) + int(1);
    }
  }

  return var_1;
}

func_7FC3(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_health")) {
    switch (var_0) {
      case "power_explodingDrone":
      case "power_blackholeGrenade":
        return var_1 + 20;
      default:
        return float(var_1) * float(1.15);
    }
  }

  return var_1;
}

func_7FC6(var_0, var_1) {
  if(func_D779(var_0, "passive_increased_speed")) {
    switch (var_0) {
      case "power_blackholeGrenade":
        return var_1 * 0.6;
      case "power_arcGrenade":
        return var_1 * 0.25;
      case "power_adrenaline":
        return var_1 + 0.1;
      default:
        return float(var_1) * float(0.85);
    }
  }

  return var_1;
}