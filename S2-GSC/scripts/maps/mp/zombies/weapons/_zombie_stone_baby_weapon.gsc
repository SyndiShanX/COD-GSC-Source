/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_stone_baby_weapon.gsc
*************************************************************************/

spawn_a_stone_baby_pickup(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = getbabyhintstring(var_4);

  if(!isDefined(var_2))
    var_2 = "npc_zom_baby_statue_01";

  var_0 = _func_2E1(var_0);
  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_2);
  var_5 _id_0378::_id_8D74("baby_statue_spawn");
  var_5 _meth_83E5((randomint(10) - 10, randomint(10) - 10, randomint(10) - 10), 0.1);
  var_5.targetname = "baby_statue_spawn";
  var_6 = bulletTrace(var_5.origin + (0, 0, 32), var_5.origin + (0, 0, -1000), 0);
  var_5.origin = var_6["position"] + (0, 0, -4);

  if(isDefined(var_2))
    var_7 = getbabyfxformodel(var_2);
  else
    var_7 = "gk_raven_hc_ee_baby_stg_3";

  if(isDefined(var_3))
    var_5 _id_0547::_id_AC41(var_1, undefined, var_3);
  else
    var_5 _id_0547::_id_AC41(var_1, (0, 0, 8));

  var_5._id_6949 = var_4;
  var_5 thread wait_for_baby_statue_pickup();
  return var_5;
}

getbabyfxformodel(var_0) {
  var_1 = "gk_raven_hc_ee_baby_stg_3";

  switch (var_0) {
    case "npc_zom_baby_statue_01":
      var_1 = "moon_raven_hc_ee_baby_stg_3";
      break;
  }

  return var_1;
}

wait_for_baby_statue_pickup() {
  for(;;) {
    self waittill("player_used", var_0);

    if(var_0 _id_0586::player_is_holding_baby_statue()) {
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
    if(isDefined(self.mybabyfx))
      self.mybabyfx delete();

    _id_0547::_id_AC40();
    var_0 thread _id_3481(self._id_6949);
    self _meth_805C();
    var_0 set_player_holding_an_baby_statue(self._id_6949);
    self delete();
    level notify("player grabbed baby statue");
    break;
  }
}

_id_3481(var_0) {
  self notify("new_baby_tracking");
  self endon("new_baby_tracking");
  self endon("baby_lost");
  var_1 = spawnStruct();
  var_1._id_A269 = self.origin;
  _id_42F2(var_1);
  spawn_a_stone_baby_pickup(var_1._id_A269, undefined, undefined, undefined, var_0);
}

_id_42F2(var_0) {
  self endon("new_baby_tracking");
  self endon("disconnect");
  self endon("baby_lost");

  while(isDefined(self)) {
    if(self _meth_8346())
      var_0._id_A269 = self.origin;

    wait 0.15;
  }
}

set_player_holding_an_baby_statue(var_0) {
  self endon("disconnect");
  thread dialog_babyweight();
  self.isswitchingtostatuepart = 1;
  self.iscarryingstatuepart = 1;
  self.currentstatueobjectiveid = var_0;
  self._id_5B98 = self _meth_8317();
  var_1 = self getweaponlistprimaries();
  _id_0586::_id_078C("stone_baby_zm");
  _id_0586::_id_078E("stone_baby_zm");
  maps\mp\_utility::giveperk("specialty_ballcarrier");
  self _meth_8326();

  if(!common_scripts\utility::_id_562E(self.oncartride))
    self _meth_8113(0);

  self _meth_8114(0);
  self _meth_8305(0);
  self waittill("weapon_change");
  self _meth_8327();
  thread watch_for_baby_statue_drop();
}

watch_for_baby_statue_drop() {
  self endon("disconnect");
  var_0 = wait_for_baby_lost();
  set_player_dropping_an_baby_statue(var_0);
}

wait_for_baby_lost() {
  self endon("disconnect");
  thread _id_A6DD();
  thread waitforbabydeposit();
  self.isswitchingtostatuepart = 0;
  self notify("baby_gained");
  self waittill("baby_lost", var_0);
  self _meth_8113(1);

  if(!common_scripts\utility::_id_3794("flag_player_in_water"))
    self _meth_8114(1);

  var_1 = 1;

  switch (var_0) {
    case "baby_dropped":
      var_1 = 1;
      break;
    case "baby_deposited":
      var_1 = 0;
      break;
  }

  return var_1;
}

_id_A6DD() {
  self endon("disconnect");
  common_scripts\utility::_id_A70A("weapon_change", "weapon_switch_started", "enter_last_stand");
  self notify("baby_lost", "baby_dropped");
}

waitforbabydeposit() {
  self endon("disconnect");
  common_scripts\utility::_id_A70A("baby_deposited");
  self notify("baby_lost", "baby_deposited");
}

try_to_deposit_baby(var_0) {
  if(common_scripts\utility::_id_562E(self.isswitchingtostatuepart))
    return 0;

  if((!isDefined(self.currentstatueobjectiveid) || self.currentstatueobjectiveid == var_0) && _id_0586::player_is_holding_baby_statue()) {
    self notify("baby_deposited");
    return 1;
  } else
    return 0;
}

set_player_dropping_an_baby_statue(var_0) {
  take_baby_statue_from_player();

  if(var_0) {
    var_1 = self.origin;
    var_2 = wait_for_safe_baby_origin();

    if(!isDefined(var_2))
      var_2 = var_1;

    spawn_a_stone_baby_pickup(var_2, undefined, getbabymodel(self.currentstatueobjectiveid), undefined, self.currentstatueobjectiveid);
  }
}

getbabymodel(var_0) {
  var_1 = "npc_zom_baby_statue_01";

  if(isDefined(var_0)) {
    switch (var_0) {
      case "__":
        var_1 = "";
        break;
    }
  }

  return var_1;
}

getbabyhintstring(var_0) {
  var_1 = &"ZOMBIE_ISLAND_PICK_STONE_BABY";

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case "__":
      var_1 = &"";
      break;
  }

  return var_1;
}

take_baby_statue_from_player() {
  self.iscarryingstatuepart = 0;
  self.isswitchingtostatuepart = 0;
  _id_0586::_id_0790("stone_baby_zm");
  maps\mp\_utility::_id_0735("specialty_ballcarrier");

  if(!_id_0547::_id_577E(self)) {
    if(isDefined(self._id_5B98) && self._id_5B98 != "none")
      _id_0586::_id_078E(self._id_5B98);

    self _meth_8305(1);
  }
}

wait_for_safe_baby_origin() {
  self endon("disconnect");
  self endon("death");

  while(!self _meth_8346())
    waitframe();

  return self.origin;
}

get_player_is_holding_an_baby_statue() {}

dialog_babyweight() {
  if(!common_scripts\utility::_id_562E(self.dlg_flag_statue_weight)) {
    var_0 = _id_0367::_id_8E3D("zepbabypickup");

    if(isDefined(var_0))
      self.dlg_flag_statue_weight = 1;
  }
}