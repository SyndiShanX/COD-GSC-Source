/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\powers\cp_tactical_cover.gsc
***************************************************/

tac_cover_init() {
  if(!isDefined(level.taccovercollision)) {
    _id_D805A86A5FE7AAF2 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(_id_D805A86A5FE7AAF2))
      level.taccovercollision = _id_D805A86A5FE7AAF2[0];
  }

  level.taccovertriggerblockers = getEntArray("dcover_blocker", "targetname");
  level.taccover_timeout = getdvarfloat("dvar_FDEB104EC6908DF8", 150.0);
}

tac_cover_on_give(ref, slot) {
  self notify("tac_cover_given");
}

tac_cover_on_take(ref, slot, issuper) {
  self notify("tac_cover_taken");
  self.taccoverrefund = undefined;
}

tac_cover_used(grenade) {
  waitframe();

  if(isDefined(grenade))
    grenade delete();
}

tac_cover_on_fired(ref, slot, objweapon, issuper) {
  if(self _meth_E40102956C887F7C()) {
    tac_cover_fire_failed(0);
    return 0;
  }

  self.taccoverrefund = 1;
  contents = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle"]);
  ignorelist = tac_cover_ignore_list(self);
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

  contents = scripts\engine\trace::_id_2D88CB1F022D0989();
  radius = getdvarfloat("dvar_9FA5C4D28EC05069", 40.0);
  traceresults = scripts\engine\trace::sphere_trace_get_all_results(targetpos, targetpos + (0, 0, 10), radius, level.players, contents, 1);

  foreach(trace in traceresults) {
    if(!isDefined(trace["surfaceflags"])) {
      continue;
    }
    if(trace["surfaceflags"] & 8)
      return 0;
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
        tac_cover_fire_failed(1);
        return 0;
      }

      _id_2464EDC7C410E680.isblocked = 1;
      self.taccoverrefund = undefined;
      thread tac_cover_spawn_with_door(_id_2464EDC7C410E680, _id_3D9512B73BDC1514, issuper, contents);
      return 1;
    } else if(_id_445CCDA2FA82B65E < 6400) {
      tac_cover_fire_failed(1);
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
  return 1;
}

tac_cover_get_stuck_to_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(_id_1D9FB21B4F3023F3)) {
    if(is_train_ent(_id_1D9FB21B4F3023F3))
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

tac_cover_adjust_for_player_space(spawnpos, spawnangles, contents) {
  _id_6B9A738317C3ECB2 = tac_cover_get_free_space(1, spawnpos, spawnangles, contents, 32);

  if(!isDefined(_id_6B9A738317C3ECB2))
    return spawnpos;

  _id_658407779FBC6828 = tac_cover_get_free_space(0, spawnpos, spawnangles, contents, 32);

  if(!isDefined(_id_658407779FBC6828))
    return spawnpos;

  _id_9B7C59CBAC03BD88 = min(_id_6B9A738317C3ECB2, 15);
  _id_68FD30DB511477F5 = anglesToForward(spawnangles);
  _id_AE73793772B8710A = spawnpos + _id_68FD30DB511477F5 * _id_9B7C59CBAC03BD88;

  foreach(trigger in level.taccovertriggerblockers) {
    if(ispointinvolume(_id_AE73793772B8710A + (0, 0, 20), trigger)) {
      _id_AE73793772B8710A = _id_AE73793772B8710A + (0, 0, -6);
      break;
    }
  }

  return _id_AE73793772B8710A;
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

  if(_id_7EF95BBA57DC4B82::hasequipment("equip_tac_cover"))
    _id_7EF95BBA57DC4B82::incrementequipmentammo("equip_tac_cover", 1);
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

tac_cover_spawn(position, angles, stuckto, issuper, contents, door, _id_3D9512B73BDC1514) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  wait 0.05;
  position = tac_cover_adjust_for_player_space(position, angles, contents);
  self notify("tac_cover_spawned");
  issuper = istrue(issuper);
  cover = spawn("script_model", position);
  cover.angles = angles;
  cover.owner = self;
  cover.team = self.team;
  cover.slot = _id_7EF95BBA57DC4B82::findequipmentslot("equip_tac_cover");
  cover.exploding = 1;
  cover.issuper = scripts\engine\utility::ter_op(issuper, 1, undefined);
  cover.superid = level.superglobals.staticsuperdata["super_tac_cover"].id;
  cover scripts\cp_mp\ent_manager::registerspawn(2, ::tac_cover_entmanagerdelete);
  cover scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  cover setentityowner(self);
  cover setotherent(self);
  cover setModel("projectile_deployable_cover_opened_v0");

  if(isDefined(stuckto)) {
    cover.moving_platform = stuckto;
    data = spawnStruct();
    data.linkparent = cover.moving_platform;
    data.deathoverridecallback = ::tac_cover_on_destroyed_by_mover;
    data.validateaccuratetouching = 1;
    cover thread scripts\cp\cp_movers::handle_moving_platforms(data);
    cover thread tac_cover_destroy_on_unstuck();
  } else if(isDefined(level.wztrain_info)) {
    data = spawnStruct();
    data.deathoverridecallback = ::tac_cover_on_destroyed_by_mover;
    cover thread scripts\cp\cp_movers::handle_moving_platforms(data);
  }

  collision = tac_cover_spawn_collision(cover);

  if(isDefined(collision)) {
    cover validatecollision(collision, level.taccovercollision);
    cover.collision = collision;
    collision.cover = cover;
    collision.moverdoesnotkill = 1;
  }

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

  _id_74502A9E0EF1F19C::onequipmentplanted(cover, "equip_tac_cover", ::tac_cover_destroy);
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, cover);

  if(issuper) {
    cover thread tac_cover_destroy_on_disowned(self);
    cover thread tac_cover_destroy_on_timeout();
  }

  cover thread tac_cover_destroy_on_game_end();
  thread tac_cover_spawn_internal(cover);
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
  return collision;
}

