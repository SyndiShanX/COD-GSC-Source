/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_147448f3f080c636.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_54acaf301486afc6;

function function_c984f2a1e4436eba() {
  level.civreactdata = spawnStruct();
  level.civreactdata.var_2382776051beed37 = 4000;
  level.civreactdata.wasgunshot = 0;
  level.civreactdata.var_cb0412bfad561be1 = 0;
  level.civreactdata.var_df9cdff867da6dd9 = 3000;
  level.civreactdata.aimatdelay = 2000;
  level.civreactdata.var_448e04f667a280b1 = 0;
  level.civreactdata.var_af1d1102ede20fc2 = "relaxed";
  level.civreactdata.forcecooldown = 0;
  level.civreactdata.runawaycooldown = 20000;
  level.civreactdata.gunshotcooldown = 1000;
  level.civreactdata.meleecooldown = 1000;
  level.civreactdata.gunshottimer = 0;
  level.civreactdata.bulletwhizbyoccurred = [];
  level.civreactdata.bulletwhizbytimers = [];
  level.civreactdata.bulletwhizbycooldown = 200;
  level.civreactdata.meleetimer = 0;
  level.civreactdata.var_30e8e171b32c1d5c = 64;
  level.civreactdata.var_e2b778b4a4a266f5 = 108;
  level.civreactdata.attitudepriority = [];
  level.civreactdata.attitudepriority["relaxed"] = 0;
  level.civreactdata.attitudepriority["curious"] = 1;
  level.civreactdata.attitudepriority["staring"] = 1;
  level.civreactdata.attitudepriority["angered"] = 2;
  level.civreactdata.attitudepriority["scared"] = 3;
  level.civreactdata.attitudepriority["panicked"] = 4;
  level.civreactdata.attitudepriority["cower"] = 5;
  level.civreactdata.civs = [];
  level.civreactdata.events = queue_create(5);
  level.civsightdata = spawnStruct();
  level.civsightdata.fov = 0.996;
  level.civsightdata.runfov = 0.975;
  level.civsightdata.starefov = 0.965;
  level.civsightdata.gunfov = 0.707;
  level.civsightdata.maxdistance = 400;
  level.civsightdata.averageheight = 6;
  level.civsightdata.aimatrange = 400;
  level.civsightdata.staredistance = 150;
  level.civsightdata.civilianfov = 0.02;
  level.civsightdata.approxeyepos = 60;
  level.civsightdata.unholsterdistance = 600;
  level.var_9958731831312749 = spawnStruct();
  level.var_9958731831312749.smalldelaymin = 0;
  level.var_9958731831312749.smalldelaymax = 200;
  level.var_9958731831312749.mediumdelaymin = 500;
  level.var_9958731831312749.mediumdelaymax = 1500;
  level.var_9958731831312749.largedelaymin = 1500;
  level.var_9958731831312749.largedelaymax = 2500;
  level.var_9958731831312749.var_bceea906e00dbe5d = 0;
  level.var_9958731831312749.var_bccbb306dfe78ca3 = 4500;
  level.var_9958731831312749.var_7684b0649e83c0f = 3000;
  level.var_9958731831312749.var_745390649c1ccc1 = 5500;
  level.var_9958731831312749.var_ab47b155a0c0b6e9 = 256;
  level.var_9958731831312749.var_7030873a2cb05d89 = 2;
  level.var_9958731831312749.var_2fe9915eca4d8d12 = 1;
  level.var_9958731831312749.var_832e9f5262aaa2b2 = 0.5;
  level.var_9958731831312749.var_55beb89839cbe08b = 0.6;
  level.var_9958731831312749.var_de22934892b70a4e = 0.8;
  level.var_9958731831312749.var_ada3cdb8ba2cd2ec = 1;
  level.var_9958731831312749.var_44b96437c2e7f624 = 3;
  level.var_9958731831312749.var_30f007ac9a8e642e = 75;
  level.var_9958731831312749.var_4bee8d2b5a70f239 = 230;
  level.var_9958731831312749.var_a2fe99c7d215229e = 100;
  level.var_9958731831312749.largedistance = 1500;
  level.var_9958731831312749.mediumdistance = 400;
  level.var_9958731831312749.smalldistance = 200;
  level.var_9958731831312749.largecooldown = 10;
  level.var_9958731831312749.mediumcooldown = 7;
  level.var_9958731831312749.smallcooldown = 3;
  level.var_9958731831312749.secsmultiplier = 1000;
  level.var_9958731831312749.glancedelay = 1000;
  level.var_9958731831312749.var_922aa1ced3d997d7 = level.var_9958731831312749.glancedelay + 1000;
  setdvarifuninitialized(@ "hash_18f4855098e19194", 1);
  setdvarifuninitialized(@ "hash_4323dba64c360cf0", 0);
}

function function_32d74b97e987274c(entity1, entity2, entity1fov, entity2fov) {
  return function_b1eeb1edab8e23d4(entity1, entity2, entity1fov) && function_b1eeb1edab8e23d4(entity2, entity1, entity2fov);
}

function function_b1eeb1edab8e23d4(sourceentity, targetentity, fov) {
  sourceentforward = anglesToForward(sourceentity.angles);
  sourceentforward = vectorNormalize(sourceentforward);
  sourcetotarget = targetentity.origin - sourceentity.origin;
  sourcetotarget = vectorNormalize(sourcetotarget);
  return vectordot(sourceentforward, sourcetotarget) >= fov;
}

function function_4b685c24abf694be(civilian, attitude) {
  return civilian.attitude == attitude || isDefined(civilian.var_f73ef0cdee5d001e) && civilian.var_f73ef0cdee5d001e == attitude || isDefined(civilian.var_e032f690711396e6) && civilian.var_e032f690711396e6 == attitude;
}

function function_8ba22addf492e664(civilian, ent) {
  result = 0;

  if(isDefined(civilian)) {
    eyepos = (civilian.origin[0], civilian.origin[1], civilian.origin[2] + level.civsightdata.approxeyepos);
    enteyepos = ent getEye();

    if(sighttracepassed(eyepos, enteyepos, 0, civilian.sight_ignore, civilian, 0)) {
      result = 1;
    }
  }

  return result;
}

function function_bf7a1de4139d5af(civilian, ent, time, speed) {
  civilian endon("death");
  civilian function_106bce0aeee91d2c(utility::function_b88f4e5baff057a9(speed));
  civilian function_1c339daaba3f71db(1);

  if(isDefined(level.players) && array_contains(level.players, ent) || ent == level.player) {
    civilian function_5621e511b99964a7(level.player);
    wait time + 1;
    civilian function_504a5e2df31069a4();
  } else {
    civilian glanceatentity(ent, time, speed);
  }

  civilian function_1c339daaba3f71db(0);
}

function function_51e25764b9a2f1b1(delaytype) {
  delaytemp = 0;

  switch (delaytype) {
    case #"hash_5971965ed985a26c":
      delaytemp = randomintrange(level.var_9958731831312749.smalldelaymin, level.var_9958731831312749.smalldelaymax);
      break;
    case #"hash_c71b112fe04823d6":
      delaytemp = randomintrange(level.var_9958731831312749.mediumdelaymin, level.var_9958731831312749.mediumdelaymax);
      break;
    case #"hash_4bf33d595d8f4894":
      delaytemp = randomintrange(level.var_9958731831312749.largedelaymin, level.var_9958731831312749.largedelaymax);
      break;
    case #"hash_862b9a06fd4c4c8d":
      delaytemp = randomintrange(level.var_9958731831312749.var_bceea906e00dbe5d, level.var_9958731831312749.var_bccbb306dfe78ca3);
      break;
    case #"hash_3d34b62cda8bac2c":
      delaytemp = randomintrange(level.var_9958731831312749.var_7684b0649e83c0f, level.var_9958731831312749.var_745390649c1ccc1);
      break;
    default:
      break;
  }

  return delaytemp;
}

function function_309155e57ee0de92(path) {
  if(isDefined(path)) {
    thread function_412f5234020b3c49(path);
    return;
  }

  function_e6f0084e863e9a4b();
  self notify("party_civ_run");
}

function function_fff7117076af2d16(sourceciv, maxdistance, reactiontype, fromplayer, shouldcheckfov) {
  if(reactiontype == "relaxed") {
    return;
  }

  for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
    civ = level.civreactdata.civs[civindex];

    if(!isDefined(civ) || civ == sourceciv) {
      continue;
    }

    if(isDefined(civ.capgroup) && isDefined(sourceciv.gapgroup)) {
      if(level.capgroups[civ.gapgroup] == level.capgroups[sourceciv.capgroup]) {
        continue;
      }
    }

    if(function_4b685c24abf694be(civ, reactiontype)) {
      continue;
    }

    if(level.civreactdata.attitudepriority[reactiontype] <= level.civreactdata.attitudepriority[civ.reactdata.triggeredreactiontype]) {
      continue;
    }

    if(civ.reactdata.isglancing == 1) {
      continue;
    }

    var_691f481a8bba4062 = 0;
    player = getclosestplayer(civ.origin);

    if(!isDefined(player)) {
      continue;
    }

    if(fromplayer) {
      var_691f481a8bba4062 = distance(player, civ.origin);
    } else {
      var_691f481a8bba4062 = distance(sourceciv.origin, civ.origin);
    }

    if(isDefined(maxdistance) && var_691f481a8bba4062 > maxdistance) {
      continue;
    }

    isinfov = !shouldcheckfov || function_b1eeb1edab8e23d4(civ, sourceciv, level.civsightdata.civilianfov);

    if(isinfov) {
      civ.reactdata.triggeredreactiontype = reactiontype;

      if(level.civreactdata.attitudepriority[reactiontype] >= level.civreactdata.attitudepriority["scared"]) {
        civ.reactdata.triggeredtime = randomintrange(0, 200);
      } else {
        civ.reactdata.triggeredtime = randomintrange(int(level.var_9958731831312749.var_922aa1ced3d997d7), level.var_9958731831312749.var_922aa1ced3d997d7 + int(var_691f481a8bba4062));
      }

      civ.triggeredtimers = undefined;
      civ.reactdata.isglancing = 0;
      civ.var_e0f99af636c737b = undefined;
      civ.var_f73ef0cdee5d001e = undefined;
      civ.civreacttime = undefined;
      civ.var_84c1ae8d0dce5970 = undefined;
      civ.var_e032f690711396e6 = undefined;
      civ.var_83b37a7080fd5c11 = undefined;
      civ.var_14c9c06bc882eee8 = undefined;
      civ.attitudechangequeued = 0;
    }
  }
}

