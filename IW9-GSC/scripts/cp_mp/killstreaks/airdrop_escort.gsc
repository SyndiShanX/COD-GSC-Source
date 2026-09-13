/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airdrop_escort.gsc
********************************************************/

_id_F383491974A17B9A() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_escort", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_escort", "init")]]();

  level _id_E407A860BFF9C632();
  level _id_A852F44527C9D61F();
  level _id_9302FD2BFE5C663C();
}

_id_E407A860BFF9C632() {
  level._id_346499147C1F5C1F = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level._id_54EAFC62B6AD04C8[_id_FABF84450735DD93] = 0;

  level.cratedropdata._id_04950BB412D4E1D5 = [];
}

_id_A852F44527C9D61F() {
  _id_01F93185F55E71C3();
  _id_29C55DA256BFA6BA();
}

#using_animtree("script_model");

_id_01F93185F55E71C3() {
  level.scr_animtree["ks_airdrop_escort_crate"] = #animtree;
  level.scr_anim["ks_airdrop_escort_crate"]["crate_push_out_left"] = % iw9_mp_esc_airdrop_pack_l;
  level.scr_animname["ks_airdrop_escort_crate"]["crate_push_out_left"] = "iw9_mp_esc_airdrop_pack_l";
  level.scr_anim["ks_airdrop_escort_crate"]["crate_push_out_right"] = % iw9_mp_esc_airdrop_pack_r;
  level.scr_animname["ks_airdrop_escort_crate"]["crate_push_out_right"] = "iw9_mp_esc_airdrop_pack_r";
}

#using_animtree("mp_vehicles_always_loaded");

_id_29C55DA256BFA6BA() {
  level.scr_animtree["ks_airdrop_escort_heli"] = #animtree;
  level.scr_anim["ks_airdrop_escort_heli"]["vehicle_doors_open"] = % iw9_mp_esc_airdrop_helidoors;
}

_id_9302FD2BFE5C663C() {
  game["dialog"]["airdrop_escort_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["airdrop_escort_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["airdrop_escort_destroyed"] = "killstreak_team_leader_crash";
  game["dialog"]["airdrop_escort_spotted_target"] = "killstreak_remote_operator_target_spotted_single";
}

_id_E24BFFEB9974833E() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("airdrop_escort", self);
  return _id_45378F51950E7D1F(streakinfo);
}

