/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_snapshot_grenade.gsc
********************************************************/

function snapshot_grenade_used(var_0, var_1) {
  var_0 thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  var_0 endon("end_explode");
  var_0 setotherent(self);
  thread snapshot_grenade_watch_emp();
  thread snapshot_grenade_watch_cleanup();
  jumpiffalse(istrue(var_1)) LOC_00000058;
  var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6);
  goto LOC_00000064;
}

function snapshot_get_flight_dest(var_0, var_1) {
  var_1 = (0, 0, 1);
  var_2 = var_0;
  var_3 = var_0 + var_1 * 137;
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  var_5 = physics_raycast(var_2, var_3, var_4, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_5) && var_5.size > 0) {
    var_3 = var_5[0]["position"];

    if(true) {
      var_6 = vectordot(var_3 - var_2, var_1);

      if(var_6 > 0) {
        if(var_6 >= 50) {
          var_6 = min(var_6 - 25, 112);
        } else {
          var_6 /= 2;
        }

        var_3 = var_2 + var_1 * var_6;
      }
    }
  } else {
    var_3 = var_2 + var_1 * 112;
  }

  return var_3;
}

function snapshot_grenade_watch_flight(var_0) {
  var_1 = self.name;
  var_2 = scripts\cp\utility::_launchgrenade("snapshot_grenade_mp", var_0, (0, 0, 0), 100, 1);
  var_2 setotherent(self);
  var_2 setscriptablepartstate("beacon", "active", 0);
  var_2 setscriptablepartstate("anims", "deploy", 0);
  var_2 missilehidetrail();
  var_2.owner = self;
  thread snapshot_grenade_watch_emp();
  thread snapshot_grenade_watch_cleanup();
  var_2 endon("death");
  var_3 = scripts\cp\utility::_launchgrenade("snapshot_grenade_danger_mp", var_2.origin, (0, 0, 0), 100, 1);
  var_3 linkTo(var_2);
  var_3 hidefromplayer(self);
  thread snapshot_grenade_cleanup_danger_icon(var_2);
  var_4 = spawn("script_model", var_2.origin);
  var_4.angles = var_2.angles;
  var_4 setModel("tag_origin");
  var_2 linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread snapshot_grenade_cleanup_mover(var_2);
  var_5 = (0, 0, 1);
  var_6 = snapshot_get_flight_dest(var_0, var_5);
  var_7 = vectordot(var_6 - var_0, var_5);
  var_8 = (0, 0, 0);

  if(var_7 > 0) {
    var_9 = var_7 / 112;
    var_10 = 0.65 * var_9;
    var_11 = var_10 * 0.19;
    var_12 = var_10 * 0.6;
    var_13 = 0.3 * var_9;
    var_14 = var_10 * 0;
    var_15 = var_10 * 0.35;
    var_4 rotateTo(var_8, var_13, var_14, var_15);
    wait 0.2;
    var_2 setscriptablepartstate("dust", "active", 0);
    var_2 setscriptablepartstate("anims", "idle", 0);
    var_4 moveTo(var_6, var_10, var_11, var_12);
    wait var_10;
  } else {
    var_4.angles = var_8;
    wait 0.2;
  }

  var_16 = 0;
  wait var_16;
  var_2 setscriptablepartstate("detect", "active", 0);
  var_2 setscriptablepartstate("anims", "idle", 0);
  var_2 setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  snapshot_grenade_detect(var_2);
  level notify("grenade_exploded_during_stealth", var_2, "snapshot_grenade_mp", var_1);
  thread snapshot_grenade_destroy();
}

