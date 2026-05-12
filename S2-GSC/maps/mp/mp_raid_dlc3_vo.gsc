/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc3_vo.gsc
*********************************************/

func_5366() {
  level endon("game_ended");
  maps\mp\_utility::func_3FA3("intro_vo_complete", 0);
  waittillframeend;
  waittillframeend;
  if(!game["switchedsides"]) {
    game["voice"]["allies"] = "al_war_";
    game["voice"]["axis"] = "ax_war_";
  } else {
    game["voice"]["allies"] = "ax_war_";
    game["voice"]["axis"] = "al_war_";
  }

  game["dialog"] = [];
  game["dialog"]["lockouts"] = [];
  lib_0506::func_52C0();
  game["dialog"]["offense_obj"] = "tunisiaintro";
  game["dialog"]["defense_obj"] = "defensivepositionsenemyai";
  game["dialog"]["attacker_allies_win"] = "welldonesoldiersthemareth";
  game["dialog"]["attacker_allies_lose"] = "fallbackthosepositionsare";
  game["dialog"]["defender_allies_win"] = "ourlastdefensehasfallenev";
  game["dialog"]["defender_allies_lose"] = "theyarenomatchforourstren";
  game["dialog"]["attacker_airdrop_start"] = "demolitionsuppliesaredrop";
  game["dialog"]["attacker_airdrop_nag1"] = "getthosedemocharges";
  game["dialog"]["attacker_airdrop_nag2"] = "weneedtothoseairdrops";
  game["dialog"]["attacker_airdrop_nag3"] = "weneedthatordnance";
  game["dialog"]["attacker_airdrop_nag4"] = "securethoseairdrops";
  game["dialog"]["attacker_airdrop_nag5"] = "getthosedemolitionsupplie";
  game["dialog"]["attacker_airdrop_incoming1"] = "airdropinbound";
  game["dialog"]["attacker_airdrop_incoming2"] = "ordnancecratedecending";
  game["dialog"]["attacker_airdrop_incoming3"] = "demochargesdroppingin";
  game["dialog"]["attacker_airdrop_captured1"] = "demochargesrecovered";
  game["dialog"]["attacker_airdrop_captured2"] = "demolitionsupplyacquired";
  game["dialog"]["attacker_airdrop_captured3"] = "ordnancesecure";
  game["dialog"]["attacker_airdrop_progress0"] = "airdroprecoveredthreetogo";
  game["dialog"]["attacker_airdrop_progress1"] = "weneedtwomoreairdrops";
  game["dialog"]["attacker_airdrop_progress2"] = "onemoreairdropandwellhave";
  game["dialog"]["attacker_airdrop_denied1"] = "demosupplylost";
  game["dialog"]["attacker_airdrop_denied2"] = "thekrautstookthatonegetth";
  game["dialog"]["attacker_airdrop_denied3"] = "droplocationoverrun";
  game["dialog"]["attacker_airdrop_overtime1"] = "pushforthosesupplycrates";
  game["dialog"]["attacker_airdrop_overtime2"] = "defendthosedropzones";
  game["dialog"]["attacker_airdrop_overtime3"] = "nowornevergetthoseairdrop";
  game["dialog"]["attacker_airdrop_success"] = "demolitionchargessecureth";
  game["dialog"]["attacker_airdrop_failure"] = "airdropscompromisedwecant";
  game["dialog"]["defender_airdrop_start"] = "rallytothetheairdropsdeny";
  game["dialog"]["defender_airdrop_nag1"] = "gettothatairdrop";
  game["dialog"]["defender_airdrop_nag2"] = "denytheenemysupply";
  game["dialog"]["defender_airdrop_nag3"] = "surroundthedropsite";
  game["dialog"]["defender_airdrop_nag4"] = "securethedropsite";
  game["dialog"]["defender_airdrop_nag5"] = "attackthedropzone";
  game["dialog"]["defender_airdrop_incoming1"] = "enemyairdropinbound";
  game["dialog"]["defender_airdrop_incoming2"] = "enemysuppliesdescending";
  game["dialog"]["defender_airdrop_incoming3"] = "enemycratedroppingin";
  game["dialog"]["defender_airdrop_captured1"] = "theysecuredthatcrate";
  game["dialog"]["defender_airdrop_captured2"] = "supplydropinenemyhands";
  game["dialog"]["defender_airdrop_captured3"] = "enemyrecoveredtheirsuppli";
  game["dialog"]["defender_airdrop_denied1"] = "dropzoneisourswelldone";
  game["dialog"]["defender_airdrop_denied2"] = "dropzonesecuredkeepitup";
  game["dialog"]["defender_airdrop_denied3"] = "supplycratedeniedwellfoug";
  game["dialog"]["defender_airdrop_overtime1"] = "holdthemoffdontletthemget";
  game["dialog"]["defender_airdrop_overtime2"] = "pinthemdowndontletthemnea";
  game["dialog"]["defender_airdrop_overtime3"] = "pushthembackdonotsurrende";
  game["dialog"]["defender_airdrop_success"] = "enemyrecoveredtheirdemoli";
  game["dialog"]["defender_airdrop_failure"] = "successtheyhavenothinglef";
  game["dialog"]["attacker_artillery_train1"] = "artillerytraincrossingyou";
  game["dialog"]["attacker_artillery_train2"] = "artillerytraininboundhunk";
  game["dialog"]["attacker_artillery_train3"] = "artillerytraininboundstay";
  game["dialog"]["attacker_bridge_start"] = "plantthosechargesonthebri";
  game["dialog"]["attacker_bridge_nag1"] = "destroythatbridge";
  game["dialog"]["attacker_bridge_nag2"] = "getthosechargesplanted";
  game["dialog"]["attacker_bridge_nag3"] = "bringdownthebridge";
  game["dialog"]["attacker_bridge_nag4"] = "armthosedemocharges";
  game["dialog"]["attacker_bridge_nag5"] = "blastthebridgeandcutthatr";
  game["dialog"]["attacker_bridge_plant1"] = "chargeplanteddefendit";
  game["dialog"]["attacker_bridge_plant2"] = "fuseishotdefendtheperimet";
  game["dialog"]["attacker_bridge_plant3"] = "demochargeprimedprotectit";
  game["dialog"]["attacker_bridge_plant4"] = "bombarmedandreadywatchthe";
  game["dialog"]["attacker_bridge_plant5"] = "chargereadytoblowdefendit";
  game["dialog"]["attacker_bridge_defuse1"] = "enemydisarmedourbomb";
  game["dialog"]["attacker_bridge_defuse2"] = "theydefusedourbomb";
  game["dialog"]["attacker_bridge_defuse3"] = "bombdisarmed";
  game["dialog"]["attacker_bridge_defuse4"] = "theydismantledourbomb";
  game["dialog"]["attacker_bridge_defuse5"] = "enemydefusedourbomb";
  game["dialog"]["attacker_bridge_detonate1"] = "bombdetonatedcontinuethea";
  game["dialog"]["attacker_bridge_detonate2"] = "chargeexplodedkeepemcomin";
  game["dialog"]["attacker_bridge_detonate3"] = "chargedetonatedbringthatb";
  game["dialog"]["attacker_bridge_progress1"] = "gonnaneedafewmorebombstoc";
  game["dialog"]["attacker_bridge_progress2"] = "acouplemoredetonationsand";
  game["dialog"]["attacker_bridge_progress3"] = "onemorebombtoblocktheroad";
  game["dialog"]["attacker_bridge_overtime1"] = "pushthroughtheirresistanc";
  game["dialog"]["attacker_bridge_overtime2"] = "itsnottoolatewecanstillta";
  game["dialog"]["attacker_bridge_overtime3"] = "turnthatbridgetorubblethi";
  game["dialog"]["attacker_bridge_success"] = "theirsupplylineiscutkeepm";
  game["dialog"]["attacker_bridge_failure"] = "wefailedtocuttheroadpullb";
  game["dialog"]["defender_bridge_start"] = "defendthebridgekeepoursup";
  game["dialog"]["defender_bridge_nag1"] = "holdthesupplyroad";
  game["dialog"]["defender_bridge_nag2"] = "defendthebridgeourresuppl";
  game["dialog"]["defender_bridge_nag3"] = "protectthebridge";
  game["dialog"]["defender_bridge_nag4"] = "holdthebridgewecantloseou";
  game["dialog"]["defender_bridge_nag5"] = "protecttheroadthissupplyr";
  game["dialog"]["defender_bridge_plant1"] = "enemybombarmeddefuseit";
  game["dialog"]["defender_bridge_plant2"] = "disarmtheenemybomb";
  game["dialog"]["defender_bridge_plant3"] = "dismantletheenemybomb";
  game["dialog"]["defender_bridge_plant4"] = "enemybombplanteddisarmit";
  game["dialog"]["defender_bridge_plant5"] = "enemychargeisprimeddisabl";
  game["dialog"]["defender_bridge_defuse1"] = "bombdefused_tunisia";
  game["dialog"]["defender_bridge_defuse2"] = "bombdisarmed";
  game["dialog"]["defender_bridge_defuse3"] = "bombdismantled";
  game["dialog"]["defender_bridge_defuse4"] = "wedefusedthebomb";
  game["dialog"]["defender_bridge_defuse5"] = "wedisarmedthebomb";
  game["dialog"]["defender_bridge_detonate1"] = "enemychargeexplodedthebri";
  game["dialog"]["defender_bridge_detonate2"] = "enemybombdetonatedbuttheb";
  game["dialog"]["defender_bridge_detonate3"] = "enemybombexplodedthebridg";
  game["dialog"]["defender_bridge_overtime1"] = "protectthebridgeatallcost";
  game["dialog"]["defender_bridge_overtime2"] = "thisroadisvitalwecantlose";
  game["dialog"]["defender_bridge_overtime3"] = "wecanstillstopthemsecuret";
  game["dialog"]["defender_bridge_success"] = "oursupplylineiscutmovebac";
  game["dialog"]["defender_bridge_failure"] = "wellfoughtsoldiersoursupp";
  game["dialog"]["attacker_capture_start"] = "thisisitthelastassaultpus";
  game["dialog"]["attacker_capture_nag1"] = "keeppushingtheline";
  game["dialog"]["attacker_capture_nag2"] = "securethetrench";
  game["dialog"]["attacker_capture_nag3"] = "movethefrontpushthemback";
  game["dialog"]["attacker_capture_nag4"] = "takethatgroundandholdit";
  game["dialog"]["attacker_capture_nag5"] = "takethebunkers_tunisia";
  game["dialog"]["attacker_capture_taking1"] = "capturingtheposition";
  game["dialog"]["attacker_capture_taking2"] = "takingtheposition";
  game["dialog"]["attacker_capture_taking3"] = "securingtheposition_tunisia";
  game["dialog"]["attacker_capture_taking4"] = "pushingtheposition";
  game["dialog"]["attacker_capture_taking5"] = "securingthearea";
  game["dialog"]["attacker_capture_took1"] = "wehavethemomentumkeeppush";
  game["dialog"]["attacker_capture_took2"] = "werepushingthelinekeepitu";
  game["dialog"]["attacker_capture_took3"] = "weregaininggroundkeepgoin";
  game["dialog"]["attacker_capture_took4"] = "wesecuredthepositionmovef";
  game["dialog"]["attacker_capture_took5"] = "thepositionisoursrallytot";
  game["dialog"]["attacker_capture_overtime1"] = "pushharderwerealmostthere";
  game["dialog"]["attacker_capture_overtime2"] = "keepupthefightmovetheline";
  game["dialog"]["attacker_capture_overtime3"] = "werestillinthiskeeppushin";
  game["dialog"]["attacker_capture_success"] = "theyreontherunwevesecured";
  game["dialog"]["attacker_capture_failure"] = "marethlineresistanceiscru";
  game["dialog"]["defender_capture_start"] = "stopthemhereandnowwemusth";
  game["dialog"]["defender_capture_nag1"] = "dontgivethemaninchofgroun";
  game["dialog"]["defender_capture_nag2"] = "holdthelinedontletthemthr";
  game["dialog"]["defender_capture_nag3"] = "secureandhold";
  game["dialog"]["defender_capture_nag4"] = "pushthemback";
  game["dialog"]["defender_capture_nag5"] = "protectthemarethline";
  game["dialog"]["defender_capture_taking1"] = "enemyadvancingcorrectthes";
  game["dialog"]["defender_capture_taking2"] = "enemygaininggroundpushbac";
  game["dialog"]["defender_capture_taking3"] = "enemytakingourpositioncou";
  game["dialog"]["defender_capture_taking4"] = "werelosingtheposition";
  game["dialog"]["defender_capture_taking5"] = "werebeingpushedout";
  game["dialog"]["defender_capture_took1"] = "fallbacktothenextposition";
  game["dialog"]["defender_capture_took2"] = "withdrawtothenextdefensiv";
  game["dialog"]["defender_capture_took3"] = "stoptheirassaultatthenext";
  game["dialog"]["defender_capture_took4"] = "movebackandholdthere";
  game["dialog"]["defender_capture_took5"] = "fallbackanddefend";
  game["dialog"]["defender_capture_overtime1"] = "ourbacksaretothewallgivei";
  game["dialog"]["defender_capture_overtime2"] = "thereisnowheretoretreatho";
  game["dialog"]["defender_capture_overtime3"] = "wearethelastdefenseholdth";
  game["dialog"]["defender_capture_success"] = "failurewevelostthemarethl";
  game["dialog"]["defender_capture_failure"] = "theyaredoneforthemarethli";
  game["dialog"]["attacker_sandstorm_warning"] = "weatherboyssayasandstormi";
  game["dialog"]["attacker_sandstorm_start"] = "sandstormstayonmissionget";
  game["dialog"]["defender_sandstorm_warning"] = "weatherpostsreportasandst";
  game["dialog"]["defender_sandstorm_start"] = "sandstormstayfocusedfinda";
  game["dialog"]["attacker_2min"] = "2minutesleftuntilenemyrei";
  game["dialog"]["attacker_1min"] = "in1minuteenemyreinforceme";
  game["dialog"]["attacker_30sec"] = "30secondsleft";
  game["dialog"]["attacker_10sec"] = "wererunningoutoftime10sec";
  game["dialog"]["defender_2min"] = "2minutesleftuntilourreinf";
  game["dialog"]["defender_1min"] = "1minuteleftkeepfighting";
  game["dialog"]["defender_30sec"] = "30secondsuntilourreinforc";
  game["dialog"]["defender_10sec"] = "10secondsleft";
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  thread runoutrovo();
  runsecuresupplyvo("secure_supplies");
  runbombplantvo("bomb_plant");
  runcaptureflagsvo("capture_flags");
}

