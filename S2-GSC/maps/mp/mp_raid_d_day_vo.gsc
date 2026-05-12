/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_d_day_vo.gsc
*********************************************/

func_5366() {
  maps\mp\_utility::func_3FA3("intro_vo_complete", 0);
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
  game["dialog"]["offense_obj"] = "thisisitsoldiers3theallie";
  game["dialog"]["defense_obj"] = "ourenemyisuponustheywilla";
  game["dialog"]["attacker_capture_start"] = "cleartheshingleandcapture";
  game["dialog"]["attacker_capture_nag1"] = "takethebunkersmove";
  game["dialog"]["attacker_capture_nag2"] = "pushthebeachheadcaptureth";
  game["dialog"]["attacker_capture_nag3"] = "takethebunkers";
  game["dialog"]["attacker_capture_nag4"] = "pushthosebunkers";
  game["dialog"]["attacker_capture_nag5"] = "capturethebunkers";
  game["dialog"]["attacker_capture_progress1"] = "takingthebunker";
  game["dialog"]["attacker_capture_progress2"] = "securingthebunker";
  game["dialog"]["attacker_capture_progress3"] = "weretakingtheenemybunker";
  game["dialog"]["attacker_capture_overtime1"] = "wereoutoftimegetthosebunk";
  game["dialog"]["attacker_capture_overtime2"] = "lastchancetakethosebunker";
  game["dialog"]["attacker_capture_overtime3"] = "moveitsoldierstimeisrunni";
  game["dialog"]["attacker_capture_success"] = "bothbunkersaresecurenicew";
  game["dialog"]["attacker_capture_failure"] = "wevefailedfallbackregroup";
  game["dialog"]["attacker_capture_success_first1"] = "onebunkerdownonetogo";
  game["dialog"]["attacker_capture_success_first2"] = "wevegotonebunkeronemorele";
  game["dialog"]["attacker_capture_success_first3"] = "wevecapturedabunkeronemor";
  game["dialog"]["defender_capture_start"] = "defendthebunkersfromtheen";
  game["dialog"]["defender_capture_nag1"] = "defendthebunkersatallcost";
  game["dialog"]["defender_capture_nag2"] = "defendthebunkers";
  game["dialog"]["defender_capture_nag3"] = "pushthembackholdyourgroun";
  game["dialog"]["defender_capture_nag4"] = "holdthebeachhead";
  game["dialog"]["defender_capture_nag5"] = "protectthebunkers";
  game["dialog"]["defender_capture_progress1"] = "theyretakingourbunker";
  game["dialog"]["defender_capture_progress2"] = "theenemyiscapturingourbun";
  game["dialog"]["defender_capture_progress3"] = "thealliesaresecuringabunk";
  game["dialog"]["defender_capture_overtime1"] = "holdthemoffvictoryisinour";
  game["dialog"]["defender_capture_overtime2"] = "theymustnotprevail";
  game["dialog"]["defender_capture_overtime3"] = "holdthemtimeisshort";
  game["dialog"]["defender_capture_success"] = "ourbunkershavefallentothe";
  game["dialog"]["defender_capture_failure"] = "congratulationsmeinkamera";
  game["dialog"]["defender_capture_success_first1"] = "theyvecapturedabunkerdefe";
  game["dialog"]["defender_capture_success_first2"] = "ourbunkerhasfallenprotect";
  game["dialog"]["defender_capture_success_first3"] = "theyvetakenourbunker";
  game["dialog"]["attacker_commequip_start"] = "weneedtodestroytheenemyco";
  game["dialog"]["attacker_commequip_nag1"] = "destroythecommsequipment";
  game["dialog"]["attacker_commequip_nag2"] = "moveitsoldersgetthatequip";
  game["dialog"]["attacker_commequip_nag3"] = "pushtheassaultdestroythec";
  game["dialog"]["attacker_commequip_nag4"] = "destroytheequipmentmove";
  game["dialog"]["attacker_commequip_nag5"] = "gogogo";
  game["dialog"]["attacker_commequip_progress1"] = "commsequipmentdown";
  game["dialog"]["attacker_commequip_progress2"] = "equipmentdestroyed";
  game["dialog"]["attacker_commequip_progress3"] = "equipmentdownkeeppushing";
  game["dialog"]["attacker_commequip_overtime1"] = "timesupsoldiersgetthatequ";
  game["dialog"]["attacker_commequip_overtime2"] = "wereoutoftimedrivethembac";
  game["dialog"]["attacker_commequip_overtime3"] = "lastchancesoldiersdestroy";
  game["dialog"]["attacker_commequip_success"] = "enemycommsequipmentishist";
  game["dialog"]["attacker_commequip_failure"] = "wefailedtodestroytheenemy";
  game["dialog"]["attacker_commequip_fiveleft"] = "equipmentdestroyedfive";
  game["dialog"]["attacker_commequip_threeleft"] = "radiodestroyedthreeleft";
  game["dialog"]["attacker_commequip_oneleft"] = "commsgeardestroyedonemore";
  game["dialog"]["defender_commequip_start"] = "wemustdefendourcommunicat";
  game["dialog"]["defender_commequip_nag1"] = "protecttheequipment";
  game["dialog"]["defender_commequip_nag2"] = "defendthecommunicationseq";
  game["dialog"]["defender_commequip_nag3"] = "protecttheequipment2";
  game["dialog"]["defender_commequip_nag4"] = "holdthemsoldiers";
  game["dialog"]["defender_commequip_nag5"] = "defendthisposition";
  game["dialog"]["defender_commequip_progress1"] = "theyvedestroyedsomeofoure";
  game["dialog"]["defender_commequip_progress2"] = "communicationsaregoingdow";
  game["dialog"]["defender_commequip_progress3"] = "ourequipmentisbeingdestro";
  game["dialog"]["defender_commequip_overtime1"] = "lastchancedefend";
  game["dialog"]["defender_commequip_overtime2"] = "timeisalmostupholdyourgro";
  game["dialog"]["defender_commequip_overtime3"] = "defendtheequipment";
  game["dialog"]["defender_commequip_success"] = "ourcommunicationsequipmen";
  game["dialog"]["defender_commequip_failure"] = "wevewonthealliesareinretr";
  game["dialog"]["defender_commequip_fiveleft"] = "equipmentisdestroyedwe";
  game["dialog"]["defender_commequip_threeleft"] = "radiodestroyedonlythree";
  game["dialog"]["defender_commequip_oneleft"] = "radiosaredownwehaveonlyon";
  game["dialog"]["attacker_artillery_start"] = "ourshipsarevulnerable";
  game["dialog"]["attacker_artillery_nag1"] = "destroytheartillerygunsmo";
  game["dialog"]["attacker_artillery_nag2"] = "getthosecannonsoutofactio";
  game["dialog"]["attacker_artillery_nag3"] = "gettotheartillerycasemate_2";
  game["dialog"]["attacker_artillery_nag4"] = "destroythecannons";
  game["dialog"]["attacker_artillery_nag5"] = "gettothoseartillerygunsso";
  game["dialog"]["attacker_artillery_progress1"] = "weveplantedexplosivesonth";
  game["dialog"]["attacker_artillery_progress2"] = "ourbombisplantedonthearti";
  game["dialog"]["attacker_artillery_progress3"] = "wevegotexplosivesactivede";
  game["dialog"]["attacker_artillery_defend1"] = "defendthatbombsoldier";
  game["dialog"]["attacker_artillery_defend2"] = "youhavetokeepthekrautsawa";
  game["dialog"]["attacker_artillery_defend3"] = "protectthebombatallcosts";
  game["dialog"]["attacker_artillery_defend4"] = "dontletthegermansdefuseth";
  game["dialog"]["attacker_artillery_defend5"] = "protectthebombuntilitdeto";
  game["dialog"]["attacker_artillery_defuse1"] = "theenemyhasdefusedourbomb";
  game["dialog"]["attacker_artillery_defuse2"] = "bombdefusedgetmorecompbon";
  game["dialog"]["attacker_artillery_defuse3"] = "bombdefusedregroupandtrya";
  game["dialog"]["attacker_artillery_overtime1"] = "wereoutoftimedefendthatbo";
  game["dialog"]["attacker_artillery_overtime2"] = "timeisoutdefendthebomb";
  game["dialog"]["attacker_artillery_overtime3"] = "holdthembackjustalittlelo";
  game["dialog"]["attacker_artillery_multiprogress1"] = "bombdetonatedkeep";
  game["dialog"]["attacker_artillery_multiprogress2"] = "artillerydamagedget";
  game["dialog"]["attacker_artillery_multiprogress3"] = "theirgunhasbeendamaged";
  game["dialog"]["attacker_artillery_multiprogress4"] = "chargedetonated";
  game["dialog"]["attacker_artillery_multiprogress5"] = "bombdetonatedkeeppush";
  game["dialog"]["attacker_artillery_multiprogress_oneleft1"] = "bombdetonatedjustone";
  game["dialog"]["attacker_artillery_multiprogress_oneleft2"] = "chargeexplodedonemore";
  game["dialog"]["attacker_artillery_success_first1"] = "onegundownonetogo";
  game["dialog"]["attacker_artillery_success_first2"] = "artillerygundestroyedonel";
  game["dialog"]["attacker_artillery_success_first3"] = "theircannonishistoryonemo";
  game["dialog"]["attacker_artillery_success"] = "theartilleryhasbeendestro_1";
  game["dialog"]["attacker_artillery_failure"] = "wefailedtotakeouttheartil";
  game["dialog"]["defender_artillery_start"] = "achtungfallbackanddefend2";
  game["dialog"]["defender_artillery_nag1"] = "defendtheartillery";
  game["dialog"]["defender_artillery_nag2"] = "defendourcannons";
  game["dialog"]["defender_artillery_nag3"] = "holdthembackdefendtheguns";
  game["dialog"]["defender_artillery_nag4"] = "pushtheenemybackdefend2th";
  game["dialog"]["defender_artillery_nag5"] = "pushtheenemybackdefendthe";
  game["dialog"]["defender_artillery_progress1"] = "abombisplantedonourcannon";
  game["dialog"]["defender_artillery_progress2"] = "theenemyplantedabombonour";
  game["dialog"]["defender_artillery_progress3"] = "theenemyhasplantedexplosi";
  game["dialog"]["defender_artillery_defend1"] = "defusethebombbeforeitdeto";
  game["dialog"]["defender_artillery_defend2"] = "getinthereandstopthatbomb";
  game["dialog"]["defender_artillery_defend3"] = "youmustdefusethebomboritw";
  game["dialog"]["defender_artillery_defend4"] = "quicklydefusethebomb";
  game["dialog"]["defender_artillery_defend5"] = "youmuststopthatbombimmedi";
  game["dialog"]["defender_artillery_defuse1"] = "wevedefusedtheirbomb";
  game["dialog"]["defender_artillery_defuse2"] = "bombdefused";
  game["dialog"]["defender_artillery_defuse3"] = "theirexplosivehavebeendef";
  game["dialog"]["defender_artillery_overtime1"] = "wemuststopthemdefusethebo";
  game["dialog"]["defender_artillery_overtime2"] = "defusethebombnow";
  game["dialog"]["defender_artillery_overtime3"] = "thisisourlastchancedefuse";
  game["dialog"]["defender_artillery_multiprogress1"] = "achargehasdetonated";
  game["dialog"]["defender_artillery_multiprogress2"] = "ourgunhasbeendamaged";
  game["dialog"]["defender_artillery_multiprogress3"] = "abombhasdetonated";
  game["dialog"]["defender_artillery_multiprogress4"] = "ourartilleryhassustained";
  game["dialog"]["defender_artillery_multiprogress5"] = "ourcannonistakingdamage";
  game["dialog"]["defender_artillery_multiprogress_oneleft1"] = "bombdetonatedthegun";
  game["dialog"]["defender_artillery_multiprogress_oneleft2"] = "chargedetonatedourcannon";
  game["dialog"]["defender_artillery_success_first1"] = "oneofourcannonshasbeendes";
  game["dialog"]["defender_artillery_success_first2"] = "anartillerygunhasbeendest";
  game["dialog"]["defender_artillery_success_first3"] = "ourgunisdestroyedwehaveon";
  game["dialog"]["defender_artillery_success"] = "ourartilleryhasbeendestro_1";
  game["dialog"]["defender_artillery_failure"] = "wehavedefendedourposition";
  game["dialog"]["attacker_2min"] = "2minutesleftuntilenemyrei";
  game["dialog"]["attacker_1min"] = "in1minuteenemyreinforceme";
  game["dialog"]["attacker_30sec"] = "30secondsleft";
  game["dialog"]["attacker_10sec"] = "wererunningoutoftime10sec";
  game["dialog"]["defender_2min"] = "2minutesleftuntilourreinf";
  game["dialog"]["defender_1min"] = "1minuteleftkeepfighting";
  game["dialog"]["defender_30sec"] = "30secondsuntilourreinforc";
  game["dialog"]["defender_10sec"] = "10secondsleft";
  level.commequipmentleft = 10;
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  func_7F8F("capture_bunkers");
  runcommequipmentvo("comm_equipment");
  func_7F81("destroy_guns");
}

