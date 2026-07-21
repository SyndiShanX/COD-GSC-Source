/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\support_box.gsc
***********************************************/

supportbox_init() {
  level.brking_watchcircletimers = [];
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0");
  scripts\common\interactive::interactive_addusedcallback(::calloutmarkerpingvo_playpredictivepingcleared, "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::_id_139B1);
  level._effect["_encstr_994F3B83D1D83782B4797F4F11708AA16898BACD297314BE0CEDEB8F078CC2E0608037D903A0F7B3E5D9D35725AD4A2FD00EABDCF8089FEBBD0DC37B59"] = loadfx("_encstr_994F3B83D1D83782B4797F4F11708AA16898BACD297314BE0CEDEB8F078CC2E0608037D903A0F7B3E5D9D35725AD4A2FD00EABDCF8089FEBBD0DC37B59");
  level._effect["_encstr_8EB239CB98596D07738BCFE54790FF02BB0833F238DDF3660B9CE0DFD081AB0C3BA8FA69C083E197A371CF0A7EC81B1949389242985B63F2DBECD0"] = loadfx("_encstr_8EB239CB98596D07738BCFE54790FF02BB0833F238DDF3660B9CE0DFD081AB0C3BA8FA69C083E197A371CF0A7EC81B1949389242985B63F2DBECD0");
}

_id_139B1(var_0) {
  foreach(var_2 in level.brking_watchcircletimers) {
    if(isDefined(var_2))
      var_2 _id_139AF(var_0);
  }
}

debug_reach_exhaust_waste(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread supportbox_watchdisownedtimeout();
  var_0 thread supportbox_hideandshowaftertime();
  var_0 thread _id_139B2(self);

  if(!scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    var_0 thread _id_139B3();

  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_4);
  var_0 setnodeploy(1);
  var_0 supportbox_handlemovingplatforms(var_4);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(var_0);

  var_0.issuper = 1;
  var_0.superid = level.superglobals.staticsuperdata[var_2].id;
  scripts\mp\weapons::onequipmentplanted(var_0, var_1, ::supportbox_destroy);
  level.brking_watchcircletimers[var_0 getentitynumber()] = var_0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::supportbox_empapplied);

  if(!istrue(var_0.madedamageable))
    var_0 supportbox_makedamageable();

  var_0.makedamageable = undefined;
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  wait 0.0;

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    var_0 supportbox_addheadicon(var_3);

  wait 0.75;
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ADB405071B8AE8", 0);
  wait(supportbox_getdeployanimduration());
  var_0 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_BE1A09DBE095E64A32C6CA", 0);
}

_id_139B2(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = scripts\engine\utility::_id_143B9(2, "_encstr_9BEC12738743F3E4FC383F10EFB9F28BAF651888");

  if(var_1 == "_encstr_995408F398012F656821") {
    return;
  }
  var_2 = undefined;
  var_3 = tablesort(self.origin, 500, 500);
  var_3[var_3.size] = self;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  var_5 = self.origin;
  var_6 = -2000.0;
  var_7 = self.origin + (0.0, 0.0, var_6);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_7, var_3, var_4);

  if(var_8["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_2 = var_8["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_2)) {
      if(tugofwar_tank(var_2))
        self.origin = var_0.origin;
    }
  }
}

_id_139B3() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  level waittill("_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");

  if(isDefined(self))
    self delete();
}

tugofwar_tank(var_0) {
  if(isDefined(level._id_145F1)) {
    foreach(var_2 in level._id_145F1._id_13C8D) {
      if(var_2 == var_0)
        return 1;
      else if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0)
        return 1;
    }
  }

  return 0;
}

supportbox_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0._id_13B87 = "_encstr_994F3B83D1D83782B4797F4F11708AA16898BACD297314BE0CEDEB8F078CC2E0608037D903A0F7B3E5D9D35725AD4A2FD00EABDCF8089FEBBD0DC37B59";
  debug_reach_exhaust_waste(var_0, "_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0", "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841", "_encstr_A6A71F0DBA23FAD21B7BCDF5CAB8D5A5C1DA2BCD3AF5DCBA3807ED9C8EF598F60F");
  var_0 thread supportbox_makeusable("_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0", &"_encstr_9AE320FBC79B3B7958B50CF187A1A1535B8796E9AD79C1682A04AF7B71B129974773");
}

