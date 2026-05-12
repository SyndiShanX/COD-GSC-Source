/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\hub_vl_firingrange.gsc
*********************************************/

func_51D0() {
  var_00 = spawnStruct();
  var_00.var_3E6C = getent("firingrange_start", "targetname");
  var_00.var_0C3A = func_3C36();
  var_00.var_0BDC = func_3C30();
  var_00.var_9C7C = [];
  var_00.var_9C7D = [];
  var_00.var_0C3B = func_3C37();
  var_00.var_0C39 = func_3C34();
  var_00.var_0C38 = func_3C33();
  var_00.var_0BDA = func_3C2F();
  var_00.var_0C37 = func_3C35();
  var_00.var_0BE1 = func_3C32();
  var_00.var_0C3C = func_3C31();
  var_00.var_0BD8 = func_3C2E();
  var_00.var_1356 = common_scripts\utility::func_46B5("audio_buzzer_org", "targetname");
  var_00.var_8F41 = [];
  var_00.var_5B57 = undefined;
  var_00.var_9812 = 32;
  var_00.var_981D = 256;
  var_00.var_76AF = 0;
  var_00.var_76AE = 0;
  var_00.var_7F1F = undefined;
  var_00.var_621E = undefined;
  var_00.var_621F = undefined;
  var_00.var_6095 = undefined;
  var_00.var_1DE2 = 0.55;
  var_00.var_1DE1 = 0;
  var_00.var_4839 = 24;
  var_00.var_29BB = 0;
  var_00.var_7A64 = 0;
  var_00.var_8B3B = 0;
  var_00.var_8B3C = 0;
  var_00.var_6F48 = 0;
  var_00.var_8BB1 = 0;
  var_00.var_7F0E = 176;
  var_00.var_99DA = 0;
  var_00.var_4895 = 5;
  var_00.var_7F12 = 0;
  var_00.var_57CC = 0;
  var_00.var_A48D = loadfx("vfx/props/holo_target_red_spawn_in");
  var_00.var_A48E = loadfx("vfx/props/holo_target_red_spawn_out");
  var_00.var_A48C = loadfx("vfx/beam/firing_range_edge_glow");
  common_scripts\utility::func_0FB2(var_00.var_0C3B, ::func_9DAD);
  level.var_9804 = (1.3, 0, 25);
  level.var_9817 = 12;
  level.var_4DD0 = 18;
  level.var_3C3B = var_00;
}

func_3C32() {
  var_00 = getEntArray("holo_emitter_floor", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_6A23 = var_02.var_0116;
    var_02.var_A08D = var_02.var_0116 + (0, 0, 4);
  }

  return var_00;
}

func_3C2E() {
  var_00 = getEntArray("display_3dui_mesh", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  return var_00;
}

func_3C34() {
  var_00 = common_scripts\utility::func_46B7("target_track_min", "targetname");
  return var_00;
}

func_3C33() {
  var_00 = common_scripts\utility::func_46B7("target_track_max", "targetname");
  return var_00;
}

func_3C2F() {
  var_00 = common_scripts\utility::func_46B7("booth_display_01", "targetname");
  var_01 = common_scripts\utility::func_46B7("booth_display_02", "targetname");
  var_02 = common_scripts\utility::func_46B7("booth_display_03", "targetname");
  var_03 = common_scripts\utility::func_46B7("booth_display_04", "targetname");
  var_04 = common_scripts\utility::func_46B7("booth_display_05", "targetname");
  var_05 = common_scripts\utility::func_46B7("booth_display_06", "targetname");
  var_06 = [var_00, var_01, var_02, var_03, var_04, var_05];
  return var_06;
}

func_9DAD() {
  var_00 = self;
  var_00 thread maps\mp\_dynamic_world::func_9DC3(::func_726D, ::func_72DD);
}

func_726D(param_00) {
  level endon("shutdown_hologram");
  while(level.var_3C3B.var_57CC == 1) {
    wait(0.1);
  }

  var_01 = self;
  if(!isDefined(param_00.var_81E1)) {
    return;
  }

  var_02 = int(param_00.var_81E1);
  level.var_3C3B.var_7F1F = var_02;
  if(!isDefined(level.var_3C3B.var_0BDC[var_02])) {
    return;
  }

  var_01 thread func_9301(var_02);
}

func_72DD(param_00) {
  var_01 = self;
  if(!isDefined(param_00.var_81E1)) {
    return;
  }

  var_02 = int(param_00.var_81E1);
  level.var_3C3B.var_7F1F = var_02;
  if(!isDefined(level.var_3C3B.var_0BDC[var_02])) {
    return;
  }

  var_01 thread func_72DE(var_02);
}

func_72DE(param_00) {
  level endon("shutdown_hologram");
  var_01 = getent("firing_range_round_trigger_end", "targetname");
  var_01 waittill("trigger");
  level.var_3C3B.var_54F5 = 0;
  thread func_8C35(param_00, self);
}

func_8DA3(param_00, param_01, param_02, param_03) {
  maps\mp\_audio::func_8DA2(param_00, param_01, param_02, param_03);
}

func_9838(param_00) {
  level endon("shutdown_hologram");
  var_01 = self;
  var_02 = level.var_3C3B.var_0C3A[param_00][0][0];
  var_02.var_0BC0 = 1;
  var_02 func_90AA();
  var_02 method_805B();
  var_02 solid();
  var_02 setCanDamage(1);
  var_02 setdamagecallbackon(1);
  var_02.var_29B5 = ::func_6378;
  var_02.var_00BC = 9999;
  var_02.var_00FB = 9999;
  foreach(var_04 in level.var_3C3B.var_0C39) {
    if(var_04.var_81E1 == level.var_3C3B.var_7F1F) {
      level.var_3C3B.var_621E = var_04;
      break;
    }
  }

  foreach(var_04 in level.var_3C3B.var_0C38) {
    if(var_04.var_81E1 == level.var_3C3B.var_7F1F) {
      level.var_3C3B.var_6095 = var_04;
      break;
    }
  }

  if(!isDefined(level.var_3C3B.var_621E) || !isDefined(level.var_3C3B.var_6095)) {
    thread func_8C35(param_00, var_01);
    return;
  }

  level.var_3C3B.var_621F = level.var_3C3B.var_621E.var_0116 + anglesToForward(level.var_3C3B.var_621E.var_001D) * -64;
  var_02 thread func_637F(var_01, var_02, level.var_3C3B.var_621E);
  thread func_63E2(var_01);
  thread func_6399(var_01);
  thread func_639C(var_01);
  thread func_3004(var_01, param_00);
  var_01 thread func_6814(var_02);
}

func_637F(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  self endon("death");
  var_03 = 0.0254;
  for(;;) {
    if(!isDefined(param_01) || !isDefined(param_02)) {
      level.var_3C3B.var_7A64 = 0;
      param_00 setclientomnvar("ui_vlobby_round_distance", level.var_3C3B.var_7A64);
    } else {
      var_04 = distance2d(param_01.var_0116, param_02.var_0116);
      var_05 = int(common_scripts\utility::func_7F03(var_03 * var_04, 0));
      if(var_05 != level.var_3C3B.var_7A64) {
        if(var_05 > 100) {
          var_05 = 100;
        } else if(var_05 < 0) {
          var_05 = 0;
        }

        level.var_3C3B.var_7A64 = var_05;
        param_00 setclientomnvar("ui_vlobby_round_distance", level.var_3C3B.var_7A64);
      }
    }

    wait 0.05;
  }
}

func_6814(param_00) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  self notifyonplayercommand("toggled_up_pressed", "+actionslot 1");
  self notifyonplayercommand("toggled_up_released", "-actionslot 1");
  self notifyonplayercommand("toggled_down_pressed", "+actionslot 2");
  self notifyonplayercommand("toggled_down_released", "-actionslot 2");
  thread func_63F5(param_00);
  thread func_63F6(param_00);
  thread func_6383(param_00);
  thread func_6384(param_00);
  thread func_64CF(param_00, self);
}

