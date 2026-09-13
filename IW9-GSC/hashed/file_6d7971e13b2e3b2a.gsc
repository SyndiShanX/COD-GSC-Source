/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6d7971e13b2e3b2a.gsc
***********************************************/

init() {
  if(isDefined(level._id_A3EBA96DA74E0BF8)) {
    return;
  }
  _id_45F38D9C4F09112B();
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["vfx_br_legendary_loot_glow"] = loadfx("vfx/iw8_br/gameplay/vfx_br_launch_code_glow");
}

_id_45F38D9C4F09112B() {
  if(!isDefined(level._id_A3EBA96DA74E0BF8)) {
    level._id_A3EBA96DA74E0BF8 = spawnStruct();
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD = [];
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["rifle"] = "brloot_ammo_762";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["mg"] = "brloot_ammo_762";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["pistol"] = "brloot_ammo_919";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["smg"] = "brloot_ammo_919";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["sniper"] = "brloot_ammo_50cal";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["rocketlauncher"] = "brloot_ammo_rocket";
    level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD["spread"] = "brloot_ammo_12g";
  }

  level._id_A3EBA96DA74E0BF8._id_E481959866261112 = [];
  level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531 = [];
}

_id_8CD7F4939FAD286D(key, _id_744EDF9C7DF03F55) {
  if(!isDefined(level._id_A3EBA96DA74E0BF8)) {
    return;
  }
  if(!scripts\engine\utility::array_contains_key(level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531, key))
    level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key] = _id_7D7A712EF3B127EA(key, _id_744EDF9C7DF03F55);
  else {}
}

_id_7B8CCEDB73CC8FD3(_id_D974CC8B12DCBA2F, _id_B3067C4046466191) {
  if(_id_53B4DF89C7012E9A(_id_D974CC8B12DCBA2F)) {
    return;
  }
  if(scripts\engine\utility::array_contains_key(level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531, _id_D974CC8B12DCBA2F))
    level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[_id_D974CC8B12DCBA2F] = _id_B3067C4046466191;
}

_id_EF51288F40F95D1B(key, _id_DB35956D84816F27, _id_73783E51D7DCA907) {
  if(_id_53B4DF89C7012E9A(key)) {
    return;
  }
  _id_36BCC1E84D2A5F78 = level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key];

  if(!scripts\engine\utility::array_contains_key(_id_36BCC1E84D2A5F78, _id_DB35956D84816F27)) {
    level._id_A3EBA96DA74E0BF8._id_E481959866261112[key][_id_DB35956D84816F27] = _id_73783E51D7DCA907;
    level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key] = _id_7D7A712EF3B127EA(key, level._id_A3EBA96DA74E0BF8._id_E481959866261112[key]);
  } else {}
}

_id_26022CD17E1904CE(key, _id_DB35956D84816F27) {
  if(_id_53B4DF89C7012E9A(key)) {
    return;
  }
  _id_36BCC1E84D2A5F78 = level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key];

  if(scripts\engine\utility::array_contains_key(_id_36BCC1E84D2A5F78, _id_DB35956D84816F27)) {
    level._id_A3EBA96DA74E0BF8._id_E481959866261112[key] = scripts\engine\utility::array_remove_key(level._id_A3EBA96DA74E0BF8._id_E481959866261112[key], _id_DB35956D84816F27);
    level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key] = _id_7D7A712EF3B127EA(key, level._id_A3EBA96DA74E0BF8._id_E481959866261112[key]);
  } else {}
}

_id_B3D3903F8130FFF7(key) {
  if(_id_53B4DF89C7012E9A(key)) {
    return;
  }
  return level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531[key];
}

_id_D9EF8D5DAB99814C(key) {
  return scripts\engine\utility::array_contains_key(level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531, key);
}

