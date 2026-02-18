/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\fx_character.csc
***************************************************/

#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\struct;
#namespace fx_character;

function autoexec main() {
  fxbundles = getscriptbundles("fxcharacterdef");
  processedfxbundles = [];

  foreach(fxbundle in fxbundles) {
    effectcount = isDefined(fxbundle.effectcount) ? fxbundle.effectcount : 0;
    processedfxbundle = spawnStruct();
    processedfxbundle.effectcount = effectcount;
    processedfxbundle.fx = [];
    processedfxbundle.name = fxbundle.name;

    for(index = 1; index <= effectcount; index++) {
      fx = fxbundle.("effect" + index + "_fx");

      if(isDefined(fx)) {
        fxstruct = spawnStruct();
        fxstruct.attachtag = fxbundle.("effect" + index + "_attachtag");
        fxstruct.fx = fxbundle.("effect" + index + "_fx");
        fxstruct.stopongib = fxclientutils::_gibpartnametogibflag(fxbundle.("effect" + index + "_stopongib"));
        fxstruct.stoponpiecedestroyed = fxbundle.("effect" + index + "_stoponpiecedestroyed");
        processedfxbundle.fx[processedfxbundle.fx.size] = fxstruct;
      }
    }

    processedfxbundles[fxbundle.name] = processedfxbundle;
  }

  level.fxcharacterdefs = processedfxbundles;
}

#namespace fxclientutils;

function private _getfxbundle(name) {
  return level.fxcharacterdefs[name];
}

function private _configentity(localclientnum, entity) {
  if(!isDefined(entity._fxcharacter)) {
    entity._fxcharacter = [];
    handledgibs = array(8, 16, 32, 128, 256);

    foreach(gibflag in handledgibs) {
      gibclientutils::addgibcallback(localclientnum, entity, gibflag, &_gibhandler);
    }

    for(index = 1; index <= 20; index++) {
      destructclientutils::adddestructpiececallback(localclientnum, entity, index, &_destructhandler);
    }
  }
}

function private _destructhandler(localclientnum, entity, piecenumber) {
  if(!isDefined(entity._fxcharacter)) {
    return;
  }

  foreach(fxbundlename, fxbundleinst in entity._fxcharacter) {
    fxbundle = _getfxbundle(fxbundlename);

    for(index = 0; index < fxbundle.fx.size; index++) {
      if(isDefined(fxbundleinst[index]) && fxbundle.fx[index].stoponpiecedestroyed === piecenumber) {
        stopfx(localclientnum, fxbundleinst[index]);
        fxbundleinst[index] = undefined;
      }
    }
  }
}

function private _gibhandler(localclientnum, entity, gibflag) {
  if(!isDefined(entity._fxcharacter)) {
    return;
  }

  foreach(fxbundlename, fxbundleinst in entity._fxcharacter) {
    fxbundle = _getfxbundle(fxbundlename);

    for(index = 0; index < fxbundle.fx.size; index++) {
      if(isDefined(fxbundleinst[index]) && fxbundle.fx[index].stopongib === gibflag) {
        stopfx(localclientnum, fxbundleinst[index]);
        fxbundleinst[index] = undefined;
      }
    }
  }
}

function private _gibpartnametogibflag(gibpartname) {
  if(isDefined(gibpartname)) {
    switch (gibpartname) {
      case # "head":
        return 8;
      case # "right arm":
        return 16;
      case # "left arm":
        return 32;
      case # "right leg":
        return 128;
      case # "left leg":
        return 256;
    }
  }
}

function private _isgibbed(localclientnum, entity, stopongibflag) {
  if(!isDefined(stopongibflag)) {
    return 0;
  }

  return gibclientutils::isgibbed(localclientnum, entity, stopongibflag);
}

function private _ispiecedestructed(localclientnum, entity, stoponpiecedestroyed) {
  if(!isDefined(stoponpiecedestroyed)) {
    return 0;
  }

  return destructclientutils::ispiecedestructed(localclientnum, entity, stoponpiecedestroyed);
}

function private _shouldplayFX(localclientnum, entity, fxstruct) {
  if(_isgibbed(localclientnum, entity, fxstruct.stopongib)) {
    return false;
  }

  if(_ispiecedestructed(localclientnum, entity, fxstruct.stoponpiecedestroyed)) {
    return false;
  }

  return true;
}

function playfxbundle(localclientnum, entity, fxscriptbundle) {
  if(!isDefined(entity) || !isDefined(fxscriptbundle)) {
    return;
  }

  _configentity(localclientnum, entity);
  fxbundle = _getfxbundle(fxscriptbundle);

  if(isDefined(entity._fxcharacter[fxbundle.name])) {
    return;
  }

  if(isDefined(fxbundle)) {
    playingfx = [];

    for(index = 0; index < fxbundle.fx.size; index++) {
      fxstruct = fxbundle.fx[index];

      if(_shouldplayFX(localclientnum, entity, fxstruct)) {
        playingfx[index] = gibclientutils::_playgibfx(localclientnum, entity, fxstruct.fx, fxstruct.attachtag);
      }
    }

    if(playingfx.size > 0) {
      entity._fxcharacter[fxbundle.name] = playingfx;
    }
  }
}

function stopallfxbundles(localclientnum, entity) {
  _configentity(localclientnum, entity);
  fxbundlenames = [];

  foreach(fxbundlename, fxbundle in entity._fxcharacter) {
    fxbundlenames[fxbundlenames.size] = fxbundlename;
  }

  foreach(fxbundlename in fxbundlenames) {
    stopfxbundle(localclientnum, entity, fxbundlename);
  }
}

function stopfxbundle(localclientnum, entity, fxscriptbundle) {
  if(!isDefined(fxscriptbundle)) {
    return;
  }

  _configentity(localclientnum, entity);
  fxbundle = _getfxbundle(fxscriptbundle);

  if(isDefined(entity._fxcharacter[fxbundle.name])) {
    foreach(fx in entity._fxcharacter[fxbundle.name]) {
      if(isDefined(fx)) {
        stopfx(localclientnum, fx);
      }
    }

    entity._fxcharacter[fxbundle.name] = undefined;
  }
}

function function_ae92446(localclientnum, entity, fxscriptbundle) {
  if(!isDefined(fxscriptbundle)) {
    return;
  }

  _configentity(localclientnum, entity);
  fxbundle = _getfxbundle(fxscriptbundle);

  if(isDefined(entity._fxcharacter[fxbundle.name])) {
    foreach(fx in entity._fxcharacter[fxbundle.name]) {
      if(isDefined(fx)) {
        killfx(localclientnum, fx);
      }
    }

    entity._fxcharacter[fxbundle.name] = undefined;
  }
}