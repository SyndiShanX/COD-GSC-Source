/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2934.gsc
***************************************/

func_1945(var_00, var_01, var_02) {
  self endon("death");

  if(isDefined(level.func_D127) && var_00 == level.func_D127)
    var_03 = 1;
  else
    var_03 = 0;

  if(var_03) {
    thread func_B840();
    func_A278();
    wait 0.5;
  }

  self.func_B8A4 = [];
  var_04 = 0;

  while(var_02 > 0) {
    if(!isDefined(self) || !isDefined(var_00)) {
      break;
    }
    if(var_04 == var_1.size)
      var_04 = 0;

    var_05 = var_1[var_04];
    var_4++;
    var_06 = func_1992(var_05, var_00);
    var_6.team = self.script_team;

    if(var_03) {
      var_6.func_438D = self;

      if(isDefined(self.func_594B))
        var_07 = 0;
      else
        var_07 = 1;

      var_06 func_A279(var_07);
      self.func_B8A4 = scripts\engine\utility::array_add(self.func_B8A4, var_06);
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

  while(isDefined(self.func_93D2) && self.func_93D2.size > 0)
    wait 0.1;

  childthread func_B841();
  var_00 = 12.0;
  var_01 = 24.0;
  wait(randomfloatrange(var_00, var_01));
  level.player scripts\sp\utility::func_65E1("jackal_enemy_homing_missile_allowed");
}

func_B841() {
  var_00 = 3.5;
  var_01 = 5.5;
  wait(randomfloatrange(var_00, var_01));
  level.player scripts\sp\utility::func_65E1("jackal_enemy_homing_missile_allowed_hyperaggressive");
}

func_7B95() {
  if(!isDefined(level.func_D127) || !isDefined(level.func_D127.func_93D2))
    return 0;

  return level.func_D127.func_93D2.size;
}

func_A279(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    thread func_B807();

  thread func_B805();
  self _meth_8557("OFFSCREEN_HAZARD_INDICATOR");
  thread func_B806();
}

func_B806() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_00 = length(self.origin - level.func_D127.origin);
    var_01 = scripts\sp\math::func_C097(200, 10000, var_00);
    var_02 = scripts\sp\math::func_6A8E(0.6, 1.3, var_01);
    self _meth_8277(var_02, 0.05);
    wait 0.05;
  }
}

func_686D(var_00, var_01) {
  self.enemy endon("death");
  var_02 = 0;
  self.enemy.func_EF5E = (0, 0, 0);
  self.enemy.func_EF63 = 1700;

  while(var_01 > 0) {
    if(var_02 == var_0.size)
      var_02 = 0;

    var_03 = var_0[var_02];
    var_2++;

    if(isDefined(self)) {
      var_04 = self.enemy thread func_1992(var_03, level.func_D127, undefined, undefined, 400, 0);
      var_4.func_438D = self.enemy;
    }

    var_1--;
    wait 0.3;
  }

  self.enemy.func_EF5E = undefined;
  self.func_6DA7 = 0;
}

func_B804() {
  self endon("death");
  self playSound("enemy_lockon_missile_launch");
  self _meth_8277(0.5, 0.05);
  self ghostattack(1.3, 0.05);
  wait 0.05;
  var_00 = 2;
  self _meth_8277(1.2, var_00);
  self ghostattack(2, var_00);
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
    self waittill("damage", var_00, var_01, var_02, var_03, var_04);

    if(isDefined(var_01) && var_01 == level.func_D127) {
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
  var_00 = 3000;
  var_01 = 12000;
  var_02 = 5000;
  var_03 = 25000;
  var_04 = 13 * level.func_A48E.func_A3FB;
  var_05 = 25 * level.func_A48E.func_A3FB;
  var_06 = 2000;
  var_07 = 500 * level.func_A48E.func_A3FB;
  var_08 = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.func_6E8B))
      var_08 = 1;

    if(!var_08) {
      var_09 = level.func_D127.spaceship_vel;
      var_10 = length(var_09);
      var_10 = scripts\engine\utility::mph_to_ips(var_10);
      var_10 = var_10 * 0.05;
      var_11 = var_10 + var_07;
      var_12 = vectordot(anglesToForward(self.angles), vectornormalize(var_09));
      var_13 = var_11 * var_12;

      if(var_13 < var_07)
        var_13 = var_07;

      var_14 = distance(self.origin, level.func_D127.origin);
      var_15 = scripts\sp\math::func_C097(var_00, var_01, var_14);
      var_16 = scripts\sp\math::func_6A8E(var_13, var_06, var_15);
      var_17 = scripts\sp\math::func_C097(var_02, var_03, var_14);
      var_18 = scripts\sp\math::func_6A8E(var_04, var_05, var_17);
    } else {
      var_16 = 1400;
      var_18 = 20;
    }

    self.func_B464 = var_16;
    self.func_1545 = var_18;
    wait 0.05;
  }
}

