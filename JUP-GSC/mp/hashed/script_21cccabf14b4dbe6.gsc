/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_21cccabf14b4dbe6.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_multi_circle;
#using scripts\mp\utility\game;
#namespace namespace_9ced0748cfd1d189;

function init() {
  if(!scripts\mp\gametypes\br_gametypes::isfeatureenabled("customGametypeCircles")) {
    return;
  }

  scripts\mp\flags::gameflaginit("customGametypeCirclesInit", 0);
  thread function_a8a81e6bc157564d();
}

function function_a8a81e6bc157564d() {
  logstring("br_multi_circle_objectives::init");

  if(getdvarint(@ "hash_5bd161f5b9367829", 1) != 0) {
    scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
  }

  initleveldata();
  waitframe();
  circlespath = undefined;

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("createMultiCircleObjectivesStruct")) {
    circlespath = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("createMultiCircleObjectivesStruct");
  }

  if(!isDefined(circlespath)) {
    return;
  }

  function_4139b5956f07453b(circlespath);
  function_2788e39d9b57d9fb();
  var_48380029fbb1007a = spawnStruct();
  var_48380029fbb1007a.createfunc = &function_82664500e421fe22;
  level.br_multi_circle.config = var_48380029fbb1007a;
  br_multi_circle::function_598312eb02c8eb61();
  level.var_80c1e8e18146024f = &function_931e40c0a6e8719b;
  level.br_multi_circle.var_29e8194ff7e13e2e = &function_29e8194ff7e13e2e;
  scripts\mp\flags::gameflagset("customGametypeCirclesInit");
}

function initleveldata() {
  level.var_cb9a9bfbbc8b8a0f = 1;
  level.var_2df69b8e552238b6 = 1;
  level.br_circle.circleindex = 0;
  level.br_level.br_movingcirclecount = 0;
  level.br_multi_circle = spawnStruct();
  level.br_multi_circle.circlecount = 2;
  level.br_multi_circle.splitindex = -1;
  level.br_multi_circle.mergeindex = -1;
  level.br_multi_circle.var_f3ea1a173901b831 = getdvarint(@ "hash_744515d8c05e3243", 1);
  level.br_multi_circle.var_c73cd3ac9dde962f = getdvarint(@ "hash_c8f6fbc981b7f489", 0);
  level.var_9ced0748cfd1d189 = spawnStruct();
  level.var_9ced0748cfd1d189.var_81e334fd07982878 = getdvarfloat(@ "hash_917b939513f89b55", 100);
  level.var_9ced0748cfd1d189.var_305a01b53523b8ce = getdvarfloat(@ "hash_f181e180ed21f06b", 0.4);
  level.var_9ced0748cfd1d189.var_ebdbc6f4c094c765 = getdvarint(@ "hash_52c6a551a325bc17", 1);
  level.var_9ced0748cfd1d189.minimapradius = getdvarint(@ "hash_25e2efa14945cadc", 3000);
  level.var_9ced0748cfd1d189.var_a30bae6d138c2730 = getdvarint(@ "hash_ad4aea439f3dd156", 15000);
  level.br_multi_circle.var_55cbe3b0d58b0604 = 1;
}

function createmulticircleobjectivesstruct(var_9da79c80305f58db, positiondurations, transitionduration, nextpositiondelays, circlepositions, circleradius) {
  circlespath = spawnStruct();
  circlespath.var_9da79c80305f58db = var_9da79c80305f58db;
  circlespath.positiondurations = positiondurations;
  circlespath.transitionduration = transitionduration;
  circlespath.nextpositiondelays = nextpositiondelays;
  circlespath.circlepositions = circlepositions;
  circlespath.circleradius = circleradius;
  circlespath.positionscount = circlepositions.size;
  return circlespath;
}

