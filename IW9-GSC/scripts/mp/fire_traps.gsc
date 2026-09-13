/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\fire_traps.gsc
***********************************************/

init() {
  if(getdvarint("dvar_1CE0FCC1847735A7", 1) == 0) {
    return;
  }
  level._effect["vfx_cp_steampipe_exp_fire"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp_fire.vfx");

  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  level._id_D49FE7F07F2BA493 = spawnStruct();
  level._id_D49FE7F07F2BA493.traps = [];
  level._id_D49FE7F07F2BA493._id_325F9F15252B4928 = ::_id_7D27B7091E90DDFC;
  level._id_D49FE7F07F2BA493._id_6D132C4E0E061592 = 0;
  isactive = getdvarint("dvar_70609FE5B82BD193", 1);
  level._id_D49FE7F07F2BA493.traps["fireBarrel"] = spawnStruct();
  level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_BED6AB8862CF09D4 = ::_id_BE9B3BA9656F790B;
  level._id_D49FE7F07F2BA493.traps["fireBarrel"].isactive = isactive;
  level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_C499FB71BD364BFC = 0;
  isactive = getdvarint("dvar_2D32CEF4A90C84A4", 1);
  level._id_D49FE7F07F2BA493.traps["gasPuddle"] = spawnStruct();
  level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_BED6AB8862CF09D4 = ::_id_ABFA9FC534304BAC;
  level._id_D49FE7F07F2BA493.traps["gasPuddle"].isactive = isactive;
  level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_C499FB71BD364BFC = 10;
  level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_CFE6236F83F95D15 = getdvarint("dvar_3EA718DBF08FF7FE", 60);
  isactive = getdvarint("dvar_D02AF883782D0EB9", 1);
  level._id_D49FE7F07F2BA493.traps["gasLeak"] = spawnStruct();
  level._id_D49FE7F07F2BA493.traps["gasLeak"]._id_BED6AB8862CF09D4 = ::_id_835640D85F3EB9C7;
  level._id_D49FE7F07F2BA493.traps["gasLeak"].isactive = isactive;
  level thread _id_86E572A7A586FF11();
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_5413E583733D8000);
}

_id_86E572A7A586FF11() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  level._id_D49FE7F07F2BA493._id_4F41C2C01146B55D = [];
  _id_468EBE30CA565CE4("fireBarrel");
  _id_468EBE30CA565CE4("gasPuddle");
  _id_468EBE30CA565CE4("gasLeak");
  level._id_D49FE7F07F2BA493._id_6D132C4E0E061592 = 1;
}

_id_468EBE30CA565CE4(_id_175653EAFCD7B326) {
  _id_1642F84B31FAA340 = _id_5DEF7AF2A9F04234::_id_47D356083884F913();

  if(_id_1642F84B31FAA340)
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A(_id_175653EAFCD7B326);

  if(_id_B93F535898283956(_id_175653EAFCD7B326)) {
    level._id_D49FE7F07F2BA493._id_4F41C2C01146B55D[level._id_D49FE7F07F2BA493._id_4F41C2C01146B55D.size] = _id_175653EAFCD7B326;
    level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326]._id_7B4B9D51932CBC65 = [];
    _id_746250914E0AD719 = scripts\engine\utility::getStructArray(_id_175653EAFCD7B326, "script_noteworthy");

    foreach(struct in _id_746250914E0AD719) {
      if(isDefined(struct.targetname) && issubstr(struct.targetname, "auto")) {
        continue;
      }
      level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326]._id_7B4B9D51932CBC65[level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326]._id_7B4B9D51932CBC65.size] = struct;

      if(_id_1642F84B31FAA340) {
        if(!isDefined(struct._id_B205D90302DA2F07))
          struct._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(struct.origin, 1, 1);

        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(struct._id_B205D90302DA2F07, _id_175653EAFCD7B326, struct);
      }
    }
  }
}

