/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58223.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_AD331373AB6D56D7C9DE36B14BE6D9AF23B2C28ED0"] = loadfx("_encstr_929E3215460326182B29D73A038AEFD01C158F6B5B0741AC52AB478389DEE7527061EA924F410FF2C7632321A0C9F1C770B865D0");
  level.nuke_expl_struct = scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("_encstr_A7220E9613A0A77FB50213DACE17879A");
}

tryusenuke() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B8BA05F06B9785", self);
  return tryusenukefromstruct(var_0);
}

tryusenukefromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  if(var_0.streakname == "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637")
    var_1 = 1;
  else
    var_1 = 0;

  var_0.nuketype = var_1;
  var_2 = undefined;
  var_3 = undefined;

  if(!isDefined(level.nukeincoming)) {
    level.nukeincoming = 1;
    level._id_11F14 = self;
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8A412177C720C171A462552DDC4B5A086967D3D77F48B69989CFDEE6740E49D0C18B59");

    return 0;
  }

  if(var_1 == 1) {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, getcompleteweaponname("_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B", ["_encstr_A1AA0D2E01D783B0AD9B42E7080B22"]), "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", ::weapongivennuke, ::weaponswitchendednuke, ::weaponfirednuke);
    var_2 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);
    var_3 = 25;
    var_5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A15C0D845DEBD4A95C1AC0F93236A3"))
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A15C0D845DEBD4A95C1AC0F93236A3")]](var_0.owner.team);

    if(isDefined(var_5))
      level thread nuke_warnenemiesnukeincoming(var_5[0]);
  } else if(!istrue(level._id_11BD4))
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, undefined, undefined, undefined, undefined, "_encstr_A5E612978FB17E603D8DD3C9B916283ACAD76329", 0);
  else
    var_4 = 1;

  if(!istrue(var_4) || level.gameended) {
    level.nukeincoming = undefined;
    level._id_11F14 = undefined;
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      level.nukeincoming = undefined;
      level._id_11F14 = undefined;
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  thread nuke_start(var_0, 0, undefined, undefined, var_2, undefined, var_3);

  if(var_1 != 1 && !istrue(level._id_11BD4))
    scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_B8BA05F06B9785", self.origin);

  return 1;
}

weapongivennuke(var_0) {
  return 1;
}

weaponswitchendednuke(var_0, var_1) {
  if(istrue(var_1))
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var_0, "_encstr_9A8F11CDC1D816DC34EBA51BB7DCAF9BABD656");
}

weaponfirednuke(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);

  if(!isDefined(var_3)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88A31A942F6BE4DA0996F50737672E37C17BFE24BC3FE91B680FA831");

    return "_encstr_AFAC097640D8DC32A87307";
  }

  return "_encstr_88E30897BDF1B71F7823";
}

nuke_delaythread(var_0, var_1, var_2, var_3) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](var_0);
  }

  level thread[[var_1]](var_2, var_3);
}

