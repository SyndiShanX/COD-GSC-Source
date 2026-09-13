/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ending_util.gsc
***************************************************/

create_animpack(anime) {
  pack = spawnStruct();
  pack.ents = [];
  pack.players = [];
  pack.cam = undefined;
  pack._id_5BA8DB57A9811D96 = [];
  pack.anime = anime;
  pack.packs = [];
  return pack;
}

_id_5C32248DFFFAC064() {
  if(!getdvarint("dvar_88262F900B40E276", 0)) {
    return;
  }
  self._id_52738E0A99ED242B = 1;
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

add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  level.scr_animname[ent.animname][self.anime] = getanimname(animation);
  self.ents[self.ents.size] = ent;
}

add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self.paramarray = paramarray;
}

_id_DECF1E23D78D0944(paramarray, func) {
  self.endfunc = func;
  self._id_315361ABD838FAD4 = paramarray;
}

_id_E718BA63D511FCDE(paramarray, func) {
  self._id_EEDB5FB15EB26BFA = func;
  self._id_5AB13B55D7CEFF80 = paramarray;
}

_id_6098F3014CD4C598(_id_56508E6F58221410) {
  self._id_56508E6F58221410 = _id_56508E6F58221410;
}

_id_6372AFDC0E9EE2DD(_id_9AB9FEFE4D2846B1) {
  self._id_9AB9FEFE4D2846B1 = _id_9AB9FEFE4D2846B1;
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

  self.players[self.players.size] = player;
  animation = _id_F8896CB359EAB159;

  if(isDefined(_id_B1E61449DA6BA188)) {
    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female")
      animation = _id_B1E61449DA6BA188;
  }

  level.scr_anim[animname][self.anime] = animation;
  level.scr_eventanim[animname][self.anime] = getanimname(animation);
}

add_pack_camanim(animation, _id_437B6BB41D98DF26) {
  self.cam = 1;
  level.scr_anim["endingCam"][self.anime] = animation;
  self._id_437B6BB41D98DF26 = _id_437B6BB41D98DF26;
}

add_pack_fx(_id_8C44BF99399EDF9A, origin, angles) {
  self.fx = _id_8C44BF99399EDF9A;
  self.fxorigin = origin;
  self.fxangles = angles;
}

_id_707983B9FDB53C55(rig) {
  self._id_5BA8DB57A9811D96[self._id_5BA8DB57A9811D96.size] = rig;
}

#using_animtree("script_model");

