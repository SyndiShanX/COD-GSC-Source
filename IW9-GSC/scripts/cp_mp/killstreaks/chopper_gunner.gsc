/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_gunner.gsc
********************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "init")]]();

  level _id_B380D510FA08CDEC();
  level _id_0402D391C1C0E8CA();
  level _id_E4D2385D5EEE2C51();
  level _id_5D9A912BAB9622DA();
  level _id_5DE17C2BABE4B71B();
  level _id_76BACDFA4C4A7BDC();
}

_id_B380D510FA08CDEC() {
  level.choppergunners = [];
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("heli_pilot_mesh");

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh hide();

  if(isDefined(level.mapname) && issubstr(level.mapname, "mp_embassy"))
    level.heli_structs_entrances = scripts\engine\utility::array_remove_index(level.heli_structs_entrances, 2);

  level.incomingallchoppergunners = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level.incomingchoppergunners[_id_FABF84450735DD93] = 0;

  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("chopper_gunner", "on", 6);
}

_id_0402D391C1C0E8CA() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("chopperGunnerUse", ["killstreaks", "allow_movement", "fire", "weapon_switch", "melee", "usability", "shellshock", "allow_jump", "offhand_weapons"]);
}

_id_E4D2385D5EEE2C51() {
  level choppergunner_pilotanims();
  level choppergunner_vehicleanims();
}

_id_5D9A912BAB9622DA() {
  game["dialog"]["chopper_gunner_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["chopper_gunner_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["chopper_gunner_engage"] = "killstreak_remote_operator_engage";
  game["dialog"]["chopper_gunner_random_radio"] = "killstreak_remote_operator_radio_chatter";
  game["dialog"]["chopper_gunner_attack_single"] = "killstreak_remote_operator_target_attack_single";
  game["dialog"]["chopper_gunner_attack_multi"] = "killstreak_remote_operator_target_attack_multi";
  game["dialog"]["chopper_gunner_flares"] = "killstreak_remote_operator_flare_release";
  game["dialog"]["chopper_gunner_light_damage"] = "killstreak_remote_operator_light_damage";
  game["dialog"]["chopper_gunner_med_damage"] = "killstreak_remote_operator_med_damage";
  game["dialog"]["chopper_gunner_heavy_damage"] = "killstreak_remote_operator_heavy_damage";
  game["dialog"]["chopper_gunner_killconf_single"] = "killstreak_remote_operator_confirm_kill_single";
  game["dialog"]["chopper_gunner_killconf_multi"] = "killstreak_remote_operator_confirm_kill_multi";
  game["dialog"]["chopper_gunner_killconf_missile"] = "killstreak_remote_operator_confirm_kill_missile";
  game["dialog"]["chopper_gunner_lockedon"] = "killstreak_remote_operator_missile_lock_warning";
  game["dialog"]["chopper_gunner_reattack"] = "killstreak_remote_operator_reattack";
  game["dialog"]["chopper_gunner_crash"] = "killstreak_remote_operator_crash";
}

_id_5DE17C2BABE4B71B() {
  level._effect["chopper_gunner_friendly_strobe"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_friendly_strobe.vfx");
}

_id_76BACDFA4C4A7BDC() {
  _id_F55722829763ABFF = "chopper_color_mp";

  if(scripts\common\utility::iscp())
    _id_F55722829763ABFF = "chopper_color_cp";

  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57(_id_F55722829763ABFF);
}

#using_animtree("script_model");

choppergunner_pilotanims() {
  level.scr_animtree["ks_chopper_gunner_pilot"] = #animtree;
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"] = % iw9_mp_ks_ahotel64_intro_player;
  level.scr_animname["ks_chopper_gunner_pilot"]["pilot_intro"] = "iw9_mp_ks_ahotel64_intro_player";
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_missile_crash"] = % iw9_mp_ks_ahotel64_crash_player;
  level.scr_animname["ks_chopper_gunner_pilot"]["pilot_missile_crash"] = "iw9_mp_ks_ahotel64_crash_player";
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_shot_crash"] = % iw9_mp_ks_ahotel64_shot_player;
  level.scr_animname["ks_chopper_gunner_pilot"]["pilot_shot_crash"] = "iw9_mp_ks_ahotel64_shot_player";
}

#using_animtree("mp_vehicles_always_loaded");

choppergunner_vehicleanims() {
  level.scr_animtree["ks_chopper_gunner_vehicle_camera"] = #animtree;
  level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"] = % iw9_mp_ks_ahotel64_intro_heli;
}

weapongivenchoppergunner(streakinfo) {
  return 1;
}

tryusechoppergunner() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_gunner", self);
  return tryusechoppergunnerfromstruct(streakinfo);
}

tryusechoppergunnerfromstruct(streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  _id_75D0DA8E536BC6E1 = _id_B96CC2F80FA02AC2(streakinfo);

  if(!istrue(_id_75D0DA8E536BC6E1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(istrue(streakinfo._id_1C24AB6A14A60F16))
    _id_3B64EB40368C1450::set("chopperGunner", "ads", 0);

  _id_F79327D5641A9504 = _id_E708B248BC646ECB(streakinfo);
  level.incomingallchoppergunners--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incomingchoppergunners[self.team]--;

  if(!istrue(_id_F79327D5641A9504)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("chopperGunner");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  _id_EB86A5CD1650B4AF = 0;
  _id_16AADB33939B88FF = startchoppergunnerintro(self, streakinfo, _id_EB86A5CD1650B4AF);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(!isDefined(_id_16AADB33939B88FF)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_gunner", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_gunner", self);

  _id_16AADB33939B88FF thread _id_FC02C5717861131A(self, _id_EB86A5CD1650B4AF);
  return 1;
}

_id_B96CC2F80FA02AC2(streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");

    return 0;
  }

  _id_4440147083ABAF0A = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + _id_4440147083ABAF0A >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");

      return 0;
    }
  }

  level.incomingallchoppergunners++;
  _id_09C8D568F8760E50 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_09C8D568F8760E50 = 2;

  if(level.choppergunners.size >= _id_09C8D568F8760E50 || level.choppergunners.size + level.incomingallchoppergunners > _id_09C8D568F8760E50) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    level.incomingallchoppergunners--;
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    _id_ABDB6AF6E3CA3893 = 1;
    level.incomingchoppergunners[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppergunners) + level.incomingchoppergunners[self.team] > _id_ABDB6AF6E3CA3893) {
      level.incomingallchoppergunners--;
      level.incomingchoppergunners[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_CHOPPER_GUNNER");

      return 0;
    }
  }

  if(level.gameended)
    return 0;

  return 1;
}

_id_E708B248BC646ECB(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(!istrue(streakinfo._id_1C24AB6A14A60F16)) {
    deployweaponobj = makeweapon("ks_remote_device_mp");
    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::weapongivenchoppergunner);

    if(!istrue(_id_9B1DEB5E9D32BBE3))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  return 1;
}

