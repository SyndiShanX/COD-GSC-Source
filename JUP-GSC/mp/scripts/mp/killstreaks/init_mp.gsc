/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\init_mp.gsc
*************************************************/

#using script_2f5a7fde37cb4ee8;
#using script_368c8ef99587dfe3;
#using script_594aedcdfa46e3d7;
#using script_6041bc662a0442e;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\airdrop_mp;
#using scripts\mp\killstreaks\airdrop_multiple_mp;
#using scripts\mp\killstreaks\airstrike_mp;
#using scripts\mp\killstreaks\auto_drone_mp;
#using scripts\mp\killstreaks\chopper_gunner_mp;
#using scripts\mp\killstreaks\chopper_support_mp;
#using scripts\mp\killstreaks\circle_peek;
#using scripts\mp\killstreaks\cluster_spike_mp;
#using scripts\mp\killstreaks\cruise_predator_mp;
#using scripts\mp\killstreaks\death_switch;
#using scripts\mp\killstreaks\deployablebox;
#using scripts\mp\killstreaks\emp_drone_mp;
#using scripts\mp\killstreaks\emp_drone_targeted_mp;
#using scripts\mp\killstreaks\gunship_mp;
#using scripts\mp\killstreaks\helicopter;
#using scripts\mp\killstreaks\helper_drone_mp;
#using scripts\mp\killstreaks\juggernaut_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\manual_turret_mp;
#using scripts\mp\killstreaks\mapselect;
#using scripts\mp\killstreaks\nuke_mp;
#using scripts\mp\killstreaks\remotetank;
#using scripts\mp\killstreaks\remoteturret;
#using scripts\mp\killstreaks\sentry_gun_mp;
#using scripts\mp\killstreaks\target_marker;
#using scripts\mp\killstreaks\throwback_marker;
#using scripts\mp\killstreaks\toma_strike_mp;
#using scripts\mp\killstreaks\uav_mp;
#using scripts\mp\killstreaks\white_phosphorus_mp;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace init_mp;

