/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\stealth\group.gsc
***********************************************/

#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\utility;
#namespace group;

function function_4e29112ac7171ec8() {
  return false;
}

function initgroup(groupname) {
  if(!isDefined(level.stealth.groupdata)) {
    level.stealth.groupdata = spawnStruct();
  }

  groupdata = level.stealth.groupdata;

  if(!isDefined(groupdata.groups)) {
    groupdata.groups = [];
  }

  mygroup = groupdata.groups[groupname];

  if(!isDefined(mygroup)) {
    mygroup = function_ff39fd6d3d8e4d65(groupname);
    groupdata.groups[groupname] = mygroup;
  }

  level.stealth.groupdata notify(groupname);
}

function addtogroup(groupname, guy) {
  if(!isDefined(level.stealth.groupdata) || !isDefined(level.stealth.groupdata.groups) || !isDefined(level.stealth.groupdata.groups[groupname])) {
    initgroup(groupname);
  }

  mygroup = level.stealth.groupdata.groups[groupname];
  function_c30acbb55783d011(groupname, guy);
  mygroup thread group_waitfordeath(guy);
}

function group_waitfordeath(guy) {
  guy waittill("death");
  guy thread scripts\stealth\enemy::death_cleanup();

  if(isDefined(guy)) {
    group_removefrompod(guy);
    function_bf304efe09a7ceeb(self.name, guy);
  }
}

function clearallgroups() {
  if(!isDefined(level.stealth.groupdata)) {
    return;
  }

  if(!isDefined(level.stealth.groupdata.groups)) {
    return;
  }

  foreach(group in level.stealth.groupdata.groups) {
    if(isDefined(group.pods)) {
      foreach(pod in group.pods) {
        pod notify("<dev string:x1c>");
      }
    }
  }

  level.stealth.groupdata.groups = undefined;
}

function getgroup(groupname) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.groupdata));
  assert(isDefined(level.stealth.groupdata.groups));
  return level.stealth.groupdata.groups[groupname];
}

function makenewpod(groupname, state, origin) {
  newpod = function_8858434f2625bf7(groupname, state, origin);
  newpod.parentgroupname = groupname;
  return newpod;
}

function addtopod(pod, guy) {
  function_8107c79679a9f8e1(pod.id, guy);
}

function group_trytojoinexistingpod(currentpod, podstate, guy, investigatepos) {
  if(isDefined(currentpod)) {
    var_ab308d685d86fc64 = currentpod.id;
  } else {
    var_ab308d685d86fc64 = undefined;
  }

  existingpod = function_4af71893064929f8(podstate, investigatepos, guy.script_stealthgroup, var_ab308d685d86fc64);

  if(isDefined(existingpod)) {
    group_removefrompod(guy);
    addtopod(existingpod, guy);
    return existingpod;
  }
}

function group_assigntoinvestigatepod(guy, investigatepos) {
  existingpod = group_trytojoinexistingpod(undefined, 1, guy, investigatepos);

  if(isDefined(existingpod)) {
    if(!isDefined(existingpod.investigateoriginguy)) {
      existingpod pod_updateinvestigateorigin(guy, investigatepos);
    }

    return false;
  }

  group_removefrompod(guy);
  newpod = makenewpod(guy.script_stealthgroup, 1, investigatepos);
  addtopod(newpod, guy);
  newpod.investigateoriginguy = guy;
  vol = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(vol)) {
    newpod.volume = vol;
    newpod.borigininvolume = ispointinvolume(investigatepos, vol);
  }

  if(!isDefined(self.script_stealthgroup)) {
    newpod.volumeidx = function_25040278e58d8da3("investigate", self.origin);
  }

  thread pod_debug(newpod);

  level thread function_92f7df07df367143(guy);
  return true;
}

function group_removefrompod(guy) {
  pod = function_bc5df124338cefea(guy);

  if(!isDefined(pod)) {
    return;
  }

  function_6daa1ca6fed22cf3(pod.id, guy);

  if(isDefined(pod.jobs) && isDefined(guy) && isDefined(pod.jobs[guy getentitynumber()])) {
    guy notify("pod_job_abort");
    pod.jobs[guy getentitynumber()] = undefined;
  }

  if(pod.members.size == 0) {
    pod pod_delete();
  }
}

