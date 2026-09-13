/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_594132fab60aa90d.gsc
***********************************************/

_id_246582E2CB860BCD() {
  if(isDefined(level._id_DB7BB73A753C01D7)) {
    return;
  }
  if(!isDefined(game["pushableObjectsOrigin"]))
    game["pushableObjectsOrigin"] = [];

  level._id_DB7BB73A753C01D7 = [];
  setDvar("dvar_781270C0B4DFA137", 1);
  objects = getEntArray("script_toolbox", "targetname");
  _id_261D73DEE9F7F35C = getEntArray("script_toolbox_trigger", "targetname");
  clips = getEntArray("script_toolbox_clip", "targetname");
  scripts\engine\utility::array_delete(_id_261D73DEE9F7F35C);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_left", ::_id_82E77070DE471DF6);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_rear", ::_id_82E77070DE471DF6);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_front", ::_id_82E77070DE471DF6);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_right", ::_id_82E77070DE471DF6);

  foreach(object in objects) {
    object setModel("storage_rolling_toolbox_pushable");
    clip = scripts\engine\utility::getclosest(object.origin, clips);
    clip linkTo(object);
    object setnodeploy(1);
    clip setnodeploy(1);
    clip _meth_3E71A76B50A93E05("movingplatform_pushable_script_anim");
    object.clip = clip;
    clip.object = object;
    level._id_DB7BB73A753C01D7[level._id_DB7BB73A753C01D7.size] = object;
    object thread _id_517BBAF39BD63540();
  }

  if(level.script == "cp_raid1_boss1") {
    _id_5BE7B907B3D37C34 = scripts\engine\utility::getclosest((11795, 7123, 360), level._id_DB7BB73A753C01D7);
    _id_5BE7B907B3D37C34.origin = _id_5BE7B907B3D37C34.origin + anglesToForward(_id_5BE7B907B3D37C34.angles) * 20 + anglestoright(_id_5BE7B907B3D37C34.angles) * 20;
    _id_5BE7B907B3D37C34.angles = _id_5BE7B907B3D37C34.angles + (0, 180, 0);
    _id_5BE7B907B3D37C34 = scripts\engine\utility::getclosest((7222, 14614, 342), level._id_DB7BB73A753C01D7);
    _id_5BE7B907B3D37C34.origin = _id_5BE7B907B3D37C34.origin + anglestoright(_id_5BE7B907B3D37C34.angles) * 20;
  }

  if(isDefined(game["pushableObjectsOrigin"]) && game["pushableObjectsOrigin"].size) {
    _id_7DEB9C4A40026A63 = [];

    foreach(index, item in game["pushableObjectsOrigin"]) {
      _id_7DEB9C4A40026A63[index] = spawnStruct();
      _id_7DEB9C4A40026A63[index].origin = item;
    }

    foreach(_id_FE8F7703F6313ED4, object in level._id_DB7BB73A753C01D7) {
      object._id_5E6A8853EFDC7302 = _id_FE8F7703F6313ED4;
      _id_2AE805B43221A762 = scripts\engine\utility::getclosest(object.origin, _id_7DEB9C4A40026A63, 4000);

      if(isDefined(_id_2AE805B43221A762))
        object.origin = _id_2AE805B43221A762.origin;
    }
  } else {
    foreach(objindex, object in level._id_DB7BB73A753C01D7) {
      game["pushableObjectsOrigin"][objindex] = object.origin;
      object._id_5E6A8853EFDC7302 = objindex;
    }
  }
}

_id_82E77070DE471DF6(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("last_stand");
  player endon("disconnect");
  org = player.origin;

  while(player useButtonPressed())
    waitframe();

  if(distance(org, player.origin) > 50) {
    return;
  }
  instance.entity notify("used", player, part);
}

