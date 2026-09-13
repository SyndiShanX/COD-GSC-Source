/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5bc0f070aa89d04b.gsc
***********************************************/

_id_903421D8C3915B6B() {
  spawndelay = 0.25;
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_1", 1, 1, 1, spawndelay, undefined, "ally_ai_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_1", ::_id_3C1791B14B77F3A7);
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_2", 1, 1, 1, spawndelay, undefined, "ally_ai_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_2", ::_id_3C1791B14B77F3A7);
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_3", 11, 11, 11, 0.1, undefined, "ally_ai_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_3", ::_id_3C1791B14B77F3A7);
  _id_18A73A64992DD07D::registerambientgroup("ally_ai_survivors", 4, 4, 4, 0.1, undefined, "ally_ai_survivors", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ally_ai_survivors", ::_id_7335D42AE60F222C);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 20; _id_AC0E594AC96AA3A8++) {
    number = 2 * _id_AC0E594AC96AA3A8;
    name = "ally_ai_respawn_p1_" + _id_AC0E594AC96AA3A8;
    _id_18A73A64992DD07D::registerambientgroup(name, number, number, number, spawndelay, undefined, "ally_ai_respawn_1", undefined, undefined, undefined);
    _id_18A73A64992DD07D::register_module_ai_spawn_func(name, ::_id_3C1791B14B77F3A7);
    name = "ally_ai_respawn_p2_" + _id_AC0E594AC96AA3A8;
    _id_18A73A64992DD07D::registerambientgroup(name, number, number, number, spawndelay, undefined, "ally_ai_respawn_2", undefined, undefined, undefined);
    _id_18A73A64992DD07D::register_module_ai_spawn_func(name, ::_id_3C1791B14B77F3A7);
  }

  _id_757C9AC43A532DAC::_id_18E5B806C7693D20();
}

_id_12BE2EFCA81C224E(delay) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(isDefined(delay))
    wait(delay);

  if(istrue(level._id_EFE609BCE901CAA8))
    scripts\cp\utility::gameflagwait("infil_started");

  _id_F318D96DABD3B489 = level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_1");
  _id_735AE730E2967741 = level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_2");

  if(level.script != "cp_lone") {
    level._id_FF3812CB242BA0F6 = level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_3");
    level._id_FF3812CB242BA0F6 thread _id_90C09E830D5AB816();
    level._id_D1A6337FDB059B41 = level thread _id_18A73A64992DD07D::run_spawn_module("ally_ai_survivors");
  }

  level thread _id_352559B3C422FEE2(_id_F318D96DABD3B489, 0);
  level thread _id_352559B3C422FEE2(_id_735AE730E2967741, 1);

  for(;;) {
    level waittill("deploy_delta_squad", _id_D7645F54A917F442);
    _id_6EA8E24D4901E87C = 0;

    foreach(index, guy in level.players) {
      if(guy == _id_D7645F54A917F442) {
        _id_6EA8E24D4901E87C = int(index);
        break;
      }
    }

    level thread _id_7C12D8F957DE7847(_id_6EA8E24D4901E87C);
  }
}

_id_7C12D8F957DE7847(_id_6EA8E24D4901E87C) {
  level endon("game_ended");

  if(isDefined(level._id_0410DCB9CDA2B067)) {
    level._id_0410DCB9CDA2B067[level._id_0410DCB9CDA2B067.size] = _id_6EA8E24D4901E87C;
    return;
  }

  level._id_0410DCB9CDA2B067 = [];
  level._id_0410DCB9CDA2B067[level._id_0410DCB9CDA2B067.size] = _id_6EA8E24D4901E87C;
  wait 4;

  while(istrue(level._id_7B57AB2CC8BA008A)) {
    wait 0.25;
    _id_8CC36C8D580E9BD4();
  }

  level _id_04C59A50C3830F12();
  level._id_0410DCB9CDA2B067 = undefined;
  level._id_FB42AFB152C7706E = undefined;
}

_id_8CC36C8D580E9BD4() {
  if(istrue(level._id_FB42AFB152C7706E)) {
    return;
  }
  level._id_FB42AFB152C7706E = 1;

  foreach(player in level.players)
  player thread scripts\cp\cp_hud_message::tutorialprint(level._id_988BC8650B85A175, 3);
}

_id_B14CF27C4CB71581() {
  self endon("death_or_disconnect");
  wait 3;
  thread scripts\cp\cp_hud_message::tutorialprint(level._id_87DBB8D8D744C95F, 3);
}

_id_04C59A50C3830F12() {
  level._id_F42ACFB1D6B18FD7 = 1;
  level thread _id_48F20B0FE71DD6DF::_id_A52439669E58CFC6();

  foreach(player in level.players)
  player thread _id_B14CF27C4CB71581();

  _id_125EFA299447940E = 0;
  _id_1E522FF0740029C1 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_0410DCB9CDA2B067.size; _id_AC0E594AC96AA3A8++) {
    if(level._id_0410DCB9CDA2B067[_id_AC0E594AC96AA3A8] == 0) {
      _id_125EFA299447940E++;
      continue;
    }

    if(level._id_0410DCB9CDA2B067[_id_AC0E594AC96AA3A8] == 1)
      _id_1E522FF0740029C1++;
  }

  if(_id_125EFA299447940E > 0)
    level thread _id_302DA1A3F0A01A74(0, _id_125EFA299447940E);

  if(_id_1E522FF0740029C1 > 0) {
    if(_id_125EFA299447940E > 0)
      wait 5;

    level thread _id_302DA1A3F0A01A74(1, _id_1E522FF0740029C1);
  }

  level._id_F42ACFB1D6B18FD7 = undefined;
}

_id_302DA1A3F0A01A74(_id_6EA8E24D4901E87C, _id_862AB22D243CD27F) {
  _id_0934B6355F77E073 = (-13512, 66432, 5904);
  level._id_7E0688B1C67F2B22 = 10;
  level._id_752D2F716AFE7FCF = 4;

  if(_id_6EA8E24D4901E87C == 0)
    level thread _id_00140F4D505F5569(_id_0934B6355F77E073, _id_6EA8E24D4901E87C, _id_862AB22D243CD27F);
  else
    level thread _id_00140C4D505F4ED0(_id_0934B6355F77E073, _id_6EA8E24D4901E87C, _id_862AB22D243CD27F);
}

_id_00140F4D505F5569(_id_0934B6355F77E073, _id_5FF76B0E0C5B9EEE, _id_862AB22D243CD27F) {
  name = "ally_ai_respawn_p1_" + _id_862AB22D243CD27F;
  spawnpoints = scripts\engine\utility::getStructArray("ally_ai_respawn_1", "targetname");
  _id_3FC2EBC056C96A4E = level scripts\cp\cp_aiparachute::request_paratroopers(name, 7000, _id_0934B6355F77E073, spawnpoints);
  level thread _id_352559B3C422FEE2(_id_3FC2EBC056C96A4E, _id_5FF76B0E0C5B9EEE);
}

_id_00140C4D505F4ED0(_id_0934B6355F77E073, _id_5FF76B0E0C5B9EEE, _id_862AB22D243CD27F) {
  name = "ally_ai_respawn_p2_" + _id_862AB22D243CD27F;
  spawnpoints = scripts\engine\utility::getStructArray("ally_ai_respawn_1", "targetname");
  _id_3FC2EAC056C9681B = level scripts\cp\cp_aiparachute::request_paratroopers(name, 7000, _id_0934B6355F77E073, spawnpoints);
  level thread _id_352559B3C422FEE2(_id_3FC2EAC056C9681B, _id_5FF76B0E0C5B9EEE);
}

