/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tactical_cover.gsc
***************************************************/

tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    _id_D805A86A5FE7AAF2 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(_id_D805A86A5FE7AAF2))
      level.taccovercollision = _id_D805A86A5FE7AAF2[0];
  }

  if(0)
    level.taccovertriggerblockers = getEntArray("dcover_blocker", "targetname");

  if(1) {
    if(!isDefined(level._id_F73654528E070AB4)) {
      level._id_F73654528E070AB4 = scripts\engine\utility::getStructArray("dcover_blocker_struct", "targetname");

      foreach(_id_445B9AC77407A627 in level._id_F73654528E070AB4)
      level _id_B8FFEACF84A9D34E(_id_445B9AC77407A627);
    } else {
      foreach(_id_445B9AC77407A627 in level._id_F73654528E070AB4)
      level _id_B8FFEACF84A9D34E(_id_445B9AC77407A627);

      level._id_F73654528E070AB4 = scripts\engine\utility::array_combine(level._id_F73654528E070AB4, getEntArray("dcover_blocker_struct", "targetname"));
    }
  }

  level.taccover_timeout = getdvarfloat("dvar_FDEB104EC6908DF8", 150.0);
  level._id_29BD6759D7F2ED45 = getdvarint("dvar_B2324A0894ED035F", 1);
  level._id_F3BE3F9BAD33BF87 = getdvarint(_func_2EF675C13CA1C4AF("dvar_2798C84281925605", scripts\mp\utility\game::getsubgametype(), "_damagedScoreLimit"), 0) == 1;
}

tac_cover_on_give(ref, slot, variantid) {
  self notify("tac_cover_given");
}

tac_cover_on_take(ref, slot, issuper) {
  self notify("tac_cover_taken");
  self.taccoverrefund = undefined;
}

tac_cover_used(grenade) {
  if(isDefined(grenade))
    grenade hide();

  waitframe();

  if(isDefined(grenade))
    grenade delete();
}

