/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\ammo_box.gsc
***********************************************/

function ammobox_init() {
  level.brevent3 = [];
  scripts\common\interactive::interactive_addusedcallback(&ammobox_usedcallback, "equip_ammo_box");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&brspawnplayersending);
  level._effect["weapon_box_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  level.ammoboxweapons = spawnStruct();
  level.ammoboxweapons.weapons = [];
  level.ammoboxweapons.probabilities = [];
  var0 = scripts\cp_mp\utility\game_utility::isnightmap();

  if(scripts\mp\utility\game::usefloorrocks()) {
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
  } else {
    brrebirth_brmayconsiderplayerdead("weapon_assault", var0);
    brrebirth_brmayconsiderplayerdead("weapon_assault", var0);
    brrebirth_brmayconsiderplayerdead("weapon_smg", var0);
    brrebirth_brmayconsiderplayerdead("weapon_smg", var0);
    brrebirth_brmayconsiderplayerdead("weapon_lmg", var0);
    brrebirth_brmayconsiderplayerdead("weapon_lmg", var0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var0);
    brrebirth_brmayconsiderplayerdead("weapon_dmr", var0);
    brrebirth_brmayconsiderplayerdead("weapon_shotgun", var0);
    brrebirth_brmayconsiderplayerdead("weapon_pistol", var0);

    if(scripts\mp\utility\game::getgametype() != "br") {
      ammobox_addboxweapon(getcompleteweaponname("iw8_lm_dblmg_mp"), 3);
    }
  }

  var1 = 0;

  foreach(var3 in level.ammoboxweapons.probabilities) {
    var1 += var3;
  }

  level.ammoboxweapons.totalprobability = var1;
}

function brrebirth_cleanupents(var0, var1) {
  var2 = scripts\mp\class::buildweapon(var0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var1);
  var3 = randomintrange(2, 8);

  for(var4 = 0; var4 < var3; var4++) {
    var5 = scripts\mp\weapons::getrandomgraverobberattachment(var2);

    if(!isDefined(var5)) {
      break;
    }

    var6 = scripts\mp\weapons::addattachmenttoweapon(var2, var5);

    if(isDefined(var6)) {
      var2 = var6;
    }
  }

  if(isDefined(var2)) {
    ammobox_addboxweapon(var2, 10);
    return;
  }
}

function brrebirth_brmayconsiderplayerdead(var0, var1) {
  var2 = scripts\mp\utility\weapon::risktokens(var0);
  brrebirth_cleanupents(var2, var1);
}

function brspawnplayersending(var0) {
  foreach(var2 in level.brevent3) {
    if(isDefined(var2)) {
      var2 scripts\mp\equipment\support_box::ref_139af(var0);
    }
  }
}

function ammobox_addboxweapon(var0, var1) {
  var2 = level.ammoboxweapons.weapons.size;
  var3 = createheadicon(var0);
  var4 = "";
  var5 = strtok(var3, "+");
  var4 = var5[0];

  for(var6 = 1; var6 < var5.size; var6++) {
    var7 = var5[var6];
    var8 = strtok(var7, "|");
    var4 += "+" + var8[0];
  }

  var9 = asmdevgetallstates(var4);
  level.ammoboxweapons.weapons[var2] = var9;
  level.ammoboxweapons.probabilities[var2] = var1;
}

function ammobox_settled(var0) {
  thread ammobox_watchdisownedtimeout();
  self setscriptablepartstate("visibility", "show", 0);

  if(true) {
    thread scripts\mp\weapons::outlineequipmentforowner(var0);
  }

  var0.issuper = 1;
  scripts\mp\weapons::onequipmentplanted(var0, "equip_ammo_box", &ammobox_destroy);
  level.brevent3[var0 getentitynumber()] = var0;
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&ammobox_empapplied);
  ammobox_makedamageable(var0);

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    ammobox_addheadicon(var0);
  }

  thread ammobox_preloadweapons();
  thread ammobox_makeusable();
}

