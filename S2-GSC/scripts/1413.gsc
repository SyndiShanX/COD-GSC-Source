/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1413.gsc
**************************************/

_id_8F7E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = _id_4701(var_4);

  if(!isDefined(var_2))
    var_2 = "zmb_gp_uber_01";

  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_2);
  var_5 _id_0378::_id_8D74("uber_battery_spawn");

  if(isDefined(var_2))
    var_6 = _id_4700(var_2);
  else
    var_6 = "gk_raven_hc_ee_uber_stg_3";

  if(_id_0547::_id_5565(var_4, "stormraven_uber"))
    var_3 = var_0 + (0, 0, 20);

  if(isDefined(var_3))
    var_5 _id_0547::_id_AC41(var_1, undefined, var_3);
  else
    var_5 _id_0547::_id_AC41(var_1, (0, 0, 8));

  var_5._id_9D65 _meth_86C1(1);
  var_5._id_65F9 = _spawnlinkedfx(level._effect[var_6], var_5, "tag_origin");
  _triggerfx(var_5._id_65F9);
  var_5._id_6949 = var_4;
  var_5 thread _id_A663();
  return var_5;
}

_id_4700(var_0) {
  var_1 = "gk_raven_hc_ee_uber_stg_3";

  if(isDefined(var_0)) {
    switch (var_0) {
      case "zmb_gp_uber_01_moon":
        var_1 = "moon_raven_hc_ee_uber_stg_3";
        break;
      case "zmb_gp_uber_01_death":
        var_1 = "death_raven_hc_ee_uber_stg_3";
        break;
      case "zmb_gp_uber_01_blood":
        var_1 = "blood_raven_hc_ee_uber_stg_3";
        break;
      case "zmb_gp_uber_01_storm":
        var_1 = "storm_raven_hc_ee_uber_stg_3";
        break;
    }
  }

  return var_1;
}

_id_A663() {
  for(;;) {
    self waittill("player_used", var_0);

    if(var_0 _id_0586::_id_72C3()) {
      continue;
    }
    if(_id_057E::_id_314D(var_0)) {
      continue;
    }
    var_1 = var_0 getcurrentweapon();
    var_2 = var_0 _meth_82D5();

    if(_id_0547::_id_5864(var_1) && !_id_0547::_id_5565(var_1, var_2)) {
      continue;
    }
    if(isDefined(self._id_65F9))
      self._id_65F9 delete();

    _id_0547::_id_AC40();
    var_0 thread _id_3481(self._id_6949);
    self hide();
    var_0 _id_8555(self._id_6949);
    self delete();
    level notify("player grabbed uber battery");
    break;
  }
}

_id_3481(var_0) {
  self notify("new_uber_tracking");
  self endon("new_uber_tracking");
  self endon("uber_lost");
  var_1 = spawnStruct();
  var_1._id_A269 = self.origin;
  _id_42F2(var_1);
  _id_8F7E(var_1._id_A269, undefined, undefined, undefined, var_0);
}

_id_42F2(var_0) {
  self endon("new_uber_tracking");
  self endon("disconnect");
  self endon("uber_lost");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  while(isDefined(self)) {
    if(common_scripts\utility::_id_562E(level.usenavmeshforuber)) {
      if(self isonground() && _func_2E6(self.origin)) {
        var_0._id_A269 = self.origin;
        thread maps\mp\_utility::_id_33DF(var_0._id_A269, 8, 3, (1, 0, 0));
      }
    } else if(self isonground())
      var_0._id_A269 = self.origin;

    wait 0.15;
  }
}

_id_8555(var_0) {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  thread _id_2EB5();
  self.isswitchingtoblimppart = 1;
  self._id_56A5 = 1;
  self._id_2927 = var_0;
  self._id_6A54 = self getcurrentprimaryweapon();
  var_1 = [];
  var_2 = _id_057E::_id_314D(self);

  if(common_scripts\utility::_id_562E(var_2))
    var_1 = common_scripts\utility::_id_0F6F(var_1, _id_057E::_id_418D());

  var_3 = self getweaponlistprimaries();
  _id_0586::_id_078C("blimp_battery_zm");
  _id_0586::_id_078E("blimp_battery_zm");
  _id_0378::_id_8D74("aud_zmb_uberschnell_pickup");
  self disableweaponswitch();
  self allowcrouch(0);
  self allowjump(0);
  self waittill("weapon_change");
  self enableweaponswitch();
  thread _id_A8B0(var_1);
}

