/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_juggernaut.gsc
***********************************************/

init() {}

jugg_makejuggernaut(var_0, var_1) {
  if(!jugg_canresolvestance(var_0))
    return 0;

  self.isjuggernaut = 1;
  self.can_revive = 0;
  self.streakinfo = var_1;
  var_2 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  var_3 = spawnStruct();
  var_3.juggconfig = var_0;
  var_3.prevhealth = self.health;
  var_3.prevmaxhealth = self.maxhealth;
  var_3.prevclothtype = self.clothtype;
  var_3.prevbody = var_2[0];
  var_3.prevhead = var_2[1];
  var_3.prevviewmodel = self getcustomizationviewmodel();
  var_3.prevspeedscale = self.playerstreakspeedscale;
  var_3.prevsuit = self.suit;
  var_3.prevstartingweap = scripts\cp\utility::getvalidtakeweapon();
  var_3.maskomnvar = "_encstr_A3B11703EBDF12090389CF0710F8FF0A53740FBFCED50A45CB";
  self.disabletakecoverwarning = 1;
  self.jugg_health = var_0.maxhealth - var_3.prevmaxhealth;
  self.maxhealth = var_0.maxhealth;
  self.health = self.maxhealth;

  if(istrue(level._id_12BAC) || istrue(level._id_12B78)) {
    var_4 = self getentitynumber();
    scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_4, "_encstr_B25D0C18B85A22CFD914E7DB5F1C", self.maxhealth);
  }

  jugg_handlestancechange(var_0);

  if(isDefined(var_0.classstruct)) {
    vehicle_handleflarerecharge(self, var_3);
    scripts\cp\cp_loadout::cargo_truck_mg_deletenextframe(self, var_0.classstruct);
    self giveweapon(self.starting_weapon);
    self setweaponammoclip(self.starting_weapon, weaponclipsize(self.starting_weapon));
    self setweaponammostock(self.starting_weapon, weaponmaxammo(self.starting_weapon));
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.starting_weapon);
  }

  jugg_toggleallows(var_0.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  jugg_setModel();
  self.playerstreakspeedscale = var_0.movespeedscalar;
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
  self setsuit(var_0.suit);
  self.suit = var_0.suit;
  self setclothtype(var_0.clothtype);
  jugg_enableoverlay(var_3);

  if(var_0.infiniteammo)
    thread infiniteammothread(var_0.infiniteammoupdaterate);

  self.juggcontext = var_3;
  self notify("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
  thread get_track_star_time_from_col();
  thread jugg_watchmusictoggle();
  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread vehicle_interact_initdev();
  thread jugg_watchfordamage();
  thread vehicle_incomingcallback();
  thread vehicle_incomingremovedcallback();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
  return 1;
}

get_track_star_time_from_col() {
  waittillframeend;

  if(isDefined(self.carryobject))
    self switchtoweapon("_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB");
}

vehicle_handleflarerecharge(var_0, var_1) {
  var_0 scripts\cp\utility::store_weapons_status();
  var_0 scripts\cp\cp_accessories::clearplayeraccessory();
  var_0 takeallweapons();
}

jugg_watchmusictoggle() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = 0;
  self notifyonplayercommand("_encstr_A54F0D334A2704D0F7F77B73E3DC60", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_A54F0D334A2704D0F7F77B73E3DC60", "_encstr_84DB11C20BBACA3B6D9821538F51EB88A108D1");
  var_1 = getcompleteweaponname("_encstr_8D711938CBB05C4FCABB2DFB6FD81B0F4FDF8918CBAFA353B7C8B8");
  var_2 = weaponfiretime(var_1);

  if(!isDefined(self.musicplaying)) {
    var_3 = self getjuggdefaultmusicenabled();
    self.musicplaying = var_3;
  }

  if(!istrue(self.musicplaying))
    self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  else
    self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_813F06832D8A18FE", 0);

  for(;;) {
    self waittill("_encstr_A54F0D334A2704D0F7F77B73E3DC60");

    if(self isonladder() || self ismantling()) {
      continue;
    }
    self giveandfireoffhand(var_1);
    self playsoundonmovingent("_encstr_8D4A19B5C1D7A657763BAFDA5DDCAF8EB7EC9D1BACAFCC7B8D56E5");
    self playlocalsound("_encstr_938A1A9DCB39AAEB047FD7177336710C10B1972581E16AA3E5210F23");
    var_4 = 0.2;

    if(istrue(self.musicplaying))
      var_4 = 0.65;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    } else {
      self.musicplaying = 1;
      self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_813F06832D8A18FE", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

jugg_watchforgameend() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = self.juggcontext;
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self.maxhealth = var_0.prevmaxhealth;
  self.health = var_0.prevhealth;
  jugg_disableoverlay(var_0);
}

jugg_watchfordisconnect() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_0 = self.juggcontext;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self)) {
    self.maxhealth = var_0.prevmaxhealth;
    self.health = var_0.prevhealth;
  }
}

