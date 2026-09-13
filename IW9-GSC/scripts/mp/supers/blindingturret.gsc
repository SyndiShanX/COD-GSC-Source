/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\blindingturret.gsc
************************************************/

_id_E10D519BBF856E68() {
  self notify("blindingTurret_unset");
}

_id_F6F76571FBD09F18(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker notify("destroyed_equipment");

  _id_7D3A3FE4313463B4();
}

_id_B02438CF4822A79E(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade waittill("missile_stuck");
  turret = _id_2BEAF4844E5A4D16(grenade);

  if(!isDefined(turret)) {
    return;
  }
  maxhealth = 100;
  turret thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", ::_id_F6F76571FBD09F18, undefined, 0, 0);
  turret thread _id_CAD43242EF6C86B5();
  turret thread _id_B310F71F299CBC78();
}

_id_B310F71F299CBC78() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(!istrue(self.stunned) && !istrue(self.isactive))
      _id_74B09DA5A1249FF7();

    if(!istrue(self.stunned) && !istrue(self._id_D299274BFC2E5980))
      thread _id_A100143A05B7B873();

    if(!istrue(self.stunned) && !isDefined(self._id_716423DC232862C0) && !istrue(self.oncooldown))
      _id_A8320570B3ED2B35();

    if(!istrue(self.stunned) && isDefined(self._id_716423DC232862C0))
      _id_3FE776CABEE63724();

    if(!istrue(self.stunned) && istrue(self._id_E9765F437A2DE9C0) && isDefined(self._id_716423DC232862C0))
      _id_83F4DD119ACBF873();

    if(istrue(self.stunned))
      _id_C471C1F93412CB6C();

    if(isDefined(self._id_716423DC232862C0))
      _id_0987732D93502E3F();

    waitframe();
  }
}

_id_83F4DD119ACBF873() {
  cansee = _id_59B368C4C2BDC737(self._id_716423DC232862C0);

  if(cansee)
    self._id_716423DC232862C0 scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp", "flash", 4.0, 1);

  thread _id_6584A53D3D4D1FA8();
}

_id_6584A53D3D4D1FA8(time) {
  if(!isDefined(time))
    time = 1.0;

  self.oncooldown = 1;
  wait(time);
  self.oncooldown = undefined;
}

_id_59B368C4C2BDC737(target) {
  if(!isDefined(target))
    return 0;

  _id_027B697504D9397D = 0;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  _id_08A4EA3A3BAA22E4 = self.origin;
  _id_295719F06C03407F = target gettagorigin("j_head");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
    _id_295719F06C03407F = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();

  _id_FC60036BA7BF253A = "j_spineupper";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
    _id_FC60036BA7BF253A = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();

  _id_D895C679F6A927E5 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, _id_08A4EA3A3BAA22E4];
  ignorelist = [self, target];
  vehicle = target scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    _id_BB7AC665413117FC = vehicle getlinkedchildren(1);

    foreach(child in _id_BB7AC665413117FC)
    ignorelist[ignorelist.size] = vehicle;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(_id_08A4EA3A3BAA22E4, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], ignorelist, _id_FBCABD62B8F66EB8)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

_id_C471C1F93412CB6C() {}

_id_0987732D93502E3F() {
  if(!isDefined(self._id_894380476A44E139))
    self._id_894380476A44E139 = [];

  self._id_894380476A44E139[self._id_894380476A44E139.size] = self._id_716423DC232862C0;
  self._id_716423DC232862C0 = undefined;
  self cleartargetentity();
  self._id_D299274BFC2E5980 = 0;
  self._id_E9765F437A2DE9C0 = 0;
}

