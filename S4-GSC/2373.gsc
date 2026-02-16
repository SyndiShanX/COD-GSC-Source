/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2373.gsc
*************************************************/

_id_8255() {
  _id_7F36();
  scripts\cp\covenants\cp_covenants::init_covenants();
}

_id_7F66() {
  if(!isDefined(level._id_7633)) {
    level._id_7633 = 1;
  }

  level._id_5808 = ::_id_DAA6;
  self._id_AFAA = [];
  self._id_AFAA["max_health"] = 100 * level._id_7633;
  self._id_AFAA["regen_time_scalar"] = 1;
  self._id_AFAA["melee_scalar"] = 1.0;
  self._id_AFAA["melee_stun_radius"] = 0;
  self._id_AFAA["revive_time_scalar"] = 1.0;
  self._id_AFAA["move_speed_scalar"] = 1.0;
  self._id_AFAA["revive_damage_scalar"] = 1.0;
  self._id_AFAA["explosive_damage_scalar"] = 1.0;
  self._id_AFAA["offhand_count"] = 1;
  self._id_AFAA["launcher_ammo"] = 4;
  self._id_AFAA["friendly_explosive_damage_reduction"] = 1;
  self._id_AFAA["enemy_explosive_damage_reduction"] = 1;
  self._id_AFAA["bullet_damage_scalar"] = 1.0;
  self._id_AFAA["stealth_dist_scalar"] = 1;
  self._id_AFAA["stealth_velocity_override"] = 0;
  self._id_AFAA["stealth_weapon_noise_scalar"] = 1;
  self._id_AFAA["short_range_damage_scalar"] = 1;
  self._id_AFAA["hipfire_damage_scalar"] = 1;
  self._id_AFAA["sprint_damage_scalar"] = 1;
  self._id_AFAA["carrying_melee_damage_scalar"] = 1;
  self._id_AFAA["increased_materials"] = 0;
  self._id_AFAA["increased_materials_wallet"] = 0;
  self._id_AFAA["additional_crafting_items"] = 0;
  self._id_AFAA["cheap_crafting_recipe"] = 0;
  self._id_AFAA["increased_materials"] = 0;
  self._id_AFAA["increased_materials_wallet"] = 0;
  self._id_AFAA["additional_crafting_items"] = 0;
  self._id_AFAA["cheap_crafting_recipe"] = 0;
  self._id_AFAA["super_fill_scalar"] = 1;
  self._id_AFAA["weapons_have_full_ammo"] = 1;
  self._id_AFAA["enemy_damage_to_player_armor_scalar"] = 1;
  self._id_AFAA["damage_to_enemy_armor_scalar"] = 1;
  self._id_AFAA["downed_duration_increase"] = 0;
  self._id_AFAA["crit_damage_increase"] = 1;
  self._id_AFAA["essence_value"] = 1;
  self._id_AFAA["salvage_pickup_value"] = 1;
  self._id_AFAA["brain_rot_chance"] = 0;
  self._id_AFAA["brain_rot_duration"] = 0;
  self._id_AFAA["brain_rot_cooldown"] = 0;
  self._id_AFAA["brain_rot_explosion_radius"] = 0;
  self._id_AFAA["brain_rot_max_explosion_turn"] = 0;
  self._id_AFAA["brain_rot_explosion_damage"] = 0;
  self._id_AFAA["brain_rot_explosion_cooldown"] = 0;
  self._id_AFAA["cryofreeze_chance"] = 0;
  self._id_AFAA["cryofreeze_duration"] = 0;
  self._id_AFAA["cryofreeze_cooldown"] = 0;
  self._id_AFAA["cryofreeze_slow_amount"] = 0;
  self._id_AFAA["cryofreeze_affects_specials"] = 0;
  self._id_AFAA["cryofreeze_explosion_cooldown"] = 0;
  self._id_AFAA["cryofreeze_explosion_damage"] = 0;
  self._id_AFAA["armor_pickup_value"] = 1;
  self._id_AFAA["armor_durability"] = 1;
  self._id_AFAA["field_upgrade_charge"] = 1;
  self._id_AFAA["field_upgrade_improvement"] = 1;
  self._id_AFAA["ammo_drop_increase"] = 0;
  self._id_AFAA["downed_crawl_speed"] = 0;
  self._id_AFAA["weapon_damage_scalar"] = 1;
  self._id_AFAA["head_popper_returned_bullet"] = 0;
  self._id_AFAA["bloodlust_extra_damage"] = 0;
  self._id_AFAA["bloodlust_heal"] = 0;
  self._id_AFAA["move_speed_increase"] = 0;
  self._id_AFAA["splatterfest_min_chance"] = 0;
  self._id_AFAA["splatterfest_max_chance"] = 0;
  self._id_AFAA["splatterfest_chance_per_failure"] = 0;
  self._id_AFAA["keep_equipment_chance"] = 0;
  self._id_AFAA["gain_equipment_chance"] = 0;
  self._id_AFAA["stationary_damage_increase"] = 0;
  self._id_AFAA["stationary_damage_increase_duration"] = 0;
  self._id_AFAA["cull_the_weak_extra_damage"] = 0;
  self._id_AFAA["cull_the_weak_crit_damage_multiplier"] = 1;
  self._id_AFAA["ammo_refill_from_stock_rate"] = 0;
  self._id_AFAA["consecutive_hit_damage_increase"] = 0;
  self._id_AFAA["consecutive_hit_damage_max"] = 0;
  self._id_AFAA["proximity_revive_distance"] = 0;
  self._id_AFAA["brimstone_damage_per_second"] = 0;
  self._id_AFAA["brimstone_radius"] = 0;
  self._id_AFAA["dead_wire_chance"] = 0;
  self._id_AFAA["dead_wire_duration"] = 0;
  self._id_AFAA["dead_wire_cooldown"] = 0;
  self._id_AFAA["dead_wire_additional_targets"] = 0;
  self._id_AFAA["dead_wire_arc_distance"] = 0;
  self._id_AFAA["dead_wire_arc_cooldown"] = 0;
  self._id_AFAA["deadshot_daiquiri_bonus_damage"] = 0;
  self._id_AFAA["salvage_pickup_increase"] = 1;
  self._id_AFAA["salvage_bonus_increase"] = 1;
  self._id_AFAA["swift_vengeance_max_damage"] = 0;
  self._id_AFAA["swift_vengeance_activation_time"] = 0;
  self._id_AFAA["swift_vengeance_max_damage"] = 0;
  self._id_AFAA["artifact_defense_chance"] = 0;
  self._id_AFAA["artifact_defense_cooldown"] = 0;
  self._id_AFAA["explosives_expert_enemy_multiplier"] = 0;
  self._id_AFAA["explosives_expert_self_reduction"] = 0;
  self._id_AFAA["critical_expertise_chance"] = 0;
  self._id_AFAA["critical_expertise_multiplier"] = 1;
  self._id_AFAA["hack_speed_boost"] = 0;
  thread _id_06FC::_id_F3D6();
  _id_06CB::_id_AA4A(::_id_AA4A);
  _id_7F25();
}