calloutmarkerpingvo_playpredictivepingadded(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0._id_13B87 = "_encstr_8EB239CB98596D07738BCFE54790FF02BB0833F238DDF3660B9CE0DFD081AB0C3BA8FA69C083E197A371CF0A7EC81B1949389242985B63F2DBECD0";
  debug_reach_exhaust_waste(var_0, "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33", "_encstr_83341156B3EB23ABBF5F40A07FCA4669B35D4F", "_encstr_86D724EB1C172077A1D385D7C38A3030FFF4D12045AF40A53AF3B1A1F7B286B0978ADE19ADE0");
  var_0 thread supportbox_makeusable("_encstr_961B0FBD525BDB0B5F7F60805FAA851F33", &"_encstr_B2AE1E151719CCC8E11F100C6149CC3461E7C7860359C0E96ECE7FF1B859E92D");
}

supportbox_hideandshowaftertime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_1 = getdvarfloat("_encstr_926923270F0E1923B31B22504EF12752A0A1C977EA07E0B9CBF9191FE98FA012EE4DA8C8AD", 0);
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  wait(var_1);
  self.madedamageable = 1;
  supportbox_makedamageable();
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
}

supportbox_unset() {
  if(0) {
    foreach(var_1 in self.plantedsuperequip) {
      if(var_1.equipmentref == "_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0" || var_1.equipmentref == "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33") {
        var_1 thread supportbox_destroy();
        scripts\mp\weapons::removeequip(var_1);
      }
    }
  }
}

supportbox_explode(var_0, var_1) {
  self notify("_encstr_B21E0C317BE1BEB21E0EC6DE3259");

  if(isDefined(var_0) || isDefined(self.owner)) {
    self clearscriptabledamageowner();

    if(isDefined(var_0))
      self setentityowner(var_0);
    else
      self setentityowner(self.owner);
  }

  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  thread supportbox_delete(var_0, 0.1, var_1);
}

supportbox_destroy(var_0) {
  self endon("_encstr_B21E0C317BE1BEB21E0EC6DE3259");

  if(!isDefined(var_0))
    var_0 = !istrue(self.planted);

  var_1 = "_encstr_994F3B83D1D83782B4797F4F11708AA16898BACD297314BE0CEDEB8F078CC2E0608037D903A0F7B3E5D9D35725AD4A2FD00EABDCF8089FEBBD0DC37B59";

  if(isDefined(self._id_13B87))
    var_1 = self._id_13B87;

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

    self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_A7A408B9CA5D1D4E2C63", 0);

    if(!var_0) {
      self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_88950636C6DE9B59", 0);
      wait(var_2);
      self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ACDD0B36B1BD6E56234A19C656", 0);
      wait 1;
    }

    if(isDefined(var_4) && isent(var_4))
      var_6 = var_4.origin - var_5;

    playFX(scripts\engine\utility::getfx(var_1), var_6, var_7, var_8);
    playsoundatpos(var_6, "_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");
  }
}

supportbox_delete(var_0, var_1, var_2) {
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  supportbox_removeheadicon();
  supportbox_makeunusable();

  if(isDefined(self.owner)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33")
      self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_83341156B3EB23ABBF5F40A07FCA4669B35D4F", self.usedcount, var_0, var_2);
    else
      self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841", self.usedcount, var_0, var_2);
  }

  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  wait(var_1);

  if(isDefined(self))
    self delete();
}

supportbox_makeusable(var_0, var_1) {
  scripts\common\interactive::interactive_addusedcallbacktoentity(var_0);
  self.playersused = [];
  self.usedcount = 0;
  self makeusable();
  self setusepriority(-1);
  self enablemissilehint(1);
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(var_1);
  self setuserange(128);
  self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  self sethintrequiresholding(0);
  self sethinttag("_encstr_BA300854E318F1FF9699");
  thread supportbox_watchallplayeruse();
}

supportbox_makeunusable() {
  self notify("_encstr_95D618A2C56183E7C330931F685EADDA0F55A39DADCF2A32E850");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

supportbox_watchallplayeruse() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_95D618A2C56183E7C330931F685EADDA0F55A39DADCF2A32E850");
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

supportbox_updateplayerusevisibility() {
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

supportbox_updateplayersused() {
  foreach(var_1 in self.playersused) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self.playersused[var_2])) {
        self.playersused[var_2] = undefined;
        _id_139AF(var_1);
      }
    }
  }
}

