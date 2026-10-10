/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\dof.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace dof;

function function_9030ff462f3daa1a() {
  version = getbuildversion();

  if(version == "SHIP") {
    return;
  }

  dvarclientnum = @ "hash_7dc7c389e33f9f1c";
  setdvarifuninitialized(dvarclientnum, 0);
  dvarenable = @ "hash_8ab43a47c4399064";
  setdvarifuninitialized(dvarenable, 0);
  var_37728f5d1856d25e = @ "hash_d4c10f4069a2675f";
  setdvarifuninitialized(var_37728f5d1856d25e, 1.2);
  var_b8424bec9ba28117 = @ "hash_20eee357db89fae8";
  setdvarifuninitialized(var_b8424bec9ba28117, 5);
  var_f2d0ba32b887ffdf = @ "hash_39ab5edeb8210902";
  setdvarifuninitialized(var_f2d0ba32b887ffdf, 5);
  values = [];
  values[var_37728f5d1856d25e] = -1;
  values[var_b8424bec9ba28117] = -1;
  values[var_f2d0ba32b887ffdf] = -1;
  clientnum = -1;
  var_18d25e8c9f508a2b = 0;

  while(true) {
    wait 1;

    if(!getdvarint(dvarenable)) {
      if(var_18d25e8c9f508a2b) {
        var_18d25e8c9f508a2b = 0;
        level notify("stop_dyndof");
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      continue;
    }

    if(utility::ismp() && getdvarint(dvarclientnum) != clientnum) {
      while(true) {
        clientnum = getdvarint(dvarclientnum);

        if(isDefined(function_cb47153207fc68d2(clientnum))) {
          break;
        }

        waitframe();
      }

      function_db7bae3d5d2e993(function_cb47153207fc68d2(clientnum));
    }

    dvarchanged = 0;

    foreach(dvar, val in values) {
      if(val != getdvarfloat(dvar)) {
        dvarchanged = 1;
        break;
      }
    }

    if(dvarchanged || !var_18d25e8c9f508a2b) {
      fstop = getdvarfloat(var_37728f5d1856d25e);
      focusspeed = getdvarfloat(var_b8424bec9ba28117);
      aperturespeed = getdvarfloat(var_f2d0ba32b887ffdf);
      values[var_37728f5d1856d25e] = fstop;
      values[var_b8424bec9ba28117] = focusspeed;
      values[var_f2d0ba32b887ffdf] = aperturespeed;
      var_18d25e8c9f508a2b = 1;
      level thread function_c1f42ed707642a04(fstop, focusspeed, aperturespeed);
    }
  }
}

function private function_db7bae3d5d2e993(player) {
  if(!isDefined(level.dyndof)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  level.dyndof notify("new_player");

  if(isDefined(level.dyndof.player)) {
    level.dyndof.player disablephysicaldepthoffieldscripting();
    player enablephysicaldepthoffieldscripting();
  }

  level.dyndof.player = player;
  level.dyndof.ignorelist = [player];

  if(utility::ismp()) {
    thread function_bee71193bca6c80c();
  }
}

function private function_bee71193bca6c80c() {
  level.dyndof endon("new_player");
  level.dyndof.player endon("disconnected");

  while(true) {
    level.dyndof.player waittill("death");

    if(!isDefined(level.dyndof.player)) {
      return;
    }

    level.dyndof.player waittill("spawned");

    if(!isDefined(level.dyndof.player)) {
      return;
    }

    level.dyndof.player enablephysicaldepthoffieldscripting();
  }
}

function private function_cb47153207fc68d2(num) {
  foreach(player in level.players) {
    if(player getentitynumber() == num) {
      return player;
    }
  }

  return undefined;
}

function function_c7a153413fa65e8d(fstop, focusspeed, aperturespeed) {
  level.dyndof.fstop = fstop;
  level.dyndof.focusspeed = focusspeed;
  level.dyndof.aperturespeed = aperturespeed;
}

function function_c1f42ed707642a04(fstop, focusspeed, aperturespeed) {
  if(isDefined(level.dyndof)) {
    function_c7a153413fa65e8d(fstop, focusspeed, aperturespeed);
    return;
  }

  assertex(isDefined(fstop), "<dev string:x1c>");

  if(!isDefined(focusspeed)) {
    focusspeed = 1;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 2;
  }

  level notify("stop_dyndof");

  setdvarifuninitialized(@ "hash_ad68aff4b57edc12", 0);

  if(!flag_exist("dyndofexp_disable")) {
    flag_init("dyndofexp_disable");
  }

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
    level notify("stop_dyndof");
  }

  level.dyndof = function_4a2ce820849a53f7();
  function_c7a153413fa65e8d(fstop, focusspeed, aperturespeed);
  level.dyndof.var_a94780cfbefad9ce = -1;
  level.dyndof.var_a28a7e3e13fa8c7f = 3.5;
  level.dyndof.var_e44cd1048efcca59 = 30;
  level.dyndof.var_e429e3048ed6aa37 = 72;
  level.dyndof.var_21146c5c5d706cbe = focusspeed * 5;
  level.dyndof.var_cfbd6dc46c776a0a = 30;
  level.dyndof.var_cfe077c46c9dc7c0 = 72;
  level.dyndof.var_d453b380dfd6161d = 0;
  level.dyndof.issp = utility::issp();

  if(level.dyndof.issp) {
    setsaveddvar(@ "hash_62c917f9692eb820", 1);
    function_db7bae3d5d2e993(level.player);
  } else {
    function_db7bae3d5d2e993(function_cb47153207fc68d2(getdvarint(@ "hash_7dc7c389e33f9f1c")));
  }

  level.dyndof.player enablephysicaldepthoffieldscripting();
  function_8ec129ee5a53f0bc();
  function_50c7801fc0abbd3a();
  level thread function_91d67d689e8a5ac5();
}

function function_4a2ce820849a53f7() {
  struct = spawnStruct();
  struct.maxfocusdist = 50000;
  struct.contents = function_121b9c1e3a5664af();
  struct.var_e00802ad31e19ee4 = function_e7a3f680f309a5a();
  struct.traceangle = 3;
  struct.prevangles = (0, 0, 0);
  struct.prevorigin = (0, 0, 0);
  return struct;
}

function function_121b9c1e3a5664af() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water", "physicscontents_characterproxy"];
  return physics_createcontents(contents);
}

