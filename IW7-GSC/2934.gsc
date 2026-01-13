/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2934.gsc
***************************************/

func_1945(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(level.var_D127) && var_0 == level.var_D127) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    thread func_B840();
    func_A278();
    wait 0.5;
  }

  self.var_B8A4 = [];
  var_4 = 0;

  while(var_2 > 0) {
    if(!isDefined(self) || !isDefined(var_0)) {
      break;
    }
    if(var_4 == var_1.size) {
      var_4 = 0;
    }

    var_5 = var_1[var_4];
    var_4++;
    var_6 = func_1992(var_5, var_0);
    var_6.team = self.script_team;

    if(var_3) {
      var_6.var_438D = self;

      if(isDefined(self.var_594B)) {
        var_7 = 0;
      } else {
        var_7 = 1;
      }

      var_6 func_A279(var_7);
      self.var_B8A4 = scripts\engine\utility::array_add(self.var_B8A4, var_6);
    }

    var_2--;
    wait 0.3;
  }
}

func_B840() {
  level notify("missile_volley_global_cooldown");
  level endon("missile_volley_global_cooldown");
  level.player endon("death");
  level.player scripts\sp\utility::func_65DD("jackal_enemy_homing_missile_allowed");
  level.player scripts\sp\utility::func_65DD("jackal_enemy_homing_missile_allowed_hyperaggressive");

  while(isDefined(self.var_93D2) && self.var_93D2.size > 0) {
    wait 0.1;
  }

  childthread func_B841();
  var_0 = 12.0;
  var_1 = 24.0;
  wait(randomfloatrange(var_0, var_1));
  level.player scripts\sp\utility::func_65E1("jackal_enemy_homing_missile_allowed");
}

func_B841() {
  var_0 = 3.5;
  var_1 = 5.5;
  wait(randomfloatrange(var_0, var_1));
  level.player scripts\sp\utility::func_65E1("jackal_enemy_homing_missile_allowed_hyperaggressive");
}

func_7B95() {
  if(!isDefined(level.var_D127) || !isDefined(level.var_D127.var_93D2)) {
    return 0;
  }

  return level.var_D127.var_93D2.size;
}

func_A279(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    thread func_B807();
  }

  thread func_B805();
  self _meth_8557("OFFSCREEN_HAZARD_INDICATOR");
  thread func_B806();
}

func_B806() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = length(self.origin - level.var_D127.origin);
    var_1 = scripts\sp\math::func_C097(200, 10000, var_0);
    var_2 = scripts\sp\math::func_6A8E(0.6, 1.3, var_1);
    self _meth_8277(var_2, 0.05);
    wait 0.05;
  }
}

func_686D(var_0, var_1) {
  self.enemy endon("death");
  var_2 = 0;
  self.enemy.var_EF5E = (0, 0, 0);
  self.enemy.var_EF63 = 1700;

  while(var_1 > 0) {
    if(var_2 == var_0.size) {
      var_2 = 0;
    }

    var_3 = var_0[var_2];
    var_2++;

    if(isDefined(self)) {
      var_4 = self.enemy thread func_1992(var_3, level.var_D127, undefined, undefined, 400, 0);
      var_4.var_438D = self.enemy;
    }

    var_1--;
    wait 0.3;
  }

  self.enemy.var_EF5E = undefined;
  self.var_6DA7 = 0;
}

func_B804() {
  self endon("death");
  self playSound("enemy_lockon_missile_launch");
  self _meth_8277(0.5, 0.05);
  self ghostattack(1.3, 0.05);
  wait 0.05;
  var_0 = 2;
  self _meth_8277(1.2, var_0);
  self ghostattack(2, var_0);
}