func_63F5(param_00) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    self waittill("toggled_up_pressed");
    level.var_3C3B.var_1DE1 = level.var_3C3B.var_1DE2;
    if(level.var_3C3B.var_76AF == 0) {
      level.var_3C3B.var_76AF = 1;
      level.var_3C3B.var_76AE = 0;
      thread func_64AF(level.var_3C3B.var_6095.var_0116, param_00, self);
    }
  }
}

func_63F6(param_00) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    self waittill("toggled_up_released");
    var_01 = distance2d(level.var_3C3B.var_6095.var_0116, param_00.var_0116);
    if(var_01 <= 1) {
      param_00 moveto(param_00.var_0116, 0.05);
    } else {
      var_02 = param_00.var_0116 + anglesToForward(level.var_3C3B.var_0C38[0].var_001D) * level.var_3C3B.var_4839 * -1;
      var_01 = distance2d(var_02, param_00.var_0116);
      var_03 = var_01 / level.var_3C3B.var_981D;
      if(var_03 < 0.05) {
        var_03 = 0.05;
      }

      level.var_3C3B.var_1DE1 = var_03 + 0.05;
      thread func_64AF(var_02, param_00, self);
    }

    param_00 waittill("movedone");
    level.var_3C3B.var_76AF = 0;
  }
}

func_6383(param_00) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    self waittill("toggled_down_pressed");
    level.var_3C3B.var_1DE1 = level.var_3C3B.var_1DE2;
    if(level.var_3C3B.var_76AE == 0) {
      level.var_3C3B.var_76AE = 1;
      level.var_3C3B.var_76AF = 0;
      thread func_64AF(level.var_3C3B.var_621F, param_00, self);
    }
  }
}

func_6384(param_00) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    self waittill("toggled_down_released");
    var_01 = distance2d(level.var_3C3B.var_621F, param_00.var_0116);
    if(var_01 <= 1) {
      param_00 moveto(param_00.var_0116, 0.05);
    } else {
      var_02 = param_00.var_0116 + anglesToForward(level.var_3C3B.var_0C38[0].var_001D) * level.var_3C3B.var_4839;
      var_01 = distance2d(var_02, param_00.var_0116);
      var_03 = var_01 / level.var_3C3B.var_981D;
      if(var_03 < 0.05) {
        var_03 = 0.05;
      }

      level.var_3C3B.var_1DE1 = var_03 + 0.05;
      thread func_64AF(var_02, param_00, self);
    }

    param_00 waittill("movedone");
    level.var_3C3B.var_76AE = 0;
  }
}

func_64AF(param_00, param_01, param_02) {
  var_03 = distance2d(param_00, param_01.var_0116);
  if(var_03 <= 1) {
    param_01 notify("movedone");
    return;
  }

  var_04 = var_03 / level.var_3C3B.var_981D;
  if(var_04 < 0.05) {
    var_04 = 0.05;
  }

  param_01 moveto(param_00, var_04);
}

func_64CF(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    wait 0.05;
    if(level.var_3C3B.var_76AE == 1 || level.var_3C3B.var_76AF == 1) {
      if(level.var_3C3B.var_1DE1 > 0) {
        level.var_3C3B.var_1DE1 = level.var_3C3B.var_1DE1 - 0.05;
        continue;
      }

      param_00 moveto(param_00.var_0116, 0.05);
      level.var_3C3B.var_76AE = 0;
      level.var_3C3B.var_76AF = 0;
    }
  }
}

func_6377(param_00) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  var_01 = undefined;
  var_02 = param_00;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(level.var_3C3B.var_7F1F == 7) {
      self.var_00BC = self.var_00FB;
    }

    var_0B = self gettagorigin("tag_chest");
    param_00 method_8615("mp_hit_default");
    var_0C = func_4591(var_0A, var_08, param_00);
    var_01 = common_scripts\utility::func_7F03(float(var_01) * var_0C, 0);
    var_01 = int(var_01);
    if(var_01 > 999) {
      var_01 = 999;
    }

    if(var_01 < 0) {
      var_01 = 0;
    }

    level.var_3C3B.var_29BB = var_01;
    var_0D = level.var_3C3B.var_8B3C + 1;
    if(var_0D > 9999) {
      level.var_3C3B.var_8B3C = 0;
    } else if(var_0D < 0) {
      level.var_3C3B.var_8B3C = 0;
    } else {
      level.var_3C3B.var_8B3C = var_0D;
    }

    level.var_3C3B.var_8BB1 = 1;
  }
}

func_6378(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(self)) {
    return;
  }

  if(level.var_3C3B.var_7F1F == 7) {
    self.var_00BC = self.var_00FB;
  }

  var_0C = self gettagorigin("tag_chest");
  param_01 method_8615("mp_hit_default");
  var_0D = 1;
  if(isDefined(param_01)) {
    var_0D = func_4591(param_05, param_0B, param_01);
  }

  param_02 = common_scripts\utility::func_7F03(float(param_02) * var_0D, 0);
  param_02 = int(param_02);
  if(param_02 > 999) {
    param_02 = 999;
  }

  if(param_02 < 0) {
    param_02 = 0;
  }

  level.var_3C3B.var_29BB = param_02;
  if(isDefined(param_01)) {
    if(isDefined(param_00) && param_00 != param_01) {
      if(!isDefined(param_00.var_2995)) {
        param_00.var_2995 = 1;
        var_0E = level.var_3C3B.var_8B3C + 1;
        if(var_0E > 9999) {
          level.var_3C3B.var_8B3C = 0;
        } else if(var_0E < 0) {
          level.var_3C3B.var_8B3C = 0;
        } else {
          level.var_3C3B.var_8B3C = var_0E;
        }

        level.var_3C3B.var_8BB1 = 1;
      }
    } else {
      param_02 thread func_268B();
    }
  }

  level.var_3C3B.var_8BB1 = 1;
}

