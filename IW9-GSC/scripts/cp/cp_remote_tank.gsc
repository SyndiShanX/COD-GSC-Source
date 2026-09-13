/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_remote_tank.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("veh_pac_sentry_ground_mp", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
}

init_local() {}

init_remote_tank() {
  level._effect["wheelson_light"] = loadfx("vfx/iw8_cp/level/cp_lab/vfx_wheelson_spotlight_14.vfx");
  level._effect["remote_tank_explode"] = loadfx("vfx/iw8_cp/level/cp_lab/vfx_wheelson_death_exp_no_model.vfx");

  if(!isDefined(level.tanksettings))
    level.tanksettings = [];

  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60.0;
  level.tanksettings["remote_tank"].maxhealth = 500;
  level.tanksettings["remote_tank"].hitstokill = 5;
  level.tanksettings["remote_tank"].streakname = "pac_sentry";
  level.tanksettings["remote_tank"].modelbase = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].modeldestroyed = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].mgturretmodelbase = "veh8_mil_lnd_whotel_turret";
  level.tanksettings["remote_tank"].mgturretinfo = "pac_sentry_turret_cp";
  level.tanksettings["remote_tank"].sentrymodeon = "sentry";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].vehicleinfo = "veh_pac_sentry_mp_cp";
  level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level.tanksettings["remote_tank"].scorepopup = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].vodestroyed = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].destoyedsplash = "callout_destroyed_pac_sentry";
  level.tanksettings["remote_tank"].premoddamagefunc = undefined;
  level.tanksettings["remote_tank"].lifetime = 600;
  level.remote_tank_armor_bulletdamage = 0.5;
  setdvarifuninitialized("dvar_8E0E41D9572BA691", 0);
  setdvarifuninitialized("dvar_D429FA03FD7003AD", level.tanksettings["remote_tank"].timeout);
  setdvarifuninitialized("scr_pac_sentry_instaspawn", 0);
}

spawn_remote_tank(spawn_node, name, _id_353C9E261AC35AAC) {
  _id_A84CFD847DC1F677 = level.tanksettings["remote_tank"];

  if(isDefined(_id_353C9E261AC35AAC))
    _id_A84CFD847DC1F677 = _id_353C9E261AC35AAC;

  spawn_pos = spawn_node.origin;
  _id_E21A7BAA6BA10015 = spawn_node.angles;

  if(!isDefined(_id_E21A7BAA6BA10015))
    _id_E21A7BAA6BA10015 = (0, 0, 0);

  _id_F5E7C5E12051B3EB = spawnVehicle(_id_A84CFD847DC1F677.modelbase, "veh_pac_sentry_mp_cp", _id_A84CFD847DC1F677.vehicleinfo, spawn_pos, _id_E21A7BAA6BA10015);

  if(!isDefined(_id_F5E7C5E12051B3EB))
    return undefined;

  _id_F5E7C5E12051B3EB.team = "axis";
  _id_F5E7C5E12051B3EB.tanktype = "remote_tank";
  _id_F5E7C5E12051B3EB.streakname = "pac_sentry";
  _id_F5E7C5E12051B3EB.config = _id_A84CFD847DC1F677;
  _id_F5E7C5E12051B3EB.maxhealth = _id_A84CFD847DC1F677.maxhealth;
  _id_F5E7C5E12051B3EB.health = _id_F5E7C5E12051B3EB.maxhealth;
  _id_F5E7C5E12051B3EB.lifetime = _id_A84CFD847DC1F677.lifetime;
  entnumber = _id_F5E7C5E12051B3EB getentitynumber();
  _id_F5E7C5E12051B3EB addtoassaultdronelist(entnumber);
  _id_F5E7C5E12051B3EB thread removefromassaultdronelistondeath(entnumber);
  _id_6EC4C83E2DED9D38 = _id_F5E7C5E12051B3EB gettagorigin("tag_turret");
  mgturret = spawnturret("misc_turret", _id_6EC4C83E2DED9D38, _id_A84CFD847DC1F677.mgturretinfo, 0);
  mgturret linkTo(_id_F5E7C5E12051B3EB, "tag_turret", (0, 0, 0), (0, 0, 0));
  mgturret setModel(level.tanksettings["remote_tank"].mgturretmodelbase);
  mgturret.angles = _id_F5E7C5E12051B3EB.angles;
  mgturret.tank = _id_F5E7C5E12051B3EB;
  mgturret setmode("manual");
  mgturret setturretteam("axis");
  mgturret setdefaultdroppitch(0);
  mgturret setleftarc(360);
  mgturret setrightarc(360);
  mgturret settoparc(45);
  mgturret setbottomarc(45);
  mgturret setconvergencetime(0.05, "yaw");
  mgturret setconvergencetime(0.05, "pitch");
  _id_F5E7C5E12051B3EB.mgturret = mgturret;
  _id_F5E7C5E12051B3EB.spawn_node = spawn_node;
  _id_F5E7C5E12051B3EB.repulsor = createnavrepulsor("tank_repulsor", 0, _id_F5E7C5E12051B3EB, 128, 1);

  if(isDefined(name)) {
    if(!isDefined(level.remote_tanks))
      level.remote_tanks = [];

    level.remote_tanks[name] = _id_F5E7C5E12051B3EB;
  }

  _id_F5E7C5E12051B3EB thread remotetank_rumble();
  return _id_F5E7C5E12051B3EB;
}

