/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_30986513d6d6877a.gsc
***********************************************/

_id_C4D89B1AABFD3516() {
  if(!_id_2C3C990BA58FA6F5::_id_364F4C40FF756CAC()) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("altar", ::_id_5A0F0410C3C4326B);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("portal", ::_id_B587A630BCEEE5AD);
  level._id_49D407295B31E357 = spawnStruct();
  level._id_49D407295B31E357._id_DBB3B36AD3319767 = _id_2C3C990BA58FA6F5::_id_278586640BAA700D();
  level._id_49D407295B31E357._id_3A8084513F82C783 = getdvarint("dvar_C51A57613D78F453", 1);
  level._id_49D407295B31E357._id_0019AD2B18CE20B7 = getdvarint("dvar_504B0D37D9DA50CC", 0);
  level._id_49D407295B31E357._id_83DA016BAFBAFEF6 = _id_2C3C990BA58FA6F5::_id_F35DBBDFC3DDDBA5();
  level._id_49D407295B31E357._id_1423E75B13B3A38D = getdvarint("dvar_FF2AB8573900FE9D", 5);
  level._id_49D407295B31E357._id_F6694E38D5991F7C = getdvarint("dvar_A786172272B5EC6F", 5);
  level._id_49D407295B31E357._id_BBF34CA272F839FB = 0;
  level._id_49D407295B31E357._id_8D11120EDFF5B400 = getdvarint("dvar_7677D5C870332C77", 120);
  level._id_49D407295B31E357._id_885AD6B3C9D47759 = getdvarint("dvar_225CD7990AEDC2F5", 1);
  level._id_49D407295B31E357.capturetime = getdvarint("dvar_ADEFD3CF436C3350", 25);
  level._id_49D407295B31E357._id_029A79D378C70E0B = getdvarint("dvar_B4BC18A31E7EB2A7", 800);
  level._id_49D407295B31E357._id_3C1656D0DE196C00 = getdvarint("dvar_D6E1E7359D4F37E8", 4);
  level._id_49D407295B31E357._id_3BF36CD0DDF354AA = getdvarint("dvar_D704DD359D7569A2", 5);
  level._id_49D407295B31E357._id_01E2B29129476352 = getdvarint("dvar_8A5C12E2CFA6CB8A", 24000);
  level._id_49D407295B31E357._id_96DC0BDED5D12406 = level._id_49D407295B31E357._id_01E2B29129476352 * level._id_49D407295B31E357._id_01E2B29129476352;
  level._id_49D407295B31E357._id_FCD0365F5A9FB237 = [];
  level._id_49D407295B31E357._id_D8BD03B318CB8767 = _id_59EBFABF2131C30F::_id_91182B18FE6CD5BE(1);
  level._id_49D407295B31E357._id_08CBC8B62D3634B5 = _id_59EBFABF2131C30F::_id_91182B18FE6CD5BE;

  if(isDefined(getdvarint("dvar_DC95D37637846BE1")))
    level._id_49D407295B31E357._id_8D11120EDFF5B400 = getdvarint("dvar_DC95D37637846BE1", 120);

  if(level._id_49D407295B31E357._id_1423E75B13B3A38D < level._id_49D407295B31E357._id_F6694E38D5991F7C)
    level._id_49D407295B31E357._id_F6694E38D5991F7C = level._id_49D407295B31E357._id_1423E75B13B3A38D;

  if(!level._id_49D407295B31E357._id_DBB3B36AD3319767) {
    return;
  }
  while(!isDefined(level.struct_class_names) || !isDefined(level._id_41670C1C65F3D3CF) || _func_9A83377C98BCE82A("everybody") <= 0)
    waitframe();

  _id_FA3821AF248E5FBA = scripts\engine\utility::getStructArray("dmz_butcher_ritual", "script_noteworthy");
  level._id_49D407295B31E357._id_0AC307D3DCEAF746 = _id_FA3821AF248E5FBA[0];
  _id_85764DE6C67B8C45 = 0;
  _id_75BC94BA7FE93DC0 = _id_FA3821AF248E5FBA[0];
  gametype = scripts\mp\utility\game::getgametype();
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(gametype == "br" && _id_FAF0D2FAC3F47583 != "dmz")
    _id_85764DE6C67B8C45 = 99999999999;

  foreach(location in _id_FA3821AF248E5FBA) {
    if(gametype == "br" && _id_FAF0D2FAC3F47583 != "dmz") {
      _id_67626439F7728DFA = -1;

      if(isDefined(level.br_circle.br_finalcircleoverride))
        _id_67626439F7728DFA = distance2d(location.origin, level.br_circle.br_finalcircleoverride);
      else if(isDefined(level.br_circle))
        _id_67626439F7728DFA = distance2d(location.origin, level.br_level.br_circlecenters[level.br_level.br_circlecenters.size - 1]);

      if(_id_85764DE6C67B8C45 > _id_67626439F7728DFA) {
        _id_85764DE6C67B8C45 = _id_67626439F7728DFA;
        _id_75BC94BA7FE93DC0 = level._id_49D407295B31E357._id_0AC307D3DCEAF746;
        level._id_49D407295B31E357._id_0AC307D3DCEAF746 = location;
      }

      continue;
    }

    if(_id_FAF0D2FAC3F47583 == "dmz") {
      if(isDefined(location) && isDefined(level) && isDefined(level._id_33A2175A9A4306BC)) {
        _id_67626439F7728DFA = distance2d(location.origin, level._id_33A2175A9A4306BC.origin);

        if(_id_85764DE6C67B8C45 < _id_67626439F7728DFA) {
          _id_85764DE6C67B8C45 = _id_67626439F7728DFA;
          _id_75BC94BA7FE93DC0 = level._id_49D407295B31E357._id_0AC307D3DCEAF746;
          level._id_49D407295B31E357._id_0AC307D3DCEAF746 = location;
        }
      }
    }
  }

  _id_F15E457EF3358A2A = randomintrange(0, 5);

  if(_id_F15E457EF3358A2A == 0)
    level._id_49D407295B31E357._id_0AC307D3DCEAF746 = _id_75BC94BA7FE93DC0;

  _id_DAD6BA87091AE1B1 = [];
  _id_9C11120A8355C30D = scripts\engine\utility::getStructArray(level._id_49D407295B31E357._id_0AC307D3DCEAF746.target, "targetname");

  foreach(child in _id_9C11120A8355C30D) {
    if(!isDefined(_id_DAD6BA87091AE1B1[child.script_noteworthy]))
      _id_DAD6BA87091AE1B1[child.script_noteworthy] = [];

    _id_DAD6BA87091AE1B1[child.script_noteworthy][_id_DAD6BA87091AE1B1[child.script_noteworthy].size] = child;
  }

  level._id_49D407295B31E357._id_7B55E2C7824BB589 = _id_DAD6BA87091AE1B1["dmz_altar_portal"][0];
  level._id_A91B93E67D4BB9E0 = [];
  level._id_49D407295B31E357._id_9EE7EA6A1B6CFCE2 = scripts\engine\utility::getStructArray(level._id_49D407295B31E357._id_7B55E2C7824BB589.target, "targetname");
  level._id_49D407295B31E357._id_35148157B0973EFB = scripts\engine\utility::getStructArray(level._id_49D407295B31E357._id_9EE7EA6A1B6CFCE2[0].target, "targetname");

  if(scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getsubgametype() == "zxp" || scripts\mp\utility\game::getsubgametype() == "resurgence") {
    level thread _id_9BB2386291FF605D();
    level waittill("br_prematchEnded");
  }

  _id_D8C035AC1DB8C25A();
  level._id_49D407295B31E357._id_7A87BCC888496D30 = _id_DAD6BA87091AE1B1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_49D407295B31E357._id_1423E75B13B3A38D; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_DAD6BA87091AE1B1["dmz_altar"][_id_AC0E594AC96AA3A8])) {
      break;
    }

    _id_4C71BC86CFB0FCC1(_id_DAD6BA87091AE1B1["dmz_altar"][_id_AC0E594AC96AA3A8]);
  }

  scripts\mp\teamrevive::_id_EA0F473582299981("butcher_arena", ::_id_9605A1D63F9B580B);
}