func_268B() {
  level endon("shutdown_hologram");
  self endon("disconnect");
  if(!isDefined(self.var_29E2)) {
    self.var_29E2 = 1;
    return;
  }

  self.var_29E2++;
}

func_4591(param_00, param_01, param_02) {
  var_03 = "none";
  var_04 = 1;
  var_05 = strtok(param_00, "_");
  var_06 = var_05[0];
  if(param_00 != "specialty_null" && param_00 != "none" && param_00 != "combatknife_mp") {
    if(maps\mp\gametypes\_class::func_5835(var_06) || maps\mp\gametypes\_class::func_5839(var_06, 0)) {
      if(param_01 == "tag_head") {
        var_03 = "head";
      } else if(param_01 == "tag_chest") {
        var_03 = "torso_upper";
      } else if(param_01 == "tag_arms") {
        var_03 = "right_arm_upper";
      } else if(param_01 == "tag_legs") {
        var_03 = "torso_lower";
      } else {
        var_03 = "none";
      }

      var_04 = param_02 method_850B(var_06 + "_mp", var_03);
      return var_04;
    }

    return var_04;
  }

  return var_04;
}

func_A6DE() {
  self endon("disconnect");
  self endon("reload");
  self endon("weapon_change");
  var_00 = 0;
  var_01 = self getcurrentweaponclipammo("right");
  var_02 = self getcurrentweaponclipammo("left");
  self waittill("weapon_fired");
  var_00 = 1;
  var_03 = self getcurrentweaponclipammo("right");
  var_04 = self getcurrentweaponclipammo("left");
  var_05 = var_01 - var_03 + var_02 - var_04;
  if(var_05 > 0) {
    var_00 = var_05;
  }

  return var_00;
}

func_63E2(param_00) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    param_00.var_29E2 = 0;
    var_01 = param_00 func_A6DE();
    if(isDefined(var_01)) {
      var_02 = level.var_3C3B.var_8B3B + var_01;
      if(var_02 > 9999) {
        level.var_3C3B.var_8B3B = 0;
        level.var_3C3B.var_8B3C = 0;
        level.var_3C3B.var_6F48 = 0;
        param_00 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
        param_00 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
        param_00 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
      } else if(var_02 < 0) {
        level.var_3C3B.var_8B3B = 0;
        level.var_3C3B.var_8B3C = 0;
        level.var_3C3B.var_6F48 = 0;
        param_00 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
        param_00 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
        param_00 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
      } else {
        level.var_3C3B.var_8BB1 = 1;
        level.var_3C3B.var_8B3B = var_02;
      }

      if(isDefined(param_00.var_29E2)) {
        var_03 = param_00.var_29E2;
        if(var_01 < param_00.var_29E2) {
          var_03 = var_01;
        }

        var_04 = level.var_3C3B.var_8B3C + var_03;
        if(var_04 > 9999) {
          level.var_3C3B.var_8B3C = 0;
        } else if(var_04 < 0) {
          level.var_3C3B.var_8B3C = 0;
        } else {
          level.var_3C3B.var_8B3C = var_04;
        }

        param_00.var_29E2 = 0;
      }
    }
  }
}

func_6399(param_00) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    param_00 waittill("grenade_fire", var_01);
    if(isDefined(var_01)) {
      waittillframeend;
      if(isDefined(var_01.var_7ACE) && var_01.var_7ACE) {
        continue;
      }

      var_02 = level.var_3C3B.var_8B3B + 1;
      if(var_02 > 9999) {
        level.var_3C3B.var_8B3B = 0;
        level.var_3C3B.var_8B3C = 0;
        level.var_3C3B.var_6F48 = 0;
        param_00 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
        param_00 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
        param_00 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
      } else if(var_02 < 0) {
        level.var_3C3B.var_8B3B = 0;
        level.var_3C3B.var_8B3C = 0;
        level.var_3C3B.var_6F48 = 0;
        param_00 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
        param_00 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
        param_00 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
      } else {
        level.var_3C3B.var_8BB1 = 1;
        level.var_3C3B.var_8B3B = var_02;
      }
    }
  }
}

func_639C(param_00) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  for(;;) {
    if(level.var_3C3B.var_8B3B > 0) {
      var_01 = level.var_3C3B.var_8B3C / level.var_3C3B.var_8B3B * 100;
      var_01 = common_scripts\utility::func_7F03(var_01, 0);
      if(var_01 != level.var_3C3B.var_6F48) {
        if(var_01 > 999) {
          var_01 = 999;
        } else if(var_01 < 0) {
          var_01 = 0;
        }

        level.var_3C3B.var_6F48 = int(var_01);
        level.var_3C3B.var_8BB1 = 1;
      }
    }

    wait 0.05;
  }
}

func_3004(param_00, param_01) {
  param_00 endon("disconnect");
  level endon("shutdown_hologram");
  var_02 = func_3B8B(level.var_3C3B.var_0BD8, param_01);
  if(isDefined(var_02)) {
    var_02 method_805B();
  }

  for(;;) {
    if(level.var_3C3B.var_8BB1 == 1) {
      param_00 setclientomnvar("ui_vlobby_round_damage", level.var_3C3B.var_29BB);
      param_00 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
      param_00 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
      param_00 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
      level.var_3C3B.var_8BB1 = 0;
    }

    wait(0.2);
  }
}

func_3B8B(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(isDefined(var_03.var_81E1) && var_03.var_81E1 == param_01) {
      return var_03;
    }
  }
}

func_9301(param_00) {
  level endon("shutdown_hologram");
  level notify("start_round");
  level.var_3C3B.var_29BB = 0;
  level.var_3C3B.var_7A64 = 0;
  level.var_3C3B.var_99DA = 0;
  level.var_3C3B.var_7F12 = 1;
  level.var_3C3B.var_8BB1 = 1;
  self setclientomnvar("ui_vlobby_round_distance", level.var_3C3B.var_7A64);
  self setclientomnvar("ui_vlobby_round_damage", level.var_3C3B.var_29BB);
  self setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
  self setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
  self setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
  foreach(var_02 in level.var_3C3B.var_0C3A[param_00]) {
    foreach(var_04 in var_02) {
      var_04.var_0116 = var_04.var_6C4F;
      var_04.var_001D = var_04.var_6C4D;
    }
  }

  if(level.var_010B) {
    func_8C14(param_00);
  } else {
    var_07 = func_8C26(param_00);
    wait(0.1);
    func_3D67(level.var_3C3B.var_0BDC[param_00]);
    func_3D67(level.var_3C3B.var_0BDC[param_00]);
    wait(0.1);
    func_3D67(level.var_3C3B.var_0BDC[param_00]);
    wait(0.1);
    func_4D1A(param_00, var_07);
    wait(0.1);
    func_8C14(param_00);
  }

  if(param_00 == 7) {
    self setclientomnvar("ui_vlobby_round_state", 3);
    thread func_9838(param_00);
    return;
  }

  self setclientomnvar("ui_vlobby_round_state", 1);
  thread func_089E(param_00);
}

