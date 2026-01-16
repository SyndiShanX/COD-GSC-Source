/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\gib.gsc
***********************************************/

#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\throttle_shared;

#namespace gib;

autoexec main() {
  clientfield::register("actor", "gib_state", 1, 9, "int");
  clientfield::register("playercorpse", "gib_state", 1, 15, "int");
  level.var_ad0f5efa = [];

  if(!isDefined(level.gib_throttle)) {
    level.gib_throttle = new throttle();
    [[level.gib_throttle]] - > initialize(2, 0.2);
  }
}

#namespace gibserverutils;

private function_3aa023f1(name, entity) {
  if(!isDefined(name)) {
    return undefined;
  }

  gibdef = level.var_ad0f5efa[name];

  if(isDefined(gibdef)) {
    return gibdef;
  }

  definition = struct::get_script_bundle("gibcharacterdef", name);

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
      assertmsg("<dev string:x58>" + gibflag);
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

private function_69db754(name, gibflag, entity) {
  gibpieces = function_3aa023f1(name, entity);
  return gibpieces[gibflag];
}

private _annihilate(entity) {
  if(isDefined(entity)) {
    entity notsolid();
  }
}

private _getgibextramodel(entity, gibflag) {
  if(gibflag == 4) {
    return (isDefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
  }

  if(gibflag == 8) {
    return (isDefined(entity.gib_data) ? entity.gib_data.head : entity.head);
  }

  assertmsg("<dev string:x8a>");
}

private _gibextra(entity, gibflag) {
  if(isgibbed(entity, gibflag)) {
    return false;
  }

  if(!_hasgibdef(entity)) {
    return false;
  }

  entity thread _gibextrainternal(entity, gibflag);
  return true;
}

private _gibextrainternal(entity, gibflag) {
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

  _setgibbed(entity, gibflag, undefined);
  destructserverutils::showdestructedpieces(entity);
  showhiddengibpieces(entity);
  gibmodel = _getgibextramodel(entity, gibflag);

  if(isDefined(gibmodel) && entity isattached(gibmodel)) {
    entity detach(gibmodel, "");
  }

  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity);
}

private _gibentity(entity, gibflag) {
  if(isgibbed(entity, gibflag) || !_hasgibpieces(entity, gibflag)) {
    return false;
  }

  if(!_hasgibdef(entity)) {
    return false;
  }

  entity thread _gibentityinternal(entity, gibflag);
  return true;
}

private _gibentityinternal(entity, gibflag) {
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
  showhiddengibpieces(entity);

  if(!(_getgibbedstate(entity) < 16)) {
    legmodel = _getgibbedlegmodel(entity);
    entity detach(legmodel);
  }

  _setgibbed(entity, gibflag, undefined);
  entity setModel(_getgibbedtorsomodel(entity));
  entity attach(_getgibbedlegmodel(entity));
  destructserverutils::reapplydestructedpieces(entity);
  reapplyhiddengibpieces(entity);
}

private _getgibbedlegmodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightleggibbed = gibstate&128;
  leftleggibbed = gibstate&256;

  if(rightleggibbed && leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
  } else if(rightleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
  } else if(leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
  }

  return isDefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1;
}

private _getgibbedstate(entity) {
  if(isDefined(entity.gib_state)) {
    return entity.gib_state;
  }

  return 0;
}

private _getgibbedtorsomodel(entity) {
  gibstate = _getgibbedstate(entity);
  rightarmgibbed = gibstate&16;
  leftarmgibbed = gibstate&32;

  if(rightarmgibbed && leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  } else if(rightarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  } else if(leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
  }

  return isDefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1;
}

private _hasgibdef(entity) {
  return isDefined(entity.gibdef);
}

private _hasgibpieces(entity, gibflag) {
  hasgibpieces = 0;
  gibstate = _getgibbedstate(entity);
  entity.gib_state = gibstate | gibflag&512 - 1;

  if(isDefined(_getgibbedtorsomodel(entity)) && isDefined(_getgibbedlegmodel(entity))) {
    hasgibpieces = 1;
  }

  entity.gib_state = gibstate;
  return hasgibpieces;
}

private _setgibbed(entity, gibflag, gibdir) {
  if(isDefined(gibdir)) {
    angles = vectortoangles(gibdir);
    yaw = angles[1];
    yaw_bits = getbitsforangle(yaw, 3);
    entity.gib_state = (_getgibbedstate(entity) | gibflag&512 - 1) + (yaw_bits << 9);
  } else {
    entity.gib_state = _getgibbedstate(entity) | gibflag&512 - 1;
  }

  entity.gibbed = 1;
  entity clientfield::set("gib_state", entity.gib_state);
}