_id_7335D42AE60F222C(group) {
  scripts\common\ai::magic_bullet_shield(1);
  _id_18A73A64992DD07D::set_goal_radius(64);
  self._id_4030AF6E547AF52B = 1;
  thread _id_3C1791B14B77F3A7(group);
  thread _id_A36C62890D67D206();
  thread _id_91D28114343AECC7();
}

_id_91D28114343AECC7() {
  self endon("death");
  wait 10;
  _id_725EF9CBF47F2896 = scripts\engine\utility::getStruct("intro_ally_target_00_point", "targetname");
  maxplayerdist = 62500;

  while(distance(self.origin, _id_725EF9CBF47F2896.origin) < 400) {
    self allowedstances("stand");
    wait(7 + randomfloat(5));
    closestplayer = scripts\cp\utility::get_closest_living_player(maxplayerdist);

    if(isDefined(closestplayer)) {
      self setlookat(closestplayer getEye());
      childthread scripts\engine\utility::delaycall(3, ::stoplookat);

      if(scripts\engine\utility::cointoss())
        self playSound("dx_cp_cpob_dfw2_uss3_breaker1allgoodhere");
    }

    self allowedstances("crouch");
    wait(8 + randomfloat(5));
  }
}

_id_A36C62890D67D206() {
  self endon("death");
  wait 3;

  if(scripts\engine\utility::flag_exist("infil_over"))
    scripts\engine\utility::flag_wait("infil_over");

  scripts\common\ai::stop_magic_bullet_shield();
}

_id_3C1791B14B77F3A7(group) {
  waitframe();

  if(!isDefined(level._id_F78FB7634E3797C4))
    level._id_F78FB7634E3797C4 = [];

  level._id_F78FB7634E3797C4[level._id_F78FB7634E3797C4.size] = self;
  self._id_EC7F24B7685542B0 = level._id_F78FB7634E3797C4.size - 1;
  self.entity_number = self getentitynumber();
  self.team = "allies";
  self.maxhealth = 1200;
  self.health = 1200;
  self.goalradius = 250;
  self.goalheight = 1024;
  self.maxfaceenemydist = 512;
  self._id_894D1167ACE5B58C = 1;
  self._id_10F81A6BF4F5CE9A = 1;
  armor = 300;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = armor;
  self.armorhealth = int(armor);
  self._id_8790C077C95DB752 = int(armor);
  _id_FEA750D6814B803D = "iw9_ar_mike4_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_mike4_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_18A73A64992DD07D::_id_9426D24DFB73528D();
  thread _id_9E75502E1061EA5C();
  self pushplayer(1);
  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  scripts\common\utility::initweapon(self.sidearm);
  _id_A68442EBADB66EB1 = "frag_grenade_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 8;
  self.baseaccuracy = getdvarfloat("dvar_BC2A2DEB983296DC", 2.0);
  self.accuracy = self.baseaccuracy;
  _id_B3DAE16DDEA1A670();
  thread _id_DDC00066411131BC();
  thread _id_473371A80215AF61(3);
  thread _id_9211CFE8D7488EFE();
  thread _id_08205B9550AE88E5("defender_wave_win");
}

_id_9E75502E1061EA5C() {
  self endon("death");
  wait 1;

  if(!isDefined(level._id_3CEBD4D749F98004)) {
    _id_3CEBD4D749F98004 = [];
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 80;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 100;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 80;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 120;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 80;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 140;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 160;
    _id_3CEBD4D749F98004[_id_3CEBD4D749F98004.size] = 520;
    level._id_3CEBD4D749F98004 = scripts\engine\utility::create_deck(_id_3CEBD4D749F98004);
  }

  armor = level._id_3CEBD4D749F98004 scripts\engine\utility::deck_draw();
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = armor;
  self.armorhealth = armor;
  self._id_8790C077C95DB752 = armor;
  helmet = int(armor / 100);
  helmet = clamp(helmet, 0, 5);
  _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, undefined, undefined, armor, helmet, 0);
}

_id_DDC00066411131BC() {
  self endon("death");
  wait 3;

  if(istrue(self._id_4030AF6E547AF52B)) {
    return;
  }
  if(istrue(level._id_BFC0F958D6B6B27F)) {
    return;
  }
  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.targetname)) {
    if(!issubstr(self.spawnpoint.targetname, "respawn"))
      return;
  }

  scripts\common\ai::magic_bullet_shield(1);
  thread _id_6E8696A6F8014862();
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
  cantakedamage = 0;

  if(isDefined(_id_A02118632C7F1621) && _id_A02118632C7F1621.size > 0) {
    for(;;) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A02118632C7F1621.size; _id_AC0E594AC96AA3A8++) {
        if(distance(self.origin, _id_A02118632C7F1621[_id_AC0E594AC96AA3A8].origin) < 1500) {
          cantakedamage = 1;
          break;
        }
      }

      if(istrue(self._id_B172B48DE3A23972))
        cantakedamage = 1;

      if(cantakedamage) {
        break;
      }

      wait 1;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 60; _id_AC0E594AC96AA3A8++) {
    if(istrue(self._id_B172B48DE3A23972))
      _id_AC0E594AC96AA3A8 = 60;

    wait 1;
  }

  scripts\common\ai::stop_magic_bullet_shield();
  self notify("endDeathShield");
}

_id_6E8696A6F8014862() {
  self endon("death");
  self endon("endDeathShield");
  spawned_ai = [];
  _id_636C8575D7A7768B = 400;

  while(spawned_ai.size == 0) {
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      if(guys[_id_AC0E594AC96AA3A8] scripts\cp\utility::isjuggernaut())
        spawned_ai[spawned_ai.size] = guys[_id_AC0E594AC96AA3A8];
    }

    wait 5;
  }

  for(;;) {
    foreach(_id_E21279FA90BDF012 in spawned_ai) {
      if(!isDefined(_id_E21279FA90BDF012) || !isalive(_id_E21279FA90BDF012) || !_id_E21279FA90BDF012 scripts\cp\utility::isjuggernaut()) {
        continue;
      }
      if(distance2d(_id_E21279FA90BDF012.origin, self.origin) < _id_636C8575D7A7768B) {
        self._id_B172B48DE3A23972 = 1;
        return;
      }
    }

    wait 1;
  }
}

_id_B3DAE16DDEA1A670() {
  if(!isDefined(level._id_6664BAC2A45BC0A0) || level._id_6664BAC2A45BC0A0.size == 0) {
    if(isDefined(level._id_E16F8BE936AE77A5))
      [[level._id_E16F8BE936AE77A5]]();
    else
      _id_77C06ABBD3EFB119();
  }

  if(level._id_6664BAC2A45BC0A0.size > 0) {
    self._id_50C39E58AF7F7018 = scripts\engine\utility::random(level._id_6664BAC2A45BC0A0);
    level._id_6664BAC2A45BC0A0 = scripts\engine\utility::array_remove(level._id_6664BAC2A45BC0A0, self._id_50C39E58AF7F7018);
    self _meth_3DE79443C911D4A5(1, 2, self._id_50C39E58AF7F7018);
  }
}

_id_77C06ABBD3EFB119() {
  level._id_6664BAC2A45BC0A0 = [];
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_ADAMSON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_ARRIZON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_CECOT";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_DENNY";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_EGAN";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_EGERT";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_CHEN";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_GARRIDO";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_JONES";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LEEAMIES";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LIMAYE";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_LUO";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MASON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MILLER";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_OHARA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PARISE";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PIERRO";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_PIERSON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_RAMON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_RIEKE";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_SALOMON";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_SANDOVAL";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_STASICA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_THIES";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_UYEDA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_HOLMES";
}