function function_e7a3f680f309a5a() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(contents);
}

function function_91d67d689e8a5ac5() {
  level endon("stop_dyndof");
  var_eb2609c9a7a036f = gettime() + 500;
  currentplayerfov = level.dyndof.var_d453b380dfd6161d;
  setdvarifuninitialized(@ "hash_9f25a07838d65086", 1);
  var_d6656715a63c5ac = 0;

  while(true) {
    if(flag("dyndofexp_disable") || !getdvarint(@ "hash_9f25a07838d65086")) {
      if(!var_d6656715a63c5ac) {
        var_d6656715a63c5ac = 1;
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      wait 0.5;
      continue;
    }

    if(var_d6656715a63c5ac) {
      level.dyndof.player enablephysicaldepthoffieldscripting();
      var_d6656715a63c5ac = 0;
    }

    if(!isDefined(level.dyndof.player)) {
      wait 0.5;
      continue;
    }

    if(gettime() > var_eb2609c9a7a036f) {
      var_eb2609c9a7a036f = gettime() + 500;
      function_8ec129ee5a53f0bc();
      currentplayerfov = level.dyndof.var_d453b380dfd6161d;
    }

    object = function_ddd1e6b7bd85c6d1();

    if(getdvarint(@ "hash_ad68aff4b57edc12", 0)) {
      line(level.dyndof.player.origin, object.origin, (0, 0.7, 0));
    }

    if(object.dofdist < level.dyndof.var_e429e3048ed6aa37) {
      frac = math::normalize_value(level.dyndof.var_e44cd1048efcca59, level.dyndof.var_e429e3048ed6aa37, object.dofdist);
      fstop = math::lerp(level.dyndof.var_a28a7e3e13fa8c7f, level.dyndof.fstop, frac);
    } else {
      fstop = level.dyndof.fstop;
    }

    if(object.dofdist < level.dyndof.var_cfe077c46c9dc7c0) {
      frac = math::normalize_value(level.dyndof.var_cfbd6dc46c776a0a, level.dyndof.var_cfe077c46c9dc7c0, object.dofdist);
      focusspeed = math::lerp(level.dyndof.var_21146c5c5d706cbe, level.dyndof.focusspeed, frac);
    } else {
      focusspeed = level.dyndof.focusspeed;
    }

    level.dyndof.player setphysicaldepthoffield(fstop, 1, focusspeed, level.dyndof.aperturespeed, object.origin);
    waitframe();
  }
}

function function_ddd1e6b7bd85c6d1() {
  self endon("death");
  playereyeorigin = function_7641c664cf37b604();
  playerviewangles = level.dyndof.player getplayerangles();
  level.dyndof.prevorigin = playereyeorigin;
  level.dyndof.prevangles = playerviewangles;
  var_cab8f864ac7d1b1 = function_b23eb6ebe631ccdc(playereyeorigin, playerviewangles);

  if(getdvarint(@ "hash_ad68aff4b57edc12") == 3) {
    var_cab8f864ac7d1b1.var_ca6d02ada0248c95 = 0;
  }

  var_a3d92abc0bca4a49 = function_ac3ec9d38fd2434(playereyeorigin, playerviewangles);

  if(getdvarint(@ "hash_ad68aff4b57edc12") == 4) {
    var_a3d92abc0bca4a49.dofscore = 0;
  }

  if(isDefined(var_a3d92abc0bca4a49) && var_a3d92abc0bca4a49.dofscore > var_cab8f864ac7d1b1.var_ca6d02ada0248c95) {
    if(getdvarint(@ "hash_ad68aff4b57edc12")) {
      printtoscreen2d(10, 800 + 30, "<dev string:x32>", (1, 1, 1), 1.5);

      sphere(var_a3d92abc0bca4a49.origin, 4, (1, 1, 1));
    }

    return var_a3d92abc0bca4a49;
  }

  if(getdvarint(@ "hash_ad68aff4b57edc12")) {
    printtoscreen2d(10, 800 + 30, "<dev string:x42>", (1, 1, 1), 1.5);
  }

  return var_cab8f864ac7d1b1;
}

function function_8ec129ee5a53f0bc() {
  basefovdvar = getdvarint(@ "hash_b38fcf293d1e91a8");

  if(getdvarint(@ "hash_b38fcf293d1e91a8") == level.dyndof.var_d453b380dfd6161d) {
    return;
  }

  x_segments = 8;
  y_segments = 4;
  angle = basefovdvar * 0.6 / x_segments;
  level.dyndof.var_d453b380dfd6161d = basefovdvar;
  var_801c42d2e14b7c0c = angle * x_segments * -1;
  var_6b84c5404b57e175 = angle * y_segments * -1;
  var_c57c437404405a37 = x_segments * 2;
  var_4c1dec663db42f82 = y_segments * 2;
  anglesarray[0][0] = 0;
  minvalue = 12000;
  maxvalue = 0;

  for(x = 0; x < var_c57c437404405a37 + 1; x++) {
    for(y = 0; y < var_4c1dec663db42f82 + 1; y++) {
      struct = spawnStruct();
      struct.addangles = (y * angle + var_6b84c5404b57e175, x * angle + var_801c42d2e14b7c0c, 0);
      anglesarray[x][y] = struct;
      centerscore = x_segments - abs(x_segments - x) + y_segments - abs(y_segments - y);
      struct.centerscale = exp(centerscore * 1);

      if(struct.centerscale > maxvalue) {
        maxvalue = struct.centerscale;
        continue;
      }

      if(struct.centerscale < minvalue) {
        minvalue = struct.centerscale;
      }
    }
  }

  level.dyndof.var_e2a735ff704c61aa = anglesarray[x_segments][y_segments];

  foreach(x, array in anglesarray) {
    foreach(y, struct in array) {
      struct.centerscale = math::normalize_value(minvalue, maxvalue, struct.centerscale) * 10;
    }
  }

  level.dyndof.tracestructs = anglesarray;
}

function function_b23eb6ebe631ccdc(playereyeorigin, playerviewangles) {
  traces = [];
  distances = 0;
  closeststruct = undefined;

  foreach(array in level.dyndof.tracestructs) {
    foreach(struct in array) {
      struct.trace = function_77d9a6389a3305ee(playereyeorigin, playerviewangles, struct.addangles);
      struct.origin = struct.trace["position"];
      struct.dofdist = distance(playereyeorigin, struct.origin);
      distances += struct.dofdist;

      if(!isDefined(closeststruct)) {
        closeststruct = struct;
        continue;
      }

      if(struct.dofdist < closeststruct.dofdist) {
        closeststruct = struct;
      }
    }
  }

  level.dyndof.var_1fef56bc059b6f9a = closeststruct;
  groupscores = [];
  groupcount = [];

  foreach(x, array in level.dyndof.tracestructs) {
    foreach(y, struct in array) {
      div = abs(closeststruct.dofdist - struct.dofdist) / 30;

      if(div > 6) {
        div = 6;
      }

      struct.groupnum = int(max(div, 1));
      groupscale = 1 + math::normalize_value(0, 7, 7 - struct.groupnum);
      struct.dofscore = int(groupscale * struct.centerscale * 10);

      if(!isDefined(groupscores[struct.groupnum])) {
        groupscores[struct.groupnum] = 0;
        groupcount[struct.groupnum] = 0;
      }

      groupscores[struct.groupnum] += struct.dofscore;
      groupcount[struct.groupnum]++;
    }
  }

  keys = getarraykeys(groupscores);
  highestgroup = groupscores[keys[0]];
  var_2f61b87587e59816 = keys[0];

  foreach(index, groupavg in groupscores) {
    if(highestgroup < groupavg) {
      highestgroup = groupavg;
      var_2f61b87587e59816 = index;
    }
  }

  highestscore = 0;
  beststruct = undefined;

  foreach(array in level.dyndof.tracestructs) {
    foreach(struct in array) {
      if(struct.groupnum != var_2f61b87587e59816) {
        continue;
      }

      if(struct.dofscore > highestscore) {
        highestscore = struct.dofscore;
        beststruct = struct;
      }
    }
  }

  if(!isDefined(beststruct)) {
    beststruct = level.dyndof.var_e2a735ff704c61aa;
  }

  if(getdvarint(@ "hash_ad68aff4b57edc12")) {
    printtoscreen2d(10, 800 + 90, "<dev string:x56>" + groupscores[beststruct.groupnum], (1, 1, 1), 1.5);
  }

  beststruct.var_ca6d02ada0248c95 = groupscores[beststruct.groupnum];
  level thread function_abfbc195c3aac94c(playereyeorigin, var_2f61b87587e59816);
  return beststruct;
}

function function_50c7801fc0abbd3a() {
  if(gettime() > level.dyndof.var_a94780cfbefad9ce) {
    level.dyndof.var_a94780cfbefad9ce = gettime() + 1000;
    level.dyndof.cosfov = cos(getdvarfloat(@ "hash_b38fcf293d1e91a8"));
    level.dyndof.var_4cc8f2b112cadde0 = level.dyndof.cosfov * 50;
  }
}

function function_ac3ec9d38fd2434(playereyepos, playerangles) {
  ents = getaiarray();

  if(!level.dyndof.issp) {
    players = [];

    foreach(player in level.players) {
      if(player == level.dyndof.player) {
        continue;
      }

      players[players.size] = player;
    }

    ents = array_combine(ents, players);
  }

  if(isDefined(level.var_7fffa6c3f269ffc9)) {
    ents = array_combine(ents, [[level.var_7fffa6c3f269ffc9]]());
  }

  ents = array_removeundefined(ents);

  foreach(ent in ents) {
    if(ent.classname != "script_model") {
      continue;
    }

    if(isDefined(ent.var_5cb5bea2f8851b21)) {
      continue;
    }

    substr = getsubstr(ent.model, 0, 5);

    if(substr == "body_") {
      ent.var_5cb5bea2f8851b21 = 1;
      continue;
    }

    ent.var_5cb5bea2f8851b21 = 0;
  }

  function_50c7801fc0abbd3a();
  playerforward = anglesToForward(playerangles);

  foreach(ent in ents) {
    ischaracter = 0;

    if(isai(ent) || isDefined(ent.var_5cb5bea2f8851b21) || isPlayer(ent)) {
      ischaracter = 1;
    }

    ent.dofscore = 0;

    if(ischaracter && distancesquared(level.dyndof.player.origin, ent.origin) < 62500) {
      entorigin = function_41ae85dd67830a98(ent, playereyepos, playerforward);
    } else {
      entorigin = ent.origin + (0, 0, 60);
    }

    ent.doftraceorigin = entorigin;
    dot = function_ce15d73cabdc73a4(entorigin, playereyepos, playerforward);
    ent.dofdot = dot;

    if(dot > level.dyndof.cosfov) {
      ndot = math::normalize_value(level.dyndof.cosfov, 1, dot);
      score = pow(ndot, 15) * 1100;
      ent.dofscore += score;

      if(getdvarint(@ "hash_ad68aff4b57edc12")) {
        print3d(entorigin + (0, 0, -5), "<dev string:x6c>" + score + "<dev string:x75>" + dot + "<dev string:x80>", (1, 1, 1), 0.8, 0.2);
      }
    }

    if(ent.dofscore == 0) {
      continue;
    }

    ent.dofdist = distance(entorigin, playereyepos);

    if(ent.dofdist < 2000) {
      if(ent.dofdist < 200) {
        frac = ent.dofdist / 200;
        distscore = 100 + 300 * pow(1 - frac, 2);
        ent.dofscore += distscore;
      } else {
        frac = ent.dofdist / 2000;
        distscore = 100 * (1 - frac);
        ent.dofscore += distscore;
      }

      if(getdvarint(@ "hash_ad68aff4b57edc12")) {
        print3d(entorigin + (0, 0, -10), "<dev string:x85>" + distscore + "<dev string:x8f>" + ent.dofscore + "<dev string:x80>", (1, 1, 1), 0.8, 0.2);
      }
    } else {
      distscale = 2000 / ent.dofdist * 0.5;
      ent.dofscore *= distscale * 0.5;

      if(getdvarint(@ "hash_ad68aff4b57edc12")) {
        print3d(entorigin + (0, 0, -10), "<dev string:x95>" + distscale + "<dev string:x8f>" + ent.dofscore + "<dev string:x80>", (1, 1, 1), 0.8, 0.2);
      }
    }

    if(ent.dofscore > 0) {
      trace = scripts\engine\trace::ray_trace(playereyepos, entorigin, [ent, level.dyndof.player], level.dyndof.contents, 1);

      if(trace["fraction"] > 0.9) {
        scale = 1;
        ent.dofscore *= scale;
      } else {
        scale = 0;
        ent.dofscore = 0;
      }

      if(getdvarint(@ "hash_ad68aff4b57edc12")) {
        print3d(entorigin + (0, 0, -15), "<dev string:xa4>" + scale + "<dev string:x8f>" + ent.dofscore + "<dev string:x80>", (1, 1, 1), 0.8, 0.2);
      }
    }

    ent.dofscore = int(ent.dofscore);

    if(getdvarint(@ "hash_ad68aff4b57edc12")) {
      print3d(entorigin, ent.dofscore, (1, 1, 1), 1, 0.2);
    }
  }

  directents = [];
  var_6e2b9d3e75679206 = level.dyndof.issp;

  if(var_6e2b9d3e75679206) {
    foreach(ent in ents) {
      if(!isPlayer(ent) && !isai(ent) && !isDefined(ent.var_5cb5bea2f8851b21)) {
        continue;
      }

      if(ent.dofscore > 0 && ent.dofdot > 0.9) {
        directents[directents.size] = ent;

        if(getdvarint(@ "hash_ad68aff4b57edc12")) {
          cylinder(ent.origin, ent.origin + (0, 0, 70), 8, (0.5, 0.5, 0.5));
        }
      }
    }

    directents = sortbydistance(directents, playereyepos);
  }

  bestscore = 80;
  bestscoreent = undefined;

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(var_6e2b9d3e75679206 && (isai(ent) || isDefined(ent.var_5cb5bea2f8851b21)) && ent.dofscore > 0 && ent.dofdot > 0.99) {
      foreach(directent in directents) {
        if(directent == ent) {
          continue;
        }

        if(directent.dofdist < ent.dofdist && function_7d02f8d29555766e(playereyepos, ent.doftraceorigin, directent.origin)) {
          ent.dofscore = 0;

          if(getdvarint(@ "hash_ad68aff4b57edc12")) {
            print3d(ent.doftraceorigin + (0, 0, -20), "<dev string:xae>", (1, 1, 1), 0.8, 0.2);

            line(ent.origin, directent.origin, (1, 0, 0));
          }

          break;
        }
      }
    }

    if(ent.dofscore > bestscore) {
      bestscoreent = ent;
      bestscore = ent.dofscore;
    }
  }

  struct = undefined;

  if(isDefined(bestscoreent)) {
    struct = spawnStruct();
    struct.origin = bestscoreent.origin;
    struct.dofscore = bestscoreent.dofscore;
    struct.origin = bestscoreent.doftraceorigin;
    struct.dofdist = bestscoreent.dofdist;

    if(getdvarint(@ "hash_ad68aff4b57edc12")) {
      printtoscreen2d(10, 800 + 60, "<dev string:xc5>" + struct.dofscore, (1, 1, 1), 1.5);
    }
  }

  return struct;
}