_id_3FE776CABEE63724() {
  if(!isDefined(self._id_716423DC232862C0))
    return;
  else {
    self endon("death");
    self endon("stunned");
    self._id_716423DC232862C0 endon("death_or_disconnect");
    self notify("blindingTurret_stopIdleMovements");
    self._id_E9765F437A2DE9C0 = 0;
    self cleartargetentity();
    waitframe();
    self setconvergencetime(0.75, "pitch");
    self setconvergencetime(0.75, "yaw");
    self.aimtarget linkTo(self._id_716423DC232862C0, "tag_shield_back", (0, 0, 0), (0, 0, 0));
    self settargetentity(self.aimtarget);
    waitframe();
    _id_8FFB4040B18F4E9E = scripts\engine\utility::flatten_vector(self.aimtarget.origin - self.origin);
    _id_F02E4B8443C68E94 = scripts\engine\utility::flatten_vector(anglesToForward(self gettagangles("tag_flash")));
    _id_C5F68CDF7B9421D9 = scripts\engine\math::anglebetweenvectors(_id_F02E4B8443C68E94, _id_8FFB4040B18F4E9E);

    while(_id_C5F68CDF7B9421D9 > 8.0) {
      _id_C5F68CDF7B9421D9 = scripts\engine\math::anglebetweenvectors(_id_F02E4B8443C68E94, _id_8FFB4040B18F4E9E);
      _id_F02E4B8443C68E94 = scripts\engine\utility::flatten_vector(anglesToForward(self gettagangles("tag_flash")));
      waitframe();
    }

    self._id_E9765F437A2DE9C0 = 1;
  }
}

_id_126DD09DA824D606(player, _id_1FEEBA72EA1B50A7) {
  if(!isDefined(player))
    return 0;

  if(player.team == self.owner.team)
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner)))
    return 0;

  if(distancesquared(player.origin, self.origin) > 562500)
    return 0;

  if(isDefined(self._id_894380476A44E139) && scripts\engine\utility::array_contains(self._id_894380476A44E139, player))
    return 0;

  _id_9AD4F0E9A4D962FB = scripts\engine\math::anglebetweenvectors(anglesToForward(self.angles), _id_1FEEBA72EA1B50A7);

  if(_id_9AD4F0E9A4D962FB >= 90)
    return 0;

  return 1;
}

_id_A100143A05B7B873() {
  self endon("death");
  self endon("blindTurret_stopIdleMovements");
  self._id_D299274BFC2E5980 = 1;
  self.aimtarget unlink();
  direction = 1;
  startangles = self.angles;
  _id_7277010A82352E32 = getdvarfloat("dvar_08BF7C4A92A43762", 15.0);
  _id_5D8C55D5B4F0643C = getdvarfloat("dvar_476655D41CF371FA", 30.0);
  _id_7531D94939D23350 = getdvarfloat("dvar_59D07E54A840556C", 100.0);
  _id_041EE18556B2486F = self gettagorigin("tag_aim_pivot") + anglesToForward(startangles) * _id_5D8C55D5B4F0643C + anglestoup(startangles) * _id_7277010A82352E32;
  self.aimtarget.origin = _id_041EE18556B2486F;
  self setconvergencetime(2.5, "pitch");
  self setconvergencetime(2.5, "yaw");

  for(;;) {
    self cleartargetentity();
    waitframe();
    self settargetentity(self.aimtarget);
    direction = direction * -1;
    self.aimtarget.origin = _id_041EE18556B2486F + anglestoright(startangles) * _id_7531D94939D23350 * direction;
    _id_DA3D9FE6B1FF496B = scripts\engine\utility::flatten_vector(self.aimtarget.origin - self.origin);
    turretangles = self gettagangles("tag_flash");
    _id_77C133840A36C8A4 = scripts\engine\math::anglebetweenvectors(anglesToForward(turretangles), _id_DA3D9FE6B1FF496B);

    while(_id_77C133840A36C8A4 > 8.0) {
      turretangles = self gettagangles("tag_flash");
      _id_77C133840A36C8A4 = scripts\engine\math::anglebetweenvectors(scripts\engine\utility::flatten_vector(anglesToForward(turretangles)), _id_DA3D9FE6B1FF496B);
      waitframe();
    }
  }
}