_id_9211CFE8D7488EFE() {
  level endon("game_ended");
  self waittill("death");
  _id_48F20B0FE71DD6DF::_id_2AC057864B3892E8();

  if(!isDefined(self.team))
    self.team = "allies";

  if(isDefined(level._id_F78FB7634E3797C4) && scripts\engine\utility::array_contains(level._id_F78FB7634E3797C4, self))
    level._id_F78FB7634E3797C4 = scripts\engine\utility::array_remove(level._id_F78FB7634E3797C4, self);

  if(isDefined(self.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
    self.headicon = undefined;
  }
}

_id_08205B9550AE88E5(_id_9302F2A5C3E99DD5) {
  self endon("death");
  _id_293ABF11561D67F2 = int(self.maxhealth * 0.1);

  for(;;) {
    level waittill(_id_9302F2A5C3E99DD5);

    if(self.health < self.maxhealth) {
      if(self.health >= self.maxhealth - _id_293ABF11561D67F2) {
        self.health = self.maxhealth;
        continue;
      }

      self.health = self.health + _id_293ABF11561D67F2;
    }
  }
}

_id_B66475303992B813() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return undefined;

  return scripts\engine\utility::random(level._id_F78FB7634E3797C4);
}

_id_222DEBB6FDD28FB7() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return undefined;

  return scripts\engine\utility::getclosest(self.origin, level._id_F78FB7634E3797C4);
}

_id_D43578C37AA09B2D() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return 6;

  return level._id_F78FB7634E3797C4.size;
}

_id_473371A80215AF61(interval) {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  for(;;) {
    if(istrue(self._id_522869EDBF9EB8FE)) {} else
      _id_D94933A1CE5E1AFC();

    wait(interval + randomfloat(0.15));
  }
}

_id_D94933A1CE5E1AFC() {
  if(!isDefined(self._id_EC7F24B7685542B0) || !isDefined(self._id_12DABD81F41B0E1A)) {
    return;
  }
  _id_6E281DBD69FC980E = self getclosestreachablepointonnavmesh(self._id_12DABD81F41B0E1A);

  if(isDefined(self._id_C812E56AAC3CF3F2) && distance2d(self._id_C812E56AAC3CF3F2, _id_6E281DBD69FC980E) <= 128) {
    return;
  }
  self._id_C812E56AAC3CF3F2 = _id_6E281DBD69FC980E;
  self setgoalpos(_id_6E281DBD69FC980E);
}

_id_01DF4F4FC6E338CC(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D, _id_21A2442ADB816DD6) {
  _id_6D455CCA8AC3B436 = distance(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D);
  _id_666D077F74E2DEE6 = _id_21A2442ADB816DD6 / _id_6D455CCA8AC3B436;
  x = _id_BF6A083C5A5402A4[0] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[0] - _id_BF6A0B3C5A54093D[0]);
  y = _id_BF6A083C5A5402A4[1] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[1] - _id_BF6A0B3C5A54093D[1]);
  z = _id_BF6A083C5A5402A4[2] - _id_666D077F74E2DEE6 * (_id_BF6A083C5A5402A4[2] - _id_BF6A0B3C5A54093D[2]) + 250;
  return scripts\engine\utility::drop_to_ground((x, y, z), 50);
}

_id_A59F06F4B5F8F8B0(center, point, angle) {
  _id_7F053C4B79E7834A = cos(angle) * (point[0] - center[0]) - sin(angle) * (point[1] - center[1]) + center[0];
  _id_7F053D4B79E7857D = sin(angle) * (point[0] - center[0]) + cos(angle) * (point[1] - center[1]) + center[1];
  _id_7F053A4B79E77EE4 = point[2] + 250;
  return scripts\engine\utility::drop_to_ground((_id_7F053C4B79E7834A, _id_7F053D4B79E7857D, point[2]), 50);
}

_id_642C414187745491() {
  level endon("game_ended");

  if(istrue(level._id_8186A15EA69AF017)) {
    return;
  }
  level._id_8186A15EA69AF017 = 1;

  for(_id_C8D8D6659E4C6318 = _id_5CB623572B271C34::_id_5BD736549F8D4441(); isDefined(_id_C8D8D6659E4C6318) && _id_C8D8D6659E4C6318.size > 0; _id_C8D8D6659E4C6318 = _id_5CB623572B271C34::_id_5BD736549F8D4441())
    wait 1;

  level thread _id_48F20B0FE71DD6DF::_id_FFF151C38D29F877();
  level._id_8186A15EA69AF017 = undefined;
}

