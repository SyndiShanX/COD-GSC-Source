/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\ammo_box.gsc
***********************************************/

ammobox_init() {
  level.allammoboxes = [];
  scripts\common\interactive::interactive_addusedcallback(::ammobox_usedcallback, "equip_ammo_box");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::ammobox_updateheadicononjointeam);
  level._effect["weapon_box_impact"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  level.ammoboxweapons = spawnStruct();
  level.ammoboxweapons.weapons = [];
  level.ammoboxweapons.probabilities = [];
  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  ammobox_addrandomweapon("weapon_assault", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_assault", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_battle", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_smg", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_smg", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_lmg", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_lmg", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_sniper", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_dmr", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_shotgun", _id_11A1FA68AEB971C0);
  ammobox_addrandomweapon("weapon_pistol", _id_11A1FA68AEB971C0);

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    ammobox_addboxweapon(makeweapon("iw8_lm_dblmg_mp"), 3);

  totalprobability = 0;

  foreach(_id_7E1B02C65B1197C8 in level.ammoboxweapons.probabilities)
  totalprobability = totalprobability + _id_7E1B02C65B1197C8;

  level.ammoboxweapons.totalprobability = totalprobability;
}

ammobox_addrandomweapon(_id_CF4209C200F8BBF4, _id_11A1FA68AEB971C0) {
  _id_72C4B0AF1A85887E = scripts\mp\utility\weapon::getrandomweaponfromgroup(_id_CF4209C200F8BBF4);
  _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon(_id_72C4B0AF1A85887E, undefined, undefined, undefined, undefined, undefined, undefined, undefined, _id_11A1FA68AEB971C0);
  _id_C8616C37BC30098B = randomintrange(2, 8);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C8616C37BC30098B; _id_AC0E594AC96AA3A8++) {
    attachment = scripts\mp\weapons::getrandomgraverobberattachment(_id_B8215055A946EEBB);

    if(!isDefined(attachment)) {
      break;
    }

    _id_66B3DB972AC1531E = scripts\mp\weapons::addattachmenttoweapon(_id_B8215055A946EEBB, attachment);

    if(isDefined(_id_66B3DB972AC1531E))
      _id_B8215055A946EEBB = _id_66B3DB972AC1531E;
  }

  if(isDefined(_id_B8215055A946EEBB))
    ammobox_addboxweapon(_id_B8215055A946EEBB, 10);
}

ammobox_updateheadicononjointeam(player) {
  foreach(_id_29B1A37EC8B83EC4 in level.allammoboxes) {
    if(isDefined(_id_29B1A37EC8B83EC4))
      _id_29B1A37EC8B83EC4 scripts\mp\equipment\support_box::supportbox_updateheadicon(player);
  }
}

ammobox_addboxweapon(weaponobj, _id_7E1B02C65B1197C8) {
  currentindex = level.ammoboxweapons.weapons.size;
  fullweaponname = getcompleteweaponname(weaponobj);
  _id_D4CCFB9E7F269C94 = "";
  _id_397643D76339E313 = strtok(fullweaponname, "+");
  _id_D4CCFB9E7F269C94 = _id_397643D76339E313[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_397643D76339E313.size; _id_AC0E594AC96AA3A8++) {
    _id_E97377032A878881 = _id_397643D76339E313[_id_AC0E594AC96AA3A8];
    _id_1B9400FECA67DF65 = strtok(_id_E97377032A878881, "|");
    _id_D4CCFB9E7F269C94 = _id_D4CCFB9E7F269C94 + ("+" + _id_1B9400FECA67DF65[0]);
  }

  _id_565DA446B4A1827C = makeweaponfromstring(_id_D4CCFB9E7F269C94);
  level.ammoboxweapons.weapons[currentindex] = _id_565DA446B4A1827C;
  level.ammoboxweapons.probabilities[currentindex] = _id_7E1B02C65B1197C8;
}

