/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2671.gsc
***************************************/

func_DEE0() {
  level.updateonkillpassivesfunc = ::func_12EDF;
  level.updateonusepassivesfunc = ::func_12EE1;
  level.updateondamagepassivesfunc = ::func_12EDD;
  level.func_462E = [];

  if(!isDefined(level.perks)) {
    level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_smack", "perk_machine_zap", "perk_machine_boom"];
  }

  level.func_C54A = [];
  level.func_C54A["passive_nuke"] = ::func_11AF4;
  level.func_C54A["passive_random_perks"] = ::trackkillsforrandomperks;
  level.func_C54A["passive_headshot_ammo"] = ::func_89AE;
  level.func_C54A["passive_headshot_super"] = ::func_1869;
  level.func_C54A["passive_refresh"] = ::func_89D1;
  level.func_C54A["passive_double_kill_reload"] = ::func_5AE4;
  level.func_C54A["passive_gore"] = ::func_89AB;
  level.func_C54A["passive_health_regen_on_kill"] = ::func_89B1;
  level.func_C54A["passive_move_speed_on_kill"] = ::func_89C8;
  level.func_C54A["passive_hitman"] = ::func_89B3;
  level.func_C54A["passive_meleekill"] = ::handlemeleekillpassive;
  level.func_C54A["passive_health_on_kill"] = ::handlehealthonkillpassive;
  level.func_C54A["passive_last_shots_ammo"] = ::handleammoonlastshotskill;
  level.func_C54A["passive_visor_detonation"] = ::handlevisordetonation;
  level.func_C54A["passive_melee_super"] = ::handlemeleesuper;
  level.func_C54A["passive_jump_super"] = ::handleairbornesuper;
  level.func_C54A["passive_double_kill_super"] = ::handledoublekillssuper;
  level.func_C54A["passive_melee_cone_expl"] = ::handlemeleeconeexplode;
  level.func_C54A["passive_berserk"] = ::handleberserk;
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
  level.func_C5C9 = [];
  level.func_C5C9["passive_infinite_ammo"] = ::func_89B8;
  level.func_C5C9["passive_ninja"] = ::handleninjaonlastshot;
  level.func_C5C9["passive_fortified"] = ::handlefortified;
  func_DEDF("passive_infinite_ammo", ::func_96B6, ::func_F4BC, ::func_12C09);
  func_DEDF("passive_crouch_move_speed", ::init_passive_crouch_move_speed, ::set_passive_crouch_move_speed, ::unset_passive_crouch_move_speed);
  level.func_C4E6 = [];
  level.func_C4E6["passive_sonic"] = ::handlepassivesonic;
  level.func_C4E6["passive_minimap_damage"] = ::updatepassiveminimapdamage;
  level.func_C4E6["passive_cold_damage"] = ::updatepassivecolddamage;
  func_DEDF("passive_wallrun_quieter", ::init_passive_ninja, ::set_passive_ninja, ::unset_passive_ninja);
  func_DEDF("passive_slide_blastshield", ::init_passive_fortified, ::set_passive_fortified, ::unset_passive_fortified);
  func_DEDF("passive_cold_damage", ::init_passive_cold_damage, ::set_passive_cold_damage, ::unset_passive_cold_damage);
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

init_passive_random_attachment(var_00) {
  var_01 = getweaponswithpassive(var_00, "passive_random_attachment");
  var_02 = [];

  foreach(var_04 in var_01) {
    var_05 = scripts\cp\utility::getrawbaseweaponname(var_04);
    var_06 = scripts\cp\utility::getweaponrootname(var_04);
    var_07 = scripts\cp\utility::getweaponcamo(var_06);
    var_08 = scripts\cp\utility::getweaponcosmeticattachment(var_06);
    var_09 = scripts\cp\utility::getweaponreticle(var_06);
    var_10 = scripts\cp\utility::getweaponpaintjobid(var_06);
    var_0.weapon_build_models[var_05] = ::scripts\cp\utility::mpbuildweaponname(var_06, var_02, var_07, var_09, scripts\cp\utility::get_weapon_variant_id(var_00, var_04), self getentitynumber(), self.clientid, var_10, var_08);
  }
}

set_passive_random_attachment(var_00) {}

unset_passive_random_attachment(var_00) {}

getweaponswithpassive(var_00, var_01) {
  var_02 = [];
  var_03 = getarraykeys(var_0.func_13C38);

  foreach(var_05 in var_03) {
    for(var_06 = 0; var_06 < var_0.func_13C38[var_05].size; var_6++) {
      if(var_0.func_13C38[var_05][var_06] == var_01) {
        var_2[var_2.size] = var_05;
      }
    }
  }

  var_02 = scripts\engine\utility::array_remove_duplicates(var_02);
  return var_02;
}

init_passive_fast_melee(var_00) {}

set_passive_fast_melee(var_00) {
  var_0.increased_melee_damage = 150;
}

unset_passive_fast_melee(var_00) {
  var_0.increased_melee_damage = undefined;
}

func_95D6(var_00) {
  var_0.weapon_passive_xp_multiplier = 1;
  var_0.kill_with_extra_xp_passive = 0;
}

func_F39A(var_00) {
  var_0.weapon_passive_xp_multiplier = 1.25;
}

func_12BF8(var_00) {
  var_0.weapon_passive_xp_multiplier = 1;
  var_0.kill_with_extra_xp_passive = 0;
}

func_96B0(var_00) {
  var_0.func_4A9A = undefined;
}

func_F4B5(var_00) {
  var_0.func_4A9A = 3.75;
}

func_12C03(var_00) {
  var_0.func_4A9A = undefined;
}

func_96B8(var_00) {
  var_0.weapon_passive_xp_multiplier = 1;
}

func_F4BE(var_00) {
  var_0.weaponpassivespeedmod = 0.05;
  var_00[[level.move_speed_scale]]();
}

func_12C0B(var_00) {
  var_0.weaponpassivespeedmod = undefined;
  var_00[[level.move_speed_scale]]();
}

init_passive_empty_reload_speed(var_00) {}

set_passive_empty_reload_speed(var_00) {
  var_00 scripts\cp\utility::_setperk("specialty_fastreload_empty");
}

unset_passive_empty_reload_speed(var_00) {
  var_00 scripts\cp\utility::_unsetperk("specialty_fastreload_empty");
}

init_passive_increased_scope_breath(var_00) {}

set_passive_increased_scope_breath(var_00) {
  var_00 scripts\cp\utility::_setperk("specialty_holdbreath");
}

unset_passive_increased_scope_breath(var_00) {
  var_00 scripts\cp\utility::_unsetperk("specialty_holdbreath");
}

func_974D(var_00) {}

func_F5A3(var_00) {
  var_00 scripts\cp\utility::_setperk("specialty_autoaimhead");
}

func_12C62(var_00) {
  var_00 scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

func_96B5(var_00) {
  self.func_91EE = 0;
}

func_F4BB(var_00) {
  self endon("passive_hunter_killer_cancel");
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread func_12EAE(var_01);
  thread func_91EA();

  foreach(var_00 in var_01) {
    thread func_91EC(var_00);
    thread func_91EB(var_00);
  }
}

func_12C08(var_00) {
  self notify("passive_hunter_killer_cancel");

  foreach(var_02 in self.func_91E9) {
    var_00 = self.func_91E8[var_02];
    scripts\cp\cp_outline::disable_outline_for_players(var_00, level.players);
  }

  self.func_91E9 = undefined;
  self.func_91E8 = undefined;
}

func_12EAE(var_00) {
  if(!isDefined(self.func_91E9)) {
    self.func_91E9 = [];
  }

  if(!isDefined(self.func_91E8)) {
    self.func_91E8 = [];
  }

  foreach(var_02 in var_00) {
    if(var_02 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_02) || !isDefined(var_2.team)) {
      continue;
    }
    var_03 = func_7F09(var_02);

    if(level.teambased && self.team != var_2.team && var_2.health / var_2.maxhealth <= 0.5 && var_2.health > 0) {
      if(var_03 < 0) {
        self.func_91EE++;
        scripts\cp\cp_outline::enable_outline_for_player(var_02, self, 1, 0, 1, "high");
        var_04 = self.func_91EE;
        self.func_91E9[self.func_91E9.size] = var_04;
        self.func_91E8[var_04] = var_02;
        thread func_91ED(var_02);
      }

      continue;
    }

    if(var_03 >= 0) {
      var_05 = [];
      var_06 = [];
      scripts\cp\cp_outline::disable_outline_for_player(var_02, self);

      foreach(var_04 in self.func_91E9) {
        var_08 = self.func_91E8[var_04];

        if(var_08 == var_02) {
          continue;
        }
        var_5[var_5.size] = var_04;
        var_6[var_04] = var_08;
      }

      self.func_91E9 = var_05;
      self.func_91E8 = var_06;
      var_02 notify("passive_hunter_killer_listen_cancel");
    }
  }
}

func_91ED(var_00) {
  self endon("passive_hunter_killer_cancel");
  var_00 endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1.0;
    thread func_12EAD(var_00);
  }
}

