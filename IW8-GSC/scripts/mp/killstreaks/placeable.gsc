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

function giveplaceable(var0, var1) {
  var2 = createplaceable(var0);
  removeperks();
  self.carrieditem = var2;
  var3 = onbegincarrying(var0, var2, 1, var1);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var2);
}

function createplaceable(var0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var1 = level.placeableconfigs[var0];
  var2 = spawn("script_model", self.origin);
  var2 setModel(var1.modelbase);
  var2.angles = self.angles;
  var2.owner = self;
  var2.team = self.team;
  var2.config = var1;
  var2.firstplacement = 1;

  if(isDefined(var1.oncreatedelegate)) {
    var2[[var1.oncreatedelegate]](var0);
  }

  deactivate(var2, var0);
  thread timeout(var2);
  thread handleuse(var2);
  thread onkillstreakdisowned(var2);
  thread ongameended(var2);
  return var2;
}

function handleuse(var0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var1);

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    onbegincarrying(var1, var0, self, 0);
  }
}

function onbegincarrying(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  thread oncarried(var1, var0);
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
    if(isDefined(var3) && var3 == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      var4 = "placePlaceable";
    } else {
      var4 = scripts\engine\utility::ref_143ae("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(var1)) {
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    if(var4 == "cancelPlaceable" && var2 || var4 == "force_cancel_placement") {
      oncancel(var1, var0, var4 == "force_cancel_placement" && !isDefined(var1.firstplacement));
      return 0;
    }

    if(var1.canbeplaced) {
      thread onplaced(var1);
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    waitframe();
  }
}

function oncancel(var0, var1) {
  if(isDefined(self.carriedby)) {
    var2 = self.carriedby;
    var2 forceusehintoff();
    var2.iscarrying = undefined;
    var2.carrieditem = undefined;
    var2 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel delete();
  }

  if(isDefined(self.carriedobj)) {
    self.carriedobj delete();
  }

  var3 = level.placeableconfigs[var0];

  if(isDefined(var3.oncanceldelegate)) {
    self[[var3.oncanceldelegate]](var0);
  }

  if(isDefined(var1) && var1) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

function onplaced(var0) {
  var1 = level.placeableconfigs[var0];
  self.origin = self.placementorigin;
  self.angles = self.carriedobj.angles;
  self playSound(var1.placedsfx);
  showplacedmodel(var0);

  if(isDefined(var1.onplaceddelegate)) {
    self[[var1.onplaceddelegate]](var0);
  }

  self setCursorHint("HINT_NOICON");
  self setHintString(var1.hintstring);
  var2 = self.owner;
  var2 forceusehintoff();
  var2.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(var1.headiconheight)) {
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var1.headiconheight, 0, undefined, undefined, undefined, 1);
  }

  thread handledamage(var0);
  thread handledeath(var0);
  self makeusable();
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);

  foreach(var4 in level.players) {
    if(var4 == var2) {
      self enableplayeruse(var4);
      continue;
    }

    self disableplayeruse(var4);
  }

  if(isDefined(self.shouldsplash)) {
    level thread scripts\mp\hud_util::teamplayercardsplash(var1.splashname, var2);
    self.shouldsplash = 0;
  }

  var6 = spawnStruct();
  var6.linkparent = self.moving_platform;
  var6.playdeathfx = 1;
  var6.endonstring = "carried";

  if(isDefined(var1.onmovingplatformcollision)) {
    var6.deathoverridecallback = var1.onmovingplatformcollision;
  }

  thread scripts\mp\movers::handle_moving_platforms(var6);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

function oncarried(var0, var1) {
  var2 = level.placeableconfigs[var0];
  self.carriedobj = createcarriedobject(var1, var0);
  self.isplaced = undefined;
  self.carriedby = var1;
  var1.iscarrying = 1;
  deactivate(var0);
  hideplacedmodel(var0);

  if(isDefined(var2.oncarrieddelegate)) {
    self[[var2.oncarrieddelegate]](var0);
  }

  thread updateplacement(var0, var1);
  thread oncarrierdeath(var0, var1);
  self notify("carried");
}

function updateplacement(var0, var1) {
  var1 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var2 = -1;
  var3 = level.placeableconfigs[var0];
  var4 = (0, 0, 0);

  if(isDefined(var3.placementoffsetz)) {
    var4 = (0, 0, var3.placementoffsetz);
  }

  var5 = self.carriedobj;

  for(;;) {
    var6 = var1 canplayerplacesentry(1, var3.placementradius);
    self.placementorigin = var6["origin"];
    var5.origin = self.placementorigin + var4;
    var5.angles = var6["angles"];
    self.canbeplaced = var1 isonground() && var6["result"] && abs(self.placementorigin[2] - var1.origin[2]) < var3.placementheighttolerance;

    if(isDefined(var6["entity"])) {
      self.moving_platform = var6["entity"];
    } else {
      self.moving_platform = undefined;
    }

    if(self.canbeplaced != var2) {
      if(self.canbeplaced) {
        var5 setModel(var3.modelplacement);
        var1 forceusehinton(var3.placestring);
      } else {
        var5 setModel(var3.modelplacementfailed);
        var1 forceusehinton(var3.cannotplacestring);
      }
    }

    var2 = self.canbeplaced;
    waitframe();
  }
}

function deactivate(var0) {
  self makeunusable();
  hideheadicons();
  var1 = level.placeableconfigs[var0];

  if(isDefined(var1.ondeactivedelegate)) {
    self[[var1.ondeactivedelegate]](var0);
    return;
  }
}

function hideheadicons() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

function handledamage(var0) {
  self endon("carried");
  var1 = level.placeableconfigs[var0];
  scripts\mp\damage::monitordamage(var1.maxhealth, var1.damagefeedback, &handledeathdamage, &modifydamage, 1);
}

function modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = self.config;

  if(isDefined(var7.allowmeleedamage) && var7.allowmeleedamage) {
    var6 = scripts\mp\damage::handlemeleedamage(var2, var3, var6);
  }

  if(isDefined(var7.allowempdamage) && var7.allowempdamage) {
    var6 = scripts\mp\damage::handleempdamage(var2, var3, var6);
  }

  var6 = scripts\mp\damage::handlemissiledamage(var2, var3, var6);
  var6 = scripts\mp\damage::handlegrenadedamage(var2, var3, var6);
  var6 = scripts\mp\damage::handleapdamage(var2, var3, var6);

  if(isDefined(var7.modifydamage)) {
    var6 = self[[var7.modifydamage]](var2, var3, var6);
  }

  return var6;
}

function handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = self.config;
  var6 = scripts\mp\damage::onkillstreakkilled(self.streakname, var1, var2, var3, var4, var5.scorepopup, var5.destroyedvo);

  if(var6 && isDefined(var5.ondestroyeddelegate)) {
    self[[var5.ondestroyeddelegate]](self.streakname, var1, self.owner, var3);
    return;
  }
}

function handledeath(var0) {
  self endon("carried");
  self waittill("death");
  var1 = level.placeableconfigs[var0];

  if(isDefined(self)) {
    deactivate(var0);

    if(isDefined(var1.modeldestroyed)) {
      self setModel(var1.modeldestroyed);
    }

    if(isDefined(var1.ondeathdelegate)) {
      self[[var1.ondeathdelegate]](var0);
    }

    self delete();
    return;
  }
}

function oncarrierdeath(var0, var1) {
  self endon("placed");
  self endon("death");
  var1 endon("disconnect");
  var1 waittill("death");

  if(self.canbeplaced) {
    thread onplaced(var0);
    return;
  }

  oncancel(var0);
}

function onkillstreakdisowned(var0) {
  self endon("death");
  level endon("game_ended");
  GscBinSkip4(0x35, "disconnect", var0);
}

function watchownerstatus(var0, var1) {
  self.owner waittill(var0);
  cleanup(var1);
}

function ongameended(var0) {
  self endon("death");
  level waittill("game_ended");
  cleanup(var0);
}

function cleanup(var0) {
  if(isDefined(self.isplaced)) {
    self notify("death");
    return;
  }

  oncancel(var0);
}

function watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var0);
    thread onplayerconnected(var0);
  }
}

function onplayerconnected(var0) {
  self endon("death");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  self disableplayeruse(var0);
}

function timeout(var0) {
  self endon("death");
  level endon("game_ended");
  var1 = level.placeableconfigs[var0];
  var2 = var1.lifespan;

  while(var2 > 0) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var2 -= 1;
    }
  }

  if(isDefined(self.owner) && isDefined(var1.gonevo)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var1.gonevo);
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

function showplacedmodel(var0) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
    return;
  }
}

function hideplacedmodel(var0) {
  self hide();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
    return;
  }
}

function createcarriedobject(var0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var1 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var1.angles = self.angles;
  var1.owner = self;
  var2 = level.placeableconfigs[var0];
  var1 setModel(var2.modelbase);
  var1 maketurretinoperable();
  var1 setturretmodechangewait(1);
  var1 setmode("sentry_offline");
  var1 makeunusable();
  var1 setsentryowner(self);
  var1 setsentrycarrier(self);
  var1 setCanDamage(0);
  var1 notsolid();
  return var1;
}