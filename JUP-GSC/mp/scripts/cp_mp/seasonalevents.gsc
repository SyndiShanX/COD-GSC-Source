/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\seasonalevents.gsc
***********************************************/

#using scripts\common\string;
#using scripts\common\utility;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace seasonalevents;

function private getdvarhash(dvarfieldname, dvarsuffix) {
  return hashcat(@ "hash_4489457facd70c28", dvarfieldname, "_", dvarsuffix);
}

function private oneindexed(i) {
  return i + 1;
}

function private function_b0de9e7b2bc4b4d5(currenttime, starttime, endtime) {
  return currenttime >= starttime && currenttime < endtime;
}

function private getcurrenttime() {
  systemtime = getsystemtime();
  currenttime = systemtime;

  if(level.var_c5f55642efa61b9c) {
    foreach(player in level.players) {
      timewarpoffsetseconds = player getplayerdata(level.var_5d69837cf4db0407, "timeWarpOffsetSeconds");

      if(!isDefined(timewarpoffsetseconds)) {
        timewarpoffsetseconds = 0;
      }

      playercurrenttime = systemtime + timewarpoffsetseconds;

      if(playercurrenttime > currenttime) {
        currenttime = playercurrenttime;
      }
    }
  }

  return currenttime;
}

function private isinwinbackdoublexpperiod() {
  var_4824d03fad5b5dcf = string_split(getDvar(@ "hash_b89d4a150e09a96b", ""), "|");

  if(var_4824d03fad5b5dcf.size != 2) {
    return false;
  }

  return function_b0de9e7b2bc4b4d5(getcurrenttime(), int(var_4824d03fad5b5dcf[0]), int(var_4824d03fad5b5dcf[1]));
}

