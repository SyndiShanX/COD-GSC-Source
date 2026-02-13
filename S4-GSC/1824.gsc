/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1824.gsc
*************************************************/

init() {
  level._id_493C = 0;
  level._id_4169 = "";
  level._id_4942 = [];
  level._id_425C = ::queue_powerup_dialog;
  _id_06CB::_id_AA4A(::_id_AA4A);
  level.allowed_dialogue_aliases = [];
  var_0 = tablelookupgetnumrows("cp/cp_dialogue_esrb_allowlist.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("cp/cp_dialogue_esrb_allowlist.csv", var_1, 0);
    level.allowed_dialogue_aliases = scripts\engine\utility::array_add(level.allowed_dialogue_aliases, var_2);
  }

  level.weapon_name_to_class = [];
  var_0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_3 = tablelookupbyrow("mp/statstable.csv", var_1, 4);
    var_4 = tablelookupbyrow("mp/statstable.csv", var_1, 1);

    if(isDefined(var_3) && var_3 != "" && isDefined(var_4) && var_4 != "") {
      level.weapon_name_to_class[var_3 + "_mp"] = var_4;
    }
  }

  level.objective_vo_aliases = [];
  var_0 = tablelookupgetnumrows("cp/cp_dialogue_objectives.csv");
  var_5 = _func_0225("cp/cp_dialogue_objectives.csv");

  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow("cp/cp_dialogue_objectives.csv", 0, var_6);
    level.objective_vo_aliases[var_7] = [];

    for(var_8 = 1; var_8 < var_0; var_8++) {
      var_9 = tablelookupbyrow("cp/cp_dialogue_objectives.csv", var_8, 0);
      var_10 = tablelookupbyrow("cp/cp_dialogue_objectives.csv", var_8, var_6);
      level.objective_vo_aliases[var_7][var_9] = var_10;
    }
  }

  thread wait_for_players();
}

add_new_aliases_into_allowlist(var_0, var_1) {
  var_2 = tablelookupgetnumrows(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow(var_0, var_3, var_1);
    level.allowed_dialogue_aliases = scripts\engine\utility::array_add(level.allowed_dialogue_aliases, var_4);
  }
}