function function_4139b5956f07453b(circlespath) {
  circlespath.var_4ab02385b70ecb03 = [];
  circlespath.var_260f61b74d1459ff = [];

  for(i = 0; i < circlespath.positionscount - 1; i++) {
    var_c661e5b77c016382 = int(min(circlespath.transitionduration, circlespath.positiondurations[i]));
    nextpositiondistance = distance2d(circlespath.circlepositions[i], circlespath.circlepositions[i + 1]);
    var_fd0a56e53772cdba = circlespath.nextpositiondelays[i] + circlespath.positiondurations[i + 1] - var_c661e5b77c016382 - 1;
    circlespath.var_4ab02385b70ecb03[i] = var_c661e5b77c016382;
    circlecenter = circlespath.circlepositions[i];
    circleradius = circlespath.circleradius[i];
    var_1cf46931e8999a1 = circlespath.circlepositions[i + 1];
    var_17c97f1f748be50e = circlespath.circleradius[i + 1];
    circlespath.var_260f61b74d1459ff[i] = function_10a532c516175bbe(circlecenter, var_1cf46931e8999a1, circleradius, var_17c97f1f748be50e, var_fd0a56e53772cdba);
  }

  level.var_9ced0748cfd1d189.circlespath = circlespath;
}

function function_10a532c516175bbe(centerstart, centertarget, radiusstart, radiustarget, maxduration) {
  deltaradius = radiusstart - radiustarget;
  circletraveldistance = distance2d(centerstart, centertarget) + deltaradius;
  return int(min(circletraveldistance / level.var_9ced0748cfd1d189.var_81e334fd07982878, maxduration));
}

function function_2788e39d9b57d9fb() {
  level.br_level.br_circlecenters = [];
  level.br_level.br_circleradii = [];
  level.br_level.br_circledelaytimes = [];
  level.br_level.br_circleclosetimes = [];
  circlespath = level.var_9ced0748cfd1d189.circlespath;
  function_1949107e97911ea5(0, 0, 0, 0);
  level.br_level.br_circleradii[0] += 1;
  circledelaytime = circlespath.var_9da79c80305f58db + circlespath.positiondurations[0];
  circleclosetime = circlespath.var_260f61b74d1459ff[0];

  for(i = 0; i < circlespath.positionscount; i++) {
    function_1949107e97911ea5(i + 1, i, circledelaytime, circleclosetime);

    if(i < circlespath.positionscount - 1) {
      circledelaytime = circlespath.positiondurations[i + 1] + circlespath.nextpositiondelays[i] - circlespath.var_260f61b74d1459ff[i];
      circleclosetime = circlespath.var_260f61b74d1459ff[i + 1];
    }
  }

  level.var_b88975a1f2a5e092 = circlespath.circlepositions[0];
}

function function_82664500e421fe22() {
  circlespath = level.var_9ced0748cfd1d189.circlespath;

  for(positionindex = 0; positionindex < circlespath.positionscount; positionindex++) {
    circleindex = int(max(positionindex - 1, 0));
    level.br_multi_circle.circles[0].circlecenters[positionindex] = circlespath.circlepositions[circleindex];
    level.br_multi_circle.circles[1].circlecenters[positionindex] = circlespath.circlepositions[circleindex];
  }
}

function function_1949107e97911ea5(circleindex, positionindex, circledelaytime, circleclosetime) {
  circlespath = level.var_9ced0748cfd1d189.circlespath;
  level.br_level.br_circledelaytimes[circleindex] = circledelaytime;
  level.br_level.br_circleclosetimes[circleindex] = circleclosetime;
  level.br_level.br_circleradii[circleindex] = circlespath.circleradius[positionindex];
  level.br_level.br_circlecenters[circleindex] = circlespath.circlepositions[positionindex];
}

function function_29e8194ff7e13e2e(circleindex) {
  return level.br_multi_circle.var_55cbe3b0d58b0604;
}