_id_7D27B7091E90DDFC() {
  while(!level._id_D49FE7F07F2BA493._id_6D132C4E0E061592)
    waitframe();

  foreach(_id_175653EAFCD7B326 in level._id_D49FE7F07F2BA493._id_4F41C2C01146B55D) {
    foreach(node in level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326]._id_7B4B9D51932CBC65)
    thread[[level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326]._id_BED6AB8862CF09D4]](node);
  }
}

_id_B93F535898283956(_id_175653EAFCD7B326) {
  return level._id_D49FE7F07F2BA493.traps[_id_175653EAFCD7B326].isactive;
}

_id_BE9B3BA9656F790B(node) {
  if(getdvarint("dvar_1CE0FCC1847735A7", 1) == 0) {
    return;
  }
  if(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done"))
    wait(level._id_D49FE7F07F2BA493.traps["fireBarrel"]._id_C499FB71BD364BFC);

  scriptable = spawnscriptable("decor_barrels_gameplay_flammable_noent", node.origin, node.angles);
  level thread _id_A68FE4F7AB9386B4(scriptable);
  return scriptable;
}

_id_A68FE4F7AB9386B4(scriptable) {
  level endon("game_ended");
  exploded = 0;
  _id_35BBF066F50AC582 = 206;

  while(!exploded) {
    scriptablestate = scriptable getscriptablepartstate("base");

    if(!isDefined(scriptablestate)) {
      return;
    }
    if(scriptablestate == "death") {
      if(isDefined(scriptable._id_276AC5E84835EA87))
        scriptable._id_276AC5E84835EA87 notify("barrelExploded");

      exploded = 1;

      if(isDefined(scriptable.lastattacker))
        attacker = scriptable.lastattacker;
      else
        attacker = level._id_CBE618F35B332990;

      level._id_CBE618F35B332990 radiusdamage(scriptable.origin, _id_35BBF066F50AC582, 150, 50, attacker, "MOD_EXPLOSIVE", "molotov_mp");
    }

    waitframe();
  }
}

_id_5413E583733D8000(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(instance.type) && instance.type == "decor_barrels_gameplay_flammable_noent")
    instance.lastattacker = eattacker;
}

