/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\smokeairdrop.gsc
***********************************************/

_id_D1F6522BC93ED94E() {
  level._effect["vfx/iw9/fieldupgrades/smokeairdrop/vfx_fieldup_smokeairdrop.vfx"] = loadfx("vfx/iw9/fieldupgrades/smokeairdrop/vfx_fieldup_smokeairdrop.vfx");
  _id_7FCFDD32159BBACC();
  level._id_92E2C130A8EA2B6C = [];
}

#using_animtree("script_model");

_id_7FCFDD32159BBACC() {
  level.scr_animtree["super_smoke_airdrop"] = #animtree;
  level.scr_anim["super_smoke_airdrop"]["activate_drone_1"] = % wm_smoke_airdrop_drone_01;
  level.scr_animname["super_smoke_airdrop"]["activate_drone_1"] = "wm_smoke_airdrop_drone_01";
  level.scr_anim["super_smoke_airdrop"]["activate_drone_2"] = % wm_smoke_airdrop_drone_02;
  level.scr_animname["super_smoke_airdrop"]["activate_drone_2"] = "wm_smoke_airdrop_drone_02";
  level.scr_anim["super_smoke_airdrop"]["activate_drone_3"] = % wm_smoke_airdrop_drone_03;
  level.scr_animname["super_smoke_airdrop"]["activate_drone_3"] = "wm_smoke_airdrop_drone_03";
  level.scr_anim["super_smoke_airdrop"]["activate_drone_4"] = % wm_smoke_airdrop_drone_04;
  level.scr_animname["super_smoke_airdrop"]["activate_drone_4"] = "wm_smoke_airdrop_drone_04";
}

_id_685E618D30DA1588() {
  result = thread _id_5E73F80DAA45F50C();
  return 1;
}

_id_CD3021441020E8E5(_id_19163E14365D9264) {
  scripts\mp\killstreaks\mapselect::_id_90F093CA8576232F(0, 1, "short_arrow", undefined, _id_19163E14365D9264);
  return 1;
}

_id_269055D8846E4665() {
  self notify("cancel_all_super_deployments");
}

_id_21C87FF403D1BAF6() {
  while(!istrue(scripts\mp\supers::getcurrentsuper().isinuse))
    waitframe();

  scripts\mp\supers::refundsuper();
}

_id_9815DEED1E75EF69() {
  if(!self isonground() && !self _meth_E40102956C887F7C())
    return 0;

  if(self isonladder())
    return 0;

  if(istrue(self.super.isdeploying))
    return 0;

  return 1;
}

_id_5E73F80DAA45F50C() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_super");

  if(!_id_9815DEED1E75EF69()) {
    _id_21C87FF403D1BAF6();
    return;
  }

  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
  _id_9B1DEB5E9D32BBE3 = _id_02AABAC61F2AE422::_id_8300EC48C43363D6(_id_19163E14365D9264, makeweapon("super_remote_map_mp"), 1, ::_id_CD3021441020E8E5);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    _id_21C87FF403D1BAF6();
    return;
  }

  self playlocalsound("iw9_ks_tablet_ui_screen_plr");
  mappointinfo = scripts\mp\killstreaks\mapselect::_id_A5839924B6723EAC(_id_19163E14365D9264, 1, 1);

  if(!isDefined(mappointinfo)) {
    _id_21C87FF403D1BAF6();
    return;
  }

  self notify("super_finished_with_deploy_weapon");
  self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  thread _id_5EA4C63126AD14FC(_id_19163E14365D9264, mappointinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
}

_id_5EA4C63126AD14FC(streakinfo, mappointinfo) {
  level endon("game_ended");
  self endon("disconnect");
  waittime = getdvarfloat("dvar_9C4A873BF6FCAB41", 1.5);
  wait(waittime);

  foreach(_id_47B05A700340406E, _id_470C049A636DB53D in mappointinfo) {
    _id_E2B7F60365CBA129 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;
    _id_645FF6D87A68EB7E(_id_E2B7F60365CBA129, _id_A4521BB88F4EB389, streakinfo);
    wait 1.0;
  }
}

