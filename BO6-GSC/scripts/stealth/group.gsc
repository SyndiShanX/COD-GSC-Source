/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\group.gsc
**************************************/

#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#namespace group;

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
    mygroup = stealthinitgroup(groupname);
    groupdata.groups[groupname] = mygroup;
  }

  level.stealth.groupdata notify(groupname);
}

function addtogroup(groupname, guy) {
  if(!(isDefined(level.stealth.groupdata.groups) && isDefined(level.stealth.groupdata) && isDefined(level.stealth.groupdata.groups[groupname]))) {
    initgroup(groupname);
  }

  mygroup = level.stealth.groupdata.groups[groupname];
  stealthaddtogroup(groupname, guy);
  mygroup thread group_waitfordeath(guy);
}

function group_waitfordeath(guy) {
  guy waittill("\x1e\xfd\xd1\xa2\a");
  guy thread enemy::death_cleanup();

  if(isDefined(guy)) {
    function_c5f8c2ecb1d5465e(self.name, guy);
  }
}

function getgroup(groupname) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.groupdata));
  assert(isDefined(level.stealth.groupdata.groups));
  return level.stealth.groupdata.groups[groupname];
}

function pod_hunt_update(squadid) {
  pod = spawnStruct();
  pod.squadid = squadid;
  pod thread function_78edee1369eea026();
}

function function_4818d30355f241ad(guy) {
  clookaheaddist = 48;
  var_e3b68564fe8a0a91 = 5000;

  if(!isDefined(guy) || !isalive(guy)) {
    return false;
  }

  if(isDefined(self.jobs[guy getentitynumber()])) {
    return false;
  }

  if(isDefined(guy.pathgoalpos) && guy pathdisttogoal(1) < clookaheaddist) {
    return false;
  }

  if(guy asm_bb::bb_playsmartobjectrequested()) {
    return false;
  }

  if(isDefined(guy.stealth.var_b8d4c388c5876f73) && gettime() - guy.stealth.var_b8d4c388c5876f73 < var_e3b68564fe8a0a91) {
    return false;
  }

  return true;
}