function drawcross(origin) {
  r = 6;
  forward = (r, 0, 0);
  left = (0, r, 0);
  up = (0, 0, r);
  color = (0, 1, 0);
  line(origin - forward, origin + forward, color, 1, 0, 1);
  line(origin - left, origin + left, color, 1, 0, 1);
  line(origin - up, origin + up, color, 1, 0, 1);
}

function pod_debug(pod) {
  pod endon("<dev string:x26>");
  up = (0, 0, 128);
  down = (0, 0, -12);

  while(true) {
    if(scripts\stealth\debug::debug_enabled()) {
      line(pod.origin, pod.origin + up, (0, 0, 1), 1, 0, 1);
      groupname = pod.parentgroupname;

      if(isDefined(groupname)) {
        print3d(pod.origin, groupname, (1, 1, 0), 1, 0.8, 1);
      }

      guystr = "<dev string:x33>";

      foreach(member in pod.members) {
        if(isalive(member)) {
          guystr += "<dev string:x34>" + member getentitynumber();
        }
      }

      if(pod.state == 1) {
        print3d(pod.origin + down, "<dev string:x36>" + guystr, (1, 1, 0), 1, 0.4, 1);
      } else if(pod.state == 2) {
        print3d(pod.origin + down, "<dev string:x3a>" + guystr, (1, 1, 0), 1, 0.4, 1);
      }

      numlanes = pod.members.size;
      lanewidth = 360 / numlanes;

      for(ilane = 0; ilane < numlanes + 1; ilane++) {
        angle = ilane * lanewidth;
        line(pod.origin, pod.origin + 128 * (cos(angle - lanewidth), sin(angle - lanewidth), 0), (0, 1, 0), 1, 0, 1);
      }
    }

    waitframe();
  }
}

function group_findsomeotherguytoinvestigate(pos, var_32a96bf508fbd2f) {
  var_7e6c997a4d1908fc = 2304;
  otherguy = undefined;
  closestdistsq = 2359296;
  candidateguys = [];

  foreach(group in level.stealth.groupdata.groups) {
    if(group.name == var_32a96bf508fbd2f) {
      continue;
    }

    volume = level.stealth.investigate_volumes[group.name];

    if(isDefined(volume) && !ispointinvolume(pos, volume)) {
      continue;
    }

    foreach(pod in group.pods) {
      if(pod.state == 1 && distance2dsquared(pod.origin, pos) < var_7e6c997a4d1908fc) {
        return undefined;
      }
    }

    foreach(guy in group.members) {
      if([[self.fnisinstealthidle]]()) {
        distsq = distancesquared(guy.origin, pos);

        if(distsq < closestdistsq) {
          candidateguys[candidateguys.size] = guy;

          if(candidateguys.size > 8) {
            break;
          }
        }
      }
    }
  }

  if(candidateguys.size > 0) {
    otherguy = findclosestpointbyapproxpathdist(candidateguys, pos);
  }

  return otherguy;
}

function group_checkrequestbackupoutsideofvolume(e) {
  volume = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(volume)) {
    if(!ispointinvolume(e.investigate_pos, volume)) {
      otherguy = group_findsomeotherguytoinvestigate(e.investigate_pos, self.script_stealthgroup);

      if(isDefined(otherguy)) {
        scripts\stealth\debug::function_ec780a18fdfb4982(self, "<dev string:x3f>");

        scripts\stealth\debug::function_ec780a18fdfb4982(self, "<dev string:x6a>");

        scripts\stealth\debug::function_ec780a18fdfb4982(otherguy, "<dev string:x90>");

        otherguy aieventlistenerevent("seek_backup", self, e.investigate_pos);
        return true;
      }
    }
  }

  return false;
}

function group_eventinvestigate(guy, e) {
  var_d24e406e7deefabc = group_assigntoinvestigatepod(guy, e.investigate_pos);

  if(var_d24e406e7deefabc) {
    guy thread group_investigate_seekbackup(e);
  }
}