func_1993(var_00, var_01) {
  if(isDefined(self.func_EF5B)) {
    return;
  }
  self.func_EF5B = 1;

  if(!isDefined(var_01))
    var_01 = "TAG_FLASH_right";

  foreach(var_03 in var_00) {
    if(!isDefined(var_03)) {
      continue;
    }
    thread func_1992(var_01, var_03);
    wait(randomfloatrange(1, 1.3));
  }

  wait 0.2;
  self.func_EF5B = undefined;
}

func_1992(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(var_02) && !isDefined(self.func_EF5D))
    var_02 = 0;
  else if(isDefined(self.func_EF5D))
    var_02 = self.func_EF5D;

  if(isDefined(self.func_EF5C))
    var_09 = self.func_EF5C;
  else
    var_09 = undefined;

  if(isDefined(var_06))
    var_06 = var_06;
  else if(isDefined(self.func_EF61))
    var_06 = self.func_EF61;

  if(isDefined(var_04))
    var_04 = var_04;
  else if(isDefined(self.func_EF62))
    var_04 = self.func_EF62;
  else if(_isaircraft(self)) {
    var_04 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_04 = var_4[0];
  } else
    var_04 = 0;

  if(isDefined(self.func_EF5E))
    var_10 = self.func_EF5E;
  else
    var_10 = (0, 0, 1500);

  var_11 = scripts\engine\utility::spawn_tag_origin(self gettagorigin(var_00), self gettagangles(var_00));

  if(var_02) {
    var_12 = vectornormalize(var_1.origin - self.origin);
    var_11.angles = vectortoangles(var_12);
  }

  if(isDefined(level.func_D127) && var_01 == level.func_D127) {
    if(isDefined(self.func_EF60))
      var_11.func_AA99 = self.func_EF60;
    else
      var_11.func_AA99 = "jackal_missile_launch_space_for_plr";

    var_11.loop_sound = "jackal_missile_loop_for_ply";
    var_11.func_69E9 = "jackal_missile_explosion_plr";
  } else if(isDefined(self.func_EF5F))
    var_11.func_AA99 = self.func_EF5F;
  else
    var_11.func_AA99 = "jackal_missile_launch_space_npc";

  if(!isDefined(var_01)) {
    var_13 = 1;
    var_14 = scripts\engine\utility::spawn_tag_origin();
    var_14.func_5F27 = 1;
    var_14.origin = var_11.origin + anglesToForward(self gettagangles(var_00)) * 30000;
  } else if(isDefined(var_05) && !var_05) {
    var_13 = 1;
    var_14 = scripts\engine\utility::spawn_tag_origin();
    var_14.func_5F27 = 1;
    var_15 = vectornormalize(var_1.origin - var_11.origin);
    var_14.origin = var_11.origin + var_15 * 30000;
    var_01 = var_14;
  } else
    var_13 = 0;

  var_11.func_50D5 = var_03;
  var_11.func_01CF = 6;

  if(isDefined(self.func_EF63))
    var_16 = self.func_EF63;
  else if(isDefined(self.func_C841) && isDefined(self.func_C841.func_B825))
    var_16 = self.func_C841.func_B825;
  else
    var_16 = 1300;

  if(isDefined(self.func_EF5A))
    var_11.func_1545 = self.func_EF5A;
  else if(isDefined(self.func_C841) && isDefined(self.func_C841.func_B821))
    var_11.func_1545 = self.func_C841.func_B821;

  if(isDefined(var_08) && var_08 == 1)
    var_11 thread func_A332(var_01, var_13, self, var_06, var_16, var_10, undefined, var_07, var_04, undefined, var_09, var_08);
  else
    var_11 thread func_A332(var_01, var_13, self, var_06, var_16, var_10, undefined, var_07, var_04, undefined, var_09);

  return var_11;
}

