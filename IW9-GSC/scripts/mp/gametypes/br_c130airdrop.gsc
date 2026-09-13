/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_c130airdrop.gsc
***************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", ::c130airdrop_oncrateuse);
  level.c130deliveriesinprogress = [];
  level.c130successfulairdrops = [];
  level.c130airdrop_heightoverride = getdvarint("dvar_5697CE5DB08F0E93", 12000);
}

c130airdrop_managedrop() {
  level endon("game_ended");
  _id_F49A0A20D47E1DC0 = 1;
  level waittill("br_prematchEnded");

  for(;;) {
    _id_F798734F97421714 = getdvarint("dvar_301A0076AA763558", 1);

    if(!_id_F798734F97421714) {
      waitframe();
      continue;
    }

    _id_B63480E487F34E3A = getdvarint("dvar_7B5F99D862E0FD13", 3);
    _id_2B458B39BBF6BB8B = getdvarint("dvar_A811B4C67A77CE31", 12);
    _id_F013E3FC1F370CA7 = getdvarint("dvar_61CD7F929E3A8D6C", 240);
    _id_3FB775A12C864C31 = getdvarint("dvar_61A98D929E12317E", 360);
    _id_B1D5325407F562DD = randomintrange(_id_F013E3FC1F370CA7, _id_3FB775A12C864C31);

    if(istrue(_id_F49A0A20D47E1DC0))
      scripts\mp\flags::gameflagwait("activate_cash_drops");
    else
      wait(_id_B1D5325407F562DD);

    if(isDefined(level.br_level))
      level.br_level.c130_speedoverride = 3044;

    _id_334267DB87355776 = level.c130successfulairdrops.size;

    if(_id_334267DB87355776 < _id_2B458B39BBF6BB8B) {
      _id_A027D7566FC885A9 = getdvarint("dvar_42F7332F1E9035B3", 3);
      _id_26C6514C64F95ECF = _id_2B458B39BBF6BB8B - _id_334267DB87355776;

      if(!istrue(_id_F49A0A20D47E1DC0))
        _id_B63480E487F34E3A = 1;

      _id_4528266CD203C948 = min(_id_B63480E487F34E3A, ceil(_id_26C6514C64F95ECF / _id_A027D7566FC885A9));
      _id_734798C9F67545DF = _id_26C6514C64F95ECF;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4528266CD203C948; _id_AC0E594AC96AA3A8++) {
        _id_5EE94AE126526F2F = min(_id_A027D7566FC885A9, _id_734798C9F67545DF);
        _id_734798C9F67545DF = _id_734798C9F67545DF - _id_5EE94AE126526F2F;
        pathstruct = c130airdrop_createpath(_id_AC0E594AC96AA3A8);
        dist = distance(pathstruct.startpt, pathstruct.endpt);
        travelspeed = _id_45B2B4A889E633FA::getc130speed();
        time = dist / travelspeed;
        _id_184D0A0CE31A2B27 = c130airdrop_spawn(pathstruct, dist, travelspeed, time);

        if(_id_AC0E594AC96AA3A8 == 0)
          scripts\mp\hud_util::showsplashtoall("br_c130airdrop_incoming");

        _id_184D0A0CE31A2B27 c130airdrop_startdelivery(_id_5EE94AE126526F2F);

        if(istrue(level.usemilestonephases))
          wait(randomintrange(4, 8));
      }

      if(istrue(_id_F49A0A20D47E1DC0))
        _id_F49A0A20D47E1DC0 = 0;
    }
  }
}

c130airdrop_createpath(_id_D6A24DD68967019E, _id_ADCB4E55DEB23E76, _id_60E425CB62AE9E62) {
  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize))
    pathstruct = c130airdrop_createpathstruct(_id_D6A24DD68967019E, _id_ADCB4E55DEB23E76, _id_60E425CB62AE9E62);
  else
    pathstruct = _id_45B2B4A889E633FA::spawnc130pathstruct(_id_ADCB4E55DEB23E76);

  return pathstruct;
}

