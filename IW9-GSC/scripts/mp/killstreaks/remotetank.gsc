/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotetank.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("pac_sentry", ::tryuseremotetankfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("remoteTank", "attachXRays", ::_id_8CBA478F80E8AC72);
  level _id_D029F84FC08948BE();
  level _id_6866DB861AC3911C();
  level _id_1CF50B689D874CAB();
  level _id_67B3C8209AEE7FD0();
  level _id_67F9BF209B3AFB75();
  level _id_E46C604FE3E0C63A();
}

_id_D029F84FC08948BE() {
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60.0;
  level.tanksettings["remote_tank"].maxhealth = 3000;
  level.tanksettings["remote_tank"].hitstokill = 10;
  level.tanksettings["remote_tank"].streakname = "pac_sentry";
  level.tanksettings["remote_tank"].modelbase = "veh9_mil_lnd_whotel_v2_composite_mp";
  level.tanksettings["remote_tank"].bodymodel = "veh9_mil_lnd_whotel_v2_body_mp";
  level.tanksettings["remote_tank"].turretmodel = "veh9_mil_lnd_whotel_v2_turret_mp";
  level.tanksettings["remote_tank"].weaponinfo = "pac_sentry_turret_mp";
  level.tanksettings["remote_tank"].vehicleinfo = "veh_pac_sentry_amphibious_mp";
  level.tanksettings["remote_tank"].sentrymodeon = "sentry";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].burstmin = 20;
  level.tanksettings["remote_tank"].burstmax = 120;
  level.tanksettings["remote_tank"].pausemin = 0.15;
  level.tanksettings["remote_tank"].pausemax = 0.35;
  level.tanksettings["remote_tank"].lockstrength = 6;
  level.tanksettings["remote_tank"].spinuptime = 0.65;
  level.tanksettings["remote_tank"].overheattime = 8.0;
  level.tanksettings["remote_tank"].cooldowntime = 0.3;
  level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level.tanksettings["remote_tank"].scorepopup = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].vodestroyed = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].destroyedsplash = "callout_destroyed_pac_sentry";
  level.tanksettings["remote_tank"].premoddamagefunc = ::_id_944F35A106CF0B72;
  level.tanksettings["remote_tank"].postmoddamagefunc = ::_id_75AB8F8D5F7AFF1D;
  level.tanksettings["remote_tank"].deathfunc = ::_id_C2A6845F0336B0F1;
  level.incomingallremotetanks = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level.incomingremotetanks[_id_FABF84450735DD93] = 0;

  level.remotetanks = [];
  level _id_94C2E83DCB13EC31();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("pac_sentry", "third_person_hud_on", 11);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("pac_sentry", "first_person_hud_on", 12);
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius("pac_sentry", 32);
}

_id_6866DB861AC3911C() {}

_id_1CF50B689D874CAB() {}

_id_94C2E83DCB13EC31() {
  minedata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pac_sentry", 1);
  minedata.frontextents = 32;
  minedata.backextents = 32;
  minedata.leftextents = 22;
  minedata.rightextents = 22;
  minedata.bottomextents = 10;
  minedata.distancetobottom = 50;
  vehicledata = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("pac_sentry");
  vehicledata.occupancy = spawnStruct();
  vehicledata.occupancy.exitdirections = ["left", "right", "back", "front"];
  vehicledata.occupancy.exitoffsets = [(-5, 0, 55), (5, 0, 55), (-35, 0, 45), (29, 0, 55)];
  vehicledata.occupancy.exittopcastoffset = 45;
  vehicledata.occupancy.exitextents["left"] = 28;
  vehicledata.occupancy.exitextents["right"] = 28;
  vehicledata.occupancy.exitextents["back"] = 45;
  vehicledata.occupancy.exitextents["front"] = 45;
  vehicledata.occupancy.exitextents["top"] = 40;
  vehicledata.occupancy.exitextents["bottom"] = 0;
}

_id_67B3C8209AEE7FD0() {
  game["dialog"]["pac_sentry_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["pac_sentry_timeout"] = "killstreak_remote_operator_timeout";
  game["dialog"]["pac_sentry_destroyed"] = "killstreak_remote_operator_crash";
  game["dialog"]["pac_sentry_sentry"] = "killstreak_remote_operator_confirm_sentry_mode";
}

_id_67F9BF209B3AFB75() {}

_id_E46C604FE3E0C63A() {}

weapongivenremotetank(streakinfo) {
  return 1;
}

deployweapontaken(streakinfo) {
  self notify("finished_deploy_weapon");
}

tryuseremotetank() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("pac_sentry", self);
  return tryuseremotetankfromstruct(streakinfo);
}

tryuseremotetankfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  _id_75D0DA8E536BC6E1 = _id_E6904A8315DB4476(streakinfo);

  if(!istrue(_id_75D0DA8E536BC6E1)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  _id_F79327D5641A9504 = _id_8DC34405ADAF04FE(streakinfo);
  level.incomingallremotetanks--;

  if(level.teambased)
    level.incomingremotetanks[self.team]--;

  if(!istrue(_id_F79327D5641A9504)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  result = starttankdropoff(streakinfo);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(!istrue(result)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/NOT_ENOUGH_SPACE");
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  return 1;
}

_id_E6904A8315DB4476(streakinfo) {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  _id_4440147083ABAF0A = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + _id_4440147083ABAF0A >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  level.incomingallremotetanks++;
  _id_3C73B886CEE8419D = 2;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_3C73B886CEE8419D = 4;

  if(level.remotetanks.size >= _id_3C73B886CEE8419D || level.remotetanks.size + level.incomingallremotetanks > _id_3C73B886CEE8419D) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    level.incomingallremotetanks--;
    return 0;
  }

  if(level.teambased) {
    _id_DEB1E3597303A7E6 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap())
      _id_DEB1E3597303A7E6 = 2;

    level.incomingremotetanks[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.remotetanks) + level.incomingremotetanks[self.team] > _id_DEB1E3597303A7E6) {
      level.incomingallremotetanks--;
      level.incomingremotetanks[self.team]--;
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
      return 0;
    }
  } else if(level.remotetanks.size > 0) {
    foreach(tank in level.remotetanks) {
      if(isDefined(tank.owner) && tank.owner == self) {
        level.incomingallremotetanks--;
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
        return 0;
      }
    }
  }

  if(level.gameended)
    return 0;

  return 1;
}