_id_517BBAF39BD63540() {
  level endon("game_ended");
  _id_FFD254198B16281C();

  for(;;) {
    self waittill("used", ent, part);

    if(!ent scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!_id_5466E10C15EA95C6(ent, part)) {
      continue;
    }
    foreach(player in level.players)
    self disablescriptableplayeruse(player);

    ent _id_3B64EB40368C1450::set("pushing", "allow_movement", 0);
    ent setmovespeedscale(0.35);
    ent _id_EC47816DFE1F6B84(0);
    ent._id_512F0D6731086F73 = 1;
    _id_FEEB4356B6B9A929 = ent.origin;
    _id_1DA12F4DA97CC44D = ent.angles;

    switch (part) {
      case "usable_left":
        _id_FEEB4356B6B9A929 = self.origin + anglestoright(self.angles) * 40;
        _id_1DA12F4DA97CC44D = vectortoangles(_id_FEEB4356B6B9A929 - self.origin) * -1;
        break;
      case "usable_right":
        _id_FEEB4356B6B9A929 = self.origin + anglestoleft(self.angles) * 40;
        _id_1DA12F4DA97CC44D = vectortoangles(_id_FEEB4356B6B9A929 - self.origin) * -1;
        break;
      case "usable_front":
        _id_FEEB4356B6B9A929 = self.origin + anglesToForward(self.angles) * 33;
        _id_1DA12F4DA97CC44D = vectortoangles(self.origin - _id_FEEB4356B6B9A929);
        break;
      case "usable_rear":
        _id_FEEB4356B6B9A929 = self.origin + anglesToForward(self.angles) * 33 * -1;
        _id_1DA12F4DA97CC44D = vectortoangles(self.origin - _id_FEEB4356B6B9A929);
        break;
    }

    ent thread _id_F77577B854565881();
    wait 0.1;
    ent _id_108434FCD23138A0(1);
    ent thread _id_98E8926B4006E597(_id_FEEB4356B6B9A929, _id_1DA12F4DA97CC44D);
    wait 0.4;
    ent _id_3B64EB40368C1450::set("pushing", "allow_movement", 1);

    if(!ent scripts\cp\utility::is_valid_player()) {
      if(isDefined(ent)) {
        ent _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("pushing");
        ent._id_512F0D6731086F73 = undefined;
        ent _id_108434FCD23138A0(0);
      }

      foreach(player in level.players)
      self enablescriptableplayeruse(player);

      continue;
    }

    level notify("player_push_object", ent, self);
    _id_07853F999549D59E(ent, part);

    if(isDefined(ent)) {
      ent._id_512F0D6731086F73 = undefined;
      ent _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("pushing");
      ent _id_108434FCD23138A0(0);
    }

    wait 1;

    foreach(player in level.players)
    self enablescriptableplayeruse(player);
  }
}

_id_98E8926B4006E597(_id_FEEB4356B6B9A929, _id_1DA12F4DA97CC44D) {
  self endon("disconnect");
  self endon("last_stand");
  self.anchor = spawn("script_origin", _id_FEEB4356B6B9A929);
  self.anchor.angles = _id_1DA12F4DA97CC44D;
  self playerlinktoblend(self.anchor, undefined, 0.35);
  wait 0.35;
  self setOrigin(self.anchor.origin);
  self.anchor delete();
}

