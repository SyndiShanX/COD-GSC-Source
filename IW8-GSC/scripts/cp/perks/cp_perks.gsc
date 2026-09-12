/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks\cp_perks.gsc
***********************************************/

function initperks() {
  init_core_mp_perks();
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
  thread scripts\cp\cp_agent_damage::ref_13C35();
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
    return;
  }
}

function get_perk(var_0) {
  if(isDefined(self.perk_data[var_0])) {
    return self.perk_data[var_0];
  }
}

function set_perk(var_0, var_1) {
  if(isDefined(self.perk_data[var_0])) {
    self.perk_data[var_0] = var_1;
    return;
  }
}

function blank() {}

function medic_speed_buff() {
  self.perk_data["move_speed_scalar"] = 1.12;
  self.movespeedscaler = 1.12;
  thread scripts\cp\cp_loadout::updatemovespeedscale();
}

function medic_health_regen(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  self endon("giving_class");
  var_1 = var_0 > 0;

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_3.medic_regeneration)) {
        if(var_1 && distancesquared(self.origin, var_3.origin) > var_0) {}
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

function should_give_extra_charge(var_0) {
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
      case "power_c4":
      case "power_claymore":
        return self.perk_data["offhand_count"];
      default:
        break;
    }
  }

  return undefined;
}

function reload_on_kill() {
  for(;;) {
    self waittill("kill_score");
    var_0 = self getcurrentprimaryweapon();
    var_1 = self getammocount(var_0);
    var_2 = int(min(var_1, weaponclipsize(var_0)));
    var_3 = var_1 - var_2;
    self setweaponammoclip(var_0, var_2);
    self setweaponammostock(var_0, var_3);
    wait 0.1;
  }
}

function give_fast_fire() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "doubletap");
  }
}

function give_bullet_penetration() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "fmj");
  }
}

function reduce_recoil() {
  self.old_view_kick = self getviewkickscale();
  self.overchargeviewkickscale = 0;
  self.old_recoil_scale = self player_getrecoilscale();
  self player_recoilscaleon(0);
  self.onhelisniper = 1;
  scripts\cp\cp_weapon::updateviewkickscale();
}

function ref_12BEE() {
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
  scripts\cp\cp_weapon::updateviewkickscale();
}

function reduce_bullet_spread() {
  scripts\cp\utility::giveperk("specialty_bulletaccuracy");
  self setaimspreadmovementscale(0.1);
}

function run_deadeye_charge_watcher() {
  self endon("disconnect");
  self endon("end_deadeye_charge_watcher");
  self endon("giving_class");
  self.deadeye_charge = undefined;
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
        if(istrue(self.deadeye_charge)) {}

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var_0 = undefined;
      var_1 = undefined;
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
  level.extraperkmap["specialty_hustle"] = ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement"];
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
  registerscriptperk("specialty_reduce_regen_delay_on_kill", &ref_131B9, &ref_13F6D);
  registerscriptperk("specialty_reduce_regen_delay_on_objective", &setreduceregendelayonobjective, &unsetreduceregendelayonobjective);
  registerscriptperk("specialty_hardline", &sethardline, &unsethardline);
  registerscriptperk("specialty_warhead", &give_amped, &take_amped, ["specialty_fastreload_launchers"]);
  registerscriptperk("specialty_fastreload_launchers", &setfastreloadlaunchers, &unsetfastreloadlaunchers);
  registerscriptperk("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_twoprimaries", &setoverkill, &unsetoverkill, []);
  registerscriptperk("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak"]);
  registerscriptperk("specialty_killstreak_to_scorestreak", &setkillstreaktoscorestreak, &unsetkillstreaktoscorestreak);
  registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  registerscriptperk("specialty_sixth_sense", &setsixthsense, &unsetsixthsense);
  thread sixthsense_think();
  registerscriptperk("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  registerscriptperk("specialty_extra_deadly", &give_shrapnel, &take_shrapnel);
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
  thread ref_1309D();
  registerscriptperk("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);
  registerscriptperk("specialty_blastshield", &setblastshield, &unsetblastshield);
  registerscriptperk("specialty_hack");
  registerscriptperk("specialty_shrapnel_resist");
  registerscriptperk("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report"]);
  registerscriptperk("specialty_tracker", &settracker, &unsettracker, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_kill_report");
  registerscriptperk("specialty_ammo_disabling");
  registerscriptperk("specialty_viewkickoverride", &setviewkickoverride, &unsetviewkickoverride);
  registerscriptperk("specialty_delayhealing");
  registerscriptperk("specialty_hardmelee", &ref_13094, &ref_13F31);
}

function registerscriptperk(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 1, var_1, var_2, var_3);
}

