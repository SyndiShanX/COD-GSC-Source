/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c5daa95f8fec03c.gsc
***********************************************/

#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#namespace namespace_81245006;

function private autoexec __init__system__() {
  system::register(#"hash_130a49b747d3bf82", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!sessionmodeiszombiesgame()) {
    return;
  }

  for(i = 0; i < 6; i++) {
    clientfield::register("actor", "" + # "weakpoint_state" + i, 1, 1, "int");
    clientfield::register("actor", "" + # "weakpoint_fx" + i, 1, 1, "counter");
  }
}

function initweakpoints(entity) {
  var_97e1b97d = function_768b9c03(self.aitype);

  if(!isDefined(var_97e1b97d)) {
    return;
  }

  var_5ace757d = getscriptbundle(var_97e1b97d);

  if(!isDefined(var_5ace757d) || !isDefined(var_5ace757d.weakpoints)) {
    return;
  }

  entity.var_5ace757d = [];

  foreach(var_dd54fdb1 in var_5ace757d.weakpoints) {
    var_7c4db75f = structcopy(var_dd54fdb1);
    function_6c64ebd3(var_7c4db75f, 2);

    if(!is_true(var_dd54fdb1.absolutehealth)) {
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

    var_7c4db75f.var_51e8b151 = undefined;
    var_7c4db75f.var_910e2f9b = undefined;
    var_7c4db75f.hitlocs = [];

    if(isDefined(var_dd54fdb1.var_60790e23)) {
      foreach(struct in var_dd54fdb1.var_60790e23) {
        array::add(var_7c4db75f.hitlocs, struct.hitloc);
      }
    }

    var_7c4db75f.var_60790e23 = undefined;

    if(isDefined(var_7c4db75f.var_8b732142)) {
      var_7c4db75f.var_8b732142 -= 1;
    }

    array::add(entity.var_5ace757d, var_7c4db75f);
  }

  foreach(var_dd54fdb1 in entity.var_5ace757d) {
    if(isDefined(var_dd54fdb1.var_8b732142)) {
      var_dd54fdb1.var_8b732142 = entity.var_5ace757d[var_dd54fdb1.var_8b732142];
    }
  }

  if(sessionmodeiszombiesgame() && isDefined(var_5ace757d.var_8009bee)) {
    function_bd0bd9f4(entity, var_5ace757d.var_8009bee);
  }

  foreach(var_dd54fdb1 in entity.var_5ace757d) {
    if(is_true(var_dd54fdb1.activebydefault)) {
      function_6c64ebd3(var_dd54fdb1, 1);
    }
  }
}

function function_bd0bd9f4(entity, &var_426069a) {
  clientfield_index = 0;

  foreach(var_8cc382e6 in var_426069a) {
    if(!isDefined(var_8cc382e6.var_4aa216c9) || !isDefined(var_8cc382e6.weakpoint)) {
      continue;
    }

    entity.var_5ace757d[var_8cc382e6.weakpoint - 1].var_ee8794bf = "" + # "weakpoint_state" + clientfield_index;
    entity.var_5ace757d[var_8cc382e6.weakpoint - 1].var_98634dc5 = "" + # "weakpoint_fx" + clientfield_index;
    clientfield_index++;
    assert(clientfield_index <= 6, "<dev string:x38>");
  }
}

function hasarmor(entity) {
  if(!isDefined(entity.var_5ace757d)) {
    return false;
  }

  foreach(var_dd54fdb1 in entity.var_5ace757d) {
    if(var_dd54fdb1.type === # "armor") {
      return true;
    }
  }

  return false;
}

function function_3131f5dd(entity, hitloc, weakpointstate) {
  if(!isDefined(hitloc)) {
    return undefined;
  }

  if(isDefined(entity.var_5ace757d)) {
    foreach(var_dd54fdb1 in entity.var_5ace757d) {
      if(isDefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
        continue;
      }

      if(isinarray(var_dd54fdb1.hitlocs, hitloc)) {
        return var_dd54fdb1;
      }
    }
  }
}

function function_73ab4754(entity, point, weakpointstate) {
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

          if(distsq <= sqr(var_dd54fdb1.hitradius) && var_833f593 > distsq) {
            var_e2b4fa2b = var_dd54fdb1;
            var_833f593 = distsq;
          }
        }
      }
    }
  }

  return var_e2b4fa2b;
}