_id_8DC34405ADAF04FE(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  deployweaponobj = makeweapon("ks_remote_device_mp");
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::weapongivenremotetank, undefined, undefined, ::deployweapontaken);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  return 1;
}

starttankdropoff(streakinfo) {
  if(scripts\cp_mp\utility\player_utility::_id_F8789F15330DE751(self))
    return 0;

  position = _id_8ACEE201D15F4C71(100);

  if(!isDefined(position))
    return 0;

  scripts\mp\utility\player::_freezecontrols(1);
  _id_3B64EB40368C1450::set("tankDropOff", "fire", 0);
  tank = createtank("remote_tank", self, streakinfo, position);
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();

  if(!isDefined(tank)) {
    scripts\mp\utility\player::_freezecontrols(0);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tankDropOff");
    return 0;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tankDropOff");
  thread _id_CFD4851E4CA5B834(tank);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry", "pac_sentry_use", 1);
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "pac_sentry", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_pac_sentry", self);
  return 1;
}

createtank(tanktype, owner, streakinfo, _id_FB1DEF007972B25A) {
  _id_A84CFD847DC1F677 = level.tanksettings[tanktype];
  modelbase = _id_A84CFD847DC1F677.modelbase;
  vehicletype = _id_A84CFD847DC1F677.vehicleinfo;
  _id_C5012E0B9ADA53CA = getdvarint("dvar_A6581CFD5A4BF464", 1);
  angles = owner.angles;
  spawndata = spawnStruct();
  spawndata.origin = _id_FB1DEF007972B25A;
  spawndata.angles = angles;
  spawndata.modelname = modelbase;
  spawndata.targetname = tanktype;
  spawndata.vehicletype = vehicletype;
  spawndata.owner = owner;
  spawndata.cannotbesuspended = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  _id_F5E7C5E12051B3EB = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(_id_F5E7C5E12051B3EB))
    return undefined;

  _id_EBBE5C4D79905B3D = getdvarint("dvar_D429FA03FD7003AD", _id_A84CFD847DC1F677.timeout);
  _id_F5E7C5E12051B3EB.team = owner.team;
  _id_F5E7C5E12051B3EB.teamfriendlyto = owner.team;
  _id_F5E7C5E12051B3EB.owner = owner;
  _id_F5E7C5E12051B3EB.playerfriendlyto = owner;
  _id_F5E7C5E12051B3EB.streakinfo = streakinfo;
  _id_F5E7C5E12051B3EB.tanktype = tanktype;
  _id_F5E7C5E12051B3EB.config = _id_A84CFD847DC1F677;
  _id_F5E7C5E12051B3EB.maxhealth = _id_A84CFD847DC1F677.maxhealth;
  _id_F5E7C5E12051B3EB.health = _id_A84CFD847DC1F677.maxhealth;
  _id_F5E7C5E12051B3EB.currenthealth = _id_A84CFD847DC1F677.maxhealth;
  _id_F5E7C5E12051B3EB.lifetime = _id_EBBE5C4D79905B3D;
  _id_F5E7C5E12051B3EB._id_D8943D63EC472996 = _id_C5012E0B9ADA53CA;
  _id_F5E7C5E12051B3EB setotherent(owner);
  _id_F5E7C5E12051B3EB setvehicleteam(_id_F5E7C5E12051B3EB.team);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(_id_F5E7C5E12051B3EB, owner, ::_id_4334ACE787C46D9E);
  _id_F5E7C5E12051B3EB._id_93D37DECDFE9BE3D = _id_F5E7C5E12051B3EB vehicle_gettopspeedforward();
  _id_F5E7C5E12051B3EB._id_9FEF0F6069126B26 = _id_F5E7C5E12051B3EB vehicle_gettopspeedreverse();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("remoteTank", "attachXRays"))
    _id_F5E7C5E12051B3EB = [[scripts\cp_mp\utility\script_utility::getsharedfunc("remoteTank", "attachXRays")]](_id_F5E7C5E12051B3EB);

  killcament = spawn("script_model", _id_F5E7C5E12051B3EB gettagorigin("tag_aim"));
  killcament.angles = _id_F5E7C5E12051B3EB gettagangles("tag_aim");
  killcament linkTo(_id_F5E7C5E12051B3EB, "tag_aim", (-5, 0, 0), (0, 0, 0));
  killcament setscriptmoverkillcam("turret");
  _id_F5E7C5E12051B3EB.killcament = killcament;
  _id_F5E7C5E12051B3EB scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", owner);
  _id_F5E7C5E12051B3EB _id_DE3E4E392C558D37(streakinfo.streakname);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(_id_F5E7C5E12051B3EB, ::_id_7FA9ED782D7C0734);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(_id_F5E7C5E12051B3EB, ::_id_13A9B220F9377BBA);
  _id_F5E7C5E12051B3EB scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  _id_F5E7C5E12051B3EB thread _id_371A76C203BDC938();
  _id_F5E7C5E12051B3EB thread _id_7F192A2A47CF2A7D();
  _id_F5E7C5E12051B3EB thread _id_DA556E71229FA017();
  _id_F5E7C5E12051B3EB thread _id_1DCEE2AB6D1348C2();
  _id_F5E7C5E12051B3EB.childoutlineents = [_id_F5E7C5E12051B3EB];

  if(_id_F5E7C5E12051B3EB._id_D8943D63EC472996 == 0) {
    _id_6EC4C83E2DED9D38 = _id_F5E7C5E12051B3EB gettagorigin("tag_turret");
    mgturret = spawnturret("misc_turret", _id_6EC4C83E2DED9D38, _id_A84CFD847DC1F677.weaponinfo, 0);
    mgturret linkTo(_id_F5E7C5E12051B3EB, "tag_turret", (0, 0, 0), (0, 0, 0));
    mgturret setModel(_id_A84CFD847DC1F677.turretmodel);
    mgturret.owner = owner;
    mgturret.angles = _id_F5E7C5E12051B3EB.angles;
    mgturret.tank = _id_F5E7C5E12051B3EB;
    mgturret.overheated = 0;
    mgturret.streakinfo = streakinfo;
    mgturret disableplayeruseforallplayers();
    mgturret setdefaultdroppitch(0);
    mgturret setmode(_id_A84CFD847DC1F677.sentrymodeoff);
    mgturret setotherent(owner);
    mgturret setturretowner(owner);
    mgturret setturretteam(owner.team);
    _id_F5E7C5E12051B3EB.mgturret = mgturret;
    _id_F5E7C5E12051B3EB.childoutlineents[_id_F5E7C5E12051B3EB.childoutlineents.size] = mgturret;
  }

  _id_F5E7C5E12051B3EB thread _id_A46005E27C92C2CA();
  _id_F5E7C5E12051B3EB thread _id_04048C2CA00C4690();
  _id_F5E7C5E12051B3EB thread _id_CBA0065C10AC9099();
  _id_405425B0F7DA50DC = "daytime";

  if(level.mapname == "mp_grandprix_pm_2" || scripts\cp_mp\utility\game_utility::isnightmap())
    _id_405425B0F7DA50DC = "nighttime";

  _id_F5E7C5E12051B3EB setscriptablepartstate("lights", _id_405425B0F7DA50DC, 0);
  scripts\mp\outofbounds::registerentforoob(_id_F5E7C5E12051B3EB, "killstreak");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(_id_F5E7C5E12051B3EB, owner, owner.team);
  level.remotetanks[level.remotetanks.size] = _id_F5E7C5E12051B3EB;
  _id_F5E7C5E12051B3EB scripts\mp\utility\killstreak::addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Ground", owner, 0, 1, 60);
  level notify("matchrecording_small_ground_vehicle", _id_F5E7C5E12051B3EB);
  return _id_F5E7C5E12051B3EB;
}