function registercodeperkinfo(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 0, var_1, var_2, var_3);
}

function registerperk(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1)) {
    level.scriptperks[var_0] = 1;
  }

  if(isDefined(var_2)) {
    level.perksetfuncs[var_0] = var_2;
  }

  if(isDefined(var_3)) {
    level.perkunsetfuncs[var_0] = var_3;
  }

  if(isDefined(var_4)) {
    level.extraperkmap[var_0] = var_4;
    return;
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

function ref_131B9() {}

function ref_13F6D() {}

function setreduceregendelayonobjective() {}

function unsetreduceregendelayonobjective() {}

function sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");

  if(scripts\cp\utility::tryingtoleave()) {
    return;
  }

  thread ref_12DE9();
  self.hardlineactive["assists"] = 0;
}

function unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

function ref_12DE9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("perk_end_hardline");
  var_0 = 7;

  for(;;) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > var_0) {
      scriptable_addusedcallbackbypart();
    }

    waitframe();
  }
}

function scriptable_addusedcallbackbypart() {
  var_0 = undefined;
  var_0 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\loot_system::give_munition(var_1, self);
  wait 10;
}

function setfastreloadlaunchers() {}

function unsetfastreloadlaunchers() {}

function setoverkill() {}

function unsetoverkill() {}

function setkillstreaktoscorestreak() {}

function unsetkillstreaktoscorestreak() {}

function sixthsense_think_internal() {
  var_0 = scripts\engine\trace::create_default_contents(1);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = getsystemtimeinmicroseconds();

  foreach(var_7 in level.sixth_sense_players) {
    if(!isDefined(var_7)) {
      level.sixth_sense_players[var_21] = undefined;
      break;
    }

    var_8 = 0;
    var_9 = var_7 getEye();
    var_10 = var_7.team;
    var_11 = anglesToForward(var_7 getplayerangles());

    foreach(var_13 in level.spawned_enemies) {
      if(var_2 >= 25) {
        var_2 = 0;
        waitframe();
      }

      if(!isDefined(var_7)) {
        level.sixth_sense_players[var_21] = undefined;
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

      if(!triggerbloodmoneyendcameras(var_13, var_7)) {
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

      var_17 = vectordot(var_11, vectorNormalize(var_3));

      if(var_17 < 0.382683) {
        var_2 += 2;

        if(scripts\engine\trace::ray_trace_detail_passed(var_14, var_9, var_7, var_0)) {
          var_8 |= roof_rpg_covers(var_7, var_13);
          break;
        }
      }
    }

    updatesixthsensevfx(var_7, var_8);
  }
}

function triggerbloodmoneyendcameras(var_0) {
  if(istrue(self.juggernaut)) {
    return true;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return true;
  }

  var_1 = self.weapon;
  var_2 = scripts\cp\cp_weapon::getweapongroup(var_1);

  switch (var_2) {
    case "weapon_dmr":
    case "weapon_projectile":
    case "weapon_sniper":
      return true;
    case "weapon_shotgun":
      if(distancesquared(self.origin, var_0.origin) > 160000) {
        return true;
      }

      break;
  }

  return false;
}

function sixthsense_think() {
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

function setsixthsense() {
  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = self;
}

function unsetsixthsense() {
  updatesixthsensevfx(0);
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = undefined;
}

function updatesixthsensevfx(var_0) {
  self setclientomnvar("ui_edge_glow", var_0);
}

function roof_rpg_covers(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  }

  if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  }

  if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  }

  if(var_5 >= -0.707107) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  }

  return 16;
}

function setghost() {
  self.perk_data["stealth_dist_scalar"] = 0.5;
}

function unsetghost() {
  self.perk_data["stealth_dist_scalar"] = 1;
}

