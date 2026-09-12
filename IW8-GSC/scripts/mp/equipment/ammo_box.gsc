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
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();

  if(scripts\mp\utility\game::usefloorrocks()) {
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
  } else {
    brrebirth_brmayconsiderplayerdead("weapon_assault", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_assault", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_smg", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_smg", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_lmg", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_lmg", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_sniper", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_dmr", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_shotgun", var_0);
    brrebirth_brmayconsiderplayerdead("weapon_pistol", var_0);

    if(scripts\mp\utility\game::getgametype() != "br") {
      ammobox_addboxweapon(getcompleteweaponname("iw8_lm_dblmg_mp"), 3);
    }
  }

  var_1 = 0;

  foreach(var_3 in level.ammoboxweapons.probabilities) {
    var_1 += var_3;
  }

  level.ammoboxweapons.totalprobability = var_1;
}

function brrebirth_cleanupents(var_0, var_1) {
  var_2 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  var_3 = randomintrange(2, 8);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = scripts\mp\weapons::getrandomgraverobberattachment(var_2);

    if(!isDefined(var_5)) {
      break;
    }

    var_6 = scripts\mp\weapons::addattachmenttoweapon(var_2, var_5);

    if(isDefined(var_6)) {
      var_2 = var_6;
    }
  }

  if(isDefined(var_2)) {
    ammobox_addboxweapon(var_2, 10);
    return;
  }
}

function brrebirth_brmayconsiderplayerdead(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::risktokens(var_0);
  brrebirth_cleanupents(var_2, var_1);
}

function brspawnplayersending(var_0) {
  foreach(var_2 in level.brevent3) {
    if(isDefined(var_2)) {
      var_2 scripts\mp\equipment\support_box::ref_139AF(var_0);
    }
  }
}

function ammobox_addboxweapon(var_0, var_1) {
  var_2 = level.ammoboxweapons.weapons.size;
  var_3 = createheadicon(var_0);
  var_4 = "";
  var_5 = strtok(var_3, "+");
  var_4 = var_5[0];

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_8 = strtok(var_7, "|");
    var_4 += "+" + var_8[0];
  }

  var_9 = asmdevgetallstates(var_4);
  level.ammoboxweapons.weapons[var_2] = var_9;
  level.ammoboxweapons.probabilities[var_2] = var_1;
}

function ammobox_settled(var_0) {
  thread ammobox_watchdisownedtimeout();
  self setscriptablepartstate("visibility", "show", 0);

  if(true) {
    thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  }

  var_0.issuper = 1;
  scripts\mp\weapons::onequipmentplanted(var_0, "equip_ammo_box", &ammobox_destroy);
  level.brevent3[var_0 getentitynumber()] = var_0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&ammobox_empapplied);
  ammobox_makedamageable(var_0);

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    ammobox_addheadicon(var_0);
  }

  thread ammobox_preloadweapons();
  thread ammobox_makeusable();
}

function ammobox_destroy(var_0) {
  thread ammobox_delete(var_0, 0, 0);
}

function ammobox_delete(var_0, var_1, var_2) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::removeequip(self);
  }

  ammobox_removeheadicon();
  ammobox_makeunusable();
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_weapon_drop", self.usedcount, var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  self setscriptablepartstate("effects", "destroy", 0);
  var_3 = scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  var_4 = self.origin;
  var_5 = anglesToForward(self.angles);
  var_6 = anglestoup(self.angles);
  playFX(var_3, var_4, var_5, var_6);
  self playSound("mp_equip_destroyed");
  wait var_1;
  self delete();
}

function ammobox_preloadweapons() {
  var_0 = 60;
  var_1 = 256;
  var_2 = spawn("trigger_radius", self.origin, 0, var_1, var_0);
  ammobox_internalpreloadweapons(var_2);
  var_2 delete();
}

function ammobox_internalpreloadweapons(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(isDefined(self.playersused[var_1 getentitynumber()])) {
      continue;
    }

    var_2 = ammobox_getbufferedweapon(var_1);
    var_3 = [var_2];
    brrebirth_initpostmain(var_1);
    var_4 = brrebirth_triggerrespawnoverlay(var_1);

    if(isDefined(var_4)) {
      var_3 = var_4;
    }

    var_1 loadweaponsforplayer(var_3, 1);
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
  var_0 = gettime();

  for(;;) {
    ammobox_updateplayersused();

    if(gettime() >= var_0) {
      ammobox_updateplayerusevisibility();
      var_0 = gettime() + 150;
    }

    waitframe();
  }
}

