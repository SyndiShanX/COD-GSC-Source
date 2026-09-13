/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_78f63ba7f4b7a9db.gsc
***********************************************/

_id_9E25C98AFACDDEB8() {
  _id_CC975B30FC8F6573 = getEntArray("slide_volume", "script_noteworthy");

  foreach(slide in _id_CC975B30FC8F6573)
  slide thread _id_4FC58197C4A65FD5(slide);
}

_id_4FC58197C4A65FD5(slide) {
  level endon("game_ended");

  for(;;) {
    slide waittill("trigger", ent);
    _id_2FC5D4717F19EC24 = getdvarint("dvar_EC59329E1B1E664E", 0);

    if(!istrue(_id_2FC5D4717F19EC24)) {
      if(istrue(ent.onslide))
        continue;
    }

    if(isPlayer(ent)) {
      if(istrue(_id_2FC5D4717F19EC24)) {
        ent thread slidetriggerplayerthink(slide);
        continue;
      }

      ent.onslide = 1;
      ent thread _id_7CBABAC62A0BD7B7(slide);
    }
  }
}

_id_7CBABAC62A0BD7B7(slide) {
  self endon("disconnect");
  self._id_DF8E5B99AE689BDE = 0;
  self._id_216B94CE0C45DDA4 = 0;
  start_position = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("slide_start_spot", "targetname"));
  _id_6FFC490C4D998B88 = scripts\engine\utility::getStruct(start_position.target, "targetname");

  while(self isjumping())
    wait 0.05;

  _id_3B64EB40368C1450::set("down_slide", "weapon", 0);
  self allowprone(0);
  scripts\cp\utility::allow_player_teleport(0, "slide");

  while(self istouching(slide)) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      thread _id_C6707DF5A01C4E2D(_id_6FFC490C4D998B88);
      return;
    }

    self.ability_invulnerable = 1;
    self.disable_consumables = 1;

    if(istrue(self isjumping())) {
      while(self isjumping()) {
        _id_A107FF89BA57DBF3 = self getvelocity();
        waitframe();
      }
    } else {
      movement = self getnormalizedmovement();
      forward = anglesToForward(self.angles);
      right = anglestoright(self.angles);
      movement = (movement[1] * right[0] + movement[0] * forward[0], movement[1] * right[1] + movement[0] * forward[1], 0);
      _id_86B8851D1B6D7D01 = getdvarint("dvar_35F5763A5E04CD59", 200);
      _id_B3915D0747CA119E = vectorNormalize(_id_6FFC490C4D998B88.origin - self.origin) * _id_86B8851D1B6D7D01;
      _id_CB3CD1BFE91D7F23 = getdvarint("dvar_93C3FE5BB6B5BFC3", 10);
      _id_A107FF89BA57DBF3 = self getvelocity();
      self setvelocity(_id_A107FF89BA57DBF3 + _id_B3915D0747CA119E + movement * _id_CB3CD1BFE91D7F23);
    }

    wait 0.05;
  }

  self.ability_invulnerable = undefined;
  self notify("offslide");
  duration = self _meth_CAA215D5F785C767("power_active_cp", "gesture014");
  self _meth_1D04454C88690744(0);
  self.disable_consumables = undefined;
  self stopgestureviewmodel("ges_slide");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("down_slide");
  self allowprone(1);
  self allowcrouch(1);
  self allowstand(1);
  self setstance("stand");
  self.onslide = undefined;
  self notify("can_teleport");
}

_id_C6707DF5A01C4E2D(end_pos) {
  self endon("disconnect");
  self notify("stopslideanim");
  self setOrigin(end_pos.origin);
  _id_C9444D4653812CD0();
}