nuke_start(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  level notify("_encstr_86010A2F605164F1D5B5CC47");
  self notify("_encstr_86010A2F605164F1D5B5CC47");
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E", 1);
  level.nukeinfo = spawnStruct();

  if(isPlayer(self))
    level.nukeinfo.player = self;

  level.nukeinfo.team = self.pers["_encstr_8AEF05472BC2D6"];
  level.nukevisionset = "_encstr_963E0F3B9EEBD8D65FF253D83903B73083";
  level.cancelmode = 0;
  level.nukegameover = undefined;
  level.nukedetonated = undefined;
  level.nukecancel = undefined;
  var_8 = 0;
  var_9 = self.origin + (0, 0, 30000) + anglesToForward(self.angles) * 30000;
  var_10 = self.origin + anglesToForward(self.angles) * 15000;

  if(isDefined(level.nuke_expl_struct)) {
    var_10 = level.nuke_expl_struct.origin;
    var_11 = vectorNormalize((var_10[0], var_10[1], 0) - (self.origin[0], self.origin[1], 0));
    var_9 = var_10 + var_11 * 15000;
    var_9 = var_9 + (0, 0, 30000) + var_11 * 5000;
  } else if(var_0.streakname != "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637") {}

  var_12 = 6;
  var_13 = 10;
  var_14 = 1;

  if(istrue(var_1)) {
    var_8 = var_1;

    if(istrue(var_8))
      level.cancelmode = 1;
  }

  if(isDefined(var_3))
    var_9 = var_3;

  if(isDefined(var_4))
    var_10 = var_4;

  if(istrue(var_5))
    var_12 = var_5;

  if(istrue(var_6))
    var_13 = var_6;

  if(istrue(var_2))
    var_14 = var_2;

  if(!isDefined(level.nuke_clockobject)) {
    level.nuke_clockobject = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_9 + (0, 0, 100));
    level.nuke_clockobject dontinterpolate();
    level.nuke_clockobject hide();
  } else
    level.nuke_clockobject.origin = var_9 + (0, 0, 100);

  level.nuke_inflictor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10 + (0, 0, 5000));
  level.nuke_inflictor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.nuke_inflictor.team = self.team;
  level.nuke_inflictor.owner = self;
  level.nuke_inflictor.streakinfo = var_0;

  if(istrue(level._id_11BD4))
    var_12 = 0.7;

  level thread nuke_startlaunchsequence(self, var_0, var_14, var_9, var_10, var_12, var_13, var_7);
  var_0.nukegoalpoint = var_10;
  var_15 = var_12 + var_13;

  if(isDefined(var_0.nuketype) && var_0.nuketype == 1)
    level thread nuke_delaythread(var_15, ::nuke_createradiationzone, self, var_0);

  level thread nuke_delaythread(var_15, ::nuke_slowmo, self, var_0);
  level thread nuke_delaythread(var_15, ::nuke_explosion, self, var_0);
  level thread nuke_delaythread(var_15, ::nuke_earthquake, self, var_0);
  level thread nuke_delaythread(var_15 + 0.075, ::nuke_vision, self, var_0);
  level thread nuke_delaythread(var_15 + 5, ::nuke_death, self, var_0);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_969018B09191A29558AD945837DA61A0A95DC6E8B4388DD2B24E"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_969018B09191A29558AD945837DA61A0A95DC6E8B4388DD2B24E")]](2, level.nukeinfo.team, "_encstr_B8BA05F06B9785");

  if(level.cancelmode && var_8)
    level thread nuke_watchownerdisconnect(level.nukeinfo.player);
}

nuke_watchownerdisconnect(var_0) {
  if(!isDefined(level._id_11EF8)) {
    createheadiconatorigin("_encstr_B8BA05F06B9785");
    level._id_11EF8 = 1;
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  _id_11EDE();
}

_id_11EDE() {
  level.nukecancel = 1;
  level.nukeincoming = undefined;
  level._id_11F14 = undefined;
  nuke_cleartimer();
  setslowmotion(1, 1, 0);
  level notify("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
}

nuke_starttimer(var_0) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");

  if(istrue(level._id_11BD4))
    _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 2);
  else
    _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);

  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  level thread nuke_updateuitimers(var_0);
  var_1 = var_0;
  var_2 = 0;

  for(var_3 = 0; var_1 > 0; var_1--) {
    if(var_1 <= 10) {
      level.nuke_clockobject playSound("_encstr_BE75132493BA2792D5BFF72797F06B5E8099DD2B28");

      if(isDefined(level.nuke_missile) && !istrue(var_2)) {
        level thread nuke_startmissileflightaudio();
        var_2 = 1;
      }
    }

    if(var_1 <= 4.9) {
      if(isDefined(level.nuke_missile) && !istrue(var_3)) {
        level.nuke_missile playsoundonmovingent("_encstr_ACC712D27707FAE6BAAD59F55ACDC67BB69673CE");
        var_3 = 1;
      }
    }

    wait 1.0;
  }
}

