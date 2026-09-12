/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\claymore.gsc
***********************************************/

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore.vfx");

  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_claymore", 1);
  var_0.triggercallback = &claymore_triggerfromvehicle;
}

function claymore_use(var_0) {
  self endon("death_or_disconnect");
  var_0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0.hasruggedeqp = 1;
  }

  var_0.exploding = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);

  if(isDefined(scripts\cp_mp\utility\player_utility::getvehicle())) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    waitframe();
    var_0 delete();
  }

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

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124F5()) {
    var_1.plantoffsetz += 2;
    var_1.contents = init_mine_caves();
  }

  var_2 = scripts\mp\utility\equipment::plant(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    var_0 delete();
    return;
  }

  var_3 = var_0 getlinkedparent();

  if(isDefined(var_3)) {
    var_0 scripts\mp\weapons::explosivehandlemovers(var_3);
  }

  var_0.exploding = 0;
  thread claymore_plant();
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_0 = self.owner;
  var_1 = self.owner.team;
  scripts\cp_mp\ent_manager::registerspawn(1, &sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0, 1);
  thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var_0 scripts\mp\weapons::onequipmentplanted(self, "equip_claymore", &claymore_delete);
  thread scripts\mp\weapons::monitordisownedequipment(var_0, self);
  self missilethermal();
  self missileoutline();
  self setentityowner(var_0);
  self setotherent(var_0);
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread scripts\mp\weapons::minedamagemonitor();
  thread claymore_explodeonnotify();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&claymore_empapplied);
  claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  var_0 setscriptablepartstate("equipClaymoreFXView", "plant", 0);
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
  var_0 = gettime() + 2000;

  while(var_0 > gettime()) {
    var_1 = (0, self.angles[1], 0);
    var_2 = 15;
    self.angles = anglelerpquat(var_1, self.angles, var_2);
    waitframe();
  }
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_0 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky"]);

  for(;;) {
    self waittill("trigger_grenade", var_1);

    if(istrue(self.stunned)) {
      continue;
    }

    foreach(var_3 in var_1) {
        if(isDefined(var_3.classname)) {
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

            if(var_3 scripts\mp\gametypes\br_public::ref_125EC()) {
              continue;
            }

            var_4 = anglesToForward(self.angles);
            var_5 = anglestoup(self.angles);
            var_6 = self.origin + var_5 * 0;
            var_7 = scripts\mp\utility\equipment::get_mine_ignore_list();
            var_8 = var_3 gettagorigin("j_mainroot");
            var_9 = [var_8];
            var_10 = var_6 - var_8;

            if(vectordot(var_10, (0, 0, 1)) >= 0) {
              var_9 = var_3 gettagorigin("j_spineupper");
            } else {
              var_9 = var_3.origin;
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
      }

      <
      error > = undefined; <
    error > = undefined;
  }
}

function claymore_trigger(var_0, var_1) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  } else {
    var_1 = self.owner;
  }

  self notify("mine_triggered");
  scripts\mp\utility\print::printgameaction("claymore triggered", self.owner);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::explosivetrigger(var_0, 0.3);
  thread claymore_explode(var_1);
}

function claymore_triggerfromvehicle(var_0, var_1) {
  var_1 endon("mine_destroyed");
  var_1 endon("death");
  var_1.owner endon("disconnect");
  var_1 notify("mine_triggered");
  var_1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var_1 setscriptablepartstate("arm", "neutral", 0);
  var_1 setscriptablepartstate("trigger", "active", 0);
  wait 0.1;
  thread claymore_explodefromvehicletrigger(var_1);
}

function claymore_explodefromvehicletrigger(var_0) {
  var_0 dodamage(160, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("claymore_mp"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("claymore_mp"), self, "MOD_EXPLOSIVE");
  thread claymore_explode();
  waitframe();

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
    return;
  }
}

function claymore_explode(var_0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\mp\weapons::makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1 scripts\mp\weapons::removeequip(self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_2 = anglestoup(self.angles);
  var_3 = -1 * anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, var_2, var_4);
  self radiusdamage(self.origin, 75, 100, 100, self.owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  self detonate(var_0);
}

function claymore_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);
  self.leadmarkers = var_1;
  thread claymore_explode(var_1);
}

function sweepclaymore() {
  claymore_destroy();
}

function claymore_destroy(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread claymore_delete(var_0 + 0.2);
  wait var_0;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_empapplied(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var_2 = "";

  if(istrue(self.hasruggedeqp)) {
    var_2 = "hitequip";
  }

  if(isPlayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_2);
  }

  thread claymore_destroy();
}

function claymore_delete(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
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

  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1 scripts\mp\weapons::removeequip(self);
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  self delete();
}

function claymore_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return var_4;
  }

  if(nullweapon(var_1)) {
    return var_4;
  }

  if(var_1 == getcompleteweaponname("claymore_mp")) {
    if(isDefined(self.handle_settings_for_techo_group)) {
      foreach(var_6 in self.handle_settings_for_techo_group) {
        if(isDefined(var_6) && var_6 == var_2) {
          return 0;
        }
      }
    }
  } else if(var_1 == getcompleteweaponname("claymore_radial_mp")) {
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner))) {
      return 0;
    }

    thread handle_ground_spawning(var_2);
  } else {
    return var_4;
  }

  if(!isexplosivedamagemod(var_3)) {
    return var_4;
  }

  var_8 = var_0.origin - var_2.origin;
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65) {
    return 0;
  }

  var_8 = var_2.origin - var_0 getEye();
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65) {
    return 0;
  }

  var_10 = anglesToForward(var_2.angles);
  var_10 = (var_10[0], var_10[1], 0);
  var_11 = var_0.origin - var_2.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectordot(var_10, var_11);

  if(var_12 < 0) {
    return 0;
  }

  var_9 = distance2d(var_2.origin, var_0.origin);
  var_13 = 1 - clamp((var_9 - 75) / 130, 0, 1);
  var_4 = 70 + 90 * var_13;

  if(isDefined(var_2.leadmarkers)) {
    var_14 = isDefined(var_2.owner) && var_2.leadmarkers == var_2.owner;
    var_15 = var_2.leadmarkers == var_0;

    if(!var_14 && var_15) {
      var_4 = min(var_4, 80);
    }
  }

  return var_4;
}

function handle_ground_spawning(var_0) {
  self endon("disconnect");
  self notify("claymore_blockDamageUntilFrameEnd");
  self endon("claymore_blockDamageUntilFrameEnd");

  if(!isDefined(self.handle_settings_for_techo_group)) {
    self.handle_settings_for_techo_group = [];
  }

  self.handle_settings_for_techo_group[self.handle_settings_for_techo_group.size] = var_0;
  waittillframeend();
  self.handle_settings_for_techo_group = undefined;
}

function claymore_onownerchanged(var_0) {
  self setscriptablepartstate("hacked", "active", 0);
  claymore_updatedangerzone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}

function handle_set_respawn_overrides(var_0) {
  self endon("death");

  if(isPlayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
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
  var_0 = ["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_playerclip"];
  return physics_createcontents(var_0);
}