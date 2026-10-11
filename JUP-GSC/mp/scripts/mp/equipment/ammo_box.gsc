/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\ammo_box.gsc
************************************************/

#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment\support_box;
#using scripts\mp\hostmigration;
#using scripts\mp\killstreaks\juggernaut_mp;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\usability;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace ammo_box;

function ammobox_init() {
  level.allammoboxes = [];
  scripts\common\interactive::interactive_addusedcallback(&ammobox_usedcallback, "equip_ammo_box");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&ammobox_updateheadicononjointeam);
  level._effect["weapon_box_impact"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  level.ammoboxweapons = spawnStruct();
  level.ammoboxweapons.weapons = [];
  level.ammoboxweapons.probabilities = [];
  hasnvg = scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4();
  ammobox_addrandomweapon("weapon_assault", hasnvg);
  ammobox_addrandomweapon("weapon_assault", hasnvg);
  ammobox_addrandomweapon("weapon_battle", hasnvg);
  ammobox_addrandomweapon("weapon_smg", hasnvg);
  ammobox_addrandomweapon("weapon_smg", hasnvg);
  ammobox_addrandomweapon("weapon_lmg", hasnvg);
  ammobox_addrandomweapon("weapon_lmg", hasnvg);
  ammobox_addrandomweapon("weapon_sniper", hasnvg);
  ammobox_addrandomweapon("weapon_dmr", hasnvg);
  ammobox_addrandomweapon("weapon_shotgun", hasnvg);
  ammobox_addrandomweapon("weapon_pistol", hasnvg);

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    ammobox_addboxweapon(makeweapon("iw8_lm_dblmg_mp"), 3);
  }

  totalprobability = 0;

  foreach(probability in level.ammoboxweapons.probabilities) {
    totalprobability += probability;
  }

  level.ammoboxweapons.totalprobability = totalprobability;

  setdevdvarifuninitialized(@ "hash_dda56d67bc308c3e", 0);
  level thread function_d78c9f174c10f8a9();
}

function ammobox_addrandomweapon(weapongroup, hasnvg) {
  randomweapon = scripts\mp\utility\weapon::getrandomweaponfromgroup(weapongroup);
  var_b8215055a946eebb = scripts\cp_mp\weapon::buildweapon(randomweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg);
  numattachments = randomintrange(2, 8);

  for(i = 0; i < numattachments; i++) {
    attachment = scripts\mp\weapons::getrandomgraverobberattachment(var_b8215055a946eebb);

    if(!isDefined(attachment)) {
      break;
    }

    newweaponobj = addattachmenttoweapon(var_b8215055a946eebb, attachment);

    if(isDefined(newweaponobj)) {
      var_b8215055a946eebb = newweaponobj;
    }
  }

  if(isDefined(var_b8215055a946eebb)) {
    ammobox_addboxweapon(var_b8215055a946eebb, 10);
  }
}

function ammobox_updateheadicononjointeam(player) {
  foreach(ammobox in level.allammoboxes) {
    if(isDefined(ammobox)) {
      ammobox scripts\mp\equipment\support_box::supportbox_updateheadicon(player);
    }
  }
}

function ammobox_addboxweapon(weaponobj, probability) {
  assert(isDefined(weaponobj));
  currentindex = level.ammoboxweapons.weapons.size;
  fullweaponname = getcompleteweaponname(weaponobj);
  var_d4ccfb9e7f269c94 = "";
  attachmenttoks = strtok(fullweaponname, "+");
  var_d4ccfb9e7f269c94 = attachmenttoks[0];

  for(i = 1; i < attachmenttoks.size; i++) {
    tok = attachmenttoks[i];
    varianttoks = strtok(tok, "|");
    var_d4ccfb9e7f269c94 += "+" + varianttoks[0];
  }

  var_565da446b4a1827c = makeweaponfromstring(var_d4ccfb9e7f269c94);
  level.ammoboxweapons.weapons[currentindex] = var_565da446b4a1827c;
  level.ammoboxweapons.probabilities[currentindex] = probability;
}