function ammobox_destroy(var0) {
  thread ammobox_delete(var0, 0, 0);
}

function ammobox_delete(var0, var1, var2) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::removeequip(self);
  }

  ammobox_removeheadicon();
  ammobox_makeunusable();
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_weapon_drop", self.usedcount, var0, var2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var2));
  self setscriptablepartstate("effects", "destroy", 0);
  var3 = scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  var4 = self.origin;
  var5 = anglesToForward(self.angles);
  var6 = anglestoup(self.angles);
  playFX(var3, var4, var5, var6);
  self playSound("mp_equip_destroyed");
  wait var1;
  self delete();
}

function ammobox_preloadweapons() {
  var0 = 60;
  var1 = 256;
  var2 = spawn("trigger_radius", self.origin, 0, var1, var0);
  ammobox_internalpreloadweapons(var2);
  var2 delete();
}

function ammobox_internalpreloadweapons(var0) {
  self endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(isDefined(self.playersused[var1 getentitynumber()])) {
      continue;
    }

    var2 = ammobox_getbufferedweapon(var1);
    var3 = [var2];
    brrebirth_initpostmain(var1);
    var4 = brrebirth_triggerrespawnoverlay(var1);

    if(isDefined(var4)) {
      var3 = var4;
    }

    var1 loadweaponsforplayer(var3, 1);
  }
}

function ammobox_makeusable() {
  scripts\common\interactive::interactive_addusedcallbacktoentity("equip_ammo_box");
  self.usedcount = 0;
  self.playersused = [];
  scripts\mp\utility\usability::maketeamusable(self.team);
  self enablemissilehint(1);
  self setCursorHint("HINT_NOICON");
  self setHintString(&"EQUIPMENT_HINTS/AMMO_BOX_USE");
  self setuserange(128);
  self setuseholdduration("duration_none");
  self sethinttag("tag_hint");
  thread ammobox_watchallplayeruse();
}

function ammobox_makeunusable() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

function ammobox_watchallplayeruse() {
  self endon("death");
  self endon("supportBox_makeUnusable");
  var0 = gettime();

  for(;;) {
    ammobox_updateplayersused();

    if(gettime() >= var0) {
      ammobox_updateplayerusevisibility();
      var0 = gettime() + 150;
    }

    waitframe();
  }
}

function ammobox_updateplayerusevisibility() {
  var0 = scripts\common\utility::playersnear(self.origin, 300);

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      if(!ammobox_playercanuse(var2)) {
        self disableplayeruse(var2);
        continue;
      }

      self enableplayeruse(var2);
    }
  }
}

function ammobox_updateplayersused() {
  foreach(var1 in self.playersused) {
    if(isDefined(var1)) {
      var2 = var1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var1) && isDefined(self.playersused[var2])) {
        self.playersused[var2] = undefined;
        scripts\mp\equipment\support_box::ref_139af(var1);
      }
    }
  }
}

function ammobox_playercanuse(var0) {
  if(!scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(!var0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(isDefined(self.playersused[var0 getentitynumber()])) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::playersareenemies(var0, self.owner)) {
    return false;
  }

  return true;
}

function brregendelayspeed(var0) {
  var1 = var0.lastdroppableweaponobj;

  if(isDefined(var0.minigunprevweaponobject)) {
    var1 = var0.minigunprevweaponobject;
    var0 scripts\cp_mp\killstreaks\juggernaut::dropjuggernautweapon("used_ammo_box", var0.miniprevweaponobject);
  }

  var2 = ammobox_getbufferedweapon(var0);
  ammobox_clearbufferedweapon(var0);

  if(var2.basename != "iw8_lm_dblmg_mp" && var0.lastweaponobj.basename != "iw8_cyberemp_mp") {
    var3 = var0.primaryweapons.size;

    if(!var0 hasweapon("iw8_fists_mp") || var3 > 1) {
      var0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
    }
  }

  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var2);
  var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var2);

  if(var0.lastweaponobj.basename == "iw8_cyberemp_mp") {
    var4 = var0.lastdroppableweaponobj;
    var0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var4);
  }

  if(var2.basename == "iw8_lm_dblmg_mp") {
    var0 scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(var2, var1);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, "flavor_awesome");
  }

  var0 playlocalsound("iw8_support_box_use");
  scripts\mp\weapons::fixupplayerweapons(var0, var2);

  if(isDefined(level.ref_120af)) {
    var0[[level.ref_120af]](var2);
  }

  return true;
}

