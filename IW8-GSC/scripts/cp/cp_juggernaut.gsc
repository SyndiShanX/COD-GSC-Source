/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_juggernaut.gsc
***********************************************/

function init() {}

function jugg_makejuggernaut(var0, var1) {
  if(!jugg_canresolvestance(var0)) {
    return false;
  }

  self.isjuggernaut = 1;
  self.can_revive = 0;
  self.streakinfo = var1;
  var2 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  var3 = spawnStruct();
  var3.juggconfig = var0;
  var3.prevhealth = self.health;
  var3.prevmaxhealth = self.maxhealth;
  var3.prevclothtype = self.clothtype;
  var3.prevbody = var2[0];
  var3.prevhead = var2[1];
  var3.prevviewmodel = self getcustomizationviewmodel();
  var3.prevspeedscale = self.playerstreakspeedscale;
  var3.prevsuit = self.suit;
  var3.prevstartingweap = scripts\cp\utility::getvalidtakeweapon();
  var3.maskomnvar = "ui_gas_mask_juggernaut";
  self.disabletakecoverwarning = 1;
  self.jugg_health = var0.maxhealth - var3.prevmaxhealth;
  self.maxhealth = var0.maxhealth;
  self.health = self.maxhealth;

  if(istrue(level.ref_12bac) || istrue(level.ref_12b78)) {
    var4 = self getentitynumber();
    scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var4, "tickettotal", self.maxhealth);
  }

  jugg_handlestancechange(var0);

  if(isDefined(var0.classstruct)) {
    vehicle_handleflarerecharge(self, var3);
    scripts\cp\cp_loadout::cargo_truck_mg_deletenextframe(self, var0.classstruct);
    self giveweapon(self.starting_weapon);
    self setweaponammoclip(self.starting_weapon, weaponclipsize(self.starting_weapon));
    self setweaponammostock(self.starting_weapon, weaponmaxammo(self.starting_weapon));
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.starting_weapon);
  }

  jugg_toggleallows(var0.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  jugg_setModel();
  self.playerstreakspeedscale = var0.movespeedscalar;
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
  self setsuit(var0.suit);
  self.suit = var0.suit;
  self setclothtype(var0.clothtype);
  jugg_enableoverlay(var3);

  if(var0.infiniteammo) {
    thread infiniteammothread(var0.infiniteammoupdaterate);
  }

  self.juggcontext = var3;
  self notify("juggernaut_start");
  self notify("munitions_used", "juggernaut");
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
  return true;
}

function get_track_star_time_from_col() {
  waittillframeend();

  if(isDefined(self.carryobject)) {
    self switchtoweapon("iw8_minigunksjugg_mp");
    return;
  }
}

function vehicle_handleflarerecharge(var0, var1) {
  var0 scripts\cp\utility::store_weapons_status();
  var0 scripts\cp\cp_accessories::clearplayeraccessory();
  var0 takeallweapons();
}

