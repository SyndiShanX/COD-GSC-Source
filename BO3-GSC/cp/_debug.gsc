/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_debug.gsc
*************************************************/

#using scripts\cp\_debug_menu;
#using scripts\cp\_util;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\init;
#using scripts\shared\ai\systems\weaponlist;
#using scripts\shared\ai_puppeteer_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace debug;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, undefined);
}

function __init__() {
  level.animsound_hudlimit = 14;
  level.debugteamcolors = [];
  level.debugteamcolors[""] = (1, 0, 0);
  level.debugteamcolors[""] = (0, 1, 0);
  level.debugteamcolors[""] = (1, 1, 0);
  level.debugteamcolors[""] = (1, 1, 1);
  thread debugdvars();
  thread engagement_distance_debug_toggle();
  thread debug_coop_bot_test();
}

function drawenttag(num) {
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }
    ai[i] thread dragtaguntildeath(getdvarstring(""));
  }
  setDvar("", "");
}

function drawtag(tag, opcolor) {
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);
  drawarrow(org, ang, opcolor);
}

function draworgforever(opcolor) {
  for(;;) {
    drawarrow(self.origin, self.angles, opcolor);
    wait(0.05);
  }
}

function drawarrowforever(org, ang) {
  for(;;) {
    drawarrow(org, ang);
    wait(0.05);
  }
}

function draworiginforever() {
  for(;;) {
    drawarrow(self.origin, self.angles);
    wait(0.05);
  }
}

function drawarrow(org, ang, opcolor) {
  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);
  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }
  line(org, org + forwardfar, red, 0.9);
  line(org + forwardfar, (org + forwardclose) + rightdraw, red, 0.9);
  line(org + forwardfar, (org + forwardclose) + leftdraw, red, 0.9);
  line(org, org + right, blue, 0.9);
  line(org, org + up, green, 0.9);
}

function drawplayerviewforever() {
  for(;;) {
    drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    wait(0.05);
  }
}

function drawtagforever(tag, opcolor) {
  self endon("death");
  for(;;) {
    drawtag(tag, opcolor);
    wait(0.05);
  }
}

function dragtaguntildeath(tag) {
  for(;;) {
    if(!isDefined(self.origin)) {
      break;
    }
    drawtag(tag);
    wait(0.05);
  }
}

function viewtag(type, tag) {
  if(type == "") {
    ai = getaiarray();
    for(i = 0; i < ai.size; i++) {
      ai[i] drawtag(tag);
    }
  } else {
    vehicle = getEntArray("", "");
    for(i = 0; i < vehicle.size; i++) {
      vehicle[i] drawtag(tag);
    }
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
    line(org + vectorscale((0, 0, 1), 35), org, (0.2, 0.5, 0.8), 0.5);
    wait(0.05);
  }
}

function createlineconstantly(ent) {
  org = undefined;
  while(isalive(ent)) {
    org = ent.origin;
    wait(0.05);
  }
  for(;;) {
    line(org + vectorscale((0, 0, 1), 35), org, (1, 0.2, 0.1), 0.5);
    wait(0.05);
  }
}

function debugmisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");
  for(;;) {
    if(self.a.misstime <= 0) {
      print3d(self gettagorigin("") + vectorscale((0, 0, 1), 15), "", (0.3, 1, 1), 1);
    } else {
      print3d(self gettagorigin("") + vectorscale((0, 0, 1), 15), self.a.misstime / 20, (0.3, 1, 1), 1);
    }
    wait(0.05);
  }
}

function debugmisstimeoff() {
  self notify("stopdebugmisstime");
}

function setemptydvar(dvar, setting) {
  /
  #
  if(getdvarstring(dvar) == "") {
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
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  setemptydvar("", "");
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  level.debug_badpath = 0;
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  for(i = 1; i <= level.animsound_hudlimit; i++) {
    if((getdvarstring("" + i)) == "") {
      setDvar("" + i, "");
    }
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
    setDvar("", "");
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  level.last_threat_debug = -23430;
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  waittillframeend();
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  noanimscripts = getdvarstring("") == "";
  for(;;) {
    if(getdvarstring("") != "") {
      debugjump(getdvarstring(""));
    }
    if(getdvarint("") == 1) {
      level thread function_2ceda325();
    }
    if(getdvarstring("") != "") {
      thread viewtag("", getdvarstring(""));
      if(getdvarstring("") > 0) {
        thread drawenttag(getdvarstring(""));
      }
    }
    if(getdvarstring("") == "") {
      level thread debug_goalradius();
    }
    if(getdvarstring("") == "") {
      level thread debug_maxvisibledist();
    }
    if(getdvarstring("") == "") {
      level thread debug_health();
    }
    if(getdvarstring("") == "") {
      level thread debug_engagedist();
    }
    if(getdvarstring("") != "") {
      thread viewtag("", getdvarstring(""));
    }
    thread debug_animsound();
    if(getdvarstring("") != "") {
      thread debug_animsoundtagselected();
    }
    for(i = 1; i <= level.animsound_hudlimit; i++) {
      if((getdvarstring("" + i)) != "") {
        thread debug_animsoundtag(i);
      }
    }
    if(getdvarstring("") != "") {
      thread debug_animsoundsave();
    }
    if(getdvarstring("") != "") {
      thread debug_nuke();
    }
    if(getdvarstring("") == "") {
      setDvar("", "");
      array::thread_all(getaiarray(), &debugmisstime);
    } else if(getdvarstring("") == "") {
      setDvar("", "");
      array::thread_all(getaiarray(), &debugmisstimeoff);
    }
    if(getdvarstring("") == "") {
      thread deathspawnerpreview();
    }
    if(getdvarstring("") == "") {
      setDvar("", "");
      players = getplayers();
      for(i = 0; i < players.size; i++) {
        players[i] dodamage(50, (324234, 3423423, 2323));
      }
    }
    if(getdvarstring("") == "") {
      setDvar("", "");
      players = getplayers();
      for(i = 0; i < players.size; i++) {
        players[i] dodamage(50, (324234, 3423423, 2323));
      }
    }
    if(getdvarstring("") == "") {
      thread fogcheck();
    }
    if(getdvarstring("") != "" && getdvarstring("") != "") {
      debugthreat();
    }
    level.debug_badpath = getdvarstring("") == "";
    if(!noanimscripts && getdvarstring("") == "") {
      noanimscripts = 1;
    }
    if(noanimscripts && getdvarstring("") == "") {
      anim.defaultexception = &util::empty;
      anim notify("hash_9a6633d5");
      noanimscripts = 0;
    }
    if(getdvarstring("") == "") {
      if(!isDefined(level.tracestart)) {
        thread showdebugtrace();
      }
      players = getplayers();
      level.tracestart = players[0] getEye();
      setDvar("", "");
    }
    if(getdvarstring("") == "" && (!isDefined(level.spawn_anywhere_active) || level.spawn_anywhere_active == 0)) {
      level.spawn_anywhere_active = 1;
      thread dynamic_ai_spawner();
    } else if(getdvarstring("") == "" && isDefined(level.spawn_anywhere_active) && level.spawn_anywhere_active == 1) {
      level.spawn_anywhere_active = 0;
      level notify("hash_d123a0a5");
    }
    debug_ik_on_actors();
    wait(0.05);
  }
}

function debug_ik_on_actors() {
  toggleon = getdvarstring("") == "";
  if(!toggleon) {
    return;
  }
  togglelegik = getdvarstring("") == "";
  toggleheadik = getdvarstring("") == "";
  ais = getactorarray();
  foreach(ai in ais) {
    if(togglelegik) {
      ai.enableterrainik = 1;
    } else {
      ai.enableterrainik = 0;
    }
    if(toggleheadik) {
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
    wait(0.05);
    start = startoverride;
    end = endoverride;
    if(!isDefined(startoverride)) {
      start = level.tracestart;
    }
    if(!isDefined(endoverride)) {
      end = players[0] getEye();
    }
    trace = bulletTrace(start, end, 0, undefined);
    line(start, trace[""], (0.9, 0.5, 0.8), 0.5);
  }
}

function hatmodel() {
  for(;;) {
    if(getdvarstring("") == "") {
      return;
    }
    nohat = [];
    ai = getaiarray();
    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].hatmodel)) {
        continue;
      }
      alreadyknown = 0;
      for(p = 0; p < nohat.size; p++) {
        if(nohat[p] != ai[i].classname) {
          continue;
        }
        alreadyknown = 1;
        break;
      }
      if(!alreadyknown) {
        nohat[nohat.size] = ai[i].classname;
      }
    }
    if(nohat.size) {
      println("");
      println("");
      for(i = 0; i < nohat.size; i++) {
        println("", nohat[i]);
      }
      println("");
    }
    wait(15);
  }
}

