/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\group.gsc
***********************************************/

initgroup(var_0) {
  if(!isDefined(level.stealth.groupdata))
    level.stealth.groupdata = spawnStruct();

  var_1 = level.stealth.groupdata;

  if(!isDefined(var_1.groups))
    var_1.groups = [];

  var_2 = var_1.groups[var_0];

  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_1.groups[var_0] = var_2;
    var_2.name = var_0;
    var_2.members = [];
    var_2.pods = [];
  }

  level.stealth.groupdata notify(var_0);
}

addtogroup(var_0, var_1) {
  if(!isDefined(level.stealth.groupdata) || !isDefined(level.stealth.groupdata.groups) || !isDefined(level.stealth.groupdata.groups[var_0]))
    initgroup(var_0);

  var_2 = level.stealth.groupdata.groups[var_0];
  var_2.members[var_2.members.size] = var_1;
  var_2 thread group_waitfordeath(var_1);
}

group_waitfordeath(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_0 thread scripts\stealth\enemy::death_cleanup();
  group_removefrompod(self, var_0);
  var_1 = self.members.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(self.members[var_2] == var_0) {
      var_3 = self.members.size - 1;
      self.members[var_2] = self.members[var_3];
      self.members[var_3] = undefined;
      break;
    }
  }

  if(isDefined(var_0.stealth) && isDefined(var_0.stealth.cleardata)) {
    var_4 = var_0.stealth.cleardata.curregion;
    var_0 scripts\stealth\clear_regions::huntunassignfromregion(var_4);
  }
}

clearallgroups() {
  if(!isDefined(level.stealth.groupdata)) {
    return;
  }
  if(!isDefined(level.stealth.groupdata.groups)) {
    return;
  }
  level.stealth.groupdata.groups = undefined;
}

getgroup(var_0) {
  return level.stealth.groupdata.groups[var_0];
}

makenewpod(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.state = var_1;
  var_3.origin = var_2;
  var_3.members = [];
  var_3.parentgroup = var_0;
  var_0.pods[var_0.pods.size] = var_3;
  return var_3;
}

addtopod(var_0, var_1) {
  var_0.members[var_0.members.size] = var_1;
}

group_trytojoinexistingpod(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 65536;

  foreach(var_7 in var_0.pods) {
    if(isDefined(var_1) && var_1 == var_7) {
      continue;
    }
    if(var_7.state == var_2) {
      if(distancesquared(var_4, var_7.origin) < var_5) {
        group_removefrompod(var_0, var_3);
        addtopod(var_7, var_3);
        return var_7;
      }
    }
  }
}

group_assigntoinvestigatepod(var_0, var_1, var_2) {
  var_3 = 65536;
  var_4 = group_trytojoinexistingpod(var_0, undefined, 1, var_1, var_2);

  if(isDefined(var_4)) {
    if(!isDefined(var_4.investigateoriginguy))
      var_4 pod_updateinvestigateorigin(var_1, var_2);

    return 0;
  }

  group_removefrompod(var_0, var_1);
  var_5 = makenewpod(var_0, 1, var_2);
  addtopod(var_5, var_1);
  var_5.investigateoriginguy = var_1;
  group_generateinitialinvestigatepoints(var_5, var_1.script_stealthgroup, var_2);
  var_6 = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(var_6)) {
    var_5.volume = var_6;
    var_5.borigininvolume = ispointinvolume(var_2, var_6);
  }

  return 1;
}

group_assigntohuntpod(var_0, var_1, var_2, var_3) {
  group_removefrompod(var_0, var_1);

  foreach(var_5 in var_0.pods) {
    if(var_5.state == 2) {
      if(!isDefined(var_1.enemy) || !isDefined(var_5.target) || var_5.target == var_1.enemy) {
        addtopod(var_5, var_1);

        if(!isDefined(var_5.target)) {
          var_5.target = var_1.enemy;

          if(isDefined(var_2))
            var_5.origin = var_2;
        }

        return;
      }
    }
  }

  if(!isDefined(var_2))
    var_2 = var_1.origin;

  var_7 = makenewpod(var_0, 2, var_2);
  addtopod(var_7, var_1);
  var_7.target = var_1.enemy;
  group_generateinitialinvestigatepoints(var_7, var_1.script_stealthgroup, var_2);
  var_8 = level.stealth.hunt_volumes[self.script_stealthgroup];

  if(isDefined(var_8)) {
    var_7.volume = var_8;
    var_7.borigininvolume = ispointinvolume(var_2, var_8);
  }

  var_7.lastannouncetime = gettime();
  level thread pod_hunt_vo();
  var_7 thread pod_hunt_update();
  var_7 thread pod_hunt_delayednotify();
}