function function_8fcb3ba9dd0eb394(sourceent, mindistance, reactiontype) {
  if(reactiontype == "relaxed") {
    return;
  }

  if(level.civreactdata.attitudepriority[reactiontype] <= level.civreactdata.attitudepriority[level.civreactdata.var_af1d1102ede20fc2]) {
    return;
  }

  level.civreactdata.var_af1d1102ede20fc2 = reactiontype;

  for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
    civ = level.civreactdata.civs[civindex];

    if(!isDefined(civ) || civ == sourceent) {
      continue;
    }

    if(isDefined(civ.capgroup) && isDefined(sourceent.gapgroup)) {
      if(level.capgroups[civ.gapgroup] == level.capgroups[sourceent.capgroup]) {
        continue;
      }
    }

    if(function_4b685c24abf694be(civ, reactiontype)) {
      continue;
    }

    var_7f42d6d073c141c9 = distance(sourceent.origin, civ.origin);

    if(isDefined(mindistance) && var_7f42d6d073c141c9 <= mindistance) {
      continue;
    }

    newreactiontype = "relaxed";
    var_cee1ee42c6b3b053 = 0;

    switch (reactiontype) {
      case #"hash_dd76edf4ebd198bd":
        if(var_7f42d6d073c141c9 <= 800) {
          if(randomint(5) <= 2) {
            newreactiontype = "curious";
          } else {
            newreactiontype = "scared";
          }

          var_cee1ee42c6b3b053 = randomintrange(int(var_7f42d6d073c141c9), int(2 * var_7f42d6d073c141c9));
        } else {
          if(randomint(4) <= 2) {
            newreactiontype = "curious";
          } else {
            newreactiontype = "scared";
          }

          var_cee1ee42c6b3b053 = randomintrange(int(2 * var_7f42d6d073c141c9), int(4 * var_7f42d6d073c141c9));
        }

        break;
      case #"hash_ea9150ecc8538d74":
        if(var_7f42d6d073c141c9 <= 800) {
          if(randomint(4) <= 2) {
            newreactiontype = "scared";
          } else {
            newreactiontype = "curious";
          }

          var_cee1ee42c6b3b053 = randomintrange(int(var_7f42d6d073c141c9 / 2), int(var_7f42d6d073c141c9));
        } else {
          randattitude = randomint(10);

          if(randattitude <= 7) {
            newreactiontype = "curious";
          } else {
            newreactiontype = "scared";
          }

          var_cee1ee42c6b3b053 = randomintrange(int(var_7f42d6d073c141c9), int(2 * var_7f42d6d073c141c9));
        }

        break;
      default:
        continue;
    }

    if(newreactiontype != "relaxed") {
      if(function_4b685c24abf694be(civ, newreactiontype)) {
        continue;
      }

      if(level.civreactdata.attitudepriority[newreactiontype] <= level.civreactdata.attitudepriority[civ.reactdata.var_af1d1102ede20fc2]) {
        continue;
      }

      civ.reactdata.var_af1d1102ede20fc2 = newreactiontype;
      civ.reactdata.var_ac13962f5c74201c = var_cee1ee42c6b3b053;
      civ.var_e0f99af636c737b = undefined;
      civ.reactdata.isglancing = 0;
      civ.var_f73ef0cdee5d001e = undefined;
      civ.civreacttime = undefined;
      civ.var_84c1ae8d0dce5970 = undefined;
      civ.var_e032f690711396e6 = undefined;
      civ.var_83b37a7080fd5c11 = undefined;
      civ.var_14c9c06bc882eee8 = undefined;
      civ.attitudechangequeued = 0;
    }
  }
}

function function_db0d38fa7aab73f3(civilian) {
  time = gettime();
  player = getclosestplayer(civilian.origin);
  dist = distance(civilian.origin, player.origin);
  reactiondelay = randomintrange(0, int(level.var_9958731831312749.glancedelay / 2));

  if(!isDefined(civilian.var_cd4296a99a7e9e7b)) {
    civilian.var_cd4296a99a7e9e7b = spawnStruct();

    if(isai(civilian)) {
      if(civilian.attitude == "relaxed") {
        civilian.var_cd4296a99a7e9e7b.quickglance = time + randomintrange(reactiondelay, reactiondelay + int(dist));
        civilian.var_cd4296a99a7e9e7b.attitudechangetimer = civilian.var_cd4296a99a7e9e7b.quickglance + level.var_9958731831312749.glancedelay;
      } else {
        civilian.var_cd4296a99a7e9e7b.attitudechangetimer = time + randomintrange(int(dist / 2), int(dist));
      }
    } else if(civilian.attitude == "relaxed") {
      civilian.var_cd4296a99a7e9e7b.attitudechangetimer = time + randomintrange(reactiondelay, reactiondelay + int(dist)) + level.var_9958731831312749.glancedelay;
    } else {
      civilian.var_cd4296a99a7e9e7b.attitudechangetimer = time + randomintrange(int(dist / 2), int(dist));
    }

    return;
  }

  if(isDefined(civilian.var_cd4296a99a7e9e7b)) {
    if(isDefined(civilian.var_cd4296a99a7e9e7b.quickglance) && time >= civilian.var_cd4296a99a7e9e7b.quickglance) {
      civilian.reactdata.isglancing = 1;

      if(isai(civilian)) {
        civilian thread function_bf7a1de4139d5af(civilian, player, level.var_9958731831312749.var_ada3cdb8ba2cd2ec, level.var_9958731831312749.var_de22934892b70a4e);
      }

      civilian.var_cd4296a99a7e9e7b.quickglance = undefined;
      return;
    }

    if(time >= civilian.var_cd4296a99a7e9e7b.attitudechangetimer) {
      civilian.civreacttime = time;
      civilian.var_f73ef0cdee5d001e = "scared";
      civilian.var_84c1ae8d0dce5970 = 0;
      civilian._blackboard.var_610cb18ecc1af719 = player;
      civilian.reactdata.isglancing = 0;
      civilian.var_cd4296a99a7e9e7b = undefined;
      civilian.attitudechangequeued = 1;
      function_fff7117076af2d16(civilian, level.var_9958731831312749.var_4bee8d2b5a70f239, "scared", 0, 0);
      function_8fcb3ba9dd0eb394(player, level.civsightdata.unholsterdistance, "scared");
    }
  }
}

function function_5bc5a2142d93c46e(civilian, sourceent) {
  time = gettime();
  dist = distance(civilian.origin, sourceent.origin);

  if(istrue(civilian.attitudechangequeued)) {
    return;
  }

  player = getclosestplayer(civilian.origin);

  if(civilian.sightdata.sight_trace_passed && function_32d74b97e987274c(player, civilian, level.civsightdata.gunfov, level.civsightdata.civilianfov)) {
    isaimedat = civilian.eventdistance <= level.civsightdata.aimatrange && function_b1eeb1edab8e23d4(player, civilian, level.civsightdata.fov);

    if(isaimedat) {
      if(isDefined(civilian.var_f73ef0cdee5d001e) && civilian.var_f73ef0cdee5d001e == "panicked") {
        return;
      }

      if(civilian.attitude == "cower") {
        level thread function_d383856f09f7b8ac(player);
        return;
      }

      if(civilian.attitude == "panicked") {
        if(!isDefined(civilian.cowertimer)) {
          civilian.cowertimer = time + randomintrange(int(dist), int(2 * dist));
          return;
        }

        if(time >= civilian.cowertimer) {
          civilian.civreacttime = time;
          civilian.var_f73ef0cdee5d001e = "cower";
          civilian.var_84c1ae8d0dce5970 = 0;
          civilian.cowertimer = undefined;
          civilian._blackboard.var_610cb18ecc1af719 = player;
          civilian.reactdata.isglancing = 0;
          civilian.var_cd4296a99a7e9e7b = undefined;
          civilian.attitudechangequeued = 1;
          level thread function_d383856f09f7b8ac(player);
          return;
        }
      } else {
        civilian.civreacttime = time + randomintrange(0, int(dist));
        civilian.var_f73ef0cdee5d001e = "panicked";
        civilian.var_84c1ae8d0dce5970 = 0;
      }

      if(isDefined(civilian.var_e032f690711396e6)) {
        civilian.var_e032f690711396e6 = undefined;
        civilian.var_83b37a7080fd5c11 = undefined;
        civilian.var_14c9c06bc882eee8 = undefined;
      }

      civilian.reactdata.isglancing = 0;
      civilian.var_cd4296a99a7e9e7b = undefined;
      civilian.attitudechangequeued = 1;
      function_fff7117076af2d16(civilian, level.var_9958731831312749.var_a2fe99c7d215229e, "scared", 0, 0);
      function_8fcb3ba9dd0eb394(player, level.civsightdata.unholsterdistance, "panicked");
    } else {
      civilian.cowertimer = undefined;

      if(function_4b685c24abf694be(civilian, "scared")) {
        return;
      }

      function_db0d38fa7aab73f3(civilian);
    }

    return;
  }

  if(civilian.reactdata.triggeredreactiontype != "relaxed" || civilian.reactdata.var_af1d1102ede20fc2 != "relaxed") {
    return;
  }

  if(function_b1eeb1edab8e23d4(player, civilian, level.civsightdata.gunfov)) {
    return;
  }

  if(function_4b685c24abf694be(civilian, "curious")) {
    return;
  }

  multiplier = 3;
  civilianforward = anglesToForward(civilian.angles);
  civilianforward = vectorNormalize(civilianforward);
  civiliantoplayer = player.origin - civilian.origin;
  civiliantoplayer = vectorNormalize(civiliantoplayer);
  tempdelay = 1 - vectordot(civilianforward, civiliantoplayer);
  civilian.civreacttime = time + randomintrange(int(dist), int(2 * dist)) + tempdelay * multiplier * level.var_9958731831312749.secsmultiplier;
  civilian.var_f73ef0cdee5d001e = "curious";
  civilian.var_84c1ae8d0dce5970 = 0;
  civilian.reactdata.isglancing = 0;
  civilian.var_cd4296a99a7e9e7b = undefined;
  civilian.attitudechangequeued = 1;
}