function ammobox_updateplayerusevisibility() {
  var_0 = scripts\common\utility::playersnear(self.origin, 300);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      if(!ammobox_playercanuse(var_2)) {
        self disableplayeruse(var_2);
        continue;
      }

      self enableplayeruse(var_2);
    }
  }
}

function ammobox_updateplayersused() {
  foreach(var_1 in self.playersused) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self.playersused[var_2])) {
        self.playersused[var_2] = undefined;
        scripts\mp\equipment\support_box::ref_139AF(var_1);
      }
    }
  }
}

function ammobox_playercanuse(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(isDefined(self.playersused[var_0 getentitynumber()])) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner)) {
    return false;
  }

  return true;
}

function brregendelayspeed(var_0) {
  var_1 = var_0.lastdroppableweaponobj;

  if(isDefined(var_0.minigunprevweaponobject)) {
    var_1 = var_0.minigunprevweaponobject;
    var_0 scripts\cp_mp\killstreaks\juggernaut::dropjuggernautweapon("used_ammo_box", var_0.miniprevweaponobject);
  }

  var_2 = ammobox_getbufferedweapon(var_0);
  ammobox_clearbufferedweapon(var_0);

  if(var_2.basename != "iw8_lm_dblmg_mp" && var_0.lastweaponobj.basename != "iw8_cyberemp_mp") {
    var_3 = var_0.primaryweapons.size;

    if(!var_0 hasweapon("iw8_fists_mp") || var_3 > 1) {
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    }
  }

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_2);

  if(var_0.lastweaponobj.basename == "iw8_cyberemp_mp") {
    var_4 = var_0.lastdroppableweaponobj;
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  if(var_2.basename == "iw8_lm_dblmg_mp") {
    var_0 scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(var_2, var_1);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "flavor_awesome");
  }

  var_0 playlocalsound("iw8_support_box_use");
  scripts\mp\weapons::fixupplayerweapons(var_0, var_2);

  if(isDefined(level.ref_120AF)) {
    var_0[[level.ref_120AF]](var_2);
  }

  return true;
}

function ammobox_getbufferedplayerdata(var_0) {
  if(!isDefined(var_0.finish)) {
    var_1 = spawnStruct();
    var_1.buffered = undefined;
    var_1.last = undefined;
    var_1.carriabletypes = undefined;
    var_1.cashleaderbag_detach = undefined;
    var_1.cashleader_trackdeath = undefined;
    var_0.finish = var_1;
  }

  return var_0.finish;
}

function ammobox_getbufferedweapon(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);

  if(!isDefined(var_1.buffered)) {
    var_2 = 10;
    var_3 = 0;
    var_4 = undefined;
    var_5 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

    while(var_3 < var_2) {
      var_4 = ammobox_getrandomweapon();

      if(ammobox_isvalidrandomweapon(var_4, var_1.last, var_5)) {
        break;
      }

      var_3++;
    }

    var_1.buffered = var_4;
  }

  return var_1.buffered;
}

function brrebirth_playernakeddroploadout(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);

  if(!isDefined(var_1.carriabletypes)) {
    var_2 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_2)) {
      return undefined;
    }

    if(!brrebirth_initfeatures(var_2)) {
      return undefined;
    }

    if(!brrebirth_initexternalfeatures(var_2)) {
      return undefined;
    }

    var_3 = scripts\mp\weapons::getrandomgraverobberattachment(var_2);

    if(!isDefined(var_3)) {
      return undefined;
    }

    var_1.carriabletypes = var_3;
  }

  return var_1.carriabletypes;
}

function brrebirth_triggerrespawnoverlay(var_0) {
  brrebirth_initdialog(var_0);
  var_1 = ammobox_getbufferedplayerdata(var_0);
  return var_1.cashleaderbag_detach;
}

function brrebirth_respawn(var_0) {
  brrebirth_initdialog(var_0);
  var_1 = ammobox_getbufferedplayerdata(var_0);
  return var_1.cashleader_trackdeath;
}