func_7F09(var_00) {
  if(!isDefined(self.func_91E9) || !isDefined(self.func_91E8)) {
    return -1;
  }

  foreach(var_02 in self.func_91E9) {
    var_03 = self.func_91E8[var_02];

    if(!isDefined(var_03)) {
      continue;
    }
    if(var_03 == var_00) {
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

func_91EC(var_00) {
  self endon("passive_hunter_killer_cancel");
  var_00 waittill("disconnect");
  thread func_12EAD(var_00);
}

func_91EB(var_00) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
    thread func_12EAD(var_00);
  }
}

func_12EAD(var_00) {
  var_01 = [];
  var_1[var_1.size] = var_00;
  thread func_12EAE(var_01);
}

func_96BB(var_00) {
  var_0.func_BFA0 = 0;
}

func_F4C1(var_00) {
  var_0.func_C54A["passive_refresh"] = 1;
}

func_12C0E(var_00) {
  var_0.func_C54A["passive_refresh"] = 0;
}

func_89D1(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_1.func_BFA0++;

  if(var_1.func_BFA0 >= 50) {
    var_01 scripts\cp\powers\coop_powers::power_adjustcharges(undefined, "primary", 1);
    var_1.func_BFA0 = 0;
  }
}

func_96B1(var_00) {
  if(!isDefined(var_0.func_5AD5)) {
    var_0.func_5AD5 = [];
  }
}

func_F4B7(var_00) {
  var_0.func_C54A["passive_double_kill_reload"] = 1;

  if(!isDefined(var_0.func_5AD5[getweaponbasename(var_00 getcurrentweapon())])) {
    var_0.func_5AD5[getweaponbasename(var_00 getcurrentweapon())] = getweaponbasename(var_00 getcurrentweapon());
  }
}

func_12C04(var_00) {
  var_0.func_C54A["passive_double_kill_reload"] = 0;
}

func_5AE4(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!scripts\engine\utility::array_contains(var_1.func_5AD5, getweaponbasename(var_00))) {
    return;
  }
  if(var_1.func_DDC2 == 4) {
    var_06 = weaponclipsize(var_00);
    var_07 = var_01 getweaponammostock(var_00);
    var_08 = var_01 getweaponammoclip(var_00);
    var_09 = min(var_06 - var_08, var_07);
    var_10 = min(var_08 + var_09, var_06);
    var_01 setweaponammoclip(var_00, int(var_10));
    var_01 setweaponammostock(var_00, int(var_07 - var_09));

    if(var_01 isdualwielding()) {
      var_07 = var_01 getweaponammostock(var_00);
      var_08 = var_01 getweaponammoclip(var_00, "left");
      var_09 = min(var_06 - var_08, var_07);
      var_10 = min(var_08 + var_09, var_06);
      var_01 setweaponammoclip(var_00, int(var_10), "left");
      var_01 setweaponammostock(var_00, int(var_07 - var_09));
    }
  }
}

init_passive_melee_kill(var_00) {
  var_0.passive_melee_kill_damage = 0;
}

set_passive_melee_kill(var_00) {
  var_0.skip_weapon_check = 1;
  var_0.passive_melee_kill_damage = 1000;
  var_0.func_C54A["passive_meleekill"] = 1;
}

unset_passive_melee_kill(var_00) {
  var_0.skip_weapon_check = undefined;
  var_0.passive_melee_kill_damage = 0;
  var_0.func_C54A["passive_meleekill"] = 0;
}

handlemeleekillpassive(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");
  self endon("disconnect");

  if(var_03 != "MOD_MELEE") {
    return;
  }
  level thread handlegoreeffect(var_02);
  wait 0.05;
  var_06 = var_02 _meth_8113();

  if(isDefined(var_06)) {
    var_06 hide();
    var_6.permanentcustommovetransition = 1;
  }
}

handlegoreeffect(var_00) {
  var_01 = var_00 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var_01, (1, 0, 0));
  playLoopSound(var_01, "gib_fullbody");

  foreach(var_03 in level.players) {
  var_03 earthquakeforplayer(0.5, 1.5, var_01, 120);
  }
}

func_96B2(var_00) {}

func_F4B8(var_00) {
  var_0.func_C54A["passive_gore"] = 1;
}

func_12C05(var_00) {
  var_0.func_C54A["passive_gore"] = 0;
}

func_89AB(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");
  self endon("disconnect");
  var_02 endon("diconnect");
  wait 0.05;
  var_06 = var_02 _meth_8113();

  if(!isDefined(var_06)) {
    return;
  }
  var_07 = var_6.origin;
  earthquake(0.5, 1.5, var_07, 120);
  playFX(level._effect["corpse_pop"], var_07 + (0, 0, 12));

  if(isDefined(var_06)) {
    var_06 hide();
    var_6.permanentcustommovetransition = 1;
  }
}

