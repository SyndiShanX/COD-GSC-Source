/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\group.gsc
***********************************************/

function initgroup(var0) {
  if(!isDefined(level.stealth.groupdata)) {
    level.stealth.groupdata = spawnStruct();
  }

  var1 = level.stealth.groupdata;

  if(!isDefined(var1.groups)) {
    var1.groups = [];
  }

  var2 = var1.groups[var0];

  if(!isDefined(var2)) {
    var2 = spawnStruct();
    var1.groups[var0] = var2;
    var2.name = var0;
    var2.members = [];
    var2.pods = [];
  }

  level.stealth.groupdata notify(var0);
}

function addtogroup(var0, var1) {
  if(!isDefined(level.stealth.groupdata) || !isDefined(level.stealth.groupdata.groups) || !isDefined(level.stealth.groupdata.groups[var0])) {
    initgroup(var0);
  }

  var2 = level.stealth.groupdata.groups[var0];
  var2.members[var2.members.size] = var1;
  thread group_waitfordeath(var2);
}

function group_waitfordeath(var0) {
  var0 waittill("death");
  var0 thread scripts\stealth\enemy::death_cleanup();
  group_removefrompod(self, var0);
  var1 = self.members.size;

  for(var2 = 0; var2 < var1; var2++) {
    if(self.members[var2] == var0) {
      var3 = self.members.size - 1;
      self.members[var2] = self.members[var3];
      self.members[var3] = undefined;
      break;
    }
  }

  if(isDefined(var0.stealth) && isDefined(var0.stealth.cleardata)) {
    var4 = var0.stealth.cleardata.curregion;
    var0 scripts\stealth\clear_regions::huntunassignfromregion(var4);
    return;
  }
}

function clearallgroups() {
  if(!isDefined(level.stealth.groupdata)) {
    return;
  }

  if(!isDefined(level.stealth.groupdata.groups)) {
    return;
  }

  level.stealth.groupdata.groups = undefined;
}

function getgroup(var0) {
  return level.stealth.groupdata.groups[var0];
}

function makenewpod(var0, var1, var2) {
  var3 = spawnStruct();
  var3.state = var1;
  var3.origin = var2;
  var3.members = [];
  var3.parentgroup = var0;
  var0.pods[var0.pods.size] = var3;
  return var3;
}

function addtopod(var0, var1) {
  var0.members[var0.members.size] = var1;
}

function group_trytojoinexistingpod(var0, var1, var2, var3, var4) {
  var5 = 65536;

  foreach(var7 in var0.pods) {
    if(isDefined(var1) && var1 == var7) {
      continue;
    }

    if(var7.state == var2) {
      if(distancesquared(var4, var7.origin) < var5) {
        group_removefrompod(var0, var3);
        addtopod(var7, var3);
        return var7;
      }
    }
  }
}

function group_assigntoinvestigatepod(var0, var1, var2) {
  var3 = 65536;
  var4 = group_trytojoinexistingpod(var0, undefined, 1, var1, var2);

  if(isDefined(var4)) {
    if(!isDefined(var4.investigateoriginguy)) {
      pod_updateinvestigateorigin(var4, var1, var2);
    }

    return false;
  }

  group_removefrompod(var0, var1);
  var5 = makenewpod(var0, 1, var2);
  addtopod(var5, var1);
  var5.investigateoriginguy = var1;
  group_generateinitialinvestigatepoints(var5, var1.script_stealthgroup, var2);
  var6 = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(var6)) {
    var5.volume = var6;
    var5.borigininvolume = ispointinvolume(var2, var6);
  }

  return true;
}

