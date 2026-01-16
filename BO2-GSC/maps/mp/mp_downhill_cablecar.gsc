/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_downhill_cablecar.gsc
********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\killstreaks\_airsupport;
#include maps\mp\_events;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\_tacticalinsertion;
#include maps\mp\killstreaks\_rcbomb;
#include maps\mp\gametypes\_weaponobjects;
#include maps\mp\gametypes\ctf;
#include maps\mp\gametypes\_gameobjects;
#include maps\mp\killstreaks\_supplydrop;

main() {
  level.cablecartrack = [];
  level.trackdistancestops = [];
  level.distancetofirstrotate = 0;
  precacheitem("gondola_mp");
  level.gondolasounds = [];
  level.gondolasounds["tower_start"] = "veh_cable_car_roller_cross";
  level.gondolasounds["rollers_start"] = "veh_cable_car_start";
  level.gondolasounds["slow_down"] = "veh_cable_car_stop";
  level.gondolaloopsounds = [];
  level.gondolaloopsounds["start"] = "veh_cable_car_move_loop";
  level.gondolaloopsounds["rollers_start"] = "veh_cable_car_move_loop";
  level.gondolaloopsounds["rollers_end"] = "";
  tracklength = createcablecarpath();
  assert(level.trackdistancestops.size == 2);

  if(level.trackdistancestops.size == 2) {
    velocity = getdvarfloatdefault("scr_cable_car_velocity", 100);
    bottomoftracklength = level.trackdistancestops[1] - level.trackdistancestops[0];
    topoftracklength = tracklength - bottomoftracklength;
    assert(topoftracklength < bottomoftracklength);
    extratrackrequired = bottomoftracklength - topoftracklength;
    extratimerequired = extratrackrequired / velocity;
    level.cablecartrack[level.cablecartrack.size - 1].movetime = extratimerequired;
    level.cablecartrack[level.cablecartrack.size - 1].rotate = 1;
    tracklength = bottomoftracklength * 2;
  } else
    return;

  cablecars = getentarray("cablecar", "targetname");
  cablecarkilltrigger = getentarray("cable_car_kill_trigger", "targetname");
  assert(isDefined(cablecars));
  assert(isDefined(cablecarkilltrigger));
  level.cablecardefaultangle = cablecars[0].angles;
  distancebetweencars = tracklength / cablecars.size;

  if(getgametypesetting("allowMapScripting"))
    currentdistanceforcar = 0;
  else
    currentdistanceforcar = distancebetweencars * 0.8;

  for(i = 0; i < cablecars.size; i++) {
    cablecar = cablecars[i];
    cablecar thread waitthenplayfx(0.1, level.cablecarlightsfx, "tag_origin");
    cablecar.killtrigger = getclosest(cablecar.origin, cablecarkilltrigger);
    assert(isDefined(cablecar.killtrigger));
    cablecar.killtrigger enablelinkto();
    cablecar.killtrigger linkto(cablecar);
    cablecar setpointontrack(currentdistanceforcar, tracklength);
    currentdistanceforcar = currentdistanceforcar + distancebetweencars;

    debug_star(cablecar.origin, 120000, (1, 0, 1));

    grip = spawn("script_model", cablecar.origin);

    if(cablecar.nextnodeindex >= level.cablecartrack.size - 1)
      grip.angles = vectortoangles(level.cablecartrack[cablecar.nextnodeindex - 1].origin - level.cablecartrack[cablecar.nextnodeindex].origin);
    else {
      if(is_true(level.cablecartrack[cablecar.nextnodeindex].pause))
        carnode = level.cablecartrack[cablecar.nextnodeindex + 2];
      else
        carnode = level.cablecartrack[cablecar.nextnodeindex];

      grip.angles = vectortoangles(carnode.origin - cablecar.origin);
    }

    grip.origin = grip.origin - (0, cos(grip.angles[1]) * -12, 8);
    grip setmodel("dh_cable_car_top_piece");
    cablecar.grip = grip;

    if(getgametypesetting("allowMapScripting")) {
      level thread cablecarrun(cablecar);
      continue;
    }

    cablecar.origin = cablecar.origin + (0, cos(cablecar.angles[1]) * -15, -66.6);
    cablecar disconnectpaths();
  }
}

waitthenplayfx(time, fxnum, tag) {
  self endon("death");
  wait(time);

  for(;;) {
    playfxontag(fxnum, self, tag);
    level waittill("host_migration_end");
  }
}