function setstunresistance(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  var_0 = int(var_0);

  if(var_0 == 10) {
    self.stunscalar = 0;
    return;
  }

  self.stunscalar = var_0 / 10;
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

function brjugg_initdialog() {
  if(!isDefined(level.teamdata)) {
    level.teamdata = [];
  }

  if(!isDefined(level.teamdata["allies"])) {
    level.teamdata["allies"] = [];
  }

  if(!isDefined(level.teamdata["allies"]["players"])) {
    level.teamdata["allies"]["players"] = level.players;
  }

  var_0 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, 2000);

  foreach(var_2 in var_0) {
    if(issubstr(var_2.type, "brloot_munition")) {
      var_2.pavelow_boss_destroyed_watch = spawn("script_model", var_2.origin);
      var_2.pavelow_boss_destroyed_watch.angles = var_2.angles;
      var_2.pavelow_boss_destroyed_watch setModel("container_ammo_box_01_nophysics_cp");
      var_2.pavelow_boss_destroyed_watch enableplayermarks("equipment");
      scripts\cp\cp_outline_utility::outlineenableforplayer(var_2.pavelow_boss_destroyed_watch, self, "spotter_notarget_equipment", "perk");
    }

    waitframe();
  }
}

function ref_11A96() {
  var_0 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var_2 in var_0) {
    var_3 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var_2);
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

function ref_11A8D() {
  var_0 = 10;
  level.ref_1215F = [];
  level.ref_1215E = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.ref_1215F[var_1] = spawn("script_model", (0, 0, 0));
    level.ref_1215F[var_1].angles = (0, 0, 0);
    level.ref_1215F[var_1] setModel("container_ammo_box_01_nophysics_cp");
    level.ref_1215F[var_1] enableplayermarks("equipment");
  }

  thread ref_11CE7();
}

function ref_11CE7() {
  level endon("game_ended");

  for(;;) {
    if(scripts\cp\utility::_hasperk("specialty_engineer")) {
      prohibited_weapon_list_from_vehicle();
    }

    wait 0.1;
  }
}

function prohibited_weapon_list_from_vehicle() {
  var_0 = 1000;
  var_1 = 10;
  var_2 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, var_0, var_5);

    foreach(var_8 in var_6) {
      var_3 = var_8;
    }
  }

  var_3 = sortbydistance(var_3, self.origin);
  var_11 = level.ref_1215F;
  var_12 = [];
  var_13 = [];

  for(var_14 = 0; var_14 < var_3.size; var_14++) {
    if(!isDefined(level.ref_1215E[var_3[var_14].index])) {
      var_13 = var_3[var_14];
    }
  }

  if(var_13.size > 0) {
    var_15 = 0;

    for(var_14 = 0; var_14 < min(var_13.size, var_1); var_14++) {
      for(var_16 = 0; var_16 < level.ref_1215F.size; var_16++) {
        if(isDefined(var_12[var_16])) {
          continue;
        }

        if(isDefined(level.ref_1215F[var_16])) {
          level.ref_1215F[var_16] dontinterpolate();
        }

        level.ref_1215F[var_16].origin = var_13[var_14].origin;
        level.ref_1215F[var_16].angles = var_13[var_14].angles;
        level.ref_1215F[var_16].index = var_13[var_14].index;
        level.ref_1215E[level.ref_1215F[var_16].index] = undefined;
        level.ref_1215E[var_13[var_14].index] = level.ref_1215F[var_16];
        unmarkent(level.ref_1215F[var_16]);
        var_12 = var_13[var_14];
        break;
      }
    }

    return;
  }
}

function unmarkent(var_0) {
  var_0 filterinplayermarks(undefined);
  self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, var_0);
  var_0 notify("unmarkEnt_" + self getentitynumber());
}

