/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\destructible_character.csc
********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\clientfield_shared;
#namespace destructible_character;

function autoexec main() {
  clientfield::register("actor", "destructible_character_state", 1, 21, "int", &destructclientutils::_destructhandler, 0, 0);
  destructibles = struct::get_script_bundles("destructiblecharacterdef");
  processedbundles = [];
  foreach(destructiblename, destructible in destructibles) {
    destructbundle = spawnStruct();
    destructbundle.piececount = destructible.piececount;
    destructbundle.pieces = [];
    destructbundle.name = destructiblename;
    for(index = 1; index <= destructbundle.piececount; index++) {
      piecestruct = spawnStruct();
      piecestruct.gibmodel = getstructfield(destructible, ("piece" + index) + "_gibmodel");
      piecestruct.gibtag = getstructfield(destructible, ("piece" + index) + "_gibtag");
      piecestruct.gibfx = getstructfield(destructible, ("piece" + index) + "_gibfx");
      piecestruct.gibfxtag = getstructfield(destructible, ("piece" + index) + "_gibeffecttag");
      piecestruct.gibdynentfx = getstructfield(destructible, ("piece" + index) + "_gibdynentfx");
      piecestruct.gibsound = getstructfield(destructible, ("piece" + index) + "_gibsound");
      piecestruct.hitlocation = getstructfield(destructible, ("piece" + index) + "_hitlocation");
      piecestruct.hidetag = getstructfield(destructible, ("piece" + index) + "_hidetag");
      piecestruct.detachmodel = getstructfield(destructible, ("piece" + index) + "_detachmodel");
      destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
    }
    processedbundles[destructiblename] = destructbundle;
  }
  level.scriptbundles["destructiblecharacterdef"] = processedbundles;
}

#namespace destructclientutils;

function private _destructhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  destructflags = oldvalue ^ newvalue;
  shouldspawngibs = newvalue & 1;
  if(bnewent) {
    destructflags = 0 ^ newvalue;
  }
  if(!isDefined(entity.destructibledef)) {
    return;
  }
  currentdestructflag = 2;
  piecenumber = 1;
  while(destructflags >= currentdestructflag) {
    if(destructflags &currentdestructflag) {
      _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs);
    }
    currentdestructflag = currentdestructflag << 1;
    piecenumber++;
  }
  entity._destruct_state = newvalue;
}

function private _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }
  destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
  piece = destructbundle.pieces[piecenumber - 1];
  if(isDefined(piece)) {
    if(shouldspawngibs) {
      gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
      entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx);
      gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
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
  return _getdestructstate(localclientnum, entity) &(1 << piecenumber);
}