function ammobox_settled(grenade) {
  grenade thread ammobox_watchdisownedtimeout();
  self setscriptablepartstate("visibility", "show", 0);

  if(true) {
    thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  }

  grenade.issuper = 1;
  scripts\mp\weapons::onequipmentplanted(grenade, "equip_ammo_box", &ammobox_destroy);
  level.allammoboxes[grenade getentitynumber()] = grenade;
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(&ammobox_empapplied);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&ammobox_empapplied);
  }

  grenade ammobox_makedamageable();

  if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    grenade ammobox_addheadicon();
  }

  grenade thread ammobox_preloadweapons();
  grenade thread ammobox_makeusable();
}

function ammobox_destroy() {
  thread ammobox_delete(0, 0);
}

function ammobox_delete(deletiondelay, wasdestroyed) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner removeequip(self);
  }

  ammobox_removeheadicon();
  ammobox_makeunusable();
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(wasdestroyed));
  self setscriptablepartstate("effects", "destroy", 0);
  effectid = getfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  origin = self.origin;
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  playFX(effectid, origin, forward, up);
  self playSound("mp_equip_box_destroyed");
  wait deletiondelay;
  self delete();
}

function ammobox_preloadweapons() {
  preloadheight = 60;
  preloadradius = 256;
  preloadtrigger = spawn("trigger_radius", self.origin, 0, preloadradius, preloadheight);
  ammobox_internalpreloadweapons(preloadtrigger);
  preloadtrigger delete();
}

function ammobox_internalpreloadweapons(preloadtrigger) {
  self endon("death");

  while(true) {
    preloadtrigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(isDefined(self.playersused[player getentitynumber()])) {
      continue;
    }

    bufferedweapon = ammobox_getbufferedweapon(player);
    loadweapons = [bufferedweapon];
    ammobox_checkclearbufferedattachmentweapon(player);
    bufferedattachmentweapon = ammobox_getbufferedattachmentweapon(player);

    if(isDefined(bufferedattachmentweapon)) {
      loadweapons[loadweapons.size] = bufferedattachmentweapon;
    }

    player loadweaponsforplayer(loadweapons, 1);
  }
}

function ammobox_makeusable() {
  scripts\common\interactive::interactive_addusedcallbacktoentity("equip_ammo_box");
  self.usedcount = 0;
  self.playersused = [];
  maketeamusable(self.team);
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
  var_47facc6abff4fd71 = gettime();

  while(true) {
    ammobox_updateplayersused();

    if(gettime() >= var_47facc6abff4fd71) {
      ammobox_updateplayerusevisibility();
      var_47facc6abff4fd71 = gettime() + 150;
    }

    waitframe();
  }
}

function ammobox_updateplayerusevisibility() {
  nearplayers = utility::playersnear(self.origin, 300);

  foreach(player in nearplayers) {
    if(isDefined(player)) {
      if(!ammobox_playercanuse(player)) {
        self disableplayeruse(player);
        continue;
      }

      self enableplayeruse(player);
    }
  }
}

function ammobox_updateplayersused() {
  foreach(player in self.playersused) {
    if(isDefined(player)) {
      entnum = player getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(player) && isDefined(self.playersused[entnum])) {
        self.playersused[entnum] = undefined;
        scripts\mp\equipment\support_box::supportbox_updateheadicon(player);
      }
    }
  }
}

function ammobox_playercanuse(player) {
  if(!scripts\mp\utility\player::isreallyalive(player)) {
    return false;
  }

  if(!player val::get("crate_use")) {
    return false;
  }

  if(isDefined(self.playersused[player getentitynumber()])) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner)) {
    return false;
  }

  return true;
}