function private loadeventdata() {
  if(isDefined(level.seasonalevents)) {
    return;
  }

  level.var_c5f55642efa61b9c = getdvarint(@ "hash_dec5cd614ac064d", 0) && !istrue(level.var_ec2fb549b15ad827) && !istrue(level.var_77907d733abe8b63);
  seasonalevents = [];
  var_fe50eb1b16b6a9dd = undefined;

  if(getdvarint(@ "hash_75ee328744735d6a", 0)) {
    var_fe50eb1b16b6a9dd = getscriptbundle(%"hash_3d06516d47cafe56");
  } else {
    var_fe50eb1b16b6a9dd = getscriptbundle(%"hash_1e670630bf9f818");
  }

  if(isDefined(var_fe50eb1b16b6a9dd)) {
    foreach(assetref in var_fe50eb1b16b6a9dd.events) {
      if(!isDefined(assetref.eventdata)) {
        continue;
      }

      bundlename = hashcat(%"hash_380349b348ddab0c", assetref.eventdata);
      bundledata = getscriptbundle(bundlename);

      if(!isDefined(bundledata)) {
        continue;
      }

      eventdisabled = getdvarint(getdvarhash("eventDisabled", bundledata.dvarsuffix));

      if(istrue(eventdisabled)) {
        continue;
      }

      starttime = getDvar(getdvarhash("startTime", bundledata.dvarsuffix), bundledata.starttime);
      endtime = getDvar(getdvarhash("endTime", bundledata.dvarsuffix), bundledata.endtime);
      starttime = ter_op(!string::function_46b9c00bb0535aa3(starttime), int(starttime), 0);
      endtime = ter_op(!string::function_46b9c00bb0535aa3(endtime), int(endtime), 1800000000);
      eventactive = function_b0de9e7b2bc4b4d5(getsystemtime(), starttime, endtime);
      featuredlootbonus = bundledata.featuredlootbonus;
      var_4ac7c4e9c961770f = getdvarhash("featuredLootBonus", bundledata.dvarsuffix);

      if(isdvardefined(var_4ac7c4e9c961770f)) {
        featuredlootbonus = getdvarint(var_4ac7c4e9c961770f);
      }

      var_56651c25de2e68b5 = [];

      for(i = 0; i < bundledata.featuredloot.size; i++) {
        featuredlootid = bundledata.featuredloot[i].featureditemlootid;
        featuredlootid = getDvar(getdvarhash("featuredItemLootID_" + oneindexed(i), bundledata.dvarsuffix), featuredlootid);
        featuredlootid = ter_op(!string::function_46b9c00bb0535aa3(featuredlootid), int(featuredlootid), 0);
        var_56651c25de2e68b5[var_56651c25de2e68b5.size] = featuredlootid;
      }

      pointscategories = [];

      for(i = 0; i < bundledata.var_5e42ba3bc94d58ff.var_c1d8c1d953c02016.pointscategories.size; i++) {
        key = bundledata.var_5e42ba3bc94d58ff.var_c1d8c1d953c02016.pointscategories[i].key;
        key = getDvar(getdvarhash("pointsCategoryKey_" + oneindexed(i), bundledata.dvarsuffix), key);
        pointscategories[pointscategories.size] = key;
      }

      var_9301e90474add74a = istrue(bundledata.template == "POINTS");
      var_e7ce9058ac932800 = istrue(bundledata.template == "HUNT");
      var_a60ed65bd4c825b7 = istrue(bundledata.var_a60ed65bd4c825b7);
      var_479fdb4d11a5e990 = [];
      var_a3d09160ba37a87b = 0;

      if(var_9301e90474add74a || var_a60ed65bd4c825b7) {
        var_a3d09160ba37a87b = 1;
        operatorskindisabled = getdvarint(getdvarhash("operatorSkinDisabled", bundledata.dvarsuffix));

        if(!istrue(operatorskindisabled)) {
          if(var_56651c25de2e68b5.size >= 1) {
            var_479fdb4d11a5e990 = var_56651c25de2e68b5;
          }
        }
      }

      eventdata = spawnStruct();
      eventdata.template = bundledata.template;
      eventdata.dvarsuffix = bundledata.dvarsuffix;
      eventdata.starttime = starttime;
      eventdata.endtime = endtime;
      eventdata.eventactive = eventactive;
      eventdata.var_56651c25de2e68b5 = var_56651c25de2e68b5;
      eventdata.pointscategories = pointscategories;
      eventdata.var_9301e90474add74a = var_9301e90474add74a;
      eventdata.var_e7ce9058ac932800 = var_e7ce9058ac932800;
      eventdata.var_a60ed65bd4c825b7 = var_a60ed65bd4c825b7;
      eventdata.var_a3d09160ba37a87b = var_a3d09160ba37a87b;
      eventdata.var_479fdb4d11a5e990 = var_479fdb4d11a5e990;
      eventdata.featuredlootbonus = featuredlootbonus;
      seasonalevents[seasonalevents.size] = eventdata;
    }
  }

  level.seasonalevents = seasonalevents;
}

function private function_7d7f33f970281be5() {
  assert(isDefined(level.seasonalevents));

  if(isDefined(level.currentevent)) {
    return;
  }

  currentevent = spawnStruct();
  currentevent.eventactive = 0;

  foreach(event in level.seasonalevents) {
    if(event.var_a3d09160ba37a87b && event.eventactive) {
      currentevent.eventactive = 1;
      currentevent.dvarsuffix = event.dvarsuffix;
      currentevent.var_9301e90474add74a = event.var_9301e90474add74a;
      currentevent.var_e7ce9058ac932800 = event.var_e7ce9058ac932800;
      currentevent.featuredlootbonus = event.featuredlootbonus;
      break;
    }
  }

  level.currentevent = currentevent;
}

function autoexec function_b9ac0d0975647ba() {
  registersharedfunc("seasonalevents", "init", &init);
  registersharedfunc("seasonalevents", "getFeaturedLootEventActive", &getfeaturedlooteventactive);
  registersharedfunc("seasonalevents", "hasFeaturedOperatorSkinEquipped", &hasfeaturedoperatorskinequipped);
  registersharedfunc("seasonalevents", "getFeaturedLootEventBonus", &getfeaturedlooteventbonus);
  registersharedfunc("seasonalevents", "featuredLootEventIsFieldRep", &featuredlooteventisfieldrep);
  registersharedfunc("seasonalevents", "isInWinbackDoubleXpPeriod", &isinwinbackdoublexpperiod);
  registersharedfunc("seasonalevents", "featuredLootEventIsHunt", &featuredlooteventishunt);
  registersharedfunc("seasonalevents", "isEventDvarNameEqualTo", &iseventdvarnameequalto);
}