func_8C14(param_00) {
  level endon("shutdown_hologram");
  var_01 = common_scripts\utility::func_7F03(level.var_3C3B.var_0BDC[param_00].size / level.var_3C3B.var_4895, 0, "up");
  var_02 = 0;
  foreach(var_04 in level.var_3C3B.var_0BDC[param_00]) {
    var_04 method_805B();
    var_04 solid();
  }
}

func_8C27(param_00) {
  level endon("shutdown_hologram");
  level.var_3C3B.var_9C7D = [];
  foreach(var_02 in param_00) {
    if(isDefined(var_02) && !function_0279(var_02) && isDefined(var_02.var_003A) && var_02.var_003A == "script_model") {
      if(isDefined(var_02.var_0106) && issubstr(var_02.var_0106, "_trans")) {
        var_03 = var_02.var_0106 + "_rev";
        var_04 = spawn("script_model", var_02.var_0116);
        level.var_3C3B.var_9C7D[level.var_3C3B.var_9C7D.size] = var_04;
        if(isDefined(var_02.var_001D)) {
          var_04.var_001D = var_02.var_001D;
        } else {
          var_04.var_001D = (0, 0, 0);
        }

        var_04 setModel(var_03);
        var_04 notsolid();
      }
    }
  }
}

func_8C25(param_00) {
  level endon("shutdown_hologram");
  level.var_3C3B.var_9C7C = [];
  foreach(var_02 in level.var_3C3B.var_0BDC[param_00]) {
    if(isDefined(var_02.var_003A) && var_02.var_003A == "script_model") {
      if(isDefined(var_02.var_0106) && issubstr(var_02.var_0106, "rec_holo_range")) {
        var_03 = var_02.var_0106 + "_trans";
        var_04 = spawn("script_model", var_02.var_0116);
        level.var_3C3B.var_9C7C[level.var_3C3B.var_9C7C.size] = var_04;
        if(isDefined(var_02.var_001D)) {
          var_04.var_001D = var_02.var_001D;
        } else {
          var_04.var_001D = (0, 0, 0);
        }

        var_04 setModel(var_03);
        var_04 notsolid();
      }
    }
  }
}

func_3D67(param_00) {
  level endon("shutdown_hologram");
  if(isDefined(param_00) && isarray(param_00)) {
    func_4D11(param_00);
    wait 0.05;
    func_8C0C(param_00);
    wait 0.05;
  }
}

func_8C0C(param_00) {
  level endon("shutdown_hologram");
  foreach(var_02 in param_00) {
    if(isDefined(var_02) && !function_0279(var_02)) {
      var_02 method_805B();
      var_02 notsolid();
    }
  }
}

func_4D11(param_00) {
  level endon("shutdown_hologram");
  foreach(var_02 in param_00) {
    if(isDefined(var_02) && !function_0279(var_02)) {
      var_02 method_805C();
      var_02 notsolid();
    }
  }
}

func_4D19() {
  if(isarray(level.var_3C3B.var_9C7C)) {
    level.var_3C3B.var_9C7C = common_scripts\utility::func_0F97(level.var_3C3B.var_9C7C);
    foreach(var_01 in level.var_3C3B.var_9C7C) {
      if(isDefined(var_01) && !function_0279(var_01)) {
        var_01 method_805C();
        var_01 notsolid();
      }
    }
  }
}

func_2D55() {
  if(isarray(level.var_3C3B.var_9C7D)) {
    level.var_3C3B.var_9C7D = common_scripts\utility::func_0F97(level.var_3C3B.var_9C7D);
    foreach(var_01 in level.var_3C3B.var_9C7D) {
      if(isDefined(var_01) && !function_0279(var_01)) {
        var_01 delete();
      }
    }
  }

  level.var_3C3B.var_9C7D = [];
}

func_7D00() {
  if(isarray(level.var_3C3B.var_9C7C)) {
    var_00 = common_scripts\utility::func_0F97(level.var_3C3B.var_9C7C);
    func_3D67(var_00);
    func_3D67(var_00);
    wait(0.1);
    func_3D67(var_00);
    wait(0.1);
    func_3D67(var_00);
    foreach(var_02 in var_00) {
      if(isDefined(var_02) && !function_0279(var_02)) {
        var_02 delete();
      }
    }
  }
}

func_7CF7() {
  if(isarray(level.var_3C3B.var_808A)) {
    level.var_3C3B.var_808A = common_scripts\utility::func_0F97(level.var_3C3B.var_808A);
    foreach(var_01 in level.var_3C3B.var_808A) {
      if(isDefined(var_01) && !function_0279(var_01)) {
        var_01 delete();
      }
    }
  }
}

func_64A8() {
  level endon("shutdown_hologram");
  var_00 = randomfloatrange(0, 1);
  wait(var_00);
  self setModel("rec_holo_emitter_floor_on");
  self moveto(self.var_A08D, 0.25, 0.1, 0.1);
}

func_64A7() {
  level endon("start_round");
  self setModel("rec_holo_emitter_floor_off");
  var_00 = randomfloatrange(0, 1);
  wait(var_00);
  self moveto(self.var_6A23, 0.25, 0.1, 0.1);
}