function function_78edee1369eea026() {
  var_da628f7a9f5608b7 = 262144;

  if(!isDefined(self.jobs)) {
    self.jobs = [];
  }

  jobid = 0;

  while(true) {
    if(!isDefined(self.squadid)) {
      return;
    }

    members = aigetsquadmembers(self.squadid);

    if(!isDefined(members) || members.size == 0) {
      return;
    }

    for(i = 0; i < members.size; i++) {
      guy = members[i];

      if(utility::is_dead_or_dying(guy) || !function_4818d30355f241ad(guy)) {
        continue;
      }

      entnum = guy getentitynumber();
      guylookaheaddir = guy.lookaheaddir;

      for(j = i + 1; j < members.size; j++) {
        otherguy = members[j];

        if(!isDefined(otherguy) || !isalive(otherguy)) {
          continue;
        }

        if(utility::is_dead_or_dying(otherguy)) {
          continue;
        }

        otherentnum = otherguy getentitynumber();

        if(distancesquared(guy.origin, otherguy.origin) < var_da628f7a9f5608b7) {
          if(!function_4818d30355f241ad(otherguy)) {
            continue;
          }

          otherguylookaheaddir = otherguy.lookaheaddir;
          var_586165aafb3dabba = vectorNormalize(otherguy.origin - guy.origin);

          if(vectordot(guylookaheaddir, var_586165aafb3dabba) < 0 && vectordot(guylookaheaddir, otherguylookaheaddir) < 0) {
            continue;
          }

          guypos = guy.origin;
          otherguypos = otherguy.origin;
          midpoint = (guypos + otherguypos) / 2;
          var_fc7ad9da82caf87a = vectorNormalize(midpoint - guy.origin);
          var_4ec584b9cd2cfac6 = vectorNormalize(midpoint - otherguy.origin);

          if(vectordot(var_fc7ad9da82caf87a, guylookaheaddir) < 0.5) {
            continue;
          }

          if(vectordot(var_4ec584b9cd2cfac6, otherguylookaheaddir) < 0.5) {
            continue;
          }

          if(guy hastacvis(otherguy) || otherguy hastacvis(guy)) {
            midpoint = guy getclosestreachablepointonnavmesh(midpoint);
            guypos = guy getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(guypos - midpoint));
            otherguypos = otherguy getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(otherguypos - midpoint));
            job = spawnStruct();
            job.guys = [];
            job.guys[job.guys.size] = guy;
            job.guys[job.guys.size] = otherguy;
            job.requestedpos = [];
            job.requestedpos[entnum] = guypos;
            job.requestedpos[otherentnum] = otherguypos;
            job.state[entnum] = "-7\xa5\xa3";
            job.state[otherentnum] = "-7\xa5\xa3";
            job.leader = guy;
            job.requesttime = gettime();
            job.id = jobid;
            self.jobs[otherentnum] = job;
            self.jobs[entnum] = job;
            childthread function_35da96e6dae74b26(job);
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

function function_96293b202eaecfa7(job) {
  self endon("CY\x1f\xa5\x1e(m\x1f#\xb7\xf9\xd5\x8b\xe5%+");
  self waittill("\x1c\xde\x8c\xaf\xa9\xf61\xeb,\x89\xbd\x93t");
  job.state[self getentitynumber()] = "\x7f5dI";
}

function function_35da96e6dae74b26(job) {
  status = "\xbb,-\x8e\xd7\xcc{\xc9\xbe\xb0N9-\x9dX\x8d";
  entnum1 = job.guys[0] getentitynumber();
  entnum2 = job.guys[1] getentitynumber();
  leader = job.leader;

  if(job.leader == job.guys[0]) {
    follower = job.guys[1];
  } else {
    follower = job.guys[0];
  }

  leader endon("\x1e\xfd\xd1\xa2\a");
  follower endon("\x1e\xfd\xd1\xa2\a");
  leader.gunposeoverride_internal = "&oq\xa3 \x15nk";
  follower.gunposeoverride_internal = "&oq\xa3 \x15nk";
  leader setlookatenabled(1);
  follower setlookatenabled(1);
  leader childthread function_96293b202eaecfa7(job);
  follower childthread function_96293b202eaecfa7(job);
  leader endon("\x1c\xde\x8c\xaf\xa9\xf61\xeb,\x89\xbd\x93t");
  follower endon("\x1c\xde\x8c\xaf\xa9\xf61\xeb,\x89\xbd\x93t");
  state1 = "";
  state2 = "";
  leader utility::delaycall(randomfloatrange(0.2, 1), &setlookatentity, follower, 0);
  follower utility::delaycall(randomfloatrange(0.2, 1), &setlookatentity, leader, 0);

  while(true) {
    if(!isDefined(job.guys[0]) || !isalive(job.guys[0])) {
      break;
    }

    if(!isDefined(job.guys[1]) || !isalive(job.guys[1])) {
      break;
    }

    guy1 = job.guys[0];
    guy2 = job.guys[1];

    if(status == "\xbb,-\x8e\xd7\xcc{\xc9\xbe\xb0N9-\x9dX\x8d") {
      if(state1 != "X\x93\xc9i;\xac\x8c" && !isDefined(guy1.pathgoalpos)) {
        state1 = "X\x93\xc9i;\xac\x8c";
        job.state[entnum1] = "/\xc8,\r";
      }

      if(state2 != "X\x93\xc9i;\xac\x8c" && !isDefined(guy2.pathgoalpos)) {
        state2 = "X\x93\xc9i;\xac\x8c";
        job.state[entnum2] = "/\xc8,\r";
      }

      if(state1 == "X\x93\xc9i;\xac\x8c" && state2 == "X\x93\xc9i;\xac\x8c") {
        status = "\xd7\xd8\xae\xb6\x0ea\xab";
      }
    }

    if(status == "\xd7\xd8\xae\xb6\x0ea\xab") {
      job.state[leader getentitynumber()] = "\xd7\xd8\xae\xb6\x0ea\xab";
      leader hunt_waitforgesture("\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");

      if(!isDefined(leader) || !isalive(leader)) {
        break;
      }

      job.state[leader getentitynumber()] = "/\xc8,\r";
      job.state[follower getentitynumber()] = "\xd7\xd8\xae\xb6\x0ea\xab";
      follower hunt_waitforgesture("\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");

      if(!isDefined(follower) || !isalive(follower)) {
        break;
      }

      job.state[follower getentitynumber()] = "/\xc8,\r";
      status = "\xb1ok\ac\xb2\xd1V";
    }

    if(status == "\xb1ok\ac\xb2\xd1V") {
      job.state[entnum1] = "\x7f5dI";
      job.state[entnum2] = "\x7f5dI";
      break;
    }

    waitframe();
  }

  leader notify("CY\x1f\xa5\x1e(m\x1f#\xb7\xf9\xd5\x8b\xe5%+");
  follower notify("CY\x1f\xa5\x1e(m\x1f#\xb7\xf9\xd5\x8b\xe5%+");
}

function hunt_waitforgesture(flag) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x12\xb0x\xf2Z/Gz\xb9W\x14\xce\v~ \x94\xf6\xf3c\x9e\x12\bQ\xf8\xbb ");
  self endon("\x85\xd6F[\xb4p>\xe7\x17\x7f\x19\x17\xf9\xe6\x15\xe9Qq\xf7K");
  childthread function_c3e5a54a4eafff27(10);

  while(true) {
    self waittill(flag, status);

    if(status == "\xc4\xc4Vbv\xf5&\xd8G<~UF\xb6" || status == "\x97\xe9\x15\x96\x1d\xe5\x1b\f3,\xa5&\x90\xf8") {
      break;
    }
  }
}

function function_c3e5a54a4eafff27(t) {
  wait t;
  self notify("\x85\xd6F[\xb4p>\xe7\x17\x7f\x19\x17\xf9\xe6\x15\xe9Qq\xf7K");
}

function function_8f107765e4a102f7(guy) {
  if(!isDefined(self.jobs)) {
    return;
  }

  return self.jobs[guy getentitynumber()];
}

function function_d57101a41c15a2f0(guy) {
  if(!isDefined(self.jobs)) {
    return;
  }

  self.jobs[guy getentitynumber()] = undefined;
}

function function_70a1ee36687b04f6(array) {
  callsigns = [];

  foreach(guy in array) {
    if(isDefined(guy.bccallsign)) {
      callsigns[callsigns.size] = guy.bccallsign;
    }
  }

  return callsigns;
}

function pod_hunt_vo() {
  if(isDefined(level.bcs_stealthhuntthink)) {
    return;
  }

  level.bcs_stealthhuntthink = 1;

  if(!isDefined(level.var_d9cf56fb8c5519d4)) {
    level.var_d9cf56fb8c5519d4 = [6, 12];
  }

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
          hunters[hunters.size] = hunter;
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
        hunters = utility::array_randomize(hunters);
      }

      hunters[0].battlechatter.huntgroup = hunters;
      leader = hunters[0];
      hunters = arrayremove(hunters, leader);
      wait randomfloatrange(2, 2.5);
      hunters = utility::array_removedead_or_dying(hunters);

      if(utility::issp()) {
        hunters = sortbydistance(hunters, level.player.origin);
      } else {
        hunters = utility::array_randomize(hunters);
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

      hunters[hunters.size] = leader;
      hunter.battlechatter.huntgroup = hunters;
    } else {
      hunter = hunters[0];

      if(!isDefined(first_lost)) {}
    }

    if(isarray(level.var_d9cf56fb8c5519d4)) {
      wait randomfloatrange(level.var_d9cf56fb8c5519d4[0], level.var_d9cf56fb8c5519d4[1]);
      continue;
    }

    wait level.var_d9cf56fb8c5519d4;
  }

  level.bcs_stealthhuntthink = undefined;
}