_id_645FF6D87A68EB7E(_id_76A22C18960F72AF, _id_A4521BB88F4EB389, streakinfo) {
  level endon("game_ended");
  midpoint = _id_76A22C18960F72AF;
  _id_90783CCFB7B260FB = 1000;
  _id_EC85ED3E96DAE633 = (0, _id_A4521BB88F4EB389, 0);
  _id_801D37E9149BBC7C = anglesToForward(_id_EC85ED3E96DAE633);
  _id_EDE169EE001CB3CF = anglestoright(_id_EC85ED3E96DAE633);
  startpoint = midpoint + _id_801D37E9149BBC7C * (-1 * _id_90783CCFB7B260FB);
  endpoint = midpoint + _id_801D37E9149BBC7C * _id_90783CCFB7B260FB;
  currentpoint = startpoint;
  _id_A5BB1FA786D5B61E = _id_90783CCFB7B260FB * 2;
  _id_C622144D94AE6D95 = getdvarint("dvar_D6117E0006347933", 4);
  _id_ECB39C9EECBD70AD = getdvarint("dvar_80D60FD8731D5FBF", 2000);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0, 0, 0, 0);
  _id_4C1FC889585F5DF5 = [];
  _id_E767D0CB155A0E85 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C622144D94AE6D95; _id_AC0E594AC96AA3A8++) {
    _id_409CF6F9FE71F7D2 = 0;
    _id_F8126431CC8D7B75 = anglestoup(_id_EC85ED3E96DAE633);
    _id_265AC1F6B1F28744 = currentpoint;
    _id_314159FC90761894 = currentpoint + anglestoup(_id_EC85ED3E96DAE633) * _id_ECB39C9EECBD70AD;
    _id_80C9138BE290D6E7 = currentpoint + anglestoup(_id_EC85ED3E96DAE633) * _id_ECB39C9EECBD70AD * -1;
    _id_4EE1C3D63BD43D9A = scripts\engine\trace::ray_trace(_id_314159FC90761894, _id_80C9138BE290D6E7, undefined, contents);

    if(_id_4EE1C3D63BD43D9A["hittype"] != "hittype_none")
      _id_265AC1F6B1F28744 = _id_4EE1C3D63BD43D9A["position"];

    _id_5573665C23482D35 = getdvarfloat("dvar_FAE98B333C47D007", 2000);
    _id_5573665C23482D35 = _id_5573665C23482D35 * _id_5573665C23482D35;

    if(distancesquared(_id_265AC1F6B1F28744, currentpoint) > _id_5573665C23482D35)
      _id_409CF6F9FE71F7D2 = 1;

    if(!_id_409CF6F9FE71F7D2) {
      index = _id_E767D0CB155A0E85.size;
      _id_E767D0CB155A0E85[index] = _id_495EBE31C275C3C5(_id_265AC1F6B1F28744, _id_EC85ED3E96DAE633, _id_ECB39C9EECBD70AD, index);
      _id_4C1FC889585F5DF5[index] = _id_265AC1F6B1F28744;
    }

    currentpoint = currentpoint + _id_A5BB1FA786D5B61E / _id_C622144D94AE6D95 * _id_801D37E9149BBC7C;
  }

  _id_7E544F0D6D580E78 = 0;
  _id_A093AAEC0039F208 = 100;
  _id_35EFD96AA054A86F = 300;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_E767D0CB155A0E85.size; _id_AC0E5C4AC96AAA41++) {
    _id_E767D0CB155A0E85[_id_AC0E5C4AC96AAA41]._id_70CB65F6B1D7D192 = 0;

    if(!_id_7E544F0D6D580E78 && distancesquared(_id_4C1FC889585F5DF5[_id_AC0E5C4AC96AAA41], _id_76A22C18960F72AF) < squared(_id_A093AAEC0039F208)) {
      _id_E767D0CB155A0E85[_id_AC0E5C4AC96AAA41]._id_70CB65F6B1D7D192 = 1;
      _id_7E544F0D6D580E78 = 1;
    }

    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < _id_4C1FC889585F5DF5.size; _id_AC0E424AC96A7113++) {
      if(distancesquared(_id_4C1FC889585F5DF5[_id_AC0E424AC96A7113], _id_4C1FC889585F5DF5[_id_AC0E5C4AC96AAA41]) < squared(_id_35EFD96AA054A86F) && _id_4C1FC889585F5DF5[_id_AC0E5C4AC96AAA41] != _id_4C1FC889585F5DF5[_id_AC0E424AC96A7113] && _id_E767D0CB155A0E85[_id_AC0E424AC96A7113]._id_BFC217EF9A050627 == 1) {
        _id_E767D0CB155A0E85[_id_AC0E5C4AC96AAA41]._id_BFC217EF9A050627 = 0;
        break;
      }
    }

    _id_E767D0CB155A0E85[_id_AC0E5C4AC96AAA41] childthread _id_1EBB9B9E63A4DF54(_id_4C1FC889585F5DF5[_id_AC0E5C4AC96AAA41], _id_EDE169EE001CB3CF);
  }

  scripts\cp_mp\challenges::_id_D997435895422ECC("super_smoke_airdrop", 0);
}