_id_C9444D4653812CD0() {
  self unlink();

  if(isDefined(self.anchor))
    self.anchor delete();

  self _meth_1D04454C88690744(0);
  self.disable_consumables = undefined;
  self stopgestureviewmodel("ges_slide");
  self setstance("stand");
  self allowprone(1);
  self allowstand(1);
  self allowcrouch(1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("down_slide");
  self.onslide = undefined;
  self notify("can_teleport");
}

issliding() {
  return self issprintsliding();
}

slidetriggerplayerthink(trig) {
  if(isDefined(self.vehicle)) {
    return;
  }
  if(issliding() || self isjumping()) {
    return;
  }
  if(isDefined(self.player_view)) {
    return;
  }
  if(scripts\engine\utility::ent_flag_exist("is_sliding") && scripts\engine\utility::ent_flag("is_sliding")) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide"))
    self playSound("SCN_cliffhanger_player_hillslide");

  accel = undefined;

  if(isDefined(trig.script_accel))
    accel = trig.script_accel;

  self endon("cancel_sliding");

  if(getdvarint("use_legacy_slide") > 0)
    thread beginslidinglegacy();
  else
    thread beginsliding(undefined, accel);

  for(;;) {
    if(!self istouching(trig)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level.end_slide_delay))
    wait(level.end_slide_delay);

  if(getdvarint("use_legacy_slide") > 0)
    endslidinglegacy();
  else
    endsliding(trig.script_stance, trig.script_damage);
}

trigger_multiple_fx_volume(trigger) {
  dummy = spawn("script_origin", (0, 0, 0));
  trigger.fx = [];

  foreach(_id_F8AC4F4543B492E8 in level.createfxent)
  assign_fx_to_trigger(_id_F8AC4F4543B492E8, trigger, dummy);

  dummy delete();

  if(!isDefined(trigger.target)) {
    return;
  }
  targets = getEntArray(trigger.target, "targetname");
  trigger.fx_on = 1;

  foreach(target in targets) {
    switch (target.classname) {
      case "trigger_multiple_fx_volume_on":
        target thread trigger_multiple_fx_trigger_on_think(trigger);
        break;
      case "trigger_multiple_fx_volume_off":
        target thread trigger_multiple_fx_trigger_off_think(trigger);
        break;
      default:
        break;
    }
  }
}

trigger_multiple_fx_trigger_on_think(volume) {
  for(;;) {
    self waittill("trigger");

    if(!volume.fx_on)
      scripts\engine\utility::array_thread(volume.fx, ::restarteffect);

    wait 1;
  }
}

restarteffect() {
  scripts\common\createfx::restart_fx_looper();
}

trigger_multiple_fx_trigger_off_think(volume) {
  for(;;) {
    self waittill("trigger");

    if(volume.fx_on)
      scripts\engine\utility::array_thread(volume.fx, scripts\engine\utility::pauseeffect);

    wait 1;
  }
}

assign_fx_to_trigger(_id_F8AC4F4543B492E8, trigger, dummy) {
  if(isDefined(_id_F8AC4F4543B492E8.v["soundalias"]) && _id_F8AC4F4543B492E8.v["soundalias"] != "nil") {
    if(!isDefined(_id_F8AC4F4543B492E8.v["stopable"]) || !_id_F8AC4F4543B492E8.v["stopable"])
      return;
  }

  dummy.origin = _id_F8AC4F4543B492E8.v["origin"];

  if(dummy istouching(trigger))
    trigger.fx[trigger.fx.size] = _id_F8AC4F4543B492E8;
}

delete_on_removed(ent) {
  ent endon("death");

  while(isDefined(self))
    wait 0.05;

  if(isDefined(ent))
    ent delete();
}

play_loop_sound_on_tag(alias, tag, _id_24818F8FD7946BA1, _id_627C155C7AC80247, _id_81ADE82BE8CAA4CE) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");

  if(!isDefined(_id_24818F8FD7946BA1))
    _id_24818F8FD7946BA1 = 1;

  if(_id_24818F8FD7946BA1)
    thread scripts\engine\utility::delete_on_death(org);

  if(!isDefined(_id_627C155C7AC80247))
    _id_627C155C7AC80247 = 0;

  if(_id_627C155C7AC80247)
    thread delete_on_removed(org);

  if(isDefined(tag))
    org linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkTo(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);

  if(isDefined(_id_81ADE82BE8CAA4CE)) {
    org playSound(_id_81ADE82BE8CAA4CE, "sounddone");
    org scripts\engine\utility::delaycall(0.15, ::stoploopsound, alias);
    org waittill("sounddone");
    org delete();
  } else {
    org stoploopsound(alias);
    org delete();
  }
}

