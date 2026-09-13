/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\values.gsc
***********************************************/

_id_20EB90F5B8963388() {
  _id_7372010B17478CDC("breath_system", 1, 0, "$self", ::_id_FF6D5864F8680D5E, "$value");
  _id_7372010B17478CDC("damage", 1, 0, "$self", ::_id_A49123F94EDB0267, "$value");
  _id_7372010B17478CDC("death", 1, 0, "$self", ::set_allowdeath, "$value");
  _id_7372010B17478CDC("damage_shield", 0, 1, "$self", ::_id_8ABA0B6AF3DCB0EF, "$value");
  _id_7372010B17478CDC("magic_bullet_shield", 0, 1, "$self", ::_id_F0041C526121C712, "$value");
  _id_428D899920A93A15("magic_bullet_shield", "$self", ::_id_8F3C8A48E0AAF653);
  _id_EE91862B850C90E5("magic_bullet_shield", "death", ::_id_527B675B7B7C98BA);
  _id_EE91862B850C90E5("magic_bullet_shield", "attackeraccuracy", ::_id_E7BE18472C15E999);
  _id_7372010B17478CDC("ignoresuppression", 0, 1, "$self", ::set_ignoresuppression, "$value");
  _id_7372010B17478CDC("whizby", 1, 0);
  _id_7372010B17478CDC("ignoreme", 0, 1, "$self", ::set_ignoreme, "$value");
  _id_7372010B17478CDC("ignoreall", 0, 1, "$self", ::set_ignoreall, "$value");
  _id_7372010B17478CDC("take_weapons", 0, 1, "$self", ::_id_0EC5F3E2B9F97388, "$value");
  _id_7372010B17478CDC("weapon", 1, 0, "$self", ::_id_945A9012BE94D89B, "$value");
  _id_7372010B17478CDC("weapon_switch", 1, 0, "$self", ::_id_271781B97A830B8F, "$value");
  _id_7372010B17478CDC("weapon_switch_clip", 1, 0, "$self", ::_id_CBBBE022B06A2D09, "$value");
  _id_7372010B17478CDC("script_weapon_switch", 0, 1);
  _id_7372010B17478CDC("reload", 1, 0, "$self", ::_id_6A7974BC3033866F, "$value");
  _id_7372010B17478CDC("weapon_pickup", 1, 0, "$self", ::_id_AC139CD4BD7D232E, "$value");
  _id_7372010B17478CDC("fire", 1, 0, "$self", ::_id_CDA8EF3BEBB4E3EE, "$value");
  _id_7372010B17478CDC("autoreload", 1, 0, "$self", ::_id_1155B13235411EEC, "$value");
  _id_7372010B17478CDC("weapon_first_raise_anims", 1, 0, "$self", ::_id_782C9CFC7F78E416, "$value");
  _id_7372010B17478CDC("offhand_weapons", 1, 0, "$self", ::_id_8FDF6DF702996FA7, "$value");

  if(!isDefined(level.ismp) || level.ismp == 0)
    _id_EE91862B850C90E5("offhand_weapons", "offhand_shield_weapons");

  _id_7372010B17478CDC("offhand_primary_weapons", 1, 0, "$self", ::_id_47279B5D7E2BCEF3, "$value");
  _id_7372010B17478CDC("offhand_secondary_weapons", 1, 0, "$self", ::_id_0C8F662A90251117, "$value");
  _id_EE91862B850C90E5("offhand_secondary_weapons", "offhand_shield_weapons");
  _id_7372010B17478CDC("offhand_shield_weapons", 1, 0, "$self", ::_id_F61D010FF82A69DA, "$value");
  _id_7372010B17478CDC("offhand_throwback", 1, 0, "$self", ::_id_54A3481116D62F02, "$value");
  _id_7372010B17478CDC("allow_offhand_special", 1, 0, "$self", ::_id_8493479DECAD7DEA, "$value");
  _id_7372010B17478CDC("allow_aim_assist", 1, 0, "$self", ::_id_4E24D3EB9687A667, "$value");
  _id_7372010B17478CDC("usability", 1, 0, "$self", ::_id_586996315A6703B0, "$value");
  _id_7372010B17478CDC("freezecontrols", 0, 1, "$self", ::_id_15CC9BFDA3C4ADEE, "$value");
  _id_7372010B17478CDC("hide", 0, 1, "$self", ::_id_9B7E3DD11D626C78, "$value");
  _id_7372010B17478CDC("health_regen", 1, 0, "$self", ::_id_578637C64746E290, "$value");
  _id_7372010B17478CDC("allow_health_regen_delay", 1, 0, "$self", ::_id_1140C973AA64C8D6, "$value");
  _id_7372010B17478CDC("ignore_health_regen_delay", 0, 1, "$self", ::_id_1BBA831C3C8052EB, "$value");
  _id_7372010B17478CDC("stealth_social_reveal", 0, 1, "$self", ::_id_00D4513B1BC21601, "$value");
  _id_7372010B17478CDC("show_hud", 1, 0, "$self", ::_id_688748C7477E93DC, "$value");
  _id_7372010B17478CDC("show_weapon_hud", 1, 0, "$self", ::_id_8B2FC23241E6448B, "$value");
  _id_7372010B17478CDC("show_dpad_hud", 1, 0, "$self", ::_id_147FE8BDA5949CF2, "$value");
  _id_7372010B17478CDC("show_hit_marker", 1, 0, "$self", ::_id_AE5BBCEB3D29EFE6, "$value");
  _id_7372010B17478CDC("allow_jump", 1, 0, "$self", ::_id_C10182E05A99F789, "$value");
  _id_7372010B17478CDC("allow_double_jump", 1, 0, "$self", ::_id_5D8C973A5B6B05D8, "$value");
  _id_7372010B17478CDC("crouch", 1, 0, "$self", ::_id_4DD00F1BE6C69677, "$value");
  _id_7372010B17478CDC("prone", 1, 0, "$self", ::_id_D4A512C33A86E3D1, "$value");
  _id_7372010B17478CDC("stance_change", 1, 0, "$self", ::_id_C8E47B79550E4319, "$value");
  _id_7372010B17478CDC("melee", 1, 0, "$self", ::_id_EBF228FBB0A74D57, "$value");
  _id_7372010B17478CDC("lean", 1, 0, "$self", ::_id_1E949110CE628E51, "$value");
  _id_7372010B17478CDC("allow_melee_victim", 1, 0, "$self", ::_id_8B3076FE0A5DA3CE, "$value");
  _id_7372010B17478CDC("mantle", 1, 0, "$self", ::_id_B3870B9EC763D70A, "$value");
  _id_7372010B17478CDC("mount_top", 1, 0, "$self", ::_id_9B5BEFBB13AD7651, "$value");
  _id_7372010B17478CDC("mount_side", 1, 0, "$self", ::_id_AAC726AF48296365, "$value");
  _id_7372010B17478CDC("sprint", 1, 0, "$self", ::_id_0F7C69559DBF71A1, "$value");
  _id_7372010B17478CDC("jog", 1, 0, "$self", ::_id_2A827539B0EE61B7, "$value");
  _id_7372010B17478CDC("ads", 1, 0, "$self", ::_id_888BC6393955267D, "$value");
  _id_7372010B17478CDC("stand", 1, 0, "$self", ::_id_503F80A21C85A0FF, "$value");
  _id_7372010B17478CDC("allow_movement", 1, 0, "$self", ::_id_1B400B9F81972824, "$value");
  _id_7372010B17478CDC("ladder", 1, 0, "$self", ::_id_F3B4BC17C87ADBA5, "$value");
  _id_7372010B17478CDC("swimming_underwater", 1, 0, "$self", ::_id_880120DB350A6425, "$value");
  _id_7372010B17478CDC("dtp", 1, 0, "$self", ::_id_D13B7A396EAB0463, "$value");
  _id_7372010B17478CDC("move_speed_scale", 1.0, 1.0, "$self", ::_id_46EDA303C0FA6322, "$value");
  _id_7372010B17478CDC("desired_speed", 0.0, 0.0, "$self", ::_id_EA87AB85D222844D, "$value");
  _id_7372010B17478CDC("goalradius", 2048, 2048, "$self", ::set_goal_radius, "$value");
  _id_7372010B17478CDC("push_player", 0, 1, "$self", ::_id_5241AABB76D1BC21, "$value");
  _id_7372010B17478CDC("skip_death", 0, 1, "$self", ::_id_397BDAE9676D99B2, "$value");
  _id_7372010B17478CDC("skip_scene_death", 0, 1, "$self", ::_id_C7CACBE604C9200D, "$value");
  _id_7372010B17478CDC("supers", 1, 0, "$self", ::_id_0EE3A42D7C6B37FE, "$value");
  _id_7372010B17478CDC("wallrun", 1, 0, "$self", ::_id_98E071A6CC904543, "$value");
  _id_7372010B17478CDC("doublejump", 1, 0, "$self", ::_id_156A6EF9E8BB6F63, "$value");
  _id_7372010B17478CDC("slide", 1, 0, "$self", ::_id_60E7C22BAC17F22F, "$value");
  _id_7372010B17478CDC("execution_attack", 1, 0, "$self", ::_id_5E4E727A591C079D, "$value");
  _id_7372010B17478CDC("execution_victim", 1, 0, "$self", ::_id_EB0398E7C2C3C055, "$value");
  _id_7372010B17478CDC("vehicle_use", 1, 0, "$self", ::_id_E62E9EFD7D1BF0DA, "$value");
  _id_7372010B17478CDC("vehicle_lean_out", 1, 0, "$self", ::_id_798A407672C35E3C, "$value");
  _id_7372010B17478CDC("vehicle_seat_switch", 1, 0, "$self", ::_id_2A5481B1DA502117, "$value");
  _id_7372010B17478CDC("nvg", 1, 0, "$self", ::_id_125B3C053100C3C8, "$value");
  _id_7372010B17478CDC("supersprint", 1, 0, "$self", ::_id_65FB0F9B12A90F29, "$value");
  _id_7372010B17478CDC("shellshock", 1, 0, "$self", ::_id_3368E1D4052B1596, "$value");
  _id_7372010B17478CDC("cinematic_motion", 1, 0, "$self", ::_id_EA01B65C909B99D2, "$value");
  _id_7372010B17478CDC("armor", 1, 0, "$self", ::_id_293669B3B38C7221, "$value");
  _id_7372010B17478CDC("door_frozen", 0, 1, "$self", ::_id_2937A757C6689FB3, "$value");
  _id_7372010B17478CDC("interactions", 1, 0, "$self", ::_id_CBDFE6762B367D1B, "$value");
  _id_7372010B17478CDC("action_slot_weapon", 1, 0, "$self", ::_id_DC9CE02E5A3BD6DA, "$value");
  _id_7372010B17478CDC("hide_operator_backpack", 0, 1, "$self", ::_id_0CFB80F3B8AAD230, "$value");
  _id_7372010B17478CDC("show_operator_pet", 1, 0, "$self", ::_id_9C9B518E967A4514, "$value");
  _id_7372010B17478CDC("equipment_primary", 1, 0, "$self", ::_id_DD8E7FDCE5F0DCFF, "$value");
  _id_7372010B17478CDC("equipment_secondary", 1, 0, "$self", ::_id_02B70E9743C9A71B, "$value");
  _id_7372010B17478CDC("overlord_locked_priority", 0.0, 0.0, "$self", ::_id_F8B197BEEC8E9945, "$value");
  _id_7372010B17478CDC("demeanor", "", "", "$self", ::set_demeanor, "$value");
  _id_7372010B17478CDC("pain", 1, 0, "$self", ::_id_E839D0E33E07C756, "$value");
  _id_7372010B17478CDC("regen_rate", 40.0, 40.0, "$self", ::_id_BC69B2952BAD1F73, "$value");
  _id_7372010B17478CDC("regen_delay", 3.0, 3.0, "$self", ::_id_D22FD39899FE2514, "$value");
  _id_7372010B17478CDC("attackeraccuracy", 1, 1);
  _id_7372010B17478CDC("ascender_use", 1, 0);
  _id_7372010B17478CDC("crate_use", 1, 0);
  _id_7372010B17478CDC("cough_gesture", 1, 0);
  _id_7372010B17478CDC("ladder_placement", 1, 0);
  _id_7372010B17478CDC("killstreaks", 1, 0);
  _id_7372010B17478CDC("cp_munitions", 1, 0);
  _id_7372010B17478CDC("one_hit_melee_victim", 1, 0);
  _id_7372010B17478CDC("flashed", 1, 0);
  _id_7372010B17478CDC("stunned", 1, 0);
  _id_7372010B17478CDC("stick_kill", 1, 0);
  _id_7372010B17478CDC("unresolved_collisions", 1, 0);
  _id_7372010B17478CDC("allow_super_jump", 1, 0);
}