_id_D8C035AC1DB8C25A() {
  if(!isDefined(level._id_49D407295B31E357._id_7B55E2C7824BB589)) {
    return;
  }
  level._id_49D407295B31E357._id_81AB4319C71FA29F = spawnscriptable("dmz_altar_portal", level._id_49D407295B31E357._id_7B55E2C7824BB589.origin, level._id_49D407295B31E357._id_7B55E2C7824BB589.angles);
  level._id_49D407295B31E357._id_81AB4319C71FA29F.curorigin = level._id_49D407295B31E357._id_81AB4319C71FA29F.origin;
  level._id_49D407295B31E357._id_81AB4319C71FA29F.offset3d = (0, 0, 15);
  level._id_49D407295B31E357._id_81AB4319C71FA29F scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  level._id_49D407295B31E357._id_81AB4319C71FA29F.objid = level._id_49D407295B31E357._id_81AB4319C71FA29F.objidnum;
  level._id_49D407295B31E357._id_81AB4319C71FA29F thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(1500);
  objid = level._id_49D407295B31E357._id_81AB4319C71FA29F.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "hud_icon_minimap_boss_butcher_lilith_altar");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, level._id_49D407295B31E357._id_7B55E2C7824BB589.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
  scripts\mp\objidpoolmanager::_id_C3C6BFF089DFDD34(objid, "icon_medium");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid, "MP_BR_INGAME/ALTAR_DEFAULT");
  objective_setlabel(objid, &"MP_BR_INGAME/ALTAR_DEFAULT");
  _id_1E8BC703FDC8620D = level._id_49D407295B31E357._id_9EE7EA6A1B6CFCE2;
  _id_35148157B0973EFB = level._id_49D407295B31E357._id_35148157B0973EFB;
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9 = spawnscriptable("dmz_altar_portal", _id_35148157B0973EFB[0].origin, _id_35148157B0973EFB[0].angles);
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9.curorigin = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9.origin;
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9.offset3d = (0, 0, 15);
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9 scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E = level._id_49D407295B31E357._id_81AB4319C71FA29F;

  if(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9 getscriptableparthasstate("portal", "open_return"))
    level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9 setscriptablepartstate("portal", "open_return");

  if(level._id_49D407295B31E357._id_0019AD2B18CE20B7)
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
  else
    scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);

  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
  level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E = _id_1E8BC703FDC8620D[0];
  level._id_49D407295B31E357._id_81AB4319C71FA29F thread _id_05EE12A782DA0D41();
}