function brrebirth_initdialog(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);

  if(!isDefined(var_1.cashleaderbag_detach)) {
    var_2 = brrebirth_playernakeddroploadout(var_0);

    if(!isDefined(var_2)) {
      return;
    }

    var_3 = var_0 getcurrentprimaryweapon();
    var_4 = scripts\mp\weapons::addattachmenttoweapon(var_3, var_2);

    if(isDefined(var_4)) {
      var_1.cashleader_trackdeath = var_3;
      var_1.cashleaderbag_detach = var_4;
      return;
    }

    return;
  }
}

function ammobox_clearbufferedweapon(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);
  var_1.last = var_1.buffered;
  var_1.buffered = undefined;
}

function brrebirth_ontimelimit(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);
  var_1.carriabletypes = undefined;
  var_1.cashleaderbag_detach = undefined;
  var_1.cashleader_trackdeath = undefined;
}

function brrebirth_initpostmain(var_0) {
  var_1 = brrebirth_respawn(var_0);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else {
    var_3 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_3)) {
      var_2 = 1;
    } else {
      var_4 = scripts\mp\utility\weapon::getweaponfullname(var_1);
      var_5 = scripts\mp\utility\weapon::getweaponfullname(var_3);
      var_2 = var_4 != var_5;
    }
  }

  if(var_2) {
    brrebirth_ontimelimit(var_0);
    return;
  }
}

function ammobox_isvalidrandomweapon(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_0 == var_1) {
    return false;
  }

  foreach(var_4 in var_2) {
    if(var_4.basename == var_0.basename) {
      return false;
    }
  }

  return true;
}

function ammobox_getrandomweapon() {
  var_0 = randomint(level.ammoboxweapons.totalprobability);
  var_1 = 0;
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.ammoboxweapons.weapons.size; var_3++) {
    var_1 += level.ammoboxweapons.probabilities[var_3];

    if(var_1 > var_0) {
      return level.ammoboxweapons.weapons[var_3];
    }
  }

  return undefined;
}

function ammobox_onplayeruse(var_0) {
  var_1 = var_0 getcurrentweapon();

  if(!brrebirth_initfeatures(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_INCOMPAT");
    }

    return false;
  }

  if(!brrebirth_initexternalfeatures(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  var_2 = brrebirth_tryrespawn(var_0, var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  return true;
}

function brrebirth_initfeatures(var_0) {
  if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0) || scripts\mp\utility\weapon::issinglehitweapon(var_0) || scripts\mp\utility\weapon::ismeleeonly(var_0) || var_0.basename == "iw8_lm_dblmg_mp") {
    return false;
  }

  return true;
}

function brrebirth_initexternalfeatures(var_0) {
  var_1 = getweaponattachments(var_0);
  var_2 = scripts\mp\utility\weapon::getattachmentbasenames(var_1);
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!scripts\mp\utility\weapon::carriedpunchcard(var_0, var_5)) {
      continue;
    }

    var_3++;
  }

  return var_3 < 8;
}

function brrebirth_tryrespawn(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = brrebirth_playernakeddroploadout(self);
  var_2 = brrebirth_triggerrespawnoverlay(self);

  if(isDefined(var_2)) {
    brrebirth_ontimelimit(self);
    var_3 = undefined;
    var_4 = undefined;

    if(var_0.isalternate) {
      var_3 = var_0;
      var_0 = var_0 getnoaltweapon();
      var_4 = scripts\mp\weapons::shouldweaponsavealtstate(var_0);
    } else {
      var_3 = var_0 getaltweapon();
      var_4 = 0;
    }

    var_5 = var_2 getaltweapon();
    var_6 = self getweaponammostock(var_0);
    var_7 = self getweaponammoclip(var_0, "left");
    var_8 = self getweaponammoclip(var_0, "right");
    var_9 = self getammotype(var_3);
    var_10 = self getweaponammostock(var_3);
    var_11 = self getweaponammoclip(var_3, "left");
    var_12 = self getweaponammoclip(var_3, "right");
    var_13 = scripts\engine\utility::ter_op(var_4, var_5, var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_13, -1, 0, 0);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_13);
    scripts\mp\weapons::fixupplayerweapons(self, var_13);
    self setweaponammostock(var_2, var_6);
    self setweaponammoclip(var_2, var_7, "left");
    self setweaponammoclip(var_2, var_8, "right");
    var_14 = self getammotype(var_5);

    if(var_9 == var_14) {
      self setweaponammostock(var_5, var_10);
      self setweaponammoclip(var_5, var_11, "left");
      self setweaponammoclip(var_5, var_12, "right");
    }

    wait 0.2;
    self playlocalsound("attachment_pickup");
    var_15 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1, var_2);
    var_16 = getweaponattachments(var_2);
    var_17 = scripts\engine\utility::array_find(var_16, var_15);

    if(!isDefined(var_17)) {} else {
      thread brregenhealthadd(var_17);
    }

    return true;
  }

  return false;
}