runsecuresupplyvo(param_00) {
  level.intelobjectivevoplayedcount = 0;
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  lib_0506::func_A61C(param_00, "airdrop_start", 0.5);
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "airdrop", lib_04FF::func_6937(param_00));
  thread securesupplyresult(lib_04FF::func_6937(param_00));
  thread securesupplywatchdrops(lib_04FF::func_6937(param_00));
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("airdrop_success");
}

securesupplyresult(param_00) {
  level endon("game_ended");
  level endon(param_00);
  var_01 = 1;
  var_02 = 1;
  var_03 = 3;
  var_04 = 3;
  var_05 = 0;
  for(;;) {
    var_06 = level common_scripts\utility::func_A715("attackers_secure_drop", "defenders_secure_drop", "securedrop_timeout");
    if(var_06 == "attackers_secure_drop" && var_05 < var_04 - 1) {
      var_07 = -1 * var_04 + 3 + var_01;
      thread lib_0506::func_A618("airdrop_captured" + var_07, 1);
      thread securesupplyprogress(var_07, param_00);
      var_05 = var_05 + 1;
      var_01++;
      continue;
    }

    if(var_05 < var_04 - 1) {
      thread lib_0506::func_A618("airdrop_denied" + var_02, 1);
      var_02++;
      if(var_02 > var_03) {
        var_02 = 1;
      }
    }
  }
}