ammobox_settled(grenade) {
  grenade thread ammobox_watchdisownedtimeout();
  self setscriptablepartstate("visibility", "show", 0);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(grenade);

  grenade.issuper = 1;
  scripts\mp\weapons::onequipmentplanted(grenade, "equip_ammo_box", ::ammobox_destroy);
  level.allammoboxes[grenade getentitynumber()] = grenade;
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::ammobox_empapplied);
  grenade ammobox_makedamageable();

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    grenade ammobox_addheadicon();

  grenade thread ammobox_preloadweapons();
  grenade thread ammobox_makeusable();
}

ammobox_destroy() {
  thread ammobox_delete(0, 0);
}

ammobox_delete(_id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  ammobox_removeheadicon();
  ammobox_makeunusable();
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
  self setscriptablepartstate("effects", "destroy", 0);
  effectid = scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  origin = self.origin;
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  playFX(effectid, origin, forward, up);
  self playSound("mp_equip_box_destroyed");
  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

ammobox_preloadweapons() {
  _id_74AFD4859E6F7819 = 60;
  _id_66F365FE0455BA18 = 256;
  _id_B0A8A6BCA6EDDC1A = spawn("trigger_radius", self.origin, 0, _id_66F365FE0455BA18, _id_74AFD4859E6F7819);
  ammobox_internalpreloadweapons(_id_B0A8A6BCA6EDDC1A);
  _id_B0A8A6BCA6EDDC1A delete();
}

ammobox_internalpreloadweapons(_id_B0A8A6BCA6EDDC1A) {
  self endon("death");

  for(;;) {
    _id_B0A8A6BCA6EDDC1A waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(self.playersused[player getentitynumber()])) {
      continue;
    }
    _id_908451D7457E7016 = ammobox_getbufferedweapon(player);
    loadweapons = [_id_908451D7457E7016];
    ammobox_checkclearbufferedattachmentweapon(player);
    _id_C09BC44482316673 = ammobox_getbufferedattachmentweapon(player);

    if(isDefined(_id_C09BC44482316673))
      loadweapons[loadweapons.size] = _id_C09BC44482316673;

    player loadweaponsforplayer(loadweapons, 1);
  }
}

ammobox_makeusable() {
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

ammobox_makeunusable() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

ammobox_watchallplayeruse() {
  self endon("death");
  self endon("supportBox_makeUnusable");
  _id_47FACC6ABFF4FD71 = gettime();

  for(;;) {
    ammobox_updateplayersused();

    if(gettime() >= _id_47FACC6ABFF4FD71) {
      ammobox_updateplayerusevisibility();
      _id_47FACC6ABFF4FD71 = gettime() + 150;
    }

    waitframe();
  }
}

ammobox_updateplayerusevisibility() {
  _id_EF269077A28646EB = scripts\common\utility::playersnear(self.origin, 300);

  foreach(player in _id_EF269077A28646EB) {
    if(isDefined(player)) {
      if(!ammobox_playercanuse(player)) {
        self disableplayeruse(player);
        continue;
      }

      self enableplayeruse(player);
    }
  }
}

ammobox_updateplayersused() {
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

ammobox_playercanuse(player) {
  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("crate_use"))
    return 0;

  if(isDefined(self.playersused[player getentitynumber()]))
    return 0;

  if(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))
    return 0;

  return 1;
}

