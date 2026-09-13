/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootchopper.gsc
***************************************************/

init() {
  level.averagealliesz = 0;
  level.loot_choppers = [];

  if(scripts\mp\utility\game::getsubgametype() != "plunder")
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", ::lootchopper_oncrateuse);

  level.quadgridcenterpoints = [];
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, 41779.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, 41779.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, -17203.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, -17203.2, 0);
  level thread registerleveldataforvehicle();
}

registerleveldataforvehicle() {
  while(!isDefined(level.vehicle))
    waitframe();

  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("loot_chopper", 1);
  _id_E2818AD39A3341B4.canfly = 1;
}

lootchopper_initspawninfo(_id_ED09715E306A1455) {
  _id_A43491919A0D6A88 = lootchopper_getspawnlocations(_id_ED09715E306A1455);
  level.loot_chopper_spawns = [];
  level.loot_chopper_spawns["quad_1"] = [];
  level.loot_chopper_spawns["quad_2"] = [];
  level.loot_chopper_spawns["quad_3"] = [];
  level.loot_chopper_spawns["quad_4"] = [];

  if(!isDefined(_id_A43491919A0D6A88)) {
    return;
  }
  foreach(_id_22CEDF10372284DA in _id_A43491919A0D6A88) {
    _id_42CA41C7DADAE0C0 = undefined;
    closestquad = undefined;
    _id_64602CFEEF6C46DA = undefined;

    if(_id_ED09715E306A1455.isvalid) {
      foreach(_id_F38B865DD10333FE, _id_9D308880669C09EA in _id_ED09715E306A1455.quadpoints) {
        _id_8D6061447AC0BF39 = distance2dsquared(_id_22CEDF10372284DA.origin, _id_9D308880669C09EA);

        if(!isDefined(_id_42CA41C7DADAE0C0) || _id_8D6061447AC0BF39 < _id_42CA41C7DADAE0C0) {
          _id_42CA41C7DADAE0C0 = _id_8D6061447AC0BF39;
          closestquad = _id_9D308880669C09EA;
          _id_64602CFEEF6C46DA = "quad_" + (_id_F38B865DD10333FE + 1);
        }
      }
    } else {
      foreach(_id_F38B865DD10333FE, _id_9D308880669C09EA in level.quadgridcenterpoints) {
        _id_8D6061447AC0BF39 = distance2dsquared(_id_22CEDF10372284DA.origin, _id_9D308880669C09EA);

        if(!isDefined(_id_42CA41C7DADAE0C0) || _id_8D6061447AC0BF39 < _id_42CA41C7DADAE0C0) {
          _id_42CA41C7DADAE0C0 = _id_8D6061447AC0BF39;
          closestquad = _id_9D308880669C09EA;
          _id_64602CFEEF6C46DA = "quad_" + (_id_F38B865DD10333FE + 1);
        }
      }
    }

    _id_22CEDF10372284DA.origin = _id_22CEDF10372284DA.origin * (1, 1, 0);
    _id_22CEDF10372284DA.origin = _id_1E4A61DB11011446::getoffsetspawnoriginmultitrace(_id_22CEDF10372284DA.origin, (0, 0, 10000));
    level.loot_chopper_spawns[_id_64602CFEEF6C46DA][level.loot_chopper_spawns[_id_64602CFEEF6C46DA].size] = _id_22CEDF10372284DA;
  }
}

lootchopper_getspawnlocations(_id_ED09715E306A1455) {
  _id_1B5B62B6222F38C0 = [];

  foreach(location in level.br_prematchspawnlocations) {
    if(_id_ED09715E306A1455.isvalid) {
      if(distance2dsquared(location.origin, _id_ED09715E306A1455.center) > _id_ED09715E306A1455.radius * _id_ED09715E306A1455.radius)
        continue;
    }

    _id_565CDE9E77EA668E = spawnStruct();
    _id_565CDE9E77EA668E.origin = location.origin;
    _id_1B5B62B6222F38C0[_id_1B5B62B6222F38C0.size] = _id_565CDE9E77EA668E;
  }

  return _id_1B5B62B6222F38C0;
}

