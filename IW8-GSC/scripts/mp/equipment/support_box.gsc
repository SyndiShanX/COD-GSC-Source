/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\support_box.gsc
************************************************/

function supportbox_init() {
  level.brking_watchcircletimers = [];
  scripts\common\interactive::interactive_addusedcallback(&supportbox_usedcallback, "equip_supportBox");
  scripts\common\interactive::interactive_addusedcallback(&calloutmarkerpingvo_playpredictivepingcleared, "equip_armorBox");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&ref_139B1);
  level._effect["vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx"] = loadfx("vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx");
  level._effect["vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx"] = loadfx("vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx");
}

function ref_139B1(var_0) {
  foreach(var_2 in level.brking_watchcircletimers) {
    if(isDefined(var_2)) {
      ref_139AF(var_2, var_0);
    }
  }
}

function debug_reach_exhaust_waste(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  thread supportbox_watchdisownedtimeout();
  thread supportbox_hideandshowaftertime();
  thread ref_139B2(var_0);
  jumpiftrue(scripts\mp\flags::gameflag("prematch_fade_done")) LOC_00000037;
  thread ref_139B3();
  var_0 waittill("missile_stuck", var_4);
  var_0 setnodeploy(1);
  supportbox_handlemovingplatforms(var_0, var_4);

  if(true) {
    thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  }

  var_0.issuper = 1;
  var_0.superid = level.superglobals.staticsuperdata[var_2].id;
  scripts\mp\weapons::onequipmentplanted(var_0, var_1, &supportbox_destroy);
  level.brking_watchcircletimers[var_0 getentitynumber()] = var_0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&supportbox_empapplied);

  if(!istrue(var_0.madedamageable)) {
    supportbox_makedamageable(var_0);
  }

  var_0.makedamageable = undefined;
  var_0 setscriptablepartstate("visibility", "show", 0);
  wait 0;

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    supportbox_addheadicon(var_0, var_3);
  }

  wait 0.75;
  var_0 setscriptablepartstate("effects", "plant", 0);
  var_0 setscriptablepartstate("anims", "open", 0);
  wait supportbox_getdeployanimduration();
  var_0 setscriptablepartstate("beacon", "active", 0);
  var_0 setscriptablepartstate("anims", "openIdle", 0);
}

function ref_139B2(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 endon("disconnect");
  var_1 = scripts\engine\utility::ref_143B9(2, "touching_platform");

  if(var_1 == "timeout") {
    return;
  }

  var_2 = undefined;
  var_3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var_3.size, self);
}

function ref_139B3() {
  self endon("death");
  self endon("missile_stuck");
  level waittill("prematch_cleanup");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function tugofwar_tank(var_0) {
  if(isDefined(level.ref_145F1)) {
    foreach(var_2 in level.ref_145F1.ref_13C8D) {
      if(var_2 == var_0) {
        return true;
      }

      if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0) {
        return true;
      }
    }
  }

  return false;
}

function supportbox_used(var_0) {
  var_0 endon("death");
  var_0.ref_13B87 = "vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx";
  debug_reach_exhaust_waste(var_0, "equip_supportBox", "super_ammo_drop", "hud_icon_equipment_support_box");
  thread supportbox_makeusable(var_0, "equip_supportBox");
}

function calloutmarkerpingvo_playpredictivepingadded(var_0) {
  var_0 endon("death");
  var_0.ref_13B87 = "vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx";
  debug_reach_exhaust_waste(var_0, "equip_armorBox", "super_armor_drop", "ui_mp_br_loot_icon_health_armor_box");
  thread supportbox_makeusable(var_0, "equip_armorBox");
}