function init() {
  level.killstreaktriggeredfunc = &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered;
  level.killstreakbeginusefunc = &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse;
  callback::add("killstreak_finish_use", &scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakfinishuse);
  initkillstreakdata();

  if(!isDefined(level.killstreaksetups)) {
    level.killstreaksetups = [];
  }

  thread scripts\mp\killstreaks\target_marker::init();
  thread scripts\mp\killstreaks\mapselect::init();
  thread scripts\mp\killstreaks\throwback_marker::init();
  thread scripts\mp\killstreaks\helicopter::init();

  if(getdvarint(@ "hash_41e841cf6efad236", 0) || isjuggermoshgamemode()) {
    thread namespace_f280858cfad8e545::init();
  }

  thread scripts\mp\killstreaks\deployablebox::init();
  thread scripts\mp\killstreaks\remotetank::init();
  thread scripts\mp\killstreaks\remoteturret::init();
  thread scripts\mp\killstreaks\death_switch::init();
  thread scripts\mp\killstreaks\circle_peek::init();
  thread scripts\cp_mp\utility\dialog_utility::function_39dc350193dd4bc4();
  scripts\engine\utility::registersharedfunc("cruise_predator", "init", &scripts\mp\killstreaks\cruise_predator_mp::init);
  scripts\engine\utility::registersharedfunc("sentry_gun", "init", &scripts\mp\killstreaks\sentry_gun_mp::init);
  scripts\engine\utility::registersharedfunc("airstrike", "init", &scripts\mp\killstreaks\airstrike_mp::init);
  scripts\engine\utility::registersharedfunc("juggernaut", "init", &scripts\mp\killstreaks\juggernaut_mp::init);
  scripts\engine\utility::registersharedfunc("airdrop", "init", &scripts\mp\killstreaks\airdrop_mp::init);
  scripts\engine\utility::registersharedfunc("airdrop_multiple", "init", &scripts\mp\killstreaks\airdrop_multiple_mp::airdrop_multiple_init);
  scripts\engine\utility::registersharedfunc("airdrop_escort", "init", &namespace_cf330d307304e7fc::function_f383491974a17b9a);
  scripts\engine\utility::registersharedfunc("white_phosphorus", "init", &scripts\mp\killstreaks\white_phosphorus_mp::init);
  scripts\engine\utility::registersharedfunc("gunship", "init", &scripts\mp\killstreaks\gunship_mp::init);
  scripts\engine\utility::registersharedfunc("manual_turret", "init", &scripts\mp\killstreaks\manual_turret_mp::init);
  scripts\engine\utility::registersharedfunc("toma_strike", "init", &scripts\mp\killstreaks\toma_strike_mp::init);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "init", &scripts\mp\killstreaks\chopper_gunner_mp::init);
  scripts\engine\utility::registersharedfunc("chopper_support", "init", &scripts\mp\killstreaks\chopper_support_mp::init);
  scripts\engine\utility::registersharedfunc("uav", "init", &scripts\mp\killstreaks\uav_mp::init_uav_mp);
  scripts\engine\utility::registersharedfunc("uav_bigmap", "init", &namespace_9e7b04da80a97ce9::init);
  scripts\engine\utility::registersharedfunc("emp_drone", "init", &scripts\mp\killstreaks\emp_drone_mp::init);
  scripts\engine\utility::registersharedfunc("emp_drone_targeted", "init", &scripts\mp\killstreaks\emp_drone_targeted_mp::init);
  scripts\engine\utility::registersharedfunc("helper_drone", "init", &scripts\mp\killstreaks\helper_drone_mp::helper_drone_init);
  scripts\engine\utility::registersharedfunc("nuke", "init", &scripts\mp\killstreaks\nuke_mp::init);
  scripts\engine\utility::registersharedfunc("hover_jet", "init", &namespace_3f6c2ec2b6aeead8::init);
  scripts\engine\utility::registersharedfunc("auto_drone", "init", &scripts\mp\killstreaks\auto_drone_mp::init);
  scripts\engine\utility::registersharedfunc("cluster_spike", "init", &scripts\mp\killstreaks\cluster_spike_mp::init);
  function_b4b623b6321cd521();

  if(isDefined(level.mapcustomkillstreakfunc)) {
    [[level.mapcustomkillstreakfunc]]();
  }

  level.killstreakrounddelay = getintproperty(@ "hash_336f868b4d4b223", 12);
  level.killstreakactivatedtime = [];

  if(function_f24e99a2f548d0b8() && getdvarint(@ "hash_4d5bd224f3f2f0bf", 1)) {
    level.var_44815c2275fee420 = 1;
    killstreak1 = getDvar(@ "hash_328d09718871cea9", "none");
    killstreak2 = getDvar(@ "hash_328d06718871c810", "uav");
    killstreak3 = getDvar(@ "hash_328d07718871ca43", "directional_uav");
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 1), killstreak1);
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 2), killstreak2);
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 3), killstreak3);
  }

  if(ismutationgamemode() && getdvarint(@ "hash_52510a23c3e3de3c", 1)) {
    level.var_44815c2275fee420 = 1;
    killstreak1 = getDvar(@ "hash_a534c1c236717066", "fuel_airstrike");
    killstreak2 = getDvar(@ "hash_a534c0c236716e33", "remote_turret");
    killstreak3 = getDvar(@ "hash_a534bfc236716c00", "juggernaut");
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 1), killstreak1);
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 2), killstreak2);
    setDvar(hashcat(@ "hash_7129c8b31055dff8", 3), killstreak3);
  }

  if(!isDefined(level.var_44815c2275fee420)) {
    level.var_44815c2275fee420 = getdvarint(@ "hash_daa203ef7cfc6ee2", 0);
  }

  level thread scripts\mp\killstreaks\killstreaks::onplayerconnect();
  level thread scripts\mp\killstreaks\killstreaks::storescorestreakpointsongameend();
  scripts\mp\outofbounds::killstreakregisteroobcallbacks();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\mp\killstreaks\killstreaks::onplayerspawned);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&scripts\mp\killstreaks\killstreaks::listenkillstreakaction);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&scripts\mp\killstreaks\killstreaks::function_c2861bf9018ab964);
  level thread function_29e99a60706e08b1();

  setdevdvarifuninitialized(@ "hash_2c01d701bac5d9d3", 0);
  setdevdvarifuninitialized(@ "hash_698613e6c8c52243", 0);
}