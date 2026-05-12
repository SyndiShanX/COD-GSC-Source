/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1408.gsc
*********************************************/

lib_0580::func_00D5() {
  lib_0547::func_7BD0("tesla_shock", ::lib_0580::func_8316, undefined, 5, ::lib_0580::func_8315);
  common_scripts\utility::func_092C("shock", "vfx/sparks/tesla_stun_sparks");
  common_scripts\utility::func_092C("head_sparks", "vfx/sparks/microwave_grenade_sparks_char_1");
  lib_054D::func_7BC6(::lib_0580::func_98EC);
  var_00 = spawnStruct();
  var_00.var_6042 = 5;
  var_00.var_6053 = 5;
  var_00.var_78CA = 300;
  var_00.var_78C4 = 20;
  var_00.var_0F43 = 0.5;
  common_scripts\utility::func_3C87("teslagun_punch_active");
  level.var_98F5 = var_00;
  lib_0581::func_17FD();
  lib_0583::func_6402();
  lib_0584::func_9434();
  lib_0582::func_2A99();
}

lib_0580::func_98F6(param_00) {
  var_01 = self;
  var_01.var_721C = param_00;
  var_02 = param_00 common_scripts\utility::func_A74D("disconnect", 5);
  if(!lib_0547::func_5565("timeout", var_02)) {
    var_01.var_721C = undefined;
  }
}

lib_0580::func_98FD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(lib_0547::func_5565(param_02, param_00)) {
    return;
  }

  if(lib_0547::func_5565(param_02.var_000A, level.var_746E)) {
    return;
  }

  if(lib_0547::func_5565(param_04, "MOD_MELEE")) {
    return;
  }

  if(lib_0547::func_5565(param_02.var_98FE, lib_0580::func_4385())) {
    return;
  }

  if(common_scripts\utility::func_562E(param_02.var_6012)) {
    return;
  }

  var_08 = spawnStruct();
  var_08.var_953E = param_05;
  var_08.var_8CD7 = param_04;
  var_08.var_6B87 = param_06;
  var_08.var_4DCD = 0;
  var_08.var_94B3 = param_07;
  if(isDefined(param_01)) {
    var_08 thread lib_0580::func_98F6(param_01);
  }

  param_02 thread lib_0580::func_9900(param_02.var_0116, param_03, var_08, 1, param_01, param_04, param_05);
}

lib_0580::func_98EC(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(!isDefined(param_05)) {
    return;
  }

  var_0C = getweapondisplayname(param_05);
  if(!isDefined(var_0C)) {
    return;
  }

  if(var_0C != "teslagun_zm" && var_0C != "teslagun_pap_zm") {
    return;
  }

  if(lib_0547::func_5565(param_04, "MOD_MELEE")) {
    return;
  }

  if(param_02 == lib_0580::func_4382()) {
    return;
  }

  lib_0580::func_98FD(param_00, param_01, var_0B, "j_head", param_04, param_05, ::lib_0580::func_98FF);
}

lib_0580::func_9900(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  if(!isalive(var_07)) {
    return;
  }

  if(common_scripts\utility::func_562E(var_07.var_172A) || var_07 lib_0547::has_scripted_state_queued("tesla_shock")) {
    var_08 = 2000;
    if(isDefined(param_06) && issubstr(param_06, "teslagun_pap_zm")) {
      var_08 = 6000;
    }

    var_07 dodamage(var_08, param_00, param_04, var_07, param_05, param_06);
    return;
  }

  var_07 endon("death");
  wait(0);
  var_07.var_98FE = lib_0580::func_4385();
  if(var_07 maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    var_07 dodamage(var_07.var_00BC + 10, param_00, param_04, var_07, param_05, "dot_generic_zm");
    return;
  }

  if(self.var_0A4B != "zombie_heavy" && self.var_0A4B != "zombie_fireman") {
    var_09 = "shock";
    if(isDefined(param_02.var_94B3)) {
      var_09 = param_02.var_94B3;
    }

    var_07 thread play_shock_fx(var_09, "j_spine4", 4);
    thread play_shock_sound(4);
  }

  if(isDefined(var_07.var_98F0) && lib_0580::func_4385() < var_07.var_98F0) {
    var_07 lib_0580::func_9901();
  } else {
    var_07 childthread[[param_02.var_6B87]](param_00, param_02);
  }

  var_0A = level.var_98F5;
  wait(var_0A.var_0F43);
  var_0B = var_0A.var_78CA - var_0A.var_78C4 * param_03;
  var_0C = squared(var_0B);
  if(var_0B <= 0 || param_03 >= var_0A.var_6042) {
    return;
  }

  var_0D = var_07 gettagorigin(param_01);
  var_0E = lib_0580::func_4385();
  foreach(var_10 in lib_0547::func_408F()) {
    if(!isalive(var_10)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_10.var_5D5F)) {
      continue;
    }

    if(distancesquared(var_07.var_0116, var_10.var_0116) > var_0C) {
      continue;
    }

    if(isDefined(var_07.var_98FE) && var_0E - var_07.var_98FE < 1) {
      continue;
    }

    if(param_02.var_4DCD >= var_0A.var_6053) {
      break;
    }

    var_11 = "j_head";
    if(-1 == var_10 method_8445(var_11)) {
      var_11 = "j_spine4";
    }

    var_12 = var_10 gettagorigin(var_11);
    if(!bullettracepassed(var_0D, var_12, 0, var_07)) {
      continue;
    }

    param_02.var_4DCD++;
    lib_0580::func_98EA(var_07, param_01, var_10, var_11, var_0A.var_953E);
    var_10 thread lib_0580::func_9900(var_07.var_0116, var_11, param_02, param_03 + 1);
  }
}