vehicle_interact_initdev() {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    self.streakinfo.shots_fired++;
  }
}

jugg_removejuggernaut() {
  var_0 = self.juggcontext;
  var_1 = var_0.juggconfig;
  self.musicplaying = undefined;
  self notify("_encstr_88F016A6D53BCECAC93785571DFAAC9B32D7190BDA85EC56");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self.maxhealth = var_0.prevmaxhealth;
    self.health = var_0.prevhealth;

    if(istrue(level._id_12BAC) || istrue(level._id_12B78)) {
      var_2 = self getentitynumber();
      scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_2, "_encstr_B25D0C18B85A22CFD914E7DB5F1C", self.maxhealth);
    }

    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    jugg_toggleallows(var_1.allows, 1);

    if(isDefined(var_1.classstruct))
      scripts\cp\survival\survival_loadout::respawnitems_assignrespawnitems(var_0.respawnitems);

    foreach(var_5, var_4 in var_1.perks)
    scripts\cp\utility::_unsetperk(var_5);

    if(var_1.infiniteammo)
      stopinfiniteammothread();
  } else {}

  jugg_restoremodel(var_0);
  self.playerstreakspeedscale = var_0.prevspeedscale;
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
  self setsuit(var_0.prevsuit);
  self.suit = var_0.prevsuit;

  if(isDefined(self.prevclothtype))
    self setclothtype(var_0.prevclothtype);

  self takeallweapons();
  scripts\cp\utility::restore_weapons_status();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(scripts\cp\utility::tryingtoleave()) {
    if(isDefined(self.loadoutaccessorydata) && isDefined(self.loadoutaccessoryweapon) && self.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
      scripts\cp\cp_accessories::giveplayeraccessory(self.loadoutaccessorydata, self.loadoutaccessoryweapon, self.loadoutaccessorylogic);
  } else if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  jugg_disableoverlay(var_0);
  self setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave())
    self skydive_setbasejumpingstatus(1);

  self.damageshieldexpiretime = gettime() + 3000;
  self.isjuggernaut = 0;
  self.can_revive = 1;
  self.juggcontext = undefined;
  self.disabletakecoverwarning = undefined;
  self.jugg_health = undefined;
  thread start_regen_early();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
  self notify("_encstr_878827C01B85818ECB1FCE45E90F316FEEE340A8A29AA7C3C72CDEB3C903394F97DAD891CA750FBBD7");
  self notify("_encstr_88B00FB037873113F3557705AB596B58EC");
}

start_regen_early() {
  wait 0.1;
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
}

infiniteammothread(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_81A91A7B3DE8C3292B808A72A803DB2F462FFDEDD8B69B2CC520E29A");

  if(!isDefined(var_0))
    var_0 = level.framedurationseconds;

  for(;;) {
    if(!scripts\cp\cp_weapon::_id_124AD(self)) {
      wait(var_0);
      continue;
    }

    if(!isDefined(var_1))
      var_1 = self.equippedweapons;

    foreach(var_3 in var_1) {
      self givemaxammo(var_3);
      self setweaponammoclip(var_3, weaponclipsize(var_3));
    }

    wait(var_0);
  }
}