lootchopper_initcircleinfo(circlecenter, circleradius) {
  _id_ED09715E306A1455 = spawnStruct();
  _id_ED09715E306A1455.isvalid = isDefined(circlecenter) && isDefined(circleradius);

  if(_id_ED09715E306A1455.isvalid) {
    _id_ED09715E306A1455.center = circlecenter;
    _id_ED09715E306A1455.radius = circleradius;
    _id_28752BF2EA017628 = 45.0;
    _id_9563AB8C74BF32FB = cos(_id_28752BF2EA017628);
    _id_50972E48B8D175A4 = sin(_id_28752BF2EA017628);
    _id_ED09715E306A1455.quadpoints[0] = circlecenter + (-1.0 * _id_9563AB8C74BF32FB, _id_50972E48B8D175A4, 0) * circleradius * 0.5;
    _id_ED09715E306A1455.quadpoints[1] = circlecenter + (_id_9563AB8C74BF32FB, _id_50972E48B8D175A4, 0) * circleradius * 0.5;
    _id_ED09715E306A1455.quadpoints[2] = circlecenter + (_id_9563AB8C74BF32FB, -1.0 * _id_50972E48B8D175A4, 0) * circleradius * 0.5;
    _id_ED09715E306A1455.quadpoints[3] = circlecenter + (-1.0 * _id_9563AB8C74BF32FB, -1.0 * _id_50972E48B8D175A4, 0) * circleradius * 0.5;
  }

  return _id_ED09715E306A1455;
}

lootchopper_managespawns() {
  level endon("game_ended");

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  circlecenter = undefined;
  circleradius = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    circlecenter = _id_2695A20D4011076D::getsafecircleorigin();
    circleradius = _id_2695A20D4011076D::getsafecircleradius();
  }

  _id_ED09715E306A1455 = lootchopper_initcircleinfo(circlecenter, circleradius);
  lootchopper_initspawninfo(_id_ED09715E306A1455);
  level waittill("br_prematchEnded");
  _id_E1CE21E5B4D1163F = getdvarint("dvar_D043EE66392F7B83", 6);
  _id_477413D8C0675495 = getdvarint("dvar_38568DAA586B1FE3", 6000);
  _id_F013E3FC1F370CA7 = getdvarint("dvar_31C380C6BA1EAB38", 360);
  _id_3FB775A12C864C31 = getdvarint("dvar_31E696C6BA452352", 480);

  if(level.mapname == "mp_br_mechanics")
    _id_477413D8C0675495 = 1000;

  for(;;) {
    _id_992EDC40264E2F58 = getdvarint("dvar_1853D73EE1C86FD4", 0);

    if(!_id_992EDC40264E2F58) {
      waitframe();
      continue;
    }

    _id_B1D5325407F562DD = randomintrange(_id_F013E3FC1F370CA7, _id_3FB775A12C864C31);

    if(istrue(level.usemilestonephases))
      scripts\mp\flags::gameflagwait("activate_cash_helis");
    else
      wait(_id_B1D5325407F562DD);

    if(level.loot_choppers.size < _id_E1CE21E5B4D1163F) {
      _id_6EEBC4632B89C8C8 = _id_E1CE21E5B4D1163F - level.loot_choppers.size;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6EEBC4632B89C8C8; _id_AC0E594AC96AA3A8++) {
        _id_32B962C704FDE3E7 = _id_AC0E594AC96AA3A8 + 1;

        if(_id_32B962C704FDE3E7 > 4)
          _id_32B962C704FDE3E7 = 1;

        patrolzone = lootchopper_findunoccupiedpatrolzone(level.loot_chopper_spawns["quad_" + _id_32B962C704FDE3E7], _id_477413D8C0675495);

        if(!isDefined(patrolzone))
          wait 1;

        if(_id_AC0E594AC96AA3A8 == 0)
          scripts\mp\hud_util::showsplashtoall("br_lootchopper_incoming");

        lootchopper_spawn(patrolzone);

        if(istrue(level.usemilestonephases))
          wait(randomintrange(1, 2));
      }

      if(istrue(level.usemilestonephases)) {
        return;
      }
      continue;
    }

    while(level.loot_choppers.size >= _id_E1CE21E5B4D1163F)
      waitframe();
  }
}

