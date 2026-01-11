/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3508.gsc
***************************************/

init() {
  if(!isDefined(level.placeableconfigs)) {
    level.placeableconfigs = [];
  }
}

giveplaceable(var_00, var_01) {
  var_02 = createplaceable(var_00);
  removeperks();
  self.carrieditem = var_02;
  var_03 = onbeginnewmode(var_00, var_02, 1, var_01);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var_02);
}

createplaceable(var_00) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_01 = level.placeableconfigs[var_00];
  var_02 = spawn("script_model", self.origin);
  var_02 setModel(var_1.modelbase);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  var_2.config = var_01;
  var_2.firstplacement = 1;

  if(isDefined(var_1.func_C4DE)) {
    var_02[[var_1.func_C4DE]](var_00);
  }

  var_02 deactivate(var_00);
  var_02 thread timeout(var_00);
  var_02 thread func_89FA(var_00);
  var_02 thread func_C547(var_00);
  var_02 thread ongameended(var_00);
  var_02 thread createbombsquadmodel(var_00);
  return var_02;
}

func_89FA(var_00) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_01);

    if(!scripts\mp\utility\game::isreallyalive(var_01)) {
      continue;
    }
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_01 onbeginnewmode(var_00, self, 0);
  }
}

onbeginnewmode(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("disconnect");
  var_01 thread oncarried(var_00, self);
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
    if(isDefined(var_03) && var_03 == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      var_04 = "placePlaceable";
    } else {
      var_04 = scripts\engine\utility::waittill_any_return("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(var_01)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else if(var_04 == "cancelPlaceable" && var_02 || var_04 == "force_cancel_placement") {
      var_01 oncancel(var_00, var_04 == "force_cancel_placement" && !isDefined(var_1.firstplacement));
      return 0;
    } else if(var_1.canbeplaced) {
      var_01 thread onplaced(var_00);
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else
      wait 0.05;
  }
}

oncancel(var_00, var_01) {
  if(isDefined(self.carriedby)) {
    var_02 = self.carriedby;
    var_02 getrigindexfromarchetyperef();
    var_2.iscarrying = undefined;
    var_2.carrieditem = undefined;
    var_02 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel delete();
  }

  if(isDefined(self.carriedobj)) {
    self.carriedobj delete();
  }

  var_03 = level.placeableconfigs[var_00];

  if(isDefined(var_3.oncanceldelegate)) {
    self[[var_3.oncanceldelegate]](var_00);
  }

  if(isDefined(var_01) && var_01) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

onplaced(var_00) {
  var_01 = level.placeableconfigs[var_00];
  self.origin = self.func_CC24;
  self.angles = self.carriedobj.angles;
  self playSound(var_1.func_CC15);
  showplacedmodel(var_00);

  if(isDefined(var_1.onplaceddelegate)) {
    self[[var_1.onplaceddelegate]](var_00);
  }

  self setcursorhint("HINT_NOICON");
  self sethintstring(var_1.hintstring);
  var_02 = self.owner;
  var_02 getrigindexfromarchetyperef();
  var_2.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(var_1.func_8C79)) {
    if(level.teambased) {
      scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_1.func_8C79));
    } else {
      scripts\mp\entityheadicons::setplayerheadicon(var_02, (0, 0, var_1.func_8C79));
    }
  }

  thread handledamage(var_00);
  thread handledeath(var_00);
  self makeusable();
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);

  foreach(var_04 in level.players) {
    if(var_04 == var_02) {
      self enableplayeruse(var_04);
      continue;
    }

    self disableplayeruse(var_04);
  }

  if(isDefined(self.shouldsplash)) {
    level thread scripts\mp\utility\game::teamplayercardsplash(var_1.func_10A38, var_02);
    self.shouldsplash = 0;
  }

  var_06 = spawnStruct();
  var_6.linkparent = self.moving_platform;
  var_6.playdeathfx = 1;
  var_6.endonstring = "carried";

  if(isDefined(var_1.func_C55B)) {
    var_6.deathoverridecallback = var_1.func_C55B;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_06);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

oncarried(var_00, var_01) {
  var_02 = level.placeableconfigs[var_00];
  self.carriedobj = var_01 createcarriedobject(var_00);
  self.isplaced = undefined;
  self.carriedby = var_01;
  var_1.iscarrying = 1;
  deactivate(var_00);
  hideplacedmodel(var_00);

  if(isDefined(var_2.oncarrieddelegate)) {
    self[[var_2.oncarrieddelegate]](var_00);
  }

  thread updateplacement(var_00, var_01);
  thread oncarrierdeath(var_00, var_01);
  self notify("carried");
}