func_B805() {
  self endon("death");
  wait 0.5;
  self setModel("veh_mil_air_un_jackal_missile_coll");
  self show();
  self.team = "axis";
  self.health = 99999999;
  self.script_team = "axis";
  self setCanDamage(1);
  self _meth_84BE("missile");
  self _meth_8339(0);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && var_1 == level.var_D127) {
      break;
    }
  }

  func_12869(self.origin);
  self playSound("jackal_missile_explosion_plr", "sounddone");
  playFX(scripts\engine\utility::getfx("jet_missile_imp_airburst"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  self waittill("sounddone");
  self delete();
}

func_B807() {
  var_0 = 3000;
  var_1 = 12000;
  var_2 = 5000;
  var_3 = 25000;
  var_4 = 13 * level.var_A48E.var_A3FB;
  var_5 = 25 * level.var_A48E.var_A3FB;
  var_6 = 2000;
  var_7 = 500 * level.var_A48E.var_A3FB;
  var_8 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.var_6E8B)) {
      var_8 = 1;
    }

    if(!var_8) {
      var_9 = level.var_D127.spaceship_vel;
      var_10 = length(var_9);
      var_10 = scripts\engine\utility::mph_to_ips(var_10);
      var_10 = var_10 * 0.05;
      var_11 = var_10 + var_7;
      var_12 = vectordot(anglesToForward(self.angles), vectornormalize(var_9));
      var_13 = var_11 * var_12;

      if(var_13 < var_7) {
        var_13 = var_7;
      }

      var_14 = distance(self.origin, level.var_D127.origin);
      var_15 = scripts\sp\math::func_C097(var_0, var_1, var_14);
      var_16 = scripts\sp\math::func_6A8E(var_13, var_6, var_15);
      var_17 = scripts\sp\math::func_C097(var_2, var_3, var_14);
      var_18 = scripts\sp\math::func_6A8E(var_4, var_5, var_17);
    } else {
      var_16 = 1400;
      var_18 = 20;
    }

    self.var_B464 = var_16;
    self.var_1545 = var_18;
    wait 0.05;
  }
}

func_1993(var_0, var_1) {
  if(isDefined(self.var_EF5B)) {
    return;
  }
  self.var_EF5B = 1;

  if(!isDefined(var_1)) {
    var_1 = "TAG_FLASH_right";
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    thread func_1992(var_1, var_3);
    wait(randomfloatrange(1, 1.3));
  }

  wait 0.2;
  self.var_EF5B = undefined;
}

func_1992(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_2) && !isDefined(self.var_EF5D)) {
    var_2 = 0;
  } else if(isDefined(self.var_EF5D)) {
    var_2 = self.var_EF5D;
  }

  if(isDefined(self.var_EF5C)) {
    var_9 = self.var_EF5C;
  } else {
    var_9 = undefined;
  }

  if(isDefined(var_6)) {
    var_6 = var_6;
  } else if(isDefined(self.var_EF61)) {
    var_6 = self.var_EF61;
  }

  if(isDefined(var_4)) {
    var_4 = var_4;
  } else if(isDefined(self.var_EF62)) {
    var_4 = self.var_EF62;
  } else if(_isaircraft(self)) {
    var_4 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_4 = var_4[0];
  } else
    var_4 = 0;

  if(isDefined(self.var_EF5E)) {
    var_10 = self.var_EF5E;
  } else {
    var_10 = (0, 0, 1500);
  }

  var_11 = scripts\engine\utility::spawn_tag_origin(self gettagorigin(var_0), self gettagangles(var_0));

  if(var_2) {
    var_12 = vectornormalize(var_1.origin - self.origin);
    var_11.angles = vectortoangles(var_12);
  }

  if(isDefined(level.var_D127) && var_1 == level.var_D127) {
    if(isDefined(self.var_EF60)) {
      var_11.var_AA99 = self.var_EF60;
    } else {
      var_11.var_AA99 = "jackal_missile_launch_space_for_plr";
    }

    var_11.loop_sound = "jackal_missile_loop_for_ply";
    var_11.var_69E9 = "jackal_missile_explosion_plr";
  } else if(isDefined(self.var_EF5F))
    var_11.var_AA99 = self.var_EF5F;
  else {
    var_11.var_AA99 = "jackal_missile_launch_space_npc";
  }

  if(!isDefined(var_1)) {
    var_13 = 1;
    var_14 = scripts\engine\utility::spawn_tag_origin();
    var_14.var_5F27 = 1;
    var_14.origin = var_11.origin + anglesToForward(self gettagangles(var_0)) * 30000;
  } else if(isDefined(var_5) && !var_5) {
    var_13 = 1;
    var_14 = scripts\engine\utility::spawn_tag_origin();
    var_14.var_5F27 = 1;
    var_15 = vectornormalize(var_1.origin - var_11.origin);
    var_14.origin = var_11.origin + var_15 * 30000;
    var_1 = var_14;
  } else
    var_13 = 0;

  var_11.var_50D5 = var_3;
  var_11.var_01CF = 6;

  if(isDefined(self.var_EF63)) {
    var_16 = self.var_EF63;
  } else if(isDefined(self.var_C841) && isDefined(self.var_C841.var_B825)) {
    var_16 = self.var_C841.var_B825;
  } else {
    var_16 = 1300;
  }

  if(isDefined(self.var_EF5A)) {
    var_11.var_1545 = self.var_EF5A;
  } else if(isDefined(self.var_C841) && isDefined(self.var_C841.var_B821)) {
    var_11.var_1545 = self.var_C841.var_B821;
  }

  if(isDefined(var_8) && var_8 == 1) {
    var_11 thread func_A332(var_1, var_13, self, var_6, var_16, var_10, undefined, var_7, var_4, undefined, var_9, var_8);
  } else {
    var_11 thread func_A332(var_1, var_13, self, var_6, var_16, var_10, undefined, var_7, var_4, undefined, var_9);
  }

  return var_11;
}