function ammobox_onplayerholduse(player) {
  currentweapon = player.lastdroppableweaponobj;

  if(isDefined(player.minigunprevweaponobject)) {
    currentweapon = player.minigunprevweaponobject;
    player scripts\cp_mp\killstreaks\juggernaut::dropjuggernautweapon("used_ammo_box", player.miniprevweaponobject);
  }

  newweapon = ammobox_getbufferedweapon(player);
  ammobox_clearbufferedweapon(player);

  if(newweapon.basename != "iw8_lm_dblmg_mp" && player.lastweaponobj.basename != "iw9_cyberemp_mp") {
    numprimaries = player.primaryweapons.size;

    if(!player hasweapon("iw9_me_fists_mp") || numprimaries > 1) {
      player _takeweapon(currentweapon);
    }
  }

  player _giveweapon(newweapon);
  player _switchtoweaponimmediate(newweapon);

  if(player.lastweaponobj.basename == "iw9_cyberemp_mp") {
    previousweapon = player.lastdroppableweaponobj;
    player _takeweapon(previousweapon);
  }

  if(newweapon.basename == "iw8_lm_dblmg_mp") {
    player scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(newweapon, currentweapon);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(player, #"bc_flavor_player_awesome");
  }

  player playlocalsound("iw9_support_box_use");
  scripts\cp_mp\weapon::fixupplayerweapons(player, newweapon);
  return true;
}

function ammobox_getbufferedplayerdata(player) {
  if(!isDefined(player.bufferedammoboxdata)) {
    var_d4d83229875d6646 = spawnStruct();
    var_d4d83229875d6646.buffered = undefined;
    var_d4d83229875d6646.last = undefined;
    var_d4d83229875d6646.attachment = undefined;
    var_d4d83229875d6646.attachmentweapon = undefined;
    var_d4d83229875d6646.attachmentsourceweapon = undefined;
    player.bufferedammoboxdata = var_d4d83229875d6646;
  }

  return player.bufferedammoboxdata;
}

function ammobox_getbufferedweapon(player) {
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(var_d4d83229875d6646.buffered)) {
    maxattempts = 10;
    safetyvalve = 0;
    randomweapon = undefined;
    primaries = player getcurrentprimaryweaponsminusalt();

    while(safetyvalve < maxattempts) {
      randomweapon = ammobox_getrandomweapon();

      if(ammobox_isvalidrandomweapon(randomweapon, var_d4d83229875d6646.last, primaries)) {
        break;
      }

      safetyvalve++;
    }

    assert(safetyvalve < maxattempts, "<dev string:x1c>" + maxattempts + "<dev string:x57>");
    var_d4d83229875d6646.buffered = randomweapon;
  }

  return var_d4d83229875d6646.buffered;
}

function ammobox_getbufferedattachment(player) {
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(var_d4d83229875d6646.attachment)) {
    objweapon = player getcurrentprimaryweapon();

    if(!isDefined(objweapon)) {
      return undefined;
    }

    if(!ammobox_canweaponuserandomattachments(objweapon)) {
      return undefined;
    }

    if(!ammobox_canweaponacceptmoreattachments(objweapon)) {
      return undefined;
    }

    randomattachment = getrandomgraverobberattachment(objweapon);

    if(!isDefined(randomattachment)) {
      return undefined;
    }

    var_d4d83229875d6646.attachment = randomattachment;
  }

  return var_d4d83229875d6646.attachment;
}

function ammobox_getbufferedattachmentweapon(player) {
  ammobox_bufferedattachmentweapon(player);
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);
  return var_d4d83229875d6646.attachmentweapon;
}

function ammobox_getbufferedattachmentsourceweapon(player) {
  ammobox_bufferedattachmentweapon(player);
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);
  return var_d4d83229875d6646.attachmentsourceweapon;
}