startchoppergunnerintro(owner, streakinfo, _id_EB86A5CD1650B4AF) {
  owner disablephysicaldepthoffieldscripting();
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = (0, 0, 0);

  if(isDefined(_id_5FA1E1697A302583) && !scripts\cp_mp\utility\game_utility::islargemap()) {
    heightoffset = (0, 0, _id_5FA1E1697A302583.origin[2] - 1000);

    if(heightoffset[2] > 4000)
      setglobalsoundcontext("airstrikeheight", "high");
    else if(heightoffset[2] > 3000)
      setglobalsoundcontext("airstrikeheight", "medium");
  } else
    heightoffset = (0, 0, 2000);

  pathgoal = (owner.origin + anglesToForward(owner.angles) * 2000) * (1, 1, 0);
  pathgoal = pathgoal + heightoffset;
  angles = owner.angles;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    _id_8013278937FF2600 = randomint(level.heli_structs_entrances.size);
    _id_B2F2CBEB5539EFA6 = level.heli_structs_entrances[_id_8013278937FF2600];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      goalstruct = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "findTargetStruct")]](_id_B2F2CBEB5539EFA6.script_linkto, level.heli_structs_goals);

      if(isDefined(goalstruct)) {
        heightoffset = _id_2B1F56257B43A133((0, 0, goalstruct.origin[2] + 200));
        _id_A168DB747B0D79AC = _id_B2F2CBEB5539EFA6.origin * (1, 1, 0) + heightoffset;
        _id_C32E33B4D51BE12F = goalstruct.origin * (1, 1, 0) + heightoffset;
        _id_8577D255D1A9BD14 = vectorNormalize(_id_C32E33B4D51BE12F - _id_A168DB747B0D79AC);
        pathgoal = _id_C32E33B4D51BE12F + _id_8577D255D1A9BD14 * 500;
        angles = vectortoangles(_id_8577D255D1A9BD14);
      } else {}
    }
  } else if(istrue(owner.infinite_chopper) && level.script == "cp_so_aniyah") {
    if(level.players.size > 1)
      _id_A5B3C87A0495ACAF = scripts\engine\utility::array_remove(level.players, owner);
    else
      _id_A5B3C87A0495ACAF = level.players;

    _id_BDE2C8DCAAF3E1E8 = scripts\engine\utility::random(_id_A5B3C87A0495ACAF);
    _id_CC75F1C67D8631D9 = (_id_BDE2C8DCAAF3E1E8.origin[0], _id_BDE2C8DCAAF3E1E8.origin[1], 1750);

    while(level.objective_locations.size == 0)
      waitframe();

    _id_6BC9557C53B7E270 = scripts\engine\utility::getclosest(_id_CC75F1C67D8631D9, level.objective_locations);
    _id_BF56B72E9A5B0CC1 = (_id_6BC9557C53B7E270.origin[0], _id_6BC9557C53B7E270.origin[1], 1750);
    _id_BC721267BCEE957A = vectorNormalize(_id_CC75F1C67D8631D9 - _id_BF56B72E9A5B0CC1);
    pathgoal = _id_BF56B72E9A5B0CC1 - _id_BC721267BCEE957A * 1000;
    angles = vectortoangles(_id_BC721267BCEE957A);
  } else if(isDefined(streakinfo._id_6411FBC3AFB86BC0)) {
    _id_C2F78F301F8104E3 = [[streakinfo._id_6411FBC3AFB86BC0]](owner);
    pathgoal = _id_C2F78F301F8104E3.pathgoal;
    angles = _id_C2F78F301F8104E3.angles;
  } else
    owner iprintlnbold("Level is missing heli structs, please set them up!");

  _id_D166C9B268E88725 = "veh_apache_mp_phys";
  _id_1F17B37A437D607C = "veh9_mil_air_heli_ahotel64_mp";

  if(getdvarint("dvar_F9D055C32419E2F2", 0) > 0 || istrue(owner.infinite_chopper) && level.script == "cp_so_aniyah")
    _id_D166C9B268E88725 = "veh_apache_cp_so_aniyah";

  _id_16AADB33939B88FF = undefined;

  if(istrue(_id_EB86A5CD1650B4AF))
    _id_16AADB33939B88FF = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathgoal, angles, _id_D166C9B268E88725, _id_1F17B37A437D607C);
  else
    _id_16AADB33939B88FF = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathgoal, angles, _id_D166C9B268E88725, _id_1F17B37A437D607C);

  if(!isDefined(_id_16AADB33939B88FF)) {
    return;
  }
  _id_16AADB33939B88FF vehphys_forcekeyframedmotion();
  _id_16AADB33939B88FF _meth_247AD6A91F6A4FFE(1);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(_id_16AADB33939B88FF, owner, ::choppergunner_explode);
  _id_EBBE5C4D79905B3D = 45;
  _id_16AADB33939B88FF.speed = 100;
  _id_16AADB33939B88FF.accel = 50;
  _id_16AADB33939B88FF.lifetime = _id_EBBE5C4D79905B3D;
  _id_16AADB33939B88FF.team = owner.team;
  _id_16AADB33939B88FF.owner = owner;
  _id_16AADB33939B88FF.angles = angles;
  _id_16AADB33939B88FF.streakinfo = streakinfo;
  _id_16AADB33939B88FF.streakname = streakinfo.streakname;
  _id_16AADB33939B88FF.flaresreservecount = 1;
  _id_16AADB33939B88FF.pathgoal = pathgoal;
  _id_16AADB33939B88FF.missilesleft = getdvarint("dvar_52BF6045193DECBF", 8);
  _id_16AADB33939B88FF.animname = "ks_chopper_gunner_vehicle_camera";
  _id_16AADB33939B88FF.infinite_chopper = istrue(owner.infinite_chopper);
  _id_16AADB33939B88FF._id_2B4BBC4C0AE46FD5 = owner _id_C77D8B1C3A992F19("chopper_interior_probe");
  _id_16AADB33939B88FF.ispiloted = 1;
  _id_16AADB33939B88FF setvehicleteam(_id_16AADB33939B88FF.team);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "attachXRays"))
    _id_16AADB33939B88FF = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "attachXRays")]](_id_16AADB33939B88FF);

  _id_16AADB33939B88FF thread choppergunner_watchintrodisown("disconnect", streakinfo);
  _id_16AADB33939B88FF thread choppergunner_watchintrodisown("joined_team", streakinfo);
  _id_16AADB33939B88FF thread choppergunner_watchintrodisown("joined_spectator", streakinfo);
  _id_16AADB33939B88FF thread choppergunner_watchintrodisown("player_fatal_death", streakinfo);
  maxhealth = 2000;

  if(istrue(level.istacops))
    maxhealth = 1000;

  _id_16AADB33939B88FF.health = maxhealth;
  _id_16AADB33939B88FF.maxhealth = maxhealth;
  _id_16AADB33939B88FF.currenthealth = maxhealth;
  _id_16AADB33939B88FF scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  _id_16AADB33939B88FF _id_8DE91F51BC626D93(streakinfo.streakname);
  level.choppergunners[level.choppergunners.size] = _id_16AADB33939B88FF;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    _id_16AADB33939B88FF[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  _id_16AADB33939B88FF setmaxpitchroll(15, 15);
  _id_16AADB33939B88FF vehicle_setspeed(_id_16AADB33939B88FF.speed, _id_16AADB33939B88FF.accel);
  _id_16AADB33939B88FF sethoverparams(50, 5, 2.5);
  _id_16AADB33939B88FF setturningability(1);
  _id_16AADB33939B88FF setyawspeed(500, 100, 25, 0.5);
  _id_16AADB33939B88FF setotherent(owner);
  _id_16AADB33939B88FF setCanDamage(1);
  _id_16AADB33939B88FF setneargoalnotifydist(5000);
  _id_16AADB33939B88FF setscriptablepartstate("blinking_lights", "on", 0);
  _id_16AADB33939B88FF setscriptablepartstate("interior_light", "on", 0);
  _id_16AADB33939B88FF setscriptablepartstate("engine", "on", 0);
  turretmodel = "veh9_mil_air_heli_ahotel64_turret";
  _id_D5D9F2143828E449 = _id_2926A76719559D56();
  _id_16AADB33939B88FF.turret = spawnturret("misc_turret", _id_16AADB33939B88FF gettagorigin("tag_turret"), _id_D5D9F2143828E449);
  _id_16AADB33939B88FF.turret setModel(turretmodel);
  _id_16AADB33939B88FF.turret.owner = owner;
  _id_16AADB33939B88FF.turret.team = owner.team;
  _id_16AADB33939B88FF.turret.angles = _id_16AADB33939B88FF.angles;
  _id_16AADB33939B88FF.turret.streakinfo = streakinfo;
  _id_16AADB33939B88FF.turret linkTo(_id_16AADB33939B88FF, "tag_turret");
  _id_16AADB33939B88FF.turret setturretteam(owner.team);
  _id_16AADB33939B88FF.turret setturretmodechangewait(0);
  _id_16AADB33939B88FF.turret setmode("manual");
  _id_16AADB33939B88FF.turret setotherent(owner);
  _id_16AADB33939B88FF.turret setdefaultdroppitch(45);
  _id_16AADB33939B88FF.mpod1 = spawn("script_model", _id_16AADB33939B88FF gettagorigin("tag_gun_l"));
  _id_16AADB33939B88FF.mpod1 setModel("ks_chopper_gunner_turret_mp");
  _id_16AADB33939B88FF.mpod1.angles = _id_16AADB33939B88FF.angles;
  _id_16AADB33939B88FF.mpod1.owner = _id_16AADB33939B88FF.owner;
  _id_16AADB33939B88FF.mpod1.team = _id_16AADB33939B88FF.team;
  _id_16AADB33939B88FF.mpod1 linkTo(_id_16AADB33939B88FF, "tag_gun_l");
  _id_16AADB33939B88FF.mpod1 setentityowner(owner);
  _id_16AADB33939B88FF.mpod1 setotherent(owner);
  _id_16AADB33939B88FF.mpod2 = spawn("script_model", _id_16AADB33939B88FF gettagorigin("tag_gun_r"));
  _id_16AADB33939B88FF.mpod2 setModel("ks_chopper_gunner_turret_mp");
  _id_16AADB33939B88FF.mpod2.angles = _id_16AADB33939B88FF.angles;
  _id_16AADB33939B88FF.mpod2.owner = _id_16AADB33939B88FF.owner;
  _id_16AADB33939B88FF.mpod2.team = _id_16AADB33939B88FF.team;
  _id_16AADB33939B88FF.mpod2 linkTo(_id_16AADB33939B88FF, "tag_gun_r");
  _id_16AADB33939B88FF.mpod2 setentityowner(owner);
  _id_16AADB33939B88FF.mpod2 setotherent(owner);
  _id_DAA0B77B12720C18 = "fullbody_sp_ally_pilot_western_vm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) == 1)
    _id_DAA0B77B12720C18 = "fullbody_sp_ally_pilot_eastern_vm";

  _id_16AADB33939B88FF.pilot = spawn("script_model", _id_16AADB33939B88FF gettagorigin("tag_origin"));
  _id_16AADB33939B88FF.pilot setModel(_id_DAA0B77B12720C18);
  _id_16AADB33939B88FF.pilot.angles = _id_16AADB33939B88FF.angles;
  _id_16AADB33939B88FF.pilot linkTo(_id_16AADB33939B88FF, "tag_origin");
  _id_16AADB33939B88FF.pilot.animname = "ks_chopper_gunner_pilot";
  _id_16AADB33939B88FF.pilot scripts\common\anim::setanimtree();
  level notify("matchrecording_chopper", _id_16AADB33939B88FF);
  self notify("chopper_gunner_used");

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    self.restoreangles = self getplayerangles();
    _id_3B64EB40368C1450::_id_3633B947164BE4F3("chopperGunnerUse", 0);
    self setcinematicmotionoverride("player_chopper_gunner_ride_mp");
    thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("80_instant_noscale", 1);
    self setclientomnvar("ui_apache_screens_state", 1);
    self cameralinkTo(_id_16AADB33939B88FF.pilot, "tag_camera", 1, 1);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    _id_16AADB33939B88FF playsoundtoplayer("mp_killstreak_apache_transition_lr", self);
  } else {}

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_use", 1, undefined, "pilot");
  _id_75FF6C760340B2DC = scripts\engine\utility::get_notetrack_time(level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"], "camera_zoom");
  _id_60C29673CCE4F3F4 = getanimlength(level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"]);
  _id_9FCAB10C7E98E5D0 = getanimlength(level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"]);
  _id_16AADB33939B88FF._id_8921CA6BCBEBD389 = _id_9FCAB10C7E98E5D0 - _id_75FF6C760340B2DC;
  _id_16AADB33939B88FF thread scripts\common\anim::anim_single_solo(_id_16AADB33939B88FF, "vehicle_intro");
  _id_16AADB33939B88FF thread scripts\common\anim::anim_single_solo(_id_16AADB33939B88FF.pilot, "pilot_intro", "body_animate_jnt");
  _id_16AADB33939B88FF _id_546C923A292BAB24(_id_16AADB33939B88FF._id_2B4BBC4C0AE46FD5);
  _id_16AADB33939B88FF choppergunner_startfadetransition(_id_75FF6C760340B2DC, _id_EB86A5CD1650B4AF, 0.1);
  _id_16AADB33939B88FF _id_38101DB6ED950F17(_id_16AADB33939B88FF._id_2B4BBC4C0AE46FD5);

  if(!isDefined(_id_16AADB33939B88FF) || istrue(_id_16AADB33939B88FF._id_3621873DCCBDE4B5))
    return undefined;

  _id_16AADB33939B88FF notify("start_chopper_use");
  return _id_16AADB33939B88FF;
}

_id_8DE91F51BC626D93(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_C668CFF4B2DDAED0;
  _id_191284E2E2837328 = ::_id_042807E45E47344C;
  _id_BACC6DD14316758C = ::_id_623713927A33CB76;
  _id_7DA88D9C69433487 = ::_id_ADE353D9AFC0D191;
  deathcallback = ::choppergunner_handledeathdamage;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 1500, ::_id_30E33DC1B5A3D096);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 1000, ::_id_9A86620D2C95B213);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 500, ::_id_5DF4204110A49163);
}

