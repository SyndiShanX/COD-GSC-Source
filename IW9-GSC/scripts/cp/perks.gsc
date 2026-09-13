/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks.gsc
***********************************************/

initperks() {
  init_core_mp_perks();
  _id_FE0D47259CB779C3();
}

init_each_perk() {
  if(!isDefined(level.health_scalar))
    level.health_scalar = 1;

  level.extra_charge_func = ::should_give_extra_charge;
  self.perk_data = [];
  self.perk_data["max_health"] = 100 * level.health_scalar;
  self.perk_data["regen_time_scalar"] = 1;
  self.perk_data["melee_scalar"] = 1.0;
  self.perk_data["melee_stun_radius"] = 0;
  self.perk_data["revive_time_scalar"] = 1.0;
  self.perk_data["move_speed_scalar"] = 1.0;
  self.perk_data["revive_damage_scalar"] = 1.0;
  self.perk_data["explosive_damage_scalar"] = 1.0;
  self.perk_data["offhand_count"] = 1;
  self.perk_data["launcher_ammo"] = 4;
  self.perk_data["friendly_explosive_damage_reduction"] = 1;
  self.perk_data["enemy_explosive_damage_reduction"] = 1;
  self.perk_data["bullet_damage_scalar"] = 1.0;
  self.perk_data["stealth_dist_scalar"] = 1;
  self.perk_data["stealth_velocity_override"] = 0;
  self.perk_data["stealth_weapon_noise_scalar"] = 1;
  self.perk_data["short_range_damage_scalar"] = 1;
  self.perk_data["hipfire_damage_scalar"] = 1;
  self.perk_data["sprint_damage_scalar"] = 1;
  self.perk_data["carrying_melee_damage_scalar"] = 1;
  self.perk_data["increased_materials"] = 0;
  self.perk_data["increased_materials_wallet"] = 0;
  self.perk_data["additional_crafting_items"] = 0;
  self.perk_data["cheap_crafting_recipe"] = 0;
  self.perk_data["increased_materials"] = 0;
  self.perk_data["increased_materials_wallet"] = 0;
  self.perk_data["additional_crafting_items"] = 0;
  self.perk_data["cheap_crafting_recipe"] = 0;
  self.perk_data["super_fill_scalar"] = 1;
  self.perk_data["weapons_have_full_ammo"] = 1;
  self.perk_data["enemy_damage_to_player_armor_scalar"] = 1;
  self.perk_data["damage_to_enemy_armor_scalar"] = 1;
  self.perk_data["hack_speed_boost"] = 0;
  thread _id_6F1E07CE9FF97D5F::track_consecutive_kills();
  init_class_changed_values();
}

init_class_changed_values() {
  self setaimspreadmovementscale(1.0);
  self notify("end_medic_health_regen");

  if(isDefined(self.old_view_kick)) {
    self setviewkickscale(self.old_view_kick);
    self.old_view_kick = undefined;
  }

  if(isDefined(self.old_recoil_scale)) {
    self player_recoilscaleon(100);
    self.old_recoil_scale = undefined;
  }
}

get_perk(_id_AB4A6235827672A0) {
  if(isDefined(self.perk_data[_id_AB4A6235827672A0]))
    return self.perk_data[_id_AB4A6235827672A0];
}

set_perk(_id_AB4A6235827672A0, value) {
  if(isDefined(self.perk_data[_id_AB4A6235827672A0]))
    self.perk_data[_id_AB4A6235827672A0] = value;
}

blank() {}

medic_speed_buff() {
  self.perk_data["move_speed_scalar"] = 1.12;
  self.movespeedscaler = 1.12;
  thread _id_12E2FB553EC1605E::updatemovespeedscale();
}

medic_health_regen(_id_A9B6B677F6D0A010) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  self endon("giving_class");
  _id_55EDBC76CB692E0A = _id_A9B6B677F6D0A010 > 0.0;

  for(;;) {
    foreach(player in level.players) {
      if(player scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(player.medic_regeneration)) {
        if(_id_55EDBC76CB692E0A && distancesquared(self.origin, player.origin) > _id_A9B6B677F6D0A010)
          continue;
      }
    }

    wait 1.0;
  }
}

medic_regenerate_health_once() {
  self endon("death");
  self endon("disconnect");
  self.medic_regeneration = 1;
  wait 1.0;
  self.health = int(min(self.maxhealth, self.health + 5.0));
  self.medic_regeneration = undefined;
}

should_give_extra_charge(equipment) {
  if(isDefined(equipment)) {
    switch (equipment) {
      case "equip_molotov":
      case "equip_gas_grenade":
      case "equip_concussion":
      case "equip_snapshot_grenade":
      case "equip_smoke":
      case "equip_at_mine":
      case "equip_c4":
      case "equip_claymore":
      case "equip_frag":
      case "equip_semtex":
      case "equip_throwing_knife":
      case "equip_bunkerbuster":
      case "equip_thermite":
        return self.perk_data["offhand_count"];
      default:
        break;
    }
  }

  return undefined;
}

reload_on_kill() {
  for(;;) {
    self waittill("kill_score");
    _id_04A8F5643E919524 = self getcurrentprimaryweapon();
    _id_DEAB3AF8D6303B6C = self getammocount(_id_04A8F5643E919524);
    _id_1903A4E1B4C39DE1 = int(min(_id_DEAB3AF8D6303B6C, weaponclipsize(_id_04A8F5643E919524)));
    _id_55F9D1C63B74482E = _id_DEAB3AF8D6303B6C - _id_1903A4E1B4C39DE1;
    self setweaponammoclip(_id_04A8F5643E919524, _id_1903A4E1B4C39DE1);
    self setweaponammostock(_id_04A8F5643E919524, _id_55F9D1C63B74482E);
    wait 0.1;
  }
}

reduce_recoil() {
  self.old_view_kick = self getviewkickscale();
  self.overchargeviewkickscale = 0;
  self.old_recoil_scale = self player_getrecoilscale();
  self player_recoilscaleon(0);
  self.onhelisniper = 1;
  _id_74502A9E0EF1F19C::updateviewkickscale();
}

remove_reduce_recoil() {
  if(isDefined(self.old_recoil_scale)) {
    if(self.old_recoil_scale != -1)
      self player_recoilscaleon(self.old_recoil_scale);
    else
      self player_recoilscaleon(100);

    self.old_recoil_scale = undefined;
  }

  self.overchargeviewkickscale = undefined;
  self.onhelisniper = undefined;
  _id_74502A9E0EF1F19C::updateviewkickscale();
}

reduce_bullet_spread() {
  scripts\cp\utility::giveperk("specialty_bulletaccuracy");
  self setaimspreadmovementscale(0.1);
}

