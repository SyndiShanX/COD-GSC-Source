/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_relics.gsc
************************************/

func_DEE0() {
  level.updateonkillpassivesfunc = ::func_12EDF;
  level.updateonusepassivesfunc = ::func_12EE1;
  level.updateondamagepassivesfunc = ::func_12EDD;
  level.var_462E = [];
  if(!isDefined(level.perks)) {
    level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_smack", "perk_machine_zap", "perk_machine_boom"];
  }

  level.var_C54A = [];
  level.var_C54A["passive_nuke"] = ::func_11AF4;
  level.var_C54A["passive_random_perks"] = ::trackkillsforrandomperks;
  level.var_C54A["passive_railgun_overload"] = ::dolocalrailgundamage;
  level.var_C54A["passive_overkill"] = ::dolocaloverkilldamage;
  level.var_C54A["passive_headshot_ammo"] = ::func_89AE;
  level.var_C54A["passive_headshot_super"] = ::func_1869;
  level.var_C54A["passive_refresh"] = ::func_89D1;
  level.var_C54A["passive_double_kill_reload"] = ::func_5AE4;
  level.var_C54A["passive_gore"] = ::func_89AB;
  level.var_C54A["passive_health_regen_on_kill"] = ::func_89B1;
  level.var_C54A["passive_move_speed_on_kill"] = ::func_89C8;
  level.var_C54A["passive_hitman"] = ::func_89B3;
  level.var_C54A["passive_meleekill"] = ::handlemeleekillpassive;
  level.var_C54A["passive_health_on_kill"] = ::handlehealthonkillpassive;
  level.var_C54A["passive_last_shots_ammo"] = ::handleammoonlastshotskill;
  level.var_C54A["passive_visor_detonation"] = ::handlevisordetonation;
  level.var_C54A["passive_melee_super"] = ::handlemeleesuper;
  level.var_C54A["passive_jump_super"] = ::handleairbornesuper;
  level.var_C54A["passive_double_kill_super"] = ::handledoublekillssuper;
  level.var_C54A["passive_melee_cone_expl"] = ::handlemeleeconeexplode;
  level.var_C54A["passive_berserk"] = ::handleberserk;
  level.var_C54A["passive_ninja"] = ::handleammoonlastshotskill;
  func_DEDF("passive_railgun_overload", ::init_passive_railgun_overload, ::set_passive_railgun_overload, ::unset_passive_railgun_overload);
  func_DEDF("passive_overkill", ::init_passive_overkill, ::set_passive_overkill, ::unset_passive_overkill);
  func_DEDF("passive_last_shots_ammo", ::init_passive_last_shots_ammo, ::set_passive_last_shots_ammo, ::unset_passive_last_shots_ammo);
  func_DEDF("passive_nuke", ::func_96BA, ::func_F4C0, ::func_12C0D);
  func_DEDF("passive_headshot_ammo", ::func_961A, ::func_F3FB, ::func_12BFF);
  func_DEDF("passive_headshot_super", ::func_961B, ::func_F3FC, ::func_12C00);
  func_DEDF("passive_refresh", ::func_96BB, ::func_F4C1, ::func_12C0E);
  func_DEDF("passive_double_kill_reload", ::func_96B1, ::func_F4B7, ::func_12C04);
  func_DEDF("passive_gore", ::func_96B2, ::func_F4B8, ::func_12C05);
  func_DEDF("passive_meleekill", ::init_passive_melee_kill, ::set_passive_melee_kill, ::unset_passive_melee_kill);
  func_DEDF("passive_health_on_kill", ::init_passive_health_on_kill, ::set_passive_health_on_kill, ::unset_passive_health_on_kill);
  func_DEDF("passive_health_regen_on_kill", ::func_96B3, ::func_F4B9, ::func_12C06);
  func_DEDF("passive_move_speed_on_kill", ::func_96B9, ::func_F4BF, ::func_12C0C);
  func_DEDF("passive_hitman", ::func_96B4, ::func_F4BA, ::func_12C07);
  func_DEDF("passive_score_bonus_kills", ::func_96BC, ::func_F4C2, ::func_12C0F);
  func_DEDF("passive_scorestreak_pack", ::func_96BC, ::func_F4C2, ::func_12C0F);
  func_DEDF("passive_random_perks", ::init_passive_random_perks, ::set_passive_random_perks, ::unset_passive_random_perks);
  func_DEDF("passive_visor_detonation", ::init_passive_visor_detonation, ::set_passive_visor_detonation, ::unset_passive_visor_detonation);
  func_DEDF("passive_melee_super", ::init_passive_melee_super, ::set_passive_melee_super, ::unset_passive_melee_super);
  func_DEDF("passive_jump_super", ::init_passive_jump_super, ::set_passive_jump_super, ::unset_passive_jump_super);
  func_DEDF("passive_double_kill_super", ::init_passive_double_kill_super, ::set_passive_double_kill_super, ::unset_passive_double_kill_super);
  func_DEDF("passive_mode_switch_score", ::init_passive_mode_switch_score, ::set_passive_mode_switch_score, ::unset_passive_mode_switch_score);
  func_DEDF("passive_melee_cone_expl", ::init_passive_melee_cone_expl, ::set_passive_melee_cone_expl, ::unset_passive_melee_cone_expl);
  func_DEDF("passive_berserk", ::init_passive_berserk, ::set_passive_berserk, ::unset_passive_berserk);
  level.var_C5C9 = [];
  level.var_C5C9["passive_infinite_ammo"] = ::func_89B8;
  level.var_C5C9["passive_ninja"] = ::handleninjaonlastshot;
  level.var_C5C9["passive_fortified"] = ::handlefortified;
  func_DEDF("passive_infinite_ammo", ::func_96B6, ::func_F4BC, ::func_12C09);
  func_DEDF("passive_crouch_move_speed", ::init_passive_crouch_move_speed, ::set_passive_crouch_move_speed, ::unset_passive_crouch_move_speed);
  level.var_C4E6 = [];
  level.var_C4E6["passive_sonic"] = ::handlepassivesonic;
  level.var_C4E6["passive_minimap_damage"] = ::updatepassiveminimapdamage;
  level.var_C4E6["passive_cold_damage"] = ::updatepassivecolddamage;
  level.var_C4E6["passive_fire_damage"] = ::updatepassivefiredamage;
  func_DEDF("passive_wallrun_quieter", ::init_passive_ninja, ::set_passive_ninja, ::unset_passive_ninja);
  func_DEDF("passive_slide_blastshield", ::init_passive_fortified, ::set_passive_fortified, ::unset_passive_fortified);
  func_DEDF("passive_cold_damage", ::init_passive_cold_damage, ::set_passive_cold_damage, ::unset_passive_cold_damage);
  func_DEDF("passive_fire_damage", ::init_passive_fire_damage, ::set_passive_fire_damage, ::unset_passive_fire_damage);
  func_DEDF("passive_sonic", ::init_passive_sonic, ::set_passive_sonic, ::unset_passive_sonic);
  func_DEDF("passive_below_the_belt", ::func_96B0, ::func_F4B5, ::func_12C03);
  func_DEDF("passive_minimap_damage", ::init_passive_minimap_damage, ::set_passive_minimap_damage, ::unset_passive_minimap_damage);
  func_DEDF("passive_extra_xp", ::func_95D6, ::func_F39A, ::func_12BF8);
  func_DEDF("passive_fast_melee", ::init_passive_fast_melee, ::set_passive_fast_melee, ::unset_passive_fast_melee);
  func_DEDF("coop_passive_snap_to_head", ::func_974D, ::func_F5A3, ::func_12C62);
  func_DEDF("passive_empty_reload_speed", ::init_passive_empty_reload_speed, ::set_passive_empty_reload_speed, ::unset_passive_empty_reload_speed);
  func_DEDF("passive_increased_scope_breath", ::init_passive_increased_scope_breath, ::set_passive_increased_scope_breath, ::unset_passive_increased_scope_breath);
  func_DEDF("passive_hunter_killer", ::func_96B5, ::func_F4BB, ::func_12C08);
  func_DEDF("passive_move_speed", ::func_96B8, ::func_F4BE, ::func_12C0B);
  func_DEDF("passive_miss_refund", ::func_96B7, ::func_F4BD, ::func_12C0A);
  func_DEDF("passive_scoutping", ::func_96BD, ::func_F4C3, ::func_12C10);
  func_DEDF("passive_scrambler", ::init_passive_scrambler, ::set_passive_scrambler, ::unset_passive_scrambler);
  func_DEDF("passive_random_attachment", ::init_passive_random_attachment, ::set_passive_random_attachment, ::unset_passive_random_attachment);
  func_DEDF("passive_scope_radar", ::init_passive_scope_radar, ::set_passive_scope_radar, ::unset_passive_scope_radar);
  func_DEDF("passive_scorestreak_damage", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
  func_DEDF("passive_scorestreak_damage_e", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
}

init_passive_random_attachment(param_00) {
  var_01 = getweaponswithpassive(param_00, "passive_random_attachment");
  var_02 = [];
  foreach(var_04 in var_01) {
    var_05 = scripts\cp\utility::getrawbaseweaponname(var_04);
    var_06 = scripts\cp\utility::getweaponrootname(var_04);
    var_07 = scripts\cp\utility::getweaponcamo(var_06);
    var_08 = scripts\cp\utility::getweaponcosmeticattachment(var_06);
    var_09 = scripts\cp\utility::getweaponreticle(var_06);
    var_0A = scripts\cp\utility::getweaponpaintjobid(var_06);
    param_00.weapon_build_models[var_05] = scripts\cp\utility::mpbuildweaponname(var_06, var_02, var_07, var_09, scripts\cp\utility::get_weapon_variant_id(param_00, var_04), self getentitynumber(), self.clientid, var_0A, var_08);
  }
}

set_passive_random_attachment(param_00) {}

unset_passive_random_attachment(param_00) {}

getweaponswithpassive(param_00, param_01) {
  var_02 = [];
  var_03 = getarraykeys(param_00.var_13C38);
  foreach(var_05 in var_03) {
    for(var_06 = 0; var_06 < param_00.var_13C38[var_05].size; var_06++) {
      if(param_00.var_13C38[var_05][var_06] == param_01) {
        var_02[var_02.size] = var_05;
      }
    }
  }

  var_02 = scripts\engine\utility::array_remove_duplicates(var_02);
  return var_02;
}

init_passive_fast_melee(param_00) {}

set_passive_fast_melee(param_00) {
  param_00.increased_melee_damage = 150;
}

unset_passive_fast_melee(param_00) {
  param_00.increased_melee_damage = undefined;
}

func_95D6(param_00) {
  param_00.weapon_passive_xp_multiplier = 1;
  param_00.kill_with_extra_xp_passive = 0;
}

func_F39A(param_00) {
  param_00.weapon_passive_xp_multiplier = 1.25;
}

func_12BF8(param_00) {
  param_00.weapon_passive_xp_multiplier = 1;
  param_00.kill_with_extra_xp_passive = 0;
}

func_96B0(param_00) {
  param_00.var_4A9A = undefined;
}

func_F4B5(param_00) {
  param_00.var_4A9A = 3.75;
}

func_12C03(param_00) {
  param_00.var_4A9A = undefined;
}

func_96B8(param_00) {
  param_00.weapon_passive_xp_multiplier = 1;
}

func_F4BE(param_00) {
  param_00.weaponpassivespeedmod = 0.05;
  param_00[[level.move_speed_scale]]();
}

func_12C0B(param_00) {
  param_00.weaponpassivespeedmod = undefined;
  param_00[[level.move_speed_scale]]();
}

init_passive_empty_reload_speed(param_00) {}

set_passive_empty_reload_speed(param_00) {
  param_00 scripts\cp\utility::_setperk("specialty_fastreload_empty");
}

unset_passive_empty_reload_speed(param_00) {
  param_00 scripts\cp\utility::_unsetperk("specialty_fastreload_empty");
}

init_passive_increased_scope_breath(param_00) {}

set_passive_increased_scope_breath(param_00) {
  param_00 scripts\cp\utility::_setperk("specialty_holdbreath");
}

unset_passive_increased_scope_breath(param_00) {
  param_00 scripts\cp\utility::_unsetperk("specialty_holdbreath");
}

func_974D(param_00) {}

func_F5A3(param_00) {
  param_00 scripts\cp\utility::_setperk("specialty_autoaimhead");
}

func_12C62(param_00) {
  param_00 scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

func_96B5(param_00) {
  self.var_91EE = 0;
}

func_F4BB(param_00) {
  self endon("passive_hunter_killer_cancel");
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread func_12EAE(var_01);
  thread func_91EA();
  foreach(param_00 in var_01) {
    thread func_91EC(param_00);
    thread func_91EB(param_00);
  }
}

func_12C08(param_00) {
  self notify("passive_hunter_killer_cancel");
  foreach(var_02 in self.var_91E9) {
    param_00 = self.var_91E8[var_02];
    scripts\cp\cp_outline::disable_outline_for_players(param_00, level.players);
  }

  self.var_91E9 = undefined;
  self.var_91E8 = undefined;
}

func_12EAE(param_00) {
  if(!isDefined(self.var_91E9)) {
    self.var_91E9 = [];
  }

  if(!isDefined(self.var_91E8)) {
    self.var_91E8 = [];
  }

  foreach(var_02 in param_00) {
    if(var_02 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_02) || !isDefined(var_02.team)) {
      continue;
    }

    var_03 = func_7F09(var_02);
    if(level.teambased && self.team != var_02.team && var_02.health / var_02.maxhealth <= 0.5 && var_02.health > 0) {
      if(var_03 < 0) {
        self.var_91EE++;
        scripts\cp\cp_outline::enable_outline_for_player(var_02, self, 1, 0, 1, "high");
        var_04 = self.var_91EE;
        self.var_91E9[self.var_91E9.size] = var_04;
        self.var_91E8[var_04] = var_02;
        thread func_91ED(var_02);
      }

      continue;
    }

    if(var_03 >= 0) {
      var_05 = [];
      var_06 = [];
      scripts\cp\cp_outline::disable_outline_for_player(var_02, self);
      foreach(var_04 in self.var_91E9) {
        var_08 = self.var_91E8[var_04];
        if(var_08 == var_02) {
          continue;
        }

        var_05[var_05.size] = var_04;
        var_06[var_04] = var_08;
      }

      self.var_91E9 = var_05;
      self.var_91E8 = var_06;
      var_02 notify("passive_hunter_killer_listen_cancel");
    }
  }
}

func_91ED(param_00) {
  self endon("passive_hunter_killer_cancel");
  param_00 endon("passive_hunter_killer_listen_cancel");
  for(;;) {
    wait(1);
    thread func_12EAD(param_00);
  }
}

func_7F09(param_00) {
  if(!isDefined(self.var_91E9) || !isDefined(self.var_91E8)) {
    return -1;
  }

  foreach(var_02 in self.var_91E9) {
    var_03 = self.var_91E8[var_02];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == param_00) {
      return var_02;
    }
  }

  return -1;
}

func_91EA() {
  self endon("passive_hunter_killer_cancel");
  for(;;) {
    level waittill("agent_spawned", var_00);
    thread func_12EAD(var_00);
    thread func_91EB(var_00);
  }
}

func_91EC(param_00) {
  self endon("passive_hunter_killer_cancel");
  param_00 waittill("disconnect");
  thread func_12EAD(param_00);
}

func_91EB(param_00) {
  self endon("passive_hunter_killer_cancel");
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    thread func_12EAD(param_00);
  }
}