remotetank_rumble() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

use_remote_tank(tank) {
  result = playremotesequence("remotetank", 1);

  if(result)
    tank_finishdropoffsequence(self, tank);
}

addtoassaultdronelist(entnumber) {
  if(!isDefined(level.assaultdrones))
    level.assaultdrones = [];

  level.assaultdrones[entnumber] = self;
}

removefromassaultdronelistondeath(entnumber) {
  self waittill("death");
  level.assaultdrones[entnumber] = undefined;
}

tank_finishdropoffsequence(owner, tank) {
  _id_3ECC13DEFFDE644F = tank.origin + (0, 0, 200);
  _id_5ED295AC87F32DF1 = tank.angles;
  _id_0A930350F718EF15 = _id_3ECC13DEFFDE644F - anglesToForward(_id_5ED295AC87F32DF1) * 100;
  _id_76F164F8C60C8101 = _id_5ED295AC87F32DF1;
  _id_E83EABF77C0C1D5A = "on";

  if(isDefined(self.config.turretlightsonstate))
    _id_E83EABF77C0C1D5A = self.config.turretlightsonstate;

  tank.mgturret setscriptablepartstate("lights", _id_E83EABF77C0C1D5A);
  tank.mgturret laseron();
  owner _id_3B64EB40368C1450::set("tank_camera_transition", "fire", 0);
  tank.owner = owner;
  tank.mgturret maketurretoperable();
  tank tank_playercameratransition(_id_3ECC13DEFFDE644F, _id_5ED295AC87F32DF1, _id_0A930350F718EF15, _id_76F164F8C60C8101);
  owner _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tank_camera_transition");
  owner thread startusingtank(tank);
  tank thread tank_watchfortimeoutdisowned();
  tank thread tank_handleairburst();
  tank thread tank_handlewheeldustfx();
}