_id_4C71BC86CFB0FCC1(node, _id_CAA1515C4AD207EB) {
  if(!isDefined(node)) {
    return;
  }
  _id_E5776B57DAD53EA9 = "dmz_altar";
  _id_6EB2A337E2363ED3 = spawn("script_model", node.origin);
  _id_6EB2A337E2363ED3.angles = node.angles;
  _id_6EB2A337E2363ED3 setModel("art_lilith_altar_scriptable");
  _id_6EB2A337E2363ED3 forcenetfieldhighlod(1);
  _id_6EB2A337E2363ED3.curorigin = _id_6EB2A337E2363ED3.origin;
  _id_6EB2A337E2363ED3.offset3d = (0, 0, 15);
  _id_6EB2A337E2363ED3 scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = _id_6EB2A337E2363ED3.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "hud_icon_minimap_boss_butcher_lilith_altar");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, _id_6EB2A337E2363ED3.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);

  if(level._id_49D407295B31E357._id_3A8084513F82C783)
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
  else
    scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);

  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
  _id_6EB2A337E2363ED3.node = node;
  node._id_6EB2A337E2363ED3 = _id_6EB2A337E2363ED3;

  if(!isDefined(level._id_49D407295B31E357._id_CADE8B1F6616C692)) {
    level._id_49D407295B31E357._id_CADE8B1F6616C692 = _id_6EB2A337E2363ED3;
    _id_6EB2A337E2363ED3 setscriptablepartstate("skull", "on");
  }

  _id_6EB2A337E2363ED3 setscriptablepartstate("altar", "usable_not_open");
  _id_6EB2A337E2363ED3.trigger = spawn("trigger_radius", _id_6EB2A337E2363ED3.node.origin, 0, int(level._id_49D407295B31E357._id_029A79D378C70E0B), int(level._id_49D407295B31E357._id_029A79D378C70E0B));
  _id_6EB2A337E2363ED3.trigger scripts\engine\utility::trigger_off();
  _id_6EB2A337E2363ED3.capturetime = level._id_49D407295B31E357.capturetime;
  _id_6EB2A337E2363ED3._id_4E29111F80D17365 = [];

  if(level._id_49D407295B31E357._id_83DA016BAFBAFEF6)
    _id_6EB2A337E2363ED3 _id_15EBD4304B177755(1);

  _id_6EB2A337E2363ED3 thread _id_5B665F6281173B25(_id_6EB2A337E2363ED3.trigger, level._id_49D407295B31E357._id_029A79D378C70E0B);
  _id_6EB2A337E2363ED3._id_6AFF45107E415FE9 = 1200;
  _id_6EB2A337E2363ED3._id_2C0CDD0259CB8480 = [];
  _id_6EB2A337E2363ED3 thread _id_C2021066FF482332();
  level._id_A91B93E67D4BB9E0[level._id_A91B93E67D4BB9E0.size] = _id_6EB2A337E2363ED3;
  return _id_6EB2A337E2363ED3;
}

_id_8C1EC559BAE28237(_id_FABF84450735DD93) {
  if(istrue(self._id_7BE8B486A10B3DE8)) {
    return;
  }
  self notify("altar_unlocked");
  self._id_7BE8B486A10B3DE8 = 1;
}

_id_9BB2386291FF605D() {
  level endon("game_ended");
  level endon("disconnect");
  gametype = scripts\mp\utility\game::getgametype();
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(scripts\mp\utility\game::getsubgametype() != "zxp" && scripts\mp\utility\game::getsubgametype() != "resurgence")
    level waittill("gulag_closed");
  else if(scripts\mp\utility\game::getsubgametype() == "zxp" || scripts\mp\utility\game::getsubgametype() == "resurgence") {
    _id_C96CADD1D90F6788 = getdvarint("dvar_CE2B0B561FC89464", 4);

    if(_id_C96CADD1D90F6788 < 1) {
      return;
    }
    while(level.br_circle.circleindex < _id_C96CADD1D90F6788)
      waitframe();
  }

  scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);
  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_portal_close", level.players);

  foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
    _id_6EB2A337E2363ED3 setscriptablepartstate("altar", "cooldown");

    foreach(player in level.players)
    _id_6EB2A337E2363ED3 disablescriptableplayeruse(player);
  }

  level._id_49D407295B31E357._id_81AB4319C71FA29F setscriptablepartstate("portal", "closing");
  level notify("butcher_experience_disabled");
}

_id_36A52B412F170312() {
  self endon("exit_portal");
  level endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "disconnect");

  if(isDefined(self) && isPlayer(self)) {
    level._id_49D407295B31E357._id_FCD0365F5A9FB237[self.guid] = undefined;
    _id_67708F418B1FAC79::setplayeringulagjailextrainfo(0);
    self setclientomnvar("ui_jammer_strength", 0);
    self setclientomnvar("ui_hide_minimap", 0);
  }
}

_id_07BDCE97E3CC67D1(_id_89A532734FAAEAE9) {
  _id_B3C15D36553B30B5 = _id_89A532734FAAEAE9 + (0, 0, getdvarint("dvar_9498363D79F94BA6", 5000));
  caststart = _id_B3C15D36553B30B5;
  _id_FA13273FBFF1AB7C = _id_89A532734FAAEAE9;
  _id_F4FB3E42FC7EEE67 = 1000;
  mapcenter = level.mapcenter;
  _id_B8726EFB17F1FE54 = 0;

  for(;;) {
    if(_id_B8726EFB17F1FE54 > 20) {
      position = _id_FA13273FBFF1AB7C;
      break;
    }

    castend = caststart + (0, 0, -2000);
    trace = scripts\engine\trace::ray_trace(caststart, castend, self, scripts\engine\trace::create_default_contents(1));
    _id_142ADC6587364423 = 0;
    position = caststart;
    dist = distance(caststart, trace["position"]);

    if(dist >= _id_F4FB3E42FC7EEE67)
      _id_142ADC6587364423 = 1;

    if(canspawn(position)) {
      if(_id_142ADC6587364423) {
        break;
      } else
        _id_FA13273FBFF1AB7C = position;
    }

    dir = scripts\engine\utility::flatten_vector(vectorNormalize(mapcenter - caststart));
    caststart = caststart + dir * randomintrange(250, 1000);

    if(!_id_142ADC6587364423) {
      caststart = (caststart.x, caststart.y, _id_B3C15D36553B30B5.z);
      caststart = caststart + (0, 0, _id_F4FB3E42FC7EEE67 - dist);
    }

    waitframe();
  }

  return position;
}