function function_c6aef8e0(entity, point, weakpointstate) {
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

      if(!isDefined(var_dd54fdb1.hitradius) || var_dd54fdb1.hitradius === 0) {
        continue;
      }

      foreach(hittag in var_dd54fdb1.hittags) {
        tagorigin = entity gettagorigin(hittag);
        distsq = distancesquared(point, tagorigin);

        if(var_833f593 > distsq) {
          var_e2b4fa2b = var_dd54fdb1;
          var_833f593 = distsq;
        }
      }
    }
  }

  return var_e2b4fa2b;
}

function function_6bb685f0(entity, point, weakpointstate) {
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

          if(distsq <= sqr(var_dd54fdb1.hitradius)) {
            return var_dd54fdb1;
          }
        }
      }
    }
  }
}

function function_37e3f011(entity, bone, weakpointstate) {
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
        iprintlnbold("<dev string:x61>" + bonename);
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

function function_fab3ee3e(entity) {
  return entity.var_5ace757d;
}

function damageweakpoint(var_dd54fdb1, damage) {
  var_dd54fdb1.health -= damage;

  if(isactor(self) && isDefined(var_dd54fdb1.var_98634dc5)) {
    self clientfield::increment(var_dd54fdb1.var_98634dc5);
  }

  if(var_dd54fdb1.health <= 0) {
    function_6c64ebd3(var_dd54fdb1, 3);

    if(isDefined(var_dd54fdb1.var_8b732142) && var_dd54fdb1.var_8b732142.currstate == 2) {
      function_6c64ebd3(var_dd54fdb1.var_8b732142, 1);
    }
  }
}

function function_76e239dc(entity, attacker) {
  var_e67ec32 = function_fab3ee3e(entity);

  if(isarray(var_e67ec32)) {
    foreach(var_7092cd34 in var_e67ec32) {
      if(var_7092cd34.type === # "armor" && var_7092cd34.health > 0) {
        damageweakpoint(var_7092cd34, var_7092cd34.health);

        if(isDefined(var_7092cd34.var_f371ebb0)) {
          destructserverutils::function_8475c53a(entity, var_7092cd34.var_f371ebb0);
          entity.var_426947c4 = 1;
          entity.var_67f98db0 = 1;

          if(isDefined(level.var_887c77a4) && isPlayer(attacker)) {
            if(sessionmodeiszombiesgame()) {
              if(isPlayer(attacker)) {
                attacker stats::function_dad108fa(#"hash_2805701e53ce32a1", 1);
              }

              level scoreevents::doscoreeventcallback("scoreEventZM", {
                #attacker: attacker, #scoreevent: level.var_887c77a4
              });
            }
          }

          if(var_7092cd34.var_f371ebb0 === "body_armor") {
            callback::callback(#"hash_7d67d0e9046494fb");
          }
        }
      }
    }

    entity function_2d4173a8(0);
  }
}

function function_6c64ebd3(var_dd54fdb1, state) {
  if(!isDefined(var_dd54fdb1)) {
    return;
  }

  var_dd54fdb1.currstate = state;

  if(isactor(self) && isDefined(var_dd54fdb1.var_ee8794bf)) {
    self clientfield::set(var_dd54fdb1.var_ee8794bf, state == 1);
  }
}

function function_f29756fe(var_dd54fdb1) {
  return var_dd54fdb1.currstate;
}

function function_26901d33(var_dd54fdb1) {
  if(is_true(var_dd54fdb1.activebydefault)) {
    function_6c64ebd3(var_dd54fdb1, 1);
  } else {
    function_6c64ebd3(var_dd54fdb1, 2);
  }

  var_dd54fdb1.health = var_dd54fdb1.maxhealth;
}

function function_6742b846(entity, var_dd54fdb1) {
  if(isDefined(entity.var_5ace757d)) {
    arrayremovevalue(entity.var_5ace757d, var_dd54fdb1, 0);
  }
}