/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc2_vo.gsc
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
  game["dialog"]["offense_obj"] = "alrightsoldierslistenupou";
  game["dialog"]["defense_obj"] = "keepalertourmenhavespotte";
  game["dialog"]["attacker_intel_start"] = "letsgettheintelandgetoutm";
  game["dialog"]["attacker_intel_nag1"] = "acquiretheintel";
  game["dialog"]["attacker_intel_nag2"] = "findtheintelmove";
  game["dialog"]["attacker_intel_nag3"] = "pushitsoldiersgetthatinte";
  game["dialog"]["attacker_intel_nag4"] = "grabtheintel";
  game["dialog"]["attacker_intel_nag5"] = "letsgosoldiersgettheintel";
  game["dialog"]["attacker_intel_pickup1"] = "intelacquired";
  game["dialog"]["attacker_intel_pickup2"] = "wevegotapieceofintel";
  game["dialog"]["attacker_intel_pickup3"] = "wevepickedupintel";
  game["dialog"]["attacker_intel_dropped1"] = "intelontheground";
  game["dialog"]["attacker_intel_dropped2"] = "intellost";
  game["dialog"]["attacker_intel_dropped3"] = "inteldropped";
  game["dialog"]["attacker_intel_delivery1"] = "intelcaptured2moretogo";
  game["dialog"]["attacker_intel_delivery2"] = "intelsecure1left";
  game["dialog"]["attacker_intel_overtime1"] = "wereoutoftimesecurethatin";
  game["dialog"]["attacker_intel_overtime2"] = "getthatintelnow";
  game["dialog"]["attacker_intel_overtime3"] = "lastchancesoldiersmovemov";
  game["dialog"]["attacker_intel_success"] = "allintelhasbeenacquiredni";
  game["dialog"]["attacker_intel_failure"] = "wefailedtoacquiretheintel";
  game["dialog"]["defender_intel_start"] = "donotletthemstealourintel";
  game["dialog"]["defender_intel_nag1"] = "defendourintel";
  game["dialog"]["defender_intel_nag2"] = "holdthemback";
  game["dialog"]["defender_intel_nag3"] = "donotletthemstealtheintel";
  game["dialog"]["defender_intel_nag4"] = "protecttheintel";
  game["dialog"]["defender_intel_nag5"] = "holdthemoffdefendtheintel";
  game["dialog"]["defender_intel_pickup1"] = "theyvegotourintel";
  game["dialog"]["defender_intel_pickup2"] = "theyhaveapieceofintel";
  game["dialog"]["defender_intel_pickup3"] = "theyvepickedupintel";
  game["dialog"]["defender_intel_dropped1"] = "intelhasbeendroppedgetitb";
  game["dialog"]["defender_intel_dropped2"] = "inteldowngetitnow";
  game["dialog"]["defender_intel_dropped3"] = "theyvedroppedintelgetit";
  game["dialog"]["defender_intel_delivery1"] = "theyvecapturedapieceofint";
  game["dialog"]["defender_intel_delivery2"] = "intelhasbeencapturedonlyo";
  game["dialog"]["defender_intel_overtime1"] = "timeisalmostupprotectthei";
  game["dialog"]["defender_intel_overtime2"] = "holdthemmenvictoryisinour";
  game["dialog"]["defender_intel_overtime3"] = "pushthembackwevealmostwon";
  game["dialog"]["defender_intel_success"] = "theyvecapturedalloftheint";
  game["dialog"]["defender_intel_failure"] = "weveheldoffthealliedattac";
  game["dialog"]["attacker_transmit_start"] = "weneedtotransmitthetarget";
  game["dialog"]["attacker_transmit_nag1"] = "transmittheintel";
  game["dialog"]["attacker_transmit_nag2"] = "pushitsoldiersgetthosecoo";
  game["dialog"]["attacker_transmit_nag3"] = "getthetargetinteltransmit";
  game["dialog"]["attacker_transmit_nag4"] = "transmitthetargetlocation";
  game["dialog"]["attacker_transmit_nag5"] = "getthosecoordinatestransm";
  game["dialog"]["attacker_transmit_progress1"] = "transmittingcoordinates";
  game["dialog"]["attacker_transmit_progress2"] = "weresendingthecoordinates";
  game["dialog"]["attacker_transmit_progress3"] = "coordinatesarebeingtransm";
  game["dialog"]["attacker_transmit_overtime1"] = "getthatinteltransmittedwe";
  game["dialog"]["attacker_transmit_overtime2"] = "wereoutoftimeholdthemback";
  game["dialog"]["attacker_transmit_overtime3"] = "pushitsoldiersgettheintel";
  game["dialog"]["attacker_transmit_success"] = "alltargetinformationhasbe";
  game["dialog"]["attacker_transmit_failure"] = "wefailedtotransmitthecoor";
  game["dialog"]["defender_transmit_start"] = "wemustnotletthemtransmitt";
  game["dialog"]["defender_transmit_nag1"] = "defendtheradiostation";
  game["dialog"]["defender_transmit_nag2"] = "donotletthemtransmittheta";
  game["dialog"]["defender_transmit_nag3"] = "protecttheradiostation";
  game["dialog"]["defender_transmit_nag4"] = "theymustnottransmitthetar";
  game["dialog"]["defender_transmit_nag5"] = "holdthembackdefendtheradi";
  game["dialog"]["defender_transmit_progress1"] = "theyretransmittingthetarg";
  game["dialog"]["defender_transmit_progress2"] = "theenemyistransmittingsto";
  game["dialog"]["defender_transmit_progress3"] = "thealliesaretransmittingt";
  game["dialog"]["defender_transmit_overtime1"] = "holdontheymustnotwin";
  game["dialog"]["defender_transmit_overtime2"] = "tothedeaththeymustnotsucc";
  game["dialog"]["defender_transmit_overtime3"] = "timeisalmostupholdthispos";
  game["dialog"]["defender_transmit_success"] = "theyvetransmittedthetarge";
  game["dialog"]["defender_transmit_failure"] = "kongratulationsmeinkamera";
  game["dialog"]["attacker_bomber_start"] = "ourbombersareenroutetothe";
  game["dialog"]["attacker_bomber_nag1"] = "destroytheirfighters";
  game["dialog"]["attacker_bomber_nag2"] = "cleartheskiestakedownthei";
  game["dialog"]["attacker_bomber_nag3"] = "keeponthemtakeouttheirfig";
  game["dialog"]["attacker_bomber_nag4"] = "ourbombersareapproachingd";
  game["dialog"]["attacker_bomber_nag5"] = "moveitgetthosefightersout";
  game["dialog"]["attacker_bomber_progress_axis1"] = "enemyfighterdown";
  game["dialog"]["attacker_bomber_progress_axis2"] = "enemybanditgoingdown";
  game["dialog"]["attacker_bomber_progress_axis3"] = "bogiedown";
  game["dialog"]["attacker_bomber_progress_axis4"] = "anotherenemydownkeepgoing";
  game["dialog"]["attacker_bomber_progress_axis5"] = "enemyfighterishistory";
  game["dialog"]["attacker_bomber_progress_allies1"] = "theyvedestroyedoneofourfi";
  game["dialog"]["attacker_bomber_progress_allies2"] = "friendlygoingdown";
  game["dialog"]["attacker_bomber_progress_allies3"] = "wejustlostanotherfighter";
  game["dialog"]["attacker_bomber_progress_allies4"] = "theytookoutanotherfriendl";
  game["dialog"]["attacker_bomber_progress_allies5"] = "theydestroyedoneofourfigh";
  game["dialog"]["attacker_bomber_onsix1"] = "enemyhasyounailedevasivem";
  game["dialog"]["attacker_bomber_onsix2"] = "hesonyoursixshakehimoff";
  game["dialog"]["attacker_bomber_onsix3"] = "bogieonyoursixmove";
  game["dialog"]["attacker_bomber_onsix4"] = "bandithasyouinsightmovemo";
  game["dialog"]["attacker_bomber_onsix5"] = "banditonyourtailshakehim";
  game["dialog"]["attacker_bomber_fightersleft_axis1"] = "halfoftheirfightersaredow";
  game["dialog"]["attacker_bomber_fightersleft_axis2"] = "10bogiesleft";
  game["dialog"]["attacker_bomber_fightersleft_axis3"] = "5enemyfightersleft";
  game["dialog"]["attacker_bomber_fightersleft_axis4"] = "3banditstogo";
  game["dialog"]["attacker_bomber_fightersleft_axis5"] = "onemoreenemyfighterleft";
  game["dialog"]["attacker_bomber_fightersleft_allies1"] = "theyvetakenouthalfofourfi";
  game["dialog"]["attacker_bomber_fightersleft_allies2"] = "10friendlyfightersleft";
  game["dialog"]["attacker_bomber_fightersleft_allies3"] = "5friendiesleft";
  game["dialog"]["attacker_bomber_fightersleft_allies4"] = "only3ofourfightersareleft";
  game["dialog"]["attacker_bomber_fightersleft_allies5"] = "onlyonefriendlyleft";
  game["dialog"]["attacker_bomber_damage1"] = "ourbombersaretakingdamage";
  game["dialog"]["attacker_bomber_damage2"] = "bombersareunderfiredefend";
  game["dialog"]["attacker_bomber_damage3"] = "ourbombersareunderattack";
  game["dialog"]["attacker_bomber_damage4"] = "takingfiretakingfire";
  game["dialog"]["attacker_bomber_damage5"] = "werebeinghitholdthemoff";
  game["dialog"]["attacker_bomber_overtime1"] = "getthosefightersoutofthes";
  game["dialog"]["attacker_bomber_overtime2"] = "cleartheskiesourbombersar";
  game["dialog"]["attacker_bomber_overtime3"] = "bombersareinboundclearthe";
  game["dialog"]["attacker_bomber_success"] = "theirfightersarehistorybo";
  game["dialog"]["attacker_bomber_failure"] = "wefailedtotakeouttheirfig";
  game["dialog"]["defender_bomber_start"] = "theenemybombersareenroute_alt";
  game["dialog"]["defender_bomber_nag1"] = "destroytheenemyfighters";
  game["dialog"]["defender_bomber_nag2"] = "holdthisairspacedestroyth";
  game["dialog"]["defender_bomber_nag3"] = "takedownthealliedplanes";
  game["dialog"]["defender_bomber_nag4"] = "destroytheirplanes";
  game["dialog"]["defender_bomber_nag5"] = "eliminatetheenemyfighters";
  game["dialog"]["defender_bomber_progress_axis1"] = "ourfighterhasbeendestroye";
  game["dialog"]["defender_bomber_progress_axis2"] = "ourplaneisgoingdown";
  game["dialog"]["defender_bomber_progress_axis3"] = "theyvedestroyedanotherpla";
  game["dialog"]["defender_bomber_progress_axis4"] = "friendlyplaneisdown";
  game["dialog"]["defender_bomber_progress_axis5"] = "theydestroyedoneofourfigh";
  game["dialog"]["defender_bomber_progress_allies1"] = "wevedestroyedanalliedplan";
  game["dialog"]["defender_bomber_progress_allies2"] = "alliedfighterisdown";
  game["dialog"]["defender_bomber_progress_allies3"] = "enemyfighterdestroyed";
  game["dialog"]["defender_bomber_progress_allies4"] = "enemyplaneisdown";
  game["dialog"]["defender_bomber_progress_allies5"] = "wevedestroyedafighter";
  game["dialog"]["defender_bomber_onsix1"] = "enemyonyourtailpealoff";
  game["dialog"]["defender_bomber_onsix2"] = "enemyfighterbehindyoushak";
  game["dialog"]["defender_bomber_onsix3"] = "alliedfighteronyourtail";
  game["dialog"]["defender_bomber_onsix4"] = "enemyonyoursixevasivemane";
  game["dialog"]["defender_bomber_onsix5"] = "onyourtailtakeaction";
  game["dialog"]["defender_bomber_fightersleft_allies1"] = "halfoftheirfightersaredow";
  game["dialog"]["defender_bomber_fightersleft_allies2"] = "10enemyplanesremain";
  game["dialog"]["defender_bomber_fightersleft_allies3"] = "5enemiesleft";
  game["dialog"]["defender_bomber_fightersleft_allies4"] = "3alliedplanesremain";
  game["dialog"]["defender_bomber_fightersleft_allies5"] = "oneenemyremains";
  game["dialog"]["defender_bomber_fightersleft_axis1"] = "halfofourplaneshavebeenel";
  game["dialog"]["defender_bomber_fightersleft_axis2"] = "wehave10fightersleftholdt";
  game["dialog"]["defender_bomber_fightersleft_axis3"] = "5ofourplanesremain";
  game["dialog"]["defender_bomber_fightersleft_axis4"] = "3friendlyfightersremain";
  game["dialog"]["defender_bomber_fightersleft_axis5"] = "wehaveonlyoneplaneleft";
  game["dialog"]["defender_bomber_damage1"] = "weredamagingtheirbombers";
  game["dialog"]["defender_bomber_damage2"] = "theirbombersaretakingfire";
  game["dialog"]["defender_bomber_damage3"] = "theenemybombersaresustain";
  game["dialog"]["defender_bomber_damage4"] = "keepfiringtheyhavebeenhit";
  game["dialog"]["defender_bomber_damage5"] = "theirbombersaredamaged";
  game["dialog"]["defender_bomber_overtime1"] = "achtungdestroytheirplanes";
  game["dialog"]["defender_bomber_overtime2"] = "destroytheenemyfighters";
  game["dialog"]["defender_bomber_overtime3"] = "takedownthealliedplanes";
  game["dialog"]["defender_bomber_success"] = "theyhavedestroyedallofour";
  game["dialog"]["defender_bomber_failure"] = "theirfightershavebeendest";
  game["dialog"]["attacker_2min"] = "2minutesleftuntilenemyrei";
  game["dialog"]["attacker_1min"] = "in1minuteenemyreinforceme";
  game["dialog"]["attacker_30sec"] = "30secondsleft";
  game["dialog"]["attacker_10sec"] = "wererunningoutoftime10sec";
  game["dialog"]["defender_2min"] = "2minutesleftuntilourreinf";
  game["dialog"]["defender_1min"] = "1minuteleftkeepfighting";
  game["dialog"]["defender_30sec"] = "30secondsuntilourreinforc";
  game["dialog"]["defender_10sec"] = "10secondsleft";
  game["dialog"]["raid_fighters"] = "ss_fighterstraff_achieve";
  game["dialog"]["allies_friendly_raid_fighters_inbound"] = "ss_fighterstraff_allyuse";
  game["dialog"]["allies_enemy_raid_fighters_inbound"] = "ss_fighterstraff_enemyuse";
  game["dialog"]["raid_flak"] = "ss_flak_achieve";
  game["dialog"]["axis_friendly_raid_flak_inbound"] = "ss_flak_allyuse";
  game["dialog"]["axis_enemy_raid_flak_inbound"] = "ss_flak_enemyuse";
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  runintelvo("intel_collect");
  runtransmitvo("radio_hardpoint");
  runbombervo("fighter_deathmatch");
}