function group_investigate_seekbackup(e) {
  self endon("death");
  self endon("start_context_melee");
  self endon("scripted_melee_start");
  waitframe();
  group_checkrequestbackupoutsideofvolume(e);

  if(!isDefined(self.script_stealthgroup)) {
    return;
  }

  waitframe();
  group = getgroup(self.script_stealthgroup);
  pod = group_findpod(group, self);

  if(!isDefined(pod)) {
    return;
  }

  if(pod.members.size == 1) {
    nummembers = group.members.size;

    for(imember = 0; imember < nummembers; imember++) {
      otherguy = group.members[imember];

      if(otherguy.var_fe5ebefa740c7106 == 0 && distancesquared(otherguy.origin, self.origin) < 10000) {
        otherguy glanceatentity(self);
      }
    }
  }
}

function group_findpod(groupdata, guy) {
  if(!isDefined(groupdata.pods)) {
    return;
  }

  numpods = groupdata.pods.size;

  for(ipod = 0; ipod < numpods; ipod++) {
    pod = groupdata.pods[ipod];
    nummembers = pod.members.size;

    for(imember = 0; imember < nummembers; imember++) {
      if(pod.members[imember] == guy) {
        return pod;
      }
    }
  }
}

function group_eventcoverblown(groupname, guy, e) {
  if(isDefined(groupname)) {
    groupdata = getgroup(groupname);
  } else {
    groupdata = undefined;
  }

  groupdata thread group_delayedcoverblownpropagation(guy);
  var_d24e406e7deefabc = group_assigntoinvestigatepod(guy, e.investigate_pos);

  if(var_d24e406e7deefabc) {
    thread group_coverblown_seekbackup(groupdata, e);
  }
}

function group_delayedcoverblownpropagation(guy) {
  wait 2;

  if(isDefined(guy) && isalive(guy)) {
    self.bcoverhasbeenblown = 1;
  }
}

function group_coverblown_seekbackup(groupdata, e) {
  self endon("death");
  self endon("start_context_melee");
  self endon("scripted_melee_start");
  waitframe();
  pod = function_bc5df124338cefea(self);

  if(!isDefined(pod)) {
    return;
  }

  if(isDefined(groupdata) && pod.members.size == 1) {
    nummembers = groupdata.members.size;

    for(imember = 0; imember < nummembers; imember++) {
      otherguy = groupdata.members[imember];

      if(otherguy != self && otherguy.var_fe5ebefa740c7106 == 0 && distancesquared(otherguy.origin, self.origin) < 10000) {
        otherguy glanceatentity(self);
      }
    }
  }

  if(group_checkrequestbackupoutsideofvolume(e)) {
    return;
  }

  if(isDefined(groupdata) && groupdata.members.size > 1) {
    pod = function_bc5df124338cefea(self);

    if(isDefined(pod) && pod.state == 1 && pod.members.size == 1 && (!isDefined(pod.volume) || pod.borigininvolume)) {
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "seek_backup", 2, undefined, 1);
    }
  }
}

function pod_updateinvestigateorigin(guy, pos) {
  self.origin = pos;
  self.investigateoriginguy = guy;
  self.needsupdate = array_add(self.needsupdate, guy);
}

function group_updatepodhuntorigin(guy, var_f31054cb5cab2166) {}

function pod_hunt_update(squadid) {
  pod = spawnStruct();
  pod.squadid = squadid;
  pod thread function_9919694707b210df();
}

function function_561073db8e56e510(guy) {
  var_f68d091e4829568a = 48;
  var_fdc0268bd71773d8 = 5000;

  if(!isDefined(guy) || !isalive(guy)) {
    return false;
  }

  if(isDefined(self.jobs[guy getentitynumber()])) {
    return false;
  }

  if(isDefined(guy.pathgoalpos) && guy pathdisttogoal(1) < var_f68d091e4829568a) {
    return false;
  }

  if(guy scripts\asm\asm_bb::bb_playsmartobjectrequested()) {
    return false;
  }

  if(isDefined(guy.stealth.var_3fcbec5af762e2) && gettime() - guy.stealth.var_3fcbec5af762e2 < var_fdc0268bd71773d8) {
    return false;
  }

  return true;
}

