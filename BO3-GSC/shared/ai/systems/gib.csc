/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\gib.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace gibclientutils;

function autoexec main() {
  clientfield::register("actor", "gib_state", 1, 9, "int", &_gibhandler, 0, 0);
  clientfield::register("playercorpse", "gib_state", 1, 15, "int", &_gibhandler, 0, 0);
  gibdefinitions = struct::get_script_bundles("gibcharacterdef");
  gibpiecelookup = [];
  gibpiecelookup[2] = "annihilate";
  gibpiecelookup[8] = "head";
  gibpiecelookup[16] = "rightarm";
  gibpiecelookup[32] = "leftarm";
  gibpiecelookup[128] = "rightleg";
  gibpiecelookup[256] = "leftleg";
  processedbundles = [];
  foreach(definitionname, definition in gibdefinitions) {
    gibbundle = spawnStruct();
    gibbundle.gibs = [];
    gibbundle.name = definitionname;
    foreach(gibpieceflag, gibpiecename in gibpiecelookup) {
      gibstruct = spawnStruct();
      gibstruct.gibmodel = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibmodel");
      gibstruct.gibtag = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibtag");
      gibstruct.gibfx = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibfx");
      gibstruct.gibfxtag = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibeffecttag");
      gibstruct.gibdynentfx = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibdynentfx");
      gibstruct.gibsound = getstructfield(definition, gibpiecelookup[gibpieceflag] + "_gibsound");
      gibbundle.gibs[gibpieceflag] = gibstruct;
    }
    processedbundles[definitionname] = gibbundle;
  }
  level.scriptbundles["gibcharacterdef"] = processedbundles;
  level thread _annihilatecorpse();
}

function private _annihilatecorpse() {
  while(true) {
    level waittill("corpse_explode", localclientnum, body, origin);
    if(!util::is_mature() || util::is_gib_restricted_build()) {
      continue;
    }
    if(isDefined(body) && _hasgibdef(body) && body isragdoll()) {
      cliententgibhead(localclientnum, body);
      cliententgibrightarm(localclientnum, body);
      cliententgibleftarm(localclientnum, body);
      cliententgibrightleg(localclientnum, body);
      cliententgibleftleg(localclientnum, body);
    }
    if(isDefined(body) && _hasgibdef(body) && body.archetype == "human") {
      if(randomint(100) >= 50) {
        continue;
      }
      if(isDefined(origin) && distancesquared(body.origin, origin) <= 14400) {
        body.ignoreragdoll = 1;
        body _gibentity(localclientnum, 50 | 384, 1);
      }
    }
  }
}