func_8C35(param_00, param_01) {
  level notify("shutdown_hologram");
  level.var_3C3B.var_57CC = 1;
  param_01 setclientomnvar("ui_vlobby_round_state", 0);
  param_01 setclientomnvar("ui_vlobby_round_timer", 0);
  param_01 setclientomnvar("ui_vlobby_round_damage", 0);
  param_01 setclientomnvar("ui_vlobby_round_distance", 0);
  param_01 setclientomnvar("ui_vlobby_round_hits", 0);
  param_01 setclientomnvar("ui_vlobby_round_fired", 0);
  param_01 setclientomnvar("ui_vlobby_round_accuracy", 0);
  param_01 thread func_4864(1);
  foreach(var_03 in level.var_3C3B.var_0BDC[param_00]) {
    var_03 method_805C();
    var_03 notsolid();
  }

  if(level.var_010B) {
    thread maps\mp\_utility::func_5C99("lt_shootingrange", 0.25, 6000);
  }

  thread maps\mp\_utility::func_5C98("lt_shootingrange_bounce", 0.25, 3000);
  thread maps\mp\_utility::func_5C98("lt_hologram_blue", 0.25, 0.01);
  foreach(var_06 in level.var_3C3B.var_0C3A[param_00]) {
    foreach(var_0B, var_08 in var_06) {
      if(var_08.var_0BC0 == 1) {
        var_09 = var_08.var_0116;
        var_0A = var_08.var_001D;
        thread func_6E9B(level.var_3C3B.var_A48E, var_09, var_0A, 3);
      }

      var_08 method_808C();
      var_08.var_0B6E method_81D3();
      var_08.var_0116 = var_08.var_6C4F;
      var_08.var_001D = var_08.var_6C4D;
      var_08.var_0B6E method_805C();
      var_08.var_0B6E notsolid();
      var_08 method_805C();
      var_08 notsolid();
      var_08.var_A580 method_805C();
      var_08.var_A580 notsolid();
      var_08.var_0BC0 = 0;
    }
  }

  foreach(var_0E in level.var_3C3B.var_0BD8) {
    var_0E method_805C();
  }

  level.var_3C3B.var_621E = undefined;
  level.var_3C3B.var_6095 = undefined;
  level.var_3C3B.var_621F = undefined;
  level.var_3C3B.var_76AE = 0;
  level.var_3C3B.var_76AF = 0;
  level.var_3C3B.var_29BB = 0;
  level.var_3C3B.var_7A64 = 0;
  level.var_3C3B.var_8B3B = 0;
  level.var_3C3B.var_8B3C = 0;
  level.var_3C3B.var_6F48 = 0;
  level.var_3C3B.var_7F12 = 0;
  level.var_3C3B.var_8BB1 = 1;
  param_01 setclientomnvar("ui_vlobby_round_distance", level.var_3C3B.var_7A64);
  param_01 setclientomnvar("ui_vlobby_round_damage", level.var_3C3B.var_29BB);
  param_01 setclientomnvar("ui_vlobby_round_hits", level.var_3C3B.var_8B3C);
  param_01 setclientomnvar("ui_vlobby_round_fired", level.var_3C3B.var_8B3B);
  param_01 setclientomnvar("ui_vlobby_round_accuracy", level.var_3C3B.var_6F48);
  level.var_3C3B.var_57CC = 0;
}

func_90AA() {
  level endon("shutdown_hologram");
  var_00 = self.var_0116;
  var_01 = self.var_001D;
  thread func_6E9B(level.var_3C3B.var_A48D, var_00, var_01, 3);
  wait 0.05;
  self solid();
  self.var_A580 method_805B();
}

func_8087() {
  level notify("ScaleSoundsOnExit");
  level endon("ScaleSoundsOnExit");
  if(isDefined(self.var_50CA)) {
    for(;;) {
      wait 0.05;
      if(self.var_50CA == 1 || getdvarint("2454", 0) == 1) {
        continue;
      } else {
        level.var_3C3B.var_8F41 = common_scripts\utility::func_0F97(level.var_3C3B.var_8F41);
        foreach(var_01 in level.var_3C3B.var_8F41) {
          var_01 method_861B(0, 0.5);
        }
      }
    }
  }
}

func_37B1(param_00) {
  param_00.var_50CA = 1;
  thread func_A673(0.4, param_00);
}

func_A673(param_00, param_01) {
  param_01 endon("enter_lobby");
  if(!level.var_A220) {
    wait(param_00);
  }

  param_01 setclientomnvar("ui_vlobby_round_state", 0);
  param_01 setclientomnvar("ui_vlobby_round_timer", 0);
  param_01 setclientomnvar("ui_vlobby_round_damage", 0);
  param_01 setclientomnvar("ui_vlobby_round_distance", 0);
  param_01 setclientomnvar("ui_vlobby_round_hits", 0);
  param_01 setclientomnvar("ui_vlobby_round_fired", 0);
  param_01 setclientomnvar("ui_vlobby_round_accuracy", 0);
  if(!level.var_A220) {
    param_01 unlink();
    param_01 method_81E3();
  }

  var_02 = getgroundposition(level.var_3C3B.var_3E6C.var_0116, 20, 512, 120);
  param_01 method_808C();
  param_01 setorigin(var_02);
  param_01 setangles(level.var_3C3B.var_3E6C.var_001D);
  param_01 setclientdvar("3078", "1.0");
  level.var_3C3B.var_57CC = 0;
  maps\mp\hub_vl_camera::func_A558(param_01.var_13B3.var_6DAC, "lobby" + param_01.var_294D + 1, 1, 1);
  maps\mp\_utility::func_A165("playing");
  param_01 visionsetnakedforplayer("mp_vlobby_room_fr", 0);
  param_01 thread maps\mp\hub_vl_base::func_3639();
  level.var_3C3B.var_8F41 = [];
  param_01 thread func_8087();
  if(maps\mp\gametypes\_class::func_5826(maps\mp\_utility::func_44CD(param_01.var_5DF5), 0) && !maps\mp\gametypes\_class::func_5682(param_01.var_5DF5.var_48CA)) {
    param_01 thread func_6311(maps\mp\_utility::func_44CD(param_01.var_5DF5), 0);
  }

  if(maps\mp\gametypes\_class::func_5826(maps\mp\_utility::func_44CD(param_01.var_5DF8), 0) && !maps\mp\gametypes\_class::func_5682(param_01.var_5DF8.var_48CA)) {
    param_01 thread func_6311(maps\mp\_utility::func_44CD(param_01.var_5DF8), 1);
  }

  if(param_01.var_7704 != "specialty_null" && param_01.var_7704 != "none" && param_01.var_7704 != "combatknife_mp" && !issubstr(param_01.var_7704, "em1") && !issubstr(param_01.var_7704, "epm3") && !issubstr(param_01.var_7704, "dlcgun1_mp") && !issubstr(param_01.var_7704, "dlcgun1loot")) {
    param_01 thread func_635E(param_01.var_7704);
    if(issubstr(param_01.var_7704, "_gl")) {
      param_01 thread func_635E("alt_" + param_01.var_7704);
    }
  }

  if(param_01.var_835A != "specialty_null" && param_01.var_835A != "none" && param_01.var_835A != "combatknife_mp" && !issubstr(param_01.var_835A, "em1") && !issubstr(param_01.var_835A, "epm3") && !issubstr(param_01.var_7704, "dlcgun1_mp") && !issubstr(param_01.var_7704, "dlcgun1loot")) {
    param_01 thread func_635E(param_01.var_835A);
    if(issubstr(param_01.var_835A, "_gl")) {
      param_01 thread func_635E("alt_" + param_01.var_835A);
    }
  }
}