function function_931e40c0a6e8719b(var_7b6d5db8cb3c5782) {
  level endon("game_ended");
  level endon("br_stop_multi_circle_objectives");

  if(!istrue(level.var_cb9a9bfbbc8b8a0f)) {
    return;
  }

  setomnvar("ui_br_circle_num", level.br_multi_circle.circlecount);
  scripts\mp\gametypes\br_multi_circle::function_ebfd46aa8754608();
  scripts\mp\gametypes\br_multi_circle::function_74c4ed830065b00c();
  level thread scripts\mp\gametypes\br_multi_circle::function_4c7e6f6847607c99(0.6);
  level thread scripts\mp\gametypes\br_multi_circle::function_5d02313c7d7c9d62();

  if(istrue(var_7b6d5db8cb3c5782)) {
    scripts\mp\flags::gameflagwait("infil_animatic_complete");
  }

  level.var_9ced0748cfd1d189.var_b0f77e41b73f0632 = level.var_9ced0748cfd1d189.minimapradius;
  setomnvar("ui_br_minimap_radius", level.var_9ced0748cfd1d189.minimapradius);
  circlespath = level.var_9ced0748cfd1d189.circlespath;
  level.br_circle.circleinittime = gettime();
  level.br_circle.starttime = gettime();
  level notify("br_circle_set");
  level notify("br_circle_started");
  wait circlespath.var_9da79c80305f58db;
  level notify("update_circle_hide");

  for(i = 0; i < circlespath.positionscount - 1; i++) {
    wait circlespath.positiondurations[i] - circlespath.var_4ab02385b70ecb03[i];
    function_78ca95c1137689e6(i + 1, circlespath.var_4ab02385b70ecb03[i]);
    wait circlespath.var_4ab02385b70ecb03[i];

    if(i < circlespath.positionscount - 1) {
      level.br_circle.circleindex++;
      level.br_circle.starttime = gettime();
    }

    staticcircle(0);
    thread function_a3eb5d233829a440(i + 1);
    wait circlespath.nextpositiondelays[i];
    level notify("br_circle_set");
  }
}

function function_78ca95c1137689e6(posindex, duration) {
  level.br_multi_circle.var_55cbe3b0d58b0604 = 0;
  var_888577293524a715 = level.var_9ced0748cfd1d189.circlespath.circlepositions[posindex];
  var_4a3b04a9deb6b922 = level.var_9ced0748cfd1d189.circlespath.circleradius[posindex];

  if(level.var_9ced0748cfd1d189.var_ebdbc6f4c094c765) {
    var_4991709acb54032c = level.var_9ced0748cfd1d189.circlespath.circlepositions[posindex - 1];
    secondcircleradius = level.var_9ced0748cfd1d189.circlespath.circleradius[posindex - 1];
    circlesdistance = distance2d(var_888577293524a715, var_4991709acb54032c);
    var_e9be70cb585ff69a = (secondcircleradius - circlesdistance - var_4a3b04a9deb6b922) / secondcircleradius;

    if(var_e9be70cb585ff69a < level.var_9ced0748cfd1d189.var_305a01b53523b8ce) {
      var_a4fbc0922141f271 = level.var_9ced0748cfd1d189.var_305a01b53523b8ce * secondcircleradius + circlesdistance - secondcircleradius;
      var_fb23773e4ef56cd = (var_a4fbc0922141f271 - var_4a3b04a9deb6b922) / 2;
      coeff = var_fb23773e4ef56cd / circlesdistance;
      deltax = var_4991709acb54032c[0] - var_888577293524a715[0];
      deltay = var_4991709acb54032c[1] - var_888577293524a715[1];
      var_888577293524a715 = (var_888577293524a715[0] + deltax * coeff, var_888577293524a715[1] + deltay * coeff, 0);
      var_4a3b04a9deb6b922 += var_fb23773e4ef56cd;
    }
  }

  function_f8d91790d1f698f2(0, duration, var_888577293524a715, var_4a3b04a9deb6b922);
  thread function_272ddfaeb01d36fc(duration, 1);
}

function function_a3eb5d233829a440(posindex) {
  level endon("game_ended");
  level endon("br_stop_multi_circle_objectives");
  transitionduration = level.var_9ced0748cfd1d189.circlespath.var_260f61b74d1459ff[posindex - 1];
  movecircle(0, posindex, transitionduration);
  movecircle(1, posindex, transitionduration);
  thread function_272ddfaeb01d36fc(level.var_9ced0748cfd1d189.circlespath.nextpositiondelays[posindex - 1]);
  wait transitionduration;
  staticcircle(1);
  level.br_multi_circle.var_55cbe3b0d58b0604 = 1;
}

function staticcircle(circleindex) {
  circleents = level.br_multi_circle.circles[circleindex].entdata;
  circleents.dangerui.origin = circleents.safeui.origin;
  waitframe();
  scripts\mp\gametypes\br_multi_circle::function_1139f778f794ff98(circleents.dangerent, circleents.safeui, circleents.dangerui, 999, 0);
}

function movecircle(circleindex, posindex, duration) {
  level.br_multi_circle.var_55cbe3b0d58b0604 = 0;
  targetorigin = level.var_9ced0748cfd1d189.circlespath.circlepositions[posindex];
  targetradius = level.var_9ced0748cfd1d189.circlespath.circleradius[posindex];
  function_f8d91790d1f698f2(circleindex, duration, targetorigin, targetradius);
}