_id_A8320570B3ED2B35() {
  _id_58929EA8D7EB7F44 = [];
  _id_124A2A5957983DB8 = [];

  foreach(player in level.characters) {
    _id_1FEEBA72EA1B50A7 = player.origin - self.origin;

    if(!_id_126DD09DA824D606(player, _id_1FEEBA72EA1B50A7)) {
      continue;
    }
    _id_AE3412F7B9B48D44 = 1 - distancesquared(player.origin, self.origin) / 562500;
    _id_AE3412F7B9B48D44 = clamp(_id_AE3412F7B9B48D44, 0.0, 1.0);
    _id_0E64A4025FFE8EB2 = 1 - scripts\engine\math::anglebetweenvectors(anglesToForward(self.angles), _id_1FEEBA72EA1B50A7) / 90;
    _id_0E64A4025FFE8EB2 = clamp(_id_0E64A4025FFE8EB2, 0.0, 1.0);
    weight = _id_AE3412F7B9B48D44 * 0.75 + _id_0E64A4025FFE8EB2 * 0.25;
    _id_58929EA8D7EB7F44[_id_58929EA8D7EB7F44.size] = player;
    _id_124A2A5957983DB8[_id_124A2A5957983DB8.size] = weight;
  }

  if(_id_58929EA8D7EB7F44.size == 0) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_124A2A5957983DB8.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_FCB8575B464D3877 = 0;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_124A2A5957983DB8.size - 1; _id_AC0E5C4AC96AAA41++) {
      if(_id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41] < _id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41 + 1]) {
        _id_382D2566050DE89A = _id_58929EA8D7EB7F44[_id_AC0E5C4AC96AAA41];
        _id_A070967229EC3DE7 = _id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41];
        _id_58929EA8D7EB7F44[_id_AC0E5C4AC96AAA41] = _id_58929EA8D7EB7F44[_id_AC0E5C4AC96AAA41 + 1];
        _id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41] = _id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41 + 1];
        _id_58929EA8D7EB7F44[_id_AC0E5C4AC96AAA41 + 1] = _id_382D2566050DE89A;
        _id_124A2A5957983DB8[_id_AC0E5C4AC96AAA41 + 1] = _id_A070967229EC3DE7;
        _id_FCB8575B464D3877 = 1;
      }
    }

    if(!_id_FCB8575B464D3877) {
      break;
    }
  }

  self._id_716423DC232862C0 = _id_58929EA8D7EB7F44[0];
}

_id_74B09DA5A1249FF7() {
  self.isactive = 1;
  self setdefaultdroppitch(-89.0);
  self setmode("manual_target");

  if(!issentient(self))
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner);
}

_id_7D3A3FE4313463B4() {
  self notify("death");
  self delete();
}

_id_CAD43242EF6C86B5() {
  self endon("death");
  _id_B305F54DD4A77190();
  thread _id_7D3A3FE4313463B4();
}

_id_B305F54DD4A77190() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("blindingTurret_unset");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(30);
}

_id_2BEAF4844E5A4D16(grenade) {
  _id_F02E4B8443C68E94 = grenade.origin - self.origin;
  _id_A9D52B91B0873E57 = vectortoangles(scripts\engine\utility::flatten_vector(_id_F02E4B8443C68E94));
  turret = spawnturret("misc_turret", grenade.origin, "blinding_turret_mp", 0);
  turret setModel("weapon_wm_mg_sentry_turret");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret maketurretinoperable();
  turret setleftarc(90);
  turret setrightarc(90);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(2.5, "pitch");
  turret setconvergencetime(2.5, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret setmode("manual_target");
  turret.angles = _id_A9D52B91B0873E57;
  turret.owner = self;
  turret setturretowner(self);
  turret setturretteam(self.team);
  turret.aimtarget = scripts\engine\utility::spawn_tag_origin(turret.origin, turret.angles);
  turret.aimtarget linkTo(turret, "tag_flash", (0, 0, 0), (0, 0, 0));
  turret._id_D299274BFC2E5980 = 0;
  grenade delete();
  return turret;
}