/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_perks.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace perks;

function autoexec __init__sytem__() {
  system::register("perks", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "flying", 1, 1, "int", & flying_callback, 0, 1);
  callback::on_localclient_connect( & on_local_client_connect);
  callback::on_localplayer_spawned( & on_localplayer_spawned);
  callback::on_spawned( & on_player_spawned);
  level.killtrackerfxenable = 1;
  level._monitor_tracker = & monitor_tracker_perk;
  level.sitrepscan1_enable = getdvarint("scr_sitrepscan1_enable", 2);
  level.sitrepscan1_setoutline = getdvarint("scr_sitrepscan1_setoutline", 1);
  level.sitrepscan1_setsolid = getdvarint("scr_sitrepscan1_setsolid", 1);
  level.sitrepscan1_setlinewidth = getdvarint("scr_sitrepscan1_setlinewidth", 1);
  level.sitrepscan1_setradius = getdvarint("scr_sitrepscan1_setradius", 50000);
  level.sitrepscan1_setfalloff = getdvarfloat("scr_sitrepscan1_setfalloff", 0.01);
  level.sitrepscan1_setdesat = getdvarfloat("scr_sitrepscan1_setdesat", 0.4);
  level.sitrepscan2_enable = getdvarint("scr_sitrepscan2_enable", 2);
  level.sitrepscan2_setoutline = getdvarint("scr_sitrepscan2_setoutline", 10);
  level.sitrepscan2_setsolid = getdvarint("scr_sitrepscan2_setsolid", 0);
  level.sitrepscan2_setlinewidth = getdvarint("scr_sitrepscan2_setlinewidth", 1);
  level.sitrepscan2_setradius = getdvarint("scr_sitrepscan2_setradius", 50000);
  level.sitrepscan2_setfalloff = getdvarfloat("scr_sitrepscan2_setfalloff", 0.01);
  level.sitrepscan2_setdesat = getdvarfloat("scr_sitrepscan2_setdesat", 0.4);
  level thread updatedvars();
}

function updatesitrepscan() {
  self endon("entityshutdown");
  while(true) {
    self oed_sitrepscan_enable(level.sitrepscan1_enable);
    self oed_sitrepscan_setoutline(level.sitrepscan1_setoutline);
    self oed_sitrepscan_setsolid(level.sitrepscan1_setsolid);
    self oed_sitrepscan_setlinewidth(level.sitrepscan1_setlinewidth);
    self oed_sitrepscan_setradius(level.sitrepscan1_setradius);
    self oed_sitrepscan_setfalloff(level.sitrepscan1_setfalloff);
    self oed_sitrepscan_setdesat(level.sitrepscan1_setdesat);
    self oed_sitrepscan_enable(level.sitrepscan2_enable, 1);
    self oed_sitrepscan_setoutline(level.sitrepscan2_setoutline, 1);
    self oed_sitrepscan_setsolid(level.sitrepscan2_setsolid, 1);
    self oed_sitrepscan_setlinewidth(level.sitrepscan2_setlinewidth, 1);
    self oed_sitrepscan_setradius(level.sitrepscan2_setradius, 1);
    self oed_sitrepscan_setfalloff(level.sitrepscan2_setfalloff, 1);
    self oed_sitrepscan_setdesat(level.sitrepscan2_setdesat, 1);
    wait(1);
  }
}