nuke_startmissileflightaudio() {
  level.nuke_missile endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.nuke_missile playLoopSound("_encstr_A60815FA83730FEDD057EDCF55C0F427F35B1132E8A0EB");
  wait 7.0;
  level.nuke_missile stoploopsound("_encstr_A60815FA83730FEDD057EDCF55C0F427F35B1132E8A0EB");
}

nuke_cleartimer() {
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
}

nuke_startlaunchsequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level thread nuke_startprelaunchalarm(var_5, var_1, var_0);

  if(isPlayer(var_0) && var_0 ispcplayer())
    var_0 setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 15);

  if(var_1.streakname != "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637") {
    var_8 = "_encstr_B40101";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
      var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

    var_9 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_97040DC7E1B00354B8593EFD30C8A3"))
      var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_97040DC7E1B00354B8593EFD30C8A3")]](var_8);

    if(isDefined(var_9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867915EEB52D987CB928C30CF92A443C9D43D3F34B6BB6"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867915EEB52D987CB928C30CF92A443C9D43D3F34B6BB6")]](var_9);
    }

    level.dontendonscore = 1;

    foreach(var_11 in level.players) {
      if(isDefined(var_11)) {
        var_11 notify("_encstr_B6730EE73AE71389B1DA381842565B08");
        var_11.cancelkillcam = 1;
      }
    }

    level thread _id_11EDC();
    level.loadoutdefaultfiresalediscount = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](var_5);

  playsoundatpos(var_3, "_encstr_85D415A14327A0B86B433B67E12BFF6BAE045765E5D60B");
  level thread nuke_launchmissile(var_0, var_1, var_3, var_4, var_6, var_7);
}

nuke_startprelaunchalarm(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_2))
    var_2 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_1.streakname, 1, 1);

  while(var_0 > 0) {
    if(isDefined(level.nuke_clockobject) && !istrue(var_3)) {
      level.nuke_clockobject playSound("_encstr_A9790FF37398A906FB2A0251DF117BF3F8");
      var_3 = 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](2);

    var_0 = var_0 - 2;
  }
}

nuke_launchmissile(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_6 = var_4;
  level thread nuke_starttimer(var_6);

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_86010A2F605164F1D5B5CC47", var_0);
  }

  var_7 = "_encstr_A29408E6D5D6CAAF5B1C";

  if(isDefined(var_5))
    var_7 = var_5;

  var_8 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_9 = (var_3 - 0.5 * var_8 * squared(var_4) - var_2) / var_4;
  level.nuke_missile = magicgrenademanual(var_7, var_2, var_9, var_4);
  level.nuke_missile setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_AB0703DBB9", 0);
}

nuke_findunobstructedfiringinfo(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_5 = -2000;
  var_6 = 2000;
  var_7 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));

  for(;;) {
    var_8 = var_0;
    var_9 = var_8 + (0, 0, 5000);

    if(scripts\engine\trace::ray_trace_passed(var_8, var_9, undefined, var_4)) {
      var_10 = (var_1 - 0.5 * var_7 * squared(var_2) - var_8) / var_2;
      var_3.sourcepos = var_8;
      var_3.goalpos = var_1;
      var_3.initvelocity = var_10;
      break;
    }

    var_8 = var_8 + anglestoright(self.angles) * randomintrange(var_5, var_6);
    var_5 = int(var_5 * 1.3);
    var_6 = int(var_6 * 1.3);
    waitframe();
  }

  return var_3;
}

