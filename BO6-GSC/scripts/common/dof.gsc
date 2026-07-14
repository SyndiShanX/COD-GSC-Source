/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\dof.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace dof;

function function_55904422b4033469() {
  version = getbuildversion();

  if(version == "SHIP") {
    return;
  }

  dvarclientnum = @ "scr_dyndofexp_clientnum";
  setdvarifuninitialized(dvarclientnum, 0);
  dvarenable = @ "scr_dyndofexp_enable";
  setdvarifuninitialized(dvarenable, 0);
  dvarfstop = @ "scr_dyndofexp_fstop";
  setdvarifuninitialized(dvarfstop, 1.2);
  dvarfocusspeed = @ "scr_dyndofexp_focusspeed";
  setdvarifuninitialized(dvarfocusspeed, 5);
  dvaraperturespeed = @ "scr_dyndofexp_aperturespeed";
  setdvarifuninitialized(dvaraperturespeed, 5);
  values = [];
  values[dvarfstop] = -1;
  values[dvarfocusspeed] = -1;
  values[dvaraperturespeed] = -1;
  clientnum = -1;
  var_5dc6e6a7bf36cb90 = 0;

  while(true) {
    wait 1;

    if(!getdvarint(dvarenable)) {
      if(var_5dc6e6a7bf36cb90) {
        var_5dc6e6a7bf36cb90 = 0;
        level notify("stop_dyndof");
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      continue;
    }

    if(utility::ismp() && getdvarint(dvarclientnum) != clientnum) {
      while(true) {
        clientnum = getdvarint(dvarclientnum);

        if(isDefined(function_b38661f50c4f17c7(clientnum))) {
          break;
        }

        waitframe();
      }

      function_994f6119a93a14a8(function_b38661f50c4f17c7(clientnum));
    }

    dvarchanged = 0;

    foreach(dvar, val in values) {
      if(val != getdvarfloat(dvar)) {
        dvarchanged = 1;
        break;
      }
    }

    if(dvarchanged || !var_5dc6e6a7bf36cb90) {
      fstop = getdvarfloat(dvarfstop);
      focusspeed = getdvarfloat(dvarfocusspeed);
      aperturespeed = getdvarfloat(dvaraperturespeed);
      values[dvarfstop] = fstop;
      values[dvarfocusspeed] = focusspeed;
      values[dvaraperturespeed] = aperturespeed;
      var_5dc6e6a7bf36cb90 = 1;
      level thread dyndofexp_internal(fstop, focusspeed, aperturespeed);
    }
  }
}

function private function_994f6119a93a14a8(player) {
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
    thread function_246cecf019f00b87();
  }
}

function private function_246cecf019f00b87() {
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

function private function_b38661f50c4f17c7(num) {
  foreach(player in level.players) {
    if(player getentitynumber() == num) {
      return player;
    }
  }

  return undefined;
}

function function_deb0a0d97775beae(fstop, focusspeed, aperturespeed) {
  level.dyndof.fstop = fstop;
  level.dyndof.focusspeed = focusspeed;
  level.dyndof.aperturespeed = aperturespeed;
}

function dyndofexp_internal(fstop, focusspeed, aperturespeed) {
  if(isDefined(level.dyndof)) {
    function_deb0a0d97775beae(fstop, focusspeed, aperturespeed);
    return;
  }

  assert(isDefined(fstop), "<dev string:x24>");

  if(!isDefined(focusspeed)) {
    focusspeed = 1;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 2;
  }

  level notify("stop_dyndof");

  setdvarifuninitialized(@ "scr_dyndofexp_debug", 0);

  if(!utility::flag_exist("dyndofexp_disable")) {
    utility::flag_init("dyndofexp_disable");
  }

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
    level notify("stop_dyndof");
  }

  level.dyndof = function_b449438cb37f4f5e();
  function_deb0a0d97775beae(fstop, focusspeed, aperturespeed);
  level.dyndof.nextcosfov = -1;
  level.dyndof.fstopnear = 3.5;
  level.dyndof.var_505061aa0ace067e = 30;
  level.dyndof.var_502d73aa0aa7e65c = 72;
  level.dyndof.focusspeedmin = focusspeed * 5;
  level.dyndof.focusspeeddistmin = 30;
  level.dyndof.focusspeeddistmax = 72;
  level.dyndof.playerbasefovdvar = 0;
  level.dyndof.issp = utility::issp();

  if(level.dyndof.issp) {
    setsaveddvar(@ "r_dof_physical_enable", 1);
    function_994f6119a93a14a8(level.player);
  } else {
    function_994f6119a93a14a8(function_b38661f50c4f17c7(getdvarint(@ "scr_dyndofexp_clientnum")));
  }

  level.dyndof.player enablephysicaldepthoffieldscripting();
  function_3691871790cd5f55();
  function_47e739b5c004012d();
  level thread dyndofexp_thread();
}

