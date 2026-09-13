/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7eafd8f2b77a1870.gsc
***********************************************/

_id_05675A69BBCEA259() {
  if(!getdvarint("dvar_4A544835C8AE64F3", 0)) {
    return;
  }
  if(!istrue(level.usegulag)) {
    return;
  }
  _id_622D21932C1BCF3A = spawnStruct();
  _id_622D21932C1BCF3A.primaryweapon = getDvar("dvar_C15AB5C0D62F602C", "ar");
  _id_622D21932C1BCF3A.tier = getdvarint("dvar_D3274D9A629743FE", 1);
  _id_622D21932C1BCF3A.totalhealth = getdvarint("dvar_E5060ACBD5AFA93E", 300);
  _id_622D21932C1BCF3A._id_62A6656A434E2DB1 = getdvarint("dvar_C010D711979F5114", 15);
  _id_622D21932C1BCF3A._id_4793C22AD6A20697 = getdvarint("dvar_373C93B98E7D3C92", 30);
  _id_622D21932C1BCF3A._id_36598EE99603EFF4 = getdvarint("dvar_2CA665603BF97065", 1);
  _id_622D21932C1BCF3A._id_E325731AEA80B77F = getdvarint("dvar_9CF27803596FFF40", 1);
  _id_622D21932C1BCF3A._id_12FB21DC8751C2CE = getdvarint("dvar_DAFA44A595367D1D", 2);
  _id_622D21932C1BCF3A._id_F4F16B39BFE10C37 = getdvarfloat("dvar_65E3ECBA47524376", 2.0);
  _id_622D21932C1BCF3A._id_F5147939C00772B9 = getdvarfloat("dvar_6606DEBA47786C64", 2.5);
  _id_622D21932C1BCF3A._id_0863EB0082B9DEC0 = getdvarint("dvar_A3586CC38781FF97", 3);
  _id_622D21932C1BCF3A._id_084101008293C76A = getdvarint("dvar_A37B7AC387A86619", 4);
  level._id_622D21932C1BCF3A = _id_622D21932C1BCF3A;

  while(!isDefined(level.struct_class_names))
    waitframe();

  foreach(arena in level.gulag.arenas) {
    arena._id_E33E5F2072A1DB86 = [];
    _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

    foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
      if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_twotwo_catwalk_ai_spawn") {
        if(isDefined(_id_BDF25D8A73FF7DAD.target)) {
          _id_BDF25D8A73FF7DAD._id_6152E69BD61845F5 = scripts\engine\utility::getStruct(_id_BDF25D8A73FF7DAD.target, "targetname");

          if(isDefined(_id_BDF25D8A73FF7DAD._id_6152E69BD61845F5))
            _id_BDF25D8A73FF7DAD._id_C79916C8DF58D478 = _id_48814951E916AF89::_id_09EDCF99159ABB0B(_id_BDF25D8A73FF7DAD._id_6152E69BD61845F5);
        }

        arena._id_E33E5F2072A1DB86[arena._id_E33E5F2072A1DB86.size] = _id_BDF25D8A73FF7DAD;
      }
    }
  }

  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("loot_key_spectator_gulag", ::_id_6B2A6E0FC1611A0B);
  _id_B896EFD72719FC99();

  foreach(arena in level.gulag.arenas)
  _id_71240CFCA27FC4DD(arena);
}

_id_B896EFD72719FC99() {
  category = "gulag_catwalk";
  _id_48814951E916AF89::_id_BA4022744DCE59F6(category);
}

_id_71240CFCA27FC4DD(arena) {
  if(isDefined(arena._id_F1D536B9F8EFC97C))
    arena._id_F1D536B9F8EFC97C _id_7E52B56769FA7774::deletescriptableinstance(1);

  _id_A620CB0E6444887F = randomintrange(level._id_622D21932C1BCF3A._id_0863EB0082B9DEC0, level._id_622D21932C1BCF3A._id_084101008293C76A + 1);
  arena._id_31839E5DD0B28150 = [];
  arena._id_9068C2300FC69810 = [];

  if(!isDefined(arena._id_60AF67BCAAC1AA55))
    arena._id_60AF67BCAAC1AA55 = 0;

  if(!isDefined(arena._id_2235CD5C616A1881))
    arena._id_2235CD5C616A1881 = 0;

  arena._id_E33E5F2072A1DB86 = scripts\engine\utility::array_randomize(arena._id_E33E5F2072A1DB86);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A620CB0E6444887F; _id_AC0E594AC96AA3A8++)
    _id_8A7784FE4A8D91B2(arena, arena._id_E33E5F2072A1DB86[_id_AC0E594AC96AA3A8], level._id_622D21932C1BCF3A.primaryweapon, level._id_622D21932C1BCF3A.tier);
}