nuke_explosion(var_0, var_1) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  nuke_cleartimer();
  level.nukedetonated = 1;
  level notify("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  level.nuke_explosionpos = level.nuke_missile.origin;
  level.nuke_missile setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_BA19049F4B2D", 0);
  level.nuke_missile delete();
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.nuke_explosionpos);
  var_2 setModel("_encstr_82380B17B369C80D1FFA4E3093");
  var_2 setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59"))
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59")]](50);

  thread nuke_startexplosionaudio(level.nuke_explosionpos);

  if(var_1.streakname != "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637") {
    foreach(var_4 in level.characters) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_889F081BC2CDADB48D8D")]](var_4, nuke_cankilleverything())) {
        if(isPlayer(var_4)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_4))
              var_4 thread nuke_startnukedeathfx();
          }
        }
      }
    }
  } else {
    foreach(var_4 in level.characters) {
      if(isPlayer(var_4) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_4))
        var_4 thread nuke_startnukedeathfx_chooselocationversion();
    }
  }
}

nuke_startexplosionaudio(var_0) {
  foreach(var_2 in level.players)
  var_2 setsoundsubmix("_encstr_9A0113E883515FA023F4269DC22FE907090A50504A", 6);

  playsoundatpos(var_0, "_encstr_AB2714E9C47A07ED9B3032A9189322B7492D5794503B");
  playsoundatpos(var_0, "_encstr_A7B41D5A23D3AF4D70378DAF2B70D6A79118A2228E463BC62821BF8FD3981F");
  playsoundatpos(var_0, "_encstr_88890F4B770EBECDAEADACF526632CE68E");
}

nuke_slowmo(var_0, var_1) {
  if(var_1.streakname == "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637") {
    return;
  }
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  setnuketimescalefactor();
  level waittill("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
  setslowmotion(1, 0.25, 0.1);
}

setnuketimescalefactor() {
  if(!isDefined(level._id_11EF8)) {
    createheadiconatorigin("_encstr_B8BA05F06B9785");
    level._id_11EF8 = 1;
  }
}

nuke_dof(var_0, var_1) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");

  foreach(var_3 in level.players)
  var_3 thread nuke_adjustexplosiondof();
}

nuke_adjustexplosiondof() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setphysicaldepthoffield(2.0, 1500);
}

nuke_vision(var_0, var_1) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  level.nukevisioninprogress = 1;
  visionsetnaked("_encstr_AC711298BB343B1E676CB03E7993C6F55D42F830", 0.05);
  setDvar("_encstr_87642439EBD60BE8B2934B85B190B1DEDBB6212A356C39A5E0D19AB06E47AC4E51372CC4D8AC", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](0.5);

  level notify("_encstr_884E1C587BF4FBDEBF267DFD2AD741919C6120C8F3CB5793C349066D151B");
  level thread nuke_fadeflashvision(1, 2);
  level waittill("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
  level thread nuke_updatevisiononhostmigration();
  level nuke_setaftermathvision(5);
}

nuke_fadeflashvision(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](var_0);

  visionsetnaked("_encstr_B40101", var_1);
}

nuke_death(var_0, var_1) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
  var_2 = level.nukeinfo.player;

  if(level.teambased)
    var_2 = level.nuke_inflictor.team;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_B2DB28CA47AFCB8FB3FF7B8669C2D0D039F08820C48B79D025BC3722FB8C5B64AB80C19405A53DB0CD10"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_B2DB28CA47AFCB8FB3FF7B8669C2D0D039F08820C48B79D025BC3722FB8C5B64AB80C19405A53DB0CD10")]]();

  var_3 = nuke_cankilleverything();

  if(isDefined(level.nukeinfo.player)) {
    if(var_1.streakname != "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637") {
      foreach(var_5 in level.characters) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_889F081BC2CDADB48D8D")]](var_5, var_3)) {
          if(isPlayer(var_5)) {
            var_5.nuked = 1;

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
              if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_5)) {
                if(!istrue(var_5._id_12E54)) {
                  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_AC9517EFE275C887082F7FA7B2E4886CD331031B9F0F42374B"))
                    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_AC9517EFE275C887082F7FA7B2E4886CD331031B9F0F42374B")]](var_5);
                }
              }
            }
          }
        }
      }

      if(istrue(var_3)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BA031591CA9B1DC9B75E82B1A3963B56F426A62BD81DE6"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BA031591CA9B1DC9B75E82B1A3963B56F426A62BD81DE6")]]();
      } else if(!istrue(level.blocknukekills)) {
        var_7 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC"))
          var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC")]](level.nuke_inflictor.team);

        foreach(var_9 in var_7) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BA031591CA9B1DC9B75E82B1A3963B56F426A62BD81DE6"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BA031591CA9B1DC9B75E82B1A3963B56F426A62BD81DE6")]](var_9);
        }
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_85BA18DA20B17DAFD36E35298A31BF85D928B2E6BA81354FE8DD", level.nukeinfo.player);
    } else {
      foreach(var_5 in level.characters) {
        var_12 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA"))
          var_12 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA")]](var_5, level.nuke_explosionpos, 25000000);

        if(var_12) {
          var_5.nuked = 1;

          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_5)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_88AF0BB8478C507912967B0D2A"))
              [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_88AF0BB8478C507912967B0D2A")]](var_5);
          }
        }
      }
    }

    if(!istrue(level._id_11BD4)) {
      if(isDefined(level.nukeinfo.player) && isDefined(var_1))
        level.nukeinfo.player scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_1);
    }
  }

  if(istrue(var_3)) {
    level.nukegameover = 1;
    level thread nuke_delayendgame(3, var_2);
  }
}

