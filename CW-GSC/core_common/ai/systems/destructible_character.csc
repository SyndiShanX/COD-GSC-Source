/*************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\destructible_character.csc
*************************************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace destructclientutils;

function private autoexec __init__system__() {
  system::register(#"destructible_character", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "destructible_character_state", 1, 21, "int", &_destructhandler, 0, 0);
  destructibles = getscriptbundles("destructiblecharacterdef");
  processedbundles = [];

  foreach(destructible in destructibles) {
    destructbundle = spawnStruct();
    destructbundle.piececount = destructible.piececount;
    destructbundle.pieces = [];
    destructbundle.name = destructible.name;

    for(index = 1; index <= destructbundle.piececount; index++) {
      piecestruct = spawnStruct();
      piecestruct.gibmodel = destructible.("piece" + index + "_gibmodel");
      piecestruct.gibtag = destructible.("piece" + index + "_gibtag");

      if(isDefined(destructible.("piece" + index + "_gibdirX")) || isDefined(destructible.("piece" + index + "_gibdirY")) || isDefined(destructible.("piece" + index + "_gibdirZ"))) {
        piecestruct.gibdir = (isDefined(destructible.("piece" + index + "_gibdirX")) ? destructible.("piece" + index + "_gibdirX") : 0, isDefined(destructible.("piece" + index + "_gibdirY")) ? destructible.("piece" + index + "_gibdirY") : 0, isDefined(destructible.("piece" + index + "_gibdirZ")) ? destructible.("piece" + index + "_gibdirZ") : 0);
      }

      piecestruct.gibdirscale = destructible.("piece" + index + "_gibdirscale");
      piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
      piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
      piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");
      piecestruct.var_ed372a00 = destructible.("piece" + index + "_gibfx2");
      piecestruct.var_e230b617 = destructible.("piece" + index + "_gibeffecttag2");
      piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
      piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
      piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
      piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");

      if(isDefined(destructible.("piece" + index + "_hittags"))) {
        piecestruct.hittags = [];

        foreach(var_5440c126 in destructible.("piece" + index + "_hittags")) {
          if(!isDefined(piecestruct.hittags)) {
            piecestruct.hittags = [];
          } else if(!isarray(piecestruct.hittags)) {
            piecestruct.hittags = array(piecestruct.hittags);
          }

          piecestruct.hittags[piecestruct.hittags.size] = var_5440c126.hittag;
        }
      }

      destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
    }

    processedbundles[destructible.name] = destructbundle;
  }

  level.destructiblecharacterdefs = processedbundles;
}

function private _getdestructibledef(entity) {
  return level.destructiblecharacterdefs[entity.destructibledef];
}

function private _destructhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }

  entity = self;
  destructflags = binitialsnap ^ fieldname;
  shouldspawngibs = fieldname & 1;

  if(wasdemojump) {
    destructflags = 0 ^ fieldname;
  }

  if(!isDefined(entity.destructibledef)) {
    return;
  }

  currentdestructflag = 2;

  for(piecenumber = 1; destructflags >= currentdestructflag; piecenumber++) {
    if(destructflags &currentdestructflag) {
      _destructpiece(bnewent, entity, piecenumber, shouldspawngibs);
    }

    currentdestructflag <<= 1;
  }

  entity._destruct_state = fieldname;
}

function private _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }

  destructbundle = _getdestructibledef(entity);
  piece = destructbundle.pieces[piecenumber - 1];

  if(isDefined(piece)) {
    if(shouldspawngibs) {
      gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
      gibclientutils::_playgibfx(localclientnum, entity, piece.var_ed372a00, piece.var_e230b617);
      entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx, piece.gibdir, piece.gibdirscale, 1 | 2 | 4);
      gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
    } else if(isDefined(piece.gibfx) && function_9229eb67(piece.gibfx)) {
      gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
    }

    _handledestructcallbacks(localclientnum, entity, piecenumber);
  }
}

function private _getdestructstate(localclientnum, entity) {
  if(isDefined(entity._destruct_state)) {
    return entity._destruct_state;
  }

  return 0;
}

function private _handledestructcallbacks(localclientnum, entity, piecenumber) {
  if(isDefined(entity._destructcallbacks) && isDefined(entity._destructcallbacks[piecenumber])) {
    foreach(callback in entity._destructcallbacks[piecenumber]) {
      if(isfunctionptr(callback)) {
        [[callback]](localclientnum, entity, piecenumber);
      }
    }
  }
}

function adddestructpiececallback(localclientnum, entity, piecenumber, callbackfunction) {
  assert(isfunctionptr(callbackfunction));

  if(!isDefined(entity._destructcallbacks)) {
    entity._destructcallbacks = [];
  }

  if(!isDefined(entity._destructcallbacks[piecenumber])) {
    entity._destructcallbacks[piecenumber] = [];
  }

  destructcallbacks = entity._destructcallbacks[piecenumber];
  destructcallbacks[destructcallbacks.size] = callbackfunction;
  entity._destructcallbacks[piecenumber] = destructcallbacks;
}

function ispiecedestructed(localclientnum, entity, piecenumber) {
  return _getdestructstate(localclientnum, entity) & 1 << piecenumber;
}