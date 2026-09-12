/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_stone_baby_weapon.gsc
*****************************************************************/

spawn_a_stone_baby_pickup(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = getbabyhintstring(param_04);
  }

  if(!isDefined(param_02)) {
    param_02 = "npc_zom_baby_statue_01";
  }

  param_00 = getclosestpointonnavmesh(param_00);
  var_05 = spawn("script_model", param_00);
  var_05 setModel(param_02);
  var_05 lib_0378::func_8D74("baby_statue_spawn");
  var_05 rotateby((randomint(10) - 10, randomint(10) - 10, randomint(10) - 10), 0.1);
  var_05.targetname = "baby_statue_spawn";
  var_06 = bulletTrace(var_05.origin + (0, 0, 32), var_05.origin + (0, 0, -1000), 0);
  var_05.origin = var_06["position"] + (0, 0, -4);
  if(isDefined(param_02)) {
    var_07 = getbabyfxformodel(param_02);
  } else {
    var_07 = "gk_raven_hc_ee_baby_stg_3";
  }

  if(isDefined(param_03)) {
    var_05 lib_0547::func_AC41(param_01, undefined, param_03);
  } else {
    var_05 lib_0547::func_AC41(param_01, (0, 0, 8));
  }

  var_05.var_6949 = param_04;
  var_05 thread wait_for_baby_statue_pickup();
  return var_05;
}

getbabyfxformodel(param_00) {
  var_01 = "gk_raven_hc_ee_baby_stg_3";
  switch (param_00) {
    case "npc_zom_baby_statue_01":
      var_01 = "moon_raven_hc_ee_baby_stg_3";
      break;
  }

  return var_01;
}

wait_for_baby_statue_pickup() {
  for(;;) {
    self waittill("player_used", var_00);
    if(var_00 lib_0586::player_is_holding_baby_statue()) {
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

    if(isDefined(self.mybabyfx)) {
      self.mybabyfx delete();
    }

    lib_0547::func_AC40();
    var_00 thread func_3481(self.var_6949);
    self hide();
    var_00 set_player_holding_an_baby_statue(self.var_6949);
    self delete();
    level notify("player grabbed baby statue");
    break;
  }
}

func_3481(param_00) {
  self notify("new_baby_tracking");
  self endon("new_baby_tracking");
  self endon("baby_lost");
  var_01 = spawnStruct();
  var_01.var_A269 = self.origin;
  func_42F2(var_01);
  spawn_a_stone_baby_pickup(var_01.var_A269, undefined, undefined, undefined, param_00);
}

func_42F2(param_00) {
  self endon("new_baby_tracking");
  self endon("disconnect");
  self endon("baby_lost");
  while(isDefined(self)) {
    if(self isonground()) {
      param_00.var_A269 = self.origin;
    }

    wait(0.15);
  }
}

set_player_holding_an_baby_statue(param_00) {
  self endon("disconnect");
  thread dialog_babyweight();
  self.isswitchingtostatuepart = 1;
  self.iscarryingstatuepart = 1;
  self.currentstatueobjectiveid = param_00;
  self.var_5B98 = self getcurrentprimaryweapon();
  var_01 = self getweaponslistprimaries();
  lib_0586::func_78C("stone_baby_zm");
  lib_0586::func_78E("stone_baby_zm");
  maps\mp\_utility::func_47A2("specialty_ballcarrier");
  self disableweaponswitch();
  if(!common_scripts\utility::func_562E(self.oncartride)) {
    self method_8113(0);
  }

  self method_8114(0);
  self allowjump(0);
  self waittill("weapon_change");
  self enableweaponswitch();
  thread watch_for_baby_statue_drop();
}

watch_for_baby_statue_drop() {
  self endon("disconnect");
  var_00 = wait_for_baby_lost();
  set_player_dropping_an_baby_statue(var_00);
}

wait_for_baby_lost() {
  self endon("disconnect");
  thread func_A6DD();
  thread waitforbabydeposit();
  self.isswitchingtostatuepart = 0;
  self notify("baby_gained");
  self waittill("baby_lost", var_00);
  self method_8113(1);
  if(!common_scripts\utility::func_3794("flag_player_in_water")) {
    self method_8114(1);
  }

  var_01 = 1;
  switch (var_00) {
    case "baby_dropped":
      var_01 = 1;
      break;

    case "baby_deposited":
      var_01 = 0;
      break;
  }

  return var_01;
}

func_A6DD() {
  self endon("disconnect");
  common_scripts\utility::waittill_any("weapon_change", "weapon_switch_started", "enter_last_stand");
  self notify("baby_lost", "baby_dropped");
}

waitforbabydeposit() {
  self endon("disconnect");
  common_scripts\utility::waittill_any("baby_deposited");
  self notify("baby_lost", "baby_deposited");
}

try_to_deposit_baby(param_00) {
  if(common_scripts\utility::func_562E(self.isswitchingtostatuepart)) {
    return 0;
  }

  if((!isDefined(self.currentstatueobjectiveid) || self.currentstatueobjectiveid == param_00) && lib_0586::player_is_holding_baby_statue()) {
    self notify("baby_deposited");
    return 1;
  }

  return 0;
}

set_player_dropping_an_baby_statue(param_00) {
  take_baby_statue_from_player();
  if(param_00) {
    var_01 = self.origin;
    var_02 = wait_for_safe_baby_origin();
    if(!isDefined(var_02)) {
      var_02 = var_01;
    }

    spawn_a_stone_baby_pickup(var_02, undefined, getbabymodel(self.currentstatueobjectiveid), undefined, self.currentstatueobjectiveid);
  }
}

getbabymodel(param_00) {
  var_01 = "npc_zom_baby_statue_01";
  if(isDefined(param_00)) {
    switch (param_00) {
      case "__":
        var_01 = "";
        break;
    }
  }

  return var_01;
}

getbabyhintstring(param_00) {
  var_01 = &"ZOMBIE_ISLAND_PICK_STONE_BABY";
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case "__":
      var_01 = &"";
      break;
  }

  return var_01;
}

take_baby_statue_from_player() {
  self.iscarryingstatuepart = 0;
  self.isswitchingtostatuepart = 0;
  lib_0586::func_790("stone_baby_zm");
  maps\mp\_utility::func_735("specialty_ballcarrier");
  if(!lib_0547::func_577E(self)) {
    if(isDefined(self.var_5B98) && self.var_5B98 != "none") {
      lib_0586::func_78E(self.var_5B98);
    }

    self allowjump(1);
  }
}

wait_for_safe_baby_origin() {
  self endon("disconnect");
  self endon("death");
  while(!self isonground()) {
    wait 0.05;
  }

  return self.origin;
}

get_player_is_holding_an_baby_statue() {}

dialog_babyweight() {
  if(!common_scripts\utility::func_562E(self.dlg_flag_statue_weight)) {
    var_00 = lib_0367::func_8E3D("zepbabypickup");
    if(isDefined(var_00)) {
      self.dlg_flag_statue_weight = 1;
    }
  }
}