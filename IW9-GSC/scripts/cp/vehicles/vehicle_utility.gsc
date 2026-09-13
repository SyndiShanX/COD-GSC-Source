/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_utility.gsc
***************************************************/

_id_7D87DD9EB57867A1() {
  if(!isDefined(self._id_D60CC6DA4FB4A98C))
    _id_036DBB623C325C79(1);

  thread _id_4F182AD6B6D594DB(::_id_FBEF61D68F733524, ::_id_E5F869D16EB9ABEA);
}

_id_FBEF61D68F733524(veh) {
  if(isDefined(veh.driver)) {
    return;
  }
  veh _id_F3AE3EA0ABCA3CFB("tag_seat_0");
  veh.ownerid = self getentitynumber();
  veh.originalowner = self;
  self setplayerangles(veh.angles);
  veh setotherent(self);
  veh setentityowner(self);
  self controlslinkTo(veh);
  self playerlinktodelta(veh);
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113(1);

  if(isDefined(veh.turret)) {
    veh.turret setotherent(self);
    self remotecontrolturret(veh.turret);
  }

  self notify("entered_driving_vehicle", veh);
}

_id_036DBB623C325C79(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self._id_D60CC6DA4FB4A98C = 1;
    self setCanDamage(1);
  } else {
    self._id_D60CC6DA4FB4A98C = 0;
    self setCanDamage(0);
  }
}

_id_E5F869D16EB9ABEA(veh) {
  if(!isDefined(veh.driver)) {
    return;
  }
  veh.ownerid = 0;
  veh.originalowner = undefined;
  self controlsunlink();
  self unlink();

  if(isDefined(veh._id_BE3314F77FEF5D6B))
    _id_7E6EA515CDBB4A45 = [[veh._id_BE3314F77FEF5D6B]]();
  else
    _id_7E6EA515CDBB4A45 = self.origin + anglestoright(self.angles) * -100 + anglesToForward(self.angles) * -80;

  self setOrigin(scripts\engine\utility::drop_to_ground(_id_7E6EA515CDBB4A45, 0, 0));
  veh setotherent(undefined);
  veh setentityowner(undefined);
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();

  if(isDefined(veh.turret)) {
    self remotecontrolturretoff(veh.turret);
    veh.turret setmode("sentry_offline");
  }

  self notify("exited_driving_vehicle", veh);
}

_id_F3AE3EA0ABCA3CFB(bone) {
  parts = getnumparts(self.model);

  if(parts > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < parts; _id_AC0E594AC96AA3A8++) {
      if(getpartname(self.model, _id_AC0E594AC96AA3A8) == bone)
        return 1;
    }
  }

  iprintln("WARNING! " + self.model + " does not have bone, " + bone);
  return 0;
}

_id_4F182AD6B6D594DB(_id_2D2D28B1528166D2, _id_6166EC335950C5F2) {
  self endon("death");
  self notify("vehicle_watch_for_driving");
  self endon("vehicle_watch_for_driving");

  for(;;) {
    waitframe();

    if(!isDefined(self.driver)) {
      player = _id_E3834EEFCC1ECD79(self);

      if(!isDefined(player)) {
        return;
      }
      player[[_id_2D2D28B1528166D2]](self);
      self.driver = player;
      player.vehicle = self;

      while(player useButtonPressed())
        waitframe();

      continue;
    }

    player = self.driver;

    if(player useButtonPressed()) {
      player[[_id_6166EC335950C5F2]](self);
      self.driver = undefined;
      player.vehicle = undefined;

      while(player useButtonPressed())
        waitframe();
    }
  }
}

_id_E3834EEFCC1ECD79(veh) {
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