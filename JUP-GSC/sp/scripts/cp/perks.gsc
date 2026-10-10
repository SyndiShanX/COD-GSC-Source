/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\perks.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\stealth\utility;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace perks;

function initperks() {
  init_core_mp_perks();
  function_fe0d47259cb779c3();
}

function init_each_perk() {
  if(!isDefined(level.health_scalar)) {
    level.health_scalar = 1;
  }

  level.extra_charge_func = &should_give_extra_charge;
  self.perk_data = [];
  self.perk_data["max_health"] = 100 * level.health_scalar;
  self.perk_data["regen_time_scalar"] = 1;
  self.perk_data["melee_scalar"] = 1;
  self.perk_data["melee_stun_radius"] = 0;
  self.perk_data["revive_time_scalar"] = 1;
  self.perk_data["move_speed_scalar"] = 1;
  self.perk_data["revive_damage_scalar"] = 1;
  self.perk_data["explosive_damage_scalar"] = 1;
  self.perk_data["offhand_count"] = 1;
  self.perk_data["launcher_ammo"] = 4;
  self.perk_data["friendly_explosive_damage_reduction"] = 1;
  self.perk_data["enemy_explosive_damage_reduction"] = 1;
  self.perk_data["bullet_damage_scalar"] = 1;
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
  thread scripts\cp\agent_damage::track_consecutive_kills();
  init_class_changed_values();
}

function init_class_changed_values() {
  self setaimspreadmovementscale(1);
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

function get_perk(string_key) {
  if(isDefined(self.perk_data[string_key])) {
    return self.perk_data[string_key];
  }
}

function set_perk(string_key, value) {
  if(isDefined(self.perk_data[string_key])) {
    self.perk_data[string_key] = value;
  }
}

function blank() {}

function medic_speed_buff() {
  self.perk_data["move_speed_scalar"] = 1.12;
  self.movespeedscaler = 1.12;
  thread scripts\cp\loadout::updatemovespeedscale();
}

function medic_health_regen(dist_sqr) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  self endon("giving_class");
  var_55edbc76cb692e0a = dist_sqr > 0;

  while(true) {
    foreach(player in level.players) {
      if(player scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(player.medic_regeneration)) {
        if(var_55edbc76cb692e0a && distancesquared(self.origin, player.origin) > dist_sqr) {}
      }
    }

    wait 1;
  }
}

function medic_regenerate_health_once() {
  self endon("death");
  self endon("disconnect");
  self.medic_regeneration = 1;
  wait 1;
  self.health = int(min(self.maxhealth, self.health + 5));
  self.medic_regeneration = undefined;
}

function should_give_extra_charge(equipment) {
  if(isDefined(equipment)) {
    switch (equipment) {
      case #"hash_142a787e36d7d7ce":
      case #"hash_2354208d9af64220":
      case #"hash_3995658e01f4fac1":
      case #"hash_4320d77f90725183":
      case #"hash_4f62b5fa00ecd075":
      case #"hash_5fca4943a78ace9c":
      case #"hash_70200b060d09d860":
      case #"hash_8c7819f0a3fbd1e0":
      case #"hash_9ba0a6ff6081954e":
      case #"hash_de4641ddbc44a7ba":
      case #"hash_e156752cb79526e8":
      case #"hash_f0907f858c134cb4":
      case #"hash_fb6b649176cec75d":
        return self.perk_data["offhand_count"];
      default:
        break;
    }
  }

  return undefined;
}

function reload_on_kill() {
  while(true) {
    self waittill("kill_score");
    curweap = self getcurrentprimaryweapon();
    total_ammo = self getammocount(curweap);
    clip_size = int(min(total_ammo, weaponclipsize(curweap)));
    remaining_stock = total_ammo - clip_size;
    self setweaponammoclip(curweap, clip_size);
    self setweaponammostock(curweap, remaining_stock);
    wait 0.1;
  }
}

function reduce_recoil() {
  self.old_view_kick = self getviewkickscale();
  self.overchargeviewkickscale = 0;
  self.old_recoil_scale = self player_getrecoilscale();
  self player_recoilscaleon(0);
  self.onhelisniper = 1;
  scripts\cp\weapon::updateviewkickscale();
}

function remove_reduce_recoil() {
  if(isDefined(self.old_recoil_scale)) {
    if(self.old_recoil_scale != -1) {
      self player_recoilscaleon(self.old_recoil_scale);
    } else {
      self player_recoilscaleon(100);
    }

    self.old_recoil_scale = undefined;
  }

  self.overchargeviewkickscale = undefined;
  self.onhelisniper = undefined;
  scripts\cp\weapon::updateviewkickscale();
}

function reduce_bullet_spread() {
  giveperk("specialty_bulletaccuracy");
  self setaimspreadmovementscale(0.1);
}