init_passive_health_on_kill(var_00) {
  var_0.func_C93F = 0;
}

set_passive_health_on_kill(var_00) {
  var_0.func_C54A["passive_health_on_kill"] = 1;
}

unset_passive_health_on_kill(var_00) {
  var_0.func_C54A["passive_health_on_kill"] = 0;
}

handlehealthonkillpassive(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_1.func_C93F++;

  if(var_1.func_C93F >= 2) {
    var_01 notify("force_regeneration");
    var_1.func_C93F = 0;
  }
}

func_96B3(var_00) {
  var_0.func_C93F = 0;
}

func_F4B9(var_00) {
  var_0.func_C54A["passive_health_regen_on_kill"] = 1;
}

func_12C06(var_00) {
  var_0.func_C54A["passive_health_regen_on_kill"] = 0;
}

func_89B1(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(var_1.func_C93F >= 2) {
    var_01 notify("force_regeneration");
    var_1.func_C93F = 0;
  } else
    var_1.func_C93F++;
}

func_96B9(var_00) {
  var_0.weaponpassivespeedonkillmod = 0;
}

func_F4BF(var_00) {
  var_0.func_C54A["passive_move_speed_on_kill"] = 1;
}

func_12C0C(var_00) {
  var_0.func_C54A["passive_move_speed_on_kill"] = 0;
}

func_89C8(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "passive_move_speed_on_kill";
  var_01 notify(var_06);
  var_01 endon(var_06);

  if(var_1.weaponpassivespeedonkillmod != 0.075) {
    var_1.weaponpassivespeedonkillmod = 0.075;
    var_01[[level.move_speed_scale]]();
  }

  var_01 scripts\engine\utility::waittill_any_timeout(5, "death", "disconnect");

  if(!isDefined(var_01)) {
    return;
  }
  var_1.weaponpassivespeedonkillmod = 0;
  var_01[[level.move_speed_scale]]();
}

func_96BC(var_00) {}

func_F4C2(var_00) {
  var_0.cash_scalar = var_0.cash_scalar + 0.1;
  var_0.cash_scalar_weapon = scripts\cp\utility::getrawbaseweaponname(var_00 getcurrentweapon());
}

func_12C0F(var_00) {
  var_0.cash_scalar = var_0.cash_scalar - 0.1;
  var_0.cash_scalar_weapon = undefined;
}

func_96B4(var_00) {}

func_F4BA(var_00) {
  var_0.func_C54A["passive_hitman"] = 1;
}

func_12C07(var_00) {
  var_0.func_C54A["passive_hitman"] = 0;
}

func_89B3(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_01) || !scripts\cp\utility::isreallyalive(var_01) || !isDefined(var_02)) {
    return;
  }
  if(!isDefined(var_1.func_903C)) {
    var_1.func_903C = [];
  }
  else if(func_903B(var_01, var_2.birthtime)) {
    return;
  }
  var_01 thread func_E252();
  var_1.func_903C[var_1.func_903C.size] = var_2.birthtime;

  if(var_1.func_903C.size >= 10) {
    var_01 notify("consumable_charge", 200);
    var_1.func_903C = [];
  }
}

func_E252() {
  self notify("hitman_timeout");
  self endon("hitman_timeout");
  self endon("death");
  level endon("game_ended");
  wait 10;
  self.func_903C = [];
}

func_903B(var_00, var_01) {
  if(!isDefined(var_0.func_903C)) {
    return 0;
  }

  foreach(var_03 in var_0.func_903C) {
    if(var_03 == var_01) {
      return 1;
    }
  }

  return 0;
}

func_903D() {
  self endon("disconnect");
  self waittill("death");
  self.func_903C = undefined;
}

func_96BA(var_00) {
  var_0.func_C944 = 0;
  var_0.func_A9CA = 0;
  var_00 thread func_11AF6(var_00);
}

func_F4C0(var_00) {
  var_0.func_C54A["passive_nuke"] = 1;
}

func_12C0D(var_00) {
  var_0.func_C54A["passive_nuke"] = 0;
}

func_11AF4(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_1.func_C944++;

  if(var_1.func_C944 >= 150 && var_1.func_A9CA + 3 <= level.wave_num) {
    var_1.func_C944 = 0;
    level scripts\cp\loot::drop_loot(var_1.origin, var_01, "kill_50", 1);
  }
}

func_11AF6(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");

  for(;;) {
    var_00 waittill("last_stand");
    var_0.func_C944 = 0;
  }
}

func_961A(var_00) {}

func_F3FB(var_00) {
  var_0.func_C54A["passive_headshot_ammo"] = 1;
}

func_12BFF(var_00) {
  var_0.func_C54A["passive_headshot_ammo"] = 0;
}

func_89AE(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_01) || !isDefined(var_00)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(var_00, var_04, var_03, var_01)) {
    return;
  }
  var_06 = weaponclipsize(var_00);
  adjust_clip_ammo_from_stock(var_01, var_00, "right", var_06);

  if(var_01 isdualwielding()) {
    adjust_clip_ammo_from_stock(var_01, var_00, "left", var_06);
  }
}

adjust_clip_ammo_from_stock(var_00, var_01, var_02, var_03) {
  var_04 = var_00 getweaponammostock(var_01);

  if(var_04 < 1) {
    return;
  }
  var_05 = var_00 getweaponammoclip(var_01, var_02);
  var_06 = var_03 - var_05;

  if(var_04 >= var_06) {
    var_00 setweaponammostock(var_01, var_04 - var_06);
  }
  else {
    var_06 = var_04;
    var_00 setweaponammostock(var_01, 0);
  }

  var_07 = min(var_05 + var_06, var_03);
  var_00 setweaponammoclip(var_01, int(var_07), var_02);
}

init_passive_fortified(var_00) {
  var_0.has_fortified_passive = 0;
}

set_passive_fortified(var_00) {
  var_0.func_C5C9["passive_fortified"] = 1;
  var_0.has_fortified_passive = 1;
}

unset_passive_fortified(var_00) {
  var_0.func_C5C9["passive_fortified"] = 0;
  var_0.has_fortified_passive = 0;
}

handlefortified(var_00, var_01, var_02) {}

init_passive_ninja(var_00) {
  var_0.stealth_used = [];
  var_0.stealth_stacks = 0;
}

set_passive_ninja(var_00) {
  var_0.func_C5C9["passive_ninja"] = 1;
}

unset_passive_ninja(var_00) {
  var_0.func_C5C9["passive_ninja"] = 0;
}

