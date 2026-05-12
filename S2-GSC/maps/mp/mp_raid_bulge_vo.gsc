/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_bulge_vo.gsc
*********************************************/

func_5366() {
  level.var_2EBB = ::func_2EDD;
  level.var_2E8F = 3.5;
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
  game["dialog"]["offense_obj"] = "wereengaginginasurpriseat";
  game["dialog"]["defense_obj"] = "thekrautsareusingasneakat";
  game["dialog"]["attacker_escort_start"] = "escortourtanksandbreakthr";
  game["dialog"]["attacker_escort_nag1"] = "staynearourtanksandprotec";
  game["dialog"]["attacker_escort_nag2"] = "escortthetanks";
  game["dialog"]["attacker_escort_nag3"] = "escortthetanksthroughthef";
  game["dialog"]["attacker_escort_nag4"] = "getnearthosetanks";
  game["dialog"]["attacker_escort_nag5"] = "protectourtanks";
  game["dialog"]["attacker_tank_escort_1_progress1"] = "tankantonisadvancingprote";
  game["dialog"]["attacker_tank_escort_1_progress2"] = "tankantonisonthemove";
  game["dialog"]["attacker_tank_escort_1_progress3"] = "tankantonismovingforward";
  game["dialog"]["attacker_tank_escort_2_progress1"] = "tankbertaismovingforwardd";
  game["dialog"]["attacker_tank_escort_2_progress2"] = "tankbertaisadvancing";
  game["dialog"]["attacker_tank_escort_2_progress3"] = "tankbertaismovingforward";
  game["dialog"]["attacker_tank_escort_3_progress1"] = "tankcesarisadvancing";
  game["dialog"]["attacker_tank_escort_3_progress2"] = "tankcesarisonthemovedefen";
  game["dialog"]["attacker_tank_escort_3_progress3"] = "tankcesarismovingforward";
  game["dialog"]["attacker_tank_escort_1_retreat1"] = "antontankisfallingback";
  game["dialog"]["attacker_tank_escort_1_retreat2"] = "antontankisretreatingitne";
  game["dialog"]["attacker_tank_escort_1_retreat3"] = "antontankispullingbackitn";
  game["dialog"]["attacker_tank_escort_2_retreat1"] = "bertatankisfallingbackbec";
  game["dialog"]["attacker_tank_escort_2_retreat2"] = "bertatankisretreating";
  game["dialog"]["attacker_tank_escort_2_retreat3"] = "bertatankispullingbackitn";
  game["dialog"]["attacker_tank_escort_3_retreat1"] = "cesartankisfallingback";
  game["dialog"]["attacker_tank_escort_3_retreat2"] = "cesartankisretreatingyoum";
  game["dialog"]["attacker_tank_escort_3_retreat3"] = "gettocesartankitspullingb";
  game["dialog"]["attacker_tank_escort_1_near1"] = "antontankhasalmostcrossed";
  game["dialog"]["attacker_tank_escort_1_near2"] = "antontankisclosetobreakin";
  game["dialog"]["attacker_tank_escort_1_near3"] = "antontankisnearlythrought";
  game["dialog"]["attacker_tank_escort_2_near1"] = "bertatankhasalmostcrossed";
  game["dialog"]["attacker_tank_escort_2_near2"] = "bertatankisclosetobreakin";
  game["dialog"]["attacker_tank_escort_2_near3"] = "bertatankisnearlythrought";
  game["dialog"]["attacker_tank_escort_3_near1"] = "cesartankhasalmostcrossed";
  game["dialog"]["attacker_tank_escort_3_near2"] = "cesartankisclosetobreakin";
  game["dialog"]["attacker_tank_escort_3_near3"] = "cesartankisnearlythrought";
  game["dialog"]["attacker_tank_escort_1_blocked1"] = "antontankisblockedbyahedg";
  game["dialog"]["attacker_tank_escort_1_blocked2"] = "anenemyhedgehogisstopping";
  game["dialog"]["attacker_tank_escort_1_blocked3"] = "antontankcannotadvancebec";
  game["dialog"]["attacker_tank_escort_2_blocked1"] = "bertatankisblockedbyahedg";
  game["dialog"]["attacker_tank_escort_2_blocked2"] = "anenemy2hedgehogisstoppin";
  game["dialog"]["attacker_tank_escort_2_blocked3"] = "bertatankcannotadvancebec";
  game["dialog"]["attacker_tank_escort_3_blocked1"] = "cesartankisblockedbyahedg";
  game["dialog"]["attacker_tank_escort_3_blocked2"] = "anenemy3hedgehogisstoppin";
  game["dialog"]["attacker_tank_escort_3_blocked3"] = "cesartankcannotadvancebec";
  game["dialog"]["attacker_tank_escort_1_unblocked1"] = "thehedgehogisremovednowan";
  game["dialog"]["attacker_tank_escort_1_unblocked2"] = "tankacanmovewiththehedgeh";
  game["dialog"]["attacker_tank_escort_1_unblocked3"] = "thehedgehoghasbeendestroy";
  game["dialog"]["attacker_tank_escort_2_unblocked1"] = "thehedgehogisremovednowbe";
  game["dialog"]["attacker_tank_escort_2_unblocked2"] = "tankbcanmovewiththehedgeh";
  game["dialog"]["attacker_tank_escort_2_unblocked3"] = "thehedgehog2hasbeendestro";
  game["dialog"]["attacker_tank_escort_3_unblocked1"] = "thehedgehogisremovednowce";
  game["dialog"]["attacker_tank_escort_3_unblocked2"] = "tankccanmovewiththehedgeh";
  game["dialog"]["attacker_tank_escort_3_unblocked3"] = "thehedgehog3hasbeendestro";
  game["dialog"]["attacker_escort_first1"] = "werehalfwaytobreakingthro";
  game["dialog"]["attacker_escort_first2"] = "allwehavetodoisgetonemore";
  game["dialog"]["attacker_escort_first3"] = "wemustgetonemoretankacros";
  game["dialog"]["attacker_escort_overtime1"] = "everyonetothetanks";
  game["dialog"]["attacker_escort_overtime2"] = "youmustescortourtanks";
  game["dialog"]["attacker_escort_overtime3"] = "gettothetanksnow";
  game["dialog"]["attacker_escort_success"] = "wevebrokenthroughthefront";
  game["dialog"]["attacker_escort_failure"] = "ouradvancehasstalledtheam";
  game["dialog"]["defender_escort_start"] = "stopthegermansfromescorti";
  game["dialog"]["defender_escort_nag1"] = "killthesoldiersaroundthos";
  game["dialog"]["defender_escort_nag2"] = "keeptheenemyfromescorting";
  game["dialog"]["defender_escort_nag3"] = "shootthekrautsescortingth";
  game["dialog"]["defender_escort_nag4"] = "hammerthegermansbythoseta";
  game["dialog"]["defender_escort_nag5"] = "layfireonthesoldiersneart";
  game["dialog"]["defender_tank_escort_1_progress1"] = "alphatankisadvancing";
  game["dialog"]["defender_tank_escort_1_progress2"] = "alphatankisonthemove";
  game["dialog"]["defender_tank_escort_1_progress3"] = "alphatankismovingforward";
  game["dialog"]["defender_tank_escort_2_progress1"] = "bakertankisadvancing";
  game["dialog"]["defender_tank_escort_2_progress2"] = "bakertankisonthemove";
  game["dialog"]["defender_tank_escort_2_progress3"] = "bakertankismovingforward";
  game["dialog"]["defender_tank_escort_3_progress1"] = "charlietankisadvancing";
  game["dialog"]["defender_tank_escort_3_progress2"] = "charlietankisonthemove";
  game["dialog"]["defender_tank_escort_3_progress3"] = "charlietankismovingforwar";
  game["dialog"]["defender_tank_escort_1_retreat1"] = "alphatankisretreatingkeep";
  game["dialog"]["defender_tank_escort_1_retreat2"] = "alphatankisfallingback";
  game["dialog"]["defender_tank_escort_1_retreat3"] = "alphatankispullingback";
  game["dialog"]["defender_tank_escort_2_retreat1"] = "bakertankisretreatingkeep";
  game["dialog"]["defender_tank_escort_2_retreat2"] = "bakertankisfallingback";
  game["dialog"]["defender_tank_escort_2_retreat3"] = "bakertankispullingback";
  game["dialog"]["defender_tank_escort_3_retreat1"] = "charlietankisretreatingke";
  game["dialog"]["defender_tank_escort_3_retreat2"] = "charlietankisfallingback";
  game["dialog"]["defender_tank_escort_3_retreat3"] = "charlietankispullingback";
  game["dialog"]["defender_tank_escort_1_near1"] = "alphatankhasalmostcrossed";
  game["dialog"]["defender_tank_escort_1_near2"] = "alphatankisclosetobreakin";
  game["dialog"]["defender_tank_escort_1_near3"] = "alphatankisnearlythrought";
  game["dialog"]["defender_tank_escort_2_near1"] = "bakertankhasalmostcrossed";
  game["dialog"]["defender_tank_escort_2_near2"] = "bakertankisclosetobreakin";
  game["dialog"]["defender_tank_escort_2_near3"] = "bakertankisnearlythrought";
  game["dialog"]["defender_tank_escort_3_near1"] = "charlietankhasalmostcross";
  game["dialog"]["defender_tank_escort_3_near2"] = "charlietankisclosetobreak";
  game["dialog"]["defender_tank_escort_3_near3"] = "charlietankisnearlythroug";
  game["dialog"]["defender_tank_escort_1_blocked1"] = "alphatankisblockedbyourhe";
  game["dialog"]["defender_tank_escort_1_blocked2"] = "ourhedgehog2hasstoppedalp";
  game["dialog"]["defender_tank_escort_1_blocked3"] = "alphatankhasbeenstoppedby";
  game["dialog"]["defender_tank_escort_2_blocked1"] = "bakertankisblockedbyourhe";
  game["dialog"]["defender_tank_escort_2_blocked2"] = "ourhedgehog2hasstoppedbak";
  game["dialog"]["defender_tank_escort_2_blocked3"] = "bakertankhasbeenstoppedby";
  game["dialog"]["defender_tank_escort_3_blocked1"] = "charlietankisblockedbyour";
  game["dialog"]["defender_tank_escort_3_blocked2"] = "ourhedgehog3hasstoppedcha";
  game["dialog"]["defender_tank_escort_3_blocked3"] = "charlietankhasbeenstopped";
  game["dialog"]["defender_tank_escort_1_unblocked1"] = "theydestroyedourhedgehoga";
  game["dialog"]["defender_tank_escort_1_unblocked2"] = "tankacanmovenowthatthekra";
  game["dialog"]["defender_tank_escort_1_unblocked3"] = "ourhedgehoghasbeendestroy";
  game["dialog"]["defender_tank_escort_2_unblocked1"] = "theydestroyedourhedgehogb";
  game["dialog"]["defender_tank_escort_2_unblocked2"] = "tankbcanmovenowthatthekra";
  game["dialog"]["defender_tank_escort_2_unblocked3"] = "ourhedgehog2hasbeendestro";
  game["dialog"]["defender_tank_escort_3_unblocked1"] = "theydestroyedourhedgehogc";
  game["dialog"]["defender_tank_escort_3_unblocked2"] = "tankccanmovenowthatthekra";
  game["dialog"]["defender_tank_escort_3_unblocked3"] = "ourhedgehog3hasbeendestro";
  game["dialog"]["defender_escort_first1"] = "thekrautsarehalfwaytobrea";
  game["dialog"]["defender_escort_first2"] = "theygotatankacrosstheline";
  game["dialog"]["defender_escort_first3"] = "donotletthemgetanothertan";
  game["dialog"]["defender_escort_overtime1"] = "stopthetanks";
  game["dialog"]["defender_escort_overtime2"] = "dontletthetanksadvance";
  game["dialog"]["defender_escort_overtime3"] = "keepthetanksfrommovingfor";
  game["dialog"]["defender_escort_success"] = "wewerentabletostoptheirad";
  game["dialog"]["defender_escort_failure"] = "wediditwestoppedemfrombre";
  game["dialog"]["attacker_refuel_start"] = "ourtanksarerunninglowonfu";
  game["dialog"]["attacker_refuel_nag1"] = "fightforthegas";
  game["dialog"]["attacker_refuel_nag2"] = "taketheenemyfuel";
  game["dialog"]["attacker_refuel_nag3"] = "stealgasfromtheenemy";
  game["dialog"]["attacker_refuel_nag4"] = "weneedfuelforourtanks";
  game["dialog"]["attacker_refuel_nag5"] = "ourtanksneedthatgas";
  game["dialog"]["attacker_refuel_delivery_11"] = "antonfuelsuccessfullydeli";
  game["dialog"]["attacker_refuel_delivery_12"] = "wevereceivedantonfuel";
  game["dialog"]["attacker_refuel_delivery_13"] = "antonfuelisours";
  game["dialog"]["attacker_refuel_delivery_21"] = "bertafuelsuccessfullydeli";
  game["dialog"]["attacker_refuel_delivery_22"] = "wevereceivedbertafuel";
  game["dialog"]["attacker_refuel_delivery_23"] = "bertafuelisours";
  game["dialog"]["attacker_refuel_progress_11"] = "wearetakingantonfuel";
  game["dialog"]["attacker_refuel_progress_12"] = "wearestealingantonfuel";
  game["dialog"]["attacker_refuel_progress_13"] = "wearegrabbingantonfuel";
  game["dialog"]["attacker_refuel_progress_21"] = "wearetakingbertafuel";
  game["dialog"]["attacker_refuel_progress_22"] = "wearestealingbertafuel";
  game["dialog"]["attacker_refuel_progress_23"] = "wearegrabbingbertafuel";
  game["dialog"]["attacker_refuel_dropped_11"] = "antongashasbeendropped";
  game["dialog"]["attacker_refuel_dropped_12"] = "pickupthedroppedantonfuel";
  game["dialog"]["attacker_refuel_dropped_13"] = "quicklygrabthedroppedanto";
  game["dialog"]["attacker_refuel_dropped_21"] = "bertagashasbeendropped";
  game["dialog"]["attacker_refuel_dropped_22"] = "pickupthedroppedbertagas";
  game["dialog"]["attacker_refuel_dropped_23"] = "quicklygrabthedroppedbert";
  game["dialog"]["attacker_refuel_returned_11"] = "theenemyhastakenbackanton";
  game["dialog"]["attacker_refuel_returned_12"] = "theenemyhasretrievedanton";
  game["dialog"]["attacker_refuel_returned_13"] = "theenemyhasstolenbackanto";
  game["dialog"]["attacker_refuel_returned_21"] = "theenemyhastakenbackberta";
  game["dialog"]["attacker_refuel_returned_22"] = "theenemyhasretrievedberta";
  game["dialog"]["attacker_refuel_returned_23"] = "theenemyhasstolenbackbert";
  game["dialog"]["attacker_refuel_thrown_1"] = "fuelthrown";
  game["dialog"]["attacker_refuel_thrown_2"] = "fuelairborne";
  game["dialog"]["attacker_refuel_thrown_3"] = "fuelthrown";
  game["dialog"]["attacker_refuel_overtime1"] = "wemusthavethatgas";
  game["dialog"]["attacker_refuel_overtime2"] = "stealthegas";
  game["dialog"]["attacker_refuel_overtime3"] = "weneedthatfuel";
  game["dialog"]["attacker_refuel_success"] = "wehavestolenenoughfuelour";
  game["dialog"]["attacker_refuel_failure"] = "wevelostwithoutfuelourtan";
  game["dialog"]["defender_refuel_start"] = "ournextmissionistokeepthe";
  game["dialog"]["defender_refuel_nag1"] = "protectourgas";
  game["dialog"]["defender_refuel_nag2"] = "dontletthemstealourfuel";
  game["dialog"]["defender_refuel_nag3"] = "keepourgassafe";
  game["dialog"]["defender_refuel_nag4"] = "keepthemfromtakingfueltot";
  game["dialog"]["defender_refuel_nag5"] = "dontletthekrautstealourga";
  game["dialog"]["defender_refuel_delivery_11"] = "thekrautshavestolenalphag";
  game["dialog"]["defender_refuel_delivery_12"] = "theyvetakenalphafuel";
  game["dialog"]["defender_refuel_delivery_13"] = "thegermanshavealphafuel";
  game["dialog"]["defender_refuel_delivery_21"] = "thekrautshavestolenbakerg";
  game["dialog"]["defender_refuel_delivery_22"] = "theyvetakenbakerfuel";
  game["dialog"]["defender_refuel_delivery_23"] = "thegermanshavebakerfuel";
  game["dialog"]["defender_refuel_progress_11"] = "theyretryingtotakealphafu";
  game["dialog"]["defender_refuel_progress_12"] = "thekrauts2aretryingtostea";
  game["dialog"]["defender_refuel_progress_13"] = "thegermansaretryingtostea";
  game["dialog"]["defender_refuel_progress_21"] = "theyretryingtotakebakerfu";
  game["dialog"]["defender_refuel_progress_22"] = "thekrauts3aretryingtostea";
  game["dialog"]["defender_refuel_progress_23"] = "thegermans2aretryingtoste";
  game["dialog"]["defender_refuel_dropped_11"] = "grabthedroppedalphafuel";
  game["dialog"]["defender_refuel_dropped_12"] = "theenemydroppedalphafuel";
  game["dialog"]["defender_refuel_dropped_13"] = "quicklypickupthedroppedal";
  game["dialog"]["defender_refuel_dropped_21"] = "grabthedroppedbakerfuel";
  game["dialog"]["defender_refuel_dropped_22"] = "theenemydroppedbakerfuel";
  game["dialog"]["defender_refuel_dropped_23"] = "quicklypickupthedroppedba";
  game["dialog"]["defender_refuel_returned_11"] = "westolebackthealphafuel";
  game["dialog"]["defender_refuel_returned_12"] = "wegotbackouralphafuel";
  game["dialog"]["defender_refuel_returned_13"] = "westolealphafuelback";
  game["dialog"]["defender_refuel_returned_21"] = "westolebackthebakerfuel";
  game["dialog"]["defender_refuel_returned_22"] = "wegotbackourbakerfuel";
  game["dialog"]["defender_refuel_returned_23"] = "westolebakerfuelback";
  game["dialog"]["defender_refuel_thrown_1"] = "fuelthrown";
  game["dialog"]["defender_refuel_thrown_2"] = "fuelairborne";
  game["dialog"]["defender_refuel_thrown_3"] = "fuelthrown";
  game["dialog"]["defender_refuel_overtime1"] = "keepthekrautsfromourgas";
  game["dialog"]["defender_refuel_overtime2"] = "protectthegas";
  game["dialog"]["defender_refuel_overtime3"] = "keepthemawayformourfuel";
  game["dialog"]["defender_refuel_success"] = "thekrautswereabletosteale";
  game["dialog"]["defender_refuel_failure"] = "wekeptthemfromstealingour";
  game["dialog"]["attacker_bridge_start"] = "movefastandescortourlastt";
  game["dialog"]["attacker_bridge_nag1"] = "staynearthetankandprotect";
  game["dialog"]["attacker_bridge_nag2"] = "escortthetanksoitcangetac";
  game["dialog"]["attacker_bridge_nag3"] = "escortthetankacrossthebri";
  game["dialog"]["attacker_bridge_nag4"] = "movetheenemywillblowupthe";
  game["dialog"]["attacker_bridge_nag5"] = "getinthereandescortthetan";
  game["dialog"]["attacker_bridge_progress1"] = "thetanksadvancingprotecti";
  game["dialog"]["attacker_bridge_progress2"] = "thetanksmovingfoward";
  game["dialog"]["attacker_bridge_progress3"] = "thetankisonthemove";
  game["dialog"]["attacker_bridge_retreat1"] = "nobodysescortingthetankit";
  game["dialog"]["attacker_bridge_retreat2"] = "tankisfallingbacknoonesne";
  game["dialog"]["attacker_bridge_retreat3"] = "tankisretreatingitneedsan";
  game["dialog"]["attacker_bridge_overtime1"] = "everyonetothetank";
  game["dialog"]["attacker_bridge_overtime2"] = "standnearthetank";
  game["dialog"]["attacker_bridge_overtime3"] = "rallynearthetank";
  game["dialog"]["attacker_bridge_success"] = "wevewonthebridgeisoursnow";
  game["dialog"]["attacker_bridge_failure"] = "wevelosttheamericanswerea";
  game["dialog"]["defender_bridge_start"] = "keepthekrautsfromescortin";
  game["dialog"]["defender_bridge_nag1"] = "killthekrautsaroundthatta";
  game["dialog"]["defender_bridge_nag2"] = "enemytankisadvancing";
  game["dialog"]["defender_bridge_nag3"] = "destroythetankescort";
  game["dialog"]["defender_bridge_nag4"] = "hammertheinfantrynearthat";
  game["dialog"]["defender_bridge_nag5"] = "layfireontheinfantrybythe";
  game["dialog"]["defender_bridge_progress1"] = "thegermantankisadvancings";
  game["dialog"]["defender_bridge_progress2"] = "enemytankisonthemovekilli";
  game["dialog"]["defender_bridge_progress3"] = "theirtankisadvancing";
  game["dialog"]["defender_bridge_retreat1"] = "thetankisretreatingkeepup";
  game["dialog"]["defender_bridge_retreat2"] = "enemytankispullingback";
  game["dialog"]["defender_bridge_retreat3"] = "thetankisbackingup";
  game["dialog"]["defender_bridge_overtime1"] = "hitthegermansnearthetank";
  game["dialog"]["defender_bridge_overtime2"] = "clearallenemiesfromthetan";
  game["dialog"]["defender_bridge_overtime3"] = "destroythekrautsneartheta";
  game["dialog"]["defender_bridge_success"] = "wevelostthegermanswereabl";
  game["dialog"]["defender_bridge_failure"] = "wediditwegavethedemolitio";
  game["dialog"]["attacker_tank1_shot"] = "anenemytankdisabledoneofo";
  game["dialog"]["defender_tank1_shot"] = "";
  game["dialog"]["attacker_tank2_shot"] = "wevedestroyedtheirambushb";
  game["dialog"]["defender_tank2_shot"] = "weknockedoutoneoftheirtan";
  game["dialog"]["attacker_vista_bridge1"] = "theyvedetonatedoneofthebr";
  game["dialog"]["defender_vista_bridge1"] = "";
  game["dialog"]["attacker_vista_bridge2"] = "theresonlyonebridgeleftno";
  game["dialog"]["defender_vista_bridge2"] = "thatsonebridgedownholdthe";
  game["dialog"]["attacker_2min"] = "2minutesuntiltheenemydest";
  game["dialog"]["attacker_1min"] = "1minuteenemyuntilthebridg";
  game["dialog"]["attacker_30sec"] = "30secondsleft";
  game["dialog"]["attacker_10sec"] = "10seconds2left";
  game["dialog"]["defender_2min"] = "in2minuteswellbereadytode";
  game["dialog"]["defender_1min"] = "1minuteleft";
  game["dialog"]["defender_30sec"] = "30seconds2left";
  game["dialog"]["defender_10sec"] = "10secondsleft";
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  func_7FD0("escort_tanks");
  func_7FC5("tank_refuel");
  func_7F8A("bridge_escort");
}

