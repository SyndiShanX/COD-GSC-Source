/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_snapshot_grenade.gsc
********************************************************/



#using scripts\common\utility;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_weapons;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace cp_snapshot_grenade;

function snapshot_grenade_used(grenade, isgl) {
  grenade thread notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  grenade setotherent(self);
  grenade thread snapshot_grenade_watch_emp();
  grenade thread snapshot_grenade_watch_cleanup();

  if(istrue(isgl)) {
    grenade waittill("missile_stuck", ent, hitloc, surfacetype, velocity, position);
  } else {
    grenade waittill("explode", position);
  }

  thread snapshot_grenade_watch_flight(position);
}

function snapshot_get_flight_dest(position, direction) {
  direction = (0, 0, 1);
  caststart = position;
  castend = position + direction * 137;
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  castresult = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(castresult) && castresult.size > 0) {
    castend = castresult[0]["position"];

    if(true) {
      castdist = vectordot(castend - caststart, direction);

      if(castdist > 0) {
        if(castdist >= 50) {
          castdist = min(castdist - 25, 112);
        } else {
          castdist /= 2;
        }

        castend = caststart + direction * castdist;
      }
    }
  } else {
    castend = caststart + direction * 112;
  }

  return castend;
}

function snapshot_grenade_watch_flight(position) {
  grenade_owner_name = self.name;
  grenade = _launchgrenade("snapshot_grenade_mp", position, (0, 0, 0), 100, 1);
  grenade setotherent(self);
  grenade setscriptablepartstate("beacon", "active", 0);
  grenade setscriptablepartstate("anims", "deploy", 0);
  grenade missilehidetrail();
  grenade.owner = self;
  grenade thread snapshot_grenade_watch_emp();
  grenade thread snapshot_grenade_watch_cleanup();
  grenade endon("death");
  dangericon = _launchgrenade("snapshot_grenade_danger_mp", grenade.origin, (0, 0, 0), 100, 1);
  dangericon linkTo(grenade);
  dangericon hidefromplayer(self);
  grenade thread snapshot_grenade_cleanup_danger_icon(dangericon);
  mover = spawn("script_model", grenade.origin);
  mover.angles = grenade.angles;
  mover setModel("tag_origin");
  grenade linkTo(mover, "tag_origin", (0, 0, 0), (0, 0, 0));
  grenade thread snapshot_grenade_cleanup_mover(mover);
  destdir = (0, 0, 1);
  destpos = snapshot_get_flight_dest(position, destdir);
  destdist = vectordot(destpos - position, destdir);
  destangles = (0, 0, 0);

  if(destdist > 0) {
    destratio = destdist / 112;
    desttime = 0.65 * destratio;
    var_d9936f1afe54db08 = desttime * 0.19;
    var_baa9727310cc90c1 = desttime * 0.6;
    var_b229534034874cef = 0.3 * destratio;
    var_ca262de1cd84def1 = desttime * 0;
    var_b34668c30f214b1c = desttime * 0.35;
    mover rotateTo(destangles, var_b229534034874cef, var_ca262de1cd84def1, var_b34668c30f214b1c);
    wait 0.2;
    grenade setscriptablepartstate("dust", "active", 0);
    grenade setscriptablepartstate("anims", "idle", 0);
    mover moveTo(destpos, desttime, var_d9936f1afe54db08, var_baa9727310cc90c1);
    wait desttime;
  } else {
    mover.angles = destangles;
    wait 0.2;
  }

  detectiondelay = 0;
  wait detectiondelay;
  grenade setscriptablepartstate("detect", "active", 0);
  grenade setscriptablepartstate("anims", "idle", 0);
  grenade setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  grenade snapshot_grenade_detect();
  level notify("grenade_exploded_during_stealth", grenade, "snapshot_grenade_mp", grenade_owner_name);
  grenade thread snapshot_grenade_destroy();
}

function snapshot_grenade_detect() {
  owner = self.owner;
  position = self.origin;
  angles = self.angles;
  outlinedata = undefined;

  if(true) {
    outlinedata = spawnStruct();
    outlinedata.owner = owner;
    outlinedata.position = position;
    outlinedata.isalive = 1;
    outlinedata.targets = [];
    outlinedata.endtimes = [];
    outlinedata.outlineids = [];
  }

  function_daf6c5596bb31dff("decoy_grenade", self.owner, self.origin, 512);
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_103f275bc910af75 = level.characters;

  if(isDefined(level.drone_turrets)) {
    var_103f275bc910af75 = array_combine(var_103f275bc910af75, level.drone_turrets);
  }

  foreach(player in var_103f275bc910af75) {
    if(!isDefined(player)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isPlayer(player)) {
      continue;
    }

    if(isDefined(player.ally_index)) {
      continue;
    }

    if(istrue(player.var_bc1ca118ea17b3e6)) {
      continue;
    }

    between = player.origin - position;
    distsqr = lengthsquared(between);

    if(distsqr > 1166400) {
      continue;
    }

    if(false) {
      caststart = position;
      castend = player getEye();
      castresult = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(castresult) && castresult.size > 0) {
        continue;
      }

      if(true) {
        entnum = player getentitynumber();
        outlinedata.targets[entnum] = player;
        outlinedata.endtimes[entnum] = gettime() + 10000;
        outlinedata.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforall(player, "snapshotgrenade", "equipment");
        player scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
        outlinedata thread snapshot_grenade_update_outlines();
      }

      if(false) {
        owner thread snapshot_grenade_create_marker(player gettagorigin("j_spineupper"), player.angles, player);
      }

      continue;
    }

    if(true) {
      entnum = player getentitynumber();
      outlinedata.targets[entnum] = player;
      outlinedata.endtimes[entnum] = gettime() + 10000;
      outlinedata.outlineids[entnum] = scripts\cp\cp_outline_utility::outlineenableforall(player, "snapshotgrenade", "equipment");

      if(isPlayer(player)) {
        player scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      }

      outlinedata thread snapshot_grenade_update_outlines();
    }

    if(false) {
      owner thread snapshot_grenade_create_marker(player gettagorigin("j_spineupper"), player.angles, player);
    }
  }

  if(true) {
    triggerportableradarping(position, owner, 1080, 500);
  }
}