function function_2e4bf288de5058a5(civilian, var_54049822cd45f4b8) {
  if(istrue(civilian.var_ab39b6ca764a6695)) {
    return;
  }

  if(istrue(civilian.sightdata.sight_trace_passed) || istrue(civilian.sightdata.var_ee72620ac1467e7f)) {
    time = gettime();
    player = getclosestplayer(civilian.origin);

    if(!isDefined(player)) {
      return;
    }

    if(!isDefined(civilian.var_c637a07b110d6d1a)) {
      civilian.var_c637a07b110d6d1a = spawnStruct();

      if(isai(civilian)) {
        civilian.var_c637a07b110d6d1a.longerglance = time + randomintrange(500, 1000);
        civilian.var_c637a07b110d6d1a.attitudechangetimer = time + randomintrange(6000, 7000);
      } else {
        civilian.var_c637a07b110d6d1a.attitudechangetimer = time + randomintrange(1500, 3000);
      }
    } else if(isDefined(civilian.var_c637a07b110d6d1a)) {
      if(isDefined(civilian.var_c637a07b110d6d1a.quickglance) && time >= civilian.var_c637a07b110d6d1a.quickglance) {
        civilian.reactdata.isglancing = 1;

        if(isai(civilian)) {
          civilian thread function_bf7a1de4139d5af(civilian, player, level.var_9958731831312749.var_ada3cdb8ba2cd2ec, level.var_9958731831312749.var_55beb89839cbe08b);
        }

        civilian.var_c637a07b110d6d1a.quickglance = undefined;
      } else if(isDefined(civilian.var_c637a07b110d6d1a.longerglance) && time >= civilian.var_c637a07b110d6d1a.longerglance) {
        civilian.reactdata.isglancing = 1;

        if(isai(civilian)) {
          civilian thread function_bf7a1de4139d5af(civilian, player, level.var_9958731831312749.var_44b96437c2e7f624, level.var_9958731831312749.var_de22934892b70a4e);
        }

        civilian.var_c637a07b110d6d1a.longerglance = undefined;
      } else if(time >= civilian.var_c637a07b110d6d1a.attitudechangetimer) {
        if(var_54049822cd45f4b8) {
          civilian.civreacttime = time;
          civilian.var_f73ef0cdee5d001e = "staring";
          civilian.var_84c1ae8d0dce5970 = 0;
          civilian.attitudechangequeued = 1;
          civilian._blackboard.var_610cb18ecc1af719 = player;
        }

        civilian.reactdata.isglancing = 0;
        civilian.var_c637a07b110d6d1a = undefined;

        if(var_54049822cd45f4b8) {
          function_fff7117076af2d16(civilian, level.var_9958731831312749.var_30f007ac9a8e642e, "staring", 0, 1);
        }
      }
    }

    return;
  }

  if(isDefined(civilian.var_c637a07b110d6d1a)) {
    civilian.var_c637a07b110d6d1a = undefined;
  }
}

function function_35f7191a1541ef00(civilian, sourceent) {
  civilian.sightdata.var_21965e18b854f978 = undefined;

  if(civilian.attitude != "relaxed" || istrue(civilian.cooldownqueued)) {
    return;
  }

  if(function_b1eeb1edab8e23d4(sourceent, civilian, level.civsightdata.starefov)) {
    check = 0;

    if(!function_b1eeb1edab8e23d4(civilian, sourceent, level.civsightdata.gunfov)) {
      if(isDefined(civilian.sightdata.var_dd42e0cfcc2298aa)) {
        return;
      }

      if(!isDefined(civilian.sightdata.var_ee72620ac1467e7f)) {
        civilian.sightdata.var_ee72620ac1467e7f = 0;
      }

      level.civsightdata.var_76448df574c47eca = function_6cf786a6cf335cb9(level.civsightdata.var_76448df574c47eca, civilian);
      civilian.sightdata.var_dd42e0cfcc2298aa = 1;
      return;
    }

    civilian.sightdata.sight_trace_passed = function_8ba22addf492e664(civilian, sourceent);
    function_2e4bf288de5058a5(civilian, 1);
  }
}

function function_8bee41bbdbe247f4(civilian, sourceent) {
  civilian.sightdata.var_21965e18b854f978 = undefined;
  civilian.sightdata.sight_trace_passed = function_8ba22addf492e664(civilian, sourceent);
  function_5bc5a2142d93c46e(civilian, sourceent);
}

function function_a1469580c494459c(civilian) {
  time = gettime();
  player = getclosestplayer(civilian.origin);

  if(!isDefined(player)) {
    return;
  }

  dist = distance(civilian.origin, player.origin);
  heightdist = abs(civilian.origin[2] - player.origin[2]);

  if(heightdist > level.civreactdata.var_e2b778b4a4a266f5) {
    return;
  }

  reactiontimedelay = civilian.reactdata.triggeredtime;

  if(!isDefined(civilian.triggeredtimers)) {
    civilian.triggeredtimers = spawnStruct();

    if(isai(civilian)) {
      if(civilian.attitude == "relaxed") {
        civilian.triggeredtimers.quickglance = time + reactiontimedelay;
        civilian.triggeredtimers.attitudechangetimer = civilian.triggeredtimers.quickglance + reactiontimedelay;
      } else {
        civilian.triggeredtimers.attitudechangetimer = time + randomintrange(int(dist / 2), int(dist));
      }
    } else if(civilian.attitude == "relaxed") {
      civilian.triggeredtimers.attitudechangetimer = time + randomintrange(reactiontimedelay, reactiontimedelay + int(dist)) + level.var_9958731831312749.var_922aa1ced3d997d7;
    } else {
      civilian.triggeredtimers.attitudechangetimer = time + randomintrange(int(dist / 2), int(dist));
    }

    return;
  }

  if(isDefined(civilian.triggeredtimers.quickglance)) {
    if(time >= civilian.triggeredtimers.quickglance) {
      civilian.reactdata.isglancing = 1;

      if(isai(civilian)) {
        civilian thread function_bf7a1de4139d5af(civilian, player, level.var_9958731831312749.var_ada3cdb8ba2cd2ec, 0.2);
      }

      civilian.triggeredtimers.quickglance = undefined;
    }

    return;
  }

  if(isDefined(civilian.triggeredtimers.attitudechangetimer)) {
    if(time >= civilian.triggeredtimers.attitudechangetimer) {
      civilian.civreacttime = time;
      civilian.var_f73ef0cdee5d001e = civilian.reactdata.triggeredreactiontype;
      civilian.var_84c1ae8d0dce5970 = 0;
      civilian._blackboard.var_610cb18ecc1af719 = player;
      civilian.triggeredtimers = undefined;
      civilian.attitudechangequeued = 1;
      civilian.reactdata.triggeredreactiontype = "relaxed";
    }

    return;
  }

  civilian.triggeredtimers = undefined;
  civilian.reactdata.triggeredreactiontype = "relaxed";
}

function function_59e85ddec8976510(civilian) {
  time = gettime();
  player = getclosestplayer(civilian.origin);

  if(!isDefined(player)) {
    return;
  }

  dist = distance(civilian.origin, player.origin);
  heightdist = abs(civilian.origin[2] - player.origin[2]);

  if(heightdist > level.civreactdata.var_e2b778b4a4a266f5) {
    return;
  }

  if(!isDefined(civilian.var_e0f99af636c737b)) {
    civilian.var_e0f99af636c737b = spawnStruct();

    if(isai(civilian)) {
      if(civilian.attitude == "relaxed") {
        civilian.var_e0f99af636c737b.quickglance = time + randomintrange(level.var_9958731831312749.glancedelay, level.var_9958731831312749.glancedelay + int(dist));
        civilian.var_e0f99af636c737b.attitudechangetimer = civilian.var_e0f99af636c737b.quickglance + level.var_9958731831312749.glancedelay + civilian.reactdata.var_ac13962f5c74201c;
      } else {
        civilian.var_e0f99af636c737b.attitudechangetimer = time + civilian.reactdata.var_ac13962f5c74201c;
      }
    } else if(civilian.attitude == "relaxed") {
      civilian.var_e0f99af636c737b.attitudechangetimer = time + randomintrange(level.var_9958731831312749.glancedelay, level.var_9958731831312749.glancedelay + int(dist)) + level.var_9958731831312749.glancedelay + civilian.reactdata.var_ac13962f5c74201c;
    } else {
      civilian.var_e0f99af636c737b.attitudechangetimer = time + civilian.reactdata.var_ac13962f5c74201c;
    }

    return;
  }

  if(isDefined(civilian.var_e0f99af636c737b)) {
    if(isDefined(civilian.var_e0f99af636c737b.quickglance)) {
      if(time >= civilian.var_e0f99af636c737b.quickglance) {
        civilian.reactdata.isglancing = 1;

        if(isai(civilian)) {
          civilian thread function_bf7a1de4139d5af(civilian, player, level.var_9958731831312749.var_ada3cdb8ba2cd2ec, level.var_9958731831312749.var_de22934892b70a4e);
        }

        civilian.var_e0f99af636c737b.quickglance = undefined;
      }

      return;
    }

    if(isDefined(civilian.var_e0f99af636c737b.attitudechangetimer)) {
      if(time >= civilian.var_e0f99af636c737b.attitudechangetimer) {
        civilian.civreacttime = time;
        civilian.var_f73ef0cdee5d001e = civilian.reactdata.var_af1d1102ede20fc2;
        civilian.var_84c1ae8d0dce5970 = 0;
        civilian._blackboard.var_610cb18ecc1af719 = player;
        civilian.var_e0f99af636c737b = undefined;
        civilian.attitudechangequeued = 1;
        civilian.reactdata.var_af1d1102ede20fc2 = "relaxed";
      }

      return;
    }

    civilian.var_e0f99af636c737b = undefined;
    civilian.reactdata.var_af1d1102ede20fc2 = "relaxed";
  }
}

function function_60798c1c9231aa81(civilian) {
  civilian.var_f73ef0cdee5d001e = undefined;
  civilian.civreacttime = undefined;
  civilian.var_84c1ae8d0dce5970 = undefined;
  civilian.var_e032f690711396e6 = undefined;
  civilian.var_83b37a7080fd5c11 = undefined;
  civilian.var_14c9c06bc882eee8 = undefined;
  civilian.civreacttime = gettime() + function_51e25764b9a2f1b1("medium");
  civilian.var_f73ef0cdee5d001e = "panicked";
  civilian.var_84c1ae8d0dce5970 = 0;
  civilian.attitudechangequeued = 1;
  civilian.var_cd4296a99a7e9e7b = undefined;
  civilian.var_e0f99af636c737b = undefined;
  civilian.triggeredtimers = undefined;
  function_35eca80b3823c8b();
}

function function_e0bae58f26ee1323() {
  self endon("death");
  level endon("civreact_terminate");
  self.reactdata.capreset = 1;

  if(self codemoverequested()) {
    self waittill("goal");
  }

  if(!(self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimScripted()) && isDefined(self.prevasmname) && isDefined(self.var_8effd09d2c6077d7)) {
    scripts\common\cap::cap_start(self.prevasmname, self.var_8effd09d2c6077d7);
  } else {
    self.prevasmname = undefined;
    self.var_8effd09d2c6077d7 = undefined;
    self.var_35336d0f72f57871 = 0;
  }

  self.reactdata.capreset = 0;
}

function function_e6f0084e863e9a4b() {
  self.reactdata.forcerunactive = 1;
  function_405bf7cde917b70e(self);

  if(isDefined(self.unittype) && self.unittype == "civilian" && isai(self)) {
    utility::demeanor_override("frantic");
  }

  self.goalradius = 120;
  self.patrol_stop = 0;
  self.disableexits = 0;
  self._blackboard.blockcower = 1;
  self.doavoidanceblocking = 0;
  self.dosharpturnspeedscaling = 0;
  exitspeed = randomintrange(180, 220);
  set_movement_speed(exitspeed);
  self.exitspeedtarget = exitspeed;
  wait randomfloatrange(0.05, 2);
}