function run_deadeye_charge_watcher() {
  self endon("disconnect");
  self endon("end_deadeye_charge_watcher");
  self endon("giving_class");
  self.deadeye_charge = undefined;
  var_f45f84783a1cc4d2 = undefined;
  var_bc4b686e2f1d19e2 = undefined;
  var_5c36fc93f90947f5 = 500;

  while(true) {
    if(self adsButtonPressed()) {
      cur_time = gettime();

      if(!isDefined(var_f45f84783a1cc4d2)) {
        var_f45f84783a1cc4d2 = cur_time;
        var_bc4b686e2f1d19e2 = cur_time + var_5c36fc93f90947f5;
      } else if(cur_time > var_bc4b686e2f1d19e2) {
        if(istrue(self.deadeye_charge)) {}

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var_f45f84783a1cc4d2 = undefined;
      var_bc4b686e2f1d19e2 = undefined;
    }

    wait 0.05;
  }
}

function init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.scriptperks["specialty_remote_defuse"] = 1;
  level.perksetfuncs["specialty_momentum"] = &setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = &unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = &setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = &unsetfreefall;
  level.perksetfuncs["specialty_remote_defuse"] = &setremotedefuse;
  level.perkunsetfuncs["specialty_remote_defuse"] = &unsetremotedefuse;
  level.scriptperks["specialty_hustle"] = 1;
  level.extraperkmap["specialty_hustle"] = ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement", "specialty_stalker", "specialty_quickdraw", "specialty_fastreload", "specialty_quickswap"];
  level.scriptperks["specialty_bulletdamage"] = 1;
  level.extraperkmap["specialty_bulletdamage"] = ["specialty_overcharge"];
  level.perksetfuncs["specialty_overcharge"] = &setovercharge;
  level.perkunsetfuncs["specialty_overcharge"] = &unsetovercharge;
  registerscriptperk("specialty_restock", undefined, undefined, ["specialty_recharge_equipment"]);
  registerscriptperk("specialty_recharge_equipment", &give_restock, &take_restock);
  registerscriptperk("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade"]);
  registerscriptperk("specialty_improved_field_upgrades");
  registerscriptperk("specialty_faster_field_upgrade", &give_tune_up, &take_tune_up);
  registerscriptperk("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective"]);
  registerscriptperk("specialty_reduce_regen_delay_on_kill", &setreduceregendelayonkills, &unsetreduceregendelayonkills);
  registerscriptperk("specialty_reduce_regen_delay_on_objective", &setreduceregendelayonobjective, &unsetreduceregendelayonobjective);
  registerscriptperk("specialty_hardline", &sethardline, &unsethardline);
  registerscriptperk("specialty_extra_tactical", &setextratacticalequipment, &function_c6df31f2ee8fe243);
  registerscriptperk("specialty_extra_deadly", &setextraprimaryequipment, &function_3ba1ba85aad48a42);
  registerscriptperk("specialty_extra_equipment", undefined, undefined, ["specialty_extra_deadly", "specialty_extra_tactical"]);
  registerscriptperk("specialty_warhead", &give_amped, &take_amped, ["specialty_fastreload_launchers"]);
  registerscriptperk("specialty_fastreload_launchers", &setfastreloadlaunchers, &unsetfastreloadlaunchers);
  registerscriptperk("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_twoprimaries", &setoverkill, &unsetoverkill, []);
  registerscriptperk("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak"]);
  registerscriptperk("specialty_killstreak_to_scorestreak", &setkillstreaktoscorestreak, &unsetkillstreaktoscorestreak);
  registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  registerscriptperk("specialty_sixth_sense", &function_378625a93d79fdc2, &function_1a4d7090fc81e97);
  registerscriptperk("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  registerscriptperk("specialty_shrapnel");
  registerscriptperk("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  registerscriptperk("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_silentkill", "specialty_sixth_sense_immune", "specialty_heartbreaker"]);
  registerscriptperk("specialty_ghost", &setghost, &unsetghost, ["specialty_gpsjammer"]);
  registerscriptperk("specialty_silentkill");
  registerscriptperk("specialty_sixth_sense_immune");
  registerscriptperk("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist"]);
  registerscriptperk("specialty_stun_resistance", &setstunresistance, &unsetstunresistance, ["specialty_hard_shell"]);
  registerscriptperk("specialty_emp_resist");
  registerscriptperk("specialty_hard_shell", &sethardshell, &unsethardshell);
  registerscriptperk("specialty_gas_grenade_resist", &setgasgrenaderesist, &unsetgasgrenaderesist);
  registerscriptperk("specialty_scrambler_resist");
  registerscriptperk("specialty_covert_ops", undefined, undefined, ["specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_snapshot_immunity"]);
  registercodeperkinfo("specialty_blindeye", &setblindeye, &unsetblindeye);
  registerscriptperk("specialty_noscopeoutline", &setnoscopeoutline, &unsetnoscopeoutline);
  registerscriptperk("specialty_snapshot_immunity");
  registerscriptperk("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks"]);
  registerscriptperk("specialty_chain_killstreaks");
  registerscriptperk("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment"]);
  registerscriptperk("specialty_engineer", &setengineer, &unsetengineer, ["specialty_outlinekillstreaks"]);
  registerscriptperk("specialty_markequipment", &setmarkequipment, &unsetmarkequipment);
  registerscriptperk("specialty_outlinekillstreaks", &setoutlinekillstreaks, &unsetoutlinekillstreaks);
  level thread set_mark_distances();
  registerscriptperk("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);
  registerscriptperk("specialty_blastshield", &setblastshield, &unsetblastshield);
  registerscriptperk("specialty_hack");
  registerscriptperk("specialty_shrapnel_resist");
  registerscriptperk("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report"]);
  registerscriptperk("specialty_tracker", &settracker, &unsettracker, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_kill_report");
  registercodeperkinfo("specialty_snakecam");
  registerscriptperk("specialty_bulletsuppress", &function_7cfa6000210cbd68, &function_f1a813fe1b8a2275);
  registerscriptperk("specialty_armorpiercingks");
  registerscriptperk("specialty_glintxsml");
  registerscriptperk("specialty_glintsml");
  registerscriptperk("specialty_glintmed");
  registerscriptperk("specialty_glintlrg");
  registerscriptperk("specialty_glintxlrg");
  registerscriptperk("specialty_ammo_disabling");
  registerscriptperk("specialty_viewkickoverride", &setviewkickoverride, &unsetviewkickoverride);
  registerscriptperk("specialty_delayhealing");
  registerscriptperk("specialty_hardmelee", &set_heavy_hitter, &unset_heavy_hitter);
  registerscriptperk("specialty_block_health_regen", &setblockhealthregen, &unsetblockhealthregen);
  registercodeperkinfo("specialty_spygame");
  registerscriptperk("specialty_swimming", undefined, undefined, ["specialty_spygame", "specialty_coldblooded"]);
  registerscriptperk("specialty_pitcher", &setpitcher, &unsetpitcher);
  registerscriptperk("specialty_flashlight");
  registerscriptperk("specialty_wounding");
  registerscriptperk("specialty_incendiary");
  registerscriptperk("specialty_smags");
  registerscriptperk("specialty_akimbo");
  registerscriptperk("specialty_explosivebullet");
  registerscriptperk("specialty_gunmelee");
  registerscriptperk("specialty_talkinggun_test1", &scripts\cp_mp\talking_gun::function_96f59fefd781e47, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_test2", &scripts\cp_mp\talking_gun::function_96f5afefd78207a, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_test3", &scripts\cp_mp\talking_gun::function_96f5bfefd7822ad, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_test4", &scripts\cp_mp\talking_gun::function_96f54fefd781348, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_announcer", &scripts\cp_mp\talking_gun::function_fc6e0b02abb995cb, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_robot", &scripts\cp_mp\talking_gun::function_73e4ae4f932e9f30, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_blackcell", &scripts\cp_mp\talking_gun::function_cc0fddfe26b772a7, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
  registerscriptperk("specialty_talkinggun_npc", &scripts\cp_mp\talking_gun::function_fc09644394bf843f, &scripts\cp_mp\talking_gun::function_da3d9f34d24ac85a);
}

function function_fe0d47259cb779c3() {
  registerscriptperk("specialty_fast_health_regen");
  registerscriptperk("specialty_quick_revive");
  registerscriptperk("specialty_extra_armor", &function_221c99519fbcdcea, &function_aadef05e93ad3aa3);
  registerscriptperk("specialty_extra_weapon");
  registerscriptperk("specialty_armor_satchel");
  registerscriptperk("specialty_increased_armor_health", &function_e12e572d8ce0f156, &function_91d0e484a126db5f);
  registerscriptperk("specialty_elasomer_pads", &function_cc2cf1db71343d8f, &function_5ab8f9c4d813c44a);
}

function function_7cfa6000210cbd68() {
  self setclientomnvar("ui_overcharge", 2);
}

function function_f1a813fe1b8a2275() {
  self setclientomnvar("ui_overcharge", 0);
}

function function_221c99519fbcdcea() {
  scripts\cp_mp\armor::initarmor(1);
}

function function_aadef05e93ad3aa3() {
  scripts\cp_mp\armor::initarmor(1);
}

function setextratacticalequipment() {
  self endon("disconnect");
  self endon("setExtraTacticalEquipment");
  level endon("game_ended");

  if(istrue(self.gettingloadout)) {
    self waittill("loadout_given");
  }

  ref = scripts\cp_mp\equipment::getcurrentequipment("secondary");

  if(isDefined(ref) && ref != "none") {
    scripts\cp_mp\equipment::incrementequipmentammo(ref);
  }
}

function function_c6df31f2ee8fe243() {
  self notify("setExtraTacticalEquipment");
}

function setextraprimaryequipment() {
  self endon("disconnect");
  self endon("setExtraPrimaryEquipment");
  level endon("game_ended");

  if(istrue(self.gettingloadout)) {
    self waittill("loadout_given");
  }

  ref = scripts\cp_mp\equipment::getcurrentequipment("primary");

  if(isDefined(ref) && ref != "none") {
    scripts\cp_mp\equipment::incrementequipmentammo(ref);
  }
}

function function_3ba1ba85aad48a42() {
  self notify("setExtraPrimaryEquipment");
}

function function_e12e572d8ce0f156() {
  self.increased_armor_health = 1;
  scripts\cp_mp\armor::initarmor();
  self.spawnarmor = 450;
}

function function_91d0e484a126db5f() {
  self.increased_armor_health = undefined;
}

function setpitcher() {
  thread setpitcherinternal();
}

function unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("unsetPitcher");
}