_id_ABFA9FC534304BAC(node) {
  if(getdvarint("dvar_1CE0FCC1847735A7", 1) == 0) {
    return;
  }
  if(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done"))
    wait(level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_C499FB71BD364BFC);

  scriptable = spawnscriptable("dmz_firetrap_gaspuddle", node.origin, node.angles + (0, 90, 0));
  scriptable.node = node;
  _id_910E34BF73FB306B = 75;
  _id_6FE256CEFDE49877 = undefined;

  if(isDefined(node._id_FB3592C9FF6761F2))
    _id_6FE256CEFDE49877 = node._id_FB3592C9FF6761F2 == "prelit";

  level thread _id_9B60ACD4B5AF2D71(scriptable, _id_910E34BF73FB306B, _id_6FE256CEFDE49877);
  return scriptable;
}

_id_9B60ACD4B5AF2D71(scriptable, radius, _id_6FE256CEFDE49877) {
  level endon("game_ended");
  burning = 0;

  while(!burning) {
    if(istrue(_id_6FE256CEFDE49877)) {
      waitframe();
      scriptable setscriptablepartstate("base", "death");
    }

    scriptablestate = scriptable getscriptablepartstate("base");

    if(scriptablestate == "death") {
      _id_A61C75B156FC1EE0 = radius * 0.7;
      navobstacle = createnavobstaclebybounds(scriptable.origin, (_id_A61C75B156FC1EE0, _id_A61C75B156FC1EE0, _id_A61C75B156FC1EE0), scriptable.angles);
      level thread _id_24AD6DB34ABE8024(scriptable, radius, _id_6FE256CEFDE49877, navobstacle);
      burning = 1;
    }

    waitframe();
  }
}

_id_24AD6DB34ABE8024(scriptable, radius, _id_6FE256CEFDE49877, navobstacle) {
  level endon("game_ended");
  _id_E0BA1A2E8FFB8E1E = 0;
  _id_BDA83843EF1DB7DF = 1;

  while(_id_BDA83843EF1DB7DF) {
    level._id_CBE618F35B332990 radiusdamage(scriptable.origin, radius, 5, 5, level._id_CBE618F35B332990, "MOD_FIRE", "molotov_mp", 0, 0);
    wait 1.0;

    if(!istrue(_id_6FE256CEFDE49877)) {
      _id_E0BA1A2E8FFB8E1E++;

      if(_id_E0BA1A2E8FFB8E1E >= level._id_D49FE7F07F2BA493.traps["gasPuddle"]._id_CFE6236F83F95D15)
        _id_BDA83843EF1DB7DF = 0;
    }
  }

  if(isDefined(navobstacle))
    destroynavobstacle(navobstacle);

  scriptable setscriptablepartstate("base", "off");
}

_id_835640D85F3EB9C7(node) {
  if(getdvarint("dvar_1CE0FCC1847735A7", 1) == 0) {
    return;
  }
  scriptable = spawnscriptable("dmz_firetrap_gasleak", node.origin, node.angles);
  scriptable.node = node;
  scriptable.state = "off";

  if(isDefined(node._id_B205D90302DA2F07) && node._id_B205D90302DA2F07 == "saba_S5Reveal") {
    if(!isDefined(level._id_247B22E11B648F93))
      level._id_247B22E11B648F93 = [];

    level._id_247B22E11B648F93[level._id_247B22E11B648F93.size] = scriptable;
  }

  return scriptable;
}

_id_53B4A8ACE69C59EA() {
  switch (self.state) {
    case "off":
      self.state = "small";
      self setscriptablepartstate("base", "small");
      return self;
    case "small":
      self.state = "heavy";
      self setscriptablepartstate("base", "heavy");
      return self;
    case "heavy":
      self.state = "damaging";
      self setscriptablepartstate("base", "damaging");
      thread _id_45B0EF5D9CEF9C8D();
      return self;
    case "damaging":
      return self;
  }
}

_id_7FDB264C9E19B7B8() {
  if(self.state == "damaging") {
    return;
  }
  self setscriptablepartstate("base", "damaging");
  thread _id_45B0EF5D9CEF9C8D();
}

_id_45B0EF5D9CEF9C8D() {
  level endon("game_ended");
  damageorigin = self.origin + rotatevector((0, 120, 0), self.angles);

  for(;;) {
    level._id_CBE618F35B332990 radiusdamage(damageorigin, 40, 4, 4, level._id_CBE618F35B332990, "MOD_FIRE", "molotov_mp", 0, 0);
    wait 0.2;
  }
}

_id_C6434D5C21B8F943() {
  wait 10;
  struct = spawnStruct();
  struct.origin = (974, 1932, 128);
  struct.angles = (0, 0, 0);
  _id_BE9B3BA9656F790B(struct);
  struct = spawnStruct();
  struct.origin = (990, 2135, 135);
  struct.angles = (0, 0, 0);
  _id_ABFA9FC534304BAC(struct);
  struct = spawnStruct();
  struct.origin = (1230, 2339, 145);
  struct.angles = (0, 180, 0);
  struct.angles = (0, 0, 0);
  _id_835640D85F3EB9C7(struct);
}

_id_4EF3B2C51679F626() {
  level endon("game_ended");

  for(;;) {
    if(getdvarint("dvar_586023952FAAE9BC", 0)) {
      setDvar("dvar_586023952FAAE9BC", 0);
      node = spawnStruct();
      node.origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 100;
      node.angles = level.players[0].angles;
      _id_BE9B3BA9656F790B(node);
    }

    waitframe();
  }
}