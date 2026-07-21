/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\ammo_box.gsc
***********************************************/

ammobox_init() {
  level.brevent3 = [];
  scripts\common\interactive::interactive_addusedcallback(::ammobox_usedcallback, "_encstr_B6820FFA831517AA4103A5BD071976473B");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::brspawnplayersending);
  level._effect["_encstr_A7B312D7AF2A0738269919B0782F303193277729"] = loadfx("_encstr_A58B337BB2F1AFF7101B1F07A36FB7C338C1FF4B4268DE83C893DD8BD998EFE33DC02077D1A3072EF40868AF277F3B6B1B0214A48B");
  level._effect["_encstr_AC882A0BE0DAF74A0FFB39ADC75713456360F6835872CFD3737FFA25208F0A1A6820BF73284B3C4BCD8C4718"] = loadfx("_encstr_AC882A0BE0DAF74A0FFB39ADC75713456360F6835872CFD3737FFA25208F0A1A6820BF73284B3C4BCD8C4718");
  level.ammoboxweapons = spawnStruct();
  level.ammoboxweapons.weapons = [];
  level.ammoboxweapons.probabilities = [];
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();

  if(scripts\mp\utility\game::usefloorrocks()) {
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
  } else {
    brrebirth_brmayconsiderplayerdead("_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_AF710BF4355A9195B0FF0AEAD0", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_AF710BF4355A9195B0FF0AEAD0", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_A3710BEEACC2E0B737EB36B676", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_A3710BEEACC2E0B737EB36B676", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_A1710B57AD31DBCDCDF1422A60", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9", var_0);
    brrebirth_brmayconsiderplayerdead("_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36", var_0);

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      ammobox_addboxweapon(getcompleteweaponname("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB"), 3);
  }

  var_1 = 0;

  foreach(var_3 in level.ammoboxweapons.probabilities)
  var_1 = var_1 + var_3;

  level.ammoboxweapons.totalprobability = var_1;
}

brrebirth_cleanupents(var_0, var_1) {
  var_2 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  var_3 = randomintrange(2, 8);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = scripts\mp\weapons::getrandomgraverobberattachment(var_2);

    if(!isDefined(var_5)) {
      break;
    }

    var_6 = scripts\mp\weapons::addattachmenttoweapon(var_2, var_5);

    if(isDefined(var_6))
      var_2 = var_6;
  }

  if(isDefined(var_2))
    ammobox_addboxweapon(var_2, 10);
}

brrebirth_brmayconsiderplayerdead(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::risktokens(var_0);
  brrebirth_cleanupents(var_2, var_1);
}

brspawnplayersending(var_0) {
  foreach(var_2 in level.brevent3) {
    if(isDefined(var_2))
      var_2 scripts\mp\equipment\support_box::_id_139AF(var_0);
  }
}

ammobox_addboxweapon(var_0, var_1) {
  var_2 = level.ammoboxweapons.weapons.size;
  var_3 = createheadicon(var_0);
  var_4 = "_encstr_B40101";
  var_5 = strtok(var_3, "_encstr_BE4C0295");
  var_4 = var_5[0];

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_8 = strtok(var_7, "_encstr_854C021F");
    var_4 = var_4 + ("_encstr_BE4C0295" + var_8[0]);
  }

  var_9 = asmdevgetallstates(var_4);
  level.ammoboxweapons.weapons[var_2] = var_9;
  level.ammoboxweapons.probabilities[var_2] = var_1;
}

ammobox_settled(var_0) {
  var_0 thread ammobox_watchdisownedtimeout();
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(var_0);

  var_0.issuper = 1;
  scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_B6820FFA831517AA4103A5BD071976473B", ::ammobox_destroy);
  level.brevent3[var_0 getentitynumber()] = var_0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::ammobox_empapplied);
  var_0 ammobox_makedamageable();

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    var_0 ammobox_addheadicon();

  var_0 thread ammobox_preloadweapons();
  var_0 thread ammobox_makeusable();
}

ammobox_destroy(var_0) {
  thread ammobox_delete(var_0, 0, 0);
}

ammobox_delete(var_0, var_1, var_2) {
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  ammobox_removeheadicon();
  ammobox_makeunusable();
  self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0", self.usedcount, var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AFCB082AC1D6A3EA7B73", 0);
  var_3 = scripts\engine\utility::getfx("_encstr_AC882A0BE0DAF74A0FFB39ADC75713456360F6835872CFD3737FFA25208F0A1A6820BF73284B3C4BCD8C4718");
  var_4 = self.origin;
  var_5 = anglesToForward(self.angles);
  var_6 = anglestoup(self.angles);
  playFX(var_3, var_4, var_5, var_6);
  self playSound("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");
  wait(var_1);
  self delete();
}

