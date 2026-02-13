/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2652.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("pac_sentry", ::_id_F79A);
  level._id_EE49 = [];
  level._id_EE49["remote_tank"] = spawnStruct();
  level._id_EE49["remote_tank"]._id_F224 = 30.0;
  level._id_EE49["remote_tank"].maxhealth = 800;
  level._id_EE49["remote_tank"].streakname = "pac_sentry";
  level._id_EE49["remote_tank"].modelbase = "tank_goscar";
  level._id_EE49["remote_tank"]._id_9FD1 = "tank_goscar";
  level._id_EE49["remote_tank"]._id_9FD5 = "tank_goscar";
  level._id_EE49["remote_tank"].vehicleinfo = "ksveh_tank_goscar_mp";
  level._id_EE49["remote_tank"]._id_EA5A = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level._id_EE49["remote_tank"]._id_CC16 = "destroyed_pac_sentry";
  level._id_EE49["remote_tank"]._id_1068F = "destroyed_pac_sentry";
  level._id_EE49["remote_tank"]._id_484B = "callout_destroyed_pac_sentry";
  level._id_EE49["remote_tank"]._id_BBB8 = undefined;
  level._id_EE49["remote_tank"]._id_BA55 = ::_id_EE13;
  level._id_EE49["remote_tank"]._id_43E5 = ::_id_EDF5;
  level._effect["remote_tank_dying"] = loadfx("vfx/s4/killstreaks/vfx_goliath_death_exp_rnr.vfx");
  level._effect["remote_tank_explode"] = loadfx("vfx/s4/killstreaks/vfx_goliath_death_exp_rnr.vfx");
  level._effect["remote_tank_explode_alt"] = loadfx("vfx/s4/killstreaks/vfx_goliath_death_exp_rnr.vfx");
  level._effect["remote_tank_crate_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_wheelson_exp_imp.vfx");
  level._id_C333 = 0.5;
  _id_8223();
  _id_8011();
  level._id_7DA1 = 0;
  level._id_7DA9["allies"] = 0;
  level._id_7DA9["axis"] = 0;
  level._id_C343 = [];

  foreach(var_1 in level._id_EE49) {
    if(isDefined(var_1._id_79C0)) {
      _id_0AAF::_id_D42B(var_1.streakname, var_1._id_79C0);
    }
  }

  scripts\cp_mp\vehicles\vehicle_spawn::_id_1028B("pac_sentry", 32);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 18, "thermite_bolt_mp");
  }

  _id_0AAF::_id_D447("s4_c4_mp", 5, "pac_sentry");
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("pac_sentry", "third_person_hud_on", 11);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("pac_sentry", "first_person_hud_on", 12);
  game["dialog"]["battlespace_crowded"] = "mp_glob_kill_bchr_tbfu";
}

_id_8223() {
  var_0 = _id_09E2::_id_10144("pac_sentry", 1);
  var_0._id_5FDC = 32;
  var_0._id_2093 = 32;
  var_0._id_919A = 22;
  var_0._id_C862 = 22;
  var_0._id_2954 = 10;
  var_0._id_4B96 = 20;
}

_id_8011() {
  game["dialog"]["pac_sentry_missile_lock"] = "pac_sentry_missile_lock";
}

_id_10D95(var_0) {
  return 1;
}

_id_47EF(var_0) {
  self notify("finished_deploy_weapon");
}

_id_F799() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("pac_sentry", self);
  return _id_F79A(var_0);
}

_id_F79A(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = _id_EE02(100);

  if(!isDefined(var_1)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/NOT_ENOUGH_SPACE");
    return 0;
  }

  if(scripts\mp\utility\game::isbasegametype()) {
    if(isDefined(level.nuke_crate_spawns_and_carriers)) {
      if(scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, self)) {
        scripts\mp\hud_message::_id_DCA2("MP/SUPERS_UNAVAILABLE");
        return 0;
      }
    }

    var_2 = self _meth_876E("ui_base_open_purchase_menu");

    if(var_2) {
      return 0;
    }
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_006")) {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_006");
  } else {
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_goscar");
    thread _id_07A9::logevent_votriggered(self, "quiptrigger_006", "none");
  }

  if(!isbot(self)) {
    var_3 = makeweapon("s4_ks_remote_goliath_mp");
    var_4 = _id_09B9::_id_EA05(var_0, ::_id_10D95, undefined, undefined, ::_id_47EF, "s4_ks_remote_goliath_mp");

    if(!istrue(var_4)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    scripts\mp\hud_message::_id_DCA2(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::_id_7DEF();
  var_5 = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 + var_5 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/TOO_MANY_VEHICLES");
    var_0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    scripts\mp\utility\killstreak::_id_455A();
    return 0;
  }

  level._id_7DA1++;
  var_6 = 2;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_6 = 4;
  }

  if(level._id_C343.size >= var_6 || level._id_C343.size + level._id_7DA1 > var_6) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/TOO_MANY_VEHICLES");
    level._id_7DA1--;
    var_0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    scripts\mp\utility\killstreak::_id_455A();
    return 0;
  }

  if(level.teambased) {
    var_7 = 1;

    if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
      var_7 = 2;
    }

    level._id_7DA9[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::_id_6BAC(self.team, level._id_C343) + level._id_7DA9[self.team] > var_7) {
      level._id_7DA1--;
      level._id_7DA9[self.team]--;
      scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
      _id_0A8D::_id_9137("battlespace_crowded");
      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      scripts\mp\utility\killstreak::_id_455A();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_8 = _id_E72B(var_0);
  level._id_7DA1--;

  if(level.teambased) {
    level._id_7DA9[self.team]--;
  }

  if(!istrue(var_8)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/NOT_ENOUGH_SPACE");
    scripts\mp\utility\killstreak::_id_455A();
    return 0;
  }

  return 1;
}