tac_cover_on_fired(ref, slot, objweapon, issuper) {
  if(self _meth_E40102956C887F7C() || !self isonground()) {
    tac_cover_fire_failed(0);
    return 0;
  }

  self.taccoverrefund = 1;
  contents = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle"]);
  ignorelist = tac_cover_ignore_list(self);

  if(ignorelist.size > 128) {
    logstring("count,entNum,birthtime,origin,classname,code_classname,model,targetname,script_noteworthy,ownerNum");
    _id_A2FCE1A0DAA1830A = getEntArray();

    foreach(_id_AC0E594AC96AA3A8, ent in ignorelist) {
      str = "" + _id_AC0E594AC96AA3A8;

      if(isent(ent)) {
        _id_B2469AF347C74CB8 = [ent getentitynumber(), ent.birthtime, ent.origin, ent.classname, ent.code_classname, ent.model, ent.targetname, ent.script_noteworthy];

        if(isDefined(ent.owner))
          _id_B2469AF347C74CB8[_id_B2469AF347C74CB8.size] = ent.owner getentitynumber();
        else
          _id_B2469AF347C74CB8[_id_B2469AF347C74CB8.size] = -1;

        foreach(value in _id_B2469AF347C74CB8) {
          if(!isDefined(value))
            value = "<undefined>";

          str = str + ("," + value);
        }
      } else
        str = str + ",not an ent";

      logstring(str);
    }
  }

  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  targetpos = self.origin + _id_20AF753DED3657E1 * 32;
  _id_44736CEE8AFAD49B = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(targetpos, 140, 20);
  _id_2464EDC7C410E680 = undefined;
  _id_445CCDA2FA82B65E = 0;

  if(tac_cover_blocked_by_turret(targetpos)) {
    tac_cover_fire_failed(0);
    return 0;
  }

  if(scripts\cp_mp\auto_ascender::_id_FF57F9ACF27BBC3C(targetpos))
    return 0;

  if(scripts\cp_mp\auto_ascender_solo::ispointnearsoloascenderline(targetpos))
    return 0;

  if(_id_6CC8838979F47B9F(targetpos) || _id_AC29E794C919FE03(targetpos) || _id_9461775D71E495CF(targetpos)) {
    tac_cover_fire_failed(0);
    return 0;
  }

  traceresults = undefined;
  contents = undefined;
  radius = getdvarfloat("dvar_9FA5C4D28EC05069", 40.0);

  if(istrue(level._id_29BD6759D7F2ED45)) {
    contents = physics_createcontents(["physicscontents_playerclip", "physicscontents_glass"]);
    traceresults = scripts\engine\trace::sphere_trace_get_all_results(targetpos, targetpos + (0, 0, 10), radius, undefined, contents, 1);
  } else {
    contents = scripts\engine\trace::_id_2D88CB1F022D0989();
    traceresults = scripts\engine\trace::sphere_trace_get_all_results(targetpos, targetpos + (0, 0, 10), radius, level.players, contents, 1);
  }

  foreach(trace in traceresults) {
    if(isDefined(trace["surfaceflags"])) {
      _id_8A9F2060AF8AFA5F = 19;
      _id_536E00A23D2DE14F = 0;
      _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | trace["surfaceflags"] == 8;
      _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | trace["surfaceflags"] == 2048;
      _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | trace["surfaceflags"] == 9 << _id_8A9F2060AF8AFA5F;
      _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | trace["surfaceflags"] == 39 << _id_8A9F2060AF8AFA5F;

      if(_id_536E00A23D2DE14F) {
        tac_cover_fire_failed(0);
        return 0;
      }
    }
  }

  foreach(door in _id_44736CEE8AFAD49B) {
    distsqrd = distancesquared(door.origin, targetpos);

    if(isDefined(_id_2464EDC7C410E680) && _id_445CCDA2FA82B65E <= distsqrd) {
      continue;
    }
    _id_2464EDC7C410E680 = door;
    _id_445CCDA2FA82B65E = distsqrd;
  }

  if(isDefined(_id_2464EDC7C410E680)) {
    _id_1B1FF29FE94010F6 = _id_2464EDC7C410E680 scriptabledoorangle();
    _id_CFB220142065EE31 = abs(_id_1B1FF29FE94010F6) > 65;
    _id_3D9512B73BDC1514 = undefined;

    foreach(otherdoor in _id_44736CEE8AFAD49B) {
      if(_id_2464EDC7C410E680 scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_is_double_door_pair(otherdoor)) {
        _id_3D9512B73BDC1514 = otherdoor;
        break;
      }
    }

    _id_560B069F3A9B36E4 = 1;

    if(isDefined(_id_3D9512B73BDC1514)) {
      _id_F5867C54C41D2A4D = _id_3D9512B73BDC1514 scriptabledoorangle();
      _id_560B069F3A9B36E4 = abs(_id_F5867C54C41D2A4D) > 65;
    }

    if(_id_445CCDA2FA82B65E < 1600 && _id_CFB220142065EE31 && _id_560B069F3A9B36E4) {
      startpos = self gettagorigin("j_spinelower");
      endpos = _id_2464EDC7C410E680 _meth_D90515F5E17DBC6F() + (0, 0, 24);
      _id_AA517194E54F048B = physics_raycast(startpos, endpos, contents, ignorelist, 0, "physicsquery_any", 1);

      if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B > 0) {
        _id_67243B08ECF2E214 = 1;

        if(isDefined(_id_2464EDC7C410E680.origin)) {
          data = _id_1D1BF10A8DA86B91(_id_2464EDC7C410E680.origin);
          _id_67243B08ECF2E214 = data[1];
        }

        tac_cover_fire_failed(_id_67243B08ECF2E214);
        return 0;
      }

      _id_2464EDC7C410E680.isblocked = 1;
      self.taccoverrefund = undefined;
      thread tac_cover_spawn_with_door(_id_2464EDC7C410E680, _id_3D9512B73BDC1514, issuper, contents);
      scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
      return 1;
    } else if(_id_445CCDA2FA82B65E < 6400) {
      _id_67243B08ECF2E214 = 1;

      if(isDefined(_id_2464EDC7C410E680.origin)) {
        data = _id_1D1BF10A8DA86B91(_id_2464EDC7C410E680.origin);
        _id_67243B08ECF2E214 = data[1];
      }

      tac_cover_fire_failed(_id_67243B08ECF2E214);
      return 0;
    }
  }

  _id_AC01A11A5F883C59 = self getplayerangles() * (0, 1, 0);
  caststart = self.origin + (0, 0, 24);
  castdir = anglesToForward(_id_AC01A11A5F883C59);
  _id_64B62CB5DC1E7AF6 = 29.5;
  _id_E2915F19F16FB5D0 = caststart + castdir * _id_64B62CB5DC1E7AF6;
  _id_AA517194E54F048B = physics_raycast(caststart, _id_E2915F19F16FB5D0, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
    tac_cover_fire_failed();
    return 0;
  }

  _id_9045F282A6B253E7 = undefined;
  _id_005EC2A3115E36D6 = undefined;
  caststart = _id_E2915F19F16FB5D0;
  castdir = anglestoright(_id_AC01A11A5F883C59);
  _id_64B62CB5DC1E7AF6 = 55.5;
  castend = caststart + castdir * _id_64B62CB5DC1E7AF6;
  _id_AA517194E54F048B = physics_spherecast(caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest");

  if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
    foreach(trace in _id_AA517194E54F048B) {
      if(isDefined(trace["surfaceflags"])) {
        _id_536E00A23D2DE14F = 0;
        _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | trace["surfaceflags"] == 8;

        if(_id_536E00A23D2DE14F) {
          tac_cover_fire_failed(0);
          return 0;
        }
      }
    }

    _id_2E3BC21C15E7AB6C = _id_AA517194E54F048B[0]["shape_position"];
    _id_9045F282A6B253E7 = _id_AA517194E54F048B[0]["fraction"];
  } else
    _id_9045F282A6B253E7 = 1;

  caststart = _id_E2915F19F16FB5D0;
  castdir = -1 * anglestoright(_id_AC01A11A5F883C59);
  _id_64B62CB5DC1E7AF6 = 55.5;
  castend = caststart + castdir * _id_64B62CB5DC1E7AF6;
  _id_AA517194E54F048B = physics_spherecast(caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest");

  if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
    foreach(trace in _id_AA517194E54F048B) {
      if(isDefined(trace["surfaceflags"])) {
        _id_536E00A23D2DE14F = 0;
        _id_536E00A23D2DE14F = _id_536E00A23D2DE14F | (trace["surfaceflags"] & 8) > 0;

        if(_id_536E00A23D2DE14F) {
          tac_cover_fire_failed(0);
          return 0;
        }
      }
    }

    _id_2E3BC21C15E7AB6C = _id_AA517194E54F048B[0]["shape_position"];
    _id_005EC2A3115E36D6 = _id_AA517194E54F048B[0]["fraction"];
  } else
    _id_005EC2A3115E36D6 = 1;

  if(_id_005EC2A3115E36D6 + _id_9045F282A6B253E7 < 1) {
    tac_cover_fire_failed();
    return 0;
  } else if(_id_9045F282A6B253E7 < 0.5)
    _id_E2915F19F16FB5D0 = _id_E2915F19F16FB5D0 + castdir * _id_64B62CB5DC1E7AF6 * (0.5 - _id_9045F282A6B253E7);
  else if(_id_005EC2A3115E36D6 < 0.5)
    _id_E2915F19F16FB5D0 = _id_E2915F19F16FB5D0 + castdir * _id_64B62CB5DC1E7AF6 * (0.5 - _id_005EC2A3115E36D6) * -1;

  castangles = _id_AC01A11A5F883C59;
  caststart = _id_E2915F19F16FB5D0;
  castdir = (0, 0, -1);
  _id_64B62CB5DC1E7AF6 = 60;
  castend = caststart + castdir * _id_64B62CB5DC1E7AF6;
  _id_188ECAFF115CACB7 = combineangles(castangles, (0, 0, 90));
  _id_AA517194E54F048B = physics_capsulecast(caststart, castend, 2.5, 16.8, _id_188ECAFF115CACB7, contents, ignorelist, "physicsquery_closest");

  if(!isDefined(_id_AA517194E54F048B) || _id_AA517194E54F048B.size <= 0) {
    tac_cover_fire_failed();
    return 0;
  }

  _id_1D9FB21B4F3023F3 = _id_AA517194E54F048B[0]["entity"];

  if(isDefined(_id_1D9FB21B4F3023F3) && !tac_cover_can_place_on(_id_1D9FB21B4F3023F3)) {
    tac_cover_fire_failed();
    return 0;
  }

  _id_C72145D539D8D1A1 = _id_AA517194E54F048B[0]["shape_position"];
  _id_2E3BC21C15E7AB6C = _id_AA517194E54F048B[0]["position"];
  spawnpos = _id_C72145D539D8D1A1 - (0, 0, 2.5);
  _id_7A2D144A06A00B97 = tac_cover_get_stuck_to_ent(_id_1D9FB21B4F3023F3);
  _id_786439B54D66D5F9 = 25.025;
  _id_D017352BFFC438F8 = pow(_id_786439B54D66D5F9 * 0.14, 2);
  _id_582FCD34A655EA3F = _id_C72145D539D8D1A1;
  _id_30F5EA3B5BC36327 = distance2dsquared(_id_582FCD34A655EA3F, _id_2E3BC21C15E7AB6C);
  _id_AFB201304F1B9458 = _id_C72145D539D8D1A1 + anglestoright(_id_AC01A11A5F883C59) * 14.3 * 1.75;
  _id_A104B4B86EA439F6 = distance2dsquared(_id_AFB201304F1B9458, _id_2E3BC21C15E7AB6C);
  _id_1E49D3AC619DDAA7 = _id_C72145D539D8D1A1 + anglestoright(_id_AC01A11A5F883C59) * 14.3 * 1.75 * -1;
  _id_265E28DA43DEED4F = distance2dsquared(_id_1E49D3AC619DDAA7, _id_2E3BC21C15E7AB6C);

  if(self _meth_67669BD20BC394F8(_id_1E49D3AC619DDAA7, 32) || self _meth_67669BD20BC394F8(_id_AFB201304F1B9458, 32)) {
    tac_cover_fire_failed();
    return 0;
  }

  _id_23B488CF8754349B = [];
  _id_558AADD2C4F2AF41 = 0;

  if(_id_A104B4B86EA439F6 <= _id_D017352BFFC438F8 && _id_A104B4B86EA439F6 < _id_30F5EA3B5BC36327 && _id_A104B4B86EA439F6 < _id_265E28DA43DEED4F) {
    _id_558AADD2C4F2AF41++;
    _id_23B488CF8754349B = [_id_582FCD34A655EA3F, _id_1E49D3AC619DDAA7];
  } else if(_id_265E28DA43DEED4F <= _id_D017352BFFC438F8 && _id_265E28DA43DEED4F < _id_30F5EA3B5BC36327 && _id_265E28DA43DEED4F < _id_A104B4B86EA439F6) {
    _id_558AADD2C4F2AF41++;
    _id_23B488CF8754349B = [_id_582FCD34A655EA3F, _id_AFB201304F1B9458];
  } else if(_id_30F5EA3B5BC36327 <= _id_D017352BFFC438F8) {
    _id_558AADD2C4F2AF41++;
    _id_23B488CF8754349B = [_id_1E49D3AC619DDAA7, _id_AFB201304F1B9458];
  } else
    _id_23B488CF8754349B = [_id_582FCD34A655EA3F, _id_1E49D3AC619DDAA7, _id_AFB201304F1B9458];

  castdir = (0, 0, -1);
  _id_64B62CB5DC1E7AF6 = 8.5;

  foreach(caststart in _id_23B488CF8754349B) {
    castend = caststart + castdir * _id_64B62CB5DC1E7AF6;
    _id_AA517194E54F048B = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_all", 1);

    if(!isDefined(_id_AA517194E54F048B) || _id_AA517194E54F048B.size <= 0) {
      continue;
    }
    _id_1D9FB21B4F3023F3 = _id_AA517194E54F048B[0]["entity"];

    if(isDefined(_id_1D9FB21B4F3023F3) && !tac_cover_can_place_on(_id_1D9FB21B4F3023F3)) {
      tac_cover_fire_failed();
      return 0;
    }

    _id_558AADD2C4F2AF41++;

    if(_id_558AADD2C4F2AF41 >= 2) {
      break;
    }
  }

  if(_id_558AADD2C4F2AF41 < 2) {
    tac_cover_fire_failed();
    return 0;
  }

  self.taccoverrefund = undefined;
  thread tac_cover_spawn(spawnpos, castangles, _id_7A2D144A06A00B97, issuper, contents);
  scripts\mp\utility\stats::incpersstat("deployableCoverUsed", 1);
  return 1;
}