function function_9919694707b210df() {
  var_3c1365bacf30636 = 262144;

  if(!isDefined(self.jobs)) {
    self.jobs = [];
  }

  jobid = 0;

  while(true) {
    if(!isDefined(self.squadid)) {
      return;
    }

    members = function_b9e807f454d30fe4(self.squadid);

    if(!isDefined(members) || members.size == 0) {
      return;
    }

    for(i = 0; i < members.size; i++) {
      guy = members[i];

      if(is_dead_or_dying(guy) || !function_561073db8e56e510(guy)) {
        continue;
      }

      entnum = guy getentitynumber();
      guylookaheaddir = guy.lookaheaddir;

      for(j = i + 1; j < members.size; j++) {
        otherguy = members[j];

        if(!isDefined(otherguy) || !isalive(otherguy)) {
          continue;
        }

        if(is_dead_or_dying(otherguy)) {
          continue;
        }

        otherentnum = otherguy getentitynumber();

        if(distancesquared(guy.origin, otherguy.origin) < var_3c1365bacf30636) {
          if(!function_561073db8e56e510(otherguy)) {
            continue;
          }

          var_483427e5f1c2060b = otherguy.lookaheaddir;
          var_21704ffa3438468f = vectorNormalize(otherguy.origin - guy.origin);

          if(vectordot(guylookaheaddir, var_21704ffa3438468f) < 0 && vectordot(guylookaheaddir, var_483427e5f1c2060b) < 0) {
            continue;
          }

          guypos = guy.origin;
          var_397b216df790894e = otherguy.origin;
          midpoint = (guypos + var_397b216df790894e) / 2;
          var_cffc7c7f4795b067 = vectorNormalize(midpoint - guy.origin);
          var_2b410386a2207da7 = vectorNormalize(midpoint - otherguy.origin);

          if(vectordot(var_cffc7c7f4795b067, guylookaheaddir) < 0.5) {
            continue;
          }

          if(vectordot(var_2b410386a2207da7, var_483427e5f1c2060b) < 0.5) {
            continue;
          }

          if(guy hastacvis(otherguy) || otherguy hastacvis(guy)) {
            midpoint = guy getclosestreachablepointonnavmesh(midpoint);
            guypos = guy getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(guypos - midpoint));
            var_397b216df790894e = otherguy getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(var_397b216df790894e - midpoint));
            job = spawnStruct();
            job.guys = [];
            job.guys[job.guys.size] = guy;
            job.guys[job.guys.size] = otherguy;
            job.requestedpos = [];
            job.requestedpos[entnum] = guypos;
            job.requestedpos[otherentnum] = var_397b216df790894e;
            job.state[entnum] = "init";
            job.state[otherentnum] = "init";
            job.leader = guy;
            job.requesttime = gettime();
            job.id = jobid;
            self.jobs[otherentnum] = job;
            self.jobs[entnum] = job;
            childthread function_67386b112e199533(job);
            jobid++;
            wait 5;
            break;
          }
        }
      }
    }

    wait 1;
  }
}

function function_87601e94f761af22(job) {
  self endon("pod_job_complete");
  self waittill("pod_job_abort");
  job.state[self getentitynumber()] = "done";
}