stopinfiniteammothread() {
  self notify("_encstr_81A91A7B3DE8C3292B808A72A803DB2F462FFDEDD8B69B2CC520E29A");
}

jugg_createconfig(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.maxhealth = 3000;
  var_2.startinghealth = var_2.maxhealth;
  var_2.movespeedscalar = -0.2;
  var_2.forcetostand = 1;
  var_2.suit = "_encstr_934212925C82495C700FDF7F3A22E3AB1B11EAC7";
  var_2.infiniteammo = 1;
  var_2.infiniteammoupdaterate = undefined;
  var_2.classstruct = jugg_getdefaultclassstruct();
  var_2.allows = [];
  var_2.allows["_encstr_83290B682399813F110463F9DD"] = 1;
  var_2.allows["_encstr_A9350D834DDE8871B8C7AD38FF21E2"] = 1;
  var_2.allows["_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F"] = 1;
  var_2.allows["_encstr_8E400866D8589B1AB2C8"] = 1;
  var_2.allows["_encstr_8ED90887F39B73AD5BFF"] = 1;
  var_2.allows["_encstr_922406F1A6FD5E05"] = 1;
  var_2.allows["_encstr_9BE40A0BC09BCEF7C0F33441"] = 1;
  var_2.allows["_encstr_BEF4071AA87BDF5220"] = 1;
  var_2.allows["_encstr_85190CAB8B3971B0A4DB2BCAC253"] = 1;
  var_2.allows["_encstr_BD6B06A64C87A9E3"] = 1;
  var_2.allows["_encstr_AF4D07932B1BDE5846"] = 1;
  var_2.allows["_encstr_914C0EDDB20B837BB97D38D2365BAB83"] = 1;
  var_2.allows["_encstr_B24E11E8C140668309413A234F0BE9176B9185"] = 0;
  var_2.perks = [];
  return var_2;
}

jugg_toggleallows(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3) {
      var_4 = tolower(var_4);
      self thread[[level.allow_funcs[var_4]]](var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    }
  }

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    scripts\common\utility::allow_mount_side(var_1, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
  }

  scripts\common\utility::allow_weapon_switch(var_1);
  scripts\common\utility::allow_vehicle_use(var_1);
}

jugg_getdefaultclassstruct() {
  var_0 = scripts\cp\cp_loadout::loadout_getclassstruct();
  var_0.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0.loadoutprimary = "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB";
  var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
  return var_0;
}

jugg_watchfordeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  jugg_removejuggernaut();
}

jugg_watchfordamage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self waittill("_encstr_88F016A6D53BCECAC93785571DFAAC9B32D7190BDA85EC56");
  jugg_removejuggernaut();
}

vehicle_incomingcallback() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self.owner = self;
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");

  if(istrue(self._id_11E8F))
    thread vehicle_incomingcallback();
  else
    jugg_removejuggernaut();
}

vehicle_incomingremovedcallback() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  self endon("_encstr_878827C01B85818ECB1FCE45E90F316FEEE340A8A29AA7C3C72CDEB3C903394F97DAD891CA750FBBD7");
  self.owner = self;
  scripts\cp\utility::_id_14441();
}

jugg_getjuggmodels() {
  var_0 = [];
  var_0["_encstr_AD9B0589ED9197"] = "_encstr_8897204CF6325EFAED07337B271BCAF53557B33BB2E473B05747BE5B07AF8DB72398";
  var_0["_encstr_81CC0586952C91"] = "_encstr_8B9B181A565819D7DBE066ED936C56AF355D9D9D2B277385BA1D";
  var_0["_encstr_9601059D5AB2EE"] = "_encstr_AF601D0348D5B77478A5E4FB2FE0BA2B0883EABA163AF7EF70AB0AFE6B68C3";
  return var_0;
}