group_removefrompod(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = getgroup(var_1.script_stealthgroup);

  var_2 = group_findpod(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2.members.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_2.members[var_4] == var_1) {
      var_5 = var_2.members.size - 1;
      var_2.members[var_4] = var_2.members[var_5];
      var_2.members[var_5] = undefined;
      break;
    }
  }

  if(var_2.members.size == 0)
    var_2 pod_delete();
}

group_findsomeotherguytoinvestigate(var_0, var_1) {
  var_2 = 2304;
  var_3 = undefined;
  var_4 = 2359296;
  var_5 = [];

  foreach(var_7 in level.stealth.groupdata.groups) {
    if(var_7.name == var_1) {
      continue;
    }
    var_8 = level.stealth.investigate_volumes[var_7.name];

    if(isDefined(var_8) && !ispointinvolume(var_0, var_8)) {
      continue;
    }
    foreach(var_10 in var_7.pods) {
      if(var_10.state == 1 && distance2dsquared(var_10.origin, var_0) < var_2)
        return undefined;
    }

    foreach(var_13 in var_7.members) {
      if([[self.fnisinstealthidle]]()) {
        var_14 = distancesquared(var_13.origin, var_0);

        if(var_14 < var_4) {
          var_5[var_5.size] = var_13;

          if(var_5.size > 8) {
            break;
          }
        }
      }
    }
  }

  if(var_5.size > 0)
    var_3 = findclosestnonlospointwithinvolume(var_5, var_0);

  return var_3;
}

group_checkrequestbackupoutsideofvolume(var_0) {
  var_1 = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(var_1)) {
    if(!ispointinvolume(var_0.investigate_pos, var_1)) {
      var_2 = group_findsomeotherguytoinvestigate(var_0.investigate_pos, self.script_stealthgroup);

      if(isDefined(var_2)) {
        var_2 aieventlistenerevent("_encstr_AB130CB9AC56DA7D31C2C6B5D507", self, var_0.investigate_pos);
        return 1;
      }
    }
  }

  return 0;
}

group_eventinvestigate(var_0, var_1, var_2) {
  var_3 = getgroup(var_0);
  var_4 = group_assigntoinvestigatepod(var_3, var_1, var_2.investigate_pos);

  if(var_4)
    var_1 thread group_investigate_seekbackup(var_2);
}

group_investigate_seekbackup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82F114C36BFB6B51C6E6886EE8F1385D5928620188F7");
  waitframe();
  group_checkrequestbackupoutsideofvolume(var_0);
  waitframe();
  var_1 = getgroup(self.script_stealthgroup);
  var_2 = group_findpod(var_1, self);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2.members.size == 1) {
    var_3 = var_1.members.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_1.members[var_4];

      if(var_5.stealth.bsmstate == 0 && distancesquared(var_5.origin, self.origin) < 10000)
        var_5 glanceatentity(self);
    }
  }
}

group_generateinitialinvestigatepoints(var_0, var_1, var_2) {
  var_3 = getgroup(var_1);
  var_4 = 1000000;
  var_5 = [];
  var_6 = getnodearray("_encstr_BA640CEB25393F5969883B5310B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = scripts\engine\utility::getStructArray("_encstr_BA640CEB25393F5969883B5310B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  var_8 = 0;

  while(var_8 < var_6.size) {
    var_9 = 0;
    var_10 = var_6[var_8];

    if(distancesquared(var_10.origin, var_2) > var_4)
      var_9 = 1;
    else if(isDefined(var_10.script_stealthgroup)) {
      if(var_10.script_stealthgroup == var_1)
        var_5[var_5.size] = var_10;

      var_9 = 1;
    }

    if(var_9) {
      var_11 = var_6.size - 1;
      var_6[var_8] = var_6[var_11];
      var_6[var_11] = undefined;
      continue;
    }

    var_8++;
  }

  var_5 = sortbydistance(var_5, var_2);
  var_6 = sortbydistance(var_6, var_2);
  var_0.investigatepoints = scripts\engine\utility::array_combine(var_5, var_6);
}

group_findpod(var_0, var_1) {
  if(!isDefined(var_0.pods)) {
    return;
  }
  var_2 = var_0.pods.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_0.pods[var_3];
    var_5 = var_4.members.size;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      if(var_4.members[var_6] == var_1)
        return var_4;
    }
  }
}

