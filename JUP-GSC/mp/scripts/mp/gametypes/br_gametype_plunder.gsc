/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_plunder.gsc
***********************************************************/

#using script_21c19cfc7139d773;
#using script_2d9d24f7c63ac143;
#using script_5bab271917698dc4;
#using script_5e7a036feaf4f8b7;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_c130airdrop;
#using scripts\mp\gametypes\br_gametype_plunder;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootchopper;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_gametype_plunder;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_plunder::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("dropbag");

  if(getdvarint(@ "hash_fe3afd6ead4aa523", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("teamSpectate");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::disablefeature("oneLife");
  scripts\mp\gametypes\br_gametypes::disablefeature("kioskXP");

  if(getdvarint(@ "hash_d507d3832769e0d7", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("kiosk");
  }

  if(getdvarint(@ "hash_df75008333710e55", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("infilParachuteVfx");
  function_597185764a5679f4();
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerShouldRespawn", &playershouldrespawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &playerwelcomesplashes);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("spawnHandled", &spawnhandled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPickupTakenIntoBackpack", &onpickuptakenintobackpack);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", &markplayeraseliminatedonkilled);

  if(!scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("lootAllowedInBackpack")) {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("lootAllowedInBackpack", &lootallowedinbackpack);
  }

  scripts\engine\utility::registersharedfunc("plunder", "packClientMatchData", &packclientmatchdata);
  scripts\engine\utility::registersharedfunc("plunder", "getPlunderExtractLocations", &_getplunderextractlocations);
  level.teamplunderscoremechanic = getdvarint(@ "hash_1a7a6d4ee3338761", 0);
  level.brgametype.maxextractions = getdvarint(@ "hash_b6a790d232323e81", 5);
  level.brgametype.numextractions = 0;
  level.brgametype.firstteam = "tie";
  level.brgametype.var_be0c10911fec189f = 1;
  level.brgametype.var_98ade9e8627af484 = 1;
  level.br_prematchffa = 0;
  level.topteamsever = [];
  level.lootleaders = [];
  level.expiredlootleaders = [];
  level.called50percentprogress = 0;
  level.called75percentprogress = 0;
  level.called90percentprogress = 0;
  level.dontendonscore = 1;
  scorelimit = getdvarint(@ "hash_a07d25d87bb595de", 1000);

  if(scorelimit > 0) {
    scorelimit *= 10;
    scorelimit *= 100;
    setDvar(@ "hash_163241713430bfed", scorelimit);
    registerscorelimitdvar(getgametype(), scorelimit);
  }

  setDvar(@ "hash_da4f64f6eb4d97da", 3);
  setDvar(@ "scr_br_loadout_option", "nothing");
  setdvarifuninitialized(@ "scr_br_respawnmaxteammateoffset", 12000);
  setomnvar("ui_br_circle_state", 4);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  setdvarifuninitialized(@ "hash_bbb179520c2c4a14", 1);
  level.giveloadouteverytime = getdvarint(@ "hash_2efff4c3f474f5c7", 1);
  level.instantbleedoutsquadwipe = getdvarint(@ "hash_c6acab01f606ff92", 1);
  level.bottompercentagetoadjusteconomy = getdvarint(@ "hash_55e51828a59c2c5b", 50);
  level.toppercentagetoadjusteconomy = getdvarint(@ "hash_a1970e3c66611a73", 5);
  level.usemilestonephases = getdvarint(@ "hash_d7a5882fe16d92e3", 1);
  level.milestonephasepercent_vips = getdvarint(@ "hash_59cba3276a3a96c6", 10);
  level.milestonephasepercent_lzs = getdvarint(@ "hash_7fdccbee87a1ff6d", 30);
  level.milestonephasepercent_drops = getdvarint(@ "hash_d6ab3431e584ead8", 50);
  level.milestonephasepercent_helis = getdvarint(@ "hash_beac4d91ad3af5d7", 75);
  level.airdropbasecashamount = getdvarint(@ "hash_f21f22782971c2ac", 750);
  level.hideplacementuntilpercent = getdvarint(@ "hash_bfb818fa6a83f7d2", 10);
  level.hideleaderhashuntilpercent = getdvarint(@ "hash_c124a7a4afb14348", 0);
  level.showplacementsplashesandmusic = getdvarint(@ "hash_63908c5e06402524", 1);
  level.secondsbeforeplacementupdates = getdvarint(@ "hash_e616cb0e727859dd", 60);
  level.disablepercentageannouncements = getdvarint(@ "hash_69e6435403e5c322", 0);
  level.var_29af3a470e92b6e1 = getdvarint(@ "hash_50c18d3651edf35d", 0);
  level.lootleadermarkcount = getdvarint(@ "scr_plunder_loot_leader_mark_count", 3);
  level.maxlootleadermarkcount = getdvarint(@ "scr_plunder_loot_leader_mark_count", 3);
  level.lootleadermarksize = getdvarint(@ "hash_1650346812659df2", 5000);
  level.lootleaderoneperteam = getdvarint(@ "hash_5fd1126ec81d6b0b", 1) == 1;
  level.lootleadermarksizedynamic = getdvarint(@ "hash_1b7554a04b02683c", 1);
  level.lootleadermarkstrongsize = getdvarint(@ "hash_210471fb05950431", 2000);
  level.lootleadermarkstrongvalue = getdvarint(@ "hash_f53e6f6fddbbbc11", 5000);
  level.lootleadermarkweaksize = getdvarint(@ "hash_fc8b22a888365974", 5000);
  level.lootleadermarkweakvalue = getdvarint(@ "hash_43d67f5054412e02", 1000);
  level.expiredlootleaderenabled = getdvarint(@ "hash_a88980519c8d01b6", 0) == 1;
  level.lootleadermarksontopteams = getdvarint(@ "scr_plunder_loot_leader_mark_top_teams", 2);
  level.plundermusicfirst = getdvarfloat(@ "hash_24c7c305d1ead986", 0.3);
  level.plundermusicsecond = getdvarfloat(@ "hash_3f1f73f0aeec8fd4", 0.5);
  level.plundermusicthird = getdvarfloat(@ "hash_25360b6a507d1e21", 0.75);
  level.plundermusicfourth = getdvarfloat(@ "hash_11b704eda4d01a78", 0.9);
  level.useautorespawn = getdvarint(@ "hash_9ea6558e3fdc02d8", 1);
  level.autorespawnwaittime = getdvarint(@ "hash_4beac336193a373d", 20);
  level.tokenrespawnwaittime = getdvarint(@ "hash_728cba7a2adc64db", level.autorespawnwaittime);
  level.incrementalrespawnpunish = getdvarint(@ "hash_fc3a0f4f0cdd615e", 0);
  level.incrementalrespawnpunishmax = getdvarfloat(@ "hash_5eb645f42926f53b", 15);
  level.respawnheightoverride = getdvarint(@ "scr_plunder_respawnheightoverride", 6000);
  level.respawntimedisable = getdvarint(@ "hash_73dbc19ad4c85d57", 0);
  level.parachutedeploydelay = getdvarfloat(@ "hash_12027360b079c1db", 1.5);
  level.bonusdeathplunder = getdvarint(@ "hash_d8ce253f7d3b81ff", 400);
  level.bonusdeathplunderot = getdvarint(@ "hash_8d7f79a8e24f83cb", 800);
  level.maxplunderdropondeath = getdvarint(@ "hash_39f9da18bb66e22a", 20000);
  level.minplunderdropondeath = getdvarint(@ "hash_e0a487b88d0e4410", 400);
  level.percentageplunderdrop = getdvarint(@ "hash_efd614d3ef385a53", 50);
  level.var_b5bc63fa8162fce0 = getdvarint(@ "hash_4e0de97531d62635", 25);
  level.plunderfxondropthreashold = getdvarint(@ "hash_9421b492cb2d2db8", 1500);
  level.maxplunderdropinovertime = getdvarint(@ "hash_f9a79b878dee90d", 20000);
  level.executioncashmultiplier = getdvarfloat(@ "scr_plunder_executioncashmultiplier", 1);
  level.autoassignfirstquest = getdvarint(@ "hash_4a06e0523640f8fa", 0);
  level.quest_domdistmin = getdvarint(@ "hash_ad5a509fceccdbca", 5000);
  level.quest_domdistmax = getdvarint(@ "hash_ad7d5a9fcef33980", 10000);
  level.quest_assdistmin = getdvarint(@ "hash_f976a86d8da6cc4d", 2500);
  level.quest_assdistmax = getdvarint(@ "hash_f952926d8d7e2133", 7500);
  level.quest_scavdistmin = getdvarint(@ "hash_f6aa125a8f31d115", 5000);
  level.quest_scavdistmax = getdvarint(@ "hash_f6cdfc5a8f5a1b6b", 8000);
  level.quest_secretdistmin = getdvarint(@ "hash_f6aa125a8f31d115", 5000);
  level.quest_secretdistmax = getdvarint(@ "hash_f6cdfc5a8f5a1b6b", 8000);
  level.tabletreplacefrequency = getdvarfloat(@ "hash_b72a5778b96923f9", 1.5);
  level.skipweapondropondeath = getdvarint(@ "hash_8d982a8e8331b9f7", 0);
  level.skipequipmentdropondeath = getdvarint(@ "hash_370fb0965baf2ad5", 1);
  level.allowfultondropondeath = getdvarint(@ "hash_9250bef0872b6dfd", 1);
  level.teamplunderexfil = getdvarint(@ "hash_53675cdab06dbcf5", 0) == 1;
  level.teamplunderexfilshowviponly = getdvarint(@ "hash_7a6732d6b24b1690", 0) == 1;
  level.teamplunderexfilvipuav = getdvarint(@ "hash_efe218d17bdae2fd", 0) == 1;
  level.teamplunderexfiltimer = getdvarint(@ "hash_c655a0b01b13910a", 180);
  level.showplunderextracticonsinworld = getdvarint(@ "hash_25741495f8eabdbe", 1) == 1;
  level.shownonscriptableextracticons = getdvarint(@ "hash_9f64abb53e8eb4f5", 0);
  level.timeoutplunderextractionsites = getdvarint(@ "hash_1908e4e2a813777f", 0);
  level.moveplunderextractionsitesonuse = getdvarint(@ "hash_e5556c731830e8a", 0) == 1;
  level.extractplunderhelihealth = int(getdvarint(@ "hash_4806b7415b66c1b5", 999) * 100);
  level.extractplunderheliinvulnerable = getdvarint(@ "hash_9126054077cbefac", 1);
  level.bankplunderextractinstantly = getdvarint(@ "hash_96c1cdc24f5c05ae", 1);
  level.plunderextractalertnearby = getdvarint(@ "hash_2878716b2c2faf01", 1);
  level.matchstartextractsitedelay = getdvarint(@ "hash_33b1cb6fd6a90efd", 120);
  level.hideallunselectedextractpads = getdvarint(@ "hash_ea045e50c8947e0f", 1);
  level.setupevenlydistributedpads = ter_op(getDvar(@ "mapname") == "mp_br_mechanics", 0, getdvarint(@ "hash_25feb62305248c26", 1));
  level.scorerequiresbanking = getdvarint(@ "hash_2bc34d5113d02622", 0);
  level.disablewinonscore = getdvarint(@ "hash_1bcb79588e18be26", 0);
  level.doendofmatchotsequence = getdvarint(@ "hash_c567928926183d31", 180);
  level.setallclientomnvarot = level.doendofmatchotsequence > 0;
  level.overtimebuiltintomatchtimer = getdvarint(@ "hash_6c0f2aa1bb3e2b02", 1);
  level.bankingoverlimitwillendot = getdvarint(@ "hash_5406c1b726ff327c", 0);
  level.mapedgeextractionlocs = getdvarint(@ "hash_da53957720737131", 0);
  level.modespawnendofgame = &playerspawnendofgame;
  level.endmatchcameratransitions = getdvarint(@ "hash_ec4443371f0f6367", 1);
  level.overtimecashmultiplier = getdvarfloat(@ "hash_b236ecb84f9d1953", 2);
  setomnvar("ui_br_overtime_cash_multiplier", level.overtimecashmultiplier);
  level.disableonemilannounce = getdvarint(@ "hash_b94883083ec8eb80", 0);
  level.dmzlootleaderupdateonpickup = getdvarint(@ "hash_9efdb377e7ae2dff", 0) == 1;
  level.dmzwincost = getdvarint(@ "hash_a07d25d87bb595de", 1000) * 10;
  level.dmzextractcost = getdvarint(@ "hash_5cb48fb038ec819f", 300);
  level.dmzminextractcost = getdvarint(@ "hash_2c2d8ae182cf1fc", 40);
  level.dmzextractcostdecrease = getdvarint(@ "hash_27a4ecc9aa9f8224", 20);
  level.minplunderextractions = getdvarint(@ "hash_eaacc4689dd5d721", 7);
  level.maxplunderextractions = getdvarint(@ "hash_23f4eae3aeebefd3", 7);
  level.var_ad5e78c78f492751 = getdvarint(@ "hash_2be698011074fc01", 1) == 1;
  level.var_3bee9b0a6835e07b = getdvarint(@ "hash_5a9165d11e511873", 0);
  var_813da151d7b2ca7e = ter_op(function_ba5574c7f287c587(), 0, 1);
  level.var_a83a4e71446bfef7 = getdvarint(@ "hash_9e2a261d00656441", var_813da151d7b2ca7e);
  level.var_5a2620a56cf4bb = getdvarint(@ "hash_b61802a00edccfa9", var_813da151d7b2ca7e);
  level.var_37172573e0865e02 = getdvarint(@ "hash_3f51edcd4ab0e8e0", 0);
  level.var_db813db0fa91a0ce = getdvarint(@ "hash_b86cdc68f61cf84", 0);
  level.var_36871639aadbfd77 = getdvarint(@ "hash_d29e2cf0e9e41d98", 0);
  level.var_7f1716b735a38c9f = getdvarint(@ "hash_a4a28649ef4389f4", 1);
  level.brdisablefinalkillcam = 1;
  thread scripts\mp\gametypes\br_lootchopper::init();
  thread initpostmain();
  thread initdialog();

  thread devthink();
}

function initpostmain() {
  waittillframeend();
  level.uavsettings["uav"].timeout = 60;
  scripts\mp\flags::gameflaginit("collect_done", 0);
  scripts\mp\flags::gameflaginit("helipad_wait_done", 0);
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  scripts\mp\flags::gameflaginit("activate_cash_lzs", 0);
  scripts\mp\flags::gameflaginit("activate_cash_drops", 0);
  scripts\mp\flags::gameflaginit("activate_cash_helis", 0);
  level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
  level.brmodevariantrewardcullfunc = &missions_clearinappropriaterewards;
  level.ononeleftevent = &ononeleftevent;
  level.onplayerkilled = &onplayerkilled;
  level.onpostkillcamcallback = &onpostkillcamcallback;
  level.ontimelimit = &ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&playerlootleadervalidity);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread setupmission();
  thread scripts\mp\gametypes\br_lootchopper::lootchopper_managespawns();
  thread scripts\mp\gametypes\br_c130airdrop::c130airdrop_managedrop();
  level thread namespace_ba90759e150897e3::init();
  level.lootleadermarks = [];
  level.expiredlootleadermarks = [];

  for(i = 0; i < level.lootleadermarkcount; i++) {
    if(level.lootleadermarksontopteams > 0 && i == 0) {
      idindex = "LootLeaderTop_Plunder";
    } else {
      idindex = "LootLeader_Plunder";
    }

    instance = spawnStruct();

    instance.debugtype = "<dev string:x1c>";

    instance.modifier = "";
    instance function_6b6b6273f8180522(idindex, undefined, level.lootleadermarksize);
    level.lootleadermarks[i] = instance;
    instance = spawnStruct();

    instance.debugtype = "<dev string:x1c>";

    instance.modifier = "";
    instance function_6b6b6273f8180522("Expired_" + idindex, undefined, level.lootleadermarksize);
    level.expiredlootleadermarks[i] = instance;
  }

  if(!istrue(level.usemilestonephases)) {
    level thread placementupdatewait();
  }

  thread waitandstartplunderpolling();
  level thread scripts\mp\gametypes\br_analytics::initcashtracking();
  cleanupents();

  if(level.teamplunderscoremechanic) {
    if(getdvarfloat(@ "hash_81be161d3102cc0e", 15) > 0) {
      level thread updatelootleadersonfixedinterval();
    }
  }

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons) {
    level thread createheliextractobjectiveicons();
  }

  thread function_dc2b625c4d2e4f5();

  if(istrue(level.mapedgeextractionlocs)) {
    level thread initextractionlocations();
  }

  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level thread eomawardplayerxp();

  if(istrue(level.endmatchcameratransitions)) {
    level thread initendcameralocations();
  }

  speed = getdvarint(@ "hash_541028f96f581a0a", -1);

  if(speed > 0) {
    level.br_level.c130_speedoverride = speed;
  }

  level thread changecirclestateatlowtime();

  if(level.doendofmatchotsequence && level.overtimebuiltintomatchtimer) {
    level thread changetimertoovertimetimer();
  }

  thread onprematchfadedone();
}

function onprematchfadedone() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    player thread namespace_aead94004cf4c147::clearbackpack();
  }
}

