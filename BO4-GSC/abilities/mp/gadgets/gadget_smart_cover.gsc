/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_smart_cover.gsc
*******************************************************/

#include scripts\abilities\gadgets\gadget_smart_cover;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\util;

#namespace smart_cover;

autoexec __init__system__() {
  system::register(#"smart_cover", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  function_649f8cbe(&onsmartcoverplaced);
  function_a9427b5c(&function_a430cceb);
  level.var_b57c1895 = &function_9a2b3318;
}

onsmartcoverplaced(smartcover) {
  self battlechatter::function_bd715920(smartcover.weapon, undefined, smartcover.origin, smartcover);
  self callback::callback(#"hash_70eeb7d813f149b2", {
    #owner: self, 
    #cover: smartcover.smartcover
  });
}

function_a430cceb(attacker, weapon) {
  concertinawire = self;

  if(isDefined(level.figure_out_attacker)) {
    attacker = self[[level.figure_out_attacker]](attacker);
  }

  if(isDefined(attacker) && isplayer(attacker) && concertinawire.owner !== attacker && isDefined(weapon)) {
    attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
  }

  self callback::callback(#"hash_15858698313c5f32", {
    #owner: self.owner, 
    #cover: self
  });
}

function_9a2b3318(origin, angles, player) {
  if(isDefined(level.smartcoversettings.bundle.var_bc78f60e)) {
    length2 = (level.smartcoversettings.bundle.var_bc78f60e + level.smartcoversettings.bundle.maxwidth) * (level.smartcoversettings.bundle.var_bc78f60e + level.smartcoversettings.bundle.maxwidth);

    foreach(protectedzone in level.smartcoversettings.objectivezones) {
      if(isDefined(protectedzone)) {
        dist2 = distance2dsquared(origin, protectedzone.origin);

        if(dist2 < length2) {
          return false;
        }
      }
    }
  }

  return true;
}

addprotectedzone(zone) {
  array::add(level.smartcoversettings.objectivezones, zone);
}

removeprotectedzone(zone) {
  arrayremovevalue(level.smartcoversettings.objectivezones, zone);
}