_id_C668CFF4B2DDAED0(streakname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
}

_id_042807E45E47344C(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 30;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 80;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 11;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 18;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

choppergunner_watchintrodisown(_id_304D14A0F176D5C3, streakinfo) {
  _id_1C9E10C88DF5E80B = self.owner;
  self endon("death");
  self endon("exit_chopper_intro");
  self endon("start_chopper_use");
  level endon("game_ended");
  _id_1C9E10C88DF5E80B waittill(_id_304D14A0F176D5C3);

  if(_id_304D14A0F176D5C3 == "disconnect") {
    level.incomingallchoppergunners--;

    if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
      level.incomingchoppergunners[self.team]--;
  }

  if(isDefined(_id_1C9E10C88DF5E80B)) {
    _id_1C9E10C88DF5E80B cameraunlink();
    _id_1C9E10C88DF5E80B disablephysicaldepthoffieldscripting();
    _id_1C9E10C88DF5E80B _id_3B64EB40368C1450::_id_588F2307A3040610("chopperGunnerUse");
    _id_1C9E10C88DF5E80B _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("chopperGunner");
    _id_1C9E10C88DF5E80B scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    _id_1C9E10C88DF5E80B setclientomnvar("ui_apache_screens_state", 0);
    _id_1C9E10C88DF5E80B painvisionon();
    _id_1C9E10C88DF5E80B scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    _id_1C9E10C88DF5E80B scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
    _id_1C9E10C88DF5E80B scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(_id_1C9E10C88DF5E80B, 0);
  }

  thread choppergunner_explode();
  self notify("exit_chopper_intro");
}

choppergunner_waitintroanimtime(time) {
  self endon("death");
  self endon("exit_chopper_intro");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(time);
  return 1;
}

choppergunner_playdofintroeffects() {
  self endon("death");
  self endon("exit_chopper_intro");
  self.owner endon("disconnect");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(4, 5000, 10, 10);
  wait 2;
  self.owner setphysicaldepthoffield(4, 20, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(4, 1, 3, 10);
}

choppergunner_camerashake(_id_16AADB33939B88FF) {
  _id_16AADB33939B88FF endon("death");
  _id_16AADB33939B88FF endon("explode");
  _id_16AADB33939B88FF endon("leaving");
  _id_16AADB33939B88FF endon("crashing");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self earthquakeforplayer(0.01, 0.1, _id_16AADB33939B88FF gettagorigin("tag_origin"), 1000);
    self playRumbleOnEntity("damage_light");
    wait 0.1;
  }
}

_id_FC02C5717861131A(gunner, _id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

  gunner = self.owner;
  gunner disablephysicaldepthoffieldscripting();

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    gunner.usingchoppergunner = 1;
    gunner _id_3B64EB40368C1450::set("chopperGunner", "allow_movement", 1);
    gunner _id_3B64EB40368C1450::set("chopperGunner", "fire", 1);
    gunner _id_3B64EB40368C1450::set("chopperGunner", "ads", 1);
    gunner cameraunlink();
    gunner thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("default");
    gunner remotecontrolturret(self.turret);
    gunner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    choppergunner_updatetargetmarkergroups(1);
  }

  if(!isDefined(self.playersfx)) {
    self.playersfx = spawn("script_origin", self.origin);
    self.playersfx linkTo(self);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, ::choppergunner_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, ::choppergunner_lockedonremovedcallback);
  self setCanDamage(1);
  thread choppergunner_handlethermalswitch(_id_EB86A5CD1650B4AF);
  thread choppergunner_handlemissilefire(_id_EB86A5CD1650B4AF);
  thread choppergunner_watchturretfire(_id_EB86A5CD1650B4AF);
  thread choppergunner_watchgameendleave(_id_EB86A5CD1650B4AF);
  thread _id_C7C48AED42B53D29(_id_EB86A5CD1650B4AF);
  thread choppergunner_watchownerexitaction("disconnect");
  thread choppergunner_watchownerexitaction("joined_team");
  thread choppergunner_watchownerexitaction("joined_spectator");
  thread choppergunner_watchownerexitaction("team_kill_punish");
  thread choppergunner_watchownerexitaction("player_fatal_death");
  thread _id_F6A755E207671291();

  if(!istrue(self.infinite_chopper)) {
    thread choppergunner_watchlifetime(_id_EB86A5CD1650B4AF);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.lifetime * 1000));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::choppergunner_handlemissiledetection);

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    gunner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
    gunner setclientomnvar("ui_apache_screens_state", 0);
    gunner setclientomnvar("ui_apache_controls", 1);
    gunner setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
    gunner setclientomnvar("ui_killstreak_health", self.health / self.maxhealth);
    gunner setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
    gunner setclientomnvar("ui_killstreak_damage_state", 0);
    self.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
    gunner setclienttriggeraudiozonepartialwithfade("apache_killstreak", 1.5, "mix", "filter");
  }

  _id_74B5B12BB6514385 = self._id_8921CA6BCBEBD389;
  wait(_id_74B5B12BB6514385);

  if(!istrue(_id_EB86A5CD1650B4AF))
    gunner remotecontrolvehicle(self);
  else
    self setvehgoalpos(self.origin, 1);

  if(self vehicle_isphysveh())
    self vehphys_setdefaultmotion();

  thread choppergunner_watchearlyexit(_id_EB86A5CD1650B4AF);
  _id_7AED0F2A57765C9D = _id_DFC7AF47240A8C18();
  self vehicle_setspeed(_id_7AED0F2A57765C9D.speed, _id_7AED0F2A57765C9D.accel);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh show();
}