function function_41ae85dd67830a98(ent, playereyepos, playerforward) {
  extratags = ["j_spineupper"];
  closesttag = "tag_eye";
  closesttagorigin = ent gettagorigin(closesttag);
  closesttagdot = function_ce15d73cabdc73a4(closesttagorigin, playereyepos, playerforward);

  foreach(tag in extratags) {
    tagorigin = ent gettagorigin(tag);
    dot = function_ce15d73cabdc73a4(tagorigin, playereyepos, playerforward);

    if(dot > closesttagdot) {
      closesttagdot = dot;
      closesttag = tag;
      closesttagorigin = tagorigin;
    }
  }

  return closesttagorigin;
}

function function_ce15d73cabdc73a4(targetorigin, sourcepos, sourceforward) {
  normal = vectorNormalize(targetorigin - sourcepos);
  return vectordot(sourceforward, normal);
}

function function_77d9a6389a3305ee(playereyeorigin, playerangles, addangles, pos) {
  angles = combineangles(playerangles, addangles);

  if(!isDefined(pos)) {
    pos = playereyeorigin + anglesToForward(angles) * level.dyndof.maxfocusdist;
  }

  trace = physics_raycast(playereyeorigin, pos, level.dyndof.var_e00802ad31e19ee4, level.dyndof.ignorelist, 1, "physicsquery_closest", 1);

  if(!isDefined(trace) || trace.size == 0) {
    trace = scripts\engine\trace::internal_pack_default_trace(pos);
  } else {
    trace = trace[0];
  }

  return trace;
}