_id_DE3E4E392C558D37(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_89445073F3E86E5C;
  _id_191284E2E2837328 = ::_id_E2797FDB403C45E0;
  _id_BACC6DD14316758C = ::_id_944F35A106CF0B72;
  _id_7DA88D9C69433487 = ::_id_75AB8F8D5F7AFF1D;
  deathcallback = ::_id_C2A6845F0336B0F1;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 2750, ::_id_30214D9FF0A7EC22);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 1500, ::_id_D0FC0DDCBAEEF567);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 500, ::_id_B89384926B7B6217);
}

_id_89445073F3E86E5C(streakname) {
  config = level.tanksettings[self.tanktype];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, config.hitstokill);
}

_id_E2797FDB403C45E0(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 18;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 25;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 7;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 8;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "c4_mp";
  weaponhitsperattack = 5;
  _id_8B4500D6A881B7B2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_7FA9ED782D7C0734() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

_id_13A9B220F9377BBA() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

_id_CFD4851E4CA5B834(_id_F5E7C5E12051B3EB) {
  level endon("game_ended");
  self endon("disconnect");
  self disablephysicaldepthoffieldscripting();
  self.restoreangles = self getplayerangles();
  _id_F5E7C5E12051B3EB scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  data = spawnStruct();
  data.deathoverridecallback = ::_id_F49E3A7CFDB07F52;
  _id_F5E7C5E12051B3EB thread scripts\mp\movers::handle_moving_platforms(data);
  _id_F5E7C5E12051B3EB setotherent(self);

  if(_id_F5E7C5E12051B3EB._id_D8943D63EC472996 == 0)
    _id_F5E7C5E12051B3EB setentityowner(self);

  _id_F5E7C5E12051B3EB.driver = self;
  _id_F5E7C5E12051B3EB.ispiloted = 1;
  self unlink();

  if(isDefined(_id_F5E7C5E12051B3EB.empcount) && _id_F5E7C5E12051B3EB.empcount > 0)
    scripts\mp\utility\player::_freezelookcontrols(1);
  else if(_id_F5E7C5E12051B3EB._id_D8943D63EC472996 == 0) {
    self controlslinkTo(_id_F5E7C5E12051B3EB);
    self remotecontrolturret(_id_F5E7C5E12051B3EB.mgturret);
  } else {
    if(_id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::is_empd())
      _id_DB443C859C55E450(1);

    _id_F5E7C5E12051B3EB vehicle_turnengineon();
    self usevehicle(_id_F5E7C5E12051B3EB, 0);
  }

  _id_F5E7C5E12051B3EB.controlslinked = 1;
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  _id_B929075EC07DCE71 = 1;
  _id_A6F4657E2F8D1D39 = "third_person_hud_on";

  if(isDefined(self.previousremotetankviewstate)) {
    _id_B929075EC07DCE71 = self.previousremotetankviewstate;

    if(_id_A6F4657E2F8D1D39 == 2)
      _id_A6F4657E2F8D1D39 = "first_person_hud_on";
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(_id_F5E7C5E12051B3EB.streakinfo.streakname, _id_A6F4657E2F8D1D39);
  self setclientomnvar("ui_pac_sentry_controls", _id_B929075EC07DCE71);
  self setclientomnvar("ui_pac_sentry_speed", 0);
  self setclientomnvar("ui_killstreak_health", _id_F5E7C5E12051B3EB.health / _id_F5E7C5E12051B3EB.maxhealth);
  self setclientomnvar("ui_killstreak_damage_state", 0);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  _id_3B64EB40368C1450::set("remoteTank", "shellshock", 0);
  scripts\mp\outofbounds::registerentforoob(_id_F5E7C5E12051B3EB, "killstreak");
  _id_F5E7C5E12051B3EB thread _id_6F3F7278C3E229D7();
  _id_3B64EB40368C1450::set("remoteTank_spawn", "player_for_spawn_logic", 0);
  scripts\mp\spawnlogic::addspawnviewer(_id_F5E7C5E12051B3EB);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_766F7C743D266217);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_A05D4CD1FE21C586);
  _id_F5E7C5E12051B3EB _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_F149E9383F183CF0);
  _id_F5E7C5E12051B3EB _id_736DEC95A49487A6::_id_AA823A31304ED981(::_id_005C67FA91FE5B79);
  scripts\mp\utility\player::_freezecontrols(0);
}