function setpitcherinternal() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.5);
    self waittill("grenade_pullback", objweapon);
    grenadename = objweapon.basename;

    if(grenadename == "airdrop_marker_mp" || grenadename == "deployable_vest_marker_mp" || grenadename == "deployable_weapon_crate_marker_mp") {
      self setgrenadethrowscale(1);
    }

    self waittill("grenade_fire", grenade, objweapon);
  }
}

function registerscriptperk(perkname, setfunc, unsetfunc, extraperkmap) {
  registerperk(perkname, 1, setfunc, unsetfunc, extraperkmap);
}

function registercodeperkinfo(perkname, setfunc, unsetfunc, extraperkmap) {
  registerperk(perkname, 0, setfunc, unsetfunc, extraperkmap);
}

function registerperk(perkname, var_9aa715f8120f5692, setfunc, unsetfunc, extraperkmap) {
  assert(isDefined(perkname));
  assert(!isDefined(level.scriptperks[perkname]), "Cannot register two perks to the name: " + perkname);

  if(istrue(var_9aa715f8120f5692)) {
    level.scriptperks[perkname] = 1;
  }

  if(isDefined(setfunc)) {
    assert(isfunction(setfunc));
    level.perksetfuncs[perkname] = setfunc;
  }

  if(isDefined(unsetfunc)) {
    assert(isfunction(unsetfunc));
    level.perkunsetfuncs[perkname] = unsetfunc;
  }

  if(isDefined(extraperkmap)) {
    assert(isarray(extraperkmap));
    level.extraperkmap[perkname] = extraperkmap;
  }
}

