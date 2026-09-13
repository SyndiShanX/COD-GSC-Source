/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2190c693b7121ab3.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  _id_30A591676D601C38();
  data.funcs["onInit"] = ::_id_E05BDB2A6122FE4A;
  data.funcs["onTeamAssigned"] = ::_id_89E3FC49199D2019;
  data.funcs["onCancel"] = ::_id_4448CCF5AAAFBCD2;
  data.funcs["onPlayerTearDown"] = ::_id_30FF47CFFE7FCA99;
  data.funcs["onPlayerAssimilated"] = ::_id_E16CC4EFA3A21AAD;
}

_id_30A591676D601C38() {
  _id_ADC3C411E839C811();
  _id_63EDE2E37AD0A069();
  _id_89538DC128A24E58();
}

_id_ADC3C411E839C811() {
  level._id_4E85625F13C359AB = spawnStruct();
  level._id_4E85625F13C359AB.enabled = getdvarint("dvar_BF18F9E007484FA5", 1);
  level._id_4E85625F13C359AB.time = getdvarint("dvar_64A7B52ADCE89EA5", 240);
  level._id_4E85625F13C359AB._id_CF9F04C2455C9551 = getdvarint("dvar_8F30C2023A4A5765", 2500);
  level._id_4E85625F13C359AB._id_5250E11F76EAF5BB = getdvarint("dvar_41EF549B795F9FC3", 15000);
  level._id_4E85625F13C359AB._id_946B411053737262 = getdvarint("dvar_DDBF53085A7A7D1C", 5000);
  level._id_4E85625F13C359AB._id_A8F585DEAC0AAA44 = getdvarint("dvar_B00AE4EDB676DEB6", 15000);
  level._id_4E85625F13C359AB._id_623C71246715C68A = getdvarint("dvar_1A693B17E369558C", 6000);
  level._id_4E85625F13C359AB._id_F618C857C91D9ADC = getdvarint("dvar_D33E01D1A7ED8DC6", 12500);
  level._id_4E85625F13C359AB._id_B4862B86B957B504 = getdvarint("dvar_3B590A4A694673AF", 2);
  level._id_4E85625F13C359AB._id_1AA0D8C830908356 = getdvarint("dvar_AC6AB3E7F4C59A81", 5);
  level._id_4E85625F13C359AB._id_DAD5ABD3A17A252E = getdvarint("dvar_FC51239397667145", 0);
  level._id_4E85625F13C359AB._id_C9A4667D43C3D2B7 = getdvarint("dvar_AB5A3352CFCE280E", 0);
  level._id_4E85625F13C359AB._id_74DE30492B65DEDB = getdvarint("dvar_CF9C5344C4606910", 0);
  level._id_4E85625F13C359AB._id_F767533F0CC83C57 = getdvarint("dvar_6127B0A8716B968A", 0);
  level._id_4E85625F13C359AB._id_4156AA8334394ED5 = getdvarint("dvar_E8FFE4AB1D755918", 6);
  level._id_4E85625F13C359AB._id_3B2141E078017F8C = getdvarint("dvar_6822A5AB6D0EE5B5", 1);
  level._id_4E85625F13C359AB._id_B3EB64B6C448164B = getdvarint("dvar_CDF23D9F5E7A81EC", 1);
  level._id_4E85625F13C359AB._id_796EBB8AD5062D75 = pow(level._id_4E85625F13C359AB._id_CF9F04C2455C9551, 2);
  level._id_4E85625F13C359AB._id_C4AFB81E4C3625AB = pow(level._id_4E85625F13C359AB._id_5250E11F76EAF5BB, 2);
  level._id_4E85625F13C359AB._id_3988D42DA71AC896 = pow(level._id_4E85625F13C359AB._id_946B411053737262, 2);
  level._id_4E85625F13C359AB._id_4D62BDA520DA444C = pow(level._id_4E85625F13C359AB._id_A8F585DEAC0AAA44, 2);
  level._id_4E85625F13C359AB._id_2B88A7031924B832 = scripts\engine\utility::getStructArray("searchseizure_poi", "script_noteworthy");
  level.averagealliesz = scripts\engine\utility::_id_53C4C53197386572(level.averagealliesz, 0);
}

_id_63EDE2E37AD0A069() {
  if(level._id_4E85625F13C359AB._id_C9A4667D43C3D2B7)
    _id_25C7A5935190C3F0::init();

  level._id_D8DB1602C8BF473E["brloot_vehiclekeys_contract"] = ::_id_794A9CABCCF51A7A;
  level thread _id_2CD86AA2DC9D1E75();
}

_id_89538DC128A24E58() {
  game["dialog"]["mission_searchseizure_accept"] = "srcs_wzan_sscs";
  game["dialog"]["mission_searchseizure_success"] = "srcs_wzan_sscv";
  game["dialog"]["mission_searchseizure_fail_destroyed"] = "srcs_wzan_ssvd";
  game["dialog"]["mission_searchseizure_fail_lost"] = "srcs_wzan_ssvl";
  game["dialog"]["mission_searchseizure_fail_time"] = "srcs_wzan_sscf";
  game["dialog"]["mission_searchseizure_no_exfil"] = "srcs_wzan_ssne";
  game["dialog"]["mission_searchseizure_timer"] = "srcs_wzan_sstm";
  game["dialog"]["mission_searchseizure_dropoff_coord"] = "srcs_wzan_ssup";
  game["dialog"]["mission_searchseizure_dist_far1"] = "srcs_wzan_ssd1";
  game["dialog"]["mission_searchseizure_dist_far2"] = "srcs_wzan_ssd2";
  game["dialog"]["mission_searchseizure_dist_close1"] = "srcs_wzan_ssd3";
  game["dialog"]["mission_searchseizure_dist_close2"] = "srcs_wzan_ssd4";
  game["dialog"]["mission_searchseizure_dz_cleared"] = "srcs_wzan_ssea";
  game["dialog"]["mission_searchseizure_key"] = "srcs_wzan_sses";
  game["dialog"]["mission_searchseizure_airstrike"] = "srcs_wzan_ssas";
  game["dialog"]["mission_searchseizure_heli_arrive"] = "srcs_wzan_sshl";
  game["dialog"]["mission_searchseizure_heli_destroy"] = "srcs_wzan_sshd";
  game["dialog"]["mission_searchseizure_heli_depart"] = "srcs_wzan_ssha";
}

