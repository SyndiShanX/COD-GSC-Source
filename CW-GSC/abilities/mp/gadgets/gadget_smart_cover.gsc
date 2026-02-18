/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_smart_cover.gsc
*******************************************************/

#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace smart_cover;

function private autoexec __init__system__() {
  system::register(#"gadget_smart_cover", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  function_649f8cbe(&onsmartcoverplaced);
  function_a9427b5c(&function_a430cceb);
  level.var_b57c1895 = &function_9a2b3318;
}

function onsmartcoverplaced(smartcover) {
  self battlechatter::function_fc82b10(smartcover.weapon, smartcover.origin, smartcover);
  self callback::callback(#"hash_70eeb7d813f149b2", {
    #owner: self, #cover: smartcover.smartcover
  });
}

function function_a430cceb(attacker, weapon) {
  concertinawire = self;

  if(isDefined(level.figure_out_attacker)) {
    attacker = self[[level.figure_out_attacker]](attacker);
  }

  if(isDefined(attacker) && isPlayer(attacker) && concertinawire.owner !== attacker && isDefined(weapon)) {
    attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
    killstreaks::function_e729ccee(attacker, weapon);
  }

  self callback::callback(#"hash_15858698313c5f32", {
    #owner: self.owner, #cover: self
  });
}

function function_9a2b3318(origin, angles, player) {
  if(isDefined(level.smartcoversettings.bundle.var_bc78f60e)) {
    length2 = sqr(level.smartcoversettings.bundle.var_bc78f60e + level.smartcoversettings.bundle.maxwidth);

    foreach(protectedzone in level.smartcoversettings.objectivezones) {
      if(isDefined(protectedzone)) {
        dist2 = distance2dsquared(player, protectedzone.origin);

        if(dist2 < length2) {
          return false;
        }
      }
    }
  }

  return true;
}

function addprotectedzone(zone) {
  array::add(level.smartcoversettings.objectivezones, zone);
}

function removeprotectedzone(zone) {
  arrayremovevalue(level.smartcoversettings.objectivezones, zone);
}