tac_cover_get_stuck_to_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(_id_1D9FB21B4F3023F3)) {
    if(scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_1D9FB21B4F3023F3))
      return _id_1D9FB21B4F3023F3;
  }

  return undefined;
}

is_train_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == _id_1D9FB21B4F3023F3)
        return 1;
    }
  }

  return 0;
}

_id_1D1BF10A8DA86B91(spawnpos) {
  _id_AE73793772B8710A = spawnpos;
  _id_0140B9FA52F1F56C = 1;
  _id_69A8940023827F01 = 6;
  _id_DB2F3EEE59030225 = 0;

  foreach(_id_BCAFD344E6C26FB4 in level._id_F73654528E070AB4) {
    if(istrue(_id_DB2F3EEE59030225)) {
      continue;
    }
    _id_1DCE2D1958040081 = scripts\engine\utility::distance_2d_squared(_id_BCAFD344E6C26FB4.origin, _id_AE73793772B8710A);
    _id_E11A1DF9E599E505 = squared(_id_BCAFD344E6C26FB4.radius);
    _id_58C847B65FC9C59E = _id_BCAFD344E6C26FB4.origin[2] - _id_69A8940023827F01;
    _id_58A459B65FA1727C = _id_58C847B65FC9C59E + _id_69A8940023827F01 + scripts\engine\utility::ter_op(isDefined(_id_BCAFD344E6C26FB4.height), _id_BCAFD344E6C26FB4.height, 96);
    _id_F66AFF855FC46C7D = _id_AE73793772B8710A[2] >= _id_58C847B65FC9C59E && _id_AE73793772B8710A[2] <= _id_58A459B65FA1727C;

    if(_id_1DCE2D1958040081 < _id_E11A1DF9E599E505 && _id_F66AFF855FC46C7D) {
      if(isDefined(_id_BCAFD344E6C26FB4.offset) && isvector(_id_BCAFD344E6C26FB4.offset)) {
        _id_AE73793772B8710A = _id_AE73793772B8710A + _id_BCAFD344E6C26FB4.offset;
        _id_DB2F3EEE59030225 = 1;
      } else {
        _id_AE73793772B8710A = _id_AE73793772B8710A + (0, 0, -6);
        _id_DB2F3EEE59030225 = 1;
      }

      if(istrue(_id_BCAFD344E6C26FB4._id_36BE730EE498727C))
        _id_0140B9FA52F1F56C = 0;
    }
  }

  return [_id_AE73793772B8710A, _id_0140B9FA52F1F56C];
}

