/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\damage_effects.gsc
***********************************************/

init() {
  if(!isDefined(level._id_FDD1AF3C4C6CBE86))
    level._id_FDD1AF3C4C6CBE86 = 0.7;
}

_id_9BC46D4B8891A740() {
  if(!isPlayer(self) || isbot(self)) {
    return;
  }
  if(!isDefined(self.damage))
    self.damage = spawnStruct();
  else if(isDefined(self.damage._id_7076478738F62D10)) {
    foreach(overlay in self.damage._id_7076478738F62D10) {
      if(isDefined(overlay))
        overlay destroy();
    }
  }

  self.damage._id_7076478738F62D10 = [];
  self.damage._id_F4687931BD3B8634 = [];
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdeathsdooroverlaypulse();
  _id_12BD9B0199862940();
  thread _id_FBA4AAAECF8E34AC();
  thread _id_C0124EDEE3A13496();
}

initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 9;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "left";
  self.damage.deathsdooroverlaypulse.aligny = "top";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 0;
  self.damage.deathsdooroverlaypulse._id_79A4133F925E83F8 = 1;
  self.damage.deathsdooroverlaypulse setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
  self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949 = 0;
  self.damage._id_7076478738F62D10 = scripts\engine\utility::array_add(self.damage._id_7076478738F62D10, self.damage.deathsdooroverlaypulse);
}

_id_12BD9B0199862940() {
  self.damage._id_5D28AF440FB50E5A = newclienthudelem(self);
  self.damage._id_5D28AF440FB50E5A.sort = 10;
  self.damage._id_5D28AF440FB50E5A.x = 0;
  self.damage._id_5D28AF440FB50E5A.y = 0;
  self.damage._id_5D28AF440FB50E5A.alignx = "left";
  self.damage._id_5D28AF440FB50E5A.aligny = "top";
  self.damage._id_5D28AF440FB50E5A.foreground = 0;
  self.damage._id_5D28AF440FB50E5A.lowresbackground = 1;
  self.damage._id_5D28AF440FB50E5A.horzalign = "fullscreen";
  self.damage._id_5D28AF440FB50E5A.vertalign = "fullscreen";
  self.damage._id_5D28AF440FB50E5A.alpha = 0;
  self.damage._id_5D28AF440FB50E5A.enablehudlighting = 0;
  self.damage._id_5D28AF440FB50E5A._id_79A4133F925E83F8 = 1;
  self.damage._id_5D28AF440FB50E5A setshader("ui_player_pain_blood_overlay", 640, 480);
  self.damage._id_F4687931BD3B8634 = scripts\engine\utility::array_add(self.damage._id_7076478738F62D10, self.damage._id_5D28AF440FB50E5A);
}

_id_FBA4AAAECF8E34AC() {
  _id_993E5CF734FBD0FC = self.damage._id_7076478738F62D10;
  self waittill("death_or_disconnect");

  foreach(overlay in _id_993E5CF734FBD0FC) {
    if(isDefined(overlay))
      overlay destroy();
  }
}

_id_C0124EDEE3A13496() {
  _id_993E5CF734FBD0FC = self.damage._id_F4687931BD3B8634;
  scripts\engine\utility::waittill_any_3("disconnect", "death_delay_finished", "spawned");

  foreach(overlay in _id_993E5CF734FBD0FC) {
    if(isDefined(overlay))
      overlay destroy();
  }
}

_id_003D879029586DE3(_id_E7B8E2A5586F580C) {
  if(getdvarint("touch_enabled"))
    return _id_E7B8E2A5586F580C * 0.6;

  return _id_E7B8E2A5586F580C;
}