_id_DFC7AF47240A8C18() {
  _id_2771A96B4C9AFD11 = spawnStruct();
  _id_2771A96B4C9AFD11.speed = 40;
  _id_2771A96B4C9AFD11.accel = 20;

  switch (level.mapname) {
    case "mp_wartorn":
    case "mp_swap_meet":
    case "mp_luxury":
    case "mp_farm_18":
    case "mp_embassy_hlwn":
    case "mp_embassy":
      _id_2771A96B4C9AFD11.speed = 25;
      _id_2771A96B4C9AFD11.accel = 15;
      break;
    case "mp_museum":
    case "mp_crossing":
    case "mp_catedral_hlwn":
    case "mp_catedral":
      _id_2771A96B4C9AFD11.speed = 30;
      _id_2771A96B4C9AFD11.accel = 20;
      break;
  }

  return _id_2771A96B4C9AFD11;
}

_id_2B1F56257B43A133(_id_BAD97BF0DD8846F4) {
  _id_7972751497D6D77D = _id_BAD97BF0DD8846F4;

  switch (level.mapname) {
    case "mp_crossing":
    case "mp_farm_18":
    case "mp_embassy_hlwn":
    case "mp_embassy":
      _id_7972751497D6D77D = _id_7972751497D6D77D + (0, 0, 300);
      break;
  }

  return _id_7972751497D6D77D;
}

choppergunner_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_lockedon", undefined, undefined, "pilot");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

choppergunner_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

