/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2dc29943582f8278.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c052d834cd7619a;
#using script_350cffecd05ef6cf;
#using script_3d173c89c2828216;
#using script_3d5e6c007c0e2bb1;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_717759a5d2a40e63;
#using script_74a56359b7d02ab6;
#using script_76983b49bef66b2e;
#using script_abb3791af68bace;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace namespace_5d515bd5;

function init() {
  clientfield::register("actor", "clone_activated", 1, 1, "int");
  clientfield::register("actor", "clone_damaged", 1, 1, "int");
  clientfield::register("allplayers", "clone_activated", 1, 1, "int");
  level.doa.clones = [];
}

function function_60c2247c() {
  self notify("7e7583031d63abc7");
  self endon("7e7583031d63abc7");
  self endon(#"disconnect");
  self clientfield::set("clone_activated", 1);
  self flag::set(#"clone_activated");
  self namespace_83eb6304::function_3ecfde67("clone_appear");
  self thread spawnclones();
  timeout = self namespace_1c2a96f9::function_4808b985(25);
  level waittilltimeout(timeout, #"doa_exit_taken");
  self clientfield::set("clone_activated", 0);
  self flag::clear(#"clone_activated");
  self killclones(self);
  self _playdematerialization();
}

function killclones(player) {
  if(isDefined(player.doa.clones)) {
    foreach(clone in player.doa.clones) {
      if(isDefined(clone)) {
        clone notify(#"clone_shutdown");
      }
    }
  }

  player.doa.clones = [];
}

function is_jumping() {
  ground_ent = self getgroundent();
  return !isDefined(ground_ent);
}

function calculatespawnorigin(origin, angles, clonedistance) {
  player = self;
  startangles = [];
  testangles = [];
  testangles[0] = (0, 0, 0);
  testangles[1] = (0, -30, 0);
  testangles[2] = (0, 30, 0);
  testangles[3] = (0, -60, 0);
  testangles[4] = (0, 60, 0);
  testangles[5] = (0, 90, 0);
  testangles[6] = (0, -90, 0);
  testangles[7] = (0, 120, 0);
  testangles[8] = (0, -120, 0);
  testangles[9] = (0, 150, 0);
  testangles[10] = (0, -150, 0);
  testangles[11] = (0, 180, 0);
  validspawns = spawnStruct();
  validpositions = [];
  validangles = [];
  zoffests = [];
  zoffests[0] = 5;
  zoffests[1] = 0;

  if(player is_jumping()) {
    zoffests[2] = -5;
  }

  foreach(zoff in zoffests) {
    for(i = 0; i < testangles.size; i++) {
      startangles[i] = (0, angles[1], 0);
      startpoint = origin + vectorscale(anglesToForward(startangles[i] + testangles[i]), clonedistance);
      startpoint += (0, 0, zoff);

      if(playerpositionvalidignoreent(startpoint, self)) {
        closestnavmeshpoint = getclosestpointonnavmesh(startpoint, 500);

        if(isDefined(closestnavmeshpoint)) {
          startpoint = closestnavmeshpoint;
          trace = groundtrace(startpoint + (0, 0, 24), startpoint - (0, 0, 24), 0, 0, 0);

          if(isDefined(trace[# "position"])) {
            startpoint = trace[# "position"];
          }
        }

        validpositions[validpositions.size] = startpoint;
        validangles[validangles.size] = startangles[i] + testangles[i];

        if(validangles.size == 3) {
          break;
        }
      }
    }

    if(validangles.size == 3) {
      break;
    }
  }

  validspawns.validpositions = validpositions;
  validspawns.validangles = validangles;
  return validspawns;
}

function insertclone(clone) {
  if(!isDefined(self.doa.clones)) {
    self.doa.clones = [];
  }

  if(isDefined(self) && isPlayer(self)) {
    self.doa.clones[self.doa.clones.size] = clone;
  }

  insertedclone = 0;

  for(i = 0; i < 12; i++) {
    if(!isDefined(level.doa.clones[i])) {
      level.doa.clones[i] = clone;
      insertedclone = 1;

      namespace_1e25ad94::debugmsg("<dev string:x38>" + i + "<dev string:x4f>" + level.doa.clones.size);

      break;
    }
  }

  assert(insertedclone);
}

function removeclone(clone) {
  for(i = 0; i < 12; i++) {
    if(isDefined(level.doa.clones[i]) && level.doa.clones[i] == clone) {
      level.doa.clones[i] = undefined;
      arrayremovevalue(level.doa.clones, undefined);

      namespace_1e25ad94::debugmsg("<dev string:x64>" + i + "<dev string:x4f>" + level.doa.clones.size);

      break;
    }
  }
}

function removeoldestclone() {
  assert(level.doa.clones.size == 12);
  oldestclone = undefined;

  for(i = 0; i < 12; i++) {
    if(!isDefined(oldestclone) && isDefined(level.doa.clones[i])) {
      oldestclone = level.doa.clones[i];
      oldestindex = i;
      continue;
    }

    if(isDefined(level.doa.clones[i]) && level.doa.clones[i].spawntime < oldestclone.spawntime) {
      oldestclone = level.doa.clones[i];
      oldestindex = i;
    }
  }

  namespace_1e25ad94::debugmsg("<dev string:x80>" + i + "<dev string:x4f>" + level.doa.clones.size);

  level.doa.clones[oldestindex] notify(#"clone_shutdown");
  level.doa.clones[oldestindex] = undefined;
  arrayremovevalue(level.doa.clones, undefined);
}

function function_cb30c0aa() {
  while(level.doa.clones.size >= 12) {
    removeoldestclone();
  }
}

function spawnclones() {
  self endon(#"disconnect", #"player_died");
  self killclones(self);
  timeout = self namespace_1c2a96f9::function_4808b985(25);
  velocity = self getvelocity();
  velocity += (0, 0, velocity[2] * -1);
  velocity = vectornormalize(velocity);
  origin = self.origin + velocity * 17 + vectorscale(anglesToForward(self getangles()), 17);
  validspawns = calculatespawnorigin(origin, self getangles(), 300);

  if(validspawns.validpositions.size < 3) {
    validextendedspawns = calculatespawnorigin(origin, self getangles(), 900);

    for(index = 0; index < validextendedspawns.validpositions.size && validspawns.validpositions.size < 3; index++) {
      validspawns.validpositions[validspawns.validpositions.size] = validextendedspawns.validpositions[index];
      validspawns.validangles[validspawns.validangles.size] = validextendedspawns.validangles[index];
    }
  }

  for(i = 0; i < validspawns.validpositions.size; i++) {
    traveldistance = distance(validspawns.validpositions[i], self.origin);
    validspawns.spawntimes[i] = traveldistance / 200;
    self thread _cloneorbfx(validspawns.validpositions[i], validspawns.spawntimes[i]);
  }

  for(i = 0; i < validspawns.validpositions.size; i++) {
    function_cb30c0aa();
    clone = spawnactor("spawner_zombietron_hat_clone", validspawns.validpositions[i], validspawns.validangles[i], "", 1);

    if(!isDefined(clone)) {
      continue;
    }

    clone thread namespace_ec06fe4a::function_203591b7(self, "disconnect", "clone_shutdown");
    clone thread namespace_ec06fe4a::function_203591b7(level, "arena_completed", "clone_shutdown");
    clone thread namespace_ec06fe4a::function_203591b7(level, "game_over", "clone_shutdown");
    clone thread namespace_ec06fe4a::function_52afe5df(timeout + 2);
    clone.team = self.team;
    clone.var_c497caa3 = 1;
    function_241f12a1(clone, self);
    clone pathmode("move delayed", 1, validspawns.spawntimes[i]);
    clone.var_539ad42b = 1;
    clone.doa = spawnStruct();
    clone.doa.var_484cc88b = 0;
    self thread _configureclone(clone, self, anglesToForward(validspawns.validangles[i]), validspawns.spawntimes[i]);
    self insertclone(clone);
    waitframe(1);
  }
}

function private _updateclonepathing(player) {
  self endon(#"death");
  var_81ef612a = self.origin;
  self.lastknownpos = self.origin;
  self.lastknownpostime = gettime();

  while(true) {
    if(self.origin[2] + 36 <= getwaterheight(self.origin)) {
      self setblackboardattribute("_stance", "swim");
      self setgoal(var_81ef612a, 1);
      wait 1;
      continue;
    } else {
      self setblackboardattribute("_stance", "stand");
    }

    if(distancesquared(self.lastknownpos, self.origin) < sqr(24) && !self haspath()) {
      self setblackboardattribute("_stance", "crouch");
      wait 0.5;
      continue;
    }

    if(self.lastknownpostime + 2000 <= gettime()) {
      self.lastknownpos = self.origin;
      self.lastknownpostime = gettime();
    }

    if(isDefined(player)) {
      self.var_ef51fb4c = player.origin;
    }

    distance = 0;

    if(isDefined(self.var_ef51fb4c)) {
      distance = distancesquared(self.var_ef51fb4c, self.origin);
    }

    if(distance > sqr(120) || !self haspath()) {
      if(isDefined(player)) {
        forward = anglesToForward(player getangles());
      } else {
        forward = anglesToForward(self getangles());
      }

      searchorigin = self.origin + forward * 256;
      self._goal_center_point = searchorigin;
      queryresult = positionquery_source_navigation(self._goal_center_point, 128, 256, 256, 100, self);

      if(queryresult.data.size == 0) {
        queryresult = positionquery_source_navigation(self.origin, 128, 256, 256, 100, self);
      }

      if(queryresult.data.size > 0) {
        randindex = randomintrange(0, queryresult.data.size);
        self setgoal(queryresult.data[randindex].origin, 1);
        self.var_ef51fb4c = queryresult.data[randindex].origin;
        self.var_49e3c1d3 = 256;
      }
    }

    wait 1.5;
  }
}

function _cloneorbfx(endpos, traveltime) {
  spawnpos = self gettagorigin("j_spine4");

  if(!isDefined(spawnpos)) {
    return;
  }

  fxorg = namespace_ec06fe4a::spawnmodel(spawnpos, "tag_origin");

  if(!isDefined(fxorg)) {
    return;
  }

  fxorg namespace_83eb6304::function_3ecfde67("clone_orb");
  fxendpos = endpos + (0, 0, 35);
  fxorg moveto(fxendpos, traveltime);
  self waittilltimeout(traveltime, #"player_died", #"disconnect");

  if(isDefined(self)) {
    self notify(#"hash_5f82250ecd4b484c");
  }

  fxorg delete();
}

function function_241f12a1(clone, player) {
  clone namespace_7f5aeb59::function_12bdee53(clone, player);
  clone namespace_7f5aeb59::function_31df67c1(player);
}

function private _configureclone(clone, player, forward, spawntime) {
  player endon(#"disconnect");
  clone.isaiclone = 1;
  clone.ignoretriggerdamage = 1;
  clone.minwalkdistance = 125;
  clone.overrideactordamage = &clonedamageoverride;
  clone.spawntime = gettime();
  clone setmaxhealth(600);

  if(isDefined(clone.pathablematerial)) {
    clone.pathablematerial &= ~2;
  }

  clone collidewithactors(1);
  clone pushplayer(1);
  clone setcontents(8192);
  clone setavoidancemask("avoid none");
  clone asmsetanimationrate(randomfloatrange(0.98, 1.02));
  clone setclone();
  clone thread _clonewatchownerdisconnect(player);
  clone thread _clonewatchshutdown();
  clone._goal_center_point = forward * 1000 + clone.origin;
  clone._goal_center_point = getclosestpointonnavmesh(clone._goal_center_point, 600);
  queryresult = undefined;

  if(isDefined(clone._goal_center_point) && clone findpath(clone.origin, clone._goal_center_point, 1, 0)) {
    queryresult = positionquery_source_navigation(clone._goal_center_point, 0, 450, 450, 100, clone);
  } else {
    queryresult = positionquery_source_navigation(clone.origin, 128, 256, 256, 50, clone);
  }

  if(queryresult.data.size > 0) {
    clone setgoal(queryresult.data[0].origin, 1);
    clone.var_ef51fb4c = queryresult.data[0].origin;
    clone.var_49e3c1d3 = 450;
  } else {
    clone._goal_center_point = clone.origin;
  }

  clone namespace_ec06fe4a::function_8c808737();
  clone thread _show(spawntime, player);
  result = clone waittilltimeout(spawntime + 0.5, #"clone_reveal", #"clone_shutdown", #"death");

  if(result._notify != # "clone_shutdown") {
    _configurecloneteam(clone, player, 0);
    clone thread _updateclonepathing(player);
  }
}

function private _playdematerialization() {
  if(isDefined(self)) {
    self namespace_83eb6304::function_3ecfde67("clone_vanish");
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_magichat_clone_disappear");
  }
}

function function_e04252ed(player, ishacked = 0) {
  _configurecloneteam(self, player, ishacked);
}

function private _configurecloneteam(clone, player, ishacked) {
  if(!isDefined(clone) || !isDefined(player)) {
    return;
  }

  if(ishacked == 0) {
    clone.originalteam = player.team;
  }

  clone val::set(#"clone_team", "ignoreall", 1);
  clone.owner = player;
  clone setteam(player.team);
  clone.team = player.team;
  clone setentityowner(player);
}

function private _show(spawntime, player) {
  self endon(#"death", #"clone_shutdown");
  wait spawntime;
  self namespace_ec06fe4a::function_4f72130c();
  roll = randomint(6);

  switch (roll) {
    case 0:
      self thread namespace_dcd37093::function_d28e9b17();
      break;
    case 1:
      level thread namespace_7da86f3c::function_eeb092f5(self);
      break;
    case 2:
      self thread namespace_5f74ac47::function_f44fbe7c();
      break;
    case 3:
      self thread namespace_9038b9d9::function_6ec0595a();
      break;
    case 4:
      self thread namespace_bf41daf8::barrelupdate();
      break;
    case 5:
      self thread namespace_52ba5a8a::sawbladeupdate();
      break;
  }

  if(self.var_539ad42b === 1) {
    self clientfield::set("clone_activated", 1);
  }

  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_magichat_clone_appear");
  self namespace_83eb6304::function_3ecfde67("clone_appear");

  if(isDefined(player)) {
    self.color = player.doa.color;
    self namespace_83eb6304::function_3ecfde67("player_trail_" + self.color);
  }

  self notify(#"clone_reveal");
}

function function_504b77c8() {
  self endon(#"death");
  self clientfield::set("clone_damaged", 1);
  util::wait_network_frame();
  self clientfield::set("clone_damaged", 0);
  self notify(#"clone_shutdown");
}

function clonedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
  if(isDefined(surfacenormal) && surfacenormal.team !== self.team) {
    self thread function_504b77c8();
  }

  return false;
}

function _clonewatchownerdisconnect(player) {
  self notify("10138ae7d107b523");
  self endon("10138ae7d107b523");
  clone = self;
  clone endon(#"clone_shutdown");
  player waittill(#"disconnect");

  if(isDefined(clone)) {
    clone notify(#"clone_shutdown");
  }
}

function _clonewatchshutdown() {
  clone = self;
  clone waittill(#"clone_shutdown", #"death");
  clone notify(#"hash_1e2c098e8231a30f");
  clone notify(#"barrels_done");
  clone notify(#"blades_done");
  clone notify(#"hash_1c99dfc5992f1a01");

  if(isDefined(clone)) {
    if(isDefined(clone.color)) {
      clone namespace_83eb6304::turnofffx("player_trail_" + clone.color);
    }

    clone _playdematerialization();
    removeclone(clone);
    util::wait_network_frame();

    if(isDefined(clone)) {
      clone delete();
    }
  }
}