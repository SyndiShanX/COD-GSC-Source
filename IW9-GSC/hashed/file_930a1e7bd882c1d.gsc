/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_930a1e7bd882c1d.gsc
***********************************************/

spawn_script_model(modelname, animname, _id_31093158B2292193) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);

  if(!isDefined(animname))
    animname = modelname;

  model.animname = animname;

  if(isDefined(_id_31093158B2292193)) {
    model.linkedents = [];

    foreach(_id_C30D717B67553796 in _id_31093158B2292193) {
      extra = spawn("script_model", self.origin);
      extra setModel(_id_C30D717B67553796[0]);
      extra forcenetfieldhighlod(1);
      extra linkTo(model, _id_C30D717B67553796[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

  return model;
}

_id_C880EDBA9FACE762(_id_0E25D1D189177A7C) {
  _id_5C3C95908409974F = "infil_" + _id_0E25D1D189177A7C + "_light_origin";
  _id_EF5F42DC3BAE2A88 = scripts\engine\utility::getStruct(_id_5C3C95908409974F, "targetname");

  if(!isDefined(level._id_B71CF533392C0371))
    level._id_B71CF533392C0371 = [];

  level._id_B71CF533392C0371[_id_5C3C95908409974F] = _id_EF5F42DC3BAE2A88;
}

_id_FCE988291DBC4649(_id_0E25D1D189177A7C) {
  if(!isDefined(level._id_B71CF533392C0371))
    return undefined;

  _id_5C3C95908409974F = "infil_" + _id_0E25D1D189177A7C + "_light_origin";
  return level._id_B71CF533392C0371[_id_5C3C95908409974F];
}

_id_8C2D124DBEF4FA60(_id_0E25D1D189177A7C, _id_599217E02A6DA3FA) {
  rig = spawnStruct();
  _id_5E0676140EECDF2D = "infil_" + _id_0E25D1D189177A7C + "_probe";
  _id_4AE45078DF12C7A7 = "infil_" + _id_0E25D1D189177A7C + "_light";
  _id_83D076584339CBE2 = getEntArray(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");
  _id_EF5F42DC3BAE2A88 = _id_FCE988291DBC4649(_id_0E25D1D189177A7C);

  if(!isDefined(_id_83D076584339CBE2))
    return undefined;

  foreach(probe in _id_83D076584339CBE2) {
    if(!isDefined(probe))
      return undefined;
  }

  if(!isDefined(lights))
    return undefined;

  foreach(light in lights) {
    if(!isDefined(light))
      return undefined;
  }

  if(!isDefined(_id_EF5F42DC3BAE2A88))
    return undefined;

  _id_FAB0539668DBA4B7 = _id_EF5F42DC3BAE2A88.origin;
  _id_3694A4E650566A39 = _id_EF5F42DC3BAE2A88.angles;

  if(!isDefined(_id_3694A4E650566A39))
    _id_3694A4E650566A39 = (0, 0, 0);

  foreach(probe in _id_83D076584339CBE2) {
    if(!isDefined(probe.origin_offset) && !isDefined(probe.angles_offset)) {
      _id_542E3E93B710380F = probe.origin;
      _id_7434C0613F2501B1 = probe.angles;

      if(!isDefined(_id_7434C0613F2501B1))
        _id_7434C0613F2501B1 = (0, 0, 0);

      probe.origin_offset = _id_542E3E93B710380F - _id_FAB0539668DBA4B7;
      probe.angles_offset = _id_7434C0613F2501B1 - _id_3694A4E650566A39;
    }
  }

  foreach(light in lights) {
    if(!isDefined(light.origin_offset) && !isDefined(light.angles_offset)) {
      _id_24CD9408147D26C5 = light.origin;
      _id_658DC910DD6C771B = light.angles;

      if(!isDefined(light.angles))
        _id_658DC910DD6C771B = (0, 0, 0);

      light.origin_offset = _id_24CD9408147D26C5 - _id_FAB0539668DBA4B7;
      light.angles_offset = _id_658DC910DD6C771B - _id_3694A4E650566A39;
    }
  }

  rig._id_83D076584339CBE2 = _id_83D076584339CBE2;
  rig.lights = lights;
  rig._id_599217E02A6DA3FA = _id_599217E02A6DA3FA;
  _id_89A2405953B84136(rig, 1);
  return rig;
}

_id_89A2405953B84136(rig, _id_AC17789997E5B858) {
  if(!isDefined(rig)) {
    return;
  }
  foreach(probe in rig._id_83D076584339CBE2)
  probe hide();

  foreach(light in rig.lights) {
    if(_id_AC17789997E5B858 && !isDefined(light.original_intensity))
      light.original_intensity = light getlightintensity();

    light setlightintensity(0.0);
  }
}

create_animpack(anime, _id_79D924275E2B5029) {
  pack = spawnStruct();
  pack.ents = [];
  pack._id_FB299ADFD0F8BFC5 = [];
  pack._id_6F8E05E25EB697A4 = [];
  pack._id_3BD5282B118D27F8 = [];
  pack._id_5BA8DB57A9811D96 = [];
  pack.anime = anime;
  pack._id_79D924275E2B5029 = istrue(_id_79D924275E2B5029);
  return pack;
}

_id_2D4C340DD3908B2D(fov) {
  self.fov = fov;
}

_id_B8F86028BCC64F84(fstop, _id_ED8206FEF1806FEF, focusspeed, aperturespeed, _id_C06551440B16249C) {
  self.fstop = fstop;
  self._id_ED8206FEF1806FEF = _id_ED8206FEF1806FEF;
  self.focusspeed = focusspeed;
  self.aperturespeed = aperturespeed;
  self._id_C06551440B16249C = _id_C06551440B16249C;
}

add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self._id_C65BB75CCE61100F = paramarray;
}

_id_E718BA63D511FCDE(paramarray, func) {
  self._id_EEDB5FB15EB26BFA = func;
  self._id_5AB13B55D7CEFF80 = paramarray;
}

add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  level.scr_animname[ent.animname][self.anime] = getanimname(animation);
  self.ents[self.ents.size] = ent;
}

_id_A44BDAB6357B7210(ent) {
  self._id_FB299ADFD0F8BFC5[self._id_FB299ADFD0F8BFC5.size] = ent;
}

_id_707983B9FDB53C55(rig) {
  self._id_5BA8DB57A9811D96[self._id_5BA8DB57A9811D96.size] = rig;
}

_id_AD0BCAC98781E0AB(ent, animation, _id_1EF3B90415513455) {
  index = self._id_6F8E05E25EB697A4.size;
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.ent = ent;
  _id_A7B23DAE3BCFE5F8.animation = animation;
  _id_A7B23DAE3BCFE5F8.animname = getanimname(animation);

  if(isDefined(_id_1EF3B90415513455)) {
    _id_A7B23DAE3BCFE5F8._id_68C4C5A108F84E4F = _id_1EF3B90415513455;
    _id_A7B23DAE3BCFE5F8._id_1FC8EFB020E9A71D = getanimname(_id_1EF3B90415513455);
  }

  self._id_6F8E05E25EB697A4[index] = _id_A7B23DAE3BCFE5F8;
}

_id_F7FC8B110C478968(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  level.scr_animname[ent.animname][self.anime] = getanimname(animation);
  self._id_3BD5282B118D27F8[self._id_3BD5282B118D27F8.size] = ent;
}

_id_D4561AB1BA4F5DE9(ent, _id_E6783D526B4A7212, animation, _id_437B6BB41D98DF26, _id_75A7646007505356) {
  self._id_2336099A20080602 = spawnStruct();
  self._id_2336099A20080602.ent = ent;
  self._id_2336099A20080602._id_E6783D526B4A7212 = _id_E6783D526B4A7212;

  if(isDefined(_id_437B6BB41D98DF26)) {
    self._id_2336099A20080602._id_437B6BB41D98DF26 = _id_437B6BB41D98DF26;
    self._id_2336099A20080602._id_75A7646007505356 = _id_75A7646007505356;

    if(!self._id_79D924275E2B5029) {
      _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(_id_437B6BB41D98DF26);
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - 0.033;
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - scripts\engine\utility::mod(_id_8355076D4ED3FC96, 0.05);
      self._id_2336099A20080602._id_8355076D4ED3FC96 = _id_8355076D4ED3FC96;
    }
  } else if(!self._id_79D924275E2B5029)
    self._id_2336099A20080602.animlength = getanimlength(animation);
}

add_pack_fx(_id_8C44BF99399EDF9A, origin, angles) {
  self.fx = _id_8C44BF99399EDF9A;
  self.fxorigin = origin;
  self.fxangles = angles;
}

add_pack_playeranim(player, _id_F8896CB359EAB159, _id_B1E61449DA6BA188) {
  if(!isDefined(player)) {
    return;
  }
  animname = undefined;

  if(!isDefined(player.brexfilanimname)) {
    animname = "player" + player getentitynumber();
    player.animname = animname;
    player.brexfilanimname = animname;
  } else
    animname = player.brexfilanimname;

  animation = _id_F8896CB359EAB159;

  if(isDefined(_id_B1E61449DA6BA188)) {
    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female")
      animation = _id_B1E61449DA6BA188;
  }

  level.scr_anim[animname][self.anime] = animation;
  level.scr_eventanim[animname][self.anime] = getanimname(animation);
  self.players[self.players.size] = player;
}

_id_AD12D29D41483E8A(statename, func) {
  level.infilstruct._id_E7C7DE60A5EA2F52[statename] = func;
}

_id_226E337633A44059(_id_4F748FB021262DBA, _id_C242A4A69C2BEED3) {
  level.infilstruct._id_6D575C4DFA5D6788 = _id_4F748FB021262DBA;

  if(isDefined(_id_C242A4A69C2BEED3))
    level.infilstruct._id_AD3C883FBFF215B5 = _id_C242A4A69C2BEED3;
  else
    level.infilstruct._id_AD3C883FBFF215B5 = undefined;
}

_id_0F18696AC7694ED9() {
  if(isDefined(level.infilstruct._id_AD3C883FBFF215B5) && isDefined(self._id_DB122A8941DFEE14) && self._id_DB122A8941DFEE14 == 1)
    return level.infilstruct._id_AD3C883FBFF215B5;

  if(isarray(level.infilstruct._id_6D575C4DFA5D6788)) {
    _id_015314DA30B44470 = 0;

    if(isDefined(self.infilanimindex))
      _id_015314DA30B44470 = self.infilanimindex - 1;

    return level.infilstruct._id_6D575C4DFA5D6788[_id_015314DA30B44470];
  }

  return level.infilstruct._id_6D575C4DFA5D6788;
}

allplayers_setfov(fov) {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientdvar("cg_fov", fov);
    player setclientdvar("cg_disable_user_fov", 1);
  }
}

_id_CF47AB3F9DEFE35B() {
  if(istrue(level.infilstruct._id_012C912EE9672FA1)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      player setclientdvar("cg_fov", 65.0);
      player setclientdvar("cg_fov_viewmodel", 65.0);
    }
  } else {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      player setclientdvar("cg_fov", 65.0);
      player setclientdvar("cg_fov_viewmodel", 65.0);
      player setclientdvar("cg_disable_user_fov", 0);
    }
  }
}