choppergunner_updatetargetmarkergroups(_id_D1D3327F51ED4342) {
  if(istrue(_id_D1D3327F51ED4342)) {
    if(istrue(self.infinite_chopper)) {
      return;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "assignTargetMarkers"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "assignTargetMarkers")]]();
  } else {
    if(isDefined(self.enemytargetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
      self.enemytargetmarkergroup = undefined;
    }

    if(isDefined(self.friendlytargetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
      self.friendlytargetmarkergroup = undefined;
    }
  }
}

choppergunner_watchendstrobefx(_id_16AADB33939B88FF) {
  self endon("death");
  level endon("game_ended");
  _id_16AADB33939B88FF scripts\engine\utility::waittill_any_2("death", "leaving");
  self delete();
}

choppergunner_startfadetransition(_id_3702CBA57F844507, _id_EB86A5CD1650B4AF, _id_1E1134FF29F6168C) {
  self endon("death");
  self endon("exit_chopper_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_3702CBA57F844507);

  if(!istrue(_id_EB86A5CD1650B4AF))
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 1, _id_1E1134FF29F6168C);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_1E1134FF29F6168C);

  if(!istrue(_id_EB86A5CD1650B4AF))
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 0, _id_1E1134FF29F6168C);
}

choppergunner_handledangerzone(_id_EB86A5CD1650B4AF) {
  self endon("leaving");
  self endon("crashing");
  self endon("death");
  level endon("game_ended");
  zone = undefined;
  _id_A34242959EA0E02B = self.origin;
  _id_4A6ABC8D46FB3619 = 750;
  _id_20E0E132629F3354 = 2000;
  _id_16A1AB6DFEB8D692 = self.team;
  _id_D5A970096FD175A0 = self.lifetime;
  _id_4CDDBF0B2285C1BE = self.owner;
  _id_DDF8049486533578 = 1;
  _id_CDC10243B9998950 = self;
  _id_D3279A50B0437E88 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    zone = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](_id_A34242959EA0E02B, _id_4A6ABC8D46FB3619, _id_20E0E132629F3354, _id_16A1AB6DFEB8D692, _id_D5A970096FD175A0, _id_4CDDBF0B2285C1BE, _id_DDF8049486533578, _id_CDC10243B9998950, _id_D3279A50B0437E88);

  if(isDefined(zone) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "getCodeHandleFromScriptHandle")) {
    _id_04344AEB5E045AC5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "getCodeHandleFromScriptHandle")]](zone);

    for(;;) {
      _id_CEFD3F9499BE0121 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(_id_CEFD3F9499BE0121["hittype"] != "hittype_none")
        spawninfluencepointsetposition(_id_04344AEB5E045AC5, _id_CEFD3F9499BE0121["position"]);

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }
  }
}

choppergunner_handlethermalswitch(_id_EB86A5CD1650B4AF) {
  if(!istrue(_id_EB86A5CD1650B4AF)) {
    _id_A95A67A21665324A = self.owner;
    _id_A95A67A21665324A thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
    choppergunner_handlethermalswitchinternal();

    if(isDefined(_id_A95A67A21665324A))
      _id_A95A67A21665324A scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
  }
}

choppergunner_handlethermalswitchinternal() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  _id_A95A67A21665324A = self.owner;
  _id_AA58B09FC1B68120 = 0;
  _id_9B984D47DE04E649 = 0;
  _id_093B54405FDA960C = scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB();
  _id_776EB21EE7BAAB30 = "chopper_color_mp";

  if(scripts\common\utility::iscp())
    _id_776EB21EE7BAAB30 = "chopper_color_cp";

  self.currentvisionset = _id_776EB21EE7BAAB30;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    _id_A95A67A21665324A scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    self.currentvisionset = _id_093B54405FDA960C;
    _id_A95A67A21665324A scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
    _id_AA58B09FC1B68120 = 1;
    _id_9B984D47DE04E649 = 1;
  }

  for(;;) {
    _id_A95A67A21665324A setclientomnvar("ui_killstreak_thermal_mode", _id_9B984D47DE04E649);
    _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(self.currentvisionset);
    _id_A95A67A21665324A waittill("switch_thermal_mode");
    _id_A95A67A21665324A notify("chopper_gunner_toggled_flir", !_id_AA58B09FC1B68120);

    if(!istrue(_id_AA58B09FC1B68120)) {
      _id_A95A67A21665324A scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
      self.currentvisionset = _id_093B54405FDA960C;
      _id_A95A67A21665324A scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
      _id_AA58B09FC1B68120 = 1;
      _id_9B984D47DE04E649 = 1;
      continue;
    }

    _id_A95A67A21665324A scripts\cp_mp\utility\player_utility::setthermalvision(0);
    self.currentvisionset = _id_776EB21EE7BAAB30;
    _id_A95A67A21665324A scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    _id_AA58B09FC1B68120 = 0;
    _id_9B984D47DE04E649 = 0;
  }
}

choppergunner_handlemissilefire(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  _id_A95A67A21665324A = self.owner;
  _id_A95A67A21665324A notifyonplayercommand("shoot_missile", "+frag");
  self.missilefireside = undefined;
  _id_FA1B66C7E6853EE1 = 0;
  _id_43CB1141ECBED065 = 4;
  _id_FA3D844D56938A31 = getdvarint("dvar_52BF6045193DECBF", 8);

  for(;;) {
    _id_A95A67A21665324A waittill("shoot_missile", _id_2511ABB80C1DE0C9);

    if(istrue(self.infinite_chopper)) {
      if(scripts\common\utility::iscp() && self.missilesleft <= 1)
        childthread choppergunner_refillmissiles();
      else if(!scripts\common\utility::iscp() && self.missilesleft == _id_FA3D844D56938A31)
        childthread choppergunner_refillmissiles();
    }

    _id_FA1B66C7E6853EE1++;
    self.streakinfo.shots_fired++;

    if(_id_FA1B66C7E6853EE1 > _id_43CB1141ECBED065)
      _id_FA1B66C7E6853EE1 = 1;

    _id_9798C7AA7C0A8A06 = scripts\engine\utility::ter_op(isDefined(self.turret), self.turret.origin, self.origin);
    self.owner earthquakeforplayer(0.25, 0.4, _id_9798C7AA7C0A8A06, 150);
    self.owner playRumbleOnEntity("damage_heavy");
    _id_B8EE7DDD93755F86 = self.mpod1;

    if(!isDefined(self.missilefireside) || self.missilefireside == "right") {
      self.missilefireside = "left";
      self.mpod1 thread choppergunner_firemissilefx(_id_FA1B66C7E6853EE1);
      _id_B8EE7DDD93755F86 = self.mpod1;
    } else {
      self.missilefireside = "right";
      self.mpod2 thread choppergunner_firemissilefx(_id_FA1B66C7E6853EE1);
      _id_B8EE7DDD93755F86 = self.mpod2;
    }

    _id_48C7944AD56A77EC = self.turret gettagorigin("tag_pivot");
    _id_A437F2B6D33146EB = anglesToForward(self.turret gettagangles("tag_player"));
    _id_B979F793DCCB4061 = _id_B8EE7DDD93755F86.origin * (1, 1, 0) + (0, 0, _id_48C7944AD56A77EC[2]);
    _id_0429AAE2E6E20F85 = _id_B979F793DCCB4061 + _id_A437F2B6D33146EB * 100;
    _id_85FA3CDCB19D2A9C = _id_B979F793DCCB4061 + _id_A437F2B6D33146EB * 1000;
    _id_53650D2083B7668F = self.owner getvieworigin();
    _id_B2AD24AEDFC0EB0A = anglesToForward(self.owner getplayerangles());
    _id_D449DEB5B0FB63BA = _id_53650D2083B7668F + _id_B2AD24AEDFC0EB0A * 50000;
    ignorelist = [self, self.turret, _id_B8EE7DDD93755F86];
    _id_369DC9ED4C0EC3F5 = scripts\engine\trace::ray_trace(_id_53650D2083B7668F, _id_D449DEB5B0FB63BA, ignorelist, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
    _id_EF24300E6DDE92BA = _id_369DC9ED4C0EC3F5["position"];

    if(isDefined(_id_2511ABB80C1DE0C9))
      _id_EF24300E6DDE92BA = _id_2511ABB80C1DE0C9;

    _id_AB7356FD109D3E8D = scripts\engine\utility::ter_op(scripts\common\utility::iscp(), "chopper_gunner_proj_cp", "chopper_gunner_proj_mp");
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(_id_AB7356FD109D3E8D), _id_0429AAE2E6E20F85, _id_85FA3CDCB19D2A9C, _id_A95A67A21665324A);
    missile thread choppergunner_watchmissilestate(_id_EF24300E6DDE92BA);
    missile thread choppergunner_watchexplosioninfluencepoint(self.owner, 2, 300, 300);
    self notify("fired_missile", missile);
    missile.streakinfo = self.streakinfo;
    self.missilesleft--;
    _id_A95A67A21665324A setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);

    if(self.missilesleft == 0) {
      if(istrue(self.infinite_chopper)) {
        self waittill("missiles_refilled");
        continue;
      }

      break;
    }
  }
}

