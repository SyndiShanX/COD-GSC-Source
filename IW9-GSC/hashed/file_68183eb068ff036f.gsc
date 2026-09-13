/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_68183eb068ff036f.gsc
***********************************************/

_id_A0B9C16CA4FA0611() {
  level._id_D8EDB7719C07AFEA = [];
  level._id_8647EA3DFB060CA8 = [];
  level._id_A11248D60A8D34EB = [];
  level._id_B20F1A43A065B04D = [];
  _id_3715259497B7BEEA();
  _id_71332A5B74214116::registerinteraction("random_item_box", undefined, ::_id_3B053B3F8F035E22, ::_id_B2073ED13B63DDBD);
  _id_71332A5B74214116::registerinteraction("random_item_box_upgraded", undefined, ::_id_3B053B3F8F035E22, ::_id_B2073ED13B63DDBD);
  weight = 1;
  _id_7315B7A0E2C2146E("iw8_ar_mike4", weight);
  _id_7315B7A0E2C2146E("iw8_lm_pkilo", weight);
  weight = 2;
  _id_7315B7A0E2C2146E("iw8_me_akimboblades", weight);
  _id_7315B7A0E2C2146E("iw8_me_akimboblunt", weight);
  _id_7315B7A0E2C2146E("iw8_ar_kilo433", weight);
  _id_7315B7A0E2C2146E("iw8_sm_mpapa5", weight);
  _id_7315B7A0E2C2146E("iw8_sm_augolf", weight);
  _id_7315B7A0E2C2146E("iw8_lm_mgolf34", weight);
  _id_7315B7A0E2C2146E("iw8_lm_lima86", weight);
  _id_7315B7A0E2C2146E("iw8_sh_oscar12", weight);
  _id_7315B7A0E2C2146E("iw8_la_rpapa7", weight);
  _id_7315B7A0E2C2146E("iw8_la_mike32_mp", weight);
  weight = 3;
  _id_7315B7A0E2C2146E("iw8_sm_mpapa7", weight);
  _id_7315B7A0E2C2146E("iw8_ar_akilo47", weight);
  _id_7315B7A0E2C2146E("iw8_sm_papa90", weight);
  _id_7315B7A0E2C2146E("iw8_lm_kilo121", weight);
  _id_7315B7A0E2C2146E("iw8_sh_dpapa12", weight);
  _id_7315B7A0E2C2146E("iw8_pi_decho", weight);
  _id_7315B7A0E2C2146E("iw8_sn_sksierra", weight);
  weight = 5;
  _id_7315B7A0E2C2146E("iw8_sn_crossbow", weight);
  _id_7315B7A0E2C2146E("iw8_sn_kilo98", weight);
  _id_7315B7A0E2C2146E("iw8_sn_hdromeo", weight);
  _id_7315B7A0E2C2146E("iw8_pi_papa320", weight);
  _id_C659DDE0FC100130("power_semtex", undefined, 2, "primary");
  _id_C659DDE0FC100130("power_molotov", undefined, 1, "primary");
  _id_C659DDE0FC100130("power_snapshotGrenade", undefined, 1, "secondary");
  _id_C659DDE0FC100130("equip_hb_sensor", undefined, 1, "secondary");
  _id_C659DDE0FC100130("power_frag", undefined, 2, "primary");
  _id_5CCA422178C24590();
}

_id_3715259497B7BEEA() {
  _id_6164DA4873023695();
  _id_01E852B5D93923F6("iw8_sh_dpapa12");
  _id_C106BC084A0938AD("");
  _id_477B24EC7A1B296F("");
}

_id_6164DA4873023695() {
  struct = spawnStruct();
  struct._id_49F1F24717C46DFD = [];
  struct._id_26A37FECB5792F92 = [];
  struct._id_EACA3E0AD9A25774 = [];
  level._id_2E37E8FCFD187B4E = struct;
}

_id_01E852B5D93923F6(item) {
  level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD[level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD.size] = item;
}

_id_C106BC084A0938AD(item) {
  level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD[level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD.size] = item;
}

_id_477B24EC7A1B296F(item) {
  level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD[level._id_2E37E8FCFD187B4E._id_49F1F24717C46DFD.size] = item;
}

_id_5CCA422178C24590() {
  level._id_F60F73A1AF0D331A = [];
  level._id_5BDB68CBA21DC387 = [];
  _id_22BE20CBC7E64FF1("weapons", 1);
  _id_22BE20CBC7E64FF1("equipment", 2);
  _id_22BE20CBC7E64FF1("armor", 2);
  _id_22BE20CBC7E64FF1("munition", 1);
}

