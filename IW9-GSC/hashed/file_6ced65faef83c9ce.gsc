/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6ced65faef83c9ce.gsc
***********************************************/

create_animpack(anime) {
  pack = spawnStruct();
  pack.ents = [];
  pack._id_FB299ADFD0F8BFC5 = [];
  pack.anime = anime;
  pack.packs = [];
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

add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  level.scr_animname[ent.animname][self.anime] = getanimname(animation);
  self.ents[self.ents.size] = ent;
}

_id_A44BDAB6357B7210(ent) {
  self._id_FB299ADFD0F8BFC5[self._id_FB299ADFD0F8BFC5.size] = ent;
}

add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self.paramarray = paramarray;
}

_id_DECF1E23D78D0944(paramarray, func) {
  self.endfunc = func;
  self._id_315361ABD838FAD4 = paramarray;
}

add_pack_fx(_id_8C44BF99399EDF9A, origin, angles) {
  self.fx = _id_8C44BF99399EDF9A;
  self.fxorigin = origin;
  self.fxangles = angles;
}

_id_D4561AB1BA4F5DE9(ent, tag, animation, _id_437B6BB41D98DF26) {
  self._id_2336099A20080602 = spawnStruct();
  self._id_2336099A20080602.ent = ent;
  self._id_2336099A20080602.tag = tag;

  if(isDefined(_id_437B6BB41D98DF26)) {
    self._id_2336099A20080602._id_437B6BB41D98DF26 = _id_437B6BB41D98DF26;
    _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(_id_437B6BB41D98DF26);
    _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - 0.033;
    _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - scripts\engine\utility::mod(_id_8355076D4ED3FC96, 0.05);
    self._id_2336099A20080602._id_8355076D4ED3FC96 = _id_8355076D4ED3FC96;
  } else
    self._id_2336099A20080602.animlength = getanimlength(animation);
}

_id_19EA8F6D547DC8BC(player) {
  cameraent = self._id_2336099A20080602.ent;
  _id_1EDD840D40B43222 = self._id_2336099A20080602.tag;
  return [cameraent, _id_1EDD840D40B43222];
}

_id_FF03E352A5746185() {
  return isDefined(self._id_2336099A20080602._id_437B6BB41D98DF26);
}

_id_BDA88F27A0337EAA(animstruct, player, _id_E45F1CD8436C9AA9) {
  [cameraent, _id_1EDD840D40B43222] = _id_19EA8F6D547DC8BC(player);

  if(_id_FF03E352A5746185()) {
    if(!istrue(_id_E45F1CD8436C9AA9)) {
      player cameraunlink();
      player _meth_33010A90BCF48DB4(self._id_2336099A20080602._id_437B6BB41D98DF26, 0, animstruct._id_11BFCAB16008015E, animstruct._id_F7C301A9DE8D90F4);
    }
  } else {
    player _meth_8FF8FD7841F6EBA2();
    player cameralinkTo(cameraent, _id_1EDD840D40B43222, 1, 1);
  }
}

_id_78DFE475A5D4F843(player) {
  [cameraent, _id_1EDD840D40B43222] = _id_19EA8F6D547DC8BC(player);
  _id_3DF9D9A1027FB9BC = cameraent gettagorigin(_id_1EDD840D40B43222);
  _id_ABB06648E9DB3FFE = cameraent gettagangles(_id_1EDD840D40B43222);
  return [_id_3DF9D9A1027FB9BC, _id_ABB06648E9DB3FFE];
}

_id_347D56FEB29D7F74() {
  if(_id_FF03E352A5746185())
    return self._id_2336099A20080602._id_8355076D4ED3FC96;
  else
    return self._id_2336099A20080602.animlength;
}

spawn_script_model(modelname, animname, _id_31093158B2292193) {
  model = spawn("script_model", self._id_11BFCAB16008015E);
  model setModel(modelname);

  if(!isDefined(animname))
    animname = modelname;

  model.animname = animname;

  if(isDefined(_id_31093158B2292193)) {
    model.linkedents = [];

    foreach(_id_C30D717B67553796 in _id_31093158B2292193) {
      extra = spawn("script_model", self._id_11BFCAB16008015E);
      extra setModel(_id_C30D717B67553796[0]);
      extra linkTo(model, _id_C30D717B67553796[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

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