function setovercharge() {
  self setclientomnvar("ui_overcharge", 1);
}

function unsetovercharge() {
  self setclientomnvar("ui_overcharge", 0);
}

function setfreefall() {}

function unsetfreefall() {}

function setremotedefuse() {}

function unsetremotedefuse() {}

function sethardshell() {
  self.shellshockreduction = 0.25;
}

function unsethardshell() {
  self.shellshockreduction = 0;
}

function setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
}

function unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
}

function setreduceregendelayonkills() {}

function unsetreduceregendelayonkills() {}

function setreduceregendelayonobjective() {}

function unsetreduceregendelayonobjective() {}

function sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");

  if(is_specops_gametype()) {
    return;
  }

  thread run_kill_watcher();
  self.hardlineactive["assists"] = 0;
}

function unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

function run_kill_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("perk_end_hardline");
  var_6d85d0102fd52796 = 7;

  while(true) {
    if(isDefined(self.consecutive_kills) && self.consecutive_kills > var_6d85d0102fd52796) {
      give_random_munition();
    }

    waitframe();
  }
}

function give_random_munition() {
  types = undefined;
  types = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  loot_type = random(types);
  scripts\cp\loot_system::give_munition(loot_type, self);
  wait 10;
}

function setfastreloadlaunchers() {}

function unsetfastreloadlaunchers() {}

function setoverkill() {}

function unsetoverkill() {}

function setkillstreaktoscorestreak() {}

function unsetkillstreaktoscorestreak() {}

function setghost() {
  self.perk_data["stealth_dist_scalar"] = 0.5;
}

function unsetghost() {
  self.perk_data["stealth_dist_scalar"] = 1;
}

function setstunresistance(var_49e6ba16eaed299c) {
  if(!isDefined(var_49e6ba16eaed299c)) {
    var_49e6ba16eaed299c = 4;
  }

  var_49e6ba16eaed299c = int(var_49e6ba16eaed299c);

  if(var_49e6ba16eaed299c == 10) {
    self.stunscalar = 0;
    return;
  }

  self.stunscalar = var_49e6ba16eaed299c / 10;
}

function unsetstunresistance() {
  self.stunscalar = 1;
}

function setblindeye() {}

function unsetblindeye() {}

function setnoscopeoutline() {}

function unsetnoscopeoutline() {}

function setengineer() {
  thread engineer_enablemarksafterprematch();
}

function engineer_enablemarksafterprematch() {
  self endon("unsetEngineer");
  self enableentitymarks("equipment", 1000000);
  self.perkengineerset = 1;
  thread markedentities_think();
}

function unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("equipment");
    self.perkengineerset = undefined;
  }

  self notify("unsetEngineer");
}

function allow_br_loot_to_br_marked() {
  if(!isDefined(level.teamdata)) {
    level.teamdata = [];
  }

  if(!isDefined(level.teamdata["allies"])) {
    level.teamdata["allies"] = [];
  }

  if(!isDefined(level.teamdata["allies"]["players"])) {
    level.teamdata["allies"]["players"] = level.players;
  }

  var_792740c4c87cf9fa = getentitylessscriptablearray(undefined, undefined, self.origin, 2000);

  foreach(thing in var_792740c4c87cf9fa) {
    if(issubstr(thing.type, "brloot_munition")) {
      thing.fake_model = spawn("script_model", thing.origin);
      thing.fake_model.angles = thing.angles;
      thing.fake_model setModel("container_ammo_box_01_nophysics_cp");
      thing.fake_model enableplayermarks("equipment");
      scripts\cp\cp_outline_utility::outlineenableforplayer(thing.fake_model, self, "spotter_notarget_equipment", "perk");
    }

    waitframe();
  }
}

