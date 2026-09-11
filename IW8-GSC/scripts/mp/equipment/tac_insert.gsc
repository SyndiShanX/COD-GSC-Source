/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tac_insert.gsc
***********************************************/

function tacinsert_init() {
  level.ref_13a10 = [];
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&ref_13a0a);

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread ref_13a02();
    return;
  }
}

function ref_13a0a(var_0) {
  foreach(var_2 in level.ref_13a10) {
    ref_13a0f(var_2, var_0);
    ref_13a0e(var_2, var_0);
  }
}

function ref_13a02() {
  level endon("game_ended");

  for(;;) {
    var_0 = level.ref_13a10;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(istrue(var_3.isdestroyed)) {
        continue;
      }

      if(!isDefined(var_3.owner)) {
        continue;
      }

      var_4 = distance2dsquared(var_3.origin, var_3.owner.origin);

      if(var_4 >= 144000000) {
        var_3.owner thread scripts\mp\hud_message::showsplash("tac_insert_fail_br_too_far");
        tacinsert_destroy(var_3, undefined, 0);
      }

      var_1++;

      if(var_1 >= 5) {
        var_1 = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

function tacinsert_set(var_0, var_1) {
  thread ref_13a09();
}

function tacinsert_unset(var_0, var_1) {
  self notify("end_monitorTIUse");
}

function ref_13a09() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  self.tispawnposition = [];

  for(;;) {
    tacinsert_updatespawnposition();
    var_0 = self getheldoffhand();
    var_1 = var_0.basename == "flare_mp";
    var_2 = scripts\engine\utility::ter_op(var_1, 0.05, 1);
    scripts\engine\utility::ref_143b9(var_2, "offhand_pullback");
  }
}

function ref_13a08(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 endon("end_monitorTIUse");
  var_0 endon("end_movingUpdate");

  for(;;) {
    wait 1;
    ref_13683(var_0, self, 1);
  }
}

function tacinsert_updatespawnposition() {
  var_0 = self.origin;
  var_1 = tacinsert_isvalidspawnposition(var_0);

  if(istrue(var_1)) {
    ref_13a01(var_0);
    return;
  }
}

function tacinsert_isvalidspawnposition(var_0) {
  var_1 = var_0 + (0, 0, 3);

  if(!canspawn(var_1)) {
    return false;
  }

  if(scripts\mp\outofbounds::istouchingoobtrigger()) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  waitframe();

  if(!self isonground()) {
    return false;
  }

  return true;
}

function ref_13a01(var_0) {
  if(isDefined(self.tispawnposition[0]) && self.tispawnposition[0] == var_0) {
    return;
  }

  self.tispawnposition[1] = self.tispawnposition[0];
  self.tispawnposition[0] = var_0;
}

function ref_13a07() {
  if(isDefined(self.tispawnposition)) {
    if(isDefined(self.tispawnposition[1])) {
      return self.tispawnposition[1];
    } else if(isDefined(self.tispawnposition[0])) {
      return self.tispawnposition[0];
    }
  }

  return undefined;
}

function deletetacinsert() {
  tacinsert_destroy();
}

function tacinsert_used(var_0) {
  var_0 delete();
  var_1 = ref_13a07();

  if(!isDefined(var_1)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  var_2 = distancesquared(self.origin, var_1);

  if(var_2 >= 14400) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  var_3 = var_1 + (0, 0, 16);
  var_4 = var_1 + (0, 0, -16);

  if(!ref_13a03(var_0, var_3, var_4)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  ref_13681(0, 0, 1);
  var_5 = [];
  GscBinSkip0(0x2e, 0, self);
}

function tacinsert_setupandwaitfordeath(var_0) {
  self.headicon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0);
  thread tacinsert_damagelistener(var_0);
  thread ref_13a05(var_0);

  if(!self.issuper) {
    thread ref_13a0b(var_0);
    return;
  }
}

function tacinsert_damagelistener(var_0) {
  scripts\mp\damage::monitordamage(10, "hitequip", &tacinsert_modifydamage, &tacinsert_handledeathdamage, 1);
}

function tacinsert_modifydamage(var_0) {
  var_1 = var_0.objweapon;
  var_2 = var_0.meansofdeath;
  return scripts\mp\damage::handlemeleedamage(var_1, var_2);
}

function tacinsert_handledeathdamage(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && var_1 != self.owner) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  thread tacinsert_destroy(var_1, 1);
}

function ref_13a0b(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self.ref_12357 = spawn("script_origin", self.origin);
  self.ref_12357 makeusable();
  self.ref_12357 setCursorHint("HINT_NOICON");
  self.ref_12357 setHintString(&"MP_PATCH/PICKUP_TI");
  self.ref_12357 linkTo(self);

  foreach(var_2 in level.players) {
    ref_13a0f(var_2);
  }

  for(;;) {
    self.ref_12357 waittill("trigger", var_2);
    var_2 playSound("iw8_tactical_insert_flare_pu");
    var_2 scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
    thread tacinsert_destroy(var_0, 0, 0, 1);
  }
}

function ref_13a0f(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self) || !isDefined(self.ref_12357)) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  var_1 = isDefined(self.owner) && var_0 == self.owner;

  if(var_1) {
    self.ref_12357 enableplayeruse(var_0);
    return;
  }

  self.ref_12357 disableplayeruse(var_0);
}

