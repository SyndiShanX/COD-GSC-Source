/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\snapshot_grenade.gsc
*****************************************************/

function snapshot_grenade_used(var_0, var_1) {
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var_0 endon("end_explode");

  if(var_1) {
    var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6);
  } else {
    var_1 setotherent(self);
    var_1 thread scripts\mp\damage::monitordamage(19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage);
    scripts\cp_mp\emp_debuff::add_emp_ent(var_1);
    var_1 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&snapshot_grenade_empapplied);
    thread snapshot_grenade_watch_cleanup();
    var_1 waittill("explode", var_6);
  }

  thread snapshot_grenade_watch_flight(var_6);
}

function snapshot_get_flight_dest(var_0, var_1, var_2) {
  var_1 = (0, 0, 1);
  var_3 = var_0 + var_1;
  var_4 = var_3 + var_1 * 137;
  var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  var_6 = physics_raycast(var_3, var_4, var_5, var_2, 0, "physicsquery_closest", 1);

  if(isDefined(var_6) && var_6.size > 0) {
    var_4 = var_6[0]["position"];

    if(true) {
      var_7 = vectordot(var_4 - var_3, var_1);

      if(var_7 > 0) {
        if(var_7 >= 50) {
          var_7 = min(var_7 - 25, 112);
        } else {
          var_7 /= 2;
        }

        var_4 = var_3 + var_1 * var_7;
      }
    }
  } else {
    var_4 = var_3 + var_1 * 112;
  }

  return var_4;
}

function nukeplayer() {
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    var_0 = self.origin;
    wait 0.05;
    self.velocity = 20 * (self.origin - var_0);
  }
}

function snapshot_grenade_watch_flight(var_0) {
  var_1 = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_mp", var_0, (0, 0, 0), 100, 1);
  var_1 scripts\cp_mp\ent_manager::registerspawn(3, &snapshot_grenade_delete);
  var_1 setotherent(self);
  var_1 setscriptablepartstate("beacon", "active", 0);
  var_1 setscriptablepartstate("anims", "deploy", 0);
  var_1 missilehidetrail();
  var_1.owner = self;
  var_1 thread scripts\mp\damage::monitordamage(19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage);
  scripts\cp_mp\emp_debuff::add_emp_ent(var_1);
  var_1 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&snapshot_grenade_empapplied);
  thread snapshot_grenade_watch_cleanup();
  var_1 endon("death");
  var_2 = scripts\mp\utility\weapon::_launchgrenade("snapshot_grenade_danger_mp", var_1.origin, (0, 0, 0), 100, 1);
  var_2.weapon_name = "snapshot_grenade_danger_mp";
  var_2 linkTo(var_1);
  var_2 hidefromplayer(self);
  thread snapshot_grenade_cleanup_danger_icon(var_1);
  var_3 = spawnStruct();
  var_3.ref_133CA = 1;
  var_1 thread scripts\mp\movers::handle_moving_platforms(var_3);
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 setModel("tag_origin");
  var_1 linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread snapshot_grenade_cleanup_mover(var_1);
  waitframe();
  var_5 = undefined;

  if(istrue(var_1.ref_13BFF)) {
    thread nukeplayer();
  }

  var_6 = (0, 0, 1);
  var_7 = snapshot_get_flight_dest(var_0, var_6, [var_1, var_2]);
  var_8 = vectordot(var_7 - var_0, var_6);
  var_9 = (0, 0, 0);

  if(var_8 > 0) {
    var_10 = var_8 / 112;
    var_11 = 0.65 * var_10;
    var_12 = var_11 * 0.19;
    var_13 = var_11 * 0.6;
    var_14 = 0.3 * var_10;
    var_15 = var_11 * 0;
    var_16 = var_11 * 0.35;
    var_4 rotateTo(var_9, var_14, var_15, var_16);

    if(isDefined(var_1.wam_number_of_failures)) {
      var_5 = _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_1.wam_number_of_failures);

      if(var_5) {
        var_4 linkTo(var_1.wam_number_of_failures);
      }
    }

    wait 0.3;

    if(istrue(var_5)) {
      var_4 unlink();
      var_7 += var_1.velocity * var_11;
    }

    var_1 setscriptablepartstate("dust", "active", 0);
    var_1 setscriptablepartstate("anims", "idle", 0);
    var_4 moveTo(var_7, var_11, var_12, var_13);
    var_1 childthread scripts\mp\utility\equipment::ref_14444();
    var_1 scripts\engine\utility::ref_143B9(var_11, "collision_with_platform");
  } else {
    var_4.angles = var_9;
    wait 0.3;
  }

  if(istrue(var_5)) {
    var_4 linkTo(var_1.wam_number_of_failures);
  }

  var_17 = 0;
  wait var_17;
  var_1 setscriptablepartstate("detect", "active", 0);
  var_1 setscriptablepartstate("anims", "idle", 0);
  var_1 setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  snapshot_grenade_detect(var_1);
  thread snapshot_grenade_destroy();
}