_id_2CD86AA2DC9D1E75() {
  level waittill("prematch_done");
  _id_48814951E916AF89::_id_BA4022744DCE59F6("searchseizure", 50);
  _id_252FA7D2B1B1B50B::_id_B146E2B40516B668("searchseizure");
}

_id_8B51245F6BBE5BBD(_id_56AC4B49CC795BC0) {
  _id_6F42354CEBCD7F35 = getclosestpointonnavmesh(self.origin);

  if(!isDefined(_id_6F42354CEBCD7F35)) {
    return;
  }
  spawnpoints = getrandomnavpoints(_id_6F42354CEBCD7F35, 1536, 64);
  _id_59BA6BE73235750F = [];

  if(!isDefined(spawnpoints)) {
    return;
  }
  _id_8357FB6A08A850D5 = randomintrange(level._id_4E85625F13C359AB._id_B4862B86B957B504, level._id_4E85625F13C359AB._id_1AA0D8C830908356);
  spawnpoints = scripts\engine\utility::array_randomize(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    if(distance2dsquared(self.origin, spawnpoint) <= pow(192, 2) || !_id_120270BD0A747A35::_id_5867290FDA7A1AC1(spawnpoint, 64, 512, 128)) {
      continue;
    }
    _id_59BA6BE73235750F = scripts\engine\utility::array_add(_id_59BA6BE73235750F, spawnpoint);

    if(_id_59BA6BE73235750F.size % 2 == 0 && _id_59BA6BE73235750F.size != _id_8357FB6A08A850D5)
      _id_59BA6BE73235750F = scripts\engine\utility::array_add(_id_59BA6BE73235750F, spawnpoint);

    if(_id_59BA6BE73235750F.size == _id_8357FB6A08A850D5) {
      break;
    }
  }

  _id_FCDC7F62624C71FF = "guard";
  groupname = _id_48814951E916AF89::_id_78759441C259F58A();
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_59BA6BE73235750F[0]);
  self.agents = [];
  self.groupname = groupname;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_59BA6BE73235750F.size; _id_AC0E594AC96AA3A8++) {
    tier = 1 + (istrue(_id_56AC4B49CC795BC0) && _id_AC0E594AC96AA3A8 + 1 == _id_59BA6BE73235750F.size);
    _id_DCF5E15C58C4152A = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, _id_171F90B9C4C76D44, _id_FCDC7F62624C71FF, undefined, tier, undefined);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_DCF5E15C58C4152A, _id_59BA6BE73235750F[_id_AC0E594AC96AA3A8], (0, randomint(360), 0), "high", "searchseizure", "searchTask", groupname, undefined, undefined, _id_171F90B9C4C76D44, 0, 0, 0, undefined, 0);

    if(isDefined(agent)) {
      if(isagent(agent)) {
        _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "groupName", groupname);
        agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256, _id_59BA6BE73235750F[_id_AC0E594AC96AA3A8]);
        self.agents = scripts\engine\utility::array_add(self.agents, agent);
      } else {}

      continue;
    }
  }
}

_id_C99B96671F305D48(baseaccuracy, time) {
  self endon("death");
  _id_FD9D97F334DB3D29 = self.baseaccuracy;
  self.baseaccuracy = baseaccuracy;
  scripts\engine\utility::waittill_notify_or_timeout("damage", time);
  self.baseaccuracy = _id_FD9D97F334DB3D29;
}

_id_F23647A77EE053E4() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self clearlookatent();
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  _id_DF6C75D1A1E4FF18 = 3;
  _id_E757789796C82383 = (0, 0, 1000);
  _id_BB0E78A73B33D580 = self.origin + _id_E757789796C82383;
  _id_BC09A6E223B96348 = undefined;
  _id_690E4620FE5FA98F = undefined;
  _id_EC0C66C48E6F8304 = undefined;

  while(_id_DF6C75D1A1E4FF18 > 0) {
    flightpath = scripts\cp_mp\utility\killstreak_utility::_id_999FE3838D6B6F8C(_id_BB0E78A73B33D580, self.angles, 350, 25000);

    if(isDefined(flightpath.end)) {
      _id_BC09A6E223B96348 = flightpath.start;
      _id_690E4620FE5FA98F = flightpath.end;
      _id_EC0C66C48E6F8304 = flightpath.angles;
      break;
    }

    _id_BB0E78A73B33D580 = _id_BB0E78A73B33D580 + (0, 0, 1000);
    _id_DF6C75D1A1E4FF18--;
    wait 0.05;
  }

  if(!isDefined(_id_690E4620FE5FA98F)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_crash(100);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_explode();
  } else {
    _id_1602FAB5EAB68601 = 150;
    _id_2451A07ACA478BF6 = 50;
    self setyawspeed(_id_1602FAB5EAB68601, 50, 50, 0.5);
    self settargetyaw(_id_EC0C66C48E6F8304[1]);
    self vehicle_setspeed(_id_2451A07ACA478BF6, 25);
    pathgoal = _id_BC09A6E223B96348;
    self setvehgoalpos(pathgoal, 1);
    self waittill("goal");
    _id_F457885F9E89C75D = 0;

    while(_id_F457885F9E89C75D < 2) {
      _id_9DBBC8DD984310F1 = (0, self.angles[1], 0);
      _id_93E14809173F1E03 = _id_EC0C66C48E6F8304 - _id_9DBBC8DD984310F1;

      if(abs(_id_93E14809173F1E03[1]) < 5) {
        break;
      }

      _id_F457885F9E89C75D = _id_F457885F9E89C75D + level.framedurationseconds;
      waitframe();
    }

    self setmaxpitchroll(15, 15);
    self vehicle_setspeed(150, self.accel);
    self setvehgoalpos(_id_690E4620FE5FA98F, 1);
    self setneargoalnotifydist(1000);
    scripts\engine\utility::waittill_any_timeout_1(10, "near_goal");
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_cleanup(0);
  }
}