securesupplyprogress(param_00, param_01) {
  level endon("game_ended");
  level endon(param_01);
  wait(6);
  thread lib_0506::func_A618("airdrop_progress" + param_00, 1);
}

securesupplywatchdrops(param_00) {
  level endon("game_ended");
  level endon(param_00);
  var_01 = 1;
  var_02 = 3;
  for(;;) {
    level waittill("airdrop_deployed");
    thread lib_0506::func_A618("airdrop_incoming" + var_01, 1);
    var_01 = var_01 + 1;
    if(var_01 > var_02) {
      var_01 = 1;
    }
  }
}

artillerytrainwarningvo() {
  var_00 = "artillery_train" + common_scripts\utility::func_9AAD(randomintrange(1, 4));
  lib_0506::func_A618(var_00);
  wait(10);
}

runbombplantvo(param_00) {
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "bridge", lib_04FF::func_6937(param_00), 1);
  thread bombplantwatch(lib_04FF::func_6937(param_00));
  thread bombdefusewatch(lib_04FF::func_6937(param_00));
  level.maxbridgedetonates = 4;
  level.numbridgedetonates = 0;
  level.voindexbridgedetonate = 1;
  level.numvolinesbridgedetonate = 3;
  level.voindexbridgeprogress = 1;
  level.numvolinesbridgeprogress = 3;
  thread bombdetonatewatch(lib_04FF::func_6937(param_00), "bomb_01");
  thread bombdetonatewatch(lib_04FF::func_6937(param_00), "bomb_02");
  thread bombdetonatewatch(lib_04FF::func_6937(param_00), "bomb_03");
  thread bombdetonatewatch(lib_04FF::func_6937(param_00), "bomb_04");
  artillerytrainwarningvo();
  lib_0506::func_A61C(param_00, "bridge_start", 0.5);
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("bridge_success", 0.5);
}

