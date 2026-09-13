/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\init_cp.gsc
***********************************************/

init() {
  level.killstreakfinishusefunc = ::onkillstreakfinishuse;
  thread scripts\cp_mp\utility\dialog_utility::_id_39DC350193DD4BC4();
  scripts\cp_mp\utility\script_utility::registersharedfunc("cluster_spike", "init", _id_0315ECB59881C4FF::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "init", scripts\cp\killstreaks\cruise_predator_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "init", scripts\cp\killstreaks\sentry_gun_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "init", scripts\cp\killstreaks\airstrike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "init", scripts\cp\killstreaks\juggernaut_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "init", scripts\cp\killstreaks\airdrop_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "init", scripts\cp\killstreaks\airdrop_multiple_cp::airdrop_multiple_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "init", scripts\cp\killstreaks\white_phosphorus_cp::init_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "init", scripts\cp\killstreaks\gunship_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "init", scripts\cp\killstreaks\manual_turret_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "init", scripts\cp\killstreaks\toma_strike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "init", scripts\cp\killstreaks\chopper_gunner_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "init", scripts\cp\killstreaks\chopper_support_cp::init_chopper_support);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "init", scripts\cp\killstreaks\uav_cp::init_uav_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone", "init", scripts\cp\killstreaks\emp_drone_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "init", scripts\cp\killstreaks\helper_drone_cp::helper_drone_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "init", scripts\cp\killstreaks\nuke_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "init", _id_2B283271AD65977C::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("auto_drone", "init", _id_594F36ED3E71FDA2::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("assault_drone", "init", _id_249F45D992AF1114::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("recon_drone", "init", _id_6D68CFDF0836123C::init);
  thread scripts\cp\inventory\cp_target_marker::init();
  level thread scripts\mp\killstreaks\throwback_marker::init();
  _id_17CA3AF80F14CE7E::_id_000D1F0B7AA511A0();
  _id_476B6443E3798F5E::_id_EADC517453265031();
  _id_2669878CF5A1B6BC::_id_B4B623B6321CD521();
  level.killstreakactivatedtime = [];
  level.non_detectable_killstreaks = ["iw8_spotter_scope_mp"];
}

onkillstreakfinishuse(_id_70437D3C1365EC0C) {}

can_killstreak_be_detected(weaponobj) {
  if(scripts\engine\utility::array_contains(level.non_detectable_killstreaks, weaponobj.basename))
    return 0;
  else
    return 1;
}

init_killstreak_data_for_challenges(streakinfo, streakname) {
  _id_16EFCF27E6EFCBE8 = spawnStruct();
  _id_16EFCF27E6EFCBE8.streakname = streakname;
  streakinfo.mpstreaksysteminfo = _id_16EFCF27E6EFCBE8;
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  return streakinfo;
}