onenterdeathsdoor(smeansofdeath) {
  if(istrue(self.deathsdoor)) {
    return;
  }
  self.deathsdoor = 1;
  self.painbreathloopsplayed = 0;
  self._id_632FCFDF269B9DC8 = gettime();
  self notify("startHeartbeatPulse");

  if(!istrue(self.deathsdoorsfx) && !istrue(self._id_A9982ABA7477CC90)) {
    self.deathsdoorsfx = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    self setsoundsubmix("deaths_door_mp", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread playerbreathingpainsound();

    if(isPlayer(self) && !isbot(self)) {
      _id_9030F56A68F604DC();
      _id_C2E66BC8CBF81B2D();
    }
  }

  if(level.healthregendisabled)
    self painvisionon();

  self notify("deaths_door_enter");
}

playerbreathingpainsound(_id_5E8799555F72FB99) {
  self endon("death_or_disconnect");
  self endon("deaths_door_exit");
  self endon("healed");
  self endon("joined_spectators");
  self endon("last_stand_revived");
  level endon("game_ended");
  wait 0.5;

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::isusingremote()) {
      waitframe();
      continue;
    }

    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("health_regen") || level.healthregendisabled || level._id_BE39D6B46044F344 < 40) {
      self.painbreathloopsplayed++;

      if(self.painbreathloopsplayed > scripts\engine\utility::ter_op(istrue(self.hasdonepainbreathloopthislife), 1, 4)) {
        wait 1.0;
        self.hasdonepainbreathloopthislife = 1;
        onexitdeathsdoor(0);
        break;
      }
    }

    self playlocalsound("plr_breath_pain_ong_exh");
    wait 1.7;
  }
}

onexitdeathsdoor(_id_6DCFCE39980A28B6) {
  if(istrue(_id_6DCFCE39980A28B6)) {
    self.painbreathloopsplayed = 0;
    self.hasdonepainbreathloopthislife = 0;
  }

  if(!istrue(self.deathsdoor)) {
    return;
  }
  self.deathsdoor = 0;
  self.deathsdoorsfx = 0;

  if(isPlayer(self) && !isbot(self)) {
    _id_86765F42C27F4BEE();
    _id_7067DFB2023A23B7();
  }

  self stoplocalsound("deaths_door_in");
  self playlocalsound("deaths_door_out");
  self clearsoundsubmix("deaths_door_mp");
  self playlocalsound(scripts\engine\utility::ter_op(scripts\cp_mp\utility\player_utility::isfemale(), "Fem_breathing_better", "breathing_better"));
  self enableplayerbreathsystem(1);

  if(level.healthregendisabled)
    self painvisionoff();

  self notify("deaths_door_exit");
}

_id_9030F56A68F604DC() {
  if(!isDefined(self.damage.deathsdooroverlaypulse)) {
    return;
  }
  thread _id_41A40F1E0A6AA78E();
}

_id_C2E66BC8CBF81B2D() {
  if(!isDefined(self.damage._id_5D28AF440FB50E5A)) {
    return;
  }
  self.damage._id_5D28AF440FB50E5A fadeovertime(0.15);
  self.damage._id_5D28AF440FB50E5A.alpha = _id_003D879029586DE3(1);
  self.damage._id_5D28AF440FB50E5A._id_8A8941AD64562137 = 1;
}

_id_86765F42C27F4BEE() {
  thread _id_47B9C7C77690BB03(0, 3.5);
}

_id_7067DFB2023A23B7() {
  if(!isDefined(self.damage._id_5D28AF440FB50E5A)) {
    return;
  }
  self.damage._id_5D28AF440FB50E5A fadeovertime(2.0);
  self.damage._id_5D28AF440FB50E5A.alpha = 0;
}

applyshrapnelfx() {
  self endon("disconnect");
  self notify("applyShrapnelFX");
  self endon("applyShrapnelFX");
  self setclientomnvar("ui_shrapnel_overlay", 1);
  self playlocalsound("iw8_mp_perk_shrapnel");
  _id_25D2445E5D783E47 = applyshrapnelfxinternal();

  if(istrue(_id_25D2445E5D783E47))
    self setclientomnvar("ui_shrapnel_overlay", 2);
  else
    self setclientomnvar("ui_shrapnel_overlay", 3);
}

applyshrapnelfxinternal() {
  self endon("death");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  value = scripts\engine\utility::waittill_any_return_3("shrapnel_ended_early", "shrapnel_ended", "force_regeneration");
  return value == "shrapnel_ended";
}

_id_6410111BAF734017() {
  if(!isDefined(level._id_194088D9669CB53D)) {
    level._id_194088D9669CB53D = getdvarint("dvar_57BAC575C6D501C4", 2000);
    level._id_1736DE83D797ADC0 = getdvarint("dvar_2FD03831CB8A51E6", 4000);
  }

  return level._id_194088D9669CB53D;
}