_id_944F35A106CF0B72(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_75AB8F8D5F7AFF1D(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(self.owner) && self.owner scripts\mp\utility\player::isusingremote()) {
    if(isexplosivedamagemod(type)) {
      if(ceil(damage / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.origin, 150);
        self.owner playrumbleonpositionforclient("damage_heavy", self.owner getEye());
      }
    } else {
      self.owner earthquakeforplayer(0.15, 0.15, self.origin, 150);
      self.owner playrumbleonpositionforclient("damage_light", self.owner getEye());
    }
  }

  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_30214D9FF0A7EC22() {
  self setscriptablepartstate("body_damage_light", "on", 0);
}

_id_D0FC0DDCBAEEF567() {
  self setscriptablepartstate("body_damage_medium", "on", 0);
}

_id_B89384926B7B6217() {
  self setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("turret_damage", "on", 0);
}

_id_C2A6845F0336B0F1(data) {
  self.killedbyweapon = data.objweapon;
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry", "pac_sentry_destroyed", 1);
  thread _id_4334ACE787C46D9E();
  return 0;
}

_id_F49E3A7CFDB07F52(data) {
  thread _id_4334ACE787C46D9E();
}

_id_371A76C203BDC938() {
  self endon("death");
  level endon("game_ended");
  thread _id_7F60B3159041388A();
  _id_CEE9BE98157CD644();
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry", "pac_sentry_timeout", 1);
  thread _id_4334ACE787C46D9E();
}

_id_7F60B3159041388A() {
  self endon("death");
  _id_ED6F9375A4009DE4 = self.owner;

  if(!isDefined(_id_ED6F9375A4009DE4)) {
    return;
  }
  _id_ED6F9375A4009DE4 endon("disconnect");
  _id_ED6F9375A4009DE4 endon("joined_team");
  _id_ED6F9375A4009DE4 endon("joined_spectators");
  _id_ED6F9375A4009DE4 endon("team_kill_punish");

  for(;;) {
    _id_ED6F9375A4009DE4 waittill("player_fatal_death");

    if(istrue(self.ispiloted)) {
      thread _id_66CD16D1EA616B67();
      continue;
    }

    thread _id_4334ACE787C46D9E();
  }
}

_id_CEE9BE98157CD644() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("team_kill_punish");
  level endon("game_ended");
  self.owner setclientomnvar("ui_killstreak_countdown", 100);
  timeelapsed = 0;
  timeoutduration = self.lifetime;

  while(timeelapsed < timeoutduration) {
    _id_77B3F0514A25C019 = (timeoutduration - timeelapsed) / timeoutduration;
    _id_77B3F0514A25C019 = int(ceil(clamp(_id_77B3F0514A25C019, 0, 1) * 100));

    if(istrue(self.ispiloted))
      self.owner setclientomnvar("ui_killstreak_countdown", _id_77B3F0514A25C019);

    timeelapsed = timeelapsed + level.framedurationseconds;
    waitframe();
  }
}

_id_7F192A2A47CF2A7D() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("start_game_ended", "game_ended");
  thread _id_4334ACE787C46D9E();
}

_id_4334ACE787C46D9E(attacker, _id_4FAC8B8CE36E09F1) {
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];

  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("death");
  self.controlslinked = undefined;

  if(self._id_D8943D63EC472996 == 0) {
    self.mgturret setturretowner(undefined);
    self.mgturret notify("kill_turret");
    self.mgturret notify("death");
    self.mgturret setmode(_id_A84CFD847DC1F677.sentrymodeoff);
  }

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(!isDefined(attacker))
    attacker = self.owner;

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  if(isDefined(self.driver))
    self.driver thread _id_FD5A2CA6A710C2C8(self);

  self playSound("veh_ks_wheelson_explode");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();

  if(self._id_D8943D63EC472996 == 0) {
    if(isDefined(self.mgturret))
      self.mgturret delete();
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  level.remotetanks = scripts\engine\utility::array_remove(level.remotetanks, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_FD5A2CA6A710C2C8(tank) {
  self endon("disconnect");
  _id_A84CFD847DC1F677 = level.tanksettings[tank.tanktype];
  tank _id_13A9B220F9377BBA();

  if(isDefined(tank.empcount) && tank.empcount > 0)
    scripts\mp\utility\player::_freezelookcontrols(0);

  tank setotherent(undefined);
  tank.driver = undefined;
  tank.ispiloted = undefined;

  if(tank._id_D8943D63EC472996 == 0) {
    tank setentityowner(undefined);
    self controlsunlink();
    self remotecontrolturretoff(tank.mgturret);
  } else {
    tank _id_DB443C859C55E450(0);
    self _meth_C0505F05660D120C(0);
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(tank.streakinfo.streakname, "off");
  self setclientomnvar("ui_pac_sentry_controls", 0);

  if(scripts\mp\utility\player::isusingremote())
    tank.streakinfo notify("killstreak_finished_with_deploy_weapon");

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remoteTank_spawn");
  scripts\mp\spawnlogic::removespawnviewer(tank);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remoteTank");
    level thread scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles(self);
  }
}

_id_717645AD31E6B064() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", projectile);
    projectile.owner = self.owner;
    projectile.streakinfo = self.streakinfo;
    _id_FCF66A83D8283EA1 = spawn("script_model", projectile.origin);
    _id_FCF66A83D8283EA1 setModel("ks_pac_sentry_mp");
    _id_FCF66A83D8283EA1.angles = projectile.angles;
    _id_FCF66A83D8283EA1.team = self.team;
    _id_FCF66A83D8283EA1.owner = self.owner;
    _id_FCF66A83D8283EA1.streakinfo = self.streakinfo;
    _id_FCF66A83D8283EA1 setentityowner(self.owner);
    _id_FCF66A83D8283EA1 dontinterpolate();
    self.streakinfo.shots_fired++;
    _id_93C80DDC3857D00D(projectile, _id_FCF66A83D8283EA1);
  }
}

