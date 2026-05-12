/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_aachen_vo.gsc
*********************************************/

func_5366() {
  level.var_7919 = ::func_A617;
  level.var_2EBB = ::dialogwaitaachen;
  level.var_2E8F = 5;
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
  game["dialog"]["attacker_out_of_bounds1"] = "sticktotheobjective";
  game["dialog"]["attacker_out_of_bounds2"] = "getbackinthebattle";
  game["dialog"]["attacker_out_of_bounds3"] = "whereareyougoingsoldier";
  game["dialog"]["attacker_out_of_bounds4"] = "getbacktothefront";
  game["dialog"]["attacker_out_of_bounds5"] = "focusontheobjective";
  game["dialog"]["attacker_out_of_bounds6"] = "wrongwaysoldier";
  game["dialog"]["attacker_attacker_airdrop"] = "airdrop2incoming";
  game["dialog"]["attacker_defender_airdrop"] = "enemy2airdropincoming";
  game["dialog"]["attacker_attacker_cpkg_destroyed"] = "care2packagedestroyed";
  game["dialog"]["attacker_defender_cpkg_destroyed"] = "";
  game["dialog"]["attacker_attacker_cpkg_enemysteal"] = "enemysteal";
  game["dialog"]["attacker_defender_cpkg_enemysteal"] = "";
  var_00 = "flamethrower";
  game["dialog"]["attacker_" + var_00] = "flame_earn";
  game["dialog"]["allies_friendly_" + var_00 + "_inbound"] = "flame_friendlyuse";
  game["dialog"]["axis_enemy_" + var_00 + "_inbound"] = "flame_enemyuse";
  game["dialog"]["offense_obj"] = "wevebeentaskedwithdestroy";
  game["dialog"]["defense_obj"] = "theenemysprimarymissionis";
  game["dialog"]["attacker_rescue_start"] = "rescueallthecapturedresis";
  game["dialog"]["attacker_rescue_nag1"] = "rescuetheresistancefighte";
  game["dialog"]["attacker_rescue_nag2"] = "locateandsavetheresistanc";
  game["dialog"]["attacker_rescue_nag3"] = "youhavetofreetheresistanc";
  game["dialog"]["attacker_rescue_nag4"] = "savetheresistancefighters";
  game["dialog"]["attacker_rescue_nag5"] = "freetheresistancefighters";
  game["dialog"]["attacker_rescue_opened_a1"] = "youveopenedcella";
  game["dialog"]["attacker_rescue_opened_a2"] = "cellaunlocked";
  game["dialog"]["attacker_rescue_opened_a3"] = "cellaopened";
  game["dialog"]["attacker_rescue_opened_b1"] = "youunlockedcellb";
  game["dialog"]["attacker_rescue_opened_b2"] = "cellbunlocked";
  game["dialog"]["attacker_rescue_opened_b3"] = "cellbopened";
  game["dialog"]["attacker_rescue_rescue_a1"] = "yourescueda";
  game["dialog"]["attacker_rescue_rescue_a2"] = "aisfree";
  game["dialog"]["attacker_rescue_rescue_a3"] = "youfreeda";
  game["dialog"]["attacker_rescue_rescue_b1"] = "yourescuedb";
  game["dialog"]["attacker_rescue_rescue_b2"] = "bisfree";
  game["dialog"]["attacker_rescue_rescue_b3"] = "youfreedb";
  game["dialog"]["attacker_rescue_both_a1"] = "werescuedbothprisonersina";
  game["dialog"]["attacker_rescue_both_a2"] = "bothprisonersinaarefree";
  game["dialog"]["attacker_rescue_both_a3"] = "wefreedbothprisonersina";
  game["dialog"]["attacker_rescue_both_b1"] = "werescuedbothprisonersinb";
  game["dialog"]["attacker_rescue_both_b2"] = "bothprisonersinbarerescue";
  game["dialog"]["attacker_rescue_both_b3"] = "wefreedbothprisonersinb";
  game["dialog"]["attacker_rescue_overtime1"] = "everyonerescuetheresistan";
  game["dialog"]["attacker_rescue_overtime2"] = "rescue2theresistancefight";
  game["dialog"]["attacker_rescue_overtime3"] = "squadrescuetheresistancef";
  game["dialog"]["attacker_rescue_success"] = "congratulationssoldierwef";
  game["dialog"]["attacker_rescue_failure"] = "ourmissionisafailurewecan";
  game["dialog"]["defender_rescue_start"] = "stoptheenemyfromrescuingt";
  game["dialog"]["defender_rescue_nag1"] = "stoptheenemyfrom2rescuing";
  game["dialog"]["defender_rescue_nag2"] = "dontletthemreleasethepris";
  game["dialog"]["defender_rescue_nag3"] = "stopthemfromfreeingthepri";
  game["dialog"]["defender_rescue_nag4"] = "dontlettheenemyfreethepri";
  game["dialog"]["defender_rescue_nag5"] = "theprisonersmustnotbefree";
  game["dialog"]["defender_rescue_opened_a1"] = "theenemyopenedcella";
  game["dialog"]["defender_rescue_opened_a2"] = "theyveunlockedcella";
  game["dialog"]["defender_rescue_opened_a3"] = "cellahasbeenopened";
  game["dialog"]["defender_rescue_opened_b1"] = "theenemyunlockedcellb";
  game["dialog"]["defender_rescue_opened_b2"] = "cellbhasbeenunlocked";
  game["dialog"]["defender_rescue_opened_b3"] = "cellbhasbeenopened";
  game["dialog"]["defender_rescue_rescue_a1"] = "ahasbeenrescued";
  game["dialog"]["defender_rescue_rescue_a2"] = "ahasbeenfreed";
  game["dialog"]["defender_rescue_rescue_a3"] = "theyfreeda";
  game["dialog"]["defender_rescue_rescue_b1"] = "theyrescuedb";
  game["dialog"]["defender_rescue_rescue_b2"] = "bhasbeenrescued";
  game["dialog"]["defender_rescue_rescue_b3"] = "theenemyreleasedb";
  game["dialog"]["defender_rescue_both_a1"] = "bothprisonersinahavebeenr";
  game["dialog"]["defender_rescue_both_a2"] = "bothprisonersinahavebeenf";
  game["dialog"]["defender_rescue_both_a3"] = "theyfreedbothprisonersina";
  game["dialog"]["defender_rescue_both_b1"] = "bothprisonersinbhavebeenr";
  game["dialog"]["defender_rescue_both_b2"] = "bothprisonersinbhavebeens";
  game["dialog"]["defender_rescue_both_b3"] = "theyfreedbothprisonersinb";
  game["dialog"]["defender_rescue_overtime1"] = "stopthemfromreleasingthep";
  game["dialog"]["defender_rescue_overtime2"] = "dontletthemfreetheprisone";
  game["dialog"]["defender_rescue_overtime3"] = "squadkeeptheprisonersinth";
  game["dialog"]["defender_rescue_success"] = "theenemymayhaverescuedall";
  game["dialog"]["defender_rescue_failure"] = "congratulationssoldierwes";
  game["dialog"]["attacker_destroy_start"] = "beforewestopthemunitionst";
  game["dialog"]["attacker_destroy_nag1"] = "destroyalltheradioequipme";
  game["dialog"]["attacker_destroy_nag2"] = "wreckallthecommunications";
  game["dialog"]["attacker_destroy_nag3"] = "allradiogearmustbedestroy";
  game["dialog"]["attacker_destroy_nag4"] = "demolishalltheradiogear";
  game["dialog"]["attacker_destroy_nag5"] = "destroyeverypieceofcommun";
  game["dialog"]["attacker_destroy_50p1"] = "youvedestroyedhalftheradi";
  game["dialog"]["attacker_destroy_50p2"] = "halftheradiogeariswrecked";
  game["dialog"]["attacker_destroy_50p3"] = "youvewreckedhalftheradiog";
  game["dialog"]["attacker_destroy_repair1"] = "theenemyisfixingradioequi";
  game["dialog"]["attacker_destroy_repair2"] = "aradioisbeingrepairedbyth";
  game["dialog"]["attacker_destroy_repair3"] = "theenemyisrepairingaradio";
  game["dialog"]["attacker_destroy_tankprogress1"] = "goodjobwereadvancingourta";
  game["dialog"]["attacker_destroy_tankprogress2"] = "youremakinggoodprogresswe";
  game["dialog"]["attacker_destroy_tankprogress3"] = "keepupthegoodworkwereadva";
  game["dialog"]["attacker_destroy_progress1"] = "radiodestroyed";
  game["dialog"]["attacker_destroy_progress2"] = "commequipmentdestroyed";
  game["dialog"]["attacker_destroy_progress3"] = "itsdestroyedgoodjob";
  game["dialog"]["attacker_destroy_tenleft"] = "commgeardestroyed10more";
  game["dialog"]["attacker_destroy_fiveleft"] = "radiodestroyed5remain";
  game["dialog"]["attacker_destroy_threeleft"] = "equipmentdestroyed3left";
  game["dialog"]["attacker_destroy_oneleft"] = "anotherradiodestroyedonem";
  game["dialog"]["attacker_destroy_overtime1"] = "destroyalltheradiogear";
  game["dialog"]["attacker_destroy_overtime2"] = "wreckthecommunicationsequ";
  game["dialog"]["attacker_destroy_overtime3"] = "allradiogearmustbedemolis";
  game["dialog"]["attacker_destroy_success"] = "wesucceededindestroyingal";
  game["dialog"]["attacker_destroy_failure"] = "wevelost2thegermanswereab";
  game["dialog"]["defender_destroy_start"] = "ifwecanstoptheenemyfromde";
  game["dialog"]["defender_destroy_nag1"] = "protecttheradioequipment";
  game["dialog"]["defender_destroy_nag2"] = "keepthecommunicationsgear";
  game["dialog"]["defender_destroy_nag3"] = "stoptheenemyfromdestroyin";
  game["dialog"]["defender_destroy_nag4"] = "protectourradiosfromtheen";
  game["dialog"]["defender_destroy_nag5"] = "dontlettheenemydestroyour";
  game["dialog"]["defender_destroy_50p1"] = "theyvedestroyedhalftherad";
  game["dialog"]["defender_destroy_50p2"] = "halfourradiogearisdestroy";
  game["dialog"]["defender_destroy_50p3"] = "theyvewreckedhalftheradio";
  game["dialog"]["defender_destroy_repair1"] = "wearefixingradioequipment";
  game["dialog"]["defender_destroy_repair2"] = "aradioisbeingrepairedbyou";
  game["dialog"]["defender_destroy_repair3"] = "wearerepairingaradio";
  game["dialog"]["defender_destroy_tankprogress1"] = "theenemyissucceedingandth";
  game["dialog"]["defender_destroy_tankprogress2"] = "theyredestroyingourradios";
  game["dialog"]["defender_destroy_tankprogress3"] = "theenemyiswreckingourcomm";
  game["dialog"]["defender_destroy_progress1"] = "theydestroyedaradio";
  game["dialog"]["defender_destroy_progress2"] = "aradiosbeendestroyed";
  game["dialog"]["defender_destroy_progress3"] = "communicationsgearhasbeen";
  game["dialog"]["defender_destroy_tenleft"] = "morecommgeardestroyed10le";
  game["dialog"]["defender_destroy_fiveleft"] = "radiodestroyed5stillremai";
  game["dialog"]["defender_destroy_threeleft"] = "equipmentdestroyed3left";
  game["dialog"]["defender_destroy_oneleft"] = "anotherradiodestroyedonly";
  game["dialog"]["defender_destroy_overtime1"] = "protectourradioequipment";
  game["dialog"]["defender_destroy_overtime2"] = "keepourradiossafe";
  game["dialog"]["defender_destroy_overtime3"] = "savetheradiosfromtheenemy";
  game["dialog"]["defender_destroy_success"] = "theenemydestroyedourradio";
  game["dialog"]["defender_destroy_failure"] = "theenemyhasbeendefeatedwe";
  game["dialog"]["attacker_escort_start"] = "escortourtanktothetrainya";
  game["dialog"]["attacker_escort_nag1"] = "youhavetostaynearthistank";
  game["dialog"]["attacker_escort_nag2"] = "escortthistanksoitcanstop";
  game["dialog"]["attacker_escort_nag3"] = "escortustothetrainyard";
  game["dialog"]["attacker_escort_nag4"] = "movethetrainisgettingread";
  game["dialog"]["attacker_escort_nag5"] = "getinhereandescortussoldi";
  game["dialog"]["attacker_escort_progress1"] = "protectuswereonthemove";
  game["dialog"]["attacker_escort_progress2"] = "wereadvancingkeepussafe";
  game["dialog"]["attacker_escort_progress3"] = "weremovingforward";
  game["dialog"]["attacker_escort_retreat1"] = "nobodysescortinguswerefal";
  game["dialog"]["attacker_escort_retreat2"] = "wereretreatingnoonesnearb";
  game["dialog"]["attacker_escort_retreat3"] = "wehavetofallbacknoonesesc";
  game["dialog"]["attacker_escort_contest1"] = "thegermansarekeepingourta";
  game["dialog"]["attacker_escort_contest2"] = "theenemysstoppingusfrommo";
  game["dialog"]["attacker_escort_contest3"] = "ourtankisntadvancingbecau";
  game["dialog"]["attacker_escort_overtime1"] = "everyoneescortthetank";
  game["dialog"]["attacker_escort_overtime2"] = "gettothetank";
  game["dialog"]["attacker_escort_overtime3"] = "rallyatthetank";
  game["dialog"]["attacker_escort_success"] = "wediditwestoppedthetraint";
  game["dialog"]["attacker_escort_failure"] = "themissionsovertheenemytr";
  game["dialog"]["defender_escort_start"] = "wehavetostoptheenemytankb";
  game["dialog"]["defender_escort_nag1"] = "killallthesoldiersescorti";
  game["dialog"]["defender_escort_nag2"] = "shoottheescortaroundtheta";
  game["dialog"]["defender_escort_nag3"] = "layfireonenemysoldiersnea";
  game["dialog"]["defender_escort_nag4"] = "dontletthattankadvance";
  game["dialog"]["defender_escort_nag5"] = "killtheescortnearthetank";
  game["dialog"]["defender_escort_progress1"] = "enemytankisadvancing";
  game["dialog"]["defender_escort_progress2"] = "thetankisadvancingstopthe";
  game["dialog"]["defender_escort_progress3"] = "enemytankismovingforward";
  game["dialog"]["defender_escort_retreat1"] = "enemytankisfallingbackyou";
  game["dialog"]["defender_escort_retreat2"] = "theyreretreatingnoonesisp";
  game["dialog"]["defender_escort_retreat3"] = "theenemytankisretreating";
  game["dialog"]["defender_escort_contest1"] = "werestoppingtheenemytankf";
  game["dialog"]["defender_escort_contest2"] = "werehaltingtheenemytank";
  game["dialog"]["defender_escort_contest3"] = "werekeepingtheenemytankfr";
  game["dialog"]["defender_escort_overtime1"] = "layfireonthetankescort";
  game["dialog"]["defender_escort_overtime2"] = "killtheescortaroundthetan";
  game["dialog"]["defender_escort_overtime3"] = "stopthetank";
  game["dialog"]["defender_escort_success"] = "wevelosttheenemywasableto";
  game["dialog"]["defender_escort_failure"] = "wediditwestoppedthetankou";
  game["dialog"]["attacker_2min"] = "2minutesuntilkrautreinfor";
  game["dialog"]["attacker_1min"] = "germanreinforcementsarriv";
  game["dialog"]["attacker_30sec"] = "30secondsleft3";
  game["dialog"]["attacker_10sec"] = "10secondsleft3";
  game["dialog"]["defender_2min"] = "ourreinforcementswillarri";
  game["dialog"]["defender_1min"] = "in1minuteourreinforcement";
  game["dialog"]["defender_30sec"] = "30seconds3left";
  game["dialog"]["defender_10sec"] = "10seconds3left";
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  runrescuevo("tram_fill");
  rundestroyradiovo("objective_radio");
  func_7FD0("tank_escort");
}