nuke_delayendgame(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _id_11EF1(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_A7D50D32ACC60B5E8A9BC8A358B659"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_A7D50D32ACC60B5E8A9BC8A358B659")]](var_0, var_1);
}

_id_11EF1(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  level notify("_encstr_B6AC0E1C8DB0F2FAE6BAAD95D7139BDA");
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 13);
}

nuke_earthquake(var_0, var_1) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");

  if(!isDefined(level.mapcenter))
    var_2 = var_1.nukegoalpoint;
  else
    var_2 = level.mapcenter;

  earthquake(0.4, 1.5, var_2, 100000);
  level thread nuke_playshockwaveearthquake(var_1);
  level waittill("_encstr_BDD90B3ACBBFEA87EC98F94B6C");

  if(var_1.streakname == "_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637")
    earthquake(0.3, 1, var_2, 100000);
  else
    earthquake(0.7, 3, var_2, 100000);

  foreach(var_4 in level.players)
  var_4 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
}

nuke_playshockwaveearthquake(var_0) {
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  level endon("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
  var_1 = 0.01;

  if(!isDefined(level.mapcenter))
    var_2 = var_0.nukegoalpoint;
  else
    var_2 = level.mapcenter;

  for(;;) {
    earthquake(var_1, 0.05, var_2, 100000);
    wait 0.05;
    var_1 = var_1 + 0.0015;

    if(var_1 >= 0.3)
      var_1 = 0.3;
  }
}

onplayerspawned() {
  if(isDefined(level.nukedetonated))
    thread nuke_setvisionforplayer(0, 0);
}

nuke_setvisionforplayer(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  self visionsetnakedforplayer("_encstr_841D16CDBAB559FAB336BD31B063F5C299E8569C5B0BE886", var_1);
}

nuke_updateuitimers(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_82420FF5B537AD019B51ED2F852409E7AF");
  level endon("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
  var_1 = var_0 * 1000 + gettime();
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", var_1);
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  var_2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_B2DB28CA47AFCB8FB3FF7B8669C2D0D039F08820C48B79D025BC3722FB8C5B64AB80C19405A53DB0CD10"))
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]]();

  if(var_2 > 0)
    setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", var_1 + var_2);
}

nuke_updatevisiononhostmigration() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
    level nuke_setaftermathvision(0);
  }
}

nuke_setaftermathvision(var_0) {
  var_2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BE821247C860E55251B8FB74054B2ABC0DF8B787"))
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BE821247C860E55251B8FB74054B2ABC0DF8B787")]]();

  if(!var_2) {
    return;
  }
  if(isDefined(level.nukedeathvisionfunc))
    level thread[[level.nukedeathvisionfunc]]();

  _id_11EF4();
}