_id_45378F51950E7D1F(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  level._id_346499147C1F5C1F++;
  _id_25F93FF4CA83EBA9 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_25F93FF4CA83EBA9 = 2;

  if(level.cratedropdata._id_04950BB412D4E1D5.size >= _id_25F93FF4CA83EBA9 || level.cratedropdata._id_04950BB412D4E1D5.size + level.incomingallchoppersupports > _id_25F93FF4CA83EBA9) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    level._id_346499147C1F5C1F--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    _id_ABDB6AF6E3CA3893 = 1;
    level._id_54EAFC62B6AD04C8[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.cratedropdata._id_04950BB412D4E1D5) + level._id_54EAFC62B6AD04C8[self.team] > _id_25F93FF4CA83EBA9) {
      level._id_346499147C1F5C1F--;
      level._id_54EAFC62B6AD04C8[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();

  _id_79710492B71B9E81 = _id_5867A72A727CED43(self, self.origin, "overwatch", streakinfo);
  level._id_346499147C1F5C1F--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level._id_54EAFC62B6AD04C8[self.team]--;

  if(!istrue(_id_79710492B71B9E81))
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("airdrop_escort", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop_escort", self);

  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("airdrop_escort", "airdrop_escort_use", 1, _id_52A5BE2E2F91D710);
  return _id_79710492B71B9E81;
}

_id_5867A72A727CED43(owner, position, _id_4361065C62F16C21, streakinfo) {
  escortheli = _id_E384066B8CC15BE4(owner, owner.team, position, _id_4361065C62F16C21, streakinfo);

  if(!isDefined(escortheli))
    return 0;

  escortheli thread _id_429BA1C88D63319C(_id_4361065C62F16C21);
  return 1;
}

_id_E384066B8CC15BE4(owner, team, position, _id_4361065C62F16C21, streakinfo) {
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

  heightoffset = (0, 0, 1000);
  _id_F3910D9D3EFD6E9D = heightoffset + (0, 0, 1000);
  _id_098309FE48684A69 = owner.angles + (0, 180, 0);
  pathgoal = position + _id_F3910D9D3EFD6E9D;
  pathstart = pathgoal - anglesToForward(_id_098309FE48684A69) * 15000;

  if(!scripts\cp_mp\utility\game_utility::islargemap() && isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    _id_8013278937FF2600 = randomint(level.heli_structs_entrances.size);
    _id_B2F2CBEB5539EFA6 = level.heli_structs_entrances[_id_8013278937FF2600];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      goalstruct = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "findTargetStruct")]](_id_B2F2CBEB5539EFA6.script_linkto, level.heli_structs_goals);

      if(isDefined(goalstruct)) {
        _id_F3910D9D3EFD6E9D = (0, 0, goalstruct.origin[2] + 1000);
        _id_A168DB747B0D79AC = _id_B2F2CBEB5539EFA6.origin * (1, 1, 0) + _id_F3910D9D3EFD6E9D;
        _id_C32E33B4D51BE12F = goalstruct.origin * (1, 1, 0) + _id_F3910D9D3EFD6E9D;
        _id_8577D255D1A9BD14 = vectorNormalize(_id_C32E33B4D51BE12F - _id_A168DB747B0D79AC);
        pathstart = _id_A168DB747B0D79AC;
        pathgoal = _id_C32E33B4D51BE12F + _id_8577D255D1A9BD14 * 1000;
        _id_098309FE48684A69 = vectortoangles(_id_8577D255D1A9BD14);
      } else {}
    }
  }

  escortheli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathstart, _id_098309FE48684A69, "veh_airdrop_escort_mp_phys", "veh9_mil_air_heli_hind_mp");

  if(!isDefined(escortheli))
    return undefined;

  if(!isDefined(team))
    team = "neutral";

  if(team != "neutral")
    escortheli setvehicleteam(team);

  _id_EBBE5C4D79905B3D = 60;
  escortheli.speed = 100;
  escortheli.accel = 50;
  escortheli.lifetime = _id_EBBE5C4D79905B3D;
  escortheli.health = 2000;
  escortheli.maxhealth = 2000;
  escortheli.currenthealth = 2000;
  escortheli.team = team;
  escortheli.owner = owner;
  escortheli.streakinfo = streakinfo;
  escortheli.streakname = streakinfo.streakname;
  escortheli.flaresreservecount = 1;
  escortheli.pathstart = pathstart;
  escortheli.pathgoal = pathgoal;
  escortheli.currentaction = undefined;
  escortheli.patrolradius = 1000;
  escortheli.heightoffset = heightoffset;
  escortheli._id_C91D73A79BA4A8AB = _id_F3910D9D3EFD6E9D;
  escortheli._id_76A22C18960F72AF = position;
  escortheli._id_4361065C62F16C21 = _id_4361065C62F16C21;
  escortheli.animname = "ks_airdrop_escort_heli";
  escortheli _id_923B24178E709FBB(streakinfo.streakname);
  escortheli setmaxpitchroll(15, 15);
  escortheli vehicle_setspeed(escortheli.speed, escortheli.accel);
  escortheli sethoverparams(50, 5, 2.5);
  escortheli setturningability(1);
  escortheli setyawspeed(50, 25, 25, 0.5);
  escortheli setotherent(owner);
  escortheli setCanDamage(1);
  escortheli setneargoalnotifydist(1000);
  escortheli _meth_247AD6A91F6A4FFE(1);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(escortheli, owner, ::_id_C91A4A524A2D461D);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_escort", "attachXRays"))
    escortheli = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_escort", "attachXRays")]](escortheli);

  escortheli scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_5555CCC5B8CA52D3);
  escortheli scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_8FC896D80A52B782);
  escortheli setscriptablepartstate("blinking_lights", "on", 0);
  escortheli setscriptablepartstate("engine", "on", 0);
  escortheli.turret = spawnturret("misc_turret", escortheli gettagorigin("tag_turret"), "airdrop_escort_turret_ballistics_mp");
  escortheli.turret setModel("veh9_mil_air_heli_hind_turret_mp");
  escortheli.turret.owner = escortheli.owner;
  escortheli.turret.team = escortheli.team;
  escortheli.turret.angles = escortheli.angles;
  escortheli.turret.streakinfo = escortheli.streakinfo;
  escortheli.turret.disabled = 0;
  escortheli.turret._id_9E50CEF01527FF79 = undefined;
  escortheli.turret linkTo(escortheli, "tag_turret");
  escortheli.turret setturretteam(escortheli.team);
  escortheli.turret setturretmodechangewait(0);
  escortheli.turret setmode("manual");
  escortheli.turret setotherent(escortheli.owner);
  escortheli.turret setdefaultdroppitch(45);
  _id_71E1E35AC8A4138D = escortheli.origin - (0, 0, 100) + anglesToForward(escortheli.angles) * 500;
  escortheli.turret.groundtargetent = spawn("script_model", _id_71E1E35AC8A4138D);
  escortheli.turret.groundtargetent setModel("tag_origin");
  escortheli.turret.groundtargetent linkTo(escortheli.turret);
  escortheli.turret.groundtargetent dontinterpolate();
  escortheli.turret settargetentity(escortheli.turret.groundtargetent);
  escortheli.killcament = spawn("script_model", escortheli.turret gettagorigin("bi_center"));
  escortheli.killcament linkTo(escortheli, "tag_origin", (-500, 0, 500), (0, 0, 0));
  escortheli.turret.killcament = escortheli.killcament;

  if(isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
      escortheli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](escortheli.streakname, "Killstreak_Air", owner, 0, 1, 100);

    if(team != "neutral")
      escortheli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  }

  level.cratedropdata._id_04950BB412D4E1D5[level.cratedropdata._id_04950BB412D4E1D5.size] = escortheli;
  return escortheli;
}