allplayers_setphysicaldof(fstop, _id_ED8206FEF1806FEF, focusspeed, aperturespeed, _id_C06551440B16249C) {
  if(!isDefined(focusspeed))
    focusspeed = 100;

  if(!isDefined(aperturespeed))
    aperturespeed = 100;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player._id_1F0A019572C9F8E2)) {
      player._id_1F0A019572C9F8E2 = 1;
      player enablephysicaldepthoffieldscripting();
    }

    if(isDefined(_id_C06551440B16249C)) {
      player setphysicaldepthoffield(fstop, _id_ED8206FEF1806FEF, focusspeed, aperturespeed, _id_C06551440B16249C);
      continue;
    }

    if(isDefined(aperturespeed)) {
      player setphysicaldepthoffield(fstop, _id_ED8206FEF1806FEF, focusspeed, aperturespeed);
      continue;
    }

    if(isDefined(focusspeed)) {
      player setphysicaldepthoffield(fstop, _id_ED8206FEF1806FEF, focusspeed);
      continue;
    }

    player setphysicaldepthoffield(fstop, _id_ED8206FEF1806FEF);
  }
}

allplayers_clearphysicaldof() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player._id_1F0A019572C9F8E2)) {
      player._id_1F0A019572C9F8E2 = undefined;
      player disablephysicaldepthoffieldscripting();
    }
  }
}

