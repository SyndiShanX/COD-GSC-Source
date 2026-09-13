/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_439d01e25d19543b.gsc
***********************************************/

init() {
  if(getdvarint("dvar_81E631C248118CD6", 1) != 1) {
    return;
  }
  level._id_C0E521049F7AE2C9 = getdvarint("dvar_62FF9F6D45BB6187", 1);
  level._id_82C0CBD2D6453E77 = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_palfa");
  level._id_343E61767F194B9D = scripts\engine\utility::getStructArray("palfa_fuel_spawn", "targetname");
}

_id_E456F5964BA54D64() {
  if(getdvarint("dvar_81E631C248118CD6", 1) != 1) {
    return;
  }
  if(!isDefined(level._id_82C0CBD2D6453E77) || level._id_82C0CBD2D6453E77.size == 0 || !isDefined(level._id_343E61767F194B9D) || level._id_343E61767F194B9D.size == 0) {
    return;
  }
  scripts\cp_mp\utility\script_utility::registersharedfunc(23395, "pickedUp", ::_id_4579AE632E8313BD);
  _id_B389B85C70DC3C9B = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", scripts\engine\utility::random(level._id_82C0CBD2D6453E77));
  _id_B389B85C70DC3C9B._id_CF9BA498AF4E41E9 = 0;
  _id_B389B85C70DC3C9B._id_7EE6203C5532A9E6 = 1;
  _id_B389B85C70DC3C9B._id_A2BA7043631B3392 = 1;
  level._id_84B057F4F76A152A = _id_B389B85C70DC3C9B;

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    scripts\mp\outofbounds::enableoobimmunity(_id_B389B85C70DC3C9B);
    _id_B389B85C70DC3C9B._id_675F44ED226AED7D = ::_id_436C572E13C3C87F;
    _id_B389B85C70DC3C9B._id_7B468990DA46C73C = ::_id_FCE5E8B79CAC65B4;
    _id_B389B85C70DC3C9B._id_076B2C48898593E9 = ::_id_4EDCAAC915EDCD2E;
  }

  scripts\engine\utility::flag_wait("wztrain_scriptables_spawned");
  level._id_343E61767F194B9D = scripts\engine\utility::array_slice(sortbydistance(level._id_343E61767F194B9D, _id_B389B85C70DC3C9B.origin), level._id_343E61767F194B9D.size - 3);

  if(isDefined(level._id_C5B14273ADC323E2)) {
    level._id_343E61767F194B9D[randomint(level._id_343E61767F194B9D.size)] = level._id_C5B14273ADC323E2;
    level._id_C5B14273ADC323E2 = undefined;
  }

  _id_A620CB0E6444887F = getdvarint("dvar_D796F74DCF2618EF", 1);

  foreach(chosen in scripts\engine\utility::array_randomize(level._id_343E61767F194B9D)) {
    _id_CF9BA498AF4E41E9 = spawnscriptable("brloot_gascan_palfa", chosen.origin, chosen.angles);

    if(isDefined(chosen.traincar))
      _id_CF9BA498AF4E41E9 scripts\common\utility::_id_6E506F39F121EA8A(chosen.traincar, chosen.origin, chosen.angles);

    _id_CF9BA498AF4E41E9.count = 1;
    _id_CF9BA498AF4E41E9._id_BBC200BC77C5DB2B = 1;
    _id_7E52B56769FA7774::registerscriptableinstance(_id_CF9BA498AF4E41E9);
    _id_A620CB0E6444887F = _id_A620CB0E6444887F - 1;

    if(_id_A620CB0E6444887F <= 0)
      return;
  }
}

_id_436C572E13C3C87F(player) {
  scripts\mp\outofbounds::enableoobimmunity(player);
  player._id_076B2C48898593E9 = ::_id_10F36F1F7C586276;
  thread _id_14980658C4AE8EAA(player.team);
}

_id_14980658C4AE8EAA(team) {
  wait 4;

  if(isDefined(self) && self._id_CF9BA498AF4E41E9 <= 0)
    level thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("palfa_is_grounded", team);
}

