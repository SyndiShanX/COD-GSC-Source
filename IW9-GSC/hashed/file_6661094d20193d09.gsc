/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6661094d20193d09.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("rcxd", ::_id_EE4C0AD90E92D557);
  _id_22F85A0A0F7FDCF3 = _id_5C9B9720E93EC5F7();
  _id_0641164BF10FF9B0 = getscriptbundle(_func_40FD49171FAD19D3(_id_22F85A0A0F7FDCF3));

  if(isstruct(_id_0641164BF10FF9B0) && isDefined(_id_0641164BF10FF9B0.weapon))
    scripts\mp\killstreaks\killstreaks::_id_9336A3981B59677B("rcxd", _id_0641164BF10FF9B0.weapon, "stat_125083191DAF6F61");

  level _id_D9E18E5D56577CEE();
  level _id_474178B7859626C1();
}

_id_D9E18E5D56577CEE() {
  _id_22F85A0A0F7FDCF3 = _id_5C9B9720E93EC5F7();
  data = getscriptbundle(_func_40FD49171FAD19D3(_id_22F85A0A0F7FDCF3));
  _id_F48D20DFEF6AF564 = data._id_14090BC312DBF6C8;

  if(isDefined(_id_F48D20DFEF6AF564) && isDefined(_id_F48D20DFEF6AF564.vfx))
    level._effect["veh9_rcxd_explosion"] = loadfx(_id_F48D20DFEF6AF564.vfx);
}

_id_5C9B9720E93EC5F7() {
  return "vehiclebundle:veh9_rcxd" + scripts\engine\utility::ter_op(!scripts\common\utility::iscp(), "_mp", "_cp");
}

_id_474178B7859626C1() {
  level._id_5E85DF3199CE15D7 = [];
  level._id_5E85DF3199CE15D7["rcxd"] = spawnStruct();
  level._id_5E85DF3199CE15D7["rcxd"].timeout = 60.0;
  level._id_5E85DF3199CE15D7["rcxd"].maxhealth = 3000;
  level._id_5E85DF3199CE15D7["rcxd"].hitstokill = 10;
  level._id_5E85DF3199CE15D7["rcxd"].streakname = "rcxd";
  level._id_5E85DF3199CE15D7["rcxd"].pausemin = 0.15;
  level._id_5E85DF3199CE15D7["rcxd"].pausemax = 0.35;
  level._id_5E85DF3199CE15D7["rcxd"].lockstrength = 6;
  level._id_5E85DF3199CE15D7["rcxd"].spinuptime = 0.65;
  level._id_5E85DF3199CE15D7["rcxd"].vehicleinfo = "veh_rcxd";
  level._id_5E85DF3199CE15D7["rcxd"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level._id_5E85DF3199CE15D7["rcxd"].scorepopup = "destroyed_rcxd";
  level._id_5E85DF3199CE15D7["rcxd"].vodestroyed = "destroyed_rcxd";
  level._id_5E85DF3199CE15D7["rcxd"].destroyedsplash = "callout_destroyed_rcxd";
  level._id_5E85DF3199CE15D7["rcxd"].premoddamagefunc = ::_id_4B882FD1C1CF174B;
  level._id_5E85DF3199CE15D7["rcxd"].postmoddamagefunc = ::_id_45A32FBF837F6B56;
  level._id_5E85DF3199CE15D7["rcxd"].deathfunc = ::_id_A8BB5EFEF7E3D2FC;
  level._id_0E05DD6681B991EC = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level._id_C98122F7AB18239F[_id_FABF84450735DD93] = 0;

  level._id_790C25E3D999B3B3 = [];
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius("rcxd", 32);
}

_id_128A18C2549E0D09(streakinfo) {
  return 1;
}

deployweapontaken(streakinfo) {
  self notify("finished_deploy_weapon");
}

_id_D6A0790526291536() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("rcxd", self);
  return _id_EE4C0AD90E92D557(streakinfo);
}