function make_sure_loot_is_visible() {
  var_7507f409fee2b657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(name in var_7507f409fee2b657) {
    var_792740c4c87cf9fa = getentitylessscriptablearray(undefined, undefined, undefined, undefined, name);
    count = 0;

    foreach(br_loot in var_792740c4c87cf9fa) {
      br_loot setscriptablepartstate(name, "visible");
      count++;

      if(count % 20) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function make_outline_ents() {
  var_58a11d31a3c59e82 = 10;
  level.outline_ents = [];
  level.outline_ent_index = [];

  for(i = 0; i < var_58a11d31a3c59e82; i++) {
    level.outline_ents[i] = spawn("script_model", (0, 0, 0));
    level.outline_ents[i].angles = (0, 0, 0);
    level.outline_ents[i] setModel("container_ammo_box_01_nophysics_cp");
    level.outline_ents[i] enableplayermarks("equipment");
  }

  thread monitor_outline_ents();
}

function monitor_outline_ents() {
  level endon("game_ended");

  while(true) {
    if(_hasperk("specialty_engineer")) {
      get_closest_munitions();
    }

    wait 0.1;
  }
}

function get_closest_munitions() {
  var_b69312781edc9ea6 = 1000;
  var_58a11d31a3c59e82 = 10;
  var_7507f409fee2b657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];
  var_1d88cbbb14926330 = [];

  foreach(name in var_7507f409fee2b657) {
    var_792740c4c87cf9fa = getentitylessscriptablearray(undefined, undefined, self.origin, var_b69312781edc9ea6, name);

    foreach(br_loot in var_792740c4c87cf9fa) {
      var_1d88cbbb14926330[var_1d88cbbb14926330.size] = br_loot;
    }
  }

  var_1d88cbbb14926330 = sortbydistance(var_1d88cbbb14926330, self.origin);
  var_93dff4684377d4c0 = level.outline_ents;
  skip_list = [];
  new_list = [];

  for(i = 0; i < var_1d88cbbb14926330.size; i++) {
    if(!isDefined(level.outline_ent_index[var_1d88cbbb14926330[i].index])) {
      new_list[new_list.size] = var_1d88cbbb14926330[i];
    }
  }

  if(new_list.size > 0) {
    outline_ent_index = 0;

    for(i = 0; i < min(new_list.size, var_58a11d31a3c59e82); i++) {
      for(j = 0; j < level.outline_ents.size; j++) {
        if(isDefined(skip_list[j])) {
          continue;
        }

        if(isDefined(level.outline_ents[j])) {
          level.outline_ents[j] dontinterpolate();
        }

        level.outline_ents[j].origin = new_list[i].origin;
        level.outline_ents[j].angles = new_list[i].angles;
        level.outline_ents[j].index = new_list[i].index;
        level.outline_ent_index[level.outline_ents[j].index] = undefined;
        level.outline_ent_index[new_list[i].index] = level.outline_ents[j];
        unmarkent(level.outline_ents[j]);
        skip_list[j] = new_list[i];
        break;
      }
    }
  }
}

function unmarkent(markedent) {
  markedent filterinplayermarks(undefined);
  self.markequipmentstate.markedents = array_remove(self.markequipmentstate.markedents, markedent);
  markedent notify("unmarkEnt_" + self getentitynumber());
}

function setmarkequipment() {
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

function unsetmarkequipment() {
  if(isDefined(self.markequipmentstate)) {
    foreach(ent in self.markequipmentstate.markedents) {
      if(isDefined(ent)) {
        unmarkent(ent);
      }
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("mark_equip_ended");
}

function markequipment_monitorlook() {
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

  while(true) {
    self waittill("marks_target_changed", ent);
    startmarking = isDefined(ent) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = ent;
    self.markequipmentstate.markingtime = 0;

    if(startmarking) {
      thread markequipment_updatestate();
    }
  }
}

function set_mark_distances() {
  level.see_air_killstreak_dist = 6000;
  level.see_killstreak_dist = 1500;
  level.see_equipment_dist = 1000;
}

function markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  lasttime = gettime();
  maxdist = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent)) {
    maxdist = level.see_air_killstreak_dist;
  } else if(self entityhasmark("killstreak", self.markequipmentstate.markingent)) {
    maxdist = level.see_killstreak_dist;
  } else if(self entityhasmark("equipment", self.markequipmentstate.markingent)) {
    maxdist = level.see_equipment_dist;
  } else {
    assert(0, "Marking Ent did not belong to one of these mark groups. Are we not taking one into account?");
  }

  maxdistsqrd = maxdist * maxdist;

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

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > maxdistsqrd) {
      break;
    }

    currenttime = gettime();
    deltatime = currenttime - lasttime;
    self.markequipmentstate.markingtime += deltatime;

    if(!array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(isplayerads()) {
        markindex = self.markequipmentstate.markedentindex;
        ent = self.markequipmentstate.markedents[markindex];

        if(isDefined(ent)) {
          ent filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(ent);
        }

        self.markequipmentstate.markingent filterinplayermarks(self.team);
        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self.markequipmentstate.markedents[markindex] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (markindex + 1) % 999;

        if(!array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        }

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    lasttime = currenttime;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

function unmarkafterduration(markedent) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  wait getdvarint(@ "hash_6a381b8385734e4e");

  if(isDefined(markedent) && isDefined(self)) {
    unmarkent(markedent);
  }
}

function unmarkonownershipchange(markedent) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());

  while(true) {
    wait 0.5;
  }
}

function outlinehelper_updateentityoutline(ent) {
  if(isDefined(ent)) {
    entitynum = ent getentitynumber();
    outlinehelper_disableentityoutline(entitynum);
    outlinehelper_enableentityoutline(ent);
  }
}

function outlinehelper_enableentityoutline(ent) {
  if(!isDefined(ent)) {
    return;
  }

  entitynum = ent getentitynumber();
  entitydata = self.entityoutlines[entitynum];

  if(isDefined(entitydata)) {
    return;
  }

  outlinedata = undefined;

  if(self entitymarkfilteredin(ent)) {
    outlinedata = spawnStruct();
    outlinedata.prioritygroup = "perk_superior";
    outlinedata.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(outlinedata);
  }

  ismarked = self entitymarkfilteredin(ent);

  if(self entityhasmark("air_killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }

    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(outlinedata);
  } else if(self entityhasmark("killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }

    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(outlinedata);
  } else if(self entityhasmark("equipment", ent)) {
    if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover") {
      return;
    }

    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_equipment";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(outlinedata);
  }

  if(isDefined(outlinedata)) {
    entitydata = spawnStruct();
    self.entityoutlines[entitynum] = entitydata;
    entitydata.list = [];
    entitydata.ent = ent;
    childents = getchildoutlineents(ent);

    foreach(child in childents) {
      entoutlineid = scripts\cp\cp_outline_utility::outlineenableforplayer(child, self, outlinedata.hudoutlineassetname, outlinedata.prioritygroup);
      outline = spawnStruct();
      outline.ent = child;
      outline.id = entoutlineid;
      childnum = child getentitynumber();
      entitydata.list[childnum] = outline;
    }
  }
}

function getchildoutlineents(ent) {
  if(!isDefined(ent)) {
    return [];
  }

  if(!isDefined(ent.childoutlineents)) {
    return [ent];
  }

  return ent.childoutlineents;
}

function outlinehelper_verifydata(outlinedata) {
  assert(isDefined(outlinedata));

  if(!isDefined(outlinedata.getplayers)) {
    outlinedata.getplayers = &outlinehelper_getallplayers;
  }

  if(!isDefined(outlinedata.validplayer)) {
    outlinedata.validplayer = &outlinehelper_validplayer;
  }

  if(!isDefined(outlinedata.hudoutlineassetname)) {
    outlinedata.hudoutlineassetname = "spotter_notarget";
  }

  if(!isDefined(outlinedata.prioritygroup)) {
    outlinedata.prioritygroup = "perk";
  }

  if(!isDefined(outlinedata.waittime)) {
    outlinedata.waittime = 0.1;
  }
}

function outlinehelper_getallplayers(ent, outlinedata) {
  return level.players;
}

function outlinehelper_validplayer(player) {
  return true;
}

function outlinehelper_disableentityoutline(entnum) {
  if(isDefined(entnum)) {
    entitydata = self.entityoutlines[entnum];

    if(isDefined(entitydata)) {
      foreach(outline in entitydata.list) {
        scripts\cp\cp_outline_utility::outlinedisable(outline.id, outline.ent);
      }

      self.entityoutlines[entnum] = undefined;
    }
  }
}

function setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

function outlinekillstreaks_enablemarksafterprematch() {
  self endon("unsetOutlineKillstreak");
  self enableentitymarks("killstreak", 1000000);
  self enableentitymarks("air_killstreak", 1000000);
  self.perkoutlinekillstreaksset = 1;
}

function unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("killstreak");
    self disableentitymarks("air_killstreak");
    self.perkoutlinekillstreaksset = undefined;
  }

  self notify("unsetOutlineKillstreak");
}