bombplantwatch(param_00) {
  level endon("game_ended");
  level endon(param_00);
  var_01 = 1;
  var_02 = 5;
  for(;;) {
    level waittill("bomb_planted");
    thread lib_0506::func_A618("bridge_plant" + var_01, 1);
    var_01 = var_01 + 1;
    if(var_01 > var_02) {
      var_01 = 1;
    }
  }
}

bombdefusewatch(param_00) {
  level endon("game_ended");
  level endon(param_00);
  var_01 = 1;
  var_02 = 5;
  for(;;) {
    level waittill("bomb_defused");
    thread lib_0506::func_A618("bridge_defuse" + var_01, 1);
    var_01 = var_01 + 1;
    if(var_01 > var_02) {
      var_01 = 1;
    }
  }
}

bombdetonatewatch(param_00, param_01) {
  level endon("game_ended");
  level endon(param_00);
  var_02 = common_scripts\utility::func_46B5(param_01, "targetname");
  var_02 waittill("bomb_explode");
  if(level.numbridgedetonates < level.maxbridgedetonates - 1) {
    thread lib_0506::func_A618("bridge_detonate" + level.voindexbridgedetonate, 1);
    thread bombdetonateprogress(param_00);
    level.numbridgedetonates = level.numbridgedetonates + 1;
  }

  level.voindexbridgedetonate = level.voindexbridgedetonate + 1;
  if(level.voindexbridgedetonate > level.numvolinesbridgedetonate) {
    level.voindexbridgedetonate = 1;
  }
}