_id_6C1E(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

_id_6C1C(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

_id_E72B(var_0) {
  self _meth_865E();
  var_1 = _id_EE02(100);

  if(!isDefined(var_1)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_3 = getdvarint("#x3f7a4093b4444e8fa", 1);
  var_4 = undefined;
  var_5 = undefined;

  if(!var_3) {
    var_6 = scripts\engine\utility::_id_5000(var_1, 50, -200, (0, 0, 1));
    var_6 = var_6 + (0, 0, 1);
    var_5 = spawn("script_model", var_6);
    var_5 setModel("offhand_wm_grenade_smoke");
    var_5.angles = (0, 90, 90);
    var_4 = spawn("script_model", var_6);
    var_4 setModel("ks_crate_marker_mp");
    var_4 setscriptablepartstate("smoke", "on", 0);
    var_5 playSound("smoke_grenade_expl_atmo");
  }

  self._id_C707 = self getplayerangles();
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\common\utility::_id_153E(0);
  var_3 = getdvarint("#x3f7a4093b4444e8fa", 0);

  if(!var_3) {
    var_7 = self.angles[1];
    var_8 = var_1 * (1, 1, 0) + (0, 0, 850);
    var_9 = _id_6C1E(var_8, var_7);
    var_10 = _id_6C1C(var_8, var_7);
    var_8 = var_8 + anglesToForward((0, var_7, 0)) * -50;
    var_11 = _id_3FBF(self, var_9, var_8);
    var_11._id_5072 = "pac_sentry";
    var_11 setvehgoalpos(var_8, 1);
    var_11 thread _id_EE03(self, var_1, var_10, var_0, var_4, var_5);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    var_12 = _id_405D("remote_tank", self, var_0, var_1, undefined, var_3);

    if(!isDefined(var_12)) {
      scripts\mp\utility\killstreak::_id_455A();
      scripts\mp\utility\player::_freezecontrols(0);
      scripts\common\utility::_id_153E(1);
      return 0;
    }

    scripts\common\utility::_id_153E(1);
    thread _id_E739(var_12, var_3);
    thread _id_A113(var_12);
    createspawndangerzone(var_12);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1);
  scripts\common\utility::_id_F73A(level._id_9BB4, "pac_sentry", self.origin);
  thread scripts\mp\hud_util::_id_EF8D("used_pac_sentry", self);
  return 1;
}

_id_A113(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  setdvarifuninitialized("#x3b5feaca052c96a00", 0);

  if(getdvarint("#x3b5feaca052c96a00", 0) == 1) {
    return;
  }
  if(scripts\mp\utility\game::isbasegametype()) {
    thread monitorgoliathdetonatebase(var_0);
  }

  wait 2.0;
  thread monitorgoliathdetonatecmd(var_0);

  while(anglestoup(var_0.angles)[2] > 0.15) {
    waitframe();
  }

  _id_48CE(var_0);
}

monitorgoliathdetonatecmd(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  self notifyonplayercommand("detonate", "+attack");
  self waittill("detonate");
  _id_48CE(var_0);
}

monitorgoliathdetonatebase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  self waittill("base_redeploy_detonate");
  _id_48CE(var_0);
}

createspawndangerzone(var_0) {
  var_1 = getdvarint("#x39bded448edbcf82a", 0) == 1;

  if(!var_1) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_0.spawndangerzone = _id_0817::_id_1135(var_0.origin, 100, 100, self.team, undefined, self, 0, var_0, 1, 1);

  if(isDefined(var_0.spawndangerzone)) {
    var_0 _id_0817::influencepoint_linktoent(var_0.spawndangerzone, var_0);
  }
}

debugdrawspawndangerzone() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(getdvarint("#x31c953f886889303d", 0) == 1) {
      var_0 = (1, 0, 0);
      _id_09C0::_id_4F3D(self.origin, 100, 100, 0.05, var_0);
    }

    wait 0.05;
  }
}

remotetank_watchkills() {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self._id_C0F4) && isDefined(self._id_C0F4["pac_sentry_turret_mp"])) {
    switch (self._id_C0F4["pac_sentry_turret_mp"]) {
      case 0:
        break;
      case 1:
        _id_0A8D::_id_9137("goliath_kill_1");
      case 3:
      case 2:
        break;
      default:
        break;
    }
  }
}

