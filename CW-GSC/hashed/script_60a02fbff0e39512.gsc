/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_60a02fbff0e39512.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dynent_use;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\system_shared;
#using scripts\weapons\land_mine;
#namespace namespace_f3e83343;

function private autoexec __init__system__() {
  system::register(#"hash_56764d013a0eb19c", &preinit, undefined, undefined, undefined);
}

function preinit() {
  dynents = getdynentarray("dynent_garage_button");

  foreach(dynent in dynents) {
    dynent.onuse = &function_51a020;
    dynent.ondamaged = &function_724a2fa5;
  }

  dynents = getdynentarray("dynent_door_check_for_vehicles");

  foreach(dynent in dynents) {
    dynent.onuse = &function_995a4e51;
    dynent.ondamaged = &function_67b96164;
  }

  dynents = getdynentarray("dynent_destroyable_door");

  foreach(dynent in dynents) {
    dynent.ondamaged = &function_5d409a7b;
    dynent.maxhealth = dynent.health;
  }

  doors = function_f3e164a9(#"hash_4d1fb8524fdfd254");

  if(isDefined(doors) && doors.size > 0) {
    level thread function_92f2f8cf(doors);
    level thread function_160e40a2();
  }

  level thread function_b217acf();
}

function private event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  dynent = eventstruct.ent;

  if(!isDefined(dynent.var_667629e9)) {
    return;
  }

  foreach(object in dynent.var_667629e9) {
    if(!isDefined(object)) {
      continue;
    }

    if(object.weapon.name == # "land_mine") {
      object land_mine::function_338f99f5();
      continue;
    }

    object dodamage(object.health - 1, dynent.origin);
  }
}

function function_b217acf() {
  while(true) {
    params = level waittill(#"hash_2d1093d938f2fad6");
    dynent = params.hitent;

    if(!isDefined(dynent.var_667629e9)) {
      dynent.var_667629e9 = [];
    }

    arrayremovevalue(dynent.var_667629e9, undefined);
    dynent.var_667629e9[dynent.var_667629e9.size] = params.projectile;
    waitframe(1);
  }
}

function function_160e40a2() {
  level endon(#"game_ended");
  updatepass = 0;
  cosangle = cos(20);
  var_3393f5fe = cos(50);
  var_2c51fa57 = sqr(64);

  while(true) {
    foreach(i, player in getplayers()) {
      time = gettime();

      if(i % 2 == updatepass) {
        if(!isDefined(player.var_8a022726)) {
          continue;
        }

        if(player sprintbuttonPressed() || player issprinting() || player issliding()) {
          var_42b5b0df = player getvelocity() * 0.1;
          var_40676129 = player.origin + var_42b5b0df;
          playerorigin = player.origin;
          bounds = (300, 300, 150);
          boundsorigin = player getcentroid();
          var_e86a4d9 = function_db4bc717(boundsorigin, bounds);

          foreach(dynent in var_e86a4d9) {
            if(isDefined(dynent.var_a548ec11) && dynent.var_a548ec11 > time) {
              continue;
            }

            if(dynent.script_noteworthy !== # "hash_4d1fb8524fdfd254") {
              continue;
            }

            if(abs(playerorigin[2] - dynent.origin[2]) > 36) {
              continue;
            }

            bundle = function_489009c1(dynent);
            v_offset = (isDefined(bundle.var_aa0fba03) ? bundle.var_aa0fba03 : 0, isDefined(bundle.var_f8525687) ? bundle.var_f8525687 : 0, isDefined(bundle.var_54b28eee) ? bundle.var_54b28eee : 0);
            v_offset = rotatepoint(v_offset, dynent.angles);
            var_dea242aa = dynent.origin + v_offset;
            playerdir = var_dea242aa - playerorigin;
            playerdir = vectornormalize((playerdir[0], playerdir[1], 0));
            var_f8682cca = vectordot(anglesToForward(player.angles), playerdir);
            var_772fc240 = distance2dsquared(playerorigin, var_dea242aa);
            isnear = var_772fc240 <= var_2c51fa57;

            if(!isnear && var_f8682cca <= cosangle || isnear && var_f8682cca <= var_3393f5fe) {
              continue;
            }

            var_df2e06ad = distance2dsquared(var_40676129, var_dea242aa);
            var_cdc68fb8 = distance2dsquared(playerorigin, var_dea242aa);

            if(var_df2e06ad <= sqr(75) || var_cdc68fb8 <= sqr(100)) {
              stateindex = function_ffdbe8c2(dynent);

              if(stateindex == 1 || stateindex == 2 || stateindex == 4 || stateindex == 5) {
                if(var_df2e06ad > sqr(75 * 0.5) && var_cdc68fb8 > sqr(100 * 0.5)) {
                  continue;
                }

                var_b4b3af4c = anglesToForward(dynent.angles);
                dot = vectordot(var_b4b3af4c, playerdir);

                if(dot >= 0 && (stateindex == 1 || stateindex == 4)) {
                  continue;
                } else if(dot <= 0 && (stateindex == 2 || stateindex == 5)) {
                  continue;
                }
              } else if(stateindex == 0 || stateindex == 6) {
                var_b4b3af4c = anglesToForward(dynent.angles);
                playerfwd = anglesToForward(player.angles);
                dot = abs(vectordot(var_b4b3af4c, playerfwd));

                if(dot < cos(45)) {
                  continue;
                }
              } else if(stateindex == 3) {
                continue;
              }

              var_dbfa3e4e = bulletTrace(player.origin, var_dea242aa, 0, player, 0);

              if(!isDefined(var_dbfa3e4e[# "dynent"])) {
                continue;
              }

              bundle = function_489009c1(dynent);

              if(isDefined(bundle) && isDefined(bundle.dynentstates) && isDefined(bundle.dynentstates[stateindex])) {
                overridestate = 6;

                if(stateindex == 0 || stateindex == 6) {
                  var_b4b3af4c = anglesToForward(dynent.angles);
                  dot = vectordot(var_b4b3af4c, playerdir);

                  if(dot >= 0) {
                    overridestate = 4;
                  } else {
                    overridestate = 5;
                  }
                }

                var_bb075e98 = {
                  #origin: var_dea242aa
                };
                var_a852a7dd = var_bb075e98 dynent_use::use_dynent(dynent, player, overridestate, 1, 1);
                player gestures::play_gesture("ges_t9_door_shove", undefined, 0);
                player function_bc82f900("door_shove");
                playsoundatposition("evt_door_bash", dynent.origin);
                playFX("debris/fx9_door_bash", dynent.origin, anglesToForward(dynent.angles), anglestoup(dynent.angles));
                var_a548ec11 = 1;
                dynent.var_a548ec11 = gettime() + int(var_a852a7dd * 1000) + int(var_a548ec11 * 1000);

                if(isDefined(level.var_83c46567)) {
                  [[level.var_83c46567]](dynent);
                }
              }
            }
          }
        }
      }
    }

    updatepass = (updatepass + 1) % 2;
    waitframe(1);
  }
}

function function_92f2f8cf(doors) {
  foreach(door in doors) {
    door.ondamaged = &function_c743094d;
  }
}

function function_c743094d(eventstruct) {
  dynent = eventstruct.ent;
  activator = eventstruct.attacker;

  if(is_true(eventstruct.melee) && isPlayer(activator) && isDefined(activator.var_8a022726) && activator.var_8a022726 istriggerenabled()) {
    dynent.health += eventstruct.amount;
    stateindex = function_ffdbe8c2(dynent);
    var_b4b3af4c = anglesToForward(dynent.angles);
    playerdir = activator.var_8a022726.origin - activator.origin;
    playerdir = vectornormalize((playerdir[0], playerdir[1], 0));
    dot = vectordot(var_b4b3af4c, playerdir);

    if(stateindex == 1 || stateindex == 2 || stateindex == 4 || stateindex == 5) {
      if(dot >= 0 && (stateindex == 1 || stateindex == 4)) {
        return;
      } else if(dot <= 0 && stateindex == (stateindex == 2 || stateindex == 5)) {
        return;
      }
    }

    bundle = function_489009c1(dynent);

    if(isDefined(bundle) && isDefined(bundle.dynentstates) && isDefined(bundle.dynentstates[stateindex])) {
      overridestate = 6;

      if(stateindex == 0 || stateindex == 6) {
        if(dot >= 0) {
          overridestate = 4;
        } else {
          overridestate = 5;
        }
      }

      var_a852a7dd = eventstruct.attacker.var_8a022726 dynent_use::use_dynent(dynent, eventstruct.attacker, overridestate, 1, 1);
      playsoundatposition("evt_door_bash", dynent.origin);
      playFX("debris/fx9_door_bash", dynent.origin, anglesToForward(dynent.angles), anglestoup(dynent.angles));
      dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
    }

    return;
  }

  if(isPlayer(activator) && dynent.health <= 0) {
    activator notify(#"hash_34928429a0070510", {
      #dynent: dynent
    });
  }
}

function function_67b96164(eventstruct) {
  dynent = eventstruct.ent;
  activator = eventstruct.attacker;

  if(isPlayer(activator) && dynent.health <= 0) {
    activator notify(#"hash_34928429a0070510", {
      #dynent: dynent
    });
  }
}

function function_995a4e51(activator, laststate, state) {
  if(state != 0 || laststate == state) {
    return true;
  }

  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  bounds = function_c440d28e(self.var_15d44120);
  midpoint = (bounds.mins + bounds.maxs) * 0.5;
  var_53c592d9 = midpoint - bounds.mins;
  doorcenter = self.origin + rotatepoint(midpoint, self.angles);

  box(doorcenter, var_53c592d9 * -1, var_53c592d9, self.angles, (1, 0, 1), 1, 0, 600);

  radius = max(max(midpoint[0], midpoint[1]), midpoint[2]);
  ents = getentitiesinradius(doorcenter, radius);

  foreach(ent in ents) {
    if(!isvehicle(ent)) {
      continue;
    }

    var_84c67202 = ent.origin + rotatepoint(ent getboundsmidpoint(), ent.angles);
    enthalfsize = ent getboundshalfsize();

    if(function_ecdf9b24(doorcenter, self.angles, var_53c592d9, var_84c67202, ent.angles, enthalfsize)) {
      box(var_84c67202, enthalfsize * -1, enthalfsize, ent.angles, (1, 0, 0), 1, 0, 600);

      return false;
    }
  }

  return true;
}

function function_d7b6ee00(activator, laststate, state) {
  if(laststate == state) {
    return;
  }

  if(state != 0) {
    forward = anglesToForward(self.angles);
    right = anglestoright(self.angles);
    bounds = function_c440d28e(self.var_15d44120);
    start = self.origin + (0, 0, 35);
    start -= right * (bounds.mins[1] + bounds.maxs[1]) * 0.5;

    if(state == 1) {
      start += forward * 5;
      end = start + forward * 35;
    } else {
      start -= forward * 5;
      end = start - forward * 35;
    }

    line(start, end, (1, 1, 1), 1, 1, 300);

    results = bullettracepassed(start, end, 0, activator);

    if(!results) {
      if(state == 1) {
        state = 2;
      } else if(state == 2) {
        state = 1;
      }

      setdynentstate(self, state);
      return 0;
    }
  }

  return 1;
}

function function_51a020(activator, laststate, state) {
  if(isDefined(self.target)) {
    if(laststate == state) {
      return false;
    }

    var_a9309589 = getdynent(self.target);

    if(!isDefined(var_a9309589)) {
      return false;
    }

    currentstate = function_ffdbe8c2(var_a9309589);

    if(state == 0) {
      right = anglestoright(var_a9309589.angles);
      bounds = function_c440d28e(var_a9309589.var_15d44120);
      center = var_a9309589.origin + (0, 0, 25);
      start = center + right * bounds.mins[1] * 0.85;
      end = center + right * bounds.maxs[1] * 0.85;
      results = bullettracepassed(start, end, 0, activator);

      if(!results) {
        return false;
      }

      center = var_a9309589.origin + (0, 0, 40);
      start = center + right * bounds.mins[1] * 0.85;
      end = center + right * bounds.maxs[1] * 0.85;
      results = bullettracepassed(start, end, 0, activator);

      if(!results) {
        return false;
      }
    }

    if(currentstate != state) {
      setdynentstate(var_a9309589, state);
    }
  }

  return true;
}

function private function_724a2fa5(eventstruct) {
  dynent = eventstruct.ent;

  if(isDefined(eventstruct)) {
    dynent.health += eventstruct.amount;
  }

  if(isDefined(dynent.var_a548ec11) && gettime() <= dynent.var_a548ec11) {
    return;
  }

  if(distancesquared(eventstruct.ent.origin, eventstruct.position) > sqr(15)) {
    return;
  }

  var_a852a7dd = dynent_use::use_dynent(dynent);
  dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
}

function private function_5d409a7b(eventstruct) {
  dynent = eventstruct.ent;
  state = function_ffdbe8c2(dynent);

  if(state <= 2) {
    var_6c9f448d = dynent.health / dynent.maxhealth;

    if(var_6c9f448d <= 0.5) {
      setdynentstate(dynent, state + 3);
    }
  }
}