c130airdrop_createpathstruct(_id_D6A24DD68967019E, _id_ADCB4E55DEB23E76, _id_60E425CB62AE9E62) {
  pathstruct = undefined;
  centerpt = level.br_level.br_mapcenter;

  if(isDefined(_id_ADCB4E55DEB23E76))
    centerpt = _id_ADCB4E55DEB23E76;

  _id_F434D604C09196AA = _id_45B2B4A889E633FA::getplanepathsaferadiusfromcenter();
  _id_FDA870B32AB92C1F = (0, randomfloat(360), 0);

  if(!isDefined(_id_D6A24DD68967019E) || _id_D6A24DD68967019E == 0) {
    if(!istrue(_id_60E425CB62AE9E62)) {
      _id_0B36772CA73E9A3D = c130airdrop_getvalidteaminlastplace();
      _id_C27ADD4C8461843D = c130airdrop_getteamaveragepos(_id_0B36772CA73E9A3D);
      _id_FDA870B32AB92C1F = vectortoangles(centerpt - _id_C27ADD4C8461843D * (1, 1, 0));
      level.c130deliverydirection = _id_FDA870B32AB92C1F;
    }
  } else {
    if(isDefined(level.c130deliverydirection)) {
      _id_FDA870B32AB92C1F = level.c130deliverydirection;
      _id_587FDCE5C24BDF3E = 1;

      if(_id_D6A24DD68967019E == 2)
        _id_587FDCE5C24BDF3E = -1;

      _id_F36436FA7801BB1C = anglestoright(_id_FDA870B32AB92C1F) * (_id_F434D604C09196AA * _id_587FDCE5C24BDF3E);
      _id_E2BB8BE14A3105F3 = randomint(2);
      _id_6768A915ED3C9351 = randomfloat(360);
      _id_FDA870B32AB92C1F = (0, _id_6768A915ED3C9351, 0);
      _id_FDA870B32AB92C1F = scripts\engine\utility::ter_op(_id_E2BB8BE14A3105F3, _id_FDA870B32AB92C1F, _id_FDA870B32AB92C1F + (0, 180, 0));
    } else {
      _id_6768A915ED3C9351 = randomfloat(360);
      _id_F36436FA7801BB1C = anglesToForward((0, _id_6768A915ED3C9351, 0));
      _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * (_id_F434D604C09196AA * randomfloatrange(-1, 1));
    }

    centerpt = centerpt + _id_F36436FA7801BB1C;
  }

  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130airdropheight();
  pathstruct = _id_45B2B4A889E633FA::spawnc130pathstructnewinternal(centerpt, _id_FDA870B32AB92C1F, _id_FDFE2D4AAF8EC33D);
  return pathstruct;
}

c130airdrop_getvalidteaminlastplace() {
  _id_CF4BBE562EA35EAA = undefined;
  _id_1EFEADCAEB3737BC = scripts\mp\gamescore::getteamscoreplacements();
  _id_176A993B8D63593A = [];

  foreach(_id_E275B8E011923428 in level.teamnamelist) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_E275B8E011923428, "players");

    if(_id_A6AB8D0FDA441DC2.size > 0) {
      _id_10838A721B202259 = 0;

      foreach(player in _id_A6AB8D0FDA441DC2) {
        if(!isDefined(player)) {
          continue;
        }
        if(scripts\mp\utility\player::isreallyalive(player)) {
          _id_10838A721B202259 = 1;
          break;
        }
      }

      if(!istrue(_id_10838A721B202259)) {
        continue;
      }
      _id_D27A4D6C71FD80D6 = _id_1EFEADCAEB3737BC[_id_E275B8E011923428];

      if(!isDefined(_id_CF4BBE562EA35EAA) || _id_D27A4D6C71FD80D6 >= _id_CF4BBE562EA35EAA) {
        _id_CF4BBE562EA35EAA = _id_D27A4D6C71FD80D6;
        _id_3EDA0EF65C9478AC = _id_176A993B8D63593A.size;
        _id_176A993B8D63593A[_id_3EDA0EF65C9478AC] = spawnStruct();
        _id_176A993B8D63593A[_id_3EDA0EF65C9478AC].team = _id_E275B8E011923428;
        _id_176A993B8D63593A[_id_3EDA0EF65C9478AC].players = _id_A6AB8D0FDA441DC2;
      }
    }
  }

  if(_id_176A993B8D63593A.size > 0) {
    _id_3EDA0EF65C9478AC = 0;

    if(_id_176A993B8D63593A.size > 1)
      _id_3EDA0EF65C9478AC = randomint(_id_176A993B8D63593A.size);

    return _id_176A993B8D63593A[_id_3EDA0EF65C9478AC];
  }

  return;
}

