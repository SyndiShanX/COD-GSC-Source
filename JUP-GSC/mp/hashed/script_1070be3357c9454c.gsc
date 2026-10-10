/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1070be3357c9454c.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\utility\join_team_aggregator;
#namespace namespace_79cde40897d177f7;

function init_dev() {
  setdevdvarifuninitialized(@ "hash_db53798b3c5b4e9a", -1);
  setdevdvarifuninitialized(@ "hash_4f76d4cdd982e0cb", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_7f3daeba250a9d7d", 0);
  setdevdvarifuninitialized(@ "hash_98784b47329ab19", 0);
  thread function_d98adc9e2868395b(@ "hash_db53798b3c5b4e9a", -1, 0.5, &function_6a9438d4640f8e60);
  thread function_f5d9e458de1ccd69(@ "hash_4f76d4cdd982e0cb", "<dev string:x1c>", 0.5, &function_32605b6bb881ab61);
  thread function_d98adc9e2868395b(@ "hash_98784b47329ab19", 0, 0.5, &function_a6ec40ab5ebf91ae);
  thread function_fd1434db987f4453(@ "hash_7f3daeba250a9d7d", 0.5, &function_c66a86ff03679ba6);
}

function init() {
  var_b2f29ec079807fbf = ["t10_sprint_variants", "t10_sprint_variant_a", "t10_sprint_variant_b", "t10_sprint_variant_c"];
  level.var_3bedd0a92453a1df = array_randomize(var_b2f29ec079807fbf);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamnospectatorcallback(&function_b9d238d0b3043270);

  init_dev();
}

function function_fcb289b4d9d2198e() {
  return level.var_3bedd0a92453a1df;
}

function function_b9d238d0b3043270(player) {
  assert(isDefined(player));
  locomotion_variants = function_fcb289b4d9d2198e();

  if(locomotion_variants.size == 0) {
    return;
  }

  if(!isDefined(level.teamdata[player.team]["teamAddedCount"])) {
    level.teamdata[player.team]["teamAddedCount"] = 0;
  }

  var_d4a9f3765962d3fc = level.teamdata[player.team]["teamAddedCount"] % locomotion_variants.size;
  player.var_a8dab01d882b1e9f = locomotion_variants[var_d4a9f3765962d3fc];
  player function_b593a4a8e497ff86();
  level.teamdata[player.team]["teamAddedCount"]++;
}

function function_b0c47b36a5b76623(moveset) {
  if(isDefined(self.var_c12ea6f6a9136bd7)) {
    return;
  }

  self function_b4d14c500183cbd6(moveset);
}

function function_2a4ecac859ca54d7() {
  if(isDefined(self.var_c12ea6f6a9136bd7)) {
    return self.var_c12ea6f6a9136bd7;
  }

  return self.var_a8dab01d882b1e9f;
}

function function_b593a4a8e497ff86() {
  if(!isDefined(self.var_a8dab01d882b1e9f)) {
    return;
  }

  function_b0c47b36a5b76623(self.var_a8dab01d882b1e9f);
}

function function_43e653ffc0c06d4e(index) {
  assert(isint(index));
  locomotion_variants = function_fcb289b4d9d2198e();
  assert(index >= 0 && index < locomotion_variants.size);
  return locomotion_variants[index];
}

function function_bc275414eb193d19(index) {
  overridename = function_43e653ffc0c06d4e(index);
  function_646f751aa1f46fa3(overridename);
}

function function_646f751aa1f46fa3(name) {
  assert(isstring(name));
  self.var_c12ea6f6a9136bd7 = name;
  self function_b4d14c500183cbd6(name);
}

function function_a1302efd0c478b4c() {
  self.var_c12ea6f6a9136bd7 = undefined;
  function_b593a4a8e497ff86();
}

function function_f5d9e458de1ccd69(dvar, dvar_default, waitinterval, onchange) {
  level endon("<dev string:x20>");

  for(prevval = undefined; true; prevval = val) {
    wait waitinterval;
    val = getDvar(dvar, dvar_default);

    if(!isDefined(prevval) || val != prevval) {
      [[onchange]](val, prevval);
    }
  }
}

function function_d98adc9e2868395b(dvar, dvar_default, waitinterval, onchange) {
  level endon("<dev string:x20>");

  for(prevval = undefined; true; prevval = val) {
    wait waitinterval;
    val = getdvarint(dvar, dvar_default);

    if(!isDefined(prevval) || val != prevval) {
      [[onchange]](val, prevval);
    }
  }
}

function function_fd1434db987f4453(dvar, waitinterval, onset) {
  level endon("<dev string:x20>");

  while(true) {
    wait waitinterval;

    if(getdvarint(dvar, 0) != 0) {
      [[onset]]();
      setDvar(dvar, 0);
    }
  }
}

function function_6a9438d4640f8e60(val, prev) {
  if(val == -1) {
    function_a1302efd0c478b4c();
    return;
  }

  locomotion_variants = function_fcb289b4d9d2198e();

  if(val < 0 || val >= locomotion_variants.size) {
    return;
  }

  foreach(player in level.players) {
    player function_bc275414eb193d19(val);
  }

  setDvar(@ "hash_4f76d4cdd982e0cb", "<dev string:x1c>");
}

function function_32605b6bb881ab61(val, prev) {
  if(val == "<dev string:x1c>") {
    function_a1302efd0c478b4c();
    return;
  }

  foreach(player in level.players) {
    player function_646f751aa1f46fa3(val);
  }

  setDvar(@ "hash_db53798b3c5b4e9a", -1);
}

function function_7fb26d53f97b4152() {
  level notify("<dev string:x2e>");
  level endon("<dev string:x2e>");

  while(true) {
    waitframe();

    foreach(player in level.players) {
      print3d(player.origin + (0, 0, 60), isDefined(player function_2a4ecac859ca54d7()) ? player function_2a4ecac859ca54d7() : "<dev string:x44>", undefined, undefined, 0.5, undefined, 1);
    }
  }
}

function function_a6ec40ab5ebf91ae(val, prev) {
  if(val == 1) {
    thread function_7fb26d53f97b4152();
    return;
  }

  level notify("<dev string:x2e>");
}

function function_c66a86ff03679ba6() {
  println("<dev string:x53>");
  println("<dev string:x67>");

  foreach(variant in function_fcb289b4d9d2198e()) {
    println(variant);
  }

  println("<dev string:x77>");

  foreach(player in level.players) {
    println("<dev string:x8a>" + player getentitynumber() + "<dev string:x96>" + player.var_a8dab01d882b1e9f + "<dev string:xa9>" + (isDefined(player function_2a4ecac859ca54d7()) ? player function_2a4ecac859ca54d7() : "<dev string:x44>"));
  }
}

# /