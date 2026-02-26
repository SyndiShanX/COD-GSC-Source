/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\gib.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace gibclientutils;

function autoexec main() {
  clientfield::register("actor", "gib_state", 1, 14, "int", &_gibhandler, 0, 0);
  clientfield::register("playercorpse", "gib_state", 1, 17, "int", &_gibhandler, 0, 0);
  level.var_ad0f5efa = [];
  level thread _annihilatecorpse();
}

function private function_3aa023f1(name) {
  if(!isDefined(name)) {
    return undefined;
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

function private function_9fe14ca3(entity, gibflag, var_c3317960) {
  if(gibflag == 8) {
    part = "head";
  } else if(gibflag == 16 || gibflag == 32) {
    part = "arms";
  } else if(gibflag == 128 || gibflag == 256) {
    part = "legs";
  }

  if(!isDefined(part)) {
    return undefined;
  }

  name = entity getplayergibdef(part, var_c3317960);

  if(!isDefined(name)) {
    assertmsg("<dev string:x8c>" + gibflag);
    return undefined;
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
  gibpiecelookup[0] = "left";
  gibpiecelookup[1] = "right";
  gibpieces = [];

  foreach(side, gibpiece in gibpiecelookup) {
    if(!isDefined(gibpiece)) {
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
    gibpieces[side] = gibstruct;
  }

  level.var_ad0f5efa[name] = gibpieces;
  return gibpieces;
}

function function_c0099e86(entity, gibflag, var_c3317960) {
  gibpiece = function_9fe14ca3(entity, gibflag, var_c3317960);

  if(!isDefined(gibpiece)) {
    return undefined;
  }

  if(gibflag == 8) {
    side = 0;
  } else if(gibflag == 16 || gibflag == 128) {
    side = 1;
  } else if(gibflag == 32 || gibflag == 256) {
    side = 0;
  }

  return gibpiece[side];
}

function private function_d956078a(entity, var_c3317960) {
  name = entity.gibdef;

  if(isDefined(entity.var_868d0717)) {
    if(isDefined(entity.var_868d0717[var_c3317960])) {
      name = entity.var_868d0717[var_c3317960];
    } else if(isDefined(entity.var_868d0717[0])) {
      name = entity.var_868d0717[0];
    }
  }

  return name;
}

function private function_69db754(entity, gibflag, var_c3317960) {
  if(isPlayer(entity) || entity isplayercorpse()) {
    return function_c0099e86(entity, gibflag, var_c3317960);
  }

  if(isDefined(entity.gib_data)) {
    gibpieces = function_3aa023f1(entity.gib_data.gibdef);
  } else {
    gibpieces = function_3aa023f1(function_d956078a(entity, var_c3317960));
  }

  return gibpieces[gibflag];
}

function private _annihilatecorpse() {
  while(true) {
    waitresult = level waittill(#"corpse_explode");
    localclientnum = waitresult.localclientnum;
    body = waitresult.body;
    origin = waitresult.position;

    if(!util::is_mature() || util::is_gib_restricted_build()) {
      continue;
    }

    if(isDefined(body) && _hasgibdef(body, 0) && body isragdoll()) {
      cliententgibhead(localclientnum, body, 0);
      cliententgibrightarm(localclientnum, body, 0);
      cliententgibleftarm(localclientnum, body, 0);
      cliententgibrightleg(localclientnum, body, 0);
      cliententgibleftleg(localclientnum, body, 0);
    }

    if(isDefined(body) && _hasgibdef(body, 0) && body.archetype == # "human") {
      if(randomint(100) >= 50) {
        continue;
      }

      if(isDefined(origin) && distancesquared(body.origin, origin) <= 14400) {
        body.ignoreragdoll = 1;
        body _gibentity(localclientnum, 50 | 384, 1, 0);
      }
    }
  }
}

function private _clonegibdata(localclientnum, entity, var_c3317960, clone) {
  clone.gib_data = spawnStruct();
  clone.gib_data.gib_state = entity.gib_state;
  clone.gib_data.gibdef = function_d956078a(entity, var_c3317960);
  clone.gib_data.hatmodel = entity.hatmodel;
  clone.gib_data.head = entity.head;
  clone.gib_data.legdmg1 = entity.legdmg1;
  clone.gib_data.legdmg2 = entity.legdmg2;
  clone.gib_data.legdmg3 = entity.legdmg3;
  clone.gib_data.legdmg4 = entity.legdmg4;
  clone.gib_data.torsodmg1 = entity.torsodmg1;
  clone.gib_data.torsodmg2 = entity.torsodmg2;
  clone.gib_data.torsodmg3 = entity.torsodmg3;
  clone.gib_data.torsodmg4 = entity.torsodmg4;
  clone.gib_data.torsodmg5 = entity.torsodmg5;
}

function private _getgibbedstate(localclientnum, entity) {
  if(isDefined(entity.gib_data) && isDefined(entity.gib_data.gib_state)) {
    return entity.gib_data.gib_state;
  } else if(isDefined(entity.gib_state)) {
    return entity.gib_state;
  }

  return 0;
}

function private _getgibbedlegmodel(localclientnum, entity) {
  gibstate = _getgibbedstate(localclientnum, entity);
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

function private _getgibextramodel(localclientnumm, entity, gibflag) {
  if(gibflag == 4) {
    return (isDefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
  }

  if(gibflag == 8) {
    return (isDefined(entity.gib_data) ? entity.gib_data.head : entity.head);
  }

  assertmsg("<dev string:xb3>");
}

function private _getgibbedtorsomodel(localclientnum, entity) {
  gibstate = _getgibbedstate(localclientnum, entity);
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

function private _gibpiecetag(localclientnum, entity, gibflag, var_c3317960) {
  if(!_hasgibdef(self, var_c3317960)) {
    return;
  }

  gibpiece = function_69db754(entity, gibflag, var_c3317960);

  if(isDefined(gibpiece)) {
    return gibpiece.gibfxtag;
  }
}

function private function_ba120c50(gibflags) {
  var_ec7623a6 = 0;

  if(gibflags & 12) {
    var_ec7623a6 |= 1;
  }

  if(gibflags & 48) {
    var_ec7623a6 |= 2;
  }

  if(gibflags & 384) {
    var_ec7623a6 |= 4;
  }

  return var_ec7623a6;
}

function private _gibentity(localclientnum, gibflags, shouldspawngibs, var_c3317960) {
  entity = self;

  if(!_hasgibdef(entity, var_c3317960)) {
    return;
  }

  currentgibflag = 2;
  gibdir = undefined;
  gibdirscale = undefined;

  if(isPlayer(entity) || entity isplayercorpse()) {
    yaw_bits = gibflags >> 14 & 8 - 1;
    yaw = getanglefrombits(yaw_bits, 3);
    gibdir = anglesToForward((0, yaw, 0));
  }

  while(gibflags >= currentgibflag) {
    if(gibflags &currentgibflag) {
      if(currentgibflag == 2) {
        if(isPlayer(entity) || entity isplayercorpse()) {
          var_c0c9eae3 = entity function_4976d5ee();

          if(isDefined(var_c0c9eae3)) {
            _playgibfx(localclientnum, entity, var_c0c9eae3[#"fx"], var_c0c9eae3[#"tag"]);
          }
        } else {
          gibpiece = function_69db754(entity, currentgibflag, var_c3317960);

          if(isDefined(gibpiece)) {
            _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);

            if(isDefined(gibpiece.var_42c89fa1)) {
              if(function_92beaa28(localclientnum)) {
                _playgibfx(localclientnum, entity, gibpiece.var_42c89fa1, gibpiece.gibfxtag);
              }
            }

            _playgibsound(localclientnum, entity, gibpiece.gibsound);
          }
        }

        entity hide();
        entity.ignoreragdoll = 1;
      } else {
        gibpiece = function_69db754(entity, currentgibflag, var_c3317960);

        if(isDefined(gibpiece)) {
          if(shouldspawngibs) {
            var_cd61eb7d = function_ba120c50(currentgibflag);
            entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir, gibdirscale, var_cd61eb7d);

            if(isDefined(gibpiece.gibhidetag) && entity isplayercorpse() && entity hasdobj(localclientnum)) {
              entity function_7a198d8c(localclientnum, gibpiece.gibhidetag, "", 1);
            }
          }

          _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);

          if(isDefined(gibpiece.var_42c89fa1)) {
            if(function_92beaa28(localclientnum)) {
              _playgibfx(localclientnum, entity, gibpiece.var_42c89fa1, gibpiece.gibfxtag);
            }
          }

          _playgibsound(localclientnum, entity, gibpiece.gibsound);
        }
      }

      _handlegibcallbacks(localclientnum, entity, currentgibflag);
    }

    currentgibflag <<= 1;
  }
}

function private _setgibbed(localclientnum, entity, gibflag, var_c3317960) {
  gib_state = (_getgibbedstate(localclientnum, entity) & 512 - 1 | gibflag & 512 - 1) + (var_c3317960 << 9);

  if(isDefined(entity.gib_data)) {
    entity.gib_data.gib_state = gib_state;
    return;
  }

  entity.gib_state = gib_state;
}

function private _gibcliententityinternal(localclientnum, entity, gibflag, var_c3317960) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }

  if(!isDefined(entity) || !_hasgibdef(entity, var_c3317960)) {
    return;
  }

  if(entity.type !== "scriptmover") {
    return;
  }

  if(isgibbed(localclientnum, entity, gibflag)) {
    return;
  }

  if(!(_getgibbedstate(localclientnum, entity) < 16)) {
    legmodel = _getgibbedlegmodel(localclientnum, entity);
    entity detach(legmodel, "");
  }

  _setgibbed(localclientnum, entity, gibflag, var_c3317960);
  entity setModel(_getgibbedtorsomodel(localclientnum, entity));
  entity attach(_getgibbedlegmodel(localclientnum, entity), "");
  entity _gibentity(localclientnum, gibflag, 1, var_c3317960);
}

function private _gibclientextrainternal(localclientnum, entity, gibflag, var_c3317960) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }

  if(!isDefined(entity)) {
    return;
  }

  if(entity.type !== "scriptmover") {
    return;
  }

  if(isgibbed(localclientnum, entity, gibflag)) {
    return;
  }

  gibmodel = _getgibextramodel(localclientnum, entity, gibflag);

  if(isDefined(gibmodel) && entity isattached(gibmodel, "")) {
    entity detach(gibmodel, "");
  }

  if(gibflag == 8) {
    if(isDefined(isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)) {
      entity attach(isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "");
    }
  }

  _setgibbed(localclientnum, entity, gibflag, var_c3317960);
  entity _gibentity(localclientnum, gibflag, 1, var_c3317960);
}

function private _gibhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  var_c3317960 = fieldname >> 9 & 32 - 1;

  if(16 < var_c3317960) {
    var_c3317960 = 0;
  }

  if(isPlayer(entity) || entity isplayercorpse()) {
    if(!util::is_mature() || util::is_gib_restricted_build()) {
      return;
    }
  } else {
    if(isDefined(entity.maturegib) && entity.maturegib && (!util::is_mature() || !isshowgibsenabled())) {
      return;
    }

    if(isDefined(entity.restrictedgib) && entity.restrictedgib && !isshowgibsenabled()) {
      return;
    }
  }

  gibflags = binitialsnap ^ fieldname;
  shouldspawngibs = !(fieldname & 1);

  if(wasdemojump) {
    gibflags = 0 ^ fieldname;
  }

  entity _gibentity(bnewent, gibflags, shouldspawngibs, var_c3317960);
  entity.gib_state = fieldname;
}

function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir, gibdirscale, var_bf41adc0) {
  if(!isDefined(gibtag) || !isDefined(gibmodel)) {
    return;
  }

  if(gibmodel == # "") {
    return;
  }

  startposition = entity gettagorigin(gibtag);
  startangles = entity gettagangles(gibtag);
  endposition = startposition;
  endangles = startangles;
  forwardvector = undefined;

  if(!isDefined(startposition) || !isDefined(startangles)) {
    return;
  }

  if(isDefined(gibdir) && !isDefined(gibdirscale)) {
    startposition = (0, 0, 0);
    forwardvector = gibdir;
    forwardvector *= randomfloatrange(100, 500);
  } else {
    waitframe(1);

    if(isDefined(entity)) {
      endposition = entity gettagorigin(gibtag);
      endangles = entity gettagangles(gibtag);
    } else {
      endposition = startposition + anglesToForward(startangles) * 10;
      endangles = startangles;
    }

    if(!isDefined(endposition) || !isDefined(endangles)) {
      return;
    }

    scale = randomfloatrange(0.6, 1);
    dir = (randomfloatrange(0, 0.2), randomfloatrange(0, 0.2), randomfloatrange(0.2, 0.7));

    if(isDefined(gibdir) && isDefined(gibdirscale) && gibdirscale > 0) {
      dir = gibdir + dir;
      scale = gibdirscale;
    }

    forwardvector = vectornormalize(endposition - startposition);
    forwardvector *= scale;
    forwardvector += dir;
  }

  if(isDefined(entity)) {
    if(!isDefined(entity.var_f9a4eb08)) {
      entity.var_f9a4eb08 = [];
    }

    gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1, !is_true(level.var_2f78f66c));

    if(!isDefined(entity.var_f9a4eb08)) {
      entity.var_f9a4eb08 = [];
    } else if(!isarray(entity.var_f9a4eb08)) {
      entity.var_f9a4eb08 = array(entity.var_f9a4eb08);
    }

    entity.var_f9a4eb08[entity.var_f9a4eb08.size] = gibentity;

    if(isDefined(gibentity)) {
      function_1cfbe3d4(gibentity, entity function_c70446c2(), var_bf41adc0);
    }
  }
}

