/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\support_box.gsc
************************************************/

function supportbox_init() {
  level.brking_watchcircletimers = [];
  scripts\common\interactive::interactive_addusedcallback(&supportbox_usedcallback, "equip_supportBox");
  scripts\common\interactive::interactive_addusedcallback(&calloutmarkerpingvo_playpredictivepingcleared, "equip_armorBox");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&ref_139b1);
  level._effect["vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx"] = loadfx("vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx");
  level._effect["vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx"] = loadfx("vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx");
}

function ref_139b1(var0) {
  foreach(var2 in level.brking_watchcircletimers) {
    if(isDefined(var2)) {
      ref_139af(var2, var0);
    }
  }
}

function debug_reach_exhaust_waste(var0, var1, var2, var3) {
  var0 endon("death");
  thread supportbox_watchdisownedtimeout();
  thread supportbox_hideandshowaftertime();
  thread ref_139b2(var0);
  jumpiftrue(scripts\mp\flags::gameflag("prematch_fade_done")) LOC_00000037;
  thread ref_139b3();
  var0 waittill("missile_stuck", var4);
  var0 setnodeploy(1);
  supportbox_handlemovingplatforms(var0, var4);

  if(true) {
    thread scripts\mp\weapons::outlineequipmentforowner(var0);
  }

  var0.issuper = 1;
  var0.superid = level.superglobals.staticsuperdata[var2].id;
  scripts\mp\weapons::onequipmentplanted(var0, var1, &supportbox_destroy);
  level.brking_watchcircletimers[var0 getentitynumber()] = var0;
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&supportbox_empapplied);

  if(!istrue(var0.madedamageable)) {
    supportbox_makedamageable(var0);
  }

  var0.makedamageable = undefined;
  var0 setscriptablepartstate("visibility", "show", 0);
  wait 0;

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    supportbox_addheadicon(var0, var3);
  }

  wait 0.75;
  var0 setscriptablepartstate("effects", "plant", 0);
  var0 setscriptablepartstate("anims", "open", 0);
  wait supportbox_getdeployanimduration();
  var0 setscriptablepartstate("beacon", "active", 0);
  var0 setscriptablepartstate("anims", "openIdle", 0);
}

function ref_139b2(var0) {
  self endon("death");
  self endon("missile_stuck");
  var0 endon("disconnect");
  var1 = scripts\engine\utility::ref_143b9(2, "touching_platform");

  if(var1 == "timeout") {
    return;
  }

  var2 = undefined;
  var3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var3.size, self);
}

function ref_139b3() {
  self endon("death");
  self endon("missile_stuck");
  level waittill("prematch_cleanup");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function tugofwar_tank(var0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var2 in level.ref_145f1.ref_13c8d) {
      if(var2 == var0) {
        return true;
      }

      if(isDefined(var2.wz_tease) && var2.wz_tease == var0) {
        return true;
      }
    }
  }

  return false;
}

function supportbox_used(var0) {
  var0 endon("death");
  var0.ref_13b87 = "vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx";
  debug_reach_exhaust_waste(var0, "equip_supportBox", "super_ammo_drop", "hud_icon_equipment_support_box");
  thread supportbox_makeusable(var0, "equip_supportBox");
}

function calloutmarkerpingvo_playpredictivepingadded(var0) {
  var0 endon("death");
  var0.ref_13b87 = "vfx/iw8_mp/equipment/vfx_offhand_wm_armorbox_timeout.vfx";
  debug_reach_exhaust_waste(var0, "equip_armorBox", "super_armor_drop", "ui_mp_br_loot_icon_health_armor_box");
  thread supportbox_makeusable(var0, "equip_armorBox");
}

