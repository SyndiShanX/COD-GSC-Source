/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5120873d6d2bb7e2.gsc
***********************************************/

_id_69B64F047B0AF1DB(minradius, minspeed) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event._id_FBEFCC9EBBC882DA = minradius * minradius;
  event.minspeed = minspeed;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_D4BF8990034D5707 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_D4BF8990034D5707;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    if(isDefined(level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E)) {
      foreach(player in level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E) {
        if(isalliedsentient(player, self)) {
          continue;
        }
        vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

        if(isDefined(vehicle) && vehicle _meth_0F96CAFFD866A1B2() && !scripts\engine\utility::array_contains(event.result, vehicle) && vehicle.veh_speed > event.minspeed && distance2dsquared(self.origin, vehicle.origin) <= event._id_FBEFCC9EBBC882DA)
          event.result[event.result.size] = vehicle;
      }
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}

_id_608AD5A3783431D9() {
  level endon("game_ended");

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E))
    level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E = [];

  for(;;) {
    message = scripts\engine\utility::waittill_any_in_array_return(["death", "disconnect", "vehicle_enter", "vehicle_exit"]);

    switch (message) {
      case "vehicle_enter":
        if(!scripts\engine\utility::array_contains(level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E, self))
          level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E[level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E.size] = self;

        break;
      case "vehicle_exit":
        level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E = scripts\engine\utility::array_remove(level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E, self);
        break;
      case "disconnect":
      case "death":
        level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E = scripts\engine\utility::array_remove(level._id_3C59090EE220AB3D.events._id_D603EAAB3906B19E, self);
        return;
    }
  }
}