function setmarkequipment() {
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

function unsetmarkequipment() {
  if(isDefined(self.markequipmentstate)) {
    foreach(var_1 in self.markequipmentstate.markedents) {
      if(isDefined(var_1)) {
        unmarkent(var_1);
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
  jumpiftrue(isDefined(self.markequipmentstate)) LOC_00000073;
  self.markequipmentstate = spawnStruct();
  self.markequipmentstate.markingtime = 0;
  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markedents = [];
  self.markequipmentstate.markedentindex = 0;
  self.markequipmentstate.pastmarkedents = [];
  self.markequipmentstate.pastmarkedentindex = 0;

  for(;;) {
    self waittill("marks_target_changed", var_0);
    var_1 = isDefined(var_0) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = var_0;
    self.markequipmentstate.markingtime = 0;

    if(var_1) {
      thread markequipment_updatestate();
    }
  }
}

function ref_1309D() {
  level.ref_12FBE = 6000;
  level.ref_12FC0 = 1500;
  level.ref_12FBF = 1000;
}

function markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  var_0 = gettime();
  var_1 = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent)) {
    var_1 = level.ref_12FBE;
  } else if(self entityhasmark("killstreak", self.markequipmentstate.markingent)) {
    var_1 = level.ref_12FC0;
  } else if(self entityhasmark("equipment", self.markequipmentstate.markingent)) {
    var_1 = level.ref_12FBF;
  }

  var_2 = var_1 * var_1;

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

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > var_2) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self.markequipmentstate.markingtime += var_4;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\cp\utility::isplayerads()) {
        var_5 = self.markequipmentstate.markedentindex;
        var_6 = self.markequipmentstate.markedents[var_5];

        if(isDefined(var_6)) {
          var_6 filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(var_6);
        }

        self.markequipmentstate.markingent filterinplayermarks(self.team);
        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self.markequipmentstate.markedents[var_5] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        }

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

function unmarkafterduration(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  wait getdvarint("perk_mark_equipment_duration");

  if(isDefined(var_0) && isDefined(self)) {
    unmarkent(var_0);
    return;
  }
}

function unmarkonownershipchange(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());

  for(;;) {
    wait 0.5;
  }
}

function outlinehelper_updateentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    outlinehelper_disableentityoutline(var_1);
    outlinehelper_enableentityoutline(var_0);
    return;
  }
}

function outlinehelper_enableentityoutline(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0 getentitynumber();
  var_2 = self.entityoutlines[var_1];

  if(isDefined(var_2)) {
    return;
  }

  var_3 = undefined;

  if(self entitymarkfilteredin(var_0)) {
    var_3 = spawnStruct();
    var_3.prioritygroup = "perk_superior";
    var_3.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(var_3);
  }

  var_4 = self entitymarkfilteredin(var_0);

  if(self entityhasmark("air_killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }

    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }

    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("equipment", var_0)) {
    if(isDefined(var_0.equipmentref) && var_0.equipmentref == "equip_tac_cover") {
      return;
    }

    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_equipment";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(var_3);
  }

  if(isDefined(var_3)) {
    var_2 = spawnStruct();
    self.entityoutlines[var_1] = var_2;
    var_2.list = [];
    var_2.ent = var_0;
    var_5 = getchildoutlineents(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\cp\cp_outline_utility::outlineenableforplayer(var_7, self, var_3.hudoutlineassetname, var_3.prioritygroup);
      var_9 = spawnStruct();
      var_9.ent = var_7;
      var_9.id = var_8;
      var_10 = var_7 getentitynumber();
      var_2.list[var_10] = var_9;
    }

    return;
  }
}

function getchildoutlineents(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  if(!isDefined(var_0.childoutlineents)) {
    return [var_0];
  }

  return var_0.childoutlineents;
}

function outlinehelper_verifydata(var_0) {
  if(!isDefined(var_0.getplayers)) {
    var_0.getplayers = &outlinehelper_getallplayers;
  }

  if(!isDefined(var_0.validplayer)) {
    var_0.validplayer = &outlinehelper_validplayer;
  }

  if(!isDefined(var_0.hudoutlineassetname)) {
    var_0.hudoutlineassetname = "spotter_notarget";
  }

  if(!isDefined(var_0.prioritygroup)) {
    var_0.prioritygroup = "perk";
  }

  if(!isDefined(var_0.waittime)) {
    var_0.waittime = 0.1;
    return;
  }
}

function outlinehelper_getallplayers(var_0, var_1) {
  return level.players;
}

function outlinehelper_validplayer(var_0) {
  return true;
}

function outlinehelper_disableentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = self.entityoutlines[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1.list) {
        scripts\cp\cp_outline_utility::outlinedisable(var_3.id, var_3.ent);
      }

      self.entityoutlines[var_0] = undefined;
      return;
    }

    return;
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

function ref_11B0B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  for(;;) {
    self waittill("marks_changed", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0) {
        outlinehelper_disableentityoutline(var_4);
      }

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = ref_11B0B(self.markequipmentstate.markedents, var_0);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size) {
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
        }
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1) {
        outlinehelper_disableentityoutline(var_7);
      }
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2) {
        outlinehelper_enableentityoutline(var_10);
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
  thread ref_12DFD();
}

