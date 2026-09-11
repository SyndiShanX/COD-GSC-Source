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
  thread scripts\cp\cp_agent_damage::ref_13c35();
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

function get_perk(var0) {
  if(isDefined(self.perk_data[var0])) {
    return self.perk_data[var0];
  }
}

function set_perk(var0, var1) {
  if(isDefined(self.perk_data[var0])) {
    self.perk_data[var0] = var1;
    return;
  }
}

function blank() {}

function medic_speed_buff() {
  self.perk_data["move_speed_scalar"] = 1.12;
  self.movespeedscaler = 1.12;
  thread scripts\cp\cp_loadout::updatemovespeedscale();
}

function medic_health_regen(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  self endon("giving_class");
  var1 = var0 > 0;

  for(;;) {
    foreach(var3 in level.players) {
      if(var3 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var3.medic_regeneration)) {
        if(var1 && distancesquared(self.origin, var3.origin) > var0) {}
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

function should_give_extra_charge(var0) {
  if(isDefined(var0)) {
    switch (var0) {
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
    var0 = self getcurrentprimaryweapon();
    var1 = self getammocount(var0);
    var2 = int(min(var1, weaponclipsize(var0)));
    var3 = var1 - var2;
    self setweaponammoclip(var0, var2);
    self setweaponammostock(var0, var3);
    wait 0.1;
  }
}

function give_fast_fire() {
  var0 = self getweaponslistprimaries();

  foreach(var2 in var0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var2, "doubletap");
  }
}

function give_bullet_penetration() {
  var0 = self getweaponslistprimaries();

  foreach(var2 in var0) {
    scripts\cp\cp_weapon::addattachmenttoweapon(var2, "fmj");
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

function ref_12bee() {
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
  var0 = undefined;
  var1 = undefined;
  var2 = 500;

  for(;;) {
    if(self adsButtonPressed()) {
      var3 = gettime();

      if(!isDefined(var0)) {
        var0 = var3;
        var1 = var3 + var2;
      } else if(var3 > var1) {
        if(istrue(self.deadeye_charge)) {}

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var0 = undefined;
      var1 = undefined;
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
  registerscriptperk("specialty_reduce_regen_delay_on_kill", &ref_131b9, &ref_13f6d);
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
  thread ref_1309d();
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
  registerscriptperk("specialty_hardmelee", &ref_13094, &ref_13f31);
}

function registerscriptperk(var0, var1, var2, var3) {
  registerperk(var0, 1, var1, var2, var3);
}

function registercodeperkinfo(var0, var1, var2, var3) {
  registerperk(var0, 0, var1, var2, var3);
}

function registerperk(var0, var1, var2, var3, var4) {
  if(istrue(var1)) {
    level.scriptperks[var0] = 1;
  }

  if(isDefined(var2)) {
    level.perksetfuncs[var0] = var2;
  }

  if(isDefined(var3)) {
    level.perkunsetfuncs[var0] = var3;
  }

  if(isDefined(var4)) {
    level.extraperkmap[var0] = var4;
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

function ref_131b9() {}

function ref_13f6d() {}

function setreduceregendelayonobjective() {}

function unsetreduceregendelayonobjective() {}

function sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");

  if(scripts\cp\utility::tryingtoleave()) {
    return;
  }

  thread ref_12de9();
  self.hardlineactive["assists"] = 0;
}

function unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

function ref_12de9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("perk_end_hardline");
  var0 = 7;

  for(;;) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > var0) {
      scriptable_addusedcallbackbypart();
    }

    waitframe();
  }
}

function scriptable_addusedcallbackbypart() {
  var0 = undefined;
  var0 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];
  var1 = scripts\engine\utility::random(var0);
  scripts\cp\loot_system::give_munition(var1, self);
  wait 10;
}

function setfastreloadlaunchers() {}

function unsetfastreloadlaunchers() {}

function setoverkill() {}

function unsetoverkill() {}

function setkillstreaktoscorestreak() {}

function unsetkillstreaktoscorestreak() {}

function sixthsense_think_internal() {
  var0 = scripts\engine\trace::create_default_contents(1);
  var1 = 0;
  var2 = 0;
  var3 = undefined;
  var4 = undefined;
  var5 = getsystemtimeinmicroseconds();

  foreach(var7 in level.sixth_sense_players) {
    if(!isDefined(var7)) {
      level.sixth_sense_players[var21] = undefined;
      break;
    }

    var8 = 0;
    var9 = var7 getEye();
    var10 = var7.team;
    var11 = anglesToForward(var7 getplayerangles());

    foreach(var13 in level.spawned_enemies) {
      if(var2 >= 25) {
        var2 = 0;
        waitframe();
      }

      if(!isDefined(var7)) {
        level.sixth_sense_players[var21] = undefined;
        break;
      }

      if(!var7 scripts\cp\utility::_hasperk("specialty_sixth_sense")) {
        continue;
      }

      if(!var7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isDefined(var13)) {
        continue;
      }

      if(!var13 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var13.team == var10) {
        continue;
      }

      if(distancesquared(var13.origin, var9) > 16000000) {
        continue;
      }

      if(!triggerbloodmoneyendcameras(var13, var7)) {
        continue;
      }

      if(isDefined(var13.vehicle)) {
        continue;
      }

      var2++;
      var14 = var13 getEye();
      var15 = anglesToForward(var13 getplayerangles());
      var16 = var9 - var14;
      var3 = var14 - var9;
      var17 = vectordot(var16, var15);

      if(var17 <= 0) {
        continue;
      }

      var18 = 0.984808;
      var19 = length(var16);

      if(var17 < var18 * var19) {
        continue;
      }

      var17 = vectordot(var11, vectorNormalize(var3));

      if(var17 < 0.382683) {
        var2 += 2;

        if(scripts\engine\trace::ray_trace_detail_passed(var14, var9, var7, var0)) {
          var8 |= roof_rpg_covers(var7, var13);
          break;
        }
      }
    }

    updatesixthsensevfx(var7, var8);
  }
}

function triggerbloodmoneyendcameras(var0) {
  if(istrue(self.juggernaut)) {
    return true;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return true;
  }

  var1 = self.weapon;
  var2 = scripts\cp\cp_weapon::getweapongroup(var1);

  switch (var2) {
    case "weapon_dmr":
    case "weapon_projectile":
    case "weapon_sniper":
      return true;
    case "weapon_shotgun":
      if(distancesquared(self.origin, var0.origin) > 160000) {
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
  var0 = self getentitynumber();
  level.sixth_sense_players[var0] = self;
}

function unsetsixthsense() {
  updatesixthsensevfx(0);
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  var0 = self getentitynumber();
  level.sixth_sense_players[var0] = undefined;
}

function updatesixthsensevfx(var0) {
  self setclientomnvar("ui_edge_glow", var0);
}

function roof_rpg_covers(var0) {
  var1 = anglesToForward(self getplayerangles());
  var2 = (var1[0], var1[1], var1[2]);
  var2 = vectorNormalize(var2);
  var3 = var0.origin - self.origin;
  var4 = (var3[0], var3[1], var3[2]);
  var4 = vectorNormalize(var4);
  var5 = vectordot(var2, var4);

  if(var5 >= 0.92388) {
    return 2;
  }

  if(var5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var2, var0.origin), 4, 1);
  }

  if(var5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var2, var0.origin), 128, 64);
  }

  if(var5 >= -0.707107) {
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var2, var0.origin), 32, 8);
  }

  return 16;
}

function setghost() {
  self.perk_data["stealth_dist_scalar"] = 0.5;
}

function unsetghost() {
  self.perk_data["stealth_dist_scalar"] = 1;
}

function setstunresistance(var0) {
  if(!isDefined(var0)) {
    var0 = 4;
  }

  var0 = int(var0);

  if(var0 == 10) {
    self.stunscalar = 0;
    return;
  }

  self.stunscalar = var0 / 10;
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

  var0 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, 2000);

  foreach(var2 in var0) {
    if(issubstr(var2.type, "brloot_munition")) {
      var2.pavelow_boss_destroyed_watch = spawn("script_model", var2.origin);
      var2.pavelow_boss_destroyed_watch.angles = var2.angles;
      var2.pavelow_boss_destroyed_watch setModel("container_ammo_box_01_nophysics_cp");
      var2.pavelow_boss_destroyed_watch enableplayermarks("equipment");
      scripts\cp\cp_outline_utility::outlineenableforplayer(var2.pavelow_boss_destroyed_watch, self, "spotter_notarget_equipment", "perk");
    }

    waitframe();
  }
}