run_deadeye_charge_watcher() {
  self endon("disconnect");
  self endon("end_deadeye_charge_watcher");
  self endon("giving_class");
  self.deadeye_charge = undefined;
  _id_F45F84783A1CC4D2 = undefined;
  _id_BC4B686E2F1D19E2 = undefined;
  _id_5C36FC93F90947F5 = 500;

  for(;;) {
    if(self adsButtonPressed()) {
      _id_4FB72B720667636B = gettime();

      if(!isDefined(_id_F45F84783A1CC4D2)) {
        _id_F45F84783A1CC4D2 = _id_4FB72B720667636B;
        _id_BC4B686E2F1D19E2 = _id_4FB72B720667636B + _id_5C36FC93F90947F5;
      } else if(_id_4FB72B720667636B > _id_BC4B686E2F1D19E2) {
        if(!istrue(self.deadeye_charge)) {}

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      _id_F45F84783A1CC4D2 = undefined;
      _id_BC4B686E2F1D19E2 = undefined;
    }

    wait 0.05;
  }
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.scriptperks["specialty_remote_defuse"] = 1;
  level.perksetfuncs["specialty_momentum"] = ::setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = ::unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = ::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = ::unsetfreefall;
  level.perksetfuncs["specialty_remote_defuse"] = ::setremotedefuse;
  level.perkunsetfuncs["specialty_remote_defuse"] = ::unsetremotedefuse;
  level.scriptperks["specialty_hustle"] = 1;
  level.extraperkmap["specialty_hustle"] = ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement", "specialty_stalker", "specialty_quickdraw", "specialty_fastreload", "specialty_quickswap"];
  level.scriptperks["specialty_bulletdamage"] = 1;
  level.extraperkmap["specialty_bulletdamage"] = ["specialty_overcharge"];
  level.perksetfuncs["specialty_overcharge"] = ::setovercharge;
  level.perkunsetfuncs["specialty_overcharge"] = ::unsetovercharge;
  registerscriptperk("specialty_restock", undefined, undefined, ["specialty_recharge_equipment"]);
  registerscriptperk("specialty_recharge_equipment", ::give_restock, ::take_restock);
  registerscriptperk("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade"]);
  registerscriptperk("specialty_improved_field_upgrades");
  registerscriptperk("specialty_faster_field_upgrade", ::give_tune_up, ::take_tune_up);
  registerscriptperk("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective"]);
  registerscriptperk("specialty_reduce_regen_delay_on_kill", ::setreduceregendelayonkills, ::unsetreduceregendelayonkills);
  registerscriptperk("specialty_reduce_regen_delay_on_objective", ::setreduceregendelayonobjective, ::unsetreduceregendelayonobjective);
  registerscriptperk("specialty_hardline", ::sethardline, ::unsethardline);
  registerscriptperk("specialty_extra_tactical", ::_id_122A864516A39BDA, ::_id_C6DF31F2EE8FE243);
  registerscriptperk("specialty_extra_deadly", ::_id_2E412ECE8104CCE5, ::_id_3BA1BA85AAD48A42);
  registerscriptperk("specialty_extra_equipment", undefined, undefined, ["specialty_extra_deadly", "specialty_extra_tactical"]);
  registerscriptperk("specialty_warhead", ::give_amped, ::take_amped, ["specialty_fastreload_launchers"]);
  registerscriptperk("specialty_fastreload_launchers", ::setfastreloadlaunchers, ::unsetfastreloadlaunchers);
  registerscriptperk("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_twoprimaries", ::setoverkill, ::unsetoverkill, []);
  registerscriptperk("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak"]);
  registerscriptperk("specialty_killstreak_to_scorestreak", ::setkillstreaktoscorestreak, ::unsetkillstreaktoscorestreak);
  registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  registerscriptperk("specialty_sixth_sense", ::setsixthsense, ::unsetsixthsense);
  registerscriptperk("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  registerscriptperk("specialty_shrapnel");
  registerscriptperk("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  registerscriptperk("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_silentkill", "specialty_sixth_sense_immune", "specialty_heartbreaker"]);
  registerscriptperk("specialty_ghost", ::setghost, ::unsetghost, ["specialty_gpsjammer"]);
  registerscriptperk("specialty_silentkill");
  registerscriptperk("specialty_sixth_sense_immune");
  registerscriptperk("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist"]);
  registerscriptperk("specialty_stun_resistance", ::setstunresistance, ::unsetstunresistance, ["specialty_hard_shell"]);
  registerscriptperk("specialty_emp_resist");
  registerscriptperk("specialty_hard_shell", ::sethardshell, ::unsethardshell);
  registerscriptperk("specialty_gas_grenade_resist", ::setgasgrenaderesist, ::unsetgasgrenaderesist);
  registerscriptperk("specialty_scrambler_resist");
  registerscriptperk("specialty_covert_ops", undefined, undefined, ["specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_snapshot_immunity"]);
  registercodeperkinfo("specialty_blindeye", ::setblindeye, ::unsetblindeye);
  registerscriptperk("specialty_noscopeoutline", ::setnoscopeoutline, ::unsetnoscopeoutline);
  registerscriptperk("specialty_snapshot_immunity");
  registerscriptperk("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks"]);
  registerscriptperk("specialty_chain_killstreaks");
  registerscriptperk("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment"]);
  registerscriptperk("specialty_engineer", ::setengineer, ::unsetengineer, ["specialty_outlinekillstreaks"]);
  registerscriptperk("specialty_markequipment", ::setmarkequipment, ::unsetmarkequipment);
  registerscriptperk("specialty_outlinekillstreaks", ::setoutlinekillstreaks, ::unsetoutlinekillstreaks);
  level thread set_mark_distances();
  registerscriptperk("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);
  registerscriptperk("specialty_blastshield", ::setblastshield, ::unsetblastshield);
  registerscriptperk("specialty_hack");
  registerscriptperk("specialty_shrapnel_resist");
  registerscriptperk("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report"]);
  registerscriptperk("specialty_tracker", ::settracker, ::unsettracker, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_kill_report");
  registercodeperkinfo("specialty_snakecam");
  registerscriptperk("specialty_glintxsml");
  registerscriptperk("specialty_glintsml");
  registerscriptperk("specialty_glintmed");
  registerscriptperk("specialty_glintlrg");
  registerscriptperk("specialty_glintxlrg");
  registerscriptperk("specialty_ammo_disabling");
  registerscriptperk("specialty_viewkickoverride", ::setviewkickoverride, ::unsetviewkickoverride);
  registerscriptperk("specialty_delayhealing");
  registerscriptperk("specialty_hardmelee", ::set_heavy_hitter, ::unset_heavy_hitter);
  registerscriptperk("specialty_block_health_regen", ::setblockhealthregen, ::unsetblockhealthregen);
  registercodeperkinfo("specialty_spygame");
  registerscriptperk("specialty_swimming", undefined, undefined, ["specialty_spygame", "specialty_coldblooded"]);
  registerscriptperk("specialty_pitcher", ::setpitcher, ::unsetpitcher);
  registerscriptperk("specialty_wounding");
  registerscriptperk("specialty_flashlight");
  registerscriptperk("specialty_incendiary");
  registerscriptperk("specialty_smags");
  registerscriptperk("specialty_akimbo");
  registerscriptperk("specialty_explosivebullet");
  registerscriptperk("specialty_rshieldradar", ::setrshieldradar, ::unsetrshieldradar);
  registerscriptperk("specialty_rshieldscrambler", ::setrshieldscrambler, ::unsetrshieldscrambler);
  registerscriptperk("specialty_highlight");
  registerscriptperk("specialty_extraclip");
  registerscriptperk("specialty_gunmelee");
  registerscriptperk("specialty_talkinggun_test1", _id_189B67B2735B981D::_id_096F59FEFD781E47, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test2", _id_189B67B2735B981D::_id_096F5AFEFD78207A, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test3", _id_189B67B2735B981D::_id_096F5BFEFD7822AD, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test4", _id_189B67B2735B981D::_id_096F54FEFD781348, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_announcer", _id_189B67B2735B981D::_id_FC6E0B02ABB995CB, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_robot", _id_189B67B2735B981D::_id_73E4AE4F932E9F30, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_blackcell", _id_189B67B2735B981D::_id_CC0FDDFE26B772A7, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_npc", _id_189B67B2735B981D::_id_FC09644394BF843F, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_cat", _id_189B67B2735B981D::_id_44D73A43CA35CBCC, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_dog", _id_189B67B2735B981D::_id_514A7643D295A3A2, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_doomscreen", _id_189B67B2735B981D::_id_62E0BCEF615A8D1D, _id_189B67B2735B981D::_id_ADE69726300553AC);
}

