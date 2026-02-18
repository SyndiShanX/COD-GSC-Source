/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\gib.gsc
***********************************************/

#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;
#namespace gib;

function autoexec main() {
  clientfield::register("actor", "gib_state", 1, 14, "int");
  clientfield::register("playercorpse", "gib_state", 1, 17, "int");
  level.var_ad0f5efa = [];

  if(!isDefined(level.gib_throttle)) {
    level.gib_throttle = new throttle();
    [[level.gib_throttle]] - > initialize(2, 0.2);
  }
}

#namespace gibserverutils;

function private function_3aa023f1(entity, var_c3317960) {
  if(!isDefined(entity) || !_hasgibdef(entity, var_c3317960)) {
    return undefined;
  }

  name = entity.gibdef;

  if(isDefined(entity.var_868d0717)) {
    if(isDefined(entity.var_868d0717[var_c3317960])) {
      name = entity.var_868d0717[var_c3317960];
    } else if(isDefined(entity.var_868d0717[0])) {
      name = entity.var_868d0717[0];
    }
  }

  gibdef = level.var_ad0f5efa[name];

  if(isDefined(gibdef)) {
    return gibdef;
  }

  definition = getscriptbundle(name);

  if(!isDefined(definition)) {
    assertmsg("<dev string:x38>" + name);
    return undefined;
  }

  gibpiecelookup = [];
  gibpiecelookup[2] = "annihilate";
  gibpiecelookup[8] = "head";
  gibpiecelookup[16] = "rightarm";
  gibpiecelookup[32] = "leftarm";
  gibpiecelookup[128] = "rightleg";
  gibpiecelookup[256] = "leftleg";
  gibpieces = [];

  foreach(gibflag, gibpiece in gibpiecelookup) {
    if(!isDefined(gibpiece)) {
      assertmsg("<dev string:x59>" + gibflag);
      continue;
    }

    gibstruct = spawnStruct();
    gibstruct.gibmodel = definition.(gibpiece + "_gibmodel");
    gibstruct.gibtag = definition.(gibpiece + "_gibtag");
    gibstruct.gibfx = definition.(gibpiece + "_gibfx");
    gibstruct.gibfxtag = definition.(gibpiece + "_gibeffecttag");
    gibstruct.gibdynentfx = definition.(gibpiece + "_gibdynentfx");
    gibstruct.var_42c89fa1 = definition.(gibpiece + "_gibcinematicfx");
    gibstruct.gibsound = definition.(gibpiece + "_gibsound");
    gibstruct.gibhidetag = definition.(gibpiece + "_gibhidetag");
    gibpieces[gibflag] = gibstruct;
  }

  level.var_ad0f5efa[name] = gibpieces;
  return gibpieces;
}

function private function_69db754(entity, gibflag, var_c3317960) {
  gibpieces = function_3aa023f1(entity, var_c3317960);
  return gibpieces[gibflag];
}

function private _annihilate(entity) {
  if(isDefined(entity)) {
    entity notsolid();
    entity.var_9a6fcc = 1;
    waitframe(5);

    if(isDefined(entity)) {
      entity delete();
    }
  }
}

function private _getgibextramodel(entity, gibflag) {
  if(gibflag == 4) {
    return (isDefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
  }

  if(gibflag == 8) {
    return (isDefined(entity.gib_data) ? entity.gib_data.head : entity.head);
  }

  assertmsg("<dev string:x8c>");
}

function private _gibextra(entity, gibflag, var_c3317960) {
  if(isgibbed(entity, gibflag)) {
    return false;
  }

  if(!_hasgibdef(entity, var_c3317960)) {
    return false;
  }

  entity thread _gibextrainternal(entity, gibflag, var_c3317960);
  return true;
}

function private _gibextrainternal(entity, gibflag, var_c3317960) {
  if(entity.gib_time !== gettime()) {
    [[level.gib_throttle]] - > waitinqueue(entity);
  }

  if(!isDefined(entity)) {
    return;
  }

  entity.gib_time = gettime();

  if(isgibbed(entity, gibflag)) {
    return 0;
  }

  if(gibflag == 8) {
    if(isDefined(isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)) {
      entity attach(isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "", 1);
    }
  }

  _setgibbed(entity, gibflag, undefined, var_c3317960);
  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity, var_c3317960);
  gibmodel = _getgibextramodel(entity, gibflag);

  if(isDefined(gibmodel) && entity isattached(gibmodel)) {
    entity detach(gibmodel, "");
  }

  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity, var_c3317960);
}

function private _gibentity(entity, gibflag, var_c3317960) {
  if(isgibbed(entity, gibflag) || !_hasgibpieces(entity, gibflag, var_c3317960)) {
    return false;
  }

  if(!_hasgibdef(entity, var_c3317960)) {
    return false;
  }

  entity thread _gibentityinternal(entity, gibflag, var_c3317960);
  return true;
}