function group_assigntohuntpod(var0, var1, var2, var3) {
  group_removefrompod(var0, var1);

  foreach(var5 in var0.pods) {
    if(var5.state == 2) {
      if(!isDefined(var1.enemy) || !isDefined(var5.target) || var5.target == var1.enemy) {
        addtopod(var5, var1);

        if(!isDefined(var5.target)) {
          var5.target = var1.enemy;

          if(isDefined(var2)) {
            var5.origin = var2;
          }
        }

        return;
      }
    }
  }

  if(!isDefined(var2)) {
    var2 = var1.origin;
  }

  var7 = makenewpod(var0, 2, var2);
  addtopod(var7, var1);
  var7.target = var1.enemy;
  group_generateinitialinvestigatepoints(var7, var1.script_stealthgroup, var2);
  var8 = level.stealth.hunt_volumes[self.script_stealthgroup];

  if(isDefined(var8)) {
    var7.volume = var8;
    var7.borigininvolume = ispointinvolume(var2, var8);
  }

  var7.lastannouncetime = gettime();
  thread pod_hunt_vo();
  thread pod_hunt_update();
  thread pod_hunt_delayednotify();
}

function group_removefrompod(var0, var1) {
  if(!isDefined(var0)) {
    var0 = getgroup(var1.script_stealthgroup);
  }

  var2 = group_findpod(var0, var1);

  if(!isDefined(var2)) {
    return;
  }

  var3 = var2.members.size;

  for(var4 = 0; var4 < var3; var4++) {
    if(var2.members[var4] == var1) {
      var5 = var2.members.size - 1;
      var2.members[var4] = var2.members[var5];
      var2.members[var5] = undefined;
      break;
    }
  }

  if(var2.members.size == 0) {
    pod_delete(var2);
    return;
  }
}

function group_findsomeotherguytoinvestigate(var0, var1) {
  var2 = 2304;
  var3 = undefined;
  var4 = 2359296;
  var5 = [];

  foreach(var7 in level.stealth.groupdata.groups) {
    if(var7.name == var1) {
      continue;
    }

    var8 = level.stealth.investigate_volumes[var7.name];

    if(isDefined(var8) && !ispointinvolume(var0, var8)) {
      continue;
    }

    foreach(var11, var10 in var7.pods) {
      if(var10.state == 1 && distance2dsquared(var10.origin, var0) < var2) {
        return undefined;
      }
    }

    foreach(var13 in var7.members) {
      if([[self.fnisinstealthidle]]()) {
        var14 = distancesquared(var13.origin, var0);

        if(var14 < var4) {
          var5 = var13;

          if(var5.size > 8) {
            break;
          }
        }
      }
    }

    var11 = undefined;
    var13 = undefined;
  }

  var5 = undefined;
  var15 = undefined;

  if(var4.size > 0) {
    var2 = findclosestnonlospointwithinvolume(var4, < error > );
  }

  return var2;
}

function group_checkrequestbackupoutsideofvolume(var0) {
  var1 = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(var1)) {
    if(!ispointinvolume(var0.investigate_pos, var1)) {
      var2 = group_findsomeotherguytoinvestigate(var0.investigate_pos, self.script_stealthgroup);

      if(isDefined(var2)) {
        var2 aieventlistenerevent("seek_backup", self, var0.investigate_pos);
        return true;
      }
    }
  }

  return false;
}

function group_eventinvestigate(var0, var1, var2) {
  var3 = getgroup(var0);
  var4 = group_assigntoinvestigatepod(var3, var1, var2.investigate_pos);

  if(var4) {
    thread group_investigate_seekbackup(var1);
    return;
  }
}

function group_investigate_seekbackup(var0) {
  self endon("death");
  self endon("start_context_melee");
  waitframe();
  group_checkrequestbackupoutsideofvolume(var0);
  waitframe();
  var1 = getgroup(self.script_stealthgroup);
  var2 = group_findpod(var1, self);

  if(!isDefined(var2)) {
    return;
  }

  if(var2.members.size == 1) {
    var3 = var1.members.size;

    for(var4 = 0; var4 < var3; var4++) {
      var5 = var1.members[var4];

      if(var5.stealth.bsmstate == 0 && distancesquared(var5.origin, self.origin) < 10000) {
        var5 glanceatentity(self);
      }
    }

    return;
  }
}

