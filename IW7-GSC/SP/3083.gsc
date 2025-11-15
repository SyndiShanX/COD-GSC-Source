/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3083.gsc
************************/

func_98DD() {
  if(self.team == level.player.team) {
    return;
  }

  thread func_324E();
  thread func_E5EE();
  thread func_B2E2();
  thread monitor_pain();
  thread func_10F6C();
  thread func_11A0D();
  thread func_4D1A();
  thread func_C12B("damage");
  thread func_C12B("damage_subpart");
}

func_324E() {
  self endon("death");
  self endon("can_damage_rocket");
  var_00 = "none";
  var_01 = 0.25;
  var_02 = 1;
  for(;;) {
    var_03 = 0;
    while(var_03 < var_02) {
      self waittill("bullethit", var_04);
      if(var_04 == level.player) {
        var_05 = getweaponbasename(var_04 getcurrentweapon());
        if(!lib_0A2F::func_DA40(var_05)) {
          var_03++;
          if(var_05 != var_00) {
            var_00 = var_05;
            var_02 = weaponclipsize(var_00) * var_01;
          }
        }
      }
    }

    scripts\sp\utility::func_56BE("c12_bullets", 5);
  }
}

func_E5EE() {
  level.player endon("death");
  var_00 = scripts\engine\utility::waittill_any_return("left_arm_dismembered", "right_arm_dismembered", "death");
  if(var_00 == "death") {
    return;
  }

  if(scripts\sp\utility::func_D123()) {
    return;
  }

  if(isDefined(self.var_30E9) && self.var_30E9) {
    return;
  }

  var_01 = strtok(var_00, "_")[0];
  while(!self.asm.var_11B08.var_30E6 && !scripts\asm\asm_bb::bb_isselfdestruct()) {
    while(isDefined(self.var_30E7) && self.var_30E7) {
      wait(0.05);
      if(!isalive(self)) {
        return;
      }
    }

    var_02 = spawn("script_model", self.origin);
    if(var_01 == "left") {
      var_02 setModel("robot_c12_prop_rail_l");
      var_02 linkto(self, "j_clavicle_inner_le", (0, 0, 0), (0, 0, 0));
    } else {
      var_02 setModel("robot_c12_prop_rail_r");
      var_02 linkto(self, "j_clavicle_inner_ri", (0, 0, 0), (0, 0, 0));
    }

    var_02 scripts\sp\utility::func_9196(3, 1, 1);
    var_02 thread scripts\sp\utility::func_918B("ar_callouts_c12_rodeo", 1, (0, 0, 0));
    thread kill_rodeo_hint_on_player_death(var_02);
    var_03 = gettime();
    var_00 = scripts\engine\utility::waittill_any_return("begin_rodeo", "self_destruct", "death", "rodeo_disabled");
    self notify("stop_kill_rodeo_hint_on_player_death");
    var_04 = gettime() - var_03 / 1000;
    if(var_04 < 0.15) {
      wait(0.15 - var_04);
    }

    var_02 thread scripts\sp\utility::func_918C();
    var_02 delete();
    if(var_00 == "rodeo_disabled") {
      continue;
    }

    if(var_00 == "self_destruct" || var_00 == "death") {
      return;
    }

    var_00 = scripts\engine\utility::waittill_any_return("end_rodeo", "death");
    if(var_00 == "death") {
      return;
    }
  }
}

kill_rodeo_hint_on_player_death(param_00) {
  self endon("stop_kill_rodeo_hint_on_player_death");
  level.player waittill("death");
  if(isDefined(param_00)) {
    param_00 thread scripts\sp\utility::func_918C();
    param_00 delete();
  }
}

