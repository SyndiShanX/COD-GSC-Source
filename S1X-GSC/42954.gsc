/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42954.gsc
**************************************/

initstart() {
  level.orbital_util_remote_traces_frame = 0;
  level.orbital_util_remote_traces = 5;
  level.orbital_util_capsule_traces_frame = 0;
  level.orbital_util_capsule_traces = 5;
  level.orbital_util_last_trace = 0;
  level thread deletemapremotemissileclip();
  level.orbital_util_covered_volumes = getEntArray("orbital_node_covered", "targetname");
}

deletemapremotemissileclip() {
  var_0 = getEntArray("carepackage_clip", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

playergetoutsidenode(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "goliath";
  }

  var_1 = playergetnodelookingat(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  self.lastnodelookingattrace = undefined;
  return var_1;
}

playergetorbitalstartpos(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "goliath";
  }

  var_2 = maps\mp\killstreaks\_aerial_utility::getentorstructarray("remoteMissileSpawn", "targetname");
  var_3 = nodegetremotemissileorigin(var_0, var_2, var_1);

  if(isDefined(var_3)) {
    return var_3;
  } else {
    return nodegetremotemissileorgfromabove(var_0);
  }
}

getstartpositionabove(var_0) {
  return var_0.origin + (0, 0, 24000);
}

adddropmarker(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "goliath";
  }

  var_0.orbitaltype = var_1;
  level.orbitaldropmarkers[level.orbitaldropmarkers.size] = var_0;
  thread _adddropmarkerinternal(var_0);
}

playerplayinvalidpositioneffect(var_0) {
  var_1 = self.lastnodelookingattrace;
  var_2 = self.lastnearestnode;

  if(!isDefined(var_1)) {
    var_3 = anglesToForward(self getangles());
    var_4 = self getEye();
    var_5 = var_4 + var_3 * 500;
    var_1 = bulletTrace(var_4, var_5, 0, self, 1, 0, 0, 0, 0);
  }

  self.lastnodelookingattrace = undefined;
  self.lastnearestnode = undefined;
  var_6 = var_1["position"];

  if(isDefined(var_2)) {
    var_7 = var_1["normal"];
    var_8 = var_7[2] > 0.8;

    if(!var_8) {
      var_6 = var_2.origin;
    }
  }

  var_9 = spawn("script_model", var_6 + (0, 0, 5));
  var_9.angles = (-90, 0, 0);
  var_9 setModel("tag_origin");
  var_9 hide();
  var_9 showtoplayer(self);
  playFXOnTag(var_0, var_9, "tag_origin");
  wait 5;
  var_9 delete();
}

playergetnodelookingat(var_0) {
  var_1 = anglesToForward(self getangles());
  var_2 = self getEye();
  var_3 = var_2 + var_1 * 500;
  var_4 = bulletTrace(var_2, var_3, 0, self, 1, 0, 0, 0, 0);
  self.lastnodelookingattrace = var_4;
  var_5 = var_4["fraction"] == 1;

  if(var_5) {
    return playergetnearestnode(undefined, var_0);
  }

  var_6 = var_4["position"];
  var_7 = getnodesinradius(var_6, 128, 0, 60);
  var_8 = var_7.size == 0;

  if(var_8) {
    return playergetnearestnode(undefined, var_0);
  }

  var_9 = var_4["normal"];
  var_10 = var_9[2] > 0.8;

  if(!var_10) {
    return playergetnearestnode(var_6, var_0);
  }

  if(orbitalbadlandingcheck(var_6)) {
    return playergetnearestnode(var_6, var_0);
  }

  if(var_0 == "goliath") {
    if(goliathbadlandingcheck(var_6)) {
      return playergetnearestnode(var_6, var_0);
    }
  }

  var_11 = carepackagetrace(var_6, self, var_0);

  if(!var_11) {
    return playergetnearestnode(var_6, var_0);
  }

  if(groundpositionoffedge(var_6, var_0)) {
    return playergetnearestnode(var_6, var_0);
  }

  var_13 = spawnStruct();
  var_13.origin = var_6;
  var_14 = maps\mp\killstreaks\_aerial_utility::getentorstructarray("remoteMissileSpawn", "targetname");
  var_15 = nodegetremotemissileorigin(var_13, var_14, var_0);

  if(!isDefined(var_15)) {
    return playergetnearestnode(var_6, var_0);
  }

  return var_13;
}

groundpositionoffedge(var_0, var_1) {
  if(var_1 == "goliath") {
    var_2 = 41;
  } else {
    var_2 = 26;
  }

  var_3 = (var_2, 0, 0);
  var_4 = -1 * var_3;
  var_5 = (0, var_2, 0);
  var_6 = -1 * var_5;
  var_7 = (0, 0, -10);
  var_8 = [var_3, var_4, var_5, var_6];

  foreach(var_10 in var_8) {
    var_11 = var_0 + var_10;
    var_12 = var_0 + var_10 + var_7;
    var_13 = bullettracepassed(var_11, var_12, 0, undefined);

    if(var_13) {
      return 1;
    }
  }

  return 0;
}