_id_D328D1B2BD6822BD(_id_CD1BD4A1058452DA) {
  overlay = newhudelem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay setshowinrealism(1);
  level.infilblackoverlay = overlay;

  if(isDefined(_id_CD1BD4A1058452DA) && _id_CD1BD4A1058452DA > 0) {
    level.infilblackoverlay.alpha = 0;
    level.infilblackoverlay fadeovertime(_id_CD1BD4A1058452DA);
    level.infilblackoverlay.alpha = 1;
  } else
    level.infilblackoverlay.alpha = 1;
}

_id_32BC1D39BF81CE95(_id_1BB7594C18D17443) {
  if(isDefined(_id_1BB7594C18D17443) && _id_1BB7594C18D17443 > 0) {
    level.infilblackoverlay.alpha = 1;
    level.infilblackoverlay fadeovertime(_id_1BB7594C18D17443);
    level.infilblackoverlay.alpha = 0;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player clearsoundsubmix("deaths_door_mp");
      player notify("deaths_door_exit");
      player clearsoundsubmix("mp_br_lobby_fade", 0.0);
    }
  } else
    level.infilblackoverlay.alpha = 0;
}

_id_743F088F49CCC99D() {
  level.infilblackoverlay destroy();
  level.infilblackoverlay = undefined;
}