func_2EDE(param_00, param_01) {
  lib_0506::func_2EDC(param_00, param_01);
  if(issubstr(param_00, "capture_start")) {
    maps\mp\_utility::func_3FA4("intro_vo_complete");
  }
}

func_A617(param_00, param_01, param_02) {
  var_03 = 8000;
  var_04 = 10000;
  var_05 = 15000;
  var_06 = 8000;
  if(level.var_3F9D) {
    return;
  }

  if(!isDefined(level.var_7917)) {
    level.var_7917 = 0;
    level.var_7916 = "";
  }

  if(level.var_7917 < gettime() || param_00 != level.var_7916) {
    switch (param_00) {
      case "bunker_hp_a":
        if(param_01 == "start_capture") {
          level.var_7917 = gettime();
          thread lib_0506::func_A61B("capture_progress");
        }
        break;

      case "bunker_hp_b":
        if(param_01 == "start_capture") {
          level.var_7917 = gettime();
          thread lib_0506::func_A61B("capture_progress");
        }
        break;

      case "gun_02":
      case "gun_01":
        if(param_01 == "bomb_planted") {
          thread lib_0506::func_A61B("artillery_progress");
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

func_7F8F(param_00) {
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  thread runpartialcompletevo("capture");
  level.var_7939 = ::dualobjnagfunc;
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "capture", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C("capture_bunkers", "capture_start");
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("capture_success");
}

runcommequipmentvo(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "commequip", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C("comm_equipment", "commequip_start");
  thread monitorequipmentdestruction();
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("commequip_success");
}

monitorequipmentdestruction() {
  level endon("game_ended");
  level endon("comm_equipment_done");
  var_00 = common_scripts\utility::func_46B5("comm_equipment", "targetname");
  for(;;) {
    var_00 waittill("prop_destroyed");
    level.commequipmentleft--;
    level.var_7917 = gettime();
    if(level.commequipmentleft == 5) {
      thread lib_0506::func_A618("commequip_fiveleft", undefined, undefined);
    } else if(level.commequipmentleft == 3) {
      thread lib_0506::func_A618("commequip_threeleft", undefined, undefined);
    } else if(level.commequipmentleft == 1) {
      thread lib_0506::func_A618("commequip_oneleft", undefined, undefined);
    } else {
      thread lib_0506::func_A61B("commequip_progress");
    }

    wait 0.05;
  }
}

dualobjnagfunc(param_00, param_01, param_02) {
  var_03 = param_01 + "_nag";
  var_04 = 1;
  var_05 = param_00 - 330;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 300;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 270;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 210;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 180;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04 = 1;
  var_05 = param_00 - 150;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 90;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  var_04++;
  var_05 = param_00 - 45;
  thread lib_0506::func_A618(var_03 + var_04, var_05, param_02);
  level.var_7939 = undefined;
}

func_7F81(param_00) {
  level.var_7939 = ::dualobjnagfunc;
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "artillery", lib_04FF::func_6937(param_00));
  thread runartillerydefusevo(lib_04FF::func_6937(param_00), "gun_01");
  thread runartillerydefusevo(lib_04FF::func_6937(param_00), "gun_02");
  thread runpartialcompletevo("artillery");
  thread multibombexplodevo("gun_01");
  thread multibombexplodevo("gun_02");
  lib_0506::func_A61C(param_00, "artillery_start", 0.5);
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("artillery_success", 0.5);
}

multibombexplodevo(param_00) {
  level endon("game_ended");
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  level.multibombexplodevoindex = 1;
  level.multibombexplodelastvoindex = 1;
  for(;;) {
    var_01 waittill("multi_bomb_explode");
    if(var_01.numbombsplanted < 2) {
      thread lib_0506::func_A618("artillery_multiprogress" + level.multibombexplodevoindex, 1);
      level.multibombexplodevoindex++;
      if(level.multibombexplodevoindex > 3) {
        level.multibombexplodevoindex = 1;
      }

      continue;
    }

    thread lib_0506::func_A618("artillery_multiprogress_oneleft" + level.multibombexplodelastvoindex, 1);
    level.multibombexplodelastvoindex++;
    break;
  }
}

runartillerydefusevo(param_00, param_01) {
  level endon(param_00);
  var_02 = 1;
  var_03 = common_scripts\utility::func_46B5(param_01, "targetname");
  for(;;) {
    var_03 waittill("bomb_defused");
    thread lib_0506::func_A618("artillery_defuse" + var_02, 1);
    var_02++;
    if(var_02 > 3) {
      var_02 = 1;
    }
  }
}

runpartialcompletevo(param_00) {
  level waittill("objectiveComplete", var_01);
  var_02 = randomintrange(1, 4);
  thread lib_0506::func_A618(param_00 + "_success_first" + var_02, 0);
}