function unsettracker() {
  self notify("tracker_removed");
}

function runtrackkillstreakuse() {
  self endon("death_or_disconnect");
  self endon("track_killstreak_end");

  for(;;) {
    if(scripts\cp\utility::isusingremote()) {
      waitframe();
      scripts\cp\utility::takeperk("specialty_tracker");

      while(scripts\cp\utility::isusingremote()) {
        waitframe();
      }

      scripts\cp\utility::giveperk("specialty_tracker");
      break;
    }

    waitframe();
  }
}

function ref_12DFD() {
  self endon("death_or_disconnect");
  self endon("tracker_removed");
  var_0 = cos(70);
  var_1 = 0;
  self.ref_142B0 = [];
  self.outlineids = [];
  var_2 = 5000;

  for(;;) {
    var_3 = level.spawned_enemies;

    foreach(var_5 in var_3) {
      if(var_1 >= 20) {
        var_1 = 0;
        waitframe();
      }

      if(!isDefined(var_5)) {
        continue;
      }

      if(var_5 scripts\cp\coop_stealth::ref_132D7()) {
        if(isDefined(var_5.fnisinstealthcombat) && var_5[[var_5.fnisinstealthcombat]]()) {
          continue;
        }
      } else if(isDefined(var_5.current_stealth_state)) {
        if(var_5.current_stealth_state != "casual" && var_5.current_stealth_state != "alert") {
          continue;
        }
      } else {
        continue;
      }

      var_1++;
      var_6 = var_5 getentitynumber();
      var_7 = scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), var_5.origin, var_0);

      if(!var_7) {
        continue;
      }

      var_8 = sighttracepassed(self getEye(), var_5 getEye(), 0, undefined);

      if(!var_8) {
        if(isDefined(self.ref_142B0[var_6])) {
          var_9 = gettime();
          var_10 = var_9 - var_2;

          if(self.ref_142B0[var_6] < var_10) {} else {
            awardobjtimeforcarrier(var_5, var_6, self);
            thread ref_13F75(var_5, self);
          }
        }

        continue;
      }

      var_9 = gettime();
      self.ref_142B0[var_6] = var_9;
      ref_12BE6(var_5, var_6, self);
    }

    var_1 = 0;
    waitframe();
  }
}

function awardobjtimeforcarrier(var_0, var_1) {
  if(!isDefined(var_1.outlineids[var_0])) {
    var_1.outlineids[var_0] = scripts\cp\cp_outline_utility::outlineenableforplayer(self, var_1, "snapshotgrenade", "equipment");
    return;
  }
}

function ref_13F75(var_0, var_1) {
  self endon("track_enemy");
  var_2 = self getentitynumber();
  wait var_1;
  ref_12BE6(var_2, var_0);
}

function ref_12BE6(var_0, var_1) {
  var_2 = var_1.outlineids[var_0];

  if(isDefined(var_2)) {
    scripts\cp\cp_outline_utility::outlinedisable(var_2, self);
    var_1.outlineids[var_0] = undefined;
  }

  self notify("track_enemy");
}

function setviewkickoverride() {
  self.overrideviewkickscale = 0.05;
  self.ref_1218D = 0.05;
  self.ref_1218E = 0.02;
  self.overrideviewkickscalesniper = 0.3;
  self.overrideviewkickscalepistol = 0.05;
  scripts\cp\cp_weapon::updateviewkickscale();
}

function unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.ref_1218D = undefined;
  self.ref_1218E = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\cp\cp_weapon::updateviewkickscale();
}

function ref_13094() {
  self.perk_data["melee_scalar"] = 2;
}

function ref_13F31() {
  self.perk_data["melee_scalar"] = 1;
}

function give_tune_up() {
  set_perk("super_fill_scalar", 1.3);
}

function take_tune_up() {
  set_perk("super_fill_scalar", 1);
}

function give_restock() {
  thread recharge_lethals_over_time(30);
}

function take_restock() {
  self notify("take_restock");
}