bombdetonateprogress(param_00) {
  level endon("game_ended");
  level endon(param_00);
  wait(6);
  thread lib_0506::func_A618("bridge_progress" + level.voindexbridgeprogress, 1);
  level.voindexbridgeprogress = level.voindexbridgeprogress + 1;
  if(level.voindexbridgeprogress > level.numvolinesbridgeprogress) {
    level.voindexbridgeprogress = 1;
  }
}

runcaptureflagsvo(param_00) {
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "capture", lib_04FF::func_6937(param_00), 1);
  lib_0506::func_A61C(param_00, "capture_start", 0.5);
  thread capturebunkerstaking(lib_04FF::func_6937(param_00));
  thread capturebunkerstook(lib_04FF::func_6937(param_00));
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("capture_success");
}

capturebunkerstaking(param_00) {
  level endon("game_ended");
  level endon(param_00);
  var_01 = ["capture_taking1", "capture_taking2", "capture_taking3", "capture_taking4", "capture_taking5"];
  var_02 = var_01;
  for(;;) {
    level waittill("momentum_point_capture_start_attmept_vo");
    var_03 = common_scripts\utility::func_7A33(var_02);
    thread lib_0506::func_A619(var_03);
    if(var_02.size <= 1) {
      var_02 = var_01;
    }

    var_02 = common_scripts\utility::func_F93(var_02, var_03);
    wait(randomintrange(15, 22));
  }
}

capturebunkerstook(param_00) {
  level endon("game_ended");
  level endon(param_00);
  level waittill("momentum_point_0_attackers");
  thread lib_0506::func_A618("capture_took1", 1);
  level waittill("momentum_point_1_attackers");
  thread lib_0506::func_A618("capture_took2", 1);
  level waittill("momentum_point_2_attackers");
  thread lib_0506::func_A618("capture_took3", 1);
}

runoutrovo() {
  level waittill("game_end_vignette");
  wait(0.1);
  var_00 = common_scripts\utility::func_562E(lib_0502::func_797A() == "allies");
  if(common_scripts\utility::func_562E(var_00)) {
    thread lib_0506::func_A619("allies_win", 0.5);
    return;
  }

  thread lib_0506::func_A619("allies_lose", 0.5);
}