tank_playercameratransition(_id_3ECC13DEFFDE644F, _id_5ED295AC87F32DF1, _id_2FA874EEF0A932B5, _id_A9EDEC246432DE8B) {
  level endon("game_ended");
  self.owner unlink();
  _id_ABD8070797A8DE25 = spawn("script_model", _id_3ECC13DEFFDE644F);
  _id_ABD8070797A8DE25 setModel("tag_player");
  _id_ABD8070797A8DE25.owner = self.owner;
  _id_ABD8070797A8DE25.angles = _id_5ED295AC87F32DF1;
  self.owner playerlinkweaponviewtodelta(_id_ABD8070797A8DE25, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  level notify("vision_set_change_request", "tac_ops_slamzoom", self.owner, 0.2);
  _id_2FA874EEF0A932B5 = _id_2FA874EEF0A932B5 + (0, 0, 20);
  _id_A9EDEC246432DE8B = vectortoangles(_id_3ECC13DEFFDE644F - _id_2FA874EEF0A932B5);
  _id_ABD8070797A8DE25 moveTo(_id_2FA874EEF0A932B5, 0.5);
  _id_ABD8070797A8DE25 rotateTo(_id_A9EDEC246432DE8B, 0.5);
  self.owner thread tank_startfadetransition();
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("vision_set_change_request", undefined, self.owner, 0.2, "tac_ops_slamzoom");
  self.owner unlink();
  _id_ABD8070797A8DE25 delete();
}

tank_startfadetransition() {
  self endon("disconnect");
  level notify("vision_set_change_request", "tac_ops_slamzoom", self, 0.5);
  wait 0.5;
  level notify("vision_set_change_request", undefined, self, 0.5, "tac_ops_slamzoom");
}

startusingtank(_id_F5E7C5E12051B3EB) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingremotetank = 1;
  _id_F5E7C5E12051B3EB.mgturret setCanDamage(1);
  _id_F5E7C5E12051B3EB setCanDamage(1);
  data = spawnStruct();
  data.deathoverridecallback = ::tank_override_moving_platform_death;
  _id_F5E7C5E12051B3EB setotherent(self);
  _id_F5E7C5E12051B3EB setentityowner(self);
  _id_F5E7C5E12051B3EB.driver = self;
  self controlslinkTo(_id_F5E7C5E12051B3EB);
  self remotecontrolturret(_id_F5E7C5E12051B3EB.mgturret);
  self painvisionoff();
  self setclientomnvar("ui_hide_hud", 1);
  self setclientomnvar("ui_pac_sentry_controls", 1);
  self setclientomnvar("ui_pac_sentry_speed", 0);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(_id_F5E7C5E12051B3EB.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", _id_F5E7C5E12051B3EB.health / _id_F5E7C5E12051B3EB.maxhealth);
  _id_F5E7C5E12051B3EB thread tank_earthquake();
  _id_F5E7C5E12051B3EB thread scripts\cp\utility::allowridekillstreakplayerexit("death");
  scripts\cp\utility::_freezecontrols(0);
}

tank_handlehelidamage() {
  self endon("death");
}

tank_modifyhelidamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  return _id_702BFC08FABD86CB;
}

tank_handlehelideathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(self.intromodel))
    self.intromodel delete();

  self notify("death");
}

tank_modifydamageresponse(data) {
  thread tank_modifydamagestate(data);
  damage = data.damage;
  type = data.meansofdeath;
  return 1;
}

tank_modifydamagestate(data) {
  damage = data.damage;
  self.currenthealth = self.health - damage;
  return 1;
}

tank_override_moving_platform_death(data) {
  thread tank_destroy();
}

tank_watchfortimeoutdisowned() {
  self endon("death");
  tank_watchfortimeoutdisownedendearly();
  thread tank_destroy();
}

tank_watchfortimeoutdisownedendearly() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

tank_destroy(attacker) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  level.remote_tanks = scripts\engine\utility::array_remove(level.remote_tanks, self);
  self notify("death");
  self.mgturret notify("death");

  if(!isDefined(attacker))
    attacker = self.owner;

  if(isDefined(self.driver))
    thread tank_driverexit(self.driver);

  if(isDefined(self.useobj))
    self.useobj delete();

  self.health = 0;
  self setCanDamage(0);
  self.mgturret setmode("sentry_offline");
  waitframe();
}

tank_destroycallback(data) {
  thread tank_destroy(data.attacker);
  return 0;
}

tank_driverexit(driver) {
  self waittill("killstreakExit");
  self notify("end_remote");
  self.driver = undefined;
  driver.isusingremotetank = undefined;
  driver controlsunlink();

  if(isDefined(self.mgturret))
    driver remotecontrolturretoff(self.mgturret);

  if(isDefined(driver.restoreangles)) {
    driver setplayerangles(driver.restoreangles);
    driver.restoreangles = undefined;
  }

  driver setclientomnvar("ui_pac_sentry_controls", 0);
  driver thread stopremotesequence(1);
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  self.mgturret maketurretinoperable();
  driver painvisionon();
}

tank_handleairburst() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", projectile);
    _id_5A60B3AFC04B3E22 = spawn("script_model", projectile.origin);
    _id_5A60B3AFC04B3E22 setModel("ks_pac_sentry_mp");
    _id_5A60B3AFC04B3E22.angles = projectile.angles;
    _id_5A60B3AFC04B3E22 linkTo(projectile);
    _id_5A60B3AFC04B3E22 setentityowner(self.owner);
    thread tank_watchprojectiledeath(projectile, _id_5A60B3AFC04B3E22);
    thread tank_findclosestairbursttarget(projectile);
  }
}