_id_FCE5E8B79CAC65B4(player) {
  if(isDefined(player)) {
    player._id_076B2C48898593E9 = undefined;

    if(!istrue(player.extracted))
      scripts\mp\outofbounds::disableoobimmunity(player);
  }
}

_id_4579AE632E8313BD(scriptable, player) {
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("palfa_fuel_use", player.team);
}

_id_354BD1BA3062243D() {
  if(istrue(level._id_43834C3A158B5EFF)) {
    return;
  }
  level._id_43834C3A158B5EFF = 1;

  if(!isDefined(level._id_84B057F4F76A152A) || level._id_84B057F4F76A152A._id_CF9BA498AF4E41E9 <= 0) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("palfa_refueled", self.team);
    level._id_84B057F4F76A152A thread _id_B5F1B07A91E21EB9();
  }

  _id_35FD13041DDE93E8 = scripts\cp_mp\vehicles\vehicle::_id_471CDE1983A05F66(self, "veh9_palfa");
  scripts\cp_mp\vehicles\vehicle::_id_4201160D49C885A7(level._id_84B057F4F76A152A, _id_35FD13041DDE93E8);
  level._id_84B057F4F76A152A._id_7EE6203C5532A9E6 = undefined;
}

_id_B5F1B07A91E21EB9() {
  self endon("death");
  wait 60;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("palfa_flying_reminder", occupants);
}

_id_10F36F1F7C586276(_id_F85572CD5F6117C6) {
  _id_4EDCAAC915EDCD2E(level._id_84B057F4F76A152A);
}

_id_4EDCAAC915EDCD2E(heli) {
  if(istrue(level._id_32E5E1538FBE1D9D)) {
    return;
  }
  level._id_32E5E1538FBE1D9D = 1;
  _id_309C0A11484CC0DB = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(heli);
  _id_5307834CD39B435C::_id_E7994A561BE9B933(_id_309C0A11484CC0DB);
  heli._id_90ACDD32579DCB16 = 1;
  vehicles = vehicle_getarrayinradius(heli.origin, 500, 500);

  foreach(vehicle in vehicles) {
    foreach(_id_F85572CD5F6117C6 in vehicle.occupants) {
      if(isPlayer(_id_F85572CD5F6117C6) && scripts\mp\utility\player::isreallyalive(_id_F85572CD5F6117C6))
        _id_309C0A11484CC0DB = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_309C0A11484CC0DB, _id_F85572CD5F6117C6);
    }

    if(!istrue(vehicle._id_90ACDD32579DCB16))
      level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
  }

  heli._id_94CF3A68B99AE841 = 1;
  heli notify("exfil_path_started");
  info = _id_5C65D346AC65390C::_id_730C660D9FC6808E(_id_309C0A11484CC0DB, 0, 0, 0, 1);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("chopper_exfil", "exfil_players", _id_309C0A11484CC0DB, info);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(heli);
  waitframe();
  struct = spawnStruct();
  struct.origin = heli.origin;
  struct.angles = heli.angles;
  _id_35FD13041DDE93E8 = heli._id_35FD13041DDE93E8;
  scripts\cp_mp\vehicles\vehicle::vehicle_death(heli);
  _id_2425BC48C64278CD = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", struct);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(_id_2425BC48C64278CD);
  _id_2425BC48C64278CD scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  _id_2425BC48C64278CD _meth_247AD6A91F6A4FFE(1);
  scripts\cp_mp\vehicles\vehicle::_id_4201160D49C885A7(_id_2425BC48C64278CD, _id_35FD13041DDE93E8);
  path = _id_5C65D346AC65390C::_id_1093B8F392744E3B(_id_2425BC48C64278CD, _id_2425BC48C64278CD.origin + (0, 0, 1000) + 5000 * anglesToForward(_id_2425BC48C64278CD.angles), level._id_251923794D7ECF20.heliheight, 0);
  path.origin = struct.origin;
  path.angles = struct.angles;
  _id_2425BC48C64278CD thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
  _id_2425BC48C64278CD._id_1693991455559C14 = 1;
  _id_2425BC48C64278CD endon("death");
  wait 15;
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(_id_2425BC48C64278CD);
}