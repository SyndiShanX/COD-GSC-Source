/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\claymore.gsc
***********************************************/

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore.vfx");

  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_claymore", 1);
  var0.triggercallback = &claymore_triggerfromvehicle;
}

function claymore_use(var0) {
  self endon("death_or_disconnect");
  var0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var0.hasruggedeqp = 1;
  }

  var0.exploding = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);

  if(isDefined(scripts\cp_mp\utility\player_utility::getvehicle())) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    waitframe();
    var0 delete();
  }

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

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124f5()) {
    var1.plantoffsetz += 2;
    var1.contents = init_mine_caves();
  }

  var2 = scripts\mp\utility\equipment::plant(var0, var1);

  if(!istrue(var2)) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    var0 delete();
    return;
  }

  var3 = var0 getlinkedparent();

  if(isDefined(var3)) {
    var0 scripts\mp\weapons::explosivehandlemovers(var3);
  }

  var0.exploding = 0;
  thread claymore_plant();
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var0 = self.owner;
  var1 = self.owner.team;
  scripts\cp_mp\ent_manager::registerspawn(1, &sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var0, 1);
  thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var0 scripts\mp\weapons::onequipmentplanted(self, "equip_claymore", &claymore_delete);
  thread scripts\mp\weapons::monitordisownedequipment(var0, self);
  self missilethermal();
  self missileoutline();
  self setentityowner(var0);
  self setotherent(var0);
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread scripts\mp\weapons::minedamagemonitor();
  thread claymore_explodeonnotify();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&claymore_empapplied);
  claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  var0 setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread handle_respawn_via_c130();
  wait 1;
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&claymore_trigger, 1, 1);
}

function claymore_updatedangerzone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function handle_respawn_via_c130() {
  self endon("mine_selfdestruct");
  self endon("death");
  var0 = gettime() + 2000;

  while(var0 > gettime()) {
    var1 = (0, self.angles[1], 0);
    var2 = 15;
    self.angles = anglelerpquat(var1, self.angles, var2);
    waitframe();
  }
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var0 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    self waittill("trigger_grenade", var1);

    if(istrue(self.stunned)) {
      continue;
    }

    foreach(var3 in var1) {
        if(isDefined(var3.classname)) {
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

            if(var3 scripts\mp\gametypes\br_public::ref_125ec()) {
              continue;
            }

            var4 = anglesToForward(self.angles);
            var5 = anglestoup(self.angles);
            var6 = self.origin + var5 * 0;
            var7 = scripts\mp\utility\equipment::get_mine_ignore_list();
            var8 = var3 gettagorigin("j_mainroot");
            var9 = [var8];
            var10 = var6 - var8;

            if(vectordot(var10, (0, 0, 1)) >= 0) {
              var9 = var3 gettagorigin("j_spineupper");
            } else {
              var9 = var3.origin;
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
      }

      <
      error > = undefined; <
    error > = undefined;
  }
}

function claymore_trigger(var0, var1) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var1)) {
    var1 endon("disconnect");
  } else {
    var1 = self.owner;
  }

  self notify("mine_triggered");
  scripts\mp\utility\print::printgameaction("claymore triggered", self.owner);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::explosivetrigger(var0, 0.3);
  thread claymore_explode(var1);
}

function claymore_triggerfromvehicle(var0, var1) {
  var1 endon("mine_destroyed");
  var1 endon("death");
  var1.owner endon("disconnect");
  var1 notify("mine_triggered");
  var1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var1 setscriptablepartstate("arm", "neutral", 0);
  var1 setscriptablepartstate("trigger", "active", 0);
  wait 0.1;
  thread claymore_explodefromvehicletrigger(var1);
}

function claymore_explodefromvehicletrigger(var0) {
  var0 dodamage(160, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("claymore_mp"));
  var1 = var0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("claymore_mp"), self, "MOD_EXPLOSIVE");
  thread claymore_explode();
  waitframe();

  if(isDefined(var0)) {
    var0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var1);
    return;
  }
}