_id_EA856EC0B3C4CFC6(_id_CD1BD4A1058452DA, players, _id_9031C2D2B6B6D7F4) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_10F93BB3F3966751(_id_CD1BD4A1058452DA, _id_9031C2D2B6B6D7F4);
  }
}

_id_10F93BB3F3966751(_id_CD1BD4A1058452DA, _id_9031C2D2B6B6D7F4) {
  _id_A38B2E30E799E9B7(_id_CD1BD4A1058452DA, _id_9031C2D2B6B6D7F4);
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::_id_6D5206BDBA79E8C3(self);

  if(_id_721982228624D657.size > 0) {
    foreach(_id_FF3FE241243B175B in _id_721982228624D657)
    _id_FF3FE241243B175B _id_A38B2E30E799E9B7(_id_CD1BD4A1058452DA, _id_9031C2D2B6B6D7F4);
  }
}

_id_A38B2E30E799E9B7(_id_CD1BD4A1058452DA, _id_9031C2D2B6B6D7F4) {
  if(!isDefined(self._id_CD09849E16631C71))
    self._id_CD09849E16631C71 = [];

  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay.archived = 0;
  overlay setshowinrealism(1);

  if(isDefined(_id_CD1BD4A1058452DA) && _id_CD1BD4A1058452DA > 0) {
    overlay.alpha = 0;
    overlay fadeovertime(_id_CD1BD4A1058452DA);
    overlay.alpha = 1;
  } else
    overlay.alpha = 1;

  self._id_CD09849E16631C71[_id_9031C2D2B6B6D7F4] = overlay;
}

_id_7F3AD8FE6DF1B8FE(_id_1BB7594C18D17443, players, _id_9031C2D2B6B6D7F4) {
  level thread _id_6B9A694AC71B6342(_id_1BB7594C18D17443, players, _id_9031C2D2B6B6D7F4);
}

_id_6B9A694AC71B6342(_id_1BB7594C18D17443, players, _id_9031C2D2B6B6D7F4) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_1162DBFDB942D179(_id_1BB7594C18D17443, _id_9031C2D2B6B6D7F4);
    _id_721982228624D657 = _id_6489FCDFE6FA2E36::_id_6D5206BDBA79E8C3(player);

    if(_id_721982228624D657.size > 0) {
      foreach(_id_FF3FE241243B175B in _id_721982228624D657)
      _id_FF3FE241243B175B _id_1162DBFDB942D179(_id_1BB7594C18D17443, _id_9031C2D2B6B6D7F4);
    }
  }

  wait(_id_1BB7594C18D17443);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_046B5C06F8D7AC31(_id_9031C2D2B6B6D7F4);
    _id_721982228624D657 = _id_6489FCDFE6FA2E36::_id_6D5206BDBA79E8C3(player);

    if(_id_721982228624D657.size > 0) {
      foreach(_id_FF3FE241243B175B in _id_721982228624D657)
      _id_FF3FE241243B175B _id_046B5C06F8D7AC31(_id_9031C2D2B6B6D7F4);
    }
  }
}