function jugg_watchmusictoggle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  var0 = 0;
  self notifyonplayercommand("toggle_music", "+actionslot 3");
  self notifyonplayercommand("toggle_music", "killstreak_wheel");
  var1 = getcompleteweaponname("ks_gesture_jugg_music_mp");
  var2 = weaponfiretime(var1);

  if(!isDefined(self.musicplaying)) {
    var3 = self getjuggdefaultmusicenabled();
    self.musicplaying = var3;
  }

  if(!istrue(self.musicplaying)) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
    goto LOC_0000008c;
  }

  self setscriptablepartstate("juggernaut", "music", 0);

  for(;;) {
    self waittill("toggle_music");

    if(self isonladder() || self ismantling()) {
      continue;
    }

    self giveandfireoffhand(var1);
    self playsoundonmovingent("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    var4 = 0.2;

    if(istrue(self.musicplaying)) {
      var4 = 0.65;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var4);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self.musicplaying = 1;
      self setscriptablepartstate("juggernaut", "music", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

function jugg_watchforgameend() {
  self endon("juggernaut_end");
  var0 = self.juggcontext;
  level waittill("game_ended");
  self.maxhealth = var0.prevmaxhealth;
  self.health = var0.prevhealth;
  jugg_disableoverlay(var0);
}

function jugg_watchfordisconnect() {
  self endon("juggernaut_end");
  var0 = self.juggcontext;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = var0.prevmaxhealth;
    self.health = var0.prevhealth;
    return;
  }
}

function vehicle_interact_initdev() {
  self endon("juggernaut_end");

  for(;;) {
    self waittill("weapon_fired");
    self.streakinfo.shots_fired++;
  }
}

function jugg_removejuggernaut() {
  var0 = self.juggcontext;
  var1 = var0.juggconfig;
  self.musicplaying = undefined;
  self notify("juggernaut_end_damage");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self.maxhealth = var0.prevmaxhealth;
    self.health = var0.prevhealth;

    if(istrue(level.ref_12bac) || istrue(level.ref_12b78)) {
      var2 = self getentitynumber();
      scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var2, "tickettotal", self.maxhealth);
    }

    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    jugg_toggleallows(var1.allows, 1);

    if(isDefined(var1.classstruct)) {
      scripts\cp\survival\survival_loadout::respawnitems_assignrespawnitems(var0.respawnitems);
    }

    foreach(var4 in var1.perks) {
      scripts\cp\utility::_unsetperk(var5);
    }

    if(var1.infiniteammo) {
      stopinfiniteammothread();
    }
  }

  jugg_restoremodel(var0);
  self.playerstreakspeedscale = var0.prevspeedscale;
  scripts\cp\survival\survival_loadout::updatemovespeedscale();
  self setsuit(var0.prevsuit);
  self.suit = var0.prevsuit;

  if(isDefined(self.prevclothtype)) {
    self setclothtype(var0.prevclothtype);
  }

  self takeallweapons();
  scripts\cp\utility::restore_weapons_status();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  }

  if(scripts\cp\utility::tryingtoleave()) {
    if(isDefined(self.loadoutaccessorydata) && isDefined(self.loadoutaccessoryweapon) && self.loadoutaccessoryweapon != "none") {
      scripts\cp\cp_accessories::giveplayeraccessory(self.loadoutaccessorydata, self.loadoutaccessoryweapon, self.loadoutaccessorylogic);
    }
  } else if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  jugg_disableoverlay(var0);
  self setscriptablepartstate("juggernaut", "neutral", 0);

  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave()) {
    self skydive_setbasejumpingstatus(1);
  }

  self.damageshieldexpiretime = gettime() + 3000;
  self.isjuggernaut = 0;
  self.can_revive = 1;
  self.juggcontext = undefined;
  self.disabletakecoverwarning = undefined;
  self.jugg_health = undefined;
  thread start_regen_early();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
  self notify("stop_hostagecarrier_watching_for_doors");
  self notify("juggernaut_end");
}

function start_regen_early() {
  wait 0.1;
  self notify("force_regeneration");
}

function infiniteammothread(var0, var1) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");
  jumpiftrue(isDefined(var0)) LOC_0000001e;
  var0 = level.framedurationseconds;

  for(;;) {
    if(!scripts\cp\cp_weapon::ref_124ad(self)) {
      wait var0;
      continue;
    }

    if(!isDefined(var1)) {
      var1 = self.equippedweapons;
    }

    foreach(var3 in var1) {
      self givemaxammo(var3);
      self setweaponammoclip(var3, weaponclipsize(var3));
    }

    wait var0;
  }
}

function stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}

function jugg_createconfig(var0, var1) {
  var2 = spawnStruct();
  var2.maxhealth = 3000;
  var2.startinghealth = var2.maxhealth;
  var2.movespeedscalar = -0.2;
  var2.forcetostand = 1;
  var2.suit = "iw8_juggernaut_mp";
  var2.infiniteammo = 1;
  var2.infiniteammoupdaterate = undefined;
  var2.classstruct = jugg_getdefaultclassstruct();
  var2.allows = [];
  var2.allows["stick_kill"] = 1;
  var2.allows["health_regen"] = 1;
  var2.allows["one_hit_melee_victim"] = 1;
  var2.allows["flashed"] = 1;
  var2.allows["stunned"] = 1;
  var2.allows["prone"] = 1;
  var2.allows["usability"] = 1;
  var2.allows["supers"] = 1;
  var2.allows["killstreaks"] = 1;
  var2.allows["slide"] = 1;
  var2.allows["reload"] = 1;
  var2.allows["weapon_pickup"] = 1;
  var2.allows["execution_victim"] = 0;
  var2.perks = [];
  return var2;
}

function jugg_toggleallows(var0, var1) {
  foreach(var4, var3 in var0) {
    if(var3) {
      var4 = tolower(var4);
      self thread[[level.allow_funcs[var4]]](var1, "juggernaut");
    }
  }

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var1, "juggernaut");
    scripts\common\utility::allow_mount_side(var1, "juggernaut");
  }

  scripts\common\utility::allow_weapon_switch(var1);
  scripts\common\utility::allow_vehicle_use(var1);
}

