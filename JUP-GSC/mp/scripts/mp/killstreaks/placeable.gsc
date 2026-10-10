/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\placeable.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace placeable;

function init() {
  if(!isDefined(level.placeableconfigs)) {
    level.placeableconfigs = [];
  }
}

function giveplaceable(streakname, var_41dbe7a9c2a55dab) {
  placeable = createplaceable(streakname);
  removeperks();
  self.carrieditem = placeable;

  if(getdvarint(@ "hash_cae913bf39486207", 0) != 0) {
    var_41dbe7a9c2a55dab = 0;
  }

  result = onbegincarrying(streakname, placeable, 1, var_41dbe7a9c2a55dab);
  self.carrieditem = undefined;
  restoreperks();
  return isDefined(placeable);
}

function createplaceable(streakname) {
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

  if(isDefined(config.oncreatedelegate)) {
    obj[[config.oncreatedelegate]](streakname);
  }

  obj deactivate(streakname);
  obj thread timeout(streakname);
  obj thread handleuse(streakname);
  obj thread onkillstreakdisowned(streakname);
  obj thread ongameended(streakname);
  return obj;
}

function handleuse(streakname) {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);
    assert(player == self.owner);
    assert(!isDefined(self.carriedby));

    if(!isreallyalive(player)) {
      continue;
    }

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    player onbegincarrying(streakname, self, 0);
  }
}

function onbegincarrying(streakname, placeable, allowcancel, var_41dbe7a9c2a55dab) {
  self endon("death_or_disconnect");
  assert(isreallyalive(self));
  placeable thread oncarried(streakname, self);
  val::set("carry", "weapon", 0);

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

  while(true) {
    if(isDefined(var_41dbe7a9c2a55dab) && var_41dbe7a9c2a55dab == 1 && !self isonladder() && self isonground() && !self ismantling()) {
      result = "placePlaceable";
    } else {
      result = waittill_any_return_3("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(placeable)) {
      val::reset_all("carry");
      return 1;
    }

    if(result == "cancelPlaceable" && allowcancel || result == "force_cancel_placement") {
      placeable oncancel(streakname, result == "force_cancel_placement" && !isDefined(placeable.firstplacement));
      return 0;
    }

    if(placeable.canbeplaced) {
      placeable thread onplaced(streakname);
      val::reset_all("carry");
      return 1;
    }

    waitframe();
  }
}

function oncancel(streakname, var_ddd5b75d0cd367c5) {
  if(isDefined(self.carriedby)) {
    owner = self.carriedby;
    owner forceusehintoff();
    owner.iscarrying = undefined;
    owner.carrieditem = undefined;
    owner val::reset_all("carry");
  }

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel delete();
  }

  if(isDefined(self.carriedobj)) {
    self.carriedobj delete();
  }

  config = level.placeableconfigs[streakname];

  if(isDefined(config.oncanceldelegate)) {
    self[[config.oncanceldelegate]](streakname);
  }

  if(isDefined(var_ddd5b75d0cd367c5) && var_ddd5b75d0cd367c5) {
    scripts\mp\weapons::equipmentdeletevfx();
  }

  self delete();
}

function onplaced(streakname) {
  config = level.placeableconfigs[streakname];
  self.origin = self.placementorigin;
  self.angles = self.carriedobj.angles;
  self playSound(config.placedsfx);
  showplacedmodel(streakname);

  if(isDefined(config.onplaceddelegate)) {
    self[[config.onplaceddelegate]](streakname);
  }

  owner = self.owner;
  owner forceusehintoff();
  owner.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;

  if(isDefined(config.headiconheight)) {
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, config.headiconheight, 0, undefined, undefined, undefined, 1);
  }

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
    level thread teamplayercardsplash(config.splashname, owner);
    self.shouldsplash = 0;
  }

  data = spawnStruct();
  data.linkparent = self.moving_platform;
  data.endonstring = "carried";

  if(isDefined(config.onmovingplatformcollision)) {
    data.deathoverridecallback = config.onmovingplatformcollision;
  }

  thread scripts\mp\movers::handle_moving_platforms(data);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
}

function oncarried(streakname, carrier) {
  config = level.placeableconfigs[streakname];
  assert(isPlayer(carrier));
  assertex(carrier == self.owner, "<dev string:x1c>");
  self.carriedobj = carrier createcarriedobject(streakname);
  self.isplaced = undefined;
  self.carriedby = carrier;
  carrier.iscarrying = 1;
  deactivate(streakname);
  hideplacedmodel(streakname);

  if(isDefined(config.oncarrieddelegate)) {
    self[[config.oncarrieddelegate]](streakname);
  }

  thread updateplacement(streakname, carrier);
  thread oncarrierdeath(streakname, carrier);
  self notify("carried");
}