_id_93C80DDC3857D00D(_id_EE356ED81B5CB7F4, _id_FCF66A83D8283EA1) {
  _id_5C2475D41219F077 = anglesToForward(_id_EE356ED81B5CB7F4.angles);
  startpos = _id_EE356ED81B5CB7F4.origin;
  endpos = startpos + _id_5C2475D41219F077 * 22500;
  ignorelist = [_id_EE356ED81B5CB7F4, _id_FCF66A83D8283EA1, self.owner];
  _id_9E4EE1C6E5812DE2 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  _id_E5354BE82A7990D5 = scripts\engine\trace::sphere_trace_get_all_results(startpos, endpos, 60, ignorelist, _id_9E4EE1C6E5812DE2);
  _id_B443B8BF31B2425E = 0;

  if(isDefined(_id_E5354BE82A7990D5[0])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E5354BE82A7990D5.size - 1; _id_AC0E594AC96AA3A8++) {
      _id_BD73C7ACC56CD20C = _id_E5354BE82A7990D5[_id_AC0E594AC96AA3A8]["entity"];
      _id_77861A4668FF91E7 = _id_E5354BE82A7990D5[_id_AC0E594AC96AA3A8]["position"];
      _id_3C70094ED665A389 = _id_E5354BE82A7990D5[_id_AC0E594AC96AA3A8]["shape_position"];

      if(isDefined(_id_BD73C7ACC56CD20C)) {
        if(level.teambased) {
          if(_id_BD73C7ACC56CD20C.team == _id_FCF66A83D8283EA1.team)
            continue;
        }

        if(!scripts\engine\trace::ray_trace_passed(_id_3C70094ED665A389, _id_77861A4668FF91E7, _id_FCF66A83D8283EA1))
          continue;
      }

      _id_B443B8BF31B2425E = 1;
      _id_42F65B4B53C1F5D4 = distance(startpos, _id_3C70094ED665A389) / 7500;
      _id_EE356ED81B5CB7F4 thread _id_21526388CE8CFE7C(_id_77861A4668FF91E7, _id_3C70094ED665A389, _id_42F65B4B53C1F5D4, _id_FCF66A83D8283EA1, self);
      break;
    }
  }

  if(!istrue(_id_B443B8BF31B2425E)) {
    if(isDefined(_id_FCF66A83D8283EA1))
      _id_FCF66A83D8283EA1 delete();
  }
}

_id_21526388CE8CFE7C(_id_77861A4668FF91E7, _id_3C70094ED665A389, _id_42F65B4B53C1F5D4, _id_FCF66A83D8283EA1, tank) {
  level endon("game_ended");

  if(isDefined(self))
    self delete();

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_42F65B4B53C1F5D4);
  _id_FCF66A83D8283EA1.origin = _id_3C70094ED665A389;
  _id_FCF66A83D8283EA1 setscriptablepartstate("airburst", "airExpl");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](_id_3C70094ED665A389, 100, 100, _id_FCF66A83D8283EA1.team, 1, _id_FCF66A83D8283EA1.owner, 1);

  _id_FCF66A83D8283EA1 thread _id_0A2D262A682AD5E0();
}

_id_1DCEE2AB6D1348C2() {
  level endon("game_ended");
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  holdtime = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587(), 0.01, 0.25);
  self._id_DF66BD377221E9B5 = 0;
  _id_EFE526BF6A23D275 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_EFE526BF6A23D275 = "hud_icon_killstreak_wheelson";

  scripts\cp_mp\utility\killstreak_utility::_id_E68434BDB941ED1E(self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/REMOTE_TANK_SENTRY_OFF", undefined, _id_EFE526BF6A23D275);

  if(isDefined(self.useobj))
    self.useobj setuseholdduration(250);

  while(isDefined(self)) {
    if(!istrue(self._id_DF66BD377221E9B5)) {
      _id_23B90B34FECC58CD = 0;

      while(isDefined(self) && isDefined(self.owner) && self.owner useButtonPressed()) {
        _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;

        if(!istrue(self._id_DF66BD377221E9B5))
          self.owner setclientomnvar("ui_exit_progress", _id_23B90B34FECC58CD / holdtime);

        if(_id_23B90B34FECC58CD >= holdtime) {
          _id_66CD16D1EA616B67();
          break;
        }

        wait(_id_038FC7BD1495C4B2);
      }

      if(isDefined(self) && isDefined(self.owner) && !istrue(self._id_DF66BD377221E9B5))
        self.owner setclientomnvar("ui_exit_progress", 0);
    } else {
      if(isDefined(self.useobj))
        self.useobj waittill("trigger", player);

      _id_BD237957848037C8();
    }

    waitframe();
  }
}

_id_44208C5A6449E697(target) {
  if(!isDefined(target))
    return 0;

  if(isPlayer(target)) {
    if(isDefined(self) && isDefined(target.team) && isDefined(self._id_1329597B4278AFE9) && scripts\engine\utility::array_contains(self._id_1329597B4278AFE9, target.team))
      return 0;

    if(!target scripts\cp_mp\utility\player_utility::_isalive() || target.sessionstate != "playing")
      return 0;

    if(istrue(target.notarget))
      return 0;

    if(target == self.owner)
      return 0;

    if(!isDefined(target.pers["team"]))
      return 0;

    if(target.pers["team"] == "spectator")
      return 0;

    if(level.teambased) {
      if(target.pers["team"] == self.team)
        return 0;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(target[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye"))
        return 0;
    }

    if(isDefined(target.team) && isDefined(self._id_1329597B4278AFE9) && scripts\engine\utility::array_contains(self._id_1329597B4278AFE9, target.team))
      return 0;
  } else if(isagent(target)) {
    if(!isalive(target))
      return 0;

    if(isDefined(target.agent_type) && issubstr(target.agent_type, "civilian"))
      return 0;

    _id_DA8CEC9BCE12F9CB = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(target, "team");

    if(!isDefined(_id_DA8CEC9BCE12F9CB))
      _id_DA8CEC9BCE12F9CB = target.team;

    if(level.teambased) {
      if(isDefined(_id_DA8CEC9BCE12F9CB) && _id_DA8CEC9BCE12F9CB == self.team)
        return 0;
    }
  }

  return self vehicle_canturrettargetpoint(target gettagorigin("j_mainroot"), 1, self);
}

_id_D8FF9AB17CBA9862() {
  _id_1E79B4675C5AA7F9 = undefined;
  _id_84D4866087B00608 = undefined;
  _id_C81C8E185FC6D4EB = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, 4096);

  foreach(target in _id_C81C8E185FC6D4EB) {
    if(!_id_44208C5A6449E697(target)) {
      continue;
    }
    distsq = distancesquared(target.origin, self.origin);

    if(!isDefined(_id_1E79B4675C5AA7F9) || distsq < _id_84D4866087B00608) {
      _id_1E79B4675C5AA7F9 = target;
      _id_84D4866087B00608 = distsq;
    }
  }

  self._id_80C53303FB317FE2 = _id_1E79B4675C5AA7F9;
}

_id_B1CCAB9347662A31() {
  self endon("death");
  self endon("entering_control");
  self.owner endon("disconnect");
  level endon("game_ended");
  _id_03807E28E9F5CD57 = 0;

  for(;;) {
    if(istrue(self._id_158F2FB396C0CCCB)) {
      waitframe();
      continue;
    }

    _id_4586E4603EE41CDE = self._id_80C53303FB317FE2;
    _id_D8FF9AB17CBA9862();

    if(isDefined(self._id_80C53303FB317FE2)) {
      self setturrettargetEnt(self._id_80C53303FB317FE2, self._id_80C53303FB317FE2 gettagorigin("j_mainroot") - self._id_80C53303FB317FE2.origin);

      while(_id_44208C5A6449E697(self._id_80C53303FB317FE2) && !_id_05323B44EE395058::_id_BB61346FDA4278E5(self, self._id_80C53303FB317FE2, "j_mainroot", 5))
        waitframe();

      if(_id_44208C5A6449E697(self._id_80C53303FB317FE2)) {
        _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
        firetime = weaponfiretime(_id_A84CFD847DC1F677.weaponinfo);
        _id_3746EC1BEFD86AE8 = _id_A84CFD847DC1F677.burstmin;
        _id_3E92CD336A99CE02 = _id_A84CFD847DC1F677.burstmax;
        _id_5F622C39D6661B23 = _id_A84CFD847DC1F677.pausemin;
        _id_42AE243CD994C3BD = _id_A84CFD847DC1F677.pausemax;
        _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);
        _id_416E1C2F79FCE693(_id_A84CFD847DC1F677);

        while(_id_44208C5A6449E697(self._id_80C53303FB317FE2) && _id_89F949A75D92E1A4 > 0) {
          self fireweapon();
          _id_89F949A75D92E1A4--;
          self.streakinfo.shots_fired++;
          wait(firetime);
        }

        wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
      }

      continue;
    }

    _id_6ADD0F629E59F222();
    _id_941D89BD45430FF7 = randomfloatrange(-5 + 180 * _id_03807E28E9F5CD57, 5 + 180 * _id_03807E28E9F5CD57);
    _id_03807E28E9F5CD57++;
    _id_03807E28E9F5CD57 = _id_03807E28E9F5CD57 % 2;
    targetangles = (0, _id_941D89BD45430FF7, 0);
    _id_C0686995758526DE = anglesToForward(targetangles);
    start = self.origin + (0, 0, 16);
    end = start + 1000.0 * _id_C0686995758526DE;
    self setturrettargetvec(end);
    scripts\engine\utility::waittill_any_timeout_1(2.0, "turret_on_target");
    wait 0.25;
  }
}

