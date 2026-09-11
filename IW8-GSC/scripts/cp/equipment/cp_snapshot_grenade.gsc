/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_snapshot_grenade.gsc
********************************************************/

function snapshot_grenade_used(var0, var1) {
  var0 thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  var0 endon("end_explode");
  var0 setotherent(self);
  thread snapshot_grenade_watch_emp();
  thread snapshot_grenade_watch_cleanup();
  jumpiffalse(istrue(var1)) LOC_00000058;
  var0 waittill("missile_stuck", var2, var3, var4, var5, var6);
  goto LOC_00000064;
}

function snapshot_get_flight_dest(var0, var1) {
  var1 = (0, 0, 1);
  var2 = var0;
  var3 = var0 + var1 * 137;
  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  var5 = physics_raycast(var2, var3, var4, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var5) && var5.size > 0) {
    var3 = var5[0]["position"];

    if(true) {
      var6 = vectordot(var3 - var2, var1);

      if(var6 > 0) {
        if(var6 >= 50) {
          var6 = min(var6 - 25, 112);
        } else {
          var6 /= 2;
        }

        var3 = var2 + var1 * var6;
      }
    }
  } else {
    var3 = var2 + var1 * 112;
  }

  return var3;
}

function snapshot_grenade_watch_flight(var0) {
  var1 = self.name;
  var2 = scripts\cp\utility::_launchgrenade("snapshot_grenade_mp", var0, (0, 0, 0), 100, 1);
  var2 setotherent(self);
  var2 setscriptablepartstate("beacon", "active", 0);
  var2 setscriptablepartstate("anims", "deploy", 0);
  var2 missilehidetrail();
  var2.owner = self;
  thread snapshot_grenade_watch_emp();
  thread snapshot_grenade_watch_cleanup();
  var2 endon("death");
  var3 = scripts\cp\utility::_launchgrenade("snapshot_grenade_danger_mp", var2.origin, (0, 0, 0), 100, 1);
  var3 linkTo(var2);
  var3 hidefromplayer(self);
  thread snapshot_grenade_cleanup_danger_icon(var2);
  var4 = spawn("script_model", var2.origin);
  var4.angles = var2.angles;
  var4 setModel("tag_origin");
  var2 linkTo(var4, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread snapshot_grenade_cleanup_mover(var2);
  var5 = (0, 0, 1);
  var6 = snapshot_get_flight_dest(var0, var5);
  var7 = vectordot(var6 - var0, var5);
  var8 = (0, 0, 0);

  if(var7 > 0) {
    var9 = var7 / 112;
    var10 = 0.65 * var9;
    var11 = var10 * 0.19;
    var12 = var10 * 0.6;
    var13 = 0.3 * var9;
    var14 = var10 * 0;
    var15 = var10 * 0.35;
    var4 rotateTo(var8, var13, var14, var15);
    wait 0.2;
    var2 setscriptablepartstate("dust", "active", 0);
    var2 setscriptablepartstate("anims", "idle", 0);
    var4 moveTo(var6, var10, var11, var12);
    wait var10;
  } else {
    var4.angles = var8;
    wait 0.2;
  }

  var16 = 0;
  wait var16;
  var2 setscriptablepartstate("detect", "active", 0);
  var2 setscriptablepartstate("anims", "idle", 0);
  var2 setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  snapshot_grenade_detect(var2);
  level notify("grenade_exploded_during_stealth", var2, "snapshot_grenade_mp", var1);
  thread snapshot_grenade_destroy();
}

function snapshot_grenade_detect() {
  var0 = self.owner;
  var1 = self.origin;
  var2 = self.angles;
  var3 = undefined;

  if(true) {
    var3 = spawnStruct();
    var3.owner = var0;
    var3.position = var1;
    var3.isalive = 1;
    var3.targets = [];
    var3.endtimes = [];
    var3.outlineids = [];
  }

  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);

  foreach(var6 in level.characters) {
    if(!isDefined(var6)) {
      continue;
    }

    if(!var6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isPlayer(var6)) {
      continue;
    }

    var7 = var6.origin - var1;
    var8 = lengthsquared(var7);

    if(var8 > 1166400) {
      continue;
    }

    if(false) {
      var9 = var1;
      var10 = var6 getEye();
      var11 = physics_raycast(var9, var10, var4, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var11) && var11.size > 0) {
        continue;
      }

      if(true) {
        var12 = var6 getentitynumber();
        var3.targets[var12] = var6;
        var3.endtimes[var12] = gettime() + 10000;
        var3.outlineids[var12] = scripts\cp\cp_outline_utility::outlineenableforall(var6, "snapshotgrenade", "equipment");
        var6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
        thread snapshot_grenade_update_outlines();
      }

      if(false) {
        thread snapshot_grenade_create_marker(var0, var6 gettagorigin("j_spineupper"), var6.angles);
      }

      continue;
    }

    if(true) {
      var12 = var6 getentitynumber();
      var3.targets[var12] = var6;
      var3.endtimes[var12] = gettime() + 10000;
      var3.outlineids[var12] = scripts\cp\cp_outline_utility::outlineenableforall(var6, "snapshotgrenade", "equipment");

      if(isPlayer(var6)) {
        var6 scripts\cp\cp_outline_utility::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      }

      thread snapshot_grenade_update_outlines();
    }

    if(false) {
      thread snapshot_grenade_create_marker(var0, var6 gettagorigin("j_spineupper"), var6.angles);
    }
  }

  if(true) {
    triggerportableradarping(var1, var0, 1080, 500);
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

function snapshot_grenade_delete(var0) {
  self notify("death");
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);
  wait var0;
  self delete();
}