play_shock_fx(param_00, param_01, param_02) {
  self endon("death");
  var_03 = 0;
  while(var_03 < param_02) {
    playFXOnTag(common_scripts\utility::func_44F5(param_00), self, param_01);
    wait(0.35);
    var_03 = var_03 + 0.35;
  }
}

play_shock_sound(param_00) {
  self notify("play_shock_sound");
  wait(0);
  thread lib_0378::func_8D74("aud_wonder_weapon_electrocute_strt");
  common_scripts\utility::func_A71B(param_00, "death", "play_shock_sound");
  thread lib_0378::func_8D74("aud_wonder_weapon_electrocute_end");
}

lib_0580::func_9901(param_00) {
  var_01 = 3;
  if(isDefined(param_00)) {
    var_01 = param_00;
  }

  var_02 = self;
  var_02.var_98F0 = lib_0580::func_4385() + var_01 + randomfloatrange(0.1, 0.6);
}

lib_0580::func_98FF(param_00, param_01) {
  var_02 = self;
  if(lib_0547::func_5565(var_02.var_0A4B, "zombie_fireman") || var_02 maps\mp\agents\humanoid\_humanoid_util::func_56BC() || common_scripts\utility::func_562E(var_02.isteslastunimmune)) {
    var_02 thread lib_0580::func_98EE(param_00, param_01.var_721C, param_01.var_8CD7, param_01.var_953E, 0);
    return;
  }

  var_03 = lib_0580::func_8317(param_00, param_01.var_721C);
  var_02 thread lib_0547::func_7D1A("tesla_shock", [var_03], 4);
}

lib_0580::func_98EE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  if(!isalive(var_07)) {
    return;
  }

  if(!isDefined(param_00)) {
    if(isDefined(param_01)) {
      param_00 = param_01.var_0116;
    } else if(isDefined(var_07)) {
      param_00 = var_07.var_0116;
    }
  }

  var_08 = "head_sparks";
  if(isDefined(param_05)) {
    var_08 = param_05;
  }

  foreach(var_0A in ["j_head", "j_spine4"]) {
    if(-1 == var_07 method_8445(var_0A)) {
      continue;
    }

    playFXOnTag(common_scripts\utility::func_44F5(var_08), var_07, var_0A);
    break;
  }

  var_0C = 2000;
  if(isDefined(param_03) && issubstr(param_03, "teslagun_pap_zm")) {
    var_0C = 6000;
  }

  if(isDefined(var_07.var_0A4B)) {
    var_0C = [[var_07 maps\mp\agents\_agent_utility::func_0A59("tesla_delayed_dmg")]](var_0C, param_04, param_06);
  }

  var_07 endon("death");
  var_07.var_172A = 0;
  if(!isDefined(param_03)) {
    param_03 = "teslagun_zm";
  }

  var_07 dodamage(var_0C, param_00, param_01, var_07, param_02, param_03);
}

lib_0580::func_4382() {
  return int(3);
}

lib_0580::func_98E9(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = lib_0547::func_408F();
  var_08 = squared(param_01);
  if(isDefined(param_03)) {
    var_07 = common_scripts\utility::func_0F93(var_07, param_03);
  }

  foreach(var_0A in var_07) {
    if(distancesquared(var_0A.var_0116, param_00) > var_08) {
      continue;
    }

    var_0A thread lib_0580::func_98EE(param_00, param_02, "MOD_ENERGY", param_04, 1, undefined, param_06);
  }

  radiusdamage(param_00, param_01, lib_0580::func_4382(), lib_0580::func_4382(), param_02, "MOD_ENERGY", param_04);
  physicsexplosioncylinder(param_00, param_01, 0, 1.7);
}