function brregenhealthadd(var_0) {
  self endon("disconnect");
  var_1 = var_0 + 1;

  if(istrue(self.ref_14597)) {
    self.ref_14597 = undefined;
    var_1 *= -1;
  } else {
    self.ref_14597 = 1;
  }

  self setclientomnvar("ui_weapon_pickup", var_1);
  scripts\engine\utility::ref_143B9(1, "death");
  self setclientomnvar("ui_weapon_pickup", 0);
}

function ammobox_makedamageable() {
  thread scripts\mp\damage::monitordamage(300, "hitequip", &ammobox_handlefataldamage, &ammobox_handledamage);
}

function ammobox_handledamage(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker);
  var_2 = undefined;

  if(isexplosivedamagemod(var_0.meansofdeath)) {
    var_2 = ammobox_explosivedamagetohits(var_0, var_1);
  } else if(scripts\engine\utility::isbulletdamage(var_0.meansofdeath)) {
    var_2 = ammobox_bulletdamagetohits(var_0, var_1);
  }

  if(isDefined(var_2)) {
    var_3 = 20;
    return int(ceil(min(1, var_2 / 20) * self.maxhealth));
  }

  return var_1.damage;
}

function ammobox_handlefataldamage(var_0) {
  ammobox_givepointsfordeath(var_0.attacker);
  thread ammobox_destroy(var_0.attacker);
}

function ammobox_bulletdamagetohits(var_0, var_1) {
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

function ammobox_explosivedamagetohits(var_0, var_1) {
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

function ammobox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
    return;
  }
}

function ammobox_addheadicon() {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  scripts\mp\equipment\support_box::ref_139B0();
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

function ammobox_givepointsfordeath(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var_0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

function ammobox_givexpforuse(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    if(self.owner != var_0) {
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("weapon_drop_teammate_used");
      return;
    }

    return;
  }
}

function ammobox_onmovingplatformdeath(var_0) {
  ammobox_destroy();
}

function ammobox_handlemovingplatforms(var_0) {
  var_1 = spawnStruct();
  var_1.linkparent = var_0;
  var_1.deathoverridecallback = &ammobox_onmovingplatformdeath;
  var_1.endonstring = "death";
  thread scripts\mp\movers::handle_moving_platforms(var_1);
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

function ammobox_empapplied(var_0) {
  thread ammobox_destroy();
}

function ammobox_usedcallback(var_0, var_1) {
  thread brsingleuse(var_0, var_1);
}

function brsingleuse(var_0, var_1) {
  if(istrue(var_1.van)) {
    return;
  }

  var_1.van = 1;
  brskipplayerkillcams(var_0, var_1);

  if(isDefined(var_1)) {
    var_1.van = undefined;
    return;
  }
}

function brskipplayerkillcams(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_0 endon("death");
  var_2 = gettime();
  var_3 = 1;

  while(gettime() - var_2 < 500) {
    if(!var_1 useButtonPressed()) {
      var_3 = 0;
      break;
    }

    waitframe();
  }

  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(!ammobox_playercanuse(var_0, var_1)) {
    return;
  }

  var_4 = undefined;

  if(var_3) {
    var_4 = brregendelayspeed(var_0, var_1);
  } else {
    var_4 = ammobox_onplayeruse(var_0, var_1);
  }

  if(var_4) {
    if(isDefined(var_0.owner)) {
      var_0.owner scripts\mp\utility\stats::incpersstat("ammoBoxUsed", 1);
      var_0.owner scripts\mp\supers::hide_plunderboxes("super_weapon_drop");
    }

    var_0.usedcount++;
    var_0.playersused[var_1 getentitynumber()] = var_1;
    var_0 scripts\mp\equipment\support_box::ref_139AF(var_1);
    ammobox_givexpforuse(var_0, var_1);
    return;
  }
}