lootchopper_findunoccupiedpatrolzone(_id_EB629964517B0C20, _id_6D423F3F70906691) {
  patrolzone = undefined;

  if(_id_EB629964517B0C20.size > 0) {
    _id_93E8EB0CC5BC4CB9 = [];

    foreach(_id_6C00C2E1ADF59F74 in _id_EB629964517B0C20) {
      if(istrue(_id_6C00C2E1ADF59F74.chopperoccupied)) {
        continue;
      }
      if(lootchopper_isnearbyoccupiedspawns(_id_6C00C2E1ADF59F74, _id_6D423F3F70906691)) {
        continue;
      }
      _id_93E8EB0CC5BC4CB9[_id_93E8EB0CC5BC4CB9.size] = _id_6C00C2E1ADF59F74;
    }

    if(_id_93E8EB0CC5BC4CB9.size > 0)
      patrolzone = _id_93E8EB0CC5BC4CB9[randomint(_id_93E8EB0CC5BC4CB9.size)];

    if(isDefined(patrolzone))
      patrolzone.chopperoccupied = 1;
  }

  return patrolzone;
}

lootchopper_isnearbyoccupiedspawns(_id_6C00C2E1ADF59F74, _id_6D423F3F70906691) {
  _id_7128B7AEE8DE7665 = 0;
  _id_1094F1264DD82C0C = level.loot_chopper_spawns;
  _id_4F0FC1C36324AFFB = _id_6D423F3F70906691 * _id_6D423F3F70906691;

  foreach(_id_E7B2EC6D5CFCAD0D in _id_1094F1264DD82C0C) {
    foreach(_id_C629CFB5AEE5BE94 in _id_E7B2EC6D5CFCAD0D) {
      if(istrue(_id_C629CFB5AEE5BE94.chopperoccupied)) {
        if(distance2dsquared(_id_6C00C2E1ADF59F74.origin, _id_C629CFB5AEE5BE94.origin) < _id_4F0FC1C36324AFFB) {
          _id_7128B7AEE8DE7665 = 1;
          break;
        }
      }
    }

    if(istrue(_id_7128B7AEE8DE7665)) {
      break;
    }
  }

  return _id_7128B7AEE8DE7665;
}

lootchopper_getzonebyindex(index) {
  _id_6622760DD5560C8A = undefined;
  zonecount = 0;

  foreach(_id_5933C7F534C269C0, zone in level.loot_chopper_spawns) {
    if(zonecount == index) {
      _id_6622760DD5560C8A = zone;
      break;
    }

    zonecount++;
  }

  return _id_6622760DD5560C8A;
}