function claymore_explode(var0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\mp\weapons::makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(self.owner)) {
    var1 scripts\mp\weapons::removeequip(self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var2 = anglestoup(self.angles);
  var3 = -1 * anglestoright(self.angles);
  var4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, var2, var4);
  self radiusdamage(self.origin, 75, 100, 100, self.owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  self detonate(var0);
}

function claymore_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var0 = self.owner;
  self waittill("detonateExplosive", var1);
  self.leadmarkers = var1;
  thread claymore_explode(var1);
}

function sweepclaymore() {
  claymore_destroy();
}

function claymore_destroy(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  thread claymore_delete(var0 + 0.2);
  wait var0;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_empapplied(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var2 = "";

  if(istrue(self.hasruggedeqp)) {
    var2 = "hitequip";
  }

  if(isPlayer(var1)) {
    var1 scripts\mp\damagefeedback::updatedamagefeedback(var2);
  }

  thread claymore_destroy();
}

function claymore_delete(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  self setscriptablepartstate("hack_usable", "off");
  self notify("death");
  scripts\cp_mp\ent_manager::deregisterspawn();
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  var1 = self.owner;

  if(isDefined(self.owner)) {
    var1 scripts\mp\weapons::removeequip(self);
  }

  if(isDefined(var0)) {
    wait var0;
  }

  self delete();
}

function claymore_modifieddamage(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    return var4;
  }

  if(nullweapon(var1)) {
    return var4;
  }

  if(var1 == getcompleteweaponname("claymore_mp")) {
    if(isDefined(self.handle_settings_for_techo_group)) {
      foreach(var6 in self.handle_settings_for_techo_group) {
        if(isDefined(var6) && var6 == var2) {
          return 0;
        }
      }
    }
  } else if(var1 == getcompleteweaponname("claymore_radial_mp")) {
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var0, var2.owner))) {
      return 0;
    }

    thread handle_ground_spawning(var2);
  } else {
    return var4;
  }

  if(!isexplosivedamagemod(var3)) {
    return var4;
  }

  var8 = var0.origin - var2.origin;
  var9 = vectordot(var8, anglestoup(var2.angles));

  if(var9 > 65) {
    return 0;
  }

  var8 = var2.origin - var0 getEye();
  var9 = vectordot(var8, anglestoup(var2.angles));

  if(var9 > 65) {
    return 0;
  }

  var10 = anglesToForward(var2.angles);
  var10 = (var10[0], var10[1], 0);
  var11 = var0.origin - var2.origin;
  var11 = (var11[0], var11[1], 0);
  var12 = vectordot(var10, var11);

  if(var12 < 0) {
    return 0;
  }

  var9 = distance2d(var2.origin, var0.origin);
  var13 = 1 - clamp((var9 - 75) / 130, 0, 1);
  var4 = 70 + 90 * var13;

  if(isDefined(var2.leadmarkers)) {
    var14 = isDefined(var2.owner) && var2.leadmarkers == var2.owner;
    var15 = var2.leadmarkers == var0;

    if(!var14 && var15) {
      var4 = min(var4, 80);
    }
  }

  return var4;
}

function handle_ground_spawning(var0) {
  self endon("disconnect");
  self notify("claymore_blockDamageUntilFrameEnd");
  self endon("claymore_blockDamageUntilFrameEnd");

  if(!isDefined(self.handle_settings_for_techo_group)) {
    self.handle_settings_for_techo_group = [];
  }

  self.handle_settings_for_techo_group[self.handle_settings_for_techo_group.size] = var0;
  waittillframeend();
  self.handle_settings_for_techo_group = undefined;
}

function claymore_onownerchanged(var0) {
  self setscriptablepartstate("hacked", "active", 0);
  claymore_updatedangerzone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}

function handle_set_respawn_overrides(var0) {
  self endon("death");

  if(isPlayer(var0)) {
    var0 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
  }

  self notify("claymore_stunned");
  self endon("claymore_stunned");
  self setscriptablepartstate("arm", "neutral", 0);
  self.stunned = 1;
  wait 3;
  self.stunned = 0;
  self setscriptablepartstate("arm", "active", 0);
}

function init_mine_caves() {
  var0 = ["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_playerclip"];
  return physics_createcontents(var0);
}