choppergunner_refillmissiles() {
  self endon("missiles_refilled");
  _id_5BD47981B826A0AD = getdvarfloat("dvar_2F91DA9928400CBD", 8.0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_5BD47981B826A0AD);
  self.missilesleft = getdvarint("dvar_52BF6045193DECBF", 8);
  self.owner setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
  self notify("missiles_refilled");
}

choppergunner_watchturretfire(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  _id_D8C1A9B6F71F67D1 = 500;

  if(scripts\common\utility::iscp()) {
    _id_D8C1A9B6F71F67D1 = 100;
    self.owner._id_606E132DDFE3CCF9 = _id_D8C1A9B6F71F67D1;
    self.owner setclientomnvar("ui_killstreak_weapon_2_ammo", _id_D8C1A9B6F71F67D1);
  }

  for(;;) {
    self.turret waittill("missile_fire", missile);
    self.owner earthquakeforplayer(0.15, 0.1, self.turret.origin, 150);
    missile.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    missile thread choppergunner_watchexplosioninfluencepoint(self.owner, 0.5, 256, 200);

    if(scripts\common\utility::iscp()) {
      _id_D8C1A9B6F71F67D1--;
      self.owner._id_606E132DDFE3CCF9 = _id_D8C1A9B6F71F67D1;

      if(_id_D8C1A9B6F71F67D1 < 0) {
        self.turret turretfiredisable();
        wait 3;
        _id_D8C1A9B6F71F67D1 = 100;
        self notify("turret_reloaded");
        self.turret turretfireenable();
      }

      self.owner setclientomnvar("ui_killstreak_weapon_2_ammo", _id_D8C1A9B6F71F67D1);
    }
  }
}

choppergunner_firemissilefx(_id_1600845F933938D5) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + _id_1600845F933938D5, "on", 0);
  wait 1;
  self setscriptablepartstate("fire_missile_" + _id_1600845F933938D5, "off", 0);
}

choppergunner_watchmissilestate(_id_A0D0DA7C35D995C8) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self))
    self missile_settargetpos(_id_A0D0DA7C35D995C8);
}

choppergunner_watchlifetime(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  lifetime = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_leave", 1, undefined, "pilot");
  thread choppergunner_leave(_id_EB86A5CD1650B4AF);
}

choppergunner_watchgameendleave(_id_EB86A5CD1650B4AF) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level scripts\engine\utility::waittill_any_2("start_game_ended", "game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  thread choppergunner_leave(_id_EB86A5CD1650B4AF);
}

_id_C7C48AED42B53D29(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(istrue(_id_EB86A5CD1650B4AF)) {
    return;
  }
  _id_6BAE51DE5D6B7B00 = 65;
  _id_A326F793BDAF5565 = 0.25;
  currentfov = _id_6BAE51DE5D6B7B00;
  _id_D54D564805C29B7B = 30;
  _id_91C95E88F4DE9ED7 = 0;
  _id_7B2D7A7927E3E11E = 0;
  self.owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);

  for(;;) {
    if(self.owner adsButtonPressed()) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 + 0.05;

      if(_id_91C95E88F4DE9ED7 >= _id_A326F793BDAF5565)
        _id_91C95E88F4DE9ED7 = _id_A326F793BDAF5565;

      if(!istrue(_id_7B2D7A7927E3E11E)) {
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_58707DDFDD9744FA("killstreak_ads_shutter");
        _id_7B2D7A7927E3E11E = 1;
      }
    } else if(_id_91C95E88F4DE9ED7 > 0) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 - 0.05;

      if(_id_91C95E88F4DE9ED7 <= 0)
        _id_91C95E88F4DE9ED7 = 0;

      if(istrue(_id_7B2D7A7927E3E11E))
        _id_7B2D7A7927E3E11E = 0;
    }

    if(_id_91C95E88F4DE9ED7 >= 0) {
      _id_F29615BFB202E7D4 = _id_91C95E88F4DE9ED7 / _id_A326F793BDAF5565 * 100;
      currentfov = int(_id_F29615BFB202E7D4 * (_id_D54D564805C29B7B - _id_6BAE51DE5D6B7B00) / 100 + _id_6BAE51DE5D6B7B00);
    }

    self.owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);
    wait 0.05;
  }
}

choppergunner_watchownerexitaction(_id_304D14A0F176D5C3) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(_id_304D14A0F176D5C3);

  if(_id_304D14A0F176D5C3 == "player_fatal_death")
    thread choppergunner_leave();
  else {
    thread choppergunner_returnplayer(0, 0);
    thread choppergunner_explode();
  }
}

choppergunner_watchtargets() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_engage", undefined, undefined, "pilot");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    _id_C26B9F481753E189 = [];

    foreach(player in level.players) {
      if(self.owner worldpointinreticle_circle(player.origin, 80, 100)) {
        if(level.teambased && player.team == self.team) {
          continue;
        }
        if(player == self.owner) {
          continue;
        }
        ignorelist = [self, self.turret];

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.turret gettagorigin("tag_flash"), player gettagorigin("j_head"), ignorelist)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
            continue;
        }

        _id_C26B9F481753E189 = choppergunner_getnearbytargets(player);
        break;
      }

      wait 0.05;
    }

    if(_id_C26B9F481753E189.size > 0 && _id_C26B9F481753E189.size < 2)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_attack_single", undefined, undefined, "pilot");
    else if(_id_C26B9F481753E189.size >= 2)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_attack_multi", undefined, undefined, "pilot");

    wait(randomintrange(5, 15));
  }
}