_id_07853F999549D59E(ent, _id_559074835C6CDA77) {
  ent endon("disconnect");
  ent scripts\cp\utility::hint_prompt("push_object", 1);
  _id_19109160C753EB9C = undefined;
  ent setmovespeedscale(0.35);

  while(ent scripts\cp\utility::is_valid_player() && !ent useButtonPressed() && !ent jumpbuttonPressed() && !ent ismantling() && !ent stancebuttonPressed() && !ent adsButtonPressed() && !ent attackButtonPressed() && !ent meleeButtonPressed()) {
    switch (_id_559074835C6CDA77) {
      case "usable_left":
        _id_19109160C753EB9C = self.origin + anglestoright(self.angles) * 40;
        break;
      case "usable_right":
        _id_19109160C753EB9C = self.origin + anglestoleft(self.angles) * 40;
        break;
      case "usable_front":
        _id_19109160C753EB9C = self.origin + anglesToForward(self.angles) * 33;
        break;
      case "usable_rear":
        _id_19109160C753EB9C = self.origin + anglesToForward(self.angles) * 33 * -1;
        break;
    }

    if(distance2d(ent.origin, _id_19109160C753EB9C) > 30) {
      break;
    }

    if(abs(ent.origin[2] - abs(self.origin[2])) > 5) {
      break;
    }

    if(!isDefined(level._id_71676CF408E6DDD1))
      level._id_71676CF408E6DDD1 = [];

    if(!isDefined(level._id_71676CF408E6DDD1[ent getentitynumber()]))
      level._id_71676CF408E6DDD1[ent getentitynumber()] = 0.0;

    _id_BC7D3132C4F820D4 = level._id_71676CF408E6DDD1[ent getentitynumber()];
    _id_F619FE4A4E1D4868 = ent getnormalizedmovement();
    _id_53E7A899384DF6FD = 0;

    if(_id_55271C4EE21EF03C(ent)) {
      if(!istrue(level._id_EFDF3B3CE9B5905A))
        _id_53E7A899384DF6FD = 1;
    }

    _id_E88D2D02F4968C18 = abs(_id_F619FE4A4E1D4868[0]);

    if(_id_F619FE4A4E1D4868[0] > 0.1) {
      if(_id_BC7D3132C4F820D4 > _id_E88D2D02F4968C18) {
        _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 - 0.15;

        if(_id_BC7D3132C4F820D4 < _id_E88D2D02F4968C18)
          _id_BC7D3132C4F820D4 = _id_E88D2D02F4968C18;
      } else {
        _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 + 0.15;

        if(_id_BC7D3132C4F820D4 > _id_E88D2D02F4968C18)
          _id_BC7D3132C4F820D4 = _id_E88D2D02F4968C18;
      }
    } else if(_id_F619FE4A4E1D4868[0] < -0.1) {
      if(_id_BC7D3132C4F820D4 < -1 * _id_E88D2D02F4968C18) {
        _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 + 0.15;

        if(_id_BC7D3132C4F820D4 > -1 * _id_E88D2D02F4968C18)
          _id_BC7D3132C4F820D4 = -1 * _id_E88D2D02F4968C18;
      } else {
        _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 - 0.15;

        if(_id_BC7D3132C4F820D4 < -1 * _id_E88D2D02F4968C18)
          _id_BC7D3132C4F820D4 = -1 * _id_E88D2D02F4968C18;
      }
    } else if(_id_BC7D3132C4F820D4 < 0.0) {
      _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 + 0.15;

      if(_id_BC7D3132C4F820D4 > 0.0)
        _id_BC7D3132C4F820D4 = 0.0;
    } else if(_id_BC7D3132C4F820D4 > 0.0) {
      _id_BC7D3132C4F820D4 = _id_BC7D3132C4F820D4 - 0.15;

      if(_id_BC7D3132C4F820D4 < 0.0)
        _id_BC7D3132C4F820D4 = 0.0;
    }

    level._id_71676CF408E6DDD1[ent getentitynumber()] = _id_BC7D3132C4F820D4;

    if(_id_F619FE4A4E1D4868 == (0, 0, 0) && _id_BC7D3132C4F820D4 == 0.0) {
      self notify("stoploopsound");
      ent _id_31A95215EB8B2013();
      waitframe();
      continue;
    }

    if(_id_53E7A899384DF6FD) {
      self notify("stoploopsound");
      ent _id_5C95D11A6F63454F();
      waitframe();
      continue;
    }

    _id_9BE10E56442B7EC8();
    _id_CEA868F483A92546 = (0, 0, 0);
    _id_88939CA2B5D194C5 = ent _meth_F73C119F364D09E8();

    if(_id_88939CA2B5D194C5 > 300.0)
      _id_88939CA2B5D194C5 = 300.0;
    else if(_id_88939CA2B5D194C5 < 100.0)
      _id_88939CA2B5D194C5 = 100.0;

    _id_3A978FAA301488B1 = _id_88939CA2B5D194C5 / 300.0;
    maxscale = 1;

    switch (_id_559074835C6CDA77) {
      case "usable_left":
        if(_id_BC7D3132C4F820D4 > 0.0)
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (0, 20, 0);
        else
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (0, 2, 0);

        _id_CEA868F483A92546 = ent.origin + (0, 45, 0) + _id_B3B7E9C2DB0D722D;
        break;
      case "usable_right":
        if(_id_BC7D3132C4F820D4 > 0.0)
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (0, -20, 0);
        else
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (0, -2, 0);

        _id_CEA868F483A92546 = ent.origin + (0, -45, 0) + _id_B3B7E9C2DB0D722D;
        break;
      case "usable_front":
        if(_id_BC7D3132C4F820D4 > 0.0)
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (-20, 0, 0);
        else
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (-2, 0, 0);

        _id_CEA868F483A92546 = ent.origin + (-37, 0, 0) + _id_B3B7E9C2DB0D722D;
        break;
      case "usable_rear":
        if(_id_BC7D3132C4F820D4 > 0.0)
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (20, 0, 0);
        else
          _id_B3B7E9C2DB0D722D = _id_BC7D3132C4F820D4 * _id_3A978FAA301488B1 * (2, 0, 0);

        _id_CEA868F483A92546 = ent.origin + (37, 0, 0) + _id_B3B7E9C2DB0D722D;
        break;
    }

    deployables = [];

    foreach(_id_4D8D7E624A8D0EB0 in level.players) {
      if(!isDefined(_id_4D8D7E624A8D0EB0.deployable_box)) {
        continue;
      }
      keys = getarraykeys(_id_4D8D7E624A8D0EB0.deployable_box);

      foreach(key in keys)
      deployables = scripts\engine\utility::array_combine(deployables, _id_4D8D7E624A8D0EB0.deployable_box[key]);
    }

    _id_801217FE248465C4 = [];

    foreach(_id_4D8D7E624A8D0EB0 in level.players) {
      if(isDefined(_id_4D8D7E624A8D0EB0._id_801217FE248465C4))
        _id_801217FE248465C4 = scripts\engine\utility::array_combine(_id_801217FE248465C4, _id_4D8D7E624A8D0EB0._id_801217FE248465C4);
    }

    contents = scripts\engine\trace::create_contents(1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0);
    ignoreents = scripts\engine\utility::array_combine(level.players, [self, self.clip], level.mines, deployables, _id_801217FE248465C4);
    _id_6EB9BB64FDA31A70 = scripts\engine\trace::sphere_trace_passed(self.origin + (0, 0, 30), _id_CEA868F483A92546 + (0, 0, 30), 26, ignoreents, contents);
    _id_01322FC0232D294B = scripts\engine\trace::sphere_trace_passed(ent.origin + (0, 0, 30), ent.origin + (0, 0, 30), 18, ignoreents, contents);
    fwd = anglesToForward(self.angles) * 20;
    _id_B8B4B9A567C24EAD = _id_CEA868F483A92546 + (0, 0, 3) + anglestoright(self.angles) * 20;
    _id_B8B4B9A567C24EAD = _id_B8B4B9A567C24EAD + fwd;
    _id_7D7CCD8F26EA0EAD = scripts\engine\trace::ray_trace_passed(_id_B8B4B9A567C24EAD, _id_B8B4B9A567C24EAD + (0, 0, -5));
    _id_B8B49BA567C20CB3 = _id_CEA868F483A92546 + (0, 0, 3) + anglestoright(self.angles) * -20;
    _id_B8B49BA567C20CB3 = _id_B8B49BA567C20CB3 + fwd;
    _id_ADF004033B6C5020 = scripts\engine\trace::ray_trace_passed(_id_B8B49BA567C20CB3, _id_B8B49BA567C20CB3 + (0, 0, -5));
    fwd = anglesToForward(self.angles) * -20;
    _id_B90C99A56822D519 = _id_CEA868F483A92546 + (0, 0, 3) + anglestoright(self.angles) * 20;
    _id_B90C99A56822D519 = _id_B90C99A56822D519 + fwd;
    _id_F0FFBA141A33B927 = scripts\engine\trace::ray_trace_passed(_id_B90C99A56822D519, _id_B8B4B9A567C24EAD + (0, 0, -5));
    _id_B90CB3A568230E47 = _id_CEA868F483A92546 + (0, 0, 3) + anglestoright(self.angles) * -20;
    _id_B90CB3A568230E47 = _id_B90CB3A568230E47 + fwd;
    _id_AB94AF372FFB3F72 = scripts\engine\trace::ray_trace_passed(_id_B90CB3A568230E47, _id_B8B49BA567C20CB3 + (0, 0, -5));

    if(_id_7D7CCD8F26EA0EAD || _id_ADF004033B6C5020 || _id_F0FFBA141A33B927 || _id_AB94AF372FFB3F72)
      _id_6EB9BB64FDA31A70 = 0;

    contents = scripts\engine\trace::create_default_contents();
    _id_B4331A150334BF61 = 0;
    _id_52C66224A2BB3C12 = physics_raycast(self.origin + _id_CEA868F483A92546 * 1.5, self.origin + _id_CEA868F483A92546 * 1.5 + (0, 0, -25), contents, ignoreents, 0, "physicsquery_all");

    if(isDefined(_id_52C66224A2BB3C12) && _id_52C66224A2BB3C12.size > 0) {
      if(isDefined(_id_52C66224A2BB3C12[0]["surfaceflags"])) {
        _id_C51360972AFFC25B = physics_getsurfacetypefromflags(_id_52C66224A2BB3C12[0]["surfaceflags"]);

        if(_id_C51360972AFFC25B["name"] == "surftype_water")
          _id_B4331A150334BF61 = 1;
      }
    }

    if(!_id_B4331A150334BF61 && _id_6EB9BB64FDA31A70 && _id_01322FC0232D294B) {
      self.origin = _id_CEA868F483A92546;
      game["pushableObjectsOrigin"][self._id_5E6A8853EFDC7302] = _id_CEA868F483A92546;
    } else {
      self notify("stoploopsound");
      ent _id_5C95D11A6F63454F();
      waitframe();
      continue;
    }

    ent _id_31A95215EB8B2013();
    waitframe();
    _id_FFD254198B16281C();
  }

  ent setclientomnvar("zm_hint_index", 0);
  self notify("stoploopsound");
  ent._id_D7037D4A51A2EA0E = undefined;
  ent._id_44CE11DCD72AE44F = undefined;
  ent _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("pushing");
  ent._id_512F0D6731086F73 = undefined;

  if(isDefined(ent._id_D23A4C6C080BEE59)) {
    ent _meth_A63E26425EF807D6(0);
    ent takeweapon("iw9_me_pushfists");
    ent switchtoweaponimmediate(ent._id_D23A4C6C080BEE59);
    ent._id_D23A4C6C080BEE59 = undefined;
  }

  ent scripts\engine\utility::delaythread(1, scripts\engine\utility::send_notify, "update_flashlight_tags");
}