function private init() {
  loadeventdata();
  function_7d7f33f970281be5();
}

function private getfeaturedlooteventactive() {
  assert(isDefined(level.currentevent));
  assert(isDefined(level.seasonalevents));

  if(level.var_c5f55642efa61b9c) {
    currenttime = getcurrenttime();

    foreach(event in level.seasonalevents) {
      if(event.var_a3d09160ba37a87b) {
        if(function_b0de9e7b2bc4b4d5(currenttime, event.starttime, event.endtime)) {
          return 1;
        }
      }
    }

    return 0;
  }

  return level.currentevent.eventactive;
}

function private featuredlooteventisfieldrep() {
  assert(isDefined(level.currentevent));
  assert(isDefined(level.seasonalevents));

  if(level.var_c5f55642efa61b9c) {
    currenttime = getcurrenttime();

    foreach(event in level.seasonalevents) {
      if(istrue(event.var_9301e90474add74a)) {
        return true;
      }
    }

    return false;
  }

  return istrue(level.currentevent.var_9301e90474add74a);
}

function private getfeaturedlooteventbonus() {
  assert(isDefined(level.currentevent));
  assert(isDefined(level.seasonalevents));

  if(level.var_c5f55642efa61b9c) {
    currenttime = getcurrenttime();

    foreach(event in level.seasonalevents) {
      if(event.var_a3d09160ba37a87b) {
        if(function_b0de9e7b2bc4b4d5(currenttime, event.starttime, event.endtime)) {
          return event.featuredlootbonus;
        }
      }
    }

    return 0;
  }

  return level.currentevent.featuredlootbonus;
}

function private hasfeaturedoperatorskinequipped() {
  assert(isDefined(level.seasonalevents));
  assert(isDefined(self) && isPlayer(self));
  player = self;
  var_650b47766000d829 = undefined;
  var_48c6afe9d308416c = undefined;
  var_1c6922a7d061f276 = undefined;

  if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinlootid)) {
    var_650b47766000d829 = player.operatorcustomization.skinlootid;
  }

  var_fd476bda738b0d05 = scripts\common\utility::ismp() && !isbrstylegametype() && getgametype() != "ob";

  if(var_fd476bda738b0d05) {
    var_f5cf62a90611b64d = player getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", 0);

    if(!string::function_46b9c00bb0535aa3(var_f5cf62a90611b64d) && scripts\cp_mp\operator::function_54240a5fc41f6590(var_f5cf62a90611b64d)) {
      var_48c6afe9d308416c = player getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_f5cf62a90611b64d, "skin");
    }

    var_d36f855c0bf1a4f7 = player getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", 1);

    if(!string::function_46b9c00bb0535aa3(var_d36f855c0bf1a4f7) && scripts\cp_mp\operator::function_54240a5fc41f6590(var_d36f855c0bf1a4f7)) {
      var_1c6922a7d061f276 = player getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_d36f855c0bf1a4f7, "skin");
    }
  }

  currenttime = getcurrenttime();

  foreach(event in level.seasonalevents) {
    if(event.var_a3d09160ba37a87b) {
      if(function_b0de9e7b2bc4b4d5(currenttime, event.starttime, event.endtime)) {
        foreach(operatorskinlootid in event.var_479fdb4d11a5e990) {
          if(operatorskinlootid != 0) {
            if(isDefined(var_650b47766000d829) && var_650b47766000d829 == operatorskinlootid) {
              return true;
            }

            if(isDefined(var_48c6afe9d308416c) && var_48c6afe9d308416c == operatorskinlootid) {
              return true;
            }

            if(isDefined(var_1c6922a7d061f276) && var_1c6922a7d061f276 == operatorskinlootid) {
              return true;
            }
          }
        }
      }
    }
  }

  return false;
}

function private featuredlooteventishunt() {
  assert(isDefined(level.currentevent));
  return istrue(level.currentevent.var_e7ce9058ac932800);
}

function private iseventdvarnameequalto(var_bda084803eae525e) {
  assert(isDefined(level.currentevent));
  assert(isDefined(level.currentevent.dvarsuffix));
  assert(isDefined(var_bda084803eae525e));

  if(level.currentevent.dvarsuffix == var_bda084803eae525e) {
    return 1;
  }

  return 0;
}