/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\arc.gsc
***********************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\damage;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\util_shared;

#namespace arc;

init_arc(weapon, var_26b2b1bb) {

  level thread update_dvars();

    if(!setup_arc(weapon, var_26b2b1bb)) {
      return;
    }

  var_26b2b1bb = level.var_8a74f7fc[weapon];

  if(!isDefined(var_26b2b1bb.var_874bd25a)) {
    var_26b2b1bb.var_874bd25a = &function_874bd25a;
  }

  function_8d134256(var_26b2b1bb);
}

update_dvars() {
  while(true) {
    wait 1;
    level.var_6d3af47 = getdvarint(#"hash_6e465f7410cc100f", 0);
  }
}

  function setup_arc(weapon, var_26b2b1bb) {
    assert(isDefined(weapon));

    if(!isDefined(level.var_8a74f7fc)) {
      level.var_8a74f7fc = [];
    }

    if(!isDefined(var_26b2b1bb)) {
      var_26b2b1bb = spawnStruct();
    }

    if(isDefined(level.var_8a74f7fc[weapon])) {
      return false;
    }

    level.var_8a74f7fc[weapon] = var_26b2b1bb;
    var_26b2b1bb.weapon = weapon;
    return true;
  }

function_8d134256(var_26b2b1bb) {
  var_26b2b1bb.range_sqr = var_26b2b1bb.range * var_26b2b1bb.range;
  var_26b2b1bb.var_1c1be14 = var_26b2b1bb.max_range * var_26b2b1bb.max_range;
  callback::add_weapon_damage(var_26b2b1bb.weapon, var_26b2b1bb.var_874bd25a);
}

function_874bd25a(eattacker, einflictor, weapon, meansofdeath, damage) {
  var_26b2b1bb = level.var_8a74f7fc[weapon];
  assert(isDefined(var_26b2b1bb));
  self thread function_9b14bec4(eattacker, einflictor, weapon, meansofdeath, damage, var_26b2b1bb);
}

function_9b14bec4(eattacker, einflictor, weapon, meansofdeath, damage, var_26b2b1bb) {
  arc_source = self;
  arc_source_origin = self.origin;
  arc_source_pos = self gettagorigin(var_26b2b1bb.fx_tag);

  if(isDefined(self.var_f5037060)) {
    self[[self.var_f5037060]](var_26b2b1bb, arc_source, 0);
  }

  if(isDefined(self.body)) {
    arc_source_origin = self.body.origin;
    arc_source_pos = self.body gettagorigin(var_26b2b1bb.fx_tag);
  }

  self find_arc_targets(var_26b2b1bb, eattacker, arc_source, arc_source_origin, 0);
}

function_bf7d5b02(arc_source_origin, max_range) {
  circle(arc_source_origin, max_range, (1, 0.5, 0), 0, 1, 2);
}

function_7a0599d(var_955a2e18, range, depth, var_94a1d56d) {
  var_227ac3be = depth / (var_94a1d56d - 1);
  circle(var_955a2e18, range, (0, 1 - var_227ac3be, var_227ac3be), 0, 1, 500);
}

  function distancecheck(var_26b2b1bb, target, arc_source_pos, arc_source_origin) {
    distancesq = distancesquared(target.origin, arc_source_pos);

    if(distancesq > var_26b2b1bb.range_sqr) {
      return false;
    }

    distancesq = distancesquared(target.origin, arc_source_origin);

    if(distancesq > var_26b2b1bb.var_1c1be14) {
      return false;
    }

    return true;
  }

function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, target, var_4d3cc1a7 = 1) {
  if(target player::is_spawn_protected()) {
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  if(isDefined(arc_source) && isDefined(arc_source.var_69ea963)) {
    if(![
        [arc_source.var_69ea963]
      ](target)) {
      return false;
    }
  }

  if(isDefined(arc_source) && target == arc_source) {
    return false;
  }

  if(eattacker == target) {
    return false;
  }

  if(isDefined(target.arc_source) && target.arc_source == arc_source) {
    return false;
  }

  if(isDefined(arc_source.var_d8d780c1) && arc_source.var_d8d780c1.size >= level.var_8a74f7fc[arc_source.arcweapon].var_755593b1) {
    return false;
  }

  if(target function_db12bbd1(arc_source)) {
    return false;
  }

  if(var_4d3cc1a7 && !distancecheck(var_26b2b1bb, target, self.origin, arc_source_origin)) {

    record3dtext("<dev string:x38>", self.origin - (0, 0, 20), (1, 0, 0), "<dev string:x47>", undefined, 0.4);

      return false;
  }

  if(!damage::friendlyfirecheck(eattacker, target)) {
    return false;
  }

  if(!target damageconetrace(self.origin + (0, 0, 10), self) && isDefined(var_26b2b1bb.var_8ce60046) && var_26b2b1bb.var_8ce60046) {
    return false;
  }

  if(isDefined(self.var_101a013c) && self.var_101a013c && isDefined(target.var_4233f7e5) && target.var_4233f7e5) {
    return false;
  }

  return true;
}

find_arc_targets(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, var_4d3cc1a7 = 1) {

  if(level.var_6d3af47) {
    function_bf7d5b02(arc_source_origin, var_26b2b1bb.max_range);
    function_7a0599d(self.origin, var_26b2b1bb.range, depth, var_26b2b1bb.depth);
  }

    delay = var_26b2b1bb.delay;

  if(!isDefined(delay)) {
    delay = 0;
  }

  allplayers = util::get_active_players();
  closesttargets = arraysort(allplayers, arc_source_origin, 1);
  validtargets = 0;

  for(i = 0; validtargets < var_26b2b1bb.var_755593b1 && i < closesttargets.size; i++) {
    target = closesttargets[i];

    if(!function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, target, var_4d3cc1a7)) {
      continue;
    }

    validtargets++;
    level thread function_30a9a6c1(var_26b2b1bb, delay, eattacker, arc_source, self, arc_source_origin, self.origin, target, target gettagorigin(var_26b2b1bb.fx_tag), depth);
  }
}

