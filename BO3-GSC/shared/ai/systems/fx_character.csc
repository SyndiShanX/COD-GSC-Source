/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\fx_character.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;
#namespace fx_character;

function autoexec main() {
  fxbundles = struct::get_script_bundles("fxcharacterdef");
  processedfxbundles = [];
  foreach(fxbundlename, fxbundle in fxbundles) {
    processedfxbundle = spawnStruct();
    processedfxbundle.effectcount = fxbundle.effectcount;
    processedfxbundle.fx = [];
    processedfxbundle.name = fxbundlename;
    for(index = 1; index <= fxbundle.effectcount; index++) {
      fx = getstructfield(fxbundle, ("effect" + index) + "_fx");
      if(isDefined(fx)) {
        fxstruct = spawnStruct();
        fxstruct.attachtag = getstructfield(fxbundle, ("effect" + index) + "_attachtag");
        fxstruct.fx = getstructfield(fxbundle, ("effect" + index) + "_fx");
        fxstruct.stopongib = fxclientutils::_gibpartnametogibflag(getstructfield(fxbundle, ("effect" + index) + "_stopongib"));
        fxstruct.stoponpiecedestroyed = getstructfield(fxbundle, ("effect" + index) + "_stoponpiecedestroyed");
        processedfxbundle.fx[processedfxbundle.fx.size] = fxstruct;
      }
    }
    processedfxbundles[fxbundlename] = processedfxbundle;
  }
  level.scriptbundles["fxcharacterdef"] = processedfxbundles;
}

#namespace fxclientutils;

function private _configentity(localclientnum, entity) {
  if(!isDefined(entity._fxcharacter)) {
    entity._fxcharacter = [];
    handledgibs = array(8, 16, 32, 128, 256);
    foreach(gibflag in handledgibs) {
      gibclientutils::addgibcallback(localclientnum, entity, gibflag, & _gibhandler);
    }
    for(index = 1; index <= 20; index++) {
      destructclientutils::adddestructpiececallback(localclientnum, entity, index, & _destructhandler);
    }
  }
}

function private _destructhandler(localclientnum, entity, piecenumber) {
  if(!isDefined(entity._fxcharacter)) {
    return;
  }
  foreach(fxbundlename, fxbundleinst in entity._fxcharacter) {
    fxbundle = struct::get_script_bundle("fxcharacterdef", fxbundlename);
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
    fxbundle = struct::get_script_bundle("fxcharacterdef", fxbundlename);
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
      case "head": {
        return 8;
      }
      case "right arm": {
        return 16;
      }
      case "left arm": {
        return 32;
      }
      case "right leg": {
        return 128;
      }
      case "left leg": {
        return 256;
      }
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
  if(!isDefined(fxscriptbundle)) {
    return;
  }
  _configentity(localclientnum, entity);
  fxbundle = struct::get_script_bundle("fxcharacterdef", fxscriptbundle);
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
  fxbundle = struct::get_script_bundle("fxcharacterdef", fxscriptbundle);
  if(isDefined(entity._fxcharacter[fxbundle.name])) {
    foreach(fx in entity._fxcharacter[fxbundle.name]) {
      if(isDefined(fx)) {
        stopfx(localclientnum, fx);
      }
    }
    entity._fxcharacter[fxbundle.name] = undefined;
  }
}