_id_1AE7E5E8808DB628() {
  level._effect["vfx_hween_butcher_burn"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Butcher/vfx_dmz_butcher_atack_damage.vfx");
  level._effect["vfx_hween_butcher_teleport"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/Butcher/vfx_dmz_butcher_teleportationfals_3rdPerson.vfx");
}

_id_9662D79E79D628D5(player, _id_6FD2D9A208CEF69B) {
  gametype = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
  _id_D6CE941C7C41A363 = undefined;

  if(gametype != "dmz") {
    _id_67626439F7728DFA = -1;

    if(!istrue(_id_6FD2D9A208CEF69B) && getdvarint("dvar_0C191CEE4444F5DE", 0) == 1) {
      if(!isDefined(level._id_16E11016257D52E2) || !isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0))
        _id_D6CE941C7C41A363 = player _id_07BDCE97E3CC67D1(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);
      else {
        player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);
        player setOrigin(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);
        player setplayerangles(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.angles + (0, -90, 0));
        return;
      }
    } else if(isDefined(level.br_circle) && istrue(_id_6FD2D9A208CEF69B)) {
      if(isDefined(level.br_circle.br_finalcircleoverride))
        _id_D6CE941C7C41A363 = player _id_07BDCE97E3CC67D1(level.br_circle.br_finalcircleoverride);
      else
        _id_D6CE941C7C41A363 = player _id_07BDCE97E3CC67D1(level.br_level.br_circlecenters[level.br_level.br_circlecenters.size - 1]);
    }
  } else if(gametype == "dmz")
    _id_D6CE941C7C41A363 = player _id_07BDCE97E3CC67D1(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);

  player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_D6CE941C7C41A363);
  player _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  player setOrigin(_id_D6CE941C7C41A363);
  player skydive_beginfreefall();
}

_id_09772E6CDFE8BB54(player) {
  if(isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0)) {
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_objective", [player]);
    player setplayermusicstate("mx_dmz_boss_butcher_combat");
    player.nosuspensemusic = 1;
  }
}

_id_A983EF3C52DDE489() {
  if(self isinexecutionvictim() || self isinexecutionattack())
    return 0;

  if(scripts\mp\utility\player::isinlaststand(self))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  if(istrue(self._id_35DADE814E13D3CE))
    return 0;

  return 1;
}

_id_B587A630BCEEE5AD(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("death_or_disconnect");

  if(istrue(player._id_9F7DFF969C876C26) || !player _id_A983EF3C52DDE489()) {
    return;
  }
  if(istrue(player._id_859654E0445A36D9)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  player playsoundonmovingent("iw9_butch_portal_use");
  player setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2.0);
  player clearclienttriggeraudiozone(2.0);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.25);
  player._id_9F7DFF969C876C26 = 1;
  player.plotarmor = 1;
  player.ignoreme = 1;
  _id_1089B8791888F6C3 = player.origin + (0, 0, 45);
  player _id_FC86CD5659E5E025(0);
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player notify("cancel_all_killstreak_deployments");
  waitframe();
  playFX(scripts\engine\utility::getfx("vfx_hween_butcher_teleport"), _id_1089B8791888F6C3);
  wait 2;

  if(!isDefined(player)) {
    return;
  }
  if(state == "open_usable") {
    if(!istrue(level._id_49D407295B31E357._id_D8BD03B318CB8767))
      player _id_4DF0D61F4B17594A();
    else if(isDefined(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E)) {
      player _id_EF81445F4396612A();
      player thread _id_2FDEB8023287BE67::_id_9483543F1B1BFA73("butcher", "Hell", player, level._id_16E11016257D52E2._id_E2958F412A7425C0, 15000);
    }
  } else if(state == "open_return") {
    if(isDefined(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E))
      player _id_4DF0D61F4B17594A();
  }

  player _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  if(!isDefined(player)) {
    return;
  }
  player clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1.0);
  player clearclienttriggeraudiozone(2.0);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.25);
  _id_1089B8791888F6C3 = player.origin + (0, 0, 45);
  playFX(scripts\engine\utility::getfx("vfx_hween_butcher_teleport"), _id_1089B8791888F6C3);
  waitframe();

  if(isDefined(player)) {
    player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    player _id_FC86CD5659E5E025(1);
  }

  wait 0.6;

  if(isDefined(player)) {
    player.plotarmor = 0;
    player._id_9F7DFF969C876C26 = 0;
    player.ignoreme = 0;
  }
}

_id_EF81445F4396612A() {
  spawninfo = spawnStruct();
  spawninfo = scripts\mp\spawnscoring::capsulepass(spawninfo, level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E);

  if(!isDefined(spawninfo.spawnposition))
    spawninfo.spawnposition = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E.origin;

  if(!isDefined(spawninfo.spawnangle)) {
    spawninfo.spawnangle = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_795FAA0FC41DAA4E.angles;

    if(!isDefined(spawninfo.spawnangle))
      spawninfo.spawnangle = (0, 0, 0);
  }

  if(istrue(self.gasmaskequipped))
    thread _id_7E52B56769FA7774::removegasmaskbr();

  _id_787C04D97400AFBD(1);
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(spawninfo.spawnposition);
  level._id_49D407295B31E357._id_FCD0365F5A9FB237[self.guid] = self;
  self setOrigin(spawninfo.spawnposition);
  self setplayerangles(spawninfo.spawnangle);
  thread _id_36A52B412F170312();
}