tank_watchprojectiledeath(projectile, _id_9B7AA4DB8D96367F) {
  _id_9B7AA4DB8D96367F endon("death");
  result = projectile scripts\engine\utility::waittill_any_return_2("death", "perform_airburst");

  if(isDefined(result) && result == "perform_airburst") {
    _id_9B7AA4DB8D96367F setscriptablepartstate("airburst", "airExpl");
    _id_9B7AA4DB8D96367F unlink();
    _id_9B7AA4DB8D96367F thread tank_delayairburstscriptabledeath();

    if(isDefined(projectile))
      projectile delete();
  } else
    _id_9B7AA4DB8D96367F delete();
}

tank_delayairburstscriptabledeath() {
  self endon("death");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2);
  self delete();
}

tank_findclosestairbursttarget(_id_EE356ED81B5CB7F4) {
  _id_EE356ED81B5CB7F4 endon("death");
  self endon("death");

  for(;;) {
    _id_42CA41C7DADAE0C0 = undefined;
    _id_F777AFD0B830D8F3 = undefined;
    _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    closestenemies = scripts\engine\utility::get_array_of_closest(_id_EE356ED81B5CB7F4.origin, _id_FC9AC45209F959BB, undefined, 10, 100);

    foreach(enemy in closestenemies) {
      if(!isDefined(enemy) || !scripts\cp\utility::should_be_affected_by_trap(enemy, 1)) {
        continue;
      }
      if(level.teambased && enemy.team == self.owner.team) {
        continue;
      }
      if(!_id_EE356ED81B5CB7F4 tank_canseetarget(enemy)) {
        continue;
      }
      _id_F777AFD0B830D8F3 = enemy;
      break;
    }

    if(isDefined(_id_F777AFD0B830D8F3)) {
      _id_EE356ED81B5CB7F4 notify("perform_airburst");
      break;
    } else
      waitframe();
  }
}

tank_handlewheeldustfx() {
  self endon("death");
  _id_2BDC3E3680DF74EB = 0;

  if(istrue(level.wet_level)) {
    return;
  }
  while(isDefined(self.owner)) {
    _id_E466656788B2BDE5 = self vehicle_getspeed();
    _id_46C9A177682CFDD2 = _id_E466656788B2BDE5 * 1.60934;

    if(_id_E466656788B2BDE5 > 3 && !istrue(_id_2BDC3E3680DF74EB)) {
      _id_2BDC3E3680DF74EB = 1;
      self setscriptablepartstate("dust", "on");
    } else if(_id_E466656788B2BDE5 <= 3 && istrue(_id_2BDC3E3680DF74EB)) {
      _id_2BDC3E3680DF74EB = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(_id_46C9A177682CFDD2));
    waitframe();
  }
}

tank_empgrenaded() {
  self notify("tank_EMPGrenaded");
  self endon("tank_EMPGrenaded");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;
  self.mgturret turretfiredisable();
  wait 3.5;
  self.empgrenaded = 0;
  self.mgturret turretfireenable();
}

tank_watchfiring(_id_F5E7C5E12051B3EB) {
  self endon("disconnect");
  self endon("end_remote");
  _id_F5E7C5E12051B3EB endon("death");
  _id_7C326413A1E419AE = 50;
  _id_6C9F573716FD0F4C = _id_7C326413A1E419AE;
  firetime = weaponfiretime(level.tanksettings[_id_F5E7C5E12051B3EB.tanktype].mgturretinfo);

  for(;;) {
    if(_id_F5E7C5E12051B3EB.mgturret isfiringvehicleturret()) {
      _id_6C9F573716FD0F4C--;

      if(_id_6C9F573716FD0F4C <= 0) {
        _id_F5E7C5E12051B3EB.mgturret turretfiredisable();
        wait 2.5;
        _id_F5E7C5E12051B3EB playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        _id_6C9F573716FD0F4C = _id_7C326413A1E419AE;
        _id_F5E7C5E12051B3EB.mgturret turretfireenable();
      }
    }

    wait(firetime);
  }
}