_id_889A4446BB24EC16(_id_BAB91EC21655F39C, position, spawncount, _id_72E8F6018C6615A0, _id_434809FD34BABEE0) {
  if(_id_53B4DF89C7012E9A(_id_BAB91EC21655F39C)) {
    return;
  }
  _id_36BCC1E84D2A5F78 = _id_B3D3903F8130FFF7(_id_BAB91EC21655F39C);
  _id_60CE74182E7C83A7 = spawnStruct();
  _id_60CE74182E7C83A7.dropcount = randomintrange(1, 10);
  _id_60CE74182E7C83A7.heightoffset = 0;
  _id_60CE74182E7C83A7.origin = position;

  if(isstring(_id_72E8F6018C6615A0)) {} else if(_id_72E8F6018C6615A0)
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), position);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawncount; _id_AC0E594AC96AA3A8++) {
    _id_3B9EE963911A96C0 = randomfloat(1.0);

    foreach(key, _id_F90358454413407F in _id_36BCC1E84D2A5F78) {
      _id_F35B93A944C13DE8 = _id_F90358454413407F[2];
      _id_02B4EF98997BE493 = _id_F90358454413407F[3];

      if(_id_3B9EE963911A96C0 >= _id_F35B93A944C13DE8 && _id_3B9EE963911A96C0 <= _id_02B4EF98997BE493) {
        switch (key) {
          case "nothing":
            continue;
          case "brloot_ammo_killer_based":
            if(!isDefined(_id_434809FD34BABEE0)) {
              continue;
            }
            if(!isDefined(_id_434809FD34BABEE0["eAttacker"])) {
              continue;
            }
            attacker = _id_434809FD34BABEE0["eAttacker"];
            _id_5131DA474C4C19CA = undefined;

            if(isPlayer(attacker) || isbot(attacker) || isagent(attacker))
              _id_5131DA474C4C19CA = weaponclass(_id_434809FD34BABEE0["eAttacker"] getcurrentweapon());

            if(!isDefined(_id_5131DA474C4C19CA)) {
              continue;
            }
            _id_60CE74182E7C83A7.item = level._id_A3EBA96DA74E0BF8._id_32137B56AF4C22DD[_id_5131DA474C4C19CA];

            if(!isDefined(_id_60CE74182E7C83A7.item)) {
              continue;
            }
            break;
          default:
            _id_60CE74182E7C83A7.item = key;
            break;
        }

        _id_60CE74182E7C83A7.dropcount = _id_60CE74182E7C83A7.dropcount + 2;
        thread spawnloot(_id_60CE74182E7C83A7);
        waitframe();
      }
    }
  }
}

_id_53B4DF89C7012E9A(key) {
  if(!scripts\engine\utility::array_contains_key(level._id_A3EBA96DA74E0BF8._id_8B7D7CE1B42F0531, key))
    return 1;

  return 0;
}

spawnloot(_id_60CE74182E7C83A7) {
  _id_60CE74182E7C83A7.legendary = issubstr(_id_60CE74182E7C83A7.item, "lege");
  itemname = _id_60CE74182E7C83A7.item;
  spawnposition = _id_60CE74182E7C83A7.origin + (0, 0, _id_60CE74182E7C83A7.heightoffset);
  angles = (0, 0, 0);
  _id_63354ED1D936777B = _id_552B8E4EA5FF7DF1::lootspawnitem(itemname, _id_60CE74182E7C83A7, spawnposition, angles, 0, _id_60CE74182E7C83A7.legendary, 0);
  _id_60CE74182E7C83A7.heightoffset = _id_60CE74182E7C83A7.heightoffset + 3;
}

_id_7D7A712EF3B127EA(_id_CCF10DEF4015E022, _id_36BCC1E84D2A5F78) {
  _id_7F076C6B7A5EF5B3 = [];
  _id_7A3C33A815C53CA3 = 0;

  foreach(value in _id_36BCC1E84D2A5F78)
  _id_7A3C33A815C53CA3 = _id_7A3C33A815C53CA3 + value;

  index = 0;
  _id_B67D18CAC8627E8C = getarraykeys(_id_36BCC1E84D2A5F78);
  _id_800802AF73FA0898 = undefined;

  foreach(key, value in _id_36BCC1E84D2A5F78) {
    _id_7F076C6B7A5EF5B3[key] = [];
    _id_716C638075C3B64E = value / _id_7A3C33A815C53CA3;

    if(index == 0) {
      _id_BDE41274F0D07563 = 0;
      _id_B57BE88BB1F41A6E = _id_716C638075C3B64E;
    } else {
      _id_BDE41274F0D07563 = _id_800802AF73FA0898[3];
      _id_B57BE88BB1F41A6E = _id_BDE41274F0D07563 + _id_716C638075C3B64E;
    }

    _id_7F076C6B7A5EF5B3[key] = [value, _id_716C638075C3B64E, _id_BDE41274F0D07563, _id_B57BE88BB1F41A6E];
    _id_800802AF73FA0898 = _id_7F076C6B7A5EF5B3[key];
    index++;
  }

  level._id_A3EBA96DA74E0BF8._id_E481959866261112[_id_CCF10DEF4015E022] = _id_36BCC1E84D2A5F78;
  return _id_7F076C6B7A5EF5B3;
}