function updateplacement(streakname, carrier) {
  carrier endon("death_or_disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  prevcanbeplaced = -1;
  config = level.placeableconfigs[streakname];
  placementoffset = (0, 0, 0);

  if(isDefined(config.placementoffsetz)) {
    placementoffset = (0, 0, config.placementoffsetz);
  }

  carriedobj = self.carriedobj;

  while(true) {
    placement = carrier canplayerplacesentry(1, config.placementradius);
    self.placementorigin = placement["origin"];
    carriedobj.origin = self.placementorigin + placementoffset;
    carriedobj.angles = placement["angles"];
    self.canbeplaced = carrier isonground() && placement["result"] && abs(self.placementorigin[2] - carrier.origin[2]) < config.placementheighttolerance;

    if(isDefined(placement["entity"])) {
      self.moving_platform = placement["entity"];
    } else {
      self.moving_platform = undefined;
    }

    if(self.canbeplaced != prevcanbeplaced) {
      if(self.canbeplaced) {
        carriedobj setModel(config.modelplacement);
        carrier forceusehinton(config.placestring);
      } else {
        carriedobj setModel(config.modelplacementfailed);
        carrier forceusehinton(config.cannotplacestring);
      }
    }

    prevcanbeplaced = self.canbeplaced;
    waitframe();
  }
}

function deactivate(streakname) {
  self makeunusable();
  hideheadicons();
  config = level.placeableconfigs[streakname];

  if(isDefined(config.ondeactivedelegate)) {
    self[[config.ondeactivedelegate]](streakname);
  }
}

function hideheadicons() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

function handledamage(streakname) {
  self endon("carried");
  config = level.placeableconfigs[streakname];
  scripts\mp\damage::monitordamage(config.maxhealth, config.damagefeedback, &handledeathdamage, &modifydamage, 1);
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  config = self.config;

  if(isDefined(config.allowmeleedamage) && config.allowmeleedamage) {
    modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  }

  if(isDefined(config.allowempdamage) && config.allowempdamage) {
    modifieddamage = scripts\mp\damage::handleempdamage(objweapon, type, modifieddamage);
  }

  modifieddamage = scripts\mp\damage::handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handlegrenadedamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);

  if(isDefined(config.modifydamage)) {
    modifieddamage = self[[config.modifydamage]](objweapon, type, modifieddamage);
  }

  return modifieddamage;
}

function handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  config = self.config;
  notifyattacker = scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo);

  if(notifyattacker && isDefined(config.ondestroyeddelegate)) {
    self[[config.ondestroyeddelegate]](self.streakname, attacker, self.owner, type);
  }
}

function handledeath(streakname) {
  self endon("carried");
  self waittill("death");
  config = level.placeableconfigs[streakname];

  if(isDefined(self)) {
    deactivate(streakname);

    if(isDefined(config.modeldestroyed)) {
      self setModel(config.modeldestroyed);
    }

    if(isDefined(config.ondeathdelegate)) {
      self[[config.ondeathdelegate]](streakname);
    }

    self delete();
  }
}

function oncarrierdeath(streakname, carrier) {
  self endon("placed");
  self endon("death");
  carrier endon("disconnect");
  carrier waittill("death");

  if(self.canbeplaced) {
    thread onplaced(streakname);
    return;
  }

  oncancel(streakname);
}

function onkillstreakdisowned(streakname) {
  self endon("death");
  level endon("game_ended");
  childthread watchownerstatus("disconnect", streakname);
  childthread watchownerstatus("joined_team", streakname);
  childthread watchownerstatus("joined_spectators", streakname);
}

function watchownerstatus(notifymsg, streakname) {
  self.owner waittill(notifymsg);
  cleanup(streakname);
}

function ongameended(streakname) {
  self endon("death");
  level waittill("game_ended");
  cleanup(streakname);
}

function cleanup(streakname) {
  if(isDefined(self.isplaced)) {
    self notify("death");
    return;
  }

  oncancel(streakname);
}

function watchplayerconnected() {
  self endon("death");

  while(true) {
    level waittill("connected", player);
    thread onplayerconnected(player);
  }
}

function onplayerconnected(owner) {
  self endon("death");
  owner endon("disconnect");
  owner waittill("spawned_player");
  self disableplayeruse(owner);
}

function timeout(streakname) {
  self endon("death");
  level endon("game_ended");
  config = level.placeableconfigs[streakname];
  lifespan = config.lifespan;

  while(lifespan > 0) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      lifespan -= 1;
    }
  }

  if(isDefined(self.owner) && isDefined(config.gonevo)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(config.gonevo);
  }

  self notify("death");
}

function removeweapons() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self.restoreweapon = "iw6_riotshield_mp";
    _takeweapon("iw6_riotshield_mp");
  }
}

function removeperks() {
  if(_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    removeperk("specialty_explosivebullets");
  }
}

function restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    _giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

function restoreperks() {
  if(isDefined(self.restoreperk)) {
    giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

function showplacedmodel(streakname) {
  self show();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

function hideplacedmodel(streakname) {
  self hide();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
  }
}

function createcarriedobject(streakname) {
  assertex(isDefined(self), "<dev string:x5e>");

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