_id_923B24178E709FBB(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = "airdrop_escort_destroyed";
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_A4B7038DF66C4B58;
  _id_191284E2E2837328 = ::_id_350EB9923F9E2A74;
  _id_BACC6DD14316758C = ::_id_3E6225EF4EFC799E;
  _id_7DA88D9C69433487 = ::_id_E687E809E9570D59;
  deathcallback = ::_id_1FE4E6FD1F673F2D;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 1500, ::_id_6E785F240CA1205E);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 1000, ::_id_71B13DC22E6C70CB);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 500, ::_id_A58186566A85E2DB);
}

_id_A4B7038DF66C4B58(streakname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
}

_id_350EB9923F9E2A74(streakname) {}

_id_3E6225EF4EFC799E(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_E687E809E9570D59(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_6E785F240CA1205E() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_71B13DC22E6C70CB() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_A58186566A85E2DB() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

_id_1FE4E6FD1F673F2D(data) {
  self.killedbyweapon = data.objweapon;
  thread _id_46088AA13D962F89(self.killedbyweapon);
  return 1;
}

_id_46088AA13D962F89(_id_11B83E21F9C87FF5) {
  self endon("explode");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](_id_11B83E21F9C87FF5))
      _id_51BEB9374F4650AB(150, _id_11B83E21F9C87FF5);
  }

  thread _id_C91A4A524A2D461D();
}

_id_51BEB9374F4650AB(speed, _id_11B83E21F9C87FF5, _id_C5ADB13BE635C61A) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  playsoundatpos(self.origin, "exp_escort_helo");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_6847739E80FB4E81 = scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_findcrashposition(2500);

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_spinout(speed);
  scripts\cp_mp\utility\killstreak_utility::_id_5A9772411551E56E("airdrop_escort");
}

_id_962725F71407F96F(position) {
  return position;
}

_id_429BA1C88D63319C(_id_4361065C62F16C21) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  thread _id_035C660A3F2BC49E();
  thread _id_7FC680F960D38005();
  self setvehgoalpos(self.pathgoal, 1);
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 4), int(self.accel / 4));
  self setneargoalnotifydist(300);
  thread _id_ACDC6C19714B6BB8();
  self waittill("goal");
  _id_60F4CBA05ECA8DB0 = undefined;
  _id_08A8E6270E7E92C6 = undefined;

  if(_id_4361065C62F16C21 == "crate") {
    self._id_60F4CBA05ECA8DB0 = "heli_patrol";
    self._id_08A8E6270E7E92C6 = ::_id_6AF592B35966F02A;
    thread _id_BA7E24EE1AAF05E3();
    wait 1;
  } else {
    self._id_60F4CBA05ECA8DB0 = "heli_overwatch";
    self._id_08A8E6270E7E92C6 = ::_id_365529B3985C87D4;
    thread _id_365529B3985C87D4();
  }

  thread _id_0E46FB5B1144140E(self.turret);
}