runintelvo(param_00) {
  level.intelobjectivevoplayedcount = 0;
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  lib_0506::func_A61C(param_00, "intel_start", 0.5);
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "intel", lib_04FF::func_6937(param_00));
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("intel_success");
}

runtransmitvo(param_00) {
  level.transmitvoindex = 0;
  level.radiostruct = common_scripts\utility::func_46B5("radio_hardpoint", "targetname");
  level.radiosoundent = spawn("script_model", level.radiostruct.var_116);
  thread radiotransmitvo();
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "transmit", lib_04FF::func_6937(param_00));
  lib_0506::func_A61C(param_00, "transmit_start");
  lib_04FF::func_6982(param_00);
  lib_0506::func_A61A("transmit_success");
}

runbombervo(param_00) {
  game["dialog"]["attacker_2min"] = "2minutesuntilourbombersar";
  game["dialog"]["attacker_1min"] = "1minutebombersarenearingt";
  game["dialog"]["defender_2min"] = "2minutesuntiltheirbombers";
  game["dialog"]["defender_1min"] = "1minutelefttheirbombersar";
  maps\mp\gametypes\_hostmigration::func_A6F5(2);
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_01, "bomber", lib_04FF::func_6937(param_00));
  thread watchbomberdamage();
  lib_0506::func_A61C(param_00, "bomber_start");
  lib_04FF::func_6982(param_00);
  thread lib_0506::func_A619("bomber_success", 0.5);
}