pod_addusedpoint(var_0, var_1) {
  var_0.usedpoints[var_0.usedpoints.size] = var_1;
  var_0.usedpointsexpiry[var_0.usedpointsexpiry.size] = gettime() + 5000;
}

pod_cleanupusedpoints(var_0) {
  var_1 = gettime();
  var_2 = 0;

  while(var_2 < var_0.usedpointsexpiry.size) {
    if(var_1 >= var_0.usedpointsexpiry[var_2]) {
      var_3 = var_0.usedpointsexpiry.size - 1;
      var_0.usedpointsexpiry[var_2] = var_0.usedpointsexpiry[var_3];
      var_0.usedpointsexpiry[var_3] = undefined;
      var_0.usedpoints[var_2] = var_0.usedpoints[var_3];
      var_0.usedpoints[var_3] = undefined;
      continue;
    }

    var_2++;
  }
}

group_getinvestigatepoint(var_0, var_1) {
  var_2 = getgroup(var_0.script_stealthgroup);
  var_3 = group_findpod(var_2, var_0);

  if(!isDefined(var_3.usedpoints)) {
    var_3.usedpoints = [];
    var_3.usedpointsexpiry = [];
  }

  pod_cleanupusedpoints(var_3);
  var_4 = undefined;
  var_5 = [];

  foreach(var_7 in var_3.members) {
    var_8 = spawnStruct();
    var_8.guy = var_7;
    var_9 = var_7.origin - var_3.origin;
    var_8.angle = vectortoyaw(var_9);
    var_5[var_5.size] = var_8;

    if(var_7 == var_0)
      var_4 = var_8.angle;
  }

  var_11 = 0;

  foreach(var_13 in var_5) {
    if(var_13.angle < var_4)
      var_11++;
  }

  var_9 = var_0.origin - var_3.origin;
  var_15 = length(var_9);
  var_16 = 768;
  var_17 = 512;
  var_18 = 256;
  var_19 = -128;
  var_20 = 64;
  var_21 = 360 / var_5.size;
  var_22 = var_11 * var_21;

  foreach(var_24 in var_3.investigatepoints) {
    if(isDefined(var_24.lastinvestigatedtime)) {
      continue;
    }
    if(ispointinlane(var_24, var_3, var_22, var_21, var_15, var_18)) {
      var_24.lastinvestigatedtime = gettime();
      return var_24.origin;
    }
  }

  var_26 = var_15;

  if(var_15 > var_16)
    var_26 = max(60, randomfloatrange(var_15 - var_18 * 2, var_15 - var_18));
  else if(var_15 > var_17)
    var_26 = randomfloatrange(var_15 + var_19, var_15 + var_18);
  else
    var_26 = randomfloatrange(var_15, var_15 + var_18);

  var_27 = (0.5 + var_11 + randomfloatrange(-0.5, 0.5)) * var_21;
  var_28 = (cos(var_27), sin(var_27), 0);
  var_29 = var_3.origin + var_26 * var_28;
  var_30 = scripts\smartobjects\utility::getbestsmartobject(var_29, var_3.volume, 256);

  if(isDefined(var_30)) {
    self.asm.customdata.arrivalangles = var_30.angles;
    scripts\smartobjects\utility::setsmartobject(var_30);
    pod_addusedpoint(var_3, var_30.origin);
    return var_30.origin;
  }

  var_31 = var_3.usedpoints;
  var_31[var_31.size] = self.origin;

  if(isDefined(var_3.volume)) {
    var_32 = findclosestnonlospointwithinradius(var_3.volume, var_0.origin, var_29, var_31, 48);

    if(isDefined(var_32)) {
      pod_addusedpoint(var_3, var_32);
      return var_32;
    }
  } else if(var_0.goalradius > 64 && isDefined(var_0.scriptgoalpos)) {
    var_32 = findclosestlospointwithinradius(var_0.scriptgoalpos, var_0.goalradius, var_0.origin, var_29, var_31, 48);

    if(isDefined(var_32)) {
      pod_addusedpoint(var_3, var_32);
      return var_32;
    }
  }

  var_33 = getclosestpointonnavmesh(var_29, self);
  var_34 = undefined;

  if(isDefined(var_3.volume)) {
    var_34 = self findlastpointonpathwithinvolume(var_33, var_3.volume);

    if(!isDefined(var_34))
      var_34 = getrandomnavpoint(var_3.origin, var_20, self);
  }

  if(!isDefined(var_34))
    var_34 = getrandomnavpoint(var_33, var_20, self);

  if(!isDefined(var_34))
    var_34 = getclosestpointonnavmesh(var_3.origin, self);

  return var_34;
}