_id_5555CCC5B8CA52D3(data) {
  self.turret.disabled = 1;
}

_id_8FC896D80A52B782(_id_FCEF8D217A441961) {
  self.turret.disabled = 0;
}

_id_ACDC6C19714B6BB8() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  wait(self.lifetime);
  thread _id_94CA0444F2EFD147();
}

_id_035C660A3F2BC49E() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread _id_94CA0444F2EFD147();
    return;
  }

  self.owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  thread _id_94CA0444F2EFD147();
}

_id_7FC680F960D38005() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level waittill("game_ended");

  if(isDefined(self.owner)) {
    self.recordedgameendstats = 1;
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  thread _id_94CA0444F2EFD147();
}

_id_BA7E24EE1AAF05E3() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self.owner endon("disconnect");
  _id_7F980E69DEF745B8 = level.scr_anim["ks_airdrop_escort_heli"]["vehicle_doors_open"];
  _id_6A5DC0FC2710AD84 = getanimlength(_id_7F980E69DEF745B8);
  thread scripts\common\anim::anim_single_solo(self, "vehicle_doors_open");
  wait(_id_6A5DC0FC2710AD84);
  _id_04A2AA8B66AC796D = [];
  numcrates = 2;
  _id_C192239C59747190 = 0;
  _id_5D11A6A17E49FDB3 = self.owner;
  _id_8DF771DFD9CC0975 = self.team;
  cratetype = scripts\engine\utility::ter_op(isDefined(self.owner), "killstreak", "killstreak_no_owner");
  _id_8C4038F0270DE13E = self gettagorigin("body_animate_jnt");
  _id_90D4FE050E6864D4 = self.angles;
  _id_DDB9D36F435AD444 = self._id_76A22C18960F72AF;
  hasnophysics = 0;
  _id_6244A1D5B282BB6C = 0;
  skipminimapicon = 0;
  scenenode = self;
  _id_7A950615615223F2 = "ks_airdrop_escort_crate";
  animname = "crate_push_out_left";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numcrates; _id_AC0E594AC96AA3A8++) {
    streakname = undefined;

    if(_id_04A2AA8B66AC796D.size > 0)
      streakname = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(_id_04A2AA8B66AC796D);
    else
      streakname = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

    cratedropdata = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(streakname, 0);

    if(_id_C192239C59747190 >= 1) {
      animname = "crate_push_out_right";
      _id_C192239C59747190 = 0;
    }

    crate = scripts\cp_mp\killstreaks\airdrop::createcrate(_id_5D11A6A17E49FDB3, _id_8DF771DFD9CC0975, cratetype, _id_8C4038F0270DE13E, _id_90D4FE050E6864D4, _id_DDB9D36F435AD444, hasnophysics, _id_6244A1D5B282BB6C, cratedropdata, skipminimapicon);
    crate.streakinfo = self.streakinfo;
    crate.animname = "ks_airdrop_escort_crate";
    crate scripts\common\anim::setanimtree();
    thread _id_96E5DFE9C1AA7DE0(crate, animname, "body_animate_jnt");
    _id_04A2AA8B66AC796D[_id_04A2AA8B66AC796D.size] = streakname;
    _id_C192239C59747190++;
    wait 0.5;
  }
}

_id_96E5DFE9C1AA7DE0(crate, animname, animtag) {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  scripts\common\anim::anim_single_solo(crate, animname, animtag);
  crate stopanimScripted();
  crate scripts\cp_mp\killstreaks\airdrop::cratephysicson();
}

_id_0E44CE535D38F95A(_id_CDBB4A9588ABEF59, currenttarget) {
  return distance2dsquared(_id_CDBB4A9588ABEF59, currenttarget.origin) <= 25000000;
}

_id_FF7ABA975A027D9B(_id_CDBB4A9588ABEF59, currenttarget) {
  return distance2dsquared(_id_CDBB4A9588ABEF59, currenttarget.origin) <= 16000000;
}