supportbox_playercanuse(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(isDefined(self.playersused[var_0 getentitynumber()]))
    return 0;

  if(isDefined(self.owner) && scripts\cp_mp\utility\player_utility::playersareenemies(var_0, self.owner))
    return 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_91070301C2") {
    if(isDefined(self.owner) && !scripts\engine\utility::array_contains(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var_0))
      return 0;
    else if(isDefined(self.team) && self.team != var_0.team)
      return 0;
  }

  return 1;
}

supportbox_onplayeruse(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var_3) || scripts\mp\utility\weapon::issuperweapon(var_3) || scripts\mp\utility\weapon::iskillstreakweapon(var_3) || scripts\mp\utility\weapon::isgamemodeweapon(var_3)) {
      continue;
    }
    var_4 = scripts\mp\utility\weapon::getweapongroup(var_3);
    var_5 = undefined;

    if(scripts\mp\utility\weapon::issinglehitweapon(var_3))
      var_5 = 1;
    else if(var_4 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
      var_5 = 1.5;
    else
      var_5 = 3;

    var_6 = scripts\mp\weapons::getammooverride(var_3) * var_5;

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_11))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");

  if(isDefined(var_12))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);

  var_0 scripts\mp\damagefeedback::hudicontype("_encstr_A60E08C1271BEF21A882");
  _id_139AE(var_0);
  thread supportbox_onplayeruseanim();
  return 1;
}

_id_139AE(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33")
      var_0 playsoundtoplayer("_encstr_8A0D1093D8A835FDD69A6BD6654A96233BA1", var_0);
    else
      var_0 playsoundtoplayer("_encstr_A3C80F4AF0E9DFB1709519F44369C36705", var_0);
  }
}

supportbox_onplayeruseanim() {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self.onuseanimplaying)) {
    return;
  }
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_85D00887B8912E11AFFD", 0);
  self.onuseanimplaying = 1;
  wait(supportbox_getuseanimduration());
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_BE1A09DBE095E64A32C6CA", 0);
  self.onuseanimplaying = undefined;
}

supportbox_makedamageable() {
  thread scripts\mp\damage::monitordamage(100, "_encstr_A2FB098A2035874AB0F358", ::supportbox_handlefataldamage, ::supportbox_handledamage);
}

supportbox_handledamage(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 0;

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0.attacker);
  var_2 = undefined;

  if(isexplosivedamagemod(var_0.meansofdeath))
    var_2 = supportbox_explosivedamagetohits(var_0, var_1);
  else if(scripts\engine\utility::isbulletdamage(var_0.meansofdeath))
    var_2 = supportbox_bulletdamagetohits(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = 5;

    if(var_1)
      var_3 = 5;

    return int(ceil(min(1, var_2 / 5) * self.maxhealth));
  }

  return var_0.damage;
}

supportbox_handlefataldamage(var_0) {
  supportbox_givepointsfordeath(var_0.attacker);
  thread supportbox_explode(var_0.attacker, 1);
}

supportbox_bulletdamagetohits(var_0, var_1) {
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

supportbox_explosivedamagetohits(var_0, var_1) {
  if(var_0.damage > 200)
    return 20;

  if(var_0.damage > 70)
    return 10;
  else if(var_0.damage > 30)
    return 7;
  else
    return 2;
}

supportbox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

supportbox_addheadicon(var_0) {
  self.showdroplocations = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_0, 20, 1, 1000, 100, undefined, 1);
  self.showemergencyhint = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  _id_139B0();
}

supportbox_removeheadicon() {
  if(isDefined(self.showdroplocations)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showdroplocations);
    self.showdroplocations = undefined;
  }

  if(isDefined(self.showemergencyhint)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.showemergencyhint);
    self.showemergencyhint = undefined;
  }
}

supportbox_givepointsfordeath(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

supportbox_givexpforuse(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
    if(self.owner != var_0) {
      self.owner thread scripts\mp\utility\points::giveunifiedpoints("_encstr_84D61CFA80F57CF330A07E7B50B957C06F60E2B2F85B368BE9806D735541");
      self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12098(self);
    }

    self.owner scripts\mp\utility\stats::incpersstat("_encstr_A55911ADAB37A5A3D2DB37CD09ED87AA9BAC8C", 1);
    self.owner scripts\mp\supers::hide_plunderboxes("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841");
    self.usedcount++;
  }
}