updateplacement(var_00, var_01) {
  var_01 endon("death");
  var_01 endon("disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var_02 = -1;
  var_03 = level.placeableconfigs[var_00];
  var_04 = (0, 0, 0);

  if(isDefined(var_3.func_CC23)) {
    var_04 = (0, 0, var_3.func_CC23);
  }

  var_05 = self.carriedobj;

  for(;;) {
    var_06 = var_01 canplayerplacesentry(1, var_3.placementradius);
    self.func_CC24 = var_6["origin"];
    var_5.origin = self.func_CC24 + var_04;
    var_5.angles = var_6["angles"];
    self.canbeplaced = var_01 isonground() && var_6["result"] && abs(self.func_CC24[2] - var_1.origin[2]) < var_3.placementheighttolerance;

    if(isDefined(var_6["entity"])) {
      self.moving_platform = var_6["entity"];
    } else {
      self.moving_platform = undefined;
    }

    if(self.canbeplaced != var_02) {
      if(self.canbeplaced) {
        var_05 setModel(var_3.modelplacement);
        var_01 forceusehinton(var_3.placestring);
      } else {
        var_05 setModel(var_3.modelplacementfailed);
        var_01 forceusehinton(var_3.cannotplacestring);
      }
    }

    var_02 = self.canbeplaced;
    wait 0.05;
  }
}

deactivate(var_00) {
  self makeunusable();
  hideheadicons();
  var_01 = level.placeableconfigs[var_00];

  if(isDefined(var_1.ondeactivedelegate)) {
    self[[var_1.ondeactivedelegate]](var_00);
  }
}

hideheadicons() {
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }
}

handledamage(var_00) {
  self endon("carried");
  var_01 = level.placeableconfigs[var_00];
  scripts\mp\damage::monitordamage(var_1.maxhealth, var_1.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_06 = self.config;

  if(isDefined(var_6.allowmeleedamage) && var_6.allowmeleedamage) {
    var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  }

  if(isDefined(var_6.func_1C8F) && var_6.func_1C8F) {
    var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  }

  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);

  if(isDefined(var_6.modifydamage)) {
    var_05 = self[[var_6.modifydamage]](var_01, var_02, var_05);
  }

  return var_05;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  var_04 = self.config;
  var_05 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_00, var_01, var_02, var_03, var_4.scorepopup, var_4.func_52DA);

  if(var_05 && isDefined(var_4.func_C4F3)) {
    self[[var_4.func_C4F3]](self.streakname, var_00, self.owner, var_02);
  }
}

handledeath(var_00) {
  self endon("carried");
  self waittill("death");
  var_01 = level.placeableconfigs[var_00];

  if(isDefined(self)) {
    deactivate(var_00);

    if(isDefined(var_1.modeldestroyed)) {
      self setModel(var_1.modeldestroyed);
    }

    if(isDefined(var_1.ondeathdelegate)) {
      self[[var_1.ondeathdelegate]](var_00);
    }

    self delete();
  }
}

oncarrierdeath(var_00, var_01) {
  self endon("placed");
  self endon("death");
  var_01 endon("disconnect");
  var_01 waittill("death");

  if(self.canbeplaced) {
    thread onplaced(var_00);
  } else {
    oncancel(var_00);
  }
}

func_C547(var_00) {
  self endon("death");
  level endon("game_ended");
  self.owner waittill("killstreak_disowned");
  cleanup(var_00);
}

ongameended(var_00) {
  self endon("death");
  level waittill("game_ended");
  cleanup(var_00);
}

cleanup(var_00) {
  if(isDefined(self.isplaced)) {
    self notify("death");
  } else {
    oncancel(var_00);
  }
}

watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_00);
    thread onplayerconnected(var_00);
  }
}

onplayerconnected(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  var_00 waittill("spawned_player");
  self disableplayeruse(var_00);
}

timeout(var_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = level.placeableconfigs[var_00];
  var_02 = var_1.lifespan;

  while(var_02 > 0.0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_02 = var_02 - 1.0;
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

createbombsquadmodel(var_00) {
  var_01 = level.placeableconfigs[var_00];

  if(isDefined(var_1.modelbombsquad)) {
    var_02 = spawn("script_model", self.origin);
    var_2.angles = self.angles;
    var_02 hide();
    var_02 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
    var_02 setModel(var_1.modelbombsquad);
    var_02 linkto(self);
    var_02 setcontents(0);
    self.bombsquadmodel = var_02;
    self waittill("death");

    if(isDefined(var_02)) {
      var_02 delete();
      self.bombsquadmodel = undefined;
    }
  }
}

showplacedmodel(var_00) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

hideplacedmodel(var_00) {
  self hide();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

createcarriedobject(var_00) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_01 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = self.angles;
  var_1.owner = self;
  var_02 = level.placeableconfigs[var_00];
  var_01 setModel(var_2.modelbase);
  var_01 maketurretinoperable();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(self);
  var_01 setsentrycarrier(self);
  var_01 setCanDamage(0);
  var_01 setcontents(0);
  return var_01;
}