func_A278() {
  if(!isDefined(self)) {
    return;
  }
  if(_isaircraft(self)) {
    var_0 = "j_mainroot_ship";
  } else {
    var_0 = "tag_origin";
  }

  self playSound("jackal_enemy_locking_warning");
  playFXOnTag(scripts\engine\utility::getfx("jackal_enemy_locking"), self, var_0);
}

func_6D2A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = 1;
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3.var_5F27 = 1;
    var_3.origin = self gettagorigin(var_0) + anglesToForward(self gettagangles(var_0)) * 30000;
  } else
    var_2 = 0;

  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin(var_0), self gettagangles(var_0));
  var_4 thread func_A332(var_1, var_2, self);
}

func_A332(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 notify("homing_missile_incoming", self, var_2);
  self.var_6E9B = 0;
  func_B80F();
  thread func_B7F5();
  var_15 = 0;

  if(isDefined(level.var_D127) && isDefined(var_2) && var_2 == level.var_D127) {
    var_15 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = "missile_flare_generic";
  }

  if(isstring(var_3)) {
    playFXOnTag(scripts\engine\utility::getfx(var_3), self, "tag_origin");
  } else {
    playFXOnTag(var_3, self, "tag_origin");
  }

  if(isDefined(self.var_AA99)) {
    if(self.var_AA99 != "null") {
      self playSound(self.var_AA99);
    }
  } else
    self playSound("jackal_missile_launch_space_npc");

  if(!isDefined(self.loop_sound)) {
    var_16 = "jackal_missile_lp_space";
  } else {
    var_16 = self.loop_sound;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!var_9) {
    self playLoopSound(var_16);
  }

  while(isDefined(self.var_50D5)) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_10)) {
    var_10 = 1.0;
  }

  if(isDefined(var_0.var_5F27)) {
    self.var_5F27 = var_0;
  }

  var_17 = var_10 * 0.25;
  var_18 = 0;
  var_19 = 0.3;
  var_20 = 8;

  if(isDefined(self.var_01CF)) {
    var_20 = self.var_01CF;
  } else if(isDefined(level.var_B81B)) {
    var_20 = level.var_B81B;
  }

  var_21 = 0;
  var_22 = 0;

  if(var_1) {
    var_23 = (0, 0, 0);
  } else {
    var_23 = (0, 0, 25);
  }

  if(isDefined(var_12)) {
    var_23 = var_12;
  }

  if(!isDefined(var_14)) {
    var_14 = 0;
  }

  var_24 = var_0.origin + var_23;
  var_25 = var_24;
  var_26 = (0, 0, 0);

  if(!isDefined(self.var_1545)) {
    self.var_1545 = 5;
  }

  var_27 = 0;

  if(isDefined(level.var_D127) && var_0 == level.var_D127) {
    var_27 = 1;
  }

  if(isDefined(var_8)) {
    var_28 = var_8;
  } else {
    var_28 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = 1000;
  }

  if(isDefined(var_2) && isDefined(var_2.var_B8AE) && isDefined(var_2.var_B8AE.var_B4C9)) {
    var_4 = var_2.var_B8AE.var_B4C9;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_11)) {
    var_11 = 0;
  }

  var_29 = 0;

  if(isDefined(self.var_BFEC)) {
    var_29 = self.var_BFEC;
  }

  if(isDefined(self.var_69E9)) {
    var_30 = self.var_69E9;
  } else {
    var_30 = undefined;
  }

  var_31 = self.origin;
  var_32 = self.angles;
  var_33 = 0;
  var_34 = undefined;

  if(isDefined(var_0.var_B83D)) {
    var_35 = var_0.var_B83D;
  } else {
    var_35 = 100;
  }

  var_36 = func_A26F();

  if(isDefined(var_13)) {
    var_36.var_12AFD.var_CA26 = var_13.var_12B00;
    var_36.var_12AFD.var_CA25 = var_13.var_12AFF;
    var_36.var_12AFD.var_B144 = var_13.var_12AFE;
    var_36.var_B0EF.var_CA26 = var_13.var_B0F3;
    var_36.var_B0EF.var_CA25 = var_13.var_B0F2;
    var_36.var_B0EF.var_B144 = var_13.var_B0F1;
  } else {
    var_36.var_12AFD.var_CA26 = 0.3;
    var_36.var_12AFD.var_CA25 = 0.4;
    var_36.var_12AFD.var_B144 = 400;
    var_36.var_B0EF.var_CA26 = 0.3;
    var_36.var_B0EF.var_CA25 = 0.4;
    var_36.var_B0EF.var_B144 = 400;
  }

  scripts\engine\utility::waitframe();
  var_37 = (0, 0, 0);
  var_38 = var_31 + var_37;
  var_39 = var_38;
  var_40 = 1;
  var_31 = var_38;

  if(isDefined(self)) {
    self.origin = var_38;
    self.var_C727 = var_0;
  }

  if(isDefined(self.weapon)) {
    var_41 = self.weapon;
  } else {
    var_41 = "spaceship_homing_missile";
  }

  if(isDefined(self)) {
    self.var_217A = 0;
    thread func_216F(var_2);
  }

  for(;;) {
    if(!isDefined(self)) {
      var_22 = 1;
      var_42 = undefined;
      break;
    }

    if(var_18 < var_10 + var_17) {
      if(var_18 < var_17) {
        var_43 = 0;
      } else {
        var_43 = scripts\sp\math::func_C097(0, var_10, var_18 - var_17);
      }
    } else
      var_43 = 1;

    if(var_1) {
      var_44 = 1;
    } else {
      var_44 = var_43;
    }

    if(isDefined(self.var_6E8B)) {
      var_0 = self.var_6E8B;
      self.var_6E9B = 1;
    } else if(isDefined(self.var_C727) && isDefined(self.var_C727.var_6E9C) && self.var_C727.var_6E9C.var_12B86.size > 0) {
      self.var_6E8B = scripts\engine\utility::random(self.var_C727.var_6E9C.var_12B86);
      self.var_C727.var_6E9C.var_12B86 = scripts\engine\utility::array_remove(self.var_C727.var_6E9C.var_12B86, self.var_6E8B);
      var_0 = self.var_6E8B;
      self.var_6E9B = 1;
    } else
      self.var_6E9B = 0;

    if(isDefined(self.var_114F9) && var_0 != self.var_114F9) {
      var_0 = self.var_114F9;
    }

    if(!isDefined(var_0)) {
      var_0 = scripts\engine\utility::spawn_tag_origin();
      var_0.origin = self.origin + anglesToForward(self.angles) * 10000;
      var_0.var_5F27 = 1;
      self.var_5F27 = var_0;
      var_1 = 1;
      var_23 = (0, 0, 0);
    }

    var_24 = var_0.origin + var_23;
    var_26 = var_24 - var_25;
    var_25 = var_24;
    var_45 = var_24 + var_26;
    var_46 = var_45 - var_31;
    var_47 = length(var_46);
    var_48 = vectornormalize(var_46);
    var_49 = anglesToForward(var_32);
    var_50 = vectordot(var_48, var_49);
    var_51 = 1 - scripts\sp\math::func_C097(0.3, 1, var_50);
    var_52 = scripts\sp\math::func_6A8E(1, var_19, var_44 * var_51);

    if(var_50 == 1) {
      var_53 = 0;
    } else {
      var_53 = 1 - scripts\sp\math::func_C097(var_50, 1, var_52);
    }

    var_54 = vectornormalize(var_48 * var_53 + var_49 * (1 - var_53));
    var_55 = scripts\sp\math::func_C097(0, 17000, var_47);
    var_55 = scripts\sp\math::func_C09B(var_55);

    if(var_55 < var_40) {
      var_40 = var_55;
    }

    var_56 = var_28 + var_14 * (1 - var_40);
    var_31 = var_31 + var_54 * var_56;
    var_32 = vectortoangles(var_54);
    var_37 = (0, 0, var_35 * var_43 * var_40);
    var_57 = var_5 * var_43 * var_40;
    var_36 func_B7E6();
    var_58 = var_36.var_B0EF.var_4D94["val"] * (var_43 * var_40);
    var_59 = var_36.var_12AFD.var_4D94["val"] * (var_43 * var_40);
    var_60 = anglestoright(var_32) * var_58 + anglestoup(var_32) * var_59;
    var_38 = var_31 + var_60 + var_37 + var_57;

    if(isDefined(var_2)) {
      if(isDefined(self.var_438D)) {
        var_61 = [self, self.var_438D, var_2];
      } else {
        var_61 = [self, var_2];
      }
    } else if(isDefined(self.var_438D))
      var_61 = [self, self.var_438D];
    else {
      var_61 = [self];
    }

    if(isDefined(level.var_B8AD)) {
      var_61 = scripts\engine\utility::array_combine(level.var_B8AD, var_61);
    }

    var_62 = 0;

    if(isDefined(self.var_6E9B) && var_47 < 1000) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
      var_38 = var_24;
    } else if(isDefined(level.var_D127) && var_0 == level.var_D127 && var_47 < 700) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
    } else if(var_56 > var_47) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
    }

    if(!isDefined(self.var_C180)) {
      var_42 = scripts\engine\trace::ray_trace(self.origin, var_38, var_61, undefined, 1);
    } else {
      var_42["fraction"] = 1;
      var_42["entity"] = var_0;
      var_42["position"] = var_24;
      var_42["surfacetype"] = "default";
      var_42["normal"] = -1 * anglesToForward(self.angles);
    }

    if(var_42["fraction"] < 1 && var_42["surfacetype"] != "surftype_none" && self.var_217A) {
      var_33 = 0;
      var_38 = var_42["position"];

      if(distance(var_42["position"], var_24) < 100) {
        var_21 = 1;
      }

      var_62 = 1;
    } else if(var_47 < var_6) {
      var_62 = 1;
      var_34 = self.angles;

      if(!isDefined(var_7)) {
        var_7 = ["jet_missile_imp_airburst", "capitalship_missile_airburst", 5];
      }
    }

    self.origin = var_38;
    self.angles = vectortoangles(vectornormalize(var_38 - var_39));
    var_39 = var_38;

    if(var_62 || isDefined(self.var_72CA)) {
      break;
    }
    if(var_18 > var_20) {
      var_22 = 1;
      break;
    }

    var_28 = var_28 + self.var_1545;

    if(isDefined(self.var_B464)) {
      if(var_28 > self.var_B464) {
        var_28 = self.var_B464;
      }
    } else if(var_28 > var_4)
      var_28 = var_4;

    var_18 = var_18 + 0.05;

    if(isDefined(self.var_6E8B) && self.var_6E8B.active) {
      self.var_6E8B waittill("pos_updated");
      continue;
    }

    scripts\engine\utility::waitframe();
  }

  if(!var_22) {
    if(isDefined(self.var_5F27) && var_21) {
      var_34 = self.angles;
    }

    if(self.var_6E9B) {
      var_34 = self.angles;
      var_11 = 1;
    }

    if(isDefined(var_0.var_1A89) && !isDefined(var_7) && var_33) {
      var_7 = ["jet_missile_imp_airburst", "capitalship_missile_airburst", 5];
      var_34 = self.angles;
    }
  }

  scripts\engine\utility::waitframe();

  if(var_22 || !isDefined(self)) {
    self notify("missile_dud");
  } else {
    self notify("missile_explode");

    if(isDefined(var_2)) {
      var_2 notify("missile_explode");

      if(scripts\sp\utility::func_D123() && var_2 == level.var_D127) {
        player_jackal_scripted_missile_self_damage(var_42["position"]);
      }
    } else
      var_2 = undefined;

    if(!var_11) {
      if(isDefined(var_2) && isDefined(var_2.var_B8AE)) {
        radiusdamage(var_42["position"], var_2.var_B8AE.var_DCCA, var_2.var_B8AE.var_B48B, var_2.var_B8AE.var_B758, var_2, "MOD_EXPLOSIVE", var_41);
      } else {
        radiusdamage(var_42["position"], 512, 2500, 1000, var_2, "MOD_EXPLOSIVE", var_41);
      }
    }

    if(var_21 && isDefined(var_0)) {
      var_42["entity"] = var_0;
    }

    thread func_4C7B(var_42, "missile", var_7, var_30, var_34);

    if(isDefined(var_42["entity"])) {
      var_42["entity"] notify("missile_hit");

      if(!var_11) {
        var_42["entity"] func_54DE(5000, var_42["position"], var_2, var_41);
      }

      if(var_27 && var_42["entity"] != level.var_D127) {
        func_12869(var_42["position"]);
      } else if(!var_29) {
        earthquake(0.2, 0.7, var_42["position"], 15000);
      }
    } else {
      if(var_27) {
        func_12869(var_42["position"]);
        return;
      }

      if(!var_29) {
        earthquake(0.2, 0.7, var_42["position"], 15000);
      }
    }
  }
}