_id_352559B3C422FEE2(_id_32F2098B0BA7ED28, _id_5FF76B0E0C5B9EEE) {
  level endon("game_ended");
  level endon("spawn_module_" + _id_32F2098B0BA7ED28.group_name + "_completed");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(istrue(level._id_21F279867AD3E473)) {
    if(isDefined(level._id_898575DB3C10AC91))
      [[level._id_898575DB3C10AC91]](_id_32F2098B0BA7ED28, _id_5FF76B0E0C5B9EEE);
    else
      _id_E311FCF5FF789376(_id_32F2098B0BA7ED28, _id_5FF76B0E0C5B9EEE);
  }

  _id_D219AF81A2A0505B = level.players[0];
  _id_C61AC90DBA85B186 = _id_D219AF81A2A0505B;
  _id_8FAB55E4E1D145F1 = undefined;
  player_vehicle = undefined;
  _id_9D46D3C9B8E90AF9 = undefined;
  _id_240A5ED442A1A68E = level.players[_id_5FF76B0E0C5B9EEE];
  _id_310A3C99DD5399E6 = 0;
  _id_4AC824A730E3A05F = 900;

  if(isDefined(level._id_07DEE064EF025310))
    _id_4AC824A730E3A05F = level._id_07DEE064EF025310;

  _id_EC9D4178D9B5258D = _id_4AC824A730E3A05F * _id_4AC824A730E3A05F;

  for(;;) {
    wait 1;

    if(isDefined(level.players[_id_5FF76B0E0C5B9EEE]))
      _id_240A5ED442A1A68E = level.players[_id_5FF76B0E0C5B9EEE];

    if(isDefined(_id_240A5ED442A1A68E) && isent(_id_240A5ED442A1A68E) && isalive(_id_240A5ED442A1A68E))
      _id_D219AF81A2A0505B = _id_240A5ED442A1A68E;
    else
      _id_D219AF81A2A0505B = _id_C61AC90DBA85B186;

    if(!isDefined(_id_D219AF81A2A0505B.origin)) {
      continue;
    }
    _id_024F8E49663E8A23(_id_32F2098B0BA7ED28, _id_D219AF81A2A0505B);

    if(isDefined(level._id_FECE02A99189C2DE))
      _id_8FAB55E4E1D145F1 = scripts\engine\utility::getclosest(_id_D219AF81A2A0505B.origin, level._id_FECE02A99189C2DE);
    else {
      _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
      _id_8FAB55E4E1D145F1 = scripts\engine\utility::getclosest(_id_D219AF81A2A0505B.origin, _id_A02118632C7F1621);
    }

    if(!isDefined(_id_8FAB55E4E1D145F1) || !isDefined(_id_D219AF81A2A0505B) || !isalive(_id_D219AF81A2A0505B)) {
      continue;
    }
    if(isDefined(_id_240A5ED442A1A68E) && _id_D219AF81A2A0505B == _id_240A5ED442A1A68E)
      _id_310A3C99DD5399E6 = 1;
    else
      _id_310A3C99DD5399E6 = 0;

    player_vehicle = undefined;
    _id_66FB730E338F458A = _id_D219AF81A2A0505B scripts\cp_mp\utility\player_utility::isinvehicle();
    _id_0D911154D12583FA = 0;
    _id_6CC1B819F498DE33 = 0;

    if(istrue(_id_66FB730E338F458A) && _id_6CC1B819F498DE33) {
      player_vehicle = _id_D219AF81A2A0505B scripts\cp_mp\utility\player_utility::getvehicle();
      _id_3D22F278EFD315CC = player_vehicle scripts\common\vehicle_code::get_vehicle_classname();
      _id_CF1AA04397D21C79 = level.vehicle.templates.aianims[_id_3D22F278EFD315CC];
      _id_0D911154D12583FA = isDefined(_id_CF1AA04397D21C79) && _id_CF1AA04397D21C79.size > 0;
    }

    if(_id_66FB730E338F458A && _id_310A3C99DD5399E6 && istrue(_id_0D911154D12583FA) && _id_6CC1B819F498DE33) {
      player_vehicle = _id_D219AF81A2A0505B scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(_id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9) && _id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9 == player_vehicle) {
        continue;
      }
      _id_9D46D3C9B8E90AF9 = player_vehicle;
      _id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9 = player_vehicle;
      _id_CA2DC9920905932E = [];
      _id_3D22F278EFD315CC = player_vehicle scripts\common\vehicle_code::get_vehicle_classname();

      if(!player_vehicle scripts\common\vehicle::ishelicopter()) {
        _id_CF1AA04397D21C79 = level.vehicle.templates.aianims[_id_3D22F278EFD315CC];
        _id_B98B68C6944E0106 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(player_vehicle);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CF1AA04397D21C79.size; _id_AC0E594AC96AA3A8++) {
          if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8]) && !isDefined(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8].vehicle_position))
            _id_CA2DC9920905932E[_id_CA2DC9920905932E.size] = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
        }

        if(!player_vehicle scripts\engine\utility::ent_flag_exist("unloaded"))
          player_vehicle scripts\engine\utility::ent_flag_init("unloaded");

        if(!player_vehicle scripts\engine\utility::ent_flag_exist("loaded"))
          player_vehicle scripts\engine\utility::ent_flag_init("loaded");

        if(!player_vehicle scripts\engine\utility::ent_flag_exist("landed"))
          player_vehicle scripts\engine\utility::ent_flag_init("landed");

        if(!isDefined(player_vehicle.riders)) {
          player_vehicle.riders = [];
          player_vehicle.unloadque = [];
          player_vehicle.unload_group = "default";
          player_vehicle.vehicleanimalias = "techo_cp";
          player_vehicle scripts\common\vehicle_aianim::handle_attached_guys();
        }

        if(_id_CA2DC9920905932E.size > 0) {
          player_vehicle thread scripts\common\vehicle::vehicle_load_ai(_id_CA2DC9920905932E);
          player_vehicle.riders = _id_CA2DC9920905932E;

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player_vehicle.riders.size; _id_AC0E594AC96AA3A8++)
            player_vehicle.riders[_id_AC0E594AC96AA3A8].vehicle_position = _id_AC0E594AC96AA3A8;
        }
      }

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8]) || !isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
          continue;
        }
        if(!isDefined(scripts\engine\utility::array_find(_id_CA2DC9920905932E, _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])))
          continue;
      }

      continue;
    }

    if(isDefined(_id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9) && isalive(_id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9) && !istrue(_id_66FB730E338F458A)) {
      _id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9 scripts\common\vehicle::vehicle_unload();
      _id_D219AF81A2A0505B._id_9D46D3C9B8E90AF9 = undefined;
    }

    _id_6CB568FEC1CF255A = 512;

    if(scripts\cp\utility::is_indoors(_id_D219AF81A2A0505B))
      _id_6CB568FEC1CF255A = 256;

    _id_79E1A5E2979F19A4 = _id_01DF4F4FC6E338CC(_id_D219AF81A2A0505B.origin, _id_8FAB55E4E1D145F1.origin, _id_6CB568FEC1CF255A);
    _id_B8FDC4D85662301A = [30, 60, -30, -60, 90, -90, 100, -100, 110, -110, 120, -120, 130, -130, 140, -140, 150, -150, 160, -160, 170, -170];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
      if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
        soldier = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
        soldier._id_894D1167ACE5B58C = 1;
        _id_38690AA00C4C968F = distance2dsquared(_id_D219AF81A2A0505B.origin, _id_8FAB55E4E1D145F1.origin) < _id_EC9D4178D9B5258D;

        if(istrue(_id_D219AF81A2A0505B.inlaststand))
          _id_38690AA00C4C968F = 1;

        if(_id_38690AA00C4C968F) {
          soldier thread _id_FAFBF15E4BA8ACB2(_id_8FAB55E4E1D145F1);
          soldier _id_18A73A64992DD07D::set_goal_radius(int(8));
          soldier._id_EE2257DCCC5D6DF8 = soldier.combatmode;
          soldier.combatmode = "cover";

          if(!isDefined(soldier._id_CBD46EDCC123806C)) {
            cover_nodes = getnodesinradius(_id_8FAB55E4E1D145F1.origin, 500, 1, 72);
            _id_0386C209C4BE9E91 = scripts\engine\utility::random(cover_nodes);

            if(isDefined(_id_0386C209C4BE9E91)) {
              soldier._id_CBD46EDCC123806C = _id_0386C209C4BE9E91;
              soldier._id_12DABD81F41B0E1A = _id_0386C209C4BE9E91.origin;
              soldier _meth_30377946FC33F8A7(soldier._id_CBD46EDCC123806C);
              soldier setgoalnode(soldier._id_CBD46EDCC123806C);
            } else {
              _id_DA83589DC0B1BB68 = getclosestpointonnavmesh(_id_D219AF81A2A0505B.origin);
              soldier setgoalpos(_id_DA83589DC0B1BB68);
            }
          }

          continue;
        }

        soldier thread _id_7E8B12058CFCE4AC();
        soldier._id_12DABD81F41B0E1A = _id_D219AF81A2A0505B.origin;

        if(isDefined(_id_B8FDC4D85662301A[_id_AC0E594AC96AA3A8])) {
          soldier._id_12DABD81F41B0E1A = _id_A59F06F4B5F8F8B0(_id_D219AF81A2A0505B.origin, _id_79E1A5E2979F19A4, _id_B8FDC4D85662301A[_id_AC0E594AC96AA3A8]);
          soldier._id_12DABD81F41B0E1A = soldier._id_12DABD81F41B0E1A + scripts\engine\utility::flatten_vector(scripts\engine\utility::randomvectorrange(10, 50));
        }

        soldier._id_D219AF81A2A0505B = _id_D219AF81A2A0505B;
        soldier.owner = _id_D219AF81A2A0505B;
        soldier._id_CBD46EDCC123806C = undefined;
        soldier _id_18A73A64992DD07D::set_goal_radius(int(250));

        if(isDefined(soldier._id_EE2257DCCC5D6DF8))
          soldier.combatmode = soldier._id_EE2257DCCC5D6DF8;
      }
    }
  }
}

_id_024F8E49663E8A23(_id_32F2098B0BA7ED28, owner) {
  if(isDefined(_id_32F2098B0BA7ED28._id_A9BBDC3A78D13C12) && _id_32F2098B0BA7ED28._id_A9BBDC3A78D13C12 == owner) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
      soldier = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
      soldier.owner = owner;
    }
  }

  _id_32F2098B0BA7ED28._id_A9BBDC3A78D13C12 = owner;
}

_id_0435C420F944AC11(player_vehicle, _id_D219AF81A2A0505B, _id_CA2DC9920905932E) {
  level endon("game_ended");
  _id_D219AF81A2A0505B scripts\engine\utility::waittill_any_3("vehicle_exit", "disconnect", "death");

  foreach(rider in _id_CA2DC9920905932E) {
    if(!isalive(rider))
      continue;
  }
}