tank_earthquake() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  while(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.07, 0.25, self gettagorigin("tag_body"), 500);
    wait 0.25;
  }
}

tank_canseetarget(target, offset) {
  if(!isDefined(offset))
    offset = (0, 0, 0);

  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1);
  _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

stopremotesequence(_id_3CFF035C1ECBD186) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    _id_608BEF26DD02E2C7 = "ks_remote_device_mp";

    if(istrue(_id_3CFF035C1ECBD186)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + _id_608BEF26DD02E2C7);
    } else
      self notify("killstreak_finished_with_weapon_" + _id_608BEF26DD02E2C7);

    self takeweapon(_id_608BEF26DD02E2C7);
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::waittill_any_timeout_1(1.3, "death");
  self setclientomnvar("ui_remote_control_sequence", 0);
  self setclientomnvar("ui_hide_hud", 0);
}

playremotesequence(streakinfo, _id_3CFF035C1ECBD186) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp\utility::isusingremote())
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  self notify("play_remote_sequence");
  self playlocalsound("mp_killstreak_tablet_gear");
  _id_608BEF26DD02E2C7 = undefined;

  if(istrue(_id_3CFF035C1ECBD186)) {
    if(self isonladder() || self ismantling() || !self isonground()) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/UNAVAILABLE");
      return 0;
    }

    _id_608BEF26DD02E2C7 = "ks_remote_device_mp";
    scripts\cp\utility::_giveweapon(_id_608BEF26DD02E2C7, 0, 0, 1);
    self setclientomnvar("ui_remote_control_sequence", 1);
    _id_41BF9BF4918115AC = scripts\cp\cp_weapons::switchtoweaponreliable(_id_608BEF26DD02E2C7);

    if(!istrue(_id_41BF9BF4918115AC))
      return 0;
  }

  scripts\cp\utility::setusingremote("remotetank");
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.8);
  result = scripts\engine\utility::waittill_any_timeout_1(1.8, "death");
  self notify("ks_freeze_end");

  if(!isDefined(result) || result != "timeout") {
    self setclientomnvar("ui_remote_control_sequence", 0);
    scripts\cp\utility::_freezecontrols(0);
    scripts\cp\utility::clearusingremote();

    if(isDefined(_id_608BEF26DD02E2C7))
      self notify("finished_with_manual_weapon_" + _id_608BEF26DD02E2C7);

    self stoplocalsound("mp_killstreak_tablet_gear");
    self notify("cancel_remote_sequence");
    return 0;
  }

  scripts\cp\utility::_freezecontrols(0);
  self setclientomnvar("ui_remote_control_sequence", 0);
  return 1;
}

