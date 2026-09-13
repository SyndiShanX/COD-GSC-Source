/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_387376c964b87290.gsc
***********************************************/

_id_C1B99BC04C9CFE4A() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_04F0A1FD1DE2EE12 = getEntArray("manipulate_ent", "script_noteworthy");

  foreach(obj in _id_04F0A1FD1DE2EE12) {
    if(isDefined(obj.script_animation_type)) {
      switch (obj.script_animation_type) {
        case "rotation_pingpong":
        case "rotation_continuous":
          obj thread animsuite_rotation(obj.script_animation_type);
          break;
        case "translation_once":
        case "translation_pingpong":
          obj thread animsuite_translation(obj.script_animation_type);
          break;
      }

      continue;
    }

    obj thread animsuite_rotation("rotation_continuous");
  }

  level._id_04F0A1FD1DE2EE12 = _id_04F0A1FD1DE2EE12;
}

gathergroups(objects) {
  groups = [];
  _id_0B9F37CF0690A914 = [];

  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && issubstr(obj.script_noteworthy, "group"))
      groups = scripts\engine\utility::array_add(groups, obj);
  }

  foreach(item in groups) {
    if(!isDefined(_id_0B9F37CF0690A914[item.script_noteworthy])) {
      _id_0B9F37CF0690A914[item.script_noteworthy] = [item];
      continue;
    }

    _id_0B9F37CF0690A914[item.script_noteworthy] = scripts\engine\utility::array_add(_id_0B9F37CF0690A914[item.script_noteworthy], item);
  }

  foreach(group in _id_0B9F37CF0690A914) {
    parent = animsuite_getparentobject(group);
    animsuite_linkchildrentoparentobject(parent, group);
  }

  return _id_0B9F37CF0690A914;
}

animsuite_getparentobject(group) {
  foreach(_id_F90358454413407F in group) {
    if(isDefined(_id_F90358454413407F.script_linkname))
      return _id_F90358454413407F;
  }
}

animsuite_linkchildrentoparentobject(parent, group) {
  if(isDefined(parent) && isDefined(group)) {
    foreach(_id_F90358454413407F in group) {
      if(_id_F90358454413407F == parent) {
        continue;
      }
      _id_F90358454413407F linkTo(parent);
    }
  }
}

animsuite_translation(_id_7BD5A576C10B3755) {
  if(issubstr(_id_7BD5A576C10B3755, "pingpong"))
    thread animsuite_translation_pingpong();

  if(issubstr(_id_7BD5A576C10B3755, "once"))
    thread animsuite_translation_once();
}

animsuite_translation_pingpong() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  _id_D62C5724671299BA = (0, 90, 0);
  _id_95C572E07CDA0A29 = 5;
  _id_66C2115B7D407541 = 0.5;
  start = undefined;
  stop = undefined;
  loop = undefined;

  if(isDefined(self.script_translation_amount))
    _id_D62C5724671299BA = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    _id_95C572E07CDA0A29 = self.script_translation_time;

  if(isDefined(self.script_audio_parameters)) {
    if(issubstr(self.script_audio_parameters, "start"))
      start = "mp_quarry_lg_crane_start";

    if(issubstr(self.script_audio_parameters, "stop"))
      stop = "mp_quarry_lg_crane_stop";

    if(issubstr(self.script_audio_parameters, "loop"))
      loop = "mp_quarry_lg_crane_loop";
  }

  for(;;) {
    _id_4549CD5FC4176D49 = self.origin;
    self moveTo(self.origin + _id_D62C5724671299BA, _id_95C572E07CDA0A29[0], _id_95C572E07CDA0A29[1], _id_95C572E07CDA0A29[2]);
    wait(_id_95C572E07CDA0A29[0] + _id_66C2115B7D407541);

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }
    self moveTo(_id_4549CD5FC4176D49, _id_95C572E07CDA0A29[0], _id_95C572E07CDA0A29[1], _id_95C572E07CDA0A29[2]);
    wait(_id_95C572E07CDA0A29[0] + _id_66C2115B7D407541);

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self))
      return;
  }
}

animsuite_translation_once() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  _id_D62C5724671299BA = (0, 90, 0);
  _id_95C572E07CDA0A29 = 5;

  if(isDefined(self.script_translation_amount))
    _id_D62C5724671299BA = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    _id_95C572E07CDA0A29 = length(self.script_translation_time);

  for(;;) {
    self rotateby(_id_D62C5724671299BA, _id_95C572E07CDA0A29, 0, 0);
    wait(_id_95C572E07CDA0A29);

    if(!isvalidanimsuiteentity("animSuite_Translation_Once()", self))
      return;
  }
}

