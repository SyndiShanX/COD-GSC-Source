/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4c543f01345a2c04.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\engine\utility;
#namespace namespace_7d1d1a833a0da9d8;

function function_935d676c39ba68a3() {
  scripts\engine\utility::registersharedfunc("zombie_entity", "AddIslandLocations", &function_82600aacebeb4997);
  scripts\engine\utility::registersharedfunc("zombie_entity", "AddIslandLocationsFromStruct", &function_55ffc022b2bb4432);
  scripts\engine\utility::registersharedfunc("zombie_entity", "AddIslandLocationsFromStructString", &function_4b66a2a4ea6c8acb);
  scripts\engine\utility::registersharedfunc("zombie_entity", "AddTeleportLocationsFromStruct", &function_f9cfcbdfbe9d4638);
  scripts\engine\utility::registersharedfunc("zombie_entity", "AddTeleportLocationsFromStructString", &function_ee59a4d25c6c6801);
  scripts\engine\utility::registersharedfunc("zombie_entity", "SetupOrbSpawns", &function_ee81bcd0f7070e2e);
  scripts\engine\utility::registersharedfunc("zombie_entity", "GetClosestOrbSpawn", &function_6790e7673398d475);
  scripts\engine\utility::registersharedfunc("zombie_entity", "KillAllZombies", &function_e81685afe57277af);
}

function function_82600aacebeb4997(origin, angles, radius) {
  var_6b244110df1fa279 = spawnStruct();
  var_6b244110df1fa279.origin = origin;
  var_6b244110df1fa279.angles = angles;
  var_6b244110df1fa279.radius = radius;

  if(!isDefined(self.entitydata.islandlocations)) {
    self.entitydata.islandlocations = [];
  }

  if(isDefined(var_6b244110df1fa279)) {
    self.entitydata.islandlocations[self.entitydata.islandlocations.size] = var_6b244110df1fa279;
  }
}

function function_55ffc022b2bb4432(var_6b244110df1fa279) {
  if(!isDefined(self.entitydata.islandlocations)) {
    self.entitydata.islandlocations = [];
  }

  if(isDefined(var_6b244110df1fa279)) {
    self.entitydata.islandlocations[self.entitydata.islandlocations.size] = var_6b244110df1fa279;
  }
}

function function_4b66a2a4ea6c8acb(var_8a781bd189f40a64) {
  var_6b244110df1fa279 = getStruct(var_8a781bd189f40a64, "targetname");

  if(isDefined(var_6b244110df1fa279)) {
    var_e98ecb0e8f990265 = getStructArray(var_8a781bd189f40a64, "script_noteworthy");

    if(isDefined(var_e98ecb0e8f990265) && var_e98ecb0e8f990265.size > 0) {
      var_6b244110df1fa279.var_e98ecb0e8f990265 = var_e98ecb0e8f990265;
    }

    function_55ffc022b2bb4432(var_6b244110df1fa279);
  }
}

function function_f9cfcbdfbe9d4638(phaseindex, teleportlocation) {
  if(!isDefined(self.phasedata[phaseindex])) {
    self.phasedata[phaseindex] = spawnStruct();
  }

  if(!isDefined(self.phasedata[phaseindex].var_8d5f6ee9e22c653e)) {
    self.phasedata[phaseindex].var_8d5f6ee9e22c653e = [];
  }

  if(isDefined(teleportlocation)) {
    var_65c64854f86704de = self.phasedata[phaseindex].var_8d5f6ee9e22c653e.size;
    self.phasedata[phaseindex].var_8d5f6ee9e22c653e[var_65c64854f86704de] = teleportlocation;
    self.phasedata[phaseindex].var_8d5f6ee9e22c653e[var_65c64854f86704de].index = var_65c64854f86704de;
  }
}

function function_ee59a4d25c6c6801(phaseindex, var_6c2b5937eaf033a4) {
  var_faedfa7b574a3cc = getStruct(var_6c2b5937eaf033a4, "targetname");

  if(isDefined(var_faedfa7b574a3cc)) {
    function_f9cfcbdfbe9d4638(phaseindex, var_faedfa7b574a3cc);
  }
}

function function_9d343b075a77dcba() {
  if(!isDefined(self.entitydata) || !isDefined(self.entitydata.phaseindex) || !isDefined(self.phasedata)) {
    return undefined;
  }

  if(!isDefined(self.phasedata[self.entitydata.phaseindex])) {
    return undefined;
  }

  if(!isDefined(self.phasedata[self.entitydata.phaseindex].var_8d5f6ee9e22c653e)) {
    return undefined;
  }

  if(!isDefined(self.entitydata.spawnlocation) || !isDefined(self.phasedata[self.entitydata.phaseindex].var_8d5f6ee9e22c653e[self.entitydata.spawnlocation])) {
    return undefined;
  }

  return self.phasedata[self.entitydata.phaseindex].var_8d5f6ee9e22c653e[self.entitydata.spawnlocation];
}