_id_495EBE31C275C3C5(_id_265AC1F6B1F28744, _id_EC85ED3E96DAE633, _id_ECB39C9EECBD70AD, index) {
  _id_1E829EE170CE2414 = spawn("script_model", _id_265AC1F6B1F28744 + anglestoup(_id_EC85ED3E96DAE633) * _id_ECB39C9EECBD70AD);
  _id_1E829EE170CE2414 setModel("misc_wm_smoke_airdrop_drone_v0");
  _id_1E829EE170CE2414.owner = self;
  _id_1E829EE170CE2414.angles = _id_EC85ED3E96DAE633;
  _id_1E829EE170CE2414._id_BFC217EF9A050627 = 1;
  _id_1E829EE170CE2414.index = index + 1;
  _id_1E829EE170CE2414.animname = "super_smoke_airdrop";
  _id_1E829EE170CE2414 scripts\common\anim::setanimtree();
  _id_1E829EE170CE2414 setscriptablepartstate("smokeDeploy", "deployStart", 0);
  _id_1E829EE170CE2414 _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_1D7362315A15C932);
  _id_1E829EE170CE2414 scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_14E878FAFFF171E9);
  _id_1E829EE170CE2414 _meth_5226227BCE83EBE9(3, _id_1E829EE170CE2414.owner.team);
  _id_6AE953C4B9E1CD89(_id_1E829EE170CE2414);

  if(getdvarint("dvar_00819D904FD33AAD", 1))
    _id_1E829EE170CE2414 thread scripts\mp\damage::monitordamage(100, "hitequip", ::_id_7A3C1B282CBFD3AB);

  return _id_1E829EE170CE2414;
}

_id_1D7362315A15C932(data) {
  attacker = data.attacker;

  if(!isDefined(attacker)) {
    return;
  }
  self dodamage(self.maxhealth / 10, self.origin, attacker, data.inflictor);

  if(isDefined(self.damagetaken) && self.damagetaken >= 100) {
    if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
      attacker notify("destroyed_equipment");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
      attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    }

    _id_7A3C1B282CBFD3AB(data);
  }
}

_id_14E878FAFFF171E9(data) {
  attacker = data.attacker;

  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker) || getdvarint("dvar_58254C61DE76BFFE", 0)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6408C284F316C1D9");
    attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  _id_7A3C1B282CBFD3AB(data);
}

_id_799D835745D0B892() {
  if(self.index == 1)
    return 4.3;
  else if(self.index == 2)
    return 5.5;
  else if(self.index == 3)
    return 5.5;
  else if(self.index == 4)
    return 4.8;

  return 0.0;
}