_id_FE0D47259CB779C3() {
  registerscriptperk("specialty_fast_health_regen");
  registerscriptperk("specialty_quick_revive");
  registerscriptperk("specialty_extra_armor", ::_id_221C99519FBCDCEA, ::_id_AADEF05E93AD3AA3);
  registerscriptperk("specialty_extra_weapon");
  registerscriptperk("specialty_armor_satchel");
  registerscriptperk("specialty_increased_armor_health", ::_id_E12E572D8CE0F156, ::_id_91D0E484A126DB5F);
}

setrshieldradar() {
  self endon("unsetRShieldRadar");
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    unsetrshieldradar();
}

unsetrshieldradar() {
  self clearportableradar();
  self notify("unsetRShieldRadar");
}

setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

setrshieldscrambler_cleanup() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    unsetrshieldscrambler();
}

unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

_id_221C99519FBCDCEA() {
  _id_07C40FA80892A721::initarmor(1);
}

_id_AADEF05E93AD3AA3() {
  _id_07C40FA80892A721::initarmor(1);
}

_id_122A864516A39BDA() {
  self endon("disconnect");
  self endon("setExtraTacticalEquipment");
  level endon("game_ended");

  if(istrue(self.gettingloadout))
    self waittill("loadout_given");

  ref = _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");

  if(isDefined(ref) && ref != "none")
    _id_7EF95BBA57DC4B82::incrementequipmentammo(ref);
}

_id_C6DF31F2EE8FE243() {
  self notify("setExtraTacticalEquipment");
}

_id_2E412ECE8104CCE5() {
  self endon("disconnect");
  self endon("setExtraPrimaryEquipment");
  level endon("game_ended");

  if(istrue(self.gettingloadout))
    self waittill("loadout_given");

  ref = _id_7EF95BBA57DC4B82::getcurrentequipment("primary");

  if(isDefined(ref) && ref != "none")
    _id_7EF95BBA57DC4B82::incrementequipmentammo(ref);
}

_id_3BA1BA85AAD48A42() {
  self notify("setExtraPrimaryEquipment");
}

_id_E12E572D8CE0F156() {
  self._id_163E87B7D147DF4E = 1;
  _id_07C40FA80892A721::initarmor();
  self._id_34867328231CA54B = 450;
}

_id_91D0E484A126DB5F() {
  self._id_163E87B7D147DF4E = undefined;
}

setpitcher() {
  thread setpitcherinternal();
}

unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("unsetPitcher");
}

setpitcherinternal() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.5);
    self waittill("grenade_pullback", objweapon);
    _id_15E599DA51A42FC2 = objweapon.basename;

    if(_id_15E599DA51A42FC2 == "airdrop_marker_mp" || _id_15E599DA51A42FC2 == "deployable_vest_marker_mp" || _id_15E599DA51A42FC2 == "deployable_weapon_crate_marker_mp")
      self setgrenadethrowscale(1);

    self waittill("grenade_fire", grenade, objweapon);
  }
}

registerscriptperk(perkname, setfunc, unsetfunc, extraperkmap) {
  registerperk(perkname, 1, setfunc, unsetfunc, extraperkmap);
}

registercodeperkinfo(perkname, setfunc, unsetfunc, extraperkmap) {
  registerperk(perkname, 0, setfunc, unsetfunc, extraperkmap);
}

registerperk(perkname, _id_9AA715F8120F5692, setfunc, unsetfunc, extraperkmap) {
  if(istrue(_id_9AA715F8120F5692))
    level.scriptperks[perkname] = 1;

  if(isDefined(setfunc))
    level.perksetfuncs[perkname] = setfunc;

  if(isDefined(unsetfunc))
    level.perkunsetfuncs[perkname] = unsetfunc;

  if(isDefined(extraperkmap))
    level.extraperkmap[perkname] = extraperkmap;
}

setovercharge() {
  self setclientomnvar("ui_overcharge", 1);
}

unsetovercharge() {
  self setclientomnvar("ui_overcharge", 0);
}

setfreefall() {}

unsetfreefall() {}

setremotedefuse() {}

unsetremotedefuse() {}

sethardshell() {
  self.shellshockreduction = 0.25;
}

unsethardshell() {
  self.shellshockreduction = 0;
}

setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive())
    return;
}

unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive())
    return;
}

setreduceregendelayonkills() {}

unsetreduceregendelayonkills() {}

setreduceregendelayonobjective() {}

unsetreduceregendelayonobjective() {}

sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");

  if(scripts\cp\utility::is_specops_gametype()) {
    return;
  }
  thread run_kill_watcher();
  self.hardlineactive["assists"] = 0;
}

unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

run_kill_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("perk_end_hardline");
  _id_6D85D0102FD52796 = 7;

  for(;;) {
    if(isDefined(self.consecutive_kills) && self.consecutive_kills > _id_6D85D0102FD52796)
      give_random_munition();

    waitframe();
  }
}

give_random_munition() {
  types = undefined;
  types = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  loot_type = scripts\engine\utility::random(types);
  scripts\cp\loot_system::give_munition(loot_type, self);
  wait 10;
}

setfastreloadlaunchers() {}

unsetfastreloadlaunchers() {}

setoverkill() {}

unsetoverkill() {}

setkillstreaktoscorestreak() {}

unsetkillstreaktoscorestreak() {}