fire_on_nearby_players(_id_B026D19BC14D8AD0) {
  self endon("death");
  level endon("wheelsons_deactivated");
  self.targetent = spawn("script_origin", self.origin);
  lights_on = 0;
  time_before_shoot = 0.75;

  if(isDefined(self.time_before_shoot))
    time_before_shoot = self.time_before_shoot;

  time_after_shoot = 0.5;

  if(isDefined(self.time_after_shoot))
    time_after_shoot = self.time_after_shoot;

  if(!isDefined(self.max_detection_sq))
    self.max_detection_sq = 54289;

  thread flicker_tank_lights();
  target_offset = (0, 0, 50);

  for(;;) {
    while(!isDefined(self.owner)) {
      _id_0D9E5028F8ED076F = undefined;

      foreach(player in level.players) {
        if(distancesquared(self.mgturret.origin, player.origin) > self.max_detection_sq) {
          continue;
        }
        if(isDefined(self.last_attacker) && gettime() <= self.last_attack_time + 5000) {} else if(isDefined(_id_B026D19BC14D8AD0)) {
          fov = _id_B026D19BC14D8AD0;

          if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, player.origin, fov))
            continue;
        }

        target_offset = get_offset_from_stance(_id_0D9E5028F8ED076F);

        if(!tank_canseetarget(player, target_offset)) {
          continue;
        }
        if(!isDefined(self.last_target) || player != self.last_target)
          self.last_target = undefined;

        _id_0D9E5028F8ED076F = player;
        break;
      }

      if(!isDefined(_id_0D9E5028F8ED076F)) {
        wait 0.5;
        self.mgturret cleartargetentity();

        if(lights_on) {
          self.mgturret laseroff();
          lights_on = 0;
        }

        self.last_target = undefined;
        continue;
      } else {
        if(!lights_on) {
          self.mgturret laseron();
          thread flicker_tank_lights();
          lights_on = 1;
        }

        target_offset = get_offset_from_stance(_id_0D9E5028F8ED076F);
        self.mgturret settargetentity(_id_0D9E5028F8ED076F, target_offset);
        self.mgturret scripts\engine\utility::waittill_any_timeout_1(5, "turret_on_target");

        if(!_id_0D9E5028F8ED076F scripts\cp\utility::is_valid_player() || !tank_canseetarget(_id_0D9E5028F8ED076F, target_offset)) {
          wait 0.5;

          if(lights_on) {
            self.mgturret laseroff();
            lights_on = 0;
          }

          self.last_target = undefined;
          continue;
        }

        if(_id_0D9E5028F8ED076F scripts\cp\utility::is_valid_player()) {
          if(!isDefined(self.last_target)) {
            self.last_target = _id_0D9E5028F8ED076F;
            _id_0D9E5028F8ED076F playlocalsound("canister_warning");
          }
        }

        wait(time_before_shoot);
        target_offset = get_offset_from_stance(_id_0D9E5028F8ED076F);

        if(!_id_0D9E5028F8ED076F scripts\cp\utility::is_valid_player() || !tank_canseetarget(_id_0D9E5028F8ED076F, target_offset) || distancesquared(self.mgturret.origin, _id_0D9E5028F8ED076F.origin) > self.max_detection_sq) {
          if(lights_on) {
            self.mgturret laseroff();
            lights_on = 0;
          }

          continue;
        }

        if(isDefined(self.config.turretoverridefunc))
          [[self.config.turretoverridefunc]](_id_0D9E5028F8ED076F);
        else
          self.mgturret shootturret();

        thread notify_nearby_enemies();
        _id_0D9E5028F8ED076F thread damage_nearby_dynolights();
        wait(time_after_shoot);
      }

      wait 0.5;
    }

    wait 0.1;
  }
}

notify_nearby_enemies() {
  level notify("enemy_spotted", self);
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  enemy_notify_range = 1000;

  if(isDefined(self.enemy_notify_range))
    enemy_notify_range = self.enemy_notify_range;

  _id_4CF33B57655A86C3 = scripts\engine\utility::get_array_of_closest(self.origin, enemies, undefined, undefined, enemy_notify_range);

  foreach(enemy in _id_4CF33B57655A86C3)
  enemy notify("bulletwhizby");
}

get_offset_from_stance(_id_0D9E5028F8ED076F) {
  target_offset = (0, 0, 50);

  if(isPlayer(_id_0D9E5028F8ED076F)) {
    stance = _id_0D9E5028F8ED076F getstance();

    switch (stance) {
      case "crouch":
        target_offset = (0, 0, 25);
        break;
      case "prone":
        target_offset = (0, 0, 0);
        break;
      default:
        target_offset = (0, 0, 50);
        break;
    }
  }

  return target_offset;
}

damage_nearby_dynolights() {
  if(!scripts\cp\utility::is_valid_player()) {
    return;
  }
  _id_88724D62DE58751F = getEntArray("office_light_destructible", "script_noteworthy");
  _id_E51D844CF1BAF9A9 = scripts\engine\utility::get_array_of_closest(self.origin, _id_88724D62DE58751F, undefined, 2, 350);

  if(_id_E51D844CF1BAF9A9.size == 0) {
    return;
  }
  foreach(light in _id_E51D844CF1BAF9A9)
  light notify("damage", 1000);
}

flicker_tank_lights() {
  self endon("death");
  _id_E83EABF77C0C1D5A = "on";

  if(isDefined(self.config.turretlightsonstate))
    _id_E83EABF77C0C1D5A = self.config.turretlightsonstate;

  self.mgturret setscriptablepartstate("lights", "off");
  wait 0.5;
  self.mgturret setscriptablepartstate("lights", _id_E83EABF77C0C1D5A);
}