_id_7F25() {
  self _meth_82D3(1.0);
  self notify("end_medic_health_regen");

  if(isDefined(self._id_AA23)) {
    self setviewkickscale(self._id_AA23);
    self._id_AA23 = undefined;
  }

  if(isDefined(self._id_AA1B)) {
    self player_recoilscaleon(100);
    self._id_AA1B = undefined;
  }
}

_id_664E(var_0) {
  if(isDefined(self._id_AFAA) && isDefined(self._id_AFAA[var_0])) {
    return self._id_AFAA[var_0];
  }
}

_id_D2EB(var_0, var_1) {
  if(isDefined(self._id_AFAA[var_0])) {
    self._id_AFAA[var_0] = var_1;
  }
}

_id_253B() {}

_id_9D02() {
  self._id_AFAA["move_speed_scalar"] = 1.12;
  self._id_A25F = 1.12;
  thread _id_073C::_id_FCCC();
}

_id_9CFF(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  self endon("giving_class");
  var_1 = var_0 > 0.0;

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_3._id_9D01)) {
        if(var_1 && distancesquared(self.origin, var_3.origin) > var_0) {
          continue;
        }
      }
    }

    wait 1.0;
  }
}

_id_9D00() {
  self endon("death");
  self endon("disconnect");
  self._id_9D01 = 1;
  wait 1.0;
  self.health = int(min(self.maxhealth, self.health + 5.0));
  self._id_9D01 = undefined;
}

_id_DAA6(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "power_concussionGrenade":
      case "power_gasGrenade":
      case "power_frag":
      case "power_atMine":
      case "power_throwingKnife":
      case "power_semtex":
      case "power_smokeGrenade":
      case "power_molotov":
      case "power_thermite":
      case "power_snapshotGrenade":
      case "power_claymore":
      case "power_c4":
        return self._id_AFAA["offhand_count"];
      default:
        break;
    }
  }

  return undefined;
}

_id_C313() {
  for(;;) {
    self waittill("kill_score");
    var_0 = self getcurrentprimaryweapon();
    var_1 = self _meth_8109(var_0);
    var_2 = int(min(var_1, weaponclipsize(var_0)));
    var_3 = var_1 - var_2;
    self setweaponammoclip(var_0, var_2);
    self setweaponammostock(var_0, var_3);
    wait 0.1;
  }
}

_id_6EE8() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "doubletap");
  }
}

_id_6ED0() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "fmj");
  }
}

_id_C177() {
  self._id_AA23 = self getviewkickscale();
  self._id_AD1D = 0;
  self._id_AA1B = self _meth_8611();
  self player_recoilscaleon(0);
  self._id_AAFE = 1;
  scripts\cp\cp_weapon::_id_FD7E();
}

_id_C43B() {
  if(isDefined(self._id_AA1B)) {
    if(self._id_AA1B != -1) {
      self player_recoilscaleon(self._id_AA1B);
    } else {
      self player_recoilscaleon(100);
    }

    self._id_AA1B = undefined;
  }

  self._id_AD1D = undefined;
  self._id_AAFE = undefined;
  scripts\cp\cp_weapon::_id_FD7E();
}

_id_C172() {
  scripts\cp\utility::_id_6FC2("specialty_bulletaccuracy");
  self _meth_82D3(0.1);
}

_id_C9BE() {
  self endon("disconnect");
  self endon("end_deadeye_charge_watcher");
  self endon("giving_class");
  self._id_439C = undefined;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 500;

  for(;;) {
    if(self adsButtonPressed()) {
      var_3 = gettime();

      if(!isDefined(var_0)) {
        var_0 = var_3;
        var_1 = var_3 + var_2;
      } else if(var_3 > var_1) {
        if(!istrue(self._id_439C)) {}

        self._id_439C = 1;
      }
    } else {
      self._id_439C = undefined;
      var_0 = undefined;
      var_1 = undefined;
    }

    wait 0.05;
  }
}

