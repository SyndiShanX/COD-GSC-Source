#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\utility;
#define H2_REMOTE_THERMAL_DEFAULT false

thermalVision(ent, endonName) {
  level endon("game_ended");
  self endon("disconnect");
  ent endon(endonName);

  self notifyOnPlayerCommand("switch thermal", "+activate");
  self notifyOnPlayerCommand("switch thermal", "+usereload");
  self visionSetThermalForPlayer("black_bw", 0);
  self visionSetThermalForPlayer(game["thermal_vision"], 1);

  for(;;) {
    if(H2_REMOTE_THERMAL_DEFAULT) {
      self thermalVisionOn();

      self waittill("switch thermal");

      self thermalVisionOff();

      self waittill("switch thermal");
    } else {
      self thermalVisionOff();

      self waittill("switch thermal");

      self thermalVisionOn();

      self waittill("switch thermal");
    }
  }
}

remote_hud(ent, waitfor, text, timer, text2) {
  self endon("disconnect");

  hud = [];

  hud[0] = self createFontString("default", 1);
  hud[0] setPoint("RIGHT", "RIGHT", -100, 65);
  hud[0].alpha = 0.7;
  hud[0] setText(text);
  hud[0].hidewheninmenu = true;
  hud[0].archived = false;

  if(isDefined(text2)) {
    hud[2] = self createFontString("default", 1);
    hud[2] setPoint("RIGHT", "RIGHT", -100, 85);
    hud[2].alpha = 0.7;
    hud[2] setText(text2);
    hud[2].hidewheninmenu = true;
    hud[2].archived = false;
  }

  if(isDefined(timer)) {
    hud[1] = self createTimer("hudbig", 0.5);
    hud[1] setPoint("RIGHT", "BOTTOM", -150, -80);
    hud[1].hidewheninmenu = true;
    hud[1].archived = false;
    hud[1] setTimer(timer);
  }

  ent waittill(waitfor);

  hud[0] destroy();

  if(isDefined(text2)) {
    hud[2] destroy();
  }

  if(isDefined(timer)) {
    hud[1] destroy();
  }
}

h2_sound_ent(sound) {
  soundEnt = spawn("script_model", self.origin);
  soundEnt.angles = self.angles;
  soundEnt setModel("tag_origin");
  soundEnt setContents(0);
  soundEnt linkTo(self);
  soundEnt playLoopSound(sound);

  self waittill("death");

  soundEnt delete();
}

initRideKillstreak() {
  self _disableUsability();
  result = self initRideKillstreak_internal();

  if(isDefined(self)) {
    self _enableUsability();
  }

  return result;
}

initRideKillstreak_internal() {
  laptopWait = self waittill_any_timeout(1.0, "disconnect", "death", "weapon_switch_started");

  if(laptopWait == "weapon_switch_started") {
    return ("fail");
  }

  if(!isAlive(self)) {
    return "fail";
  }

  if(laptopWait == "disconnect" || laptopWait == "death") {
    if(laptopWait == "disconnect") {
      return ("disconnect");
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return ("success");
  }

  if(self isEMPed() || self isNuked()) {
    return ("fail");
  }

  self _visionsetnakedforplayer("black_bw", 0.75);
  blackOutWait = self waittill_any_timeout(0.80, "disconnect", "death");

  if(blackOutWait != "disconnect") {
    self thread clearRideIntro(1.0);

    if(self.team == "spectator") {
      return "fail";
    }
  }

  if(!isAlive(self)) {
    return "fail";
  }

  if(self isEMPed() || self isNuked()) {
    return "fail";
  }

  if(blackOutWait == "disconnect") {
    return ("disconnect");
  }
  else {
    return ("success");
  }
}

clearRideIntro(delay) {
  self endon("disconnect");

  if(isDefined(delay)) {
    wait(delay);
  }

  //self freezeControlsWrapper( false );

  if(!isDefined(level.nukeVisionInProgress)) {
    self _visionsetnakedforplayer("", 0);
  }
}

takeKillstreakWeapons() {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  if(!isReallyAlive(self) && !level.gameEnded) {
    return;
  }

  self takeAllKillstreakWeapons();
  self _giveWeapon("laptop_mp");
  self setSpawnWeapon("laptop_mp");

  wait 0.5;

  self switchToWeapon(self getLastWeaponWrapper());
}

takeAllKillstreakWeapons() {
  if(!isDefined(self)) {
    return;
  }

  if(!isReallyAlive(self) && !level.gameEnded) {
    return;
  }

  weaponsList = self getWeaponsListAll();

  foreach(item in weaponsList) {
    if(maps\mp\gametypes\_hardpoints::h2_isKillstreakActivator(item)) {
      continue;
    }

    if(isKillstreakWeapon(item)) {
      self takeWeapon(item);
    }
  }
}

getLastWeaponWrapper() {
  lastWeapon = self getLastWeapon();

  if(!self hasWeapon(lastWeapon)) {
    lastWeapon = self getFirstPrimaryWeapon();
  }

  return lastWeapon;
}

getFirstPrimaryWeapon() {
  weaponsList = self getWeaponsListPrimaries();

  assert(isDefined(weaponsList[0]));
  assert(!isKillstreakWeapon(weaponsList[0]));

  if(weaponsList[0] == "onemanarmy_mp") {
    assert(isDefined(weaponsList[1]));
    assert(!isKillstreakWeapon(weaponsList[1]));

    return weaponsList[1];
  }

  return weaponsList[0];
}