_id_EE4C0AD90E92D557(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B70A873A72C9B255");
  deployweaponobj = makeweapon("ks_remote_device_mp");
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::_id_128A18C2549E0D09, undefined, undefined, ::deployweapontaken);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  _id_4440147083ABAF0A = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + _id_4440147083ABAF0A >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level._id_0E05DD6681B991EC++;
  _id_4C930FC2A4FD2FB2 = 2;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_4C930FC2A4FD2FB2 = 4;

  if(level._id_790C25E3D999B3B3.size >= _id_4C930FC2A4FD2FB2 || level._id_790C25E3D999B3B3.size + level._id_0E05DD6681B991EC > _id_4C930FC2A4FD2FB2) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    level._id_0E05DD6681B991EC--;
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(level.teambased) {
    _id_1168020B70ACEFE9 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap())
      _id_1168020B70ACEFE9 = 2;

    level._id_C98122F7AB18239F[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level._id_790C25E3D999B3B3) + level._id_C98122F7AB18239F[self.team] > _id_1168020B70ACEFE9) {
      level._id_0E05DD6681B991EC--;
      level._id_C98122F7AB18239F[self.team]--;
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_RCXD");
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  result = _id_8E200E50755253D6(streakinfo);
  level._id_0E05DD6681B991EC--;

  if(level.teambased)
    level._id_C98122F7AB18239F[self.team]--;

  if(!istrue(result)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/NOT_ENOUGH_SPACE");
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  return 1;
}

_id_8E200E50755253D6(streakinfo) {
  self disablephysicaldepthoffieldscripting();
  position = _id_BD58FF389CCB7484(100);

  if(!isDefined(position)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  scripts\mp\utility\player::_freezecontrols(1);
  _id_3B64EB40368C1450::set("rcxdDropOff", "fire", 0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  _id_1EF846C5BF5D08F2 = _id_0A56F917E19A55C2("rcxd", self, streakinfo, position);

  if(!isDefined(_id_1EF846C5BF5D08F2)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    scripts\mp\utility\player::_freezecontrols(0);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("rcxdDropOff");
    return 0;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("rcxdDropOff");
  thread _id_092F7B7AF33F2E4F(_id_1EF846C5BF5D08F2);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("rcxd", "use_rcxd", 1);
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "rcxd", self.origin);
  thread scripts\mp\hud_message::showsplash("rcxd");
  return 1;
}

_id_0A56F917E19A55C2(_id_33C83F378CFB7B22, owner, streakinfo, _id_FB1DEF007972B25A) {
  _id_8C9B77F96067631C = level._id_5E85DF3199CE15D7[_id_33C83F378CFB7B22];
  angles = owner.angles;
  spawndata = spawnStruct();
  spawndata.origin = _id_FB1DEF007972B25A;
  spawndata.angles = angles;
  superfaction = scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner);
  spawndata.targetname = _id_33C83F378CFB7B22;
  spawndata.vehicletype = _id_8C9B77F96067631C.vehicleinfo;
  spawndata.owner = owner;
  spawndata.cannotbesuspended = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  _id_1EF846C5BF5D08F2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(_id_1EF846C5BF5D08F2))
    return undefined;

  _id_EBBE5C4D79905B3D = getdvarint("dvar_A587D6A17C45030A", _id_8C9B77F96067631C.timeout);
  _id_1EF846C5BF5D08F2.team = owner.team;
  _id_1EF846C5BF5D08F2.owner = owner;
  _id_1EF846C5BF5D08F2.streakinfo = streakinfo;
  _id_1EF846C5BF5D08F2._id_33C83F378CFB7B22 = _id_33C83F378CFB7B22;
  _id_1EF846C5BF5D08F2.config = _id_8C9B77F96067631C;
  _id_1EF846C5BF5D08F2.maxhealth = _id_8C9B77F96067631C.maxhealth;
  _id_1EF846C5BF5D08F2.health = _id_8C9B77F96067631C.maxhealth;
  _id_1EF846C5BF5D08F2.currenthealth = _id_8C9B77F96067631C.maxhealth;
  _id_1EF846C5BF5D08F2.lifetime = _id_EBBE5C4D79905B3D;
  _id_1EF846C5BF5D08F2.superfaction = superfaction;
  _id_1EF846C5BF5D08F2 setotherent(owner);
  _id_1EF846C5BF5D08F2 setvehicleteam(_id_1EF846C5BF5D08F2.team);
  _id_1EF846C5BF5D08F2 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", owner);
  _id_1EF846C5BF5D08F2 _id_51DE319093C63184(streakinfo.streakname);
  _id_1EF846C5BF5D08F2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  _id_1EF846C5BF5D08F2 thread _id_9809A94762B799BD();
  _id_1EF846C5BF5D08F2 thread _id_BDD816A535EAEBD4();
  _id_1EF846C5BF5D08F2 thread _id_C9A7318945B83E7B(_id_1EF846C5BF5D08F2.owner);
  _id_1EF846C5BF5D08F2.childoutlineents = [_id_1EF846C5BF5D08F2];
  scripts\mp\outofbounds::registerentforoob(_id_1EF846C5BF5D08F2, "killstreak");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(_id_1EF846C5BF5D08F2, owner, owner.team);
  level._id_790C25E3D999B3B3[level._id_790C25E3D999B3B3.size] = _id_1EF846C5BF5D08F2;
  _id_1EF846C5BF5D08F2 scripts\mp\utility\killstreak::addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Ground", owner, 0, 1, 60);
  level notify("matchrecording_small_ground_vehicle", _id_1EF846C5BF5D08F2);
  return _id_1EF846C5BF5D08F2;
}

_id_51DE319093C63184(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = "destroyed_" + streakname;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_BD873B34E815A7EF;
  _id_191284E2E2837328 = ::_id_22D055BFB09E75F9;
  _id_BACC6DD14316758C = ::_id_4B882FD1C1CF174B;
  _id_7DA88D9C69433487 = ::_id_45A32FBF837F6B56;
  deathcallback = ::_id_A8BB5EFEF7E3D2FC;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
}

_id_BD873B34E815A7EF(streakname) {
  config = level._id_5E85DF3199CE15D7[self._id_33C83F378CFB7B22];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, config.hitstokill);
}