c130airdrop_getteamaveragepos(_id_0B36772CA73E9A3D) {
  if(!isDefined(_id_0B36772CA73E9A3D.players))
    return (randomfloatrange(-1000, 1000), 0, 0);

  _id_05E57C125BA3E9B8 = (0, 0, 0);
  _id_82316DC9ED0020F7 = 3000;
  _id_B5B5E50F6EF69AAE = 1;

  foreach(player in _id_0B36772CA73E9A3D.players) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    _id_05E57C125BA3E9B8 = player.origin;

    foreach(_id_6EE5484560EC747C in _id_0B36772CA73E9A3D.players) {
      if(_id_6EE5484560EC747C == player) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(_id_6EE5484560EC747C)) {
        continue;
      }
      if(distance2dsquared(player.origin, _id_6EE5484560EC747C.origin) <= _id_82316DC9ED0020F7 * _id_82316DC9ED0020F7) {
        _id_B5B5E50F6EF69AAE++;
        _id_05E57C125BA3E9B8 = _id_05E57C125BA3E9B8 + _id_6EE5484560EC747C.origin;
        break;
      }
    }

    if(_id_B5B5E50F6EF69AAE >= 2) {
      break;
    }
  }

  _id_2F432D8C975DECC6 = _id_05E57C125BA3E9B8 / _id_B5B5E50F6EF69AAE;
  return _id_2F432D8C975DECC6;
}

