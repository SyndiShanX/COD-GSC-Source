/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\placeable.gsc
************************************************/

function init() {
  if(!isDefined(level.placeableconfigs)) {
    level.placeableconfigs = [];
    return;
  }
}

function giveplaceable(var_0, var_1) {
  var_2 = createplaceable(var_0);
  removeperks();
  self.carrieditem = var_2;
  var_3 = onbegincarrying(var_0, var_2, 1, var_1);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var_2);
}

function createplaceable(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var_1 = level.placeableconfigs[var_0];
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(var_1.modelbase);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  var_2.config = var_1;
  var_2.firstplacement = 1;

  if(isDefined(var_1.oncreatedelegate)) {
    var_2[[var_1.oncreatedelegate]](var_0);
  }

  deactivate(var_2, var_0);
  thread timeout(var_2);
  thread handleuse(var_2);
  thread onkillstreakdisowned(var_2);
  thread ongameended(var_2);
  return var_2;
}

function handleuse(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    onbegincarrying(var_1, var_0, self, 0);
  }
}

function onbegincarrying(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  thread oncarried(var_1, var_0);
  scripts\common\utility::allow_weapon(0);
  jumpiftrue(isai(self)) LOC_00000085;
  self notifyonplayercommand("placePlaceable", "+attack");
  self notifyonplayercommand("placePlaceable", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancelPlaceable", "+actionslot 4");
  jumpiftrue(self isconsoleplayer()) LOC_00000085;
  self notifyonplayercommand("cancelPlaceable", "+actionslot 5");
  self notifyonplayercommand("cancelPlaceable", "+actionslot 6");
  self notifyonplayercommand("cancelPlaceable", "+actionslot 7");

  for(;;) {
    if(isDefined(var_3) && var_3 == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      var_4 = "placePlaceable";
    } else {
      var_4 = scripts\engine\utility::ref_143ae("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(var_1)) {
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    if(var_4 == "cancelPlaceable" && var_2 || var_4 == "force_cancel_placement") {
      oncancel(var_1, var_0, var_4 == "force_cancel_placement" && !isDefined(var_1.firstplacement));
      return 0;
    }

    if(var_1.canbeplaced) {
      thread onplaced(var_1);
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    waitframe();
  }
}

function oncancel(var_0, var_1) {
  if(isDefined(self.carriedby)) {
    var_2 = self.carriedby;
    var_2 forceusehintoff();
    var_2.iscarrying = undefined;
    var_2.carrieditem = undefined;
    var_2 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel delete();
  }

  if(isDefined(self.carriedobj)) {
    self.carriedobj delete();
  }

  var_3 = level.placeableconfigs[var_0];

  if(isDefined(var_3.oncanceldelegate)) {
    self[[var_3.oncanceldelegate]](var_0);
  }

  if(isDefined(var_1) && var_1) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

function onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  self.origin = self.placementorigin;
  self.angles = self.carriedobj.angles;
  self playSound(var_1.placedsfx);
  showplacedmodel(var_0);

  if(isDefined(var_1.onplaceddelegate)) {
    self[[var_1.onplaceddelegate]](var_0);
  }

  self setCursorHint("HINT_NOICON");
  self setHintString(var_1.hintstring);
  var_2 = self.owner;
  var_2 forceusehintoff();
  var_2.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(var_1.headiconheight)) {
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_1.headiconheight, 0, undefined, undefined, undefined, 1);
  }

  thread handledamage(var_0);
  thread handledeath(var_0);
  self makeusable();
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);

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
  var_6.endonstring = "carried";

  if(isDefined(var_1.onmovingplatformcollision)) {
    var_6.deathoverridecallback = var_1.onmovingplatformcollision;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_6);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

function oncarried(var_0, var_1) {
  var_2 = level.placeableconfigs[var_0];
  self.carriedobj = createcarriedobject(var_1, var_0);
  self.isplaced = undefined;
  self.carriedby = var_1;
  var_1.iscarrying = 1;
  deactivate(var_0);
  hideplacedmodel(var_0);

  if(isDefined(var_2.oncarrieddelegate)) {
    self[[var_2.oncarrieddelegate]](var_0);
  }

  thread updateplacement(var_0, var_1);
  thread oncarrierdeath(var_0, var_1);
  self notify("carried");
}

function updateplacement(var_0, var_1) {
  var_1 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var_2 = -1;
  var_3 = level.placeableconfigs[var_0];
  var_4 = (0, 0, 0);

  if(isDefined(var_3.placementoffsetz)) {
    var_4 = (0, 0, var_3.placementoffsetz);
  }

  var_5 = self.carriedobj;

  for(;;) {
    var_6 = var_1 canplayerplacesentry(1, var_3.placementradius);
    self.placementorigin = var_6["origin"];
    var_5.origin = self.placementorigin + var_4;
    var_5.angles = var_6["angles"];
    self.canbeplaced = var_1 isonground() && var_6["result"] && abs(self.placementorigin[2] - var_1.origin[2]) < var_3.placementheighttolerance;

    if(isDefined(var_6["entity"])) {
      self.moving_platform = var_6["entity"];
    } else {
      self.moving_platform = undefined;
    }

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

function deactivate(var_0) {
  self makeunusable();
  hideheadicons();
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.ondeactivedelegate)) {
    self[[var_1.ondeactivedelegate]](var_0);
    return;
  }
}

function hideheadicons() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

function handledamage(var_0) {
  self endon("carried");
  var_1 = level.placeableconfigs[var_0];
  scripts\mp\damage::monitordamage(var_1.maxhealth, var_1.damagefeedback, &handledeathdamage, &modifydamage, 1);
}

function modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = self.config;

  if(isDefined(var_7.allowmeleedamage) && var_7.allowmeleedamage) {
    var_6 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_6);
  }

  if(isDefined(var_7.allowempdamage) && var_7.allowempdamage) {
    var_6 = scripts\mp\damage::handleempdamage(var_2, var_3, var_6);
  }

  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlegrenadedamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);

  if(isDefined(var_7.modifydamage)) {
    var_6 = self[[var_7.modifydamage]](var_2, var_3, var_6);
  }

  return var_6;
}

function handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = self.config;
  var_6 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_1, var_2, var_3, var_4, var_5.scorepopup, var_5.destroyedvo);

  if(var_6 && isDefined(var_5.ondestroyeddelegate)) {
    self[[var_5.ondestroyeddelegate]](self.streakname, var_1, self.owner, var_3);
    return;
  }
}

function handledeath(var_0) {
  self endon("carried");
  self waittill("death");
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(self)) {
    deactivate(var_0);

    if(isDefined(var_1.modeldestroyed)) {
      self setModel(var_1.modeldestroyed);
    }

    if(isDefined(var_1.ondeathdelegate)) {
      self[[var_1.ondeathdelegate]](var_0);
    }

    self delete();
    return;
  }
}

function oncarrierdeath(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_1 endon("disconnect");
  var_1 waittill("death");

  if(self.canbeplaced) {
    thread onplaced(var_0);
    return;
  }

  oncancel(var_0);
}

function onkillstreakdisowned(var_0) {
  self endon("death");
  level endon("game_ended");
  GscBinSkip4(0x35, "disconnect", var_0);
}

function watchownerstatus(var_0, var_1) {
  self.owner waittill(var_0);
  cleanup(var_1);
}

function ongameended(var_0) {
  self endon("death");
  level waittill("game_ended");
  cleanup(var_0);
}

function cleanup(var_0) {
  if(isDefined(self.isplaced)) {
    self notify("death");
    return;
  }

  oncancel(var_0);
}

function watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    thread onplayerconnected(var_0);
  }
}

function onplayerconnected(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  self disableplayeruse(var_0);
}

function timeout(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = level.placeableconfigs[var_0];
  var_2 = var_1.lifespan;

  while(var_2 > 0) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_2 -= 1;
    }
  }

  if(isDefined(self.owner) && isDefined(var_1.gonevo)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var_1.gonevo);
  }

  self notify("death");
}

function removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
    return;
  }
}

function removeperks() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
    return;
  }
}

function restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
    return;
  }
}

function restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\perk::giveperk(self.restoreperk);
    self.restoreperk = undefined;
    return;
  }
}

function showplacedmodel(var_0) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
    return;
  }
}

function hideplacedmodel(var_0) {
  self hide();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
    return;
  }
}

function createcarriedobject(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var_1 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = self.angles;
  var_1.owner = self;
  var_2 = level.placeableconfigs[var_0];
  var_1 setModel(var_2.modelbase);
  var_1 maketurretinoperable();
  var_1 setturretmodechangewait(1);
  var_1 setmode("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(self);
  var_1 setsentrycarrier(self);
  var_1 setCanDamage(0);
  var_1 notsolid();
  return var_1;
}