function snapshot_grenade_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("dust", "neutral", 0);
  self setscriptablepartstate("detect", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self missilehidetrail();
  thread snapshot_grenade_delete(0.35);
}

function snapshot_grenade_delete(delay) {
  self notify("death");
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);
  wait delay;
  self delete();
}

function snapshot_grenade_handle_damage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isbulletdamage(meansofdeath)) {
    if(isDefined(objweapon)) {
      hits = 1;
      damage = hits * 19;
    }
  }

  return damage;
}

function snapshot_grenade_handle_fatal_damage(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_watch_emp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", data);
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_watch_cleanup() {
  self endon("death");
  snapshot_grenade_watch_cleanup_end_early();

  if(isDefined(self)) {
    thread snapshot_grenade_destroy();
  }
}

function snapshot_grenade_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  while(true) {
    waitframe();
  }
}

function snapshot_grenade_cleanup_mover(mover) {
  mover endon("death");
  self waittill("death");
  wait 1;
  mover delete();
}

function snapshot_grenade_cleanup_danger_icon(dangericon) {
  dangericon endon("death");
  self waittill("death");
  dangericon delete();
}

function snapshot_grenade_update_outlines() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(!istrue(self.isalive)) {
    return;
  }

  self notify("update");
  self endon("update");
  thread snapshot_grenade_watch_cleanup_outlines();

  while(self.targets.size > 0) {
    foreach(id, target in self.targets) {
      target = self.targets[id];
      endtime = self.endtimes[id];
      outlineid = self.outlineids[id];

      if(!isDefined(target) || !target scripts\cp_mp\utility\player_utility::_isalive() || gettime() >= endtime) {
        scripts\cp\cp_outline_utility::outlinedisable(outlineid, target);

        if(isDefined(target) && isPlayer(target)) {
          target scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
        }

        self.targets[id] = undefined;
        self.endtimes[id] = undefined;
        self.outlineids[id] = undefined;
      }
    }

    waitframe();
  }

  thread snapshot_grenade_clear_outlines();
}

function snapshot_grenade_watch_cleanup_outlines() {
  self endon("death");
  self endon("update");
  snapshot_grenade_watch_cleanup_outlines_end_early();
  thread snapshot_grenade_clear_outlines();
}

function snapshot_grenade_watch_cleanup_outlines_end_early() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  while(true) {
    waitframe();
  }
}

function snapshot_grenade_clear_outlines() {
  self notify("death");
  self.isalive = 0;

  foreach(id, target in self.targets) {
    target = self.targets[id];
    outlineid = self.outlineids[id];
    scripts\cp\cp_outline_utility::outlinedisable(outlineid, target);

    if(isDefined(target) && isPlayer(target)) {
      target scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
    }
  }
}

function snapshot_grenade_create_marker(position, angles, target) {
  marker = spawn("script_model", position);
  marker.angles = angles;

  if(isDefined(target) && true) {
    marker linkTo(target);
  }

  marker setModel("equip_snapshot_marker_mp");
  marker setotherent(self);
  marker setscriptablepartstate("effects", "active", 0);
  marker snapshot_grenade_watch_marker_end_early(self, 36000, target, 15000);

  if(isDefined(marker)) {
    marker delete();
  }
}

function snapshot_grenade_watch_marker_end_early(owner, durationms, target, liveupdatedurationms) {
  self endon("death");
  owner endon("death");
  owner endon("disconnect");
  level endon("game_ended");
  endtime = gettime() + durationms;
  liveupdateendtime = ter_op(-1, gettime() + 15000, undefined);

  while(endtime > gettime()) {
    if(isDefined(liveupdateendtime)) {
      if(liveupdateendtime < gettime()) {
        self unlink();
        liveupdateendtime = undefined;
      } else if(!isDefined(target)) {
        self unlink();
        liveupdateendtime = undefined;
      } else if(!target scripts\cp_mp\utility\player_utility::_isalive()) {
        self unlink();
        liveupdateendtime = undefined;
      }
    }

    waitframe();
  }
}