helicopter_start(position, _id_9CA5B7427AE3D1F2, _id_0EC75CFF8B549413) {
  _id_109D904FA5BB4C5C = spawnStruct();
  _id_109D904FA5BB4C5C.health = 5000;
  _id_109D904FA5BB4C5C.speed = 100;
  _id_109D904FA5BB4C5C.accel = 40;
  _id_109D904FA5BB4C5C._id_A659D1D5A6693D1A = 16;
  _id_109D904FA5BB4C5C._id_B4101D72E3CD2ABD = 3;
  _id_109D904FA5BB4C5C._id_62C8F81FFF6AA072 = 0.1;
  _id_109D904FA5BB4C5C.accuracy = 35;
  _id_109D904FA5BB4C5C._id_49D076A82A5DC908 = 4000000;
  _id_109D904FA5BB4C5C.team = "team_hundred_ninety_five";
  position = position + (0, 0, 1000);
  escortheli = _id_25C7A5935190C3F0::_id_3DDB1DE0C470A2B2(_id_9CA5B7427AE3D1F2, _id_0EC75CFF8B549413, position, _id_109D904FA5BB4C5C);

  if(!isDefined(escortheli))
    return undefined;

  return escortheli;
}

_id_37E73A6A4C1AFB18(_id_FABF84450735DD93) {
  _id_64ACB6CE534155B7::createquestobjicon("ui_map_icon_obj_searchseizure", "current");
  objective_removeallfrommask(self.objectiveiconid);
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    if(scripts\mp\utility\player::isreallyalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
      objective_addclienttomask(self.objectiveiconid, player);
  }

  objective_setshowdistance(self.objectiveiconid, 1);
  objective_setdescription(self.objectiveiconid, &"MP_DMZ_MISSIONS/CONTRACT_ICON_LABEL");
}

_id_545F0DF81E095369(target, _id_630CC7E8A4141D21) {
  self endon("task_ended");
  self endon("task_cleanup");

  if(!isDefined(self.objectiveiconid)) {
    return;
  }
  if(isDefined(target)) {
    if(isvector(target)) {
      scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, target + (0, 0, 64));
      scripts\mp\objidpoolmanager::update_objective_setzoffset(self.objectiveiconid, 0);
    } else if(isent(target) || target isscriptable()) {
      scripts\mp\objidpoolmanager::update_objective_onentity(self.objectiveiconid, target);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(self.objectiveiconid, 64);
    }

    scripts\mp\objidpoolmanager::objective_set_pulsate(self.objectiveiconid, istrue(_id_630CC7E8A4141D21));
  } else {}
}

_id_794A9CABCCF51A7A(pickup, player) {
  if(isDefined(pickup.instance) && isDefined(pickup.instance._id_B8EBE3F71A08AB40)) {
    instance = pickup.instance;
    _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;
    _id_B8EBE3F71A08AB40 _id_545F0DF81E095369(_id_B8EBE3F71A08AB40.vehicle);

    if(isDefined(_id_B8EBE3F71A08AB40.vehicle.useobject))
      _id_B8EBE3F71A08AB40.vehicle.useobject delete();

    _id_B8EBE3F71A08AB40.vehicle thread _id_CCA3D2BC5739C2A6(_id_B8EBE3F71A08AB40, 0);
    return 1;
  }

  return 0;
}

_id_3FB629470EA4F5F6() {
  self waittill("death");
  params = spawnStruct();
  params.intvar = 0;
  _id_B8EBE3F71A08AB40 = self._id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::displayteamsplash(_id_B8EBE3F71A08AB40.teams[0], "br_searchseizure_quest_failure", params, "splash_list_br_contract_searchseizure");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_fail_destroyed", _id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");
  _id_B8EBE3F71A08AB40 thread _id_8D032F436B816D9D(0);
}

_id_4D6D52197650FB91() {
  self endon("death");
  self endon("kill_distance_watcher");
  _id_B4F98212CBC88C60 = 0;
  _id_47F2674D63CD0747 = 0;
  _id_5DB87D3DF0B608EF = level._id_4E85625F13C359AB._id_3988D42DA71AC896 * pow(1.5, 2);
  _id_24D0D992023428E0 = level._id_4E85625F13C359AB._id_3988D42DA71AC896 * pow(1.5, 2);

  if(self.vehiclename == "veh9_suv_1996")
    scripts\engine\utility::wait_time_in_ms(5000.0);

  for(;;) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    if(occupants.size == 0) {
      waitframe();
      continue;
    }

    if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
      self notify("kill_distance_watcher");
      return;
    }

    if(!_id_B4F98212CBC88C60 && distance2dsquared(self.origin, self._id_B8EBE3F71A08AB40.endnode.origin) <= _id_5DB87D3DF0B608EF) {
      _id_B4F98212CBC88C60 = 1;
      self._id_B8EBE3F71A08AB40 notify("task_within_distance");

      if(scripts\engine\utility::cointoss())
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dist_far1", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");
      else
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dist_far2", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");

      waitframe();
      continue;
    }

    if(!_id_47F2674D63CD0747 && level._id_4E85625F13C359AB._id_DAD5ABD3A17A252E > 1 && distance2dsquared(self.origin, self._id_B8EBE3F71A08AB40.endnode.origin) <= _id_24D0D992023428E0) {
      _id_47F2674D63CD0747 = 1;
      self._id_B8EBE3F71A08AB40 notify("task_eliminate_hostiles");

      if(scripts\engine\utility::cointoss())
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dist_close1", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");
      else
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dist_close2", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");

      return;
    }

    wait 1.0;
  }
}

_id_4944E32D48208083(type, origin, angles) {
  spawnposition = origin;
  spawnangles = angles * (0, 1, 0);
  spawndata = spawnStruct();
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  spawndata.spawntype = "LEVEL";
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(type, "land"), "veh9_suv_1996", "veh9_patrol_boat"), spawndata);
  vehicle._id_CF9BA498AF4E41E9 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(vehicle.vehiclename)._id_29F1EA79ED2B40DD / 2;
  vehicle._id_7EE6203C5532A9E6 = 1;
  vehicle.damagecallback = ::_id_96B758D589365EF6;
  return vehicle;
}