function players_getcentroid() {
  centroid = undefined;
  temp = undefined;

  foreach(player in level.players) {
    if(!isDefined(temp)) {
      temp = player.origin;
      continue;
    }

    temp += player.origin;
  }

  if(isDefined(temp)) {
    centroid = temp / level.players.size;
  }

  return centroid;
}

function function_130b4014bf08795() {
  centroid = players_getcentroid();
  var_84573ab46f320c97 = undefined;
  var_52d384e6c8efa49d = undefined;
  closestdistance = 2147483647;
  phaseindex = self.entitydata.phaseindex;
  var_8d5f6ee9e22c653e = self.phasedata[phaseindex].var_8d5f6ee9e22c653e;

  if(isDefined(var_8d5f6ee9e22c653e) && isDefined(centroid)) {
    for(i = 0; i < var_8d5f6ee9e22c653e.size; i++) {
      location = var_8d5f6ee9e22c653e[i];

      if(!isDefined(var_84573ab46f320c97) || distancesquared(centroid, location.origin) < closestdistance) {
        closestdistance = distancesquared(centroid, location.origin);
        var_84573ab46f320c97 = location;
        var_52d384e6c8efa49d = i;
      }
    }
  }

  return var_52d384e6c8efa49d;
}

function function_72cc2105f47c4128() {
  centroid = players_getcentroid();
  var_645bc4aca8a3225 = undefined;
  var_744881db1baa1db5 = 0;
  var_7c58c737150e428b = undefined;
  phaseindex = self.entitydata.phaseindex;
  var_8d5f6ee9e22c653e = self.phasedata[phaseindex].var_8d5f6ee9e22c653e;

  if(isDefined(var_8d5f6ee9e22c653e) && isDefined(centroid)) {
    for(i = 0; i < var_8d5f6ee9e22c653e.size; i++) {
      location = var_8d5f6ee9e22c653e[i];

      if(!isDefined(var_645bc4aca8a3225) || distancesquared(centroid, location.origin) > var_744881db1baa1db5) {
        var_744881db1baa1db5 = distancesquared(centroid, location.origin);
        var_645bc4aca8a3225 = location;
        var_7c58c737150e428b = i;
      }
    }
  }

  return var_7c58c737150e428b;
}

function function_e9488f769f23fc32() {
  phaseindex = self.entitydata.phaseindex;
  var_8d5f6ee9e22c653e = self.phasedata[phaseindex].var_8d5f6ee9e22c653e;

  if(isDefined(var_8d5f6ee9e22c653e)) {
    var_92c77deda84a52b7 = array_randomize(var_8d5f6ee9e22c653e);

    for(index = 0; index < var_92c77deda84a52b7.size; index++) {
      if(isDefined(self.entitydata.var_9e9d541733c8afa4) && var_92c77deda84a52b7[index].index == self.entitydata.var_9e9d541733c8afa4) {
        continue;
      }

      if(var_92c77deda84a52b7[index].index != self.entitydata.spawnlocation) {
        return var_92c77deda84a52b7[index].index;
      }
    }
  }

  return undefined;
}

function function_f8a0235c72851079(island) {
  if(!isDefined(island)) {
    return false;
  }

  if(!isDefined(island.radius)) {
    island.radius = 1500;
  }

  radiussq = island.radius * island.radius;

  foreach(player in level.players) {
    if(distance2dsquared(island.origin, player.origin) < radiussq) {
      return true;
    }
  }

  return false;
}

function function_c95d968e76b2a761(index) {
  if(!isDefined(self.entitydata) || !isDefined(self.entitydata.islandlocations)) {
    return false;
  }

  if(index < 0 || index >= self.entitydata.islandlocations.size) {
    return false;
  }

  island = self.entitydata.islandlocations[index];
  return function_f8a0235c72851079(island);
}

function function_276a136594f3f693() {
  var_64ef3d495ae82376 = [];

  foreach(island in self.entitydata.islandlocations) {
    if(function_f8a0235c72851079(island)) {
      var_64ef3d495ae82376[var_64ef3d495ae82376.size] = island;
    }
  }

  return var_64ef3d495ae82376;
}

function function_370e89cf65df0b01(var_b2d4c9b4db7ee54, var_490cf556fe18ff1) {
  closestdist = 2147483647;
  closestplayer = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || istrue(player.inlaststand)) {
      continue;
    }

    if(function_d58d9fad4c55a9b8(player)) {
      continue;
    }

    if(istrue(var_b2d4c9b4db7ee54)) {
      if(!istrue(player isonground())) {
        continue;
      }

      if(isDefined(player.fling_data) && istrue(player.fling_data.in_air)) {
        continue;
      }
    }

    if(istrue(var_490cf556fe18ff1) && istrue(player.var_c764aba579deab63)) {
      continue;
    }

    dist = distancesquared(player.origin, self.origin);

    if(dist < closestdist) {
      closestdist = dist;
      closestplayer = player;
    }
  }

  return closestplayer;
}