function tacinsert_destroy(var_0, var_1, var_2, var_3) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;

  if(isDefined(self.owner)) {
    if(istrue(var_2)) {
      thread ref_13a00();
      self.owner scripts\mp\utility\stats::incpersstat("tacticalInsertionSpawns", 1);
      self.owner scripts\mp\supers::hide_plunderboxes("super_tac_insert");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_insert", 1, var_0, var_1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 1, istrue(var_1));
    } else {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_insert", 0, var_0, var_1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 0, istrue(var_1));
    }

    if(!istrue(var_2) && !istrue(var_3)) {
      thread ref_13a0d();
    }

    self.owner.setspawnpoint = undefined;
  }

  self makeunusable();

  if(isDefined(self.ref_12357)) {
    self.ref_12357 delete();
  }

  self notify("death");

  if(!istrue(self.ref_133e3)) {
    self setscriptablepartstate("smoke", "neutral", 0);
  }

  if(istrue(var_1)) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread tacinsert_delayeddelete();
}

function ref_13a0d() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 0;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isinkillcam()) {
    var_0 = 1;
    waitframe();
  }

  if(var_0) {
    wait 0.3;
  }

  scripts\mp\damagefeedback::hudicontype("tacinsert_destroyed");
}

function ref_13a00() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_0 = self.owner;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  wait 1.5;
  var_0 thread scripts\mp\hud_message::showsplash("tac_insert_success_br");
}

function ref_13a04() {
  self endon("death");
  level waittill("game_ended");
  thread tacinsert_destroy(undefined, 0, 0, 1);
}

function tacinsert_delayeddelete() {
  wait 1;
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  scripts\mp\weapons::cleanupequipment(var_0, var_1, var_2);
  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function ref_13a05(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH/DESTROY_TI");

  foreach(var_2 in level.players) {
    ref_13a0e(var_2);
  }

  for(;;) {
    self waittill("trigger", var_2);
    var_2 notify("destroyed_insertion", var_0);
    var_2 notify("destroyed_equipment");
    tacinsert_givepointsfordeath(var_2);
    thread tacinsert_destroy(var_2, 1);
  }
}

function ref_13a0e(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  var_1 = scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0);

  if(var_1) {
    self enableplayeruse(var_0);
    return;
  }

  self disableplayeruse(var_0);
}

function tacinsert_empapplied(var_0) {
  var_1 = var_0.attacker;
  tacinsert_givepointsfordeath(var_1);

  if(isDefined(self.owner) && var_0.attacker != self.owner) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  thread tacinsert_destroy(var_1, 1);
}

function tacinsert_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\killstreaks\killstreaks::givescorefordestroyedtacinsert();
    var_0 thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
    return;
  }
}

function ref_13a03(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = self;
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);
  var_6 = scripts\engine\trace::sphere_trace(var_1, var_2, 20, var_4, var_5, 1);

  if(isDefined(var_6)) {
    if(isDefined(var_6["hittype"]) && var_6["hittype"] != "hittype_none") {
      var_7 = var_6["surfacetype"];

      if(isDefined(var_7) && var_7 != "surftype_none") {
        var_7 = var_6["surfacetype"];

        if(var_7 == "surftype_glass_pane") {
          var_3 = 0;
        }
      }

      var_8 = var_6["entity"];

      if(isDefined(var_8)) {
        if(var_8 scripts\cp_mp\vehicles\vehicle::isvehicle() && !_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_8)) {
          var_3 = 0;
        }

        var_9 = getdvarint("scr_br_tac_insert_moving_platform_valid", 1);

        if(!var_9 && (_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_8) || scripts\mp\gametypes\br_gondola::triggereliminatedoverlay(var_8))) {
          var_3 = 0;
        }

        if(isDefined(var_8.classname)) {
          switch (var_8.classname) {
            case "grenade":
            case "misc_turret":
              var_3 = 0;
              break;
            case "script_model":
              if(isDefined(var_8.crate)) {
                var_3 = 0;
              }

              break;
          }
        }
      }
    }
  }

  return istrue(var_3);
}

function ref_13a0c() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getdvarint("scr_tac_insert_refund", 1);

  if(var_0 == 0) {
    return;
  }

  if(istrue(level.unset_relic_laststandmelee)) {
    if(level.infectedtactical == "equip_tac_insert") {
      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    }

    var_1 = scripts\engine\utility::ref_143b9(5, "super_use_finished_lb");

    if(isDefined(var_1) && var_1 == "super_use_finished_lb") {
      thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }

    return;
  }

  self waittill("super_use_finished_lb");
  thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
}

function ref_13684(var_0, var_1, var_2, var_3) {
  ref_13681();
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = spawn("script_model", var_0);
  }

  var_4.playerspawnpos = var_0;
  var_4.playerspawnangles = var_1;
  var_4.notti = !istrue(var_3);
  var_4.issuper = isDefined(var_2) && istrue(var_2.issuper);
  self.setspawnpoint = var_4;
}

function ref_13681(var_0, var_1, var_2) {
  if(isDefined(self.setspawnpoint)) {
    if(istrue(self.setspawnpoint.notti)) {
      self.setspawnpoint delete();
      return;
    }

    tacinsert_destroy(self.setspawnpoint, undefined, var_0, var_1, var_2);
    return;
  }
}

function ref_13683(var_0, var_1) {
  if(!isDefined(var_0)) {
    self notify("end_movingUpdate");
    return;
  }

  var_2 = var_0;
  var_2.playerspawnpos = var_0.origin;
  var_2.playerspawnangles = var_0.angles;
  var_2.notti = !istrue(var_1);
  var_2.issuper = isDefined(var_0) && istrue(var_0.issuper);
  self.setspawnpoint = var_2;
}