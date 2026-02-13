/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2637.gsc
*************************************************/

init() {
  level._id_8DEB = scripts\mp\killstreaks\killstreaks::_id_EA0C;
  level._id_8DC6 = scripts\mp\killstreaks\killstreaks::_id_EA0A;
  level._id_8DD3 = scripts\mp\killstreaks\killstreaks::_id_EA0B;
  scripts\mp\killstreaks\killstreaks::_id_8205();
  level._id_8DE6 = [];
  thread _id_0A61::init();
  thread _id_0A54::init();
  thread _id_0A62::init();
  thread scripts\mp\killstreaks\helicopter::init();
  thread _id_0A59::init();
  thread _id_0A3C::init();
  thread _id_0A40::init();
  thread _id_0A56::init();
  thread _id_0A5C::init();
  thread _id_0A5D::init();
  thread _id_0A4C::init();
  thread _id_0A3B::init();
  thread _id_0A2B::init();
  thread _id_0A65::init();
  thread _id_0A29::init();
  thread _id_0A33::_id_7EF5();
  thread _id_0A60::init();
  thread _id_0A3E::_id_7EBF();
  thread _id_0A57::init();
  thread _id_0A66::init();
  thread _id_0A2F::init();
  thread _id_0A55::init();
  thread _id_0A43::init();
  thread _id_0A52::init();
  thread _id_0A4E::_id_831B();
  thread scripts\mp\agents\krampus\s4_krampus::init();
  thread scripts\mp\agents\elf\s4_mp_codmas_elf::init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("glide_bomb", "init", _id_0A45::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "init", _id_0A5F::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "init", _id_0A32::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "init", _id_0A50::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "init", _id_0A30::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "init", _id_0A31::_id_138E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "init", _id_0A67::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ball_turret_gunner", "init", _id_0A36::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "init", _id_0A53::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "init", _id_0A63::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "init", _id_0A38::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "init", _id_0A39::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "init", _id_0A64::_id_80EC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone", "init", _id_0A41::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone_targeted", "init", _id_0A42::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "init", _id_0A4B::_id_7819);
  scripts\cp_mp\utility\script_utility::registersharedfunc("warmachine", "init", _id_0A66::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("intel", "init", _id_0A4E::_id_831B);
  level._id_8DEE = [];
  level._id_8DEE["s4_v2_mp"] = "nuke";
  level._id_8DEE["airdrop_marker_mp"] = "airdrop";
  level._id_8DEE["s4_strafing_run_mp"] = "precision_airstrike";
  level._id_8DEE["s4_binoculars_mp"] = "precision_airstrike";
  level._id_8DEE["s4_deploy_airdrop_mp"] = "airdrop";
  level._id_8DEE["deploy_airdrop_mp_sticky"] = "airdrop";
  level._id_8DEE["tacops_beacon_mp"] = "marker";
  level._id_8DEE["cruise_proj_mp"] = "cruise_predator";
  level._id_8DEE["manual_turret_mp"] = "manual_turret";
  level._id_8DEE["pac_sentry_turret_mp"] = "pac_sentry";
  level._id_8DEE["s4_ks_ord_ger_mp"] = "toma_strike";
  level._id_8DEE["iw8_green_beam_mp"] = "toma_strike";
  level._id_8DEE["apache_turret_mp"] = "chopper_gunner";
  level._id_8DEE["apache_proj_mp"] = "chopper_gunner";
  level._id_8DEE["lighttank_tur_ks_mp"] = "bradley";
  level._id_8DEE["bradley_tow_proj_ks_mp"] = "bradley";
  level._id_8DEE["radar_drone_proj_mp"] = "radar_drone_recon";
  level._id_8DEE["ac130_25mm_mp"] = "gunship";
  level._id_8DEE["ac130_40mm_mp"] = "gunship";
  level._id_8DEE["ac130_105mm_mp"] = "gunship";
  level._id_8DEE["ac130_proj_mp"] = "gunship";
  level._id_8DEE["fuelstrike_proj_mp"] = "fuel_airstrike";
  level._id_8DEE["chopper_support_turret_mp"] = "chopper_support";
  level._id_8DEE["sentry_turret_mp"] = "sentry_gun";
  level._id_8DEE["white_phosphorus_marker_mp"] = "white_phosphorus";
  level._id_8DEE["hover_jet_turret_mp"] = "hover_jet";
  level._id_8DEE["hover_jet_proj_mp"] = "hover_jet";
  level._id_8DEE["s4_gw_flima35_mp"] = "juggernaut";
  level._id_8DEE["s4_ks_deploy_flamenaut_mp"] = "juggernaut";
  level._id_8DEE["s4_airstrike_bomb_mp"] = "s2_airstrike";
  level._id_8DEE["s4_bombing_run_strike_mp"] = "toma_strike";
  level._id_8DEE["s4_la_walpha2_mp"] = "warmachine";
  level._id_8DEE["s4_mg_streak_mp"] = "lmg_streak";
  level._id_8DEE["s4_ks_dog_bite_mp"] = "attack_dogs";
  level._id_8DEE["s4_ks_mortar_mp"] = "mortar_barrage";
  level._id_8DEE["s4_ks_flare_canister_mp"] = "mortar_barrage";
  level._id_8DEE["s4_ks_tw_ball_turret_gunner_mp"] = "ball_turret_gunner";
  level._id_8DEE["s4_glidebomb_fromeo_mp"] = "glide_bomb";
  level._id_8DEE["s4_firebombing_run_mp"] = "white_phosphorus";

  if(isDefined(level._id_9AB4)) {
    [[level._id_9AB4]]();
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    level._id_8DE2 = 0;
  } else {
    level._id_8DE2 = scripts\mp\utility\dvars::_id_6AC8("#x32e749a3e3f8f6085", 12);
  }

  level._id_8DC5 = [];
  level thread scripts\mp\killstreaks\killstreaks::onplayerconnect();
  level thread scripts\mp\killstreaks\killstreaks::_id_E9CC();
  scripts\mp\outofbounds::_id_8DE1();
  _id_0AA3::_id_C28D(scripts\mp\killstreaks\killstreaks::onplayerspawned);
  _id_0A9A::_id_C287(scripts\mp\killstreaks\killstreaks::_id_9551);
  level thread _id_09B9::onplayerconnect();
}