_id_48CE(var_0) {
  var_0.owner thread _id_B829(var_0 gettagorigin("tag_player"), var_0.angles, var_0.owner);
  var_0.owner thread _id_B82A(var_0.origin, var_0.angles, var_0.owner, var_0 _meth_8726());
  var_0 thread _id_EDF4();
}

_id_B829(var_0, var_1, var_2) {
  if(var_2 _id_0819::isredeploying()) {
    return;
  }
  var_0 = var_0 + (0, 0, 10);
  var_3 = anglesToForward(var_1);
  var_4 = (0, 0, 100);
  var_5 = var_1[0];

  if(vectordot(var_3, (0, 0, 1)) > 0.3) {
    var_4 = var_4 * (1 - vectordot(var_3, (0, 0, 1)));
    var_6 = _func_025B(var_3, (0, 0, 1));
    var_3 = _func_025B((0, 0, 1), var_6);
    var_5 = 0;
  }

  var_7 = (0, 0, 40);
  var_8 = vectornormalize(var_3) * -75;
  var_9 = scripts\engine\trace::ray_trace(var_0, var_0 + var_7 + var_8);

  if(var_9["hittype"] != "hittype_none") {
    var_7 = var_7 * 0;
    var_8 = var_8 * 0;
  }

  var_10 = spawn("script_model", var_0 + var_7 + var_8);
  var_10 setModel("tag_origin");
  var_10.angles = (var_5 + 25, var_1[1], 0);
  var_11 = vectornormalize(var_3) * -145;
  var_12 = var_10.origin + var_4 + var_11;
  var_9 = scripts\engine\trace::ray_trace(var_0, var_12);

  if(var_9["hittype"] != "hittype_none") {
    var_12 = var_10.origin + (var_11 + var_4) * var_9["fraction"] * 0.5;
  }

  var_2 cameralinkto(var_10, "tag_origin", 1);
  var_10 moveto(var_12, 0.2);
}

_id_B82A(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("disconnect");
  var_4 = spawn("script_model", var_0);
  var_4 setModel(level._id_EE49["remote_tank"].modelbase);
  var_4.angles = var_1;
  var_4 _meth_8851(3, var_2.team);

  if(var_3) {
    wait 0.1;
  }

  var_5 = level._effect["remote_tank_explode"];
  var_6 = playFX(var_5, var_0);
  thread _id_084C::goliath_explosion(var_0, var_2, var_6);
  thread detonatedannouncer(var_2);
  earthquake(0.6, 1.5, var_0, 300);
  var_4 radiusdamage(var_0, 400, 1000, 1000, var_2, "MOD_EXPLOSIVE", "pac_sentry_turret_mp");
  var_2 thread remotetank_watchkills();
  waitframe();
  var_4 delete();
}

detonatedannouncer(var_0) {
  wait 1;
  var_0 thread _id_0A8D::_id_9137("goliath_detonate");
}

_id_3FBF(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = "veh_airdrop_mp";
  var_5 = spawnhelicopter(var_0, var_1, var_3, var_4, "veh8_mil_air_lbravo");

  if(!isDefined(var_5)) {
    return;
  }
  var_5 playLoopSound("veh_apache_killstreak_amb_lr");
  var_5.maxhealth = 500;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5._id_873D = 1;
  var_5 setmaxpitchroll(15, 15);
  var_5 vehicle_setspeed(250, 175);
  var_5._id_77E7 = "airdrop";
  var_5._id_298C = spawn("script_model", var_5.origin - (0, 0, 100));
  var_5._id_298C setModel("veh8_mil_lnd_whotel_crate");
  var_5._id_298C.angles = var_5.angles;
  var_5._id_298C linkto(var_5);
  var_5._id_84D4 = spawn("script_model", var_5._id_298C.origin);
  var_5._id_84D4 setModel("tank_goscar");
  var_5._id_84D4.angles = var_5._id_298C.angles;
  var_5._id_84D4.owner = var_5.owner;
  var_5._id_84D4 linkto(var_5._id_298C);
  var_5._id_84D4 _meth_82CB("mp_wheelson_drop_intro");
  var_5.owner setclientomnvar("ui_pac_sentry_controls", 1);
  var_5.owner setclientomnvar("ui_pac_sentry_speed", 0);
  var_5.owner setclientomnvar("ui_killstreak_health", 800);
  var_5 thread scripts\mp\killstreaks\helicopter::_id_7699("pac_sentry");
  var_5 scripts\mp\utility\killstreak::_id_1155(var_5._id_77E7, "Killstreak_Air", var_0, 0, 1, 100);
  var_5 thread _id_EE07();
  return var_5;
}