ispointinlane(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.origin - var_1.origin;
  var_7 = length(var_6);
  var_8 = vectortoyaw(var_6);
  var_9 = var_8 - var_2;

  if(var_9 >= 0 && var_9 <= var_3) {
    if(var_4 + var_5 > var_7)
      return 1;
  }

  return 0;
}

group_eventcoverblown(var_0, var_1, var_2) {
  var_3 = getgroup(var_0);
  var_3 thread group_delayedcoverblownpropagation(var_1);
  var_4 = group_assigntoinvestigatepod(var_3, var_1, var_2.investigate_pos);

  if(var_4)
    thread group_coverblown_seekbackup(var_3, var_2);
}

group_delayedcoverblownpropagation(var_0) {
  wait 2;

  if(isDefined(var_0) && isalive(var_0))
    self.bcoverhasbeenblown = 1;
}

group_coverblown_seekbackup(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82F114C36BFB6B51C6E6886EE8F1385D5928620188F7");
  waitframe();
  var_2 = group_findpod(var_0, self);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2.members.size == 1) {
    var_3 = var_0.members.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_0.members[var_4];

      if(var_5 != self && var_5.stealth.bsmstate == 0 && distancesquared(var_5.origin, self.origin) < 10000)
        var_5 glanceatentity(self);
    }
  }

  if(group_checkrequestbackupoutsideofvolume(var_1)) {
    return;
  }
  if(var_0.members.size > 1) {
    var_2 = group_findpod(var_0, self);

    if(isDefined(var_2) && var_2.state == 1 && var_2.members.size == 1 && (!isDefined(var_2.borigininvolume) || var_2.borigininvolume))
      thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_AB130CB9AC56DA7D31C2C6B5D507", 2.0, undefined, 1);
  }
}

pod_updateinvestigateorigin(var_0, var_1) {
  self.origin = var_1;

  if(!isDefined(self.needsupdate))
    self.needsupdate = [];

  self.investigateoriginguy = var_0;
  self.needsupdate[self.needsupdate.size] = var_0;
}

group_eventhunt(var_0, var_1) {
  var_2 = getgroup(var_0);
  var_3 = self.origin;
  var_4 = 0;

  if(isDefined(var_1.enemy)) {
    var_3 = var_1 lastknownpos(var_1.enemy);
    var_4 = var_1 lastknowntime(var_1.enemy);
    var_3 = getclosestpointonnavmesh(var_3, self);
  }

  group_removefrompod(var_2, var_1);
  group_assigntohuntpod(var_2, var_1, var_3, var_4);
}

group_updatepodhuntorigin(var_0, var_1) {
  var_2 = getgroup(var_0.script_stealthgroup);
  var_3 = group_findpod(var_2, var_0);
  var_3.origin = getclosestpointonnavmesh(var_1, var_0);
  var_3.borigininvestigated = undefined;

  if(isDefined(var_3.volume))
    var_3.borigininvolume = ispointinvolume(var_1, var_3.volume);

  return var_3.origin;
}

pod_hunt_update() {
  self endon("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");
  thread pod_hunt_hunker_update();

  if(isDefined(level.stealth.hunttimeout) && level.stealth.hunttimeout[self.script_stealthgroup]) {
    var_0 = level.stealth.hunttimeout[self.script_stealthgroup];
    wait(var_0);
    thread pod_settoidle();
  } else
    return;
}