_nodefindnewremotemissileorg(var_0, var_1, var_2) {
  var_3 = nodefindremotemissleent(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    return nodegetremotemissleentorg(var_0, var_1);
  }

  var_4 = nodetestfirefromabove(var_0, var_2);

  if(isDefined(var_4)) {
    return nodegetremotemissileorgfromabove(var_0);
  } else {}
}

nodegetremotemissileorigin(var_0, var_1, var_2) {
  if(nodehasremotemissiledataset(var_0)) {
    if(!nodeisremotemissilefromabove(var_0)) {
      return nodegetremotemissleentorg(var_0, var_1);
    } else {
      return nodegetremotemissileorgfromabove(var_0);
    }
  } else {
    return _nodefindnewremotemissileorg(var_0, var_1, var_2);
  }
}

nodeispathnode(var_0) {
  return isDefined(var_0.type);
}

nodeisremotemissilefromabove(var_0) {
  return nodeispathnode(var_0) && nodehasremotemissileset(var_0) && nodegetremotemissilename(var_0) == "up" || isDefined(var_0.bestmissilespawnabove);
}

nodehasremotemissiledataset(var_0) {
  return nodeispathnode(var_0) && nodehasremotemissileset(var_0) || (isDefined(var_0.bestmissilespawnabove) || isDefined(var_0.bestmissilespawn));
}

nodegetremotemissileorgfromabove(var_0) {
  return getstartpositionabove(var_0);
}

nodetestfirefromabove(var_0, var_1) {
  var_2 = getstartpositionabove(var_0);
  var_3 = remotemissileenttracetooriginpassedwrapper(var_2, var_0.origin, var_1);

  if(var_3) {
    var_0.bestmissilespawnabove = var_2;
    return var_2;
  }
}

nodegetremotemissleentorg(var_0, var_1) {
  var_2 = undefined;

  if(nodeispathnode(var_0) && nodehasremotemissileset(var_0)) {
    var_3 = nodegetremotemissilename(var_0);

    foreach(var_5 in var_1) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_3) {
        var_2 = var_5;
      }
    }
  } else if(isDefined(var_0.bestmissilespawn)) {
    var_2 = var_0.bestmissilespawn;
  }

  var_7 = vectornormalize(var_2.origin - var_0.origin);
  return var_0.origin + var_7 * 24000;
}

nodefindremotemissleent(var_0, var_1, var_2) {
  var_1 = sortbydistance(var_1, var_0.origin);

  foreach(var_4 in var_1) {
    var_5 = remotemissileenttracetooriginpassedwrapper(var_4.origin, var_0.origin, var_2);

    if(var_5) {
      var_0.bestmissilespawn = var_4;
      return var_4;
    }

    waitframe();
  }
}

remotemissileenttracetooriginpassedwrapper(var_0, var_1, var_2) {
  if(level.orbital_util_remote_traces_frame != gettime()) {
    level.orbital_util_remote_traces_frame = gettime();
    level.orbital_util_remote_traces = 5;
  }

  if(level.orbital_util_remote_traces <= 0) {
    if(level.orbital_util_last_trace != gettime()) {
      waitframe();
      level.orbital_util_last_trace = gettime();
    }

    level.orbital_util_remote_traces = 5;
  }

  level.orbital_util_remote_traces--;
  var_3 = 26;

  if(var_2 == "goliath") {
    var_3 = 41;
  }

  return remotemissileenttracetooriginpassed(var_0, var_1, var_3, 1);
}

nodecanhitground(var_0, var_1) {
  if(orbitalbadlandingcheck(var_0.origin)) {
    return 0;
  }

  if(isDefined(var_1) && var_1 == "goliath") {
    if(goliathbadlandingcheck(var_0.origin)) {
      return 0;
    }
  }

  if(nodehasremotemissileset(var_0)) {
    return nodegetremotemissilename(var_0) != "none";
  } else {
    return nodeexposedtosky(var_0, 1);
  }
}