function private _gibentityinternal(entity, gibflag, var_c3317960) {
  if(entity.gib_time !== gettime()) {
    [[level.gib_throttle]] - > waitinqueue(entity);
  }

  if(!isDefined(entity)) {
    return;
  }

  entity.gib_time = gettime();

  if(isgibbed(entity, gibflag)) {
    return;
  }

  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity, var_c3317960);

  if(!(_getgibbedstate(entity) < 16)) {
    legmodel = _getgibbedlegmodel(entity);
    entity detach(legmodel);
  }

  _setgibbed(entity, gibflag, undefined, var_c3317960);
  entity setModel(_getgibbedtorsomodel(entity));

  if(!entity isattached(_getgibbedlegmodel(entity))) {
    entity attach(_getgibbedlegmodel(entity));
  }

  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity, var_c3317960);
}

function private _getgibbedlegmodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightleggibbed = gibstate & 128;
  leftleggibbed = gibstate & 256;

  if(rightleggibbed && leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
  } else if(rightleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
  } else if(leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
  }

  return isDefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1;
}

function private _getgibbedstate(entity) {
  if(isDefined(entity.gib_state)) {
    return entity.gib_state;
  }

  return 0;
}

function private _getgibbedtorsomodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightarmgibbed = gibstate & 16;
  leftarmgibbed = gibstate & 32;

  if(rightarmgibbed && leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  } else if(rightarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  } else if(leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
  }

  return isDefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1;
}

function private _hasgibdef(entity, var_c3317960) {
  if(isDefined(entity.var_868d0717)) {
    if(isDefined(entity.var_868d0717[var_c3317960]) || isDefined(entity.var_868d0717[0])) {
      return true;
    }
  }

  return isDefined(entity.gibdef);
}

function private _hasgibpieces(entity, gibflag, var_c3317960) {
  if(16 < var_c3317960) {
    var_c3317960 = 0;
  }

  hasgibpieces = 0;
  gibstate = _getgibbedstate(entity);
  entity.gib_state = (gibstate & 512 - 1 | gibflag & 512 - 1) + (var_c3317960 << 9);

  if(isDefined(_getgibbedtorsomodel(entity)) && isDefined(_getgibbedlegmodel(entity))) {
    hasgibpieces = 1;
  }

  entity.gib_state = gibstate;
  return hasgibpieces;
}

function private _setgibbed(entity, gibflag, gibdir, var_c3317960) {
  if(16 < var_c3317960) {
    var_c3317960 = 0;
  }

  if(isDefined(gibdir)) {
    angles = vectortoangles(gibdir);
    yaw = angles[1];
    yaw_bits = getbitsforangle(yaw, 3);
    entity.gib_state = (_getgibbedstate(entity) & 512 - 1 | gibflag & 512 - 1) + (var_c3317960 << 9) + (yaw_bits << 14);
  } else {
    entity.gib_state = (_getgibbedstate(entity) & 512 - 1 | gibflag & 512 - 1) + (var_c3317960 << 9);
  }

  entity.gibbed = 1;
  entity clientfield::set("gib_state", entity.gib_state);
}

function annihilate(entity) {
  if(!_hasgibdef(entity, 0)) {
    return false;
  }

  gibpiecestruct = function_69db754(entity, 2, 0);

  if(isDefined(gibpiecestruct)) {
    if(isDefined(gibpiecestruct.gibfx)) {
      _setgibbed(entity, 2, undefined, 0);
      entity thread _annihilate(entity);
      return true;
    }
  }

  return false;
}

function copygibstate(originalentity, newentity) {
  newentity.gib_state = _getgibbedstate(originalentity);
  togglespawngibs(newentity, 0);
  var_c3317960 = newentity.gib_state >> 9 & 32 - 1;
  reapplyhiddengibpieces(newentity, var_c3317960);
}

function isgibbed(entity, gibflag) {
  return _getgibbedstate(entity) &gibflag;
}

function gibhat(entity, var_c3317960) {
  return _gibextra(entity, 4, var_c3317960);
}