player_jackal_scripted_missile_self_damage(var_0) {
  var_1 = distance(var_0, level.var_D127.origin);
  var_2 = 1900;

  if(var_1 > var_2) {
    return;
  }
  var_3 = scripts\sp\math::func_C097(0, var_2, var_1);
  var_4 = scripts\sp\math::func_6A8E(1000, 500, var_3);
  level.var_D127 getrandomarmkillstreak(var_4, var_0, level.var_D127, level.var_D127, "MOD_EXPLOSIVE", "spaceship_homing_missile");
}

func_216F(var_0) {
  self endon("death");
  var_1 = self;

  if(!isDefined(var_0)) {
    var_1.var_217A = 1;
    return;
  }

  if(isDefined(var_0.var_217B)) {
    wait(var_0.var_217B);
  }

  if(isDefined(var_1)) {
    var_1.var_217A = 1;
  }
}

func_12869(var_0) {
  if(isDefined(level.var_A056) && scripts\engine\utility::player_is_in_jackal()) {
    [[level.var_A056.var_B81C]](var_0);
  }
}

func_A26F(var_0) {
  var_1 = spawnStruct();
  var_1.var_B0EF = func_A26E();
  var_1.var_12AFD = func_A26E();

  if(isDefined(var_0)) {
    var_1.var_6BB1 = func_A26E();
  }

  return var_1;
}