_id_405D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_EE49[var_0];
  var_7 = var_1.angles;

  if(isDefined(var_4)) {
    var_7 = var_4.angles;
  }

  var_8 = spawnStruct();
  var_8.origin = var_3;
  var_8.angles = var_7;
  var_8.modelname = var_6.modelbase;
  var_9 = scripts\cp_mp\utility\player_utility::_id_6C67(var_1);

  if(var_9) {
    var_8.modelname = var_6._id_9FD1;
  }

  var_8._id_0481 = var_0;
  var_8._id_04DE = var_6.vehicleinfo;
  var_8.owner = var_1;
  var_8._id_31A0 = 1;
  var_10 = spawnStruct();
  var_11 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_8, var_10);

  if(!isDefined(var_11)) {
    return undefined;
  }

  var_12 = getdvarint("#x3166d3ee7fe08a327", var_6._id_F224);
  var_11.team = var_1.team;
  var_11.owner = var_1;
  var_1.remotetank = var_11;
  var_11.streakinfo = var_2;
  var_11._id_EE5F = var_0;
  var_11._id_3B73 = var_6;
  var_11.maxhealth = var_6.maxhealth;
  var_11.health = var_11.maxhealth;
  var_11.lifetime = var_12;
  var_11._id_EB25 = var_9;
  var_11._id_41BE = 0;
  var_11.weapon_name = "tracked_mine";
  var_11 setotherent(var_1);
  var_11 _meth_83A6(var_11.team);
  var_11 _meth_8851(3, var_11.team);
  var_11 _id_0812::_id_C2B2("Killstreak_Ground", var_1);
  var_11 scripts\mp\utility\killstreak::_id_8DB7(var_2.streakname, var_6._id_CC16, var_6._id_1068F, undefined, var_6._id_484B);
  var_11 scripts\mp\utility\killstreak::_id_8DC1(var_2.streakname, var_6._id_BBB8);
  var_11 scripts\mp\utility\killstreak::_id_8DC0(var_2.streakname, var_6._id_BA55);
  var_11 scripts\mp\utility\killstreak::_id_8DBF(var_2.streakname, var_6._id_43E5);
  scripts\cp_mp\utility\weapon_utility::_id_D5E7(var_11, ::_id_EE10);
  scripts\cp_mp\utility\weapon_utility::_id_D5E8(var_11, ::_id_EE11);
  var_11._id_FE90 = spawn("script_model", var_11 gettagorigin("tag_body"));
  var_11._id_FE90 linkto(var_11, "tag_body");

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_reaper") && scripts\cp_mp\utility\killstreak_utility::_id_C0B7("pac_sentry")) {
    var_11.maxhealth = var_11.maxhealth * 1.5;
    var_11.health = var_11.health * 1.5;

    foreach(var_16, var_15 in var_1._id_E9FF._id_EA14) {
      if(var_15.streakname == "pac_sentry" && istrue(var_1._id_E9FF._id_EA14[var_16]._id_C0B4)) {
        var_1._id_E9FF._id_EA14[var_16]._id_C0B4 = undefined;
      }
    }
  }

  var_11 _meth_86A2(0);
  var_11 thread _id_EE34();
  var_11 thread _id_EE33();
  var_11 thread _id_EE09();
  var_11 thread _id_EE2D();
  var_11._id_357A = [var_11];

  if(istrue(var_5)) {
    var_17 = 1;
    var_18 = "third_person_hud_on";

    if(isDefined(var_1._id_BC42)) {
      var_17 = var_1._id_BC42;

      if(var_18 == 2) {
        var_18 = "first_person_hud_on";
      }
    }

    var_1 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_11.streakinfo.streakname, var_18);
    var_1 setclientomnvar("ui_pac_sentry_controls", var_17);
    var_1 setclientomnvar("ui_pac_sentry_speed", 0);
    var_1 setclientomnvar("ui_killstreak_health", 800);
    scripts\mp\outofbounds::_id_C259(var_11, "killstreak");
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(var_11, var_1, var_1.team);
  level._id_C343[level._id_C343.size] = var_11;
  var_11 scripts\mp\utility\killstreak::_id_1155(var_2.streakname, "Killstreak_Ground", var_1, 0, 1, 25);
  level notify("matchrecording_small_ground_vehicle", var_11);
  return var_11;
}

_id_EE10() {
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("pac_sentry_missile_lock");
  _id_09CA::_id_10390("missileLocking", self.owner, "killstreak");
}

_id_EE11() {
  _id_09CA::_id_1037B("missileLocking", self.owner, "killstreak");
}