jugg_setModel() {
  var_0 = jugg_getjuggmodels();
  var_1 = var_0["_encstr_AD9B0589ED9197"];
  var_2 = var_0["_encstr_81CC0586952C91"];
  var_3 = var_0["_encstr_9601059D5AB2EE"];
  scripts\cp\survival\survival_loadout::setcharactermodels(var_1, var_2, var_3);
}

jugg_restoremodel(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(var_0.prevbody, var_0.prevhead);
    var_1 = self getcustomizationbody();
    var_2 = self getcustomizationhead();
    var_3 = self getcustomizationviewmodel();
    scripts\cp\survival\survival_loadout::setcharactermodels(var_1, var_2, var_3);
  }
}

jugg_needtochangestance(var_0) {
  var_1 = 0;
  var_2 = self getstance();

  switch (var_2) {
    case "_encstr_A5AD069B231F0BAF":
      var_1 = 0;
      break;
    case "_encstr_B13D076BED70539F23":
      if(var_0.forcetostand || !var_0.allowcrouch) {
        var_1 = 1;
        break;
      }

      break;
    case "_encstr_922406F1A6FD5E05":
      if(var_0.forcetostand || !var_0.allowprone) {
        var_1 = 1;
        break;
      }

      break;
  }

  return var_1;
}

jugg_canresolvestance(var_0) {
  return 1;
}

jugg_handlestancechange(var_0) {
  if(jugg_needtochangestance(var_0))
    self setstance("_encstr_A5AD069B231F0BAF");
}

jugg_enableoverlay(var_0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8111084A907F4CEF60B0");
  self setclientomnvar(var_0.maskomnvar, 1);
  self.juggoverlaystatelabel = "_encstr_8111084A907F4CEF60B0";
  self.juggoverlaystate = 1;
  thread jugg_watchoverlaydamagestates(var_0);
  thread jugg_watchforoverlayexecutiontoggle(var_0);
}

jugg_watchoverlaydamagestates(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88F016A6D53BCECAC93785571DFAAC9B32D7190BDA85EC56");
  var_1 = self.health;
  var_2 = var_0.prevmaxhealth;
  var_3 = var_1 - var_2;
  var_4 = var_1 - var_3 * 0.1;
  var_5 = var_1 - var_3 * 0.35;
  var_6 = var_1 - var_3 * 0.6;
  var_7 = var_1 - var_3 * 0.85;
  var_8 = 1;
  var_9 = var_8;
  var_10 = "_encstr_8111084A907F4CEF60B0";

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F");

    if(self.health <= 0) {
      continue;
    }
    if(self.health <= var_7) {
      var_10 = "_encstr_825E15B802DFBAF11F6123338F872976733A13A04AEF61";
      var_8 = 5;
    } else if(self.health <= var_6) {
      var_10 = "_encstr_83D41161B917B05FFFFA98F07257A72897277B";
      var_8 = 4;
    } else if(self.health <= var_5) {
      var_10 = "_encstr_B2DC109A7FAFB747A9F398864F02C8C8E868";
      var_8 = 3;
    } else if(self.health <= var_4) {
      var_10 = "_encstr_BDDC100ACE8F0A87ECB8F51AAFF2278AE8BF";
      var_8 = 2;
    }

    if(var_9 != var_8) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", var_10);
      self setclientomnvar(var_0.maskomnvar, var_8);
      var_9 = var_8;
      self.juggoverlaystatelabel = var_10;
      self.juggoverlaystate = var_8;
    }
  }
}

jugg_watchforoverlayexecutiontoggle(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  var_1 = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(var_1)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", self.juggoverlaystatelabel);
        self setclientomnvar(var_0.maskomnvar, self.juggoverlaystate);
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_1)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA19049F4B2D");
      self setclientomnvar(var_0.maskomnvar, 0);
      var_1 = 1;
    }

    waitframe();
  }
}

jugg_disableoverlay(var_0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA19049F4B2D");
  self setclientomnvar(var_0.maskomnvar, 0);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

jugg_getmovespeedscalar() {
  return -0.2;
}