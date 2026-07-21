/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\placeable.gsc
***********************************************/

init() {
  if(!isDefined(level.placeableconfigs))
    level.placeableconfigs = [];
}

giveplaceable(var_0, var_1) {
  var_2 = createplaceable(var_0);
  removeperks();
  self.carrieditem = var_2;
  var_3 = onbegincarrying(var_0, var_2, 1, var_1);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var_2);
}

createplaceable(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_1 = level.placeableconfigs[var_0];
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 setModel(var_1.modelbase);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  var_2.config = var_1;
  var_2.firstplacement = 1;

  if(isDefined(var_1.oncreatedelegate))
    var_2[[var_1.oncreatedelegate]](var_0);

  var_2 deactivate(var_0);
  var_2 thread timeout(var_0);
  var_2 thread handleuse(var_0);
  var_2 thread onkillstreakdisowned(var_0);
  var_2 thread ongameended(var_0);
  return var_2;
}

handleuse(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(self getlinkedparent()))
      self unlink();

    var_1 onbegincarrying(var_0, self, 0);
  }
}

onbegincarrying(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 thread oncarried(var_0, self);
  scripts\common\utility::allow_weapon(0);

  if(!isai(self)) {
    self notifyonplayercommand("_encstr_96860F1C36851BAC4163C2C656B04CC695", "_encstr_A9E60828803C73F11780");
    self notifyonplayercommand("_encstr_96860F1C36851BAC4163C2C656B04CC695", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
    self notifyonplayercommand("_encstr_ABB1108D1673C656368263B0B1950B896356", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

    if(!self isconsoleplayer()) {
      self notifyonplayercommand("_encstr_ABB1108D1673C656368263B0B1950B896356", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
      self notifyonplayercommand("_encstr_ABB1108D1673C656368263B0B1950B896356", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
      self notifyonplayercommand("_encstr_ABB1108D1673C656368263B0B1950B896356", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
    }
  }

  for(;;) {
    if(isDefined(var_3) && var_3 == 1 && !self isonladder() && self isonground() && !self ismantling())
      var_4 = "_encstr_96860F1C36851BAC4163C2C656B04CC695";
    else
      var_4 = scripts\engine\utility::_id_143AE("_encstr_96860F1C36851BAC4163C2C656B04CC695", "_encstr_ABB1108D1673C656368263B0B1950B896356", "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");

    if(!isDefined(var_1)) {
      scripts\common\utility::allow_weapon(1);
      return 1;
    } else if(var_4 == "_encstr_ABB1108D1673C656368263B0B1950B896356" && var_2 || var_4 == "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003") {
      var_1 oncancel(var_0, var_4 == "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003" && !isDefined(var_1.firstplacement));
      return 0;
    } else if(var_1.canbeplaced) {
      var_1 thread onplaced(var_0);
      scripts\common\utility::allow_weapon(1);
      return 1;
    } else
      waitframe();
  }
}

oncancel(var_0, var_1) {
  if(isDefined(self.carriedby)) {
    var_2 = self.carriedby;
    var_2 forceusehintoff();
    var_2.iscarrying = undefined;
    var_2.carrieditem = undefined;
    var_2 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel delete();

  if(isDefined(self.carriedobj))
    self.carriedobj delete();

  var_3 = level.placeableconfigs[var_0];

  if(isDefined(var_3.oncanceldelegate))
    self[[var_3.oncanceldelegate]](var_0);

  if(isDefined(var_1) && var_1)
    scripts\mp\weapons::equipmentdeletevfx();

  self delete();
}

onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  self.origin = self.placementorigin;
  self.angles = self.carriedobj.angles;
  self playSound(var_1.placedsfx);
  showplacedmodel(var_0);

  if(isDefined(var_1.onplaceddelegate))
    self[[var_1.onplaceddelegate]](var_0);

  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self setHintString(var_1.hintstring);
  var_2 = self.owner;
  var_2 forceusehintoff();
  var_2.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(var_1.headiconheight))
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_1.headiconheight, 0, undefined, undefined, undefined, 1);

  thread handledamage(var_0);
  thread handledeath(var_0);
  self makeusable();
  scripts\mp\sentientpoolmanager::registersentient("_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", self.owner);

  foreach(var_4 in level.players) {
    if(var_4 == var_2) {
      self enableplayeruse(var_4);
      continue;
    }

    self disableplayeruse(var_4);
  }

  if(isDefined(self.shouldsplash)) {
    level thread scripts\mp\hud_util::teamplayercardsplash(var_1.splashname, var_2);
    self.shouldsplash = 0;
  }

  var_6 = spawnStruct();
  var_6.linkparent = self.moving_platform;
  var_6.playdeathfx = 1;
  var_6.endonstring = "_encstr_A93B084AF782F0DA4A04";

  if(isDefined(var_1.onmovingplatformcollision))
    var_6.deathoverridecallback = var_1.onmovingplatformcollision;

  thread scripts\mp\movers::handle_moving_platforms(var_6);
  thread watchplayerconnected();
  self notify("_encstr_B8B00782A191CB07D9");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

oncarried(var_0, var_1) {
  var_2 = level.placeableconfigs[var_0];
  self.carriedobj = var_1 createcarriedobject(var_0);
  self.isplaced = undefined;
  self.carriedby = var_1;
  var_1.iscarrying = 1;
  deactivate(var_0);
  hideplacedmodel(var_0);

  if(isDefined(var_2.oncarrieddelegate))
    self[[var_2.oncarrieddelegate]](var_0);

  thread updateplacement(var_0, var_1);
  thread oncarrierdeath(var_0, var_1);
  self notify("_encstr_A93B084AF782F0DA4A04");
}

updateplacement(var_0, var_1) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  self.canbeplaced = 1;
  var_2 = -1;
  var_3 = level.placeableconfigs[var_0];
  var_4 = (0, 0, 0);

  if(isDefined(var_3.placementoffsetz))
    var_4 = (0, 0, var_3.placementoffsetz);

  var_5 = self.carriedobj;

  for(;;) {
    var_6 = var_1 canplayerplacesentry(1, var_3.placementradius);
    self.placementorigin = var_6["_encstr_97FE07DE392D76D2CD"];
    var_5.origin = self.placementorigin + var_4;
    var_5.angles = var_6["_encstr_A7610758E6CED8569B"];
    self.canbeplaced = var_1 isonground() && var_6["_encstr_9B7C07725D17A39473"] && abs(self.placementorigin[2] - var_1.origin[2]) < var_3.placementheighttolerance;

    if(isDefined(var_6["_encstr_850E077B0BF30318B9"]))
      self.moving_platform = var_6["_encstr_850E077B0BF30318B9"];
    else
      self.moving_platform = undefined;

    if(self.canbeplaced != var_2) {
      if(self.canbeplaced) {
        var_5 setModel(var_3.modelplacement);
        var_1 forceusehinton(var_3.placestring);
      } else {
        var_5 setModel(var_3.modelplacementfailed);
        var_1 forceusehinton(var_3.cannotplacestring);
      }
    }

    var_2 = self.canbeplaced;
    waitframe();
  }
}

deactivate(var_0) {
  self makeunusable();
  hideheadicons();
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.ondeactivedelegate))
    self[[var_1.ondeactivedelegate]](var_0);
}

hideheadicons() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

handledamage(var_0) {
  self endon("_encstr_A93B084AF782F0DA4A04");
  var_1 = level.placeableconfigs[var_0];
  scripts\mp\damage::monitordamage(var_1.maxhealth, var_1.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = self.config;

  if(isDefined(var_7.allowmeleedamage) && var_7.allowmeleedamage)
    var_6 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_6);

  if(isDefined(var_7.allowempdamage) && var_7.allowempdamage)
    var_6 = scripts\mp\damage::handleempdamage(var_2, var_3, var_6);

  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlegrenadedamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);

  if(isDefined(var_7.modifydamage))
    var_6 = self[[var_7.modifydamage]](var_2, var_3, var_6);

  return var_6;
}

handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = self.config;
  var_6 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_1, var_2, var_3, var_4, var_5.scorepopup, var_5.destroyedvo);

  if(var_6 && isDefined(var_5.ondestroyeddelegate))
    self[[var_5.ondestroyeddelegate]](self.streakname, var_1, self.owner, var_3);
}

handledeath(var_0) {
  self endon("_encstr_A93B084AF782F0DA4A04");
  self waittill("_encstr_AD75063D571AE108");
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(self)) {
    deactivate(var_0);

    if(isDefined(var_1.modeldestroyed))
      self setModel(var_1.modeldestroyed);

    if(isDefined(var_1.ondeathdelegate))
      self[[var_1.ondeathdelegate]](var_0);

    self delete();
  }
}

oncarrierdeath(var_0, var_1) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 waittill("_encstr_AD75063D571AE108");

  if(self.canbeplaced)
    thread onplaced(var_0);
  else
    oncancel(var_0);
}

onkillstreakdisowned(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  childthread watchownerstatus("_encstr_8D820B49520F0EC02DDE6367EC", var_0);
  childthread watchownerstatus("_encstr_81170C244F9CBDE72C01BB99A298", var_0);
  childthread watchownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", var_0);
}

watchownerstatus(var_0, var_1) {
  self.owner waittill(var_0);
  cleanup(var_1);
}

ongameended(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  cleanup(var_0);
}

cleanup(var_0) {
  if(isDefined(self.isplaced))
    self notify("_encstr_AD75063D571AE108");
  else
    oncancel(var_0);
}

watchplayerconnected() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    thread onplayerconnected(var_0);
  }
}

onplayerconnected(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self disableplayeruse(var_0);
}

timeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = level.placeableconfigs[var_0];
  var_2 = var_1.lifespan;

  while(var_2 > 0.0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      var_2 = var_2 - 1.0;
  }

  if(isDefined(self.owner) && isDefined(var_1.gonevo))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var_1.gonevo);

  self notify("_encstr_AD75063D571AE108");
}

removeweapons() {
  if(self hasweapon("_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1")) {
    self.restoreweapon = "_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1");
  }
}

removeperks() {
  if(scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    self.restoreperk = "_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B";
    scripts\mp\utility\perk::removeperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\perk::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

showplacedmodel(var_0) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("_encstr_91B411BAE0190B1D59FA26BDB64C6E17AEC219");
  }
}

hideplacedmodel(var_0) {
  self hide();

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel hide();
}

createcarriedobject(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_1 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", self.origin + (0, 0, 25), "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043");
  var_1.angles = self.angles;
  var_1.owner = self;
  var_2 = level.placeableconfigs[var_0];
  var_1 setModel(var_2.modelbase);
  var_1 maketurretinoperable();
  var_1 setturretmodechangewait(1);
  var_1 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_1 makeunusable();
  var_1 setsentryowner(self);
  var_1 setsentrycarrier(self);
  var_1 setCanDamage(0);
  var_1 notsolid();
  return var_1;
}