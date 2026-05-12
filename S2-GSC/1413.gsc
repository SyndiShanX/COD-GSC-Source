/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1413.gsc
*********************************************/

lib_0585::func_8F7E(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = lib_0585::func_4701(param_04);
  }

  if(!isDefined(param_02)) {
    param_02 = "zmb_gp_uber_01";
  }

  var_05 = spawn("script_model", param_00);
  var_05 setModel(param_02);
  var_05 lib_0378::func_8D74("uber_battery_spawn");
  if(isDefined(param_02)) {
    var_06 = lib_0585::func_4700(param_02);
  } else {
    var_06 = "gk_raven_hc_ee_uber_stg_3";
  }

  if(lib_0547::func_5565(param_04, "stormraven_uber")) {
    param_03 = param_00 + (0, 0, 20);
  }

  if(isDefined(param_03)) {
    var_05 lib_0547::func_AC41(param_01, undefined, param_03);
  } else {
    var_05 lib_0547::func_AC41(param_01, (0, 0, 8));
  }

  var_05.var_9D65 method_86C1(1);
  var_05.var_65F9 = spawnlinkedfx(level.var_0611[var_06], var_05, "tag_origin");
  triggerfx(var_05.var_65F9);
  var_05.var_6949 = param_04;
  var_05 thread lib_0585::func_A663();
  return var_05;
}

lib_0585::func_4700(param_00) {
  var_01 = "gk_raven_hc_ee_uber_stg_3";
  if(isDefined(param_00)) {
    switch (param_00) {
      case "zmb_gp_uber_01_moon":
        var_01 = "moon_raven_hc_ee_uber_stg_3";
        break;

      case "zmb_gp_uber_01_death":
        var_01 = "death_raven_hc_ee_uber_stg_3";
        break;

      case "zmb_gp_uber_01_blood":
        var_01 = "blood_raven_hc_ee_uber_stg_3";
        break;

      case "zmb_gp_uber_01_storm":
        var_01 = "storm_raven_hc_ee_uber_stg_3";
        break;
    }
  }

  return var_01;
}

lib_0585::func_A663() {
  for(;;) {
    self waittill("player_used", var_00);
    if(var_00 lib_0586::func_72C3()) {
      continue;
    }

    if(lib_057E::func_314D(var_00)) {
      continue;
    }

    var_01 = var_00 getcurrentweapon();
    var_02 = var_00 method_82D5();
    if(lib_0547::func_5864(var_01) && !lib_0547::func_5565(var_01, var_02)) {
      continue;
    }

    if(isDefined(self.var_65F9)) {
      self.var_65F9 delete();
    }

    lib_0547::func_AC40();
    var_00 thread lib_0585::func_3481(self.var_6949);
    self method_805C();
    var_00 lib_0585::func_8555(self.var_6949);
    self delete();
    level notify("player grabbed uber battery");
    break;
  }
}

lib_0585::func_3481(param_00) {
  self notify("new_uber_tracking");
  self endon("new_uber_tracking");
  self endon("uber_lost");
  var_01 = spawnStruct();
  var_01.var_A269 = self.var_0116;
  lib_0585::func_42F2(var_01);
  lib_0585::func_8F7E(var_01.var_A269, undefined, undefined, undefined, param_00);
}

lib_0585::func_42F2(param_00) {
  self endon("new_uber_tracking");
  self endon("disconnect");
  self endon("uber_lost");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  while(isDefined(self)) {
    if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
      if(self isonground() && function_02E6(self.var_0116)) {
        param_00.var_A269 = self.var_0116;
        thread maps\mp\_utility::func_33DF(param_00.var_A269, 8, 3, (1, 0, 0));
      }

      continue;
    }

    if(self isonground()) {
      param_00.var_A269 = self.var_0116;
    }

    wait(0.15);
  }
}

lib_0585::func_8555(param_00) {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  thread lib_0585::func_2EB5();
  self.isswitchingtoblimppart = 1;
  self.var_56A5 = 1;
  self.var_2927 = param_00;
  self.var_6A54 = self getcurrentprimaryweapon();
  var_01 = [];
  var_02 = lib_057E::func_314D(self);
  if(common_scripts\utility::func_562E(var_02)) {
    var_01 = common_scripts\utility::func_0F6F(var_01, lib_057E::func_418D());
  }

  var_03 = self getweaponslistprimaries();
  lib_0586::func_078C("blimp_battery_zm");
  lib_0586::func_078E("blimp_battery_zm");
  lib_0378::func_8D74("aud_zmb_uberschnell_pickup");
  self method_8326();
  self method_8113(0);
  self allowjump(0);
  self waittill("weapon_change");
  self method_8327();
  thread lib_0585::func_A8B0(var_01);
}