function debug_nuke() {
  players = getplayers();
  player = players[0];
  dvar = getdvarstring("");
  if(dvar == "") {
    ai = getaiteamarray("", "");
    for(i = 0; i < ai.size; i++) {
      ignore = 0;
      classname = ai[i].classname;
      if(isDefined(classname) && (issubstr(classname, "") || issubstr(classname, "") || issubstr(classname, ""))) {
        ignore = 1;
      }
      if(!ignore) {
        ai[i] dodamage(ai[i].health, (0, 0, 0), player);
      }
    }
  } else {
    if(dvar == "") {
      ai = getaiteamarray("");
      for(i = 0; i < ai.size; i++) {
        ai[i] dodamage(ai[i].health, (0, 0, 0), player);
      }
    } else if(dvar == "") {
      ai = getaispeciesarray("", "");
      for(i = 0; i < ai.size; i++) {
        ai[i] dodamage(ai[i].health, (0, 0, 0), player);
      }
    }
  }
  setDvar("", "");
}

function debug_misstime() {}

function freeplayer() {
  setDvar("", "");
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
        print3d(ent.origin, (i + "") + ent.truecount, (0, 0.8, 0.6), 5);
        continue;
      }
      print3d(ent.origin, (i + "") + "", (0, 0.8, 0.6), 5);
    }
  }
}