tac_cover_destroy(immediate, _id_4FAC8B8CE36E09F1) {
  _id_CBF7BE4F62A0DDB2 = 0;

  if(!istrue(immediate))
    _id_CBF7BE4F62A0DDB2 = 0.2 + tac_cover_get_destroy_anim_dur();

  dmg = self.maxhealth;

  if(isDefined(self.damagetaken) && self.damagetaken < self.maxhealth)
    dmg = self.damagetaken;

  if(!isDefined(dmg))
    dmg = 1250;

  self.owner scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB("super_tac_cover", int(dmg));
  thread tac_cover_destroy_internal(_id_CBF7BE4F62A0DDB2);
  thread tac_cover_delete(_id_CBF7BE4F62A0DDB2);
}

tac_cover_destroy_internal(_id_CBF7BE4F62A0DDB2) {
  if(isDefined(self.blockeddoor)) {
    self.blockeddoor _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tac_cover_door");
    self.blockeddoor.blockingcover = undefined;
  }

  if(isDefined(self.blockeddoubledoor)) {
    self.blockeddoubledoor _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tac_cover_door");
    self.blockeddoubledoor.blockingcover = undefined;
  }

  if(_id_CBF7BE4F62A0DDB2 > 0) {
    self setscriptablepartstate("effects", "destroyStart");
    wait(tac_cover_get_destroy_anim_dur());
    self setscriptablepartstate("effects", "destroyEnd");
  }

  if(isDefined(self.collision)) {
    self.collision connectpaths();
    self.collision delete();
  }
}

tac_cover_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  owner = self.owner;

  if(1) {
    _id_74502A9E0EF1F19C::monitordamageend();
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
  tac_cover_destroy(undefined, 0);
}

tac_cover_destroy_on_game_end() {
  self endon("death");
  level waittill("game_ended");
  tac_cover_destroy(undefined, 0);
}

tac_cover_destroy_on_unstuck() {
  self endon("death");

  while(isDefined(self getlinkedparent()))
    waitframe();

  tac_cover_destroy(undefined, 0);
}

