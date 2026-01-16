/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3083.gsc
*********************************************/

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
  var_0 = "none";
  var_1 = 0.25;
  var_2 = 1;
  for(;;) {
    var_3 = 0;
    while(var_3 < var_2) {
      self waittill("bullethit", var_4);
      if(var_4 == level.player) {
        var_5 = getweaponbasename(var_4 getcurrentweapon());
        if(!lib_0A2F::func_DA40(var_5)) {
          var_3++;
          if(var_5 != var_0) {
            var_0 = var_5;
            var_2 = weaponclipsize(var_0) * var_1;
          }
        }
      }
    }

    scripts\sp\utility::func_56BE("c12_bullets", 5);
  }
}

func_E5EE() {
  level.player endon("death");
  var_0 = scripts\engine\utility::waittill_any_return("left_arm_dismembered", "right_arm_dismembered", "death");
  if(var_0 == "death") {
    return;
  }

  if(scripts\sp\utility::func_D123()) {
    return;
  }

  if(isDefined(self.var_30E9) && self.var_30E9) {
    return;
  }

  var_1 = strtok(var_0, "_")[0];
  while(!self.asm.var_11B08.var_30E6 && !scripts\asm\asm_bb::bb_isselfdestruct()) {
    while(isDefined(self.var_30E7) && self.var_30E7) {
      wait(0.05);
      if(!isalive(self)) {
        return;
      }
    }

    var_2 = spawn("script_model", self.origin);
    if(var_1 == "left") {
      var_2 setModel("robot_c12_prop_rail_l");
      var_2 linkto(self, "j_clavicle_inner_le", (0, 0, 0), (0, 0, 0));
    } else {
      var_2 setModel("robot_c12_prop_rail_r");
      var_2 linkto(self, "j_clavicle_inner_ri", (0, 0, 0), (0, 0, 0));
    }

    var_2 scripts\sp\utility::func_9196(3, 1, 1);
    var_2 thread scripts\sp\utility::func_918B("ar_callouts_c12_rodeo", 1, (0, 0, 0));
    thread kill_rodeo_hint_on_player_death(var_2);
    var_3 = gettime();
    var_0 = scripts\engine\utility::waittill_any_return("begin_rodeo", "self_destruct", "death", "rodeo_disabled");
    self notify("stop_kill_rodeo_hint_on_player_death");
    var_4 = gettime() - var_3 / 1000;
    if(var_4 < 0.15) {
      wait(0.15 - var_4);
    }

    var_2 thread scripts\sp\utility::func_918C();
    var_2 delete();
    if(var_0 == "rodeo_disabled") {
      continue;
    }

    if(var_0 == "self_destruct" || var_0 == "death") {
      return;
    }

    var_0 = scripts\engine\utility::waittill_any_return("end_rodeo", "death");
    if(var_0 == "death") {
      return;
    }
  }
}

kill_rodeo_hint_on_player_death(var_0) {
  self endon("stop_kill_rodeo_hint_on_player_death");
  level.player waittill("death");
  if(isDefined(var_0)) {
    var_0 thread scripts\sp\utility::func_918C();
    var_0 delete();
  }
}

func_B2E2() {
  self.var_C925 = [];
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.var_3508 = self;
  var_0.name = "script_c12_right_arm";
  var_0 linkto(self, "j_clavicle_ri", (15, 0, 0), (0, 0, 0));
  self.var_C925["right_arm"] = var_0;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.var_3508 = self;
  var_1.name = "script_c12_left_arm";
  var_1 linkto(self, "j_clavicle_le", (15, 0, 0), (0, 0, 0));
  self.var_C925["left_arm"] = var_1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.var_3508 = self;
  var_2.name = "script_c12_right_leg";
  var_2 linkto(self, "j_mainroot2", (0, 0, 25), (0, 0, 0));
  self.var_C925["right_leg"] = var_2;
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.var_3508 = self;
  var_3.name = "script_c12_left_leg";
  var_3 linkto(self, "j_mainroot2", (0, 0, -25), (0, 0, 0));
  self.var_C925["left_leg"] = var_3;
  self waittill("death");
  foreach(var_5 in self.var_C925) {
    var_5 delete();
  }

  self.var_C925 = undefined;
}

monitor_pain() {
  self endon("death");
  scripts\engine\utility::waitframe();
  foreach(var_2, var_1 in self.var_C925) {
    var_1.var_B43D = self func_850C(var_2);
    var_1.var_B440 = self func_850C(var_2, "upper");
    var_1.var_B43E = self func_850C(var_2, "lower");
    var_1.var_8CB0 = 100;
  }

  for(;;) {
    scripts\engine\utility::waitframe();
    foreach(var_2, var_1 in self.var_C925) {
      func_36F9(var_2, var_1);
    }
  }
}