handleninjaonlastshot(var_00, var_01, var_02) {
  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }
  var_03 = weaponclipsize(var_01);
  var_04 = var_00 getweaponammoclip(var_01, "right");

  if(var_04 == 0 && !scripts\engine\utility::array_contains(var_0.stealth_used, "right")) {
    set_player_stealthed(var_00, "right");
  }
  else if(var_04 > 0) {
    var_0.stealth_used = scripts\engine\utility::array_remove(var_0.stealth_used, "right");
  }

  if(var_00 isdualwielding()) {
    var_05 = var_00 getweaponammoclip(var_01, "left");

    if(var_05 == 0 && !scripts\engine\utility::array_contains(var_0.stealth_used, "left")) {
      set_player_stealthed(var_00, "left");
    }
    else if(var_05 > 0) {
      var_0.stealth_used = scripts\engine\utility::array_remove(var_0.stealth_used, "left");
    }
  }
}

set_player_stealthed(var_00, var_01) {
  var_00 scripts\cp\utility::allow_player_ignore_me(1);
  playFX(level._effect["stimulus_glow_burst"], scripts\engine\utility::drop_to_ground(var_0.origin) - (0, 0, 30));
  scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", scripts\engine\utility::drop_to_ground(var_0.origin) - (0, 0, 30));
  var_0.stealth_used = scripts\engine\utility::add_to_array(var_0.stealth_used, var_01);
  var_0.stealth_stacks++;

  if(var_00 isdualwielding()) {
    wait 3.0;
  }
  else {
    wait 4.0;
  }

  var_0.stealth_stacks--;

  if(var_0.stealth_stacks <= 0) {
    var_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.stealth_stacks = 0;
}

init_passive_last_shots_ammo(var_00) {}

set_passive_last_shots_ammo(var_00) {
  var_0.func_C54A["passive_ninja"] = 1;
}

unset_passive_last_shots_ammo(var_00) {
  var_0.func_C54A["passive_ninja"] = 0;
}

handleammoonlastshotskill(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_01) || !isDefined(var_00)) {
    return;
  }
  var_06 = weaponclipsize(var_00);
  var_07 = var_01 getweaponammoclip(var_00, "right");

  if(var_07 <= int(var_06 * 0.2)) {
    adjust_clip_ammo_from_stock(var_01, var_00, "right", var_06);
  }

  if(var_01 isdualwielding()) {
    var_07 = var_01 getweaponammoclip(var_00, "left");

    if(var_07 <= int(var_06 * 0.2)) {
      adjust_clip_ammo_from_stock(var_01, var_00, "left", var_06);
    }
  }
}

func_961B(var_00) {
  var_0.delayedsuperbonus = 0;
}

func_F3FC(var_00) {
  var_0.func_C54A["passive_headshot_super"] = 1;
}

func_12C00(var_00) {
  var_0.func_C54A["passive_headshot_super"] = 0;
}

func_1869(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_1.delayedsuperbonus++;
  wait(0.05 * var_1.delayedsuperbonus);
  var_1.delayedsuperbonus--;

  if(var_1.delayedsuperbonus < 0) {
    var_1.delayedsuperbonus = 0;
  }

  var_01 notify("consumable_charge", 10);
}

init_passive_sonic(var_00) {
  var_0.sonictimer = 0;
}

set_passive_sonic(var_00) {
  var_0.func_C4E6["passive_sonic"] = 1;
}

unset_passive_sonic(var_00) {
  var_0.func_C4E6["passive_sonic"] = 0;
}

handlepassivesonic(var_00, var_01, var_02) {
  var_03 = gettime();

  if(var_02 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }
  if(var_03 <= var_0.sonictimer) {
    return;
  }
  if(distance2dsquared(var_0.origin, var_2.origin) <= 62500) {
    thread scripts\cp\cp_weapon::fx_stun_damage(var_02, var_00);
  }

  var_0.sonictimer = var_03 + 1000;
}

init_passive_crouch_move_speed(var_00) {}

set_passive_crouch_move_speed(var_00) {
  var_00 thread adjust_move_speed_while_crouched(var_00);
}

unset_passive_crouch_move_speed(var_00) {
  var_00 notify("remove_crouch_speed_mod");
  var_0.weaponpassivespeedmod = undefined;
}

adjust_move_speed_while_crouched(var_00, var_01) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("remove_crouch_speed_mod");

  for(;;) {
    if(var_00 getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        var_0.weaponpassivespeedmod = 0.5;
        var_00[[level.move_speed_scale]]();
      }
    }

    while(var_00 getstance() == "crouch") {
      wait 0.1;
    }

    var_0.weaponpassivespeedmod = undefined;
    var_00[[level.move_speed_scale]]();
    var_00 waittill("adjustedStance");
  }
}

func_96B6(var_00) {}

func_F4BC(var_00) {
  var_00 scripts\cp\utility::enable_infinite_ammo(1);
  var_0.func_C5C9["passive_infinite_ammo"] = 1;
}

func_12C09(var_00) {
  var_00 scripts\cp\utility::enable_infinite_ammo(0);
  var_0.func_C5C9["passive_infinite_ammo"] = 0;
}

func_89B8(var_00, var_01) {
  var_00 thread func_AD6F(var_01);
  var_02 = 4;
  var_03 = self.health;

  if(var_03 - var_02 < 1) {
    var_02 = var_03 - 1;
  }

  if(var_02 > 0) {
    var_00 getrandomarmkillstreak(var_02, var_00 gettagorigin("j_wrist_ri"), var_00, undefined, "MOD_RIFLE_BULLET", "iw7_pickup_zm");
  }

  var_00 func_12EB2(var_01);
}

func_AD6F(var_00) {
  self endon("disconnect");
  self endon("last_stand");
  self notify("infinite_ammo_fire");
  self endon("infinite_ammo_fire");
  self.selfdamaging = 1;
  wait 0.2;
  self.selfdamaging = 0;
}

func_12EB2(var_00) {
  var_01 = self.health;
  var_02 = weaponclipsize(var_00);
  self setweaponammoclip(var_00, var_02);

  if(self isdualwielding()) {
    self setweaponammoclip(var_00, var_02, "left");
  }
}

func_96B7(var_00) {}

func_F4BD(var_00) {
  var_01 = var_00 getcurrentweapon();
  var_00 thread func_B8D5(var_01);
}

func_12C0A(var_00) {
  var_00 notify("removeMissRefundPassive");
}

func_B8D5(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", var_01);

    if(var_01 == var_00) {
      if(randomfloat(1.0) > 0.75) {
        var_02 = self getweaponammostock(var_00);
        self setweaponammostock(var_00, var_02 + 1);
      }
    }
  }
}

init_passive_scrambler(var_00) {}

set_passive_scrambler(var_00) {
  var_00 thread handlepassivescrambler(var_00);
}

unset_passive_scrambler(var_00) {
  var_00 notify("handlePassiveScrambler");
}