annihilate(entity) {
  if(!_hasgibdef(entity)) {
    return false;
  }

  gibpiecestruct = function_69db754(entity.gibdef, 2, entity);

  if(isDefined(gibpiecestruct)) {
    if(isDefined(gibpiecestruct.gibfx)) {
      _setgibbed(entity, 2, undefined);
      entity thread _annihilate(entity);
      return true;
    }
  }

  return false;
}

copygibstate(originalentity, newentity) {
  newentity.gib_state = _getgibbedstate(originalentity);
  togglespawngibs(newentity, 0);
  reapplyhiddengibpieces(newentity);
}

isgibbed(entity, gibflag) {
  return _getgibbedstate(entity)&gibflag;
}

gibhat(entity) {
  return _gibextra(entity, 4);
}

gibhead(entity) {
  gibhat(entity);
  level notify(#"gib", {
    #entity: entity, 
    #attacker: self.attacker, 
    #area: "head"
  });
  return _gibextra(entity, 8);
}

gibleftarm(entity) {
  if(isgibbed(entity, 16)) {
    return false;
  }

  if(_gibentity(entity, 32)) {
    destructserverutils::destructleftarmpieces(entity);
    level notify(#"gib", {
      #entity: entity, 
      #attacker: self.attacker, 
      #area: "left_arm"
    });
    return true;
  }

  return false;
}

gibrightarm(entity) {
  if(isgibbed(entity, 32)) {
    return false;
  }

  if(_gibentity(entity, 16)) {
    destructserverutils::destructrightarmpieces(entity);
    entity thread shared::dropaiweapon();
    level notify(#"gib", {
      #entity: entity, 
      #attacker: self.attacker, 
      #area: "right_arm"
    });
    return true;
  }

  return false;
}

gibleftleg(entity) {
  if(_gibentity(entity, 256)) {
    destructserverutils::destructleftlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, 
      #attacker: self.attacker, 
      #area: "left_leg"
    });
    return true;
  }

  return false;
}

gibrightleg(entity) {
  if(_gibentity(entity, 128)) {
    destructserverutils::destructrightlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, 
      #attacker: self.attacker, 
      #area: "right_leg"
    });
    return true;
  }

  return false;
}

giblegs(entity) {
  if(_gibentity(entity, 384)) {
    destructserverutils::destructrightlegpieces(entity);
    destructserverutils::destructleftlegpieces(entity);
    level notify(#"gib", {
      #entity: entity, 
      #attacker: self.attacker, 
      #area: "both_legs"
    });
    return true;
  }

  return false;
}

playergibleftarm(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 32, dir);
  }
}

playergibrightarm(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 16, dir);
  }
}

playergibleftleg(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 256, dir);
  }
}

playergibrightleg(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 128, dir);
  }
}

playergiblegs(entity) {
  if(isDefined(entity.body)) {
    dir = (1, 0, 0);
    _setgibbed(entity.body, 128, dir);
    _setgibbed(entity.body, 256, dir);
  }
}

event_handler[player_gibleftarmvel] playergibleftarmvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 32, entitystruct.direction);
  }
}

event_handler[player_gibrightarmvel] playergibrightarmvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 16, entitystruct.direction);
  }
}

event_handler[player_gibleftlegvel] playergibleftlegvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
  }
}

event_handler[player_gibrightlegvel] playergibrightlegvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
  }
}

event_handler[player_gibbothlegsvel] playergiblegsvel(entitystruct) {
  if(isDefined(entitystruct.player.body)) {
    _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
    _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
  }
}

reapplyhiddengibpieces(entity) {
  if(!_hasgibdef(entity)) {
    return;
  }

  gibpieces = function_3aa023f1(entity.gibdef, entity);

  foreach(gibflag, gib in gibpieces) {
    if(!isgibbed(entity, gibflag)) {
      continue;
    }

    if(!isDefined(gib)) {
      continue;
    }

    if(isDefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag)) {
      if(!(isDefined(entity.skipdeath) && entity.skipdeath)) {
        entity hidepart(gib.gibhidetag, "", 1);
      }
    }
  }
}

showhiddengibpieces(entity) {
  if(!_hasgibdef(entity)) {
    return;
  }

  gibpieces = function_3aa023f1(entity.gibdef, entity);

  foreach(gib in gibpieces) {
    if(!isDefined(gib)) {
      continue;
    }

    if(isDefined(gib.gibhidetag) && entity haspart(gib.gibhidetag)) {
      entity showpart(gib.gibhidetag, "", 1);
    }
  }
}

togglespawngibs(entity, shouldspawngibs) {
  if(!shouldspawngibs) {
    entity.gib_state = _getgibbedstate(entity) | 1;
  } else {
    entity.gib_state = _getgibbedstate(entity)&-2;
  }

  entity clientfield::set("gib_state", entity.gib_state);
}