lib_0580::func_98FA(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.var_8FAD = param_01;
  var_05.var_9014 = param_02;
  var_05.var_606B = param_03;
  var_05.var_A0A7 = param_04;
  var_05.var_953E = param_00;
  level thread maps\mp\_utility::func_6F74(::lib_0580::func_98F9, var_05);
}

lib_0580::func_98F7(param_00) {
  var_01 = self;
  if(!isalive(param_00)) {
    return;
  }

  var_02 = undefined;
  foreach(var_04 in ["j_head", "j_spine4"]) {
    if(-1 == param_00 method_8445(var_04)) {
      continue;
    }

    var_02 = var_04;
    break;
  }

  if(!isDefined(var_02)) {
    return;
  }

  lib_0580::func_98EA(var_01, "tag_origin", param_00, var_02, var_01.var_953E);
}

lib_0580::func_98F8(param_00, param_01) {
  var_02 = self;
  param_00 thread lib_0580::func_98EE(var_02.var_0116, var_02.var_721C, "MOD_ENERGY", var_02.var_953E, 1, param_01);
}

lib_0580::func_98FC() {
  var_00 = self;
  var_00 endon("death");
  var_01 = 30;
  var_02 = [];
  var_03 = 0;
  for(;;) {
    wait 0.05;
    foreach(var_05 in lib_0547::func_408F()) {
      if(!isalive(var_05)) {
        continue;
      }

      var_06 = 30;
      if(isDefined(var_05.var_8303)) {
        var_06 = var_05.var_8303;
      }

      if(distance2d(var_05.var_0116, var_00.var_0116) > var_06 + var_01) {
        continue;
      }

      var_07 = 70;
      if(isDefined(var_05.var_8302)) {
        var_07 = var_05.var_8302;
      }

      if(var_00.var_0116[2] < var_05.var_0116[2] - var_01 || var_00.var_0116[2] > var_05.var_0116[2] + var_07 + var_01) {
        continue;
      }

      var_08 = var_05 getentitynumber();
      if(isDefined(var_02[var_08])) {
        continue;
      }

      var_02[var_08] = 1;
      if(issubstr(var_00.var_953E, "moon")) {
        var_00 lib_0583::func_63FC(var_05);
      } else {
        var_00 lib_0580::func_98F7(var_05);
        var_00 lib_0580::func_98F8(var_05);
      }

      var_03++;
      if(var_03 == 4) {
        var_03 = 0;
        wait 0.05;
      }
    }
  }
}

lib_0580::func_98F9(param_00) {
  var_01 = self;
  for(;;) {
    var_01 waittill("weapon_fired", var_02);
    if(!lib_0547::func_5565(var_02, param_00.var_953E)) {
      continue;
    }

    var_03 = [[param_00.var_8FAD]]();
    var_04 = [[param_00.var_9014]]();
    var_05 = [[param_00.var_606B]]();
    var_06 = var_01 geteyeangles();
    var_07 = anglesToForward(var_06);
    var_08 = anglestoup(var_06);
    var_09 = var_01 getEye() + var_07 * var_03 + var_08 * var_04;
    var_0A = bulletTrace(var_09, var_09 + var_05 * var_07, 0, undefined, 0, 0, 0, 0, 0, 0, 0);
    var_0B = spawn("script_model", var_09);
    var_0B.var_001D = var_01.var_001D;
    var_0B setModel("tag_origin");
    var_0B.var_2DA7 = var_0A["position"];
    var_0B.var_2F0C = vectornormalize(var_0B.var_2DA7 - var_0B.var_0116);
    var_0B.var_9B7F = var_0A["fraction"];
    var_0B.var_721C = var_01;
    var_0B.var_953E = param_00.var_953E;
    var_0B thread lib_0580::func_98FB();
    var_0B thread lib_0580::func_98FC();
    var_0B thread[[param_00.var_A0A7]]();
  }
}

lib_0580::func_98FB() {
  var_00 = self;
  var_00 endon("death");
  var_00.var_721C waittill("disconnect");
  var_00.var_721C = undefined;
}