function group_generateinitialinvestigatepoints(var0, var1, var2) {
  var3 = getgroup(var1);
  var4 = 1000000;
  var5 = [];
  var6 = getnodearray("seek_patrol", "targetname");
  var7 = scripts\engine\utility::getStructArray("seek_patrol", "targetname");
  var6 = scripts\engine\utility::array_combine(var6, var7);

  for(var8 = 0; var8 < var6.size; var8++) {
    var9 = 0;
    var10 = var6[var8];

    if(distancesquared(var10.origin, var2) > var4) {
      var9 = 1;
    } else if(isDefined(var10.script_stealthgroup)) {
      if(var10.script_stealthgroup == var1) {
        var5 = var10;
      }

      var9 = 1;
    }

    if(var9) {
      var11 = var6.size - 1;
      var6 = var6[var11];
      var6[var11] = undefined;
      continue;
    }
  }

  var5 = sortbydistance(var5, var2);
  var6 = sortbydistance(var6, var2);
  var0.investigatepoints = scripts\engine\utility::array_combine(var5, var6);
}

function group_findpod(var0, var1) {
  if(!isDefined(var0.pods)) {
    return;
  }

  var2 = var0.pods.size;

  for(var3 = 0; var3 < var2; var3++) {
    var4 = var0.pods[var3];
    var5 = var4.members.size;

    for(var6 = 0; var6 < var5; var6++) {
      if(var4.members[var6] == var1) {
        return var4;
      }
    }
  }
}

function pod_addusedpoint(var0, var1) {
  var0.usedpoints[var0.usedpoints.size] = var1;
  var0.usedpointsexpiry[var0.usedpointsexpiry.size] = gettime() + 5000;
}

function pod_cleanupusedpoints(var0) {
  var1 = gettime();

  for(var2 = 0; var2 < var0.usedpointsexpiry.size; var2++) {
    if(var1 >= var0.usedpointsexpiry[var2]) {
      var3 = var0.usedpointsexpiry.size - 1;
      var0.usedpointsexpiry[var2] = var0.usedpointsexpiry[var3];
      var0.usedpointsexpiry[var3] = undefined;
      var0.usedpoints[var2] = var0.usedpoints[var3];
      var0.usedpoints[var3] = undefined;
      continue;
    }
  }
}

function group_getinvestigatepoint(var0, var1) {
  var2 = getgroup(var0.script_stealthgroup);
  var3 = group_findpod(var2, var0);

  if(!isDefined(var3.usedpoints)) {
    var3.usedpoints = [];
    var3.usedpointsexpiry = [];
  }

  pod_cleanupusedpoints(var3);
  var4 = undefined;
  var5 = [];

  foreach(var7 in var3.members) {
    var8 = spawnStruct();
    var8.guy = var7;
    var9 = var7.origin - var3.origin;
    var8.angle = vectortoyaw(var9);
    var5 = var8;

    if(var7 == var0) {
      var4 = var8.angle;
    }
  }

  var11 = 0;

  foreach(var13 in var5) {
    if(var13.angle < var4) {
      var11++;
    }
  }

  var9 = var0.origin - var3.origin;
  var15 = length(var9);
  var16 = 768;
  var17 = 512;
  var18 = 256;
  var19 = -128;
  var20 = 64;
  var21 = 360 / var5.size;
  var22 = var11 * var21;

  foreach(var24 in var3.investigatepoints) {
    if(isDefined(var24.lastinvestigatedtime)) {
      continue;
    }

    if(ispointinlane(var24, var3, var22, var21, var15, var18)) {
      var24.lastinvestigatedtime = gettime();
      return var24.origin;
    }
  }

  var26 = var15;

  if(var15 > var16) {
    var26 = max(60, randomfloatrange(var15 - var18 * 2, var15 - var18));
  } else if(var15 > var17) {
    var26 = randomfloatrange(var15 + var19, var15 + var18);
  } else {
    var26 = randomfloatrange(var15, var15 + var18);
  }

  var27 = (0.5 + var11 + randomfloatrange(-0.5, 0.5)) * var21;
  var28 = (cos(var27), sin(var27), 0);
  var29 = var3.origin + var26 * var28;
  var30 = scripts\smartobjects\utility::getbestsmartobject(var29, var3.volume, 256);

  if(isDefined(var30)) {
    self.asm.customdata.arrivalangles = var30.angles;
    scripts\smartobjects\utility::setsmartobject(var30);
    pod_addusedpoint(var3, var30.origin);
    return var30.origin;
  }

  var31 = var3.usedpoints;
  GscBinSkip0(0x2e, var31.size, self.origin);
}