spawn_script_model(modelname, animname, _id_31093158B2292193) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);

  if(!isDefined(animname))
    animname = modelname;

  model.animname = animname;
  model useanimtree(#animtree);

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

_id_38C7F6BC1DEEF269(modelname, animname, vehicletype) {
  if(!isDefined(animname))
    animname = modelname;

  vehicle = spawnVehicle(modelname, animname, vehicletype, self.origin, self.angles);
  vehicle.animname = animname;
  vehicle._id_90ACDD32579DCB16 = 1;
  vehicle.vehiclename = vehicletype;
  vehicle setCanDamage(0);

  if(vehicle vehicle_isphysveh()) {
    vehicle _meth_247AD6A91F6A4FFE(1);
    vehicle vehphys_forcekeyframedmotion();
  } else
    vehicle notsolid();

  vehicle vehicle_turnengineoff();
  vehicle _meth_97E11A84480635BC(1);
  return vehicle;
}

_id_C880EDBA9FACE762(_id_0E25D1D189177A7C) {
  _id_5C3C95908409974F = "exfil_" + _id_0E25D1D189177A7C + "_light_origin";
  _id_EF5F42DC3BAE2A88 = scripts\engine\utility::getStruct(_id_5C3C95908409974F, "targetname");

  if(!isDefined(level._id_B71CF533392C0371))
    level._id_B71CF533392C0371 = [];

  level._id_B71CF533392C0371[_id_5C3C95908409974F] = _id_EF5F42DC3BAE2A88;
}

_id_FCE988291DBC4649(_id_0E25D1D189177A7C) {
  if(!isDefined(level._id_B71CF533392C0371))
    return undefined;

  _id_5C3C95908409974F = "exfil_" + _id_0E25D1D189177A7C + "_light_origin";
  return level._id_B71CF533392C0371[_id_5C3C95908409974F];
}

_id_8C2D124DBEF4FA60(_id_0E25D1D189177A7C, _id_599217E02A6DA3FA) {
  rig = spawnStruct();
  _id_5E0676140EECDF2D = "exfil_" + _id_0E25D1D189177A7C + "_probe";
  _id_4AE45078DF12C7A7 = "exfil_" + _id_0E25D1D189177A7C + "_light";
  _id_83D076584339CBE2 = getEntArray(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");
  _id_EF5F42DC3BAE2A88 = _id_FCE988291DBC4649(_id_0E25D1D189177A7C);

  if(!isDefined(_id_83D076584339CBE2))
    return undefined;

  foreach(_id_AC0E424AC96A7113 in _id_83D076584339CBE2) {
    if(!isDefined(_id_AC0E424AC96A7113))
      return undefined;
  }

  if(!isDefined(lights))
    return undefined;

  foreach(_id_AC0E5E4AC96AAEA7 in lights) {
    if(!isDefined(_id_AC0E5E4AC96AAEA7))
      return undefined;
  }

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

add_pack_characteranim(modelname, _id_31093158B2292193, animation, _id_F34379ACBA78A66B, _id_A8542244FDA27657) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);
  model useanimtree(#animtree);

  if(isDefined(_id_A8542244FDA27657))
    animname = _id_A8542244FDA27657;
  else
    animname = modelname;

  model.animname = animname;
  level.scr_anim[model.animname]["br_ending"] = animation;

  if(isDefined(_id_F34379ACBA78A66B))
    level.scr_animname[model.animname]["br_ending"] = _id_F34379ACBA78A66B;

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

  self.pack.models[self.pack.models.size] = model;
  return model;
}

allplayers_setphysicaldof(fstop, _id_ED8206FEF1806FEF, focusspeed, aperturespeed, _id_C06551440B16249C) {
  if(!isDefined(focusspeed))
    focusspeed = 100;

  if(!isDefined(aperturespeed))
    aperturespeed = 100;

  foreach(player in level.players) {
    if(!isDefined(player.scriptedphysicaldofenabled)) {
      player.scriptedphysicaldofenabled = 1;
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

allplayers_setfov(fov) {
  foreach(player in level.players) {
    player setclientdvar("cg_fov", fov);
    player setclientdvar("cg_disable_user_fov", 1);
  }
}

_id_CF47AB3F9DEFE35B() {
  foreach(player in level.players) {
    player setclientdvar("cg_fov", 65.0);
    player setclientdvar("cg_fov_viewmodel", 65.0);
    player setclientdvar("cg_disable_user_fov", 0);
  }
}

allplayers_clearphysicaldof() {
  foreach(player in level.players) {
    if(isDefined(player.scriptedphysicaldofenabled)) {
      player.scriptedphysicaldofenabled = undefined;
      player disablephysicaldepthoffieldscripting();
    }
  }
}

chopperexfil_set_brcircle() {
  if(!isDefined(level.br_circle)) {
    return;
  }
  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }
  level.br_circle.dangercircleent brcirclemoveTo(self.origin[0], self.origin[1], 9000, 0.05);
}

create_disconnectplayer(animstruct) {
  _id_382D2566050DE89A = spawn("script_model", self.origin);
  _id_382D2566050DE89A setModel("tag_origin");
  _id_382D2566050DE89A forcenetfieldhighlod(1);
  _id_382D2566050DE89A.isdisconnectplayer = 1;
  _id_382D2566050DE89A.brexfilanimname = "player0";
  _id_382D2566050DE89A.origin = animstruct.origin;
  _id_382D2566050DE89A.angles = animstruct.angles;
  _id_382D2566050DE89A create_player_rig(_id_382D2566050DE89A.brexfilanimname, "viewhands_base_iw8", animstruct);

  if(getdvarint("dvar_BC95D8892007EBFD", 1))
    _id_382D2566050DE89A _id_050962E9F971266E(_id_382D2566050DE89A.brexfilanimname, animstruct.origin);

  _id_382D2566050DE89A linkTo(_id_382D2566050DE89A.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  level thread ending_player_disconnect_thread(_id_382D2566050DE89A, 1);
  animstruct.winners[0] = _id_382D2566050DE89A;
}

ending_player_disconnect_thread(player, _id_8D259C975723AEDC) {
  rig = player.player_rig;
  _id_A0B64BD11AA5B217 = isPlayer(player);

  if(!isDefined(_id_8D259C975723AEDC))
    player waittill("disconnect");
  else
    wait 0.1;

  if(!isDefined(rig)) {
    return;
  }
  if(getdvarint("dvar_BC95D8892007EBFD", 1) && isDefined(rig._id_7D489A3282F9CCE0)) {
    rig._id_7D489A3282F9CCE0._id_0F941525E6ACDEAC = undefined;
    rig notify("update_avatar_visibility");
  } else
    playFXOnTag(scripts\engine\utility::getfx("player_disconnect"), rig, "tag_player");
}

create_cam() {
  model = spawn("script_model", self.origin);
  model setModel("tag_origin");
  model forcenetfieldhighlod(1);
  model useanimtree(#animtree);
  model.animname = "endingCam";
  return model;
}

create_player_rig(animname, _id_486DB5FA512A3B6B, animstruct, _id_40A4287D8D2E7EF9) {
  self.animname = animname;
  origin = animstruct.origin;

  if(!isDefined(origin))
    origin = (0, 0, 0);

  player_rig = spawn("script_model", origin);
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig setModel(_id_486DB5FA512A3B6B);
  self.player_rig hide();
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.winindex = self.winindex;
  self.player_rig forcenetfieldhighlod(1);
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = scripts\mp\utility\infilexfil::handledofnotetrack;

  if(!isDefined(animstruct.player_rigs))
    animstruct.player_rigs = [];

  if(isPlayer(self)) {
    self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);
    animstruct.player_rigs[animstruct.player_rigs.size] = self.player_rig;
    self.player_rig._id_6EA8E24D4901E87C = self getentitynumber();
  } else {
    self.player_rig.winindex = 0;
    self.player_rig._id_6EA8E24D4901E87C = 0;
  }

  self notify("rig_created");
}

_id_050962E9F971266E(animname, origin) {
  bodymodelname = "";
  headmodelname = "";
  gender = "";

  if(isPlayer(self) && isDefined(self.operatorcustomization)) {
    bodymodelname = self.operatorcustomization.body;
    headmodelname = self.operatorcustomization.head;
    gender = self.operatorcustomization.gender;
  } else {
    _id_0BFBF0D4002DD345 = ["milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d"];
    _id_5864EA4E21A60CD4 = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_0BFBF0D4002DD345);
    operatorref = tablelookup("operatorSkins.csv", 1, _id_5864EA4E21A60CD4, 2);
    bodymodelname = tablelookup("operatorSkins.csv", 1, _id_5864EA4E21A60CD4, 4);
    headmodelname = tablelookup("operatorSkins.csv", 1, _id_5864EA4E21A60CD4, 5);
    gender = scripts\mp\teams::getoperatorgender(operatorref);
  }

  _id_7D489A3282F9CCE0 = spawn("script_model", origin);
  _id_7D489A3282F9CCE0 setModel("fullbody_usmc_ar_br_infil");
  _id_7D489A3282F9CCE0 _meth_DD6D30B9EC87C1B3(bodymodelname, headmodelname, "iw9_avatar_scriptable_mp");
  _id_7D489A3282F9CCE0.operatorcustomization = spawnStruct();
  _id_7D489A3282F9CCE0.operatorcustomization.gender = gender;
  _id_7D489A3282F9CCE0 hide();
  _id_7D489A3282F9CCE0.animname = animname;
  _id_7D489A3282F9CCE0.winindex = self.winindex;
  _id_7D489A3282F9CCE0 forcenetfieldhighlod(1);
  weaponobj = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4", [], "none", "none");
  _id_7BC1C35C0AB292C2 = spawn("script_weapon", origin, 0, 0, weaponobj);
  _id_7BC1C35C0AB292C2 hide();
  _id_7BC1C35C0AB292C2 forcenetfieldhighlod(1);
  _id_7BC1C35C0AB292C2 linkTo(_id_7D489A3282F9CCE0, "j_gun", (0, 0, 0), (0, 0, 0));
  _id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 = _id_7BC1C35C0AB292C2;
  _id_7D489A3282F9CCE0._id_0F941525E6ACDEAC = 1;
  _id_7D489A3282F9CCE0._id_CB4F608693686CB0 = 0;
  self.player_rig._id_7D489A3282F9CCE0 = _id_7D489A3282F9CCE0;
  self.player_rig thread _id_2839481298D2E5F4();
}

_id_2839481298D2E5F4() {
  _id_7D489A3282F9CCE0 = self._id_7D489A3282F9CCE0;
  player = self.player;

  if(isPlayer(player))
    _id_7D489A3282F9CCE0._id_0F941525E6ACDEAC = 1;

  _id_7D489A3282F9CCE0._id_CB4F608693686CB0 = 0;
  self endon("death");

  for(;;) {
    self waittill("update_avatar_visibility");

    if(!isDefined(_id_7D489A3282F9CCE0)) {
      return;
    }
    _id_BD7E56573C70F3DB = !istrue(_id_7D489A3282F9CCE0._id_0F941525E6ACDEAC) && !istrue(_id_7D489A3282F9CCE0._id_CB4F608693686CB0);

    if(_id_BD7E56573C70F3DB) {
      _id_7D489A3282F9CCE0 show();

      if(isDefined(_id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2) && !istrue(_id_7D489A3282F9CCE0._id_13A06FDF296DC555))
        _id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 show();

      continue;
    }

    _id_7D489A3282F9CCE0 hide();

    if(isDefined(_id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
      _id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 hide();
  }
}

_id_E874FD3A9C016379(_id_CBB44B27D7364405, _id_0CBAF46AF6F07196) {
  if(isDefined(self._id_7D489A3282F9CCE0)) {
    self._id_7D489A3282F9CCE0._id_CB4F608693686CB0 = _id_CBB44B27D7364405;
    self._id_7D489A3282F9CCE0._id_13A06FDF296DC555 = _id_0CBAF46AF6F07196;
    self notify("update_avatar_visibility");
  }
}

remove_player_rig() {
  if(isDefined(self))
    self unlink();

  if(isDefined(self.player_rig)) {
    if(isDefined(self.player_rig._id_7D489A3282F9CCE0)) {
      if(isDefined(self.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
        self.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 delete();

      self.player_rig._id_7D489A3282F9CCE0 delete();
    }

    self.player_rig delete();
  }
}

get_center_of_array(array) {
  center = (0, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    center = (center[0] + array[_id_AC0E594AC96AA3A8].origin[0], center[1] + array[_id_AC0E594AC96AA3A8].origin[1], center[2] + array[_id_AC0E594AC96AA3A8].origin[2]);

  if(array.size != 0)
    return (center[0] / array.size, center[1] / array.size, center[2] / array.size);

  return undefined;
}

_id_3F005B301EC7F15B(_id_ACD8FAA0E7DDE1B2, _id_E26F44ACAD48DDD1, _id_C447F0AC96C38753, _id_1E2F2224127D2990, radius, height, _id_D4364A524E8A2BCD) {
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8._id_E26F44ACAD48DDD1 = _id_E26F44ACAD48DDD1;
  _id_A7B23DAE3BCFE5F8._id_C447F0AC96C38753 = _id_C447F0AC96C38753;
  _id_A7B23DAE3BCFE5F8._id_1E2F2224127D2990 = _id_1E2F2224127D2990;
  _id_A7B23DAE3BCFE5F8._id_715D3504E80C76E9 = radius;
  _id_A7B23DAE3BCFE5F8._id_C580CE41C807E164 = height;
  _id_A7B23DAE3BCFE5F8._id_D4364A524E8A2BCD = _id_D4364A524E8A2BCD;
  _id_ACD8FAA0E7DDE1B2[_id_ACD8FAA0E7DDE1B2.size] = _id_A7B23DAE3BCFE5F8;
  return _id_ACD8FAA0E7DDE1B2;
}

_id_F317A6F0AE25E3D4(_id_ACD8FAA0E7DDE1B2, modelname, _id_E26F44ACAD48DDD1, _id_C447F0AC96C38753, _id_1E2F2224127D2990, radius, _id_D4364A524E8A2BCD) {
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.modelname = modelname;
  _id_A7B23DAE3BCFE5F8._id_E26F44ACAD48DDD1 = _id_E26F44ACAD48DDD1;
  _id_A7B23DAE3BCFE5F8._id_C447F0AC96C38753 = _id_C447F0AC96C38753;
  _id_A7B23DAE3BCFE5F8._id_1E2F2224127D2990 = _id_1E2F2224127D2990;
  _id_A7B23DAE3BCFE5F8._id_C77E7A25454430DA = radius;
  _id_A7B23DAE3BCFE5F8._id_D4364A524E8A2BCD = _id_D4364A524E8A2BCD;
  _id_ACD8FAA0E7DDE1B2[_id_ACD8FAA0E7DDE1B2.size] = _id_A7B23DAE3BCFE5F8;
  return _id_ACD8FAA0E7DDE1B2;
}

_id_19AE50E23FE0625A(_id_ACD8FAA0E7DDE1B2, modelname, _id_E26F44ACAD48DDD1, _id_1E2F2224127D2990, radius, _id_5C9CB2FBE8943109, _id_D4364A524E8A2BCD) {
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.modelname = modelname;
  _id_A7B23DAE3BCFE5F8._id_E26F44ACAD48DDD1 = _id_E26F44ACAD48DDD1;
  _id_A7B23DAE3BCFE5F8._id_1E2F2224127D2990 = _id_1E2F2224127D2990;
  _id_A7B23DAE3BCFE5F8._id_C77E7A25454430DA = radius;
  _id_A7B23DAE3BCFE5F8._id_5C9CB2FBE8943109 = _id_5C9CB2FBE8943109;
  _id_A7B23DAE3BCFE5F8._id_D4364A524E8A2BCD = _id_D4364A524E8A2BCD;
  _id_ACD8FAA0E7DDE1B2[_id_ACD8FAA0E7DDE1B2.size] = _id_A7B23DAE3BCFE5F8;
  return _id_ACD8FAA0E7DDE1B2;
}

_id_C300D34E34164B6D(_id_CD1BD4A1058452DA, _id_95A318D022E623A7, _id_1BB7594C18D17443) {
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

  if(isDefined(_id_CD1BD4A1058452DA) && _id_CD1BD4A1058452DA > 0) {
    overlay.alpha = 0;
    overlay fadeovertime(_id_CD1BD4A1058452DA);
    overlay.alpha = 1;
    wait(_id_CD1BD4A1058452DA);
  } else
    overlay.alpha = 1;

  if(isDefined(_id_95A318D022E623A7) && _id_95A318D022E623A7 > 0)
    wait(_id_95A318D022E623A7);

  if(isDefined(_id_1BB7594C18D17443) && _id_1BB7594C18D17443 > 0) {
    overlay.alpha = 1;
    overlay fadeovertime(_id_1BB7594C18D17443);
    overlay.alpha = 0;
    wait(_id_1BB7594C18D17443);
  } else
    overlay.alpha = 0;

  overlay destroy();
}