pod_hunt_hunker_update() {
  self endon("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");

  for(;;) {
    var_0 = isDefined(self.volume) && !istrue(self.borigininvolume);

    if(var_0) {
      if(!isDefined(self.hunkerstarttime)) {
        self.hunkerstarttime = gettime();
        self.bhunkering = 1;
      } else if(istrue(self.bhunkering) && gettime() > self.hunkerstarttime + 20000)
        self.bhunkering = undefined;
    } else {
      self.bhunkering = undefined;
      self.hunkerstarttime = undefined;
    }

    waitframe();
  }
}

pod_hunt_delayednotify() {
  self endon("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");
  wait 3;
  var_0 = self.parentgroup;

  foreach(var_2 in var_0.members) {
    if(var_2[[var_2.fnisinstealthidle]]() || var_2[[var_2.fnisinstealthinvestigate]]()) {
      var_3 = 1;

      if(isDefined(var_2.stealth.funcs) && isDefined(var_2.stealth.funcs["_encstr_B1640C97D382CD18E451803B05DC"]))
        var_3 = var_2[[var_2.stealth.funcs["_encstr_B1640C97D382CD18E451803B05DC"]]]();

      if(var_3)
        var_2 scripts\stealth\enemy::bt_set_stealth_state("_encstr_9ACC05B4156DF3", undefined);
    }
  }
}

pod_hunt_vo() {
  if(!isDefined(level.bcs_stealthhuntthink))
    level.bcs_stealthhuntthink = 1;
  else
    return;

  var_0 = undefined;

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.stealth.groupdata.groups) {
      if(isDefined(var_3.pods)) {
        foreach(var_5 in var_3.pods) {
          if(isDefined(var_5.state) && var_5.state == 2) {
            foreach(var_7 in var_5.members)
            var_1 = scripts\engine\utility::array_add(var_1, var_7);
          }
        }
      }
    }

    if(var_1.size < 1) {
      break;
    }

    if(var_1.size > 1) {
      var_1 = sortbydistance(var_1, level.player.origin);
      var_1[0].battlechatter.customgroup = var_1;
      var_1[0] thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_9ACC05B4156DF3", "_encstr_AC2C0C3ACA85B6B4DC17D5B44EE5", undefined, undefined, 1);
      var_11 = var_1[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_11);
      wait(randomfloatrange(2, 2.5));
      var_1 = scripts\engine\utility::array_removedead_or_dying(var_1);
      var_1 = sortbydistance(var_1, level.player.origin);
      var_7 = undefined;

      switch (var_1.size) {
        case 0:
          break;
        case 3:
        case 2:
        case 1:
          var_7 = var_1[randomint(var_1.size)];
          break;
        default:
          var_7 = var_1[randomint(3)];
          break;
      }

      if(!isDefined(var_7)) {
        break;
      }

      var_1 = scripts\engine\utility::array_add(var_1, var_11);
      var_7.battlechatter.customgroup = var_1;
      var_7 thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_9ACC05B4156DF3", "_encstr_85030B637B9B1DBE9BA5B33447", undefined, undefined, 1);
    } else {
      var_7 = var_1[0];

      if(!isDefined(var_0)) {
        var_0 = 1;
        var_7 thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_9ACC05B4156DF3", "_encstr_8B0A0BCCA54EE6A3EBB17B9B47");
      } else
        var_7 thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_9ACC05B4156DF3", "_encstr_85030B637B9B1DBE9BA5B33447");
    }

    wait(randomintrange(10, 15));
  }

  level.bcs_stealthhuntthink = undefined;
}

group_assigntocombatpod(var_0, var_1) {
  group_removefrompod(var_0, var_1);

  foreach(var_3 in var_0.pods) {
    if(var_3.state == 3) {
      addtopod(var_3, var_1);
      return 0;
    }
  }

  var_5 = makenewpod(var_0, 3, undefined);
  addtopod(var_5, var_1);
  var_5 thread pod_combat_update_checklosttarget();
  var_5 thread pod_combat_periodicping();
  return 1;
}

group_anyoneincombat(var_0) {
  var_1 = getgroup(var_0);

  foreach(var_3 in var_1.pods) {
    if(var_3.state == 3)
      return 1;
  }

  return 0;
}