function private _handlegibcallbacks(localclientnum, entity, gibflag) {
  if(isDefined(entity._gibcallbacks) && isDefined(entity._gibcallbacks[gibflag])) {
    foreach(callback in entity._gibcallbacks[gibflag]) {
      [[callback]](localclientnum, entity, gibflag);
    }
  }
}

function private _handlegibannihilate(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib_annihilate"}, #"_anim_notify_");
  cliententgibannihilate(localclientnum, entity);
}

function private _handlegibhead(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib = \"head\""}, #"_anim_notify_");
  cliententgibhead(localclientnum, entity, 0);
}

function private _handlegibrightarm(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib = \"arm_right\""}, #"_anim_notify_");
  cliententgibrightarm(localclientnum, entity, 0);
}

function private _handlegibleftarm(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib = \"arm_left\""}, #"_anim_notify_");
  cliententgibleftarm(localclientnum, entity, 0);
}

function private _handlegibrightleg(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib = \"leg_right\""}, #"_anim_notify_");
  cliententgibrightleg(localclientnum, entity, 0);
}

function private _handlegibleftleg(localclientnum) {
  entity = self;
  entity endon(#"death");
  entity waittillmatch({
    #notetrack: "gib = \"leg_left\""}, #"_anim_notify_");
  cliententgibleftleg(localclientnum, entity, 0);
}

function private _hasgibdef(entity, var_c3317960) {
  return isDefined(entity.gib_data) && isDefined(entity.gib_data.gibdef) || isDefined(entity.gibdef) || isDefined(entity getplayergibdef("arms", var_c3317960)) && isDefined(entity getplayergibdef("legs", var_c3317960));
}

function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
  if(isDefined(fxfilename) && isDefined(fxtag) && entity hasdobj(localclientnum)) {
    fx = util::playFXOnTag(localclientnum, fxfilename, entity, fxtag);

    if(isDefined(fx)) {
      if(isDefined(entity.team)) {
        setfxteam(localclientnum, fx, entity.team);
      }

      if(is_true(level.setgibfxtoignorepause)) {
        setfxignorepause(localclientnum, fx, 1);
      }
    }

    return fx;
  }
}

function _playgibsound(localclientnum, entity, soundalias) {
  if(level.var_c91b202 === 1) {
    return;
  }

  if(isDefined(soundalias)) {
    playSound(localclientnum, soundalias, entity.origin);
  }
}

function addgibcallback(localclientnum, entity, gibflag, callbackfunction) {
  assert(isfunctionptr(callbackfunction));

  if(!isDefined(entity._gibcallbacks)) {
    entity._gibcallbacks = [];
  }

  if(!isDefined(entity._gibcallbacks[gibflag])) {
    entity._gibcallbacks[gibflag] = [];
  }

  gibcallbacks = entity._gibcallbacks[gibflag];
  gibcallbacks[gibcallbacks.size] = callbackfunction;
  entity._gibcallbacks[gibflag] = gibcallbacks;
}

function cliententgibannihilate(localclientnum, entity) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }

  entity.ignoreragdoll = 1;
  entity _gibentity(localclientnum, 50 | 384, 1, 0);
}

