/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\entity.gsc
***********************************************/

getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size)
    return undefined;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

touchingbadtrigger() {
  var_0 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0) {
    if(self istouching(var_2))
      return 1;
  }

  var_4 = getEntArray("_encstr_BD3E0A4EC2325A85E82DEDB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_4) {
    if(self istouching(var_2))
      return 1;
  }

  return 0;
}

touchingoobtrigger() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level.outofboundstriggers))
    return 0;

  foreach(var_1 in level.outofboundstriggers) {
    if(self istouching(var_1))
      return 1;
  }

  return 0;
}

touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(var_1 in level.ballallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(var_1 in level.playerallowedtriggers) {
    if(self istouching(var_1)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

findisfacing(var_0, var_1, var_2) {
  var_3 = cos(var_2);
  var_4 = anglesToForward(var_0.angles);
  var_5 = var_1.origin - var_0.origin;
  var_4 = var_4 * (1, 1, 0);
  var_5 = var_5 * (1, 1, 0);
  var_5 = vectorNormalize(var_5);
  var_4 = vectorNormalize(var_4);
  var_6 = vectordot(var_5, var_4);

  if(var_6 >= var_3)
    return 1;
  else
    return 0;
}

isaiteamparticipant(var_0) {
  if(isagent(var_0) && var_0.agent_teamparticipant == 1)
    return 1;

  if(isbot(var_0))
    return 1;

  return 0;
}

isteamparticipant(var_0) {
  if(isaiteamparticipant(var_0))
    return 1;

  if(isPlayer(var_0))
    return 1;

  return 0;
}

isaigameparticipant(var_0) {
  if(isagent(var_0) && isDefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1)
    return 1;

  if(isbot(var_0))
    return 1;

  return 0;
}

isgameparticipant(var_0) {
  if(isaigameparticipant(var_0))
    return 1;

  if(isPlayer(var_0))
    return 1;

  return 0;
}

getteamindex(var_0) {
  var_1 = 0;

  if(level.teambased) {
    switch (var_0) {
      case "_encstr_8E8405EA382B2A":
        var_1 = 1;
        break;
      case "_encstr_9A8507BA4040188D08":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

isvalidteamtarget(var_0, var_1, var_2) {
  return isDefined(var_2.team) && var_2.team == var_1;
}

isvalidffatarget(var_0, var_1, var_2) {
  return isDefined(var_2.owner) && (!isDefined(var_0) || var_2.owner != var_0);
}

getlinknamenodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, "_encstr_974C0246");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(isDefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

getparticipantsinradius(var_0, var_1, var_2, var_3) {
  return getentitiesinradius(var_0, var_1, var_2, var_3, scripts\engine\trace::create_character_contents());
}

getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0)
    return [];

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3))
      var_5 = var_3;
    else
      var_5 = [var_3];
  }

  var_6 = physics_querypoint(var_0, var_1, var_4, var_5, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_7 = [];

  if(!isDefined(var_2)) {
    foreach(var_9 in var_6) {
      var_10 = var_9["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_10))
        var_7[var_7.size] = var_10;
    }
  } else {
    foreach(var_9 in var_6) {
      var_10 = var_9["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_10) && isDefined(var_10.team) && var_10.team == var_2)
        var_7[var_7.size] = var_10;
    }
  }

  return var_7;
}

watchentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B1A91727184D719F3DA05F41D03B08CFE02B49EE9850A0A377");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_5 = undefined;

    if(var_4)
      var_5 = scripts\cp\utility\player::getplayersinradius(self.origin, var_0);
    else
      var_5 = getentitiesinradius(self.origin, var_0);

    if(var_5.size > 0) {
      if(!var_3)
        self notify(var_1, var_5);
      else {
        var_6 = [];

        foreach(var_8 in var_5) {
          var_9 = self getorigin();
          var_10 = scripts\engine\utility::ter_op(var_4, var_8 getEye(), var_8.origin);
          var_11 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_AFFD1BA288905BEB3613178585909038D34B1E333CB6938680579B4975", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1"]);
          var_12 = physics_raycast(var_9, var_10, var_11, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

          if(var_12.size <= 0)
            var_6[var_6.size] = var_8;
        }

        self notify(var_1, var_6);
      }
    }

    wait(var_2);
  }
}

cancelentitiesinradius() {
  self notify("_encstr_B1A91727184D719F3DA05F41D03B08CFE02B49EE9850A0A377");
}

placeequipmentfailed(var_0, var_1, var_2, var_3) {
  self playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isDefined(var_3))
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
    else
      var_4 = spawnfxforclient(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), var_2, self);

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
  }

  switch (var_0) {
    case "_encstr_84661447C3CBFCDDDB636EC17A098B7753F83A0F1859":
    case "_encstr_AA830D5B0B32A731FF4BE57F38FD73":
    case "_encstr_99D710CDFCDE401566F4DBCA1B9A7D97C8F8":
    case "_encstr_A14A0DD37BFF6FA915219DF36F7D98":
    case "_encstr_92EA0A290B32FF88A90170EB":
      if(isPlayer(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
        self iprintlnbold("_encstr_977C1158DAE646CAADBF70C031DDA77B13BA50");
        return;
      }
  }
}