wait_for_players() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0)) {
      if(!isDefined(var_0.demon_core_alias)) {
        var_0.demon_core_alias = "cblk_blkr";
      }

      var_0.cooldown_vos = [];
      var_1 = var_0 getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", 0);

      switch (var_1) {
        case "polina":
          var_0.zm_operator_alias = "cmcp_cpln_poli";
          var_0.mp_operator_alias = "cs15_zspp_poli";
          break;
        case "roland":
          var_0.zm_operator_alias = "cmcp_crld_rola";
          var_0.mp_operator_alias = "cs15_zsrz_rola";
          break;
        case "daniel":
          var_0.zm_operator_alias = "cmcp_cdnl_danl";
          var_0.mp_operator_alias = "cs15_zsdt_danl";
          break;
        case "wade":
          var_0.zm_operator_alias = "cmcp_cwde_wade";
          var_0.mp_operator_alias = "cs15_zswj_wade";
          break;
        case "arthur":
          var_0.zm_operator_alias = "cmcp_ckng_arth";
          var_0.mp_operator_alias = "cs15_zsak_arth";
          break;
        case "constanze":
          var_0.zm_operator_alias = "cmcp_ccns_cons";
          var_0.mp_operator_alias = "cs15_zscm_cons";
          break;
        case "solange":
          var_0.zm_operator_alias = "cmcp_csln_sola";
          var_0.mp_operator_alias = "cs15_zssh_sola";
          break;
        case "shigenori":
          var_0.zm_operator_alias = "cmcp_cshg_shig";
          var_0.mp_operator_alias = "cs15_zsso_shig";
          break;
        case "padmavati":
          var_0.zm_operator_alias = "cmcp_cpdm_padm";
          var_0.mp_operator_alias = "cs15_zspb_padm";
          break;
        case "halima":
          var_0.zm_operator_alias = "cmcp_chlm_hali";
          var_0.mp_operator_alias = "cs15_zshz_hali";
          break;
        case "lucas":
          var_0.zm_operator_alias = "cmcp_clcs_luca";
          var_0.mp_operator_alias = "cs15_zslr_luca";
          break;
        case "beatrice":
          var_0.zm_operator_alias = "cmcp_cbea_beat";
          var_0.mp_operator_alias = "cs15_zsbm_beat";
          break;
        case "francis":
          var_0.zm_operator_alias = "cmcp_cfra_mpof";
          var_0.mp_operator_alias = "cs15_zsfl_mpof";
          break;
        case "lewis":
          var_0.zm_operator_alias = "cmcp_clew_lewi";
          var_0.mp_operator_alias = "cs15_zslh_lewi";
          break;
        case "isabella":
          var_0.zm_operator_alias = "cmcp_cisa_mpoi";
          var_0.mp_operator_alias = "cs15_zsic_mpoi";
          break;
        case "thomas":
          var_0.zm_operator_alias = "ztms_cblt_thbl";
          var_0.mp_operator_alias = "cstb_zstb_thbl";
          break;
        case "anna":
          var_0.zm_operator_alias = "zana_cdrk_anna";
          var_0.mp_operator_alias = "csad_zsad_anna";
          break;
        case "gustavo":
          var_0.zm_operator_alias = "zgst_cdsn_gust";
          var_0.mp_operator_alias = "csgd_zsgd_gust";
          break;
        case "lion":
          var_0.zm_operator_alias = "zlin_clin_lion";
          var_0.mp_operator_alias = "zlin_clin_lion";
          break;
        case "florence":
          var_0.zm_operator_alias = "zflr_cctr_flor";
          var_0.mp_operator_alias = "zflr_cctr_flor";
          break;
        case "mateo":
          var_0.zm_operator_alias = "zmto_chrn_mate";
          var_0.mp_operator_alias = "zmto_chrn_mate";
          break;
        case "kim":
          var_0.zm_operator_alias = "zkmt_cyng_kimt";
          var_0.mp_operator_alias = "zkmt_cyng_kimt";
          break;
        case "carver":
          var_0.zm_operator_alias = "cps4_zbtr_obut";
          var_0.mp_operator_alias = "cps4_zbtr_obut";
          break;
        case "callum":
          var_0.zm_operator_alias = "cps4_zclm_caum";
          var_0.mp_operator_alias = "cps4_zclm_caum";
          break;
        case "ikenna":
          var_0.zm_operator_alias = "cp45_zikn_iken";
          var_0.mp_operator_alias = "cp45_zikn_iken";
          break;
        case "palmer":
          var_0.zm_operator_alias = "cp45_zt8c_t800";
          var_0.mp_operator_alias = "cp45_zt8c_t800";
          break;
        case "doggett":
          var_0.zm_operator_alias = "cp45_zt1k_t100";
          var_0.mp_operator_alias = "cp45_zt1k_t100";
          break;
        case "khaled":
          var_0.zm_operator_alias = "cp50_zkld_khal";
          var_0.mp_operator_alias = "cp50_zkld_khal";
          break;
        case "raul":
          var_0.zm_operator_alias = "cp50_zmnd_medz";
          var_0.mp_operator_alias = "cp50_zmnd_medz";
          break;
        case "gabriel":
          var_0.zm_operator_alias = "cp55_zrke_rork";
          var_0.mp_operator_alias = "cp55_zrke_rork";
          break;
        case "seraph":
          var_0.zm_operator_alias = "cp55_zsrp_sera";
          var_0.mp_operator_alias = "cp55_zsrp_sera";
          break;
        default:
          var_0.zm_operator_alias = "cmcp_cwde_wade";
          var_0.mp_operator_alias = "glob_opwa_wade";
          break;
      }

      var_0 thread update_player_centric_vo();
    }
  }
}

