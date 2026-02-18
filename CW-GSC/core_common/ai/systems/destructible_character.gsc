/*************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\destructible_character.gsc
*************************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#namespace destructserverutils;

function private autoexec __init__system__() {
  system::register(#"destructible_character", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "destructible_character_state", 1, 21, "int");
  destructibles = getscriptbundles("destructiblecharacterdef");
  processedbundles = [];

  foreach(destructible in destructibles) {
    destructbundle = spawnStruct();
    destructbundle.piececount = destructible.piececount;
    destructbundle.pieces = [];
    destructbundle.name = destructible.name;

    for(index = 1; index <= destructbundle.piececount; index++) {
      piecestruct = spawnStruct();
      piecestruct.name = destructible.("piece" + index + "_name");
      piecestruct.gibmodel = destructible.("piece" + index + "_gibmodel");
      piecestruct.gibtag = destructible.("piece" + index + "_gibtag");
      piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
      piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");
      piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
      piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
      piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
      piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
      piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");
      piecestruct.detachtag = destructible.("piece" + index + "_detachtag");

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

      if(isDefined(destructible.("piece" + index + "_additionalhitlocations"))) {
        piecestruct.hittags = [];

        foreach(var_9c2171bc in destructible.("piece" + index + "_additionalhitlocations")) {
          if(!isDefined(piecestruct.var_47627399)) {
            piecestruct.var_47627399 = [];
          } else if(!isarray(piecestruct.var_47627399)) {
            piecestruct.var_47627399 = array(piecestruct.var_47627399);
          }

          piecestruct.var_47627399[piecestruct.var_47627399.size] = var_9c2171bc.hitlocation;
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

function getdestructstate(entity) {
  if(isDefined(entity._destruct_state)) {
    return entity._destruct_state;
  }

  return 0;
}

function function_f865501b(entity, var_e9807706, var_9cea16fe) {
  entity._destruct_state = var_e9807706;
  togglespawngibs(entity, var_9cea16fe);
  reapplydestructedpieces(entity);
}

function private _setdestructed(entity, destructflag) {
  entity._destruct_state = getdestructstate(entity) | destructflag;
  entity clientfield::set("destructible_character_state", entity._destruct_state);
}

function copydestructstate(originalentity, newentity) {
  newentity._destruct_state = getdestructstate(originalentity);
  togglespawngibs(newentity, 0);
  reapplydestructedpieces(newentity);
}

function function_8475c53a(entity, piecename) {
  if(isDefined(entity.destructibledef)) {
    destructbundle = _getdestructibledef(entity);

    for(index = 1; index <= destructbundle.pieces.size; index++) {
      piece = destructbundle.pieces[index - 1];

      if(isDefined(piece.name) && piece.name == piecename) {
        destructpiece(entity, index);
      }
    }
  }
}

function destructhitlocpieces(entity, hitloc) {
  if(isDefined(entity.destructibledef)) {
    destructbundle = _getdestructibledef(entity);

    for(index = 1; index <= destructbundle.pieces.size; index++) {
      piece = destructbundle.pieces[index - 1];

      if(isDefined(piece.hitlocation) && piece.hitlocation === hitloc || isDefined(piece.var_47627399) && isinarray(piece.var_47627399, hitloc)) {
        destructpiece(entity, index);
      }
    }
  }
}

function function_629a8d54(entity, hittag) {
  if(isDefined(hittag) && isDefined(entity.destructibledef)) {
    destructbundle = _getdestructibledef(entity);

    for(index = 1; index <= destructbundle.pieces.size; index++) {
      piece = destructbundle.pieces[index - 1];

      if(isDefined(piece.hittags) && isinarray(piece.hittags, hittag)) {
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
  assert(1 <= piecenumber && piecenumber <= 20);

  if(isdestructed(entity, piecenumber)) {
    return;
  }

  _setdestructed(entity, 1 << piecenumber);

  if(!isDefined(entity.destructibledef)) {
    return;
  }

  destructbundle = _getdestructibledef(entity);
  piece = destructbundle.pieces[piecenumber - 1];

  if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
    entity hidepart(piece.hidetag);
  }

  if(isDefined(piece.detachmodel) && entity isattached(piece.detachmodel)) {
    detachtag = "";

    if(isDefined(piece.detachtag)) {
      detachtag = piece.detachtag;
    }

    entity detach(piece.detachmodel, detachtag);
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
    destructbundle = _getdestructibledef(entity);

    if(isDefined(destructbundle)) {
      return destructbundle.piececount;
    }
  }

  return 0;
}

function handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, var_a9e3f040, modelindex) {
  entity = self;

  if(is_true(entity.skipdeath)) {
    return psoffsettime;
  }

  togglespawngibs(entity, 1);
  destructhitlocpieces(entity, var_a9e3f040);

  if(isDefined(modelindex)) {
    bonename = modelindex;

    if(!isstring(modelindex)) {
      bonename = getpartname(entity, modelindex);
    }

    if(isDefined(bonename)) {
      function_629a8d54(entity, bonename);
    }
  }

  return psoffsettime;
}

function function_9885f550(entity, hitloc, var_a9e3f040) {
  togglespawngibs(entity, 1);
  destructhitlocpieces(entity, hitloc);

  if(isDefined(var_a9e3f040)) {
    bonename = var_a9e3f040;

    if(!isstring(var_a9e3f040)) {
      bonename = getpartname(entity, var_a9e3f040);
    }

    if(isDefined(bonename)) {
      function_629a8d54(entity, bonename);
    }
  }
}

function isdestructed(entity, piecenumber) {
  assert(1 <= piecenumber && piecenumber <= 20);
  return getdestructstate(entity) & 1 << piecenumber;
}

function reapplydestructedpieces(entity) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }

  destructbundle = _getdestructibledef(entity);

  for(index = 1; index <= destructbundle.pieces.size; index++) {
    if(!isdestructed(entity, index)) {
      continue;
    }

    piece = destructbundle.pieces[index - 1];

    if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
      entity hidepart(piece.hidetag);
    }

    if(isDefined(piece.detachmodel)) {
      detachtag = "";

      if(isDefined(piece.detachtag)) {
        detachtag = piece.detachtag;
      }

      if(entity isattached(piece.detachmodel, detachtag)) {
        entity detach(piece.detachmodel, detachtag);
      }
    }
  }
}

function showdestructedpieces(entity) {
  if(!isDefined(entity.destructibledef)) {
    return;
  }

  destructbundle = _getdestructibledef(entity);

  for(index = 1; index <= destructbundle.pieces.size; index++) {
    piece = destructbundle.pieces[index - 1];

    if(isDefined(piece.hidetag) && entity haspart(piece.hidetag)) {
      entity showpart(piece.hidetag);
    }
  }
}

function togglespawngibs(entity, shouldspawngibs) {
  if(shouldspawngibs) {
    entity._destruct_state = getdestructstate(entity) | 1;
  } else {
    entity._destruct_state = getdestructstate(entity) &-2;
  }

  entity clientfield::set("destructible_character_state", entity._destruct_state);
}