_id_4DF0D61F4B17594A() {
  self notify("exit_portal");
  level._id_49D407295B31E357._id_FCD0365F5A9FB237[self.guid] = undefined;
  _id_67708F418B1FAC79::setplayeringulagjailextrainfo(0);

  if(getdvarint("dvar_B3422AD4BDC1AD75"))
    self setclientomnvar("ui_jammer_strength", 0);

  if(getdvarint("dvar_EE7A6594E8553168"))
    self setclientomnvar("ui_hide_minimap", 0);

  gametype = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
  _id_BA458688B364ABFF = _id_2695A20D4011076D::_id_024C5A8D31AE262F(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);
  _id_787C04D97400AFBD(0);

  if(gametype != "dmz" && (getdvarint("dvar_0C191CEE4444F5DE", 0) == 1 || _id_BA458688B364ABFF))
    _id_9662D79E79D628D5(self, _id_BA458688B364ABFF);
  else if(gametype == "dmz" && (_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin) || getdvarint("dvar_0C191CEE4444F5DE", 0) == 1))
    _id_9662D79E79D628D5(self, 1);
  else {
    _id_2CEDCC356F1B9FC8::playerstreamhintlocation(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin);
    spawninfo = spawnStruct();
    location = spawnStruct();
    location.origin = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin;
    location.angles = (0, 0, 0);
    spawninfo = scripts\mp\spawnscoring::capsulepass(spawninfo, location);

    if(!isDefined(spawninfo.spawnposition))
      spawninfo.spawnposition = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin;

    spawninfo.spawnposition = scripts\engine\utility::drop_to_ground(spawninfo.spawnposition);
    self setOrigin(spawninfo.spawnposition);
    self setplayerangles(level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.angles + (0, -90, 0));
  }
}

_id_787C04D97400AFBD(_id_B67BFF25DF67F62F) {
  if(_id_B67BFF25DF67F62F) {
    self.radarstrength = 0;
    self.isradarblocked = 0;
    self.hasradar = 0;
    self.radarshowenemydirection = 0;
  } else
    level notify("uav_update");
}

_id_5A0F0410C3C4326B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance = instance.entity;

  if(isDefined(instance._id_AB0E150EDA2B5E13)) {
    self[[instance._id_AB0E150EDA2B5E13]](instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
    return;
  }

  if(!_id_8044E890612B0331(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  if(state == "usable_not_open") {
    instance setscriptablepartstate(part, "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance.isbeingcaptured = 1;

    foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
      if(_id_6EB2A337E2363ED3 != instance) {
        if(_id_6EB2A337E2363ED3 getscriptablepartstate(part) == "usable_not_open")
          _id_6EB2A337E2363ED3 setscriptablepartstate(part, "unusable");
      }
    }

    if(level._id_49D407295B31E357._id_BBF34CA272F839FB == 0) {
      if(isDefined(player)) {
        _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_ritual_started", _id_96674628376EABA6);
        _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(player.team);

        if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
          _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);
          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_ritual_started_global", _id_024AECB67BB3A207, _id_171F90B9C4C76D44);
        }

        wait 1.6;
      }
    }

    instance setscriptablepartstate(part, "unusable_intro_drilling");
    instance._id_B14A331BA425C286 = 1;

    if(istrue(instance._id_B14A331BA425C286)) {
      instance.teams = [player.team];
      instance.trigger scripts\engine\utility::trigger_on();
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, "mx_dmz_boss_butcher_approach", 0.5, "mx_dmz_boss_butcher_approach");
      scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "invisible");
      scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
      instance thread _id_2364CB3873797258();
    } else
      instance setscriptablepartstate(part, "usable_not_open");
  }
}

_id_05EE12A782DA0D41() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(_id_97C849A27BAED651(player.origin)) {
        if(!istrue(player._id_CDB204811B37DB77) && isDefined(level._id_16E11016257D52E2._id_E2958F412A7425C0)) {
          _id_171F90B9C4C76D44 = undefined;

          if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
            _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);

          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("altar_near", [player], _id_171F90B9C4C76D44);
          player._id_CDB204811B37DB77 = 1;
        }

        continue;
      }

      if(!istrue(_id_97C849A27BAED651(player.origin)))
        player._id_CDB204811B37DB77 = 0;
    }

    wait 1;
  }
}

_id_97C849A27BAED651(_id_1CFCCAC3E5778BBB) {
  if(isDefined(_id_1CFCCAC3E5778BBB) && isvector(_id_1CFCCAC3E5778BBB)) {
    if(isDefined(self.origin) && isvector(self.origin)) {
      _id_AFE9E823907C4FDE = distance2d(_id_1CFCCAC3E5778BBB, self.origin);
      return _id_AFE9E823907C4FDE < 3000;
    }
  }

  return 0;
}

_id_15EBD4304B177755(_id_6E6EE0D9F73A2999) {
  self.agents = [];

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    return;
  }
  aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range", undefined, 2);
  _id_F945F5534FFEDF42 = anglesToForward(self.angles) * 80;
  origin = getclosestpointonnavmesh(self.origin + _id_F945F5534FFEDF42);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, self.angles, "high", "mission", "altarInitialGuards", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 1);

  if(isDefined(agent)) {
    self.agents[0] = agent;
    thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 0);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6E6EE0D9F73A2999; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range");
    _id_AFE9E823907C4FDE = randomfloatrange(144, 360);
    forward = anglesToForward(self.angles) * _id_AFE9E823907C4FDE;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / _id_6E6EE0D9F73A2999 * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = getclosestpointonnavmesh(self.origin + offset);
    spawnorigin = scripts\engine\utility::drop_to_ground(origin, 20, -150, (0, 0, 1));
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnorigin, _id_CB88E484EB1A3A92, "high", "mission", "altar", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 0);

    if(isDefined(agent)) {
      self.agents[self.agents.size] = agent;
      thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    }
  }
}