function snapshot_grenade_detect() {
  var_0 = self.owner;
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = ref_13436(var_0, var_1);
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_5 = scripts\mp\utility\game::unset_relic_grounded();
  var_6 = scripts\common\utility::playersinsphere(var_1, scripts\engine\utility::ter_op(var_5, 865, 540));
  var_7 = binocularsstate(var_1, scripts\engine\utility::ter_op(var_5, 865, 540));

  if(var_7.size) {
    var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  }

  foreach(var_9 in var_6) {
    if(!scripts\mp\utility\player::isreallyalive(var_9)) {
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_9)) {
      continue;
    }

    if(false) {
      var_10 = var_1;
      var_11 = var_9 getEye();
      var_12 = physics_raycast(var_10, var_11, var_4, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var_12) && var_12.size > 0) {
        continue;
      }
    }

    ref_13435(var_9, var_0, var_3);
  }

  if(true) {
    triggerportableradarping(var_1, var_0, scripts\engine\utility::ter_op(var_5, 865, 540), 500, "specialty_snapshot_immunity");
    return;
  }
}

function ref_13436(var_0, var_1) {
  var_2 = undefined;

  if(true) {
    var_2 = spawnStruct();
    var_2.owner = var_0;
    var_2.position = var_1;
    var_2.isalive = 1;
    var_2.targets = [];
    var_2.endtimes = [];
    var_2.outlineids = [];
  }

  return var_2;
}

function ref_13435(var_0, var_1, var_2) {
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("hittacresist");
    return;
  }

  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(true) {
    var_3 = scripts\mp\utility\game::unset_relic_grounded();
    var_4 = var_0 getentitynumber();
    var_2.targets[var_4] = var_0;
    var_2.endtimes[var_4] = gettime() + scripts\engine\utility::ter_op(var_3, 2000, 1250);

    if(!level.teambased) {
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "snapshotgrenade", "equipment");
    } else if(isDefined(var_1.squadindex)) {
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforsquad(var_0, var_1.team, var_1.squadindex, "snapshotgrenade", "equipment");
    } else {
      var_2.outlineids[var_4] = scripts\mp\utility\outline::outlineenableforteam(var_0, var_1.team, "snapshotgrenade", "equipment");
    }

    if(isPlayer(var_0) || isbot(var_0)) {
      var_0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("snapshotgrenade", 0);
      var_0 scripts\cp_mp\killstreaks\helper_drone::markeduion();
    }

    thread snapshot_grenade_update_outlines();
  }

  if(false) {
    thread snapshot_grenade_create_marker(var_1, var_0 gettagorigin("j_spineupper"), var_0.angles);
  }

  var_0.lastsnapshotgrenadetime = gettime();
  var_1 scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
  var_1 scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
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
  scripts\cp_mp\ent_manager::deregisterspawn();
  self endon("death");
  self.exploding = 1;
  self setCanDamage(0);

  if(isDefined(var_0)) {
    wait var_0;
  }

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

      if(var_4 >= scripts\mp\weapons::minegettwohitthreshold()) {
        var_6 += 1;
      }

      if(scripts\mp\utility\damage::isfmjdamage(var_2, var_3, 1)) {
        var_6 *= 2;
      }

      var_4 = var_6 * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_4;
}

function snapshot_grenade_handle_fatal_damage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(var_1) && scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_0.objweapon);
  }

  thread snapshot_grenade_destroy();
}

function snapshot_grenade_empapplied(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }

  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
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
    foreach(var_4, var_1 in self.targets) {
      var_1 = self.targets[var_4];
      var_2 = self.endtimes[var_4];
      var_3 = self.outlineids[var_4];

      if(!isDefined(var_1) || !scripts\mp\utility\player::isreallyalive(var_1) || gettime() >= var_2) {
        scripts\mp\utility\outline::outlinedisable(var_3, var_1);

        if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1))) {
          var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
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

  foreach(var_1 in self.targets) {
    var_1 = self.targets[var_3];
    var_2 = self.outlineids[var_3];
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1))) {
      var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
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
  snapshot_grenade_watch_marker_end_early(var_3, self, 3000, var_2, 1250);

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function snapshot_grenade_watch_marker_end_early(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  var_4 = gettime() + var_1;
  var_5 = scripts\engine\utility::ter_op(1, gettime() + 1250, undefined);

  while(var_4 > gettime()) {
    if(isDefined(var_5)) {
      if(var_5 < gettime()) {
        self unlink();
        var_5 = undefined;
      } else if(!isDefined(var_2)) {
        self unlink();
        var_5 = undefined;
      } else if(!scripts\mp\utility\player::isreallyalive(var_2)) {
        self unlink();
        var_5 = undefined;
      }
    }

    waitframe();
  }
}

function binocularsstate(var_0, var_1) {
  var_2 = binocularsstruct(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4) {
      var_3 = var_6;
    }
  }

  return var_3;
}

function binocularsstruct(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_actor"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
}

function removespawnselections() {
  return 3000;
}