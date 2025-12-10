/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\destructible_character.gsc
********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#namespace destructible_character;

function autoexec main() {
  clientfield::register("actor", "destructible_character_state", 1, 21, "int");
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

#namespace destructserverutils;

function private _getdestructstate(entity) {
  if(isDefined(entity._destruct_state)) {
    return entity._destruct_state;
  }
  return 0;
}

function private _setdestructed(entity, destructflag) {
  entity._destruct_state = _getdestructstate(entity) | destructflag;
  entity clientfield::set("destructible_character_state", entity._destruct_state);
}

function copydestructstate(originalentity, newentity) {
  newentity._destruct_state = _getdestructstate(originalentity);
  togglespawngibs(newentity, 0);
  reapplydestructedpieces(newentity);
}

function destructhitlocpieces(entity, hitloc) {
  if(isDefined(entity.destructibledef)) {
    destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
    for(index = 1; index <= destructbundle.pieces.size; index++) {
      piece = destructbundle.pieces[index - 1];
      if(isDefined(piece.hitlocation) && piece.hitlocation == hitloc) {
        destructpiece(entity, index);
      }
    }
  }
}

function destructleftarmpieces(entity) {
  destructhitlocpieces(entity, "left_arm_upper");
  destructhitlocpieces(entity, "left_arm_lower");
  destructhitlocpieces(entity, "left_hand");
}

function destructleftlegpieces(entity) {
  destructhitlocpieces(entity, "left_leg_upper");
  destructhitlocpieces(entity, "left_leg_lower");
  destructhitlocpieces(entity, "left_foot");
}

function destructpiece(entity, piecenumber) {
  /
  #
  assert(1 <= piecenumber && piecenumber <= 20);
  if(isdestructed(entity, piecenumber)) {
    return;
  }
  _setdestructed(entity, 1 << piecenumber);
  if(!isDefined(entity.destructibledef)) {
    return;
  }
  destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
  piece = destructbundle.pieces[piecenumber - 1];
  if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
    entity hidepart(piece.hidetag);
  }
  if(isDefined(piece.detachmodel)) {
    entity detach(piece.detachmodel, "");
  }
}

function destructnumberrandompieces(entity, num_pieces_to_destruct = 0) {
  destructible_pieces_list = [];
  destructablepieces = getpiececount(entity);
  if(num_pieces_to_destruct == 0) {
    num_pieces_to_destruct = destructablepieces;
  }
  for(i = 0; i < destructablepieces; i++) {
    destructible_pieces_list[i] = i + 1;
  }
  destructible_pieces_list = array::randomize(destructible_pieces_list);
  foreach(piece in destructible_pieces_list) {
    if(!isdestructed(entity, piece)) {
      destructpiece(entity, piece);
      num_pieces_to_destruct--;
      if(num_pieces_to_destruct == 0) {
        break;
      }
    }
  }
}

function destructrandompieces(entity) {
  destructpieces = getpiececount(entity);
  for(index = 0; index < destructpieces; index++) {
    if(math::cointoss()) {
      destructpiece(entity, index + 1);
    }
  }
}

function destructrightarmpieces(entity) {
  destructhitlocpieces(entity, "right_arm_upper");
  destructhitlocpieces(entity, "right_arm_lower");
  destructhitlocpieces(entity, "right_hand");
}

function destructrightlegpieces(entity) {
  destructhitlocpieces(entity, "right_leg_upper");
  destructhitlocpieces(entity, "right_leg_lower");
  destructhitlocpieces(entity, "right_foot");
}

function getpiececount(entity) {
  if(isDefined(entity.destructibledef)) {
    destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
    if(isDefined(destructbundle)) {
      return destructbundle.piececount;
    }
  }
  return 0;
}

function handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  entity = self;
  if(isDefined(entity.skipdeath) && entity.skipdeath) {
    return idamage;
  }
  if(isDefined(entity.var_132756fd) && entity.var_132756fd) {
    return idamage;
  }
  togglespawngibs(entity, 1);
  destructhitlocpieces(entity, shitloc);
  return idamage;
}

function isdestructed(entity, piecenumber) {
  /
  #
  assert(1 <= piecenumber && piecenumber <= 20);
  return _getdestructstate(entity) &(1 << piecenumber);
}

function reapplydestructedpieces(entity) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }
  destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
  for(index = 1; index <= destructbundle.pieces.size; index++) {
    if(!isdestructed(entity, index)) {
      continue;
    }
    piece = destructbundle.pieces[index - 1];
    if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
      entity hidepart(piece.hidetag);
    }
  }
}

function showdestructedpieces(entity) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }
  destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
  for(index = 1; index <= destructbundle.pieces.size; index++) {
    piece = destructbundle.pieces[index - 1];
    if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
      entity showpart(piece.hidetag);
    }
  }
}

function togglespawngibs(entity, shouldspawngibs) {
  if(shouldspawngibs) {
    entity._destruct_state = _getdestructstate(entity) | 1;
  } else {
    entity._destruct_state = _getdestructstate(entity) &-2;
  }
  entity clientfield::set("destructible_character_state", entity._destruct_state);
}