_id_FAFBF15E4BA8ACB2(_id_772E439B44CE2C1E) {
  if(isDefined(level._id_C9541A655AD22551) && level._id_C9541A655AD22551 == _id_772E439B44CE2C1E) {
    return;
  }
  _id_EB096A3D2E8804AE = 20000;

  if(isDefined(level._id_8D2B529060030BC4) && gettime() < level._id_8D2B529060030BC4 + _id_EB096A3D2E8804AE) {
    return;
  }
  if(istrue(self.group._id_2D9D16FE3393D947)) {
    return;
  }
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_772E439B44CE2C1E);
  thread _id_48F20B0FE71DD6DF::_id_00D22B9E567F113A(id);
  level._id_8D2B529060030BC4 = gettime();
  level._id_C9541A655AD22551 = _id_772E439B44CE2C1E;
  self.group._id_2D9D16FE3393D947 = 1;
  self._id_CC8EC1B830EF3DFF = undefined;
  self.group._id_CC8EC1B830EF3DFF = undefined;
}

_id_04FCC1D94CD34134(id) {
  dialog = undefined;

  if(id == "a") {
    switch (self.group.group_name) {
      case "ally_ai_respawn_1":
      case "ally_ai_1":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_1_GOING_A";
        break;
      case "ally_ai_respawn_2":
      case "ally_ai_2":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_2_GOING_A";
        break;
    }
  } else if(id == "b") {
    switch (self.group.group_name) {
      case "ally_ai_respawn_1":
      case "ally_ai_1":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_1_GOING_B";
        break;
      case "ally_ai_respawn_2":
      case "ally_ai_2":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_2_GOING_B";
        break;
    }
  } else if(id == "c") {
    switch (self.group.group_name) {
      case "ally_ai_respawn_1":
      case "ally_ai_1":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_1_GOING_C";
        break;
      case "ally_ai_respawn_2":
      case "ally_ai_2":
        dialog = &"CP_MISSION_DEFENDER/DIALOG_SQUAD_2_GOING_C";
        break;
    }
  }

  return dialog;
}

_id_7E8B12058CFCE4AC() {
  if(isDefined(level._id_80F068F06FD7E5C0) && gettime() < level._id_80F068F06FD7E5C0 + 9000) {
    return;
  }
  if(istrue(self._id_CC8EC1B830EF3DFF) || istrue(self.group._id_CC8EC1B830EF3DFF)) {
    return;
  }
  thread _id_48F20B0FE71DD6DF::_id_107A3DC15AFB78BD();
  level._id_80F068F06FD7E5C0 = gettime();
  self._id_CC8EC1B830EF3DFF = 1;
  self.group._id_CC8EC1B830EF3DFF = 1;
  self.group._id_2D9D16FE3393D947 = undefined;
}

_id_F8E9E44430B5469E(_id_32F2098B0BA7ED28) {
  level endon("game_ended");
  level endon("defender_intro_completed");
  level endon("intro_soldier_damaged");
  level endon("defender_intro_play");

  if(level._id_EFE609BCE901CAA8) {
    if(istrue(level._id_DCE708FBCB2EB2ED)) {
      return;
    }
    if(!isDefined(level._id_C28487B3FEAD096F)) {
      level._id_C28487B3FEAD096F = [];
      level._id_C28487B3FEAD096F[level._id_C28487B3FEAD096F.size] = scripts\engine\utility::getStruct("ally_intro_cover_1", "targetname");
      level._id_C28487B3FEAD096F[level._id_C28487B3FEAD096F.size] = scripts\engine\utility::getStruct("ally_intro_cover_2", "targetname");
    }

    while(!isDefined(_id_32F2098B0BA7ED28) || _id_32F2098B0BA7ED28.ai_spawned.size < 1)
      wait 0.1;

    wait 0.1;
    _id_1541E28C207DA1DE = (0, 0, 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
      if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
        soldier = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
        soldier._id_894D1167ACE5B58C = 1;
        _id_D40311A017522176 = scripts\engine\utility::random(level._id_C28487B3FEAD096F);
        level._id_C28487B3FEAD096F = scripts\engine\utility::array_remove(level._id_C28487B3FEAD096F, _id_D40311A017522176);
        cover_nodes = getnodesinradius(_id_D40311A017522176.origin, 50, 1, 72);
        _id_0386C209C4BE9E91 = scripts\engine\utility::random(cover_nodes);

        if(!isDefined(_id_0386C209C4BE9E91))
          _id_0386C209C4BE9E91 = _id_FBF5C5BA55ABF236(_id_D40311A017522176);

        _id_1541E28C207DA1DE = _id_0386C209C4BE9E91.origin;

        if(isDefined(_id_0386C209C4BE9E91)) {
          soldier._id_CBD46EDCC123806C = _id_0386C209C4BE9E91;
          soldier._id_12DABD81F41B0E1A = _id_0386C209C4BE9E91.origin;
          soldier _meth_30377946FC33F8A7(soldier._id_CBD46EDCC123806C);
          soldier setgoalnode(soldier._id_CBD46EDCC123806C);
        }
      }
    }

    wait 15;
    maxdist = 160000;

    while(!scripts\cp\utility::any_player_nearby(_id_1541E28C207DA1DE, maxdist))
      wait 0.1;
  }

  wait 1;
  level._id_DCE708FBCB2EB2ED = 1;
  level notify("defender_intro_play");
}

_id_FBF5C5BA55ABF236(struct) {
  struct.covernode = spawncovernode(struct.origin, struct.angles, "Exposed", 21);

  if(isDefined(struct.radius))
    struct.covernode.radius = struct.radius;

  return struct.covernode;
}

_id_E311FCF5FF789376(_id_32F2098B0BA7ED28, _id_5FF76B0E0C5B9EEE) {
  level endon("game_ended");
  level endon("defender_intro_completed");
  _id_240A5ED442A1A68E = level.player;
  _id_D2BF0E97D3015267 = 0;

  switch (_id_32F2098B0BA7ED28.group_name) {
    case "ally_ai_respawn_1":
    case "ally_ai_respawn_2":
      _id_D2BF0E97D3015267 = 1;
      break;
  }

  if(!_id_D2BF0E97D3015267)
    level _id_F8E9E44430B5469E(_id_32F2098B0BA7ED28);

  for(_id_D67D85A99B044AFD = 0; !isDefined(_id_32F2098B0BA7ED28) || !isDefined(_id_32F2098B0BA7ED28.ai_spawned) || _id_32F2098B0BA7ED28.ai_spawned.size < 1; _id_D67D85A99B044AFD = 1)
    wait 0.1;

  if(_id_D67D85A99B044AFD)
    wait 0.1;

  level._id_EE8B8EE8B367149F = 0;

  if(isDefined(level.players[_id_5FF76B0E0C5B9EEE]))
    _id_240A5ED442A1A68E = level.players[_id_5FF76B0E0C5B9EEE];

  _id_13C9C224C71F19C1 = scripts\engine\utility::getStruct("intro_ally_target_00", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32F2098B0BA7ED28.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8])) {
      soldier = _id_32F2098B0BA7ED28.ai_spawned[_id_AC0E594AC96AA3A8];
      soldier._id_894D1167ACE5B58C = 1;

      if(isDefined(_id_13C9C224C71F19C1))
        soldier scripts\engine\utility::delaythread(_id_AC0E594AC96AA3A8 + 0.1, ::_id_95C961A472192A0A, soldier, _id_13C9C224C71F19C1, _id_D2BF0E97D3015267);
    }
  }

  wait 2;

  if(scripts\engine\utility::flag("defender_intro_completed")) {
    return;
  }
  for(;;) {
    if(isDefined(level.players[_id_5FF76B0E0C5B9EEE]))
      _id_240A5ED442A1A68E = level.players[_id_5FF76B0E0C5B9EEE];

    _id_024F8E49663E8A23(_id_32F2098B0BA7ED28, _id_240A5ED442A1A68E);

    if(scripts\engine\utility::flag("defender_intro_completed")) {
      return;
    }
    wait 5;
  }
}

