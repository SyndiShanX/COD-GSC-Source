/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_concertina_wire.gsc
***********************************************************/

#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#namespace concertina_wire;

function private autoexec __init__system__() {
  system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(getgametypesetting(#"competitivesettings") === 1) {
    init_shared("concertina_wire_custom_settings_comp");
  } else {
    init_shared("concertina_wire_settings");
  }

  function_c5f0b9e7(&onconcertinawireplaced);
  function_d700c081(&function_806b0f85);
  level.var_cbec7a45 = 0;
  level.var_d1ae43e3 = &function_6190ae9e;
}

function onconcertinawireplaced(concertinawire) {
  self battlechatter::function_bd715920(concertinawire.weapon, undefined, concertinawire.origin, concertinawire);
}

function function_806b0f85(attacker, weapon) {
  concertinawire = self;

  if(isDefined(level.figure_out_attacker)) {
    attacker = self[[level.figure_out_attacker]](attacker);
  }

  if(isDefined(attacker) && isPlayer(attacker) && concertinawire.owner !== attacker && isDefined(weapon)) {
    attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
  }
}

function function_6190ae9e(origin, angles, player) {
  if(isDefined(level.var_87226c31.bundle.var_bc78f60e)) {
    length2 = sqr(level.var_87226c31.bundle.var_bc78f60e + level.var_87226c31.bundle.maxwidth);

    foreach(protectedzone in level.var_87226c31.objectivezones) {
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
  array::add(level.var_87226c31.objectivezones, zone);
}

function removeprotectedzone(zone) {
  arrayremovevalue(level.var_87226c31.objectivezones, zone);
}