_id_7F36() {
  level._id_AFFB = [];
  level._id_CF95 = [];
  level._id_AFFB = [];
  level._id_B000 = [];
  level._id_CF95["specialty_falldamage"] = 1;
  level._id_CF95["specialty_armorpiercing"] = 1;
  level._id_CF95["specialty_gung_ho"] = 1;
  level._id_CF95["specialty_momentum"] = 1;
  level._id_CF95["specialty_remote_defuse"] = 1;
  level._id_AFFB["specialty_momentum"] = ::_id_D5FF;
  level._id_B000["specialty_momentum"] = ::_id_FABF;
  level._id_AFFB["specialty_falldamage"] = ::_id_D56C;
  level._id_B000["specialty_falldamage"] = ::_id_FA96;
  level._id_AFFB["specialty_remote_defuse"] = ::_id_D6A6;
  level._id_B000["specialty_remote_defuse"] = ::_id_FAE7;
  level._id_CF95["specialty_hustle"] = 1;
  level._id_5853["specialty_hustle"] = ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement"];
  level._id_CF95["specialty_bulletdamage"] = 1;
  level._id_5853["specialty_bulletdamage"] = ["specialty_overcharge"];
  level._id_AFFB["specialty_overcharge"] = ::_id_D62E;
  level._id_B000["specialty_overcharge"] = ::_id_FAC9;
  _id_C2B1("specialty_restock", undefined, undefined, ["specialty_recharge_equipment"]);
  _id_C2B1("specialty_recharge_equipment", ::_id_6F45, ::_id_ED9A);
  _id_C2B1("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade"]);
  _id_C2B1("specialty_improved_field_upgrades");
  _id_C2B1("specialty_faster_field_upgrade", ::_id_6F62, ::_id_EDA1);
  _id_C2B1("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective"]);
  _id_C2B1("specialty_reduce_regen_delay_on_kill", ::_id_D69D, ::_id_FAE1);
  _id_C2B1("specialty_reduce_regen_delay_on_objective", ::_id_D69E, ::_id_FAE2);
  _id_C2B1("specialty_hardline", ::_id_D589, ::_id_FAA0);
  _id_C2B1("specialty_warhead", ::_id_6EC4, ::_id_ED81, ["specialty_fastreload_launchers"]);
  _id_C2B1("specialty_fastreload_launchers", ::_id_D55C, ::_id_FA92);
  _id_C2B1("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  _id_C2B1("specialty_twoprimaries", ::_id_D630, ::_id_FACB, []);
  _id_C2B1("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak"]);
  _id_C2B1("specialty_killstreak_to_scorestreak", ::_id_D5D3, ::_id_FAB1);
  _id_C2B1("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  _id_C2B1("specialty_sixth_sense", ::_id_D6CA, ::_id_FAFA);
  level thread _id_DD73();
  _id_C2B1("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  _id_C2B1("specialty_extra_deadly", ::_id_6F4E, ::_id_ED9D);
  _id_C2B1("specialty_shrapnel");
  _id_C2B1("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  _id_C2B1("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_silentkill", "specialty_sixth_sense_immune", "specialty_heartbreaker"]);
  _id_C2B1("specialty_ghost", ::_id_D575, ::_id_FA9A, ["specialty_gpsjammer"]);
  _id_C2B1("specialty_silentkill");
  _id_C2B1("specialty_sixth_sense_immune");
  _id_C2B1("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist"]);
  _id_C2B1("specialty_stun_resistance", ::_id_D6F7, ::_id_FB09, ["specialty_hard_shell"]);
  _id_C2B1("specialty_emp_resist");
  _id_C2B1("specialty_hard_shell", ::_id_D58C, ::_id_FAA2);
  _id_C2B1("specialty_gas_grenade_resist", ::_id_D574, ::_id_FA99);
  _id_C2B1("specialty_scrambler_resist");
  _id_C2B1("specialty_covert_ops", undefined, undefined, ["specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_snapshot_immunity"]);
  _id_C249("specialty_blindeye", ::_id_D49B, ::_id_FA5E);
  _id_C2B1("specialty_noscopeoutline", ::_id_D60F, ::_id_FAC3);
  _id_C2B1("specialty_snapshot_immunity");
  _id_C2B1("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks"]);
  _id_C2B1("specialty_chain_killstreaks");
  _id_C2B1("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment"]);
  _id_C2B1("specialty_engineer", ::_id_D540, ::_id_FA88, ["specialty_outlinekillstreaks"]);
  _id_C2B1("specialty_markequipment", ::_id_D5F1, ::_id_FABB);
  _id_C2B1("specialty_outlinekillstreaks", ::_id_D62D, ::_id_FAC8);
  level thread _id_D286();
  _id_C2B1("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);
  _id_C2B1("specialty_blastshield", ::_id_D49A, ::_id_FA5D);
  _id_C2B1("specialty_hack");
  _id_C2B1("specialty_shrapnel_resist");
  _id_C2B1("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report"]);
  _id_C2B1("specialty_tracker", ::_id_D732, ::_id_FB1D, ["specialty_tracker_pro"]);
  _id_C2B1("specialty_kill_report");
  _id_C2B1("specialty_ammo_disabling");
  _id_C2B1("specialty_viewkickoverride", ::_id_D8DE, ::_id_FB23);
  _id_C2B1("specialty_delayhealing");
  _id_C2B1("specialty_hardmelee", ::_id_D245, ::_id_F9C1);
  _id_C2B1("specialty_van_demolition");
  _id_C2B1("specialty_van_demolition_sniper");
  _id_C2B1("specialty_van_demolition_mg");
  _id_C2B1("specialty_scout");
  _id_C2B1("specialty_scout_spread_smg");
  _id_C2B1("specialty_scout_rifle_sniper");
  _id_C2B1("specialty_scout_mg");
  _id_C2B1("specialty_operator");
  _id_C2B1("specialty_tactician");
  _id_C2B1("specialty_extra_tactical");
  _id_C2B1("specialty_reaper");
  _id_C2B1("specialty_clandestine");
  _id_C2B1("specialty_radarpingonspawn");
  _id_C2B1("specialty_gasmask");
  _id_C2B1("specialty_explosive_recon");
  _id_C2B1("specialty_tac_mask");
  _id_C2B1("specialty_code_breaker");
  _id_C2B1("specialty_piercing_vision");
  _id_C2B1("specialty_intuition");
  _id_C2B1("specialty_runner");
  _id_C2B1("specialty_asdic");
  _id_C2B1("specialty_tier1_wip1");
  _id_C2B1("specialty_tier1_wip2");
  _id_C2B1("specialty_tier1_wip3");
  _id_C2B1("specialty_tier2_wip1");
  _id_C2B1("specialty_tier3_wip1");
}

_id_C2B1(var_0, var_1, var_2, var_3) {
  _id_C298(var_0, 1, var_1, var_2, var_3);
}

_id_C249(var_0, var_1, var_2, var_3) {
  _id_C298(var_0, 0, var_1, var_2, var_3);
}