function ref_11a96() {
  var0 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var2 in var0) {
    var3 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var2);
    var4 = 0;

    foreach(var6 in var3) {
      var6 setscriptablepartstate(var2, "visible");
      var4++;

      if(var4 % 20) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function ref_11a8d() {
  var0 = 10;
  level.ref_1215f = [];
  level.ref_1215e = [];

  for(var1 = 0; var1 < var0; var1++) {
    level.ref_1215f[var1] = spawn("script_model", (0, 0, 0));
    level.ref_1215f[var1].angles = (0, 0, 0);
    level.ref_1215f[var1] setModel("container_ammo_box_01_nophysics_cp");
    level.ref_1215f[var1] enableplayermarks("equipment");
  }

  thread ref_11ce7();
}

function ref_11ce7() {
  level endon("game_ended");

  for(;;) {
    if(scripts\cp\utility::_hasperk("specialty_engineer")) {
      prohibited_weapon_list_from_vehicle();
    }

    wait 0.1;
  }
}

function prohibited_weapon_list_from_vehicle() {
  var0 = 1000;
  var1 = 10;
  var2 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];
  var3 = [];

  foreach(var5 in var2) {
    var6 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, var0, var5);

    foreach(var8 in var6) {
      var3 = var8;
    }
  }

  var3 = sortbydistance(var3, self.origin);
  var11 = level.ref_1215f;
  var12 = [];
  var13 = [];

  for(var14 = 0; var14 < var3.size; var14++) {
    if(!isDefined(level.ref_1215e[var3[var14].index])) {
      var13 = var3[var14];
    }
  }

  if(var13.size > 0) {
    var15 = 0;

    for(var14 = 0; var14 < min(var13.size, var1); var14++) {
      for(var16 = 0; var16 < level.ref_1215f.size; var16++) {
        if(isDefined(var12[var16])) {
          continue;
        }

        if(isDefined(level.ref_1215f[var16])) {
          level.ref_1215f[var16] dontinterpolate();
        }

        level.ref_1215f[var16].origin = var13[var14].origin;
        level.ref_1215f[var16].angles = var13[var14].angles;
        level.ref_1215f[var16].index = var13[var14].index;
        level.ref_1215e[level.ref_1215f[var16].index] = undefined;
        level.ref_1215e[var13[var14].index] = level.ref_1215f[var16];
        unmarkent(level.ref_1215f[var16]);
        var12 = var13[var14];
        break;
      }
    }

    return;
  }
}

