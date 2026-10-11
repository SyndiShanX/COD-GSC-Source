/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\init_cp.gsc
*************************************************/

#using script_17ca3af80f14ce7e;
#using script_2b283271ad65977c;
#using script_315ecb59881c4ff;
#using script_594f36ed3e71fda2;
#using scripts\common\callbacks;
#using scripts\cp\inventory\cp_target_marker;
#using scripts\cp\killstreaks\airdrop_cp;
#using scripts\cp\killstreaks\airdrop_multiple_cp;
#using scripts\cp\killstreaks\airstrike_cp;
#using scripts\cp\killstreaks\chopper_gunner_cp;
#using scripts\cp\killstreaks\chopper_support_cp;
#using scripts\cp\killstreaks\cruise_predator_cp;
#using scripts\cp\killstreaks\gunship_cp;
#using scripts\cp\killstreaks\helper_drone_cp;
#using scripts\cp\killstreaks\juggernaut_cp;
#using scripts\cp\killstreaks\sentry_gun_cp;
#using scripts\cp\killstreaks\toma_strike_cp;
#using scripts\cp\killstreaks\uav_cp;
#using scripts\cp\objective_trigger;
#using scripts\cp\utility;
#using scripts\cp_mp\killstreaks\assault_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\throwback_marker;
#namespace init_cp;

function init() {
  callback::add("killstreak_finish_use", &onkillstreakfinishuse);
  thread scripts\cp_mp\utility\dialog_utility::function_39dc350193dd4bc4();
  scripts\engine\utility::registersharedfunc("cluster_spike", "init", &namespace_4a3cae8a354ac02f::init);
  scripts\engine\utility::registersharedfunc("cruise_predator", "init", &scripts\cp\killstreaks\cruise_predator_cp::init);
  scripts\engine\utility::registersharedfunc("sentry_gun", "init", &scripts\cp\killstreaks\sentry_gun_cp::init);
  scripts\engine\utility::registersharedfunc("airstrike", "init", &scripts\cp\killstreaks\airstrike_cp::init);
  scripts\engine\utility::registersharedfunc("juggernaut", "init", &scripts\cp\killstreaks\juggernaut_cp::init);
  scripts\engine\utility::registersharedfunc("gunship", "init", &scripts\cp\killstreaks\gunship_cp::init);
  scripts\engine\utility::registersharedfunc("toma_strike", "init", &scripts\cp\killstreaks\toma_strike_cp::init);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "init", &scripts\cp\killstreaks\chopper_gunner_cp::init);
  scripts\engine\utility::registersharedfunc("chopper_support", "init", &scripts\cp\killstreaks\chopper_support_cp::init_chopper_support);
  scripts\engine\utility::registersharedfunc("uav", "init", &scripts\cp\killstreaks\uav_cp::init_uav_cp);
  scripts\engine\utility::registersharedfunc("helper_drone", "init", &scripts\cp\killstreaks\helper_drone_cp::helper_drone_init);
  scripts\engine\utility::registersharedfunc("hover_jet", "init", &namespace_2ad4bf452456e988::init);
  scripts\engine\utility::registersharedfunc("auto_drone", "init", &namespace_597d145ab41b7ffc::init);
  scripts\engine\utility::registersharedfunc("assault_drone", "init", &scripts\cp_mp\killstreaks\assault_drone::init);
  scripts\engine\utility::registersharedfunc("recon_drone", "init", &scripts\cp_mp\killstreaks\recon_drone::init);
  scripts\engine\utility::registersharedfunc("airdrop", "init", &scripts\cp\killstreaks\airdrop_cp::init);

  if(!scripts\cp\utility::function_240f7f4e57340e8f()) {
    scripts\engine\utility::registersharedfunc("airdrop_multiple", "init", &scripts\cp\killstreaks\airdrop_multiple_cp::airdrop_multiple_init);
  }

  thread scripts\cp\inventory\cp_target_marker::init();
  level thread scripts\mp\killstreaks\throwback_marker::init();
  namespace_1fdb557af4bcd29e::function_d1f0b7aa511a0();
  scripts\cp\objective_trigger::function_eadc517453265031();
  scripts\cp_mp\weapon::initkillstreakweaponmap();
  level.killstreakactivatedtime = [];
  level.non_detectable_killstreaks = ["iw8_spotter_scope_mp"];
}

function onkillstreakfinishuse(params) {
  streakinfo = params.streakinfo;
  streakinfo.owner notify("killstreak_use_finished", streakinfo.streakname);
}

function can_killstreak_be_detected(weaponobj) {
  if(scripts\engine\utility::array_contains(level.non_detectable_killstreaks, weaponobj.basename)) {
    return 0;
  }

  return 1;
}

function init_killstreak_data_for_challenges(streakinfo, streakname) {
  streakitem = spawnStruct();
  streakitem.streakname = streakname;
  streakinfo.mpstreaksysteminfo = streakitem;
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  return streakinfo;
}