supportbox_onmovingplatformdeath(var_0) {
  supportbox_destroy(1);
}

supportbox_handlemovingplatforms(var_0) {
  var_1 = spawnStruct();
  var_1.linkparent = var_0;
  var_1.deathoverridecallback = ::supportbox_onmovingplatformdeath;
  var_1.endonstring = "_encstr_AD75063D571AE108";
  var_1.validateaccuratetouching = 1;

  if(isDefined(var_0) && _calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0)) {
    var_1._id_123B4 = 1;
    self _meth_87BB(1);
  }

  thread scripts\mp\movers::handle_moving_platforms(var_1);
}

supportbox_watchdisownedtimeout() {
  self endon("_encstr_AD75063D571AE108");
  supportbox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread supportbox_destroy();
}

supportbox_watchdisownedtimeoutinternal() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

supportbox_empapplied(var_0) {
  var_1 = var_0.attacker;
  supportbox_givepointsfordeath(var_1);
  thread supportbox_destroy();
}

_id_139B0() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      return;
    }
    _id_139AF(var_1);
  }
}

_id_139AF(var_0) {
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
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\menus::_id_13733() && isDefined(self.owner))
    var_3 = scripts\engine\utility::array_contains(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.owner.team, self.owner.squadindex), var_0);
  else {
    if(isDefined(self.owner))
      var_4 = self.owner.team;
    else
      var_4 = self.team;

    var_3 = scripts\mp\utility\player::isfriendly(var_4, var_0);
  }

  var_5 = isDefined(self.playersused) && isDefined(self.playersused[var_0 getentitynumber()]);

  if(var_3 && !var_5) {
    scripts\cp_mp\entityheadicons::_id_1315D(var_1, var_0);
    scripts\cp_mp\entityheadicons::_id_1315E(var_2, var_0);
  } else if(var_3) {
    scripts\cp_mp\entityheadicons::_id_1315E(var_1, var_0);
    scripts\cp_mp\entityheadicons::_id_1315D(var_2, var_0);
  } else {
    scripts\cp_mp\entityheadicons::_id_1315E(var_1, var_0);
    scripts\cp_mp\entityheadicons::_id_1315E(var_2, var_0);
  }
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

supportbox_getdeployanimduration() {
  return getanimlength(%_encstr_83071A433061EBC3B7693FB39956AA28B9D9BACDAB808439B7411FCB);
}

#using_animtree("_encstr_B40101");

supportbox_getuseanimduration() {
  return getanimlength(%_encstr_A9BA2373A8A8C75390F94F5AD9289DB3F0815B7A33985301A0C97455F718620F803EA32399);
}

#using_animtree("_encstr_B40101");

supportbox_getcloseanimduration() {
  return getanimlength(%_encstr_8E521BB7095677EB512852BB304DA5938EE43A579DD893391FA05AA350);
}

supportbox_usedcallback(var_0, var_1) {
  if(istrue(var_1.isjuggernaut) && level.gametype != "_encstr_B607038AAB") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

    return;
  }

  if(var_0 supportbox_playercanuse(var_1)) {
    if(isDefined(level._id_12099))
      var_2 = var_0[[level._id_12099]](var_1);
    else
      var_2 = var_0 supportbox_onplayeruse(var_1);

    if(var_2) {
      var_0.playersused[var_1 getentitynumber()] = var_1;
      var_0 _id_139AF(var_1);
      var_0 supportbox_givexpforuse(var_1);
    }
  }
}

calloutmarkerpingvo_playpredictivepingcleared(var_0, var_1) {
  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

    return;
  }

  if(var_0 supportbox_playercanuse(var_1)) {
    if(isDefined(level._id_11FFE))
      var_2 = var_0[[level._id_11FFE]](var_1);
    else
      var_2 = 0;

    if(var_2 && !istrue(var_0._id_13F0F)) {
      var_0.playersused[var_1 getentitynumber()] = var_1;
      var_0 _id_139AF(var_1);
      var_0 supportbox_givexpforuse(var_1);
    }
  }
}