sixthsense_think_internal() {
  if(scripts\engine\utility::flag("stealth_spotted")) {
    foreach(guy in level.players)
    guy setclientomnvar("ui_edge_glow", 0);

    return;
  }

  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_0C0269881CB3B186 = 0;
  _id_7A25DDB41E7358DB = undefined;
  _id_0746071AB06F38FD = undefined;
  time = getsystemtimeinmicroseconds();

  foreach(num, player in level.sixth_sense_players) {
    if(!isDefined(player)) {
      level.sixth_sense_players[num] = undefined;
      break;
    }

    if(istrue(player.ignoreme) || istrue(player.notarget)) {
      continue;
    }
    player._id_FA89613ACD0EB87E = 0;
    _id_75ABBF0830C5D3FA = 0;
    _id_F9BC699768A98866 = 0;
    _id_1925D24D0AE333E6 = player getEye();
    playerteam = player.team;
    _id_10E9894DC0EB9765 = anglesToForward(player getplayerangles());

    foreach(_id_6EE5484560EC747C in getaiarray("bad_guys")) {
      if(player._id_FA89613ACD0EB87E >= 25) {
        player._id_FA89613ACD0EB87E = 0;
        waitframe();
      }

      if(!isDefined(player)) {
        level.sixth_sense_players[num] = undefined;
        break;
      }

      if(!player scripts\cp\utility::_hasperk("specialty_sixth_sense")) {
        continue;
      }
      if(istrue(player.ignoreme) || istrue(player.notarget)) {
        continue;
      }
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(_id_6EE5484560EC747C)) {
        continue;
      }
      if(!isDefined(_id_6EE5484560EC747C.stealth)) {
        continue;
      }
      if(!_id_6EE5484560EC747C scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(istrue(_id_6EE5484560EC747C.ignoreall)) {
        continue;
      }
      if(_id_6EE5484560EC747C.team == playerteam) {
        continue;
      }
      if(distancesquared(_id_6EE5484560EC747C.origin, _id_1925D24D0AE333E6) > 16000000) {
        continue;
      }
      if(!_id_6EE5484560EC747C is_enemy_dangerous(player)) {
        continue;
      }
      player._id_FA89613ACD0EB87E++;

      if(!_id_6EE5484560EC747C cansee(player)) {
        continue;
      }
      _id_F5AA6039EFDCFF26 = _id_6EE5484560EC747C getEye();
      _id_ED6E173AA5E562A5 = anglesToForward(_id_6EE5484560EC747C getplayerangles());
      _id_577D4BC399877AE4 = _id_1925D24D0AE333E6 - _id_F5AA6039EFDCFF26;
      _id_7A25DDB41E7358DB = _id_F5AA6039EFDCFF26 - _id_1925D24D0AE333E6;
      dot = vectordot(_id_10E9894DC0EB9765, vectorNormalize(_id_7A25DDB41E7358DB));
      player._id_FA89613ACD0EB87E = player._id_FA89613ACD0EB87E + 2;
      _id_75ABBF0830C5D3FA = _id_75ABBF0830C5D3FA | player getsixthsensedirection(_id_6EE5484560EC747C);

      if(_id_6EE5484560EC747C scripts\stealth\utility::_id_6A86DD83C01F8FAA() && !isDefined(_id_6EE5484560EC747C._id_BB5D687F2F98454A)) {
        _id_F9BC699768A98866 = _id_F9BC699768A98866 | player getsixthsensedirection(_id_6EE5484560EC747C);

        if(_id_F9BC699768A98866 > 0) {
          if(!isDefined(player._id_80221E9C5627503A))
            player._id_80221E9C5627503A = gettime();

          if(gettime() >= player._id_80221E9C5627503A) {
            player._id_80221E9C5627503A = gettime() + 5000;
            player playlocalsound("ui_stealth_spotted_vision");
          }
        }

        continue;
      }

      if(isDefined(level._id_28C0D60E971FF699)) {
        _id_451B85725D725AC9 = ["left", "right", "lower", "upper"];

        foreach(dir in _id_451B85725D725AC9) {
          active = _id_14C8D34A7E2B92C1(dir, _id_75ABBF0830C5D3FA);
          spotted = _id_14C8D34A7E2B92C1(dir, _id_F9BC699768A98866);
          player _id_494FDA903EF1977C(dir, active, spotted, _id_75ABBF0830C5D3FA, _id_F9BC699768A98866);
          player thread[[level._id_28C0D60E971FF699]](dir, active, spotted);
        }
      }

      break;
    }

    player updatesixthsensevfx(_id_75ABBF0830C5D3FA);
  }
}

_id_494FDA903EF1977C(dir, active, spotted, _id_75ABBF0830C5D3FA, _id_F9BC699768A98866) {
  if(_id_75ABBF0830C5D3FA > 0) {
    if(_id_F9BC699768A98866 == 0 && _func_EAC0CD99C9C6D8EE() != "spotted") {
      if(!isDefined(self._id_33DF676309C77FC4))
        self._id_33DF676309C77FC4 = gettime();

      if(gettime() >= self._id_33DF676309C77FC4) {
        self._id_33DF676309C77FC4 = gettime() + 5000;
        self playlocalsound("ui_stealth_threat_hud_periph_vision");
      }
    }
  }

  if(_id_F9BC699768A98866 > 0 || istrue(spotted) || _func_EAC0CD99C9C6D8EE() == "spotted") {
    if(!isDefined(self._id_80221E9C5627503A))
      self._id_80221E9C5627503A = gettime();

    if(gettime() >= self._id_80221E9C5627503A) {
      self._id_80221E9C5627503A = gettime() + 5000;
      self playlocalsound("ui_stealth_spotted_vision");
    }
  }
}

_id_14C8D34A7E2B92C1(dir, mask) {
  _id_91C0D90230D51049 = [];

  switch (dir) {
    case "left":
      _id_91C0D90230D51049 = [128, 32];
      break;
    case "right":
      _id_91C0D90230D51049 = [64, 8];
      break;
    case "upper":
      _id_91C0D90230D51049 = [4, 2, 1];
      break;
    case "lower":
      _id_91C0D90230D51049 = [16];
      break;
    default:
      break;
  }

  foreach(_id_A85BB3E5070650D1 in _id_91C0D90230D51049) {
    if(mask &_id_A85BB3E5070650D1)
      return 1;
  }

  return 0;
}

sixthsense_inotherplayertargetcone(_id_6EE5484560EC747C, _id_1925D24D0AE333E6, _id_F5AA6039EFDCFF26, _id_ED6E173AA5E562A5) {
  _id_577D4BC399877AE4 = _id_1925D24D0AE333E6 - _id_F5AA6039EFDCFF26;
  dot = vectordot(_id_577D4BC399877AE4, _id_ED6E173AA5E562A5);

  if(dot <= 0)
    return 0;

  _id_33E2AF87C7B68CE8 = length(_id_577D4BC399877AE4);
  _id_A4B3B596DCF9790C = 12;
  _id_A4B3B596DCF9790C = _id_A4B3B596DCF9790C + -0.15 * sqrt(_id_33E2AF87C7B68CE8);
  _id_B6B1CD24E33B485F = scripts\engine\math::degrees_to_radians(_id_A4B3B596DCF9790C);
  _id_29F5E95C42138166 = 1 - 0.5 * _id_B6B1CD24E33B485F * _id_B6B1CD24E33B485F;

  if(dot < _id_29F5E95C42138166 * _id_33E2AF87C7B68CE8)
    return 0;

  return 1;
}

sixthsense_playerseesotherplayer(_id_10E9894DC0EB9765, _id_1925D24D0AE333E6, _id_F5AA6039EFDCFF26) {
  _id_7A25DDB41E7358DB = _id_F5AA6039EFDCFF26 - _id_1925D24D0AE333E6;
  dot = vectordot(_id_10E9894DC0EB9765, vectorNormalize(_id_7A25DDB41E7358DB));

  if(dot < 0.382683)
    return 1;

  return 0;
}