_id_8A7784FE4A8D91B2(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED) {
  aitype = "enemy_mp_baton_base";

  if(getdvarint("dvar_13BDD9641F2E3308", 0)) {
    if(!isDefined(_id_1439F86640D42E34))
      _id_1439F86640D42E34 = "smg";

    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED);
  }

  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin + (0, 0, 30));

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag_catwalk", undefined, undefined, undefined, undefined, undefined, 1, undefined, 0);

  if(isagent(agent)) {
    agent _id_7C45EBD8F87CBEC2(arena);
    agent.arena = arena;
    agent._id_A4738C70736D3A61 = ::_id_A970772FF3C57929;
    agent.fnshouldplaypainanim = ::_id_2362B21EBE35F2DD;
    agent.handledamagefeedback = ::_id_D92FBFD19F555324;
    agent.health = level._id_622D21932C1BCF3A.totalhealth;
    agent.maxhealth = level._id_622D21932C1BCF3A.totalhealth;
    agent.meleechargedistvsplayer = 120;
    agent.pathenemyfightdist = 0;
    agent._id_00A6EC133A74DE3B = 1;
    agent._id_185F1EFD0EC920D3 = 90;
    agent._id_E6B3EB176DDA8ABC = 70;
    agent._id_F88C7E674F2B356E = 60;
    agent._id_2D2CD9DAC58C3455 = 0;
    agent._id_A7704795E7C8E95A = 0;
    agent._id_4E94C508DBE088A2 = 0;
    agent._id_725248D464D15738 = 0;
    agent.ballowexecutions = 0;
    agent._id_214EC6C7283A65C6 = 0;
    agent._id_E585C560D79F00F8 = 1;
    agent _meth_D493E7FE15E5EAF4("default");
    agent notify("endLootDropThread");
    agent attach("misc_wm_baton", "tag_accessory_right");

    if(getdvarint("dvar_B3D7A9483362813E", 0)) {
      agent forceteleport(_id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles);
      agent setgoalpos(agent.origin, 16);
      agent clearpath();
      agent.fixednode = 1;
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 1, agent.origin);
    } else if(getdvarint("dvar_1BED526F1079E5DA", 1) && isDefined(_id_55E69FB0CE97F15E._id_C79916C8DF58D478)) {
      agent.pacifist = 1;
      agent aisetdesiredspeed(80);
      level thread _id_0D68BE668E6E95BB(agent, _id_55E69FB0CE97F15E._id_C79916C8DF58D478, undefined, 64);
      agent scripts\common\utility::demeanor_override("patrol");
      agent thread _id_93B11E4DA88BF536();
      agent thread _id_F02C2688FAD36430();
      agent thread _id_F4270B365E95D937();
    } else
      level thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);

    agent setplayerghost(1);
    agent setperk("specialty_gpsjammer", 1);
    agent thread _id_07AE9EBB1A232528(arena);
  }
}

_id_7C45EBD8F87CBEC2(arena) {
  if(!isDefined(arena._id_6099A8D8CE7DE8DE))
    arena._id_6099A8D8CE7DE8DE = [];

  arena._id_6099A8D8CE7DE8DE = scripts\engine\utility::array_add(arena._id_6099A8D8CE7DE8DE, self);
}

_id_07AE9EBB1A232528(arena) {
  level endon("game_ended");
  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(arena._id_6099A8D8CE7DE8DE)) {
    arena._id_6099A8D8CE7DE8DE = scripts\engine\utility::array_remove(arena._id_6099A8D8CE7DE8DE, self);

    if(isagent(self)) {
      if(isalive(self)) {
        self.nocorpse = 1;
        self kill();
      }
    }

    if(!isDefined(arena._id_7174E40427FAEAE2))
      arena._id_7174E40427FAEAE2 = [];

    body = self getcorpseentity();

    if(isDefined(body))
      arena._id_7174E40427FAEAE2 = scripts\engine\utility::array_add(arena._id_7174E40427FAEAE2, body);

    if(isPlayer(_id_6181DE250AFA5BB6)) {
      arena thread _id_28D2431AA45D5DF8();

      if(arena._id_6099A8D8CE7DE8DE.size <= 0) {
        if(!isDefined(arena._id_F1D536B9F8EFC97C)) {
          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
          _id_7E52B56769FA7774::_id_A10ADEC57AD9E3A4(dropstruct, arena, _id_6181DE250AFA5BB6);
        }

        foreach(_id_7F57B800332723A1 in arena.jailedplayers)
        _id_7F57B800332723A1 setplayermusicstate("");
      }
    }

    if(!isDefined(arena._id_CD8F73438EC92B1B)) {
      arena._id_CD8F73438EC92B1B = 1;
      arena._id_60AF67BCAAC1AA55 = arena._id_60AF67BCAAC1AA55 + 1;

      if(isPlayer(_id_6181DE250AFA5BB6))
        playsoundatpos(_id_6181DE250AFA5BB6.origin + (0, 0, 72), "mp_br_gulag_riot_alarm");

      foreach(_id_7F57B800332723A1 in arena.jailedplayers) {
        _id_7F57B800332723A1 thread scripts\mp\hud_message::showsplash("br_gulag_prison_riot_in_progress");
        _id_7F57B800332723A1 setplayermusicstate("mx_mp_dmz_delta_activity_tension_loop2");
      }
    }
  }
}