function markedentities_removeentsbyindex(entarray, var_223829bbefc81935) {
  resultarray = [];

  foreach(ent in entarray) {
    if(isDefined(ent)) {
      entnum = ent getentitynumber();

      if(!array_contains(var_223829bbefc81935, entnum)) {
        resultarray[resultarray.size] = ent;
      }
    }
  }

  return resultarray;
}

function markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  while(true) {
    self waittill("marks_changed", var_b56ac8b012f37095, var_7b50cc9c94be9505, var_c5dda6b7a37d4129);

    if(isDefined(var_b56ac8b012f37095)) {
      foreach(var_e0abeaa6ef08e178 in var_b56ac8b012f37095) {
        outlinehelper_disableentityoutline(var_e0abeaa6ef08e178);
      }

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = markedentities_removeentsbyindex(self.markequipmentstate.markedents, var_b56ac8b012f37095);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size) {
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
        }
      }
    }

    if(isDefined(var_7b50cc9c94be9505)) {
      foreach(var_4905d157180507c8 in var_7b50cc9c94be9505) {
        outlinehelper_disableentityoutline(var_4905d157180507c8);
      }
    }

    if(isDefined(var_c5dda6b7a37d4129)) {
      foreach(addedent in var_c5dda6b7a37d4129) {
        outlinehelper_enableentityoutline(addedent);
      }
    }
  }
}

function setblastshield() {
  set_perk("enemy_explosive_damage_reduction", 0.5);
}

function unsetblastshield() {
  set_perk("enemy_explosive_damage_reduction", 1);
}

function settracker() {
  thread runtrackkillstreakuse();
  thread run_track_enemy_patrollers();
}

function unsettracker() {
  self notify("tracker_removed");
}

function runtrackkillstreakuse() {
  self endon("death_or_disconnect");
  self endon("track_killstreak_end");

  while(true) {
    if(isusingremote()) {
      waitframe();
      takeperk("specialty_tracker");

      while(isusingremote()) {
        waitframe();
      }

      giveperk("specialty_tracker");
      break;
    }

    waitframe();
  }
}