function snapshot_grenade_detect() {
  var_0 = self.owner;
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = undefined;

  if(true) {
    var_3 = spawnStruct();
    var_3.owner = var_0;
    var_3.position = var_1;
    var_3.isalive = 1;
    var_3.targets = [];
    var_3.endtimes = [];
    var_3.outlineids = [];
  }

  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);

  foreach(var_6 in level.characters) {
    if(!isDefined(var_6)) {
      continue;
    }

    if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isPlayer(var_6)) {
      continue;
    }

    var_7 = var_6.origin - var_1;
    var_8 = lengthsquared(var_7);

    if(var_8 > 1166400) {
      continue;
    }

    if(false) {
      var_9 = var_1;
      var_10 = var_6 getEye();
      var_11 = physics_raycast(var_9, var_10, var_4, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var_11) && var_11.size > 0) {
        continue;
      }

      if(true) {
        var_12 = var_6 getentitynumber();
        var_3.targets[var_12] = var_6;
        var_3.endtimes[var_12] = gettime() + 10000;
        var_3.outlineids[var_12] = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "snapshotgrenade", "equipment");
        var_6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
        thread snapshot_grenade_update_outlines();
      }

      if(false) {
        thread snapshot_grenade_create_marker(var_0, var_6 gettagorigin("j_spineupper"), var_6.angles);
      }

      continue;
    }

    if(true) {
      var_12 = var_6 getentitynumber();
      var_3.targets[var_12] = var_6;
      var_3.endtimes[var_12] = gettime() + 10000;
      var_3.outlineids[var_12] = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "snapshotgrenade", "equipment");

      if(isPlayer(var_6)) {
        var_6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      }

      thread snapshot_grenade_update_outlines();
    }

    if(false) {
      thread snapshot_grenade_create_marker(var_0, var_6 gettagorigin("j_spineupper"), var_6.angles);
    }
  }

  if(true) {
    triggerportableradarping(var_1, var_0, 1080, 500);
    return;
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

function snapshot_grenade_delete(var_0) {
  self notify("death");
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);
  wait var_0;
  self delete();
}

function snapshot_grenade_handle_damage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(scripts\engine\utility::isbulletdamage(var_3)) {
    if(isDefined(var_2)) {
      var_6 = 1;
      var_4 = var_6 * 19;
    }
  }

  return var_4;
}

function snapshot_grenade_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(var_1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)) {
    var_1 notify("destroyed_equipment");
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_watch_emp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", var_0);
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_watch_cleanup() {
  self endon("death");
  snapshot_grenade_watch_cleanup_end_early();

  if(isDefined(self)) {
    thread snapshot_grenade_destroy();
    return;
  }
}

function snapshot_grenade_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

function snapshot_grenade_cleanup_mover(var_0) {
  var_0 endon("death");
  self waittill("death");
  wait 1;
  var_0 delete();
}

function snapshot_grenade_cleanup_danger_icon(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
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
    foreach(var_4, var_1 in self.targets) {
      var_1 = self.targets[var_4];
      var_2 = self.endtimes[var_4];
      var_3 = self.outlineids[var_4];

      if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive() || gettime() >= var_2) {
        scripts\cp\cp_outline_utility::outlinedisable(var_3, var_1);

        if(isDefined(var_1) && isPlayer(var_1)) {
          var_1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
        }

        self.targets[var_4] = undefined;
        self.endtimes[var_4] = undefined;
        self.outlineids[var_4] = undefined;
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

  for(;;) {
    waitframe();
  }
}

function snapshot_grenade_clear_outlines() {
  self notify("death");
  self.isalive = 0;

  foreach(var_1 in self.targets) {
    var_1 = self.targets[var_3];
    var_2 = self.outlineids[var_3];
    scripts\cp\cp_outline_utility::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
    }
  }
}

function snapshot_grenade_create_marker(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;

  if(isDefined(var_2) && true) {
    var_3 linkTo(var_2);
  }

  var_3 setModel("equip_snapshot_marker_mp");
  var_3 setotherent(self);
  var_3 setscriptablepartstate("effects", "active", 0);
  snapshot_grenade_watch_marker_end_early(var_3, self, 36000, var_2, 15000);

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function snapshot_grenade_watch_marker_end_early(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_4 = gettime() + var_1;
  var_5 = scripts\engine\utility::ter_op(1, gettime() + 15000, undefined);

  while(var_4 > gettime()) {
    if(isDefined(var_5)) {
      if(var_5 < gettime()) {
        self unlink();
        var_5 = undefined;
      } else if(!isDefined(var_2)) {
        self unlink();
        var_5 = undefined;
      } else if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        self unlink();
        var_5 = undefined;
      }
    }

    waitframe();
  }
}