set_active_super(var_0) {
  switch (var_0) {
    case "field_upgrade_frost_blast":
      self.demon_core_alias = "cmcp_cnrt_dnrt";
      self.demon_skorpion_alias = "zohs_hbsk_dnrt";
      self.demon_hub_alias_a = "dnrt";
      self.demon_hub_alias_b = "n";
      self.super_ready_alias = "drfb";
      self.super_activated_alias = "dufb";
      self.super_multikill_alias = "dmfb";
      self.demon_zaballa_intro_alias = "ezaa";
      break;
    case "field_upgrade_aether_shroud":
      self.demon_core_alias = "cmcp_cblk_blkr";
      self.demon_skorpion_alias = "zohs_hbsk_blkr";
      self.demon_hub_alias_a = "blkr";
      self.demon_hub_alias_b = "b";
      self.super_ready_alias = "dras";
      self.super_activated_alias = "duas";
      self.super_multikill_alias = "dmas";
      self.demon_zaballa_intro_alias = "ezab";
      break;
    case "field_upgrade_ring_of_fire":
      self.demon_core_alias = "cmcp_cinv_dnvk";
      self.demon_skorpion_alias = "zohs_hbsk_dnvk";
      self.demon_hub_alias_a = "dnvk";
      self.demon_hub_alias_b = "i";
      self.super_ready_alias = "drrf";
      self.super_activated_alias = "durf";
      self.super_multikill_alias = "dmrf";
      self.demon_zaballa_intro_alias = "ezac";
      break;
    case "field_upgrade_energy_mine":
      self.demon_core_alias = "cmcp_csrx_dsrx";
      self.demon_skorpion_alias = "zohs_hbsk_dsrx";
      self.demon_hub_alias_a = "dsrx";
      self.demon_hub_alias_b = "s";
      self.super_ready_alias = "drem";
      self.super_activated_alias = "duem";
      self.super_multikill_alias = "dmem";
      self.demon_zaballa_intro_alias = "ezad";
      break;
    case "field_upgrade_healing_aura":
      self.demon_core_alias = "cdvc_dvcn_vrcn";
      self.demon_skorpion_alias = "zohs_hbsk_vrcn";
      self.demon_hub_alias_a = "vrcn";
      self.demon_hub_alias_b = undefined;
      self.super_ready_alias = "drha";
      self.super_activated_alias = "duha";
      self.super_multikill_alias = "dmha";
      self.demon_zaballa_intro_alias = "ezae";
      break;
  }
}

update_player_centric_vo() {
  self endon("disconnect");
  level endon("game_ended");
  thread update_killstreak_vo();
  thread update_headshot_vo();

  for(;;) {
    if(isalive(self)) {
      var_0 = _func_0071(self.origin, 300, level._id_11056);

      if(isDefined(var_0)) {
        var_1 = 0;

        foreach(var_3 in var_0) {
          if(abs(self.origin[2] - var_3.origin[2]) < 50) {
            var_1++;
          }
        }

        if(var_1 >= 8) {
          _id_BEC0("surrounded", 1);
          play_to_nearby_allies("ally_surrounded", 810000);
          wait 15;
        }
      }
    }

    wait 0.3;
  }
}

update_killstreak_vo() {
  for(;;) {
    self waittill("multikillstreak");

    if(self _meth_80D0()) {
      _id_BEC0("field_upgrade_multikill", 1);
    } else {
      _id_BEC0("kill_streak", 1);
    }

    if(randomintrange(0, 100) < 100) {
      play_to_nearby_allies("ally_impressive", 1440000);
    }
  }
}

update_headshot_vo() {
  for(;;) {
    self waittill("kill_headshot");

    if(randomintrange(0, 100) < 10) {
      play_to_nearby_allies("ally_impressive", 1440000);
    }
  }
}