_id_7372010B17478CDC(_id_957163D1155464E2, _id_74EC7A474B47B41C, _id_8F2A3DE49E1F0527, _id_4D2D7D0FD0F38637, func, _id_434809FD34BABEE0) {
  if(!isDefined(level.values))
    level.values = [];

  _id_19E5D22684B42CA9 = getarraykeys(level.values);

  if(scripts\engine\utility::array_contains(_id_19E5D22684B42CA9, _id_957163D1155464E2)) {
    return;
  }
  if(isDefined(_id_434809FD34BABEE0) && !isarray(_id_434809FD34BABEE0))
    _id_434809FD34BABEE0 = [_id_434809FD34BABEE0];

  if(!isDefined(_id_434809FD34BABEE0))
    _id_434809FD34BABEE0 = [];

  _id_0AD9C31003EF8158 = spawnStruct();
  _id_0AD9C31003EF8158._id_957163D1155464E2 = _id_957163D1155464E2;
  _id_0AD9C31003EF8158._id_4D2D7D0FD0F38637 = _id_4D2D7D0FD0F38637;
  _id_0AD9C31003EF8158.func = func;
  _id_0AD9C31003EF8158._id_74EC7A474B47B41C = _id_74EC7A474B47B41C;
  _id_0AD9C31003EF8158._id_8F2A3DE49E1F0527 = _id_8F2A3DE49E1F0527;
  _id_0AD9C31003EF8158._id_41D5269D51C6BFF4 = _id_434809FD34BABEE0;
  level.values[_id_957163D1155464E2] = _id_0AD9C31003EF8158;
}