_id_6B2A6E0FC1611A0B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level endon("game_ended");
  arena = player.arena;

  if(isDefined(arena._id_F1D536B9F8EFC97C)) {
    arena._id_F1D536B9F8EFC97C _id_7E52B56769FA7774::deletescriptableinstance(1);
    player thread _id_7E52B56769FA7774::playerplaypickupanim();
  }

  if(isDefined(player))
    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7F475510F9F5698D");

  wait 1.17;

  foreach(_id_D7836AB41DCA3E4A in arena._id_31839E5DD0B28150) {
    if(isDefined(_id_D7836AB41DCA3E4A))
      _id_D7836AB41DCA3E4A scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0DD106359BCA2B84");
  }

  _id_B215274F1A3EB134 = scripts\engine\utility::array_combine(arena.jailedplayers, arena.arenaplayers);
  arena thread _id_4A9DBCE4369F1BBA();
  arena thread _id_03391003FE051704();
  level notify("gulag_break");

  if(isDefined(arena)) {
    if(isDefined(arena._id_2235CD5C616A1881))
      arena._id_2235CD5C616A1881 = arena._id_2235CD5C616A1881 + 1;
  }

  _id_715028F54BAD19A1::_id_05098EE655AFED5D(arena.id, level.br_circle.circleindex, 1, arena._id_31839E5DD0B28150.size, 0, _id_B215274F1A3EB134.size);
  arena thread _id_EC93AE254484BA9D(5.0);
}

_id_03391003FE051704() {
  level endon("game_ended");
  self endon("fight_over");
  self endon("matchEnded");

  if(istrue(self.fightover)) {
    return;
  }
  foreach(player in self.arenaplayers) {
    player setclientomnvar("ui_br_gulag_lethal_delay", 0);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("watchLethalDelayPlayer");

    if(!isbot(player) && isPlayer(player)) {
      player notifyonplayercommandremove("lethal_attempt_gulag", "+frag");
      player notifyonplayercommandremove("lethal_attempt_gulag", "+smoke");
    }

    player thread _id_CABF225FA4B4CACA(1);
  }
}

_id_4A9DBCE4369F1BBA() {
  foreach(player in self.jailedplayers) {
    if(!player isinexecutionvictim()) {
      if(player _id_5BAB271917698DC4::playeriscinematiclayeron())
        player stopcinematicforplayer(1, 1);

      player thread _id_CABF225FA4B4CACA(0);
    }
  }
}

_id_CABF225FA4B4CACA(_id_15A419E19E435F2B) {
  if(!isDefined(self)) {
    return;
  }
  _id_1B7F5108008D55B6 = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

  if(_id_15A419E19E435F2B) {
    if(_id_5BAB271917698DC4::playeriscinematiclayeron())
      _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  }

  scripts\mp\utility\player::_freezecontrols(1, 0, "gulagBreak");
  thread scripts\mp\hud_message::showsplash("br_gulagbreak_active");

  if(_id_1B7F5108008D55B6)
    _id_67708F418B1FAC79::gulagvictory(self.arena, self, 1, 0, undefined, undefined, undefined, undefined, undefined, 1);
  else
    thread _id_67708F418B1FAC79::playergulagautowin("gulagbreak_playerRespawn", undefined, undefined, 1, 0, undefined, 1);
}