choppergunner_getnearbytargets(_id_0050ED806F04C63D) {
  _id_EF269077A28646EB = scripts\common\utility::playersincylinder(_id_0050ED806F04C63D.origin, 300);
  _id_BC19A29ED084D79C = [];

  foreach(player in _id_EF269077A28646EB) {
    if(level.teambased && player.team != _id_0050ED806F04C63D.team) {
      continue;
    }
    if(!level.teambased && player == self.owner) {
      continue;
    }
    _id_BC19A29ED084D79C[_id_BC19A29ED084D79C.size] = player;
  }

  return _id_BC19A29ED084D79C;
}

_id_F6A755E207671291() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner endon("disconnect");
  self._id_0D743AC65ECCE766 = 0;
  self._id_5FB9DDD4AEC3A659 = undefined;
  childthread choppergunner_watchkills();
  childthread _id_708F19CF8E854691();
  _id_AB7356FD109D3E8D = scripts\engine\utility::ter_op(scripts\common\utility::iscp(), "chopper_gunner_proj_cp", "chopper_gunner_proj_mp");

  for(;;) {
    if(self._id_0D743AC65ECCE766 != 0) {
      wait 2;

      if(self._id_0D743AC65ECCE766 >= 1 && self._id_5FB9DDD4AEC3A659 == _id_AB7356FD109D3E8D)
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_killconf_missile", undefined, undefined, "pilot");
      else if(self._id_0D743AC65ECCE766 == 1)
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_killconf_single", undefined, undefined, "pilot");
      else if(self._id_0D743AC65ECCE766 >= 2)
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_killconf_multi", undefined, undefined, "pilot");

      self._id_0D743AC65ECCE766 = 0;
      self._id_5FB9DDD4AEC3A659 = undefined;
      wait 1;
    }

    waitframe();
  }
}

choppergunner_watchkills() {
  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(isDefined(_id_E4C6376813E5A077)) {
      self._id_0D743AC65ECCE766++;
      self._id_5FB9DDD4AEC3A659 = weaponname;
    }
  }
}

_id_708F19CF8E854691() {
  for(;;) {
    self.owner waittill("update_rapid_agent_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(isDefined(_id_E4C6376813E5A077)) {
      self._id_0D743AC65ECCE766++;
      self._id_5FB9DDD4AEC3A659 = weaponname;
    }
  }
}

