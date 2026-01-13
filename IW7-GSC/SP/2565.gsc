/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2565.gsc
************************/

func_360D(var_0, var_1, var_2, var_3) {
  if(isarray(var_1)) {
    self.var_EF6D[var_0] = var_1;
  } else {
    self.var_EF6D[var_0] = [var_1];
  }

  self.var_EF70[var_0] = var_2;
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self.var_EF6E[var_0] = var_3;
}

func_360C(var_0) {
  self.var_E5C4 = var_0;
}

func_352D(var_0) {
  if(!isDefined(self.var_EF6D)) {
    return;
  }

  self.var_EF6D[var_0] = undefined;
  self.var_EF70[var_0] = undefined;
  self.var_EF6E[var_0] = undefined;
  if(self.var_EF6D.size == 0) {
    self.var_EF6D = undefined;
    self.var_EF70 = undefined;
    self.var_EF6E = undefined;
  }
}

func_3552(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.var_27F7 = var_0;
}

func_3555(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self.var_13C83[var_0] = var_1;
}

func_3551(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.var_290A = var_0;
  if(!var_0) {
    self _meth_8484();
  }
}

func_3540(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.var_30E9 = var_0;
}

func_353F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.var_30E7 = var_0;
  if(var_0) {
    self notify("rodeo_disabled");
    return;
  }

  self notify("rodeo_enabled");
}

func_3553(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self.var_3131 = 1;
    return;
  }

  self.var_3131 = undefined;
}

func_3609(var_0) {
  self.var_1A48 = var_0;
}

func_35AC() {
  return scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg");
}

func_3554(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.var_32D5 = var_0;
}

func_3634(var_0) {
  thread func_1375A(var_0);
}

func_1375A(var_0) {
  level.player endon("death");
  self waittill("death");
  wait(0.1);
  level.player _meth_84C7(var_0, 1);
  if(level.player _meth_84C6("c12AchievementRodeoLeft") && level.player _meth_84C6("c12AchievementRodeoRight") && level.player _meth_84C6("c12AchievementSelfdestruct")) {
    scripts\sp\utility::settimer("KILL_C12S");
  }
}

func_35A8(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  scripts\engine\utility::array_thread(var_0, ::func_3638, var_1, var_2, var_3, var_4);
}

func_3638(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 25));
  var_4.var_E297 = 0;
  var_4 endon("death");
  var_4 thread func_3639(var_0);
  thread func_363A(var_4, var_3);
  if(isDefined(var_2)) {
    level waittill(var_2);
  }

  if(level.var_7683 == 3) {
    wait(10);
  }

  for(;;) {
    while(distance2dsquared(var_4.origin, level.player.origin) < squared(128)) {
      wait(0.05);
    }

    if(func_35DB(var_3) && !var_4.var_E297) {
      var_4 lib_0E46::func_48C4("tag_origin", undefined, undefined, undefined, 5000, 0, 1, 0, 0, var_1, 0, 0);
      while(distance2dsquared(var_4.origin, level.player.origin) >= squared(128)) {
        if(func_35DB(var_3)) {
          wait(0.05);
          continue;
        }

        break;
      }

      var_4 lib_0E46::func_DFE3();
    }

    wait(0.05);
  }
}

func_3639(var_0) {
  while(!isDefined(var_0.var_3508)) {
    wait(0.05);
  }

  var_0.var_3508 scripts\engine\utility::waittill_any_3("death", "begin_rodeo", "self_destruct");
  self delete();
}

func_35DB(var_0) {
  var_1 = level.player getweaponslistprimaries();
  var_2 = [];
  foreach(var_4 in var_1) {
    switch (getweaponbasename(var_4)) {
      case "iw7_atomizer":
        return 0;

      case "iw7_penetrationrail":
      case "iw7_chargeshot":
      case "iw7_lockon":
      case "iw7_steeldragon":
        var_2[var_2.size] = var_4;
        break;
    }
  }

  if(var_2.size == 0) {
    return 1;
  }

  foreach(var_4 in var_2) {
    var_7 = 0;
    if(var_0) {
      var_7 = int(weaponclipsize(var_4) / 2);
    }

    if(level.player getweaponammostock(var_4) + level.player getweaponammoclip(var_4) > var_7) {
      return 0;
    }
  }

  return 1;
}

func_363A(var_0, var_1) {
  level.player endon("death");
  var_0 endon("death");
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_3 = self;
  var_4 = getsubstr(var_3.classname, 7);
  if(var_1) {
    var_5 = weaponmaxammo(var_4);
    var_6 = 0;
  } else {
    var_5 = 1;
    var_6 = 1;
  }

  for(;;) {
    var_3 gettimepassedpercentage(var_6, var_5);
    var_3 waittill("trigger");
    if(isDefined(var_3)) {
      var_3 delete();
    }

    if(level.player getrunningforwardpainanim(var_4) == var_6 + var_5) {
      level.player switchtoweapon(var_4);
      if(var_1) {
        level.player setweaponammoclip(var_4, weaponclipsize(var_4));
        level.player setweaponammostock(var_4, var_5);
      }
    }

    var_0.var_E297 = 1;
    while(distance2dsquared(var_2.origin, level.player.origin) < squared(512)) {
      wait(1);
    }

    wait(10);
    if(level.var_7683 == 3) {
      wait(10);
    }

    var_0.var_E297 = 0;
    var_3 = spawn("weapon_" + var_4, var_2.origin, 1);
    var_3.angles = var_2.angles;
  }
}