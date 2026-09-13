/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_8673e0244b7df2f.gsc
***********************************************/

_id_5171170AC608CA01() {}

_id_4AD27A07D0C6B1D5(taskid) {
  if(isDefined(self.spawner) && self.spawner _id_1484600EC292770E())
    self.entered_playspace = 1;

  if(isDefined(level.in_room_check_func)) {
    if(self[[level.in_room_check_func]]())
      self.entered_playspace = 1;
  }

  setupagent();
  self._id_3942301085D60337 = _id_0A662F25DBF78119::_id_CF169A8DE2A0D355;
  self._id_7E006F8C7B898B70 = _id_0A662F25DBF78119::_id_E8F9A124778CC606;
  _id_0A662F25DBF78119::_id_CF169A8DE2A0D355("walk");
  _id_0A662F25DBF78119::_id_E8F9A124778CC606(1.0);
  self.species = "zombie";
  self.zombie = 1;
  self._id_4BBA3A58F389E465 = self._id_FA4CF34A0C3681B8;
  self._id_3835F6FBD6173DC9 = squared(self._id_4BBA3A58F389E465);
  self._id_D41ED96694C55D83 = 1;
  self.allowstrafe = 0;
  self._id_1858803EA66E73E0 = 1;
  self._id_DF41B7F76F62D9A2 = 0;
  self._id_0B222000B9E5E8CE = 1;
  self.health = getdvarint("dvar_98524611D6B1AC04", 500);
  self.maxhealth = self.health;
  self disableexecutionvictim();

  if(!threatbiasgroupexists("zombie")) {
    createthreatbiasgroup("zombie");
    setignoremegroup("Lethal_Static", "zombie");

    if(threatbiasgroupexists("player_zombie"))
      setignoremegroup("player_zombie", "zombie");
  }

  self setthreatbiasgroup("zombie");
  _id_5674766C9779586E();
  thread _id_1BA83D775A9EE0EC();

  if(self isscriptable())
    thread initscriptable();

  self enabletraversals(0);
  return anim.success;
}

initscriptable() {
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

sortdoorsbydistance(_id_A74F7EFB3166D264, door2) {
  return distancesquared(_id_A74F7EFB3166D264.origin, self.closestdoorpos) < distancesquared(door2.origin, self.closestdoorpos);
}

_id_1BA83D775A9EE0EC() {
  self endon("death");

  for(;;) {
    doorpos = self getmodifierlocationonpath("door", 64);

    if(isDefined(doorpos)) {
      self.closestdoorpos = doorpos;
      _id_C35E313B48080112 = getentarrayinradius("dynamic_door", "targetname", doorpos, 256);

      if(_id_C35E313B48080112.size > 0) {
        _id_C35E313B48080112 = scripts\engine\utility::array_sort_with_func(_id_C35E313B48080112, ::sortdoorsbydistance);
        door = _id_C35E313B48080112[0];

        if(isDefined(door.state) && door scripts\mp\door::door_can_open_check())
          door thread scripts\mp\door::cheapopen(self);
      }

      self.closestdoorpos = undefined;
      _id_F0B5BCB30A7F121A = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(doorpos, 64, 72);
      _id_62FDA80EC26E34EB = 0;

      foreach(door in _id_F0B5BCB30A7F121A) {
        _id_CF824D726536819E = abs(door scriptabledoorangle());

        if(_id_CF824D726536819E < 50) {
          door scriptabledooropen("away", self.origin);
          _id_62FDA80EC26E34EB = 1;
        }
      }

      if(_id_62FDA80EC26E34EB) {
        _id_1E8FEA6CBB75220F = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(doorpos, 128, 72);
        _id_BBC48F9A5C738FCA = scripts\engine\utility::array_remove_array(_id_1E8FEA6CBB75220F, _id_F0B5BCB30A7F121A);

        foreach(door in _id_BBC48F9A5C738FCA) {
          _id_CF824D726536819E = abs(door scriptabledoorangle());

          if(_id_CF824D726536819E < 50)
            door scriptabledooropen("away", self.origin);
        }

        wait 2.0;
      }
    }

    wait 0.05;
  }
}

_id_5674766C9779586E() {
  if(!isDefined(level._id_BA3FD47C2FEEA836))
    level._id_BA3FD47C2FEEA836 = 1;
  else
    return;

  level._id_855763480DFAE2AC = 1;
  level._id_B90AA42D4934AC37 = 0;
  level._id_E47E7FA77BC59B2A = 0;
  level._id_804B4F6D9BF13089 = [];
  level._id_47E363E45EE90C6E = [];
  level._id_07E9AA42CBB64F35 = [];
  level._id_60B011E242899B53 = [];
  level._id_CE05120D0652E369 = [];
  level._id_EE0827F1AD696786 = [];
  level.playerteam = "allies";
  _id_13AFF24327B0AA83();
  level.callbackplayerdamage = ::_id_4753F432947152B9;
  loadvfx();
  thread _id_A04CF7AEDB0B7311();
}

setupagent() {
  thread _id_1F575FFE0E5D2C4E();
  self.legacy = spawnStruct();
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.saved_actionslotdata = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.entered_playspace = 0;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self._id_1E0B2C127D2BE63E = undefined;
  self.aistate = "idle";
  self.legacy.movemode = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
  self._id_C8818686F12F33B6 = 26 + self.radius;
  self._id_5754D6C3DF1A2B31 = "normal";
  self._id_5CB3CC0C49EE04F1 = 50;
  self._id_6EE412D13BCF28D2 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self._id_8D31C7EACB516468 = 1.0;
  self._id_0DA951E8204605E7 = 1.0;
  self._id_D2D25942E3B908E9 = 1.0;
  self._id_05B1209ECD2C2DE2 = 1.0;
  self._id_16734F091BFEBAA1 = 0;
  self._id_0D4AE052F5BDA013 = 1;
  self._id_A045430175C98788 = 0;
  self.allowcrouch = 1;
  self.pathenemyfightdist = 30;
  self.pathenemylookahead = 30;
  self._id_7C0157EC8B265F6E = 40;
  self._id_FA4CF34A0C3681B8 = 70;
  self._id_A9BBCE143412F034 = 80;
  self._id_F5BD7EEB8C658300 = squared(self._id_FA4CF34A0C3681B8);
  self._id_B9DC79113497B05B = self.radius + 1;
  self.dismember_crawl = 0;
  self._id_86D9FBF4F411FE16 = 0;
  self.died_poorly = 0;
  self.damaged_by_player = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self._id_61BE94A8E9904DBF = 1;
  self.full_gib = 0;
  self.favoriteenemy = undefined;
  self._id_7D440599A78C8E28 = undefined;
  self._id_0805F8A6DA772965 = [];
  self._id_2392A32020FB22B5 = 0;
  self.hasplayedvignetteanim = undefined;
  self._id_34E840B2AC491E04 = undefined;
  self.highlyawareradius = 200;
  self._id_AD9276C342EDD6FC = undefined;
  self._id_563B2ECE9CD174A3 = undefined;
  self._id_C65E18C51D178FA9 = undefined;
  self._id_4F7789AC24F18DF1 = undefined;
  self._id_0DC7052BBFE5C799 = 1;
  self._id_BAE9B33C9C1783AF = undefined;
  self.death_anim_no_ragdoll = undefined;
  self._id_67E1D89E2F7C463D = 0.85;
  self._id_8B21F2B424F46AF0 = 2.0;
  self._id_9563742BCC8616C5 = gettime();
  self._id_B7BDFA418F9F4430 = gettime();
  self._id_BF830B312EB47E30 = gettime();
  self._id_D491CD53E778C48E = gettime();
  self._id_BB57EF5C97F7C107 = gettime() + 2500;
  self.immune_against_repulsor = undefined;
  self.on_zombie_agent_killed_common = ::on_zombie_agent_killed_common;
  self._id_353B862B77F0AD7E = ::_id_E1E82089AC7F4F7D;
  self._id_81C4985793EFAE10 = ::_id_530B5EDDCFE3FCFB;
  self.lasthittime = [];
  self._id_7A480DEB4960D81E = 54;
  self._id_A853A9004B90B766 = -64;
  self._id_93C7E046D802A2D2 = 0.5;
  self.battlechatter = spawnStruct();
  self.fnisinstealthidle = ::_id_EB16AF28FCFA61A9;
  self.fnisinstealthinvestigate = ::_id_EB16AF28FCFA61A9;
  self.fnisinstealthhunt = ::_id_EB16AF28FCFA61A9;
  self.fnisinstealthcombat = ::_id_EB16AF28FCFA61A9;
  _id_0A662F25DBF78119::_id_A490D346D97D0167(self._id_FA4CF34A0C3681B8);

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1)
    self._id_91A2982967965547 = 1;

  _id_CB920E03144E9344 = 15;

  if(isDefined(level._id_3DFCDEA6EFB8A124))
    _id_CB920E03144E9344 = level._id_3DFCDEA6EFB8A124;

  self _meth_748A16E0D1FE8B85(_id_CB920E03144E9344);
  thread _id_4222D0ECF1D363BA();
  thread _id_3A6C3F63DA7103BF();
}

_id_EB16AF28FCFA61A9() {
  return 0;
}

_id_3A6C3F63DA7103BF() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  self asmsetstate(self.asmname, "idle");
}