_id_549FBFADA3618987() {
  _id_194088D9669CB53D = _id_6410111BAF734017();
  return _id_194088D9669CB53D > 2000;
}

_id_F74C4C476C9489F6() {
  if(_id_549FBFADA3618987()) {
    if(!isDefined(self.lasttimedamaged))
      self.firsttimedamaged = gettime();
    else if(gettime() - self.lasttimedamaged > level._id_1736DE83D797ADC0)
      self.firsttimedamaged = gettime();
  }
}

removeoldattackersovertime() {
  self endon("damage");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.attackers)) {
    return;
  }
  _id_194088D9669CB53D = _id_6410111BAF734017();

  for(;;) {
    time = gettime();

    foreach(guid, attacker in self.attackers) {
      if(isDefined(attacker) && time - self.attackerdata[guid].lasttimedamaged < _id_194088D9669CB53D) {
        continue;
      }
      self.attackers[guid] = undefined;
      self.attackerdata[guid] = undefined;
    }

    waitframe();
  }
}

damageeffects(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7, objweapon) {
  self endon("death_or_disconnect");
  self notify("damageEffects");

  if(!isPlayer(self) || isbot(self)) {
    return;
  }
  _id_C944E9A256D8F3F9 = [::damagepainvision, ::damagebloodoverlaydirectional];
  _id_CCBBA16287668F0A = damageratio(idamage + _id_1DA1A66B5C6A06A7);

  if(!isDefined(eattacker) && smeansofdeath == "MOD_FALLING")
    eattacker = self;

  foreach(function in _id_C944E9A256D8F3F9)
  self childthread[[function]](vpoint, _id_CCBBA16287668F0A, smeansofdeath, idamage, objweapon);
}

damagepainvision(vpoint, _id_CCBBA16287668F0A, smeansofdeath, idamage, objweapon) {
  self endon("damageEffects");
  self endon("death_or_disconnect");

  if(!shoulddopainvision(objweapon))
    return 0;

  if(_id_3E54581E73DFF375(smeansofdeath))
    eventtype = "vsp_fall";
  else if(_id_6A97B15CDCD5961B(smeansofdeath))
    eventtype = "vsp_fire";
  else if(_id_9CA01A02F4EFC7F6(smeansofdeath))
    eventtype = "vsp_explosive";
  else
    eventtype = "vsp_bullet";

  self _meth_2F6B8C6721D18B0B(eventtype);
  self _meth_9227C84D3FB311A3(eventtype);
}

shoulddopainvision(objweapon) {
  if(istrue(level.wpinprogress) || istrue(self.focus))
    return 0;

  if(isDefined(objweapon) && objweapon.basename == "dragonsbreath_mp")
    return 0;

  return 1;
}

_id_52F60AC82B866362(_id_F69BA8D7B96E8326) {
  if(istrue(level.wpinprogress)) {
    return;
  }
  self visionsetnakedforplayer("", _id_F69BA8D7B96E8326);
}

damagebloodoverlaydirectional(vpoint, _id_CCBBA16287668F0A, smeansofdeath, idamage, objweapon) {
  if(!isDefined(vpoint)) {
    return;
  }
  if(!_id_9C9288020FCCD597(_id_CCBBA16287668F0A, smeansofdeath, idamage, objweapon)) {
    return;
  }
  time = gettime();

  if(time - self.damage.lastdiretionalbloodtime < 200)
    return;
  else
    self.damage.lastdiretionalbloodtime = time;

  _id_52055A030C13E72B = getplayersidesfromposition(vpoint);
  _id_F34FFB5314F27B6D = "";

  if(_id_9CA01A02F4EFC7F6(smeansofdeath))
    _id_DEC9BCCE93873125 = "fullscreen_dirt_";
  else if(!_id_07C40FA80892A721::hasarmor()) {
    _id_DEC9BCCE93873125 = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      _id_F34FFB5314F27B6D = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else
      self.damage.altdirectionalbloodoverlay = 1;
  } else
    _id_DEC9BCCE93873125 = "fullscreen_armor_";

  foreach(_id_A66BA9B157533F5A, type in _id_52055A030C13E72B) {
    material = _id_DEC9BCCE93873125 + _id_A66BA9B157533F5A;
    _id_F75CE51BC49A2E0F = material + "_splash";
    material = material + _id_F34FFB5314F27B6D;
    _id_6A78028DC80D36FE = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffect(_id_A66BA9B157533F5A, material, 0.15, 2.0, _id_6A78028DC80D36FE, 1, 1, 1);
    createscreeneffect(_id_A66BA9B157533F5A, _id_F75CE51BC49A2E0F, 0.15, 0.15, _id_6A78028DC80D36FE, 0, 1, 1);
  }
}