function ammobox_getbufferedplayerdata(var0) {
  if(!isDefined(var0.finish)) {
    var1 = spawnStruct();
    var1.buffered = undefined;
    var1.last = undefined;
    var1.carriabletypes = undefined;
    var1.cashleaderbag_detach = undefined;
    var1.cashleader_trackdeath = undefined;
    var0.finish = var1;
  }

  return var0.finish;
}

function ammobox_getbufferedweapon(var0) {
  var1 = ammobox_getbufferedplayerdata(var0);

  if(!isDefined(var1.buffered)) {
    var2 = 10;
    var3 = 0;
    var4 = undefined;
    var5 = var0 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

    while(var3 < var2) {
      var4 = ammobox_getrandomweapon();

      if(ammobox_isvalidrandomweapon(var4, var1.last, var5)) {
        break;
      }

      var3++;
    }

    var1.buffered = var4;
  }

  return var1.buffered;
}

function brrebirth_playernakeddroploadout(var0) {
  var1 = ammobox_getbufferedplayerdata(var0);

  if(!isDefined(var1.carriabletypes)) {
    var2 = var0 getcurrentprimaryweapon();

    if(!isDefined(var2)) {
      return undefined;
    }

    if(!brrebirth_initfeatures(var2)) {
      return undefined;
    }

    if(!brrebirth_initexternalfeatures(var2)) {
      return undefined;
    }

    var3 = scripts\mp\weapons::getrandomgraverobberattachment(var2);

    if(!isDefined(var3)) {
      return undefined;
    }

    var1.carriabletypes = var3;
  }

  return var1.carriabletypes;
}

function brrebirth_triggerrespawnoverlay(var0) {
  brrebirth_initdialog(var0);
  var1 = ammobox_getbufferedplayerdata(var0);
  return var1.cashleaderbag_detach;
}

function brrebirth_respawn(var0) {
  brrebirth_initdialog(var0);
  var1 = ammobox_getbufferedplayerdata(var0);
  return var1.cashleader_trackdeath;
}

function brrebirth_initdialog(var0) {
  var1 = ammobox_getbufferedplayerdata(var0);

  if(!isDefined(var1.cashleaderbag_detach)) {
    var2 = brrebirth_playernakeddroploadout(var0);

    if(!isDefined(var2)) {
      return;
    }

    var3 = var0 getcurrentprimaryweapon();
    var4 = scripts\mp\weapons::addattachmenttoweapon(var3, var2);

    if(isDefined(var4)) {
      var1.cashleader_trackdeath = var3;
      var1.cashleaderbag_detach = var4;
      return;
    }

    return;
  }
}

function ammobox_clearbufferedweapon(var0) {
  var1 = ammobox_getbufferedplayerdata(var0);
  var1.last = var1.buffered;
  var1.buffered = undefined;
}

function brrebirth_ontimelimit(var0) {
  var1 = ammobox_getbufferedplayerdata(var0);
  var1.carriabletypes = undefined;
  var1.cashleaderbag_detach = undefined;
  var1.cashleader_trackdeath = undefined;
}

function brrebirth_initpostmain(var0) {
  var1 = brrebirth_respawn(var0);
  var2 = 0;

  if(!isDefined(var1)) {
    var2 = 1;
  } else {
    var3 = var0 getcurrentprimaryweapon();

    if(!isDefined(var3)) {
      var2 = 1;
    } else {
      var4 = scripts\mp\utility\weapon::getweaponfullname(var1);
      var5 = scripts\mp\utility\weapon::getweaponfullname(var3);
      var2 = var4 != var5;
    }
  }

  if(var2) {
    brrebirth_ontimelimit(var0);
    return;
  }
}

