/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_claymore.gsc
***********************************************/

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore.vfx");
}

function claymore_use(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_0.exploding = 1;
  var_0.ref_121AC = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_1 = spawnStruct();
  var_1.throwspeedforward = 100;
  var_1.throwspeedup = -50;
  var_1.castdivisions = 3;
  var_1.castmaxtime = 0.5;
  var_1.castdetail = 1;
  var_1.plantmaxtime = 0.5;
  var_1.plantmaxroll = 15;
  var_1.plantmindistbeloweye = 12;
  var_1.plantmaxdistbelowownerfeet = 20;
  var_1.plantmindisteyetofeet = 45;
  var_1.plantnormalcos = 0.342;
  var_1.plantoffsetz = 3;
  var_2 = scripts\cp\cp_equipment::plant(var_0, var_1);

  if(!istrue(var_2)) {
    var_0.owner notify("pickup_equipment", var_0.weapon_name);
    self setweaponammoclip(var_0.weapon_obj, self.powers["power_claymore"].charges + 1);
    var_0 delete();
    return;
  }

  var_3 = var_0 getlinkedparent();

  if(isDefined(var_3)) {
    var_0 scripts\cp\cp_weapon::explosivehandlemovers(var_3);
  }

  var_0.exploding = 0;
  thread claymore_plant();
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self.owner endon("disconnect");
  }

  var_0 = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    var_0 scripts\cp\cp_weapon::onlethalequipmentplanted(self, "claymore_mp");
    thread scripts\cp\cp_weapon::monitordisownedequipment(var_0, self);
  } else {
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);
  }

  self missilethermal();
  self missileoutline();

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self setentityowner(var_0);
    self setotherent(var_0);
  }

  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread scripts\cp\cp_weapon::minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  var_0 setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  wait 1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_0 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    self waittill("trigger_grenade", var_1);

    foreach(var_3 in var_1) {
        if(!isalive(var_3)) {
          continue;
        }

        if(var_3.classname == "script_vehicle") {
          if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var_3, self)) {
            continue;
          }

          scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var_3, self);
          break;
        }

        if(var_3.classname == "agent" || var_3.classname == "player") {
          if(!isPlayer(var_3) && !isagent(var_3)) {
            continue;
          }

          var_4 = anglesToForward(self.angles);
          var_5 = anglestoup(self.angles);
          var_6 = self.origin + var_5 * 0;
          var_7 = get_mine_ignore_list();
          var_8 = var_3 gettagorigin("j_mainroot");
          var_9 = [var_8];
          var_10 = var_6 - var_8;

          if(vectordot(var_10, (0, 0, 1)) >= 0) {
            var_9 = var_3 gettagorigin("j_spineupper");
          } else {
            var_9 = var_3.origin + (0, 0, 0.125);
          }

          var_11 = 0;

          foreach(var_13 in var_9) {
            var_10 = var_13 - self.origin;
            var_14 = vectordot(var_10, var_4);

            if(var_14 > 192) {
              continue;
            }

            var_15 = vectordot(var_10, var_5);

            if(abs(var_15) > 32) {
              continue;
            }

            var_16 = vectorNormalize(var_10);
            var_17 = vectordot(var_16, var_4);

            if(var_17 < 0.86602) {
              continue;
            }

            var_18 = physics_raycast(var_6, var_13, var_0, var_7, 0, "physicsquery_closest", 1);

            if(isDefined(var_18) && var_18.size > 0) {
              continue;
            }

            var_11 = 1;
            thread claymore_trigger(var_3);
          }

          if(var_11) {
            break;
          }
        }
      }

      <
      error > = undefined; <
    error > = undefined;
  }
}

function get_mine_ignore_list() {
  var_0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var_2 in level.dynamicladders) {
      var_0 = var_2.ents[0];
    }
  }

  var_4 = self getlinkedchildren(1);

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  GscBinSkip0(0x2e, var_4.size, self getlinkedparent());
}

function claymore_trigger(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\cp\cp_weapon::explosivetrigger(var_0, 0.3);
  thread claymore_explode(self.owner);
}

function claymore_explode(var_0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && isDefined(var_1.plantedlethalequip)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_2 = anglestoup(self.angles);
  var_3 = -1 * anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, var_2, var_4);
  level notify("grenade_exploded_during_stealth", self.origin, "claymore_mp", self.ref_121AC);
  self detonate();
}

function claymore_explodeonnotify() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");
  self waittill("detonateExplosive", var_0);
  thread claymore_explode(var_0);
}

function claymore_destroy(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread claymore_delete(var_0 + 0.2);
  wait var_0;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_destroyonemp() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", var_0);
    var_1 = var_0.attacker;

    if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
      var_1 notify("destroyed_equipment");
      var_2 = "";

      if(istrue(self.hasruggedeqp)) {
        var_2 = "hitequip";
      }

      thread claymore_destroy();
    }
  }
}

function claymore_delete(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self notify("death");

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
  }

  wait var_0;
  self delete();
}

function claymore_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return var_4;
  }

  if(nullweapon(var_1)) {
    return var_4;
  }

  if(var_1 != getcompleteweaponname("claymore_mp")) {
    return var_4;
  }

  if(!isexplosivedamagemod(var_3)) {
    return var_4;
  }

  var_5 = distance2d(var_2.origin, var_0.origin);
  var_6 = 1 - clamp((var_5 - 75) / 181, 0, 1);
  var_4 = 70 + 70 * var_6;
  return var_4;
}

function remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = &"PERKS/REMOTE_DEFUSE_HINT";
  var_1 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, var_0, var_1, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var_3 in level.players) {
    self.useobj disableplayeruse(var_3);
  }

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", var_3);

    if(isPlayer(var_3)) {
      thread claymore_trigger(var_3);
    }
  }
}

function defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(var_1 in level.players) {
      self.useobj enableplayeruse(var_1);
    }
  }
}

function defusethink() {
  self endon("restarting_physics");
  var_0 = self.useobj;
  var_1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var_0)) LOC_00000022;
  return;
}