function supportbox_hideandshowaftertime(var0) {
  self endon("death");
  self endon("missile_stuck");
  var1 = getdvarfloat("scr_support_box_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var1;
  self.madedamageable = 1;
  supportbox_makedamageable();
  self setscriptablepartstate("visibility", "show", 0);
}

function supportbox_unset() {
  if(false) {
    foreach(var1 in self.plantedsuperequip) {
      if(var1.equipmentref == "equip_supportBox" || var1.equipmentref == "equip_armorBox") {
        thread supportbox_destroy();
        scripts\mp\weapons::removeequip(var1);
      }
    }

    return;
  }
}

function supportbox_explode(var0, var1) {
  self notify("box_explode");

  if(isDefined(var0) || isDefined(self.owner)) {
    self clearscriptabledamageowner();

    if(isDefined(var0)) {
      self setentityowner(var0);
    } else {
      self setentityowner(self.owner);
    }
  }

  self setscriptablepartstate("effects", "explode", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
  thread supportbox_delete(var0, 0.1, var1);
}

function supportbox_destroy(var0) {
  self endon("box_explode");

  if(!isDefined(var0)) {
    var0 = !istrue(self.planted);
  }

  var1 = "vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx";

  if(isDefined(self.ref_13b87)) {
    var1 = self.ref_13b87;
  }

  var2 = undefined;
  var3 = 0;

  if(!var0) {
    var2 = supportbox_getcloseanimduration();
    var3 = var2 + 1;
  }

  thread supportbox_delete(undefined, var3, 0);
  var4 = undefined;
  var5 = undefined;

  if(isDefined(self)) {
    var6 = self.origin;
    var7 = anglesToForward(self.angles);
    var8 = anglestoup(self.angles);
    var9 = self getlinkedparent();

    if(isDefined(var9)) {
      var4 = var9;
      var5 = var4.origin - var6;
    }

    self setscriptablepartstate("beacon", "neutral", 0);
    self setscriptablepartstate("hacked", "neutral", 0);

    if(!var0) {
      self setscriptablepartstate("anims", "close", 0);
      wait var2;
      self setscriptablepartstate("anims", "closedIdle", 0);
      wait 1;
    }

    if(isDefined(var4) && isent(var4)) {
      var6 = var4.origin - var5;
    }

    playFX(scripts\engine\utility::getfx(var1), var6, var7, var8);
    playsoundatpos(var6, "mp_equip_destroyed");
    return;
  }
}

function supportbox_delete(var0, var1, var2) {
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
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_armor_drop", self.usedcount, var0, var2);
    } else {
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_ammo_drop", self.usedcount, var0, var2);
    }
  }

  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var2));
  wait var1;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function supportbox_makeusable(var0, var1) {
  scripts\common\interactive::interactive_addusedcallbacktoentity(var0);
  self.playersused = [];
  self.usedcount = 0;
  self makeusable();
  self setusepriority(-1);
  self enablemissilehint(1);
  self setCursorHint("HINT_NOICON");
  self setHintString(var1);
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
  var0 = gettime();

  for(;;) {
    supportbox_updateplayersused();

    if(gettime() >= var0) {
      supportbox_updateplayerusevisibility();
      var0 = gettime() + 150;
    }

    waitframe();
  }
}

function supportbox_updateplayerusevisibility() {
  var0 = scripts\common\utility::playersnear(self.origin, 300);

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      if(!supportbox_playercanuse(var2)) {
        self disableplayeruse(var2);
        continue;
      }

      self enableplayeruse(var2);
    }
  }
}

function supportbox_updateplayersused() {
  foreach(var1 in self.playersused) {
    if(isDefined(var1)) {
      var2 = var1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var1) && isDefined(self.playersused[var2])) {
        self.playersused[var2] = undefined;
        ref_139af(var1);
      }
    }
  }
}

function supportbox_playercanuse(var0) {
  if(!scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(!var0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(isDefined(self.playersused[var0 getentitynumber()])) {
    return false;
  }

  if(isDefined(self.owner) && scripts\cp_mp\utility\player_utility::playersareenemies(var0, self.owner)) {
    return false;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "x2") {
    if(isDefined(self.owner) && !scripts\engine\utility::array_contains(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var0)) {
      return false;
    } else if(isDefined(self.team) && self.team != var0.team) {
      return false;
    }
  }

  return true;
}

function supportbox_onplayeruse(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var3) || scripts\mp\utility\weapon::issuperweapon(var3) || scripts\mp\utility\weapon::iskillstreakweapon(var3) || scripts\mp\utility\weapon::isgamemodeweapon(var3)) {
      continue;
    }

    var4 = scripts\mp\utility\weapon::getweapongroup(var3);
    var5 = undefined;

    if(scripts\mp\utility\weapon::issinglehitweapon(var3)) {
      var5 = 1;
    } else if(var4 == "weapon_sniper") {
      var5 = 1.5;
    } else {
      var5 = 3;
    }

    var6 = scripts\mp\weapons::getammooverride(var3) * var5;

    if(var3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var3.underbarrel) == "ubshtgn") {
      var7 = var0 getweaponammoclip(var3);
      var8 = int(var7 + var6);
      var0 setweaponammoclip(var3, var8);
      continue;
    }

    var9 = var0 getweaponammostock(var3);
    var8 = int(var9 + var6);
    var0 setweaponammostock(var3, var8);
  }

  var11 = var0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var11)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var11);
  }

  var12 = var0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var12)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var12);
  }

  var0 scripts\mp\damagefeedback::hudicontype("ammobox");
  ref_139ae(var0);
  thread supportbox_onplayeruseanim();
  return true;
}