function function_dc2b625c4d2e4f5() {
  if(level.timeoutplunderextractionsites > 0) {
    scripts\mp\flags::gameflagwait("prematch_done");

    if(level.matchstartextractsitedelay > 0) {
      wait level.matchstartextractsitedelay;
    }

    level thread startplunderextractiontimers();
  }
}

function changecirclestateatlowtime() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  level endon("end_circlestate_timer");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint(@ "scr_br_timelimit");
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_hardpoint_timer", gettime() + int(timer * 1000));
  wait int(max(timer - 300, 0));
  setomnvar("ui_br_circle_state", 6);
}

function changetimertoovertimetimer() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint(@ "scr_br_timelimit");
  waittime = int(max(timer - level.doendofmatchotsequence, 0));

  if(waittime <= 0) {
    return;
  }

  wait waittime;
  level notify("end_circlestate_timer");
  level thread triggerovertimetimer(undefined, undefined, 1);
}

function waitandstartplunderpolling() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread plunderrankupdate();
}

function cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

function onplayerdisconnect(player) {
  if(isDefined(player) && scripts\mp\flags::gameflag("prematch_done")) {
    player scripts\mp\gametypes\br_pickups::droponplayerdeath();

    if(isDefined(level.numteamswithplayers)) {
      if(level.teamdata[player.team]["players"].size == 0) {
        level.numteamswithplayers--;
      }

      return;
    }

    scripts\mp\utility\teams::calculatenumteamswithplayers();
  }
}

function ononeleftevent(team) {}

function onpickuptakenintobackpack(pickupent) {
  if(!(isDefined(pickupent.scriptablename) && istrue(level.var_b19067b41fd5cfe8))) {
    return;
  }

  var_7c0646d93451368c = scripts\mp\gametypes\br_pickups::function_b77386f2a0293169(pickupent.scriptablename);

  if(var_7c0646d93451368c) {
    namespace_88bfae359020fdd3::function_1976438a8865ac27("br_ftue_valuables");
  }
}

function playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled)) {
    self waittill("joining_Infil");
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  wait 1;

  if(level.mapname == "<dev string:x28>" && getdvarint(@ "hash_7713e10380b6cb97", 0) == 0) {
    if(isDefined(self.plotarmor)) {
      self.plotarmor = undefined;
    }
  }

  level thread scripts\mp\utility\teams::calculatenumteamswithplayers();

  if(soundexists("dx_bra_uktl_bm_tut_earn_cash")) {
    level scripts\mp\gametypes\br_public::brleaderdialogplayer("bm_tut_earn_cash", self);
  }

  if(level.var_36871639aadbfd77) {
    scripts\mp\hud_message::showsplash("br_gametype_plunder_welcome", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
  }

  if(istrue(self.isbrsquadleader)) {
    level scripts\mp\gametypes\br_public::brleaderdialogplayer("deploy_squad_leader", self, 1, 0, 4.5);
  }

  if(istrue(level.autoassignfirstquest) && istrue(level.br_prematchstarted)) {
    autoassignquest(self);
  }
}

function spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

function getdropbagdelay() {}

function trackserverend() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_4c473852188edc3f = 0;
  var_99d0e04b2137bd95 = 0;
  var_26482caeea97c1f9 = 0;

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  while(true) {
    wait 1;
    timeremaining = scripts\mp\gamelogic::gettimeremaining() / 1000;

    if(istrue(level.bmoovertime)) {
      break;
    }

    if(timeremaining <= 600 && !var_4c473852188edc3f) {
      var_4c473852188edc3f = 1;
      setomnvar("ui_br_circle_state", 1);

      foreach(player in level.players) {
        player scripts\mp\utility\lower_message::setlowermessageomnvar("br_dmz_10minwarning", undefined, 10);
      }

      continue;
    }

    if(timeremaining <= 300 && !var_99d0e04b2137bd95) {
      var_99d0e04b2137bd95 = 1;
      setomnvar("ui_br_circle_state", 2);

      foreach(player in level.players) {
        player scripts\mp\utility\lower_message::setlowermessageomnvar("br_dmz_5minwarning", undefined, 10);
      }

      continue;
    }

    if(timeremaining <= 0 && !var_26482caeea97c1f9) {
      var_26482caeea97c1f9 = 1;

      if(level.teamplunderscoremechanic) {
        return;
      }

      setomnvar("ui_nuke_countdown_active", 0);
      level.mercywintriggered = 1;
      var_39e8f33513c716cd = findanyaliveplayer();

      if(isPlayer(var_39e8f33513c716cd)) {
        var_39e8f33513c716cd scripts\cp_mp\killstreaks\nuke::tryusenuke();
        wait 10;
        emptyteam = findteamwithnoplayers();
        level thread scripts\mp\gamelogic::endgame(emptyteam, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
        continue;
      }

      emptyteam = findteamwithnoplayers();
      level thread scripts\mp\gamelogic::endgame(emptyteam, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
    }
  }
}

function findanyaliveplayer() {
  teamkeys = getarraykeys(level.teamdata);

  foreach(key in teamkeys) {
    if(level.teamdata[key]["alivePlayers"].size > 0) {
      return level.teamdata[key]["alivePlayers"][0];
    }
  }

  return undefined;
}

function findteamwithnoplayers() {
  teamkeys = getarraykeys(level.teamdata);

  foreach(key in teamkeys) {
    if(level.teamdata[key]["players"].size == 0) {
      return key;
    }
  }

  return "tie";
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\mp\gametypes\br::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  var_1cf59dc12f7225cb = getdvarint(@ "hash_2af6e6a061931dc", 7500);

  if(isDefined(level.splashtime_vip) && level.splashtime_vip + var_1cf59dc12f7225cb > gettime()) {
    scripts\mp\hud_message::showsplash("bm_vips_marked");
  }

  if(isDefined(level.splashtime_lzs) && level.splashtime_lzs + var_1cf59dc12f7225cb > gettime()) {
    scripts\mp\hud_message::showsplash("bm_extract_heli_start");
  }

  if(isDefined(level.splashtime_drops) && level.splashtime_drops + var_1cf59dc12f7225cb > gettime()) {
    scripts\mp\hud_message::showsplash("br_c130airdrop_incoming");
  }

  if(isDefined(level.splashtime_helis) && level.splashtime_helis + var_1cf59dc12f7225cb > gettime()) {
    scripts\mp\hud_message::showsplash("br_lootchopper_incoming");
  }
}

function brmayconsiderplayerdead(player) {
  return true;
}

function playershouldrespawn(data) {
  return true;
}

function setupmission() {
  level.brgametype.extractposition = getextractionposition();
  thread makeextractionobjective();
}

function getextractionposition() {
  var_4bf102a2e23c6c84 = 2500;
  centerpt = level.br_level.br_mapcenter;
  randomangles = (0, randomfloatrange(0, 360), 0);
  pathdir = anglesToForward(randomangles);
  pathradius = level.br_level.br_circleradii[0] * 2;
  endpt = centerpt + pathdir * pathradius;
  endpt = scripts\mp\gametypes\br_c130::snappointtooutofboundstriggertrace(centerpt, endpt);
  startheight = 0;
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(heightent)) {
    startheight = heightent.origin[2];
  }

  start = (endpt[0], endpt[1], startheight);
  groundpt = tracegroundpoint(start);
  endpt = groundpt + (0, 0, var_4bf102a2e23c6c84);
  return endpt;
}

function makeextractionobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.brgametype.objectiveiconid = objectiveiconid;
  assert(objectiveiconid != -1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", level.brgametype.extractposition, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  }
}

function setupmissionwidget() {
  scripts\mp\flags::gameflagwait("prematch_done");
  xp = getcurrentxp();
  startindex = namespace_1eb3c4e0e28fac71::getquesttableindex("gt_extract_1");

  foreach(player in level.players) {
    player namespace_1eb3c4e0e28fac71::setquestindexomnvar(startindex);
    player namespace_1eb3c4e0e28fac71::uiobjectivesetparameter(xp);
  }
}

function getcurrentxp() {
  xp = getdvarint(@ "hash_911e056fab287a06", 5000);
  xpmin = getdvarint(@ "hash_728f3c5d729a3f2d", 2000);
  xpdecrease = getdvarint(@ "hash_802cc155c089e133", 200);

  if(xpmin > 0) {
    xp = int(max(xpmin, xp - level.brgametype.numextractions * xpdecrease));
  }

  return xp;
}

function showextractionobjectivetoteam(team) {
  teammates = level.teamdata[team]["players"];

  foreach(player in teammates) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.brgametype.objectiveiconid, player);
  }
}

function hideextractionobjectivefromteam(team) {
  teammates = level.teamdata[team]["players"];

  foreach(player in teammates) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.brgametype.objectiveiconid, player);
  }
}

function doteamextractedupdate() {
  level.brgametype.numextractions++;
  level.brgametype.hudextractnum setvalue(level.brgametype.numextractions);
  level.brgametype.hudextractnum thread huddopulse();
  level.brgametype.hudextractmax thread huddopulse();
  cost = getcost();
  level.brgametype.hudcost setvalue(cost * 10);

  foreach(entry, teamdata in level.teamdata) {
    if(isDefined(teamdata["teamCount"]) && teamdata["teamCount"] > 0) {
      updateteamplunderhud(entry);
    }
  }

  xp = getcurrentxp();

  foreach(player in level.players) {
    if(!namespace_8bfdb6eb5a3df67a::isteamextracted(player.team)) {
      player thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      player namespace_1eb3c4e0e28fac71::uiobjectivesetparameter(xp);
    }
  }
}

function brendgame() {
  wait 1.5;
  handleendgamesplash();
  scripts\mp\gamelogic::endgame_regularmp(level.brgametype.firstteam, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

function handleendgamesplash() {
  foreach(player in level.players) {
    if(!namespace_8bfdb6eb5a3df67a::isteamextracted(player.team)) {
      player setcachedclientomnvar("post_game_state", 2);
    }
  }
}

function function_34e46d26df79fdad() {
  if(!isDefined(self.var_db548fc480c33eac)) {
    self.var_db548fc480c33eac = [];
    self.var_db548fc480c33eac[0] = 0;
    self.var_db548fc480c33eac[1] = 0;
    self.var_db548fc480c33eac[2] = 0;
    self.var_db548fc480c33eac[3] = 0;
    self.var_db548fc480c33eac[4] = 0;
  }

  totalcash = self.plundercount + self.plunderbanked;
  var_cdf68f979a48cea6 = self.var_db548fc480c33eac[0] + self.var_db548fc480c33eac[1] + self.var_db548fc480c33eac[2] - self.var_db548fc480c33eac[3] - self.var_db548fc480c33eac[4];
  var_4e673c880cb3ff65 = var_cdf68f979a48cea6 - totalcash;
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 0, int(var_4e673c880cb3ff65));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 1, int(self.var_db548fc480c33eac[4]));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 2, int(self.var_db548fc480c33eac[3]));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 3, int(self.var_db548fc480c33eac[2]));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 4, int(self.var_db548fc480c33eac[1]));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 5, int(self.var_db548fc480c33eac[0]));
  self setplayerdata(level.var_5d69837cf4db0407, "plunderAARValue", 6, int(totalcash));
  scripts\mp\gametypes\br_analytics::function_9d458fb3a5d1e86a(scripts\mp\gametypes\br_plunder::getteamplunder(self.team) * 100, game["teamPlacements"][self.team], totalcash, self.var_db548fc480c33eac[0], self.var_db548fc480c33eac[1], self.var_db548fc480c33eac[2], self.var_db548fc480c33eac[3], self.var_db548fc480c33eac[4]);

  if(istrue(level.var_db813db0fa91a0ce)) {
    team = self.team;

    if(!isDefined(level.var_e224ccaf8102eea7)) {
      level.var_e224ccaf8102eea7 = [];
    }

    if(!isDefined(level.var_e224ccaf8102eea7[team])) {
      level.var_e224ccaf8102eea7[team] = spawnStruct();
      level.var_e224ccaf8102eea7[team].cashtotal = 0;
      level.var_e224ccaf8102eea7[team].var_5aef484ac6780f1c = 0;
      level.var_e224ccaf8102eea7[team].contracttotal = 0;
      level.var_e224ccaf8102eea7[team].var_f86b346fef47a962 = 0;
      level.var_e224ccaf8102eea7[team].ondeathtotal = 0;
      level.var_e224ccaf8102eea7[team].purchasetotal = 0;
      level.var_e224ccaf8102eea7[team].var_bea7a1b2df733cdc = 0;
    }

    level.var_e224ccaf8102eea7[team].cashtotal += totalcash;
    level.var_e224ccaf8102eea7[team].var_5aef484ac6780f1c += self.var_db548fc480c33eac[0];
    level.var_e224ccaf8102eea7[team].contracttotal += self.var_db548fc480c33eac[1];
    level.var_e224ccaf8102eea7[team].var_f86b346fef47a962 += self.var_db548fc480c33eac[2];
    level.var_e224ccaf8102eea7[team].ondeathtotal += self.var_db548fc480c33eac[3];
    level.var_e224ccaf8102eea7[team].purchasetotal += self.var_db548fc480c33eac[4];
    level.var_e224ccaf8102eea7[team].var_bea7a1b2df733cdc += var_4e673c880cb3ff65;
  }

  if(istrue(level.var_37172573e0865e02)) {
    logstring("Player Plunder Total: { Name: " + self.name + ", Team: " + self.team + ", Total Cash: " + totalcash + ", Looted: " + self.var_db548fc480c33eac[0] + ", Contracts: " + self.var_db548fc480c33eac[1] + ", Valuables: " + self.var_db548fc480c33eac[2] + ", Lost On Death: " + self.var_db548fc480c33eac[3] + ", Lost On Purchase: " + self.var_db548fc480c33eac[4] + ", Net Dropped: " + var_4e673c880cb3ff65 + " }");
  }
}

function setuptimelimit() {
  level endon("game_ended");
  var_b0fca93213e625c7 = 120;
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled)) {
    level waittill("br_ready_to_jump");
  }

  waitframe();
  missionhud = createhudelem(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  missionhud.alpha = 1;
  timerhud = scripts\mp\hud_util::createservertimer("default", 1.5);
  timerhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  collecttime = getdvarint(@ "hash_a718bf7355e667a3", 180);

  if(collecttime > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(collecttime * 1000));
    timerhud settimer(collecttime);
    wait collecttime;
  }

  scripts\mp\flags::gameflagset("collect_done");
  var_532c835e523ef572 = getdvarint(@ "hash_9fd551b851144f28", 180);

  if(var_532c835e523ef572 > 0) {
    missionhud.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    missionhud thread huddopulse();
    setomnvar("ui_hardpoint_timer", gettime() + int(var_532c835e523ef572 * 1000));
    timerhud settimer(var_532c835e523ef572);
    wait var_532c835e523ef572;
  }

  scripts\mp\flags::gameflagset("helipad_wait_done");
  var_f8dd42f6bc48954b = getdvarint(@ "hash_db683ed24a430594", 840);
  missionhud.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  missionhud thread huddopulse();
  setomnvar("ui_hardpoint_timer", gettime() + int(var_f8dd42f6bc48954b * 1000));
  timerhud settimer(var_f8dd42f6bc48954b);
  var_98ee5131da5693 = max(var_f8dd42f6bc48954b - var_b0fca93213e625c7, 0);
  wait var_98ee5131da5693;
  timeleft = max(var_f8dd42f6bc48954b - var_98ee5131da5693, 0);
  timerhud.color = (1, 0, 0);
  timerhud thread huddopulse();
  thread clocksounds(timeleft);
  wait timeleft;
  timerhud destroy();
  thread brendgame();
}