function ammobox_bufferedattachmentweapon(player) {
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(var_d4d83229875d6646.attachmentweapon)) {
    bufferedattachment = ammobox_getbufferedattachment(player);

    if(!isDefined(bufferedattachment)) {
      return;
    }

    oldweapon = player getcurrentprimaryweapon();
    newweapon = addattachmenttoweapon(oldweapon, bufferedattachment);
    assertex(isDefined(newweapon), oldweapon.basename + "<dev string:x62>" + bufferedattachment);

    if(isDefined(newweapon)) {
      var_d4d83229875d6646.attachmentsourceweapon = oldweapon;
      var_d4d83229875d6646.attachmentweapon = newweapon;
    }
  }
}

function ammobox_clearbufferedweapon(player) {
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);
  var_d4d83229875d6646.last = var_d4d83229875d6646.buffered;
  var_d4d83229875d6646.buffered = undefined;
}

function ammobox_clearbufferedattachmentweapon(player) {
  var_d4d83229875d6646 = ammobox_getbufferedplayerdata(player);
  var_d4d83229875d6646.attachment = undefined;
  var_d4d83229875d6646.attachmentweapon = undefined;
  var_d4d83229875d6646.attachmentsourceweapon = undefined;
}

function ammobox_checkclearbufferedattachmentweapon(player) {
  sourceweapon = ammobox_getbufferedattachmentsourceweapon(player);
  shouldclear = 0;

  if(!isDefined(sourceweapon)) {
    shouldclear = 1;
  } else {
    currentweapon = player getcurrentprimaryweapon();

    if(!isDefined(currentweapon)) {
      shouldclear = 1;
    } else {
      sourceweaponname = scripts\mp\utility\weapon::getweaponfullname(sourceweapon);
      currentweaponname = scripts\mp\utility\weapon::getweaponfullname(currentweapon);
      shouldclear = sourceweaponname != currentweaponname;
    }
  }

  if(shouldclear) {
    ammobox_clearbufferedattachmentweapon(player);
  }
}

function ammobox_isvalidrandomweapon(randomweapon, lastweapon, primaries) {
  if(isDefined(lastweapon) && randomweapon == lastweapon) {
    return false;
  }

  foreach(primary in primaries) {
    if(primary.basename == randomweapon.basename) {
      return false;
    }
  }

  return true;
}

function ammobox_getrandomweapon() {
  randomindex = randomint(level.ammoboxweapons.totalprobability);
  runningtotal = 0;
  selectedweapon = undefined;

  for(i = 0; i < level.ammoboxweapons.weapons.size; i++) {
    runningtotal += level.ammoboxweapons.probabilities[i];

    if(runningtotal > randomindex) {
      return level.ammoboxweapons.weapons[i];
    }
  }

  assert(isDefined(selectedweapon), "<dev string:xa4>");
  return undefined;
}