animsuite_rotation(_id_B7A189377EAE230C) {
  if(issubstr(_id_B7A189377EAE230C, "pingpong"))
    thread animsuite_rotation_pingpong();

  if(issubstr(_id_B7A189377EAE230C, "continuous"))
    thread animsuite_rotation_continuous();
}

animsuite_rotation_pingpong() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  _id_88C3A0FD4D89C1F4 = (0, 90, 0);
  _id_CC5BC42930ABBC4F = (5, 0, 0);
  _id_AD33515358075D20 = 0;
  start = undefined;
  stop = undefined;
  loop = undefined;

  if(isDefined(self.script_rotation_amount))
    _id_88C3A0FD4D89C1F4 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    _id_CC5BC42930ABBC4F = self.script_rotation_speed;

  for(;;) {
    self rotateby(_id_88C3A0FD4D89C1F4, _id_CC5BC42930ABBC4F[0], _id_CC5BC42930ABBC4F[1], _id_CC5BC42930ABBC4F[2]);
    wait(_id_CC5BC42930ABBC4F[0] + _id_AD33515358075D20);

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }
    self rotateby(_id_88C3A0FD4D89C1F4 * -1, _id_CC5BC42930ABBC4F[0], _id_CC5BC42930ABBC4F[1], _id_CC5BC42930ABBC4F[2]);
    wait(_id_CC5BC42930ABBC4F[0] + _id_AD33515358075D20);

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self))
      return;
  }
}

animsuite_rotation_continuous() {
  self notify("anim_started");
  level endon("game_ended");
  self endon("anim_started");
  _id_88C3A0FD4D89C1F4 = (0, 90, 0);
  _id_CC5BC42930ABBC4F = (5, 0, 0);
  _id_AD33515358075D20 = 0.5;

  if(isDefined(self.script_rotation_amount))
    _id_88C3A0FD4D89C1F4 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    _id_CC5BC42930ABBC4F = self.script_rotation_speed;

  for(;;) {
    self rotateby(_id_88C3A0FD4D89C1F4, _id_CC5BC42930ABBC4F[0], _id_CC5BC42930ABBC4F[1], _id_CC5BC42930ABBC4F[2]);
    wait(_id_CC5BC42930ABBC4F[0]);

    if(!isvalidanimsuiteentity("animSuite_Rotation_Continuous()", self))
      return;
  }
}

isvalidanimsuiteentity(_id_EA847593E957F2B0, ent) {
  if(!isDefined(ent))
    return 0;

  return 1;
}

_id_D6355F012701CCD5() {
  level endon("game_ended");
  level._id_541F214D076EB549 = undefined;

  for(;;) {
    _id_3A0BAF8F0C5BD7F1 = getdvarint("dvar_0E9197F745A6B494", 0);

    switch (_id_3A0BAF8F0C5BD7F1) {
      case 1:
        if(!isDefined(level._id_541F214D076EB549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level._id_541F214D076EB549 = obj;
        }

        level._id_541F214D076EB549 thread animsuite_rotation("continuous");
        break;
      case 2:
        if(!isDefined(level._id_541F214D076EB549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level._id_541F214D076EB549 = obj;
        }

        level._id_541F214D076EB549 thread animsuite_translation("once");
        break;
      case 3:
        if(!isDefined(level._id_541F214D076EB549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level._id_541F214D076EB549 = obj;
        }

        level._id_541F214D076EB549 thread animsuite_rotation("pingpong");
        break;
      case 4:
        if(!isDefined(level._id_541F214D076EB549)) {
          obj = spawn("script_model", (-5910.26, -3473.5, 0));
          obj setModel("veh9_mil_lnd_jltv_lobby");
          level._id_541F214D076EB549 = obj;
        }

        level._id_541F214D076EB549 thread animsuite_translation("pingpong");
        break;
      case 5:
        if(!isDefined(level._id_04F0A1FD1DE2EE12[0])) {
          break;
        }

        forward = vectorNormalize(anglesToForward(level._id_04F0A1FD1DE2EE12[0].angles));
        level._id_7FC91D1D11CD14DE.origin = forward * 100 + level._id_04F0A1FD1DE2EE12[0].origin;
        level._id_04F0A1FD1DE2EE12[0] thread animsuite_rotation("continuous");
        break;
      default:
        break;
    }

    setDvar("dvar_0E9197F745A6B494", 0);
    waitframe();
  }
}