function clocksounds(timeleft) {
  level endon("game_ended");

  while(timeleft > 0) {
    dosound = 0;
    clocksoundalias = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(timeleft);

    if(timeleft > 60 && timeleft % 10 == 0 || timeleft <= 60 && timeleft > 30 && timeleft % 2 == 0 || timeleft <= 30) {
      dosound = 1;
    }

    if(dosound) {
      foreach(player in level.players) {
        player playlocalsound(clocksoundalias);
      }
    }

    timeleft -= 1;
    wait 1;
  }
}

function function_9846f99ee86791d8(timeleft) {
  level endon("game_ended");
  wait 2;

  while(isDefined(timeleft) && timeleft > 0) {
    dosound = 0;
    clocksoundalias = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(timeleft);

    if(timeleft <= 10) {
      dosound = 1;
    }

    if(dosound) {
      foreach(player in level.players) {
        player playlocalsound(clocksoundalias);
      }
    }

    timeleft -= 1;
    wait 1;
  }
}

function setupteamplunderhud() {
  var_d1f0e5189f1576d0 = 155;
  var_a1ca4daa7621c02f = 15;
  var_b4c134e149b2e70b = -3;
  var_d2c8c88f6ff982fa = 3;

  if(level.teamplunderscoremechanic) {
    cost = getwincost();
    text = &"MP_BR_INGAME/WIN_COST_TEXT";
    hudcost = cost;
  } else {
    cost = getcost();
    text = &"MP_BR_INGAME/EXTRACT_COST_TEXT";
    hudcost = cost * 10;
  }

  level.brgametype.hudcoststring = createhudelem(text, undefined, "LEFT", "CENTER", var_d2c8c88f6ff982fa, var_d1f0e5189f1576d0, undefined, undefined, 1);
  level.brgametype.hudcost = createhudelem(&"MP_BR_INGAME/EXTRACT_COST_MILLION", undefined, "LEFT", "CENTER", 65 + var_d2c8c88f6ff982fa, var_d1f0e5189f1576d0, undefined, undefined, 1);
  level.brgametype.hudplunderstring = createhudelem(&"MP_BR_INGAME/YOUR_TEAM_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", 5 + var_b4c134e149b2e70b, var_d1f0e5189f1576d0, undefined, undefined, 1);
  var_a7f7937dc17270c2 = 0;
  level.brgametype.leaderplunderstring = createhudelem(&"MP_BR_INGAME/LEADER_PLUNDER_TEXT", var_a7f7937dc17270c2, "CENTER", "CENTER", 0, var_d1f0e5189f1576d0 + var_a1ca4daa7621c02f, undefined, undefined, 1);

  foreach(team in level.teamnamelist) {
    hudplunder = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", 70 + var_b4c134e149b2e70b, var_d1f0e5189f1576d0, undefined, team, 1);
    hudplacement = createhudelem(&"MP_BR_INGAME/ST_PLACE", undefined, "RIGHT", "CENTER", -65 + var_b4c134e149b2e70b, var_d1f0e5189f1576d0, undefined, team, 1);
    hudplacement setvalue(1);
    hudplunder.placement = hudplacement;
    setteamplunderhud(team, hudplunder);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled)) {
    level waittill("br_ready_to_jump");
  }

  level.brgametype.hudcoststring.alpha = 1;
  level.brgametype.hudcost.alpha = 1;
  level.brgametype.hudplunderstring.alpha = 1;
  level.brgametype.leaderplunderstring.alpha = 1;

  foreach(team in level.teamnamelist) {
    hudplunder = getteamplunderhud(team);
    hudplunder.alpha = 1;
    hudplunder.placement.alpha = 1;
  }
}

function setteamplunderhud(team, hudelem) {
  level.teamdata[team]["hudPlunder"] = hudelem;
  hudelem.plundercount = 0;
  hudelem.plundercountroll = 0;
}

function getteamplunderhud(team) {
  return level.teamdata[team]["hudPlunder"];
}

function createhudelem(label, value, point, relativepoint, xoffset, yoffset, color, team, fontscale, player) {
  if(!isDefined(fontscale)) {
    fontscale = 1.5;
  }

  if(isDefined(team)) {
    fontelem = newteamhudelem(team);
  } else if(isDefined(player)) {
    fontelem = newclienthudelem(player);
  } else {
    fontelem = newhudelem();
  }

  fontelem.elemtype = "font";
  fontelem.font = "default";
  fontelem.fontscale = fontscale;
  fontelem.basefontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem scripts\mp\hud_util::setparent(level.uiparent);
  fontelem.hidden = 0;
  fontelem.alpha = 0;
  fontelem scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label)) {
    fontelem.label = label;
  }

  if(isDefined(value)) {
    fontelem setvalue(value);
  }

  if(isDefined(color)) {
    fontelem.color = color;
  }

  return fontelem;
}

function sortplayerplunderscores(score1, score2) {
  return score1 > score2;
}

function hackclientomnvarclamp(omnvar, val) {
  valclamp = int(min(val, 131072));
  assertex(val == valclamp, "<dev string:x3b>" + val);
  setcachedclientomnvar(omnvar, valclamp);
}

function hackomnvarclamp(omnvar, val) {
  valclamp = int(min(val, 131072));
  assertex(val == valclamp, "<dev string:x3b>" + val);
  setcachedgameomnvar(omnvar, valclamp);
}