function ammobox_onplayeruse(player) {
  objweapon = player getcurrentweapon();

  if(!ammobox_canweaponuserandomattachments(objweapon)) {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      player[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_INCOMPAT");
    }

    return false;
  }

  if(!ammobox_canweaponacceptmoreattachments(objweapon)) {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      player[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  results = player ammobox_giverandomattachment(objweapon);

  if(!results) {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      player[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return false;
  }

  return true;
}

function ammobox_canweaponuserandomattachments(objweapon) {
  if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(objweapon) || scripts\mp\utility\weapon::issinglehitweapon(objweapon) || scripts\mp\utility\weapon::ismeleeonly(objweapon) || objweapon.basename == "iw8_lm_dblmg_mp") {
    return false;
  }

  return true;
}

function ammobox_canweaponacceptmoreattachments(objweapon) {
  attachments = getweaponattachments(objweapon);
  attachmentcount = 0;

  foreach(attachment in attachments) {
    if(!attachmentisselectable(objweapon, attachment)) {
      continue;
    }

    attachmentcount++;
  }

  return attachmentcount < 8;
}

function ammobox_giverandomattachment(objweapon) {
  if(!isDefined(objweapon)) {
    return false;
  }

  randomattachment = ammobox_getbufferedattachment(self);
  newweaponobj = ammobox_getbufferedattachmentweapon(self);

  if(isDefined(newweaponobj)) {
    ammobox_clearbufferedattachmentweapon(self);
    altweaponobj = undefined;
    var_f184d9de2531004f = undefined;

    if(objweapon.isalternate) {
      altweaponobj = objweapon;
      objweapon = objweapon getnoaltweapon();
      var_f184d9de2531004f = scripts\mp\weapons::shouldweaponsavealtstate(objweapon);
    } else {
      altweaponobj = objweapon getaltweapon();
      var_f184d9de2531004f = 0;
    }

    var_c233f1525f444c2d = newweaponobj getaltweapon();
    mainstockammo = self getweaponammostock(objweapon);
    var_d1e8a3c0c782161f = self getweaponammoclip(objweapon, "left");
    var_3b77670cee4d09d8 = self getweaponammoclip(objweapon, "right");
    var_26f2db792005350e = self getammotype(altweaponobj);
    altstockammo = self getweaponammostock(altweaponobj);
    var_baeada8d49906593 = self getweaponammoclip(altweaponobj, "left");
    var_9ca1030d20188244 = self getweaponammoclip(altweaponobj, "right");
    weapontogive = ter_op(var_f184d9de2531004f, var_c233f1525f444c2d, newweaponobj);
    _takeweapon(objweapon);
    _giveweapon(weapontogive, -1, 0, 0);
    _switchtoweaponimmediate(weapontogive);
    scripts\cp_mp\weapon::fixupplayerweapons(self, weapontogive);
    self setweaponammostock(newweaponobj, mainstockammo);
    self setweaponammoclip(newweaponobj, var_d1e8a3c0c782161f, "left");
    self setweaponammoclip(newweaponobj, var_3b77670cee4d09d8, "right");
    var_7ffa2e286d21619a = self getammotype(var_c233f1525f444c2d);

    if(var_26f2db792005350e == var_7ffa2e286d21619a) {
      self setweaponammostock(var_c233f1525f444c2d, altstockammo);
      self setweaponammoclip(var_c233f1525f444c2d, var_baeada8d49906593, "left");
      self setweaponammoclip(var_c233f1525f444c2d, var_9ca1030d20188244, "right");
    }

    wait 0.2;
    self playlocalsound("attachment_pickup");
    currentattachments = getweaponattachments(newweaponobj);
    attachmentindex = array_find(currentattachments, randomattachment);

    if(!isDefined(attachmentindex)) {
      assertmsg("<dev string:xfc>");
    } else {
      thread ammobox_showattachmentflyout(attachmentindex);
    }

    return true;
  }

  return false;
}

function ammobox_showattachmentflyout(attachmentindex) {
  self endon("disconnect");
  pickupindex = attachmentindex + 1;

  if(istrue(self.weaponpickupflyoutbit)) {
    self.weaponpickupflyoutbit = undefined;
    pickupindex *= -1;
  } else {
    self.weaponpickupflyoutbit = 1;
  }

  self setclientomnvar("ui_weapon_pickup", pickupindex);
  waittill_any_timeout_1(1, "death");
  self setclientomnvar("ui_weapon_pickup", 0);
}

function ammobox_makedamageable() {
  thread scripts\mp\damage::monitordamage(300, "hitequip", &ammobox_handlefataldamage, &ammobox_handledamage);
}

function ammobox_handledamage(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  isenemydamage = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath)) {
    hits = ammobox_explosivedamagetohits(data, isenemydamage);
  } else if(isbulletdamage(data.meansofdeath)) {
    hits = ammobox_bulletdamagetohits(data, isenemydamage);
  }

  if(isDefined(hits)) {
    hitstokill = 20;
    return int(ceil(min(1, hits / 20) * self.maxhealth));
  }

  return data.damage;
}

function ammobox_handlefataldamage(data) {
  ammobox_givepointsfordeath(data.attacker);
  thread ammobox_destroy();
}