_id_22BE20CBC7E64FF1(drop_type, _id_9CDAE6E77AFC97B9) {
  level._id_F60F73A1AF0D331A[level._id_F60F73A1AF0D331A.size] = drop_type;
  level._id_5BDB68CBA21DC387[level._id_5BDB68CBA21DC387.size] = _id_9CDAE6E77AFC97B9;
}

_id_7315B7A0E2C2146E(weapon, weight) {
  if(isDefined(weight) && !weight) {
    return;
  }
  level._id_D8EDB7719C07AFEA[level._id_D8EDB7719C07AFEA.size] = weapon;

  if(!isDefined(weight))
    weight = 1;

  level._id_8647EA3DFB060CA8[level._id_8647EA3DFB060CA8.size] = weight;
}

_id_C659DDE0FC100130(equipment, weight, count, slot) {
  if(isDefined(weight) && !weight) {
    return;
  }
  if(!isDefined(weight))
    weight = 1;

  if(!isDefined(count))
    count = 1;

  if(!isDefined(slot))
    slot = "primary";

  level._id_A11248D60A8D34EB[level._id_A11248D60A8D34EB.size] = equipment;
  level._id_D99C5845920F7E63[equipment] = count;
  level._id_B20F1A43A065B04D[level._id_B20F1A43A065B04D.size] = weight;
  level._id_C9C74CDADEEC4710[equipment] = slot;
}

_id_B2073ED13B63DDBD(_id_9E4E1482CB40C9C5) {
  node_creation_angle_frac = 22.5;
  _id_0E20DF846C8700EF = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    _id_837178326DAF8AB5 = [];
    _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].cost = getdvarint("dvar_97E1698A7F18E0CA", 1000);
    _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8]._id_2E37E8FCFD187B4E = "random_item_box";
    _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8]._id_EAECDF56E917C0A5 = 1;
    _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8]._id_C83A47C596B260BC = ::_id_B8C65C2981D5450A;

    for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 <= 3; _id_AC0E5C4AC96AAA41++) {
      for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < 16; _id_AC0E5B4AC96AA80E++) {
        _id_0E20DF846C8700EF++;
        pos = _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].origin;
        angle = node_creation_angle_frac * _id_AC0E5B4AC96AA80E;
        _id_8A9F895755FD607E = cos(angle) * 128 * _id_AC0E5C4AC96AAA41;
        _id_D867033AB311670B = sin(angle) * 128 * _id_AC0E5C4AC96AAA41;
        x = pos[0] + _id_8A9F895755FD607E;
        y = pos[1] + _id_D867033AB311670B;
        z = pos[2];
        _id_55A01E81BDA4CC0C = (x, y, z);

        if(ispointonnavmesh(_id_55A01E81BDA4CC0C) && scripts\engine\trace::capsule_trace_passed(_id_55A01E81BDA4CC0C + (0, 0, 2000), _id_55A01E81BDA4CC0C, 32, 64, (0, 0, 0), level.characters)) {
          struct = spawnStruct();
          struct.origin = _id_55A01E81BDA4CC0C;
          _id_837178326DAF8AB5[_id_837178326DAF8AB5.size] = struct;
          continue;
        }
      }
    }

    _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8]._id_F83BC8E4B98A16BA = _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].script_noteworthy + "_" + _id_AC0E594AC96AA3A8;

    for(_id_AC0E5E4AC96AAEA7 = 0; _id_AC0E5E4AC96AAEA7 < _id_837178326DAF8AB5.size; _id_AC0E5E4AC96AAEA7++) {
      _id_837178326DAF8AB5[_id_AC0E5E4AC96AAEA7].script_noteworthy = _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].script_noteworthy + "_" + _id_AC0E594AC96AA3A8;
      scripts\cp\utility::addtostructarray("script_noteworthy", _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].script_noteworthy + "_" + _id_AC0E594AC96AA3A8, _id_837178326DAF8AB5[_id_AC0E5E4AC96AAEA7]);
    }
  }

  test = _id_0E20DF846C8700EF;
}

_id_B8C65C2981D5450A(_id_DF071553D0996FF9) {
  self makeusable();
  self sethinttag("tag_hint");
  self setCursorHint("HINT_BUTTON");
  self setuserange(4);
  self sethintdisplayrange(512);
  self disconnectPaths();
  self.open = 0;
  _id_DF071553D0996FF9._id_C8FC403022EA9C7C = self;
  _id_9C9AD1DF28CABB0D = _id_780514F14B1134ED::_id_4149E569A4716705(_id_DF071553D0996FF9);

  if(isDefined(_id_9C9AD1DF28CABB0D))
    _id_DF071553D0996FF9.headicon = _id_9C9AD1DF28CABB0D;

  self._id_8946C3E2E95DA2F8 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, _id_DF071553D0996FF9.headicon, 56, 1, 5000, 1000, 0, 0, 1, undefined, 0);
  thread _id_780514F14B1134ED::_id_7D378614C1FE7036();
  _id_780514F14B1134ED::_id_E8C95A48F269C285(_id_DF071553D0996FF9, _id_DF071553D0996FF9.origin, undefined, 30);
  thread _id_09629C9CEF1CB674(_id_DF071553D0996FF9.headicon, _id_DF071553D0996FF9.origin);
}