function function_67386b112e199533(job) {
  status = "wait_for_arrival";
  entnum1 = job.guys[0] getentitynumber();
  entnum2 = job.guys[1] getentitynumber();
  leader = job.leader;

  if(job.leader == job.guys[0]) {
    follower = job.guys[1];
  } else {
    follower = job.guys[0];
  }

  leader endon("death");
  follower endon("death");
  leader.gunposeoverride_internal = "gun_down";
  follower.gunposeoverride_internal = "gun_down";
  leader function_1c339daaba3f71db(1);
  follower function_1c339daaba3f71db(1);
  leader childthread function_87601e94f761af22(job);
  follower childthread function_87601e94f761af22(job);
  leader endon("pod_job_abort");
  follower endon("pod_job_abort");
  state1 = "";
  state2 = "";
  leader delaycall(randomfloatrange(0.2, 1), &setlookatentity, follower, 0);
  follower delaycall(randomfloatrange(0.2, 1), &setlookatentity, leader, 0);

  while(true) {
    if(!isDefined(job.guys[0]) || !isalive(job.guys[0])) {
      break;
    }

    if(!isDefined(job.guys[1]) || !isalive(job.guys[1])) {
      break;
    }

    guy1 = job.guys[0];
    guy2 = job.guys[1];

    if(status == "wait_for_arrival") {
      if(state1 != "arrived" && !isDefined(guy1.pathgoalpos)) {
        state1 = "arrived";
        job.state[entnum1] = "wait";
      }

      if(state2 != "arrived" && !isDefined(guy2.pathgoalpos)) {
        state2 = "arrived";
        job.state[entnum2] = "wait";
      }

      if(state1 == "arrived" && state2 == "arrived") {
        status = "gesture";
      }
    }

    if(status == "gesture") {
      job.state[leader getentitynumber()] = "gesture";
      leader function_c5bfef99b23e74be("hunt_gesture");

      if(!isDefined(leader) || !isalive(leader)) {
        break;
      }

      job.state[leader getentitynumber()] = "wait";
      job.state[follower getentitynumber()] = "gesture";
      follower function_c5bfef99b23e74be("hunt_gesture");

      if(!isDefined(follower) || !isalive(follower)) {
        break;
      }

      job.state[follower getentitynumber()] = "wait";
      status = "complete";
    }

    if(status == "complete") {
      job.state[entnum1] = "done";
      job.state[entnum2] = "done";
      break;
    }

    waitframe();
  }

  leader notify("pod_job_complete");
  follower notify("pod_job_complete");
}

function function_c5bfef99b23e74be(flag) {
  self endon("death");
  self endon("smartobject_logic_finished");
  self endon("hunt_gesture_timeout");
  childthread function_1e36bd48fc41811e(10);

  while(true) {
    self waittill(flag, status);

    if(status == "gesture_finish" || status == "gesture_cancel") {
      break;
    }
  }
}

function function_1e36bd48fc41811e(t) {
  wait t;
  self notify("hunt_gesture_timeout");
}

function function_75087b386454d072(guy) {
  if(!isDefined(self.jobs)) {
    return;
  }

  return self.jobs[guy getentitynumber()];
}

function function_b121dde73e7da661(guy) {
  if(!isDefined(self.jobs)) {
    return;
  }

  self.jobs[guy getentitynumber()] = undefined;
}

function function_92f7df07df367143(guy) {
  level notify("stop investigate start vo");
  level endon("stop investigate start vo");

  if(!isDefined(guy.script_stealthgroup)) {
    return;
  }

  groupdata = getgroup(guy.script_stealthgroup);

  if(!isDefined(groupdata)) {
    return;
  }

  groupdata.var_a67f19dde4bb4421 = 1;
  wait 0.1;

  if(groupdata.pods.size == 0) {
    return;
  }

  staymembers = [];
  var_b2f98cc1c4ec5171 = [];
  var_9dad3f5a14a525a3 = [];
  largestpod = groupdata.pods[0];

  for(i = 1; i < groupdata.pods.size; i++) {
    if(largestpod.members.size < groupdata.pods[i].members.size) {
      largestpod = groupdata.pods[i];
    }
  }

  if(utility::issp()) {
    speaker = getclosest(level.player.origin, largestpod.members);
  } else {
    speaker = random(largestpod.members);
  }

  if(!isDefined(speaker) || !isDefined(speaker.battlechatter)) {
    return;
  }

  var_b2f98cc1c4ec5171 = largestpod.members;

  foreach(pod in groupdata.pods) {
    if(pod != largestpod) {
      var_9dad3f5a14a525a3 = array_combine(var_9dad3f5a14a525a3, pod.members);
    }
  }

  staymembers = array_remove_array(groupdata.members, array_combine(var_b2f98cc1c4ec5171, var_9dad3f5a14a525a3));
  staymembers = array_remove(staymembers, speaker);

  if(var_9dad3f5a14a525a3.size == 0 && var_b2f98cc1c4ec5171.size == 0 && staymembers.size == 0) {
    groupdata.var_a67f19dde4bb4421 = 0;
    return;
  }

  if(!isDefined(speaker) || !isDefined(speaker.battlechatter)) {
    return;
  }

  speaker.battlechatter.investigatestart = spawnStruct();
  speaker.battlechatter.investigatestart.staymembers = staymembers;
  speaker.battlechatter.investigatestart.var_b2f98cc1c4ec5171 = var_b2f98cc1c4ec5171;
  speaker.battlechatter.investigatestart.var_9dad3f5a14a525a3 = var_9dad3f5a14a525a3;
  speaker thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "investigate");

  if(var_9dad3f5a14a525a3.size > 0) {
    if(var_b2f98cc1c4ec5171.size > 0) {
      if(staymembers.size > 0) {
        speaker thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_spreadoutwithmestay", undefined, undefined, 1);
      } else {
        speaker thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_spreadoutwithme", undefined, undefined, 1);
      }
    } else if(staymembers.size > 0) {
      speaker thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_singlespreadoutstay", undefined, undefined, 1);
    } else {
      speaker thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_singlespreadout", undefined, undefined, 1);
    }

    return;
  }

  if(var_b2f98cc1c4ec5171.size > 0) {
    return;
  }

  if(staymembers.size > 0) {}
}

