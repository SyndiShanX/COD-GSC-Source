/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\placeable.gsc
************************************************/

init() {
  if(!isDefined(level.placeableconfigs))
    level.placeableconfigs = [];
}

giveplaceable(streakname, _id_41DBE7A9C2A55DAB) {
  _id_9C1016ADDB615B08 = createplaceable(streakname);
  removeperks();
  self.carrieditem = _id_9C1016ADDB615B08;
  result = onbegincarrying(streakname, _id_9C1016ADDB615B08, 1, _id_41DBE7A9C2A55DAB);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(_id_9C1016ADDB615B08);
}

createplaceable(streakname) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  config = level.placeableconfigs[streakname];
  obj = spawn("script_model", self.origin);
  obj setModel(config.modelbase);
  obj.angles = self.angles;
  obj.owner = self;
  obj.team = self.team;
  obj.config = config;
  obj.firstplacement = 1;

  if(isDefined(config.oncreatedelegate))
    obj[[config.oncreatedelegate]](streakname);

  obj deactivate(streakname);
  obj thread timeout(streakname);
  obj thread handleuse(streakname);
  obj thread onkillstreakdisowned(streakname);
  obj thread ongameended(streakname);
  return obj;
}

handleuse(streakname) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(isDefined(self getlinkedparent()))
      self unlink();

    player onbegincarrying(streakname, self, 0);
  }
}

onbegincarrying(streakname, _id_9C1016ADDB615B08, _id_3A565847D875F3EC, _id_41DBE7A9C2A55DAB) {
  self endon("death_or_disconnect");
  _id_9C1016ADDB615B08 thread oncarried(streakname, self);
  _id_3B64EB40368C1450::set("carry", "weapon", 0);

  if(!isai(self)) {
    self notifyonplayercommand("placePlaceable", "+attack");
    self notifyonplayercommand("placePlaceable", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancelPlaceable", "+actionslot 4");

    if(!self isconsoleplayer()) {
      self notifyonplayercommand("cancelPlaceable", "+actionslot 5");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 6");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 7");
    }
  }

  for(;;) {
    if(isDefined(_id_41DBE7A9C2A55DAB) && _id_41DBE7A9C2A55DAB == 1 && !self isonladder() && self isonground() && !self ismantling())
      result = "placePlaceable";
    else
      result = scripts\engine\utility::waittill_any_return_3("placePlaceable", "cancelPlaceable", "force_cancel_placement");

    if(!isDefined(_id_9C1016ADDB615B08)) {
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
      return 1;
    } else if(result == "cancelPlaceable" && _id_3A565847D875F3EC || result == "force_cancel_placement") {
      _id_9C1016ADDB615B08 oncancel(streakname, result == "force_cancel_placement" && !isDefined(_id_9C1016ADDB615B08.firstplacement));
      return 0;
    } else if(_id_9C1016ADDB615B08.canbeplaced) {
      _id_9C1016ADDB615B08 thread onplaced(streakname);
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
      return 1;
    } else
      waitframe();
  }
}

oncancel(streakname, _id_DDD5B75D0CD367C5) {
  if(isDefined(self.carriedby)) {
    owner = self.carriedby;
    owner forceusehintoff();
    owner.iscarrying = undefined;
    owner.carrieditem = undefined;
    owner _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  }

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel delete();

  if(isDefined(self.carriedobj))
    self.carriedobj delete();

  config = level.placeableconfigs[streakname];

  if(isDefined(config.oncanceldelegate))
    self[[config.oncanceldelegate]](streakname);

  if(isDefined(_id_DDD5B75D0CD367C5) && _id_DDD5B75D0CD367C5)
    scripts\mp\weapons::equipmentdeletevfx();

  self delete();
}

onplaced(streakname) {
  config = level.placeableconfigs[streakname];
  self.origin = self.placementorigin;
  self.angles = self.carriedobj.angles;
  self playSound(config.placedsfx);
  showplacedmodel(streakname);

  if(isDefined(config.onplaceddelegate))
    self[[config.onplaceddelegate]](streakname);

  owner = self.owner;
  owner forceusehintoff();
  owner.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(config.headiconheight))
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, config.headiconheight, 0, undefined, undefined, undefined, 1);

  thread handledamage(streakname);
  thread handledeath(streakname);
  self makeusable();
  self setCursorHint("HINT_NOICON");
  self setHintString(config.hintstring);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);

  foreach(player in level.players) {
    if(player == owner) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }

  if(isDefined(self.shouldsplash)) {
    level thread scripts\mp\hud_util::teamplayercardsplash(config.splashname, owner);
    self.shouldsplash = 0;
  }

  data = spawnStruct();
  data.linkparent = self.moving_platform;
  data.endonstring = "carried";

  if(isDefined(config.onmovingplatformcollision))
    data.deathoverridecallback = config.onmovingplatformcollision;

  thread scripts\mp\movers::handle_moving_platforms(data);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

oncarried(streakname, carrier) {
  config = level.placeableconfigs[streakname];
  self.carriedobj = carrier createcarriedobject(streakname);
  self.isplaced = undefined;
  self.carriedby = carrier;
  carrier.iscarrying = 1;
  deactivate(streakname);
  hideplacedmodel(streakname);

  if(isDefined(config.oncarrieddelegate))
    self[[config.oncarrieddelegate]](streakname);

  thread updateplacement(streakname, carrier);
  thread oncarrierdeath(streakname, carrier);
  self notify("carried");
}