function snapshot_grenade_handle_damage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(scripts\engine\utility::isbulletdamage(var3)) {
    if(isDefined(var2)) {
      var6 = 1;
      var4 = var6 * 19;
    }
  }

  return var4;
}

function snapshot_grenade_handle_fatal_damage(var0) {
  var1 = var0.attacker;

  if(isDefined(var1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1)) {
    var1 notify("destroyed_equipment");
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_watch_emp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", var0);
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
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

function snapshot_grenade_cleanup_mover(var0) {
  var0 endon("death");
  self waittill("death");
  wait 1;
  var0 delete();
}

function snapshot_grenade_cleanup_danger_icon(var0) {
  var0 endon("death");
  self waittill("death");
  var0 delete();
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
    foreach(var4, var1 in self.targets) {
      var1 = self.targets[var4];
      var2 = self.endtimes[var4];
      var3 = self.outlineids[var4];

      if(!isDefined(var1) || !var1 scripts\cp_mp\utility\player_utility::_isalive() || gettime() >= var2) {
        scripts\cp\cp_outline_utility::outlinedisable(var3, var1);

        if(isDefined(var1) && isPlayer(var1)) {
          var1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
        }

        self.targets[var4] = undefined;
        self.endtimes[var4] = undefined;
        self.outlineids[var4] = undefined;
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

  foreach(var1 in self.targets) {
    var1 = self.targets[var3];
    var2 = self.outlineids[var3];
    scripts\cp\cp_outline_utility::outlinedisable(var2, var1);

    if(isDefined(var1) && isPlayer(var1)) {
      var1 scripts\cp\cp_outline_utility::_hudoutlineviewmodeldisable();
    }
  }
}

function snapshot_grenade_create_marker(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3.angles = var1;

  if(isDefined(var2) && true) {
    var3 linkTo(var2);
  }

  var3 setModel("equip_snapshot_marker_mp");
  var3 setotherent(self);
  var3 setscriptablepartstate("effects", "active", 0);
  snapshot_grenade_watch_marker_end_early(var3, self, 36000, var2, 15000);

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function snapshot_grenade_watch_marker_end_early(var0, var1, var2, var3) {
  self endon("death");
  var0 endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var4 = gettime() + var1;
  var5 = scripts\engine\utility::ter_op(1, gettime() + 15000, undefined);

  while(var4 > gettime()) {
    if(isDefined(var5)) {
      if(var5 < gettime()) {
        self unlink();
        var5 = undefined;
      } else if(!isDefined(var2)) {
        self unlink();
        var5 = undefined;
      } else if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
        self unlink();
        var5 = undefined;
      }
    }

    waitframe();
  }
}