ammobox_onplayerholduse(player) {
  currentweapon = player.lastdroppableweaponobj;

  if(isDefined(player.minigunprevweaponobject)) {
    currentweapon = player.minigunprevweaponobject;
    player scripts\cp_mp\killstreaks\juggernaut::dropjuggernautweapon("used_ammo_box", player.miniprevweaponobject);
  }

  _id_DD515FCF025B2E79 = ammobox_getbufferedweapon(player);
  ammobox_clearbufferedweapon(player);

  if(_id_DD515FCF025B2E79.basename != "iw8_lm_dblmg_mp" && player.lastweaponobj.basename != "iw9_cyberemp_mp") {
    _id_060012A0838191D7 = player.primaryweapons.size;

    if(!player hasweapon("iw9_me_fists_mp") || _id_060012A0838191D7 > 1)
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
  }

  player scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_DD515FCF025B2E79);
  player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DD515FCF025B2E79);

  if(player.lastweaponobj.basename == "iw9_cyberemp_mp") {
    _id_17372FFC28DC7D78 = player.lastdroppableweaponobj;
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_17372FFC28DC7D78);
  }

  if(_id_DD515FCF025B2E79.basename == "iw8_lm_dblmg_mp") {
    player scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(_id_DD515FCF025B2E79, currentweapon);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(player, "stat_7CB1A871B292B051");
  }

  player playlocalsound("iw9_support_box_use");
  scripts\mp\weapons::fixupplayerweapons(player, _id_DD515FCF025B2E79);
  return 1;
}

ammobox_getbufferedplayerdata(player) {
  if(!isDefined(player.bufferedammoboxdata)) {
    _id_D4D83229875D6646 = spawnStruct();
    _id_D4D83229875D6646.buffered = undefined;
    _id_D4D83229875D6646.last = undefined;
    _id_D4D83229875D6646.attachment = undefined;
    _id_D4D83229875D6646.attachmentweapon = undefined;
    _id_D4D83229875D6646.attachmentsourceweapon = undefined;
    player.bufferedammoboxdata = _id_D4D83229875D6646;
  }

  return player.bufferedammoboxdata;
}

ammobox_getbufferedweapon(player) {
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(_id_D4D83229875D6646.buffered)) {
    _id_3B5686B7D0848557 = 10;
    _id_E26FF636F4ED6943 = 0;
    _id_72C4B0AF1A85887E = undefined;

    for(_id_BC002676438672C9 = player scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt(); _id_E26FF636F4ED6943 < _id_3B5686B7D0848557; _id_E26FF636F4ED6943++) {
      _id_72C4B0AF1A85887E = ammobox_getrandomweapon();

      if(ammobox_isvalidrandomweapon(_id_72C4B0AF1A85887E, _id_D4D83229875D6646.last, _id_BC002676438672C9)) {
        break;
      }
    }

    _id_D4D83229875D6646.buffered = _id_72C4B0AF1A85887E;
  }

  return _id_D4D83229875D6646.buffered;
}

ammobox_getbufferedattachment(player) {
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(_id_D4D83229875D6646.attachment)) {
    objweapon = player getcurrentprimaryweapon();

    if(!isDefined(objweapon))
      return undefined;

    if(!ammobox_canweaponuserandomattachments(objweapon))
      return undefined;

    if(!ammobox_canweaponacceptmoreattachments(objweapon))
      return undefined;

    _id_7779125EA10FE77B = scripts\mp\weapons::getrandomgraverobberattachment(objweapon);

    if(!isDefined(_id_7779125EA10FE77B))
      return undefined;

    _id_D4D83229875D6646.attachment = _id_7779125EA10FE77B;
  }

  return _id_D4D83229875D6646.attachment;
}

ammobox_getbufferedattachmentweapon(player) {
  ammobox_bufferedattachmentweapon(player);
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);
  return _id_D4D83229875D6646.attachmentweapon;
}

ammobox_getbufferedattachmentsourceweapon(player) {
  ammobox_bufferedattachmentweapon(player);
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);
  return _id_D4D83229875D6646.attachmentsourceweapon;
}

ammobox_bufferedattachmentweapon(player) {
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);

  if(!isDefined(_id_D4D83229875D6646.attachmentweapon)) {
    _id_746516231320A2A3 = ammobox_getbufferedattachment(player);

    if(!isDefined(_id_746516231320A2A3)) {
      return;
    }
    _id_F0FFAFCA5D927A12 = player getcurrentprimaryweapon();
    _id_DD515FCF025B2E79 = scripts\mp\weapons::addattachmenttoweapon(_id_F0FFAFCA5D927A12, _id_746516231320A2A3);

    if(isDefined(_id_DD515FCF025B2E79)) {
      _id_D4D83229875D6646.attachmentsourceweapon = _id_F0FFAFCA5D927A12;
      _id_D4D83229875D6646.attachmentweapon = _id_DD515FCF025B2E79;
    }
  }
}