_id_416E1C2F79FCE693(_id_A84CFD847DC1F677) {
  self endon("death");
  spinuptime = _id_A84CFD847DC1F677.spinuptime;
  self laseron();
  thread scripts\cp_mp\killstreaks\sentry_gun::sentry_targetlocksound();
  self _meth_EE85446AFC7CB0A8(1);
  self._id_4863A1B39F3E20F5 = 1;

  while(_id_44208C5A6449E697(self._id_80C53303FB317FE2) && spinuptime > 0) {
    spinuptime = spinuptime - 0.05;
    wait 0.05;
  }
}

_id_6ADD0F629E59F222() {
  if(istrue(self._id_4863A1B39F3E20F5)) {
    self laseroff();
    self _meth_EE85446AFC7CB0A8(0);
    self._id_4863A1B39F3E20F5 = undefined;
  }
}

_id_66CD16D1EA616B67() {
  self endon("death");
  self.owner endon("disconnect");

  if(istrue(self.destroyed)) {
    return;
  }
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
  childthread _id_79479FF61F57B90B();
  self.owner _id_FD5A2CA6A710C2C8(self);
  self notify("leaving_control");
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry", "pac_sentry_sentry", 1);
  _id_3C864CEE6CA51E89(1);

  if(self._id_D8943D63EC472996 == 0) {
    self.mgturret setmode(_id_A84CFD847DC1F677.sentrymodeon);
    self.mgturret thread scripts\cp_mp\killstreaks\sentry_gun::sentry_attacktargets(_id_A84CFD847DC1F677);
  } else
    thread _id_B1CCAB9347662A31();

  self._id_DF66BD377221E9B5 = 1;
  self setscriptablepartstate("auto_spin_sfx", "on");
  scripts\cp_mp\utility\killstreak_utility::_id_86FF095469A70CD2();
}

_id_79479FF61F57B90B() {
  level endon("game_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_3F55C1FB553A4775(self.owner, self.useobj);
  wait 0.1;
  scripts\cp_mp\utility\killstreak_utility::_id_17576A4CDCD447A7(self.owner);
}

_id_BD237957848037C8() {
  self.owner endon("disconnect");
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
  streakinfo = self.streakinfo;
  deployweaponobj = makeweapon("ks_remote_device_mp");
  _id_9B1DEB5E9D32BBE3 = self.owner scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(self.streakinfo, ::weapongivenremotetank, undefined, undefined, ::deployweapontaken, undefined, undefined, undefined, 0, 1);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    self.owner scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_RECONNECT");
    return;
  }

  if(!isDefined(self) || istrue(self.destroyed)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return;
  }

  if(self._id_D8943D63EC472996 == 0) {
    self.mgturret setmode(_id_A84CFD847DC1F677.sentrymodeoff);
    self.mgturret notify("kill_turret");
  } else {
    self notify("entering_control");
    self clearturrettarget();
  }

  _id_3C864CEE6CA51E89(0);
  self setscriptablepartstate("auto_spin_sfx", "off");
  self.owner _id_CFD4851E4CA5B834(self);
  self._id_DF66BD377221E9B5 = 0;
  scripts\cp_mp\utility\killstreak_utility::_id_A91EBB0263D086F3();
}

_id_3C864CEE6CA51E89(_id_93C07017FA762D2B) {
  _id_0698544664D21F59 = self _meth_962A6476FE1C33EE();

  if(isDefined(_id_0698544664D21F59)) {
    if(_id_0698544664D21F59 == "veh_amphibious_water") {
      if(istrue(_id_93C07017FA762D2B))
        self _meth_481C2A63F2BA3332(-1, 0, 0);
      else
        self _meth_481C2A63F2BA3332(0);
    } else
      self _meth_65AA053C077C003A(_id_93C07017FA762D2B);
  }

  if(istrue(_id_93C07017FA762D2B))
    _id_C5B2E0BB2A8D5F68();
}