_id_6AF592B35966F02A() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self endon("heli_attack");
  level endon("game_ended");
  self notify("heli_patrol");
  self.currentaction = "heli_patrol";
  self clearlookatent();
  self setneargoalnotifydist(300);
  _id_65AF68838583C396 = 0;
  _id_B9A46106A6A99EE8 = 0;

  for(;;) {
    if(self.currentaction == "heli_attack") {
      waitframe();
      continue;
    }

    _id_6E281DBD69FC980E = self.pathgoal + anglesToForward((0, _id_B9A46106A6A99EE8, 0)) * int(self.patrolradius / 1.2);
    _id_B9A46106A6A99EE8 = _id_B9A46106A6A99EE8 + 90;
    _id_112064ACBA6603C3(_id_6E281DBD69FC980E, 0);

    if(_id_B9A46106A6A99EE8 >= 360)
      _id_B9A46106A6A99EE8 = 0;

    wait 0.5;
  }
}

_id_365529B3985C87D4() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self endon("heli_attack");
  level endon("game_ended");
  self notify("heli_overwatch");
  self.currentaction = "heli_overwatch";
  self clearlookatent();
  self setlookatent(self.owner);

  for(;;) {
    _id_112064ACBA6603C3(self.owner, 1);
    waitframe();
  }
}

_id_112064ACBA6603C3(target, _id_6C814CEE8D2BD65E) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self notify("escort_moving");
  self endon("escort_moving");
  _id_6C53D859D582A421 = undefined;
  _id_4E6DF96D95BF50BC = target;

  if(!isvector(target))
    _id_4E6DF96D95BF50BC = target.origin;

  ignorelist = [self, self.turret];

  for(;;) {
    _id_0454EBDDE3D9DCF4 = self.origin;
    _id_2ECA7B12D2EE27BA = _id_4E6DF96D95BF50BC * (1, 1, 0) + (0, 0, self.origin[2]);
    _id_691AA1D5DA533612 = scripts\engine\trace::sphere_trace(_id_0454EBDDE3D9DCF4, _id_2ECA7B12D2EE27BA, 350, ignorelist);
    _id_158F8E4D0E511638 = 0;
    _id_81954D580B24281B = _id_4E6DF96D95BF50BC[0];
    _id_E4F34F3A01C6FFF2 = _id_4E6DF96D95BF50BC[1];

    if(isDefined(_id_691AA1D5DA533612)) {
      if(_id_691AA1D5DA533612["hittype"] != "hittype_none") {
        _id_81954D580B24281B = _id_691AA1D5DA533612["position"][0];
        _id_E4F34F3A01C6FFF2 = _id_691AA1D5DA533612["position"][1];
        _id_158F8E4D0E511638 = 1;
      }
    }

    _id_7504C8791E34DC73 = scripts\cp_mp\killstreaks\chopper_support::getcorrectheight(_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, 20, 512);
    _id_6C53D859D582A421 = (_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, _id_7504C8791E34DC73);
    _id_E1F26216DAE25CB7 = 0;

    if(istrue(_id_6C814CEE8D2BD65E) && !istrue(_id_158F8E4D0E511638))
      _id_E1F26216DAE25CB7 = _id_6C814CEE8D2BD65E;

    self setvehgoalpos(_id_6C53D859D582A421, _id_E1F26216DAE25CB7);
    scripts\engine\utility::waittill_any_2("near_goal");

    if(!istrue(_id_158F8E4D0E511638)) {
      break;
    }
  }
}

_id_94CA0444F2EFD147() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self clearlookatent();
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("airdrop_escort", "airdrop_escort_leave", 1);
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

  if(!isDefined(_id_690E4620FE5FA98F))
    thread _id_C91A4A524A2D461D();
  else {
    _id_1602FAB5EAB68601 = 150;
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
    thread _id_334E82BD0E14DCF4(0);
  }
}

_id_C91A4A524A2D461D() {
  if(istrue(self._id_3621873DCCBDE4B5)) {
    return;
  }
  self notify("explode");
  self._id_3621873DCCBDE4B5 = 1;
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  _id_334E82BD0E14DCF4(1);
}