ammobox_clearbufferedweapon(player) {
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);
  _id_D4D83229875D6646.last = _id_D4D83229875D6646.buffered;
  _id_D4D83229875D6646.buffered = undefined;
}

ammobox_clearbufferedattachmentweapon(player) {
  _id_D4D83229875D6646 = ammobox_getbufferedplayerdata(player);
  _id_D4D83229875D6646.attachment = undefined;
  _id_D4D83229875D6646.attachmentweapon = undefined;
  _id_D4D83229875D6646.attachmentsourceweapon = undefined;
}

ammobox_checkclearbufferedattachmentweapon(player) {
  _id_7BB5165F56FAF770 = ammobox_getbufferedattachmentsourceweapon(player);
  _id_C4A7DB4763EB0687 = 0;

  if(!isDefined(_id_7BB5165F56FAF770))
    _id_C4A7DB4763EB0687 = 1;
  else {
    currentweapon = player getcurrentprimaryweapon();

    if(!isDefined(currentweapon))
      _id_C4A7DB4763EB0687 = 1;
    else {
      _id_60D6979D461D8AB3 = scripts\mp\utility\weapon::getweaponfullname(_id_7BB5165F56FAF770);
      _id_03549C153A27C9BD = scripts\mp\utility\weapon::getweaponfullname(currentweapon);
      _id_C4A7DB4763EB0687 = _id_60D6979D461D8AB3 != _id_03549C153A27C9BD;
    }
  }

  if(_id_C4A7DB4763EB0687)
    ammobox_clearbufferedattachmentweapon(player);
}

ammobox_isvalidrandomweapon(_id_72C4B0AF1A85887E, lastweapon, _id_BC002676438672C9) {
  if(isDefined(lastweapon) && _id_72C4B0AF1A85887E == lastweapon)
    return 0;

  foreach(primary in _id_BC002676438672C9) {
    if(primary.basename == _id_72C4B0AF1A85887E.basename)
      return 0;
  }

  return 1;
}

ammobox_getrandomweapon() {
  _id_610520BE555433B2 = randomint(level.ammoboxweapons.totalprobability);
  _id_0E1321B920805C42 = 0;
  _id_4BF97A8A5D58DDB4 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ammoboxweapons.weapons.size; _id_AC0E594AC96AA3A8++) {
    _id_0E1321B920805C42 = _id_0E1321B920805C42 + level.ammoboxweapons.probabilities[_id_AC0E594AC96AA3A8];

    if(_id_0E1321B920805C42 > _id_610520BE555433B2)
      return level.ammoboxweapons.weapons[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

ammobox_onplayeruse(player) {
  objweapon = player getcurrentweapon();

  if(!ammobox_canweaponuserandomattachments(objweapon)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_INCOMPAT");

    return 0;
  }

  if(!ammobox_canweaponacceptmoreattachments(objweapon)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");

    return 0;
  }

  results = player ammobox_giverandomattachment(objweapon);

  if(!results) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");

    return 0;
  }

  return 1;
}

ammobox_canweaponuserandomattachments(objweapon) {
  if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(objweapon) || scripts\mp\utility\weapon::issinglehitweapon(objweapon) || scripts\mp\utility\weapon::ismeleeonly(objweapon) || objweapon.basename == "iw8_lm_dblmg_mp")
    return 0;

  return 1;
}

ammobox_canweaponacceptmoreattachments(objweapon) {
  attachments = getweaponattachments(objweapon);
  _id_A28F4E760500001B = 0;

  foreach(attachment in attachments) {
    if(!scripts\mp\utility\weapon::attachmentisselectable(objweapon, attachment)) {
      continue;
    }
    _id_A28F4E760500001B++;
  }

  return _id_A28F4E760500001B < 8;
}