setpointontrack(distancealongtrack, tracklength) {
  pointontrack = level.cablecartrack[0].origin;

  while(distancealongtrack > tracklength)
    distancealongtrack = tracklength * -1;

  remainingdistance = distancealongtrack;

  for(i = 0; i < level.cablecartrack.size; i++) {
    cablecartracknode = level.cablecartrack[i];
    currentnodeisstop = is_true(cablecartracknode.pause);

    if(currentnodeisstop) {
      velocity = getdvarfloatdefault("scr_cable_car_velocity", 100);
      remainingdistance = remainingdistance - 3 * velocity;

      if(remainingdistance <= 0) {
        pointontrack = cablecartracknode.origin;
        self.nextnodeindex = i;
        self.needtopauseatstart = remainingdistance / velocity;
        break;
      }
    }

    nextnodeisstop = 0;

    if(level.cablecartrack.size > i + 1)
      nextnodeisstop = is_true(level.cablecartrack[i + 1].pause);

    currentnodeisstop = 0;

    if(is_true(cablecartracknode.pause))
      currentnodeisstop = 1;

    distance = cablecartracknode.stepdistance;

    if(nextnodeisstop || currentnodeisstop)
      distance = distance * 2;

    if(!isDefined(distance)) {
      pointontrack = cablecartracknode.origin;
      self.nextnodeindex = i;
      break;
    }

    if(remainingdistance < distance) {
      if(distance > 0) {
        ratio = remainingdistance / distance;
        pointontrack = getpointonline(cablecartracknode.origin, level.cablecartrack[i + 1].origin, ratio);
      }

      self.nextnodeindex = i;
      break;
    }

    remainingdistance = remainingdistance - distance;
  }

  self.angles = level.cablecardefaultangle;

  if(distancealongtrack < level.distancetofirstrotate)
    self.angles = self.angles + vectorscale((0, 1, 0), 180.0);

  self.origin = pointontrack;
}

createcablecarpath(cablecar) {
  currentnode = getent("cable_down_start", "targetname");
  startorigin = currentnode.origin;
  velocity = getdvarfloatdefault("scr_cable_car_velocity", 100);
  tracklength = 0;
  previousnode = undefined;
  movetime = -1;

  while(isDefined(currentnode)) {
    cablecarnodestruct = spawnstruct();
    cablecarnodestruct.origin = currentnode.origin;
    level.cablecartrack[level.cablecartrack.size] = cablecarnodestruct;

    if(isDefined(currentnode.target))
      nextnode = getent(currentnode.target, "targetname");

    if(!isDefined(nextnode)) {
      break;
    }

    stepdistance = distance(currentnode.origin, nextnode.origin);
    cablecarnodestruct.stepdistance = stepdistance;
    movetime = stepdistance / velocity;
    assert(movetime > 0);
    pauseratio = 1;

    if(isDefined(nextnode.script_noteworthy) && nextnode.script_noteworthy == "stop")
      pauseratio = pauseratio * 2;

    if(isDefined(currentnode.script_noteworthy)) {
      if(currentnode.script_noteworthy == "stop") {
        cablecarnodestruct.pause = 1;
        tracklength = tracklength + velocity * 3;
        level.trackdistancestops[level.trackdistancestops.size] = tracklength;
        pauseratio = pauseratio * 2;
      } else if(currentnode.script_noteworthy == "rotate")
        cablecarnodestruct.rotate = 1;
      else if(currentnode.script_noteworthy == "forceorigin")
        cablecarnodestruct.forceorigin = 1;
      else {
        if(isDefined(level.gondolasounds[currentnode.script_noteworthy]))
          cablecarnodestruct.playsound = level.gondolasounds[currentnode.script_noteworthy];

        if(isDefined(level.gondolaloopsounds[currentnode.script_noteworthy]))
          cablecarnodestruct.playloopsound = level.gondolaloopsounds[currentnode.script_noteworthy];
      }
    }

    tracklength = tracklength + stepdistance * pauseratio;

    if(is_true(cablecarnodestruct.rotate))
      level.distancetofirstrotate = tracklength;

    cablecarnodestruct.movetime = movetime;
    previousnode = currentnode;
    currentnode = nextnode;
    nextnode = undefined;
  }

  return tracklength;
}