function cliententgibhead(localclientnum, entity, var_c3317960) {
  _gibclientextrainternal(localclientnum, entity, 8, var_c3317960);
}

function cliententgibleftarm(localclientnum, entity, var_c3317960) {
  if(isgibbed(localclientnum, entity, 16)) {
    return;
  }

  _gibcliententityinternal(localclientnum, entity, 32, var_c3317960);
}

function cliententgibrightarm(localclientnum, entity, var_c3317960) {
  if(isgibbed(localclientnum, entity, 32)) {
    return;
  }

  _gibcliententityinternal(localclientnum, entity, 16, var_c3317960);
}

function cliententgibleftleg(localclientnum, entity, var_c3317960) {
  _gibcliententityinternal(localclientnum, entity, 256, var_c3317960);
}

function cliententgibrightleg(localclientnum, entity, var_c3317960) {
  _gibcliententityinternal(localclientnum, entity, 128, var_c3317960);
}

function createscriptmodelofentity(localclientnum, entity, var_c3317960) {
  clone = spawn(localclientnum, entity.origin, "script_model");
  clone.angles = entity.angles;
  _clonegibdata(localclientnum, entity, var_c3317960, clone);
  gibstate = _getgibbedstate(localclientnum, clone);

  if(!util::is_mature() || util::is_gib_restricted_build()) {
    gibstate = 0;
  }

  if(!(_getgibbedstate(localclientnum, entity) < 16)) {
    clone setModel(_getgibbedtorsomodel(localclientnum, entity));
    clone attach(_getgibbedlegmodel(localclientnum, entity), "");
  } else {
    clone setModel(entity.model);
  }

  if(gibstate & 8) {
    if(isDefined(isDefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5)) {
      clone attach(isDefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5, "");
    }
  } else {
    if(isDefined(isDefined(clone.gib_data) ? clone.gib_data.head : clone.head)) {
      clone attach(isDefined(clone.gib_data) ? clone.gib_data.head : clone.head, "");
    }

    if(!(gibstate & 4) && isDefined(isDefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel)) {
      clone attach(isDefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel, "");
    }
  }

  return clone;
}

function isgibbed(localclientnum, entity, gibflag) {
  return _getgibbedstate(localclientnum, entity) &gibflag;
}

function isundamaged(localclientnum, entity) {
  return _getgibbedstate(localclientnum, entity) == 0;
}

function handlegibnotetracks(localclientnum) {
  entity = self;
  entity thread _handlegibannihilate(localclientnum);
  entity thread _handlegibhead(localclientnum);
  entity thread _handlegibrightarm(localclientnum);
  entity thread _handlegibleftarm(localclientnum);
  entity thread _handlegibrightleg(localclientnum);
  entity thread _handlegibleftleg(localclientnum);
}