func_A26E() {
  var_0 = spawnStruct();
  var_0.var_4D94 = [];
  var_0.var_4D94["old"] = 0;
  var_0.var_4D94["period"] = 0;
  var_0.var_4D94["target"] = 0;
  var_0.var_4D94["val"] = 0;
  var_0.var_4D94["time"] = 0;
  return var_0;
}

func_A26D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.var_12B00 = var_0;
  var_6.var_12AFF = var_1;
  var_6.var_12AFE = var_2;
  var_6.var_B0F3 = var_3;
  var_6.var_B0F2 = var_4;
  var_6.var_B0F1 = var_5;
  return var_6;
}

func_B80F() {
  if(!isDefined(level.var_1678)) {
    level.var_1678 = [];
  }

  level.var_1678[level.var_1678.size] = self;
  thread func_B810();
}

func_B810() {
  self waittill("entitydeleted");
  level.var_1678 = scripts\engine\utility::array_remove(level.var_1678, self);
}

func_FBC1() {
  self delete();
}

func_B7F5() {
  func_135EE();
  func_4096();
}

func_135EE() {
  level endon("end_shoot_missiles");
  scripts\engine\utility::waittill_any("missile_destroyed", "missile_dud", "missile_explode");
}

func_4096() {
  if(isDefined(self) && isDefined(self.var_5F27)) {
    self.var_5F27 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_B7E6() {
  self.var_B0EF func_B7E7();
  self.var_12AFD func_B7E7();

  if(isDefined(self.var_6BB1)) {
    self.var_6BB1 func_B7E7();
  }
}

func_B7E7() {
  if(self.var_4D94["time"] >= self.var_4D94["period"]) {
    self.var_4D94["period"] = randomfloatrange(self.var_CA26, self.var_CA25);
    self.var_4D94["old"] = self.var_4D94["target"];
    self.var_4D94["time"] = 0;
    self.var_4D94["target"] = randomfloatrange(self.var_B144 * -1, self.var_B144);
  }

  var_0 = scripts\sp\math::func_C097(0, self.var_4D94["period"], self.var_4D94["time"]);
  var_0 = scripts\sp\math::func_C09C(var_0);
  self.var_4D94["val"] = self.var_4D94["old"] * (1 - var_0) + self.var_4D94["target"] * var_0;
  self.var_4D94["time"] = self.var_4D94["time"] + 0.05;
}

func_54DE(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_8CBE)) {
    var_4 = self.var_8CBE;
  } else {
    var_4 = self;
  }

  if(!_isent(var_4)) {
    return;
  }
  var_4 getrandomarmkillstreak(var_0, var_1, var_2, var_2, "MOD_EXPLOSIVE", var_3);
}