_id_A04CF7AEDB0B7311() {
  level._id_E38F758D6AD03356 = ["slow_walk", "walk", "run", "sprint"];

  if(!isDefined(level._id_905DDCFDC0322C3C)) {
    level._id_905DDCFDC0322C3C["slow_walk"][0] = 1;
    level._id_905DDCFDC0322C3C["slow_walk"][1] = 1;
    level._id_905DDCFDC0322C3C["walk"][0] = 1;
    level._id_905DDCFDC0322C3C["walk"][1] = 1;
    level._id_905DDCFDC0322C3C["run"][0] = 1;
    level._id_905DDCFDC0322C3C["run"][1] = 1;
    level._id_905DDCFDC0322C3C["sprint"][0] = 1.0;
    level._id_905DDCFDC0322C3C["sprint"][1] = 1.0;
  }

  if(!isDefined(level._id_DD15EE493C7ACC65)) {
    level._id_DD15EE493C7ACC65["slow_walk"] = 1.0;
    level._id_DD15EE493C7ACC65["walk"] = 1.0;
    level._id_DD15EE493C7ACC65["run"] = 1.0;
    level._id_DD15EE493C7ACC65["sprint"] = 1.0;
  }

  if(!isDefined(level._id_03D6E5D2EF374747)) {
    level._id_03D6E5D2EF374747[0] = 1.0;
    level._id_03D6E5D2EF374747[1] = 1.0;
  }

  if(!isDefined(level._id_B61E2B2B1159FCE2)) {
    level._id_B61E2B2B1159FCE2["slow_walk"] = 20;
    level._id_B61E2B2B1159FCE2["walk"] = 20;
    level._id_B61E2B2B1159FCE2["run"] = 24;
    level._id_B61E2B2B1159FCE2["sprint"] = 32;
  }
}

_id_20AB509ECFE07D76() {
  self endon("death");

  if(isDefined(level._id_753F52C768E31266))
    _id_E400A0A530E647C6 = level._id_753F52C768E31266;
  else
    _id_E400A0A530E647C6 = 7;

  if(!isDefined(level.wave_num))
    level.wave_num = 1;

  waitframe();
  self._id_E33465EAACFB7E8B = undefined;
  self._id_8DF3FF6D9DB28011 = undefined;
  thread _id_908EF702189F4655();
  self.legacy.movemode = _id_6397A056EED64FD6(_id_E400A0A530E647C6);
  _id_F7F5CA1B95DDF18A = "";

  for(;;) {
    if(scripts\mp\agents\scriptedagents::isstatelocked() || self.aistate == "traverse") {
      wait 0.05;
      continue;
    }

    if(isDefined(self.isfrozen)) {
      wait 0.05;
      continue;
    }

    if(_id_0A662F25DBF78119::_id_83E45D9DD1B34CA4())
      self._id_8D31C7EACB516468 = 0.85;

    if(isDefined(level._id_804B4F6D9BF13089[self.agent_type])) {
      _id_39129AEFC4AAFB2A = [[level._id_804B4F6D9BF13089[self.agent_type]]](_id_E400A0A530E647C6);

      if(isDefined(_id_39129AEFC4AAFB2A))
        self.legacy.movemode = _id_39129AEFC4AAFB2A;
    }

    if(_id_F7F5CA1B95DDF18A != self.legacy.movemode) {
      _id_F7F5CA1B95DDF18A = self.legacy.movemode;
      self.sharpturnnotifydist = level._id_B61E2B2B1159FCE2[self.legacy.movemode];

      if(isDefined(level._id_47E363E45EE90C6E[self.agent_type]))
        self._id_8D31C7EACB516468 = [[level._id_47E363E45EE90C6E[self.agent_type]]]();
      else
        self._id_8D31C7EACB516468 = 1;

      if(isDefined(level._id_07E9AA42CBB64F35[self.agent_type]))
        self._id_0DA951E8204605E7 = [[level._id_07E9AA42CBB64F35[self.agent_type]]]();
      else
        self._id_0DA951E8204605E7 = 1;

      if(isDefined(level._id_60B011E242899B53[self.agent_type]))
        self._id_D2D25942E3B908E9 = [[level._id_60B011E242899B53[self.agent_type]]]();
      else
        self._id_D2D25942E3B908E9 = 1;

      self._id_05B1209ECD2C2DE2 = self._id_D2D25942E3B908E9;

      if(_id_0A662F25DBF78119::_id_83E45D9DD1B34CA4()) {
        self.sharpturnnotifydist = 100;
        self._id_8D31C7EACB516468 = 0.85;
      }

      scripts\asm\asm_bb::bb_requestmovetype(self.legacy.movemode);
    }

    if(self.legacy.movemode == "sprint") {
      if(istrue(self._id_8DF3FF6D9DB28011)) {
        if(!isDefined(self._id_E33465EAACFB7E8B)) {
          self._id_E33465EAACFB7E8B = 1;
          self._id_8D31C7EACB516468 = 1.15;
        }
      } else if(isDefined(self._id_8DF3FF6D9DB28011)) {
        if(isDefined(level._id_47E363E45EE90C6E[self.agent_type]))
          self._id_8D31C7EACB516468 = [[level._id_47E363E45EE90C6E[self.agent_type]]]();
        else
          self._id_8D31C7EACB516468 = 1;

        self._id_E33465EAACFB7E8B = undefined;
        self._id_8DF3FF6D9DB28011 = undefined;
      }
    }

    if(isDefined(level._id_595A7FF2F08F9503))
      self._id_8D31C7EACB516468 = level._id_595A7FF2F08F9503;

    scripts\engine\utility::waittill_any_timeout_1(1.0, "speed_debuffs_changed");
  }
}

_id_908EF702189F4655() {
  self endon("death");

  for(;;) {
    if(!isDefined(self._id_8DF3FF6D9DB28011)) {
      if(randomint(100) < 25) {
        self._id_8DF3FF6D9DB28011 = 1;
        wait 5;
        self._id_8DF3FF6D9DB28011 = 0;
      }
    }

    wait 5;
  }
}

_id_6397A056EED64FD6(_id_E400A0A530E647C6) {
  if(istrue(self.is_skeleton))
    return "sprint";

  if(isDefined(self.move_override))
    return self.move_override;

  if(level.wave_num == 1)
    return "sprint";

  _id_7DD0C006CD985CFD = level.wave_num * 4;
  _id_00AE14C5A8B1B582 = randomintrange(_id_7DD0C006CD985CFD, _id_7DD0C006CD985CFD + 35);

  if(_id_00AE14C5A8B1B582 <= 32)
    return "slow_walk";
  else if(_id_00AE14C5A8B1B582 <= 55)
    return "walk";
  else if(_id_00AE14C5A8B1B582 <= 78)
    return "run";
  else
    return "sprint";
}

_id_790BAD6671D4D8AF(movemode) {
  _id_0A79E77A41C1ED3B = level._id_DD15EE493C7ACC65[movemode];
  _id_0A79E77A41C1ED3B = _id_0A79E77A41C1ED3B * _id_750CFA498BE0DFA2();
  return _id_0A79E77A41C1ED3B;
}

_id_4168614C1A8FF83D(_id_E400A0A530E647C6) {
  _id_2648B8FC988ECD74 = level.wave_num - 1;

  if(isDefined(self._id_DC54E1455AD27A46))
    _id_2648B8FC988ECD74 = _id_2648B8FC988ECD74 + self._id_DC54E1455AD27A46;

  _id_2648B8FC988ECD74 = int(clamp(_id_2648B8FC988ECD74, 0, level._id_E38F758D6AD03356.size * _id_E400A0A530E647C6 - 1));
  return _id_2648B8FC988ECD74;
}

_id_29634D445C2504D0(_id_E400A0A530E647C6, _id_3CF750ED36E9E6FB, _id_3CD446ED36C38945) {
  _id_2648B8FC988ECD74 = _id_4168614C1A8FF83D(_id_E400A0A530E647C6);
  _id_9A63EA89ADE0F011 = _id_2648B8FC988ECD74 % _id_E400A0A530E647C6;

  if(_id_E400A0A530E647C6 < 2)
    _id_0BC2E3461BCE82E2 = float(_id_9A63EA89ADE0F011) / 1;
  else
    _id_0BC2E3461BCE82E2 = float(_id_9A63EA89ADE0F011) / float(_id_E400A0A530E647C6 - 1);

  _id_0A79E77A41C1ED3B = _id_0A662F25DBF78119::lerp(_id_0BC2E3461BCE82E2, _id_3CF750ED36E9E6FB, _id_3CD446ED36C38945);
  return _id_0A79E77A41C1ED3B;
}

_id_C2E62B51C8BF4631(_id_E400A0A530E647C6, _id_3CF750ED36E9E6FB, _id_3CD446ED36C38945) {
  _id_2648B8FC988ECD74 = _id_4168614C1A8FF83D(_id_E400A0A530E647C6);
  _id_0BC2E3461BCE82E2 = _id_2648B8FC988ECD74 / (level._id_E38F758D6AD03356.size * _id_E400A0A530E647C6 - 1.0);
  _id_0A79E77A41C1ED3B = _id_0A662F25DBF78119::lerp(_id_0BC2E3461BCE82E2, _id_3CF750ED36E9E6FB, _id_3CD446ED36C38945);
  return _id_0A79E77A41C1ED3B;
}

_id_750CFA498BE0DFA2() {
  _id_5284DB3900B88CB3 = 1;

  if(!isDefined(self._id_4208CC56453B6459))
    return _id_5284DB3900B88CB3;

  foreach(key, _id_2327284215F2EB30 in self._id_4208CC56453B6459) {
    if(!isDefined(_id_2327284215F2EB30._id_5284DB3900B88CB3)) {
      continue;
    }
    _id_5284DB3900B88CB3 = _id_5284DB3900B88CB3 * _id_2327284215F2EB30._id_5284DB3900B88CB3;
  }

  return _id_5284DB3900B88CB3;
}

_id_87B62BBB66394F7E() {
  self._id_AED6A471459C1F66 = undefined;
  self.dismember_crawl = 1;
  thread _id_8431F59EFDFF6517();
  level._id_B90AA42D4934AC37++;
  self waittill("death");
  level._id_B90AA42D4934AC37--;
}

_id_8431F59EFDFF6517() {
  self endon("death");
  wait 0.5;
  self._id_86D9FBF4F411FE16 = 1;
}

istraversing() {
  return isDefined(self.istraversing) && self.istraversing;
}