func_12EAD(param_00) {
  var_01 = [];
  var_01[var_01.size] = param_00;
  thread func_12EAE(var_01);
}

func_96BB(param_00) {
  param_00.var_BFA0 = 0;
}

func_F4C1(param_00) {
  param_00.var_C54A["passive_refresh"] = 1;
}

func_12C0E(param_00) {
  param_00.var_C54A["passive_refresh"] = 0;
}

func_89D1(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01.var_BFA0++;
  if(param_01.var_BFA0 >= 50) {
    param_01 scripts\cp\powers\coop_powers::power_adjustcharges(undefined, "primary", 1);
    param_01.var_BFA0 = 0;
  }
}

func_96B1(param_00) {
  if(!isDefined(param_00.var_5AD5)) {
    param_00.var_5AD5 = [];
  }
}

func_F4B7(param_00) {
  param_00.var_C54A["passive_double_kill_reload"] = 1;
  if(!isDefined(param_00.var_5AD5[getweaponbasename(param_00 getcurrentweapon())])) {
    param_00.var_5AD5[getweaponbasename(param_00 getcurrentweapon())] = getweaponbasename(param_00 getcurrentweapon());
  }
}

func_12C04(param_00) {
  param_00.var_C54A["passive_double_kill_reload"] = 0;
}