dialogwaitaachen(param_00, param_01) {
  lib_0506::func_2EDC(param_00, param_01);
  if(issubstr(param_00, "escort_start")) {
    maps\mp\_utility::func_3FA4("intro_vo_complete");
  }
}

radiodestroyprogress(param_00) {
  var_01 = "destroy_" + param_00;
  var_02 = 0.5;
  if(param_00 == "tenleft" || param_00 == "fiveleft" || param_00 == "threeleft" || param_00 == "oneleft") {
    thread lib_0506::func_A618(var_01, var_02);
    return 0;
  }

  thread lib_0506::func_A61B(var_01, var_02);
  return 1;
}

hostageprogress(param_00) {
  var_01 = "rescue_" + param_00;
  var_02 = randomintrange(1, 4);
  var_01 = var_01 + var_02;
  thread lib_0506::func_A618(var_01, 1, undefined, 0);
}

func_A617(param_00, param_01, param_02) {
  var_03 = 8000;
  var_04 = 8000;
  var_05 = 8000;
  if(level.var_3F9D) {
    return;
  }

  var_06 = 0;
  if(isDefined(param_02) && isstring(param_02) && param_02 == "force") {
    var_06 = 1;
  }

  if(!isDefined(level.var_7917) || var_06) {
    level.var_7917 = 0;
    level.var_7916 = "";
  }

  var_07 = param_00;
  switch (param_00) {
    case "hostage_b":
    case "hostage_a":
      param_00 = "tram_fill";
      break;

    default:
      break;
  }

  if(!isDefined(level.var_A5E4) || level.var_A5E4 != param_00) {
    return;
  }

  if(level.var_7917 < gettime() || param_00 != level.var_7916) {
    switch (param_00) {
      case "tram_fill":
        if(param_01 != "active") {
          thread hostageprogress(param_01);
        }
        break;

      case "objective_radio":
        if(param_01 != "active") {
          if(radiodestroyprogress(param_01)) {
            level.var_7917 = gettime() + var_04;
          }
        }
        break;

      case "tank_escort":
        if(param_01 == "forward") {
          level.var_7917 = gettime() + var_05;
          thread lib_0506::func_A61B("escort_progress");
        } else if(param_01 == "reverse") {
          level.var_7917 = gettime() + var_05;
          thread lib_0506::func_A61B("escort_retreat");
        } else if(param_01 == "contest") {
          level.var_7917 = gettime() + var_05;
          thread lib_0506::func_A61B("escort_contest");
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

runrescuevo(param_00) {
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "rescue", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "rescue_start", 0.5);
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("rescue_success");
}

rundestroyradiovo(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "destroy", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "destroy_start");
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("destroy_success");
}

func_7FD0(param_00) {
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "escort", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "escort_start", 0.5);
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("escort_success", 0.5);
}