_id_EE03(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self waittill("goal");
  self setyawspeed(40, 20, 20, 0.3);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self notify("drop_crate");
  self._id_298C unlink();
  self._id_298C moveto(var_1, 1.5, 1);
  self._id_84D4 _meth_82CB("mp_wheelson_drop_release");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self._id_84D4 _meth_82CB("mp_wheelson_drop_land");
  earthquake(0.3, 0.1, self._id_84D4.origin, 400);
  playrumbleonposition("artillery_rumble", self._id_84D4.origin);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.7);
  var_6 = self._id_84D4 gettagorigin("tag_player");
  var_7 = self._id_84D4.angles;
  var_8 = var_6 - anglesToForward(var_7) * 500;
  var_9 = var_7;
  playFX(scripts\engine\utility::getfx("remote_tank_crate_explode"), self._id_84D4.origin);
  earthquake(0.3, 0.1, self._id_84D4.origin, 400);
  playrumbleonposition("damage_heavy", self._id_84D4.origin);
  self._id_298C delete();
  self._id_84D4 delete();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_10 = _id_405D("remote_tank", var_0, var_3, var_1, self);

  if(!isDefined(var_10)) {
    scripts\mp\utility\killstreak::_id_455A();
    var_0 scripts\mp\utility\player::_freezecontrols(0);
    var_0 scripts\common\utility::_id_153E(1);
    return 0;
  }

  var_10 _id_EE1E(var_6, var_7, var_8, var_9);
  var_0 scripts\common\utility::_id_153E(1);
  var_0 thread _id_E739(var_10);
  self setvehgoalpos(var_2, 1);
  self._id_916C = 1;
  self waittill("goal");
  self delete();
  var_4 delete();
  var_5 delete();
}

_id_EE1E(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.owner unlink();
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_player");
  var_4.owner = self.owner;
  var_4.angles = var_1;
  self.owner _meth_826E(var_4, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner _meth_8266(0);
  self.owner visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var_2 = var_2 + (0, 0, 20);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 moveto(var_2, 0.5);
  var_4 rotateto(var_3, 0.5);
  self.owner thread _id_EE27();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self.owner visionsetkillstreakforplayer("", 0.2);
  self.owner unlink();
  var_4 delete();
}

_id_EE27() {
  self endon("disconnect");
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.5);
  wait 0.5;
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.5);
}

_id_EE2B(var_0) {
  self endon("death");
  _id_EDF8(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 setplayerangles(var_0.angles);
    var_1 playerlinkto(self, "tag_playerride");
    var_1 thread _id_EE3C(var_0, self);
  }
}

_id_EDF8(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.team) && var_2.team == self.team) {
      continue;
    }
    var_2 disableplayeruse();
  }

  thread _id_EDF7(var_0);
}

_id_EDF7(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1.team) && var_1.team == self.team) {
      var_0 _meth_80E0(var_1);
      continue;
    }

    var_0 disableplayeruse(var_1);
  }
}

_id_EE3C(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  while(isDefined(var_0) && self _meth_81F4()) {
    waitframe();
  }

  var_2 = _id_EE01(var_1);
  self unlink();
  self dontinterpolate();
  self.origin = var_2;
  self.angles = var_0.angles;
  self notify("done_using_turret");
}

_id_EE01(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_2 * 100;
  var_5 = var_0.origin - var_2 * 100;
  var_6 = var_0.origin + var_3 * 100;
  var_7 = var_0.origin - var_3 * 100;
  var_8 = [var_5, var_6, var_7, var_4];

  foreach(var_11, var_10 in var_8) {
    if(_func_0036(var_10, 40, 80, var_0, 0, 1)) {
      var_1 = var_10;
      break;
    }
  }

  return var_1;
}

_id_E739(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(1);
  var_2 = spawnStruct();
  var_2._id_B385 = 1;
  var_2._id_43F7 = ::_id_EE1B;
  var_0 thread scripts\mp\movers::_id_7403(var_2);
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0._id_4F62 = self;

  if(istrue(var_1)) {
    self unlink();
  }

  self _meth_8094(var_0);
  self cameralinkto(var_0, "tag_player", 0, 1);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", var_0.health / var_0.maxhealth);
  _id_09C8::_id_0D89();
  scripts\common\utility::_id_157E(0);
  scripts\mp\outofbounds::_id_C259(var_0, "killstreak");
  var_0 thread _id_EDFA();
  scripts\mp\utility\player::_id_5265(0, "remoteTank");
  _id_0817::_id_1137(var_0);
  var_0 _id_078D::_id_D3BA(::_id_EDFD);
  var_0 _id_078D::_id_D189(::_id_EDFB);
  scripts\mp\utility\player::_freezecontrols(0);

  foreach(var_4 in level._id_EF89) {
    if(var_4 != self.team) {
      _id_0A8D::_id_9136("gt_enemy_use", var_4);
    }
  }
}

_id_EE07() {
  self endon("death");
  _id_07C3::_id_A0FF(self.maxhealth, "", ::_id_EE08, ::_id_EE15, 1);
}

_id_EE15(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 1);
  return var_6;
}

_id_EE08(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(isDefined(self._id_84D4)) {
    self._id_84D4 delete();
  }

  self notify("death");
}

_id_EE13(var_0) {
  thread _id_EE14(var_0);
  var_1 = var_0.damage;
  var_2 = var_0._id_9CD6;

  if(isDefined(self.owner) && self.owner scripts\mp\utility\player::_id_8ACE()) {
    if(_func_010F(var_2)) {
      if(_func_0037(var_1 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.origin, 150);
        self.owner _meth_827A("damage_heavy", self.owner getEye());
      }
    } else {
      self.owner earthquakeforplayer(0.15, 0.15, self.origin, 150);
      self.owner _meth_827A("damage_light", self.owner getEye());
    }
  }

  return 1;
}