function getchains() {
  chainarray = [];
  chainarray = getEntArray("", "");
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
    ent = getent(ent.target, "");
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

function islookingatorigin(origin) {
  normalvec = vectornormalize(origin - self getshootatpos());
  veccomp = vectornormalize((origin - vectorscale((0, 0, 1), 24)) - self getshootatpos());
  insidedot = vectordot(normalvec, veccomp);
  anglevec = anglesToForward(self getplayerangles());
  vectordot = vectordot(anglevec, normalvec);
  if(vectordot > insidedot) {
    return true;
  }
  return false;
}

function fogcheck() {
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  close = getdvarint("");
  far = getdvarint("");
  setexpfog(close, far, 1, 1, 1, 0);
}

function debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

function debugthreatcalc() {
  ai = getaiarray();
  entnum = getdvarstring("");
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
  self endon("death");
  if(self.team == entity.team) {
    return;
  }
  selfthreat = 0;
  selfthreat = selfthreat + self.threatbias;
  threat = 0;
  threat = threat + entity.threatbias;
  mygroup = undefined;
  if(isDefined(entitygroup)) {
    mygroup = self getthreatbiasgroup();
    if(isDefined(mygroup)) {
      threat = threat + getthreatbias(entitygroup, mygroup);
      selfthreat = selfthreat + getthreatbias(mygroup, entitygroup);
    }
  }
  if(entity.ignoreme || threat < -900000) {
    threat = "";
  }
  if(self.ignoreme || selfthreat < -900000) {
    selfthreat = "";
  }
  players = getplayers();
  col = (1, 0.5, 0.2);
  col2 = (0.2, 0.5, 1);
  pacifist = self != players[0] && self.pacifist;
  for(i = 0; i <= 20; i++) {
    print3d(self.origin + vectorscale((0, 0, 1), 65), "", col, 3);
    print3d(self.origin + vectorscale((0, 0, 1), 50), threat, col, 5);
    if(isDefined(entitygroup)) {
      print3d(self.origin + vectorscale((0, 0, 1), 35), entitygroup, col, 2);
    }
    print3d(self.origin + vectorscale((0, 0, 1), 15), "", col2, 3);
    print3d(self.origin + (0, 0, 0), selfthreat, col2, 5);
    if(isDefined(mygroup)) {
      print3d(self.origin + (vectorscale((0, 0, -1), 15)), mygroup, col2, 2);
    }
    if(pacifist) {
      print3d(self.origin + vectorscale((0, 0, 1), 25), "", col2, 5);
    }
    wait(0.05);
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
  notetracks = getarraykeys(level.scr_notetrack[animname]);
  for(i = 0; i < notetracks.size; i++) {
    soundalias = level.scr_notetrack[animname][i][""];
    if(!isDefined(soundalias)) {
      continue;
    }
    anime = level.scr_notetrack[animname][i][""];
    notetrack = level.scr_notetrack[animname][i][""];
    level.animsound_aliases[animname][anime][notetrack][""] = soundalias;
    if(isDefined(level.scr_notetrack[animname][i][""])) {
      level.animsound_aliases[animname][anime][notetrack][""] = 1;
    }
  }
}

function init_animsounds_for_animname(animname) {
  animes = getarraykeys(level.scr_animsound[animname]);
  for(i = 0; i < animes.size; i++) {
    anime = animes[i];
    soundalias = level.scr_animsound[animname][anime];
    level.animsound_aliases[animname][anime]["" + anime][""] = soundalias;
    level.animsound_aliases[animname][anime]["" + anime][""] = 1;
  }
}

function add_hud_line(x, y, msg) {
  hudelm = newhudelem();
  hudelm.alignx = "";
  hudelm.aligny = "";
  hudelm.x = x;
  hudelm.y = y;
  hudelm.alpha = 1;
  hudelm.fontscale = 1;
  hudelm.label = msg;
  level.animsound_hud_extralines[level.animsound_hud_extralines.size] = hudelm;
  return hudelm;
}

function debug_animsound() {
  enabled = getdvarstring("") == "";
  if(!isDefined(level.animsound_hud)) {
    if(!enabled) {
      return;
    }
    level.animsound_selected = 0;
    level.animsound_input = "";
    level.animsound_hud = [];
    level.animsound_hud_timer = [];
    level.animsound_hud_alias = [];
    level.animsound_hud_extralines = [];
    level.animsound_locked = 0;
    level.animsound_locked_pressed = 0;
    level.animsound_hud_animname = add_hud_line(-30, 180, "");
    level.animsound_hud_anime = add_hud_line(100, 180, "");
    add_hud_line(10, 190, "");
    add_hud_line(-30, 190, "");
    add_hud_line(-30, 160, "");
    add_hud_line(-30, 150, "");
    add_hud_line(-30, 140, "");
    level.animsound_hud_locked = add_hud_line(-30, 170, "");
    level.animsound_hud_locked.alpha = 0;
    for(i = 0; i < level.animsound_hudlimit; i++) {
      hudelm = newhudelem();
      hudelm.alignx = "";
      hudelm.aligny = "";
      hudelm.x = 10;
      hudelm.y = 200 + (i * 10);
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud[level.animsound_hud.size] = hudelm;
      hudelm = newhudelem();
      hudelm.alignx = "";
      hudelm.aligny = "";
      hudelm.x = -10;
      hudelm.y = 200 + (i * 10);
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud_timer[level.animsound_hud_timer.size] = hudelm;
      hudelm = newhudelem();
      hudelm.alignx = "";
      hudelm.aligny = "";
      hudelm.x = 210;
      hudelm.y = 200 + (i * 10);
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud_alias[level.animsound_hud_alias.size] = hudelm;
    }
    level.animsound_hud[0].color = (1, 1, 0);
    level.animsound_hud_timer[0].color = (1, 1, 0);
  } else if(!enabled) {
    for(i = 0; i < level.animsound_hudlimit; i++) {
      level.animsound_hud[i] destroy();
      level.animsound_hud_timer[i] destroy();
      level.animsound_hud_alias[i] destroy();
    }
    for(i = 0; i < level.animsound_hud_extralines.size; i++) {
      level.animsound_hud_extralines[i] destroy();
    }
    level.animsound_hud = undefined;
    level.animsound_hud_timer = undefined;
    level.animsound_hud_alias = undefined;
    level.animsound_hud_extralines = undefined;
    level.animsounds = undefined;
    return;
  }
  if(!isDefined(level.animsound_tagged)) {
    level.animsound_locked = 0;
  }
  if(level.animsound_locked) {
    level.animsound_hud_locked.alpha = 1;
  } else {
    level.animsound_hud_locked.alpha = 0;
  }
  if(!isDefined(level.animsounds)) {
    init_animsounds();
  }
  level.animsounds_thisframe = [];
  arrayremovevalue(level.animsounds, undefined);
  array::thread_all(level.animsounds, &display_animsound);
  players = getplayers();
  if(level.animsound_locked) {
    for(i = 0; i < level.animsounds_thisframe.size; i++) {
      animsound = level.animsounds_thisframe[i];
      animsound.animsound_color = vectorscale((1, 1, 1), 0.5);
    }
  } else if(players.size > 0) {
    dot = 0.85;
    forward = anglesToForward(players[0] getplayerangles());
    for(i = 0; i < level.animsounds_thisframe.size; i++) {
      animsound = level.animsounds_thisframe[i];
      animsound.animsound_color = (0.25, 1, 0.5);
      difference = vectornormalize((animsound.origin + vectorscale((0, 0, 1), 40)) - (players[0].origin + vectorscale((0, 0, 1), 55)));
      newdot = vectordot(forward, difference);
      if(newdot < dot) {
        continue;
      }
      dot = newdot;
      level.animsound_tagged = animsound;
    }
  }
  if(isDefined(level.animsound_tagged)) {
    level.animsound_tagged.animsound_color = (1, 1, 0);
  }
  is_tagged = isDefined(level.animsound_tagged);
  for(i = 0; i < level.animsounds_thisframe.size; i++) {
    animsound = level.animsounds_thisframe[i];
    msg = "";
    if(level.animsound_locked) {
      msg = "";
    }
    print3d(animsound.origin + vectorscale((0, 0, 1), 40), msg + animsound.animsounds.size, animsound.animsound_color, 1, 1);
  }
  if(is_tagged) {
    draw_animsounds_in_hud();
  }
}

function draw_animsounds_in_hud() {
  guy = level.animsound_tagged;
  animsounds = guy.animsounds;
  animname = "";
  if(isDefined(guy.animname)) {
    animname = guy.animname;
  }
  level.animsound_hud_animname.label = "" + animname;
  players = getplayers();
  if(players[0] buttonpressed("")) {
    if(!level.animsound_locked_pressed) {
      level.animsound_locked = !level.animsound_locked;
      level.animsound_locked_pressed = 1;
    }
  } else {
    level.animsound_locked_pressed = 0;
  }
  if(players[0] buttonpressed("")) {
    if(level.animsound_input != "") {
      level.animsound_selected--;
    }
    level.animsound_input = "";
  } else {
    if(players[0] buttonpressed("")) {
      if(level.animsound_input != "") {
        level.animsound_selected++;
      }
      level.animsound_input = "";
    } else {
      level.animsound_input = "";
    }
  }
  for(i = 0; i < level.animsound_hudlimit; i++) {
    hudelm = level.animsound_hud[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_timer[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_alias[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
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
  if(level.animsound_selected > highest) {
    level.animsound_selected = highest;
  }
  if(level.animsound_selected < 0) {
    level.animsound_selected = 0;
  }
  for(;;) {
    if(isDefined(animsounds[level.animsound_selected])) {
      break;
    }
    level.animsound_selected--;
    if(level.animsound_selected < 0) {
      level.animsound_selected = highest;
    }
  }
  level.animsound_hud_anime.label = "" + animsounds[level.animsound_selected].anime;
  level.animsound_hud[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_timer[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_alias[level.animsound_selected].color = (1, 1, 0);
  time = gettime();
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    animsound = animsounds[key];
    hudelm = level.animsound_hud[key];
    soundalias = get_alias_from_stored(animsound);
    hudelm.label = ((key + 1) + "") + animsound.notetrack;
    hudelm = level.animsound_hud_timer[key];
    hudelm.label = int((time - (animsound.end_time - 60000)) * 0.001);
    if(isDefined(soundalias)) {
      hudelm = level.animsound_hud_alias[key];
      hudelm.label = soundalias;
      if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
        hudelm.color = vectorscale((1, 1, 1), 0.7);
      }
    }
  }
  players = getplayers();
  if(players[0] buttonpressed("")) {
    animsound = animsounds[level.animsound_selected];
    soundalias = get_alias_from_stored(animsound);
    if(!isDefined(soundalias)) {
      return;
    }
    if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
      return;
    }
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack] = undefined;
    debug_animsoundsave();
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
  return level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][""];
}

function is_from_animsound(animname, anime, notetrack) {
  return isDefined(level.animsound_aliases[animname][anime][notetrack][""]);
}

function display_animsound() {
  players = getplayers();
  if(distance(players[0].origin, self.origin) > 1500) {
    return;
  }
  level.animsounds_thisframe[level.animsounds_thisframe.size] = self;
}

function debug_animsoundtag(tagnum) {
  tag = getdvarstring("" + tagnum);
  if(tag == "") {
    iprintlnbold("");
    return;
  }
  tag_sound(tag, tagnum - 1);
  setDvar("" + tagnum, "");
}

function debug_animsoundtagselected() {
  tag = getdvarstring("");
  if(tag == "") {
    iprintlnbold("");
    return;
  }
  tag_sound(tag, level.animsound_selected);
  setDvar("", "");
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
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][""] = tag;
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack][""] = 1;
    debug_animsoundsave();
  }
}

function debug_animsoundsave() {
  filename = ("" + level.script) + "";
  file = openfile(filename, "");
  if(file == -1) {
    iprintlnbold(("" + filename) + "");
    return;
  }
  iprintlnbold("" + filename);
  print_aliases_to_file(file);
  saved = closefile(file);
  setDvar("", "");
}

function print_aliases_to_file(file) {
  tab = "";
  fprintln(file, "");
  fprintln(file, "");
  fprintln(file, "");
  fprintln(file, tab + "");
  fprintln(file, tab + "");
  fprintln(file, "");
  fprintln(file, "");
  fprintln(file, "");
  fprintln(file, "");
  fprintln(file, tab + "");
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
        alias = level.animsound_aliases[animnames[i]][anime][notetrack][""];
        if(notetrack == ("" + anime)) {
          fprintln(file, (((tab + "") + tostr(animnames[i]) + "") + tostr(anime) + "") + tostr(alias) + "");
        } else {
          fprintln(file, ((((tab + "") + tostr(animnames[i]) + "") + tostr(anime) + "") + tostr(notetrack) + "") + tostr(alias) + "");
        }
        println((("" + alias) + "") + notetrack);
      }
    }
  }
  fprintln(file, "");
}