_id_4222D0ECF1D363BA() {
  self endon("death");
  level endon("game_ended");
  _id_206FD4337EA8ED6F = 0;

  for(;;) {
    if(length(self getvelocity()) == 0 && self.aistate == "move")
      _id_206FD4337EA8ED6F = _id_206FD4337EA8ED6F + 0.05;
    else
      _id_206FD4337EA8ED6F = 0;

    if(_id_206FD4337EA8ED6F > 2.0) {
      _id_30A6E70573ED723B = self getnegotiationstartnode();

      if(isDefined(_id_30A6E70573ED723B)) {
        _id_ABD9EE4725B96FC2 = distancesquared(self.origin, _id_30A6E70573ED723B.origin);

        if(_id_ABD9EE4725B96FC2 < squared(15))
          self setOrigin(_id_30A6E70573ED723B.origin, 0);
      }
    }

    wait 0.05;
  }
}

_id_4753F432947152B9(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1) {
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(eattacker) && isai(eattacker) && isDefined(eattacker.unittype) && eattacker.unittype == "zombie") {
      self playSound("zmb_npc_impact_hit");
      self playlocalsound("zmb_player_impact_hit");
    }

    scripts\mp\damage::callback_playerdamage_internal(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1);
    return;
  }

  sweapon = getcompleteweaponname(objweapon);
  idamage = int(idamage);
  finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, 0, modelindex, partname);
  self notify("player_damaged");

  if(idamage <= 0)
    return;
}

finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self))
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname);

  if(!isai(self))
    self playRumbleOnEntity("damage_heavy");
}

_id_E1E82089AC7F4F7D(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  zombie = self;

  if(isDefined(eattacker) && eattacker scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(eattacker.owner))
    eattacker = eattacker.owner;

  if(istrue(self._id_724FFB9C961617C9)) {} else {
    _id_6095280CA2FFDE58 = 0;

    if(sweapon.basename == "molotov_mp")
      idamage = int(floor(float(idamage / 2.5)));
    else if(isDefined(zombie._id_521FAC03E5F3A11B)) {
      if(zombie._id_521FAC03E5F3A11B == level._id_81406583DCF98219) {
        if(shitloc != "head") {
          if(einflictor.classname != "script_vehicle")
            idamage = int(floor(float(idamage) / 10));
        } else if(shitloc == "head" || shitloc == "helmet") {
          idamage = int(floor(float(idamage) / 3));
          _id_6095280CA2FFDE58 = 1;

          if(istrue(zombie.hashelmet)) {
            zombie.hashelmet = undefined;
            zombie detach("c_t9_zmb_ndu_zombie_honorguard_helmet_barbed", "j_helmet");
            eattacker playsoundtoplayer("hit_marker_3d_armor_break", eattacker);
          }
        }
      } else if(isexplosivedamagemod(smeansofdeath)) {
        if(isDefined(level._id_76CE39572BE8612F._id_E77806D8E9E70420))
          idamage = int(floor(idamage * level._id_76CE39572BE8612F._id_E77806D8E9E70420));
      }
    }
  }

  _id_6DA37E0E07826838 = zombie.health;
  _id_A9918B3A8D740F6B = 0;
  _id_2D159C20A9C1823B = !zombie _id_4FE5DD8062BD2FE5() && smeansofdeath != "MOD_FALLING" && sweapon.basename != "repulsor_zombie_mp" && sweapon.basename != "zombie_water_trap_mp";

  if(_id_2D159C20A9C1823B && istrue(zombie.died_poorly))
    _id_2D159C20A9C1823B = 0;

  if(zombie.health > 0)
    _id_A82E5D1900969E3C = clamp(idamage / zombie.health, 0, 1);
  else
    _id_A82E5D1900969E3C = 1;

  if(_id_2D159C20A9C1823B) {
    _id_A9918B3A8D740F6B = zombie _id_7843BF76EC76C6B3(shitloc, sweapon, smeansofdeath, _id_A82E5D1900969E3C, eattacker, vdir, smeansofdeath, einflictor);

    if(_id_A9918B3A8D740F6B && isDefined(eattacker))
      idamage = zombie.health + 1;
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && !isDefined(zombie.favoriteenemy)) {
    _id_A448429024A5BE67 = isDefined(zombie._id_003B90191D39897A) && zombie._id_003B90191D39897A == eattacker;
    _id_0F5F829281B4891C = isDefined(zombie._id_003B90191D39897A) && !isPlayer(zombie._id_003B90191D39897A);

    if(_id_A448429024A5BE67 || _id_0F5F829281B4891C) {
      if(distancesquared(zombie.origin, eattacker.origin) <= zombie._id_6EE412D13BCF28D2) {
        zombie _id_0A662F25DBF78119::_id_33555FFB3402A9B5(eattacker);
        zombie thread _id_9ED5528DA5DCE4C7(0.2);
      }
    }
  }

  if(!zombie _id_D03C6BC4BF0B2F05() && zombie.health - idamage <= 0) {
    zombie thread _id_F608D98BED22C790(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
    idamage = int(max(0, zombie.health - 1));
  }

  _id_6393D7141EDAFB03(idamage, smeansofdeath, sweapon);
  level notify("zombie_damaged", zombie, eattacker);
  agent_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);

  if(isalive(zombie)) {
    if(_id_A9918B3A8D740F6B && !zombie _id_DEF3082A027E7AFA())
      zombie suicide();
  }
}

_id_530B5EDDCFE3FCFB(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(eattacker) && eattacker scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(eattacker.owner))
    eattacker = eattacker.owner;

  if(!istrue(self.shutdown)) {
    level._id_76CE39572BE8612F._id_3F20AAF8B5647B32++;

    switch (self._id_521FAC03E5F3A11B) {
      case "gas_on_death":
        _id_639E5210BBEBFE09 = 50;
        _id_4089ECC93472DB9C = "br_zai_killed_gas";
        break;
      case "explosion_on_death":
        _id_639E5210BBEBFE09 = 50;
        _id_4089ECC93472DB9C = "br_zai_killed_explode";
        break;
      case "emp":
        _id_639E5210BBEBFE09 = 75;
        _id_4089ECC93472DB9C = "br_zai_killed_emp";
        break;
      case "weakpoint":
        _id_639E5210BBEBFE09 = 75;
        _id_4089ECC93472DB9C = "br_zai_killed_weakpoint";
        break;
      default:
        _id_639E5210BBEBFE09 = 30;
        _id_4089ECC93472DB9C = "br_zai_killed";
        break;
    }

    _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

    if(_id_FAF0D2FAC3F47583 != "dmz" && _id_FAF0D2FAC3F47583 != "risk" && _id_FAF0D2FAC3F47583 != "kingslayer") {
      eattacker thread scripts\mp\rank::giverankxp(_id_4089ECC93472DB9C, _id_639E5210BBEBFE09);
      eattacker thread scripts\mp\rank::scoreeventpopup(_id_4089ECC93472DB9C);
    } else {
      eattacker thread scripts\mp\rank::giverankxp(_id_4089ECC93472DB9C + "_low_xp", 10);
      eattacker thread scripts\mp\rank::scoreeventpopup(_id_4089ECC93472DB9C + "_low_xp");
    }
  }

  if(isDefined(self._id_3D886DDE9B70D929))
    self._id_3D886DDE9B70D929.claimer = undefined;

  scripts\mp\mp_agent::default_on_killed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
  _id_4EEAE0670F16191D(self._id_F0C673F8DB6CBD80, smeansofdeath, sweapon);
}

on_zombie_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, _id_6F593AD6C6267D6D) {
  if(isDefined(self._id_003B90191D39897A))
    self._id_003B90191D39897A._id_5A6732EFF9BD04B7 = gettime();

  if(isDefined(self._id_94919E2028DBC9D0))
    [[self._id_94919E2028DBC9D0]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);

  if(isDefined(self._id_3D886DDE9B70D929))
    self._id_3D886DDE9B70D929.claimer = undefined;

  _id_424BA50473D03219 = scripts\mp\mp_agent::should_do_immediate_ragdoll(self);

  if(isDefined(self.nocorpse))
    _id_424BA50473D03219 = 0;

  _id_6F390843ABD4779D = isDefined(self.ragdollimpactvector);

  if(!_id_424BA50473D03219 || !istrue(self._id_06263830DFE60A23))
    self asmdodeathtransition(self.asmname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onAgentKilled") && (isPlayer(eattacker) || isagent(eattacker)))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onAgentKilled")]](einflictor, eattacker, self, idamage, 0, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, 1);

  if(isDefined(self.nocorpse)) {
    if(isDefined(level._id_601827F406D7AAB7) && [[level._id_601827F406D7AAB7]](sweapon)) {
      _id_EA28F46CE0C348C8 = self cloneagent(deathanimduration, 1);
      _id_EA28F46CE0C348C8 hide(1);
    }

    return;
  }

  victim = self;

  if(isDefined(self.has_backpack) && isDefined(level._id_0A6F584CF286AD7F)) {
    if([[level._id_0A6F584CF286AD7F]](eattacker, self.origin))
      self setscriptablepartstate("backpack", "hide", 1);
  }

  if(isDefined(self.ragdollhitloc)) {
    self.body = self cloneagent(deathanimduration, _id_424BA50473D03219);
    self.body.ragdollhitloc = self.ragdollhitloc;
    self.body.ragdollimpactvector = self.ragdollimpactvector;
  } else
    self.body = self cloneagent(deathanimduration, _id_424BA50473D03219);

  if(_id_0CBB0697DE4C5728::_id_BBEE2E46AB15A720(eattacker, sweapon, smeansofdeath, shitloc, einflictor)) {
    return;
  }
  if(isDefined(self.is_burning) || isDefined(eattacker) && isDefined(sweapon) && sweapon.basename == "incendiary_ammo_mp")
    self.body setscriptablepartstate("burning", "active", 1);
  else if(isDefined(self.electrocuted))
    self.body setscriptablepartstate("electrocuted", "active");

  if(isDefined(self._id_9254444F4546E591)) {
    currenttime = gettime();

    foreach(info in self._id_9254444F4546E591) {
      if(info.time != currenttime) {
        continue;
      }
      if(self.body getscriptableparthasstate(info.part, info.state))
        self.body setscriptablepartstate(info.part, info.state, 1);
    }
  }

  if(isDefined(self._id_4F7789AC24F18DF1))
    self.body thread _id_E858A5EB297FD90F(self._id_4F7789AC24F18DF1, istrue(self._id_06263830DFE60A23));

  if(istrue(_id_424BA50473D03219))
    scripts\mp\mp_agent::do_immediate_ragdoll(self.body);
  else if(istrue(_id_6F390843ABD4779D))
    thread _id_999156F5E8767979(self.body, shitloc, vdir, sweapon, einflictor, smeansofdeath);
  else if(!istrue(self.death_anim_no_ragdoll))
    thread scripts\mp\mp_agent::delaystartragdoll(self.body, shitloc, vdir, sweapon, einflictor, smeansofdeath);

  if(isDefined(self.body)) {
    _id_4110A8C207913DFC = getdvarfloat("dvar_F067C82339C56D48", 0.0);

    if(_id_4110A8C207913DFC > 0.0)
      self.body scripts\engine\utility::_id_AD9433AAB9FCDF04(_id_4110A8C207913DFC, "death", ::delete);
  }

  self.death_anim_no_ragdoll = undefined;
}

