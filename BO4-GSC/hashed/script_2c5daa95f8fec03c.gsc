/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_2c5daa95f8fec03c.gsc
***********************************************/

#include scripts\core_common\array_shared;

#namespace namespace_81245006;

initweakpoints(entity, var_97e1b97d) {
  var_5ace757d = getscriptbundle(var_97e1b97d);

  if(!isDefined(var_5ace757d) || !isDefined(var_5ace757d.weakpoints)) {
    return;
  }

  entity.var_5ace757d = [];

  foreach(var_dd54fdb1 in var_5ace757d.weakpoints) {
    var_7c4db75f = structcopy(var_dd54fdb1);
    var_7c4db75f.currstate = 2;

    if(isDefined(var_dd54fdb1.activebydefault) && var_dd54fdb1.activebydefault) {
      var_7c4db75f.currstate = 1;
    }

    if(!(isDefined(var_dd54fdb1.absolutehealth) && var_dd54fdb1.absolutehealth)) {
      var_7c4db75f.health = var_dd54fdb1.health * entity.health;
    } else {
      var_7c4db75f.health = var_dd54fdb1.health;
    }

    var_7c4db75f.maxhealth = var_7c4db75f.health;
    var_7c4db75f.hittags = [];

    if(isDefined(var_dd54fdb1.var_51e8b151)) {
      array::add(var_7c4db75f.hittags, var_dd54fdb1.var_51e8b151);
    }

    if(isDefined(var_dd54fdb1.var_910e2f9b)) {
      array::add(var_7c4db75f.hittags, var_dd54fdb1.var_910e2f9b);
    }

    array::add(entity.var_5ace757d, var_7c4db75f);
  }
}

function_3131f5dd(entity, hitloc, weakpointstate) {
  if(!isDefined(hitloc)) {
    return undefined;
  }

  if(isDefined(entity.var_5ace757d)) {
    foreach(var_dd54fdb1 in entity.var_5ace757d) {
      if(isDefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
        continue;
      }

      if(var_dd54fdb1.hitloc === hitloc) {
        return var_dd54fdb1;
      }
    }
  }
}

function_73ab4754(entity, point, weakpointstate) {
  if(!isDefined(point)) {
    return undefined;
  }

  if(isDefined(entity.var_5ace757d)) {
    var_e2b4fa2b = undefined;
    var_833f593 = 2147483647;

    foreach(var_dd54fdb1 in entity.var_5ace757d) {
      if(isDefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
        continue;
      }

      if(isDefined(var_dd54fdb1.hitradius)) {
        foreach(hittag in var_dd54fdb1.hittags) {
          tagorigin = entity gettagorigin(hittag);
          distsq = distancesquared(point, tagorigin);

          if(distsq <= var_dd54fdb1.hitradius * var_dd54fdb1.hitradius && var_833f593 > distsq) {
            var_e2b4fa2b = var_dd54fdb1;
            var_833f593 = distsq;
          }
        }
      }
    }
  }

  return var_e2b4fa2b;
}

function_6bb685f0(entity, point, weakpointstate) {
  if(!isDefined(point)) {
    return undefined;
  }

  if(isDefined(entity.var_5ace757d)) {
    foreach(var_dd54fdb1 in entity.var_5ace757d) {
      if(isDefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
        continue;
      }

      if(isDefined(var_dd54fdb1.hitradius)) {
        foreach(hittag in var_dd54fdb1.hittags) {
          tagorigin = entity gettagorigin(hittag);
          distsq = distancesquared(point, tagorigin);

          if(distsq <= var_dd54fdb1.hitradius * var_dd54fdb1.hitradius) {
            return var_dd54fdb1;
          }
        }
      }
    }
  }
}

function_37e3f011(entity, bone, weakpointstate) {
  if(!isDefined(entity)) {
    return undefined;
  }

  if(isDefined(bone) && !isstring(bone)) {
    bonename = getpartname(entity, bone);
  } else {
    bonename = bone;
  }

  if(isDefined(bonename) && isDefined(entity.var_5ace757d)) {

    if(getdvarint(#"scr_weakpoint_debug", 0) > 0) {
      if(!isstring(bone)) {
        iprintlnbold("<dev string:x38>" + bonename);
      }
    }

      foreach(var_dd54fdb1 in entity.var_5ace757d) {
        if(isDefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
          continue;
        }

        foreach(hittag in var_dd54fdb1.hittags) {
          if(hittag == bonename) {
            return var_dd54fdb1;
          }
        }
      }
  }

  return undefined;
}

function_fab3ee3e(entity) {
  return entity.var_5ace757d;
}

damageweakpoint(var_dd54fdb1, damage) {
  var_dd54fdb1.health -= damage;

  if(var_dd54fdb1.health <= 0) {
    var_dd54fdb1.currstate = 3;
  }
}

function_6c64ebd3(var_dd54fdb1, state) {
  var_dd54fdb1.currstate = state;
}

function_f29756fe(var_dd54fdb1) {
  return var_dd54fdb1.currstate;
}

function_26901d33(var_dd54fdb1) {
  var_dd54fdb1.currstate = 2;

  if(isDefined(var_dd54fdb1.activebydefault) && var_dd54fdb1.activebydefault) {
    var_dd54fdb1.currstate = 1;
  }

  var_dd54fdb1.health = var_dd54fdb1.maxhealth;
}

function_6742b846(entity, var_dd54fdb1) {
  if(isDefined(entity.var_5ace757d)) {
    arrayremovevalue(entity.var_5ace757d, var_dd54fdb1, 0);
  }
}