_id_A970772FF3C57929(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(eattacker) && scripts\engine\utility::array_contains(self.arena.arenaplayers, eattacker)) {
    return;
  }
  if(isDefined(self.arena) && !scripts\engine\utility::array_contains(self.arena._id_31839E5DD0B28150, eattacker))
    self.arena._id_31839E5DD0B28150 = scripts\engine\utility::array_add(self.arena._id_31839E5DD0B28150, eattacker);

  if(isPlayer(eattacker)) {
    if(isDefined(self.arena)) {
      if(isDefined(self.arena._id_9068C2300FC69810) && !scripts\engine\utility::array_contains(self.arena._id_9068C2300FC69810, self)) {
        self.arena._id_9068C2300FC69810 = scripts\engine\utility::array_add(self.arena._id_9068C2300FC69810, self);

        if(isDefined(self.arena._id_19FE32F41A41C7FF))
          self.arena._id_19FE32F41A41C7FF = self.arena._id_19FE32F41A41C7FF + 1;
        else
          self.arena._id_19FE32F41A41C7FF = 1;
      }
    }
  }

  _id_B5B49EC3D37D653A = isDefined(self.flashendtime);

  if(smeansofdeath == "MOD_IMPACT") {
    if(distance2dsquared(einflictor.origin, eattacker.origin) < 640000) {
      if(partname == "hunk_51BD95AA" || partname == "hunk_119CD9B0") {
        idamage = level._id_622D21932C1BCF3A._id_4793C22AD6A20697;
        self._id_2D2CD9DAC58C3455++;

        if(!_id_B5B49EC3D37D653A && isDefined(self._id_2D2CD9DAC58C3455) && self._id_2D2CD9DAC58C3455 >= level._id_622D21932C1BCF3A._id_36598EE99603EFF4) {
          self._id_CF96019BE76D9636 = eattacker;
          _id_0BB4122A38672185(1);
          _id_0430056385102FBD = randomfloatrange(level._id_622D21932C1BCF3A._id_F4F16B39BFE10C37, level._id_622D21932C1BCF3A._id_F5147939C00772B9);

          if(self.asmname != self._id_A942DD31D55102C9)
            _id_4E1D4DD23699A8A4::_id_DB8201BA3A4A894D();

          self shellshock("flashbang_mp", _id_0430056385102FBD);

          if(!isDefined(self.flashendtime)) {
            self.flashendtime = int(_id_0430056385102FBD * 1000);
            scripts\asm\asm::asm_setstate("pain_flashed_transition");
          }

          self._id_2D2CD9DAC58C3455 = 0;
          self._id_77F17252937F40CD = 1;
          thread _id_D663D609F9113305();
          _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_damage_reaction_head", "react_multi", 0, 0, 3);
        }
      } else {
        self._id_A7704795E7C8E95A++;

        if(self._id_A7704795E7C8E95A >= level._id_622D21932C1BCF3A._id_E325731AEA80B77F) {
          self._id_A7704795E7C8E95A = 0;

          if(!self._id_725248D464D15738) {
            self._id_0D05847451D7568A = 1;
            _id_823867E4D6972EA8 = vectorNormalize(anglesToForward(self.angles));
            _id_C43FA317DC81B416 = vectorNormalize(vdir);
            _id_9913FD1FFEA99C33 = vectordot(_id_C43FA317DC81B416, _id_823867E4D6972EA8);

            if(_id_9913FD1FFEA99C33 > 0.35)
              _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_damage_reaction_body", "react_unaware", 0, 0, 4);
            else
              _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_damage_reaction_body", "react_aware", 0, 0, 4);
          }
        }
      }

      self._id_CF96019BE76D9636 = eattacker;
      _id_0BB4122A38672185(1);
    }
  } else if(smeansofdeath == "MOD_MELEE") {
    if(!self._id_725248D464D15738) {
      if(!_id_B5B49EC3D37D653A) {
        self._id_0D05847451D7568A = 1;
        _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_melee_reaction", "react_aware", 0, 0, 3);
      }

      self._id_CF96019BE76D9636 = eattacker;
      _id_0BB4122A38672185(1);
    }

    if(isDefined(self.flashendtime) && self.flashendtime > 0)
      idamage = level._id_622D21932C1BCF3A._id_4793C22AD6A20697;
    else
      idamage = level._id_622D21932C1BCF3A._id_62A6656A434E2DB1;
  }

  if(idamage > self.health)
    self detach("misc_wm_baton", "tag_accessory_right");

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_D663D609F9113305() {
  self endon("death");

  while(isDefined(self.flashendtime))
    waitframe();

  self._id_77F17252937F40CD = 0;
}

_id_2362B21EBE35F2DD() {
  _id_392782E59863C89F = 64;

  if(istrue(self._id_0D05847451D7568A)) {
    self._id_0D05847451D7568A = 0;
    return 1;
  }

  if(self.a.disablepain)
    return 0;

  if(isDefined(self.allowpain) && self.allowpain == 0)
    return 0;

  if(istrue(self._id_A1DB58C75F381A55))
    return 0;

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < _id_392782E59863C89F)
    return 0;

  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);
    _id_F700B7A9C3B98B13 = issubstr(basename, "fists");

    if(_id_F700B7A9C3B98B13)
      return 0;
  }

  return 1;
}