function run_track_enemy_patrollers() {
  self endon("death_or_disconnect");
  self endon("tracker_removed");
  tracker_fov = cos(70);
  var_820e590cb5620371 = 0;
  self.view_list = [];
  self.outlineids = [];
  var_2ab4eb5f9bf4dd77 = 5000;

  while(true) {
    enemy_list = level.agentarray;

    foreach(guy in enemy_list) {
      if(var_820e590cb5620371 >= 20) {
        var_820e590cb5620371 = 0;
        waitframe();
      }

      if(!isDefined(guy)) {
        continue;
      }

      var_820e590cb5620371++;
      entnum = guy getentitynumber();
      var_25ab57d46f5f99f9 = within_fov(self getEye(), self getplayerangles(), guy.origin, tracker_fov);

      if(!var_25ab57d46f5f99f9) {
        continue;
      }

      passed = sighttracepassed(self getEye(), guy getEye(), 0, undefined);

      if(!passed) {
        if(isDefined(self.view_list[entnum])) {
          cur_time = gettime();
          var_77c5b5dd30fc2909 = cur_time - var_2ab4eb5f9bf4dd77;

          if(self.view_list[entnum] < var_77c5b5dd30fc2909) {} else {
            guy add_outline(entnum, self);
            guy thread untrack_enemy(self, 5);
          }
        }

        continue;
      }

      cur_time = gettime();
      self.view_list[entnum] = cur_time;
      guy remove_outline(entnum, self);
    }

    var_820e590cb5620371 = 0;
    waitframe();
  }
}

function function_d0eb3583cf0cdf66(var_b76712bde7c371e4) {
  self endon("death_or_disconnect");
  self notify("tracker_removed");
  self endon("tracker_removed");
  tracker_fov = cos(70);
  var_820e590cb5620371 = 0;
  self.view_list = [];
  self.outlineids = [];
  var_2ab4eb5f9bf4dd77 = 5000;

  while(true) {
    enemy_list = level.agentarray;

    foreach(guy in enemy_list) {
      if(var_820e590cb5620371 >= 20) {
        var_820e590cb5620371 = 0;
        waitframe();
      }

      if(!isDefined(guy)) {
        continue;
      }

      var_820e590cb5620371++;
      entnum = guy getentitynumber();
      target = guy getEye();

      if(!isDefined(target)) {
        target = guy.origin;
      }

      var_25ab57d46f5f99f9 = within_fov(self getEye(), self getplayerangles(), target, tracker_fov);

      if(!var_25ab57d46f5f99f9) {
        continue;
      }

      passed = sighttracepassed(self getEye(), guy getEye(), 0, undefined);

      if(istrue(var_b76712bde7c371e4) || !passed || istrue(self.var_2332678633fe1728)) {
        if(istrue(guy.reconmarked)) {
          guy add_outline(entnum, self);
        }

        continue;
      }

      if(istrue(guy.reconmarked)) {
        guy remove_outline(entnum, self);
      }
    }

    var_820e590cb5620371 = 0;
    waitframe();
  }
}

function add_outline(entnum, player) {
  if(!isDefined(player.outlineids[entnum])) {
    player.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforplayer(self, player, "snapshotgrenade", "equipment");
  }
}

function remove_perk(perk_name) {
  self[[scripts\engine\utility::getsharedfunc("perk", "removePerk")]](perk_name);
}

function untrack_enemy(player, timer) {
  entnum = self getentitynumber();

  if(isDefined(timer)) {
    wait timer;
  }

  if(isDefined(self.reconmarked)) {
    self.reconmarked = undefined;
  }

  remove_outline(entnum, player);
}

function remove_outline(entnum, player) {
  outlineid = player.outlineids[entnum];

  if(isDefined(outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(outlineid, self);
    player.outlineids[entnum] = undefined;
  }
}

function setviewkickoverride() {
  self.overrideviewkickscale = 0.5;
  self.overrideviewkickscaledmr = 0.5;
  self.overrideviewkickscalesniper = 0.5;
  self.overrideviewkickscalepistol = 0.5;
  scripts\cp\weapon::updateviewkickscale();
}

function unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.overrideviewkickscaledmr = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\cp\weapon::updateviewkickscale();
}

function set_heavy_hitter() {
  self.perk_data["melee_scalar"] = 2;
}

function unset_heavy_hitter() {
  self.perk_data["melee_scalar"] = 1;
}

function give_tune_up() {
  set_perk("super_fill_scalar", 1.3);
}

function take_tune_up() {
  set_perk("super_fill_scalar", 1);
}

function give_restock() {
  thread recharge_lethals_over_time(60);
}

function take_restock() {
  self notify("take_restock");
}

function recharge_lethals_over_time(timer) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  thread reset_restock_flag();
  thread reset_recharge_after_respawn();

  while(true) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(!isDefined(grenade.equipmentref)) {
      return;
    }

    var_d690ef8fdb341e60 = scripts\cp_mp\equipment::getcurrentequipment("primary");

    if(grenade.equipmentref == var_d690ef8fdb341e60) {
      thread function_b705cd6e9764d5b5(timer, "primary");
      thread function_b732b7db9744396e("primary");
    }

    var_ddca460ea9f6d6c5 = scripts\cp_mp\equipment::getcurrentequipment("secondary");

    if(grenade.equipmentref == var_ddca460ea9f6d6c5) {
      thread function_b705cd6e9764d5b5(timer, "secondary");
      thread function_b732b7db9744396e("secondary");
    }
  }
}

function reset_restock_flag() {
  level endon("game_ended");
  self waittill("take_restock");
  self.waiting_for_tactical_restock = undefined;
  self.waiting_for_lethal_restock = undefined;
  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar("ui_lethal_recharge_progress", 0);
  self setclientomnvar("ui_tactical_recharge_progress", 0);
}