scrambler_executevisuals(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 = spawn("script_model", self gettagorigin("tag_eye"));
  var_01 setModel("prop_mp_optic_wave_scr");
  var_1.angles = self getplayerangles();
  var_01 setotherent(self);
  var_01 setscriptablepartstate("effects", "active", 0);
  var_02 = var_1.origin + anglesToForward(var_1.angles) * 256;
  var_01 moveto(var_02, var_00);
  scripts\engine\utility::waittill_any_timeout(var_00, "last_stand", "death");

  if(isDefined(var_01)) {
    var_01 delete();
  }
}

handlepassivescrambler(var_00) {
  var_00 notify("handlePassiveScrambler");
  var_00 endon("handlePassiveScrambler");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");

  for(;;) {
    if(randomint(100) > 85) {
      var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      var_02 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_01, undefined, 24, 256);
      var_03 = 0;

      foreach(var_05 in var_02) {
        if(scripts\engine\utility::within_fov(var_00 getEye(), var_0.angles, var_5.origin, cos(65))) {
          if(!var_03) {
            var_00 thread scrambler_executevisuals(0.8);
          }

          thread scrambler_stun_damage(var_05, var_00);
          var_3++;
        }

        if(var_03 >= 5) {
          break;
        }
      }
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

scrambler_stun_damage(var_00, var_01) {
  var_00 endon("death");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        var_0.scripted_mode = 1;
        var_0.ignoreall = 1;
        var_00 give_mp_super_weapon(var_0.origin);
      }

      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
    } else
      return;
  } else {
    if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
      var_0.scripted_mode = 1;
      var_0.ignoreall = 1;
      var_00 give_mp_super_weapon(var_0.origin);
    }

    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
  }

  var_00 getrandomarmkillstreak(1, var_0.origin, var_01, var_01, "MOD_UNKNOWN", "iw7_scrambler_zm");
  var_00 thread addhealthback(var_00);
  wait 1;

  if(var_00 scripts\mp\agents\zombie\zombie_util::iscrawling()) {
    var_0.scripted_mode = 0;
    var_0.ignoreall = 0;
  }

  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

addhealthback(var_00) {
  var_00 endon("death");
  waittillframeend;

  if(var_0.health < var_0.maxhealth) {
    var_0.health = var_0.health + 1;
  }
}

init_passive_random_perks(var_00) {
  var_0.passiverandomperkskillcount = 0;
  var_00 thread tracklaststandforpassiverandomperks(var_00);
}

tracklaststandforpassiverandomperks(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");

  for(;;) {
    var_00 waittill("last_stand");
    var_0.passiverandomperkskillcount = 0;
  }
}

set_passive_random_perks(var_00) {
  var_0.func_C54A["passive_random_perks"] = 1;
}

trackkillsforrandomperks(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_01 endon("disconnect");
  var_01 endon("last_stand");
  var_01 endon("death");
  var_1.passiverandomperkskillcount++;

  if(var_1.passiverandomperkskillcount >= 75) {
    var_06 = level.perks;
    var_1.passiverandomperkskillcount = 0;

    if(!isDefined(var_1.zombies_perks) || var_1.zombies_perks.size < 5) {
      for(;;) {
        var_07 = scripts\engine\utility::random(var_06);

        if(!var_01 scripts\cp\utility::has_zombie_perk(var_07)) {
          var_01 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_07, 0);
          break;
        } else
          var_06 = scripts\engine\utility::array_remove(var_06, var_07);

        scripts\engine\utility::waitframe();
      }
    }
  }
}

unset_passive_random_perks(var_00) {
  var_0.func_C54A["passive_random_perks"] = 0;
}

init_passive_melee_super(var_00) {}

set_passive_melee_super(var_00) {
  var_0.skip_weapon_check = 1;
  var_0.func_C54A["passive_melee_super"] = 1;
}

unset_passive_melee_super(var_00) {
  var_0.skip_weapon_check = undefined;
  var_0.func_C54A["passive_melee_super"] = 0;
}

handlemeleesuper(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");
  var_01 endon("disconnect");

  if(isDefined(var_03) && var_03 == "MOD_MELEE") {
    var_01 notify("consumable_charge", 125);
  }
}

init_passive_jump_super(var_00) {}

set_passive_jump_super(var_00) {
  var_0.func_C54A["passive_jump_super"] = 1;
  var_0.current_weapon_jump_super = scripts\cp\utility::getrawbaseweaponname(var_00 getcurrentweapon());
}

unset_passive_jump_super(var_00) {
  var_0.func_C54A["passive_jump_super"] = 0;
  var_0.current_weapon_jump_super = undefined;
}

handleairbornesuper(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");
  var_01 endon("disconnect");

  if(!var_01 isonground() && (isDefined(var_1.current_weapon_jump_super) && scripts\cp\utility::getrawbaseweaponname(var_00) == var_1.current_weapon_jump_super)) {
    var_01 notify("consumable_charge", 75);
  }
}

init_passive_double_kill_super(var_00) {}

set_passive_double_kill_super(var_00) {
  var_0.func_C54A["passive_double_kill_super"] = 1;
  var_0.current_weapon_double_super = scripts\cp\utility::getrawbaseweaponname(var_00 getcurrentweapon());
}

unset_passive_double_kill_super(var_00) {
  var_0.func_C54A["passive_double_kill_super"] = 0;
  var_0.current_weapon_double_super = undefined;
}

handledoublekillssuper(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");
  var_01 endon("disconnect");

  if(isDefined(var_1.func_DDC2) && (isDefined(var_1.current_weapon_double_super) && scripts\cp\utility::getrawbaseweaponname(var_00) == var_1.current_weapon_double_super)) {
    if(var_1.func_DDC2 == 2) {
      var_01 notify("consumable_charge", 125);
    }
  }
}

init_passive_mode_switch_score(var_00) {}

set_passive_mode_switch_score(var_00) {
  var_0.alt_mode_passive = 1;
  var_0.cash_scalar_alt_weapon = scripts\cp\utility::getrawbaseweaponname(var_00 getcurrentweapon());
  var_0.cash_scalar = var_0.cash_scalar + 0.1;
}

unset_passive_mode_switch_score(var_00) {
  var_0.cash_scalar = var_0.cash_scalar - 0.1;
  var_0.cash_scalar_alt_weapon = undefined;
  var_0.alt_mode_passive = 0;
}

init_passive_visor_detonation(var_00) {}

set_passive_visor_detonation(var_00) {
  var_0.func_C54A["passive_visor_detonation"] = 1;
}

unset_passive_visor_detonation(var_00) {
  var_0.func_C54A["passive_visor_detonation"] = 0;
}