function function_2ceda325() {
  setDvar("", 0);
  if(!isDefined(level.a_npcdeaths) || getdvarint("") != 1) {
    return;
  }
  players = getplayers();
  filename = ((("" + level.savename) + "") + players[0].playername) + "";
  file = openfile(filename, "");
  if(file == -1) {
    iprintlnbold(("" + filename) + "");
    return;
  }
  if(isDefined(level.current_skipto)) {
    fprintln(file, ("" + level.current_skipto) + "");
  } else {
    fprintln(file, "");
  }
  if(level.a_npcdeaths.size <= 0) {
    fprintln(file, "");
  }
  foreach(deadnpctypecount in level.a_npcdeaths) {
    fprintln(file, (((((deadnpctypecount.strscoretype + "") + deadnpctypecount.icount) + "") + deadnpctypecount.ikilledbyplayercount) + "") + deadnpctypecount.ixpvaluesum);
  }
  fprintln(file, "");
  iprintlnbold("" + filename);
  saved = closefile(file);
  level.a_npcdeaths = [];
}

function tostr(str) {
  newstr = "";
  for(i = 0; i < str.size; i++) {
    if(str[i] == "") {
      newstr = newstr + "";
      newstr = newstr + "";
      continue;
    }
    newstr = newstr + str[i];
  }
  newstr = newstr + "";
  return newstr;
}

function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    wait(0.05);
  }
}

function drawdebugline(frompoint, topoint, color, durationframes) {
  thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
}

function drawdebugenttoentinternal(ent1, ent2, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    if(!isDefined(ent1) || !isDefined(ent2)) {
      return;
    }
    line(ent1.origin, ent2.origin, color);
    wait(0.05);
  }
}