_id_AC069E47F0EF3B9E(_id_B8EBE3F71A08AB40, vehicle) {
  self endon("entitydeleted");
  _id_B8EBE3F71A08AB40 endon("task_ended");
  vehicle endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(scripts\mp\utility\player::isinlaststand(player)) {
      continue;
    }
    if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
      return;
    }
    if(isDefined(_id_B8EBE3F71A08AB40._id_7BC06C0F8542A87C)) {
      _id_B8EBE3F71A08AB40 _id_545F0DF81E095369(vehicle);
      _id_7E52B56769FA7774::loothide(_id_B8EBE3F71A08AB40._id_7BC06C0F8542A87C);
    }

    vehicle thread _id_CCA3D2BC5739C2A6(_id_B8EBE3F71A08AB40, 0);
    self delete();
  }
}

_id_96B758D589365EF6(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(istrue(attacker._id_C0AA24316813868F) && objweapon.basename == "toma_proj_mp") {
    _id_45C7A5781E6CED58 = scripts\engine\utility::ter_op(self.vehiclename == "veh9_suv_1996", 3, 5);
    damage = int(ceil(self.maxhealth / _id_45C7A5781E6CED58));
    self._id_1FAA3D3DEC8D49BD = 1;
  }

  self[[level.vehicles.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
  self._id_1FAA3D3DEC8D49BD = undefined;
}

_id_85DC015A530EBA24() {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  childthread _id_3FB629470EA4F5F6();
  childthread _id_C54F10C1D2CD38D5();
}

_id_C54F10C1D2CD38D5() {
  self endon("death");

  for(;;) {
    self waittill("vehicle_owner_update");

    if(!isDefined(self.owner) || scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
      continue;
    }
    driver = self.owner;

    if(driver.team != self._id_B8EBE3F71A08AB40.teams[0]) {
      params = spawnStruct();
      params.intvar = 0;
      self._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::displayteamsplash(self._id_B8EBE3F71A08AB40.teams[0], "br_searchseizure_quest_target_lost", params, "splash_list_br_contract_searchseizure");
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_fail_lost", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");
      self._id_B8EBE3F71A08AB40 thread _id_8D032F436B816D9D(0);
      return;
    }

    driver childthread _id_D40A1DB55C22ABAC(self);
    self._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::displayteamsplash(driver.team, "br_searchseizure_quest_deliver_asset", undefined, "splash_list_br_contract_searchseizure");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dropoff_coord", self._id_B8EBE3F71A08AB40.teams[0], 1, 2, undefined, "dx_br_seal_");

    if(istrue(self._id_B8EBE3F71A08AB40._id_096F861DAEEB48A6)) {
      self._id_B8EBE3F71A08AB40 _id_545F0DF81E095369(self._id_B8EBE3F71A08AB40.endnode.groundpos);
      continue;
    }

    self._id_B8EBE3F71A08AB40 thread _id_0E6858A6A14325D0(driver, self);
  }
}

_id_D40A1DB55C22ABAC(vehicle) {
  scripts\engine\utility::waittill_any_3("vehicle_seat_exit", "death_or_disconnect", "killed_player");

  if(isDefined(self.vehicle)) {
    return;
  }
  if(vehicle.occupants.size > 0) {
    return;
  }
  vehicle._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::displayteamsplash(self.team, "br_searchseizure_quest_deliver_asset", undefined, "splash_list_br_contract_searchseizure");
  vehicle._id_B8EBE3F71A08AB40 _id_545F0DF81E095369(vehicle);
}

_id_894FDC630B584297(origin, angles, radius, height) {
  trigger = spawn("trigger_radius", origin, 0, radius, height);
  trigger.effect = spawnfx(level._effect["vfx_smktrail_mortar"], origin + (0, 0, 16));
  trigger.angles = angles;
  trigger thread _id_26A3B8AADF24C800(self);
  triggerfx(trigger.effect);
  return trigger;
}

_id_26A3B8AADF24C800(_id_B8EBE3F71A08AB40) {
  level endon("game_ended");
  _id_B8EBE3F71A08AB40 endon("task_ended");
  driver = undefined;

  for(;;) {
    self waittill("trigger", entity);

    if(isDefined(entity) && entity scripts\cp_mp\vehicles\vehicle::isvehicle() && !entity scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
      if(!scripts\engine\utility::is_equal(_id_B8EBE3F71A08AB40, entity._id_B8EBE3F71A08AB40)) {
        continue;
      }
      if(level._id_4E85625F13C359AB._id_F767533F0CC83C57 && (isDefined(entity._id_B8EBE3F71A08AB40.endnode.agents) && entity._id_B8EBE3F71A08AB40.endnode.agents.size > 0)) {
        continue;
      }
      _id_F85572CD5F6117C6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(entity);

      if(!isDefined(_id_F85572CD5F6117C6)) {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(entity);

        if(occupants.size > 0) {
          keys = getarraykeys(occupants);
          _id_F85572CD5F6117C6 = occupants[keys[0]];
        }
      }

      break;
    }
  }

  _id_FABF84450735DD93 = _id_B8EBE3F71A08AB40.teams[0];
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, _id_F85572CD5F6117C6, 8, _id_64ACB6CE534155B7::getquestindex("searchseizure"));
  rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("searchseizure", _id_FABF84450735DD93, _id_B8EBE3F71A08AB40.vehicle);

  if(!_id_2CEDCC356F1B9FC8::istutorial()) {
    if(isDefined(rewards) && isDefined(rewards["plunder"]))
      _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_searchseizure_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("searchseizure"), rewards["plunder"], _id_FABF84450735DD93, undefined, "splash_list_br_contract_searchseizure");

    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_success", _id_FABF84450735DD93, 1, 2, undefined, "dx_br_seal_");
  }

  _id_B8EBE3F71A08AB40 thread _id_8D032F436B816D9D(1);
}

_id_CCA3D2BC5739C2A6(_id_B8EBE3F71A08AB40, _id_20E9F4F3F1F66219) {
  self.islocked = 0;
  _id_B8EBE3F71A08AB40._id_7BC06C0F8542A87C = undefined;
  scripts\common\utility::_id_3677F2BE30FDD581("single", "vehicle_use");

  if(istrue(_id_20E9F4F3F1F66219)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40.teams[0], "players"))
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6B31DAEAAD06CAA5");

  if(self getscriptablehaspart("lights")) {
    scripts\common\utility::_id_3677F2BE30FDD581("car_alarm", "off");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 % 2 == 0)
        scripts\common\utility::_id_3677F2BE30FDD581("lights", "on");
      else
        scripts\common\utility::_id_3677F2BE30FDD581("lights", "off");

      wait 0.5;
    }
  }
}