func_A278() {
  if(!isDefined(self)) {
    return;
  }
  if(_isaircraft(self))
    var_00 = "j_mainroot_ship";
  else
    var_00 = "tag_origin";

  self playSound("jackal_enemy_locking_warning");
  playFXOnTag(scripts\engine\utility::getfx("jackal_enemy_locking"), self, var_00);
}

func_6D2A(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_02 = 1;
    var_03 = scripts\engine\utility::spawn_tag_origin();
    var_3.func_5F27 = 1;
    var_3.origin = self gettagorigin(var_00) + anglesToForward(self gettagangles(var_00)) * 30000;
  } else
    var_02 = 0;

  var_04 = scripts\engine\utility::spawn_tag_origin(self gettagorigin(var_00), self gettagangles(var_00));
  var_04 thread func_A332(var_01, var_02, self);
}

func_A332(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(var_00)) {
    return;
  }
  var_00 notify("homing_missile_incoming", self, var_02);
  self.func_6E9B = 0;
  func_B80F();
  thread func_B7F5();
  var_15 = 0;

  if(isDefined(level.func_D127) && isDefined(var_02) && var_02 == level.func_D127)
    var_15 = 1;

  if(!isDefined(var_03))
    var_03 = "missile_flare_generic";

  if(isstring(var_03))
    playFXOnTag(scripts\engine\utility::getfx(var_03), self, "tag_origin");
  else
    playFXOnTag(var_03, self, "tag_origin");

  if(isDefined(self.func_AA99)) {
    if(self.func_AA99 != "null")
      self playSound(self.func_AA99);
  } else
    self playSound("jackal_missile_launch_space_npc");

  if(!isDefined(self.loop_sound))
    var_16 = "jackal_missile_lp_space";
  else
    var_16 = self.loop_sound;

  if(!isDefined(var_09))
    var_09 = 0;

  if(!var_09)
    self playLoopSound(var_16);

  while(isDefined(self.func_50D5))
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_10))
    var_10 = 1.0;

  if(isDefined(var_0.func_5F27))
    self.func_5F27 = var_00;

  var_17 = var_10 * 0.25;
  var_18 = 0;
  var_19 = 0.3;
  var_20 = 8;

  if(isDefined(self.func_01CF))
    var_20 = self.func_01CF;
  else if(isDefined(level.func_B81B))
    var_20 = level.func_B81B;

  var_21 = 0;
  var_22 = 0;

  if(var_01)
    var_23 = (0, 0, 0);
  else
    var_23 = (0, 0, 25);

  if(isDefined(var_12))
    var_23 = var_12;

  if(!isDefined(var_14))
    var_14 = 0;

  var_24 = var_0.origin + var_23;
  var_25 = var_24;
  var_26 = (0, 0, 0);

  if(!isDefined(self.func_1545))
    self.func_1545 = 5;

  var_27 = 0;

  if(isDefined(level.func_D127) && var_00 == level.func_D127)
    var_27 = 1;

  if(isDefined(var_08))
    var_28 = var_08;
  else
    var_28 = 0;

  if(!isDefined(var_05))
    var_05 = (0, 0, 0);

  if(!isDefined(var_04))
    var_04 = 1000;

  if(isDefined(var_02) && isDefined(var_2.func_B8AE) && isDefined(var_2.func_B8AE.func_B4C9))
    var_04 = var_2.func_B8AE.func_B4C9;

  if(!isDefined(var_06))
    var_06 = 0;

  if(!isDefined(var_11))
    var_11 = 0;

  var_29 = 0;

  if(isDefined(self.func_BFEC))
    var_29 = self.func_BFEC;

  if(isDefined(self.func_69E9))
    var_30 = self.func_69E9;
  else
    var_30 = undefined;

  var_31 = self.origin;
  var_32 = self.angles;
  var_33 = 0;
  var_34 = undefined;

  if(isDefined(var_0.func_B83D))
    var_35 = var_0.func_B83D;
  else
    var_35 = 100;

  var_36 = func_A26F();

  if(isDefined(var_13)) {
    var_36.func_12AFD.func_CA26 = var_13.func_12B00;
    var_36.func_12AFD.func_CA25 = var_13.func_12AFF;
    var_36.func_12AFD.func_B144 = var_13.func_12AFE;
    var_36.func_B0EF.func_CA26 = var_13.func_B0F3;
    var_36.func_B0EF.func_CA25 = var_13.func_B0F2;
    var_36.func_B0EF.func_B144 = var_13.func_B0F1;
  } else {
    var_36.func_12AFD.func_CA26 = 0.3;
    var_36.func_12AFD.func_CA25 = 0.4;
    var_36.func_12AFD.func_B144 = 400;
    var_36.func_B0EF.func_CA26 = 0.3;
    var_36.func_B0EF.func_CA25 = 0.4;
    var_36.func_B0EF.func_B144 = 400;
  }

  scripts\engine\utility::waitframe();
  var_37 = (0, 0, 0);
  var_38 = var_31 + var_37;
  var_39 = var_38;
  var_40 = 1;
  var_31 = var_38;

  if(isDefined(self)) {
    self.origin = var_38;
    self.func_C727 = var_00;
  }

  if(isDefined(self.weapon))
    var_41 = self.weapon;
  else
    var_41 = "spaceship_homing_missile";

  if(isDefined(self)) {
    self.func_217A = 0;
    thread func_216F(var_02);
  }

  for(;;) {
    if(!isDefined(self)) {
      var_22 = 1;
      var_42 = undefined;
      break;
    }

    if(var_18 < var_10 + var_17) {
      if(var_18 < var_17)
        var_43 = 0;
      else
        var_43 = scripts\sp\math::func_C097(0, var_10, var_18 - var_17);
    } else
      var_43 = 1;

    if(var_01)
      var_44 = 1;
    else
      var_44 = var_43;

    if(isDefined(self.func_6E8B)) {
      var_00 = self.func_6E8B;
      self.func_6E9B = 1;
    } else if(isDefined(self.func_C727) && isDefined(self.func_C727.func_6E9C) && self.func_C727.func_6E9C.func_12B86.size > 0) {
      self.func_6E8B = scripts\engine\utility::random(self.func_C727.func_6E9C.func_12B86);
      self.func_C727.func_6E9C.func_12B86 = scripts\engine\utility::array_remove(self.func_C727.func_6E9C.func_12B86, self.func_6E8B);
      var_00 = self.func_6E8B;
      self.func_6E9B = 1;
    } else
      self.func_6E9B = 0;

    if(isDefined(self.func_114F9) && var_00 != self.func_114F9)
      var_00 = self.func_114F9;

    if(!isDefined(var_00)) {
      var_00 = scripts\engine\utility::spawn_tag_origin();
      var_0.origin = self.origin + anglesToForward(self.angles) * 10000;
      var_0.func_5F27 = 1;
      self.func_5F27 = var_00;
      var_01 = 1;
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

    if(var_50 == 1)
      var_53 = 0;
    else
      var_53 = 1 - scripts\sp\math::func_C097(var_50, 1, var_52);

    var_54 = vectornormalize(var_48 * var_53 + var_49 * (1 - var_53));
    var_55 = scripts\sp\math::func_C097(0, 17000, var_47);
    var_55 = scripts\sp\math::func_C09B(var_55);

    if(var_55 < var_40)
      var_40 = var_55;

    var_56 = var_28 + var_14 * (1 - var_40);
    var_31 = var_31 + var_54 * var_56;
    var_32 = vectortoangles(var_54);
    var_37 = (0, 0, var_35 * var_43 * var_40);
    var_57 = var_05 * var_43 * var_40;
    var_36 func_B7E6();
    var_58 = var_36.func_B0EF.func_4D94["val"] * (var_43 * var_40);
    var_59 = var_36.func_12AFD.func_4D94["val"] * (var_43 * var_40);
    var_60 = anglestoright(var_32) * var_58 + anglestoup(var_32) * var_59;
    var_38 = var_31 + var_60 + var_37 + var_57;

    if(isDefined(var_02)) {
      if(isDefined(self.func_438D))
        var_61 = [self, self.func_438D, var_02];
      else
        var_61 = [self, var_02];
    } else if(isDefined(self.func_438D))
      var_61 = [self, self.func_438D];
    else
      var_61 = [self];

    if(isDefined(level.func_B8AD))
      var_61 = scripts\engine\utility::array_combine(level.func_B8AD, var_61);

    var_62 = 0;

    if(isDefined(self.func_6E9B) && var_47 < 1000) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
      var_38 = var_24;
    } else if(isDefined(level.func_D127) && var_00 == level.func_D127 && var_47 < 700) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
    } else if(var_56 > var_47) {
      var_21 = 1;
      var_62 = 1;
      var_33 = 1;
    }

    if(!isDefined(self.func_C180))
      var_42 = scripts\engine\trace::ray_trace(self.origin, var_38, var_61, undefined, 1);
    else {
      var_42["fraction"] = 1;
      var_42["entity"] = var_00;
      var_42["position"] = var_24;
      var_42["surfacetype"] = "default";
      var_42["normal"] = -1 * anglesToForward(self.angles);
    }

    if(var_42["fraction"] < 1 && var_42["surfacetype"] != "surftype_none" && self.func_217A) {
      var_33 = 0;
      var_38 = var_42["position"];

      if(distance(var_42["position"], var_24) < 100)
        var_21 = 1;

      var_62 = 1;
    } else if(var_47 < var_06) {
      var_62 = 1;
      var_34 = self.angles;

      if(!isDefined(var_07))
        var_07 = ["jet_missile_imp_airburst", "capitalship_missile_airburst", 5];
    }

    self.origin = var_38;
    self.angles = vectortoangles(vectornormalize(var_38 - var_39));
    var_39 = var_38;

    if(var_62 || isDefined(self.func_72CA)) {
      break;
    }
    if(var_18 > var_20) {
      var_22 = 1;
      break;
    }

    var_28 = var_28 + self.func_1545;

    if(isDefined(self.func_B464)) {
      if(var_28 > self.func_B464)
        var_28 = self.func_B464;
    } else if(var_28 > var_04)
      var_28 = var_04;

    var_18 = var_18 + 0.05;

    if(isDefined(self.func_6E8B) && self.func_6E8B.active) {
      self.func_6E8B waittill("pos_updated");
      continue;
    }

    scripts\engine\utility::waitframe();
  }

  if(!var_22) {
    if(isDefined(self.func_5F27) && var_21)
      var_34 = self.angles;

    if(self.func_6E9B) {
      var_34 = self.angles;
      var_11 = 1;
    }

    if(isDefined(var_0.func_1A89) && !isDefined(var_07) && var_33) {
      var_07 = ["jet_missile_imp_airburst", "capitalship_missile_airburst", 5];
      var_34 = self.angles;
    }
  }

  scripts\engine\utility::waitframe();

  if(var_22 || !isDefined(self))
    self notify("missile_dud");
  else {
    self notify("missile_explode");

    if(isDefined(var_02)) {
      var_02 notify("missile_explode");

      if(scripts\sp\utility::func_D123() && var_02 == level.func_D127)
        player_jackal_scripted_missile_self_damage(var_42["position"]);
    } else
      var_02 = undefined;

    if(!var_11) {
      if(isDefined(var_02) && isDefined(var_2.func_B8AE))
        radiusdamage(var_42["position"], var_2.func_B8AE.func_DCCA, var_2.func_B8AE.func_B48B, var_2.func_B8AE.func_B758, var_02, "MOD_EXPLOSIVE", var_41);
      else
        radiusdamage(var_42["position"], 512, 2500, 1000, var_02, "MOD_EXPLOSIVE", var_41);
    }

    if(var_21 && isDefined(var_00))
      var_42["entity"] = var_00;

    thread func_4C7B(var_42, "missile", var_07, var_30, var_34);

    if(isDefined(var_42["entity"])) {
      var_42["entity"] notify("missile_hit");

      if(!var_11)
        var_42["entity"] func_54DE(5000, var_42["position"], var_02, var_41);

      if(var_27 && var_42["entity"] != level.func_D127)
        func_12869(var_42["position"]);
      else if(!var_29)
        earthquake(0.2, 0.7, var_42["position"], 15000);
    } else {
      if(var_27) {
        func_12869(var_42["position"]);
        return;
      }

      if(!var_29)
        earthquake(0.2, 0.7, var_42["position"], 15000);
    }
  }
}