function_30a9a6c1(var_26b2b1bb, delay, eattacker, arc_source, var_9a099e60, arc_source_origin, arc_source_pos, arc_target, arc_target_pos, depth, var_4d3cc1a7 = 1) {
  if(delay) {
    wait float(delay) / 1000;

    if(!function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, arc_target, var_4d3cc1a7)) {
      return;
    }
  }

  function_41827934(arc_source, arc_target);

  if(depth < (isDefined(var_26b2b1bb.depth) ? var_26b2b1bb.depth : 0) && isDefined(arc_source)) {
    arc_target find_arc_targets(level.var_8a74f7fc[arc_source.arcweapon], arc_source.owner, arc_source, arc_source_origin, depth + 1, var_4d3cc1a7);
  }

  if(isDefined(arc_source) && isDefined(arc_source.var_16d479de)) {
    arc_source[[arc_source.var_16d479de]](arc_target);
  }

  if(isDefined(arc_source)) {
    var_ac6e1436 = 0;

    if(isDefined(arc_source.var_f5037060)) {
      var_ac6e1436 = arc_target[[arc_source.var_f5037060]](var_26b2b1bb, arc_source, depth);
    }

    arc_source.var_290ed3ab = gettime() + var_ac6e1436;
  }
}

function_db12bbd1(arc_source) {
  if(isDefined(self.var_671951da) && isDefined(arc_source)) {
    foreach(source in self.var_671951da) {
      if(isDefined(source) && source == arc_source) {
        return true;
      }
    }
  }

  return false;
}

function_41827934(arc_source, arc_target) {
  arc_target.arc_source = arc_source;

  if(!isDefined(arc_target.var_671951da)) {
    arc_target.var_671951da = [];
  }

  arc_target.var_671951da[arc_target.var_671951da.size] = arc_source;

  if(isDefined(arc_source)) {
    if(!isDefined(arc_source.var_d8d780c1)) {
      arc_source.var_d8d780c1 = [];
    }

    arc_source.var_d8d780c1[arc_source.var_d8d780c1.size] = arc_target;
  }
}

function_936e96aa(var_26b2b1bb) {
  if(isDefined(self.var_d8d780c1)) {
    foreach(target in self.var_d8d780c1) {
      if(isDefined(target) && isalive(target) && isDefined(target.arc_source) && target.arc_source == self) {
        if(isDefined(self.var_8a41c722)) {
          self[[self.var_8a41c722]](target, var_26b2b1bb);
        }
      }
    }
  }
}