_id_DD9EC28DE865596E(origin, angles, _id_447F40C814B97CDC) {
  self endon("task_ended");
  self endon("task_cleanup");
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, angles, _id_447F40C814B97CDC, undefined);
  item = _id_7E52B56769FA7774::spawnpickup("brloot_vehiclekeys_contract", _id_CB4FAD49263E20C4, 1, 1, undefined, 1);
  item._id_BBC200BC77C5DB2B = 1;
  item._id_B8EBE3F71A08AB40 = self;
  self._id_7BC06C0F8542A87C = item;

  while(item getscriptablepartstate("brloot_vehiclekeys_contract") != "visible")
    waitframe();

  _id_545F0DF81E095369(item.origin, 1);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_key", self.teams[0], 1, 2, undefined, "dx_br_seal_");
}

_id_D01CB68A0F2EA6F6() {
  endnode = self.endnode;
  _id_AA517194E54F048B = undefined;
  groundpos = undefined;
  _id_22C4300CE1D248E8 = endnode.origin + (0, 0, 128);
  _id_98C6610C2907BA2B = endnode.origin - (0, 0, 64);
  contents = scripts\engine\utility::ter_op(self._id_4F9872239D5FFA28 == "land", scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0), scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1));
  _id_AA517194E54F048B = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, undefined, contents, 0, 0, 0);

  if(isDefined(_id_AA517194E54F048B["hittype"] != "hittype_none") && isDefined(_id_AA517194E54F048B["position"]))
    groundpos = _id_AA517194E54F048B["position"];
  else
    groundpos = self.origin;

  endnode.groundpos = groundpos;

  if(level._id_4E85625F13C359AB._id_DAD5ABD3A17A252E > 1 && self._id_4F9872239D5FFA28 != "water")
    endnode _id_8B51245F6BBE5BBD();

  endnode.trigger = _id_894FDC630B584297(groundpos, endnode.angles, 96, 128);
  _id_545F0DF81E095369(groundpos);
}

_id_42A696D8B1CC5AAD(type, _id_7285AFD5055BDA71) {
  _id_E734085AB058D0B4 = _id_051CA04C003F5020(type, _id_7285AFD5055BDA71, level._id_4E85625F13C359AB._id_796EBB8AD5062D75, level._id_4E85625F13C359AB._id_C4AFB81E4C3625AB);

  if(_id_E734085AB058D0B4.size == 0)
    return undefined;

  _id_FDC6EE1B91EBB7BF = undefined;
  _id_220E66163356B51E = undefined;
  _id_24588C4E37E62333 = undefined;

  if(!level.br_circle_disabled) {
    _id_527A7B84D978E792 = _id_58F20490049AF6AC::_id_60951B84C58915AB(_id_7285AFD5055BDA71);
    _id_FDC6EE1B91EBB7BF = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_527A7B84D978E792);
  }

  _id_B88AA9CCEE86B6A3 = undefined;
  _id_06B50C4622758CC3 = level._id_4E85625F13C359AB._id_5250E11F76EAF5BB;

  foreach(node in _id_E734085AB058D0B4) {
    if(scripts\engine\utility::is_equal(node.script_type, "end")) {
      continue;
    }
    dist = distance2d(node.origin, _id_7285AFD5055BDA71);

    if(dist > _id_06B50C4622758CC3) {
      continue;
    }
    if(!level.br_circle_disabled) {
      _id_220E66163356B51E = _id_58F20490049AF6AC::_id_60951B84C58915AB(node.origin);
      _id_24588C4E37E62333 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_220E66163356B51E);

      if(_id_24588C4E37E62333 < _id_FDC6EE1B91EBB7BF)
        continue;
    }

    _id_5435995E95681B89 = 0;

    if(dist < level._id_4E85625F13C359AB._id_F618C857C91D9ADC) {
      if(dist < level._id_4E85625F13C359AB._id_623C71246715C68A)
        _id_5435995E95681B89 = level._id_4E85625F13C359AB._id_623C71246715C68A - dist;
    } else
      _id_5435995E95681B89 = dist - level._id_4E85625F13C359AB._id_F618C857C91D9ADC;

    if(_id_5435995E95681B89 < _id_06B50C4622758CC3) {
      _id_06B50C4622758CC3 = _id_5435995E95681B89;
      _id_B88AA9CCEE86B6A3 = node;
      _id_B88AA9CCEE86B6A3._id_E1384FF4A85E24E6 = _id_220E66163356B51E;
      _id_B88AA9CCEE86B6A3._id_9D42D8CFFEF859FB = _id_24588C4E37E62333;

      if(_id_5435995E95681B89 <= 0) {
        break;
      }
    }
  }

  return _id_B88AA9CCEE86B6A3;
}

_id_206405B8C9D63038(type, startnode) {
  _id_C09A118D31C10225 = _id_051CA04C003F5020(type, startnode.origin, level._id_4E85625F13C359AB._id_3988D42DA71AC896, level._id_4E85625F13C359AB._id_4D62BDA520DA444C);

  if(_id_C09A118D31C10225.size == 0)
    return undefined;

  _id_B88AA9CCEE86B6A3 = undefined;
  _id_06B50C4622758CC3 = level._id_4E85625F13C359AB._id_A8F585DEAC0AAA44;

  foreach(node in _id_C09A118D31C10225) {
    if(scripts\engine\utility::is_equal(node.script_type, "start")) {
      continue;
    }
    dist = distance2d(node.origin, startnode.origin);

    if(dist > _id_06B50C4622758CC3) {
      continue;
    }
    if(!level.br_circle_disabled) {
      _id_220E66163356B51E = _id_58F20490049AF6AC::_id_60951B84C58915AB(node.origin);
      _id_24588C4E37E62333 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_220E66163356B51E);

      if(_id_24588C4E37E62333 < startnode._id_9D42D8CFFEF859FB)
        continue;
    }

    _id_5435995E95681B89 = 0;

    if(dist < level._id_4E85625F13C359AB._id_F618C857C91D9ADC) {
      if(dist < level._id_4E85625F13C359AB._id_623C71246715C68A)
        _id_5435995E95681B89 = level._id_4E85625F13C359AB._id_623C71246715C68A - dist;
    } else
      _id_5435995E95681B89 = dist - level._id_4E85625F13C359AB._id_F618C857C91D9ADC;

    if(_id_5435995E95681B89 < _id_06B50C4622758CC3) {
      _id_06B50C4622758CC3 = _id_5435995E95681B89;
      _id_B88AA9CCEE86B6A3 = node;

      if(_id_5435995E95681B89 <= 0) {
        break;
      }
    }
  }

  return _id_B88AA9CCEE86B6A3;
}