player_jackal_scripted_missile_self_damage(var_00) {
  var_01 = distance(var_00, level.func_D127.origin);
  var_02 = 1900;

  if(var_01 > var_02) {
    return;
  }
  var_03 = scripts\sp\math::func_C097(0, var_02, var_01);
  var_04 = scripts\sp\math::func_6A8E(1000, 500, var_03);
  level.func_D127 getrandomarmkillstreak(var_04, var_00, level.func_D127, level.func_D127, "MOD_EXPLOSIVE", "spaceship_homing_missile");
}

func_216F(var_00) {
  self endon("death");
  var_01 = self;

  if(!isDefined(var_00)) {
    var_1.func_217A = 1;
    return;
  }

  if(isDefined(var_0.func_217B))
    wait(var_0.func_217B);

  if(isDefined(var_01))
    var_1.func_217A = 1;
}

func_12869(var_00) {
  if(isDefined(level.func_A056) && scripts\engine\utility::player_is_in_jackal())
    [[level.func_A056.func_B81C]](var_00);
}

func_A26F(var_00) {
  var_01 = spawnStruct();
  var_1.func_B0EF = func_A26E();
  var_1.func_12AFD = func_A26E();

  if(isDefined(var_00))
    var_1.func_6BB1 = func_A26E();

  return var_01;
}