lootchopper_spawn(patrolzone, _id_EE7155023F428E5B) {
  patrollocation = undefined;
  patrolradius = getdvarint("dvar_AD78DA1D72E62DD3", 4000);

  if(isDefined(patrolzone))
    patrollocation = patrolzone.origin;
  else {
    _id_208C21E43B00C7AE = [];

    foreach(player in level.players) {
      if(scripts\mp\utility\player::isreallyalive(player))
        _id_208C21E43B00C7AE[_id_208C21E43B00C7AE.size] = player;
    }

    if(_id_208C21E43B00C7AE.size > 0) {
      _id_610520BE555433B2 = randomint(_id_208C21E43B00C7AE.size);
      patrollocation = _id_208C21E43B00C7AE[_id_610520BE555433B2].origin;
    }

    if(isDefined(patrollocation))
      patrollocation = _id_1E4A61DB11011446::getoffsetspawnoriginmultitrace(patrollocation, (0, 0, 10000));
  }

  if(!isDefined(patrollocation)) {
    return;
  }
  _id_A5639D6F3F95033A = scripts\cp_mp\killstreaks\chopper_support::getpathstart(patrollocation);
  startingangles = vectortoangles(patrollocation - _id_A5639D6F3F95033A);
  _id_6EA44339B53B31BC = scripts\engine\utility::ter_op(isDefined(_id_EE7155023F428E5B), _id_EE7155023F428E5B, "veh_chopper_support_dmz_mp");
  _id_A5C6D4F05FA73949 = "veh8_mil_air_palfa_east";

  if(istrue(level._id_A83A4E71446BFEF7))
    _id_A5C6D4F05FA73949 = "veh9_mil_air_heli_hind";

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    chopper = undefined;

    if(scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle())
      chopper = spawnVehicle(_id_A5C6D4F05FA73949, "dmz_ai_chopper", "veh9_mil_air_heli_hind_physics_dmz", _id_A5639D6F3F95033A, startingangles);

    if(isDefined(chopper)) {
      level.vehiclecount++;
      chopper._id_85BF734167B68CA3 = 1;
      chopper _meth_247AD6A91F6A4FFE(1);
    }
  } else
    chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], _id_A5639D6F3F95033A, startingangles, _id_6EA44339B53B31BC, _id_A5C6D4F05FA73949);

  if(!isDefined(chopper)) {
    return;
  }
  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = getdvarint("dvar_6AB65BA1A8931841", 9999);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    chopper.team = "team_hundred_ninety";
  else
    chopper.team = "neutral";

  chopper.angles = startingangles;
  chopper.flaresreservecount = getdvarint("dvar_5DB4B9205B63BBD3", 0);
  chopper.pathstart = _id_A5639D6F3F95033A;
  chopper.pathgoal = patrollocation;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.heightoffset = (0, 0, getdvarint("dvar_880C7F3811901EA1", 1500));
  chopper.patrolzone = patrolzone;
  chopper.patrollocation = patrollocation;
  chopper.patrolradius = patrolradius;
  chopper.stage3accradius = 35;
  chopper.crashoffset = chopper.heightoffset[2] - 250;
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setvehicleteam(chopper.team);
  chopper.health = getdvarint("dvar_117DB97FCBBFFBB8", 4500);
  chopper.maxhealth = getdvarint("dvar_117DB97FCBBFFBB8", 4500);
  chopper.currenthealth = getdvarint("dvar_117DB97FCBBFFBB8", 4500);
  chopper scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", chopper.team);
  chopper lootchopper_setupdamagefunctionality();
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  turretmodel = "veh9_mil_air_heli_ahotel64_turret";
  _id_4CADAFE0DB5700B3 = "tag_turret_front";

  if(istrue(level._id_A83A4E71446BFEF7)) {
    turretmodel = "veh9_mil_air_heli_hind_turret";
    _id_4CADAFE0DB5700B3 = "tag_turret";
  }

  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin(_id_4CADAFE0DB5700B3), "chopper_support_turret_br");
  chopper.frontturret setModel(turretmodel);
  chopper.frontturret.team = chopper.team;
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = undefined;
  chopper.frontturret.vehicleparent = "loot_chopper";
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam(chopper.team);
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.groundtargetent = spawn("script_model", chopper.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();

  if(!istrue(level._id_A83A4E71446BFEF7)) {
    chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_br");
    chopper.rearturret setModel("veh9_mil_air_heli_ahotel64_turret");
    chopper.rearturret.team = chopper.team;
    chopper.rearturret.angles = chopper.angles;
    chopper.rearturret.turreton = 1;
    chopper.rearturret.name = "rear_turret";
    chopper.rearturret.attackingtarget = undefined;
    chopper.rearturret.vehicleparent = "loot_chopper";
    chopper.rearturret linkTo(chopper);
    chopper.rearturret setturretteam(chopper.team);
    chopper.rearturret setturretmodechangewait(0);
    chopper.rearturret setmode("manual");
    chopper.rearturret setdefaultdroppitch(45);
    chopper.rearturret.groundtargetent = spawn("script_model", chopper.origin);
    chopper.rearturret.groundtargetent setModel("tag_origin");
    chopper.rearturret.groundtargetent dontinterpolate();
  }

  level.loot_choppers[level.loot_choppers.size] = chopper;
  chopper.patrolfunc = ::lootchopper_patrolzone;
  chopper.lootfunc = ::lootchopper_droploot;
  chopper.cleanupfunc = ::lootchopper_cleanup;
  chopper lootchopper_createobjective();
  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    chopper thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);

  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(chopper.pathgoal, 1);
  return chopper;
}