_id_28D2431AA45D5DF8() {
  level notify("spectator_ai_death");
  level endon("spectator_ai_death");
  level endon("gulag_break");

  for(;;) {
    players = scripts\engine\utility::array_remove_array(self.jailedplayers, self.arenaplayers);

    if(players.size <= 0) {
      thread _id_EC93AE254484BA9D(5.0);
      _id_715028F54BAD19A1::_id_05098EE655AFED5D(self.id, level.br_circle.circleindex, 0, self._id_31839E5DD0B28150.size, self._id_6099A8D8CE7DE8DE.size, 0);
      break;
    }

    wait 1;
  }
}

_id_EC93AE254484BA9D(delay) {
  level endon("game_ended");

  if(isDefined(delay))
    wait(delay);

  if(isDefined(self._id_6099A8D8CE7DE8DE)) {
    foreach(agent in self._id_6099A8D8CE7DE8DE) {
      if(isDefined(agent) && isagent(agent)) {
        if(isalive(agent)) {
          agent.nocorpse = 1;
          agent kill();
        }

        body = agent getcorpseentity();

        if(isDefined(body))
          body delete();
      }
    }
  }

  if(isDefined(self._id_7174E40427FAEAE2)) {
    foreach(body in self._id_7174E40427FAEAE2) {
      if(isDefined(body))
        body delete();
    }
  }

  _id_71240CFCA27FC4DD(self);
}

_id_D92FBFD19F555324(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, iskillstreakweapon) {
  if(isDefined(eattacker) && isDefined(eattacker.owner))
    _id_91EBB035A259E76A = eattacker.owner;
  else
    _id_91EBB035A259E76A = eattacker;

  if(isDefined(_id_91EBB035A259E76A) && _id_91EBB035A259E76A != victim && idamage + _id_1DA1A66B5C6A06A7 + _id_986B2E0350629522 > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    _id_4FFE32F42D51A763 = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent(victim) && idamage >= victim.health;
    headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
    _id_62CF84636D4CEF2C = smeansofdeath == "MOD_MELEE";
    _id_BDA9C6703DCFCC16 = "" + victim getentitynumber();

    if(_id_4FFE32F42D51A763 && isDefined(victim.body))
      _id_249FCA7089CD498F = victim.body getentitynumber();
    else
      _id_249FCA7089CD498F = victim getentitynumber();

    if(isDefined(self._id_2D8D11A34BE5B244) && [[self._id_2D8D11A34BE5B244]]())
      _id_91EBB035A259E76A _id_5762AC2F22202BA2::updatedamagefeedback("hitarmorheavybreak", _id_4FFE32F42D51A763, headshot, undefined, _id_62CF84636D4CEF2C, undefined, _id_249FCA7089CD498F, undefined);
    else if(idamage >= level._id_622D21932C1BCF3A._id_4793C22AD6A20697)
      _id_91EBB035A259E76A _id_5762AC2F22202BA2::updatedamagefeedback("standard", _id_4FFE32F42D51A763, headshot, undefined, _id_62CF84636D4CEF2C, undefined, _id_249FCA7089CD498F, undefined);
    else if(idamage >= level._id_622D21932C1BCF3A._id_62A6656A434E2DB1)
      _id_91EBB035A259E76A _id_5762AC2F22202BA2::updatedamagefeedback("hitarmorheavy", _id_4FFE32F42D51A763, headshot, undefined, _id_62CF84636D4CEF2C, undefined, _id_249FCA7089CD498F, undefined);
  }
}