_id_5C95D11A6F63454F() {
  scripts\cp\utility::hint_prompt("push_object_blocked", 1);
}

_id_31A95215EB8B2013() {
  scripts\cp\utility::hint_prompt("push_object", 1);
}

_id_FFD254198B16281C() {
  if(!isDefined(self.badplace))
    self.badplace = createnavobstaclebybounds(self.origin, (250, 250, 250), (0, 0, 0));
  else {
    destroynavobstacle(self.badplace);
    self.badplace = createnavobstaclebybounds(self.origin, (250, 250, 250), (0, 0, 0));
  }
}

_id_55271C4EE21EF03C(usingplayer) {
  foreach(player in level.players) {
    if(player == usingplayer) {
      continue;
    }
    _id_36C12D04A03471D6 = player getmovingplatformparent();

    if(isDefined(_id_36C12D04A03471D6) && (_id_36C12D04A03471D6 == self || _id_36C12D04A03471D6 == self.clip))
      return 1;
  }

  return 0;
}

_id_108434FCD23138A0(_id_E3108E412AFB3811) {
  if(getdvarint("dvar_6E5541CC7B215E50", 0) > 0) {
    return;
  }
  if(istrue(_id_E3108E412AFB3811)) {
    self setclientomnvar("ui_toggle_third_person", 1);
    _id_309D0C57EE3E59E8(1);
    scripts\engine\utility::delaythread(1, scripts\engine\utility::send_notify, "update_flashlight_tags");
  } else if(!istrue(self._id_911B640702FEC71A)) {
    self setclientomnvar("ui_toggle_third_person", 0);
    _id_309D0C57EE3E59E8(0);
  }
}