function jugg_getdefaultclassstruct() {
  var0 = scripts\cp\cp_loadout::loadout_getclassstruct();
  var0.loadoutarchetype = "archetype_assault";
  var0.loadoutprimary = "iw8_minigunksjugg_mp";
  var0.loadoutsecondary = "none";
  return var0;
}

function jugg_watchfordeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self waittill("last_stand");
  jugg_removejuggernaut();
}

function jugg_watchfordamage() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self waittill("juggernaut_end_damage");
  jugg_removejuggernaut();
}

function vehicle_incomingcallback() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self.owner = self;
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("killstreakExit");

  if(istrue(self.ref_11e8f)) {
    thread vehicle_incomingcallback();
    return;
  }

  jugg_removejuggernaut();
}

function vehicle_incomingremovedcallback() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self endon("stop_hostagecarrier_watching_for_doors");
  self.owner = self;
  scripts\cp\utility::ref_14441();
}

function jugg_getjuggmodels() {
  var0 = [];
  GscBinSkip0(0x2e, "body", "body_opforce_juggernaut_mp_lod1");
}

function jugg_setModel() {
  var0 = jugg_getjuggmodels();
  var1 = var0["body"];
  var2 = var0["head"];
  var3 = var0["view"];
  scripts\cp\survival\survival_loadout::setcharactermodels(var1, var2, var3);
}

function jugg_restoremodel(var0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(var0.prevbody, var0.prevhead);
    var1 = self getcustomizationbody();
    var2 = self getcustomizationhead();
    var3 = self getcustomizationviewmodel();
    scripts\cp\survival\survival_loadout::setcharactermodels(var1, var2, var3);
    return;
  }
}

function jugg_needtochangestance(var0) {
  var1 = 0;
  var2 = self getstance();

  switch (var2) {
    case "stand":
      var1 = 0;
      break;
    case "crouch":
      if(var0.forcetostand || !var0.allowcrouch) {
        var1 = 1;
        break;
      }

      break;
    case "prone":
      if(var0.forcetostand || !var0.allowprone) {
        var1 = 1;
        break;
      }

      break;
  }

  return var1;
}

function jugg_canresolvestance(var0) {
  return true;
}

function jugg_handlestancechange(var0) {
  if(jugg_needtochangestance(var0)) {
    self setstance("stand");
    return;
  }
}

function jugg_enableoverlay(var0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "mask_on");
  self setclientomnvar(var0.maskomnvar, 1);
  self.juggoverlaystatelabel = "mask_on";
  self.juggoverlaystate = 1;
  thread jugg_watchoverlaydamagestates(var0);
  thread jugg_watchforoverlayexecutiontoggle(var0);
}

function jugg_watchoverlaydamagestates(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("juggernaut_end_damage");
  var1 = self.health;
  var2 = var0.prevmaxhealth;
  var3 = var1 - var2;
  var4 = var1 - var3 * 0.1;
  var5 = var1 - var3 * 0.35;
  var6 = var1 - var3 * 0.6;
  var7 = var1 - var3 * 0.85;
  var8 = 1;
  var9 = var8;
  var10 = "mask_on";

  for(;;) {
    self waittill("damage");

    if(self.health <= 0) {
      continue;
    }

    if(self.health <= var7) {
      var10 = "mask_damage_critical";
      var8 = 5;
    } else if(self.health <= var6) {
      var10 = "mask_damage_high";
      var8 = 4;
    } else if(self.health <= var5) {
      var10 = "mask_damage_med";
      var8 = 3;
    } else if(self.health <= var4) {
      var10 = "mask_damage_low";
      var8 = 2;
    }

    if(var9 != var8) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", var10);
      self setclientomnvar(var0.maskomnvar, var8);
      var9 = var8;
      self.juggoverlaystatelabel = var10;
      self.juggoverlaystate = var8;
    }
  }
}

function jugg_watchforoverlayexecutiontoggle(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("juggernaut_end");
  var1 = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(var1)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
        self setclientomnvar(var0.maskomnvar, self.juggoverlaystate);
        var1 = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var1)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      self setclientomnvar(var0.maskomnvar, 0);
      var1 = 1;
    }

    waitframe();
  }
}

function jugg_disableoverlay(var0) {
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(var0.maskomnvar, 0);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

function jugg_getmovespeedscalar() {
  return -0.2;
}