function unmarkent(var0) {
  var0 filterinplayermarks(undefined);
  self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, var0);
  var0 notify("unmarkEnt_" + self getentitynumber());
}

function setmarkequipment() {
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

function unsetmarkequipment() {
  if(isDefined(self.markequipmentstate)) {
    foreach(var1 in self.markequipmentstate.markedents) {
      if(isDefined(var1)) {
        unmarkent(var1);
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
    self waittill("marks_target_changed", var0);
    var1 = isDefined(var0) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = var0;
    self.markequipmentstate.markingtime = 0;

    if(var1) {
      thread markequipment_updatestate();
    }
  }
}

function ref_1309d() {
  level.ref_12fbe = 6000;
  level.ref_12fc0 = 1500;
  level.ref_12fbf = 1000;
}

function markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  var0 = gettime();
  var1 = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent)) {
    var1 = level.ref_12fbe;
  } else if(self entityhasmark("killstreak", self.markequipmentstate.markingent)) {
    var1 = level.ref_12fc0;
  } else if(self entityhasmark("equipment", self.markequipmentstate.markingent)) {
    var1 = level.ref_12fbf;
  }

  var2 = var1 * var1;

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

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > var2) {
      break;
    }

    var3 = gettime();
    var4 = var3 - var0;
    self.markequipmentstate.markingtime += var4;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\cp\utility::isplayerads()) {
        var5 = self.markequipmentstate.markedentindex;
        var6 = self.markequipmentstate.markedents[var5];

        if(isDefined(var6)) {
          var6 filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(var6);
        }

        self.markequipmentstate.markingent filterinplayermarks(self.team);
        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self.markequipmentstate.markedents[var5] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (var5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        }

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    var0 = var3;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

function unmarkafterduration(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  wait getdvarint("perk_mark_equipment_duration");

  if(isDefined(var0) && isDefined(self)) {
    unmarkent(var0);
    return;
  }
}

function unmarkonownershipchange(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());

  for(;;) {
    wait 0.5;
  }
}