function function_34f345873460798b(var_b2d4c9b4db7ee54, var_490cf556fe18ff1) {
  minhealth = 2147483647;
  var_b77cee88a9a17b3f = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || istrue(player.inlaststand)) {
      continue;
    }

    if(function_d58d9fad4c55a9b8(player)) {
      continue;
    }

    if(istrue(var_b2d4c9b4db7ee54)) {
      if(!istrue(player isonground())) {
        continue;
      }

      if(isDefined(player.fling_data) && istrue(player.fling_data.in_air)) {
        continue;
      }
    }

    if(istrue(var_490cf556fe18ff1) && istrue(player.var_c764aba579deab63)) {
      continue;
    }

    if(player.health < minhealth) {
      minhealth = player.health;
      var_b77cee88a9a17b3f = player;
    }
  }

  return var_b77cee88a9a17b3f;
}

function function_f3a96ba65901316(var_b2d4c9b4db7ee54, var_490cf556fe18ff1) {
  maxscore = 0;
  var_22c69a24a1ad0d6a = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || istrue(player.inlaststand)) {
      continue;
    }

    if(function_d58d9fad4c55a9b8(player)) {
      continue;
    }

    if(istrue(var_b2d4c9b4db7ee54)) {
      if(!istrue(player isonground())) {
        continue;
      }

      if(isDefined(player.fling_data) && istrue(player.fling_data.in_air)) {
        continue;
      }
    }

    if(istrue(var_490cf556fe18ff1) && istrue(player.var_c764aba579deab63)) {
      continue;
    }

    var_599c6f0b6b596efc = player.pers;

    if(var_599c6f0b6b596efc["score"] >= maxscore) {
      maxscore = var_599c6f0b6b596efc["score"];
      var_22c69a24a1ad0d6a = player;
    }
  }

  return var_22c69a24a1ad0d6a;
}

function function_f95e59f2b54f3763() {
  count = 0;

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(function_d58d9fad4c55a9b8(player)) {
      continue;
    }

    count++;
  }

  return count;
}

function function_d58d9fad4c55a9b8(player) {
  if(isDefined(player.team) && (player.team == "spectator" || player.team == "codcaster")) {
    return true;
  }

  if(isDefined(player.sessionstate) && (player.sessionstate == "spectator" || player.sessionstate == "playing_but_spectating" || player.sessionstate == "intermission")) {
    return true;
  }

  return false;
}

function function_f40c1634cd048cda(var_4195498e9121e409) {
  self.entitydata.var_4195498e9121e409 = var_4195498e9121e409;
  self notify("pain");
  scripts\asm\asm_mp::runpain();
}

function function_ee81bcd0f7070e2e(substring, maxcount) {
  if(!isDefined(self.var_2810bd3ceddee8da.spawnlocations)) {
    self.var_2810bd3ceddee8da.spawnlocations = [];
  }

  for(index = 1; index <= maxcount; index++) {
    var_f5c1c7e608a946f7 = getStruct(string(substring + index), "targetname");

    if(isDefined(var_f5c1c7e608a946f7)) {
      self.var_2810bd3ceddee8da.spawnlocations[index - 1] = var_f5c1c7e608a946f7;
    }
  }
}

function function_6790e7673398d475() {
  position = self.origin;
  var_84573ab46f320c97 = undefined;
  closestdistance = 2147483647;
  var_52d384e6c8efa49d = undefined;
  var_f5c1c7e608a946f7 = self.var_2810bd3ceddee8da.spawnlocations;

  if(isDefined(position)) {
    for(i = 0; i < var_f5c1c7e608a946f7.size; i++) {
      location = var_f5c1c7e608a946f7[i];

      if(!isDefined(var_84573ab46f320c97) || distancesquared(position, location.origin) < closestdistance) {
        closestdistance = distancesquared(position, location.origin);
        var_84573ab46f320c97 = location;
        var_52d384e6c8efa49d = i;
      }
    }
  }

  return var_84573ab46f320c97;
}

function function_e81685afe57277af(var_c738c3b00598761c) {
  if(flag("killing_all_ai")) {
    return;
  }

  thread function_3920244020576011(var_c738c3b00598761c);
}