func_A26E() {
  var_00 = spawnStruct();
  var_0.func_4D94 = [];
  var_0.func_4D94["old"] = 0;
  var_0.func_4D94["period"] = 0;
  var_0.func_4D94["target"] = 0;
  var_0.func_4D94["val"] = 0;
  var_0.func_4D94["time"] = 0;
  return var_00;
}

func_A26D(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();
  var_6.func_12B00 = var_00;
  var_6.func_12AFF = var_01;
  var_6.func_12AFE = var_02;
  var_6.func_B0F3 = var_03;
  var_6.func_B0F2 = var_04;
  var_6.func_B0F1 = var_05;
  return var_06;
}

func_B80F() {
  if(!isDefined(level.func_1678))
    level.func_1678 = [];

  level.func_1678[level.func_1678.size] = self;
  thread func_B810();
}

func_B810() {
  self waittill("entitydeleted");
  level.func_1678 = scripts\engine\utility::array_remove(level.func_1678, self);
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
  if(isDefined(self) && isDefined(self.func_5F27))
    self.func_5F27 delete();

  if(isDefined(self))
    self delete();
}

func_B7E6() {
  self.func_B0EF func_B7E7();
  self.func_12AFD func_B7E7();

  if(isDefined(self.func_6BB1))
    self.func_6BB1 func_B7E7();
}