_id_C298(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1)) {
    level._id_CF95[var_0] = 1;
  }

  if(isDefined(var_2)) {
    level._id_AFFB[var_0] = var_2;
  }

  if(isDefined(var_3)) {
    level._id_B000[var_0] = var_3;
  }

  if(isDefined(var_4)) {
    level._id_5853[var_0] = var_4;
  }
}

_id_D62E() {
  self setclientomnvar("ui_overcharge", 1);
}

_id_FAC9() {
  self setclientomnvar("ui_overcharge", 0);
}

_id_D56C() {}

_id_FA96() {}

_id_D6A6() {}

_id_FAE7() {}

_id_D58C() {
  self._id_D9D5 = 0.25;
}

_id_FAA2() {
  self._id_D9D5 = 0;
}

_id_D574() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
}

_id_FA99() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
}

_id_D69D() {}

_id_FAE1() {}

_id_D69E() {}

_id_FAE2() {}

_id_D589() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");

  if(scripts\cp\utility::_id_86C9()) {
    return;
  }
  thread _id_C9DD();
  self._id_74C6["assists"] = 0;
}

_id_FAA0() {
  self._id_74C6 = undefined;
  self notify("perk_end_hardline");
}

_id_C9DD() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("perk_end_hardline");
  var_0 = 7;

  for(;;) {
    if(isDefined(self._id_3B87) && self._id_3B87 > var_0) {
      _id_6F41();
    }

    waitframe();
  }
}

_id_6F41() {
  var_0 = undefined;
  var_0 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  var_1 = scripts\engine\utility::random(var_0);
  _id_0780::_id_6F13(var_1, self);
  wait 10;
}

_id_D55C() {}

_id_FA92() {}

_id_D630() {}

_id_FACB() {}

_id_D5D3() {}

_id_FAB1() {}

_id_DD74() {
  var_0 = scripts\engine\trace::_id_3EF6(1);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = _func_028F();

  foreach(var_21, var_7 in level._id_DD6F) {
    if(!isDefined(var_7)) {
      level._id_DD6F[var_21] = undefined;
      break;
    }

    var_8 = 0;
    var_9 = var_7 getEye();
    var_10 = var_7.team;
    var_11 = anglesToForward(var_7 getplayerangles());

    foreach(var_13 in level._id_E2A4) {
      if(var_2 >= 25) {
        var_2 = 0;
        waitframe();
      }

      if(!isDefined(var_7)) {
        level._id_DD6F[var_21] = undefined;
        break;
      }

      if(!var_7 scripts\cp\utility::_hasperk("specialty_sixth_sense")) {
        continue;
      }
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(var_13)) {
        continue;
      }
      if(!var_13 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_13.team == var_10) {
        continue;
      }
      if(distancesquared(var_13.origin, var_9) > 16000000) {
        continue;
      }
      if(!var_13 _id_85B6(var_7)) {
        continue;
      }
      if(isDefined(var_13.vehicle)) {
        continue;
      }
      var_2++;
      var_14 = var_13 getEye();
      var_15 = anglesToForward(var_13 getplayerangles());
      var_16 = var_9 - var_14;
      var_3 = var_14 - var_9;
      var_17 = vectordot(var_16, var_15);

      if(var_17 <= 0) {
        continue;
      }
      var_18 = 0.984808;
      var_19 = length(var_16);

      if(var_17 < var_18 * var_19) {
        continue;
      }
      var_17 = vectordot(var_11, vectornormalize(var_3));

      if(var_17 < 0.382683) {
        var_2 = var_2 + 2;

        if(scripts\engine\trace::_id_C052(var_14, var_9, var_7, var_0)) {
          var_8 = var_8 | var_7 _id_6D2D(var_13);
          break;
        }
      }
    }

    var_7 _id_FD2C(var_8);
  }
}

_id_85B6(var_0) {
  if(istrue(self._id_8C36)) {
    return 1;
  }

  if(isDefined(self._id_04B9) && self._id_04B9 == "suicidebomber") {
    return 1;
  }

  var_1 = self._id_04F6;
  var_2 = scripts\cp\cp_weapon::getweapongroup(var_1);

  switch (var_2) {
    case "weapon_projectile":
    case "weapon_dmr":
    case "weapon_sniper":
      return 1;
    case "weapon_shotgun":
      if(distancesquared(self.origin, var_0.origin) > 160000) {
        return 1;
      }

      break;
  }

  return 0;
}

_id_DD73() {
  level._id_DD6F = [];

  for(;;) {
    waitframe();
    _id_DD74();
  }
}

_id_D6CA() {
  self._id_DD75 = 0;
  self._id_DD77 = 0;
  _id_FD2C(0);
  var_0 = self getentitynumber();
  level._id_DD6F[var_0] = self;
}

_id_FAFA() {
  _id_FD2C(0);
  self._id_DD75 = undefined;
  self._id_DD77 = undefined;
  self._id_DD76 = undefined;
  self notify("removeSixthSense");
  var_0 = self getentitynumber();
  level._id_DD6F[var_0] = undefined;
}

_id_FD2C(var_0) {
  self setclientomnvar("ui_edge_glow", var_0);
}

_id_6D2D(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectornormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(_id_0960::_id_8909(self.origin, var_2, var_0.origin), 4, 1);
  } else if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(_id_0960::_id_8909(self.origin, var_2, var_0.origin), 128, 64);
  } else if(var_5 >= -0.707107) {
    return scripts\engine\utility::ter_op(_id_0960::_id_8909(self.origin, var_2, var_0.origin), 32, 8);
  } else {
    return 16;
  }
}

_id_D575() {
  self._id_AFAA["stealth_dist_scalar"] = 0.5;
}

_id_FA9A() {
  self._id_AFAA["stealth_dist_scalar"] = 1;
}

_id_D6F7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  var_0 = int(var_0);

  if(var_0 == 10) {
    self._id_EAAE = 0;
  } else {
    self._id_EAAE = var_0 / 10;
  }
}

_id_FB09() {
  self._id_EAAE = 1;
}

_id_D49B() {}