function private _clonegibdata(localclientnum, entity, clone) {
  clone.gib_data = spawnStruct();
  clone.gib_data.gib_state = entity.gib_state;
  clone.gib_data.gibdef = entity.gibdef;
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

function private _getgibdef(entity) {
  if(entity isPlayer() || entity isplayercorpse()) {
    return entity getplayergibdef();
  }
  if(isDefined(entity.gib_data)) {
    return entity.gib_data.gibdef;
  }
  return entity.gibdef;
}

function private _getgibbedstate(localclientnum, entity) {
  if(isDefined(entity.gib_data) && isDefined(entity.gib_data.gib_state)) {
    return entity.gib_data.gib_state;
  }
  if(isDefined(entity.gib_state)) {
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
  }
  if(rightleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
  }
  if(leftleggibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
  }
  return (isDefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1);
}

function private _getgibextramodel(localclientnumm, entity, gibflag) {
  if(gibflag == 4) {
    return (isDefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
  }
  if(gibflag == 8) {
    return (isDefined(entity.gib_data) ? entity.gib_data.head : entity.head);
  }
  assertmsg("");
}

function private _getgibbedtorsomodel(localclientnum, entity) {
  gibstate = _getgibbedstate(localclientnum, entity);
  rightarmgibbed = gibstate & 16;
  leftarmgibbed = gibstate & 32;
  if(rightarmgibbed && leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  }
  if(rightarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
  }
  if(leftarmgibbed) {
    return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
  }
  return (isDefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1);
}

function private _gibpiecetag(localclientnum, entity, gibflag) {
  if(!_hasgibdef(self)) {
    return;
  }
  gibbundle = struct::get_script_bundle("gibcharacterdef", _getgibdef(entity));
  gibpiece = gibbundle.gibs[gibflag];
  if(isDefined(gibpiece)) {
    return gibpiece.gibfxtag;
  }
}

function private _gibentity(localclientnum, gibflags, shouldspawngibs) {
  entity = self;
  if(!_hasgibdef(entity)) {
    return;
  }
  currentgibflag = 2;
  gibdir = undefined;
  if(entity isPlayer() || entity isplayercorpse()) {
    yaw_bits = (gibflags >> 9) &(8 - 1);
    yaw = getanglefrombits(yaw_bits, 3);
    gibdir = anglesToForward((0, yaw, 0));
  }
  gibbundle = struct::get_script_bundle("gibcharacterdef", _getgibdef(entity));
  while(gibflags >= currentgibflag) {
    if(gibflags &currentgibflag) {
      gibpiece = gibbundle.gibs[currentgibflag];
      if(isDefined(gibpiece)) {
        if(shouldspawngibs) {
          entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir);
        }
        _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
        _playgibsound(localclientnum, entity, gibpiece.gibsound);
        if(currentgibflag == 2) {
          entity hide();
          entity.ignoreragdoll = 1;
        }
      }
      _handlegibcallbacks(localclientnum, entity, currentgibflag);
    }
    currentgibflag = currentgibflag << 1;
  }
}

function private _setgibbed(localclientnum, entity, gibflag) {
  gib_state = _getgibbedstate(localclientnum, entity) | (gibflag &(512 - 1));
  if(isDefined(entity.gib_data)) {
    entity.gib_data.gib_state = gib_state;
  } else {
    entity.gib_state = gib_state;
  }
}

function private _gibcliententityinternal(localclientnum, entity, gibflag) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }
  if(!isDefined(entity) || !_hasgibdef(entity)) {
    return;
  }
  if(entity.type !== "scriptmover") {
    return;
  }
  if(isgibbed(localclientnum, entity, gibflag)) {
    return;
  }
  if(!_getgibbedstate(localclientnum, entity) < 16) {
    legmodel = _getgibbedlegmodel(localclientnum, entity);
    entity detach(legmodel, "");
  }
  _setgibbed(localclientnum, entity, gibflag);
  entity setModel(_getgibbedtorsomodel(localclientnum, entity));
  entity attach(_getgibbedlegmodel(localclientnum, entity), "");
  entity _gibentity(localclientnum, gibflag, 1);
}

function private _gibclientextrainternal(localclientnum, entity, gibflag) {
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
    if(isDefined((isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5))) {
      entity attach((isDefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5), "");
    }
  }
  _setgibbed(localclientnum, entity, gibflag);
  entity _gibentity(localclientnum, gibflag, 1);
}

function private _gibhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(entity isPlayer() || entity isplayercorpse()) {
    if(!util::is_mature() || util::is_gib_restricted_build()) {
      return;
    }
  } else {
    if(isDefined(entity.maturegib) && entity.maturegib && !util::is_mature()) {
      return;
    }
    if(isDefined(entity.restrictedgib) && entity.restrictedgib && !isshowgibsenabled()) {
      return;
    }
  }
  gibflags = oldvalue ^ newvalue;
  shouldspawngibs = !newvalue & 1;
  if(bnewent) {
    gibflags = 0 ^ newvalue;
  }
  entity _gibentity(localclientnum, gibflags, shouldspawngibs);
  entity.gib_state = newvalue;
}