func_5AE4(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!scripts\engine\utility::array_contains(param_01.var_5AD5, getweaponbasename(param_00))) {
    return;
  }

  if(param_01.var_DDC2 == 4) {
    var_06 = weaponclipsize(param_00);
    var_07 = param_01 getweaponammostock(param_00);
    var_08 = param_01 getweaponammoclip(param_00);
    var_09 = min(var_06 - var_08, var_07);
    var_0A = min(var_08 + var_09, var_06);
    param_01 setweaponammoclip(param_00, int(var_0A));
    param_01 setweaponammostock(param_00, int(var_07 - var_09));
    if(param_01 isdualwielding()) {
      var_07 = param_01 getweaponammostock(param_00);
      var_08 = param_01 getweaponammoclip(param_00, "left");
      var_09 = min(var_06 - var_08, var_07);
      var_0A = min(var_08 + var_09, var_06);
      param_01 setweaponammoclip(param_00, int(var_0A), "left");
      param_01 setweaponammostock(param_00, int(var_07 - var_09));
    }
  }
}

init_passive_melee_kill(param_00) {
  param_00.passive_melee_kill_damage = 0;
}

set_passive_melee_kill(param_00) {
  param_00.skip_weapon_check = 1;
  param_00.passive_melee_kill_damage = 1000;
  param_00.var_C54A["passive_meleekill"] = 1;
}

unset_passive_melee_kill(param_00) {
  param_00.skip_weapon_check = undefined;
  param_00.passive_melee_kill_damage = 0;
  param_00.var_C54A["passive_meleekill"] = 0;
}

handlemeleekillpassive(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  self endon("disconnect");
  if(param_03 != "MOD_MELEE") {
    return;
  }

  level thread handlegoreeffect(param_02);
  wait(0.05);
  var_06 = param_02 _meth_8113();
  if(isDefined(var_06)) {
    var_06 hide();
    var_06.permanentcustommovetransition = 1;
  }
}

handlegoreeffect(param_00) {
  var_01 = param_00 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var_01, (1, 0, 0));
  playsoundatpos(var_01, "gib_fullbody");
  foreach(var_03 in level.players) {
    var_03 earthquakeforplayer(0.5, 1.5, var_01, 120);
  }
}

func_96B2(param_00) {}

func_F4B8(param_00) {
  param_00.var_C54A["passive_gore"] = 1;
}

func_12C05(param_00) {
  param_00.var_C54A["passive_gore"] = 0;
}

func_89AB(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  self endon("disconnect");
  param_02 endon("diconnect");
  wait(0.05);
  var_06 = param_02 _meth_8113();
  if(!isDefined(var_06)) {
    return;
  }

  var_07 = var_06.origin;
  earthquake(0.5, 1.5, var_07, 120);
  playFX(level._effect["corpse_pop"], var_07 + (0, 0, 12));
  if(isDefined(var_06)) {
    var_06 hide();
    var_06.permanentcustommovetransition = 1;
  }
}

init_passive_health_on_kill(param_00) {
  param_00.var_C93F = 0;
}

set_passive_health_on_kill(param_00) {
  param_00.var_C54A["passive_health_on_kill"] = 1;
}

unset_passive_health_on_kill(param_00) {
  param_00.var_C54A["passive_health_on_kill"] = 0;
}

handlehealthonkillpassive(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01.var_C93F++;
  if(param_01.var_C93F >= 2) {
    param_01 notify("force_regeneration");
    param_01.var_C93F = 0;
  }
}

func_96B3(param_00) {
  param_00.var_C93F = 0;
}

func_F4B9(param_00) {
  param_00.var_C54A["passive_health_regen_on_kill"] = 1;
}

func_12C06(param_00) {
  param_00.var_C54A["passive_health_regen_on_kill"] = 0;
}

func_89B1(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(param_01.var_C93F >= 2) {
    param_01 notify("force_regeneration");
    param_01.var_C93F = 0;
    return;
  }

  param_01.var_C93F++;
}

func_96B9(param_00) {
  param_00.weaponpassivespeedonkillmod = 0;
}

func_F4BF(param_00) {
  param_00.var_C54A["passive_move_speed_on_kill"] = 1;
}

func_12C0C(param_00) {
  param_00.var_C54A["passive_move_speed_on_kill"] = 0;
}

func_89C8(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = "passive_move_speed_on_kill";
  param_01 notify(var_06);
  param_01 endon(var_06);
  if(param_01.weaponpassivespeedonkillmod != 0.075) {
    param_01.weaponpassivespeedonkillmod = 0.075;
    param_01[[level.move_speed_scale]]();
  }

  param_01 scripts\engine\utility::waittill_any_timeout_1(5, "death", "disconnect");
  if(!isDefined(param_01)) {
    return;
  }

  param_01.weaponpassivespeedonkillmod = 0;
  param_01[[level.move_speed_scale]]();
}

func_96BC(param_00) {}

func_F4C2(param_00) {
  param_00.cash_scalar = param_00.cash_scalar + 0.1;
  param_00.cash_scalar_weapon = scripts\cp\utility::getrawbaseweaponname(param_00 getcurrentweapon());
}

func_12C0F(param_00) {
  param_00.cash_scalar = param_00.cash_scalar - 0.1;
  param_00.cash_scalar_weapon = undefined;
}

func_96B4(param_00) {}

func_F4BA(param_00) {
  param_00.var_C54A["passive_hitman"] = 1;
}

func_12C07(param_00) {
  param_00.var_C54A["passive_hitman"] = 0;
}

func_89B3(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01) || !scripts\cp\utility::isreallyalive(param_01) || !isDefined(param_02)) {
    return;
  }

  if(!isDefined(param_01.var_903C)) {
    param_01.var_903C = [];
  } else if(func_903B(param_01, param_02.var_64)) {
    return;
  }

  param_01 thread func_E252();
  param_01.var_903C[param_01.var_903C.size] = param_02.var_64;
  if(param_01.var_903C.size >= 10) {
    param_01 notify("consumable_charge", 200);
    param_01.var_903C = [];
  }
}

func_E252() {
  self notify("hitman_timeout");
  self endon("hitman_timeout");
  self endon("death");
  level endon("game_ended");
  wait(10);
  self.var_903C = [];
}

func_903B(param_00, param_01) {
  if(!isDefined(param_00.var_903C)) {
    return 0;
  }

  foreach(var_03 in param_00.var_903C) {
    if(var_03 == param_01) {
      return 1;
    }
  }

  return 0;
}

func_903D() {
  self endon("disconnect");
  self waittill("death");
  self.var_903C = undefined;
}

func_96BA(param_00) {
  param_00.var_C944 = 0;
  param_00.var_A9CA = 0;
  param_00 thread func_11AF6(param_00);
}

func_F4C0(param_00) {
  param_00.var_C54A["passive_nuke"] = 1;
}

func_12C0D(param_00) {
  param_00.var_C54A["passive_nuke"] = 0;
}

func_11AF4(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01.var_C944++;
  if(param_01.var_C944 >= 150 && param_01.var_A9CA + 3 <= level.wave_num) {
    param_01.var_C944 = 0;
    level scripts\cp\loot::drop_loot(param_01.origin, param_01, "kill_50", 1, undefined, 1);
  }
}

func_11AF6(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(;;) {
    param_00 waittill("last_stand");
    param_00.var_C944 = 0;
  }
}

func_961A(param_00) {}

func_F3FB(param_00) {
  param_00.var_C54A["passive_headshot_ammo"] = 1;
}