_id_FA5E() {}

_id_D60F() {}

_id_FAC3() {}

_id_D540() {
  thread _id_545F();
}

_id_545F() {
  self endon("unsetEngineer");
  self _meth_8700("equipment", 1000000);
  self._id_AFCC = 1;
  thread _id_9B38();
}

_id_FA88() {
  if(istrue(self._id_AFCC)) {
    self _meth_8701("equipment");
    self._id_AFCC = undefined;
  }

  self notify("unsetEngineer");
}

_id_1527() {
  if(!isDefined(level._id_EF6A)) {
    level._id_EF6A = [];
  }

  if(!isDefined(level._id_EF6A["allies"])) {
    level._id_EF6A["allies"] = [];
  }

  if(!isDefined(level._id_EF6A["allies"]["players"])) {
    level._id_EF6A["allies"]["players"] = level.players;
  }

  var_0 = _func_03C0(undefined, undefined, self.origin, 2000);

  foreach(var_2 in var_0) {
    if(issubstr(var_2.type, "brloot_munition")) {
      var_2._id_58FC = spawn("script_model", var_2.origin);
      var_2._id_58FC.angles = var_2.angles;
      var_2._id_58FC setModel("container_ammo_box_01_nophysics_cp");
      var_2._id_58FC _meth_86FE("equipment");
      scripts\cp\cp_outline_utility::outlineenableforplayer(var_2._id_58FC, self, "spotter_notarget_equipment", "perk");
    }

    waitframe();
  }
}

_id_99C6() {
  var_0 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var_2 in var_0) {
    var_3 = _func_03C0(undefined, undefined, undefined, undefined, var_2);
    var_4 = 0;

    foreach(var_6 in var_3) {
      var_6 setscriptablepartstate(var_2, "visible");
      var_4++;

      if(var_4 % 20) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

_id_99AE() {
  var_0 = 10;
  level._id_ACB7 = [];
  level._id_ACB6 = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_ACB7[var_1] = spawn("script_model", (0, 0, 0));
    level._id_ACB7[var_1].angles = (0, 0, 0);
    level._id_ACB7[var_1] setModel("container_ammo_box_01_nophysics_cp");
    level._id_ACB7[var_1] _meth_86FE("equipment");
  }

  thread _id_A0DC();
}

_id_A0DC() {
  level endon("game_ended");

  for(;;) {
    if(scripts\cp\utility::_hasperk("specialty_engineer")) {
      _id_63EA();
    }

    wait 0.1;
  }
}

_id_63EA() {
  var_0 = 1000;
  var_1 = 10;
  var_2 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = _func_03C0(undefined, undefined, self.origin, var_0, var_5);

    foreach(var_8 in var_6) {
      var_3[var_3.size] = var_8;
    }
  }

  var_3 = _func_0204(var_3, self.origin);
  var_11 = level._id_ACB7;
  var_12 = [];
  var_13 = [];

  for(var_14 = 0; var_14 < var_3.size; var_14++) {
    if(!isDefined(level._id_ACB6[var_3[var_14].index])) {
      var_13[var_13.size] = var_3[var_14];
    }
  }

  if(var_13.size > 0) {
    var_15 = 0;

    for(var_14 = 0; var_14 < min(var_13.size, var_1); var_14++) {
      for(var_16 = 0; var_16 < level._id_ACB7.size; var_16++) {
        if(isDefined(var_12[var_16])) {
          continue;
        }
        if(isDefined(level._id_ACB7[var_16])) {
          level._id_ACB7[var_16] dontinterpolate();
        }

        level._id_ACB7[var_16].origin = var_13[var_14].origin;
        level._id_ACB7[var_16].angles = var_13[var_14].angles;
        level._id_ACB7[var_16].index = var_13[var_14].index;
        level._id_ACB6[level._id_ACB7[var_16].index] = undefined;
        level._id_ACB6[var_13[var_14].index] = level._id_ACB7[var_16];
        _id_F995(level._id_ACB7[var_16]);
        var_12[var_16] = var_13[var_14];
        break;
      }
    }
  }
}

_id_F995(var_0) {
  var_0 _meth_8707(undefined);
  self._id_9B4C._id_9B3A = scripts\engine\utility::array_remove(self._id_9B4C._id_9B3A, var_0);
  var_0 notify("unmarkEnt_" + self getentitynumber());
}

_id_D5F1() {
  self _meth_870B();
  thread _id_9B4A();
}

_id_FABB() {
  if(isDefined(self._id_9B4C)) {
    foreach(var_1 in self._id_9B4C._id_9B3A) {
      if(isDefined(var_1)) {
        _id_F995(var_1);
      }
    }
  }

  self._id_9B4C = undefined;
  self _meth_870C();
  self notify("mark_equip_ended");
}

_id_9B4A() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");

  if(!isDefined(self._id_9B4C)) {
    self._id_9B4C = spawnStruct();
    self._id_9B4C._id_9B81 = 0;
    self._id_9B4C._id_9B7F = undefined;
    self._id_9B4C._id_9B3A = [];
    self._id_9B4C._id_9B36 = 0;
    self._id_9B4C._id_AEBA = [];
    self._id_9B4C._id_AEB9 = 0;
  }

  for(;;) {
    self waittill("marks_target_changed", var_0);
    var_1 = isDefined(var_0) && !isDefined(self._id_9B4C._id_9B7F);
    self._id_9B4C._id_9B7F = var_0;
    self._id_9B4C._id_9B81 = 0;

    if(var_1) {
      thread _id_9B4B();
    }
  }
}

_id_D286() {
  level._id_D006 = 6000;
  level._id_D00A = 1500;
  level._id_D007 = 1000;
}