_id_334E82BD0E14DCF4(_id_4FAC8B8CE36E09F1) {
  if(istrue(self._id_BF178F6894D17B96)) {
    return;
  }
  self._id_BF178F6894D17B96 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - airdrop_escort", self.owner);

  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(!istrue(self.recordedgameendstats))
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  self stoploopsound();

  if(isDefined(self.turret)) {
    if(isDefined(self.turret.groundtargetent))
      self.turret.groundtargetent delete();

    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self._id_4E6DF96D95BF50BC))
    self._id_4E6DF96D95BF50BC delete();

  if(isDefined(self.killcament))
    self.killcament delete();

  level.cratedropdata._id_04950BB412D4E1D5 = scripts\engine\utility::array_remove(level.cratedropdata._id_04950BB412D4E1D5, self);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_0E46FB5B1144140E(turret) {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  childthread _id_5A040540BEE50D81();

  for(;;) {
    _id_868C91589C5DB1AB = getdvarint("dvar_94EDBE8B5C5B8DD0", 0);

    if(istrue(turret.disabled)) {
      waitframe();
      continue;
    }

    if(self.currentaction == "heli_overwatch")
      self waittill("near_goal");

    if(!_id_868C91589C5DB1AB) {
      _id_97E45AB250562D16 = _id_05323B44EE395058::_id_770A14E56B03B067(turret, 4000, 1, 0, 0, "lost_target", "dvar_F8C88D9BCFA63DA3");

      if(isDefined(_id_97E45AB250562D16))
        _id_CADE8C61DF282DE5(_id_97E45AB250562D16);

      if(!isDefined(self.currentaction) || self.currentaction != self._id_60F4CBA05ECA8DB0) {
        self thread[[self._id_08A8E6270E7E92C6]]();
        wait 2;
      }
    }

    wait 0.05;
  }
}

_id_5A040540BEE50D81() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self.turret waittill("missile_fire", projectile);
    projectile.streakinfo = self.streakinfo;
    projectile.killcament = self.killcament;
  }
}

_id_CADE8C61DF282DE5(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  self endon("heli_overwatch");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("airdrop_escort", "airdrop_escort_spotted_target", 1);
    self.lastfiretime = gettime();
  }

  self notify("heli_attack");
  self.currentaction = "heli_attack";
  turret = self.turret;
  _id_35D198C823443318 = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);
  _id_F14A9B1E9835AEAF = _id_05323B44EE395058::_id_0EFFEBB9076EFBDB(targetdata);
  _id_82D3DA0197EF0362("target_normal");
  self setlookatent(_id_35D198C823443318);
  self setvehgoalpos(self.origin + anglesToForward(self.angles) * 500, 1);

  if(!isDefined(self._id_2BAD310FE00F31E3) || isDefined(self._id_2BAD310FE00F31E3) && self._id_2BAD310FE00F31E3 != _id_35D198C823443318) {
    _id_E207676F4FA3C931 = _id_35D198C823443318;
    _id_D0AE85B60EC1F5F7 = self.owner calloutmarkerping_create(6, _id_E207676F4FA3C931.origin + (0, 0, 50), _id_E207676F4FA3C931 getentitynumber());
    self.owner thread scripts\cp_mp\calloutmarkerping::_calloutmarkerping_predicted_timeout(_id_D0AE85B60EC1F5F7);
    thread _id_7FA1ED261AE2F5E3(_id_35D198C823443318);
  }

  _id_2E5B122BD53F3E85(targetdata);
  _id_AA86F3F7FE0F419B(targetdata);

  while(_id_B42AD7E3BD84C2A7() && _id_05323B44EE395058::_id_BC2021C62B0D43CC(turret, _id_35D198C823443318)) {
    wait 1;
    _id_8E4E16BBBFA26EFC(targetdata);
  }

  return "stopped_firing";
}

_id_7FA1ED261AE2F5E3(_id_35D198C823443318) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  level endon("game_ended");
  self notify("new_prev_target");
  self endon("new_prev_target");
  self._id_2BAD310FE00F31E3 = _id_35D198C823443318;
  wait 5;
  self._id_2BAD310FE00F31E3 = undefined;
}