function drawdebuglineenttoent(ent1, ent2, color, durationframes) {
  thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
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
  hud_title = newdebughudelem();
  hud_title.x = 10;
  hud_title.y = 300;
  hud_title.alpha = 0;
  hud_title.alignx = "";
  hud_title.fontscale = 1.2;
  hud_title settext(&"");
  x_pos = hud_title.x + 50;
  hud_x = newdebughudelem();
  hud_x.x = x_pos;
  hud_x.y = 300;
  hud_x.alpha = 0;
  hud_x.alignx = "";
  hud_x.fontscale = 1.2;
  hud_x setvalue(0);
  hud_y = newdebughudelem();
  hud_y.x = 10;
  hud_y.y = 300;
  hud_y.alpha = 0;
  hud_y.alignx = "";
  hud_y.fontscale = 1.2;
  hud_y setvalue(0);
  hud_z = newdebughudelem();
  hud_z.x = 10;
  hud_z.y = 300;
  hud_z.alpha = 0;
  hud_z.alignx = "";
  hud_z.fontscale = 1.2;
  hud_z setvalue(0);
  setDvar("", "");
  players = getplayers();
  while(true) {
    if(getdvarint("") > 0) {
      hud_title.alpha = 1;
      hud_x.alpha = 1;
      hud_y.alpha = 1;
      hud_z.alpha = 1;
      x = players[0].origin[0];
      y = players[0].origin[1];
      z = players[0].origin[2];
      spacing1 = ((2 + number_before_decimal(x)) * 8) + 10;
      spacing2 = ((2 + number_before_decimal(y)) * 8) + 10;
      hud_y.x = x_pos + spacing1;
      hud_z.x = (x_pos + spacing1) + spacing2;
      hud_x setvalue(round_to(x, 100));
      hud_y setvalue(round_to(y, 100));
      hud_z setvalue(round_to(z, 100));
    } else {
      hud_title.alpha = 0;
      hud_x.alpha = 0;
      hud_y.alpha = 0;
      hud_z.alpha = 0;
    }
    wait(0.5);
  }
}

function number_before_decimal(num) {
  abs_num = abs(num);
  count = 0;
  while(true) {
    abs_num = abs_num * 0.1;
    count = count + 1;
    if(abs_num < 1) {
      return count;
    }
  }
}

function round_to(val, num) {
  return (int(val * num)) / num;
}