_id_9B4B() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  var_0 = gettime();
  var_1 = 0;

  if(self _meth_8702("air_killstreak", self._id_9B4C._id_9B7F)) {
    var_1 = level._id_D006;
  } else if(self _meth_8702("killstreak", self._id_9B4C._id_9B7F)) {
    var_1 = level._id_D00A;
  } else if(self _meth_8702("equipment", self._id_9B4C._id_9B7F)) {
    var_1 = level._id_D007;
  } else {}

  var_2 = var_1 * var_1;

  while(isDefined(self._id_9B4C._id_9B7F) && !istrue(self._id_888B)) {
    if(self _meth_8703(self._id_9B4C._id_9B7F)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self._id_9B4C._id_9B7F) {
      break;
    }

    if(distancesquared(self.origin, self._id_9B4C._id_9B7F.origin) > var_2) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self._id_9B4C._id_9B81 = self._id_9B4C._id_9B81 + var_4;

    if(!scripts\engine\utility::array_contains(self._id_9B4C._id_9B3A, self._id_9B4C._id_9B7F)) {
      if(scripts\cp\utility::_id_8989()) {
        var_5 = self._id_9B4C._id_9B36;
        var_6 = self._id_9B4C._id_9B3A[var_5];

        if(isDefined(var_6)) {
          var_6 _meth_8707(undefined);
          _id_ACE2(var_6);
        }

        self._id_9B4C._id_9B7F _meth_8707(self.team);
        _id_ACE2(self._id_9B4C._id_9B7F);
        self._id_9B4C._id_9B3A[var_5] = self._id_9B4C._id_9B7F;
        self._id_9B4C._id_9B36 = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self._id_9B4C._id_AEBA, self._id_9B4C._id_9B7F)) {
          self._id_9B4C._id_AEBA[self._id_9B4C._id_AEB9] = self._id_9B4C._id_9B7F;
          self._id_9B4C._id_AEB9++;
        } else {}

        thread _id_F993(self._id_9B4C._id_9B7F);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self._id_888B)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self._id_9B4C._id_9B7F = undefined;
  self._id_9B4C._id_9B81 = 0;
}

_id_F993(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  wait(getdvarint("#x3310d3a0a2be69660"));

  if(isDefined(var_0) && isDefined(self)) {
    _id_F995(var_0);
  }
}

_id_F996(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());

  for(;;) {
    wait 0.5;
  }
}

_id_ACE2(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    _id_ACDF(var_1);
    _id_ACE0(var_0);
  }
}

_id_ACE0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getentitynumber();
  var_2 = self._id_550B[var_1];

  if(isDefined(var_2)) {
    return;
  }
  var_3 = undefined;

  if(self _meth_8703(var_0)) {
    var_3 = spawnStruct();
    var_3._id_BD2C = "perk_superior";
    var_3._id_7B8A = "spotter_target";
    _id_ACE4(var_3);
  }

  var_4 = self _meth_8703(var_0);

  if(self _meth_8702("air_killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_killstreak_air";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_killstreak_air";
    }

    _id_ACE4(var_3);
  } else if(self _meth_8702("killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_killstreak";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_killstreak";
    }

    _id_ACE4(var_3);
  } else if(self _meth_8702("equipment", var_0)) {
    if(isDefined(var_0._id_5562) && var_0._id_5562 == "equip_tac_cover") {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3._id_BD2C = "perk_superior";
      var_3._id_7B8A = "spotter_target_equipment";
    } else {
      var_3._id_BD2C = "perk";
      var_3._id_7B8A = "spotter_notarget_equipment";
    }

    _id_ACE4(var_3);
  }

  if(isDefined(var_3)) {
    var_2 = spawnStruct();
    self._id_550B[var_1] = var_2;
    var_2._id_951C = [];
    var_2._id_5469 = var_0;
    var_5 = _id_6958(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\cp\cp_outline_utility::outlineenableforplayer(var_7, self, var_3._id_7B8A, var_3._id_BD2C);
      var_9 = spawnStruct();
      var_9._id_5469 = var_7;
      var_9._id_7C8C = var_8;
      var_10 = var_7 getentitynumber();
      var_2._id_951C[var_10] = var_9;
    }
  }
}

_id_6958(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  if(!isDefined(var_0._id_357A)) {
    return [var_0];
  }

  return var_0._id_357A;
}

_id_ACE4(var_0) {
  if(!isDefined(var_0._id_6C5C)) {
    var_0._id_6C5C = ::_id_ACE1;
  }

  if(!isDefined(var_0._id_FF62)) {
    var_0._id_FF62 = ::_id_ACE3;
  }

  if(!isDefined(var_0._id_7B8A)) {
    var_0._id_7B8A = "spotter_notarget";
  }

  if(!isDefined(var_0._id_BD2C)) {
    var_0._id_BD2C = "perk";
  }

  if(!isDefined(var_0._id_10971)) {
    var_0._id_10971 = 0.1;
  }
}

_id_ACE1(var_0, var_1) {
  return level.players;
}

_id_ACE3(var_0) {
  return 1;
}

_id_ACDF(var_0) {
  if(isDefined(var_0)) {
    var_1 = self._id_550B[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1._id_951C) {
        scripts\cp\cp_outline_utility::outlinedisable(var_3._id_7C8C, var_3._id_5469);
      }

      self._id_550B[var_0] = undefined;
    }
  }
}

_id_D62D() {
  thread _id_ACEC();
}

_id_ACEC() {
  self endon("unsetOutlineKillstreak");
  self _meth_8700("killstreak", 1000000);
  self _meth_8700("air_killstreak", 1000000);
  self._id_AFD5 = 1;
}

_id_FAC8() {
  if(istrue(self._id_AFD5)) {
    self _meth_8701("killstreak");
    self _meth_8701("air_killstreak");
    self._id_AFD5 = undefined;
  }

  self notify("unsetOutlineKillstreak");
}

_id_9B37(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_9B38() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_550B = [];

  for(;;) {
    self waittill("marks_changed", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0) {
        _id_ACDF(var_4);
      }

      if(isDefined(self._id_9B4C)) {
        self._id_9B4C._id_9B3A = _id_9B37(self._id_9B4C._id_9B3A, var_0);

        if(self._id_9B4C._id_9B36 > self._id_9B4C._id_9B3A.size) {
          self._id_9B4C._id_9B36 = self._id_9B4C._id_9B3A.size;
        }
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1) {
        _id_ACDF(var_7);
      }
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2) {
        _id_ACE0(var_10);
      }
    }
  }
}