function function_2871e87dbd100e26(path) {
  newnode = path;
  patharray = [];

  while(true) {
    patharray[patharray.size] = newnode;

    if(isDefined(newnode.target)) {
      nodes = getStructArray(newnode.target, "targetname");

      if(nodes.size == 1) {
        newnode = nodes[0];
      } else {
        newnode = random(nodes);
      }

      continue;
    }

    break;
  }

  return patharray;
}

function function_dc3866343d3f5b15() {
  self waittill("cap_exit_completed");

  if(istrue(level.arcchange)) {
    self setoverridearchetype("default", "civilian_1");
    level.arcchange = 0;
    return;
  }

  level.arcchange = 1;
}

function function_639ac5f87833e45c(path, patharray) {
  percentage = 0;

  foreach(node in patharray) {
    dist = 40;

    if(isDefined(node.radius)) {
      dist = node.radius;
    }

    pointa = node.origin + anglestoleft(node.angles) * dist;
    pointb = node.origin + anglestoright(node.angles) * dist;

    if(node == path) {
      origin = pointonsegmentnearesttopoint(pointa, pointb, self.origin);
      origin = self getclosestreachablepointonnavmesh(origin);
      fulllength = length(pointa - pointb);
      originlength = length(pointa - origin);
      percentage = originlength / fulllength;
    } else {
      percdist = dist * 2 * percentage;
      origin = pointa + anglestoright(node.angles) * percdist;
      origin = self getclosestreachablepointonnavmesh(origin);
    }

    if(getdvarint(@ "hash_4323dba64c360cf0") == 1) {
      thread function_99210893ea5ea5f7(pointa, pointb, origin);
    }

    self.last_set_goalnode = undefined;
    self.last_set_goalpos = origin;
    self.last_set_goalent = undefined;
    self setgoalpos(origin);

    if(getdvarint(@ "hash_126bbee19522aa10") == 1) {
      thread function_dc3866343d3f5b15();
    }

    self waittill("goal");

    self notify("<dev string:x1c>");
  }
}

function function_1c29806b1e483c2d(sorted, isgunshot, var_5cb080bc298f2db0) {
  player = getclosestplayer(self.origin);

  if(!isDefined(player)) {
    return undefined;
  }

  left = anglestoleft(player.angles);
  forward = anglesToForward(player.angles);
  var_3d978a255f632a5 = self.origin - player.origin;
  var_c6dc218d10e0e5b5 = vectordot(left, var_3d978a255f632a5);
  var_c31c9ae87a14cf4d = vectordot(var_3d978a255f632a5, forward) >= 0;
  camerafov = 0.65;
  frontfov = 0.1;
  path = undefined;

  foreach(node in sorted) {
    if(istrue(var_5cb080bc298f2db0) && isDefined(node.script_parameters) && node.script_parameters != "middle") {
      continue;
    }

    var_625873782c3eabbd = vectorNormalize(node.origin - player.origin);
    var_398607f86ce55d6d = vectordot(left, var_625873782c3eabbd);
    dot = vectordot(var_625873782c3eabbd, forward);

    if(isgunshot) {
      pathcheck = var_c31c9ae87a14cf4d && dot > frontfov || !var_c31c9ae87a14cf4d && dot < -1 * frontfov;

      if(!pathcheck) {
        continue;
      }

      civforward = anglesToForward(self.angles);
      var_fa909a27b74a724c = vectorNormalize(node.origin - self.origin);

      if(vectordot(civforward, var_fa909a27b74a724c) > -0.25) {
        continue;
      }
    } else {
      pathcheck1 = dot < camerafov;
      pathcheck2 = dot > frontfov;

      if(var_c6dc218d10e0e5b5 * var_398607f86ce55d6d < 0 || !(pathcheck1 && pathcheck2)) {
        continue;
      }
    }

    nodetoplayer = vectorNormalize(player.origin - node.origin);
    nodeforward = anglesToForward(node.angles);
    nodedot = vectordot(nodetoplayer, nodeforward);

    if(nodedot > 0) {
      continue;
    }

    if(distance(node.origin, player.origin) < distance(self.origin, player.origin)) {
      continue;
    }

    dist = distancesquared(player.origin, node.origin);

    if(dist <= level.squarednum["player"]) {
      continue;
    }

    if(getdvarint(@ "hash_4323dba64c360cf0") == 1) {
      thread function_6aa255201d6332f9(dot, node);
    }

    path = node;
    break;
  }

  return path;
}

function function_a9e8cc25edfd1488(isgunshot) {
  if(istrue(self.reactdata.forcerunactive)) {
    return undefined;
  }

  path = undefined;
  paths = getStructArray("panicked_path", "script_noteworthy");

  if(!isDefined(paths)) {
    return undefined;
  }

  var_5cb080bc298f2db0 = 0;

  if(isgunshot && randomint(10) <= 8) {
    var_5cb080bc298f2db0 = 1;
  }

  sorted = sortbydistance(paths, self.origin);
  path = function_1c29806b1e483c2d(sorted, isgunshot, var_5cb080bc298f2db0);
  return path;
}

function function_412f5234020b3c49(path) {
  if(!isDefined(path) || isDefined(self.reactdata.forcerunbypass) || !isai(self)) {
    return;
  }

  function_e6f0084e863e9a4b();
  patharray = function_2871e87dbd100e26(path);
  function_639ac5f87833e45c(path, patharray);
  self delete();
}

function function_4585228f63bec744() {
  level endon("civreact_terminate");
  self endon("civ_deregister");

  while(true) {
    self waittill("bulletwhizby", shooter, whizbydist);
    civindex = array_find(level.civreactdata.civs, self);

    if(gettime() < level.civreactdata.bulletwhizbytimers[civindex]) {
      level.civreactdata.bulletwhizbytimers[civindex] = gettime() + level.civreactdata.bulletwhizbycooldown;
      continue;
    }

    level.civreactdata.bulletwhizbytimers[civindex] = gettime() + level.civreactdata.bulletwhizbycooldown;
    level.civreactdata.bulletwhizbyoccurred[civindex] = 1;
  }
}

function function_f44bcfc1647b23f() {
  level endon("civreact_terminate");
  self endon("civ_deregister");
  self endon("death");

  while(true) {
    level waittill("civ_death", civ);

    if(isDefined(civ)) {
      if(distance(self.origin, civ.origin) < level.civreactdata.var_30e8e171b32c1d5c) {
        function_1ce443834cd6b133();
        return;
      }
    }
  }
}

function function_1ce443834cd6b133() {
  self.reactdata.var_2141f7cb7ff397a6 = 1;
  self.attitude = "panicked";
  runpath = function_a9e8cc25edfd1488(1);
  function_309155e57ee0de92(runpath);
}

function function_8cbbda93904d3a65() {
  level endon("civreact_terminate");
  self endon("civ_deregister");
  self waittill("death");
  level notify("civ_death", self);
}

function function_6aa255201d6332f9(dot, path) {
  self endon("<dev string:x38>");

  while(true) {
    line(self.origin, path.origin, (1, 1, 1), 1, 0, 1);
    print3d(path.origin + (0, 0, 5), dot, (1, 1, 1), 1, 1, 0, 1);
    waitframe();
  }
}

function function_99210893ea5ea5f7(pointa, pointb, origin) {
  self endon("<dev string:x38>");
  self endon("<dev string:x1c>");

  while(true) {
    line(pointa, pointb, (1, 1, 1), 1, 0, 1);
    line(self.origin, origin, (0, 1, 0), 1, 0, 1);
    sphere(origin, 10, (1, 0, 0), 0, 1);
    waitframe();
  }
}

function function_d383856f09f7b8ac(sourceent) {
  if(isDefined(level.civreactdata.forcerun)) {
    return;
  }

  level.civreactdata.forcerun = 1;
  time = gettime();
  maxnumcivilian = randomint(2);

  for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
    civ = level.civreactdata.civs[civindex];

    if(!isai(civ)) {
      continue;
    }

    if(civ.reactdata.runawaycooldown > 0) {
      continue;
    }

    dist = distance(sourceent.origin, civ.origin);

    if(dist > level.var_9958731831312749.mediumdistance) {
      continue;
    }

    if(level.civreactdata.attitudepriority[civ.attitude] < level.civreactdata.attitudepriority["scared"] || function_4b685c24abf694be(civ, "cower")) {
      continue;
    }

    if(function_b1eeb1edab8e23d4(sourceent, civ, level.civsightdata.runfov)) {
      continue;
    }

    isinfront = function_b1eeb1edab8e23d4(sourceent, civ, 0.7);

    if(!isinfront) {
      continue;
    }

    civ.reactdata.runawaycooldown = time + level.civreactdata.runawaycooldown;

    if(maxnumcivilian > 1) {
      continue;
    }

    multiplier = dist / level.var_9958731831312749.mediumdistance;
    rand = (randomint(10) + 1) * multiplier;

    if(rand <= 0.2 && randomint(5) <= 3) {
      continue;
    }

    runpath = civ function_a9e8cc25edfd1488(0);
    function_309155e57ee0de92(runpath);
    maxnumcivilian++;
    civ.reactdata.isglancing = 0;
    civ.var_cd4296a99a7e9e7b = undefined;
    civ.attitudechangequeued = 0;
    function_35eca80b3823c8b();
  }

  level.civreactdata.forcerun = undefined;
}