_id_A8B0(var_0) {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  var_1 = _id_A664();
  deleteonhostmigration(var_1, var_0);
}

_id_A664() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  thread _id_A6DD();
  thread _id_A6D9();
  self.isswitchingtoblimppart = 0;
  self notify("uber_gained");
  self waittill("uber_lost", var_0);
  self allowcrouch(1);
  var_1 = 1;

  switch (var_0) {
    case "uber_dropped":
      var_1 = 1;
      break;
    case "uber_deposited":
      var_1 = 0;
      break;
  }

  return var_1;
}

_id_A6DD() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  common_scripts\utility::_id_A70A("weapon_change", "weapon_switch_started", "enter_last_stand");

  if(maps\mp\_utility::_id_4571() == "mp_zombie_descent") {
    while(!self isonground())
      waitframe();
  }

  self notify("uber_lost", "uber_dropped");
}

_id_A6D9() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(level.usenavmeshforuber))
    self endon("death");

  common_scripts\utility::_id_A70A("uber_deposited");
  self notify("uber_lost", "uber_deposited");
}

_id_9E12(var_0) {
  if(common_scripts\utility::_id_562E(self.isswitchingtoblimppart))
    return 0;

  if((!isDefined(self._id_2927) || self._id_2927 == var_0) && _id_0586::_id_72C3()) {
    self notify("uber_deposited");
    return 1;
  } else
    return 0;
}

deleteonhostmigration(var_0, var_1) {
  _id_95CE(var_1);

  if(var_0) {
    var_2 = self.origin;
    var_3 = _id_A65A();

    if(!isDefined(var_3))
      var_3 = var_2;

    _id_8F7E(var_3, undefined, _id_4702(self._id_2927), undefined, self._id_2927);
  }
}

_id_4702(var_0) {
  var_1 = "zmb_gp_uber_01";

  if(isDefined(var_0)) {
    switch (var_0) {
      case "moon_raven_hc_ee":
        var_1 = "zmb_gp_uber_01_moon";
        break;
      case "death_raven_hc_ee":
        var_1 = "zmb_gp_uber_01_death";
        break;
      case "blood_raven_hc_ee":
        var_1 = "zmb_gp_uber_01_blood";
        break;
      case "storm_raven_hc_ee":
        var_1 = "zmb_gp_uber_01_storm";
        break;
    }
  }

  return var_1;
}

_id_4701(var_0) {
  var_1 = &"ZOMBIES_PICKUP_UBER_GEN";

  if(maps\mp\_utility::_id_4571() == "mp_zombie_nest_01") {
    var_1 = &"ZOMBIE_NEST_PICK_BLIMP_PIECE";

    if(!isDefined(var_0))
      return var_1;

    switch (var_0) {
      case "moon_raven_hc_ee":
        var_1 = &"ZOMBIE_NEST_PICKUP_UBER_MOON";
        break;
      case "death_raven_hc_ee":
        var_1 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";
        break;
      case "blood_raven_hc_ee":
        var_1 = &"ZOMBIE_NEST_PICKUP_UBER_BLOOD";
        break;
      case "storm_raven_hc_ee":
        var_1 = &"ZOMBIE_NEST_PICKUP_UBER_STORM";
        break;
    }
  }

  return var_1;
}

_id_95CE(var_0) {
  self._id_56A5 = 0;
  self.isswitchingtoblimppart = 0;
  _id_0586::_id_0790("blimp_battery_zm");
  _id_0586::_id_078E(self._id_6A54);
  self allowjump(1);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    _id_0586::_id_078C(var_0[var_1]);
}

_id_A65A() {
  self endon("disconnect");
  self endon("death");

  while(!self isonground())
    waitframe();

  return self.origin;
}

_id_429F() {}

_id_2EB5() {
  if(maps\mp\_utility::_id_4571() == "mp_zombie_nest_01" && !common_scripts\utility::_id_562E(self._id_305E)) {
    var_0 = _id_0367::_id_8E3D("zepuberpickup");

    if(isDefined(var_0))
      self._id_305E = 1;
  }
}