_id_2239A4A14E69A8EF(_id_957163D1155464E2) {
  if(isDefined(level.values))
    level.values[_id_957163D1155464E2] = undefined;
}

_id_2D6E7E0B80767910(group_name, _id_347687DDDFB04131) {
  if(!isDefined(level._id_2C32FA263B09C33B))
    level._id_2C32FA263B09C33B = [];

  level._id_2C32FA263B09C33B[group_name] = _id_347687DDDFB04131;
}

_id_3633B947164BE4F3(group_name, value) {
  _id_D4CC29E776820C4C = "_group_" + group_name;
  _id_59C053B89257BC95(_id_D4CC29E776820C4C, level._id_2C32FA263B09C33B[group_name], value);
}

_id_588F2307A3040610(group_name) {
  _id_D4CC29E776820C4C = "_group_" + group_name;
  _id_C9D0B43701BDBA00(_id_D4CC29E776820C4C);
}

_id_857FE0303DEDB778(_id_957163D1155464E2) {
  return 1;
}

_id_428D899920A93A15(_id_957163D1155464E2, _id_4D2D7D0FD0F38637, value, _id_434809FD34BABEE0) {
  if(_id_857FE0303DEDB778(_id_957163D1155464E2)) {
    if(isDefined(_id_434809FD34BABEE0) && !isarray(_id_434809FD34BABEE0))
      _id_434809FD34BABEE0 = [_id_434809FD34BABEE0];

    if(!isDefined(_id_434809FD34BABEE0))
      _id_434809FD34BABEE0 = [];

    _id_0AD9C31003EF8158 = level.values[_id_957163D1155464E2];
    _id_0AD9C31003EF8158._id_34BC9D2AF780FB01 = _id_4D2D7D0FD0F38637;
    _id_0AD9C31003EF8158._id_74EC7A474B47B41C = value;
    _id_0AD9C31003EF8158._id_B6C15B0DE2D56A22 = _id_434809FD34BABEE0;
  }
}

_id_EE91862B850C90E5(_id_957163D1155464E2, _id_04D81048FD967E05, func) {
  if(_id_857FE0303DEDB778(_id_957163D1155464E2)) {
    _id_0AD9C31003EF8158 = level.values[_id_957163D1155464E2];
    _id_5FE88B3A9D2968BE = spawnStruct();
    _id_5FE88B3A9D2968BE.name = _id_04D81048FD967E05;
    _id_5FE88B3A9D2968BE.func = func;

    if(!isDefined(_id_5FE88B3A9D2968BE.func))
      _id_5FE88B3A9D2968BE.func = ::_id_9D2FB572E4091B34;

    _id_0AD9C31003EF8158._id_B69AA7B59AA1F9E2[_id_04D81048FD967E05] = _id_5FE88B3A9D2968BE;
  }
}

_id_9D2FB572E4091B34(_id_77C892C2CEC7A0EB) {
  return _id_77C892C2CEC7A0EB;
}

set(_id_D4CC29E776820C4C, _id_957163D1155464E2, value) {
  if(_id_857FE0303DEDB778(_id_957163D1155464E2)) {
    if(!isDefined(value))
      value = level.values[_id_957163D1155464E2]._id_8F2A3DE49E1F0527;

    _id_84DAF63CB0F79E23(_id_D4CC29E776820C4C, _id_957163D1155464E2, value);
    _id_2A218863F3CDF349(_id_957163D1155464E2, value);
  }

  if(isarray(level.values[_id_957163D1155464E2]._id_B69AA7B59AA1F9E2)) {
    foreach(_id_97480D1662BB5AFF in level.values[_id_957163D1155464E2]._id_B69AA7B59AA1F9E2)
    set(_id_D4CC29E776820C4C, _id_97480D1662BB5AFF.name, [[_id_97480D1662BB5AFF.func]](value));
  }
}