_id_999156F5E8767979(ent, shitloc, vdir, sweapon, einflictor, smeansofdeath) {
  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(_id_672C0CCE467A1C00 in level.noragdollents) {
      if(distancesquared(ent.origin, _id_672C0CCE467A1C00.origin) < 65536)
        return;
    }
  }

  if(!isDefined(ent)) {
    return;
  }
  if(ent isragdoll()) {
    return;
  }
  if(isDefined(ent)) {
    if(isDefined(ent.ragdollhitloc) && isDefined(ent.ragdollimpactvector))
      ent startragdollfromimpact(ent.ragdollhitloc, ent.ragdollimpactvector);
    else
      ent startragdoll();
  }
}

_id_E858A5EB297FD90F(timer, _id_06263830DFE60A23) {
  if(!istrue(_id_06263830DFE60A23))
    wait(timer);

  if(isDefined(self)) {
    self setscriptablepartstate("death_fx", "active", 1);
    wait 0.1;
    self hide(1);
  }
}

_id_0CF3FA2D57E75C8E(_id_EE9F7F2B851CC905, _id_F0C673F8DB6CBD80) {
  fxname = level._id_821252F0EBAE8EB9[_id_EE9F7F2B851CC905]["torsoFX"];

  if(isDefined(_id_F0C673F8DB6CBD80)) {
    if(isDefined(_id_F0C673F8DB6CBD80["emz"]))
      fxname = fxname + "_emz";
    else if(isDefined(_id_F0C673F8DB6CBD80["exploder"]))
      fxname = fxname + "_exp";
    else if(isDefined(_id_F0C673F8DB6CBD80["fast"]))
      fxname = fxname + "_ovr";
  }

  playFXOnTag(scripts\engine\utility::getfx(fxname), self.body, level._id_821252F0EBAE8EB9[_id_EE9F7F2B851CC905]["fxTagName"]);
  wait 10;

  if(isDefined(self.body))
    stopFXOnTag(scripts\engine\utility::getfx(fxname), self.body, level._id_821252F0EBAE8EB9[_id_EE9F7F2B851CC905]["fxTagName"]);
}

_id_4FE5DD8062BD2FE5() {
  return isDefined(self._id_DE53242FCA0E7881);
}

agent_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  if(isDefined(einflictor) || isDefined(eattacker)) {
    if(!isDefined(einflictor))
      einflictor = eattacker;

    if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
      if(isDefined(einflictor.classname) && einflictor.classname == "script_vehicle")
        return 0;
    }

    if(isDefined(einflictor.classname) && einflictor.classname == "auto_turret")
      eattacker = einflictor;

    if(isDefined(eattacker) && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(eattacker.team) && eattacker.team != self.team)
          self setagentattacker(eattacker);
      } else
        self setagentattacker(eattacker);
    }
  }

  if(isDefined(level._id_C01235187BC88F5A) && !scripts\engine\utility::array_contains(level._id_C01235187BC88F5A._id_B4D3F717373AF2BB, self.unittype))
    scripts\mp\mp_agent::default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);

  return 1;
}

_id_4645B83FB0DCA1E9() {
  if(isDefined(self._id_9913B144430B5B4C) && self._id_9913B144430B5B4C)
    return 1;

  if(isDefined(self._id_3125E097AACD42FE) && self._id_3125E097AACD42FE)
    return 1;

  return 0;
}

_id_1F575FFE0E5D2C4E() {
  self notify("updatePainSensor");
  self endon("updatePainSensor");
  self endon("death");
  self._id_178A54FEBDE2EC97 = spawnStruct();
  self._id_178A54FEBDE2EC97.lastpaintime = gettime();
  self._id_178A54FEBDE2EC97.damage = 0.0;
  _id_CD743003D3F4F0CA = 0.05;
  _id_A35692B629483499 = 5 * _id_CD743003D3F4F0CA;

  for(;;) {
    wait(_id_CD743003D3F4F0CA);

    if(gettime() > self._id_178A54FEBDE2EC97.lastpaintime + 2000)
      self._id_178A54FEBDE2EC97.damage = self._id_178A54FEBDE2EC97.damage - _id_A35692B629483499;

    self._id_178A54FEBDE2EC97.damage = max(self._id_178A54FEBDE2EC97.damage, 0);

    if(_id_4645B83FB0DCA1E9())
      self._id_178A54FEBDE2EC97.damage = 0;
  }
}

_id_D03C6BC4BF0B2F05() {
  if(gettime() - self.spawntime <= 0.05)
    return 0;

  return 1;
}