carepackagetrace(var_0, var_1, var_2) {
  var_3 = 100;

  if(var_2 == "goliath") {
    var_4 = 41;
  } else {
    var_4 = 26;
  }

  foreach(var_6 in level.orbitaldropmarkers) {
    var_7 = var_4;

    if(var_6.orbitaltype == "goliath") {
      var_7 = var_7 + 41;
    } else {
      var_7 = var_7 + 26;
    }

    var_8 = var_7 * var_7;
    var_9 = distance2dsquared(var_6.origin, var_0);

    if(var_9 < var_8) {
      return 0;
    }
  }

  if(level.orbital_util_capsule_traces_frame != gettime()) {
    level.orbital_util_capsule_traces_frame = gettime();
    level.orbital_util_capsule_traces = 5;
  }

  if(level.orbital_util_capsule_traces <= 0) {
    if(level.orbital_util_last_trace != gettime()) {
      waitframe();
      level.orbital_util_last_trace = gettime();
    }

    level.orbital_util_capsule_traces = 5;
  }

  level.orbital_util_capsule_traces--;
  return capsuletracepassed(var_0 + (0, 0, 6), var_4, var_4 * 2, var_1, 0);
}

playergetnearestnode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = 300;
    var_3 = self getEye();
    var_4 = anglesToForward(self.angles);
    var_5 = var_3 + var_4 * var_2;
    var_6 = bulletTrace(var_3, var_5, 0, self);
    var_0 = var_5;

    if(var_6["fraction"] < 1) {
      var_0 = var_3 + var_4 * var_2 * var_6["fraction"];
    }
  }

  var_7 = getclosestnodeinsight(var_0, 1);
  var_8 = isDefined(var_7);

  if(var_8) {
    var_8 = nodecanhitground(var_7, var_1) && carepackagetrace(var_7.origin, self, var_1);
  }

  if(var_8) {
    return var_7;
  }

  var_9 = spawnStruct();
  var_9.maxtracesperframe = 5;
  var_9.maxnodes = 20;
  var_9.numtraces = 5;
  playerfindnodeinfront(var_0, var_1, var_9);
  var_10 = var_9.nearestnode;

  if(isDefined(var_10)) {
    return var_10;
  }

  if(!isDefined(var_7)) {
    var_7 = playergetclosestnode(500, 100, self.origin, 0, 1, var_1);

    if(!isDefined(var_7)) {
      var_7 = playergetclosestnode(500, 0, self.origin, 0, 0, var_1);
    }

    if(!isDefined(var_7)) {
      var_7 = self getnearestnode();
    }
  }

  self.lastnearestnode = var_7;

  if(isDefined(var_7)) {
    return playerfindaltnode(var_7, var_1);
  }
}

orbitalbadlandingcheck(var_0) {
  if(isDefined(level.orbital_util_covered_volumes) && level.orbital_util_covered_volumes.size > 0) {
    var_1 = 0;

    foreach(var_3 in level.orbital_util_covered_volumes) {
      var_1 = ispointinvolume(var_0, var_3);

      if(var_1) {
        return 1;
      }
    }
  }

  return 0;
}

goliathbadlandingcheck(var_0) {
  if(isDefined(level.goliath_bad_landing_volumes)) {
    foreach(var_2 in level.goliath_bad_landing_volumes) {
      if(ispointinvolume(var_0, var_2)) {
        return 1;
      }
    }
  }

  return 0;
}

playerfindnodeinfront(var_0, var_1, var_2) {
  var_3 = 500;
  var_4 = 100;
  var_5 = playerfindnodeinfrontinternal(var_0, var_4, var_3, var_1, var_2);

  if(!isDefined(var_5) && var_2.maxnodes > 0) {
    var_4 = 0;
    var_5 = playerfindnodeinfrontinternal(var_0, var_4, var_3, var_1, var_2);
  }

  var_2.nearestnode = var_5;
}

playerfindnodeinfrontinternal(var_0, var_1, var_2, var_3, var_4) {
  while(var_1 < var_2 && var_4.maxnodes > 0) {
    var_5 = playergetclosestnode(var_2, var_1, var_0, 1, 1, var_3);

    if(var_4.numtraces <= 0 && !tracedonerecently()) {
      waitframe();
      var_4.numtraces = var_4.maxtracesperframe;
    }

    if(isDefined(var_5)) {
      var_4.numtraces--;
      var_4.maxnodes--;
      var_6 = self getEye();
      var_7 = var_5.origin + (0, 0, 6);
      var_8 = bulletTrace(var_6, var_7, 0, self);
      var_9 = var_8["fraction"] == 1 && carepackagetrace(var_5.origin, self, var_3);

      if(var_9) {
        return var_5;
      }

      var_1 = distance(var_0, var_5.origin) + 1;
      continue;
    }

    var_1 = var_2 + 1;
  }
}

playerfindaltnode(var_0, var_1) {
  var_2 = checknodestart(var_0, self, var_1);

  if(isDefined(var_2)) {
    if(orbitalbadlandingcheck(var_2.origin)) {
      return undefined;
    }

    if(var_1 == "goliath") {
      if(goliathbadlandingcheck(var_2.origin)) {
        return undefined;
      }
    }

    return var_2;
  }
}

tracedonerecently() {
  return level.orbital_util_last_trace == gettime();
}

