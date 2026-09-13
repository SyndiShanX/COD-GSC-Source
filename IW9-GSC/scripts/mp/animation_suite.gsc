/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animation_suite.gsc
***********************************************/

animationsuite() {
  while(!istrue(game["gamestarted"]))
    waitframe();

  _id_04F0A1FD1DE2EE12 = getEntArray("animObj", "targetname");
  groups = gathergroups(_id_04F0A1FD1DE2EE12);
  setupvfxobjs(_id_04F0A1FD1DE2EE12);
  setupsfxobjs(_id_04F0A1FD1DE2EE12);

  foreach(obj in _id_04F0A1FD1DE2EE12) {
    if(scripts\cp_mp\utility\game_utility::islargemap())
      obj forcenetfieldhighlod(1);

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
    }
  }
}

setupvfxobjs(objects) {
  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && scripts\engine\utility::string_starts_with(obj.script_noteworthy, "vfx_")) {
      model = obj scripts\engine\utility::spawn_tag_origin();
      model show();
      model linkTo(obj);
      waitframe();

      if(!isvalidanimsuiteentity("setupVFXObjs(): obj", obj)) {
        continue;
      }
      if(!isvalidanimsuiteentity("setupVFXObjs(): model", model)) {
        continue;
      }
      thread delayfxcall(scripts\engine\utility::getfx(obj.script_noteworthy), model, "tag_origin");
    }
  }
}

delayfxcall(fx, model, tag) {
  wait 5;

  if(!isvalidanimsuiteentity("delayFXCall()", model)) {
    return;
  }
  playFXOnTag(fx, model, tag);
}

setupsfxobjs(objects) {
  foreach(obj in objects) {
    if(isDefined(obj.script_noteworthy) && scripts\engine\utility::string_starts_with(obj.script_noteworthy, "sfx_")) {
      obj setModel("tag_origin");
      obj thread scripts\engine\utility::play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility\debug::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
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
  level endon("game_ended");
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

    if(isDefined(stop))
      thread animsuite_playthreadedsound(_id_95C572E07CDA0A29[0], stop);

    wait(_id_95C572E07CDA0A29[0] + _id_66C2115B7D407541);

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }
    if(isDefined(start))
      playsoundatpos(self.origin, start);

    self moveTo(_id_4549CD5FC4176D49, _id_95C572E07CDA0A29[0], _id_95C572E07CDA0A29[1], _id_95C572E07CDA0A29[2]);

    if(isDefined(stop))
      thread animsuite_playthreadedsound(_id_95C572E07CDA0A29[0], stop);

    wait(_id_95C572E07CDA0A29[0] + _id_66C2115B7D407541);

    if(!isvalidanimsuiteentity("animSuite_Translation_PingPong()", self)) {
      return;
    }
    if(isDefined(start))
      playsoundatpos(self.origin, start);
  }
}

animsuite_playthreadedsound(waittime, alias) {
  wait(waittime);

  if(!isvalidanimsuiteentity("animSuite_playThreadedSound()", self)) {
    return;
  }
  playsoundatpos(self.origin, alias);
}

animsuite_translation_once() {
  level endon("game_ended");
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
  level endon("game_ended");
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

    if(isDefined(stop))
      thread animsuite_playthreadedsound(_id_CC5BC42930ABBC4F[0] * 0.9, stop);

    wait(_id_CC5BC42930ABBC4F[0] + _id_AD33515358075D20);

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }
    if(isDefined(start))
      playsoundatpos(self.origin, start);

    self rotateby(_id_88C3A0FD4D89C1F4 * -1, _id_CC5BC42930ABBC4F[0], _id_CC5BC42930ABBC4F[1], _id_CC5BC42930ABBC4F[2]);

    if(isDefined(stop))
      thread animsuite_playthreadedsound(_id_CC5BC42930ABBC4F[0] * 0.9, stop);

    wait(_id_CC5BC42930ABBC4F[0] + _id_AD33515358075D20);

    if(!isvalidanimsuiteentity("animSuite_Rotation_PingPong()", self)) {
      return;
    }
    if(isDefined(start))
      playsoundatpos(self.origin, start);
  }
}

animsuite_rotation_continuous() {
  level endon("game_ended");
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