function set_event_printname_thread(text, focus) {
  level notify("stop_event_name_thread");
  level endon("stop_event_name_thread");
  if(getdvarint("") > 0) {
    return;
  }
  if(!isDefined(focus)) {
    focus = 0;
  }
  suffix = "";
  if(focus) {
    suffix = "";
  }
  setDvar("", text);
  text = ("" + text) + suffix;
  if(!isDefined(level.event_hudelem)) {
    hud = newhudelem();
    hud.horzalign = "";
    hud.alignx = "";
    hud.aligny = "";
    hud.foreground = 1;
    hud.fontscale = 1.5;
    hud.sort = 50;
    hud.alpha = 1;
    hud.y = 15;
    level.event_hudelem = hud;
  }
  if(focus) {
    level.event_hudelem.color = (1, 1, 0);
  } else {
    level.event_hudelem.color = (1, 1, 1);
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  level.event_hudelem settext(text);
  enabled = 1;
  while(true) {
    toggle = 0;
    if(getdvarint("") < 1) {
      toggle = 1;
      enabled = 0;
    } else if(getdvarint("") > 0) {
      toggle = 1;
      enabled = 1;
    }
    if(toggle && enabled) {
      level.event_hudelem.alpha = 1;
    } else if(toggle) {
      level.event_hudelem.alpha = 0;
    }
    wait(0.5);
  }
}

function get_playerone() {
  return level.players[0];
}

function engagement_distance_debug_toggle() {
  level endon("kill_engage_dist_debug_toggle_watcher");
  laststate = getdvarint("");
  while(true) {
    currentstate = getdvarint("");
    if(dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
      weapon_engage_dists_init();
      thread debug_realtime_engage_dist();
      thread debug_ai_engage_dist();
      laststate = currentstate;
    } else if(!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
      level notify("kill_all_engage_dist_debug");
      laststate = currentstate;
    }
    wait(0.3);
  }
}

function dvar_turned_on(val) {
  if(val <= 0) {
    return false;
  }
  return true;
}

function engagement_distance_debug_init(player) {
  level.realtimeengagedist = newclienthudelem(player);
  level.realtimeengagedist.alignx = "";
  level.realtimeengagedist.fontscale = 1.5;
  level.realtimeengagedist.x = -50;
  level.realtimeengagedist.y = 250;
  level.realtimeengagedist.color = (1, 1, 1);
  level.realtimeengagedist settext("");
  xpos = 157;
  level.realtimeengagedist_value = newclienthudelem(player);
  level.realtimeengagedist_value.alignx = "";
  level.realtimeengagedist_value.fontscale = 1.5;
  level.realtimeengagedist_value.x = xpos;
  level.realtimeengagedist_value.y = 250;
  level.realtimeengagedist_value.color = (1, 1, 1);
  level.realtimeengagedist_value setvalue(0);
  xpos = xpos + 37;
  level.realtimeengagedist_middle = newclienthudelem(player);
  level.realtimeengagedist_middle.alignx = "";
  level.realtimeengagedist_middle.fontscale = 1.5;
  level.realtimeengagedist_middle.x = xpos;
  level.realtimeengagedist_middle.y = 250;
  level.realtimeengagedist_middle.color = (1, 1, 1);
  level.realtimeengagedist_middle settext("");
  xpos = xpos + 105;
  level.realtimeengagedist_offvalue = newclienthudelem(player);
  level.realtimeengagedist_offvalue.alignx = "";
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
  engage_dists_add("", genericpistol);
  engage_dists_add("", genericsmg);
  engage_dists_add("", shotty);
  engage_dists_add("", generichmg);
  engage_dists_add("", genericriflesa);
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
  level endon("kill_all_engage_dist_debug");
  level endon("kill_engage_dists_watcher");
  while(true) {
    player = get_playerone();
    playerweapon = player getcurrentweapon();
    if(!isDefined(player.lastweapon)) {
      player.lastweapon = playerweapon;
    } else if(player.lastweapon == playerweapon) {
      wait(0.05);
      continue;
    }
    values = get_engage_dists(playerweapon.weapclass);
    if(isDefined(values)) {
      level.weaponengagedistvalues = values;
    } else {
      level.weaponengagedistvalues = undefined;
    }
    player.lastweapon = playerweapon;
    wait(0.05);
  }
}

function debug_realtime_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_realtime_engagement_distance_debug");
  player = get_playerone();
  hudobjarray = engagement_distance_debug_init(player);
  level thread engage_dist_debug_hud_destroy(hudobjarray, "");
  level.debugrtengagedistcolor = (0, 1, 0);
  while(true) {
    lasttracepos = (0, 0, 0);
    direction = player getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
    tracepoint = trace[""];
    tracenormal = trace[""];
    tracedist = int(distance(eye, tracepoint));
    if(tracepoint != lasttracepos) {
      lasttracepos = tracepoint;
      if(!isDefined(level.weaponengagedistvalues)) {
        hudobj_changecolor(hudobjarray, (1, 1, 1));
        hudobjarray engagedist_hud_changetext("", tracedist);
      } else {
        engagedistmin = level.weaponengagedistvalues.engagedistmin;
        engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
        engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
        engagedistmax = level.weaponengagedistvalues.engagedistmax;
        if(tracedist >= engagedistmin && tracedist <= engagedistmax) {
          if(tracedist >= (engagedistoptimal - engagedistmulligan) && tracedist <= (engagedistoptimal + engagedistmulligan)) {
            hudobjarray engagedist_hud_changetext("", tracedist);
            hudobj_changecolor(hudobjarray, (0, 1, 0));
          } else {
            hudobjarray engagedist_hud_changetext("", tracedist);
            hudobj_changecolor(hudobjarray, (1, 1, 0));
          }
        } else {
          if(tracedist < engagedistmin) {
            hudobj_changecolor(hudobjarray, (1, 0, 0));
            hudobjarray engagedist_hud_changetext("", tracedist);
          } else if(tracedist > engagedistmax) {
            hudobj_changecolor(hudobjarray, (1, 0, 0));
            hudobjarray engagedist_hud_changetext("", tracedist);
          }
        }
      }
    }
    thread plot_circle_fortime(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    thread plot_circle_fortime(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    wait(0.05);
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
    level.lastdisttype = "";
  }
  if(engagedisttype == "") {
    self[1] setvalue(units);
    self[2] settext("");
    self[3].alpha = 0;
  } else {
    if(engagedisttype == "") {
      self[1] setvalue(units);
      self[2] settext("");
      self[3].alpha = 0;
    } else {
      if(engagedisttype == "") {
        amountunder = level.weaponengagedistvalues.engagedistmin - units;
        self[1] setvalue(units);
        self[3] setvalue(amountunder);
        self[3].alpha = 1;
        if(level.lastdisttype != engagedisttype) {
          self[2] settext("");
        }
      } else {
        if(engagedisttype == "") {
          amountover = units - level.weaponengagedistvalues.engagedistmax;
          self[1] setvalue(units);
          self[3] setvalue(amountover);
          self[3].alpha = 1;
          if(level.lastdisttype != engagedisttype) {
            self[2] settext("");
          }
        } else if(engagedisttype == "") {
          self[1] setvalue(units);
          self[2] settext("");
          self[3].alpha = 0;
        }
      }
    }
  }
  level.lastdisttype = engagedisttype;
}

function debug_ai_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_ai_engagement_distance_debug");
  player = get_playerone();
  while(true) {
    axis = getaiteamarray("");
    if(isDefined(axis) && axis.size > 0) {
      playereye = player getEye();
      for(i = 0; i < axis.size; i++) {
        ai = axis[i];
        aieye = ai getEye();
        if(sighttracepassed(playereye, aieye, 0, player) && !isvehicle(ai)) {
          dist = distance(playereye, aieye);
          drawcolor = (1, 1, 1);
          drawstring = "";
          engagedistmin = ai.engagemindist;
          engagedistfalloffmin = ai.engageminfalloffdist;
          engagedistfalloffmax = ai.engagemaxfalloffdist;
          engagedistmax = ai.engagemaxdist;
          if(dist >= engagedistmin && dist <= engagedistmax) {
            drawcolor = (0, 1, 0);
            drawstring = "";
          } else {
            if(dist < engagedistmin && dist >= engagedistfalloffmin) {
              drawcolor = (1, 1, 0);
              drawstring = "";
            } else {
              if(dist > engagedistmax && dist <= engagedistfalloffmax) {
                drawcolor = (1, 1, 0);
                drawstring = "";
              } else {
                if(dist > engagedistfalloffmax) {
                  drawcolor = (1, 0, 0);
                  drawstring = "";
                } else if(dist < engagedistfalloffmin) {
                  drawcolor = (1, 0, 0);
                  drawstring = "";
                }
              }
            }
          }
          scale = dist / 1000;
          print3d(ai.origin + vectorscale((0, 0, 1), 67), (drawstring + "") + dist, drawcolor, 1, scale);
        }
      }
    }
    wait(0.05);
  }
}

function bot_count() {
  count = 0;
  foreach(player in level.players) {
    if(player istestclient()) {
      count++;
    }
  }
  return count;
}

function function_6a200458() {
  count = 0;
  foreach(player in level.players) {
    if(!player istestclient()) {
      count++;
    }
  }
  return count;
}

function debug_coop_bot_test() {
  adddebugcommand("");
  while(!isDefined(level.players)) {
    wait(0.5);
  }
  var_d49b0ff = 0;
  while(true) {
    if(getdvarint("") > 0) {
      while(getdvarint("") > 0) {
        var_7e4baf07 = 4 - function_6a200458();
        botcount = bot_count();
        if(botcount > 0 && randomint(100) > 60) {
          util::add_queued_debug_command("");
          wait(2);
          debugmsg("" + bot_count());
        } else if(botcount < var_7e4baf07) {
          if(botcount < getdvarint("") && randomint(100) > 50) {
            var_d49b0ff = 1;
            util::add_queued_debug_command("");
            wait(2);
            debugmsg("" + bot_count());
          }
        }
        wait(randomintrange(1, 3));
      }
    } else if(var_d49b0ff) {
      while(bot_count() > 0) {
        util::add_queued_debug_command("");
        wait(2);
        debugmsg("" + bot_count());
      }
      var_d49b0ff = 0;
    }
    wait(1);
  }
}

function debugmsg(str_txt) {
  /
  #
  iprintlnbold(str_txt);
  if(isDefined(level.name)) {
    println((("" + level.name) + "") + str_txt);
  }
}

function plot_circle_fortime(radius1, radius2, time, color, origin, normal) {
  if(!isDefined(color)) {
    color = (0, 1, 0);
  }
  circleres = 6;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0;
  radius = radius2;
  angletoplayer = vectortoangles(normal);
  for(i = 0; i < circleres; i++) {
    plotpoints[plotpoints.size] = origin + (vectorscale(anglesToForward(angletoplayer + (rad, 90, 0)), radius));
    rad = rad + circleinc;
  }
  plot_points(plotpoints, color[0], color[1], color[2], time);
}

function dynamic_ai_spawner() {
  if(!isDefined(level.debug_dynamic_ai_spawner)) {
    dynamic_ai_spawner_find_spawners();
    level.debug_dynamic_ai_spawner = 1;
  }
  getplayers()[0] thread spawn_guy_placement();
  level waittill("hash_d123a0a5");
  if(isDefined(level.dynamic_spawn_hud)) {
    level.dynamic_spawn_hud destroy();
  }
  if(isDefined(level.dynamic_spawn_dummy_model)) {
    level.dynamic_spawn_dummy_model delete();
  }
}

function dynamic_ai_spawner_find_spawners() {
  spawners = getspawnerarray();
  level.aitypes = [];
  level.aitype_index = 0;
  var_7b3173a8 = [];
  foreach(spawner in spawners) {
    if(!isDefined(var_7b3173a8[spawner.classname])) {
      var_7b3173a8[spawner.classname] = 1;
      struct = spawnStruct();
      classname = spawner.classname;
      vehicletype = spawner.vehicletype;
      if(issubstr(classname, "")) {
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

function spawn_guy_placement() {
  level endon("hash_d123a0a5");
  assert(isDefined(level.aitypes) && level.aitypes.size > 0, "");
  level.dynamic_spawn_hud = newclienthudelem(getplayers()[0]);
  level.dynamic_spawn_hud.alignx = "";
  level.dynamic_spawn_hud.x = 0;
  level.dynamic_spawn_hud.y = 245;
  level.dynamic_spawn_hud.fontscale = 1.5;
  level.dynamic_spawn_hud settext("");
  level.dynamic_spawn_dummy_model = spawn("", (0, 0, 0));
  wait(0.1);
  while(true) {
    direction = self getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = self getEye();
    trace_dist = 4000;
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, trace_dist), 0, level.dynamic_spawn_dummy_model);
    dist = distance(eye, trace[""]);
    position = eye + (vectorscale(direction_vec, dist - level.aitypes[level.aitype_index].radius));
    origin = position;
    angles = self.angles + vectorscale((0, 1, 0), 180);
    level.dynamic_spawn_dummy_model.origin = position;
    level.dynamic_spawn_dummy_model.angles = angles;
    level.dynamic_spawn_hud settext((((("" + level.aitype_index) + "") + level.aitypes.size) + "") + level.aitypes[level.aitype_index].classname);
    level.dynamic_spawn_dummy_model detachall();
    level.dynamic_spawn_dummy_model setModel(level.aitypes[level.aitype_index].classname);
    level.dynamic_spawn_dummy_model show();
    level.dynamic_spawn_dummy_model notsolid();
    if(self usebuttonpressed()) {
      level.dynamic_spawn_dummy_model hide();
      if(level.aitypes[level.aitype_index].isvehicle) {
        spawn = spawnvehicle(level.aitypes[level.aitype_index].classname, origin, angles, "");
      } else {
        spawn = spawnactor(level.aitypes[level.aitype_index].classname, origin, angles, "", 1);
      }
      spawn.ignoreme = getdvarstring("") == "";
      spawn.ignoreall = getdvarstring("") == "";
      spawn.pacifist = getdvarstring("") == "";
      spawn.fixednode = 0;
      wait(0.3);
    } else {
      if(self buttonpressed("")) {
        level.dynamic_spawn_dummy_model hide();
        level.aitype_index++;
        if(level.aitype_index >= level.aitypes.size) {
          level.aitype_index = 0;
        }
        wait(0.3);
      } else {
        if(self buttonpressed("")) {
          level.dynamic_spawn_dummy_model hide();
          level.aitype_index--;
          if(level.aitype_index < 0) {
            level.aitype_index = level.aitypes.size - 1;
          }
          wait(0.3);
        } else if(self buttonpressed("")) {
          setDvar("", "");
        }
      }
    }
    wait(0.05);
  }
}

function display_module_text() {
  wait(1);
  iprintlnbold(("" + level.script) + "");
}

function debug_goalradius() {
  guys = getaiarray();
  for(i = 0; i < guys.size; i++) {
    if(guys[i].team == "") {
      print3d(guys[i].origin + vectorscale((0, 0, 1), 70), (isDefined(guys[i].goalradius) ? "" + guys[i].goalradius : ""), (1, 0, 0), 1, 1, 1);
      record3dtext("" + guys[i].goalradius, guys[i].origin + vectorscale((0, 0, 1), 70), (1, 0, 0), "");
      continue;
    }
    print3d(guys[i].origin + vectorscale((0, 0, 1), 70), (isDefined(guys[i].goalradius) ? "" + guys[i].goalradius : ""), (0, 1, 0), 1, 1, 1);
    record3dtext("" + guys[i].goalradius, guys[i].origin + vectorscale((0, 0, 1), 70), (0, 1, 0), "");
  }
}

function debug_maxvisibledist() {
  guys = getaiarray();
  for(i = 0; i < guys.size; i++) {
    recordenttext((isDefined(guys[i].maxvisibledist) ? "" + guys[i].maxvisibledist : ""), guys[i], level.debugteamcolors[guys[i].team], "");
  }
  recordenttext((isDefined(level.player.maxvisibledist) ? "" + level.player.maxvisibledist : ""), level.player, level.debugteamcolors[""], "");
}

function debug_health() {
  v_print_pos = (0, 0, 0);
  guys = getaiarray();
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i] gettagorigin(""))) {
      v_print_pos = guys[i] gettagorigin("") + vectorscale((0, 0, 1), 15);
    } else {
      v_print_pos = guys[i] getorigin() + vectorscale((0, 0, 1), 70);
    }
    print3d(v_print_pos, (isDefined(guys[i].health) ? "" + guys[i].health : ""), level.debugteamcolors[guys[i].team], 1, 0.5);
    recordenttext((isDefined(guys[i].health) ? "" + guys[i].health : ""), guys[i], level.debugteamcolors[guys[i].team], "");
  }
  vehicles = getvehiclearray();
  for(i = 0; i < vehicles.size; i++) {
    recordenttext((isDefined(vehicles[i].health) ? "" + vehicles[i].health : ""), vehicles[i], level.debugteamcolors[vehicles[i].team], "");
  }
  if(isDefined(level.player)) {
    recordenttext((isDefined(level.player.health) ? "" + level.player.health : ""), level.player, level.debugteamcolors[""], "");
  }
}

