/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_clone.gsc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_oob;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai_puppeteer_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_clone;

function autoexec __init__sytem__() {
  system::register("gadget_clone", &__init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(42, &gadget_clone_on, &gadget_clone_off);
  ability_player::register_gadget_possession_callbacks(42, &gadget_clone_on_give, &gadget_clone_on_take);
  ability_player::register_gadget_flicker_callbacks(42, &gadget_clone_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(42, &gadget_clone_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(42, &gadget_clone_is_flickering);
  callback::on_connect(&gadget_clone_on_connect);
  clientfield::register("actor", "clone_activated", 1, 1, "int");
  clientfield::register("actor", "clone_damaged", 1, 1, "int");
  clientfield::register("allplayers", "clone_activated", 1, 1, "int");
  level._clone = [];
}

function gadget_clone_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_clone_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_clone_on_flicker(slot, weapon) {}

function gadget_clone_on_give(slot, weapon) {}

function gadget_clone_on_take(slot, weapon) {}

function gadget_clone_on_connect() {}

function killclones(player) {
  if(isDefined(player._clone)) {
    foreach(clone in player._clone) {
      if(isDefined(clone)) {
        clone notify("clone_shutdown");
      }
    }
  }
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
  testangles[1] = vectorscale((0, -1, 0), 30);
  testangles[2] = vectorscale((0, 1, 0), 30);
  testangles[3] = vectorscale((0, -1, 0), 60);
  testangles[4] = vectorscale((0, 1, 0), 60);
  testangles[5] = vectorscale((0, 1, 0), 90);
  testangles[6] = vectorscale((0, -1, 0), 90);
  testangles[7] = vectorscale((0, 1, 0), 120);
  testangles[8] = vectorscale((0, -1, 0), 120);
  testangles[9] = vectorscale((0, 1, 0), 150);
  testangles[10] = vectorscale((0, -1, 0), 150);
  testangles[11] = vectorscale((0, 1, 0), 180);
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
      startpoint = origin + (vectorscale(anglesToForward(startangles[i] + testangles[i]), clonedistance));
      startpoint = startpoint + (0, 0, zoff);
      if(playerpositionvalidignoreent(startpoint, self)) {
        closestnavmeshpoint = getclosestpointonnavmesh(startpoint, 500);
        if(isDefined(closestnavmeshpoint)) {
          startpoint = closestnavmeshpoint;
          trace = groundtrace(startpoint + (0, 0, 24), startpoint - (0, 0, 24), 0, 0, 0);
          if(isDefined(trace["position"])) {
            startpoint = trace["position"];
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
  insertedclone = 0;
  for(i = 0; i < 20; i++) {
    if(!isDefined(level._clone[i])) {
      level._clone[i] = clone;
      insertedclone = 1;
      println((("" + i) + "") + level._clone.size);
      break;
    }
  }
  assert(insertedclone);
}

function removeclone(clone) {
  for(i = 0; i < 20; i++) {
    if(isDefined(level._clone[i]) && level._clone[i] == clone) {
      level._clone[i] = undefined;
      array::remove_undefined(level._clone);
      println((("" + i) + "") + level._clone.size);
      break;
    }
  }
}

function removeoldestclone() {
  assert(level._clone.size == 20);
  oldestclone = undefined;
  for(i = 0; i < 20; i++) {
    if(!isDefined(oldestclone) && isDefined(level._clone[i])) {
      oldestclone = level._clone[i];
      oldestindex = i;
      continue;
    }
    if(isDefined(level._clone[i]) && level._clone[i].spawntime < oldestclone.spawntime) {
      oldestclone = level._clone[i];
      oldestindex = i;
    }
  }
  println((("" + i) + "") + level._clone.size);
  level._clone[oldestindex] notify("clone_shutdown");
  level._clone[oldestindex] = undefined;
  array::remove_undefined(level._clone);
}

function spawnclones() {
  self endon("death");
  self killclones(self);
  self._clone = [];
  velocity = self getvelocity();
  velocity = velocity + (0, 0, velocity[2] * -1);
  velocity = vectornormalize(velocity);
  origin = (self.origin + (velocity * 17)) + vectorscale(anglesToForward(self getangles()), 17);
  validspawns = calculatespawnorigin(origin, self getangles(), 60);
  if(validspawns.validpositions.size < 3) {
    validextendedspawns = calculatespawnorigin(origin, self getangles(), 180);
    for(index = 0; index < validextendedspawns.validpositions.size && validspawns.validpositions.size < 3; index++) {
      validspawns.validpositions[validspawns.validpositions.size] = validextendedspawns.validpositions[index];
      validspawns.validangles[validspawns.validangles.size] = validextendedspawns.validangles[index];
    }
  }
  for(i = 0; i < validspawns.validpositions.size; i++) {
    traveldistance = distance(validspawns.validpositions[i], self.origin);
    validspawns.spawntimes[i] = traveldistance / 800;
    self thread _cloneorbfx(validspawns.validpositions[i], validspawns.spawntimes[i]);
  }
  for(i = 0; i < validspawns.validpositions.size; i++) {
    if(level._clone.size < 20) {} else {
      removeoldestclone();
    }
    clone = spawnactor("spawner_bo3_human_male_reaper_mp", validspawns.validpositions[i], validspawns.validangles[i], "", 1);
    recordcircle(validspawns.validpositions[i], 2, (1, 0.5, 0), "", clone);
    _configureclone(clone, self, anglesToForward(validspawns.validangles[i]), validspawns.spawntimes[i]);
    self._clone[self._clone.size] = clone;
    insertclone(clone);
    wait(0.05);
  }
  self notify("reveal_clone");
  if(self oob::isoutofbounds()) {
    gadget_clone_off(self, undefined);
  }
}

function gadget_clone_on(slot, weapon) {
  self clientfield::set("clone_activated", 1);
  self flagsys::set("clone_activated");
  fx = playFX("player/fx_plyr_clone_reaper_appear", self.origin, anglesToForward(self getangles()));
  fx.team = self.team;
  thread spawnclones();
}

function private _updateclonepathing() {
  self endon("death");
  while(true) {
    if(getdvarint("tu1_gadgetCloneSwimming", 1)) {
      if((self.origin[2] + 36) <= getwaterheight(self.origin)) {
        blackboard::setblackboardattribute(self, "_stance", "swim");
        self setgoal(self.origin, 1);
        wait(0.5);
        continue;
      }
    }
    if(getdvarint("tu1_gadgetCloneCrouching", 1)) {
      if(!isDefined(self.lastknownpos)) {
        self.lastknownpos = self.origin;
        self.lastknownpostime = gettime();
      }
      if(distancesquared(self.lastknownpos, self.origin) < (24 * 24) && !self haspath()) {
        blackboard::setblackboardattribute(self, "_stance", "crouch");
        wait(0.5);
        continue;
      }
      if((self.lastknownpostime + 2000) <= gettime()) {
        self.lastknownpos = self.origin;
        self.lastknownpostime = gettime();
      }
    }
    distance = 0;
    if(isDefined(self._clone_goal)) {
      distance = distancesquared(self._clone_goal, self.origin);
    }
    if(distance < 14400 || !self haspath()) {
      forward = anglesToForward(self getangles());
      searchorigin = self.origin + (forward * 750);
      self._goal_center_point = searchorigin;
      queryresult = positionquery_source_navigation(self._goal_center_point, 500, 750, 750, 100, self);
      if(queryresult.data.size == 0) {
        queryresult = positionquery_source_navigation(self.origin, 500, 750, 750, 100, self);
      }
      if(queryresult.data.size > 0) {
        randindex = randomintrange(0, queryresult.data.size);
        self setgoalpos(queryresult.data[randindex].origin, 1);
        self._clone_goal = queryresult.data[randindex].origin;
        self._clone_goal_max_dist = 750;
      }
    }
    wait(0.5);
  }
}

function _cloneorbfx(endpos, traveltime) {
  spawnpos = self gettagorigin("j_spine4");
  fxorg = spawn("script_model", spawnpos);
  fxorg setModel("tag_origin");
  fx = playFXOnTag("player/fx_plyr_clone_reaper_orb", fxorg, "tag_origin");
  fx.team = self.team;
  fxendpos = endpos + (0, 0, 35);
  fxorg moveto(fxendpos, traveltime);
  self util::waittill_any_timeout(traveltime, "death", "disconnect");
  fxorg delete();
}

function private _clonecopyplayerlook(clone, player) {
  if(getdvarint("tu1_gadgetCloneCopyLook", 1)) {
    if(isPlayer(player) && isai(clone)) {
      bodymodel = player getcharacterbodymodel();
      if(isDefined(bodymodel)) {
        clone setModel(bodymodel);
      }
      headmodel = player getcharacterheadmodel();
      if(isDefined(headmodel)) {
        if(isDefined(clone.head)) {
          clone detach(clone.head);
        }
        clone attach(headmodel);
      }
      helmetmodel = player getcharacterhelmetmodel();
      if(isDefined(helmetmodel)) {
        clone attach(helmetmodel);
      }
    }
  }
}

function private _configureclone(clone, player, forward, spawntime) {
  clone.isaiclone = 1;
  clone.propername = "";
  clone.ignoretriggerdamage = 1;
  clone.minwalkdistance = 125;
  clone.overrideactordamage = &clonedamageoverride;
  clone.spawntime = gettime();
  clone setmaxhealth(int(1.5 * level.playermaxhealth));
  if(getdvarint("tu1_aiPathableMaterials", 0)) {
    if(isDefined(clone.pathablematerial)) {
      clone.pathablematerial = clone.pathablematerial &(~2);
    }
  }
  clone pushactors(1);
  clone pushplayer(1);
  clone setcontents(8192);
  clone setavoidancemask("avoid none");
  clone asmsetanimationrate(randomfloatrange(0.98, 1.02));
  clone setclone();
  clone _clonecopyplayerlook(clone, player);
  clone _cloneselectweapon(player);
  clone thread _clonewatchdeath();
  clone thread _clonewatchownerdisconnect(player);
  clone thread _clonewatchshutdown();
  clone thread _clonefakefire();
  clone thread _clonebreakglass();
  clone._goal_center_point = (forward * 1000) + clone.origin;
  clone._goal_center_point = getclosestpointonnavmesh(clone._goal_center_point, 600);
  queryresult = undefined;
  if(isDefined(clone._goal_center_point) && clone findpath(clone.origin, clone._goal_center_point, 1, 0)) {
    queryresult = positionquery_source_navigation(clone._goal_center_point, 0, 450, 450, 100, clone);
  } else {
    queryresult = positionquery_source_navigation(clone.origin, 500, 750, 750, 50, clone);
  }
  if(queryresult.data.size > 0) {
    clone setgoalpos(queryresult.data[0].origin, 1);
    clone._clone_goal = queryresult.data[0].origin;
    clone._clone_goal_max_dist = 450;
  } else {
    clone._goal_center_point = clone.origin;
  }
  clone thread _updateclonepathing();
  clone ghost();
  clone thread _show(spawntime);
  _configurecloneteam(clone, player, 0);
}

function private _playdematerialization() {
  if(isDefined(self)) {
    fx = playFX("player/fx_plyr_clone_vanish", self.origin);
    fx.team = self.team;
    playsoundatposition("mpl_clone_holo_death", self.origin);
  }
}

function private _clonewatchdeath() {
  self waittill("death");
  if(isDefined(self)) {
    self stoploopsound();
    self _playdematerialization();
    removeclone(self);
    self delete();
  }
}

function private _configurecloneteam(clone, player, ishacked) {
  if(ishacked == 0) {
    clone.originalteam = player.team;
  }
  clone.ignoreall = 1;
  clone.owner = player;
  clone setteam(player.team);
  clone.team = player.team;
  clone setentityowner(player);
}

function private _show(spawntime) {
  self endon("death");
  wait(spawntime);
  self show();
  self clientfield::set("clone_activated", 1);
  fx = playFX("player/fx_plyr_clone_reaper_appear", self.origin, anglesToForward(self getangles()));
  fx.team = self.team;
  self playLoopSound("mpl_clone_gadget_loop_npc");
}

function gadget_clone_off(slot, weapon) {
  self clientfield::set("clone_activated", 0);
  self flagsys::clear("clone_activated");
  self killclones(self);
  self _playdematerialization();
  if(isalive(self) && isDefined(level.playgadgetsuccess)) {
    self[[level.playgadgetsuccess]](weapon, "cloneSuccessDelay");
  }
}

function private _clonedamaged() {
  self endon("death");
  self clientfield::set("clone_damaged", 1);
  util::wait_network_frame();
  self clientfield::set("clone_damaged", 0);
}

function processclonescoreevent(clone, attacker, weapon) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(!level.teambased || clone.team != attacker.pers["team"]) {
      if(isDefined(clone.isaiclone) && clone.isaiclone) {
        scoreevents::processscoreevent("killed_clone_enemy", attacker, clone, weapon);
      }
    }
  }
}

function clonedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
  self thread _clonedamaged();
  if(weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
    processclonescoreevent(self, eattacker, weapon);
    self notify("clone_shutdown");
  }
  if(isDefined(level.weaponlightninggun) && weapon == level.weaponlightninggun) {
    processclonescoreevent(self, eattacker, weapon);
    self notify("clone_shutdown");
  }
  supplydrop = getweapon("supplydrop");
  if(isDefined(supplydrop) && supplydrop == weapon) {
    processclonescoreevent(self, eattacker, weapon);
    self notify("clone_shutdown");
  }
  return idamage;
}

function _clonewatchownerdisconnect(player) {
  clone = self;
  clone notify("watchcloneownerdisconnect");
  clone endon("watchcloneownerdisconnect");
  clone endon("clone_shutdown");
  player util::waittill_any("joined_team", "disconnect", "joined_spectators");
  if(isDefined(clone)) {
    clone notify("clone_shutdown");
  }
}

function _clonewatchshutdown() {
  clone = self;
  clone waittill("clone_shutdown");
  removeclone(clone);
  if(isDefined(clone)) {
    if(!level.gameended) {
      clone kill();
    } else {
      clone stoploopsound();
      self _playdematerialization();
      clone hide();
    }
  }
}

function _clonebreakglass() {
  clone = self;
  clone endon("clone_shutdown");
  clone endon("death");
  while(true) {
    clone util::break_glass();
    wait(0.25);
  }
}

function _clonefakefire() {
  clone = self;
  clone endon("clone_shutdown");
  clone endon("death");
  while(true) {
    waittime = randomfloatrange(0.5, 3);
    wait(waittime);
    shotsfired = randomintrange(1, 4);
    if(isDefined(clone.fakefireweapon) && clone.fakefireweapon != level.weaponnone) {
      players = getplayers();
      foreach(player in players) {
        if(isDefined(player) && isalive(player) && player getteam() != clone.team) {
          if(distancesquared(player.origin, clone.origin) < 562500) {
            if(clone cansee(player)) {
              clone fakefire(clone.owner, clone.origin, clone.fakefireweapon, shotsfired);
              break;
            }
          }
        }
      }
    }
    wait(shotsfired / 2);
    clone setfakefire(0);
  }
}

function _cloneselectweapon(player) {
  clone = self;
  items = _clonebuilditemlist(player);
  playerweapon = player getcurrentweapon();
  ball = getweapon("ball");
  if(isDefined(playerweapon) && isDefined(ball) && playerweapon == ball) {
    weapon = ball;
  } else {
    if(isDefined(playerweapon.worldmodel) && _testplayerweapon(playerweapon, items["primary"])) {
      weapon = playerweapon;
    } else {
      if(isDefined(level.var_7ce7fbed)) {
        weapon = [[level.var_7ce7fbed]](player);
      } else {
        weapon = undefined;
      }
      if(!isDefined(weapon)) {
        weapon = _chooseweapon(player);
      }
    }
  }
  if(isDefined(weapon)) {
    clone shared::placeweaponon(weapon, "right");
    clone.fakefireweapon = weapon;
  }
}

function _clonebuilditemlist(player) {
  pixbeginevent("clone_build_item_list");
  items = [];
  for(i = 0; i < 256; i++) {
    row = tablelookuprownum(level.statstableid, 0, i);
    if(row > -1) {
      slot = tablelookupcolumnforrow(level.statstableid, row, 13);
      if(slot == "") {
        continue;
      }
      number = int(tablelookupcolumnforrow(level.statstableid, row, 0));
      if(player isitemlocked(number)) {
        continue;
      }
      allocation = int(tablelookupcolumnforrow(level.statstableid, row, 12));
      if(allocation < 0) {
        continue;
      }
      name = tablelookupcolumnforrow(level.statstableid, row, 3);
      if(!isDefined(items[slot])) {
        items[slot] = [];
      }
      items[slot][items[slot].size] = name;
    }
  }
  pixendevent();
  return items;
}

function private _chooseweapon(player) {
  classnum = randomint(10);
  for(i = 0; i < 10; i++) {
    weapon = player getloadoutweapon((i + classnum) % 10, "primary");
    if(weapon != level.weaponnone) {
      break;
    }
  }
  return weapon;
}

function private _testplayerweapon(playerweapon, items) {
  if(!isDefined(items) || !items.size || !isDefined(playerweapon)) {
    return false;
  }
  for(i = 0; i < items.size; i++) {
    displayname = items[i];
    if(playerweapon.displayname == displayname) {
      return true;
    }
  }
  return false;
}