func_2EDD(param_00, param_01) {
  lib_0506::func_2EDC(param_00, param_01);
  if(issubstr(param_00, "escort_start")) {
    maps\mp\_utility::func_3FA4("intro_vo_complete");
  }
}

func_A61E(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_A5EF)) {
    level.var_A5EF = [];
  }

  if(!isDefined(level.var_7918)) {
    level.var_7918 = 0;
  }

  level.var_7917 = 0;
  var_04 = "";
  var_05 = 0;
  switch (param_01) {
    case "forward":
      if(param_02 > 0.8) {
        var_04 = param_00 + "_near";
      } else {
        var_04 = param_00 + "_progress";
      }
      break;

    case "reverse":
      var_04 = param_00 + "_retreat";
      break;

    case "blocked_forward_scripted":
      var_04 = param_00 + "_blocked";
      break;

    case "unblocked_scripted":
      var_04 = param_00 + "_unblocked";
      var_05 = 1;
      break;

    default:
      break;
  }

  if((level.var_A5EF.size == 0 && level.var_7918 <= gettime()) || var_05) {
    level.var_7918 = gettime() + param_03;
    thread lib_0506::func_A61B(var_04, undefined, !var_05);
    return;
  }

  func_A61F(param_00, var_04, param_02, var_05, param_03);
}