handlevisordetonation(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!scripts\engine\utility::isbulletdamage(var_03)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(var_00, var_04, var_03, var_01)) {
    return 0;
  }

  if(isDefined(var_2.agent_type) && (var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey" || var_2.agent_type == "slasher" || var_2.agent_type == "superslasher" || var_2.agent_type == "zombie_sasquatch" || var_2.agent_type == "lumberjack")) {
    return;
  }
  var_06 = scripts\engine\utility::is_true(var_2.is_suicide_bomber);
  var_2.head_is_exploding = 1;
  var_07 = var_02 gettagorigin("j_spine4");
  playLoopSound(var_2.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_07);

  foreach(var_01 in level.players) {
    if(distance(var_1.origin, var_07) <= 350) {
      var_01 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(isDefined(var_2.headmodel)) {
    var_02 detach(var_2.headmodel);
  }

  if(!var_06) {
    var_02 setscriptablepartstate("head", "hide");
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

init_passive_berserk(var_00) {}

set_passive_berserk(var_00) {
  var_0.func_C54A["passive_berserk"] = 1;
}

unset_passive_berserk(var_00) {
  var_0.func_C54A["passive_berserk"] = 0;
}

handleberserk(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!scripts\engine\utility::is_true(var_1.berserk)) {
    var_1.berserk = 1;
    var_01 _meth_85C1(65);
    var_06 = var_01 _meth_85C0();

    if(var_06 < 0) {
      var_06 = 100;
    }

    var_06 = max(var_06 - 20, 0);
    var_01 getweaponrankinfomaxxp(int(var_06));
  }

  var_01 notify("stop_berserk_timer");
  var_01 thread remove_berserk_after_timeout(2);
}

remove_berserk_after_timeout(var_00) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelberserk();
  wait(var_00);
  unset_berserk();
}

listencancelberserk() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("death", "weapon_change");
  unset_berserk();
}

unset_berserk() {
  if(scripts\engine\utility::is_true(self.berserk)) {
    self.berserk = 0;
    self _meth_85C2();
    var_00 = self _meth_85C0();
    var_00 = min(var_00 + 20, 100);
    self getweaponrankinfomaxxp(int(var_00));
    self notify("end_berserk");
  }
}

unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unset_berserk();
}

init_passive_melee_cone_expl(var_00) {}

set_passive_melee_cone_expl(var_00) {
  var_0.func_C54A["passive_melee_cone_expl"] = 1;
  var_0.skip_weapon_check = 1;
}

unset_passive_melee_cone_expl(var_00) {
  var_0.func_C54A["passive_melee_cone_expl"] = 0;
  var_0.skip_weapon_check = undefined;
}

handlemeleeconeexplode(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(var_03 != "MOD_MELEE") {
    return;
  }
  if(!issubstr(var_00, "meleervn") && !var_01 _meth_8519(var_00)) {
    return;
  }
  var_06 = var_02 gettagorigin("j_spineupper");
  var_07 = var_01 getplayerangles();
  var_08 = anglesToForward(var_07);
  var_09 = anglestoup(var_07);
  var_10 = var_06 - var_08 * 128;
  var_11 = 384;
  playFX(level._effect["cone_expl_fx"], var_06 + (0, 2, 0), var_08, var_09);
  var_12 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(var_14 in var_12) {
    if(isDefined(var_14.flung) || isDefined(var_14.agent_type) && (var_14.agent_type == "zombie_brute" || var_14.agent_type == "zombie_ghost" || var_14.agent_type == "zombie_grey" || var_14.agent_type == "slasher" || var_14.agent_type == "superslasher")) {
      continue;
    }
    if(!scripts\cp\utility::pointvscone(var_14 gettagorigin("tag_origin"), var_10, var_08, var_09, var_11, 128, 12)) {
      continue;
    }
    if(var_14 damageconetrace(var_06, var_01) <= 0) {
      continue;
    }
    var_15 = int(1500 * var_01 scripts\cp\cp_weapon::get_weapon_level(var_00));
    wait 0.05;
    var_14 getrandomarmkillstreak(var_15, var_06, var_01, var_01, "MOD_EXPLOSIVE", var_00);
  }
}

init_passive_minimap_damage(var_00) {}

set_passive_minimap_damage(var_00) {
  var_0.func_C4E6["passive_minimap_damage"] = 1;
}

unset_passive_minimap_damage(var_00) {
  var_0.func_C4E6["passive_minimap_damage"] = 0;
}

updatepassiveminimapdamage(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    return;
  }
  var_03 = 4;
  var_04 = 1;
  var_05 = 1;

  if(isDefined(var_2.damaged_by_players)) {
    var_03 = 5;
  }

  if(isDefined(var_2.marked_for_challenge)) {
    var_03 = 0;
  }
  else {
    var_03 = 4;
  }

  level thread set_outline_passive_minimap_damage(var_00, var_02, var_03, var_04, var_05);
}

enable_outline_for_players(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 hudoutlineenableforclients(var_01, var_02, var_03, var_04);
}

set_outline_passive_minimap_damage(var_00, var_01, var_02, var_03, var_04) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(var_01)) {
    return;
  }
  if(!isDefined(var_02)) {
    var_02 = 4;
  }

  if(!isDefined(var_03)) {
    var_03 = 1;
  }

  if(!isDefined(var_04)) {
    var_04 = 1;
  }

  enable_outline_for_players(var_01, level.players, var_02, 1, 1, "high");
  wait 10;
  unset_outline_passive_minimap_damage(var_01);
}

disable_outline_for_players(var_00, var_01) {
  var_00 hudoutlinedisableforclients(var_01);
}

unset_outline_passive_minimap_damage(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  scripts\cp\cp_outline::disable_outline_for_players(var_00, level.players);
}

activate_adrenaline_boost(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_00 scripts\cp\utility::adddamagemodifier("health_boost", 0.2, 0);
  var_00 notify("force_regeneration");
  var_00 playlocalsound("breathing_heartbeat_alt");
  wait 5;
  var_00 scripts\cp\utility::removedamagemodifier("health_boost", 0);
  var_00 playlocalsound("breathing_limp");
}

adr_boost(var_00) {
  var_00 notify("updatepassiveminimapdamage");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");

  for(;;) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(var_00, 5);
      thread activate_adrenaline_boost(var_00);
    }

    wait(randomfloatrange(5.0, 15.0));
  }
}

remove_adrenaline_visuals(var_00) {
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_00 setscriptablepartstate("passive_armor", "neutral", 0);
  var_00 setscriptablepartstate("armor_active", "neutral", 0);
  var_00 visionsetnakedforplayer("", 0.5);
}

run_adrenaline_visuals(var_00, var_01) {
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_00 endon("remove_adrenaline_visuals");
  self setscriptablepartstate("passive_armor", "active", 0);
  self setscriptablepartstate("armor_active", "active", 0);
  var_00 visionsetnakedforplayer("missilecam", scripts\engine\utility::ter_op(1, 0.1, 0.0));
  var_00 scripts\engine\utility::waittill_any_timeout(var_01, "last_stand");
  var_00 thread remove_adrenaline_visuals(var_00);
}

init_passive_cold_damage(var_00) {}

set_passive_cold_damage(var_00) {
  var_0.func_C4E6["passive_cold_damage"] = 1;
  var_0.cold_weapon = var_00 getcurrentweapon();
}