function function_500fe4721adccab3(array) {
  callsigns = [];

  foreach(guy in array) {
    if(isDefined(guy.bccallsign)) {
      callsigns = array_add(callsigns, guy.bccallsign);
    }
  }

  return callsigns;
}

function pod_hunt_vo() {
  if(isDefined(level.bcs_stealthhuntthink)) {
    return;
  }

  level.bcs_stealthhuntthink = 1;
  level.var_cc7fb07b623a0ef5 = default_to(level.var_cc7fb07b623a0ef5, [6, 12]);
  first_lost = undefined;

  while(true) {
    hunters = [];

    foreach(group in level.stealth.groupdata.groups) {
      if(!isDefined(group.pods)) {
        continue;
      }

      foreach(pod in group.pods) {
        if(!isDefined(pod.state) || pod.state != 2) {
          continue;
        }

        foreach(hunter in pod.members) {
          hunters = array_add(hunters, hunter);
        }
      }
    }

    if(hunters.size < 1) {
      break;
    }

    if(hunters.size > 1) {
      if(utility::issp()) {
        hunters = sortbydistance(hunters, level.player.origin);
      } else {
        hunters = array_randomize(hunters);
      }

      hunters[0].battlechatter.huntgroup = hunters;
      leader = hunters[0];
      hunters = array_remove(hunters, leader);
      wait randomfloatrange(2, 2.5);
      hunters = array_removedead_or_dying(hunters);

      if(utility::issp()) {
        hunters = sortbydistance(hunters, level.player.origin);
      } else {
        hunters = array_randomize(hunters);
      }

      hunter = undefined;

      switch (hunters.size) {
        case 0:
          break;
        case 1:
        case 2:
        case 3:
          hunter = hunters[randomint(hunters.size)];
          break;
        default:
          hunter = hunters[randomint(3)];
          break;
      }

      if(!isDefined(hunter)) {
        break;
      }

      hunters = array_add(hunters, leader);
      hunter.battlechatter.huntgroup = hunters;
    } else {
      hunter = hunters[0];

      if(!isDefined(first_lost)) {}
    }

    if(isarray(level.var_cc7fb07b623a0ef5)) {
      wait randomfloatrange(level.var_cc7fb07b623a0ef5[0], level.var_cc7fb07b623a0ef5[1]);
      continue;
    }

    wait level.var_cc7fb07b623a0ef5;
  }

  level.bcs_stealthhuntthink = undefined;
}

function group_anyoneincombat(groupname) {
  groupdata = getgroup(groupname);

  foreach(pod in groupdata.pods) {
    if(pod.state == 3) {
      return true;
    }
  }

  return false;
}

function function_624f57a99242f017(groupname) {
  groupdata = getgroup(groupname);

  foreach(pod in groupdata.pods) {
    if(pod.state == 1) {
      return true;
    }
  }

  return false;
}