_id_59C053B89257BC95(_id_D4CC29E776820C4C, _id_D1450EF5EE023044, value) {
  foreach(_id_957163D1155464E2 in _id_D1450EF5EE023044)
  set(_id_D4CC29E776820C4C, _id_957163D1155464E2, value);
}

_id_E0751B03DFB9EB43(_id_957163D1155464E2) {
  if(_id_857FE0303DEDB778(_id_957163D1155464E2)) {
    if(isDefined(self.values) && isDefined(self.values[_id_957163D1155464E2])) {
      _id_2E78F93D5C47361A = self.values[_id_957163D1155464E2].size - 1;

      if(_id_2E78F93D5C47361A >= 0 && isDefined(self.values[_id_957163D1155464E2][_id_2E78F93D5C47361A].value))
        return self.values[_id_957163D1155464E2][_id_2E78F93D5C47361A].value;
    }

    return _id_ADC5570CA43BF869(_id_957163D1155464E2);
  }
}

_id_B8752CBC9310DBBF(_id_957163D1155464E2, value) {
  set("radiant", _id_957163D1155464E2, value);
}

_id_FB8578079795E3A1(_id_D7B494B43ADCB54F, _id_D4CC29E776820C4C, _id_957163D1155464E2, value) {
  self endon("death");
  set(_id_D4CC29E776820C4C, _id_957163D1155464E2, value);
  wait(_id_D7B494B43ADCB54F);
  _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, _id_957163D1155464E2);
}

_id_462E6336A0DC84A8(_id_D4CC29E776820C4C, _id_957163D1155464E2) {
  _id_2E78F93D5C47361A = _id_637FD9B91C8B1623(_id_D4CC29E776820C4C, _id_957163D1155464E2);

  if(!_id_2E78F93D5C47361A) {
    if(isDefined(self.values) && isDefined(self.values[_id_957163D1155464E2]) && self.values[_id_957163D1155464E2].size > 0)
      _id_2A218863F3CDF349(_id_957163D1155464E2, self.values[_id_957163D1155464E2][0].value);
    else
      _id_548DF0B2FFD1DE95(_id_957163D1155464E2);
  }

  if(isarray(level.values[_id_957163D1155464E2]._id_B69AA7B59AA1F9E2)) {
    foreach(_id_97480D1662BB5AFF in level.values[_id_957163D1155464E2]._id_B69AA7B59AA1F9E2)
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, _id_97480D1662BB5AFF.name);
  }
}

_id_C9D0B43701BDBA00(_id_D4CC29E776820C4C) {
  if(!isDefined(self.values)) {
    return;
  }
  _id_7354D28B732F3B06 = _func_82D95BA721744147(self.values);

  foreach(_id_8F0D78AA4ACFE8C5, _id_6D0BB6FDBB532A90 in _id_7354D28B732F3B06) {
    foreach(state in _id_6D0BB6FDBB532A90) {
      if(isDefined(state._id_D4CC29E776820C4C) && state._id_D4CC29E776820C4C == _id_D4CC29E776820C4C)
        _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, _id_8F0D78AA4ACFE8C5);
    }
  }
}

_id_1A0B0A06690C8088(_id_957163D1155464E2) {
  _id_462E6336A0DC84A8("radiant", _id_957163D1155464E2);
}

nuke(_id_957163D1155464E2) {
  self.values[_id_957163D1155464E2] = [];
  _id_548DF0B2FFD1DE95(_id_957163D1155464E2);
}

_id_8B5F9E0014775208() {
  if(!isDefined(self.values)) {
    return;
  }
  _id_9C45B28E12994E8F = [];

  foreach(_id_957163D1155464E2, value in self.values)
  _id_9C45B28E12994E8F[_id_9C45B28E12994E8F.size] = _id_957163D1155464E2;

  foreach(_id_957163D1155464E2 in _id_9C45B28E12994E8F)
  nuke(_id_957163D1155464E2);
}

_id_84DAF63CB0F79E23(_id_D4CC29E776820C4C, _id_957163D1155464E2, value) {
  _id_637FD9B91C8B1623(_id_D4CC29E776820C4C, _id_957163D1155464E2);

  if(!isDefined(self.values))
    self.values = [];

  if(!isDefined(self.values[_id_957163D1155464E2]))
    self.values[_id_957163D1155464E2] = [];

  _id_6302CA9978061647 = spawnStruct();
  _id_6302CA9978061647._id_D4CC29E776820C4C = _id_D4CC29E776820C4C;
  _id_6302CA9978061647.value = value;
  self.values[_id_957163D1155464E2] = scripts\engine\utility::array_insert(self.values[_id_957163D1155464E2], _id_6302CA9978061647, 0);
}

_id_637FD9B91C8B1623(_id_D4CC29E776820C4C, _id_957163D1155464E2) {
  if(!isDefined(self))
    return -1;

  _id_2E78F93D5C47361A = undefined;

  if(isDefined(self.values) && isDefined(self.values[_id_957163D1155464E2])) {
    for(_id_2E78F93D5C47361A = self.values[_id_957163D1155464E2].size - 1; _id_2E78F93D5C47361A >= 0; _id_2E78F93D5C47361A--) {
      if(self.values[_id_957163D1155464E2][_id_2E78F93D5C47361A]._id_D4CC29E776820C4C == _id_D4CC29E776820C4C) {
        self.values[_id_957163D1155464E2] = scripts\engine\utility::array_remove_index(self.values[_id_957163D1155464E2], _id_2E78F93D5C47361A);
        break;
      }
    }

    if(!self.values[_id_957163D1155464E2].size) {
      self.values[_id_957163D1155464E2] = undefined;

      if(!self.values.size)
        self.values = undefined;
    }
  }

  return scripts\engine\utility::ter_op(isDefined(_id_2E78F93D5C47361A), _id_2E78F93D5C47361A, -1);
}