function reset_recharge_after_respawn() {
  level endon("game_ended");
  self endon("take_restock");
  timer = 60;
  self waittill("landed_after_respawn");
  primary_equipment = scripts\cp_mp\equipment::getcurrentequipment("primary");

  if(isDefined(primary_equipment) && scripts\cp_mp\equipment::getequipmentammo(primary_equipment) < scripts\cp_mp\equipment::getequipmentmaxammo(primary_equipment)) {
    thread function_b705cd6e9764d5b5(timer, "primary");
  }

  secondary_equipment = scripts\cp_mp\equipment::getcurrentequipment("secondary");

  if(scripts\cp_mp\equipment::getequipmentammo(secondary_equipment) < scripts\cp_mp\equipment::getequipmentmaxammo(secondary_equipment)) {
    thread function_b705cd6e9764d5b5(timer, "secondary");
  }
}

function function_b705cd6e9764d5b5(timer, slot) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");
  equipmentref = scripts\cp_mp\equipment::getcurrentequipment(slot);
  self endon("equipment_taken_" + equipmentref);

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

  scripts\cp_mp\equipment::incrementequipmentammo(equipmentref);

  if(scripts\cp_mp\equipment::getequipmentammo(equipmentref) < scripts\cp_mp\equipment::getequipmentmaxammo(equipmentref)) {
    thread function_b705cd6e9764d5b5(timer, slot);
    return;
  }

  self notify("restock_done");
}

function update_restock_ui(omnvar, timer, slot) {
  self setclientomnvar("ui_recharge_notify", -1);
  start_time = gettime();
  end_time = start_time + timer * 1000;
  cur_time = gettime();

  while(cur_time < end_time) {
    while(istrue(self.inlaststand)) {
      self setclientomnvar("ui_recharge_notify", -1);
      self setclientomnvar(omnvar, 0);
      waitframe();
    }

    cur_time = gettime();
    progress = (cur_time - start_time) / (end_time - start_time);
    self setclientomnvar(omnvar, progress);
    wait 0.1;
  }

  self setclientomnvar("ui_recharge_notify", slot);
  self setclientomnvar(omnvar, 0);
}

function stop_restock_recharge(omnvar, slot) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");
  equipment = scripts\cp_mp\equipment::getcurrentequipment(slot);
  self endon("equipment_taken_" + equipment);

  while(istrue(self.inlaststand) || scripts\cp_mp\equipment::getequipmentammo(equipment) < scripts\cp_mp\equipment::getequipmentmaxammo(equipment)) {
    waitframe();
  }

  self notify("stop_restock_recharge");

  if(slot == "primary") {
    self.waiting_for_lethal_restock = undefined;
  } else {
    self.waiting_for_tactical_restock = undefined;
  }

  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar(omnvar, 0);
}

function function_b732b7db9744396e(slot) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");
  equipment = scripts\cp_mp\equipment::getcurrentequipment(slot);
  self waittill("equipment_taken_" + equipment);

  if(slot == "primary") {
    self.waiting_for_lethal_restock = undefined;
    self setclientomnvar("ui_lethal_recharge_progress", 0);
  } else {
    self.waiting_for_tactical_restock = undefined;
    self setclientomnvar("ui_tactical_recharge_progress", 0);
  }

  self setclientomnvar("ui_recharge_notify", -1);
}

function give_amped() {
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
}

function take_amped() {}

function give_shrapnel() {}

function take_shrapnel() {}

function setmomentum() {
  thread runmomentum();
}

function runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  while(true) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;

      if(isDefined(level.move_speed_scale)) {
        self[[level.move_speed_scale]]();
      }
    }

    wait 0.1;
  }
}

function graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();
  var_51438b11657961cc = 0;

  while(var_51438b11657961cc < 0.08) {
    self.movespeedscaler += 0.01;

    if(isDefined(level.move_speed_scale)) {
      self[[level.move_speed_scale]]();
    }

    wait 0.035 / 0.08;
    var_51438b11657961cc += 0.01;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

function momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

function momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  while(true) {
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

function momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

function unsetmomentum() {
  self notify("momentum_unset");
}

function watchcombatspeedscaler() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self.pistolcombatspeedscalar = 1;
  self.aliensnarespeedscalar = 1;
  self.aliensnarecount = 0;
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();

  while(true) {
    self waittill("weapon_change", objweapon);
    currentweapon = self getcurrentweapon();
    baseweapon = getrawbaseweaponname(currentweapon);

    if(isDefined(baseweapon)) {
      if(baseweapon == "nrg" || baseweapon == "zmagnum" || baseweapon == "zg18" || baseweapon == "emc") {
        self.pistolcombatspeedscalar = 1.1;
      } else {
        self.pistolcombatspeedscalar = 1;
      }

      wait 0.05;
      updatecombatspeedscalar();
    }

    wait 0.05;
  }
}

function updatecombatspeedscalar() {
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();
}

function getcombatspeedscalar() {
  return self.pistolcombatspeedscalar * self.aliensnarespeedscalar;
}

function removeperk(perkname) {
  assertex(isDefined(perkname), "removePerk perkName not defined and should be");
  assertex(perkname != "specialty_null", "removePerk perkName shouldn't be specialty_null");
  assertex(perkname != "none", "removePerk perkName shouldn't be none");
  scripts\cp\utility::_unsetperk(perkname);
  scripts\cp\utility::_unsetextraperks(perkname);
}

function setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regeneration");
}

function unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regeneration");
}

function function_cc2cf1db71343d8f() {
  self.var_4aec8a632dc40e2c = &function_5790c8111baf94d3;
}

function function_5ab8f9c4d813c44a() {
  self.var_4aec8a632dc40e2c = undefined;
}

function function_5790c8111baf94d3() {
  scripts\cp\perks\cp_perks::activateperk("specialty_elasomer_pads");
}