_id_309D0C57EE3E59E8(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811))
    self setcamerathirdperson(1);
  else {
    self setcamerathirdperson(0);
    self _meth_5762CF97C6F1A2C1("none");
  }
}

_id_F77577B854565881() {
  self endon("disconnect");

  for(;;) {
    _id_1AFED0877937F203 = self getcurrentprimaryweapon();

    if(_id_1AFED0877937F203.basename == "none") {
      waitframe();
      continue;
    }

    if(_id_1AFED0877937F203.basename != "iw9_me_pushfists") {
      self _meth_A63E26425EF807D6(1);
      self giveweapon("iw9_me_pushfists");
      self switchtoweaponimmediate("iw9_me_pushfists");
      _id_3B64EB40368C1450::set("pushing", "weapon_switch", 0);
      self._id_D23A4C6C080BEE59 = _id_1AFED0877937F203;
    } else
      break;

    if(isDefined(self._id_D23A4C6C080BEE59)) {
      break;
    }

    waitframe();
  }
}

_id_9BE10E56442B7EC8() {
  if(istrue(self._id_961D41C9EF7657B5)) {
    return;
  }
  if(scripts\engine\utility::flag_exist("p0_finished") && scripts\engine\utility::flag("p0_finished")) {
    self playSound("evt_raid3_toolbox_push_uw_start");
    thread _id_D39192CCEC1518AA();
  } else {
    self playSound("evt_raid3_toolbox_push_start");
    thread _id_D39192CCEC1518AA();
  }
}

