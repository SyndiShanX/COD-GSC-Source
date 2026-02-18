/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\group.gsc
***********************************************/

#using script_3072532951b5b4ae;
#using script_6f8610e78fdd3440;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\smart_object;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\tac;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace group;

function scalevolume(ent, vol) {}

#namespace stealth_group;

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
    mygroup = spawnStruct();
    groupdata.groups[groupname] = mygroup;
    mygroup.name = groupname;
    mygroup.members = [];
    mygroup.pods = [];
  }

  level.stealth.groupdata notify(groupname);
}

function addtogroup(groupname, guy) {
  if(!isDefined(level.stealth.groupdata) || !isDefined(level.stealth.groupdata.groups) || !isDefined(level.stealth.groupdata.groups[groupname])) {
    initgroup(groupname);
  }

  mygroup = level.stealth.groupdata.groups[groupname];
  mygroup.members[mygroup.members.size] = guy;
  mygroup thread group_waitfordeath(guy);
}

function function_b6ebd4af(guy) {
  if(!isDefined(guy.script_stealthgroup)) {
    return;
  }

  stealthgroup = getgroup(guy.script_stealthgroup);

  if(isDefined(stealthgroup)) {
    stealthgroup function_34c06bfe(guy);
  }
}

function function_34c06bfe(guy) {
  group_removefrompod(self, guy);
  nummembers = self.members.size;

  for(imember = 0; imember < nummembers; imember++) {
    if(self.members[imember] == guy) {
      var_a47c95a3 = self.members.size - 1;
      self.members[imember] = self.members[var_a47c95a3];
      self.members[var_a47c95a3] = undefined;
      break;
    }
  }

  if(isDefined(guy.stealth) && isDefined(guy.stealth.cleardata)) {
    region = guy.stealth.cleardata.curregion;
    guy namespace_5cd4acd8::huntunassignfromregion(region);
  }
}