lootchopper_setupdamagefunctionality() {
  self.vehiclename = "loot_chopper";
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  lootchopper_modifyweapondamage("iw9_la_gromeo_mp", 4.0, 20);
  lootchopper_modifyweapondamage("iw9_la_kgolf_mp", 4.0, 20);
  lootchopper_modifyweapondamage("iw9_la_rpapa7_mp", 4.0, 20);
  lootchopper_modifyweapondamage("iw9_la_juliet_mp", 5.0, 20);
  lootchopper_modifyweapondamage("iw9_la_gromeo_mp", 4.0, 20);
  lootchopper_modifyweapondamage("iw9_la_mike32_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("c4_mp", 4.0, 20);
  lootchopper_modifyweapondamage("semtex_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("frag_grenade_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("pop_rocket_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("molotov_mp", 1.81818, 20);
  lootchopper_modifyweapondamage("at_mine_ap_mp", 1.81818, 20);
  lootchopper_modifyweapondamage("at_mine_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("thermite_mp", 1, 36);
  lootchopper_modifyweapondamage("thermite_av_mp", 1, 36);
  lootchopper_modifyweapondamage("thermite_bolt_mp", 1, 30);
  lootchopper_modifyweapondamage("thermite_xmike109_mp", 1, 52);
  lootchopper_modifyweapondamage("emp_grenade_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("claymore_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("semtex_bolt_mp", 2.0, 20);
  lootchopper_modifyweapondamage("semtex_xmike109_mp", 1.42857, 20);
  lootchopper_modifyweapondamage("chopper_gunner_proj_mp", 5.0, 20);
  lootchopper_modifyweapondamage("toma_proj_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("cruise_proj_mp", 6.66667, 20);
  lootchopper_modifyweapondamage("artillery_mp", 6.66667, 20);
  lootchopper_modifyweapondamage("nuke_mp", 10.0, 20);
  lootchopper_modifyweapondamage("gunship_hellfire_mp", 10.0, 20);
  lootchopper_modifyweapondamage("gunship_105mm_mp", 10.0, 20);
  lootchopper_modifyweapondamage("gunship_40mm_mp", 5.0, 20);
  lootchopper_modifyweapondamage("gunship_25mm_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("hover_jet_proj_mp", 5.0, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, ::lootchopper_premodifydamage);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, ::lootchopper_postmodifydamage);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, ::lootchopper_handledeathdamage);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 2000, ::_id_C300BCCA405C826D);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 1000, ::_id_F70041F0A83148CE);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 500, ::_id_3CD972F38FF76D2C);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

lootchopper_modifyweapondamage(weaponname, _id_DC9CC1D7198502C2, _id_E88CBE78A1E25E8A) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(weaponname, _id_DC9CC1D7198502C2, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, _id_E88CBE78A1E25E8A, weaponname);
}

lootchopper_premodifydamage(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

lootchopper_postmodifydamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::_id_400022DABDB64055(data);

  if(!isDefined(self.attackers))
    self.attackers = [];

  _id_996B260954D28D79 = lootchopper_getattackerdata(data.attacker);

  if(!isDefined(_id_996B260954D28D79)) {
    _id_BBCA3E84D8043876 = spawnStruct();
    _id_BBCA3E84D8043876.player = data.attacker;
    _id_BBCA3E84D8043876.objweapon = data.objweapon;
    _id_BBCA3E84D8043876.totaldamage = data.damage;
    self.attackers[self.attackers.size] = _id_BBCA3E84D8043876;
  } else {
    _id_996B260954D28D79.totaldamage = _id_996B260954D28D79.totaldamage + data.damage;
    _id_996B260954D28D79.objweapon = data.objweapon;
  }

  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

lootchopper_handledeathdamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  _id_F0FA3B7B27926553 = undefined;
  points = undefined;
  _id_6181DE250AFA5BB6 = data.attacker;

  foreach(_id_A64D70120038E5FA in self.attackers) {
    if(isDefined(_id_A64D70120038E5FA.player)) {
      if(isDefined(_id_6181DE250AFA5BB6) && _id_6181DE250AFA5BB6 == _id_A64D70120038E5FA.player)
        _id_F0FA3B7B27926553 = "stat_916AF74A28436E1C";
      else
        _id_F0FA3B7B27926553 = "stat_59B8198B31BAF7EA";

      points = scripts\mp\rank::getscoreinfovalue(_id_F0FA3B7B27926553);
      _id_A64D70120038E5FA.player thread scripts\mp\rank::giverankxp(_id_F0FA3B7B27926553, points, _id_A64D70120038E5FA.objweapon);
      _id_A64D70120038E5FA.player thread scripts\mp\events::killeventtextpopup(_id_F0FA3B7B27926553, 0);
      thread scripts\cp_mp\challenges::vehiclekilled(self, _id_A64D70120038E5FA.player, 0, _id_A64D70120038E5FA.objweapon);
    }
  }

  self notify("death");
  return 1;
}

lootchopper_patrolzone(_id_0CE938A4EA8A54D5) {
  if(self.currentaction != "patrol")
    self.currentaction = "patrol";
  else if(self.currentaction == "patrol" && !istrue(_id_0CE938A4EA8A54D5)) {
    return;
  }
  self clearlookatent();
  self setneargoalnotifydist(300);
  _id_65AF68838583C396 = 0;
  _id_B9A46106A6A99EE8 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(_id_65AF68838583C396))
        _id_65AF68838583C396 = 1;

      waitframe();
      continue;
    }

    if(!istrue(_id_0CE938A4EA8A54D5) && istrue(_id_65AF68838583C396))
      _id_65AF68838583C396 = 0;

    _id_6E281DBD69FC980E = self.patrollocation + anglesToForward((0, _id_B9A46106A6A99EE8, 0)) * int(self.patrolradius / 1.2);
    _id_B9A46106A6A99EE8 = _id_B9A46106A6A99EE8 + 90;
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(_id_6E281DBD69FC980E, 1);

    if(_id_B9A46106A6A99EE8 >= 360)
      _id_B9A46106A6A99EE8 = 0;

    wait 0.5;
  }
}

lootchopper_droploot() {
  _id_76A22C18960F72AF = lootchopper_finddroplocation(self.origin + (0, 0, 500));

  if(isDefined(_id_76A22C18960F72AF)) {
    _id_0E38F5EC33ED2CB0 = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrate(self.origin, _id_76A22C18960F72AF);
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(_id_0E38F5EC33ED2CB0);
    _id_EF5D5141FDB51174.usetimeoverride = 10;
  }
}

lootchopper_finddroplocation(_id_22C4300CE1D248E8) {
  _id_76A22C18960F72AF = undefined;
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 - (0, 0, 20000);
  ignorelist = [self, self.frontturret, self.rearturret];
  ignorelist = scripts\engine\utility::array_removeundefined(ignorelist);
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none")
    _id_76A22C18960F72AF = trace["position"];

  return _id_76A22C18960F72AF;
}

lootchopper_oncrateuse(player) {
  _id_C8A8CADCFBFF950A = getdvarint("dvar_C027DB5B75DED4AA", 100000);

  if(istrue(level.bmoovertime)) {
    _id_E168AEAF2D8A83F4 = getdvarint("dvar_7DAF22BB16ED19FE", 50000);
    _id_C8A8CADCFBFF950A = _id_C8A8CADCFBFF950A + _id_E168AEAF2D8A83F4;
  }

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  dropstruct._id_DFBA5A2C3C6F0A07 = 10;
  self.itemsdropped = 0;
  _id_E05413A53B5D9167 = _id_6AFF3948CF4CCA03::dropplunderbyrarity(_id_C8A8CADCFBFF950A / 100, dropstruct);

  foreach(ent in _id_E05413A53B5D9167)
  ent.lootsource = "loot_chopper";

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_70E5DE61CFAA916B");
}

lootchopper_cleanup() {
  if(isDefined(self.dropzone))
    self.dropzone delete();

  if(isDefined(self.patrolzone))
    self.patrolzone.chopperoccupied = undefined;

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  level.loot_choppers = scripts\engine\utility::array_remove(level.loot_choppers, self);
}

lootchopper_createobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
    objective_sethideelevation(objectiveiconid, 1);
  }

  self.objectiveiconid = objectiveiconid;
}

lootchopper_getattackerdata(_id_76B6B96D4589E81D) {
  attackerdata = undefined;

  if(!isDefined(_id_76B6B96D4589E81D))
    return attackerdata;

  foreach(_id_6B478DCF436AE4C0 in self.attackers) {
    if(isDefined(_id_6B478DCF436AE4C0.player) && _id_76B6B96D4589E81D == _id_6B478DCF436AE4C0.player) {
      attackerdata = _id_6B478DCF436AE4C0;
      break;
    }
  }

  return attackerdata;
}

_id_C300BCCA405C826D() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_F70041F0A83148CE() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_3CD972F38FF76D2C() {
  self setscriptablepartstate("body_damage_heavy", "on");
}