is_enemy_dangerous(player) {
  if(istrue(self.juggernaut))
    return 1;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 1;

  objweapon = self.weapon;
  _id_CF4209C200F8BBF4 = _id_74502A9E0EF1F19C::getweapongroup(objweapon);

  switch (_id_CF4209C200F8BBF4) {
    case "weapon_battle":
    case "weapon_smg":
    case "weapon_lmg":
    case "weapon_projectile":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_assault":
      return 1;
    case "weapon_shotgun":
      if(distancesquared(self.origin, player.origin) > 160000)
        return 1;

      break;
  }

  return 0;
}

sixthsense_think() {
  self endon("disconnect");
  level endon("game_ended");
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

setsixthsense() {
  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  _id_6EA8E24D4901E87C = self getentitynumber();
  level.sixth_sense_players[_id_6EA8E24D4901E87C] = self;
}

unsetsixthsense() {
  updatesixthsensevfx(0);
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  _id_6EA8E24D4901E87C = self getentitynumber();
  level.sixth_sense_players[_id_6EA8E24D4901E87C] = undefined;
}

updatesixthsensevfx(_id_75ABBF0830C5D3FA) {}

getsixthsensedirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  _id_9D9E76097A59CB60 = (forward[0], forward[1], forward[2]);
  _id_9D9E76097A59CB60 = vectorNormalize(_id_9D9E76097A59CB60);
  _id_9001DA663C7CDFEC = enemy.origin - self.origin;
  _id_4720FAE3929BBDBA = (_id_9001DA663C7CDFEC[0], _id_9001DA663C7CDFEC[1], _id_9001DA663C7CDFEC[2]);
  _id_4720FAE3929BBDBA = vectorNormalize(_id_4720FAE3929BBDBA);
  dot = vectordot(_id_9D9E76097A59CB60, _id_4720FAE3929BBDBA);

  if(dot >= 0.92388)
    return 2;
  else if(dot >= 0.5)
    return scripts\engine\utility::ter_op(scripts\cp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 4, 1);
  else if(dot >= 0.5)
    return scripts\engine\utility::ter_op(scripts\cp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 128, 64);
  else if(dot >= -0.707107)
    return scripts\engine\utility::ter_op(scripts\cp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 32, 8);
  else
    return 16;
}

setghost() {
  self.perk_data["stealth_dist_scalar"] = 0.5;
}

unsetghost() {
  self.perk_data["stealth_dist_scalar"] = 1;
}

setstunresistance(_id_49E6BA16EAED299C) {
  if(!isDefined(_id_49E6BA16EAED299C))
    _id_49E6BA16EAED299C = 4;

  _id_49E6BA16EAED299C = int(_id_49E6BA16EAED299C);

  if(_id_49E6BA16EAED299C == 10)
    self.stunscalar = 0;
  else
    self.stunscalar = _id_49E6BA16EAED299C / 10;
}

unsetstunresistance() {
  self.stunscalar = 1;
}

setblindeye() {}

unsetblindeye() {}

setnoscopeoutline() {}

unsetnoscopeoutline() {}

setengineer() {
  thread engineer_enablemarksafterprematch();
}

engineer_enablemarksafterprematch() {
  self endon("unsetEngineer");
  self enableentitymarks("equipment", 1000000);
  self.perkengineerset = 1;
  thread markedentities_think();
}

unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("equipment");
    self.perkengineerset = undefined;
  }

  self notify("unsetEngineer");
}

allow_br_loot_to_br_marked() {
  if(!isDefined(level.teamdata))
    level.teamdata = [];

  if(!isDefined(level.teamdata["allies"]))
    level.teamdata["allies"] = [];

  if(!isDefined(level.teamdata["allies"]["players"]))
    level.teamdata["allies"]["players"] = level.players;

  _id_792740C4C87CF9FA = getentitylessscriptablearray(undefined, undefined, self.origin, 2000);

  foreach(_id_A0DDCCC8DA0CA6AB in _id_792740C4C87CF9FA) {
    if(issubstr(_id_A0DDCCC8DA0CA6AB.type, "brloot_munition")) {
      _id_A0DDCCC8DA0CA6AB.fake_model = spawn("script_model", _id_A0DDCCC8DA0CA6AB.origin);
      _id_A0DDCCC8DA0CA6AB.fake_model.angles = _id_A0DDCCC8DA0CA6AB.angles;
      _id_A0DDCCC8DA0CA6AB.fake_model setModel("container_ammo_box_01_nophysics_cp");
      _id_A0DDCCC8DA0CA6AB.fake_model enableplayermarks("equipment");
      scripts\cp\cp_outline_utility::outlineenableforplayer(_id_A0DDCCC8DA0CA6AB.fake_model, self, "spotter_notarget_equipment", "perk");
    }

    waitframe();
  }
}

make_sure_loot_is_visible() {
  _id_7507F409FEE2B657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(name in _id_7507F409FEE2B657) {
    _id_792740C4C87CF9FA = getentitylessscriptablearray(undefined, undefined, undefined, undefined, name);
    count = 0;

    foreach(_id_31F869647E8740B4 in _id_792740C4C87CF9FA) {
      _id_31F869647E8740B4 setscriptablepartstate(name, "visible");
      count++;

      if(count % 20)
        wait 0.1;
    }

    wait 0.1;
  }
}

make_outline_ents() {
  _id_58A11D31A3C59E82 = 10;
  level.outline_ents = [];
  level.outline_ent_index = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_58A11D31A3C59E82; _id_AC0E594AC96AA3A8++) {
    level.outline_ents[_id_AC0E594AC96AA3A8] = spawn("script_model", (0, 0, 0));
    level.outline_ents[_id_AC0E594AC96AA3A8].angles = (0, 0, 0);
    level.outline_ents[_id_AC0E594AC96AA3A8] setModel("container_ammo_box_01_nophysics_cp");
    level.outline_ents[_id_AC0E594AC96AA3A8] enableplayermarks("equipment");
  }

  thread monitor_outline_ents();
}

monitor_outline_ents() {
  level endon("game_ended");

  for(;;) {
    if(scripts\cp\utility::_hasperk("specialty_engineer"))
      get_closest_munitions();

    wait 0.1;
  }
}