function groups_combat_checklosttarget() {}

function pod_combat_update_checklosttarget() {
  self endon("state_change");
  wait level.stealth.var_e012fd4f27172998;

  if(istrue(self.var_dff7984130ece673)) {
    while(self.var_dff7984130ece673) {
      wait 0.5;
    }

    wait randomfloatrange(0.5, 1);
  }

  if(!pod_haslostenemy() && isDefined(level.stealth.funcs) && isDefined(level.stealth.funcs["call_backup"])) {
    self thread[[level.stealth.funcs["call_backup"]]]();
  }

  if(isDefined(level.stealth.bstayincombatoncealerted)) {
    return;
  }

  self.bchecklosttarget = 1;
}

function pod_haslostenemy() {
  ctimetolose = 10000;
  var_7c08dd16ffa22ba8 = 15000;
  cstillrighttheredistsq = 50625;

  if(isDefined(level.stealth.var_792e4b9a380ade11)) {
    ctimetolose = level.stealth.var_792e4b9a380ade11;
  }

  if(isDefined(level.stealth.var_94f8771062f2161)) {
    var_7c08dd16ffa22ba8 = level.stealth.var_94f8771062f2161;
  }

  if(isDefined(level.stealth.var_e2e3c78d7dc88605)) {
    cstillrighttheredistsq = level.stealth.var_e2e3c78d7dc88605;
  }

  curtime = gettime();
  var_397afc8bc8ec2d48 = undefined;

  foreach(guy in self.members) {
    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs["has_lost_enemy"])) {
      if(!guy[[guy.stealth.funcs["has_lost_enemy"]]]()) {
        return false;
      }

      continue;
    }

    enemy = guy.enemy;

    if(isDefined(enemy) && issentient(enemy) && isalive(enemy)) {
      if(utility::issp() && enemy.team != "allies") {
        return false;
      }

      lasttime = guy lastknowntime(enemy);

      if(curtime < lasttime + ctimetolose) {
        return false;
      }

      lastknownpostoenemy = guy lastknownpos(enemy);

      if(lasttime > 0 && distancesquared(enemy.origin, lastknownpostoenemy) < cstillrighttheredistsq) {
        return false;
      }

      if(curtime < lasttime + var_7c08dd16ffa22ba8 && enemy hastacvis(lastknownpostoenemy)) {
        return false;
      }

      if(istrue(guy.benemyinlowcover)) {
        return false;
      }

      continue;
    }

    if(!isDefined(guy.enemy) && guy ent_flag_exist("in_the_dark") && guy ent_flag("in_the_dark") && curtime - guy.lastenemysighttime < ctimetolose) {
      return false;
    }
  }

  return true;
}

function pod_settohunt(var_d384e7929fbdb26c) {
  localmembers = self.members;

  foreach(guy in localmembers) {
    var_332044e98950634f = 1;

    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs["should_hunt"])) {
      var_332044e98950634f = guy[[guy.stealth.funcs["should_hunt"]]]();
    }

    if(!var_332044e98950634f) {
      guy scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
      continue;
    }

    if(isDefined(var_d384e7929fbdb26c)) {
      guy.var_4b1fa39975a3fd58 = randomint(var_d384e7929fbdb26c);
      guy thread function_b32f74bb1f7e968e(var_d384e7929fbdb26c / 1000);

      if(cointoss()) {
        guy.var_587d8840dea10869 = 1;
      }
    }

    guy scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
  }
}

function function_b32f74bb1f7e968e(delaytime) {
  self endon("death");
  wait delaytime;
  self.var_4b1fa39975a3fd58 = undefined;
  self.var_587d8840dea10869 = undefined;
}

function pod_settoidle() {
  foreach(guy in self.members) {
    guy aieventlistenerevent("reset", guy, guy.origin);
  }
}

function pod_isleader(guy) {
  pod = function_bc5df124338cefea(guy);

  if(!isDefined(pod)) {
    return false;
  }

  assert(pod.members.size > 0);
  return pod.members[0] == guy;
}

function pod_delete() {
  self notify("state_change");
  assert(self.members.size == 0);
  function_90814ee949699baa(self.id);
}