function function_7641c664cf37b604() {
  if(level.dyndof.player islinked()) {
    linkedent = level.dyndof.player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(hastag(linkedent.model, "tag_camera")) {
          linkedent.dyndof_hastag = 1;
        }
      }
    }

    if(linkedent.dyndof_hastag) {
      return linkedent gettagorigin("tag_camera");
    }
  }

  return level.dyndof.player getvieworigin();
}

function function_abfbc195c3aac94c(playereyeorigin, highestgroup) {
  level notify("stop_dyndof_debug");
  level endon("stop_dyndof");
  level endon("stop_dyndof_debug");

  while(getdvarint(@ "hash_ad68aff4b57edc12")) {
    closestpos = level.dyndof.var_1fef56bc059b6f9a.trace["<dev string:xd7>"];
    closestdist = level.dyndof.var_1fef56bc059b6f9a.dofdist;

    foreach(array in level.dyndof.tracestructs) {
      foreach(struct in array) {
        if((getdvarint(@ "hash_ad68aff4b57edc12") == 2 || getdvarint(@ "hash_ad68aff4b57edc12") == 4) && struct.groupnum != highestgroup) {
          continue;
        }

        switch (struct.groupnum) {
          case 0:
            color = (0, 0.9, 0);
            break;
          case 1:
            color = (0, 1, 1);
            break;
          case 2:
            color = (1, 1, 0);
            break;
          case 3:
            color = (1, 0.5, 0);
            break;
          case 4:
            color = (1, 0, 0);
            break;
          default:
            color = (1, 0, 1);
            break;
        }

        print3d(struct.origin, struct.dofscore, (1, 1, 1), 0.7, 0.05);
        function_28ac1e5f07cc8ea8(struct.trace["<dev string:xd7>"], color);
      }
    }

    radius = math::normalize_value(0, 3000, closestdist);
    radius *= 16;
    sphere(closestpos, radius, (1, 1, 0));
    waitframe();
  }
}