_id_F608D98BED22C790(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");

  while(isDefined(self) && isalive(self)) {
    self._id_CDB2FAB6A055B0AA = 1;

    if(!_id_D03C6BC4BF0B2F05()) {
      wait 0.05;
      continue;
    }

    self._id_CDB2FAB6A055B0AA = 0;
    _id_E1E82089AC7F4F7D(einflictor, eattacker, self.health + 1, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
  }
}

_id_6393D7141EDAFB03(idamage, smeansofdeath, sweapon) {
  if(isDefined(self._id_5A286015ECE43829))
    [[self._id_5A286015ECE43829]](idamage, smeansofdeath, sweapon);

  self._id_178A54FEBDE2EC97.lastpaintime = gettime();
  self._id_178A54FEBDE2EC97.damage = self._id_178A54FEBDE2EC97.damage + idamage;
}

_id_DEF3082A027E7AFA(ai) {
  return isDefined(self._id_CDB2FAB6A055B0AA) && self._id_CDB2FAB6A055B0AA;
}

_id_1484600EC292770E() {
  if(isDefined(self.script_parameters) && (self.script_parameters == "no_boards" || self.script_parameters == "ground_spawn_no_boards"))
    return 1;

  return 0;
}

_id_1FE8127365E94575(taskid) {
  time = gettime();

  if(isDefined(self._id_E5905596F3BA68B4)) {
    if(time >= self._id_E5905596F3BA68B4) {
      self._id_E5905596F3BA68B4 = undefined;
      return anim.failure;
    }

    return anim.running;
  }

  if(!isDefined(self._id_003B90191D39897A)) {
    self._id_E5905596F3BA68B4 = time + 2000;
    return anim.running;
  }

  dist = distance2d(self.origin, self._id_003B90191D39897A.origin);

  if(dist < 1200)
    return anim.failure;

  if(dist > 2000) {
    self._id_E5905596F3BA68B4 = time + 500;
    return anim.running;
  }

  dist = dist - 1200;
  _id_B1D0BC03029F6A2C = dist / 800;
  self._id_E5905596F3BA68B4 = time + 200 + int(_id_B1D0BC03029F6A2C * 300);
  return anim.running;
}

_id_1ABC3A6C25B2532C(taskid) {
  if(isDefined(level._id_A4C1E569C411D8BE)) {
    if(!self[[level._id_A4C1E569C411D8BE]]())
      return anim.failure;
    else if(self.hastraversed)
      return anim.failure;
  }

  return anim.success;
}

_id_64451C7C5F28AD3E() {
  self endon("AbortEnterPlayspace");
  self._id_DD832DDF906E5945 = 1;
  self[[level._id_947D59101FD80495]]();
  self._id_DD832DDF906E5945 = 0;
}

_id_1C0A6BBCC552B6F6(taskid) {
  self._id_C61769CBBAEFB13E = 1;
}

_id_78B8A2B2A51787CB(taskid) {
  self notify("AbortEnterPlayspace");
}

_id_76059E9B4C48EB43(taskid) {
  if(istrue(self.entered_playspace))
    return anim.success;

  return anim.running;
}

_id_8225E9DBF1FD31A5(taskid) {
  if(!istrue(self.scripted_mode))
    return anim.failure;

  return anim.running;
}

_id_E37573971690C6F6(target) {
  if(!istrue(target.inlaststand) && sighttracepassed(self.origin + (0, 0, 50), target.origin + (0, 0, 50), 0, self, target))
    return 1;

  return 0;
}

_id_CD66A77A472DDD65() {
  _id_542F6574FCB1588B = getdvarint("dvar_8CE63CCD43B4E9BE", 1);

  if(_id_542F6574FCB1588B == 0)
    return 0;

  if(isDefined(self._id_8B21F2B424F46AF0)) {
    _id_A5D73BCACA566673 = gettime() - self._id_B7BDFA418F9F4430;

    if(_id_A5D73BCACA566673 < self._id_8B21F2B424F46AF0 * 1000)
      return 0;
  }

  if(isDefined(self._id_521FAC03E5F3A11B) && self._id_521FAC03E5F3A11B == "ranger") {
    if(distancesquared(self.origin, self._id_003B90191D39897A.origin) > squared(getdvarfloat("dvar_724B65C1388CA501", 1000)))
      return 0;
  }

  _id_27C441810F48CC73 = getdvarfloat("dvar_AAA1F671C868B5FA", 0.05);

  if(gettime() >= self._id_BF830B312EB47E30) {
    self._id_BF830B312EB47E30 = gettime() + 1000;
    _id_CDC5DD6C28C9709D = squared(getdvarfloat("dvar_D89A23C4B5AB21E5", 1500));
    _id_8336F113929858A6 = distancesquared(self.origin, self._id_003B90191D39897A.origin);

    if(_id_8336F113929858A6 > _id_CDC5DD6C28C9709D)
      return 0;

    if(istrue(self._id_788DDF5CE6DE796A))
      _id_27C441810F48CC73 = 1.0;
    else {
      _id_4F0FC1C36324AFFB = squared(getdvarfloat("dvar_5AE64712FF3B009B", 300));

      if(_id_8336F113929858A6 < _id_4F0FC1C36324AFFB)
        _id_27C441810F48CC73 = 0.0;

      if(isDefined(self._id_521FAC03E5F3A11B) && self._id_521FAC03E5F3A11B == "ranger") {
        if(_id_8336F113929858A6 <= squared(getdvarfloat("dvar_0F2F39913E3839A2", 50)))
          _id_27C441810F48CC73 = 0.0;
        else
          _id_27C441810F48CC73 = 1.0;
      }
    }

    _id_A04E3E81966BBB66 = randomfloat(1);

    if(_id_A04E3E81966BBB66 < _id_27C441810F48CC73)
      return _id_E37573971690C6F6(self._id_003B90191D39897A);
  }

  return 0;
}

_id_262E486F37ACA7C5(taskid) {
  _id_D6F7FD08061BDDF3();

  if(self.ignoreall)
    return anim.failure;

  if(!isDefined(self._id_003B90191D39897A))
    return anim.failure;

  if(isDefined(self._id_003B90191D39897A.ignoreme) && self._id_003B90191D39897A.ignoreme == 1)
    return anim.failure;

  if(isDefined(self._id_003B90191D39897A.killing_time))
    return anim.failure;

  if(self.aistate == "melee" || scripts\mp\agents\scriptedagents::isstatelocked())
    return anim.failure;

  if(!_id_0A662F25DBF78119::_id_6F1F2CF8495FB8F2())
    return anim.failure;

  if(_id_CD66A77A472DDD65()) {
    scripts\asm\asm_bb::bb_requestmelee(self._id_003B90191D39897A);
    self._blackboard._id_1FE1B9B8CD0B87AC = 1;
    return anim.failure;
  }

  if(_id_0A662F25DBF78119::_id_3044FF47CEA632AC())
    return anim.failure;

  if(_id_0A662F25DBF78119::_id_2D78D2CF5681691A())
    return anim.failure;

  _id_083D75332F46BDDC = istrue(self._id_6B4B9114BC1E7B35) && isDefined(self._id_99A76E83D749ADC8) && gettime() - self._id_99A76E83D749ADC8 <= self._id_6BF0F8E4D7FE1763;

  if(!ispointonnavmesh(self._id_003B90191D39897A.origin, self) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(!_id_0A662F25DBF78119::_id_06F13D6BE163AD9A("offmesh"))
      return anim.failure;
  } else if(_id_0A662F25DBF78119::_id_977823E93057BB7F() || _id_083D75332F46BDDC) {
    if(!_id_0A662F25DBF78119::_id_06F13D6BE163AD9A("base"))
      return anim.failure;
  } else if(!_id_0A662F25DBF78119::_id_06F13D6BE163AD9A("normal"))
    return anim.failure;

  if(isDefined(self._id_67E1D89E2F7C463D)) {
    _id_50930C459A70582A = gettime() - self._id_9563742BCC8616C5;

    if(_id_50930C459A70582A < self._id_67E1D89E2F7C463D * 1000)
      return anim.failure;
  }

  if(!isDefined(self._id_8A1D0DF0BFD00B8B) || distancesquared(self._id_8A1D0DF0BFD00B8B, self.origin) > 256) {
    if(!isDefined(self.asm.cur_move_mode))
      _id_2F10825BA72AADD1 = self.legacy.movemode;
    else
      _id_2F10825BA72AADD1 = self.asm.cur_move_mode;

    self._id_ECD7A04BA5810935 = _id_2F10825BA72AADD1;
  }

  scripts\asm\asm_bb::bb_requestmelee(self._id_003B90191D39897A);
  return anim.failure;
}

_id_14627B1045DA03DD(taskid) {
  if(!istrue(self.is_suicide_bomber))
    return anim.failure;

  _id_D6F7FD08061BDDF3();

  if(self.ignoreall)
    return anim.failure;

  if(!isDefined(self._id_003B90191D39897A))
    return anim.failure;

  if(isDefined(self._id_003B90191D39897A.ignoreme) && self._id_003B90191D39897A.ignoreme == 1)
    return anim.failure;

  if(self.aistate == "melee" || scripts\mp\agents\scriptedagents::isstatelocked())
    return anim.failure;

  if(!_id_0A662F25DBF78119::_id_6F1F2CF8495FB8F2())
    return anim.failure;

  if(!_id_612A12877E1A9877(self._id_003B90191D39897A))
    return anim.failure;

  _id_8A84A73AB81D4101(self._id_003B90191D39897A);
  return anim.failure;
}

_id_8A84A73AB81D4101(target) {
  self._blackboard._id_45C3DFCA98A9533B = 1;
}

_id_D6F7FD08061BDDF3() {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  self._blackboard._id_1FE1B9B8CD0B87AC = 0;
}

_id_612A12877E1A9877(target) {
  return distancesquared(self.origin, target.origin) <= 5625;
}

_id_B04028D06F64F4C7(taskid) {
  scripts\asm\asm_bb::bb_setisincombat(1);

  if(self.ignoreall) {
    self._id_003B90191D39897A = undefined;
    return anim.failure;
  }

  if(gettime() < self._id_BB57EF5C97F7C107)
    return anim.failure;

  if(isDefined(self.hastraversed) && self.hastraversed)
    self.noturnanims = 0;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(isDefined(self.enemy.is_fast_traveling) || isDefined(self.enemy._id_5AA26DCE2C71AD98)) {
    self._id_003B90191D39897A = undefined;
    return anim.failure;
  }

  if(isDefined(self.enemy.killing_time)) {
    self._id_003B90191D39897A = undefined;
    return anim.failure;
  }

  if(istrue(self.badpath)) {
    if(getdvarint("dvar_04276F4B86D24E50", 1) == 1) {
      self._id_003B90191D39897A = undefined;
      return anim.failure;
    }
  }

  _id_8A755B28784E6E3E = undefined;

  if(isDefined(self._id_DF6B3BF77BD413EC) && _id_0A662F25DBF78119::_id_B62A600F1B081011())
    _id_8A755B28784E6E3E = self._id_DF6B3BF77BD413EC;
  else if(isDefined(self._id_1E0B2C127D2BE63E))
    _id_8A755B28784E6E3E = self._id_1E0B2C127D2BE63E;
  else if(isDefined(self.enemy) && _id_1B16718B8A59C8B7(self.enemy)) {
    _id_A48654BAAE4A5395 = self.enemy scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(_id_A48654BAAE4A5395))
      _id_8A755B28784E6E3E = _id_A48654BAAE4A5395;
    else
      _id_8A755B28784E6E3E = self.enemy;
  }

  if(!isDefined(_id_8A755B28784E6E3E)) {
    if(isDefined(self._id_003B90191D39897A))
      self._id_0D4AE052F5BDA013 = 1;

    self._id_003B90191D39897A = undefined;
    return anim.failure;
  }

  _id_F0F8688A462D92B3 = self._id_C8818686F12F33B6 + self.radius * 2;
  _id_FA4921E2D9CC530C = _id_F0F8688A462D92B3 * _id_F0F8688A462D92B3;
  _id_56FA69700B1EA66C = self._id_C8818686F12F33B6;
  _id_1FC7F4A734F26EAD = _id_56FA69700B1EA66C * _id_56FA69700B1EA66C;
  self._id_003B90191D39897A = _id_8A755B28784E6E3E;
  _id_225D5BE1546186A5 = _id_0A662F25DBF78119::_id_FD42BE10A26FFF59(_id_8A755B28784E6E3E);
  _id_8ADC06D9FDFE6452 = _id_225D5BE1546186A5._id_1A9D3CFAC74BF193;
  _id_D3C016046F1C9488 = distancesquared(_id_225D5BE1546186A5.origin, self.origin);
  _id_3711CDF227CCD51B = distancesquared(_id_8ADC06D9FDFE6452, self.origin);
  _id_A39B4B2953D5C958 = self._id_0D4AE052F5BDA013;

  if(_id_3711CDF227CCD51B < squared(self.radius) && distancesquared(_id_8ADC06D9FDFE6452, _id_225D5BE1546186A5.origin) > squared(self.radius)) {
    _id_A39B4B2953D5C958 = 1;
    self notify("attack_anim", "end");
  }

  if(!_id_A39B4B2953D5C958 && _id_3711CDF227CCD51B > _id_FA4921E2D9CC530C && _id_D3C016046F1C9488 > _id_1FC7F4A734F26EAD)
    _id_A39B4B2953D5C958 = 1;

  _id_16CF274FFC86E1E2(_id_3711CDF227CCD51B);

  if(_id_225D5BE1546186A5._id_05956C54E54EBF3D) {
    if(!_id_A39B4B2953D5C958 && _id_3711CDF227CCD51B <= _id_FA4921E2D9CC530C && _id_D3C016046F1C9488 > squared(self._id_B9DC79113497B05B))
      _id_A39B4B2953D5C958 = 1;

    self.goalradius = self._id_B9DC79113497B05B;
  } else if(!_id_0A662F25DBF78119::_id_47ED76E02C439723(_id_8A755B28784E6E3E, self._id_5754D6C3DF1A2B31)) {
    self.goalradius = self._id_B9DC79113497B05B;
    _id_A39B4B2953D5C958 = 1;
  } else {
    self.goalradius = _id_F0F8688A462D92B3;

    if(_id_3711CDF227CCD51B <= _id_FA4921E2D9CC530C) {
      _id_225D5BE1546186A5.origin = self.origin;
      _id_A39B4B2953D5C958 = 1;
    }
  }

  if(_id_A39B4B2953D5C958 || isDefined(self._id_521FAC03E5F3A11B) && self._id_521FAC03E5F3A11B == "ranger") {
    _id_F33F587E225DE2AF = _id_9F9C992BC1154282(_id_8A755B28784E6E3E, _id_225D5BE1546186A5.origin, 10000);

    if(isDefined(_id_F33F587E225DE2AF)) {
      if(distance(_id_F33F587E225DE2AF, self.origin) > 5000) {
        self._id_0D4AE052F5BDA013 = 1;
        self._id_003B90191D39897A = undefined;
        return anim.failure;
      }

      self setgoalpos(_id_F33F587E225DE2AF);
      self._id_0D4AE052F5BDA013 = 0;
    }
  }

  return anim.success;
}