function debug_engagedist() {
  guys = getaiarray();
  for(i = 0; i < guys.size; i++) {
    diststring = (((((guys[i].engageminfalloffdist + "") + guys[i].engagemindist) + "") + guys[i].engagemaxdist) + "") + guys[i].engagemaxfalloffdist;
    recordenttext(diststring, guys[i], level.debugteamcolors[guys[i].team], "");
  }
}

function debug_sphere(origin, radius, color, alpha, time) {
  if(!isDefined(time)) {
    time = 1000;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  sides = int(10 * (1 + (int(radius) % 100)));
  sphere(origin, radius, color, alpha, 1, sides, time);
}

function draw_arrow_time(start, end, color, frames) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = (start + (vectorscale(right, dist * 0.1))) + (vectorscale(forward, dist * -0.1));
  arrow[2] = end;
  arrow[3] = (start + (vectorscale(right, dist * -1 * 0.1))) + (vectorscale(forward, dist * -0.1));
  arrow[4] = start;
  arrow[5] = (start + (vectorscale(up, dist * 0.1))) + (vectorscale(forward, dist * -0.1));
  arrow[6] = end;
  arrow[7] = (start + (vectorscale(up, dist * -1 * 0.1))) + (vectorscale(forward, dist * -0.1));
  arrow[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(arrow, r, g, b, frames);
}

function draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = (start + (vectorscale(right, dist * 0.05))) + (vectorscale(forward, dist * -0.2));
  arrow[2] = end;
  arrow[3] = (start + (vectorscale(right, dist * -1 * 0.05))) + (vectorscale(forward, dist * -0.2));
  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;
    if(nextpoint >= 4) {
      nextpoint = 0;
    }
    line(arrow[p], arrow[nextpoint], color, 1);
  }
}