checknodestart(var_0, var_1, var_2) {
  var_3 = 250000;
  var_4 = 20;
  var_0.linkdistance = 0;
  var_0.nodechecked = 1;
  var_5 = spawnStruct();
  var_5.nodestocheck = [];
  var_5.nodeschecked = [];
  var_5.nodeschecked["" + var_0 getnodenumber()] = var_0;
  var_5.nextnodes = getlinkednodes(var_0, 1);
  addnodestobechecked(var_5, 1, var_0, var_3, var_1, var_2);
  var_6 = 0;

  for(;;) {
    var_7 = getnextnode(var_5);

    if(isDefined(var_7)) {
      var_6++;

      if(!carepackagetrace(var_7.origin, var_1, var_2)) {
        var_7.nodechecked = 1;
        var_5.nodestocheck["" + var_7 getnodenumber()] = undefined;
        var_5.nodeschecked["" + var_7 getnodenumber()] = var_7;
        var_8 = var_7.linkdistance + 1;

        if(var_8 <= 6) {
          var_5.nextnodes = getlinkednodes(var_7, 1);
          addnodestobechecked(var_5, var_8, var_7, var_3, var_1, var_2);
        }
      } else {
        cleanupnodefields(var_5);
        return var_7;
      }
    } else {
      cleanupnodefields(var_5);
      return;
    }

    if(var_6 >= var_4) {
      if(!tracedonerecently()) {
        waitframe();
      }

      var_6 = 0;
    }
  }
}

cleanupnodefields(var_0) {
  foreach(var_2 in var_0.nodestocheck) {
    var_2.linkdistance = undefined;
    var_2.nodechecked = undefined;
  }

  foreach(var_2 in var_0.nodeschecked) {
    var_2.linkdistance = undefined;
    var_2.nodechecked = undefined;
  }
}

getnextnode(var_0) {
  if(var_0.nodestocheck.size == 0) {
    return;
  }
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getarraykeys(var_0.nodestocheck);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0.nodestocheck[var_3[var_4]];

    if(!isDefined(var_1) || var_5.linkdistance < var_2) {
      var_1 = var_5;
      var_2 = var_5.linkdistance;
    }
  }

  return var_1;
}

addnodestobechecked(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.nextnodes.size; var_6++) {
    var_7 = var_0.nextnodes[var_6];

    if(!isDefined(var_7.nodechecked)) {
      var_8 = nodecanhitground(var_7, var_5);

      if(var_8) {
        var_9 = distancesquared(var_7.origin, var_4.origin);
        var_8 = var_9 < var_3;
      }

      if(!var_8) {
        var_7.nodechecked = 1;
        var_0.nodeschecked["" + var_7 getnodenumber()] = var_7;
      } else if(!isDefined(var_7.linkdistance)) {
        var_7.linkdistance = var_1;
        var_0.nodestocheck["" + var_7 getnodenumber()] = var_7;
      } else if(var_7.linkdistance > var_1) {
        var_7.linkdistance = var_1;
      }
    }
  }
}

playergetclosestnode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = 1500;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = self.origin;
  }

  var_6 = 100;
  var_7 = var_1;
  var_8 = var_1 + var_6;

  if(var_8 > var_0) {
    var_8 = var_0;
  }

  while(var_8 <= var_0 && var_7 < var_0) {
    var_9 = playergetclosestnodeinternal(var_8, var_7, var_2, var_3, var_4, var_5);

    if(isDefined(var_9)) {
      return var_9;
    }

    var_7 = var_7 + var_6;
    var_8 = var_8 + var_6;

    if(var_8 > var_0) {
      var_8 = var_0;
    }
  }
}

playergetclosestnodeinternal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = getnodesinradiussorted(var_2, var_0, var_1, 120, "path");

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    if(var_3) {
      var_6 = var_6 &nodecanhitground(var_7[var_8], var_5);
    }

    if(var_4) {
      var_6 = var_6 &playerwithinfov2d(var_7[var_8].origin);
    }

    if(var_6) {
      return var_7[var_8];
    }
  }
}

playerwithinfov2d(var_0) {
  var_1 = cos(60);
  var_2 = vectornormalize((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  var_3 = anglesToForward((0, self.angles[1], 0));
  return vectordot(var_3, var_2) >= var_1;
}

_adddropmarkerinternal(var_0) {
  var_0 waittill("death");
  level.orbitaldropmarkers = common_scripts\utility::array_remove(level.orbitaldropmarkers, var_0);
}

nodesetremotemissilenamewrapper(var_0, var_1) {
  var_2 = getnodesinradiussorted(var_0, 24, 0);

  if(var_2.size > 0) {
    var_3 = var_2[0];
    nodesetremotemissilename(var_3, var_1);
  } else {}
}