_id_22D055BFB09E75F9(streakname) {
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

  weaponname = "c4_mp_p";
  weaponhitsperattack = 5;
  _id_8B4500D6A881B7B2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_092F7B7AF33F2E4F(_id_1EF846C5BF5D08F2) {
  level endon("game_ended");
  self endon("disconnect");
  self.restoreangles = self getplayerangles();
  _id_1EF846C5BF5D08F2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  data = spawnStruct();
  data.deathoverridecallback = ::_id_51698288892E0D91;
  _id_1EF846C5BF5D08F2 thread scripts\mp\movers::handle_moving_platforms(data);
  _id_1EF846C5BF5D08F2 setotherent(self);
  _id_1EF846C5BF5D08F2.driver = self;
  _id_1EF846C5BF5D08F2.ispiloted = 1;
  self unlink();

  if(isDefined(_id_1EF846C5BF5D08F2.empcount) && _id_1EF846C5BF5D08F2.empcount > 0)
    scripts\mp\utility\player::_freezelookcontrols(1);
  else
    self usevehicle(_id_1EF846C5BF5D08F2, 0);

  _id_1EF846C5BF5D08F2.controlslinked = 1;
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  _id_B929075EC07DCE71 = 1;
  _id_A6F4657E2F8D1D39 = "third_person_hud_on";

  if(isDefined(self._id_88C352B8B8F511FF)) {
    _id_B929075EC07DCE71 = self._id_88C352B8B8F511FF;

    if(_id_A6F4657E2F8D1D39 == 2)
      _id_A6F4657E2F8D1D39 = "first_person_hud_on";
  }

  self setclientomnvar("ui_rcxd_controls", _id_B929075EC07DCE71);
  self setclientomnvar("ui_rcxd_speed", 0);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(_id_1EF846C5BF5D08F2.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", _id_1EF846C5BF5D08F2.health / _id_1EF846C5BF5D08F2.maxhealth);
  self setclientomnvar("ui_killstreak_damage_state", 0);
  _id_2CD52BBC2A67B7CF = [];
  players = level.players;

  foreach(player in players) {
    if(level.teambased && player.team == self.team || player == self) {
      continue;
    }
    if(player scripts\mp\utility\perk::_hasperk("specialty_covert_ops")) {
      continue;
    }
    _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcxdenemytarget", self, _id_2CD52BBC2A67B7CF, self, 0, 1);
  self._id_87A4932A581ECB5A = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcxdownertarget", self, self, self, 1, 1);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  _id_3B64EB40368C1450::set("rcxd", "shellshock", 0);
  scripts\mp\outofbounds::registerentforoob(_id_1EF846C5BF5D08F2, "killstreak");
  _id_1EF846C5BF5D08F2 thread _id_5E96F6734A16EB8E();
  _id_3B64EB40368C1450::set("rcxd_spawn", "player_for_spawn_logic", 0);
  scripts\mp\spawnlogic::addspawnviewer(_id_1EF846C5BF5D08F2);
  scripts\mp\utility\player::_freezecontrols(0);
}

_id_4B882FD1C1CF174B(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_45A32FBF837F6B56(data) {
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

_id_A8BB5EFEF7E3D2FC(data) {
  self.killedbyweapon = data.objweapon;
  thread _id_55B8FB7382BF8868();
  return 0;
}

_id_51698288892E0D91(data) {
  thread _id_55B8FB7382BF8868();
}

_id_9809A94762B799BD() {
  self endon("death");
  level endon("game_ended");
  _id_7C2087C0D6D9B9A1();
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("rcxd", "timeout_rcxd", 1);
  thread _id_55B8FB7382BF8868();
}

_id_7C2087C0D6D9B9A1() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("last_stand_start");
  self.owner endon("team_kill_punish");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

_id_BDD816A535EAEBD4() {
  self endon("death");
  level waittill("game_ended");
  thread _id_4EEC08FBCAE80437();
}

_id_4EEC08FBCAE80437(_id_4FAC8B8CE36E09F1) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("death");
  self.controlslinked = undefined;
  _id_8C9B77F96067631C = level._id_5E85DF3199CE15D7[self._id_33C83F378CFB7B22];

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  if(isDefined(self.driver))
    self.driver thread _id_896A6F62E002C911(self);

  waitframe();
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  level._id_790C25E3D999B3B3 = scripts\engine\utility::array_remove(level._id_790C25E3D999B3B3, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_896A6F62E002C911(_id_1EF846C5BF5D08F2) {
  self endon("disconnect");
  _id_8C9B77F96067631C = level._id_5E85DF3199CE15D7[_id_1EF846C5BF5D08F2._id_33C83F378CFB7B22];

  if(isDefined(_id_1EF846C5BF5D08F2.empcount) && _id_1EF846C5BF5D08F2.empcount > 0)
    scripts\mp\utility\player::_freezelookcontrols(0);

  _id_1EF846C5BF5D08F2 setotherent(undefined);
  _id_1EF846C5BF5D08F2.driver = undefined;
  _id_1EF846C5BF5D08F2.ispiloted = undefined;
  self _meth_C0505F05660D120C(0);
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(_id_1EF846C5BF5D08F2.streakinfo.streakname, "off");
  self setclientomnvar("ui_rcxd_controls", 0);

  if(scripts\mp\utility\player::isusingremote())
    _id_1EF846C5BF5D08F2.streakinfo notify("killstreak_finished_with_deploy_weapon");

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("rcxd_spawn");
  scripts\mp\spawnlogic::removespawnviewer(_id_1EF846C5BF5D08F2);

  if(isDefined(self.enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);

  if(isDefined(self._id_87A4932A581ECB5A))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self._id_87A4932A581ECB5A);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("rcxd");
    level thread scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles(self);
  }
}

_id_5E96F6734A16EB8E() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  for(;;) {
    self.owner earthquakeforplayer(0.05, 0.05, self gettagorigin("tag_body"), 500);
    wait 0.05;
  }
}

_id_BD58FF389CCB7484(spawndist) {
  result = undefined;
  startpos = self.origin;
  startang = self.angles;
  forward = anglesToForward(startang);
  right = anglestoright(startang);
  _id_07DDDF03B37D511F = [startpos + spawndist * forward, startpos - spawndist * forward, startpos + spawndist * right, startpos - spawndist * right, startpos + 0.707 * spawndist * (forward + right), startpos + 0.707 * spawndist * (forward - right), startpos + 0.707 * spawndist * (right - forward), startpos + 0.707 * spawndist * (-1 * forward - right)];

  foreach(_id_850A0F04F8EDABA5 in _id_07DDDF03B37D511F) {
    result = _id_BF7C51D4AAD70B8A(startpos, _id_850A0F04F8EDABA5);

    if(isDefined(result)) {
      break;
    }
  }

  return result;
}

_id_BF7C51D4AAD70B8A(startpoint, spawnpoint) {
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

_id_634C68391925C2B1(player) {
  if(player usinggamepad())
    return player buttonPressed("BUTTON_RTRIG");
  else
    return player attackButtonPressed();
}

_id_55B8FB7382BF8868() {
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread _id_CD6C00B238CEC19C();
  thread _id_4EEC08FBCAE80437();
}

_id_CD6C00B238CEC19C() {
  _id_22F85A0A0F7FDCF3 = _id_5C9B9720E93EC5F7();
  data = getscriptbundle(_func_40FD49171FAD19D3(_id_22F85A0A0F7FDCF3));
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC["rcxd"];
  _id_F48D20DFEF6AF564 = data._id_14090BC312DBF6C8;
  _id_240A4F3D560753FF = self.origin;
  self radiusdamage(self.origin, _id_D442547D75DFFD09._id_FE77BEC3D33CF356, _id_D442547D75DFFD09._id_CF4282AC724AB35E, _id_D442547D75DFFD09._id_CF6574AC7270DC4C, self);
  fx = scripts\engine\utility::getfx("veh9_rcxd_explosion");
  playFX(fx, _id_240A4F3D560753FF, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(_id_F48D20DFEF6AF564.sfx))
    playsoundatpos(_id_240A4F3D560753FF, _id_F48D20DFEF6AF564.sfx);

  earthquake(_id_F48D20DFEF6AF564._id_2904DF1BE79620B6, _id_F48D20DFEF6AF564._id_0BDA0B1D6CCE0914, _id_240A4F3D560753FF, _id_F48D20DFEF6AF564._id_1CCED33303F26D02);
  playrumbleonposition("grenade_rumble", _id_240A4F3D560753FF);
  physicsexplosionsphere(_id_240A4F3D560753FF, _id_F48D20DFEF6AF564._id_A1939E49D568612B, _id_F48D20DFEF6AF564._id_9ED85C24DBCF8DA4, _id_F48D20DFEF6AF564._id_FDDF5FE707F47E54);
}

_id_C9A7318945B83E7B(player) {
  self endon("death");
  level endon("game_ended");

  while(!_id_634C68391925C2B1(player))
    waitframe();

  self dodamage(self.health, self.origin);
}