function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir) {
  if(!isDefined(gibtag) || !isDefined(gibmodel)) {
    return;
  }
  startposition = entity gettagorigin(gibtag);
  startangles = entity gettagangles(gibtag);
  endposition = startposition;
  endangles = startangles;
  forwardvector = undefined;
  if(!isDefined(startposition) || !isDefined(startangles)) {
    return false;
  }
  if(isDefined(gibdir)) {
    startposition = (0, 0, 0);
    forwardvector = gibdir;
    forwardvector = forwardvector * randomfloatrange(100, 500);
  } else {
    wait(0.016);
    if(isDefined(entity)) {
      endposition = entity gettagorigin(gibtag);
      endangles = entity gettagangles(gibtag);
    } else {
      endposition = startposition + (anglesToForward(startangles) * 10);
      endangles = startangles;
    }
    if(!isDefined(endposition) || !isDefined(endangles)) {
      return false;
    }
    forwardvector = vectornormalize(endposition - startposition);
    forwardvector = forwardvector * randomfloatrange(0.6, 1);
    forwardvector = forwardvector + (randomfloatrange(0, 0.2), randomfloatrange(0, 0.2), randomfloatrange(0.2, 0.7));
  }
  if(isDefined(entity)) {
    gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1);
    if(isDefined(gibentity)) {
      setdynentbodyrenderoptionspacked(gibentity, entity getbodyrenderoptionspacked());
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
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibannihilate(localclientnum, entity);
}

function private _handlegibhead(localclientnum) {
  entity = self;
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibhead(localclientnum, entity);
}

function private _handlegibrightarm(localclientnum) {
  entity = self;
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibrightarm(localclientnum, entity);
}

function private _handlegibleftarm(localclientnum) {
  entity = self;
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibleftarm(localclientnum, entity);
}

function private _handlegibrightleg(localclientnum) {
  entity = self;
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibrightleg(localclientnum, entity);
}

function private _handlegibleftleg(localclientnum) {
  entity = self;
  entity endon("entityshutdown");
  entity waittillmatch("_anim_notify_");
  cliententgibleftleg(localclientnum, entity);
}

function private _hasgibdef(entity) {
  return isDefined(entity.gib_data) && isDefined(entity.gib_data.gibdef) || isDefined(entity.gibdef) || entity getplayergibdef() != "unknown";
}

function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
  if(isDefined(fxfilename) && isDefined(fxtag) && entity hasdobj(localclientnum)) {
    fx = playFXOnTag(localclientnum, fxfilename, entity, fxtag);
    if(isDefined(fx)) {
      if(isDefined(entity.team)) {
        setfxteam(localclientnum, fx, entity.team);
      }
      if(isDefined(level.setgibfxtoignorepause) && level.setgibfxtoignorepause) {
        setfxignorepause(localclientnum, fx, 1);
      }
    }
    return fx;
  }
}

function _playgibsound(localclientnum, entity, soundalias) {
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
  entity _gibentity(localclientnum, 50 | 384, 1);
}

function cliententgibhead(localclientnum, entity) {
  _gibclientextrainternal(localclientnum, entity, 4);
  _gibclientextrainternal(localclientnum, entity, 8);
}

function cliententgibleftarm(localclientnum, entity) {
  if(isgibbed(localclientnum, entity, 16)) {
    return;
  }
  _gibcliententityinternal(localclientnum, entity, 32);
}

function cliententgibrightarm(localclientnum, entity) {
  if(isgibbed(localclientnum, entity, 32)) {
    return;
  }
  _gibcliententityinternal(localclientnum, entity, 16);
}

function cliententgibleftleg(localclientnum, entity) {
  _gibcliententityinternal(localclientnum, entity, 256);
}

function cliententgibrightleg(localclientnum, entity) {
  _gibcliententityinternal(localclientnum, entity, 128);
}

function createscriptmodelofentity(localclientnum, entity) {
  clone = spawn(localclientnum, entity.origin, "script_model");
  clone.angles = entity.angles;
  _clonegibdata(localclientnum, entity, clone);
  gibstate = _getgibbedstate(localclientnum, clone);
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    gibstate = 0;
  }
  if(!_getgibbedstate(localclientnum, entity) < 16) {
    clone setModel(_getgibbedtorsomodel(localclientnum, entity));
    clone attach(_getgibbedlegmodel(localclientnum, entity), "");
  } else {
    clone setModel(entity.model);
  }
  if(gibstate & 8) {
    if(isDefined((isDefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5))) {
      clone attach((isDefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5), "");
    }
  } else {
    if(isDefined((isDefined(clone.gib_data) ? clone.gib_data.head : clone.head))) {
      clone attach((isDefined(clone.gib_data) ? clone.gib_data.head : clone.head), "");
    }
    if(!gibstate & 4 && isDefined((isDefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel))) {
      clone attach((isDefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel), "");
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

function gibentity(localclientnum, gibflags) {
  self _gibentity(localclientnum, gibflags, 1);
  self.gib_state = _getgibbedstate(localclientnum, self) | (gibflags &(512 - 1));
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

function playergibleftarm(localclientnum) {
  self gibentity(localclientnum, 32);
}

function playergibrightarm(localclientnum) {
  self gibentity(localclientnum, 16);
}

function playergibleftleg(localclientnum) {
  self gibentity(localclientnum, 256);
}

function playergibrightleg(localclientnum) {
  self gibentity(localclientnum, 128);
}

function playergiblegs(localclientnum) {
  self gibentity(localclientnum, 128);
  self gibentity(localclientnum, 256);
}

function playergibtag(localclientnum, gibflag) {
  return _gibpiecetag(localclientnum, self, gibflag);
}