_id_11EF4() {
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 12);

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1);
    var_1 setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1);
    var_1 setclienttriggeraudiozonepartialwithfade("_encstr_9B2610521B022F69981BBCB407486A97BF70", 2, "_encstr_8D4708E790B3E4FA7D8B", "_encstr_AD9D0FE05F8AC82B3ACB607523E27513E3");
  }

  level thread _id_11EF2();
}

_id_11EF2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_B6AC0E1C8DB0F2FAE6BAAD95D7139BDA");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 0, 1);
  }
}

nuke_startnukedeathfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(self._id_12E54)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59")]](1, "_encstr_86630CCDAEAD597D2C1B8E5A9DAC");
  }

  thread nuke_playrollingdeathfx(3.25);
  level waittill("_encstr_BDD90B3ACBBFEA87EC98F94B6C");

  if(isDefined(self.burnfxenabled) && self.burnfxenabled > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9")]](1, "_encstr_86630CCDAEAD597D2C1B8E5A9DAC");
  }

  var_0 = 0;

  if(var_0)
    return;
}

nuke_startnukedeathfx_chooselocationversion() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59")]](1, "_encstr_86630CCDAEAD597D2C1B8E5A9DAC");

  thread nuke_playrollingdeathfx(3.25);
  level waittill("_encstr_BDD90B3ACBBFEA87EC98F94B6C");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9")]](1, "_encstr_86630CCDAEAD597D2C1B8E5A9DAC");
}

nuke_playrollingdeathfx(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A")]](var_0);

  if(!scripts\cp_mp\utility\player_utility::isusingremote())
    self visionsetnakedforplayer("_encstr_8E230FB9AE6D56F51995B01D4398C65DC9", 4);

  var_1 = self.origin;
  var_2 = level.nuke_explosionpos;
  var_3 = var_1;
  var_4 = "_encstr_AD331373AB6D56D7C9DE36B14BE6D9AF23B2C28ED0";
  playFX(scripts\engine\utility::getfx(var_4), var_1, var_2 - var_3, undefined, self);
}