function debugorigin() {
  self notify("hash_707e044");
  self endon("hash_707e044");
  self endon("death");
  for(;;) {
    forward = anglesToForward(self.angles);
    forwardfar = vectorscale(forward, 30);
    forwardclose = vectorscale(forward, 20);
    right = anglestoright(self.angles);
    left = vectorscale(right, -10);
    right = vectorscale(right, 10);
    line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, (self.origin + forwardclose) + right, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, (self.origin + forwardclose) + left, (0.9, 0.7, 0.6), 0.9);
    wait(0.05);
  }
}

function plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isDefined(r)) {
    r = 1;
  }
  if(!isDefined(g)) {
    g = 1;
  }
  if(!isDefined(b)) {
    b = 1;
  }
  if(!isDefined(timer)) {
    timer = 0.05;
  }
  for(i = 1; i < plotpoints.size; i++) {
    thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
    lastpoint = plotpoints[i];
  }
}

function draw_line_for_time(org1, org2, r, g, b, timer) {
  timer = gettime() + (timer * 1000);
  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1);
    recordline(org1, org2, (1, 1, 1), "");
    wait(0.05);
  }
}

function _get_debug_color(str_color) {
  switch (str_color) {
    case "": {
      return (1, 0, 0);
      break;
    }
    case "": {
      return (0, 1, 0);
      break;
    }
    case "": {
      return (0, 0, 1);
      break;
    }
    case "": {
      return (1, 1, 0);
      break;
    }
    case "": {
      return (1, 0.5, 0);
      break;
    }
    case "": {
      return (0, 1, 1);
      break;
    }
    case "": {
      return (1, 1, 1);
      break;
    }
    case "": {
      return vectorscale((1, 1, 1), 0.75);
      break;
    }
    case "": {
      return (0, 0, 0);
      break;
    }
    default: {
      println(("" + str_color) + "");
      return (0, 0, 0);
      break;
    }
  }
}

function debug_info_screen(text_array, time, fade_in_bg_time, fade_out_bg_time, fade_in_text_time, fade_out_text_time, font_size, show_black_background) {
  if(!isDefined(time)) {
    time = 3;
  }
  if(!isDefined(fade_in_bg_time)) {
    fade_in_bg_time = 0;
  }
  if(!isDefined(fade_out_bg_time)) {
    fade_out_bg_time = 2;
  }
  if(!isDefined(fade_in_text_time)) {
    fade_in_text_time = 2;
  }
  if(!isDefined(fade_out_text_time)) {
    fade_out_text_time = 2;
  }
  if(!isDefined(font_size)) {
    font_size = 2;
  }
  if(!isDefined(show_black_background)) {
    show_black_background = 1;
  }
  if(show_black_background) {
    if(isPlayer(self)) {
      background = hud::createicon("", 640, 480);
    } else {
      background = hud::createservericon("", 640, 480);
    }
    background.horzalign = "";
    background.vertalign = "";
    background.foreground = 1;
    background.sort = 0;
    background.x = 320;
    background.y = 0;
    if(fade_in_bg_time > 0) {
      background.alpha = 0;
      background fadeovertime(fade_in_bg_time);
      background.alpha = 1;
      wait(fade_in_bg_time);
    } else {
      background.alpha = 1;
    }
  }
  text_elems = [];
  spacing = (int(level.fontheight * font_size)) + 2;
  start_y = 0;
  if(isarray(text_array)) {
    start_y = 0 - ((text_array.size * spacing) / 2);
    foreach(text in text_array) {
      if(isPlayer(self)) {
        text_elems[text_elems.size] = hud::createfontstring("", font_size);
      } else {
        text_elems[text_elems.size] = hud::createserverfontstring("", font_size);
      }
      text_elems[text_elems.size - 1] settext(text);
    }
  } else {
    if(isPlayer(self)) {
      text_elems[text_elems.size] = hud::createfontstring("", font_size);
    } else {
      text_elems[text_elems.size] = hud::createserverfontstring("", font_size);
    }
    text_elems[text_elems.size - 1] settext(text);
  }
  text_num = 0;
  foreach(text_elem in text_elems) {
    text_elem.horzalign = "";
    text_elem.vertalign = "";
    text_elem.x = 0;
    text_elem.y = start_y + (spacing * text_num);
    text_elem.color = (1, 1, 1);
    text_elem.foreground = 1;
    text_elem.sort = 1;
    if(fade_in_text_time > 0) {
      text_elem.alpha = 0;
      text_elem fadeovertime(fade_in_text_time);
      text_elem.alpha = 1;
    } else {
      text_elem.alpha = 1;
    }
    text_num++;
  }
  if(fade_in_text_time > 0) {
    wait(fade_in_text_time);
  }
  wait(time);
  if(fade_out_text_time > 0) {
    foreach(text_elem in text_elems) {
      text_elem fadeovertime(fade_out_text_time);
      text_elem.alpha = 0;
    }
    wait(fade_out_text_time);
  }
  if(show_black_background) {
    if(fade_out_bg_time > 0) {
      background fadeovertime(fade_out_bg_time);
      background.alpha = 0;
      wait(fade_out_bg_time);
    }
    background destroy();
  }
  foreach(text_elem in text_elems) {
    text_elem destroy();
  }
}