function group_waitfordeath(guy) {
  guy waittill(#"death");
  guy thread stealth_enemy::death_cleanup();
  self function_34c06bfe(guy);
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
        pod notify(#"debug off");
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

function function_957fac82() {
  foreach(group in level.stealth.groupdata.groups) {
    println("<dev string:x38>" + group.name);
    println("<dev string:x47>");

    foreach(guy in group.members) {
      println("<dev string:x56>" + guy getentitynumber());
    }

    var_d78e3a4f = 0;
    println("<dev string:x5d>");

    foreach(pod in group.pods) {
      println("<dev string:x69>" + var_d78e3a4f + "<dev string:x74>");

      foreach(guy in pod.members) {
        println("<dev string:x56>" + guy getentitynumber());
      }

      var_d78e3a4f++;
    }
  }
}

function makenewpod(groupdata, state, origin) {
  newpod = spawnStruct();
  newpod.state = state;
  newpod.members = [];
  newpod.parentgroup = groupdata;
  groupdata.pods[groupdata.pods.size] = newpod;

  if(isDefined(origin)) {
    function_f6ab9430(newpod, origin);
  }

  return newpod;
}

function function_f6ab9430(pod, origin, var_ccf5f27b) {
  assert(isDefined(origin));
  pod.origin = getclosestpointonnavmesh(origin, 500, 16);

  if(!isDefined(pod.origin)) {
    pod.origin = origin;
  }

  function_4f3db9c6(pod, var_ccf5f27b);
}

function addtopod(pod, guy) {
  pod.members[pod.members.size] = guy;
}

function function_4f3db9c6(pod, var_ccf5f27b) {
  mindistsq = sqr(100);

  if(!isDefined(var_ccf5f27b)) {
    var_ccf5f27b = 0;
  }

  assert(isDefined(pod));

  if(!isDefined(pod.origin)) {
    return;
  }

  if(var_ccf5f27b > 3) {
    return;
  }

  foreach(group in level.stealth.groupdata.groups) {
    foreach(var_dff5abf9 in group.pods) {
      if(var_dff5abf9 === pod) {
        continue;
      }

      if(!isDefined(var_dff5abf9.origin)) {
        continue;
      }

      if(distancesquared(var_dff5abf9.origin, pod.origin) < mindistsq) {
        var_85bca00c = getrandomnavpoint(pod.origin, 500);

        if(isDefined(var_85bca00c)) {
          function_f6ab9430(pod, var_85bca00c, var_ccf5f27b + 1);
        }
      }
    }
  }
}

function group_trytojoinexistingpod(groupdata, currentpod, podstate, guy, investigatepos) {
  var_76bc7166 = 65536;

  foreach(pod in groupdata.pods) {
    if(isDefined(currentpod) && currentpod == pod) {
      continue;
    }

    if(pod.state == podstate) {
      if(distancesquared(investigatepos, pod.origin) < var_76bc7166) {
        group_removefrompod(groupdata, guy);
        addtopod(pod, guy);
        return pod;
      }
    }
  }
}

function group_assigntoinvestigatepod(groupdata, guy, investigatepos) {
  var_76bc7166 = 65536;
  existingpod = group_trytojoinexistingpod(groupdata, undefined, 1, guy, investigatepos);

  if(isDefined(existingpod)) {
    existingpod pod_updateinvestigateorigin(guy, investigatepos);
    return false;
  }

  group_removefrompod(groupdata, guy);
  newpod = makenewpod(groupdata, 1, investigatepos);
  addtopod(newpod, guy);
  group_generateinitialinvestigatepoints(newpod, guy.script_stealthgroup, investigatepos);
  vol = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(vol)) {
    newpod.volume = vol;
    newpod.borigininvolume = vol istouching(investigatepos);
  }

  thread pod_debug(newpod);

  return true;
}

function group_assigntohuntpod(groupdata, guy, lastknownpos, lastknowntime) {
  group_removefrompod(guy, lastknownpos);

  foreach(pod in guy.pods) {
    if(pod.state == 2) {
      if(!isDefined(lastknownpos.enemy) || !isDefined(pod.target) || pod.target == lastknownpos.enemy) {
        addtopod(pod, lastknownpos);

        if(!isDefined(pod.target)) {
          pod.target = lastknownpos.enemy;

          if(isDefined(lastknowntime)) {
            function_f6ab9430(pod, lastknowntime);
          }
        }

        return;
      }
    }
  }

  if(!isDefined(lastknowntime)) {
    lastknowntime = lastknownpos.origin;
  }

  newpod = makenewpod(guy, 2, lastknowntime);
  addtopod(newpod, lastknownpos);
  newpod.target = lastknownpos.enemy;
  group_generateinitialinvestigatepoints(newpod, lastknownpos.script_stealthgroup, lastknowntime);
  vol = level.stealth.hunt_volumes[self.script_stealthgroup];

  if(isDefined(vol)) {
    newpod.volume = vol;
    newpod.borigininvolume = vol istouching(lastknowntime);
  }

  newpod.lastannouncetime = gettime();
  level thread pod_hunt_vo();
  newpod thread pod_hunt_update();
  newpod thread pod_hunt_delayednotify();

  if(isDefined(newpod.borigininvolume) && !newpod.borigininvolume) {
    stealth_debug::function_65b21ab8(lastknownpos, "<dev string:x82>");
  } else {
    stealth_debug::function_65b21ab8(lastknownpos, "<dev string:x9f>");
  }

  newpod thread pod_debug(newpod);
}

function group_removefrompod(groupdata = getgroup(guy.script_stealthgroup), guy) {
  pod = group_findpod(groupdata, guy);

  if(!isDefined(pod)) {
    return;
  }

  nummembers = pod.members.size;

  for(imember = 0; imember < nummembers; imember++) {
    if(pod.members[imember] == guy) {
      var_a47c95a3 = pod.members.size - 1;
      pod.members[imember] = pod.members[var_a47c95a3];
      pod.members[var_a47c95a3] = undefined;
      break;
    }
  }

  if(pod.members.size == 0) {
    if(pod.state == 2) {
      guy namespace_979752dc::group_flag_clear("stealth_combat_hunting", guy.script_stealthgroup);
    }

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
  pod endon(#"state_change");
  up = (0, 0, 128);
  down = (0, 0, -12);

  while(true) {
    if(stealth_debug::debug_enabled() && isDefined(pod.origin)) {
      zoffset = 0;
      var_5a7a026e = [];

      foreach(group in level.stealth.groupdata.groups) {
        foreach(var_dff5abf9 in group.pods) {
          if(!isDefined(var_dff5abf9.origin)) {
            continue;
          }

          if(distancesquared(var_dff5abf9.origin, pod.origin) < sqr(20)) {
            if(pod == var_dff5abf9) {
              zoffset = var_5a7a026e.size * 30;
            }

            var_5a7a026e[var_5a7a026e.size] = var_dff5abf9;
          }
        }
      }

      zoffset = (0, 0, zoffset);
      line(pod.origin + zoffset, pod.origin + up + zoffset, (0, 0, 1), 1, 0, 1);
      groupname = pod.parentgroup.name;

      if(isDefined(groupname)) {
        print3d(pod.origin + zoffset, groupname, (1, 1, 0), 1, 0.8, 1);
      }

      guystr = "<dev string:xc9>";

      foreach(member in pod.members) {
        if(isalive(member)) {
          guystr += "<dev string:xcd>" + member getentitynumber();
        }
      }

      if(pod.state == 1) {
        print3d(pod.origin + zoffset + down, "<dev string:xd2>" + guystr, (1, 1, 0), 1, 0.4, 1);
      } else if(pod.state == 2) {
        print3d(pod.origin + zoffset + down, "<dev string:xd9>" + guystr, (1, 1, 0), 1, 0.4, 1);
      }

      foreach(point in pod.investigatepoints) {
        drawcross(point.origin);
      }

      numlanes = pod.members.size;
      lanewidth = 360 / numlanes;

      for(ilane = 0; ilane < numlanes + 1; ilane++) {
        angle = ilane * lanewidth;
        line(pod.origin, pod.origin + 128 * (cos(angle - lanewidth), sin(angle - lanewidth), 0), (0, 1, 0), 1, 0, 1);
      }
    }

    waitframe(1);
  }
}

function group_findsomeotherguytoinvestigate(pos, var_ae3b954a) {
  var_3f2754d4 = 2304;
  otherguy = undefined;
  closestdistsq = 2359296;
  candidateguys = [];

  foreach(group in level.stealth.groupdata.groups) {
    if(group.name == var_ae3b954a) {
      continue;
    }

    volume = level.stealth.investigate_volumes[group.name];

    if(isDefined(volume) && !volume istouching(pos)) {
      continue;
    }

    foreach(pod in group.pods) {
      if(pod.state == 1 && distance2dsquared(pod.origin, pos) < var_3f2754d4) {
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
    if(!volume istouching(e.investigate_pos)) {
      otherguy = group_findsomeotherguytoinvestigate(e.investigate_pos, self.script_stealthgroup);

      if(isDefined(otherguy)) {
        stealth_debug::function_65b21ab8(self, "<dev string:xe1>");

        stealth_debug::function_65b21ab8(self, "<dev string:x10f>");

        stealth_debug::function_65b21ab8(otherguy, "<dev string:x138>");

        otherguy function_a3fcf9e0("seek_backup", self, e.investigate_pos);
        return true;
      }
    }
  }

  return false;
}

function group_eventinvestigate(groupname, guy, e) {
  groupdata = getgroup(groupname);
  var_89808178 = group_assigntoinvestigatepod(groupdata, guy, e.investigate_pos);

  if(var_89808178) {
    guy thread group_investigate_seekbackup(e);
  }
}

function group_investigate_seekbackup(e) {
  self endon(#"death", #"start_context_melee", #"takedown");
  waitframe(1);
  self group_checkrequestbackupoutsideofvolume(e);
  waitframe(1);
  group = getgroup(self.script_stealthgroup);
  pod = group_findpod(group, self);

  if(!isDefined(pod)) {
    return;
  }

  if(pod.members.size == 1) {
    nummembers = group.members.size;

    for(imember = 0; imember < nummembers; imember++) {
      otherguy = group.members[imember];

      if(otherguy.stealth.bsmstate == 0 && distancesquared(otherguy.origin, self.origin) < 10000) {
        otherguy ai::look_at(self, undefined, undefined, 0.55);
      }
    }
  }
}

function group_generateinitialinvestigatepoints(pod, groupname, origin) {
  groupdata = getgroup(groupname);
  assert(pod.state == 1 || pod.state == 2);
  assert(!isDefined(pod.investigatepoints));
  var_804461ee = 1000000;
  var_c491acad = [];
  var_f5ea0eba = getnodearray("seek_patrol", "targetname");
  var_7e3b3cbc = struct::get_array("seek_patrol", "targetname");
  var_f5ea0eba = arraycombine(var_f5ea0eba, var_7e3b3cbc);

  for(var_e10e2e46 = 0; var_e10e2e46 < var_f5ea0eba.size; var_e10e2e46++) {
    var_594c1bc9 = 0;
    point = var_f5ea0eba[var_e10e2e46];

    if(distancesquared(point.origin, origin) > var_804461ee) {
      var_594c1bc9 = 1;
    } else if(isDefined(point.script_stealthgroup)) {
      if(point.script_stealthgroup == groupname) {
        var_c491acad[var_c491acad.size] = point;
      }

      var_594c1bc9 = 1;
    }

    if(var_594c1bc9) {
      lastpoint = var_f5ea0eba.size - 1;
      var_f5ea0eba[var_e10e2e46] = var_f5ea0eba[lastpoint];
      var_f5ea0eba[lastpoint] = undefined;
      continue;
    }
  }

  var_c491acad = arraysortclosest(var_c491acad, origin);
  var_f5ea0eba = arraysortclosest(var_f5ea0eba, origin);
  pod.investigatepoints = arraycombine(var_c491acad, var_f5ea0eba);
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

function pod_addusedpoint(pod, point) {
  if(!isDefined(pod.usedpoints)) {
    pod.usedpoints = [];
  }

  pod.usedpoints[pod.usedpoints.size] = {
    #origin: point, #expire: gettime() + 5000
  };
}

function pod_cleanupusedpoints(pod) {
  if(!isDefined(pod.usedpoints)) {
    pod.usedpoints = [];
  }

  curtime = gettime();

  for(var_e10e2e46 = 0; var_e10e2e46 < pod.usedpoints.size; var_e10e2e46++) {
    if(isDefined(pod.usedpoints[var_e10e2e46].expire) && curtime >= pod.usedpoints[var_e10e2e46].expire) {
      pod.usedpoints[var_e10e2e46] = pod.usedpoints[pod.usedpoints.size - 1];
      pod.usedpoints[pod.usedpoints.size - 1] = undefined;
      continue;
    }
  }
}

function group_getinvestigatepoint(guy, volume) {
  assert(isDefined(volume.origin));

  if(!isDefined(volume.origin)) {
    return (0, 0, 0);
  }

  groupdata = getgroup(volume.script_stealthgroup);
  pod = group_findpod(groupdata, volume);
  assert(isDefined(pod));
  assert(isDefined(pod.investigatepoints));
  assert(pod.state == 2 || pod.state == 1);
  assert(isDefined(pod.origin));

  if(!isDefined(pod.origin)) {
    return volume.origin;
  }

  pod_cleanupusedpoints(pod);
  var_86a04485 = undefined;
  dots = [];
  arrayremovevalue(pod.members, undefined);

  foreach(member in pod.members) {
    data = spawnStruct();
    data.guy = member;
    var_5c185af = member.origin - pod.origin;
    data.angle = vectortoyaw(var_5c185af);
    dots[dots.size] = data;

    if(member == volume) {
      var_86a04485 = data.angle;
    }
  }

  assert(isDefined(var_86a04485));
  var_73f7fb2a = 0;

  foreach(dot in dots) {
    if(dot.angle < var_86a04485) {
      var_73f7fb2a++;
    }
  }

  var_5c185af = volume.origin - pod.origin;
  distfromcenter = length(var_5c185af);
  var_ee7f3a11 = 768;
  var_dc7be821 = 512;
  var_f64a59e = 256;
  var_5c49f737 = -128;
  var_29469527 = 64;
  lanewidth = 360 / dots.size;
  var_941fad23 = var_73f7fb2a * lanewidth;

  foreach(point in pod.investigatepoints) {
    if(isDefined(point.lastinvestigatedtime)) {
      continue;
    }

    if(ispointinlane(point, pod, var_941fad23, lanewidth, distfromcenter, var_f64a59e)) {
      point.lastinvestigatedtime = gettime();
      return point.origin;
    }
  }

  var_2e04480f = distfromcenter;

  if(distfromcenter > var_ee7f3a11) {
    var_2e04480f = max(60, randomfloatrange(distfromcenter - var_f64a59e * 2, distfromcenter - var_f64a59e));
  } else if(distfromcenter > var_dc7be821) {
    var_2e04480f = randomfloatrange(distfromcenter + var_5c49f737, distfromcenter + var_f64a59e);
  } else {
    var_2e04480f = randomfloatrange(distfromcenter, distfromcenter + var_f64a59e);
  }

  var_dc04453c = (0.5 + var_73f7fb2a + randomfloatrange(-0.5, 0.5)) * lanewidth;
  var_8bfbd3f = (cos(var_dc04453c), sin(var_dc04453c), 0);
  desiredpos = pod.origin + var_2e04480f * var_8bfbd3f;
  var_9ea07d03 = pod.state == 2;
  smartobject = smart_object::function_ab981ed(desiredpos, pod.volume, 512, var_9ea07d03);

  if(isDefined(smartobject)) {
    return self namespace_77fd5d41::function_4efdd16b(smartobject);
  }

  pod_addusedpoint(pod, self.origin);

  if(isDefined(pod.volume)) {
    searchpos = namespace_206491b4::findclosestnonlospointwithinvolume(pod.volume, volume.origin, desiredpos, pod.usedpoints, 12);

    if(isDefined(searchpos)) {
      pod_addusedpoint(pod, searchpos);
      return searchpos;
    }
  } else if(volume.goalradius > 64 && isDefined(volume.scriptgoalpos)) {
    searchpos = namespace_206491b4::findclosestnonlospointwithinradius(volume.scriptgoalpos, volume.goalradius, volume.origin, desiredpos, pod.usedpoints, 12);

    if(isDefined(searchpos)) {
      pod_addusedpoint(pod, searchpos);
      return searchpos;
    }
  }

  var_a212a37d = getclosestpointonnavmesh(desiredpos, 500, 16);

  if(!isDefined(var_a212a37d)) {
    var_a212a37d = desiredpos;
  }

  var_e887f629 = undefined;

  if(isDefined(pod.volume)) {
    var_e887f629 = self findlastpointonpathwithinvolume(var_a212a37d, pod.volume);

    if(!isDefined(var_e887f629)) {
      var_e887f629 = getrandomnavpoint(pod.origin, var_29469527);
    }
  }

  if(!isDefined(var_e887f629)) {
    var_e887f629 = getrandomnavpoint(var_a212a37d, var_29469527);
  }

  if(!isDefined(var_e887f629)) {
    var_e887f629 = getclosestpointonnavmesh(pod.origin, 500, 16);

    if(!isDefined(var_e887f629)) {
      var_e887f629 = pod.origin;
    }
  }

  return var_e887f629;
}

function ispointinlane(point, pod, var_941fad23, lanewidth, distfromcenter, var_f64a59e) {
  var_1a3a18a0 = point.origin - pod.origin;
  d = length(var_1a3a18a0);
  angle = vectortoyaw(var_1a3a18a0);
  diff = angle - var_941fad23;

  if(diff >= 0 && diff <= lanewidth) {
    if(distfromcenter + var_f64a59e > d) {
      return true;
    }
  }

  return false;
}

function group_eventcoverblown(groupname, guy, e) {
  groupdata = getgroup(groupname);
  groupdata thread group_delayedcoverblownpropagation(guy);
  var_89808178 = group_assigntoinvestigatepod(groupdata, guy, e.investigate_pos);

  if(var_89808178) {
    self thread group_coverblown_seekbackup(groupdata, e);
  }
}

function group_delayedcoverblownpropagation(guy) {
  wait 2;

  if(isDefined(guy) && isalive(guy)) {
    self.bcoverhasbeenblown = 1;
  }
}

function group_coverblown_seekbackup(groupdata, e) {
  self endon(#"death", #"start_context_melee", #"takedown");
  waitframe(1);
  pod = group_findpod(groupdata, self);

  if(!isDefined(pod)) {
    return;
  }

  if(pod.members.size == 1) {
    nummembers = groupdata.members.size;

    for(imember = 0; imember < nummembers; imember++) {
      otherguy = groupdata.members[imember];

      if(otherguy != self && otherguy.stealth.bsmstate == 0 && distancesquared(otherguy.origin, self.origin) < 10000) {
        otherguy ai::look_at(self, undefined, undefined, 0.55);
      }
    }
  }

  if(group_checkrequestbackupoutsideofvolume(e)) {
    return;
  }

  if(groupdata.members.size > 1) {
    pod = group_findpod(groupdata, self);

    if(isDefined(pod) && pod.state == 1 && pod.members.size == 1 && (!isDefined(pod.borigininvolume) || pod.borigininvolume)) {
      self thread namespace_979752dc::function_f5f4416f("stealth", "announce", "seek_backup", 2, undefined, 1);
    }
  }
}

function pod_updateinvestigateorigin(guy, pos) {
  assert(isDefined(pos));

  if(!isDefined(self)) {
    return;
  }

  self.origin = pos;

  if(!isDefined(self.needsupdate)) {
    self.needsupdate = [];
  }

  self.investigateoriginguy = guy;
  self.needsupdate[self.needsupdate.size] = guy;
}

function group_eventhunt(groupname, guy) {
  groupdata = getgroup(groupname);
  lastknownpos = self.origin;
  lastknowntime = 0;

  if(isDefined(guy.enemy)) {
    lastknownpos = guy lastknownpos(guy.enemy);
    lastknowntime = guy lastknowntime(guy.enemy);
    var_3951724e = getclosestpointonnavmesh(lastknownpos, 500, 16);

    if(!isDefined(var_3951724e)) {
      var_3951724e = lastknownpos;
    }

    lastknownpos = var_3951724e;
  }

  group_removefrompod(groupdata, guy);
  group_assigntohuntpod(groupdata, guy, lastknownpos, lastknowntime);
}

function group_updatepodhuntorigin(guy, var_4af4ea3d) {
  groupdata = getgroup(guy.script_stealthgroup);
  pod = group_findpod(groupdata, guy);
  assert(isDefined(pod));
  assert(pod.state == 2);
  assert(isDefined(var_4af4ea3d));
  function_f6ab9430(pod, var_4af4ea3d);
  pod.borigininvestigated = undefined;

  if(isDefined(pod.volume)) {
    pod.borigininvolume = pod.volume istouching(pod.origin);
  }

  return pod.origin;
}

function pod_hunt_update() {
  self endon(#"state_change");
  self thread pod_hunt_hunker_update();

  if(isDefined(level.stealth.hunttimeout) && level.stealth.hunttimeout[self.script_stealthgroup]) {
    endtime = level.stealth.hunttimeout[self.script_stealthgroup];
    wait endtime;
    self thread pod_settoidle();
    return;
  }

  return;
}

function pod_hunt_hunker_update() {
  self endon(#"state_change");

  while(true) {
    var_65199be1 = isDefined(self.volume) && !is_true(self.borigininvolume);

    if(var_65199be1) {
      if(!isDefined(self.hunkerstarttime)) {
        self.hunkerstarttime = gettime();
        self.bhunkering = 1;
      } else if(is_true(self.bhunkering) && gettime() > self.hunkerstarttime + 20000) {
        self.bhunkering = undefined;
        self function_b55ead5e();
      }
    } else {
      self.bhunkering = undefined;
      self.hunkerstarttime = undefined;
      self function_b55ead5e();
    }

    waitframe(1);
  }
}

function function_b55ead5e() {
  self.bhunkering = undefined;
  self.hunkerstarttime = undefined;

  foreach(member in self.members) {
    if(isalive(member)) {
      member namespace_77fd5d41::hunt_hunker_terminate(member);
    }
  }
}

function pod_hunt_delayednotify() {
  self endon(#"state_change");
  wait 3;
  groupdata = self.parentgroup;

  foreach(guy in groupdata.members) {
    if(guy[[guy.fnisinstealthidle]]() || guy[[guy.fnisinstealthinvestigate]]()) {
      var_d6fd5eab = 1;

      if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs[# "should_hunt"])) {
        var_d6fd5eab = guy[[guy.stealth.funcs[# "should_hunt"]]]();
      }

      if(var_d6fd5eab) {
        guy stealth_enemy::bt_set_stealth_state("hunt", undefined);
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

  first_lost = undefined;

  while(true) {
    hunters = [];

    foreach(group in level.stealth.groupdata.groups) {
      if(isDefined(group.pods)) {
        foreach(pod in group.pods) {
          if(isDefined(pod.state) && pod.state == 2) {
            foreach(hunter in pod.members) {
              array::add(hunters, hunter);
            }
          }
        }
      }
    }

    if(hunters.size < 1) {
      break;
    }

    if(hunters.size > 1) {
      hunters = arraysortclosest(hunters, getplayers()[0].origin);

      if(!is_true(hunters[0].ignoreall)) {
        leader = hunters[0];
        arrayremovevalue(hunters, leader);
        wait randomfloatrange(2, 2.5);
        function_1eaaceab(hunters);
        hunters = arraysortclosest(hunters, getplayers()[0].origin);
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

        array::add(hunters, leader);
        hunter thread namespace_979752dc::function_f5f4416f("stealth", "hunt", "lost_sight", undefined, undefined, 1);
      }
    } else {
      hunter = hunters[0];

      if(!is_true(hunter.ignoreall)) {
        if(!isDefined(first_lost)) {
          first_lost = 1;
          hunter thread namespace_979752dc::function_f5f4416f("stealth", "hunt", "first_lost");
        } else {
          hunter thread namespace_979752dc::function_f5f4416f("stealth", "hunt", "lost_sight");
        }
      }
    }

    wait randomintrange(10, 15);
  }

  level.bcs_stealthhuntthink = undefined;
}

function group_assigntocombatpod(groupdata, guy) {
  group_removefrompod(groupdata, guy);

  foreach(pod in groupdata.pods) {
    if(pod.state == 3) {
      addtopod(pod, guy);
      return false;
    }
  }

  newpod = makenewpod(groupdata, 3, undefined);
  addtopod(newpod, guy);
  newpod thread pod_combat_update_checklosttarget();
  newpod thread pod_combat_periodicping();
  return true;
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

function group_eventcombat(groupname, guy, target) {
  var_23fa0e2d = getgroup(groupname);
  targetpos = undefined;

  if(isDefined(target)) {
    targetpos = target.origin;
  }

  pod = group_findpod(var_23fa0e2d, guy);
  group_assigntocombatpod(var_23fa0e2d, guy);
  var_23fa0e2d thread group_delayedcombatpropagation(2, guy, target, targetpos);
  var_23fa0e2d thread group_delayedcombatpropagationfromhunt(3, guy, target, targetpos);
}

function group_delayedcombatpropagationfromhunt(delaytime, guy, target, targetpos) {
  wait delaytime;

  if(!isDefined(guy) || !isalive(guy) || is_true(guy.in_melee_death)) {
    return;
  }

  if(!isDefined(target)) {
    return;
  }

  guy endon(#"death");
  target endon(#"death");
  var_5bc0b0ef = sqr(99999);

  foreach(groupdata in level.stealth.groupdata.groups) {
    var_760c584d = arraysort(groupdata.members, guy.origin);

    foreach(otherguy in var_760c584d) {
      if(!isDefined(otherguy)) {
        continue;
      }

      if(guy == otherguy) {
        continue;
      }

      pod = group_findpod(groupdata, otherguy);

      if(!isDefined(pod)) {
        continue;
      }

      if(pod.state == 1 || pod.state == 2 && isDefined(pod.target) && pod.target == target) {
        if(guy.script_stealthgroup == otherguy.script_stealthgroup || distancesquared(guy.origin, otherguy.origin) < var_5bc0b0ef) {
          otherguy getenemyinfo(target);
          otherguy function_a3fcf9e0("combat", target, targetpos);

          stealth_debug::function_65b21ab8(otherguy, "<dev string:x142>");

          wait 0.5;
        }
      }
    }
  }
}

function group_delayedcombatpropagation(delaytime, guy, target, targetpos) {
  initialwait = float(function_60d95f53()) / 1000 * 2;
  wait initialwait;

  if(is_true(guy.stealth.reacting)) {
    guy waittill(#"hash_22ca87c523f21d6d");
  }

  if(delaytime > initialwait) {
    wait delaytime - initialwait;
  }

  var_91239be5 = sqr(99999);

  if(!isDefined(guy) || !isalive(guy) || is_true(guy.in_melee_death)) {
    return;
  }

  guy endon(#"death");
  self.bcoverhasbeenblown = 1;
  level notify(#"cover_blown");

  foreach(groupdata in level.stealth.groupdata.groups) {
    var_760c584d = arraysort(groupdata.members, guy.origin);

    foreach(otherguy in var_760c584d) {
      if(!isalive(otherguy)) {
        continue;
      }

      if(guy == otherguy) {
        continue;
      }

      var_b288ad4a = 0;
      var_3f01ab8a = 0;
      pod = group_findpod(groupdata, otherguy);

      if(isDefined(pod) && pod.state == 3) {
        continue;
      }

      if(isDefined(target)) {
        if(otherguy cansee(target)) {
          var_b288ad4a = 1;
          var_3f01ab8a = 1;

          stealth_debug::function_65b21ab8(otherguy, "<dev string:x158>");
        }
      }

      if(!var_b288ad4a && otherguy cansee(guy)) {
        var_b288ad4a = 1;

        stealth_debug::function_65b21ab8(otherguy, "<dev string:x16a>");
      }

      if(!var_b288ad4a && distancesquared(otherguy.origin, guy.origin) < var_91239be5 && (!false || otherguy util::has_tac_vis(guy))) {
        var_b288ad4a = 1;

        if(isDefined(target)) {
          var_3f01ab8a = 1;
        }

        stealth_debug::function_65b21ab8(otherguy, "<dev string:x18e>");
      }

      if(var_3f01ab8a) {
        otherguy getenemyinfo(target);
      }

      if(var_b288ad4a) {
        if(isDefined(target)) {
          otherguy function_a3fcf9e0("combat", target, targetpos);
        } else {
          otherguy function_a3fcf9e0("combat", guy, guy.origin);
        }

        wait 0.5;
      }
    }
  }
}

function pod_settocombat(var_3f01ab8a, enemy) {
  assert(!var_3f01ab8a || isDefined(enemy));
  localmembers = self.members;

  foreach(guy in localmembers) {
    if(var_3f01ab8a) {
      guy getenemyinfo(enemy);
    }

    guy function_a3fcf9e0("combat", enemy, enemy.origin);
  }
}

function groups_combat_checklosttarget() {
  level notify(#"hash_231bf1036978b7d8");
  level endon(#"hash_231bf1036978b7d8");
  waitframe(1);

  while(is_true(level.stealth.var_ffa24aff)) {
    var_3b124a7f = [];
    var_2f7e139f = 1;

    foreach(groupdata in level.stealth.groupdata.groups) {
      foreach(pod in groupdata.pods) {
        if(pod.state == 3) {
          var_3b124a7f[var_3b124a7f.size] = pod;

          if(!isDefined(pod.bchecklosttarget) || !pod pod_haslostenemy()) {
            var_2f7e139f = 0;
            break;
          }
        }
      }

      if(!var_2f7e139f) {
        break;
      }
    }

    if(var_2f7e139f) {
      foreach(var_49201461 in var_3b124a7f) {
        arrayremovevalue(var_49201461.members, undefined);

        if(var_49201461.members.size > 0) {
          var_62ac8068 = var_49201461.members[0];
          var_62ac8068 namespace_979752dc::group_flag_set("stealth_combat_hunting");
          var_49201461 pod_settohunt();
        }

        wait randomfloatrange(0.5, 1);
      }

      return;
    }

    wait 2;
  }
}

function pod_combat_update_checklosttarget() {
  self endon(#"state_change");
  wait 5;

  if(!self pod_haslostenemy() && isDefined(level.stealth.funcs) && isDefined(level.stealth.funcs[# "call_backup"])) {
    self thread[[level.stealth.funcs[# "call_backup"]]]();
  }

  if(!is_true(level.stealth.var_ffa24aff)) {
    return;
  }

  self.bchecklosttarget = 1;
  level thread groups_combat_checklosttarget();
}

function pod_haslostenemy() {
  ctimetolose = 10000;
  var_36307b39 = 20000;
  var_e7b5c776 = 15000;
  cstillrighttheredistsq = 50625;
  curtime = gettime();
  var_2f31a4a5 = undefined;

  foreach(guy in self.members) {
    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs[# "hash_6fc6e860faaf2da5"])) {
      return guy[[guy.stealth.funcs[# "hash_6fc6e860faaf2da5"]]]();
    }

    enemy = guy.enemy;

    if(isDefined(enemy) && issentient(enemy) && isalive(enemy)) {
      if(enemy.team != "allies") {
        return 0;
      }

      lasttime = guy lastknowntime(enemy);

      if(curtime < lasttime + ctimetolose) {
        return 0;
      }

      lastknownpostoenemy = guy lastknownpos(enemy);

      if(curtime < lasttime + var_36307b39 && distancesquared(enemy.origin, lastknownpostoenemy) < cstillrighttheredistsq) {
        return 0;
      }

      if(curtime < lasttime + var_e7b5c776 && enemy util::has_tac_vis(lastknownpostoenemy)) {
        return 0;
      }

      if(isDefined(self.benemyinlowcover)) {
        return 0;
      }

      continue;
    }

    if(!isDefined(guy.enemy) && guy flag::exists("in_the_dark") && guy flag::get("in_the_dark") && curtime - guy.lastenemysighttime < ctimetolose) {
      return 0;
    }
  }

  return 1;
}

function pod_isclosetoanymembers(otherguy, radius, var_2c0664ad) {
  if(!var_2c0664ad) {
    var_2c0664ad = 0;
  }

  radiussq = radius * radius;
  function_1eaaceab(self.members);

  foreach(guy in self.members) {
    if(distancesquared(otherguy.origin, guy.origin) > radiussq) {
      continue;
    }

    if(var_2c0664ad && !otherguy util::has_tac_vis(guy)) {
      continue;
    }

    return true;
  }

  return false;
}

function pod_combat_periodicping() {
  self endon(#"state_change");
  var_69617fed = 1;
  var_26031df0 = 384;
  wait var_69617fed;

  while(true) {
    foreach(group in level.stealth.groupdata.groups) {
      foreach(guy in group.members) {
        if(guy.stealth.bsmstate == 3 || guy.stealth.bsmstate == 2) {
          continue;
        }

        if(self pod_isclosetoanymembers(guy, var_26031df0, 1)) {
          stealth_debug::function_65b21ab8(guy, "<dev string:x1a9>");

          guy function_a3fcf9e0("combat", guy, guy.origin);
        }
      }
    }

    wait var_69617fed;
  }
}

function pod_settohunt() {
  self thread function_b921795f();
}

function private function_b921795f() {
  self notify(#"pod_settohunt");
  self endon(#"pod_settohunt");
  localmembers = arraycopy(self.members);
  localmembers = arraysortclosest(localmembers, level.players[0].origin);

  foreach(guy in localmembers) {
    if(!isalive(guy)) {
      continue;
    }

    var_d6fd5eab = 1;

    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs[# "should_hunt"])) {
      var_d6fd5eab = guy[[guy.stealth.funcs[# "should_hunt"]]]();
    }

    if(!var_d6fd5eab) {
      guy stealth_enemy::bt_set_stealth_state("idle", undefined);
      continue;
    }

    guy stealth_enemy::bt_set_stealth_state("hunt", undefined);
    wait randomfloatrange(0.5, 1);
  }
}

function pod_settoidle() {
  foreach(guy in self.members) {
    guy function_a3fcf9e0("reset", guy, guy.origin);
  }
}

function pod_isleader(guy) {
  groupdata = getgroup(guy.script_stealthgroup);
  pod = group_findpod(groupdata, guy);

  if(!isDefined(pod)) {
    return false;
  }

  assert(pod.members.size > 0);
  return pod.members[0] == guy;
}

function pod_getclosestguy(pos) {
  closestguy = undefined;
  closestdistsq = 99999999;

  foreach(guy in self.members) {
    if(!isDefined(guy)) {
      continue;
    }

    distsq = distancesquared(guy.origin, pos);

    if(!isDefined(closestguy) || distsq < closestdistsq) {
      closestguy = guy;
      closestdistsq = distsq;
    }
  }

  return closestguy;
}

function pod_delete() {
  self notify(#"state_change");
  assert(isDefined(self.parentgroup));
  assert(self.members.size == 0);
  groupdata = self.parentgroup;
  numpods = groupdata.pods.size;

  for(ipod = 0; ipod < numpods; ipod++) {
    if(groupdata.pods[ipod] == self) {
      var_542fc63d = groupdata.pods.size - 1;
      groupdata.pods[ipod] = groupdata.pods[var_542fc63d];
      groupdata.pods[var_542fc63d] = undefined;
      break;
    }
  }
}