_id_0A2D262A682AD5E0() {
  self endon("death");
  self.dying = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

_id_DA556E71229FA017() {
  self endon("death");
  _id_2BDC3E3680DF74EB = 0;

  for(;;) {
    _id_E466656788B2BDE5 = self vehicle_getspeed();
    _id_46C9A177682CFDD2 = _id_E466656788B2BDE5 * 1.60934;

    if(_id_E466656788B2BDE5 > 1 && !istrue(_id_2BDC3E3680DF74EB)) {
      _id_2BDC3E3680DF74EB = 1;
      self setscriptablepartstate("dust", "on");
    } else if(_id_E466656788B2BDE5 <= 1 && istrue(_id_2BDC3E3680DF74EB)) {
      _id_2BDC3E3680DF74EB = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(_id_46C9A177682CFDD2));
    waitframe();
  }
}

_id_CBA0065C10AC9099() {
  self endon("death");
  level endon("game_ended");
  thread _id_C495D6715028BEDF();

  for(;;) {
    if(istrue(self._id_DF66BD377221E9B5)) {
      waitframe();
      continue;
    }

    driver = self.owner;

    if(isDefined(driver)) {
      _id_F619FE4A4E1D4868 = driver getnormalizedmovement();
      _id_58724D69CA657B30 = abs(_id_F619FE4A4E1D4868[0]);

      if(_id_58724D69CA657B30 >= 0.15)
        _id_CF71EB6E0611096C();
      else
        _id_C5B2E0BB2A8D5F68();
    } else
      _id_C5B2E0BB2A8D5F68();

    waitframe();
  }
}

_id_CF71EB6E0611096C() {
  self endon("death");
  self endon("wheelson_stop_engine");
  level endon("game_ended");

  if(istrue(self.engine_audio_active)) {
    return;
  }
  self.engine_audio_active = 1;
  self playsoundonmovingent("veh_wheelson_engine_start");
  wait 0.5;
  self playLoopSound("veh_wheelson_engine_lp");
}

_id_C5B2E0BB2A8D5F68(_id_FCEF8D217A441961) {
  if(istrue(_id_FCEF8D217A441961)) {
    self notify("wheelson_stop_engine");
    self.engine_audio_active = undefined;
    self stoploopsound("veh_wheelson_engine_lp");
  } else if(istrue(self.engine_audio_active)) {
    self notify("wheelson_stop_engine");
    self endon("wheelson_stop_engine");
    self.engine_audio_active = undefined;
    self playsoundonmovingent("veh_wheelson_engine_stop");
    wait 0.5;

    if(isDefined(self))
      self stoploopsound("veh_wheelson_engine_lp");
  }
}

_id_C495D6715028BEDF() {
  self endon("death");
  level waittill("game_ended");
  thread _id_C5B2E0BB2A8D5F68();
}

_id_766F7C743D266217(data) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker))
    data.attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E5CE77CFAE268AB3");

  self._id_158F2FB396C0CCCB = 1;

  if(istrue(self.ispiloted))
    _id_DB443C859C55E450(1);

  self vehicle_turnengineoff();

  if(isPlayer(self.owner))
    thread scripts\cp_mp\emp_debuff::play_scramble_for_player_until_cleared(self.owner, 5);
}

_id_DB443C859C55E450(_id_E60552DD6ABCC4AA) {
  _id_E796719320E13E49 = self _meth_01E8542A707A8002("p2p");

  if(!_id_E796719320E13E49) {
    self.owner scripts\mp\utility\player::_freezelookcontrols(_id_E60552DD6ABCC4AA);
    self.owner scripts\mp\utility\player::_freezecontrols(_id_E60552DD6ABCC4AA);
  }

  _id_E4ADB8DFBD1E62DD(_id_E60552DD6ABCC4AA, _id_E796719320E13E49);
}