_id_D39192CCEC1518AA() {
  self._id_961D41C9EF7657B5 = 1;

  if(scripts\engine\utility::flag_exist("p0_finished") && scripts\engine\utility::flag("p0_finished")) {
    self playLoopSound("evt_raid3_toolbox_push_uw_lp");
    self waittill("stoploopsound");
    self stoploopsound();
    self playSound("evt_raid3_toolbox_push_uw_stop");
  } else {
    self playLoopSound("evt_raid3_toolbox_push_lp");
    self waittill("stoploopsound");
    self stoploopsound();
    self playSound("evt_raid3_toolbox_push_stop");
  }

  self._id_961D41C9EF7657B5 = undefined;
}

_id_EC47816DFE1F6B84(val) {
  _id_3B64EB40368C1450::set("pushing", "prone", val);
  _id_3B64EB40368C1450::set("pushing", "crouch", val);
  _id_3B64EB40368C1450::set("pushing", "allow_jump", val);
  _id_3B64EB40368C1450::set("pushing", "fire", val);
  _id_3B64EB40368C1450::set("pushing", "ads", val);
  _id_3B64EB40368C1450::set("pushing", "sprint", val);
  _id_3B64EB40368C1450::set("pushing", "melee", val);
  _id_3B64EB40368C1450::set("pushing", "reload", val);
  _id_3B64EB40368C1450::set("pushing", "lean", val);
  _id_3B64EB40368C1450::set("pushing", "slide", val);
  _id_3B64EB40368C1450::set("pushing", "offhand_weapons", val);
  _id_3B64EB40368C1450::set("pushing", "usability", val);
}

_id_5466E10C15EA95C6(player, _id_A137E502148A0CBC) {
  fwd = undefined;
  up = undefined;

  switch (_id_A137E502148A0CBC) {
    case "usable_left":
      fwd = anglestoright(self.angles) * 32;
      up = anglestoup(self.angles) * 45;
      break;
    case "usable_right":
      fwd = anglestoright(self.angles) * -32;
      up = anglestoup(self.angles) * 45;
      break;
    case "usable_front":
      fwd = anglesToForward(self.angles) * 28;
      up = anglestoup(self.angles) * 45;
      break;
    case "usable_rear":
      fwd = anglesToForward(self.angles) * -28;
      up = anglestoup(self.angles) * 45;
      break;
  }

  if(!isDefined(fwd) || !isDefined(up))
    return 0;

  contents = scripts\engine\trace::create_contents(1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0);
  ignoreents = scripts\engine\utility::array_combine(level.players, [self, self.clip]);
  _id_01322FC0232D294B = scripts\engine\trace::sphere_trace_passed(self.origin + fwd + (0, 0, 30), self.origin + fwd + (0, 0, 30), 26, ignoreents, contents);
  return _id_01322FC0232D294B && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + fwd + up, [self.clip]);
}