beginslidinglegacy(velocity, _id_82EBFB9873BEBD03, _id_F8D869E874843E58) {
  player = self;

  if(player scripts\engine\utility::ent_flag_exist("is_sliding"))
    player scripts\engine\utility::ent_flag_clear("is_sliding");
  else
    player scripts\engine\utility::ent_flag_init("is_sliding");

  _id_F7D4DD03F8C4AC9E = isDefined(level.custom_linkto_slide);

  if(!isDefined(velocity))
    velocity = player getvelocity() + (0, 0, -10);

  if(!isDefined(_id_82EBFB9873BEBD03))
    _id_82EBFB9873BEBD03 = 10;

  if(!isDefined(_id_F8D869E874843E58))
    _id_F8D869E874843E58 = 0.035;

  slidemodel = spawn("script_origin", player.origin);
  slidemodel.angles = player.angles;
  player.slidemodel = slidemodel;
  slidemodel _meth_C1B4BAA714ED48E5((0, 0, 15), 15, velocity);
  player scripts\engine\utility::ent_flag_set("is_sliding");

  if(_id_F7D4DD03F8C4AC9E)
    player playerlinktoblend(slidemodel, undefined, 1);
  else
    player playerlinkTo(slidemodel);

  player _id_3B64EB40368C1450::set("slide", "weapon", 0);
  player _id_3B64EB40368C1450::set("slide", "prone", 0);
  player _id_3B64EB40368C1450::set("slide", "crouch", 1);
  player thread doslide(slidemodel, _id_82EBFB9873BEBD03, _id_F8D869E874843E58);
}

doslide(slidemodel, _id_82EBFB9873BEBD03, _id_F8D869E874843E58) {
  self endon("death");
  self endon("stop_sliding");
  player = self;
  last_pos = slidemodel.origin;
  current_pos = slidemodel.origin;
  _id_3FA79149E2D479D1 = undefined;

  for(;;) {
    if(player jumpbuttonPressed()) {
      player unlink();

      while(player isjumping())
        waitframe();

      slidemodel.origin = player.origin;
    }

    movement = player getnormalizedmovement();
    forward = anglesToForward(player.angles);
    right = anglestoright(player.angles);
    movement = (movement[1] * right[0] + movement[0] * forward[0], movement[1] * right[1] + movement[0] * forward[1], 0);
    slidemodel.slidevelocity = slidemodel.slidevelocity + movement * _id_82EBFB9873BEBD03;
    player.fx_tag.origin = slidemodel.origin + anglesToForward(slidemodel.gesture_target.angles) * 400;
    waitframe();
    slidemodel.slidevelocity = slidemodel.slidevelocity * (1 - _id_F8D869E874843E58);
  }
}