_id_D49A() {
  _id_D2EB("enemy_explosive_damage_reduction", 0.5);
}

_id_FA5D() {
  _id_D2EB("enemy_explosive_damage_reduction", 1);
}

_id_D732() {
  thread _id_CA79();
  thread _id_CA13();
}

_id_FB1D() {
  self notify("tracker_removed");
}

_id_CA79() {
  self endon("death_or_disconnect");
  self endon("track_killstreak_end");

  for(;;) {
    if(scripts\cp\utility::_id_8ACE()) {
      waitframe();
      scripts\cp\utility::_id_EDCE("specialty_tracker");

      while(scripts\cp\utility::_id_8ACE()) {
        waitframe();
      }

      scripts\cp\utility::_id_6FC2("specialty_tracker");
      break;
    }

    waitframe();
  }
}

_id_CA13() {
  self endon("death_or_disconnect");
  self endon("tracker_removed");
  var_0 = cos(70);
  var_1 = 0;
  self._id_103CD = [];
  self._id_ACE9 = [];
  var_2 = 5000;

  for(;;) {
    var_3 = level._id_E2A4;

    foreach(var_5 in var_3) {
      if(var_1 >= 20) {
        var_1 = 0;
        waitframe();
      }

      if(!isDefined(var_5)) {
        continue;
      }
      if(isDefined(var_5._id_41A1)) {
        if(var_5._id_41A1 != "casual" && var_5._id_41A1 != "alert") {
          continue;
        }
      } else
        continue;

      var_1++;
      var_6 = var_5 getentitynumber();
      var_7 = scripts\engine\utility::_id_10E76(self getEye(), self getplayerangles(), var_5.origin, var_0);

      if(!var_7) {
        continue;
      }
      var_8 = _func_0202(self getEye(), var_5 getEye(), 0, undefined);

      if(!var_8) {
        if(isDefined(self._id_103CD[var_6])) {
          var_9 = gettime();
          var_10 = var_9 - var_2;

          if(self._id_103CD[var_6] < var_10) {} else {
            var_5 _id_1001(var_6, self);
            var_5 thread _id_FB2A(self, 5);
          }
        } else {}

        continue;
      }

      var_9 = gettime();
      self._id_103CD[var_6] = var_9;
      var_5 _id_C423(var_6, self);
    }

    var_1 = 0;
    waitframe();
  }
}

_id_1001(var_0, var_1) {
  if(!isDefined(var_1._id_ACE9[var_0])) {
    var_1._id_ACE9[var_0] = ::scripts\cp\cp_outline_utility::outlineenableforplayer(self, var_1, "snapshotgrenade", "equipment");
  }
}

_id_FB2A(var_0, var_1) {
  self endon("track_enemy");
  var_2 = self getentitynumber();
  wait(var_1);
  _id_C423(var_2, var_0);
}

_id_C423(var_0, var_1) {
  var_2 = var_1._id_ACE9[var_0];

  if(isDefined(var_2)) {
    scripts\cp\cp_outline_utility::outlinedisable(var_2, self);
    var_1._id_ACE9[var_0] = undefined;
  }

  self notify("track_enemy");
}

_id_D8DE() {
  self._id_AD63 = 0.05;
  self._id_AD64 = 0.05;
  self._id_AD65 = 0.02;
  self._id_AD67 = 0.3;
  self._id_AD66 = 0.05;
  scripts\cp\cp_weapon::_id_FD7E();
}

_id_FB23() {
  self._id_AD63 = undefined;
  self._id_AD64 = undefined;
  self._id_AD65 = undefined;
  self._id_AD67 = undefined;
  self._id_AD66 = undefined;
  scripts\cp\cp_weapon::_id_FD7E();
}

_id_D245() {
  self._id_AFAA["melee_scalar"] = 2;
}

_id_F9C1() {
  self._id_AFAA["melee_scalar"] = 1;
}

_id_6F62() {
  _id_D2EB("super_fill_scalar", 1.3);
}

_id_EDA1() {
  _id_D2EB("super_fill_scalar", 1);
}

_id_6F45() {
  thread _id_C106(30);
}

_id_ED9A() {
  self notify("take_restock");
}

_id_C106(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  thread _id_C5E3();
  thread _id_C5E1();

  for(;;) {
    self waittill("grenade_fire", var_1, var_2, var_3, var_4);
    var_5 = _id_683C(self, "primary");

    if(var_2.basename == var_5) {
      thread _id_4664(self, var_0);
    }

    var_6 = _id_683C(self, "secondary");

    if(var_2.basename == var_6) {
      thread _id_4665(self, var_0);
    }
  }
}

_id_C5E3() {
  level endon("game_ended");
  self waittill("take_restock");
  self._id_10840 = 0;
  self._id_1083F = 0;
  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar("ui_lethal_recharge_progress", 0);
  self setclientomnvar("ui_tactical_recharge_progress", 0);
}

_id_C5E1() {
  level endon("game_ended");
  self endon("take_restock");
  var_0 = 30;
  self waittill("landed_after_respawn");

  if(_id_66BA(self, "primary") < _id_66BB(self, "primary")) {
    thread _id_4664(self, var_0);
  }

  if(_id_66BA(self, "secondary") < _id_66BB(self, "secondary")) {
    thread _id_4665(self, var_0);
  }
}

_id_4664(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var_0._id_1083F)) {
    return;
  }
  thread _id_E8D6("ui_lethal_recharge_progress", "primary");
  var_0._id_1083F = 1;
  _id_FBBC("ui_lethal_recharge_progress", var_1, 0);
  var_0._id_1083F = 0;
  var_0 _id_0753::_id_BA95(_id_66BC(var_0, "primary"), 1);

  if(_id_66BA(var_0, "primary") < _id_66BB(var_0, "primary")) {
    var_0 thread _id_4664(self, var_1);
  } else {
    var_0 notify("restock_done");
  }
}