watchpronetouch() {
  for(;;) {
    self waittill("touch", entity);

    if(isplayer(entity)) {
      if(entity.origin[2] < 940) {
        if(entity getstance() == "prone")
          entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_HIT_BY_OBJECT", 0, "gondola_mp");
      }
    }
  }
}

cablecarrun(cablecar) {
  nextnodeindex = cablecar.nextnodeindex;
  cablecar thread watchpronetouch();
  cablecar thread cablecar_move_think(cablecar.killtrigger, 1);
  cablecar thread cablecar_ai_watch();
  cablecar.ismoving = 1;
  grip = cablecar.grip;
  firstmove = 1;
  cablecar.hidden = 0;
  grip.forceangles = 0;

  if(isDefined(cablecar.needtopauseatstart)) {
    if(cablecar.needtopauseatstart > 0)
      wait(cablecar.needtopauseatstart);
  }

  for(;;) {
    for(i = nextnodeindex; i < level.cablecartrack.size; i++) {
      nextnode = level.cablecartrack[i + 1];

      if(!isDefined(nextnode))
        nextnode = level.cablecartrack[0];

      currentnode = level.cablecartrack[i];
      acceltime = 0;
      deceltime = 0;
      currentmovetime = currentnode.movetime;

      if(isDefined(nextnode.pause) || isDefined(currentnode) && isDefined(currentnode.pause)) {
        currentmovetime = currentmovetime * 2;

        if(isDefined(nextnode.pause))
          deceltime = currentmovetime - 0.1;

        if(isDefined(currentnode) && isDefined(currentnode.pause))
          acceltime = currentmovetime - 0.1;
      }

      debug_star(nextnode.origin, (1, 1, 1), 1000);

      if(isDefined(currentnode)) {
        if(isDefined(currentnode.playsound))
          cablecar playsound(currentnode.playsound);

        if(isDefined(currentnode.playloopsound)) {
          cablecar stoploopsound();
          cablecar playsound("veh_cable_car_leave");

          if(currentnode.playloopsound != "")
            cablecar playloopsound(currentnode.playloopsound);
        }
      }

      if(isDefined(currentnode.rotate)) {
        cablecar hide();
        grip hide();
        cablecar.hidden = 1;
        cablecar.origin = cablecar.origin + vectorscale((0, 0, -1), 1000.0);

        if(cablecar.angles[1] > 360)
          cablecar.angles = cablecar.angles - vectorscale((0, 1, 0), 180.0);
        else
          cablecar.angles = cablecar.angles + vectorscale((0, 1, 0), 180.0);
      }

      if(isDefined(currentnode) && isDefined(nextnode)) {
        angles = vectortoangles(currentnode.origin - nextnode.origin);
        grip.nextangles = angles;

        if(grip.forceangles == 1) {
          grip.forceangles = 0;
          grip.angles = grip.nextangles;
        } else
          grip rotateto(grip.nextangles, 0.9);
      }

      if(firstmove == 1) {
        firstmovedistance = distance(cablecar.origin, nextnode.origin);
        velocity = getdvarfloatdefault("scr_cable_car_velocity", 100);
        timetomove = firstmovedistance / velocity;

        if(timetomove > 0) {
          cablecar moveto(nextnode.origin + (0, cos(cablecar.angles[1]) * -15, -66.6), timetomove);
          grip moveto(nextnode.origin - (0, cos(cablecar.angles[1]) * -12, 8), timetomove);
          wait(timetomove);
        }
      } else {
        heightoffset = -66.6;

        if(is_true(cablecar.hidden))
          heightoffset = heightoffset + -1000;

        if(deceltime > 0)
          cablecar thread prettyslowdown(currentmovetime - deceltime);

        grip thread hostmigrationawaremoveto(nextnode.origin - (0, cos(cablecar.angles[1]) * -12, 8), currentmovetime, acceltime, deceltime, currentmovetime - 0.05);
        cablecar hostmigrationawaremoveto(nextnode.origin + (0, cos(cablecar.angles[1]) * -15, heightoffset), currentmovetime, acceltime, deceltime, currentmovetime - 0.05);
      }

      if(cablecar.hidden == 1) {
        cablecar.hidden = 0;

        if(is_true(cablecar.hidden))
          cablecar.origin = cablecar.origin - vectorscale((0, 0, -1), 1000.0);

        cablecar show();
        grip show();
        grip.forceangles = 1;
      }

      firstmove = 0;

      if(isDefined(nextnode.pause)) {
        cablecar.ismoving = 0;
        grip thread hostmigrationawaremoveto(nextnode.origin - (0, cos(cablecar.angles[1]) * -12, 8), 300, 0, 0, 3);
        cablecar hostmigrationawaremoveto(nextnode.origin + (0, cos(cablecar.angles[1]) * -15, -66.6), 300, 0, 0, 3);
        cablecar notify("started_moving");
        cablecar thread prettyspeedup();
        cablecar.ismoving = 1;
      }

      if(isDefined(nextnode.forceorigin)) {
        cablecar.origin = nextnode.origin + (0, cos(cablecar.angles[1]) * -15, -66.6);
        grip.origin = nextnode.origin - (0, cos(cablecar.angles[1]) * -12, 8);
      }
    }

    nextnodeindex = 0;
  }
}

