/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\gestures_cp.gsc
***********************************************/

#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\movement;
#using scripts\cp\utility\lui_game_event_aggregator;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#namespace gestures_cp;

function init_cp() {
  scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(&watchradialgestureactivation);
  scripts\common\notetrack::function_11f8c6d6f5ba948();
}

function player_gesture_force(gesturename, lookatent) {
  self endon("death");
  gestureplayed = 0;
  blendtime = undefined;
  canceltransition = 0;

  if(get_player_demeanor() == "safe") {
    blendtime = 0.2;
    canceltransition = 1;
  }

  if(isDefined(lookatent) && isent(lookatent)) {
    gestureplayed = self forceplaygestureviewmodel(gesturename, lookatent, blendtime, undefined, undefined);
  } else {
    gestureplayed = self forceplaygestureviewmodel(gesturename, undefined, blendtime, undefined, undefined);
  }

  if(gestureplayed) {
    thread player_gestures_input_disable(gesturename, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "gesture");
  }

  return gestureplayed;
}

function player_gestures_input_disable(gesturename, pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, disabletime, tag) {
  self endon("death");

  if(!isDefined(tag)) {
    tag = "gesture";
  }

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(pronemovement) && pronemovement == 1) {
    if(self getstance() == "prone") {
      val::set(tag + "_prone", "allow_movement", 0);
      thread player_gestures_prone_getup_think(gesturename, tag);

      if(!isDefined(self.gestures.restrictingpronespeed)) {
        self.gestures.restrictingpronespeed = 0;
      }

      self.gestures.restrictingpronespeed++;
    } else {
      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "prone", 0);
    }

    self.gestures.restrictingpronemovement = 1;
  }

  if(isDefined(mantle) && mantle == 1) {
    if(!isDefined(self.gestures.restrictingmantle)) {
      self.gestures.restrictingmantle = 0;
    }

    self.gestures.restrictingmantle++;
    val::set(tag, "mantle", 0);
  }

  if(isDefined(sprint) && sprint == 1) {
    if(!isDefined(self.gestures.restrictingsprint)) {
      self.gestures.restrictingsprint = 0;
    }

    self.gestures.restrictingsprint++;
    val::set(tag, "sprint", 0);
  }

  if(isDefined(fire) && fire == 1) {
    if(!isDefined(self.gestures.restrictingfire)) {
      self.gestures.restrictingfire = 0;
    }

    self.gestures.restrictingfire++;
    val::set(tag, "fire", 0);
  }

  if(isDefined(reload) && reload == 1) {
    if(!isDefined(self.gestures.restrictingreload)) {
      self.gestures.restrictingreload = 0;
    }

    self.gestures.restrictingreload++;
    val::set(tag, "reload", 0);
  }

  if(isDefined(weaponswitch) && weaponswitch == 1) {
    if(!isDefined(self.gestures.restrictingweaponswitch)) {
      self.gestures.restrictingweaponswitch = 0;
    }

    self.gestures.restrictingweaponswitch++;
    val::set(tag, "weapon_switch", 0);
  }

  if(isDefined(ads) && ads == 1) {
    if(!isDefined(self.gestures.restrictingads)) {
      self.gestures.restrictingads = 0;
    }

    self.gestures.restrictingads++;
    val::set(tag, "ads", 0);
  }

  if(isDefined(wallrun) && wallrun == 1) {
    if(!isDefined(self.gestures.restrictingwallrun)) {
      self.gestures.restrictingwallrun = 0;
    }

    self.gestures.restrictingwallrun++;
    val::set(tag, "wallrun", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    if(!isDefined(self.gestures.restrictingdoublejump)) {
      self.gestures.restrictingdoublejump = 0;
    }

    self.gestures.restrictingdoublejump++;
    val::set(tag, "doublejump", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    if(!isDefined(self.gestures.restrictingmeleeattack)) {
      self.gestures.restrictingmeleeattack = 0;
    }

    self.gestures.restrictingmeleeattack++;
    val::set(tag, "melee", 0);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    if(!isDefined(self.gestures.restrictingoffhandweapons)) {
      self.gestures.restrictingoffhandweapons = 0;
    }

    self.gestures.restrictingoffhandweapons++;
    val::set(tag, "offhand_weapons", 0);
  }

  if(isDefined(disabletime)) {
    wait disabletime;
  } else {
    self waittill("gesture_stopped", stoppedgesturename);

    if(stoppedgesturename != gesturename) {
      while(true) {
        if(!self isgestureplaying(gesturename)) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self notify(gesturename + "gesture_stopped_internal");
  player_gestures_input_enable(pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag);
}

function player_gestures_input_enable(pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag) {
  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(pronemovement) && pronemovement > 0) {
    if(isDefined(self.gestures.restrictingpronespeed) && self.gestures.restrictingpronespeed > 0) {
      self.gestures.restrictingpronespeed--;

      if(self.gestures.restrictingpronespeed <= 0) {
        val::set(tag + "_prone", "allow_movement", 1);
      }
    }

    if(isDefined(self.gestures.restrictingpronestance) && self.gestures.restrictingpronestance > 0) {
      self.gestures.restrictingpronestance--;
      val::reset_all(tag);
    }
  }

  if(isDefined(mantle) && mantle == 1) {
    val::reset_all(tag);
  }

  if(isDefined(sprint) && sprint == 1) {
    val::reset_all(tag);
  }

  if(isDefined(fire) && fire == 1) {
    val::reset_all(tag);
  }

  if(isDefined(reload) && reload == 1) {
    val::reset_all(tag);
  }

  if(isDefined(weaponswitch) && weaponswitch == 1) {
    val::reset_all(tag);
  }

  if(isDefined(ads) && ads == 1) {
    val::reset_all(tag);
  }

  if(isDefined(wallrun) && wallrun == 1) {
    val::set(tag, "wallrun", 0);
  }

  if(isDefined(doublejump) && doublejump == 1) {
    val::set(tag, "doublejump", 0);
  }

  if(isDefined(meleeattack) && meleeattack == 1) {
    val::reset_all(tag);
  }

  if(isDefined(offhandweapons) && offhandweapons == 1) {
    val::reset_all(tag);
  }
}

function player_gestures_prone_getup_think(gesturename, tag) {
  self endon("death");
  self endon(gesturename + "gesture_stopped_internal");
  stillprone = 1;

  while(stillprone) {
    if(self getstance() != "prone") {
      waittillframeend();
      self.gestures.restrictingpronespeed--;

      if(self.gestures.restrictingpronespeed <= 0) {
        val::set(tag + "_prone", "allow_movement", 1);
      }

      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      val::set(tag, "prone", 0);
      stillprone = 0;
    }

    wait 0.05;
  }
}

function get_player_demeanor() {
  return self getdemeanorviewmodel();
}