get_closest_munitions() {
  _id_B69312781EDC9EA6 = 1000;
  _id_58A11D31A3C59E82 = 10;
  _id_7507F409FEE2B657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];
  _id_1D88CBBB14926330 = [];

  foreach(name in _id_7507F409FEE2B657) {
    _id_792740C4C87CF9FA = getentitylessscriptablearray(undefined, undefined, self.origin, _id_B69312781EDC9EA6, name);

    foreach(_id_31F869647E8740B4 in _id_792740C4C87CF9FA)
    _id_1D88CBBB14926330[_id_1D88CBBB14926330.size] = _id_31F869647E8740B4;
  }

  _id_1D88CBBB14926330 = sortbydistance(_id_1D88CBBB14926330, self.origin);
  _id_93DFF4684377D4C0 = level.outline_ents;
  _id_586B9984FDEB517B = [];
  _id_5F8B983A9CC28FB2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1D88CBBB14926330.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.outline_ent_index[_id_1D88CBBB14926330[_id_AC0E594AC96AA3A8].index]))
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = _id_1D88CBBB14926330[_id_AC0E594AC96AA3A8];
  }

  if(_id_5F8B983A9CC28FB2.size > 0) {
    outline_ent_index = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < min(_id_5F8B983A9CC28FB2.size, _id_58A11D31A3C59E82); _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.outline_ents.size; _id_AC0E5C4AC96AAA41++) {
        if(isDefined(_id_586B9984FDEB517B[_id_AC0E5C4AC96AAA41])) {
          continue;
        }
        if(isDefined(level.outline_ents[_id_AC0E5C4AC96AAA41]))
          level.outline_ents[_id_AC0E5C4AC96AAA41] dontinterpolate();

        level.outline_ents[_id_AC0E5C4AC96AAA41].origin = _id_5F8B983A9CC28FB2[_id_AC0E594AC96AA3A8].origin;
        level.outline_ents[_id_AC0E5C4AC96AAA41].angles = _id_5F8B983A9CC28FB2[_id_AC0E594AC96AA3A8].angles;
        level.outline_ents[_id_AC0E5C4AC96AAA41].index = _id_5F8B983A9CC28FB2[_id_AC0E594AC96AA3A8].index;
        level.outline_ent_index[level.outline_ents[_id_AC0E5C4AC96AAA41].index] = undefined;
        level.outline_ent_index[_id_5F8B983A9CC28FB2[_id_AC0E594AC96AA3A8].index] = level.outline_ents[_id_AC0E5C4AC96AAA41];
        unmarkent(level.outline_ents[_id_AC0E5C4AC96AAA41]);
        _id_586B9984FDEB517B[_id_AC0E5C4AC96AAA41] = _id_5F8B983A9CC28FB2[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }
}

unmarkent(_id_BE331B5A39B1738A) {
  _id_BE331B5A39B1738A filterinplayermarks(undefined);
  self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, _id_BE331B5A39B1738A);
  _id_BE331B5A39B1738A notify("unmarkEnt_" + self getentitynumber());
}

setmarkequipment() {
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

unsetmarkequipment() {
  if(isDefined(self.markequipmentstate)) {
    foreach(ent in self.markequipmentstate.markedents) {
      if(isDefined(ent))
        unmarkent(ent);
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("mark_equip_ended");
}

markequipment_monitorlook() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");

  if(!isDefined(self.markequipmentstate)) {
    self.markequipmentstate = spawnStruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
  }

  for(;;) {
    self waittill("marks_target_changed", ent);
    _id_49ED8019E89F9C5A = isDefined(ent) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = ent;
    self.markequipmentstate.markingtime = 0;

    if(_id_49ED8019E89F9C5A)
      thread markequipment_updatestate();
  }
}

set_mark_distances() {
  level.see_air_killstreak_dist = 6000;
  level.see_killstreak_dist = 1500;
  level.see_equipment_dist = 1000;
}

markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  _id_B4C04337A6A90C84 = gettime();
  maxdist = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent))
    maxdist = level.see_air_killstreak_dist;
  else if(self entityhasmark("killstreak", self.markequipmentstate.markingent))
    maxdist = level.see_killstreak_dist;
  else if(self entityhasmark("equipment", self.markequipmentstate.markingent))
    maxdist = level.see_equipment_dist;
  else {}

  _id_D8351990B067AA9B = maxdist * maxdist;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self)) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > _id_D8351990B067AA9B) {
      break;
    }

    currenttime = gettime();
    _id_56DDE920C84C7B04 = currenttime - _id_B4C04337A6A90C84;
    self.markequipmentstate.markingtime = self.markequipmentstate.markingtime + _id_56DDE920C84C7B04;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\cp\utility::isplayerads()) {
        _id_C626A360E6435920 = self.markequipmentstate.markedentindex;
        ent = self.markequipmentstate.markedents[_id_C626A360E6435920];

        if(isDefined(ent)) {
          ent filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(ent);
        }

        self.markequipmentstate.markingent filterinplayermarks(self.team);
        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self.markequipmentstate.markedents[_id_C626A360E6435920] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (_id_C626A360E6435920 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else {}

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    _id_B4C04337A6A90C84 = currenttime;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

unmarkafterduration(_id_BE331B5A39B1738A) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  wait(getdvarint("perk_mark_equipment_duration"));

  if(isDefined(_id_BE331B5A39B1738A) && isDefined(self))
    unmarkent(_id_BE331B5A39B1738A);
}

unmarkonownershipchange(_id_BE331B5A39B1738A) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());

  for(;;)
    wait 0.5;
}

outlinehelper_updateentityoutline(ent) {
  if(isDefined(ent)) {
    _id_8B1683C8EAD7B9BE = ent getentitynumber();
    outlinehelper_disableentityoutline(_id_8B1683C8EAD7B9BE);
    outlinehelper_enableentityoutline(ent);
  }
}

outlinehelper_enableentityoutline(ent) {
  if(!isDefined(ent)) {
    return;
  }
  _id_8B1683C8EAD7B9BE = ent getentitynumber();
  _id_913FE1549A1C5C96 = self.entityoutlines[_id_8B1683C8EAD7B9BE];

  if(isDefined(_id_913FE1549A1C5C96)) {
    return;
  }
  _id_7AA1FF687CFC30D1 = undefined;

  if(self entitymarkfilteredin(ent)) {
    _id_7AA1FF687CFC30D1 = spawnStruct();
    _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
    _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  }

  ismarked = self entitymarkfilteredin(ent);

  if(self entityhasmark("air_killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  } else if(self entityhasmark("killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  } else if(self entityhasmark("equipment", ent)) {
    if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover") {
      return;
    }
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_equipment";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  }

  if(isDefined(_id_7AA1FF687CFC30D1)) {
    _id_913FE1549A1C5C96 = spawnStruct();
    self.entityoutlines[_id_8B1683C8EAD7B9BE] = _id_913FE1549A1C5C96;
    _id_913FE1549A1C5C96.list = [];
    _id_913FE1549A1C5C96.ent = ent;
    _id_20D77D27621233DF = getchildoutlineents(ent);

    foreach(child in _id_20D77D27621233DF) {
      entoutlineid = scripts\cp\cp_outline_utility::outlineenableforplayer(child, self, _id_7AA1FF687CFC30D1.hudoutlineassetname, _id_7AA1FF687CFC30D1.prioritygroup);
      outline = spawnStruct();
      outline.ent = child;
      outline.id = entoutlineid;
      _id_0AD3B147E911F12F = child getentitynumber();
      _id_913FE1549A1C5C96.list[_id_0AD3B147E911F12F] = outline;
    }
  }
}

getchildoutlineents(ent) {
  if(!isDefined(ent))
    return [];

  if(!isDefined(ent.childoutlineents))
    return [ent];

  return ent.childoutlineents;
}

outlinehelper_verifydata(_id_7AA1FF687CFC30D1) {
  if(!isDefined(_id_7AA1FF687CFC30D1.getplayers))
    _id_7AA1FF687CFC30D1.getplayers = ::outlinehelper_getallplayers;

  if(!isDefined(_id_7AA1FF687CFC30D1.validplayer))
    _id_7AA1FF687CFC30D1.validplayer = ::outlinehelper_validplayer;

  if(!isDefined(_id_7AA1FF687CFC30D1.hudoutlineassetname))
    _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget";

  if(!isDefined(_id_7AA1FF687CFC30D1.prioritygroup))
    _id_7AA1FF687CFC30D1.prioritygroup = "perk";

  if(!isDefined(_id_7AA1FF687CFC30D1.waittime))
    _id_7AA1FF687CFC30D1.waittime = 0.1;
}

outlinehelper_getallplayers(ent, _id_7AA1FF687CFC30D1) {
  return level.players;
}

outlinehelper_validplayer(player) {
  return 1;
}

outlinehelper_disableentityoutline(entnum) {
  if(isDefined(entnum)) {
    _id_913FE1549A1C5C96 = self.entityoutlines[entnum];

    if(isDefined(_id_913FE1549A1C5C96)) {
      foreach(outline in _id_913FE1549A1C5C96.list)
      scripts\cp\cp_outline_utility::outlinedisable(outline.id, outline.ent);

      self.entityoutlines[entnum] = undefined;
    }
  }
}

setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

outlinekillstreaks_enablemarksafterprematch() {
  self endon("unsetOutlineKillstreak");
  self enableentitymarks("killstreak", 1000000);
  self enableentitymarks("air_killstreak", 1000000);
  self.perkoutlinekillstreaksset = 1;
}

unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("killstreak");
    self disableentitymarks("air_killstreak");
    self.perkoutlinekillstreaksset = undefined;
  }

  self notify("unsetOutlineKillstreak");
}