func_12BFF(param_00) {
  param_00.var_C54A["passive_headshot_ammo"] = 0;
}

func_89AE(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01) || !isDefined(param_00)) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(param_00, param_04, param_03, param_01)) {
    return;
  }

  var_06 = weaponclipsize(param_00);
  adjust_clip_ammo_from_stock(param_01, param_00, "right", var_06);
  if(param_01 isdualwielding()) {
    adjust_clip_ammo_from_stock(param_01, param_00, "left", var_06);
  }
}

adjust_clip_ammo_from_stock(param_00, param_01, param_02, param_03) {
  var_04 = param_00 getweaponammostock(param_01);
  if(var_04 < 1) {
    return;
  }

  var_05 = param_00 getweaponammoclip(param_01, param_02);
  var_06 = param_03 - var_05;
  if(var_04 >= var_06) {
    param_00 setweaponammostock(param_01, var_04 - var_06);
  } else {
    var_06 = var_04;
    param_00 setweaponammostock(param_01, 0);
  }

  var_07 = min(var_05 + var_06, param_03);
  param_00 setweaponammoclip(param_01, int(var_07), param_02);
}

init_passive_fortified(param_00) {
  param_00.has_fortified_passive = 0;
}

set_passive_fortified(param_00) {
  param_00.var_C5C9["passive_fortified"] = 1;
  param_00.has_fortified_passive = 1;
}

unset_passive_fortified(param_00) {
  param_00.var_C5C9["passive_fortified"] = 0;
  param_00.has_fortified_passive = 0;
}

handlefortified(param_00, param_01, param_02) {}

init_passive_ninja(param_00) {}

set_passive_ninja(param_00) {
  param_00.stealth_used = [];
  param_00.var_C5C9["passive_ninja"] = 1;
}

unset_passive_ninja(param_00) {
  param_00.var_C5C9["passive_ninja"] = 0;
  param_00 notify("reset_stealth");
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }
}

handleninjaonlastshot(param_00, param_01, param_02) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  var_03 = weaponclipsize(param_01);
  var_04 = param_00 getweaponammoclip(param_01, "right");
  if(var_04 == 0) {
    param_00 thread set_player_stealthed();
  }

  if(var_04 == 0 && !scripts\engine\utility::array_contains(param_00.stealth_used, "right")) {
    param_00 thread set_player_stealthed();
  } else if(var_04 > 0) {
    param_00.stealth_used = scripts\engine\utility::array_remove(param_00.stealth_used, "right");
  }

  if(param_00 isdualwielding()) {
    var_05 = param_00 getweaponammoclip(param_01, "left");
    if(var_05 == 0 && !scripts\engine\utility::array_contains(param_00.stealth_used, "left")) {
      param_00 thread set_player_stealthed();
      return;
    }

    if(var_05 > 0) {
      param_00.stealth_used = scripts\engine\utility::array_remove(param_00.stealth_used, "left");
      return;
    }
  }
}

set_player_stealthed() {
  self notify("reset_stealth");
  self endon("reset_stealth");
  self endon("disconnect");
  if(!scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  playFX(level._effect["stimulus_glow_burst"], scripts\engine\utility::drop_to_ground(self.origin) - (0, 0, 30));
  scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", scripts\engine\utility::drop_to_ground(self.origin));
  if(self isdualwielding()) {
    wait(3);
  } else {
    wait(4);
  }

  if(scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(0);
  }
}

init_passive_last_shots_ammo(param_00) {}

set_passive_last_shots_ammo(param_00) {
  param_00.var_C54A["passive_ninja"] = 1;
}

unset_passive_last_shots_ammo(param_00) {
  param_00.var_C54A["passive_ninja"] = 0;
}

handleammoonlastshotskill(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01) || !isDefined(param_00)) {
    return;
  }

  var_06 = weaponclipsize(param_00);
  var_07 = param_01 getweaponammoclip(param_00, "right");
  if(var_07 <= int(var_06 * 0.2)) {
    adjust_clip_ammo_from_stock(param_01, param_00, "right", var_06);
  }

  if(param_01 isdualwielding()) {
    var_07 = param_01 getweaponammoclip(param_00, "left");
    if(var_07 <= int(var_06 * 0.2)) {
      adjust_clip_ammo_from_stock(param_01, param_00, "left", var_06);
    }
  }
}

init_passive_overkill(param_00) {}

set_passive_overkill(param_00) {
  param_00.var_C54A["passive_overkill"] = 1;
}

unset_passive_overkill(param_00) {
  param_00.var_C54A["passive_overkill"] = 0;
}

dolocaloverkilldamage(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!scripts\engine\utility::isbulletdamage(param_03)) {
    return 0;
  }

  if(isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack") {
    return;
  }

  var_06 = scripts\engine\utility::istrue(param_02.is_suicide_bomber);
  param_02.head_is_exploding = 1;
  var_07 = param_02 gettagorigin("j_spine4");
  playsoundatpos(param_02.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_07);
  foreach(param_01 in level.players) {
    if(distance(param_01.origin, var_07) <= 350) {
      param_01 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(isDefined(param_02.headmodel)) {
    param_02 detach(param_02.headmodel);
  }

  if(!var_06) {
    param_02 setscriptablepartstate("head", "hide");
  }

  var_0A = scripts\engine\utility::get_array_of_closest(param_02.origin, level.spawned_enemies, [param_02], undefined, 64, 1);
  foreach(var_0C in var_0A) {
    var_0C dodamage(param_02.maxhealth, param_02.origin, param_01, param_01, "MOD_EXPLOSIVE", "iw7_walkietalkie_zm");
  }
}

init_passive_railgun_overload(param_00) {}

set_passive_railgun_overload(param_00) {
  param_00.var_C54A["passive_railgun_overload"] = 1;
}

unset_passive_railgun_overload(param_00) {
  param_00.var_C54A["passive_railgun_overload"] = 0;
}

dolocalrailgundamage(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_02.hitbychargedshot)) {
    return 0;
  }

  param_02.hitbychargedshot = undefined;
  if(!scripts\engine\utility::isbulletdamage(param_03)) {
    return 0;
  }

  if(isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack") {
    return;
  }

  var_06 = scripts\engine\utility::istrue(param_02.is_suicide_bomber);
  param_02.head_is_exploding = 1;
  var_07 = param_02 gettagorigin("j_spine4");
  playsoundatpos(param_02.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_07);
  foreach(param_01 in level.players) {
    if(distance(param_01.origin, var_07) <= 350) {
      param_01 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(isDefined(param_02.headmodel)) {
    param_02 detach(param_02.headmodel);
  }

  if(!var_06) {
    param_02 setscriptablepartstate("head", "hide");
  }

  var_0A = scripts\engine\utility::get_array_of_closest(param_02.origin, level.spawned_enemies, [param_02], undefined, 64, 1);
  foreach(var_0C in var_0A) {
    var_0C dodamage(param_02.maxhealth, param_02.origin, param_01, param_01, "MOD_EXPLOSIVE", "iw7_walkietalkie_zm");
  }
}

func_961B(param_00) {
  param_00.delayedsuperbonus = 0;
}

func_F3FC(param_00) {
  param_00.var_C54A["passive_headshot_super"] = 1;
}

func_12C00(param_00) {
  param_00.var_C54A["passive_headshot_super"] = 0;
}

func_1869(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01.delayedsuperbonus++;
  wait(0.05 * param_01.delayedsuperbonus);
  param_01.delayedsuperbonus--;
  if(param_01.delayedsuperbonus < 0) {
    param_01.delayedsuperbonus = 0;
  }

  param_01 notify("consumable_charge", 10);
}

init_passive_sonic(param_00) {
  param_00.sonictimer = 0;
}

set_passive_sonic(param_00) {
  param_00.var_C4E6["passive_sonic"] = 1;
}

unset_passive_sonic(param_00) {
  param_00.var_C4E6["passive_sonic"] = 0;
}

handlepassivesonic(param_00, param_01, param_02) {
  var_03 = gettime();
  if(param_02 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }

  if(var_03 <= param_00.sonictimer) {
    return;
  }

  if(distance2dsquared(param_00.origin, param_02.origin) <= -3036) {
    thread scripts\cp\cp_weapon::fx_stun_damage(param_02, param_00);
  }

  param_00.sonictimer = var_03 + 1000;
}

init_passive_crouch_move_speed(param_00) {}

set_passive_crouch_move_speed(param_00) {
  param_00 thread adjust_move_speed_while_crouched(param_00);
  param_00 thread adjust_move_speed_while_sliding(param_00);
}

unset_passive_crouch_move_speed(param_00) {
  param_00 notify("remove_crouch_speed_mod");
  param_00.weaponpassivespeedmod = undefined;
}

adjust_move_speed_while_sliding(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("remove_crouch_speed_mod");
  for(;;) {
    self waittill("sprint_slide_end");
    if(param_00 getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        param_00.weaponpassivespeedmod = 0.5;
        param_00[[level.move_speed_scale]]();
      }
    }

    while(param_00 getstance() == "crouch") {
      wait(0.1);
    }

    param_00.weaponpassivespeedmod = undefined;
    param_00[[level.move_speed_scale]]();
  }
}