func_A61F(param_00, param_01, param_02, param_03, param_04) {
  if(!param_03 && isDefined(level.var_A5EF[param_00]) && level.var_A5EF[param_00].var_4B83) {
    var_05 = gettime() - level.var_A5EF[param_00].var_9A18;
    if(var_05 < 2500) {
      return;
    }
  }

  var_06 = level.var_A5EF.size == 0;
  if(!isDefined(level.var_A5EF[param_00])) {
    level.var_A5EF[param_00] = spawnStruct();
  }

  level.var_A5EF[param_00].var_9A18 = gettime();
  level.var_A5EF[param_00].laststand_enter_levelspecificaction = param_02;
  level.var_A5EF[param_00].var_A622 = param_01;
  level.var_A5EF[param_00].var_4B83 = param_03;
  if(var_06) {
    func_A621(param_04);
  }
}

func_A620() {
  var_00 = undefined;
  var_01 = undefined;
  foreach(var_05, var_03 in level.var_A5EF) {
    var_04 = gettime() - var_03.var_9A18;
    if((!var_03.var_4B83 && var_04 > 1000) || !var_03.var_4B83 && var_04 > 2500) {
      level.var_A5EF[var_05] = undefined;
      continue;
    }

    if(!isDefined(var_00) || var_03.laststand_enter_levelspecificaction > var_00.laststand_enter_levelspecificaction) {
      var_00 = var_03;
      var_01 = var_05;
    }
  }

  if(isDefined(var_00)) {
    level.var_A5EF[var_01] = undefined;
    return var_00.var_A622;
  }
}