function function_28ac1e5f07cc8ea8(pos, color) {
  range = 1;

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  line(pos - (0, 0, range), pos + (0, 0, range), color, 1, 0);
  line(pos - (0, range, 0), pos + (0, range, 0), color, 1, 0);
  line(pos - (range, 0, 0), pos + (range, 0, 0), color, 1, 0);
}

function function_7d02f8d29555766e(start, end, actorpos) {
  raydir = vectorNormalize(end - start);
  radius = 8;
  actorpos2 = actorpos + (0, 0, 70);
  cline = actorpos2 - actorpos;
  var_a4753fbd89ce084f = start - actorpos;
  var_e3516dba67d45efb = vectorcross(var_a4753fbd89ce084f, cline);
  var_424283857447cee9 = vectorcross(raydir, cline);
  var_9b2f6dd030cc1244 = vectordot(cline, cline);
  a = vectordot(var_424283857447cee9, var_424283857447cee9);
  b = 2 * vectordot(var_424283857447cee9, var_e3516dba67d45efb);
  c = vectordot(var_e3516dba67d45efb, var_e3516dba67d45efb) - radius * radius * var_9b2f6dd030cc1244;
  dist = b * b - 4 * a * c;

  if(dist < 0) {
    return false;
  }

  time = (b * -1 - sqrt(dist)) / 2 * a;

  if(time == length(end - start)) {
    return false;
  }

  if(time < 0) {
    return false;
  }

  intersection = start + raydir * time;
  return true;
}