_id_16CF274FFC86E1E2(_id_3711CDF227CCD51B) {
  if(!0 || !isPlayer(self._id_003B90191D39897A)) {
    return;
  }
  time = gettime();

  if(!isDefined(self._id_003B90191D39897A._id_5A6732EFF9BD04B7))
    self._id_003B90191D39897A._id_5A6732EFF9BD04B7 = time;
  else if(time < self._id_003B90191D39897A._id_5A6732EFF9BD04B7) {
    return;
  }
  _id_B55FC573AAA3D8D4 = self._id_003B90191D39897A.origin - self.origin;
  _id_CBDE868D773316B1 = anglesToForward(self._id_003B90191D39897A.angles);
  dot = vectordot(_id_B55FC573AAA3D8D4, _id_CBDE868D773316B1);

  if(dot > 0 && _id_3711CDF227CCD51B < 250000) {
    self._id_003B90191D39897A._id_5A6732EFF9BD04B7 = time + randomintrange(3000, 5000);
    self._id_003B90191D39897A playlocalsound("zmb_player_impact_hit");
  }
}

_id_9F9C992BC1154282(target_ent, _id_BF1B72D688BC972D, _id_2057ACE5B545925D) {
  self._id_788DDF5CE6DE796A = undefined;
  _id_F33F587E225DE2AF = getclosestpointonnavmesh(_id_BF1B72D688BC972D);
  _id_E1BBCB81B41FFEFD = distancesquared(_id_F33F587E225DE2AF, _id_BF1B72D688BC972D);

  if(getdvarint("dvar_8CE63CCD43B4E9BE", 1) != 0) {
    if(isDefined(self._id_521FAC03E5F3A11B) && self._id_521FAC03E5F3A11B == "ranger") {
      _id_E80F66E023B2AEA2 = getdvarint("dvar_ED5F8FFB19F810CB", 500);

      if(distancesquared(self.origin, target_ent.origin) <= squared(_id_E80F66E023B2AEA2))
        return self.origin;
    }

    _id_AC6B2AECD711A3BC = _id_7755EA2956BA1119(_id_F33F587E225DE2AF);
    _id_5C2C6C447B4C1BD1 = _id_0A662F25DBF78119::_id_8C1EBABCC8737D7E(_id_AC6B2AECD711A3BC, target_ent.origin);

    if(_id_E1BBCB81B41FFEFD > 625 || !_id_5C2C6C447B4C1BD1) {
      if(istrue(self._id_16CF75FF2BB42685))
        self._id_788DDF5CE6DE796A = 1;
      else if(!_id_5C2C6C447B4C1BD1)
        self._id_788DDF5CE6DE796A = 1;
      else if(!ispointonnavmesh(self._id_003B90191D39897A.origin, self)) {
        if(!_id_0A662F25DBF78119::_id_1EA5D1AD97D72DA5(_id_AC6B2AECD711A3BC, target_ent.origin))
          self._id_788DDF5CE6DE796A = 1;
      } else if(!_id_0A662F25DBF78119::_id_B5C47115061C80C9(_id_AC6B2AECD711A3BC, target_ent.origin))
        self._id_788DDF5CE6DE796A = 1;

      if(istrue(self._id_788DDF5CE6DE796A)) {
        _id_85E5C0853898D9FA = distancesquared(self.origin, _id_BF1B72D688BC972D);
        _id_21B0311D64CADFA2 = getdvarfloat("dvar_C89FB9C2BE16AC4F", 600);
        _id_6025F24941184817 = squared(_id_21B0311D64CADFA2);

        if(_id_85E5C0853898D9FA < _id_6025F24941184817 && _id_E37573971690C6F6(target_ent))
          _id_F33F587E225DE2AF = self.origin;
      }
    }
  } else if(_id_E1BBCB81B41FFEFD > _id_2057ACE5B545925D)
    return undefined;

  return _id_F33F587E225DE2AF;
}

_id_7755EA2956BA1119(_id_F33F587E225DE2AF) {
  _id_AC6B2AECD711A3BC = scripts\mp\agents\scriptedagents::droppostoground(_id_F33F587E225DE2AF, 128);

  if(!isDefined(_id_AC6B2AECD711A3BC)) {
    _id_AC6B2AECD711A3BC = getgroundposition(_id_F33F587E225DE2AF, 1, 128, 0);

    if(!isDefined(_id_AC6B2AECD711A3BC))
      _id_AC6B2AECD711A3BC = _id_F33F587E225DE2AF - (0, 0, 10);
  }

  return _id_AC6B2AECD711A3BC;
}