adjust_move_speed_while_crouched(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("remove_crouch_speed_mod");
  for(;;) {
    if(param_00 getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        param_00.weaponpassivespeedmod = 0.5;
        param_00[[level.move_speed_scale]]();
      }
    }

    while(param_00 getstance() == "crouch") {
      wait(0.1);
    }

    param_00.weaponpassivespeedmod = undefined;
    param_00[[level.move_speed_scale]]();
    param_00 waittill("adjustedStance");
  }
}

func_96B6(param_00) {}

func_F4BC(param_00) {
  param_00 scripts\cp\utility::enable_infinite_ammo(1);
  param_00.var_C5C9["passive_infinite_ammo"] = 1;
}

func_12C09(param_00) {
  param_00 scripts\cp\utility::enable_infinite_ammo(0);
  param_00.var_C5C9["passive_infinite_ammo"] = 0;
}

func_89B8(param_00, param_01) {
  param_00 thread func_AD6F(param_01);
  var_02 = 4;
  var_03 = self.health;
  if(var_03 - var_02 < 1) {
    var_02 = var_03 - 1;
  }

  if(var_02 > 0) {
    param_00 dodamage(var_02, param_00 gettagorigin("j_wrist_ri"), param_00, undefined, "MOD_RIFLE_BULLET", "iw7_pickup_zm");
  }

  param_00 func_12EB2(param_01);
}

func_AD6F(param_00) {
  self endon("disconnect");
  self notify("infinite_ammo_fire");
  self endon("infinite_ammo_fire");
  self.selfdamaging = 1;
  wait(0.2);
  self.selfdamaging = 0;
}

func_12EB2(param_00) {
  var_01 = self.health;
  var_02 = weaponclipsize(param_00);
  self setweaponammoclip(param_00, var_02);
  if(self isdualwielding()) {
    self setweaponammoclip(param_00, var_02, "left");
  }
}

func_96B7(param_00) {}

func_F4BD(param_00) {
  var_01 = param_00 getcurrentweapon();
  param_00 thread func_B8D5(var_01);
}

func_12C0A(param_00) {
  param_00 notify("removeMissRefundPassive");
}

func_B8D5(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");
  for(;;) {
    self waittill("shot_missed", var_01);
    if(var_01 == param_00) {
      if(randomfloat(1) > 0.75) {
        var_02 = self getweaponammostock(param_00);
        self setweaponammostock(param_00, var_02 + 1);
      }
    }
  }
}

init_passive_scrambler(param_00) {}

set_passive_scrambler(param_00) {
  param_00 thread handlepassivescrambler(param_00);
}

unset_passive_scrambler(param_00) {
  param_00 notify("handlePassiveScrambler");
}

scrambler_executevisuals(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 = spawn("script_model", self gettagorigin("tag_eye"));
  var_01 setModel("prop_mp_optic_wave_scr");
  var_01.angles = self getplayerangles();
  var_01 setotherent(self);
  var_01 setscriptablepartstate("effects", "active", 0);
  var_02 = var_01.origin + anglesToForward(var_01.angles) * 256;
  var_01 moveto(var_02, param_00);
  scripts\engine\utility::waittill_any_timeout_1(param_00, "last_stand", "death");
  if(isDefined(var_01)) {
    var_01 delete();
  }
}

handlepassivescrambler(param_00) {
  param_00 notify("handlePassiveScrambler");
  param_00 endon("handlePassiveScrambler");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  for(;;) {
    if(randomint(100) > 85) {
      var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      var_02 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_01, undefined, 24, 256);
      var_03 = 0;
      foreach(var_05 in var_02) {
        if(scripts\engine\utility::within_fov(param_00 getEye(), param_00.angles, var_05.origin, cos(65))) {
          if(!var_03) {
            param_00 thread scrambler_executevisuals(0.8);
          }

          thread scrambler_stun_damage(var_05, param_00);
          var_03++;
        }

        if(var_03 >= 5) {
          break;
        }
      }
    }

    wait(randomfloatrange(5, 10));
  }
}

scrambler_stun_damage(param_00, param_01) {
  param_00 endon("death");
  if(isDefined(param_00.stun_hit_time)) {
    if(gettime() > param_00.stun_hit_time) {
      if(param_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        param_00.scripted_mode = 1;
        param_00.precacheleaderboards = 1;
        param_00 give_mp_super_weapon(param_00.origin);
      }

      param_00.allowpain = 1;
      param_00.stun_hit_time = gettime() + 1000;
      param_00.stunned = 1;
    } else {
      return;
    }
  } else {
    if(param_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
      param_00.scripted_mode = 1;
      param_00.precacheleaderboards = 1;
      param_00 give_mp_super_weapon(param_00.origin);
    }

    param_00.allowpain = 1;
    param_00.stun_hit_time = gettime() + 1000;
    param_00.stunned = 1;
  }

  param_00 dodamage(1, param_00.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_scrambler_zm");
  param_00 thread addhealthback(param_00);
  wait(1);
  if(param_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
    param_00.scripted_mode = 0;
    param_00.precacheleaderboards = 0;
  }

  param_00.allowpain = 0;
  param_00.stunned = undefined;
}

addhealthback(param_00) {
  param_00 endon("death");
  waittillframeend;
  if(param_00.health < param_00.maxhealth) {
    param_00.health = param_00.health + 1;
  }
}

init_passive_random_perks(param_00) {
  param_00.passiverandomperkskillcount = 0;
  param_00 thread tracklaststandforpassiverandomperks(param_00);
}

tracklaststandforpassiverandomperks(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(;;) {
    param_00 waittill("last_stand");
    param_00.passiverandomperkskillcount = 0;
  }
}

set_passive_random_perks(param_00) {
  param_00.var_C54A["passive_random_perks"] = 1;
}

trackkillsforrandomperks(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  param_01 endon("death");
  param_01.passiverandomperkskillcount++;
  if(param_01.passiverandomperkskillcount >= 75) {
    var_06 = level.perks;
    param_01.passiverandomperkskillcount = 0;
    if(!isDefined(param_01.zombies_perks) || param_01.zombies_perks.size < 5) {
      for(;;) {
        var_07 = scripts\engine\utility::random(var_06);
        if(!param_01 scripts\cp\utility::has_zombie_perk(var_07)) {
          param_01 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_07, 0);
          break;
        } else {
          var_06 = scripts\engine\utility::array_remove(var_06, var_07);
        }

        scripts\engine\utility::waitframe();
      }
    }
  }
}

unset_passive_random_perks(param_00) {
  param_00.var_C54A["passive_random_perks"] = 0;
}

init_passive_melee_super(param_00) {}

set_passive_melee_super(param_00) {
  param_00.skip_weapon_check = 1;
  param_00.var_C54A["passive_melee_super"] = 1;
}

unset_passive_melee_super(param_00) {
  param_00.skip_weapon_check = undefined;
  param_00.var_C54A["passive_melee_super"] = 0;
}

handlemeleesuper(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  param_01 endon("disconnect");
  if(isDefined(param_03) && param_03 == "MOD_MELEE") {
    param_01 notify("consumable_charge", 125);
  }
}