function outlinehelper_updateentityoutline(var0) {
  if(isDefined(var0)) {
    var1 = var0 getentitynumber();
    outlinehelper_disableentityoutline(var1);
    outlinehelper_enableentityoutline(var0);
    return;
  }
}

function outlinehelper_enableentityoutline(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0 getentitynumber();
  var2 = self.entityoutlines[var1];

  if(isDefined(var2)) {
    return;
  }

  var3 = undefined;

  if(self entitymarkfilteredin(var0)) {
    var3 = spawnStruct();
    var3.prioritygroup = "perk_superior";
    var3.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(var3);
  }

  var4 = self entitymarkfilteredin(var0);

  if(self entityhasmark("air_killstreak", var0)) {
    if(!isDefined(var0.model)) {
      return;
    }

    var3 = spawnStruct();

    if(var4) {
      var3.prioritygroup = "perk_superior";
      var3.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      var3.prioritygroup = "perk";
      var3.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(var3);
  } else if(self entityhasmark("killstreak", var0)) {
    if(!isDefined(var0.model)) {
      return;
    }

    var3 = spawnStruct();

    if(var4) {
      var3.prioritygroup = "perk_superior";
      var3.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      var3.prioritygroup = "perk";
      var3.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(var3);
  } else if(self entityhasmark("equipment", var0)) {
    if(isDefined(var0.equipmentref) && var0.equipmentref == "equip_tac_cover") {
      return;
    }

    var3 = spawnStruct();

    if(var4) {
      var3.prioritygroup = "perk_superior";
      var3.hudoutlineassetname = "spotter_target_equipment";
    } else {
      var3.prioritygroup = "perk";
      var3.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(var3);
  }

  if(isDefined(var3)) {
    var2 = spawnStruct();
    self.entityoutlines[var1] = var2;
    var2.list = [];
    var2.ent = var0;
    var5 = getchildoutlineents(var0);

    foreach(var7 in var5) {
      var8 = scripts\cp\cp_outline_utility::outlineenableforplayer(var7, self, var3.hudoutlineassetname, var3.prioritygroup);
      var9 = spawnStruct();
      var9.ent = var7;
      var9.id = var8;
      var10 = var7 getentitynumber();
      var2.list[var10] = var9;
    }

    return;
  }
}

function getchildoutlineents(var0) {
  if(!isDefined(var0)) {
    return [];
  }

  if(!isDefined(var0.childoutlineents)) {
    return [var0];
  }

  return var0.childoutlineents;
}

function outlinehelper_verifydata(var0) {
  if(!isDefined(var0.getplayers)) {
    var0.getplayers = &outlinehelper_getallplayers;
  }

  if(!isDefined(var0.validplayer)) {
    var0.validplayer = &outlinehelper_validplayer;
  }

  if(!isDefined(var0.hudoutlineassetname)) {
    var0.hudoutlineassetname = "spotter_notarget";
  }

  if(!isDefined(var0.prioritygroup)) {
    var0.prioritygroup = "perk";
  }

  if(!isDefined(var0.waittime)) {
    var0.waittime = 0.1;
    return;
  }
}

function outlinehelper_getallplayers(var0, var1) {
  return level.players;
}

function outlinehelper_validplayer(var0) {
  return true;
}

function outlinehelper_disableentityoutline(var0) {
  if(isDefined(var0)) {
    var1 = self.entityoutlines[var0];

    if(isDefined(var1)) {
      foreach(var3 in var1.list) {
        scripts\cp\cp_outline_utility::outlinedisable(var3.id, var3.ent);
      }

      self.entityoutlines[var0] = undefined;
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

function ref_11b0b(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    var5 = var4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var1, var5)) {
      var2 = var4;
    }
  }

  return var2;
}

function markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  for(;;) {
    self waittill("marks_changed", var0, var1, var2);

    if(isDefined(var0)) {
      foreach(var4 in var0) {
        outlinehelper_disableentityoutline(var4);
      }

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = ref_11b0b(self.markequipmentstate.markedents, var0);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size) {
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
        }
      }
    }

    if(isDefined(var1)) {
      foreach(var7 in var1) {
        outlinehelper_disableentityoutline(var7);
      }
    }

    if(isDefined(var2)) {
      foreach(var10 in var2) {
        outlinehelper_enableentityoutline(var10);
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
  thread ref_12dfd();
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

function ref_12dfd() {
  self endon("death_or_disconnect");
  self endon("tracker_removed");
  var0 = cos(70);
  var1 = 0;
  self.ref_142b0 = [];
  self.outlineids = [];
  var2 = 5000;

  for(;;) {
    var3 = level.spawned_enemies;

    foreach(var5 in var3) {
      if(var1 >= 20) {
        var1 = 0;
        waitframe();
      }

      if(!isDefined(var5)) {
        continue;
      }

      if(var5 scripts\cp\coop_stealth::ref_132d7()) {
        if(isDefined(var5.fnisinstealthcombat) && var5[[var5.fnisinstealthcombat]]()) {
          continue;
        }
      } else if(isDefined(var5.current_stealth_state)) {
        if(var5.current_stealth_state != "casual" && var5.current_stealth_state != "alert") {
          continue;
        }
      } else {
        continue;
      }

      var1++;
      var6 = var5 getentitynumber();
      var7 = scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), var5.origin, var0);

      if(!var7) {
        continue;
      }

      var8 = sighttracepassed(self getEye(), var5 getEye(), 0, undefined);

      if(!var8) {
        if(isDefined(self.ref_142b0[var6])) {
          var9 = gettime();
          var10 = var9 - var2;

          if(self.ref_142b0[var6] < var10) {} else {
            awardobjtimeforcarrier(var5, var6, self);
            thread ref_13f75(var5, self);
          }
        }

        continue;
      }

      var9 = gettime();
      self.ref_142b0[var6] = var9;
      ref_12be6(var5, var6, self);
    }

    var1 = 0;
    waitframe();
  }
}

function awardobjtimeforcarrier(var0, var1) {
  if(!isDefined(var1.outlineids[var0])) {
    var1.outlineids[var0] = scripts\cp\cp_outline_utility::outlineenableforplayer(self, var1, "snapshotgrenade", "equipment");
    return;
  }
}

function ref_13f75(var0, var1) {
  self endon("track_enemy");
  var2 = self getentitynumber();
  wait var1;
  ref_12be6(var2, var0);
}

function ref_12be6(var0, var1) {
  var2 = var1.outlineids[var0];

  if(isDefined(var2)) {
    scripts\cp\cp_outline_utility::outlinedisable(var2, self);
    var1.outlineids[var0] = undefined;
  }

  self notify("track_enemy");
}

function setviewkickoverride() {
  self.overrideviewkickscale = 0.05;
  self.ref_1218d = 0.05;
  self.ref_1218e = 0.02;
  self.overrideviewkickscalesniper = 0.3;
  self.overrideviewkickscalepistol = 0.05;
  scripts\cp\cp_weapon::updateviewkickscale();
}

function unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.ref_1218d = undefined;
  self.ref_1218e = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\cp\cp_weapon::updateviewkickscale();
}

function ref_13094() {
  self.perk_data["melee_scalar"] = 2;
}

function ref_13f31() {
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

function recharge_lethals_over_time(var0) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  thread ref_12c5f();
  thread ref_12c5d();
  thread ref_13f8b();

  for(;;) {
    self.ref_12141 = register_chopper_boss_combat_actions(self, "primary");
    self.ref_12142 = register_chopper_boss_combat_actions(self, "secondary");
    self waittill("grenade_fire", var1, var2, var3, var4);
    var5 = register_chopper_boss_combat_actions(self, "primary");

    if(!isDefined(var5)) {
      var5 = self.ref_12141;
    }

    if(var2.basename == var5) {
      thread kill_drone_turret(self, var0);
    }

    var6 = register_chopper_boss_combat_actions(self, "secondary");

    if(!isDefined(var6)) {
      var6 = self.ref_12142;
    }

    if(var2.basename == var6) {
      thread kill_furthest_enemy(self, var0);
    }
  }
}

function ref_13f8b() {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");

  for(;;) {
    self waittill("powers_updated");
    self.ref_12141 = register_chopper_boss_combat_actions(self, "primary");
    self.ref_12142 = register_chopper_boss_combat_actions(self, "secondary");
  }
}

function ref_12c5f() {
  level endon("game_ended");
  self waittill("take_restock");
  self.ref_14388 = 0;
  self.ref_14387 = 0;
  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar("ui_lethal_recharge_progress", 0);
  self setclientomnvar("ui_tactical_recharge_progress", 0);
}

function ref_12c5d() {
  level endon("game_ended");
  self endon("take_restock");
  var0 = 30;
  self waittill("landed_after_respawn");

  if(race_get_next_checkpoint(self, "primary") < race_init(self, "primary")) {
    thread kill_drone_turret(self, var0);
  }

  if(race_get_next_checkpoint(self, "secondary") < race_init(self, "secondary")) {
    thread kill_furthest_enemy(self, var0);
    return;
  }
}

function kill_drone_turret(var0, var1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var0.ref_14387)) {
    return;
  }

  thread ref_138c5("ui_lethal_recharge_progress", "primary");
  var0.ref_14387 = 1;
  ref_13fac("ui_lethal_recharge_progress", var1, 0);
  var0.ref_14387 = 0;
  var0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var0, "primary"), 1);

  if(race_get_next_checkpoint(var0, "primary") < race_init(var0, "primary")) {
    thread kill_drone_turret(var0, self);
    return;
  }

  var0 notify("restock_done");
}