function plunderrankupdate() {
  level endon("game_ended");
  var_61a13391e0337903 = 0;
  var_5a1b98786f638bb3 = [];
  var_53ba034cdc687f01 = 0;
  var_9d41c15dc3dfa5e4 = 0;
  var_556e0039a439cd2 = 0;
  var_73f830db146a9277 = 0;
  var_ad5e6d3e7e4cc004 = 0;
  var_f6780228ec69f8d5 = 0;
  var_39926f7b2de6c632 = level.hideleaderhashuntilpercent != 0;
  level.splashtime_vip = undefined;
  level.splashtime_lzs = undefined;
  level.splashtime_drops = undefined;
  level.splashtime_helis = undefined;

  while(true) {
    waittillframeend();
    var_20085f3d87bac60b = level.called50percentprogress && level.called75percentprogress && level.called90percentprogress;
    wincost = getwincost();
    var_61a13391e0337903 += level.framedurationseconds;

    if(istrue(level.usemilestonephases)) {
      var_1910592d7cd985fe = scripts\mp\flags::gameflag("placement_updates_allowed");
    } else {
      var_1910592d7cd985fe = var_61a13391e0337903 > level.secondsbeforeplacementupdates;
    }

    splashesallowed = level.showplacementsplashesandmusic && var_1910592d7cd985fe;
    placements = getteamscoreplacements();
    var_89f63b69f41ad35a = level.teamplunderscoremechanic;
    var_745ae0b656709a1 = undefined;
    team75 = undefined;
    team50 = undefined;
    var_44578707af5385ce = [];
    playerscores = [];
    playerlookup = [];
    winningteam = "none";
    secondplaceteam = "none";
    highscore = -1;
    secondplacescore = -1;

    foreach(team in level.teamnamelist) {
      plundercount = scripts\mp\gametypes\br_plunder::getteamplunder(team);
      bankedplunder = scripts\mp\gametypes\br_plunder::getbankedplunder(team);
      delta = updateteamplunderscore(plundercount, team, level.brgametype.firstteam);
      previousplacement = getpreviousplacement(team);
      placement = placements[team];

      if(plundercount > highscore) {
        if(highscore > secondplacescore) {
          secondplacescore = highscore;
          secondplaceteam = winningteam;
        }

        highscore = plundercount;
        winningteam = team;
      } else if(winningteam != "none") {
        if(plundercount > secondplacescore) {
          secondplacescore = plundercount;
          secondplaceteam = team;
        }
      }

      pockets = (plundercount - bankedplunder) * 10;
      total = plundercount * 10;
      banked = total - pockets;

      if(pockets < 0) {
        println("<dev string:x73>" + plundercount + "<dev string:xc8>" + bankedplunder + "<dev string:xe0>" + pockets);
        pockets = 0;
      }

      if(total >= wincost * 0.9) {
        var_745ae0b656709a1 = team;
      } else if(total >= wincost * 0.75) {
        team75 = team;
      } else if(total >= wincost * 0.5) {
        team50 = team;
      }

      if(total >= wincost * level.plundermusicfourth) {
        thread scripts\mp\music_and_dialog::plunder_ninetypercent_music();
      } else if(total >= wincost * level.plundermusicthird) {
        thread scripts\mp\music_and_dialog::plunder_seventyfivepercent_music();
      } else if(total >= wincost * level.plundermusicsecond) {
        thread scripts\mp\music_and_dialog::plunder_fiftypercent_music();
      } else if(total >= wincost * level.plundermusicfirst) {
        thread scripts\mp\music_and_dialog::plunder_thirtypercent_music();
      }

      players = getfriendlyplayers(team, 0);

      foreach(player in players) {
        placement = placements[player.team];

        if(!var_ad5e6d3e7e4cc004) {
          placement = 155;
        }

        player setcachedclientomnvar("ui_br_team_placement", placement);
        player setcachedclientomnvar("ui_br_player_position", placement);
        player hackclientomnvarclamp("ui_br_team_cash_banked", int(banked * 0.1));
        player hackclientomnvarclamp("ui_br_team_cash_pockets", int(pockets * 0.1));
        playerscores[player.guid] = player.plundercount;
        playerlookup[player.guid] = player;
      }

      if(splashesallowed) {
        if(placement == 1) {
          var_44578707af5385ce[var_44578707af5385ce.size] = team;
        } else if(placement <= 5) {
          if(previousplacement > 5) {
            if(getdvarint(@ "hash_eabb43d303ca5c9c", 0)) {
              showsplashtoteam(team, "bm_top_5", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            }
          }
        } else if(placement <= 10) {
          if(previousplacement > 10) {
            if(getdvarint(@ "hash_a245d6517f1b4f1c", 0)) {
              showsplashtoteam(team, "bm_top_10", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            }
          }
        }
      }

      if(total >= wincost) {
        autobankteamplunder(team);

        if(var_89f63b69f41ad35a && level.doendofmatchotsequence > 0 && !level.disablewinonscore) {
          level thread triggerovertimetimer(team, level.teamdata[team]["plunderBanked"] * 10 >= wincost);
          continue;
        }

        if(var_89f63b69f41ad35a && level.doendofmatchotsequence > 0 && level.disablewinonscore) {
          level.initialwinningteam = team;
          continue;
        }

        if(level.teamplunderexfil && !istrue(level.exfilactive)) {
          level.exfilactive = 1;
          level thread startbmoexfilprocess(team);
          continue;
        }

        if(!level.teamplunderexfil && var_89f63b69f41ad35a && !level.disablewinonscore) {
          level thread givewincondition(team);
        }
      }
    }

    teamsorted = [];
    playersorted = [];

    if(level.lootleadermarksontopteams == 1) {
      teamsorted = tablesort(game["teamPlacements"], "up");
    } else if(level.lootleadermarksontopteams == 2) {
      teamsorted[0] = winningteam;
      playersorted = tablesort(playerscores, "down");
    } else {
      playersorted = tablesort(playerscores, "down");
    }

    level.brgametype.firstteam = winningteam;

    if(winningteam == "none") {
      var_5a1b98786f638bb3 = [];
      waitframe();
      continue;
    }

    if(secondplaceteam != "none") {
      hackomnvarclamp("ui_br_cash_second", int(secondplacescore));
    }

    hackomnvarclamp("ui_br_cash_leader", int(highscore));

    if(!var_39926f7b2de6c632 && highscore * 10 >= wincost * level.hideleaderhashuntilpercent * 0.01) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      var_39926f7b2de6c632 = 1;
    }

    if(!istrue(var_f6780228ec69f8d5) && istrue(level.usemilestonephases)) {
      if(!var_53ba034cdc687f01 && highscore * 10 >= wincost * level.milestonephasepercent_vips * 0.01) {
        var_53ba034cdc687f01 = 1;
        level.splashtime_vip = gettime();
        scripts\mp\flags::gameflagset("placement_updates_allowed");

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          showsplashtoall("bm_vips_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
        }
      }

      if(!var_9d41c15dc3dfa5e4 && (level.scorerequiresbanking || highscore * 10 >= wincost * level.milestonephasepercent_lzs * 0.01)) {
        var_9d41c15dc3dfa5e4 = 1;
        level.splashtime_lzs = gettime();
        scripts\mp\flags::gameflagset("activate_cash_lzs");

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          scripts\mp\gametypes\br_public::brleaderdialog("extract_enabled", 0, undefined, undefined, undefined, "bm");
        }
      }

      if(!var_556e0039a439cd2 && highscore * 10 >= wincost * level.milestonephasepercent_drops * 0.01) {
        var_556e0039a439cd2 = 1;
        level.splashtime_drops = gettime();
        level.br_level.c130_speedoverride = 3044;
        scripts\mp\flags::gameflagset("activate_cash_drops");

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          scripts\mp\gametypes\br_public::brleaderdialog("event_airdrop", 0, undefined, undefined, undefined, "bm");
        }
      }

      if(!var_73f830db146a9277 && (istrue(level.bmoovertime) || highscore * 10 >= wincost * level.milestonephasepercent_helis * 0.01)) {
        var_73f830db146a9277 = 1;
        level.splashtime_helis = gettime();
        scripts\mp\flags::gameflagset("activate_cash_helis");

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          scripts\mp\gametypes\br_public::brleaderdialog("event_chopper", 0, undefined, undefined, undefined, "bm");
        }
      }

      if(var_53ba034cdc687f01 && var_9d41c15dc3dfa5e4 && var_556e0039a439cd2 && var_73f830db146a9277) {
        var_f6780228ec69f8d5 = 1;
      }
    }

    if(!var_ad5e6d3e7e4cc004 && highscore * 10 >= wincost * level.hideplacementuntilpercent * 0.01) {
      var_ad5e6d3e7e4cc004 = 1;
    }

    if(!splashesallowed || highscore == 0) {
      waitframe();
      continue;
    }

    if(level.lootleadermarksontopteams > 0) {
      if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
        updatelootleadermarks(playerscores, playersorted, playerlookup, teamsorted);
        level.plunderupdatelootleadermarks = 0;
      }
    } else if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
      updatelootleadermarks(playerscores, playersorted, playerlookup);
      level.plunderupdatelootleadermarks = 0;
    }

    foreach(team in var_44578707af5385ce) {
      if(!array_contains(var_5a1b98786f638bb3, team)) {
        if(istrue(level.topteamsever[team])) {
          if(getdvarint(@ "hash_fb39b1c02691c31b", 0)) {
            if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
              showsplashtoteam(team, "br_plunder_took_the_lead", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            }
          }

          continue;
        }

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          showsplashtoteam(team, "br_plunder_took_the_lead", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
        }

        level.topteamsever[team] = 1;
      }
    }

    if(getdvarint(@ "hash_7e82fb8d960e5fea", 0)) {
      if(var_44578707af5385ce.size > 0) {
        foreach(team in var_5a1b98786f638bb3) {
          if(!array_contains(var_44578707af5385ce, team)) {
            showsplashtoteam(team, "br_plunder_lead_lost", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
          }
        }
      }
    }

    var_5a1b98786f638bb3 = var_44578707af5385ce;
    level.topteam = winningteam;
    level.previousplacements = placements;

    if(!var_20085f3d87bac60b) {
      if(!level.called90percentprogress && isDefined(var_745ae0b656709a1)) {
        level.called90percentprogress = 1;

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          if(!level.disablepercentageannouncements) {
            showsplashtoallexceptteam(var_745ae0b656709a1, "bm_first_to_90_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            showsplashtoteam(var_745ae0b656709a1, "bm_first_to_90_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");

            if(istrue(level.var_29af3a470e92b6e1)) {
              level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_90_perc_first", var_745ae0b656709a1, 1, undefined, "bm");

              foreach(entry in level.teamnamelist) {
                if(entry != var_745ae0b656709a1) {
                  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_90_perc_enemy", entry, 1, undefined, "bm");
                }
              }
            }
          }
        }
      } else if(!level.called75percentprogress && isDefined(team75)) {
        level.called75percentprogress = 1;

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          if(!level.disablepercentageannouncements) {
            showsplashtoallexceptteam(team75, "bm_first_to_75_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            showsplashtoteam(team75, "bm_first_to_75_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");

            if(istrue(level.var_29af3a470e92b6e1)) {
              level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_75_perc_first", team75, 1, undefined, "bm");

              foreach(entry in level.teamnamelist) {
                if(entry != team75) {
                  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_75_perc_enemy", entry, 1, undefined, "bm");
                }
              }
            }
          }
        }
      } else if(!level.called50percentprogress && isDefined(team50)) {
        level.called50percentprogress = 1;

        if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
          if(!level.disablepercentageannouncements) {
            showsplashtoallexceptteam(team50, "bm_first_to_50_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
            showsplashtoteam(team50, "bm_first_to_50_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");

            if(istrue(level.var_29af3a470e92b6e1)) {
              level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_50_perc_first", team50, 1, undefined, "bm");

              foreach(entry in level.teamnamelist) {
                if(entry != team50) {
                  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("gamestate_50_perc_enemy", entry, 1, undefined, "bm");
                }
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

function autobankteamplunder(team) {
  if(!level.var_ad5e78c78f492751) {
    return;
  }

  if(!isDefined(level.autobankedteams)) {
    level.autobankedteams = [];
  }

  if(array_contains(level.autobankedteams, team)) {
    return;
  }

  players = getteamdata(team, "players");
  data = scripts\mp\gametypes\br_plunder::createplayerplundereventdata();
  data.playanimation = 0;

  foreach(player in players) {
    if(isDefined(player.plundercount) && player.plundercount > 0) {
      player scripts\mp\gametypes\br_plunder::playerplunderbank(player.plundercount, undefined, data);
    }
  }

  level.autobankedteams[level.autobankedteams.size] = team;
}

function overtimecashmultiplier() {
  level thread scripts\mp\gametypes\br_plunder::processcashpileovertimemultiplier(level.overtimecashmultiplier);
}

function placementupdatewait() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.secondsbeforeplacementupdates)) {
    wait level.secondsbeforeplacementupdates;
  }

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

function getpreviousplacement(team) {
  if(isDefined(level.previousplacements)) {
    return level.previousplacements[team];
  }

  return -1;
}

function triggermatchendtimer(endtime) {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  timelimit = getdvarfloat(@ "hash_4dcbff985e3e175e", 10);
  gamemode = hashcat(@ "scr_", getgametype(), "_timelimit");
  level.watchdvars[gamemode].value = timelimit;
  level.overridewatchdvars[gamemode] = timelimit;
}

function updateteamplunderhud(team) {
  hudplunder = getteamplunderhud(team);
  plundercount = scripts\mp\gametypes\br_plunder::getteamplunder(team);
  cost = getcost();

  if(plundercount >= cost && hudplunder.color != (0, 1, 0)) {
    hudplunder.color = (0, 1, 0);
    teammates = level.teamdata[team]["players"];

    foreach(player in teammates) {
      player playlocalsound("br_plunder_atm_deposit_gtr");
    }
  }
}

function dohudplunderrollsound(sign, team) {
  teammates = level.teamdata[team]["players"];

  foreach(player in teammates) {
    if(sign > 0) {
      if(isDefined(player.hudplunderstart)) {
        duration = gettime() - player.hudplunderstart;

        if(duration <= 6000) {
          break;
        }
      }

      player.hudplunderstart = gettime();

      if(isalive(player)) {
        player playlocalsound("br_plunder_atm_use");
      }

      continue;
    }

    player.hudplunderstart = undefined;
    player stoplocalsound("br_plunder_atm_use");
  }
}

function givewincondition(winteam) {
  if(istrue(level.triggeredwincondition)) {
    return;
  }

  if(!istrue(level.triggeredwincondition)) {
    level thread printallteamsplundercount();
  }

  level.triggeredwincondition = 1;
  level thread scripts\mp\gamelogic::endgame(winteam, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
}

function playerdropplunderondeath(dropstruct, attacker) {
  if(isDefined(self.c130)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  var_47545befc5dedb97 = 0;
  var_6aee9c9054f09ed5 = 0;
  var_b64f283113c99581 = 0;

  if(isDefined(self.plundercount)) {
    var_47545befc5dedb97 = self.plundercount;
  }

  if(istrue(self.isdisconnecting)) {
    var_b64f283113c99581 = self.plundercount;
    var_ae5066e110a1c221 = self.plundercount;
    var_6aee9c9054f09ed5 = 0;

    if(!isDefined(var_b64f283113c99581)) {
      return;
    }
  } else {
    dropinfo = scripts\mp\gametypes\br_plunder::function_79275e2fab13f54d();
    var_b64f283113c99581 = dropinfo.var_b64f283113c99581;
    var_6aee9c9054f09ed5 = dropinfo.var_6aee9c9054f09ed5;

    if(!isDefined(var_b64f283113c99581)) {
      return;
    }

    finalmod = 1;
    bonuscash = 0;

    if(istrue(self.wasexecuted)) {
      executionmod = level.executioncashmultiplier;

      if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"bloodmoney")) {
        executionmod *= level.br_pe_data[%"bloodmoney"].var_ee5fb771f83add5e;
      }

      finalmod *= executionmod;
    }

    if(istrue(level.bmoovertime) && (!isDefined(attacker) || self != attacker)) {
      finalmod *= level.overtimecashmultiplier;
    }

    var_b64f283113c99581 *= finalmod;
    var_b64f283113c99581 += bonuscash;
    var_651927b6a8813428 = level.minplunderdropondeath;
    var_f84c055c8b9bf87e = level.maxplunderdropondeath;

    if(istrue(level.bmoovertime)) {
      if(isDefined(level.bonusdeathplunderot) && (!isDefined(var_651927b6a8813428) || level.bonusdeathplunderot > var_651927b6a8813428)) {
        var_651927b6a8813428 = level.bonusdeathplunderot;
      }

      if(isDefined(level.maxplunderdropinovertime)) {
        var_f84c055c8b9bf87e = level.maxplunderdropinovertime;
      }
    }

    if(!isDefined(var_651927b6a8813428)) {
      var_651927b6a8813428 = 0;
    }

    if(isDefined(var_f84c055c8b9bf87e)) {
      var_b64f283113c99581 = int(clamp(var_b64f283113c99581, var_651927b6a8813428, var_f84c055c8b9bf87e));
    } else {
      var_b64f283113c99581 = int(max(var_b64f283113c99581, var_651927b6a8813428));
    }
  }

  var_ae5066e110a1c221 = int(max(var_47545befc5dedb97 - var_6aee9c9054f09ed5, 0));
  self.plundercountondeath = var_6aee9c9054f09ed5;

  if(var_ae5066e110a1c221 > 0) {
    scripts\mp\gametypes\br_plunder::playerplunderdrop(var_ae5066e110a1c221);
  }

  if(var_b64f283113c99581 > 0) {
    pickupents = dropplunderbyrarity(var_b64f283113c99581, dropstruct);

    foreach(ent in pickupents) {
      ent.lootsource = "combat";
    }
  }

  if(isDefined(level.lootleaders) && array_contains(level.lootleaders, self)) {
    playFX(getfx("money"), self.origin + (0, 0, 64));
  }

  if(isDefined(attacker) && self == attacker || !level.killcam) {
    self setclientomnvar("ui_cash_dropped", var_ae5066e110a1c221);
  } else {
    self.postkillcamplunderlost = var_ae5066e110a1c221;
  }

  scripts\mp\gametypes\br_analytics::trackcashevent(self, "combat", var_ae5066e110a1c221 * -1);
  scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(3, var_ae5066e110a1c221);

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    level notify("victim_death_drop", self, attacker, pickupents);
  }

  var_73dc67ec76d54557 = string(max(var_47545befc5dedb97 - var_6aee9c9054f09ed5 + var_b64f283113c99581, 0));
  println("<dev string:xee>" + var_47545befc5dedb97 + "<dev string:x10f>" + var_6aee9c9054f09ed5 + "<dev string:x11b>" + var_b64f283113c99581 + "<dev string:x12a>" + var_73dc67ec76d54557);

  return 1;
}

function onpostkillcamcallback() {
  if(isDefined(self.postkillcamplunderlost)) {
    self setclientomnvar("ui_cash_dropped", int(self.postkillcamplunderlost));
    self.postkillcamplunderlost = undefined;
  }
}

function dropplunderbyrarity(amount, dropstruct) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  pickupents = [];
  numspawns = [];
  totalcount = 0;

  for(i = level.br_plunder.quantity.size - 1; i >= 0; i--) {
    numspawns[i] = int(amount / level.br_plunder.quantity[i]);
    totalcount += numspawns[i];

    if(amount <= 0) {
      break;
    }

    amount -= numspawns[i] * level.br_plunder.quantity[i];
  }

  for(var_f90d0e006a1f717b = level.br_plunder.quantity.size - 1; var_f90d0e006a1f717b >= 0; var_f90d0e006a1f717b--) {
    if(!isDefined(numspawns[var_f90d0e006a1f717b])) {
      continue;
    }

    for(itemindex = 0; itemindex < numspawns[var_f90d0e006a1f717b]; itemindex++) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      pickupent = scripts\mp\gametypes\br_pickups::spawnpickup(level.br_plunder.names[var_f90d0e006a1f717b], dropinfo, level.br_plunder.quantity[var_f90d0e006a1f717b], 1);
      scripts\mp\gametypes\br_plunder::modify_plunder_itemsinworld(level.br_plunder.names[var_f90d0e006a1f717b], 1);

      if(isDefined(pickupent)) {
        pickupents[pickupents.size] = pickupent;

        if(scripts\mp\gametypes\br_plunder::inplunderlivelobby()) {
          level.br_plunder_ents[level.br_plunder_ents.size] = pickupent;
        }
      }
    }
  }

  level.br_plunder.plunder_items_dropped += totalcount;
  level.br_plunder.plunder_value_dropped += amount;
  level thread scripts\mp\gametypes\br_plunder::dropplundersounds(self.origin, pickupents.size);
  return pickupents;
}

function getcost() {
  if(level.dmzminextractcost > 0) {
    cost = int(max(level.dmzminextractcost, level.dmzextractcost - level.brgametype.numextractions * level.dmzextractcostdecrease));
  }

  return level.dmzextractcost;
}

function getwincost() {
  return level.dmzwincost;
}

function playertakeextractionplunder(amount) {
  if(self.plundercount < amount) {
    amount = self.plundercount;
  }

  if(!isDefined(self.plunderforextract)) {
    self.plunderforextract = 0;
  }

  self.plunderforextract += amount;
  scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount - amount);
  return amount;
}

function teamclearextractplunder(team) {
  teammates = level.teamdata[team]["players"];

  foreach(player in teammates) {
    player.plunderforextract = 0;
  }
}

function teamrefundplunder(team) {
  teammates = level.teamdata[team]["players"];

  foreach(player in teammates) {
    if(isDefined(player.plunderforextract)) {
      player scripts\mp\gametypes\br_plunder::playerplunderpickup(player.plunderforextract, undefined, undefined, 1);
      player.plunderforextract = 0;
      player iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

function huddopulse() {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }

  var_cc2c2f3eac3c7bd2 = 0.5;
  var_5f2809f4e8852c13 = 4;
  self.pulsing = 1;
  originalscale = self.fontscale;
  self changefontscaleovertime(var_cc2c2f3eac3c7bd2);
  self.fontscale = var_5f2809f4e8852c13;
  wait var_cc2c2f3eac3c7bd2;
  self changefontscaleovertime(var_cc2c2f3eac3c7bd2);
  self.fontscale = originalscale;
  self.pulsing = undefined;
}

function drophelicrate(heli) {
  crate = spawn("script_model", heli.origin);
  crate setModel("military_skyhook_backpack");
  startorg = heli.origin;
  end = (startorg[0], startorg[1], -12000);
  contents = create_contents(0, 1, 1, 1, 1, 1, 0);
  trace = ray_trace(startorg, end, heli, contents);
  groundorg = trace["position"];
  dist = startorg[2] - groundorg[2];

  if(dist > 0) {
    time = sqrt(2 * dist / 800);
    crate moveTo(groundorg, time, time, 0);
    wait time;
  }

  crate.origin = groundorg;
  playFX(getfx("airdrop_crate_impact_ground"), groundorg);
  crate cratedropplunder();
  crate delete();
}

function cratedropplunder() {
  amount = getcost();
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(amount, dropstruct);
}

function calculatehelitimetoflysec(distinches, speedmph, accelmph) {
  distmiles = distinches * 1.57828e-05;
  a = 0.5 * accelmph;
  b = speedmph;
  c = -1 * distmiles;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / 2 * a;
  flytime *= 3600;
  flytime += 1.5;
  return flytime;
}

function calculatehelitimetoarrive(var_625180ce8d2f8f77) {
  arrivetime = calculatehelitimetoflysec(30000, 100, 125);
  descendtime = calculatehelitimetoflysec(var_625180ce8d2f8f77, 25, 31.25);
  totaltime = arrivetime + descendtime;
  return totaltime;
}

function helisetteamextractionhud(state, timesec) {
  endtimems = gettime() + int(timesec * 1000);
  teamplayers = level.teamdata[self.team]["alivePlayers"];

  foreach(player in teamplayers) {
    player setcachedclientomnvar("ui_br_plunder_extract_state", state);
    player setcachedclientomnvar("ui_br_timed_feature_end_time", endtimems);
  }
}

function helibankplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("plunder_extract_success", self.team, 1);
  var_a8eeb94dcc610b78 = 0;
  contains_enemy_plunder = 0;

  foreach(item in self.plunder) {
    var_a8eeb94dcc610b78 += item.plundercount;

    if(item.player.team != self.team) {
      contains_enemy_plunder = 1;
    }
  }

  scripts\mp\gametypes\br_analytics::branalytics_plunder_extraction_success(self.plunder.size, var_a8eeb94dcc610b78, "little_bird", contains_enemy_plunder, self.endpoint);
  level.br_plunder.extraction_helicoptor_total_plunder += var_a8eeb94dcc610b78;
  level.br_plunder.extraction_helicoptor_num_completed++;
  scripts\mp\gametypes\br_plunder::entityplunderbankalldeposited();
}

function heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = array_remove(level.br_depots, self.usable);
    self.usable = undefined;
  }
}

function helicleanupdepotonleaving(usable) {
  self.usable endon("death");
  waittill_either("leaving", "death");
  heliusecleanup();
}

function helicreateextractvfx(position) {
  self.vfxent = spawn("script_model", position);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

function helicleanupextract(enablesite) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(enablesite) && isDefined(self.site)) {
    self.site setscriptablepartstate(self.site.type, self.site.activestate);
  }
}

function helidisapateextractvfx() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }

  wait 5;
  self.vfxent endon("death");
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

function spawnheli(owner, pathstart, pathgoal, pathexit) {
  angles = vectortoangles(pathgoal - pathstart);
  numflares = 99;
  modelname = "veh8_mil_air_mindia8_plunder_x";
  vehicle = "veh_apache_plunder_mp";

  if(istrue(level.var_a83a4e71446bfef7)) {
    modelname = "veh9_mil_air_heli_blima_mp_x";
    vehicle = "veh9_mil_air_heli_blima_nophysics_br";
  }

  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, vehicle, modelname);

  if(!isDefined(heli)) {
    return;
  }

  endpoint = pathgoal * (1, 1, 0);
  heli.damagecallback = &callback_vehicledamage;
  heli.speed = 50;
  heli.accel = 99999;
  heli.health = 1000;
  heli.maxhealth = heli.health;
  heli.team = owner.team;
  heli.owner = owner;
  heli.defendloc = pathgoal;
  heli.lifeid = 0;
  heli.flaresreservecount = numflares;
  heli.pathgoal = pathgoal;
  heli.pathexit = pathexit;
  heli.endpoint = endpoint;
  heli.goalyaw = angles[1];
  heli.vehiclename = "magma_plunder_chopper";
  heli setCanDamage(1);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(50, 100, 50);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  spawnrope(heli);
  heli thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  heli thread healdamage();
  heli thread handledestroydamage();
  heli thread helidestroyed();
  return heli;
}