function dyndof(fstop, targetentity, focusspeed, aperturespeed, angles, var_387062334ab0e50e, ignorelist, ignorecollision, var_4a0992ce3ff1d7ea) {
  assertex(isDefined(fstop), "<dev string:x1c>");
  assertex(!isDefined(targetentity) || isent(targetentity), "<dev string:xe3>");

  if(!isDefined(focusspeed)) {
    focusspeed = 1;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 2;
  }

  if(!isDefined(ignorecollision)) {
    ignorecollision = 0;
  }

  player = self;
  player notify("stop_dyndof");

  setdvarifuninitialized(@ "hash_93ca035fa3964d3d", 0);

  if(utility::issp()) {
    setsaveddvar(@ "hash_62c917f9692eb820", 1);
  }

  player enablephysicaldepthoffieldscripting();

  if(isDefined(player.dyndof)) {
    player.dyndof = player destroy_dyndof();
  }

  player.dyndof = create_dyndof();
  player.dyndof.fstop = fstop;
  player.dyndof.focusspeed = focusspeed;
  player.dyndof.aperturespeed = aperturespeed;

  if(isstring(var_387062334ab0e50e)) {
    player.dyndof.desiredbone = var_387062334ab0e50e;
  } else if(isvector(var_387062334ab0e50e)) {
    player.dyndof.desiredpos = var_387062334ab0e50e;
  } else if(isnumber(var_387062334ab0e50e)) {
    player.dyndof.desireddistance = var_387062334ab0e50e;
  }

  player.dyndof.ignorecollision = ignorecollision;
  player.dyndof.var_4a0992ce3ff1d7ea = var_4a0992ce3ff1d7ea;

  if(isDefined(ignorelist)) {
    player.dyndof.ignorelist = ignorelist;
  } else {
    player.dyndof.ignorelist = [player];
  }

  if(isDefined(angles)) {
    player.dyndof.traceangle = angles;
  }

  player thread dyndof_thread(targetentity);
}

function dyndof_disable() {
  player = self;
  player notify("stop_dyndof");
  player notify("stop_dyndof_debug");
  player disablephysicaldepthoffieldscripting();
  player destroy_dyndof();
}

function private function_a0bbe9bbf0848458() {
  if(self isplayingxcam()) {
    pos = self getxcamposition();
    ang = self getxcamangles();
    return [pos, ang];
  }

  return [self getEye(), self getgunangles()];
}

function dyndof_thread(targetentity) {
  player = self;

  if(isDefined(targetentity)) {
    targetentity endon("death");
  }

  level endon("stop_dyndof");
  player endon("stop_dyndof");

  while(true) {
    if(isDefined(player.dyndof.desiredpos) && player.dyndof.ignorecollision) {
      pos = player.dyndof.desiredpos;
    } else if(isDefined(player.dyndof.desireddistance) && player.dyndof.ignorecollision) {
      [eye, ang] = function_a0bbe9bbf0848458();
      pos = eye + anglesToForward(ang) * player.dyndof.desireddistance;
    } else {
      pos = player dyndof_distance(targetentity);
    }

    if(!isint(pos)) {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos + (0, 0, 1.5), "<dev string:x112>" + pos, (0, 1, 0), 1, 0.1, 1);
        line(pos, pos - (0, 0, 1000), (0, 1, 0), 1, 1, 1);
      }

      player setphysicaldepthoffield(player.dyndof.fstop, 1, player.dyndof.focusspeed, player.dyndof.aperturespeed, pos);
    }

    waitframe();
  }
}