function updatedvars() {
  while(true) {
    level.sitrepscan1_enable = getdvarint("", level.sitrepscan1_enable);
    level.sitrepscan1_setoutline = getdvarint("", level.sitrepscan1_setoutline);
    level.sitrepscan1_setsolid = getdvarint("", level.sitrepscan1_setsolid);
    level.sitrepscan1_setlinewidth = getdvarint("", level.sitrepscan1_setlinewidth);
    level.sitrepscan1_setradius = getdvarint("", level.sitrepscan1_setradius);
    level.sitrepscan1_setfalloff = getdvarfloat("", level.sitrepscan1_setfalloff);
    level.sitrepscan1_setdesat = getdvarfloat("", level.sitrepscan1_setdesat);
    level.sitrepscan2_enable = getdvarint("", level.sitrepscan2_enable);
    level.sitrepscan2_setoutline = getdvarint("", level.sitrepscan2_setoutline);
    level.sitrepscan2_setsolid = getdvarint("", level.sitrepscan2_setsolid);
    level.sitrepscan2_setlinewidth = getdvarint("", level.sitrepscan2_setlinewidth);
    level.sitrepscan2_setradius = getdvarint("", level.sitrepscan2_setradius);
    level.sitrepscan2_setfalloff = getdvarfloat("", level.sitrepscan2_setfalloff);
    level.sitrepscan2_setdesat = getdvarfloat("", level.sitrepscan2_setdesat);
    level.friendlycontentoutlines = getdvarint("", level.friendlycontentoutlines);
    wait(1);
  }
}

function flying_callback(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.flying = newval;
}

function on_local_client_connect(local_client_num) {
  registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_l");
  registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_r");
  registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_l");
  registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_r");
  registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_lf");
  registerrewindfx(local_client_num, "player/fx_plyr_footstep_tracker_rf");
  registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_lf");
  registerrewindfx(local_client_num, "player/fx_plyr_flying_tracker_rf");
}

function on_localplayer_spawned(local_client_num) {
  if(self != getlocalplayer(local_client_num)) {
    return;
  }
  self thread monitor_tracker_perk_killcam(local_client_num);
  self thread monitor_detectnearbyenemies(local_client_num);
  self thread monitor_tracker_existing_players(local_client_num);
}

function on_player_spawned(local_client_num) {
  self thread watch_perks_change(local_client_num);
  self notify("perks_changed");
  self thread updatesitrepscan();
  self thread updatesitrepscan();
  self thread killtrackerfx_on_death(local_client_num);
  self thread monitor_tracker_perk(local_client_num);
}

function array_equal( & a, & b) {
  if(isDefined(a) && isDefined(b) && isarray(a) && isarray(b) && a.size == b.size) {
    for(i = 0; i < a.size; i++) {
      if(!a[i] === b[i]) {
        return false;
      }
    }
    return true;
  }
  return false;
}

function watch_perks_change(local_client_num) {
  self notify("watch_perks_change");
  self endon("entityshutdown");
  self endon("watch_perks_change");
  self endon("death");
  self endon("disconnect");
  self.last_perks = self getperks(local_client_num);
  while(isDefined(self)) {
    perks = self getperks(local_client_num);
    if(!array_equal(perks, self.last_perks)) {
      self.last_perks = perks;
      self notify("perks_changed");
    }
    wait(1);
  }
}

function get_players(local_client_num) {
  players = [];
  entities = getEntArray(local_client_num);
  if(isDefined(entities)) {
    foreach(ent in entities) {
      if(ent isplayer()) {
        players[players.size] = ent;
      }
    }
  }
  return players;
}

function monitor_tracker_existing_players(local_client_num) {
  self endon("death");
  self endon("monitor_tracker_existing_players");
  self notify("monitor_tracker_existing_players");
  players = getplayers(local_client_num);
  foreach(player in players) {
    if(isDefined(player) && player != self) {
      player thread monitor_tracker_perk(local_client_num);
    }
    wait(0.016);
  }
}