function spawnrope(heli) {
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("br_plunder_extraction_delivery_rope");
  rope linkTo(heli, "side_door_l_jnt", (11, 20, 42), (0, 180, 0));
  crate = spawn("script_model", (0, 0, 0));
  crate setModel("br_plunder_extraction_delivery_bag");
  crate linkTo(rope, "dyn_rope_end", (0, 0, 0), (0, 0, 0));
  heli.rope = rope;
  heli.crate = crate;
}

function helidestroyed() {
  self endon("heli_gone");
  self endon("swapped");
  owner = self.owner;
  team = self.team;
  self waittill("death", attacker, meansofdeath, weaponobject, damagelocation);
  teamrefundplunder(team);
  helicleanup();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread helicrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  heliexplode(attacker);
}

function helicleanup() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    self.crate delete();
  }
}

function heliexplode(attacker) {
  explosionposition = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(explosionposition, 256, 140, 70, attacker, "MOD_EXPLOSIVE");
  playFX(getfx("little_bird_explode"), explosionposition, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(explosionposition, "veh_chopper_support_crash");
  earthquake(0.4, 800, explosionposition, 0.7);
  playrumbleonposition("grenade_rumble", explosionposition);
  physicsexplosionsphere(explosionposition, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::teamsplashbr("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  helicleanupextract(1);
  helidelete();
}

function helidelete() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function helicrash(speed) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health) {
      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
      helicleanupextract(1);
    }
  }
}

function callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

function helileave() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.goalyaw);
  helisetteamextractionhud(3, self.flytime);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.pathexit, 1);
  self settargetyaw(self.goalyaw);
  self waittill("goal");
  self stoploopsound();
  helibankplunder();
  helisetteamextractionhud(0, 0);
  self notify("heli_gone");
  helidelete();
}

function helidescend(location, groundz) {
  self endon("death");
  locationx = location[0];
  locationy = location[1];
  newpos = (locationx, locationy, groundz);
  self setvehgoalpos(newpos, 1);
  self settargetyaw(self.goalyaw);
  self vehicle_setspeed(25, 31.25);
  thread helidestroyvehiclestouchnotify();
  thread helidestroyvehiclestouchtrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

function entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function helidestroyvehiclestouchnotify() {
  self endon("leaving");
  self endon("death");

  while(true) {
    self waittill("touch", vehicle);

    if(isDefined(vehicle) && vehicle entisalivevehicle()) {
      vehicle dodamage(vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH");
    }
  }
}

function helidestroyvehiclestouchtrace() {
  self endon("leaving");
  self endon("death");
  radius = 70;
  offsetdown = -80;
  forward = 150;
  middle = 25;
  back = -100;

  while(true) {
    vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat(@ "test_radius", 400));

    if(vehicles.size <= 1) {
      wait 0.5;
      continue;
    }

    vehiclecontents = create_vehicle_contents();
    dir = anglesToForward(self.angles);
    origin = self.origin + dir * getdvarfloat(@ "test_f", forward) + (0, 0, getdvarfloat(@ "test_d", offsetdown));
    trace = sphere_trace(origin, origin + (0, 0, 1), radius, self, vehiclecontents);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat(@ "test_m", middle) + (0, 0, getdvarfloat(@ "test_d", offsetdown));
    trace = sphere_trace(origin, origin + (0, 0, 1), radius, self, vehiclecontents);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat(@ "test_b", back) + (0, 0, getdvarfloat(@ "test_d", offsetdown));
    trace = sphere_trace(origin, origin + (0, 0, 1), radius, self, vehiclecontents);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function tracegroundheight(start) {
  var_dc8bb6300463cf1e = 125;
  groundpt = tracegroundpoint(start, 100, [self]);
  groundheight = groundpt[2];
  trueheight = groundheight + var_dc8bb6300463cf1e;
  return trueheight;
}

function tracegroundpoint(start, radius, ignorelist) {
  var_379ff849b3cda7d7 = -99999;
  end = (start[0], start[1], var_379ff849b3cda7d7);
  contents = create_world_contents();
  trc = undefined;

  if(isDefined(radius)) {
    trc = sphere_trace(start, end, radius, ignorelist, contents);
  } else {
    trc = ray_trace(start, end, ignorelist, contents);
  }

  return trc["position"];
}

function heliwatchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread helileave();
}

function initextractionlocations() {
  extractionlocations = [];

  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    extractionlocations[extractionlocations.size] = (-33750, -36000, 155);
    extractionlocations[extractionlocations.size] = (-41550, -7950, 515);
    extractionlocations[extractionlocations.size] = (-37500, 15350, 1130);
    extractionlocations[extractionlocations.size] = (-31950, 52015, 2265);
    extractionlocations[extractionlocations.size] = (-18510, 64815, 1940);
    extractionlocations[extractionlocations.size] = (15565, 60050, 2680);
    extractionlocations[extractionlocations.size] = (44400, 39255, -50);
    extractionlocations[extractionlocations.size] = (59780, 13800, 555);
    extractionlocations[extractionlocations.size] = (61200, -8445, 30);
    extractionlocations[extractionlocations.size] = (59325, -38390, -210);
    extractionlocations[extractionlocations.size] = (8660, -36630, -640);
  } else {
    switch (level.mapname) {
      case #"hash_4aa5d6e97851bdbd":
        extractionlocations[extractionlocations.size] = (1500, 1500, 0);
        extractionlocations[extractionlocations.size] = (2500, 1500, 0);
        extractionlocations[extractionlocations.size] = (3500, 1500, 0);
        extractionlocations[extractionlocations.size] = (4500, 1500, 0);
        break;
      case #"hash_822ffed9bd418efc":
        break;
    }
  }

  level.extractionlocations = extractionlocations;
  level.extractingplayers = [];
  level thread monitorextractionlocations();
}

function createextractionlocation(origin) {}

function monitorextractionlocations() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(location in level.extractionlocations) {
    objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
    assert(objectiveiconid != -1);

    if(objectiveiconid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", location, "icon_waypoint_flag");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
    }

    level thread spawnextractsmoke(location);
  }

  while(true) {
    foreach(location in level.extractionlocations) {
      players = scripts\mp\utility\player::getplayersinradius(location, 300);

      foreach(player in players) {
        if(!array_contains(level.extractingplayers, player) && !istrue(player.extractioncomplete)) {
          player extactionstart(location);
        }
      }
    }

    foreach(player in level.extractingplayers) {
      if(distancesquared(player.origin, player.extractionlocation) > 90000) {
        player extactioncancel();
        continue;
      }

      player.extractiontime -= level.framedurationseconds;

      if(player.extractiontime <= 0) {
        player extactioncomplete();
      }
    }

    waitframe();
  }
}

function spawnextractsmoke(location) {
  pos = scripts\mp\gametypes\br_public::droptogroundmultitrace(location, 50, -200);
  vfxent = spawn("script_model", pos + (0, 0, 3));
  vfxent setModel("scr_smoke_grenade");
  wait 1;
  playFXOnTag(getfx("vfx_smk_signal_red"), vfxent, "tag_fx");
  vfxent playLoopSound("mp_flare_burn_lp");
}

function extactionstart(location) {
  self iprintlnbold("Extraction Start!");
  level.extractingplayers = array_add(level.extractingplayers, self);
  self.extractionlocation = location;
  self.extractiontime = 10;
  thread showextractiontime();
}

function showextractiontime() {
  self endon("death_or_disconnect");
  self endon("extactionCancel");

  while(self.extractiontime > 0) {
    self iprintlnbold("Extracting in " + math::round_float(self.extractiontime, 1));
    waitframe();
  }
}

function extactioncancel() {
  self notify("extactionCancel");
  self iprintlnbold("Extraction Canceled!");
  level.extractingplayers = array_remove(level.extractingplayers, self);
  self.extractionlocation = undefined;
  self.extractiontime = undefined;
}

function extactioncomplete() {
  self iprintlnbold("Extraction Complete!");
  level.extractingplayers = array_remove(level.extractingplayers, self);
  self.extractioncomplete = 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_EXTRACTED");
}

function autoassignquest(player) {
  if(!isDefined(level.questinfo.teamsonquests) || array_contains(level.questinfo.teamsonquests, player.team)) {
    return;
  }

  var_73a1687c46c4d341 = [];

  foreach(type in level.validautoassignquests) {
    var_73a1687c46c4d341 = array_combine(var_73a1687c46c4d341, getlootscriptablearray("brloot_" + type + "_tablet"));
  }

  var_73a1687c46c4d341 = array_randomize(var_73a1687c46c4d341);
  closesttablet = undefined;
  var_31a0a0ed9e70e900 = undefined;

  foreach(questtablet in var_73a1687c46c4d341) {
    dist = distance_2d_squared(player.origin, questtablet.origin);

    if(dist <= 16777216 && dist >= 16384) {
      player namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(questtablet);
      return;
    }

    if(!isDefined(closesttablet) || dist < var_31a0a0ed9e70e900) {
      closesttablet = questtablet;
      var_31a0a0ed9e70e900 = dist;
    }
  }

  if(isDefined(closesttablet)) {
    player namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(closesttablet);
  }
}

function missions_clearinappropriaterewards(rewards) {
  var_36f04620526242ff = [];

  foreach(key, reward in rewards) {
    if(key == "circle_peek") {
      continue;
    }

    var_36f04620526242ff[key] = reward;
  }

  return var_36f04620526242ff;
}

function handleplunderendgamesplash(winner) {
  winnerplayers = [];

  if(isDefined(winner) && winner != "tie") {
    winnerplayers = getteamdata(winner, "players");
  }

  var_464dd76c6ecb56fa = scripts\mp\gamelogic::getbrendsplashpostgamestate();

  foreach(player in level.players) {
    if(winnerplayers.size > 0 && array_contains(winnerplayers, player)) {
      player setcachedclientomnvar("post_game_state", var_464dd76c6ecb56fa);
      player setcachedclientomnvar("ui_br_end_game_splash_type", 11);
      continue;
    }

    player setcachedclientomnvar("post_game_state", var_464dd76c6ecb56fa);
    player setcachedclientomnvar("ui_br_end_game_splash_type", 12);
  }
}

function updateteamplunderscore(var_7eddf19f11da2f94, team, var_c6544e2c82d62dfb) {
  oldscore = _getteamscore(team);
  delta = var_7eddf19f11da2f94 - oldscore;

  if(delta != 0) {
    skipvo = ter_op(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf(), 1, undefined);
    level thread giveteamscoreforobjective(team, delta, 0, undefined, skipvo, var_c6544e2c82d62dfb);
  }

  return delta;
}

function updatelootleadersonfixedinterval() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  interval = getdvarfloat(@ "hash_81be161d3102cc0e", 15);
  blinkinterval = getdvarfloat(@ "hash_b82244f91b963437", 5);
  initialvalue = getdvarint(@ "hash_114aa0db563f4c19", 800);
  finalvalue = getdvarint(@ "hash_4f47f4bd5cfef308", 200);
  solidinterval = interval - blinkinterval;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");

  for(firstpass = 1; true; firstpass = 0) {
    level.plunderupdatelootleadermarks = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", solidinterval);

    if(blinkinterval > 0) {
      function_b97f3e1b29916d34("Expired_");
      scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", blinkinterval);
      function_b97f3e1b29916d34();
    }
  }
}

function function_b97f3e1b29916d34(indexprefix) {
  for(i = 0; i < level.lootleadermarkcount; i++) {
    if(level.lootleadermarksontopteams > 0 && i == 0) {
      idindex = "LootLeaderTop_Plunder";
    } else {
      idindex = "LootLeader_Plunder";
    }

    if(isDefined(indexprefix)) {
      idindex = indexprefix + idindex;
    }

    level.lootleadermarks[i] scripts\cp_mp\utility\game_utility::function_6a52fd9d448df322(idindex);
  }
}

function updatecirclepulse(startval, endval, duration) {
  currenttime = gettime();
  duration *= 1000;
  endtime = int(currenttime + duration);
  diff = abs(startval - endval);

  while(true) {
    currenttime = gettime();
    t = clamp(1 - (endtime - currenttime) / duration, 0, 1);
    frac = ter_op(startval < endval, diff * t + startval, startval - diff * t);
    setDvar(@ "hash_1256574652334627", frac);

    if(t == 1) {
      break;
    }

    waitframe();
  }
}

function updatelootleadermarks(playerscores, playersorted, playerlookup, teamsorted) {
  level.lootleadersprev = level.lootleaders;
  level.lootleaders = [];

  if(level.lootleaderoneperteam) {
    if(istrue(level.bmoovertime)) {
      level.lootleadermarkcount = adjustlootleadermarkcount();

      foreach(mark in level.lootleadermarks) {
        mark function_4eaf685bc40a3b9();
      }
    }
  }

  if(level.lootleadermarksontopteams == 1) {
    for(i = 0; i < level.lootleadermarkcount; i++) {
      var_d546f00edc1b5fc7 = getlootteamleader(i, playerscores, teamsorted);

      if(isDefined(var_d546f00edc1b5fc7)) {
        level.lootleaders[level.lootleaders.size] = playerlookup[var_d546f00edc1b5fc7];

        if(istrue(level.expiredlootleaderenabled)) {
          if(isDefined(playerlookup[var_d546f00edc1b5fc7].expiredlootleaderinstance)) {
            removeplayerasexpiredlootleader(playerlookup[var_d546f00edc1b5fc7].expiredlootleaderinstance);
          }
        }
      }
    }
  } else if(level.lootleadermarksontopteams == 2) {
    var_d546f00edc1b5fc7 = getlootteamleader(0, playerscores, teamsorted);

    if(isDefined(var_d546f00edc1b5fc7)) {
      level.lootleaders[0] = playerlookup[var_d546f00edc1b5fc7];

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(playerlookup[var_d546f00edc1b5fc7].expiredlootleaderinstance)) {
          removeplayerasexpiredlootleader(playerlookup[var_d546f00edc1b5fc7].expiredlootleaderinstance);
        }
      }
    }

    foreach(playerkey in playersorted) {
      player = playerlookup[playerkey];
      plunder = playerscores[playerkey];

      if(plunder == 0) {
        break;
      }

      if(array_contains(level.lootleaders, player)) {
        continue;
      }

      level.lootleaders[level.lootleaders.size] = player;

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(player.expiredlootleaderinstance)) {
          removeplayerasexpiredlootleader(player.expiredlootleaderinstance);
        }
      }

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  } else {
    foreach(player in playersorted) {
      plunder = playerscores[player];

      if(plunder == 0) {
        break;
      }

      level.lootleaders[level.lootleaders.size] = playerlookup[player];

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(playerlookup[player].expiredlootleaderinstance)) {
          removeplayerasexpiredlootleader(playerlookup[player].expiredlootleaderinstance);
        }
      }

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  }

  foreach(player in level.lootleadersprev) {
    if(isDefined(player) && !array_contains(level.lootleaders, player)) {
      removeplayeraslootleader(player);
    }
  }

  for(i = 0; i < level.lootleadermarkcount; i++) {
    instance = level.lootleadermarks[i];

    if(isDefined(level.lootleaders[i])) {
      instance.targetplayer = level.lootleaders[i];
      instance.targetplayer.lootleaderinstance = instance;
      location = (instance.targetplayer.origin[0], instance.targetplayer.origin[1], level.lootleadermarksize);

      if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
        location += math::random_vector_2d() * randomfloatrange(100, 1000);
      }

      instance function_6e148c8da2e4db13(location);

      if(istrue(level.lootleadermarksizedynamic)) {
        updatelootleadercirclesize(instance);
      }

      newmark = array_contains(level.lootleaders, instance.targetplayer) && !array_contains(level.lootleadersprev, instance.targetplayer);
      showtoplayers = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

      foreach(player in showtoplayers) {
        instance function_cfd53c8f6878014f(player);
      }

      hidefromplayers = scripts\mp\utility\teams::getfriendlyplayers(instance.targetplayer.team, 0);

      foreach(player in hidefromplayers) {
        instance function_d7d113d56ef0ef5b(player);
      }

      if(newmark) {
        addplayeraslootleader(instance);
      }

      continue;
    }

    instance.targetplayer = undefined;

    foreach(player in level.players) {
      instance function_d7d113d56ef0ef5b(player);
    }
  }
}