_id_4665(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var_0._id_10840)) {
    return;
  }
  thread _id_E8D6("ui_tactical_recharge_progress", "secondary");
  var_0._id_10840 = 1;
  _id_FBBC("ui_tactical_recharge_progress", var_1, 1);
  var_0._id_10840 = 0;
  var_0 _id_0753::_id_BA95(_id_66BC(var_0, "secondary"), 1);

  if(_id_66BA(var_0, "secondary") < _id_66BB(var_0, "secondary")) {
    var_0 thread _id_4665(self, var_1);
  } else {
    var_0 notify("restock_done");
  }
}

_id_FBBC(var_0, var_1, var_2) {
  self setclientomnvar("ui_recharge_notify", -1);
  var_3 = gettime();
  var_4 = var_3 + var_1 * 1000;
  var_5 = gettime();

  while(var_5 < var_4) {
    while(istrue(self.inlaststand)) {
      self setclientomnvar("ui_recharge_notify", -1);
      self setclientomnvar(var_0, 0);
      waitframe();
    }

    var_5 = gettime();
    var_6 = (var_5 - var_3) / (var_4 - var_3);
    self setclientomnvar(var_0, var_6);
    wait 0.1;
  }

  self setclientomnvar("ui_recharge_notify", var_2);
  self setclientomnvar(var_0, 0);
}

_id_E8D6(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");

  while(istrue(self.inlaststand) || _id_66BA(self, var_1) < _id_66BB(self, var_1)) {
    waitframe();
  }

  self notify("stop_restock_recharge");

  if(var_1 == "primary") {
    self._id_1083F = 0;
  } else {
    self._id_10840 = 0;
  }

  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar(var_0, 0);
}

_id_683C(var_0, var_1) {
  foreach(var_3 in var_0._id_BADE) {
    if(var_3._id_DDEF == var_1) {
      return var_3._id_10DE9;
    }
  }
}

_id_66BC(var_0, var_1) {
  foreach(var_4, var_3 in var_0._id_BADE) {
    if(var_3._id_DDEF == var_1) {
      return var_4;
    }
  }
}

_id_66BA(var_0, var_1) {
  foreach(var_3 in var_0._id_BADE) {
    if(var_3._id_DDEF == var_1) {
      return var_3._id_3411;
    }
  }
}

_id_66BB(var_0, var_1) {
  foreach(var_3 in var_0._id_BADE) {
    if(var_3._id_DDEF == var_1) {
      return var_3._id_9C5C;
    }
  }
}

_id_6EC4() {
  scripts\cp\utility::_id_6FC2("specialty_quickdraw");
  scripts\cp\utility::_id_6FC2("specialty_quickswap");
  scripts\cp\utility::_id_6FC2("specialty_fastoffhand");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
}

_id_ED81() {}

_id_6F4E() {}

_id_ED9D() {}

_id_D5FF() {
  thread _id_CA50();
}

_id_CA50() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      _id_7119();
      self._id_A25F = 1;

      if(isDefined(level._id_A201)) {
        self[[level._id_A201]]();
      }
    }

    wait 0.1;
  }
}

_id_7119() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread _id_A0B5();
  thread _id_A0B4();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self._id_A25F = self._id_A25F + 0.01;

    if(isDefined(level._id_A201)) {
      self[[level._id_A201]]();
    }

    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread _id_A0B3();
  self waittill("momentum_reset");
}

_id_A0B3() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

_id_A0B5() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self _meth_8498()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

_id_A0B4() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

_id_FABF() {
  self notify("momentum_unset");
}

_id_10AB2() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self._id_B133 = 1.0;
  self._id_145B = 1.0;
  self._id_145A = 0;
  self._id_3AC4 = _id_697E();
  self[[level._id_A201]]();

  for(;;) {
    self waittill("weapon_change", var_0);
    var_1 = self getcurrentweapon();
    var_2 = scripts\cp\utility::_id_6CE3(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "nrg" || var_2 == "zmagnum" || var_2 == "zg18" || var_2 == "emc") {
        self._id_B133 = 1.1;
      } else {
        self._id_B133 = 1.0;
      }

      wait 0.05;
      _id_FC38();
    }

    wait 0.05;
  }
}

_id_FC38() {
  self._id_3AC4 = _id_697E();
  self[[level._id_A201]]();
}

_id_697E() {
  return self._id_B133 * self._id_145B;
}

removeperk(var_0) {
  scripts\cp\utility::_unsetperk(var_0);
  scripts\cp\utility::_id_0DA0(var_0);
}

_id_AA4A(var_0) {
  if(!isDefined(var_0._id_50FF)) {
    return;
  }
  var_1 = var_0._id_50FF;
  var_2 = var_1 getentitynumber();

  if(isPlayer(var_1)) {
    var_3 = var_1 _id_664E("head_popper_returned_bullet");

    if(var_3 > 0 && _func_0107(self.killing_blow_count) && isDefined(self.killing_blow_count[var_2])) {
      var_4 = var_0._id_04F6;

      if(scripts\cp\utility::_id_8891(var_4, var_0._id_D9E0, var_0._id_DE2B, var_1) && !scripts\cp\utility::_id_88F6(var_4) && scripts\cp\cp_weapon::_id_8795(var_4) && (!isDefined(level.no_headshot_refill_weapon) || !scripts\engine\utility::array_contains(level.no_headshot_refill_weapon, var_4.basename))) {
        var_5 = self.killing_blow_count[var_2];
        var_5 = int(max(var_3 * var_5, var_3 / 0.33));
        var_6 = var_1 getweaponammoclip(var_4);

        if(var_6 > 0 || !istrue(var_4._id_0246)) {
          var_7 = weaponclipsize(var_4);
          var_8 = var_6 + var_5;

          if(var_8 > var_7) {
            var_8 = var_7;
          }

          var_1 setweaponammoclip(var_4, var_8);
        } else {
          var_9 = var_1 getweaponammostock(var_4);
          var_10 = var_9 + var_5;
          var_1 setweaponammostock(var_4, var_10);
        }
      }
    }
  }
}