function ispointinlane(var0, var1, var2, var3, var4, var5) {
  var6 = var0.origin - var1.origin;
  var7 = length(var6);
  var8 = vectortoyaw(var6);
  var9 = var8 - var2;

  if(var9 >= 0 && var9 <= var3) {
    if(var4 + var5 > var7) {
      return true;
    }
  }

  return false;
}

function group_eventcoverblown(var0, var1, var2) {
  var3 = getgroup(var0);
  thread group_delayedcoverblownpropagation(var3);
  var4 = group_assigntoinvestigatepod(var3, var1, var2.investigate_pos);

  if(var4) {
    thread group_coverblown_seekbackup(var3, var2);
    return;
  }
}

function group_delayedcoverblownpropagation(var0) {
  wait 2;

  if(isDefined(var0) && isalive(var0)) {
    self.bcoverhasbeenblown = 1;
    return;
  }
}

function group_coverblown_seekbackup(var0, var1) {
  self endon("death");
  self endon("start_context_melee");
  waitframe();
  var2 = group_findpod(var0, self);

  if(!isDefined(var2)) {
    return;
  }

  if(var2.members.size == 1) {
    var3 = var0.members.size;

    for(var4 = 0; var4 < var3; var4++) {
      var5 = var0.members[var4];

      if(var5 != self && var5.stealth.bsmstate == 0 && distancesquared(var5.origin, self.origin) < 10000) {
        var5 glanceatentity(self);
      }
    }
  }

  if(group_checkrequestbackupoutsideofvolume(var1)) {
    return;
  }

  if(var0.members.size > 1) {
    var2 = group_findpod(var0, self);

    if(isDefined(var2) && var2.state == 1 && var2.members.size == 1 && (!isDefined(var2.borigininvolume) || var2.borigininvolume)) {
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "seek_backup", 2, undefined, 1);
      return;
    }

    return;
  }
}

function pod_updateinvestigateorigin(var0, var1) {
  self.origin = var1;

  if(!isDefined(self.needsupdate)) {
    self.needsupdate = [];
  }

  self.investigateoriginguy = var0;
  self.needsupdate[self.needsupdate.size] = var0;
}

function group_eventhunt(var0, var1) {
  var2 = getgroup(var0);
  var3 = self.origin;
  var4 = 0;

  if(isDefined(var1.enemy)) {
    var3 = var1 lastknownpos(var1.enemy);
    var4 = var1 lastknowntime(var1.enemy);
    var3 = getclosestpointonnavmesh(var3, self);
  }

  group_removefrompod(var2, var1);
  group_assigntohuntpod(var2, var1, var3, var4);
}

function group_updatepodhuntorigin(var0, var1) {
  var2 = getgroup(var0.script_stealthgroup);
  var3 = group_findpod(var2, var0);
  var3.origin = getclosestpointonnavmesh(var1, var0);
  var3.borigininvestigated = undefined;

  if(isDefined(var3.volume)) {
    var3.borigininvolume = ispointinvolume(var1, var3.volume);
  }

  return var3.origin;
}

function pod_hunt_update() {
  self endon("state_change");
  thread pod_hunt_hunker_update();

  if(isDefined(level.stealth.hunttimeout) && level.stealth.hunttimeout[self.script_stealthgroup]) {
    var0 = level.stealth.hunttimeout[self.script_stealthgroup];
    wait var0;
    thread pod_settoidle();
    return;
  }
}