function supportbox_hideandshowaftertime(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_1 = getdvarfloat("scr_support_box_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var_1;
  self.madedamageable = 1;
  supportbox_makedamageable();
  self setscriptablepartstate("visibility", "show", 0);
}

function supportbox_unset() {
  if(false) {
    foreach(var_1 in self.plantedsuperequip) {
      if(var_1.equipmentref == "equip_supportBox" || var_1.equipmentref == "equip_armorBox") {
        thread supportbox_destroy();
        scripts\mp\weapons::removeequip(var_1);
      }
    }

    return;
  }
}

function supportbox_explode(var_0, var_1) {
  self notify("box_explode");

  if(isDefined(var_0) || isDefined(self.owner)) {
    self clearscriptabledamageowner();

    if(isDefined(var_0)) {
      self setentityowner(var_0);
    } else {
      self setentityowner(self.owner);
    }
  }

  self setscriptablepartstate("effects", "explode", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
  thread supportbox_delete(var_0, 0.1, var_1);
}

function supportbox_destroy(var_0) {
  self endon("box_explode");

  if(!isDefined(var_0)) {
    var_0 = !istrue(self.planted);
  }

  var_1 = "vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx";

  if(isDefined(self.ref_13B87)) {
    var_1 = self.ref_13B87;
  }

  var_2 = undefined;
  var_3 = 0;

  if(!var_0) {
    var_2 = supportbox_getcloseanimduration();
    var_3 = var_2 + 1;
  }

  thread supportbox_delete(undefined, var_3, 0);
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self)) {
    var_6 = self.origin;
    var_7 = anglesToForward(self.angles);
    var_8 = anglestoup(self.angles);
    var_9 = self getlinkedparent();

    if(isDefined(var_9)) {
      var_4 = var_9;
      var_5 = var_4.origin - var_6;
    }

    self setscriptablepartstate("beacon", "neutral", 0);
    self setscriptablepartstate("hacked", "neutral", 0);

    if(!var_0) {
      self setscriptablepartstate("anims", "close", 0);
      wait var_2;
      self setscriptablepartstate("anims", "closedIdle", 0);
      wait 1;
    }

    if(isDefined(var_4) && isent(var_4)) {
      var_6 = var_4.origin - var_5;
    }

    playFX(scripts\engine\utility::getfx(var_1), var_6, var_7, var_8);
    playsoundatpos(var_6, "mp_equip_destroyed");
    return;
  }
}

function supportbox_delete(var_0, var_1, var_2) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::removeequip(self);
  }

  supportbox_removeheadicon();
  supportbox_makeunusable();

  if(isDefined(self.owner)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_armorBox") {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_armor_drop", self.usedcount, var_0, var_2);
    } else {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_ammo_drop", self.usedcount, var_0, var_2);
    }
  }

  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  wait var_1;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function supportbox_makeusable(var_0, var_1) {
  scripts\common\interactive::interactive_addusedcallbacktoentity(var_0);
  self.playersused = [];
  self.usedcount = 0;
  self makeusable();
  self setusepriority(-1);
  self enablemissilehint(1);
  self setCursorHint("HINT_NOICON");
  self setHintString(var_1);
  self setuserange(128);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(0);
  self sethinttag("tag_use");
  thread supportbox_watchallplayeruse();
}

function supportbox_makeunusable() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

function supportbox_watchallplayeruse() {
  self endon("death");
  self endon("supportBox_makeUnusable");
  var_0 = gettime();

  for(;;) {
    supportbox_updateplayersused();

    if(gettime() >= var_0) {
      supportbox_updateplayerusevisibility();
      var_0 = gettime() + 150;
    }

    waitframe();
  }
}

function supportbox_updateplayerusevisibility() {
  var_0 = scripts\common\utility::playersnear(self.origin, 300);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      if(!supportbox_playercanuse(var_2)) {
        self disableplayeruse(var_2);
        continue;
      }

      self enableplayeruse(var_2);
    }
  }
}

function supportbox_updateplayersused() {
  foreach(var_1 in self.playersused) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self.playersused[var_2])) {
        self.playersused[var_2] = undefined;
        ref_139AF(var_1);
      }
    }
  }
}