play_to_nearby_allies(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_4 = _func_0202(self getEye(), var_3 getEye(), 0, self);

    if(var_3 != self && distance2dsquared(var_3.origin, self.origin) < var_1 && is_in_front(self, var_3.origin) && var_4) {
      var_3 _id_BEC0(var_0);
    }
  }
}

_id_AA4A(var_0) {
  var_1 = var_0._id_50FF;

  if(isPlayer(var_1)) {
    if(self._id_110B0 == "screamer" && var_1 check_kill_vo_cool_down(60)) {
      var_1 _id_BEC0("kill_screamer", 1);
    }

    if(self._id_110B0 == "juggernaut" && var_1 check_kill_vo_cool_down(60)) {
      var_1 _id_BEC0("kill_juggernaut", 1);
    }

    if(distance2dsquared(self.origin, var_1.origin) < 6400) {
      var_1 _id_BEC0("kill_close", 1);
    }

    if(_id_08EA::isrevengekill(var_1)) {
      var_1 _id_BEC0("kill_revenge", 1);
    }

    if(scripts\cp\utility::_id_8891(var_0._id_04F6, var_0._id_D9E0, var_0._id_DE2B, var_1)) {
      var_1 _id_BEC0("kill_headshot", 1);
      var_1 notify("kill_headshot");
    }
  }
}

check_kill_vo_cool_down(var_0) {
  if(!isDefined(self.kill_vo_start_time)) {
    self.kill_vo_start_time = gettime();
    return 1;
  }

  var_1 = gettime() - self.kill_vo_start_time;
  var_1 = scripts\cp\utility::_id_A2B8(var_1);

  if(var_1 >= var_0) {
    self.kill_vo_start_time = gettime();
    return 1;
  }

  return 0;
}

queue_powerup_dialog(var_0, var_1) {
  if(istrue(level.disable_incoming_powerup_vo)) {
    return;
  }
  foreach(var_3 in level.players) {
    thread queue_powerup_dialog_player(var_3, var_1);
  }
}

queue_powerup_dialog_player(var_0, var_1) {
  var_2 = undefined;

  if(getdvarint("#x32499d9dc5db0430e", 0)) {
    var_2 = get_event_alias(var_0, "announcer_powerup_holiday");
  } else {
    var_2 = get_event_alias(var_0, "announcer_powerup_" + var_1);
  }

  if(isDefined(var_2) && _func_0205(var_2)) {
    play_table_alias(var_0, var_2);
    wait(get_dialogue_length(var_2));

    if(isDefined(var_0)) {
      var_0 _id_BEC0("demon_powerup_" + var_1, 1);
    }
  }
}

queue_weapon_pickup_dialogue(var_0) {
  if(var_0 == "s4_me_rindigoww_mp" && isDefined(level.decimator_pickup_dialogue)) {
    _id_BEC0(level.decimator_pickup_dialogue);
    return;
  }

  if(is_wonder_weapon(var_0)) {
    var_1 = "wonder";
  } else {
    var_1 = level.weapon_name_to_class[var_0];
    var_1 = strtok(var_1, "_")[1];
  }

  _id_BEC0("weapon_pickup_" + var_1, 1);
}

is_wonder_weapon(var_0) {
  return var_0 == "s4_pi_raygun_mp" || var_0 == "s4_me_rindigoww_mp" || var_0 == "s4_ar_tgun_mp";
}

_id_BEC0(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(var_1) && (istrue(self._id_493C) || istrue(level._id_493C))) {
    return;
  }
  if(!isDefined(self.pending_dialogue_events)) {
    self.pending_dialogue_events = [];
  }

  self.pending_dialogue_events = scripts\engine\utility::array_add(self.pending_dialogue_events, var_0);

  if(!istrue(self._id_493C)) {
    thread determine_dialogue_to_play();
  }
}