unset_passive_cold_damage(var_00) {
  var_0.func_C4E6["passive_cold_damage"] = 0;
  var_0.cold_weapon = undefined;
}

updatepassivecolddamage(var_00, var_01, var_02) {
  var_03 = isDefined(var_2.agent_type) && var_2.agent_type == "zombie_brute";
  var_04 = isDefined(var_2.agent_type) && var_2.agent_type == "zombie_grey";
  var_05 = scripts\engine\utility::is_true(var_2.is_suicide_bomber);

  if(var_03 || var_04 || var_05) {
    return;
  }
  if(isDefined(var_0.cold_weapon)) {
    if(scripts\cp\utility::getrawbaseweaponname(var_0.cold_weapon) == scripts\cp\utility::getrawbaseweaponname(var_01)) {
      var_2.movemode = "slow_walk";
      var_02 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
    }
  }
}

init_passive_scorestreak_damage(var_00) {}

set_passive_scorestreak_damage(var_00) {
  var_0.special_zombie_damage = 1.1;
}

unset_passive_scorestreak_damage(var_00) {
  var_0.special_zombie_damage = undefined;
}

init_passive_scope_radar(var_00) {
  var_0.activate_radar = 0;
  var_00 notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  var_00 notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

set_passive_scope_radar(var_00) {
  var_00 thread updatescoperadar(var_00);
}

unset_passive_scope_radar(var_00) {
  var_00 notify("unsetScopeRadar");
  var_00 thread cleanup_outlines(var_00);
}

updatescoperadar(var_00) {
  var_00 notify("updateScopeRadar");
  var_00 endon("updateScopeRadar");
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 endon("unsetScopeRadar");
  var_01 = 2.4;
  var_02 = 1750;

  for(;;) {
    if(!var_00 adsbuttonpressed()) {
      var_03 = var_00 scripts\engine\utility::waittill_any_return_no_endon_death("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    }
    else {
      var_03 = "scope_radar_ads_in";
    }

    if(var_03 == "scope_radar_ads_in") {
      runscoperadarinloop(var_00, var_01, var_02);
    }

    var_00 thread remove_visuals(var_00);
  }
}

runscoperadarinloop(var_00, var_01, var_02) {
  level endon("game_ended");
  var_00 notify("runScopeRadarInLoop");
  var_00 endon("runScopeRadarInLoop");
  var_00 endon("scope_radar_ads_out");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_03 = 0.75;

  while(var_00 adsbuttonpressed()) {
    if(var_00 playerads() >= var_03) {
      var_00 playlocalsound("uav_ping");
      var_00 thread scoperadar_executeping(var_00, var_01, var_02);
      var_00 scoperadar_executevisuals(var_00, var_01);
    }

    scripts\engine\utility::waitframe();
  }
}

scoperadar_executeping(var_00, var_01, var_02) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("scope_radar_ads_out");
  var_03 = 0;
  var_04 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_05 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_04, undefined, 24, var_02);
  var_0.closestenemies = var_05;
  var_06 = 0;

  foreach(var_08 in var_0.closestenemies) {
    var_8.is_outlined_from_scoperadar = 0;

    if(scripts\engine\utility::within_fov(var_00 getEye(), var_0.angles, var_8.origin, cos(65))) {
      var_6++;
      var_09 = var_8.origin - var_0.origin;

      if(1 && vectordot(anglesToForward(var_0.angles), var_09) < 0) {
        continue;
      }
      var_10 = var_02 * var_02;

      if(length2dsquared(var_09) > var_10) {
        continue;
      }
      var_00 thread func_C7A7(var_08, var_00, distance2d(var_0.origin, var_8.origin) / var_02, var_01);
      var_03 = 1;
    }
  }
}

enable_outline_for_player(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 hudoutlineenableforclient(var_01, var_02, var_03, var_04);
}

func_C7A7(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  var_01 endon("scope_radar_ads_out");
  var_01 endon("last_stand");
  var_01 endon("death");
  var_01 endon("disconnect");
  var_01 endon("weapon_change");
  wait(var_03 * var_02);
  var_04 = 1;
  var_0.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(var_00, var_01, var_04, 1, 1, "high");
}

func_13AA0(var_00, var_01, var_02) {
  var_00 endon("disconnect");
  level endon("game_ended");
  var_00 scripts\engine\utility::waittill_any_timeout_no_endon_death(var_02);

  if(isDefined(var_01)) {
    disable_outline_for_player(var_01, var_00);
  }
}

disable_outline_for_player(var_00, var_01) {
  var_00 hudoutlinedisableforclient(var_01);
}

scoperadar_executevisuals(var_00, var_01) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 visionsetnakedforplayer("opticwave_mp", 0.2);
  var_0.fxent = spawn("script_model", var_00 gettagorigin("tag_eye"));
  var_0.fxent setModel("prop_mp_optic_wave_scr");
  var_0.fxent.angles = var_00 getplayerangles();
  var_0.fxent setotherent(var_00);
  var_0.fxent setscriptablepartstate("effects", "active", 0);
  var_02 = var_0.fxent.origin + anglesToForward(var_0.fxent.angles) * 1750;
  var_0.fxent moveto(var_02, var_01);
  var_00 scripts\engine\utility::waittill_any_timeout_no_endon_death(var_01, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");

  if(isDefined(var_0.closestenemies)) {
    foreach(var_04 in var_0.closestenemies) {
      if(isDefined(var_04)) {
        if(scripts\engine\utility::is_true(var_4.is_outlined_from_scoperadar)) {
          disable_outline_for_player(var_04, var_00);
          var_4.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }

  if(scripts\engine\utility::is_true(var_0.wearing_dischord_glasses)) {
    var_00 visionsetnakedforplayer("cp_zmb_bw", 0.1);
  }
  else if(scripts\engine\utility::is_true(var_0.rave_mode)) {
    var_00 visionsetnakedforplayer("cp_rave_rave_mode", 0.1);
  }
  else {
    var_00 visionsetnakedforplayer("", 0.1);
  }

  if(isDefined(var_0.fxent)) {
    var_0.fxent delete();
  }
}

remove_visuals(var_00) {
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_03 in var_01) {
    if(isDefined(var_03)) {
      if(scripts\engine\utility::is_true(var_3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_03, var_00);
        var_3.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(scripts\engine\utility::is_true(var_0.wearing_dischord_glasses)) {
    var_00 visionsetnakedforplayer("cp_zmb_bw", 0.1);
  }
  else if(scripts\engine\utility::is_true(var_0.rave_mode)) {
    var_00 visionsetnakedforplayer("cp_rave_rave_mode", 0.1);
  }
  else {
    var_00 visionsetnakedforplayer("", 0.1);
  }

  if(isDefined(var_0.fxent)) {
    var_0.fxent delete();
  }
}

cleanup_outlines(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("last_stand");
  var_00 endon("death");
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_03 in var_01) {
    if(isDefined(var_03)) {
      if(scripts\engine\utility::is_true(var_3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_03, var_00);
        var_3.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

func_96BD(var_00) {}

func_F4C3(var_00) {
  var_00 thread updatescoutping(var_00);
}

func_12C10(var_00) {
  var_00 notify("unsetScoutPing");
}

updatescoutping(var_00) {
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 endon("unsetScoutPing");
  var_01 = 50;
  var_02 = 0.1;

  for(;;) {
    var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_04 = var_01;
    var_05 = var_02;
    var_04 = int(var_04);
    var_05 = int(var_05);
    var_06 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_03, undefined, 24, var_04);

    if(var_6.size >= 1) {
      foreach(var_08 in var_06) {
        scripts\cp\cp_outline::enable_outline_for_players(var_08, level.players, 7, 0, 0, "low");
        wait(var_05);
      }

      continue;
    }

    wait(var_02 / 1200);
  }
}

func_12EDF(var_00, var_01, var_02, var_03, var_04) {
  var_05 = gettime();
  var_06 = getarraykeys(var_1.func_C54A);

  if(!scripts\engine\utility::is_true(var_1.skip_weapon_check) && isDefined(var_1.current_passive_weapon) && var_00 != var_1.current_passive_weapon) {
    return;
  }
  foreach(var_08 in var_06) {
    if(scripts\engine\utility::is_true(var_1.func_C54A[var_08])) {
      thread[[level.func_C54A[var_08]]](var_00, var_01, var_02, var_03, var_04, var_05);
    }
  }
}

func_12EE1(var_00, var_01) {
  var_02 = gettime();
  var_03 = getarraykeys(var_0.func_C5C9);

  foreach(var_05 in var_03) {
    if(scripts\engine\utility::is_true(var_0.func_C5C9[var_05])) {
      thread[[level.func_C5C9[var_05]]](var_00, var_01);
    }
  }
}

func_12EDD(var_00, var_01, var_02) {
  var_03 = gettime();
  var_04 = getarraykeys(var_0.func_C4E6);

  foreach(var_06 in var_04) {
    if(scripts\engine\utility::is_true(var_0.func_C4E6[var_06])) {
      thread[[level.func_C4E6[var_06]]](var_00, var_01, var_02);
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

func_13C36(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_01 = undefined;
  var_0.func_D8A7 = undefined;
  var_0.func_1607 = [];

  while(!isDefined(var_0.weaponkitinitialized)) {
    wait 0.1;
  }

  var_00 func_94F1(var_00);

  for(;;) {
    if(!isDefined(var_01) || isDefined(var_01) && !scripts\cp\utility::is_melee_weapon(getweaponbasename(var_01), 1)) {
      var_02 = var_00 getcurrentprimaryweapon();

      if(!isDefined(var_02)) {
        wait 0.05;
        continue;
      }

      if(var_02 == "none") {
        wait 0.05;
        continue;
      }

      if(isDefined(var_0.func_D8A7)) {
        func_12C64(var_00, var_0.func_D8A7);
      }

      func_F616(var_00, var_02);
      var_0.current_passive_weapon = var_02;
      var_0.func_D8A7 = var_02;
    }

    var_00 waittill("weapon_change", var_01);
  }
}

func_94F1(var_00) {
  var_01 = [];

  foreach(var_03 in var_0.func_13C38) {
    foreach(var_05 in var_03) {
      if(scripts\engine\utility::array_contains(var_01, var_05)) {
        continue;
      }
      if(isDefined(level.func_462E[var_05])) {
        var_06 = level.func_462E[var_05];

        if(isDefined(var_06) && isDefined(var_6.init_func)) {
          [[var_6.init_func]](var_00);
        }
      }

      var_01 = scripts\engine\utility::array_add(var_01, var_05);
    }
  }
}

func_12C64(var_00, var_01) {
  var_01 = scripts\cp\utility::getweaponrootname(var_01);

  if(!isDefined(var_0.func_13C38[var_01])) {
    return;
  }
  var_02 = var_0.func_13C38[var_01];

  foreach(var_04 in var_02) {
    if(isDefined(level.func_462E[var_04])) {
      var_05 = level.func_462E[var_04];

      if(isDefined(var_05) && isDefined(var_5.func_12BFB)) {
        [[var_5.func_12BFB]](var_00);
      }
    }

    var_0.func_1607 = scripts\engine\utility::array_remove(var_0.func_1607, var_04);
  }
}

func_F616(var_00, var_01) {
  var_01 = scripts\cp\utility::getweaponrootname(var_01);

  if(!isDefined(var_0.func_13C38[var_01])) {
    return;
  }
  var_02 = var_0.func_13C38[var_01];

  foreach(var_04 in var_02) {
    if(scripts\engine\utility::array_contains(var_0.func_1607, var_04)) {
      continue;
    }
    var_05 = level.func_462E[var_04];

    if(isDefined(var_05) && isDefined(var_5.func_F3C3)) {
      [[var_5.func_F3C3]](var_00);
    }

    var_0.func_1607 = scripts\engine\utility::array_add(var_0.func_1607, var_04);
  }
}

func_DEDF(var_00, var_01, var_02, var_03) {
  var_04 = spawnStruct();
  var_4.init_func = var_01;
  var_4.func_F3C3 = var_02;
  var_4.func_12BFB = var_03;
  level.func_462E[var_00] = var_04;
}

func_7D6C(var_00, var_01) {
  var_02 = scripts\cp\utility::get_weapon_variant_id(var_00, var_01);
  var_03 = [];

  if(!isDefined(var_02) || var_02 == -1) {
    return var_03;
  }

  var_04 = "mp\loot\weapon\" + var_01 + ".csv ";
  var_05 = tablelookuprownum(var_04, 0, var_02);

  for(var_06 = 0; var_06 < 3; var_6++) {
    var_07 = tablelookupbyrow(var_04, var_05, 21 + var_06);

    if(isDefined(var_07) && var_07 != "") {
      var_3[var_3.size] = var_07;
    }
  }

  return var_03;
}

func_1772(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(level.passivemap)) {
    level.passivemap = [];
  }

  var_08 = spawnStruct();
  var_8.name = var_00;
  var_8.func_13CDE = scripts\engine\utility::ter_op(isDefined(var_04), 0, 1);
  var_8.killstreaktype = scripts\engine\utility::ter_op(isDefined(var_05), 0, 1);
  var_8.func_ABCA = scripts\engine\utility::ter_op(isDefined(var_06), 0, 1);
  var_8.func_113D1 = scripts\engine\utility::ter_op(isDefined(var_07), 0, 1);

  if(isDefined(var_01)) {
    var_8.attachmentroll = var_01;
  }

  if(isDefined(var_02)) {
    var_8.func_CA59 = var_02;
  }

  if(isDefined(var_03)) {
    var_8.func_B689 = var_03;
  }

  if(!isDefined(level.passivemap[var_00])) {
    level.passivemap[var_00] = var_08;
  }
}