function recharge_lethals_over_time(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  thread ref_12C5F();
  thread ref_12C5D();
  thread ref_13F8B();

  for(;;) {
    self.ref_12141 = register_chopper_boss_combat_actions(self, "primary");
    self.ref_12142 = register_chopper_boss_combat_actions(self, "secondary");
    self waittill("grenade_fire", var_1, var_2, var_3, var_4);
    var_5 = register_chopper_boss_combat_actions(self, "primary");

    if(!isDefined(var_5)) {
      var_5 = self.ref_12141;
    }

    if(var_2.basename == var_5) {
      thread kill_drone_turret(self, var_0);
    }

    var_6 = register_chopper_boss_combat_actions(self, "secondary");

    if(!isDefined(var_6)) {
      var_6 = self.ref_12142;
    }

    if(var_2.basename == var_6) {
      thread kill_furthest_enemy(self, var_0);
    }
  }
}

function ref_13F8B() {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");

  for(;;) {
    self waittill("powers_updated");
    self.ref_12141 = register_chopper_boss_combat_actions(self, "primary");
    self.ref_12142 = register_chopper_boss_combat_actions(self, "secondary");
  }
}

function ref_12C5F() {
  level endon("game_ended");
  self waittill("take_restock");
  self.ref_14388 = 0;
  self.ref_14387 = 0;
  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar("ui_lethal_recharge_progress", 0);
  self setclientomnvar("ui_tactical_recharge_progress", 0);
}

function ref_12C5D() {
  level endon("game_ended");
  self endon("take_restock");
  var_0 = 30;
  self waittill("landed_after_respawn");

  if(race_get_next_checkpoint(self, "primary") < race_init(self, "primary")) {
    thread kill_drone_turret(self, var_0);
  }

  if(race_get_next_checkpoint(self, "secondary") < race_init(self, "secondary")) {
    thread kill_furthest_enemy(self, var_0);
    return;
  }
}

function kill_drone_turret(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var_0.ref_14387)) {
    return;
  }

  thread ref_138C5("ui_lethal_recharge_progress", "primary");
  var_0.ref_14387 = 1;
  ref_13FAC("ui_lethal_recharge_progress", var_1, 0);
  var_0.ref_14387 = 0;
  var_0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var_0, "primary"), 1);

  if(race_get_next_checkpoint(var_0, "primary") < race_init(var_0, "primary")) {
    thread kill_drone_turret(var_0, self);
    return;
  }

  var_0 notify("restock_done");
}

function kill_furthest_enemy(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var_0.ref_14388)) {
    return;
  }

  thread ref_138C5("ui_tactical_recharge_progress", "secondary");
  var_0.ref_14388 = 1;
  ref_13FAC("ui_tactical_recharge_progress", var_1, 1);
  var_0.ref_14388 = 0;
  var_0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var_0, "secondary"), 1);

  if(race_get_next_checkpoint(var_0, "secondary") < race_init(var_0, "secondary")) {
    thread kill_furthest_enemy(var_0, self);
    return;
  }

  var_0 notify("restock_done");
}

function ref_13FAC(var_0, var_1, var_2) {
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

function ref_138C5(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");

  while(istrue(self.inlaststand) || race_get_next_checkpoint(self, var_1) < race_init(self, var_1)) {
    waitframe();
  }

  self notify("stop_restock_recharge");

  if(var_1 == "primary") {
    self.ref_14387 = 0;
  } else {
    self.ref_14388 = 0;
  }

  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar(var_0, 0);
}

function register_chopper_boss_combat_actions(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1) {
      return var_3.weaponuse;
    }
  }
}

function race_is_player_driving_vehicle(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1) {
      return var_4;
    }
  }
}

function race_get_next_checkpoint(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1) {
      return var_3.charges;
    }
  }
}

function race_init(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1) {
      return var_3.maxcharges;
    }
  }
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

  for(;;) {
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
  var_0 = 0;

  while(var_0 < 0.08) {
    self.movespeedscaler += 0.01;

    if(isDefined(level.move_speed_scale)) {
      self[[level.move_speed_scale]]();
    }

    wait 0.4375;
    var_0 += 0.01;
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

  for(;;) {
    self waittill("weapon_change", var_0);
    var_1 = self getcurrentweapon();
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "nrg" || var_2 == "zmagnum" || var_2 == "zg18" || var_2 == "emc") {
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

function removeperk(var_0) {
  scripts\cp\utility::_unsetperk(var_0);
  scripts\cp\utility::_unsetextraperks(var_0);
}