determine_dialogue_to_play() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self._id_493C = 1;
  wait 0.5;

  if(isDefined(self) && isDefined(self.pending_dialogue_events)) {
    var_0 = tablelookupgetnumrows("cp/cp_dialogue_events.csv");

    for(var_1 = 0; var_1 < var_0; var_1++) {
      var_2 = tablelookupbyrow("cp/cp_dialogue_events.csv", var_1, 0);

      if(isDefined(scripts\engine\utility::_id_1BAB(self.pending_dialogue_events, var_2))) {
        var_3 = tablelookupbyrow("cp/cp_dialogue_events.csv", var_1, 3);

        if(isDefined(var_3) && var_3 != "") {
          var_4 = float(var_3);

          if(isDefined(self.cooldown_vos[var_1]) && gettime() - self.cooldown_vos[var_1] < var_4 * 1000.0) {
            continue;
          }
          self.cooldown_vos[var_1] = gettime();
        }

        var_5 = int(tablelookupbyrow("cp/cp_dialogue_events.csv", var_1, 2));
        var_6 = randomintrange(0, 100);

        if(var_6 < var_5) {
          var_7 = tablelookupbyrow("cp/cp_dialogue_events.csv", var_1, 1);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{demon}", self.demon_core_alias);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{demon-short}", self.demon_hub_alias_a);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{superready}", self.super_ready_alias);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{superactivated}", self.super_activated_alias);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{supermulti}", self.super_multikill_alias);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{zm-operator}", self.zm_operator_alias);
          var_7 = scripts\engine\utility::_id_5AB3(var_7, "_", "{mp-operator}", self.mp_operator_alias);
          _id_B309(self, var_7);
          self._id_493C = 0;
          break;
        }
      }
    }
  }

  self.pending_dialogue_events = [];
  self._id_493C = 0;
}

get_event_alias(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0.demon_core_alias) && isDefined(var_0.zm_operator_alias) && isDefined(var_0.mp_operator_alias)) {
    var_3 = tablelookupgetnumrows("cp/cp_dialogue_events.csv");

    for(var_4 = 0; var_4 < var_3; var_4++) {
      if(scripts\engine\utility::is_equal(var_1, tablelookupbyrow("cp/cp_dialogue_events.csv", var_4, 0))) {
        var_2 = tablelookupbyrow("cp/cp_dialogue_events.csv", var_4, 1);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{demon}", var_0.demon_core_alias);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{superready}", var_0.super_ready_alias);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{superactivated}", var_0.super_activated_alias);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{supermulti}", var_0.super_multikill_alias);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{zm-operator}", var_0.zm_operator_alias);
        var_2 = scripts\engine\utility::_id_5AB3(var_2, "_", "{mp-operator}", var_0.mp_operator_alias);
        break;
      }
    }
  }

  return var_2;
}

play_event_vo_from_valid_players(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\cp\utility::_id_636E();
  var_2 = [];
  var_3 = undefined;
  var_4 = undefined;
  var_5 = -1;

  foreach(var_7 in var_1) {
    var_8 = get_event_alias(var_7, var_0);

    if(isDefined(var_8)) {
      var_9 = get_dialogue_length(var_8);

      if(isDefined(var_9)) {
        var_2 = scripts\engine\utility::array_add(var_2, [var_7, var_8]);

        if(var_9 > var_5) {
          var_5 = var_9;
          var_3 = var_7;
          var_4 = var_8;
        }
      }
    }
  }

  if(isDefined(var_3)) {
    foreach(var_12 in var_2) {
      var_7 = var_12[0];
      var_8 = var_12[1];

      if(var_7 != var_3 && isDefined(var_8)) {
        level thread _id_B309(var_7, var_8);
      }
    }

    level _id_B309(var_3, var_4);
  }
}