func_4C7B(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_0["entity"]) && isDefined(var_0["entity"].var_112DC)) {
    var_5 = var_0["entity"].var_112DC;
  } else if(isDefined(var_0["entity"]) && isDefined(var_0["entity"].surfacetype)) {
    var_5 = var_0["entity"].surfacetype;
  } else {
    var_5 = var_0["surfacetype"];
  }

  if(!isDefined(var_2)) {
    var_6 = func_B7E8(var_5, var_1);
  } else {
    var_6 = var_2;
  }

  var_7 = spawn("script_model", var_0["position"]);
  var_7 setModel("tag_origin");

  if(isDefined(var_4)) {
    var_7.angles = var_4;
  } else {
    var_7.angles = vectortoangles(var_0["normal"]);
  }

  if(isDefined(var_0["entity"]) && _isent(var_0["entity"])) {
    var_7 linkto(var_0["entity"]);
  }

  playFXOnTag(scripts\engine\utility::getfx(var_6[0]), var_7, "tag_origin");

  if(!isDefined(var_3)) {
    if(isDefined(var_6[1])) {
      thread scripts\engine\utility::play_sound_in_space(var_6[1], var_7.origin);
    }
  } else
    thread scripts\engine\utility::play_sound_in_space(var_3, var_7.origin);

  thread scripts\sp\utility::func_5187(var_7);
  wait(var_6[2]);

  if(isDefined(var_7)) {
    var_7 delete();
  }
}

