/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_placeable.gsc
*************************************************/

init() {
  if(!isDefined(level.placeableconfigs)) {
    level.placeableconfigs = [];
  }
}

giveplaceable(param_00, param_01) {
  var_02 = createplaceable(param_00);
  removeperks();
  self.carrieditem = var_02;
  var_03 = onbeginnewmode(param_00, var_02, 1, param_01);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(var_02);
}

createplaceable(param_00) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var_01 = level.placeableconfigs[param_00];
  var_02 = spawn("script_model", self.origin);
  var_02 setModel(var_01.modelbase);
  var_02.angles = self.angles;
  var_02.triggerportableradarping = self;
  var_02.team = self.team;
  var_02.config = var_01;
  var_02.firstplacement = 1;
  if(isDefined(var_01.var_C4DE)) {
    var_02[[var_01.var_C4DE]](param_00);
  }

  var_02 deactivate(param_00);
  var_02 thread timeout(param_00);
  var_02 thread func_89FA(param_00);
  var_02 thread func_C547(param_00);
  var_02 thread ongameended(param_00);
  var_02 thread createbombsquadmodel(param_00);
  return var_02;
}

func_89FA(param_00) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_01);
    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_01 onbeginnewmode(param_00, self, 0);
  }
}

onbeginnewmode(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("disconnect");
  param_01 thread oncarried(param_00, self);
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
    if(isDefined(param_03) && param_03 == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      var_04 = "placePlaceable";
    } else {
      var_04 = scripts\engine\utility::waittill_any_return("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(param_01)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else if((var_04 == "cancelPlaceable" && param_02) || var_04 == "force_cancel_placement") {
      param_01 oncancel(param_00, var_04 == "force_cancel_placement" && !isDefined(param_01.firstplacement));
      return 0;
    } else if(param_01.canbeplaced) {
      param_01 thread onplaced(param_00);
      scripts\engine\utility::allow_weapon(1);
      return 1;
    } else {
      wait(0.05);
    }
  }
}

oncancel(param_00, param_01) {
  if(isDefined(self.carriedby)) {
    var_02 = self.carriedby;
    var_02 getrigindexfromarchetyperef();
    var_02.iscarrying = undefined;
    var_02.carrieditem = undefined;
    var_02 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel delete();
  }

  if(isDefined(self.carriedobj)) {
    self.carriedobj delete();
  }

  var_03 = level.placeableconfigs[param_00];
  if(isDefined(var_03.oncanceldelegate)) {
    self[[var_03.oncanceldelegate]](param_00);
  }

  if(isDefined(param_01) && param_01) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

onplaced(param_00) {
  var_01 = level.placeableconfigs[param_00];
  self.origin = self.var_CC24;
  self.angles = self.carriedobj.angles;
  self playSound(var_01.var_CC15);
  showplacedmodel(param_00);
  if(isDefined(var_01.onplaceddelegate)) {
    self[[var_01.onplaceddelegate]](param_00);
  }

  self setcursorhint("HINT_NOICON");
  self sethintstring(var_01.pow);
  var_02 = self.triggerportableradarping;
  var_02 getrigindexfromarchetyperef();
  var_02.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;
  if(isDefined(var_01.var_8C79)) {
    if(level.teambased) {
      scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_01.var_8C79));
    } else {
      scripts\mp\entityheadicons::setplayerheadicon(var_02, (0, 0, var_01.var_8C79));
    }
  }

  thread handledamage(param_00);
  thread handledeath(param_00);
  self makeusable();
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.triggerportableradarping);
  foreach(var_04 in level.players) {
    if(var_04 == var_02) {
      self enableplayeruse(var_04);
      continue;
    }

    self disableplayeruse(var_04);
  }

  if(isDefined(self.shouldsplash)) {
    level thread scripts\mp\utility::teamplayercardsplash(var_01.var_10A38, var_02);
    self.shouldsplash = 0;
  }

  var_06 = spawnStruct();
  var_06.linkparent = self.moving_platform;
  var_06.playdeathfx = 1;
  var_06.endonstring = "carried";
  if(isDefined(var_01.var_C55B)) {
    var_06.deathoverridecallback = var_01.var_C55B;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_06);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

oncarried(param_00, param_01) {
  var_02 = level.placeableconfigs[param_00];
  self.carriedobj = param_01 createcarriedobject(param_00);
  self.isplaced = undefined;
  self.carriedby = param_01;
  param_01.iscarrying = 1;
  deactivate(param_00);
  hideplacedmodel(param_00);
  if(isDefined(var_02.oncarrieddelegate)) {
    self[[var_02.oncarrieddelegate]](param_00);
  }

  thread updateplacement(param_00, param_01);
  thread oncarrierdeath(param_00, param_01);
  self notify("carried");
}