_id_2A218863F3CDF349(_id_957163D1155464E2, value) {
  _id_0AD9C31003EF8158 = level.values[_id_957163D1155464E2];

  if(isDefined(_id_0AD9C31003EF8158)) {
    _id_0AD9C31003EF8158.value = value;

    if(isDefined(_id_0AD9C31003EF8158.func)) {
      _id_4D2D7D0FD0F38637 = scripts\engine\utility::ter_op(isstring(_id_0AD9C31003EF8158._id_4D2D7D0FD0F38637) && _id_0AD9C31003EF8158._id_4D2D7D0FD0F38637 == "$self", self, _id_0AD9C31003EF8158._id_4D2D7D0FD0F38637);
      scripts\engine\utility::_id_4F220ACA2909F184(_id_4D2D7D0FD0F38637, _id_0AD9C31003EF8158.func, _id_0BDF4BD4BFD210F6(_id_0AD9C31003EF8158._id_41D5269D51C6BFF4, value));
    }
  }
}

_id_ADC5570CA43BF869(_id_957163D1155464E2) {
  _id_74EC7A474B47B41C = undefined;
  _id_0AD9C31003EF8158 = level.values[_id_957163D1155464E2];

  if(isDefined(_id_0AD9C31003EF8158) && isDefined(_id_0AD9C31003EF8158._id_74EC7A474B47B41C)) {
    if(isfunction(_id_0AD9C31003EF8158._id_74EC7A474B47B41C)) {
      _id_4D2D7D0FD0F38637 = scripts\engine\utility::ter_op(isstring(_id_0AD9C31003EF8158._id_34BC9D2AF780FB01) && _id_0AD9C31003EF8158._id_34BC9D2AF780FB01 == "$self", self, _id_0AD9C31003EF8158._id_34BC9D2AF780FB01);
      _id_74EC7A474B47B41C = scripts\engine\utility::_id_4F220ACA2909F184(_id_4D2D7D0FD0F38637, _id_0AD9C31003EF8158._id_74EC7A474B47B41C, _id_0BDF4BD4BFD210F6(_id_0AD9C31003EF8158._id_B6C15B0DE2D56A22));
    } else
      _id_74EC7A474B47B41C = _id_0AD9C31003EF8158._id_74EC7A474B47B41C;
  }

  return _id_74EC7A474B47B41C;
}

_id_548DF0B2FFD1DE95(_id_957163D1155464E2) {
  _id_74EC7A474B47B41C = _id_ADC5570CA43BF869(_id_957163D1155464E2);

  if(isDefined(_id_74EC7A474B47B41C))
    _id_2A218863F3CDF349(_id_957163D1155464E2, _id_74EC7A474B47B41C);
}

_id_32EFB357C319ABF0(array, _id_360B7934C10DF8F6, _id_DA3FF4B19BBF2C53) {
  foreach(_id_AC0E594AC96AA3A8, val in array) {
    if(isstring(val) && val == _id_360B7934C10DF8F6)
      array[_id_AC0E594AC96AA3A8] = _id_DA3FF4B19BBF2C53;
  }

  return array;
}

_id_0BDF4BD4BFD210F6(_id_41D5269D51C6BFF4, value) {
  if(isDefined(_id_41D5269D51C6BFF4)) {
    _id_41D5269D51C6BFF4 = _id_32EFB357C319ABF0(_id_41D5269D51C6BFF4, "$self", self);
    _id_41D5269D51C6BFF4 = _id_32EFB357C319ABF0(_id_41D5269D51C6BFF4, "$value", value);
  }

  return _id_41D5269D51C6BFF4;
}

_id_A49123F94EDB0267(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(isPlayer(self)) {
    if(scripts\common\utility::issp()) {
      if(_id_77C892C2CEC7A0EB == 1)
        self disableinvulnerability();
      else
        self enableinvulnerability();
    } else {}
  } else if(isai(self)) {
    if(_id_77C892C2CEC7A0EB == 1 && istrue(self.magic_bullet_shield))
      scripts\common\ai::_id_3F8F8FB4E593BFCE();
    else if(_id_77C892C2CEC7A0EB != 1 && !istrue(self.magic_bullet_shield))
      scripts\common\ai::_id_34707F8E64F52969(_id_77C892C2CEC7A0EB == -1);
  }
}

set_ignoresuppression(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self.ignoresuppression = _id_77C892C2CEC7A0EB;
}

set_allowdeath(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(isDefined(self.deathshieldfunc))
    self[[self.deathshieldfunc]](!_id_77C892C2CEC7A0EB);

  self.allowdeath = _id_77C892C2CEC7A0EB;
}

_id_8ABA0B6AF3DCB0EF(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self.damageshield = _id_77C892C2CEC7A0EB;
}

_id_F0041C526121C712(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self.magic_bullet_shield = _id_77C892C2CEC7A0EB;
}

_id_8F3C8A48E0AAF653() {
  self.magic_bullet_shield = undefined;
}

_id_527B675B7B7C98BA(_id_64717E5B22BCF08A) {
  return !_id_64717E5B22BCF08A;
}

_id_E7BE18472C15E999(_id_64717E5B22BCF08A) {
  return scripts\engine\utility::ter_op(_id_64717E5B22BCF08A, 0.1, 1);
}

_id_1D19C0B0F63836BF() {
  if(isPlayer(self))
    return !self isinvulnerable();
  else
    return self.takedamage;
}

_id_0EC5F3E2B9F97388(_id_77C892C2CEC7A0EB) {}

_id_945A9012BE94D89B(value) {
  if(!isDefined(value))
    value = 0;

  if(value != 1) {
    self disableweapons(scripts\engine\utility::ter_op(isnumber(value) && value == -1, 1, 0));

    if(isDefined(level.allow_weapon_mp))
      self[[level.allow_weapon_mp]](0);
  } else {
    self enableweapons();

    if(isDefined(level.allow_weapon_mp))
      self[[level.allow_weapon_mp]](1);
  }
}

_id_271781B97A830B8F(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableweaponswitch();
  else
    self disableweaponswitch();
}

_id_CBBBE022B06A2D09(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self disableemptyclipweaponswitch(0);
  else
    self disableemptyclipweaponswitch(1);
}