_id_051CA04C003F5020(type, _id_B85DE1F57F90A2B1, _id_4F0FC1C36324AFFB, _id_CDC5DD6C28C9709D, _id_8A0186F902BAFAEF) {
  _id_2B88A7031924B832 = scripts\engine\utility::array_randomize(level._id_4E85625F13C359AB._id_2B88A7031924B832);

  if(scripts\engine\utility::is_equal(type, "water")) {
    _id_4F0FC1C36324AFFB = undefined;
    _id_CDC5DD6C28C9709D = undefined;
  }

  _id_44DC45A56FEEA28E = [];

  foreach(node in _id_2B88A7031924B832) {
    if(isDefined(_id_4F0FC1C36324AFFB) && isDefined(_id_CDC5DD6C28C9709D)) {
      distsq = distance2dsquared(node.origin, _id_B85DE1F57F90A2B1);

      if(distsq < _id_4F0FC1C36324AFFB || distsq > _id_CDC5DD6C28C9709D)
        continue;
    }

    if(isDefined(type) && !scripts\engine\utility::is_equal(node._id_9E40BFB0CE8B77F6, type)) {
      continue;
    }
    if(!istrue(_id_8A0186F902BAFAEF) && istrue(node.inuse)) {
      continue;
    }
    _id_44DC45A56FEEA28E = scripts\engine\utility::array_add(_id_44DC45A56FEEA28E, node);
  }

  return _id_44DC45A56FEEA28E;
}

_id_A60307ADCC0ADED1(agent, attacker) {
  _id_1C9CB43BCF3EB16D = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "subcategory");

  if(!scripts\engine\utility::is_equal("searchTask", _id_1C9CB43BCF3EB16D)) {
    return;
  }
  groupname = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "groupName");

  if(scripts\engine\utility::is_equal(self.startnode.groupname, groupname)) {
    if(level._id_4E85625F13C359AB._id_3B2141E078017F8C) {
      vehicle = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "keysForVehicle");

      if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() && !vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown() && istrue(vehicle.islocked)) {
        if(scripts\engine\utility::is_equal(attacker.team, self.teams[0])) {} else {}

        thread _id_DD9EC28DE865596E(agent.origin, agent.angles, agent);
      }
    }

    self.startnode.agents = scripts\engine\utility::array_remove(self.startnode.agents, agent);

    if(self.startnode.agents.size == 0)
      return;
  } else if(scripts\engine\utility::is_equal(self.endnode.groupname, groupname)) {
    self.endnode.agents = scripts\engine\utility::array_remove(self.endnode.agents, agent);

    if(self.endnode.agents.size == 0)
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_dz_cleared", self.teams[0], 1, 2, undefined, "dx_br_seal_");
  }
}

_id_8D032F436B816D9D(success) {
  self notify("task_ended");
  self.ended = 1;
  thread _id_8AF2A0D1C41847E3();
  wait 1.0;
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined));
}

_id_E05BDB2A6122FE4A() {
  if(!level._id_4E85625F13C359AB.enabled)
    return 0;

  return _id_0D97AC1473F7695B();
}

_id_89E3FC49199D2019() {
  self.category = "searchseizure";
  _id_FABF84450735DD93 = self.teams[0];
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_A60307ADCC0ADED1);
  _id_C28CF680F4D0D4DC(_id_FABF84450735DD93);
  _id_B76F3380ABD30D8E();
}

_id_30FF47CFFE7FCA99(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(_id_8A04AA0E0755E7E3, level._id_41F4BC9EE8C7C9C6.defaultfilter))
      thread _id_4448CCF5AAAFBCD2(_id_8A04AA0E0755E7E3);
    else {
      player _id_64ACB6CE534155B7::uiobjectivehide();
      objective_removeclientfrommask(self.objectiveiconid, player);
    }
  }
}

_id_E16CC4EFA3A21AAD(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(self.vehicle)) {
    return;
  }
  if(_id_EB06B338608EF354 == self.teams[0]) {
    objective_addclienttomask(self.objectiveiconid, player);
    player _id_64ACB6CE534155B7::uiobjectiveshow("searchseizure");
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }
}

_id_4448CCF5AAAFBCD2(team) {
  if(istrue(self.teams[0] == team))
    thread _id_8D032F436B816D9D(0);
}

_id_C28CF680F4D0D4DC(team) {
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("searchseizure", team);
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(level._id_4E85625F13C359AB.time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time, 0);
  thread _id_0BA49DB393BED5B9();
  _id_64ACB6CE534155B7::displayteamsplash(team, "br_searchseizure_quest_start_team", undefined, "splash_list_br_contract_searchseizure");
  _id_64ACB6CE534155B7::displaysquadmessagetoteam(team, self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex("searchseizure"));
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_accept", self.teams[0], 1, 2, undefined, "dx_br_seal_");
}