function pod_hunt_hunker_update() {
  self endon("state_change");

  for(;;) {
    var0 = isDefined(self.volume) && !istrue(self.borigininvolume);

    if(var0) {
      if(!isDefined(self.hunkerstarttime)) {
        self.hunkerstarttime = gettime();
        self.bhunkering = 1;
      } else if(istrue(self.bhunkering) && gettime() > self.hunkerstarttime + 20000) {
        self.bhunkering = undefined;
      }
    } else {
      self.bhunkering = undefined;
      self.hunkerstarttime = undefined;
    }

    waitframe();
  }
}

function pod_hunt_delayednotify() {
  self endon("state_change");
  wait 3;
  var0 = self.parentgroup;

  foreach(var2 in var0.members) {
    if(var2[[var2.fnisinstealthidle]]() || var2[[var2.fnisinstealthinvestigate]]()) {
      var3 = 1;

      if(isDefined(var2.stealth.funcs) && isDefined(var2.stealth.funcs["should_hunt"])) {
        var3 = var2[[var2.stealth.funcs["should_hunt"]]]();
      }

      if(var3) {
        var2 scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
      }
    }
  }
}

function pod_hunt_vo() {
  if(!isDefined(level.bcs_stealthhuntthink)) {
    level.bcs_stealthhuntthink = 1;
  } else {
    return;
  }

  var0 = undefined;

  for(;;) {
    var1 = [];

    foreach(var10, var3 in level.stealth.groupdata.groups) {
      if(isDefined(var3.pods)) {
        foreach(var5 in var3.pods) {
          if(isDefined(var5.state) && var5.state == 2) {
            foreach(var7 in var5.members) {
              var1 = scripts\engine\utility::array_add(var1, var7);
            }
          }
        }
      }
    }

    if(var1.size < 1) {
      break;
    }

    if(var1.size > 1) {
      var1 = sortbydistance(var1, level.player.origin);
      var1[0].battlechatter.customgroup = var1;
      var1[0] thread scripts\stealth\utility::addeventplaybcs("stealth", "hunt", "teaminquiry", undefined, undefined, 1);
      var11 = var1[0];
      var1 = scripts\engine\utility::array_remove(var1, var11);
      wait randomfloatrange(2, 2.5);
      var1 = scripts\engine\utility::array_removedead_or_dying(var1);
      var1 = sortbydistance(var1, level.player.origin);
      var7 = undefined;

      switch (var1.size) {
        case 0:
          break;
        case 3:
        case 2:
        case 1:
          var7 = var1[randomint(var1.size)];
          break;
        default:
          var7 = var1[randomint(3)];
          break;
      }

      if(!isDefined(var7)) {
        break;
      }

      var0 = scripts\engine\utility::array_add(var0, var7);
      var10.battlechatter.customgroup = var0;
      var10 thread scripts\stealth\utility::addeventplaybcs("stealth", "hunt", "lost_sight", undefined, undefined, 1);
    } else {
      var10 = var0[0];

      if(!isDefined( < error > )) {
        <
        error > = 1;
        var10 thread scripts\stealth\utility::addeventplaybcs("stealth", "hunt", "first_lost");
      } else {
        var10 thread scripts\stealth\utility::addeventplaybcs("stealth", "hunt", "lost_sight");
      }
    }

    wait randomintrange(10, 15);
  }

  level.bcs_stealthhuntthink = undefined;
}

function group_assigntocombatpod(var0, var1) {
  group_removefrompod(var0, var1);

  foreach(var3 in var0.pods) {
    if(var3.state == 3) {
      addtopod(var3, var1);
      return false;
    }
  }

  var5 = makenewpod(var0, 3, undefined);
  addtopod(var5, var1);
  thread pod_combat_update_checklosttarget();
  thread pod_combat_periodicping();
  return true;
}

function group_anyoneincombat(var0) {
  var1 = getgroup(var0);

  foreach(var3 in var1.pods) {
    if(var3.state == 3) {
      return true;
    }
  }

  return false;
}