placeequipmentfailedinit() {
  level._effect["_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"] = loadfx("_encstr_8843337DF690F2335F0F908643CFF7E86F5BF1EFD7BD502873F2728E3AA720D042A9673F0562B043137A299073776D709A76C535B0");
}

placeequipmentfailedcleanup(var_0) {
  wait 2;
  var_0 delete();
}

isspidergrenade(var_0) {
  return istrue(var_0.isspidergrenade);
}

issupertrophy(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level.supertrophy))
    return 0;

  if(!isDefined(level.supertrophy.trophies))
    return 0;

  if(!isDefined(level.supertrophy.trophies[var_1]))
    return 0;

  return level.supertrophy.trophies[var_1] == var_0;
}

ismicroturret(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level.microturrets))
    return 0;

  if(!isDefined(level.microturrets[var_1]))
    return 0;

  return level.microturrets[var_1] == var_0;
}

ischoppergunner(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";
  return var_1;
}

tutorial_jumpfromplane(var_0) {
  if(!isDefined(var_0.vehicletype))
    return 0;

  var_1 = var_0.vehicletype == "_encstr_88CD07337F8B2B8083";
  return var_1;
}

issupporthelo(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3";
  return var_1;
}

isclusterstrike(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  return var_1;
}

isuav(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  if(var_0.streakinfo.streakname == "_encstr_851904B59B34" || var_0.streakinfo.streakname == "_encstr_8C9D0C506F0B96A8F78B297BF313" || var_0.streakinfo.streakname == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
    return 1;

  return 0;
}

isgunship(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_86FD08B775CD07DC1338";
  return var_1;
}

isradardrone(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11" || var_0.streakinfo.streakname == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
  return var_1;
}

isscramblerdrone(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD";
  return var_1;
}

isradarhelicopter(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60";
  return var_1;
}

isturret(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E";
}

isdronepackage(var_0) {
  return isDefined(var_0.cratetype);
}

_enableequipdeployvfx() {
  if(!isDefined(self.enabledequipdeployvfx))
    self.enabledequipdeployvfx = 0;

  if(self.enabledequipdeployvfx == 0)
    self enableequipdeployvfx(1);

  self.enabledequipdeployvfx++;
}

_disableequipdeployvfx() {
  if(self.enabledequipdeployvfx == 1)
    self enableequipdeployvfx(0);

  self.enabledequipdeployvfx--;
}

register_physics_collisions() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4A311D88B980FC8731413C30F96A87BD84283");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("_encstr_83EB08F3E1931B7B5091", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

global_physics_sound_monitor() {
  level notify("_encstr_A7A0102B9399A31AD91FC1204DA56041386A");
  level endon("_encstr_A7A0102B9399A31AD91FC1204DA56041386A");

  for(;;) {
    level waittill("_encstr_83EB08F3E1931B7B5091", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0.phys_sound_func))
      level thread[[var_0.phys_sound_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

register_physics_collision_func(var_0, var_1) {
  var_0.phys_sound_func = var_1;
}

istouchingboundstrigger(var_0) {
  return istrue(var_0.alreadytouchingtrigger);
}

istouchingboundsnullify(var_0) {
  var_1 = 0;

  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(var_3 in level.outofboundstriggerpatches) {
      if(var_0 istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

deleteonplayerdeathdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self delete();
}

deleteatframeend() {
  self endon("_encstr_AD75063D571AE108");
  waittillframeend;
  self delete();
}