_id_09629C9CEF1CB674(_id_810BAC61EC8C9792, _id_A53E70F6D949BABD) {
  scripts\engine\utility::flag_wait("objectives_registered");
  objindex = scripts\cp\cp_objectives::requestworldid("random_box");

  if(objindex != -1) {
    objective_state(objindex, "active");
    objective_position(objindex, _id_A53E70F6D949BABD);
    objective_icon(objindex, _id_810BAC61EC8C9792);
    objective_setbackground(objindex, 5);
    objective_setminimapiconsize(objindex, "icon_regular");
    self.objindex = objindex;
  }
}

_id_7264F0434FF33B05() {
  if(isDefined(self.objindex)) {
    objective_state(self.objindex, "done");
    objective_delete(self.objindex);
    scripts\cp\cp_objectives::freeworldid("random_box");
  }
}

_id_3B053B3F8F035E22(_id_DF071553D0996FF9, player) {
  level notify("drop_requested", _id_DF071553D0996FF9._id_F83BC8E4B98A16BA, undefined, _id_DF071553D0996FF9.script_noteworthy, _id_DF071553D0996FF9);
  player thread scripts\cp\cp_hud_message::showsplash("cp_random_box_incoming", undefined, player);
  _id_71332A5B74214116::_id_9A2E153E21F32208(_id_DF071553D0996FF9, player);
  _id_DF071553D0996FF9 thread _id_89A3AEC723869032(player);
}

_id_89A3AEC723869032(player) {
  level endon("game_ended");
  _id_71332A5B74214116::remove_from_current_interaction_list(self);
  self._id_C8FC403022EA9C7C._id_703B3B072DEA5230 = 1;
  level waittill("crate_dropped_" + self._id_F83BC8E4B98A16BA, crate);
  player thread scripts\cp\cp_hud_message::showsplash("cp_random_box_landed", undefined, player);
  crate waittill("death");
  self._id_C8FC403022EA9C7C._id_703B3B072DEA5230 = undefined;
  _id_71332A5B74214116::add_to_current_interaction_list(self);
  self._id_C8FC403022EA9C7C thread _id_780514F14B1134ED::_id_7D378614C1FE7036();
}

_id_D96ABD36A916B351(player, param2, param3, param4) {
  self disableplayeruse(player);

  if(getdvarint("dvar_66080A3A6A29A8D9", 1)) {
    _id_56218893A21367E0 = 0;
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_56218893A21367E0, self.origin, self.angles);
    weaponobj = _id_3958CB5D5B71926F();
    weapon = _id_66122A002AFF5D57::weaponspawn(weaponobj, _id_06FE80416B4BE165, undefined, 1);
    _id_56218893A21367E0++;
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_56218893A21367E0, self.origin, self.angles);
    _id_32E00752C95AAD17 = scripts\engine\utility::random(["brloot_offhand_claymore", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite", "brloot_offhand_throwingknife", "brloot_offhand_throwingknife_fire"]);
    item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, undefined, 1, undefined, 0);
    _id_56218893A21367E0++;
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_56218893A21367E0, self.origin, self.angles);
    item = _id_66122A002AFF5D57::spawnpickup("brloot_armor_plate", _id_06FE80416B4BE165, undefined, 1, undefined, 1);
    _id_56218893A21367E0++;
    _id_F376C1E66F42F294 = randomintrange(5, 10);

    for(_id_AC0E594AC96AA3A8 = _id_56218893A21367E0; _id_AC0E594AC96AA3A8 < _id_F376C1E66F42F294; _id_AC0E594AC96AA3A8++) {
      _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_AC0E594AC96AA3A8, self.origin, self.angles);
      drop_type = weighted_array_randomize(level._id_F60F73A1AF0D331A, level._id_5BDB68CBA21DC387);
      _id_920F4173513EB6B8 = undefined;

      if(drop_type == "weapons") {
        weaponobj = _id_3958CB5D5B71926F();
        weapon = _id_66122A002AFF5D57::weaponspawn(weaponobj, _id_06FE80416B4BE165, undefined, 1);
        continue;
      }

      if(drop_type == "equipment") {
        _id_32E00752C95AAD17 = scripts\engine\utility::random(["brloot_offhand_claymore", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite", "brloot_offhand_throwingknife", "brloot_offhand_throwingknife_fire"]);
        item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, undefined, 0);
        continue;
      }

      if(drop_type == "armor") {
        item = _id_66122A002AFF5D57::spawnpickup("brloot_armor_plate", _id_06FE80416B4BE165, undefined, 1, undefined, 1);
        continue;
      }

      if(drop_type == "munition") {
        _id_B9702BE39BD96E38 = scripts\engine\utility::random(["brloot_munition_hover_jet", "brloot_munition_precision_airstrike", "brloot_munition_cluster_strike", "brloot_munition_juggernaut", "brloot_munition_cruise_missile", "brloot_munition_turret", "brloot_munition_sentry"]);
        item = _id_66122A002AFF5D57::spawnpickup(_id_B9702BE39BD96E38, _id_06FE80416B4BE165, undefined, 0);
      }
    }
  } else {
    result = scripts\engine\utility::cointoss();

    if(result)
      _id_35E578049579143B(player);
    else
      _id_09A11A32BBB0DB7F(player);
  }
}