function ref_139ae(var0) {
  if(isDefined(var0)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_armorBox") {
      var0 playsoundtoplayer("armor_crate_use", var0);
      return;
    }

    var0 playsoundtoplayer("ammo_crate_use", var0);
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

function supportbox_handledamage(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  var1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0.attacker);
  var2 = undefined;

  if(isexplosivedamagemod(var0.meansofdeath)) {
    var2 = supportbox_explosivedamagetohits(var0, var1);
  } else if(scripts\engine\utility::isbulletdamage(var0.meansofdeath)) {
    var2 = supportbox_bulletdamagetohits(var0, var1);
  }

  if(isDefined(var2)) {
    var3 = 5;

    if(var1) {
      var3 = 5;
    }

    return int(ceil(min(1, var2 / 5) * self.maxhealth));
  }

  return var1.damage;
}

function supportbox_handlefataldamage(var0) {
  supportbox_givepointsfordeath(var0.attacker);
  thread supportbox_explode(var0.attacker, 1);
}

function supportbox_bulletdamagetohits(var0, var1) {
  var2 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var0.objweapon, var0.meansofdeath, 1) && var1, 2, 0);

  if(var0.damage > 150) {
    return (var2 + 10);
  }

  if(var0.damage >= 80) {
    return (var2 + 5);
  }

  if(var0.damage >= 30) {
    return (var2 + 2);
  }

  return var2 + 1;
}

function supportbox_explosivedamagetohits(var0, var1) {
  if(var0.damage > 200) {
    return 20;
  }

  if(var0.damage > 70) {
    return 10;
  }

  if(var0.damage > 30) {
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

function supportbox_addheadicon(var0) {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var0, 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  ref_139b0();
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

function supportbox_givepointsfordeath(var0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0)) {
    var0 notify("destroyed_equipment");
    var0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function supportbox_givexpforuse(var0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0)) {
    if(self.owner != var0) {
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("munitions_box_teammate_used");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12098(self);
    }

    self.owner scripts\mp\utility\stats::incpersstat("munitionsBoxUsed", 1);
    self.owner scripts\mp\supers::hide_plunderboxes("super_ammo_drop");
    self.usedcount++;
    return;
  }
}

function supportbox_onmovingplatformdeath(var0) {
  supportbox_destroy(1);
}

function supportbox_handlemovingplatforms(var0) {
  var1 = spawnStruct();
  var1.linkparent = var0;
  var1.deathoverridecallback = &supportbox_onmovingplatformdeath;
  var1.endonstring = "death";
  var1.validateaccuratetouching = 1;

  if(isDefined(var0) && _calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var0)) {
    var1.ref_123b4 = 1;
    self method_87bb(1);
  }

  thread scripts\mp\movers::handle_moving_platforms(var1);
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

function supportbox_empapplied(var0) {
  var1 = var0.attacker;
  supportbox_givepointsfordeath(var1);
  thread supportbox_destroy();
}

function ref_139b0() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      return;
    }

    ref_139af(var1);
  }
}

function ref_139af(var0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner) && !isDefined(self.team)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  var1 = self.showdroplocations;

  if(!isDefined(var1)) {
    return;
  }

  var2 = self.showemergencyhint;

  if(!isDefined(var2)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\menus::ref_13733() && isDefined(self.owner)) {
    var3 = scripts\engine\utility::array_contains(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var0);
  } else {
    jumpiffalse(isDefined(self.owner)) LOC_000000a1;
    var4 = self.owner.team;
    goto LOC_000000aa;
  }

  var5 = isDefined(self.playersused) && isDefined(self.playersused[var3 getentitynumber()]);

  if(var3 && !var5) {
    scripts\cp_mp\entityheadicons::ref_1315d(var3, var3);
    scripts\cp_mp\entityheadicons::ref_1315e(var4, var3);
    return;
  }

  if(var3) {
    scripts\cp_mp\entityheadicons::ref_1315e(var3, var3);
    scripts\cp_mp\entityheadicons::ref_1315d(var4, var3);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315e(var3, var3);
  scripts\cp_mp\entityheadicons::ref_1315e(var4, var3);
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

function supportbox_usedcallback(var0, var1) {
  if(istrue(var1.isjuggernaut) && level.gametype != "br") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(supportbox_playercanuse(var0, var1)) {
    if(isDefined(level.ref_12099)) {
      var2 = var0[[level.ref_12099]](var1);
    } else {
      var2 = supportbox_onplayeruse(var1, var2);
    }

    if(var2) {
      var1.playersused[var2 getentitynumber()] = var2;
      ref_139af(var1, var2);
      supportbox_givexpforuse(var1, var2);
      return;
    }

    return;
  }
}

function calloutmarkerpingvo_playpredictivepingcleared(var0, var1) {
  if(istrue(var1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(supportbox_playercanuse(var0, var1)) {
    if(isDefined(level.ref_11ffe)) {
      var2 = var0[[level.ref_11ffe]](var1);
    } else {
      var2 = 0;
    }

    if(var2 && !istrue(var1.ref_13f0f)) {
      var1.playersused[var2 getentitynumber()] = var2;
      ref_139af(var1, var2);
      supportbox_givexpforuse(var1, var2);
      return;
    }

    return;
  }
}