tesla_ammo_tracker(param_00) {
  self endon("death");
  level endon(param_00 + "_stop_tracking");
  for(;;) {
    common_scripts\utility::func_A70C(self, "missile_fire", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");
    if(self hasweapon(param_00)) {
      self.var_A2AF[param_00] = self getweaponammostock(param_00);
      self.var_A2B0[param_00] = self getweaponammoclip(param_00);
    }
  }
}

tesla_drop_watcher(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  for(;;) {
    var_03 = param_00 common_scripts\utility::func_A715("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");
    if(var_03 == "weapon_change") {
      if(lib_0547::func_577E(param_00)) {
        continue;
      } else if(!lib_0547::func_73F9(param_00, param_01)) {
        if(param_02) {
          tesla_variant_set_available(param_01);
        }

        level notify(param_01 + "_stop_tracking");
        return;
      }

      continue;
    }

    if(var_03 == "bleedout" || var_03 == "becameSpectator" || var_03 == "disconnect") {
      if(param_02) {
        tesla_variant_set_available(param_01);
      }

      return;
    }
  }
}

init_variant_structs_simple() {
  if(!isDefined(level.var_AACA)) {
    level.var_AACA = [];
  }

  var_00 = lib_0580::func_43B4();
  foreach(var_02 in var_00) {
    level.var_AACA[var_02] = tesla_variant_struct_init(var_02);
  }
}

tesla_variant_struct_init(param_00) {
  var_01 = spawnStruct();
  var_01.var_A9E0 = param_00;
  var_01.var_2916 = "not built";
  var_01.var_2909 = undefined;
  return var_01;
}

tesla_variant_check_if_available(param_00) {
  if(!isDefined(param_00) || !isDefined(level.var_AACA) || !isDefined(level.var_AACA[param_00])) {}

  if(level.var_AACA[param_00].var_2916 == "available" || level.var_AACA[param_00].var_2916 == "not built") {
    return 1;
  }

  return 0;
}

tesla_variant_set_available(param_00) {
  level.var_AACA[param_00].var_2916 = "available";
  level.var_AACA[param_00].var_2909 = undefined;
}

tesla_variant_set_taken(param_00, param_01) {
  level.var_AACA[param_00].var_2916 = "taken";
  level.var_AACA[param_00].var_2909 = param_01;
}

lib_0580::func_5533(param_00) {
  if(!isstring(param_00)) {
    return 0;
  }

  return issubstr(param_00, "teslagun");
}

lib_0580::func_408C() {
  var_00 = common_scripts\utility::func_0F73(["teslagun_zm"], lib_0580::func_43B4());
  var_00 = common_scripts\utility::func_0F73(["teslagun_pap_zm"], var_00);
  return var_00;
}

lib_0580::func_43B4() {
  return ["teslagun_zm_blood", "teslagun_zm_death", "teslagun_zm_moon", "teslagun_zm_storm"];
}

lib_0580::func_563A(param_00) {
  if(!isstring(param_00)) {
    return 0;
  }

  return common_scripts\utility::func_0F79(lib_0580::func_43B4(), param_00);
}

lib_0580::func_4385() {
  var_00 = gettime();
  var_01 = var_00 * 0.001;
  return var_01;
}

lib_0580::func_40C5(param_00) {
  switch (param_00) {
    case "teslagun_zm_blood":
      return "zmb_tesla_blood_beam";

    case "teslagun_zm_moon":
      return "zmb_tesla_moon_beam";

    case "teslagun_zm_death":
      return "zmb_tesla_death_beam";

    case "teslagun_zm_storm":
      return "zmb_tesla_storm_beam";

    default:
      return "zmb_tesla_reg_beam";
  }
}

lib_0580::func_98EB(param_00, param_01, param_02, param_03, param_04) {
  var_05 = launchbeam(lib_0580::func_40C5(param_04), param_00, param_01, param_02, param_03);
  wait(level.var_98F5.var_0F43);
  var_05 delete();
}

lib_0580::func_98EA(param_00, param_01, param_02, param_03, param_04) {
  level thread lib_0580::func_98EB(param_00, param_01, param_02, param_03, param_04);
}

lib_0580::func_8317(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_29A8 = param_00;
  var_04.var_721C = param_01;
  var_04.var_6AA0 = param_02;
  var_04.var_8365 = param_03;
  return var_04;
}

lib_0580::func_8316(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01.var_98EF = 1;
  var_01.var_172A = 1;
  var_02 = "scripted_tesla_shock";
  if(var_01 maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    var_02 = "stun_hold";
  }

  var_03 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_02);
  if(isDefined(var_03)) {
    thread maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_0116, self.var_001D, var_03, undefined, 0, undefined, 1, 1, undefined, "stop_shock");
    var_01 lib_0580::func_9901(param_00.var_8365);
    for(;;) {
      var_04 = var_01.var_98F0 - lib_0580::func_4385();
      if(var_04 <= 0) {
        break;
      }

      wait(var_04);
    }
  }
}

lib_0580::func_8315(param_00) {
  var_01 = self;
  var_01.var_98EF = 0;
  var_01 notify("stop_shock");
  if(isDefined(param_00.var_6AA0)) {
    var_01 thread[[param_00.var_6AA0]](param_00);
    return;
  }

  var_01 thread lib_0580::func_98EE(param_00.var_29A8, param_00.var_721C, param_00.var_8CD7, param_00.var_953E, 0);
}