ammobox_preloadweapons() {
  var_0 = 60;
  var_1 = 256;
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, var_1, var_0);
  ammobox_internalpreloadweapons(var_2);
  var_2 delete();
}

ammobox_internalpreloadweapons(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

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

    if(isDefined(var_4))
      var_3[var_3.size] = var_4;

    var_1 loadweaponsforplayer(var_3, 1);
  }
}

ammobox_makeusable() {
  scripts\common\interactive::interactive_addusedcallbacktoentity("_encstr_B6820FFA831517AA4103A5BD071976473B");
  self.usedcount = 0;
  self.playersused = [];
  scripts\mp\utility\usability::maketeamusable(self.team);
  self enablemissilehint(1);
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(&"_encstr_A3101DB9B3E10499EC755DC1BF496C205947FE182D9F97DFCE5961D1C12F11");
  self setuserange(128);
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self sethinttag("_encstr_924D09DB90574133A0B0F4");
  thread ammobox_watchallplayeruse();
}

ammobox_makeunusable() {
  self notify("_encstr_95D618A2C56183E7C330931F685EADDA0F55A39DADCF2A32E850");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

ammobox_watchallplayeruse() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_95D618A2C56183E7C330931F685EADDA0F55A39DADCF2A32E850");
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

ammobox_updateplayerusevisibility() {
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

ammobox_updateplayersused() {
  foreach(var_1 in self.playersused) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self.playersused[var_2])) {
        self.playersused[var_2] = undefined;
        scripts\mp\equipment\support_box::_id_139AF(var_1);
      }
    }
  }
}

ammobox_playercanuse(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(isDefined(self.playersused[var_0 getentitynumber()]))
    return 0;

  if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner))
    return 0;

  return 1;
}

brregendelayspeed(var_0) {
  var_1 = var_0.lastdroppableweaponobj;

  if(isDefined(var_0.minigunprevweaponobject)) {
    var_1 = var_0.minigunprevweaponobject;
    var_0 scripts\cp_mp\killstreaks\juggernaut::dropjuggernautweapon("_encstr_B1860E4F9B31C4516B19ED6568152A90", var_0.miniprevweaponobject);
  }

  var_2 = ammobox_getbufferedweapon(var_0);
  ammobox_clearbufferedweapon(var_0);

  if(var_2.basename != "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB" && var_0.lastweaponobj.basename != "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
    var_3 = var_0.primaryweapons.size;

    if(!var_0 hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") || var_3 > 1)
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  }

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_2);

  if(var_0.lastweaponobj.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8") {
    var_4 = var_0.lastdroppableweaponobj;
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  if(var_2.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {
    var_0 scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(var_2, var_1);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "_encstr_81220F60E331839763E987947F2BCFA89D");
  }

  var_0 playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
  scripts\mp\weapons::fixupplayerweapons(var_0, var_2);

  if(isDefined(level._id_120AF))
    var_0[[level._id_120AF]](var_2);

  return 1;
}

ammobox_getbufferedplayerdata(var_0) {
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

ammobox_getbufferedweapon(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);

  if(!isDefined(var_1.buffered)) {
    var_2 = 10;
    var_3 = 0;
    var_4 = undefined;

    for(var_5 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt(); var_3 < var_2; var_3++) {
      var_4 = ammobox_getrandomweapon();

      if(ammobox_isvalidrandomweapon(var_4, var_1.last, var_5)) {
        break;
      }
    }

    var_1.buffered = var_4;
  }

  return var_1.buffered;
}

brrebirth_playernakeddroploadout(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);

  if(!isDefined(var_1.carriabletypes)) {
    var_2 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_2))
      return undefined;

    if(!brrebirth_initfeatures(var_2))
      return undefined;

    if(!brrebirth_initexternalfeatures(var_2))
      return undefined;

    var_3 = scripts\mp\weapons::getrandomgraverobberattachment(var_2);

    if(!isDefined(var_3))
      return undefined;

    var_1.carriabletypes = var_3;
  }

  return var_1.carriabletypes;
}

brrebirth_triggerrespawnoverlay(var_0) {
  brrebirth_initdialog(var_0);
  var_1 = ammobox_getbufferedplayerdata(var_0);
  return var_1.cashleaderbag_detach;
}

brrebirth_respawn(var_0) {
  brrebirth_initdialog(var_0);
  var_1 = ammobox_getbufferedplayerdata(var_0);
  return var_1.cashleader_trackdeath;
}