function kill_furthest_enemy(var0, var1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("stop_restock_recharge");

  if(istrue(var0.ref_14388)) {
    return;
  }

  thread ref_138c5("ui_tactical_recharge_progress", "secondary");
  var0.ref_14388 = 1;
  ref_13fac("ui_tactical_recharge_progress", var1, 1);
  var0.ref_14388 = 0;
  var0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var0, "secondary"), 1);

  if(race_get_next_checkpoint(var0, "secondary") < race_init(var0, "secondary")) {
    thread kill_furthest_enemy(var0, self);
    return;
  }

  var0 notify("restock_done");
}

function ref_13fac(var0, var1, var2) {
  self setclientomnvar("ui_recharge_notify", -1);
  var3 = gettime();
  var4 = var3 + var1 * 1000;
  var5 = gettime();

  while(var5 < var4) {
    while(istrue(self.inlaststand)) {
      self setclientomnvar("ui_recharge_notify", -1);
      self setclientomnvar(var0, 0);
      waitframe();
    }

    var5 = gettime();
    var6 = (var5 - var3) / (var4 - var3);
    self setclientomnvar(var0, var6);
    wait 0.1;
  }

  self setclientomnvar("ui_recharge_notify", var2);
  self setclientomnvar(var0, 0);
}

function ref_138c5(var0, var1) {
  self endon("death");
  level endon("game_ended");
  self endon("take_restock");
  self endon("restock_done");

  while(istrue(self.inlaststand) || race_get_next_checkpoint(self, var1) < race_init(self, var1)) {
    waitframe();
  }

  self notify("stop_restock_recharge");

  if(var1 == "primary") {
    self.ref_14387 = 0;
  } else {
    self.ref_14388 = 0;
  }

  self setclientomnvar("ui_recharge_notify", -1);
  self setclientomnvar(var0, 0);
}