_id_9CA01A02F4EFC7F6(smeansofdeath) {
  _id_1C6CCEB173CE3935 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH"];

  if(scripts\engine\utility::array_contains(_id_1C6CCEB173CE3935, smeansofdeath))
    return 1;

  return 0;
}

_id_3E54581E73DFF375(smeansofdeath) {
  if(smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_IMPACT")
    return 1;

  return 0;
}

_id_6A97B15CDCD5961B(smeansofdeath) {
  if(smeansofdeath == "MOD_FIRE")
    return 1;

  return 0;
}

_id_9C9288020FCCD597(_id_CCBBA16287668F0A, smeansofdeath, idamage, objweapon) {
  if(!isalive(self))
    return 0;

  if(isDefined(idamage) && idamage <= 12)
    return 0;

  if(scripts\common\utility::iswegameplatform())
    return 0;

  if(_id_4B87F2871B6B025C::_id_1CF18F5E612E68C5())
    return 0;

  if(_id_3E54581E73DFF375(smeansofdeath) || _id_6A97B15CDCD5961B(smeansofdeath))
    return 0;

  if(isDefined(objweapon) && objweapon.basename == "dragonsbreath_mp")
    return 0;

  if(istrue(self.inlaststand))
    return 0;

  return 1;
}

getplayersidesfromposition(position) {
  forwardvec = vectorNormalize(anglesToForward(self.angles));
  _id_6F0E7A5743E7A561 = vectorNormalize(anglestoright(self.angles));
  _id_44ADE5CF4179DE8F = vectorNormalize((position[0], position[1], 0) - (self.origin[0], self.origin[1], 0));
  _id_C30A3F9960924930 = vectordot(_id_44ADE5CF4179DE8F, forwardvec);
  _id_4946DDC5DDED5B64 = vectordot(_id_44ADE5CF4179DE8F, _id_6F0E7A5743E7A561);
  _id_52055A030C13E72B = [];

  if(abs(_id_C30A3F9960924930) > 0.819152)
    _id_52055A030C13E72B["bottom"] = 1;
  else if(_id_4946DDC5DDED5B64 > 0)
    _id_52055A030C13E72B["right"] = 1;
  else
    _id_52055A030C13E72B["left"] = 1;

  return _id_52055A030C13E72B;
}

createscreeneffectoffsets(x, y, scale) {
  offsets = [];
  offsets["x"] = x;
  offsets["y"] = y;
  offsets["scale"] = scale;
  return offsets;
}

createscreeneffect(_id_A66BA9B157533F5A, shader, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, _id_6A78028DC80D36FE, _id_F100EBBBD2F636FC, _id_8983CFC1A0FF4EA1, _id_DDD23DC36AB7CB2C) {
  hud = newclienthudelem(self);
  hud.sort = 13;
  hud.foreground = 0;
  hud.lowresbackground = _id_8983CFC1A0FF4EA1;
  hud.horzalign = "fullscreen";
  hud.vertalign = "fullscreen";
  hud.alpha = 0;
  hud.enablehudlighting = 1;
  hud._id_79A4133F925E83F8 = 1;
  hud._id_8A8941AD64562137 = _id_DDD23DC36AB7CB2C;
  x = 0;
  y = 0;
  _id_BA8D59C006AB07C1 = 0;
  _id_BA8D58C006AB058E = 0;
  _id_91180BE623F6B59B = scripts\engine\math::factor_value(0.9, 1.25, _id_6A78028DC80D36FE["scale"]);

  switch (_id_A66BA9B157533F5A) {
    case "left":
      hud.aligny = "top";
      hud.alignx = "left";
      x = -640;
      y = scripts\engine\math::factor_value(-30, 30, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = y;
      _id_BA8D59C006AB07C1 = scripts\engine\math::factor_value(-55, 0, _id_6A78028DC80D36FE["x"]);
      break;
    case "right":
      hud.aligny = "top";
      hud.alignx = "right";
      x = 1280;
      y = scripts\engine\math::factor_value(-30, 30, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = y;
      _id_BA8D59C006AB07C1 = scripts\engine\math::factor_value(0, 55, _id_6A78028DC80D36FE["x"]) + 640;
      break;
    case "bottom":
      hud.aligny = "bottom";
      hud.alignx = "left";
      y = 960;
      x = scripts\engine\math::factor_value(-50, 50, _id_6A78028DC80D36FE["x"]);
      _id_BA8D58C006AB058E = scripts\engine\math::factor_value(0, 50, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = _id_BA8D58C006AB058E + 480;
      _id_BA8D59C006AB07C1 = x;
      break;
  }

  hud.x = x;
  hud.y = y;
  hud setshader(shader, 640, 480);
  thread screeneffectcleanup(hud);
  thread animatescreeneffect(hud, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, _id_BA8D59C006AB07C1, _id_BA8D58C006AB058E, _id_91180BE623F6B59B, _id_F100EBBBD2F636FC);
}

screeneffectcleanup(hud) {
  _id_81A2B809749B4189(hud);

  if(isDefined(hud)) {
    hud notify("destroySreenEffectOverlay");
    hud destroy();
  }
}

_id_81A2B809749B4189(hud) {
  self endon("death_or_disconnect");
  hud waittill("destroySreenEffectOverlay");
}

animatescreeneffect(hud, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, x, y, scale, _id_F100EBBBD2F636FC) {
  self endon("death_or_disconnect");
  hud endon("destroySreenEffectOverlay");
  width = int(640 * scale);
  height = int(480 * scale);

  if(!_id_F100EBBBD2F636FC) {
    width = int(640 * scale);
    height = int(480 * scale);
    hud scaleovertime(_id_187EF7FAE5A4F6F3, width, height);
    hud moveovertime(_id_187EF7FAE5A4F6F3);
    hud.x = x;
    hud.y = y;
    _id_187EF7FAE5A4F6F3 = 0.05;
    hud.alpha = _id_003D879029586DE3(1);
    wait 0.05;
  } else {
    hud scaleovertime(_id_187EF7FAE5A4F6F3, width, height);
    hud.x = x;
    hud.y = y;
    wait 0.15;
    hud fadeovertime(_id_187EF7FAE5A4F6F3);
    hud.alpha = _id_003D879029586DE3(1);
    wait(_id_187EF7FAE5A4F6F3);
  }

  if(isDefined(hud)) {
    hud fadeovertime(_id_D75DFE2C8B34F282);
    hud.alpha = 0;
  }

  wait(_id_D75DFE2C8B34F282 + 0.05);

  if(isDefined(hud))
    hud notify("destroySreenEffectOverlay");
}

damageratio(idamage) {
  return scripts\engine\math::normalize_value(10, 40, idamage);
}

_id_2A9705C393C0E2C4() {
  return self.deathsdoor || isDefined(self.damage) && isDefined(self.damage.deathsdooroverlaypulse) && isDefined(self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949) && self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949 > 0;
}

_id_41A40F1E0A6AA78E() {
  self notify("deaths_door_overlay_pulse");
  self endon("death_or_disconnect");
  self endon("deaths_door_overlay_pulse");
  thread _id_47B9C7C77690BB03(1, 0.3);
  _id_10C70BD3A4ADB1A8 = _id_0372301AF73968CB::_id_5C0987ADA94437DF();
  starttime = gettime();

  while(_id_2A9705C393C0E2C4()) {
    _id_5C46646210255EF0 = self._id_7FB1B36BDC873CAB.pulsetime;
    _id_060027769B32B054 = scripts\engine\math::factor_value(0.15, 0.45, _id_5C46646210255EF0);
    _id_05DD15769B0C4106 = scripts\engine\math::factor_value(0.05, 0.28, _id_5C46646210255EF0);
    _id_3B5803E733581858 = gettime() - starttime;

    if(_id_10C70BD3A4ADB1A8 > 0)
      _id_3B56FE29AD0CB0B5 = scripts\engine\math::normalize_value(0, _id_10C70BD3A4ADB1A8, _id_3B5803E733581858);
    else
      _id_3B56FE29AD0CB0B5 = 0;

    _id_9E6A60AB5457B772 = scripts\engine\math::factor_value(_id_060027769B32B054, _id_05DD15769B0C4106, _id_3B56FE29AD0CB0B5);

    if(isDefined(self.damage.deathsdooroverlaypulse)) {
      _id_9E6A60AB5457B772 = _id_9E6A60AB5457B772 * self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949;
      _id_9E6A60AB5457B772 = _id_003D879029586DE3(_id_9E6A60AB5457B772);
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = _id_9E6A60AB5457B772;
    }

    waitframe();
  }
}

_id_252173BF5AC108A3(_id_8D358D35683B1D65, time) {
  if(!isPlayer(self)) {
    return;
  }
  if(self.deathsdoor) {
    return;
  }
  if(!isDefined(self.damage)) {
    return;
  }
  self notify("deaths_door_overlay_pulse_oneoff");
  self endon("deaths_door_overlay_pulse_oneoff");
  self endon("deaths_door_overlay_pulse");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(starttime = time; time > 0; time = time - 0.05) {
    _id_805136F88545A0DB = scripts\engine\math::normalize_value(0, starttime, time);
    _id_9E6A60AB5457B772 = scripts\engine\math::factor_value(0, _id_8D358D35683B1D65, _id_805136F88545A0DB);
    _id_9E6A60AB5457B772 = _id_003D879029586DE3(_id_9E6A60AB5457B772);
    self.damage.deathsdooroverlaypulse fadeovertime(0.05);
    self.damage.deathsdooroverlaypulse.alpha = _id_9E6A60AB5457B772;
    wait 0.05;
  }
}

_id_47B9C7C77690BB03(_id_5E6F92830ACAB138, time) {
  self notify("lerpDeathDoorOverlayAlpha");
  self endon("lerpDeathDoorOverlayAlpha");
  self endon("death_or_disconnect");

  if(!isDefined(self.damage) || !isDefined(self.damage.deathsdooroverlaypulse)) {
    return;
  }
  timer = time;
  _id_8D358D35683B1D65 = self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949;

  while(timer > 0) {
    if(!isDefined(self.damage) || !isDefined(self.damage.deathsdooroverlaypulse)) {
      return;
    }
    _id_47AF4311A1D5AFDA = scripts\engine\math::normalize_value(0, time, timer);
    _id_EEDA4296AE80E949 = scripts\engine\math::factor_value(_id_5E6F92830ACAB138, _id_8D358D35683B1D65, _id_47AF4311A1D5AFDA);
    self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949 = _id_EEDA4296AE80E949;
    timer = timer - 0.05;
    waitframe();
  }

  if(isDefined(self.damage) && isDefined(self.damage.deathsdooroverlaypulse))
    self.damage.deathsdooroverlaypulse._id_EEDA4296AE80E949 = _id_5E6F92830ACAB138;
}

_id_2CA98396C7F5CC85(_id_FED4732DD8EC7225) {
  _id_CCBBA16287668F0A = _id_FED4732DD8EC7225 / self.maxhealth;
  _id_2FF497A47C266950 = getdvarfloat("dvar_6B03D4DBA904D25E", 0.5);

  if(_id_CCBBA16287668F0A >= _id_2FF497A47C266950) {
    _id_4BC08DB3876DE031 = getdvarfloat("dvar_02558D1926211903", 3.0);
    _id_B1505E7CE3AF8FEA = 1.0 - _id_2FF497A47C266950;
    _id_ACC0F0811605B1FE = (_id_CCBBA16287668F0A - _id_2FF497A47C266950) / _id_B1505E7CE3AF8FEA;
    _id_F5AE019BFC804965 = _id_ACC0F0811605B1FE * _id_4BC08DB3876DE031;
    scripts\cp_mp\utility\shellshock_utility::_shellshock("falldamage", "damage", _id_F5AE019BFC804965, 0, 0);
  }

  pulsetime = scripts\engine\math::factor_value(0.5, 0.5, _id_CCBBA16287668F0A);
  _id_9E6A60AB5457B772 = scripts\engine\math::factor_value(0.3, 0.7, _id_CCBBA16287668F0A);
  _id_252173BF5AC108A3(_id_9E6A60AB5457B772, pulsetime);
}