function function_f8d91790d1f698f2(circleindex, duration, position, radius) {
  circleents = level.br_multi_circle.circles[circleindex].entdata;
  circleents.safeent.origin = (position[0], position[1], radius);
  circleents.safeui.origin = circleents.safeent.origin;
  circleents.dangerui.origin = circleents.dangerent.origin;

  if(circleindex == 0) {
    function_edf140306fca3e8b(position, radius);
  }

  if(duration <= 0) {
    duration = 0.001;
  }

  scripts\mp\gametypes\br_multi_circle::function_898ca8fcdf7d6479(circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, duration, 0);
  circleents.dangerent brcirclemoveTo(position[0], position[1], radius, duration);
}

function function_edf140306fca3e8b(position, radius) {
  circleents = level.br_multi_circle.circles[1].entdata;
  circleents.safeent.origin = (position[0], position[1], radius);
  circleents.safeui.origin = circleents.safeent.origin;
  scripts\mp\gametypes\br_multi_circle::function_1139f778f794ff98(circleents.dangerent, circleents.safeui, circleents.dangerui, 999, 0);
}

function function_628f61246095f688(positionindex, transitionmaxduration) {
  level notify("br_stop_multi_circle_objectives");
  level.br_multi_circle.var_55cbe3b0d58b0604 = 0;
  var_7050c7a80b60748 = level.br_multi_circle.circles[0].entdata.dangerent.origin;
  firstcircleradius = level.br_multi_circle.circles[0].entdata.dangerent.origin[2];
  var_4991709acb54032c = level.br_multi_circle.circles[1].entdata.dangerent.origin;
  secondcircleradius = level.br_multi_circle.circles[1].entdata.dangerent.origin[2];
  var_1cf46931e8999a1 = level.var_9ced0748cfd1d189.circlespath.circlepositions[positionindex];
  var_17c97f1f748be50e = level.var_9ced0748cfd1d189.circlespath.circleradius[positionindex];
  var_c661e5b77c016382 = function_10a532c516175bbe(var_7050c7a80b60748, var_1cf46931e8999a1, firstcircleradius, var_17c97f1f748be50e, transitionmaxduration);
  var_2511192c6ea17576 = function_10a532c516175bbe(var_4991709acb54032c, var_1cf46931e8999a1, secondcircleradius, var_17c97f1f748be50e, transitionmaxduration);
  transitionduration = int(max(var_c661e5b77c016382, var_2511192c6ea17576));
  movecircle(0, positionindex, transitionduration);
  movecircle(1, positionindex, transitionduration);
  thread function_272ddfaeb01d36fc(transitionduration);
  wait transitionduration;
  staticcircle(0);
  staticcircle(1);
  level.br_multi_circle.var_55cbe3b0d58b0604 = 1;
}

function function_272ddfaeb01d36fc(totallerptime, iszoomout) {
  level notify("br_multi_circle_objectives_minimap_zoom");
  level endon("br_multi_circle_objectives_minimap_zoom");
  level endon("game_ended");

  if(istrue(iszoomout)) {
    goalzoom = level.var_9ced0748cfd1d189.var_a30bae6d138c2730;
  } else {
    goalzoom = level.var_9ced0748cfd1d189.minimapradius;
  }

  previouszoom = level.var_9ced0748cfd1d189.var_b0f77e41b73f0632;

  if(goalzoom == previouszoom) {
    return;
  }

  zoominterval = 0.05;
  var_7f479bce3abf8b1b = totallerptime / zoominterval;
  var_777913b6f66c8417 = int((previouszoom - goalzoom) / var_7f479bce3abf8b1b);
  var_d1f50321d77c76dc = previouszoom;

  for(i = 0; i < var_7f479bce3abf8b1b; i++) {
    var_d1f50321d77c76dc -= var_777913b6f66c8417;
    level.var_9ced0748cfd1d189.var_b0f77e41b73f0632 = var_d1f50321d77c76dc;
    setomnvar("ui_br_minimap_radius", var_d1f50321d77c76dc);
    wait zoominterval;
  }

  setomnvar("ui_br_minimap_radius", goalzoom);
  level.var_9ced0748cfd1d189.var_b0f77e41b73f0632 = goalzoom;
}