group_eventcombat(var_0, var_1, var_2) {
  var_3 = getgroup(var_0);
  var_4 = undefined;

  if(isDefined(var_2))
    var_4 = var_2.origin;

  var_5 = group_findpod(var_3, var_1);
  group_assigntocombatpod(var_3, var_1);
  var_3 thread group_delayedcombatpropagation(2.0, var_1, var_2, var_4);
  var_3 thread group_delayedcombatpropagationfromhunt(3.0, var_1, var_2, var_4);
}

group_delayedcombatpropagationfromhunt(var_0, var_1, var_2, var_3) {
  var_1 endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(!isDefined(var_1) || !isalive(var_1) || istrue(var_1.in_melee_death)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  var_4 = 65536;

  foreach(var_6 in level.stealth.groupdata.groups) {
    foreach(var_8 in var_6.members) {
      if(var_1 == var_8) {
        continue;
      }
      var_9 = group_findpod(var_6, var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      if(var_9.state == 1 || var_9.state == 2 && isDefined(var_9.target) && var_9.target == var_2) {
        if(var_1.script_stealthgroup == var_8.script_stealthgroup || distancesquared(var_1.origin, var_8.origin) < var_4) {
          var_8 getenemyinfo(var_2);
          var_8 aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_2, var_3);
        }
      }
    }
  }
}

group_delayedcombatpropagation(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_4 = 16384;

  if(!isDefined(var_1) || !isalive(var_1) || istrue(var_1.in_melee_death)) {
    return;
  }
  self.bcoverhasbeenblown = 1;
  level notify("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9");

  foreach(var_6 in level.stealth.groupdata.groups) {
    foreach(var_8 in var_6.members) {
      if(var_1 == var_8) {
        continue;
      }
      var_9 = 0;
      var_10 = 0;
      var_11 = group_findpod(var_6, var_8);

      if(isDefined(var_11) && var_11.state == 3) {
        continue;
      }
      if(isDefined(var_2)) {
        if(var_8 cansee(var_2)) {
          var_9 = 1;
          var_10 = 1;
        }
      }

      if(!var_9 && var_8 cansee(var_1))
        var_9 = 1;

      if(!var_9 && distancesquared(var_8.origin, var_1.origin) < var_4 && var_8 hastacvis(var_1)) {
        var_9 = 1;

        if(isDefined(var_2))
          var_10 = 1;
      }

      if(var_10)
        var_8 getenemyinfo(var_2);

      if(var_9) {
        if(isDefined(var_2)) {
          var_8 aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_2, var_3);
          continue;
        }

        var_8 aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_1, var_1.origin);
      }
    }
  }
}

pod_settocombat(var_0, var_1) {
  var_2 = self.members;

  foreach(var_4 in var_2) {
    if(var_0)
      var_4 getenemyinfo(var_1);

    var_4 aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_1, var_1.origin);
  }
}

groups_combat_checklosttarget() {
  level notify("_encstr_AB032441765E2885FA3F87B5E7335781EB4D08F99EAC114E92BF878FC37A1E6094A653D107F4");
  level endon("_encstr_AB032441765E2885FA3F87B5E7335781EB4D08F99EAC114E92BF878FC37A1E6094A653D107F4");
  waitframe();

  while(!isDefined(level.stealth.bstayincombatoncealerted)) {
    var_0 = [];
    var_1 = 1;

    foreach(var_3 in level.stealth.groupdata.groups) {
      foreach(var_5 in var_3.pods) {
        if(var_5.state == 3) {
          var_0[var_0.size] = var_5;

          if(!isDefined(var_5.bchecklosttarget) || !var_5 pod_haslostenemy()) {
            var_1 = 0;
            break;
          }
        }
      }

      if(!var_1) {
        break;
      }
    }

    if(var_1) {
      foreach(var_9 in var_0)
      var_9 pod_settohunt();

      return;
    }

    wait 2;
  }
}

pod_combat_update_checklosttarget() {
  self endon("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");
  wait 5;

  if(!pod_haslostenemy() && isDefined(level.stealth.funcs) && isDefined(level.stealth.funcs["_encstr_A7630CD816D8D8F5130B1BB65783"]))
    self thread[[level.stealth.funcs["_encstr_A7630CD816D8D8F5130B1BB65783"]]]();

  if(isDefined(level.stealth.bstayincombatoncealerted)) {
    return;
  }
  self.bchecklosttarget = 1;
  level thread groups_combat_checklosttarget();
}