_id_2364CB3873797258() {
  level endon("game_ended");
  self endon("altar_unlocked");
  self.progress = 0;
  _id_A81135442EE1A731 = 0;
  _id_306804C6C85C36B0 = undefined;
  _id_94947EF251BF06D8 = 0;
  _id_F7D8DF490BD332C3 = 512;
  _id_7CC37D084D5E863C = 0;
  _id_90FB369A18926018 = [];
  _id_82BEE4736815089B = level._id_49D407295B31E357._id_7B55E2C7824BB589.origin;

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(_id_306804C6C85C36B0))
        _id_306804C6C85C36B0 = [0, self.capturetime / 2];

      if(self._id_78122E18403A8DC4.size > 0) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
      }

      progress = self.progress / self.capturetime;
      _id_90FB369A18926018 = _id_CD938CB70F911193(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        _id_FA709F49619D0D6C();

        if(isDefined(level._id_FA709F49619D0D6C))
          self[[level._id_FA709F49619D0D6C]]();

        _id_8C1EC559BAE28237();
      } else if(level._id_49D407295B31E357._id_83DA016BAFBAFEF6 && self._id_78122E18403A8DC4.size > 0 && isDefined(_id_306804C6C85C36B0[_id_94947EF251BF06D8]) && self.progress >= _id_306804C6C85C36B0[_id_94947EF251BF06D8]) {
        _id_94947EF251BF06D8++;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
          _id_51160157E596BB9C = 600;
          _id_F0E87F1127A2209E = 1000;
          _id_1E0EFB08324146DC = randomfloatrange(_id_51160157E596BB9C, _id_F0E87F1127A2209E);
          _id_E2BB8BE14A3105F3 = randomfloatrange(0.0, 360);
          _id_A9979045658C3DED = (_id_82BEE4736815089B[0] + cos(_id_E2BB8BE14A3105F3) * _id_1E0EFB08324146DC, _id_82BEE4736815089B[1] + sin(_id_E2BB8BE14A3105F3) * _id_1E0EFB08324146DC, _id_82BEE4736815089B[2]);
          _id_D8235976EA87D0D2 = (0, randomfloatrange(0.0, 360), 0);
          pos = spawnStruct();
          pos.origin = getclosestpointonnavmesh(_id_A9979045658C3DED);
          pos.angles = _id_D8235976EA87D0D2;
          _id_B7034EF67B8CA88D = pos.origin + (0, 0, 20);
          _id_D1A6F7A468F82326 = _id_B7034EF67B8CA88D + anglesToForward(pos.angles) * 60;
          _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(_id_B7034EF67B8CA88D, _id_D1A6F7A468F82326);

          if(_id_214D77BB9D513C28["fraction"] != 1)
            pos.angles = pos.angles + (0, 180, 0);

          _id_3138C7EBA9B7AA1F = _id_59EBFABF2131C30F::_id_C48BC2EFBD1CE08A(pos, 0);

          if(isDefined(_id_3138C7EBA9B7AA1F)) {
            _id_3138C7EBA9B7AA1F._id_F22F47741E34D6AE = _id_3138C7EBA9B7AA1F.origin;
            _id_3138C7EBA9B7AA1F._id_E334D718934928EC = self;
            _id_3138C7EBA9B7AA1F thread _id_961DC5AB7854E83E();
            _id_3138C7EBA9B7AA1F thread _id_59EBFABF2131C30F::_id_2A4563CF9FF0BDC4();
            self._id_2C0CDD0259CB8480[self._id_2C0CDD0259CB8480.size] = _id_3138C7EBA9B7AA1F;
          }
        }
      }
    }

    waitframe();
  }
}

_id_CD938CB70F911193(_id_78122E18403A8DC4, _id_90FB369A18926018, progress) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_show_player_progress(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_DMZ_MISSIONS/ALTAR_RITUAL_PROGRESS", player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(2, player);
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_hide_player_progress(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_FA709F49619D0D6C() {
  if(level._id_49D407295B31E357._id_885AD6B3C9D47759 == 0)
    self.trigger delete();
  else
    self.trigger scripts\engine\utility::trigger_off();

  level._id_49D407295B31E357._id_BBF34CA272F839FB++;

  foreach(team in self.teams) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);

      if(!isDefined(player._id_20155A41C058C40C))
        player._id_20155A41C058C40C = 0;

      player._id_20155A41C058C40C++;

      if(level._id_49D407295B31E357._id_BBF34CA272F839FB >= level._id_49D407295B31E357._id_F6694E38D5991F7C) {
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A8123F52400A3B36");
        continue;
      }

      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_79C2E2CC1A904CD9");
    }

    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "", 1.5);
  }

  self setscriptablepartstate("altar", "opening");
  wait 2;

  foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
    if(_id_6EB2A337E2363ED3 getscriptablepartstate("altar") == "unusable")
      _id_6EB2A337E2363ED3 setscriptablepartstate("altar", "usable_not_open");
  }

  self.opened = 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);

  if(level._id_49D407295B31E357._id_885AD6B3C9D47759 == 0)
    scripts\mp\gameobjects::releaseid();

  if(level._id_49D407295B31E357._id_BBF34CA272F839FB >= level._id_49D407295B31E357._id_F6694E38D5991F7C) {
    objective_setlabel(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid, &"MP_BR_INGAME/ALTAR_PORTAL");
    scripts\mp\objidpoolmanager::update_objective_icon(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid, "hud_icon_minimap_boss_butcher_portal");
    level._id_49D407295B31E357._id_81AB4319C71FA29F setscriptablepartstate("portal", "opening");
    level notify("butcher_portal_opened");
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_portal", level.players);
  }

  self.isbeingcaptured = 0;
}

_id_5B665F6281173B25(trigger, radius) {
  level endon("game_ended");
  self endon("altar_unlocked");
  self._id_78122E18403A8DC4 = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(isDefined(player) && player scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(player.occupants) && player.occupants.size >= 1) {
      foreach(_id_F85572CD5F6117C6 in player.occupants) {
        if(!scripts\engine\utility::array_contains(self.teams, _id_F85572CD5F6117C6.team))
          self.teams[self.teams.size] = _id_F85572CD5F6117C6.team;

        self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, _id_F85572CD5F6117C6);
        thread _id_4FEC4413C08C7778(trigger, _id_F85572CD5F6117C6, radius);
      }

      continue;
    }

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, player);
    thread _id_4FEC4413C08C7778(trigger, player, radius);
  }
}