_id_EE14(var_0) {
  var_1 = var_0.damage;
  self._id_41CA = self.health - var_1;

  if(self._id_41CA <= int(self.maxhealth / 1.2) && self._id_41BE == 0) {
    self._id_41BE = 1;
    self setscriptablepartstate("body_damage_light", "on");
  } else if(self._id_41CA <= int(self.maxhealth / 2) && self._id_41BE == 1) {
    self._id_41BE = 2;
    self setscriptablepartstate("body_damage_medium", "on");
  } else if(self._id_41CA <= int(self.maxhealth / 3) && self._id_41BE == 2) {
    self._id_41BE = 3;
    self setscriptablepartstate("body_damage_heavy", "on");
  }

  self.owner setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
  return 1;
}

_id_EE1B(var_0) {
  thread _id_EDF4();
}

_id_EE34() {
  self endon("death");
  level endon("game_ended");
  _id_EE35();
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_pac_sentry", 1);

  if(getdvarint("#x3b5feaca052c96a00", 0) == 0) {
    _id_48CE(self);
  }
}

_id_EE35() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("team_kill_punish");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

_id_EE33() {
  self endon("death");
  level waittill("game_ended");
  thread _id_EDF4();
}

_id_EDF4(var_0, var_1, var_2) {
  if(istrue(self._id_4847)) {
    return;
  } else {
    self._id_4847 = 1;
  }

  self notify("death");

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  if(isDefined(self.owner.remotetank)) {
    self.owner.remotetank = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_102BB(self);
  self._id_FE90 delete();
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(0);
  _id_C4C3(self getentitynumber());
  _id_078D::_id_38CB(1);
  _id_078D::_id_1538(0);
  scripts\mp\outofbounds::_id_3964(self, 1);
  self.streakinfo._id_57A7 = istrue(var_1);
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);

  if(isDefined(var_1) && var_1) {
    var_3 = level._effect["remote_tank_explode_alt"];
    playFX(var_3, self.origin);

    foreach(var_5 in level._id_EF89) {
      if(var_5 != self.team) {
        _id_0A8D::_id_9136("gt_destroyed", var_5);
      }
    }

    if(var_0 != self.owner) {
      var_0 scripts\mp\battlechatter_mp::_id_555B(self);
    }
  }

  if(isDefined(self._id_4F62)) {
    thread _id_EDF9(self._id_4F62, var_1);
  }

  if(isDefined(self.spawndangerzone)) {
    _id_0817::_id_C51F(self.spawndangerzone);
    self.spawndangerzone = undefined;
  }

  scripts\mp\utility\killstreak::_id_455A();
  level._id_C343 = scripts\engine\utility::array_remove(level._id_C343, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_EDF5(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");
  thread _id_EDF4(var_0.attacker, 1, var_1);

  if(isDefined(var_0.attacker) && var_0.attacker.team != self.team) {
    var_0.attacker thread _id_07BC::createfieldupgradechallengeevent("destroy", var_1);
  }

  return 0;
}

_id_EDF9(var_0, var_1) {
  var_0 endon("disconnect");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  _id_EE11();
  self._id_4F62 = undefined;
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_pac_sentry_controls", 0);

  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var_0 painvisionon();
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
  var_0 scripts\mp\utility\player::_id_5265(1, "remoteTank");
  _id_0817::_id_C528(self);

  if(scripts\mp\utility\player::isreallyalive(var_0) && !var_1) {
    wait 1.5;
  }

  var_0 _meth_8095();

  if(!var_0 _id_0819::isredeploying()) {
    var_0 _meth_8060();
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 _id_09C8::_id_0D89();
    var_0 scripts\common\utility::_id_157E(1);
    level thread scripts\cp_mp\utility\killstreak_utility::_id_C70C(var_0);
  }
}

_id_EE1F(var_0, var_1) {
  var_0 unlink();
}

_id_EE06() {
  self endon("death");

  for(;;) {
    self._id_9E6C waittill("missile_fire", var_0);
    var_0.owner = self.owner;
    var_0.streakinfo = self.streakinfo;
    var_1 = spawn("script_model", var_0.origin);
    var_1 setModel("ks_pac_sentry_mp");
    var_1.angles = var_0.angles;
    var_1.team = self.team;
    var_1.owner = self.owner;
    var_1.streakinfo = self.streakinfo;
    var_1 setentityowner(self.owner);
    var_1 dontinterpolate();
    self.streakinfo._id_DA63++;
    _id_EE00(var_0, var_1);
  }
}

_id_EE00(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0.origin;
  var_4 = var_3 + var_2 * 22500;
  var_5 = [var_0, var_1, self.owner];
  var_6 = scripts\engine\trace::_id_3EE5(1, 0, 0, 0, 0, 0, 0, 0, 0);
  var_7 = scripts\engine\trace::_id_E40C(var_3, var_4, 60, var_5, var_6);
  var_8 = 0;

  if(isDefined(var_7[0])) {
    for(var_9 = 0; var_9 < var_7.size - 1; var_9++) {
      var_10 = var_7[var_9]["entity"];
      var_11 = var_7[var_9]["position"];
      var_12 = var_7[var_9]["shape_position"];

      if(isDefined(var_10)) {
        if(level.teambased) {
          if(var_10.team == var_1.team) {
            continue;
          }
        }

        if(!scripts\engine\trace::ray_trace_passed(var_12, var_11, var_1)) {
          continue;
        }
      }

      var_8 = 1;
      var_13 = distance(var_3, var_12) / 7500;
      var_0 thread _id_EE32(var_11, var_12, var_13, var_1, self);
      break;
    }
  }

  if(!istrue(var_8)) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_EE32(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(isDefined(self)) {
    self delete();
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3.origin = var_1;
  var_3 setscriptablepartstate("airburst", "airExpl");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1, 100, 100, var_3.team, 1, var_3.owner, 1);
  }

  var_3 thread _id_EDF3();
}

_id_EDF3() {
  self endon("death");
  self._id_50A0 = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

_id_EE09() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    var_1 = self _meth_842E();
    var_2 = var_1 * 1.60934;

    if(var_1 > 1 && !istrue(var_0)) {
      var_0 = 1;
      self setscriptablepartstate("dust", "on");
    } else if(var_1 <= 1 && istrue(var_0)) {
      var_0 = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(var_2));
    waitframe();
  }
}

_id_10DFD() {
  self endon("death");
  level endon("game_ended");
  thread _id_10DFC();

  for(;;) {
    var_0 = self.owner;

    if(isDefined(var_0)) {
      var_1 = var_0 getnormalizedmovement();
      var_2 = abs(var_1[0]);

      if(var_2 >= 0.15) {
        _id_10DFE();
      } else {
        _id_10DFF();
      }
    } else
      _id_10DFF();

    waitframe();
  }
}

_id_10DFE() {
  self endon("death");
  self endon("wheelson_stop_engine");
  level endon("game_ended");

  if(istrue(self._id_545B)) {
    return;
  }
  self._id_545B = 1;
  self _meth_827E("veh_wheelson_engine_start");
  wait 0.5;
  self playLoopSound("veh_wheelson_engine_lp");
}

_id_10DFF(var_0) {
  if(istrue(var_0)) {
    self notify("wheelson_stop_engine");
    self._id_545B = undefined;
    self stoploopsound("veh_wheelson_engine_lp");
  } else if(istrue(self._id_545B)) {
    self notify("wheelson_stop_engine");
    self endon("wheelson_stop_engine");
    self._id_545B = undefined;
    self _meth_827E("veh_wheelson_engine_stop");
    wait 0.5;

    if(isDefined(self)) {
      self stoploopsound("veh_wheelson_engine_lp");
    }
  }
}

_id_10DFC() {
  self endon("death");
  level waittill("game_ended");
  thread _id_10DFF();
}

_id_EDFD(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  self.owner _meth_8095();
  thread _id_078D::_id_B2B4(self.owner, 5);
}

_id_EDFB(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(!istrue(var_0)) {
    self.owner _meth_8094(self);
  }
}

_id_EE31(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  var_0 endon("death");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level._id_EE49[var_0._id_EE5F]._id_9E70);

  for(;;) {
    if(var_0._id_9E6C _meth_81C2()) {
      var_2--;

      if(var_2 <= 0) {
        var_0._id_9E6C _meth_8410();
        wait 2.5;
        var_0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_2 = var_1;
        var_0._id_9E6C _meth_8411();
      }
    }

    wait(var_3);
  }
}