init_passive_jump_super(param_00) {}

set_passive_jump_super(param_00) {
  param_00.var_C54A["passive_jump_super"] = 1;
  param_00.current_weapon_jump_super = scripts\cp\utility::getrawbaseweaponname(param_00 getcurrentweapon());
}

unset_passive_jump_super(param_00) {
  param_00.var_C54A["passive_jump_super"] = 0;
  param_00.current_weapon_jump_super = undefined;
}

handleairbornesuper(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  param_01 endon("disconnect");
  if(!param_01 isonground() && isDefined(param_01.current_weapon_jump_super) && scripts\cp\utility::getrawbaseweaponname(param_00) == param_01.current_weapon_jump_super) {
    param_01 notify("consumable_charge", 75);
  }
}

init_passive_double_kill_super(param_00) {}

set_passive_double_kill_super(param_00) {
  param_00.var_C54A["passive_double_kill_super"] = 1;
  param_00.current_weapon_double_super = scripts\cp\utility::getrawbaseweaponname(param_00 getcurrentweapon());
}

unset_passive_double_kill_super(param_00) {
  param_00.var_C54A["passive_double_kill_super"] = 0;
  param_00.current_weapon_double_super = undefined;
}

handledoublekillssuper(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  param_01 endon("disconnect");
  if(isDefined(param_01.var_DDC2) && isDefined(param_01.current_weapon_double_super) && scripts\cp\utility::getrawbaseweaponname(param_00) == param_01.current_weapon_double_super) {
    if(param_01.var_DDC2 == 2) {
      param_01 notify("consumable_charge", 125);
    }
  }
}

init_passive_mode_switch_score(param_00) {}

set_passive_mode_switch_score(param_00) {
  param_00.alt_mode_passive = 1;
  param_00.cash_scalar_alt_weapon = scripts\cp\utility::getrawbaseweaponname(param_00 getcurrentweapon());
  param_00.cash_scalar = param_00.cash_scalar + 0.1;
}

unset_passive_mode_switch_score(param_00) {
  param_00.cash_scalar = param_00.cash_scalar - 0.1;
  param_00.cash_scalar_alt_weapon = undefined;
  param_00.alt_mode_passive = 0;
}

init_passive_visor_detonation(param_00) {}

set_passive_visor_detonation(param_00) {
  param_00.var_C54A["passive_visor_detonation"] = 1;
}

unset_passive_visor_detonation(param_00) {
  param_00.var_C54A["passive_visor_detonation"] = 0;
}

handlevisordetonation(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!scripts\engine\utility::isbulletdamage(param_03)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(param_00, param_04, param_03, param_01)) {
    return 0;
  }

  if(isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack") {
    return;
  }

  var_06 = scripts\engine\utility::istrue(param_02.is_suicide_bomber);
  param_02.head_is_exploding = 1;
  var_07 = param_02 gettagorigin("j_spine4");
  playsoundatpos(param_02.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_07);
  foreach(param_01 in level.players) {
    if(distance(param_01.origin, var_07) <= 350) {
      param_01 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(isDefined(param_02.headmodel)) {
    param_02 detach(param_02.headmodel);
  }

  if(!var_06) {
    param_02 setscriptablepartstate("head", "hide");
  }
}

passive_visor_detonation_activate() {
  self endon("death");
  self endon("disconnect");
  self endon("end_passive_visor_detonation");
  for(;;) {
    self waittill("headshot_done_with_this_weapon", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    scripts\engine\utility::waitframe();
  }
}

init_passive_berserk(param_00) {}

set_passive_berserk(param_00) {
  param_00.var_C54A["passive_berserk"] = 1;
}

unset_passive_berserk(param_00) {
  param_00.var_C54A["passive_berserk"] = 0;
}

handleberserk(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!scripts\engine\utility::istrue(param_01.berserk)) {
    param_01.berserk = 1;
    param_01 _meth_85C1(65);
    var_06 = param_01 _meth_85C0();
    if(var_06 < 0) {
      var_06 = 100;
    }

    var_06 = max(var_06 - 20, 0);
    param_01 player_recoilscaleon(int(var_06));
  }

  param_01 notify("stop_berserk_timer");
  param_01 thread remove_berserk_after_timeout(2);
}

remove_berserk_after_timeout(param_00) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelberserk();
  wait(param_00);
  unset_berserk();
}

listencancelberserk() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "weapon_change");
  unset_berserk();
}

unset_berserk() {
  if(scripts\engine\utility::istrue(self.berserk)) {
    self.berserk = 0;
    self _meth_85C2();
    var_00 = self _meth_85C0();
    var_00 = min(var_00 + 20, 100);
    self player_recoilscaleon(int(var_00));
    self notify("end_berserk");
  }
}

unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unset_berserk();
}

init_passive_melee_cone_expl(param_00) {}

set_passive_melee_cone_expl(param_00) {
  param_00.var_C54A["passive_melee_cone_expl"] = 1;
  param_00.skip_weapon_check = 1;
}

unset_passive_melee_cone_expl(param_00) {
  param_00.var_C54A["passive_melee_cone_expl"] = 0;
  param_00.skip_weapon_check = undefined;
}

handlemeleeconeexplode(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(param_03 != "MOD_MELEE") {
    return;
  }

  if(!issubstr(param_00, "meleervn") && !param_01 _meth_8519(param_00)) {
    return;
  }

  var_06 = param_02 gettagorigin("j_spineupper");
  var_07 = param_01 getplayerangles();
  var_08 = anglesToForward(var_07);
  var_09 = anglestoup(var_07);
  var_0A = var_06 - var_08 * 128;
  var_0B = 384;
  playFX(level._effect["cone_expl_fx"], var_06 + (0, 2, 0), var_08, var_09);
  var_0C = scripts\cp\cp_agent_utils::get_alive_enemies();
  foreach(var_0E in var_0C) {
    if(isDefined(var_0E.flung) || isDefined(var_0E.agent_type) && var_0E.agent_type == "zombie_brute" || var_0E.agent_type == "zombie_ghost" || var_0E.agent_type == "zombie_grey" || var_0E.agent_type == "slasher" || var_0E.agent_type == "superslasher") {
      continue;
    }

    if(!scripts\cp\utility::pointvscone(var_0E gettagorigin("tag_origin"), var_0A, var_08, var_09, var_0B, 128, 12)) {
      continue;
    }

    if(var_0E damageconetrace(var_06, param_01) <= 0) {
      continue;
    }

    var_0F = int(1500 * param_01 scripts\cp\cp_weapon::get_weapon_level(param_00));
    wait(0.05);
    var_0E dodamage(var_0F, var_06, param_01, param_01, "MOD_EXPLOSIVE", param_00);
  }
}

init_passive_minimap_damage(param_00) {}

set_passive_minimap_damage(param_00) {
  param_00.var_C4E6["passive_minimap_damage"] = 1;
}

unset_passive_minimap_damage(param_00) {
  param_00.var_C4E6["passive_minimap_damage"] = 0;
}

updatepassiveminimapdamage(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return;
  }

  var_03 = 4;
  var_04 = 1;
  var_05 = 1;
  if(isDefined(param_02.damaged_by_players)) {
    var_03 = 5;
  }

  if(isDefined(param_02.marked_for_challenge)) {
    var_03 = 0;
  } else {
    var_03 = 4;
  }

  level thread set_outline_passive_minimap_damage(param_00, param_02, var_03, var_04, var_05);
}

enable_outline_for_players(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 hudoutlineenableforclients(param_01, param_02, param_03, param_04);
}

set_outline_passive_minimap_damage(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  level endon("outline_disabled");
  if(!isDefined(param_01)) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 4;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  enable_outline_for_players(param_01, level.players, param_02, 1, 1, "high");
  wait(10);
  unset_outline_passive_minimap_damage(param_01);
}

disable_outline_for_players(param_00, param_01) {
  param_00 hudoutlinedisableforclients(param_01);
}

unset_outline_passive_minimap_damage(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  scripts\cp\cp_outline::disable_outline_for_players(param_00, level.players);
}