function ammobox_isvalidrandomweapon(var0, var1, var2) {
  if(isDefined(var1) && var0 == var1) {
    return false;
  }

  foreach(var4 in var2) {
    if(var4.basename == var0.basename) {
      return false;
    }
  }

  return true;
}

function ammobox_getrandomweapon() {
  var0 = randomint(level.ammoboxweapons.totalprobability);
  var1 = 0;
  var2 = undefined;

  for(var3 = 0; var3 < level.ammoboxweapons.weapons.size; var3++) {
    var1 += level.ammoboxweapons.probabilities[var3];

    if(var1 > var0) {
      return level.ammoboxweapons.weapons[var3];
    }
  }

  return undefined;
}

function ammobox_onplayeruse(var0) {
  var1 = var0 getcurrentweapon();

  if(!brrebirth_initfeatures(var1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_INCOMPAT");
    }

    return false;
  }

  if(!brrebirth_initexternalfeatures(var1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  var2 = brrebirth_tryrespawn(var0, var1);

  if(!var2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  return true;
}

function brrebirth_initfeatures(var0) {
  if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(var0) || scripts\mp\utility\weapon::issinglehitweapon(var0) || scripts\mp\utility\weapon::ismeleeonly(var0) || var0.basename == "iw8_lm_dblmg_mp") {
    return false;
  }

  return true;
}

function brrebirth_initexternalfeatures(var0) {
  var1 = getweaponattachments(var0);
  var2 = scripts\mp\utility\weapon::getattachmentbasenames(var1);
  var3 = 0;

  foreach(var5 in var2) {
    if(!scripts\mp\utility\weapon::carriedpunchcard(var0, var5)) {
      continue;
    }

    var3++;
  }

  return var3 < 8;
}

function brrebirth_tryrespawn(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = brrebirth_playernakeddroploadout(self);
  var2 = brrebirth_triggerrespawnoverlay(self);

  if(isDefined(var2)) {
    brrebirth_ontimelimit(self);
    var3 = undefined;
    var4 = undefined;

    if(var0.isalternate) {
      var3 = var0;
      var0 = var0 getnoaltweapon();
      var4 = scripts\mp\weapons::shouldweaponsavealtstate(var0);
    } else {
      var3 = var0 getaltweapon();
      var4 = 0;
    }

    var5 = var2 getaltweapon();
    var6 = self getweaponammostock(var0);
    var7 = self getweaponammoclip(var0, "left");
    var8 = self getweaponammoclip(var0, "right");
    var9 = self getammotype(var3);
    var10 = self getweaponammostock(var3);
    var11 = self getweaponammoclip(var3, "left");
    var12 = self getweaponammoclip(var3, "right");
    var13 = scripts\engine\utility::ter_op(var4, var5, var2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var13, -1, 0, 0);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var13);
    scripts\mp\weapons::fixupplayerweapons(self, var13);
    self setweaponammostock(var2, var6);
    self setweaponammoclip(var2, var7, "left");
    self setweaponammoclip(var2, var8, "right");
    var14 = self getammotype(var5);

    if(var9 == var14) {
      self setweaponammostock(var5, var10);
      self setweaponammoclip(var5, var11, "left");
      self setweaponammoclip(var5, var12, "right");
    }

    wait 0.2;
    self playlocalsound("attachment_pickup");
    var15 = scripts\mp\utility\weapon::attachmentmap_tounique(var1, var2);
    var16 = getweaponattachments(var2);
    var17 = scripts\engine\utility::array_find(var16, var15);

    if(!isDefined(var17)) {} else {
      thread brregenhealthadd(var17);
    }

    return true;
  }

  return false;
}

function brregenhealthadd(var0) {
  self endon("disconnect");
  var1 = var0 + 1;

  if(istrue(self.ref_14597)) {
    self.ref_14597 = undefined;
    var1 *= -1;
  } else {
    self.ref_14597 = 1;
  }

  self setclientomnvar("ui_weapon_pickup", var1);
  scripts\engine\utility::ref_143b9(1, "death");
  self setclientomnvar("ui_weapon_pickup", 0);
}

function ammobox_makedamageable() {
  thread scripts\mp\damage::monitordamage(300, "hitequip", &ammobox_handlefataldamage, &ammobox_handledamage);
}

function ammobox_handledamage(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  var1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0.attacker);
  var2 = undefined;

  if(isexplosivedamagemod(var0.meansofdeath)) {
    var2 = ammobox_explosivedamagetohits(var0, var1);
  } else if(scripts\engine\utility::isbulletdamage(var0.meansofdeath)) {
    var2 = ammobox_bulletdamagetohits(var0, var1);
  }

  if(isDefined(var2)) {
    var3 = 20;
    return int(ceil(min(1, var2 / 20) * self.maxhealth));
  }

  return var1.damage;
}

