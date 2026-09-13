/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a698cf430108fb7.gsc
***********************************************/

_id_CFB677B5F7D5E644() {
  if(!isalive(self) || self isparachuting() || self isskydiving() || self isonladder() || self _meth_9CC921A57FF4DEB5() || self isinexecutionattack() || self isinexecutionvictim())
    return 0;

  if(istrue(self.inlaststand) || isDefined(self.usingremote) || istrue(self.isdeploying) || istrue(self.usingascender) || scripts\cp_mp\utility\player_utility::_id_B7869F6D9D4242E3(self) || istrue(self.isjuggernaut) || istrue(self._id_859654E0445A36D9))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  thread scripts\mp\hud_message::showsplash("super_teleport_deploy_activate", undefined, self, undefined, undefined, undefined, 1);
  self setclientomnvar("ui_field_upgrade_use", 0);
  scripts\mp\utility\perk::giveperk("specialty_third_person");
  _id_6CAA4B447CB1EE5C(1);
  self.plotarmor = 1;
  thread _id_049E5C6A221425B7();
  scripts\engine\utility::delaythread(getdvarfloat("dvar_96DBD55B49EF1C2B", 0.1), ::_id_456DA1486741F194, 1);
  scripts\engine\utility::delaythread(getdvarfloat("dvar_81DBEAD1CA86D536", 0.2), ::_id_E2B829448C14C0F4, 1);
  thread _id_4B2FA585273DBB8C();
  return 1;
}

_id_E2B829448C14C0F4(_id_7449E9A013A1A596) {
  if(_id_7449E9A013A1A596) {
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("temp_v_teleport_superpower::superTeleport_hide()");
  } else {
    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("temp_v_teleport_superpower::superTeleport_hide()");
  }
}

_id_6CAA4B447CB1EE5C(_id_9F7DFF969C876C26) {
  if(_id_9F7DFF969C876C26) {
    _id_6944DA8624CCDF1D = ["ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload", "allow_jump", "usability", "vehicle_use", "execution_attack", "execution_victim"];
    scripts\mp\utility\player::_freezecontrols(1);
    _id_3B64EB40368C1450::_id_59C053B89257BC95("teleport_superpower", _id_6944DA8624CCDF1D, 0);
  } else {
    scripts\mp\utility\player::_freezecontrols(0);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("teleport_superpower");
  }
}

_id_4B2FA585273DBB8C() {
  _id_3F1786887462AF7D = getdvarfloat("dvar_62C67DF9C015A11B", 1.0);
  wait(_id_3F1786887462AF7D);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.25);
  scripts\mp\utility\perk::removeperk("specialty_third_person");
  self setOrigin(_id_3754EA1A27EECDD8());
  self skydive_beginfreefall();
  scripts\engine\utility::delaythread(0.15, ::_id_E2B829448C14C0F4, 0);
  scripts\engine\utility::delaythread(0.2, ::_id_456DA1486741F194, 0);
  self.plotarmor = undefined;
  _id_6CAA4B447CB1EE5C(0);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.25);
  _id_104E3370B024F998::_id_269B97F3D86EB172();
}

_id_3754EA1A27EECDD8() {
  _id_B3C15D36553B30B5 = self.origin + (0, 0, getdvarint("dvar_6607BD90C44F0838", 5000));
  caststart = _id_B3C15D36553B30B5;
  _id_FA13273FBFF1AB7C = self.origin;
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

    if(dist >= 1000)
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

_id_456DA1486741F194(_id_BE6106930385BD5B) {
  if(_id_BE6106930385BD5B)
    playFX(scripts\engine\utility::getfx("superPower_teleportOut"), self.origin);
  else
    self setscriptablepartstate("superpowers", "teleportIn", 0);
}

_id_049E5C6A221425B7() {
  self setscriptablepartstate("superpowers", "teleportOut", 0);
  _id_1FC06BF514F2782A = self.origin + (0, 0, 15);
  soundent = spawn("script_origin", _id_1FC06BF514F2782A);
  soundent playSound("br_the_boys_teleport_out_npc", self, soundent);
  wait 2;
  soundent delete();
}