tac_cover_set_can_damage(_id_E3108E412AFB3811) {
  if(1) {
    if(_id_E3108E412AFB3811) {
      _id_307667D0142F2035 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");
      maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 1250, 1000);
      damagefeedback = "hitequip";
      thread _id_74502A9E0EF1F19C::monitordamage(maxhealth, damagefeedback, ::tac_cover_handle_fatal_damage, ::tac_cover_handle_damage, 0);
      self thermaldrawenable();
    } else {
      _id_74502A9E0EF1F19C::monitordamageend();
      self thermaldrawdisable();
    }
  }
}

tac_cover_handle_damage(data) {
  damage = tac_cover_adjust_damage(data);

  if(isDefined(self.owner)) {
    _id_CFABC0D1AB1AB2E9 = max(self.maxhealth - self.damagetaken, 0);
    _id_C738E38FA087114B = int(min(_id_CFABC0D1AB1AB2E9, damage));
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

  if(_id_74502A9E0EF1F19C::issmallsplashdamage(data.objweapon))
    return 0;

  if(objweapon.basename == "thermite_bolt_mp")
    return 83.3333;

  if(objweapon.basename == "thermite_xmike109_mp")
    return 62.5;

  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_IMPACT") {
    if(meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade")
      return damage;

    return 333.333;
  }

  if(scripts\cp\cp_weapons::isthrowingknife(objweapon.basename))
    return 0;

  if(objweapon.basename == "iw9_dm_crossbow_mp" && meansofdeath != "MOD_MELEE")
    return 0;

  if(meansofdeath == "MOD_CRUSH" && isDefined(data.inflictor) && data.inflictor.classname == "script_vehicle") {
    if(isDefined(attacker) && !_id_25845ACA699D038D::friendlyfirecheck(self.owner, attacker))
      return damage;
  }

  if(isexplosivedamagemod(data.meansofdeath)) {
    if(objweapon.basename == "semtex_xmike109_mp")
      return 333.333;

    return 700.0;
  }

  damage = _id_25845ACA699D038D::handleapdamage(objweapon, meansofdeath, damage, attacker);
  damage = _id_25845ACA699D038D::handleshotgundamage(objweapon, meansofdeath, damage);
  return damage;
}

tac_cover_give_new() {
  if(self hasweapon("tac_cover_mp"))
    self takeweapon("tac_cover_mp");

  _id_97ADA5E8BEBE7579 = scripts\cp\loot_system::get_empty_munition_slot(self);

  if(isDefined(_id_97ADA5E8BEBE7579))
    _id_644C18834356D9DC::give_munition_to_slot("deployable_cover", _id_97ADA5E8BEBE7579);
}

tac_cover_handle_fatal_damage(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\cp\cp_player_battlechatter::equipmentdestroyed(self);
  }

  thread tac_cover_destroy(undefined, 1);
}

tac_cover_deploy_freeze_controls() {
  if(!isDefined(self.taccoverfrozecontrols)) {
    slot = _id_7EF95BBA57DC4B82::findequipmentslot("equip_tac_cover");

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

  if(isDefined(level.grenades)) {
    foreach(grenade in level.grenades) {
      if(isDefined(grenade))
        ignorelist[ignorelist.size] = grenade;
    }
  }

  if(isDefined(level.missiles)) {
    foreach(missile in level.missiles) {
      if(isDefined(missile))
        ignorelist[ignorelist.size] = missile;
    }
  }

  if(isDefined(level.mines)) {
    foreach(mine in level.mines) {
      if(!isDefined(mine)) {
        continue;
      }
      _id_A81AFC6275977E88 = isDefined(mine.owner) && mine.owner == player;
      _id_79D78C01B023B7F2 = isDefined(mine.equipmentref) && mine.equipmentref == "equip_tac_cover";
      _id_873E2074C47E6314 = isDefined(mine.equipmentref) && mine.equipmentref == "equip_ammo_box";

      if(!_id_A81AFC6275977E88 && (_id_79D78C01B023B7F2 || _id_873E2074C47E6314)) {
        continue;
      }
      ignorelist[ignorelist.size] = mine;

      if(isDefined(mine.collision))
        ignorelist[ignorelist.size] = mine.collision;
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
  thread tac_cover_destroy(undefined, 0);
}

tac_cover_on_destroyed_by_mover(data) {
  tac_cover_destroy(undefined, 0);
}