nuke_atomizebody() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0[0][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
  var_0[0][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_813B0D4027B390B37585BBC819FD28");
  var_0[0][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83890D9CA8EF0B79D830939788913A");
  var_0[0][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83890D9CA8EF0B79D830939788913A");
  var_0[0][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_AADA07DBF19A4A81D7");
  var_0[0][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_AADA07DBF19A4A81D7");
  var_0[1][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_BD500A3C087F4AD519410B6F");
  var_0[1][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_BD500A3C087F4AD519410B6F");
  var_0[1][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_AC500A7A366A5BBFC04F9465");
  var_0[1][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_AC500A7A366A5BBFC04F9465");
  var_0[1][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A78B0B4D7DAC6398F6DDEB27A5");
  var_0[1][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A78B0B4D7DAC6398F6DDEB27A5");
  var_0[1][3]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_8D8B0B309FA99B7EFA735F68F1");
  var_0[1][3]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_8D8B0B309FA99B7EFA735F68F1");
  var_0[2][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A1D50BD4BE2CDC6D36B2EBC695");
  var_0[2][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A1D50BD4BE2CDC6D36B2EBC695");
  var_0[2][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83D50BE2875F1037FDBA096892");
  var_0[2][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83D50BE2875F1037FDBA096892");
  var_0[2][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A1190BD4FABB9396DC47EB8DAC");
  var_0[2][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A1190BD4FABB9396DC47EB8DAC");
  var_0[2][3]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83190BED4757A3B3B20C5E83E0");
  var_0[2][3]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83190BED4757A3B3B20C5E83E0");
  self.body hide();
  var_1 = self.body.origin;
  var_2 = level.nuke_inflictor.origin * (1, 1, 0);
  var_3 = var_1 * (1, 1, 0);
  var_4 = "_encstr_9A8112AA7B1B1160E9B18F4009724D8F1305D378";
  playFX(scripts\engine\utility::getfx(var_4), var_1, var_2 - var_3);
}

nuke_cankilleverything() {
  var_0 = 1;
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

  if(isDefined(var_1) && var_1 == "_encstr_B607038AAB")
    var_0 = 0;

  return var_0;
}

nuke_createradiationzone(var_0, var_1) {
  if(!scripts\common\utility::iscp()) {
    if(0) {
      wait 10;
      playFX(scripts\engine\utility::getfx("_encstr_926C1CBC1F033FB00DDF4099B33F88F3D95317E7E2292F3BC15B38403F5B"), (0, 0, 0));
      nuke_registerradzone((0, 0, 0));

      if(!isDefined(level.nukedangerzones))
        level.nukedangerzones = [];

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "_encstr_8E8405EA382B2A", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "_encstr_9A8507BA4040188D08", 4000);
    } else {
      var_1.sealevelorigin = (var_1.nukegoalpoint[0], var_1.nukegoalpoint[1], scripts\cp_mp\parachute::getc130sealevel());
      playFX(scripts\engine\utility::getfx("_encstr_926C1CBC1F033FB00DDF4099B33F88F3D95317E7E2292F3BC15B38403F5B"), var_1.sealevelorigin);
      nuke_registerradzone(var_1.sealevelorigin);

      if(!isDefined(level.nukedangerzones))
        level.nukedangerzones = [];

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "_encstr_8E8405EA382B2A", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "_encstr_9A8507BA4040188D08", 4000);
    }
  }

  thread nuke_finalizelocationnuke(var_0);
}

nuke_registerradzone(var_0) {
  if(!isDefined(level.radzones)) {
    level.radzones = [];
    level thread nuke_radzones_think();
  }

  level.radzones[level.radzones.size] = var_0;
}

nuke_removeradzone(var_0) {
  level.radzones = scripts\engine\utility::array_remove(level.radzones, var_0);
}

nuke_radzones_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 10;

  for(;;) {
    foreach(var_2 in level.players) {
      var_2.inradzone = 0;

      foreach(var_4 in level.radzones) {
        var_5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA"))
          var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA")]](var_2, var_4, 25000000);

        if(var_5) {
          if(istrue(var_2.gasmaskequipped))
            var_2 scripts\cp_mp\gasmask::processdamage(var_0);
          else {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820"))
              var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820")]]("_encstr_A6BA1751F1D009A10FB0EF92851DAC199361FC559FB9C79DE9", 2);

            var_2 dodamage(var_0, var_2.origin, var_2, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
          }

          var_2.inradzone = 1;
          break;
        }
      }

      if(var_2.inradzone) {
        continue;
      }
      foreach(var_4 in level.radzones) {
        var_5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA"))
          var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA")]](var_2, var_4, 36000000);

        if(var_5) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820"))
            var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820")]]("_encstr_8F0B1AA1C9054D7FF7A548C6B913249B33A0392191A30BD78B81F854", 2);

          break;
        }
      }
    }

    wait 1;
  }
}

nuke_warnenemiesnukeincoming(var_0) {
  level endon("_encstr_BDD90B3ACBBFEA87EC98F94B6C");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820"))
          var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820")]]("_encstr_A1F11F5382BCE455B4A8D7A9A2312A342AF51314AA930D21BE22542A8AD0515488", 2);
      }
    }

    wait 1;
  }
}

nuke_finalizelocationnuke(var_0) {
  wait 20;

  if(istrue(var_0.hasnukeselectks))
    var_0.hasnukeselectks = 0;

  if(isDefined(var_0.killcountthislife))
    var_0.killcountthislife = 0;

  visionsetnaked("_encstr_B40101", 1);
}

_id_11EDC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);

    if(isDefined(var_0)) {
      var_0 notify("_encstr_B6730EE73AE71389B1DA381842565B08");
      var_0.cancelkillcam = 1;
    }
  }
}