func_B7E8(var_0, var_1) {
  var_2 = "";
  var_3 = "";
  var_4 = 0;

  switch (var_0) {
    case "metal":
      switch (var_1) {
        case "missile":
          var_2 = "jet_missile_imp_generic";
          var_3 = "jackal_missile_impact";
          var_4 = 5;
          break;
      }

      break;
    case "rock":
      switch (var_1) {
        case "missile":
          var_2 = "jet_missile_imp_generic";
          var_3 = "jackal_missile_impact_rock";
          var_4 = 5;
          break;
      }

      break;
    case "water":
      switch (var_1) {
        case "missile":
          var_2 = "jet_missile_imp_water";
          var_3 = "jackal_missile_impact_water";
          var_4 = 5;
          break;
      }

      break;
    case "jackal":
      switch (var_1) {
        case "missile":
          var_2 = "jet_missile_imp_generic";
          var_3 = "jackal_missile_impact";
          var_4 = 5;
          break;
      }

      break;
    default:
      switch (var_1) {
        case "missile":
          var_2 = "jet_missile_imp_generic";
          var_3 = "jackal_missile_impact";
          var_4 = 5;

          if(isDefined(level.var_241D) && !level.var_241D) {
            var_2 = "jet_missile_imp_generic_zg";
          }

          break;
      }

      break;
  }

  return [var_2, var_3, var_4];
}