func_B7E7() {
  if(self.func_4D94["time"] >= self.func_4D94["period"]) {
    self.func_4D94["period"] = randomfloatrange(self.func_CA26, self.func_CA25);
    self.func_4D94["old"] = self.func_4D94["target"];
    self.func_4D94["time"] = 0;
    self.func_4D94["target"] = randomfloatrange(self.func_B144 * -1, self.func_B144);
  }

  var_00 = scripts\sp\math::func_C097(0, self.func_4D94["period"], self.func_4D94["time"]);
  var_00 = scripts\sp\math::func_C09C(var_00);
  self.func_4D94["val"] = self.func_4D94["old"] * (1 - var_00) + self.func_4D94["target"] * var_00;
  self.func_4D94["time"] = self.func_4D94["time"] + 0.05;
}

func_54DE(var_00, var_01, var_02, var_03) {
  if(isDefined(self.func_8CBE))
    var_04 = self.func_8CBE;
  else
    var_04 = self;

  if(!_isent(var_04)) {
    return;
  }
  var_04 getrandomarmkillstreak(var_00, var_01, var_02, var_02, "MOD_EXPLOSIVE", var_03);
}

func_4C7B(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");

  if(isDefined(var_0["entity"]) && isDefined(var_0["entity"].func_112DC))
    var_05 = var_0["entity"].func_112DC;
  else if(isDefined(var_0["entity"]) && isDefined(var_0["entity"].surfacetype))
    var_05 = var_0["entity"].surfacetype;
  else
    var_05 = var_0["surfacetype"];

  if(!isDefined(var_02))
    var_06 = func_B7E8(var_05, var_01);
  else
    var_06 = var_02;

  var_07 = spawn("script_model", var_0["position"]);
  var_07 setModel("tag_origin");

  if(isDefined(var_04))
    var_7.angles = var_04;
  else
    var_7.angles = vectortoangles(var_0["normal"]);

  if(isDefined(var_0["entity"]) && _isent(var_0["entity"]))
    var_07 linkto(var_0["entity"]);

  playFXOnTag(scripts\engine\utility::getfx(var_6[0]), var_07, "tag_origin");

  if(!isDefined(var_03)) {
    if(isDefined(var_6[1]))
      thread scripts\engine\utility::play_sound_in_space(var_6[1], var_7.origin);
  } else
    thread scripts\engine\utility::play_sound_in_space(var_03, var_7.origin);

  thread scripts\sp\utility::func_5187(var_07);
  wait(var_6[2]);

  if(isDefined(var_07))
    var_07 delete();
}