play_event_vo_from_selected_players(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;
  var_6 = -1;

  foreach(var_8 in var_1) {
    if(isPlayer(var_8)) {
      var_9 = get_event_alias(var_8, var_0);

      if(isDefined(var_9)) {
        var_10 = get_dialogue_length(var_9);

        if(isDefined(var_10)) {
          var_3 = scripts\engine\utility::array_add(var_3, [var_8, var_9]);

          if(var_10 > var_6) {
            var_6 = var_10;
            var_4 = var_8;
            var_5 = var_9;
          }
        }
      }
    }
  }

  if(isDefined(var_4)) {
    foreach(var_13 in var_3) {
      var_8 = var_13[0];
      var_9 = var_13[1];

      if(var_8 != var_4 && isDefined(var_9)) {
        if(istrue(var_2)) {
          level thread play_vo_to_player_ignore_teammate(var_8, var_9);
          continue;
        }

        level thread _id_B309(var_8, var_9);
      }
    }

    if(istrue(var_2)) {
      level play_vo_to_player_ignore_teammate(var_4, var_5);
    } else {
      level _id_B309(var_4, var_5);
    }
  }
}

init_approach_dialogue(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    if(isDefined(level.players)) {
      foreach(var_6 in level.players) {
        var_6 thread update_approach_vo(var_0, var_1, var_2, var_3, var_4);
      }
    }

    for(;;) {
      level waittill("player_spawned", var_6);

      if(isDefined(var_6)) {
        var_6 thread update_approach_vo(var_0, var_1, var_2, var_3, var_4);
      }
    }
  }
}

update_approach_vo(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "approach_" + var_1;
  self endon(var_5);
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  while(is_away_from_location(var_0, var_3, var_4) || !is_in_front(self, var_0) || istrue(level._id_0C35) || istrue(self._id_2031) || isDefined(level._id_3BE9._id_0F51) || getdvarint("#x3dee089cb49164e4e", 0) == 0 && level._id_11049 != 2 || istrue(self._id_493C)) {
    wait 0.2;

    if(!isDefined(self)) {
      return;
    }
  }

  play_approach_dialogue(var_1, var_2, 1);
  self notify(var_5);
}

is_away_from_location(var_0, var_1, var_2) {
  if(!isDefined(self) || !isPlayer(self)) {
    return 0;
  }

  if(istrue(var_2)) {
    return distancesquared(var_0, self.origin) > var_1;
  } else {
    return distance2dsquared(var_0, self.origin) > var_1;
  }
}

is_in_front(var_0, var_1) {
  var_2 = var_0 _id_09A5::_id_686F(var_1);
  return var_2 > -15 && var_2 < 15;
}

play_approach_dialogue(var_0, var_1, var_2) {
  if(istrue(var_2) && (istrue(self._id_493C) || istrue(level._id_493C))) {
    return;
  }
  _id_E88B();
  self._id_493C = 1;

  if(var_1) {
    var_0 = build_demon_hub_alias(var_0);
  }

  if(isDefined(var_0)) {
    _id_B309(self, var_0);
  }

  self._id_493C = 0;
}

build_demon_chatter_alias(var_0) {
  var_1 = scripts\cp\utility::_id_459B(self.demon_core_alias, "cmcp_cnrt_dnrt");
  var_2 = scripts\cp\utility::_id_459B(self.demon_skorpion_alias, "zohs_hbsk_dnrt");
  var_0 = scripts\engine\utility::_id_5AB3(var_0, "_", "{demon}", var_1);
  var_0 = scripts\engine\utility::_id_5AB3(var_0, "_", "{demon-skorpion}", var_2);
  return var_0;
}

build_demon_hub_alias(var_0) {
  if(!isDefined(self.demon_hub_alias_a)) {
    return undefined;
  }

  if(self.demon_hub_alias_a == "vrcn") {
    switch (var_0) {
      case "hin":
        return "zm_cdvc_dvcn_vrcn_gstr";
      case "hbx":
        return "zm_cdvc_dvcn_vrcn_hsoa";
      case "hdf":
        return "zm_cdvc_dvcn_vrcn_hspa";
      case "htr":
        return "zm_cdvc_dvcn_vrcn_hsqa";
      case "hac":
        return "zm_cdvc_dvcn_vrcn_hsra";
      case "hpp":
        return "zm_cdvc_dvcn_vrcn_hssa";
    }
  }

  return "zm_cmcp_obhb_" + self.demon_hub_alias_a + "_" + var_0 + self.demon_hub_alias_b;
}