function group_eventcombat(var0, var1, var2) {
  var3 = getgroup(var0);
  var4 = undefined;

  if(isDefined(var2)) {
    var4 = var2.origin;
  }

  var5 = group_findpod(var3, var1);
  group_assigntocombatpod(var3, var1);
  thread group_delayedcombatpropagation(var3, 2, var1, var2);
  thread group_delayedcombatpropagationfromhunt(var3, 3, var1, var2);
}

function group_delayedcombatpropagationfromhunt(var0, var1, var2, var3) {
  var1 endon("death");
  wait var0;

  if(!isDefined(var1) || !isalive(var1) || istrue(var1.in_melee_death)) {
    return;
  }

  if(!isDefined(var2)) {
    return;
  }

  var4 = 65536;

  foreach(var6 in level.stealth.groupdata.groups) {
    foreach(var8 in var6.members) {
      if(var1 == var8) {
        continue;
      }

      var9 = group_findpod(var6, var8);

      if(!isDefined(var9)) {
        continue;
      }

      if(var9.state == 1 || var9.state == 2 && isDefined(var9.target) && var9.target == var2) {
        if(var1.script_stealthgroup == var8.script_stealthgroup || distancesquared(var1.origin, var8.origin) < var4) {
          var8 getenemyinfo(var2);
          var8 aieventlistenerevent("combat", var2, var3);
        }
      }
    }
  }
}

function group_delayedcombatpropagation(var0, var1, var2, var3) {
  wait var0;
  var4 = 16384;

  if(!isDefined(var1) || !isalive(var1) || istrue(var1.in_melee_death)) {
    return;
  }

  self.bcoverhasbeenblown = 1;
  level notify("cover_blown");

  foreach(var6 in level.stealth.groupdata.groups) {
    foreach(var8 in var6.members) {
      if(var1 == var8) {
        continue;
      }

      var9 = 0;
      var10 = 0;
      var11 = group_findpod(var6, var8);

      if(isDefined(var11) && var11.state == 3) {
        continue;
      }

      if(isDefined(var2)) {
        if(var8 cansee(var2)) {
          var9 = 1;
          var10 = 1;
        }
      }

      if(!var9 && var8 cansee(var1)) {
        var9 = 1;
      }

      if(!var9 && distancesquared(var8.origin, var1.origin) < var4 && var8 hastacvis(var1)) {
        var9 = 1;

        if(isDefined(var2)) {
          var10 = 1;
        }
      }

      if(var10) {
        var8 getenemyinfo(var2);
      }

      if(var9) {
        if(isDefined(var2)) {
          var8 aieventlistenerevent("combat", var2, var3);
          continue;
        }

        var8 aieventlistenerevent("combat", var1, var1.origin);
      }
    }
  }
}

function pod_settocombat(var0, var1) {
  var2 = self.members;

  foreach(var4 in var2) {
    if(var0) {
      var4 getenemyinfo(var1);
    }

    var4 aieventlistenerevent("combat", var1, var1.origin);
  }
}

function groups_combat_checklosttarget() {
  level notify("cancel_group_combat_checklosttarget");
  level endon("cancel_group_combat_checklosttarget");
  waitframe();

  while(!isDefined(level.stealth.bstayincombatoncealerted)) {
    var0 = [];
    var1 = 1;

    foreach(var3 in level.stealth.groupdata.groups) {
      foreach(var5 in var3.pods) {
        if(var5.state == 3) {
          var0 = var5;

          if(!isDefined(var5.bchecklosttarget) || !pod_haslostenemy(var5)) {
            var1 = 0;
            break;
          }
        }
      }

      if(!var1) {
        break;
      }
    }

    if(var1) {
      foreach(var9 in var0) {
        pod_settohunt(var9);
      }

      return;
    }

    wait 2;
  }
}