function dyndof_distance(targetentity) {
  player = self;

  if(isDefined(targetentity)) {
    targetentity endon("death");
    closesttrace["entity"] = targetentity;

    if(isent(targetentity) && isDefined(targetentity.model)) {
      if(!isDefined(player.dyndof.bone)) {
        if(isDefined(player.dyndof.desiredbone)) {
          bone = player.dyndof.desiredbone;
        } else {
          bone = "tag_eye";
        }

        closesttrace["position"] = targetentity.origin;
        closesttrace["hittype"] = bone + " DOESN'T EXIST";
        pos = closesttrace["position"];
        closesttrace["hittype"] = bone + " DOESN'T EXIST";
        pos = closesttrace["position"];

        if(isDefined(targetentity.headmodel)) {
          num_parts = getnumparts(targetentity.headmodel);

          for(i = 0; i < num_parts; i++) {
            if(getpartname(targetentity.headmodel, i) == bone) {
              player.dyndof.bone = bone;
              closesttrace["hittype"] = player.dyndof.bone;
              closesttrace["position"] = targetentity gettagorigin(player.dyndof.bone);
              pos = closesttrace["position"];
              break;
            }
          }
        }

        if(isDefined(targetentity.attachedweaponmodels)) {
          foreach(n, model in targetentity.attachedweaponmodels) {
            num_parts = getnumparts(targetentity.attachedweaponmodels[n]);

            for(i = 0; i < num_parts; i++) {
              if(getpartname(targetentity.attachedweaponmodels[n], i) == bone) {
                player.dyndof.bone = bone;
                closesttrace["hittype"] = player.dyndof.bone;
                closesttrace["position"] = targetentity gettagorigin(player.dyndof.bone);
                pos = closesttrace["position"];
                break;
              }
            }
          }
        }

        num_parts = getnumparts(targetentity.model);

        for(i = 0; i < num_parts; i++) {
          if(getpartname(targetentity.model, i) == bone) {
            player.dyndof.bone = bone;
            closesttrace["hittype"] = player.dyndof.bone;
            closesttrace["position"] = targetentity gettagorigin(player.dyndof.bone);
            pos = closesttrace["position"];
            break;
          }
        }
      } else {
        closesttrace["hittype"] = player.dyndof.bone;
        closesttrace["position"] = targetentity gettagorigin(player.dyndof.bone);
        pos = closesttrace["position"];
      }
    } else {
      closesttrace["hittype"] = "struct or no bones";
      closesttrace["position"] = targetentity.origin;
      pos = closesttrace["position"];
    }

    if(isDefined(player worldpointtoscreenpos(pos, getdvarint(@ "hash_b38fcf293d1e91a8"))) && dyndof_trace_target(pos)) {
      if(player.dyndof.prevorigin == pos) {
        return -1;
      }

      player.dyndof.prevorigin = pos;

      player thread dyndof_debug(undefined, closesttrace);

      return closesttrace["position"];
    } else {
      if(istrue(player.dyndof.var_4a0992ce3ff1d7ea)) {
        [player_eye_pos, ang] = function_a0bbe9bbf0848458();
        var_6e20e569f2c0df7f = pos - player_eye_pos;
        player_fwd = anglesToForward(ang);
        dot = vectordot(var_6e20e569f2c0df7f, player_fwd);

        if(dot > 0) {
          var_92f914f8aed12f65 = player_eye_pos + player_fwd * dot;
        } else {
          var_92f914f8aed12f65 = player_eye_pos;
        }

        if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
          line(player.dyndof.prevorigin, var_92f914f8aed12f65, (1, 1, 1), 1, 1);
          print3d(var_92f914f8aed12f65, "<dev string:x123>", (1, 1, 1), 1, 0.1, 1, 1);
          print3d(var_92f914f8aed12f65 + (0, 0, 2), "<dev string:x12a>", (1, 0, 0), 1, 0.1, 1);
        }

        return var_92f914f8aed12f65;
      }

      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos, "<dev string:x123>", (1, 1, 1), 1, 0.1, 1, 1);
        print3d(pos + (0, 0, 2), "<dev string:x160>", (1, 0, 0), 1, 0.1, 1);
      }
    }
  }

  pos = dyndof_getplayerorigin();
  angles = dyndof_getplayerangles();

  if(player.dyndof.prevorigin == pos && player.dyndof.prevangles == angles) {
    if(!isDefined(player.dyndof.firstnomovetime)) {
      player.dyndof.firstnomovetime = gettime();
    } else if(gettime() - player.dyndof.firstnomovetime > 2000) {
      return -1;
    }
  } else {
    player.dyndof.firstnomovetime = undefined;
  }

  player.dyndof.prevorigin = pos;
  player.dyndof.prevangles = angles;
  angles = [];
  angle = player.dyndof.traceangle;
  angles[angles.size] = (angle * -1, 0, 0);
  angles[angles.size] = (0, angle, 0);
  angles[angles.size] = (0, angle * -1, 0);
  angles[angles.size] = (0, 0, 0);
  traces = [];

  foreach(index, a in angles) {
    if(isDefined(player.dyndof.desiredpos)) {
      trace = dyndof_trace_internal(a, player.dyndof.desiredpos);
    } else {
      trace = dyndof_trace_internal(a, undefined);
    }

    if(!isDefined(trace)) {
      continue;
    }

    traces[traces.size] = trace[0];
  }

  if(traces.size == 0) {
    player notify("stop_dyndof_debug");
    return (dyndof_getplayerorigin() + anglesToForward(dyndof_getplayerangles()) * player.dyndof.maxfocusdist);
  }

  index = 0;
  closesttrace = traces[index];

  for(i = 1; i < traces.size; i++) {
    if(traces[i]["fraction"] < closesttrace["fraction"]) {
      closesttrace = traces[i];
    }
  }

  player thread dyndof_debug(traces, closesttrace);

  return closesttrace["position"];
}