_id_B76F3380ABD30D8E() {
  vehicle = undefined;
  vehicles = vehicle_getarrayinradius(self.startnode.origin, 512);

  if(isDefined(vehicles) && vehicles.size > 0) {
    _id_8C33E181F5DDAE3C = [];
    vehiclename = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(self._id_4F9872239D5FFA28, "land"), "veh9_suv_1996", "veh9_patrol_boat");
    _id_22E70DBEB2DF9621 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(vehiclename)._id_29F1EA79ED2B40DD / 4;

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle._id_B8EBE3F71A08AB40)) {
        continue;
      }
      if(!isDefined(vehicle._id_CF9BA498AF4E41E9) || !isDefined(_id_22E70DBEB2DF9621)) {
        continue;
      }
      if(vehicle.vehiclename != vehiclename) {
        continue;
      }
      if(vehicle._id_CF9BA498AF4E41E9 < _id_22E70DBEB2DF9621) {
        continue;
      }
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

      if(occupants.size > 0) {
        continue;
      }
      if(vehicle.health / vehicle.maxhealth < 0.33) {
        continue;
      }
      if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
        continue;
      }
      _id_8C33E181F5DDAE3C = scripts\engine\utility::array_add(_id_8C33E181F5DDAE3C, vehicle);
    }

    vehicle = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_8C33E181F5DDAE3C);
  }

  if(!isDefined(vehicle))
    vehicle = _id_4944E32D48208083(self._id_4F9872239D5FFA28, self.startnode.origin, self.startnode.angles);

  vehicle._id_B8EBE3F71A08AB40 = self;
  vehicle thread _id_85DC015A530EBA24();
  vehicle scripts\common\utility::_id_3677F2BE30FDD581("car_alarm", "on");
  _id_37E73A6A4C1AFB18(self.teams[0]);
  _id_545F0DF81E095369(vehicle);

  if(level._id_4E85625F13C359AB._id_DAD5ABD3A17A252E % 2 == 1)
    self.startnode _id_8B51245F6BBE5BBD(level._id_4E85625F13C359AB._id_3B2141E078017F8C);

  if(level._id_4E85625F13C359AB._id_3B2141E078017F8C) {
    vehicle.islocked = 1;
    vehicle scripts\common\utility::_id_3677F2BE30FDD581("single", "vehicle_unusable");

    if(level._id_4E85625F13C359AB._id_B3EB64B6C448164B) {
      tag = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(self._id_4F9872239D5FFA28, "land"), "tag_door_front_left", "tag_steering_axis");
      tagorigin = vehicle gettagorigin(tag);
      radius = 96;
      fov = 120;
      hintstring = &"MP_BR_INGAME/UNLOCK_VEHICLE";
      useobject = scripts\mp\gameobjects::createhintobject(tagorigin, "HINT_BUTTON", undefined, hintstring, undefined, "duration_long", "show", radius, fov, radius, fov);
      useobject linkTo(vehicle, tag);
      useobject thread _id_AC069E47F0EF3B9E(self, vehicle);
      vehicle.useobject = useobject;
    }

    if(isDefined(self.startnode.agents) && self.startnode.agents.size > 0) {
      agent = self.startnode.agents[self.startnode.agents.size - 1];
      _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "keysForVehicle", vehicle);
      scripts\engine\utility::array_thread(self.startnode.agents, ::_id_C99B96671F305D48, 0.01, 5.0);
    }
  }

  self.vehicle = vehicle;
}

_id_8AF2A0D1C41847E3() {
  self notify("task_cleanup");
  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_A60307ADCC0ADED1);

  if(isDefined(self.vehicle.useobject))
    self.vehicle.useobject delete();

  if(level._id_4E85625F13C359AB._id_3B2141E078017F8C) {
    if(isDefined(self._id_7BC06C0F8542A87C))
      _id_7E52B56769FA7774::loothide(self._id_7BC06C0F8542A87C);

    if(self.vehicle.islocked)
      self.vehicle thread _id_CCA3D2BC5739C2A6(self, 1);
  }

  self.vehicle._id_B8EBE3F71A08AB40 = undefined;
  self.vehicle.damagecallback = undefined;
  self.vehicle = undefined;
  self.startnode.inuse = 0;

  if(isDefined(self.endnode)) {
    self.endnode.inuse = 0;

    if(isDefined(self.endnode.trigger)) {
      self.endnode.trigger.effect delete();
      self.endnode.trigger delete();
    }
  }

  if(isDefined(self._id_66549CA9BC89058C)) {
    foreach(fxent in self._id_66549CA9BC89058C)
    fxent delete();

    self._id_66549CA9BC89058C = undefined;
  }

  if(_id_64ACB6CE534155B7::checkforactiveobjicon()) {
    _id_64ACB6CE534155B7::deletequestobjicon();
    self.objectiveiconid = undefined;
  }

  if(isDefined(self._id_DB2893EE5A058AD4)) {
    self._id_DB2893EE5A058AD4 notify("change_movement_type", ::_id_F23647A77EE053E4);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_heli_depart", self.teams[0], 1, 2, undefined, "dx_br_seal_");
  } else if(isDefined(self._id_EE0FCA50E066499F)) {
    wait 9.0;
    self._id_EE0FCA50E066499F delete();
  }
}

_id_0D97AC1473F7695B(secondarymode) {
  _id_4F9872239D5FFA28 = undefined;
  startnode = _id_42A696D8B1CC5AAD(_id_4F9872239D5FFA28, self.tablet.origin);

  if(!isDefined(startnode))
    return 0;

  if(!isDefined(startnode._id_9E40BFB0CE8B77F6))
    startnode._id_9E40BFB0CE8B77F6 = "land";

  _id_4F9872239D5FFA28 = startnode._id_9E40BFB0CE8B77F6;
  endnode = _id_206405B8C9D63038(_id_4F9872239D5FFA28, startnode);

  if(!isDefined(endnode))
    return 0;

  startnode.inuse = 1;
  endnode.inuse = 1;
  self.startnode = startnode;
  self.endnode = endnode;
  self._id_4F9872239D5FFA28 = _id_4F9872239D5FFA28;
  return 1;
}

_id_0BA49DB393BED5B9() {
  level endon("game_ended");
  self endon("task_ended");
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(level._id_4E85625F13C359AB.time);
  _id_258E7B3DFB914A71 = time * 0.7;
  _id_00697C47591112DF = time - _id_258E7B3DFB914A71;
  scripts\engine\utility::wait_time_in_ms(_id_258E7B3DFB914A71 * 1000);

  if(istrue(self._id_096F861DAEEB48A6))
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_timer", self.teams[0], 1, 2, undefined, "dx_br_seal_");

  scripts\engine\utility::wait_time_in_ms(_id_00697C47591112DF * 1000);
  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_searchseizure_quest_timer_expired", params, "splash_list_br_contract_searchseizure");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_fail_time", self.teams[0], 1, 2, undefined, "dx_br_seal_");
  thread _id_8D032F436B816D9D(0);
}

