/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3508.gsc
**************************************/

init() {
  if(!isDefined(level.placeableconfigs)) {
    level.placeableconfigs = [];
  }
}

giveplaceable(var_0, var_1) {
  var_2 = createplaceable(var_0);
  removeperks();
  self.carrieditem = var_2;
  var_3 = onbeginnewmode(var_0, var_2, 1, var_1);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var_2);
}

createplaceable(var_0) {
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

  if(isDefined(var_1.var_C4DE)) {
    var_2[[var_1.var_C4DE]](var_0);
  }

  var_2 deactivate(var_0);
  var_2 thread timeout(var_0);
  var_2 thread func_89FA(var_0);
  var_2 thread func_C547(var_0);
  var_2 thread ongameended(var_0);
  var_2 thread createbombsquadmodel(var_0);
  return var_2;
}

func_89FA(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_1 onbeginnewmode(var_0, self, 0);
  }
}

onbeginnewmode(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("disconnect");
  var_1 thread oncarried(var_0, self);
  scripts\engine\utility::allow_weapon(0);

  if(!isai(self)) {
    self notifyonplayercommand("placePlaceable", "+attack");
    self notifyonplayercommand("placePlaceable", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancelPlaceable", "+actionslot 4");

    if(!level.console) {
      self notifyonplayercommand("cancelPlaceable", "+actionslot 5");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 6");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 7");
    }
  }

  for(;;) {
    if(isDefined(var_3) && var_3 == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      var_4 = "placePlaceable";
    } else {
      var_4 = scripts\engine\utility::waittill_any_return("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(var_1)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else if(var_4 == "cancelPlaceable" && var_2 || var_4 == "force_cancel_placement") {
      var_1 oncancel(var_0, var_4 == "force_cancel_placement" && !isDefined(var_1.firstplacement));
      return 0;
    } else if(var_1.canbeplaced) {
      var_1 thread onplaced(var_0);
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else
      wait 0.05;
  }
}

oncancel(var_0, var_1) {
  if(isDefined(self.carriedby)) {
    var_2 = self.carriedby;
    var_2 getrigindexfromarchetyperef();
    var_2.iscarrying = undefined;
    var_2.carrieditem = undefined;
    var_2 scripts\engine\utility::allow_weapon(1);
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

onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  self.origin = self.var_CC24;
  self.angles = self.carriedobj.angles;
  self playSound(var_1.var_CC15);
  showplacedmodel(var_0);

  if(isDefined(var_1.onplaceddelegate)) {
    self[[var_1.onplaceddelegate]](var_0);
  }

  self setcursorhint("HINT_NOICON");
  self sethintstring(var_1.hintstring);
  var_2 = self.owner;
  var_2 getrigindexfromarchetyperef();
  var_2.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(var_1.var_8C79)) {
    if(level.teambased) {
      scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_1.var_8C79));
    } else {
      scripts\mp\entityheadicons::setplayerheadicon(var_2, (0, 0, var_1.var_8C79));
    }
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
    level thread scripts\mp\utility\game::teamplayercardsplash(var_1.var_10A38, var_2);
    self.shouldsplash = 0;
  }

  var_6 = spawnStruct();
  var_6.linkparent = self.moving_platform;
  var_6.playdeathfx = 1;
  var_6.endonstring = "carried";

  if(isDefined(var_1.var_C55B)) {
    var_6.deathoverridecallback = var_1.var_C55B;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_6);
  thread watchplayerconnected();
  self notify("placed");
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

  if(isDefined(var_2.oncarrieddelegate)) {
    self[[var_2.oncarrieddelegate]](var_0);
  }

  thread updateplacement(var_0, var_1);
  thread oncarrierdeath(var_0, var_1);
  self notify("carried");
}

updateplacement(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var_2 = -1;
  var_3 = level.placeableconfigs[var_0];
  var_4 = (0, 0, 0);

  if(isDefined(var_3.var_CC23)) {
    var_4 = (0, 0, var_3.var_CC23);
  }

  var_5 = self.carriedobj;

  for(;;) {
    var_6 = var_1 canplayerplacesentry(1, var_3.placementradius);
    self.var_CC24 = var_6["origin"];
    var_5.origin = self.var_CC24 + var_4;
    var_5.angles = var_6["angles"];
    self.canbeplaced = var_1 isonground() && var_6["result"] && abs(self.var_CC24[2] - var_1.origin[2]) < var_3.placementheighttolerance;

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
    wait 0.05;
  }
}

deactivate(var_0) {
  self makeunusable();
  hideheadicons();
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.ondeactivedelegate)) {
    self[[var_1.ondeactivedelegate]](var_0);
  }
}

hideheadicons() {
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }
}

handledamage(var_0) {
  self endon("carried");
  var_1 = level.placeableconfigs[var_0];
  scripts\mp\damage::monitordamage(var_1.maxhealth, var_1.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_6 = self.config;

  if(isDefined(var_6.allowmeleedamage) && var_6.allowmeleedamage) {
    var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  }

  if(isDefined(var_6.var_1C8F) && var_6.var_1C8F) {
    var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  }

  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlegrenadedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);

  if(isDefined(var_6.modifydamage)) {
    var_5 = self[[var_6.modifydamage]](var_1, var_2, var_5);
  }

  return var_5;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = self.config;
  var_5 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.var_52DA);

  if(var_5 && isDefined(var_4.var_C4F3)) {
    self[[var_4.var_C4F3]](self.streakname, var_0, self.owner, var_2);
  }
}

handledeath(var_0) {
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
  }
}

oncarrierdeath(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_1 endon("disconnect");
  var_1 waittill("death");

  if(self.canbeplaced) {
    thread onplaced(var_0);
  } else {
    oncancel(var_0);
  }
}

func_C547(var_0) {
  self endon("death");
  level endon("game_ended");
  self.owner waittill("killstreak_disowned");
  cleanup(var_0);
}

ongameended(var_0) {
  self endon("death");
  level waittill("game_ended");
  cleanup(var_0);
}

cleanup(var_0) {
  if(isDefined(self.isplaced)) {
    self notify("death");
  } else {
    oncancel(var_0);
  }
}

watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    thread onplayerconnected(var_0);
  }
}

onplayerconnected(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  self disableplayeruse(var_0);
}

timeout(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = level.placeableconfigs[var_0];
  var_2 = var_1.lifespan;

  while(var_2 > 0.0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_2 = var_2 - 1.0;
    }
  }

  if(isDefined(self.owner) && isDefined(var_1.gonevo)) {
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer(var_1.gonevo);
  }

  self notify("death");
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility\game::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility\game::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\game::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

createbombsquadmodel(var_0) {
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.modelbombsquad)) {
    var_2 = spawn("script_model", self.origin);
    var_2.angles = self.angles;
    var_2 hide();
    var_2 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
    var_2 setModel(var_1.modelbombsquad);
    var_2 linkto(self);
    var_2 setcontents(0);
    self.bombsquadmodel = var_2;
    self waittill("death");

    if(isDefined(var_2)) {
      var_2 delete();
      self.bombsquadmodel = undefined;
    }
  }
}

showplacedmodel(var_0) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

hideplacedmodel(var_0) {
  self hide();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

createcarriedobject(var_0) {
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
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(self);
  var_1 setsentrycarrier(self);
  var_1 setCanDamage(0);
  var_1 setcontents(0);
  return var_1;
}