_id_0BB4122A38672185(aggressive) {
  self.pacifist = !aggressive;
  self._id_C833409FB72D15FB = !aggressive;

  if(aggressive) {
    if(!self._id_725248D464D15738) {
      self _meth_1C339DAABA3F71DB(1);
      self._id_725248D464D15738 = 1;
      self._id_214EC6C7283A65C6 = 1;
      self.goalradius = 8000;
      self clearpath();
      scripts\common\utility::demeanor_override("cqb");
      self.allowstrafe = 0;

      if(self.asmname == self._id_A942DD31D55102C9)
        self asmsetstate(self.asmname, "stand_run_loop");
    }

    if(isDefined(self._id_CF96019BE76D9636)) {
      player = self._id_CF96019BE76D9636;
      self agentsetfavoriteenemy(player);
      self setlookatentity(player);

      if(!isDefined(player._id_E1590A93ECA5E264))
        player._id_E1590A93ECA5E264 = [];

      player._id_E1590A93ECA5E264 = scripts\engine\utility::array_add(player._id_E1590A93ECA5E264, self);
    }
  } else {
    self._id_725248D464D15738 = 0;
    self._id_214EC6C7283A65C6 = 0;
    self agentsetfavoriteenemy(undefined);
    self setlookatentity();
    self aisetdesiredspeed(80);
    self.goalradius = 64;
    scripts\common\utility::demeanor_override("patrol");
    player = self._id_CF96019BE76D9636;

    if(isDefined(player) && isDefined(player._id_E1590A93ECA5E264)) {
      player._id_E1590A93ECA5E264 = scripts\engine\utility::array_remove(player._id_E1590A93ECA5E264, self);
      self._id_CF96019BE76D9636 = undefined;
    }

    if(self._id_4E94C508DBE088A2 >= level._id_622D21932C1BCF3A._id_12FB21DC8751C2CE)
      self._id_4E94C508DBE088A2 = 0;
  }
}

_id_F02C2688FAD36430() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(istrue(self._id_725248D464D15738)) {
      _id_35B984525605169B = self._id_CF96019BE76D9636;
      _id_1B48581DB97B1495 = scripts\mp\utility\player::isinlaststand(_id_35B984525605169B);
      _id_0F134AD0A55F3963 = _id_35B984525605169B isinexecutionvictim() && !self isinexecutionattack();
      _id_EA03686B0EDF04E2 = scripts\engine\utility::array_contains(self.arena.arenaplayers, _id_35B984525605169B);

      if(!isDefined(_id_35B984525605169B) || !isalive(_id_35B984525605169B) || _id_1B48581DB97B1495 || _id_0F134AD0A55F3963 || _id_EA03686B0EDF04E2 || distance2dsquared(self.origin, _id_35B984525605169B.origin) > 640000)
        _id_0BB4122A38672185(0);
    }

    wait 0.1;
  }
}

_id_F4270B365E95D937() {
  level endon("game_ended");
  self endon("death");
  self._id_16304B6CCAA4B8BD = 0;

  for(;;) {
    self waittill("object_whizby", org, player);

    if(!istrue(self._id_725248D464D15738) && isDefined(player)) {
      self._id_4E94C508DBE088A2++;

      if(!self._id_16304B6CCAA4B8BD) {
        if(self._id_4E94C508DBE088A2 >= level._id_622D21932C1BCF3A._id_12FB21DC8751C2CE && distance2dsquared(self.origin, player.origin) < 640000) {
          self._id_CF96019BE76D9636 = player;
          _id_1A7204646A84BC7A(player);
          _id_0BB4122A38672185(1);
        } else {
          self._id_16304B6CCAA4B8BD = 1;
          thread _id_F107289C7060DE31(player);
        }
      }
    }

    wait 0.1;
  }
}

_id_F107289C7060DE31(player) {
  level endon("game_ended");
  self endon("death");
  _id_3E38EE41DC326FDC = "cap_jailer_warnoff";
  _id_7A140EE03CFC699E = "caps/common/cap_jailer_warnoff";
  self _meth_1C339DAABA3F71DB(1);
  self setlookatentity(player);
  self._id_6EA17FD821A76B9F = player;
  self _meth_105C123CD778717A(player);
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, _id_7A140EE03CFC699E);
  self waittill("cap_exit_completed");
  self _meth_105C123CD778717A();
  self setlookatentity();
  self._id_6EA17FD821A76B9F = undefined;

  if(self._id_4E94C508DBE088A2 >= level._id_622D21932C1BCF3A._id_12FB21DC8751C2CE && distance2dsquared(self.origin, player.origin) < 640000) {
    self._id_CF96019BE76D9636 = player;
    self asmsetstate(self.asmname, "patrol_idle");
    _id_0BB4122A38672185(1);
  }

  self._id_16304B6CCAA4B8BD = 0;
}

_id_1A7204646A84BC7A(player) {
  if(self.asmname == self._id_A942DD31D55102C9) {
    self._id_1C9ED4A46D13EDC9 = player.origin;
    self._id_FD01AD49B4E38AE8 = "med";
    _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_player_spotted", "warn_spotted", 0, 0, 3);
    animindex = self asmgetanim(self.asmname, "patrol_move_react_aim");
    _id_93A2C35BC9547955 = scripts\asm\asm::asm_getxanim("patrol_move_react_aim", animindex);
    _id_EB5B1F36E255152D = getanimlength(_id_93A2C35BC9547955);
    self motionwarpcancel();
    self animmode("zonly_physics");
    self orientmode("face enemy");
    self _meth_105C123CD778717A(player);
    self aisetanim("patrol_move_react_aim", animindex, 1.0);
    wait(_id_EB5B1F36E255152D);

    if(self.asmname == self._id_A942DD31D55102C9)
      self _meth_105C123CD778717A();
  }
}