func_B7E8(var_00, var_01) {
  var_02 = "";
  var_03 = "";
  var_04 = 0;

  switch (var_00) {
    case "metal":
      switch (var_01) {
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "jackal_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    case "rock":
      switch (var_01) {
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "jackal_missile_impact_rock";
          var_04 = 5;
          break;
      }

      break;
    case "water":
      switch (var_01) {
        case "missile":
          var_02 = "jet_missile_imp_water";
          var_03 = "jackal_missile_impact_water";
          var_04 = 5;
          break;
      }

      break;
    case "jackal":
      switch (var_01) {
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "jackal_missile_impact";
          var_04 = 5;
          break;
      }

      break;
    default:
      switch (var_01) {
        case "missile":
          var_02 = "jet_missile_imp_generic";
          var_03 = "jackal_missile_impact";
          var_04 = 5;

          if(isDefined(level.func_241D) && !level.func_241D)
            var_02 = "jet_missile_imp_generic_zg";

          break;
      }

      break;
  }

  return [var_02, var_03, var_04];
}

func_F42B(var_00) {
  if(level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(isDefined(self.func_9B4C) && self.func_9B4C)
    var_00 = var_00 + "_ace";

  if(isDefined(self.func_9CB8) && self.func_9CB8)
    var_00 = var_00 + "_ace";

  if(var_00 == "none")
    self _meth_84A0(0);
  else if(var_00 == "ally_jackal")
    self _meth_84A0(1);
  else if(var_00 == "enemy_jackal")
    self _meth_84A0(2);
  else if(var_00 == "enemy_dogfight")
    self _meth_84A0(3);
  else if(var_00 == "ally_capitalship")
    self _meth_84A0(4);
  else if(var_00 == "enemy_capitalship")
    self _meth_84A0(5);
  else if(var_00 == "enemy_jackal_ace")
    self _meth_84A0(6);
  else if(var_00 == "enemy_dogfight_ace")
    self _meth_84A0(7);
  else if(var_00 == "ally_jackal_unloc")
    self _meth_84A0(8);
  else {}
}

func_F42C(var_00) {
  if(level.player scripts\sp\utility::func_65DF("disable_jackal_lockon") && level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(self.func_AEDF.priority) {
    if(isDefined(self.func_9B4C) && self.func_9B4C)
      var_00 = "ace_objective";
    else if(isDefined(self.func_9CB8) && self.func_9CB8)
      var_00 = "ace_objective";
    else {
      if(!isDefined(self.script_team))
        var_01 = "allies";
      else
        var_01 = self.script_team;

      var_00 = var_01 + "_objective";
    }
  } else if(var_00 == "jackal" || var_00 == "last_engaged") {
    if(isDefined(self.func_9B4C) && self.func_9B4C)
      var_00 = var_00 + "_ace";
    else if(isDefined(self.func_9CB8) && self.func_9CB8)
      var_00 = var_00 + "_ace";
  }

  switch (var_00) {
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

func_39C3(var_00, var_01, var_02) {
  self notify("scan_for_turrets");
  self endon("death");
  self endon("scan_for_turrets");
  var_03 = 0;

  if(!isDefined(var_01))
    var_01 = 0;

  if(self.script_team == "axis")
    var_04 = "enemy";
  else
    var_04 = "friendly";

  if(isDefined(var_02))
    var_04 = var_02;

  while(var_03 < var_00) {
    scripts\sp\utility::func_F40A(var_04, 0);

    if(!var_01)
      self playSound("jackal_scan_ship");

    wait 0.25;
    self hudoutlinedisable();
    var_3++;
    wait 0.15;
  }
}

func_D195(var_00, var_01) {
  if(var_00) {
    if(isDefined(level.func_D127.audio.func_138F5)) {
      return;
    }
    var_02 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, "jackal_collision_warning");
    level.func_D127.audio.func_138F5 = var_02;
    level.player thread scripts\engine\utility::play_loop_sound_on_entity(var_02);
  } else {
    if(!isDefined(level.func_D127.audio.func_138F5)) {
      return;
    }
    level.player notify("stop sound" + level.func_D127.audio.func_138F5);
    level.func_D127.audio.func_138F5 = undefined;
  }
}

func_9C19(var_00) {
  var_01 = func_7A60(var_0.origin);
  return var_01 >= cos(50);
}

func_7A60(var_00) {
  if(scripts\engine\utility::player_is_in_jackal())
    var_01 = level.func_D127 gettagorigin("tag_camera");
  else
    var_01 = level.player getEye();

  var_02 = vectornormalize(var_00 - var_01);
  var_03 = anglesToForward(level.player getplayerangles());
  var_04 = vectordot(var_02, var_03);
  return var_04;
}

func_16FE(var_00, var_01, var_02) {
  _setomnvarbit("ui_jackal_objective_bits", var_00, 1);
  setomnvar("ui_jackal_objective_string_" + var_00, var_01);
  setomnvar("ui_jackal_objective_state_" + var_00, 1);

  if(isDefined(var_02)) {
    setomnvar("ui_jackal_objective_maxkills_" + var_00, var_02);
    setomnvar("ui_jackal_objective_kills_" + var_00, 0);
  }
}

func_4474(var_00) {
  setomnvar("ui_jackal_objective_state_" + var_00, 2);
}

func_8E93(var_00) {
  _setomnvarbit("ui_jackal_objective_bits", var_00, 0);
}

func_100EC(var_00) {
  _setomnvarbit("ui_jackal_objective_bits", var_00, 1);
}

func_F433(var_00, var_01) {
  setomnvar("ui_jackal_objective_string_" + var_00, var_01);
}

func_F432(var_00, var_01) {
  setomnvar("ui_jackal_objective_kills_" + var_00, var_01);
}