func_47A5() {
  self endon("enter_lobby");
  wait(2);
  var_00 = getdvarint("2454", 0);
  if(var_00 == 1 && self.var_50CA == 1) {
    self method_812B(1);
  }
}

func_089E(param_00) {
  level endon("shutdown_hologram");
  var_01 = self;
  level.var_3C3B.var_5B57 = undefined;
  thread func_63EE(var_01);
  thread func_63E2(var_01);
  thread func_639C(var_01);
  foreach(var_03 in level.var_3C3B.var_0C3A[param_00]) {
    foreach(var_05 in var_03) {
      var_05 thread func_6377(var_01);
    }
  }

  thread func_3004(var_01, param_00);
  var_08 = level.var_3C3B.var_0C3A[param_00].size;
  var_09 = level.var_3C3B.var_0C3A[param_00];
  for(var_0A = 0; var_0A < var_08; var_0A++) {
    thread func_930C(var_09[var_0A], var_01);
    level waittill("wave_done");
    wait 0.05;
  }

  level notify("round_done");
  level.var_3C3B.var_7F12 = 0;
  var_01 setclientomnvar("ui_vlobby_round_state", 2);
}

func_63EE(param_00) {
  level endon("shutdown_hologram");
  level endon("round_done");
  var_01 = maps\mp\_utility::func_46E3();
  for(;;) {
    var_02 = maps\mp\_utility::func_46E3();
    var_03 = var_02 - var_01;
    var_04 = common_scripts\utility::func_7F03(var_03 / 1000, 1);
    if(var_04 > 9999.9) {
      level.var_3C3B.var_99DA = 0;
      param_00 setclientomnvar("ui_vlobby_round_timer", level.var_3C3B.var_99DA);
      param_00 setclientomnvar("ui_vlobby_round_state", 0);
      thread func_8C35(level.var_3C3B.var_7F1F, param_00);
      return;
    } else if(var_04 < 0) {
      level.var_3C3B.var_99DA = 0;
      param_00 setclientomnvar("ui_vlobby_round_timer", level.var_3C3B.var_99DA);
      param_00 setclientomnvar("ui_vlobby_round_state", 0);
      thread func_8C35(level.var_3C3B.var_7F1F, param_00);
      return;
    } else {
      level.var_3C3B.var_99DA = var_04;
      param_00 setclientomnvar("ui_vlobby_round_timer", level.var_3C3B.var_99DA);
    }

    wait 0.05;
  }
}

func_930C(param_00, param_01) {
  level endon("shutdown_hologram");
  if(getdvarint("scr_target_bots", 0) > 0) {
    level.var_8C7A = 1;
    level.var_0A41["player"]["think"] = ::func_3765;
    level.var_0A41["player"]["on_damaged_finished"] = ::func_3764;
  }

  var_02 = 0;
  foreach(var_04 in param_00) {
    if(getdvarint("scr_target_bots", 0) > 0) {
      var_04 thread func_9800(param_01);
      continue;
    }

    var_04 thread func_980F(param_01);
  }

  for(;;) {
    level waittill("target_died");
    var_02++;
    if(var_02 == param_00.size) {
      level notify("wave_done");
      return;
    }
  }
}

func_980F(param_00) {
  level endon("shutdown_hologram");
  self.var_6C4F = self.var_0116;
  self.var_6C4D = self.var_001D;
  self.var_0BC0 = 1;
  func_90AA();
  thread func_980D(param_00);
  thread func_9810();
  thread func_980B();
  thread func_980C();
}

func_9800(param_00) {
  level endon("shutdown_hologram");
  var_01 = spawnStruct();
  var_01.var_0116 = self.var_0116;
  var_01.var_001D = self.var_001D;
  var_02 = func_9000(var_01.var_0116, var_01.var_001D, param_00);
  if(isDefined(var_02)) {
    var_02 thread func_9801();
    var_02 thread func_9802();
  }
}

func_9000(param_00, param_01, param_02) {
  var_03 = maps\mp\agents\_agents::func_0933("player", game["defenders"], undefined, param_00, param_01, undefined, undefined, 0, undefined, undefined);
  if(isDefined(var_03)) {
    var_04 = 1;
    var_03 method_8528(var_04, maps\mp\_utility::func_45DE(param_02.var_01A7));
    var_03 method_83E1("cloth");
    var_03 func_861F(var_04, maps\mp\_utility::func_45DE(param_02.var_01A7));
  }

  return var_03;
}

func_861F(param_00, param_01) {
  for(var_02 = 0; var_02 < level.var_2683.size; var_02++) {
    if(param_01 == "allies") {
      var_03 = 0;
    } else {
      var_03 = 6;
    }

    var_04 = tablelookupbyrow("mp/agentcostumetable.csv", var_02 + var_03, param_00);
    self.var_267E[var_02] = int(tablelookup("mp/costumeIdTable.csv", 7, var_04, 4));
  }
}

func_3765() {
  self endon("death");
  level endon("game_ended");
  self botsetflag("no_enemy_search", 1);
  self botsetflag("disable_movement", 1);
  self botsetflag("disable_rotation", 1);
  self botsetflag("disable_attack", 1);
}

func_3764(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(param_01)) {
    var_0B = length(self.var_0116 - param_01.var_0116);
  } else {
    var_0B = 0;
  }

  iprintln(self.var_0109 + " " + param_08 + " has been hit for " + param_02 + " at " + var_0B);
  return maps\mp\agents\_agents::func_0A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_6E9B(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  var_05 = spawnfx(param_00, param_01, anglesToForward(param_02), anglestoup(param_02));
  if(isDefined(param_04)) {
    function_014E(var_05, param_04);
  }

  triggerfx(var_05);
  if(isDefined(param_03)) {
    wait(param_03);
    if(isDefined(var_05) && !function_0279(var_05)) {
      var_05 delete();
      return;
    }

    return;
  }

  level waittill("shutdown_hologram");
  if(isDefined(var_05) && !function_0279(var_05)) {
    var_05 delete();
  }
}

func_9810() {
  level endon("shutdown_hologram");
  self endon("death");
  if(isDefined(self.var_8260)) {
    var_00 = self.var_8260;
    func_64D0();
    switch (var_00) {
      case "stand":
        break;

      case "cover":
        thread func_7574();
        break;

      case "move":
        thread func_649E();
        break;
    }
  }
}