_id_3231B59578BFFE2F(alias) {
  level endon("game_ended");
  self endon("death");
  _id_927B3199642B75FC = [];

  switch (alias) {
    case "warn_get_back":
      _id_927B3199642B75FC = ["warn_getBack"];
      break;
    case "warn_get_back_now":
      _id_927B3199642B75FC = ["warn_getBackNow"];
      break;
    case "warn_get_out":
      _id_927B3199642B75FC = ["warn_getOut"];
      break;
    case "warn_curse":
      _id_927B3199642B75FC = ["warn_curse"];
      break;
    case "attack_effort":
      _id_927B3199642B75FC = ["warn_curse"];
      break;
  }

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_player_warning", _id_927B3199642B75FC, 0, 0, 1);
}

_id_3032D7F191CE6B69() {
  level endon("game_ended");
  self endon("death");
  wait 2.7;
  _id_927B3199642B75FC = [];

  if(scripts\engine\utility::_id_51D76700600CEBE3(25)) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(25))
      _id_927B3199642B75FC = ["warn_getBack", 1.0, "warn_getOut", 0.4, "warn_curse"];
    else
      _id_927B3199642B75FC = ["warn_getBack", 1.0, "warn_getOut"];
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(25)) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(25))
      _id_927B3199642B75FC = ["warn_getBackNow", 1.0, "warn_getOut", 0.4, "warn_curse"];
    else
      _id_927B3199642B75FC = ["warn_getBackNow", 1.0, "warn_getOut"];
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(25)) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(25))
      _id_927B3199642B75FC = ["warn_getOut", 1.0, "warn_getBack", 0.4, "warn_curse"];
    else
      _id_927B3199642B75FC = ["warn_getOut", 1.0, "warn_getBack"];
  } else if(scripts\engine\utility::_id_51D76700600CEBE3(25))
    _id_927B3199642B75FC = ["warn_getOut", 1.0, "warn_getBackNow", 0.4, "warn_curse"];
  else
    _id_927B3199642B75FC = ["warn_getOut", 1.0, "warn_getBackNow"];

  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_player_warning", _id_927B3199642B75FC, 0, 0, 1);
}

_id_93B11E4DA88BF536() {
  level endon("game_ended");
  self endon("death");
  _id_B5B3F47D2C2ECA22 = 0;

  for(;;) {
    if(self._id_725248D464D15738) {
      self._id_214EC6C7283A65C6 = 1;
      wait 0.1;
      continue;
    }

    _id_F47DD9D668CC52E2 = _id_DFF80119C7CCAC6A(self.arena, self.origin, 180);

    if(_id_F47DD9D668CC52E2.size > 0) {
      _id_F47DD9D668CC52E2 = sortbydistance(_id_F47DD9D668CC52E2, self.origin);

      foreach(player in _id_F47DD9D668CC52E2) {
        if(player.ignoreme || scripts\mp\utility\player::isinlaststand(player) || player isinexecutionvictim()) {
          continue;
        }
        _id_0A75A06EE98DF814 = distance2d(self.origin, player.origin) <= 80;

        if((self cansee(player) || _id_0A75A06EE98DF814) && !_id_B5B3F47D2C2ECA22) {
          if(isDefined(player._id_E1590A93ECA5E264) && player._id_E1590A93ECA5E264.size > 0) {
            _id_B5B3F47D2C2ECA22 = 1;
            self._id_214EC6C7283A65C6 = _id_B5B3F47D2C2ECA22;
            self._id_CF96019BE76D9636 = player;
            _id_1A7204646A84BC7A(player);
            _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_warn_attack", "warn_attack", 0, 0, 3);
            _id_0BB4122A38672185(1);
            _id_0BB4122A38672185(1);
            break;
          }

          if(self._id_1420C6F292149589) {
            _id_B5B3F47D2C2ECA22 = 1;
            self._id_214EC6C7283A65C6 = _id_B5B3F47D2C2ECA22;
            self._id_CF96019BE76D9636 = player;
            _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_warn_attack", "warn_attack", 0, 0, 3);
            _id_0BB4122A38672185(1);
            break;
          } else if(_id_0A75A06EE98DF814) {
            self._id_1420C6F292149589 = 1;
            self._id_6292BA769942BEAF = 1;
            self setgoalpos(self.origin);

            if(!self._id_725248D464D15738) {
              _id_3E38EE41DC326FDC = "cap_jailer_warnoff";
              _id_7A140EE03CFC699E = "caps/common/cap_jailer_warnoff";
              self _meth_1C339DAABA3F71DB(1);
              self setlookatentity(player);
              self._id_6EA17FD821A76B9F = player;
              self _meth_105C123CD778717A(player);
              thread _id_3032D7F191CE6B69();
              _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, _id_7A140EE03CFC699E);
              self waittill("cap_exit_completed");
              self _meth_105C123CD778717A();
              self setlookatentity();
              self._id_6EA17FD821A76B9F = undefined;
            }

            break;
          }
        }
      }
    } else {
      self._id_6292BA769942BEAF = 0;
      self._id_1420C6F292149589 = 0;
      _id_B5B3F47D2C2ECA22 = 0;
      self._id_214EC6C7283A65C6 = _id_B5B3F47D2C2ECA22;
    }

    if(!_id_B5B3F47D2C2ECA22 && !self._id_214EC6C7283A65C6 && self._id_4E94C508DBE088A2 < level._id_622D21932C1BCF3A._id_12FB21DC8751C2CE) {
      _id_0BB4122A38672185(0);
      self._id_A02447B50DE44BCC = undefined;
    }

    wait 0.1;
  }
}