lib_0585::func_A8B0(param_00) {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  var_01 = lib_0585::func_A664();
  lib_0585::func_8553(var_01, param_00);
}

lib_0585::func_A664() {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  thread lib_0585::func_A6DD();
  thread lib_0585::func_A6D9();
  self.isswitchingtoblimppart = 0;
  self notify("uber_gained");
  self waittill("uber_lost", var_00);
  self method_8113(1);
  var_01 = 1;
  switch (var_00) {
    case "uber_dropped":
      var_01 = 1;
      break;

    case "uber_deposited":
      var_01 = 0;
      break;
  }

  return var_01;
}

lib_0585::func_A6DD() {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  common_scripts\utility::func_A70A("weapon_change", "weapon_switch_started", "enter_last_stand");
  if(maps\mp\_utility::func_4571() == "mp_zombie_descent") {
    while(!self isonground()) {
      wait 0.05;
    }
  }

  self notify("uber_lost", "uber_dropped");
}

lib_0585::func_A6D9() {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(level.usenavmeshforuber)) {
    self endon("death");
  }

  common_scripts\utility::func_A70A("uber_deposited");
  self notify("uber_lost", "uber_deposited");
}

lib_0585::func_9E12(param_00) {
  if(common_scripts\utility::func_562E(self.isswitchingtoblimppart)) {
    return 0;
  }

  if((!isDefined(self.var_2927) || self.var_2927 == param_00) && lib_0586::func_72C3()) {
    self notify("uber_deposited");
    return 1;
  }

  return 0;
}

lib_0585::func_8553(param_00, param_01) {
  lib_0585::func_95CE(param_01);
  if(param_00) {
    var_02 = self.var_0116;
    var_03 = lib_0585::func_A65A();
    if(!isDefined(var_03)) {
      var_03 = var_02;
    }

    lib_0585::func_8F7E(var_03, undefined, lib_0585::func_4702(self.var_2927), undefined, self.var_2927);
  }
}

lib_0585::func_4702(param_00) {
  var_01 = "zmb_gp_uber_01";
  if(isDefined(param_00)) {
    switch (param_00) {
      case "moon_raven_hc_ee":
        var_01 = "zmb_gp_uber_01_moon";
        break;

      case "death_raven_hc_ee":
        var_01 = "zmb_gp_uber_01_death";
        break;

      case "blood_raven_hc_ee":
        var_01 = "zmb_gp_uber_01_blood";
        break;

      case "storm_raven_hc_ee":
        var_01 = "zmb_gp_uber_01_storm";
        break;
    }
  }

  return var_01;
}

lib_0585::func_4701(param_00) {
  var_01 = &"ZOMBIES_PICKUP_UBER_GEN";
  if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01") {
    var_01 = &"ZOMBIE_NEST_PICK_BLIMP_PIECE";
    if(!isDefined(param_00)) {
      return var_01;
    }

    switch (param_00) {
      case "moon_raven_hc_ee":
        var_01 = &"ZOMBIE_NEST_PICKUP_UBER_MOON";
        break;

      case "death_raven_hc_ee":
        var_01 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";
        break;

      case "blood_raven_hc_ee":
        var_01 = &"ZOMBIE_NEST_PICKUP_UBER_BLOOD";
        break;

      case "storm_raven_hc_ee":
        var_01 = &"ZOMBIE_NEST_PICKUP_UBER_STORM";
        break;
    }
  }

  return var_01;
}

lib_0585::func_95CE(param_00) {
  self.var_56A5 = 0;
  self.isswitchingtoblimppart = 0;
  lib_0586::func_0790("blimp_battery_zm");
  lib_0586::func_078E(self.var_6A54);
  self allowjump(1);
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    lib_0586::func_078C(param_00[var_01]);
  }
}

lib_0585::func_A65A() {
  self endon("disconnect");
  self endon("death");
  while(!self isonground()) {
    wait 0.05;
  }

  return self.var_0116;
}

lib_0585::func_429F() {}

lib_0585::func_2EB5() {
  if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01" && !common_scripts\utility::func_562E(self.var_305E)) {
    var_00 = lib_0367::func_8E3D("zepuberpickup");
    if(isDefined(var_00)) {
      self.var_305E = 1;
    }
  }
}