_id_3F0235F3C067371D(drone) {
  level endon("game_ended");
  drone endon("death");
  _id_65DC1767352C19CD = "activate_drone_" + drone.index;
  scripts\common\anim::anim_single_solo(drone, _id_65DC1767352C19CD);
  drone thread _id_9353AA49397987C8();
}

_id_1EBB9B9E63A4DF54(point, _id_EDE169EE001CB3CF) {
  self endon("death");
  _id_83C576C6DF21DF13 = self.origin;
  _id_E99B8E5A3E9C2979 = getdvarfloat("dvar_096D7E827843E457", 3.0);
  offset = getdvarfloat("dvar_320BE90FA91EE74B", 1.5);
  _id_31A8E29E242B9A1B = _id_799D835745D0B892();
  _id_C6E1701A6E24D511 = point + anglestoup(self.angles) * 350;
  _id_7622A5AD898BDBD1 = vectortoangles(_id_EDE169EE001CB3CF);
  _id_2937B8A737595E2A = spawnStruct();
  _id_2937B8A737595E2A.origin = _id_C6E1701A6E24D511;
  _id_2937B8A737595E2A.angles = _id_7622A5AD898BDBD1;
  _id_2937B8A737595E2A thread _id_3F0235F3C067371D(self);

  if(self._id_70CB65F6B1D7D192)
    self playSound("iw9_smoke_airdrop_center_incoming");
  else
    self playSound("iw9_smoke_airdrop_travel_incoming");

  wait(_id_31A8E29E242B9A1B);
  self setscriptablepartstate("smokeDeploy", "settle", 0);

  if(getdvarint("dvar_ABE45E35EF030A56") == 1) {
    if(getdvarint("mgl", 0))
      thread scripts\common\ai::_id_F8903387EA945165(point, 3);
    else
      scripts\common\ai::_id_8A09C0E5FA78A48C(point, 18.0, 300.0, 250.0);
  } else
    thread scripts\mp\bots\bots::create_smoke_occluder(point, 18);

  if(self.index == 1)
    self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_581123D5B51A75F0");

  self playSound("iw9_smoke_airdrop_release");

  if(self._id_BFC217EF9A050627)
    thread _id_1F3E2F430F67A00B(23, self.origin - (0, 0, 100));

  if(self._id_70CB65F6B1D7D192)
    self playSound("iw9_smoke_airdrop_center_outgoing");
  else
    self playSound("iw9_smoke_airdrop_travel_outgoing");
}

_id_1F3E2F430F67A00B(_id_4FEFFEB82828CFD3, position) {
  _id_4CF58793CC4F1AD6 = spawn("script_origin", position);
  _id_4CF58793CC4F1AD6 playSound("iw9_smoke_airdrop_smoke_start");
  _id_4CF58793CC4F1AD6 playLoopSound("iw9_smoke_airdrop_smoke_lp");
  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait(_id_4FEFFEB82828CFD3 - 3);
  thread scripts\engine\utility::play_sound_in_space("iw9_smoke_airdrop_smoke_tail", position);
  wait 0.3;
  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::deregisterspawn();
  _id_4CF58793CC4F1AD6 stoploopsound();
  _id_4CF58793CC4F1AD6 delete();
}

_id_9353AA49397987C8(data) {
  level endon("game_ended");

  if(istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;
  self notify("death");
  self setscriptablepartstate("smokeDeploy", "deployEnd", 0);
  wait 0.35;
  _id_D0326BAD3508B303(self);
  self delete();
}

_id_7A3C1B282CBFD3AB(data) {
  self setscriptablepartstate("destroy", "on", 0);
  _id_9353AA49397987C8(data);
}

_id_6AE953C4B9E1CD89(drone) {
  level._id_92E2C130A8EA2B6C[drone getentitynumber()] = drone;
}

_id_D0326BAD3508B303(drone) {
  level._id_92E2C130A8EA2B6C[drone getentitynumber()] = undefined;
}