function getlootteamleader(index, playerscores, teamsorted) {
  team = teamsorted[index];
  var_9fb5def50e853261 = 0;
  plunder = 0;

  if(level.teamdata[team]["players"].size == 0) {
    return undefined;
  }

  var_d546f00edc1b5fc7 = level.teamdata[team]["players"][0].guid;

  foreach(player in level.teamdata[team]["players"]) {
    var_9fb5def50e853261 = playerscores[player.guid];

    if(var_9fb5def50e853261 > plunder) {
      plunder = var_9fb5def50e853261;
      var_d546f00edc1b5fc7 = player.guid;
    }
  }

  return var_d546f00edc1b5fc7;
}

function addplayeraslootleader(instance) {
  player = instance.targetplayer;

  if(isreallyalive(player)) {
    if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      player scripts\mp\hud_message::showsplash("br_plunder_you_are_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    }

    player cashleaderbag_attach();

    if(istrue(level.expiredlootleaderenabled)) {
      player thread watchforplayerdeath(instance);
    }
  }
}

function removeplayeraslootleader(player) {
  if(isDefined(player.attached_bag)) {
    player cashleaderbag_detach();
  }

  if(isDefined(player.lootleaderinstance)) {
    foreach(entry in level.players) {
      player.lootleaderinstance function_d7d113d56ef0ef5b(entry);
    }

    circleorigin = player.lootleaderinstance function_d9583306c5a171e4();

    if(istrue(level.expiredlootleaderenabled)) {
      addplayerasexpiredlootleader(player, circleorigin);
    }

    player.lootleaderinstance.targetplayer = undefined;
    player.lootleaderinstance = undefined;
  }

  level.lootleaders = array_remove(level.lootleaders, player);
}

function watchforplayerdeath(instance) {
  self endon("disconnect");
  self waittill("death");
  circleorigin = self.lootleaderinstance function_d9583306c5a171e4();
  removeplayeraslootleader(self);
  addplayerasexpiredlootleader(self, circleorigin);
}

function addplayerasexpiredlootleader(player, circleorigin) {
  if(array_contains(level.expiredlootleaders, player)) {
    return;
  }

  level.expiredlootleaders = array_add(level.expiredlootleaders, player);
  instance = undefined;

  foreach(entry in level.expiredlootleadermarks) {
    if(!isDefined(entry.targetplayer)) {
      instance = entry;
      break;
    }
  }

  if(!isDefined(instance)) {
    oldesttime = undefined;

    foreach(entry in level.expiredlootleadermarks) {
      if(!isDefined(oldesttime) || entry.lastusedtime < oldesttime) {
        oldesttime = entry.lastusedtime;
        instance = entry;
      }
    }

    instance.targetplayer notify("stop_update");
  }

  instance.targetplayer = player;
  instance.lastusedtime = gettime();
  player.expiredlootleaderinstance = instance;

  if(isDefined(circleorigin)) {
    instance function_6e148c8da2e4db13(circleorigin);
  } else {
    location = (instance.targetplayer.origin[0], instance.targetplayer.origin[1], level.lootleadermarksize);
    location += math::random_vector_2d() * randomfloatrange(100, 1000);
    instance function_6e148c8da2e4db13(location);
  }

  if(istrue(level.lootleadermarksizedynamic)) {
    updatelootleadercirclesize(instance);
  }

  showtoplayers = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

  foreach(entry in showtoplayers) {
    instance function_cfd53c8f6878014f(entry);
  }

  hidefromplayers = scripts\mp\utility\teams::getfriendlyplayers(instance.targetplayer.team, 0);

  foreach(entry in hidefromplayers) {
    instance function_d7d113d56ef0ef5b(entry);
  }

  thread updateexpiredlootleader(instance);
}

function updateexpiredlootleader(instance) {
  instance.targetplayer endon("stop_update");
  wait 5;
  removeplayerasexpiredlootleader(instance);
}

function removeplayerasexpiredlootleader(instance) {
  player = instance.targetplayer;
  level.expiredlootleaders = array_remove(level.expiredlootleaders, instance.targetplayer);
  instance.targetplayer.expiredlootleaderinstance = undefined;
  instance.targetplayer = undefined;

  foreach(entry in level.players) {
    instance function_d7d113d56ef0ef5b(entry);
  }

  player notify("stop_update");
}

function cashleaderbag_attach() {
  assertex(isPlayer(self), "<dev string:x136>");
  assertex(!isDefined(self.attached_bag), "<dev string:x17f>");
  modeltype = getmatchrulesdata("brData", "plunderModelType");
  modelname = "accessory_money_bag_large_closed_player";

  switch (modeltype) {
    case #"hash_59b8e9d05b31ff9":
      modelname = "accessory_money_bag_large_closed_player_plunder";
      break;
  }

  self attach(modelname, "tag_stowed_back3", 1, 1);
  self.attached_bag = modelname;

  if(self tagexists("j_bag_left")) {
    playFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
  }

  thread cashleader_trackdeath();
}

function cashleaderbag_detach() {
  assertex(isPlayer(self), "<dev string:x1cb>");
  assertex(isDefined(self.attached_bag), "<dev string:x214>");

  if(isDefined(self) && isDefined(self.attached_bag)) {
    if(self tagexists("j_bag_left")) {
      stopFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
    }

    self detach(self.attached_bag, "tag_stowed_back3");
    self.attached_bag = undefined;
  }

  self notify("killthread_bagModelSwap");
}

function cashleader_trackdeath() {
  self notify("cashleader_trackDeath");
  self endon("cashleader_trackDeath");
  self endon("killthread_bagModelSwap");
  self waittill("death");
  cashleaderbag_detach();
}

function packextrascore0(data) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(getsubgametype() == "kingslayer" || getsubgametype() == "resurgence") {
    return;
  }

  packedvalue = 0;
  cashvalue = 0;

  if(isDefined(self.plundercount)) {
    cashvalue += self.plundercount;
  }

  if(isDefined(self.plunderbanked)) {
    cashvalue += self.plunderbanked;
  }

  cashvalue = int(cashvalue / 10);

  if(cashvalue > 4095) {
    cashvalue = 4095;
  }

  packedvalue = cashvalue;
  missionvalue = 0;

  if(isDefined(self.missionparticipation)) {
    missionvalue += self.missionparticipation;
  }

  if(missionvalue > 15) {
    missionvalue = 15;
  }

  packedvalue += missionvalue << 12;
  setextrascore0(packedvalue);
}

function packclientmatchdata() {
  packedvalue = 0;
  cashvalue = 0;

  if(isDefined(self.plundercount)) {
    cashvalue += self.plundercount;
  }

  if(isDefined(self.plunderbanked)) {
    cashvalue += self.plunderbanked;
  }

  cashvalue = int(cashvalue / 10);

  if(cashvalue > 4095) {
    cashvalue = 4095;
  }

  packedvalue = cashvalue;
  missionvalue = 0;

  if(isDefined(self.brmissionscompleted)) {
    missionvalue += self.brmissionscompleted;
  }

  if(missionvalue > 15) {
    missionvalue = 15;
  }

  packedvalue += missionvalue << 12;
  return packedvalue;
}

function playerlootleadervalidity() {
  self endon("disconnect");

  if(isDefined(level.lootleaders) && array_contains(level.lootleaders, self)) {
    scripts\mp\hud_message::showsplash("br_plunder_you_are_marked", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    cashleaderbag_attach();
  }
}

function updatelootleadercirclesize(instance) {
  if(isDefined(instance.targetplayer.plundercount)) {
    playervalue = instance.targetplayer.plundercount;
  } else {
    playervalue = 0;
  }

  playervalue = clamp(playervalue, level.lootleadermarkweakvalue, level.lootleadermarkstrongvalue);
  range = level.lootleadermarkstrongvalue - level.lootleadermarkweakvalue;
  frac = (playervalue - level.lootleadermarkweakvalue) / range;
  circlerange = level.lootleadermarkweaksize - level.lootleadermarkstrongsize;
  circlesize = level.lootleadermarkweaksize - frac * circlerange;
  instance function_4584ad1c0e2c58ec(circlesize);
}

function adjustlootleadermarkcount(placements) {
  var_11a4492adc953ff5 = 0;
  placements = getteamscoreplacements();
  wintarget = getwincost();

  for(i = 1; i < level.maxlootleadermarkcount + 1; i++) {
    foreach(team in level.teamnamelist) {
      if(placements[team] != i) {
        continue;
      }

      teamplunder = scripts\mp\gametypes\br_plunder::getteamplunder(team) * 10;

      if(teamplunder >= wintarget || placements[team] == 1) {
        var_11a4492adc953ff5++;
      }
    }
  }

  if(var_11a4492adc953ff5 > level.maxlootleadermarkcount) {
    var_11a4492adc953ff5 = level.maxlootleadermarkcount;
  }

  return var_11a4492adc953ff5;
}

function displayplunderloss(player, delta) {
  var_83e60cf2f8b66836 = 0;
  var_350f8764871aa143 = 0;
  var_1e89d40fe2954ab6 = 20;
  delta *= 10;
  teamplunder = player.plundercount * 10;
  plunderstart = teamplunder + delta;
  current = plunderstart;
  target = teamplunder;
  diff = target - plunderstart;
  sign = sign(diff);
  var_b749e3228ec71e90 = diff / 2;
  var_585aae66e20728c4 = int(var_b749e3228ec71e90 * 2 * level.framedurationseconds);

  if(var_585aae66e20728c4 == 0) {
    return;
  }

  plunderlost = createhudelem(&"MP_BR_INGAME/PLUNDER_DEATH_LOSS", delta, "RIGHT", "CENTER", var_83e60cf2f8b66836 + 46, var_350f8764871aa143, undefined, undefined, 1.25, player);
  plunderlost.alpha = 1;
  yourteam = createhudelem(&"MP_BR_INGAME/YOUR_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", var_83e60cf2f8b66836, var_350f8764871aa143 + var_1e89d40fe2954ab6, undefined, undefined, 1.25, player);
  yourteam.alpha = 1;
  var_aa9c740500dd5694 = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER", plunderstart, "LEFT", "CENTER", var_83e60cf2f8b66836 + 45, var_350f8764871aa143 + var_1e89d40fe2954ab6, undefined, undefined, 1.25, player);
  var_aa9c740500dd5694.alpha = 1;
  wait 1;

  while(current != target) {
    current += var_585aae66e20728c4;

    if(sign > 0 && current > target || sign < 0 && current < target) {
      current = target;
    }

    var_aa9c740500dd5694 setvalue(current);
    wait level.framedurationseconds;
  }

  wait 3;
  plunderlost destroy();
  yourteam destroy();
  var_aa9c740500dd5694 destroy();
}

function _getplunderextractlocations(var_532388c61e12b9df, maxlocations, var_395f0c06f7abdcc1) {
  if(var_532388c61e12b9df.size == 0 || maxlocations == 0) {
    return;
  }

  spawnstructs = [];
  newarraysize = [];

  if(var_532388c61e12b9df.size > 0) {
    var_532388c61e12b9df = scripts\engine\utility::array_randomize(var_532388c61e12b9df);
    newarraysize = int(min(maxlocations, var_532388c61e12b9df.size));
  }

  if(level.setupevenlydistributedpads) {
    dist = 0;

    if(level.adjusteventdistributionpadding > 0 && istrue(var_395f0c06f7abdcc1)) {
      siteindex = 0;

      for(i = 0; i < newarraysize; i++) {
        if(siteindex > level.paddedquadgridcenterpoints.size - 1) {
          siteindex = 0;
        }

        var_ed7960f0edb5f2a0 = level.paddedquadgridcenterpoints[siteindex];

        foreach(exsite in var_532388c61e12b9df) {
          if(pointinsquare(exsite.origin, var_ed7960f0edb5f2a0, level.pointinsquarewidth)) {
            spawnstructs[spawnstructs.size] = exsite;
            var_532388c61e12b9df = array_remove(var_532388c61e12b9df, exsite);
            break;
          }
        }

        siteindex++;
      }
    } else {
      foreach(exsite in var_532388c61e12b9df) {
        dist = 0;

        foreach(quad in level.quadgridcenterpoints) {
          newdist = scripts\engine\utility::distance_2d_squared(quad, exsite.origin);

          if(dist == 0 || newdist < dist) {
            dist = newdist;
            exsite.closestquad = quad;
          }
        }
      }

      siteindex = 0;

      for(i = 0; i < newarraysize; i++) {
        if(siteindex > level.quadgridcenterpoints.size - 1) {
          siteindex = 0;
        }

        var_ed7960f0edb5f2a0 = level.quadgridcenterpoints[siteindex];

        foreach(exsite in var_532388c61e12b9df) {
          if(isDefined(exsite.closestquad) && exsite.closestquad == var_ed7960f0edb5f2a0) {
            spawnstructs[spawnstructs.size] = exsite;
            var_532388c61e12b9df = array_remove(var_532388c61e12b9df, exsite);
            break;
          }
        }

        siteindex++;
      }
    }
  } else if(var_532388c61e12b9df.size > 0) {
    var_532388c61e12b9df = scripts\engine\utility::array_randomize(var_532388c61e12b9df);
    newarraysize = int(min(maxlocations, var_532388c61e12b9df.size));

    for(i = 0; i < newarraysize; i++) {
      spawnstructs[spawnstructs.size] = var_532388c61e12b9df[i];
    }
  }

  if(istrue(level.hideallunselectedextractpads)) {
    foreach(site in var_532388c61e12b9df) {
      if(!array_contains(spawnstructs, site)) {
        site setscriptablepartstate(site.type, "hidden");
      }
    }
  }

  return spawnstructs;
}

function pointinsquare(point, center, width) {
  xmin = center[0] - width;
  xmax = center[0] + width;
  ymin = center[1] - width;
  ymax = center[1] + width;
  return point[0] >= xmin && point[0] <= xmax && point[1] >= ymin && point[1] <= ymax;
}

function _getsingleplunderextractlocations(var_532388c61e12b9df, maxlocations) {
  if(var_532388c61e12b9df.size == 0 || maxlocations == 0) {
    return;
  }

  site = undefined;

  if(var_532388c61e12b9df.size > 0) {
    var_532388c61e12b9df = scripts\engine\utility::array_randomize(var_532388c61e12b9df);

    for(i = 0; i < var_532388c61e12b9df.size; i++) {
      if(!array_contains(level.br_plunder_sites, var_532388c61e12b9df[i])) {
        site = var_532388c61e12b9df[i];
        break;
      }
    }
  }

  return site;
}

function findnewplunderextractsite(oldsite) {
  newsite = _getsingleplunderextractlocations(scripts\mp\gametypes\br_plunder::getallextractspawninstances(), level.maxplunderextractions);
  newsite.disabled = undefined;
  newsite.helidisabled = undefined;
  scriptablestate = ter_op(level.showplunderextracticonsinworld && !level.shownonscriptableextracticons, newsite.activecurrstate, newsite.activestate);
  newsite setscriptablepartstate(newsite.type, scriptablestate);

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons) {
    scripts\mp\objidpoolmanager::returnobjectiveid(oldsite.locale.objectiveiconid);
    oldsite.locale.objectiveiconid = -1;
    locale = spawnStruct();
    locale scripts\mp\gametypes\br_quest_util::createquestobjicon("ui_mp_br_mapmenu_icon_atm", "current", newsite.origin + (0, 0, 200));
    newsite.locale = locale;
  }

  level.br_plunder_sites = array_remove(level.br_plunder_sites, oldsite);
  level.br_plunder_sites = array_add(level.br_plunder_sites, newsite);
}

function startplunderextractiontimers() {
  scripts\mp\flags::gameflagwait("prematch_done");
  waitframe();

  foreach(extract in level.br_plunder_sites) {
    extract.disabled = undefined;
    scriptablestate = ter_op(level.showplunderextracticonsinworld && !level.shownonscriptableextracticons, extract.activecurrstate, extract.activestate);
    extract setscriptablepartstate(extract.type, scriptablestate);
    extract thread runplunderextractsitetimer();

    if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons) {
      extract.locale thread timeoutradialunfill();
    }
  }

  level thread runextractreroll();
}

function runplunderextractsitetimer() {
  wait level.timeoutplunderextractionsites;
  self.disabled = 1;
  self.helidisabled = 1;
  self setscriptablepartstate(self.type, self.disabledstate);
}