_id_35E578049579143B(player) {
  level endon("game_ended");
  player endon("disconnect");
  weapon = _id_3958CB5D5B71926F();
  weapons = player getweaponslistprimaries();
  _id_80DAEE44B2F7948E = 2;
  _id_3384211CA508ED2F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weapons.size; _id_AC0E594AC96AA3A8++) {
    name = weapons[_id_AC0E594AC96AA3A8].basename;

    if(issubstr(name, "ks_")) {
      continue;
    }
    if(weapons[_id_AC0E594AC96AA3A8].isalternate) {
      continue;
    }
    _id_3384211CA508ED2F[_id_3384211CA508ED2F.size] = weapons[_id_AC0E594AC96AA3A8];
  }

  if(player scripts\cp\utility::_hasperk("specialty_extra_weapon"))
    _id_80DAEE44B2F7948E = 3;

  if(_id_3384211CA508ED2F.size >= _id_80DAEE44B2F7948E) {
    _id_0B30A1E974D02FDA = player getcurrentprimaryweapon();

    if(isDefined(player.last_valid_weapon))
      _id_0B30A1E974D02FDA = player.last_valid_weapon;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3384211CA508ED2F.size; _id_AC0E594AC96AA3A8++) {
      name = weapons[_id_AC0E594AC96AA3A8].basename;

      if(issubstr(name, "fist")) {
        _id_0B30A1E974D02FDA = weapons[_id_AC0E594AC96AA3A8];
        break;
      }
    }

    player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0B30A1E974D02FDA);
  }

  player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon);
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon);
}

_id_09A11A32BBB0DB7F(player) {
  equipment = _id_FDC6133B815F97E0(player);
  count = level._id_D99C5845920F7E63[equipment];
  slot = level._id_C9C74CDADEEC4710[equipment];
  player _id_7EF95BBA57DC4B82::giveequipment(equipment, slot);
  player _id_7EF95BBA57DC4B82::setequipmentammo(equipment, 1);
}

_id_783E3767630A6D54(model, origin, angles) {
  item = spawn("script_model", origin);

  if(!isDefined(angles))
    item.angles = angles;

  item setModel("");
  return item;
}

_id_3958CB5D5B71926F(_id_0B30A1E974D02FDA) {
  weapon_name = weighted_array_randomize(level._id_D8EDB7719C07AFEA, level._id_8647EA3DFB060CA8);

  if(scripts\cp\utility::weaponhasvariants(weapon_name))
    weapon_obj = _id_2669878CF5A1B6BC::buildweapon_blueprint(weapon_name, "none", "none", randomint(11));
  else
    weapon_obj = _id_2669878CF5A1B6BC::buildweapon(weapon_name, [], "none", "none", -1);

  return weapon_obj;
}

_id_FDC6133B815F97E0() {
  equipment = weighted_array_randomize(level._id_A11248D60A8D34EB, level._id_B20F1A43A065B04D);
  return equipment;
}

weighted_array_randomize(array, weights) {
  _id_13ACBD53528ED1FF = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weights.size; _id_AC0E594AC96AA3A8++)
    _id_13ACBD53528ED1FF = _id_13ACBD53528ED1FF + weights[_id_AC0E594AC96AA3A8];

  random_weight = randomfloat(_id_13ACBD53528ED1FF);
  _id_98ABCC65D2B0707D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_98ABCC65D2B0707D = _id_98ABCC65D2B0707D + weights[_id_AC0E594AC96AA3A8];

    if(_id_98ABCC65D2B0707D >= random_weight)
      return array[_id_AC0E594AC96AA3A8];
  }
}