_id_EDFA() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  for(;;) {
    self.owner earthquakeforplayer(0.065, 0.05, self gettagorigin("tag_body"), 500);
    wait 0.05;
  }
}

_id_117C(var_0) {
  level._id_F906[var_0] = self;
}

_id_C4C3(var_0) {
  level._id_F906[var_0] = undefined;
}

_id_EE3A() {
  self endon("death");
  level endon("game_ended");
  self._id_FE90 scripts\mp\utility\killstreak::_id_D5D2(self.owner, &"KILLSTREAKS_HINTS/PAC_SENTRY_MOUNT", 90, 90, 150, 150, 3, 1);
  _id_EDFE();

  for(;;) {
    self._id_FE90 waittill("trigger", var_0);

    if(isDefined(self._id_C830) && self._id_C830 == var_0) {
      var_0 unlink();
      self._id_C830 = undefined;
      _id_EDFE();
      continue;
    }

    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(!var_0 scripts\common\utility::_id_86F9()) {
      continue;
    }
    self._id_C830 = var_0;
    var_0 playerlinkto(self, "tag_playerride", 0.8);
    thread _id_EE3B(var_0, 20);
    thread _id_EE38(var_0);
    thread _id_EE39(var_0);
    _id_EDF6(var_0);
  }
}