func_64D0() {
  level endon("shutdown_hologram");
  self endon("death");
  if(!isDefined(level.var_3C3B.var_7F1F)) {
    return;
  }

  var_00 = level.var_3C3B.var_7F1F;
  if(!isDefined(level.var_3C3B.var_0C37[var_00])) {
    return;
  }

  var_01 = common_scripts\utility::func_4461(self.var_0116, level.var_3C3B.var_0C37[var_00]);
  self.var_28F5 = var_01;
  self.var_5B23 = self.var_28F5;
  for(;;) {
    if(isDefined(self)) {
      var_02 = distance(self.var_28F5.var_0116, self.var_0116);
      var_03 = var_02 / level.var_3C3B.var_7F0E;
      if(var_03 < 0.5) {
        var_03 = 0.5;
      }

      if(isDefined(self.var_28F5.var_0165) && self.var_28F5.var_0165 == "jump") {
        self moveto(self.var_28F5.var_0116, var_03 * 0.5, 0, 0.1);
      } else if(isDefined(self.var_5B23.var_0165) && self.var_5B23.var_0165 == "jump") {
        self moveto(self.var_28F5.var_0116, var_03 * 0.5, 0.1, 0);
      } else {
        self moveto(self.var_28F5.var_0116, var_03);
      }

      self waittill("movedone");
      if(isDefined(self.var_28F5.var_01A2)) {
        var_04 = getent(self.var_28F5.var_01A2, "targetname");
        self.var_5B23 = self.var_28F5;
        self.var_28F5 = var_04;
      } else {
        return;
      }

      continue;
    }
  }
}

func_7574() {
  level endon("shutdown_hologram");
  self endon("death");
  var_00 = 4;
  var_01 = 1;
  var_02 = self.var_28F5.var_0116;
  var_03 = self.var_5B23.var_0116;
  if(self.var_28F5 == self.var_5B23) {
    var_03 = self.var_6C4F;
  }

  wait(var_00);
  for(;;) {
    if(isDefined(self)) {
      var_04 = distance(var_03, var_02);
      var_05 = var_04 / level.var_3C3B.var_7F0E;
      self moveto(var_03, var_05);
      self waittill("movedone");
      wait(var_01);
      var_04 = distance(var_03, var_02);
      var_05 = var_04 / level.var_3C3B.var_7F0E;
      self moveto(var_02, var_05);
      self waittill("movedone");
      wait(var_00);
    }
  }
}

func_649E() {
  level endon("shutdown_hologram");
  self endon("death");
  var_00 = undefined;
  var_01 = undefined;
  if(isDefined(self.var_5B23.var_0165) && self.var_5B23.var_0165 == "jump") {
    var_00 = self.var_5B23;
    var_01 = var_00.var_0116;
    self.var_5B23 = getent(var_00.var_01A5, "target");
  }

  var_02 = self.var_28F5.var_0116;
  var_03 = self.var_5B23.var_0116;
  if(self.var_28F5 == self.var_5B23) {
    var_03 = self.var_6C4F;
  }

  for(;;) {
    if(isDefined(self)) {
      if(isDefined(var_01)) {
        wait(2);
        var_04 = distance(var_01, var_02);
        var_05 = var_04 / level.var_3C3B.var_7F0E;
        self moveto(var_01, var_05 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_04 = distance(var_01, var_03);
        var_05 = var_04 / level.var_3C3B.var_7F0E;
        self moveto(var_03, var_05 * 0.5, 0.1, 0);
        self waittill("movedone");
        wait(2);
        var_04 = distance(var_01, var_03);
        var_05 = var_04 / level.var_3C3B.var_7F0E;
        self moveto(var_01, var_05 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_04 = distance(var_01, var_02);
        var_05 = var_04 / level.var_3C3B.var_7F0E;
        self moveto(var_02, var_05 * 0.5, 0.1, 0);
        self waittill("movedone");
      } else {
        var_04 = distance(var_05, var_04);
        var_05 = var_05 / level.var_3C3B.var_7F0E;
        self moveto(var_03, var_05);
        self waittill("movedone");
        var_04 = distance(var_02, var_03);
        var_05 = var_04 / level.var_3C3B.var_7F0E;
        self moveto(var_02, var_05);
        self waittill("movedone");
      }
    }
  }
}

func_80A5() {
  level endon("shutdown_hologram");
  for(;;) {
    var_00 = [];
    for(var_01 = 0; var_01 < self.var_4DDE.size; var_01++) {
      self.var_4DDE[var_01].var_99DA = self.var_4DDE[var_01].var_99DA - 1;
      if(self.var_4DDE[var_01].var_99DA > 0) {
        var_00[var_00.size] = self.var_4DDE[var_01];
      }
    }

    self.var_4DDE = var_00;
    foreach(var_03 in self.var_4DDE) {}

    wait 0.05;
  }
}

func_980D(param_00) {
  level endon("shutdown_hologram");
  self.var_4DDE = [];
  self.var_0B6E.var_00BC = 9999;
  self.var_0B6E.var_00FB = 9999;
  self.var_00FB = 9999;
  self.var_00BC = self.var_00FB;
  self.var_3A09 = 100;
  self setCanDamage(1);
  self.var_0B6E method_805B();
  self.var_0B6E solid();
  self.var_0B6E method_81B0();
  self.var_A580 method_805B();
  while(self.var_00BC > 0) {
    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = undefined;
    var_07 = undefined;
    var_08 = undefined;
    var_09 = undefined;
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    var_0B = func_4591(var_0A, var_08, param_00);
    var_0C = self gettagorigin("tag_head");
    var_0D = self gettagorigin("tag_chest");
    self.var_00BC = self.var_00FB;
    var_0E = self.var_3A09;
    var_0E = float(var_0E) - float(var_01) * var_0B;
    var_0E = common_scripts\utility::func_7F03(var_0E, 0);
    self.var_3A09 = int(var_0E);
    if(self.var_3A09 <= 0) {
      thread func_9833(var_0D);
      self.var_00BC = 0;
      if(isDefined(var_02)) {
        if(isDefined(var_08)) {
          if(var_08 == "tag_head") {
            var_02 maps\mp\gametypes\_damagefeedback::func_A102("killshot_headshot");
          } else if(var_08 == "tag_chest") {
            var_02 maps\mp\gametypes\_damagefeedback::func_A102("mp_hit_kill");
          }
        }
      }

      self notify("death");
      continue;
    }

    if(isDefined(var_02)) {
      if(isDefined(var_08) && var_08 == "tag_head") {
        var_02 maps\mp\gametypes\_damagefeedback::func_A102("headshot");
        continue;
      }

      var_02 maps\mp\gametypes\_damagefeedback::func_A102("standard");
    }
  }
}

func_9803() {
  level endon("shutdown_hologram");
  self.var_4DDE = [];
  while(isDefined(self) && self.var_00BC > 0) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  }
}

func_9833(param_00) {
  playFX(level.var_0611["recovery_scoring_target_shutter_enemy"], param_00);
}

func_2A72() {
  level notify("shutdown_hologram");
}

func_3C37() {
  var_00 = getEntArray("firing_range_round_trigger", "targetname");
  return var_00;
}

func_3C35() {
  var_00 = getEntArray("target_logic_point", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_81E1)) {
      var_04 = int(var_03.var_81E1);
      if(!isarray(var_01[var_04])) {
        var_05 = [var_03];
        var_01[var_04] = var_05;
      } else {
        var_01[var_04] = common_scripts\utility::func_0972(var_01[var_04], var_03);
      }
    }
  }

  return var_01;
}