function pod_combat_update_checklosttarget() {
  self endon("state_change");
  wait 5;

  if(!pod_haslostenemy() && isDefined(level.stealth.funcs) && isDefined(level.stealth.funcs["call_backup"])) {
    self thread[[level.stealth.funcs["call_backup"]]]();
  }

  if(isDefined(level.stealth.bstayincombatoncealerted)) {
    return;
  }

  self.bchecklosttarget = 1;
  thread groups_combat_checklosttarget();
}

function pod_haslostenemy() {
  var0 = 10000;
  var1 = 15000;
  var2 = 50625;
  var3 = gettime();
  var4 = undefined;

  foreach(var6 in self.members) {
    if(isDefined(var6.stealth.funcs) && isDefined(var6.stealth.funcs["has_lost_enemy"])) {
      return var6[[var6.stealth.funcs["has_lost_enemy"]]]();
    }

    var7 = var6.enemy;

    if(isDefined(var7) && issentient(var7) && isalive(var7)) {
      if(var7.team != "allies") {
        return 0;
      }

      var8 = var6 lastknowntime(var7);

      if(var3 < var8 + var0) {
        return 0;
      }

      var9 = var6 lastknownpos(var7);

      if(var8 > 0 && distancesquared(var7.origin, var9) < var2) {
        return 0;
      }

      if(var3 < var8 + var1 && var7 hastacvis(var9)) {
        return 0;
      }

      if(isDefined(self.benemyinlowcover)) {
        return 0;
      }

      continue;
    }

    if(!isDefined(var6.enemy) && var6 scripts\engine\utility::ent_flag_exist("in_the_dark") && var6 scripts\engine\utility::ent_flag("in_the_dark") && var3 - var6.lastenemysighttime < var0) {
      return 0;
    }
  }

  return 1;
}

function pod_isclosetoanymembers(var0, var1, var2) {
  if(!var2) {
    var2 = 0;
  }

  var3 = var1 * var1;

  foreach(var5 in self.members) {
    if(distancesquared(var0.origin, var5.origin) > var3) {
      continue;
    }

    if(var2 && !var0 hastacvis(var5)) {
      continue;
    }

    return true;
  }

  return false;
}

function pod_combat_periodicping() {
  self endon("state_change");
  var0 = 1;
  var1 = 384;
  wait var0;

  for(;;) {
    foreach(var3 in level.stealth.groupdata.groups) {
      foreach(var5 in var3.members) {
        if(var5.stealth.bsmstate == 3 || var5.stealth.bsmstate == 2) {
          continue;
        }

        if(pod_isclosetoanymembers(var5, var1, 1)) {
          var5 aieventlistenerevent("combat", var5, var5.origin);
        }
      }
    }

    wait var0;
  }
}

function pod_settohunt() {
  var0 = self.members;

  foreach(var2 in var0) {
    var3 = 1;

    if(isDefined(var2.stealth.funcs) && isDefined(var2.stealth.funcs["should_hunt"])) {
      var3 = var2[[var2.stealth.funcs["should_hunt"]]]();
    }

    if(!var3) {
      var2 scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
      continue;
    }

    var2 scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
  }
}

function pod_settoidle() {
  foreach(var1 in self.members) {
    var1 aieventlistenerevent("reset", var1, var1.origin);
  }
}

function pod_isleader(var0) {
  var1 = getgroup(var0.script_stealthgroup);
  var2 = group_findpod(var1, var0);

  if(!isDefined(var2)) {
    return false;
  }

  return var2.members[0] == var0;
}

function pod_getclosestguy(var0) {
  var1 = undefined;
  var2 = 99999999;

  foreach(var4 in self.members) {
    var5 = distancesquared(var4.origin, var0);

    if(!isDefined(var1) || var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function pod_delete() {
  self notify("state_change");
  var0 = self.parentgroup;
  var1 = var0.pods.size;

  for(var2 = 0; var2 < var1; var2++) {
    if(var0.pods[var2] == self) {
      var3 = var0.pods.size - 1;
      var0.pods[var2] = var0.pods[var3];
      var0.pods[var3] = undefined;
      break;
    }
  }
}