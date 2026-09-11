/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\init_cp.gsc
***********************************************/

function init() {
  level.killstreakfinishusefunc = &onkillstreakfinishuse;
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "init", &scripts\cp\killstreaks\cruise_predator_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "init", &scripts\cp\killstreaks\sentry_gun_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "init", &scripts\cp\killstreaks\airstrike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "init", &scripts\cp\killstreaks\juggernaut_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "init", &scripts\cp\killstreaks\airdrop_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "init", &scripts\cp\killstreaks\airdrop_multiple_cp::airdrop_multiple_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "init", &scripts\cp\killstreaks\white_phosphorus_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "init", &scripts\cp\killstreaks\gunship_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "init", &scripts\cp\killstreaks\manual_turret_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "init", &scripts\cp\killstreaks\toma_strike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "init", &scripts\cp\killstreaks\chopper_gunner_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "init", &scripts\cp\killstreaks\chopper_support_cp::init_chopper_support);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "init", &scripts\cp\killstreaks\uav_cp::init_uav_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone", "init", &scripts\cp\killstreaks\emp_drone_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "init", &scripts\cp\killstreaks\helper_drone_cp::helper_drone_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "init", &scripts\mp\trials\trial_target_utility::init);
  thread scripts\cp\inventory\cp_target_marker::init();
  level thread scripts\mp\killstreaks\throwback_marker::init();
  level.killstreakweaponmap = [];
  level.killstreakweaponmap["nuke_mp"] = "nuke";
  level.killstreakweaponmap["airdrop_marker_mp"] = "airdrop";
  level.killstreakweaponmap["artillery_mp"] = "precision_airstrike";
  level.killstreakweaponmap["iw8_spotter_scope_mp"] = "precision_airstrike";
  level.killstreakweaponmap["deploy_airdrop_mp"] = "airdrop";
  level.killstreakweaponmap["deploy_airdrop_mp_sticky"] = "airdrop";
  level.killstreakweaponmap["tacops_beacon_mp"] = "marker";
  level.killstreakweaponmap["cruise_proj_mp"] = "cruise_predator";
  level.killstreakweaponmap["manual_turret_mp"] = "manual_turret";
  level.killstreakweaponmap["pac_sentry_turret_mp"] = "pac_sentry";
  level.killstreakweaponmap["toma_proj_mp"] = "toma_strike";
  level.killstreakweaponmap["iw8_green_beam_mp"] = "toma_strike";
  level.killstreakweaponmap["apache_turret_mp"] = "chopper_gunner";
  level.killstreakweaponmap["apache_proj_mp"] = "chopper_gunner";
  level.killstreakweaponmap["lighttank_mp"] = "bradley";
  level.killstreakweaponmap["lighttank_tur_mp"] = "bradley";
  level.killstreakweaponmap["bradley_tow_proj_mp"] = "bradley";
  level.killstreakweaponmap["radar_drone_proj_mp"] = "radar_drone_recon";
  level.killstreakweaponmap["ac130_25mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_40mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_105mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_proj_mp"] = "gunship";
  level.killstreakweaponmap["fuelstrike_proj_mp"] = "fuel_airstrike";
  level.killstreakweaponmap["chopper_support_turret_mp"] = "chopper_support";
  level.killstreakweaponmap["sentry_turret_mp"] = "sentry_gun";
  level.killstreakweaponmap["white_phosphorus_proj_mp"] = "white_phosphorus";
  level.killstreakweaponmap["white_phosphorus_marker_mp"] = "white_phosphorus";
  level.killstreakweaponmap["hover_jet_turret_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_proj_mp"] = "hover_jet";
  level.killstreakweaponmap["iw8_minigunksjugg_mp"] = "juggernaut";
  level.killstreakweaponmap["deploy_juggernaut_mp"] = "juggernaut";
  level.ref_11eaf = ["iw8_spotter_scope_mp"];
}

function onkillstreakfinishuse(var0) {
  if(var0.streakname == "gunship") {
    if(isDefined(var0.owner)) {
      var0.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
      return;
    }

    return;
  }
}

function gastrap_dmg_trig(var0) {
  if(scripts\engine\utility::array_contains(level.ref_11eaf, var0.basename)) {
    return 0;
  }

  return 1;
}