_id_0E6858A6A14325D0(player, vehicle) {
  self endon("task_ended");
  vehicle childthread _id_4D6D52197650FB91();
  _id_D01CB68A0F2EA6F6();
  self._id_096F861DAEEB48A6 = 1;

  if(self._id_4F9872239D5FFA28 == "water" && level._id_4E85625F13C359AB._id_C9A4667D43C3D2B7) {
    _id_DB2893EE5A058AD4 = helicopter_start(vehicle.origin, vehicle, player);
    self._id_DB2893EE5A058AD4 = _id_DB2893EE5A058AD4;
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_heli_arrive", self.teams[0], 1, 5, undefined, "dx_br_seal_");
  } else {
    if(self._id_4F9872239D5FFA28 == "land")
      self waittill("task_within_distance");

    _id_9CBBC426BE64A21A = _id_B66446C0C80398C2();
    self._id_EE0FCA50E066499F = _id_9CBBC426BE64A21A;
    thread _id_BE4861D33DA1689F(vehicle, _id_9CBBC426BE64A21A);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_searchseizure_airstrike", self.teams[0], 1, 5, undefined, "dx_br_seal_");
  }
}

_id_29ABF5B8A864C5DD(target) {
  startpos = target.origin + (0, 0, 32);
  endpos = target.origin + (0, 0, 2048);
  _id_5B36D1353E9A2B32 = scripts\engine\trace::ray_trace_passed(startpos, endpos, target);
  return !_id_5B36D1353E9A2B32;
}

_id_BE4861D33DA1689F(target, owner) {
  level endon("game_ended");
  self endon("task_ended");
  self._id_66549CA9BC89058C = [];
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", owner);
  _id_E5F2AEFA61CC09DC = level._id_4E85625F13C359AB._id_4156AA8334394ED5;

  if(self._id_4F9872239D5FFA28 == "water")
    _id_E5F2AEFA61CC09DC = _id_E5F2AEFA61CC09DC * 2;

  for(;;) {
    if(_id_E5F2AEFA61CC09DC == 0) {
      foreach(_id_66549CA9BC89058C in self._id_66549CA9BC89058C)
      _id_66549CA9BC89058C delete();

      self._id_66549CA9BC89058C = undefined;
      break;
    }

    if(_id_29ABF5B8A864C5DD(target)) {
      wait(randomfloatrange(3.5, 5.0) / 2);
      continue;
    }

    _id_E8DB9359BD731029 = anglesToForward(target.angles);
    _id_3C3E840099FF521E = anglestoright(target.angles);
    _id_9E57080EF7594916 = randomfloatrange(4.0, 4.5);
    _id_3E1F9C45395E389F = _id_3100067B96889B40(target);
    _id_9913FD1FFEA99C33 = vectordot(_id_E8DB9359BD731029, _id_D6C95CADDE7FCC79(target));
    sign = scripts\engine\utility::ter_op(_id_9913FD1FFEA99C33 >= 0, 1, -1);
    _id_49F486C39F38B9D9 = target.origin + _id_E8DB9359BD731029 * (sign * _id_3E1F9C45395E389F * _id_9E57080EF7594916);
    _id_A0EDD3F59D938FB1 = 256;
    _id_FA378E997A33A137 = owner scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(_id_49F486C39F38B9D9, _id_A0EDD3F59D938FB1, _id_E8DB9359BD731029, _id_E8DB9359BD731029, _id_3C3E840099FF521E);
    _id_41D8FABDCB0957BB = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
    _id_C148DFE3DD8379C8 = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(_id_FA378E997A33A137.goalpos, _id_A0EDD3F59D938FB1 * 3, undefined, _id_41D8FABDCB0957BB);

    if(isDefined(_id_C148DFE3DD8379C8) && _id_C148DFE3DD8379C8.size > 0) {
      wait(randomfloatrange(3.5, 5.0));
      continue;
    }

    fxent = undefined;

    if(level._id_4E85625F13C359AB._id_74DE30492B65DEDB)
      fxent = spawnfx(level._effect["vfx_dom_flare"], _id_FA378E997A33A137.goalpos);
    else {
      foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
        if(isalive(player))
          fxent = spawnfxforclient(level._effect["vfx_dom_flare"], _id_FA378E997A33A137.goalpos, player);
      }
    }

    triggerfx(fxent);
    self._id_66549CA9BC89058C = scripts\engine\utility::array_add(self._id_66549CA9BC89058C, fxent);
    owner scripts\cp_mp\killstreaks\toma_strike::tomastrike_firestrike(1, _id_FA378E997A33A137, streakinfo);
    _id_E5F2AEFA61CC09DC--;

    if(self._id_66549CA9BC89058C.size == 2) {
      self._id_66549CA9BC89058C[0] delete();
      self._id_66549CA9BC89058C = scripts\engine\utility::array_remove_index(self._id_66549CA9BC89058C, 0);
    }

    wait(randomfloatrange(3.5, 5.0));
  }
}

_id_B66446C0C80398C2() {
  _id_D012A269F2BEC545 = scripts\engine\utility::spawn_tag_origin();
  _id_D012A269F2BEC545.pers = [];
  _id_D012A269F2BEC545.pers["deaths"] = 0;
  _id_D012A269F2BEC545.pers["nextKillstreakID"] = 0;
  _id_D012A269F2BEC545.team = "team_hundred_ninety_five";
  _id_D012A269F2BEC545._id_C0AA24316813868F = 1;
  return _id_D012A269F2BEC545;
}

_id_3100067B96889B40(target) {
  velocity = _id_D6C95CADDE7FCC79(target);
  return length(velocity);
}

_id_D6C95CADDE7FCC79(target) {
  velocity = 0;

  if(target scripts\cp_mp\vehicles\vehicle::isvehicle())
    velocity = target vehicle_getvelocity();
  else if(isPlayer(target)) {
    if(target scripts\cp_mp\utility\player_utility::isinvehicle()) {
      target = scripts\cp_mp\utility\player_utility::getvehicle();
      velocity = target vehicle_getvelocity();
    } else
      velocity = target getvelocity();
  } else {}

  return velocity;
}