function runextractreroll() {
  wait level.timeoutplunderextractionsites + 1;
  level.br_plunder_sites = _getplunderextractlocations(scripts\mp\gametypes\br_plunder::getallextractspawninstances(), level.maxplunderextractions);

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons) {
    level thread createheliextractobjectiveicons();
  }

  level thread startplunderextractiontimers();
}

function createheliextractobjectiveicons() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(extract in level.br_plunder_sites) {
    locale = spawnStruct();
    locale scripts\mp\gametypes\br_quest_util::createquestobjicon("ui_mp_br_mapmenu_icon_atm", "current", extract.origin + (0, 0, 200));
    extract.locale = locale;
  }
}

function timeoutradialunfill() {
  timer = level.timeoutplunderextractionsites;
  updaterate = level.framedurationseconds;
  updateratems = updaterate * 1000;
  lockendtime = timer * 1000;
  subtime = lockendtime - updateratems;
  endtime = gettime() + lockendtime;

  while(gettime() < endtime) {
    var_6403fb28fbb44896 = subtime / lockendtime;
    scripts\mp\objidpoolmanager::objective_show_progress(self.objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objectiveiconid, var_6403fb28fbb44896);
    subtime = max(subtime - updateratems, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  self.objectiveiconid = -1;
}

function createquestobjicon(iconref, state, var_38116998df9814d4) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, state, (0, 0, 0), iconref);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_38116998df9814d4)) {
      movequestobjicon(var_38116998df9814d4);
    }

    return;
  }

  println(self.category + "<dev string:x25e>");
}

function movequestobjicon(neworigin) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, neworigin);
}

function showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

function showquestobjicontoall(objid) {
  objective_addalltomask(objid);
}

function hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

function deletequestobjicon() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

function startbmoexfilprocess(team) {
  level setexfiltimer();
  level thread showexfilstartsplash(team);

  if(level.teamplunderexfilvipuav) {
    level thread startvipteamuav(team);
  }

  if(level.teamplunderexfilshowviponly) {
    level thread removenonvipteamlocations();
  }

  level thread startexfilchoppers();
  level thread nuke_startexfilcountdown(team);
}

function setexfiltimer() {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  timelimit = getdvarfloat(@ "hash_c655a0b01b13910a", 180);
  gamemode = hashcat(@ "scr_", getgametype(), "_timelimit");
  level.watchdvars[gamemode].value = timelimit;
  level.overridewatchdvars[gamemode] = timelimit;
}

function showexfilstartsplash(winningteam) {
  foreach(team in level.teamnamelist) {
    scripts\mp\gametypes\br_public::brleaderdialogteam("plunder_extract_requested", team);
  }

  foreach(player in level.players) {
    player thread scripts\mp\hud_message::showsplash("callout_bmo_exfil_winners");
    player scripts\mp\utility\lower_message::setlowermessageomnvar("bmo_exfil_start", undefined, 20);
  }
}

function startvipteamuav(team) {
  level.radarmode[team] = "normal_radar";
  level.activeuavs[team] = 1;
  level.activeadvanceduavs[team] = 0;
  scripts\cp_mp\killstreaks\uav::function_484d86ce003c2526(team, 4);
}

function removenonvipteamlocations() {
  level.lootleadermarkcount = 1;

  if(getdvarint(@ "hash_9efdb377e7ae2dff", 0) == 1) {
    if(getdvarfloat(@ "hash_81be161d3102cc0e", 15) > 0) {
      level thread updatelootleadersonfixedinterval();
    }
  }
}

function startexfilchoppers() {
  foreach(site in level.br_plunder_sites) {
    site setscriptablepartstate(site.type, "inuse");
    groundorg = getgroundposition(site.origin, 1) + (0, 0, 2);
    var_6b2ff09e35c441ce = level.players[0];

    for(i = 0; i < 200; i++) {
      var_6b2ff09e35c441ce = findanyaliveplayer();

      if(isPlayer(var_6b2ff09e35c441ce)) {
        break;
      }
    }

    groundorg = getgroundposition(site.origin, 1) + (0, 0, 2);
    heli = var_6b2ff09e35c441ce playerspawnexfilchopper(groundorg, site);

    if(isDefined(heli)) {
      heli.site = site;
      site.heli = heli;
      heli helicreateextractvfx(groundorg);
      heli thread extractplayers();
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("plunder_extract_requested", var_6b2ff09e35c441ce.team, 1);
    }
  }
}

function playerspawnexfilchopper(position, site) {
  extractpos = position;
  descendpoint = extractpos + (0, 0, 2500);
  yaw = findclearflightyaw(descendpoint, site);
  angles = (0, yaw, 0);

  if(getdvarint(@ "hash_d5878ca9e558dd32", 1) == 1) {
    var_cb2dc60f7cafc6d4 = -100;
    var_f0db3d408327db23 = 60;
    dirfwd = anglesToForward(angles);
    dirright = anglestoright(angles);
    extractpos = extractpos + dirfwd * var_cb2dc60f7cafc6d4 + dirright * var_f0db3d408327db23;
  }

  enterposition = descendpoint + -1 * anglesToForward(angles) * 30000;
  exitposition = descendpoint + anglesToForward(angles) * 30000;
  heli = spawnheli(self, enterposition, descendpoint, exitposition);
  return heli;
}

function extractplayers() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.goalyaw);
  groundz = tracegroundheightexfil(self.pathgoal);
  var_625180ce8d2f8f77 = self.pathgoal[2] - groundz;
  self.flytime = calculatehelitimetoarrive(var_625180ce8d2f8f77);
  helisetteamextractionhud(1, self.flytime);
  self waittill("goal");

  foreach(player in level.players) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar("bmo_exfil_arrive", undefined, 20);
  }

  thread heliwatchgameendleave();
  thread helidisapateextractvfx();
  helidescend(self.endpoint, groundz);

  foreach(entry in level.teamnamelist) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("plunder_extract_chopper_arrive", entry, 1);
  }

  helimakeexfilwait();
  helicleanupextract();

  foreach(entry in level.teamnamelist) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("plunder_extract_chopper_leave", entry, 1);
  }

  thread helileave();
}

function helimakeexfilwait() {
  self.isdepot = 1;
  self.usable = self.crate;
  usable = self.usable;
  usable makeusable();
  usable setCursorHint("HINT_NOICON");
  usable setuseholdduration("duration_medium");
  usable sethintrequiresholding(1);
  usable setuserange(230);
  usable setHintString(&"MP/BR_USE_EXFIL_CHOPPER");
  var_bdf913fbadcce9a7 = level.br_depots.size;
  level.br_depots[var_bdf913fbadcce9a7] = usable;

  foreach(player in level.players) {
    if(!isDefined(player)) {}
  }

  thread helicleanupdepotonleaving();
  thread heliexfilthink(usable);
  helisetteamextractionhud(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

function heliexfilthink(usable) {
  self endon("death");
  usable endon("death");

  while(true) {
    usable waittill("trigger", player);
    player scripts\mp\hud_message::showsplash("callout_exfil_success");
    player function_a593971d75d82113();
    player function_379bb555405c16bb("br_gametype_plunder::heliExfilThink()");
    player sethidenameplate(0);
    player allowmovement(0);
    player allowfire(0);
    player disableoffhandprimaryweapons(0);
    player disableoffhandsecondaryweapons(0);
    player disableweapons(0);
    player disableweaponswitch(0);
    player setcamerathirdperson(1);
    player allowcrouch(0);
    player allowmelee(0);
    player allowjump(0);
    player allowprone(0);
    player val::set("heliExfil", "killstreaks", 0);
    player val::set("heliExfil", "supers", 0);
    player.safefromnuke = 1;
    usable disableplayeruse(player);
  }
}

function healdamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 99999;
  }
}

function tracegroundheightexfil(start) {
  var_dc8bb6300463cf1e = 256;
  groundpt = tracegroundpoint(start, 100, [self]);
  groundheight = groundpt[2];
  trueheight = groundheight + var_dc8bb6300463cf1e;
  return trueheight;
}

function findclearflightyaw(descendpoint, site) {
  if(isDefined(site) && isDefined(site.flightyaw)) {
    return site.flightyaw;
  }

  var_3fb4a86293ed25a6 = 10;
  contents = create_world_contents();
  yaw = 0;

  while(yaw < 360) {
    angles = (0, yaw, 0);
    start = descendpoint + -1 * anglesToForward(angles) * 30000;
    end = descendpoint + anglesToForward(angles) * 30000;
    trace = sphere_trace(descendpoint, end, 100, undefined, contents, 1);

    if(trace["fraction"] == 1) {
      line(start, end, (0, 1, 0), 1, 0, 2000);

      if(isDefined(site)) {
        site.flightyaw = yaw;
      }

      return yaw;
    }

    line(start, end, (1, 0, 0), 1, 0, 2000);

    if(yaw % 3 == 0) {
      waitframe();
    }

    yaw += var_3fb4a86293ed25a6;
  }

  yaw = randomfloat(360);

  if(isDefined(site)) {
    site.flightyaw = yaw;
  }

  return yaw;
}

function nuke_startexfilcountdown(winteam) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_nuke_timer_time", level.teamplunderexfiltimer);
  setomnvar("ui_nuke_countdown_active", 1);
  starttime = gettime();
  endtime = level.teamplunderexfiltimer * 1000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", level.teamplunderexfiltimer * 1000 + starttime);

  while(true) {
    waitframe();

    if(gettime() > endtime) {
      break;
    }
  }

  level thread scripts\mp\gamelogic::endgame(winteam, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
  setomnvar("ui_nuke_countdown_active", 0);
}