_id_95C961A472192A0A(soldier, struct, _id_D2BF0E97D3015267) {
  level endon("game_ended");
  soldier endon("death");
  level thread _id_48F20B0FE71DD6DF::_id_DE641834E3B74898(soldier);
  _id_E9EE63D282F1D816 = 1;
  _id_12B0F825F87DB633 = _id_7E3E9340D6564E5C(struct);
  soldier thread _id_5497DE138A128266();

  if(istrue(_id_D2BF0E97D3015267)) {
    _id_FD7110EE1A817E91 = _id_6DD2249303C428DD(struct, soldier);
    struct = _id_FD7110EE1A817E91;
  }

  while(isDefined(struct.target)) {
    _id_2DC0BDD4C3F47785 = undefined;
    _id_51320540F35AB7FF = undefined;
    _id_965EFA67BE338BA6 = undefined;
    _id_AE7FBC9B7B67D9B5 = 10000;

    if(isDefined(struct.radius))
      _id_AE7FBC9B7B67D9B5 = struct.radius * struct.radius;

    if(isDefined(struct.script_noteworthy)) {
      switch (struct.script_noteworthy) {
        case "crouch":
          _id_2DC0BDD4C3F47785 = 1;
          break;
        case "point":
          _id_51320540F35AB7FF = 1;
          break;
        case "infilwait":
          _id_965EFA67BE338BA6 = 1;
          break;
      }
    }

    soldier _id_18A73A64992DD07D::set_goal_radius(int(sqrt(_id_AE7FBC9B7B67D9B5)));
    soldier _id_18A73A64992DD07D::set_goal_pos(struct.origin);
    soldier.goalheight = 128;

    if(isDefined(struct.script_goalheight))
      soldier.goalheight = struct.script_goalheight;

    if(struct == _id_12B0F825F87DB633)
      soldier _id_18A73A64992DD07D::set_goal_pos(struct.origin - (0, 0, 64));

    _id_5E9FFA0C5D39BAA1 = distancesquared(soldier.origin, struct.origin);
    _id_920C9B94FE98F926 = _id_5E9FFA0C5D39BAA1;

    while(_id_920C9B94FE98F926 > _id_AE7FBC9B7B67D9B5 * 2) {
      _id_920C9B94FE98F926 = distancesquared(soldier.origin, struct.origin);

      if(_id_920C9B94FE98F926 > _id_5E9FFA0C5D39BAA1 * 1.4) {
        struct = _id_12B0F825F87DB633;
        _id_2DC0BDD4C3F47785 = 0;
        _id_51320540F35AB7FF = 0;
        _id_E9EE63D282F1D816 = 0;
        break;
      }

      wait 0.05;
    }

    if(istrue(_id_2DC0BDD4C3F47785)) {
      soldier allowedstances("crouch");
      soldier _meth_B11B5190B03C861C("none");
      soldier _id_9989482A4750667F();
      soldier thread _id_6087D4934775747B(2);
      wait 0.25;
    } else if(istrue(_id_965EFA67BE338BA6)) {
      soldier _meth_B11B5190B03C861C("none");
      soldier _id_436A1B051EE7156B(struct);
      wait 0.25;
    }

    if(istrue(_id_51320540F35AB7FF) && level._id_EFE609BCE901CAA8) {
      if(!isDefined(level._id_51320540F35AB7FF)) {
        level._id_51320540F35AB7FF = gettime();
        wait 1;
        _id_DCB42738E8FB72EA = scripts\engine\utility::getStruct("intro_ally_target_00_point", "targetname");
        soldier _id_18A73A64992DD07D::set_goal_radius(64);
        soldier _id_18A73A64992DD07D::set_goal_pos(_id_DCB42738E8FB72EA.origin);
        wait 1;
        level thread _id_48F20B0FE71DD6DF::_id_85B2A3F43E3EB338();
        wait 1.75;
      }
    }

    if(_id_E9EE63D282F1D816)
      struct = scripts\engine\utility::getStruct(struct.target, "targetname");
  }

  _id_AE7FBC9B7B67D9B5 = 10000;

  if(isDefined(struct.radius))
    _id_AE7FBC9B7B67D9B5 = struct.radius * struct.radius;

  soldier.goalheight = 80;
  soldier _id_18A73A64992DD07D::set_goal_radius(int(sqrt(_id_AE7FBC9B7B67D9B5)));
  soldier _id_18A73A64992DD07D::set_goal_pos(struct.origin - (0, 0, soldier.goalheight));
}

_id_829FA89741FDCB7F(delay) {
  self endon("death");
  _id_A29497B5A1296685 = self._blackboard.requestedspeed;
  scripts\engine\utility::set_movement_speed(25);

  if(isDefined(delay))
    wait(delay);
  else
    wait 2;

  _id_920AE12BD971845F = min(200, _id_A29497B5A1296685);
  scripts\engine\utility::set_movement_speed(_id_920AE12BD971845F);
}

_id_6087D4934775747B(delay) {
  self endon("death");
  wait 0.1;
  self allowedstances("stand");

  if(isDefined(delay))
    wait(delay);
  else
    wait 2;

  self allowedstances("stand", "crouch");
}