pod_haslostenemy() {
  var_0 = 10000;
  var_1 = 15000;
  var_2 = 50625;
  var_3 = gettime();
  var_4 = undefined;

  foreach(var_6 in self.members) {
    if(isDefined(var_6.stealth.funcs) && isDefined(var_6.stealth.funcs["_encstr_AC600FC80FFB6E598AAA55C807B2839049"]))
      return var_6[[var_6.stealth.funcs["_encstr_AC600FC80FFB6E598AAA55C807B2839049"]]]();

    var_7 = var_6.enemy;

    if(isDefined(var_7) && issentient(var_7) && isalive(var_7)) {
      if(var_7.team != "_encstr_9A8507BA4040188D08")
        return 0;

      var_8 = var_6 lastknowntime(var_7);

      if(var_3 < var_8 + var_0)
        return 0;

      var_9 = var_6 lastknownpos(var_7);

      if(var_8 > 0 && distancesquared(var_7.origin, var_9) < var_2)
        return 0;

      if(var_3 < var_8 + var_1 && var_7 hastacvis(var_9))
        return 0;

      if(isDefined(self.benemyinlowcover))
        return 0;

      continue;
    }

    if(!isDefined(var_6.enemy) && var_6 scripts\engine\utility::ent_flag_exist("_encstr_88160C37E07EEC1A6B08B7EE861F") && var_6 scripts\engine\utility::ent_flag("_encstr_88160C37E07EEC1A6B08B7EE861F") && var_3 - var_6.lastenemysighttime < var_0)
      return 0;
  }

  return 1;
}

pod_isclosetoanymembers(var_0, var_1, var_2) {
  if(!var_2)
    var_2 = 0;

  var_3 = var_1 * var_1;

  foreach(var_5 in self.members) {
    if(distancesquared(var_0.origin, var_5.origin) > var_3) {
      continue;
    }
    if(var_2 && !var_0 hastacvis(var_5)) {
      continue;
    }
    return 1;
  }

  return 0;
}

pod_combat_periodicping() {
  self endon("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");
  var_0 = 1;
  var_1 = 384;
  wait(var_0);

  for(;;) {
    foreach(var_3 in level.stealth.groupdata.groups) {
      foreach(var_5 in var_3.members) {
        if(var_5.stealth.bsmstate == 3 || var_5.stealth.bsmstate == 2) {
          continue;
        }
        if(pod_isclosetoanymembers(var_5, var_1, 1))
          var_5 aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_5, var_5.origin);
      }
    }

    wait(var_0);
  }
}

pod_settohunt() {
  var_0 = self.members;

  foreach(var_2 in var_0) {
    var_3 = 1;

    if(isDefined(var_2.stealth.funcs) && isDefined(var_2.stealth.funcs["_encstr_B1640C97D382CD18E451803B05DC"]))
      var_3 = var_2[[var_2.stealth.funcs["_encstr_B1640C97D382CD18E451803B05DC"]]]();

    if(!var_3) {
      var_2 scripts\stealth\enemy::bt_set_stealth_state("_encstr_A7C5056BD931D1", undefined);
      continue;
    }

    var_2 scripts\stealth\enemy::bt_set_stealth_state("_encstr_9ACC05B4156DF3", undefined);
  }
}

pod_settoidle() {
  foreach(var_1 in self.members)
  var_1 aieventlistenerevent("_encstr_88F20627959BCAE8", var_1, var_1.origin);
}

pod_isleader(var_0) {
  var_1 = getgroup(var_0.script_stealthgroup);
  var_2 = group_findpod(var_1, var_0);

  if(!isDefined(var_2))
    return 0;

  return var_2.members[0] == var_0;
}

pod_getclosestguy(var_0) {
  var_1 = undefined;
  var_2 = 99999999;

  foreach(var_4 in self.members) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

pod_delete() {
  self notify("_encstr_BDB00D37E816A32B7DD80D0BDCECAC");
  var_0 = self.parentgroup;
  var_1 = var_0.pods.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(var_0.pods[var_2] == self) {
      var_3 = var_0.pods.size - 1;
      var_0.pods[var_2] = var_0.pods[var_3];
      var_0.pods[var_3] = undefined;
      break;
    }
  }
}