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

function ref_13a0a(var0) {
  foreach(var2 in level.ref_13a10) {
    ref_13a0f(var2, var0);
    ref_13a0e(var2, var0);
  }
}

function ref_13a02() {
  level endon("game_ended");

  for(;;) {
    var0 = level.ref_13a10;
    var1 = 0;

    foreach(var3 in var0) {
      if(!isDefined(var3)) {
        continue;
      }

      if(istrue(var3.isdestroyed)) {
        continue;
      }

      if(!isDefined(var3.owner)) {
        continue;
      }

      var4 = distance2dsquared(var3.origin, var3.owner.origin);

      if(var4 >= 144000000) {
        var3.owner thread scripts\mp\hud_message::showsplash("tac_insert_fail_br_too_far");
        tacinsert_destroy(var3, undefined, 0);
      }

      var1++;

      if(var1 >= 5) {
        var1 = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

function tacinsert_set(var0, var1) {
  thread ref_13a09();
}

function tacinsert_unset(var0, var1) {
  self notify("end_monitorTIUse");
}

function ref_13a09() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  self.tispawnposition = [];

  for(;;) {
    tacinsert_updatespawnposition();
    var0 = self getheldoffhand();
    var1 = var0.basename == "flare_mp";
    var2 = scripts\engine\utility::ter_op(var1, 0.05, 1);
    scripts\engine\utility::ref_143b9(var2, "offhand_pullback");
  }
}

function ref_13a08(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  var0 endon("end_monitorTIUse");
  var0 endon("end_movingUpdate");

  for(;;) {
    wait 1;
    ref_13683(var0, self, 1);
  }
}

function tacinsert_updatespawnposition() {
  var0 = self.origin;
  var1 = tacinsert_isvalidspawnposition(var0);

  if(istrue(var1)) {
    ref_13a01(var0);
    return;
  }
}

function tacinsert_isvalidspawnposition(var0) {
  var1 = var0 + (0, 0, 3);

  if(!canspawn(var1)) {
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

function ref_13a01(var0) {
  if(isDefined(self.tispawnposition[0]) && self.tispawnposition[0] == var0) {
    return;
  }

  self.tispawnposition[1] = self.tispawnposition[0];
  self.tispawnposition[0] = var0;
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

function tacinsert_used(var0) {
  var0 delete();
  var1 = ref_13a07();

  if(!isDefined(var1)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  var2 = distancesquared(self.origin, var1);

  if(var2 >= 14400) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  var3 = var1 + (0, 0, 16);
  var4 = var1 + (0, 0, -16);

  if(!ref_13a03(var0, var3, var4)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread ref_13a0c();
    return false;
  }

  ref_13681(0, 0, 1);
  var5 = [];
  GscBinSkip0(0x2e, 0, self);
}

function tacinsert_setupandwaitfordeath(var0) {
  self.headicon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0);
  thread tacinsert_damagelistener(var0);
  thread ref_13a05(var0);

  if(!self.issuper) {
    thread ref_13a0b(var0);
    return;
  }
}

function tacinsert_damagelistener(var0) {
  scripts\mp\damage::monitordamage(10, "hitequip", &tacinsert_modifydamage, &tacinsert_handledeathdamage, 1);
}

function tacinsert_modifydamage(var0) {
  var1 = var0.objweapon;
  var2 = var0.meansofdeath;
  return scripts\mp\damage::handlemeleedamage(var1, var2);
}

function tacinsert_handledeathdamage(var0) {
  var1 = var0.attacker;

  if(isDefined(self.owner) && var1 != self.owner) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  thread tacinsert_destroy(var1, 1);
}

function ref_13a0b(var0) {
  self endon("death");
  level endon("game_ended");
  var0 endon("disconnect");
  self.ref_12357 = spawn("script_origin", self.origin);
  self.ref_12357 makeusable();
  self.ref_12357 setCursorHint("HINT_NOICON");
  self.ref_12357 setHintString(&"MP_PATCH/PICKUP_TI");
  self.ref_12357 linkTo(self);

  foreach(var2 in level.players) {
    ref_13a0f(var2);
  }

  for(;;) {
    self.ref_12357 waittill("trigger", var2);
    var2 playSound("iw8_tactical_insert_flare_pu");
    var2 scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
    thread tacinsert_destroy(var0, 0, 0, 1);
  }
}

function ref_13a0f(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self) || !isDefined(self.ref_12357)) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  var1 = isDefined(self.owner) && var0 == self.owner;

  if(var1) {
    self.ref_12357 enableplayeruse(var0);
    return;
  }

  self.ref_12357 disableplayeruse(var0);
}

function tacinsert_destroy(var0, var1, var2, var3) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;

  if(isDefined(self.owner)) {
    if(istrue(var2)) {
      thread ref_13a00();
      self.owner scripts\mp\utility\stats::incpersstat("tacticalInsertionSpawns", 1);
      self.owner scripts\mp\supers::hide_plunderboxes("super_tac_insert");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_insert", 1, var0, var1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 1, istrue(var1));
    } else {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_tac_insert", 0, var0, var1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 0, istrue(var1));
    }

    if(!istrue(var2) && !istrue(var3)) {
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

  if(istrue(var1)) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread tacinsert_delayeddelete();
}

function ref_13a0d() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = 0;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isinkillcam()) {
    var0 = 1;
    waitframe();
  }

  if(var0) {
    wait 0.3;
  }

  scripts\mp\damagefeedback::hudicontype("tacinsert_destroyed");
}

function ref_13a00() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var0 = self.owner;
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  wait 1.5;
  var0 thread scripts\mp\hud_message::showsplash("tac_insert_success_br");
}

function ref_13a04() {
  self endon("death");
  level waittill("game_ended");
  thread tacinsert_destroy(undefined, 0, 0, 1);
}

function tacinsert_delayeddelete() {
  wait 1;
  var0 = self getentitynumber();
  var1 = self.killcament;
  var2 = self.trigger;
  scripts\mp\weapons::cleanupequipment(var0, var1, var2);
  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function ref_13a05(var0) {
  self endon("death");
  level endon("game_ended");
  var0 endon("disconnect");
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH/DESTROY_TI");

  foreach(var2 in level.players) {
    ref_13a0e(var2);
  }

  for(;;) {
    self waittill("trigger", var2);
    var2 notify("destroyed_insertion", var0);
    var2 notify("destroyed_equipment");
    tacinsert_givepointsfordeath(var2);
    thread tacinsert_destroy(var2, 1);
  }
}

function ref_13a0e(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isdestroyed)) {
    return;
  }

  var1 = scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0);

  if(var1) {
    self enableplayeruse(var0);
    return;
  }

  self disableplayeruse(var0);
}