function supportbox_playercanuse(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(isDefined(self.playersused[var_0 getentitynumber()])) {
    return false;
  }

  if(isDefined(self.owner) && scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner)) {
    return false;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "x2") {
    if(isDefined(self.owner) && !scripts\engine\utility::array_contains(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var_0)) {
      return false;
    } else if(isDefined(self.team) && self.team != var_0.team) {
      return false;
    }
  }

  return true;
}

function supportbox_onplayeruse(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var_3) || scripts\mp\utility\weapon::issuperweapon(var_3) || scripts\mp\utility\weapon::iskillstreakweapon(var_3) || scripts\mp\utility\weapon::isgamemodeweapon(var_3)) {
      continue;
    }

    var_4 = scripts\mp\utility\weapon::getweapongroup(var_3);
    var_5 = undefined;

    if(scripts\mp\utility\weapon::issinglehitweapon(var_3)) {
      var_5 = 1;
    } else if(var_4 == "weapon_sniper") {
      var_5 = 1.5;
    } else {
      var_5 = 3;
    }

    var_6 = scripts\mp\weapons::getammooverride(var_3) * var_5;

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "ubshtgn") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var_11)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);
  }

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var_12)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);
  }

  var_0 scripts\mp\damagefeedback::hudicontype("ammobox");
  ref_139AE(var_0);
  thread supportbox_onplayeruseanim();
  return true;
}

function ref_139AE(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_armorBox") {
      var_0 playsoundtoplayer("armor_crate_use", var_0);
      return;
    }

    var_0 playsoundtoplayer("ammo_crate_use", var_0);
    return;
  }
}

function supportbox_onplayeruseanim() {
  self endon("death");

  if(istrue(self.onuseanimplaying)) {
    return;
  }

  self setscriptablepartstate("anims", "openUse", 0);
  self.onuseanimplaying = 1;
  wait supportbox_getuseanimduration();
  self setscriptablepartstate("anims", "openIdle", 0);
  self.onuseanimplaying = undefined;
}

function supportbox_makedamageable() {
  thread scripts\mp\damage::monitordamage(100, "hitequip", &supportbox_handlefataldamage, &supportbox_handledamage);
}

function supportbox_handledamage(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker);
  var_2 = undefined;

  if(isexplosivedamagemod(var_0.meansofdeath)) {
    var_2 = supportbox_explosivedamagetohits(var_0, var_1);
  } else if(scripts\engine\utility::isbulletdamage(var_0.meansofdeath)) {
    var_2 = supportbox_bulletdamagetohits(var_0, var_1);
  }

  if(isDefined(var_2)) {
    var_3 = 5;

    if(var_1) {
      var_3 = 5;
    }

    return int(ceil(min(1, var_2 / 5) * self.maxhealth));
  }

  return var_1.damage;
}

function supportbox_handlefataldamage(var_0) {
  supportbox_givepointsfordeath(var_0.attacker);
  thread supportbox_explode(var_0.attacker, 1);
}

function supportbox_bulletdamagetohits(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var_0.objweapon, var_0.meansofdeath, 1) && var_1, 2, 0);

  if(var_0.damage > 150) {
    return (var_2 + 10);
  }

  if(var_0.damage >= 80) {
    return (var_2 + 5);
  }

  if(var_0.damage >= 30) {
    return (var_2 + 2);
  }

  return var_2 + 1;
}

function supportbox_explosivedamagetohits(var_0, var_1) {
  if(var_0.damage > 200) {
    return 20;
  }

  if(var_0.damage > 70) {
    return 10;
  }

  if(var_0.damage > 30) {
    return 7;
  }

  return 2;
}

function supportbox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
    return;
  }
}

function supportbox_addheadicon(var_0) {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_0, 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  ref_139B0();
}

function supportbox_removeheadicon() {
  if(isDefined(self.showdroplocations)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showdroplocations);
    self.showdroplocations = undefined;
  }

  if(isDefined(self.showemergencyhint)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showemergencyhint);
    self.showemergencyhint = undefined;
    return;
  }
}

