/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\destructible_character.csc
*************************************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace destructclientutils;

autoexec __init__system__() {
  system::register(#"destructible_character", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "destructible_character_state", 1, 21, "int", &_destructhandler, 0, 0);
  destructibles = struct::get_script_bundles("destructiblecharacterdef");
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
      piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
      piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");

      if(isDefined(destructible.("piece" + index + "_gibdirX")) || isDefined(destructible.("piece" + index + "_gibdirY")) || isDefined(destructible.("piece" + index + "_gibdirZ"))) {
        piecestruct.gibdir = (isDefined(destructible.("piece" + index + "_gibdirX")) ? destructible.("piece" + index + "_gibdirX") : 0, isDefined(destructible.("piece" + index + "_gibdirY")) ? destructible.("piece" + index + "_gibdirY") : 0, isDefined(destructible.("piece" + index + "_gibdirZ")) ? destructible.("piece" + index + "_gibdirZ") : 0);
      }

      piecestruct.gibdirscale = destructible.("piece" + index + "_gibdirscale");
      piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
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

private _getdestructibledef(entity) {
  return level.destructiblecharacterdefs[entity.destructibledef];
}

private _destructhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }

  entity = self;
  destructflags = oldvalue ^ newvalue;
  shouldspawngibs = newvalue&1;

  if(bnewent) {
    destructflags = 0 ^ newvalue;
  }

  if(!isDefined(entity.destructibledef)) {
    return;
  }

  currentdestructflag = 2;

  for(piecenumber = 1; destructflags >= currentdestructflag; piecenumber++) {
    if(destructflags&currentdestructflag) {
      _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs);
    }

    currentdestructflag <<= 1;
  }

  entity._destruct_state = newvalue;
}

private _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }

  destructbundle = _getdestructibledef(entity);
  piece = destructbundle.pieces[piecenumber - 1];

  if(isDefined(piece)) {
    if(shouldspawngibs) {
      gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
      entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx, piece.gibdir, piece.gibdirscale, 1 | 2 | 4);
      gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
    } else if(isDefined(piece.gibfx) && function_9229eb67(piece.gibfx)) {
      gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
    }

    _handledestructcallbacks(localclientnum, entity, piecenumber);
  }
}

private _getdestructstate(localclientnum, entity) {
  if(isDefined(entity._destruct_state)) {
    return entity._destruct_state;
  }

  return 0;
}

private _handledestructcallbacks(localclientnum, entity, piecenumber) {
  if(isDefined(entity._destructcallbacks) && isDefined(entity._destructcallbacks[piecenumber])) {
    foreach(callback in entity._destructcallbacks[piecenumber]) {
      if(isfunctionptr(callback)) {
        [
          [callback]
        ](localclientnum, entity, piecenumber);
      }
    }
  }
}

adddestructpiececallback(localclientnum, entity, piecenumber, callbackfunction) {
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

ispiecedestructed(localclientnum, entity, piecenumber) {
  return _getdestructstate(localclientnum, entity)&1 << piecenumber;
}