tac_cover_adjust_for_player_space(spawnpos, spawnangles, contents, _id_0140B9FA52F1F56C) {
  _id_AE73793772B8710A = spawnpos;
  _id_0140B9FA52F1F56C = 1;
  _id_DB2F3EEE59030225 = 0;

  if(0) {
    foreach(trigger in level.taccovertriggerblockers) {
      if(istrue(_id_DB2F3EEE59030225)) {
        continue;
      }
      if(ispointinvolume(_id_AE73793772B8710A + (0, 0, 20), trigger)) {
        _id_AE73793772B8710A = _id_AE73793772B8710A + (0, 0, -6);
        _id_DB2F3EEE59030225 = 1;
        break;
      }
    }
  }

  if(1) {
    _id_E62B2BEE781878AB = _id_1D1BF10A8DA86B91(_id_AE73793772B8710A);
    _id_AE73793772B8710A = _id_E62B2BEE781878AB[0];
    _id_0140B9FA52F1F56C = _id_E62B2BEE781878AB[1];
  }

  _id_6B9A738317C3ECB2 = tac_cover_get_free_space(1, _id_AE73793772B8710A, spawnangles, contents, 32);

  if(!isDefined(_id_6B9A738317C3ECB2))
    return [_id_AE73793772B8710A, _id_0140B9FA52F1F56C];

  _id_658407779FBC6828 = tac_cover_get_free_space(0, _id_AE73793772B8710A, spawnangles, contents, 32);

  if(!isDefined(_id_658407779FBC6828))
    return [_id_AE73793772B8710A, _id_0140B9FA52F1F56C];

  _id_9B7C59CBAC03BD88 = min(_id_6B9A738317C3ECB2, 15);
  _id_68FD30DB511477F5 = anglesToForward(spawnangles);
  _id_AE73793772B8710A = _id_AE73793772B8710A + _id_68FD30DB511477F5 * _id_9B7C59CBAC03BD88;
  return [_id_AE73793772B8710A, _id_0140B9FA52F1F56C];
}

tac_cover_get_free_space(_id_187BE19DB6529474, spawnpos, spawnangles, contents, _id_0C6E503A659D5227) {
  _id_C97984F220F9C0B3 = anglestoleft(spawnangles);
  _id_68FD30DB511477F5 = anglesToForward(spawnangles);
  _id_231854EA5561ECD7 = -1 * _id_68FD30DB511477F5;
  _id_1EB4C6F92DD4D311 = undefined;

  if(_id_187BE19DB6529474)
    _id_1EB4C6F92DD4D311 = _id_68FD30DB511477F5 * _id_0C6E503A659D5227;
  else
    _id_1EB4C6F92DD4D311 = _id_231854EA5561ECD7 * _id_0C6E503A659D5227;

  _id_09E9E3E27C514CCD = spawnpos + (0, 0, 48);
  start = _id_09E9E3E27C514CCD;
  end = _id_09E9E3E27C514CCD + _id_1EB4C6F92DD4D311;
  radius = 2.5;
  halfheight = 29.0 + _id_0C6E503A659D5227;
  angles = combineangles(spawnangles, (0, 0, 90));
  contents = contents;
  ignorelist = [self];
  _id_2CFB39849EA742ED = "physicsquery_closest";
  results = physics_capsulecast(start, end, radius, halfheight, angles, contents, ignorelist, _id_2CFB39849EA742ED);
  _id_103240D8E96F1F76 = results.size == 0;

  if(_id_103240D8E96F1F76)
    return undefined;

  _id_A93F5739C1EB2F78 = results[0]["shape_position"];
  dist = distance(_id_A93F5739C1EB2F78, _id_09E9E3E27C514CCD);
  return dist;
}

tac_cover_blocked_by_turret(targetpos) {
  if(isDefined(level.turrets)) {
    foreach(turret in level.turrets) {
      if(!isDefined(turret)) {
        continue;
      }
      distsqrd = distancesquared(turret.origin, targetpos);

      if(6400 >= distsqrd)
        return 1;
    }
  }

  return 0;
}