ammobox_giverandomattachment(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  _id_7779125EA10FE77B = ammobox_getbufferedattachment(self);
  _id_66B3DB972AC1531E = ammobox_getbufferedattachmentweapon(self);

  if(isDefined(_id_66B3DB972AC1531E)) {
    ammobox_clearbufferedattachmentweapon(self);
    _id_A0F049FA949F48E9 = undefined;
    _id_F184D9DE2531004F = undefined;

    if(objweapon.isalternate) {
      _id_A0F049FA949F48E9 = objweapon;
      objweapon = objweapon getnoaltweapon();
      _id_F184D9DE2531004F = scripts\mp\weapons::shouldweaponsavealtstate(objweapon);
    } else {
      _id_A0F049FA949F48E9 = objweapon getaltweapon();
      _id_F184D9DE2531004F = 0;
    }

    _id_C233F1525F444C2D = _id_66B3DB972AC1531E getaltweapon();
    _id_502CAE5AA3E6C1DC = self getweaponammostock(objweapon);
    _id_D1E8A3C0C782161F = self getweaponammoclip(objweapon, "left");
    _id_3B77670CEE4D09D8 = self getweaponammoclip(objweapon, "right");
    _id_26F2DB792005350E = self getammotype(_id_A0F049FA949F48E9);
    altstockammo = self getweaponammostock(_id_A0F049FA949F48E9);
    _id_BAEADA8D49906593 = self getweaponammoclip(_id_A0F049FA949F48E9, "left");
    _id_9CA1030D20188244 = self getweaponammoclip(_id_A0F049FA949F48E9, "right");
    _id_72672CD81EC1093D = scripts\engine\utility::ter_op(_id_F184D9DE2531004F, _id_C233F1525F444C2D, _id_66B3DB972AC1531E);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(objweapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_72672CD81EC1093D, -1, 0, 0);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_72672CD81EC1093D);
    scripts\mp\weapons::fixupplayerweapons(self, _id_72672CD81EC1093D);
    self setweaponammostock(_id_66B3DB972AC1531E, _id_502CAE5AA3E6C1DC);
    self setweaponammoclip(_id_66B3DB972AC1531E, _id_D1E8A3C0C782161F, "left");
    self setweaponammoclip(_id_66B3DB972AC1531E, _id_3B77670CEE4D09D8, "right");
    _id_7FFA2E286D21619A = self getammotype(_id_C233F1525F444C2D);

    if(_id_26F2DB792005350E == _id_7FFA2E286D21619A) {
      self setweaponammostock(_id_C233F1525F444C2D, altstockammo);
      self setweaponammoclip(_id_C233F1525F444C2D, _id_BAEADA8D49906593, "left");
      self setweaponammoclip(_id_C233F1525F444C2D, _id_9CA1030D20188244, "right");
    }

    wait 0.2;
    self playlocalsound("attachment_pickup");
    _id_DFAF5DD7FB4C5238 = getweaponattachments(_id_66B3DB972AC1531E);
    _id_DF6D8E005B4B8020 = scripts\engine\utility::array_find(_id_DFAF5DD7FB4C5238, _id_7779125EA10FE77B);

    if(!isDefined(_id_DF6D8E005B4B8020)) {} else
      thread ammobox_showattachmentflyout(_id_DF6D8E005B4B8020);

    return 1;
  }

  return 0;
}

ammobox_showattachmentflyout(_id_DF6D8E005B4B8020) {
  self endon("disconnect");
  _id_E2BBA4EF3D8B3B2F = _id_DF6D8E005B4B8020 + 1;

  if(istrue(self.weaponpickupflyoutbit)) {
    self.weaponpickupflyoutbit = undefined;
    _id_E2BBA4EF3D8B3B2F = _id_E2BBA4EF3D8B3B2F * -1;
  } else
    self.weaponpickupflyoutbit = 1;

  self setclientomnvar("ui_weapon_pickup", _id_E2BBA4EF3D8B3B2F);
  scripts\engine\utility::waittill_any_timeout_1(1, "death");
  self setclientomnvar("ui_weapon_pickup", 0);
}

