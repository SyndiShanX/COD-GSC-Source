/*********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombies_scripted_mtx_20_paps.gsc
*********************************************************************/

func_00D5() {
  lib_0547::func_7BA9(::scripted_mtx20_on_death);
  common_scripts\utility::func_092C("zmi_m2hyde_acid_dot", "vfx/zombie/prototype_fx/zombie_eye_glow_green");
  common_scripts\utility::func_092C("zmi_m2hyde_acid_expl", "vfx/zombie/prototype_fx/mtx20/zmi_m2hyde_acid_expl");
  common_scripts\utility::func_092C("zmi_warsaw_sparks", "vfx/zombie/prototype_fx/mtx20/zmi_warsaw_sparks");
  common_scripts\utility::func_092C("zmi_paper_burst", "vfx/zombie/prototype_fx/mtx20/zmi_paper_burst");
  common_scripts\utility::func_092C("zmb_green_zmb_stun", "vfx/zombie/abilities_perks\zmb_green_zmb_stun");
  common_scripts\utility::func_092C("zmb_dp28_green_impact_lrg", "vfx/zombie/zmb_dp28_green_impact_lrg");
  level.zmb_minibosstypes = ["zombie_heavy", "zombie_fireman", "zombie_assassin", "zombie_exploder", "zombie_dlc4"];
  level.green_death_dmg = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 10);
  level thread maps\mp\_utility::func_6F74(::kgm21_on_reload_empty);
}

required_weapon(param_00) {
  var_01 = self;
  var_02 = var_01 getcurrentweapon();
  if(lib_0569::func_55D4(var_02)) {
    var_02 = var_01 maps\mp\_events_z::set_last_checked_weapon(var_02);
    if(!lib_0547::func_5565(var_02, param_00)) {
      return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

scripted_mtx20_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_04)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  var_09 = self;
  if(common_scripts\utility::func_562E(var_09.bouttoblow)) {
    playFX(common_scripts\utility::func_44F5("zmb_dp28_green_impact"), var_09 getEye());
    level thread lib_0380::func_2889("zmb_wpn_crossbow_cricket_explo", undefined, var_09 getEye());
  }

  if(issubstr(param_04, "m2hyde") && issubstr(param_04, "_pap_zm") && common_scripts\utility::func_0F79(level.zmb_minibosstypes, var_09.var_0A4B)) {
    playFX(common_scripts\utility::func_44F5("zmb_dp28_green_impact_lrg"), var_09.var_0116);
    level thread lib_0380::func_2889("zmb_wpn_crossbow_cricket_explo", undefined, var_09 getEye());
    foreach(var_09 in lib_0547::func_408F()) {
      if(common_scripts\utility::func_0F79(level.zmb_minibosstypes, var_09.var_0A4B)) {
        continue;
      }

      if(!common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_sizzler"], var_09.var_0A4B)) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_09.bouttoblow)) {
        continue;
      }

      if(lib_0547::func_5565(self, var_09)) {
        continue;
      }

      if(distance(var_09.var_0116, self.var_0116) > 400) {
        continue;
      }

      var_09 thread green_splode(param_01);
    }
  }
}

green_splode(param_00) {
  var_01 = self;
  var_01 endon("death");
  param_00 endon("disconnect");
  var_01.bouttoblow = 1;
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmi_m2hyde_acid_dot"), var_01, "tag_eye");
  var_01 childthread loop_green_fx();
  wait(randomfloat(3));
  for(;;) {
    wait(2);
    wait(randomfloat(3));
    var_01 dodamage(level.green_death_dmg, var_01.var_0116, param_00, param_00, "MOD_RIFLE_BULLET", "m2hyde_pap_zm", "head");
  }
}

loop_green_fx() {
  var_00 = self;
  for(;;) {
    playFXOnTag(common_scripts\utility::func_44F5("zmb_green_zmb_stun"), var_00, "j_spine4");
    wait(0.75);
  }
}

kgm21_on_reload_empty() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload");
    var_00 attempt_reload_action(::randomize_clip_size, "kgm21_zm");
  }
}

randomize_clip_size() {
  var_00 = self;
  var_01 = weaponclipsize(var_00.weapontoadjust, var_00);
  if(isDefined(var_00.weapontoadjust)) {
    if(randomint(3) <= 1) {
      var_02 = randomintrange(15, 20);
    } else {
      var_02 = randomintrange(30, var_02);
    }

    if(randomint(100) <= 2) {
      var_02 = randomintrange(4, 9);
    }

    self method_82FA(var_00.weapontoadjust, var_02);
    self givemaxammo(var_00.weapontoadjust);
  }
}

attempt_reload_action(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  if(!var_02 required_weapon(param_01)) {
    return;
  } else {
    var_02.weapontoadjust = var_02 getcurrentweapon();
  }

  var_02 childthread[[param_00]]();
  while(weapon_clip_empty(param_01)) {
    wait 0.05;
  }
}

weapon_clip_empty(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(param_00, lib_0547::func_AAF9(var_01 getcurrentweapon()))) {
    return 1;
  }

  return var_01 getcurrentweaponclipammo() == 0;
}

sqrd_dist_between_segments(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = 1E-06;
  var_06 = param_03 - param_02;
  var_07 = param_01 - param_00;
  var_08 = param_00 - param_02;
  var_09 = vectordot(var_06, var_06);
  var_0A = vectordot(var_07, var_07);
  var_0B = vectordot(var_07, var_06);
  var_0C = vectordot(var_06, var_08);
  var_0D = vectordot(var_07, var_08);
  var_0E = var_09 * var_0A - var_0B * var_0B;
  var_0F = 0;
  var_10 = 0;
  if(var_0E <= var_05) {
    if(var_0B > var_09) {
      var_0F = var_0D / var_0B;
    } else {
      var_0F = var_0C / var_09;
    }
  } else {
    var_0F = var_0C * var_0A - var_0B * var_0D / var_0E;
    var_10 = var_0B * var_0C - var_0D * var_09 / var_0E;
  }

  var_0F = clamp(var_0F, 0, 1);
  var_10 = clamp(var_10, 0, 1);
  var_11 = param_02 + var_06 * var_0F;
  var_12 = param_00 + var_07 * var_10;
  var_13 = var_12 - var_11;
  var_14 = vectordot(var_13, var_13);
  var_04[1] = var_12;
  var_04[2] = var_11;
  var_04[0] = var_14;
  return var_04;
}