func_B2E2() {
  self.var_C925 = [];
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00.var_3508 = self;
  var_00.name = "script_c12_right_arm";
  var_00 linkto(self, "j_clavicle_ri", (15, 0, 0), (0, 0, 0));
  self.var_C925["right_arm"] = var_00;
  var_01 = scripts\engine\utility::spawn_tag_origin();
  var_01.var_3508 = self;
  var_01.name = "script_c12_left_arm";
  var_01 linkto(self, "j_clavicle_le", (15, 0, 0), (0, 0, 0));
  self.var_C925["left_arm"] = var_01;
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_02.var_3508 = self;
  var_02.name = "script_c12_right_leg";
  var_02 linkto(self, "j_mainroot2", (0, 0, 25), (0, 0, 0));
  self.var_C925["right_leg"] = var_02;
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_03.var_3508 = self;
  var_03.name = "script_c12_left_leg";
  var_03 linkto(self, "j_mainroot2", (0, 0, -25), (0, 0, 0));
  self.var_C925["left_leg"] = var_03;
  self waittill("death");
  foreach(var_05 in self.var_C925) {
    var_05 delete();
  }

  self.var_C925 = undefined;
}

monitor_pain() {
  self endon("death");
  scripts\engine\utility::waitframe();
  foreach(var_02, var_01 in self.var_C925) {
    var_01.var_B43D = self _meth_850C(var_02);
    var_01.var_B440 = self _meth_850C(var_02, "upper");
    var_01.var_B43E = self _meth_850C(var_02, "lower");
    var_01.var_8CB0 = 100;
  }

  for(;;) {
    scripts\engine\utility::waitframe();
    foreach(var_02, var_01 in self.var_C925) {
      func_36F9(var_02, var_01);
    }
  }
}

func_36F9(param_00, param_01) {
  var_02 = self _meth_850C(param_00);
  var_03 = self _meth_850C(param_00, "upper");
  var_04 = self _meth_850C(param_00, "lower");
  if(strtok(param_00, "_")[1] == "leg") {
    var_05 = var_02 + var_03 + var_04;
    var_06 = param_01.var_B43D + param_01.var_B440 + param_01.var_B43E;
    param_01.var_8CB0 = int(var_05 / var_06 * 100);
    return;
  }

  if(var_05 > 0 && var_06 > 0) {
    var_07 = var_05 / var_03.var_B440;
    var_08 = var_06 / var_03.var_B43E;
    var_03.var_8CB0 = int(var_07 + var_08 / 2 * 50) + 50;
    return;
  }

  if(var_05 > 0) {
    var_07 = var_05 / var_03.var_B440;
    var_09 = var_04 / var_03.var_B43D;
    if(var_07 < var_09) {
      var_0A = var_07;
    } else {
      var_0A = var_0A;
    }

    var_03.var_8CB0 = int(var_0A * 50);
    return;
  }

  if(var_06 > 0) {
    var_08 = var_06 / var_03.var_B43E;
    var_09 = var_04 / var_03.var_B43D;
    if(var_08 < var_09) {
      var_0A = var_08;
    } else {
      var_0A = var_0A;
    }

    var_03.var_8CB0 = int(var_0A * 50);
    return;
  }

  var_03.var_8CB0 = int(var_04 / var_03.var_B43D * 50);
}

func_10F6C() {
  self endon("death");
  self.var_10F6A = 0;
  for(;;) {
    while(!func_10F6E()) {
      wait(0.05);
    }

    setomnvar("ui_lockon_ads", 1);
    while(func_10F6E()) {
      self waittill("damage_any", var_00);
      if(!isDefined(var_00.var_4F) || var_00.var_4F != level.player) {
        continue;
      }

      if(!isDefined(var_00.var_394) || getweaponbasename(var_00.var_394) != "iw7_steeldragon") {
        continue;
      }

      var_01 = var_00.updategamerprofileall;
      if(var_01 == "torso") {
        var_02 = self _meth_850C("right_arm", "upper") + self _meth_850C("right_arm");
        var_03 = self _meth_850C("left_arm", "upper") + self _meth_850C("left_arm");
        if(var_03 > 0 && var_03 < var_02 || var_02 == 0) {
          var_01 = "left_arm";
        } else if(var_02 > 0) {
          var_01 = "right_arm";
        }
      }

      var_04 = self.var_C925[var_01];
      if(!isDefined(var_04)) {
        continue;
      }

      if(!isDefined(self.var_10F6B) || var_04 != self.var_10F6B) {
        setomnvar("ui_lockon_target_ent_0", var_04);
        setomnvar("ui_lockon_target_state_0", 3);
        setomnvar("ui_lockon_target_name_0", var_04.name);
        self.var_10F6B = var_04;
      }

      var_05 = gettime();
      self.var_10F6A = var_05 + 250;
      if(!isDefined(self.var_10F68)) {
        thread func_10F69();
      }

      setomnvar("ui_lockon_target_health_0", var_04.var_8CB0);
    }

    setomnvar("ui_lockon_ads", 0);
  }
}