function function_384465a3a8aa24f7(event) {
  eventdistance = distance(self.origin, event.position);
  runpath = function_a9e8cc25edfd1488(1);
  runcheck = getdvarint(@ "hash_18f4855098e19194") == 1 && isai(self) && eventdistance >= 800;
  runcheck2 = getdvarint(@ "hash_18f4855098e19194") == 1 && isai(self) && !function_4b685c24abf694be(self, "cower") && self.reactdata.runawaycooldown <= 0;
  var_1919d7729da23373 = function_b1eeb1edab8e23d4(event.originator, self, level.civsightdata.runfov);
  self.fleefromorigin = event.originator.origin;
  self.reactent = event.originator;
  var_801eb63f7c1178cf = getdvarint(@ "hash_e605a179ccf872", 500);
  var_455adacb086acebd = getdvarint(@ "hash_79ead190d52f34da", 1000);
  var_c5f83ffc76c21554 = getdvarint(@ "hash_13259e908967df41", 4000);

  if(eventdistance <= var_801eb63f7c1178cf) {
    if(runcheck2 && var_1919d7729da23373 && randomint(10) <= 7) {
      function_309155e57ee0de92(runpath);
    } else if(self.attitude == "cower") {
      if(randomint(10) <= 3) {
        self.var_f73ef0cdee5d001e = "cower";
      }
    } else if(self.attitude != "panicked" && self.attitude != "scared") {
      randattitude = randomint(10);

      if(randattitude <= 2) {
        self.var_f73ef0cdee5d001e = "scared";
      } else if(runcheck && randattitude == 4) {
        function_309155e57ee0de92(runpath);
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(self.attitude != "panicked") {
      if(runcheck && randomint(4) == 0) {
        function_309155e57ee0de92(runpath);
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else {
      randattitude = randomint(3);

      if(var_1919d7729da23373 || randattitude == 0) {
        self.var_f73ef0cdee5d001e = "cower";
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    }

    self.civreacttime = gettime() + randomintrange(0, int(max(eventdistance / 2, 1)));
  } else if(eventdistance <= var_455adacb086acebd) {
    if(runcheck2 && var_1919d7729da23373 && randomint(10) <= 6) {
      function_309155e57ee0de92(runpath);
    } else if(self.attitude == "cower") {
      if(randomint(10) <= 3) {
        self.var_f73ef0cdee5d001e = "cower";
      }
    } else if(self.attitude == "panicked") {
      randattitude = randomint(3);

      if(var_1919d7729da23373 || randattitude == 0) {
        self.var_f73ef0cdee5d001e = "cower";
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(self.attitude != "scared") {
      randattitude = randomint(10);

      if(randattitude <= 3) {
        self.var_f73ef0cdee5d001e = "scared";
      } else if(runcheck && randattitude <= 6) {
        function_309155e57ee0de92(runpath);
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(runcheck && randomint(4) <= 1) {
      function_309155e57ee0de92(runpath);
    } else {
      self.var_f73ef0cdee5d001e = "panicked";
    }

    self.civreacttime = gettime() + randomintrange(0, int(max(eventdistance / 2, 1)));
  } else if(eventdistance < var_c5f83ffc76c21554) {
    if(runcheck2 && var_1919d7729da23373 && randomint(10) <= 3) {
      function_309155e57ee0de92(runpath);
    } else if(self.attitude == "cower") {
      if(randomint(10) <= 3) {
        self.var_f73ef0cdee5d001e = "cower";
      }
    } else if(self.attitude == "panicked") {
      randattitude = randomint(3);

      if(var_1919d7729da23373 || randattitude == 0) {
        self.var_f73ef0cdee5d001e = "cower";
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(self.attitude == "scared") {
      if(runcheck && randomint(4) <= 2) {
        function_309155e57ee0de92(runpath);
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(self.attitude != "curious") {
      randattitude = randomint(10);

      if(randattitude <= 1) {
        self.var_f73ef0cdee5d001e = "curious";
      } else if(randattitude <= 2) {
        self.var_f73ef0cdee5d001e = "scared";
      } else if(runcheck && randattitude <= 8) {
        function_309155e57ee0de92(runpath);
      } else {
        self.var_f73ef0cdee5d001e = "panicked";
      }
    } else {
      self.var_f73ef0cdee5d001e = "scared";
    }

    self.civreacttime = gettime() + 500 + randomintrange(int(eventdistance / 2), int(max(eventdistance, 1)));
  }

  if(isDefined(self.var_f73ef0cdee5d001e)) {
    self.reactdata.runawaycooldown = level.civreactdata.runawaycooldown;
    self.attitudechangequeued = 1;
    self.var_cd4296a99a7e9e7b = undefined;
    self.var_e0f99af636c737b = undefined;
    self.triggeredtimers = undefined;
    self.reactdata.triggeredreactiontype = "relaxed";
    self.reactdata.var_af1d1102ede20fc2 = "relaxed";
    self._blackboard.var_610cb18ecc1af719 = event.originator;
    function_35eca80b3823c8b();
  }
}

function function_fbdb93097601737a(event) {
  eventdistance = distance(event.position, self.origin);
  heightdist = abs(self.origin[2] - event.position[2]);

  if(heightdist > level.civreactdata.var_e2b778b4a4a266f5) {
    return;
  }

  var_b5adf29860122c43 = geteventdefaultdistance("silenced_shot", self);

  if(function_32d74b97e987274c(self, event.originator, level.civsightdata.civilianfov, level.civsightdata.civilianfov)) {
    if(isDefined(level.stealth)) {
      var_b5adf29860122c43 = function_61b03c8c194a6733("spotted", "silenced_shot");
    }

    attitudechange = "panicked";
  } else {
    if(isDefined(level.stealth)) {
      var_b5adf29860122c43 = function_61b03c8c194a6733("hidden", "silenced_shot");
    }

    attitudechange = "curious";
  }

  if(eventdistance <= var_b5adf29860122c43) {
    if(function_4b685c24abf694be(self, attitudechange)) {
      return;
    }

    self.civreacttime = gettime() + function_51e25764b9a2f1b1("medium");
    self.var_f73ef0cdee5d001e = attitudechange;
    self.var_84c1ae8d0dce5970 = 0;
    self.reactdata.isglancing = 0;
    self.var_cd4296a99a7e9e7b = undefined;
    self.attitudechangequeued = 1;
    self._blackboard.var_610cb18ecc1af719 = event.originator;
  }
}

function function_a4962be231e7f4cf(event) {
  eventdistance = distance(event.position, self.origin);

  if(function_b1eeb1edab8e23d4(event.originator, self, level.civsightdata.starefov)) {
    if(eventdistance <= 50) {
      self.reactdata.waspunched = 1;
      self._blackboard.var_610cb18ecc1af719 = event.originator;
    }
  }
}

function function_73a4e814a7693f37(asmname, statename, tostatename, params) {
  return istrue(self.reactdata.waspunched);
}

function function_56628bebf53a65c() {
  if(isDefined(self.reactdata.waspunched)) {
    self.reactdata.waspunched = 0;
  }
}

function function_87d532954468d789(event) {
  eventdistance = distance(event.position, self.origin);
  heightdist = abs(self.origin[2] - event.position[2]);

  if(heightdist > level.civreactdata.var_e2b778b4a4a266f5) {
    return;
  }

  target = spawnStruct();
  target.origin = event.position;

  if(isDefined(event.stuckto) && event.stuckto == self) {
    self.civreacttime = gettime() + function_51e25764b9a2f1b1("small");
    self.var_f73ef0cdee5d001e = "angered";
    return;
  }

  if(eventdistance <= 500) {
    self.civreacttime = gettime() + function_51e25764b9a2f1b1("small");
    self.var_f73ef0cdee5d001e = "curious";
    self._blackboard.var_610cb18ecc1af719 = target;
    self.var_731b4f6bd2e8eb89 = event.originator;
    self.var_bfb728a6bee19f20 = gettime() + function_51e25764b9a2f1b1("medium");
    return;
  }

  if(eventdistance <= 1000 && randomint(3) == 1) {
    self.civreacttime = gettime() + function_51e25764b9a2f1b1("small");
    self.var_f73ef0cdee5d001e = "curious";
  }
}

function function_befe366dded94832() {
  runpath = function_a9e8cc25edfd1488(1);
  runcheck = getdvarint(@ "hash_18f4855098e19194") == 1 && isai(self) && self.reactdata.runawaycooldown <= 0;

  if(self.attitude == "cower") {
    if(runcheck && randomint(10) <= 3) {
      function_309155e57ee0de92(runpath);
    } else {
      self.var_f73ef0cdee5d001e = "cower";
    }
  } else if(self.attitude == "panicked" || self.attitude == "scared") {
    if(randomint(10) <= 7) {
      self.var_f73ef0cdee5d001e = "cower";
    } else if(runcheck) {
      function_309155e57ee0de92(runpath);
    }
  } else if(randomint(3) == 0) {
    self.var_f73ef0cdee5d001e = "cower";
  } else {
    self.var_f73ef0cdee5d001e = "panicked";
  }

  self.civreacttime = gettime() + function_51e25764b9a2f1b1("small");

  if(isDefined(self.var_f73ef0cdee5d001e)) {
    self.reactdata.runawaycooldown = level.civreactdata.runawaycooldown;
    self.attitudechangequeued = 1;
    self.var_cd4296a99a7e9e7b = undefined;
    self.var_e0f99af636c737b = undefined;
    self.triggeredtimers = undefined;
    self.reactdata.triggeredreactiontype = "relaxed";
    self.reactdata.var_af1d1102ede20fc2 = "relaxed";
    function_35eca80b3823c8b();
  }
}

function function_262d76ab041e99c2(event) {
  function_447f2db6891c228c();
  checkdistance = level.civsightdata.staredistance;

  if(level.civreactdata.wasgunshot && !level.civreactdata.var_cb0412bfad561be1) {
    return;
  }

  if(level.civreactdata.var_cb0412bfad561be1) {
    checkdistance = self.civsightdata.unholsterdistance;
  }

  for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
    civ = level.civreactdata.civs[civindex];

    if(!level.civreactdata.var_cb0412bfad561be1 && isDefined(civ.attitudechangequeued) && civ.attitudechangequeued) {
      continue;
    }

    if(!isDefined(event.position) || !isDefined(event.originator)) {
      player = getclosestplayer(civ.origin);

      if(!isDefined(player)) {
        return;
      }

      event.position = player.origin;
      event.originator = player;
    }

    eventdistance = distance(civ.origin, event.position);

    if(eventdistance <= checkdistance) {
      civ.eventdistance = eventdistance;
      civ.fleefromorigin = event.position;
      civ.reactent = event.originator;

      if(istrue(civ.sightdata.var_21965e18b854f978)) {
        continue;
      }

      if(!isDefined(civ.sightdata.sight_trace_passed)) {
        civ.sightdata.sight_trace_passed = 0;
      }

      level.civsightdata.sight_trace_queue = function_6cf786a6cf335cb9(level.civsightdata.sight_trace_queue, civ);
      civ.sightdata.var_21965e18b854f978 = 1;
      continue;
    }

    civ.reactdata.isglancing = 0;
    civ.var_c637a07b110d6d1a = undefined;
    civ.var_cd4296a99a7e9e7b = undefined;
  }
}

function function_61eac1179884dcf9(civilian) {
  if(istrue(civilian.attitudechangequeued) || istrue(civilian.cooldownqueued)) {
    return;
  }

  if(civilian.attitude == "relaxed") {
    return;
  }

  player = civilian.reactent;

  if(!isDefined(player)) {
    player = getclosestplayer(civilian.origin);
  }

  if(!isDefined(player)) {
    return;
  }

  var_6d10010320439599 = distancesquared(civilian.origin, player.origin);
  enemyinrange = 1;
  heightdelta = abs(civilian.origin[2] - player.origin[2]);

  if(heightdelta > 72) {
    enemyinrange = 0;
  }

  cooldowndistance = level.var_9958731831312749.smalldistance;
  cooldowntime = level.var_9958731831312749.largecooldown;
  newattitude = "relaxed";

  if(civilian.attitude == "panicked" || civilian.attitude == "cower") {
    cooldowntime = level.var_9958731831312749.mediumcooldown;
    cooldowndistance = level.var_9958731831312749.mediumdistance;
    newattitude = "scared";
  } else if(civilian.attitude == "scared") {
    cooldowntime = level.var_9958731831312749.mediumcooldown;
    cooldowndistance = level.var_9958731831312749.mediumdistance;
    newattitude = "curious";
  } else if(civilian.attitude == "angered") {
    cooldowntime = level.var_9958731831312749.mediumcooldown;
    cooldowndistance = level.var_9958731831312749.mediumdistance;
    newattitude = "relaxed";
  } else {
    cooldowntime = level.var_9958731831312749.smallcooldown;
    newattitude = "relaxed";
  }

  if(enemyinrange && !level.civreactdata.forcecooldown) {
    if(var_6d10010320439599 < cooldowndistance * cooldowndistance) {
      return;
    }
  }

  if(level.civreactdata.forcecooldown) {
    cooldowndistance = 0;
    level.civreactdata.forcecooldown = 0;
  }

  civilian.cooldownqueued = 1;
  civilian.civreacttime = gettime() + cooldowntime * level.var_9958731831312749.secsmultiplier + function_51e25764b9a2f1b1("extra_large");
  civilian.var_f73ef0cdee5d001e = newattitude;
  civilian.var_84c1ae8d0dce5970 = 1;
  civilian._blackboard.var_610cb18ecc1af719 = undefined;
}

function function_2965d2916e126b37(eventname, originator, origin, radius) {
  entarray = getentarrayinradius("civ_cap", "target", origin, radius);

  for(capindex = 0; capindex < entarray.size; capindex++) {
    entarray[capindex] notify("cap_event", eventname, originator);
  }
}

function function_5739996c28d6429f(grenade, objweapon) {
  grenade waittill("missile_stuck", stuckto, null, null, null, position, hitnormal);
  eventname = "grenade";

  if(objweapon.basename == "bottle") {
    eventname = "bottleThrow";
  }

  function_cac704adccfe911(eventname, "civilian", level.player, position, objweapon, stuckto);
}

function function_4ead24a48cd14450(offhand) {
  level endon("civreact_terminate");

  while(true) {
    self waittill("grenade_fire", grenade, objweapon);
    thread function_5739996c28d6429f(grenade, objweapon);
    waitframe();
  }
}

function function_63decb4f6cdcf09a() {
  level endon("civreact_terminate");

  if(!flag_exist("weapon_unholstered")) {
    return;
  }

  while(true) {
    while(!flag("weapon_unholstered")) {
      waitframe();
    }

    if(!level.civreactdata.var_cb0412bfad561be1) {
      level.civreactdata.var_cb0412bfad561be1 = 1;
      function_35eca80b3823c8b();
      function_cac704adccfe911("lookAt", "level");
    }

    while(flag("weapon_unholstered")) {
      waitframe();
    }

    if(level.civreactdata.var_cb0412bfad561be1) {
      level.civreactdata.var_cb0412bfad561be1 = 0;
      function_35eca80b3823c8b();
      function_cac704adccfe911("lookAt", "level");
    }

    waitframe();
  }
}

function function_a5c5d7e306852a60() {
  level endon("civreact_terminate");

  while(true) {
    self waittill("weapon_fired", objweapon);
    bissilenced = objweapon issilenced();

    if(gettime() < level.civreactdata.gunshottimer) {
      level.civreactdata.gunshottimer = gettime() + level.civreactdata.gunshotcooldown;
      continue;
    }

    if(bissilenced) {
      function_cac704adccfe911("silenced_shot", "civilian", self, self.origin);
    } else {
      function_cac704adccfe911("gunshot", "civilian", self, self.origin);
      level.civreactdata.wasgunshot = 1;
    }

    level.civreactdata.gunshottimer = gettime() + level.civreactdata.gunshotcooldown;
  }
}

function function_f8ec45e1854c97bc() {
  level endon("civreact_terminate");

  while(true) {
    while(self meleeButtonPressed()) {
      waitframe();
    }

    self waittill("melee");

    if(gettime() < level.civreactdata.meleetimer) {
      level.civreactdata.meleetimer = gettime() + level.civreactdata.meleecooldown;
      continue;
    }

    function_cac704adccfe911("melee", "civilian", self, self.origin);
    level.civreactdata.meleetimer = gettime() + level.civreactdata.meleecooldown;
  }
}

function function_c17e63bc92f46e3e() {
  if(utility::issp()) {
    while(!isDefined(level.player)) {
      waitframe();
    }
  }

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      player thread function_4ead24a48cd14450();
      player thread function_a5c5d7e306852a60();
      player thread function_f8ec45e1854c97bc();
    }

    return;
  }

  level.player thread function_4ead24a48cd14450();
  level.player thread function_a5c5d7e306852a60();
  level.player thread function_63decb4f6cdcf09a();
  level.player thread function_f8ec45e1854c97bc();
}

function function_dc2bce7e852d197b(civindex) {
  civ = level.civreactdata.civs[civindex];
  level.civreactdata.bulletwhizbytimers[civindex] = 0;
  level.civreactdata.bulletwhizbyoccurred[civindex] = 0;
  civ thread function_4585228f63bec744();
}

function function_b318dc6f26328b88(attitude, time, override, var_62370ee9083222cb, followuptime) {
  if(isDefined(self.capgroup)) {
    group = level.capgroups[self.capgroup];

    foreach(ent in group) {
      ent function_e64776b765c9b869(attitude, time, override, var_62370ee9083222cb, followuptime);
    }

    return;
  }

  function_e64776b765c9b869(attitude, time, override, var_62370ee9083222cb, followuptime);
}

function function_e64776b765c9b869(attitude, time, override, var_62370ee9083222cb, followuptime) {
  self.civreacttime = time;
  self.var_f73ef0cdee5d001e = attitude;
  self.var_84c1ae8d0dce5970 = override;

  if(var_62370ee9083222cb != attitude) {
    self.var_e032f690711396e6 = var_62370ee9083222cb;
    self.var_83b37a7080fd5c11 = followuptime;
  }
}

function function_442900a9a1893842() {
  function_c984f2a1e4436eba();
  function_447f2db6891c228c();
  level thread function_929576cfa3ada541();
  function_c17e63bc92f46e3e();
  function_cac704adccfe911("lookAt", "level");

  level thread function_1d44ab1df1d7d067();
}

function function_929576cfa3ada541() {
  level endon("civreact_terminate");
  eventhandlers = [];
  eventhandlers["gunshot"] = &function_384465a3a8aa24f7;
  eventhandlers["silenced_shot"] = &function_fbdb93097601737a;
  eventhandlers["melee"] = &function_a4962be231e7f4cf;
  eventhandlers["bottleThrow"] = &function_87d532954468d789;
  eventhandlers["lookAt"] = &function_262d76ab041e99c2;

  while(true) {
    assert(level.civreactdata.events.array.size <= 5);
    eventhandler = undefined;
    event = undefined;
    time = gettime();
    level.civreactdata.civs = array_removeundefined(level.civreactdata.civs);

    if(level.civreactdata.events.array.size > 0) {
      event = queue_peek(level.civreactdata.events);
      eventhandler = eventhandlers[event.type];

      if(event.entitytype == "level") {
        level[[eventhandler]](event);
        eventhandler = undefined;
      }

      level.civreactdata.events = function_93def91a50927481(level.civreactdata.events);
    } else if(!isDefined(level.civsightdata.sight_trace_queue) || queue_isempty(level.civsightdata.sight_trace_queue)) {
      function_cac704adccfe911("lookAt", "level");
    }

    for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
      civ = level.civreactdata.civs[civindex];

      if(!isDefined(civ)) {
        continue;
      }

      capanimset = self findoverridearchetype("animscript");

      if(isDefined(civ.var_8effd09d2c6077d7) && (!isDefined(capanimset) || civ.var_8effd09d2c6077d7 != capanimset) && !istrue(civ.reactdata.capreset)) {
        if(istrue(civ.var_35336d0f72f57871) && isDefined(civ.reactdata)) {
          civ thread function_e0bae58f26ee1323();
        } else {
          function_405bf7cde917b70e(civ);
          civ.var_8effd09d2c6077d7 = undefined;
          break;
        }
      }

      if(istrue(civ.reactdata.var_2141f7cb7ff397a6) || istrue(civ.reactdata.forcerunactive) || istrue(civ.reactdata.walkback)) {
        continue;
      }

      if(istrue(civ.ishostage)) {
        continue;
      }

      if(level.civreactdata.bulletwhizbyoccurred[civindex]) {
        civ function_befe366dded94832();
        level.civreactdata.bulletwhizbyoccurred[civindex] = 0;
      } else if(isDefined(eventhandler)) {
        civ[[eventhandler]](event);
      }

      if(!isDefined(civ.var_f73ef0cdee5d001e)) {
        if(isDefined(civ.attitudechangequeued)) {
          civ.attitudechangequeued = 0;
        }
      }

      if(isDefined(civ.var_731b4f6bd2e8eb89) && time >= civ.var_bfb728a6bee19f20) {
        civ._blackboard.var_610cb18ecc1af719 = civ.var_731b4f6bd2e8eb89;
        civ.var_731b4f6bd2e8eb89 = undefined;
        civ.var_bfb728a6bee19f20 = undefined;
      }

      if(isDefined(civ.var_f73ef0cdee5d001e) && time >= civ.civreacttime) {
        newattitude = civ.var_f73ef0cdee5d001e;
        player = getclosestplayer(civ.origin);

        if(istrue(civ.cooldownqueued)) {
          if(function_b1eeb1edab8e23d4(player, civ, 0)) {
            if(level.civreactdata.attitudepriority[newattitude] <= level.civreactdata.attitudepriority[civ.attitude]) {
              continue;
            } else {
              civ.var_84c1ae8d0dce5970 = undefined;
              civ.cooldownqueued = undefined;
            }
          } else {
            civ._blackboard.var_610cb18ecc1af719 = undefined;
          }
        }

        civ.reactdata.triggeredreactiontype = "relaxed";

        if(newattitude == "panicked" && civ.attitude == "panicked" || newattitude == "cower" && civ.attitude == "cower") {
          civ._blackboard.retriggerpanic = 1;
        } else if(level.civreactdata.attitudepriority[newattitude] > level.civreactdata.attitudepriority[civ.attitude] || istrue(civ.var_84c1ae8d0dce5970)) {
          civ.prevattitude = civ.attitude;
          civ.attitude = newattitude;
        }

        if(isDefined(civ.var_e032f690711396e6)) {
          civ.var_f73ef0cdee5d001e = civ.var_e032f690711396e6;
          civ.civreacttime = civ.var_83b37a7080fd5c11;
          civ.var_84c1ae8d0dce5970 = civ.var_14c9c06bc882eee8;
          civ.var_e032f690711396e6 = undefined;
          civ.var_83b37a7080fd5c11 = undefined;
          civ.var_14c9c06bc882eee8 = undefined;
        } else {
          civ.var_f73ef0cdee5d001e = undefined;
          civ.civreacttime = undefined;
          civ.var_84c1ae8d0dce5970 = undefined;

          if(isDefined(civ.attitudechangequeued)) {
            civ.attitudechangequeued = 0;
          }

          if(isDefined(civ.cooldownqueued)) {
            civ.cooldownqueued = 0;
          }
        }

        continue;
      }

      if(!level.civreactdata.wasgunshot && civ.reactdata.triggeredreactiontype != "relaxed") {
        function_a1469580c494459c(civ);
        continue;
      }

      if(!level.civreactdata.wasgunshot && civ.reactdata.var_af1d1102ede20fc2 != "relaxed") {
        function_59e85ddec8976510(civ);
        continue;
      }

      if(!istrue(civ.cooldownqueued) && !level.civreactdata.var_cb0412bfad561be1) {
        function_61eac1179884dcf9(civ);
      }
    }

    level.civreactdata.var_af1d1102ede20fc2 = "relaxed";
    waitframe();
  }
}

function function_2b93cb073c8caa49(civ) {
  assert(isDefined(level.civreactdata));
  level.civreactdata.civs[level.civreactdata.civs.size] = civ;
  function_dc2bce7e852d197b(level.civreactdata.civs.size - 1);
  civ thread function_8cbbda93904d3a65();
  civ thread function_f44bcfc1647b23f();
}

function function_405bf7cde917b70e(civ) {
  assert(isDefined(level.civreactdata));
  civ notify("civ_deregister");
  civindex = array_find(level.civreactdata.civs, civ);
  level.civreactdata.civs = array_remove(level.civreactdata.civs, civ);
  level.civreactdata.bulletwhizbytimers = array_remove_index(level.civreactdata.bulletwhizbytimers, civindex, 0);
  level.civreactdata.bulletwhizbyoccurred = array_remove_index(level.civreactdata.bulletwhizbyoccurred, civindex, 0);
}

function function_1d44ab1df1d7d067() {
  while(true) {
    while(getdvarint(@ "hash_c544e07187fda60", 0) == 0) {
      wait 1;
    }

    while(getdvarint(@ "hash_c544e07187fda60", 0) != 0) {
      for(civindex = 0; civindex < level.civreactdata.civs.size; civindex++) {
        civ = level.civreactdata.civs[civindex];

        if(isalive(civ) && distancesquared(level.player.origin, civ.origin) < 1048576) {
          if(isDefined(civ.asmname)) {
            print3d(civ.origin + (0, 0, 80), "<dev string:x41>" + civ.asmname, (1, 1, 0), 1, 0.3, 5);
          }

          if(isDefined(civ.animsetname)) {
            print3d(civ.origin + (0, 0, 72), "<dev string:x41>" + civ.animsetname, (1, 1, 0), 1, 0.3, 5);
          }

          state = civ asmgetcurrentstate(civ.asmname);

          if(isDefined(state)) {
            print3d(civ.origin + (0, 0, 64), "<dev string:x41>" + state, (1, 1, 0), 1, 0.3, 5);
          }
        }
      }

      wait 0.25;
    }
  }
}

function function_447f2db6891c228c() {
  if(!isDefined(level.civsightdata.sight_trace_queue)) {
    level.civsightdata.sight_trace_queue = queue_create(level.var_9958731831312749.var_ab47b155a0c0b6e9);
    level thread function_62642d01fcc6fd7b();
  }

  if(!isDefined(level.civsightdata.var_76448df574c47eca)) {
    level.civsightdata.var_76448df574c47eca = queue_create(level.var_9958731831312749.var_ab47b155a0c0b6e9);
    level thread function_731be81501e0bc9d();
  }
}

function function_35eca80b3823c8b() {
  if(isDefined(level.civsightdata.sight_trace_queue)) {
    while(!queue_isempty(level.civsightdata.sight_trace_queue)) {
      civilian = queue_peek(level.civsightdata.sight_trace_queue);
      level.civsightdata.sight_trace_queue = function_93def91a50927481(level.civsightdata.sight_trace_queue);

      if(isDefined(civilian)) {
        civilian.sightdata.var_21965e18b854f978 = 0;
        civilian.sightdata.sight_trace_passed = 0;
        continue;
      }

      waitframe();
    }

    level.civsightdata.sight_trace_queue = undefined;
  }

  if(isDefined(level.civsightdata.var_76448df574c47eca)) {
    while(!queue_isempty(level.civsightdata.var_76448df574c47eca)) {
      civilian = queue_peek(level.civsightdata.var_76448df574c47eca);
      level.civsightdata.var_76448df574c47eca = function_93def91a50927481(level.civsightdata.var_76448df574c47eca);

      if(isDefined(civilian)) {
        civilian.sightdata.var_dd42e0cfcc2298aa = 0;
        civilian.sightdata.var_ee72620ac1467e7f = 0;
        continue;
      }

      waitframe();
    }

    level.civsightdata.var_76448df574c47eca = undefined;
  }

  level notify("civilian_process_eye_look_at");
  level notify("player_look_at_process");
}

function function_62642d01fcc6fd7b() {
  level notify("player_look_at_process");
  level endon("player_look_at_process");
  var_98cfcdbee7100d1 = level.var_9958731831312749.var_7030873a2cb05d89;

  while(true) {
    numtraces = min(var_98cfcdbee7100d1, level.civsightdata.sight_trace_queue.array.size);

    for(i = 0; i < numtraces; i++) {
      civilian = queue_peek(level.civsightdata.sight_trace_queue);
      level.civsightdata.sight_trace_queue = function_93def91a50927481(level.civsightdata.sight_trace_queue);

      if(isDefined(civilian)) {
        player = getclosestplayer(civilian.origin);

        if(!isDefined(player)) {
          continue;
        }

        if(level.civreactdata.var_cb0412bfad561be1) {
          function_8bee41bbdbe247f4(civilian, player);
          continue;
        }

        function_35f7191a1541ef00(civilian, player);
      }
    }

    waitframe();
  }
}

function function_731be81501e0bc9d() {
  level notify("civilian_process_eye_look_at");
  level endon("civilian_process_eye_look_at");
  var_a2f52cef95a01cd6 = level.var_9958731831312749.var_2fe9915eca4d8d12;

  while(true) {
    numtraces = min(var_a2f52cef95a01cd6, level.civsightdata.var_76448df574c47eca.array.size);

    for(i = 0; i < numtraces; i++) {
      civilian = queue_peek(level.civsightdata.var_76448df574c47eca);
      level.civsightdata.var_76448df574c47eca = function_93def91a50927481(level.civsightdata.var_76448df574c47eca);

      if(isDefined(civilian)) {
        player = getclosestplayer(civilian.origin);

        if(!isDefined(player)) {
          continue;
        }

        civilian.sightdata.var_dd42e0cfcc2298aa = undefined;

        if(isai(civilian)) {
          tag_angles = civilian gettagangles("TAG_EYE");
        } else {
          tag_angles = civilian gettagangles("TAG_ORIGIN");
        }

        civilianforward = anglesToForward(tag_angles);
        civilianforward = vectorNormalize(civilianforward);
        sourcetotarget = player.origin - civilian.origin;
        sourcetotarget = vectorNormalize(sourcetotarget);

        if(vectordot(civilianforward, sourcetotarget) >= level.civsightdata.civilianfov) {
          civilian.sightdata.var_ee72620ac1467e7f = 1;
          function_2e4bf288de5058a5(civilian, 1);
        }
      }
    }

    wait level.var_9958731831312749.var_832e9f5262aaa2b2;
  }
}

function function_cac704adccfe911(eventtype, entitytype, originator, position, object, stuckto) {
  newevent = spawnStruct();
  newevent.type = eventtype;
  newevent.entitytype = entitytype;
  newevent.originator = originator;
  newevent.position = position;
  newevent.time = gettime();
  newevent.object = object;
  newevent.stuckto = stuckto;
  function_6cf786a6cf335cb9(level.civreactdata.events, newevent);
}

function function_85c36ebf7018ecfa(asmname, statename, tostatename, params) {
  if(!isDefined(self.attitude)) {
    return 0;
  }

  if(self.attitude == "relaxed" || self.attitude == "panicked") {
    return scripts\asm\cap::function_85eca0a1310a70c(asmname, statename, tostatename, params);
  }

  return 0;
}

function function_c41c4fe8ec2978f7(asmname, statename, tostatename) {
  if(self.reactdata.var_2141f7cb7ff397a6 && self.attitude == "panicked") {
    return true;
  }

  return false;
}

function function_8652e1daf9f118cb() {
  level thread function_df878d36247b150d();
}

function function_df878d36247b150d() {
  level notify("civilian_cap_random_headlook_end");
  level endon("civilian_cap_random_headlook_end");

  while(true) {
    if(!isDefined(level.civs["ending_ai"]) || level.civs["ending_ai"].size == 0) {
      level notify("civilian_cap_random_headlook_end");
      return;
    }

    level.civs["ending_ai"] = array_removeundefined(level.civs["ending_ai"]);
    level.civs["ending_ai"] = array_removedead_or_dying(level.civs["ending_ai"]);

    foreach(civ in level.civs["ending_ai"]) {
      if(!isalive(civ) || !isDefined(civ.using_goto_node) || istrue(civ.disableheadlook)) {
        continue;
      }

      if(!isDefined(civ.headlooksetup)) {
        civ function_1c339daaba3f71db(1);
        civ.headlooksetup = spawnStruct();
        civ.headlooksetup.timeout = 1000;
        civ.headlooksetup.looktime = 0;
        civ.headlooksetup.customtarget = 2;
        civ function_504a5e2df31069a4();
        civ function_1c339daaba3f71db(0);
        timedelay = randomintrange(2000, 3000);
        civ.headlooksetup.looktime = gettime() + timedelay;
      }

      player = getclosestplayer(civ.origin);

      if(!isDefined(player)) {
        continue;
      }

      notwithinfov = !function_b1eeb1edab8e23d4(civ, player, -0.707);

      if(civ.headlooksetup.customtarget == 1 && notwithinfov) {
        civ.headlooksetup.looktime = gettime();
      }

      if(gettime() > civ.headlooksetup.looktime && !istrue(civ.iscap)) {
        civ function_1c339daaba3f71db(1);
        civ function_106bce0aeee91d2c(utility::function_b88f4e5baff057a9(0.2));
        timedelay = 0;

        if(civ.headlooksetup.customtarget == 1 || notwithinfov) {
          civ function_504a5e2df31069a4();
          civ function_1c339daaba3f71db(0);
          civ.headlooksetup.customtarget = 2;
          timedelay = randomintrange(2000, 3000);
        } else {
          civ._blackboard.var_610cb18ecc1af719 = undefined;
          civ scripts\asm\cap::function_7495a975f79b957(player);
          civ.headlooksetup.customtarget = 1;
          timedelay = randomintrange(500, 750);
        }

        civ.headlooksetup.looktime = gettime() + timedelay;
      }
    }

    waitframe();
  }
}

function function_bdddad63d480f563() {
  level notify("civilian_gl_ending_caps_reaction");
  level endon("civilian_gl_ending_caps_reaction");

  while(true) {
    time = gettime();
    level.civs["ending_cap"] = array_removeundefined(level.civs["ending_cap"]);
    level.civs["ending_cap"] = array_removedead_or_dying(level.civs["ending_cap"]);

    if(isDefined(level.civs["cellPhoneGuy"]) && isDefined(level.civs["cellPhoneGuy"].var_f73ef0cdee5d001e) && time >= level.civs["cellPhoneGuy"].civreacttime) {
      newattitude = level.civs["cellPhoneGuy"].var_f73ef0cdee5d001e;

      if(level.civreactdata.attitudepriority[newattitude] > level.civreactdata.attitudepriority[level.civs["cellPhoneGuy"].attitude] || istrue(level.civs["cellPhoneGuy"].var_84c1ae8d0dce5970)) {
        level.civs["cellPhoneGuy"].prevattitude = level.civs["cellPhoneGuy"].attitude;
        level.civs["cellPhoneGuy"].attitude = newattitude;
      }

      level.civs["cellPhoneGuy"].var_f73ef0cdee5d001e = undefined;
      level.civs["cellPhoneGuy"].civreacttime = undefined;
      level.civs["cellPhoneGuy"].var_84c1ae8d0dce5970 = undefined;
    }

    if(isDefined(level.civs["ending_church_grp"]) && level.civs["ending_church_grp"].size > 0) {
      level.civs["ending_church_grp"] = array_removeundefined(level.civs["ending_church_grp"]);
      level.civs["ending_church_grp"] = array_removedead_or_dying(level.civs["ending_church_grp"]);

      foreach(civ in level.civs["ending_church_grp"]) {
        if(isDefined(civ.var_f73ef0cdee5d001e) && time >= civ.civreacttime) {
          newattitude = civ.var_f73ef0cdee5d001e;

          if(level.civreactdata.attitudepriority[newattitude] > level.civreactdata.attitudepriority[civ.attitude] || istrue(civ.var_84c1ae8d0dce5970)) {
            civ.prevattitude = civ.attitude;
            civ.attitude = newattitude;
          }

          civ.var_f73ef0cdee5d001e = undefined;
          civ.civreacttime = undefined;
          civ.var_84c1ae8d0dce5970 = undefined;
        }
      }
    }

    foreach(civ in level.civs["ending_cap"]) {
      if(isDefined(civ.var_f73ef0cdee5d001e) && time >= civ.civreacttime) {
        newattitude = civ.var_f73ef0cdee5d001e;

        if(newattitude == "panicked" && civ.attitude == "panicked") {
          civ._blackboard.retriggerpanic = 1;
        } else if(level.civreactdata.attitudepriority[newattitude] > level.civreactdata.attitudepriority[civ.attitude] || istrue(civ.var_84c1ae8d0dce5970)) {
          civ.prevattitude = civ.attitude;
          civ.attitude = newattitude;
        }

        civ.var_f73ef0cdee5d001e = undefined;
        civ.civreacttime = undefined;
        civ.var_84c1ae8d0dce5970 = undefined;
      }
    }

    waitframe();
  }
}

function function_e703112e44ace0bb() {
  level thread function_4ec9b795d4c490d7();
  level thread function_2ec0f8c971eda828();
  level thread function_89051fa78d0f0af7();
  level thread function_3e7e8e0bd69a89f7();
  level thread function_cd4c7a39360d8657();
}

function function_4ec9b795d4c490d7() {
  level notify("civilian_gl_ending_caps_watcher_HVT_running");
  level endon("civilian_gl_ending_caps_watcher_HVT_running");
  level endon("civreact_terminate");

  while(true) {
    level waittill("hvt_running");

    if(isDefined(level.civs["cellPhoneGuy"])) {
      level.civs["cellPhoneGuy"].var_f73ef0cdee5d001e = "panicked";
      level.civs["cellPhoneGuy"].civreacttime = gettime() + randomintrange(0, 500);
    }

    function_9eab2622d3518f80();
    function_6145ab8334e20d85(level.player);
    waitframe();
  }
}

function function_2ec0f8c971eda828() {
  level notify("civilian_gl_ending_caps_Watcher_HVT_Shot");
  level endon("civilian_gl_ending_caps_Watcher_HVT_Shot");
  level endon("civreact_terminate");

  while(true) {
    level waittill("hvt_shot");
    function_6145ab8334e20d85(level.player, 1);
    waitframe();
  }
}

function function_89051fa78d0f0af7() {
  level notify("civilian_gl_ending_caps_watcher_mom_shot");
  level endon("civilian_gl_ending_caps_watcher_mom_shot");
  level endon("civreact_terminate");

  while(true) {
    level waittill("mom_shot_by_hvt");
    function_6145ab8334e20d85(level.carteltarget);
    waitframe();
  }
}

function function_3e7e8e0bd69a89f7() {
  level notify("civilian_gl_ending_caps_watcher_player_shoots");
  level endon("civilian_gl_ending_caps_watcher_player_shoots");
  level endon("civreact_terminate");

  while(true) {
    level.player waittill("weapon_fired");
    function_6145ab8334e20d85(level.player);
    waitframe();
  }
}

function function_cd4c7a39360d8657() {
  level notify("civilian_gl_ending_caps_watcher_kid_hostage");
  level endon("civilian_gl_ending_caps_watcher_kid_hostage");
  level endon("civreact_terminate");

  while(true) {
    level waittill("kid_is_a_hostage");
    function_c3b1c08c4de97f52();
    waitframe();
  }
}

function function_c3b1c08c4de97f52() {
  level.civs["ending_cap"] = array_removeundefined(level.civs["ending_cap"]);
  level.civs["ending_cap"] = array_removedead_or_dying(level.civs["ending_cap"]);

  foreach(civ in level.civs["ending_cap"]) {
    if(distance(civ.origin, level.carteltarget.origin) <= 230) {
      civ._blackboard.var_610cb18ecc1af719 = level.carteltarget;
      continue;
    }

    civ._blackboard.var_610cb18ecc1af719 = undefined;
  }
}

function function_9eab2622d3518f80() {
  if(!isDefined(level.civs["ending_church_grp"]) || level.civs["ending_church_grp"].size == 0) {
    return;
  }

  foreach(civ in level.civs["ending_church_grp"]) {
    civ.var_f73ef0cdee5d001e = "panicked";
    civ.civreacttime = gettime() + randomintrange(1000, 1500);
  }
}

function function_a5a743ce26ef37b5(animset) {
  if(isDefined(animset) && (animset == "cap_civ_react_4" || animset == "cap_civ_react_4_female")) {
    return false;
  }

  return true;
}

function function_6145ab8334e20d85(source, var_bc807aa760828d81) {
  source endon("death");
  level.civs["ending_cap"] = array_removeundefined(level.civs["ending_cap"]);
  level.civs["ending_cap"] = array_removedead_or_dying(level.civs["ending_cap"]);

  foreach(civ in level.civs["ending_cap"]) {
    if(!isDefined(civ)) {
      continue;
    }

    if(source == level.carteltarget || istrue(var_bc807aa760828d81) && isDefined(level.carteltarget) && distance(level.carteltarget.origin, civ.origin) <= 350 && randomint(4) <= 1) {
      civ._blackboard.var_610cb18ecc1af719 = level.carteltarget;
    } else {
      civ._blackboard.var_610cb18ecc1af719 = undefined;
    }

    dist = distance(civ.origin, source.origin);

    if(dist <= 500) {
      if(civ.attitude == "cower") {} else if(civ.attitude != "panicked" && civ.attitude != "scared") {
        randattitude = randomint(10);

        if(randattitude <= 2) {
          civ.var_f73ef0cdee5d001e = "scared";
        } else {
          civ.var_f73ef0cdee5d001e = "panicked";
        }
      } else if(civ.attitude != "panicked") {
        civ.var_f73ef0cdee5d001e = "panicked";
      } else if(!function_a5a743ce26ef37b5(civ.animset) || randomint(3) == 0 && !function_b1eeb1edab8e23d4(source, civ, level.civsightdata.gunfov)) {
        civ.var_f73ef0cdee5d001e = "cower";
      } else {
        civ.var_f73ef0cdee5d001e = "panicked";
      }

      civ.civreacttime = gettime() + randomintrange(0, int(dist / 2));
      continue;
    }

    if(dist <= 1000) {
      if(civ.attitude == "cower") {} else if(civ.attitude == "panicked") {
        if(!function_a5a743ce26ef37b5(civ.animset) || randomint(3) == 0) {
          civ.var_f73ef0cdee5d001e = "cower";
        } else {
          civ.var_f73ef0cdee5d001e = "panicked";
        }
      } else if(civ.attitude != "scared") {
        randattitude = randomint(10);

        if(randattitude <= 4) {
          civ.var_f73ef0cdee5d001e = "scared";
        } else {
          civ.var_f73ef0cdee5d001e = "panicked";
        }
      } else {
        civ.var_f73ef0cdee5d001e = "panicked";
      }

      civ.civreacttime = gettime() + randomintrange(0, int(dist / 2));
      continue;
    }

    if(civ.attitude == "cower") {} else if(civ.attitude == "panicked") {
      if(!function_a5a743ce26ef37b5(civ.animset) || randomint(3) == 0) {
        civ.var_f73ef0cdee5d001e = "cower";
      } else {
        civ.var_f73ef0cdee5d001e = "panicked";
      }
    } else if(civ.attitude == "scared") {
      civ.var_f73ef0cdee5d001e = "panicked";
    } else if(civ.attitude != "curious") {
      randattitude = randomint(10);

      if(randattitude <= 6) {
        civ.var_f73ef0cdee5d001e = "curious";
      } else if(randattitude <= 8) {
        civ.var_f73ef0cdee5d001e = "scared";
      } else {
        civ.var_f73ef0cdee5d001e = "panicked";
      }
    } else {
      civ.var_f73ef0cdee5d001e = "scared";
    }

    civ.civreacttime = gettime() + 500 + randomintrange(0, int(dist));
  }
}

function getclosestplayer(testorigin) {
  if(utility::ismp()) {
    possibleplayers = [];

    foreach(player in level.players) {
      if(!isalive(player) || isDefined(player.fauxdead) || istrue(player.delayedspawnedplayernotify)) {
        continue;
      }

      possibleplayers[possibleplayers.size] = player;
    }

    if(possibleplayers.size == 0) {
      return sortbydistance(level.players, testorigin)[0];
    } else if(possibleplayers.size == 1) {
      return possibleplayers[0];
    } else {
      return sortbydistance(possibleplayers, testorigin)[0];
    }

    return;
  }

  return level.player;
}