/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\bottle.gsc
***********************************************/

#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#namespace bottle;

function precache(offhand) {
  level.g_effect["bottle_break"] = loadfx("vfx/iw9/core/bottle/vfx_bottle_explosion.vfx");
  level.offhands.bottle = spawnStruct();
  level.offhands.bottle.var_9c36b02032770c02 = undefined;

  setdvarifuninitialized(@ "debug_bottle", 0);

  registeroffhandfirefunc(offhand, &function_4b06c81b27875a14);
}

function function_4b06c81b27875a14(grenade, weapon) {
  grenade waittill("missile_stuck", stuckto, hitpart, null, hitvelocity, position, hitnormal);

  if(function_402e63d965a03b3c()) {
    sphere(position, 5, (1, 0, 0), 0, 300);
  }

  grenade delete();
  thread play_sound_in_space("weap_bottle_explo", position);
  right = undefined;

  if(is_equal(hitnormal, (0, 0, 1)) || is_equal(hitnormal, (0, 0, -1))) {
    right = (1, 0, 0);
  } else {
    right = vectorcross(hitnormal, (0, 0, 1));
  }

  playFX(level.g_effect["bottle_break"], position, right, hitnormal);
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.15, 0.35, position, 300);

  if(isDefined(stuckto) && isai(stuckto)) {
    thread function_a32bb7bb61372225(stuckto, position, hitpart, hitvelocity);
  }

  if(!isPlayer(self)) {
    level notify("bottle_impact");
    return;
  }
}

function function_a32bb7bb61372225(ai, position, hitpart, hitvelocity) {
  if(isDefined(ai.var_879faed8e3a3276f)) {
    ai thread[[ai.var_879faed8e3a3276f]](position, hitpart, hitvelocity);
  }

  waitframe();

  if(!istrue(ai.disablepain)) {
    ai notify("flashbang", position, 1, 1, level.player, "axis");
  }
}

function function_402e63d965a03b3c() {
  return getdvarint(@ "debug_bottle");
}

# /