function ammobox_handlefataldamage(var0) {
  ammobox_givepointsfordeath(var0.attacker);
  thread ammobox_destroy(var0.attacker);
}

function ammobox_bulletdamagetohits(var0, var1) {
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

function ammobox_explosivedamagetohits(var0, var1) {
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

function ammobox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
    return;
  }
}

function ammobox_addheadicon() {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  scripts\mp\equipment\support_box::ref_139b0();
}

function ammobox_removeheadicon() {
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

function ammobox_givepointsfordeath(var0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0)) {
    var0 notify("destroyed_equipment");
    var0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function ammobox_givexpforuse(var0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0)) {
    if(self.owner != var0) {
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("weapon_drop_teammate_used");
      return;
    }

    return;
  }
}

function ammobox_onmovingplatformdeath(var0) {
  ammobox_destroy();
}

function ammobox_handlemovingplatforms(var0) {
  var1 = spawnStruct();
  var1.linkparent = var0;
  var1.deathoverridecallback = &ammobox_onmovingplatformdeath;
  var1.endonstring = "death";
  thread scripts\mp\movers::handle_moving_platforms(var1);
}

function ammobox_watchdisownedtimeout() {
  self endon("death");
  ammobox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread ammobox_destroy();
    return;
  }
}

function ammobox_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

function ammobox_empapplied(var0) {
  thread ammobox_destroy();
}

function ammobox_usedcallback(var0, var1) {
  thread brsingleuse(var0, var1);
}

function brsingleuse(var0, var1) {
  if(istrue(var1.van)) {
    return;
  }

  var1.van = 1;
  brskipplayerkillcams(var0, var1);

  if(isDefined(var1)) {
    var1.van = undefined;
    return;
  }
}

function brskipplayerkillcams(var0, var1) {
  level endon("game_ended");
  var1 endon("death_or_disconnect");
  var0 endon("death");
  var2 = gettime();
  var3 = 1;

  while(gettime() - var2 < 500) {
    if(!var1 useButtonPressed()) {
      var3 = 0;
      break;
    }

    waitframe();
  }

  if(istrue(var1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(!ammobox_playercanuse(var0, var1)) {
    return;
  }

  var4 = undefined;

  if(var3) {
    var4 = brregendelayspeed(var0, var1);
  } else {
    var4 = ammobox_onplayeruse(var0, var1);
  }

  if(var4) {
    if(isDefined(var0.owner)) {
      var0.owner scripts\mp\utility\stats::incpersstat("ammoBoxUsed", 1);
      var0.owner scripts\mp\supers::hide_plunderboxes("super_weapon_drop");
    }

    var0.usedcount++;
    var0.playersused[var1 getentitynumber()] = var1;
    var0 scripts\mp\equipment\support_box::ref_139af(var1);
    ammobox_givexpforuse(var0, var1);
    return;
  }
}