_id_B309(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_2 = getdvarint("#x3654d27cdea5ec051");

  if(var_2 && !isDefined(scripts\engine\utility::_id_1BAB(level.allowed_dialogue_aliases, var_1))) {
    return;
  }
  var_0._id_4169 = var_1;

  if(_func_0107(var_1)) {
    var_1 = scripts\engine\utility::random(var_1);
  }

  if(_func_0205(var_1)) {
    play_table_alias(var_0, var_1);
    wait(get_dialogue_length(var_1));
  }

  var_0._id_4169 = "";
  var_0 notify("dialogue_finished");
}

play_vo_to_player_ignore_teammate(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_2 = getdvarint("#x3654d27cdea5ec051");

  if(var_2 && !isDefined(scripts\engine\utility::_id_1BAB(level.allowed_dialogue_aliases, var_1))) {
    return;
  }
  var_0._id_4169 = var_1;

  if(_func_0107(var_1)) {
    var_1 = scripts\engine\utility::random(var_1);
  }

  if(_func_0205(var_1)) {
    play_table_alias_ignore_teammate(var_0, var_1);
    wait(get_dialogue_length(var_1));
  }

  var_0._id_4169 = "";
  var_0 notify("dialogue_finished");
}

get_dialogue_length(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0205(var_0)) {
    return 0;
  }

  var_1 = scripts\cp\utility::_id_459B(var_1, 1);

  if(var_1) {
    var_2 = _func_0142(var_0, 1) / 1000 + 0.4;

    if(getdvarint("#x3ad67579137c951a9") != 0 && getdvarint("#x3ad67579137c951a9") != 1) {
      var_2 = var_2 + 1.5;
    }
  } else
    var_2 = _func_0142(var_0, 1) / 1000;

  return var_2;
}

play_table_alias(var_0, var_1) {
  var_2 = strtok(var_1, "_");

  if(var_2[0] == "zm") {
    var_0 _meth_8854("battlechatter", var_2[0] + "_" + var_2[1], var_2[2], var_2[3], var_2[4], var_0);

    if(isDefined(var_0.team)) {
      var_0 _meth_8855("battlechatter", var_2[0] + "_" + var_2[1] + "3d", var_2[2], var_2[3], var_2[4], var_0.team, var_0);
    }
  } else if(var_2[0] == "mp") {
    var_0 _meth_8854("battlechatter_mp", var_2[0] + "_" + var_2[1], var_2[2], var_2[3], var_2[4], var_0);

    if(isDefined(var_0.team)) {
      var_0 _meth_8855("battlechatter_mp", var_2[0] + "_" + var_2[1] + "3d", var_2[2], var_2[3], var_2[4], var_0.team, var_0);
    }
  }
}

play_table_alias_ignore_teammate(var_0, var_1) {
  var_2 = strtok(var_1, "_");

  if(var_2[0] == "zm") {
    var_0 _meth_8854("battlechatter", var_2[0] + "_" + var_2[1], var_2[2], var_2[3], var_2[4], var_0);
  } else if(var_2[0] == "mp") {
    var_0 _meth_8854("battlechatter_mp", var_2[0] + "_" + var_2[1], var_2[2], var_2[3], var_2[4], var_0);
  }
}

get_objective_alias(var_0, var_1) {
  if(!isDefined(level.objective_vo_aliases[var_0])) {
    return undefined;
  }

  return level.objective_vo_aliases[var_0][var_1];
}

play_event_narration(var_0) {
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 _id_E88B();
      var_2._id_493C = 1;
      var_2.pending_dialogue_events = [var_0];
    }
  }

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(isDefined(var_2)) {
      var_2 thread determine_dialogue_to_play();
    }
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2.pending_dialogue_events = [];
      var_2._id_493C = 0;
    }
  }
}

