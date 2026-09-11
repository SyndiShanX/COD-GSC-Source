/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_claymore.gsc
***********************************************/

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore.vfx");
}

function claymore_use(var0) {
  self endon("death");
  self endon("disconnect");
  var0 endon("death");
  var0.exploding = 1;
  var0.ref_121ac = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  var1 = spawnStruct();
  var1.throwspeedforward = 100;
  var1.throwspeedup = -50;
  var1.castdivisions = 3;
  var1.castmaxtime = 0.5;
  var1.castdetail = 1;
  var1.plantmaxtime = 0.5;
  var1.plantmaxroll = 15;
  var1.plantmindistbeloweye = 12;
  var1.plantmaxdistbelowownerfeet = 20;
  var1.plantmindisteyetofeet = 45;
  var1.plantnormalcos = 0.342;
  var1.plantoffsetz = 3;
  var2 = scripts\cp\cp_equipment::plant(var0, var1);

  if(!istrue(var2)) {
    var0.owner notify("pickup_equipment", var0.weapon_name);
    self setweaponammoclip(var0.weapon_obj, self.powers["power_claymore"].charges + 1);
    var0 delete();
    return;
  }

  var3 = var0 getlinkedparent();

  if(isDefined(var3)) {
    var0 scripts\cp\cp_weapon::explosivehandlemovers(var3);
  }

  var0.exploding = 0;
  thread claymore_plant();
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self.owner endon("disconnect");
  }

  var0 = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    var0 scripts\cp\cp_weapon::onlethalequipmentplanted(self, "claymore_mp");
    thread scripts\cp\cp_weapon::monitordisownedequipment(var0, self);
  } else {
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);
  }

  self missilethermal();
  self missileoutline();

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self setentityowner(var0);
    self setotherent(var0);
  }

  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread scripts\cp\cp_weapon::minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  var0 setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  wait 1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var0 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    self waittill("trigger_grenade", var1);

    foreach(var3 in var1) {
        if(!isalive(var3)) {
          continue;
        }

        if(var3.classname == "script_vehicle") {
          if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var3, self)) {
            continue;
          }

          scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var3, self);
          break;
        }

        if(var3.classname == "agent" || var3.classname == "player") {
          if(!isPlayer(var3) && !isagent(var3)) {
            continue;
          }

          var4 = anglesToForward(self.angles);
          var5 = anglestoup(self.angles);
          var6 = self.origin + var5 * 0;
          var7 = get_mine_ignore_list();
          var8 = var3 gettagorigin("j_mainroot");
          var9 = [var8];
          var10 = var6 - var8;

          if(vectordot(var10, (0, 0, 1)) >= 0) {
            var9 = var3 gettagorigin("j_spineupper");
          } else {
            var9 = var3.origin + (0, 0, 0.125);
          }

          var11 = 0;

          foreach(var13 in var9) {
            var10 = var13 - self.origin;
            var14 = vectordot(var10, var4);

            if(var14 > 192) {
              continue;
            }

            var15 = vectordot(var10, var5);

            if(abs(var15) > 32) {
              continue;
            }

            var16 = vectorNormalize(var10);
            var17 = vectordot(var16, var4);

            if(var17 < 0.86602) {
              continue;
            }

            var18 = physics_raycast(var6, var13, var0, var7, 0, "physicsquery_closest", 1);

            if(isDefined(var18) && var18.size > 0) {
              continue;
            }

            var11 = 1;
            thread claymore_trigger(var3);
          }

          if(var11) {
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
  var0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var2 in level.dynamicladders) {
      var0 = var2.ents[0];
    }
  }

  var4 = self getlinkedchildren(1);

  if(!isDefined(var4)) {
    var4 = [];
  }

  GscBinSkip0(0x2e, var4.size, self getlinkedparent());
}

function claymore_trigger(var0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\cp\cp_weapon::explosivetrigger(var0, 0.3);
  thread claymore_explode(self.owner);
}

function claymore_explode(var0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(self.owner) && isDefined(var1.plantedlethalequip)) {
    var1.plantedlethalequip = scripts\engine\utility::array_remove(var1.plantedlethalequip, self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var2 = anglestoup(self.angles);
  var3 = -1 * anglestoright(self.angles);
  var4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, var2, var4);
  level notify("grenade_exploded_during_stealth", self.origin, "claymore_mp", self.ref_121ac);
  self detonate();
}

function claymore_explodeonnotify() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");
  self waittill("detonateExplosive", var0);
  thread claymore_explode(var0);
}

function claymore_destroy(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  thread claymore_delete(var0 + 0.2);
  wait var0;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_destroyonemp() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", var0);
    var1 = var0.attacker;

    if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
      var1 notify("destroyed_equipment");
      var2 = "";

      if(istrue(self.hasruggedeqp)) {
        var2 = "hitequip";
      }

      thread claymore_destroy();
    }
  }
}

function claymore_delete(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
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
  var1 = self.owner;

  if(isDefined(self.owner)) {
    var1.plantedlethalequip = scripts\engine\utility::array_remove(var1.plantedlethalequip, self);
  }

  wait var0;
  self delete();
}

function claymore_modifieddamage(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    return var4;
  }

  if(nullweapon(var1)) {
    return var4;
  }

  if(var1 != getcompleteweaponname("claymore_mp")) {
    return var4;
  }

  if(!isexplosivedamagemod(var3)) {
    return var4;
  }

  var5 = distance2d(var2.origin, var0.origin);
  var6 = 1 - clamp((var5 - 75) / 181, 0, 1);
  var4 = 70 + 70 * var6;
  return var4;
}

function remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var0 = &"PERKS/REMOTE_DEFUSE_HINT";
  var1 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, var0, var1, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var3 in level.players) {
    self.useobj disableplayeruse(var3);
  }

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", var3);

    if(isPlayer(var3)) {
      thread claymore_trigger(var3);
    }
  }
}

function defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(var1 in level.players) {
      self.useobj enableplayeruse(var1);
    }
  }
}

function defusethink() {
  self endon("restarting_physics");
  var0 = self.useobj;
  var1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var0)) LOC_00000022;
  return;
}