function monitor_tracker_perk_killcam(local_client_num) {
  self notify("monitor_tracker_perk_killcam" + local_client_num);
  self endon("monitor_tracker_perk_killcam" + local_client_num);
  self endon("entityshutdown");
  predictedlocalplayer = getlocalplayer(local_client_num);
  if(!isDefined(level.trackerspecialtyself)) {
    level.trackerspecialtyself = [];
    level.trackerspecialtycounter = 0;
  }
  if(!isDefined(level.trackerspecialtyself[local_client_num])) {
    level.trackerspecialtyself[local_client_num] = [];
  }
  if(predictedlocalplayer getinkillcam(local_client_num)) {
    nonpredictedlocalplayer = getnonpredictedlocalplayer(local_client_num);
    if(predictedlocalplayer hasperk(local_client_num, "specialty_tracker")) {
      servertime = getservertime(local_client_num);
      for(count = 0; count < level.trackerspecialtyself[local_client_num].size; count++) {
        if(level.trackerspecialtyself[local_client_num][count].time < servertime && level.trackerspecialtyself[local_client_num][count].time > (servertime - 5000)) {
          positionandrotationstruct = level.trackerspecialtyself[local_client_num][count];
          tracker_playFX(local_client_num, positionandrotationstruct);
        }
      }
    }
  } else {
    for(;;) {
      wait(0.05);
      positionandrotationstruct = self gettrackerfxposition(local_client_num);
      if(isDefined(positionandrotationstruct)) {
        positionandrotationstruct.time = getservertime(local_client_num);
        level.trackerspecialtyself[local_client_num][level.trackerspecialtycounter] = positionandrotationstruct;
        level.trackerspecialtycounter++;
        if(level.trackerspecialtycounter > 20) {
          level.trackerspecialtycounter = 0;
        }
      }
    }
  }
}

function monitor_tracker_perk(local_client_num) {
  self notify("monitor_tracker_perk");
  self endon("monitor_tracker_perk");
  self endon("death");
  self endon("disconnect");
  self endon("entityshutdown");
  self.flying = 0;
  self.tracker_flying = 0;
  self.tracker_last_pos = self.origin;
  offset = (0, 0, getdvarfloat("perk_tracker_fx_foot_height", 0));
  dist2 = 1024;
  while(isDefined(self)) {
    wait(0.05);
    watcher = getlocalplayer(local_client_num);
    if(!isDefined(watcher) || self == watcher) {
      return;
    }
    if(isDefined(watcher) && watcher hasperk(local_client_num, "specialty_tracker")) {
      friend = self isfriendly(local_client_num, 1);
      camooff = 1;
      if(!isDefined(self._isclone) || !self._isclone) {
        camo_val = self clientfield::get("camo_shader");
        if(camo_val != 0) {
          camooff = 0;
        }
      }
      if(!friend && isalive(self) && camooff) {
        positionandrotationstruct = self gettrackerfxposition(local_client_num);
        if(isDefined(positionandrotationstruct)) {
          self tracker_playFX(local_client_num, positionandrotationstruct);
        }
      } else {
        self.tracker_flying = 0;
      }
    }
  }
}

