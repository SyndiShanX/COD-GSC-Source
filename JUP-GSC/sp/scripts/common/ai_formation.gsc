/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ai_formation.gsc
***********************************************/



#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ai_formation;

function init_formations() {
  if(!isDefined(level.formationlist)) {
    level.formationlist = [];
  }
}

function function_a18d80bcfacb9e00(formationname, formationtype) {
  if(!isDefined(level.formationlist)) {
    init_formations();
  }

  if(isDefined(level.formationlist[formationname])) {
    return level.formationlist[formationname];
  }

  assertex(formationtype >= 0 && formationtype < 4, "Invalid formation type of " + formationtype);
  level.formationlist[formationname] = newaiformation(formationtype);
  return level.formationlist[formationname];
}

function delete_formation(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  deleteaiformation(level.formationlist[formationname]);
  level.formationlist[formationname] = undefined;
}

function function_73d6d4ee28a18071(formationname, aitoadd, formationtype) {
  if(!isDefined(formationtype)) {
    formationtype = 3;
  }

  if(!isDefined(level.formationlist)) {
    init_formations();
  }

  if(!isDefined(level.formationlist[formationname])) {
    function_a18d80bcfacb9e00(formationname, formationtype);
  }

  if(isarray(aitoadd)) {
    foreach(ai in aitoadd) {
      ai enter_formation(level.formationlist[formationname]);
    }

    return;
  }

  aitoadd enter_formation(level.formationlist[formationname]);
}

function function_98e62e94c2b167e0(formationname, horizontalcount, verticalcount, horizontalseparation, verticalseparation, leaderinfront) {
  if(!isDefined(leaderinfront)) {
    leaderinfront = 0;
  }

  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  mid = floor(horizontalcount / 2);
  offsetcount = 1;

  for(verticalindex = 0; verticalindex < verticalcount; verticalindex++) {
    for(horizontalindex = 0; horizontalindex < horizontalcount; horizontalindex++) {
      if(!leaderinfront && verticalindex == 0 && horizontalindex == mid) {
        continue;
      }

      yoffset = horizontalseparation * -1 * (horizontalindex - mid);
      xoffset = verticalseparation * -1 * verticalindex;

      if(leaderinfront) {
        yoffset -= 0.5 * (horizontalcount - 1) % 2 * horizontalseparation;
        xoffset -= verticalseparation;
      }

      function_c412284514efc768(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
      offsetcount++;
    }
  }
}

function function_cf3f27c3c5266ee2(formationname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront) {
  if(!isDefined(leaderinfront)) {
    leaderinfront = 0;
  }

  if(!isDefined(level.formationlist[formationname])) {
    return 1;
  }

  if(numai <= 1) {
    return 1;
  }

  if(leaderinfront && formationshape != 1) {
    numai--;
  }

  switch (formationshape) {
    case 1:
      dimension = ceil((sqrt(8 * numai + 1) - 1) / 2);
      offsetcount = 1;

      for(verticalindex = 0; verticalindex < dimension; verticalindex++) {
        for(horizontalindex = 0; horizontalindex < verticalindex + 1; horizontalindex++) {
          if(verticalindex == 0 && horizontalindex == 0) {
            continue;
          }

          yoffset = horizontalseparation * (horizontalindex - verticalindex / 2);
          xoffset = verticalseparation * -1 * verticalindex;
          function_c412284514efc768(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
          offsetcount++;
        }
      }

      return ((dimension - 1) * horizontalseparation);
    case 2:
      mid = 0;
      horizontalcount = 1;
      verticalcount = numai;
      break;
    case 3:
      mid = 1;
      horizontalcount = 2;
      verticalcount = ceil(numai / horizontalcount);
      break;
    case 4:
      mid = 1;
      horizontalcount = 3;
      verticalcount = ceil(numai / horizontalcount);
      break;
    default:
      horizontalcount = ceil(sqrt(numai));
      verticalcount = ceil(numai / horizontalcount);
      mid = floor(horizontalcount / 2);
      break;
  }

  offsetcount = 1;

  for(verticalindex = 0; verticalindex < verticalcount; verticalindex++) {
    for(horizontalindex = 0; horizontalindex < horizontalcount; horizontalindex++) {
      if(!leaderinfront && verticalindex == 0 && horizontalindex == mid) {
        continue;
      }

      yoffset = horizontalseparation * -1 * (horizontalindex - mid);
      xoffset = verticalseparation * -1 * verticalindex;

      if(leaderinfront) {
        yoffset -= 0.5 * (horizontalcount - 1) % 2 * horizontalseparation;
        xoffset -= verticalseparation;
      }

      function_c412284514efc768(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
      offsetcount++;
    }
  }

  return (horizontalcount - 1) * horizontalseparation;
}

function function_e780688c49cc9549(formationname, customoffsetlist) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  assertex(customoffsetlist.size < 31, "Exceeding max number of formation offsets of " + 32 - 1 + " . Formation name of " + level.formationlist[formationname]);
  count = 1;

  foreach(offset in customoffsetlist) {
    function_c412284514efc768(level.formationlist[formationname], count, offset);
    count++;
  }
}

function function_bc785df299663d60(formationname, formationslot, customoffset) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  maxcount = 31;
  assertex(formationslot < maxcount && formationslot > 0, "Setting invalid formation slot custom offset, must be below " + maxcount + " and above 0. Formation name of " + level.formationlist[formationname]);
  function_c412284514efc768(level.formationlist[formationname], formationslot, customoffset);
}

function set_goal(formationname, goalposition) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  function_e29a9a1d854faa6a(level.formationlist[formationname], goalposition);
}

function leave_formation(aitoremove) {
  if(isarray(aitoremove)) {
    foreach(ai in aitoremove) {
      ai exit_formation();
    }

    return;
  }

  aitoremove exit_formation();
}

function follow_entity(formationname, ent, followdistance, timestep) {
  if(!isDefined(followdistance)) {
    followdistance = 100;
  }

  if(!isDefined(ent)) {
    return false;
  }

  if(!isDefined(level.formationlist[formationname])) {
    return false;
  }

  leader = get_leader(formationname);

  if(isDefined(leader)) {
    leader setgoalentity(ent);
    function_34c06b9933952e67(level.formationlist[formationname], followdistance);
    return true;
  }

  return false;
}

function function_5e8d7d93ecffa23f(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return false;
  }

  leader = get_leader(formationname);

  if(isDefined(leader)) {
    leader cleargoalentity();
    return true;
  }

  return false;
}

function get_leader(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return undefined;
  }

  return function_37a4bf80ea1cae75(level.formationlist[formationname]);
}

function function_679b2830741a1384(formationname) {
  formationid = level.formationlist[formationname];

  if(!isDefined(formationid)) {
    return;
  }

  self function_5ba70c95e357a4f9(formationid);
}

function private exit_formation() {
  if(istrue(self.information)) {
    self.information = 0;
    self function_fd663014f7eae161();
  }
}

function private enter_formation(formationid) {
  exit_formation();
  self.information = 1;
  self function_19ef30914f93393e(formationid);
}