tac_cover_fire_failed(_id_E2780B690518AE5B) {
  _id_67243B08ECF2E214 = scripts\engine\utility::ter_op(istrue(_id_E2780B690518AE5B), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_67243B08ECF2E214);

  self playsoundtoplayer("iw9_deployable_cover_plant_fail", self);
  _id_DBA0E6107F51D41E();
}

_id_DBA0E6107F51D41E() {
  if(scripts\mp\equipment::hasequipment("equip_tac_cover")) {
    scripts\mp\equipment::incrementequipmentammo("equip_tac_cover", 1);
    thread _id_CD0C066B3516BCB0();
  }
}

_id_CD0C066B3516BCB0() {
  self endon("death_or_disconnect");
  self notify("refreshed_tac_cover_ammo");
  self endon("refreshed_tac_cover_ammo");
  level endon("game_ended");
  self waittill("tac_cover_finalized_spawn");

  if(scripts\mp\equipment::hasequipment("equip_tac_cover"))
    scripts\mp\equipment::decrementequipmentammo("equip_tac_cover", 1);
}

tac_cover_entmanagerdelete() {
  thread tac_cover_delete(0);
}

tac_cover_spawn_with_door(door, _id_3D9512B73BDC1514, issuper, contents) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  _id_71ED5BA14EAAE576 = door _meth_BACD2D0ACDF8559E() + (0, 90, 0);
  _id_807CD8789B963DF2 = anglesToForward(_id_71ED5BA14EAAE576);
  _id_5AC08DEC36D1218B = vectordot(_id_20AF753DED3657E1, _id_807CD8789B963DF2);
  _id_8C12E1B74CF59060 = _id_5AC08DEC36D1218B > 0;
  _id_1B1FF29FE94010F6 = door scriptabledoorangle();
  door _id_3B64EB40368C1450::set("tac_cover_door", "door_frozen", 1);

  if(isDefined(_id_3D9512B73BDC1514))
    _id_3D9512B73BDC1514 _id_3B64EB40368C1450::set("tac_cover_door", "door_frozen", 1);

  _id_279A4854B51C5AF2 = scripts\engine\utility::ter_op(_id_8C12E1B74CF59060, (0, 90, 0), (0, -90, 0));
  _id_4D932CFABB42EEF4 = (0, 0, -1);
  doorpos = door _meth_D90515F5E17DBC6F() + _id_4D932CFABB42EEF4;
  _id_306D8B5B030998E9 = combineangles(door _meth_BACD2D0ACDF8559E(), _id_279A4854B51C5AF2);
  _id_7422D61F3592AC6E = undefined;
  tac_cover_spawn(doorpos, _id_306D8B5B030998E9, _id_7422D61F3592AC6E, issuper, contents, door, _id_3D9512B73BDC1514);
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}

tac_cover_spawn(position, angles, stuckto, issuper, contents, door, _id_3D9512B73BDC1514) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  wait 0.05;
  _id_068D446C128DE07C = tac_cover_adjust_for_player_space(position, angles, contents);
  issuper = istrue(issuper);

  if(!istrue(_id_068D446C128DE07C[1])) {
    tac_cover_fire_failed(0);

    if(issuper)
      scripts\mp\supers::refundsuper();

    return 0;
  }

  position = _id_068D446C128DE07C[0];
  self notify("tac_cover_spawned");
  cover = spawn("script_model", position);
  cover.angles = angles;
  cover.owner = self;
  cover.team = self.team;
  cover.slot = scripts\mp\equipment::findequipmentslot("equip_tac_cover");
  cover.exploding = 1;
  cover.issuper = scripts\engine\utility::ter_op(issuper, 1, undefined);
  cover.superid = level.superglobals.staticsuperdata["super_tac_cover"].id;

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = cover[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      tac_cover_fire_failed();
      cover delete();

      if(issuper)
        scripts\mp\supers::refundsuper();

      return 0;
    }
  }

  cover scripts\cp_mp\ent_manager::registerspawn(2, ::tac_cover_entmanagerdelete);
  cover setentityowner(self);
  cover setotherent(self);
  cover setModel("projectile_deployable_cover_opened_v0");
  cover setscriptablepartstate("allowPing", "on", 0);

  if(isDefined(stuckto)) {
    cover.moving_platform = stuckto;
    data = spawnStruct();
    data.linkparent = cover.moving_platform;
    data.deathoverridecallback = ::tac_cover_on_destroyed_by_mover;
    data.validateaccuratetouching = 1;
    cover thread scripts\mp\movers::handle_moving_platforms(data);
    cover thread tac_cover_destroy_on_unstuck();
  } else if(isDefined(level.wztrain_info)) {
    data = spawnStruct();
    data.deathoverridecallback = ::tac_cover_on_destroyed_by_mover;
    cover thread scripts\mp\movers::handle_moving_platforms(data);
  }

  collision = tac_cover_spawn_collision(cover);
  cover validatecollision(collision, level.taccovercollision);
  cover.collision = collision;
  collision.cover = cover;
  collision.moverdoesnotkill = 1;

  if(isDefined(door)) {
    if(isDefined(door.blockingcover))
      door.blockingcover tac_cover_destroy();

    cover.blockeddoor = door;
    door.blockingcover = cover;
  }

  if(isDefined(_id_3D9512B73BDC1514)) {
    cover.blockeddoubledoor = _id_3D9512B73BDC1514;
    _id_3D9512B73BDC1514.blockingcover = cover;
  }

  scripts\mp\weapons::onequipmentplanted(cover, "equip_tac_cover", ::tac_cover_destroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, cover);

  if(issuper) {
    cover thread tac_cover_destroy_on_disowned(self);
    cover thread tac_cover_destroy_on_timeout();
  }

  cover _id_49197CD063A740EA(::tac_cover_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_A465AA01FA0187D8(cover);
  }

  cover thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(cover);
  thread scripts\mp\weapons::outlineequipmentforowner(cover);
  cover thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_deployed_decoy", 0);
  self notify("tac_cover_finalized_spawn");
}