updateplacement(param_00, param_01) {
  param_01 endon("death");
  param_01 endon("disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var_02 = -1;
  var_03 = level.placeableconfigs[param_00];
  var_04 = (0, 0, 0);
  if(isDefined(var_03.var_CC23)) {
    var_04 = (0, 0, var_03.var_CC23);
  }

  var_05 = self.carriedobj;
  for(;;) {
    var_06 = param_01 canplayerplacesentry(1, var_03.placementradius);
    self.var_CC24 = var_06["origin"];
    var_05.origin = self.var_CC24 + var_04;
    var_05.angles = var_06["angles"];
    self.canbeplaced = param_01 isonground() && var_06["result"] && abs(self.var_CC24[2] - param_01.origin[2]) < var_03.placementheighttolerance;
    if(isDefined(var_06["entity"])) {
      self.moving_platform = var_06["entity"];
    } else {
      self.moving_platform = undefined;
    }

    if(self.canbeplaced != var_02) {
      if(self.canbeplaced) {
        var_05 setModel(var_03.modelplacement);
        param_01 forceusehinton(var_03.placestring);
      } else {
        var_05 setModel(var_03.modelplacementfailed);
        param_01 forceusehinton(var_03.cannotplacestring);
      }
    }

    var_02 = self.canbeplaced;
    wait(0.05);
  }
}

deactivate(param_00) {
  self makeunusable();
  hideheadicons();
  var_01 = level.placeableconfigs[param_00];
  if(isDefined(var_01.ondeactivedelegate)) {
    self[[var_01.ondeactivedelegate]](param_00);
  }
}

hideheadicons() {
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
    return;
  }

  if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }
}

handledamage(param_00) {
  self endon("carried");
  var_01 = level.placeableconfigs[param_00];
  scripts\mp\damage::monitordamage(var_01.maxhealth, var_01.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_06 = self.config;
  if(isDefined(var_06.allowmeleedamage) && var_06.allowmeleedamage) {
    var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  }

  if(isDefined(var_06.var_1C8F) && var_06.var_1C8F) {
    var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  }

  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  if(isDefined(var_06.modifydamage)) {
    var_05 = self[[var_06.modifydamage]](param_01, param_02, var_05);
  }

  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  var_04 = self.config;
  var_05 = scripts\mp\damage::onkillstreakkilled(self.streakname, param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.var_52DA);
  if(var_05 && isDefined(var_04.var_C4F3)) {
    self[[var_04.var_C4F3]](self.streakname, param_00, self.triggerportableradarping, param_02);
  }
}

handledeath(param_00) {
  self endon("carried");
  self waittill("death");
  var_01 = level.placeableconfigs[param_00];
  if(isDefined(self)) {
    deactivate(param_00);
    if(isDefined(var_01.modeldestroyed)) {
      self setModel(var_01.modeldestroyed);
    }

    if(isDefined(var_01.ondeathdelegate)) {
      self[[var_01.ondeathdelegate]](param_00);
    }

    self delete();
  }
}

oncarrierdeath(param_00, param_01) {
  self endon("placed");
  self endon("death");
  param_01 endon("disconnect");
  param_01 waittill("death");
  if(self.canbeplaced) {
    thread onplaced(param_00);
    return;
  }

  oncancel(param_00);
}

func_C547(param_00) {
  self endon("death");
  level endon("game_ended");
  self.triggerportableradarping waittill("killstreak_disowned");
  cleanup(param_00);
}

ongameended(param_00) {
  self endon("death");
  level waittill("game_ended");
  cleanup(param_00);
}

cleanup(param_00) {
  if(isDefined(self.isplaced)) {
    self notify("death");
    return;
  }

  oncancel(param_00);
}

watchplayerconnected() {
  self endon("death");
  for(;;) {
    level waittill("connected", var_00);
    thread onplayerconnected(var_00);
  }
}

onplayerconnected(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  param_00 waittill("spawned_player");
  self disableplayeruse(param_00);
}

timeout(param_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = level.placeableconfigs[param_00];
  var_02 = var_01.lifespan;
  while(var_02 > 0) {
    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      var_02 = var_02 - 1;
    }
  }

  if(isDefined(self.triggerportableradarping) && isDefined(var_01.gonevo)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer(var_01.gonevo);
  }

  self notify("death");
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\mp\utility::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility::removeperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\mp\utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

createbombsquadmodel(param_00) {
  var_01 = level.placeableconfigs[param_00];
  if(isDefined(var_01.modelbombsquad)) {
    var_02 = spawn("script_model", self.origin);
    var_02.angles = self.angles;
    var_02 hide();
    var_02 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
    var_02 setModel(var_01.modelbombsquad);
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

showplacedmodel(param_00) {
  self show();
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

hideplacedmodel(param_00) {
  self hide();
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

createcarriedobject(param_00) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }

  var_01 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var_01.angles = self.angles;
  var_01.triggerportableradarping = self;
  var_02 = level.placeableconfigs[param_00];
  var_01 setModel(var_02.modelbase);
  var_01 getvalidattachments();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(self);
  var_01 setsentrycarrier(self);
  var_01 setCanDamage(0);
  var_01 setcontents(0);
  return var_01;
}