c130airdrop_spawn(_id_41C8BB9AFB483172, pathdist, _id_F0192932004DCE8D, _id_5B16491505732B2B) {
  _id_03EF9B41093F5752 = spawn("script_model", _id_41C8BB9AFB483172.startpt);
  _id_03EF9B41093F5752 setModel("veh8_mil_air_acharlie130_magma_animated");
  _id_03EF9B41093F5752 setCanDamage(0);
  _id_03EF9B41093F5752.maxhealth = 100000;
  _id_03EF9B41093F5752.health = _id_03EF9B41093F5752.maxhealth;
  _id_03EF9B41093F5752.startpt = _id_41C8BB9AFB483172.startpt;
  _id_03EF9B41093F5752.endpt = _id_41C8BB9AFB483172.endpt;
  _id_03EF9B41093F5752.centerpt = _id_41C8BB9AFB483172.centerpt;
  _id_03EF9B41093F5752.dir = vectorNormalize(_id_03EF9B41093F5752.endpt - _id_03EF9B41093F5752.startpt);
  _id_03EF9B41093F5752.angles = vectortoangles(_id_03EF9B41093F5752.dir);
  _id_03EF9B41093F5752.pathdist = pathdist;
  _id_03EF9B41093F5752.speed = _id_F0192932004DCE8D;
  _id_03EF9B41093F5752.lifetime = _id_5B16491505732B2B;
  _id_03EF9B41093F5752.chassis = spawn("script_model", _id_03EF9B41093F5752.startpt);
  _id_03EF9B41093F5752.chassis setModel("veh8_mil_air_acharlie130_magma_rigid");
  _id_03EF9B41093F5752.chassis linkTo(_id_03EF9B41093F5752, "", (0, 0, 0), (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = _id_03EF9B41093F5752[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", undefined, undefined, 1, 1);
    _id_03EF9B41093F5752.minimapid = minimapid;
  }

  level.c130deliveriesinprogress[level.c130deliveriesinprogress.size] = _id_03EF9B41093F5752;
  return _id_03EF9B41093F5752;
}

c130airdrop_startdelivery(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  self setscriptablepartstate("audio_lp_dmz", "on", 0);
  self moveTo(self.endpt, self.lifetime);
  thread c130airdrop_deleteatlifetime();
  thread c130airdrop_dropcrates(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle);
}

c130airdrop_deleteatlifetime() {
  self endon("death");
  level endon("game_ended");
  wait(self.lifetime - 1);
  _id_B23A5BA733C5935D = spawn("script_model", self.origin);
  _id_B23A5BA733C5935D setModel("veh8_mil_air_acharlie130_magma_scriptable");
  _id_B23A5BA733C5935D setscriptablepartstate("audio_exit_dmz", "on", 0);
  _id_B23A5BA733C5935D thread scripts\mp\utility\script::delayentdelete(10);
  wait 1;
  level.c130deliveriesinprogress = scripts\engine\utility::array_remove(level.c130deliveriesinprogress, self);
  self setscriptablepartstate("audio_lp_dmz", "off", 0);

  if(isDefined(self.minimapid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);

  if(isDefined(self.chassis))
    self.chassis delete();

  if(isDefined(self))
    self delete();
}

c130airdrop_dropcrates(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  self endon("death");

  if(isDefined(self.dropfunc))
    self[[self.dropfunc]](_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle);
  else {
    _id_BD693DCF6BECE704 = self.lifetime;
    _id_11F20C6978F7D6A6 = _id_BD693DCF6BECE704 * 0.4;
    _id_4FD47BD923217DE1 = _id_BD693DCF6BECE704 - _id_11F20C6978F7D6A6;
    _id_BE2EEA72DFA2C196 = _id_11F20C6978F7D6A6 / 2;
    cratedroptime = _id_4FD47BD923217DE1 / max(1, _id_5EE94AE126526F2F - 1);
    _id_4E2DC12FC7BD831E = 1;
    _id_71CAC1D48AB1C488 = 0;
    _id_800DF1B7C6E3AA60 = _id_BE2EEA72DFA2C196;
    numcrates = 0;

    while(numcrates < _id_5EE94AE126526F2F) {
      if(!istrue(_id_4E2DC12FC7BD831E))
        _id_800DF1B7C6E3AA60 = cratedroptime;

      if(istrue(_id_71CAC1D48AB1C488)) {
        _id_800DF1B7C6E3AA60 = cratedroptime / 3;
        _id_71CAC1D48AB1C488 = 0;
      }

      wait(_id_800DF1B7C6E3AA60);

      if(istrue(_id_4E2DC12FC7BD831E))
        _id_4E2DC12FC7BD831E = 0;

      _id_76A22C18960F72AF = c130airdrop_findvaliddroplocation(self.origin + anglesToForward(self.angles) * 500);

      if(!isDefined(_id_76A22C18960F72AF)) {
        _id_71CAC1D48AB1C488 = 1;
        continue;
      }

      crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(_id_76A22C18960F72AF + (0, 0, level.c130airdrop_heightoverride - 100), _id_76A22C18960F72AF, self.angles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4);

      if(!isDefined(crate)) {
        _id_71CAC1D48AB1C488 = 1;
        continue;
      }

      numcrates++;
      _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
      _id_EF5D5141FDB51174.usetimeoverride = 5;
      level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    }
  }
}

c130airdrop_findvaliddroplocation(_id_22C4300CE1D248E8, _id_5CE47DE2B275EEC8, _id_D637E30565BE7341) {
  _id_76A22C18960F72AF = undefined;
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 - (0, 0, 20000);
  ignorelist = [self, self.chassis];
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignorelist, contents);

  if(isDefined(trace) && trace["hittype"] != "hittype_none")
    _id_76A22C18960F72AF = trace["position"];

  if(isDefined(_id_76A22C18960F72AF) && !istrue(_id_5CE47DE2B275EEC8)) {
    _id_5F1F32386B2BA829 = _id_45B2B4A889E633FA::ispointinbounds(_id_76A22C18960F72AF) && (istrue(_id_D637E30565BE7341) || !c130airdrop_isnearotherdrop(_id_76A22C18960F72AF));

    if(!istrue(_id_5F1F32386B2BA829))
      _id_76A22C18960F72AF = undefined;
  }

  return _id_76A22C18960F72AF;
}

c130airdrop_isnearotherdrop(_id_76A22C18960F72AF) {
  _id_F6EA6DC7B7E56191 = 0;
  _id_FE9FA47FA7FA928B = level.c130successfulairdrops;
  _id_491F9F618AD350F6 = getdvarint("dvar_D313F3ED75DBFF0F", 10000);
  _id_16FAC8F9233A1ACA = _id_491F9F618AD350F6 * _id_491F9F618AD350F6;

  foreach(_id_920F4173513EB6B8 in _id_FE9FA47FA7FA928B) {
    if(distance2dsquared(_id_76A22C18960F72AF, _id_920F4173513EB6B8.origin) < _id_16FAC8F9233A1ACA) {
      _id_F6EA6DC7B7E56191 = 1;
      break;
    }
  }

  return _id_F6EA6DC7B7E56191;
}

c130airdrop_oncrateuse(player) {
  _id_6B5E1783915835C1 = getDvar("dvar_C6F562BBCB26F231", "mp/loot_set_airdrop_contents_dmz.csv");
  self.itemsdropped = 0;
  _id_E05413A53B5D9167 = [];
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "killstreak", _id_6B5E1783915835C1);
    _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  }

  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 4, 1, "weapon", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "health", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && getdvarint("dvar_506A78BC5717F8F4", 0) == 1) {
    _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "tablet", _id_6B5E1783915835C1);
    _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  }

  _id_3EBBDC9F30B63842 = randomint(3);

  if(_id_3EBBDC9F30B63842 == 2) {
    _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "revive", _id_6B5E1783915835C1);
    _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  }

  _id_29E0256E5DD397A3 = 750;

  if(isDefined(level.airdropbasecashamount))
    _id_29E0256E5DD397A3 = level.airdropbasecashamount;

  if(istrue(level.bmoovertime))
    _id_29E0256E5DD397A3 = int(_id_29E0256E5DD397A3 * level.overtimecashmultiplier);

  _id_1361F1A11BA15C7E = _id_6AFF3948CF4CCA03::dropplunderbyrarity(_id_29E0256E5DD397A3, dropstruct);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);

  foreach(ent in _id_E05413A53B5D9167)
  ent.lootsource = "c130_box";

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D9180CA5C5DC7B88");
}