ammobox_makedamageable() {
  thread scripts\mp\damage::monitordamage(300, "hitequip", ::ammobox_handlefataldamage, ::ammobox_handledamage);
}

ammobox_handledamage(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 0;

  _id_10D243B75EC6D6AE = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath))
    hits = ammobox_explosivedamagetohits(data, _id_10D243B75EC6D6AE);
  else if(scripts\engine\utility::isbulletdamage(data.meansofdeath))
    hits = ammobox_bulletdamagetohits(data, _id_10D243B75EC6D6AE);

  if(isDefined(hits)) {
    hitstokill = 20;
    return int(ceil(min(1, hits / 20) * self.maxhealth));
  }

  return data.damage;
}

ammobox_handlefataldamage(data) {
  ammobox_givepointsfordeath(data.attacker);
  thread ammobox_destroy();
}

ammobox_bulletdamagetohits(data, _id_10D243B75EC6D6AE) {
  _id_2DDCAF824AC5D676 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && _id_10D243B75EC6D6AE, 2, 0);

  if(data.damage > 150)
    return _id_2DDCAF824AC5D676 + 10;

  if(data.damage >= 80)
    return _id_2DDCAF824AC5D676 + 5;
  else if(data.damage >= 30)
    return _id_2DDCAF824AC5D676 + 2;
  else
    return _id_2DDCAF824AC5D676 + 1;
}

ammobox_explosivedamagetohits(data, _id_10D243B75EC6D6AE) {
  if(data.damage > 200)
    return 20;

  if(data.damage > 70)
    return 10;
  else if(data.damage > 30)
    return 7;
  else
    return 2;
}

ammobox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

ammobox_addheadicon() {
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  scripts\mp\equipment\support_box::supportbox_updateheadiconallplayers();
}

ammobox_removeheadicon() {
  if(isDefined(self.headiconbox)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconbox);
    self.headiconbox = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }
}

ammobox_givepointsfordeath(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

ammobox_givexpforuse(player) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
    if(self.owner != player)
      self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1854B1CA8856F504");
  }
}

ammobox_onmovingplatformdeath(data) {
  ammobox_destroy();
}

ammobox_handlemovingplatforms(stuckto) {
  data = spawnStruct();
  data.linkparent = stuckto;
  data.deathoverridecallback = ::ammobox_onmovingplatformdeath;
  data.endonstring = "death";
  thread scripts\mp\movers::handle_moving_platforms(data);
}

ammobox_watchdisownedtimeout() {
  self endon("death");
  ammobox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread ammobox_destroy();
}

ammobox_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

ammobox_empapplied(data) {
  thread ammobox_destroy();
}

ammobox_usedcallback(entity, player) {
  thread ammobox_tryuse(entity, player);
}

ammobox_tryuse(entity, player) {
  if(istrue(player.isusingammobox)) {
    return;
  }
  player.isusingammobox = 1;
  ammobox_tryuseinternal(entity, player);

  if(isDefined(player))
    player.isusingammobox = undefined;
}

ammobox_tryuseinternal(entity, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  entity endon("death");
  starttime = gettime();
  _id_E6FEBE85E4636F53 = 1;

  while(gettime() - starttime < 500) {
    if(!player useButtonPressed()) {
      _id_E6FEBE85E4636F53 = 0;
      break;
    }

    waitframe();
  }

  if(istrue(player.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");

    return;
  }

  if(!entity ammobox_playercanuse(player)) {
    return;
  }
  result = undefined;

  if(_id_E6FEBE85E4636F53)
    result = entity ammobox_onplayerholduse(player);
  else
    result = entity ammobox_onplayeruse(player);

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