choppergunner_leave(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("crashing");
  thread choppergunner_returnplayer(0, _id_EB86A5CD1650B4AF);
  self clearlookatent();
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  _id_DF6C75D1A1E4FF18 = 3;
  _id_E757789796C82383 = (0, 0, 1000);
  _id_BB0E78A73B33D580 = self.origin + _id_E757789796C82383;
  _id_BC09A6E223B96348 = undefined;
  _id_690E4620FE5FA98F = undefined;
  _id_EC0C66C48E6F8304 = undefined;

  while(_id_DF6C75D1A1E4FF18 > 0) {
    flightpath = scripts\cp_mp\utility\killstreak_utility::_id_999FE3838D6B6F8C(_id_BB0E78A73B33D580, self.angles, 400, 15000);

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

  if(!isDefined(_id_690E4620FE5FA98F))
    thread choppergunner_explode();
  else {
    _id_1602FAB5EAB68601 = 100;
    _id_2451A07ACA478BF6 = 50;
    self setyawspeed(_id_1602FAB5EAB68601, 50, 25, 0);
    self settargetyaw(_id_EC0C66C48E6F8304[1]);
    self vehicle_setspeed(_id_2451A07ACA478BF6, 25);
    pathgoal = _id_BC09A6E223B96348;
    self setvehgoalpos(pathgoal, 1);
    scripts\engine\utility::waittill_any_timeout_1(3, "goal");
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
    self notify("gone");
    thread choppergunner_delete(0);
  }
}

choppergunner_getpathend() {
  _id_CE2E2CFD0619F6CA = 150;
  _id_90783CCFB7B260FB = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * _id_90783CCFB7B260FB;
  return endpoint;
}

_id_623713927A33CB76(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_ADE353D9AFC0D191(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(self.owner) && self.owner isusingchoppergunner()) {
    _id_BB22D61320FFE92D = "light";

    if(isexplosivedamagemod(type)) {
      if(ceil(damage / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
        _id_BB22D61320FFE92D = "heavy";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }

    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C144DE677D9B9175(self.currentvisionset, _id_BB22D61320FFE92D);
  }

  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_30E33DC1B5A3D096() {
  self setscriptablepartstate("body_damage_light", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_light_damage", undefined, undefined, "pilot");
}

_id_9A86620D2C95B213() {
  self setscriptablepartstate("body_damage_medium", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_med_damage", undefined, undefined, "pilot");
}

_id_5DF4204110A49163() {
  self setscriptablepartstate("body_damage_heavy", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_heavy_damage", undefined, undefined, "pilot");
}

choppergunner_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread _id_2B17AA319C193951(data.attacker, data.objweapon);
  return 1;
}

_id_2B17AA319C193951(attacker, killedbyweapon) {
  self endon("explode");
  _id_EB86A5CD1650B4AF = 0;
  _id_01D4408C68F2118A = isDefined(attacker) && isPlayer(attacker) && istrue(attacker.isjuggernaut);
  _id_031777ACBF2B0901 = 1;

  if(isDefined(self.owner) && self.owner isusingchoppergunner())
    thread choppergunner_returnplayer(_id_031777ACBF2B0901, _id_EB86A5CD1650B4AF);

  if(istrue(_id_031777ACBF2B0901)) {
    _id_546C923A292BAB24(self._id_2B4BBC4C0AE46FD5);
    choppergunner_crash(150, killedbyweapon);
    _id_38101DB6ED950F17(self._id_2B4BBC4C0AE46FD5);
  }

  thread choppergunner_explode();
}

choppergunner_crash(speed, _id_11B83E21F9C87FF5, _id_C5ADB13BE635C61A) {
  self endon("explode");
  self.iscrashing = 1;
  self clearlookatent();
  self notify("crashing");
  self setscriptablepartstate("engine_explosion", "on", 0);
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_D3197EAE18C8CC43 = "missile_damage";

  if(scripts\cp_mp\utility\weapon_utility::isbulletweapon(_id_11B83E21F9C87FF5))
    _id_D3197EAE18C8CC43 = "bullet_damage";

  self setscriptablepartstate("glass", _id_D3197EAE18C8CC43, 0);
  _id_6847739E80FB4E81 = choppergunner_findcrashposition(1250);

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_crash", 1, undefined, "pilot");
  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread choppergunner_spinout(speed);
  _id_AD75966BE1548661 = "pilot_missile_crash";

  if(scripts\cp_mp\utility\weapon_utility::isbulletweapon(_id_11B83E21F9C87FF5))
    _id_AD75966BE1548661 = "pilot_shot_crash";

  thread scripts\common\anim::anim_single_solo(self.pilot, _id_AD75966BE1548661, "body_animate_jnt");
  scripts\engine\utility::waittill_any_timeout_2(5, "collision", _id_AD75966BE1548661);
  scripts\cp_mp\utility\killstreak_utility::_id_5A9772411551E56E("chopper_gunner", "pilot");
}

choppergunner_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.6);
    wait 0.5;
  }
}

choppergunner_findcrashposition(_id_6F8D59F68BD2B46C) {
  _id_B2B5F5510C5D94E0 = self.origin;
  crashoffset = 1000;
  _id_543F2191DDE2B7F6 = undefined;
  _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
  _id_5CC1D6DD55C49E3A = anglestoright(self.angles);
  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 + _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_5CC1D6DD55C49E3A - _id_6C5CEED9B00EB7D5) - (0, 0, crashoffset);
  _id_4720F54E3EFF6E8D = scripts\engine\trace::ray_trace(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (-1 * _id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  return _id_543F2191DDE2B7F6;
}

choppergunner_explode() {
  if(istrue(self._id_3621873DCCBDE4B5)) {
    return;
  }
  self notify("explode");
  self._id_3621873DCCBDE4B5 = 1;

  if(isDefined(self.owner))
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_ballistics_mp");

  self setscriptablepartstate("explode", "on", 0);
  self setscriptablepartstate("explode_smoke", "on", 0);
  wait 0.35;
  thread choppergunner_delete(1);
}

choppergunner_delete(_id_4FAC8B8CE36E09F1) {
  if(istrue(self._id_BF178F6894D17B96)) {
    return;
  }
  self._id_BF178F6894D17B96 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - chopperGunner", self.owner);

  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(!istrue(self.recordedgameendstats))
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  self stoploopsound();

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self.firetarget))
    self.firetarget delete();

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.mpod1)) {
    self.mpod1 setentityowner(undefined);
    self.mpod1 delete();
  }

  if(isDefined(self.mpod2)) {
    self.mpod2 setentityowner(undefined);
    self.mpod2 delete();
  }

  level.choppergunners = scripts\engine\utility::array_remove(level.choppergunners, self);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

choppergunner_returnplayer(_id_07436690EA0E728C, _id_EB86A5CD1650B4AF) {
  choppergunner_updatetargetmarkergroups(0);
  _id_A95A67A21665324A = self.owner;

  if(!isDefined(_id_A95A67A21665324A)) {
    return;
  }
  streakinfo = self.streakinfo;
  thread _id_70FF764379BE5089(_id_A95A67A21665324A, _id_07436690EA0E728C, _id_EB86A5CD1650B4AF, streakinfo);
  _id_A95A67A21665324A notify("chopperGunner_returning_player");
  _id_A95A67A21665324A endon("disconnect");

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh hide();

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  choppergunner_lockedonremovedcallback();
  _id_A95A67A21665324A clearclienttriggeraudiozone(0.5);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(isDefined(_id_A95A67A21665324A)) {
    if(!istrue(_id_EB86A5CD1650B4AF)) {
      _id_A95A67A21665324A _id_3B64EB40368C1450::set("chopperGunner", "allow_movement", 0);
      _id_A95A67A21665324A clearcinematicmotionoverride();
      _id_A95A67A21665324A scripts\cp_mp\utility\player_utility::setthermalvision(0);
      _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
      _id_A95A67A21665324A setclientomnvar("ui_apache_controls", 0);
      _id_A95A67A21665324A remotecontrolvehicleoff();
      _id_A95A67A21665324A remotecontrolturretoff(self.turret);
      _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
      _id_A95A67A21665324A scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

      if(istrue(_id_07436690EA0E728C)) {
        wait 0.05;
        _id_A95A67A21665324A setclientomnvar("ui_apache_screens_state", 2);
        _id_A95A67A21665324A thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("80_instant_noscale");
        _id_A95A67A21665324A cameralinkTo(self.pilot, "tag_camera", 1, 1);
        _id_A95A67A21665324A playlocalsound("mp_killstreak_apache_death_plr");
        self waittill("explode");
        _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_static");
        _id_A95A67A21665324A cameraunlink();
        wait 1;
        _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
      }

      _id_A95A67A21665324A _id_3B64EB40368C1450::_id_588F2307A3040610("chopperGunnerUse");
      _id_A95A67A21665324A _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("chopperGunner");
      level thread scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles(_id_A95A67A21665324A);
      _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
      _id_A95A67A21665324A setclientomnvar("ui_apache_screens_state", 0);
      _id_A95A67A21665324A painvisionon();
      _id_A95A67A21665324A scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
      _id_A95A67A21665324A.usingchoppergunner = undefined;
    }
  }

  _id_A95A67A21665324A notify("chopperGunner_finished_crash_anim");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

_id_70FF764379BE5089(owner, _id_07436690EA0E728C, _id_EB86A5CD1650B4AF, streakinfo) {
  if(!istrue(_id_07436690EA0E728C)) {
    return;
  }
  self endon("explode");
  owner endon("disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("death");

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    owner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_static");
    owner cameraunlink();
    owner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
    level thread scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles(owner);
    owner scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
    owner setclientomnvar("ui_apache_screens_state", 0);
    owner painvisionon();
    owner scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    owner.usingchoppergunner = undefined;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

choppergunner_watchearlyexit(_id_EB86A5CD1650B4AF) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");

  self waittill("killstreakExit");
  thread choppergunner_leave(_id_EB86A5CD1650B4AF);
}

choppergunner_handlemissiledetection(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
        _id_6D87867F43E1D612 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, _id_5991F0E5DA9F9BD5);

      _id_6D87867F43E1D612 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner", "chopper_gunner_flares", undefined, undefined, "pilot");
      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit"))
        _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

isusingchoppergunner() {
  return isDefined(self.usingchoppergunner);
}

choppergunner_watchexplosioninfluencepoint(owner, lifetime, radius, height) {
  owner endon("disconnect");
  level endon("game_ended");
  self waittill("explode", position);
  owner notify("gunner_turret_impact", position);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](position, radius, height, owner.team, lifetime, owner, 1);
}

_id_C77D8B1C3A992F19(_id_5E0676140EECDF2D) {
  _id_CF01D7BE22198C56 = spawnStruct();
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");

  if(!isDefined(probe))
    return undefined;

  _id_CF01D7BE22198C56.probe = probe;
  _id_AD02EAA051593BFF = [];
  _id_AD02EAA051593BFF["pos"] = probe.origin;
  _id_AD02EAA051593BFF["rot"] = probe.angles;
  _id_CF01D7BE22198C56._id_0AF2C99167339224 = _id_AD02EAA051593BFF;
  return _id_CF01D7BE22198C56;
}

_id_546C923A292BAB24(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  _id_CF01D7BE22198C56.probe linkTo(self, "tag_origin", (109, 0, -62), (0, 0, 0));
}

_id_38101DB6ED950F17(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  _id_CF01D7BE22198C56.probe unlink();
  _id_CF01D7BE22198C56.probe.origin = _id_CF01D7BE22198C56._id_0AF2C99167339224["pos"];
  _id_CF01D7BE22198C56.probe.angles = _id_CF01D7BE22198C56._id_0AF2C99167339224["rot"];
}

_id_2926A76719559D56() {
  turretweapon = "chopper_gunner_turret_ballistics_mp";

  if(scripts\common\utility::iscp())
    turretweapon = "chopper_gunner_turret_cp";

  return turretweapon;
}