_id_CDA8EF3BEBB4E3EE(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self allowfire(1);
  else
    self allowfire(0);
}

_id_6A7974BC3033866F(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB != 1) {
    self allowreload(0);

    if(_id_77C892C2CEC7A0EB != -1) {
      self cancelreload();
      _id_5814D27874B48E54 = spawnStruct();
      _id_5814D27874B48E54.player = self;
      _id_5814D27874B48E54._id_C198F7CA473378FB = "ENTER_VEHICLE";
      _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
    }
  } else
    self allowreload(1);
}

_id_AC139CD4BD7D232E(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableweaponpickup();
  else
    self disableweaponpickup();
}

_id_1155B13235411EEC(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableautoreload();
  else
    self disableautoreload();
}

_id_8FDF6DF702996FA7(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableoffhandweapons();
  else
    self disableoffhandweapons();
}

_id_47279B5D7E2BCEF3(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableoffhandprimaryweapons();
  else
    self disableoffhandprimaryweapons();
}

_id_0C8F662A90251117(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableoffhandsecondaryweapons();
  else
    self disableoffhandsecondaryweapons();
}

_id_F61D010FF82A69DA(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowoffhandshieldweapons(_id_77C892C2CEC7A0EB);
}

_id_54A3481116D62F02(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB)
    self enableoffhandthrowback();
  else
    self disableoffhandthrowback();
}

_id_8493479DECAD7DEA(_id_77C892C2CEC7A0EB) {}

_id_4E24D3EB9687A667(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  setsaveddvar("dvar_03460979D7380DA0", !_id_77C892C2CEC7A0EB);
}

_id_586996315A6703B0(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self enableusability();
  else
    self disableusability();
}

set_ignoreme(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self.ignoreme = _id_77C892C2CEC7A0EB;
}

set_ignoreall(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self.ignoreall = _id_77C892C2CEC7A0EB;
}

_id_AE5BBCEB3D29EFE6(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB)
    self._id_91A2B92A7AA3E452 = undefined;
  else
    self._id_91A2B92A7AA3E452 = 1;
}

_id_9B7E3DD11D626C78(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB) {
    if(_id_77C892C2CEC7A0EB == 1)
      self hide();
    else
      self hide();
  } else
    self show();
}

_id_578637C64746E290(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB)
    self.disable_health_regen = undefined;
  else
    self.disable_health_regen = 1;
}

_id_1140C973AA64C8D6(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self._id_633AF906C0B1AAF8 = undefined;
  else
    self._id_633AF906C0B1AAF8 = 1;
}

_id_1BBA831C3C8052EB(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB)
    self._id_4E582A61633010E8 = 1;
  else
    self._id_4E582A61633010E8 = 0;
}

set_goal_radius(val) {
  if(isDefined(val))
    self.goalradius = val;
  else if(isDefined(self.radius))
    self.goalradius = float(self.radius);
  else if(isDefined(self.spawner.radius))
    self.goalradius = float(self.spawner.radius);
  else
    self.goalradius = 2048;
}

_id_397BDAE9676D99B2(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self.skipdeath = scripts\engine\utility::ter_op(_id_77C892C2CEC7A0EB, 1, 0);
}

_id_C7CACBE604C9200D(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self._id_0D7F93BA5F99D64C = scripts\engine\utility::ter_op(_id_77C892C2CEC7A0EB, 1, undefined);
}

_id_FF6D5864F8680D5E(_id_785A82E3F6EED24F) {
  self enableplayerbreathsystem(_id_785A82E3F6EED24F);
}

_id_15CC9BFDA3C4ADEE(_id_87395F3239B51779) {
  self freezecontrols(_id_87395F3239B51779);
}

_id_00D4513B1BC21601(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(!scripts\engine\utility::ent_flag_exist("stealth_social_reveal"))
    scripts\engine\utility::ent_flag_init("stealth_social_reveal");

  if(istrue(_id_77C892C2CEC7A0EB))
    scripts\engine\utility::ent_flag_set("stealth_social_reveal");
  else
    scripts\engine\utility::ent_flag_clear("stealth_social_reveal");
}

_id_688748C7477E93DC(_id_77C892C2CEC7A0EB) {
  if(_id_77C892C2CEC7A0EB)
    _id_77C892C2CEC7A0EB = 0;
  else
    _id_77C892C2CEC7A0EB = 1;

  self setclientomnvar("ui_hide_hud", _id_77C892C2CEC7A0EB);
}

_id_8B2FC23241E6448B(_id_77C892C2CEC7A0EB) {
  if(_id_77C892C2CEC7A0EB)
    _id_77C892C2CEC7A0EB = 0;
  else
    _id_77C892C2CEC7A0EB = 1;

  self setclientomnvar("ui_hide_weapon_info", _id_77C892C2CEC7A0EB);
}

_id_147FE8BDA5949CF2(_id_77C892C2CEC7A0EB) {
  if(_id_77C892C2CEC7A0EB)
    _id_77C892C2CEC7A0EB = 0;
  else
    _id_77C892C2CEC7A0EB = 1;

  self setclientomnvar("ui_hide_dpad_hud", _id_77C892C2CEC7A0EB);
}

_id_8B3076FE0A5DA3CE(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self._id_B23E4BBC1BF4614C = scripts\engine\utility::ter_op(_id_77C892C2CEC7A0EB, 1, 0);
}

_id_C10182E05A99F789(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowjump(_id_77C892C2CEC7A0EB);
}

_id_5D8C973A5B6B05D8(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowdoublejump(_id_77C892C2CEC7A0EB);
}

_id_4DD00F1BE6C69677(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowcrouch(_id_77C892C2CEC7A0EB);
}

_id_D4A512C33A86E3D1(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowprone(_id_77C892C2CEC7A0EB);
}