_id_349680B7FEEFDC83() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F78FB7634E3797C4.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level._id_F78FB7634E3797C4[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    if(scripts\engine\utility::is_dead_or_dying(level._id_F78FB7634E3797C4[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    level._id_F78FB7634E3797C4[_id_AC0E594AC96AA3A8] scripts\engine\utility::set_movement_speed(200);
  }
}

_id_7E3E9340D6564E5C(struct) {
  if(!isDefined(struct.target))
    return struct;

  for(struct = scripts\engine\utility::getStruct(struct.target, "targetname"); isDefined(struct.target); struct = scripts\engine\utility::getStruct(struct.target, "targetname")) {}

  return struct;
}

_id_473A7BFC01BE4033(struct) {
  if(!isDefined(struct.target))
    return [struct];

  _id_FF65D6C608A23A56 = [];

  for(struct = scripts\engine\utility::getStruct(struct.target, "targetname"); isDefined(struct.target); _id_FF65D6C608A23A56[_id_FF65D6C608A23A56.size] = struct)
    struct = scripts\engine\utility::getStruct(struct.target, "targetname");

  return _id_FF65D6C608A23A56;
}

_id_6DD2249303C428DD(first_struct, soldier) {
  _id_FF65D6C608A23A56 = _id_473A7BFC01BE4033(first_struct);
  _id_FDB9974A1CCCE54C = 81000000;
  _id_B88AA9CCEE86B6A3 = first_struct;

  foreach(_id_16E1581A754501AC in _id_FF65D6C608A23A56) {
    _id_5EE5A07D7D8DC443 = distancesquared(soldier.origin, _id_16E1581A754501AC.origin);

    if(_id_5EE5A07D7D8DC443 < _id_FDB9974A1CCCE54C) {
      _id_FDB9974A1CCCE54C = _id_5EE5A07D7D8DC443;
      _id_B88AA9CCEE86B6A3 = _id_16E1581A754501AC;
    }
  }

  if(isDefined(_id_B88AA9CCEE86B6A3.target)) {
    _id_EC3EF5CA79D12AE6 = scripts\engine\utility::getStruct(_id_B88AA9CCEE86B6A3.target, "targetname");
    _id_694804CCBACC76D9 = _id_EC3EF5CA79D12AE6.origin - _id_B88AA9CCEE86B6A3.origin;
    _id_86279FB19D007225 = _id_C66A5347CA4AD69A(_id_B88AA9CCEE86B6A3, _id_EC3EF5CA79D12AE6);

    if(_id_86279FB19D007225)
      _id_B88AA9CCEE86B6A3 = _id_EC3EF5CA79D12AE6;
  }

  return _id_B88AA9CCEE86B6A3;
}

_id_C66A5347CA4AD69A(node, target, _id_3B37CA6EC4D56E75) {
  dir = vectorNormalize((target.origin - node.origin) * (1, 1, 0));
  fwd = anglesToForward(node.angles);
  dot = vectordot(dir, fwd);

  if(!isDefined(_id_3B37CA6EC4D56E75))
    return dot > 0;

  return dot > _id_3B37CA6EC4D56E75;
}

_id_9989482A4750667F() {
  level endon("level_ended");
  level endon("intro_soldier_damaged");

  if(!scripts\engine\utility::flag_exist("deltaSquad_introEngage"))
    scripts\engine\utility::flag_init("deltaSquad_introEngage");

  if(istrue(level._id_E961004A63D606FD)) {
    wait 1;
    return;
  }

  level thread _id_48F20B0FE71DD6DF::_id_4F12585AE2E9B952(self);
  childthread _id_55A8EC46E11D14DA();

  if(!isDefined(level._id_EF4D698BBD3D1AC5))
    level._id_EF4D698BBD3D1AC5 = 0;

  level._id_EF4D698BBD3D1AC5++;
  _id_385CCF06380FE17F = level._id_EF4D698BBD3D1AC5;
  _id_CDC5DD6C28C9709D = squared(500);
  level thread _id_E61367B0E344BD40(self.origin, _id_CDC5DD6C28C9709D);
  _id_28CBF87065B24740 = squared(1500);
  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  level thread _id_E61367B0E344BD40(_id_278BA2944DB8A0EA.origin, _id_28CBF87065B24740);
  level thread _id_ABD08E0038AFC8E3();
  scripts\engine\utility::flag_wait("deltaSquad_introEngage");
  wait(1 + _id_385CCF06380FE17F * 0.5);
  level thread _id_48F20B0FE71DD6DF::_id_455F8E627F5B3E04(self);

  if(!istrue(level._id_E961004A63D606FD)) {
    level._id_E961004A63D606FD = 1;

    if(isalive(self)) {
      closestplayer = scripts\cp\utility::get_closest_living_player();

      if(isDefined(closestplayer)) {
        alias = "stat_A468B6BBF3BA3B66";
        level thread _id_48F20B0FE71DD6DF::_id_A9632ED81F365867(closestplayer, alias);
      }
    }

    level thread _id_9C506A9D5C505E23();
  }
}

_id_55A8EC46E11D14DA() {
  level endon("game_ended");
  level endon("deltaSquad_introEngage");
  level endon("defender_intro_completed");
  level endon("intro_soldier_damaged");

  if(!istrue(level._id_21F279867AD3E473)) {
    return;
  }
  _id_3DEF217D9BD38E42 = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_88A17B45B2570488 = squared(2000);

  if(scripts\cp\utility::any_player_nearby(_id_3DEF217D9BD38E42.origin, _id_88A17B45B2570488)) {
    return;
  }
  for(;;) {
    if(isDefined(level._id_7AB4EB7E8D289A79)) {
      return;
    }
    _id_3A7E743E27BB9B54 = squared(1000);

    if(!isDefined(level._id_7AB4EB7E8D289A79) && !scripts\cp\utility::any_player_nearby(self.origin, _id_3A7E743E27BB9B54)) {
      objindex = scripts\cp\cp_objectives::requestworldid("defender_intropath_waypoint");
      objective_state(objindex, "current");
      objective_position(objindex, self getEye() + (0, 0, 16));
      objective_icon(objindex, "icon_waypoint_objective_general");
      objective_setminimapiconsize(objindex, "icon_small");
      objective_setshowdistance(objindex, 1);
      objective_setplayintro(objindex, 1);
      objective_sethot(objindex, 0);
      objective_setownerteam(objindex, "allies");
      objective_setbackground(objindex, 1);
      level._id_7AB4EB7E8D289A79 = objindex;
    }

    wait 2;
  }
}

_id_9C506A9D5C505E23() {
  if(isDefined(level._id_7AB4EB7E8D289A79)) {
    objective_delete(level._id_7AB4EB7E8D289A79);
    scripts\cp\cp_objectives::freeworldidbyobjid(level._id_7AB4EB7E8D289A79);
    level._id_7AB4EB7E8D289A79 = 0;
  }
}

_id_E61367B0E344BD40(origin, _id_CDC5DD6C28C9709D) {
  level endon("game_ended");
  level endon("deltaSquad_introEngage");

  while(!scripts\cp\utility::any_player_nearby(origin, _id_CDC5DD6C28C9709D))
    wait 0.1;

  scripts\engine\utility::flag_set("deltaSquad_introEngage");
}

_id_ABD08E0038AFC8E3() {
  level endon("game_ended");
  level endon("deltaSquad_introEngage");
  level waittill("intro_soldier_damaged");
  scripts\engine\utility::flag_set("deltaSquad_introEngage");
}

_id_5497DE138A128266() {
  self endon("death");

  if(isDefined(self.magic_bullet_shield)) {
    return;
  }
  scripts\common\ai::magic_bullet_shield(1);

  if(!istrue(level._id_4564A0412869FEF7)) {
    level._id_4564A0412869FEF7 = 1;
    level waittill("defender_intro_completed");
    wait 5;
    scripts\common\ai::stop_magic_bullet_shield();
  } else {
    level waittill("deltaSquad_introEngage");
    wait 10;
    scripts\common\ai::stop_magic_bullet_shield();
  }
}

_id_90C09E830D5AB816() {
  target = scripts\engine\utility::getStruct("intro_guys_fallback", "targetname");

  while(!isDefined(self.ai_spawned) || self.ai_spawned.size == 0)
    wait 0.1;

  if(istrue(level._id_EFE609BCE901CAA8)) {
    level waittill("deltaSquad_intro_runbackwards");
    wait 15;
  } else
    wait 1;

  _id_18A73A64992DD07D::stop_module_by_groupname(self.group_name);
  _id_1047A207E101159E = self.ai_spawned;
  _id_1047A207E101159E = scripts\engine\utility::array_removedead_or_dying(_id_1047A207E101159E);

  foreach(soldier in _id_1047A207E101159E) {
    soldier kill(soldier.origin);
    wait(0.25 + randomfloat(1));
  }
}

_id_436A1B051EE7156B(struct) {
  level endon("level_ended");
  level endon("intro_soldier_damaged");

  if(!scripts\engine\utility::flag_exist("intro_infilDeltaSquadWait"))
    scripts\engine\utility::flag_init("intro_infilDeltaSquadWait");

  if(istrue(level._id_E961004A63D606FD)) {
    wait 1;
    return;
  }

  _id_457471485336C961 = squared(340);
  childthread _id_B35EF3AE1ACA6474(struct.origin, _id_457471485336C961);
  _id_28CBF87065B24740 = squared(2500);
  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  childthread _id_B35EF3AE1ACA6474(_id_278BA2944DB8A0EA.origin, _id_28CBF87065B24740);
  childthread _id_4B41F77FF5E50146(struct.origin);
  scripts\engine\utility::flag_wait("intro_infilDeltaSquadWait");
  level thread _id_DA0C1DF1584374E7();

  if(!isDefined(level._id_D24403B1A304FE31))
    level._id_D24403B1A304FE31 = 0;

  level._id_D24403B1A304FE31++;
  _id_385CCF06380FE17F = level._id_D24403B1A304FE31;

  if(_id_385CCF06380FE17F == 1) {
    level thread _id_48F20B0FE71DD6DF::_id_EAD6C8307D2EBF4B(self);

    if(isalive(self)) {
      closestplayer = scripts\cp\utility::get_closest_living_player();

      if(isDefined(closestplayer)) {
        alias = "stat_A468B6BBF3BA3B66";
        level thread _id_48F20B0FE71DD6DF::_id_A9632ED81F365867(closestplayer, alias);
      }
    }
  }

  wait(0.05 + _id_385CCF06380FE17F * 0.75);
}

_id_DA0C1DF1584374E7() {
  if(isDefined(level._id_1E898F28B5DAB569)) {
    objective_delete(level._id_1E898F28B5DAB569);
    scripts\cp\cp_objectives::freeworldidbyobjid(level._id_1E898F28B5DAB569);
    level._id_1E898F28B5DAB569 = 0;
  }
}

_id_B35EF3AE1ACA6474(origin, _id_A9B6B677F6D0A010) {
  self endon("intro_infilDeltaSquadWait");
  self endon("death");

  while(!scripts\cp\utility::any_player_nearby(origin, _id_A9B6B677F6D0A010))
    wait 0.1;

  if(!scripts\engine\utility::flag("intro_infilDeltaSquadWait"))
    scripts\engine\utility::flag_set("intro_infilDeltaSquadWait");
}

_id_4B41F77FF5E50146(origin) {
  self endon("intro_infilDeltaSquadWait");
  self endon("death");

  if(!istrue(level._id_21F279867AD3E473)) {
    return;
  }
  _id_3DEF217D9BD38E42 = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_88A17B45B2570488 = squared(2000);

  if(scripts\cp\utility::any_player_nearby(_id_3DEF217D9BD38E42.origin, _id_88A17B45B2570488)) {
    return;
  }
  _id_88A17B45B2570488 = squared(600);

  if(scripts\cp\utility::any_player_nearby(self.origin, _id_88A17B45B2570488)) {
    return;
  }
  if(!isDefined(level._id_1E898F28B5DAB569)) {
    level thread _id_48F20B0FE71DD6DF::_id_291028C58B2B41F3(self);
    objindex = scripts\cp\cp_objectives::requestworldid("defender_intropath_waypoint");
    objective_state(objindex, "current");
    objective_position(objindex, self getEye() + (0, 0, 16));
    objective_icon(objindex, "icon_waypoint_objective_general");
    objective_setminimapiconsize(objindex, "icon_small");
    objective_setshowdistance(objindex, 1);
    objective_setplayintro(objindex, 1);
    objective_sethot(objindex, 0);
    objective_setownerteam(objindex, "allies");
    objective_setbackground(objindex, 1);
    level._id_1E898F28B5DAB569 = objindex;
  }
}

_id_057D85DBFBD24236() {
  level endon("game_ended");
  self endon("disconnect");
  wait 5;
  _id_CDC5DD6C28C9709D = 1000000;

  for(;;) {
    waitframe();

    if(!isalive(self)) {
      continue;
    }
    if(!isDefined(level._id_F78FB7634E3797C4) || level._id_F78FB7634E3797C4.size == 0) {
      continue;
    }
    _id_C984F49843A26A7B = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F78FB7634E3797C4.size; _id_AC0E594AC96AA3A8++) {
      if(distance2dsquared(self.origin, level._id_F78FB7634E3797C4[_id_AC0E594AC96AA3A8].origin) <= _id_CDC5DD6C28C9709D)
        _id_C984F49843A26A7B++;
    }

    if(_id_C984F49843A26A7B == 0) {
      self setclientomnvar("ui_target_entity_num", -1);
      continue;
    }

    _id_0B4A8A51FE13EFB8 = self getclientomnvar("ui_target_entity_num");

    if(_id_0B4A8A51FE13EFB8 > 0) {
      _id_E404C23035EEB71F = getentbynum(int(_id_0B4A8A51FE13EFB8));

      if(!isDefined(_id_E404C23035EEB71F._id_50C39E58AF7F7018))
        self setclientomnvar("ui_target_entity_num", -1);
    }

    level._id_9149AA09E5534D8B = _id_7C2D0E47D44A53A6();
    level._id_E8A53778EB5C127D = _id_F0772B50FC376504();
  }
}

_id_7C2D0E47D44A53A6() {
  tracestart = self getEye();
  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 1000;
  results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
  _id_9595F9643C69A295 = results["entity"];

  if(isDefined(_id_9595F9643C69A295) && issentient(_id_9595F9643C69A295) && !isPlayer(_id_9595F9643C69A295)) {
    if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team && isDefined(_id_9595F9643C69A295.entity_number) && isDefined(_id_9595F9643C69A295._id_50C39E58AF7F7018)) {
      if(_id_DED5B64E51712A2F(_id_9595F9643C69A295)) {
        self setclientomnvar("ui_target_entity_num", _id_9595F9643C69A295.entity_number);
        return _id_9595F9643C69A295.entity_number;
      }

      if(!isDefined(_id_9595F9643C69A295.owner) && _id_2CD6C88D75D3509F(_id_9595F9643C69A295, 200)) {
        self setclientomnvar("ui_target_health", 0);
        self setclientomnvar("ui_target_entity_num", _id_9595F9643C69A295.entity_number);
        return _id_9595F9643C69A295.entity_number;
      }
    }
  }

  self setclientomnvar("ui_target_entity_num", -1);
  self setclientomnvar("ui_target_name_index", -1);
  return -1;
}