updateplacement(streakname, carrier) {
  carrier endon("death_or_disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  _id_60DD404A742CBA9A = -1;
  config = level.placeableconfigs[streakname];
  _id_70D1E6DF9172E80F = (0, 0, 0);

  if(isDefined(config.placementoffsetz))
    _id_70D1E6DF9172E80F = (0, 0, config.placementoffsetz);

  carriedobj = self.carriedobj;

  for(;;) {
    placement = carrier canplayerplacesentry(1, config.placementradius);
    self.placementorigin = placement["origin"];
    carriedobj.origin = self.placementorigin + _id_70D1E6DF9172E80F;
    carriedobj.angles = placement["angles"];
    self.canbeplaced = carrier isonground() && placement["result"] && abs(self.placementorigin[2] - carrier.origin[2]) < config.placementheighttolerance;

    if(isDefined(placement["entity"]))
      self.moving_platform = placement["entity"];
    else
      self.moving_platform = undefined;

    if(self.canbeplaced != _id_60DD404A742CBA9A) {
      if(self.canbeplaced) {
        carriedobj setModel(config.modelplacement);
        carrier forceusehinton(config.placestring);
      } else {
        carriedobj setModel(config.modelplacementfailed);
        carrier forceusehinton(config.cannotplacestring);
      }
    }

    _id_60DD404A742CBA9A = self.canbeplaced;
    waitframe();
  }
}

deactivate(streakname) {
  self makeunusable();
  hideheadicons();
  config = level.placeableconfigs[streakname];

  if(isDefined(config.ondeactivedelegate))
    self[[config.ondeactivedelegate]](streakname);
}

hideheadicons() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

handledamage(streakname) {
  self endon("carried");
  config = level.placeableconfigs[streakname];
  scripts\mp\damage::monitordamage(config.maxhealth, config.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  config = self.config;

  if(isDefined(config.allowmeleedamage) && config.allowmeleedamage)
    _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);

  if(isDefined(config.allowempdamage) && config.allowempdamage)
    _id_702BFC08FABD86CB = scripts\mp\damage::handleempdamage(objweapon, type, _id_702BFC08FABD86CB);

  _id_702BFC08FABD86CB = scripts\mp\damage::handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handlegrenadedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);

  if(isDefined(config.modifydamage))
    _id_702BFC08FABD86CB = self[[config.modifydamage]](objweapon, type, _id_702BFC08FABD86CB);

  return _id_702BFC08FABD86CB;
}

handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  config = self.config;
  _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo);

  if(_id_3737240CEFE2C793 && isDefined(config.ondestroyeddelegate))
    self[[config.ondestroyeddelegate]](self.streakname, attacker, self.owner, type);
}

handledeath(streakname) {
  self endon("carried");
  self waittill("death");
  config = level.placeableconfigs[streakname];

  if(isDefined(self)) {
    deactivate(streakname);

    if(isDefined(config.modeldestroyed))
      self setModel(config.modeldestroyed);

    if(isDefined(config.ondeathdelegate))
      self[[config.ondeathdelegate]](streakname);

    self delete();
  }
}

oncarrierdeath(streakname, carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");
  carrier waittill("death");

  if(self.canbeplaced)
    thread onplaced(streakname);
  else
    oncancel(streakname);
}

onkillstreakdisowned(streakname) {
  self endon("death");
  level endon("game_ended");
  childthread watchownerstatus("disconnect", streakname);
  childthread watchownerstatus("joined_team", streakname);
  childthread watchownerstatus("joined_spectators", streakname);
}

watchownerstatus(_id_70687E0CC558A009, streakname) {
  self.owner waittill(_id_70687E0CC558A009);
  cleanup(streakname);
}

ongameended(streakname) {
  self endon("death");
  level waittill("game_ended");
  cleanup(streakname);
}

cleanup(streakname) {
  if(isDefined(self.isplaced))
    self notify("death");
  else
    oncancel(streakname);
}

watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", player);
    thread onplayerconnected(player);
  }
}

onplayerconnected(owner) {
  self endon("death");
  owner endon("disconnect");
  owner waittill("spawned_player");
  self disableplayeruse(owner);
}

timeout(streakname) {
  self endon("death");
  level endon("game_ended");
  config = level.placeableconfigs[streakname];
  lifespan = config.lifespan;

  while(lifespan > 0.0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      lifespan = lifespan - 1.0;
  }

  if(isDefined(self.owner) && isDefined(config.gonevo))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(config.gonevo);

  self notify("death");
}

removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
  }
}

removeperks() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
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

showplacedmodel(streakname) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

hideplacedmodel(streakname) {
  self hide();

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel hide();
}

createcarriedobject(streakname) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  carriedobj = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  carriedobj.angles = self.angles;
  carriedobj.owner = self;
  config = level.placeableconfigs[streakname];
  carriedobj setModel(config.modelbase);
  carriedobj maketurretinoperable();
  carriedobj setturretmodechangewait(1);
  carriedobj setmode("sentry_offline");
  carriedobj makeunusable();
  carriedobj setsentryowner(self);
  carriedobj setsentrycarrier(self);
  carriedobj setCanDamage(0);
  carriedobj notsolid();
  return carriedobj;
}