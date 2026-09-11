/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\init_mp.gsc
***********************************************/

function init() {
  level.killstreaktriggeredfunc = &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered;
  level.killstreakbeginusefunc = &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse;
  level.killstreakfinishusefunc = &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakfinishuse;
  scripts\mp\killstreaks\killstreaks::initkillstreakdata();
  level.killstreaksetups = [];
  thread scripts\mp\killstreaks\target_marker::init();
  thread scripts\mp\killstreaks\mapselect::init();
  thread scripts\mp\killstreaks\throwback_marker::init();
  thread scripts\mp\killstreaks\helicopter::init();
  thread scripts\mp\killstreaks\deployablebox::init();
  thread scripts\mp\killstreaks\emp::init();
  thread scripts\mp\killstreaks\remotetank::init();
  thread scripts\mp\killstreaks\remoteturret::init();
  thread scripts\mp\killstreaks\hover_jet::init();
  thread scripts\mp\killstreaks\death_switch::init();
  thread _getequipmentammotomax::init();
  thread _handlekillstreakpurchase::init();
  thread _handlespecialpurchase::ref_12a27();
  thread _getplunderextractlocations::init();
  thread _getlocationscircleinfluencedwithnoise::init();
  thread _getrandomlocations::init();
  thread scripts\mp\killstreaks\supply_sweep::init();
  var0 = scripts\mp\utility\game::unset_relic_grounded() && getdvarint("scr_use_br_sentry_gun");
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "init", scripts\engine\utility::ter_op(istrue(var0), &_handlevehiclepurchase::init, &scripts\mp\killstreaks\sentry_gun_mp::init));
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "init", &scripts\mp\killstreaks\cruise_predator_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "init", &scripts\mp\killstreaks\airstrike_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "init", &scripts\mp\killstreaks\juggernaut_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "init", &scripts\mp\killstreaks\airdrop_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "init", &scripts\mp\killstreaks\airdrop_multiple_mp::airdrop_multiple_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "init", &scripts\mp\killstreaks\white_phosphorus_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "init", &scripts\mp\killstreaks\gunship_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "init", &scripts\mp\killstreaks\manual_turret_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "init", &scripts\mp\killstreaks\toma_strike_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "init", &scripts\mp\killstreaks\chopper_gunner_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "init", &scripts\mp\killstreaks\chopper_support_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "init", &scripts\mp\killstreaks\uav_mp::init_uav_mp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone", "init", &scripts\mp\killstreaks\emp_drone_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone_targeted", "init", &scripts\mp\killstreaks\emp_drone_targeted_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "init", &scripts\mp\killstreaks\helper_drone_mp::helper_drone_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "init", &_handlefieldupgradepurchase::init);
  level.killstreakweaponmap = [];
  level.killstreakweaponmap["nuke_mp"] = "nuke";
  level.killstreakweaponmap["airdrop_marker_mp"] = "airdrop";
  level.killstreakweaponmap["artillery_mp"] = "precision_airstrike";
  level.killstreakweaponmap["iw8_spotter_scope_mp"] = "precision_airstrike";
  level.killstreakweaponmap["iw8_spotter_scope_mp_ch3"] = "precision_airstrike";
  level.killstreakweaponmap["deploy_airdrop_mp"] = "airdrop";
  level.killstreakweaponmap["deploy_airdrop_mp_sticky"] = "airdrop";
  level.killstreakweaponmap["tacops_beacon_mp"] = "marker";
  level.killstreakweaponmap["cruise_proj_mp"] = "cruise_predator";
  level.killstreakweaponmap["manual_turret_mp"] = "manual_turret";
  level.killstreakweaponmap["pac_sentry_turret_mp"] = "pac_sentry";
  level.killstreakweaponmap["toma_proj_mp"] = "toma_strike";
  level.killstreakweaponmap["toma_proj_mp_x2"] = "toma_strike";
  level.killstreakweaponmap["iw8_green_beam_mp"] = "toma_strike";
  level.killstreakweaponmap["iw8_spotter_scope_mp_ch3"] = "toma_strike";
  level.killstreakweaponmap["apache_turret_mp"] = "chopper_gunner";
  level.killstreakweaponmap["apache_proj_mp"] = "chopper_gunner";
  level.killstreakweaponmap["lighttank_tur_ks_mp"] = "bradley";
  level.killstreakweaponmap["bradley_tow_proj_ks_mp"] = "bradley";
  level.killstreakweaponmap["radar_drone_proj_mp"] = "radar_drone_recon";
  level.killstreakweaponmap["ac130_25mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_40mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_105mm_mp"] = "gunship";
  level.killstreakweaponmap["ac130_proj_mp"] = "gunship";
  level.killstreakweaponmap["fuelstrike_proj_mp"] = "fuel_airstrike";
  level.killstreakweaponmap["chopper_support_turret_mp"] = "chopper_support";
  level.killstreakweaponmap["convoy_truck_turret_mp"] = "convoy_truck_turret_mp";
  level.killstreakweaponmap["sentry_turret_mp"] = "sentry_gun";
  level.killstreakweaponmap["white_phosphorus_proj_mp"] = "white_phosphorus";
  level.killstreakweaponmap["white_phosphorus_marker_mp"] = "white_phosphorus";
  level.killstreakweaponmap["hover_jet_turret_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_proj_mp"] = "hover_jet";
  level.killstreakweaponmap["iw8_minigunksjugg_mp"] = "juggernaut";
  level.killstreakweaponmap["iw8_minigunksjugg_reload_mp"] = "juggernaut";
  level.killstreakweaponmap["deploy_juggernaut_mp"] = "juggernaut";
  level.killstreakweaponmap["assault_drone_mp"] = "assault_drone";
  level.killstreakweaponmap["iw8_sn_t9explosivebow_mp"] = "explosive_bow";
  level.killstreakweaponmap["city_killer_mp"] = "city_killer";
  level.killstreakweaponmap["greenbay_strike"] = "greenbay_strike";
  level.killstreakweaponmap["kenosha_strike"] = "greenbay_strike";
  level.killstreakweaponmap["defense_turret_mp"] = "defense_turret";

  if(isDefined(level.mapcustomkillstreakfunc)) {
    [[level.mapcustomkillstreakfunc]]();
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    level.killstreakrounddelay = 0;
    level.killstreakweaponmap["sentry_turret_wz"] = "sentry_gun";
  } else {
    level.killstreakrounddelay = scripts\mp\utility\dvars::getintproperty("scr_game_killstreakdelay", 12);
  }

  level.killstreakactivatedtime = [];
  level thread scripts\mp\killstreaks\killstreaks::onplayerconnect();
  level thread scripts\mp\killstreaks\killstreaks::storescorestreakpointsongameend();
  scripts\mp\outofbounds::killstreakregisteroobcallbacks();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\mp\killstreaks\killstreaks::onplayerspawned);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&scripts\mp\killstreaks\killstreaks::listenkillstreakaction);
  level thread scripts\cp_mp\killstreaks\killstreakdeploy::onplayerconnect();
}