_id_C8E47B79550E4319(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  if(_id_77C892C2CEC7A0EB) {
    self allowstand(1);
    self allowcrouch(1);
    self allowprone(1);
  } else {
    current = self getstance();

    foreach(stance in scripts\engine\utility::array_remove(["stand", "crouch", "prone"], current)) {
      switch (stance) {
        case "stand":
          self allowstand(0);
          break;
        case "crouch":
          self allowcrouch(0);
          break;
        case "prone":
          self allowprone(0);
          break;
      }
    }
  }
}

_id_EBF228FBB0A74D57(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowmelee(_id_77C892C2CEC7A0EB);
}

_id_1E949110CE628E51(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowlean(_id_77C892C2CEC7A0EB);
}

_id_B3870B9EC763D70A(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowmantle(_id_77C892C2CEC7A0EB);
}

_id_9B5BEFBB13AD7651(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowmounttop(_id_77C892C2CEC7A0EB);
}

_id_AAC726AF48296365(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowmountside(_id_77C892C2CEC7A0EB);
}

_id_0F7C69559DBF71A1(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowsprint(_id_77C892C2CEC7A0EB);
}

_id_2A827539B0EE61B7(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowjog(_id_77C892C2CEC7A0EB);
}

_id_888BC6393955267D(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowads(_id_77C892C2CEC7A0EB);
}

_id_503F80A21C85A0FF(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowstand(_id_77C892C2CEC7A0EB);
}

_id_1B400B9F81972824(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self allowmovement(_id_77C892C2CEC7A0EB);
}

_id_F3B4BC17C87ADBA5(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self _meth_B13377D16B8E41DE(_id_77C892C2CEC7A0EB);
}

_id_880120DB350A6425(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self _meth_F484B2C51E0D6F5E(_id_77C892C2CEC7A0EB);
}

_id_D13B7A396EAB0463(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self _meth_D92F18565AAD28EC(_id_77C892C2CEC7A0EB);
}

_id_46EDA303C0FA6322(val) {
  if(!isDefined(val))
    val = 1;

  if(isai(self))
    scripts\asm\asm::asm_setmoveplaybackrate(val);
  else if(isPlayer(self))
    self setmovespeedscale(val);
}

_id_EA87AB85D222844D(val) {
  if(!isDefined(val))
    val = 0;

  if(!isai(self)) {
    return;
  }
  if(val > 0)
    self aisetdesiredspeed(val);
  else
    self aiclearscriptdesiredspeed(val);
}

_id_5241AABB76D1BC21(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self pushplayer(_id_77C892C2CEC7A0EB);
}

_id_0EE3A42D7C6B37FE(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self _meth_F9594EE32C931A2E();
  else
    self _meth_8A340E416D4D11ED();
}

_id_0CFB80F3B8AAD230(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB) {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
      if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.body) || self.operatorcustomization.body != "body_mp_gus_iw9_1_1")
        self hidepart("TAG_STOWED_BACKPACK_HIDE");
    }
  } else if(self tagexists("TAG_STOWED_BACKPACK_HIDE"))
    self showpart("TAG_STOWED_BACKPACK_HIDE");
}

_id_9C9B518E967A4514(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self _meth_360AA68E9D2FC8D3(!_id_77C892C2CEC7A0EB, self);
}

_id_98E071A6CC904543(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowwallrun(_id_77C892C2CEC7A0EB);
}

_id_156A6EF9E8BB6F63(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB) {
    self energy_setenergy(0, self.doublejumpenergy);
    self energy_setrestorerate(0, self.doublejumpenergyrestorerate);
    self.doublejumpenergy = undefined;
    self.doublejumpenergyrestorerate = undefined;
    self allowdoublejump(1);
  } else {
    self.doublejumpenergy = self energy_getenergy(0);
    self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
    self energy_setenergy(0, 0);
    self energy_setrestorerate(0, 0);
    self allowdoublejump(0);
  }
}

_id_60E7C22BAC17F22F(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowslide(_id_77C892C2CEC7A0EB);
}

_id_5E4E727A591C079D(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self[[level.enableexecutionattackfunc]]();
  else
    self[[level.disableexecutionattackfunc]]();
}

_id_EB0398E7C2C3C055(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self[[level.enableexecutionvictimfunc]]();
  else
    self[[level.disableexecutionvictimfunc]]();
}

_id_E62E9EFD7D1BF0DA(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  vehicle_allowplayeruse(self, _id_77C892C2CEC7A0EB);
}

_id_798A407672C35E3C(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self _meth_681750C19A6216CA(_id_77C892C2CEC7A0EB);
}

_id_2A5481B1DA502117(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self._id_EA02A8BFCFDE7C4B = scripts\engine\utility::ter_op(_id_77C892C2CEC7A0EB, undefined, 1);
}

_id_125B3C053100C3C8(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  _id_C7B3C8374684B876 = 2;

  if(_id_77C892C2CEC7A0EB) {
    if(!isai(self))
      self setactionslot(_id_C7B3C8374684B876, "nightvision");
  } else if(!isai(self))
    self setactionslot(_id_C7B3C8374684B876, "");
}

_id_65FB0F9B12A90F29(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  self allowsupersprint(_id_77C892C2CEC7A0EB);
}

_id_3368E1D4052B1596(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB) {
    if(isDefined(level.enableshellshockfunc))
      self[[level.enableshellshockfunc]]();
  } else if(isDefined(level.disableshellshockfunc))
    self[[level.disableshellshockfunc]]();
}

_id_EA01B65C909B99D2(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB) {
    if(isDefined(level.player.cinematicmotionoverride))
      level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
    else
      level.player clearcinematicmotionoverride();
  } else
    self setcinematicmotionoverride("disabled");
}

_id_293669B3B38C7221(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(isDefined(self.armor) && isDefined(self.armor.toggleuifunc))
    self[[self.armor.toggleuifunc]](_id_77C892C2CEC7A0EB);
}

getequipmenttableinfo(ref) {
  if(isDefined(ref) && !isDefined(level.equipment.table[ref])) {}

  return level.equipment.table[ref];
}

getcurrentequipment(slot) {
  if(!isDefined(self.equipment))
    return undefined;

  return self.equipment[slot];
}