_id_AA86F3F7FE0F419B(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  turret = self.turret;
  _id_DE95D26A97999B92 = undefined;
  _id_F14A9B1E9835AEAF = _id_05323B44EE395058::_id_0EFFEBB9076EFBDB(targetdata);
  _id_35D198C823443318 = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);

  if(isDefined(_id_F14A9B1E9835AEAF))
    _id_DE95D26A97999B92 = _id_F14A9B1E9835AEAF.origin;
  else if(isPlayer(_id_35D198C823443318))
    _id_DE95D26A97999B92 = _id_35D198C823443318 gettagorigin("j_mainroot");
  else
    _id_DE95D26A97999B92 = _id_35D198C823443318.origin;

  _id_36694823BA9EC40A(_id_DE95D26A97999B92);

  while(!_id_46BA72DFA1F04939(turret.groundtargetent.origin))
    waitframe();
}

_id_8E4E16BBBFA26EFC(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  turret = self.turret;
  turret endon("lost_target");
  _id_DE95D26A97999B92 = undefined;
  _id_F14A9B1E9835AEAF = _id_05323B44EE395058::_id_0EFFEBB9076EFBDB(targetdata);
  _id_35D198C823443318 = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);
  _id_DBC5AEB90480B355 = 0;
  _id_C09EEFD28DED683E = weaponfiretime("airdrop_escort_turret_ballistics_mp");
  _id_B0B68854AE03B4D7 = 80;
  _id_546D410FCED2A7DC = 5;
  _id_B7F1B7D94522544F = 12;

  while(_id_05323B44EE395058::_id_20E6F4D27C8040BD(turret) && _id_DBC5AEB90480B355 < 15) {
    if(isDefined(_id_F14A9B1E9835AEAF))
      _id_DE95D26A97999B92 = _id_F14A9B1E9835AEAF.origin;
    else if(isPlayer(_id_35D198C823443318))
      _id_DE95D26A97999B92 = _id_35D198C823443318 gettagorigin("j_mainroot");
    else
      _id_DE95D26A97999B92 = _id_35D198C823443318.origin;

    _id_36694823BA9EC40A(_id_DE95D26A97999B92, _id_B0B68854AE03B4D7);

    if(_id_DBC5AEB90480B355 == _id_546D410FCED2A7DC)
      _id_B0B68854AE03B4D7 = int(40.0);
    else if(_id_DBC5AEB90480B355 >= _id_B7F1B7D94522544F)
      _id_B0B68854AE03B4D7 = undefined;

    turret shootturret();
    _id_DBC5AEB90480B355++;

    if(isDefined(turret.streakinfo))
      turret.streakinfo.shots_fired++;

    wait(_id_C09EEFD28DED683E);
  }
}

_id_2E5B122BD53F3E85(targetdata) {
  turret = self.turret;
  _id_39C7490877E6EFE5 = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);
  thread _id_0A4DA6E59481303F(_id_39C7490877E6EFE5, "death_or_disconnect");
  thread _id_0A4DA6E59481303F(turret, "target_broke_los");
  thread _id_0A4DA6E59481303F(turret, "target_outside_valid_range");
  thread _id_0A4DA6E59481303F(turret, "target_timeout");
  thread _id_0A4DA6E59481303F(turret, "target_last_stand");
  thread _id_D8910BADEC564FA0(targetdata);
  thread _id_3E4E3769F386A9A3(targetdata);
  thread _id_A39BC57828127BE1(targetdata);
  thread _id_CC44CC73F134622E(targetdata);
}

_id_0A4DA6E59481303F(ent, _id_BF4A0ADF8E2321FE) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  turret = self.turret;
  turret endon("lost_target");
  ent waittill(_id_BF4A0ADF8E2321FE);
  _id_7303808C08DBAAE1();
  turret notify("lost_target");
}

_id_B42AD7E3BD84C2A7() {
  turret = self.turret;
  _id_55D7603C1D7C24CA = _id_05323B44EE395058::_id_20E6F4D27C8040BD(turret);
  _id_56E17EFA53B640D9 = !isDefined(self.iscrashing) && !isDefined(self.isleaving);
  return istrue(_id_55D7603C1D7C24CA) && istrue(_id_56E17EFA53B640D9);
}