hostmigrationawaremoveto(origin, movetime, acceltime, deceltime, waittime) {
  starttime = gettime();
  self moveto(origin, movetime, acceltime, deceltime);
  waitcompleted = self waitendonmigration(waittime);

  if(!isDefined(waitcompleted)) {
    endtime = gettime();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    mstimedifference = starttime + waittime * 1000 - endtime;

    if(mstimedifference > 500)
      wait(mstimedifference / 1000);
  }
}

waitendonmigration(time) {
  level endon("host_migration_begin");
  wait(time);
  return true;
}

prettyslowdown(waittime) {
  if(waittime > 0)
    wait(waittime);

  self stoploopsound();
  self playsound(level.gondolasounds["slow_down"]);
  originalangle = self.angles;
  swingtime = getdvarfloatdefault("scr_cable_swing_time", 1.5);
  swingbacktime = getdvarfloatdefault("scr_cable_swing_back_time", 1.5);
  swingangle = getdvarfloatdefault("scr_cable_swing_angle", 2.0);
  self rotateto((originalangle[0] + swingangle, originalangle[1], originalangle[2]), swingtime, swingtime / 2, swingtime / 2);
  self waittill("rotatedone");
  self rotateto((originalangle[0], originalangle[1], originalangle[2]), swingbacktime, swingbacktime / 2, swingbacktime / 2);
  self waittill("rotatedone");
}

prettyspeedup() {
  self stoploopsound();
  self playsound(level.gondolasounds["rollers_start"]);
  self playloopsound(level.gondolaloopsounds["start"]);
  originalangle = self.angles;
  swingtime = getdvarfloatdefault("scr_cable_swing_time_up", 1.0);
  swingbacktime = getdvarfloatdefault("scr_cable_swing_back_time_up", 1.5);
  swingangle = getdvarfloatdefault("scr_cable_swing_angle_up", 2.0);
  self rotateto((originalangle[0] - swingangle, originalangle[1], originalangle[2]), swingtime, swingtime / 2, swingtime / 2);
  self waittill("rotatedone");
  self rotateto((originalangle[0], originalangle[1], originalangle[2]), swingbacktime, swingbacktime / 2, swingbacktime / 2);
  self waittill("rotatedone");
}

cablecar_ai_watch() {
  self endon("death");
  self endon("delete");

  for(;;) {
    wait 1;

    if(isDefined(self.nodes)) {
      for(i = 0; i < self.nodes.size; i++) {
        node = self.nodes[i];

        foreach(team in level.teams)
        node setdangerous(team, 0);
      }
    }

    dir = vectornormalize(anglestoforward(self.angles));
    dangerorigin = self.origin - dir * 196;
    nodes = getnodesinradius(dangerorigin, 256, 0, 196);

    for(i = 0; i < nodes.size; i++) {
      node = nodes[i];

      foreach(team in level.teams)
      node setdangerous(team, 1);
    }

    if(nodes.size > 0) {
      self.nodes = nodes;
      continue;
    }

    self.nodes = undefined;
  }
}