_id_EE3B(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = var_0 getplayerangles();
    var_5 = var_4[1];
    var_6 = self.angles[1];

    switch (var_2) {
      case 0:
        var_7 = 90 - var_1 * 0.5;
        var_8 = _func_000B(var_5 - var_6);

        if(abs(var_8) >= var_7) {
          var_3 = 2;
          var_2 = 1;
        }

        break;
      case 1:
        var_9 = vectordot(anglesToForward(var_4), anglestoright(self.angles));
        var_10 = -1.0 * var_1;

        if(var_9 > 0) {
          var_11 = _func_000B(var_5 - var_6 + 90);

          if(var_11 < var_10) {
            var_3 = 2;
            var_2 = 2;
          } else if(var_11 > var_1) {
            var_3 = 0;
            var_2 = 0;
          }
        } else {
          var_11 = _func_000B(var_5 - var_6 - 90);

          if(var_11 > var_1) {
            var_3 = 2;
            var_2 = 2;
          } else if(var_11 < var_10) {
            var_3 = 0;
            var_2 = 0;
          }
        }

        break;
      case 2:
        var_7 = 90 - var_1 * 0.5;
        var_11 = _func_000B(var_5 - var_6 + 180);

        if(abs(var_11) >= var_7) {
          var_3 = 0;
          var_2 = 1;
        }

        break;
    }

    waitframe();
  }
}

_id_EE38(var_0) {
  self endon("death");
  var_0 waittill("death_or_disconnect");
  self._id_C830 = undefined;
  _id_EDFE();
}

_id_EE39(var_0) {
  self waittill("death");

  if(isDefined(self._id_C830) && var_0 == self._id_C830) {
    var_0 unlink();
  }
}

_id_EDFE() {
  if(level.teambased) {
    foreach(var_1 in level.players) {
      if(var_1.team != self.team) {
        continue;
      }
      self _meth_80E0(var_1);
    }
  }
}

_id_EDF6(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.players) {
      if(var_2.team != self.team) {
        continue;
      }
      if(var_2 == var_0) {
        continue;
      }
      self disableplayeruse(var_2);
    }
  }
}

_id_EE02(var_0) {
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = [var_2 + var_0 * var_4, var_2 + 0.707 * var_0 * (var_4 + var_5), var_2 + 0.707 * var_0 * (var_4 - var_5)];

  foreach(var_8 in var_6) {
    var_1 = _id_EDF2(var_2, var_8);

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

_id_EDF2(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, 45);
  var_4 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var_5 = var_0 + var_3;
  var_6 = var_1 + var_3;
  var_7 = 40;
  var_8 = scripts\engine\trace::ray_trace_passed(var_5, var_6, self, var_4);

  if(!istrue(var_8)) {
    return var_2;
  }

  var_9 = scripts\engine\trace::ray_trace(var_6, var_6 - (0, 0, 500), level.players, var_4);

  if(isDefined(var_9["position"]) && var_9["hittype"] != "hittype_none") {
    var_10 = var_9["position"] + var_3;
    var_11 = scripts\engine\trace::_id_E40D(var_10, var_10, var_7, level.players, var_4);
    var_12 = undefined;

    if(level.teambased) {
      var_12 = self.team;
    }

    if(istrue(var_11) && !scripts\mp\outofbounds::_id_89B8(var_9["position"], var_12)) {
      var_2 = var_9["position"];
    } else {}
  }

  return var_2;
}

_id_EE2C() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self._id_9E6C gettagangles("tag_flash");
    var_1 = _func_00FF(self.angles);
    var_2 = _func_0047(var_1, var_0);
    var_3 = var_2[1] * -1.0;
    self.owner setclientomnvar("ui_pac_sentry_degrees", var_3);
    waitframe();
  }
}

_id_EE2D() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  thread _id_EE36();
  self.owner notifyonplayercommand("toggle_view", "+togglevehcam");
  var_0 = 1;
  var_1 = "third_person_hud_on";

  if(isDefined(self.owner._id_BC42)) {
    var_0 = self.owner._id_BC42;

    if(var_1 == 2) {
      var_1 = "first_person_hud_on";
    }
  }

  for(;;) {
    self.owner waittill("toggle_view");
    var_0++;

    if(var_0 == 2) {
      self.owner _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self.lifetime, 0);
      var_1 = "first_person_hud_on";
    } else if(var_0 > 2) {
      self.owner _id_09C8::_id_0D89();
      var_0 = 1;
      var_1 = "third_person_hud_on";
    }

    self.owner._id_BC42 = var_0;
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, var_1);
    self.owner setclientomnvar("ui_pac_sentry_controls", var_0);
  }
}

_id_EE36() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 notify("tank_reset_viewState");
  var_0 endon("tank_reset_viewState");
  var_0 waittill("death");

  if(isDefined(var_0._id_BC42)) {
    var_0._id_BC42 = undefined;
  }
}