func_3C30() {
  var_00 = getEntArray("round_environment", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_03 method_805C();
    var_03 notsolid();
    var_04 = undefined;
    if(isDefined(var_03.var_81E1)) {
      var_04 = int(var_03.var_81E1);
    }

    if(isDefined(var_04)) {
      if(!isarray(var_01[var_04])) {
        var_05 = [var_03];
        var_01[var_04] = var_05;
        continue;
      }

      var_01[var_04] = common_scripts\utility::func_0972(var_01[var_04], var_03);
    }
  }

  return var_01;
}

func_3C31() {
  var_00 = common_scripts\utility::func_46B7("round_environment", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = undefined;
    if(isDefined(var_03.var_81E1)) {
      var_04 = int(var_03.var_81E1);
    }

    if(isDefined(var_04)) {
      if(!isarray(var_01[var_04])) {
        var_05 = [var_03];
        var_01[var_04] = var_05;
        continue;
      }

      var_01[var_04] = common_scripts\utility::func_0972(var_01[var_04], var_03);
    }
  }

  return var_01;
}

func_3C36() {
  var_00 = getEntArray("target_enemy", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_03.var_0BC0 = 0;
    var_03.var_012C["team"] = "axis";
    var_03.var_01A7 = "axis";
    var_03.var_6C3E = getent(var_03.var_01A2, "targetname");
    var_03.var_0B6E = getent(var_03.var_6C3E.var_01A2, "targetname");
    var_03.var_0B6E method_8449(var_03);
    var_03.var_0B6E.var_012C["team"] = "axis";
    var_03.var_0B6E.var_01A7 = "axis";
    if(isDefined(var_03.var_0B6E.var_01A2)) {
      var_03.var_A580 = getent(var_03.var_0B6E.var_01A2, "targetname");
      var_03.var_A580 method_8449(var_03);
    } else {
      var_03.var_A580 = var_03;
    }

    var_03.var_6C4F = var_03.var_0116;
    var_03.var_6C4D = var_03.var_001D;
    var_03.var_0B6E method_805C();
    var_03.var_0B6E notsolid();
    var_03 method_805C();
    var_03 notsolid();
    var_03.var_A580 method_805C();
    var_03.var_A580 notsolid();
    if(isDefined(var_03.var_81E1)) {
      var_04 = int(var_03.var_81E1);
      if(!isarray(var_01[var_04])) {
        var_05 = [];
        var_01[var_04] = var_05;
      }

      if(isDefined(var_03.var_81D2)) {
        var_06 = int(var_03.var_81D2);
        if(!isarray(var_01[var_04][var_06])) {
          var_07 = [var_03];
          var_01[var_04][var_06] = var_07;
        } else {
          var_01[var_04][var_06] = common_scripts\utility::func_0972(var_01[var_04][var_06], var_03);
        }
      }
    }
  }

  return var_01;
}

func_980B() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
  func_9819();
}

func_9801() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
}

func_980C() {
  self endon("death");
  level waittill("shutdown_hologram");
  func_9819();
}

func_9802() {
  self endon("death");
  level waittill("shutdown_hologram");
  maps\mp\agents\_agent_utility::func_5A28(self);
}

func_9819() {
  self setCanDamage(0);
  self method_805C();
  self notsolid();
  self.var_0BC0 = 0;
  if(isDefined(self.var_0B6E)) {
    self.var_0B6E method_81D3();
  }

  if(isDefined(self.var_A580)) {
    self.var_A580 method_805C();
  }
}

func_635E(param_00) {
  self endon("enter_lobby");
  while(self.var_50CA == 1) {
    var_01 = self getfractionmaxammo(param_00);
    if(var_01 <= 0.25) {
      self givemaxammo(param_00);
      continue;
    }

    wait(0.5);
  }
}

func_4864(param_00) {
  if(isDefined(level.var_486C) && isarray(level.var_486C)) {
    foreach(var_02 in level.var_486C) {
      if(isDefined(var_02) && !function_0279(var_02)) {
        if(!isDefined(self) || !isDefined(var_02.var_0117) || function_0279(var_02.var_0117)) {
          if(!isDefined(var_02.var_A9E0)) {
            continue;
          } else {
            var_02 notify("death");
            var_02 thread func_2CC3();
          }

          continue;
        }

        if(var_02.var_0117 == self) {
          if(!isDefined(var_02.var_A9E0)) {
            continue;
          } else {
            var_02 notify("death");
            var_02 thread func_2CC3();
          }
        }
      }
    }
  }
}

func_2CC3() {
  wait 0.05;
  if(isDefined(self) && !function_0279(self)) {
    self delete();
  }
}

func_6311(param_00, param_01) {
  self endon("enter_lobby");
  while(level.var_50CA == 1) {
    wait(1.5);
    var_02 = self method_817F(param_00);
    if(var_02 == 0) {
      maps\mp\gametypes\_class::func_479F(param_00);
      continue;
    }

    wait(0.5);
  }
}

func_8C26(param_00) {
  level endon("shutdown_hologram");
  var_01 = 0;
  var_02 = [];
  foreach(var_04 in level.var_3C3B.var_0BDC[param_00]) {
    if(isDefined(var_04.var_003A) && var_04.var_003A == "script_model") {
      if(isDefined(var_04.var_0106) && issubstr(var_04.var_0106, "rec_holo_range")) {
        var_02[var_01] = var_04.var_0106;
        if(!issubstr(var_04.var_0106, "trans")) {
          var_05 = var_04.var_0106 + "_trans";
          var_04 setModel(var_05);
        }

        var_04 method_805B();
      } else {
        var_02[var_01] = undefined;
      }
    }

    var_01++;
  }

  return var_02;
}

func_4D1A(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in level.var_3C3B.var_0BDC[param_00]) {
    if(isDefined(var_04.var_003A) && var_04.var_003A == "script_model") {
      if(isDefined(var_04.var_0106) && issubstr(var_04.var_0106, "rec_holo_range")) {
        if(isstring(param_01[var_02])) {
          var_04 method_805C();
          var_04 setModel(param_01[var_02]);
        }
      }
    }

    var_02++;
  }
}