cablecar_move_think(kill_trigger, checkmoving) {
  self endon("death");
  self endon("delete");
  self.disablefinalkillcam = 1;
  destroycorpses = 0;

  for(;;) {
    wait 0.05;
    pixbeginevent("cablecar_move_think");

    if(checkmoving) {
      if(self.ismoving == 0)
        self waittill("started_moving");
    }

    entities = getdamageableentarray(self.origin, 200);

    foreach(entity in entities) {
      if(isDefined(entity.targetname) && entity.targetname == "cablecar") {
        continue;
      }
      if(!entity istouching(kill_trigger)) {
        continue;
      }
      if(isDefined(entity.model) && entity.model == "t6_wpn_tac_insert_world") {
        entity maps\mp\_tacticalinsertion::destroy_tactical_insertion();
        continue;
      }

      if(!isalive(entity)) {
        continue;
      }
      if(isDefined(entity.targetname)) {
        if(entity.targetname == "talon") {
          entity notify("death");
          continue;
        } else if(entity.targetname == "rcbomb") {
          entity maps\mp\killstreaks\_rcbomb::rcbomb_force_explode();
          continue;
        } else if(entity.targetname == "riotshield_mp") {
          entity dodamage(1, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
          continue;
        }
      }

      if(isDefined(entity.helitype) && entity.helitype == "qrdrone") {
        watcher = entity.owner maps\mp\gametypes\_weaponobjects::getweaponobjectwatcher("qrdrone");
        watcher thread maps\mp\gametypes\_weaponobjects::waitanddetonate(entity, 0.0, undefined);
        continue;
      }

      if(entity.classname == "grenade") {
        if(!isDefined(entity.name)) {
          continue;
        }
        if(!isDefined(entity.owner)) {
          continue;
        }
        if(entity.name == "satchel_charge_mp") {
          continue;
        }
        if(entity.name == "proximity_grenade_mp") {
          watcher = entity.owner getwatcherforweapon(entity.name);
          watcher thread maps\mp\gametypes\_weaponobjects::waitanddetonate(entity, 0.0, undefined, "script_mover_mp");
          continue;
        }

        if(!isweaponequipment(entity.name)) {
          continue;
        }
        watcher = entity.owner getwatcherforweapon(entity.name);

        if(!isDefined(watcher)) {
          continue;
        }
        watcher thread maps\mp\gametypes\_weaponobjects::waitanddetonate(entity, 0.0, undefined, "script_mover_mp");
        continue;
      } else if(entity.classname == "remote_drone") {
        continue;
      }
      if(entity.classname == "auto_turret") {
        if(isDefined(entity.carried) && entity.carried == 1) {
          continue;
        }
        if(!isDefined(entity.damagedtodeath) || !entity.damagedtodeath)
          entity domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");

        continue;
      }

      if(isplayer(entity)) {
        if(entity getstance() == "prone") {
          if(entity isonground() == 0)
            destroycorpses = 1;
        }

        entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_HIT_BY_OBJECT", 0, "gondola_mp");
        continue;
      }

      entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
    }

    if(destroycorpses == 1) {
      destroycorpses = 0;
      self destroy_corpses();
    }

    self destroy_supply_crates();

    if(level.gametype == "ctf") {
      foreach(flag in level.flags) {
        if(flag.curorigin != flag.trigger.baseorigin && flag.visuals[0] istouching(kill_trigger))
          flag maps\mp\gametypes\ctf::returnflag();
      }
    } else if(level.gametype == "sd" && !level.multibomb) {
      if(level.sdbomb.visuals[0] istouching(kill_trigger))
        level.sdbomb maps\mp\gametypes\_gameobjects::returnhome();
    }

    pixendevent();
  }
}

getwatcherforweapon(weapname) {
  if(!isDefined(self))
    return undefined;

  if(!isplayer(self))
    return undefined;

  for(i = 0; i < self.weaponobjectwatcherarray.size; i++) {
    if(self.weaponobjectwatcherarray[i].weapon != weapname) {
      continue;
    }
    return self.weaponobjectwatcherarray[i];
  }

  return undefined;
}

destroy_supply_crates() {
  crates = getentarray("care_package", "script_noteworthy");

  foreach(crate in crates) {
    if(distancesquared(crate.origin, self.origin) < 40000) {
      if(crate istouching(self)) {
        playfx(level._supply_drop_explosion_fx, crate.origin);
        playsoundatposition("wpn_grenade_explode", crate.origin);
        wait 0.1;
        crate maps\mp\killstreaks\_supplydrop::cratedelete();
      }
    }
  }
}

destroy_corpses() {
  corpses = getcorpsearray();

  for(i = 0; i < corpses.size; i++) {
    if(distancesquared(corpses[i].origin, self.origin) < 40000)
      corpses[i] delete();
  }
}