_id_56A13C24FDAAF353(taskid) {
  if(isDefined(self._id_68011EA8DFF99DB6))
    return anim.failure;

  _id_395824552AD4CB06 = [];

  foreach(_id_7DC3241E7F3C6B24 in level.players) {
    if(_id_7DC3241E7F3C6B24.ignoreme || isDefined(_id_7DC3241E7F3C6B24.owner) && _id_7DC3241E7F3C6B24.owner.ignoreme) {
      continue;
    }
    if(!_id_1B16718B8A59C8B7(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(!isalive(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    _id_395824552AD4CB06[_id_395824552AD4CB06.size] = _id_7DC3241E7F3C6B24;
  }

  _id_6293B832D8F1FE43 = undefined;

  if(_id_395824552AD4CB06.size > 0)
    _id_6293B832D8F1FE43 = sortbydistance(_id_395824552AD4CB06, self.origin);

  if(isDefined(_id_6293B832D8F1FE43) && _id_6293B832D8F1FE43.size > 0) {
    goalradius = 300;
    _id_6F1937277208C460 = distancesquared(_id_6293B832D8F1FE43[0].origin, self.origin);

    if(_id_6F1937277208C460 < goalradius * goalradius)
      goalradius = 16;

    _id_84E9BA7F67FF8090 = goalradius * goalradius;

    if(self._id_0D4AE052F5BDA013 || !isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, _id_6293B832D8F1FE43[0].origin) > _id_84E9BA7F67FF8090) {
      _id_672F20A520D6C841 = _id_6293B832D8F1FE43[0].origin;
      _id_0C3EA9B1A20FF199 = getclosestpointonnavmesh(_id_672F20A520D6C841, self);

      if(distancesquared(_id_0C3EA9B1A20FF199, _id_6293B832D8F1FE43[0].origin) > _id_84E9BA7F67FF8090)
        return anim.failure;

      self setgoalpos(_id_0C3EA9B1A20FF199);
      self._id_0D4AE052F5BDA013 = 0;
    }

    scripts\asm\asm_bb::bb_setisincombat(1);
    return anim.success;
  }

  return anim.failure;
}

_id_1B16718B8A59C8B7(_id_BFDFDCCACCC50166) {
  zombie = self;

  if(!isDefined(_id_BFDFDCCACCC50166) || _id_0A662F25DBF78119::_id_A0CC8513F431ED0D(_id_BFDFDCCACCC50166))
    return 0;

  _id_681C9A08F4AC4EF8 = distancesquared(zombie.origin, _id_BFDFDCCACCC50166.origin) > 100000000;

  if(_id_681C9A08F4AC4EF8)
    return 0;

  return 1;
}

_id_3771B152C7260E89(taskid) {
  scripts\asm\asm_bb::bb_setisincombat(0);

  if(isDefined(level._id_D2EE5794F8E5EAC1)) {
    _id_0C3EA9B1A20FF199 = self[[level._id_D2EE5794F8E5EAC1]]();

    if(isDefined(_id_0C3EA9B1A20FF199))
      self setgoalpos(_id_0C3EA9B1A20FF199);
    else
      self clearpath();
  } else if(istrue(self._id_2964A6C155E309F9)) {
    _id_991A04BA80E4895F = getrandomnavpoint(self.origin, 300);

    if(isDefined(_id_991A04BA80E4895F))
      self setgoalpos(_id_991A04BA80E4895F);
  }

  return anim.success;
}

_id_9ED5528DA5DCE4C7(timer) {
  self endon("death");
  wait(timer);
  self.favoriteenemy = undefined;
}

_id_13AFF24327B0AA83() {
  level._id_821252F0EBAE8EB9[1]["tagName"] = "J_Shoulder_RI";
  level._id_821252F0EBAE8EB9[2]["tagName"] = "J_Shoulder_LE";
  level._id_821252F0EBAE8EB9[4]["tagName"] = "J_Hip_RI";
  level._id_821252F0EBAE8EB9[8]["tagName"] = "J_Hip_LE";
  level._id_821252F0EBAE8EB9[16]["tagName"] = "J_Head";
  level._id_821252F0EBAE8EB9[1]["torsoFX"] = "torso_arm_loss_right";
  level._id_821252F0EBAE8EB9[2]["torsoFX"] = "torso_arm_loss_left";
  level._id_821252F0EBAE8EB9[4]["torsoFX"] = "torso_loss_right";
  level._id_821252F0EBAE8EB9[8]["torsoFX"] = "torso_loss_left";
  level._id_821252F0EBAE8EB9[16]["torsoFX"] = "torso_head_loss";
  level._id_821252F0EBAE8EB9[1]["fxTagName"] = "J_Shoulder_RI";
  level._id_821252F0EBAE8EB9[2]["fxTagName"] = "J_Shoulder_LE";
  level._id_821252F0EBAE8EB9[4]["fxTagName"] = "J_Hip_RI";
  level._id_821252F0EBAE8EB9[8]["fxTagName"] = "J_Hip_LE";
  level._id_821252F0EBAE8EB9[16]["fxTagName"] = "j_neck";
  level._id_821252F0EBAE8EB9["full"]["fxTagName"] = "J_MainRoot";
  level._id_821252F0EBAE8EB9[1]["limbFX"] = "arm_loss_right";
  level._id_821252F0EBAE8EB9[2]["limbFX"] = "arm_loss_left";
  level._id_821252F0EBAE8EB9[4]["limbFX"] = "limb_loss_right";
  level._id_821252F0EBAE8EB9[8]["limbFX"] = "limb_loss_left";
  level._id_821252F0EBAE8EB9[16]["limbFX"] = "head_loss";
  level._id_17EF2A119729E1F6 = 0;
}

loadvfx() {}

_id_7843BF76EC76C6B3(location, weaponname, _id_D95DA0355CF4CCB4, _id_A82E5D1900969E3C, eattacker, _id_A52F740328ED97BB, smeansofdeath, einflictor) {
  _id_A9918B3A8D740F6B = 0;
  weaponname = weaponname.basename;

  if(!_id_E311827DC852AF62(self))
    return 0;

  if(_func_53BC7625403C35AC(weaponname))
    return 0;

  if(isalive(self) && (!scripts\mp\agents\scriptedagents::isstatelocked() || _id_A82E5D1900969E3C >= 1) && !istraversing()) {
    if(!isDefined(self._id_E4CC6D9942333B6F))
      self._id_E4CC6D9942333B6F = 0;

    _id_BDF522C561E36249 = _id_30FFB5618494812B(location, weaponname, _id_D95DA0355CF4CCB4, _id_A82E5D1900969E3C, eattacker, self._id_E4CC6D9942333B6F, einflictor);

    if(_id_BDF522C561E36249 != 0) {
      _id_78D41C09FF0E027B = !istrue(self.dismember_crawl);
      _id_73CF110BEAC62ACF = isDefined(self._id_E4CC6D9942333B6F) && self._id_E4CC6D9942333B6F == 0;

      if(level._id_B90AA42D4934AC37 < 8 || istrue(self.dismember_crawl) || (_id_BDF522C561E36249 & 12) == 0 || (_id_BDF522C561E36249 & 16) != 0 || (self._id_E4CC6D9942333B6F & 3) != 0) {
        if(_id_C10CBCAC37301028(self._id_E4CC6D9942333B6F | _id_BDF522C561E36249, weaponname, _id_A82E5D1900969E3C, _id_A52F740328ED97BB, smeansofdeath)) {
          if(_id_558B6C1B5CFAE9EC())
            earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);

          _id_A9918B3A8D740F6B = 1;
        }
      }
    }
  }

  return _id_A9918B3A8D740F6B;
}

_id_E311827DC852AF62(zombie) {
  if(!getdvarint("dvar_2DD2813936134782", 0))
    return 0;

  if(istrue(self._id_06263830DFE60A23))
    return 0;

  if(isDefined(self._id_5E94D0B8D42DEAA3))
    return 0;

  if(isDefined(zombie.isfrozen))
    return 0;

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim)
    return 0;

  if(isDefined(level._id_916CD132212014DB))
    return [[level._id_916CD132212014DB]](zombie);

  return 1;
}

_id_30FFB5618494812B(location, weaponname, _id_D95DA0355CF4CCB4, _id_A82E5D1900969E3C, eattacker, _id_E4CC6D9942333B6F, einflictor) {
  _id_CAA61C143B86DA98 = _id_558B6C1B5CFAE9EC();

  if(location == "none" && _id_A82E5D1900969E3C >= 0.25) {
    _id_CAA61C143B86DA98 = _id_CAA61C143B86DA98 || isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle();
    _id_CAA61C143B86DA98 = _id_CAA61C143B86DA98 || isDefined(_id_D95DA0355CF4CCB4) && isexplosivedamagemod(_id_D95DA0355CF4CCB4);
  }

  if(_id_CAA61C143B86DA98)
    _id_7D2C90FC7E0CD9C6 = 31;
  else
    _id_7D2C90FC7E0CD9C6 = _id_09184F852E22385A(location);

  modifiers = 1;

  if(isDefined(level._id_EE5BFDDFCBCF5CEA)) {
    _id_170C587E68A7E466 = [[level._id_EE5BFDDFCBCF5CEA]](_id_7D2C90FC7E0CD9C6, weaponname, _id_D95DA0355CF4CCB4, _id_A82E5D1900969E3C, eattacker, _id_E4CC6D9942333B6F, einflictor);

    if(isDefined(_id_170C587E68A7E466))
      _id_7D2C90FC7E0CD9C6 = _id_170C587E68A7E466;
  }

  if(_id_7D2C90FC7E0CD9C6 == 0)
    return 0;

  modifiers = modifiers * (_id_CA6D955288ACABFE(eattacker, weaponname, undefined) * _id_CA6D955288ACABFE(eattacker, undefined, _id_D95DA0355CF4CCB4));
  modifiers = modifiers * (-0.7 * _id_A82E5D1900969E3C + 1);
  return _id_79C07C4B23EA0F7A(_id_7D2C90FC7E0CD9C6, _id_E4CC6D9942333B6F, _id_A82E5D1900969E3C, modifiers);
}

_id_558B6C1B5CFAE9EC() {
  _id_D1E1B3C105862BC6 = scripts\engine\utility::flag_exist("insta_kill") && scripts\engine\utility::flag("insta_kill");
  return _id_D1E1B3C105862BC6;
}

_id_09184F852E22385A(location) {
  switch (location) {
    case "right_arm_upper":
    case "right_hand":
    case "right_arm_lower":
      return 1;
    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;
    case "right_leg_lower":
    case "right_foot":
    case "right_leg_upper":
      return 4;
    case "left_leg_lower":
    case "left_foot":
    case "left_leg_upper":
      return 8;
    case "neck":
    case "head":
    case "helmet":
      return 16;
    default:
      return 0;
  }
}

_id_CA6D955288ACABFE(eattacker, weaponname, _id_D95DA0355CF4CCB4) {
  if(_id_558B6C1B5CFAE9EC())
    return 0;

  _id_B9087326BDD4F8EF = undefined;

  if(isDefined(weaponname)) {
    weaponname = getweaponbasename(weaponname);
    _id_B9087326BDD4F8EF = weaponname;
  } else if(isDefined(_id_D95DA0355CF4CCB4))
    _id_B9087326BDD4F8EF = _id_D95DA0355CF4CCB4;

  if(!isDefined(_id_B9087326BDD4F8EF))
    return 1;

  if(isDefined(level._id_6634C8A94C28FEBD) && isDefined(level._id_6634C8A94C28FEBD[_id_B9087326BDD4F8EF]))
    return level._id_6634C8A94C28FEBD[_id_B9087326BDD4F8EF];

  modifier = 1.0;

  if(isDefined(modifier))
    return modifier;
  else
    return 1;
}

_id_79C07C4B23EA0F7A(_id_7D2C90FC7E0CD9C6, _id_E4CC6D9942333B6F, _id_A82E5D1900969E3C, modifiers) {
  _id_BDF522C561E36249 = 0;

  if(!isDefined(modifiers))
    modifiers = 1;

  test = _id_7D2C90FC7E0CD9C6 &_id_7D2C90FC7E0CD9C6 - 1;

  if(test > 0) {
    if(_id_A82E5D1900969E3C < 1) {
      _id_1C7D60421D75BC77 = randomint(24);
      _id_ED5EFD3F3C5BE876 = 228;

      for(_id_AC0E594AC96AA3A8 = 4; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
        _id_8D68C837270C1B62 = 1 << _id_1C7D60421D75BC77 % _id_AC0E594AC96AA3A8 * 2;
        _id_1C7D60421D75BC77 = int(_id_1C7D60421D75BC77 / _id_AC0E594AC96AA3A8);
        _id_034BAF23CFCE266E = _id_ED5EFD3F3C5BE876 % _id_8D68C837270C1B62;
        _id_DA611C632FE7481B = int(_id_ED5EFD3F3C5BE876 / _id_8D68C837270C1B62);
        _id_ED5EFD3F3C5BE876 = _id_034BAF23CFCE266E + (_id_DA611C632FE7481B >> 2) * _id_8D68C837270C1B62;
        _id_EC335DDDE4083551 = 1 << (_id_DA611C632FE7481B & 3);

        if((_id_7D2C90FC7E0CD9C6 &_id_EC335DDDE4083551) != 0 && isDefined(_id_3A1245ED829BD1EC(_id_E4CC6D9942333B6F | _id_BDF522C561E36249 | _id_EC335DDDE4083551))) {
          if(randomfloat(1.0) > _id_B5DA9A414147800C(_id_EC335DDDE4083551) * modifiers)
            _id_BDF522C561E36249 = _id_BDF522C561E36249 | _id_EC335DDDE4083551;
        }
      }
    } else {
      while(_id_7D2C90FC7E0CD9C6 > 0) {
        _id_EC335DDDE4083551 = _id_7D2C90FC7E0CD9C6 & 0 - _id_7D2C90FC7E0CD9C6;

        if(randomfloat(1.0) > _id_B5DA9A414147800C(_id_EC335DDDE4083551) * modifiers)
          _id_BDF522C561E36249 = _id_BDF522C561E36249 | _id_EC335DDDE4083551;

        _id_7D2C90FC7E0CD9C6 = _id_7D2C90FC7E0CD9C6 - _id_EC335DDDE4083551;
      }
    }
  } else if(_id_A82E5D1900969E3C >= 1 || isDefined(_id_3A1245ED829BD1EC(_id_E4CC6D9942333B6F | _id_7D2C90FC7E0CD9C6))) {
    _id_302E82DA1A1989AD = _id_B5DA9A414147800C(_id_7D2C90FC7E0CD9C6) * modifiers;
    random = randomfloat(1.0);

    if(random > _id_302E82DA1A1989AD)
      _id_BDF522C561E36249 = _id_7D2C90FC7E0CD9C6;
  }

  return _id_BDF522C561E36249;
}

_id_3A1245ED829BD1EC(_id_5B8EC446F61E3F70) {
  switch (_id_5B8EC446F61E3F70) {
    case 1:
      return "zombie_missing_right_arm_animclass";
    case 2:
      return "zombie_missing_left_arm_animclass";
    case 4:
      return "zombie_missing_right_leg_animclass";
    case 8:
      return "zombie_missing_left_leg_animclass";
    case 12:
      return "zombie_crawl_animclass";
    case 0:
      return "zombie_asm_animclass";
    default:
      return undefined;
  }
}

_id_B5DA9A414147800C(_id_63C6FF09C7EE7518) {
  if(isDefined(level._id_539FF6BCF08FA004))
    return self[[level._id_539FF6BCF08FA004]](_id_63C6FF09C7EE7518);

  switch (_id_63C6FF09C7EE7518) {
    case 1:
      return 0.45;
    case 2:
      return 0.45;
    case 4:
      return 0.5;
    case 8:
      return 0.5;
    case 16:
      if(isDefined(self.hashelmet))
        return 1;

      return 0.65;
    default:
      return 1;
  }
}

_id_C10CBCAC37301028(_id_D237BB187B07B9EB, weaponname, _id_A82E5D1900969E3C, _id_A52F740328ED97BB, smeansofdeath) {
  _id_A9918B3A8D740F6B = 0;
  _id_7D6DBD1D06DE3FFC = 0;

  if(isDefined(weaponname))
    _id_7D6DBD1D06DE3FFC = istrue(level._id_CE05120D0652E369[weaponname]);

  if(_id_D237BB187B07B9EB != self._id_E4CC6D9942333B6F) {
    if(self._id_E4CC6D9942333B6F & 1)
      _id_D237BB187B07B9EB = _id_D237BB187B07B9EB &~2;

    if(self._id_E4CC6D9942333B6F & 2)
      _id_D237BB187B07B9EB = _id_D237BB187B07B9EB &~1;

    if(_id_D237BB187B07B9EB & 3) {
      if(scripts\engine\utility::cointoss())
        _id_D237BB187B07B9EB = _id_D237BB187B07B9EB &~1;
      else
        _id_D237BB187B07B9EB = _id_D237BB187B07B9EB &~2;
    }

    if(!_id_D237BB187B07B9EB)
      return _id_A9918B3A8D740F6B;

    _id_37079BF5940FBB9B = ~self._id_E4CC6D9942333B6F &_id_D237BB187B07B9EB;
    self._id_E4CC6D9942333B6F = _id_D237BB187B07B9EB;
    _id_FAE8053D4BC647DE = self.spawntime < gettime();

    if(_id_CC7887191916571D(_id_37079BF5940FBB9B) >= 3) {
      if(_id_FAE8053D4BC647DE)
        self._id_D3C566926B77AC94 = _id_37079BF5940FBB9B;

      _id_FAE8053D4BC647DE = 0;
      self.full_gib = 1;
      self.nocorpse = 1;
      self._id_AD9276C342EDD6FC = "mutilate";
    }

    if((_id_37079BF5940FBB9B & 1) != 0)
      _id_06A19056713CD83E(1);

    if((_id_37079BF5940FBB9B & 2) != 0)
      _id_06A19056713CD83E(2);

    if((_id_37079BF5940FBB9B & 4) != 0) {
      if(self._id_E4CC6D9942333B6F & 8)
        _id_06A19056713CD83E(12);
      else
        _id_06A19056713CD83E(4);
    }

    if((_id_37079BF5940FBB9B & 8) != 0) {
      if(self._id_E4CC6D9942333B6F & 4)
        _id_06A19056713CD83E(12);
      else
        _id_06A19056713CD83E(8);
    }

    if((_id_37079BF5940FBB9B & 16) != 0)
      _id_06A19056713CD83E(16);

    _id_BBABF5BCD6B3DC10 = _id_3A1245ED829BD1EC(_id_D237BB187B07B9EB);

    if(isDefined(_id_BBABF5BCD6B3DC10)) {
      if(self.dismember_crawl)
        _id_FAE8053D4BC647DE = 0;

      if(!self.dismember_crawl && (_id_D237BB187B07B9EB & 12) != 0)
        thread _id_87B62BBB66394F7E();

      if(_id_FAE8053D4BC647DE) {
        if(_id_A82E5D1900969E3C < 1)
          _id_6C1867C995FF7F69::_id_6BDD824A574AE2AB(_id_D237BB187B07B9EB, _id_7D6DBD1D06DE3FFC);
        else
          _id_A9918B3A8D740F6B = 1;
      }
    } else
      _id_A9918B3A8D740F6B = 1;

    if(_id_A9918B3A8D740F6B && _id_FAE8053D4BC647DE)
      self._id_D3C566926B77AC94 = _id_37079BF5940FBB9B;
  }

  return _id_A9918B3A8D740F6B;
}

_id_CC7887191916571D(_id_375A312EECEC7429) {
  for(_id_41DFA193D397A746 = 0; _id_375A312EECEC7429 > 0; _id_375A312EECEC7429 = _id_375A312EECEC7429 - (_id_375A312EECEC7429 & 0 - _id_375A312EECEC7429))
    _id_41DFA193D397A746++;

  return _id_41DFA193D397A746;
}

_id_06A19056713CD83E(_id_EE9F7F2B851CC905) {
  if(isDefined(level._id_183CC0DFC80FE670))
    [[level._id_183CC0DFC80FE670]](_id_EE9F7F2B851CC905);

  level notify("dismember", self, _id_EE9F7F2B851CC905);

  if(getdvarint("dvar_9AFD97D0E8B2BE09", 0) && !isdismembermentenabled()) {
    return;
  }
  switch (_id_EE9F7F2B851CC905) {
    case 1:
      _id_7F8A756ECD900AAE("torso", "right_arm_off");
      break;
    case 4:
      _id_7F8A756ECD900AAE("legs", "right_leg_off");
      break;
    case 2:
      _id_7F8A756ECD900AAE("torso", "left_arm_off");
      break;
    case 8:
      _id_7F8A756ECD900AAE("legs", "left_leg_off");
      break;
    case 12:
      current = self getscriptablepartstate("legs");

      if(current == "left_leg_off")
        _id_7F8A756ECD900AAE("legs", "both_legs_off_from_left_leg_off");
      else if(current == "right_leg_off")
        _id_7F8A756ECD900AAE("legs", "both_legs_off_from_right_leg_off");
      else if(current == "normal")
        _id_7F8A756ECD900AAE("legs", "both_legs_off_from_normal");

      break;
    case 3:
      break;
    case 16:
      current = self getscriptablepartstate("head");
      _id_A7A5E8D3B001ED7B = current + "_off";

      if(self getscriptableparthasstate("head", _id_A7A5E8D3B001ED7B))
        _id_7F8A756ECD900AAE("head", _id_A7A5E8D3B001ED7B);

      break;
  }
}

_id_7F8A756ECD900AAE(part, state) {
  self setscriptablepartstate(part, state, 1);

  if(!isDefined(self._id_9254444F4546E591))
    self._id_9254444F4546E591 = [];

  info = spawnStruct();
  info.time = gettime();
  info.part = part;
  info.state = state;
  self._id_9254444F4546E591[self._id_9254444F4546E591.size] = info;
}

_id_4EEAE0670F16191D(_id_F0C673F8DB6CBD80, smeansofdeath, sweapon) {
  if(isDefined(self.isfrozen)) {
    self.nocorpse = 1;
    self playSound("forge_freeze_shatter");
    self setscriptablepartstate("frozen", "unfrozen");
    playFX(level._effect["zombie_freeze_shatter"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(!isDefined(self.body) && !istrue(self.full_gib)) {
    return;
  }
  _id_E58E22B5BE4F0E82 = self._id_D3C566926B77AC94;

  if(!isDefined(_id_E58E22B5BE4F0E82) && !istrue(self.full_gib)) {
    return;
  }
  if(self.full_gib || _id_CC7887191916571D(_id_E58E22B5BE4F0E82) >= 3) {
    thread _id_82AD17C4F06A0E5D(_id_F0C673F8DB6CBD80);
    return;
  }
}

_id_82AD17C4F06A0E5D(_id_F0C673F8DB6CBD80) {
  _id_13F57E11D55F32D4 = 35;
  players = scripts\cp_mp\utility\player_utility::getdismembermentlist();

  if(players.size < _id_13F57E11D55F32D4) {
    fxent = spawn("script_model", self gettagorigin("j_mainroot"));
    fxent.angles = self.angles;
    fxent setModel("iw9_player_death_fx");
    fxent setscriptablepartstate("effects", "gib", 0);

    foreach(player in players)
    fxent hidefromplayer(player);

    wait 0.5;
    fxent delete();
  }
}