func_10F69() {
  self.var_10F68 = 1;
  while(func_10100()) {
    wait(0.05);
  }

  self.var_10F68 = undefined;
  self.var_10F6B = undefined;
  setomnvar("ui_lockon_target_ent_0", undefined);
  setomnvar("ui_lockon_target_state_0", 0);
  setomnvar("ui_lockon_target_name_0", "none");
  setomnvar("ui_lockon_target_health_0", 0);
}

func_10100() {
  if(!isalive(self)) {
    return 0;
  }

  if(!isalive(level.player)) {
    return 0;
  }

  if(!isDefined(self.var_10F6B)) {
    return 0;
  }

  return gettime() < self.var_10F6A;
}

func_10F6E() {
  var_00 = level.player getcurrentweapon();
  var_01 = getweaponbasename(var_00);
  if(!isDefined(var_01) || var_01 != "iw7_steeldragon") {
    return 0;
  }

  if(level.player getweaponammoclip(var_00) == 0) {
    return 0;
  }

  return 1;
}

func_11A0D() {
  self endon("death");
  var_00 = self _meth_850C("torso", "upper");
  var_01 = self _meth_850C("torso", "lower");
  for(;;) {
    scripts\engine\utility::waitframe();
    var_02 = self _meth_850C("torso", "upper");
    var_03 = self _meth_850C("torso", "lower");
    var_04 = var_00 - var_02 + var_01 - var_03;
    if(var_04 > 0) {
      self _meth_8550("torso", "upper", var_00);
      self _meth_8550("torso", "lower", var_01);
      var_05 = self _meth_850C("right_arm", "upper") + self _meth_850C("right_arm");
      var_06 = self _meth_850C("left_arm", "upper") + self _meth_850C("left_arm");
      if(var_05 == 0 && var_06 == 0) {
        return;
      }

      var_07 = "right_arm";
      if((var_06 < var_05 && var_06 != 0) || var_05 == 0) {
        var_07 = "left_arm";
      }

      self _meth_850B(var_04, var_07, "upper");
    }
  }
}

func_4D1A() {
  self endon("death");
  var_00 = self.health;
  self.var_7212 = 0;
  for(;;) {
    self waittill("damage_any");
    if(self.health < var_00) {
      self.health = var_00;
    }

    self.var_7212 = gettime() + 10000;
  }
}

func_C12B(param_00) {
  self endon("death");
  for(;;) {
    var_01 = spawnStruct();
    switch (param_00) {
      case "damage":
        self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
        switch (var_09) {
          case "j_weaponshoulder_ri":
            var_09 = "right_arm";
            break;

          case "j_weaponshoulder_le":
            var_09 = "left_arm";
            break;

          case "j_hipinner_ri":
          case "j_ankle_ri":
            var_09 = "right_leg";
            break;

          case "j_hipinner_le":
          case "j_ankle_le":
            var_09 = "left_leg";
            break;
        }

        var_01.var_4F = var_03;
        var_01.updategamerprofileall = var_09;
        var_01.var_394 = var_0B;
        break;

      case "damage_subpart":
        self waittill("damage_subpart", var_0C);
        var_0D = var_0C[0];
        if(!scripts\sp\utility::func_93A6()) {
          scripts\sp\damagefeedback::func_4D4C(var_0D.var_3C, var_0D.var_4F, var_0D.var_F2, var_0D.point, undefined, var_0D.stopfxontag, undefined, var_0D.updategamerprofileall, undefined, var_0D.var_394);
        }

        var_01.var_4F = var_0D.var_4F;
        var_01.updategamerprofileall = var_0D.updategamerprofileall;
        var_01.var_394 = var_0D.var_394;
        break;

      default:
        break;
    }

    self notify("damage_any", var_01);
  }
}