function register_chopper_boss_combat_actions(var0, var1) {
  foreach(var3 in var0.powers) {
    if(var3.slot == var1) {
      return var3.weaponuse;
    }
  }
}

function race_is_player_driving_vehicle(var0, var1) {
  foreach(var3 in var0.powers) {
    if(var3.slot == var1) {
      return var4;
    }
  }
}

function race_get_next_checkpoint(var0, var1) {
  foreach(var3 in var0.powers) {
    if(var3.slot == var1) {
      return var3.charges;
    }
  }
}

function race_init(var0, var1) {
  foreach(var3 in var0.powers) {
    if(var3.slot == var1) {
      return var3.maxcharges;
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
  var0 = 0;

  while(var0 < 0.08) {
    self.movespeedscaler += 0.01;

    if(isDefined(level.move_speed_scale)) {
      self[[level.move_speed_scale]]();
    }

    wait 0.4375;
    var0 += 0.01;
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
    self waittill("weapon_change", var0);
    var1 = self getcurrentweapon();
    var2 = scripts\cp\utility::getrawbaseweaponname(var1);

    if(isDefined(var2)) {
      if(var2 == "nrg" || var2 == "zmagnum" || var2 == "zg18" || var2 == "emc") {
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

function removeperk(var0) {
  scripts\cp\utility::_unsetperk(var0);
  scripts\cp\utility::_unsetextraperks(var0);
}