function supportbox_givepointsfordeath(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var_0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function supportbox_givexpforuse(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    if(self.owner != var_0) {
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("munitions_box_teammate_used");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12098(self);
    }

    self.owner scripts\mp\utility\stats::incpersstat("munitionsBoxUsed", 1);
    self.owner scripts\mp\supers::hide_plunderboxes("super_ammo_drop");
    self.usedcount++;
    return;
  }
}

function supportbox_onmovingplatformdeath(var_0) {
  supportbox_destroy(1);
}

function supportbox_handlemovingplatforms(var_0) {
  var_1 = spawnStruct();
  var_1.linkparent = var_0;
  var_1.deathoverridecallback = &supportbox_onmovingplatformdeath;
  var_1.endonstring = "death";
  var_1.validateaccuratetouching = 1;

  if(isDefined(var_0) && _calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0)) {
    var_1.ref_123B4 = 1;
    self method_87bb(1);
  }

  thread scripts\mp\movers::handle_moving_platforms(var_1);
}

function supportbox_watchdisownedtimeout() {
  self endon("death");
  supportbox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread supportbox_destroy();
    return;
  }
}

function supportbox_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

function supportbox_empapplied(var_0) {
  var_1 = var_0.attacker;
  supportbox_givepointsfordeath(var_1);
  thread supportbox_destroy();
}

function ref_139B0() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      return;
    }

    ref_139AF(var_1);
  }
}

function ref_139AF(var_0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner) && !isDefined(self.team)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = self.showdroplocations;

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self.showemergencyhint;

  if(!isDefined(var_2)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\menus::ref_13733() && isDefined(self.owner)) {
    var_3 = scripts\engine\utility::array_contains(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var_0);
  } else {
    jumpiffalse(isDefined(self.owner)) LOC_000000a1;
    var_4 = self.owner.team;
    goto LOC_000000aa;
  }

  var_5 = isDefined(self.playersused) && isDefined(self.playersused[var_3 getentitynumber()]);

  if(var_3 && !var_5) {
    scripts\cp_mp\entityheadicons::ref_1315D(var_3, var_3);
    scripts\cp_mp\entityheadicons::ref_1315E(var_4, var_3);
    return;
  }

  if(var_3) {
    scripts\cp_mp\entityheadicons::ref_1315E(var_3, var_3);
    scripts\cp_mp\entityheadicons::ref_1315D(var_4, var_3);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315E(var_3, var_3);
  scripts\cp_mp\entityheadicons::ref_1315E(var_4, var_3);
}

#using_animtree("scriptables");

function supportbox_getdeployanimduration() {
  return getanimlength(%wm_supportbox_ground_open);
}

#using_animtree("");

function supportbox_getuseanimduration() {
  return getanimlength(%wm_supportbox_ground_idle_open_use);
}

function supportbox_getcloseanimduration() {
  return getanimlength(%wm_supportbox_ground_close);
}

function supportbox_usedcallback(var_0, var_1) {
  if(istrue(var_1.isjuggernaut) && level.gametype != "br") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(supportbox_playercanuse(var_0, var_1)) {
    if(isDefined(level.ref_12099)) {
      var_2 = var_0[[level.ref_12099]](var_1);
    } else {
      var_2 = supportbox_onplayeruse(var_1, var_2);
    }

    if(var_2) {
      var_1.playersused[var_2 getentitynumber()] = var_2;
      ref_139AF(var_1, var_2);
      supportbox_givexpforuse(var_1, var_2);
      return;
    }

    return;
  }
}

function calloutmarkerpingvo_playpredictivepingcleared(var_0, var_1) {
  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(supportbox_playercanuse(var_0, var_1)) {
    if(isDefined(level.ref_11FFE)) {
      var_2 = var_0[[level.ref_11FFE]](var_1);
    } else {
      var_2 = 0;
    }

    if(var_2 && !istrue(var_1.ref_13F0F)) {
      var_1.playersused[var_2 getentitynumber()] = var_2;
      ref_139AF(var_1, var_2);
      supportbox_givexpforuse(var_1, var_2);
      return;
    }

    return;
  }
}