func_A621(param_00) {
  level notify("voProgressTankQueue");
  level endon("voProgressTankQueue");
  var_01 = lib_04FF::func_6937("escort_tanks");
  level endon(var_01);
  while(level.var_A5EF.size > 0) {
    var_02 = level.var_7918 - gettime() / 1000;
    wait(var_02);
    var_03 = func_A620();
    if(isDefined(var_03)) {
      level.var_7918 = gettime() + param_00;
      thread lib_0506::func_A61B(var_03);
    }
  }
}

func_A617(param_00, param_01, param_02) {
  var_03 = 8000;
  var_04 = 8000;
  var_05 = 8000;
  var_06 = 8000;
  if(level.var_3F9D) {
    return;
  }

  if(!isDefined(level.var_7917)) {
    level.var_7917 = 0;
    level.var_7916 = "";
  }

  var_07 = param_00;
  switch (param_00) {
    case "tank_escort_3":
    case "tank_escort_2":
    case "tank_escort_1":
      param_00 = "escort_tanks";
      break;
  }

  if(!isDefined(level.var_A5E4) || level.var_A5E4 != param_00) {
    return;
  }

  if(level.var_7917 < gettime() || param_00 != level.var_7916) {
    switch (param_00) {
      case "escort_tanks":
        func_A61E(var_07, param_01, param_02, var_03);
        break;

      case "tank_refuel":
        if(param_01 == "delivery") {
          thread lib_0506::func_A61B("refuel_delivery_" + param_02);
        } else if(param_01 == "progress") {
          thread lib_0506::func_A61B("refuel_progress_" + param_02);
        } else if(param_01 == "dropped") {
          thread lib_0506::func_A61B("refuel_dropped_" + param_02);
        } else if(param_01 == "thrown") {
          thread lib_0506::func_A61B("refuel_thrown_");
        } else if(param_01 == "returned") {
          thread lib_0506::func_A61B("refuel_returned_" + param_02);
        }
        break;

      case "bridge_escort":
        if(param_01 == "forward") {
          level.var_7917 = gettime() + var_06;
          thread lib_0506::func_A61B("bridge_progress");
        } else if(param_01 == "reverse") {
          level.var_7917 = gettime() + var_06;
          thread lib_0506::func_A61B("bridge_retreat");
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

func_7FD0(param_00) {
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "escort", lib_04FF::func_6937(param_00));
  thread func_7F9B(lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "escort_start", 0.5);
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("escort_success");
}

func_7F9B(param_00) {
  level endon(param_00);
  level waittill("objectiveComplete", var_01);
  if(var_01 == "tank_escort_1") {
    thread lib_0506::func_A618("escort_first1");
    return;
  }

  if(var_01 == "tank_escort_2") {
    thread lib_0506::func_A618("escort_first2");
    return;
  }

  thread lib_0506::func_A618("escort_first3");
}

func_7FC5(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "refuel", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "refuel_start", 0.5);
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("refuel_success");
}

func_7F8A(param_00) {
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "bridge", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "bridge_start", 0.5);
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("bridge_success", 0.5);
}