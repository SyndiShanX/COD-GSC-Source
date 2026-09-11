/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\snapshot_grenade.gsc
*****************************************************/

function snapshot_grenade_used(var0, var1) {
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var0 endon("end_explode");

  if(var1) {
    var0 waittill("missile_stuck", var2, var3, var4, var5, var6);
  } else {
    var1 setotherent(self);
    var1 thread scripts\mp\damage::monitordamage(19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage);
    scripts\cp_mp\emp_debuff::add_emp_ent(var1);
    var1 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&snapshot_grenade_empapplied);
    thread snapshot_grenade_watch_cleanup();
    var1 waittill("explode", var6);
  }

  thread snapshot_grenade_watch_flight(var6);
}

function snapshot_get_flight_dest(var0, var1, var2) {
  var1 = (0, 0, 1);
  var3 = var0 + var1;
  var4 = var3 + var1 * 137;
  var5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  var6 = physics_raycast(var3, var4, var5, var2, 0, "physicsquery_closest", 1);

  if(isDefined(var6) && var6.size > 0) {
    var4 = var6[0]["position"];

    if(true) {
      var7 = vectordot(var4 - var3, var1);

      if(var7 > 0) {
        if(var7 >= 50) {
          var7 = min(var7 - 25, 112);
        } else {
          var7 /= 2;
        }

        var4 = var3 + var1 * var7;
      }
    }
  } else {
    var4 = var3 + var1 * 112;
  }

  return var4;
}

function nukeplayer() {
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    var0 = self.origin;
    wait 0.05;
    self.velocity = 20 * (self.origin - var0);
  }
}

function snapshot_grenade_watch_flight(var0) {
  var1 = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_mp", var0, (0, 0, 0), 100, 1);
  var1 scripts\cp_mp\ent_manager::registerspawn(3, &snapshot_grenade_delete);
  var1 setotherent(self);
  var1 setscriptablepartstate("beacon", "active", 0);
  var1 setscriptablepartstate("anims", "deploy", 0);
  var1 missilehidetrail();
  var1.owner = self;
  var1 thread scripts\mp\damage::monitordamage(19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage);
  scripts\cp_mp\emp_debuff::add_emp_ent(var1);
  var1 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&snapshot_grenade_empapplied);
  thread snapshot_grenade_watch_cleanup();
  var1 endon("death");
  var2 = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_danger_mp", var1.origin, (0, 0, 0), 100, 1);
  var2.weapon_name = "snapshot_grenade_danger_mp";
  var2 linkTo(var1);
  var2 hidefromplayer(self);
  thread snapshot_grenade_cleanup_danger_icon(var1);
  var3 = spawnStruct();
  var3.ref_133ca = 1;
  var1 thread scripts\mp\movers::handle_moving_platforms(var3);
  var4 = spawn("script_model", var1.origin);
  var4.angles = var1.angles;
  var4 setModel("tag_origin");
  var1 linkTo(var4, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread snapshot_grenade_cleanup_mover(var1);
  waitframe();
  var5 = undefined;

  if(istrue(var1.ref_13bff)) {
    thread nukeplayer();
  }

  var6 = (0, 0, 1);
  var7 = snapshot_get_flight_dest(var0, var6, [var1, var2]);
  var8 = vectordot(var7 - var0, var6);
  var9 = (0, 0, 0);

  if(var8 > 0) {
    var10 = var8 / 112;
    var11 = 0.65 * var10;
    var12 = var11 * 0.19;
    var13 = var11 * 0.6;
    var14 = 0.3 * var10;
    var15 = var11 * 0;
    var16 = var11 * 0.35;
    var4 rotateTo(var9, var14, var15, var16);

    if(isDefined(var1.wam_number_of_failures)) {
      var5 = _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var1.wam_number_of_failures);

      if(var5) {
        var4 linkTo(var1.wam_number_of_failures);
      }
    }

    wait 0.3;

    if(istrue(var5)) {
      var4 unlink();
      var7 += var1.velocity * var11;
    }

    var1 setscriptablepartstate("dust", "active", 0);
    var1 setscriptablepartstate("anims", "idle", 0);
    var4 moveTo(var7, var11, var12, var13);
    var1 childthread scripts\mp\utility\equipment::ref_14444();
    var1 scripts\engine\utility::ref_143b9(var11, "collision_with_platform");
  } else {
    var4.angles = var9;
    wait 0.3;
  }

  if(istrue(var5)) {
    var4 linkTo(var1.wam_number_of_failures);
  }

  var17 = 0;
  wait var17;
  var1 setscriptablepartstate("detect", "active", 0);
  var1 setscriptablepartstate("anims", "idle", 0);
  var1 setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  snapshot_grenade_detect(var1);
  thread snapshot_grenade_destroy();
}