tac_cover_spawn_internal(cover) {
  cover endon("death");

  if(1 && 0)
    cover tac_cover_set_can_damage(1);

  if(isDefined(cover.blockeddoor))
    cover setscriptablepartstate("effects", "plantStartDoor", 0);
  else
    cover setscriptablepartstate("effects", "plantStart", 0);

  wait(tac_cover_get_deploy_anim_dur());

  if(1 && !0)
    cover tac_cover_set_can_damage(1);

  if(isDefined(cover.blockeddoor))
    cover setscriptablepartstate("effects", "plantEndDoor", 0);
  else
    cover setscriptablepartstate("effects", "plantEnd", 0);
}

tac_cover_spawn_collision(cover) {
  if(!isDefined(level.taccovercollision)) {
    return;
  }
  collision = spawn("script_model", cover.origin);
  collision dontinterpolate();
  collision.angles = cover.angles;
  collision clonebrushmodeltoscriptmodel(level.taccovercollision);
  collision linkTo(cover);
  collision setentityowner(cover);
  collision disconnectPaths();
  _id_6FD5FD4A27BDF9A3 = anglesToForward(cover.angles);
  _id_25E38C6ED49771E3 = cover.origin + _id_6FD5FD4A27BDF9A3 * 25;
  _id_25E38D6ED4977416 = cover.origin + _id_6FD5FD4A27BDF9A3 * -25;
  _func_95C8DFF88843E0FE("tacCover1", _id_25E38C6ED49771E3, _id_25E38D6ED4977416, "traverse_warp_across", 1920);
  _func_95C8DFF88843E0FE("tacCover2", _id_25E38D6ED4977416, _id_25E38C6ED49771E3, "traverse_warp_across", 1920);
  return collision;
}

tac_cover_destroy(immediate, _id_4FAC8B8CE36E09F1, _id_70F6E994A59A36A8) {
  if(!isDefined(_id_70F6E994A59A36A8))
    _id_70F6E994A59A36A8 = 0;

  _id_CBF7BE4F62A0DDB2 = 0;

  if(!istrue(immediate))
    _id_CBF7BE4F62A0DDB2 = 0.2 + tac_cover_get_destroy_anim_dur();

  dmg = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth)
    dmg = self.damagetaken;

  if(!isDefined(dmg))
    dmg = 1250;

  self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_deployed_decoy", 3, int(dmg));
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, int(dmg), istrue(_id_4FAC8B8CE36E09F1));
  thread tac_cover_destroy_internal(_id_CBF7BE4F62A0DDB2, _id_70F6E994A59A36A8);
  thread tac_cover_delete(_id_CBF7BE4F62A0DDB2);
}

tac_cover_destroy_internal(_id_CBF7BE4F62A0DDB2, _id_70F6E994A59A36A8) {
  if(!isDefined(_id_70F6E994A59A36A8))
    _id_70F6E994A59A36A8 = 0;

  if(isDefined(self.blockeddoor)) {
    self.blockeddoor _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tac_cover_door");
    self.blockeddoor.blockingcover = undefined;
  }

  if(isDefined(self.blockeddoubledoor)) {
    self.blockeddoubledoor _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tac_cover_door");
    self.blockeddoubledoor.blockingcover = undefined;
  }

  if(_id_CBF7BE4F62A0DDB2 > 0) {
    if(istrue(_id_70F6E994A59A36A8 >= 1)) {
      if(_id_70F6E994A59A36A8 == 1)
        self setscriptablepartstate("effects", "destroyStartExplosive");
      else
        self setscriptablepartstate("effects", "destroyStartExplosiveBehind");
    } else
      self setscriptablepartstate("effects", "destroyStart");

    wait(tac_cover_get_destroy_anim_dur());
    self setscriptablepartstate("effects", "destroyEnd");
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  destroynavlink("tacCover1");
  destroynavlink("tacCover2");
}

tac_cover_delete(_id_CBF7BE4F62A0DDB2) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  owner = self.owner;

  if(isDefined(owner))
    owner scripts\mp\weapons::removeequip(self);

  if(1) {
    scripts\mp\damage::monitordamageend();
    self thermaldrawdisable();
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }

  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

tac_cover_destroy_on_timeout() {
  self endon("death");
  wait(level.taccover_timeout);
  tac_cover_destroy(undefined, 0, 0);
}

tac_cover_destroy_on_game_end() {
  self endon("death");
  level waittill("game_ended");
  tac_cover_destroy(undefined, 0, 0);
}

tac_cover_destroy_on_unstuck() {
  self endon("death");

  while(isDefined(self getlinkedparent()))
    waitframe();

  tac_cover_destroy(undefined, 0, 0);
}

tac_cover_set_can_damage(_id_E3108E412AFB3811) {
  if(1) {
    if(_id_E3108E412AFB3811) {
      _id_307667D0142F2035 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
      maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 1250, 1000);
      damagefeedback = "hitequip";
      thread scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ::tac_cover_handle_fatal_damage, ::tac_cover_handle_damage, 0);
      self thermaldrawenable();
    } else {
      scripts\mp\damage::monitordamageend();
      self thermaldrawdisable();
    }
  }
}

tac_cover_handle_damage(data) {
  damage = tac_cover_adjust_damage(data);

  if(isDefined(self.owner)) {
    _id_CFABC0D1AB1AB2E9 = max(self.maxhealth - self.damagetaken, 0);
    _id_C738E38FA087114B = int(min(_id_CFABC0D1AB1AB2E9, damage));
    self.owner scripts\mp\supers::combatrecordsupermisc("super_tac_cover", _id_C738E38FA087114B);
    _id_2C06F76B1150EE6C = istrue(level._id_F3BE3F9BAD33BF87) && istrue(self._id_135E1C9614AC0DD0);

    if(data.attacker != self.owner && data.attacker.team != self.owner.team && !_id_2C06F76B1150EE6C) {
      self._id_135E1C9614AC0DD0 = 1;
      self.owner _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "tacCoverShot");
    }
  }

  return damage;
}