activate_adrenaline_boost(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  param_00 scripts\cp\utility::adddamagemodifier("health_boost", 0.2, 0);
  param_00 notify("force_regeneration");
  param_00 playlocalsound("breathing_heartbeat_alt");
  wait(5);
  param_00 scripts\cp\utility::removedamagemodifier("health_boost", 0);
  param_00 playlocalsound("breathing_limp");
}

adr_boost(param_00) {
  param_00 notify("updatepassiveminimapdamage");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  for(;;) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(param_00, 5);
      thread activate_adrenaline_boost(param_00);
    }

    wait(randomfloatrange(5, 15));
  }
}

remove_adrenaline_visuals(param_00) {
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  param_00 visionsetnakedforplayer("", 0.5);
}

run_adrenaline_visuals(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  param_00 endon("remove_adrenaline_visuals");
  param_00 visionsetnakedforplayer("missilecam", scripts\engine\utility::ter_op(1, 0.1, 0));
  param_00 scripts\engine\utility::waittill_any_timeout_1(param_01, "last_stand");
  param_00 thread remove_adrenaline_visuals(param_00);
}

init_passive_fire_damage(param_00) {}

set_passive_fire_damage(param_00) {
  param_00.var_C4E6["passive_fire_damage"] = 1;
  param_00.var_6D53 = param_00 getcurrentweapon();
}

unset_passive_fire_damage(param_00) {
  param_00.var_C4E6["passive_fire_damage"] = 0;
  param_00.var_6D53 = undefined;
}

updatepassivefiredamage(param_00, param_01, param_02) {
  var_03 = isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute";
  var_04 = isDefined(param_02.agent_type) && param_02.agent_type == "zombie_grey";
  var_05 = scripts\engine\utility::istrue(param_02.is_suicide_bomber);
  var_06 = min(param_02.maxhealth * 0.1, 1000);
  if(var_03 || var_04 || var_05) {
    return;
  }

  if(isDefined(param_00.var_6D53)) {
    if(scripts\cp\utility::getrawbaseweaponname(param_00.var_6D53) == scripts\cp\utility::getrawbaseweaponname(param_01)) {
      param_02 thread scripts\cp\utility::damage_over_time(param_02, param_00, 5, var_06, "MOD_HEAD_SHOT", "incendiary_ammo_mp", undefined, "burning");
    }
  }
}

init_passive_cold_damage(param_00) {}

set_passive_cold_damage(param_00) {
  param_00.var_C4E6["passive_cold_damage"] = 1;
  param_00.cold_weapon = param_00 getcurrentweapon();
}

unset_passive_cold_damage(param_00) {
  param_00.var_C4E6["passive_cold_damage"] = 0;
  param_00.cold_weapon = undefined;
}

updatepassivecolddamage(param_00, param_01, param_02) {
  var_03 = isDefined(param_02.agent_type) && param_02.agent_type == "zombie_brute";
  var_04 = isDefined(param_02.agent_type) && param_02.agent_type == "zombie_grey";
  var_05 = scripts\engine\utility::istrue(param_02.is_suicide_bomber);
  if(var_03 || var_04 || var_05) {
    return;
  }

  if(isDefined(param_00.cold_weapon)) {
    if(scripts\cp\utility::getrawbaseweaponname(param_00.cold_weapon) == scripts\cp\utility::getrawbaseweaponname(param_01)) {
      param_02 thread unsetslowmovementaftertime(param_02, param_02.synctransients);
      param_02.synctransients = "slow_walk";
      param_02 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
    }
  }
}

unsetslowmovementaftertime(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("death");
  wait(10);
  if(isDefined(param_01)) {
    param_00.synctransients = param_01;
    param_00 scripts\asm\asm_bb::bb_requestmovetype(param_01);
  }
}

init_passive_scorestreak_damage(param_00) {}

set_passive_scorestreak_damage(param_00) {
  param_00.special_zombie_damage = 1.1;
}

unset_passive_scorestreak_damage(param_00) {
  param_00.special_zombie_damage = undefined;
}

init_passive_scope_radar(param_00) {
  param_00.activate_radar = 0;
  param_00 notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  param_00 notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

set_passive_scope_radar(param_00) {
  param_00 thread updatescoperadar(param_00);
}

unset_passive_scope_radar(param_00) {
  param_00 notify("unsetScopeRadar");
  param_00 thread cleanup_outlines(param_00);
}

updatescoperadar(param_00) {
  param_00 notify("updateScopeRadar");
  param_00 endon("updateScopeRadar");
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("unsetScopeRadar");
  var_01 = 2.4;
  var_02 = 1750;
  for(;;) {
    if(!param_00 adsbuttonpressed()) {
      var_03 = param_00 scripts\engine\utility::waittill_any_return_no_endon_death_3("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    } else {
      var_03 = "scope_radar_ads_in";
    }

    if(var_03 == "scope_radar_ads_in") {
      runscoperadarinloop(param_00, var_01, var_02);
    }

    param_00 thread remove_visuals(param_00);
  }
}

runscoperadarinloop(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 notify("runScopeRadarInLoop");
  param_00 endon("runScopeRadarInLoop");
  param_00 endon("scope_radar_ads_out");
  param_00 endon("last_stand");
  param_00 endon("death");
  param_00 endon("disconnect");
  var_03 = 0.75;
  while(param_00 adsbuttonpressed()) {
    if(param_00 getweaponrankinfominxp() >= var_03) {
      param_00 playlocalsound("uav_ping");
      param_00 thread scoperadar_executeping(param_00, param_01, param_02);
      param_00 scoperadar_executevisuals(param_00, param_01);
    }

    scripts\engine\utility::waitframe();
  }
}

scoperadar_executeping(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("scope_radar_ads_out");
  var_03 = 0;
  var_04 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_05 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_04, undefined, 24, param_02);
  param_00.closestenemies = var_05;
  var_06 = 0;
  foreach(var_08 in param_00.closestenemies) {
    var_08.is_outlined_from_scoperadar = 0;
    if(scripts\engine\utility::within_fov(param_00 getEye(), param_00.angles, var_08.origin, cos(65))) {
      var_06++;
      var_09 = var_08.origin - param_00.origin;
      if(1 && vectordot(anglesToForward(param_00.angles), var_09) < 0) {
        continue;
      }

      var_0A = param_02 * param_02;
      if(length2dsquared(var_09) > var_0A) {
        continue;
      }

      param_00 thread func_C7A7(var_08, param_00, distance2d(param_00.origin, var_08.origin) / param_02, param_01);
      var_03 = 1;
    }
  }
}

enable_outline_for_player(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 hudoutlineenableforclient(param_01, param_02, param_03, param_04);
}

func_C7A7(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_01 endon("scope_radar_ads_out");
  param_01 endon("last_stand");
  param_01 endon("death");
  param_01 endon("disconnect");
  param_01 endon("weapon_change");
  wait(param_03 * param_02);
  var_04 = 1;
  param_00.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(param_00, param_01, var_04, 1, 1, "high");
}

func_13AA0(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  level endon("game_ended");
  param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_02);
  if(isDefined(param_01)) {
    disable_outline_for_player(param_01, param_00);
  }
}

disable_outline_for_player(param_00, param_01) {
  param_00 hudoutlinedisableforclient(param_01);
}

