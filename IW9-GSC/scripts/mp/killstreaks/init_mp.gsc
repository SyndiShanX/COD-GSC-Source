/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\init_mp.gsc
***********************************************/

init() {
  level.killstreaktriggeredfunc = scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered;
  level.killstreakbeginusefunc = scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse;
  level.killstreakfinishusefunc = scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakfinishuse;
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
  thread scripts\mp\killstreaks\death_switch::init();
  thread _id_46DA2115D89395CA::init();
  thread scripts\cp_mp\utility\dialog_utility::_id_39DC350193DD4BC4();
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "init", scripts\mp\killstreaks\cruise_predator_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sentry_gun", "init", scripts\mp\killstreaks\sentry_gun_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airstrike", "init", scripts\mp\killstreaks\airstrike_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("juggernaut", "init", scripts\mp\killstreaks\juggernaut_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "init", scripts\mp\killstreaks\airdrop_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_multiple", "init", scripts\mp\killstreaks\airdrop_multiple_mp::airdrop_multiple_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_escort", "init", _id_06041BC662A0442E::_id_F383491974A17B9A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "init", scripts\mp\killstreaks\white_phosphorus_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "init", scripts\mp\killstreaks\gunship_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("manual_turret", "init", scripts\mp\killstreaks\manual_turret_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "init", scripts\mp\killstreaks\toma_strike_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "init", scripts\mp\killstreaks\chopper_gunner_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "init", scripts\mp\killstreaks\chopper_support_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "init", scripts\mp\killstreaks\uav_mp::init_uav_mp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav_bigmap", "init", _id_594AEDCDFA46E3D7::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone", "init", scripts\mp\killstreaks\emp_drone_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp_drone_targeted", "init", scripts\mp\killstreaks\emp_drone_targeted_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "init", scripts\mp\killstreaks\helper_drone_mp::helper_drone_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "init", scripts\mp\killstreaks\nuke_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "init", _id_2F5A7FDE37CB4EE8::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("auto_drone", "init", _id_51A20FBAC8B22816::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cluster_spike", "init", _id_62172000A46A1193::init);
  _id_2669878CF5A1B6BC::_id_B4B623B6321CD521();

  if(isDefined(level.mapcustomkillstreakfunc))
    [[level.mapcustomkillstreakfunc]]();

  level.killstreakrounddelay = scripts\mp\utility\dvars::getintproperty("scr_game_killstreakdelay", 12);
  level.killstreakactivatedtime = [];
  level thread scripts\mp\killstreaks\killstreaks::onplayerconnect();
  level thread scripts\mp\killstreaks\killstreaks::storescorestreakpointsongameend();
  scripts\mp\outofbounds::killstreakregisteroobcallbacks();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\mp\killstreaks\killstreaks::onplayerspawned);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\mp\killstreaks\killstreaks::listenkillstreakaction);
  level thread scripts\mp\killstreaks\killstreaks::_id_29E99A60706E08B1();
}