_id_1162DBFDB942D179(_id_1BB7594C18D17443, _id_9031C2D2B6B6D7F4) {
  overlay = self._id_CD09849E16631C71[_id_9031C2D2B6B6D7F4];

  if(isDefined(_id_1BB7594C18D17443) && _id_1BB7594C18D17443 > 0) {
    if(isDefined(overlay)) {
      overlay.alpha = 1;
      overlay fadeovertime(_id_1BB7594C18D17443);
      overlay.alpha = 0;
    }

    self clearsoundsubmix("deaths_door_mp");
    self clearsoundsubmix("mp_br_lobby_fade", 0.0);
  } else if(isDefined(overlay))
    overlay.alpha = 0;
}

_id_046B5C06F8D7AC31(_id_9031C2D2B6B6D7F4) {
  self._id_CD09849E16631C71[_id_9031C2D2B6B6D7F4] destroy();
  self._id_CD09849E16631C71[_id_9031C2D2B6B6D7F4] = undefined;

  if(self._id_CD09849E16631C71.size == 0)
    self._id_CD09849E16631C71 = undefined;
}

_id_4238C1C62B656B65() {
  if(getdvarint("dvar_4467D7E1CB69C4FD", 1) == 0) {
    return;
  }
  if(!isDefined(self._id_CD09849E16631C71)) {
    return;
  }
  foreach(overlay in self._id_CD09849E16631C71) {
    overlay destroy();
    overlay = undefined;
  }

  self._id_CD09849E16631C71 = undefined;
}

endprematchskydiving() {
  _id_98EAF83FC88A156E = 5;
  player = self;
  player skydive_setdeploymentstatus(0);
  player skydive_setbasejumpingstatus(0);

  if(isDefined(player.ffsm_state))
    player.ffsm_state = _id_98EAF83FC88A156E;

  player scripts\cp_mp\parachute::parachutecleanup();
}

_id_2B9BBF8169114D2E() {
  return getdvarint("dvar_9F312D7BE58E5170", 0) == 1;
}

_id_583F118C4064CA21(players) {
  _id_1B99E9AA1B149E01 = 0;
  _id_2C13B756B0AA6DCF = isDefined(players) && players.size != level.players.size;

  foreach(team in level.teamnamelist) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(index, player in _id_A6AB8D0FDA441DC2) {
      if(_id_2C13B756B0AA6DCF && !scripts\engine\utility::array_contains(players, player)) {
        continue;
      }
      if(!_id_75377E59F5BECAC8::_id_60597DA56F99D304(player)) {
        continue;
      }
      player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_util::refreshTeamVisibility()");

      if(!_id_1B99E9AA1B149E01 && !_id_2B9BBF8169114D2E()) {
        foreach(_id_6EE5484560EC747C in _id_A6AB8D0FDA441DC2)
        player showtoplayer(_id_6EE5484560EC747C);
      }

      if(_id_2B9BBF8169114D2E())
        player showtoplayer(player);
    }
  }
}

_id_423115ED15F21E05(team) {
  _id_1B99E9AA1B149E01 = 0;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(index, player in _id_A6AB8D0FDA441DC2) {
    if(!_id_75377E59F5BECAC8::_id_60597DA56F99D304(player)) {
      continue;
    }
    player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_util::refreshTeamVisibilityForTeam()");

    if(!_id_1B99E9AA1B149E01 && !_id_2B9BBF8169114D2E()) {
      foreach(_id_6EE5484560EC747C in _id_A6AB8D0FDA441DC2)
      player showtoplayer(_id_6EE5484560EC747C);
    }

    if(_id_2B9BBF8169114D2E())
      player showtoplayer(player);
  }
}

registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4) {
  if(!istrue(_id_FC8439660D24B9C4.jumpcomandsregistered)) {
    _id_FC8439660D24B9C4.jumpcomandsregistered = 1;
    _id_FC8439660D24B9C4 _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", 2);
    _id_FC8439660D24B9C4 notifyonplayercommand("halo_jump_c130", "+gostand");
    _id_FC8439660D24B9C4 notifyonplayercommand("br_break_squad", "+breath_sprint");
  }
}

watchbrsquadleaderdisconnect(team) {
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_FC8439660D24B9C4 = setupbrsquadleader(_id_A6AB8D0FDA441DC2);

  if(isDefined(_id_FC8439660D24B9C4)) {
    registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4);
    _id_FC8439660D24B9C4 thread watchbrsquadleaderdisconnect(team);
  }
}

setupbrsquadleader(_id_A6AB8D0FDA441DC2) {
  if(_id_A6AB8D0FDA441DC2.size == 0)
    return undefined;

  _id_FC8439660D24B9C4 = undefined;

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player) && player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
      return player;
  }

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(level.onlinegame && player isfireteamleader()) {
      _id_FC8439660D24B9C4 = player;
      break;
    }
  }

  if(!isDefined(_id_FC8439660D24B9C4)) {
    _id_11A39090E204313A = 0;
    _id_0AB2CF4A4734BD50 = 0;

    foreach(player in _id_A6AB8D0FDA441DC2) {
      _id_921910F60D54CFA6 = _id_11A39090E204313A == isbot(player);

      if(_id_921910F60D54CFA6) {
        _id_0AB2CF4A4734BD50++;
        _id_54A63825D837AFE3 = 1.0 / _id_0AB2CF4A4734BD50;

        if(randomfloat(1.0) < _id_54A63825D837AFE3)
          _id_FC8439660D24B9C4 = player;
      }
    }
  }

  if(!isDefined(_id_FC8439660D24B9C4)) {
    foreach(player in _id_A6AB8D0FDA441DC2) {
      _id_FC8439660D24B9C4 = player;
      break;
    }
  }

  if(!isDefined(_id_FC8439660D24B9C4))
    return undefined;

  _id_FC8439660D24B9C4 _id_1E4A61DB11011446::setplayerbrsquadleader(1);

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(player != _id_FC8439660D24B9C4)
      player _id_1E4A61DB11011446::setplayerbrsquadleader(0);

    _id_D9CDB46DAE44D57B = scripts\engine\utility::ter_op(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader(), 2, 1);
    _id_45B2B4A889E633FA::setteammateomnvarsforplayer(player, _id_A6AB8D0FDA441DC2, _id_D9CDB46DAE44D57B);
  }

  return _id_FC8439660D24B9C4;
}

_id_6D8AC534AD288AA5(player) {
  _id_384446A35F40358C = undefined;
  _id_F5B09A636E6E3153 = [1, 2, 3, 4];
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");
  player._id_DB122A8941DFEE14 = _id_A6AB8D0FDA441DC2.size;

  foreach(_id_736D8D9188CCBD45 in _id_A6AB8D0FDA441DC2) {
    if(_id_736D8D9188CCBD45 == player) {
      continue;
    }
    if(isDefined(_id_736D8D9188CCBD45.infilanimindex))
      _id_F5B09A636E6E3153 = scripts\engine\utility::array_remove(_id_F5B09A636E6E3153, _id_736D8D9188CCBD45.infilanimindex);

    if(_id_736D8D9188CCBD45 _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
      _id_F5B09A636E6E3153 = scripts\engine\utility::array_remove(_id_F5B09A636E6E3153, 1);
  }

  if(_id_F5B09A636E6E3153.size == 0)
    _id_F5B09A636E6E3153[0] = 1;

  player.infilanimindex = _id_F5B09A636E6E3153[0];
}

getinfilspawnoffset() {
  return getdvarfloat("scr_br_dropspawnoffsetminz", 12000);
}

_id_8663DA4077FA7E20() {
  _id_B57AACAF2CC7095F = 1;
  return _id_B57AACAF2CC7095F;
}

waitandpause(_id_80B642A0F8C9659D) {
  wait(_id_80B642A0F8C9659D);
}

_id_6199C35F4CF4524C(func) {
  level._id_16DA1E546DC92A4C[level._id_16DA1E546DC92A4C.size] = func;
}