func_F42B(var_0) {
  if(level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(isDefined(self.var_9B4C) && self.var_9B4C) {
    var_0 = var_0 + "_ace";
  }

  if(isDefined(self.var_9CB8) && self.var_9CB8) {
    var_0 = var_0 + "_ace";
  }

  if(var_0 == "none") {
    self _meth_84A0(0);
  } else if(var_0 == "ally_jackal") {
    self _meth_84A0(1);
  } else if(var_0 == "enemy_jackal") {
    self _meth_84A0(2);
  } else if(var_0 == "enemy_dogfight") {
    self _meth_84A0(3);
  } else if(var_0 == "ally_capitalship") {
    self _meth_84A0(4);
  } else if(var_0 == "enemy_capitalship") {
    self _meth_84A0(5);
  } else if(var_0 == "enemy_jackal_ace") {
    self _meth_84A0(6);
  } else if(var_0 == "enemy_dogfight_ace") {
    self _meth_84A0(7);
  } else if(var_0 == "ally_jackal_unloc") {
    self _meth_84A0(8);
  }
}

func_F42C(var_0) {
  if(level.player scripts\sp\utility::func_65DF("disable_jackal_lockon") && level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(self.var_AEDF.priority) {
    if(isDefined(self.var_9B4C) && self.var_9B4C) {
      var_0 = "ace_objective";
    } else if(isDefined(self.var_9CB8) && self.var_9CB8) {
      var_0 = "ace_objective";
    } else {
      if(!isDefined(self.script_team)) {
        var_1 = "allies";
      } else {
        var_1 = self.script_team;
      }

      var_0 = var_1 + "_objective";
    }
  } else if(var_0 == "jackal" || var_0 == "last_engaged") {
    if(isDefined(self.var_9B4C) && self.var_9B4C) {
      var_0 = var_0 + "_ace";
    } else if(isDefined(self.var_9CB8) && self.var_9CB8) {
      var_0 = var_0 + "_ace";
    }
  }

  switch (var_0) {
    case "jackal":
      self _meth_8557("FLYING_TARGET");
      break;
    case "jackal_ace":
      self _meth_8557("ACE_TARGET");
      break;
    case "last_engaged":
      self _meth_8557("ENEMY_OBJECTIVE");
      break;
    case "last_engaged_ace":
      self _meth_8557("PRIORITY_FLYING_TARGET");
      break;
    case "ally_jackal":
      self _meth_8557("FLYING_ALLY_TARGET");
      break;
    case "axis_objective":
      self _meth_8557("ENEMY_OBJECTIVE");
      break;
    case "ally_objective":
      self _meth_8557("ALLY_OBJECTIVE");
      break;
    case "ace_objective":
      self _meth_8557("PRIORITY_FLYING_TARGET_ACE");
      break;
    case "dogfight_tracker":
      self _meth_8557("PRIORITY_FLYING_TARGET");
      break;
    case "large_target":
      self _meth_8557("LARGE_TARGET");
      break;
    case "medium_target":
      self _meth_8557("MEDIUM_TARGET");
      break;
    case "small_target":
      self _meth_8557("SMALL_TARGET");
      break;
    case "incoming_missile":
      self _meth_8557("OFFSCREEN_HAZARD_INDICATOR");
      break;
    case "immediate_threat":
      self _meth_8557("OFFSCREEN_ENEMY_INDICATOR");
      break;
    case "hoverheat":
      self _meth_8557("OFFSCREEN_ENEMY_INDICATOR");
      break;
    case "droppod_marker":
      self _meth_8557("LARGE_WEAKSPOT");
      break;
    case "none":
      self _meth_8558();
      break;
    default:
  }
}

func_39C3(var_0, var_1, var_2) {
  self notify("scan_for_turrets");
  self endon("death");
  self endon("scan_for_turrets");
  var_3 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self.script_team == "axis") {
    var_4 = "enemy";
  } else {
    var_4 = "friendly";
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  while(var_3 < var_0) {
    scripts\sp\utility::func_F40A(var_4, 0);

    if(!var_1) {
      self playSound("jackal_scan_ship");
    }

    wait 0.25;
    self hudoutlinedisable();
    var_3++;
    wait 0.15;
  }
}

func_D195(var_0, var_1) {
  if(var_0) {
    if(isDefined(level.var_D127.audio.var_138F5)) {
      return;
    }
    var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "jackal_collision_warning");
    level.var_D127.audio.var_138F5 = var_2;
    level.player thread scripts\engine\utility::play_loop_sound_on_entity(var_2);
  } else {
    if(!isDefined(level.var_D127.audio.var_138F5)) {
      return;
    }
    level.player notify("stop sound" + level.var_D127.audio.var_138F5);
    level.var_D127.audio.var_138F5 = undefined;
  }
}

func_9C19(var_0) {
  var_1 = func_7A60(var_0.origin);
  return var_1 >= cos(50);
}

func_7A60(var_0) {
  if(scripts\engine\utility::player_is_in_jackal()) {
    var_1 = level.var_D127 gettagorigin("tag_camera");
  } else {
    var_1 = level.player getEye();
  }

  var_2 = vectornormalize(var_0 - var_1);
  var_3 = anglesToForward(level.player getplayerangles());
  var_4 = vectordot(var_2, var_3);
  return var_4;
}

func_16FE(var_0, var_1, var_2) {
  _setomnvarbit("ui_jackal_objective_bits", var_0, 1);
  setomnvar("ui_jackal_objective_string_" + var_0, var_1);
  setomnvar("ui_jackal_objective_state_" + var_0, 1);

  if(isDefined(var_2)) {
    setomnvar("ui_jackal_objective_maxkills_" + var_0, var_2);
    setomnvar("ui_jackal_objective_kills_" + var_0, 0);
  }
}

func_4474(var_0) {
  setomnvar("ui_jackal_objective_state_" + var_0, 2);
}

func_8E93(var_0) {
  _setomnvarbit("ui_jackal_objective_bits", var_0, 0);
}

func_100EC(var_0) {
  _setomnvarbit("ui_jackal_objective_bits", var_0, 1);
}

func_F433(var_0, var_1) {
  setomnvar("ui_jackal_objective_string_" + var_0, var_1);
}

func_F432(var_0, var_1) {
  setomnvar("ui_jackal_objective_kills_" + var_0, var_1);
}