_id_F0772B50FC376504() {
  tracestart = self getEye();
  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 1000;
  results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
  _id_9595F9643C69A295 = results["entity"];

  if(isDefined(_id_9595F9643C69A295) && issentient(_id_9595F9643C69A295) && !isPlayer(_id_9595F9643C69A295)) {
    if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team && _id_DED5B64E51712A2F(_id_9595F9643C69A295)) {
      if(_id_2CD6C88D75D3509F(_id_9595F9643C69A295, 200)) {
        _id_3ABBBB7549584332 = _id_14FE8CCCC8BDB49B();
        self setclientomnvar("ui_target_health", _id_3ABBBB7549584332);
      } else
        self setclientomnvar("ui_target_health", 0);

      _id_83DAC78C767951B5 = _id_EC4BBA595B3AF91E(_id_9595F9643C69A295);
      self setclientomnvar("ui_target_name_index", _id_83DAC78C767951B5);
      return "follower";
    } else if(isDefined(_id_9595F9643C69A295.team) && _id_9595F9643C69A295.team == self.team && !isDefined(_id_9595F9643C69A295.owner) && _id_2CD6C88D75D3509F(_id_9595F9643C69A295, 200)) {
      self setclientomnvar("ui_target_health", 0);
      _id_83DAC78C767951B5 = _id_B1296B603ADA9FD0();
      self setclientomnvar("ui_target_name_index", _id_83DAC78C767951B5);
      return "guarding";
    }
  }

  return undefined;
}

_id_EC4BBA595B3AF91E(_id_9595F9643C69A295) {
  _id_A4A4484A0B8EE774 = 9;
  return _id_A4A4484A0B8EE774;
}

_id_B1296B603ADA9FD0() {
  return 10;
}

_id_2CD6C88D75D3509F(soldier, dist) {
  if(distance(self.origin, soldier.origin) < dist)
    return 1;

  return 0;
}

_id_14FE8CCCC8BDB49B() {
  _id_3ABBBB7549584332 = _id_5CB623572B271C34::_id_5C6C98E7D15B8D4A(self);

  if(!isDefined(_id_3ABBBB7549584332))
    _id_3ABBBB7549584332 = 0;
  else
    _id_3ABBBB7549584332 = _id_3ABBBB7549584332.size;

  return _id_3ABBBB7549584332;
}

_id_DED5B64E51712A2F(entity) {
  if(isDefined(entity.owner) && entity.owner == self)
    return 1;

  return 0;
}