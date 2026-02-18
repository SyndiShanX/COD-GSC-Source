/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\debug.gsc
***********************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\init;
#using scripts\core_common\ai\systems\weaponlist;
#using scripts\core_common\ai_puppeteer_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\debug_menu;
#using scripts\cp_common\util;
#namespace debug;

function private autoexec __init__system__() {
  system::register(#"debug_script", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.animsound_hudlimit = 14;
  level.var_99e12d63 = [];
  level.var_99e12d63[# "axis"] = (1, 0, 0);
  level.var_99e12d63[# "allies"] = (0, 1, 0);
  level.var_99e12d63[# "team3"] = (1, 1, 0);
  level.var_99e12d63[# "neutral"] = (1, 1, 1);
  thread debugdvars();
  thread engagement_distance_debug_toggle();
}

function drawenttag(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }

    ai[i] thread dragtaguntildeath(getdvarstring(#"debug_tag"));
  }

  setDvar(#"hash_4f53ce2aad8845e2", "<dev string:x38>");
}

function drawtag(tag, opcolor) {
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);
  drawarrow(org, ang, opcolor);
}

function function_73d54326(opcolor) {
  for(;;) {
    drawarrow(self.origin, self.angles, opcolor);
    waitframe(1);
  }
}

function function_cc26947c(org, ang) {
  for(;;) {
    drawarrow(org, ang);
    waitframe(1);
  }
}

function function_9b38e79c() {
  for(;;) {
    drawarrow(self.origin, self.angles);
    waitframe(1);
  }
}

function drawarrow(org, ang, opcolor, var_40dcdbad, var_6e4eeae5, var_5f9d71c2) {
  if(!isDefined(var_40dcdbad)) {
    var_40dcdbad = 1;
  }

  if(!isDefined(var_6e4eeae5)) {
    var_6e4eeae5 = 50;
  }

  if(!isDefined(var_5f9d71c2)) {
    var_5f9d71c2 = 1;
  }

  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, var_6e4eeae5);
  forwardclose = vectorscale(forward, var_6e4eeae5 * 0.8);
  right = anglestoright(ang);
  leftdraw = vectorscale(right, var_6e4eeae5 * -0.2);
  rightdraw = vectorscale(right, var_6e4eeae5 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, var_6e4eeae5);
  up = vectorscale(up, var_6e4eeae5);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  if(is_true(var_40dcdbad)) {
    line(org, org + forwardfar, red, 0.9);
  }

  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);

  if(is_true(var_5f9d71c2)) {
    line(org, org + right, blue, 0.9);
    line(org, org + up, green, 0.9);
  }
}

function function_738cf60a() {
  for(;;) {
    drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    waitframe(1);
  }
}

function drawtagforever(tag, opcolor) {
  self endon(#"death");

  for(;;) {
    drawtag(tag, opcolor);
    waitframe(1);
  }
}

function dragtaguntildeath(tag) {
  for(;;) {
    if(!isDefined(self.origin)) {
      break;
    }

    drawtag(tag);
    waitframe(1);
  }
}

function viewtag(type, tag) {
  if(type == "<dev string:x3c>") {
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      ai[i] drawtag(tag);
    }

    return;
  }

  vehicle = getEntArray("<dev string:x42>", "<dev string:x54>");

  for(i = 0; i < vehicle.size; i++) {
    vehicle[i] drawtag(tag);
  }
}

function removeactivespawner(spawner) {
  newspawners = [];

  for(p = 0; p < level.activenodes.size; p++) {
    if(level.activenodes[p] == spawner) {
      continue;
    }

    newspawners[newspawners.size] = level.activenodes[p];
  }

  level.activenodes = newspawners;
}

function createline(org) {
  for(;;) {
    line(org + (0, 0, 35), org, (0.2, 0.5, 0.8), 0.5);
    waitframe(1);
  }
}

function createlineconstantly(ent) {
  org = undefined;

  while(isalive(ent)) {
    org = ent.origin;
    waitframe(1);
  }

  for(;;) {
    line(org + (0, 0, 35), org, (1, 0.2, 0.1), 0.5);
    waitframe(1);
  }
}

function debugmisstime() {
  self notify(#"hash_5ec34db59fed84d9");
  self endon(#"hash_5ec34db59fed84d9", #"death");

  for(;;) {
    if(self.a.misstime <= 0) {
      print3d(self gettagorigin("<dev string:x61>") + (0, 0, 15), "<dev string:x6c>", (0.3, 1, 1), 1);
    } else {
      print3d(self gettagorigin("<dev string:x61>") + (0, 0, 15), self.a.misstime / 20, (0.3, 1, 1), 1);
    }

    waitframe(1);
  }
}

function debugmisstimeoff() {
  self notify(#"hash_5ec34db59fed84d9");
}

function function_24a0ab5e(dvar, setting) {
  if(getdvarstring(dvar) == "<dev string:x38>") {
    setDvar(dvar, setting);
  }
}

function debugjump(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }

    players = getplayers();
    line(players[0].origin, ai[i].origin, (0.2, 0.3, 1));
    return;
  }
}

function debugdvars() {
  if(getdvarstring(#"hash_5f6154a37f067e0e") == "<dev string:x38>") {
    setDvar(#"hash_5f6154a37f067e0e", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_392e0e2c79fbffac") == "<dev string:x38>") {
    setDvar(#"hash_392e0e2c79fbffac", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_21b7a22ce9c6275b") == "<dev string:x38>") {
    setDvar(#"hash_21b7a22ce9c6275b", "<dev string:x73>");
  }

  function_24a0ab5e("<dev string:x7a>", "<dev string:x73>");

  if(getdvarstring(#"hash_481d2a6e8d396b6d") == "<dev string:x38>") {
    setDvar(#"hash_481d2a6e8d396b6d", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_4914e697f9fc2671") == "<dev string:x38>") {
    setDvar(#"hash_4914e697f9fc2671", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_7cb3964103d64b39") == "<dev string:x38>") {
    setDvar(#"hash_7cb3964103d64b39", "<dev string:x93>");
  }

  if(getdvarstring(#"hash_3ff91657730a45a4") == "<dev string:x38>") {
    setDvar(#"hash_3ff91657730a45a4", "<dev string:x93>");
  }

  if(getdvarstring(#"debug_tag") == "<dev string:x38>") {
    setDvar(#"debug_tag", "<dev string:x38>");
  }

  if(getdvarstring(#"hash_4656023913ce3f58") == "<dev string:x38>") {
    setDvar(#"hash_4656023913ce3f58", "<dev string:x38>");
  }

  if(getdvarstring(#"hash_46799eb73d1021e5") == "<dev string:x38>") {
    setDvar(#"hash_46799eb73d1021e5", "<dev string:x38>");
  }

  if(getdvarstring(#"debug_goalradius") == "<dev string:x38>") {
    setDvar(#"debug_goalradius", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_400262ff40d7af83") == "<dev string:x38>") {
    setDvar(#"hash_400262ff40d7af83", "<dev string:x73>");
  }

  if(getdvarstring(#"debug_health") == "<dev string:x38>") {
    setDvar(#"debug_health", "<dev string:x73>");
  }

  if(getdvarstring(#"debug_engagedist") == "<dev string:x38>") {
    setDvar(#"debug_engagedist", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_294a430f19483cbb") == "<dev string:x38>") {
    setDvar(#"hash_294a430f19483cbb", "<dev string:x73>");
  }

  if(getdvarstring(#"debug_hatmodel") == "<dev string:x38>") {
    setDvar(#"debug_hatmodel", "<dev string:x99>");
  }

  if(getdvarstring(#"hash_15af95544805e487") == "<dev string:x38>") {
    setDvar(#"hash_15af95544805e487", "<dev string:x73>");
  }

  level.var_979b0066 = 0;

  if(getdvarstring(#"hash_1828e38c6e01052f") == "<dev string:x38>") {
    setDvar(#"hash_1828e38c6e01052f", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_4bc852aa6aeb7bd8") == "<dev string:x38>") {
    setDvar(#"hash_37bed2af009035a0", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_543b88a4a8d9f9a9") == "<dev string:x38>") {
    setDvar(#"hash_543b88a4a8d9f9a9", "<dev string:x38>");
  }

  if(getdvarstring(#"debug_nuke") == "<dev string:x38>") {
    setDvar(#"debug_nuke", "<dev string:x73>");
  }

  if(getdvarstring(#"hash_14cb1b9851034a23") == "<dev string:x99>") {
    setDvar(#"hash_14cb1b9851034a23", "<dev string:x73>");
  }

  if(getdvarstring(#"debug_jump") == "<dev string:x38>") {
    setDvar(#"debug_jump", "<dev string:x38>");
  }

  if(getdvarstring(#"debug_hurt") == "<dev string:x38>") {
    setDvar(#"debug_hurt", "<dev string:x38>");
  }

  if(getdvarstring(#"animsound") == "<dev string:x38>") {
    setDvar(#"animsound", "<dev string:x73>");
  }

  if(getdvarstring(#"tag") == "<dev string:x38>") {
    setDvar(#"tag", "<dev string:x38>");
  }

  for(i = 1; i <= level.animsound_hudlimit; i++) {
    if(getdvarstring("<dev string:x9f>" + i) == "<dev string:x38>") {
      setDvar("<dev string:x9f>" + i, "<dev string:x38>");
    }
  }

  if(getdvarstring(#"hash_685827e90be8c03d") == "<dev string:x38>") {
    setDvar(#"hash_685827e90be8c03d", "<dev string:x38>");
  }

  if(getdvarstring(#"debug_depth") == "<dev string:x38>") {
    setDvar(#"debug_depth", "<dev string:x38>");
  }

  if(getdvarstring(#"hash_1a7527951f30d85d") == "<dev string:x38>") {
    setDvar(#"hash_1a7527951f30d85d", 0);
    setDvar(#"hash_457f0b340b899504", 0);
    setDvar(#"hash_5fb2bcff79d1e458", 0);
  }

  if(getdvarstring(#"debug_dynamic_ai_spawning") == "<dev string:x38>") {
    setDvar(#"debug_dynamic_ai_spawning", 0);
  }

  level.last_threat_debug = -23430;

  if(getdvarstring(#"debug_threat") == "<dev string:x38>") {
    setDvar(#"debug_threat", "<dev string:x93>");
  }

  waittillframeend();

  if(getdvarstring(#"debug_character_count") == "<dev string:x38>") {
    setDvar(#"debug_character_count", "<dev string:x73>");
  }

  var_375b9d88 = getdvarstring(#"hash_3e63b96becc87615") == "<dev string:x99>";

  for(;;) {
    if(getdvarint(#"hash_328d096ed229649d", 0) == 1) {
      level thread function_f48a99b9();
    }

    if(getdvarstring(#"debug_tag") != "<dev string:x38>") {
      thread viewtag("<dev string:x3c>", getdvarstring(#"debug_tag"));

      if(getdvarint(#"hash_4f53ce2aad8845e2", 0) > 0) {
        thread drawenttag(getdvarint(#"hash_4f53ce2aad8845e2", 0));
      }
    }

    if(getdvarstring(#"debug_goalradius") == "<dev string:x99>") {
      level thread debug_goalradius();
    }

    if(getdvarstring(#"hash_400262ff40d7af83") == "<dev string:x99>") {
      level thread function_3a215729();
    }

    if(getdvarstring(#"debug_health") == "<dev string:x99>") {
      level thread debug_health();
    }

    if(getdvarstring(#"debug_engagedist") == "<dev string:x99>") {
      level thread debug_engagedist();
    }

    if(getdvarstring(#"hash_46799eb73d1021e5") != "<dev string:x38>") {
      thread viewtag("<dev string:xa6>", getdvarstring(#"hash_46799eb73d1021e5"));
    }

    thread function_b03ecdf3();

    if(getdvarstring(#"tag") != "<dev string:x38>") {
      thread debug_animsoundtagselected();
    }

    for(i = 1; i <= level.animsound_hudlimit; i++) {
      if(getdvarstring("<dev string:x9f>" + i) != "<dev string:x38>") {
        thread debug_animsoundtag(i);
      }
    }

    if(getdvarstring(#"hash_685827e90be8c03d") != "<dev string:x38>") {
      thread function_119a2b9f();
    }

    if(getdvarstring(#"debug_nuke") != "<dev string:x73>") {
      thread debug_nuke();
    }

    if(getdvarstring(#"debug_misstime") == "<dev string:x99>") {
      setDvar(#"debug_misstime", "<dev string:xb1>");
      array::thread_all(getaiarray(), &debugmisstime);
    } else if(getdvarstring(#"debug_misstime") == "<dev string:x73>") {
      setDvar(#"debug_misstime", "<dev string:xb1>");
      array::thread_all(getaiarray(), &debugmisstimeoff);
    }

    if(getdvarstring(#"hash_14cb1b9851034a23") == "<dev string:x99>") {
      thread deathspawnerpreview();
    }

    if(getdvarstring(#"debug_hurt") == "<dev string:x99>") {
      setDvar(#"debug_hurt", "<dev string:x73>");
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        players[i] dodamage(50, (324234, 3423423, 2323));
      }
    }

    if(getdvarstring(#"debug_hurt") == "<dev string:x99>") {
      setDvar(#"debug_hurt", "<dev string:x73>");
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        players[i] dodamage(50, (324234, 3423423, 2323));
      }
    }

    if(getdvarstring(#"debug_depth") == "<dev string:x99>") {
      thread function_fdfcc52();
    }

    if(getdvarstring(#"debug_threat") != "<dev string:x93>" && getdvarstring(#"debug_threat") != "<dev string:x38>") {
      debugthreat();
    }

    level.var_979b0066 = getdvarstring(#"hash_1828e38c6e01052f") == "<dev string:x99>";

    if(!var_375b9d88 && getdvarstring(#"hash_3e63b96becc87615") == "<dev string:x99>") {
      var_375b9d88 = 1;
    }

    if(var_375b9d88 && getdvarstring(#"hash_3e63b96becc87615") == "<dev string:x73>") {
      level.animation.defaultexception = &util::void;
      level.animation notify(#"hash_1c96242baab724dd");
      var_375b9d88 = 0;
    }

    if(getdvarint(#"debug_dynamic_ai_spawning", 0) == 1 && (!isDefined(level.var_5c403878) || level.var_5c403878 == 0)) {
      level.var_5c403878 = 1;
      thread function_2fcd7502();
    } else if(getdvarint(#"debug_dynamic_ai_spawning", 0) == 0 && isDefined(level.var_5c403878) && level.var_5c403878 == 1) {
      level.var_5c403878 = 0;
      level notify(#"hash_34e65f3c6ffc6a39");
    }

    function_d851fc3c();
    waitframe(1);
  }
}

function function_d851fc3c() {
  toggleon = getdvarint(#"hash_1a7527951f30d85d", 0);

  if(!toggleon) {
    return;
  }

  var_cb0c64e2 = getdvarint(#"hash_5fb2bcff79d1e458", 0);
  var_e429284b = getdvarint(#"hash_457f0b340b899504", 0);
  ais = getactorarray();

  foreach(ai in ais) {
    if(var_cb0c64e2) {
      ai.enableterrainik = 1;
    } else {
      ai.enableterrainik = 0;
    }

    if(var_e429284b) {
      ai lookatentity(level.players[0]);
      continue;
    }

    ai lookatentity();
  }
}

function showdebugtrace() {
  startoverride = undefined;
  endoverride = undefined;
  startoverride = (15.1859, -12.2822, 4.071);
  endoverride = (947.2, -10918, 64.9514);
  assert(!isDefined(level.traceend));

  for(;;) {
    players = getplayers();
    waitframe(1);
    start = startoverride;
    end = endoverride;

    if(!isDefined(startoverride)) {
      start = level.tracestart;
    }

    if(!isDefined(endoverride)) {
      end = players[0] getEye();
    }

    trace = bulletTrace(start, end, 0, undefined);
    line(start, trace[# "position"], (0.9, 0.5, 0.8), 0.5);
  }
}

function hatmodel() {
  for(;;) {
    if(getdvarstring(#"debug_hatmodel") == "<dev string:x73>") {
      return;
    }

    var_3eea2550 = [];
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].hatmodel)) {
        continue;
      }

      var_b7d2e573 = 0;

      for(p = 0; p < var_3eea2550.size; p++) {
        if(var_3eea2550[p] != ai[i].classname) {
          continue;
        }

        var_b7d2e573 = 1;
        break;
      }

      if(!var_b7d2e573) {
        var_3eea2550[var_3eea2550.size] = ai[i].classname;
      }
    }

    if(var_3eea2550.size) {
      println("<dev string:xba>");
      println("<dev string:xbf>");

      for(i = 0; i < var_3eea2550.size; i++) {
        println("<dev string:x114>", var_3eea2550[i]);
      }

      println("<dev string:x123>");
    }

    wait 15;
  }
}

function debug_nuke() {
  player = util::gethostplayer();
  dvar = getdvarstring(#"debug_nuke");

  if(dvar == "<dev string:x99>") {
    ai = getaiteamarray(util::get_enemy_team(player.team), #"team3");

    for(i = 0; i < ai.size; i++) {
      ignore = 0;
      classname = ai[i].classname;

      if(isDefined(classname) && (issubstr(classname, "<dev string:x158>") || issubstr(classname, "<dev string:x160>") || issubstr(classname, "<dev string:x168>"))) {
        ignore = 1;
      }

      if(!ignore) {
        ai[i] dodamage(ai[i].health, (0, 0, 0), player);
      }
    }
  } else if(dvar == "<dev string:x3c>") {
    ai = getaiteamarray(util::get_enemy_team(player.team));

    for(i = 0; i < ai.size; i++) {
      ai[i] dodamage(ai[i].health, (0, 0, 0), player);
    }
  } else if(dvar == "<dev string:x175>") {
    ai = getaispeciesarray(util::get_enemy_team(player.team), "<dev string:x17d>");

    for(i = 0; i < ai.size; i++) {
      ai[i] dodamage(ai[i].health, (0, 0, 0), player);
    }
  }

  setDvar(#"debug_nuke", "<dev string:x73>");
}

function debug_misstime() {}

function freeplayer() {
  setDvar(#"hash_5aa2b9b0db0dfc6c", 0);
}

function deathspawnerpreview() {
  waittillframeend();

  for(i = 0; i < 50; i++) {
    if(!isDefined(level.deathspawnerents[i])) {
      continue;
    }

    array = level.deathspawnerents[i];

    for(p = 0; p < array.size; p++) {
      ent = array[p];

      if(isDefined(ent.truecount)) {
        print3d(ent.origin, i + "<dev string:x184>" + ent.truecount, (0, 0.8, 0.6), 5);
        continue;
      }

      print3d(ent.origin, i + "<dev string:x184>" + "<dev string:x18a>", (0, 0.8, 0.6), 5);
    }
  }
}

function getchains() {
  chainarray = [];
  chainarray = getEntArray("<dev string:x18f>", "<dev string:x19f>");
  array = [];

  for(i = 0; i < chainarray.size; i++) {
    array[i] = chainarray[i] getchain();
  }

  return array;
}

function getchain() {
  array = [];
  ent = self;

  while(isDefined(ent)) {
    array[array.size] = ent;

    if(!isDefined(ent) || !isDefined(ent.target)) {
      break;
    }

    ent = getent(ent.target, "<dev string:x1b4>");

    if(isDefined(ent) && ent == array[0]) {
      array[array.size] = ent;
      break;
    }
  }

  originarray = [];

  for(i = 0; i < array.size; i++) {
    originarray[i] = array[i].origin;
  }

  return originarray;
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function function_e05e43c3(origin) {
  normalvec = vectornormalize(origin - self getshootatpos());
  var_b9593434 = vectornormalize(origin - (0, 0, 24) - self getshootatpos());
  var_c2a09695 = vectordot(normalvec, var_b9593434);
  var_8194ae5a = anglesToForward(self getplayerangles());
  vectordot = vectordot(var_8194ae5a, normalvec);

  if(vectordot > var_c2a09695) {
    return 1;
  }

  return 0;
}

function function_fdfcc52() {
  close = getdvarint(#"depth_close", 0);
  far = getdvarint(#"depth_far", 1500);
  setexpfog(close, far, 1, 1, 1, 0);
}

function debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

function debugthreatcalc() {
  ai = getaiarray();
  entnum = getdvarstring(#"debug_threat");
  entity = undefined;
  players = getplayers();

  if(entnum == 0) {
    entity = players[0];
  } else {
    for(i = 0; i < ai.size; i++) {
      if(entnum != ai[i] getentnum()) {
        continue;
      }

      entity = ai[i];
      break;
    }
  }

  if(!isalive(entity)) {
    return;
  }

  entitygroup = entity getthreatbiasgroup();
  array::thread_all(ai, &displaythreat, entity, entitygroup);
  players[0] thread displaythreat(entity, entitygroup);
}

function displaythreat(entity, entitygroup) {
  self endon(#"death");

  if(self.team == entity.team) {
    return;
  }

  selfthreat = 0;
  selfthreat += self.threatbias;
  threat = 0;
  threat += entity.threatbias;
  mygroup = undefined;

  if(isDefined(entitygroup)) {
    mygroup = self getthreatbiasgroup();

    if(isDefined(mygroup)) {
      threat += getthreatbias(entitygroup, mygroup);
      selfthreat += getthreatbias(mygroup, entitygroup);
    }
  }

  if(entity.ignoreme || threat < -900000) {
    threat = "<dev string:x1c2>";
  }

  if(self.ignoreme || selfthreat < -900000) {
    selfthreat = "<dev string:x1c2>";
  }

  players = getplayers();
  col = (1, 0.5, 0.2);
  col2 = (0.2, 0.5, 1);
  pacifist = self != players[0] && self.pacifist;

  for(i = 0; i <= 20; i++) {
    print3d(self.origin + (0, 0, 65), "<dev string:x1cc>", col, 3);
    print3d(self.origin + (0, 0, 50), threat, col, 5);

    if(isDefined(entitygroup)) {
      print3d(self.origin + (0, 0, 35), entitygroup, col, 2);
    }

    print3d(self.origin + (0, 0, 15), "<dev string:x1da>", col2, 3);
    print3d(self.origin + (0, 0, 0), selfthreat, col2, 5);

    if(isDefined(mygroup)) {
      print3d(self.origin + (0, 0, -15), mygroup, col2, 2);
    }

    if(pacifist) {
      print3d(self.origin + (0, 0, 25), "<dev string:x1e8>", col2, 5);
    }

    waitframe(1);
  }
}

function init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  waittillframeend();
  waittillframeend();
  animnames = getarraykeys(level.scr_notetrack);

  for(i = 0; i < animnames.size; i++) {
    init_notetracks_for_animname(animnames[i]);
  }

  animnames = getarraykeys(level.scr_animsound);

  for(i = 0; i < animnames.size; i++) {
    init_animsounds_for_animname(animnames[i]);
  }
}

function init_notetracks_for_animname(animname) {
  foreach(v in level.scr_notetrack[animname]) {
    soundalias = v[# "sound"];

    if(!isDefined(soundalias)) {
      continue;
    }

    anime = v[# "anime"];
    notetrack = v[# "notetrack"];
    level.animsound_aliases[animname][anime][notetrack][# "soundalias"] = soundalias;

    if(isDefined(v[# "hash_3bcdf8e8541b5d4a"])) {
      level.animsound_aliases[animname][anime][notetrack][# "hash_3bcdf8e8541b5d4a"] = 1;
    }
  }
}

function init_animsounds_for_animname(animname) {
  animes = getarraykeys(level.scr_animsound[animname]);

  for(i = 0; i < animes.size; i++) {
    anime = animes[i];
    soundalias = level.scr_animsound[animname][anime];
    level.animsound_aliases[animname][anime]["<dev string:x1f8>" + anime][# "soundalias"] = soundalias;
    level.animsound_aliases[animname][anime]["<dev string:x1f8>" + anime][# "hash_3bcdf8e8541b5d4a"] = 1;
  }
}

function function_90b2a0b0(x, y, msg) {
  var_5e39fc46 = newdebughudelem();
  var_5e39fc46.alignx = "<dev string:x1fd>";
  var_5e39fc46.aligny = "<dev string:x205>";
  var_5e39fc46.x = x;
  var_5e39fc46.y = y;
  var_5e39fc46.alpha = 1;
  var_5e39fc46.fontscale = 1;
  var_5e39fc46.label = msg;
  level.var_e8a7658[level.var_e8a7658.size] = var_5e39fc46;
  return var_5e39fc46;
}

function function_b03ecdf3() {
  enabled = getdvarstring(#"animsound") == "<dev string:x99>";

  if(!isDefined(level.var_100db28b)) {
    if(!enabled) {
      return;
    }

    level.var_d7c96297 = 0;
    level.var_7e2e9d77 = "<dev string:x20f>";
    level.var_100db28b = [];
    level.var_eef171c = [];
    level.var_c22fdb8f = [];
    level.var_e8a7658 = [];
    level.var_969ba98a = 0;
    level.var_9c80d401 = 0;
    level.var_fe79cec = function_90b2a0b0(-30, 180, "<dev string:x217>");
    level.var_77ea7dca = function_90b2a0b0(100, 180, "<dev string:x222>");
    function_90b2a0b0(10, 190, "<dev string:x22c>");
    function_90b2a0b0(-30, 190, "<dev string:x242>");
    function_90b2a0b0(-30, 160, "<dev string:x24d>");
    function_90b2a0b0(-30, 150, "<dev string:x270>");
    function_90b2a0b0(-30, 140, "<dev string:x287>");
    level.var_bf8f879e = function_90b2a0b0(-30, 170, "<dev string:x2ba>");
    level.var_bf8f879e.alpha = 0;

    for(i = 0; i < level.animsound_hudlimit; i++) {
      var_5e39fc46 = newdebughudelem();
      var_5e39fc46.alignx = "<dev string:x1fd>";
      var_5e39fc46.aligny = "<dev string:x205>";
      var_5e39fc46.x = 10;
      var_5e39fc46.y = 200 + i * 10;
      var_5e39fc46.alpha = 1;
      var_5e39fc46.fontscale = 1;
      var_5e39fc46.label = "<dev string:x38>";
      level.var_100db28b[level.var_100db28b.size] = var_5e39fc46;
      var_5e39fc46 = newdebughudelem();
      var_5e39fc46.alignx = "<dev string:x2c6>";
      var_5e39fc46.aligny = "<dev string:x205>";
      var_5e39fc46.x = -10;
      var_5e39fc46.y = 200 + i * 10;
      var_5e39fc46.alpha = 1;
      var_5e39fc46.fontscale = 1;
      var_5e39fc46.label = "<dev string:x38>";
      level.var_eef171c[level.var_eef171c.size] = var_5e39fc46;
      var_5e39fc46 = newdebughudelem();
      var_5e39fc46.alignx = "<dev string:x2c6>";
      var_5e39fc46.aligny = "<dev string:x205>";
      var_5e39fc46.x = 210;
      var_5e39fc46.y = 200 + i * 10;
      var_5e39fc46.alpha = 1;
      var_5e39fc46.fontscale = 1;
      var_5e39fc46.label = "<dev string:x38>";
      level.var_c22fdb8f[level.var_c22fdb8f.size] = var_5e39fc46;
    }

    level.var_100db28b[0].color = (1, 1, 0);
    level.var_eef171c[0].color = (1, 1, 0);
  } else if(!enabled) {
    for(i = 0; i < level.animsound_hudlimit; i++) {
      level.var_100db28b[i] destroy();
      level.var_eef171c[i] destroy();
      level.var_c22fdb8f[i] destroy();
    }

    for(i = 0; i < level.var_e8a7658.size; i++) {
      level.var_e8a7658[i] destroy();
    }

    level.var_100db28b = undefined;
    level.var_eef171c = undefined;
    level.var_c22fdb8f = undefined;
    level.var_e8a7658 = undefined;
    level.animsounds = undefined;
    return;
  }

  if(!isDefined(level.animsound_tagged)) {
    level.var_969ba98a = 0;
  }

  if(level.var_969ba98a) {
    level.var_bf8f879e.alpha = 1;
  } else {
    level.var_bf8f879e.alpha = 0;
  }

  if(!isDefined(level.animsounds)) {
    init_animsounds();
  }

  level.var_b19c1dfd = [];
  arrayremovevalue(level.animsounds, undefined);
  array::thread_all(level.animsounds, &function_e5ad4202);
  players = getplayers();

  if(level.var_969ba98a) {
    for(i = 0; i < level.var_b19c1dfd.size; i++) {
      animsound = level.var_b19c1dfd[i];
      animsound.var_cdbf6838 = (0.5, 0.5, 0.5);
    }
  } else if(players.size > 0) {
    dot = 0.85;
    forward = anglesToForward(players[0] getplayerangles());

    for(i = 0; i < level.var_b19c1dfd.size; i++) {
      animsound = level.var_b19c1dfd[i];
      animsound.var_cdbf6838 = (0.25, 1, 0.5);
      difference = vectornormalize(animsound.origin + (0, 0, 40) - players[0].origin + (0, 0, 55));
      newdot = vectordot(forward, difference);

      if(newdot < dot) {
        continue;
      }

      dot = newdot;
      level.animsound_tagged = animsound;
    }
  }

  if(isDefined(level.animsound_tagged)) {
    level.animsound_tagged.var_cdbf6838 = (1, 1, 0);
  }

  var_86c85a76 = isDefined(level.animsound_tagged);

  for(i = 0; i < level.var_b19c1dfd.size; i++) {
    animsound = level.var_b19c1dfd[i];
    msg = "<dev string:x2cf>";

    if(level.var_969ba98a) {
      msg = "<dev string:x2d4>";
    }

    print3d(animsound.origin + (0, 0, 40), msg + animsound.animsounds.size, animsound.var_cdbf6838, 1, 1);
  }

  if(var_86c85a76) {
    function_21619947();
  }
}

function function_21619947() {
  guy = level.animsound_tagged;
  animsounds = guy.animsounds;
  animname = "<dev string:x2dd>";

  if(isDefined(guy.animname)) {
    animname = guy.animname;
  }

  level.var_fe79cec.label = "<dev string:x217>" + animname;
  players = getplayers();

  if(players[0] buttonPressed("<dev string:x2e8>")) {
    if(!level.var_9c80d401) {
      level.var_969ba98a = !level.var_969ba98a;
      level.var_9c80d401 = 1;
    }
  } else {
    level.var_9c80d401 = 0;
  }

  if(players[0] buttonPressed("<dev string:x2ef>")) {
    if(level.var_7e2e9d77 != "<dev string:x2fa>") {
      level.var_d7c96297--;
    }

    level.var_7e2e9d77 = "<dev string:x2fa>";
  } else if(players[0] buttonPressed("<dev string:x300>")) {
    if(level.var_7e2e9d77 != "<dev string:x30d>") {
      level.var_d7c96297++;
    }

    level.var_7e2e9d77 = "<dev string:x30d>";
  } else {
    level.var_7e2e9d77 = "<dev string:x20f>";
  }

  for(i = 0; i < level.animsound_hudlimit; i++) {
    var_5e39fc46 = level.var_100db28b[i];
    var_5e39fc46.label = "<dev string:x38>";
    var_5e39fc46.color = (1, 1, 1);
    var_5e39fc46 = level.var_eef171c[i];
    var_5e39fc46.label = "<dev string:x38>";
    var_5e39fc46.color = (1, 1, 1);
    var_5e39fc46 = level.var_c22fdb8f[i];
    var_5e39fc46.label = "<dev string:x38>";
    var_5e39fc46.color = (1, 1, 1);
  }

  keys = getarraykeys(animsounds);
  highest = -1;

  for(i = 0; i < keys.size; i++) {
    if(keys[i] > highest) {
      highest = keys[i];
    }
  }

  if(highest == -1) {
    return;
  }

  if(level.var_d7c96297 > highest) {
    level.var_d7c96297 = highest;
  }

  if(level.var_d7c96297 < 0) {
    level.var_d7c96297 = 0;
  }

  for(;;) {
    if(isDefined(animsounds[level.var_d7c96297])) {
      break;
    }

    level.var_d7c96297--;

    if(level.var_d7c96297 < 0) {
      level.var_d7c96297 = highest;
    }
  }

  level.var_77ea7dca.label = "<dev string:x222>" + animsounds[level.var_d7c96297].anime;
  level.var_100db28b[level.var_d7c96297].color = (1, 1, 0);
  level.var_eef171c[level.var_d7c96297].color = (1, 1, 0);
  level.var_c22fdb8f[level.var_d7c96297].color = (1, 1, 0);
  time = gettime();

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    animsound = animsounds[key];
    var_5e39fc46 = level.var_100db28b[key];
    soundalias = get_alias_from_stored(animsound);
    var_5e39fc46.label = key + 1 + "<dev string:x315>" + animsound.notetrack;
    var_5e39fc46 = level.var_eef171c[key];
    var_5e39fc46.label = int((time - animsound.end_time - 60000) * 0.001);

    if(isDefined(soundalias)) {
      var_5e39fc46 = level.var_c22fdb8f[key];
      var_5e39fc46.label = soundalias;

      if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
        var_5e39fc46.color = (0.7, 0.7, 0.7);
      }
    }
  }

  players = getplayers();

  if(players[0] buttonPressed("<dev string:x31b>")) {
    animsound = animsounds[level.var_d7c96297];
    soundalias = get_alias_from_stored(animsound);

    if(!isDefined(soundalias)) {
      return;
    }

    if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
      return;
    }

    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack] = undefined;
    function_119a2b9f();
  }
}

function get_alias_from_stored(animsound) {
  if(!isDefined(level.animsound_aliases[animsound.animname])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack])) {
    return;
  }

  return level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][# "soundalias"];
}

function is_from_animsound(animname, anime, notetrack) {
  return isDefined(level.animsound_aliases[animname][anime][notetrack][# "hash_3bcdf8e8541b5d4a"]);
}

function function_e5ad4202() {
  players = getplayers();

  if(distance(players[0].origin, self.origin) > 1500) {
    return;
  }

  level.var_b19c1dfd[level.var_b19c1dfd.size] = self;
}

function debug_animsoundtag(tagnum) {
  tag = getdvarstring("<dev string:x9f>" + tagnum);

  if(tag == "<dev string:x38>") {
    iprintlnbold("<dev string:x322>");
    return;
  }

  tag_sound(tag, tagnum - 1);
  setDvar(#"tag" + tagnum, "<dev string:x38>");
}

function debug_animsoundtagselected() {
  tag = getdvarstring(#"tag");

  if(tag == "<dev string:x38>") {
    iprintlnbold("<dev string:x34f>");
    return;
  }

  tag_sound(tag, level.var_d7c96297);
  setDvar(#"tag", "<dev string:x38>");
}

function tag_sound(tag, tagnum) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }

  if(!isDefined(level.animsound_tagged.animsounds[tagnum])) {
    return;
  }

  animsound = level.animsound_tagged.animsounds[tagnum];
  soundalias = get_alias_from_stored(animsound);

  if(!isDefined(soundalias) || is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][# "soundalias"] = tag;
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][# "hash_3bcdf8e8541b5d4a"] = 1;
    function_119a2b9f();
  }
}

function function_119a2b9f() {
  filename = "<dev string:x37b>" + level.script + "<dev string:x388>";
  file = openfile(filename, "<dev string:x396>");

  if(file == -1) {
    iprintlnbold("<dev string:x39f>" + filename + "<dev string:x3b5>");
    return;
  }

  iprintlnbold("<dev string:x3d9>" + filename);
  function_eaaa729a(file);
  saved = closefile(file);
  setDvar(#"hash_685827e90be8c03d", "<dev string:x38>");
}

function function_eaaa729a(file) {
  tab = "<dev string:x3e6>";
  fprintln(file, "<dev string:x3ee>");
  fprintln(file, "<dev string:x409>");
  fprintln(file, "<dev string:x413>");
  fprintln(file, tab + "<dev string:x418>");
  fprintln(file, tab + "<dev string:x49a>");
  fprintln(file, "<dev string:x4b7>");
  fprintln(file, "<dev string:x38>");
  fprintln(file, "<dev string:x4bc>");
  fprintln(file, "<dev string:x413>");
  fprintln(file, tab + "<dev string:x4d1>");
  animnames = getarraykeys(level.animsound_aliases);

  for(i = 0; i < animnames.size; i++) {
    animes = getarraykeys(level.animsound_aliases[animnames[i]]);

    for(p = 0; p < animes.size; p++) {
      anime = animes[p];
      notetracks = getarraykeys(level.animsound_aliases[animnames[i]][anime]);

      for(z = 0; z < notetracks.size; z++) {
        notetrack = notetracks[z];

        if(!is_from_animsound(animnames[i], anime, notetrack)) {
          continue;
        }

        alias = level.animsound_aliases[animnames[i]][anime][notetrack][# "soundalias"];

        if(notetrack == "<dev string:x1f8>" + anime) {
          fprintln(file, tab + "<dev string:x4e8>" + tostr(animnames[i]) + "<dev string:x502>" + tostr(anime) + "<dev string:x502>" + tostr(alias) + "<dev string:x508>");
        } else {
          fprintln(file, tab + "<dev string:x510>" + tostr(animnames[i]) + "<dev string:x502>" + tostr(anime) + "<dev string:x502>" + tostr(notetrack) + "<dev string:x502>" + tostr(alias) + "<dev string:x508>");
        }

        println("<dev string:x52c>" + alias + "<dev string:x540>" + notetrack);
      }
    }
  }

  fprintln(file, "<dev string:x4b7>");
}

function function_f48a99b9() {
  setDvar(#"hash_328d096ed229649d", 0);

  if(!isDefined(level.var_31c87253) || getdvarint(#"enablenpcdeathtracking", 0) != 1) {
    return;
  }

  players = getplayers();
  filename = "<dev string:x556>" + level.var_3a8f95b4 + "<dev string:x56f>" + players[0].playername + "<dev string:x574>";

  file = openfile(filename, "<dev string:x57c>");

  if(file == -1) {
    iprintlnbold("<dev string:x39f>" + filename + "<dev string:x586>");
    return;
  }

  if(isDefined(level.var_c2ccaeac)) {
    fprintln(file, "<dev string:x5c7>" + level.var_c2ccaeac + "<dev string:x5d4>");
  } else {
    fprintln(file, "<dev string:x5f7>");
  }

  if(level.var_31c87253.size <= 0) {
    fprintln(file, "<dev string:x62b>");
  }

  foreach(var_1f53424f in level.var_31c87253) {
    fprintln(file, var_1f53424f.var_8c76324 + "<dev string:x64f>" + var_1f53424f.icount + "<dev string:x64f>" + var_1f53424f.var_d8daf812 + "<dev string:x64f>" + var_1f53424f.var_23ba749);
  }

  fprintln(file, "<dev string:x38>");
  iprintlnbold("<dev string:x654>" + filename);
  saved = closefile(file);

  level.var_31c87253 = [];
}

function tostr(str) {
  newstr = "<dev string:x66f>";

  for(i = 0; i < str.size; i++) {
    if(str[i] == "<dev string:x66f>") {
      newstr += "<dev string:x674>";
      newstr += "<dev string:x66f>";
      continue;
    }

    newstr += str[i];
  }

  newstr += "<dev string:x66f>";
  return newstr;
}

function new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array)) {
    level.hud_array = [];
  }

  if(!isDefined(level.hud_array[hud_name])) {
    level.hud_array[hud_name] = [];
  }

  hud = debug_menu::set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

function debug_show_viewpos() {
  var_1071292 = newdebughudelem();
  var_1071292.x = 10;
  var_1071292.y = 300;
  var_1071292.alpha = 0;
  var_1071292.alignx = "<dev string:x1fd>";
  var_1071292.fontscale = 1.2;
  var_1071292 settext(#"hash_59d12e465ccbab9a");
  x_pos = var_1071292.x + 50;
  hud_x = newdebughudelem();
  hud_x.x = x_pos;
  hud_x.y = 300;
  hud_x.alpha = 0;
  hud_x.alignx = "<dev string:x1fd>";
  hud_x.fontscale = 1.2;
  hud_x setvalue(0);
  hud_y = newdebughudelem();
  hud_y.x = 10;
  hud_y.y = 300;
  hud_y.alpha = 0;
  hud_y.alignx = "<dev string:x1fd>";
  hud_y.fontscale = 1.2;
  hud_y setvalue(0);
  var_7125033d = newdebughudelem();
  var_7125033d.x = 10;
  var_7125033d.y = 300;
  var_7125033d.alpha = 0;
  var_7125033d.alignx = "<dev string:x1fd>";
  var_7125033d.fontscale = 1.2;
  var_7125033d setvalue(0);
  setDvar(#"debug_show_viewpos", 0);
  players = getplayers();

  while(true) {
    if(getdvarint(#"debug_show_viewpos", 0) > 0) {
      var_1071292.alpha = 1;
      hud_x.alpha = 1;
      hud_y.alpha = 1;
      var_7125033d.alpha = 1;
      x = players[0].origin[0];
      y = players[0].origin[1];
      z = players[0].origin[2];
      var_41568b91 = (2 + function_d2d39ee5(x)) * 8 + 10;
      var_b2c0ee64 = (2 + function_d2d39ee5(y)) * 8 + 10;
      hud_y.x = x_pos + var_41568b91;
      var_7125033d.x = x_pos + var_41568b91 + var_b2c0ee64;
      hud_x setvalue(function_6334846f(x, 100));
      hud_y setvalue(function_6334846f(y, 100));
      var_7125033d setvalue(function_6334846f(z, 100));
    } else {
      var_1071292.alpha = 0;
      hud_x.alpha = 0;
      hud_y.alpha = 0;
      var_7125033d.alpha = 0;
    }

    wait 0.5;
  }
}

function function_d2d39ee5(num) {
  var_dd9c91de = abs(num);
  count = 0;

  while(true) {
    var_dd9c91de *= 0.1;
    count += 1;

    if(var_dd9c91de < 1) {
      return count;
    }
  }
}

function function_6334846f(val, num) {
  return int(val * num) / num;
}

function function_1261f881() {
  return level.players[0];
}

function engagement_distance_debug_toggle() {
  level endon(#"kill_engage_dist_debug_toggle_watcher");
  laststate = getdvarint(#"debug_engage_dists", 0);

  while(true) {
    currentstate = getdvarint(#"debug_engage_dists", 0);

    if(dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
      weapon_engage_dists_init();
      thread debug_realtime_engage_dist();
      thread function_16b58d7f();
      laststate = currentstate;
    } else if(!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
      level notify(#"kill_all_engage_dist_debug");
      laststate = currentstate;
    }

    wait 0.3;
  }
}

function dvar_turned_on(val) {
  if(val <= 0) {
    return 0;
  }

  return 1;
}

function engagement_distance_debug_init(player) {
  level.realtimeengagedist = newdebughudelem(player);
  level.realtimeengagedist.alignx = "<dev string:x1fd>";
  level.realtimeengagedist.fontscale = 1.5;
  level.realtimeengagedist.x = -50;
  level.realtimeengagedist.y = 250;
  level.realtimeengagedist.color = (1, 1, 1);
  level.realtimeengagedist settext("<dev string:x679>");
  xpos = 157;
  level.realtimeengagedist_value = newdebughudelem(player);
  level.realtimeengagedist_value.alignx = "<dev string:x1fd>";
  level.realtimeengagedist_value.fontscale = 1.5;
  level.realtimeengagedist_value.x = xpos;
  level.realtimeengagedist_value.y = 250;
  level.realtimeengagedist_value.color = (1, 1, 1);
  level.realtimeengagedist_value setvalue(0);
  xpos += 37;
  level.realtimeengagedist_middle = newdebughudelem(player);
  level.realtimeengagedist_middle.alignx = "<dev string:x1fd>";
  level.realtimeengagedist_middle.fontscale = 1.5;
  level.realtimeengagedist_middle.x = xpos;
  level.realtimeengagedist_middle.y = 250;
  level.realtimeengagedist_middle.color = (1, 1, 1);
  level.realtimeengagedist_middle settext("<dev string:x69a>");
  xpos += 105;
  level.realtimeengagedist_offvalue = newdebughudelem(player);
  level.realtimeengagedist_offvalue.alignx = "<dev string:x1fd>";
  level.realtimeengagedist_offvalue.fontscale = 1.5;
  level.realtimeengagedist_offvalue.x = xpos;
  level.realtimeengagedist_offvalue.y = 250;
  level.realtimeengagedist_offvalue.color = (1, 1, 1);
  level.realtimeengagedist_offvalue setvalue(0);
  hudobjarray = [];
  hudobjarray[0] = level.realtimeengagedist;
  hudobjarray[1] = level.realtimeengagedist_value;
  hudobjarray[2] = level.realtimeengagedist_middle;
  hudobjarray[3] = level.realtimeengagedist_offvalue;
  return hudobjarray;
}

function engage_dist_debug_hud_destroy(hudarray, killnotify) {
  level waittill(killnotify);

  for(i = 0; i < hudarray.size; i++) {
    hudarray[i] destroy();
  }
}

function weapon_engage_dists_init() {
  level.engagedists = [];
  genericpistol = spawnStruct();
  genericpistol.engagedistmin = 125;
  genericpistol.engagedistoptimal = 400;
  genericpistol.engagedistmulligan = 100;
  genericpistol.engagedistmax = 600;
  shotty = spawnStruct();
  shotty.engagedistmin = 0;
  shotty.engagedistoptimal = 300;
  shotty.engagedistmulligan = 100;
  shotty.engagedistmax = 600;
  genericsmg = spawnStruct();
  genericsmg.engagedistmin = 100;
  genericsmg.engagedistoptimal = 500;
  genericsmg.engagedistmulligan = 150;
  genericsmg.engagedistmax = 1000;
  genericriflesa = spawnStruct();
  genericriflesa.engagedistmin = 325;
  genericriflesa.engagedistoptimal = 800;
  genericriflesa.engagedistmulligan = 300;
  genericriflesa.engagedistmax = 1600;
  generichmg = spawnStruct();
  generichmg.engagedistmin = 500;
  generichmg.engagedistoptimal = 700;
  generichmg.engagedistmulligan = 300;
  generichmg.engagedistmax = 1400;
  genericsniper = spawnStruct();
  genericsniper.engagedistmin = 950;
  genericsniper.engagedistoptimal = 2000;
  genericsniper.engagedistmulligan = 500;
  genericsniper.engagedistmax = 3000;
  engage_dists_add("<dev string:x6b4>", genericpistol);
  engage_dists_add("<dev string:x6be>", genericsmg);
  engage_dists_add("<dev string:x6c5>", shotty);
  engage_dists_add("<dev string:x6cf>", generichmg);
  engage_dists_add("<dev string:x6d5>", genericriflesa);
  level thread engage_dists_watcher();
}

function engage_dists_add(weaponname, values) {
  level.engagedists[weaponname] = values;
}

function get_engage_dists(weapon) {
  if(isDefined(level.engagedists[weapon])) {
    return level.engagedists[weapon];
  }

  return undefined;
}

function engage_dists_watcher() {
  level endon(#"kill_all_engage_dist_debug", #"kill_engage_dists_watcher");

  while(true) {
    player = function_1261f881();
    playerweapon = player getcurrentweapon();

    if(!isDefined(player.lastweapon)) {
      player.lastweapon = playerweapon;
    } else if(player.lastweapon == playerweapon) {
      waitframe(1);
      continue;
    }

    values = get_engage_dists(playerweapon.weapclass);

    if(isDefined(values)) {
      level.weaponengagedistvalues = values;
    } else {
      level.weaponengagedistvalues = undefined;
    }

    player.lastweapon = playerweapon;
    waitframe(1);
  }
}

function debug_realtime_engage_dist() {
  level endon(#"kill_all_engage_dist_debug", #"kill_realtime_engagement_distance_debug");
  player = function_1261f881();
  hudobjarray = engagement_distance_debug_init(player);
  level thread engage_dist_debug_hud_destroy(hudobjarray, "<dev string:x6de>");
  level.debugrtengagedistcolor = (0, 1, 0);

  while(true) {
    lasttracepos = (0, 0, 0);
    direction = player getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
    tracepoint = trace[# "position"];
    tracenormal = trace[# "normal"];
    tracedist = int(distance(eye, tracepoint));

    if(tracepoint != lasttracepos) {
      lasttracepos = tracepoint;

      if(!isDefined(level.weaponengagedistvalues)) {
        hudobj_changecolor(hudobjarray, (1, 1, 1));
        hudobjarray engagedist_hud_changetext("<dev string:x6fc>", tracedist);
      } else {
        engagedistmin = level.weaponengagedistvalues.engagedistmin;
        engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
        engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
        engagedistmax = level.weaponengagedistvalues.engagedistmax;

        if(tracedist >= engagedistmin && tracedist <= engagedistmax) {
          if(tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) {
            hudobjarray engagedist_hud_changetext("<dev string:x706>", tracedist);
            hudobj_changecolor(hudobjarray, (0, 1, 0));
          } else {
            hudobjarray engagedist_hud_changetext("<dev string:x711>", tracedist);
            hudobj_changecolor(hudobjarray, (1, 1, 0));
          }
        } else if(tracedist < engagedistmin) {
          hudobj_changecolor(hudobjarray, (1, 0, 0));
          hudobjarray engagedist_hud_changetext("<dev string:x717>", tracedist);
        } else if(tracedist > engagedistmax) {
          hudobj_changecolor(hudobjarray, (1, 0, 0));
          hudobjarray engagedist_hud_changetext("<dev string:x720>", tracedist);
        }
      }
    }

    thread util::function_6844bea4(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    thread util::function_6844bea4(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    waitframe(1);
  }
}

function hudobj_changecolor(hudobjarray, newcolor) {
  for(i = 0; i < hudobjarray.size; i++) {
    hudobj = hudobjarray[i];

    if(hudobj.color != newcolor) {
      hudobj.color = newcolor;
      level.debugrtengagedistcolor = newcolor;
    }
  }
}

function engagedist_hud_changetext(engagedisttype, units) {
  if(!isDefined(level.lastdisttype)) {
    level.lastdisttype = "<dev string:x20f>";
  }

  if(engagedisttype == "<dev string:x706>") {
    self[1] setvalue(units);
    self[2] settext("<dev string:x728>");
    self[3].alpha = 0;
  } else if(engagedisttype == "<dev string:x711>") {
    self[1] setvalue(units);
    self[2] settext("<dev string:x73b>");
    self[3].alpha = 0;
  } else if(engagedisttype == "<dev string:x717>") {
    amountunder = level.weaponengagedistvalues.engagedistmin - units;
    self[1] setvalue(units);
    self[3] setvalue(amountunder);
    self[3].alpha = 1;

    if(level.lastdisttype != engagedisttype) {
      self[2] settext("<dev string:x749>");
    }
  } else if(engagedisttype == "<dev string:x720>") {
    amountover = units - level.weaponengagedistvalues.engagedistmax;
    self[1] setvalue(units);
    self[3] setvalue(amountover);
    self[3].alpha = 1;

    if(level.lastdisttype != engagedisttype) {
      self[2] settext("<dev string:x75d>");
    }
  } else if(engagedisttype == "<dev string:x6fc>") {
    self[1] setvalue(units);
    self[2] settext("<dev string:x770>");
    self[3].alpha = 0;
  }

  level.lastdisttype = engagedisttype;
}

function function_16b58d7f() {
  level endon(#"kill_all_engage_dist_debug", #"hash_55d49f3fca6a3bdc");
  player = function_1261f881();

  while(true) {
    axis = getaiteamarray(#"axis");

    if(isDefined(axis) && axis.size > 0) {
      playereye = player getEye();

      for(i = 0; i < axis.size; i++) {
        ai = axis[i];
        aieye = ai getEye();

        if(sighttracepassed(playereye, aieye, 0, player) && !isvehicle(ai)) {
          dist = distance(playereye, aieye);
          drawcolor = (1, 1, 1);
          drawstring = "<dev string:x56f>";
          engagedistmin = ai.engagemindist;
          var_686e2a66 = ai.engageminfalloffdist;
          var_109383f6 = ai.engagemaxfalloffdist;
          engagedistmax = ai.engagemaxdist;

          if(dist >= engagedistmin && dist <= engagedistmax) {
            drawcolor = (0, 1, 0);
            drawstring = "<dev string:x796>";
          } else if(dist < engagedistmin && dist >= var_686e2a66) {
            drawcolor = (1, 1, 0);
            drawstring = "<dev string:x79e>";
          } else if(dist > engagedistmax && dist <= var_109383f6) {
            drawcolor = (1, 1, 0);
            drawstring = "<dev string:x7af>";
          } else if(dist > var_109383f6) {
            drawcolor = (1, 0, 0);
            drawstring = "<dev string:x7be>";
          } else if(dist < var_686e2a66) {
            drawcolor = (1, 0, 0);
            drawstring = "<dev string:x7c9>";
          }

          scale = dist / 1000;
          print3d(ai.origin + (0, 0, 67), drawstring + "<dev string:xba>" + dist, drawcolor, 1, scale);
        }
      }
    }

    waitframe(1);
  }
}

function function_2fcd7502() {
  if(!isDefined(level.var_4c576f0)) {
    function_3171027d();
    level.var_4c576f0 = 1;
  }

  getplayers()[0] thread function_90edec37();
  level waittill(#"hash_34e65f3c6ffc6a39");

  if(isDefined(level.dynamic_spawn_hud)) {
    level.dynamic_spawn_hud destroy();
  }

  if(isDefined(level.dynamic_spawn_dummy_model)) {
    level.dynamic_spawn_dummy_model delete();
  }
}

function function_3171027d() {
  spawners = getspawnerarray();
  level.aitypes = [];
  level.var_9f54edf5 = 0;
  var_362d54a0 = [];

  foreach(spawner in spawners) {
    if(!isDefined(var_362d54a0[spawner.classname])) {
      var_362d54a0[spawner.classname] = 1;
      struct = spawnStruct();
      classname = spawner.classname;
      vehicletype = spawner.vehicletype;

      if(issubstr(classname, "<dev string:x7d6>")) {
        struct.radius = 64;
        struct.isvehicle = 0;
        classname = getsubstr(classname, 6);
      } else {
        continue;
      }

      struct.classname = classname;
      level.aitypes[level.aitypes.size] = struct;
    }
  }
}

function function_90edec37() {
  level endon(#"hash_34e65f3c6ffc6a39");
  assert(isDefined(level.aitypes) && level.aitypes.size > 0, "<dev string:x7e0>");
  level.dynamic_spawn_hud = newdebughudelem(getplayers()[0]);
  level.dynamic_spawn_hud.alignx = "<dev string:x1fd>";
  level.dynamic_spawn_hud.x = 0;
  level.dynamic_spawn_hud.y = 245;
  level.dynamic_spawn_hud.fontscale = 1.5;
  level.dynamic_spawn_hud settext("<dev string:x7fd>");
  level.dynamic_spawn_dummy_model = spawn("<dev string:x82b>", (0, 0, 0));
  wait 0.1;

  while(true) {
    direction = self getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = self getEye();
    trace_dist = 4000;
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, trace_dist), 0, level.dynamic_spawn_dummy_model);
    dist = distance(eye, trace[# "position"]);
    position = eye + vectorscale(direction_vec, dist - level.aitypes[level.var_9f54edf5].radius);
    origin = position;
    angles = self.angles + (0, 180, 0);
    level.dynamic_spawn_dummy_model.origin = position;
    level.dynamic_spawn_dummy_model.angles = angles;
    level.dynamic_spawn_hud settext("<dev string:x83b>" + level.var_9f54edf5 + 1 + "<dev string:x88b>" + level.aitypes.size + "<dev string:x890>" + level.aitypes[level.var_9f54edf5].classname);
    level.dynamic_spawn_dummy_model detachall();
    level.dynamic_spawn_dummy_model setModel(level.aitypes[level.var_9f54edf5].classname);
    level.dynamic_spawn_dummy_model show();
    level.dynamic_spawn_dummy_model notsolid();

    if(self useButtonPressed() || self buttonPressed("<dev string:x897>")) {
      level.dynamic_spawn_dummy_model hide();

      if(level.aitypes[level.var_9f54edf5].isvehicle) {
        spawn = spawnvehicle(level.aitypes[level.var_9f54edf5].classname, origin, angles, "<dev string:x8a1>");
      } else {
        spawn = spawnactor(level.aitypes[level.var_9f54edf5].classname, origin, angles, "<dev string:x8a1>", 1);
      }

      var_ec8949ef = getdvarint(#"debug_dynamic_ai_ignoreme", 0);
      var_a127c98a = getdvarint(#"debug_dynamic_ai_ignoreall", 0);
      spawn.pacifist = getdvarint(#"debug_dynamic_ai_pacifist", 0);
      spawn val::set(#"hash_624cb07df0cbb198", "<dev string:x8b5>", var_ec8949ef);
      spawn val::set(#"hash_624cb07df0cbb198", "<dev string:x8c1>", var_a127c98a);
      spawn.fixednode = 0;
      wait 0.3;
    } else if(self buttonPressed("<dev string:x8ce>") || self buttonPressed("<dev string:x8dc>")) {
      level.dynamic_spawn_dummy_model hide();
      level.var_9f54edf5++;

      if(level.var_9f54edf5 >= level.aitypes.size) {
        level.var_9f54edf5 = 0;
      }

      wait 0.3;
    } else if(self buttonPressed("<dev string:x8ea>") || self buttonPressed("<dev string:x8f7>")) {
      level.dynamic_spawn_dummy_model hide();
      level.var_9f54edf5--;

      if(level.var_9f54edf5 < 0) {
        level.var_9f54edf5 = level.aitypes.size - 1;
      }

      wait 0.3;
    } else if(self buttonPressed("<dev string:x904>") || self buttonPressed("<dev string:x910>")) {
      setDvar(#"debug_dynamic_ai_spawning", 0);
    }

    waitframe(1);
  }
}

function function_11228d34() {
  wait 1;
  iprintlnbold("<dev string:x91b>" + level.script + "<dev string:x934>");
}

function debug_goalradius() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++) {
    if(guys[i].team == # "axis") {
      print3d(guys[i].origin + (0, 0, 70), isDefined(guys[i].goalradius) ? "<dev string:x38>" + guys[i].goalradius : "<dev string:x38>", (1, 0, 0), 1, 1, 1);
      record3dtext("<dev string:x38>" + guys[i].goalradius, guys[i].origin + (0, 0, 70), (1, 0, 0), "<dev string:x957>");
      continue;
    }

    print3d(guys[i].origin + (0, 0, 70), isDefined(guys[i].goalradius) ? "<dev string:x38>" + guys[i].goalradius : "<dev string:x38>", (0, 1, 0), 1, 1, 1);
    record3dtext("<dev string:x38>" + guys[i].goalradius, guys[i].origin + (0, 0, 70), (0, 1, 0), "<dev string:x957>");
  }
}

function function_3a215729() {
  guys = getaiarray();

  foreach(guy in guys) {
    recordcircle(guy.origin, sqrt(guy.maxsightdistsqrd), (1, 1, 0), "<dev string:x957>");
  }

  foreach(player in level.players) {
    record3dtext(isDefined(player.maxvisibledist) ? "<dev string:x38>" + player.maxvisibledist : "<dev string:x38>", player.origin, (1, 0, 0), "<dev string:x957>");
    recordcircle(player.origin, player.maxvisibledist, (1, 0, 0), "<dev string:x957>");
  }
}

function debug_health() {
  var_d4d10882 = (0, 0, 0);
  guys = getaiarray();

  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i] gettagorigin("<dev string:x965>"))) {
      var_d4d10882 = guys[i] gettagorigin("<dev string:x965>") + (0, 0, 15);
    } else {
      var_d4d10882 = guys[i] getorigin() + (0, 0, 70);
    }

    print3d(var_d4d10882, isDefined(guys[i].health) ? "<dev string:x38>" + guys[i].health : "<dev string:x38>", level.var_99e12d63[guys[i].team], 1, 0.5);
    recordenttext(isDefined(guys[i].health) ? "<dev string:x38>" + guys[i].health : "<dev string:x38>", guys[i], level.var_99e12d63[guys[i].team], "<dev string:x957>");
  }

  vehicles = getvehiclearray();

  for(i = 0; i < vehicles.size; i++) {
    recordenttext(isDefined(vehicles[i].health) ? "<dev string:x38>" + vehicles[i].health : "<dev string:x38>", vehicles[i], level.var_99e12d63[vehicles[i].team], "<dev string:x957>");
  }

  if(isDefined(level.player)) {
    recordenttext(isDefined(level.player.health) ? "<dev string:x38>" + level.player.health : "<dev string:x38>", level.player, level.var_99e12d63[# "allies"], "<dev string:x957>");
  }
}

function debug_engagedist() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++) {
    diststring = guys[i].engageminfalloffdist + "<dev string:x970>" + guys[i].engagemindist + "<dev string:x970>" + guys[i].engagemaxdist + "<dev string:x970>" + guys[i].engagemaxfalloffdist;
    recordenttext(diststring, guys[i], level.var_99e12d63[guys[i].team], "<dev string:x957>");
  }
}

function debug_sphere(origin, radius, color, alpha, time) {
  if(!isDefined(time)) {
    time = 1000;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  sides = int(10 * (1 + int(radius) % 100));
  sphere(origin, radius, color, alpha, 1, sides, time);
}