function dyndof_trace_internal(angles, pos) {
  player = self;
  assert(isDefined(player));
  playereye = dyndof_getplayerorigin();
  angles = combineangles(dyndof_getplayerangles(), angles);

  if(isDefined(player.dyndof.desireddistance)) {
    forward_distance = player.dyndof.desireddistance;
  } else {
    forward_distance = player.dyndof.maxfocusdist;
  }

  if(!isDefined(pos)) {
    pos = dyndof_getplayerorigin() + anglesToForward(angles) * forward_distance;
  }

  results = physics_raycast(playereye, pos, player.dyndof.contents, player.dyndof.ignorelist, 1, "physicsquery_closest", 1);

  if(getdvarint(@ "hash_93ca035fa3964d3d", 1)) {
    if(!isDefined(results) || results.size == 0) {
      line(playereye, pos, (0.3, 0.3, 0.3));
    }
  }

  return results;
}

function dyndof_trace_target(pos) {
  player = self;
  assert(isDefined(player));

  if(istrue(player.dyndof.ignorecollision)) {
    return true;
  }

  trace = dyndof_trace_internal((0, 0, 0), pos);
  pos_print = pos + (0, 0, 3);

  if(isDefined(trace) && isDefined(trace[0]) && isDefined(trace[0]["position"])) {
    if(distance(trace[0]["position"], pos) < 8) {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos_print, "<dev string:x18f>", (1, 0, 1), 1, 0.1, 1, 1);
        playereye = dyndof_getplayerorigin();
        line(playereye, trace[0]["<dev string:xd7>"], (1, 0, 1));
      }

      return true;
    } else {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos_print, "<dev string:x1a5>", (1, 0, 0), 1, 0.1, 1, 1);
        playereye = dyndof_getplayerorigin();
        line(playereye, trace[0]["<dev string:xd7>"], (1, 0, 0));
      }

      return false;
    }
  }

  if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
    print3d(pos_print, "<dev string:x1b5>", (0, 1, 0), 1, 0.1, 1, 1);
    playereye = dyndof_getplayerorigin();
    line(playereye, pos, (0, 1, 0));
  }

  return true;
}

function dyndof_getplayerorigin() {
  player = self;

  if(player isplayingxcam()) {
    [pos, ang] = player function_a0bbe9bbf0848458();
    return pos;
  }

  if(player islinked()) {
    linkedent = player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(hastag(linkedent.model, "tag_camera")) {
          linkedent.dyndof_hastag = 1;
        }
      }
    }

    if(linkedent.dyndof_hastag) {
      return linkedent gettagorigin("tag_camera");
    }
  }

  return player getvieworigin();
}

function dyndof_getplayerangles() {
  player = self;
  [pos, ang] = player function_a0bbe9bbf0848458();
  return ang;
}

function create_dyndof() {
  struct = spawnStruct();
  struct.maxfocusdist = 50000;
  struct.contents = get_dyndof_contents();
  struct.traceangle = 3;
  struct.prevangles = (0, 0, 0);
  struct.prevorigin = (0, 0, 0);
  return struct;
}

function destroy_dyndof() {
  if(!isDefined(self.dyndof)) {
    return;
  }

  self.dyndof = undefined;
}

function get_dyndof_contents() {
  dof_contents = ["physicscontents_characterproxy", "physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(dof_contents);
}

function dyndof_debug(traces, closesttrace) {
  player = self;
  assert(isDefined(player));
  player notify("stop_dyndof_debug");
  player endon("stop_dyndof");
  player endon("stop_dyndof_debug");

  if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
    while(true) {
      if(!getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        break;
      }

      if(isDefined(traces)) {
        foreach(trace in traces) {
          line(trace["<dev string:xd7>"], dyndof_getplayerorigin() + (0, 0, -1));
        }
      }

      line(closesttrace["<dev string:xd7>"], dyndof_getplayerorigin() + (0, 0, -1), (1, 1, 0));
      value = math::normalize_value(0, 3000, distance(dyndof_getplayerorigin(), closesttrace["<dev string:xd7>"]));
      value *= 32;
      sphere(closesttrace["<dev string:xd7>"], value, (1, 1, 0));
      print3d(closesttrace["<dev string:xd7>"], closesttrace["<dev string:x1c5>"], (1, 1, 1), 1, 0.1, 1);

      if(isDefined(closesttrace["<dev string:x1d0>"]) && isDefined(closesttrace["<dev string:x1d0>"].model)) {
        model = closesttrace["<dev string:x1d0>"].model;

        if(!isDefined(player.var_526ab6a3fcbfa671) || model != player.var_526ab6a3fcbfa671) {
          iprintln("<dev string:x1da>" + model);
          player.var_526ab6a3fcbfa671 = model;
        }

        print3d(closesttrace["<dev string:xd7>"] + (0, 0, -1.5), model, (1, 1, 1), 1, 0.1, 1);
      }

      waitframe();
    }
  }

}