beginsliding(velocity, _id_82EBFB9873BEBD03, _id_F8D869E874843E58) {
  self endon("stop_sliding");
  self endon("death");
  player = self;

  if(player scripts\engine\utility::ent_flag_exist("is_sliding"))
    player scripts\engine\utility::ent_flag_clear("is_sliding");
  else
    player scripts\engine\utility::ent_flag_init("is_sliding");

  player scripts\engine\utility::ent_flag_set("is_sliding");
  _id_F7D4DD03F8C4AC9E = isDefined(level.custom_linkto_slide);
  slidemodel = level.players[0] scripts\engine\utility::spawn_tag_origin();
  player.slidemodel = slidemodel;
  fx_tag = level.players[0] scripts\engine\utility::spawn_tag_origin();
  player.fx_tag = fx_tag;
  trace_contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0);
  trace = scripts\engine\trace::ray_trace(level.players[0] getEye(), level.players[0] getEye() - (0, 0, 100), player, trace_contents);
  angle = 0;
  point = (0, 0, 0);
  normal = trace["normal"];

  for(;;) {
    if(!player isjumping()) {
      trace = scripts\engine\trace::ray_trace(player getEye(), player getEye() - (0, 0, 100), player, trace_contents);
      normal = trace["normal"];

      if(isDefined(normal)) {
        _id_C22BACA169342A86 = vectordot(normal, (0, 0, 1));

        if(_id_C22BACA169342A86 <= 0.95) {
          angle = acos(_id_C22BACA169342A86);
          point = trace["position"];
          break;
        }
      }
    }

    wait 0.05;
  }

  normal = vectorNormalize(scripts\engine\utility::flatten_vector(normal, (0, 0, 1)));
  _id_76D34DC0F1F05F18 = vectorNormalize(vectorcross(normal, (0, 1, 0)));
  _id_5E829C3A809CBB07 = vectorNormalize(vectorcross(normal, _id_76D34DC0F1F05F18));
  slidemodel.angles = player.angles;
  slidemodel.origin = player.origin;
  _id_9CBF3E1432E34389 = vectortoangles(normal) + normal * angle;
  slidemodel.gesture_target = spawn("script_model", slidemodel.origin + anglesToForward(_id_9CBF3E1432E34389) * 2000);
  slidemodel.gesture_target.angles = _id_9CBF3E1432E34389;
  player.fx_tag.angles = _id_9CBF3E1432E34389;

  if(!isDefined(velocity))
    velocity = player getvelocity() + (0, 0, -10);

  if(!isDefined(_id_82EBFB9873BEBD03))
    _id_82EBFB9873BEBD03 = 10;

  if(!isDefined(_id_F8D869E874843E58))
    _id_F8D869E874843E58 = 0.035;

  slidemodel _meth_C1B4BAA714ED48E5((0, 0, 15), 15, velocity);
  player forceplaygestureviewmodel("ges_slide", slidemodel.gesture_target, 0.2);

  if(isDefined(level._effect["vfx_slide_dirt"])) {
    effect = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), player.fx_tag, "tag_origin");
    player.fx_tag show();
  }

  if(_id_F7D4DD03F8C4AC9E) {
    player playerlinktoblend(slidemodel, undefined, 1);
    wait 1.0;
    player playerlinktodelta(slidemodel, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else
    player playerlinktodelta(slidemodel, "tag_origin", 0, 180, 180, 180, 180);

  player _id_3B64EB40368C1450::set("slide", "fire", 0);
  player _id_3B64EB40368C1450::set("slide", "prone", 0);
  player _id_3B64EB40368C1450::set("slide", "reload", 0);
  player thread doslide(slidemodel, _id_82EBFB9873BEBD03, _id_F8D869E874843E58);
  player thread play_loop_sound_on_tag("foot_slide_plr_loop");
}

endsliding(_id_15060420A136AFE6, _id_1363A88619936DF7) {
  player = self;

  if(player isgestureplaying()) {
    player stopgestureviewmodel("ges_slide");
    player notify("stop soundfoot_slide_plr_loop");
  }

  if(player islinked()) {
    player unlink();
    player setvelocity(player.slidemodel.slidevelocity);
  }

  if(isDefined(player.fx_tag)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      effect = scripts\engine\utility::getfx("vfx_slide_dirt");

      if(isDefined(effect))
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), player.fx_tag, "tag_origin");
    }

    player.fx_tag delete();
  }

  if(player scripts\engine\utility::ent_flag_exist("is_sliding") && player scripts\engine\utility::ent_flag("is_sliding")) {
    player scripts\engine\utility::ent_flag_clear("is_sliding");
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("slide");
  }

  if(isDefined(_id_15060420A136AFE6))
    player setstance(_id_15060420A136AFE6);

  if(isDefined(_id_1363A88619936DF7))
    player scripts\engine\utility::delaycall(0.2, ::dodamage, _id_1363A88619936DF7, player.origin);

  player.slidemodel delete();
  player notify("stop_sliding");
}

endslidinglegacy() {
  player = self;
  player notify("stop soundfoot_slide_plr_loop");
  player unlink();
  player setvelocity(player.slidemodel.slidevelocity);
  player.slidemodel delete();
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("slide");
  player notify("stop_sliding");

  if(player scripts\engine\utility::ent_flag_exist("is_sliding") && player scripts\engine\utility::ent_flag("is_sliding"))
    player scripts\engine\utility::ent_flag_clear("is_sliding");
}