_id_E4ADB8DFBD1E62DD(_id_E2A66DD8A90FBD3F, _id_E796719320E13E49) {
  if(_id_E2A66DD8A90FBD3F) {
    if(_id_E796719320E13E49)
      self _meth_77320E794D35465A("p2p", "pause", 1);
    else {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("movementDisabled", self.owner, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
      self _meth_64D8AE560C3EC9B6(1);
      self.veh_throttle = 0;
    }
  } else if(_id_E796719320E13E49)
    self _meth_77320E794D35465A("p2p", "resume", 1);
  else {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("movementDisabled", self.owner, scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
    self _meth_64D8AE560C3EC9B6(0);
  }
}

_id_A05D4CD1FE21C586(_id_B3990D56E2779F79) {
  if(!isDefined(self.owner)) {
    return;
  }
  self vehicle_turnengineon();
  self._id_158F2FB396C0CCCB = 0;

  if(!istrue(_id_B3990D56E2779F79) && istrue(self.ispiloted))
    _id_DB443C859C55E450(0);
}

_id_F149E9383F183CF0(data) {
  _id_8A28FD9DF2F03764 = data.victim;

  if(!isDefined(_id_8A28FD9DF2F03764)) {
    return;
  }
  if(!isDefined(_id_8A28FD9DF2F03764.owner)) {
    return;
  }
  if(istrue(_id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8)) {
    return;
  }
  _id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8 = 1;
  _id_8A28FD9DF2F03764 thread _id_E6CBF8131B64E6DB();
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", _id_8A28FD9DF2F03764.owner, _id_8A28FD9DF2F03764.vehiclename);
  _id_8A28FD9DF2F03764 vehicle_settopspeedforward(_id_8A28FD9DF2F03764._id_93D37DECDFE9BE3D / 3);
  _id_8A28FD9DF2F03764 vehicle_settopspeedreverse(_id_8A28FD9DF2F03764._id_9FEF0F6069126B26 / 3);
}

_id_005C67FA91FE5B79(data) {
  _id_8A28FD9DF2F03764 = data.victim;

  if(!isDefined(_id_8A28FD9DF2F03764)) {
    return;
  }
  if(!isDefined(_id_8A28FD9DF2F03764.owner)) {
    return;
  }
  _id_8A28FD9DF2F03764 vehicle_settopspeedforward(_id_8A28FD9DF2F03764._id_93D37DECDFE9BE3D);
  _id_8A28FD9DF2F03764 vehicle_settopspeedreverse(_id_8A28FD9DF2F03764._id_9FEF0F6069126B26);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("shockStickAttached", _id_8A28FD9DF2F03764.owner, _id_8A28FD9DF2F03764.vehiclename);
  _id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8 = 0;
}

_id_E6CBF8131B64E6DB() {
  level endon("game_ended");
  self.owner endon("disconnect");
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
  firetime = weaponfiretime(_id_A84CFD847DC1F677.weaponinfo);
  childthread _id_4973F20495F7D1FF(firetime);
  self._id_158F2FB396C0CCCB = 1;

  if(!isDefined(self.driver)) {
    self clearturrettarget();
    self._id_80C53303FB317FE2 = undefined;
  }

  msg = scripts\engine\utility::waittill_any_return_2("death", "haywire_cleared");
  self._id_158F2FB396C0CCCB = undefined;
}

_id_4973F20495F7D1FF(firetime) {
  self endon("death");
  self endon("haywire_cleared");

  for(;;) {
    self fireweapon();
    wait(firetime);
  }
}

_id_6F3F7278C3E229D7() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  for(;;) {
    self.owner earthquakeforplayer(0.05, 0.05, self gettagorigin("tag_body"), 500);
    wait 0.05;
  }
}

_id_8ACEE201D15F4C71(spawndist) {
  result = undefined;
  startpos = self.origin;
  startang = self.angles;
  forward = anglesToForward(startang);
  right = anglestoright(startang);
  _id_07DDDF03B37D511F = [startpos + spawndist * forward, startpos - spawndist * forward, startpos + spawndist * right, startpos - spawndist * right, startpos + 0.707 * spawndist * (forward + right), startpos + 0.707 * spawndist * (forward - right), startpos + 0.707 * spawndist * (right - forward), startpos + 0.707 * spawndist * (-1 * forward - right)];

  foreach(_id_850A0F04F8EDABA5 in _id_07DDDF03B37D511F) {
    result = _id_A03FD14F53C89E53(startpos, _id_850A0F04F8EDABA5);

    if(isDefined(result)) {
      break;
    }
  }

  return result;
}

_id_A03FD14F53C89E53(startpoint, spawnpoint) {
  result = undefined;
  zoffset = (0, 0, 45);
  _id_1BFA180C6FDD09DD = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  tracestart = startpoint + zoffset;
  _id_8B39E5984DA1FFAF = spawnpoint + zoffset;
  _id_DDEB1B8D9D4632E6 = 40;
  _id_CB0A84B6D7F42D67 = scripts\engine\trace::ray_trace_passed(tracestart, _id_8B39E5984DA1FFAF, self, _id_1BFA180C6FDD09DD);

  if(!istrue(_id_CB0A84B6D7F42D67))
    return result;

  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(_id_8B39E5984DA1FFAF, _id_8B39E5984DA1FFAF - (0, 0, 500), level.players, _id_1BFA180C6FDD09DD);

  if(isDefined(_id_0DB1541018D7BADF["position"]) && _id_0DB1541018D7BADF["hittype"] != "hittype_none") {
    _id_FC168E598E8265AE = _id_0DB1541018D7BADF["position"] + zoffset;
    _id_2DB6453133B55E73 = scripts\engine\trace::sphere_trace_passed(_id_FC168E598E8265AE, _id_FC168E598E8265AE, _id_DDEB1B8D9D4632E6, level.players, _id_1BFA180C6FDD09DD);
    _id_DA8CEC9BCE12F9CB = undefined;

    if(level.teambased)
      _id_DA8CEC9BCE12F9CB = self.team;

    if(istrue(_id_2DB6453133B55E73) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_0DB1541018D7BADF["position"], _id_DA8CEC9BCE12F9CB))
      result = _id_0DB1541018D7BADF["position"];
    else {}
  }

  return result;
}

_id_A46005E27C92C2CA() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    turretangles = undefined;

    if(self._id_D8943D63EC472996 == 0)
      turretangles = self.mgturret gettagangles("tag_flash");
    else
      turretangles = self gettagangles("tag_flash");

    _id_5F1A5A32F3D81CE2 = invertangles(self.angles);
    _id_D550EBE8B9A1BB32 = combineangles(_id_5F1A5A32F3D81CE2, turretangles);
    _id_BBB9076182480914 = _id_D550EBE8B9A1BB32[1] * -1.0;
    self.owner setclientomnvar("ui_pac_sentry_degrees", _id_BBB9076182480914);
    waitframe();
  }
}

_id_04048C2CA00C4690() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  thread _id_865318FE12D890E8();
  self.owner notifyonplayercommand("toggle_view", "+togglevehcam");
  _id_B929075EC07DCE71 = 1;
  _id_A6F4657E2F8D1D39 = "third_person_hud_on";

  if(isDefined(self.owner.previousremotetankviewstate)) {
    _id_B929075EC07DCE71 = self.owner.previousremotetankviewstate;

    if(_id_A6F4657E2F8D1D39 == 2)
      _id_A6F4657E2F8D1D39 = "first_person_hud_on";
  }

  for(;;) {
    self.owner waittill("toggle_view");
    _id_B929075EC07DCE71++;

    if(_id_B929075EC07DCE71 == 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
      _id_A6F4657E2F8D1D39 = "first_person_hud_on";
    } else if(_id_B929075EC07DCE71 > 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      _id_B929075EC07DCE71 = 1;
      _id_A6F4657E2F8D1D39 = "third_person_hud_on";
    }

    self.owner.previousremotetankviewstate = _id_B929075EC07DCE71;
    self.owner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, _id_A6F4657E2F8D1D39);
    self.owner setclientomnvar("ui_pac_sentry_controls", _id_B929075EC07DCE71);
  }
}

_id_865318FE12D890E8() {
  _id_ED6F9375A4009DE4 = self.owner;
  _id_ED6F9375A4009DE4 endon("disconnect");
  level endon("game_ended");
  _id_ED6F9375A4009DE4 notify("tank_reset_viewState");
  _id_ED6F9375A4009DE4 endon("tank_reset_viewState");
  _id_ED6F9375A4009DE4 waittill("death");

  if(isDefined(_id_ED6F9375A4009DE4.previousremotetankviewstate))
    _id_ED6F9375A4009DE4.previousremotetankviewstate = undefined;
}

_id_8CBA478F80E8AC72(_id_F5E7C5E12051B3EB) {
  _id_F5E7C5E12051B3EB _meth_5226227BCE83EBE9(3, _id_F5E7C5E12051B3EB.team);
  return _id_F5E7C5E12051B3EB;
}