function gibhead(entity, var_c3317960 = 0) {
  gibhat(entity, var_c3317960);
  level notify(#"gib", {
    #entity: entity, #attacker: self.attacker, #area: "head"});
  entity callback::callback(#"head_gibbed");
  return _gibextra(entity, 8, var_c3317960);
}

function gibleftarm(entity, var_c3317960 = 0) {
  if(isgibbed(entity, 16)) {
    return false;
  }

  if(_gibentity(entity, 32, var_c3317960)) {
    destructserverutils::destructleftarmpieces(entity);
    level notify(#"gib", {
      #entity: entity, #attacker: self.attacker, #area: "left_arm"});
    return true;
  }

  return false;
}

function gibrightarm(entity, var_c3317960 = 0) {
  if(isgibbed(entity, 32)) {
    return false;
  }

  if(_gibentity(entity, 16, var_c3317960)) {
    destructserverutils::destructrightarmpieces(entity);
    entity thread shared::dropaiweapon();
    level notify(#"gib", {
      #entity: entity, #attacker: self.attacker, #area: "right_arm"});
    return true;
  }

  return false;
}

function gibleftleg(entity, var_c3317960 = 0) {
  if(_gibentity(entity, 256, var_c3317960)) {
    destructserverutils::destructleftlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, #attacker: self.attacker, #area: "left_leg"});
    return true;
  }

  return false;
}

function gibrightleg(entity, var_c3317960 = 0) {
  if(_gibentity(entity, 128, var_c3317960)) {
    destructserverutils::destructrightlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, #attacker: self.attacker, #area: "right_leg"});
    return true;
  }

  return false;
}

function giblegs(entity, var_c3317960 = 0) {
  if(_gibentity(entity, 384, var_c3317960)) {
    destructserverutils::destructrightlegpieces(entity);
    destructserverutils::destructleftlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, #attacker: self.attacker, #area: "both_legs"});
    return true;
  }

  return false;
}

function event_handler[player_gibleftarmvel] playergibleftarmvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 32, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function event_handler[player_gibrightarmvel] playergibrightarmvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 16, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function event_handler[player_gibleftlegvel] playergibleftlegvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 256, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function event_handler[player_gibrightlegvel] playergibrightlegvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 128, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function event_handler[player_gibbothlegsvel] playergiblegsvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 128, entitystruct.direction, entitystruct.var_c3317960);
    _setgibbed(entitystruct.player.body, 256, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function event_handler[event_5d8d772d] function_b14ffba8(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 8, entitystruct.direction, entitystruct.var_c3317960);
  }
}

function reapplyhiddengibpieces(entity, var_c3317960) {
  if(!_hasgibdef(entity, var_c3317960)) {
    return;
  }

  gibpieces = function_3aa023f1(entity, var_c3317960);

  foreach(gibflag, gib in gibpieces) {
    if(!isgibbed(entity, gibflag)) {
      continue;
    }

    if(!isDefined(gib)) {
      continue;
    }

    if(isDefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag)) {
      if(!is_true(entity.skipdeath)) {
        entity hidepart(gib.gibhidetag, "", 1);
      }
    }
  }
}

function showhiddengibpieces(entity, var_c3317960) {
  if(!_hasgibdef(entity, var_c3317960)) {
    return;
  }

  gibpieces = function_3aa023f1(entity, var_c3317960);

  foreach(gib in gibpieces) {
    if(!isDefined(gib)) {
      continue;
    }

    if(isDefined(gib.gibhidetag) && entity haspart(gib.gibhidetag)) {
      entity showpart(gib.gibhidetag, "", 1);
    }
  }
}

function togglespawngibs(entity, shouldspawngibs) {
  if(!shouldspawngibs) {
    entity.gib_state = _getgibbedstate(entity) | 1;
  } else {
    entity.gib_state = _getgibbedstate(entity) &-2;
  }

  entity clientfield::set("gib_state", entity.gib_state);
}

function function_96bedd91(entity) {
  if([[level.gib_throttle]] - > wm_ht_posidlestart(entity)) {
    return;
  }

  var_c3317960 = entity.gib_state >> 9 & 32 - 1;
  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity, var_c3317960);

  if(!(_getgibbedstate(entity) < 16)) {
    legmodel = _getgibbedlegmodel(entity);

    if(isDefined(legmodel)) {
      entity detach(legmodel);
    }
  }

  var_8d04b98a = _getgibbedtorsomodel(entity);

  if(!isDefined(var_8d04b98a)) {
    return;
  }

  entity setModel(var_8d04b98a);
  var_992e2883 = _getgibbedlegmodel(entity);

  if(isDefined(var_992e2883) && !entity isattached(var_992e2883)) {
    entity attach(var_992e2883);
  }

  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity, var_c3317960);

  if(is_true(entity.head_gibbed)) {
    var_3bb4d879 = isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5;

    if(isDefined(var_3bb4d879) && !entity isattached(var_3bb4d879)) {
      entity attach(var_3bb4d879, "", 1);
    }

    var_81adae15 = _getgibextramodel(entity, 4);

    if(isDefined(var_81adae15) && entity isattached(var_81adae15)) {
      entity detach(var_81adae15, "");
    }

    var_ec17ebe9 = _getgibextramodel(entity, 8);

    if(isDefined(var_ec17ebe9) && entity isattached(var_ec17ebe9)) {
      entity detach(var_ec17ebe9, "");
    }
  }
}

function function_de4d9d(weapon, var_fd90b0bb) {
  if(!isweapon(weapon) || !weapon.isvalid || weapon === level.weaponnone || !isDefined(var_fd90b0bb) || !var_fd90b0bb) {
    return 0;
  }

  return function_497b2440(weapon, var_fd90b0bb);
}