function snapshot_grenade_detect() {
  var0 = self.owner;
  var1 = self.origin;
  var2 = self.angles;
  var3 = ref_13436(var0, var1);
  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var5 = scripts\mp\utility\game::unset_relic_grounded();
  var6 = scripts\common\utility::playersinsphere(var1, scripts\engine\utility::ter_op(var5, 865, 540));
  var7 = binocularsstate(var1, scripts\engine\utility::ter_op(var5, 865, 540));

  if(var7.size) {
    var6 = scripts\engine\utility::array_combine(var6, var7);
  }

  foreach(var9 in var6) {
    if(!scripts\mp\utility\player::isreallyalive(var9)) {
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::playersareenemies(var0, var9)) {
      continue;
    }

    if(false) {
      var10 = var1;
      var11 = var9 getEye();
      var12 = physics_raycast(var10, var11, var4, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var12) && var12.size > 0) {
        continue;
      }
    }

    ref_13435(var9, var0, var3);
  }

  if(true) {
    triggerportableradarping(var1, var0, scripts\engine\utility::ter_op(var5, 865, 540), 500, "specialty_snapshot_immunity");
    return;
  }
}

function ref_13436(var0, var1) {
  var2 = undefined;

  if(true) {
    var2 = spawnStruct();
    var2.owner = var0;
    var2.position = var1;
    var2.isalive = 1;
    var2.targets = [];
    var2.endtimes = [];
    var2.outlineids = [];
  }

  return var2;
}

function ref_13435(var0, var1, var2) {
  if(var0 scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
    var1 scripts\mp\damagefeedback::updatedamagefeedback("hittacresist");
    return;
  }

  var1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(true) {
    var3 = scripts\mp\utility\game::unset_relic_grounded();
    var4 = var0 getentitynumber();
    var2.targets[var4] = var0;
    var2.endtimes[var4] = gettime() + scripts\engine\utility::ter_op(var3, 2000, 1250);

    if(!level.teambased) {
      var2.outlineids[var4] = scripts\mp\utility\outline::outlineenableforplayer(var0, var1, "snapshotgrenade", "equipment");
    } else if(isDefined(var1.squadindex)) {
      var2.outlineids[var4] = scripts\mp\utility\outline::outlineenableforsquad(var0, var1.team, var1.squadindex, "snapshotgrenade", "equipment");
    } else {
      var2.outlineids[var4] = scripts\mp\utility\outline::outlineenableforteam(var0, var1.team, "snapshotgrenade", "equipment");
    }

    if(isPlayer(var0) || isbot(var0)) {
      var0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      var0 scripts\cp_mp\killstreaks\helper_drone::markeduion();
    }

    thread snapshot_grenade_update_outlines();
  }

  if(false) {
    thread snapshot_grenade_create_marker(var1, var0 gettagorigin("j_spineupper"), var0.angles);
  }

  var0.lastsnapshotgrenadetime = gettime();
  var1 scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
  var1 scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
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
  scripts\cp_mp\ent_manager::deregisterspawn();
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);

  if(isDefined(var0)) {
    wait var0;
  }

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

      if(var4 >= scripts\mp\weapons::minegettwohitthreshold()) {
        var6 += 1;
      }

      if(scripts\mp\utility\damage::isfmjdamage(var2, var3, 1)) {
        var6 *= 2;
      }

      var4 = var6 * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, var1, var2, var3);
  return var4;
}

function snapshot_grenade_handle_fatal_damage(var0) {
  var1 = var0.attacker;

  if(isDefined(var1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1)) {
    var1 notify("destroyed_equipment");
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var0.objweapon);
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_empapplied(var0) {
  if(!isDefined(self.owner)) {
    return;
  }

  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var1)) {
    var1 scripts\mp\damagefeedback::updatedamagefeedback("");
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
  self.owner endon("death_or_disconnect");
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

      if(!isDefined(var1) || !scripts\mp\utility\player::isreallyalive(var1) || gettime() >= var2) {
        scripts\mp\utility\outline::outlinedisable(var3, var1);

        if(isDefined(var1) && (isPlayer(var1) || isbot(var1))) {
          var1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
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
  self.owner endon("death_or_disconnect");
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
    scripts\mp\utility\outline::outlinedisable(var2, var1);

    if(isDefined(var1) && (isPlayer(var1) || isbot(var1))) {
      var1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
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
  snapshot_grenade_watch_marker_end_early(var3, self, 3000, var2, 1250);

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function snapshot_grenade_watch_marker_end_early(var0, var1, var2, var3) {
  self endon("death");
  var0 endon("death_or_disconnect");
  level endon("game_ended");
  var4 = gettime() + var1;
  var5 = scripts\engine\utility::ter_op(1, gettime() + 1250, undefined);

  while(var4 > gettime()) {
    if(isDefined(var5)) {
      if(var5 < gettime()) {
        self unlink();
        var5 = undefined;
      } else if(!isDefined(var2)) {
        self unlink();
        var5 = undefined;
      } else if(!scripts\mp\utility\player::isreallyalive(var2)) {
        self unlink();
        var5 = undefined;
      }
    }

    waitframe();
  }
}

function binocularsstate(var0, var1) {
  var2 = binocularsstruct(var0, var1);
  var3 = [];
  var4 = var1 * var1;

  foreach(var6 in var2) {
    var7 = distancesquared(var6.origin, var0);

    if(var7 < var4) {
      var3 = var6;
    }
  }

  return var3;
}

function binocularsstruct(var0, var1) {
  var2 = physics_createcontents(["physicscontents_actor"]);
  var3 = (var1, var1, var1);
  var4 = var0 - var3;
  var5 = var0 + var3;
  var6 = physics_aabbbroadphasequery(var4, var5, var2, []);
  return var6;
}

function removespawnselections() {
  return 3000;
}