function triggerovertimetimer(team, var_c0174fb6729764e5, ontimelimitot) {
  if(istrue(level.bmoovertime)) {
    if(istrue(level.bankingoverlimitwillendot) && istrue(var_c0174fb6729764e5)) {
      level thread bmoendgameot();
    }

    return;
  }

  level.bmoovertime = 1;
  level notify("cancel_announcer_dialog");
  thread scripts\mp\music_and_dialog::plunder_overtime_music();
  scripts\mp\gametypes\br_publicevents::cancelupcomingpublicevents();
  level thread overtimecashmultiplier();
  splash = "bm_overtime_double_cash_2x";

  if(isDefined(team) && (level.disablewinonscore || !level.disableonemilannounce)) {
    level.initialwinningteam = team;
    showsplashtoallexceptteam(team, "bm_overtime_start_them", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    showsplashtoteam(team, "bm_overtime_start_us", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("bm_gamestate_overtime", team);

    foreach(entry in level.teamnamelist) {
      if(entry != team) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("bm_gamestate_overtime_enemy", entry);
      }
    }
  } else {
    level.initialwinningteam = getinitialwinningteam();
  }

  if(!isDefined(ontimelimitot)) {
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    timelimit = ter_op(level.disableonemilannounce || istrue(ontimelimitot), 7, 12);
    gamemode = hashcat(@ "scr_", getgametype(), "_timelimit");
    level.watchdvars[gamemode].value = timelimit;
    level.overridewatchdvars[gamemode] = timelimit;

    if(!level.disableonemilannounce) {
      wait 5;
    }

    showsplashtoall(splash, undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    wait 5;
    level.ontimelimitgraceperiod = level.doendofmatchotsequence;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
  } else {
    level.ontimelimitgraceperiod = level.doendofmatchotsequence;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
    level.forcehideottimer = 1;
    level.forceotlogictorun = 1;
    showsplashtoall(splash, undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    wait 5;
  }

  level.forcehideottimer = undefined;
  scripts\mp\flags::gameflagwait("overtime_started");
  thread function_9846f99ee86791d8(level.doendofmatchotsequence);
  setomnvar("ui_br_circle_state", 7);

  if(!isDefined(ontimelimitot)) {
    timer = gettime() + int(level.doendofmatchotsequence * 1000);
    setomnvar("ui_hardpoint_timer", timer);
  }

  wait int(max(level.doendofmatchotsequence - 60, 0));
  setomnvar("ui_br_circle_state", 8);
}

function getinitialwinningteam() {
  winningteam = "";

  foreach(team in level.teamnamelist) {
    placement = game["teamPlacements"][team];

    if(placement == 1) {
      winningteam = team;
      break;
    }
  }

  return winningteam;
}

function ontimelimit() {
  if(level.teamplunderscoremechanic && level.doendofmatchotsequence > 0 && !istrue(level.bmoovertime)) {
    if(!isDefined(level.initialwinningteam)) {
      level.initialwinningteam = getinitialwinningteam();
    }

    level thread triggerovertimetimer(level.initialwinningteam, level.teamdata[level.initialwinningteam]["plunderBanked"] * 10 >= getwincost());
    level waittill("bmo_overtime_start");

    while(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      wait level.framedurationseconds;
    }
  }

  level thread bmoendgameot();
}

function bmoendgameot() {
  if(istrue(level.gameended)) {
    return;
  }

  level thread handlebmoendgamesplash();
  level thread scripts\mp\gamelogic::endgame(level.brgametype.firstteam, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
}

function handlebmoendgamesplash() {
  var_464dd76c6ecb56fa = scripts\mp\gamelogic::getbrendsplashpostgamestate();

  foreach(player in level.players) {
    player setcachedclientomnvar("post_game_state", var_464dd76c6ecb56fa);
  }
}

function playerspawnendofgame() {
  if(level.var_7f1716b735a38c9f) {
    return false;
  }

  if(!istrue(self.controlsfrozen)) {
    _freezecontrols(1);
  }

  spawnpoint = spawnStruct();
  player = self getspectatingplayer();

  if(!isDefined(player)) {
    player = self;
  }

  spawnpoint.origin = player.origin;
  spawnpoint.angles = player.angles;

  if(!player isonground()) {
    tracecontents = scripts\engine\trace::create_default_contents(1);
    spawnpoint.origin = scripts\mp\gametypes\br_public::droptogroundmultitrace(spawnpoint.origin, 0, -20000, tracecontents);
  }

  spawnpoint.origin += (0, 0, 100);

  if(!isDefined(level.endmatchcamerastriggered)) {
    level.endmatchcamerastriggered = 1;
    level thread triggerbloodmoneyendcameras();
  }

  return true;
}

function eomawardplayerxp() {
  level waittill("give_match_bonus");
  waitframe();
  var_7c3103094888139a = getdvarfloat(@ "hash_624dff063fdc19e4", 0.001);
  var_e7e8ca63000a1c32 = getdvarfloat(@ "hash_5776e92fc7e990f4", 0.05);
  var_e649b857d1df196f = getdvarint(@ "hash_a0c1b8638163484e", 10000);
  var_bcda60d01edd703c = getdvarint(@ "hash_7845f9181d5707ba", 7500);
  var_563b1704964abc60 = getdvarint(@ "hash_163aca343e614b6e", 5000);

  foreach(team in level.teamnamelist) {
    teamplunder = scripts\mp\gametypes\br_plunder::getteamplunder(team) * 10;
    var_9b88e8a64bd55390 = teamplunder >= getwincost();
    placement = game["teamPlacements"][team];
    placementscore = 0;

    if(var_9b88e8a64bd55390) {
      placementscore = var_bcda60d01edd703c;
    } else if(placement <= 10) {
      placementscore = var_563b1704964abc60;
    }

    players = getteamdata(team, "players");

    foreach(player in players) {
      player scripts\mp\gametypes\br::stopchallengetimers();

      if(!player rankingenabled() || !player hasplayerdata()) {
        continue;
      }

      player scripts\mp\utility\stats::incpersstat("cash", int(teamplunder / 10000));
      combatxp = player.pers["combatXP"];

      if(!isDefined(combatxp)) {
        combatxp = 0;
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 0, combatxp);
      missionxp = player.pers["missionXP"];

      if(!isDefined(missionxp)) {
        missionxp = 0;
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 1, missionxp);
      lootingxp = player.pers["lootingXP"];

      if(!isDefined(lootingxp)) {
        lootingxp = 0;
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 2, lootingxp);
      heldscore = 0;

      if(isDefined(player.plundercount)) {
        heldscore = int(player.plundercount * var_7c3103094888139a);
      }

      var_452885d9ffe85530 = 0;

      if(isDefined(player.plunderbanked)) {
        var_452885d9ffe85530 = int(player.plunderbanked * var_e7e8ca63000a1c32);
      }

      score = heldscore + var_452885d9ffe85530;

      if(score > 0) {
        player scripts\mp\rank::giverankxp(#"hash_31a9f06f2a47aeff", score, undefined, 1, 1);
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 3, score);
      reconxp = player.pers["reconXP"];

      if(!isDefined(reconxp)) {
        reconxp = 0;
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 4, reconxp);
      matchbonus = 0;

      if(isDefined(player.matchbonus)) {
        matchbonus = int(player.matchbonus);
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 5, matchbonus);

      if(placementscore > 0) {
        player scripts\mp\rank::giverankxp(#"placement_bonus", placementscore, undefined, 1, 1);
      }

      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 6, placementscore);
      squadplayxp = player scripts\mp\utility\stats::getpersstat("squadPlayXP");
      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 7, isDefined(squadplayxp) ? squadplayxp : 0);
      initialxp = player getplayerdata(level.var_5d69837cf4db0407, "aarValue", 7);
      finalxp = initialxp + player.pers["summary"]["xp"];
      player setplayerdata(level.var_5d69837cf4db0407, "aarValue", 8, finalxp);
      player function_34e46d26df79fdad();
    }

    if(istrue(level.var_db813db0fa91a0ce) && isDefined(level.var_e224ccaf8102eea7) && isDefined(level.var_e224ccaf8102eea7[team])) {
      logstring("Team Plunder Total: { Team: " + team + ", Placement: " + placement + ", Total Cash: " + level.var_e224ccaf8102eea7[team].cashtotal + ", Looted: " + level.var_e224ccaf8102eea7[team].var_5aef484ac6780f1c + ", Contracts: " + level.var_e224ccaf8102eea7[team].contracttotal + ", Valuables: " + level.var_e224ccaf8102eea7[team].var_f86b346fef47a962 + ", Lost On Death: " + level.var_e224ccaf8102eea7[team].ondeathtotal + ", Lost On Purchase: " + level.var_e224ccaf8102eea7[team].purchasetotal + ", Net Dropped: " + level.var_e224ccaf8102eea7[team].var_bea7a1b2df733cdc + " }");
    }
  }
}

function devthink() {
  setdevdvarifuninitialized(@ "hash_73759683c80b1a3d", 0);
  setdevdvarifuninitialized(@ "hash_60ce22543dc3ff22", 0);
  setdevdvarifuninitialized(@ "plunder_win", 0);

  while(true) {
    if(getdvarint(@ "hash_c5963975fc37d256", 0) != 0) {
      doteamextractedupdate();
      setDvar(@ "hash_c5963975fc37d256", 0);
    }

    if(getdvarint(@ "plunder_win", 0) != 0) {
      setDvar(@ "plunder_win", 0);
      host = scripts\mp\gamelogic::gethostplayer();
      level.brgametype.firstteam = host.team;
      thread bmoendgameot();
    }

    if(getdvarint(@ "hash_73759683c80b1a3d", 0) != 0) {
      setDvar(@ "hash_73759683c80b1a3d", 0);
      wintarget = getwincost();
      wintarget = int(wintarget / 100);
      host = scripts\mp\gamelogic::gethostplayer();
      targetteam = "<dev string:x27d>";

      foreach(player in level.players) {
        if(isalive(player) && player != host && player.team != host.team) {
          targetteam = player.team;
          level.teamdata[targetteam]["<dev string:x281>"] = int(wintarget - 100);
          break;
        }
      }

      wait 15;
      level.teamdata[targetteam]["<dev string:x281>"] = int(wintarget);
    }

    if(getdvarint(@ "hash_60ce22543dc3ff22", 0) != 0) {
      setDvar(@ "hash_60ce22543dc3ff22", 0);
      wintarget = getwincost();
      wintarget = int(wintarget / 100);
      host = scripts\mp\gamelogic::gethostplayer();
      targetteam = host.team;
      level.teamdata[targetteam]["<dev string:x281>"] = int(wintarget - 100);
      break;
    }

    waitframe();
  }
}

function initendcameralocations() {
  var_6f0d91b3ab59b3e8 = [];
  level.endcameraorigins = [];
  level.endcameraangles = [];

  if(level.mapname == "mp_br_mechanics") {
    level.endcameraorigins[0] = (8682, -1036, 427);
    level.endcameraangles[0] = (14, 163, 0);
    level.endcameraorigins[1] = (-1139, -3425, 1116);
    level.endcameraangles[1] = (33, 75, 0);
    level.endcameraorigins[2] = (-5567, -4786, 1116);
    level.endcameraangles[2] = (37, 192, 0);
  } else {
    level.endcameraorigins[0] = (-36548, -31983, 2400);
    level.endcameraangles[0] = (12, 72, 0);
    level.endcameraorigins[1] = (-17592, -36440, 1379);
    level.endcameraangles[1] = (17, 90, 0);
    level.endcameraorigins[2] = (-3520, -34298, 1217);
    level.endcameraangles[2] = (11, 110, 0);
    level.endcameraorigins[3] = (-9577, -25957, 360);
    level.endcameraangles[3] = (357, 82, 0);
    level.endcameraorigins[4] = (23022, -26926, 1359);
    level.endcameraangles[4] = (16, 101, 0);
    level.endcameraorigins[5] = (31261, -29753, 1359);
    level.endcameraangles[5] = (27, 52, 0);
    level.endcameraorigins[6] = (44843, -41261, 3220);
    level.endcameraangles[6] = (16, 52, 0);
    level.endcameraorigins[7] = (44229, -15403, 1331);
    level.endcameraangles[7] = (13, 72, 0);
    level.endcameraorigins[8] = (44491, 3484, 1638);
    level.endcameraangles[8] = (23, 11, 0);
    level.endcameraorigins[9] = (16047, -3206, 2613);
    level.endcameraangles[9] = (27, 309, 0);
    level.endcameraorigins[10] = (5668, -5905, 1614);
    level.endcameraangles[10] = (23, 304, 0);
    level.endcameraorigins[11] = (-13412, -20443, 1033);
    level.endcameraangles[11] = (11, 109, 0);
    level.endcameraorigins[12] = (-30369, -7811, 1680);
    level.endcameraangles[12] = (31, 339, 0);
    level.endcameraorigins[13] = (-26278, 4081, 142);
    level.endcameraangles[13] = (6, 110, 0);
    level.endcameraorigins[14] = (-16429, 6021, 847);
    level.endcameraangles[14] = (21, 57, 0);
    level.endcameraorigins[15] = (-7525, 11672, 1082);
    level.endcameraangles[15] = (14, 46, 0);
    level.endcameraorigins[16] = (8356, 15296, 2021);
    level.endcameraangles[16] = (12, 38, 0);
    level.endcameraorigins[17] = (26010, 29975, 2716);
    level.endcameraangles[17] = (13, 68, 0);
    level.endcameraorigins[18] = (12043, 30910, 3081);
    level.endcameraangles[18] = (21, 88, 0);
    level.endcameraorigins[19] = (7127, 52592, 2100);
    level.endcameraangles[19] = (28, 241, 0);
    level.endcameraorigins[20] = (-6693, 56481, 4026);
    level.endcameraangles[20] = (16, 246, 0);
    level.endcameraorigins[21] = (-21394, 37175, 757);
    level.endcameraangles[21] = (2, 124, 0);
    level.endcameraorigins[22] = (-26151, 25577, 271);
    level.endcameraangles[22] = (357, 10, 0);
  }

  if(false) {
    endcameradebug_think();
  }
}

function triggerbloodmoneyendcameras() {
  playerscalculated = 0;

  foreach(player in level.players) {
    player thread playmatchendcamera(player, getbestcameraindex(player));
    playerscalculated++;

    if(playerscalculated == 5) {
      waitframe();
      playerscalculated = 0;
    }
  }
}

function endcameradebug_think() {
  while(true) {
    var_ed43777427f1dc38 = getdvarint(@ "hash_f91d2c0618ed9086", -1);

    if(var_ed43777427f1dc38 > -1) {
      playmatchendcamera(level.players[0], getbestcameraindex(level.players[0]));
      setDvar(@ "hash_f91d2c0618ed9086", -1);
    }

    waitframe();
  }
}

function getbestcameraindex(player) {
  var_bcd1f02c15cf8f02 = undefined;
  shortestdist = undefined;

  foreach(index, origin in level.endcameraorigins) {
    dist = distance2dsquared(player.origin, origin);

    if(dist <= 9000000) {
      return index;
    }

    if(!isDefined(shortestdist) || shortestdist > dist) {
      shortestdist = dist;
      var_bcd1f02c15cf8f02 = index;
    }
  }

  return var_bcd1f02c15cf8f02;
}

function playmatchendcamera(player, cameraindex) {
  originstart = level.endcameraorigins[cameraindex];
  anglesstart = level.endcameraangles[cameraindex];
  originend = originstart + anglestoright(anglesstart) * 1000;
  anglesend = anglesstart;
  cament = spawn("script_model", originstart);
  cament setModel("tag_origin");
  cament.angles = anglesstart;
  player cameralinkTo(cament, "tag_origin");
  cament moveTo(originend, 60);
  cament rotateTo(anglesend, 60);

  if(false) {
    wait 5;
    player cameraunlink();
  }
}

function printallteamsplundercount() {
  wait 1;
  wintarget = getwincost();
  teamsorted = tablesort(game["<dev string:x295>"], "<dev string:x2a7>");

  for(i = 0; i < teamsorted.size - 1; i++) {
    if(isDefined(level.teamdata[teamsorted[i]]["<dev string:x281>"])) {
      teamplunder = scripts\mp\gametypes\br_plunder::getteamplunder(teamsorted[i]) * 10;
      println("<dev string:x2ad>" + teamsorted[i] + "<dev string:x2b7>" + teamplunder);
    }
  }

}

function initdialog() {
  level endon("game_ended");
  waitframe();
  game["dialog"]["match_start"] = "bmlt_grav_gmty";
  game["dialog"]["offense_obj"] = "bmol_grav_boos";
  game["dialog"]["defense_obj"] = "bmol_grav_boos";
  game["dialog"]["event_chopper"] = "chpp_grav_bmev";
  game["dialog"]["event_airdrop"] = "ardr_grav_bmev";
  game["dialog"]["extract_enabled"] = "nbld_grav_bmxt";
  game["dialog"]["gamestate_25_perc"] = "25pf_grav_bmgm";
  game["dialog"]["gamestate_50_perc"] = "50pf_grav_bmgm";
  game["dialog"]["gamestate_75_perc"] = "75pf_grav_bmgm";
  game["dialog"]["gamestate_90_perc"] = "90pf_grav_bmgm";
  game["dialog"]["gamestate_25_perc_enemy"] = "25pn_grav_bmgm";
  game["dialog"]["gamestate_50_perc_enemy"] = "50pn_grav_bmgm";
  game["dialog"]["gamestate_75_perc_enemy"] = "75pn_grav_bmgm";
  game["dialog"]["gamestate_90_perc_enemy"] = "90pn_grav_bmgm";
  game["dialog"]["gamestate_25_perc_first"] = "25pf_grav_bmgm";
  game["dialog"]["gamestate_50_perc_first"] = "50pf_grav_bmgm";
  game["dialog"]["gamestate_75_perc_first"] = "75pf_grav_bmgm";
  game["dialog"]["gamestate_90_perc_first"] = "90pf_grav_bmgm";
  game["dialog"]["lead_lost"] = "ldls_grav_bmgm";
  game["dialog"]["lead_taken"] = "ldtk_grav_bmgm";
  game["dialog"]["mission_failure"] = "plnd_grav_msnf";
  game["dialog"]["mission_success"] = "plnd_grav_msnc";
  game["dialog"]["gamestate_top_5"] = "tp05_grav_bmgm";
  game["dialog"]["gamestate_top_10"] = "tp10_grav_gmst";
  game["dialog"]["bm_gamestate_overtime"] = "vrtm_grav_bgvb";
  game["dialog"]["bm_gamestate_overtime_enemy"] = "vrtn_grav_bmgm";
  game["dialog"]["team_loss"] = "lost_grav_bmgm";
  game["dialog"]["team_victory"] = "win1_grav_bmgm";
  game["dialog"]["event_bank"] = "event_bank";
  game["dialog"]["exfil_arrived"] = "exfil_arrived";
  game["dialog"]["exfil_failed"] = "exfil_failed";
  game["dialog"]["exfil_inbound"] = "exfil_inbound";
  game["dialog"]["exfil_leaving"] = "exfil_leaving";
  game["dialog"]["exfil_start_generic"] = "exfil_start_generic";
  game["dialog"]["exfil_start_win"] = "exfil_start_win";
  game["dialog"]["exfil_start_win_lz"] = "exfil_start_win_lz";
  game["dialog"]["exfil_success_full"] = "exfil_success_full";
  game["dialog"]["exfil_success_partial"] = "exfil_success_partial";
}

function function_597185764a5679f4() {
  var_89ce56155940323f = getdvarfloat(@ "hash_ddfa90008c99da3c", 0.25) > randomfloat(1);

  if(!var_89ce56155940323f) {
    scripts\mp\gametypes\br_gametypes::disablefeature("circle");
    return;
  }

  game["dialog"]["public_events_choke_hold_start"] = "chkh_grav_name";
  scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
  level.var_e486acb8f70c45a2 = spawnStruct();
  level.var_e486acb8f70c45a2.delaytime = getdvarint(@ "hash_9d3b9b1136287d59", 1500);
  level.var_e486acb8f70c45a2.circleradius = getdvarint(@ "hash_7c47c81509bb5bef", 40000);
  level.var_e486acb8f70c45a2.circleclosetime = getdvarint(@ "hash_76caafb421164ba8", 300);
  level thread function_af537bbd5b957fa6();
}

function function_af537bbd5b957fa6() {
  level endon("game_ended");
  level waittill("br_circle_started");
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_plunder_pe_choke_hold_active", "splash_list_br_plunder_iw9_mp");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_choke_hold_start");
  wait level.var_e486acb8f70c45a2.circleclosetime;
  flag_set("chokehold_closed", 1);
}

function lootallowedinbackpack(scriptablename) {
  if(istrue(level.var_3bee9b0a6835e07b)) {
    return scripts\mp\gametypes\br_pickups::isvaluable(scriptablename);
  }

  return 1;
}

function markplayeraseliminatedonkilled() {
  return false;
}

function watchparachutersoverhead(intervalms) {
  level endon("game_ended");
  level endon("cancel_watch_parachuters_overhead");

  while(true) {
    foreach(xuid, player in level.activeparachuters) {
      if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player) || !(player isparachuting() || player isinfreefall())) {
        level.activeparachuters[xuid] = undefined;
        continue;
      }

      nearbyplayers = utility::playersincylinder(player.origin, level.parachuteoverheadwarningradius, undefined, level.parachuteoverheadwarningheight);
      teamcompare = player.team;

      foreach(targetplayer in nearbyplayers) {
        if(isDefined(targetplayer.c130)) {
          continue;
        }

        sameteam = teamcompare == targetplayer.team;

        if(sameteam) {
          continue;
        }

        var_cda71aec07aab082 = !scripts\mp\utility\player::isreallyalive(targetplayer) || istrue(targetplayer.inlaststand);

        if(var_cda71aec07aab082) {
          continue;
        }

        var_744496cccbbfcb78 = targetplayer isparachuting() || targetplayer isinfreefall();

        if(var_744496cccbbfcb78) {
          continue;
        }

        time = gettime();
        var_8edff54c680323 = isDefined(targetplayer.heardparachuteoverheadtime) && time - targetplayer.heardparachuteoverheadtime < intervalms;

        if(var_8edff54c680323) {
          continue;
        }

        targetplayer.heardparachuteoverheadtime = time;

        if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
          operatorteam = scripts\mp\gametypes\br_public::brgetoperatorteam(targetplayer);

          if(!isDefined(operatorteam)) {
            operatorteam = "allies";
          }

          var_7570afa45d86040f = game["voice"][operatorteam];
          targetplayer queuedialogforplayer(level.activeparachutersfactionvo[var_7570afa45d86040f], "respawning_enemy_in_area", 2);
          continue;
        }

        scripts\mp\gametypes\br_public::brleaderdialog("respawning_enemy_in_area", 1, [targetplayer]);
      }

      waitframe();
    }

    waitframe();
  }
}