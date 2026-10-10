/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\vehicles\vehicle_utility.gsc
******************************************************/

#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace vehicle_utility;

function function_7d87dd9eb57867a1() {
  if(!isDefined(self.candamage)) {
    function_36dbb623c325c79(1);
  }

  thread vehicle_watch_for_driving(&function_fbef61d68f733524, &function_e5f869d16eb9abea);
}

function function_fbef61d68f733524(veh) {
  if(isDefined(veh.driver)) {
    return;
  }

  veh function_f3ae3ea0abca3cfb("tag_seat_0");
  veh.ownerid = self getentitynumber();
  veh.originalowner = self;
  self setplayerangles(veh.angles);
  veh setotherent(self);
  veh setentityowner(self);
  self controlslinkTo(veh);
  self playerlinktodelta(veh);
  function_a593971d75d82113(1);

  if(isDefined(veh.turret)) {
    veh.turret setotherent(self);
    self remotecontrolturret(veh.turret);
  }

  self notify("entered_driving_vehicle", veh);
}

function function_36dbb623c325c79(bool) {
  if(bool) {
    self.candamage = 1;
    self setCanDamage(1);
    return;
  }

  self.candamage = 0;
  self setCanDamage(0);
}

function function_e5f869d16eb9abea(veh) {
  if(!isDefined(veh.driver)) {
    return;
  }

  veh.ownerid = 0;
  veh.originalowner = undefined;
  self controlsunlink();
  self unlink();

  if(isDefined(veh.exitfunc)) {
    exitpos = [[veh.exitfunc]]();
  } else {
    exitpos = self.origin + anglestoright(self.angles) * -100 + anglesToForward(self.angles) * -80;
  }

  self setOrigin(scripts\engine\utility::drop_to_ground(exitpos, 0, 0));
  veh setotherent(undefined);
  veh setentityowner(undefined);
  function_6fb380927695ee76();

  if(isDefined(veh.turret)) {
    self remotecontrolturretoff(veh.turret);
    veh.turret setmode("sentry_offline");
  }

  self notify("exited_driving_vehicle", veh);
}

function function_f3ae3ea0abca3cfb(bone) {
  parts = getnumparts(self.model);

  if(parts > 0) {
    for(i = 0; i < parts; i++) {
      if(getpartname(self.model, i) == bone) {
        return true;
      }
    }
  }

  iprintln("WARNING! " + self.model + " does not have bone, " + bone);
  return false;
}

function vehicle_watch_for_driving(entercallback, exitcallback) {
  self endon("death");
  self notify("vehicle_watch_for_driving");
  self endon("vehicle_watch_for_driving");

  while(true) {
    waitframe();

    if(!isDefined(self.driver)) {
      player = function_e3834eefcc1ecd79(self);

      if(!isDefined(player)) {
        return;
      }

      player[[entercallback]](self);
      self.driver = player;
      player.vehicle = self;

      while(player useButtonPressed()) {
        waitframe();
      }

      continue;
    }

    player = self.driver;

    if(player useButtonPressed()) {
      player[[exitcallback]](self);
      self.driver = undefined;
      player.vehicle = undefined;

      while(player useButtonPressed()) {
        waitframe();
      }
    }
  }
}

function function_e3834eefcc1ecd79(veh) {
  useobj = spawn("script_model", veh.origin + (0, 0, 40));
  useobj makeusable();
  useobj setHintString(&"VEHICLES_HINTS/PICKUP_TRUCK_ENTER");
  useobj sethintdisplayrange(200);
  useobj setuserange(150);
  useobj setCursorHint("HINT_BUTTON");
  useobj sethintdisplayfov(120);
  useobj sethintonobstruction("show");
  useobj linkTo(veh);
  useobj waittill("trigger", player);
  useobj unlink();
  useobj delete();
  return player;
}