brrebirth_initdialog(var_0) {
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
    }
  }
}

ammobox_clearbufferedweapon(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);
  var_1.last = var_1.buffered;
  var_1.buffered = undefined;
}

brrebirth_ontimelimit(var_0) {
  var_1 = ammobox_getbufferedplayerdata(var_0);
  var_1.carriabletypes = undefined;
  var_1.cashleaderbag_detach = undefined;
  var_1.cashleader_trackdeath = undefined;
}

brrebirth_initpostmain(var_0) {
  var_1 = brrebirth_respawn(var_0);
  var_2 = 0;

  if(!isDefined(var_1))
    var_2 = 1;
  else {
    var_3 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_3))
      var_2 = 1;
    else {
      var_4 = scripts\mp\utility\weapon::getweaponfullname(var_1);
      var_5 = scripts\mp\utility\weapon::getweaponfullname(var_3);
      var_2 = var_4 != var_5;
    }
  }

  if(var_2)
    brrebirth_ontimelimit(var_0);
}

ammobox_isvalidrandomweapon(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_0 == var_1)
    return 0;

  foreach(var_4 in var_2) {
    if(var_4.basename == var_0.basename)
      return 0;
  }

  return 1;
}

ammobox_getrandomweapon() {
  var_0 = randomint(level.ammoboxweapons.totalprobability);
  var_1 = 0;
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.ammoboxweapons.weapons.size; var_3++) {
    var_1 = var_1 + level.ammoboxweapons.probabilities[var_3];

    if(var_1 > var_0)
      return level.ammoboxweapons.weapons[var_3];
  }

  return undefined;
}

ammobox_onplayeruse(var_0) {
  var_1 = var_0 getcurrentweapon();

  if(!brrebirth_initfeatures(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22918CD97E2CFC02F29BF43CF45791FC1DE74856D89ADC91709");

    return 0;
  }

  if(!brrebirth_initexternalfeatures(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_914924352879BA2A0541A79CF522927A14FA51A7E9F5D450E456BE5045A8821A426A15E4459A");

    return 0;
  }

  var_2 = var_0 brrebirth_tryrespawn(var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_914924352879BA2A0541A79CF522927A14FA51A7E9F5D450E456BE5045A8821A426A15E4459A");

    return 0;
  }

  return 1;
}

brrebirth_initfeatures(var_0) {
  if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0) || scripts\mp\utility\weapon::issinglehitweapon(var_0) || scripts\mp\utility\weapon::ismeleeonly(var_0) || var_0.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
    return 0;

  return 1;
}

brrebirth_initexternalfeatures(var_0) {
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

brrebirth_tryrespawn(var_0) {
  if(!isDefined(var_0))
    return 0;

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
    var_7 = self getweaponammoclip(var_0, "_encstr_A5AD056A019C63");
    var_8 = self getweaponammoclip(var_0, "_encstr_8253060E2B5FE330");
    var_9 = self getammotype(var_3);
    var_10 = self getweaponammostock(var_3);
    var_11 = self getweaponammoclip(var_3, "_encstr_A5AD056A019C63");
    var_12 = self getweaponammoclip(var_3, "_encstr_8253060E2B5FE330");
    var_13 = scripts\engine\utility::ter_op(var_4, var_5, var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_13, -1, 0, 0);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_13);
    scripts\mp\weapons::fixupplayerweapons(self, var_13);
    self setweaponammostock(var_2, var_6);
    self setweaponammoclip(var_2, var_7, "_encstr_A5AD056A019C63");
    self setweaponammoclip(var_2, var_8, "_encstr_8253060E2B5FE330");
    var_14 = self getammotype(var_5);

    if(var_9 == var_14) {
      self setweaponammostock(var_5, var_10);
      self setweaponammoclip(var_5, var_11, "_encstr_A5AD056A019C63");
      self setweaponammoclip(var_5, var_12, "_encstr_8253060E2B5FE330");
    }

    wait 0.2;
    self playlocalsound("_encstr_AC49121F3813C1927919EF25FD6FDB819958C7E3");
    var_15 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1, var_2);
    var_16 = getweaponattachments(var_2);
    var_17 = scripts\engine\utility::array_find(var_16, var_15);

    if(!isDefined(var_17)) {} else
      thread brregenhealthadd(var_17);

    return 1;
  }

  return 0;
}