_id_4FEC4413C08C7778(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2)
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}

_id_CA164585962E5901(team, origin) {
  wait 4;
  _id_26F0C58CF64AB613 = 0;
  _id_6451409D2BFDDB20 = randomintrange(level._id_49D407295B31E357._id_3C1656D0DE196C00, level._id_49D407295B31E357._id_3BF36CD0DDF354AA + 1);
  _id_DFDD438871090D04 = sortbydistance(level._id_A91B93E67D4BB9E0, origin);

  foreach(_id_6EB2A337E2363ED3 in _id_DFDD438871090D04) {
    if(!istrue(_id_6EB2A337E2363ED3.opened) && !scripts\engine\utility::array_contains(_id_6EB2A337E2363ED3._id_4E29111F80D17365, team)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(_id_6EB2A337E2363ED3.objidnum, team);
      _id_6EB2A337E2363ED3._id_4E29111F80D17365[_id_6EB2A337E2363ED3._id_4E29111F80D17365.size] = team;
      _id_26F0C58CF64AB613++;

      if(_id_26F0C58CF64AB613 >= _id_6451409D2BFDDB20) {
        break;
      }
    }
  }
}

_id_49DFCC9932C8570E() {
  foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
    while(istrue(_id_6EB2A337E2363ED3.isbeingcaptured))
      waitframe();

    _id_6EB2A337E2363ED3 setscriptablepartstate("altar", "cooldown");

    if(isDefined(level.players)) {
      foreach(player in level.players)
      _id_6EB2A337E2363ED3 disablescriptableplayeruse(player);
    }
  }

  level._id_49D407295B31E357._id_81AB4319C71FA29F setscriptablepartstate("portal", "closing");
  scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);
  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);

  if(level._id_49D407295B31E357._id_885AD6B3C9D47759 == 0) {
    return;
  }
  foreach(_id_3138C7EBA9B7AA1F in level._id_D0DBF9BF852DD46C) {
    if(isDefined(_id_3138C7EBA9B7AA1F))
      _id_3138C7EBA9B7AA1F _id_48814951E916AF89::_id_28B90EB2B591003F();
  }

  level._id_49D407295B31E357._id_CADE8B1F6616C692 setscriptablepartstate("skull", "off");
}

_id_CE893CBCBA60CAAE() {
  level endon("disconnect");
  level endon("game_ended");
  level endon("butcher_experience_disabled");
  self waittill("death");
  _id_5DCB4B231E9F7E79 = 1;

  while(level._id_49D407295B31E357._id_FCD0365F5A9FB237.size != 0 && _id_5DCB4B231E9F7E79) {
    _id_5DCB4B231E9F7E79 = 0;

    foreach(player in level._id_49D407295B31E357._id_FCD0365F5A9FB237) {
      if(scripts\mp\utility\player::_id_AD443BBCDCF37B85(player))
        _id_5DCB4B231E9F7E79 = 1;
    }

    waitframe();
  }

  foreach(player in level._id_49D407295B31E357._id_FCD0365F5A9FB237) {
    if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
      spawninfo = spawnStruct();
      location = spawnStruct();
      location.origin = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin;
      location.angles = (0, 0, 0);
      spawninfo = player scripts\mp\spawnscoring::capsulepass(spawninfo, location);

      if(!isDefined(spawninfo.spawnposition))
        spawninfo.spawnposition = level._id_49D407295B31E357._id_81AB4319C71FA29F._id_6869AC43900D77F9._id_795FAA0FC41DAA4E.origin;

      spawninfo.spawnposition = scripts\engine\utility::drop_to_ground(spawninfo.spawnposition);
      scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.25);
      player._id_9F7DFF969C876C26 = 1;
      player.plotarmor = 1;
      player.ignoreme = 1;
      player _id_FC86CD5659E5E025(0);
      player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(spawninfo.spawnposition);
      player _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

      if(!isDefined(player)) {
        return;
      }
      player setOrigin(spawninfo.spawnposition);
      player clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1.0);
      player clearclienttriggeraudiozone(2.0);
      playFX(scripts\engine\utility::getfx("vfx_hween_butcher_teleport"), player.origin);
      wait 0.6;
      scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.25);

      if(isDefined(player)) {
        player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
        player _id_FC86CD5659E5E025(1);
        player.plotarmor = 0;
        player._id_9F7DFF969C876C26 = 0;
        player.ignoreme = 0;
      }
    }
  }

  _id_49DFCC9932C8570E();
  wait(level._id_49D407295B31E357._id_8D11120EDFF5B400);
  _id_41182C4D3989B029();
}