function function_b449438cb37f4f5e() {
  struct = spawnStruct();
  struct.maxfocusdist = 50000;
  struct.contents = dyndofexp_contents();
  struct.contents_static_geo = function_1af3b09473549a37();
  struct.traceangle = 3;
  struct.prevangles = (0, 0, 0);
  struct.prevorigin = (0, 0, 0);
  return struct;
}

function dyndofexp_contents() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water", "physicscontents_characterproxy"];
  return physics_createcontents(contents);
}

function function_1af3b09473549a37() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(contents);
}

function dyndofexp_thread() {
  level endon("stop_dyndof");
  var_86523488c9d4988a = gettime() + 500;
  currentplayerfov = level.dyndof.playerbasefovdvar;
  setdvarifuninitialized(@ "scr_dyndofexp", 1);
  dyndofexpdisabled = 0;

  while(true) {
    if(utility::flag("dyndofexp_disable") || !getdvarint(@ "scr_dyndofexp")) {
      if(!dyndofexpdisabled) {
        dyndofexpdisabled = 1;
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      wait 0.5;
      continue;
    }

    if(dyndofexpdisabled) {
      level.dyndof.player enablephysicaldepthoffieldscripting();
      dyndofexpdisabled = 0;
    }

    if(!isDefined(level.dyndof.player)) {
      wait 0.5;
      continue;
    }

    if(gettime() > var_86523488c9d4988a) {
      var_86523488c9d4988a = gettime() + 500;
      function_3691871790cd5f55();
      currentplayerfov = level.dyndof.playerbasefovdvar;
    }

    object = function_ebc195aa5ddd17ac();

    if(getdvarint(@ "scr_dyndofexp_debug", 0)) {
      line(level.dyndof.player.origin, object.origin, (0, 0.7, 0));
    }

    if(object.dofdist < level.dyndof.var_502d73aa0aa7e65c) {
      frac = math::normalize_value(level.dyndof.var_505061aa0ace067e, level.dyndof.var_502d73aa0aa7e65c, object.dofdist);
      fstop = math::lerp(level.dyndof.fstopnear, level.dyndof.fstop, frac);
    } else {
      fstop = level.dyndof.fstop;
    }

    if(object.dofdist < level.dyndof.focusspeeddistmax) {
      frac = math::normalize_value(level.dyndof.focusspeeddistmin, level.dyndof.focusspeeddistmax, object.dofdist);
      focusspeed = math::lerp(level.dyndof.focusspeedmin, level.dyndof.focusspeed, frac);
    } else {
      focusspeed = level.dyndof.focusspeed;
    }

    level.dyndof.player setphysicaldepthoffield(fstop, 1, focusspeed, level.dyndof.aperturespeed, object.origin);
    waitframe();
  }
}

function function_ebc195aa5ddd17ac() {
  self endon("death");
  playereyeorigin = dyndofexp_getplayerorigin();
  playerviewangles = level.dyndof.player getplayerangles();
  level.dyndof.prevorigin = playereyeorigin;
  level.dyndof.prevangles = playerviewangles;
  var_525a07ede41828a4 = function_a877f6a29d9eaf37(playereyeorigin, playerviewangles);

  if(getdvarint(@ "scr_dyndofexp_debug") == 3) {
    var_525a07ede41828a4.var_85bf1b0c4f9e6f34 = 0;
  }

  bestentstruct = function_2b95531ad6c55bb7(playereyeorigin, playerviewangles);

  if(getdvarint(@ "scr_dyndofexp_debug") == 4) {
    bestentstruct.dofscore = 0;
  }

  if(isDefined(bestentstruct) && bestentstruct.dofscore > var_525a07ede41828a4.var_85bf1b0c4f9e6f34) {
    if(getdvarint(@ "scr_dyndofexp_debug")) {
      printtoscreen2d(10, 830, "<dev string:x3a>", (1, 1, 1), 1.5);

      sphere(bestentstruct.origin, 4, (1, 1, 1));
    }

    return bestentstruct;
  }

  if(getdvarint(@ "scr_dyndofexp_debug")) {
    printtoscreen2d(10, 830, "<dev string:x4a>", (1, 1, 1), 1.5);
  }

  return var_525a07ede41828a4;
}

function function_3691871790cd5f55() {
  basefovdvar = getdvarfloat(@ "cg_targetbasefov");

  if(getdvarfloat(@ "cg_targetbasefov") == level.dyndof.playerbasefovdvar) {
    return;
  }

  x_segments = 8;
  y_segments = 4;
  angle = basefovdvar * 0.6 / x_segments;
  level.dyndof.playerbasefovdvar = basefovdvar;
  startxangle = angle * x_segments * -1;
  startyangle = angle * y_segments * -1;
  x_segments_dbl = x_segments * 2;
  y_segments_dbl = y_segments * 2;
  anglesarray[0][0] = 0;
  minvalue = 12000;
  maxvalue = 0;

  for(x = 0; x < x_segments_dbl + 1; x++) {
    for(y = 0; y < y_segments_dbl + 1; y++) {
      struct = spawnStruct();
      struct.addangles = (y * angle + startyangle, x * angle + startxangle, 0);
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

  level.dyndof.var_dc0818680aecd70f = anglesarray[x_segments][y_segments];

  foreach(x, array in anglesarray) {
    foreach(y, struct in array) {
      struct.centerscale = math::normalize_value(minvalue, maxvalue, struct.centerscale) * 10;
    }
  }

  level.dyndof.tracestructs = anglesarray;
}

function function_a877f6a29d9eaf37(playereyeorigin, playerviewangles) {
  traces = [];
  distances = 0;
  closeststruct = undefined;

  foreach(array in level.dyndof.tracestructs) {
    foreach(struct in array) {
      struct.trace = function_a83db885a74488ad(playereyeorigin, playerviewangles, struct.addangles);
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

  level.dyndof.var_b6ea170af7b44bc1 = closeststruct;
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
  highestgroupindex = keys[0];

  foreach(index, groupavg in groupscores) {
    if(highestgroup < groupavg) {
      highestgroup = groupavg;
      highestgroupindex = index;
    }
  }

  highestscore = 0;
  beststruct = undefined;

  foreach(x, array in level.dyndof.tracestructs) {
    foreach(y, struct in array) {
      if(struct.groupnum != highestgroupindex) {
        continue;
      }

      if(struct.dofscore > highestscore) {
        highestscore = struct.dofscore;
        beststruct = struct;
      }
    }
  }

  if(!isDefined(beststruct)) {
    beststruct = level.dyndof.var_dc0818680aecd70f;
  }

  if(getdvarint(@ "scr_dyndofexp_debug")) {
    printtoscreen2d(10, 890, "<dev string:x5e>" + groupscores[beststruct.groupnum], (1, 1, 1), 1.5);
  }

  beststruct.var_85bf1b0c4f9e6f34 = groupscores[beststruct.groupnum];
  level thread dyndofexp_debug(playereyeorigin, highestgroupindex);
  return beststruct;
}

function function_47e739b5c004012d() {
  if(gettime() > level.dyndof.nextcosfov) {
    level.dyndof.nextcosfov = gettime() + 1000;
    level.dyndof.cosfov = cos(getdvarfloat(@ "cg_targetbasefov"));
    level.dyndof.var_5d49e617853be79 = level.dyndof.cosfov * 50;
  }
}

function function_2b95531ad6c55bb7(playereyepos, playerangles) {
  ents = getaiarray();

  if(!level.dyndof.issp) {
    players = [];

    foreach(player in level.players) {
      if(player == level.dyndof.player) {
        continue;
      }

      players[players.size] = player;
    }

    ents = arraycombine(ents, players);
  }

  if(isDefined(level.var_cb5454c0e4af6c94)) {
    ents = arraycombine(ents, [[level.var_cb5454c0e4af6c94]]());
  }

  ents = function_5713d46873b29625(ents);

  foreach(ent in ents) {
    if(ent.classname != "script_model") {
      continue;
    }

    if(isDefined(ent.dofischaracter)) {
      continue;
    }

    substr = getsubstr(ent.model, 0, 5);

    if(substr == "body_") {
      ent.dofischaracter = 1;
      continue;
    }

    ent.dofischaracter = 0;
  }

  function_47e739b5c004012d();
  playerforward = anglesToForward(playerangles);

  foreach(ent in ents) {
    ischaracter = 0;

    if(isai(ent) || isDefined(ent.dofischaracter) || isPlayer(ent)) {
      ischaracter = 1;
    }

    ent.dofscore = 0;

    if(ischaracter && distancesquared(level.dyndof.player.origin, ent.origin) < 62500) {
      entorigin = function_399289f399d06971(ent, playereyepos, playerforward);
    } else {
      entorigin = ent.origin + (0, 0, 60);
    }

    ent.doftraceorigin = entorigin;
    dot = function_27f66bd4668b76d5(entorigin, playereyepos, playerforward);
    ent.dofdot = dot;

    if(dot > level.dyndof.cosfov) {
      ndot = math::normalize_value(level.dyndof.cosfov, 1, dot);
      score = pow(ndot, 15) * 1100;
      ent.dofscore += score;

      if(getdvarint(@ "scr_dyndofexp_debug")) {
        print3d(entorigin + (0, 0, -5), "<dev string:x74>" + score + "<dev string:x7d>" + dot + "<dev string:x88>", (1, 1, 1), 0.8, 0.2);
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

      if(getdvarint(@ "scr_dyndofexp_debug")) {
        print3d(entorigin + (0, 0, -10), "<dev string:x8d>" + distscore + "<dev string:x97>" + ent.dofscore + "<dev string:x88>", (1, 1, 1), 0.8, 0.2);
      }
    } else {
      distscale = 2000 / ent.dofdist * 0.5;
      ent.dofscore *= distscale * 0.5;

      if(getdvarint(@ "scr_dyndofexp_debug")) {
        print3d(entorigin + (0, 0, -10), "<dev string:x9d>" + distscale + "<dev string:x97>" + ent.dofscore + "<dev string:x88>", (1, 1, 1), 0.8, 0.2);
      }
    }

    if(ent.dofscore > 0) {
      trace = trace::ray_trace(playereyepos, entorigin, [ent, level.dyndof.player], level.dyndof.contents, 1);

      if(trace["fraction"] > 0.9) {
        scale = 1;
        ent.dofscore *= scale;
      } else {
        scale = 0;
        ent.dofscore = 0;
      }

      if(getdvarint(@ "scr_dyndofexp_debug")) {
        print3d(entorigin + (0, 0, -15), "<dev string:xac>" + scale + "<dev string:x97>" + ent.dofscore + "<dev string:x88>", (1, 1, 1), 0.8, 0.2);
      }
    }

    ent.dofscore = int(ent.dofscore);

    if(getdvarint(@ "scr_dyndofexp_debug")) {
      print3d(entorigin, ent.dofscore, (1, 1, 1), 1, 0.2);
    }
  }

  directents = [];
  var_fc7cc93356cb3461 = level.dyndof.issp;

  if(var_fc7cc93356cb3461) {
    foreach(ent in ents) {
      if(!isPlayer(ent) && !isai(ent) && !isDefined(ent.dofischaracter)) {
        continue;
      }

      if(ent.dofscore > 0 && ent.dofdot > 0.9) {
        directents[directents.size] = ent;

        if(getdvarint(@ "scr_dyndofexp_debug")) {
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

    if(var_fc7cc93356cb3461 && (isai(ent) || isDefined(ent.dofischaracter)) && ent.dofscore > 0 && ent.dofdot > 0.99) {
      foreach(directent in directents) {
        if(directent == ent) {
          continue;
        }

        if(directent.dofdist < ent.dofdist && function_9cbe1dca40e0dbe1(playereyepos, ent.doftraceorigin, directent.origin)) {
          ent.dofscore = 0;

          if(getdvarint(@ "scr_dyndofexp_debug")) {
            print3d(ent.doftraceorigin + (0, 0, -20), "<dev string:xb6>", (1, 1, 1), 0.8, 0.2);

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

    if(getdvarint(@ "scr_dyndofexp_debug")) {
      printtoscreen2d(10, 860, "<dev string:xcd>" + struct.dofscore, (1, 1, 1), 1.5);
    }
  }

  return struct;
}

function function_399289f399d06971(ent, playereyepos, playerforward) {
  extratags = ["j_spineupper"];
  closesttag = "tag_eye";
  closesttagorigin = ent gettagorigin(closesttag);
  closesttagdot = function_27f66bd4668b76d5(closesttagorigin, playereyepos, playerforward);

  foreach(tag in extratags) {
    tagorigin = ent gettagorigin(tag);
    dot = function_27f66bd4668b76d5(tagorigin, playereyepos, playerforward);

    if(dot > closesttagdot) {
      closesttagdot = dot;
      closesttag = tag;
      closesttagorigin = tagorigin;
    }
  }

  return closesttagorigin;
}

function function_27f66bd4668b76d5(targetorigin, sourcepos, sourceforward) {
  normal = vectorNormalize(targetorigin - sourcepos);
  return vectordot(sourceforward, normal);
}

function function_a83db885a74488ad(playereyeorigin, playerangles, addangles, pos) {
  angles = combineangles(playerangles, addangles);

  if(!isDefined(pos)) {
    pos = playereyeorigin + anglesToForward(angles) * level.dyndof.maxfocusdist;
  }

  trace = physics_raycast(playereyeorigin, pos, level.dyndof.contents_static_geo, level.dyndof.ignorelist, 1, "physicsquery_closest", 1);

  if(!isDefined(trace) || trace.size == 0) {
    trace = trace::internal_pack_default_trace(pos);
  } else {
    trace = trace[0];
  }

  return trace;
}

function dyndofexp_getplayerorigin() {
  if(level.dyndof.player islinked()) {
    linkedent = level.dyndof.player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(utility::hastag(linkedent.model, "tag_camera")) {
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

function dyndofexp_debug(playereyeorigin, highestgroup) {
  level notify("stop_dyndof_debug");
  level endon("stop_dyndof");
  level endon("stop_dyndof_debug");

  while(getdvarint(@ "scr_dyndofexp_debug")) {
    closestpos = level.dyndof.var_b6ea170af7b44bc1.trace["<dev string:xdf>"];
    closestdist = level.dyndof.var_b6ea170af7b44bc1.dofdist;

    foreach(array in level.dyndof.tracestructs) {
      foreach(struct in array) {
        if((getdvarint(@ "scr_dyndofexp_debug") == 2 || getdvarint(@ "scr_dyndofexp_debug") == 4) && struct.groupnum != highestgroup) {
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
        function_bbedb82a51465887(struct.trace["<dev string:xdf>"], color);
      }
    }

    radius = math::normalize_value(0, 3000, closestdist);
    radius *= 16;
    sphere(closestpos, radius, (1, 1, 0));
    waitframe();
  }
}

function function_bbedb82a51465887(pos, color) {
  range = 1;

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  line(pos - (0, 0, range), pos + (0, 0, range), color, 1, 0);
  line(pos - (0, range, 0), pos + (0, range, 0), color, 1, 0);
  line(pos - (range, 0, 0), pos + (range, 0, 0), color, 1, 0);
}

function function_9cbe1dca40e0dbe1(start, end, actorpos) {
  raydir = vectorNormalize(end - start);
  radius = 8;
  actorpos2 = actorpos + (0, 0, 70);
  cline = actorpos2 - actorpos;
  ctoraystart = start - actorpos;
  cross_cline = vectorcross(ctoraystart, cline);
  var_4f232dbc7e210888 = vectorcross(raydir, cline);
  dot_cline = vectordot(cline, cline);
  a = vectordot(var_4f232dbc7e210888, var_4f232dbc7e210888);
  b = 2 * vectordot(var_4f232dbc7e210888, cross_cline);
  c = vectordot(cross_cline, cross_cline) - radius * radius * dot_cline;
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

function dyndof(fstop, targetentity, focusspeed, aperturespeed, angles, var_80bc11493bd39409, ignorelist, ignorecollision, var_b18f77fd8c2dde85, minfocusdist) {
  assert(isDefined(fstop), "<dev string:x24>");
  assert(!isDefined(targetentity) || isent(targetentity), "<dev string:xeb>");

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
    setsaveddvar(@ "r_dof_physical_enable", 1);
  }

  player enablephysicaldepthoffieldscripting();

  if(isDefined(player.dyndof)) {
    player.dyndof = player destroy_dyndof();
  }

  player.dyndof = create_dyndof();
  player.dyndof.fstop = fstop;
  player.dyndof.focusspeed = focusspeed;
  player.dyndof.aperturespeed = aperturespeed;

  if(isstring(var_80bc11493bd39409)) {
    player.dyndof.desiredbone = var_80bc11493bd39409;
  } else if(isvector(var_80bc11493bd39409)) {
    player.dyndof.desiredpos = var_80bc11493bd39409;
  } else if(isnumber(var_80bc11493bd39409)) {
    player.dyndof.desireddistance = var_80bc11493bd39409;
  }

  player.dyndof.ignorecollision = ignorecollision;
  player.dyndof.var_b18f77fd8c2dde85 = var_b18f77fd8c2dde85;
  player.dyndof.minfocusdist = minfocusdist;

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

function private function_892e1d1187d0d027() {
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
    fstop = player.dyndof.fstop;
    aperturespeed = player.dyndof.aperturespeed;

    if(isDefined(player.dyndof.desiredpos) && player.dyndof.ignorecollision) {
      pos = player.dyndof.desiredpos;
    } else if(isDefined(player.dyndof.desireddistance) && player.dyndof.ignorecollision) {
      [eye, ang] = function_892e1d1187d0d027();
      pos = eye + anglesToForward(ang) * player.dyndof.desireddistance;
    } else if(isDefined(player.dyndof.desireddistance) && player.dyndof.minfocusdist) {
      pos = player dyndof_distance(undefined);
      tracedistance = distance(pos, dyndof_getplayerorigin());

      if(tracedistance < player.dyndof.minfocusdist) {
        fstop = 5;
        aperturespeed = 10000;
      } else {
        [eye, ang] = function_892e1d1187d0d027();
        pos = eye + anglesToForward(ang) * player.dyndof.desireddistance;
      }
    } else {
      pos = player dyndof_distance(targetentity);
    }

    if(!isint(pos)) {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos + (0, 0, 1.5), "<dev string:x11a>" + pos, (0, 1, 0), 1, 0.1, 1);
        line(pos, pos - (0, 0, 1000), (0, 1, 0), 1, 1, 1);
      }

      player setphysicaldepthoffield(fstop, 1, player.dyndof.focusspeed, aperturespeed, pos);
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

    if(isDefined(player worldpointtoscreenpos(pos, getdvarfloat(@ "cg_targetbasefov"))) && dyndof_trace_target(pos)) {
      if(player.dyndof.prevorigin == pos) {
        return -1;
      }

      player.dyndof.prevorigin = pos;

      player thread dyndof_debug(undefined, closesttrace);

      return closesttrace["position"];
    } else {
      if(player.dyndof.var_b18f77fd8c2dde85) {
        [player_eye_pos, ang] = function_892e1d1187d0d027();
        var_3287aa75c2fa8e16 = pos - player_eye_pos;
        player_fwd = anglesToForward(ang);
        dot = vectordot(var_3287aa75c2fa8e16, player_fwd);

        if(dot > 0) {
          var_5d4042a52381fd5e = player_eye_pos + player_fwd * dot;
        } else {
          var_5d4042a52381fd5e = player_eye_pos;
        }

        if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
          line(player.dyndof.prevorigin, var_5d4042a52381fd5e, (1, 1, 1), 1, 1);
          print3d(var_5d4042a52381fd5e, "<dev string:x12b>", (1, 1, 1), 1, 0.1, 1, 1);
          print3d(var_5d4042a52381fd5e + (0, 0, 2), "<dev string:x132>", (1, 0, 0), 1, 0.1, 1);
        }

        return var_5d4042a52381fd5e;
      }

      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos, "<dev string:x12b>", (1, 1, 1), 1, 0.1, 1, 1);
        print3d(pos + (0, 0, 2), "<dev string:x168>", (1, 0, 0), 1, 0.1, 1);
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

  if(player.dyndof.ignorecollision) {
    return true;
  }

  trace = dyndof_trace_internal((0, 0, 0), pos);
  pos_print = pos + (0, 0, 3);

  if(isDefined(trace[0]) && isDefined(trace) && isDefined(trace[0]["position"])) {
    if(distance(trace[0]["position"], pos) < 8) {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos_print, "<dev string:x197>", (1, 0, 1), 1, 0.1, 1, 1);
        playereye = dyndof_getplayerorigin();
        line(playereye, trace[0]["<dev string:xdf>"], (1, 0, 1));
      }

      return true;
    } else {
      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(pos_print, "<dev string:x1ad>", (1, 0, 0), 1, 0.1, 1, 1);
        playereye = dyndof_getplayerorigin();
        line(playereye, trace[0]["<dev string:xdf>"], (1, 0, 0));
      }

      return false;
    }
  }

  if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
    print3d(pos_print, "<dev string:x1bd>", (0, 1, 0), 1, 0.1, 1, 1);
    playereye = dyndof_getplayerorigin();
    line(playereye, pos, (0, 1, 0));
  }

  return true;
}

function dyndof_getplayerorigin() {
  player = self;

  if(player isplayingxcam()) {
    [pos, ang] = player function_892e1d1187d0d027();
    return pos;
  }

  if(player islinked()) {
    linkedent = player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(utility::hastag(linkedent.model, "tag_camera")) {
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
  [pos, ang] = player function_892e1d1187d0d027();
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
          line(trace["<dev string:xdf>"], dyndof_getplayerorigin() + (0, 0, -1));
        }
      }

      line(closesttrace["<dev string:xdf>"], dyndof_getplayerorigin() + (0, 0, -1), (1, 1, 0));
      value = math::normalize_value(0, 3000, distance(dyndof_getplayerorigin(), closesttrace["<dev string:xdf>"]));
      value *= 32;
      sphere(closesttrace["<dev string:xdf>"], value, (1, 1, 0));
      print3d(closesttrace["<dev string:xdf>"], closesttrace["<dev string:x1cd>"], (1, 1, 1), 1, 0.1, 1);

      if(isDefined(closesttrace["<dev string:x1d8>"]) && isDefined(closesttrace["<dev string:x1d8>"].model)) {
        model = closesttrace["<dev string:x1d8>"].model;

        if(model != player.var_80964a983c9c6826) {
          iprintln("<dev string:x1e2>" + model);
          player.var_80964a983c9c6826 = model;
        }

        print3d(closesttrace["<dev string:xdf>"] + (0, 0, -1.5), model, (1, 1, 1), 1, 0.1, 1);
      }

      waitframe();
    }
  }

}