function ammobox_bulletdamagetohits(data, isenemydamage) {
  basehits = ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && isenemydamage, 2, 0);

  if(data.damage > 150) {
    return (basehits + 10);
  }

  if(data.damage >= 80) {
    return (basehits + 5);
  }

  if(data.damage >= 30) {
    return (basehits + 2);
  }

  return basehits + 1;
}

function ammobox_explosivedamagetohits(data, isenemydamage) {
  if(data.damage > 200) {
    return 20;
  }

  if(data.damage > 70) {
    return 10;
  }

  if(data.damage > 30) {
    return 7;
  }

  return 2;
}

function ammobox_removeowneroutline() {
  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  }
}

function ammobox_addheadicon() {
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  scripts\mp\equipment\support_box::supportbox_updateheadiconallplayers();
}

function ammobox_removeheadicon() {
  if(isDefined(self.headiconbox)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconbox);
    self.headiconbox = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }
}

function ammobox_givepointsfordeath(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
    attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

function ammobox_givexpforuse(player) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
    if(self.owner != player) {
      self.owner thread scripts\mp\utility\points::doscoreevent(#"hash_1854b1ca8856f504");
    }
  }
}

function ammobox_onmovingplatformdeath(data) {
  ammobox_destroy();
}

function ammobox_handlemovingplatforms(stuckto) {
  data = spawnStruct();
  data.linkparent = stuckto;
  data.deathoverridecallback = &ammobox_onmovingplatformdeath;
  data.endonstring = "death";
  thread scripts\mp\movers::handle_moving_platforms(data);
}

function ammobox_watchdisownedtimeout() {
  self endon("death");
  ammobox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread ammobox_destroy();
  }
}

function ammobox_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

function ammobox_empapplied(data) {
  thread ammobox_destroy();
}

function ammobox_usedcallback(entity, player) {
  thread ammobox_tryuse(entity, player);
}

function ammobox_tryuse(entity, player) {
  if(istrue(player.isusingammobox)) {
    return;
  }

  player.isusingammobox = 1;
  ammobox_tryuseinternal(entity, player);

  if(isDefined(player)) {
    player.isusingammobox = undefined;
  }
}

function ammobox_tryuseinternal(entity, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  entity endon("death");
  starttime = gettime();
  usebuttonheld = 1;

  while(gettime() - starttime < 500) {
    if(!player useButtonPressed()) {
      usebuttonheld = 0;
      break;
    }

    waitframe();
  }

  if(istrue(player.isjuggernaut)) {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      player[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(!entity ammobox_playercanuse(player)) {
    return;
  }

  result = undefined;

  if(usebuttonheld) {
    result = entity ammobox_onplayerholduse(player);
  } else {
    result = entity ammobox_onplayeruse(player);
  }

  if(result) {
    if(isDefined(entity.owner)) {
      entity.owner scripts\mp\utility\stats::incpersstat("ammoBoxUsed", 1);
      entity.owner scripts\mp\supers::combatrecordsupermisc("super_weapon_drop");
    }

    entity.usedcount++;
    entity.playersused[player getentitynumber()] = player;
    entity scripts\mp\equipment\support_box::supportbox_updateheadicon(player);
    entity ammobox_givexpforuse(player);
  }
}

function function_d78c9f174c10f8a9() {
  setdevdvar(@ "hash_dda56d67bc308c3e", 0);

  while(true) {
    if(getdvarint(@ "hash_dda56d67bc308c3e") != 0) {
      setdevdvar(@ "hash_dda56d67bc308c3e", 0);

      if(level.players.size < 1) {
        iprintlnbold("<dev string:x129>");
        continue;
      }

      firstplayer = level.players[0];
      objweapon = firstplayer getcurrentweapon();
      firstplayer ammobox_giverandomattachment(objweapon);
    }

    waitframe();
  }
}

# /