watchbomberdamage() {
  level endon("game_ended");
  level endon("objectiveComplete");
  for(var_00 = 0; var_00 < 5; var_00++) {
    level waittill("bomber_damage");
    thread lib_0506::func_A61B("bomber_damage", 0, 1, 5);
    var_01 = randomintrange(20, 60);
    maps\mp\gametypes\_hostmigration::func_A6F5(var_01);
  }
}

func_A617(param_00, param_01, param_02) {
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
      case "intel_collect":
        if(param_01 == "delivery") {
          level.intelobjectivevoplayedcount++;
          if(level.intelobjectivevoplayedcount > 2) {
            return;
          }

          thread lib_0506::func_A61B("intel_delivery");
        } else if(param_01 == "progress") {
          thread lib_0506::func_A61B("intel_pickup");
        } else if(param_01 == "dropped") {
          thread lib_0506::func_A61B("intel_dropped");
        } else if(param_01 == "returned") {}
        break;

      case "radio_hardpoint":
        if(param_01 == "start_capture") {
          level.var_7917 = gettime();
          thread lib_0506::func_A61B("transmit_progress");
        }

        break;

      case "fighter_deathmatch":
        if(param_01 == "death") {
          if(isDefined(param_02)) {
            if(param_02 == game["attackers"]) {
              var_03 = "allies";
            } else {
              var_03 = "axis";
            }

            waittillframeend;
            if(level.fighters_downed == level.numfighterkillsrequired) {
              return;
            }

            level.var_7917 = gettime();
            thread lib_0506::func_A61B("bomber_progress_" + var_03, 0, 1, 5);
            thread voplayfightersleft(var_03);
          }
        } else if(param_01 == "onsix") {
          var_04 = param_02;
          if(isPlayer(var_04)) {
            var_04 thread dogfightonsixvo();
          }
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

radiotransmitvo() {
  level endon("game_ended");
  waittillframeend;
  var_00 = ["alpha", "bravo", "charlie"];
  var_01 = level.var_8D1[0];
  if(isDefined(var_01)) {
    var_01.capping = 0;
  }

  while(level.var_8D1.size) {
    while(var_01.var_931A != "taking") {
      wait(0.25);
    }

    wait(1);
    lib_0380::func_288E("al_war_huskyintro" + var_00[level.transmitvoindex], undefined, level.radiosoundent, 1, 0.5, 1, "stop_transmit_vo");
    level.transmitvoindex++;
    if(level.transmitvoindex > 2) {
      level.transmitvoindex = 0;
    }

    while(var_01.var_931A == "taking") {
      if(!level.var_8D1.size) {
        break;
      }

      wait(0.25);
    }

    level.radiosoundent notify("stop_transmit_vo");
    wait 0.05;
  }

  level.radiosoundent notify("stop_transmit_vo");
}

voplayfightersleft(param_00) {
  if(param_00 == "allies") {
    var_01 = level.alliedfightersdowned;
  } else {
    var_01 = level.axisfightersdowned;
  }

  if(var_01 == level.numfighterkillsrequired - 1) {
    thread lib_0506::func_A618("bomber_fightersleft_" + param_00 + "5", undefined, undefined);
    return;
  }

  if(var_01 == level.numfighterkillsrequired - 3) {
    thread lib_0506::func_A618("bomber_fightersleft_" + param_00 + "4", undefined, undefined);
    return;
  }

  if(var_01 == level.numfighterkillsrequired - 5) {
    thread lib_0506::func_A618("bomber_fightersleft_" + param_00 + "3", undefined, undefined);
    return;
  }

  if(var_01 == level.numfighterkillsrequired - 10) {
    thread lib_0506::func_A618("bomber_fightersleft_" + param_00 + "2", undefined, undefined);
    return;
  }
}

dogfightonsixvo() {
  level endon("game_ended");
  if(isDefined(self.allowonsixvo) && !self.allowonsixvo) {
    return;
  }

  if(!isDefined(self.onsixvoindex)) {
    self.onsixvoindex = 1;
  }

  if(!isDefined(self.allowonsixvo)) {
    self.allowonsixvo = 1;
  }

  thread lib_0506::func_A618("bomber_onsix" + self.onsixvoindex, undefined, undefined, 1, self);
  self.onsixvoindex++;
  if(self.onsixvoindex > 5) {
    self.onsixvoindex = 1;
  }

  self.allowonsixvo = 0;
  thread allowonsixvocooldown();
}

allowonsixvocooldown() {
  level endon("game_ended");
  var_00 = randomintrange(5, 10);
  maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
  self.allowonsixvo = 1;
}