func_36F9(var_0, var_1) {
  var_2 = self func_850C(var_0);
  var_3 = self func_850C(var_0, "upper");
  var_4 = self func_850C(var_0, "lower");
  if(strtok(var_0, "_")[1] == "leg") {
    var_5 = var_2 + var_3 + var_4;
    var_6 = var_1.var_B43D + var_1.var_B440 + var_1.var_B43E;
    var_1.var_8CB0 = int(var_5 / var_6 * 100);
    return;
  }

  if(var_5 > 0 && var_6 > 0) {
    var_7 = var_5 / var_3.var_B440;
    var_8 = var_6 / var_3.var_B43E;
    var_3.var_8CB0 = int(var_7 + var_8 / 2 * 50) + 50;
    return;
  }

  if(var_5 > 0) {
    var_7 = var_5 / var_3.var_B440;
    var_9 = var_4 / var_3.var_B43D;
    if(var_7 < var_9) {
      var_10 = var_7;
    } else {
      var_10 = var_10;
    }

    var_3.var_8CB0 = int(var_10 * 50);
    return;
  }

  if(var_6 > 0) {
    var_8 = var_6 / var_3.var_B43E;
    var_9 = var_4 / var_3.var_B43D;
    if(var_8 < var_9) {
      var_10 = var_8;
    } else {
      var_10 = var_10;
    }

    var_3.var_8CB0 = int(var_10 * 50);
    return;
  }

  var_3.var_8CB0 = int(var_4 / var_3.var_B43D * 50);
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
      self waittill("damage_any", var_0);
      if(!isDefined(var_0.var_4F) || var_0.var_4F != level.player) {
        continue;
      }

      if(!isDefined(var_0.weapon) || getweaponbasename(var_0.weapon) != "iw7_steeldragon") {
        continue;
      }

      var_1 = var_0.updategamerprofileall;
      if(var_1 == "torso") {
        var_2 = self func_850C("right_arm", "upper") + self func_850C("right_arm");
        var_3 = self func_850C("left_arm", "upper") + self func_850C("left_arm");
        if(var_3 > 0 && var_3 < var_2 || var_2 == 0) {
          var_1 = "left_arm";
        } else if(var_2 > 0) {
          var_1 = "right_arm";
        }
      }

      var_4 = self.var_C925[var_1];
      if(!isDefined(var_4)) {
        continue;
      }

      if(!isDefined(self.var_10F6B) || var_4 != self.var_10F6B) {
        setomnvar("ui_lockon_target_ent_0", var_4);
        setomnvar("ui_lockon_target_state_0", 3);
        setomnvar("ui_lockon_target_name_0", var_4.name);
        self.var_10F6B = var_4;
      }

      var_5 = gettime();
      self.var_10F6A = var_5 + 250;
      if(!isDefined(self.var_10F68)) {
        thread func_10F69();
      }

      setomnvar("ui_lockon_target_health_0", var_4.var_8CB0);
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
  var_0 = level.player getcurrentweapon();
  var_1 = getweaponbasename(var_0);
  if(!isDefined(var_1) || var_1 != "iw7_steeldragon") {
    return 0;
  }

  if(level.player getweaponammoclip(var_0) == 0) {
    return 0;
  }

  return 1;
}

func_11A0D() {
  self endon("death");
  var_0 = self func_850C("torso", "upper");
  var_1 = self func_850C("torso", "lower");
  for(;;) {
    scripts\engine\utility::waitframe();
    var_2 = self func_850C("torso", "upper");
    var_3 = self func_850C("torso", "lower");
    var_4 = var_0 - var_2 + var_1 - var_3;
    if(var_4 > 0) {
      self func_8550("torso", "upper", var_0);
      self func_8550("torso", "lower", var_1);
      var_5 = self func_850C("right_arm", "upper") + self func_850C("right_arm");
      var_6 = self func_850C("left_arm", "upper") + self func_850C("left_arm");
      if(var_5 == 0 && var_6 == 0) {
        return;
      }

      var_7 = "right_arm";
      if((var_6 < var_5 && var_6 != 0) || var_5 == 0) {
        var_7 = "left_arm";
      }

      self func_850B(var_4, var_7, "upper");
    }
  }
}

func_4D1A() {
  self endon("death");
  var_0 = self.health;
  self.var_7212 = 0;
  for(;;) {
    self waittill("damage_any");
    if(self.health < var_0) {
      self.health = var_0;
    }

    self.var_7212 = gettime() + 10000;
  }
}

func_C12B(var_0) {
  self endon("death");
  for(;;) {
    var_1 = spawnStruct();
    switch (var_0) {
      case "damage":
        self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
        switch (var_9) {
          case "j_weaponshoulder_ri":
            var_9 = "right_arm";
            break;

          case "j_weaponshoulder_le":
            var_9 = "left_arm";
            break;

          case "j_hipinner_ri":
          case "j_ankle_ri":
            var_9 = "right_leg";
            break;

          case "j_hipinner_le":
          case "j_ankle_le":
            var_9 = "left_leg";
            break;
        }

        var_1.var_4F = var_3;
        var_1.updategamerprofileall = var_9;
        var_1.weapon = var_11;
        break;

      case "damage_subpart":
        self waittill("damage_subpart", var_12);
        var_13 = var_12[0];
        if(!scripts\sp\utility::func_93A6()) {
          scripts\sp\damagefeedback::func_4D4C(var_13.var_3C, var_13.var_4F, var_13.var_F2, var_13.point, undefined, var_13.stopfxontag, undefined, var_13.updategamerprofileall, undefined, var_13.weapon);
        }

        var_1.var_4F = var_13.var_4F;
        var_1.updategamerprofileall = var_13.updategamerprofileall;
        var_1.weapon = var_13.weapon;
        break;

      default:
        break;
    }

    self notify("damage_any", var_1);
  }
}