tac_cover_adjust_damage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;
  pos = data.point;

  if(objweapon.basename == "thermite_av_mp")
    return 200.0;

  if(scripts\mp\damage::issmallsplashdamage(data.objweapon))
    return 0;

  if(objweapon.basename == "thermite_bolt_mp")
    return 83.3333;

  if(objweapon.basename == "thermite_xmike109_mp")
    return 62.5;

  if(scripts\mp\utility\weapon::isthrowingknife(objweapon.basename) || scripts\mp\utility\weapon::_id_160A992C78BDF589(objweapon.basename))
    return 0;

  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_IMPACT") {
    if(meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade")
      return damage;

    return 333.333;
  }

  if(objweapon.basename == "iw9_dm_crossbow_mp" && meansofdeath != "MOD_MELEE")
    return 0;

  if(meansofdeath == "MOD_CRUSH" && isDefined(data.inflictor) && data.inflictor.classname == "script_vehicle") {
    if(isDefined(attacker) && !scripts\mp\weapons::friendlyfirecheck(self.owner, attacker))
      return damage;
  }

  if(isexplosivedamagemod(data.meansofdeath)) {
    if(objweapon.basename == "semtex_xmike109_mp")
      return 333.333;

    return 700.0;
  }

  damage = scripts\mp\damage::handleapdamage(objweapon, meansofdeath, damage, attacker);
  damage = scripts\mp\damage::handleshotgundamage(objweapon, meansofdeath, damage);
  return damage;
}

tac_cover_handle_fatal_damage(data) {
  attacker = data.attacker;
  _id_70F6E994A59A36A8 = 0;

  if(istrue(data.meansofdeath == "MOD_EXPLOSIVE")) {
    _id_70F6E994A59A36A8 = 1;
    _id_07C5C3C06D620979 = anglesToForward(self.angles);
    _id_07C5C3C06D620979 = vectorNormalize(_id_07C5C3C06D620979);
    _id_6E86A25A741E3A50 = vectortoangles(self.origin - data.point);
    _id_6E86A25A741E3A50 = anglesToForward(_id_6E86A25A741E3A50);
    _id_6E86A25A741E3A50 = vectorNormalize(_id_6E86A25A741E3A50);
    _id_EB513A01B5C89A61 = vectordot(_id_07C5C3C06D620979, _id_6E86A25A741E3A50);

    if(_id_EB513A01B5C89A61 >= 0)
      _id_70F6E994A59A36A8 = 2;
  }

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_1DADEF4EB4500029");
  }

  thread tac_cover_destroy(undefined, 1, _id_70F6E994A59A36A8);
}

tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    slot = scripts\mp\equipment::findequipmentslot("equip_tac_cover");

    if(slot == "primary")
      _id_3B64EB40368C1450::set("tac_cover_deploy", "equipment_primary", 0);
    else
      _id_3B64EB40368C1450::set("tac_cover_deploy", "equipment_secondary", 0);

    _id_3B64EB40368C1450::set("tac_cover_deploy", "usability", 0);
    _id_3B64EB40368C1450::set("tac_cover_deploy", "gesture", 0);
    self.taccoverfrozecontrols = slot;
  }
}

tac_cover_deploy_unfreeze_controls() {
  if(isDefined(self.taccoverfrozecontrols)) {
    slot = self.taccoverfrozecontrols;
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tac_cover_deploy");
    self.taccoverfrozecontrols = undefined;
  }
}

tac_cover_ignore_list(player) {
  ignorelist = [player];
  scripts\cp_mp\utility\game_utility::_id_9ED62E98A39D59EB();

  foreach(array in level._id_E7E46E0E18411A5B scripts\engine\utility::_id_0DF633F460888A47(player.origin)) {
    foreach(projectile in array) {
      if(!isDefined(projectile)) {
        continue;
      }
      _id_A81AFC6275977E88 = isDefined(projectile.owner) && projectile.owner == player;
      _id_79D78C01B023B7F2 = isDefined(projectile.equipmentref) && projectile.equipmentref == "equip_tac_cover";
      _id_873E2074C47E6314 = isDefined(projectile.equipmentref) && projectile.equipmentref == "equip_ammo_box";

      if(!_id_A81AFC6275977E88 && (_id_79D78C01B023B7F2 || _id_873E2074C47E6314)) {
        continue;
      }
      ignorelist[ignorelist.size] = projectile;
    }
  }

  return ignorelist;
}

tac_cover_can_place_on(ent) {
  if(isPlayer(ent))
    return 0;

  if(ent getnonstick())
    return 0;

  if(istrue(ent.mountmantlemodel))
    return 0;

  if(isDefined(ent.cover) && isDefined(ent.cover.equipmentref) && ent.cover.equipmentref == "equip_tac_cover")
    return 0;

  if(ent.classname == "misc_turret")
    return 0;

  if(ent.classname == "script_vehicle")
    return 0;

  return 1;
}

#using_animtree("scriptables");

tac_cover_get_deploy_anim_dur() {
  return getanimlength(%wm_spawn_2h_deployable_cover_fire);
}

tac_cover_get_destroy_anim_dur() {
  return 0;
}

tac_cover_on_fired_super() {
  return tac_cover_on_fired(undefined, undefined, undefined, 1);
}

tac_cover_on_take_super() {
  tac_cover_on_take(undefined, undefined, 1);
}

tac_cover_destroy_on_disowned(owner) {
  self endon("death");
  owner endon("tac_cover_taken");
  owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  thread tac_cover_destroy(undefined, 0, 0);
}

tac_cover_on_destroyed_by_mover(data) {
  tac_cover_destroy(undefined, 0, 0);
}