disableslotinternal(slot) {
  if(slot == "primary")
    self clearoffhandprimary();
  else if(slot == "secondary")
    self clearoffhandsecondary();
  else if(slot == "super")
    self clearoffhandspecial();
}

enableslotinternal(slot) {
  ref = getcurrentequipment(slot);
  _id_A1A3722FB9707783 = self getweaponslistoffhands();
  weapon = undefined;
  variantid = undefined;

  if(!isDefined(ref)) {
    return;
  }
  found = 0;

  foreach(_id_2EB789D043254817 in _id_A1A3722FB9707783) {
    _id_1189BD7FBE2861F8 = undefined;

    foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
      if(isDefined(_id_8BF83D28BE4C2D4F.objweapon.basename) && _id_2EB789D043254817.basename == _id_8BF83D28BE4C2D4F.objweapon.basename) {
        _id_1189BD7FBE2861F8 = _id_8BF83D28BE4C2D4F.ref;
        break;
      }
    }

    if(isDefined(_id_1189BD7FBE2861F8) && _id_1189BD7FBE2861F8 == ref) {
      found = 1;

      if(isDefined(_id_2EB789D043254817.variantid) && _id_2EB789D043254817.variantid > 0) {
        variantid = _id_2EB789D043254817.variantid;

        if(!isDefined(_id_2EB789D043254817.basename))
          return undefined;

        if(isDefined(variantid) && variantid > 0) {
          weapon = makeweapon(_id_2EB789D043254817.basename, [], undefined, undefined, variantid);
          _id_1092BC40C58C1C9A = _id_2EB789D043254817.basename + "|" + scripts\engine\utility::string(variantid);
          attachments = level._id_A1E3B0D7B2A7836F[_id_1092BC40C58C1C9A];

          foreach(attachment, _id_6794F7417ED0B5A2 in attachments)
          weapon = weapon withattachment(attachment, _id_6794F7417ED0B5A2);
        } else
          weapon = makeweapon(_id_2EB789D043254817.basename);
      } else {
        _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);
        weapon = _id_8BF83D28BE4C2D4F.objweapon;
      }

      break;
    }
  }

  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!istrue(found))
    weapon = _id_8BF83D28BE4C2D4F.objweapon;

  if(isDefined(weapon)) {
    if(isDefined(weapon) && !_id_8BF83D28BE4C2D4F.ispassive) {
      if(slot == "primary")
        self assignweaponoffhandprimary(weapon);
      else if(slot == "secondary")
        self assignweaponoffhandsecondary(weapon);
      else if(slot == "super")
        self assignweaponoffhandspecial(weapon);
    }
  } else {}
}

_id_DD8E7FDCE5F0DCFF(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    enableslotinternal("primary");
  else
    disableslotinternal("primary");
}

_id_02B70E9743C9A71B(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    enableslotinternal("secondary");
  else
    disableslotinternal("secondary");
}

_id_782C9CFC7F78E416(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  setsaveddvar("bg_disableWeaponFirstRaiseAnims", !_id_77C892C2CEC7A0EB);
}

_id_2937A757C6689FB3(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 1;

  self scriptabledoorfreeze(_id_77C892C2CEC7A0EB);
}

_id_CBDFE6762B367D1B(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    self.interactions_disabled = undefined;
  else
    self.interactions_disabled = 1;
}

_id_4E80F7E4FFE334E0(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB)
    scripts\engine\utility::flag_clear("weapon_scanning_off");
  else
    scripts\engine\utility::flag_set("weapon_scanning_off");
}

_id_DC9CE02E5A3BD6DA(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB && isDefined(self.actionslotweapon))
    self setactionslot(1, "weapon", self.actionslotweapon);
  else
    self setactionslot(1, "");
}

set_demeanor(_id_360B7934C10DF8F6) {
  if(isai(self)) {
    if(!isDefined(_id_360B7934C10DF8F6) || _id_360B7934C10DF8F6 == "")
      scripts\common\utility::clear_demeanor_override();
    else
      scripts\common\utility::demeanor_override(_id_360B7934C10DF8F6);
  }
}

_id_E839D0E33E07C756(_id_77C892C2CEC7A0EB) {
  if(isai(self))
    self.allowpain = _id_77C892C2CEC7A0EB;
}

_id_F8B197BEEC8E9945(val) {
  if(isDefined(level._id_60FC087BC7DEAADC))
    self[[level._id_60FC087BC7DEAADC]](val);
}

_id_BEE64CEA73F1992B(_id_D4CC29E776820C4C, value) {
  if(value) {
    set(_id_D4CC29E776820C4C, "fire", !value);
    set(_id_D4CC29E776820C4C, "offhand_weapons", !value);
    set(_id_D4CC29E776820C4C, "allow_movement", !value);
    set(_id_D4CC29E776820C4C, "allow_jump", !value);
    set(_id_D4CC29E776820C4C, "melee", !value);
    set(_id_D4CC29E776820C4C, "sprint", !value);
    set(_id_D4CC29E776820C4C, "prone", !value);
  } else {
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "fire");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "offhand_weapons");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "allow_movement");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "allow_jump");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "melee");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "sprint");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "prone");
  }
}

_id_91558560B423D58E(_id_D4CC29E776820C4C, value) {
  if(value) {
    set(_id_D4CC29E776820C4C, "offhand_weapons", !value);
    set(_id_D4CC29E776820C4C, "allow_movement", !value);
    set(_id_D4CC29E776820C4C, "allow_jump", !value);
    set(_id_D4CC29E776820C4C, "melee", !value);
    set(_id_D4CC29E776820C4C, "sprint", !value);
  } else {
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "offhand_weapons");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "allow_movement");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "allow_jump");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "melee");
    _id_462E6336A0DC84A8(_id_D4CC29E776820C4C, "sprint");
  }
}

_id_BC69B2952BAD1F73(val) {
  val = scripts\engine\utility::_id_53C4C53197386572(val, 0);

  if(val > 0)
    self.gs.healthregenrate = val;
}

_id_D22FD39899FE2514(val) {
  val = scripts\engine\utility::_id_53C4C53197386572(val, 0);

  if(val > 0)
    self.gs.healthregendelay = val;
}