play_narration(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!var_1 && level._id_493C) {
    return;
  }
  if(istrue(level._id_493C)) {
    waittill_dialogue_finished(var_2);
  }

  if(_func_0107(var_0)) {
    var_0 = scripts\engine\utility::random(var_0);
  }

  _func_01EA("ui_zm_comms", get_portrait_index(strtok(var_0, "_")[3]));
  _id_B308(var_0, var_2);
  _func_01EA("ui_zm_comms", -1);
}

play_narrations(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  var_1 = scripts\cp\utility::_id_459B(var_1, 1);

  if(!var_1 && level._id_493C) {
    return;
  }
  if(istrue(level._id_493C)) {
    waittill_dialogue_finished(var_2);
  }

  if(!pre_play_vo()) {
    return;
  }
  if(isDefined(var_3)) {
    level endon(var_3);
    level thread play_narrations_watch_custom_endon(var_3);
  }

  level._id_4942 = var_0;

  foreach(var_5 in var_0) {
    _func_01EA("ui_zm_comms", get_portrait_index(strtok(var_5, "_")[3]));
    play_vo_to_all_internal(var_5, var_2);
    level._id_4942 = scripts\engine\utility::array_remove(level._id_4942, var_5);
  }

  post_play_vo();
  _func_01EA("ui_zm_comms", -1);
}

play_narrations_watch_custom_endon(var_0) {
  level endon("game_ended");
  level endon("dialogue_finished");
  level waittill(var_0);

  if(istrue(level._id_493C)) {
    thread post_play_vo(1);
    _func_01EA("ui_zm_comms", -1);
  }
}

get_portrait_index(var_0) {
  switch (var_0) {
    case "blkr":
      return 0;
    case "krft":
      return 1;
    case "dnvk":
      return 2;
    case "krtx":
      return 3;
    case "dnrt":
      return 4;
    case "dsrx":
      return 5;
    case "vlst":
      return 6;
    case "vrcn":
      return 7;
    default:
      return -1;
  }
}

pre_play_vo(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(istrue(level._id_493C)) {
    return 0;
  }

  level._id_493C = 1;
  level._id_18F9 = 1;
  return 1;
}

_id_B308(var_0, var_1) {
  if(!pre_play_vo(var_1)) {
    return;
  }
  play_vo_to_all_internal(var_0);
  post_play_vo();
}

play_vo_to_all_internal(var_0, var_1) {
  level._id_4169 = var_0;

  foreach(var_3 in level.players) {
    play_table_alias(var_3, var_0);
  }

  wait(get_dialogue_length(var_0, var_1));
}

post_play_vo(var_0) {
  foreach(var_2 in level.players) {
    if(istrue(var_0) && isDefined(level._id_4169)) {
      var_2 _meth_83EF(level._id_4169);
    }

    var_2 notify("dialogue_finished");
  }

  level notify("dialogue_finished");
  level._id_493C = 0;
  level._id_18F9 = 0;
  level._id_4169 = "";
  level._id_4942 = [];
}

waittill_dialogue_finished(var_0) {
  if(level._id_4942.size) {
    var_1 = 0;

    foreach(var_3 in level._id_4942) {
      var_1 = var_1 + get_dialogue_length(level._id_4169, var_0);
    }
  } else
    var_1 = get_dialogue_length(level._id_4169, var_0);

  level scripts\engine\utility::_id_108A7(var_1, "dialogue_finished");
}

_id_E88B() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(istrue(var_1._id_493C) && isDefined(var_1._id_4169) && _func_0121(var_1._id_4169) && var_1._id_4169 != "") {
      var_1 _meth_83EF(var_1._id_4169);
      var_1._id_493C = 0;
      var_1.pending_dialogue_events = [];
    }
  }

  _func_01EA("ui_zm_comms", -1);
  level._id_493C = 0;
  level._id_4942 = [];
}