_id_0D68BE668E6E95BB(agent, pathstruct, _id_2F55781AF96F22F9, _id_87D4C4075F48EC58, _id_C75025A5B8EB8D36) {
  if(!isDefined(agent)) {
    return;
  }
  level endon("game_ended");
  _id_A1D5907E01730345 = 0;
  _id_F8BC7ECDD324DD79 = _id_120270BD0A747A35::_id_F0C78111CE0CDC0A(agent);

  if(!isDefined(_id_F8BC7ECDD324DD79) || _id_F8BC7ECDD324DD79.behavior != "patrol")
    _id_120270BD0A747A35::_id_4561FE6BFC76F8EC(agent, [agent], pathstruct);

  if(isagent(agent)) {
    agent endon("death");
    _id_A1D5907E01730345 = 1;
  }

  if(!_id_A1D5907E01730345) {
    return;
  }
  path = pathstruct.path;
  pathstruct.claimed = 1;
  index = 1;
  _id_47EA45F5BCF10FC3 = 1;

  if(isDefined(_id_2F55781AF96F22F9)) {
    index = _id_2F55781AF96F22F9;
    index = int(min(index, path.size - 1));
    index = int(max(index, 0));
  }

  _id_120270BD0A747A35::_id_1670C315976C767B();
  wait 1;

  for(;;) {
    _id_846067098790C9C4 = !agent._id_214EC6C7283A65C6 && !istrue(agent._id_6292BA769942BEAF);

    if(_id_846067098790C9C4) {
      if(isvector(path[index]))
        point = path[index];
      else
        point = path[index].origin;

      _id_BCFEC646853A95C1 = randomfloatrange(10, 11) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
      _id_BCFEC546853A938E = randomfloatrange(10, 11) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
      point = (point[0] + _id_BCFEC646853A95C1, point[1] + _id_BCFEC546853A938E, point[2]);
      agent _id_120270BD0A747A35::_setgoalpos(point, 32);
      wait(randomfloatrange(1.5, 2.5));
      waitframe();
      agent waittill("goal");
    }

    if(istrue(agent._id_CF430336D17E3AFE))
      wait 0.5;
    else
      wait(scripts\engine\utility::_id_53C4C53197386572(_id_C75025A5B8EB8D36, 5));

    _id_846067098790C9C4 = !agent._id_214EC6C7283A65C6 && !istrue(agent._id_6292BA769942BEAF);

    if(_id_846067098790C9C4) {
      if(_id_47EA45F5BCF10FC3)
        index++;
      else
        index--;

      if(!isDefined(path[index])) {
        if(!pathstruct._id_4437E81F60B6B5A0) {
          index = 0;
          continue;
        }

        if(_id_47EA45F5BCF10FC3) {
          index = path.size - 2;
          _id_47EA45F5BCF10FC3 = 0;
          continue;
        }

        index = 1;
        _id_47EA45F5BCF10FC3 = 1;
      }
    }
  }
}

_id_DFF80119C7CCAC6A(arena, pos, radius) {
  players = [];

  foreach(player in arena.jailedplayers) {
    if(isDefined(player)) {
      if(distance2d(pos, player.origin) <= radius)
        players = scripts\engine\utility::array_add(players, player);
    }
  }

  return players;
}