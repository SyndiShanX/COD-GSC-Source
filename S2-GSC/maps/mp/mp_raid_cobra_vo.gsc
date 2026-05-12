/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_cobra_vo.gsc
*********************************************/

func_5366() {
  level.var_2EBB = ::func_2EDE;
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
  game["dialog"]["offense_obj"] = "enemyartilleryisshellingt";
  game["dialog"]["defense_obj"] = "ourartilleryguniskeepinge";
  game["dialog"]["attacker_capture_start"] = "allrightsoldiereitherseiz";
  game["dialog"]["attacker_capture_nag1"] = "getinthereweneedtheinfoin";
  game["dialog"]["attacker_capture_nag2"] = "yourteamneedstoadvanceand";
  game["dialog"]["attacker_capture_nag3"] = "timeisrunningoutcaptureth";
  game["dialog"]["attacker_capture_nag4"] = "pushharderweneedthatcomma";
  game["dialog"]["attacker_capture_nag5"] = "capturethecommandpostkrau";
  game["dialog"]["attacker_capture_progress1"] = "weretakingthecommandpost";
  game["dialog"]["attacker_capture_progress2"] = "attackingthecommandpost";
  game["dialog"]["attacker_capture_progress3"] = "werefightingforthecommand";
  game["dialog"]["attacker_capture_overtime1"] = "finalpusheveryonetothecom";
  game["dialog"]["attacker_capture_overtime2"] = "doordiegettothecommandpos";
  game["dialog"]["attacker_capture_overtime3"] = "lastchancegettothecommand";
  game["dialog"]["attacker_capture_success"] = "welldonewiththecommandpos";
  game["dialog"]["attacker_capture_failure"] = "wevelostgermanreinforceme";
  game["dialog"]["defender_capture_start"] = "protectourcommandpostsoth";
  game["dialog"]["defender_capture_nag1"] = "defendthecommandpostsoldi";
  game["dialog"]["defender_capture_nag2"] = "fightdonotletthealliestak";
  game["dialog"]["defender_capture_nag3"] = "protectthecommandpostatal";
  game["dialog"]["defender_capture_nag4"] = "holdonreinforcementswillb";
  game["dialog"]["defender_capture_nag5"] = "stoptheamericansfromcaptu";
  game["dialog"]["defender_capture_progress1"] = "theenemyistakingourcomman";
  game["dialog"]["defender_capture_progress2"] = "theyreattackingourcommand";
  game["dialog"]["defender_capture_progress3"] = "ourcommandpostisunderatta";
  game["dialog"]["defender_capture_overtime1"] = "clearthemoutofthecommandp";
  game["dialog"]["defender_capture_overtime2"] = "killthealliesinthecommand";
  game["dialog"]["defender_capture_overtime3"] = "killallalliesatthecommand";
  game["dialog"]["defender_capture_success"] = "theallieshavecapturedourc";
  game["dialog"]["defender_capture_failure"] = "theycapturedourcommandpos";
  game["dialog"]["attacker_bridge_start"] = "youvegot2optionseithertak";
  game["dialog"]["attacker_bridge_nag1"] = "youhavetorepairthebridge";
  game["dialog"]["attacker_bridge_nag2"] = "getyourtroopsinthereandre";
  game["dialog"]["attacker_bridge_nag3"] = "yougottafixthatbridgebefo";
  game["dialog"]["attacker_bridge_nag4"] = "buildthatbridgeasap";
  game["dialog"]["attacker_bridge_nag5"] = "yourerunningoutoftimefixt";
  game["dialog"]["attacker_bridge_progress1"] = "thebridgeisbeingbuilt";
  game["dialog"]["attacker_bridge_progress2"] = "werebuildingthebridge";
  game["dialog"]["attacker_bridge_progress3"] = "bridgeisbeingrepaired";
  game["dialog"]["attacker_bridge_halfway1"] = "werehalfwaydonerepairingt";
  game["dialog"]["attacker_bridge_halfway2"] = "wevegothalfthebridgerepai";
  game["dialog"]["attacker_bridge_halfway3"] = "thebridgeishalfbuilt";
  game["dialog"]["attacker_bridge_overtime1"] = "finalpusheveryonebuildthe";
  game["dialog"]["attacker_bridge_overtime2"] = "doordiebuildthebridge";
  game["dialog"]["attacker_bridge_overtime3"] = "lastchancebuildthebridge";
  game["dialog"]["attacker_bridge_success"] = "goodjobthebridgeisopenour";
  game["dialog"]["attacker_bridge_failure"] = "wevefailedgermanreinforce";
  game["dialog"]["defender_bridge_start"] = "youvegot2areastoprotectno";
  game["dialog"]["defender_bridge_nag1"] = "fightkeeptheamericansfrom";
  game["dialog"]["defender_bridge_nag2"] = "keepthealliesfromfixingth";
  game["dialog"]["defender_bridge_nag3"] = "getintherestopthealliesfr";
  game["dialog"]["defender_bridge_nag4"] = "donotallowtheenemytofixth";
  game["dialog"]["defender_bridge_nag5"] = "keepfightingourreinforcem";
  game["dialog"]["defender_bridge_progress1"] = "theyrebuildingthebridge";
  game["dialog"]["defender_bridge_progress2"] = "theenemyisrepairingthebri";
  game["dialog"]["defender_bridge_progress3"] = "thebridgeisbeingrepaired";
  game["dialog"]["defender_bridge_halfway1"] = "theyrehalfwaydonerepairin";
  game["dialog"]["defender_bridge_halfway2"] = "theyvegothalfthebridgerep";
  game["dialog"]["defender_bridge_halfway3"] = "thebridgeishalfwayfixed";
  game["dialog"]["defender_bridge_overtime1"] = "killallalliesatthebridge";
  game["dialog"]["defender_bridge_overtime2"] = "clearallalliesfromthebrid";
  game["dialog"]["defender_bridge_overtime3"] = "killthealliesatthebridge";
  game["dialog"]["defender_bridge_success"] = "theenemyrepairedthebridge";
  game["dialog"]["defender_bridge_failure"] = "wediditwekeptthealliesfro";
  game["dialog"]["attacker_ammo_start"] = "destroythatammunitiondump";
  game["dialog"]["attacker_ammo_nag1"] = "theenemyammunitiondumpmus";
  game["dialog"]["attacker_ammo_nag2"] = "yoursquadneedstoadvancean";
  game["dialog"]["attacker_ammo_nag3"] = "ifyoudonttakeoutthatammun";
  game["dialog"]["attacker_ammo_nag4"] = "whatareyouwaitingfordestr";
  game["dialog"]["attacker_ammo_nag5"] = "takeoutthatammodumpbefore";
  game["dialog"]["attacker_ammo_progress1"] = "abombsbeenplantedontheamm";
  game["dialog"]["attacker_ammo_progress2"] = "weplantedabombontheammodu";
  game["dialog"]["attacker_ammo_progress3"] = "bombactivatedontheammodum";
  game["dialog"]["attacker_ammo_defend1"] = "defendthatbombsoldier";
  game["dialog"]["attacker_ammo_defend2"] = "youhavetokeepthekrautsawa";
  game["dialog"]["attacker_ammo_defend3"] = "protectthebombatallcosts";
  game["dialog"]["attacker_ammo_defend4"] = "dontletthegermansdefuseth";
  game["dialog"]["attacker_ammo_defend5"] = "protectthebombuntilitdeto";
  game["dialog"]["attacker_ammo_defuse1"] = "thekrautsdefusedourbomb";
  game["dialog"]["attacker_ammo_defuse2"] = "thegermansdeactivatedourb";
  game["dialog"]["attacker_ammo_defuse3"] = "ourbombsbeendefused";
  game["dialog"]["attacker_ammo_overtime1"] = "finalpushsquaddefendthebo";
  game["dialog"]["attacker_ammo_overtime2"] = "doordieeveryonedefendtheb";
  game["dialog"]["attacker_ammo_overtime3"] = "lastchancedefendthebomb";
  game["dialog"]["attacker_ammo_success"] = "welldonesoldiertheenemyam";
  game["dialog"]["attacker_ammo_failure"] = "thekrautshavewontheirrein";
  game["dialog"]["defender_ammo_start"] = "dontlettheenemydestroythe";
  game["dialog"]["defender_ammo_nag1"] = "youmustprotecttheammuniti";
  game["dialog"]["defender_ammo_nag2"] = "donotallowtheamericanstod";
  game["dialog"]["defender_ammo_nag3"] = "keepfightingreinforcement";
  game["dialog"]["defender_ammo_nag4"] = "youcanwinthisourreinforce";
  game["dialog"]["defender_ammo_nag5"] = "theamericanscannotbeallow";
  game["dialog"]["defender_ammo_progress1"] = "abombsbeenplantedonouramm";
  game["dialog"]["defender_ammo_progress2"] = "theenemyplantedabombonour";
  game["dialog"]["defender_ammo_progress3"] = "theresabombonourammodump";
  game["dialog"]["defender_ammo_defend1"] = "defusethebombbeforeitdeto";
  game["dialog"]["defender_ammo_defend2"] = "getinthereandstopthatbomb";
  game["dialog"]["defender_ammo_defend3"] = "youmustdefusethebomboritw";
  game["dialog"]["defender_ammo_defend4"] = "quicklydefusethebomb";
  game["dialog"]["defender_ammo_defend5"] = "youmuststopthatbombimmedi";
  game["dialog"]["defender_ammo_defuse1"] = "wedefusedthealliedbomb";
  game["dialog"]["defender_ammo_defuse2"] = "wedeactivatedthebomb";
  game["dialog"]["defender_ammo_defuse3"] = "thebombsbeendefused";
  game["dialog"]["defender_ammo_overtime1"] = "squadremovethebomb";
  game["dialog"]["defender_ammo_overtime2"] = "stopthebomb";
  game["dialog"]["defender_ammo_overtime3"] = "defusethebomb";
  game["dialog"]["defender_ammo_success"] = "theenemyhasdestroyedtheam";
  game["dialog"]["defender_ammo_failure"] = "goodjobwekepttheammodumps";
  game["dialog"]["attacker_escort_start"] = "repairthetankandescortitt";
  game["dialog"]["attacker_escort_nag1"] = "youhavetorepairthetanksol";
  game["dialog"]["attacker_escort_nag2"] = "repairthetanksoitcandestr";
  game["dialog"]["attacker_escort_nag3"] = "timesrunningoutyouhavetor";
  game["dialog"]["attacker_escort_nag4"] = "movekrautreinforcementsar";
  game["dialog"]["attacker_escort_nag5"] = "defendourtankfromthekraut";
  game["dialog"]["attacker_escort_progress1"] = "weremovingthetank";
  game["dialog"]["attacker_escort_progress2"] = "ourtankisonthemove";
  game["dialog"]["attacker_escort_progress3"] = "tankadvancing";
  game["dialog"]["attacker_escort_retreat1"] = "nobodystheretoescortourta";
  game["dialog"]["attacker_escort_retreat2"] = "thetanksfallingbacknoones";
  game["dialog"]["attacker_escort_retreat3"] = "wegottaretreattheresnoone";
  game["dialog"]["attacker_escort_destroy1"] = "gotonebutthemainbatteryis";
  game["dialog"]["attacker_escort_destroy2"] = "goodkeepadvancingtothechu";
  game["dialog"]["attacker_escort_destroy3"] = "alrightletsgettothechurch";
  game["dialog"]["attacker_escort_overtime1"] = "finalpusheveryonetothetan";
  game["dialog"]["attacker_escort_overtime2"] = "doordiestandnearthetank";
  game["dialog"]["attacker_escort_overtime3"] = "lastchancegetnearthetank";
  game["dialog"]["attacker_escort_success"] = "welldonesoldieryoudestroy";
  game["dialog"]["attacker_escort_failure"] = "wecouldntgetitdonethekrau";
  game["dialog"]["defender_escort_start"] = "wehavetodestroythealliedt";
  game["dialog"]["defender_escort_nag1"] = "dontlettheenemyrepairthat";
  game["dialog"]["defender_escort_nag2"] = "stoptheamericanstheyrefix";
  game["dialog"]["defender_escort_nag3"] = "dontlettheenemyrepairthat";
  game["dialog"]["defender_escort_nag4"] = "destroythattankatanycost";
  game["dialog"]["defender_escort_nag5"] = "fightstopthattanknow";
  game["dialog"]["defender_escort_progress1"] = "theenemyismovingtheirtank";
  game["dialog"]["defender_escort_progress2"] = "enemytankisonthemove";
  game["dialog"]["defender_escort_progress3"] = "theyremovingthetank";
  game["dialog"]["defender_escort_retreat1"] = "thealliesarentnearthetank";
  game["dialog"]["defender_escort_retreat2"] = "theenemyisclearedouttheir";
  game["dialog"]["defender_escort_retreat3"] = "wekilledallalliedsoldiers";
  game["dialog"]["defender_escort_destroy1"] = "theydestroyedoneofourcann";
  game["dialog"]["defender_escort_destroy2"] = "dontletthemdestroyourcann";
  game["dialog"]["defender_escort_destroy3"] = "keepthemfromdestroyingthe";
  game["dialog"]["defender_escort_overtime1"] = "killallalliesnearthetank";
  game["dialog"]["defender_escort_overtime2"] = "clearallalliesfromthetank";
  game["dialog"]["defender_escort_overtime3"] = "dontlettheenemyrepairthat";
  game["dialog"]["defender_escort_success"] = "wevelosttheydestroyourart";
  game["dialog"]["defender_escort_failure"] = "wevewonreinforcementshave";
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
  func_7F9F("farm_hardpoint");
  func_7F8C("bridge_2");
  func_7FDA("town_bombplant");
  func_7FD0("tank_escort");
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

  if(!isDefined(level.var_A5E4) || level.var_A5E4 != param_00) {
    return;
  }

  if(level.var_7917 < gettime() || param_00 != level.var_7916) {
    switch (param_00) {
      case "farm_hardpoint":
        if(param_01 == "start_capture") {
          level.var_7917 = gettime() + var_03;
          thread lib_0506::func_A61B("capture_progress");
        }
        break;

      case "farm_bombplant":
        if(param_01 == "bomb_planted") {
          thread lib_0506::func_A61B("gun_progress");
        }
        break;

      case "bridge_2":
      case "bridge_1":
        level.var_7917 = gettime() + var_04;
        thread lib_0506::func_A61B("bridge_progress");
        break;

      case "town_destruction":
        level.var_7917 = gettime() + var_05;
        thread lib_0506::func_A61B("radar_progress");
        break;

      case "town_bombplant":
        if(param_01 == "bomb_planted") {
          thread lib_0506::func_A61B("ammo_progress", 1);
        }
        break;

      case "tank_hedgerow":
      case "tank_escort":
        if(param_01 == "forward") {
          level.var_7917 = gettime() + var_06;
          thread lib_0506::func_A61B("escort_progress");
        } else if(param_01 == "reverse") {
          level.var_7917 = gettime() + var_06;
          thread lib_0506::func_A61B("escort_retreat");
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

func_7F9F(param_00) {
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "capture", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C("farm_hardpoint", "capture_start");
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("capture_success");
}

func_7F8C(param_00) {
  level endon("game_ended");
  var_01 = 3;
  var_02 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_02, "bridge", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C("bridge_1", "bridge_start", 0.5);
  lib_04FF::func_6982("bridge_1");
  var_03 = randomintrange(1, var_01 + 1);
  lib_0506::func_A61C("bridge_2", "bridge_halfway" + var_03);
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("bridge_success");
}

func_7FDA(param_00) {
  level endon("game_ended");
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "ammo", lib_04FF::func_6937(param_00));
  thread func_7FD6(lib_04FF::func_6937(param_00));
  lib_0506::func_A61C("town_bombplant", "ammo_start", 0.5);
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("ammo_success");
}

func_7FD6(param_00) {
  level endon(param_00);
  var_01 = common_scripts\utility::func_46B5("town_bombplant", "targetname");
  var_02 = 1;
  for(;;) {
    var_01 waittill("bomb_planted");
    thread func_7FD7(var_01, param_00);
    var_01 waittill("bomb_defused");
    thread lib_0506::func_A618("ammo_defuse" + var_02, 1);
    var_02++;
    if(var_02 > 3) {
      var_02 = 1;
    }
  }
}

func_7FD7(param_00, param_01) {
  level endon(param_01);
  param_00 endon("bomb_defused");
  wait(10);
  if(common_scripts\utility::func_24A6()) {
    thread lib_0506::func_A618("ammo_defend1");
  } else {
    thread lib_0506::func_A618("ammo_defend2");
  }

  wait(10);
  thread lib_0506::func_A618("ammo_defend3");
  wait(10);
  if(common_scripts\utility::func_24A6()) {
    thread lib_0506::func_A618("ammo_defend4");
    return;
  }

  thread lib_0506::func_A618("ammo_defend5");
}

func_7FD0(param_00) {
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "escort", lib_04FF::func_6937(param_00));
  thread func_7F9D();
  lib_0506::func_A61C(param_00, "escort_start", 0.5);
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("escort_success", 0.5);
}

func_7F9D() {
  var_00 = 3;
  for(var_01 = 1; var_01 <= var_00; var_01++) {
    level waittill("tank_target_destroyed");
    thread lib_0506::func_A618("escort_destroy" + var_01, 2);
  }
}