markedentities_removeentsbyindex(_id_1D2BE7531AAF82AF, _id_223829BBEFC81935) {
  _id_5877436CC451FA7D = [];

  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(isDefined(ent)) {
      entnum = ent getentitynumber();

      if(!scripts\engine\utility::array_contains(_id_223829BBEFC81935, entnum))
        _id_5877436CC451FA7D[_id_5877436CC451FA7D.size] = ent;
    }
  }

  return _id_5877436CC451FA7D;
}

markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  for(;;) {
    self waittill("marks_changed", _id_B56AC8B012F37095, _id_7B50CC9C94BE9505, _id_C5DDA6B7A37D4129);

    if(isDefined(_id_B56AC8B012F37095)) {
      foreach(_id_E0ABEAA6EF08E178 in _id_B56AC8B012F37095)
      outlinehelper_disableentityoutline(_id_E0ABEAA6EF08E178);

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = markedentities_removeentsbyindex(self.markequipmentstate.markedents, _id_B56AC8B012F37095);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size)
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
      }
    }

    if(isDefined(_id_7B50CC9C94BE9505)) {
      foreach(_id_4905D157180507C8 in _id_7B50CC9C94BE9505)
      outlinehelper_disableentityoutline(_id_4905D157180507C8);
    }

    if(isDefined(_id_C5DDA6B7A37D4129)) {
      foreach(_id_F445C1A8471869FE in _id_C5DDA6B7A37D4129)
      outlinehelper_enableentityoutline(_id_F445C1A8471869FE);
    }
  }
}

setblastshield() {
  set_perk("enemy_explosive_damage_reduction", 0.5);
}

unsetblastshield() {
  set_perk("enemy_explosive_damage_reduction", 1);
}

settracker() {
  thread runtrackkillstreakuse();
  thread run_track_enemy_patrollers();
}

unsettracker() {
  self notify("tracker_removed");
}

runtrackkillstreakuse() {
  self endon("death_or_disconnect");
  self endon("track_killstreak_end");

  for(;;) {
    if(scripts\cp\utility::isusingremote()) {
      waitframe();
      scripts\cp\utility::takeperk("specialty_tracker");

      while(scripts\cp\utility::isusingremote())
        waitframe();

      scripts\cp\utility::giveperk("specialty_tracker");
      break;
    }

    waitframe();
  }
}

run_track_enemy_patrollers() {
  self endon("death_or_disconnect");
  self endon("tracker_removed");
  _id_89640CA652887743 = cos(70);
  _id_820E590CB5620371 = 0;
  self.view_list = [];
  self.outlineids = [];
  _id_2AB4EB5F9BF4DD77 = 5000;

  for(;;) {
    enemy_list = level.agentarray;

    foreach(guy in enemy_list) {
      if(_id_820E590CB5620371 >= 20) {
        _id_820E590CB5620371 = 0;
        waitframe();
      }

      if(!isDefined(guy)) {
        continue;
      }
      _id_820E590CB5620371++;
      entnum = guy getentitynumber();
      _id_25AB57D46F5F99F9 = scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), guy.origin, _id_89640CA652887743);

      if(!_id_25AB57D46F5F99F9) {
        continue;
      }
      passed = sighttracepassed(self getEye(), guy getEye(), 0, undefined);

      if(!passed) {
        if(isDefined(self.view_list[entnum])) {
          _id_4FB72B720667636B = gettime();
          _id_77C5B5DD30FC2909 = _id_4FB72B720667636B - _id_2AB4EB5F9BF4DD77;

          if(self.view_list[entnum] < _id_77C5B5DD30FC2909) {} else {
            guy add_outline(entnum, self);
            guy thread untrack_enemy(self, 5);
          }
        } else {}

        continue;
      }

      _id_4FB72B720667636B = gettime();
      self.view_list[entnum] = _id_4FB72B720667636B;
      guy remove_outline(entnum, self);
    }

    _id_820E590CB5620371 = 0;
    waitframe();
  }
}

_id_D0EB3583CF0CDF66(_id_B76712BDE7C371E4) {
  self endon("death_or_disconnect");
  self notify("tracker_removed");
  self endon("tracker_removed");
  _id_89640CA652887743 = cos(70);
  _id_820E590CB5620371 = 0;
  self.view_list = [];
  self.outlineids = [];
  _id_2AB4EB5F9BF4DD77 = 5000;

  for(;;) {
    enemy_list = level.agentarray;

    foreach(guy in enemy_list) {
      if(_id_820E590CB5620371 >= 20) {
        _id_820E590CB5620371 = 0;
        waitframe();
      }

      if(!isDefined(guy)) {
        continue;
      }
      _id_820E590CB5620371++;
      entnum = guy getentitynumber();
      target = guy getEye();

      if(!isDefined(target))
        target = guy.origin;

      _id_25AB57D46F5F99F9 = scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), target, _id_89640CA652887743);

      if(!_id_25AB57D46F5F99F9) {
        continue;
      }
      passed = sighttracepassed(self getEye(), guy getEye(), 0, undefined);

      if(istrue(_id_B76712BDE7C371E4) || (!passed || istrue(self._id_2332678633FE1728))) {
        if(istrue(guy.reconmarked))
          guy add_outline(entnum, self);

        continue;
      }

      if(istrue(guy.reconmarked))
        guy remove_outline(entnum, self);
    }

    _id_820E590CB5620371 = 0;
    waitframe();
  }
}

add_outline(entnum, player) {
  if(!isDefined(player.outlineids[entnum]))
    player.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforplayer(self, player, "snapshotgrenade", "equipment");
}

_id_BC0B60676EF3D606(_id_D2769810C4BAD341) {
  self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]](_id_D2769810C4BAD341);
}

untrack_enemy(player, timer) {
  entnum = self getentitynumber();

  if(isDefined(timer))
    wait(timer);

  if(isDefined(self.reconmarked))
    self.reconmarked = undefined;

  remove_outline(entnum, player);
}