brregenhealthadd(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 + 1;

  if(istrue(self._id_14597)) {
    self._id_14597 = undefined;
    var_1 = var_1 * -1;
  } else
    self._id_14597 = 1;

  self setclientomnvar("_encstr_AD81115796EBDD2B0B0EF69BBE38D28DB5BA83", var_1);
  scripts\engine\utility::_id_143B9(1, "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_AD81115796EBDD2B0B0EF69BBE38D28DB5BA83", 0);
}

ammobox_makedamageable() {
  thread scripts\mp\damage::monitordamage(300, "_encstr_A2FB098A2035874AB0F358", ::ammobox_handlefataldamage, ::ammobox_handledamage);
}

ammobox_handledamage(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 0;

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker);
  var_2 = undefined;

  if(isexplosivedamagemod(var_0.meansofdeath))
    var_2 = ammobox_explosivedamagetohits(var_0, var_1);
  else if(scripts\engine\utility::isbulletdamage(var_0.meansofdeath))
    var_2 = ammobox_bulletdamagetohits(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = 20;
    return int(ceil(min(1, var_2 / 20) * self.maxhealth));
  }

  return var_0.damage;
}

ammobox_handlefataldamage(var_0) {
  ammobox_givepointsfordeath(var_0.attacker);
  thread ammobox_destroy(var_0.attacker);
}

ammobox_bulletdamagetohits(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var_0.objweapon, var_0.meansofdeath, 1) && var_1, 2, 0);

  if(var_0.damage > 150)
    return var_2 + 10;

  if(var_0.damage >= 80)
    return var_2 + 5;
  else if(var_0.damage >= 30)
    return var_2 + 2;
  else
    return var_2 + 1;
}

ammobox_explosivedamagetohits(var_0, var_1) {
  if(var_0.damage > 200)
    return 20;

  if(var_0.damage > 70)
    return 10;
  else if(var_0.damage > 30)
    return 7;
  else
    return 2;
}

ammobox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

ammobox_addheadicon() {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "_encstr_8C8022535879A76AC7B095C12CFB622CC1F0ABE718B1D49267545F460F8F8AD729505FC3", 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  scripts\mp\equipment\support_box::_id_139B0();
}

ammobox_removeheadicon() {
  if(isDefined(self.showdroplocations)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showdroplocations);
    self.showdroplocations = undefined;
  }

  if(isDefined(self.showemergencyhint)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showemergencyhint);
    self.showemergencyhint = undefined;
  }
}

ammobox_givepointsfordeath(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

ammobox_givexpforuse(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    if(self.owner != var_0)
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B8CA1ACFDBBF0B677016EF7208588F83056B2F3FBB5D021F807BA7FF");
  }
}

ammobox_onmovingplatformdeath(var_0) {
  ammobox_destroy();
}

ammobox_handlemovingplatforms(var_0) {
  var_1 = spawnStruct();
  var_1.linkparent = var_0;
  var_1.deathoverridecallback = ::ammobox_onmovingplatformdeath;
  var_1.endonstring = "_encstr_AD75063D571AE108";
  thread scripts\mp\movers::handle_moving_platforms(var_1);
}

ammobox_watchdisownedtimeout() {
  self endon("_encstr_AD75063D571AE108");
  ammobox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread ammobox_destroy();
}

ammobox_watchdisownedtimeoutinternal() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

ammobox_empapplied(var_0) {
  thread ammobox_destroy();
}

ammobox_usedcallback(var_0, var_1) {
  thread brsingleuse(var_0, var_1);
}

brsingleuse(var_0, var_1) {
  if(istrue(var_1.van)) {
    return;
  }
  var_1.van = 1;
  brskipplayerkillcams(var_0, var_1);

  if(isDefined(var_1))
    var_1.van = undefined;
}

brskipplayerkillcams(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_AD75063D571AE108");
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
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

    return;
  }

  if(!var_0 ammobox_playercanuse(var_1)) {
    return;
  }
  var_4 = undefined;

  if(var_3)
    var_4 = var_0 brregendelayspeed(var_1);
  else
    var_4 = var_0 ammobox_onplayeruse(var_1);

  if(var_4) {
    if(isDefined(var_0.owner)) {
      var_0.owner scripts\mp\utility\stats::incpersstat("_encstr_994D0C3A40F3FD2BF02B457B4D79", 1);
      var_0.owner scripts\mp\supers::hide_plunderboxes("_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0");
    }

    var_0.usedcount++;
    var_0.playersused[var_1 getentitynumber()] = var_1;
    var_0 scripts\mp\equipment\support_box::_id_139AF(var_1);
    var_0 ammobox_givexpforuse(var_1);
  }
}