function tacinsert_empapplied(var0) {
  var1 = var0.attacker;
  tacinsert_givepointsfordeath(var1);

  if(isDefined(self.owner) && var0.attacker != self.owner) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }

  thread tacinsert_destroy(var1, 1);
}

function tacinsert_givepointsfordeath(var0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");
    var0 thread scripts\mp\killstreaks\killstreaks::givescorefordestroyedtacinsert();
    var0 thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
    return;
  }
}

function ref_13a03(var0, var1, var2) {
  var3 = 1;
  var4 = self;
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);
  var6 = scripts\engine\trace::sphere_trace(var1, var2, 20, var4, var5, 1);

  if(isDefined(var6)) {
    if(isDefined(var6["hittype"]) && var6["hittype"] != "hittype_none") {
      var7 = var6["surfacetype"];

      if(isDefined(var7) && var7 != "surftype_none") {
        var7 = var6["surfacetype"];

        if(var7 == "surftype_glass_pane") {
          var3 = 0;
        }
      }

      var8 = var6["entity"];

      if(isDefined(var8)) {
        if(var8 scripts\cp_mp\vehicles\vehicle::isvehicle() && !_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var8)) {
          var3 = 0;
        }

        var9 = getdvarint("scr_br_tac_insert_moving_platform_valid", 1);

        if(!var9 && (_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var8) || scripts\mp\gametypes\br_gondola::triggereliminatedoverlay(var8))) {
          var3 = 0;
        }

        if(isDefined(var8.classname)) {
          switch (var8.classname) {
            case "grenade":
            case "misc_turret":
              var3 = 0;
              break;
            case "script_model":
              if(isDefined(var8.crate)) {
                var3 = 0;
              }

              break;
          }
        }
      }
    }
  }

  return istrue(var3);
}

function ref_13a0c() {
  self endon("disconnect");
  level endon("game_ended");
  var0 = getdvarint("scr_tac_insert_refund", 1);

  if(var0 == 0) {
    return;
  }

  if(istrue(level.unset_relic_laststandmelee)) {
    if(level.infectedtactical == "equip_tac_insert") {
      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    }

    var1 = scripts\engine\utility::ref_143b9(5, "super_use_finished_lb");

    if(isDefined(var1) && var1 == "super_use_finished_lb") {
      thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }

    return;
  }

  self waittill("super_use_finished_lb");
  thread scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
}

function ref_13684(var0, var1, var2, var3) {
  ref_13681();
  var4 = undefined;

  if(isDefined(var2)) {
    var4 = var2;
  } else {
    var4 = spawn("script_model", var0);
  }

  var4.playerspawnpos = var0;
  var4.playerspawnangles = var1;
  var4.notti = !istrue(var3);
  var4.issuper = isDefined(var2) && istrue(var2.issuper);
  self.setspawnpoint = var4;
}

function ref_13681(var0, var1, var2) {
  if(isDefined(self.setspawnpoint)) {
    if(istrue(self.setspawnpoint.notti)) {
      self.setspawnpoint delete();
      return;
    }

    tacinsert_destroy(self.setspawnpoint, undefined, var0, var1, var2);
    return;
  }
}

function ref_13683(var0, var1) {
  if(!isDefined(var0)) {
    self notify("end_movingUpdate");
    return;
  }

  var2 = var0;
  var2.playerspawnpos = var0.origin;
  var2.playerspawnangles = var0.angles;
  var2.notti = !istrue(var1);
  var2.issuper = isDefined(var0) && istrue(var0.issuper);
  self.setspawnpoint = var2;
}