function tracker_playFX(local_client_num, positionandrotationstruct) {
  handle = playFX(local_client_num, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
  self killtrackerfx_track(local_client_num, handle);
}

function killtrackerfx_track(local_client_num, handle) {
  if(handle && isDefined(self.killtrackerfx)) {
    servertime = getservertime(local_client_num);
    killfxstruct = spawnStruct();
    killfxstruct.time = servertime;
    killfxstruct.handle = handle;
    index = self.killtrackerfx.index;
    if(index >= 40) {
      index = 0;
    }
    self.killtrackerfx.array[index] = killfxstruct;
    self.killtrackerfx.index = index + 1;
  }
}

function killtrackerfx_on_death(local_client_num) {
  self endon("disconnect");
  if(!(isDefined(level.killtrackerfxenable) && level.killtrackerfxenable)) {
    return;
  }
  predictedlocalplayer = getlocalplayer(local_client_num);
  if(predictedlocalplayer == self) {
    return;
  }
  if(isDefined(self.killtrackerfx)) {
    self.killtrackerfx.array = [];
    self.killtrackerfx.index = 0;
    self.killtrackerfx = undefined;
  }
  killtrackerfx = spawnStruct();
  killtrackerfx.array = [];
  killtrackerfx.index = 0;
  self.killtrackerfx = killtrackerfx;
  self waittill("entityshutdown");
  servertime = getservertime(local_client_num);
  foreach(killfxstruct in killtrackerfx.array) {
    if(isDefined(killfxstruct) && (killfxstruct.time + 5000) > servertime) {
      killfx(local_client_num, killfxstruct.handle);
    }
  }
  killtrackerfx.array = [];
  killtrackerfx.index = 0;
  killtrackerfx = undefined;
}

function gettrackerfxposition(local_client_num) {
  positionandrotation = undefined;
  player = self;
  if(isDefined(self._isclone) && self._isclone) {
    player = self.owner;
  }
  playfastfx = player hasperk(local_client_num, "specialty_trackerjammer");
  if(isDefined(self.flying) && self.flying) {
    offset = (0, 0, getdvarfloat("perk_tracker_fx_fly_height", 0));
    dist2 = 1024;
    if(isDefined(self.trailrightfoot) && self.trailrightfoot) {
      if(playfastfx) {
        fx = "player/fx_plyr_flying_tracker_rf";
      } else {
        fx = "player/fx_plyr_flying_tracker_r";
      }
    } else {
      if(playfastfx) {
        fx = "player/fx_plyr_flying_tracker_lf";
      } else {
        fx = "player/fx_plyr_flying_tracker_l";
      }
    }
  } else {
    offset = (0, 0, getdvarfloat("perk_tracker_fx_foot_height", 0));
    dist2 = 1024;
    if(isDefined(self.trailrightfoot) && self.trailrightfoot) {
      if(playfastfx) {
        fx = "player/fx_plyr_footstep_tracker_rf";
      } else {
        fx = "player/fx_plyr_footstep_tracker_r";
      }
    } else {
      if(playfastfx) {
        fx = "player/fx_plyr_footstep_tracker_lf";
      } else {
        fx = "player/fx_plyr_footstep_tracker_l";
      }
    }
  }
  pos = self.origin + offset;
  fwd = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  up = anglestoup(self.angles);
  vel = self getvelocity();
  if(lengthsquared(vel) > 1) {
    up = vectorcross(vel, right);
    if(lengthsquared(up) < 0.0001) {
      up = vectorcross(fwd, vel);
    }
    fwd = vel;
  }
  if(self isplayer() && self isplayerwallrunning()) {
    if(self isplayerwallrunningright()) {
      up = vectorcross(up, fwd);
    } else {
      up = vectorcross(fwd, up);
    }
  }
  if(!self.tracker_flying) {
    self.tracker_flying = 1;
    self.tracker_last_pos = self.origin;
  } else if(distancesquared(self.tracker_last_pos, pos) > dist2) {
    positionandrotation = spawnStruct();
    positionandrotation.fx = fx;
    positionandrotation.pos = pos;
    positionandrotation.fwd = fwd;
    positionandrotation.up = up;
    self.tracker_last_pos = self.origin;
    if(isDefined(self.trailrightfoot) && self.trailrightfoot) {
      self.trailrightfoot = 0;
    } else {
      self.trailrightfoot = 1;
    }
  }
  return positionandrotation;
}

function monitor_detectnearbyenemies(local_client_num) {
  self endon("entityshutdown");
  controllermodel = getuimodelforcontroller(local_client_num);
  sixthsensemodel = createuimodel(controllermodel, "hudItems.sixthsense");
  enemynearbytime = 0;
  enemylosttime = 0;
  previousenemydetectedbitfield = 0;
  setuimodelvalue(sixthsensemodel, 0);
  while(true) {
    localplayer = getlocalplayer(local_client_num);
    if(!localplayer isplayer() || localplayer hasperk(local_client_num, "specialty_detectnearbyenemies") == 0 || (localplayer getinkillcam(local_client_num) == 1 || isalive(localplayer) == 0)) {
      setuimodelvalue(sixthsensemodel, 0);
      previousenemydetectedbitfield = 0;
      self util::waittill_any("death", "spawned", "perks_changed");
      continue;
    }
    enemynearbyfront = 0;
    enemynearbyback = 0;
    enemynearbyleft = 0;
    enemynearbyright = 0;
    enemydetectedbitfield = 0;
    team = localplayer.team;
    innerdetect = getdvarint("specialty_detectnearbyenemies_inner", 1);
    outerdetect = getdvarint("specialty_detectnearbyenemies_outer", 1);
    zdetect = getdvarint("specialty_detectnearbyenemies_zthreshold", 1);
    localplayeranglestoforward = anglesToForward(localplayer.angles);
    players = getplayers(local_client_num);
    clones = getclones(local_client_num);
    sixthsenseents = arraycombine(players, clones, 0, 0);
    foreach(sixthsenseent in sixthsenseents) {
      if(sixthsenseent isfriendly(local_client_num, 1) || sixthsenseent == localplayer) {
        continue;
      }
      if(!isalive(sixthsenseent)) {
        continue;
      }
      distancescalarsq = 1;
      zscalarsq = 1;
      player = sixthsenseent;
      if(isDefined(sixthsenseent._isclone) && sixthsenseent._isclone) {
        player = sixthsenseent.owner;
      }
      if(player isplayer() && player hasperk(local_client_num, "specialty_sixthsensejammer")) {
        distancescalarsq = getdvarfloat("specialty_sixthsensejammer_distance_scalar", 0.01);
        zscalarsq = getdvarfloat("specialty_sixthsensejammer_z_scalar", 0.01);
      }
      if(previousenemydetectedbitfield == 0) {
        distancesq = 90000 * distancescalarsq;
      } else {
        distancesq = 122500 * distancescalarsq;
      }
      distcurrentsq = distancesquared(sixthsenseent.origin, localplayer.origin);
      zdistcurrent = sixthsenseent.origin[2] - localplayer.origin[2];
      zdistcurrentsq = zdistcurrent * zdistcurrent;
      if(distcurrentsq < distancesq) {
        distancemask = 1;
        if(previousenemydetectedbitfield > 16) {
          znearbycheck = 122500 * zscalarsq;
        } else {
          znearbycheck = 2500 * zscalarsq;
        }
        if(zdistcurrentsq < znearbycheck && zdetect) {
          distancemask = 16;
        }
        vector = sixthsenseent.origin - localplayer.origin;
        vector = (vector[0], vector[1], 0);
        vectorflat = vectornormalize(vector);
        cosangle = vectordot(vectorflat, localplayeranglestoforward);
        if(cosangle > 0.7071) {
          enemydetectedbitfield = enemydetectedbitfield | (1 * distancemask);
          continue;
        }
        if(cosangle < -0.7071) {
          enemydetectedbitfield = enemydetectedbitfield | (2 * distancemask);
          continue;
        }
        localplayeranglestoright = anglestoright(localplayer.angles);
        cosangle = vectordot(vectorflat, localplayeranglestoright);
        if(cosangle < 0) {
          enemydetectedbitfield = enemydetectedbitfield | (4 * distancemask);
          continue;
        }
        enemydetectedbitfield = enemydetectedbitfield | (8 * distancemask);
      }
    }
    if(enemydetectedbitfield) {
      enemylosttime = 0;
      if(previousenemydetectedbitfield != enemydetectedbitfield && enemynearbytime >= 0.05) {
        setuimodelvalue(sixthsensemodel, enemydetectedbitfield);
        enemynearbytime = 0;
        diff = enemydetectedbitfield ^ previousenemydetectedbitfield;
        if(diff & enemydetectedbitfield) {
          self playSound(0, "uin_sixth_sense_ping_on");
        }
        previousenemydetectedbitfield = enemydetectedbitfield;
      }
      enemynearbytime = enemynearbytime + 0.05;
    } else {
      enemynearbytime = 0;
      if(previousenemydetectedbitfield != 0 && enemylosttime >= 0.05) {
        setuimodelvalue(sixthsensemodel, 0);
        previousenemydetectedbitfield = 0;
      }
      enemylosttime = enemylosttime + 0.05;
    }
    wait(0.05);
  }
  setuimodelvalue(sixthsensemodel, 0);
}