function private function_3920244020576011(var_c738c3b00598761c) {
  level endon("game_ended");

  if(flag("killing_all_ai") || !isDefined(var_c738c3b00598761c)) {
    return;
  }

  flag_set("killing_all_ai");
  var_3c41e488c621880d = [];

  if(isDefined(var_c738c3b00598761c.entitydata) && isDefined(var_c738c3b00598761c.entitydata.islandlocations)) {
    for(i = 0; i < var_c738c3b00598761c.entitydata.islandlocations.size; i++) {
      nearbyzombies = getaiarrayinradius(var_c738c3b00598761c.entitydata.islandlocations[i].origin, var_c738c3b00598761c.entitydata.islandlocations[i].radius, "team_two_hundred");

      if(nearbyzombies.size > 0) {
        foreach(zombie in nearbyzombies) {
          var_3c41e488c621880d[var_3c41e488c621880d.size] = zombie;
        }
      }
    }
  } else {
    var_3c41e488c621880d = getaiarrayinradius(var_c738c3b00598761c.origin, 10240, "team_two_hundred");
  }

  foreach(zombie in var_3c41e488c621880d) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      continue;
    }

    if(isDefined(var_c738c3b00598761c) && isalive(var_c738c3b00598761c) && zombie == var_c738c3b00598761c) {
      continue;
    }

    zombie.marked_for_death = 1;
  }

  var_623589fae9ba93c7 = 8;

  foreach(zombie in var_3c41e488c621880d) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      continue;
    }

    if(!istrue(zombie.marked_for_death)) {
      continue;
    }

    zombie.nuked = 1;
    zombie.full_gib = 1;
    zombie.var_745cd904c1ec804c = 1;
    zombie kill();
    var_623589fae9ba93c7--;

    if(var_623589fae9ba93c7 <= 0) {
      wait 0.2;
      var_623589fae9ba93c7 = 8;
    }
  }

  flag_clear("killing_all_ai");
}

function function_2da1745aab41cb94(phaseindex) {
  if(isDefined(self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[phaseindex])) {
    return self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[phaseindex];
  }
}

function function_c4447e7f406126bb(var_8b59a837b0e6f7fe, phaseindex) {
  switch (phaseindex) {
    case 0:
      return (var_8b59a837b0e6f7fe + "phase1");
    case 1:
    case 2:
    default:
      return (var_8b59a837b0e6f7fe + "phase2");
  }
}

function function_6a493253ff0a74bd() {
  if(istrue(self.var_4919d15787f01154)) {
    return self.fake_health;
  }

  return self.health;
}

function function_539a480132aefe25() {
  if(istrue(self.var_4919d15787f01154)) {
    return self.max_fake_health;
  }

  return self.maxhealth;
}

function function_b61d0a63a27dd52e(scriptablestate, phaseindex) {
  switch (phaseindex) {
    case 0:
      return (scriptablestate + "_" + "phase1");
    case 1:
    case 2:
    default:
      return (scriptablestate + "_" + "phase2");
  }
}

function function_90dc656a3cef966a(location, outerradius, innerradius, fxid, maxdamage, mindamage, magnitude, delay) {
  wait delay;
  var_584d9c5318c06de8 = spawnfx(getfx(fxid), location);
  physicsexplosionsphere(location, outerradius, innerradius, magnitude);

  if(isDefined(var_584d9c5318c06de8)) {
    triggerfx(var_584d9c5318c06de8);
  }

  radiusdamage(location, outerradius, maxdamage, mindamage, self);
  wait 4;

  if(isDefined(var_584d9c5318c06de8)) {
    var_584d9c5318c06de8 delete();
  }
}

function function_e1c9888a10e1798f(value) {
  self.var_faef8af80c81254e = value;
}

function function_efc9be9e46d1f242(asmname, statename, startnotetrack, endnotetrack) {
  tempanim = self asmgetanim(asmname, statename);
  assert(isDefined(tempanim));
  xanim = asm_getxanim(statename, tempanim);
  duration = undefined;

  if(animhasnotetrack(xanim, startnotetrack)) {
    assert(animhasnotetrack(xanim, endnotetrack));
    startnote = getnotetracktimes(xanim, startnotetrack);

    if(animhasnotetrack(xanim, endnotetrack)) {
      endnote = getnotetracktimes(xanim, endnotetrack);
      animlength = getanimlength(xanim);
      starttime = startnote[0];

      if(starttime > 0) {
        starttime = startnote[0] * animlength * 1000;
        starttime -= mod(int(starttime), level.frameduration);
        starttime = starttime / animlength / 1000;
      }

      end_time = endnote[0];
      duration = int((end_time - starttime) * animlength * 1000);
      duration += level.frameduration - mod(duration, level.frameduration);
    }
  }

  return duration;
}

function function_b330308e17eb473b(asmname, statename, notetrack) {
  tempanim = self asmgetanim(asmname, statename);
  assert(isDefined(tempanim));
  xanim = asm_getxanim(statename, tempanim);
  time = undefined;

  if(animhasnotetrack(xanim, notetrack)) {
    endnote = getnotetracktimes(xanim, notetrack);
    time = endnote[0] * 1000;
  }

  return time;
}