remove_outline(entnum, player) {
  outlineid = player.outlineids[entnum];

  if(isDefined(outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(outlineid, self);
    player.outlineids[entnum] = undefined;
  }
}

setviewkickoverride() {
  self.overrideviewkickscale = 0.5;
  self.overrideviewkickscaledmr = 0.5;
  self.overrideviewkickscalesniper = 0.5;
  self.overrideviewkickscalepistol = 0.5;
  _id_74502A9E0EF1F19C::updateviewkickscale();
}

unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.overrideviewkickscaledmr = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  _id_74502A9E0EF1F19C::updateviewkickscale();
}

set_heavy_hitter() {
  self.perk_data["melee_scalar"] = 2;
}

unset_heavy_hitter() {
  self.perk_data["melee_scalar"] = 1;
}

give_tune_up() {
  set_perk("super_fill_scalar", 1.3);
}

take_tune_up() {
  set_perk("super_fill_scalar", 1);
}

give_restock() {
  thread recharge_lethals_over_time(60);
}

take_restock() {
  self notify("take_restock");
}

recharge_lethals_over_time(timer) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  thread reset_restock_flag();
  thread reset_recharge_after_respawn();

  for(;;) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(!isDefined(grenade.equipmentref)) {
      return;
    }
    _id_D690EF8FDB341E60 = _id_7EF95BBA57DC4B82::getcurrentequipment("primary");

    if(isDefined(_id_D690EF8FDB341E60) && grenade.equipmentref == _id_D690EF8FDB341E60)
      thread _id_B705CD6E9764D5B5(timer, "primary");

    _id_DDCA460EA9F6D6C5 = _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");

    if(isDefined(_id_DDCA460EA9F6D6C5) && grenade.equipmentref == _id_DDCA460EA9F6D6C5)
      thread _id_B705CD6E9764D5B5(timer, "secondary");
  }
}

reset_restock_flag() {
  level endon("game_ended");
  self waittill("take_restock");
  self.waiting_for_tactical_restock = undefined;
  self.waiting_for_lethal_restock = undefined;
  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar("ui_lethal_recharge_progress", 0);
  self setclientomnvar("ui_tactical_recharge_progress", 0);
}

reset_recharge_after_respawn() {
  level endon("game_ended");
  self endon("take_restock");
  timer = 60;
  self waittill("landed_after_respawn");
  _id_15DC79D0E74115B6 = _id_7EF95BBA57DC4B82::getcurrentequipment("primary");

  if(isDefined(_id_15DC79D0E74115B6) && _id_7EF95BBA57DC4B82::getequipmentammo(_id_15DC79D0E74115B6) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(_id_15DC79D0E74115B6))
    thread _id_B705CD6E9764D5B5(timer, "primary");

  _id_BBFD67040E7C52F6 = _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");

  if(_id_7EF95BBA57DC4B82::getequipmentammo(_id_BBFD67040E7C52F6) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(_id_BBFD67040E7C52F6))
    thread _id_B705CD6E9764D5B5(timer, "secondary");
}

_id_B705CD6E9764D5B5(timer, slot) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(slot == "primary" && istrue(self.waiting_for_lethal_restock)) {
    return;
  }
  if(slot == "secondary" && istrue(self.waiting_for_tactical_restock)) {
    return;
  }
  if(slot == "primary") {
    thread stop_restock_recharge("ui_lethal_recharge_progress", slot);
    self.waiting_for_lethal_restock = 1;
    update_restock_ui("ui_lethal_recharge_progress", timer, 0);
    self.waiting_for_lethal_restock = undefined;
  } else {
    thread stop_restock_recharge("ui_tactical_recharge_progress", slot);
    self.waiting_for_tactical_restock = 1;
    update_restock_ui("ui_tactical_recharge_progress", timer, 0);
    self.waiting_for_tactical_restock = undefined;
  }

  equipmentref = _id_7EF95BBA57DC4B82::getcurrentequipment(slot);
  _id_7EF95BBA57DC4B82::incrementequipmentammo(equipmentref);

  if(_id_7EF95BBA57DC4B82::getequipmentammo(equipmentref) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipmentref))
    thread _id_B705CD6E9764D5B5(timer, slot);
  else
    self notify("restock_done");
}

update_restock_ui(omnvar, timer, slot) {
  self setclientomnvar("ui_recharge_notify", -1);
  start_time = gettime();
  end_time = start_time + timer * 1000;
  _id_4FB72B720667636B = gettime();

  while(_id_4FB72B720667636B < end_time) {
    while(istrue(self.inlaststand)) {
      self setclientomnvar("ui_recharge_notify", -1);
      self setclientomnvar(omnvar, 0);
      waitframe();
    }

    _id_4FB72B720667636B = gettime();
    progress = (_id_4FB72B720667636B - start_time) / (end_time - start_time);
    self setclientomnvar(omnvar, progress);
    wait 0.1;
  }

  self setclientomnvar("ui_recharge_notify", slot);
  self setclientomnvar(omnvar, 0);
}

stop_restock_recharge(omnvar, slot) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");
  equipment = _id_7EF95BBA57DC4B82::getcurrentequipment(slot);

  while(istrue(self.inlaststand) || _id_7EF95BBA57DC4B82::getequipmentammo(equipment) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipment))
    waitframe();

  self notify("stop_restock_recharge");

  if(slot == "primary")
    self.waiting_for_lethal_restock = undefined;
  else
    self.waiting_for_tactical_restock = undefined;

  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar(omnvar, 0);
}

give_amped() {
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
}

take_amped() {}

give_shrapnel() {}

take_shrapnel() {}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;

      if(isDefined(level.move_speed_scale))
        self[[level.move_speed_scale]]();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(_id_51438B11657961CC = 0; _id_51438B11657961CC < 0.08; _id_51438B11657961CC = _id_51438B11657961CC + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;

    if(isDefined(level.move_speed_scale))
      self[[level.move_speed_scale]]();

    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

unsetmomentum() {
  self notify("momentum_unset");
}

watchcombatspeedscaler() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self.pistolcombatspeedscalar = 1.0;
  self.aliensnarespeedscalar = 1.0;
  self.aliensnarecount = 0;
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();

  for(;;) {
    self waittill("weapon_change", objweapon);
    currentweapon = self getcurrentweapon();
    baseweapon = scripts\cp\utility::getrawbaseweaponname(currentweapon);

    if(isDefined(baseweapon)) {
      if(baseweapon == "nrg" || baseweapon == "zmagnum" || baseweapon == "zg18" || baseweapon == "emc")
        self.pistolcombatspeedscalar = 1.1;
      else
        self.pistolcombatspeedscalar = 1.0;

      wait 0.05;
      updatecombatspeedscalar();
    }

    wait 0.05;
  }
}

updatecombatspeedscalar() {
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();
}

getcombatspeedscalar() {
  return self.pistolcombatspeedscalar * self.aliensnarespeedscalar;
}

removeperk(perkname) {
  scripts\cp\utility::_unsetperk(perkname);
  scripts\cp\utility::_unsetextraperks(perkname);
}

setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regeneration");
}

unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regeneration");
}