_id_36694823BA9EC40A(_id_225D5BE1546186A5, _id_B0B68854AE03B4D7) {
  point = _id_225D5BE1546186A5;
  turret = self.turret;
  ignorelist = [self, self.turret];
  _id_FC034515F9E66143 = turret.groundtargetent;

  if(isDefined(_id_B0B68854AE03B4D7)) {
    if(_id_FC034515F9E66143 islinked())
      _id_FC034515F9E66143 unlink();

    _id_A0A41BA05E16FFE6 = randomint(_id_B0B68854AE03B4D7);
    _id_9E5D403038E4C071 = randomint(360);
    x = _id_225D5BE1546186A5[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
    y = _id_225D5BE1546186A5[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
    z = _id_225D5BE1546186A5[2];
    point = (x, y, z);
    _id_FC034515F9E66143.origin = point;
  } else {
    if(_id_FC034515F9E66143 islinked())
      _id_FC034515F9E66143 unlink();

    _id_FC034515F9E66143 linkTo(_id_05323B44EE395058::_id_2ADFF40B591B5758(turret), "tag_origin", (0, 0, 30), (0, 0, 0));
  }
}

_id_46BA72DFA1F04939(targetorigin) {
  turret = self.turret;
  _id_929AD65D451FFC68 = anglesToForward(turret gettagangles("tag_flash"));
  _id_EFA57ADC48838F9B = targetorigin - turret.origin;
  _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(_id_929AD65D451FFC68, _id_EFA57ADC48838F9B);

  if(_id_077B9E4B599269EB <= 10)
    return 1;

  return 0;
}

_id_D8910BADEC564FA0(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  _id_FA2A5BDD4208DF6E = undefined;
  tolerance = 500;
  targetplayer = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);
  _id_9E6B52E2227B1D6B = _id_05323B44EE395058::_id_F6926785E402B9FE(targetdata);

  for(;;) {
    canseetarget = _id_05323B44EE395058::_id_F6F04FC4E42CF2C4(turret, targetplayer);

    if(!istrue(canseetarget)) {
      if(!isDefined(_id_FA2A5BDD4208DF6E))
        _id_FA2A5BDD4208DF6E = gettime();

      if(gettime() - _id_FA2A5BDD4208DF6E > tolerance) {
        _id_82D3DA0197EF0362("target_broke_los");
        break;
      }
    } else
      _id_FA2A5BDD4208DF6E = undefined;

    wait 0.05;
  }
}

_id_3E4E3769F386A9A3(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  targetplayer = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);

  for(;;) {
    _id_CDBB4A9588ABEF59 = self.owner.origin;

    if(self._id_4361065C62F16C21 == "crate")
      _id_CDBB4A9588ABEF59 = self.pathgoal;

    if(_id_0E44CE535D38F95A(_id_CDBB4A9588ABEF59, targetplayer)) {
      if(!_id_FF7ABA975A027D9B(_id_CDBB4A9588ABEF59, targetplayer)) {
        _id_112064ACBA6603C3(targetplayer, 1);
        wait 1;
      }
    } else {
      _id_82D3DA0197EF0362("target_outside_valid_range");
      break;
    }

    wait 0.05;
  }
}

_id_A39BC57828127BE1(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  wait 5;
  _id_82D3DA0197EF0362("target_timeout");
}

_id_CC44CC73F134622E(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  targetplayer = _id_05323B44EE395058::_id_70B8756E9FC03C44(targetdata);
  _id_24E9CECE4BC538DB = _id_05323B44EE395058::_id_D463678CCF4BEEDA(targetdata);

  if(istrue(_id_24E9CECE4BC538DB)) {
    return;
  }
  targetplayer waittill("last_stand_start");
  _id_82D3DA0197EF0362("target_last_stand");
}

_id_82D3DA0197EF0362(_id_9E50CEF01527FF79) {
  turret = self.turret;
  _id_05323B44EE395058::_id_46C1EA4A69AD33D6(turret, _id_9E50CEF01527FF79);
  turret notify(_id_9E50CEF01527FF79);
}

_id_7303808C08DBAAE1() {
  turret = self.turret;

  if(turret.groundtargetent islinked())
    turret.groundtargetent unlink();

  _id_71E1E35AC8A4138D = self.origin - (0, 0, 100) + anglesToForward(self.angles) * 500;
  turret.groundtargetent.origin = _id_71E1E35AC8A4138D;
  turret.groundtargetent linkTo(self);
}