_id_41182C4D3989B029() {
  if(isDefined(level.players)) {
    foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
      _id_6EB2A337E2363ED3.opened = 0;
      _id_6EB2A337E2363ED3.progress = 0;
      _id_6EB2A337E2363ED3._id_E80C6AAC15D6B886 = 0;
      _id_6EB2A337E2363ED3._id_7BE8B486A10B3DE8 = 0;
      _id_6EB2A337E2363ED3._id_B14A331BA425C286 = 0;
      _id_6EB2A337E2363ED3 setscriptablepartstate("altar", "usable_not_open");
      _id_6EB2A337E2363ED3 thread _id_5B665F6281173B25(_id_6EB2A337E2363ED3.trigger, level._id_49D407295B31E357._id_029A79D378C70E0B);

      foreach(player in level.players)
      _id_6EB2A337E2363ED3 enablescriptableplayeruse(player);
    }
  }

  level._id_49D407295B31E357._id_FCD0365F5A9FB237 = [];
  level._id_49D407295B31E357._id_CADE8B1F6616C692 setscriptablepartstate("skull", "on");
  level._id_49D407295B31E357._id_BBF34CA272F839FB = 0;

  if(level._id_49D407295B31E357._id_0019AD2B18CE20B7)
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);
  else
    scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);

  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid);
  scripts\mp\objidpoolmanager::update_objective_icon(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid, "hud_icon_minimap_boss_butcher_lilith_altar");
  objective_setlabel(level._id_49D407295B31E357._id_81AB4319C71FA29F.objid, &"MP_BR_INGAME/ALTAR_DEFAULT");

  foreach(_id_6EB2A337E2363ED3 in level._id_A91B93E67D4BB9E0) {
    if(level._id_49D407295B31E357._id_83DA016BAFBAFEF6 && scripts\mp\utility\game::getgametype() != "br")
      _id_6EB2A337E2363ED3 _id_15EBD4304B177755(1);
  }

  level._id_16E11016257D52E2._id_E2958F412A7425C0 = level._id_16E11016257D52E2 _id_59EBFABF2131C30F::_id_6D69350C86BAF67B(level._id_16E11016257D52E2.nodes["boss_butcher_spawn"][0]);
  level._id_16E11016257D52E2._id_E2958F412A7425C0 _id_5938B1C7E9CF6DDD::go_to_node_set_goal(level._id_16E11016257D52E2.nodes["boss_butcher_spawn"]);
  level notify("butcher_boss_reset");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_butcher_respawned", level.players);
  _id_55E395B5A89CC532::_id_1C436B0944DB5FDF("butcher_area_damage", getdvarfloat("dvar_B2B82FF812A9E6FE", 1.0));
  _id_55E395B5A89CC532::_id_661C9A3EA014D8F0("butcher_area_damage", getdvarfloat("dvar_58EAD4934366A659", 5.0));
}

_id_8044E890612B0331(player) {
  if(isDefined(player) && istrue(player._id_859654E0445A36D9))
    return 0;

  return 1;
}

_id_961DC5AB7854E83E() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    while(!isDefined(self._id_003B90191D39897A) || isDefined(self._id_003B90191D39897A) && (distancesquared(self._id_003B90191D39897A.origin, self.origin) < 1440000 || distancesquared(self._id_003B90191D39897A.origin, self._id_E334D718934928EC.origin) < 4000000))
      waitframe();

    self.ignoreall = 1;
    self._id_68011EA8DFF99DB6 = 1;
    self._id_F0B8CE627701035E = 0;
    _id_5938B1C7E9CF6DDD::set_goal_pos(self._id_F22F47741E34D6AE);

    for(;;) {
      _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

      if(_id_78122E18403A8DC4.size > 0 || istrue(self._id_F0B8CE627701035E)) {
        self._id_F0B8CE627701035E = 0;
        self.ignoreall = 0;
        self._id_68011EA8DFF99DB6 = undefined;
        break;
      }

      wait 1;
    }

    waitframe();
  }
}

_id_C2021066FF482332() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(self.origin, 2000);

    if(_id_78122E18403A8DC4.size > 0) {
      foreach(zombie in self._id_2C0CDD0259CB8480)
      zombie._id_F0B8CE627701035E = 1;
    }

    wait 1;
  }
}

_id_FC86CD5659E5E025(_id_BD138DE99B3B3507) {
  if(!isDefined(self)) {
    return;
  }
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("teleporting", "allow_jump", 0);
    _id_3B64EB40368C1450::set("teleporting", "gesture", 0);
    _id_3B64EB40368C1450::set("teleporting", "melee", 0);
    _id_3B64EB40368C1450::set("teleporting", "mantle", 0);
    _id_3B64EB40368C1450::set("teleporting", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("teleporting", "allow_movement", 0);
    _id_3B64EB40368C1450::set("teleporting", "sprint", 0);
    _id_3B64EB40368C1450::set("teleporting", "fire", 0);
    _id_3B64EB40368C1450::set("teleporting", "reload", 0);
    _id_3B64EB40368C1450::set("teleporting", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("teleporting", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("teleporting", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("teleporting", "execution_victim", 0);
    _id_3B64EB40368C1450::set("teleporting", "vehicle_use", 0);
    _id_3B64EB40368C1450::set("teleporting", "supers", 0);
    self setclientomnvar("ui_br_inventory_disabled", 1);
    self _meth_35501B42058D4DE9();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("teleporting");
    self setclientomnvar("ui_br_inventory_disabled", 0);
    self _meth_BB04491D50D9E43E();
  }
}

_id_A13ED0AB1E8F27C0(ent) {
  if(!isDefined(ent))
    return 0;

  return _id_55E395B5A89CC532::_id_1BE5E0D403A7EDDC("butcher_area_damage") && _id_55E395B5A89CC532::_id_798B7526DBF940F7("butcher_area_damage", ent);
}

_id_9605A1D63F9B580B(icon, victim, team) {
  level endon("game_ended");
  victim endon("disconnect");
  victim endon("revivedAlive");
  victim endon("trigger_removed");
  victim endon("spawned");

  if(!isDefined(icon) || !isDefined(victim) || !isDefined(team)) {
    return;
  }
  _id_E946DAEDDA5415AA = _id_A13ED0AB1E8F27C0(victim);

  for(;;) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in _id_A6AB8D0FDA441DC2) {
      if(player == victim) {
        continue;
      }
      _id_097505F226D8AAF5 = _id_A13ED0AB1E8F27C0(player);

      if(_id_E946DAEDDA5415AA != _id_097505F226D8AAF5) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(icon.objidnum, player);
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(icon.objidnum, player);
    }

    wait 0.25;
  }
}