_id_F6491690FE2FA94E(_id_8F6695FBD2CEE6A3, _id_F8BD30B866395824, _id_089AA1DCAD7A5096, _id_9C691B5325DA706E, _id_36BE730EE498727C) {
  if(!isDefined(level._id_F73654528E070AB4))
    level._id_F73654528E070AB4 = [];

  _id_4D453C5A0F78E5F3 = spawnStruct();
  _id_4D453C5A0F78E5F3.targetname = "dcover_blocker_struct";
  _id_4D453C5A0F78E5F3.origin = _id_8F6695FBD2CEE6A3;
  _id_4D453C5A0F78E5F3.radius = _id_F8BD30B866395824;
  _id_4D453C5A0F78E5F3.height = _id_089AA1DCAD7A5096;
  _id_4D453C5A0F78E5F3.offset = (0, 0, _id_9C691B5325DA706E);
  _id_4D453C5A0F78E5F3._id_36BE730EE498727C = _id_36BE730EE498727C;
  level._id_F73654528E070AB4[level._id_F73654528E070AB4.size] = _id_4D453C5A0F78E5F3;
  return _id_4D453C5A0F78E5F3;
}

_id_8126F259BBF1A7ED(_id_8F6695FBD2CEE6A3) {
  _id_4D453C5A0F78E5F3 = _id_F6491690FE2FA94E(_id_8F6695FBD2CEE6A3, 80, 96, -6, undefined);
  return _id_4D453C5A0F78E5F3;
}

_id_65FDE24CE2BC91E9(_id_8F6695FBD2CEE6A3) {
  _id_4D453C5A0F78E5F3 = _id_F6491690FE2FA94E(_id_8F6695FBD2CEE6A3, 140, 96, -6, undefined);
  return _id_4D453C5A0F78E5F3;
}

_id_B8FFEACF84A9D34E(_id_5C4E2A948C4617A4) {
  if(!isDefined(_id_5C4E2A948C4617A4.offset))
    _id_5C4E2A948C4617A4.offset = -6;
}

_id_C5D3D6E10BD8C8AB(_id_A61748234DA405DB, _id_CAE297D0690CC359) {
  switch (_id_CAE297D0690CC359) {
    case 0:
      _id_8126F259BBF1A7ED(_id_A61748234DA405DB);
      break;
    case 1:
      _id_65FDE24CE2BC91E9(_id_A61748234DA405DB);
      break;
    default:
      break;
  }
}

_id_85555E609B23B2BE(_id_CAE297D0690CC359) {
  _id_130B136C0F62B47E = undefined;

  switch (_id_CAE297D0690CC359) {
    case 0:
      _id_130B136C0F62B47E = 80;
      break;
    case 1:
      _id_130B136C0F62B47E = 140;
      break;
    default:
      break;
  }

  return _id_130B136C0F62B47E;
}

_id_F41F835B1AB9DBD8(_id_8F6695FBD2CEE6A3, _id_F8BD30B866395824, _id_089AA1DCAD7A5096, _id_9C691B5325DA706E, _id_36BE730EE498727C) {
  if(!isDefined(_id_089AA1DCAD7A5096))
    _id_089AA1DCAD7A5096 = 96;

  if(!isDefined(_id_9C691B5325DA706E))
    _id_9C691B5325DA706E = -6;

  _id_F6491690FE2FA94E(_id_8F6695FBD2CEE6A3, _id_F8BD30B866395824, _id_089AA1DCAD7A5096, _id_9C691B5325DA706E, _id_36BE730EE498727C);
}

_id_9461775D71E495CF(targetpos) {
  if(!1 || !isDefined(level._id_B6A3186C09D2DD34))
    return 0;

  foreach(_id_351EAEE3269EE1D8 in level._id_B6A3186C09D2DD34) {
    if(ispointinvolume(targetpos + (0, 0, 8), _id_351EAEE3269EE1D8))
      return 1;
  }

  return 0;
}

_id_AC29E794C919FE03(targetpos) {
  if(!1 || !isDefined(level._id_057B13482577DD10))
    return 0;

  foreach(_id_B92D911C350C9026 in level._id_057B13482577DD10) {
    if(ispointinvolume(targetpos + (0, 0, 8), _id_B92D911C350C9026))
      return 1;
  }

  return 0;
}

_id_6CC8838979F47B9F(targetpos) {
  if(!1 || !isDefined(level._id_CA0420748E3190ED))
    return 0;

  foreach(_id_5A2CB93C3C5423E5 in level._id_CA0420748E3190ED) {
    _id_C114ECFA39E69379 = squared(32);

    if(isDefined(_id_5A2CB93C3C5423E5.radius))
      _id_C114ECFA39E69379 = squared(_id_5A2CB93C3C5423E5.radius);

    _id_F17759894781F5EB = _id_5A2CB93C3C5423E5.origin[2] - 8;
    _id_F1536F894759AB95 = _id_F17759894781F5EB + scripts\engine\utility::ter_op(isDefined(_id_5A2CB93C3C5423E5.height), _id_5A2CB93C3C5423E5.height, 96);
    _id_F66AFF855FC46C7D = targetpos[2] >= _id_F17759894781F5EB && targetpos[2] <= _id_F1536F894759AB95;

    if(scripts\engine\utility::distance_2d_squared(_id_5A2CB93C3C5423E5.origin, targetpos) < _id_C114ECFA39E69379 && _id_F66AFF855FC46C7D)
      return 1;
  }

  return 0;
}

_id_D147E0986E29DD8D(org, _id_CB920E03144E9344, height) {
  if(!1)
    return 0;

  if(!isDefined(level._id_CA0420748E3190ED))
    level._id_CA0420748E3190ED = [];

  _id_5A2CB93C3C5423E5 = spawnStruct();
  _id_5A2CB93C3C5423E5.targetname = "dcover_invalid_struct";
  _id_5A2CB93C3C5423E5.origin = org;
  _id_5A2CB93C3C5423E5.radius = _id_CB920E03144E9344;
  _id_5A2CB93C3C5423E5.height = height;
  level._id_CA0420748E3190ED[level._id_CA0420748E3190ED.size] = _id_5A2CB93C3C5423E5;
  return _id_5A2CB93C3C5423E5;
}