scoperadar_executevisuals(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 visionsetnakedforplayer("opticwave_mp", 0.2);
  param_00.fxent = spawn("script_model", param_00 gettagorigin("tag_eye"));
  param_00.fxent setModel("prop_mp_optic_wave_scr");
  param_00.fxent.angles = param_00 getplayerangles();
  param_00.fxent setotherent(param_00);
  param_00.fxent setscriptablepartstate("effects", "active", 0);
  var_02 = param_00.fxent.origin + anglesToForward(param_00.fxent.angles) * 1750;
  param_00.fxent moveto(var_02, param_01);
  param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_01, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");
  if(isDefined(param_00.closestenemies)) {
    foreach(var_04 in param_00.closestenemies) {
      if(isDefined(var_04)) {
        if(scripts\engine\utility::istrue(var_04.is_outlined_from_scoperadar)) {
          disable_outline_for_player(var_04, param_00);
          var_04.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }

  if(scripts\engine\utility::istrue(param_00.wearing_dischord_glasses)) {
    param_00 visionsetnakedforplayer("cp_zmb_bw", 0.1);
  } else if(scripts\engine\utility::istrue(param_00.rave_mode)) {
    param_00 visionsetnakedforplayer("cp_rave_rave_mode", 0.1);
  } else {
    param_00 visionsetnakedforplayer("", 0.1);
  }

  if(isDefined(param_00.fxent)) {
    param_00.fxent delete();
  }
}

remove_visuals(param_00) {
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_03 in var_01) {
    if(isDefined(var_03)) {
      if(scripts\engine\utility::istrue(var_03.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_03, param_00);
        var_03.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(scripts\engine\utility::istrue(param_00.wearing_dischord_glasses)) {
    param_00 visionsetnakedforplayer("cp_zmb_bw", 0.1);
  } else if(scripts\engine\utility::istrue(param_00.rave_mode)) {
    param_00 visionsetnakedforplayer("cp_rave_rave_mode", 0.1);
  } else {
    param_00 visionsetnakedforplayer("", 0.1);
  }

  if(isDefined(param_00.fxent)) {
    param_00.fxent delete();
  }
}

cleanup_outlines(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  param_00 endon("death");
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_03 in var_01) {
    if(isDefined(var_03)) {
      if(scripts\engine\utility::istrue(var_03.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_03, param_00);
        var_03.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

func_96BD(param_00) {}

func_F4C3(param_00) {
  param_00 thread updatescoutping(param_00);
}

func_12C10(param_00) {
  param_00 notify("unsetScoutPing");
}

updatescoutping(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("unsetScoutPing");
  var_01 = 50;
  var_02 = 0.1;
  for(;;) {
    var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_04 = var_01;
    var_05 = var_02;
    var_04 = int(var_04);
    var_05 = int(var_05);
    var_06 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_03, undefined, 24, var_04);
    if(var_06.size >= 1) {
      foreach(var_08 in var_06) {
        scripts\cp\cp_outline::enable_outline_for_players(var_08, level.players, 7, 0, 0, "low");
        wait(var_05);
      }

      continue;
    }

    wait(var_02 / 1200);
  }
}

func_12EDF(param_00, param_01, param_02, param_03, param_04) {
  var_05 = gettime();
  var_06 = getarraykeys(param_01.var_C54A);
  if(!scripts\engine\utility::istrue(param_01.skip_weapon_check) && isDefined(param_01.current_passive_weapon) && param_00 != param_01.current_passive_weapon) {
    return;
  }

  foreach(var_08 in var_06) {
    if(scripts\engine\utility::istrue(param_01.var_C54A[var_08])) {
      thread[[level.var_C54A[var_08]]](param_00, param_01, param_02, param_03, param_04, var_05);
    }
  }
}

func_12EE1(param_00, param_01) {
  var_02 = gettime();
  var_03 = getarraykeys(param_00.var_C5C9);
  foreach(var_05 in var_03) {
    if(scripts\engine\utility::istrue(param_00.var_C5C9[var_05])) {
      thread[[level.var_C5C9[var_05]]](param_00, param_01);
    }
  }
}

func_12EDD(param_00, param_01, param_02) {
  var_03 = gettime();
  var_04 = getarraykeys(param_00.var_C4E6);
  foreach(var_06 in var_04) {
    if(scripts\engine\utility::istrue(param_00.var_C4E6[var_06])) {
      thread[[level.var_C4E6[var_06]]](param_00, param_01, param_02);
    }
  }
}

init() {
  func_DEE0();
  level thread player_connect_monitor();
}

player_connect_monitor() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_13C36(var_00);
  }
}

func_13C36(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = undefined;
  param_00.var_D8A7 = undefined;
  param_00.var_1607 = [];
  while(!isDefined(param_00.weaponkitinitialized)) {
    wait(0.1);
  }

  param_00 func_94F1(param_00);
  for(;;) {
    if(!isDefined(var_01) || isDefined(var_01) && !scripts\cp\utility::is_melee_weapon(getweaponbasename(var_01), 1)) {
      var_02 = param_00 getcurrentprimaryweapon();
      if(!isDefined(var_02)) {
        wait(0.05);
        continue;
      }

      if(var_02 == "none") {
        wait(0.05);
        continue;
      }

      if(isDefined(param_00.var_D8A7)) {
        func_12C64(param_00, param_00.var_D8A7);
      }

      func_F616(param_00, var_02);
      param_00.current_passive_weapon = var_02;
      param_00.var_D8A7 = var_02;
    }

    param_00 waittill("weapon_change", var_01);
  }
}

func_94F1(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.var_13C38) {
    foreach(var_05 in var_03) {
      if(scripts\engine\utility::array_contains(var_01, var_05)) {
        continue;
      }

      if(isDefined(level.var_462E[var_05])) {
        var_06 = level.var_462E[var_05];
        if(isDefined(var_06) && isDefined(var_06.init_func)) {
          [
            [var_06.init_func]
          ](param_00);
        }
      }

      var_01 = scripts\engine\utility::array_add(var_01, var_05);
    }
  }
}

func_12C64(param_00, param_01) {
  param_01 = scripts\cp\utility::getweaponrootname(param_01);
  if(!isDefined(param_00.var_13C38[param_01])) {
    return;
  }

  var_02 = param_00.var_13C38[param_01];
  foreach(var_04 in var_02) {
    if(isDefined(level.var_462E[var_04])) {
      var_05 = level.var_462E[var_04];
      if(isDefined(var_05) && isDefined(var_05.var_12BFB)) {
        [
          [var_05.var_12BFB]
        ](param_00);
      }
    }

    param_00.var_1607 = scripts\engine\utility::array_remove(param_00.var_1607, var_04);
  }
}

func_F616(param_00, param_01) {
  param_01 = scripts\cp\utility::getweaponrootname(param_01);
  if(!isDefined(param_00.var_13C38[param_01])) {
    return;
  }

  var_02 = param_00.var_13C38[param_01];
  foreach(var_04 in var_02) {
    if(scripts\engine\utility::array_contains(param_00.var_1607, var_04)) {
      continue;
    }

    var_05 = level.var_462E[var_04];
    if(isDefined(var_05) && isDefined(var_05.var_F3C3)) {
      [
        [var_05.var_F3C3]
      ](param_00);
    }

    param_00.var_1607 = scripts\engine\utility::array_add(param_00.var_1607, var_04);
  }
}

func_DEDF(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.init_func = param_01;
  var_04.var_F3C3 = param_02;
  var_04.var_12BFB = param_03;
  level.var_462E[param_00] = var_04;
}

func_7D6C(param_00, param_01) {
  var_02 = scripts\cp\utility::get_weapon_variant_id(param_00, param_01);
  var_03 = [];
  if(!isDefined(var_02) || var_02 == -1) {
    return var_03;
  }

  var_04 = "mp\loot\weapon\" + param_01 + ".csv ";
  var_05 = tablelookuprownum(var_04, 0, var_02);
  for(var_06 = 0; var_06 < 3; var_06++) {
    var_07 = tablelookupbyrow(var_04, var_05, 21 + var_06);
    if(isDefined(var_07) && var_07 != "") {
      var_03[var_03.size] = var_07;
    }
  }

  return var_03;
}

func_1772(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(level.passivemap)) {
    level.passivemap = [];
  }

  var_08 = spawnStruct();
  var_08.name = param_00;
  var_08.var_13CDE = scripts\engine\utility::ter_op(isDefined(param_04), 0, 1);
  var_08.killstreaktype = scripts\engine\utility::ter_op(isDefined(param_05), 0, 1);
  var_08.var_ABCA = scripts\engine\utility::ter_op(isDefined(param_06), 0, 1);
  var_08.var_113D1 = scripts\engine\utility::ter_op(isDefined(param_07), 0, 1);
  if(isDefined(param_01)) {
    var_08.attachmentroll = param_01;
  }

  if(isDefined(param_02)) {
    var_08.var_CA59 = param_02;
  }

  if(isDefined(param_03)) {
    var_08.var_B689 = param_03;
  }

  if(!isDefined(level.passivemap[param_00])) {
    level.passivemap[param_00] = var_08;
  }
}